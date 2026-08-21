return {
	Play303041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 303041001
		arg_1_1.duration_ = 4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play303041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B15f"

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
				local var_4_5 = arg_1_1.bgs_.B15f

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
					if iter_4_0 ~= "B15f" then
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

			local var_4_24 = "1084ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1084ui_story"].transform
			local var_4_30 = 1.999999999999

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_29.localPosition

				local var_4_31 = "1084ui_story"

				arg_1_1:ShowWeapon(arg_1_1.var_[var_4_31 .. "Animator"].transform, true)
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(0, -0.97, -6)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -0.97, -6)

				local var_4_37 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_37.x, var_4_37.y, var_4_37.z)

				local var_4_38 = var_4_29.localEulerAngles

				var_4_38.z = 0
				var_4_38.x = 0
				var_4_29.localEulerAngles = var_4_38
			end

			local var_4_39 = arg_1_1.actors_["1084ui_story"]
			local var_4_40 = 1.999999999999

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_41 = 0.200000002980232

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 and not isNil(var_4_39) then
				local var_4_42 = (arg_1_1.time_ - var_4_40) / var_4_41

				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_39) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_43 = 1.999999999999

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_4_44 = 1.999999999999

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_4_45 = 0.2
			local var_4_46 = 1

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "effect"

				arg_1_1:AudioAction(var_4_47, var_4_48, "se_story_148", "se_story_148_amb_drone02", "")
			end

			local var_4_49 = 1
			local var_4_50 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous.awb")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous")

				if var_4_54 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_54 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_54

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_54
						arg_1_1.bgmTxt2_.text = var_4_54
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

			local var_4_55 = 0
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "effect"

				arg_1_1:AudioAction(var_4_57, var_4_58, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_59 = 1.999999999999
			local var_4_60 = 0.375

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_61 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_61:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_62 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(303041001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 15
				local var_4_66 = utf8.len(var_4_64)
				local var_4_67 = var_4_65 <= 0 and var_4_60 or var_4_60 * (var_4_66 / var_4_65)

				if var_4_67 > 0 and var_4_60 < var_4_67 then
					arg_1_1.talkMaxDuration = var_4_67
					var_4_59 = var_4_59 + 0.3

					if var_4_67 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_59
					end
				end

				arg_1_1.text_.text = var_4_64
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303041", "303041001", "story_v_out_303041.awb") ~= 0 then
					local var_4_68 = manager.audio:GetVoiceLength("story_v_out_303041", "303041001", "story_v_out_303041.awb") / 1000

					if var_4_68 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_59
					end

					if var_4_63.prefab_name ~= "" and arg_1_1.actors_[var_4_63.prefab_name] ~= nil then
						local var_4_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_63.prefab_name].transform, "story_v_out_303041", "303041001", "story_v_out_303041.awb")

						arg_1_1:RecordAudio("303041001", var_4_69)
						arg_1_1:RecordAudio("303041001", var_4_69)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_303041", "303041001", "story_v_out_303041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_303041", "303041001", "story_v_out_303041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_70 = var_4_59 + 0.3
			local var_4_71 = math.max(var_4_60, arg_1_1.talkMaxDuration)

			if var_4_70 <= arg_1_1.time_ and arg_1_1.time_ < var_4_70 + var_4_71 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_70) / var_4_71

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_70 + var_4_71 and arg_1_1.time_ < var_4_70 + var_4_71 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play303041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 303041002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play303041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1084ui_story"].transform
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_0.localPosition

				local var_11_2 = "1084ui_story"

				arg_8_1:ShowWeapon(arg_8_1.var_[var_11_2 .. "Animator"].transform, false)
			end

			local var_11_3 = 0.001

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_3 then
				local var_11_4 = (arg_8_1.time_ - var_11_1) / var_11_3
				local var_11_5 = Vector3.New(0, 100, 0)

				var_11_0.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, var_11_5, var_11_4)

				local var_11_6 = manager.ui.mainCamera.transform.position - var_11_0.position

				var_11_0.forward = Vector3.New(var_11_6.x, var_11_6.y, var_11_6.z)

				local var_11_7 = var_11_0.localEulerAngles

				var_11_7.z = 0
				var_11_7.x = 0
				var_11_0.localEulerAngles = var_11_7
			end

			if arg_8_1.time_ >= var_11_1 + var_11_3 and arg_8_1.time_ < var_11_1 + var_11_3 + arg_11_0 then
				var_11_0.localPosition = Vector3.New(0, 100, 0)

				local var_11_8 = manager.ui.mainCamera.transform.position - var_11_0.position

				var_11_0.forward = Vector3.New(var_11_8.x, var_11_8.y, var_11_8.z)

				local var_11_9 = var_11_0.localEulerAngles

				var_11_9.z = 0
				var_11_9.x = 0
				var_11_0.localEulerAngles = var_11_9
			end

			local var_11_10 = arg_8_1.actors_["1084ui_story"]
			local var_11_11 = 0

			if var_11_11 < arg_8_1.time_ and arg_8_1.time_ <= var_11_11 + arg_11_0 and not isNil(var_11_10) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_12 = 0.200000002980232

			if var_11_11 <= arg_8_1.time_ and arg_8_1.time_ < var_11_11 + var_11_12 and not isNil(var_11_10) then
				local var_11_13 = (arg_8_1.time_ - var_11_11) / var_11_12

				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_10) then
					local var_11_14 = Mathf.Lerp(0, 0.5, var_11_13)

					arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1084ui_story.fillRatio = var_11_14
				end
			end

			if arg_8_1.time_ >= var_11_11 + var_11_12 and arg_8_1.time_ < var_11_11 + var_11_12 + arg_11_0 and not isNil(var_11_10) and arg_8_1.var_.characterEffect1084ui_story then
				local var_11_15 = 0.5

				arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1084ui_story.fillRatio = var_11_15
			end

			local var_11_16 = 0.2
			local var_11_17 = 1

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				local var_11_18 = "play"
				local var_11_19 = "effect"

				arg_8_1:AudioAction(var_11_18, var_11_19, "se_story_139", "se_story_139_metalhit03", "")
			end

			local var_11_20 = 0
			local var_11_21 = 1.45

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_22 = arg_8_1:GetWordFromCfg(303041002)
				local var_11_23 = arg_8_1:FormatText(var_11_22.content)

				arg_8_1.text_.text = var_11_23

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_24 = 58
				local var_11_25 = utf8.len(var_11_23)
				local var_11_26 = var_11_24 <= 0 and var_11_21 or var_11_21 * (var_11_25 / var_11_24)

				if var_11_26 > 0 and var_11_21 < var_11_26 then
					arg_8_1.talkMaxDuration = var_11_26

					if var_11_26 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_26 + var_11_20
					end
				end

				arg_8_1.text_.text = var_11_23
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_27 = math.max(var_11_21, arg_8_1.talkMaxDuration)

			if var_11_20 <= arg_8_1.time_ and arg_8_1.time_ < var_11_20 + var_11_27 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_20) / var_11_27

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_20 + var_11_27 and arg_8_1.time_ < var_11_20 + var_11_27 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play303041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 303041003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play303041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.275

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

				local var_15_2 = arg_12_1:GetWordFromCfg(303041003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 51
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
	Play303041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 303041004
		arg_16_1.duration_ = 6.84

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play303041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = manager.ui.mainCamera.transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				local var_19_2 = arg_16_1.var_.effectjinshuguanbaozha1
				local var_19_3
				local var_19_4 = var_19_0

				if not var_19_2 then
					var_19_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_19_4)
					var_19_2.name = "jinshuguanbaozha1"
					arg_16_1.var_.effectjinshuguanbaozha1 = var_19_2
				else
					var_19_2.transform:SetParent(var_19_4)
				end

				var_19_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_19_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_19_5 = manager.ui.mainCamera.transform
			local var_19_6 = 2.8

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				local var_19_7 = arg_16_1.var_.effectjinshuguanbaozha1

				if var_19_7 then
					Object.Destroy(var_19_7)

					arg_16_1.var_.effectjinshuguanbaozha1 = nil
				end
			end

			local var_19_8 = manager.ui.mainCamera.transform
			local var_19_9 = 1.23333333333333

			if var_19_9 < arg_16_1.time_ and arg_16_1.time_ <= var_19_9 + arg_19_0 then
				arg_16_1.var_.shakeOldPos = var_19_8.localPosition
			end

			local var_19_10 = 0.60814186494487

			if var_19_9 <= arg_16_1.time_ and arg_16_1.time_ < var_19_9 + var_19_10 then
				local var_19_11 = (arg_16_1.time_ - var_19_9) / 0.066
				local var_19_12, var_19_13 = math.modf(var_19_11)

				var_19_8.localPosition = Vector3.New(var_19_13 * 0.13, var_19_13 * 0.13, var_19_13 * 0.13) + arg_16_1.var_.shakeOldPos
			end

			if arg_16_1.time_ >= var_19_9 + var_19_10 and arg_16_1.time_ < var_19_9 + var_19_10 + arg_19_0 then
				var_19_8.localPosition = arg_16_1.var_.shakeOldPos
			end

			local var_19_14 = 0.1
			local var_19_15 = 1

			if var_19_14 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				local var_19_16 = "play"
				local var_19_17 = "effect"

				arg_16_1:AudioAction(var_19_16, var_19_17, "se_story_140", "se_story_140_6141_bullet_5", "")
			end

			local var_19_18 = 1.8414751982782
			local var_19_19 = 0.975

			if var_19_18 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_20 = arg_16_1:GetWordFromCfg(303041004)
				local var_19_21 = arg_16_1:FormatText(var_19_20.content)

				arg_16_1.text_.text = var_19_21

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_22 = 39
				local var_19_23 = utf8.len(var_19_21)
				local var_19_24 = var_19_22 <= 0 and var_19_19 or var_19_19 * (var_19_23 / var_19_22)

				if var_19_24 > 0 and var_19_19 < var_19_24 then
					arg_16_1.talkMaxDuration = var_19_24

					if var_19_24 + var_19_18 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_24 + var_19_18
					end
				end

				arg_16_1.text_.text = var_19_21
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_25 = math.max(var_19_19, arg_16_1.talkMaxDuration)

			if var_19_18 <= arg_16_1.time_ and arg_16_1.time_ < var_19_18 + var_19_25 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_18) / var_19_25

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_18 + var_19_25 and arg_16_1.time_ < var_19_18 + var_19_25 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play303041005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 303041005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play303041006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.975

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_2 = arg_20_1:GetWordFromCfg(303041005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 39
				local var_23_5 = utf8.len(var_23_3)
				local var_23_6 = var_23_4 <= 0 and var_23_1 or var_23_1 * (var_23_5 / var_23_4)

				if var_23_6 > 0 and var_23_1 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_7 and arg_20_1.time_ < var_23_0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play303041006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 303041006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play303041007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.775

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(303041006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 31
				local var_27_5 = utf8.len(var_27_3)
				local var_27_6 = var_27_4 <= 0 and var_27_1 or var_27_1 * (var_27_5 / var_27_4)

				if var_27_6 > 0 and var_27_1 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_7 and arg_24_1.time_ < var_27_0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play303041007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 303041007
		arg_28_1.duration_ = 3

		local var_28_0 = {
			zh = 3,
			ja = 1.999999999999
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
				arg_28_0:Play303041008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1084ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos1084ui_story = var_31_0.localPosition
			end

			local var_31_2 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2
				local var_31_4 = Vector3.New(0, -0.97, -6)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1084ui_story, var_31_4, var_31_3)

				local var_31_5 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_5.x, var_31_5.y, var_31_5.z)

				local var_31_6 = var_31_0.localEulerAngles

				var_31_6.z = 0
				var_31_6.x = 0
				var_31_0.localEulerAngles = var_31_6
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_31_7 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_7.x, var_31_7.y, var_31_7.z)

				local var_31_8 = var_31_0.localEulerAngles

				var_31_8.z = 0
				var_31_8.x = 0
				var_31_0.localEulerAngles = var_31_8
			end

			local var_31_9 = arg_28_1.actors_["1084ui_story"]
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1084ui_story == nil then
				arg_28_1.var_.characterEffect1084ui_story = var_31_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_11 = 0.200000002980232

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 and not isNil(var_31_9) then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11

				if arg_28_1.var_.characterEffect1084ui_story and not isNil(var_31_9) then
					arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1084ui_story then
				arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_31_13 = 0

			if var_31_13 < arg_28_1.time_ and arg_28_1.time_ <= var_31_13 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_31_14 = 0

			if var_31_14 < arg_28_1.time_ and arg_28_1.time_ <= var_31_14 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_31_15 = 0
			local var_31_16 = 0.375

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_17 = arg_28_1:FormatText(StoryNameCfg[6].name)

				arg_28_1.leftNameTxt_.text = var_31_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_18 = arg_28_1:GetWordFromCfg(303041007)
				local var_31_19 = arg_28_1:FormatText(var_31_18.content)

				arg_28_1.text_.text = var_31_19

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_20 = 15
				local var_31_21 = utf8.len(var_31_19)
				local var_31_22 = var_31_20 <= 0 and var_31_16 or var_31_16 * (var_31_21 / var_31_20)

				if var_31_22 > 0 and var_31_16 < var_31_22 then
					arg_28_1.talkMaxDuration = var_31_22

					if var_31_22 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_22 + var_31_15
					end
				end

				arg_28_1.text_.text = var_31_19
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303041", "303041007", "story_v_out_303041.awb") ~= 0 then
					local var_31_23 = manager.audio:GetVoiceLength("story_v_out_303041", "303041007", "story_v_out_303041.awb") / 1000

					if var_31_23 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_23 + var_31_15
					end

					if var_31_18.prefab_name ~= "" and arg_28_1.actors_[var_31_18.prefab_name] ~= nil then
						local var_31_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_18.prefab_name].transform, "story_v_out_303041", "303041007", "story_v_out_303041.awb")

						arg_28_1:RecordAudio("303041007", var_31_24)
						arg_28_1:RecordAudio("303041007", var_31_24)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_303041", "303041007", "story_v_out_303041.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_303041", "303041007", "story_v_out_303041.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_25 = math.max(var_31_16, arg_28_1.talkMaxDuration)

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_25 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_15) / var_31_25

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_15 + var_31_25 and arg_28_1.time_ < var_31_15 + var_31_25 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play303041008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 303041008
		arg_32_1.duration_ = 4.4

		local var_32_0 = {
			zh = 4.4,
			ja = 1.999999999999
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
				arg_32_0:Play303041009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_2 = 0
			local var_35_3 = 0.65

			if var_35_2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_4 = arg_32_1:FormatText(StoryNameCfg[6].name)

				arg_32_1.leftNameTxt_.text = var_35_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_5 = arg_32_1:GetWordFromCfg(303041008)
				local var_35_6 = arg_32_1:FormatText(var_35_5.content)

				arg_32_1.text_.text = var_35_6

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 26
				local var_35_8 = utf8.len(var_35_6)
				local var_35_9 = var_35_7 <= 0 and var_35_3 or var_35_3 * (var_35_8 / var_35_7)

				if var_35_9 > 0 and var_35_3 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_2
					end
				end

				arg_32_1.text_.text = var_35_6
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303041", "303041008", "story_v_out_303041.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_303041", "303041008", "story_v_out_303041.awb") / 1000

					if var_35_10 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_2
					end

					if var_35_5.prefab_name ~= "" and arg_32_1.actors_[var_35_5.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_5.prefab_name].transform, "story_v_out_303041", "303041008", "story_v_out_303041.awb")

						arg_32_1:RecordAudio("303041008", var_35_11)
						arg_32_1:RecordAudio("303041008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_303041", "303041008", "story_v_out_303041.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_303041", "303041008", "story_v_out_303041.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_3, arg_32_1.talkMaxDuration)

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_2) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_2 + var_35_12 and arg_32_1.time_ < var_35_2 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play303041009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 303041009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play303041010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1084ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1084ui_story = var_39_0.localPosition
			end

			local var_39_2 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2
				local var_39_4 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1084ui_story, var_39_4, var_39_3)

				local var_39_5 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_5.x, var_39_5.y, var_39_5.z)

				local var_39_6 = var_39_0.localEulerAngles

				var_39_6.z = 0
				var_39_6.x = 0
				var_39_0.localEulerAngles = var_39_6
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, 100, 0)

				local var_39_7 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_7.x, var_39_7.y, var_39_7.z)

				local var_39_8 = var_39_0.localEulerAngles

				var_39_8.z = 0
				var_39_8.x = 0
				var_39_0.localEulerAngles = var_39_8
			end

			local var_39_9 = arg_36_1.actors_["1084ui_story"]
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_11 = 0.200000002980232

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 and not isNil(var_39_9) then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11

				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_9) then
					local var_39_13 = Mathf.Lerp(0, 0.5, var_39_12)

					arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1084ui_story.fillRatio = var_39_13
				end
			end

			if arg_36_1.time_ >= var_39_10 + var_39_11 and arg_36_1.time_ < var_39_10 + var_39_11 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.characterEffect1084ui_story then
				local var_39_14 = 0.5

				arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1084ui_story.fillRatio = var_39_14
			end

			local var_39_15 = 0
			local var_39_16 = 1.175

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_17 = arg_36_1:GetWordFromCfg(303041009)
				local var_39_18 = arg_36_1:FormatText(var_39_17.content)

				arg_36_1.text_.text = var_39_18

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_19 = 47
				local var_39_20 = utf8.len(var_39_18)
				local var_39_21 = var_39_19 <= 0 and var_39_16 or var_39_16 * (var_39_20 / var_39_19)

				if var_39_21 > 0 and var_39_16 < var_39_21 then
					arg_36_1.talkMaxDuration = var_39_21

					if var_39_21 + var_39_15 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_21 + var_39_15
					end
				end

				arg_36_1.text_.text = var_39_18
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_22 = math.max(var_39_16, arg_36_1.talkMaxDuration)

			if var_39_15 <= arg_36_1.time_ and arg_36_1.time_ < var_39_15 + var_39_22 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_15) / var_39_22

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_15 + var_39_22 and arg_36_1.time_ < var_39_15 + var_39_22 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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

		arg_36_1:InitPlayNodeList()
	end,
	Play303041010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 303041010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play303041011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 1

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_2 = arg_40_1:GetWordFromCfg(303041010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 38
				local var_43_5 = utf8.len(var_43_3)
				local var_43_6 = var_43_4 <= 0 and var_43_1 or var_43_1 * (var_43_5 / var_43_4)

				if var_43_6 > 0 and var_43_1 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_7 and arg_40_1.time_ < var_43_0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play303041011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 303041011
		arg_44_1.duration_ = 5.73

		local var_44_0 = {
			zh = 5.733,
			ja = 1.999999999999
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play303041012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1084ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0, -0.97, -6)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = arg_44_1.actors_["1084ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_9) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_47_13 = 0

			if var_47_13 < arg_44_1.time_ and arg_44_1.time_ <= var_47_13 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_47_14 = 0

			if var_47_14 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_47_15 = 0
			local var_47_16 = 0.425

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_17 = arg_44_1:FormatText(StoryNameCfg[6].name)

				arg_44_1.leftNameTxt_.text = var_47_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_18 = arg_44_1:GetWordFromCfg(303041011)
				local var_47_19 = arg_44_1:FormatText(var_47_18.content)

				arg_44_1.text_.text = var_47_19

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_20 = 17
				local var_47_21 = utf8.len(var_47_19)
				local var_47_22 = var_47_20 <= 0 and var_47_16 or var_47_16 * (var_47_21 / var_47_20)

				if var_47_22 > 0 and var_47_16 < var_47_22 then
					arg_44_1.talkMaxDuration = var_47_22

					if var_47_22 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_22 + var_47_15
					end
				end

				arg_44_1.text_.text = var_47_19
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303041", "303041011", "story_v_out_303041.awb") ~= 0 then
					local var_47_23 = manager.audio:GetVoiceLength("story_v_out_303041", "303041011", "story_v_out_303041.awb") / 1000

					if var_47_23 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_15
					end

					if var_47_18.prefab_name ~= "" and arg_44_1.actors_[var_47_18.prefab_name] ~= nil then
						local var_47_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_18.prefab_name].transform, "story_v_out_303041", "303041011", "story_v_out_303041.awb")

						arg_44_1:RecordAudio("303041011", var_47_24)
						arg_44_1:RecordAudio("303041011", var_47_24)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_303041", "303041011", "story_v_out_303041.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_303041", "303041011", "story_v_out_303041.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_25 = math.max(var_47_16, arg_44_1.talkMaxDuration)

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_25 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_15) / var_47_25

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_15 + var_47_25 and arg_44_1.time_ < var_47_15 + var_47_25 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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

		arg_44_1:InitPlayNodeList()
	end,
	Play303041012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 303041012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play303041013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1084ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1084ui_story then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_5
			end

			local var_51_6 = 0
			local var_51_7 = 0.55

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_8 = arg_48_1:FormatText(StoryNameCfg[7].name)

				arg_48_1.leftNameTxt_.text = var_51_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_9 = arg_48_1:GetWordFromCfg(303041012)
				local var_51_10 = arg_48_1:FormatText(var_51_9.content)

				arg_48_1.text_.text = var_51_10

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 22
				local var_51_12 = utf8.len(var_51_10)
				local var_51_13 = var_51_11 <= 0 and var_51_7 or var_51_7 * (var_51_12 / var_51_11)

				if var_51_13 > 0 and var_51_7 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_10
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_14 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_14 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_14

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_14 and arg_48_1.time_ < var_51_6 + var_51_14 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play303041013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 303041013
		arg_52_1.duration_ = 4.73

		local var_52_0 = {
			zh = 4.733,
			ja = 3.3
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
				arg_52_0:Play303041014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.175

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[68].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(303041013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_303041", "303041013", "story_v_out_303041.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_303041", "303041013", "story_v_out_303041.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_303041", "303041013", "story_v_out_303041.awb")

						arg_52_1:RecordAudio("303041013", var_55_9)
						arg_52_1:RecordAudio("303041013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_303041", "303041013", "story_v_out_303041.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_303041", "303041013", "story_v_out_303041.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_10 and arg_52_1.time_ < var_55_0 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play303041014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 303041014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play303041015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1084ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0, 100, 0)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, 100, 0)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = 0
			local var_59_10 = 1.25

			if var_59_9 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_11 = arg_56_1:GetWordFromCfg(303041014)
				local var_59_12 = arg_56_1:FormatText(var_59_11.content)

				arg_56_1.text_.text = var_59_12

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_13 = 50
				local var_59_14 = utf8.len(var_59_12)
				local var_59_15 = var_59_13 <= 0 and var_59_10 or var_59_10 * (var_59_14 / var_59_13)

				if var_59_15 > 0 and var_59_10 < var_59_15 then
					arg_56_1.talkMaxDuration = var_59_15

					if var_59_15 + var_59_9 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_15 + var_59_9
					end
				end

				arg_56_1.text_.text = var_59_12
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_10, arg_56_1.talkMaxDuration)

			if var_59_9 <= arg_56_1.time_ and arg_56_1.time_ < var_59_9 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_9) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_9 + var_59_16 and arg_56_1.time_ < var_59_9 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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

		arg_56_1:InitPlayNodeList()
	end,
	Play303041015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 303041015
		arg_60_1.duration_ = 11.47

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play303041016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "MS0301"

			if arg_60_1.bgs_[var_63_0] == nil then
				local var_63_1 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_63_0)
				var_63_1.name = var_63_0
				var_63_1.transform.parent = arg_60_1.stage_.transform
				var_63_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_[var_63_0] = var_63_1
			end

			local var_63_2 = 1.23333333333333

			if var_63_2 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				local var_63_3 = manager.ui.mainCamera.transform.localPosition
				local var_63_4 = Vector3.New(0, 0, 10) + Vector3.New(var_63_3.x, var_63_3.y, 0)
				local var_63_5 = arg_60_1.bgs_.MS0301

				var_63_5.transform.localPosition = var_63_4
				var_63_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_6 = var_63_5:GetComponent("SpriteRenderer")

				if var_63_6 and var_63_6.sprite then
					local var_63_7 = (var_63_5.transform.localPosition - var_63_3).z
					local var_63_8 = manager.ui.mainCameraCom_
					local var_63_9 = 2 * var_63_7 * Mathf.Tan(var_63_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_63_10 = var_63_9 * var_63_8.aspect
					local var_63_11 = var_63_6.sprite.bounds.size.x
					local var_63_12 = var_63_6.sprite.bounds.size.y
					local var_63_13 = var_63_10 / var_63_11
					local var_63_14 = var_63_9 / var_63_12
					local var_63_15 = var_63_14 < var_63_13 and var_63_13 or var_63_14

					var_63_5.transform.localScale = Vector3.New(var_63_15, var_63_15, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "MS0301" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_16 = 3.29200194332028

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			local var_63_17 = 0.3

			if arg_60_1.time_ >= var_63_16 + var_63_17 and arg_60_1.time_ < var_63_16 + var_63_17 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			local var_63_18 = 0

			if var_63_18 < arg_60_1.time_ and arg_60_1.time_ <= var_63_18 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_19 = 1.27466472334539

			if var_63_18 <= arg_60_1.time_ and arg_60_1.time_ < var_63_18 + var_63_19 then
				local var_63_20 = (arg_60_1.time_ - var_63_18) / var_63_19
				local var_63_21 = Color.New(0, 0, 0)

				var_63_21.a = Mathf.Lerp(0, 1, var_63_20)
				arg_60_1.mask_.color = var_63_21
			end

			if arg_60_1.time_ >= var_63_18 + var_63_19 and arg_60_1.time_ < var_63_18 + var_63_19 + arg_63_0 then
				local var_63_22 = Color.New(0, 0, 0)

				var_63_22.a = 1
				arg_60_1.mask_.color = var_63_22
			end

			local var_63_23 = 1.27466472334539

			if var_63_23 < arg_60_1.time_ and arg_60_1.time_ <= var_63_23 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_24 = 1.29200194332128

			if var_63_23 <= arg_60_1.time_ and arg_60_1.time_ < var_63_23 + var_63_24 then
				local var_63_25 = (arg_60_1.time_ - var_63_23) / var_63_24
				local var_63_26 = Color.New(0, 0, 0)

				var_63_26.a = Mathf.Lerp(1, 0, var_63_25)
				arg_60_1.mask_.color = var_63_26
			end

			if arg_60_1.time_ >= var_63_23 + var_63_24 and arg_60_1.time_ < var_63_23 + var_63_24 + arg_63_0 then
				local var_63_27 = Color.New(0, 0, 0)
				local var_63_28 = 0

				arg_60_1.mask_.enabled = false
				var_63_27.a = var_63_28
				arg_60_1.mask_.color = var_63_27
			end

			local var_63_29 = manager.ui.mainCamera.transform
			local var_63_30 = 1.3

			if var_63_30 < arg_60_1.time_ and arg_60_1.time_ <= var_63_30 + arg_63_0 then
				local var_63_31 = arg_60_1.var_.effectshihaichuxian1

				if var_63_31 then
					Object.Destroy(var_63_31)

					arg_60_1.var_.effectshihaichuxian1 = nil
				end
			end

			local var_63_32 = manager.ui.mainCamera.transform
			local var_63_33 = 1.27466472334539

			if var_63_33 < arg_60_1.time_ and arg_60_1.time_ <= var_63_33 + arg_63_0 then
				local var_63_34 = arg_60_1.var_.effectheisewuqi
				local var_63_35
				local var_63_36 = var_63_32

				if not var_63_34 then
					var_63_34 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_red_out"), var_63_36)
					var_63_34.name = "heisewuqi"
					arg_60_1.var_.effectheisewuqi = var_63_34
				else
					var_63_34.transform:SetParent(var_63_36)
				end

				var_63_34.transform.localPosition = Vector3.New(0, -1.5, 0)
				var_63_34.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_63_37 = 1.7777777777777777
				local var_63_38 = Screen.width / Screen.height
				local var_63_39 = var_63_38 / var_63_37
				local var_63_40 = Mathf.Max(var_63_37 / var_63_38, 1)

				var_63_34.transform.localScale = Vector3.New(var_63_34.transform.localScale.x * var_63_39, var_63_34.transform.localScale.y * var_63_40, var_63_34.transform.localScale.z)
			end

			local var_63_41 = manager.ui.mainCamera.transform
			local var_63_42 = 11.1666666666667

			if var_63_42 < arg_60_1.time_ and arg_60_1.time_ <= var_63_42 + arg_63_0 then
				local var_63_43 = arg_60_1.var_.effectheisewuqi

				if var_63_43 then
					Object.Destroy(var_63_43)

					arg_60_1.var_.effectheisewuqi = nil
				end
			end

			local var_63_44 = arg_60_1.bgs_.MS0301.transform
			local var_63_45 = 1.27466472334539

			if var_63_45 < arg_60_1.time_ and arg_60_1.time_ <= var_63_45 + arg_63_0 then
				arg_60_1.var_.moveOldPosMS0301 = var_63_44.localPosition
			end

			local var_63_46 = 2.6

			if var_63_45 <= arg_60_1.time_ and arg_60_1.time_ < var_63_45 + var_63_46 then
				local var_63_47 = (arg_60_1.time_ - var_63_45) / var_63_46
				local var_63_48 = Vector3.New(0, 1, 7.62)

				var_63_44.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPosMS0301, var_63_48, var_63_47)
			end

			if arg_60_1.time_ >= var_63_45 + var_63_46 and arg_60_1.time_ < var_63_45 + var_63_46 + arg_63_0 then
				var_63_44.localPosition = Vector3.New(0, 1, 7.62)
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_49 = 3.29200194332128
			local var_63_50 = 0.975

			if var_63_49 < arg_60_1.time_ and arg_60_1.time_ <= var_63_49 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_51 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_51:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_52 = arg_60_1:GetWordFromCfg(303041015)
				local var_63_53 = arg_60_1:FormatText(var_63_52.content)

				arg_60_1.text_.text = var_63_53

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_54 = 39
				local var_63_55 = utf8.len(var_63_53)
				local var_63_56 = var_63_54 <= 0 and var_63_50 or var_63_50 * (var_63_55 / var_63_54)

				if var_63_56 > 0 and var_63_50 < var_63_56 then
					arg_60_1.talkMaxDuration = var_63_56
					var_63_49 = var_63_49 + 0.3

					if var_63_56 + var_63_49 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_56 + var_63_49
					end
				end

				arg_60_1.text_.text = var_63_53
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_57 = var_63_49 + 0.3
			local var_63_58 = math.max(var_63_50, arg_60_1.talkMaxDuration)

			if var_63_57 <= arg_60_1.time_ and arg_60_1.time_ < var_63_57 + var_63_58 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_57) / var_63_58

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_57 + var_63_58 and arg_60_1.time_ < var_63_57 + var_63_58 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS0301",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.6,
				startTime = 1.27466472334539,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-3, 0, 3),
					endPos = Vector3.New(0, 1, 7.62),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play303041016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 303041016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play303041017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 1.75

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_2 = arg_66_1:GetWordFromCfg(303041016)
				local var_69_3 = arg_66_1:FormatText(var_69_2.content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 70
				local var_69_5 = utf8.len(var_69_3)
				local var_69_6 = var_69_4 <= 0 and var_69_1 or var_69_1 * (var_69_5 / var_69_4)

				if var_69_6 > 0 and var_69_1 < var_69_6 then
					arg_66_1.talkMaxDuration = var_69_6

					if var_69_6 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_6 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_7 and arg_66_1.time_ < var_69_0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play303041017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 303041017
		arg_70_1.duration_ = 5.43

		local var_70_0 = {
			zh = 5.433,
			ja = 3.433
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
				arg_70_0:Play303041018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.3

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[68].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:GetWordFromCfg(303041017)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 12
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303041", "303041017", "story_v_out_303041.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_303041", "303041017", "story_v_out_303041.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_303041", "303041017", "story_v_out_303041.awb")

						arg_70_1:RecordAudio("303041017", var_73_9)
						arg_70_1:RecordAudio("303041017", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_303041", "303041017", "story_v_out_303041.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_303041", "303041017", "story_v_out_303041.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play303041018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 303041018
		arg_74_1.duration_ = 3.23

		local var_74_0 = {
			zh = 3.233,
			ja = 1.333
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
				arg_74_0:Play303041019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.35

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[6].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:GetWordFromCfg(303041018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_303041", "303041018", "story_v_out_303041.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_303041", "303041018", "story_v_out_303041.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_303041", "303041018", "story_v_out_303041.awb")

						arg_74_1:RecordAudio("303041018", var_77_9)
						arg_74_1:RecordAudio("303041018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_303041", "303041018", "story_v_out_303041.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_303041", "303041018", "story_v_out_303041.awb")
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
	Play303041019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 303041019
		arg_78_1.duration_ = 4.47

		local var_78_0 = {
			zh = 4.466,
			ja = 3.5
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
				arg_78_0:Play303041020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.225

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[68].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_3 = arg_78_1:GetWordFromCfg(303041019)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 9
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303041", "303041019", "story_v_out_303041.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_303041", "303041019", "story_v_out_303041.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_303041", "303041019", "story_v_out_303041.awb")

						arg_78_1:RecordAudio("303041019", var_81_9)
						arg_78_1:RecordAudio("303041019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_303041", "303041019", "story_v_out_303041.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_303041", "303041019", "story_v_out_303041.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play303041020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 303041020
		arg_82_1.duration_ = 5.93

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play303041021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = manager.ui.mainCamera.transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				local var_85_2 = arg_82_1.var_.effectdaoguangduochu1
				local var_85_3
				local var_85_4 = var_85_0

				if not var_85_2 then
					var_85_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), var_85_4)
					var_85_2.name = "daoguangduochu1"
					arg_82_1.var_.effectdaoguangduochu1 = var_85_2
				else
					var_85_2.transform:SetParent(var_85_4)
				end

				var_85_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_85_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_85_5 = manager.ui.mainCamera.transform
			local var_85_6 = 2.53333333333333

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				local var_85_7 = arg_82_1.var_.effectdaoguangduochu1

				if var_85_7 then
					Object.Destroy(var_85_7)

					arg_82_1.var_.effectdaoguangduochu1 = nil
				end
			end

			local var_85_8 = manager.ui.mainCamera.transform
			local var_85_9 = 0

			if var_85_9 < arg_82_1.time_ and arg_82_1.time_ <= var_85_9 + arg_85_0 then
				arg_82_1.var_.shakeOldPos = var_85_8.localPosition
			end

			local var_85_10 = 0.466666666666667

			if var_85_9 <= arg_82_1.time_ and arg_82_1.time_ < var_85_9 + var_85_10 then
				local var_85_11 = (arg_82_1.time_ - var_85_9) / 0.066
				local var_85_12, var_85_13 = math.modf(var_85_11)

				var_85_8.localPosition = Vector3.New(var_85_13 * 0.13, var_85_13 * 0.13, var_85_13 * 0.13) + arg_82_1.var_.shakeOldPos
			end

			if arg_82_1.time_ >= var_85_9 + var_85_10 and arg_82_1.time_ < var_85_9 + var_85_10 + arg_85_0 then
				var_85_8.localPosition = arg_82_1.var_.shakeOldPos
			end

			local var_85_14 = 0

			if var_85_14 < arg_82_1.time_ and arg_82_1.time_ <= var_85_14 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			local var_85_15 = 0.933333333333333

			if arg_82_1.time_ >= var_85_14 + var_85_15 and arg_82_1.time_ < var_85_14 + var_85_15 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end

			if arg_82_1.frameCnt_ <= 1 then
				arg_82_1.dialog_:SetActive(false)
			end

			local var_85_16 = 0.933333333333333
			local var_85_17 = 1.6

			if var_85_16 < arg_82_1.time_ and arg_82_1.time_ <= var_85_16 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				arg_82_1.dialog_:SetActive(true)

				arg_82_1.dialogCg_.alpha = 0

				local var_85_18 = LeanTween.value(arg_82_1.dialog_, 0, 1, 0.3)

				var_85_18:setOnUpdate(LuaHelper.FloatAction(function(arg_86_0)
					arg_82_1.dialogCg_.alpha = arg_86_0
				end))
				var_85_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_82_1.dialog_)
					var_85_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_82_1.duration_ = arg_82_1.duration_ + 0.3

				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_19 = arg_82_1:GetWordFromCfg(303041020)
				local var_85_20 = arg_82_1:FormatText(var_85_19.content)

				arg_82_1.text_.text = var_85_20

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_21 = 64
				local var_85_22 = utf8.len(var_85_20)
				local var_85_23 = var_85_21 <= 0 and var_85_17 or var_85_17 * (var_85_22 / var_85_21)

				if var_85_23 > 0 and var_85_17 < var_85_23 then
					arg_82_1.talkMaxDuration = var_85_23
					var_85_16 = var_85_16 + 0.3

					if var_85_23 + var_85_16 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_23 + var_85_16
					end
				end

				arg_82_1.text_.text = var_85_20
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_24 = var_85_16 + 0.3
			local var_85_25 = math.max(var_85_17, arg_82_1.talkMaxDuration)

			if var_85_24 <= arg_82_1.time_ and arg_82_1.time_ < var_85_24 + var_85_25 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_24) / var_85_25

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_24 + var_85_25 and arg_82_1.time_ < var_85_24 + var_85_25 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play303041021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 303041021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play303041022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 1.075

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_2 = arg_88_1:GetWordFromCfg(303041021)
				local var_91_3 = arg_88_1:FormatText(var_91_2.content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 43
				local var_91_5 = utf8.len(var_91_3)
				local var_91_6 = var_91_4 <= 0 and var_91_1 or var_91_1 * (var_91_5 / var_91_4)

				if var_91_6 > 0 and var_91_1 < var_91_6 then
					arg_88_1.talkMaxDuration = var_91_6

					if var_91_6 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_7 and arg_88_1.time_ < var_91_0 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play303041022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 303041022
		arg_92_1.duration_ = 3.5

		local var_92_0 = {
			zh = 3.5,
			ja = 1.333
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play303041023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 0.375

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[6].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_3 = arg_92_1:GetWordFromCfg(303041022)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 15
				local var_95_6 = utf8.len(var_95_4)
				local var_95_7 = var_95_5 <= 0 and var_95_1 or var_95_1 * (var_95_6 / var_95_5)

				if var_95_7 > 0 and var_95_1 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303041", "303041022", "story_v_out_303041.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_303041", "303041022", "story_v_out_303041.awb") / 1000

					if var_95_8 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_0
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_303041", "303041022", "story_v_out_303041.awb")

						arg_92_1:RecordAudio("303041022", var_95_9)
						arg_92_1:RecordAudio("303041022", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_303041", "303041022", "story_v_out_303041.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_303041", "303041022", "story_v_out_303041.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_10 and arg_92_1.time_ < var_95_0 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play303041023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 303041023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play303041024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.525

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_2 = arg_96_1:FormatText(StoryNameCfg[7].name)

				arg_96_1.leftNameTxt_.text = var_99_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:GetWordFromCfg(303041023)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 21
				local var_99_6 = utf8.len(var_99_4)
				local var_99_7 = var_99_5 <= 0 and var_99_1 or var_99_1 * (var_99_6 / var_99_5)

				if var_99_7 > 0 and var_99_1 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_8 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_8 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_8

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_8 and arg_96_1.time_ < var_99_0 + var_99_8 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play303041024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 303041024
		arg_100_1.duration_ = 4.2

		local var_100_0 = {
			zh = 4.2,
			ja = 1.333
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
				arg_100_0:Play303041025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.525

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[6].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_3 = arg_100_1:GetWordFromCfg(303041024)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 21
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303041", "303041024", "story_v_out_303041.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_303041", "303041024", "story_v_out_303041.awb") / 1000

					if var_103_8 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_0
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_303041", "303041024", "story_v_out_303041.awb")

						arg_100_1:RecordAudio("303041024", var_103_9)
						arg_100_1:RecordAudio("303041024", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_303041", "303041024", "story_v_out_303041.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_303041", "303041024", "story_v_out_303041.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_10 and arg_100_1.time_ < var_103_0 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play303041025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 303041025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play303041026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 1.625

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_2 = arg_104_1:GetWordFromCfg(303041025)
				local var_107_3 = arg_104_1:FormatText(var_107_2.content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 65
				local var_107_5 = utf8.len(var_107_3)
				local var_107_6 = var_107_4 <= 0 and var_107_1 or var_107_1 * (var_107_5 / var_107_4)

				if var_107_6 > 0 and var_107_1 < var_107_6 then
					arg_104_1.talkMaxDuration = var_107_6

					if var_107_6 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_7 and arg_104_1.time_ < var_107_0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play303041026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 303041026
		arg_108_1.duration_ = 7.1

		local var_108_0 = {
			zh = 7.1,
			ja = 1.333
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
				arg_108_0:Play303041027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = manager.ui.mainCamera.transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.shakeOldPos = var_111_0.localPosition
			end

			local var_111_2 = 0.3

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / 0.066
				local var_111_4, var_111_5 = math.modf(var_111_3)

				var_111_0.localPosition = Vector3.New(var_111_5 * 0.13, var_111_5 * 0.13, var_111_5 * 0.13) + arg_108_1.var_.shakeOldPos
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = arg_108_1.var_.shakeOldPos
			end

			local var_111_6 = 0

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.allBtn_.enabled = false
			end

			local var_111_7 = 0.3

			if arg_108_1.time_ >= var_111_6 + var_111_7 and arg_108_1.time_ < var_111_6 + var_111_7 + arg_111_0 then
				arg_108_1.allBtn_.enabled = true
			end

			local var_111_8 = 0
			local var_111_9 = 0.575

			if var_111_8 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_10 = arg_108_1:FormatText(StoryNameCfg[6].name)

				arg_108_1.leftNameTxt_.text = var_111_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_11 = arg_108_1:GetWordFromCfg(303041026)
				local var_111_12 = arg_108_1:FormatText(var_111_11.content)

				arg_108_1.text_.text = var_111_12

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_13 = 23
				local var_111_14 = utf8.len(var_111_12)
				local var_111_15 = var_111_13 <= 0 and var_111_9 or var_111_9 * (var_111_14 / var_111_13)

				if var_111_15 > 0 and var_111_9 < var_111_15 then
					arg_108_1.talkMaxDuration = var_111_15

					if var_111_15 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_15 + var_111_8
					end
				end

				arg_108_1.text_.text = var_111_12
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303041", "303041026", "story_v_out_303041.awb") ~= 0 then
					local var_111_16 = manager.audio:GetVoiceLength("story_v_out_303041", "303041026", "story_v_out_303041.awb") / 1000

					if var_111_16 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_16 + var_111_8
					end

					if var_111_11.prefab_name ~= "" and arg_108_1.actors_[var_111_11.prefab_name] ~= nil then
						local var_111_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_11.prefab_name].transform, "story_v_out_303041", "303041026", "story_v_out_303041.awb")

						arg_108_1:RecordAudio("303041026", var_111_17)
						arg_108_1:RecordAudio("303041026", var_111_17)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_303041", "303041026", "story_v_out_303041.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_303041", "303041026", "story_v_out_303041.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_18 = math.max(var_111_9, arg_108_1.talkMaxDuration)

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_18 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_8) / var_111_18

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_8 + var_111_18 and arg_108_1.time_ < var_111_8 + var_111_18 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play303041027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 303041027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play303041028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.4

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[7].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(303041027)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 16
				local var_115_6 = utf8.len(var_115_4)
				local var_115_7 = var_115_5 <= 0 and var_115_1 or var_115_1 * (var_115_6 / var_115_5)

				if var_115_7 > 0 and var_115_1 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_8 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_8 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_8

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_8 and arg_112_1.time_ < var_115_0 + var_115_8 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play303041028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 303041028
		arg_116_1.duration_ = 1.33

		local var_116_0 = {
			zh = 1.133,
			ja = 1.333
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
				arg_116_0:Play303041029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.075

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[6].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:GetWordFromCfg(303041028)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_303041", "303041028", "story_v_out_303041.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_303041", "303041028", "story_v_out_303041.awb") / 1000

					if var_119_8 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_0
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_303041", "303041028", "story_v_out_303041.awb")

						arg_116_1:RecordAudio("303041028", var_119_9)
						arg_116_1:RecordAudio("303041028", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_303041", "303041028", "story_v_out_303041.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_303041", "303041028", "story_v_out_303041.awb")
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
	Play303041029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 303041029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play303041030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.075

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[7].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(303041029)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 3
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_8 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_8 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_8

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_8 and arg_120_1.time_ < var_123_0 + var_123_8 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play303041030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 303041030
		arg_124_1.duration_ = 5.5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play303041031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = manager.ui.mainCamera.transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				local var_127_2 = arg_124_1.var_.effecthengsao1
				local var_127_3
				local var_127_4 = var_127_0

				if not var_127_2 then
					var_127_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), var_127_4)
					var_127_2.name = "hengsao1"
					arg_124_1.var_.effecthengsao1 = var_127_2
				else
					var_127_2.transform:SetParent(var_127_4)
				end

				var_127_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_127_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_127_5 = manager.ui.mainCamera.transform
			local var_127_6 = 1.975

			if var_127_6 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				local var_127_7 = arg_124_1.var_.effecthengsao1

				if var_127_7 then
					Object.Destroy(var_127_7)

					arg_124_1.var_.effecthengsao1 = nil
				end
			end

			local var_127_8 = manager.ui.mainCamera.transform
			local var_127_9 = 0

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 then
				arg_124_1.var_.shakeOldPos = var_127_8.localPosition
			end

			local var_127_10 = 0.266666666666667

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_10 then
				local var_127_11 = (arg_124_1.time_ - var_127_9) / 0.066
				local var_127_12, var_127_13 = math.modf(var_127_11)

				var_127_8.localPosition = Vector3.New(var_127_13 * 0.13, var_127_13 * 0.13, var_127_13 * 0.13) + arg_124_1.var_.shakeOldPos
			end

			if arg_124_1.time_ >= var_127_9 + var_127_10 and arg_124_1.time_ < var_127_9 + var_127_10 + arg_127_0 then
				var_127_8.localPosition = arg_124_1.var_.shakeOldPos
			end

			local var_127_14 = 0

			if var_127_14 < arg_124_1.time_ and arg_124_1.time_ <= var_127_14 + arg_127_0 then
				arg_124_1.allBtn_.enabled = false
			end

			local var_127_15 = 1.33333333333333

			if arg_124_1.time_ >= var_127_14 + var_127_15 and arg_124_1.time_ < var_127_14 + var_127_15 + arg_127_0 then
				arg_124_1.allBtn_.enabled = true
			end

			local var_127_16 = arg_124_1.bgs_.MS0301.transform
			local var_127_17 = 0

			if var_127_17 < arg_124_1.time_ and arg_124_1.time_ <= var_127_17 + arg_127_0 then
				arg_124_1.var_.moveOldPosMS0301 = var_127_16.localPosition
			end

			local var_127_18 = 0.266666666666667

			if var_127_17 <= arg_124_1.time_ and arg_124_1.time_ < var_127_17 + var_127_18 then
				local var_127_19 = (arg_124_1.time_ - var_127_17) / var_127_18
				local var_127_20 = Vector3.New(0, 1, 6)

				var_127_16.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPosMS0301, var_127_20, var_127_19)
			end

			if arg_124_1.time_ >= var_127_17 + var_127_18 and arg_124_1.time_ < var_127_17 + var_127_18 + arg_127_0 then
				var_127_16.localPosition = Vector3.New(0, 1, 6)
			end

			local var_127_21 = 0.8
			local var_127_22 = 1

			if var_127_21 < arg_124_1.time_ and arg_124_1.time_ <= var_127_21 + arg_127_0 then
				local var_127_23 = "play"
				local var_127_24 = "effect"

				arg_124_1:AudioAction(var_127_23, var_127_24, "se_story_152", "se_story_152_machine", "")
			end

			local var_127_25 = 0.5
			local var_127_26 = 1.475

			if var_127_25 < arg_124_1.time_ and arg_124_1.time_ <= var_127_25 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_27 = arg_124_1:GetWordFromCfg(303041030)
				local var_127_28 = arg_124_1:FormatText(var_127_27.content)

				arg_124_1.text_.text = var_127_28

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_29 = 59
				local var_127_30 = utf8.len(var_127_28)
				local var_127_31 = var_127_29 <= 0 and var_127_26 or var_127_26 * (var_127_30 / var_127_29)

				if var_127_31 > 0 and var_127_26 < var_127_31 then
					arg_124_1.talkMaxDuration = var_127_31

					if var_127_31 + var_127_25 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_31 + var_127_25
					end
				end

				arg_124_1.text_.text = var_127_28
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_32 = math.max(var_127_26, arg_124_1.talkMaxDuration)

			if var_127_25 <= arg_124_1.time_ and arg_124_1.time_ < var_127_25 + var_127_32 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_25) / var_127_32

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_25 + var_127_32 and arg_124_1.time_ < var_127_25 + var_127_32 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS0301",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.266666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 7.62),
					endPos = Vector3.New(0, 1, 6),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play303041031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 303041031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play303041032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.9
			local var_131_1 = 1

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				local var_131_2 = "play"
				local var_131_3 = "effect"

				arg_128_1:AudioAction(var_131_2, var_131_3, "se_story_135_01", "se_story_135_01_scream", "")
			end

			local var_131_4 = 0.4
			local var_131_5 = 1

			if var_131_4 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				local var_131_6 = "play"
				local var_131_7 = "effect"

				arg_128_1:AudioAction(var_131_6, var_131_7, "se_story_144", "se_story_144_metal", "")
			end

			local var_131_8 = 0
			local var_131_9 = 1.2

			if var_131_8 < arg_128_1.time_ and arg_128_1.time_ <= var_131_8 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_10 = arg_128_1:GetWordFromCfg(303041031)
				local var_131_11 = arg_128_1:FormatText(var_131_10.content)

				arg_128_1.text_.text = var_131_11

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_12 = 48
				local var_131_13 = utf8.len(var_131_11)
				local var_131_14 = var_131_12 <= 0 and var_131_9 or var_131_9 * (var_131_13 / var_131_12)

				if var_131_14 > 0 and var_131_9 < var_131_14 then
					arg_128_1.talkMaxDuration = var_131_14

					if var_131_14 + var_131_8 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_14 + var_131_8
					end
				end

				arg_128_1.text_.text = var_131_11
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_15 = math.max(var_131_9, arg_128_1.talkMaxDuration)

			if var_131_8 <= arg_128_1.time_ and arg_128_1.time_ < var_131_8 + var_131_15 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_8) / var_131_15

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_8 + var_131_15 and arg_128_1.time_ < var_131_8 + var_131_15 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play303041032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 303041032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play303041033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 1.425

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_2 = arg_132_1:GetWordFromCfg(303041032)
				local var_135_3 = arg_132_1:FormatText(var_135_2.content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 57
				local var_135_5 = utf8.len(var_135_3)
				local var_135_6 = var_135_4 <= 0 and var_135_1 or var_135_1 * (var_135_5 / var_135_4)

				if var_135_6 > 0 and var_135_1 < var_135_6 then
					arg_132_1.talkMaxDuration = var_135_6

					if var_135_6 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_3
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_7 and arg_132_1.time_ < var_135_0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play303041033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 303041033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play303041034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.675

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[7].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:GetWordFromCfg(303041033)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 27
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_8 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_8 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_8

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_8 and arg_136_1.time_ < var_139_0 + var_139_8 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play303041034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 303041034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play303041035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 0.5

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

				local var_143_3 = arg_140_1:GetWordFromCfg(303041034)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 20
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
	Play303041035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 303041035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play303041036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 1.275

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_2 = arg_144_1:GetWordFromCfg(303041035)
				local var_147_3 = arg_144_1:FormatText(var_147_2.content)

				arg_144_1.text_.text = var_147_3

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 51
				local var_147_5 = utf8.len(var_147_3)
				local var_147_6 = var_147_4 <= 0 and var_147_1 or var_147_1 * (var_147_5 / var_147_4)

				if var_147_6 > 0 and var_147_1 < var_147_6 then
					arg_144_1.talkMaxDuration = var_147_6

					if var_147_6 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_6 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_3
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_7 and arg_144_1.time_ < var_147_0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play303041036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 303041036
		arg_148_1.duration_ = 3.8

		local var_148_0 = {
			zh = 3.8,
			ja = 1.333
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
			arg_148_1.auto_ = false
		end

		function arg_148_1.playNext_(arg_150_0)
			arg_148_1.onStoryFinished_()
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.bgs_.MS0301.transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPosMS0301 = var_151_0.localPosition
			end

			local var_151_2 = 1.13333333333333

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0, 1, 10)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPosMS0301, var_151_4, var_151_3)
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_151_5 = 0

			if var_151_5 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1.allBtn_.enabled = false
			end

			local var_151_6 = 1.13333333333333

			if arg_148_1.time_ >= var_151_5 + var_151_6 and arg_148_1.time_ < var_151_5 + var_151_6 + arg_151_0 then
				arg_148_1.allBtn_.enabled = true
			end

			local var_151_7 = 0
			local var_151_8 = 0.175

			if var_151_7 < arg_148_1.time_ and arg_148_1.time_ <= var_151_7 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_9 = arg_148_1:FormatText(StoryNameCfg[6].name)

				arg_148_1.leftNameTxt_.text = var_151_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_10 = arg_148_1:GetWordFromCfg(303041036)
				local var_151_11 = arg_148_1:FormatText(var_151_10.content)

				arg_148_1.text_.text = var_151_11

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_12 = 7
				local var_151_13 = utf8.len(var_151_11)
				local var_151_14 = var_151_12 <= 0 and var_151_8 or var_151_8 * (var_151_13 / var_151_12)

				if var_151_14 > 0 and var_151_8 < var_151_14 then
					arg_148_1.talkMaxDuration = var_151_14

					if var_151_14 + var_151_7 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_14 + var_151_7
					end
				end

				arg_148_1.text_.text = var_151_11
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303041", "303041036", "story_v_out_303041.awb") ~= 0 then
					local var_151_15 = manager.audio:GetVoiceLength("story_v_out_303041", "303041036", "story_v_out_303041.awb") / 1000

					if var_151_15 + var_151_7 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_15 + var_151_7
					end

					if var_151_10.prefab_name ~= "" and arg_148_1.actors_[var_151_10.prefab_name] ~= nil then
						local var_151_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_10.prefab_name].transform, "story_v_out_303041", "303041036", "story_v_out_303041.awb")

						arg_148_1:RecordAudio("303041036", var_151_16)
						arg_148_1:RecordAudio("303041036", var_151_16)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_303041", "303041036", "story_v_out_303041.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_303041", "303041036", "story_v_out_303041.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_17 = math.max(var_151_8, arg_148_1.talkMaxDuration)

			if var_151_7 <= arg_148_1.time_ and arg_148_1.time_ < var_151_7 + var_151_17 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_7) / var_151_17

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_7 + var_151_17 and arg_148_1.time_ < var_151_7 + var_151_17 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS0301",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.13333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 6),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutQuint
				}
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B15f",
		"TextureConfig/Background/MS0301"
	},
	voices = {
		"story_v_out_303041.awb"
	}
}
