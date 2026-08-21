return {
	Play122152001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122152001
		arg_1_1.duration_ = 7.7

		local var_1_0 = {
			ja = 7.70000000298023,
			ko = 7.00000000298023,
			zh = 7.00000000298023
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
				arg_1_0:Play122152002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J11"

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
				local var_4_5 = arg_1_1.bgs_.J11

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
					if iter_4_0 ~= "J11" then
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

			local var_4_22 = "10037ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "10037ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_1_1.stage_.transform)

					var_4_24.name = var_4_22
					var_4_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_22] = var_4_24

					local var_4_25 = var_4_24:GetComponentInChildren(typeof(CharacterEffect))

					var_4_25.enabled = true

					local var_4_26 = GameObjectTools.GetOrAddComponent(var_4_24, typeof(DynamicBoneHelper))

					if var_4_26 then
						var_4_26:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_25.transform, false)

					arg_1_1.var_[var_4_22 .. "Animator"] = var_4_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_22 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_22 .. "LipSync"] = var_4_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_27 = arg_1_1.actors_["10037ui_story"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos10037ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -1.13, -6.2)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10037ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["10037ui_story"]
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect10037ui_story == nil then
				arg_1_1.var_.characterEffect10037ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect10037ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect10037ui_story then
				arg_1_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_4_40 = 1.8

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action6_2")
			end

			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_4_42 = 0
			local var_4_43 = 0.233333333333333

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "music"

				arg_1_1:AudioAction(var_4_44, var_4_45, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_46 = ""
				local var_4_47 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_47 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_47 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_47

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_47
						arg_1_1.bgmTxt2_.text = var_4_47
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

			local var_4_48 = 1.46666666666667
			local var_4_49 = 1

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_activity_2_1_battle_city", "bgm_activity_2_1_battle_city", "bgm_activity_2_1_battle_city.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_activity_2_1_battle_city", "bgm_activity_2_1_battle_city")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_54 = 2.00000000298023
			local var_4_55 = 0.375

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_56 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_56:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[383].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(122152001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 15
				local var_4_61 = utf8.len(var_4_59)
				local var_4_62 = var_4_60 <= 0 and var_4_55 or var_4_55 * (var_4_61 / var_4_60)

				if var_4_62 > 0 and var_4_55 < var_4_62 then
					arg_1_1.talkMaxDuration = var_4_62
					var_4_54 = var_4_54 + 0.3

					if var_4_62 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_54
					end
				end

				arg_1_1.text_.text = var_4_59
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152001", "story_v_out_122152.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_out_122152", "122152001", "story_v_out_122152.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_out_122152", "122152001", "story_v_out_122152.awb")

						arg_1_1:RecordAudio("122152001", var_4_64)
						arg_1_1:RecordAudio("122152001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_122152", "122152001", "story_v_out_122152.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_122152", "122152001", "story_v_out_122152.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_65 = var_4_54 + 0.3
			local var_4_66 = math.max(var_4_55, arg_1_1.talkMaxDuration)

			if var_4_65 <= arg_1_1.time_ and arg_1_1.time_ < var_4_65 + var_4_66 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_65) / var_4_66

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_65 + var_4_66 and arg_1_1.time_ < var_4_65 + var_4_66 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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
	Play122152002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 122152002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play122152003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10037ui_story"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos10037ui_story = var_12_0.localPosition
			end

			local var_12_2 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2
				local var_12_4 = Vector3.New(0, 100, 0)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10037ui_story, var_12_4, var_12_3)

				local var_12_5 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_5.x, var_12_5.y, var_12_5.z)

				local var_12_6 = var_12_0.localEulerAngles

				var_12_6.z = 0
				var_12_6.x = 0
				var_12_0.localEulerAngles = var_12_6
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, 100, 0)

				local var_12_7 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_7.x, var_12_7.y, var_12_7.z)

				local var_12_8 = var_12_0.localEulerAngles

				var_12_8.z = 0
				var_12_8.x = 0
				var_12_0.localEulerAngles = var_12_8
			end

			local var_12_9 = arg_9_1.actors_["10037ui_story"]
			local var_12_10 = 0

			if var_12_10 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 and not isNil(var_12_9) and arg_9_1.var_.characterEffect10037ui_story == nil then
				arg_9_1.var_.characterEffect10037ui_story = var_12_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_11 = 0.200000002980232

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_11 and not isNil(var_12_9) then
				local var_12_12 = (arg_9_1.time_ - var_12_10) / var_12_11

				if arg_9_1.var_.characterEffect10037ui_story and not isNil(var_12_9) then
					local var_12_13 = Mathf.Lerp(0, 0.5, var_12_12)

					arg_9_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10037ui_story.fillRatio = var_12_13
				end
			end

			if arg_9_1.time_ >= var_12_10 + var_12_11 and arg_9_1.time_ < var_12_10 + var_12_11 + arg_12_0 and not isNil(var_12_9) and arg_9_1.var_.characterEffect10037ui_story then
				local var_12_14 = 0.5

				arg_9_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10037ui_story.fillRatio = var_12_14
			end

			local var_12_15 = 0
			local var_12_16 = 1.525

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_17 = arg_9_1:GetWordFromCfg(122152002)
				local var_12_18 = arg_9_1:FormatText(var_12_17.content)

				arg_9_1.text_.text = var_12_18

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_19 = 61
				local var_12_20 = utf8.len(var_12_18)
				local var_12_21 = var_12_19 <= 0 and var_12_16 or var_12_16 * (var_12_20 / var_12_19)

				if var_12_21 > 0 and var_12_16 < var_12_21 then
					arg_9_1.talkMaxDuration = var_12_21

					if var_12_21 + var_12_15 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_21 + var_12_15
					end
				end

				arg_9_1.text_.text = var_12_18
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_22 = math.max(var_12_16, arg_9_1.talkMaxDuration)

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_22 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_15) / var_12_22

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_15 + var_12_22 and arg_9_1.time_ < var_12_15 + var_12_22 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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
	Play122152003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 122152003
		arg_13_1.duration_ = 10.17

		local var_13_0 = {
			ja = 10.166,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_13_0:Play122152004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10037ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10037ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, -1.13, -6.2)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10037ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["10037ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect10037ui_story == nil then
				arg_13_1.var_.characterEffect10037ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect10037ui_story and not isNil(var_16_9) then
					arg_13_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect10037ui_story then
				arg_13_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_16_14 = 0
			local var_16_15 = 0.2

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_16 = arg_13_1:FormatText(StoryNameCfg[383].name)

				arg_13_1.leftNameTxt_.text = var_16_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_17 = arg_13_1:GetWordFromCfg(122152003)
				local var_16_18 = arg_13_1:FormatText(var_16_17.content)

				arg_13_1.text_.text = var_16_18

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_19 = 8
				local var_16_20 = utf8.len(var_16_18)
				local var_16_21 = var_16_19 <= 0 and var_16_15 or var_16_15 * (var_16_20 / var_16_19)

				if var_16_21 > 0 and var_16_15 < var_16_21 then
					arg_13_1.talkMaxDuration = var_16_21

					if var_16_21 + var_16_14 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_21 + var_16_14
					end
				end

				arg_13_1.text_.text = var_16_18
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152003", "story_v_out_122152.awb") ~= 0 then
					local var_16_22 = manager.audio:GetVoiceLength("story_v_out_122152", "122152003", "story_v_out_122152.awb") / 1000

					if var_16_22 + var_16_14 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_22 + var_16_14
					end

					if var_16_17.prefab_name ~= "" and arg_13_1.actors_[var_16_17.prefab_name] ~= nil then
						local var_16_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_17.prefab_name].transform, "story_v_out_122152", "122152003", "story_v_out_122152.awb")

						arg_13_1:RecordAudio("122152003", var_16_23)
						arg_13_1:RecordAudio("122152003", var_16_23)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_122152", "122152003", "story_v_out_122152.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_122152", "122152003", "story_v_out_122152.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_24 = math.max(var_16_15, arg_13_1.talkMaxDuration)

			if var_16_14 <= arg_13_1.time_ and arg_13_1.time_ < var_16_14 + var_16_24 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_14) / var_16_24

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_14 + var_16_24 and arg_13_1.time_ < var_16_14 + var_16_24 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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
	Play122152004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 122152004
		arg_17_1.duration_ = 5.9

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play122152005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10037ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos10037ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10037ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, 100, 0)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["10037ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect10037ui_story == nil then
				arg_17_1.var_.characterEffect10037ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect10037ui_story and not isNil(var_20_9) then
					local var_20_13 = Mathf.Lerp(0, 0.5, var_20_12)

					arg_17_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10037ui_story.fillRatio = var_20_13
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect10037ui_story then
				local var_20_14 = 0.5

				arg_17_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10037ui_story.fillRatio = var_20_14
			end

			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_16 = 2

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16
				local var_20_18 = Color.New(1, 1, 1)

				var_20_18.a = Mathf.Lerp(1, 0, var_20_17)
				arg_17_1.mask_.color = var_20_18
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 then
				local var_20_19 = Color.New(1, 1, 1)
				local var_20_20 = 0

				arg_17_1.mask_.enabled = false
				var_20_19.a = var_20_20
				arg_17_1.mask_.color = var_20_19
			end

			local var_20_21 = manager.ui.mainCamera.transform
			local var_20_22 = 1

			if var_20_22 < arg_17_1.time_ and arg_17_1.time_ <= var_20_22 + arg_20_0 then
				arg_17_1.var_.shakeOldPos = var_20_21.localPosition
			end

			local var_20_23 = 1

			if var_20_22 <= arg_17_1.time_ and arg_17_1.time_ < var_20_22 + var_20_23 then
				local var_20_24 = (arg_17_1.time_ - var_20_22) / 0.066
				local var_20_25, var_20_26 = math.modf(var_20_24)

				var_20_21.localPosition = Vector3.New(var_20_26 * 0.13, var_20_26 * 0.13, var_20_26 * 0.13) + arg_17_1.var_.shakeOldPos
			end

			if arg_17_1.time_ >= var_20_22 + var_20_23 and arg_17_1.time_ < var_20_22 + var_20_23 + arg_20_0 then
				var_20_21.localPosition = arg_17_1.var_.shakeOldPos
			end

			local var_20_27 = 0
			local var_20_28 = 1

			if var_20_27 < arg_17_1.time_ and arg_17_1.time_ <= var_20_27 + arg_20_0 then
				local var_20_29 = "play"
				local var_20_30 = "effect"

				arg_17_1:AudioAction(var_20_29, var_20_30, "se_story_122_02", "se_story_122_02_hack", "")
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_31 = 0.9
			local var_20_32 = 1.525

			if var_20_31 < arg_17_1.time_ and arg_17_1.time_ <= var_20_31 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_33 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_33:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_34 = arg_17_1:GetWordFromCfg(122152004)
				local var_20_35 = arg_17_1:FormatText(var_20_34.content)

				arg_17_1.text_.text = var_20_35

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_36 = 61
				local var_20_37 = utf8.len(var_20_35)
				local var_20_38 = var_20_36 <= 0 and var_20_32 or var_20_32 * (var_20_37 / var_20_36)

				if var_20_38 > 0 and var_20_32 < var_20_38 then
					arg_17_1.talkMaxDuration = var_20_38
					var_20_31 = var_20_31 + 0.3

					if var_20_38 + var_20_31 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_38 + var_20_31
					end
				end

				arg_17_1.text_.text = var_20_35
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_39 = var_20_31 + 0.3
			local var_20_40 = math.max(var_20_32, arg_17_1.talkMaxDuration)

			if var_20_39 <= arg_17_1.time_ and arg_17_1.time_ < var_20_39 + var_20_40 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_39) / var_20_40

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_39 + var_20_40 and arg_17_1.time_ < var_20_39 + var_20_40 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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
	Play122152005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 122152005
		arg_23_1.duration_ = 8.27

		local var_23_0 = {
			ja = 7.833,
			ko = 8.266,
			zh = 8.266
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
				arg_23_0:Play122152006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = "10051ui_story"

			if arg_23_1.actors_[var_26_0] == nil then
				local var_26_1 = Asset.Load("Char/" .. "10051ui_story")

				if not isNil(var_26_1) then
					local var_26_2 = Object.Instantiate(Asset.Load("Char/" .. "10051ui_story"), arg_23_1.stage_.transform)

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

			local var_26_5 = arg_23_1.actors_["10051ui_story"].transform
			local var_26_6 = 0

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.var_.moveOldPos10051ui_story = var_26_5.localPosition

				local var_26_7 = "10051ui_story"

				arg_23_1:ShowWeapon(arg_23_1.var_[var_26_7 .. "Animator"].transform, true)
			end

			local var_26_8 = 0.001

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_8 then
				local var_26_9 = (arg_23_1.time_ - var_26_6) / var_26_8
				local var_26_10 = Vector3.New(-0.7, -1.11, -5.6)

				var_26_5.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10051ui_story, var_26_10, var_26_9)

				local var_26_11 = manager.ui.mainCamera.transform.position - var_26_5.position

				var_26_5.forward = Vector3.New(var_26_11.x, var_26_11.y, var_26_11.z)

				local var_26_12 = var_26_5.localEulerAngles

				var_26_12.z = 0
				var_26_12.x = 0
				var_26_5.localEulerAngles = var_26_12
			end

			if arg_23_1.time_ >= var_26_6 + var_26_8 and arg_23_1.time_ < var_26_6 + var_26_8 + arg_26_0 then
				var_26_5.localPosition = Vector3.New(-0.7, -1.11, -5.6)

				local var_26_13 = manager.ui.mainCamera.transform.position - var_26_5.position

				var_26_5.forward = Vector3.New(var_26_13.x, var_26_13.y, var_26_13.z)

				local var_26_14 = var_26_5.localEulerAngles

				var_26_14.z = 0
				var_26_14.x = 0
				var_26_5.localEulerAngles = var_26_14
			end

			local var_26_15 = arg_23_1.actors_["10051ui_story"]
			local var_26_16 = 0

			if var_26_16 < arg_23_1.time_ and arg_23_1.time_ <= var_26_16 + arg_26_0 and not isNil(var_26_15) and arg_23_1.var_.characterEffect10051ui_story == nil then
				arg_23_1.var_.characterEffect10051ui_story = var_26_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_17 = 0.200000002980232

			if var_26_16 <= arg_23_1.time_ and arg_23_1.time_ < var_26_16 + var_26_17 and not isNil(var_26_15) then
				local var_26_18 = (arg_23_1.time_ - var_26_16) / var_26_17

				if arg_23_1.var_.characterEffect10051ui_story and not isNil(var_26_15) then
					arg_23_1.var_.characterEffect10051ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_16 + var_26_17 and arg_23_1.time_ < var_26_16 + var_26_17 + arg_26_0 and not isNil(var_26_15) and arg_23_1.var_.characterEffect10051ui_story then
				arg_23_1.var_.characterEffect10051ui_story.fillFlat = false
			end

			local var_26_19 = 0

			if var_26_19 < arg_23_1.time_ and arg_23_1.time_ <= var_26_19 + arg_26_0 then
				arg_23_1:PlayTimeline("10051ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_26_20 = 0

			if var_26_20 < arg_23_1.time_ and arg_23_1.time_ <= var_26_20 + arg_26_0 then
				arg_23_1:PlayTimeline("10051ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_26_21 = arg_23_1.actors_["10037ui_story"].transform
			local var_26_22 = 0

			if var_26_22 < arg_23_1.time_ and arg_23_1.time_ <= var_26_22 + arg_26_0 then
				arg_23_1.var_.moveOldPos10037ui_story = var_26_21.localPosition
			end

			local var_26_23 = 0.001

			if var_26_22 <= arg_23_1.time_ and arg_23_1.time_ < var_26_22 + var_26_23 then
				local var_26_24 = (arg_23_1.time_ - var_26_22) / var_26_23
				local var_26_25 = Vector3.New(0.7, -1.13, -6.2)

				var_26_21.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10037ui_story, var_26_25, var_26_24)

				local var_26_26 = manager.ui.mainCamera.transform.position - var_26_21.position

				var_26_21.forward = Vector3.New(var_26_26.x, var_26_26.y, var_26_26.z)

				local var_26_27 = var_26_21.localEulerAngles

				var_26_27.z = 0
				var_26_27.x = 0
				var_26_21.localEulerAngles = var_26_27
			end

			if arg_23_1.time_ >= var_26_22 + var_26_23 and arg_23_1.time_ < var_26_22 + var_26_23 + arg_26_0 then
				var_26_21.localPosition = Vector3.New(0.7, -1.13, -6.2)

				local var_26_28 = manager.ui.mainCamera.transform.position - var_26_21.position

				var_26_21.forward = Vector3.New(var_26_28.x, var_26_28.y, var_26_28.z)

				local var_26_29 = var_26_21.localEulerAngles

				var_26_29.z = 0
				var_26_29.x = 0
				var_26_21.localEulerAngles = var_26_29
			end

			local var_26_30 = arg_23_1.actors_["10037ui_story"]
			local var_26_31 = 0

			if var_26_31 < arg_23_1.time_ and arg_23_1.time_ <= var_26_31 + arg_26_0 and not isNil(var_26_30) and arg_23_1.var_.characterEffect10037ui_story == nil then
				arg_23_1.var_.characterEffect10037ui_story = var_26_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_32 = 0.0166666666666667

			if var_26_31 <= arg_23_1.time_ and arg_23_1.time_ < var_26_31 + var_26_32 and not isNil(var_26_30) then
				local var_26_33 = (arg_23_1.time_ - var_26_31) / var_26_32

				if arg_23_1.var_.characterEffect10037ui_story and not isNil(var_26_30) then
					arg_23_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_31 + var_26_32 and arg_23_1.time_ < var_26_31 + var_26_32 + arg_26_0 and not isNil(var_26_30) and arg_23_1.var_.characterEffect10037ui_story then
				arg_23_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_26_34 = arg_23_1.actors_["10037ui_story"]
			local var_26_35 = 0

			if var_26_35 < arg_23_1.time_ and arg_23_1.time_ <= var_26_35 + arg_26_0 and not isNil(var_26_34) and arg_23_1.var_.characterEffect10037ui_story == nil then
				arg_23_1.var_.characterEffect10037ui_story = var_26_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_36 = 0.034000001847744

			if var_26_35 <= arg_23_1.time_ and arg_23_1.time_ < var_26_35 + var_26_36 and not isNil(var_26_34) then
				local var_26_37 = (arg_23_1.time_ - var_26_35) / var_26_36

				if arg_23_1.var_.characterEffect10037ui_story and not isNil(var_26_34) then
					local var_26_38 = Mathf.Lerp(0, 0.5, var_26_37)

					arg_23_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_23_1.var_.characterEffect10037ui_story.fillRatio = var_26_38
				end
			end

			if arg_23_1.time_ >= var_26_35 + var_26_36 and arg_23_1.time_ < var_26_35 + var_26_36 + arg_26_0 and not isNil(var_26_34) and arg_23_1.var_.characterEffect10037ui_story then
				local var_26_39 = 0.5

				arg_23_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_23_1.var_.characterEffect10037ui_story.fillRatio = var_26_39
			end

			local var_26_40 = 0
			local var_26_41 = 0.75

			if var_26_40 < arg_23_1.time_ and arg_23_1.time_ <= var_26_40 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_42 = arg_23_1:FormatText(StoryNameCfg[6].name)

				arg_23_1.leftNameTxt_.text = var_26_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_43 = arg_23_1:GetWordFromCfg(122152005)
				local var_26_44 = arg_23_1:FormatText(var_26_43.content)

				arg_23_1.text_.text = var_26_44

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_45 = 30
				local var_26_46 = utf8.len(var_26_44)
				local var_26_47 = var_26_45 <= 0 and var_26_41 or var_26_41 * (var_26_46 / var_26_45)

				if var_26_47 > 0 and var_26_41 < var_26_47 then
					arg_23_1.talkMaxDuration = var_26_47

					if var_26_47 + var_26_40 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_47 + var_26_40
					end
				end

				arg_23_1.text_.text = var_26_44
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152005", "story_v_out_122152.awb") ~= 0 then
					local var_26_48 = manager.audio:GetVoiceLength("story_v_out_122152", "122152005", "story_v_out_122152.awb") / 1000

					if var_26_48 + var_26_40 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_48 + var_26_40
					end

					if var_26_43.prefab_name ~= "" and arg_23_1.actors_[var_26_43.prefab_name] ~= nil then
						local var_26_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_43.prefab_name].transform, "story_v_out_122152", "122152005", "story_v_out_122152.awb")

						arg_23_1:RecordAudio("122152005", var_26_49)
						arg_23_1:RecordAudio("122152005", var_26_49)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_122152", "122152005", "story_v_out_122152.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_122152", "122152005", "story_v_out_122152.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_50 = math.max(var_26_41, arg_23_1.talkMaxDuration)

			if var_26_40 <= arg_23_1.time_ and arg_23_1.time_ < var_26_40 + var_26_50 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_40) / var_26_50

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_40 + var_26_50 and arg_23_1.time_ < var_26_40 + var_26_50 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10051ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10037ui_story",
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
	Play122152006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 122152006
		arg_27_1.duration_ = 7.63

		local var_27_0 = {
			ja = 7.633,
			ko = 4.433,
			zh = 4.433
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
				arg_27_0:Play122152007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 0.45

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_2 = arg_27_1:FormatText(StoryNameCfg[6].name)

				arg_27_1.leftNameTxt_.text = var_30_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_3 = arg_27_1:GetWordFromCfg(122152006)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 18
				local var_30_6 = utf8.len(var_30_4)
				local var_30_7 = var_30_5 <= 0 and var_30_1 or var_30_1 * (var_30_6 / var_30_5)

				if var_30_7 > 0 and var_30_1 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152006", "story_v_out_122152.awb") ~= 0 then
					local var_30_8 = manager.audio:GetVoiceLength("story_v_out_122152", "122152006", "story_v_out_122152.awb") / 1000

					if var_30_8 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_0
					end

					if var_30_3.prefab_name ~= "" and arg_27_1.actors_[var_30_3.prefab_name] ~= nil then
						local var_30_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_3.prefab_name].transform, "story_v_out_122152", "122152006", "story_v_out_122152.awb")

						arg_27_1:RecordAudio("122152006", var_30_9)
						arg_27_1:RecordAudio("122152006", var_30_9)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_122152", "122152006", "story_v_out_122152.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_122152", "122152006", "story_v_out_122152.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_10 and arg_27_1.time_ < var_30_0 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play122152007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 122152007
		arg_31_1.duration_ = 8.5

		local var_31_0 = {
			ja = 8.5,
			ko = 6.033,
			zh = 6.033
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
				arg_31_0:Play122152008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["10051ui_story"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect10051ui_story == nil then
				arg_31_1.var_.characterEffect10051ui_story = var_34_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 and not isNil(var_34_0) then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.characterEffect10051ui_story and not isNil(var_34_0) then
					local var_34_4 = Mathf.Lerp(0, 0.5, var_34_3)

					arg_31_1.var_.characterEffect10051ui_story.fillFlat = true
					arg_31_1.var_.characterEffect10051ui_story.fillRatio = var_34_4
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect10051ui_story then
				local var_34_5 = 0.5

				arg_31_1.var_.characterEffect10051ui_story.fillFlat = true
				arg_31_1.var_.characterEffect10051ui_story.fillRatio = var_34_5
			end

			local var_34_6 = arg_31_1.actors_["10037ui_story"]
			local var_34_7 = 0

			if var_34_7 < arg_31_1.time_ and arg_31_1.time_ <= var_34_7 + arg_34_0 and not isNil(var_34_6) and arg_31_1.var_.characterEffect10037ui_story == nil then
				arg_31_1.var_.characterEffect10037ui_story = var_34_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_8 = 0.200000002980232

			if var_34_7 <= arg_31_1.time_ and arg_31_1.time_ < var_34_7 + var_34_8 and not isNil(var_34_6) then
				local var_34_9 = (arg_31_1.time_ - var_34_7) / var_34_8

				if arg_31_1.var_.characterEffect10037ui_story and not isNil(var_34_6) then
					arg_31_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_7 + var_34_8 and arg_31_1.time_ < var_34_7 + var_34_8 + arg_34_0 and not isNil(var_34_6) and arg_31_1.var_.characterEffect10037ui_story then
				arg_31_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_34_10 = 0
			local var_34_11 = 0.475

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_12 = arg_31_1:FormatText(StoryNameCfg[383].name)

				arg_31_1.leftNameTxt_.text = var_34_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_13 = arg_31_1:GetWordFromCfg(122152007)
				local var_34_14 = arg_31_1:FormatText(var_34_13.content)

				arg_31_1.text_.text = var_34_14

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_15 = 19
				local var_34_16 = utf8.len(var_34_14)
				local var_34_17 = var_34_15 <= 0 and var_34_11 or var_34_11 * (var_34_16 / var_34_15)

				if var_34_17 > 0 and var_34_11 < var_34_17 then
					arg_31_1.talkMaxDuration = var_34_17

					if var_34_17 + var_34_10 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_17 + var_34_10
					end
				end

				arg_31_1.text_.text = var_34_14
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152007", "story_v_out_122152.awb") ~= 0 then
					local var_34_18 = manager.audio:GetVoiceLength("story_v_out_122152", "122152007", "story_v_out_122152.awb") / 1000

					if var_34_18 + var_34_10 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_18 + var_34_10
					end

					if var_34_13.prefab_name ~= "" and arg_31_1.actors_[var_34_13.prefab_name] ~= nil then
						local var_34_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_13.prefab_name].transform, "story_v_out_122152", "122152007", "story_v_out_122152.awb")

						arg_31_1:RecordAudio("122152007", var_34_19)
						arg_31_1:RecordAudio("122152007", var_34_19)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_122152", "122152007", "story_v_out_122152.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_122152", "122152007", "story_v_out_122152.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_20 = math.max(var_34_11, arg_31_1.talkMaxDuration)

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_20 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_10) / var_34_20

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_10 + var_34_20 and arg_31_1.time_ < var_34_10 + var_34_20 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play122152008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 122152008
		arg_35_1.duration_ = 1.43

		local var_35_0 = {
			ja = 1.333,
			ko = 1.433,
			zh = 1.433
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
				arg_35_0:Play122152009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["10051ui_story"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect10051ui_story == nil then
				arg_35_1.var_.characterEffect10051ui_story = var_38_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.characterEffect10051ui_story and not isNil(var_38_0) then
					arg_35_1.var_.characterEffect10051ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect10051ui_story then
				arg_35_1.var_.characterEffect10051ui_story.fillFlat = false
			end

			local var_38_4 = arg_35_1.actors_["10037ui_story"]
			local var_38_5 = 0

			if var_38_5 < arg_35_1.time_ and arg_35_1.time_ <= var_38_5 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect10037ui_story == nil then
				arg_35_1.var_.characterEffect10037ui_story = var_38_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_6 = 0.200000002980232

			if var_38_5 <= arg_35_1.time_ and arg_35_1.time_ < var_38_5 + var_38_6 and not isNil(var_38_4) then
				local var_38_7 = (arg_35_1.time_ - var_38_5) / var_38_6

				if arg_35_1.var_.characterEffect10037ui_story and not isNil(var_38_4) then
					local var_38_8 = Mathf.Lerp(0, 0.5, var_38_7)

					arg_35_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_35_1.var_.characterEffect10037ui_story.fillRatio = var_38_8
				end
			end

			if arg_35_1.time_ >= var_38_5 + var_38_6 and arg_35_1.time_ < var_38_5 + var_38_6 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect10037ui_story then
				local var_38_9 = 0.5

				arg_35_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_35_1.var_.characterEffect10037ui_story.fillRatio = var_38_9
			end

			local var_38_10 = 0
			local var_38_11 = 0.05

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_12 = arg_35_1:FormatText(StoryNameCfg[6].name)

				arg_35_1.leftNameTxt_.text = var_38_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_13 = arg_35_1:GetWordFromCfg(122152008)
				local var_38_14 = arg_35_1:FormatText(var_38_13.content)

				arg_35_1.text_.text = var_38_14

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_15 = 2
				local var_38_16 = utf8.len(var_38_14)
				local var_38_17 = var_38_15 <= 0 and var_38_11 or var_38_11 * (var_38_16 / var_38_15)

				if var_38_17 > 0 and var_38_11 < var_38_17 then
					arg_35_1.talkMaxDuration = var_38_17

					if var_38_17 + var_38_10 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_17 + var_38_10
					end
				end

				arg_35_1.text_.text = var_38_14
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152008", "story_v_out_122152.awb") ~= 0 then
					local var_38_18 = manager.audio:GetVoiceLength("story_v_out_122152", "122152008", "story_v_out_122152.awb") / 1000

					if var_38_18 + var_38_10 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_18 + var_38_10
					end

					if var_38_13.prefab_name ~= "" and arg_35_1.actors_[var_38_13.prefab_name] ~= nil then
						local var_38_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_13.prefab_name].transform, "story_v_out_122152", "122152008", "story_v_out_122152.awb")

						arg_35_1:RecordAudio("122152008", var_38_19)
						arg_35_1:RecordAudio("122152008", var_38_19)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_122152", "122152008", "story_v_out_122152.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_122152", "122152008", "story_v_out_122152.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_20 = math.max(var_38_11, arg_35_1.talkMaxDuration)

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_20 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_10) / var_38_20

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_10 + var_38_20 and arg_35_1.time_ < var_38_10 + var_38_20 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play122152009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 122152009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play122152010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["10051ui_story"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect10051ui_story == nil then
				arg_39_1.var_.characterEffect10051ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.characterEffect10051ui_story and not isNil(var_42_0) then
					local var_42_4 = Mathf.Lerp(0, 0.5, var_42_3)

					arg_39_1.var_.characterEffect10051ui_story.fillFlat = true
					arg_39_1.var_.characterEffect10051ui_story.fillRatio = var_42_4
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect10051ui_story then
				local var_42_5 = 0.5

				arg_39_1.var_.characterEffect10051ui_story.fillFlat = true
				arg_39_1.var_.characterEffect10051ui_story.fillRatio = var_42_5
			end

			local var_42_6 = 0
			local var_42_7 = 1

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				local var_42_8 = "play"
				local var_42_9 = "effect"

				arg_39_1:AudioAction(var_42_8, var_42_9, "se_story_121_04", "se_story_121_04_earthquake_loop", "")
			end

			local var_42_10 = 0
			local var_42_11 = 1

			if var_42_10 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 then
				local var_42_12 = "play"
				local var_42_13 = "effect"

				arg_39_1:AudioAction(var_42_12, var_42_13, "se_story_122_01", "se_story_122_01_buildinghit03", "")
			end

			local var_42_14 = 0
			local var_42_15 = 0.975

			if var_42_14 < arg_39_1.time_ and arg_39_1.time_ <= var_42_14 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_16 = arg_39_1:GetWordFromCfg(122152009)
				local var_42_17 = arg_39_1:FormatText(var_42_16.content)

				arg_39_1.text_.text = var_42_17

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_18 = 39
				local var_42_19 = utf8.len(var_42_17)
				local var_42_20 = var_42_18 <= 0 and var_42_15 or var_42_15 * (var_42_19 / var_42_18)

				if var_42_20 > 0 and var_42_15 < var_42_20 then
					arg_39_1.talkMaxDuration = var_42_20

					if var_42_20 + var_42_14 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_20 + var_42_14
					end
				end

				arg_39_1.text_.text = var_42_17
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_21 = math.max(var_42_15, arg_39_1.talkMaxDuration)

			if var_42_14 <= arg_39_1.time_ and arg_39_1.time_ < var_42_14 + var_42_21 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_14) / var_42_21

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_14 + var_42_21 and arg_39_1.time_ < var_42_14 + var_42_21 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play122152010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 122152010
		arg_43_1.duration_ = 7

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play122152011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = "ST49"

			if arg_43_1.bgs_[var_46_0] == nil then
				local var_46_1 = Object.Instantiate(arg_43_1.paintGo_)

				var_46_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_46_0)
				var_46_1.name = var_46_0
				var_46_1.transform.parent = arg_43_1.stage_.transform
				var_46_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.bgs_[var_46_0] = var_46_1
			end

			local var_46_2 = 0

			if var_46_2 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				local var_46_3 = manager.ui.mainCamera.transform.localPosition
				local var_46_4 = Vector3.New(0, 0, 10) + Vector3.New(var_46_3.x, var_46_3.y, 0)
				local var_46_5 = arg_43_1.bgs_.ST49

				var_46_5.transform.localPosition = var_46_4
				var_46_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_6 = var_46_5:GetComponent("SpriteRenderer")

				if var_46_6 and var_46_6.sprite then
					local var_46_7 = (var_46_5.transform.localPosition - var_46_3).z
					local var_46_8 = manager.ui.mainCameraCom_
					local var_46_9 = 2 * var_46_7 * Mathf.Tan(var_46_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_46_10 = var_46_9 * var_46_8.aspect
					local var_46_11 = var_46_6.sprite.bounds.size.x
					local var_46_12 = var_46_6.sprite.bounds.size.y
					local var_46_13 = var_46_10 / var_46_11
					local var_46_14 = var_46_9 / var_46_12
					local var_46_15 = var_46_14 < var_46_13 and var_46_13 or var_46_14

					var_46_5.transform.localScale = Vector3.New(var_46_15, var_46_15, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "ST49" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_16 = 0

			if var_46_16 < arg_43_1.time_ and arg_43_1.time_ <= var_46_16 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_17 = 2

			if var_46_16 <= arg_43_1.time_ and arg_43_1.time_ < var_46_16 + var_46_17 then
				local var_46_18 = (arg_43_1.time_ - var_46_16) / var_46_17
				local var_46_19 = Color.New(1, 1, 1)

				var_46_19.a = Mathf.Lerp(1, 0, var_46_18)
				arg_43_1.mask_.color = var_46_19
			end

			if arg_43_1.time_ >= var_46_16 + var_46_17 and arg_43_1.time_ < var_46_16 + var_46_17 + arg_46_0 then
				local var_46_20 = Color.New(1, 1, 1)
				local var_46_21 = 0

				arg_43_1.mask_.enabled = false
				var_46_20.a = var_46_21
				arg_43_1.mask_.color = var_46_20
			end

			local var_46_22 = arg_43_1.actors_["10051ui_story"].transform
			local var_46_23 = 0

			if var_46_23 < arg_43_1.time_ and arg_43_1.time_ <= var_46_23 + arg_46_0 then
				arg_43_1.var_.moveOldPos10051ui_story = var_46_22.localPosition
			end

			local var_46_24 = 0.001

			if var_46_23 <= arg_43_1.time_ and arg_43_1.time_ < var_46_23 + var_46_24 then
				local var_46_25 = (arg_43_1.time_ - var_46_23) / var_46_24
				local var_46_26 = Vector3.New(0, 100, 0)

				var_46_22.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10051ui_story, var_46_26, var_46_25)

				local var_46_27 = manager.ui.mainCamera.transform.position - var_46_22.position

				var_46_22.forward = Vector3.New(var_46_27.x, var_46_27.y, var_46_27.z)

				local var_46_28 = var_46_22.localEulerAngles

				var_46_28.z = 0
				var_46_28.x = 0
				var_46_22.localEulerAngles = var_46_28
			end

			if arg_43_1.time_ >= var_46_23 + var_46_24 and arg_43_1.time_ < var_46_23 + var_46_24 + arg_46_0 then
				var_46_22.localPosition = Vector3.New(0, 100, 0)

				local var_46_29 = manager.ui.mainCamera.transform.position - var_46_22.position

				var_46_22.forward = Vector3.New(var_46_29.x, var_46_29.y, var_46_29.z)

				local var_46_30 = var_46_22.localEulerAngles

				var_46_30.z = 0
				var_46_30.x = 0
				var_46_22.localEulerAngles = var_46_30
			end

			local var_46_31 = arg_43_1.actors_["10037ui_story"].transform
			local var_46_32 = 0

			if var_46_32 < arg_43_1.time_ and arg_43_1.time_ <= var_46_32 + arg_46_0 then
				arg_43_1.var_.moveOldPos10037ui_story = var_46_31.localPosition
			end

			local var_46_33 = 0.001

			if var_46_32 <= arg_43_1.time_ and arg_43_1.time_ < var_46_32 + var_46_33 then
				local var_46_34 = (arg_43_1.time_ - var_46_32) / var_46_33
				local var_46_35 = Vector3.New(0, 100, 0)

				var_46_31.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10037ui_story, var_46_35, var_46_34)

				local var_46_36 = manager.ui.mainCamera.transform.position - var_46_31.position

				var_46_31.forward = Vector3.New(var_46_36.x, var_46_36.y, var_46_36.z)

				local var_46_37 = var_46_31.localEulerAngles

				var_46_37.z = 0
				var_46_37.x = 0
				var_46_31.localEulerAngles = var_46_37
			end

			if arg_43_1.time_ >= var_46_32 + var_46_33 and arg_43_1.time_ < var_46_32 + var_46_33 + arg_46_0 then
				var_46_31.localPosition = Vector3.New(0, 100, 0)

				local var_46_38 = manager.ui.mainCamera.transform.position - var_46_31.position

				var_46_31.forward = Vector3.New(var_46_38.x, var_46_38.y, var_46_38.z)

				local var_46_39 = var_46_31.localEulerAngles

				var_46_39.z = 0
				var_46_39.x = 0
				var_46_31.localEulerAngles = var_46_39
			end

			local var_46_40 = arg_43_1.bgs_.ST49.transform
			local var_46_41 = 0

			if var_46_41 < arg_43_1.time_ and arg_43_1.time_ <= var_46_41 + arg_46_0 then
				arg_43_1.var_.moveOldPosST49 = var_46_40.localPosition
			end

			local var_46_42 = 4.5

			if var_46_41 <= arg_43_1.time_ and arg_43_1.time_ < var_46_41 + var_46_42 then
				local var_46_43 = (arg_43_1.time_ - var_46_41) / var_46_42
				local var_46_44 = Vector3.New(0, 1, 9.5)

				var_46_40.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPosST49, var_46_44, var_46_43)
			end

			if arg_43_1.time_ >= var_46_41 + var_46_42 and arg_43_1.time_ < var_46_41 + var_46_42 + arg_46_0 then
				var_46_40.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_46_45 = 2

			if var_46_45 < arg_43_1.time_ and arg_43_1.time_ <= var_46_45 + arg_46_0 then
				arg_43_1.allBtn_.enabled = false
			end

			local var_46_46 = 2.5

			if arg_43_1.time_ >= var_46_45 + var_46_46 and arg_43_1.time_ < var_46_45 + var_46_46 + arg_46_0 then
				arg_43_1.allBtn_.enabled = true
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_47 = 2
			local var_46_48 = 1.325

			if var_46_47 < arg_43_1.time_ and arg_43_1.time_ <= var_46_47 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_49 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_49:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_50 = arg_43_1:GetWordFromCfg(122152010)
				local var_46_51 = arg_43_1:FormatText(var_46_50.content)

				arg_43_1.text_.text = var_46_51

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_52 = 53
				local var_46_53 = utf8.len(var_46_51)
				local var_46_54 = var_46_52 <= 0 and var_46_48 or var_46_48 * (var_46_53 / var_46_52)

				if var_46_54 > 0 and var_46_48 < var_46_54 then
					arg_43_1.talkMaxDuration = var_46_54
					var_46_47 = var_46_47 + 0.3

					if var_46_54 + var_46_47 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_54 + var_46_47
					end
				end

				arg_43_1.text_.text = var_46_51
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_55 = var_46_47 + 0.3
			local var_46_56 = math.max(var_46_48, arg_43_1.talkMaxDuration)

			if var_46_55 <= arg_43_1.time_ and arg_43_1.time_ < var_46_55 + var_46_56 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_55) / var_46_56

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_55 + var_46_56 and arg_43_1.time_ < var_46_55 + var_46_56 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10051ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ST49",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play122152011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 122152011
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play122152012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 1.7

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(122152011)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 68
				local var_52_5 = utf8.len(var_52_3)
				local var_52_6 = var_52_4 <= 0 and var_52_1 or var_52_1 * (var_52_5 / var_52_4)

				if var_52_6 > 0 and var_52_1 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_7 and arg_49_1.time_ < var_52_0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play122152012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 122152012
		arg_53_1.duration_ = 4.7

		local var_53_0 = {
			ja = 4.7,
			ko = 2.566,
			zh = 2.566
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
				arg_53_0:Play122152013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10037ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10037ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, 100, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10037ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, 100, 0)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["10051ui_story"].transform
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1.var_.moveOldPos10051ui_story = var_56_9.localPosition

				local var_56_11 = "10051ui_story"

				arg_53_1:ShowWeapon(arg_53_1.var_[var_56_11 .. "Animator"].transform, false)
			end

			local var_56_12 = 0.001

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_12 then
				local var_56_13 = (arg_53_1.time_ - var_56_10) / var_56_12
				local var_56_14 = Vector3.New(0, 100, 0)

				var_56_9.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10051ui_story, var_56_14, var_56_13)

				local var_56_15 = manager.ui.mainCamera.transform.position - var_56_9.position

				var_56_9.forward = Vector3.New(var_56_15.x, var_56_15.y, var_56_15.z)

				local var_56_16 = var_56_9.localEulerAngles

				var_56_16.z = 0
				var_56_16.x = 0
				var_56_9.localEulerAngles = var_56_16
			end

			if arg_53_1.time_ >= var_56_10 + var_56_12 and arg_53_1.time_ < var_56_10 + var_56_12 + arg_56_0 then
				var_56_9.localPosition = Vector3.New(0, 100, 0)

				local var_56_17 = manager.ui.mainCamera.transform.position - var_56_9.position

				var_56_9.forward = Vector3.New(var_56_17.x, var_56_17.y, var_56_17.z)

				local var_56_18 = var_56_9.localEulerAngles

				var_56_18.z = 0
				var_56_18.x = 0
				var_56_9.localEulerAngles = var_56_18
			end

			local var_56_19 = 0

			if var_56_19 < arg_53_1.time_ and arg_53_1.time_ <= var_56_19 + arg_56_0 then
				arg_53_1:PlayTimeline("10051ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_56_20 = 0
			local var_56_21 = 1

			if var_56_20 < arg_53_1.time_ and arg_53_1.time_ <= var_56_20 + arg_56_0 then
				local var_56_22 = "stop"
				local var_56_23 = "effect"

				arg_53_1:AudioAction(var_56_22, var_56_23, "se_story_121_04", "se_story_121_04_earthquake_loop", "")
			end

			local var_56_24 = 0
			local var_56_25 = 0.3

			if var_56_24 < arg_53_1.time_ and arg_53_1.time_ <= var_56_24 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_26 = arg_53_1:FormatText(StoryNameCfg[383].name)

				arg_53_1.leftNameTxt_.text = var_56_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10037")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_27 = arg_53_1:GetWordFromCfg(122152012)
				local var_56_28 = arg_53_1:FormatText(var_56_27.content)

				arg_53_1.text_.text = var_56_28

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_29 = 12
				local var_56_30 = utf8.len(var_56_28)
				local var_56_31 = var_56_29 <= 0 and var_56_25 or var_56_25 * (var_56_30 / var_56_29)

				if var_56_31 > 0 and var_56_25 < var_56_31 then
					arg_53_1.talkMaxDuration = var_56_31

					if var_56_31 + var_56_24 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_31 + var_56_24
					end
				end

				arg_53_1.text_.text = var_56_28
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152012", "story_v_out_122152.awb") ~= 0 then
					local var_56_32 = manager.audio:GetVoiceLength("story_v_out_122152", "122152012", "story_v_out_122152.awb") / 1000

					if var_56_32 + var_56_24 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_32 + var_56_24
					end

					if var_56_27.prefab_name ~= "" and arg_53_1.actors_[var_56_27.prefab_name] ~= nil then
						local var_56_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_27.prefab_name].transform, "story_v_out_122152", "122152012", "story_v_out_122152.awb")

						arg_53_1:RecordAudio("122152012", var_56_33)
						arg_53_1:RecordAudio("122152012", var_56_33)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_122152", "122152012", "story_v_out_122152.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_122152", "122152012", "story_v_out_122152.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_34 = math.max(var_56_25, arg_53_1.talkMaxDuration)

			if var_56_24 <= arg_53_1.time_ and arg_53_1.time_ < var_56_24 + var_56_34 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_24) / var_56_34

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_24 + var_56_34 and arg_53_1.time_ < var_56_24 + var_56_34 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10051ui_story",
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
	Play122152013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 122152013
		arg_57_1.duration_ = 4.6

		local var_57_0 = {
			ja = 4.6,
			ko = 3.133,
			zh = 3.133
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
				arg_57_0:Play122152014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.275

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[6].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10051")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(122152013)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152013", "story_v_out_122152.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_122152", "122152013", "story_v_out_122152.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_122152", "122152013", "story_v_out_122152.awb")

						arg_57_1:RecordAudio("122152013", var_60_9)
						arg_57_1:RecordAudio("122152013", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_122152", "122152013", "story_v_out_122152.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_122152", "122152013", "story_v_out_122152.awb")
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
	Play122152014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 122152014
		arg_61_1.duration_ = 14.17

		local var_61_0 = {
			ja = 14.166,
			ko = 12.3,
			zh = 12.3
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
				arg_61_0:Play122152015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1.15

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[383].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10037")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(122152014)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 46
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152014", "story_v_out_122152.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_122152", "122152014", "story_v_out_122152.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_122152", "122152014", "story_v_out_122152.awb")

						arg_61_1:RecordAudio("122152014", var_64_9)
						arg_61_1:RecordAudio("122152014", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_122152", "122152014", "story_v_out_122152.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_122152", "122152014", "story_v_out_122152.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play122152015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 122152015
		arg_65_1.duration_ = 12.23

		local var_65_0 = {
			ja = 10.833,
			ko = 12.233,
			zh = 12.233
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
				arg_65_0:Play122152016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.95

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[383].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10037")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(122152015)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152015", "story_v_out_122152.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_122152", "122152015", "story_v_out_122152.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_122152", "122152015", "story_v_out_122152.awb")

						arg_65_1:RecordAudio("122152015", var_68_9)
						arg_65_1:RecordAudio("122152015", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_122152", "122152015", "story_v_out_122152.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_122152", "122152015", "story_v_out_122152.awb")
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
	Play122152016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 122152016
		arg_69_1.duration_ = 6.5

		local var_69_0 = {
			ja = 6.5,
			ko = 6.3,
			zh = 6.3
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
				arg_69_0:Play122152017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.5

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[383].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10037")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(122152016)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 20
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152016", "story_v_out_122152.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_122152", "122152016", "story_v_out_122152.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_122152", "122152016", "story_v_out_122152.awb")

						arg_69_1:RecordAudio("122152016", var_72_9)
						arg_69_1:RecordAudio("122152016", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_122152", "122152016", "story_v_out_122152.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_122152", "122152016", "story_v_out_122152.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play122152017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 122152017
		arg_73_1.duration_ = 7.8

		local var_73_0 = {
			ja = 4.533,
			ko = 7.8,
			zh = 7.8
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
				arg_73_0:Play122152018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.7

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[383].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10037")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(122152017)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 28
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152017", "story_v_out_122152.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_122152", "122152017", "story_v_out_122152.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_122152", "122152017", "story_v_out_122152.awb")

						arg_73_1:RecordAudio("122152017", var_76_9)
						arg_73_1:RecordAudio("122152017", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_122152", "122152017", "story_v_out_122152.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_122152", "122152017", "story_v_out_122152.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play122152018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 122152018
		arg_77_1.duration_ = 11

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play122152019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = "J12g"

			if arg_77_1.bgs_[var_80_0] == nil then
				local var_80_1 = Object.Instantiate(arg_77_1.paintGo_)

				var_80_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_80_0)
				var_80_1.name = var_80_0
				var_80_1.transform.parent = arg_77_1.stage_.transform
				var_80_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.bgs_[var_80_0] = var_80_1
			end

			local var_80_2 = 3

			if var_80_2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				local var_80_3 = manager.ui.mainCamera.transform.localPosition
				local var_80_4 = Vector3.New(0, 0, 10) + Vector3.New(var_80_3.x, var_80_3.y, 0)
				local var_80_5 = arg_77_1.bgs_.J12g

				var_80_5.transform.localPosition = var_80_4
				var_80_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_6 = var_80_5:GetComponent("SpriteRenderer")

				if var_80_6 and var_80_6.sprite then
					local var_80_7 = (var_80_5.transform.localPosition - var_80_3).z
					local var_80_8 = manager.ui.mainCameraCom_
					local var_80_9 = 2 * var_80_7 * Mathf.Tan(var_80_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_80_10 = var_80_9 * var_80_8.aspect
					local var_80_11 = var_80_6.sprite.bounds.size.x
					local var_80_12 = var_80_6.sprite.bounds.size.y
					local var_80_13 = var_80_10 / var_80_11
					local var_80_14 = var_80_9 / var_80_12
					local var_80_15 = var_80_14 < var_80_13 and var_80_13 or var_80_14

					var_80_5.transform.localScale = Vector3.New(var_80_15, var_80_15, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "J12g" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_17 = 3

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 then
				local var_80_18 = (arg_77_1.time_ - var_80_16) / var_80_17
				local var_80_19 = Color.New(0, 0, 0)

				var_80_19.a = Mathf.Lerp(0, 1, var_80_18)
				arg_77_1.mask_.color = var_80_19
			end

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 then
				local var_80_20 = Color.New(0, 0, 0)

				var_80_20.a = 1
				arg_77_1.mask_.color = var_80_20
			end

			local var_80_21 = 3

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_22 = 3

			if var_80_21 <= arg_77_1.time_ and arg_77_1.time_ < var_80_21 + var_80_22 then
				local var_80_23 = (arg_77_1.time_ - var_80_21) / var_80_22
				local var_80_24 = Color.New(0, 0, 0)

				var_80_24.a = Mathf.Lerp(1, 0, var_80_23)
				arg_77_1.mask_.color = var_80_24
			end

			if arg_77_1.time_ >= var_80_21 + var_80_22 and arg_77_1.time_ < var_80_21 + var_80_22 + arg_80_0 then
				local var_80_25 = Color.New(0, 0, 0)
				local var_80_26 = 0

				arg_77_1.mask_.enabled = false
				var_80_25.a = var_80_26
				arg_77_1.mask_.color = var_80_25
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_27 = 6
			local var_80_28 = 1.55

			if var_80_27 < arg_77_1.time_ and arg_77_1.time_ <= var_80_27 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_29 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_29:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_30 = arg_77_1:GetWordFromCfg(122152018)
				local var_80_31 = arg_77_1:FormatText(var_80_30.content)

				arg_77_1.text_.text = var_80_31

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_32 = 62
				local var_80_33 = utf8.len(var_80_31)
				local var_80_34 = var_80_32 <= 0 and var_80_28 or var_80_28 * (var_80_33 / var_80_32)

				if var_80_34 > 0 and var_80_28 < var_80_34 then
					arg_77_1.talkMaxDuration = var_80_34
					var_80_27 = var_80_27 + 0.3

					if var_80_34 + var_80_27 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_34 + var_80_27
					end
				end

				arg_77_1.text_.text = var_80_31
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_35 = var_80_27 + 0.3
			local var_80_36 = math.max(var_80_28, arg_77_1.talkMaxDuration)

			if var_80_35 <= arg_77_1.time_ and arg_77_1.time_ < var_80_35 + var_80_36 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_35) / var_80_36

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_35 + var_80_36 and arg_77_1.time_ < var_80_35 + var_80_36 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play122152019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 122152019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play122152020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 1.65

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_2 = arg_83_1:GetWordFromCfg(122152019)
				local var_86_3 = arg_83_1:FormatText(var_86_2.content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 66
				local var_86_5 = utf8.len(var_86_3)
				local var_86_6 = var_86_4 <= 0 and var_86_1 or var_86_1 * (var_86_5 / var_86_4)

				if var_86_6 > 0 and var_86_1 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_7 and arg_83_1.time_ < var_86_0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play122152020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 122152020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play122152021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.35

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[7].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:GetWordFromCfg(122152020)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 14
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_8 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_8 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_8

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_8 and arg_87_1.time_ < var_90_0 + var_90_8 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play122152021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 122152021
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play122152022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 1.425

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_2 = arg_91_1:GetWordFromCfg(122152021)
				local var_94_3 = arg_91_1:FormatText(var_94_2.content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 57
				local var_94_5 = utf8.len(var_94_3)
				local var_94_6 = var_94_4 <= 0 and var_94_1 or var_94_1 * (var_94_5 / var_94_4)

				if var_94_6 > 0 and var_94_1 < var_94_6 then
					arg_91_1.talkMaxDuration = var_94_6

					if var_94_6 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_7 and arg_91_1.time_ < var_94_0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play122152022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 122152022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play122152023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 1.2

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_2 = arg_95_1:GetWordFromCfg(122152022)
				local var_98_3 = arg_95_1:FormatText(var_98_2.content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 48
				local var_98_5 = utf8.len(var_98_3)
				local var_98_6 = var_98_4 <= 0 and var_98_1 or var_98_1 * (var_98_5 / var_98_4)

				if var_98_6 > 0 and var_98_1 < var_98_6 then
					arg_95_1.talkMaxDuration = var_98_6

					if var_98_6 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_7 and arg_95_1.time_ < var_98_0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play122152023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 122152023
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play122152024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.4

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[7].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_3 = arg_99_1:GetWordFromCfg(122152023)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 16
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
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_8 and arg_99_1.time_ < var_102_0 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play122152024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 122152024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play122152025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.425

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[7].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_3 = arg_103_1:GetWordFromCfg(122152024)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 17
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_8 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_8 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_8

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_8 and arg_103_1.time_ < var_106_0 + var_106_8 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play122152025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 122152025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play122152026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 1.05

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_2 = arg_107_1:GetWordFromCfg(122152025)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 42
				local var_110_5 = utf8.len(var_110_3)
				local var_110_6 = var_110_4 <= 0 and var_110_1 or var_110_1 * (var_110_5 / var_110_4)

				if var_110_6 > 0 and var_110_1 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_7 and arg_107_1.time_ < var_110_0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play122152026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 122152026
		arg_111_1.duration_ = 7.53

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play122152027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_1 = 2

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_1 then
				local var_114_2 = (arg_111_1.time_ - var_114_0) / var_114_1
				local var_114_3 = Color.New(1, 1, 1)

				var_114_3.a = Mathf.Lerp(1, 0, var_114_2)
				arg_111_1.mask_.color = var_114_3
			end

			if arg_111_1.time_ >= var_114_0 + var_114_1 and arg_111_1.time_ < var_114_0 + var_114_1 + arg_114_0 then
				local var_114_4 = Color.New(1, 1, 1)
				local var_114_5 = 0

				arg_111_1.mask_.enabled = false
				var_114_4.a = var_114_5
				arg_111_1.mask_.color = var_114_4
			end

			local var_114_6 = manager.ui.mainCamera.transform
			local var_114_7 = 2.3

			if var_114_7 < arg_111_1.time_ and arg_111_1.time_ <= var_114_7 + arg_114_0 then
				arg_111_1.var_.shakeOldPos = var_114_6.localPosition
			end

			local var_114_8 = 1

			if var_114_7 <= arg_111_1.time_ and arg_111_1.time_ < var_114_7 + var_114_8 then
				local var_114_9 = (arg_111_1.time_ - var_114_7) / 0.066
				local var_114_10, var_114_11 = math.modf(var_114_9)

				var_114_6.localPosition = Vector3.New(var_114_11 * 0.13, var_114_11 * 0.13, var_114_11 * 0.13) + arg_111_1.var_.shakeOldPos
			end

			if arg_111_1.time_ >= var_114_7 + var_114_8 and arg_111_1.time_ < var_114_7 + var_114_8 + arg_114_0 then
				var_114_6.localPosition = arg_111_1.var_.shakeOldPos
			end

			local var_114_12 = 2

			if var_114_12 < arg_111_1.time_ and arg_111_1.time_ <= var_114_12 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			local var_114_13 = 1.3

			if arg_111_1.time_ >= var_114_12 + var_114_13 and arg_111_1.time_ < var_114_12 + var_114_13 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			local var_114_14 = 2.3
			local var_114_15 = 1

			if var_114_14 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 then
				local var_114_16 = "play"
				local var_114_17 = "effect"

				arg_111_1:AudioAction(var_114_16, var_114_17, "se_story_121_04", "se_story_121_04_bowhit1", "")
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_18 = 2.53333333333333
			local var_114_19 = 1.125

			if var_114_18 < arg_111_1.time_ and arg_111_1.time_ <= var_114_18 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_20 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_20:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_111_1.dialogCg_.alpha = arg_115_0
				end))
				var_114_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_21 = arg_111_1:GetWordFromCfg(122152026)
				local var_114_22 = arg_111_1:FormatText(var_114_21.content)

				arg_111_1.text_.text = var_114_22

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_23 = 45
				local var_114_24 = utf8.len(var_114_22)
				local var_114_25 = var_114_23 <= 0 and var_114_19 or var_114_19 * (var_114_24 / var_114_23)

				if var_114_25 > 0 and var_114_19 < var_114_25 then
					arg_111_1.talkMaxDuration = var_114_25
					var_114_18 = var_114_18 + 0.3

					if var_114_25 + var_114_18 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_25 + var_114_18
					end
				end

				arg_111_1.text_.text = var_114_22
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_26 = var_114_18 + 0.3
			local var_114_27 = math.max(var_114_19, arg_111_1.talkMaxDuration)

			if var_114_26 <= arg_111_1.time_ and arg_111_1.time_ < var_114_26 + var_114_27 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_26) / var_114_27

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_26 + var_114_27 and arg_111_1.time_ < var_114_26 + var_114_27 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play122152027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 122152027
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play122152028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.175

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[7].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:GetWordFromCfg(122152027)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 7
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_8 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_8 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_8

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_8 and arg_117_1.time_ < var_120_0 + var_120_8 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play122152028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 122152028
		arg_121_1.duration_ = 6.6

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play122152029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 1

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				local var_124_2 = "play"
				local var_124_3 = "effect"

				arg_121_1:AudioAction(var_124_2, var_124_3, "se_story_122_02", "se_story_122_02_punch", "")
			end

			local var_124_4 = manager.ui.mainCamera.transform
			local var_124_5 = 0

			if var_124_5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1.var_.shakeOldPos = var_124_4.localPosition
			end

			local var_124_6 = 1

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_6 then
				local var_124_7 = (arg_121_1.time_ - var_124_5) / 0.066
				local var_124_8, var_124_9 = math.modf(var_124_7)

				var_124_4.localPosition = Vector3.New(var_124_9 * 0.13, var_124_9 * 0.13, var_124_9 * 0.13) + arg_121_1.var_.shakeOldPos
			end

			if arg_121_1.time_ >= var_124_5 + var_124_6 and arg_121_1.time_ < var_124_5 + var_124_6 + arg_124_0 then
				var_124_4.localPosition = arg_121_1.var_.shakeOldPos
			end

			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 then
				arg_121_1.allBtn_.enabled = false
			end

			local var_124_11 = 2

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 then
				arg_121_1.allBtn_.enabled = true
			end

			local var_124_12 = "J12g_blur"

			if arg_121_1.bgs_[var_124_12] == nil then
				local var_124_13 = Object.Instantiate(arg_121_1.blurPaintGo_)
				local var_124_14 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_124_12)

				var_124_13:GetComponent("SpriteRenderer").sprite = var_124_14
				var_124_13.name = var_124_12
				var_124_13.transform.parent = arg_121_1.stage_.transform
				var_124_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.bgs_[var_124_12] = var_124_13
			end

			local var_124_15 = 0
			local var_124_16 = arg_121_1.bgs_[var_124_12]

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				local var_124_17 = manager.ui.mainCamera.transform.localPosition
				local var_124_18 = Vector3.New(0, 0, 10) + Vector3.New(var_124_17.x, var_124_17.y, 0)

				var_124_16.transform.localPosition = var_124_18
				var_124_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_124_19 = var_124_16:GetComponent("SpriteRenderer")

				if var_124_19 and var_124_19.sprite then
					local var_124_20 = (var_124_16.transform.localPosition - var_124_17).z
					local var_124_21 = manager.ui.mainCameraCom_
					local var_124_22 = 2 * var_124_20 * Mathf.Tan(var_124_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_124_23 = var_124_22 * var_124_21.aspect
					local var_124_24 = var_124_19.sprite.bounds.size.x
					local var_124_25 = var_124_19.sprite.bounds.size.y
					local var_124_26 = var_124_23 / var_124_24
					local var_124_27 = var_124_22 / var_124_25
					local var_124_28 = var_124_27 < var_124_26 and var_124_26 or var_124_27

					var_124_16.transform.localScale = Vector3.New(var_124_28, var_124_28, 0)
				end
			end

			local var_124_29 = 2

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_29 then
				local var_124_30 = (arg_121_1.time_ - var_124_15) / var_124_29
				local var_124_31 = Color.New(1, 1, 1)

				var_124_31.a = Mathf.Lerp(0, 1, var_124_30)

				var_124_16:GetComponent("SpriteRenderer").material:SetColor("_Color", var_124_31)
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_32 = 1.6
			local var_124_33 = 1

			if var_124_32 < arg_121_1.time_ and arg_121_1.time_ <= var_124_32 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_34 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_34:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_35 = arg_121_1:GetWordFromCfg(122152028)
				local var_124_36 = arg_121_1:FormatText(var_124_35.content)

				arg_121_1.text_.text = var_124_36

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_37 = 40
				local var_124_38 = utf8.len(var_124_36)
				local var_124_39 = var_124_37 <= 0 and var_124_33 or var_124_33 * (var_124_38 / var_124_37)

				if var_124_39 > 0 and var_124_33 < var_124_39 then
					arg_121_1.talkMaxDuration = var_124_39
					var_124_32 = var_124_32 + 0.3

					if var_124_39 + var_124_32 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_39 + var_124_32
					end
				end

				arg_121_1.text_.text = var_124_36
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_40 = var_124_32 + 0.3
			local var_124_41 = math.max(var_124_33, arg_121_1.talkMaxDuration)

			if var_124_40 <= arg_121_1.time_ and arg_121_1.time_ < var_124_40 + var_124_41 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_40) / var_124_41

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_40 + var_124_41 and arg_121_1.time_ < var_124_40 + var_124_41 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play122152029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 122152029
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play122152030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 1.325

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_2 = arg_127_1:GetWordFromCfg(122152029)
				local var_130_3 = arg_127_1:FormatText(var_130_2.content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 53
				local var_130_5 = utf8.len(var_130_3)
				local var_130_6 = var_130_4 <= 0 and var_130_1 or var_130_1 * (var_130_5 / var_130_4)

				if var_130_6 > 0 and var_130_1 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_7 and arg_127_1.time_ < var_130_0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play122152030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 122152030
		arg_131_1.duration_ = 7.8

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play122152031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_1 = 2

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_1 then
				local var_134_2 = (arg_131_1.time_ - var_134_0) / var_134_1
				local var_134_3 = Color.New(0, 0, 0)

				var_134_3.a = Mathf.Lerp(0, 1, var_134_2)
				arg_131_1.mask_.color = var_134_3
			end

			if arg_131_1.time_ >= var_134_0 + var_134_1 and arg_131_1.time_ < var_134_0 + var_134_1 + arg_134_0 then
				local var_134_4 = Color.New(0, 0, 0)

				var_134_4.a = 1
				arg_131_1.mask_.color = var_134_4
			end

			local var_134_5 = 2

			if var_134_5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_6 = 2

			if var_134_5 <= arg_131_1.time_ and arg_131_1.time_ < var_134_5 + var_134_6 then
				local var_134_7 = (arg_131_1.time_ - var_134_5) / var_134_6
				local var_134_8 = Color.New(0, 0, 0)

				var_134_8.a = Mathf.Lerp(1, 0, var_134_7)
				arg_131_1.mask_.color = var_134_8
			end

			if arg_131_1.time_ >= var_134_5 + var_134_6 and arg_131_1.time_ < var_134_5 + var_134_6 + arg_134_0 then
				local var_134_9 = Color.New(0, 0, 0)
				local var_134_10 = 0

				arg_131_1.mask_.enabled = false
				var_134_9.a = var_134_10
				arg_131_1.mask_.color = var_134_9
			end

			local var_134_11 = "STblack"

			if arg_131_1.bgs_[var_134_11] == nil then
				local var_134_12 = Object.Instantiate(arg_131_1.paintGo_)

				var_134_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_134_11)
				var_134_12.name = var_134_11
				var_134_12.transform.parent = arg_131_1.stage_.transform
				var_134_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.bgs_[var_134_11] = var_134_12
			end

			local var_134_13 = 2

			if var_134_13 < arg_131_1.time_ and arg_131_1.time_ <= var_134_13 + arg_134_0 then
				local var_134_14 = manager.ui.mainCamera.transform.localPosition
				local var_134_15 = Vector3.New(0, 0, 10) + Vector3.New(var_134_14.x, var_134_14.y, 0)
				local var_134_16 = arg_131_1.bgs_.STblack

				var_134_16.transform.localPosition = var_134_15
				var_134_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_134_17 = var_134_16:GetComponent("SpriteRenderer")

				if var_134_17 and var_134_17.sprite then
					local var_134_18 = (var_134_16.transform.localPosition - var_134_14).z
					local var_134_19 = manager.ui.mainCameraCom_
					local var_134_20 = 2 * var_134_18 * Mathf.Tan(var_134_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_134_21 = var_134_20 * var_134_19.aspect
					local var_134_22 = var_134_17.sprite.bounds.size.x
					local var_134_23 = var_134_17.sprite.bounds.size.y
					local var_134_24 = var_134_21 / var_134_22
					local var_134_25 = var_134_20 / var_134_23
					local var_134_26 = var_134_25 < var_134_24 and var_134_24 or var_134_25

					var_134_16.transform.localScale = Vector3.New(var_134_26, var_134_26, 0)
				end

				for iter_134_0, iter_134_1 in pairs(arg_131_1.bgs_) do
					if iter_134_0 ~= "STblack" then
						iter_134_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_131_1.frameCnt_ <= 1 then
				arg_131_1.dialog_:SetActive(false)
			end

			local var_134_27 = 2.8
			local var_134_28 = 1.2

			if var_134_27 < arg_131_1.time_ and arg_131_1.time_ <= var_134_27 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0

				arg_131_1.dialog_:SetActive(true)

				arg_131_1.dialogCg_.alpha = 0

				local var_134_29 = LeanTween.value(arg_131_1.dialog_, 0, 1, 0.3)

				var_134_29:setOnUpdate(LuaHelper.FloatAction(function(arg_135_0)
					arg_131_1.dialogCg_.alpha = arg_135_0
				end))
				var_134_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_131_1.dialog_)
					var_134_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_131_1.duration_ = arg_131_1.duration_ + 0.3

				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_30 = arg_131_1:GetWordFromCfg(122152030)
				local var_134_31 = arg_131_1:FormatText(var_134_30.content)

				arg_131_1.text_.text = var_134_31

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_32 = 48
				local var_134_33 = utf8.len(var_134_31)
				local var_134_34 = var_134_32 <= 0 and var_134_28 or var_134_28 * (var_134_33 / var_134_32)

				if var_134_34 > 0 and var_134_28 < var_134_34 then
					arg_131_1.talkMaxDuration = var_134_34
					var_134_27 = var_134_27 + 0.3

					if var_134_34 + var_134_27 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_34 + var_134_27
					end
				end

				arg_131_1.text_.text = var_134_31
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_35 = var_134_27 + 0.3
			local var_134_36 = math.max(var_134_28, arg_131_1.talkMaxDuration)

			if var_134_35 <= arg_131_1.time_ and arg_131_1.time_ < var_134_35 + var_134_36 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_35) / var_134_36

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_35 + var_134_36 and arg_131_1.time_ < var_134_35 + var_134_36 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play122152031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 122152031
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play122152032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.325

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:GetWordFromCfg(122152031)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 13
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play122152032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 122152032
		arg_141_1.duration_ = 7.17

		local var_141_0 = {
			ja = 7.133,
			ko = 7.166,
			zh = 7.166
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
				arg_141_0:Play122152033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 2

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				local var_144_1 = manager.ui.mainCamera.transform.localPosition
				local var_144_2 = Vector3.New(0, 0, 10) + Vector3.New(var_144_1.x, var_144_1.y, 0)
				local var_144_3 = arg_141_1.bgs_.J11

				var_144_3.transform.localPosition = var_144_2
				var_144_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_144_4 = var_144_3:GetComponent("SpriteRenderer")

				if var_144_4 and var_144_4.sprite then
					local var_144_5 = (var_144_3.transform.localPosition - var_144_1).z
					local var_144_6 = manager.ui.mainCameraCom_
					local var_144_7 = 2 * var_144_5 * Mathf.Tan(var_144_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_144_8 = var_144_7 * var_144_6.aspect
					local var_144_9 = var_144_4.sprite.bounds.size.x
					local var_144_10 = var_144_4.sprite.bounds.size.y
					local var_144_11 = var_144_8 / var_144_9
					local var_144_12 = var_144_7 / var_144_10
					local var_144_13 = var_144_12 < var_144_11 and var_144_11 or var_144_12

					var_144_3.transform.localScale = Vector3.New(var_144_13, var_144_13, 0)
				end

				for iter_144_0, iter_144_1 in pairs(arg_141_1.bgs_) do
					if iter_144_0 ~= "J11" then
						iter_144_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_144_14 = 0

			if var_144_14 < arg_141_1.time_ and arg_141_1.time_ <= var_144_14 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_15 = 2

			if var_144_14 <= arg_141_1.time_ and arg_141_1.time_ < var_144_14 + var_144_15 then
				local var_144_16 = (arg_141_1.time_ - var_144_14) / var_144_15
				local var_144_17 = Color.New(0, 0, 0)

				var_144_17.a = Mathf.Lerp(0, 1, var_144_16)
				arg_141_1.mask_.color = var_144_17
			end

			if arg_141_1.time_ >= var_144_14 + var_144_15 and arg_141_1.time_ < var_144_14 + var_144_15 + arg_144_0 then
				local var_144_18 = Color.New(0, 0, 0)

				var_144_18.a = 1
				arg_141_1.mask_.color = var_144_18
			end

			local var_144_19 = 2

			if var_144_19 < arg_141_1.time_ and arg_141_1.time_ <= var_144_19 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_20 = 2

			if var_144_19 <= arg_141_1.time_ and arg_141_1.time_ < var_144_19 + var_144_20 then
				local var_144_21 = (arg_141_1.time_ - var_144_19) / var_144_20
				local var_144_22 = Color.New(0, 0, 0)

				var_144_22.a = Mathf.Lerp(1, 0, var_144_21)
				arg_141_1.mask_.color = var_144_22
			end

			if arg_141_1.time_ >= var_144_19 + var_144_20 and arg_141_1.time_ < var_144_19 + var_144_20 + arg_144_0 then
				local var_144_23 = Color.New(0, 0, 0)
				local var_144_24 = 0

				arg_141_1.mask_.enabled = false
				var_144_23.a = var_144_24
				arg_141_1.mask_.color = var_144_23
			end

			local var_144_25 = arg_141_1.actors_["10051ui_story"].transform
			local var_144_26 = 3.8

			if var_144_26 < arg_141_1.time_ and arg_141_1.time_ <= var_144_26 + arg_144_0 then
				arg_141_1.var_.moveOldPos10051ui_story = var_144_25.localPosition
			end

			local var_144_27 = 0.001

			if var_144_26 <= arg_141_1.time_ and arg_141_1.time_ < var_144_26 + var_144_27 then
				local var_144_28 = (arg_141_1.time_ - var_144_26) / var_144_27
				local var_144_29 = Vector3.New(-0.7, -1.11, -5.6)

				var_144_25.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10051ui_story, var_144_29, var_144_28)

				local var_144_30 = manager.ui.mainCamera.transform.position - var_144_25.position

				var_144_25.forward = Vector3.New(var_144_30.x, var_144_30.y, var_144_30.z)

				local var_144_31 = var_144_25.localEulerAngles

				var_144_31.z = 0
				var_144_31.x = 0
				var_144_25.localEulerAngles = var_144_31
			end

			if arg_141_1.time_ >= var_144_26 + var_144_27 and arg_141_1.time_ < var_144_26 + var_144_27 + arg_144_0 then
				var_144_25.localPosition = Vector3.New(-0.7, -1.11, -5.6)

				local var_144_32 = manager.ui.mainCamera.transform.position - var_144_25.position

				var_144_25.forward = Vector3.New(var_144_32.x, var_144_32.y, var_144_32.z)

				local var_144_33 = var_144_25.localEulerAngles

				var_144_33.z = 0
				var_144_33.x = 0
				var_144_25.localEulerAngles = var_144_33
			end

			local var_144_34 = arg_141_1.actors_["10051ui_story"]
			local var_144_35 = 3.8

			if var_144_35 < arg_141_1.time_ and arg_141_1.time_ <= var_144_35 + arg_144_0 and not isNil(var_144_34) and arg_141_1.var_.characterEffect10051ui_story == nil then
				arg_141_1.var_.characterEffect10051ui_story = var_144_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_36 = 0.200000002980232

			if var_144_35 <= arg_141_1.time_ and arg_141_1.time_ < var_144_35 + var_144_36 and not isNil(var_144_34) then
				local var_144_37 = (arg_141_1.time_ - var_144_35) / var_144_36

				if arg_141_1.var_.characterEffect10051ui_story and not isNil(var_144_34) then
					arg_141_1.var_.characterEffect10051ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_35 + var_144_36 and arg_141_1.time_ < var_144_35 + var_144_36 + arg_144_0 and not isNil(var_144_34) and arg_141_1.var_.characterEffect10051ui_story then
				arg_141_1.var_.characterEffect10051ui_story.fillFlat = false
			end

			local var_144_38 = 3.8

			if var_144_38 < arg_141_1.time_ and arg_141_1.time_ <= var_144_38 + arg_144_0 then
				arg_141_1:PlayTimeline("10051ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_144_39 = 3.8

			if var_144_39 < arg_141_1.time_ and arg_141_1.time_ <= var_144_39 + arg_144_0 then
				arg_141_1:PlayTimeline("10051ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_40 = 4
			local var_144_41 = 0.225

			if var_144_40 < arg_141_1.time_ and arg_141_1.time_ <= var_144_40 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_42 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_42:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_43 = arg_141_1:FormatText(StoryNameCfg[6].name)

				arg_141_1.leftNameTxt_.text = var_144_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_44 = arg_141_1:GetWordFromCfg(122152032)
				local var_144_45 = arg_141_1:FormatText(var_144_44.content)

				arg_141_1.text_.text = var_144_45

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_46 = 9
				local var_144_47 = utf8.len(var_144_45)
				local var_144_48 = var_144_46 <= 0 and var_144_41 or var_144_41 * (var_144_47 / var_144_46)

				if var_144_48 > 0 and var_144_41 < var_144_48 then
					arg_141_1.talkMaxDuration = var_144_48
					var_144_40 = var_144_40 + 0.3

					if var_144_48 + var_144_40 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_48 + var_144_40
					end
				end

				arg_141_1.text_.text = var_144_45
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152032", "story_v_out_122152.awb") ~= 0 then
					local var_144_49 = manager.audio:GetVoiceLength("story_v_out_122152", "122152032", "story_v_out_122152.awb") / 1000

					if var_144_49 + var_144_40 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_49 + var_144_40
					end

					if var_144_44.prefab_name ~= "" and arg_141_1.actors_[var_144_44.prefab_name] ~= nil then
						local var_144_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_44.prefab_name].transform, "story_v_out_122152", "122152032", "story_v_out_122152.awb")

						arg_141_1:RecordAudio("122152032", var_144_50)
						arg_141_1:RecordAudio("122152032", var_144_50)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_122152", "122152032", "story_v_out_122152.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_122152", "122152032", "story_v_out_122152.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_51 = var_144_40 + 0.3
			local var_144_52 = math.max(var_144_41, arg_141_1.talkMaxDuration)

			if var_144_51 <= arg_141_1.time_ and arg_141_1.time_ < var_144_51 + var_144_52 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_51) / var_144_52

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_51 + var_144_52 and arg_141_1.time_ < var_144_51 + var_144_52 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10051ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play122152033 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 122152033
		arg_147_1.duration_ = 8.87

		local var_147_0 = {
			ja = 8.866,
			ko = 7.233,
			zh = 7.233
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
				arg_147_0:Play122152034(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10037ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos10037ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0.7, -1.13, -6.2)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10037ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0.7, -1.13, -6.2)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["10037ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect10037ui_story == nil then
				arg_147_1.var_.characterEffect10037ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect10037ui_story and not isNil(var_150_9) then
					arg_147_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect10037ui_story then
				arg_147_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			local var_150_14 = 0

			if var_150_14 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_15 = arg_147_1.actors_["10051ui_story"]
			local var_150_16 = 0

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 and not isNil(var_150_15) and arg_147_1.var_.characterEffect10051ui_story == nil then
				arg_147_1.var_.characterEffect10051ui_story = var_150_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_17 = 0.200000002980232

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_17 and not isNil(var_150_15) then
				local var_150_18 = (arg_147_1.time_ - var_150_16) / var_150_17

				if arg_147_1.var_.characterEffect10051ui_story and not isNil(var_150_15) then
					local var_150_19 = Mathf.Lerp(0, 0.5, var_150_18)

					arg_147_1.var_.characterEffect10051ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10051ui_story.fillRatio = var_150_19
				end
			end

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 and not isNil(var_150_15) and arg_147_1.var_.characterEffect10051ui_story then
				local var_150_20 = 0.5

				arg_147_1.var_.characterEffect10051ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10051ui_story.fillRatio = var_150_20
			end

			local var_150_21 = 0
			local var_150_22 = 0.6

			if var_150_21 < arg_147_1.time_ and arg_147_1.time_ <= var_150_21 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_23 = arg_147_1:FormatText(StoryNameCfg[383].name)

				arg_147_1.leftNameTxt_.text = var_150_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_24 = arg_147_1:GetWordFromCfg(122152033)
				local var_150_25 = arg_147_1:FormatText(var_150_24.content)

				arg_147_1.text_.text = var_150_25

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_26 = 24
				local var_150_27 = utf8.len(var_150_25)
				local var_150_28 = var_150_26 <= 0 and var_150_22 or var_150_22 * (var_150_27 / var_150_26)

				if var_150_28 > 0 and var_150_22 < var_150_28 then
					arg_147_1.talkMaxDuration = var_150_28

					if var_150_28 + var_150_21 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_28 + var_150_21
					end
				end

				arg_147_1.text_.text = var_150_25
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152033", "story_v_out_122152.awb") ~= 0 then
					local var_150_29 = manager.audio:GetVoiceLength("story_v_out_122152", "122152033", "story_v_out_122152.awb") / 1000

					if var_150_29 + var_150_21 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_29 + var_150_21
					end

					if var_150_24.prefab_name ~= "" and arg_147_1.actors_[var_150_24.prefab_name] ~= nil then
						local var_150_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_24.prefab_name].transform, "story_v_out_122152", "122152033", "story_v_out_122152.awb")

						arg_147_1:RecordAudio("122152033", var_150_30)
						arg_147_1:RecordAudio("122152033", var_150_30)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_122152", "122152033", "story_v_out_122152.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_122152", "122152033", "story_v_out_122152.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_31 = math.max(var_150_22, arg_147_1.talkMaxDuration)

			if var_150_21 <= arg_147_1.time_ and arg_147_1.time_ < var_150_21 + var_150_31 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_21) / var_150_31

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_21 + var_150_31 and arg_147_1.time_ < var_150_21 + var_150_31 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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
	Play122152034 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 122152034
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play122152035(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10037ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos10037ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(0, 100, 0)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10037ui_story, var_154_4, var_154_3)

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

			local var_154_9 = arg_151_1.actors_["10037ui_story"]
			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect10037ui_story == nil then
				arg_151_1.var_.characterEffect10037ui_story = var_154_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_11 = 0.200000002980232

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_11 and not isNil(var_154_9) then
				local var_154_12 = (arg_151_1.time_ - var_154_10) / var_154_11

				if arg_151_1.var_.characterEffect10037ui_story and not isNil(var_154_9) then
					local var_154_13 = Mathf.Lerp(0, 0.5, var_154_12)

					arg_151_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10037ui_story.fillRatio = var_154_13
				end
			end

			if arg_151_1.time_ >= var_154_10 + var_154_11 and arg_151_1.time_ < var_154_10 + var_154_11 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect10037ui_story then
				local var_154_14 = 0.5

				arg_151_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10037ui_story.fillRatio = var_154_14
			end

			local var_154_15 = arg_151_1.actors_["10051ui_story"].transform
			local var_154_16 = 0

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 then
				arg_151_1.var_.moveOldPos10051ui_story = var_154_15.localPosition
			end

			local var_154_17 = 0.001

			if var_154_16 <= arg_151_1.time_ and arg_151_1.time_ < var_154_16 + var_154_17 then
				local var_154_18 = (arg_151_1.time_ - var_154_16) / var_154_17
				local var_154_19 = Vector3.New(0, 100, 0)

				var_154_15.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10051ui_story, var_154_19, var_154_18)

				local var_154_20 = manager.ui.mainCamera.transform.position - var_154_15.position

				var_154_15.forward = Vector3.New(var_154_20.x, var_154_20.y, var_154_20.z)

				local var_154_21 = var_154_15.localEulerAngles

				var_154_21.z = 0
				var_154_21.x = 0
				var_154_15.localEulerAngles = var_154_21
			end

			if arg_151_1.time_ >= var_154_16 + var_154_17 and arg_151_1.time_ < var_154_16 + var_154_17 + arg_154_0 then
				var_154_15.localPosition = Vector3.New(0, 100, 0)

				local var_154_22 = manager.ui.mainCamera.transform.position - var_154_15.position

				var_154_15.forward = Vector3.New(var_154_22.x, var_154_22.y, var_154_22.z)

				local var_154_23 = var_154_15.localEulerAngles

				var_154_23.z = 0
				var_154_23.x = 0
				var_154_15.localEulerAngles = var_154_23
			end

			local var_154_24 = arg_151_1.actors_["10051ui_story"]
			local var_154_25 = 0

			if var_154_25 < arg_151_1.time_ and arg_151_1.time_ <= var_154_25 + arg_154_0 and not isNil(var_154_24) and arg_151_1.var_.characterEffect10051ui_story == nil then
				arg_151_1.var_.characterEffect10051ui_story = var_154_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_26 = 0.200000002980232

			if var_154_25 <= arg_151_1.time_ and arg_151_1.time_ < var_154_25 + var_154_26 and not isNil(var_154_24) then
				local var_154_27 = (arg_151_1.time_ - var_154_25) / var_154_26

				if arg_151_1.var_.characterEffect10051ui_story and not isNil(var_154_24) then
					local var_154_28 = Mathf.Lerp(0, 0.5, var_154_27)

					arg_151_1.var_.characterEffect10051ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10051ui_story.fillRatio = var_154_28
				end
			end

			if arg_151_1.time_ >= var_154_25 + var_154_26 and arg_151_1.time_ < var_154_25 + var_154_26 + arg_154_0 and not isNil(var_154_24) and arg_151_1.var_.characterEffect10051ui_story then
				local var_154_29 = 0.5

				arg_151_1.var_.characterEffect10051ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10051ui_story.fillRatio = var_154_29
			end

			local var_154_30 = 0
			local var_154_31 = 0.925

			if var_154_30 < arg_151_1.time_ and arg_151_1.time_ <= var_154_30 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_32 = arg_151_1:GetWordFromCfg(122152034)
				local var_154_33 = arg_151_1:FormatText(var_154_32.content)

				arg_151_1.text_.text = var_154_33

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_34 = 37
				local var_154_35 = utf8.len(var_154_33)
				local var_154_36 = var_154_34 <= 0 and var_154_31 or var_154_31 * (var_154_35 / var_154_34)

				if var_154_36 > 0 and var_154_31 < var_154_36 then
					arg_151_1.talkMaxDuration = var_154_36

					if var_154_36 + var_154_30 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_36 + var_154_30
					end
				end

				arg_151_1.text_.text = var_154_33
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_37 = math.max(var_154_31, arg_151_1.talkMaxDuration)

			if var_154_30 <= arg_151_1.time_ and arg_151_1.time_ < var_154_30 + var_154_37 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_30) / var_154_37

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_30 + var_154_37 and arg_151_1.time_ < var_154_30 + var_154_37 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10051ui_story",
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
	Play122152035 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 122152035
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play122152036(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.725

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_2 = arg_155_1:GetWordFromCfg(122152035)
				local var_158_3 = arg_155_1:FormatText(var_158_2.content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 29
				local var_158_5 = utf8.len(var_158_3)
				local var_158_6 = var_158_4 <= 0 and var_158_1 or var_158_1 * (var_158_5 / var_158_4)

				if var_158_6 > 0 and var_158_1 < var_158_6 then
					arg_155_1.talkMaxDuration = var_158_6

					if var_158_6 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_7 and arg_155_1.time_ < var_158_0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play122152036 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 122152036
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play122152037(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.75

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_2 = arg_159_1:GetWordFromCfg(122152036)
				local var_162_3 = arg_159_1:FormatText(var_162_2.content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 30
				local var_162_5 = utf8.len(var_162_3)
				local var_162_6 = var_162_4 <= 0 and var_162_1 or var_162_1 * (var_162_5 / var_162_4)

				if var_162_6 > 0 and var_162_1 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_7 and arg_159_1.time_ < var_162_0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play122152037 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 122152037
		arg_163_1.duration_ = 11.77

		local var_163_0 = {
			ja = 11.766,
			ko = 9.733,
			zh = 9.733
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
				arg_163_0:Play122152038(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10037ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos10037ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0, -1.13, -6.2)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10037ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = arg_163_1.actors_["10037ui_story"]
			local var_166_10 = 0

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect10037ui_story == nil then
				arg_163_1.var_.characterEffect10037ui_story = var_166_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_11 = 0.200000002980232

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_11 and not isNil(var_166_9) then
				local var_166_12 = (arg_163_1.time_ - var_166_10) / var_166_11

				if arg_163_1.var_.characterEffect10037ui_story and not isNil(var_166_9) then
					arg_163_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_10 + var_166_11 and arg_163_1.time_ < var_166_10 + var_166_11 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect10037ui_story then
				arg_163_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_166_13 = 0

			if var_166_13 < arg_163_1.time_ and arg_163_1.time_ <= var_166_13 + arg_166_0 then
				arg_163_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			local var_166_14 = 0

			if var_166_14 < arg_163_1.time_ and arg_163_1.time_ <= var_166_14 + arg_166_0 then
				arg_163_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_166_15 = 0
			local var_166_16 = 0.725

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_17 = arg_163_1:FormatText(StoryNameCfg[383].name)

				arg_163_1.leftNameTxt_.text = var_166_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_18 = arg_163_1:GetWordFromCfg(122152037)
				local var_166_19 = arg_163_1:FormatText(var_166_18.content)

				arg_163_1.text_.text = var_166_19

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_20 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152037", "story_v_out_122152.awb") ~= 0 then
					local var_166_23 = manager.audio:GetVoiceLength("story_v_out_122152", "122152037", "story_v_out_122152.awb") / 1000

					if var_166_23 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_23 + var_166_15
					end

					if var_166_18.prefab_name ~= "" and arg_163_1.actors_[var_166_18.prefab_name] ~= nil then
						local var_166_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_18.prefab_name].transform, "story_v_out_122152", "122152037", "story_v_out_122152.awb")

						arg_163_1:RecordAudio("122152037", var_166_24)
						arg_163_1:RecordAudio("122152037", var_166_24)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_122152", "122152037", "story_v_out_122152.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_122152", "122152037", "story_v_out_122152.awb")
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
				actorName = "10037ui_story",
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
	Play122152038 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 122152038
		arg_167_1.duration_ = 8.53

		local var_167_0 = {
			ja = 8.533,
			ko = 8.233,
			zh = 8.233
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
				arg_167_0:Play122152039(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action4_1")
			end

			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_170_2 = 0
			local var_170_3 = 0.65

			if var_170_2 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_4 = arg_167_1:FormatText(StoryNameCfg[383].name)

				arg_167_1.leftNameTxt_.text = var_170_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_5 = arg_167_1:GetWordFromCfg(122152038)
				local var_170_6 = arg_167_1:FormatText(var_170_5.content)

				arg_167_1.text_.text = var_170_6

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_7 = 26
				local var_170_8 = utf8.len(var_170_6)
				local var_170_9 = var_170_7 <= 0 and var_170_3 or var_170_3 * (var_170_8 / var_170_7)

				if var_170_9 > 0 and var_170_3 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_6
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122152", "122152038", "story_v_out_122152.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_122152", "122152038", "story_v_out_122152.awb") / 1000

					if var_170_10 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_2
					end

					if var_170_5.prefab_name ~= "" and arg_167_1.actors_[var_170_5.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_5.prefab_name].transform, "story_v_out_122152", "122152038", "story_v_out_122152.awb")

						arg_167_1:RecordAudio("122152038", var_170_11)
						arg_167_1:RecordAudio("122152038", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_122152", "122152038", "story_v_out_122152.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_122152", "122152038", "story_v_out_122152.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_12 = math.max(var_170_3, arg_167_1.talkMaxDuration)

			if var_170_2 <= arg_167_1.time_ and arg_167_1.time_ < var_170_2 + var_170_12 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_2) / var_170_12

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_2 + var_170_12 and arg_167_1.time_ < var_170_2 + var_170_12 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play122152039 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 122152039
		arg_171_1.duration_ = 109.25

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
			arg_171_1.auto_ = false
		end

		function arg_171_1.playNext_(arg_173_0)
			arg_171_1.onStoryFinished_()
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_1 = 2

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_1 then
				local var_174_2 = (arg_171_1.time_ - var_174_0) / var_174_1
				local var_174_3 = Color.New(0, 0, 0)

				var_174_3.a = Mathf.Lerp(0, 1, var_174_2)
				arg_171_1.mask_.color = var_174_3
			end

			if arg_171_1.time_ >= var_174_0 + var_174_1 and arg_171_1.time_ < var_174_0 + var_174_1 + arg_174_0 then
				local var_174_4 = Color.New(0, 0, 0)

				var_174_4.a = 1
				arg_171_1.mask_.color = var_174_4
			end

			local var_174_5 = 2

			if var_174_5 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_6 = 2

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_6 then
				local var_174_7 = (arg_171_1.time_ - var_174_5) / var_174_6
				local var_174_8 = Color.New(0, 0, 0)

				var_174_8.a = Mathf.Lerp(1, 0, var_174_7)
				arg_171_1.mask_.color = var_174_8
			end

			if arg_171_1.time_ >= var_174_5 + var_174_6 and arg_171_1.time_ < var_174_5 + var_174_6 + arg_174_0 then
				local var_174_9 = Color.New(0, 0, 0)
				local var_174_10 = 0

				arg_171_1.mask_.enabled = false
				var_174_9.a = var_174_10
				arg_171_1.mask_.color = var_174_9
			end

			local var_174_11 = 2

			if var_174_11 < arg_171_1.time_ and arg_171_1.time_ <= var_174_11 + arg_174_0 then
				SetActive(arg_171_1.dialog_, false)
				SetActive(arg_171_1.allBtn_.gameObject, false)
				arg_171_1.hideBtnsController_:SetSelectedIndex(1)

				arg_171_1.marker = "XHV03"

				manager.video:Play("SofdecAsset/story/101221502.usm", function(arg_175_0)
					arg_171_1:Skip(arg_175_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_176_0)
					if arg_176_0 then
						arg_171_1.state_ = "pause"
					else
						arg_171_1.state_ = "playing"
					end
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_174_12 = 107.25

			if var_174_11 <= arg_171_1.time_ and arg_171_1.time_ < var_174_11 + var_174_12 then
				-- block empty
			end

			if arg_171_1.time_ >= var_174_11 + var_174_12 and arg_171_1.time_ < var_174_11 + var_174_12 + arg_174_0 then
				arg_171_1.marker = ""
			end

			local var_174_13 = 0
			local var_174_14 = 1
			local var_174_15 = manager.audio:GetVoiceLength("story_v_out_122152", "122152038", "story_v_out_122152.awb") / 1000

			if var_174_15 > 0 and var_174_14 < var_174_15 and var_174_15 + var_174_13 > arg_171_1.duration_ then
				local var_174_16 = var_174_15

				arg_171_1.duration_ = var_174_15 + var_174_13
			end

			if var_174_13 < arg_171_1.time_ and arg_171_1.time_ <= var_174_13 + arg_174_0 then
				local var_174_17 = "stop"
				local var_174_18 = "voice"

				arg_171_1:AudioAction(var_174_17, var_174_18, "story_v_out_122152", "122152038", "story_v_out_122152.awb")
			end

			local var_174_19 = 0
			local var_174_20 = 1

			if var_174_19 < arg_171_1.time_ and arg_171_1.time_ <= var_174_19 + arg_174_0 then
				local var_174_21 = "play"
				local var_174_22 = "music"

				arg_171_1:AudioAction(var_174_21, var_174_22, "ui_battle", "ui_battle_stopbgm", "")

				local var_174_23 = ""
				local var_174_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_174_24 ~= "" then
					if arg_171_1.bgmTxt_.text ~= var_174_24 and arg_171_1.bgmTxt_.text ~= "" then
						if arg_171_1.bgmTxt2_.text ~= "" then
							arg_171_1.bgmTxt_.text = arg_171_1.bgmTxt2_.text
						end

						arg_171_1.bgmTxt2_.text = var_174_24

						arg_171_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_171_1.bgmTxt_.text = var_174_24
						arg_171_1.bgmTxt2_.text = var_174_24
					end

					if arg_171_1.bgmTimer then
						arg_171_1.bgmTimer:Stop()

						arg_171_1.bgmTimer = nil
					end

					if arg_171_1.settingData.show_music_name == 1 then
						arg_171_1.musicController:SetSelectedState("show")
						arg_171_1.musicAnimator_:Play("open", 0, 0)

						if arg_171_1.settingData.music_time ~= 0 then
							arg_171_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_171_1.settingData.music_time), function()
								if arg_171_1 == nil or isNil(arg_171_1.bgmTxt_) then
									return
								end

								arg_171_1.musicController:SetSelectedState("hide")
								arg_171_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_174_25 = arg_171_1.actors_["10037ui_story"].transform
			local var_174_26 = 1.966

			if var_174_26 < arg_171_1.time_ and arg_171_1.time_ <= var_174_26 + arg_174_0 then
				arg_171_1.var_.moveOldPos10037ui_story = var_174_25.localPosition
			end

			local var_174_27 = 0.001

			if var_174_26 <= arg_171_1.time_ and arg_171_1.time_ < var_174_26 + var_174_27 then
				local var_174_28 = (arg_171_1.time_ - var_174_26) / var_174_27
				local var_174_29 = Vector3.New(0, 100, 0)

				var_174_25.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10037ui_story, var_174_29, var_174_28)

				local var_174_30 = manager.ui.mainCamera.transform.position - var_174_25.position

				var_174_25.forward = Vector3.New(var_174_30.x, var_174_30.y, var_174_30.z)

				local var_174_31 = var_174_25.localEulerAngles

				var_174_31.z = 0
				var_174_31.x = 0
				var_174_25.localEulerAngles = var_174_31
			end

			if arg_171_1.time_ >= var_174_26 + var_174_27 and arg_171_1.time_ < var_174_26 + var_174_27 + arg_174_0 then
				var_174_25.localPosition = Vector3.New(0, 100, 0)

				local var_174_32 = manager.ui.mainCamera.transform.position - var_174_25.position

				var_174_25.forward = Vector3.New(var_174_32.x, var_174_32.y, var_174_32.z)

				local var_174_33 = var_174_25.localEulerAngles

				var_174_33.z = 0
				var_174_33.x = 0
				var_174_25.localEulerAngles = var_174_33
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J11",
		"TextureConfig/Background/ST49",
		"TextureConfig/Background/J12g",
		"TextureConfig/Background/STblack",
		"SofdecAsset/story/101221502.usm"
	},
	voices = {
		"story_v_out_122152.awb"
	},
	skipMarkers = {
		122152039
	}
}
