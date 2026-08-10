return {
	Play421032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421032001
		arg_1_1.duration_ = 6.47

		local var_1_0 = {
			zh = 4.165999999999,
			ja = 6.465999999999
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
				arg_1_0:Play421032002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2401"

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
				local var_4_5 = arg_1_1.bgs_.ST2401

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
					if iter_4_0 ~= "ST2401" then
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

			local var_4_22 = 1.999999999999

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_23 = 0.133333333334333

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_24 = "10145ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "10145ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["10145ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos10145ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(-0.65, -1, -6.2)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10145ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(-0.65, -1, -6.2)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["10145ui_story"]
			local var_4_39 = 1.8

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect10145ui_story == nil then
				arg_1_1.var_.characterEffect10145ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect10145ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect10145ui_story then
				arg_1_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_4_44 = 0.1
			local var_4_45 = 1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "effect"

				arg_1_1:AudioAction(var_4_46, var_4_47, "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			local var_4_48 = 0
			local var_4_49 = 0.3

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_53 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_53 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_53

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_53
						arg_1_1.bgmTxt2_.text = var_4_53
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

			local var_4_54 = 0.566666666666667
			local var_4_55 = 1

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				local var_4_56 = "play"
				local var_4_57 = "music"

				arg_1_1:AudioAction(var_4_56, var_4_57, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_58 = ""
				local var_4_59 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_4_59 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_59 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_59

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_59
						arg_1_1.bgmTxt2_.text = var_4_59
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

			local var_4_60 = 1.999999999999
			local var_4_61 = 0.275

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

				local var_4_63 = arg_1_1:FormatText(StoryNameCfg[1308].name)

				arg_1_1.leftNameTxt_.text = var_4_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_64 = arg_1_1:GetWordFromCfg(421032001)
				local var_4_65 = arg_1_1:FormatText(var_4_64.content)

				arg_1_1.text_.text = var_4_65

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_66 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032001", "story_v_out_421032.awb") ~= 0 then
					local var_4_69 = manager.audio:GetVoiceLength("story_v_out_421032", "421032001", "story_v_out_421032.awb") / 1000

					if var_4_69 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_60
					end

					if var_4_64.prefab_name ~= "" and arg_1_1.actors_[var_4_64.prefab_name] ~= nil then
						local var_4_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_64.prefab_name].transform, "story_v_out_421032", "421032001", "story_v_out_421032.awb")

						arg_1_1:RecordAudio("421032001", var_4_70)
						arg_1_1:RecordAudio("421032001", var_4_70)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_421032", "421032001", "story_v_out_421032.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_421032", "421032001", "story_v_out_421032.awb")
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
				actorName = "10145ui_story",
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
	Play421032002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 421032002
		arg_9_1.duration_ = 2

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play421032003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1047ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_9_1.stage_.transform)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentInChildren(typeof(CharacterEffect))

					var_12_3.enabled = true

					local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_2, typeof(DynamicBoneHelper))

					if var_12_4 then
						var_12_4:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_3.transform, false)

					arg_9_1.var_[var_12_0 .. "Animator"] = var_12_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_0 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_0 .. "LipSync"] = var_12_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_5 = arg_9_1.actors_["1047ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1047ui_story = var_12_5.localPosition

				local var_12_7 = "1047ui_story"

				arg_9_1:ShowWeapon(arg_9_1.var_[var_12_7 .. "Animator"].transform, false)
			end

			local var_12_8 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_6) / var_12_8
				local var_12_10 = Vector3.New(0.74, -1.13, -6.2)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1047ui_story, var_12_10, var_12_9)

				local var_12_11 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_11.x, var_12_11.y, var_12_11.z)

				local var_12_12 = var_12_5.localEulerAngles

				var_12_12.z = 0
				var_12_12.x = 0
				var_12_5.localEulerAngles = var_12_12
			end

			if arg_9_1.time_ >= var_12_6 + var_12_8 and arg_9_1.time_ < var_12_6 + var_12_8 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0.74, -1.13, -6.2)

				local var_12_13 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_13.x, var_12_13.y, var_12_13.z)

				local var_12_14 = var_12_5.localEulerAngles

				var_12_14.z = 0
				var_12_14.x = 0
				var_12_5.localEulerAngles = var_12_14
			end

			local var_12_15 = arg_9_1.actors_["1047ui_story"]
			local var_12_16 = 0

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.characterEffect1047ui_story == nil then
				arg_9_1.var_.characterEffect1047ui_story = var_12_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_17 = 0.200000002980232

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_17 and not isNil(var_12_15) then
				local var_12_18 = (arg_9_1.time_ - var_12_16) / var_12_17

				if arg_9_1.var_.characterEffect1047ui_story and not isNil(var_12_15) then
					arg_9_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_16 + var_12_17 and arg_9_1.time_ < var_12_16 + var_12_17 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.characterEffect1047ui_story then
				arg_9_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_12_19 = arg_9_1.actors_["10145ui_story"]
			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 and not isNil(var_12_19) and arg_9_1.var_.characterEffect10145ui_story == nil then
				arg_9_1.var_.characterEffect10145ui_story = var_12_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_21 = 0.200000002980232

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_21 and not isNil(var_12_19) then
				local var_12_22 = (arg_9_1.time_ - var_12_20) / var_12_21

				if arg_9_1.var_.characterEffect10145ui_story and not isNil(var_12_19) then
					local var_12_23 = Mathf.Lerp(0, 0.5, var_12_22)

					arg_9_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10145ui_story.fillRatio = var_12_23
				end
			end

			if arg_9_1.time_ >= var_12_20 + var_12_21 and arg_9_1.time_ < var_12_20 + var_12_21 + arg_12_0 and not isNil(var_12_19) and arg_9_1.var_.characterEffect10145ui_story then
				local var_12_24 = 0.5

				arg_9_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10145ui_story.fillRatio = var_12_24
			end

			local var_12_25 = 0

			if var_12_25 < arg_9_1.time_ and arg_9_1.time_ <= var_12_25 + arg_12_0 then
				arg_9_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_12_26 = 0

			if var_12_26 < arg_9_1.time_ and arg_9_1.time_ <= var_12_26 + arg_12_0 then
				arg_9_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_12_27 = 0
			local var_12_28 = 0.2

			if var_12_27 < arg_9_1.time_ and arg_9_1.time_ <= var_12_27 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_29 = arg_9_1:FormatText(StoryNameCfg[1296].name)

				arg_9_1.leftNameTxt_.text = var_12_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_30 = arg_9_1:GetWordFromCfg(421032002)
				local var_12_31 = arg_9_1:FormatText(var_12_30.content)

				arg_9_1.text_.text = var_12_31

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_32 = 8
				local var_12_33 = utf8.len(var_12_31)
				local var_12_34 = var_12_32 <= 0 and var_12_28 or var_12_28 * (var_12_33 / var_12_32)

				if var_12_34 > 0 and var_12_28 < var_12_34 then
					arg_9_1.talkMaxDuration = var_12_34

					if var_12_34 + var_12_27 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_34 + var_12_27
					end
				end

				arg_9_1.text_.text = var_12_31
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032002", "story_v_out_421032.awb") ~= 0 then
					local var_12_35 = manager.audio:GetVoiceLength("story_v_out_421032", "421032002", "story_v_out_421032.awb") / 1000

					if var_12_35 + var_12_27 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_35 + var_12_27
					end

					if var_12_30.prefab_name ~= "" and arg_9_1.actors_[var_12_30.prefab_name] ~= nil then
						local var_12_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_30.prefab_name].transform, "story_v_out_421032", "421032002", "story_v_out_421032.awb")

						arg_9_1:RecordAudio("421032002", var_12_36)
						arg_9_1:RecordAudio("421032002", var_12_36)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_421032", "421032002", "story_v_out_421032.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_421032", "421032002", "story_v_out_421032.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_37 = math.max(var_12_28, arg_9_1.talkMaxDuration)

			if var_12_27 <= arg_9_1.time_ and arg_9_1.time_ < var_12_27 + var_12_37 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_27) / var_12_37

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_27 + var_12_37 and arg_9_1.time_ < var_12_27 + var_12_37 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421032003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 421032003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play421032004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1047ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1047ui_story == nil then
				arg_13_1.var_.characterEffect1047ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1047ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1047ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1047ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1047ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 0.25

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_8 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_9 = arg_13_1:GetWordFromCfg(421032003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 10
				local var_16_12 = utf8.len(var_16_10)
				local var_16_13 = var_16_11 <= 0 and var_16_7 or var_16_7 * (var_16_12 / var_16_11)

				if var_16_13 > 0 and var_16_7 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_14 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_14 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_14

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_14 and arg_13_1.time_ < var_16_6 + var_16_14 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play421032004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 421032004
		arg_17_1.duration_ = 6.8

		local var_17_0 = {
			zh = 6.433,
			ja = 6.8
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
				arg_17_0:Play421032005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "ST2105"

			if arg_17_1.bgs_[var_20_0] == nil then
				local var_20_1 = Object.Instantiate(arg_17_1.paintGo_)

				var_20_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_20_0)
				var_20_1.name = var_20_0
				var_20_1.transform.parent = arg_17_1.stage_.transform
				var_20_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.bgs_[var_20_0] = var_20_1
			end

			local var_20_2 = 2

			if var_20_2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				local var_20_3 = manager.ui.mainCamera.transform.localPosition
				local var_20_4 = Vector3.New(0, 0, 10) + Vector3.New(var_20_3.x, var_20_3.y, 0)
				local var_20_5 = arg_17_1.bgs_.ST2105

				var_20_5.transform.localPosition = var_20_4
				var_20_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_6 = var_20_5:GetComponent("SpriteRenderer")

				if var_20_6 and var_20_6.sprite then
					local var_20_7 = (var_20_5.transform.localPosition - var_20_3).z
					local var_20_8 = manager.ui.mainCameraCom_
					local var_20_9 = 2 * var_20_7 * Mathf.Tan(var_20_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_20_10 = var_20_9 * var_20_8.aspect
					local var_20_11 = var_20_6.sprite.bounds.size.x
					local var_20_12 = var_20_6.sprite.bounds.size.y
					local var_20_13 = var_20_10 / var_20_11
					local var_20_14 = var_20_9 / var_20_12
					local var_20_15 = var_20_14 < var_20_13 and var_20_13 or var_20_14

					var_20_5.transform.localScale = Vector3.New(var_20_15, var_20_15, 0)
				end

				for iter_20_0, iter_20_1 in pairs(arg_17_1.bgs_) do
					if iter_20_0 ~= "ST2105" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_20_16 = 4

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			local var_20_17 = 0.0999999999999996

			if arg_17_1.time_ >= var_20_16 + var_20_17 and arg_17_1.time_ < var_20_16 + var_20_17 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_19 = 2

			if var_20_18 <= arg_17_1.time_ and arg_17_1.time_ < var_20_18 + var_20_19 then
				local var_20_20 = (arg_17_1.time_ - var_20_18) / var_20_19
				local var_20_21 = Color.New(0, 0, 0)

				var_20_21.a = Mathf.Lerp(0, 1, var_20_20)
				arg_17_1.mask_.color = var_20_21
			end

			if arg_17_1.time_ >= var_20_18 + var_20_19 and arg_17_1.time_ < var_20_18 + var_20_19 + arg_20_0 then
				local var_20_22 = Color.New(0, 0, 0)

				var_20_22.a = 1
				arg_17_1.mask_.color = var_20_22
			end

			local var_20_23 = 2

			if var_20_23 < arg_17_1.time_ and arg_17_1.time_ <= var_20_23 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_24 = 2

			if var_20_23 <= arg_17_1.time_ and arg_17_1.time_ < var_20_23 + var_20_24 then
				local var_20_25 = (arg_17_1.time_ - var_20_23) / var_20_24
				local var_20_26 = Color.New(0, 0, 0)

				var_20_26.a = Mathf.Lerp(1, 0, var_20_25)
				arg_17_1.mask_.color = var_20_26
			end

			if arg_17_1.time_ >= var_20_23 + var_20_24 and arg_17_1.time_ < var_20_23 + var_20_24 + arg_20_0 then
				local var_20_27 = Color.New(0, 0, 0)
				local var_20_28 = 0

				arg_17_1.mask_.enabled = false
				var_20_27.a = var_20_28
				arg_17_1.mask_.color = var_20_27
			end

			local var_20_29 = arg_17_1.actors_["1047ui_story"].transform
			local var_20_30 = 2

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 then
				arg_17_1.var_.moveOldPos1047ui_story = var_20_29.localPosition
			end

			local var_20_31 = 0.001

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_31 then
				local var_20_32 = (arg_17_1.time_ - var_20_30) / var_20_31
				local var_20_33 = Vector3.New(0, 100, 0)

				var_20_29.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1047ui_story, var_20_33, var_20_32)

				local var_20_34 = manager.ui.mainCamera.transform.position - var_20_29.position

				var_20_29.forward = Vector3.New(var_20_34.x, var_20_34.y, var_20_34.z)

				local var_20_35 = var_20_29.localEulerAngles

				var_20_35.z = 0
				var_20_35.x = 0
				var_20_29.localEulerAngles = var_20_35
			end

			if arg_17_1.time_ >= var_20_30 + var_20_31 and arg_17_1.time_ < var_20_30 + var_20_31 + arg_20_0 then
				var_20_29.localPosition = Vector3.New(0, 100, 0)

				local var_20_36 = manager.ui.mainCamera.transform.position - var_20_29.position

				var_20_29.forward = Vector3.New(var_20_36.x, var_20_36.y, var_20_36.z)

				local var_20_37 = var_20_29.localEulerAngles

				var_20_37.z = 0
				var_20_37.x = 0
				var_20_29.localEulerAngles = var_20_37
			end

			local var_20_38 = arg_17_1.actors_["10145ui_story"].transform
			local var_20_39 = 2

			if var_20_39 < arg_17_1.time_ and arg_17_1.time_ <= var_20_39 + arg_20_0 then
				arg_17_1.var_.moveOldPos10145ui_story = var_20_38.localPosition
			end

			local var_20_40 = 0.001

			if var_20_39 <= arg_17_1.time_ and arg_17_1.time_ < var_20_39 + var_20_40 then
				local var_20_41 = (arg_17_1.time_ - var_20_39) / var_20_40
				local var_20_42 = Vector3.New(0, 100, 0)

				var_20_38.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10145ui_story, var_20_42, var_20_41)

				local var_20_43 = manager.ui.mainCamera.transform.position - var_20_38.position

				var_20_38.forward = Vector3.New(var_20_43.x, var_20_43.y, var_20_43.z)

				local var_20_44 = var_20_38.localEulerAngles

				var_20_44.z = 0
				var_20_44.x = 0
				var_20_38.localEulerAngles = var_20_44
			end

			if arg_17_1.time_ >= var_20_39 + var_20_40 and arg_17_1.time_ < var_20_39 + var_20_40 + arg_20_0 then
				var_20_38.localPosition = Vector3.New(0, 100, 0)

				local var_20_45 = manager.ui.mainCamera.transform.position - var_20_38.position

				var_20_38.forward = Vector3.New(var_20_45.x, var_20_45.y, var_20_45.z)

				local var_20_46 = var_20_38.localEulerAngles

				var_20_46.z = 0
				var_20_46.x = 0
				var_20_38.localEulerAngles = var_20_46
			end

			local var_20_47 = "10102ui_story"

			if arg_17_1.actors_[var_20_47] == nil then
				local var_20_48 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_20_48) then
					local var_20_49 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_17_1.stage_.transform)

					var_20_49.name = var_20_47
					var_20_49.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_47] = var_20_49

					local var_20_50 = var_20_49:GetComponentInChildren(typeof(CharacterEffect))

					var_20_50.enabled = true

					local var_20_51 = GameObjectTools.GetOrAddComponent(var_20_49, typeof(DynamicBoneHelper))

					if var_20_51 then
						var_20_51:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_50.transform, false)

					arg_17_1.var_[var_20_47 .. "Animator"] = var_20_50.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_47 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_47 .. "LipSync"] = var_20_50.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_52 = arg_17_1.actors_["10102ui_story"].transform
			local var_20_53 = 3.83333333333333

			if var_20_53 < arg_17_1.time_ and arg_17_1.time_ <= var_20_53 + arg_20_0 then
				arg_17_1.var_.moveOldPos10102ui_story = var_20_52.localPosition
			end

			local var_20_54 = 0.001

			if var_20_53 <= arg_17_1.time_ and arg_17_1.time_ < var_20_53 + var_20_54 then
				local var_20_55 = (arg_17_1.time_ - var_20_53) / var_20_54
				local var_20_56 = Vector3.New(0, -0.985, -6.275)

				var_20_52.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10102ui_story, var_20_56, var_20_55)

				local var_20_57 = manager.ui.mainCamera.transform.position - var_20_52.position

				var_20_52.forward = Vector3.New(var_20_57.x, var_20_57.y, var_20_57.z)

				local var_20_58 = var_20_52.localEulerAngles

				var_20_58.z = 0
				var_20_58.x = 0
				var_20_52.localEulerAngles = var_20_58
			end

			if arg_17_1.time_ >= var_20_53 + var_20_54 and arg_17_1.time_ < var_20_53 + var_20_54 + arg_20_0 then
				var_20_52.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_20_59 = manager.ui.mainCamera.transform.position - var_20_52.position

				var_20_52.forward = Vector3.New(var_20_59.x, var_20_59.y, var_20_59.z)

				local var_20_60 = var_20_52.localEulerAngles

				var_20_60.z = 0
				var_20_60.x = 0
				var_20_52.localEulerAngles = var_20_60
			end

			local var_20_61 = arg_17_1.actors_["10102ui_story"]
			local var_20_62 = 3.83333333333333

			if var_20_62 < arg_17_1.time_ and arg_17_1.time_ <= var_20_62 + arg_20_0 and not isNil(var_20_61) and arg_17_1.var_.characterEffect10102ui_story == nil then
				arg_17_1.var_.characterEffect10102ui_story = var_20_61:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_63 = 0.200000002980232

			if var_20_62 <= arg_17_1.time_ and arg_17_1.time_ < var_20_62 + var_20_63 and not isNil(var_20_61) then
				local var_20_64 = (arg_17_1.time_ - var_20_62) / var_20_63

				if arg_17_1.var_.characterEffect10102ui_story and not isNil(var_20_61) then
					arg_17_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_62 + var_20_63 and arg_17_1.time_ < var_20_62 + var_20_63 + arg_20_0 and not isNil(var_20_61) and arg_17_1.var_.characterEffect10102ui_story then
				arg_17_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_20_65 = 3.83333333333333

			if var_20_65 < arg_17_1.time_ and arg_17_1.time_ <= var_20_65 + arg_20_0 then
				arg_17_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			local var_20_66 = 3.83333333333333

			if var_20_66 < arg_17_1.time_ and arg_17_1.time_ <= var_20_66 + arg_20_0 then
				arg_17_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_20_67 = 0.1
			local var_20_68 = 1

			if var_20_67 < arg_17_1.time_ and arg_17_1.time_ <= var_20_67 + arg_20_0 then
				local var_20_69 = "stop"
				local var_20_70 = "effect"

				arg_17_1:AudioAction(var_20_69, var_20_70, "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			local var_20_71 = 1.6
			local var_20_72 = 1

			if var_20_71 < arg_17_1.time_ and arg_17_1.time_ <= var_20_71 + arg_20_0 then
				local var_20_73 = "play"
				local var_20_74 = "effect"

				arg_17_1:AudioAction(var_20_73, var_20_74, "se_story_133", "se_story_133_sea", "")
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_75 = 4
			local var_20_76 = 0.35

			if var_20_75 < arg_17_1.time_ and arg_17_1.time_ <= var_20_75 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_77 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_77:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_77:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_77:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_78 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_78

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_79 = arg_17_1:GetWordFromCfg(421032004)
				local var_20_80 = arg_17_1:FormatText(var_20_79.content)

				arg_17_1.text_.text = var_20_80

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_81 = 14
				local var_20_82 = utf8.len(var_20_80)
				local var_20_83 = var_20_81 <= 0 and var_20_76 or var_20_76 * (var_20_82 / var_20_81)

				if var_20_83 > 0 and var_20_76 < var_20_83 then
					arg_17_1.talkMaxDuration = var_20_83
					var_20_75 = var_20_75 + 0.3

					if var_20_83 + var_20_75 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_83 + var_20_75
					end
				end

				arg_17_1.text_.text = var_20_80
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032004", "story_v_out_421032.awb") ~= 0 then
					local var_20_84 = manager.audio:GetVoiceLength("story_v_out_421032", "421032004", "story_v_out_421032.awb") / 1000

					if var_20_84 + var_20_75 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_84 + var_20_75
					end

					if var_20_79.prefab_name ~= "" and arg_17_1.actors_[var_20_79.prefab_name] ~= nil then
						local var_20_85 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_79.prefab_name].transform, "story_v_out_421032", "421032004", "story_v_out_421032.awb")

						arg_17_1:RecordAudio("421032004", var_20_85)
						arg_17_1:RecordAudio("421032004", var_20_85)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_421032", "421032004", "story_v_out_421032.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_421032", "421032004", "story_v_out_421032.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_86 = var_20_75 + 0.3
			local var_20_87 = math.max(var_20_76, arg_17_1.talkMaxDuration)

			if var_20_86 <= arg_17_1.time_ and arg_17_1.time_ < var_20_86 + var_20_87 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_86) / var_20_87

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_86 + var_20_87 and arg_17_1.time_ < var_20_86 + var_20_87 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play421032005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 421032005
		arg_23_1.duration_ = 6.17

		local var_23_0 = {
			zh = 3.366,
			ja = 6.166
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
				arg_23_0:Play421032006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["10102ui_story"].transform
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.var_.moveOldPos10102ui_story = var_26_0.localPosition
			end

			local var_26_2 = 0.001

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2
				local var_26_4 = Vector3.New(0, 100, 0)

				var_26_0.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10102ui_story, var_26_4, var_26_3)

				local var_26_5 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_5.x, var_26_5.y, var_26_5.z)

				local var_26_6 = var_26_0.localEulerAngles

				var_26_6.z = 0
				var_26_6.x = 0
				var_26_0.localEulerAngles = var_26_6
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 then
				var_26_0.localPosition = Vector3.New(0, 100, 0)

				local var_26_7 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_7.x, var_26_7.y, var_26_7.z)

				local var_26_8 = var_26_0.localEulerAngles

				var_26_8.z = 0
				var_26_8.x = 0
				var_26_0.localEulerAngles = var_26_8
			end

			local var_26_9 = arg_23_1.actors_["10145ui_story"].transform
			local var_26_10 = 0

			if var_26_10 < arg_23_1.time_ and arg_23_1.time_ <= var_26_10 + arg_26_0 then
				arg_23_1.var_.moveOldPos10145ui_story = var_26_9.localPosition
			end

			local var_26_11 = 0.001

			if var_26_10 <= arg_23_1.time_ and arg_23_1.time_ < var_26_10 + var_26_11 then
				local var_26_12 = (arg_23_1.time_ - var_26_10) / var_26_11
				local var_26_13 = Vector3.New(0, -1, -6.2)

				var_26_9.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10145ui_story, var_26_13, var_26_12)

				local var_26_14 = manager.ui.mainCamera.transform.position - var_26_9.position

				var_26_9.forward = Vector3.New(var_26_14.x, var_26_14.y, var_26_14.z)

				local var_26_15 = var_26_9.localEulerAngles

				var_26_15.z = 0
				var_26_15.x = 0
				var_26_9.localEulerAngles = var_26_15
			end

			if arg_23_1.time_ >= var_26_10 + var_26_11 and arg_23_1.time_ < var_26_10 + var_26_11 + arg_26_0 then
				var_26_9.localPosition = Vector3.New(0, -1, -6.2)

				local var_26_16 = manager.ui.mainCamera.transform.position - var_26_9.position

				var_26_9.forward = Vector3.New(var_26_16.x, var_26_16.y, var_26_16.z)

				local var_26_17 = var_26_9.localEulerAngles

				var_26_17.z = 0
				var_26_17.x = 0
				var_26_9.localEulerAngles = var_26_17
			end

			local var_26_18 = arg_23_1.actors_["10145ui_story"]
			local var_26_19 = 0

			if var_26_19 < arg_23_1.time_ and arg_23_1.time_ <= var_26_19 + arg_26_0 and not isNil(var_26_18) and arg_23_1.var_.characterEffect10145ui_story == nil then
				arg_23_1.var_.characterEffect10145ui_story = var_26_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_20 = 0.200000002980232

			if var_26_19 <= arg_23_1.time_ and arg_23_1.time_ < var_26_19 + var_26_20 and not isNil(var_26_18) then
				local var_26_21 = (arg_23_1.time_ - var_26_19) / var_26_20

				if arg_23_1.var_.characterEffect10145ui_story and not isNil(var_26_18) then
					arg_23_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_19 + var_26_20 and arg_23_1.time_ < var_26_19 + var_26_20 + arg_26_0 and not isNil(var_26_18) and arg_23_1.var_.characterEffect10145ui_story then
				arg_23_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_26_22 = arg_23_1.actors_["10102ui_story"]
			local var_26_23 = 0

			if var_26_23 < arg_23_1.time_ and arg_23_1.time_ <= var_26_23 + arg_26_0 and not isNil(var_26_22) and arg_23_1.var_.characterEffect10102ui_story == nil then
				arg_23_1.var_.characterEffect10102ui_story = var_26_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_24 = 0.200000002980232

			if var_26_23 <= arg_23_1.time_ and arg_23_1.time_ < var_26_23 + var_26_24 and not isNil(var_26_22) then
				local var_26_25 = (arg_23_1.time_ - var_26_23) / var_26_24

				if arg_23_1.var_.characterEffect10102ui_story and not isNil(var_26_22) then
					local var_26_26 = Mathf.Lerp(0, 0.5, var_26_25)

					arg_23_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_23_1.var_.characterEffect10102ui_story.fillRatio = var_26_26
				end
			end

			if arg_23_1.time_ >= var_26_23 + var_26_24 and arg_23_1.time_ < var_26_23 + var_26_24 + arg_26_0 and not isNil(var_26_22) and arg_23_1.var_.characterEffect10102ui_story then
				local var_26_27 = 0.5

				arg_23_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_23_1.var_.characterEffect10102ui_story.fillRatio = var_26_27
			end

			local var_26_28 = 0

			if var_26_28 < arg_23_1.time_ and arg_23_1.time_ <= var_26_28 + arg_26_0 then
				arg_23_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_1")
			end

			local var_26_29 = 0

			if var_26_29 < arg_23_1.time_ and arg_23_1.time_ <= var_26_29 + arg_26_0 then
				arg_23_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_26_30 = 0
			local var_26_31 = 0.475

			if var_26_30 < arg_23_1.time_ and arg_23_1.time_ <= var_26_30 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_32 = arg_23_1:FormatText(StoryNameCfg[1308].name)

				arg_23_1.leftNameTxt_.text = var_26_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_33 = arg_23_1:GetWordFromCfg(421032005)
				local var_26_34 = arg_23_1:FormatText(var_26_33.content)

				arg_23_1.text_.text = var_26_34

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_35 = 19
				local var_26_36 = utf8.len(var_26_34)
				local var_26_37 = var_26_35 <= 0 and var_26_31 or var_26_31 * (var_26_36 / var_26_35)

				if var_26_37 > 0 and var_26_31 < var_26_37 then
					arg_23_1.talkMaxDuration = var_26_37

					if var_26_37 + var_26_30 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_37 + var_26_30
					end
				end

				arg_23_1.text_.text = var_26_34
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032005", "story_v_out_421032.awb") ~= 0 then
					local var_26_38 = manager.audio:GetVoiceLength("story_v_out_421032", "421032005", "story_v_out_421032.awb") / 1000

					if var_26_38 + var_26_30 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_38 + var_26_30
					end

					if var_26_33.prefab_name ~= "" and arg_23_1.actors_[var_26_33.prefab_name] ~= nil then
						local var_26_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_33.prefab_name].transform, "story_v_out_421032", "421032005", "story_v_out_421032.awb")

						arg_23_1:RecordAudio("421032005", var_26_39)
						arg_23_1:RecordAudio("421032005", var_26_39)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_421032", "421032005", "story_v_out_421032.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_421032", "421032005", "story_v_out_421032.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_40 = math.max(var_26_31, arg_23_1.talkMaxDuration)

			if var_26_30 <= arg_23_1.time_ and arg_23_1.time_ < var_26_30 + var_26_40 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_30) / var_26_40

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_30 + var_26_40 and arg_23_1.time_ < var_26_30 + var_26_40 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421032006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 421032006
		arg_27_1.duration_ = 2.37

		local var_27_0 = {
			zh = 1.999999999999,
			ja = 2.366
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
				arg_27_0:Play421032007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1047ui_story"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos1047ui_story = var_30_0.localPosition

				local var_30_2 = "1047ui_story"

				arg_27_1:ShowWeapon(arg_27_1.var_[var_30_2 .. "Animator"].transform, false)
			end

			local var_30_3 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_3 then
				local var_30_4 = (arg_27_1.time_ - var_30_1) / var_30_3
				local var_30_5 = Vector3.New(0.74, -1.13, -6.2)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1047ui_story, var_30_5, var_30_4)

				local var_30_6 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_6.x, var_30_6.y, var_30_6.z)

				local var_30_7 = var_30_0.localEulerAngles

				var_30_7.z = 0
				var_30_7.x = 0
				var_30_0.localEulerAngles = var_30_7
			end

			if arg_27_1.time_ >= var_30_1 + var_30_3 and arg_27_1.time_ < var_30_1 + var_30_3 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(0.74, -1.13, -6.2)

				local var_30_8 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_8.x, var_30_8.y, var_30_8.z)

				local var_30_9 = var_30_0.localEulerAngles

				var_30_9.z = 0
				var_30_9.x = 0
				var_30_0.localEulerAngles = var_30_9
			end

			local var_30_10 = arg_27_1.actors_["1047ui_story"]
			local var_30_11 = 0

			if var_30_11 < arg_27_1.time_ and arg_27_1.time_ <= var_30_11 + arg_30_0 and not isNil(var_30_10) and arg_27_1.var_.characterEffect1047ui_story == nil then
				arg_27_1.var_.characterEffect1047ui_story = var_30_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_12 = 0.200000002980232

			if var_30_11 <= arg_27_1.time_ and arg_27_1.time_ < var_30_11 + var_30_12 and not isNil(var_30_10) then
				local var_30_13 = (arg_27_1.time_ - var_30_11) / var_30_12

				if arg_27_1.var_.characterEffect1047ui_story and not isNil(var_30_10) then
					arg_27_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_11 + var_30_12 and arg_27_1.time_ < var_30_11 + var_30_12 + arg_30_0 and not isNil(var_30_10) and arg_27_1.var_.characterEffect1047ui_story then
				arg_27_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_30_14 = arg_27_1.actors_["10145ui_story"]
			local var_30_15 = 0

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.characterEffect10145ui_story == nil then
				arg_27_1.var_.characterEffect10145ui_story = var_30_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_16 = 0.200000002980232

			if var_30_15 <= arg_27_1.time_ and arg_27_1.time_ < var_30_15 + var_30_16 and not isNil(var_30_14) then
				local var_30_17 = (arg_27_1.time_ - var_30_15) / var_30_16

				if arg_27_1.var_.characterEffect10145ui_story and not isNil(var_30_14) then
					local var_30_18 = Mathf.Lerp(0, 0.5, var_30_17)

					arg_27_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_27_1.var_.characterEffect10145ui_story.fillRatio = var_30_18
				end
			end

			if arg_27_1.time_ >= var_30_15 + var_30_16 and arg_27_1.time_ < var_30_15 + var_30_16 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.characterEffect10145ui_story then
				local var_30_19 = 0.5

				arg_27_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_27_1.var_.characterEffect10145ui_story.fillRatio = var_30_19
			end

			local var_30_20 = 0

			if var_30_20 < arg_27_1.time_ and arg_27_1.time_ <= var_30_20 + arg_30_0 then
				arg_27_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_30_21 = 0

			if var_30_21 < arg_27_1.time_ and arg_27_1.time_ <= var_30_21 + arg_30_0 then
				arg_27_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_30_22 = arg_27_1.actors_["10145ui_story"].transform
			local var_30_23 = 0

			if var_30_23 < arg_27_1.time_ and arg_27_1.time_ <= var_30_23 + arg_30_0 then
				arg_27_1.var_.moveOldPos10145ui_story = var_30_22.localPosition
			end

			local var_30_24 = 0.001

			if var_30_23 <= arg_27_1.time_ and arg_27_1.time_ < var_30_23 + var_30_24 then
				local var_30_25 = (arg_27_1.time_ - var_30_23) / var_30_24
				local var_30_26 = Vector3.New(-0.65, -1, -6.2)

				var_30_22.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10145ui_story, var_30_26, var_30_25)

				local var_30_27 = manager.ui.mainCamera.transform.position - var_30_22.position

				var_30_22.forward = Vector3.New(var_30_27.x, var_30_27.y, var_30_27.z)

				local var_30_28 = var_30_22.localEulerAngles

				var_30_28.z = 0
				var_30_28.x = 0
				var_30_22.localEulerAngles = var_30_28
			end

			if arg_27_1.time_ >= var_30_23 + var_30_24 and arg_27_1.time_ < var_30_23 + var_30_24 + arg_30_0 then
				var_30_22.localPosition = Vector3.New(-0.65, -1, -6.2)

				local var_30_29 = manager.ui.mainCamera.transform.position - var_30_22.position

				var_30_22.forward = Vector3.New(var_30_29.x, var_30_29.y, var_30_29.z)

				local var_30_30 = var_30_22.localEulerAngles

				var_30_30.z = 0
				var_30_30.x = 0
				var_30_22.localEulerAngles = var_30_30
			end

			local var_30_31 = 0
			local var_30_32 = 0.125

			if var_30_31 < arg_27_1.time_ and arg_27_1.time_ <= var_30_31 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_33 = arg_27_1:FormatText(StoryNameCfg[1296].name)

				arg_27_1.leftNameTxt_.text = var_30_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_34 = arg_27_1:GetWordFromCfg(421032006)
				local var_30_35 = arg_27_1:FormatText(var_30_34.content)

				arg_27_1.text_.text = var_30_35

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_36 = 5
				local var_30_37 = utf8.len(var_30_35)
				local var_30_38 = var_30_36 <= 0 and var_30_32 or var_30_32 * (var_30_37 / var_30_36)

				if var_30_38 > 0 and var_30_32 < var_30_38 then
					arg_27_1.talkMaxDuration = var_30_38

					if var_30_38 + var_30_31 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_38 + var_30_31
					end
				end

				arg_27_1.text_.text = var_30_35
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032006", "story_v_out_421032.awb") ~= 0 then
					local var_30_39 = manager.audio:GetVoiceLength("story_v_out_421032", "421032006", "story_v_out_421032.awb") / 1000

					if var_30_39 + var_30_31 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_39 + var_30_31
					end

					if var_30_34.prefab_name ~= "" and arg_27_1.actors_[var_30_34.prefab_name] ~= nil then
						local var_30_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_34.prefab_name].transform, "story_v_out_421032", "421032006", "story_v_out_421032.awb")

						arg_27_1:RecordAudio("421032006", var_30_40)
						arg_27_1:RecordAudio("421032006", var_30_40)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_421032", "421032006", "story_v_out_421032.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_421032", "421032006", "story_v_out_421032.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_41 = math.max(var_30_32, arg_27_1.talkMaxDuration)

			if var_30_31 <= arg_27_1.time_ and arg_27_1.time_ < var_30_31 + var_30_41 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_31) / var_30_41

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_31 + var_30_41 and arg_27_1.time_ < var_30_31 + var_30_41 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421032007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 421032007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play421032008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1047ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1047ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(0, 100, 0)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1047ui_story, var_34_4, var_34_3)

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

			local var_34_9 = arg_31_1.actors_["10145ui_story"].transform
			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1.var_.moveOldPos10145ui_story = var_34_9.localPosition
			end

			local var_34_11 = 0.001

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 then
				local var_34_12 = (arg_31_1.time_ - var_34_10) / var_34_11
				local var_34_13 = Vector3.New(0, 100, 0)

				var_34_9.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10145ui_story, var_34_13, var_34_12)

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

			local var_34_18 = 0.1
			local var_34_19 = 1

			if var_34_18 < arg_31_1.time_ and arg_31_1.time_ <= var_34_18 + arg_34_0 then
				local var_34_20 = "play"
				local var_34_21 = "effect"

				arg_31_1:AudioAction(var_34_20, var_34_21, "se_story_1310", "se_story_1310_car02", "")
			end

			local var_34_22 = 0
			local var_34_23 = 1.05

			if var_34_22 < arg_31_1.time_ and arg_31_1.time_ <= var_34_22 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_24 = arg_31_1:GetWordFromCfg(421032007)
				local var_34_25 = arg_31_1:FormatText(var_34_24.content)

				arg_31_1.text_.text = var_34_25

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_26 = 42
				local var_34_27 = utf8.len(var_34_25)
				local var_34_28 = var_34_26 <= 0 and var_34_23 or var_34_23 * (var_34_27 / var_34_26)

				if var_34_28 > 0 and var_34_23 < var_34_28 then
					arg_31_1.talkMaxDuration = var_34_28

					if var_34_28 + var_34_22 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_28 + var_34_22
					end
				end

				arg_31_1.text_.text = var_34_25
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_29 = math.max(var_34_23, arg_31_1.talkMaxDuration)

			if var_34_22 <= arg_31_1.time_ and arg_31_1.time_ < var_34_22 + var_34_29 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_22) / var_34_29

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_22 + var_34_29 and arg_31_1.time_ < var_34_22 + var_34_29 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421032008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 421032008
		arg_35_1.duration_ = 4.77

		local var_35_0 = {
			zh = 3.4,
			ja = 4.766
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
				arg_35_0:Play421032009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["10145ui_story"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos10145ui_story = var_38_0.localPosition
			end

			local var_38_2 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2
				local var_38_4 = Vector3.New(-0.65, -1, -6.2)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10145ui_story, var_38_4, var_38_3)

				local var_38_5 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_5.x, var_38_5.y, var_38_5.z)

				local var_38_6 = var_38_0.localEulerAngles

				var_38_6.z = 0
				var_38_6.x = 0
				var_38_0.localEulerAngles = var_38_6
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(-0.65, -1, -6.2)

				local var_38_7 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_7.x, var_38_7.y, var_38_7.z)

				local var_38_8 = var_38_0.localEulerAngles

				var_38_8.z = 0
				var_38_8.x = 0
				var_38_0.localEulerAngles = var_38_8
			end

			local var_38_9 = arg_35_1.actors_["10145ui_story"]
			local var_38_10 = 0

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect10145ui_story == nil then
				arg_35_1.var_.characterEffect10145ui_story = var_38_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_11 = 0.200000002980232

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_11 and not isNil(var_38_9) then
				local var_38_12 = (arg_35_1.time_ - var_38_10) / var_38_11

				if arg_35_1.var_.characterEffect10145ui_story and not isNil(var_38_9) then
					arg_35_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_10 + var_38_11 and arg_35_1.time_ < var_38_10 + var_38_11 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect10145ui_story then
				arg_35_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_38_13 = 0

			if var_38_13 < arg_35_1.time_ and arg_35_1.time_ <= var_38_13 + arg_38_0 then
				arg_35_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_2")
			end

			local var_38_14 = 0

			if var_38_14 < arg_35_1.time_ and arg_35_1.time_ <= var_38_14 + arg_38_0 then
				arg_35_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_38_15 = 0
			local var_38_16 = 0.575

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_17 = arg_35_1:FormatText(StoryNameCfg[1308].name)

				arg_35_1.leftNameTxt_.text = var_38_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_18 = arg_35_1:GetWordFromCfg(421032008)
				local var_38_19 = arg_35_1:FormatText(var_38_18.content)

				arg_35_1.text_.text = var_38_19

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_20 = 23
				local var_38_21 = utf8.len(var_38_19)
				local var_38_22 = var_38_20 <= 0 and var_38_16 or var_38_16 * (var_38_21 / var_38_20)

				if var_38_22 > 0 and var_38_16 < var_38_22 then
					arg_35_1.talkMaxDuration = var_38_22

					if var_38_22 + var_38_15 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_22 + var_38_15
					end
				end

				arg_35_1.text_.text = var_38_19
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032008", "story_v_out_421032.awb") ~= 0 then
					local var_38_23 = manager.audio:GetVoiceLength("story_v_out_421032", "421032008", "story_v_out_421032.awb") / 1000

					if var_38_23 + var_38_15 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_23 + var_38_15
					end

					if var_38_18.prefab_name ~= "" and arg_35_1.actors_[var_38_18.prefab_name] ~= nil then
						local var_38_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_18.prefab_name].transform, "story_v_out_421032", "421032008", "story_v_out_421032.awb")

						arg_35_1:RecordAudio("421032008", var_38_24)
						arg_35_1:RecordAudio("421032008", var_38_24)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_421032", "421032008", "story_v_out_421032.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_421032", "421032008", "story_v_out_421032.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_25 = math.max(var_38_16, arg_35_1.talkMaxDuration)

			if var_38_15 <= arg_35_1.time_ and arg_35_1.time_ < var_38_15 + var_38_25 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_15) / var_38_25

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_15 + var_38_25 and arg_35_1.time_ < var_38_15 + var_38_25 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421032009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 421032009
		arg_39_1.duration_ = 4.6

		local var_39_0 = {
			zh = 4.066,
			ja = 4.6
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
				arg_39_0:Play421032010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = "10143ui_story"

			if arg_39_1.actors_[var_42_0] == nil then
				local var_42_1 = Asset.Load("Char/" .. "10143ui_story")

				if not isNil(var_42_1) then
					local var_42_2 = Object.Instantiate(Asset.Load("Char/" .. "10143ui_story"), arg_39_1.stage_.transform)

					var_42_2.name = var_42_0
					var_42_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_39_1.actors_[var_42_0] = var_42_2

					local var_42_3 = var_42_2:GetComponentInChildren(typeof(CharacterEffect))

					var_42_3.enabled = true

					local var_42_4 = GameObjectTools.GetOrAddComponent(var_42_2, typeof(DynamicBoneHelper))

					if var_42_4 then
						var_42_4:EnableDynamicBone(false)
					end

					arg_39_1:ShowWeapon(var_42_3.transform, false)

					arg_39_1.var_[var_42_0 .. "Animator"] = var_42_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_39_1.var_[var_42_0 .. "Animator"].applyRootMotion = true
					arg_39_1.var_[var_42_0 .. "LipSync"] = var_42_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_42_5 = arg_39_1.actors_["10143ui_story"].transform
			local var_42_6 = 0

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.var_.moveOldPos10143ui_story = var_42_5.localPosition
			end

			local var_42_7 = 0.001

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_7 then
				local var_42_8 = (arg_39_1.time_ - var_42_6) / var_42_7
				local var_42_9 = Vector3.New(0.78, -1.06, -6)

				var_42_5.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10143ui_story, var_42_9, var_42_8)

				local var_42_10 = manager.ui.mainCamera.transform.position - var_42_5.position

				var_42_5.forward = Vector3.New(var_42_10.x, var_42_10.y, var_42_10.z)

				local var_42_11 = var_42_5.localEulerAngles

				var_42_11.z = 0
				var_42_11.x = 0
				var_42_5.localEulerAngles = var_42_11
			end

			if arg_39_1.time_ >= var_42_6 + var_42_7 and arg_39_1.time_ < var_42_6 + var_42_7 + arg_42_0 then
				var_42_5.localPosition = Vector3.New(0.78, -1.06, -6)

				local var_42_12 = manager.ui.mainCamera.transform.position - var_42_5.position

				var_42_5.forward = Vector3.New(var_42_12.x, var_42_12.y, var_42_12.z)

				local var_42_13 = var_42_5.localEulerAngles

				var_42_13.z = 0
				var_42_13.x = 0
				var_42_5.localEulerAngles = var_42_13
			end

			local var_42_14 = arg_39_1.actors_["10143ui_story"]
			local var_42_15 = 0

			if var_42_15 < arg_39_1.time_ and arg_39_1.time_ <= var_42_15 + arg_42_0 and not isNil(var_42_14) and arg_39_1.var_.characterEffect10143ui_story == nil then
				arg_39_1.var_.characterEffect10143ui_story = var_42_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_16 = 0.200000002980232

			if var_42_15 <= arg_39_1.time_ and arg_39_1.time_ < var_42_15 + var_42_16 and not isNil(var_42_14) then
				local var_42_17 = (arg_39_1.time_ - var_42_15) / var_42_16

				if arg_39_1.var_.characterEffect10143ui_story and not isNil(var_42_14) then
					arg_39_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_15 + var_42_16 and arg_39_1.time_ < var_42_15 + var_42_16 + arg_42_0 and not isNil(var_42_14) and arg_39_1.var_.characterEffect10143ui_story then
				arg_39_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_42_18 = arg_39_1.actors_["10145ui_story"]
			local var_42_19 = 0

			if var_42_19 < arg_39_1.time_ and arg_39_1.time_ <= var_42_19 + arg_42_0 and not isNil(var_42_18) and arg_39_1.var_.characterEffect10145ui_story == nil then
				arg_39_1.var_.characterEffect10145ui_story = var_42_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_20 = 0.200000002980232

			if var_42_19 <= arg_39_1.time_ and arg_39_1.time_ < var_42_19 + var_42_20 and not isNil(var_42_18) then
				local var_42_21 = (arg_39_1.time_ - var_42_19) / var_42_20

				if arg_39_1.var_.characterEffect10145ui_story and not isNil(var_42_18) then
					local var_42_22 = Mathf.Lerp(0, 0.5, var_42_21)

					arg_39_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_39_1.var_.characterEffect10145ui_story.fillRatio = var_42_22
				end
			end

			if arg_39_1.time_ >= var_42_19 + var_42_20 and arg_39_1.time_ < var_42_19 + var_42_20 + arg_42_0 and not isNil(var_42_18) and arg_39_1.var_.characterEffect10145ui_story then
				local var_42_23 = 0.5

				arg_39_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_39_1.var_.characterEffect10145ui_story.fillRatio = var_42_23
			end

			local var_42_24 = 0

			if var_42_24 < arg_39_1.time_ and arg_39_1.time_ <= var_42_24 + arg_42_0 then
				arg_39_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action8_1")
			end

			local var_42_25 = 0

			if var_42_25 < arg_39_1.time_ and arg_39_1.time_ <= var_42_25 + arg_42_0 then
				arg_39_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_42_26 = 0
			local var_42_27 = 0.425

			if var_42_26 < arg_39_1.time_ and arg_39_1.time_ <= var_42_26 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_28 = arg_39_1:FormatText(StoryNameCfg[1307].name)

				arg_39_1.leftNameTxt_.text = var_42_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_29 = arg_39_1:GetWordFromCfg(421032009)
				local var_42_30 = arg_39_1:FormatText(var_42_29.content)

				arg_39_1.text_.text = var_42_30

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_31 = 17
				local var_42_32 = utf8.len(var_42_30)
				local var_42_33 = var_42_31 <= 0 and var_42_27 or var_42_27 * (var_42_32 / var_42_31)

				if var_42_33 > 0 and var_42_27 < var_42_33 then
					arg_39_1.talkMaxDuration = var_42_33

					if var_42_33 + var_42_26 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_33 + var_42_26
					end
				end

				arg_39_1.text_.text = var_42_30
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032009", "story_v_out_421032.awb") ~= 0 then
					local var_42_34 = manager.audio:GetVoiceLength("story_v_out_421032", "421032009", "story_v_out_421032.awb") / 1000

					if var_42_34 + var_42_26 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_34 + var_42_26
					end

					if var_42_29.prefab_name ~= "" and arg_39_1.actors_[var_42_29.prefab_name] ~= nil then
						local var_42_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_29.prefab_name].transform, "story_v_out_421032", "421032009", "story_v_out_421032.awb")

						arg_39_1:RecordAudio("421032009", var_42_35)
						arg_39_1:RecordAudio("421032009", var_42_35)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_421032", "421032009", "story_v_out_421032.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_421032", "421032009", "story_v_out_421032.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_36 = math.max(var_42_27, arg_39_1.talkMaxDuration)

			if var_42_26 <= arg_39_1.time_ and arg_39_1.time_ < var_42_26 + var_42_36 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_26) / var_42_36

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_26 + var_42_36 and arg_39_1.time_ < var_42_26 + var_42_36 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421032010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 421032010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play421032011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["10143ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos10143ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(0, 100, 0)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10143ui_story, var_46_4, var_46_3)

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

			local var_46_9 = arg_43_1.actors_["10145ui_story"].transform
			local var_46_10 = 0

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 then
				arg_43_1.var_.moveOldPos10145ui_story = var_46_9.localPosition
			end

			local var_46_11 = 0.001

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_11 then
				local var_46_12 = (arg_43_1.time_ - var_46_10) / var_46_11
				local var_46_13 = Vector3.New(0, 100, 0)

				var_46_9.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10145ui_story, var_46_13, var_46_12)

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
			local var_46_19 = 1.2

			if var_46_18 < arg_43_1.time_ and arg_43_1.time_ <= var_46_18 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_20 = arg_43_1:GetWordFromCfg(421032010)
				local var_46_21 = arg_43_1:FormatText(var_46_20.content)

				arg_43_1.text_.text = var_46_21

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_22 = 48
				local var_46_23 = utf8.len(var_46_21)
				local var_46_24 = var_46_22 <= 0 and var_46_19 or var_46_19 * (var_46_23 / var_46_22)

				if var_46_24 > 0 and var_46_19 < var_46_24 then
					arg_43_1.talkMaxDuration = var_46_24

					if var_46_24 + var_46_18 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_24 + var_46_18
					end
				end

				arg_43_1.text_.text = var_46_21
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_25 = math.max(var_46_19, arg_43_1.talkMaxDuration)

			if var_46_18 <= arg_43_1.time_ and arg_43_1.time_ < var_46_18 + var_46_25 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_18) / var_46_25

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_18 + var_46_25 and arg_43_1.time_ < var_46_18 + var_46_25 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421032011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 421032011
		arg_47_1.duration_ = 5.6

		local var_47_0 = {
			zh = 5.6,
			ja = 4.066
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
				arg_47_0:Play421032012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = manager.ui.mainCamera.transform
			local var_50_1 = 0.933333333333333

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.shakeOldPos = var_50_0.localPosition
			end

			local var_50_2 = 0.566666666666667

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / 0.066
				local var_50_4, var_50_5 = math.modf(var_50_3)

				var_50_0.localPosition = Vector3.New(var_50_5 * 0.13, var_50_5 * 0.13, var_50_5 * 0.13) + arg_47_1.var_.shakeOldPos
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 then
				var_50_0.localPosition = arg_47_1.var_.shakeOldPos
			end

			local var_50_6 = arg_47_1.actors_["11"]
			local var_50_7 = 0.6

			if var_50_7 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 then
				local var_50_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_50_8 then
					var_50_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_50_8.radialBlurScale = 0
					var_50_8.radialBlurGradient = 1
					var_50_8.radialBlurIntensity = 1

					if var_50_6 then
						var_50_8.radialBlurTarget = var_50_6.transform
					end
				end
			end

			local var_50_9 = 1.3

			if var_50_7 <= arg_47_1.time_ and arg_47_1.time_ < var_50_7 + var_50_9 then
				local var_50_10 = (arg_47_1.time_ - var_50_7) / var_50_9
				local var_50_11 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_50_11 then
					var_50_11.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_50_11.radialBlurScale = Mathf.Lerp(0, 1, var_50_10)
					var_50_11.radialBlurGradient = Mathf.Lerp(1, 1, var_50_10)
					var_50_11.radialBlurIntensity = Mathf.Lerp(1, 1, var_50_10)
				end
			end

			if arg_47_1.time_ >= var_50_7 + var_50_9 and arg_47_1.time_ < var_50_7 + var_50_9 + arg_50_0 then
				local var_50_12 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_50_12 then
					var_50_12.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_50_12.radialBlurScale = 1
					var_50_12.radialBlurGradient = 1
					var_50_12.radialBlurIntensity = 1
				end
			end

			local var_50_13 = 0
			local var_50_14 = 0.6

			if var_50_13 < arg_47_1.time_ and arg_47_1.time_ <= var_50_13 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_15 = arg_47_1:FormatText(StoryNameCfg[1308].name)

				arg_47_1.leftNameTxt_.text = var_50_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10145")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_16 = arg_47_1:GetWordFromCfg(421032011)
				local var_50_17 = arg_47_1:FormatText(var_50_16.content)

				arg_47_1.text_.text = var_50_17

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_18 = 24
				local var_50_19 = utf8.len(var_50_17)
				local var_50_20 = var_50_18 <= 0 and var_50_14 or var_50_14 * (var_50_19 / var_50_18)

				if var_50_20 > 0 and var_50_14 < var_50_20 then
					arg_47_1.talkMaxDuration = var_50_20

					if var_50_20 + var_50_13 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_20 + var_50_13
					end
				end

				arg_47_1.text_.text = var_50_17
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032011", "story_v_out_421032.awb") ~= 0 then
					local var_50_21 = manager.audio:GetVoiceLength("story_v_out_421032", "421032011", "story_v_out_421032.awb") / 1000

					if var_50_21 + var_50_13 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_21 + var_50_13
					end

					if var_50_16.prefab_name ~= "" and arg_47_1.actors_[var_50_16.prefab_name] ~= nil then
						local var_50_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_16.prefab_name].transform, "story_v_out_421032", "421032011", "story_v_out_421032.awb")

						arg_47_1:RecordAudio("421032011", var_50_22)
						arg_47_1:RecordAudio("421032011", var_50_22)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_421032", "421032011", "story_v_out_421032.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_421032", "421032011", "story_v_out_421032.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_23 = math.max(var_50_14, arg_47_1.talkMaxDuration)

			if var_50_13 <= arg_47_1.time_ and arg_47_1.time_ < var_50_13 + var_50_23 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_13) / var_50_23

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_13 + var_50_23 and arg_47_1.time_ < var_50_13 + var_50_23 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play421032012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 421032012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play421032013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 1.3

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

				local var_54_2 = arg_51_1:GetWordFromCfg(421032012)
				local var_54_3 = arg_51_1:FormatText(var_54_2.content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 52
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
	Play421032013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 421032013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play421032014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.1
			local var_58_1 = 1

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				local var_58_2 = "play"
				local var_58_3 = "effect"

				arg_55_1:AudioAction(var_58_2, var_58_3, "se_story_1311", "se_story_1311_car02", "")
			end

			local var_58_4 = 0
			local var_58_5 = 0.975

			if var_58_4 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(421032013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_8 = 39
				local var_58_9 = utf8.len(var_58_7)
				local var_58_10 = var_58_8 <= 0 and var_58_5 or var_58_5 * (var_58_9 / var_58_8)

				if var_58_10 > 0 and var_58_5 < var_58_10 then
					arg_55_1.talkMaxDuration = var_58_10

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_11 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_11 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_11

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_11 and arg_55_1.time_ < var_58_4 + var_58_11 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play421032014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 421032014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play421032015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = manager.ui.mainCamera.transform
			local var_62_1 = 0.666666666666667

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				local var_62_2 = arg_59_1.var_.effect2014
				local var_62_3
				local var_62_4 = var_62_0

				if not var_62_2 then
					var_62_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_62_4)
					var_62_2.name = "2014"
					arg_59_1.var_.effect2014 = var_62_2
				else
					var_62_2.transform:SetParent(var_62_4)
				end

				var_62_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_62_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_62_5 = manager.ui.mainCamera.transform
			local var_62_6 = 2.46666666666667

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				local var_62_7 = arg_59_1.var_.effect2014

				if var_62_7 then
					Object.Destroy(var_62_7)

					arg_59_1.var_.effect2014 = nil
				end
			end

			local var_62_8 = arg_59_1.actors_["11"]
			local var_62_9 = 0.666666666666667

			if var_62_9 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 then
				local var_62_10 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_62_10 then
					var_62_10.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_62_10.radialBlurScale = 0
					var_62_10.radialBlurGradient = 1
					var_62_10.radialBlurIntensity = 1

					if var_62_8 then
						var_62_10.radialBlurTarget = var_62_8.transform
					end
				end
			end

			local var_62_11 = 1.36666666666667

			if var_62_9 <= arg_59_1.time_ and arg_59_1.time_ < var_62_9 + var_62_11 then
				local var_62_12 = (arg_59_1.time_ - var_62_9) / var_62_11
				local var_62_13 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_62_13 then
					var_62_13.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_62_13.radialBlurScale = Mathf.Lerp(0, 0, var_62_12)
					var_62_13.radialBlurGradient = Mathf.Lerp(1, 1, var_62_12)
					var_62_13.radialBlurIntensity = Mathf.Lerp(1, 1, var_62_12)
				end
			end

			if arg_59_1.time_ >= var_62_9 + var_62_11 and arg_59_1.time_ < var_62_9 + var_62_11 + arg_62_0 then
				local var_62_14 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_62_14 then
					var_62_14.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_62_14.radialBlurScale = 0
					var_62_14.radialBlurGradient = 1
					var_62_14.radialBlurIntensity = 1
				end
			end

			local var_62_15 = 0.28
			local var_62_16 = 1

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				local var_62_17 = "play"
				local var_62_18 = "effect"

				arg_59_1:AudioAction(var_62_17, var_62_18, "se_story_143", "se_story_143_car", "")
			end

			local var_62_19 = 0
			local var_62_20 = 1.25

			if var_62_19 < arg_59_1.time_ and arg_59_1.time_ <= var_62_19 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_21 = arg_59_1:GetWordFromCfg(421032014)
				local var_62_22 = arg_59_1:FormatText(var_62_21.content)

				arg_59_1.text_.text = var_62_22

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_23 = 50
				local var_62_24 = utf8.len(var_62_22)
				local var_62_25 = var_62_23 <= 0 and var_62_20 or var_62_20 * (var_62_24 / var_62_23)

				if var_62_25 > 0 and var_62_20 < var_62_25 then
					arg_59_1.talkMaxDuration = var_62_25

					if var_62_25 + var_62_19 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_25 + var_62_19
					end
				end

				arg_59_1.text_.text = var_62_22
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_26 = math.max(var_62_20, arg_59_1.talkMaxDuration)

			if var_62_19 <= arg_59_1.time_ and arg_59_1.time_ < var_62_19 + var_62_26 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_19) / var_62_26

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_19 + var_62_26 and arg_59_1.time_ < var_62_19 + var_62_26 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play421032015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 421032015
		arg_63_1.duration_ = 2

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
			arg_63_1.auto_ = false
		end

		function arg_63_1.playNext_(arg_65_0)
			arg_63_1.onStoryFinished_()
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1047ui_story"].transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.var_.moveOldPos1047ui_story = var_66_0.localPosition

				local var_66_2 = "1047ui_story"

				arg_63_1:ShowWeapon(arg_63_1.var_[var_66_2 .. "Animator"].transform, false)
			end

			local var_66_3 = 0.001

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_3 then
				local var_66_4 = (arg_63_1.time_ - var_66_1) / var_66_3
				local var_66_5 = Vector3.New(0, -1.13, -6.2)

				var_66_0.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1047ui_story, var_66_5, var_66_4)

				local var_66_6 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_6.x, var_66_6.y, var_66_6.z)

				local var_66_7 = var_66_0.localEulerAngles

				var_66_7.z = 0
				var_66_7.x = 0
				var_66_0.localEulerAngles = var_66_7
			end

			if arg_63_1.time_ >= var_66_1 + var_66_3 and arg_63_1.time_ < var_66_1 + var_66_3 + arg_66_0 then
				var_66_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_66_8 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_8.x, var_66_8.y, var_66_8.z)

				local var_66_9 = var_66_0.localEulerAngles

				var_66_9.z = 0
				var_66_9.x = 0
				var_66_0.localEulerAngles = var_66_9
			end

			local var_66_10 = arg_63_1.actors_["1047ui_story"]
			local var_66_11 = 0

			if var_66_11 < arg_63_1.time_ and arg_63_1.time_ <= var_66_11 + arg_66_0 and not isNil(var_66_10) and arg_63_1.var_.characterEffect1047ui_story == nil then
				arg_63_1.var_.characterEffect1047ui_story = var_66_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_12 = 0.200000002980232

			if var_66_11 <= arg_63_1.time_ and arg_63_1.time_ < var_66_11 + var_66_12 and not isNil(var_66_10) then
				local var_66_13 = (arg_63_1.time_ - var_66_11) / var_66_12

				if arg_63_1.var_.characterEffect1047ui_story and not isNil(var_66_10) then
					arg_63_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_11 + var_66_12 and arg_63_1.time_ < var_66_11 + var_66_12 + arg_66_0 and not isNil(var_66_10) and arg_63_1.var_.characterEffect1047ui_story then
				arg_63_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_66_14 = 0

			if var_66_14 < arg_63_1.time_ and arg_63_1.time_ <= var_66_14 + arg_66_0 then
				arg_63_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_1")
			end

			local var_66_15 = 0

			if var_66_15 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 then
				arg_63_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_66_16 = 0
			local var_66_17 = 0.15

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_18 = arg_63_1:FormatText(StoryNameCfg[1296].name)

				arg_63_1.leftNameTxt_.text = var_66_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_19 = arg_63_1:GetWordFromCfg(421032015)
				local var_66_20 = arg_63_1:FormatText(var_66_19.content)

				arg_63_1.text_.text = var_66_20

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_21 = 6
				local var_66_22 = utf8.len(var_66_20)
				local var_66_23 = var_66_21 <= 0 and var_66_17 or var_66_17 * (var_66_22 / var_66_21)

				if var_66_23 > 0 and var_66_17 < var_66_23 then
					arg_63_1.talkMaxDuration = var_66_23

					if var_66_23 + var_66_16 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_23 + var_66_16
					end
				end

				arg_63_1.text_.text = var_66_20
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032015", "story_v_out_421032.awb") ~= 0 then
					local var_66_24 = manager.audio:GetVoiceLength("story_v_out_421032", "421032015", "story_v_out_421032.awb") / 1000

					if var_66_24 + var_66_16 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_24 + var_66_16
					end

					if var_66_19.prefab_name ~= "" and arg_63_1.actors_[var_66_19.prefab_name] ~= nil then
						local var_66_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_19.prefab_name].transform, "story_v_out_421032", "421032015", "story_v_out_421032.awb")

						arg_63_1:RecordAudio("421032015", var_66_25)
						arg_63_1:RecordAudio("421032015", var_66_25)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_421032", "421032015", "story_v_out_421032.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_421032", "421032015", "story_v_out_421032.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_26 = math.max(var_66_17, arg_63_1.talkMaxDuration)

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_26 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_16) / var_66_26

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_16 + var_66_26 and arg_63_1.time_ < var_66_16 + var_66_26 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	assets = {
		"TextureConfig/Background/ST2401",
		"TextureConfig/Background/ST2105"
	},
	voices = {
		"story_v_out_421032.awb"
	}
}
