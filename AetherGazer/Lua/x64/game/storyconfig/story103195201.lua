return {
	Play319521001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319521001
		arg_1_1.duration_ = 8

		local var_1_0 = {
			zh = 6.9,
			ja = 8
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
				arg_1_0:Play319521002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST02"

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
				local var_4_5 = arg_1_1.bgs_.ST02

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
					if iter_4_0 ~= "ST02" then
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

			local var_4_22 = "1084ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1084ui_story"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -0.97, -6)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -0.97, -6)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["1084ui_story"]
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_40 = 1.8

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_4_42 = 0
			local var_4_43 = 1

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "effect"

				arg_1_1:AudioAction(var_4_44, var_4_45, "se_story_221_00", "se_story_221_00_canteen_loop", "")
			end

			local var_4_46 = 0
			local var_4_47 = 0.0666666666666667

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "music"

				arg_1_1:AudioAction(var_4_48, var_4_49, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_50 = ""
				local var_4_51 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_51 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_51 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_51

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_51
						arg_1_1.bgmTxt2_.text = var_4_51
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

			local var_4_52 = 0.1
			local var_4_53 = 1

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				local var_4_54 = "play"
				local var_4_55 = "music"

				arg_1_1:AudioAction(var_4_54, var_4_55, "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure.awb")

				local var_4_56 = ""
				local var_4_57 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure")

				if var_4_57 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_57 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_57

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_57
						arg_1_1.bgmTxt2_.text = var_4_57
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

			local var_4_58 = 2
			local var_4_59 = 0.4

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_60 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_60:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_61 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_62 = arg_1_1:GetWordFromCfg(319521001)
				local var_4_63 = arg_1_1:FormatText(var_4_62.content)

				arg_1_1.text_.text = var_4_63

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_64 = 16
				local var_4_65 = utf8.len(var_4_63)
				local var_4_66 = var_4_64 <= 0 and var_4_59 or var_4_59 * (var_4_65 / var_4_64)

				if var_4_66 > 0 and var_4_59 < var_4_66 then
					arg_1_1.talkMaxDuration = var_4_66
					var_4_58 = var_4_58 + 0.3

					if var_4_66 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_66 + var_4_58
					end
				end

				arg_1_1.text_.text = var_4_63
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521001", "story_v_out_319521.awb") ~= 0 then
					local var_4_67 = manager.audio:GetVoiceLength("story_v_out_319521", "319521001", "story_v_out_319521.awb") / 1000

					if var_4_67 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_58
					end

					if var_4_62.prefab_name ~= "" and arg_1_1.actors_[var_4_62.prefab_name] ~= nil then
						local var_4_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_62.prefab_name].transform, "story_v_out_319521", "319521001", "story_v_out_319521.awb")

						arg_1_1:RecordAudio("319521001", var_4_68)
						arg_1_1:RecordAudio("319521001", var_4_68)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319521", "319521001", "story_v_out_319521.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319521", "319521001", "story_v_out_319521.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_69 = var_4_58 + 0.3
			local var_4_70 = math.max(var_4_59, arg_1_1.talkMaxDuration)

			if var_4_69 <= arg_1_1.time_ and arg_1_1.time_ < var_4_69 + var_4_70 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_69) / var_4_70

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_69 + var_4_70 and arg_1_1.time_ < var_4_69 + var_4_70 + arg_4_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play319521002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319521002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play319521003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1084ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect1084ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1084ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1084ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1084ui_story.fillRatio = var_12_5
			end

			local var_12_6 = arg_9_1.actors_["1084ui_story"].transform
			local var_12_7 = 0

			if var_12_7 < arg_9_1.time_ and arg_9_1.time_ <= var_12_7 + arg_12_0 then
				arg_9_1.var_.moveOldPos1084ui_story = var_12_6.localPosition
			end

			local var_12_8 = 0.001

			if var_12_7 <= arg_9_1.time_ and arg_9_1.time_ < var_12_7 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_7) / var_12_8
				local var_12_10 = Vector3.New(0, 100, 0)

				var_12_6.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1084ui_story, var_12_10, var_12_9)

				local var_12_11 = manager.ui.mainCamera.transform.position - var_12_6.position

				var_12_6.forward = Vector3.New(var_12_11.x, var_12_11.y, var_12_11.z)

				local var_12_12 = var_12_6.localEulerAngles

				var_12_12.z = 0
				var_12_12.x = 0
				var_12_6.localEulerAngles = var_12_12
			end

			if arg_9_1.time_ >= var_12_7 + var_12_8 and arg_9_1.time_ < var_12_7 + var_12_8 + arg_12_0 then
				var_12_6.localPosition = Vector3.New(0, 100, 0)

				local var_12_13 = manager.ui.mainCamera.transform.position - var_12_6.position

				var_12_6.forward = Vector3.New(var_12_13.x, var_12_13.y, var_12_13.z)

				local var_12_14 = var_12_6.localEulerAngles

				var_12_14.z = 0
				var_12_14.x = 0
				var_12_6.localEulerAngles = var_12_14
			end

			local var_12_15 = 0
			local var_12_16 = 1.275

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

				local var_12_17 = arg_9_1:GetWordFromCfg(319521002)
				local var_12_18 = arg_9_1:FormatText(var_12_17.content)

				arg_9_1.text_.text = var_12_18

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_19 = 51
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play319521003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319521003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play319521004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.075

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

				local var_16_2 = arg_13_1:GetWordFromCfg(319521003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 43
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
	Play319521004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319521004
		arg_17_1.duration_ = 3.03

		local var_17_0 = {
			zh = 2.3,
			ja = 3.033
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
				arg_17_0:Play319521005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.25

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[704].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(319521004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521004", "story_v_out_319521.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_319521", "319521004", "story_v_out_319521.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_319521", "319521004", "story_v_out_319521.awb")

						arg_17_1:RecordAudio("319521004", var_20_9)
						arg_17_1:RecordAudio("319521004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319521", "319521004", "story_v_out_319521.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319521", "319521004", "story_v_out_319521.awb")
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
	Play319521005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319521005
		arg_21_1.duration_ = 6.53

		local var_21_0 = {
			zh = 4.3,
			ja = 6.533
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
				arg_21_0:Play319521006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1084ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1084ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1084ui_story then
				arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_24_4 = arg_21_1.actors_["1084ui_story"].transform
			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.var_.moveOldPos1084ui_story = var_24_4.localPosition
			end

			local var_24_6 = 0.001

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_6 then
				local var_24_7 = (arg_21_1.time_ - var_24_5) / var_24_6
				local var_24_8 = Vector3.New(0, -0.97, -6)

				var_24_4.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1084ui_story, var_24_8, var_24_7)

				local var_24_9 = manager.ui.mainCamera.transform.position - var_24_4.position

				var_24_4.forward = Vector3.New(var_24_9.x, var_24_9.y, var_24_9.z)

				local var_24_10 = var_24_4.localEulerAngles

				var_24_10.z = 0
				var_24_10.x = 0
				var_24_4.localEulerAngles = var_24_10
			end

			if arg_21_1.time_ >= var_24_5 + var_24_6 and arg_21_1.time_ < var_24_5 + var_24_6 + arg_24_0 then
				var_24_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_24_11 = manager.ui.mainCamera.transform.position - var_24_4.position

				var_24_4.forward = Vector3.New(var_24_11.x, var_24_11.y, var_24_11.z)

				local var_24_12 = var_24_4.localEulerAngles

				var_24_12.z = 0
				var_24_12.x = 0
				var_24_4.localEulerAngles = var_24_12
			end

			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_24_14 = 0

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_24_15 = 0
			local var_24_16 = 0.575

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(319521005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 23
				local var_24_21 = utf8.len(var_24_19)
				local var_24_22 = var_24_20 <= 0 and var_24_16 or var_24_16 * (var_24_21 / var_24_20)

				if var_24_22 > 0 and var_24_16 < var_24_22 then
					arg_21_1.talkMaxDuration = var_24_22

					if var_24_22 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_22 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_19
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521005", "story_v_out_319521.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_319521", "319521005", "story_v_out_319521.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_319521", "319521005", "story_v_out_319521.awb")

						arg_21_1:RecordAudio("319521005", var_24_24)
						arg_21_1:RecordAudio("319521005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319521", "319521005", "story_v_out_319521.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319521", "319521005", "story_v_out_319521.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_25 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_25 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_25

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_25 and arg_21_1.time_ < var_24_15 + var_24_25 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play319521006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319521006
		arg_25_1.duration_ = 7.33

		local var_25_0 = {
			zh = 4,
			ja = 7.333
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
				arg_25_0:Play319521007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1084ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1084ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1084ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1084ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1084ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 0.425

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[704].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_9 = arg_25_1:GetWordFromCfg(319521006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521006", "story_v_out_319521.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_319521", "319521006", "story_v_out_319521.awb") / 1000

					if var_28_14 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_6
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_out_319521", "319521006", "story_v_out_319521.awb")

						arg_25_1:RecordAudio("319521006", var_28_15)
						arg_25_1:RecordAudio("319521006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319521", "319521006", "story_v_out_319521.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319521", "319521006", "story_v_out_319521.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_16 and arg_25_1.time_ < var_28_6 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319521007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319521007
		arg_29_1.duration_ = 10.53

		local var_29_0 = {
			zh = 6.233,
			ja = 10.533
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
				arg_29_0:Play319521008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1084ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1084ui_story == nil then
				arg_29_1.var_.characterEffect1084ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1084ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1084ui_story then
				arg_29_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_32_4 = 0
			local var_32_5 = 0.75

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_6 = arg_29_1:FormatText(StoryNameCfg[6].name)

				arg_29_1.leftNameTxt_.text = var_32_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(319521007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 30
				local var_32_10 = utf8.len(var_32_8)
				local var_32_11 = var_32_9 <= 0 and var_32_5 or var_32_5 * (var_32_10 / var_32_9)

				if var_32_11 > 0 and var_32_5 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521007", "story_v_out_319521.awb") ~= 0 then
					local var_32_12 = manager.audio:GetVoiceLength("story_v_out_319521", "319521007", "story_v_out_319521.awb") / 1000

					if var_32_12 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_4
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_319521", "319521007", "story_v_out_319521.awb")

						arg_29_1:RecordAudio("319521007", var_32_13)
						arg_29_1:RecordAudio("319521007", var_32_13)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319521", "319521007", "story_v_out_319521.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319521", "319521007", "story_v_out_319521.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_14 and arg_29_1.time_ < var_32_4 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319521008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319521008
		arg_33_1.duration_ = 9.5

		local var_33_0 = {
			zh = 9.433,
			ja = 9.5
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
				arg_33_0:Play319521009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1084ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1084ui_story == nil then
				arg_33_1.var_.characterEffect1084ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1084ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1084ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1084ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1084ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.975

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[704].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_9 = arg_33_1:GetWordFromCfg(319521008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521008", "story_v_out_319521.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_319521", "319521008", "story_v_out_319521.awb") / 1000

					if var_36_14 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_6
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_out_319521", "319521008", "story_v_out_319521.awb")

						arg_33_1:RecordAudio("319521008", var_36_15)
						arg_33_1:RecordAudio("319521008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319521", "319521008", "story_v_out_319521.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319521", "319521008", "story_v_out_319521.awb")
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
	Play319521009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319521009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play319521010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_40_1 = 0
			local var_40_2 = 0.8

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(319521009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 32
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_2 or var_40_2 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_2 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_8 and arg_37_1.time_ < var_40_1 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play319521010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319521010
		arg_41_1.duration_ = 4.8

		local var_41_0 = {
			zh = 3.4,
			ja = 4.8
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
				arg_41_0:Play319521011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1084ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1084ui_story == nil then
				arg_41_1.var_.characterEffect1084ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1084ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1084ui_story then
				arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_6 = 0
			local var_44_7 = 0.325

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[6].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_9 = arg_41_1:GetWordFromCfg(319521010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521010", "story_v_out_319521.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_319521", "319521010", "story_v_out_319521.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_out_319521", "319521010", "story_v_out_319521.awb")

						arg_41_1:RecordAudio("319521010", var_44_15)
						arg_41_1:RecordAudio("319521010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319521", "319521010", "story_v_out_319521.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319521", "319521010", "story_v_out_319521.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_16 and arg_41_1.time_ < var_44_6 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play319521011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319521011
		arg_45_1.duration_ = 5.23

		local var_45_0 = {
			zh = 3.733,
			ja = 5.233
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
				arg_45_0:Play319521012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1084ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1084ui_story == nil then
				arg_45_1.var_.characterEffect1084ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1084ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1084ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1084ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1084ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 0.45

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[704].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_9 = arg_45_1:GetWordFromCfg(319521011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521011", "story_v_out_319521.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_319521", "319521011", "story_v_out_319521.awb") / 1000

					if var_48_14 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_6
					end

					if var_48_9.prefab_name ~= "" and arg_45_1.actors_[var_48_9.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_9.prefab_name].transform, "story_v_out_319521", "319521011", "story_v_out_319521.awb")

						arg_45_1:RecordAudio("319521011", var_48_15)
						arg_45_1:RecordAudio("319521011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319521", "319521011", "story_v_out_319521.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319521", "319521011", "story_v_out_319521.awb")
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
	Play319521012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319521012
		arg_49_1.duration_ = 8.13

		local var_49_0 = {
			zh = 6.433,
			ja = 8.133
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
				arg_49_0:Play319521013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = "I11s"

			if arg_49_1.bgs_[var_52_0] == nil then
				local var_52_1 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_52_0)
				var_52_1.name = var_52_0
				var_52_1.transform.parent = arg_49_1.stage_.transform
				var_52_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_[var_52_0] = var_52_1
			end

			local var_52_2 = 2

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				local var_52_3 = manager.ui.mainCamera.transform.localPosition
				local var_52_4 = Vector3.New(0, 0, 10) + Vector3.New(var_52_3.x, var_52_3.y, 0)
				local var_52_5 = arg_49_1.bgs_.I11s

				var_52_5.transform.localPosition = var_52_4
				var_52_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_6 = var_52_5:GetComponent("SpriteRenderer")

				if var_52_6 and var_52_6.sprite then
					local var_52_7 = (var_52_5.transform.localPosition - var_52_3).z
					local var_52_8 = manager.ui.mainCameraCom_
					local var_52_9 = 2 * var_52_7 * Mathf.Tan(var_52_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_52_10 = var_52_9 * var_52_8.aspect
					local var_52_11 = var_52_6.sprite.bounds.size.x
					local var_52_12 = var_52_6.sprite.bounds.size.y
					local var_52_13 = var_52_10 / var_52_11
					local var_52_14 = var_52_9 / var_52_12
					local var_52_15 = var_52_14 < var_52_13 and var_52_13 or var_52_14

					var_52_5.transform.localScale = Vector3.New(var_52_15, var_52_15, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "I11s" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_17 = 2

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17
				local var_52_19 = Color.New(0, 0, 0)

				var_52_19.a = Mathf.Lerp(0, 1, var_52_18)
				arg_49_1.mask_.color = var_52_19
			end

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 then
				local var_52_20 = Color.New(0, 0, 0)

				var_52_20.a = 1
				arg_49_1.mask_.color = var_52_20
			end

			local var_52_21 = 2

			if var_52_21 < arg_49_1.time_ and arg_49_1.time_ <= var_52_21 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_22 = 2

			if var_52_21 <= arg_49_1.time_ and arg_49_1.time_ < var_52_21 + var_52_22 then
				local var_52_23 = (arg_49_1.time_ - var_52_21) / var_52_22
				local var_52_24 = Color.New(0, 0, 0)

				var_52_24.a = Mathf.Lerp(1, 0, var_52_23)
				arg_49_1.mask_.color = var_52_24
			end

			if arg_49_1.time_ >= var_52_21 + var_52_22 and arg_49_1.time_ < var_52_21 + var_52_22 + arg_52_0 then
				local var_52_25 = Color.New(0, 0, 0)
				local var_52_26 = 0

				arg_49_1.mask_.enabled = false
				var_52_25.a = var_52_26
				arg_49_1.mask_.color = var_52_25
			end

			local var_52_27 = arg_49_1.actors_["1084ui_story"].transform
			local var_52_28 = 2

			if var_52_28 < arg_49_1.time_ and arg_49_1.time_ <= var_52_28 + arg_52_0 then
				arg_49_1.var_.moveOldPos1084ui_story = var_52_27.localPosition
			end

			local var_52_29 = 0.001

			if var_52_28 <= arg_49_1.time_ and arg_49_1.time_ < var_52_28 + var_52_29 then
				local var_52_30 = (arg_49_1.time_ - var_52_28) / var_52_29
				local var_52_31 = Vector3.New(0, 100, 0)

				var_52_27.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1084ui_story, var_52_31, var_52_30)

				local var_52_32 = manager.ui.mainCamera.transform.position - var_52_27.position

				var_52_27.forward = Vector3.New(var_52_32.x, var_52_32.y, var_52_32.z)

				local var_52_33 = var_52_27.localEulerAngles

				var_52_33.z = 0
				var_52_33.x = 0
				var_52_27.localEulerAngles = var_52_33
			end

			if arg_49_1.time_ >= var_52_28 + var_52_29 and arg_49_1.time_ < var_52_28 + var_52_29 + arg_52_0 then
				var_52_27.localPosition = Vector3.New(0, 100, 0)

				local var_52_34 = manager.ui.mainCamera.transform.position - var_52_27.position

				var_52_27.forward = Vector3.New(var_52_34.x, var_52_34.y, var_52_34.z)

				local var_52_35 = var_52_27.localEulerAngles

				var_52_35.z = 0
				var_52_35.x = 0
				var_52_27.localEulerAngles = var_52_35
			end

			local var_52_36 = arg_49_1.actors_["1084ui_story"]
			local var_52_37 = 2

			if var_52_37 < arg_49_1.time_ and arg_49_1.time_ <= var_52_37 + arg_52_0 and not isNil(var_52_36) and arg_49_1.var_.characterEffect1084ui_story == nil then
				arg_49_1.var_.characterEffect1084ui_story = var_52_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_38 = 0.200000002980232

			if var_52_37 <= arg_49_1.time_ and arg_49_1.time_ < var_52_37 + var_52_38 and not isNil(var_52_36) then
				local var_52_39 = (arg_49_1.time_ - var_52_37) / var_52_38

				if arg_49_1.var_.characterEffect1084ui_story and not isNil(var_52_36) then
					local var_52_40 = Mathf.Lerp(0, 0.5, var_52_39)

					arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1084ui_story.fillRatio = var_52_40
				end
			end

			if arg_49_1.time_ >= var_52_37 + var_52_38 and arg_49_1.time_ < var_52_37 + var_52_38 + arg_52_0 and not isNil(var_52_36) and arg_49_1.var_.characterEffect1084ui_story then
				local var_52_41 = 0.5

				arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1084ui_story.fillRatio = var_52_41
			end

			local var_52_42 = 0
			local var_52_43 = 1

			if var_52_42 < arg_49_1.time_ and arg_49_1.time_ <= var_52_42 + arg_52_0 then
				local var_52_44 = "stop"
				local var_52_45 = "effect"

				arg_49_1:AudioAction(var_52_44, var_52_45, "se_story_221_00", "se_story_221_00_canteen_loop", "")
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_46 = 2
			local var_52_47 = 0.475

			if var_52_46 < arg_49_1.time_ and arg_49_1.time_ <= var_52_46 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_48 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_48:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_49 = arg_49_1:FormatText(StoryNameCfg[704].name)

				arg_49_1.leftNameTxt_.text = var_52_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_50 = arg_49_1:GetWordFromCfg(319521012)
				local var_52_51 = arg_49_1:FormatText(var_52_50.content)

				arg_49_1.text_.text = var_52_51

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_52 = 19
				local var_52_53 = utf8.len(var_52_51)
				local var_52_54 = var_52_52 <= 0 and var_52_47 or var_52_47 * (var_52_53 / var_52_52)

				if var_52_54 > 0 and var_52_47 < var_52_54 then
					arg_49_1.talkMaxDuration = var_52_54
					var_52_46 = var_52_46 + 0.3

					if var_52_54 + var_52_46 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_54 + var_52_46
					end
				end

				arg_49_1.text_.text = var_52_51
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521012", "story_v_out_319521.awb") ~= 0 then
					local var_52_55 = manager.audio:GetVoiceLength("story_v_out_319521", "319521012", "story_v_out_319521.awb") / 1000

					if var_52_55 + var_52_46 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_55 + var_52_46
					end

					if var_52_50.prefab_name ~= "" and arg_49_1.actors_[var_52_50.prefab_name] ~= nil then
						local var_52_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_50.prefab_name].transform, "story_v_out_319521", "319521012", "story_v_out_319521.awb")

						arg_49_1:RecordAudio("319521012", var_52_56)
						arg_49_1:RecordAudio("319521012", var_52_56)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319521", "319521012", "story_v_out_319521.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319521", "319521012", "story_v_out_319521.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_57 = var_52_46 + 0.3
			local var_52_58 = math.max(var_52_47, arg_49_1.talkMaxDuration)

			if var_52_57 <= arg_49_1.time_ and arg_49_1.time_ < var_52_57 + var_52_58 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_57) / var_52_58

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_57 + var_52_58 and arg_49_1.time_ < var_52_57 + var_52_58 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play319521013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319521013
		arg_55_1.duration_ = 3.9

		local var_55_0 = {
			zh = 2.366,
			ja = 3.9
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
				arg_55_0:Play319521014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.275

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[704].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(319521013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521013", "story_v_out_319521.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_319521", "319521013", "story_v_out_319521.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_319521", "319521013", "story_v_out_319521.awb")

						arg_55_1:RecordAudio("319521013", var_58_9)
						arg_55_1:RecordAudio("319521013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_319521", "319521013", "story_v_out_319521.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_319521", "319521013", "story_v_out_319521.awb")
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
	Play319521014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319521014
		arg_59_1.duration_ = 2

		local var_59_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_59_0:Play319521015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = "10074ui_story"

			if arg_59_1.actors_[var_62_0] == nil then
				local var_62_1 = Asset.Load("Char/" .. "10074ui_story")

				if not isNil(var_62_1) then
					local var_62_2 = Object.Instantiate(Asset.Load("Char/" .. "10074ui_story"), arg_59_1.stage_.transform)

					var_62_2.name = var_62_0
					var_62_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_59_1.actors_[var_62_0] = var_62_2

					local var_62_3 = var_62_2:GetComponentInChildren(typeof(CharacterEffect))

					var_62_3.enabled = true

					local var_62_4 = GameObjectTools.GetOrAddComponent(var_62_2, typeof(DynamicBoneHelper))

					if var_62_4 then
						var_62_4:EnableDynamicBone(false)
					end

					arg_59_1:ShowWeapon(var_62_3.transform, false)

					arg_59_1.var_[var_62_0 .. "Animator"] = var_62_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_59_1.var_[var_62_0 .. "Animator"].applyRootMotion = true
					arg_59_1.var_[var_62_0 .. "LipSync"] = var_62_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_62_5 = arg_59_1.actors_["10074ui_story"].transform
			local var_62_6 = 0

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.var_.moveOldPos10074ui_story = var_62_5.localPosition
			end

			local var_62_7 = 0.001

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_7 then
				local var_62_8 = (arg_59_1.time_ - var_62_6) / var_62_7
				local var_62_9 = Vector3.New(0, -0.75, -6.18)

				var_62_5.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10074ui_story, var_62_9, var_62_8)

				local var_62_10 = manager.ui.mainCamera.transform.position - var_62_5.position

				var_62_5.forward = Vector3.New(var_62_10.x, var_62_10.y, var_62_10.z)

				local var_62_11 = var_62_5.localEulerAngles

				var_62_11.z = 0
				var_62_11.x = 0
				var_62_5.localEulerAngles = var_62_11
			end

			if arg_59_1.time_ >= var_62_6 + var_62_7 and arg_59_1.time_ < var_62_6 + var_62_7 + arg_62_0 then
				var_62_5.localPosition = Vector3.New(0, -0.75, -6.18)

				local var_62_12 = manager.ui.mainCamera.transform.position - var_62_5.position

				var_62_5.forward = Vector3.New(var_62_12.x, var_62_12.y, var_62_12.z)

				local var_62_13 = var_62_5.localEulerAngles

				var_62_13.z = 0
				var_62_13.x = 0
				var_62_5.localEulerAngles = var_62_13
			end

			local var_62_14 = arg_59_1.actors_["10074ui_story"]
			local var_62_15 = 0

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 and not isNil(var_62_14) and arg_59_1.var_.characterEffect10074ui_story == nil then
				arg_59_1.var_.characterEffect10074ui_story = var_62_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_16 = 0.200000002980232

			if var_62_15 <= arg_59_1.time_ and arg_59_1.time_ < var_62_15 + var_62_16 and not isNil(var_62_14) then
				local var_62_17 = (arg_59_1.time_ - var_62_15) / var_62_16

				if arg_59_1.var_.characterEffect10074ui_story and not isNil(var_62_14) then
					arg_59_1.var_.characterEffect10074ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_15 + var_62_16 and arg_59_1.time_ < var_62_15 + var_62_16 + arg_62_0 and not isNil(var_62_14) and arg_59_1.var_.characterEffect10074ui_story then
				arg_59_1.var_.characterEffect10074ui_story.fillFlat = false
			end

			local var_62_18 = 0

			if var_62_18 < arg_59_1.time_ and arg_59_1.time_ <= var_62_18 + arg_62_0 then
				arg_59_1:PlayTimeline("10074ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action2_1")
			end

			local var_62_19 = 0

			if var_62_19 < arg_59_1.time_ and arg_59_1.time_ <= var_62_19 + arg_62_0 then
				arg_59_1:PlayTimeline("10074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_62_20 = 0
			local var_62_21 = 0.125

			if var_62_20 < arg_59_1.time_ and arg_59_1.time_ <= var_62_20 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_22 = arg_59_1:FormatText(StoryNameCfg[697].name)

				arg_59_1.leftNameTxt_.text = var_62_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_23 = arg_59_1:GetWordFromCfg(319521014)
				local var_62_24 = arg_59_1:FormatText(var_62_23.content)

				arg_59_1.text_.text = var_62_24

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_25 = 5
				local var_62_26 = utf8.len(var_62_24)
				local var_62_27 = var_62_25 <= 0 and var_62_21 or var_62_21 * (var_62_26 / var_62_25)

				if var_62_27 > 0 and var_62_21 < var_62_27 then
					arg_59_1.talkMaxDuration = var_62_27

					if var_62_27 + var_62_20 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_27 + var_62_20
					end
				end

				arg_59_1.text_.text = var_62_24
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521014", "story_v_out_319521.awb") ~= 0 then
					local var_62_28 = manager.audio:GetVoiceLength("story_v_out_319521", "319521014", "story_v_out_319521.awb") / 1000

					if var_62_28 + var_62_20 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_28 + var_62_20
					end

					if var_62_23.prefab_name ~= "" and arg_59_1.actors_[var_62_23.prefab_name] ~= nil then
						local var_62_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_23.prefab_name].transform, "story_v_out_319521", "319521014", "story_v_out_319521.awb")

						arg_59_1:RecordAudio("319521014", var_62_29)
						arg_59_1:RecordAudio("319521014", var_62_29)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_319521", "319521014", "story_v_out_319521.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_319521", "319521014", "story_v_out_319521.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_30 = math.max(var_62_21, arg_59_1.talkMaxDuration)

			if var_62_20 <= arg_59_1.time_ and arg_59_1.time_ < var_62_20 + var_62_30 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_20) / var_62_30

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_20 + var_62_30 and arg_59_1.time_ < var_62_20 + var_62_30 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play319521015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319521015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play319521016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = "10068ui_story"

			if arg_63_1.actors_[var_66_0] == nil then
				local var_66_1 = Asset.Load("Char/" .. "10068ui_story")

				if not isNil(var_66_1) then
					local var_66_2 = Object.Instantiate(Asset.Load("Char/" .. "10068ui_story"), arg_63_1.stage_.transform)

					var_66_2.name = var_66_0
					var_66_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_63_1.actors_[var_66_0] = var_66_2

					local var_66_3 = var_66_2:GetComponentInChildren(typeof(CharacterEffect))

					var_66_3.enabled = true

					local var_66_4 = GameObjectTools.GetOrAddComponent(var_66_2, typeof(DynamicBoneHelper))

					if var_66_4 then
						var_66_4:EnableDynamicBone(false)
					end

					arg_63_1:ShowWeapon(var_66_3.transform, false)

					arg_63_1.var_[var_66_0 .. "Animator"] = var_66_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_63_1.var_[var_66_0 .. "Animator"].applyRootMotion = true
					arg_63_1.var_[var_66_0 .. "LipSync"] = var_66_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_66_5 = arg_63_1.actors_["10068ui_story"]
			local var_66_6 = 0

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.characterEffect10068ui_story == nil then
				arg_63_1.var_.characterEffect10068ui_story = var_66_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_7 = 0.200000002980232

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_7 and not isNil(var_66_5) then
				local var_66_8 = (arg_63_1.time_ - var_66_6) / var_66_7

				if arg_63_1.var_.characterEffect10068ui_story and not isNil(var_66_5) then
					local var_66_9 = Mathf.Lerp(0, 0.5, var_66_8)

					arg_63_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10068ui_story.fillRatio = var_66_9
				end
			end

			if arg_63_1.time_ >= var_66_6 + var_66_7 and arg_63_1.time_ < var_66_6 + var_66_7 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.characterEffect10068ui_story then
				local var_66_10 = 0.5

				arg_63_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10068ui_story.fillRatio = var_66_10
			end

			local var_66_11 = 0
			local var_66_12 = 0.6

			if var_66_11 < arg_63_1.time_ and arg_63_1.time_ <= var_66_11 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_13 = arg_63_1:FormatText(StoryNameCfg[698].name)

				arg_63_1.leftNameTxt_.text = var_66_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_14 = arg_63_1:GetWordFromCfg(319521015)
				local var_66_15 = arg_63_1:FormatText(var_66_14.content)

				arg_63_1.text_.text = var_66_15

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_16 = 24
				local var_66_17 = utf8.len(var_66_15)
				local var_66_18 = var_66_16 <= 0 and var_66_12 or var_66_12 * (var_66_17 / var_66_16)

				if var_66_18 > 0 and var_66_12 < var_66_18 then
					arg_63_1.talkMaxDuration = var_66_18

					if var_66_18 + var_66_11 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_18 + var_66_11
					end
				end

				arg_63_1.text_.text = var_66_15
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_19 = math.max(var_66_12, arg_63_1.talkMaxDuration)

			if var_66_11 <= arg_63_1.time_ and arg_63_1.time_ < var_66_11 + var_66_19 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_11) / var_66_19

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_11 + var_66_19 and arg_63_1.time_ < var_66_11 + var_66_19 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play319521016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319521016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play319521017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.75

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_2 = arg_67_1:GetWordFromCfg(319521016)
				local var_70_3 = arg_67_1:FormatText(var_70_2.content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 30
				local var_70_5 = utf8.len(var_70_3)
				local var_70_6 = var_70_4 <= 0 and var_70_1 or var_70_1 * (var_70_5 / var_70_4)

				if var_70_6 > 0 and var_70_1 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_7 and arg_67_1.time_ < var_70_0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play319521017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319521017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play319521018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.425

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[698].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:GetWordFromCfg(319521017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 17
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_8 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_8 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_8

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_8 and arg_71_1.time_ < var_74_0 + var_74_8 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play319521018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 319521018
		arg_75_1.duration_ = 9.7

		local var_75_0 = {
			zh = 8.1,
			ja = 9.7
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play319521019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.825

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[704].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:GetWordFromCfg(319521018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 33
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521018", "story_v_out_319521.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_319521", "319521018", "story_v_out_319521.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_319521", "319521018", "story_v_out_319521.awb")

						arg_75_1:RecordAudio("319521018", var_78_9)
						arg_75_1:RecordAudio("319521018", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_319521", "319521018", "story_v_out_319521.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_319521", "319521018", "story_v_out_319521.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_10 and arg_75_1.time_ < var_78_0 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play319521019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319521019
		arg_79_1.duration_ = 9

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play319521020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 2

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				local var_82_1 = manager.ui.mainCamera.transform.localPosition
				local var_82_2 = Vector3.New(0, 0, 10) + Vector3.New(var_82_1.x, var_82_1.y, 0)
				local var_82_3 = arg_79_1.bgs_.I11s

				var_82_3.transform.localPosition = var_82_2
				var_82_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_4 = var_82_3:GetComponent("SpriteRenderer")

				if var_82_4 and var_82_4.sprite then
					local var_82_5 = (var_82_3.transform.localPosition - var_82_1).z
					local var_82_6 = manager.ui.mainCameraCom_
					local var_82_7 = 2 * var_82_5 * Mathf.Tan(var_82_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_82_8 = var_82_7 * var_82_6.aspect
					local var_82_9 = var_82_4.sprite.bounds.size.x
					local var_82_10 = var_82_4.sprite.bounds.size.y
					local var_82_11 = var_82_8 / var_82_9
					local var_82_12 = var_82_7 / var_82_10
					local var_82_13 = var_82_12 < var_82_11 and var_82_11 or var_82_12

					var_82_3.transform.localScale = Vector3.New(var_82_13, var_82_13, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "I11s" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_82_14 = 0

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_15 = 2

			if var_82_14 <= arg_79_1.time_ and arg_79_1.time_ < var_82_14 + var_82_15 then
				local var_82_16 = (arg_79_1.time_ - var_82_14) / var_82_15
				local var_82_17 = Color.New(0, 0, 0)

				var_82_17.a = Mathf.Lerp(0, 1, var_82_16)
				arg_79_1.mask_.color = var_82_17
			end

			if arg_79_1.time_ >= var_82_14 + var_82_15 and arg_79_1.time_ < var_82_14 + var_82_15 + arg_82_0 then
				local var_82_18 = Color.New(0, 0, 0)

				var_82_18.a = 1
				arg_79_1.mask_.color = var_82_18
			end

			local var_82_19 = 2

			if var_82_19 < arg_79_1.time_ and arg_79_1.time_ <= var_82_19 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_20 = 2

			if var_82_19 <= arg_79_1.time_ and arg_79_1.time_ < var_82_19 + var_82_20 then
				local var_82_21 = (arg_79_1.time_ - var_82_19) / var_82_20
				local var_82_22 = Color.New(0, 0, 0)

				var_82_22.a = Mathf.Lerp(1, 0, var_82_21)
				arg_79_1.mask_.color = var_82_22
			end

			if arg_79_1.time_ >= var_82_19 + var_82_20 and arg_79_1.time_ < var_82_19 + var_82_20 + arg_82_0 then
				local var_82_23 = Color.New(0, 0, 0)
				local var_82_24 = 0

				arg_79_1.mask_.enabled = false
				var_82_23.a = var_82_24
				arg_79_1.mask_.color = var_82_23
			end

			local var_82_25 = arg_79_1.actors_["10074ui_story"].transform
			local var_82_26 = 1.96599999815226

			if var_82_26 < arg_79_1.time_ and arg_79_1.time_ <= var_82_26 + arg_82_0 then
				arg_79_1.var_.moveOldPos10074ui_story = var_82_25.localPosition
			end

			local var_82_27 = 0.001

			if var_82_26 <= arg_79_1.time_ and arg_79_1.time_ < var_82_26 + var_82_27 then
				local var_82_28 = (arg_79_1.time_ - var_82_26) / var_82_27
				local var_82_29 = Vector3.New(0, 100, 0)

				var_82_25.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10074ui_story, var_82_29, var_82_28)

				local var_82_30 = manager.ui.mainCamera.transform.position - var_82_25.position

				var_82_25.forward = Vector3.New(var_82_30.x, var_82_30.y, var_82_30.z)

				local var_82_31 = var_82_25.localEulerAngles

				var_82_31.z = 0
				var_82_31.x = 0
				var_82_25.localEulerAngles = var_82_31
			end

			if arg_79_1.time_ >= var_82_26 + var_82_27 and arg_79_1.time_ < var_82_26 + var_82_27 + arg_82_0 then
				var_82_25.localPosition = Vector3.New(0, 100, 0)

				local var_82_32 = manager.ui.mainCamera.transform.position - var_82_25.position

				var_82_25.forward = Vector3.New(var_82_32.x, var_82_32.y, var_82_32.z)

				local var_82_33 = var_82_25.localEulerAngles

				var_82_33.z = 0
				var_82_33.x = 0
				var_82_25.localEulerAngles = var_82_33
			end

			local var_82_34 = arg_79_1.actors_["10074ui_story"].transform
			local var_82_35 = 1.966

			if var_82_35 < arg_79_1.time_ and arg_79_1.time_ <= var_82_35 + arg_82_0 then
				arg_79_1.var_.moveOldPos10074ui_story = var_82_34.localPosition
			end

			local var_82_36 = 0.001

			if var_82_35 <= arg_79_1.time_ and arg_79_1.time_ < var_82_35 + var_82_36 then
				local var_82_37 = (arg_79_1.time_ - var_82_35) / var_82_36
				local var_82_38 = Vector3.New(0, 100, 0)

				var_82_34.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10074ui_story, var_82_38, var_82_37)

				local var_82_39 = manager.ui.mainCamera.transform.position - var_82_34.position

				var_82_34.forward = Vector3.New(var_82_39.x, var_82_39.y, var_82_39.z)

				local var_82_40 = var_82_34.localEulerAngles

				var_82_40.z = 0
				var_82_40.x = 0
				var_82_34.localEulerAngles = var_82_40
			end

			if arg_79_1.time_ >= var_82_35 + var_82_36 and arg_79_1.time_ < var_82_35 + var_82_36 + arg_82_0 then
				var_82_34.localPosition = Vector3.New(0, 100, 0)

				local var_82_41 = manager.ui.mainCamera.transform.position - var_82_34.position

				var_82_34.forward = Vector3.New(var_82_41.x, var_82_41.y, var_82_41.z)

				local var_82_42 = var_82_34.localEulerAngles

				var_82_42.z = 0
				var_82_42.x = 0
				var_82_34.localEulerAngles = var_82_42
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_43 = 4
			local var_82_44 = 0.875

			if var_82_43 < arg_79_1.time_ and arg_79_1.time_ <= var_82_43 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_45 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_45:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_46 = arg_79_1:GetWordFromCfg(319521019)
				local var_82_47 = arg_79_1:FormatText(var_82_46.content)

				arg_79_1.text_.text = var_82_47

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_48 = 35
				local var_82_49 = utf8.len(var_82_47)
				local var_82_50 = var_82_48 <= 0 and var_82_44 or var_82_44 * (var_82_49 / var_82_48)

				if var_82_50 > 0 and var_82_44 < var_82_50 then
					arg_79_1.talkMaxDuration = var_82_50
					var_82_43 = var_82_43 + 0.3

					if var_82_50 + var_82_43 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_50 + var_82_43
					end
				end

				arg_79_1.text_.text = var_82_47
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_51 = var_82_43 + 0.3
			local var_82_52 = math.max(var_82_44, arg_79_1.talkMaxDuration)

			if var_82_51 <= arg_79_1.time_ and arg_79_1.time_ < var_82_51 + var_82_52 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_51) / var_82_52

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_51 + var_82_52 and arg_79_1.time_ < var_82_51 + var_82_52 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play319521020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319521020
		arg_85_1.duration_ = 3.17

		local var_85_0 = {
			zh = 2.5,
			ja = 3.166
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
				arg_85_0:Play319521021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1084ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1084ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, -0.97, -6)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1084ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["1084ui_story"]
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.200000002980232

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 and not isNil(var_88_9) then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11

				if arg_85_1.var_.characterEffect1084ui_story and not isNil(var_88_9) then
					arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1084ui_story then
				arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_88_13 = 0

			if var_88_13 < arg_85_1.time_ and arg_85_1.time_ <= var_88_13 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_88_14 = 0

			if var_88_14 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_15 = 0
			local var_88_16 = 0.275

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[6].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(319521020)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521020", "story_v_out_319521.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_319521", "319521020", "story_v_out_319521.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_out_319521", "319521020", "story_v_out_319521.awb")

						arg_85_1:RecordAudio("319521020", var_88_24)
						arg_85_1:RecordAudio("319521020", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319521", "319521020", "story_v_out_319521.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319521", "319521020", "story_v_out_319521.awb")
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
				actorName = "1084ui_story",
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
	Play319521021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319521021
		arg_89_1.duration_ = 7.83

		local var_89_0 = {
			zh = 5.066,
			ja = 7.833
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
				arg_89_0:Play319521022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.65

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[6].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(319521021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 26
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521021", "story_v_out_319521.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_319521", "319521021", "story_v_out_319521.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_319521", "319521021", "story_v_out_319521.awb")

						arg_89_1:RecordAudio("319521021", var_92_9)
						arg_89_1:RecordAudio("319521021", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319521", "319521021", "story_v_out_319521.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319521", "319521021", "story_v_out_319521.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play319521022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319521022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play319521023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1084ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1084ui_story == nil then
				arg_93_1.var_.characterEffect1084ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1084ui_story and not isNil(var_96_0) then
					local var_96_4 = Mathf.Lerp(0, 0.5, var_96_3)

					arg_93_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1084ui_story.fillRatio = var_96_4
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1084ui_story then
				local var_96_5 = 0.5

				arg_93_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1084ui_story.fillRatio = var_96_5
			end

			local var_96_6 = 0
			local var_96_7 = 1.475

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:GetWordFromCfg(319521022)
				local var_96_9 = arg_93_1:FormatText(var_96_8.content)

				arg_93_1.text_.text = var_96_9

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 59
				local var_96_11 = utf8.len(var_96_9)
				local var_96_12 = var_96_10 <= 0 and var_96_7 or var_96_7 * (var_96_11 / var_96_10)

				if var_96_12 > 0 and var_96_7 < var_96_12 then
					arg_93_1.talkMaxDuration = var_96_12

					if var_96_12 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_9
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_13 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_13 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_13

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_13 and arg_93_1.time_ < var_96_6 + var_96_13 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319521023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319521023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play319521024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 1.5

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

				local var_100_2 = arg_97_1:GetWordFromCfg(319521023)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 60
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
	Play319521024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319521024
		arg_101_1.duration_ = 6.07

		local var_101_0 = {
			zh = 5.2,
			ja = 6.066
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
				arg_101_0:Play319521025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1084ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1084ui_story then
				arg_101_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_104_4 = 0

			if var_104_4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_104_5 = 0

			if var_104_5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_104_6 = 0
			local var_104_7 = 0.6

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_8 = arg_101_1:FormatText(StoryNameCfg[6].name)

				arg_101_1.leftNameTxt_.text = var_104_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_9 = arg_101_1:GetWordFromCfg(319521024)
				local var_104_10 = arg_101_1:FormatText(var_104_9.content)

				arg_101_1.text_.text = var_104_10

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 24
				local var_104_12 = utf8.len(var_104_10)
				local var_104_13 = var_104_11 <= 0 and var_104_7 or var_104_7 * (var_104_12 / var_104_11)

				if var_104_13 > 0 and var_104_7 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_10
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521024", "story_v_out_319521.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_319521", "319521024", "story_v_out_319521.awb") / 1000

					if var_104_14 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_6
					end

					if var_104_9.prefab_name ~= "" and arg_101_1.actors_[var_104_9.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_9.prefab_name].transform, "story_v_out_319521", "319521024", "story_v_out_319521.awb")

						arg_101_1:RecordAudio("319521024", var_104_15)
						arg_101_1:RecordAudio("319521024", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319521", "319521024", "story_v_out_319521.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319521", "319521024", "story_v_out_319521.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_16 and arg_101_1.time_ < var_104_6 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play319521025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319521025
		arg_105_1.duration_ = 6.9

		local var_105_0 = {
			zh = 3.4,
			ja = 6.9
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
				arg_105_0:Play319521026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1084ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1084ui_story == nil then
				arg_105_1.var_.characterEffect1084ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1084ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1084ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1084ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1084ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 0.3

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_8 = arg_105_1:FormatText(StoryNameCfg[36].name)

				arg_105_1.leftNameTxt_.text = var_108_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_9 = arg_105_1:GetWordFromCfg(319521025)
				local var_108_10 = arg_105_1:FormatText(var_108_9.content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521025", "story_v_out_319521.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_319521", "319521025", "story_v_out_319521.awb") / 1000

					if var_108_14 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_6
					end

					if var_108_9.prefab_name ~= "" and arg_105_1.actors_[var_108_9.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_9.prefab_name].transform, "story_v_out_319521", "319521025", "story_v_out_319521.awb")

						arg_105_1:RecordAudio("319521025", var_108_15)
						arg_105_1:RecordAudio("319521025", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_319521", "319521025", "story_v_out_319521.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_319521", "319521025", "story_v_out_319521.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_16 and arg_105_1.time_ < var_108_6 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play319521026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319521026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play319521027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_112_2 = 0
			local var_112_3 = 1.15

			if var_112_2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(319521026)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 46
				local var_112_7 = utf8.len(var_112_5)
				local var_112_8 = var_112_6 <= 0 and var_112_3 or var_112_3 * (var_112_7 / var_112_6)

				if var_112_8 > 0 and var_112_3 < var_112_8 then
					arg_109_1.talkMaxDuration = var_112_8

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_9 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_9 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_9

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_9 and arg_109_1.time_ < var_112_2 + var_112_9 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play319521027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319521027
		arg_113_1.duration_ = 7.47

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play319521028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = "STblack"

			if arg_113_1.bgs_[var_116_0] == nil then
				local var_116_1 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_116_0)
				var_116_1.name = var_116_0
				var_116_1.transform.parent = arg_113_1.stage_.transform
				var_116_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_[var_116_0] = var_116_1
			end

			local var_116_2 = 0

			if var_116_2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				local var_116_3 = manager.ui.mainCamera.transform.localPosition
				local var_116_4 = Vector3.New(0, 0, 10) + Vector3.New(var_116_3.x, var_116_3.y, 0)
				local var_116_5 = arg_113_1.bgs_.STblack

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
					if iter_116_0 ~= "STblack" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				local var_116_17 = arg_113_1.fswbg_.transform:Find("textbox/adapt/content") or arg_113_1.fswbg_.transform:Find("textbox/content")
				local var_116_18 = arg_113_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_116_19 = var_116_17:GetComponent("Text")
				local var_116_20 = var_116_17:GetComponent("RectTransform")

				var_116_19.alignment = UnityEngine.TextAnchor.LowerCenter
				var_116_20.offsetMin = Vector2.New(0, 0)
				var_116_20.offsetMax = Vector2.New(0, 0)
			end

			local var_116_21 = 0

			if var_116_21 < arg_113_1.time_ and arg_113_1.time_ <= var_116_21 + arg_116_0 then
				arg_113_1.fswbg_:SetActive(true)
				arg_113_1.dialog_:SetActive(false)

				arg_113_1.fswtw_.percent = 0

				local var_116_22 = arg_113_1:GetWordFromCfg(319521027)
				local var_116_23 = arg_113_1:FormatText(var_116_22.content)

				arg_113_1.fswt_.text = var_116_23

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.fswt_)

				arg_113_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_113_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_113_1.fswtw_:SetDirty()

				arg_113_1.typewritterCharCountI18N = 0

				SetActive(arg_113_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_113_1:ShowNextGo(false)
			end

			local var_116_24 = 0.366666666666667

			if var_116_24 < arg_113_1.time_ and arg_113_1.time_ <= var_116_24 + arg_116_0 then
				arg_113_1.var_.oldValueTypewriter = arg_113_1.fswtw_.percent

				SetActive(arg_113_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_113_1:ShowNextGo(false)
			end

			local var_116_25 = 4
			local var_116_26 = 0.266666666666667
			local var_116_27 = arg_113_1:GetWordFromCfg(319521027)
			local var_116_28 = arg_113_1:FormatText(var_116_27.content)
			local var_116_29, var_116_30 = arg_113_1:GetPercentByPara(var_116_28, 1)

			if var_116_24 < arg_113_1.time_ and arg_113_1.time_ <= var_116_24 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				local var_116_31 = var_116_25 <= 0 and var_116_26 or var_116_26 * ((var_116_30 - arg_113_1.typewritterCharCountI18N) / var_116_25)

				if var_116_31 > 0 and var_116_26 < var_116_31 then
					arg_113_1.talkMaxDuration = var_116_31

					if var_116_31 + var_116_24 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_31 + var_116_24
					end
				end
			end

			local var_116_32 = 0.266666666666667
			local var_116_33 = math.max(var_116_32, arg_113_1.talkMaxDuration)

			if var_116_24 <= arg_113_1.time_ and arg_113_1.time_ < var_116_24 + var_116_33 then
				local var_116_34 = (arg_113_1.time_ - var_116_24) / var_116_33

				arg_113_1.fswtw_.percent = Mathf.Lerp(arg_113_1.var_.oldValueTypewriter, var_116_29, var_116_34)
				arg_113_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_113_1.fswtw_:SetDirty()
			end

			if arg_113_1.time_ >= var_116_24 + var_116_33 and arg_113_1.time_ < var_116_24 + var_116_33 + arg_116_0 then
				arg_113_1.fswtw_.percent = var_116_29

				arg_113_1.fswtw_:SetDirty()
				arg_113_1:ShowNextGo(true)

				arg_113_1.typewritterCharCountI18N = var_116_30
			end

			local var_116_35 = 0

			if var_116_35 < arg_113_1.time_ and arg_113_1.time_ <= var_116_35 + arg_116_0 then
				arg_113_1.cswbg_:SetActive(true)

				local var_116_36 = arg_113_1.cswt_:GetComponent("RectTransform")

				arg_113_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_116_36.offsetMin = Vector2.New(410, 330)
				var_116_36.offsetMax = Vector2.New(-400, -175)

				local var_116_37 = arg_113_1:GetWordFromCfg(419028)
				local var_116_38 = arg_113_1:FormatText(var_116_37.content)

				arg_113_1.cswt_.text = var_116_38

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.cswt_)

				arg_113_1.cswt_.fontSize = 180
				arg_113_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_113_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_113_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_116_39 = arg_113_1.actors_["1084ui_story"].transform
			local var_116_40 = 0

			if var_116_40 < arg_113_1.time_ and arg_113_1.time_ <= var_116_40 + arg_116_0 then
				arg_113_1.var_.moveOldPos1084ui_story = var_116_39.localPosition
			end

			local var_116_41 = 0.001

			if var_116_40 <= arg_113_1.time_ and arg_113_1.time_ < var_116_40 + var_116_41 then
				local var_116_42 = (arg_113_1.time_ - var_116_40) / var_116_41
				local var_116_43 = Vector3.New(0, 100, 0)

				var_116_39.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1084ui_story, var_116_43, var_116_42)

				local var_116_44 = manager.ui.mainCamera.transform.position - var_116_39.position

				var_116_39.forward = Vector3.New(var_116_44.x, var_116_44.y, var_116_44.z)

				local var_116_45 = var_116_39.localEulerAngles

				var_116_45.z = 0
				var_116_45.x = 0
				var_116_39.localEulerAngles = var_116_45
			end

			if arg_113_1.time_ >= var_116_40 + var_116_41 and arg_113_1.time_ < var_116_40 + var_116_41 + arg_116_0 then
				var_116_39.localPosition = Vector3.New(0, 100, 0)

				local var_116_46 = manager.ui.mainCamera.transform.position - var_116_39.position

				var_116_39.forward = Vector3.New(var_116_46.x, var_116_46.y, var_116_46.z)

				local var_116_47 = var_116_39.localEulerAngles

				var_116_47.z = 0
				var_116_47.x = 0
				var_116_39.localEulerAngles = var_116_47
			end

			local var_116_48 = 0.366666666666667
			local var_116_49 = 1.333
			local var_116_50 = manager.audio:GetVoiceLength("story_v_out_319521", "319521027", "story_v_out_319521.awb") / 1000

			if var_116_50 > 0 and var_116_49 < var_116_50 and var_116_50 + var_116_48 > arg_113_1.duration_ then
				local var_116_51 = var_116_50

				arg_113_1.duration_ = var_116_50 + var_116_48
			end

			if var_116_48 < arg_113_1.time_ and arg_113_1.time_ <= var_116_48 + arg_116_0 then
				local var_116_52 = "play"
				local var_116_53 = "voice"

				arg_113_1:AudioAction(var_116_52, var_116_53, "story_v_out_319521", "319521027", "story_v_out_319521.awb")
			end

			local var_116_54 = 0
			local var_116_55 = 0.6

			if var_116_54 < arg_113_1.time_ and arg_113_1.time_ <= var_116_54 + arg_116_0 then
				local var_116_56 = "play"
				local var_116_57 = "music"

				arg_113_1:AudioAction(var_116_56, var_116_57, "ui_battle", "ui_battle_stopbgm", "")

				local var_116_58 = ""
				local var_116_59 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_116_59 ~= "" then
					if arg_113_1.bgmTxt_.text ~= var_116_59 and arg_113_1.bgmTxt_.text ~= "" then
						if arg_113_1.bgmTxt2_.text ~= "" then
							arg_113_1.bgmTxt_.text = arg_113_1.bgmTxt2_.text
						end

						arg_113_1.bgmTxt2_.text = var_116_59

						arg_113_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_113_1.bgmTxt_.text = var_116_59
						arg_113_1.bgmTxt2_.text = var_116_59
					end

					if arg_113_1.bgmTimer then
						arg_113_1.bgmTimer:Stop()

						arg_113_1.bgmTimer = nil
					end

					if arg_113_1.settingData.show_music_name == 1 then
						arg_113_1.musicController:SetSelectedState("show")
						arg_113_1.musicAnimator_:Play("open", 0, 0)

						if arg_113_1.settingData.music_time ~= 0 then
							arg_113_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_113_1.settingData.music_time), function()
								if arg_113_1 == nil or isNil(arg_113_1.bgmTxt_) then
									return
								end

								arg_113_1.musicController:SetSelectedState("hide")
								arg_113_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play319521028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 319521028
		arg_118_1.duration_ = 4.87

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play319521029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.fswbg_:SetActive(true)
				arg_118_1.dialog_:SetActive(false)

				arg_118_1.fswtw_.percent = 0

				local var_121_1 = arg_118_1:GetWordFromCfg(319521028)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.fswt_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.fswt_)

				arg_118_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_118_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_118_1.fswtw_:SetDirty()

				arg_118_1.typewritterCharCountI18N = 0

				SetActive(arg_118_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_118_1:ShowNextGo(false)
			end

			local var_121_3 = 0.133333333333333

			if var_121_3 < arg_118_1.time_ and arg_118_1.time_ <= var_121_3 + arg_121_0 then
				arg_118_1.var_.oldValueTypewriter = arg_118_1.fswtw_.percent

				SetActive(arg_118_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_118_1:ShowNextGo(false)
			end

			local var_121_4 = 19
			local var_121_5 = 1.26666666666667
			local var_121_6 = arg_118_1:GetWordFromCfg(319521028)
			local var_121_7 = arg_118_1:FormatText(var_121_6.content)
			local var_121_8, var_121_9 = arg_118_1:GetPercentByPara(var_121_7, 1)

			if var_121_3 < arg_118_1.time_ and arg_118_1.time_ <= var_121_3 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				local var_121_10 = var_121_4 <= 0 and var_121_5 or var_121_5 * ((var_121_9 - arg_118_1.typewritterCharCountI18N) / var_121_4)

				if var_121_10 > 0 and var_121_5 < var_121_10 then
					arg_118_1.talkMaxDuration = var_121_10

					if var_121_10 + var_121_3 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_3
					end
				end
			end

			local var_121_11 = 1.26666666666667
			local var_121_12 = math.max(var_121_11, arg_118_1.talkMaxDuration)

			if var_121_3 <= arg_118_1.time_ and arg_118_1.time_ < var_121_3 + var_121_12 then
				local var_121_13 = (arg_118_1.time_ - var_121_3) / var_121_12

				arg_118_1.fswtw_.percent = Mathf.Lerp(arg_118_1.var_.oldValueTypewriter, var_121_8, var_121_13)
				arg_118_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_118_1.fswtw_:SetDirty()
			end

			if arg_118_1.time_ >= var_121_3 + var_121_12 and arg_118_1.time_ < var_121_3 + var_121_12 + arg_121_0 then
				arg_118_1.fswtw_.percent = var_121_8

				arg_118_1.fswtw_:SetDirty()
				arg_118_1:ShowNextGo(true)

				arg_118_1.typewritterCharCountI18N = var_121_9
			end

			local var_121_14 = 0.133333333333333
			local var_121_15 = 4.733
			local var_121_16 = manager.audio:GetVoiceLength("story_v_out_319521", "319521028", "story_v_out_319521.awb") / 1000

			if var_121_16 > 0 and var_121_15 < var_121_16 and var_121_16 + var_121_14 > arg_118_1.duration_ then
				local var_121_17 = var_121_16

				arg_118_1.duration_ = var_121_16 + var_121_14
			end

			if var_121_14 < arg_118_1.time_ and arg_118_1.time_ <= var_121_14 + arg_121_0 then
				local var_121_18 = "play"
				local var_121_19 = "voice"

				arg_118_1:AudioAction(var_121_18, var_121_19, "story_v_out_319521", "319521028", "story_v_out_319521.awb")
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play319521029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 319521029
		arg_122_1.duration_ = 3.47

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play319521030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				local var_125_1 = manager.ui.mainCamera.transform.localPosition
				local var_125_2 = Vector3.New(0, 0, 10) + Vector3.New(var_125_1.x, var_125_1.y, 0)
				local var_125_3 = arg_122_1.bgs_.I11s

				var_125_3.transform.localPosition = var_125_2
				var_125_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_125_4 = var_125_3:GetComponent("SpriteRenderer")

				if var_125_4 and var_125_4.sprite then
					local var_125_5 = (var_125_3.transform.localPosition - var_125_1).z
					local var_125_6 = manager.ui.mainCameraCom_
					local var_125_7 = 2 * var_125_5 * Mathf.Tan(var_125_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_125_8 = var_125_7 * var_125_6.aspect
					local var_125_9 = var_125_4.sprite.bounds.size.x
					local var_125_10 = var_125_4.sprite.bounds.size.y
					local var_125_11 = var_125_8 / var_125_9
					local var_125_12 = var_125_7 / var_125_10
					local var_125_13 = var_125_12 < var_125_11 and var_125_11 or var_125_12

					var_125_3.transform.localScale = Vector3.New(var_125_13, var_125_13, 0)
				end

				for iter_125_0, iter_125_1 in pairs(arg_122_1.bgs_) do
					if iter_125_0 ~= "I11s" then
						iter_125_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_125_14 = arg_122_1.actors_["1084ui_story"]
			local var_125_15 = 0.9

			if var_125_15 < arg_122_1.time_ and arg_122_1.time_ <= var_125_15 + arg_125_0 and not isNil(var_125_14) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = var_125_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_16 = 0.200000002980232

			if var_125_15 <= arg_122_1.time_ and arg_122_1.time_ < var_125_15 + var_125_16 and not isNil(var_125_14) then
				local var_125_17 = (arg_122_1.time_ - var_125_15) / var_125_16

				if arg_122_1.var_.characterEffect1084ui_story and not isNil(var_125_14) then
					arg_122_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_15 + var_125_16 and arg_122_1.time_ < var_125_15 + var_125_16 + arg_125_0 and not isNil(var_125_14) and arg_122_1.var_.characterEffect1084ui_story then
				arg_122_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_125_18 = 0.9
			local var_125_19 = 0.0666666666666667

			if var_125_18 < arg_122_1.time_ and arg_122_1.time_ <= var_125_18 + arg_125_0 then
				local var_125_20 = "play"
				local var_125_21 = "music"

				arg_122_1:AudioAction(var_125_20, var_125_21, "ui_battle", "ui_battle_stopbgm", "")

				local var_125_22 = ""
				local var_125_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_125_23 ~= "" then
					if arg_122_1.bgmTxt_.text ~= var_125_23 and arg_122_1.bgmTxt_.text ~= "" then
						if arg_122_1.bgmTxt2_.text ~= "" then
							arg_122_1.bgmTxt_.text = arg_122_1.bgmTxt2_.text
						end

						arg_122_1.bgmTxt2_.text = var_125_23

						arg_122_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_122_1.bgmTxt_.text = var_125_23
						arg_122_1.bgmTxt2_.text = var_125_23
					end

					if arg_122_1.bgmTimer then
						arg_122_1.bgmTimer:Stop()

						arg_122_1.bgmTimer = nil
					end

					if arg_122_1.settingData.show_music_name == 1 then
						arg_122_1.musicController:SetSelectedState("show")
						arg_122_1.musicAnimator_:Play("open", 0, 0)

						if arg_122_1.settingData.music_time ~= 0 then
							arg_122_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_122_1.settingData.music_time), function()
								if arg_122_1 == nil or isNil(arg_122_1.bgmTxt_) then
									return
								end

								arg_122_1.musicController:SetSelectedState("hide")
								arg_122_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_125_24 = 1
			local var_125_25 = 1

			if var_125_24 < arg_122_1.time_ and arg_122_1.time_ <= var_125_24 + arg_125_0 then
				local var_125_26 = "play"
				local var_125_27 = "music"

				arg_122_1:AudioAction(var_125_26, var_125_27, "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_125_28 = ""
				local var_125_29 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

				if var_125_29 ~= "" then
					if arg_122_1.bgmTxt_.text ~= var_125_29 and arg_122_1.bgmTxt_.text ~= "" then
						if arg_122_1.bgmTxt2_.text ~= "" then
							arg_122_1.bgmTxt_.text = arg_122_1.bgmTxt2_.text
						end

						arg_122_1.bgmTxt2_.text = var_125_29

						arg_122_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_122_1.bgmTxt_.text = var_125_29
						arg_122_1.bgmTxt2_.text = var_125_29
					end

					if arg_122_1.bgmTimer then
						arg_122_1.bgmTimer:Stop()

						arg_122_1.bgmTimer = nil
					end

					if arg_122_1.settingData.show_music_name == 1 then
						arg_122_1.musicController:SetSelectedState("show")
						arg_122_1.musicAnimator_:Play("open", 0, 0)

						if arg_122_1.settingData.music_time ~= 0 then
							arg_122_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_122_1.settingData.music_time), function()
								if arg_122_1 == nil or isNil(arg_122_1.bgmTxt_) then
									return
								end

								arg_122_1.musicController:SetSelectedState("hide")
								arg_122_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_125_30 = 0

			if var_125_30 < arg_122_1.time_ and arg_122_1.time_ <= var_125_30 + arg_125_0 then
				arg_122_1.fswbg_:SetActive(false)
				arg_122_1.dialog_:SetActive(false)
				SetActive(arg_122_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_122_1:ShowNextGo(false)
			end

			local var_125_31 = 0

			if var_125_31 < arg_122_1.time_ and arg_122_1.time_ <= var_125_31 + arg_125_0 then
				arg_122_1.cswbg_:SetActive(false)
			end

			local var_125_32 = 0.9

			if var_125_32 < arg_122_1.time_ and arg_122_1.time_ <= var_125_32 + arg_125_0 then
				arg_122_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_125_33 = 0.9

			if var_125_33 < arg_122_1.time_ and arg_122_1.time_ <= var_125_33 + arg_125_0 then
				arg_122_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_125_34 = arg_122_1.actors_["1084ui_story"].transform
			local var_125_35 = 0.9

			if var_125_35 < arg_122_1.time_ and arg_122_1.time_ <= var_125_35 + arg_125_0 then
				arg_122_1.var_.moveOldPos1084ui_story = var_125_34.localPosition
			end

			local var_125_36 = 0.001

			if var_125_35 <= arg_122_1.time_ and arg_122_1.time_ < var_125_35 + var_125_36 then
				local var_125_37 = (arg_122_1.time_ - var_125_35) / var_125_36
				local var_125_38 = Vector3.New(0, -0.97, -6)

				var_125_34.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1084ui_story, var_125_38, var_125_37)

				local var_125_39 = manager.ui.mainCamera.transform.position - var_125_34.position

				var_125_34.forward = Vector3.New(var_125_39.x, var_125_39.y, var_125_39.z)

				local var_125_40 = var_125_34.localEulerAngles

				var_125_40.z = 0
				var_125_40.x = 0
				var_125_34.localEulerAngles = var_125_40
			end

			if arg_122_1.time_ >= var_125_35 + var_125_36 and arg_122_1.time_ < var_125_35 + var_125_36 + arg_125_0 then
				var_125_34.localPosition = Vector3.New(0, -0.97, -6)

				local var_125_41 = manager.ui.mainCamera.transform.position - var_125_34.position

				var_125_34.forward = Vector3.New(var_125_41.x, var_125_41.y, var_125_41.z)

				local var_125_42 = var_125_34.localEulerAngles

				var_125_42.z = 0
				var_125_42.x = 0
				var_125_34.localEulerAngles = var_125_42
			end

			if arg_122_1.frameCnt_ <= 1 then
				arg_122_1.dialog_:SetActive(false)
			end

			local var_125_43 = 0.9
			local var_125_44 = 0.175

			if var_125_43 < arg_122_1.time_ and arg_122_1.time_ <= var_125_43 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_45 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_45:setOnUpdate(LuaHelper.FloatAction(function(arg_128_0)
					arg_122_1.dialogCg_.alpha = arg_128_0
				end))
				var_125_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_46 = arg_122_1:FormatText(StoryNameCfg[6].name)

				arg_122_1.leftNameTxt_.text = var_125_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_47 = arg_122_1:GetWordFromCfg(319521029)
				local var_125_48 = arg_122_1:FormatText(var_125_47.content)

				arg_122_1.text_.text = var_125_48

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_49 = 7
				local var_125_50 = utf8.len(var_125_48)
				local var_125_51 = var_125_49 <= 0 and var_125_44 or var_125_44 * (var_125_50 / var_125_49)

				if var_125_51 > 0 and var_125_44 < var_125_51 then
					arg_122_1.talkMaxDuration = var_125_51
					var_125_43 = var_125_43 + 0.3

					if var_125_51 + var_125_43 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_51 + var_125_43
					end
				end

				arg_122_1.text_.text = var_125_48
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521029", "story_v_out_319521.awb") ~= 0 then
					local var_125_52 = manager.audio:GetVoiceLength("story_v_out_319521", "319521029", "story_v_out_319521.awb") / 1000

					if var_125_52 + var_125_43 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_52 + var_125_43
					end

					if var_125_47.prefab_name ~= "" and arg_122_1.actors_[var_125_47.prefab_name] ~= nil then
						local var_125_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_47.prefab_name].transform, "story_v_out_319521", "319521029", "story_v_out_319521.awb")

						arg_122_1:RecordAudio("319521029", var_125_53)
						arg_122_1:RecordAudio("319521029", var_125_53)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_319521", "319521029", "story_v_out_319521.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_319521", "319521029", "story_v_out_319521.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_54 = var_125_43 + 0.3
			local var_125_55 = math.max(var_125_44, arg_122_1.talkMaxDuration)

			if var_125_54 <= arg_122_1.time_ and arg_122_1.time_ < var_125_54 + var_125_55 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_54) / var_125_55

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_54 + var_125_55 and arg_122_1.time_ < var_125_54 + var_125_55 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play319521030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 319521030
		arg_130_1.duration_ = 10.6

		local var_130_0 = {
			zh = 6.2,
			ja = 10.6
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play319521031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = "4040ui_story"

			if arg_130_1.actors_[var_133_0] == nil then
				local var_133_1 = Asset.Load("Char/" .. "4040ui_story")

				if not isNil(var_133_1) then
					local var_133_2 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_130_1.stage_.transform)

					var_133_2.name = var_133_0
					var_133_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_130_1.actors_[var_133_0] = var_133_2

					local var_133_3 = var_133_2:GetComponentInChildren(typeof(CharacterEffect))

					var_133_3.enabled = true

					local var_133_4 = GameObjectTools.GetOrAddComponent(var_133_2, typeof(DynamicBoneHelper))

					if var_133_4 then
						var_133_4:EnableDynamicBone(false)
					end

					arg_130_1:ShowWeapon(var_133_3.transform, false)

					arg_130_1.var_[var_133_0 .. "Animator"] = var_133_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_130_1.var_[var_133_0 .. "Animator"].applyRootMotion = true
					arg_130_1.var_[var_133_0 .. "LipSync"] = var_133_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_133_5 = arg_130_1.actors_["4040ui_story"]
			local var_133_6 = 0

			if var_133_6 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 and not isNil(var_133_5) and arg_130_1.var_.characterEffect4040ui_story == nil then
				arg_130_1.var_.characterEffect4040ui_story = var_133_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_7 = 0.200000002980232

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_7 and not isNil(var_133_5) then
				local var_133_8 = (arg_130_1.time_ - var_133_6) / var_133_7

				if arg_130_1.var_.characterEffect4040ui_story and not isNil(var_133_5) then
					arg_130_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_6 + var_133_7 and arg_130_1.time_ < var_133_6 + var_133_7 + arg_133_0 and not isNil(var_133_5) and arg_130_1.var_.characterEffect4040ui_story then
				arg_130_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_133_9 = arg_130_1.actors_["1084ui_story"]
			local var_133_10 = 0

			if var_133_10 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 and not isNil(var_133_9) and arg_130_1.var_.characterEffect1084ui_story == nil then
				arg_130_1.var_.characterEffect1084ui_story = var_133_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_11 = 0.200000002980232

			if var_133_10 <= arg_130_1.time_ and arg_130_1.time_ < var_133_10 + var_133_11 and not isNil(var_133_9) then
				local var_133_12 = (arg_130_1.time_ - var_133_10) / var_133_11

				if arg_130_1.var_.characterEffect1084ui_story and not isNil(var_133_9) then
					local var_133_13 = Mathf.Lerp(0, 0.5, var_133_12)

					arg_130_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1084ui_story.fillRatio = var_133_13
				end
			end

			if arg_130_1.time_ >= var_133_10 + var_133_11 and arg_130_1.time_ < var_133_10 + var_133_11 + arg_133_0 and not isNil(var_133_9) and arg_130_1.var_.characterEffect1084ui_story then
				local var_133_14 = 0.5

				arg_130_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1084ui_story.fillRatio = var_133_14
			end

			local var_133_15 = arg_130_1.actors_["4040ui_story"].transform
			local var_133_16 = 0

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1.var_.moveOldPos4040ui_story = var_133_15.localPosition
			end

			local var_133_17 = 0.001

			if var_133_16 <= arg_130_1.time_ and arg_130_1.time_ < var_133_16 + var_133_17 then
				local var_133_18 = (arg_130_1.time_ - var_133_16) / var_133_17
				local var_133_19 = Vector3.New(0.7, -1.55, -5.5)

				var_133_15.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos4040ui_story, var_133_19, var_133_18)

				local var_133_20 = manager.ui.mainCamera.transform.position - var_133_15.position

				var_133_15.forward = Vector3.New(var_133_20.x, var_133_20.y, var_133_20.z)

				local var_133_21 = var_133_15.localEulerAngles

				var_133_21.z = 0
				var_133_21.x = 0
				var_133_15.localEulerAngles = var_133_21
			end

			if arg_130_1.time_ >= var_133_16 + var_133_17 and arg_130_1.time_ < var_133_16 + var_133_17 + arg_133_0 then
				var_133_15.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_133_22 = manager.ui.mainCamera.transform.position - var_133_15.position

				var_133_15.forward = Vector3.New(var_133_22.x, var_133_22.y, var_133_22.z)

				local var_133_23 = var_133_15.localEulerAngles

				var_133_23.z = 0
				var_133_23.x = 0
				var_133_15.localEulerAngles = var_133_23
			end

			local var_133_24 = arg_130_1.actors_["1084ui_story"].transform
			local var_133_25 = 0

			if var_133_25 < arg_130_1.time_ and arg_130_1.time_ <= var_133_25 + arg_133_0 then
				arg_130_1.var_.moveOldPos1084ui_story = var_133_24.localPosition
			end

			local var_133_26 = 0.001

			if var_133_25 <= arg_130_1.time_ and arg_130_1.time_ < var_133_25 + var_133_26 then
				local var_133_27 = (arg_130_1.time_ - var_133_25) / var_133_26
				local var_133_28 = Vector3.New(-0.7, -0.97, -6)

				var_133_24.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1084ui_story, var_133_28, var_133_27)

				local var_133_29 = manager.ui.mainCamera.transform.position - var_133_24.position

				var_133_24.forward = Vector3.New(var_133_29.x, var_133_29.y, var_133_29.z)

				local var_133_30 = var_133_24.localEulerAngles

				var_133_30.z = 0
				var_133_30.x = 0
				var_133_24.localEulerAngles = var_133_30
			end

			if arg_130_1.time_ >= var_133_25 + var_133_26 and arg_130_1.time_ < var_133_25 + var_133_26 + arg_133_0 then
				var_133_24.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_133_31 = manager.ui.mainCamera.transform.position - var_133_24.position

				var_133_24.forward = Vector3.New(var_133_31.x, var_133_31.y, var_133_31.z)

				local var_133_32 = var_133_24.localEulerAngles

				var_133_32.z = 0
				var_133_32.x = 0
				var_133_24.localEulerAngles = var_133_32
			end

			local var_133_33 = 0

			if var_133_33 < arg_130_1.time_ and arg_130_1.time_ <= var_133_33 + arg_133_0 then
				arg_130_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_133_34 = 0

			if var_133_34 < arg_130_1.time_ and arg_130_1.time_ <= var_133_34 + arg_133_0 then
				arg_130_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_133_35 = 0
			local var_133_36 = 0.725

			if var_133_35 < arg_130_1.time_ and arg_130_1.time_ <= var_133_35 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_37 = arg_130_1:FormatText(StoryNameCfg[668].name)

				arg_130_1.leftNameTxt_.text = var_133_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_38 = arg_130_1:GetWordFromCfg(319521030)
				local var_133_39 = arg_130_1:FormatText(var_133_38.content)

				arg_130_1.text_.text = var_133_39

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_40 = 29
				local var_133_41 = utf8.len(var_133_39)
				local var_133_42 = var_133_40 <= 0 and var_133_36 or var_133_36 * (var_133_41 / var_133_40)

				if var_133_42 > 0 and var_133_36 < var_133_42 then
					arg_130_1.talkMaxDuration = var_133_42

					if var_133_42 + var_133_35 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_42 + var_133_35
					end
				end

				arg_130_1.text_.text = var_133_39
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521030", "story_v_out_319521.awb") ~= 0 then
					local var_133_43 = manager.audio:GetVoiceLength("story_v_out_319521", "319521030", "story_v_out_319521.awb") / 1000

					if var_133_43 + var_133_35 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_43 + var_133_35
					end

					if var_133_38.prefab_name ~= "" and arg_130_1.actors_[var_133_38.prefab_name] ~= nil then
						local var_133_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_38.prefab_name].transform, "story_v_out_319521", "319521030", "story_v_out_319521.awb")

						arg_130_1:RecordAudio("319521030", var_133_44)
						arg_130_1:RecordAudio("319521030", var_133_44)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_319521", "319521030", "story_v_out_319521.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_319521", "319521030", "story_v_out_319521.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_45 = math.max(var_133_36, arg_130_1.talkMaxDuration)

			if var_133_35 <= arg_130_1.time_ and arg_130_1.time_ < var_133_35 + var_133_45 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_35) / var_133_45

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_35 + var_133_45 and arg_130_1.time_ < var_133_35 + var_133_45 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play319521031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 319521031
		arg_134_1.duration_ = 8.43

		local var_134_0 = {
			zh = 5.066,
			ja = 8.433
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play319521032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 0.625

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_2 = arg_134_1:FormatText(StoryNameCfg[668].name)

				arg_134_1.leftNameTxt_.text = var_137_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_3 = arg_134_1:GetWordFromCfg(319521031)
				local var_137_4 = arg_134_1:FormatText(var_137_3.content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 25
				local var_137_6 = utf8.len(var_137_4)
				local var_137_7 = var_137_5 <= 0 and var_137_1 or var_137_1 * (var_137_6 / var_137_5)

				if var_137_7 > 0 and var_137_1 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_4
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521031", "story_v_out_319521.awb") ~= 0 then
					local var_137_8 = manager.audio:GetVoiceLength("story_v_out_319521", "319521031", "story_v_out_319521.awb") / 1000

					if var_137_8 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_0
					end

					if var_137_3.prefab_name ~= "" and arg_134_1.actors_[var_137_3.prefab_name] ~= nil then
						local var_137_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_3.prefab_name].transform, "story_v_out_319521", "319521031", "story_v_out_319521.awb")

						arg_134_1:RecordAudio("319521031", var_137_9)
						arg_134_1:RecordAudio("319521031", var_137_9)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_319521", "319521031", "story_v_out_319521.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_319521", "319521031", "story_v_out_319521.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_10 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_10 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_10

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_10 and arg_134_1.time_ < var_137_0 + var_137_10 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play319521032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 319521032
		arg_138_1.duration_ = 6.83

		local var_138_0 = {
			zh = 3.666,
			ja = 6.833
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play319521033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["4040ui_story"].transform
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.var_.moveOldPos4040ui_story = var_141_0.localPosition
			end

			local var_141_2 = 0.001

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2
				local var_141_4 = Vector3.New(0.7, -1.55, -5.5)

				var_141_0.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos4040ui_story, var_141_4, var_141_3)

				local var_141_5 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_5.x, var_141_5.y, var_141_5.z)

				local var_141_6 = var_141_0.localEulerAngles

				var_141_6.z = 0
				var_141_6.x = 0
				var_141_0.localEulerAngles = var_141_6
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 then
				var_141_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_141_7 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_7.x, var_141_7.y, var_141_7.z)

				local var_141_8 = var_141_0.localEulerAngles

				var_141_8.z = 0
				var_141_8.x = 0
				var_141_0.localEulerAngles = var_141_8
			end

			local var_141_9 = arg_138_1.actors_["4040ui_story"]
			local var_141_10 = 0

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 and not isNil(var_141_9) and arg_138_1.var_.characterEffect4040ui_story == nil then
				arg_138_1.var_.characterEffect4040ui_story = var_141_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_11 = 0.200000002980232

			if var_141_10 <= arg_138_1.time_ and arg_138_1.time_ < var_141_10 + var_141_11 and not isNil(var_141_9) then
				local var_141_12 = (arg_138_1.time_ - var_141_10) / var_141_11

				if arg_138_1.var_.characterEffect4040ui_story and not isNil(var_141_9) then
					arg_138_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_10 + var_141_11 and arg_138_1.time_ < var_141_10 + var_141_11 + arg_141_0 and not isNil(var_141_9) and arg_138_1.var_.characterEffect4040ui_story then
				arg_138_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_141_13 = 0

			if var_141_13 < arg_138_1.time_ and arg_138_1.time_ <= var_141_13 + arg_141_0 then
				arg_138_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_141_14 = 0

			if var_141_14 < arg_138_1.time_ and arg_138_1.time_ <= var_141_14 + arg_141_0 then
				arg_138_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_141_15 = 0
			local var_141_16 = 0.475

			if var_141_15 < arg_138_1.time_ and arg_138_1.time_ <= var_141_15 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_17 = arg_138_1:FormatText(StoryNameCfg[668].name)

				arg_138_1.leftNameTxt_.text = var_141_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_18 = arg_138_1:GetWordFromCfg(319521032)
				local var_141_19 = arg_138_1:FormatText(var_141_18.content)

				arg_138_1.text_.text = var_141_19

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_20 = 19
				local var_141_21 = utf8.len(var_141_19)
				local var_141_22 = var_141_20 <= 0 and var_141_16 or var_141_16 * (var_141_21 / var_141_20)

				if var_141_22 > 0 and var_141_16 < var_141_22 then
					arg_138_1.talkMaxDuration = var_141_22

					if var_141_22 + var_141_15 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_22 + var_141_15
					end
				end

				arg_138_1.text_.text = var_141_19
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521032", "story_v_out_319521.awb") ~= 0 then
					local var_141_23 = manager.audio:GetVoiceLength("story_v_out_319521", "319521032", "story_v_out_319521.awb") / 1000

					if var_141_23 + var_141_15 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_23 + var_141_15
					end

					if var_141_18.prefab_name ~= "" and arg_138_1.actors_[var_141_18.prefab_name] ~= nil then
						local var_141_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_18.prefab_name].transform, "story_v_out_319521", "319521032", "story_v_out_319521.awb")

						arg_138_1:RecordAudio("319521032", var_141_24)
						arg_138_1:RecordAudio("319521032", var_141_24)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_319521", "319521032", "story_v_out_319521.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_319521", "319521032", "story_v_out_319521.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_25 = math.max(var_141_16, arg_138_1.talkMaxDuration)

			if var_141_15 <= arg_138_1.time_ and arg_138_1.time_ < var_141_15 + var_141_25 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_15) / var_141_25

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_15 + var_141_25 and arg_138_1.time_ < var_141_15 + var_141_25 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play319521033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 319521033
		arg_142_1.duration_ = 12.13

		local var_142_0 = {
			zh = 5,
			ja = 12.133
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play319521034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1084ui_story"].transform
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.var_.moveOldPos1084ui_story = var_145_0.localPosition
			end

			local var_145_2 = 0.001

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2
				local var_145_4 = Vector3.New(-0.7, -0.97, -6)

				var_145_0.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1084ui_story, var_145_4, var_145_3)

				local var_145_5 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_5.x, var_145_5.y, var_145_5.z)

				local var_145_6 = var_145_0.localEulerAngles

				var_145_6.z = 0
				var_145_6.x = 0
				var_145_0.localEulerAngles = var_145_6
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 then
				var_145_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_145_7 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_7.x, var_145_7.y, var_145_7.z)

				local var_145_8 = var_145_0.localEulerAngles

				var_145_8.z = 0
				var_145_8.x = 0
				var_145_0.localEulerAngles = var_145_8
			end

			local var_145_9 = arg_142_1.actors_["1084ui_story"]
			local var_145_10 = 0

			if var_145_10 < arg_142_1.time_ and arg_142_1.time_ <= var_145_10 + arg_145_0 and not isNil(var_145_9) and arg_142_1.var_.characterEffect1084ui_story == nil then
				arg_142_1.var_.characterEffect1084ui_story = var_145_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_11 = 0.200000002980232

			if var_145_10 <= arg_142_1.time_ and arg_142_1.time_ < var_145_10 + var_145_11 and not isNil(var_145_9) then
				local var_145_12 = (arg_142_1.time_ - var_145_10) / var_145_11

				if arg_142_1.var_.characterEffect1084ui_story and not isNil(var_145_9) then
					arg_142_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_10 + var_145_11 and arg_142_1.time_ < var_145_10 + var_145_11 + arg_145_0 and not isNil(var_145_9) and arg_142_1.var_.characterEffect1084ui_story then
				arg_142_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_145_13 = 0

			if var_145_13 < arg_142_1.time_ and arg_142_1.time_ <= var_145_13 + arg_145_0 then
				arg_142_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_145_14 = 0

			if var_145_14 < arg_142_1.time_ and arg_142_1.time_ <= var_145_14 + arg_145_0 then
				arg_142_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_145_15 = arg_142_1.actors_["4040ui_story"]
			local var_145_16 = 0

			if var_145_16 < arg_142_1.time_ and arg_142_1.time_ <= var_145_16 + arg_145_0 and not isNil(var_145_15) and arg_142_1.var_.characterEffect4040ui_story == nil then
				arg_142_1.var_.characterEffect4040ui_story = var_145_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_17 = 0.200000002980232

			if var_145_16 <= arg_142_1.time_ and arg_142_1.time_ < var_145_16 + var_145_17 and not isNil(var_145_15) then
				local var_145_18 = (arg_142_1.time_ - var_145_16) / var_145_17

				if arg_142_1.var_.characterEffect4040ui_story and not isNil(var_145_15) then
					local var_145_19 = Mathf.Lerp(0, 0.5, var_145_18)

					arg_142_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_142_1.var_.characterEffect4040ui_story.fillRatio = var_145_19
				end
			end

			if arg_142_1.time_ >= var_145_16 + var_145_17 and arg_142_1.time_ < var_145_16 + var_145_17 + arg_145_0 and not isNil(var_145_15) and arg_142_1.var_.characterEffect4040ui_story then
				local var_145_20 = 0.5

				arg_142_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_142_1.var_.characterEffect4040ui_story.fillRatio = var_145_20
			end

			local var_145_21 = 0
			local var_145_22 = 0.6

			if var_145_21 < arg_142_1.time_ and arg_142_1.time_ <= var_145_21 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_23 = arg_142_1:FormatText(StoryNameCfg[6].name)

				arg_142_1.leftNameTxt_.text = var_145_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_24 = arg_142_1:GetWordFromCfg(319521033)
				local var_145_25 = arg_142_1:FormatText(var_145_24.content)

				arg_142_1.text_.text = var_145_25

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_26 = 24
				local var_145_27 = utf8.len(var_145_25)
				local var_145_28 = var_145_26 <= 0 and var_145_22 or var_145_22 * (var_145_27 / var_145_26)

				if var_145_28 > 0 and var_145_22 < var_145_28 then
					arg_142_1.talkMaxDuration = var_145_28

					if var_145_28 + var_145_21 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_28 + var_145_21
					end
				end

				arg_142_1.text_.text = var_145_25
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521033", "story_v_out_319521.awb") ~= 0 then
					local var_145_29 = manager.audio:GetVoiceLength("story_v_out_319521", "319521033", "story_v_out_319521.awb") / 1000

					if var_145_29 + var_145_21 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_29 + var_145_21
					end

					if var_145_24.prefab_name ~= "" and arg_142_1.actors_[var_145_24.prefab_name] ~= nil then
						local var_145_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_24.prefab_name].transform, "story_v_out_319521", "319521033", "story_v_out_319521.awb")

						arg_142_1:RecordAudio("319521033", var_145_30)
						arg_142_1:RecordAudio("319521033", var_145_30)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_319521", "319521033", "story_v_out_319521.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_319521", "319521033", "story_v_out_319521.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_31 = math.max(var_145_22, arg_142_1.talkMaxDuration)

			if var_145_21 <= arg_142_1.time_ and arg_142_1.time_ < var_145_21 + var_145_31 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_21) / var_145_31

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_21 + var_145_31 and arg_142_1.time_ < var_145_21 + var_145_31 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
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

		arg_142_1:InitPlayNodeList()
	end,
	Play319521034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 319521034
		arg_146_1.duration_ = 3.5

		local var_146_0 = {
			zh = 1.566,
			ja = 3.5
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play319521035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1084ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1084ui_story == nil then
				arg_146_1.var_.characterEffect1084ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1084ui_story and not isNil(var_149_0) then
					local var_149_4 = Mathf.Lerp(0, 0.5, var_149_3)

					arg_146_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1084ui_story.fillRatio = var_149_4
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1084ui_story then
				local var_149_5 = 0.5

				arg_146_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1084ui_story.fillRatio = var_149_5
			end

			local var_149_6 = arg_146_1.actors_["4040ui_story"]
			local var_149_7 = 0

			if var_149_7 < arg_146_1.time_ and arg_146_1.time_ <= var_149_7 + arg_149_0 and not isNil(var_149_6) and arg_146_1.var_.characterEffect4040ui_story == nil then
				arg_146_1.var_.characterEffect4040ui_story = var_149_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_8 = 0.200000002980232

			if var_149_7 <= arg_146_1.time_ and arg_146_1.time_ < var_149_7 + var_149_8 and not isNil(var_149_6) then
				local var_149_9 = (arg_146_1.time_ - var_149_7) / var_149_8

				if arg_146_1.var_.characterEffect4040ui_story and not isNil(var_149_6) then
					arg_146_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_7 + var_149_8 and arg_146_1.time_ < var_149_7 + var_149_8 + arg_149_0 and not isNil(var_149_6) and arg_146_1.var_.characterEffect4040ui_story then
				arg_146_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_149_10 = 0
			local var_149_11 = 0.2

			if var_149_10 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_12 = arg_146_1:FormatText(StoryNameCfg[668].name)

				arg_146_1.leftNameTxt_.text = var_149_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_13 = arg_146_1:GetWordFromCfg(319521034)
				local var_149_14 = arg_146_1:FormatText(var_149_13.content)

				arg_146_1.text_.text = var_149_14

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_15 = 8
				local var_149_16 = utf8.len(var_149_14)
				local var_149_17 = var_149_15 <= 0 and var_149_11 or var_149_11 * (var_149_16 / var_149_15)

				if var_149_17 > 0 and var_149_11 < var_149_17 then
					arg_146_1.talkMaxDuration = var_149_17

					if var_149_17 + var_149_10 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_17 + var_149_10
					end
				end

				arg_146_1.text_.text = var_149_14
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521034", "story_v_out_319521.awb") ~= 0 then
					local var_149_18 = manager.audio:GetVoiceLength("story_v_out_319521", "319521034", "story_v_out_319521.awb") / 1000

					if var_149_18 + var_149_10 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_18 + var_149_10
					end

					if var_149_13.prefab_name ~= "" and arg_146_1.actors_[var_149_13.prefab_name] ~= nil then
						local var_149_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_13.prefab_name].transform, "story_v_out_319521", "319521034", "story_v_out_319521.awb")

						arg_146_1:RecordAudio("319521034", var_149_19)
						arg_146_1:RecordAudio("319521034", var_149_19)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_319521", "319521034", "story_v_out_319521.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_319521", "319521034", "story_v_out_319521.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_20 = math.max(var_149_11, arg_146_1.talkMaxDuration)

			if var_149_10 <= arg_146_1.time_ and arg_146_1.time_ < var_149_10 + var_149_20 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_10) / var_149_20

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_10 + var_149_20 and arg_146_1.time_ < var_149_10 + var_149_20 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play319521035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 319521035
		arg_150_1.duration_ = 2

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play319521036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["4040ui_story"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect4040ui_story == nil then
				arg_150_1.var_.characterEffect4040ui_story = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.200000002980232

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect4040ui_story and not isNil(var_153_0) then
					local var_153_4 = Mathf.Lerp(0, 0.5, var_153_3)

					arg_150_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_150_1.var_.characterEffect4040ui_story.fillRatio = var_153_4
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect4040ui_story then
				local var_153_5 = 0.5

				arg_150_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_150_1.var_.characterEffect4040ui_story.fillRatio = var_153_5
			end

			local var_153_6 = arg_150_1.actors_["1084ui_story"]
			local var_153_7 = 0

			if var_153_7 < arg_150_1.time_ and arg_150_1.time_ <= var_153_7 + arg_153_0 and not isNil(var_153_6) and arg_150_1.var_.characterEffect1084ui_story == nil then
				arg_150_1.var_.characterEffect1084ui_story = var_153_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_8 = 0.200000002980232

			if var_153_7 <= arg_150_1.time_ and arg_150_1.time_ < var_153_7 + var_153_8 and not isNil(var_153_6) then
				local var_153_9 = (arg_150_1.time_ - var_153_7) / var_153_8

				if arg_150_1.var_.characterEffect1084ui_story and not isNil(var_153_6) then
					arg_150_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_7 + var_153_8 and arg_150_1.time_ < var_153_7 + var_153_8 + arg_153_0 and not isNil(var_153_6) and arg_150_1.var_.characterEffect1084ui_story then
				arg_150_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_153_10 = 0

			if var_153_10 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 then
				arg_150_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_153_11 = 0
			local var_153_12 = 0.05

			if var_153_11 < arg_150_1.time_ and arg_150_1.time_ <= var_153_11 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_13 = arg_150_1:FormatText(StoryNameCfg[6].name)

				arg_150_1.leftNameTxt_.text = var_153_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_14 = arg_150_1:GetWordFromCfg(319521035)
				local var_153_15 = arg_150_1:FormatText(var_153_14.content)

				arg_150_1.text_.text = var_153_15

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_16 = 2
				local var_153_17 = utf8.len(var_153_15)
				local var_153_18 = var_153_16 <= 0 and var_153_12 or var_153_12 * (var_153_17 / var_153_16)

				if var_153_18 > 0 and var_153_12 < var_153_18 then
					arg_150_1.talkMaxDuration = var_153_18

					if var_153_18 + var_153_11 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_18 + var_153_11
					end
				end

				arg_150_1.text_.text = var_153_15
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521035", "story_v_out_319521.awb") ~= 0 then
					local var_153_19 = manager.audio:GetVoiceLength("story_v_out_319521", "319521035", "story_v_out_319521.awb") / 1000

					if var_153_19 + var_153_11 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_19 + var_153_11
					end

					if var_153_14.prefab_name ~= "" and arg_150_1.actors_[var_153_14.prefab_name] ~= nil then
						local var_153_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_14.prefab_name].transform, "story_v_out_319521", "319521035", "story_v_out_319521.awb")

						arg_150_1:RecordAudio("319521035", var_153_20)
						arg_150_1:RecordAudio("319521035", var_153_20)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_319521", "319521035", "story_v_out_319521.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_319521", "319521035", "story_v_out_319521.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_21 = math.max(var_153_12, arg_150_1.talkMaxDuration)

			if var_153_11 <= arg_150_1.time_ and arg_150_1.time_ < var_153_11 + var_153_21 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_11) / var_153_21

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_11 + var_153_21 and arg_150_1.time_ < var_153_11 + var_153_21 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play319521036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 319521036
		arg_154_1.duration_ = 5.23

		local var_154_0 = {
			zh = 3.133,
			ja = 5.233
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play319521037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["4040ui_story"].transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPos4040ui_story = var_157_0.localPosition
			end

			local var_157_2 = 0.001

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2
				local var_157_4 = Vector3.New(0.7, -1.55, -5.5)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos4040ui_story, var_157_4, var_157_3)

				local var_157_5 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_5.x, var_157_5.y, var_157_5.z)

				local var_157_6 = var_157_0.localEulerAngles

				var_157_6.z = 0
				var_157_6.x = 0
				var_157_0.localEulerAngles = var_157_6
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_157_7 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_7.x, var_157_7.y, var_157_7.z)

				local var_157_8 = var_157_0.localEulerAngles

				var_157_8.z = 0
				var_157_8.x = 0
				var_157_0.localEulerAngles = var_157_8
			end

			local var_157_9 = arg_154_1.actors_["4040ui_story"]
			local var_157_10 = 0

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect4040ui_story == nil then
				arg_154_1.var_.characterEffect4040ui_story = var_157_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_11 = 0.200000002980232

			if var_157_10 <= arg_154_1.time_ and arg_154_1.time_ < var_157_10 + var_157_11 and not isNil(var_157_9) then
				local var_157_12 = (arg_154_1.time_ - var_157_10) / var_157_11

				if arg_154_1.var_.characterEffect4040ui_story and not isNil(var_157_9) then
					arg_154_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_10 + var_157_11 and arg_154_1.time_ < var_157_10 + var_157_11 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect4040ui_story then
				arg_154_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_157_13 = 0

			if var_157_13 < arg_154_1.time_ and arg_154_1.time_ <= var_157_13 + arg_157_0 then
				arg_154_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_157_14 = 0

			if var_157_14 < arg_154_1.time_ and arg_154_1.time_ <= var_157_14 + arg_157_0 then
				arg_154_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_157_15 = arg_154_1.actors_["1084ui_story"]
			local var_157_16 = 0

			if var_157_16 < arg_154_1.time_ and arg_154_1.time_ <= var_157_16 + arg_157_0 and not isNil(var_157_15) and arg_154_1.var_.characterEffect1084ui_story == nil then
				arg_154_1.var_.characterEffect1084ui_story = var_157_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_17 = 0.200000002980232

			if var_157_16 <= arg_154_1.time_ and arg_154_1.time_ < var_157_16 + var_157_17 and not isNil(var_157_15) then
				local var_157_18 = (arg_154_1.time_ - var_157_16) / var_157_17

				if arg_154_1.var_.characterEffect1084ui_story and not isNil(var_157_15) then
					local var_157_19 = Mathf.Lerp(0, 0.5, var_157_18)

					arg_154_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1084ui_story.fillRatio = var_157_19
				end
			end

			if arg_154_1.time_ >= var_157_16 + var_157_17 and arg_154_1.time_ < var_157_16 + var_157_17 + arg_157_0 and not isNil(var_157_15) and arg_154_1.var_.characterEffect1084ui_story then
				local var_157_20 = 0.5

				arg_154_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1084ui_story.fillRatio = var_157_20
			end

			local var_157_21 = 0
			local var_157_22 = 0.325

			if var_157_21 < arg_154_1.time_ and arg_154_1.time_ <= var_157_21 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_23 = arg_154_1:FormatText(StoryNameCfg[668].name)

				arg_154_1.leftNameTxt_.text = var_157_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_24 = arg_154_1:GetWordFromCfg(319521036)
				local var_157_25 = arg_154_1:FormatText(var_157_24.content)

				arg_154_1.text_.text = var_157_25

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_26 = 13
				local var_157_27 = utf8.len(var_157_25)
				local var_157_28 = var_157_26 <= 0 and var_157_22 or var_157_22 * (var_157_27 / var_157_26)

				if var_157_28 > 0 and var_157_22 < var_157_28 then
					arg_154_1.talkMaxDuration = var_157_28

					if var_157_28 + var_157_21 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_28 + var_157_21
					end
				end

				arg_154_1.text_.text = var_157_25
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521036", "story_v_out_319521.awb") ~= 0 then
					local var_157_29 = manager.audio:GetVoiceLength("story_v_out_319521", "319521036", "story_v_out_319521.awb") / 1000

					if var_157_29 + var_157_21 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_29 + var_157_21
					end

					if var_157_24.prefab_name ~= "" and arg_154_1.actors_[var_157_24.prefab_name] ~= nil then
						local var_157_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_24.prefab_name].transform, "story_v_out_319521", "319521036", "story_v_out_319521.awb")

						arg_154_1:RecordAudio("319521036", var_157_30)
						arg_154_1:RecordAudio("319521036", var_157_30)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_319521", "319521036", "story_v_out_319521.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_319521", "319521036", "story_v_out_319521.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_31 = math.max(var_157_22, arg_154_1.talkMaxDuration)

			if var_157_21 <= arg_154_1.time_ and arg_154_1.time_ < var_157_21 + var_157_31 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_21) / var_157_31

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_21 + var_157_31 and arg_154_1.time_ < var_157_21 + var_157_31 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play319521037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 319521037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play319521038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["4040ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect4040ui_story == nil then
				arg_158_1.var_.characterEffect4040ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect4040ui_story and not isNil(var_161_0) then
					local var_161_4 = Mathf.Lerp(0, 0.5, var_161_3)

					arg_158_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_158_1.var_.characterEffect4040ui_story.fillRatio = var_161_4
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect4040ui_story then
				local var_161_5 = 0.5

				arg_158_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_158_1.var_.characterEffect4040ui_story.fillRatio = var_161_5
			end

			local var_161_6 = 0
			local var_161_7 = 1

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_8 = arg_158_1:GetWordFromCfg(319521037)
				local var_161_9 = arg_158_1:FormatText(var_161_8.content)

				arg_158_1.text_.text = var_161_9

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_10 = 40
				local var_161_11 = utf8.len(var_161_9)
				local var_161_12 = var_161_10 <= 0 and var_161_7 or var_161_7 * (var_161_11 / var_161_10)

				if var_161_12 > 0 and var_161_7 < var_161_12 then
					arg_158_1.talkMaxDuration = var_161_12

					if var_161_12 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_12 + var_161_6
					end
				end

				arg_158_1.text_.text = var_161_9
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_13 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_13 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_13

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_13 and arg_158_1.time_ < var_161_6 + var_161_13 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play319521038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 319521038
		arg_162_1.duration_ = 7.27

		local var_162_0 = {
			zh = 6.366,
			ja = 7.266
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play319521039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["4040ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect4040ui_story == nil then
				arg_162_1.var_.characterEffect4040ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect4040ui_story and not isNil(var_165_0) then
					arg_162_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect4040ui_story then
				arg_162_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_165_4 = 0

			if var_165_4 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_165_5 = 0

			if var_165_5 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 then
				arg_162_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_165_6 = 0
			local var_165_7 = 0.625

			if var_165_6 < arg_162_1.time_ and arg_162_1.time_ <= var_165_6 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_8 = arg_162_1:FormatText(StoryNameCfg[668].name)

				arg_162_1.leftNameTxt_.text = var_165_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_9 = arg_162_1:GetWordFromCfg(319521038)
				local var_165_10 = arg_162_1:FormatText(var_165_9.content)

				arg_162_1.text_.text = var_165_10

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_11 = 25
				local var_165_12 = utf8.len(var_165_10)
				local var_165_13 = var_165_11 <= 0 and var_165_7 or var_165_7 * (var_165_12 / var_165_11)

				if var_165_13 > 0 and var_165_7 < var_165_13 then
					arg_162_1.talkMaxDuration = var_165_13

					if var_165_13 + var_165_6 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_13 + var_165_6
					end
				end

				arg_162_1.text_.text = var_165_10
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521038", "story_v_out_319521.awb") ~= 0 then
					local var_165_14 = manager.audio:GetVoiceLength("story_v_out_319521", "319521038", "story_v_out_319521.awb") / 1000

					if var_165_14 + var_165_6 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_14 + var_165_6
					end

					if var_165_9.prefab_name ~= "" and arg_162_1.actors_[var_165_9.prefab_name] ~= nil then
						local var_165_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_9.prefab_name].transform, "story_v_out_319521", "319521038", "story_v_out_319521.awb")

						arg_162_1:RecordAudio("319521038", var_165_15)
						arg_162_1:RecordAudio("319521038", var_165_15)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_319521", "319521038", "story_v_out_319521.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_319521", "319521038", "story_v_out_319521.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_16 = math.max(var_165_7, arg_162_1.talkMaxDuration)

			if var_165_6 <= arg_162_1.time_ and arg_162_1.time_ < var_165_6 + var_165_16 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_6) / var_165_16

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_6 + var_165_16 and arg_162_1.time_ < var_165_6 + var_165_16 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play319521039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 319521039
		arg_166_1.duration_ = 5.73

		local var_166_0 = {
			zh = 3.666,
			ja = 5.733
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play319521040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 0.375

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_2 = arg_166_1:FormatText(StoryNameCfg[668].name)

				arg_166_1.leftNameTxt_.text = var_169_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_3 = arg_166_1:GetWordFromCfg(319521039)
				local var_169_4 = arg_166_1:FormatText(var_169_3.content)

				arg_166_1.text_.text = var_169_4

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 15
				local var_169_6 = utf8.len(var_169_4)
				local var_169_7 = var_169_5 <= 0 and var_169_1 or var_169_1 * (var_169_6 / var_169_5)

				if var_169_7 > 0 and var_169_1 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_4
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521039", "story_v_out_319521.awb") ~= 0 then
					local var_169_8 = manager.audio:GetVoiceLength("story_v_out_319521", "319521039", "story_v_out_319521.awb") / 1000

					if var_169_8 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_8 + var_169_0
					end

					if var_169_3.prefab_name ~= "" and arg_166_1.actors_[var_169_3.prefab_name] ~= nil then
						local var_169_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_3.prefab_name].transform, "story_v_out_319521", "319521039", "story_v_out_319521.awb")

						arg_166_1:RecordAudio("319521039", var_169_9)
						arg_166_1:RecordAudio("319521039", var_169_9)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_319521", "319521039", "story_v_out_319521.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_319521", "319521039", "story_v_out_319521.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_10 and arg_166_1.time_ < var_169_0 + var_169_10 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play319521040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 319521040
		arg_170_1.duration_ = 6.63

		local var_170_0 = {
			zh = 2.533,
			ja = 6.633
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play319521041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1084ui_story"].transform
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.var_.moveOldPos1084ui_story = var_173_0.localPosition
			end

			local var_173_2 = 0.001

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2
				local var_173_4 = Vector3.New(-0.7, -0.97, -6)

				var_173_0.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1084ui_story, var_173_4, var_173_3)

				local var_173_5 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_5.x, var_173_5.y, var_173_5.z)

				local var_173_6 = var_173_0.localEulerAngles

				var_173_6.z = 0
				var_173_6.x = 0
				var_173_0.localEulerAngles = var_173_6
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 then
				var_173_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_173_7 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_7.x, var_173_7.y, var_173_7.z)

				local var_173_8 = var_173_0.localEulerAngles

				var_173_8.z = 0
				var_173_8.x = 0
				var_173_0.localEulerAngles = var_173_8
			end

			local var_173_9 = arg_170_1.actors_["1084ui_story"]
			local var_173_10 = 0

			if var_173_10 < arg_170_1.time_ and arg_170_1.time_ <= var_173_10 + arg_173_0 and not isNil(var_173_9) and arg_170_1.var_.characterEffect1084ui_story == nil then
				arg_170_1.var_.characterEffect1084ui_story = var_173_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_11 = 0.200000002980232

			if var_173_10 <= arg_170_1.time_ and arg_170_1.time_ < var_173_10 + var_173_11 and not isNil(var_173_9) then
				local var_173_12 = (arg_170_1.time_ - var_173_10) / var_173_11

				if arg_170_1.var_.characterEffect1084ui_story and not isNil(var_173_9) then
					arg_170_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_10 + var_173_11 and arg_170_1.time_ < var_173_10 + var_173_11 + arg_173_0 and not isNil(var_173_9) and arg_170_1.var_.characterEffect1084ui_story then
				arg_170_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_173_13 = 0

			if var_173_13 < arg_170_1.time_ and arg_170_1.time_ <= var_173_13 + arg_173_0 then
				arg_170_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_173_14 = 0

			if var_173_14 < arg_170_1.time_ and arg_170_1.time_ <= var_173_14 + arg_173_0 then
				arg_170_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_173_15 = arg_170_1.actors_["4040ui_story"]
			local var_173_16 = 0

			if var_173_16 < arg_170_1.time_ and arg_170_1.time_ <= var_173_16 + arg_173_0 and not isNil(var_173_15) and arg_170_1.var_.characterEffect4040ui_story == nil then
				arg_170_1.var_.characterEffect4040ui_story = var_173_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_17 = 0.200000002980232

			if var_173_16 <= arg_170_1.time_ and arg_170_1.time_ < var_173_16 + var_173_17 and not isNil(var_173_15) then
				local var_173_18 = (arg_170_1.time_ - var_173_16) / var_173_17

				if arg_170_1.var_.characterEffect4040ui_story and not isNil(var_173_15) then
					local var_173_19 = Mathf.Lerp(0, 0.5, var_173_18)

					arg_170_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_170_1.var_.characterEffect4040ui_story.fillRatio = var_173_19
				end
			end

			if arg_170_1.time_ >= var_173_16 + var_173_17 and arg_170_1.time_ < var_173_16 + var_173_17 + arg_173_0 and not isNil(var_173_15) and arg_170_1.var_.characterEffect4040ui_story then
				local var_173_20 = 0.5

				arg_170_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_170_1.var_.characterEffect4040ui_story.fillRatio = var_173_20
			end

			local var_173_21 = 0
			local var_173_22 = 0.3

			if var_173_21 < arg_170_1.time_ and arg_170_1.time_ <= var_173_21 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_23 = arg_170_1:FormatText(StoryNameCfg[6].name)

				arg_170_1.leftNameTxt_.text = var_173_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_24 = arg_170_1:GetWordFromCfg(319521040)
				local var_173_25 = arg_170_1:FormatText(var_173_24.content)

				arg_170_1.text_.text = var_173_25

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_26 = 12
				local var_173_27 = utf8.len(var_173_25)
				local var_173_28 = var_173_26 <= 0 and var_173_22 or var_173_22 * (var_173_27 / var_173_26)

				if var_173_28 > 0 and var_173_22 < var_173_28 then
					arg_170_1.talkMaxDuration = var_173_28

					if var_173_28 + var_173_21 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_28 + var_173_21
					end
				end

				arg_170_1.text_.text = var_173_25
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521040", "story_v_out_319521.awb") ~= 0 then
					local var_173_29 = manager.audio:GetVoiceLength("story_v_out_319521", "319521040", "story_v_out_319521.awb") / 1000

					if var_173_29 + var_173_21 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_29 + var_173_21
					end

					if var_173_24.prefab_name ~= "" and arg_170_1.actors_[var_173_24.prefab_name] ~= nil then
						local var_173_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_24.prefab_name].transform, "story_v_out_319521", "319521040", "story_v_out_319521.awb")

						arg_170_1:RecordAudio("319521040", var_173_30)
						arg_170_1:RecordAudio("319521040", var_173_30)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_319521", "319521040", "story_v_out_319521.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_319521", "319521040", "story_v_out_319521.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_31 = math.max(var_173_22, arg_170_1.talkMaxDuration)

			if var_173_21 <= arg_170_1.time_ and arg_170_1.time_ < var_173_21 + var_173_31 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_21) / var_173_31

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_21 + var_173_31 and arg_170_1.time_ < var_173_21 + var_173_31 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
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

		arg_170_1:InitPlayNodeList()
	end,
	Play319521041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 319521041
		arg_174_1.duration_ = 5.83

		local var_174_0 = {
			zh = 5.833,
			ja = 5.4
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play319521042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["4040ui_story"].transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPos4040ui_story = var_177_0.localPosition
			end

			local var_177_2 = 0.001

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2
				local var_177_4 = Vector3.New(0.7, -1.55, -5.5)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos4040ui_story, var_177_4, var_177_3)

				local var_177_5 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_5.x, var_177_5.y, var_177_5.z)

				local var_177_6 = var_177_0.localEulerAngles

				var_177_6.z = 0
				var_177_6.x = 0
				var_177_0.localEulerAngles = var_177_6
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_177_7 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_7.x, var_177_7.y, var_177_7.z)

				local var_177_8 = var_177_0.localEulerAngles

				var_177_8.z = 0
				var_177_8.x = 0
				var_177_0.localEulerAngles = var_177_8
			end

			local var_177_9 = arg_174_1.actors_["4040ui_story"]
			local var_177_10 = 0

			if var_177_10 < arg_174_1.time_ and arg_174_1.time_ <= var_177_10 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect4040ui_story == nil then
				arg_174_1.var_.characterEffect4040ui_story = var_177_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_11 = 0.200000002980232

			if var_177_10 <= arg_174_1.time_ and arg_174_1.time_ < var_177_10 + var_177_11 and not isNil(var_177_9) then
				local var_177_12 = (arg_174_1.time_ - var_177_10) / var_177_11

				if arg_174_1.var_.characterEffect4040ui_story and not isNil(var_177_9) then
					arg_174_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= var_177_10 + var_177_11 and arg_174_1.time_ < var_177_10 + var_177_11 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect4040ui_story then
				arg_174_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_177_13 = 0

			if var_177_13 < arg_174_1.time_ and arg_174_1.time_ <= var_177_13 + arg_177_0 then
				arg_174_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			local var_177_14 = 0

			if var_177_14 < arg_174_1.time_ and arg_174_1.time_ <= var_177_14 + arg_177_0 then
				arg_174_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_177_15 = arg_174_1.actors_["1084ui_story"]
			local var_177_16 = 0

			if var_177_16 < arg_174_1.time_ and arg_174_1.time_ <= var_177_16 + arg_177_0 and not isNil(var_177_15) and arg_174_1.var_.characterEffect1084ui_story == nil then
				arg_174_1.var_.characterEffect1084ui_story = var_177_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_17 = 0.200000002980232

			if var_177_16 <= arg_174_1.time_ and arg_174_1.time_ < var_177_16 + var_177_17 and not isNil(var_177_15) then
				local var_177_18 = (arg_174_1.time_ - var_177_16) / var_177_17

				if arg_174_1.var_.characterEffect1084ui_story and not isNil(var_177_15) then
					local var_177_19 = Mathf.Lerp(0, 0.5, var_177_18)

					arg_174_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1084ui_story.fillRatio = var_177_19
				end
			end

			if arg_174_1.time_ >= var_177_16 + var_177_17 and arg_174_1.time_ < var_177_16 + var_177_17 + arg_177_0 and not isNil(var_177_15) and arg_174_1.var_.characterEffect1084ui_story then
				local var_177_20 = 0.5

				arg_174_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1084ui_story.fillRatio = var_177_20
			end

			local var_177_21 = 0
			local var_177_22 = 0.7

			if var_177_21 < arg_174_1.time_ and arg_174_1.time_ <= var_177_21 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_23 = arg_174_1:FormatText(StoryNameCfg[668].name)

				arg_174_1.leftNameTxt_.text = var_177_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_24 = arg_174_1:GetWordFromCfg(319521041)
				local var_177_25 = arg_174_1:FormatText(var_177_24.content)

				arg_174_1.text_.text = var_177_25

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_26 = 28
				local var_177_27 = utf8.len(var_177_25)
				local var_177_28 = var_177_26 <= 0 and var_177_22 or var_177_22 * (var_177_27 / var_177_26)

				if var_177_28 > 0 and var_177_22 < var_177_28 then
					arg_174_1.talkMaxDuration = var_177_28

					if var_177_28 + var_177_21 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_28 + var_177_21
					end
				end

				arg_174_1.text_.text = var_177_25
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521041", "story_v_out_319521.awb") ~= 0 then
					local var_177_29 = manager.audio:GetVoiceLength("story_v_out_319521", "319521041", "story_v_out_319521.awb") / 1000

					if var_177_29 + var_177_21 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_29 + var_177_21
					end

					if var_177_24.prefab_name ~= "" and arg_174_1.actors_[var_177_24.prefab_name] ~= nil then
						local var_177_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_24.prefab_name].transform, "story_v_out_319521", "319521041", "story_v_out_319521.awb")

						arg_174_1:RecordAudio("319521041", var_177_30)
						arg_174_1:RecordAudio("319521041", var_177_30)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_319521", "319521041", "story_v_out_319521.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_319521", "319521041", "story_v_out_319521.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_31 = math.max(var_177_22, arg_174_1.talkMaxDuration)

			if var_177_21 <= arg_174_1.time_ and arg_174_1.time_ < var_177_21 + var_177_31 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_21) / var_177_31

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_21 + var_177_31 and arg_174_1.time_ < var_177_21 + var_177_31 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play319521042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 319521042
		arg_178_1.duration_ = 6.73

		local var_178_0 = {
			zh = 3.1,
			ja = 6.733
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play319521043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.4

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[668].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_3 = arg_178_1:GetWordFromCfg(319521042)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 16
				local var_181_6 = utf8.len(var_181_4)
				local var_181_7 = var_181_5 <= 0 and var_181_1 or var_181_1 * (var_181_6 / var_181_5)

				if var_181_7 > 0 and var_181_1 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521042", "story_v_out_319521.awb") ~= 0 then
					local var_181_8 = manager.audio:GetVoiceLength("story_v_out_319521", "319521042", "story_v_out_319521.awb") / 1000

					if var_181_8 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_0
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_out_319521", "319521042", "story_v_out_319521.awb")

						arg_178_1:RecordAudio("319521042", var_181_9)
						arg_178_1:RecordAudio("319521042", var_181_9)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_319521", "319521042", "story_v_out_319521.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_319521", "319521042", "story_v_out_319521.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_10 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_10 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_10

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_10 and arg_178_1.time_ < var_181_0 + var_181_10 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play319521043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 319521043
		arg_182_1.duration_ = 11.6

		local var_182_0 = {
			zh = 3,
			ja = 11.6
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play319521044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["4040ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect4040ui_story == nil then
				arg_182_1.var_.characterEffect4040ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect4040ui_story and not isNil(var_185_0) then
					local var_185_4 = Mathf.Lerp(0, 0.5, var_185_3)

					arg_182_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_182_1.var_.characterEffect4040ui_story.fillRatio = var_185_4
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect4040ui_story then
				local var_185_5 = 0.5

				arg_182_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_182_1.var_.characterEffect4040ui_story.fillRatio = var_185_5
			end

			local var_185_6 = arg_182_1.actors_["1084ui_story"]
			local var_185_7 = 0

			if var_185_7 < arg_182_1.time_ and arg_182_1.time_ <= var_185_7 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect1084ui_story == nil then
				arg_182_1.var_.characterEffect1084ui_story = var_185_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_8 = 0.200000002980232

			if var_185_7 <= arg_182_1.time_ and arg_182_1.time_ < var_185_7 + var_185_8 and not isNil(var_185_6) then
				local var_185_9 = (arg_182_1.time_ - var_185_7) / var_185_8

				if arg_182_1.var_.characterEffect1084ui_story and not isNil(var_185_6) then
					arg_182_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_7 + var_185_8 and arg_182_1.time_ < var_185_7 + var_185_8 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect1084ui_story then
				arg_182_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_185_10 = 0

			if var_185_10 < arg_182_1.time_ and arg_182_1.time_ <= var_185_10 + arg_185_0 then
				arg_182_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_185_11 = 0
			local var_185_12 = 0.325

			if var_185_11 < arg_182_1.time_ and arg_182_1.time_ <= var_185_11 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_13 = arg_182_1:FormatText(StoryNameCfg[6].name)

				arg_182_1.leftNameTxt_.text = var_185_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_14 = arg_182_1:GetWordFromCfg(319521043)
				local var_185_15 = arg_182_1:FormatText(var_185_14.content)

				arg_182_1.text_.text = var_185_15

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_16 = 13
				local var_185_17 = utf8.len(var_185_15)
				local var_185_18 = var_185_16 <= 0 and var_185_12 or var_185_12 * (var_185_17 / var_185_16)

				if var_185_18 > 0 and var_185_12 < var_185_18 then
					arg_182_1.talkMaxDuration = var_185_18

					if var_185_18 + var_185_11 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_18 + var_185_11
					end
				end

				arg_182_1.text_.text = var_185_15
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521043", "story_v_out_319521.awb") ~= 0 then
					local var_185_19 = manager.audio:GetVoiceLength("story_v_out_319521", "319521043", "story_v_out_319521.awb") / 1000

					if var_185_19 + var_185_11 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_19 + var_185_11
					end

					if var_185_14.prefab_name ~= "" and arg_182_1.actors_[var_185_14.prefab_name] ~= nil then
						local var_185_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_14.prefab_name].transform, "story_v_out_319521", "319521043", "story_v_out_319521.awb")

						arg_182_1:RecordAudio("319521043", var_185_20)
						arg_182_1:RecordAudio("319521043", var_185_20)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_319521", "319521043", "story_v_out_319521.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_319521", "319521043", "story_v_out_319521.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_21 = math.max(var_185_12, arg_182_1.talkMaxDuration)

			if var_185_11 <= arg_182_1.time_ and arg_182_1.time_ < var_185_11 + var_185_21 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_11) / var_185_21

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_11 + var_185_21 and arg_182_1.time_ < var_185_11 + var_185_21 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play319521044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 319521044
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play319521045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1084ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1084ui_story == nil then
				arg_186_1.var_.characterEffect1084ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect1084ui_story and not isNil(var_189_0) then
					local var_189_4 = Mathf.Lerp(0, 0.5, var_189_3)

					arg_186_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1084ui_story.fillRatio = var_189_4
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1084ui_story then
				local var_189_5 = 0.5

				arg_186_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1084ui_story.fillRatio = var_189_5
			end

			local var_189_6 = 0
			local var_189_7 = 1.425

			if var_189_6 < arg_186_1.time_ and arg_186_1.time_ <= var_189_6 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_8 = arg_186_1:GetWordFromCfg(319521044)
				local var_189_9 = arg_186_1:FormatText(var_189_8.content)

				arg_186_1.text_.text = var_189_9

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_10 = 57
				local var_189_11 = utf8.len(var_189_9)
				local var_189_12 = var_189_10 <= 0 and var_189_7 or var_189_7 * (var_189_11 / var_189_10)

				if var_189_12 > 0 and var_189_7 < var_189_12 then
					arg_186_1.talkMaxDuration = var_189_12

					if var_189_12 + var_189_6 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_12 + var_189_6
					end
				end

				arg_186_1.text_.text = var_189_9
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_13 = math.max(var_189_7, arg_186_1.talkMaxDuration)

			if var_189_6 <= arg_186_1.time_ and arg_186_1.time_ < var_189_6 + var_189_13 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_6) / var_189_13

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_6 + var_189_13 and arg_186_1.time_ < var_189_6 + var_189_13 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play319521045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 319521045
		arg_190_1.duration_ = 6.23

		local var_190_0 = {
			zh = 4.066,
			ja = 6.233
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play319521046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["4040ui_story"].transform
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.var_.moveOldPos4040ui_story = var_193_0.localPosition
			end

			local var_193_2 = 0.001

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2
				local var_193_4 = Vector3.New(0.7, -1.55, -5.5)

				var_193_0.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos4040ui_story, var_193_4, var_193_3)

				local var_193_5 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_5.x, var_193_5.y, var_193_5.z)

				local var_193_6 = var_193_0.localEulerAngles

				var_193_6.z = 0
				var_193_6.x = 0
				var_193_0.localEulerAngles = var_193_6
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 then
				var_193_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_193_7 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_7.x, var_193_7.y, var_193_7.z)

				local var_193_8 = var_193_0.localEulerAngles

				var_193_8.z = 0
				var_193_8.x = 0
				var_193_0.localEulerAngles = var_193_8
			end

			local var_193_9 = arg_190_1.actors_["4040ui_story"]
			local var_193_10 = 0

			if var_193_10 < arg_190_1.time_ and arg_190_1.time_ <= var_193_10 + arg_193_0 and not isNil(var_193_9) and arg_190_1.var_.characterEffect4040ui_story == nil then
				arg_190_1.var_.characterEffect4040ui_story = var_193_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_11 = 0.200000002980232

			if var_193_10 <= arg_190_1.time_ and arg_190_1.time_ < var_193_10 + var_193_11 and not isNil(var_193_9) then
				local var_193_12 = (arg_190_1.time_ - var_193_10) / var_193_11

				if arg_190_1.var_.characterEffect4040ui_story and not isNil(var_193_9) then
					arg_190_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_10 + var_193_11 and arg_190_1.time_ < var_193_10 + var_193_11 + arg_193_0 and not isNil(var_193_9) and arg_190_1.var_.characterEffect4040ui_story then
				arg_190_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_193_13 = 0

			if var_193_13 < arg_190_1.time_ and arg_190_1.time_ <= var_193_13 + arg_193_0 then
				arg_190_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_193_14 = 0

			if var_193_14 < arg_190_1.time_ and arg_190_1.time_ <= var_193_14 + arg_193_0 then
				arg_190_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_193_15 = 0
			local var_193_16 = 0.55

			if var_193_15 < arg_190_1.time_ and arg_190_1.time_ <= var_193_15 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_17 = arg_190_1:FormatText(StoryNameCfg[668].name)

				arg_190_1.leftNameTxt_.text = var_193_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_18 = arg_190_1:GetWordFromCfg(319521045)
				local var_193_19 = arg_190_1:FormatText(var_193_18.content)

				arg_190_1.text_.text = var_193_19

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_20 = 22
				local var_193_21 = utf8.len(var_193_19)
				local var_193_22 = var_193_20 <= 0 and var_193_16 or var_193_16 * (var_193_21 / var_193_20)

				if var_193_22 > 0 and var_193_16 < var_193_22 then
					arg_190_1.talkMaxDuration = var_193_22

					if var_193_22 + var_193_15 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_22 + var_193_15
					end
				end

				arg_190_1.text_.text = var_193_19
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521045", "story_v_out_319521.awb") ~= 0 then
					local var_193_23 = manager.audio:GetVoiceLength("story_v_out_319521", "319521045", "story_v_out_319521.awb") / 1000

					if var_193_23 + var_193_15 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_23 + var_193_15
					end

					if var_193_18.prefab_name ~= "" and arg_190_1.actors_[var_193_18.prefab_name] ~= nil then
						local var_193_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_18.prefab_name].transform, "story_v_out_319521", "319521045", "story_v_out_319521.awb")

						arg_190_1:RecordAudio("319521045", var_193_24)
						arg_190_1:RecordAudio("319521045", var_193_24)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_319521", "319521045", "story_v_out_319521.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_319521", "319521045", "story_v_out_319521.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_25 = math.max(var_193_16, arg_190_1.talkMaxDuration)

			if var_193_15 <= arg_190_1.time_ and arg_190_1.time_ < var_193_15 + var_193_25 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_15) / var_193_25

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_15 + var_193_25 and arg_190_1.time_ < var_193_15 + var_193_25 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play319521046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 319521046
		arg_194_1.duration_ = 3.73

		local var_194_0 = {
			zh = 1.333,
			ja = 3.733
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play319521047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1084ui_story"].transform
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.var_.moveOldPos1084ui_story = var_197_0.localPosition
			end

			local var_197_2 = 0.001

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2
				local var_197_4 = Vector3.New(-0.7, -0.97, -6)

				var_197_0.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1084ui_story, var_197_4, var_197_3)

				local var_197_5 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_5.x, var_197_5.y, var_197_5.z)

				local var_197_6 = var_197_0.localEulerAngles

				var_197_6.z = 0
				var_197_6.x = 0
				var_197_0.localEulerAngles = var_197_6
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 then
				var_197_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_197_7 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_7.x, var_197_7.y, var_197_7.z)

				local var_197_8 = var_197_0.localEulerAngles

				var_197_8.z = 0
				var_197_8.x = 0
				var_197_0.localEulerAngles = var_197_8
			end

			local var_197_9 = arg_194_1.actors_["1084ui_story"]
			local var_197_10 = 0

			if var_197_10 < arg_194_1.time_ and arg_194_1.time_ <= var_197_10 + arg_197_0 and not isNil(var_197_9) and arg_194_1.var_.characterEffect1084ui_story == nil then
				arg_194_1.var_.characterEffect1084ui_story = var_197_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_11 = 0.200000002980232

			if var_197_10 <= arg_194_1.time_ and arg_194_1.time_ < var_197_10 + var_197_11 and not isNil(var_197_9) then
				local var_197_12 = (arg_194_1.time_ - var_197_10) / var_197_11

				if arg_194_1.var_.characterEffect1084ui_story and not isNil(var_197_9) then
					arg_194_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_10 + var_197_11 and arg_194_1.time_ < var_197_10 + var_197_11 + arg_197_0 and not isNil(var_197_9) and arg_194_1.var_.characterEffect1084ui_story then
				arg_194_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_197_13 = 0

			if var_197_13 < arg_194_1.time_ and arg_194_1.time_ <= var_197_13 + arg_197_0 then
				arg_194_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_197_14 = 0

			if var_197_14 < arg_194_1.time_ and arg_194_1.time_ <= var_197_14 + arg_197_0 then
				arg_194_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_197_15 = arg_194_1.actors_["4040ui_story"]
			local var_197_16 = 0

			if var_197_16 < arg_194_1.time_ and arg_194_1.time_ <= var_197_16 + arg_197_0 and not isNil(var_197_15) and arg_194_1.var_.characterEffect4040ui_story == nil then
				arg_194_1.var_.characterEffect4040ui_story = var_197_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_17 = 0.200000002980232

			if var_197_16 <= arg_194_1.time_ and arg_194_1.time_ < var_197_16 + var_197_17 and not isNil(var_197_15) then
				local var_197_18 = (arg_194_1.time_ - var_197_16) / var_197_17

				if arg_194_1.var_.characterEffect4040ui_story and not isNil(var_197_15) then
					local var_197_19 = Mathf.Lerp(0, 0.5, var_197_18)

					arg_194_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_194_1.var_.characterEffect4040ui_story.fillRatio = var_197_19
				end
			end

			if arg_194_1.time_ >= var_197_16 + var_197_17 and arg_194_1.time_ < var_197_16 + var_197_17 + arg_197_0 and not isNil(var_197_15) and arg_194_1.var_.characterEffect4040ui_story then
				local var_197_20 = 0.5

				arg_194_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_194_1.var_.characterEffect4040ui_story.fillRatio = var_197_20
			end

			local var_197_21 = 0
			local var_197_22 = 0.125

			if var_197_21 < arg_194_1.time_ and arg_194_1.time_ <= var_197_21 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_23 = arg_194_1:FormatText(StoryNameCfg[6].name)

				arg_194_1.leftNameTxt_.text = var_197_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_24 = arg_194_1:GetWordFromCfg(319521046)
				local var_197_25 = arg_194_1:FormatText(var_197_24.content)

				arg_194_1.text_.text = var_197_25

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_26 = 5
				local var_197_27 = utf8.len(var_197_25)
				local var_197_28 = var_197_26 <= 0 and var_197_22 or var_197_22 * (var_197_27 / var_197_26)

				if var_197_28 > 0 and var_197_22 < var_197_28 then
					arg_194_1.talkMaxDuration = var_197_28

					if var_197_28 + var_197_21 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_28 + var_197_21
					end
				end

				arg_194_1.text_.text = var_197_25
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521046", "story_v_out_319521.awb") ~= 0 then
					local var_197_29 = manager.audio:GetVoiceLength("story_v_out_319521", "319521046", "story_v_out_319521.awb") / 1000

					if var_197_29 + var_197_21 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_29 + var_197_21
					end

					if var_197_24.prefab_name ~= "" and arg_194_1.actors_[var_197_24.prefab_name] ~= nil then
						local var_197_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_24.prefab_name].transform, "story_v_out_319521", "319521046", "story_v_out_319521.awb")

						arg_194_1:RecordAudio("319521046", var_197_30)
						arg_194_1:RecordAudio("319521046", var_197_30)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_319521", "319521046", "story_v_out_319521.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_319521", "319521046", "story_v_out_319521.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_31 = math.max(var_197_22, arg_194_1.talkMaxDuration)

			if var_197_21 <= arg_194_1.time_ and arg_194_1.time_ < var_197_21 + var_197_31 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_21) / var_197_31

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_21 + var_197_31 and arg_194_1.time_ < var_197_21 + var_197_31 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
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

		arg_194_1:InitPlayNodeList()
	end,
	Play319521047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 319521047
		arg_198_1.duration_ = 11.13

		local var_198_0 = {
			zh = 1.999999999999,
			ja = 11.133
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play319521048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1084ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1084ui_story == nil then
				arg_198_1.var_.characterEffect1084ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect1084ui_story and not isNil(var_201_0) then
					local var_201_4 = Mathf.Lerp(0, 0.5, var_201_3)

					arg_198_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1084ui_story.fillRatio = var_201_4
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1084ui_story then
				local var_201_5 = 0.5

				arg_198_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1084ui_story.fillRatio = var_201_5
			end

			local var_201_6 = arg_198_1.actors_["4040ui_story"]
			local var_201_7 = 0

			if var_201_7 < arg_198_1.time_ and arg_198_1.time_ <= var_201_7 + arg_201_0 and not isNil(var_201_6) and arg_198_1.var_.characterEffect4040ui_story == nil then
				arg_198_1.var_.characterEffect4040ui_story = var_201_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_8 = 0.200000002980232

			if var_201_7 <= arg_198_1.time_ and arg_198_1.time_ < var_201_7 + var_201_8 and not isNil(var_201_6) then
				local var_201_9 = (arg_198_1.time_ - var_201_7) / var_201_8

				if arg_198_1.var_.characterEffect4040ui_story and not isNil(var_201_6) then
					arg_198_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_7 + var_201_8 and arg_198_1.time_ < var_201_7 + var_201_8 + arg_201_0 and not isNil(var_201_6) and arg_198_1.var_.characterEffect4040ui_story then
				arg_198_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_201_10 = 0

			if var_201_10 < arg_198_1.time_ and arg_198_1.time_ <= var_201_10 + arg_201_0 then
				arg_198_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_201_11 = 0

			if var_201_11 < arg_198_1.time_ and arg_198_1.time_ <= var_201_11 + arg_201_0 then
				arg_198_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_201_12 = 0
			local var_201_13 = 0.25

			if var_201_12 < arg_198_1.time_ and arg_198_1.time_ <= var_201_12 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_14 = arg_198_1:FormatText(StoryNameCfg[668].name)

				arg_198_1.leftNameTxt_.text = var_201_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_15 = arg_198_1:GetWordFromCfg(319521047)
				local var_201_16 = arg_198_1:FormatText(var_201_15.content)

				arg_198_1.text_.text = var_201_16

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_17 = 10
				local var_201_18 = utf8.len(var_201_16)
				local var_201_19 = var_201_17 <= 0 and var_201_13 or var_201_13 * (var_201_18 / var_201_17)

				if var_201_19 > 0 and var_201_13 < var_201_19 then
					arg_198_1.talkMaxDuration = var_201_19

					if var_201_19 + var_201_12 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_19 + var_201_12
					end
				end

				arg_198_1.text_.text = var_201_16
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521047", "story_v_out_319521.awb") ~= 0 then
					local var_201_20 = manager.audio:GetVoiceLength("story_v_out_319521", "319521047", "story_v_out_319521.awb") / 1000

					if var_201_20 + var_201_12 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_20 + var_201_12
					end

					if var_201_15.prefab_name ~= "" and arg_198_1.actors_[var_201_15.prefab_name] ~= nil then
						local var_201_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_15.prefab_name].transform, "story_v_out_319521", "319521047", "story_v_out_319521.awb")

						arg_198_1:RecordAudio("319521047", var_201_21)
						arg_198_1:RecordAudio("319521047", var_201_21)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_319521", "319521047", "story_v_out_319521.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_319521", "319521047", "story_v_out_319521.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_22 = math.max(var_201_13, arg_198_1.talkMaxDuration)

			if var_201_12 <= arg_198_1.time_ and arg_198_1.time_ < var_201_12 + var_201_22 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_12) / var_201_22

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_12 + var_201_22 and arg_198_1.time_ < var_201_12 + var_201_22 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play319521048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 319521048
		arg_202_1.duration_ = 7.97

		local var_202_0 = {
			zh = 4.566,
			ja = 7.966
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play319521049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["4040ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect4040ui_story == nil then
				arg_202_1.var_.characterEffect4040ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect4040ui_story and not isNil(var_205_0) then
					local var_205_4 = Mathf.Lerp(0, 0.5, var_205_3)

					arg_202_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_202_1.var_.characterEffect4040ui_story.fillRatio = var_205_4
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect4040ui_story then
				local var_205_5 = 0.5

				arg_202_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_202_1.var_.characterEffect4040ui_story.fillRatio = var_205_5
			end

			local var_205_6 = arg_202_1.actors_["1084ui_story"]
			local var_205_7 = 0

			if var_205_7 < arg_202_1.time_ and arg_202_1.time_ <= var_205_7 + arg_205_0 and not isNil(var_205_6) and arg_202_1.var_.characterEffect1084ui_story == nil then
				arg_202_1.var_.characterEffect1084ui_story = var_205_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_8 = 0.200000002980232

			if var_205_7 <= arg_202_1.time_ and arg_202_1.time_ < var_205_7 + var_205_8 and not isNil(var_205_6) then
				local var_205_9 = (arg_202_1.time_ - var_205_7) / var_205_8

				if arg_202_1.var_.characterEffect1084ui_story and not isNil(var_205_6) then
					arg_202_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_7 + var_205_8 and arg_202_1.time_ < var_205_7 + var_205_8 + arg_205_0 and not isNil(var_205_6) and arg_202_1.var_.characterEffect1084ui_story then
				arg_202_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_205_10 = 0
			local var_205_11 = 0.65

			if var_205_10 < arg_202_1.time_ and arg_202_1.time_ <= var_205_10 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_12 = arg_202_1:FormatText(StoryNameCfg[6].name)

				arg_202_1.leftNameTxt_.text = var_205_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_13 = arg_202_1:GetWordFromCfg(319521048)
				local var_205_14 = arg_202_1:FormatText(var_205_13.content)

				arg_202_1.text_.text = var_205_14

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_15 = 26
				local var_205_16 = utf8.len(var_205_14)
				local var_205_17 = var_205_15 <= 0 and var_205_11 or var_205_11 * (var_205_16 / var_205_15)

				if var_205_17 > 0 and var_205_11 < var_205_17 then
					arg_202_1.talkMaxDuration = var_205_17

					if var_205_17 + var_205_10 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_17 + var_205_10
					end
				end

				arg_202_1.text_.text = var_205_14
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521048", "story_v_out_319521.awb") ~= 0 then
					local var_205_18 = manager.audio:GetVoiceLength("story_v_out_319521", "319521048", "story_v_out_319521.awb") / 1000

					if var_205_18 + var_205_10 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_18 + var_205_10
					end

					if var_205_13.prefab_name ~= "" and arg_202_1.actors_[var_205_13.prefab_name] ~= nil then
						local var_205_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_13.prefab_name].transform, "story_v_out_319521", "319521048", "story_v_out_319521.awb")

						arg_202_1:RecordAudio("319521048", var_205_19)
						arg_202_1:RecordAudio("319521048", var_205_19)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_319521", "319521048", "story_v_out_319521.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_319521", "319521048", "story_v_out_319521.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_20 = math.max(var_205_11, arg_202_1.talkMaxDuration)

			if var_205_10 <= arg_202_1.time_ and arg_202_1.time_ < var_205_10 + var_205_20 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_10) / var_205_20

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_10 + var_205_20 and arg_202_1.time_ < var_205_10 + var_205_20 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play319521049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 319521049
		arg_206_1.duration_ = 3.17

		local var_206_0 = {
			zh = 2.433,
			ja = 3.166
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play319521050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["4040ui_story"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect4040ui_story == nil then
				arg_206_1.var_.characterEffect4040ui_story = var_209_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.200000002980232

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.characterEffect4040ui_story and not isNil(var_209_0) then
					arg_206_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect4040ui_story then
				arg_206_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_209_4 = arg_206_1.actors_["1084ui_story"]
			local var_209_5 = 0

			if var_209_5 < arg_206_1.time_ and arg_206_1.time_ <= var_209_5 + arg_209_0 and not isNil(var_209_4) and arg_206_1.var_.characterEffect1084ui_story == nil then
				arg_206_1.var_.characterEffect1084ui_story = var_209_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_6 = 0.200000002980232

			if var_209_5 <= arg_206_1.time_ and arg_206_1.time_ < var_209_5 + var_209_6 and not isNil(var_209_4) then
				local var_209_7 = (arg_206_1.time_ - var_209_5) / var_209_6

				if arg_206_1.var_.characterEffect1084ui_story and not isNil(var_209_4) then
					local var_209_8 = Mathf.Lerp(0, 0.5, var_209_7)

					arg_206_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_206_1.var_.characterEffect1084ui_story.fillRatio = var_209_8
				end
			end

			if arg_206_1.time_ >= var_209_5 + var_209_6 and arg_206_1.time_ < var_209_5 + var_209_6 + arg_209_0 and not isNil(var_209_4) and arg_206_1.var_.characterEffect1084ui_story then
				local var_209_9 = 0.5

				arg_206_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_206_1.var_.characterEffect1084ui_story.fillRatio = var_209_9
			end

			local var_209_10 = 0
			local var_209_11 = 0.25

			if var_209_10 < arg_206_1.time_ and arg_206_1.time_ <= var_209_10 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_12 = arg_206_1:FormatText(StoryNameCfg[668].name)

				arg_206_1.leftNameTxt_.text = var_209_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_13 = arg_206_1:GetWordFromCfg(319521049)
				local var_209_14 = arg_206_1:FormatText(var_209_13.content)

				arg_206_1.text_.text = var_209_14

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_15 = 10
				local var_209_16 = utf8.len(var_209_14)
				local var_209_17 = var_209_15 <= 0 and var_209_11 or var_209_11 * (var_209_16 / var_209_15)

				if var_209_17 > 0 and var_209_11 < var_209_17 then
					arg_206_1.talkMaxDuration = var_209_17

					if var_209_17 + var_209_10 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_17 + var_209_10
					end
				end

				arg_206_1.text_.text = var_209_14
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521049", "story_v_out_319521.awb") ~= 0 then
					local var_209_18 = manager.audio:GetVoiceLength("story_v_out_319521", "319521049", "story_v_out_319521.awb") / 1000

					if var_209_18 + var_209_10 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_18 + var_209_10
					end

					if var_209_13.prefab_name ~= "" and arg_206_1.actors_[var_209_13.prefab_name] ~= nil then
						local var_209_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_13.prefab_name].transform, "story_v_out_319521", "319521049", "story_v_out_319521.awb")

						arg_206_1:RecordAudio("319521049", var_209_19)
						arg_206_1:RecordAudio("319521049", var_209_19)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_319521", "319521049", "story_v_out_319521.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_319521", "319521049", "story_v_out_319521.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_20 = math.max(var_209_11, arg_206_1.talkMaxDuration)

			if var_209_10 <= arg_206_1.time_ and arg_206_1.time_ < var_209_10 + var_209_20 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_10) / var_209_20

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_10 + var_209_20 and arg_206_1.time_ < var_209_10 + var_209_20 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play319521050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 319521050
		arg_210_1.duration_ = 6.7

		local var_210_0 = {
			zh = 1.999999999999,
			ja = 6.7
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play319521051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["4040ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect4040ui_story == nil then
				arg_210_1.var_.characterEffect4040ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect4040ui_story and not isNil(var_213_0) then
					local var_213_4 = Mathf.Lerp(0, 0.5, var_213_3)

					arg_210_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_210_1.var_.characterEffect4040ui_story.fillRatio = var_213_4
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect4040ui_story then
				local var_213_5 = 0.5

				arg_210_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_210_1.var_.characterEffect4040ui_story.fillRatio = var_213_5
			end

			local var_213_6 = arg_210_1.actors_["1084ui_story"]
			local var_213_7 = 0

			if var_213_7 < arg_210_1.time_ and arg_210_1.time_ <= var_213_7 + arg_213_0 and not isNil(var_213_6) and arg_210_1.var_.characterEffect1084ui_story == nil then
				arg_210_1.var_.characterEffect1084ui_story = var_213_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_8 = 0.200000002980232

			if var_213_7 <= arg_210_1.time_ and arg_210_1.time_ < var_213_7 + var_213_8 and not isNil(var_213_6) then
				local var_213_9 = (arg_210_1.time_ - var_213_7) / var_213_8

				if arg_210_1.var_.characterEffect1084ui_story and not isNil(var_213_6) then
					arg_210_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_7 + var_213_8 and arg_210_1.time_ < var_213_7 + var_213_8 + arg_213_0 and not isNil(var_213_6) and arg_210_1.var_.characterEffect1084ui_story then
				arg_210_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_213_10 = 0

			if var_213_10 < arg_210_1.time_ and arg_210_1.time_ <= var_213_10 + arg_213_0 then
				arg_210_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_213_11 = 0
			local var_213_12 = 0.2

			if var_213_11 < arg_210_1.time_ and arg_210_1.time_ <= var_213_11 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_13 = arg_210_1:FormatText(StoryNameCfg[6].name)

				arg_210_1.leftNameTxt_.text = var_213_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_14 = arg_210_1:GetWordFromCfg(319521050)
				local var_213_15 = arg_210_1:FormatText(var_213_14.content)

				arg_210_1.text_.text = var_213_15

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_16 = 8
				local var_213_17 = utf8.len(var_213_15)
				local var_213_18 = var_213_16 <= 0 and var_213_12 or var_213_12 * (var_213_17 / var_213_16)

				if var_213_18 > 0 and var_213_12 < var_213_18 then
					arg_210_1.talkMaxDuration = var_213_18

					if var_213_18 + var_213_11 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_18 + var_213_11
					end
				end

				arg_210_1.text_.text = var_213_15
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521050", "story_v_out_319521.awb") ~= 0 then
					local var_213_19 = manager.audio:GetVoiceLength("story_v_out_319521", "319521050", "story_v_out_319521.awb") / 1000

					if var_213_19 + var_213_11 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_19 + var_213_11
					end

					if var_213_14.prefab_name ~= "" and arg_210_1.actors_[var_213_14.prefab_name] ~= nil then
						local var_213_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_14.prefab_name].transform, "story_v_out_319521", "319521050", "story_v_out_319521.awb")

						arg_210_1:RecordAudio("319521050", var_213_20)
						arg_210_1:RecordAudio("319521050", var_213_20)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_319521", "319521050", "story_v_out_319521.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_319521", "319521050", "story_v_out_319521.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_21 = math.max(var_213_12, arg_210_1.talkMaxDuration)

			if var_213_11 <= arg_210_1.time_ and arg_210_1.time_ < var_213_11 + var_213_21 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_11) / var_213_21

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_11 + var_213_21 and arg_210_1.time_ < var_213_11 + var_213_21 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play319521051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 319521051
		arg_214_1.duration_ = 10.27

		local var_214_0 = {
			zh = 4.333,
			ja = 10.266
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
				arg_214_0:Play319521052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["4040ui_story"].transform
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.var_.moveOldPos4040ui_story = var_217_0.localPosition
			end

			local var_217_2 = 0.001

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2
				local var_217_4 = Vector3.New(0.7, -1.55, -5.5)

				var_217_0.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos4040ui_story, var_217_4, var_217_3)

				local var_217_5 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_5.x, var_217_5.y, var_217_5.z)

				local var_217_6 = var_217_0.localEulerAngles

				var_217_6.z = 0
				var_217_6.x = 0
				var_217_0.localEulerAngles = var_217_6
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 then
				var_217_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_217_7 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_7.x, var_217_7.y, var_217_7.z)

				local var_217_8 = var_217_0.localEulerAngles

				var_217_8.z = 0
				var_217_8.x = 0
				var_217_0.localEulerAngles = var_217_8
			end

			local var_217_9 = arg_214_1.actors_["4040ui_story"]
			local var_217_10 = 0

			if var_217_10 < arg_214_1.time_ and arg_214_1.time_ <= var_217_10 + arg_217_0 and not isNil(var_217_9) and arg_214_1.var_.characterEffect4040ui_story == nil then
				arg_214_1.var_.characterEffect4040ui_story = var_217_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_11 = 0.200000002980232

			if var_217_10 <= arg_214_1.time_ and arg_214_1.time_ < var_217_10 + var_217_11 and not isNil(var_217_9) then
				local var_217_12 = (arg_214_1.time_ - var_217_10) / var_217_11

				if arg_214_1.var_.characterEffect4040ui_story and not isNil(var_217_9) then
					arg_214_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_10 + var_217_11 and arg_214_1.time_ < var_217_10 + var_217_11 + arg_217_0 and not isNil(var_217_9) and arg_214_1.var_.characterEffect4040ui_story then
				arg_214_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_217_13 = 0

			if var_217_13 < arg_214_1.time_ and arg_214_1.time_ <= var_217_13 + arg_217_0 then
				arg_214_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_217_14 = 0

			if var_217_14 < arg_214_1.time_ and arg_214_1.time_ <= var_217_14 + arg_217_0 then
				arg_214_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_217_15 = arg_214_1.actors_["1084ui_story"]
			local var_217_16 = 0

			if var_217_16 < arg_214_1.time_ and arg_214_1.time_ <= var_217_16 + arg_217_0 and not isNil(var_217_15) and arg_214_1.var_.characterEffect1084ui_story == nil then
				arg_214_1.var_.characterEffect1084ui_story = var_217_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_17 = 0.200000002980232

			if var_217_16 <= arg_214_1.time_ and arg_214_1.time_ < var_217_16 + var_217_17 and not isNil(var_217_15) then
				local var_217_18 = (arg_214_1.time_ - var_217_16) / var_217_17

				if arg_214_1.var_.characterEffect1084ui_story and not isNil(var_217_15) then
					local var_217_19 = Mathf.Lerp(0, 0.5, var_217_18)

					arg_214_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1084ui_story.fillRatio = var_217_19
				end
			end

			if arg_214_1.time_ >= var_217_16 + var_217_17 and arg_214_1.time_ < var_217_16 + var_217_17 + arg_217_0 and not isNil(var_217_15) and arg_214_1.var_.characterEffect1084ui_story then
				local var_217_20 = 0.5

				arg_214_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1084ui_story.fillRatio = var_217_20
			end

			local var_217_21 = 0
			local var_217_22 = 0.55

			if var_217_21 < arg_214_1.time_ and arg_214_1.time_ <= var_217_21 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_23 = arg_214_1:FormatText(StoryNameCfg[668].name)

				arg_214_1.leftNameTxt_.text = var_217_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_24 = arg_214_1:GetWordFromCfg(319521051)
				local var_217_25 = arg_214_1:FormatText(var_217_24.content)

				arg_214_1.text_.text = var_217_25

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_26 = 22
				local var_217_27 = utf8.len(var_217_25)
				local var_217_28 = var_217_26 <= 0 and var_217_22 or var_217_22 * (var_217_27 / var_217_26)

				if var_217_28 > 0 and var_217_22 < var_217_28 then
					arg_214_1.talkMaxDuration = var_217_28

					if var_217_28 + var_217_21 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_28 + var_217_21
					end
				end

				arg_214_1.text_.text = var_217_25
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521051", "story_v_out_319521.awb") ~= 0 then
					local var_217_29 = manager.audio:GetVoiceLength("story_v_out_319521", "319521051", "story_v_out_319521.awb") / 1000

					if var_217_29 + var_217_21 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_29 + var_217_21
					end

					if var_217_24.prefab_name ~= "" and arg_214_1.actors_[var_217_24.prefab_name] ~= nil then
						local var_217_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_24.prefab_name].transform, "story_v_out_319521", "319521051", "story_v_out_319521.awb")

						arg_214_1:RecordAudio("319521051", var_217_30)
						arg_214_1:RecordAudio("319521051", var_217_30)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_319521", "319521051", "story_v_out_319521.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_319521", "319521051", "story_v_out_319521.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_31 = math.max(var_217_22, arg_214_1.talkMaxDuration)

			if var_217_21 <= arg_214_1.time_ and arg_214_1.time_ < var_217_21 + var_217_31 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_21) / var_217_31

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_21 + var_217_31 and arg_214_1.time_ < var_217_21 + var_217_31 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319521052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 319521052
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play319521053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["4040ui_story"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect4040ui_story == nil then
				arg_218_1.var_.characterEffect4040ui_story = var_221_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.characterEffect4040ui_story and not isNil(var_221_0) then
					local var_221_4 = Mathf.Lerp(0, 0.5, var_221_3)

					arg_218_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_218_1.var_.characterEffect4040ui_story.fillRatio = var_221_4
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect4040ui_story then
				local var_221_5 = 0.5

				arg_218_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_218_1.var_.characterEffect4040ui_story.fillRatio = var_221_5
			end

			local var_221_6 = 0
			local var_221_7 = 0.75

			if var_221_6 < arg_218_1.time_ and arg_218_1.time_ <= var_221_6 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_8 = arg_218_1:GetWordFromCfg(319521052)
				local var_221_9 = arg_218_1:FormatText(var_221_8.content)

				arg_218_1.text_.text = var_221_9

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_10 = 30
				local var_221_11 = utf8.len(var_221_9)
				local var_221_12 = var_221_10 <= 0 and var_221_7 or var_221_7 * (var_221_11 / var_221_10)

				if var_221_12 > 0 and var_221_7 < var_221_12 then
					arg_218_1.talkMaxDuration = var_221_12

					if var_221_12 + var_221_6 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_12 + var_221_6
					end
				end

				arg_218_1.text_.text = var_221_9
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_13 = math.max(var_221_7, arg_218_1.talkMaxDuration)

			if var_221_6 <= arg_218_1.time_ and arg_218_1.time_ < var_221_6 + var_221_13 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_6) / var_221_13

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_6 + var_221_13 and arg_218_1.time_ < var_221_6 + var_221_13 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play319521053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 319521053
		arg_222_1.duration_ = 10.6

		local var_222_0 = {
			zh = 7.933,
			ja = 10.6
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play319521054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["4040ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect4040ui_story == nil then
				arg_222_1.var_.characterEffect4040ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect4040ui_story and not isNil(var_225_0) then
					arg_222_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect4040ui_story then
				arg_222_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_225_4 = 0
			local var_225_5 = 0.975

			if var_225_4 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_6 = arg_222_1:FormatText(StoryNameCfg[668].name)

				arg_222_1.leftNameTxt_.text = var_225_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_7 = arg_222_1:GetWordFromCfg(319521053)
				local var_225_8 = arg_222_1:FormatText(var_225_7.content)

				arg_222_1.text_.text = var_225_8

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_9 = 39
				local var_225_10 = utf8.len(var_225_8)
				local var_225_11 = var_225_9 <= 0 and var_225_5 or var_225_5 * (var_225_10 / var_225_9)

				if var_225_11 > 0 and var_225_5 < var_225_11 then
					arg_222_1.talkMaxDuration = var_225_11

					if var_225_11 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_11 + var_225_4
					end
				end

				arg_222_1.text_.text = var_225_8
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521053", "story_v_out_319521.awb") ~= 0 then
					local var_225_12 = manager.audio:GetVoiceLength("story_v_out_319521", "319521053", "story_v_out_319521.awb") / 1000

					if var_225_12 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_12 + var_225_4
					end

					if var_225_7.prefab_name ~= "" and arg_222_1.actors_[var_225_7.prefab_name] ~= nil then
						local var_225_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_7.prefab_name].transform, "story_v_out_319521", "319521053", "story_v_out_319521.awb")

						arg_222_1:RecordAudio("319521053", var_225_13)
						arg_222_1:RecordAudio("319521053", var_225_13)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_319521", "319521053", "story_v_out_319521.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_319521", "319521053", "story_v_out_319521.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_14 = math.max(var_225_5, arg_222_1.talkMaxDuration)

			if var_225_4 <= arg_222_1.time_ and arg_222_1.time_ < var_225_4 + var_225_14 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_4) / var_225_14

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_4 + var_225_14 and arg_222_1.time_ < var_225_4 + var_225_14 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play319521054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 319521054
		arg_226_1.duration_ = 10.73

		local var_226_0 = {
			zh = 8.733,
			ja = 10.733
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play319521055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1084ui_story"].transform
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.var_.moveOldPos1084ui_story = var_229_0.localPosition
			end

			local var_229_2 = 0.001

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2
				local var_229_4 = Vector3.New(-0.7, -0.97, -6)

				var_229_0.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1084ui_story, var_229_4, var_229_3)

				local var_229_5 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_5.x, var_229_5.y, var_229_5.z)

				local var_229_6 = var_229_0.localEulerAngles

				var_229_6.z = 0
				var_229_6.x = 0
				var_229_0.localEulerAngles = var_229_6
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 then
				var_229_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_229_7 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_7.x, var_229_7.y, var_229_7.z)

				local var_229_8 = var_229_0.localEulerAngles

				var_229_8.z = 0
				var_229_8.x = 0
				var_229_0.localEulerAngles = var_229_8
			end

			local var_229_9 = arg_226_1.actors_["1084ui_story"]
			local var_229_10 = 0

			if var_229_10 < arg_226_1.time_ and arg_226_1.time_ <= var_229_10 + arg_229_0 and not isNil(var_229_9) and arg_226_1.var_.characterEffect1084ui_story == nil then
				arg_226_1.var_.characterEffect1084ui_story = var_229_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_11 = 0.200000002980232

			if var_229_10 <= arg_226_1.time_ and arg_226_1.time_ < var_229_10 + var_229_11 and not isNil(var_229_9) then
				local var_229_12 = (arg_226_1.time_ - var_229_10) / var_229_11

				if arg_226_1.var_.characterEffect1084ui_story and not isNil(var_229_9) then
					arg_226_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_10 + var_229_11 and arg_226_1.time_ < var_229_10 + var_229_11 + arg_229_0 and not isNil(var_229_9) and arg_226_1.var_.characterEffect1084ui_story then
				arg_226_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_229_13 = 0

			if var_229_13 < arg_226_1.time_ and arg_226_1.time_ <= var_229_13 + arg_229_0 then
				arg_226_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_229_14 = 0

			if var_229_14 < arg_226_1.time_ and arg_226_1.time_ <= var_229_14 + arg_229_0 then
				arg_226_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_229_15 = arg_226_1.actors_["4040ui_story"]
			local var_229_16 = 0

			if var_229_16 < arg_226_1.time_ and arg_226_1.time_ <= var_229_16 + arg_229_0 and not isNil(var_229_15) and arg_226_1.var_.characterEffect4040ui_story == nil then
				arg_226_1.var_.characterEffect4040ui_story = var_229_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_17 = 0.200000002980232

			if var_229_16 <= arg_226_1.time_ and arg_226_1.time_ < var_229_16 + var_229_17 and not isNil(var_229_15) then
				local var_229_18 = (arg_226_1.time_ - var_229_16) / var_229_17

				if arg_226_1.var_.characterEffect4040ui_story and not isNil(var_229_15) then
					local var_229_19 = Mathf.Lerp(0, 0.5, var_229_18)

					arg_226_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_226_1.var_.characterEffect4040ui_story.fillRatio = var_229_19
				end
			end

			if arg_226_1.time_ >= var_229_16 + var_229_17 and arg_226_1.time_ < var_229_16 + var_229_17 + arg_229_0 and not isNil(var_229_15) and arg_226_1.var_.characterEffect4040ui_story then
				local var_229_20 = 0.5

				arg_226_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_226_1.var_.characterEffect4040ui_story.fillRatio = var_229_20
			end

			local var_229_21 = 0
			local var_229_22 = 1.1

			if var_229_21 < arg_226_1.time_ and arg_226_1.time_ <= var_229_21 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_23 = arg_226_1:FormatText(StoryNameCfg[6].name)

				arg_226_1.leftNameTxt_.text = var_229_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_24 = arg_226_1:GetWordFromCfg(319521054)
				local var_229_25 = arg_226_1:FormatText(var_229_24.content)

				arg_226_1.text_.text = var_229_25

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_26 = 44
				local var_229_27 = utf8.len(var_229_25)
				local var_229_28 = var_229_26 <= 0 and var_229_22 or var_229_22 * (var_229_27 / var_229_26)

				if var_229_28 > 0 and var_229_22 < var_229_28 then
					arg_226_1.talkMaxDuration = var_229_28

					if var_229_28 + var_229_21 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_28 + var_229_21
					end
				end

				arg_226_1.text_.text = var_229_25
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521054", "story_v_out_319521.awb") ~= 0 then
					local var_229_29 = manager.audio:GetVoiceLength("story_v_out_319521", "319521054", "story_v_out_319521.awb") / 1000

					if var_229_29 + var_229_21 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_29 + var_229_21
					end

					if var_229_24.prefab_name ~= "" and arg_226_1.actors_[var_229_24.prefab_name] ~= nil then
						local var_229_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_24.prefab_name].transform, "story_v_out_319521", "319521054", "story_v_out_319521.awb")

						arg_226_1:RecordAudio("319521054", var_229_30)
						arg_226_1:RecordAudio("319521054", var_229_30)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_319521", "319521054", "story_v_out_319521.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_319521", "319521054", "story_v_out_319521.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_31 = math.max(var_229_22, arg_226_1.talkMaxDuration)

			if var_229_21 <= arg_226_1.time_ and arg_226_1.time_ < var_229_21 + var_229_31 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_21) / var_229_31

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_21 + var_229_31 and arg_226_1.time_ < var_229_21 + var_229_31 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
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

		arg_226_1:InitPlayNodeList()
	end,
	Play319521055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 319521055
		arg_230_1.duration_ = 11.77

		local var_230_0 = {
			zh = 7.733,
			ja = 11.766
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play319521056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1084ui_story"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1084ui_story == nil then
				arg_230_1.var_.characterEffect1084ui_story = var_233_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.characterEffect1084ui_story and not isNil(var_233_0) then
					local var_233_4 = Mathf.Lerp(0, 0.5, var_233_3)

					arg_230_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1084ui_story.fillRatio = var_233_4
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1084ui_story then
				local var_233_5 = 0.5

				arg_230_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1084ui_story.fillRatio = var_233_5
			end

			local var_233_6 = arg_230_1.actors_["4040ui_story"]
			local var_233_7 = 0

			if var_233_7 < arg_230_1.time_ and arg_230_1.time_ <= var_233_7 + arg_233_0 and not isNil(var_233_6) and arg_230_1.var_.characterEffect4040ui_story == nil then
				arg_230_1.var_.characterEffect4040ui_story = var_233_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_8 = 0.200000002980232

			if var_233_7 <= arg_230_1.time_ and arg_230_1.time_ < var_233_7 + var_233_8 and not isNil(var_233_6) then
				local var_233_9 = (arg_230_1.time_ - var_233_7) / var_233_8

				if arg_230_1.var_.characterEffect4040ui_story and not isNil(var_233_6) then
					arg_230_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_7 + var_233_8 and arg_230_1.time_ < var_233_7 + var_233_8 + arg_233_0 and not isNil(var_233_6) and arg_230_1.var_.characterEffect4040ui_story then
				arg_230_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_233_10 = 0

			if var_233_10 < arg_230_1.time_ and arg_230_1.time_ <= var_233_10 + arg_233_0 then
				arg_230_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_233_11 = 0
			local var_233_12 = 0.85

			if var_233_11 < arg_230_1.time_ and arg_230_1.time_ <= var_233_11 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_13 = arg_230_1:FormatText(StoryNameCfg[668].name)

				arg_230_1.leftNameTxt_.text = var_233_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_14 = arg_230_1:GetWordFromCfg(319521055)
				local var_233_15 = arg_230_1:FormatText(var_233_14.content)

				arg_230_1.text_.text = var_233_15

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_16 = 34
				local var_233_17 = utf8.len(var_233_15)
				local var_233_18 = var_233_16 <= 0 and var_233_12 or var_233_12 * (var_233_17 / var_233_16)

				if var_233_18 > 0 and var_233_12 < var_233_18 then
					arg_230_1.talkMaxDuration = var_233_18

					if var_233_18 + var_233_11 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_18 + var_233_11
					end
				end

				arg_230_1.text_.text = var_233_15
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521055", "story_v_out_319521.awb") ~= 0 then
					local var_233_19 = manager.audio:GetVoiceLength("story_v_out_319521", "319521055", "story_v_out_319521.awb") / 1000

					if var_233_19 + var_233_11 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_19 + var_233_11
					end

					if var_233_14.prefab_name ~= "" and arg_230_1.actors_[var_233_14.prefab_name] ~= nil then
						local var_233_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_14.prefab_name].transform, "story_v_out_319521", "319521055", "story_v_out_319521.awb")

						arg_230_1:RecordAudio("319521055", var_233_20)
						arg_230_1:RecordAudio("319521055", var_233_20)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_319521", "319521055", "story_v_out_319521.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_319521", "319521055", "story_v_out_319521.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_21 = math.max(var_233_12, arg_230_1.talkMaxDuration)

			if var_233_11 <= arg_230_1.time_ and arg_230_1.time_ < var_233_11 + var_233_21 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_11) / var_233_21

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_11 + var_233_21 and arg_230_1.time_ < var_233_11 + var_233_21 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play319521056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 319521056
		arg_234_1.duration_ = 13.2

		local var_234_0 = {
			zh = 7.866,
			ja = 13.2
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
				arg_234_0:Play319521057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_237_1 = 0
			local var_237_2 = 0.9

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_3 = arg_234_1:FormatText(StoryNameCfg[668].name)

				arg_234_1.leftNameTxt_.text = var_237_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_4 = arg_234_1:GetWordFromCfg(319521056)
				local var_237_5 = arg_234_1:FormatText(var_237_4.content)

				arg_234_1.text_.text = var_237_5

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_6 = 36
				local var_237_7 = utf8.len(var_237_5)
				local var_237_8 = var_237_6 <= 0 and var_237_2 or var_237_2 * (var_237_7 / var_237_6)

				if var_237_8 > 0 and var_237_2 < var_237_8 then
					arg_234_1.talkMaxDuration = var_237_8

					if var_237_8 + var_237_1 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_8 + var_237_1
					end
				end

				arg_234_1.text_.text = var_237_5
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521056", "story_v_out_319521.awb") ~= 0 then
					local var_237_9 = manager.audio:GetVoiceLength("story_v_out_319521", "319521056", "story_v_out_319521.awb") / 1000

					if var_237_9 + var_237_1 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_9 + var_237_1
					end

					if var_237_4.prefab_name ~= "" and arg_234_1.actors_[var_237_4.prefab_name] ~= nil then
						local var_237_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_4.prefab_name].transform, "story_v_out_319521", "319521056", "story_v_out_319521.awb")

						arg_234_1:RecordAudio("319521056", var_237_10)
						arg_234_1:RecordAudio("319521056", var_237_10)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_319521", "319521056", "story_v_out_319521.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_319521", "319521056", "story_v_out_319521.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_11 = math.max(var_237_2, arg_234_1.talkMaxDuration)

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_11 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_1) / var_237_11

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_1 + var_237_11 and arg_234_1.time_ < var_237_1 + var_237_11 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play319521057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 319521057
		arg_238_1.duration_ = 5.1

		local var_238_0 = {
			zh = 4.3,
			ja = 5.1
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play319521058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_241_1 = arg_238_1.actors_["1084ui_story"]
			local var_241_2 = 0

			if var_241_2 < arg_238_1.time_ and arg_238_1.time_ <= var_241_2 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect1084ui_story == nil then
				arg_238_1.var_.characterEffect1084ui_story = var_241_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_3 = 0.2

			if var_241_2 <= arg_238_1.time_ and arg_238_1.time_ < var_241_2 + var_241_3 and not isNil(var_241_1) then
				local var_241_4 = (arg_238_1.time_ - var_241_2) / var_241_3

				if arg_238_1.var_.characterEffect1084ui_story and not isNil(var_241_1) then
					arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= var_241_2 + var_241_3 and arg_238_1.time_ < var_241_2 + var_241_3 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect1084ui_story then
				arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_241_5 = 0
			local var_241_6 = 0.575

			if var_241_5 < arg_238_1.time_ and arg_238_1.time_ <= var_241_5 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_7 = arg_238_1:FormatText(StoryNameCfg[6].name)

				arg_238_1.leftNameTxt_.text = var_241_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_8 = arg_238_1:GetWordFromCfg(319521057)
				local var_241_9 = arg_238_1:FormatText(var_241_8.content)

				arg_238_1.text_.text = var_241_9

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_10 = 23
				local var_241_11 = utf8.len(var_241_9)
				local var_241_12 = var_241_10 <= 0 and var_241_6 or var_241_6 * (var_241_11 / var_241_10)

				if var_241_12 > 0 and var_241_6 < var_241_12 then
					arg_238_1.talkMaxDuration = var_241_12

					if var_241_12 + var_241_5 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_12 + var_241_5
					end
				end

				arg_238_1.text_.text = var_241_9
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521057", "story_v_out_319521.awb") ~= 0 then
					local var_241_13 = manager.audio:GetVoiceLength("story_v_out_319521", "319521057", "story_v_out_319521.awb") / 1000

					if var_241_13 + var_241_5 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_13 + var_241_5
					end

					if var_241_8.prefab_name ~= "" and arg_238_1.actors_[var_241_8.prefab_name] ~= nil then
						local var_241_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_8.prefab_name].transform, "story_v_out_319521", "319521057", "story_v_out_319521.awb")

						arg_238_1:RecordAudio("319521057", var_241_14)
						arg_238_1:RecordAudio("319521057", var_241_14)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_319521", "319521057", "story_v_out_319521.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_319521", "319521057", "story_v_out_319521.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_15 = math.max(var_241_6, arg_238_1.talkMaxDuration)

			if var_241_5 <= arg_238_1.time_ and arg_238_1.time_ < var_241_5 + var_241_15 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_5) / var_241_15

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_5 + var_241_15 and arg_238_1.time_ < var_241_5 + var_241_15 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play319521058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 319521058
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play319521059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1084ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1084ui_story == nil then
				arg_242_1.var_.characterEffect1084ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect1084ui_story and not isNil(var_245_0) then
					local var_245_4 = Mathf.Lerp(0, 0.5, var_245_3)

					arg_242_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1084ui_story.fillRatio = var_245_4
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1084ui_story then
				local var_245_5 = 0.5

				arg_242_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1084ui_story.fillRatio = var_245_5
			end

			local var_245_6 = 0
			local var_245_7 = 0.8

			if var_245_6 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_8 = arg_242_1:GetWordFromCfg(319521058)
				local var_245_9 = arg_242_1:FormatText(var_245_8.content)

				arg_242_1.text_.text = var_245_9

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_10 = 32
				local var_245_11 = utf8.len(var_245_9)
				local var_245_12 = var_245_10 <= 0 and var_245_7 or var_245_7 * (var_245_11 / var_245_10)

				if var_245_12 > 0 and var_245_7 < var_245_12 then
					arg_242_1.talkMaxDuration = var_245_12

					if var_245_12 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_12 + var_245_6
					end
				end

				arg_242_1.text_.text = var_245_9
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_13 = math.max(var_245_7, arg_242_1.talkMaxDuration)

			if var_245_6 <= arg_242_1.time_ and arg_242_1.time_ < var_245_6 + var_245_13 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_6) / var_245_13

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_6 + var_245_13 and arg_242_1.time_ < var_245_6 + var_245_13 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play319521059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 319521059
		arg_246_1.duration_ = 6.23

		local var_246_0 = {
			zh = 6.233,
			ja = 6.066
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play319521060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["4040ui_story"].transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.moveOldPos4040ui_story = var_249_0.localPosition
			end

			local var_249_2 = 0.001

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2
				local var_249_4 = Vector3.New(0.7, -1.55, -5.5)

				var_249_0.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos4040ui_story, var_249_4, var_249_3)

				local var_249_5 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_5.x, var_249_5.y, var_249_5.z)

				local var_249_6 = var_249_0.localEulerAngles

				var_249_6.z = 0
				var_249_6.x = 0
				var_249_0.localEulerAngles = var_249_6
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 then
				var_249_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_249_7 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_7.x, var_249_7.y, var_249_7.z)

				local var_249_8 = var_249_0.localEulerAngles

				var_249_8.z = 0
				var_249_8.x = 0
				var_249_0.localEulerAngles = var_249_8
			end

			local var_249_9 = arg_246_1.actors_["4040ui_story"]
			local var_249_10 = 0

			if var_249_10 < arg_246_1.time_ and arg_246_1.time_ <= var_249_10 + arg_249_0 and not isNil(var_249_9) and arg_246_1.var_.characterEffect4040ui_story == nil then
				arg_246_1.var_.characterEffect4040ui_story = var_249_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_11 = 0.200000002980232

			if var_249_10 <= arg_246_1.time_ and arg_246_1.time_ < var_249_10 + var_249_11 and not isNil(var_249_9) then
				local var_249_12 = (arg_246_1.time_ - var_249_10) / var_249_11

				if arg_246_1.var_.characterEffect4040ui_story and not isNil(var_249_9) then
					arg_246_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= var_249_10 + var_249_11 and arg_246_1.time_ < var_249_10 + var_249_11 + arg_249_0 and not isNil(var_249_9) and arg_246_1.var_.characterEffect4040ui_story then
				arg_246_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_249_13 = 0

			if var_249_13 < arg_246_1.time_ and arg_246_1.time_ <= var_249_13 + arg_249_0 then
				arg_246_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			local var_249_14 = 0

			if var_249_14 < arg_246_1.time_ and arg_246_1.time_ <= var_249_14 + arg_249_0 then
				arg_246_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_249_15 = 0
			local var_249_16 = 0.55

			if var_249_15 < arg_246_1.time_ and arg_246_1.time_ <= var_249_15 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_17 = arg_246_1:FormatText(StoryNameCfg[668].name)

				arg_246_1.leftNameTxt_.text = var_249_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_18 = arg_246_1:GetWordFromCfg(319521059)
				local var_249_19 = arg_246_1:FormatText(var_249_18.content)

				arg_246_1.text_.text = var_249_19

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_20 = 22
				local var_249_21 = utf8.len(var_249_19)
				local var_249_22 = var_249_20 <= 0 and var_249_16 or var_249_16 * (var_249_21 / var_249_20)

				if var_249_22 > 0 and var_249_16 < var_249_22 then
					arg_246_1.talkMaxDuration = var_249_22

					if var_249_22 + var_249_15 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_22 + var_249_15
					end
				end

				arg_246_1.text_.text = var_249_19
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521059", "story_v_out_319521.awb") ~= 0 then
					local var_249_23 = manager.audio:GetVoiceLength("story_v_out_319521", "319521059", "story_v_out_319521.awb") / 1000

					if var_249_23 + var_249_15 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_23 + var_249_15
					end

					if var_249_18.prefab_name ~= "" and arg_246_1.actors_[var_249_18.prefab_name] ~= nil then
						local var_249_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_18.prefab_name].transform, "story_v_out_319521", "319521059", "story_v_out_319521.awb")

						arg_246_1:RecordAudio("319521059", var_249_24)
						arg_246_1:RecordAudio("319521059", var_249_24)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_319521", "319521059", "story_v_out_319521.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_319521", "319521059", "story_v_out_319521.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_25 = math.max(var_249_16, arg_246_1.talkMaxDuration)

			if var_249_15 <= arg_246_1.time_ and arg_246_1.time_ < var_249_15 + var_249_25 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_15) / var_249_25

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_15 + var_249_25 and arg_246_1.time_ < var_249_15 + var_249_25 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play319521060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 319521060
		arg_250_1.duration_ = 12.1

		local var_250_0 = {
			zh = 8.466,
			ja = 12.1
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play319521061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1084ui_story"].transform
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.var_.moveOldPos1084ui_story = var_253_0.localPosition
			end

			local var_253_2 = 0.001

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2
				local var_253_4 = Vector3.New(-0.7, -0.97, -6)

				var_253_0.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1084ui_story, var_253_4, var_253_3)

				local var_253_5 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_5.x, var_253_5.y, var_253_5.z)

				local var_253_6 = var_253_0.localEulerAngles

				var_253_6.z = 0
				var_253_6.x = 0
				var_253_0.localEulerAngles = var_253_6
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 then
				var_253_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_253_7 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_7.x, var_253_7.y, var_253_7.z)

				local var_253_8 = var_253_0.localEulerAngles

				var_253_8.z = 0
				var_253_8.x = 0
				var_253_0.localEulerAngles = var_253_8
			end

			local var_253_9 = arg_250_1.actors_["1084ui_story"]
			local var_253_10 = 0

			if var_253_10 < arg_250_1.time_ and arg_250_1.time_ <= var_253_10 + arg_253_0 and not isNil(var_253_9) and arg_250_1.var_.characterEffect1084ui_story == nil then
				arg_250_1.var_.characterEffect1084ui_story = var_253_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_11 = 0.200000002980232

			if var_253_10 <= arg_250_1.time_ and arg_250_1.time_ < var_253_10 + var_253_11 and not isNil(var_253_9) then
				local var_253_12 = (arg_250_1.time_ - var_253_10) / var_253_11

				if arg_250_1.var_.characterEffect1084ui_story and not isNil(var_253_9) then
					arg_250_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_10 + var_253_11 and arg_250_1.time_ < var_253_10 + var_253_11 + arg_253_0 and not isNil(var_253_9) and arg_250_1.var_.characterEffect1084ui_story then
				arg_250_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_253_13 = 0

			if var_253_13 < arg_250_1.time_ and arg_250_1.time_ <= var_253_13 + arg_253_0 then
				arg_250_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_253_14 = 0

			if var_253_14 < arg_250_1.time_ and arg_250_1.time_ <= var_253_14 + arg_253_0 then
				arg_250_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_253_15 = arg_250_1.actors_["4040ui_story"]
			local var_253_16 = 0

			if var_253_16 < arg_250_1.time_ and arg_250_1.time_ <= var_253_16 + arg_253_0 and not isNil(var_253_15) and arg_250_1.var_.characterEffect4040ui_story == nil then
				arg_250_1.var_.characterEffect4040ui_story = var_253_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_17 = 0.200000002980232

			if var_253_16 <= arg_250_1.time_ and arg_250_1.time_ < var_253_16 + var_253_17 and not isNil(var_253_15) then
				local var_253_18 = (arg_250_1.time_ - var_253_16) / var_253_17

				if arg_250_1.var_.characterEffect4040ui_story and not isNil(var_253_15) then
					local var_253_19 = Mathf.Lerp(0, 0.5, var_253_18)

					arg_250_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_250_1.var_.characterEffect4040ui_story.fillRatio = var_253_19
				end
			end

			if arg_250_1.time_ >= var_253_16 + var_253_17 and arg_250_1.time_ < var_253_16 + var_253_17 + arg_253_0 and not isNil(var_253_15) and arg_250_1.var_.characterEffect4040ui_story then
				local var_253_20 = 0.5

				arg_250_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_250_1.var_.characterEffect4040ui_story.fillRatio = var_253_20
			end

			local var_253_21 = 0
			local var_253_22 = 1.025

			if var_253_21 < arg_250_1.time_ and arg_250_1.time_ <= var_253_21 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_23 = arg_250_1:FormatText(StoryNameCfg[6].name)

				arg_250_1.leftNameTxt_.text = var_253_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_24 = arg_250_1:GetWordFromCfg(319521060)
				local var_253_25 = arg_250_1:FormatText(var_253_24.content)

				arg_250_1.text_.text = var_253_25

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_26 = 41
				local var_253_27 = utf8.len(var_253_25)
				local var_253_28 = var_253_26 <= 0 and var_253_22 or var_253_22 * (var_253_27 / var_253_26)

				if var_253_28 > 0 and var_253_22 < var_253_28 then
					arg_250_1.talkMaxDuration = var_253_28

					if var_253_28 + var_253_21 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_28 + var_253_21
					end
				end

				arg_250_1.text_.text = var_253_25
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521060", "story_v_out_319521.awb") ~= 0 then
					local var_253_29 = manager.audio:GetVoiceLength("story_v_out_319521", "319521060", "story_v_out_319521.awb") / 1000

					if var_253_29 + var_253_21 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_29 + var_253_21
					end

					if var_253_24.prefab_name ~= "" and arg_250_1.actors_[var_253_24.prefab_name] ~= nil then
						local var_253_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_24.prefab_name].transform, "story_v_out_319521", "319521060", "story_v_out_319521.awb")

						arg_250_1:RecordAudio("319521060", var_253_30)
						arg_250_1:RecordAudio("319521060", var_253_30)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_319521", "319521060", "story_v_out_319521.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_319521", "319521060", "story_v_out_319521.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_31 = math.max(var_253_22, arg_250_1.talkMaxDuration)

			if var_253_21 <= arg_250_1.time_ and arg_250_1.time_ < var_253_21 + var_253_31 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_21) / var_253_31

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_21 + var_253_31 and arg_250_1.time_ < var_253_21 + var_253_31 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
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

		arg_250_1:InitPlayNodeList()
	end,
	Play319521061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 319521061
		arg_254_1.duration_ = 10.4

		local var_254_0 = {
			zh = 3.566,
			ja = 10.4
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play319521062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1084ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1084ui_story == nil then
				arg_254_1.var_.characterEffect1084ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect1084ui_story and not isNil(var_257_0) then
					local var_257_4 = Mathf.Lerp(0, 0.5, var_257_3)

					arg_254_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1084ui_story.fillRatio = var_257_4
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1084ui_story then
				local var_257_5 = 0.5

				arg_254_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1084ui_story.fillRatio = var_257_5
			end

			local var_257_6 = arg_254_1.actors_["4040ui_story"]
			local var_257_7 = 0

			if var_257_7 < arg_254_1.time_ and arg_254_1.time_ <= var_257_7 + arg_257_0 and not isNil(var_257_6) and arg_254_1.var_.characterEffect4040ui_story == nil then
				arg_254_1.var_.characterEffect4040ui_story = var_257_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_8 = 0.200000002980232

			if var_257_7 <= arg_254_1.time_ and arg_254_1.time_ < var_257_7 + var_257_8 and not isNil(var_257_6) then
				local var_257_9 = (arg_254_1.time_ - var_257_7) / var_257_8

				if arg_254_1.var_.characterEffect4040ui_story and not isNil(var_257_6) then
					arg_254_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_7 + var_257_8 and arg_254_1.time_ < var_257_7 + var_257_8 + arg_257_0 and not isNil(var_257_6) and arg_254_1.var_.characterEffect4040ui_story then
				arg_254_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_257_10 = 0
			local var_257_11 = 0.4

			if var_257_10 < arg_254_1.time_ and arg_254_1.time_ <= var_257_10 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_12 = arg_254_1:FormatText(StoryNameCfg[668].name)

				arg_254_1.leftNameTxt_.text = var_257_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_13 = arg_254_1:GetWordFromCfg(319521061)
				local var_257_14 = arg_254_1:FormatText(var_257_13.content)

				arg_254_1.text_.text = var_257_14

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_15 = 16
				local var_257_16 = utf8.len(var_257_14)
				local var_257_17 = var_257_15 <= 0 and var_257_11 or var_257_11 * (var_257_16 / var_257_15)

				if var_257_17 > 0 and var_257_11 < var_257_17 then
					arg_254_1.talkMaxDuration = var_257_17

					if var_257_17 + var_257_10 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_17 + var_257_10
					end
				end

				arg_254_1.text_.text = var_257_14
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521061", "story_v_out_319521.awb") ~= 0 then
					local var_257_18 = manager.audio:GetVoiceLength("story_v_out_319521", "319521061", "story_v_out_319521.awb") / 1000

					if var_257_18 + var_257_10 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_18 + var_257_10
					end

					if var_257_13.prefab_name ~= "" and arg_254_1.actors_[var_257_13.prefab_name] ~= nil then
						local var_257_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_13.prefab_name].transform, "story_v_out_319521", "319521061", "story_v_out_319521.awb")

						arg_254_1:RecordAudio("319521061", var_257_19)
						arg_254_1:RecordAudio("319521061", var_257_19)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_319521", "319521061", "story_v_out_319521.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_319521", "319521061", "story_v_out_319521.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_20 = math.max(var_257_11, arg_254_1.talkMaxDuration)

			if var_257_10 <= arg_254_1.time_ and arg_254_1.time_ < var_257_10 + var_257_20 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_10) / var_257_20

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_10 + var_257_20 and arg_254_1.time_ < var_257_10 + var_257_20 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play319521062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 319521062
		arg_258_1.duration_ = 8.27

		local var_258_0 = {
			zh = 3.766,
			ja = 8.266
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play319521063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["4040ui_story"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect4040ui_story == nil then
				arg_258_1.var_.characterEffect4040ui_story = var_261_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.characterEffect4040ui_story and not isNil(var_261_0) then
					local var_261_4 = Mathf.Lerp(0, 0.5, var_261_3)

					arg_258_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_258_1.var_.characterEffect4040ui_story.fillRatio = var_261_4
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect4040ui_story then
				local var_261_5 = 0.5

				arg_258_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_258_1.var_.characterEffect4040ui_story.fillRatio = var_261_5
			end

			local var_261_6 = arg_258_1.actors_["1084ui_story"]
			local var_261_7 = 0

			if var_261_7 < arg_258_1.time_ and arg_258_1.time_ <= var_261_7 + arg_261_0 and not isNil(var_261_6) and arg_258_1.var_.characterEffect1084ui_story == nil then
				arg_258_1.var_.characterEffect1084ui_story = var_261_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_8 = 0.200000002980232

			if var_261_7 <= arg_258_1.time_ and arg_258_1.time_ < var_261_7 + var_261_8 and not isNil(var_261_6) then
				local var_261_9 = (arg_258_1.time_ - var_261_7) / var_261_8

				if arg_258_1.var_.characterEffect1084ui_story and not isNil(var_261_6) then
					arg_258_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_7 + var_261_8 and arg_258_1.time_ < var_261_7 + var_261_8 + arg_261_0 and not isNil(var_261_6) and arg_258_1.var_.characterEffect1084ui_story then
				arg_258_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_261_10 = 0

			if var_261_10 < arg_258_1.time_ and arg_258_1.time_ <= var_261_10 + arg_261_0 then
				arg_258_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_261_11 = 0

			if var_261_11 < arg_258_1.time_ and arg_258_1.time_ <= var_261_11 + arg_261_0 then
				arg_258_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_261_12 = 0
			local var_261_13 = 0.425

			if var_261_12 < arg_258_1.time_ and arg_258_1.time_ <= var_261_12 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_14 = arg_258_1:FormatText(StoryNameCfg[6].name)

				arg_258_1.leftNameTxt_.text = var_261_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_15 = arg_258_1:GetWordFromCfg(319521062)
				local var_261_16 = arg_258_1:FormatText(var_261_15.content)

				arg_258_1.text_.text = var_261_16

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_17 = 17
				local var_261_18 = utf8.len(var_261_16)
				local var_261_19 = var_261_17 <= 0 and var_261_13 or var_261_13 * (var_261_18 / var_261_17)

				if var_261_19 > 0 and var_261_13 < var_261_19 then
					arg_258_1.talkMaxDuration = var_261_19

					if var_261_19 + var_261_12 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_19 + var_261_12
					end
				end

				arg_258_1.text_.text = var_261_16
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521062", "story_v_out_319521.awb") ~= 0 then
					local var_261_20 = manager.audio:GetVoiceLength("story_v_out_319521", "319521062", "story_v_out_319521.awb") / 1000

					if var_261_20 + var_261_12 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_20 + var_261_12
					end

					if var_261_15.prefab_name ~= "" and arg_258_1.actors_[var_261_15.prefab_name] ~= nil then
						local var_261_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_15.prefab_name].transform, "story_v_out_319521", "319521062", "story_v_out_319521.awb")

						arg_258_1:RecordAudio("319521062", var_261_21)
						arg_258_1:RecordAudio("319521062", var_261_21)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_319521", "319521062", "story_v_out_319521.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_319521", "319521062", "story_v_out_319521.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_22 = math.max(var_261_13, arg_258_1.talkMaxDuration)

			if var_261_12 <= arg_258_1.time_ and arg_258_1.time_ < var_261_12 + var_261_22 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_12) / var_261_22

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_12 + var_261_22 and arg_258_1.time_ < var_261_12 + var_261_22 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play319521063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 319521063
		arg_262_1.duration_ = 6.47

		local var_262_0 = {
			zh = 5.666,
			ja = 6.466
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play319521064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["4040ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect4040ui_story == nil then
				arg_262_1.var_.characterEffect4040ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect4040ui_story and not isNil(var_265_0) then
					arg_262_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect4040ui_story then
				arg_262_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_265_4 = arg_262_1.actors_["1084ui_story"]
			local var_265_5 = 0

			if var_265_5 < arg_262_1.time_ and arg_262_1.time_ <= var_265_5 + arg_265_0 and not isNil(var_265_4) and arg_262_1.var_.characterEffect1084ui_story == nil then
				arg_262_1.var_.characterEffect1084ui_story = var_265_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_6 = 0.200000002980232

			if var_265_5 <= arg_262_1.time_ and arg_262_1.time_ < var_265_5 + var_265_6 and not isNil(var_265_4) then
				local var_265_7 = (arg_262_1.time_ - var_265_5) / var_265_6

				if arg_262_1.var_.characterEffect1084ui_story and not isNil(var_265_4) then
					local var_265_8 = Mathf.Lerp(0, 0.5, var_265_7)

					arg_262_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1084ui_story.fillRatio = var_265_8
				end
			end

			if arg_262_1.time_ >= var_265_5 + var_265_6 and arg_262_1.time_ < var_265_5 + var_265_6 + arg_265_0 and not isNil(var_265_4) and arg_262_1.var_.characterEffect1084ui_story then
				local var_265_9 = 0.5

				arg_262_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1084ui_story.fillRatio = var_265_9
			end

			local var_265_10 = 0

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 then
				arg_262_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_265_11 = 0

			if var_265_11 < arg_262_1.time_ and arg_262_1.time_ <= var_265_11 + arg_265_0 then
				arg_262_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_265_12 = 0
			local var_265_13 = 0.425

			if var_265_12 < arg_262_1.time_ and arg_262_1.time_ <= var_265_12 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_14 = arg_262_1:FormatText(StoryNameCfg[668].name)

				arg_262_1.leftNameTxt_.text = var_265_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_15 = arg_262_1:GetWordFromCfg(319521063)
				local var_265_16 = arg_262_1:FormatText(var_265_15.content)

				arg_262_1.text_.text = var_265_16

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_17 = 17
				local var_265_18 = utf8.len(var_265_16)
				local var_265_19 = var_265_17 <= 0 and var_265_13 or var_265_13 * (var_265_18 / var_265_17)

				if var_265_19 > 0 and var_265_13 < var_265_19 then
					arg_262_1.talkMaxDuration = var_265_19

					if var_265_19 + var_265_12 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_19 + var_265_12
					end
				end

				arg_262_1.text_.text = var_265_16
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521063", "story_v_out_319521.awb") ~= 0 then
					local var_265_20 = manager.audio:GetVoiceLength("story_v_out_319521", "319521063", "story_v_out_319521.awb") / 1000

					if var_265_20 + var_265_12 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_20 + var_265_12
					end

					if var_265_15.prefab_name ~= "" and arg_262_1.actors_[var_265_15.prefab_name] ~= nil then
						local var_265_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_15.prefab_name].transform, "story_v_out_319521", "319521063", "story_v_out_319521.awb")

						arg_262_1:RecordAudio("319521063", var_265_21)
						arg_262_1:RecordAudio("319521063", var_265_21)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_319521", "319521063", "story_v_out_319521.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_319521", "319521063", "story_v_out_319521.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_22 = math.max(var_265_13, arg_262_1.talkMaxDuration)

			if var_265_12 <= arg_262_1.time_ and arg_262_1.time_ < var_265_12 + var_265_22 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_12) / var_265_22

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_12 + var_265_22 and arg_262_1.time_ < var_265_12 + var_265_22 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play319521064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 319521064
		arg_266_1.duration_ = 13.37

		local var_266_0 = {
			zh = 8.966,
			ja = 13.366
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play319521065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 0.825

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_2 = arg_266_1:FormatText(StoryNameCfg[668].name)

				arg_266_1.leftNameTxt_.text = var_269_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_3 = arg_266_1:GetWordFromCfg(319521064)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 33
				local var_269_6 = utf8.len(var_269_4)
				local var_269_7 = var_269_5 <= 0 and var_269_1 or var_269_1 * (var_269_6 / var_269_5)

				if var_269_7 > 0 and var_269_1 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521064", "story_v_out_319521.awb") ~= 0 then
					local var_269_8 = manager.audio:GetVoiceLength("story_v_out_319521", "319521064", "story_v_out_319521.awb") / 1000

					if var_269_8 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_8 + var_269_0
					end

					if var_269_3.prefab_name ~= "" and arg_266_1.actors_[var_269_3.prefab_name] ~= nil then
						local var_269_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_3.prefab_name].transform, "story_v_out_319521", "319521064", "story_v_out_319521.awb")

						arg_266_1:RecordAudio("319521064", var_269_9)
						arg_266_1:RecordAudio("319521064", var_269_9)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_319521", "319521064", "story_v_out_319521.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_319521", "319521064", "story_v_out_319521.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_10 and arg_266_1.time_ < var_269_0 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play319521065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 319521065
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play319521066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["4040ui_story"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect4040ui_story == nil then
				arg_270_1.var_.characterEffect4040ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect4040ui_story and not isNil(var_273_0) then
					local var_273_4 = Mathf.Lerp(0, 0.5, var_273_3)

					arg_270_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_270_1.var_.characterEffect4040ui_story.fillRatio = var_273_4
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect4040ui_story then
				local var_273_5 = 0.5

				arg_270_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_270_1.var_.characterEffect4040ui_story.fillRatio = var_273_5
			end

			local var_273_6 = 0
			local var_273_7 = 1.15

			if var_273_6 < arg_270_1.time_ and arg_270_1.time_ <= var_273_6 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_8 = arg_270_1:GetWordFromCfg(319521065)
				local var_273_9 = arg_270_1:FormatText(var_273_8.content)

				arg_270_1.text_.text = var_273_9

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_10 = 46
				local var_273_11 = utf8.len(var_273_9)
				local var_273_12 = var_273_10 <= 0 and var_273_7 or var_273_7 * (var_273_11 / var_273_10)

				if var_273_12 > 0 and var_273_7 < var_273_12 then
					arg_270_1.talkMaxDuration = var_273_12

					if var_273_12 + var_273_6 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_12 + var_273_6
					end
				end

				arg_270_1.text_.text = var_273_9
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_13 = math.max(var_273_7, arg_270_1.talkMaxDuration)

			if var_273_6 <= arg_270_1.time_ and arg_270_1.time_ < var_273_6 + var_273_13 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_6) / var_273_13

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_6 + var_273_13 and arg_270_1.time_ < var_273_6 + var_273_13 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play319521066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 319521066
		arg_274_1.duration_ = 9.33

		local var_274_0 = {
			zh = 6.3,
			ja = 9.333
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
				arg_274_0:Play319521067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["4040ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos4040ui_story = var_277_0.localPosition
			end

			local var_277_2 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2
				local var_277_4 = Vector3.New(0.7, -1.55, -5.5)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos4040ui_story, var_277_4, var_277_3)

				local var_277_5 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_5.x, var_277_5.y, var_277_5.z)

				local var_277_6 = var_277_0.localEulerAngles

				var_277_6.z = 0
				var_277_6.x = 0
				var_277_0.localEulerAngles = var_277_6
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_277_7 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_7.x, var_277_7.y, var_277_7.z)

				local var_277_8 = var_277_0.localEulerAngles

				var_277_8.z = 0
				var_277_8.x = 0
				var_277_0.localEulerAngles = var_277_8
			end

			local var_277_9 = arg_274_1.actors_["4040ui_story"]
			local var_277_10 = 0

			if var_277_10 < arg_274_1.time_ and arg_274_1.time_ <= var_277_10 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect4040ui_story == nil then
				arg_274_1.var_.characterEffect4040ui_story = var_277_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_11 = 0.200000002980232

			if var_277_10 <= arg_274_1.time_ and arg_274_1.time_ < var_277_10 + var_277_11 and not isNil(var_277_9) then
				local var_277_12 = (arg_274_1.time_ - var_277_10) / var_277_11

				if arg_274_1.var_.characterEffect4040ui_story and not isNil(var_277_9) then
					arg_274_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_10 + var_277_11 and arg_274_1.time_ < var_277_10 + var_277_11 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect4040ui_story then
				arg_274_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_277_13 = 0

			if var_277_13 < arg_274_1.time_ and arg_274_1.time_ <= var_277_13 + arg_277_0 then
				arg_274_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			local var_277_14 = 0

			if var_277_14 < arg_274_1.time_ and arg_274_1.time_ <= var_277_14 + arg_277_0 then
				arg_274_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_277_15 = 0
			local var_277_16 = 0.6

			if var_277_15 < arg_274_1.time_ and arg_274_1.time_ <= var_277_15 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_17 = arg_274_1:FormatText(StoryNameCfg[668].name)

				arg_274_1.leftNameTxt_.text = var_277_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_18 = arg_274_1:GetWordFromCfg(319521066)
				local var_277_19 = arg_274_1:FormatText(var_277_18.content)

				arg_274_1.text_.text = var_277_19

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_20 = 24
				local var_277_21 = utf8.len(var_277_19)
				local var_277_22 = var_277_20 <= 0 and var_277_16 or var_277_16 * (var_277_21 / var_277_20)

				if var_277_22 > 0 and var_277_16 < var_277_22 then
					arg_274_1.talkMaxDuration = var_277_22

					if var_277_22 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_22 + var_277_15
					end
				end

				arg_274_1.text_.text = var_277_19
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319521", "319521066", "story_v_out_319521.awb") ~= 0 then
					local var_277_23 = manager.audio:GetVoiceLength("story_v_out_319521", "319521066", "story_v_out_319521.awb") / 1000

					if var_277_23 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_23 + var_277_15
					end

					if var_277_18.prefab_name ~= "" and arg_274_1.actors_[var_277_18.prefab_name] ~= nil then
						local var_277_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_18.prefab_name].transform, "story_v_out_319521", "319521066", "story_v_out_319521.awb")

						arg_274_1:RecordAudio("319521066", var_277_24)
						arg_274_1:RecordAudio("319521066", var_277_24)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_319521", "319521066", "story_v_out_319521.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_319521", "319521066", "story_v_out_319521.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_25 = math.max(var_277_16, arg_274_1.talkMaxDuration)

			if var_277_15 <= arg_274_1.time_ and arg_274_1.time_ < var_277_15 + var_277_25 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_15) / var_277_25

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_15 + var_277_25 and arg_274_1.time_ < var_277_15 + var_277_25 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play319521067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 319521067
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play319521068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["4040ui_story"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect4040ui_story == nil then
				arg_278_1.var_.characterEffect4040ui_story = var_281_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.200000002980232

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.characterEffect4040ui_story and not isNil(var_281_0) then
					local var_281_4 = Mathf.Lerp(0, 0.5, var_281_3)

					arg_278_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_278_1.var_.characterEffect4040ui_story.fillRatio = var_281_4
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect4040ui_story then
				local var_281_5 = 0.5

				arg_278_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_278_1.var_.characterEffect4040ui_story.fillRatio = var_281_5
			end

			local var_281_6 = arg_278_1.actors_["4040ui_story"].transform
			local var_281_7 = 0

			if var_281_7 < arg_278_1.time_ and arg_278_1.time_ <= var_281_7 + arg_281_0 then
				arg_278_1.var_.moveOldPos4040ui_story = var_281_6.localPosition
			end

			local var_281_8 = 0.001

			if var_281_7 <= arg_278_1.time_ and arg_278_1.time_ < var_281_7 + var_281_8 then
				local var_281_9 = (arg_278_1.time_ - var_281_7) / var_281_8
				local var_281_10 = Vector3.New(0, 100, 0)

				var_281_6.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos4040ui_story, var_281_10, var_281_9)

				local var_281_11 = manager.ui.mainCamera.transform.position - var_281_6.position

				var_281_6.forward = Vector3.New(var_281_11.x, var_281_11.y, var_281_11.z)

				local var_281_12 = var_281_6.localEulerAngles

				var_281_12.z = 0
				var_281_12.x = 0
				var_281_6.localEulerAngles = var_281_12
			end

			if arg_278_1.time_ >= var_281_7 + var_281_8 and arg_278_1.time_ < var_281_7 + var_281_8 + arg_281_0 then
				var_281_6.localPosition = Vector3.New(0, 100, 0)

				local var_281_13 = manager.ui.mainCamera.transform.position - var_281_6.position

				var_281_6.forward = Vector3.New(var_281_13.x, var_281_13.y, var_281_13.z)

				local var_281_14 = var_281_6.localEulerAngles

				var_281_14.z = 0
				var_281_14.x = 0
				var_281_6.localEulerAngles = var_281_14
			end

			local var_281_15 = arg_278_1.actors_["1084ui_story"].transform
			local var_281_16 = 0

			if var_281_16 < arg_278_1.time_ and arg_278_1.time_ <= var_281_16 + arg_281_0 then
				arg_278_1.var_.moveOldPos1084ui_story = var_281_15.localPosition
			end

			local var_281_17 = 0.001

			if var_281_16 <= arg_278_1.time_ and arg_278_1.time_ < var_281_16 + var_281_17 then
				local var_281_18 = (arg_278_1.time_ - var_281_16) / var_281_17
				local var_281_19 = Vector3.New(0, 100, 0)

				var_281_15.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1084ui_story, var_281_19, var_281_18)

				local var_281_20 = manager.ui.mainCamera.transform.position - var_281_15.position

				var_281_15.forward = Vector3.New(var_281_20.x, var_281_20.y, var_281_20.z)

				local var_281_21 = var_281_15.localEulerAngles

				var_281_21.z = 0
				var_281_21.x = 0
				var_281_15.localEulerAngles = var_281_21
			end

			if arg_278_1.time_ >= var_281_16 + var_281_17 and arg_278_1.time_ < var_281_16 + var_281_17 + arg_281_0 then
				var_281_15.localPosition = Vector3.New(0, 100, 0)

				local var_281_22 = manager.ui.mainCamera.transform.position - var_281_15.position

				var_281_15.forward = Vector3.New(var_281_22.x, var_281_22.y, var_281_22.z)

				local var_281_23 = var_281_15.localEulerAngles

				var_281_23.z = 0
				var_281_23.x = 0
				var_281_15.localEulerAngles = var_281_23
			end

			local var_281_24 = 0
			local var_281_25 = 1.275

			if var_281_24 < arg_278_1.time_ and arg_278_1.time_ <= var_281_24 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_26 = arg_278_1:GetWordFromCfg(319521067)
				local var_281_27 = arg_278_1:FormatText(var_281_26.content)

				arg_278_1.text_.text = var_281_27

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_28 = 51
				local var_281_29 = utf8.len(var_281_27)
				local var_281_30 = var_281_28 <= 0 and var_281_25 or var_281_25 * (var_281_29 / var_281_28)

				if var_281_30 > 0 and var_281_25 < var_281_30 then
					arg_278_1.talkMaxDuration = var_281_30

					if var_281_30 + var_281_24 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_30 + var_281_24
					end
				end

				arg_278_1.text_.text = var_281_27
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_31 = math.max(var_281_25, arg_278_1.talkMaxDuration)

			if var_281_24 <= arg_278_1.time_ and arg_278_1.time_ < var_281_24 + var_281_31 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_24) / var_281_31

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_24 + var_281_31 and arg_278_1.time_ < var_281_24 + var_281_31 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play319521068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 319521068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play319521069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 1.2

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_2 = arg_282_1:GetWordFromCfg(319521068)
				local var_285_3 = arg_282_1:FormatText(var_285_2.content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_4 = 48
				local var_285_5 = utf8.len(var_285_3)
				local var_285_6 = var_285_4 <= 0 and var_285_1 or var_285_1 * (var_285_5 / var_285_4)

				if var_285_6 > 0 and var_285_1 < var_285_6 then
					arg_282_1.talkMaxDuration = var_285_6

					if var_285_6 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_6 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_7 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_7 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_7

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_7 and arg_282_1.time_ < var_285_0 + var_285_7 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play319521069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 319521069
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play319521070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 1.65

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_2 = arg_286_1:GetWordFromCfg(319521069)
				local var_289_3 = arg_286_1:FormatText(var_289_2.content)

				arg_286_1.text_.text = var_289_3

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_4 = 66
				local var_289_5 = utf8.len(var_289_3)
				local var_289_6 = var_289_4 <= 0 and var_289_1 or var_289_1 * (var_289_5 / var_289_4)

				if var_289_6 > 0 and var_289_1 < var_289_6 then
					arg_286_1.talkMaxDuration = var_289_6

					if var_289_6 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_6 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_3
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_7 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_7 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_7

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_7 and arg_286_1.time_ < var_289_0 + var_289_7 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play319521070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 319521070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
			arg_290_1.auto_ = false
		end

		function arg_290_1.playNext_(arg_292_0)
			arg_290_1.onStoryFinished_()
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 1.6

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

				local var_293_2 = arg_290_1:GetWordFromCfg(319521070)
				local var_293_3 = arg_290_1:FormatText(var_293_2.content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_4 = 64
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
	assets = {
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/I11s",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319521.awb"
	}
}
