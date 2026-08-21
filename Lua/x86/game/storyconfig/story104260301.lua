return {
	Play426031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 426031001
		arg_1_1.duration_ = 14.1

		local var_1_0 = {
			zh = 8.90000000298023,
			ja = 14.1000000029802
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
				arg_1_0:Play426031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J03f"

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
				local var_4_5 = arg_1_1.bgs_.J03f

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
					if iter_4_0 ~= "J03f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

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

			local var_4_24 = "1012ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1012ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1012ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1012ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1012ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -1.05, -6.24)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1012ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1012ui_story"]
			local var_4_39 = 1.8

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1012ui_story == nil then
				arg_1_1.var_.characterEffect1012ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1012ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1012ui_story then
				arg_1_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_4_44 = 0
			local var_4_45 = 0.3

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "music"

				arg_1_1:AudioAction(var_4_46, var_4_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_48 = ""
				local var_4_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_49 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_49 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_49

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_49
						arg_1_1.bgmTxt2_.text = var_4_49
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

			local var_4_50 = 0.433333333333333
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

				if var_4_55 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_55 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_55

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_55
						arg_1_1.bgmTxt2_.text = var_4_55
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

			local var_4_56 = 0.166666666666667
			local var_4_57 = 1

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				local var_4_58 = "play"
				local var_4_59 = "effect"

				arg_1_1:AudioAction(var_4_58, var_4_59, "se_story_1311", "se_story_1311_wind", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_60 = 2.00000000298023
			local var_4_61 = 0.95

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_62 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_62:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_63 = arg_1_1:FormatText(StoryNameCfg[595].name)

				arg_1_1.leftNameTxt_.text = var_4_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_64 = arg_1_1:GetWordFromCfg(426031001)
				local var_4_65 = arg_1_1:FormatText(var_4_64.content)

				arg_1_1.text_.text = var_4_65

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_66 = 38
				local var_4_67 = utf8.len(var_4_65)
				local var_4_68 = var_4_66 <= 0 and var_4_61 or var_4_61 * (var_4_67 / var_4_66)

				if var_4_68 > 0 and var_4_61 < var_4_68 then
					arg_1_1.talkMaxDuration = var_4_68
					var_4_60 = var_4_60 + 0.3

					if var_4_68 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_60
					end
				end

				arg_1_1.text_.text = var_4_65
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031001", "story_v_out_426031.awb") ~= 0 then
					local var_4_69 = manager.audio:GetVoiceLength("story_v_out_426031", "426031001", "story_v_out_426031.awb") / 1000

					if var_4_69 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_60
					end

					if var_4_64.prefab_name ~= "" and arg_1_1.actors_[var_4_64.prefab_name] ~= nil then
						local var_4_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_64.prefab_name].transform, "story_v_out_426031", "426031001", "story_v_out_426031.awb")

						arg_1_1:RecordAudio("426031001", var_4_70)
						arg_1_1:RecordAudio("426031001", var_4_70)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_426031", "426031001", "story_v_out_426031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_426031", "426031001", "story_v_out_426031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_71 = var_4_60 + 0.3
			local var_4_72 = math.max(var_4_61, arg_1_1.talkMaxDuration)

			if var_4_71 <= arg_1_1.time_ and arg_1_1.time_ < var_4_71 + var_4_72 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_71) / var_4_72

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_71 + var_4_72 and arg_1_1.time_ < var_4_71 + var_4_72 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play426031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 426031002
		arg_9_1.duration_ = 5.47

		local var_9_0 = {
			zh = 5.466,
			ja = 5.266
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
				arg_9_0:Play426031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1012ui_story"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos1012ui_story = var_12_0.localPosition
			end

			local var_12_2 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2
				local var_12_4 = Vector3.New(0, -1.05, -6.24)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1012ui_story, var_12_4, var_12_3)

				local var_12_5 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_5.x, var_12_5.y, var_12_5.z)

				local var_12_6 = var_12_0.localEulerAngles

				var_12_6.z = 0
				var_12_6.x = 0
				var_12_0.localEulerAngles = var_12_6
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_12_7 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_7.x, var_12_7.y, var_12_7.z)

				local var_12_8 = var_12_0.localEulerAngles

				var_12_8.z = 0
				var_12_8.x = 0
				var_12_0.localEulerAngles = var_12_8
			end

			local var_12_9 = 0

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 then
				arg_9_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_12_10 = 0
			local var_12_11 = 0.725

			if var_12_10 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_12 = arg_9_1:FormatText(StoryNameCfg[595].name)

				arg_9_1.leftNameTxt_.text = var_12_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_13 = arg_9_1:GetWordFromCfg(426031002)
				local var_12_14 = arg_9_1:FormatText(var_12_13.content)

				arg_9_1.text_.text = var_12_14

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 29
				local var_12_16 = utf8.len(var_12_14)
				local var_12_17 = var_12_15 <= 0 and var_12_11 or var_12_11 * (var_12_16 / var_12_15)

				if var_12_17 > 0 and var_12_11 < var_12_17 then
					arg_9_1.talkMaxDuration = var_12_17

					if var_12_17 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_14
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031002", "story_v_out_426031.awb") ~= 0 then
					local var_12_18 = manager.audio:GetVoiceLength("story_v_out_426031", "426031002", "story_v_out_426031.awb") / 1000

					if var_12_18 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_10
					end

					if var_12_13.prefab_name ~= "" and arg_9_1.actors_[var_12_13.prefab_name] ~= nil then
						local var_12_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_13.prefab_name].transform, "story_v_out_426031", "426031002", "story_v_out_426031.awb")

						arg_9_1:RecordAudio("426031002", var_12_19)
						arg_9_1:RecordAudio("426031002", var_12_19)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_426031", "426031002", "story_v_out_426031.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_426031", "426031002", "story_v_out_426031.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_20 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_20 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_10) / var_12_20

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_10 + var_12_20 and arg_9_1.time_ < var_12_10 + var_12_20 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play426031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 426031003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play426031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1012ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1012ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, 100, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1012ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, 100, 0)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["1012ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1012ui_story == nil then
				arg_13_1.var_.characterEffect1012ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect1012ui_story and not isNil(var_16_9) then
					local var_16_13 = Mathf.Lerp(0, 0.5, var_16_12)

					arg_13_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1012ui_story.fillRatio = var_16_13
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1012ui_story then
				local var_16_14 = 0.5

				arg_13_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1012ui_story.fillRatio = var_16_14
			end

			local var_16_15 = 0
			local var_16_16 = 0.75

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_17 = arg_13_1:GetWordFromCfg(426031003)
				local var_16_18 = arg_13_1:FormatText(var_16_17.content)

				arg_13_1.text_.text = var_16_18

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_19 = 30
				local var_16_20 = utf8.len(var_16_18)
				local var_16_21 = var_16_19 <= 0 and var_16_16 or var_16_16 * (var_16_20 / var_16_19)

				if var_16_21 > 0 and var_16_16 < var_16_21 then
					arg_13_1.talkMaxDuration = var_16_21

					if var_16_21 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_21 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_18
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_22 and arg_13_1.time_ < var_16_15 + var_16_22 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play426031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 426031004
		arg_17_1.duration_ = 5.3

		local var_17_0 = {
			zh = 1.999999999999,
			ja = 5.3
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
				arg_17_0:Play426031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1012ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1012ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, -1.05, -6.24)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1012ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1012ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1012ui_story == nil then
				arg_17_1.var_.characterEffect1012ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect1012ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1012ui_story then
				arg_17_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_20_14 = 0
			local var_20_15 = 0.175

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_16 = arg_17_1:FormatText(StoryNameCfg[595].name)

				arg_17_1.leftNameTxt_.text = var_20_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_17 = arg_17_1:GetWordFromCfg(426031004)
				local var_20_18 = arg_17_1:FormatText(var_20_17.content)

				arg_17_1.text_.text = var_20_18

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_19 = 7
				local var_20_20 = utf8.len(var_20_18)
				local var_20_21 = var_20_19 <= 0 and var_20_15 or var_20_15 * (var_20_20 / var_20_19)

				if var_20_21 > 0 and var_20_15 < var_20_21 then
					arg_17_1.talkMaxDuration = var_20_21

					if var_20_21 + var_20_14 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_21 + var_20_14
					end
				end

				arg_17_1.text_.text = var_20_18
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031004", "story_v_out_426031.awb") ~= 0 then
					local var_20_22 = manager.audio:GetVoiceLength("story_v_out_426031", "426031004", "story_v_out_426031.awb") / 1000

					if var_20_22 + var_20_14 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_22 + var_20_14
					end

					if var_20_17.prefab_name ~= "" and arg_17_1.actors_[var_20_17.prefab_name] ~= nil then
						local var_20_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_17.prefab_name].transform, "story_v_out_426031", "426031004", "story_v_out_426031.awb")

						arg_17_1:RecordAudio("426031004", var_20_23)
						arg_17_1:RecordAudio("426031004", var_20_23)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_426031", "426031004", "story_v_out_426031.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_426031", "426031004", "story_v_out_426031.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_24 = math.max(var_20_15, arg_17_1.talkMaxDuration)

			if var_20_14 <= arg_17_1.time_ and arg_17_1.time_ < var_20_14 + var_20_24 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_14) / var_20_24

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_14 + var_20_24 and arg_17_1.time_ < var_20_14 + var_20_24 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play426031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 426031005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play426031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1012ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1012ui_story == nil then
				arg_21_1.var_.characterEffect1012ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1012ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1012ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1012ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1012ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 0.075

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_9 = arg_21_1:GetWordFromCfg(426031005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 3
				local var_24_12 = utf8.len(var_24_10)
				local var_24_13 = var_24_11 <= 0 and var_24_7 or var_24_7 * (var_24_12 / var_24_11)

				if var_24_13 > 0 and var_24_7 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_10
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_14 and arg_21_1.time_ < var_24_6 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play426031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 426031006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play426031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1012ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1012ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1012ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, 100, 0)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = 0
			local var_28_10 = 1.375

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_11 = arg_25_1:GetWordFromCfg(426031006)
				local var_28_12 = arg_25_1:FormatText(var_28_11.content)

				arg_25_1.text_.text = var_28_12

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 55
				local var_28_14 = utf8.len(var_28_12)
				local var_28_15 = var_28_13 <= 0 and var_28_10 or var_28_10 * (var_28_14 / var_28_13)

				if var_28_15 > 0 and var_28_10 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15

					if var_28_15 + var_28_9 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_9
					end
				end

				arg_25_1.text_.text = var_28_12
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_10, arg_25_1.talkMaxDuration)

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_9) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_9 + var_28_16 and arg_25_1.time_ < var_28_9 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play426031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 426031007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play426031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1012ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1012ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0, -1.05, -6.24)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1012ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["1012ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1012ui_story == nil then
				arg_29_1.var_.characterEffect1012ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect1012ui_story and not isNil(var_32_9) then
					arg_29_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1012ui_story then
				arg_29_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_32_13 = 0

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_2")
			end

			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_32_15 = 0
			local var_32_16 = 0.25

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_17 = arg_29_1:FormatText(StoryNameCfg[595].name)

				arg_29_1.leftNameTxt_.text = var_32_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(426031007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_20 = 10
				local var_32_21 = utf8.len(var_32_19)
				local var_32_22 = var_32_20 <= 0 and var_32_16 or var_32_16 * (var_32_21 / var_32_20)

				if var_32_22 > 0 and var_32_16 < var_32_22 then
					arg_29_1.talkMaxDuration = var_32_22

					if var_32_22 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_22 + var_32_15
					end
				end

				arg_29_1.text_.text = var_32_19
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031007", "story_v_out_426031.awb") ~= 0 then
					local var_32_23 = manager.audio:GetVoiceLength("story_v_out_426031", "426031007", "story_v_out_426031.awb") / 1000

					if var_32_23 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_15
					end

					if var_32_18.prefab_name ~= "" and arg_29_1.actors_[var_32_18.prefab_name] ~= nil then
						local var_32_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_18.prefab_name].transform, "story_v_out_426031", "426031007", "story_v_out_426031.awb")

						arg_29_1:RecordAudio("426031007", var_32_24)
						arg_29_1:RecordAudio("426031007", var_32_24)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_426031", "426031007", "story_v_out_426031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_426031", "426031007", "story_v_out_426031.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_25 = math.max(var_32_16, arg_29_1.talkMaxDuration)

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_25 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_15) / var_32_25

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_15 + var_32_25 and arg_29_1.time_ < var_32_15 + var_32_25 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play426031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 426031008
		arg_33_1.duration_ = 6.2

		local var_33_0 = {
			zh = 3.866,
			ja = 6.2
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
				arg_33_0:Play426031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1012ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1012ui_story == nil then
				arg_33_1.var_.characterEffect1012ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1012ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1012ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1012ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1012ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.475

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[1110].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_9 = arg_33_1:GetWordFromCfg(426031008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031008", "story_v_out_426031.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_426031", "426031008", "story_v_out_426031.awb") / 1000

					if var_36_14 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_6
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_out_426031", "426031008", "story_v_out_426031.awb")

						arg_33_1:RecordAudio("426031008", var_36_15)
						arg_33_1:RecordAudio("426031008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_426031", "426031008", "story_v_out_426031.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_426031", "426031008", "story_v_out_426031.awb")
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
	Play426031009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 426031009
		arg_37_1.duration_ = 8.83

		local var_37_0 = {
			zh = 4.233,
			ja = 8.833
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
				arg_37_0:Play426031010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1012ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1012ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, -1.05, -6.24)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1012ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["1012ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1012ui_story == nil then
				arg_37_1.var_.characterEffect1012ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect1012ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1012ui_story then
				arg_37_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_40_15 = 0
			local var_40_16 = 0.5

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[595].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(426031009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 20
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_16 or var_40_16 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_16 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031009", "story_v_out_426031.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_426031", "426031009", "story_v_out_426031.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_426031", "426031009", "story_v_out_426031.awb")

						arg_37_1:RecordAudio("426031009", var_40_24)
						arg_37_1:RecordAudio("426031009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_426031", "426031009", "story_v_out_426031.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_426031", "426031009", "story_v_out_426031.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_25 and arg_37_1.time_ < var_40_15 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play426031010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 426031010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play426031011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1012ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1012ui_story == nil then
				arg_41_1.var_.characterEffect1012ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1012ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1012ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1012ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1012ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.55

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

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(426031010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 22
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
	Play426031011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 426031011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play426031012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1012ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1012ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, 100, 0)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1012ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, 100, 0)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = 0
			local var_48_10 = 1.025

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_11 = arg_45_1:GetWordFromCfg(426031011)
				local var_48_12 = arg_45_1:FormatText(var_48_11.content)

				arg_45_1.text_.text = var_48_12

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 41
				local var_48_14 = utf8.len(var_48_12)
				local var_48_15 = var_48_13 <= 0 and var_48_10 or var_48_10 * (var_48_14 / var_48_13)

				if var_48_15 > 0 and var_48_10 < var_48_15 then
					arg_45_1.talkMaxDuration = var_48_15

					if var_48_15 + var_48_9 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_9
					end
				end

				arg_45_1.text_.text = var_48_12
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_10, arg_45_1.talkMaxDuration)

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_9) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_9 + var_48_16 and arg_45_1.time_ < var_48_9 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play426031012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 426031012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play426031013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.4

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[7].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(426031012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 16
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_8 and arg_49_1.time_ < var_52_0 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play426031013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 426031013
		arg_53_1.duration_ = 8.43

		local var_53_0 = {
			zh = 5.9,
			ja = 8.433
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
				arg_53_0:Play426031014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1012ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1012ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, -1.05, -6.24)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1012ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["1012ui_story"]
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1012ui_story == nil then
				arg_53_1.var_.characterEffect1012ui_story = var_56_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_11 = 0.200000002980232

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 and not isNil(var_56_9) then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11

				if arg_53_1.var_.characterEffect1012ui_story and not isNil(var_56_9) then
					arg_53_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1012ui_story then
				arg_53_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_56_13 = 0

			if var_56_13 < arg_53_1.time_ and arg_53_1.time_ <= var_56_13 + arg_56_0 then
				arg_53_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_56_14 = 0
			local var_56_15 = 0.825

			if var_56_14 < arg_53_1.time_ and arg_53_1.time_ <= var_56_14 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_16 = arg_53_1:FormatText(StoryNameCfg[595].name)

				arg_53_1.leftNameTxt_.text = var_56_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_17 = arg_53_1:GetWordFromCfg(426031013)
				local var_56_18 = arg_53_1:FormatText(var_56_17.content)

				arg_53_1.text_.text = var_56_18

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_19 = 33
				local var_56_20 = utf8.len(var_56_18)
				local var_56_21 = var_56_19 <= 0 and var_56_15 or var_56_15 * (var_56_20 / var_56_19)

				if var_56_21 > 0 and var_56_15 < var_56_21 then
					arg_53_1.talkMaxDuration = var_56_21

					if var_56_21 + var_56_14 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_21 + var_56_14
					end
				end

				arg_53_1.text_.text = var_56_18
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031013", "story_v_out_426031.awb") ~= 0 then
					local var_56_22 = manager.audio:GetVoiceLength("story_v_out_426031", "426031013", "story_v_out_426031.awb") / 1000

					if var_56_22 + var_56_14 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_22 + var_56_14
					end

					if var_56_17.prefab_name ~= "" and arg_53_1.actors_[var_56_17.prefab_name] ~= nil then
						local var_56_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_17.prefab_name].transform, "story_v_out_426031", "426031013", "story_v_out_426031.awb")

						arg_53_1:RecordAudio("426031013", var_56_23)
						arg_53_1:RecordAudio("426031013", var_56_23)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_426031", "426031013", "story_v_out_426031.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_426031", "426031013", "story_v_out_426031.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_24 = math.max(var_56_15, arg_53_1.talkMaxDuration)

			if var_56_14 <= arg_53_1.time_ and arg_53_1.time_ < var_56_14 + var_56_24 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_14) / var_56_24

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_14 + var_56_24 and arg_53_1.time_ < var_56_14 + var_56_24 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play426031014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 426031014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play426031015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1012ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1012ui_story == nil then
				arg_57_1.var_.characterEffect1012ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1012ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1012ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1012ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1012ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 0.65

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_8 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_9 = arg_57_1:GetWordFromCfg(426031014)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 26
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
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play426031015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 426031015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play426031016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1012ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1012ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, 100, 0)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1012ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, 100, 0)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = 0.034000001847744
			local var_64_10 = 1

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 then
				local var_64_11 = "play"
				local var_64_12 = "effect"

				arg_61_1:AudioAction(var_64_11, var_64_12, "se_story_141", "se_story_141_foley_plastic", "")
			end

			local var_64_13 = 0
			local var_64_14 = 0.7

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_15 = arg_61_1:GetWordFromCfg(426031015)
				local var_64_16 = arg_61_1:FormatText(var_64_15.content)

				arg_61_1.text_.text = var_64_16

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_17 = 28
				local var_64_18 = utf8.len(var_64_16)
				local var_64_19 = var_64_17 <= 0 and var_64_14 or var_64_14 * (var_64_18 / var_64_17)

				if var_64_19 > 0 and var_64_14 < var_64_19 then
					arg_61_1.talkMaxDuration = var_64_19

					if var_64_19 + var_64_13 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_13
					end
				end

				arg_61_1.text_.text = var_64_16
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_20 = math.max(var_64_14, arg_61_1.talkMaxDuration)

			if var_64_13 <= arg_61_1.time_ and arg_61_1.time_ < var_64_13 + var_64_20 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_13) / var_64_20

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_13 + var_64_20 and arg_61_1.time_ < var_64_13 + var_64_20 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play426031016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 426031016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play426031017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.175

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(426031016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 7
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
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_8 and arg_65_1.time_ < var_68_0 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play426031017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 426031017
		arg_69_1.duration_ = 9.13

		local var_69_0 = {
			zh = 6.1,
			ja = 9.133
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
				arg_69_0:Play426031018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1012ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1012ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0, -1.05, -6.24)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1012ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["1012ui_story"]
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1012ui_story == nil then
				arg_69_1.var_.characterEffect1012ui_story = var_72_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 and not isNil(var_72_9) then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11

				if arg_69_1.var_.characterEffect1012ui_story and not isNil(var_72_9) then
					arg_69_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1012ui_story then
				arg_69_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_72_13 = 0

			if var_72_13 < arg_69_1.time_ and arg_69_1.time_ <= var_72_13 + arg_72_0 then
				arg_69_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_72_14 = 0
			local var_72_15 = 0.725

			if var_72_14 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_16 = arg_69_1:FormatText(StoryNameCfg[595].name)

				arg_69_1.leftNameTxt_.text = var_72_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_17 = arg_69_1:GetWordFromCfg(426031017)
				local var_72_18 = arg_69_1:FormatText(var_72_17.content)

				arg_69_1.text_.text = var_72_18

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_19 = 29
				local var_72_20 = utf8.len(var_72_18)
				local var_72_21 = var_72_19 <= 0 and var_72_15 or var_72_15 * (var_72_20 / var_72_19)

				if var_72_21 > 0 and var_72_15 < var_72_21 then
					arg_69_1.talkMaxDuration = var_72_21

					if var_72_21 + var_72_14 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_21 + var_72_14
					end
				end

				arg_69_1.text_.text = var_72_18
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031017", "story_v_out_426031.awb") ~= 0 then
					local var_72_22 = manager.audio:GetVoiceLength("story_v_out_426031", "426031017", "story_v_out_426031.awb") / 1000

					if var_72_22 + var_72_14 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_22 + var_72_14
					end

					if var_72_17.prefab_name ~= "" and arg_69_1.actors_[var_72_17.prefab_name] ~= nil then
						local var_72_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_17.prefab_name].transform, "story_v_out_426031", "426031017", "story_v_out_426031.awb")

						arg_69_1:RecordAudio("426031017", var_72_23)
						arg_69_1:RecordAudio("426031017", var_72_23)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_426031", "426031017", "story_v_out_426031.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_426031", "426031017", "story_v_out_426031.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_24 = math.max(var_72_15, arg_69_1.talkMaxDuration)

			if var_72_14 <= arg_69_1.time_ and arg_69_1.time_ < var_72_14 + var_72_24 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_14) / var_72_24

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_14 + var_72_24 and arg_69_1.time_ < var_72_14 + var_72_24 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play426031018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 426031018
		arg_73_1.duration_ = 11.3

		local var_73_0 = {
			zh = 9.033,
			ja = 11.3
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
				arg_73_0:Play426031019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1012ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1012ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0, -1.05, -6.24)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1012ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 then
				arg_73_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 then
				arg_73_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_76_11 = 0
			local var_76_12 = 1.05

			if var_76_11 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_13 = arg_73_1:FormatText(StoryNameCfg[595].name)

				arg_73_1.leftNameTxt_.text = var_76_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_14 = arg_73_1:GetWordFromCfg(426031018)
				local var_76_15 = arg_73_1:FormatText(var_76_14.content)

				arg_73_1.text_.text = var_76_15

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_16 = 42
				local var_76_17 = utf8.len(var_76_15)
				local var_76_18 = var_76_16 <= 0 and var_76_12 or var_76_12 * (var_76_17 / var_76_16)

				if var_76_18 > 0 and var_76_12 < var_76_18 then
					arg_73_1.talkMaxDuration = var_76_18

					if var_76_18 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_18 + var_76_11
					end
				end

				arg_73_1.text_.text = var_76_15
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031018", "story_v_out_426031.awb") ~= 0 then
					local var_76_19 = manager.audio:GetVoiceLength("story_v_out_426031", "426031018", "story_v_out_426031.awb") / 1000

					if var_76_19 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_11
					end

					if var_76_14.prefab_name ~= "" and arg_73_1.actors_[var_76_14.prefab_name] ~= nil then
						local var_76_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_14.prefab_name].transform, "story_v_out_426031", "426031018", "story_v_out_426031.awb")

						arg_73_1:RecordAudio("426031018", var_76_20)
						arg_73_1:RecordAudio("426031018", var_76_20)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_426031", "426031018", "story_v_out_426031.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_426031", "426031018", "story_v_out_426031.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_21 = math.max(var_76_12, arg_73_1.talkMaxDuration)

			if var_76_11 <= arg_73_1.time_ and arg_73_1.time_ < var_76_11 + var_76_21 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_11) / var_76_21

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_11 + var_76_21 and arg_73_1.time_ < var_76_11 + var_76_21 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play426031019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 426031019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play426031020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1012ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1012ui_story == nil then
				arg_77_1.var_.characterEffect1012ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1012ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1012ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1012ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1012ui_story.fillRatio = var_80_5
			end

			local var_80_6 = 0
			local var_80_7 = 0.3

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_8 = arg_77_1:FormatText(StoryNameCfg[7].name)

				arg_77_1.leftNameTxt_.text = var_80_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_9 = arg_77_1:GetWordFromCfg(426031019)
				local var_80_10 = arg_77_1:FormatText(var_80_9.content)

				arg_77_1.text_.text = var_80_10

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 12
				local var_80_12 = utf8.len(var_80_10)
				local var_80_13 = var_80_11 <= 0 and var_80_7 or var_80_7 * (var_80_12 / var_80_11)

				if var_80_13 > 0 and var_80_7 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_10
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_14 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_14

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_14 and arg_77_1.time_ < var_80_6 + var_80_14 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play426031020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 426031020
		arg_81_1.duration_ = 6.4

		local var_81_0 = {
			zh = 5.566,
			ja = 6.4
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
				arg_81_0:Play426031021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1012ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1012ui_story == nil then
				arg_81_1.var_.characterEffect1012ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1012ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1012ui_story then
				arg_81_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_84_4 = 0
			local var_84_5 = 0.6

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_6 = arg_81_1:FormatText(StoryNameCfg[595].name)

				arg_81_1.leftNameTxt_.text = var_84_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_7 = arg_81_1:GetWordFromCfg(426031020)
				local var_84_8 = arg_81_1:FormatText(var_84_7.content)

				arg_81_1.text_.text = var_84_8

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 24
				local var_84_10 = utf8.len(var_84_8)
				local var_84_11 = var_84_9 <= 0 and var_84_5 or var_84_5 * (var_84_10 / var_84_9)

				if var_84_11 > 0 and var_84_5 < var_84_11 then
					arg_81_1.talkMaxDuration = var_84_11

					if var_84_11 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_8
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031020", "story_v_out_426031.awb") ~= 0 then
					local var_84_12 = manager.audio:GetVoiceLength("story_v_out_426031", "426031020", "story_v_out_426031.awb") / 1000

					if var_84_12 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_4
					end

					if var_84_7.prefab_name ~= "" and arg_81_1.actors_[var_84_7.prefab_name] ~= nil then
						local var_84_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_7.prefab_name].transform, "story_v_out_426031", "426031020", "story_v_out_426031.awb")

						arg_81_1:RecordAudio("426031020", var_84_13)
						arg_81_1:RecordAudio("426031020", var_84_13)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_426031", "426031020", "story_v_out_426031.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_426031", "426031020", "story_v_out_426031.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_14 and arg_81_1.time_ < var_84_4 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play426031021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 426031021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play426031022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1012ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1012ui_story == nil then
				arg_85_1.var_.characterEffect1012ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1012ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1012ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1012ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1012ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.125

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

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(426031021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 5
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
	Play426031022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 426031022
		arg_89_1.duration_ = 5.2

		local var_89_0 = {
			zh = 4.066,
			ja = 5.2
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
				arg_89_0:Play426031023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1012ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1012ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, -1.05, -6.24)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1012ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["1012ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1012ui_story == nil then
				arg_89_1.var_.characterEffect1012ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect1012ui_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1012ui_story then
				arg_89_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_92_13 = 0

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_2")
			end

			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_92_15 = 0
			local var_92_16 = 0.4

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_17 = arg_89_1:FormatText(StoryNameCfg[595].name)

				arg_89_1.leftNameTxt_.text = var_92_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_18 = arg_89_1:GetWordFromCfg(426031022)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031022", "story_v_out_426031.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_out_426031", "426031022", "story_v_out_426031.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_out_426031", "426031022", "story_v_out_426031.awb")

						arg_89_1:RecordAudio("426031022", var_92_24)
						arg_89_1:RecordAudio("426031022", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_426031", "426031022", "story_v_out_426031.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_426031", "426031022", "story_v_out_426031.awb")
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
				actorName = "1012ui_story",
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
	Play426031023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 426031023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play426031024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1012ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1012ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, 100, 0)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1012ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, 100, 0)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1012ui_story"]
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1012ui_story == nil then
				arg_93_1.var_.characterEffect1012ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect1012ui_story and not isNil(var_96_9) then
					local var_96_13 = Mathf.Lerp(0, 0.5, var_96_12)

					arg_93_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1012ui_story.fillRatio = var_96_13
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1012ui_story then
				local var_96_14 = 0.5

				arg_93_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1012ui_story.fillRatio = var_96_14
			end

			local var_96_15 = 0
			local var_96_16 = 0.875

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_17 = arg_93_1:GetWordFromCfg(426031023)
				local var_96_18 = arg_93_1:FormatText(var_96_17.content)

				arg_93_1.text_.text = var_96_18

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_19 = 35
				local var_96_20 = utf8.len(var_96_18)
				local var_96_21 = var_96_19 <= 0 and var_96_16 or var_96_16 * (var_96_20 / var_96_19)

				if var_96_21 > 0 and var_96_16 < var_96_21 then
					arg_93_1.talkMaxDuration = var_96_21

					if var_96_21 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_21 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_18
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_22 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_22 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_22

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_22 and arg_93_1.time_ < var_96_15 + var_96_22 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play426031024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 426031024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play426031025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.85

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

				local var_100_2 = arg_97_1:GetWordFromCfg(426031024)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 34
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
	Play426031025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 426031025
		arg_101_1.duration_ = 3.23

		local var_101_0 = {
			zh = 1.999999999999,
			ja = 3.233
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
				arg_101_0:Play426031026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1012ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1012ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, -1.05, -6.24)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1012ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1012ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1012ui_story == nil then
				arg_101_1.var_.characterEffect1012ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect1012ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1012ui_story then
				arg_101_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_104_14 = 0
			local var_104_15 = 0.2

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_16 = arg_101_1:FormatText(StoryNameCfg[595].name)

				arg_101_1.leftNameTxt_.text = var_104_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_17 = arg_101_1:GetWordFromCfg(426031025)
				local var_104_18 = arg_101_1:FormatText(var_104_17.content)

				arg_101_1.text_.text = var_104_18

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_19 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031025", "story_v_out_426031.awb") ~= 0 then
					local var_104_22 = manager.audio:GetVoiceLength("story_v_out_426031", "426031025", "story_v_out_426031.awb") / 1000

					if var_104_22 + var_104_14 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_22 + var_104_14
					end

					if var_104_17.prefab_name ~= "" and arg_101_1.actors_[var_104_17.prefab_name] ~= nil then
						local var_104_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_17.prefab_name].transform, "story_v_out_426031", "426031025", "story_v_out_426031.awb")

						arg_101_1:RecordAudio("426031025", var_104_23)
						arg_101_1:RecordAudio("426031025", var_104_23)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_426031", "426031025", "story_v_out_426031.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_426031", "426031025", "story_v_out_426031.awb")
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
				actorName = "1012ui_story",
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
	Play426031026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 426031026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play426031027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1012ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1012ui_story == nil then
				arg_105_1.var_.characterEffect1012ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1012ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1012ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1012ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1012ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 0.475

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_8 = arg_105_1:FormatText(StoryNameCfg[7].name)

				arg_105_1.leftNameTxt_.text = var_108_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_9 = arg_105_1:GetWordFromCfg(426031026)
				local var_108_10 = arg_105_1:FormatText(var_108_9.content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 19
				local var_108_12 = utf8.len(var_108_10)
				local var_108_13 = var_108_11 <= 0 and var_108_7 or var_108_7 * (var_108_12 / var_108_11)

				if var_108_13 > 0 and var_108_7 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_14 and arg_105_1.time_ < var_108_6 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play426031027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 426031027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play426031028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1012ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1012ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, 100, 0)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1012ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, 100, 0)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = 0
			local var_112_10 = 0.95

			if var_112_9 < arg_109_1.time_ and arg_109_1.time_ <= var_112_9 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_11 = arg_109_1:GetWordFromCfg(426031027)
				local var_112_12 = arg_109_1:FormatText(var_112_11.content)

				arg_109_1.text_.text = var_112_12

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_13 = 38
				local var_112_14 = utf8.len(var_112_12)
				local var_112_15 = var_112_13 <= 0 and var_112_10 or var_112_10 * (var_112_14 / var_112_13)

				if var_112_15 > 0 and var_112_10 < var_112_15 then
					arg_109_1.talkMaxDuration = var_112_15

					if var_112_15 + var_112_9 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_15 + var_112_9
					end
				end

				arg_109_1.text_.text = var_112_12
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_10, arg_109_1.talkMaxDuration)

			if var_112_9 <= arg_109_1.time_ and arg_109_1.time_ < var_112_9 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_9) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_9 + var_112_16 and arg_109_1.time_ < var_112_9 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play426031028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 426031028
		arg_113_1.duration_ = 7.03

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play426031029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = "J03g"

			if arg_113_1.bgs_[var_116_0] == nil then
				local var_116_1 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_116_0)
				var_116_1.name = var_116_0
				var_116_1.transform.parent = arg_113_1.stage_.transform
				var_116_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_[var_116_0] = var_116_1
			end

			local var_116_2 = 0.866666666666667

			if var_116_2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				local var_116_3 = manager.ui.mainCamera.transform.localPosition
				local var_116_4 = Vector3.New(0, 0, 10) + Vector3.New(var_116_3.x, var_116_3.y, 0)
				local var_116_5 = arg_113_1.bgs_.J03g

				var_116_5.transform.localPosition = var_116_4
				var_116_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_6 = var_116_5:GetComponent("SpriteRenderer")

				if var_116_6 and var_116_6.sprite then
					local var_116_7 = (var_116_5.transform.localPosition - var_116_3).z
					local var_116_8 = manager.ui.mainCameraCom_
					local var_116_9 = 2 * var_116_7 * Mathf.Tan(var_116_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_116_10 = var_116_9 * var_116_8.aspect
					local var_116_11 = var_116_6.sprite.bounds.size.x
					local var_116_12 = var_116_6.sprite.bounds.size.y
					local var_116_13 = var_116_10 / var_116_11
					local var_116_14 = var_116_9 / var_116_12
					local var_116_15 = var_116_14 < var_116_13 and var_116_13 or var_116_14

					var_116_5.transform.localScale = Vector3.New(var_116_15, var_116_15, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "J03g" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_16 = 1.5

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			local var_116_17 = 0.533333333333333

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end

			local var_116_18 = manager.ui.mainCamera.transform
			local var_116_19 = 0

			if var_116_19 < arg_113_1.time_ and arg_113_1.time_ <= var_116_19 + arg_116_0 then
				local var_116_20 = arg_113_1.var_.effectzhuanchangshanshang1
				local var_116_21
				local var_116_22 = var_116_18

				if not var_116_20 then
					var_116_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_116_22)
					var_116_20.name = "zhuanchangshanshang1"
					arg_113_1.var_.effectzhuanchangshanshang1 = var_116_20
				else
					var_116_20.transform:SetParent(var_116_22)
				end

				var_116_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_116_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_23 = 2.03333333333333
			local var_116_24 = 0.375

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_25 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_25:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_26 = arg_113_1:FormatText(StoryNameCfg[7].name)

				arg_113_1.leftNameTxt_.text = var_116_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_27 = arg_113_1:GetWordFromCfg(426031028)
				local var_116_28 = arg_113_1:FormatText(var_116_27.content)

				arg_113_1.text_.text = var_116_28

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_29 = 15
				local var_116_30 = utf8.len(var_116_28)
				local var_116_31 = var_116_29 <= 0 and var_116_24 or var_116_24 * (var_116_30 / var_116_29)

				if var_116_31 > 0 and var_116_24 < var_116_31 then
					arg_113_1.talkMaxDuration = var_116_31
					var_116_23 = var_116_23 + 0.3

					if var_116_31 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_31 + var_116_23
					end
				end

				arg_113_1.text_.text = var_116_28
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_32 = var_116_23 + 0.3
			local var_116_33 = math.max(var_116_24, arg_113_1.talkMaxDuration)

			if var_116_32 <= arg_113_1.time_ and arg_113_1.time_ < var_116_32 + var_116_33 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_32) / var_116_33

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_32 + var_116_33 and arg_113_1.time_ < var_116_32 + var_116_33 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play426031029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 426031029
		arg_119_1.duration_ = 4.17

		local var_119_0 = {
			zh = 4.166,
			ja = 3.666
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
				arg_119_0:Play426031030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = "1054ui_story"

			if arg_119_1.actors_[var_122_0] == nil then
				local var_122_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_122_1) then
					local var_122_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_119_1.stage_.transform)

					var_122_2.name = var_122_0
					var_122_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_119_1.actors_[var_122_0] = var_122_2

					local var_122_3 = var_122_2:GetComponentInChildren(typeof(CharacterEffect))

					var_122_3.enabled = true

					local var_122_4 = GameObjectTools.GetOrAddComponent(var_122_2, typeof(DynamicBoneHelper))

					if var_122_4 then
						var_122_4:EnableDynamicBone(false)
					end

					arg_119_1:ShowWeapon(var_122_3.transform, false)

					arg_119_1.var_[var_122_0 .. "Animator"] = var_122_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_119_1.var_[var_122_0 .. "Animator"].applyRootMotion = true
					arg_119_1.var_[var_122_0 .. "LipSync"] = var_122_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_122_5 = arg_119_1.actors_["1054ui_story"].transform
			local var_122_6 = 0

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.var_.moveOldPos1054ui_story = var_122_5.localPosition

				local var_122_7 = GameObjectTools.GetOrAddComponent(var_122_5.gameObject, typeof(DynamicBoneHelper))

				if var_122_7 then
					var_122_7:EnableDynamicBone(false)
				end
			end

			local var_122_8 = 0.001

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_8 then
				local var_122_9 = (arg_119_1.time_ - var_122_6) / var_122_8
				local var_122_10 = Vector3.New(-0.7, -0.985, -6)

				var_122_5.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1054ui_story, var_122_10, var_122_9)

				local var_122_11 = manager.ui.mainCamera.transform.position - var_122_5.position

				var_122_5.forward = Vector3.New(var_122_11.x, var_122_11.y, var_122_11.z)

				local var_122_12 = var_122_5.localEulerAngles

				var_122_12.z = 0
				var_122_12.x = 0
				var_122_5.localEulerAngles = var_122_12
			end

			if arg_119_1.time_ >= var_122_6 + var_122_8 and arg_119_1.time_ < var_122_6 + var_122_8 + arg_122_0 then
				var_122_5.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_122_13 = manager.ui.mainCamera.transform.position - var_122_5.position

				var_122_5.forward = Vector3.New(var_122_13.x, var_122_13.y, var_122_13.z)

				local var_122_14 = var_122_5.localEulerAngles

				var_122_14.z = 0
				var_122_14.x = 0
				var_122_5.localEulerAngles = var_122_14

				local var_122_15 = GameObjectTools.GetOrAddComponent(var_122_5.gameObject, typeof(DynamicBoneHelper))

				if var_122_15 then
					var_122_15:EnableDynamicBone(true)
				end
			end

			local var_122_16 = arg_119_1.actors_["1054ui_story"]
			local var_122_17 = 0

			if var_122_17 < arg_119_1.time_ and arg_119_1.time_ <= var_122_17 + arg_122_0 and not isNil(var_122_16) and arg_119_1.var_.characterEffect1054ui_story == nil then
				arg_119_1.var_.characterEffect1054ui_story = var_122_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_18 = 0.200000002980232

			if var_122_17 <= arg_119_1.time_ and arg_119_1.time_ < var_122_17 + var_122_18 and not isNil(var_122_16) then
				local var_122_19 = (arg_119_1.time_ - var_122_17) / var_122_18

				if arg_119_1.var_.characterEffect1054ui_story and not isNil(var_122_16) then
					arg_119_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_17 + var_122_18 and arg_119_1.time_ < var_122_17 + var_122_18 + arg_122_0 and not isNil(var_122_16) and arg_119_1.var_.characterEffect1054ui_story then
				arg_119_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_122_20 = 0

			if var_122_20 < arg_119_1.time_ and arg_119_1.time_ <= var_122_20 + arg_122_0 then
				arg_119_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_122_21 = 0

			if var_122_21 < arg_119_1.time_ and arg_119_1.time_ <= var_122_21 + arg_122_0 then
				arg_119_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_122_22 = 0
			local var_122_23 = 0.325

			if var_122_22 < arg_119_1.time_ and arg_119_1.time_ <= var_122_22 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_24 = arg_119_1:FormatText(StoryNameCfg[1487].name)

				arg_119_1.leftNameTxt_.text = var_122_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_25 = arg_119_1:GetWordFromCfg(426031029)
				local var_122_26 = arg_119_1:FormatText(var_122_25.content)

				arg_119_1.text_.text = var_122_26

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_27 = 13
				local var_122_28 = utf8.len(var_122_26)
				local var_122_29 = var_122_27 <= 0 and var_122_23 or var_122_23 * (var_122_28 / var_122_27)

				if var_122_29 > 0 and var_122_23 < var_122_29 then
					arg_119_1.talkMaxDuration = var_122_29

					if var_122_29 + var_122_22 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_29 + var_122_22
					end
				end

				arg_119_1.text_.text = var_122_26
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031029", "story_v_out_426031.awb") ~= 0 then
					local var_122_30 = manager.audio:GetVoiceLength("story_v_out_426031", "426031029", "story_v_out_426031.awb") / 1000

					if var_122_30 + var_122_22 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_30 + var_122_22
					end

					if var_122_25.prefab_name ~= "" and arg_119_1.actors_[var_122_25.prefab_name] ~= nil then
						local var_122_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_25.prefab_name].transform, "story_v_out_426031", "426031029", "story_v_out_426031.awb")

						arg_119_1:RecordAudio("426031029", var_122_31)
						arg_119_1:RecordAudio("426031029", var_122_31)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_426031", "426031029", "story_v_out_426031.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_426031", "426031029", "story_v_out_426031.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_32 = math.max(var_122_23, arg_119_1.talkMaxDuration)

			if var_122_22 <= arg_119_1.time_ and arg_119_1.time_ < var_122_22 + var_122_32 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_22) / var_122_32

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_22 + var_122_32 and arg_119_1.time_ < var_122_22 + var_122_32 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
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

		arg_119_1:InitPlayNodeList()
	end,
	Play426031030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 426031030
		arg_123_1.duration_ = 9.8

		local var_123_0 = {
			zh = 4.733,
			ja = 9.8
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
				arg_123_0:Play426031031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = "6148ui_story"

			if arg_123_1.actors_[var_126_0] == nil then
				local var_126_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_126_1) then
					local var_126_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_123_1.stage_.transform)

					var_126_2.name = var_126_0
					var_126_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_123_1.actors_[var_126_0] = var_126_2

					local var_126_3 = var_126_2:GetComponentInChildren(typeof(CharacterEffect))

					var_126_3.enabled = true

					local var_126_4 = GameObjectTools.GetOrAddComponent(var_126_2, typeof(DynamicBoneHelper))

					if var_126_4 then
						var_126_4:EnableDynamicBone(false)
					end

					arg_123_1:ShowWeapon(var_126_3.transform, false)

					arg_123_1.var_[var_126_0 .. "Animator"] = var_126_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_123_1.var_[var_126_0 .. "Animator"].applyRootMotion = true
					arg_123_1.var_[var_126_0 .. "LipSync"] = var_126_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_126_5 = arg_123_1.actors_["6148ui_story"].transform
			local var_126_6 = 0

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.var_.moveOldPos6148ui_story = var_126_5.localPosition

				local var_126_7 = GameObjectTools.GetOrAddComponent(var_126_5.gameObject, typeof(DynamicBoneHelper))

				if var_126_7 then
					var_126_7:EnableDynamicBone(false)
				end
			end

			local var_126_8 = 0.001

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_8 then
				local var_126_9 = (arg_123_1.time_ - var_126_6) / var_126_8
				local var_126_10 = Vector3.New(0.7, -0.985, -6)

				var_126_5.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos6148ui_story, var_126_10, var_126_9)

				local var_126_11 = manager.ui.mainCamera.transform.position - var_126_5.position

				var_126_5.forward = Vector3.New(var_126_11.x, var_126_11.y, var_126_11.z)

				local var_126_12 = var_126_5.localEulerAngles

				var_126_12.z = 0
				var_126_12.x = 0
				var_126_5.localEulerAngles = var_126_12
			end

			if arg_123_1.time_ >= var_126_6 + var_126_8 and arg_123_1.time_ < var_126_6 + var_126_8 + arg_126_0 then
				var_126_5.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_126_13 = manager.ui.mainCamera.transform.position - var_126_5.position

				var_126_5.forward = Vector3.New(var_126_13.x, var_126_13.y, var_126_13.z)

				local var_126_14 = var_126_5.localEulerAngles

				var_126_14.z = 0
				var_126_14.x = 0
				var_126_5.localEulerAngles = var_126_14

				local var_126_15 = GameObjectTools.GetOrAddComponent(var_126_5.gameObject, typeof(DynamicBoneHelper))

				if var_126_15 then
					var_126_15:EnableDynamicBone(true)
				end
			end

			local var_126_16 = arg_123_1.actors_["6148ui_story"]
			local var_126_17 = 0

			if var_126_17 < arg_123_1.time_ and arg_123_1.time_ <= var_126_17 + arg_126_0 and not isNil(var_126_16) and arg_123_1.var_.characterEffect6148ui_story == nil then
				arg_123_1.var_.characterEffect6148ui_story = var_126_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_18 = 0.200000002980232

			if var_126_17 <= arg_123_1.time_ and arg_123_1.time_ < var_126_17 + var_126_18 and not isNil(var_126_16) then
				local var_126_19 = (arg_123_1.time_ - var_126_17) / var_126_18

				if arg_123_1.var_.characterEffect6148ui_story and not isNil(var_126_16) then
					arg_123_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_17 + var_126_18 and arg_123_1.time_ < var_126_17 + var_126_18 + arg_126_0 and not isNil(var_126_16) and arg_123_1.var_.characterEffect6148ui_story then
				arg_123_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_126_20 = arg_123_1.actors_["1054ui_story"]
			local var_126_21 = 0

			if var_126_21 < arg_123_1.time_ and arg_123_1.time_ <= var_126_21 + arg_126_0 and not isNil(var_126_20) and arg_123_1.var_.characterEffect1054ui_story == nil then
				arg_123_1.var_.characterEffect1054ui_story = var_126_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_22 = 0.200000002980232

			if var_126_21 <= arg_123_1.time_ and arg_123_1.time_ < var_126_21 + var_126_22 and not isNil(var_126_20) then
				local var_126_23 = (arg_123_1.time_ - var_126_21) / var_126_22

				if arg_123_1.var_.characterEffect1054ui_story and not isNil(var_126_20) then
					local var_126_24 = Mathf.Lerp(0, 0.5, var_126_23)

					arg_123_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1054ui_story.fillRatio = var_126_24
				end
			end

			if arg_123_1.time_ >= var_126_21 + var_126_22 and arg_123_1.time_ < var_126_21 + var_126_22 + arg_126_0 and not isNil(var_126_20) and arg_123_1.var_.characterEffect1054ui_story then
				local var_126_25 = 0.5

				arg_123_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1054ui_story.fillRatio = var_126_25
			end

			local var_126_26 = 0

			if var_126_26 < arg_123_1.time_ and arg_123_1.time_ <= var_126_26 + arg_126_0 then
				arg_123_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_126_27 = 0

			if var_126_27 < arg_123_1.time_ and arg_123_1.time_ <= var_126_27 + arg_126_0 then
				arg_123_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_126_28 = 0
			local var_126_29 = 0.6

			if var_126_28 < arg_123_1.time_ and arg_123_1.time_ <= var_126_28 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_30 = arg_123_1:FormatText(StoryNameCfg[1488].name)

				arg_123_1.leftNameTxt_.text = var_126_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_31 = arg_123_1:GetWordFromCfg(426031030)
				local var_126_32 = arg_123_1:FormatText(var_126_31.content)

				arg_123_1.text_.text = var_126_32

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_33 = 24
				local var_126_34 = utf8.len(var_126_32)
				local var_126_35 = var_126_33 <= 0 and var_126_29 or var_126_29 * (var_126_34 / var_126_33)

				if var_126_35 > 0 and var_126_29 < var_126_35 then
					arg_123_1.talkMaxDuration = var_126_35

					if var_126_35 + var_126_28 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_35 + var_126_28
					end
				end

				arg_123_1.text_.text = var_126_32
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031030", "story_v_out_426031.awb") ~= 0 then
					local var_126_36 = manager.audio:GetVoiceLength("story_v_out_426031", "426031030", "story_v_out_426031.awb") / 1000

					if var_126_36 + var_126_28 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_36 + var_126_28
					end

					if var_126_31.prefab_name ~= "" and arg_123_1.actors_[var_126_31.prefab_name] ~= nil then
						local var_126_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_31.prefab_name].transform, "story_v_out_426031", "426031030", "story_v_out_426031.awb")

						arg_123_1:RecordAudio("426031030", var_126_37)
						arg_123_1:RecordAudio("426031030", var_126_37)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_426031", "426031030", "story_v_out_426031.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_426031", "426031030", "story_v_out_426031.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_38 = math.max(var_126_29, arg_123_1.talkMaxDuration)

			if var_126_28 <= arg_123_1.time_ and arg_123_1.time_ < var_126_28 + var_126_38 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_28) / var_126_38

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_28 + var_126_38 and arg_123_1.time_ < var_126_28 + var_126_38 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426031031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 426031031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play426031032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["6148ui_story"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos6148ui_story = var_130_0.localPosition

				local var_130_2 = GameObjectTools.GetOrAddComponent(var_130_0.gameObject, typeof(DynamicBoneHelper))

				if var_130_2 then
					var_130_2:EnableDynamicBone(false)
				end
			end

			local var_130_3 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_3 then
				local var_130_4 = (arg_127_1.time_ - var_130_1) / var_130_3
				local var_130_5 = Vector3.New(0, 100, 0)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos6148ui_story, var_130_5, var_130_4)

				local var_130_6 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_6.x, var_130_6.y, var_130_6.z)

				local var_130_7 = var_130_0.localEulerAngles

				var_130_7.z = 0
				var_130_7.x = 0
				var_130_0.localEulerAngles = var_130_7
			end

			if arg_127_1.time_ >= var_130_1 + var_130_3 and arg_127_1.time_ < var_130_1 + var_130_3 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, 100, 0)

				local var_130_8 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_8.x, var_130_8.y, var_130_8.z)

				local var_130_9 = var_130_0.localEulerAngles

				var_130_9.z = 0
				var_130_9.x = 0
				var_130_0.localEulerAngles = var_130_9

				local var_130_10 = GameObjectTools.GetOrAddComponent(var_130_0.gameObject, typeof(DynamicBoneHelper))

				if var_130_10 then
					var_130_10:EnableDynamicBone(true)
				end
			end

			local var_130_11 = arg_127_1.actors_["1054ui_story"].transform
			local var_130_12 = 0

			if var_130_12 < arg_127_1.time_ and arg_127_1.time_ <= var_130_12 + arg_130_0 then
				arg_127_1.var_.moveOldPos1054ui_story = var_130_11.localPosition

				local var_130_13 = GameObjectTools.GetOrAddComponent(var_130_11.gameObject, typeof(DynamicBoneHelper))

				if var_130_13 then
					var_130_13:EnableDynamicBone(false)
				end
			end

			local var_130_14 = 0.001

			if var_130_12 <= arg_127_1.time_ and arg_127_1.time_ < var_130_12 + var_130_14 then
				local var_130_15 = (arg_127_1.time_ - var_130_12) / var_130_14
				local var_130_16 = Vector3.New(0, 100, 0)

				var_130_11.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1054ui_story, var_130_16, var_130_15)

				local var_130_17 = manager.ui.mainCamera.transform.position - var_130_11.position

				var_130_11.forward = Vector3.New(var_130_17.x, var_130_17.y, var_130_17.z)

				local var_130_18 = var_130_11.localEulerAngles

				var_130_18.z = 0
				var_130_18.x = 0
				var_130_11.localEulerAngles = var_130_18
			end

			if arg_127_1.time_ >= var_130_12 + var_130_14 and arg_127_1.time_ < var_130_12 + var_130_14 + arg_130_0 then
				var_130_11.localPosition = Vector3.New(0, 100, 0)

				local var_130_19 = manager.ui.mainCamera.transform.position - var_130_11.position

				var_130_11.forward = Vector3.New(var_130_19.x, var_130_19.y, var_130_19.z)

				local var_130_20 = var_130_11.localEulerAngles

				var_130_20.z = 0
				var_130_20.x = 0
				var_130_11.localEulerAngles = var_130_20

				local var_130_21 = GameObjectTools.GetOrAddComponent(var_130_11.gameObject, typeof(DynamicBoneHelper))

				if var_130_21 then
					var_130_21:EnableDynamicBone(true)
				end
			end

			local var_130_22 = arg_127_1.actors_["6148ui_story"]
			local var_130_23 = 0

			if var_130_23 < arg_127_1.time_ and arg_127_1.time_ <= var_130_23 + arg_130_0 and not isNil(var_130_22) and arg_127_1.var_.characterEffect6148ui_story == nil then
				arg_127_1.var_.characterEffect6148ui_story = var_130_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_24 = 0.200000002980232

			if var_130_23 <= arg_127_1.time_ and arg_127_1.time_ < var_130_23 + var_130_24 and not isNil(var_130_22) then
				local var_130_25 = (arg_127_1.time_ - var_130_23) / var_130_24

				if arg_127_1.var_.characterEffect6148ui_story and not isNil(var_130_22) then
					local var_130_26 = Mathf.Lerp(0, 0.5, var_130_25)

					arg_127_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_127_1.var_.characterEffect6148ui_story.fillRatio = var_130_26
				end
			end

			if arg_127_1.time_ >= var_130_23 + var_130_24 and arg_127_1.time_ < var_130_23 + var_130_24 + arg_130_0 and not isNil(var_130_22) and arg_127_1.var_.characterEffect6148ui_story then
				local var_130_27 = 0.5

				arg_127_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_127_1.var_.characterEffect6148ui_story.fillRatio = var_130_27
			end

			local var_130_28 = 0
			local var_130_29 = 0.725

			if var_130_28 < arg_127_1.time_ and arg_127_1.time_ <= var_130_28 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_30 = arg_127_1:GetWordFromCfg(426031031)
				local var_130_31 = arg_127_1:FormatText(var_130_30.content)

				arg_127_1.text_.text = var_130_31

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_32 = 29
				local var_130_33 = utf8.len(var_130_31)
				local var_130_34 = var_130_32 <= 0 and var_130_29 or var_130_29 * (var_130_33 / var_130_32)

				if var_130_34 > 0 and var_130_29 < var_130_34 then
					arg_127_1.talkMaxDuration = var_130_34

					if var_130_34 + var_130_28 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_34 + var_130_28
					end
				end

				arg_127_1.text_.text = var_130_31
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_35 = math.max(var_130_29, arg_127_1.talkMaxDuration)

			if var_130_28 <= arg_127_1.time_ and arg_127_1.time_ < var_130_28 + var_130_35 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_28) / var_130_35

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_28 + var_130_35 and arg_127_1.time_ < var_130_28 + var_130_35 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_127_1:InitPlayNodeList()
	end,
	Play426031032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 426031032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play426031033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.4

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(426031032)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 16
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play426031033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 426031033
		arg_135_1.duration_ = 3.43

		local var_135_0 = {
			zh = 3.433,
			ja = 3.333
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
				arg_135_0:Play426031034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1054ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos1054ui_story = var_138_0.localPosition

				local var_138_2 = GameObjectTools.GetOrAddComponent(var_138_0.gameObject, typeof(DynamicBoneHelper))

				if var_138_2 then
					var_138_2:EnableDynamicBone(false)
				end
			end

			local var_138_3 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_3 then
				local var_138_4 = (arg_135_1.time_ - var_138_1) / var_138_3
				local var_138_5 = Vector3.New(0, -0.985, -6)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1054ui_story, var_138_5, var_138_4)

				local var_138_6 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_6.x, var_138_6.y, var_138_6.z)

				local var_138_7 = var_138_0.localEulerAngles

				var_138_7.z = 0
				var_138_7.x = 0
				var_138_0.localEulerAngles = var_138_7
			end

			if arg_135_1.time_ >= var_138_1 + var_138_3 and arg_135_1.time_ < var_138_1 + var_138_3 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_138_8 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_8.x, var_138_8.y, var_138_8.z)

				local var_138_9 = var_138_0.localEulerAngles

				var_138_9.z = 0
				var_138_9.x = 0
				var_138_0.localEulerAngles = var_138_9

				local var_138_10 = GameObjectTools.GetOrAddComponent(var_138_0.gameObject, typeof(DynamicBoneHelper))

				if var_138_10 then
					var_138_10:EnableDynamicBone(true)
				end
			end

			local var_138_11 = arg_135_1.actors_["1054ui_story"]
			local var_138_12 = 0

			if var_138_12 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 and not isNil(var_138_11) and arg_135_1.var_.characterEffect1054ui_story == nil then
				arg_135_1.var_.characterEffect1054ui_story = var_138_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_13 = 0.200000002980232

			if var_138_12 <= arg_135_1.time_ and arg_135_1.time_ < var_138_12 + var_138_13 and not isNil(var_138_11) then
				local var_138_14 = (arg_135_1.time_ - var_138_12) / var_138_13

				if arg_135_1.var_.characterEffect1054ui_story and not isNil(var_138_11) then
					arg_135_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_12 + var_138_13 and arg_135_1.time_ < var_138_12 + var_138_13 + arg_138_0 and not isNil(var_138_11) and arg_135_1.var_.characterEffect1054ui_story then
				arg_135_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_138_15 = 0

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 then
				arg_135_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			local var_138_16 = 0

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 then
				arg_135_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_138_17 = 0
			local var_138_18 = 0.2

			if var_138_17 < arg_135_1.time_ and arg_135_1.time_ <= var_138_17 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_19 = arg_135_1:FormatText(StoryNameCfg[1487].name)

				arg_135_1.leftNameTxt_.text = var_138_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_20 = arg_135_1:GetWordFromCfg(426031033)
				local var_138_21 = arg_135_1:FormatText(var_138_20.content)

				arg_135_1.text_.text = var_138_21

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_22 = 8
				local var_138_23 = utf8.len(var_138_21)
				local var_138_24 = var_138_22 <= 0 and var_138_18 or var_138_18 * (var_138_23 / var_138_22)

				if var_138_24 > 0 and var_138_18 < var_138_24 then
					arg_135_1.talkMaxDuration = var_138_24

					if var_138_24 + var_138_17 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_24 + var_138_17
					end
				end

				arg_135_1.text_.text = var_138_21
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031033", "story_v_out_426031.awb") ~= 0 then
					local var_138_25 = manager.audio:GetVoiceLength("story_v_out_426031", "426031033", "story_v_out_426031.awb") / 1000

					if var_138_25 + var_138_17 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_25 + var_138_17
					end

					if var_138_20.prefab_name ~= "" and arg_135_1.actors_[var_138_20.prefab_name] ~= nil then
						local var_138_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_20.prefab_name].transform, "story_v_out_426031", "426031033", "story_v_out_426031.awb")

						arg_135_1:RecordAudio("426031033", var_138_26)
						arg_135_1:RecordAudio("426031033", var_138_26)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_426031", "426031033", "story_v_out_426031.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_426031", "426031033", "story_v_out_426031.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_27 = math.max(var_138_18, arg_135_1.talkMaxDuration)

			if var_138_17 <= arg_135_1.time_ and arg_135_1.time_ < var_138_17 + var_138_27 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_17) / var_138_27

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_17 + var_138_27 and arg_135_1.time_ < var_138_17 + var_138_27 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play426031034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 426031034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play426031035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1054ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1054ui_story == nil then
				arg_139_1.var_.characterEffect1054ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1054ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1054ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1054ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1054ui_story.fillRatio = var_142_5
			end

			local var_142_6 = 0
			local var_142_7 = 0.725

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_8 = arg_139_1:FormatText(StoryNameCfg[7].name)

				arg_139_1.leftNameTxt_.text = var_142_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_9 = arg_139_1:GetWordFromCfg(426031034)
				local var_142_10 = arg_139_1:FormatText(var_142_9.content)

				arg_139_1.text_.text = var_142_10

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 29
				local var_142_12 = utf8.len(var_142_10)
				local var_142_13 = var_142_11 <= 0 and var_142_7 or var_142_7 * (var_142_12 / var_142_11)

				if var_142_13 > 0 and var_142_7 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_10
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_14 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_14 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_14

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_14 and arg_139_1.time_ < var_142_6 + var_142_14 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play426031035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 426031035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play426031036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.7

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[7].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(426031035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 28
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
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_8 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_8 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_8

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_8 and arg_143_1.time_ < var_146_0 + var_146_8 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play426031036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 426031036
		arg_147_1.duration_ = 4.97

		local var_147_0 = {
			zh = 4.966,
			ja = 4.4
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
				arg_147_0:Play426031037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["6148ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos6148ui_story = var_150_0.localPosition

				local var_150_2 = GameObjectTools.GetOrAddComponent(var_150_0.gameObject, typeof(DynamicBoneHelper))

				if var_150_2 then
					var_150_2:EnableDynamicBone(false)
				end
			end

			local var_150_3 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_3 then
				local var_150_4 = (arg_147_1.time_ - var_150_1) / var_150_3
				local var_150_5 = Vector3.New(0.7, -0.985, -6)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos6148ui_story, var_150_5, var_150_4)

				local var_150_6 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_6.x, var_150_6.y, var_150_6.z)

				local var_150_7 = var_150_0.localEulerAngles

				var_150_7.z = 0
				var_150_7.x = 0
				var_150_0.localEulerAngles = var_150_7
			end

			if arg_147_1.time_ >= var_150_1 + var_150_3 and arg_147_1.time_ < var_150_1 + var_150_3 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_150_8 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_8.x, var_150_8.y, var_150_8.z)

				local var_150_9 = var_150_0.localEulerAngles

				var_150_9.z = 0
				var_150_9.x = 0
				var_150_0.localEulerAngles = var_150_9

				local var_150_10 = GameObjectTools.GetOrAddComponent(var_150_0.gameObject, typeof(DynamicBoneHelper))

				if var_150_10 then
					var_150_10:EnableDynamicBone(true)
				end
			end

			local var_150_11 = arg_147_1.actors_["1054ui_story"].transform
			local var_150_12 = 0

			if var_150_12 < arg_147_1.time_ and arg_147_1.time_ <= var_150_12 + arg_150_0 then
				arg_147_1.var_.moveOldPos1054ui_story = var_150_11.localPosition

				local var_150_13 = GameObjectTools.GetOrAddComponent(var_150_11.gameObject, typeof(DynamicBoneHelper))

				if var_150_13 then
					var_150_13:EnableDynamicBone(false)
				end
			end

			local var_150_14 = 0.001

			if var_150_12 <= arg_147_1.time_ and arg_147_1.time_ < var_150_12 + var_150_14 then
				local var_150_15 = (arg_147_1.time_ - var_150_12) / var_150_14
				local var_150_16 = Vector3.New(-0.7, -0.985, -6)

				var_150_11.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1054ui_story, var_150_16, var_150_15)

				local var_150_17 = manager.ui.mainCamera.transform.position - var_150_11.position

				var_150_11.forward = Vector3.New(var_150_17.x, var_150_17.y, var_150_17.z)

				local var_150_18 = var_150_11.localEulerAngles

				var_150_18.z = 0
				var_150_18.x = 0
				var_150_11.localEulerAngles = var_150_18
			end

			if arg_147_1.time_ >= var_150_12 + var_150_14 and arg_147_1.time_ < var_150_12 + var_150_14 + arg_150_0 then
				var_150_11.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_150_19 = manager.ui.mainCamera.transform.position - var_150_11.position

				var_150_11.forward = Vector3.New(var_150_19.x, var_150_19.y, var_150_19.z)

				local var_150_20 = var_150_11.localEulerAngles

				var_150_20.z = 0
				var_150_20.x = 0
				var_150_11.localEulerAngles = var_150_20

				local var_150_21 = GameObjectTools.GetOrAddComponent(var_150_11.gameObject, typeof(DynamicBoneHelper))

				if var_150_21 then
					var_150_21:EnableDynamicBone(true)
				end
			end

			local var_150_22 = arg_147_1.actors_["6148ui_story"]
			local var_150_23 = 0

			if var_150_23 < arg_147_1.time_ and arg_147_1.time_ <= var_150_23 + arg_150_0 and not isNil(var_150_22) and arg_147_1.var_.characterEffect6148ui_story == nil then
				arg_147_1.var_.characterEffect6148ui_story = var_150_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_24 = 0.200000002980232

			if var_150_23 <= arg_147_1.time_ and arg_147_1.time_ < var_150_23 + var_150_24 and not isNil(var_150_22) then
				local var_150_25 = (arg_147_1.time_ - var_150_23) / var_150_24

				if arg_147_1.var_.characterEffect6148ui_story and not isNil(var_150_22) then
					arg_147_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_23 + var_150_24 and arg_147_1.time_ < var_150_23 + var_150_24 + arg_150_0 and not isNil(var_150_22) and arg_147_1.var_.characterEffect6148ui_story then
				arg_147_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_150_26 = 0

			if var_150_26 < arg_147_1.time_ and arg_147_1.time_ <= var_150_26 + arg_150_0 then
				arg_147_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_150_27 = 0

			if var_150_27 < arg_147_1.time_ and arg_147_1.time_ <= var_150_27 + arg_150_0 then
				arg_147_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_150_28 = 0
			local var_150_29 = 0.5

			if var_150_28 < arg_147_1.time_ and arg_147_1.time_ <= var_150_28 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_30 = arg_147_1:FormatText(StoryNameCfg[1488].name)

				arg_147_1.leftNameTxt_.text = var_150_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_31 = arg_147_1:GetWordFromCfg(426031036)
				local var_150_32 = arg_147_1:FormatText(var_150_31.content)

				arg_147_1.text_.text = var_150_32

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_33 = 20
				local var_150_34 = utf8.len(var_150_32)
				local var_150_35 = var_150_33 <= 0 and var_150_29 or var_150_29 * (var_150_34 / var_150_33)

				if var_150_35 > 0 and var_150_29 < var_150_35 then
					arg_147_1.talkMaxDuration = var_150_35

					if var_150_35 + var_150_28 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_35 + var_150_28
					end
				end

				arg_147_1.text_.text = var_150_32
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031036", "story_v_out_426031.awb") ~= 0 then
					local var_150_36 = manager.audio:GetVoiceLength("story_v_out_426031", "426031036", "story_v_out_426031.awb") / 1000

					if var_150_36 + var_150_28 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_36 + var_150_28
					end

					if var_150_31.prefab_name ~= "" and arg_147_1.actors_[var_150_31.prefab_name] ~= nil then
						local var_150_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_31.prefab_name].transform, "story_v_out_426031", "426031036", "story_v_out_426031.awb")

						arg_147_1:RecordAudio("426031036", var_150_37)
						arg_147_1:RecordAudio("426031036", var_150_37)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_426031", "426031036", "story_v_out_426031.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_426031", "426031036", "story_v_out_426031.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_38 = math.max(var_150_29, arg_147_1.talkMaxDuration)

			if var_150_28 <= arg_147_1.time_ and arg_147_1.time_ < var_150_28 + var_150_38 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_28) / var_150_38

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_28 + var_150_38 and arg_147_1.time_ < var_150_28 + var_150_38 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_147_1:InitPlayNodeList()
	end,
	Play426031037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 426031037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play426031038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["6148ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect6148ui_story == nil then
				arg_151_1.var_.characterEffect6148ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect6148ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_151_1.var_.characterEffect6148ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect6148ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_151_1.var_.characterEffect6148ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.6

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[7].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_9 = arg_151_1:GetWordFromCfg(426031037)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 24
				local var_154_12 = utf8.len(var_154_10)
				local var_154_13 = var_154_11 <= 0 and var_154_7 or var_154_7 * (var_154_12 / var_154_11)

				if var_154_13 > 0 and var_154_7 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_10
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_14 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_14 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_14

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_14 and arg_151_1.time_ < var_154_6 + var_154_14 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play426031038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 426031038
		arg_155_1.duration_ = 8.6

		local var_155_0 = {
			zh = 8.6,
			ja = 5.733
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
				arg_155_0:Play426031039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1054ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos1054ui_story = var_158_0.localPosition

				local var_158_2 = GameObjectTools.GetOrAddComponent(var_158_0.gameObject, typeof(DynamicBoneHelper))

				if var_158_2 then
					var_158_2:EnableDynamicBone(false)
				end
			end

			local var_158_3 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_3 then
				local var_158_4 = (arg_155_1.time_ - var_158_1) / var_158_3
				local var_158_5 = Vector3.New(-0.7, -0.985, -6)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1054ui_story, var_158_5, var_158_4)

				local var_158_6 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_6.x, var_158_6.y, var_158_6.z)

				local var_158_7 = var_158_0.localEulerAngles

				var_158_7.z = 0
				var_158_7.x = 0
				var_158_0.localEulerAngles = var_158_7
			end

			if arg_155_1.time_ >= var_158_1 + var_158_3 and arg_155_1.time_ < var_158_1 + var_158_3 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_158_8 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_8.x, var_158_8.y, var_158_8.z)

				local var_158_9 = var_158_0.localEulerAngles

				var_158_9.z = 0
				var_158_9.x = 0
				var_158_0.localEulerAngles = var_158_9

				local var_158_10 = GameObjectTools.GetOrAddComponent(var_158_0.gameObject, typeof(DynamicBoneHelper))

				if var_158_10 then
					var_158_10:EnableDynamicBone(true)
				end
			end

			local var_158_11 = arg_155_1.actors_["1054ui_story"]
			local var_158_12 = 0

			if var_158_12 < arg_155_1.time_ and arg_155_1.time_ <= var_158_12 + arg_158_0 and not isNil(var_158_11) and arg_155_1.var_.characterEffect1054ui_story == nil then
				arg_155_1.var_.characterEffect1054ui_story = var_158_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_13 = 0.200000002980232

			if var_158_12 <= arg_155_1.time_ and arg_155_1.time_ < var_158_12 + var_158_13 and not isNil(var_158_11) then
				local var_158_14 = (arg_155_1.time_ - var_158_12) / var_158_13

				if arg_155_1.var_.characterEffect1054ui_story and not isNil(var_158_11) then
					arg_155_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_12 + var_158_13 and arg_155_1.time_ < var_158_12 + var_158_13 + arg_158_0 and not isNil(var_158_11) and arg_155_1.var_.characterEffect1054ui_story then
				arg_155_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_158_15 = 0

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_2")
			end

			local var_158_16 = 0

			if var_158_16 < arg_155_1.time_ and arg_155_1.time_ <= var_158_16 + arg_158_0 then
				arg_155_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_158_17 = 0
			local var_158_18 = 0.85

			if var_158_17 < arg_155_1.time_ and arg_155_1.time_ <= var_158_17 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_19 = arg_155_1:FormatText(StoryNameCfg[1487].name)

				arg_155_1.leftNameTxt_.text = var_158_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_20 = arg_155_1:GetWordFromCfg(426031038)
				local var_158_21 = arg_155_1:FormatText(var_158_20.content)

				arg_155_1.text_.text = var_158_21

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_22 = 34
				local var_158_23 = utf8.len(var_158_21)
				local var_158_24 = var_158_22 <= 0 and var_158_18 or var_158_18 * (var_158_23 / var_158_22)

				if var_158_24 > 0 and var_158_18 < var_158_24 then
					arg_155_1.talkMaxDuration = var_158_24

					if var_158_24 + var_158_17 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_24 + var_158_17
					end
				end

				arg_155_1.text_.text = var_158_21
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031038", "story_v_out_426031.awb") ~= 0 then
					local var_158_25 = manager.audio:GetVoiceLength("story_v_out_426031", "426031038", "story_v_out_426031.awb") / 1000

					if var_158_25 + var_158_17 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_25 + var_158_17
					end

					if var_158_20.prefab_name ~= "" and arg_155_1.actors_[var_158_20.prefab_name] ~= nil then
						local var_158_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_20.prefab_name].transform, "story_v_out_426031", "426031038", "story_v_out_426031.awb")

						arg_155_1:RecordAudio("426031038", var_158_26)
						arg_155_1:RecordAudio("426031038", var_158_26)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_426031", "426031038", "story_v_out_426031.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_426031", "426031038", "story_v_out_426031.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_27 = math.max(var_158_18, arg_155_1.talkMaxDuration)

			if var_158_17 <= arg_155_1.time_ and arg_155_1.time_ < var_158_17 + var_158_27 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_17) / var_158_27

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_17 + var_158_27 and arg_155_1.time_ < var_158_17 + var_158_27 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play426031039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 426031039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play426031040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["6148ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos6148ui_story = var_162_0.localPosition

				local var_162_2 = GameObjectTools.GetOrAddComponent(var_162_0.gameObject, typeof(DynamicBoneHelper))

				if var_162_2 then
					var_162_2:EnableDynamicBone(false)
				end
			end

			local var_162_3 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_3 then
				local var_162_4 = (arg_159_1.time_ - var_162_1) / var_162_3
				local var_162_5 = Vector3.New(0, 100, 0)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos6148ui_story, var_162_5, var_162_4)

				local var_162_6 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_6.x, var_162_6.y, var_162_6.z)

				local var_162_7 = var_162_0.localEulerAngles

				var_162_7.z = 0
				var_162_7.x = 0
				var_162_0.localEulerAngles = var_162_7
			end

			if arg_159_1.time_ >= var_162_1 + var_162_3 and arg_159_1.time_ < var_162_1 + var_162_3 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, 100, 0)

				local var_162_8 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_8.x, var_162_8.y, var_162_8.z)

				local var_162_9 = var_162_0.localEulerAngles

				var_162_9.z = 0
				var_162_9.x = 0
				var_162_0.localEulerAngles = var_162_9

				local var_162_10 = GameObjectTools.GetOrAddComponent(var_162_0.gameObject, typeof(DynamicBoneHelper))

				if var_162_10 then
					var_162_10:EnableDynamicBone(true)
				end
			end

			local var_162_11 = arg_159_1.actors_["1054ui_story"].transform
			local var_162_12 = 0

			if var_162_12 < arg_159_1.time_ and arg_159_1.time_ <= var_162_12 + arg_162_0 then
				arg_159_1.var_.moveOldPos1054ui_story = var_162_11.localPosition

				local var_162_13 = GameObjectTools.GetOrAddComponent(var_162_11.gameObject, typeof(DynamicBoneHelper))

				if var_162_13 then
					var_162_13:EnableDynamicBone(false)
				end
			end

			local var_162_14 = 0.001

			if var_162_12 <= arg_159_1.time_ and arg_159_1.time_ < var_162_12 + var_162_14 then
				local var_162_15 = (arg_159_1.time_ - var_162_12) / var_162_14
				local var_162_16 = Vector3.New(0, 100, 0)

				var_162_11.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1054ui_story, var_162_16, var_162_15)

				local var_162_17 = manager.ui.mainCamera.transform.position - var_162_11.position

				var_162_11.forward = Vector3.New(var_162_17.x, var_162_17.y, var_162_17.z)

				local var_162_18 = var_162_11.localEulerAngles

				var_162_18.z = 0
				var_162_18.x = 0
				var_162_11.localEulerAngles = var_162_18
			end

			if arg_159_1.time_ >= var_162_12 + var_162_14 and arg_159_1.time_ < var_162_12 + var_162_14 + arg_162_0 then
				var_162_11.localPosition = Vector3.New(0, 100, 0)

				local var_162_19 = manager.ui.mainCamera.transform.position - var_162_11.position

				var_162_11.forward = Vector3.New(var_162_19.x, var_162_19.y, var_162_19.z)

				local var_162_20 = var_162_11.localEulerAngles

				var_162_20.z = 0
				var_162_20.x = 0
				var_162_11.localEulerAngles = var_162_20

				local var_162_21 = GameObjectTools.GetOrAddComponent(var_162_11.gameObject, typeof(DynamicBoneHelper))

				if var_162_21 then
					var_162_21:EnableDynamicBone(true)
				end
			end

			local var_162_22 = arg_159_1.actors_["1054ui_story"]
			local var_162_23 = 0

			if var_162_23 < arg_159_1.time_ and arg_159_1.time_ <= var_162_23 + arg_162_0 and not isNil(var_162_22) and arg_159_1.var_.characterEffect1054ui_story == nil then
				arg_159_1.var_.characterEffect1054ui_story = var_162_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_24 = 0.200000002980232

			if var_162_23 <= arg_159_1.time_ and arg_159_1.time_ < var_162_23 + var_162_24 and not isNil(var_162_22) then
				local var_162_25 = (arg_159_1.time_ - var_162_23) / var_162_24

				if arg_159_1.var_.characterEffect1054ui_story and not isNil(var_162_22) then
					local var_162_26 = Mathf.Lerp(0, 0.5, var_162_25)

					arg_159_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1054ui_story.fillRatio = var_162_26
				end
			end

			if arg_159_1.time_ >= var_162_23 + var_162_24 and arg_159_1.time_ < var_162_23 + var_162_24 + arg_162_0 and not isNil(var_162_22) and arg_159_1.var_.characterEffect1054ui_story then
				local var_162_27 = 0.5

				arg_159_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1054ui_story.fillRatio = var_162_27
			end

			local var_162_28 = 0
			local var_162_29 = 1.125

			if var_162_28 < arg_159_1.time_ and arg_159_1.time_ <= var_162_28 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_30 = arg_159_1:GetWordFromCfg(426031039)
				local var_162_31 = arg_159_1:FormatText(var_162_30.content)

				arg_159_1.text_.text = var_162_31

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_32 = 45
				local var_162_33 = utf8.len(var_162_31)
				local var_162_34 = var_162_32 <= 0 and var_162_29 or var_162_29 * (var_162_33 / var_162_32)

				if var_162_34 > 0 and var_162_29 < var_162_34 then
					arg_159_1.talkMaxDuration = var_162_34

					if var_162_34 + var_162_28 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_34 + var_162_28
					end
				end

				arg_159_1.text_.text = var_162_31
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_35 = math.max(var_162_29, arg_159_1.talkMaxDuration)

			if var_162_28 <= arg_159_1.time_ and arg_159_1.time_ < var_162_28 + var_162_35 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_28) / var_162_35

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_28 + var_162_35 and arg_159_1.time_ < var_162_28 + var_162_35 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_159_1:InitPlayNodeList()
	end,
	Play426031040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 426031040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play426031041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.875

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[7].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:GetWordFromCfg(426031040)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 35
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_8 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_8 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_8

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_8 and arg_163_1.time_ < var_166_0 + var_166_8 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play426031041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 426031041
		arg_167_1.duration_ = 4.67

		local var_167_0 = {
			zh = 4.666,
			ja = 2.9
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
				arg_167_0:Play426031042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["6148ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos6148ui_story = var_170_0.localPosition

				local var_170_2 = GameObjectTools.GetOrAddComponent(var_170_0.gameObject, typeof(DynamicBoneHelper))

				if var_170_2 then
					var_170_2:EnableDynamicBone(false)
				end
			end

			local var_170_3 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_3 then
				local var_170_4 = (arg_167_1.time_ - var_170_1) / var_170_3
				local var_170_5 = Vector3.New(-0.7, -0.985, -6)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos6148ui_story, var_170_5, var_170_4)

				local var_170_6 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_6.x, var_170_6.y, var_170_6.z)

				local var_170_7 = var_170_0.localEulerAngles

				var_170_7.z = 0
				var_170_7.x = 0
				var_170_0.localEulerAngles = var_170_7
			end

			if arg_167_1.time_ >= var_170_1 + var_170_3 and arg_167_1.time_ < var_170_1 + var_170_3 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_170_8 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_8.x, var_170_8.y, var_170_8.z)

				local var_170_9 = var_170_0.localEulerAngles

				var_170_9.z = 0
				var_170_9.x = 0
				var_170_0.localEulerAngles = var_170_9

				local var_170_10 = GameObjectTools.GetOrAddComponent(var_170_0.gameObject, typeof(DynamicBoneHelper))

				if var_170_10 then
					var_170_10:EnableDynamicBone(true)
				end
			end

			local var_170_11 = arg_167_1.actors_["6148ui_story"]
			local var_170_12 = 0

			if var_170_12 < arg_167_1.time_ and arg_167_1.time_ <= var_170_12 + arg_170_0 and not isNil(var_170_11) and arg_167_1.var_.characterEffect6148ui_story == nil then
				arg_167_1.var_.characterEffect6148ui_story = var_170_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_13 = 0.200000002980232

			if var_170_12 <= arg_167_1.time_ and arg_167_1.time_ < var_170_12 + var_170_13 and not isNil(var_170_11) then
				local var_170_14 = (arg_167_1.time_ - var_170_12) / var_170_13

				if arg_167_1.var_.characterEffect6148ui_story and not isNil(var_170_11) then
					arg_167_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_12 + var_170_13 and arg_167_1.time_ < var_170_12 + var_170_13 + arg_170_0 and not isNil(var_170_11) and arg_167_1.var_.characterEffect6148ui_story then
				arg_167_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_170_15 = 0

			if var_170_15 < arg_167_1.time_ and arg_167_1.time_ <= var_170_15 + arg_170_0 then
				arg_167_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_170_16 = 0
			local var_170_17 = 0.325

			if var_170_16 < arg_167_1.time_ and arg_167_1.time_ <= var_170_16 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_18 = arg_167_1:FormatText(StoryNameCfg[1488].name)

				arg_167_1.leftNameTxt_.text = var_170_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_19 = arg_167_1:GetWordFromCfg(426031041)
				local var_170_20 = arg_167_1:FormatText(var_170_19.content)

				arg_167_1.text_.text = var_170_20

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_21 = 13
				local var_170_22 = utf8.len(var_170_20)
				local var_170_23 = var_170_21 <= 0 and var_170_17 or var_170_17 * (var_170_22 / var_170_21)

				if var_170_23 > 0 and var_170_17 < var_170_23 then
					arg_167_1.talkMaxDuration = var_170_23

					if var_170_23 + var_170_16 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_23 + var_170_16
					end
				end

				arg_167_1.text_.text = var_170_20
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031041", "story_v_out_426031.awb") ~= 0 then
					local var_170_24 = manager.audio:GetVoiceLength("story_v_out_426031", "426031041", "story_v_out_426031.awb") / 1000

					if var_170_24 + var_170_16 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_24 + var_170_16
					end

					if var_170_19.prefab_name ~= "" and arg_167_1.actors_[var_170_19.prefab_name] ~= nil then
						local var_170_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_19.prefab_name].transform, "story_v_out_426031", "426031041", "story_v_out_426031.awb")

						arg_167_1:RecordAudio("426031041", var_170_25)
						arg_167_1:RecordAudio("426031041", var_170_25)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_426031", "426031041", "story_v_out_426031.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_426031", "426031041", "story_v_out_426031.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_26 = math.max(var_170_17, arg_167_1.talkMaxDuration)

			if var_170_16 <= arg_167_1.time_ and arg_167_1.time_ < var_170_16 + var_170_26 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_16) / var_170_26

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_16 + var_170_26 and arg_167_1.time_ < var_170_16 + var_170_26 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426031042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 426031042
		arg_171_1.duration_ = 5.73

		local var_171_0 = {
			zh = 4.133,
			ja = 5.733
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
				arg_171_0:Play426031043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1054ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1054ui_story = var_174_0.localPosition

				local var_174_2 = GameObjectTools.GetOrAddComponent(var_174_0.gameObject, typeof(DynamicBoneHelper))

				if var_174_2 then
					var_174_2:EnableDynamicBone(false)
				end
			end

			local var_174_3 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_3 then
				local var_174_4 = (arg_171_1.time_ - var_174_1) / var_174_3
				local var_174_5 = Vector3.New(0.7, -0.985, -6)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1054ui_story, var_174_5, var_174_4)

				local var_174_6 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_6.x, var_174_6.y, var_174_6.z)

				local var_174_7 = var_174_0.localEulerAngles

				var_174_7.z = 0
				var_174_7.x = 0
				var_174_0.localEulerAngles = var_174_7
			end

			if arg_171_1.time_ >= var_174_1 + var_174_3 and arg_171_1.time_ < var_174_1 + var_174_3 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_174_8 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_8.x, var_174_8.y, var_174_8.z)

				local var_174_9 = var_174_0.localEulerAngles

				var_174_9.z = 0
				var_174_9.x = 0
				var_174_0.localEulerAngles = var_174_9

				local var_174_10 = GameObjectTools.GetOrAddComponent(var_174_0.gameObject, typeof(DynamicBoneHelper))

				if var_174_10 then
					var_174_10:EnableDynamicBone(true)
				end
			end

			local var_174_11 = arg_171_1.actors_["1054ui_story"]
			local var_174_12 = 0

			if var_174_12 < arg_171_1.time_ and arg_171_1.time_ <= var_174_12 + arg_174_0 and not isNil(var_174_11) and arg_171_1.var_.characterEffect1054ui_story == nil then
				arg_171_1.var_.characterEffect1054ui_story = var_174_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_13 = 0.200000002980232

			if var_174_12 <= arg_171_1.time_ and arg_171_1.time_ < var_174_12 + var_174_13 and not isNil(var_174_11) then
				local var_174_14 = (arg_171_1.time_ - var_174_12) / var_174_13

				if arg_171_1.var_.characterEffect1054ui_story and not isNil(var_174_11) then
					arg_171_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_12 + var_174_13 and arg_171_1.time_ < var_174_12 + var_174_13 + arg_174_0 and not isNil(var_174_11) and arg_171_1.var_.characterEffect1054ui_story then
				arg_171_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_174_15 = arg_171_1.actors_["6148ui_story"]
			local var_174_16 = 0

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 and not isNil(var_174_15) and arg_171_1.var_.characterEffect6148ui_story == nil then
				arg_171_1.var_.characterEffect6148ui_story = var_174_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_17 = 0.200000002980232

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_17 and not isNil(var_174_15) then
				local var_174_18 = (arg_171_1.time_ - var_174_16) / var_174_17

				if arg_171_1.var_.characterEffect6148ui_story and not isNil(var_174_15) then
					local var_174_19 = Mathf.Lerp(0, 0.5, var_174_18)

					arg_171_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_171_1.var_.characterEffect6148ui_story.fillRatio = var_174_19
				end
			end

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 and not isNil(var_174_15) and arg_171_1.var_.characterEffect6148ui_story then
				local var_174_20 = 0.5

				arg_171_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_171_1.var_.characterEffect6148ui_story.fillRatio = var_174_20
			end

			local var_174_21 = 0

			if var_174_21 < arg_171_1.time_ and arg_171_1.time_ <= var_174_21 + arg_174_0 then
				arg_171_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_174_22 = 0

			if var_174_22 < arg_171_1.time_ and arg_171_1.time_ <= var_174_22 + arg_174_0 then
				arg_171_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_174_23 = 0
			local var_174_24 = 0.35

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_25 = arg_171_1:FormatText(StoryNameCfg[1487].name)

				arg_171_1.leftNameTxt_.text = var_174_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_26 = arg_171_1:GetWordFromCfg(426031042)
				local var_174_27 = arg_171_1:FormatText(var_174_26.content)

				arg_171_1.text_.text = var_174_27

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_28 = 14
				local var_174_29 = utf8.len(var_174_27)
				local var_174_30 = var_174_28 <= 0 and var_174_24 or var_174_24 * (var_174_29 / var_174_28)

				if var_174_30 > 0 and var_174_24 < var_174_30 then
					arg_171_1.talkMaxDuration = var_174_30

					if var_174_30 + var_174_23 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_30 + var_174_23
					end
				end

				arg_171_1.text_.text = var_174_27
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031042", "story_v_out_426031.awb") ~= 0 then
					local var_174_31 = manager.audio:GetVoiceLength("story_v_out_426031", "426031042", "story_v_out_426031.awb") / 1000

					if var_174_31 + var_174_23 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_31 + var_174_23
					end

					if var_174_26.prefab_name ~= "" and arg_171_1.actors_[var_174_26.prefab_name] ~= nil then
						local var_174_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_26.prefab_name].transform, "story_v_out_426031", "426031042", "story_v_out_426031.awb")

						arg_171_1:RecordAudio("426031042", var_174_32)
						arg_171_1:RecordAudio("426031042", var_174_32)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_426031", "426031042", "story_v_out_426031.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_426031", "426031042", "story_v_out_426031.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_33 = math.max(var_174_24, arg_171_1.talkMaxDuration)

			if var_174_23 <= arg_171_1.time_ and arg_171_1.time_ < var_174_23 + var_174_33 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_23) / var_174_33

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_23 + var_174_33 and arg_171_1.time_ < var_174_23 + var_174_33 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play426031043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 426031043
		arg_175_1.duration_ = 2

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play426031044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1012ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1012ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(-0.7, -1.05, -6.24)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1012ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(-0.7, -1.05, -6.24)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["6148ui_story"].transform
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 then
				arg_175_1.var_.moveOldPos6148ui_story = var_178_9.localPosition

				local var_178_11 = GameObjectTools.GetOrAddComponent(var_178_9.gameObject, typeof(DynamicBoneHelper))

				if var_178_11 then
					var_178_11:EnableDynamicBone(false)
				end
			end

			local var_178_12 = 0.001

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_12 then
				local var_178_13 = (arg_175_1.time_ - var_178_10) / var_178_12
				local var_178_14 = Vector3.New(0, 100, 0)

				var_178_9.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos6148ui_story, var_178_14, var_178_13)

				local var_178_15 = manager.ui.mainCamera.transform.position - var_178_9.position

				var_178_9.forward = Vector3.New(var_178_15.x, var_178_15.y, var_178_15.z)

				local var_178_16 = var_178_9.localEulerAngles

				var_178_16.z = 0
				var_178_16.x = 0
				var_178_9.localEulerAngles = var_178_16
			end

			if arg_175_1.time_ >= var_178_10 + var_178_12 and arg_175_1.time_ < var_178_10 + var_178_12 + arg_178_0 then
				var_178_9.localPosition = Vector3.New(0, 100, 0)

				local var_178_17 = manager.ui.mainCamera.transform.position - var_178_9.position

				var_178_9.forward = Vector3.New(var_178_17.x, var_178_17.y, var_178_17.z)

				local var_178_18 = var_178_9.localEulerAngles

				var_178_18.z = 0
				var_178_18.x = 0
				var_178_9.localEulerAngles = var_178_18

				local var_178_19 = GameObjectTools.GetOrAddComponent(var_178_9.gameObject, typeof(DynamicBoneHelper))

				if var_178_19 then
					var_178_19:EnableDynamicBone(true)
				end
			end

			local var_178_20 = arg_175_1.actors_["1012ui_story"]
			local var_178_21 = 0

			if var_178_21 < arg_175_1.time_ and arg_175_1.time_ <= var_178_21 + arg_178_0 and not isNil(var_178_20) and arg_175_1.var_.characterEffect1012ui_story == nil then
				arg_175_1.var_.characterEffect1012ui_story = var_178_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_22 = 0.200000002980232

			if var_178_21 <= arg_175_1.time_ and arg_175_1.time_ < var_178_21 + var_178_22 and not isNil(var_178_20) then
				local var_178_23 = (arg_175_1.time_ - var_178_21) / var_178_22

				if arg_175_1.var_.characterEffect1012ui_story and not isNil(var_178_20) then
					arg_175_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_21 + var_178_22 and arg_175_1.time_ < var_178_21 + var_178_22 + arg_178_0 and not isNil(var_178_20) and arg_175_1.var_.characterEffect1012ui_story then
				arg_175_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_178_24 = arg_175_1.actors_["1054ui_story"]
			local var_178_25 = 0

			if var_178_25 < arg_175_1.time_ and arg_175_1.time_ <= var_178_25 + arg_178_0 and not isNil(var_178_24) and arg_175_1.var_.characterEffect1054ui_story == nil then
				arg_175_1.var_.characterEffect1054ui_story = var_178_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_26 = 0.200000002980232

			if var_178_25 <= arg_175_1.time_ and arg_175_1.time_ < var_178_25 + var_178_26 and not isNil(var_178_24) then
				local var_178_27 = (arg_175_1.time_ - var_178_25) / var_178_26

				if arg_175_1.var_.characterEffect1054ui_story and not isNil(var_178_24) then
					local var_178_28 = Mathf.Lerp(0, 0.5, var_178_27)

					arg_175_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1054ui_story.fillRatio = var_178_28
				end
			end

			if arg_175_1.time_ >= var_178_25 + var_178_26 and arg_175_1.time_ < var_178_25 + var_178_26 + arg_178_0 and not isNil(var_178_24) and arg_175_1.var_.characterEffect1054ui_story then
				local var_178_29 = 0.5

				arg_175_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1054ui_story.fillRatio = var_178_29
			end

			local var_178_30 = 0

			if var_178_30 < arg_175_1.time_ and arg_175_1.time_ <= var_178_30 + arg_178_0 then
				arg_175_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_178_31 = 0

			if var_178_31 < arg_175_1.time_ and arg_175_1.time_ <= var_178_31 + arg_178_0 then
				arg_175_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_178_32 = 0
			local var_178_33 = 0.1

			if var_178_32 < arg_175_1.time_ and arg_175_1.time_ <= var_178_32 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_34 = arg_175_1:FormatText(StoryNameCfg[595].name)

				arg_175_1.leftNameTxt_.text = var_178_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_35 = arg_175_1:GetWordFromCfg(426031043)
				local var_178_36 = arg_175_1:FormatText(var_178_35.content)

				arg_175_1.text_.text = var_178_36

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_37 = 4
				local var_178_38 = utf8.len(var_178_36)
				local var_178_39 = var_178_37 <= 0 and var_178_33 or var_178_33 * (var_178_38 / var_178_37)

				if var_178_39 > 0 and var_178_33 < var_178_39 then
					arg_175_1.talkMaxDuration = var_178_39

					if var_178_39 + var_178_32 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_39 + var_178_32
					end
				end

				arg_175_1.text_.text = var_178_36
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031043", "story_v_out_426031.awb") ~= 0 then
					local var_178_40 = manager.audio:GetVoiceLength("story_v_out_426031", "426031043", "story_v_out_426031.awb") / 1000

					if var_178_40 + var_178_32 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_40 + var_178_32
					end

					if var_178_35.prefab_name ~= "" and arg_175_1.actors_[var_178_35.prefab_name] ~= nil then
						local var_178_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_35.prefab_name].transform, "story_v_out_426031", "426031043", "story_v_out_426031.awb")

						arg_175_1:RecordAudio("426031043", var_178_41)
						arg_175_1:RecordAudio("426031043", var_178_41)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_426031", "426031043", "story_v_out_426031.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_426031", "426031043", "story_v_out_426031.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_42 = math.max(var_178_33, arg_175_1.talkMaxDuration)

			if var_178_32 <= arg_175_1.time_ and arg_175_1.time_ < var_178_32 + var_178_42 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_32) / var_178_42

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_32 + var_178_42 and arg_175_1.time_ < var_178_32 + var_178_42 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426031044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 426031044
		arg_179_1.duration_ = 2

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play426031045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1054ui_story"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos1054ui_story = var_182_0.localPosition

				local var_182_2 = GameObjectTools.GetOrAddComponent(var_182_0.gameObject, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(false)
				end
			end

			local var_182_3 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_3 then
				local var_182_4 = (arg_179_1.time_ - var_182_1) / var_182_3
				local var_182_5 = Vector3.New(0.7, -0.985, -6)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1054ui_story, var_182_5, var_182_4)

				local var_182_6 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_6.x, var_182_6.y, var_182_6.z)

				local var_182_7 = var_182_0.localEulerAngles

				var_182_7.z = 0
				var_182_7.x = 0
				var_182_0.localEulerAngles = var_182_7
			end

			if arg_179_1.time_ >= var_182_1 + var_182_3 and arg_179_1.time_ < var_182_1 + var_182_3 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_182_8 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_8.x, var_182_8.y, var_182_8.z)

				local var_182_9 = var_182_0.localEulerAngles

				var_182_9.z = 0
				var_182_9.x = 0
				var_182_0.localEulerAngles = var_182_9

				local var_182_10 = GameObjectTools.GetOrAddComponent(var_182_0.gameObject, typeof(DynamicBoneHelper))

				if var_182_10 then
					var_182_10:EnableDynamicBone(true)
				end
			end

			local var_182_11 = arg_179_1.actors_["1054ui_story"]
			local var_182_12 = 0

			if var_182_12 < arg_179_1.time_ and arg_179_1.time_ <= var_182_12 + arg_182_0 and not isNil(var_182_11) and arg_179_1.var_.characterEffect1054ui_story == nil then
				arg_179_1.var_.characterEffect1054ui_story = var_182_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_13 = 0.200000002980232

			if var_182_12 <= arg_179_1.time_ and arg_179_1.time_ < var_182_12 + var_182_13 and not isNil(var_182_11) then
				local var_182_14 = (arg_179_1.time_ - var_182_12) / var_182_13

				if arg_179_1.var_.characterEffect1054ui_story and not isNil(var_182_11) then
					arg_179_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_12 + var_182_13 and arg_179_1.time_ < var_182_12 + var_182_13 + arg_182_0 and not isNil(var_182_11) and arg_179_1.var_.characterEffect1054ui_story then
				arg_179_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_182_15 = arg_179_1.actors_["1012ui_story"]
			local var_182_16 = 0

			if var_182_16 < arg_179_1.time_ and arg_179_1.time_ <= var_182_16 + arg_182_0 and not isNil(var_182_15) and arg_179_1.var_.characterEffect1012ui_story == nil then
				arg_179_1.var_.characterEffect1012ui_story = var_182_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_17 = 0.200000002980232

			if var_182_16 <= arg_179_1.time_ and arg_179_1.time_ < var_182_16 + var_182_17 and not isNil(var_182_15) then
				local var_182_18 = (arg_179_1.time_ - var_182_16) / var_182_17

				if arg_179_1.var_.characterEffect1012ui_story and not isNil(var_182_15) then
					local var_182_19 = Mathf.Lerp(0, 0.5, var_182_18)

					arg_179_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1012ui_story.fillRatio = var_182_19
				end
			end

			if arg_179_1.time_ >= var_182_16 + var_182_17 and arg_179_1.time_ < var_182_16 + var_182_17 + arg_182_0 and not isNil(var_182_15) and arg_179_1.var_.characterEffect1012ui_story then
				local var_182_20 = 0.5

				arg_179_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1012ui_story.fillRatio = var_182_20
			end

			local var_182_21 = 0

			if var_182_21 < arg_179_1.time_ and arg_179_1.time_ <= var_182_21 + arg_182_0 then
				arg_179_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_182_22 = 0

			if var_182_22 < arg_179_1.time_ and arg_179_1.time_ <= var_182_22 + arg_182_0 then
				arg_179_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			local var_182_23 = 0
			local var_182_24 = 0.05

			if var_182_23 < arg_179_1.time_ and arg_179_1.time_ <= var_182_23 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_25 = arg_179_1:FormatText(StoryNameCfg[1487].name)

				arg_179_1.leftNameTxt_.text = var_182_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_26 = arg_179_1:GetWordFromCfg(426031044)
				local var_182_27 = arg_179_1:FormatText(var_182_26.content)

				arg_179_1.text_.text = var_182_27

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_28 = 2
				local var_182_29 = utf8.len(var_182_27)
				local var_182_30 = var_182_28 <= 0 and var_182_24 or var_182_24 * (var_182_29 / var_182_28)

				if var_182_30 > 0 and var_182_24 < var_182_30 then
					arg_179_1.talkMaxDuration = var_182_30

					if var_182_30 + var_182_23 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_30 + var_182_23
					end
				end

				arg_179_1.text_.text = var_182_27
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031044", "story_v_out_426031.awb") ~= 0 then
					local var_182_31 = manager.audio:GetVoiceLength("story_v_out_426031", "426031044", "story_v_out_426031.awb") / 1000

					if var_182_31 + var_182_23 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_31 + var_182_23
					end

					if var_182_26.prefab_name ~= "" and arg_179_1.actors_[var_182_26.prefab_name] ~= nil then
						local var_182_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_26.prefab_name].transform, "story_v_out_426031", "426031044", "story_v_out_426031.awb")

						arg_179_1:RecordAudio("426031044", var_182_32)
						arg_179_1:RecordAudio("426031044", var_182_32)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_426031", "426031044", "story_v_out_426031.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_426031", "426031044", "story_v_out_426031.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_33 = math.max(var_182_24, arg_179_1.talkMaxDuration)

			if var_182_23 <= arg_179_1.time_ and arg_179_1.time_ < var_182_23 + var_182_33 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_23) / var_182_33

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_23 + var_182_33 and arg_179_1.time_ < var_182_23 + var_182_33 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play426031045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 426031045
		arg_183_1.duration_ = 3.5

		local var_183_0 = {
			zh = 2.6,
			ja = 3.5
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
				arg_183_0:Play426031046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1012ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos1012ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(-0.7, -1.05, -6.24)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1012ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(-0.7, -1.05, -6.24)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["1012ui_story"]
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1012ui_story == nil then
				arg_183_1.var_.characterEffect1012ui_story = var_186_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 and not isNil(var_186_9) then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11

				if arg_183_1.var_.characterEffect1012ui_story and not isNil(var_186_9) then
					arg_183_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1012ui_story then
				arg_183_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_186_13 = arg_183_1.actors_["1054ui_story"]
			local var_186_14 = 0

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 and not isNil(var_186_13) and arg_183_1.var_.characterEffect1054ui_story == nil then
				arg_183_1.var_.characterEffect1054ui_story = var_186_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_15 = 0.200000002980232

			if var_186_14 <= arg_183_1.time_ and arg_183_1.time_ < var_186_14 + var_186_15 and not isNil(var_186_13) then
				local var_186_16 = (arg_183_1.time_ - var_186_14) / var_186_15

				if arg_183_1.var_.characterEffect1054ui_story and not isNil(var_186_13) then
					local var_186_17 = Mathf.Lerp(0, 0.5, var_186_16)

					arg_183_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1054ui_story.fillRatio = var_186_17
				end
			end

			if arg_183_1.time_ >= var_186_14 + var_186_15 and arg_183_1.time_ < var_186_14 + var_186_15 + arg_186_0 and not isNil(var_186_13) and arg_183_1.var_.characterEffect1054ui_story then
				local var_186_18 = 0.5

				arg_183_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1054ui_story.fillRatio = var_186_18
			end

			local var_186_19 = 0

			if var_186_19 < arg_183_1.time_ and arg_183_1.time_ <= var_186_19 + arg_186_0 then
				arg_183_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action3_1")
			end

			local var_186_20 = 0

			if var_186_20 < arg_183_1.time_ and arg_183_1.time_ <= var_186_20 + arg_186_0 then
				arg_183_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_186_21 = 0
			local var_186_22 = 0.3

			if var_186_21 < arg_183_1.time_ and arg_183_1.time_ <= var_186_21 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_23 = arg_183_1:FormatText(StoryNameCfg[595].name)

				arg_183_1.leftNameTxt_.text = var_186_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_24 = arg_183_1:GetWordFromCfg(426031045)
				local var_186_25 = arg_183_1:FormatText(var_186_24.content)

				arg_183_1.text_.text = var_186_25

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_26 = 12
				local var_186_27 = utf8.len(var_186_25)
				local var_186_28 = var_186_26 <= 0 and var_186_22 or var_186_22 * (var_186_27 / var_186_26)

				if var_186_28 > 0 and var_186_22 < var_186_28 then
					arg_183_1.talkMaxDuration = var_186_28

					if var_186_28 + var_186_21 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_28 + var_186_21
					end
				end

				arg_183_1.text_.text = var_186_25
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031045", "story_v_out_426031.awb") ~= 0 then
					local var_186_29 = manager.audio:GetVoiceLength("story_v_out_426031", "426031045", "story_v_out_426031.awb") / 1000

					if var_186_29 + var_186_21 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_29 + var_186_21
					end

					if var_186_24.prefab_name ~= "" and arg_183_1.actors_[var_186_24.prefab_name] ~= nil then
						local var_186_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_24.prefab_name].transform, "story_v_out_426031", "426031045", "story_v_out_426031.awb")

						arg_183_1:RecordAudio("426031045", var_186_30)
						arg_183_1:RecordAudio("426031045", var_186_30)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_426031", "426031045", "story_v_out_426031.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_426031", "426031045", "story_v_out_426031.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_31 = math.max(var_186_22, arg_183_1.talkMaxDuration)

			if var_186_21 <= arg_183_1.time_ and arg_183_1.time_ < var_186_21 + var_186_31 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_21) / var_186_31

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_21 + var_186_31 and arg_183_1.time_ < var_186_21 + var_186_31 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play426031046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 426031046
		arg_187_1.duration_ = 2.9

		local var_187_0 = {
			zh = 2.7,
			ja = 2.9
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
				arg_187_0:Play426031047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1012ui_story"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos1012ui_story = var_190_0.localPosition
			end

			local var_190_2 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2
				local var_190_4 = Vector3.New(-0.7, -1.05, -6.24)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1012ui_story, var_190_4, var_190_3)

				local var_190_5 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_5.x, var_190_5.y, var_190_5.z)

				local var_190_6 = var_190_0.localEulerAngles

				var_190_6.z = 0
				var_190_6.x = 0
				var_190_0.localEulerAngles = var_190_6
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(-0.7, -1.05, -6.24)

				local var_190_7 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_7.x, var_190_7.y, var_190_7.z)

				local var_190_8 = var_190_0.localEulerAngles

				var_190_8.z = 0
				var_190_8.x = 0
				var_190_0.localEulerAngles = var_190_8
			end

			local var_190_9 = 0

			if var_190_9 < arg_187_1.time_ and arg_187_1.time_ <= var_190_9 + arg_190_0 then
				arg_187_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action3_2")
			end

			local var_190_10 = 0
			local var_190_11 = 0.225

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_12 = arg_187_1:FormatText(StoryNameCfg[595].name)

				arg_187_1.leftNameTxt_.text = var_190_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_13 = arg_187_1:GetWordFromCfg(426031046)
				local var_190_14 = arg_187_1:FormatText(var_190_13.content)

				arg_187_1.text_.text = var_190_14

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_15 = 9
				local var_190_16 = utf8.len(var_190_14)
				local var_190_17 = var_190_15 <= 0 and var_190_11 or var_190_11 * (var_190_16 / var_190_15)

				if var_190_17 > 0 and var_190_11 < var_190_17 then
					arg_187_1.talkMaxDuration = var_190_17

					if var_190_17 + var_190_10 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_17 + var_190_10
					end
				end

				arg_187_1.text_.text = var_190_14
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031046", "story_v_out_426031.awb") ~= 0 then
					local var_190_18 = manager.audio:GetVoiceLength("story_v_out_426031", "426031046", "story_v_out_426031.awb") / 1000

					if var_190_18 + var_190_10 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_18 + var_190_10
					end

					if var_190_13.prefab_name ~= "" and arg_187_1.actors_[var_190_13.prefab_name] ~= nil then
						local var_190_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_13.prefab_name].transform, "story_v_out_426031", "426031046", "story_v_out_426031.awb")

						arg_187_1:RecordAudio("426031046", var_190_19)
						arg_187_1:RecordAudio("426031046", var_190_19)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_426031", "426031046", "story_v_out_426031.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_426031", "426031046", "story_v_out_426031.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_20 = math.max(var_190_11, arg_187_1.talkMaxDuration)

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_20 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_10) / var_190_20

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_10 + var_190_20 and arg_187_1.time_ < var_190_10 + var_190_20 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play426031047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 426031047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play426031048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1012ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos1012ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0, 100, 0)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1012ui_story, var_194_4, var_194_3)

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

			local var_194_9 = arg_191_1.actors_["1054ui_story"].transform
			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 then
				arg_191_1.var_.moveOldPos1054ui_story = var_194_9.localPosition

				local var_194_11 = GameObjectTools.GetOrAddComponent(var_194_9.gameObject, typeof(DynamicBoneHelper))

				if var_194_11 then
					var_194_11:EnableDynamicBone(false)
				end
			end

			local var_194_12 = 0.001

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_12 then
				local var_194_13 = (arg_191_1.time_ - var_194_10) / var_194_12
				local var_194_14 = Vector3.New(0, 100, 0)

				var_194_9.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1054ui_story, var_194_14, var_194_13)

				local var_194_15 = manager.ui.mainCamera.transform.position - var_194_9.position

				var_194_9.forward = Vector3.New(var_194_15.x, var_194_15.y, var_194_15.z)

				local var_194_16 = var_194_9.localEulerAngles

				var_194_16.z = 0
				var_194_16.x = 0
				var_194_9.localEulerAngles = var_194_16
			end

			if arg_191_1.time_ >= var_194_10 + var_194_12 and arg_191_1.time_ < var_194_10 + var_194_12 + arg_194_0 then
				var_194_9.localPosition = Vector3.New(0, 100, 0)

				local var_194_17 = manager.ui.mainCamera.transform.position - var_194_9.position

				var_194_9.forward = Vector3.New(var_194_17.x, var_194_17.y, var_194_17.z)

				local var_194_18 = var_194_9.localEulerAngles

				var_194_18.z = 0
				var_194_18.x = 0
				var_194_9.localEulerAngles = var_194_18

				local var_194_19 = GameObjectTools.GetOrAddComponent(var_194_9.gameObject, typeof(DynamicBoneHelper))

				if var_194_19 then
					var_194_19:EnableDynamicBone(true)
				end
			end

			local var_194_20 = arg_191_1.actors_["1012ui_story"]
			local var_194_21 = 0

			if var_194_21 < arg_191_1.time_ and arg_191_1.time_ <= var_194_21 + arg_194_0 and not isNil(var_194_20) and arg_191_1.var_.characterEffect1012ui_story == nil then
				arg_191_1.var_.characterEffect1012ui_story = var_194_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_22 = 0.200000002980232

			if var_194_21 <= arg_191_1.time_ and arg_191_1.time_ < var_194_21 + var_194_22 and not isNil(var_194_20) then
				local var_194_23 = (arg_191_1.time_ - var_194_21) / var_194_22

				if arg_191_1.var_.characterEffect1012ui_story and not isNil(var_194_20) then
					local var_194_24 = Mathf.Lerp(0, 0.5, var_194_23)

					arg_191_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1012ui_story.fillRatio = var_194_24
				end
			end

			if arg_191_1.time_ >= var_194_21 + var_194_22 and arg_191_1.time_ < var_194_21 + var_194_22 + arg_194_0 and not isNil(var_194_20) and arg_191_1.var_.characterEffect1012ui_story then
				local var_194_25 = 0.5

				arg_191_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1012ui_story.fillRatio = var_194_25
			end

			local var_194_26 = 0
			local var_194_27 = 0.975

			if var_194_26 < arg_191_1.time_ and arg_191_1.time_ <= var_194_26 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_28 = arg_191_1:GetWordFromCfg(426031047)
				local var_194_29 = arg_191_1:FormatText(var_194_28.content)

				arg_191_1.text_.text = var_194_29

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_30 = 39
				local var_194_31 = utf8.len(var_194_29)
				local var_194_32 = var_194_30 <= 0 and var_194_27 or var_194_27 * (var_194_31 / var_194_30)

				if var_194_32 > 0 and var_194_27 < var_194_32 then
					arg_191_1.talkMaxDuration = var_194_32

					if var_194_32 + var_194_26 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_32 + var_194_26
					end
				end

				arg_191_1.text_.text = var_194_29
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_33 = math.max(var_194_27, arg_191_1.talkMaxDuration)

			if var_194_26 <= arg_191_1.time_ and arg_191_1.time_ < var_194_26 + var_194_33 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_26) / var_194_33

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_26 + var_194_33 and arg_191_1.time_ < var_194_26 + var_194_33 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_191_1:InitPlayNodeList()
	end,
	Play426031048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 426031048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play426031049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 1.175

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[7].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(426031048)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 47
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_8 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_8 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_8

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_8 and arg_195_1.time_ < var_198_0 + var_198_8 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play426031049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 426031049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play426031050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.975

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[7].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(426031049)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 39
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_1 or var_202_1 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_1 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_8 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_8 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_8

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_8 and arg_199_1.time_ < var_202_0 + var_202_8 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play426031050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 426031050
		arg_203_1.duration_ = 4.33

		local var_203_0 = {
			zh = 3.9,
			ja = 4.333
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play426031051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["6148ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos6148ui_story = var_206_0.localPosition

				local var_206_2 = GameObjectTools.GetOrAddComponent(var_206_0.gameObject, typeof(DynamicBoneHelper))

				if var_206_2 then
					var_206_2:EnableDynamicBone(false)
				end
			end

			local var_206_3 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_3 then
				local var_206_4 = (arg_203_1.time_ - var_206_1) / var_206_3
				local var_206_5 = Vector3.New(-0.7, -0.985, -6)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos6148ui_story, var_206_5, var_206_4)

				local var_206_6 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_6.x, var_206_6.y, var_206_6.z)

				local var_206_7 = var_206_0.localEulerAngles

				var_206_7.z = 0
				var_206_7.x = 0
				var_206_0.localEulerAngles = var_206_7
			end

			if arg_203_1.time_ >= var_206_1 + var_206_3 and arg_203_1.time_ < var_206_1 + var_206_3 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_206_8 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_8.x, var_206_8.y, var_206_8.z)

				local var_206_9 = var_206_0.localEulerAngles

				var_206_9.z = 0
				var_206_9.x = 0
				var_206_0.localEulerAngles = var_206_9

				local var_206_10 = GameObjectTools.GetOrAddComponent(var_206_0.gameObject, typeof(DynamicBoneHelper))

				if var_206_10 then
					var_206_10:EnableDynamicBone(true)
				end
			end

			local var_206_11 = arg_203_1.actors_["6148ui_story"]
			local var_206_12 = 0

			if var_206_12 < arg_203_1.time_ and arg_203_1.time_ <= var_206_12 + arg_206_0 and not isNil(var_206_11) and arg_203_1.var_.characterEffect6148ui_story == nil then
				arg_203_1.var_.characterEffect6148ui_story = var_206_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_13 = 0.200000002980232

			if var_206_12 <= arg_203_1.time_ and arg_203_1.time_ < var_206_12 + var_206_13 and not isNil(var_206_11) then
				local var_206_14 = (arg_203_1.time_ - var_206_12) / var_206_13

				if arg_203_1.var_.characterEffect6148ui_story and not isNil(var_206_11) then
					arg_203_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_12 + var_206_13 and arg_203_1.time_ < var_206_12 + var_206_13 + arg_206_0 and not isNil(var_206_11) and arg_203_1.var_.characterEffect6148ui_story then
				arg_203_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_206_15 = 0

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_206_16 = 0

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 then
				arg_203_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_206_17 = 0
			local var_206_18 = 0.25

			if var_206_17 < arg_203_1.time_ and arg_203_1.time_ <= var_206_17 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_19 = arg_203_1:FormatText(StoryNameCfg[1488].name)

				arg_203_1.leftNameTxt_.text = var_206_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_20 = arg_203_1:GetWordFromCfg(426031050)
				local var_206_21 = arg_203_1:FormatText(var_206_20.content)

				arg_203_1.text_.text = var_206_21

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_22 = 10
				local var_206_23 = utf8.len(var_206_21)
				local var_206_24 = var_206_22 <= 0 and var_206_18 or var_206_18 * (var_206_23 / var_206_22)

				if var_206_24 > 0 and var_206_18 < var_206_24 then
					arg_203_1.talkMaxDuration = var_206_24

					if var_206_24 + var_206_17 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_24 + var_206_17
					end
				end

				arg_203_1.text_.text = var_206_21
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031050", "story_v_out_426031.awb") ~= 0 then
					local var_206_25 = manager.audio:GetVoiceLength("story_v_out_426031", "426031050", "story_v_out_426031.awb") / 1000

					if var_206_25 + var_206_17 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_25 + var_206_17
					end

					if var_206_20.prefab_name ~= "" and arg_203_1.actors_[var_206_20.prefab_name] ~= nil then
						local var_206_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_20.prefab_name].transform, "story_v_out_426031", "426031050", "story_v_out_426031.awb")

						arg_203_1:RecordAudio("426031050", var_206_26)
						arg_203_1:RecordAudio("426031050", var_206_26)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_426031", "426031050", "story_v_out_426031.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_426031", "426031050", "story_v_out_426031.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_27 = math.max(var_206_18, arg_203_1.talkMaxDuration)

			if var_206_17 <= arg_203_1.time_ and arg_203_1.time_ < var_206_17 + var_206_27 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_17) / var_206_27

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_17 + var_206_27 and arg_203_1.time_ < var_206_17 + var_206_27 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426031051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 426031051
		arg_207_1.duration_ = 6.83

		local var_207_0 = {
			zh = 5.233,
			ja = 6.833
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
				arg_207_0:Play426031052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1012ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1012ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(0.7, -1.05, -6.24)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1012ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0.7, -1.05, -6.24)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["1012ui_story"]
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1012ui_story == nil then
				arg_207_1.var_.characterEffect1012ui_story = var_210_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_11 = 0.200000002980232

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 and not isNil(var_210_9) then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11

				if arg_207_1.var_.characterEffect1012ui_story and not isNil(var_210_9) then
					arg_207_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1012ui_story then
				arg_207_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_210_13 = arg_207_1.actors_["6148ui_story"]
			local var_210_14 = 0

			if var_210_14 < arg_207_1.time_ and arg_207_1.time_ <= var_210_14 + arg_210_0 and not isNil(var_210_13) and arg_207_1.var_.characterEffect6148ui_story == nil then
				arg_207_1.var_.characterEffect6148ui_story = var_210_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_15 = 0.200000002980232

			if var_210_14 <= arg_207_1.time_ and arg_207_1.time_ < var_210_14 + var_210_15 and not isNil(var_210_13) then
				local var_210_16 = (arg_207_1.time_ - var_210_14) / var_210_15

				if arg_207_1.var_.characterEffect6148ui_story and not isNil(var_210_13) then
					local var_210_17 = Mathf.Lerp(0, 0.5, var_210_16)

					arg_207_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_207_1.var_.characterEffect6148ui_story.fillRatio = var_210_17
				end
			end

			if arg_207_1.time_ >= var_210_14 + var_210_15 and arg_207_1.time_ < var_210_14 + var_210_15 + arg_210_0 and not isNil(var_210_13) and arg_207_1.var_.characterEffect6148ui_story then
				local var_210_18 = 0.5

				arg_207_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_207_1.var_.characterEffect6148ui_story.fillRatio = var_210_18
			end

			local var_210_19 = 0

			if var_210_19 < arg_207_1.time_ and arg_207_1.time_ <= var_210_19 + arg_210_0 then
				arg_207_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_210_20 = 0

			if var_210_20 < arg_207_1.time_ and arg_207_1.time_ <= var_210_20 + arg_210_0 then
				arg_207_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_210_21 = 0
			local var_210_22 = 0.55

			if var_210_21 < arg_207_1.time_ and arg_207_1.time_ <= var_210_21 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_23 = arg_207_1:FormatText(StoryNameCfg[595].name)

				arg_207_1.leftNameTxt_.text = var_210_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_24 = arg_207_1:GetWordFromCfg(426031051)
				local var_210_25 = arg_207_1:FormatText(var_210_24.content)

				arg_207_1.text_.text = var_210_25

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_26 = 22
				local var_210_27 = utf8.len(var_210_25)
				local var_210_28 = var_210_26 <= 0 and var_210_22 or var_210_22 * (var_210_27 / var_210_26)

				if var_210_28 > 0 and var_210_22 < var_210_28 then
					arg_207_1.talkMaxDuration = var_210_28

					if var_210_28 + var_210_21 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_28 + var_210_21
					end
				end

				arg_207_1.text_.text = var_210_25
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031051", "story_v_out_426031.awb") ~= 0 then
					local var_210_29 = manager.audio:GetVoiceLength("story_v_out_426031", "426031051", "story_v_out_426031.awb") / 1000

					if var_210_29 + var_210_21 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_29 + var_210_21
					end

					if var_210_24.prefab_name ~= "" and arg_207_1.actors_[var_210_24.prefab_name] ~= nil then
						local var_210_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_24.prefab_name].transform, "story_v_out_426031", "426031051", "story_v_out_426031.awb")

						arg_207_1:RecordAudio("426031051", var_210_30)
						arg_207_1:RecordAudio("426031051", var_210_30)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_426031", "426031051", "story_v_out_426031.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_426031", "426031051", "story_v_out_426031.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_31 = math.max(var_210_22, arg_207_1.talkMaxDuration)

			if var_210_21 <= arg_207_1.time_ and arg_207_1.time_ < var_210_21 + var_210_31 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_21) / var_210_31

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_21 + var_210_31 and arg_207_1.time_ < var_210_21 + var_210_31 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play426031052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 426031052
		arg_211_1.duration_ = 10.53

		local var_211_0 = {
			zh = 8.4,
			ja = 10.533
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
				arg_211_0:Play426031053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 1.2

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[595].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_3 = arg_211_1:GetWordFromCfg(426031052)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 48
				local var_214_6 = utf8.len(var_214_4)
				local var_214_7 = var_214_5 <= 0 and var_214_1 or var_214_1 * (var_214_6 / var_214_5)

				if var_214_7 > 0 and var_214_1 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_4
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031052", "story_v_out_426031.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_426031", "426031052", "story_v_out_426031.awb") / 1000

					if var_214_8 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_0
					end

					if var_214_3.prefab_name ~= "" and arg_211_1.actors_[var_214_3.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_3.prefab_name].transform, "story_v_out_426031", "426031052", "story_v_out_426031.awb")

						arg_211_1:RecordAudio("426031052", var_214_9)
						arg_211_1:RecordAudio("426031052", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_426031", "426031052", "story_v_out_426031.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_426031", "426031052", "story_v_out_426031.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_10 and arg_211_1.time_ < var_214_0 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play426031053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 426031053
		arg_215_1.duration_ = 2.1

		local var_215_0 = {
			zh = 1.999999999999,
			ja = 2.1
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
				arg_215_0:Play426031054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["6148ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos6148ui_story = var_218_0.localPosition

				local var_218_2 = GameObjectTools.GetOrAddComponent(var_218_0.gameObject, typeof(DynamicBoneHelper))

				if var_218_2 then
					var_218_2:EnableDynamicBone(false)
				end
			end

			local var_218_3 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_3 then
				local var_218_4 = (arg_215_1.time_ - var_218_1) / var_218_3
				local var_218_5 = Vector3.New(-0.7, -0.985, -6)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos6148ui_story, var_218_5, var_218_4)

				local var_218_6 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_6.x, var_218_6.y, var_218_6.z)

				local var_218_7 = var_218_0.localEulerAngles

				var_218_7.z = 0
				var_218_7.x = 0
				var_218_0.localEulerAngles = var_218_7
			end

			if arg_215_1.time_ >= var_218_1 + var_218_3 and arg_215_1.time_ < var_218_1 + var_218_3 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_218_8 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_8.x, var_218_8.y, var_218_8.z)

				local var_218_9 = var_218_0.localEulerAngles

				var_218_9.z = 0
				var_218_9.x = 0
				var_218_0.localEulerAngles = var_218_9

				local var_218_10 = GameObjectTools.GetOrAddComponent(var_218_0.gameObject, typeof(DynamicBoneHelper))

				if var_218_10 then
					var_218_10:EnableDynamicBone(true)
				end
			end

			local var_218_11 = arg_215_1.actors_["6148ui_story"]
			local var_218_12 = 0

			if var_218_12 < arg_215_1.time_ and arg_215_1.time_ <= var_218_12 + arg_218_0 and not isNil(var_218_11) and arg_215_1.var_.characterEffect6148ui_story == nil then
				arg_215_1.var_.characterEffect6148ui_story = var_218_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_13 = 0.200000002980232

			if var_218_12 <= arg_215_1.time_ and arg_215_1.time_ < var_218_12 + var_218_13 and not isNil(var_218_11) then
				local var_218_14 = (arg_215_1.time_ - var_218_12) / var_218_13

				if arg_215_1.var_.characterEffect6148ui_story and not isNil(var_218_11) then
					arg_215_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_12 + var_218_13 and arg_215_1.time_ < var_218_12 + var_218_13 + arg_218_0 and not isNil(var_218_11) and arg_215_1.var_.characterEffect6148ui_story then
				arg_215_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_218_15 = arg_215_1.actors_["1012ui_story"]
			local var_218_16 = 0

			if var_218_16 < arg_215_1.time_ and arg_215_1.time_ <= var_218_16 + arg_218_0 and not isNil(var_218_15) and arg_215_1.var_.characterEffect1012ui_story == nil then
				arg_215_1.var_.characterEffect1012ui_story = var_218_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_17 = 0.200000002980232

			if var_218_16 <= arg_215_1.time_ and arg_215_1.time_ < var_218_16 + var_218_17 and not isNil(var_218_15) then
				local var_218_18 = (arg_215_1.time_ - var_218_16) / var_218_17

				if arg_215_1.var_.characterEffect1012ui_story and not isNil(var_218_15) then
					local var_218_19 = Mathf.Lerp(0, 0.5, var_218_18)

					arg_215_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1012ui_story.fillRatio = var_218_19
				end
			end

			if arg_215_1.time_ >= var_218_16 + var_218_17 and arg_215_1.time_ < var_218_16 + var_218_17 + arg_218_0 and not isNil(var_218_15) and arg_215_1.var_.characterEffect1012ui_story then
				local var_218_20 = 0.5

				arg_215_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1012ui_story.fillRatio = var_218_20
			end

			local var_218_21 = 0

			if var_218_21 < arg_215_1.time_ and arg_215_1.time_ <= var_218_21 + arg_218_0 then
				arg_215_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_218_22 = 0

			if var_218_22 < arg_215_1.time_ and arg_215_1.time_ <= var_218_22 + arg_218_0 then
				arg_215_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_218_23 = 0
			local var_218_24 = 0.15

			if var_218_23 < arg_215_1.time_ and arg_215_1.time_ <= var_218_23 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_25 = arg_215_1:FormatText(StoryNameCfg[1488].name)

				arg_215_1.leftNameTxt_.text = var_218_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_26 = arg_215_1:GetWordFromCfg(426031053)
				local var_218_27 = arg_215_1:FormatText(var_218_26.content)

				arg_215_1.text_.text = var_218_27

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_28 = 6
				local var_218_29 = utf8.len(var_218_27)
				local var_218_30 = var_218_28 <= 0 and var_218_24 or var_218_24 * (var_218_29 / var_218_28)

				if var_218_30 > 0 and var_218_24 < var_218_30 then
					arg_215_1.talkMaxDuration = var_218_30

					if var_218_30 + var_218_23 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_30 + var_218_23
					end
				end

				arg_215_1.text_.text = var_218_27
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031053", "story_v_out_426031.awb") ~= 0 then
					local var_218_31 = manager.audio:GetVoiceLength("story_v_out_426031", "426031053", "story_v_out_426031.awb") / 1000

					if var_218_31 + var_218_23 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_31 + var_218_23
					end

					if var_218_26.prefab_name ~= "" and arg_215_1.actors_[var_218_26.prefab_name] ~= nil then
						local var_218_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_26.prefab_name].transform, "story_v_out_426031", "426031053", "story_v_out_426031.awb")

						arg_215_1:RecordAudio("426031053", var_218_32)
						arg_215_1:RecordAudio("426031053", var_218_32)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_426031", "426031053", "story_v_out_426031.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_426031", "426031053", "story_v_out_426031.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_33 = math.max(var_218_24, arg_215_1.talkMaxDuration)

			if var_218_23 <= arg_215_1.time_ and arg_215_1.time_ < var_218_23 + var_218_33 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_23) / var_218_33

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_23 + var_218_33 and arg_215_1.time_ < var_218_23 + var_218_33 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play426031054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 426031054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play426031055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["6148ui_story"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect6148ui_story == nil then
				arg_219_1.var_.characterEffect6148ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.characterEffect6148ui_story and not isNil(var_222_0) then
					local var_222_4 = Mathf.Lerp(0, 0.5, var_222_3)

					arg_219_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_219_1.var_.characterEffect6148ui_story.fillRatio = var_222_4
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect6148ui_story then
				local var_222_5 = 0.5

				arg_219_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_219_1.var_.characterEffect6148ui_story.fillRatio = var_222_5
			end

			local var_222_6 = 0
			local var_222_7 = 0.3

			if var_222_6 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_8 = arg_219_1:FormatText(StoryNameCfg[7].name)

				arg_219_1.leftNameTxt_.text = var_222_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_9 = arg_219_1:GetWordFromCfg(426031054)
				local var_222_10 = arg_219_1:FormatText(var_222_9.content)

				arg_219_1.text_.text = var_222_10

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 12
				local var_222_12 = utf8.len(var_222_10)
				local var_222_13 = var_222_11 <= 0 and var_222_7 or var_222_7 * (var_222_12 / var_222_11)

				if var_222_13 > 0 and var_222_7 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13

					if var_222_13 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_10
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_14 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_14 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_14

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_14 and arg_219_1.time_ < var_222_6 + var_222_14 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play426031055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 426031055
		arg_223_1.duration_ = 8.47

		local var_223_0 = {
			zh = 5.266,
			ja = 8.466
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
				arg_223_0:Play426031056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1012ui_story"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos1012ui_story = var_226_0.localPosition
			end

			local var_226_2 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2
				local var_226_4 = Vector3.New(0.7, -1.05, -6.24)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1012ui_story, var_226_4, var_226_3)

				local var_226_5 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_5.x, var_226_5.y, var_226_5.z)

				local var_226_6 = var_226_0.localEulerAngles

				var_226_6.z = 0
				var_226_6.x = 0
				var_226_0.localEulerAngles = var_226_6
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0.7, -1.05, -6.24)

				local var_226_7 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_7.x, var_226_7.y, var_226_7.z)

				local var_226_8 = var_226_0.localEulerAngles

				var_226_8.z = 0
				var_226_8.x = 0
				var_226_0.localEulerAngles = var_226_8
			end

			local var_226_9 = arg_223_1.actors_["1012ui_story"]
			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1012ui_story == nil then
				arg_223_1.var_.characterEffect1012ui_story = var_226_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_11 = 0.200000002980232

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_11 and not isNil(var_226_9) then
				local var_226_12 = (arg_223_1.time_ - var_226_10) / var_226_11

				if arg_223_1.var_.characterEffect1012ui_story and not isNil(var_226_9) then
					arg_223_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_10 + var_226_11 and arg_223_1.time_ < var_226_10 + var_226_11 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1012ui_story then
				arg_223_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_226_13 = 0

			if var_226_13 < arg_223_1.time_ and arg_223_1.time_ <= var_226_13 + arg_226_0 then
				arg_223_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_226_14 = 0

			if var_226_14 < arg_223_1.time_ and arg_223_1.time_ <= var_226_14 + arg_226_0 then
				arg_223_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_226_15 = 0
			local var_226_16 = 0.7

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_17 = arg_223_1:FormatText(StoryNameCfg[595].name)

				arg_223_1.leftNameTxt_.text = var_226_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_18 = arg_223_1:GetWordFromCfg(426031055)
				local var_226_19 = arg_223_1:FormatText(var_226_18.content)

				arg_223_1.text_.text = var_226_19

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_20 = 28
				local var_226_21 = utf8.len(var_226_19)
				local var_226_22 = var_226_20 <= 0 and var_226_16 or var_226_16 * (var_226_21 / var_226_20)

				if var_226_22 > 0 and var_226_16 < var_226_22 then
					arg_223_1.talkMaxDuration = var_226_22

					if var_226_22 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_22 + var_226_15
					end
				end

				arg_223_1.text_.text = var_226_19
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031055", "story_v_out_426031.awb") ~= 0 then
					local var_226_23 = manager.audio:GetVoiceLength("story_v_out_426031", "426031055", "story_v_out_426031.awb") / 1000

					if var_226_23 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_15
					end

					if var_226_18.prefab_name ~= "" and arg_223_1.actors_[var_226_18.prefab_name] ~= nil then
						local var_226_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_18.prefab_name].transform, "story_v_out_426031", "426031055", "story_v_out_426031.awb")

						arg_223_1:RecordAudio("426031055", var_226_24)
						arg_223_1:RecordAudio("426031055", var_226_24)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_426031", "426031055", "story_v_out_426031.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_426031", "426031055", "story_v_out_426031.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_25 = math.max(var_226_16, arg_223_1.talkMaxDuration)

			if var_226_15 <= arg_223_1.time_ and arg_223_1.time_ < var_226_15 + var_226_25 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_15) / var_226_25

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_15 + var_226_25 and arg_223_1.time_ < var_226_15 + var_226_25 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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

		arg_223_1:InitPlayNodeList()
	end,
	Play426031056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 426031056
		arg_227_1.duration_ = 8.77

		local var_227_0 = {
			zh = 5.066,
			ja = 8.766
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
				arg_227_0:Play426031057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action2_1")
			end

			local var_230_1 = 0
			local var_230_2 = 0.725

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_3 = arg_227_1:FormatText(StoryNameCfg[595].name)

				arg_227_1.leftNameTxt_.text = var_230_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_4 = arg_227_1:GetWordFromCfg(426031056)
				local var_230_5 = arg_227_1:FormatText(var_230_4.content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_6 = 29
				local var_230_7 = utf8.len(var_230_5)
				local var_230_8 = var_230_6 <= 0 and var_230_2 or var_230_2 * (var_230_7 / var_230_6)

				if var_230_8 > 0 and var_230_2 < var_230_8 then
					arg_227_1.talkMaxDuration = var_230_8

					if var_230_8 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031056", "story_v_out_426031.awb") ~= 0 then
					local var_230_9 = manager.audio:GetVoiceLength("story_v_out_426031", "426031056", "story_v_out_426031.awb") / 1000

					if var_230_9 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_1
					end

					if var_230_4.prefab_name ~= "" and arg_227_1.actors_[var_230_4.prefab_name] ~= nil then
						local var_230_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_4.prefab_name].transform, "story_v_out_426031", "426031056", "story_v_out_426031.awb")

						arg_227_1:RecordAudio("426031056", var_230_10)
						arg_227_1:RecordAudio("426031056", var_230_10)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_426031", "426031056", "story_v_out_426031.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_426031", "426031056", "story_v_out_426031.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_11 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_11 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_11

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_11 and arg_227_1.time_ < var_230_1 + var_230_11 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play426031057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 426031057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play426031058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1012ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1012ui_story == nil then
				arg_231_1.var_.characterEffect1012ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1012ui_story and not isNil(var_234_0) then
					local var_234_4 = Mathf.Lerp(0, 0.5, var_234_3)

					arg_231_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1012ui_story.fillRatio = var_234_4
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1012ui_story then
				local var_234_5 = 0.5

				arg_231_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1012ui_story.fillRatio = var_234_5
			end

			local var_234_6 = 0
			local var_234_7 = 0.425

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

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_9 = arg_231_1:GetWordFromCfg(426031057)
				local var_234_10 = arg_231_1:FormatText(var_234_9.content)

				arg_231_1.text_.text = var_234_10

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_11 = 17
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
	Play426031058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 426031058
		arg_235_1.duration_ = 2

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play426031059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1054ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos1054ui_story = var_238_0.localPosition

				local var_238_2 = GameObjectTools.GetOrAddComponent(var_238_0.gameObject, typeof(DynamicBoneHelper))

				if var_238_2 then
					var_238_2:EnableDynamicBone(false)
				end
			end

			local var_238_3 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_3 then
				local var_238_4 = (arg_235_1.time_ - var_238_1) / var_238_3
				local var_238_5 = Vector3.New(0.7, -0.985, -6)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1054ui_story, var_238_5, var_238_4)

				local var_238_6 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_6.x, var_238_6.y, var_238_6.z)

				local var_238_7 = var_238_0.localEulerAngles

				var_238_7.z = 0
				var_238_7.x = 0
				var_238_0.localEulerAngles = var_238_7
			end

			if arg_235_1.time_ >= var_238_1 + var_238_3 and arg_235_1.time_ < var_238_1 + var_238_3 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_238_8 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_8.x, var_238_8.y, var_238_8.z)

				local var_238_9 = var_238_0.localEulerAngles

				var_238_9.z = 0
				var_238_9.x = 0
				var_238_0.localEulerAngles = var_238_9

				local var_238_10 = GameObjectTools.GetOrAddComponent(var_238_0.gameObject, typeof(DynamicBoneHelper))

				if var_238_10 then
					var_238_10:EnableDynamicBone(true)
				end
			end

			local var_238_11 = arg_235_1.actors_["1012ui_story"].transform
			local var_238_12 = 0

			if var_238_12 < arg_235_1.time_ and arg_235_1.time_ <= var_238_12 + arg_238_0 then
				arg_235_1.var_.moveOldPos1012ui_story = var_238_11.localPosition
			end

			local var_238_13 = 0.001

			if var_238_12 <= arg_235_1.time_ and arg_235_1.time_ < var_238_12 + var_238_13 then
				local var_238_14 = (arg_235_1.time_ - var_238_12) / var_238_13
				local var_238_15 = Vector3.New(0, 100, 0)

				var_238_11.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1012ui_story, var_238_15, var_238_14)

				local var_238_16 = manager.ui.mainCamera.transform.position - var_238_11.position

				var_238_11.forward = Vector3.New(var_238_16.x, var_238_16.y, var_238_16.z)

				local var_238_17 = var_238_11.localEulerAngles

				var_238_17.z = 0
				var_238_17.x = 0
				var_238_11.localEulerAngles = var_238_17
			end

			if arg_235_1.time_ >= var_238_12 + var_238_13 and arg_235_1.time_ < var_238_12 + var_238_13 + arg_238_0 then
				var_238_11.localPosition = Vector3.New(0, 100, 0)

				local var_238_18 = manager.ui.mainCamera.transform.position - var_238_11.position

				var_238_11.forward = Vector3.New(var_238_18.x, var_238_18.y, var_238_18.z)

				local var_238_19 = var_238_11.localEulerAngles

				var_238_19.z = 0
				var_238_19.x = 0
				var_238_11.localEulerAngles = var_238_19
			end

			local var_238_20 = arg_235_1.actors_["1054ui_story"]
			local var_238_21 = 0

			if var_238_21 < arg_235_1.time_ and arg_235_1.time_ <= var_238_21 + arg_238_0 and not isNil(var_238_20) and arg_235_1.var_.characterEffect1054ui_story == nil then
				arg_235_1.var_.characterEffect1054ui_story = var_238_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_22 = 0.200000002980232

			if var_238_21 <= arg_235_1.time_ and arg_235_1.time_ < var_238_21 + var_238_22 and not isNil(var_238_20) then
				local var_238_23 = (arg_235_1.time_ - var_238_21) / var_238_22

				if arg_235_1.var_.characterEffect1054ui_story and not isNil(var_238_20) then
					arg_235_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_21 + var_238_22 and arg_235_1.time_ < var_238_21 + var_238_22 + arg_238_0 and not isNil(var_238_20) and arg_235_1.var_.characterEffect1054ui_story then
				arg_235_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_238_24 = 0

			if var_238_24 < arg_235_1.time_ and arg_235_1.time_ <= var_238_24 + arg_238_0 then
				arg_235_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			local var_238_25 = 0

			if var_238_25 < arg_235_1.time_ and arg_235_1.time_ <= var_238_25 + arg_238_0 then
				arg_235_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_238_26 = 0
			local var_238_27 = 0.15

			if var_238_26 < arg_235_1.time_ and arg_235_1.time_ <= var_238_26 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_28 = arg_235_1:FormatText(StoryNameCfg[1487].name)

				arg_235_1.leftNameTxt_.text = var_238_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_29 = arg_235_1:GetWordFromCfg(426031058)
				local var_238_30 = arg_235_1:FormatText(var_238_29.content)

				arg_235_1.text_.text = var_238_30

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_31 = 6
				local var_238_32 = utf8.len(var_238_30)
				local var_238_33 = var_238_31 <= 0 and var_238_27 or var_238_27 * (var_238_32 / var_238_31)

				if var_238_33 > 0 and var_238_27 < var_238_33 then
					arg_235_1.talkMaxDuration = var_238_33

					if var_238_33 + var_238_26 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_33 + var_238_26
					end
				end

				arg_235_1.text_.text = var_238_30
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031058", "story_v_out_426031.awb") ~= 0 then
					local var_238_34 = manager.audio:GetVoiceLength("story_v_out_426031", "426031058", "story_v_out_426031.awb") / 1000

					if var_238_34 + var_238_26 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_34 + var_238_26
					end

					if var_238_29.prefab_name ~= "" and arg_235_1.actors_[var_238_29.prefab_name] ~= nil then
						local var_238_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_29.prefab_name].transform, "story_v_out_426031", "426031058", "story_v_out_426031.awb")

						arg_235_1:RecordAudio("426031058", var_238_35)
						arg_235_1:RecordAudio("426031058", var_238_35)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_426031", "426031058", "story_v_out_426031.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_426031", "426031058", "story_v_out_426031.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_36 = math.max(var_238_27, arg_235_1.talkMaxDuration)

			if var_238_26 <= arg_235_1.time_ and arg_235_1.time_ < var_238_26 + var_238_36 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_26) / var_238_36

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_26 + var_238_36 and arg_235_1.time_ < var_238_26 + var_238_36 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
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
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play426031059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 426031059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play426031060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1054ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1054ui_story = var_242_0.localPosition

				local var_242_2 = GameObjectTools.GetOrAddComponent(var_242_0.gameObject, typeof(DynamicBoneHelper))

				if var_242_2 then
					var_242_2:EnableDynamicBone(false)
				end
			end

			local var_242_3 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_3 then
				local var_242_4 = (arg_239_1.time_ - var_242_1) / var_242_3
				local var_242_5 = Vector3.New(0, 100, 0)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1054ui_story, var_242_5, var_242_4)

				local var_242_6 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_6.x, var_242_6.y, var_242_6.z)

				local var_242_7 = var_242_0.localEulerAngles

				var_242_7.z = 0
				var_242_7.x = 0
				var_242_0.localEulerAngles = var_242_7
			end

			if arg_239_1.time_ >= var_242_1 + var_242_3 and arg_239_1.time_ < var_242_1 + var_242_3 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, 100, 0)

				local var_242_8 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_8.x, var_242_8.y, var_242_8.z)

				local var_242_9 = var_242_0.localEulerAngles

				var_242_9.z = 0
				var_242_9.x = 0
				var_242_0.localEulerAngles = var_242_9

				local var_242_10 = GameObjectTools.GetOrAddComponent(var_242_0.gameObject, typeof(DynamicBoneHelper))

				if var_242_10 then
					var_242_10:EnableDynamicBone(true)
				end
			end

			local var_242_11 = arg_239_1.actors_["1054ui_story"]
			local var_242_12 = 0

			if var_242_12 < arg_239_1.time_ and arg_239_1.time_ <= var_242_12 + arg_242_0 and not isNil(var_242_11) and arg_239_1.var_.characterEffect1054ui_story == nil then
				arg_239_1.var_.characterEffect1054ui_story = var_242_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_13 = 0.200000002980232

			if var_242_12 <= arg_239_1.time_ and arg_239_1.time_ < var_242_12 + var_242_13 and not isNil(var_242_11) then
				local var_242_14 = (arg_239_1.time_ - var_242_12) / var_242_13

				if arg_239_1.var_.characterEffect1054ui_story and not isNil(var_242_11) then
					local var_242_15 = Mathf.Lerp(0, 0.5, var_242_14)

					arg_239_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1054ui_story.fillRatio = var_242_15
				end
			end

			if arg_239_1.time_ >= var_242_12 + var_242_13 and arg_239_1.time_ < var_242_12 + var_242_13 + arg_242_0 and not isNil(var_242_11) and arg_239_1.var_.characterEffect1054ui_story then
				local var_242_16 = 0.5

				arg_239_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1054ui_story.fillRatio = var_242_16
			end

			local var_242_17 = arg_239_1.actors_["6148ui_story"].transform
			local var_242_18 = 0

			if var_242_18 < arg_239_1.time_ and arg_239_1.time_ <= var_242_18 + arg_242_0 then
				arg_239_1.var_.moveOldPos6148ui_story = var_242_17.localPosition

				local var_242_19 = GameObjectTools.GetOrAddComponent(var_242_17.gameObject, typeof(DynamicBoneHelper))

				if var_242_19 then
					var_242_19:EnableDynamicBone(false)
				end
			end

			local var_242_20 = 0.001

			if var_242_18 <= arg_239_1.time_ and arg_239_1.time_ < var_242_18 + var_242_20 then
				local var_242_21 = (arg_239_1.time_ - var_242_18) / var_242_20
				local var_242_22 = Vector3.New(0, 100, 0)

				var_242_17.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos6148ui_story, var_242_22, var_242_21)

				local var_242_23 = manager.ui.mainCamera.transform.position - var_242_17.position

				var_242_17.forward = Vector3.New(var_242_23.x, var_242_23.y, var_242_23.z)

				local var_242_24 = var_242_17.localEulerAngles

				var_242_24.z = 0
				var_242_24.x = 0
				var_242_17.localEulerAngles = var_242_24
			end

			if arg_239_1.time_ >= var_242_18 + var_242_20 and arg_239_1.time_ < var_242_18 + var_242_20 + arg_242_0 then
				var_242_17.localPosition = Vector3.New(0, 100, 0)

				local var_242_25 = manager.ui.mainCamera.transform.position - var_242_17.position

				var_242_17.forward = Vector3.New(var_242_25.x, var_242_25.y, var_242_25.z)

				local var_242_26 = var_242_17.localEulerAngles

				var_242_26.z = 0
				var_242_26.x = 0
				var_242_17.localEulerAngles = var_242_26

				local var_242_27 = GameObjectTools.GetOrAddComponent(var_242_17.gameObject, typeof(DynamicBoneHelper))

				if var_242_27 then
					var_242_27:EnableDynamicBone(true)
				end
			end

			local var_242_28 = 0
			local var_242_29 = 0.8

			if var_242_28 < arg_239_1.time_ and arg_239_1.time_ <= var_242_28 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_30 = arg_239_1:GetWordFromCfg(426031059)
				local var_242_31 = arg_239_1:FormatText(var_242_30.content)

				arg_239_1.text_.text = var_242_31

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_32 = 32
				local var_242_33 = utf8.len(var_242_31)
				local var_242_34 = var_242_32 <= 0 and var_242_29 or var_242_29 * (var_242_33 / var_242_32)

				if var_242_34 > 0 and var_242_29 < var_242_34 then
					arg_239_1.talkMaxDuration = var_242_34

					if var_242_34 + var_242_28 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_34 + var_242_28
					end
				end

				arg_239_1.text_.text = var_242_31
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_35 = math.max(var_242_29, arg_239_1.talkMaxDuration)

			if var_242_28 <= arg_239_1.time_ and arg_239_1.time_ < var_242_28 + var_242_35 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_28) / var_242_35

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_28 + var_242_35 and arg_239_1.time_ < var_242_28 + var_242_35 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
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
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play426031060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 426031060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play426031061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.2

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[7].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:GetWordFromCfg(426031060)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 8
				local var_246_6 = utf8.len(var_246_4)
				local var_246_7 = var_246_5 <= 0 and var_246_1 or var_246_1 * (var_246_6 / var_246_5)

				if var_246_7 > 0 and var_246_1 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_8 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_8 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_8

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_8 and arg_243_1.time_ < var_246_0 + var_246_8 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play426031061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 426031061
		arg_247_1.duration_ = 2

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play426031062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1012ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos1012ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(0, -1.05, -6.24)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1012ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["1012ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1012ui_story == nil then
				arg_247_1.var_.characterEffect1012ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect1012ui_story and not isNil(var_250_9) then
					arg_247_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1012ui_story then
				arg_247_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_250_13 = 0

			if var_250_13 < arg_247_1.time_ and arg_247_1.time_ <= var_250_13 + arg_250_0 then
				arg_247_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_250_14 = 0

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				arg_247_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_250_15 = 0
			local var_250_16 = 0.1

			if var_250_15 < arg_247_1.time_ and arg_247_1.time_ <= var_250_15 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_17 = arg_247_1:FormatText(StoryNameCfg[595].name)

				arg_247_1.leftNameTxt_.text = var_250_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_18 = arg_247_1:GetWordFromCfg(426031061)
				local var_250_19 = arg_247_1:FormatText(var_250_18.content)

				arg_247_1.text_.text = var_250_19

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_20 = 4
				local var_250_21 = utf8.len(var_250_19)
				local var_250_22 = var_250_20 <= 0 and var_250_16 or var_250_16 * (var_250_21 / var_250_20)

				if var_250_22 > 0 and var_250_16 < var_250_22 then
					arg_247_1.talkMaxDuration = var_250_22

					if var_250_22 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_22 + var_250_15
					end
				end

				arg_247_1.text_.text = var_250_19
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031061", "story_v_out_426031.awb") ~= 0 then
					local var_250_23 = manager.audio:GetVoiceLength("story_v_out_426031", "426031061", "story_v_out_426031.awb") / 1000

					if var_250_23 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_23 + var_250_15
					end

					if var_250_18.prefab_name ~= "" and arg_247_1.actors_[var_250_18.prefab_name] ~= nil then
						local var_250_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_18.prefab_name].transform, "story_v_out_426031", "426031061", "story_v_out_426031.awb")

						arg_247_1:RecordAudio("426031061", var_250_24)
						arg_247_1:RecordAudio("426031061", var_250_24)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_426031", "426031061", "story_v_out_426031.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_426031", "426031061", "story_v_out_426031.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_25 = math.max(var_250_16, arg_247_1.talkMaxDuration)

			if var_250_15 <= arg_247_1.time_ and arg_247_1.time_ < var_250_15 + var_250_25 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_15) / var_250_25

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_15 + var_250_25 and arg_247_1.time_ < var_250_15 + var_250_25 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
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

		arg_247_1:InitPlayNodeList()
	end,
	Play426031062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 426031062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play426031063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1012ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1012ui_story == nil then
				arg_251_1.var_.characterEffect1012ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect1012ui_story and not isNil(var_254_0) then
					local var_254_4 = Mathf.Lerp(0, 0.5, var_254_3)

					arg_251_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1012ui_story.fillRatio = var_254_4
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1012ui_story then
				local var_254_5 = 0.5

				arg_251_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1012ui_story.fillRatio = var_254_5
			end

			local var_254_6 = 0
			local var_254_7 = 0.25

			if var_254_6 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_8 = arg_251_1:FormatText(StoryNameCfg[7].name)

				arg_251_1.leftNameTxt_.text = var_254_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_9 = arg_251_1:GetWordFromCfg(426031062)
				local var_254_10 = arg_251_1:FormatText(var_254_9.content)

				arg_251_1.text_.text = var_254_10

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 10
				local var_254_12 = utf8.len(var_254_10)
				local var_254_13 = var_254_11 <= 0 and var_254_7 or var_254_7 * (var_254_12 / var_254_11)

				if var_254_13 > 0 and var_254_7 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13

					if var_254_13 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_10
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_14 = math.max(var_254_7, arg_251_1.talkMaxDuration)

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_14 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_6) / var_254_14

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_6 + var_254_14 and arg_251_1.time_ < var_254_6 + var_254_14 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play426031063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 426031063
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play426031064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.8

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_2 = arg_255_1:GetWordFromCfg(426031063)
				local var_258_3 = arg_255_1:FormatText(var_258_2.content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 32
				local var_258_5 = utf8.len(var_258_3)
				local var_258_6 = var_258_4 <= 0 and var_258_1 or var_258_1 * (var_258_5 / var_258_4)

				if var_258_6 > 0 and var_258_1 < var_258_6 then
					arg_255_1.talkMaxDuration = var_258_6

					if var_258_6 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_6 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_7 and arg_255_1.time_ < var_258_0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play426031064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 426031064
		arg_259_1.duration_ = 7.83

		local var_259_0 = {
			zh = 4.266,
			ja = 7.833
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play426031065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1012ui_story"].transform
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.var_.moveOldPos1012ui_story = var_262_0.localPosition
			end

			local var_262_2 = 0.001

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2
				local var_262_4 = Vector3.New(0, -1.05, -6.24)

				var_262_0.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1012ui_story, var_262_4, var_262_3)

				local var_262_5 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_5.x, var_262_5.y, var_262_5.z)

				local var_262_6 = var_262_0.localEulerAngles

				var_262_6.z = 0
				var_262_6.x = 0
				var_262_0.localEulerAngles = var_262_6
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 then
				var_262_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_262_7 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_7.x, var_262_7.y, var_262_7.z)

				local var_262_8 = var_262_0.localEulerAngles

				var_262_8.z = 0
				var_262_8.x = 0
				var_262_0.localEulerAngles = var_262_8
			end

			local var_262_9 = arg_259_1.actors_["1012ui_story"]
			local var_262_10 = 0

			if var_262_10 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 and not isNil(var_262_9) and arg_259_1.var_.characterEffect1012ui_story == nil then
				arg_259_1.var_.characterEffect1012ui_story = var_262_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_11 = 0.200000002980232

			if var_262_10 <= arg_259_1.time_ and arg_259_1.time_ < var_262_10 + var_262_11 and not isNil(var_262_9) then
				local var_262_12 = (arg_259_1.time_ - var_262_10) / var_262_11

				if arg_259_1.var_.characterEffect1012ui_story and not isNil(var_262_9) then
					arg_259_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_10 + var_262_11 and arg_259_1.time_ < var_262_10 + var_262_11 + arg_262_0 and not isNil(var_262_9) and arg_259_1.var_.characterEffect1012ui_story then
				arg_259_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_262_13 = 0

			if var_262_13 < arg_259_1.time_ and arg_259_1.time_ <= var_262_13 + arg_262_0 then
				arg_259_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_262_14 = 0

			if var_262_14 < arg_259_1.time_ and arg_259_1.time_ <= var_262_14 + arg_262_0 then
				arg_259_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_262_15 = 0
			local var_262_16 = 0.425

			if var_262_15 < arg_259_1.time_ and arg_259_1.time_ <= var_262_15 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_17 = arg_259_1:FormatText(StoryNameCfg[595].name)

				arg_259_1.leftNameTxt_.text = var_262_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_18 = arg_259_1:GetWordFromCfg(426031064)
				local var_262_19 = arg_259_1:FormatText(var_262_18.content)

				arg_259_1.text_.text = var_262_19

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_20 = 17
				local var_262_21 = utf8.len(var_262_19)
				local var_262_22 = var_262_20 <= 0 and var_262_16 or var_262_16 * (var_262_21 / var_262_20)

				if var_262_22 > 0 and var_262_16 < var_262_22 then
					arg_259_1.talkMaxDuration = var_262_22

					if var_262_22 + var_262_15 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_22 + var_262_15
					end
				end

				arg_259_1.text_.text = var_262_19
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031064", "story_v_out_426031.awb") ~= 0 then
					local var_262_23 = manager.audio:GetVoiceLength("story_v_out_426031", "426031064", "story_v_out_426031.awb") / 1000

					if var_262_23 + var_262_15 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_23 + var_262_15
					end

					if var_262_18.prefab_name ~= "" and arg_259_1.actors_[var_262_18.prefab_name] ~= nil then
						local var_262_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_18.prefab_name].transform, "story_v_out_426031", "426031064", "story_v_out_426031.awb")

						arg_259_1:RecordAudio("426031064", var_262_24)
						arg_259_1:RecordAudio("426031064", var_262_24)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_426031", "426031064", "story_v_out_426031.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_426031", "426031064", "story_v_out_426031.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_25 = math.max(var_262_16, arg_259_1.talkMaxDuration)

			if var_262_15 <= arg_259_1.time_ and arg_259_1.time_ < var_262_15 + var_262_25 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_15) / var_262_25

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_15 + var_262_25 and arg_259_1.time_ < var_262_15 + var_262_25 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
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

		arg_259_1:InitPlayNodeList()
	end,
	Play426031065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 426031065
		arg_263_1.duration_ = 3.13

		local var_263_0 = {
			zh = 3.133,
			ja = 2.166
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play426031066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1054ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1054ui_story = var_266_0.localPosition

				local var_266_2 = GameObjectTools.GetOrAddComponent(var_266_0.gameObject, typeof(DynamicBoneHelper))

				if var_266_2 then
					var_266_2:EnableDynamicBone(false)
				end
			end

			local var_266_3 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_3 then
				local var_266_4 = (arg_263_1.time_ - var_266_1) / var_266_3
				local var_266_5 = Vector3.New(0, -0.985, -6)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1054ui_story, var_266_5, var_266_4)

				local var_266_6 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_6.x, var_266_6.y, var_266_6.z)

				local var_266_7 = var_266_0.localEulerAngles

				var_266_7.z = 0
				var_266_7.x = 0
				var_266_0.localEulerAngles = var_266_7
			end

			if arg_263_1.time_ >= var_266_1 + var_266_3 and arg_263_1.time_ < var_266_1 + var_266_3 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_266_8 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_8.x, var_266_8.y, var_266_8.z)

				local var_266_9 = var_266_0.localEulerAngles

				var_266_9.z = 0
				var_266_9.x = 0
				var_266_0.localEulerAngles = var_266_9

				local var_266_10 = GameObjectTools.GetOrAddComponent(var_266_0.gameObject, typeof(DynamicBoneHelper))

				if var_266_10 then
					var_266_10:EnableDynamicBone(true)
				end
			end

			local var_266_11 = arg_263_1.actors_["1012ui_story"].transform
			local var_266_12 = 0

			if var_266_12 < arg_263_1.time_ and arg_263_1.time_ <= var_266_12 + arg_266_0 then
				arg_263_1.var_.moveOldPos1012ui_story = var_266_11.localPosition
			end

			local var_266_13 = 0.001

			if var_266_12 <= arg_263_1.time_ and arg_263_1.time_ < var_266_12 + var_266_13 then
				local var_266_14 = (arg_263_1.time_ - var_266_12) / var_266_13
				local var_266_15 = Vector3.New(0, 100, 0)

				var_266_11.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1012ui_story, var_266_15, var_266_14)

				local var_266_16 = manager.ui.mainCamera.transform.position - var_266_11.position

				var_266_11.forward = Vector3.New(var_266_16.x, var_266_16.y, var_266_16.z)

				local var_266_17 = var_266_11.localEulerAngles

				var_266_17.z = 0
				var_266_17.x = 0
				var_266_11.localEulerAngles = var_266_17
			end

			if arg_263_1.time_ >= var_266_12 + var_266_13 and arg_263_1.time_ < var_266_12 + var_266_13 + arg_266_0 then
				var_266_11.localPosition = Vector3.New(0, 100, 0)

				local var_266_18 = manager.ui.mainCamera.transform.position - var_266_11.position

				var_266_11.forward = Vector3.New(var_266_18.x, var_266_18.y, var_266_18.z)

				local var_266_19 = var_266_11.localEulerAngles

				var_266_19.z = 0
				var_266_19.x = 0
				var_266_11.localEulerAngles = var_266_19
			end

			local var_266_20 = arg_263_1.actors_["1054ui_story"]
			local var_266_21 = 0

			if var_266_21 < arg_263_1.time_ and arg_263_1.time_ <= var_266_21 + arg_266_0 and not isNil(var_266_20) and arg_263_1.var_.characterEffect1054ui_story == nil then
				arg_263_1.var_.characterEffect1054ui_story = var_266_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_22 = 0.200000002980232

			if var_266_21 <= arg_263_1.time_ and arg_263_1.time_ < var_266_21 + var_266_22 and not isNil(var_266_20) then
				local var_266_23 = (arg_263_1.time_ - var_266_21) / var_266_22

				if arg_263_1.var_.characterEffect1054ui_story and not isNil(var_266_20) then
					arg_263_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_21 + var_266_22 and arg_263_1.time_ < var_266_21 + var_266_22 + arg_266_0 and not isNil(var_266_20) and arg_263_1.var_.characterEffect1054ui_story then
				arg_263_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_266_24 = arg_263_1.actors_["1012ui_story"]
			local var_266_25 = 0

			if var_266_25 < arg_263_1.time_ and arg_263_1.time_ <= var_266_25 + arg_266_0 and not isNil(var_266_24) and arg_263_1.var_.characterEffect1012ui_story == nil then
				arg_263_1.var_.characterEffect1012ui_story = var_266_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_26 = 0.200000002980232

			if var_266_25 <= arg_263_1.time_ and arg_263_1.time_ < var_266_25 + var_266_26 and not isNil(var_266_24) then
				local var_266_27 = (arg_263_1.time_ - var_266_25) / var_266_26

				if arg_263_1.var_.characterEffect1012ui_story and not isNil(var_266_24) then
					local var_266_28 = Mathf.Lerp(0, 0.5, var_266_27)

					arg_263_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1012ui_story.fillRatio = var_266_28
				end
			end

			if arg_263_1.time_ >= var_266_25 + var_266_26 and arg_263_1.time_ < var_266_25 + var_266_26 + arg_266_0 and not isNil(var_266_24) and arg_263_1.var_.characterEffect1012ui_story then
				local var_266_29 = 0.5

				arg_263_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1012ui_story.fillRatio = var_266_29
			end

			local var_266_30 = 0

			if var_266_30 < arg_263_1.time_ and arg_263_1.time_ <= var_266_30 + arg_266_0 then
				arg_263_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_266_31 = 0

			if var_266_31 < arg_263_1.time_ and arg_263_1.time_ <= var_266_31 + arg_266_0 then
				arg_263_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_266_32 = 0
			local var_266_33 = 0.175

			if var_266_32 < arg_263_1.time_ and arg_263_1.time_ <= var_266_32 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_34 = arg_263_1:FormatText(StoryNameCfg[1487].name)

				arg_263_1.leftNameTxt_.text = var_266_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_35 = arg_263_1:GetWordFromCfg(426031065)
				local var_266_36 = arg_263_1:FormatText(var_266_35.content)

				arg_263_1.text_.text = var_266_36

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_37 = 7
				local var_266_38 = utf8.len(var_266_36)
				local var_266_39 = var_266_37 <= 0 and var_266_33 or var_266_33 * (var_266_38 / var_266_37)

				if var_266_39 > 0 and var_266_33 < var_266_39 then
					arg_263_1.talkMaxDuration = var_266_39

					if var_266_39 + var_266_32 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_39 + var_266_32
					end
				end

				arg_263_1.text_.text = var_266_36
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031065", "story_v_out_426031.awb") ~= 0 then
					local var_266_40 = manager.audio:GetVoiceLength("story_v_out_426031", "426031065", "story_v_out_426031.awb") / 1000

					if var_266_40 + var_266_32 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_40 + var_266_32
					end

					if var_266_35.prefab_name ~= "" and arg_263_1.actors_[var_266_35.prefab_name] ~= nil then
						local var_266_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_35.prefab_name].transform, "story_v_out_426031", "426031065", "story_v_out_426031.awb")

						arg_263_1:RecordAudio("426031065", var_266_41)
						arg_263_1:RecordAudio("426031065", var_266_41)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_426031", "426031065", "story_v_out_426031.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_426031", "426031065", "story_v_out_426031.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_42 = math.max(var_266_33, arg_263_1.talkMaxDuration)

			if var_266_32 <= arg_263_1.time_ and arg_263_1.time_ < var_266_32 + var_266_42 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_32) / var_266_42

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_32 + var_266_42 and arg_263_1.time_ < var_266_32 + var_266_42 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play426031066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 426031066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play426031067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1054ui_story"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos1054ui_story = var_270_0.localPosition

				local var_270_2 = GameObjectTools.GetOrAddComponent(var_270_0.gameObject, typeof(DynamicBoneHelper))

				if var_270_2 then
					var_270_2:EnableDynamicBone(false)
				end
			end

			local var_270_3 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_3 then
				local var_270_4 = (arg_267_1.time_ - var_270_1) / var_270_3
				local var_270_5 = Vector3.New(0, 100, 0)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1054ui_story, var_270_5, var_270_4)

				local var_270_6 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_6.x, var_270_6.y, var_270_6.z)

				local var_270_7 = var_270_0.localEulerAngles

				var_270_7.z = 0
				var_270_7.x = 0
				var_270_0.localEulerAngles = var_270_7
			end

			if arg_267_1.time_ >= var_270_1 + var_270_3 and arg_267_1.time_ < var_270_1 + var_270_3 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(0, 100, 0)

				local var_270_8 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_8.x, var_270_8.y, var_270_8.z)

				local var_270_9 = var_270_0.localEulerAngles

				var_270_9.z = 0
				var_270_9.x = 0
				var_270_0.localEulerAngles = var_270_9

				local var_270_10 = GameObjectTools.GetOrAddComponent(var_270_0.gameObject, typeof(DynamicBoneHelper))

				if var_270_10 then
					var_270_10:EnableDynamicBone(true)
				end
			end

			local var_270_11 = arg_267_1.actors_["1054ui_story"]
			local var_270_12 = 0

			if var_270_12 < arg_267_1.time_ and arg_267_1.time_ <= var_270_12 + arg_270_0 and not isNil(var_270_11) and arg_267_1.var_.characterEffect1054ui_story == nil then
				arg_267_1.var_.characterEffect1054ui_story = var_270_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_13 = 0.200000002980232

			if var_270_12 <= arg_267_1.time_ and arg_267_1.time_ < var_270_12 + var_270_13 and not isNil(var_270_11) then
				local var_270_14 = (arg_267_1.time_ - var_270_12) / var_270_13

				if arg_267_1.var_.characterEffect1054ui_story and not isNil(var_270_11) then
					local var_270_15 = Mathf.Lerp(0, 0.5, var_270_14)

					arg_267_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1054ui_story.fillRatio = var_270_15
				end
			end

			if arg_267_1.time_ >= var_270_12 + var_270_13 and arg_267_1.time_ < var_270_12 + var_270_13 + arg_270_0 and not isNil(var_270_11) and arg_267_1.var_.characterEffect1054ui_story then
				local var_270_16 = 0.5

				arg_267_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1054ui_story.fillRatio = var_270_16
			end

			local var_270_17 = 0
			local var_270_18 = 1.1

			if var_270_17 < arg_267_1.time_ and arg_267_1.time_ <= var_270_17 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_19 = arg_267_1:GetWordFromCfg(426031066)
				local var_270_20 = arg_267_1:FormatText(var_270_19.content)

				arg_267_1.text_.text = var_270_20

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_21 = 44
				local var_270_22 = utf8.len(var_270_20)
				local var_270_23 = var_270_21 <= 0 and var_270_18 or var_270_18 * (var_270_22 / var_270_21)

				if var_270_23 > 0 and var_270_18 < var_270_23 then
					arg_267_1.talkMaxDuration = var_270_23

					if var_270_23 + var_270_17 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_23 + var_270_17
					end
				end

				arg_267_1.text_.text = var_270_20
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_24 = math.max(var_270_18, arg_267_1.talkMaxDuration)

			if var_270_17 <= arg_267_1.time_ and arg_267_1.time_ < var_270_17 + var_270_24 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_17) / var_270_24

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_17 + var_270_24 and arg_267_1.time_ < var_270_17 + var_270_24 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
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

		arg_267_1:InitPlayNodeList()
	end,
	Play426031067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 426031067
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play426031068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 0.475

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_2 = arg_271_1:FormatText(StoryNameCfg[7].name)

				arg_271_1.leftNameTxt_.text = var_274_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_3 = arg_271_1:GetWordFromCfg(426031067)
				local var_274_4 = arg_271_1:FormatText(var_274_3.content)

				arg_271_1.text_.text = var_274_4

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 19
				local var_274_6 = utf8.len(var_274_4)
				local var_274_7 = var_274_5 <= 0 and var_274_1 or var_274_1 * (var_274_6 / var_274_5)

				if var_274_7 > 0 and var_274_1 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_4
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_8 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_8 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_8

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_8 and arg_271_1.time_ < var_274_0 + var_274_8 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play426031068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 426031068
		arg_275_1.duration_ = 9.1

		local var_275_0 = {
			zh = 6.166,
			ja = 9.1
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play426031069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1012ui_story"].transform
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.var_.moveOldPos1012ui_story = var_278_0.localPosition
			end

			local var_278_2 = 0.001

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2
				local var_278_4 = Vector3.New(0, -1.05, -6.24)

				var_278_0.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1012ui_story, var_278_4, var_278_3)

				local var_278_5 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_5.x, var_278_5.y, var_278_5.z)

				local var_278_6 = var_278_0.localEulerAngles

				var_278_6.z = 0
				var_278_6.x = 0
				var_278_0.localEulerAngles = var_278_6
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 then
				var_278_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_278_7 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_7.x, var_278_7.y, var_278_7.z)

				local var_278_8 = var_278_0.localEulerAngles

				var_278_8.z = 0
				var_278_8.x = 0
				var_278_0.localEulerAngles = var_278_8
			end

			local var_278_9 = arg_275_1.actors_["1012ui_story"]
			local var_278_10 = 0

			if var_278_10 < arg_275_1.time_ and arg_275_1.time_ <= var_278_10 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect1012ui_story == nil then
				arg_275_1.var_.characterEffect1012ui_story = var_278_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_11 = 0.200000002980232

			if var_278_10 <= arg_275_1.time_ and arg_275_1.time_ < var_278_10 + var_278_11 and not isNil(var_278_9) then
				local var_278_12 = (arg_275_1.time_ - var_278_10) / var_278_11

				if arg_275_1.var_.characterEffect1012ui_story and not isNil(var_278_9) then
					arg_275_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_10 + var_278_11 and arg_275_1.time_ < var_278_10 + var_278_11 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect1012ui_story then
				arg_275_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_278_13 = 0

			if var_278_13 < arg_275_1.time_ and arg_275_1.time_ <= var_278_13 + arg_278_0 then
				arg_275_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_278_14 = 0
			local var_278_15 = 0.7

			if var_278_14 < arg_275_1.time_ and arg_275_1.time_ <= var_278_14 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_16 = arg_275_1:FormatText(StoryNameCfg[595].name)

				arg_275_1.leftNameTxt_.text = var_278_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_17 = arg_275_1:GetWordFromCfg(426031068)
				local var_278_18 = arg_275_1:FormatText(var_278_17.content)

				arg_275_1.text_.text = var_278_18

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_19 = 28
				local var_278_20 = utf8.len(var_278_18)
				local var_278_21 = var_278_19 <= 0 and var_278_15 or var_278_15 * (var_278_20 / var_278_19)

				if var_278_21 > 0 and var_278_15 < var_278_21 then
					arg_275_1.talkMaxDuration = var_278_21

					if var_278_21 + var_278_14 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_21 + var_278_14
					end
				end

				arg_275_1.text_.text = var_278_18
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031068", "story_v_out_426031.awb") ~= 0 then
					local var_278_22 = manager.audio:GetVoiceLength("story_v_out_426031", "426031068", "story_v_out_426031.awb") / 1000

					if var_278_22 + var_278_14 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_22 + var_278_14
					end

					if var_278_17.prefab_name ~= "" and arg_275_1.actors_[var_278_17.prefab_name] ~= nil then
						local var_278_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_17.prefab_name].transform, "story_v_out_426031", "426031068", "story_v_out_426031.awb")

						arg_275_1:RecordAudio("426031068", var_278_23)
						arg_275_1:RecordAudio("426031068", var_278_23)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_426031", "426031068", "story_v_out_426031.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_426031", "426031068", "story_v_out_426031.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_24 = math.max(var_278_15, arg_275_1.talkMaxDuration)

			if var_278_14 <= arg_275_1.time_ and arg_275_1.time_ < var_278_14 + var_278_24 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_14) / var_278_24

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_14 + var_278_24 and arg_275_1.time_ < var_278_14 + var_278_24 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
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

		arg_275_1:InitPlayNodeList()
	end,
	Play426031069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 426031069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play426031070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1012ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1012ui_story == nil then
				arg_279_1.var_.characterEffect1012ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect1012ui_story and not isNil(var_282_0) then
					local var_282_4 = Mathf.Lerp(0, 0.5, var_282_3)

					arg_279_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1012ui_story.fillRatio = var_282_4
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1012ui_story then
				local var_282_5 = 0.5

				arg_279_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1012ui_story.fillRatio = var_282_5
			end

			local var_282_6 = 0
			local var_282_7 = 0.775

			if var_282_6 < arg_279_1.time_ and arg_279_1.time_ <= var_282_6 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_8 = arg_279_1:FormatText(StoryNameCfg[7].name)

				arg_279_1.leftNameTxt_.text = var_282_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_9 = arg_279_1:GetWordFromCfg(426031069)
				local var_282_10 = arg_279_1:FormatText(var_282_9.content)

				arg_279_1.text_.text = var_282_10

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_11 = 31
				local var_282_12 = utf8.len(var_282_10)
				local var_282_13 = var_282_11 <= 0 and var_282_7 or var_282_7 * (var_282_12 / var_282_11)

				if var_282_13 > 0 and var_282_7 < var_282_13 then
					arg_279_1.talkMaxDuration = var_282_13

					if var_282_13 + var_282_6 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_13 + var_282_6
					end
				end

				arg_279_1.text_.text = var_282_10
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_14 = math.max(var_282_7, arg_279_1.talkMaxDuration)

			if var_282_6 <= arg_279_1.time_ and arg_279_1.time_ < var_282_6 + var_282_14 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_6) / var_282_14

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_6 + var_282_14 and arg_279_1.time_ < var_282_6 + var_282_14 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play426031070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 426031070
		arg_283_1.duration_ = 4.87

		local var_283_0 = {
			zh = 3.2,
			ja = 4.866
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play426031071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1012ui_story"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos1012ui_story = var_286_0.localPosition
			end

			local var_286_2 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2
				local var_286_4 = Vector3.New(0, -1.05, -6.24)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1012ui_story, var_286_4, var_286_3)

				local var_286_5 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_5.x, var_286_5.y, var_286_5.z)

				local var_286_6 = var_286_0.localEulerAngles

				var_286_6.z = 0
				var_286_6.x = 0
				var_286_0.localEulerAngles = var_286_6
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_286_7 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_7.x, var_286_7.y, var_286_7.z)

				local var_286_8 = var_286_0.localEulerAngles

				var_286_8.z = 0
				var_286_8.x = 0
				var_286_0.localEulerAngles = var_286_8
			end

			local var_286_9 = arg_283_1.actors_["1012ui_story"]
			local var_286_10 = 0

			if var_286_10 < arg_283_1.time_ and arg_283_1.time_ <= var_286_10 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect1012ui_story == nil then
				arg_283_1.var_.characterEffect1012ui_story = var_286_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_11 = 0.200000002980232

			if var_286_10 <= arg_283_1.time_ and arg_283_1.time_ < var_286_10 + var_286_11 and not isNil(var_286_9) then
				local var_286_12 = (arg_283_1.time_ - var_286_10) / var_286_11

				if arg_283_1.var_.characterEffect1012ui_story and not isNil(var_286_9) then
					arg_283_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_10 + var_286_11 and arg_283_1.time_ < var_286_10 + var_286_11 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect1012ui_story then
				arg_283_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_286_13 = 0

			if var_286_13 < arg_283_1.time_ and arg_283_1.time_ <= var_286_13 + arg_286_0 then
				arg_283_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			local var_286_14 = 0

			if var_286_14 < arg_283_1.time_ and arg_283_1.time_ <= var_286_14 + arg_286_0 then
				arg_283_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_286_15 = 0
			local var_286_16 = 0.325

			if var_286_15 < arg_283_1.time_ and arg_283_1.time_ <= var_286_15 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_17 = arg_283_1:FormatText(StoryNameCfg[595].name)

				arg_283_1.leftNameTxt_.text = var_286_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_18 = arg_283_1:GetWordFromCfg(426031070)
				local var_286_19 = arg_283_1:FormatText(var_286_18.content)

				arg_283_1.text_.text = var_286_19

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_20 = 13
				local var_286_21 = utf8.len(var_286_19)
				local var_286_22 = var_286_20 <= 0 and var_286_16 or var_286_16 * (var_286_21 / var_286_20)

				if var_286_22 > 0 and var_286_16 < var_286_22 then
					arg_283_1.talkMaxDuration = var_286_22

					if var_286_22 + var_286_15 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_22 + var_286_15
					end
				end

				arg_283_1.text_.text = var_286_19
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031070", "story_v_out_426031.awb") ~= 0 then
					local var_286_23 = manager.audio:GetVoiceLength("story_v_out_426031", "426031070", "story_v_out_426031.awb") / 1000

					if var_286_23 + var_286_15 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_23 + var_286_15
					end

					if var_286_18.prefab_name ~= "" and arg_283_1.actors_[var_286_18.prefab_name] ~= nil then
						local var_286_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_18.prefab_name].transform, "story_v_out_426031", "426031070", "story_v_out_426031.awb")

						arg_283_1:RecordAudio("426031070", var_286_24)
						arg_283_1:RecordAudio("426031070", var_286_24)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_426031", "426031070", "story_v_out_426031.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_426031", "426031070", "story_v_out_426031.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_25 = math.max(var_286_16, arg_283_1.talkMaxDuration)

			if var_286_15 <= arg_283_1.time_ and arg_283_1.time_ < var_286_15 + var_286_25 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_15) / var_286_25

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_15 + var_286_25 and arg_283_1.time_ < var_286_15 + var_286_25 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
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

		arg_283_1:InitPlayNodeList()
	end,
	Play426031071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 426031071
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play426031072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1012ui_story"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1012ui_story == nil then
				arg_287_1.var_.characterEffect1012ui_story = var_290_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.characterEffect1012ui_story and not isNil(var_290_0) then
					local var_290_4 = Mathf.Lerp(0, 0.5, var_290_3)

					arg_287_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1012ui_story.fillRatio = var_290_4
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1012ui_story then
				local var_290_5 = 0.5

				arg_287_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1012ui_story.fillRatio = var_290_5
			end

			local var_290_6 = 0
			local var_290_7 = 0.425

			if var_290_6 < arg_287_1.time_ and arg_287_1.time_ <= var_290_6 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_8 = arg_287_1:FormatText(StoryNameCfg[7].name)

				arg_287_1.leftNameTxt_.text = var_290_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_9 = arg_287_1:GetWordFromCfg(426031071)
				local var_290_10 = arg_287_1:FormatText(var_290_9.content)

				arg_287_1.text_.text = var_290_10

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_11 = 17
				local var_290_12 = utf8.len(var_290_10)
				local var_290_13 = var_290_11 <= 0 and var_290_7 or var_290_7 * (var_290_12 / var_290_11)

				if var_290_13 > 0 and var_290_7 < var_290_13 then
					arg_287_1.talkMaxDuration = var_290_13

					if var_290_13 + var_290_6 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_13 + var_290_6
					end
				end

				arg_287_1.text_.text = var_290_10
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_14 = math.max(var_290_7, arg_287_1.talkMaxDuration)

			if var_290_6 <= arg_287_1.time_ and arg_287_1.time_ < var_290_6 + var_290_14 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_6) / var_290_14

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_6 + var_290_14 and arg_287_1.time_ < var_290_6 + var_290_14 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play426031072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 426031072
		arg_291_1.duration_ = 5.77

		local var_291_0 = {
			zh = 4.2,
			ja = 5.766
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
				arg_291_0:Play426031073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1012ui_story"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1012ui_story == nil then
				arg_291_1.var_.characterEffect1012ui_story = var_294_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.characterEffect1012ui_story and not isNil(var_294_0) then
					arg_291_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1012ui_story then
				arg_291_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_294_4 = 0

			if var_294_4 < arg_291_1.time_ and arg_291_1.time_ <= var_294_4 + arg_294_0 then
				arg_291_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_294_5 = 0
			local var_294_6 = 0.375

			if var_294_5 < arg_291_1.time_ and arg_291_1.time_ <= var_294_5 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_7 = arg_291_1:FormatText(StoryNameCfg[595].name)

				arg_291_1.leftNameTxt_.text = var_294_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_8 = arg_291_1:GetWordFromCfg(426031072)
				local var_294_9 = arg_291_1:FormatText(var_294_8.content)

				arg_291_1.text_.text = var_294_9

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_10 = 15
				local var_294_11 = utf8.len(var_294_9)
				local var_294_12 = var_294_10 <= 0 and var_294_6 or var_294_6 * (var_294_11 / var_294_10)

				if var_294_12 > 0 and var_294_6 < var_294_12 then
					arg_291_1.talkMaxDuration = var_294_12

					if var_294_12 + var_294_5 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_12 + var_294_5
					end
				end

				arg_291_1.text_.text = var_294_9
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031072", "story_v_out_426031.awb") ~= 0 then
					local var_294_13 = manager.audio:GetVoiceLength("story_v_out_426031", "426031072", "story_v_out_426031.awb") / 1000

					if var_294_13 + var_294_5 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_13 + var_294_5
					end

					if var_294_8.prefab_name ~= "" and arg_291_1.actors_[var_294_8.prefab_name] ~= nil then
						local var_294_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_8.prefab_name].transform, "story_v_out_426031", "426031072", "story_v_out_426031.awb")

						arg_291_1:RecordAudio("426031072", var_294_14)
						arg_291_1:RecordAudio("426031072", var_294_14)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_426031", "426031072", "story_v_out_426031.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_426031", "426031072", "story_v_out_426031.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_15 = math.max(var_294_6, arg_291_1.talkMaxDuration)

			if var_294_5 <= arg_291_1.time_ and arg_291_1.time_ < var_294_5 + var_294_15 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_5) / var_294_15

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_5 + var_294_15 and arg_291_1.time_ < var_294_5 + var_294_15 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play426031073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 426031073
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play426031074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1012ui_story"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos1012ui_story = var_298_0.localPosition
			end

			local var_298_2 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2
				local var_298_4 = Vector3.New(0, 100, 0)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1012ui_story, var_298_4, var_298_3)

				local var_298_5 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_5.x, var_298_5.y, var_298_5.z)

				local var_298_6 = var_298_0.localEulerAngles

				var_298_6.z = 0
				var_298_6.x = 0
				var_298_0.localEulerAngles = var_298_6
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(0, 100, 0)

				local var_298_7 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_7.x, var_298_7.y, var_298_7.z)

				local var_298_8 = var_298_0.localEulerAngles

				var_298_8.z = 0
				var_298_8.x = 0
				var_298_0.localEulerAngles = var_298_8
			end

			local var_298_9 = arg_295_1.actors_["1012ui_story"]
			local var_298_10 = 0

			if var_298_10 < arg_295_1.time_ and arg_295_1.time_ <= var_298_10 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1012ui_story == nil then
				arg_295_1.var_.characterEffect1012ui_story = var_298_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_11 = 0.200000002980232

			if var_298_10 <= arg_295_1.time_ and arg_295_1.time_ < var_298_10 + var_298_11 and not isNil(var_298_9) then
				local var_298_12 = (arg_295_1.time_ - var_298_10) / var_298_11

				if arg_295_1.var_.characterEffect1012ui_story and not isNil(var_298_9) then
					local var_298_13 = Mathf.Lerp(0, 0.5, var_298_12)

					arg_295_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1012ui_story.fillRatio = var_298_13
				end
			end

			if arg_295_1.time_ >= var_298_10 + var_298_11 and arg_295_1.time_ < var_298_10 + var_298_11 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1012ui_story then
				local var_298_14 = 0.5

				arg_295_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1012ui_story.fillRatio = var_298_14
			end

			local var_298_15 = 0
			local var_298_16 = 0.7

			if var_298_15 < arg_295_1.time_ and arg_295_1.time_ <= var_298_15 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_17 = arg_295_1:GetWordFromCfg(426031073)
				local var_298_18 = arg_295_1:FormatText(var_298_17.content)

				arg_295_1.text_.text = var_298_18

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_19 = 28
				local var_298_20 = utf8.len(var_298_18)
				local var_298_21 = var_298_19 <= 0 and var_298_16 or var_298_16 * (var_298_20 / var_298_19)

				if var_298_21 > 0 and var_298_16 < var_298_21 then
					arg_295_1.talkMaxDuration = var_298_21

					if var_298_21 + var_298_15 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_21 + var_298_15
					end
				end

				arg_295_1.text_.text = var_298_18
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_22 = math.max(var_298_16, arg_295_1.talkMaxDuration)

			if var_298_15 <= arg_295_1.time_ and arg_295_1.time_ < var_298_15 + var_298_22 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_15) / var_298_22

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_15 + var_298_22 and arg_295_1.time_ < var_298_15 + var_298_22 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play426031074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 426031074
		arg_299_1.duration_ = 7.47

		local var_299_0 = {
			zh = 7.466,
			ja = 6.866
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play426031075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["6148ui_story"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos6148ui_story = var_302_0.localPosition

				local var_302_2 = GameObjectTools.GetOrAddComponent(var_302_0.gameObject, typeof(DynamicBoneHelper))

				if var_302_2 then
					var_302_2:EnableDynamicBone(false)
				end
			end

			local var_302_3 = 0.001

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_3 then
				local var_302_4 = (arg_299_1.time_ - var_302_1) / var_302_3
				local var_302_5 = Vector3.New(0, -0.985, -6)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos6148ui_story, var_302_5, var_302_4)

				local var_302_6 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_6.x, var_302_6.y, var_302_6.z)

				local var_302_7 = var_302_0.localEulerAngles

				var_302_7.z = 0
				var_302_7.x = 0
				var_302_0.localEulerAngles = var_302_7
			end

			if arg_299_1.time_ >= var_302_1 + var_302_3 and arg_299_1.time_ < var_302_1 + var_302_3 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_302_8 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_8.x, var_302_8.y, var_302_8.z)

				local var_302_9 = var_302_0.localEulerAngles

				var_302_9.z = 0
				var_302_9.x = 0
				var_302_0.localEulerAngles = var_302_9

				local var_302_10 = GameObjectTools.GetOrAddComponent(var_302_0.gameObject, typeof(DynamicBoneHelper))

				if var_302_10 then
					var_302_10:EnableDynamicBone(true)
				end
			end

			local var_302_11 = arg_299_1.actors_["6148ui_story"]
			local var_302_12 = 0

			if var_302_12 < arg_299_1.time_ and arg_299_1.time_ <= var_302_12 + arg_302_0 and not isNil(var_302_11) and arg_299_1.var_.characterEffect6148ui_story == nil then
				arg_299_1.var_.characterEffect6148ui_story = var_302_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_13 = 0.200000002980232

			if var_302_12 <= arg_299_1.time_ and arg_299_1.time_ < var_302_12 + var_302_13 and not isNil(var_302_11) then
				local var_302_14 = (arg_299_1.time_ - var_302_12) / var_302_13

				if arg_299_1.var_.characterEffect6148ui_story and not isNil(var_302_11) then
					arg_299_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_12 + var_302_13 and arg_299_1.time_ < var_302_12 + var_302_13 + arg_302_0 and not isNil(var_302_11) and arg_299_1.var_.characterEffect6148ui_story then
				arg_299_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_302_15 = 0

			if var_302_15 < arg_299_1.time_ and arg_299_1.time_ <= var_302_15 + arg_302_0 then
				arg_299_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_302_16 = 0

			if var_302_16 < arg_299_1.time_ and arg_299_1.time_ <= var_302_16 + arg_302_0 then
				arg_299_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_302_17 = 0
			local var_302_18 = 0.575

			if var_302_17 < arg_299_1.time_ and arg_299_1.time_ <= var_302_17 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_19 = arg_299_1:FormatText(StoryNameCfg[1488].name)

				arg_299_1.leftNameTxt_.text = var_302_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_20 = arg_299_1:GetWordFromCfg(426031074)
				local var_302_21 = arg_299_1:FormatText(var_302_20.content)

				arg_299_1.text_.text = var_302_21

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_22 = 23
				local var_302_23 = utf8.len(var_302_21)
				local var_302_24 = var_302_22 <= 0 and var_302_18 or var_302_18 * (var_302_23 / var_302_22)

				if var_302_24 > 0 and var_302_18 < var_302_24 then
					arg_299_1.talkMaxDuration = var_302_24

					if var_302_24 + var_302_17 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_24 + var_302_17
					end
				end

				arg_299_1.text_.text = var_302_21
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031074", "story_v_out_426031.awb") ~= 0 then
					local var_302_25 = manager.audio:GetVoiceLength("story_v_out_426031", "426031074", "story_v_out_426031.awb") / 1000

					if var_302_25 + var_302_17 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_25 + var_302_17
					end

					if var_302_20.prefab_name ~= "" and arg_299_1.actors_[var_302_20.prefab_name] ~= nil then
						local var_302_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_20.prefab_name].transform, "story_v_out_426031", "426031074", "story_v_out_426031.awb")

						arg_299_1:RecordAudio("426031074", var_302_26)
						arg_299_1:RecordAudio("426031074", var_302_26)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_426031", "426031074", "story_v_out_426031.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_426031", "426031074", "story_v_out_426031.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_27 = math.max(var_302_18, arg_299_1.talkMaxDuration)

			if var_302_17 <= arg_299_1.time_ and arg_299_1.time_ < var_302_17 + var_302_27 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_17) / var_302_27

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_17 + var_302_27 and arg_299_1.time_ < var_302_17 + var_302_27 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play426031075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 426031075
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play426031076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["6148ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect6148ui_story == nil then
				arg_303_1.var_.characterEffect6148ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect6148ui_story and not isNil(var_306_0) then
					local var_306_4 = Mathf.Lerp(0, 0.5, var_306_3)

					arg_303_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_303_1.var_.characterEffect6148ui_story.fillRatio = var_306_4
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect6148ui_story then
				local var_306_5 = 0.5

				arg_303_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_303_1.var_.characterEffect6148ui_story.fillRatio = var_306_5
			end

			local var_306_6 = 0
			local var_306_7 = 0.875

			if var_306_6 < arg_303_1.time_ and arg_303_1.time_ <= var_306_6 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_8 = arg_303_1:FormatText(StoryNameCfg[7].name)

				arg_303_1.leftNameTxt_.text = var_306_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_9 = arg_303_1:GetWordFromCfg(426031075)
				local var_306_10 = arg_303_1:FormatText(var_306_9.content)

				arg_303_1.text_.text = var_306_10

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_11 = 35
				local var_306_12 = utf8.len(var_306_10)
				local var_306_13 = var_306_11 <= 0 and var_306_7 or var_306_7 * (var_306_12 / var_306_11)

				if var_306_13 > 0 and var_306_7 < var_306_13 then
					arg_303_1.talkMaxDuration = var_306_13

					if var_306_13 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_13 + var_306_6
					end
				end

				arg_303_1.text_.text = var_306_10
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_14 = math.max(var_306_7, arg_303_1.talkMaxDuration)

			if var_306_6 <= arg_303_1.time_ and arg_303_1.time_ < var_306_6 + var_306_14 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_6) / var_306_14

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_6 + var_306_14 and arg_303_1.time_ < var_306_6 + var_306_14 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play426031076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 426031076
		arg_307_1.duration_ = 4.43

		local var_307_0 = {
			zh = 4.433,
			ja = 2.4
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play426031077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["6148ui_story"].transform
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.var_.moveOldPos6148ui_story = var_310_0.localPosition

				local var_310_2 = GameObjectTools.GetOrAddComponent(var_310_0.gameObject, typeof(DynamicBoneHelper))

				if var_310_2 then
					var_310_2:EnableDynamicBone(false)
				end
			end

			local var_310_3 = 0.001

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_3 then
				local var_310_4 = (arg_307_1.time_ - var_310_1) / var_310_3
				local var_310_5 = Vector3.New(0, -0.985, -6)

				var_310_0.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos6148ui_story, var_310_5, var_310_4)

				local var_310_6 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_6.x, var_310_6.y, var_310_6.z)

				local var_310_7 = var_310_0.localEulerAngles

				var_310_7.z = 0
				var_310_7.x = 0
				var_310_0.localEulerAngles = var_310_7
			end

			if arg_307_1.time_ >= var_310_1 + var_310_3 and arg_307_1.time_ < var_310_1 + var_310_3 + arg_310_0 then
				var_310_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_310_8 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_8.x, var_310_8.y, var_310_8.z)

				local var_310_9 = var_310_0.localEulerAngles

				var_310_9.z = 0
				var_310_9.x = 0
				var_310_0.localEulerAngles = var_310_9

				local var_310_10 = GameObjectTools.GetOrAddComponent(var_310_0.gameObject, typeof(DynamicBoneHelper))

				if var_310_10 then
					var_310_10:EnableDynamicBone(true)
				end
			end

			local var_310_11 = arg_307_1.actors_["6148ui_story"]
			local var_310_12 = 0

			if var_310_12 < arg_307_1.time_ and arg_307_1.time_ <= var_310_12 + arg_310_0 and not isNil(var_310_11) and arg_307_1.var_.characterEffect6148ui_story == nil then
				arg_307_1.var_.characterEffect6148ui_story = var_310_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_13 = 0.200000002980232

			if var_310_12 <= arg_307_1.time_ and arg_307_1.time_ < var_310_12 + var_310_13 and not isNil(var_310_11) then
				local var_310_14 = (arg_307_1.time_ - var_310_12) / var_310_13

				if arg_307_1.var_.characterEffect6148ui_story and not isNil(var_310_11) then
					arg_307_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= var_310_12 + var_310_13 and arg_307_1.time_ < var_310_12 + var_310_13 + arg_310_0 and not isNil(var_310_11) and arg_307_1.var_.characterEffect6148ui_story then
				arg_307_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_310_15 = 0

			if var_310_15 < arg_307_1.time_ and arg_307_1.time_ <= var_310_15 + arg_310_0 then
				arg_307_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_310_16 = 0
			local var_310_17 = 0.475

			if var_310_16 < arg_307_1.time_ and arg_307_1.time_ <= var_310_16 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_18 = arg_307_1:FormatText(StoryNameCfg[1488].name)

				arg_307_1.leftNameTxt_.text = var_310_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_19 = arg_307_1:GetWordFromCfg(426031076)
				local var_310_20 = arg_307_1:FormatText(var_310_19.content)

				arg_307_1.text_.text = var_310_20

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_21 = 19
				local var_310_22 = utf8.len(var_310_20)
				local var_310_23 = var_310_21 <= 0 and var_310_17 or var_310_17 * (var_310_22 / var_310_21)

				if var_310_23 > 0 and var_310_17 < var_310_23 then
					arg_307_1.talkMaxDuration = var_310_23

					if var_310_23 + var_310_16 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_23 + var_310_16
					end
				end

				arg_307_1.text_.text = var_310_20
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031076", "story_v_out_426031.awb") ~= 0 then
					local var_310_24 = manager.audio:GetVoiceLength("story_v_out_426031", "426031076", "story_v_out_426031.awb") / 1000

					if var_310_24 + var_310_16 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_24 + var_310_16
					end

					if var_310_19.prefab_name ~= "" and arg_307_1.actors_[var_310_19.prefab_name] ~= nil then
						local var_310_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_19.prefab_name].transform, "story_v_out_426031", "426031076", "story_v_out_426031.awb")

						arg_307_1:RecordAudio("426031076", var_310_25)
						arg_307_1:RecordAudio("426031076", var_310_25)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_426031", "426031076", "story_v_out_426031.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_426031", "426031076", "story_v_out_426031.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_26 = math.max(var_310_17, arg_307_1.talkMaxDuration)

			if var_310_16 <= arg_307_1.time_ and arg_307_1.time_ < var_310_16 + var_310_26 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_16) / var_310_26

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_16 + var_310_26 and arg_307_1.time_ < var_310_16 + var_310_26 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play426031077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 426031077
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play426031078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["6148ui_story"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect6148ui_story == nil then
				arg_311_1.var_.characterEffect6148ui_story = var_314_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.characterEffect6148ui_story and not isNil(var_314_0) then
					local var_314_4 = Mathf.Lerp(0, 0.5, var_314_3)

					arg_311_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_311_1.var_.characterEffect6148ui_story.fillRatio = var_314_4
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect6148ui_story then
				local var_314_5 = 0.5

				arg_311_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_311_1.var_.characterEffect6148ui_story.fillRatio = var_314_5
			end

			local var_314_6 = 0
			local var_314_7 = 0.725

			if var_314_6 < arg_311_1.time_ and arg_311_1.time_ <= var_314_6 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_8 = arg_311_1:FormatText(StoryNameCfg[7].name)

				arg_311_1.leftNameTxt_.text = var_314_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_9 = arg_311_1:GetWordFromCfg(426031077)
				local var_314_10 = arg_311_1:FormatText(var_314_9.content)

				arg_311_1.text_.text = var_314_10

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_11 = 29
				local var_314_12 = utf8.len(var_314_10)
				local var_314_13 = var_314_11 <= 0 and var_314_7 or var_314_7 * (var_314_12 / var_314_11)

				if var_314_13 > 0 and var_314_7 < var_314_13 then
					arg_311_1.talkMaxDuration = var_314_13

					if var_314_13 + var_314_6 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_13 + var_314_6
					end
				end

				arg_311_1.text_.text = var_314_10
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_14 = math.max(var_314_7, arg_311_1.talkMaxDuration)

			if var_314_6 <= arg_311_1.time_ and arg_311_1.time_ < var_314_6 + var_314_14 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_6) / var_314_14

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_6 + var_314_14 and arg_311_1.time_ < var_314_6 + var_314_14 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play426031078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 426031078
		arg_315_1.duration_ = 2

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play426031079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["6148ui_story"].transform
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.var_.moveOldPos6148ui_story = var_318_0.localPosition

				local var_318_2 = GameObjectTools.GetOrAddComponent(var_318_0.gameObject, typeof(DynamicBoneHelper))

				if var_318_2 then
					var_318_2:EnableDynamicBone(false)
				end
			end

			local var_318_3 = 0.001

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_3 then
				local var_318_4 = (arg_315_1.time_ - var_318_1) / var_318_3
				local var_318_5 = Vector3.New(-0.7, -0.985, -6)

				var_318_0.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos6148ui_story, var_318_5, var_318_4)

				local var_318_6 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_6.x, var_318_6.y, var_318_6.z)

				local var_318_7 = var_318_0.localEulerAngles

				var_318_7.z = 0
				var_318_7.x = 0
				var_318_0.localEulerAngles = var_318_7
			end

			if arg_315_1.time_ >= var_318_1 + var_318_3 and arg_315_1.time_ < var_318_1 + var_318_3 + arg_318_0 then
				var_318_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_318_8 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_8.x, var_318_8.y, var_318_8.z)

				local var_318_9 = var_318_0.localEulerAngles

				var_318_9.z = 0
				var_318_9.x = 0
				var_318_0.localEulerAngles = var_318_9

				local var_318_10 = GameObjectTools.GetOrAddComponent(var_318_0.gameObject, typeof(DynamicBoneHelper))

				if var_318_10 then
					var_318_10:EnableDynamicBone(true)
				end
			end

			local var_318_11 = arg_315_1.actors_["1054ui_story"].transform
			local var_318_12 = 0

			if var_318_12 < arg_315_1.time_ and arg_315_1.time_ <= var_318_12 + arg_318_0 then
				arg_315_1.var_.moveOldPos1054ui_story = var_318_11.localPosition

				local var_318_13 = GameObjectTools.GetOrAddComponent(var_318_11.gameObject, typeof(DynamicBoneHelper))

				if var_318_13 then
					var_318_13:EnableDynamicBone(false)
				end
			end

			local var_318_14 = 0.001

			if var_318_12 <= arg_315_1.time_ and arg_315_1.time_ < var_318_12 + var_318_14 then
				local var_318_15 = (arg_315_1.time_ - var_318_12) / var_318_14
				local var_318_16 = Vector3.New(0.7, -0.985, -6)

				var_318_11.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1054ui_story, var_318_16, var_318_15)

				local var_318_17 = manager.ui.mainCamera.transform.position - var_318_11.position

				var_318_11.forward = Vector3.New(var_318_17.x, var_318_17.y, var_318_17.z)

				local var_318_18 = var_318_11.localEulerAngles

				var_318_18.z = 0
				var_318_18.x = 0
				var_318_11.localEulerAngles = var_318_18
			end

			if arg_315_1.time_ >= var_318_12 + var_318_14 and arg_315_1.time_ < var_318_12 + var_318_14 + arg_318_0 then
				var_318_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_318_19 = manager.ui.mainCamera.transform.position - var_318_11.position

				var_318_11.forward = Vector3.New(var_318_19.x, var_318_19.y, var_318_19.z)

				local var_318_20 = var_318_11.localEulerAngles

				var_318_20.z = 0
				var_318_20.x = 0
				var_318_11.localEulerAngles = var_318_20

				local var_318_21 = GameObjectTools.GetOrAddComponent(var_318_11.gameObject, typeof(DynamicBoneHelper))

				if var_318_21 then
					var_318_21:EnableDynamicBone(true)
				end
			end

			local var_318_22 = arg_315_1.actors_["1054ui_story"]
			local var_318_23 = 0

			if var_318_23 < arg_315_1.time_ and arg_315_1.time_ <= var_318_23 + arg_318_0 and not isNil(var_318_22) and arg_315_1.var_.characterEffect1054ui_story == nil then
				arg_315_1.var_.characterEffect1054ui_story = var_318_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_24 = 0.200000002980232

			if var_318_23 <= arg_315_1.time_ and arg_315_1.time_ < var_318_23 + var_318_24 and not isNil(var_318_22) then
				local var_318_25 = (arg_315_1.time_ - var_318_23) / var_318_24

				if arg_315_1.var_.characterEffect1054ui_story and not isNil(var_318_22) then
					arg_315_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= var_318_23 + var_318_24 and arg_315_1.time_ < var_318_23 + var_318_24 + arg_318_0 and not isNil(var_318_22) and arg_315_1.var_.characterEffect1054ui_story then
				arg_315_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_318_26 = 0

			if var_318_26 < arg_315_1.time_ and arg_315_1.time_ <= var_318_26 + arg_318_0 then
				arg_315_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_318_27 = 0
			local var_318_28 = 0.1

			if var_318_27 < arg_315_1.time_ and arg_315_1.time_ <= var_318_27 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_29 = arg_315_1:FormatText(StoryNameCfg[1487].name)

				arg_315_1.leftNameTxt_.text = var_318_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_30 = arg_315_1:GetWordFromCfg(426031078)
				local var_318_31 = arg_315_1:FormatText(var_318_30.content)

				arg_315_1.text_.text = var_318_31

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_32 = 4
				local var_318_33 = utf8.len(var_318_31)
				local var_318_34 = var_318_32 <= 0 and var_318_28 or var_318_28 * (var_318_33 / var_318_32)

				if var_318_34 > 0 and var_318_28 < var_318_34 then
					arg_315_1.talkMaxDuration = var_318_34

					if var_318_34 + var_318_27 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_34 + var_318_27
					end
				end

				arg_315_1.text_.text = var_318_31
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031078", "story_v_out_426031.awb") ~= 0 then
					local var_318_35 = manager.audio:GetVoiceLength("story_v_out_426031", "426031078", "story_v_out_426031.awb") / 1000

					if var_318_35 + var_318_27 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_35 + var_318_27
					end

					if var_318_30.prefab_name ~= "" and arg_315_1.actors_[var_318_30.prefab_name] ~= nil then
						local var_318_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_30.prefab_name].transform, "story_v_out_426031", "426031078", "story_v_out_426031.awb")

						arg_315_1:RecordAudio("426031078", var_318_36)
						arg_315_1:RecordAudio("426031078", var_318_36)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_426031", "426031078", "story_v_out_426031.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_426031", "426031078", "story_v_out_426031.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_37 = math.max(var_318_28, arg_315_1.talkMaxDuration)

			if var_318_27 <= arg_315_1.time_ and arg_315_1.time_ < var_318_27 + var_318_37 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_27) / var_318_37

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_27 + var_318_37 and arg_315_1.time_ < var_318_27 + var_318_37 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_315_1:InitPlayNodeList()
	end,
	Play426031079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 426031079
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play426031080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1054ui_story"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1054ui_story == nil then
				arg_319_1.var_.characterEffect1054ui_story = var_322_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.characterEffect1054ui_story and not isNil(var_322_0) then
					local var_322_4 = Mathf.Lerp(0, 0.5, var_322_3)

					arg_319_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1054ui_story.fillRatio = var_322_4
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1054ui_story then
				local var_322_5 = 0.5

				arg_319_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1054ui_story.fillRatio = var_322_5
			end

			local var_322_6 = 0
			local var_322_7 = 0.2

			if var_322_6 < arg_319_1.time_ and arg_319_1.time_ <= var_322_6 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_8 = arg_319_1:FormatText(StoryNameCfg[7].name)

				arg_319_1.leftNameTxt_.text = var_322_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_9 = arg_319_1:GetWordFromCfg(426031079)
				local var_322_10 = arg_319_1:FormatText(var_322_9.content)

				arg_319_1.text_.text = var_322_10

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_11 = 8
				local var_322_12 = utf8.len(var_322_10)
				local var_322_13 = var_322_11 <= 0 and var_322_7 or var_322_7 * (var_322_12 / var_322_11)

				if var_322_13 > 0 and var_322_7 < var_322_13 then
					arg_319_1.talkMaxDuration = var_322_13

					if var_322_13 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_13 + var_322_6
					end
				end

				arg_319_1.text_.text = var_322_10
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_14 = math.max(var_322_7, arg_319_1.talkMaxDuration)

			if var_322_6 <= arg_319_1.time_ and arg_319_1.time_ < var_322_6 + var_322_14 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_6) / var_322_14

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_6 + var_322_14 and arg_319_1.time_ < var_322_6 + var_322_14 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play426031080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 426031080
		arg_323_1.duration_ = 7.63

		local var_323_0 = {
			zh = 6.133,
			ja = 7.633
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play426031081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1054ui_story"].transform
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.var_.moveOldPos1054ui_story = var_326_0.localPosition

				local var_326_2 = GameObjectTools.GetOrAddComponent(var_326_0.gameObject, typeof(DynamicBoneHelper))

				if var_326_2 then
					var_326_2:EnableDynamicBone(false)
				end
			end

			local var_326_3 = 0.001

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_3 then
				local var_326_4 = (arg_323_1.time_ - var_326_1) / var_326_3
				local var_326_5 = Vector3.New(0.7, -0.985, -6)

				var_326_0.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1054ui_story, var_326_5, var_326_4)

				local var_326_6 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_6.x, var_326_6.y, var_326_6.z)

				local var_326_7 = var_326_0.localEulerAngles

				var_326_7.z = 0
				var_326_7.x = 0
				var_326_0.localEulerAngles = var_326_7
			end

			if arg_323_1.time_ >= var_326_1 + var_326_3 and arg_323_1.time_ < var_326_1 + var_326_3 + arg_326_0 then
				var_326_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_326_8 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_8.x, var_326_8.y, var_326_8.z)

				local var_326_9 = var_326_0.localEulerAngles

				var_326_9.z = 0
				var_326_9.x = 0
				var_326_0.localEulerAngles = var_326_9

				local var_326_10 = GameObjectTools.GetOrAddComponent(var_326_0.gameObject, typeof(DynamicBoneHelper))

				if var_326_10 then
					var_326_10:EnableDynamicBone(true)
				end
			end

			local var_326_11 = arg_323_1.actors_["1054ui_story"]
			local var_326_12 = 0

			if var_326_12 < arg_323_1.time_ and arg_323_1.time_ <= var_326_12 + arg_326_0 and not isNil(var_326_11) and arg_323_1.var_.characterEffect1054ui_story == nil then
				arg_323_1.var_.characterEffect1054ui_story = var_326_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_13 = 0.200000002980232

			if var_326_12 <= arg_323_1.time_ and arg_323_1.time_ < var_326_12 + var_326_13 and not isNil(var_326_11) then
				local var_326_14 = (arg_323_1.time_ - var_326_12) / var_326_13

				if arg_323_1.var_.characterEffect1054ui_story and not isNil(var_326_11) then
					arg_323_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_12 + var_326_13 and arg_323_1.time_ < var_326_12 + var_326_13 + arg_326_0 and not isNil(var_326_11) and arg_323_1.var_.characterEffect1054ui_story then
				arg_323_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_326_15 = 0

			if var_326_15 < arg_323_1.time_ and arg_323_1.time_ <= var_326_15 + arg_326_0 then
				arg_323_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			local var_326_16 = 0

			if var_326_16 < arg_323_1.time_ and arg_323_1.time_ <= var_326_16 + arg_326_0 then
				arg_323_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_326_17 = 0
			local var_326_18 = 0.55

			if var_326_17 < arg_323_1.time_ and arg_323_1.time_ <= var_326_17 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_19 = arg_323_1:FormatText(StoryNameCfg[1487].name)

				arg_323_1.leftNameTxt_.text = var_326_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_20 = arg_323_1:GetWordFromCfg(426031080)
				local var_326_21 = arg_323_1:FormatText(var_326_20.content)

				arg_323_1.text_.text = var_326_21

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_22 = 22
				local var_326_23 = utf8.len(var_326_21)
				local var_326_24 = var_326_22 <= 0 and var_326_18 or var_326_18 * (var_326_23 / var_326_22)

				if var_326_24 > 0 and var_326_18 < var_326_24 then
					arg_323_1.talkMaxDuration = var_326_24

					if var_326_24 + var_326_17 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_24 + var_326_17
					end
				end

				arg_323_1.text_.text = var_326_21
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031080", "story_v_out_426031.awb") ~= 0 then
					local var_326_25 = manager.audio:GetVoiceLength("story_v_out_426031", "426031080", "story_v_out_426031.awb") / 1000

					if var_326_25 + var_326_17 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_25 + var_326_17
					end

					if var_326_20.prefab_name ~= "" and arg_323_1.actors_[var_326_20.prefab_name] ~= nil then
						local var_326_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_20.prefab_name].transform, "story_v_out_426031", "426031080", "story_v_out_426031.awb")

						arg_323_1:RecordAudio("426031080", var_326_26)
						arg_323_1:RecordAudio("426031080", var_326_26)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_426031", "426031080", "story_v_out_426031.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_426031", "426031080", "story_v_out_426031.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_27 = math.max(var_326_18, arg_323_1.talkMaxDuration)

			if var_326_17 <= arg_323_1.time_ and arg_323_1.time_ < var_326_17 + var_326_27 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_17) / var_326_27

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_17 + var_326_27 and arg_323_1.time_ < var_326_17 + var_326_27 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
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

		arg_323_1:InitPlayNodeList()
	end,
	Play426031081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 426031081
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play426031082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1054ui_story"].transform
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.var_.moveOldPos1054ui_story = var_330_0.localPosition

				local var_330_2 = GameObjectTools.GetOrAddComponent(var_330_0.gameObject, typeof(DynamicBoneHelper))

				if var_330_2 then
					var_330_2:EnableDynamicBone(false)
				end
			end

			local var_330_3 = 0.001

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_3 then
				local var_330_4 = (arg_327_1.time_ - var_330_1) / var_330_3
				local var_330_5 = Vector3.New(0, 100, 0)

				var_330_0.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1054ui_story, var_330_5, var_330_4)

				local var_330_6 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_6.x, var_330_6.y, var_330_6.z)

				local var_330_7 = var_330_0.localEulerAngles

				var_330_7.z = 0
				var_330_7.x = 0
				var_330_0.localEulerAngles = var_330_7
			end

			if arg_327_1.time_ >= var_330_1 + var_330_3 and arg_327_1.time_ < var_330_1 + var_330_3 + arg_330_0 then
				var_330_0.localPosition = Vector3.New(0, 100, 0)

				local var_330_8 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_8.x, var_330_8.y, var_330_8.z)

				local var_330_9 = var_330_0.localEulerAngles

				var_330_9.z = 0
				var_330_9.x = 0
				var_330_0.localEulerAngles = var_330_9

				local var_330_10 = GameObjectTools.GetOrAddComponent(var_330_0.gameObject, typeof(DynamicBoneHelper))

				if var_330_10 then
					var_330_10:EnableDynamicBone(true)
				end
			end

			local var_330_11 = arg_327_1.actors_["6148ui_story"].transform
			local var_330_12 = 0

			if var_330_12 < arg_327_1.time_ and arg_327_1.time_ <= var_330_12 + arg_330_0 then
				arg_327_1.var_.moveOldPos6148ui_story = var_330_11.localPosition

				local var_330_13 = GameObjectTools.GetOrAddComponent(var_330_11.gameObject, typeof(DynamicBoneHelper))

				if var_330_13 then
					var_330_13:EnableDynamicBone(false)
				end
			end

			local var_330_14 = 0.001

			if var_330_12 <= arg_327_1.time_ and arg_327_1.time_ < var_330_12 + var_330_14 then
				local var_330_15 = (arg_327_1.time_ - var_330_12) / var_330_14
				local var_330_16 = Vector3.New(0, 100, 0)

				var_330_11.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos6148ui_story, var_330_16, var_330_15)

				local var_330_17 = manager.ui.mainCamera.transform.position - var_330_11.position

				var_330_11.forward = Vector3.New(var_330_17.x, var_330_17.y, var_330_17.z)

				local var_330_18 = var_330_11.localEulerAngles

				var_330_18.z = 0
				var_330_18.x = 0
				var_330_11.localEulerAngles = var_330_18
			end

			if arg_327_1.time_ >= var_330_12 + var_330_14 and arg_327_1.time_ < var_330_12 + var_330_14 + arg_330_0 then
				var_330_11.localPosition = Vector3.New(0, 100, 0)

				local var_330_19 = manager.ui.mainCamera.transform.position - var_330_11.position

				var_330_11.forward = Vector3.New(var_330_19.x, var_330_19.y, var_330_19.z)

				local var_330_20 = var_330_11.localEulerAngles

				var_330_20.z = 0
				var_330_20.x = 0
				var_330_11.localEulerAngles = var_330_20

				local var_330_21 = GameObjectTools.GetOrAddComponent(var_330_11.gameObject, typeof(DynamicBoneHelper))

				if var_330_21 then
					var_330_21:EnableDynamicBone(true)
				end
			end

			local var_330_22 = arg_327_1.actors_["1054ui_story"]
			local var_330_23 = 0

			if var_330_23 < arg_327_1.time_ and arg_327_1.time_ <= var_330_23 + arg_330_0 and not isNil(var_330_22) and arg_327_1.var_.characterEffect1054ui_story == nil then
				arg_327_1.var_.characterEffect1054ui_story = var_330_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_24 = 0.200000002980232

			if var_330_23 <= arg_327_1.time_ and arg_327_1.time_ < var_330_23 + var_330_24 and not isNil(var_330_22) then
				local var_330_25 = (arg_327_1.time_ - var_330_23) / var_330_24

				if arg_327_1.var_.characterEffect1054ui_story and not isNil(var_330_22) then
					local var_330_26 = Mathf.Lerp(0, 0.5, var_330_25)

					arg_327_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1054ui_story.fillRatio = var_330_26
				end
			end

			if arg_327_1.time_ >= var_330_23 + var_330_24 and arg_327_1.time_ < var_330_23 + var_330_24 + arg_330_0 and not isNil(var_330_22) and arg_327_1.var_.characterEffect1054ui_story then
				local var_330_27 = 0.5

				arg_327_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1054ui_story.fillRatio = var_330_27
			end

			local var_330_28 = 0
			local var_330_29 = 0.875

			if var_330_28 < arg_327_1.time_ and arg_327_1.time_ <= var_330_28 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_30 = arg_327_1:GetWordFromCfg(426031081)
				local var_330_31 = arg_327_1:FormatText(var_330_30.content)

				arg_327_1.text_.text = var_330_31

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_32 = 35
				local var_330_33 = utf8.len(var_330_31)
				local var_330_34 = var_330_32 <= 0 and var_330_29 or var_330_29 * (var_330_33 / var_330_32)

				if var_330_34 > 0 and var_330_29 < var_330_34 then
					arg_327_1.talkMaxDuration = var_330_34

					if var_330_34 + var_330_28 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_34 + var_330_28
					end
				end

				arg_327_1.text_.text = var_330_31
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_35 = math.max(var_330_29, arg_327_1.talkMaxDuration)

			if var_330_28 <= arg_327_1.time_ and arg_327_1.time_ < var_330_28 + var_330_35 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_28) / var_330_35

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_28 + var_330_35 and arg_327_1.time_ < var_330_28 + var_330_35 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
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
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play426031082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 426031082
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play426031083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0
			local var_334_1 = 0.55

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_2 = arg_331_1:FormatText(StoryNameCfg[7].name)

				arg_331_1.leftNameTxt_.text = var_334_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_3 = arg_331_1:GetWordFromCfg(426031082)
				local var_334_4 = arg_331_1:FormatText(var_334_3.content)

				arg_331_1.text_.text = var_334_4

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 22
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
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_8 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_8 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_8

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_8 and arg_331_1.time_ < var_334_0 + var_334_8 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play426031083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 426031083
		arg_335_1.duration_ = 7

		local var_335_0 = {
			zh = 6.6,
			ja = 7
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
				arg_335_0:Play426031084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["6148ui_story"].transform
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.var_.moveOldPos6148ui_story = var_338_0.localPosition

				local var_338_2 = GameObjectTools.GetOrAddComponent(var_338_0.gameObject, typeof(DynamicBoneHelper))

				if var_338_2 then
					var_338_2:EnableDynamicBone(false)
				end
			end

			local var_338_3 = 0.001

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_3 then
				local var_338_4 = (arg_335_1.time_ - var_338_1) / var_338_3
				local var_338_5 = Vector3.New(0, -0.985, -6)

				var_338_0.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos6148ui_story, var_338_5, var_338_4)

				local var_338_6 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_6.x, var_338_6.y, var_338_6.z)

				local var_338_7 = var_338_0.localEulerAngles

				var_338_7.z = 0
				var_338_7.x = 0
				var_338_0.localEulerAngles = var_338_7
			end

			if arg_335_1.time_ >= var_338_1 + var_338_3 and arg_335_1.time_ < var_338_1 + var_338_3 + arg_338_0 then
				var_338_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_338_8 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_8.x, var_338_8.y, var_338_8.z)

				local var_338_9 = var_338_0.localEulerAngles

				var_338_9.z = 0
				var_338_9.x = 0
				var_338_0.localEulerAngles = var_338_9

				local var_338_10 = GameObjectTools.GetOrAddComponent(var_338_0.gameObject, typeof(DynamicBoneHelper))

				if var_338_10 then
					var_338_10:EnableDynamicBone(true)
				end
			end

			local var_338_11 = arg_335_1.actors_["6148ui_story"]
			local var_338_12 = 0

			if var_338_12 < arg_335_1.time_ and arg_335_1.time_ <= var_338_12 + arg_338_0 and not isNil(var_338_11) and arg_335_1.var_.characterEffect6148ui_story == nil then
				arg_335_1.var_.characterEffect6148ui_story = var_338_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_13 = 0.200000002980232

			if var_338_12 <= arg_335_1.time_ and arg_335_1.time_ < var_338_12 + var_338_13 and not isNil(var_338_11) then
				local var_338_14 = (arg_335_1.time_ - var_338_12) / var_338_13

				if arg_335_1.var_.characterEffect6148ui_story and not isNil(var_338_11) then
					arg_335_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= var_338_12 + var_338_13 and arg_335_1.time_ < var_338_12 + var_338_13 + arg_338_0 and not isNil(var_338_11) and arg_335_1.var_.characterEffect6148ui_story then
				arg_335_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_338_15 = 0

			if var_338_15 < arg_335_1.time_ and arg_335_1.time_ <= var_338_15 + arg_338_0 then
				arg_335_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_338_16 = 0

			if var_338_16 < arg_335_1.time_ and arg_335_1.time_ <= var_338_16 + arg_338_0 then
				arg_335_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_338_17 = 0
			local var_338_18 = 0.85

			if var_338_17 < arg_335_1.time_ and arg_335_1.time_ <= var_338_17 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_19 = arg_335_1:FormatText(StoryNameCfg[1488].name)

				arg_335_1.leftNameTxt_.text = var_338_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_20 = arg_335_1:GetWordFromCfg(426031083)
				local var_338_21 = arg_335_1:FormatText(var_338_20.content)

				arg_335_1.text_.text = var_338_21

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_22 = 34
				local var_338_23 = utf8.len(var_338_21)
				local var_338_24 = var_338_22 <= 0 and var_338_18 or var_338_18 * (var_338_23 / var_338_22)

				if var_338_24 > 0 and var_338_18 < var_338_24 then
					arg_335_1.talkMaxDuration = var_338_24

					if var_338_24 + var_338_17 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_24 + var_338_17
					end
				end

				arg_335_1.text_.text = var_338_21
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031083", "story_v_out_426031.awb") ~= 0 then
					local var_338_25 = manager.audio:GetVoiceLength("story_v_out_426031", "426031083", "story_v_out_426031.awb") / 1000

					if var_338_25 + var_338_17 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_25 + var_338_17
					end

					if var_338_20.prefab_name ~= "" and arg_335_1.actors_[var_338_20.prefab_name] ~= nil then
						local var_338_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_20.prefab_name].transform, "story_v_out_426031", "426031083", "story_v_out_426031.awb")

						arg_335_1:RecordAudio("426031083", var_338_26)
						arg_335_1:RecordAudio("426031083", var_338_26)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_426031", "426031083", "story_v_out_426031.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_426031", "426031083", "story_v_out_426031.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_27 = math.max(var_338_18, arg_335_1.talkMaxDuration)

			if var_338_17 <= arg_335_1.time_ and arg_335_1.time_ < var_338_17 + var_338_27 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_17) / var_338_27

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_17 + var_338_27 and arg_335_1.time_ < var_338_17 + var_338_27 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426031084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 426031084
		arg_339_1.duration_ = 9.17

		local var_339_0 = {
			zh = 5.1,
			ja = 9.166
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
				arg_339_0:Play426031085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["6148ui_story"].transform
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.var_.moveOldPos6148ui_story = var_342_0.localPosition

				local var_342_2 = GameObjectTools.GetOrAddComponent(var_342_0.gameObject, typeof(DynamicBoneHelper))

				if var_342_2 then
					var_342_2:EnableDynamicBone(false)
				end
			end

			local var_342_3 = 0.001

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_3 then
				local var_342_4 = (arg_339_1.time_ - var_342_1) / var_342_3
				local var_342_5 = Vector3.New(0, -0.985, -6)

				var_342_0.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos6148ui_story, var_342_5, var_342_4)

				local var_342_6 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_6.x, var_342_6.y, var_342_6.z)

				local var_342_7 = var_342_0.localEulerAngles

				var_342_7.z = 0
				var_342_7.x = 0
				var_342_0.localEulerAngles = var_342_7
			end

			if arg_339_1.time_ >= var_342_1 + var_342_3 and arg_339_1.time_ < var_342_1 + var_342_3 + arg_342_0 then
				var_342_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_342_8 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_8.x, var_342_8.y, var_342_8.z)

				local var_342_9 = var_342_0.localEulerAngles

				var_342_9.z = 0
				var_342_9.x = 0
				var_342_0.localEulerAngles = var_342_9

				local var_342_10 = GameObjectTools.GetOrAddComponent(var_342_0.gameObject, typeof(DynamicBoneHelper))

				if var_342_10 then
					var_342_10:EnableDynamicBone(true)
				end
			end

			local var_342_11 = 0

			if var_342_11 < arg_339_1.time_ and arg_339_1.time_ <= var_342_11 + arg_342_0 then
				arg_339_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_342_12 = 0

			if var_342_12 < arg_339_1.time_ and arg_339_1.time_ <= var_342_12 + arg_342_0 then
				arg_339_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_342_13 = 0
			local var_342_14 = 0.575

			if var_342_13 < arg_339_1.time_ and arg_339_1.time_ <= var_342_13 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_15 = arg_339_1:FormatText(StoryNameCfg[1488].name)

				arg_339_1.leftNameTxt_.text = var_342_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_16 = arg_339_1:GetWordFromCfg(426031084)
				local var_342_17 = arg_339_1:FormatText(var_342_16.content)

				arg_339_1.text_.text = var_342_17

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_18 = 23
				local var_342_19 = utf8.len(var_342_17)
				local var_342_20 = var_342_18 <= 0 and var_342_14 or var_342_14 * (var_342_19 / var_342_18)

				if var_342_20 > 0 and var_342_14 < var_342_20 then
					arg_339_1.talkMaxDuration = var_342_20

					if var_342_20 + var_342_13 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_20 + var_342_13
					end
				end

				arg_339_1.text_.text = var_342_17
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031084", "story_v_out_426031.awb") ~= 0 then
					local var_342_21 = manager.audio:GetVoiceLength("story_v_out_426031", "426031084", "story_v_out_426031.awb") / 1000

					if var_342_21 + var_342_13 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_21 + var_342_13
					end

					if var_342_16.prefab_name ~= "" and arg_339_1.actors_[var_342_16.prefab_name] ~= nil then
						local var_342_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_16.prefab_name].transform, "story_v_out_426031", "426031084", "story_v_out_426031.awb")

						arg_339_1:RecordAudio("426031084", var_342_22)
						arg_339_1:RecordAudio("426031084", var_342_22)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_426031", "426031084", "story_v_out_426031.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_426031", "426031084", "story_v_out_426031.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_23 = math.max(var_342_14, arg_339_1.talkMaxDuration)

			if var_342_13 <= arg_339_1.time_ and arg_339_1.time_ < var_342_13 + var_342_23 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_13) / var_342_23

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_13 + var_342_23 and arg_339_1.time_ < var_342_13 + var_342_23 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426031085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 426031085
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
			arg_343_1.auto_ = false
		end

		function arg_343_1.playNext_(arg_345_0)
			arg_343_1.onStoryFinished_()
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["6148ui_story"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect6148ui_story == nil then
				arg_343_1.var_.characterEffect6148ui_story = var_346_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.200000002980232

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.characterEffect6148ui_story and not isNil(var_346_0) then
					local var_346_4 = Mathf.Lerp(0, 0.5, var_346_3)

					arg_343_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_343_1.var_.characterEffect6148ui_story.fillRatio = var_346_4
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect6148ui_story then
				local var_346_5 = 0.5

				arg_343_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_343_1.var_.characterEffect6148ui_story.fillRatio = var_346_5
			end

			local var_346_6 = 0.433333333333333
			local var_346_7 = 1

			if var_346_6 < arg_343_1.time_ and arg_343_1.time_ <= var_346_6 + arg_346_0 then
				local var_346_8 = "play"
				local var_346_9 = "effect"

				arg_343_1:AudioAction(var_346_8, var_346_9, "se_story_1311", "se_story_1311_footsteps", "")
			end

			local var_346_10 = arg_343_1.actors_["6148ui_story"].transform
			local var_346_11 = 0

			if var_346_11 < arg_343_1.time_ and arg_343_1.time_ <= var_346_11 + arg_346_0 then
				arg_343_1.var_.moveOldPos6148ui_story = var_346_10.localPosition

				local var_346_12 = GameObjectTools.GetOrAddComponent(var_346_10.gameObject, typeof(DynamicBoneHelper))

				if var_346_12 then
					var_346_12:EnableDynamicBone(false)
				end
			end

			local var_346_13 = 0.001

			if var_346_11 <= arg_343_1.time_ and arg_343_1.time_ < var_346_11 + var_346_13 then
				local var_346_14 = (arg_343_1.time_ - var_346_11) / var_346_13
				local var_346_15 = Vector3.New(0, 100, 0)

				var_346_10.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos6148ui_story, var_346_15, var_346_14)

				local var_346_16 = manager.ui.mainCamera.transform.position - var_346_10.position

				var_346_10.forward = Vector3.New(var_346_16.x, var_346_16.y, var_346_16.z)

				local var_346_17 = var_346_10.localEulerAngles

				var_346_17.z = 0
				var_346_17.x = 0
				var_346_10.localEulerAngles = var_346_17
			end

			if arg_343_1.time_ >= var_346_11 + var_346_13 and arg_343_1.time_ < var_346_11 + var_346_13 + arg_346_0 then
				var_346_10.localPosition = Vector3.New(0, 100, 0)

				local var_346_18 = manager.ui.mainCamera.transform.position - var_346_10.position

				var_346_10.forward = Vector3.New(var_346_18.x, var_346_18.y, var_346_18.z)

				local var_346_19 = var_346_10.localEulerAngles

				var_346_19.z = 0
				var_346_19.x = 0
				var_346_10.localEulerAngles = var_346_19

				local var_346_20 = GameObjectTools.GetOrAddComponent(var_346_10.gameObject, typeof(DynamicBoneHelper))

				if var_346_20 then
					var_346_20:EnableDynamicBone(true)
				end
			end

			local var_346_21 = 0
			local var_346_22 = 1.05

			if var_346_21 < arg_343_1.time_ and arg_343_1.time_ <= var_346_21 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_23 = arg_343_1:GetWordFromCfg(426031085)
				local var_346_24 = arg_343_1:FormatText(var_346_23.content)

				arg_343_1.text_.text = var_346_24

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_25 = 42
				local var_346_26 = utf8.len(var_346_24)
				local var_346_27 = var_346_25 <= 0 and var_346_22 or var_346_22 * (var_346_26 / var_346_25)

				if var_346_27 > 0 and var_346_22 < var_346_27 then
					arg_343_1.talkMaxDuration = var_346_27

					if var_346_27 + var_346_21 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_27 + var_346_21
					end
				end

				arg_343_1.text_.text = var_346_24
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_28 = math.max(var_346_22, arg_343_1.talkMaxDuration)

			if var_346_21 <= arg_343_1.time_ and arg_343_1.time_ < var_346_21 + var_346_28 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_21) / var_346_28

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_21 + var_346_28 and arg_343_1.time_ < var_346_21 + var_346_28 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J03f",
		"TextureConfig/Background/J03g"
	},
	voices = {
		"story_v_out_426031.awb"
	}
}
