return {
	Play322061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322061001
		arg_1_1.duration_ = 7

		local var_1_0 = {
			zh = 6.1,
			ja = 7
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
				arg_1_0:Play322061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST61a"

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
				local var_4_5 = arg_1_1.bgs_.ST61a

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
					if iter_4_0 ~= "ST61a" then
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

			local var_4_24 = "1089ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1089ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1089ui_story = var_4_29.localPosition

				local var_4_31 = "1089ui_story"

				arg_1_1:ShowWeapon(arg_1_1.var_[var_4_31 .. "Animator"].transform, false)
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(0, -1.1, -6.17)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1089ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_4_37 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_37.x, var_4_37.y, var_4_37.z)

				local var_4_38 = var_4_29.localEulerAngles

				var_4_38.z = 0
				var_4_38.x = 0
				var_4_29.localEulerAngles = var_4_38
			end

			local var_4_39 = arg_1_1.actors_["1089ui_story"]
			local var_4_40 = 1.8

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1089ui_story == nil then
				arg_1_1.var_.characterEffect1089ui_story = var_4_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_41 = 0.200000002980232

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 and not isNil(var_4_39) then
				local var_4_42 = (arg_1_1.time_ - var_4_40) / var_4_41

				if arg_1_1.var_.characterEffect1089ui_story and not isNil(var_4_39) then
					arg_1_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1089ui_story then
				arg_1_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_4_45 = 0
			local var_4_46 = 0.3

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "music"

				arg_1_1:AudioAction(var_4_47, var_4_48, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_49 = ""
				local var_4_50 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_50 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_50 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_50

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_50
						arg_1_1.bgmTxt2_.text = var_4_50
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

			local var_4_51 = 0.3
			local var_4_52 = 1

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				local var_4_53 = "play"
				local var_4_54 = "effect"

				arg_1_1:AudioAction(var_4_53, var_4_54, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_55 = 2
			local var_4_56 = 0.425

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_57 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_57:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_58 = arg_1_1:FormatText(StoryNameCfg[1031].name)

				arg_1_1.leftNameTxt_.text = var_4_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_59 = arg_1_1:GetWordFromCfg(322061001)
				local var_4_60 = arg_1_1:FormatText(var_4_59.content)

				arg_1_1.text_.text = var_4_60

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_61 = 17
				local var_4_62 = utf8.len(var_4_60)
				local var_4_63 = var_4_61 <= 0 and var_4_56 or var_4_56 * (var_4_62 / var_4_61)

				if var_4_63 > 0 and var_4_56 < var_4_63 then
					arg_1_1.talkMaxDuration = var_4_63
					var_4_55 = var_4_55 + 0.3

					if var_4_63 + var_4_55 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_55
					end
				end

				arg_1_1.text_.text = var_4_60
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061001", "story_v_out_322061.awb") ~= 0 then
					local var_4_64 = manager.audio:GetVoiceLength("story_v_out_322061", "322061001", "story_v_out_322061.awb") / 1000

					if var_4_64 + var_4_55 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_55
					end

					if var_4_59.prefab_name ~= "" and arg_1_1.actors_[var_4_59.prefab_name] ~= nil then
						local var_4_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_59.prefab_name].transform, "story_v_out_322061", "322061001", "story_v_out_322061.awb")

						arg_1_1:RecordAudio("322061001", var_4_65)
						arg_1_1:RecordAudio("322061001", var_4_65)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322061", "322061001", "story_v_out_322061.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322061", "322061001", "story_v_out_322061.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_66 = var_4_55 + 0.3
			local var_4_67 = math.max(var_4_56, arg_1_1.talkMaxDuration)

			if var_4_66 <= arg_1_1.time_ and arg_1_1.time_ < var_4_66 + var_4_67 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_66) / var_4_67

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_66 + var_4_67 and arg_1_1.time_ < var_4_66 + var_4_67 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
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
	Play322061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 322061002
		arg_8_1.duration_ = 1.8

		local var_8_0 = {
			zh = 1.8,
			ja = 1.6
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play322061003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1089ui_story"].transform
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.var_.moveOldPos1089ui_story = var_11_0.localPosition
			end

			local var_11_2 = 0.001

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2
				local var_11_4 = Vector3.New(0, 100, 0)

				var_11_0.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1089ui_story, var_11_4, var_11_3)

				local var_11_5 = manager.ui.mainCamera.transform.position - var_11_0.position

				var_11_0.forward = Vector3.New(var_11_5.x, var_11_5.y, var_11_5.z)

				local var_11_6 = var_11_0.localEulerAngles

				var_11_6.z = 0
				var_11_6.x = 0
				var_11_0.localEulerAngles = var_11_6
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 then
				var_11_0.localPosition = Vector3.New(0, 100, 0)

				local var_11_7 = manager.ui.mainCamera.transform.position - var_11_0.position

				var_11_0.forward = Vector3.New(var_11_7.x, var_11_7.y, var_11_7.z)

				local var_11_8 = var_11_0.localEulerAngles

				var_11_8.z = 0
				var_11_8.x = 0
				var_11_0.localEulerAngles = var_11_8
			end

			local var_11_9 = arg_8_1.actors_["1089ui_story"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1089ui_story == nil then
				arg_8_1.var_.characterEffect1089ui_story = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.200000002980232

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect1089ui_story and not isNil(var_11_9) then
					local var_11_13 = Mathf.Lerp(0, 0.5, var_11_12)

					arg_8_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1089ui_story.fillRatio = var_11_13
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1089ui_story then
				local var_11_14 = 0.5

				arg_8_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1089ui_story.fillRatio = var_11_14
			end

			local var_11_15 = 0
			local var_11_16 = 0.200000002980232

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				local var_11_17 = "play"
				local var_11_18 = "music"

				arg_8_1:AudioAction(var_11_17, var_11_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_11_19 = ""
				local var_11_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_11_20 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_20 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_20

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_20
						arg_8_1.bgmTxt2_.text = var_11_20
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_21 = 0.333333333333333
			local var_11_22 = 1

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				local var_11_23 = "play"
				local var_11_24 = "music"

				arg_8_1:AudioAction(var_11_23, var_11_24, "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious.awb")

				local var_11_25 = ""
				local var_11_26 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious")

				if var_11_26 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_26 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_26

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_26
						arg_8_1.bgmTxt2_.text = var_11_26
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_27 = 0.34
			local var_11_28 = 1

			if var_11_27 < arg_8_1.time_ and arg_8_1.time_ <= var_11_27 + arg_11_0 then
				local var_11_29 = "play"
				local var_11_30 = "music"

				arg_8_1:AudioAction(var_11_29, var_11_30, "bgm_activity_4_5_story_serious", "init_story", "bgm_activity_4_5_story_serious.awb")

				local var_11_31 = ""
				local var_11_32 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "init_story")

				if var_11_32 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_32 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_32

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_32
						arg_8_1.bgmTxt2_.text = var_11_32
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_33 = 0
			local var_11_34 = 0.15

			if var_11_33 < arg_8_1.time_ and arg_8_1.time_ <= var_11_33 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_35 = arg_8_1:FormatText(StoryNameCfg[36].name)

				arg_8_1.leftNameTxt_.text = var_11_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_36 = arg_8_1:GetWordFromCfg(322061002)
				local var_11_37 = arg_8_1:FormatText(var_11_36.content)

				arg_8_1.text_.text = var_11_37

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_38 = 6
				local var_11_39 = utf8.len(var_11_37)
				local var_11_40 = var_11_38 <= 0 and var_11_34 or var_11_34 * (var_11_39 / var_11_38)

				if var_11_40 > 0 and var_11_34 < var_11_40 then
					arg_8_1.talkMaxDuration = var_11_40

					if var_11_40 + var_11_33 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_40 + var_11_33
					end
				end

				arg_8_1.text_.text = var_11_37
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061002", "story_v_out_322061.awb") ~= 0 then
					local var_11_41 = manager.audio:GetVoiceLength("story_v_out_322061", "322061002", "story_v_out_322061.awb") / 1000

					if var_11_41 + var_11_33 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_41 + var_11_33
					end

					if var_11_36.prefab_name ~= "" and arg_8_1.actors_[var_11_36.prefab_name] ~= nil then
						local var_11_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_36.prefab_name].transform, "story_v_out_322061", "322061002", "story_v_out_322061.awb")

						arg_8_1:RecordAudio("322061002", var_11_42)
						arg_8_1:RecordAudio("322061002", var_11_42)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_322061", "322061002", "story_v_out_322061.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_322061", "322061002", "story_v_out_322061.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_43 = math.max(var_11_34, arg_8_1.talkMaxDuration)

			if var_11_33 <= arg_8_1.time_ and arg_8_1.time_ < var_11_33 + var_11_43 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_33) / var_11_43

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_33 + var_11_43 and arg_8_1.time_ < var_11_33 + var_11_43 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play322061003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 322061003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play322061004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 1.275

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_2 = arg_15_1:GetWordFromCfg(322061003)
				local var_18_3 = arg_15_1:FormatText(var_18_2.content)

				arg_15_1.text_.text = var_18_3

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 51
				local var_18_5 = utf8.len(var_18_3)
				local var_18_6 = var_18_4 <= 0 and var_18_1 or var_18_1 * (var_18_5 / var_18_4)

				if var_18_6 > 0 and var_18_1 < var_18_6 then
					arg_15_1.talkMaxDuration = var_18_6

					if var_18_6 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_6 + var_18_0
					end
				end

				arg_15_1.text_.text = var_18_3
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_1, arg_15_1.talkMaxDuration)

			if var_18_0 <= arg_15_1.time_ and arg_15_1.time_ < var_18_0 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_0) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_0 + var_18_7 and arg_15_1.time_ < var_18_0 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play322061004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 322061004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play322061005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0
			local var_22_1 = 1.625

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_2 = arg_19_1:GetWordFromCfg(322061004)
				local var_22_3 = arg_19_1:FormatText(var_22_2.content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_4 = 65
				local var_22_5 = utf8.len(var_22_3)
				local var_22_6 = var_22_4 <= 0 and var_22_1 or var_22_1 * (var_22_5 / var_22_4)

				if var_22_6 > 0 and var_22_1 < var_22_6 then
					arg_19_1.talkMaxDuration = var_22_6

					if var_22_6 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_3
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_7 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_7 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_7

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_7 and arg_19_1.time_ < var_22_0 + var_22_7 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play322061005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 322061005
		arg_23_1.duration_ = 3.27

		local var_23_0 = {
			zh = 2.566,
			ja = 3.266
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
				arg_23_0:Play322061006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 0.25

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_2 = arg_23_1:FormatText(StoryNameCfg[36].name)

				arg_23_1.leftNameTxt_.text = var_26_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_3 = arg_23_1:GetWordFromCfg(322061005)
				local var_26_4 = arg_23_1:FormatText(var_26_3.content)

				arg_23_1.text_.text = var_26_4

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 10
				local var_26_6 = utf8.len(var_26_4)
				local var_26_7 = var_26_5 <= 0 and var_26_1 or var_26_1 * (var_26_6 / var_26_5)

				if var_26_7 > 0 and var_26_1 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_4
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061005", "story_v_out_322061.awb") ~= 0 then
					local var_26_8 = manager.audio:GetVoiceLength("story_v_out_322061", "322061005", "story_v_out_322061.awb") / 1000

					if var_26_8 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_8 + var_26_0
					end

					if var_26_3.prefab_name ~= "" and arg_23_1.actors_[var_26_3.prefab_name] ~= nil then
						local var_26_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_3.prefab_name].transform, "story_v_out_322061", "322061005", "story_v_out_322061.awb")

						arg_23_1:RecordAudio("322061005", var_26_9)
						arg_23_1:RecordAudio("322061005", var_26_9)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_322061", "322061005", "story_v_out_322061.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_322061", "322061005", "story_v_out_322061.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_10 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_10 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_10

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_10 and arg_23_1.time_ < var_26_0 + var_26_10 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play322061006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 322061006
		arg_27_1.duration_ = 14.33

		local var_27_0 = {
			zh = 10.5,
			ja = 14.333
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
				arg_27_0:Play322061007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1089ui_story"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos1089ui_story = var_30_0.localPosition

				local var_30_2 = "1089ui_story"

				arg_27_1:ShowWeapon(arg_27_1.var_[var_30_2 .. "Animator"].transform, false)
			end

			local var_30_3 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_3 then
				local var_30_4 = (arg_27_1.time_ - var_30_1) / var_30_3
				local var_30_5 = Vector3.New(0, -1.1, -6.17)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1089ui_story, var_30_5, var_30_4)

				local var_30_6 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_6.x, var_30_6.y, var_30_6.z)

				local var_30_7 = var_30_0.localEulerAngles

				var_30_7.z = 0
				var_30_7.x = 0
				var_30_0.localEulerAngles = var_30_7
			end

			if arg_27_1.time_ >= var_30_1 + var_30_3 and arg_27_1.time_ < var_30_1 + var_30_3 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_30_8 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_8.x, var_30_8.y, var_30_8.z)

				local var_30_9 = var_30_0.localEulerAngles

				var_30_9.z = 0
				var_30_9.x = 0
				var_30_0.localEulerAngles = var_30_9
			end

			local var_30_10 = arg_27_1.actors_["1089ui_story"]
			local var_30_11 = 0

			if var_30_11 < arg_27_1.time_ and arg_27_1.time_ <= var_30_11 + arg_30_0 and not isNil(var_30_10) and arg_27_1.var_.characterEffect1089ui_story == nil then
				arg_27_1.var_.characterEffect1089ui_story = var_30_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_12 = 0.200000002980232

			if var_30_11 <= arg_27_1.time_ and arg_27_1.time_ < var_30_11 + var_30_12 and not isNil(var_30_10) then
				local var_30_13 = (arg_27_1.time_ - var_30_11) / var_30_12

				if arg_27_1.var_.characterEffect1089ui_story and not isNil(var_30_10) then
					arg_27_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_11 + var_30_12 and arg_27_1.time_ < var_30_11 + var_30_12 + arg_30_0 and not isNil(var_30_10) and arg_27_1.var_.characterEffect1089ui_story then
				arg_27_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_30_14 = 0

			if var_30_14 < arg_27_1.time_ and arg_27_1.time_ <= var_30_14 + arg_30_0 then
				arg_27_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			local var_30_15 = 0

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 then
				arg_27_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_30_16 = 0
			local var_30_17 = 1.075

			if var_30_16 < arg_27_1.time_ and arg_27_1.time_ <= var_30_16 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_18 = arg_27_1:FormatText(StoryNameCfg[1031].name)

				arg_27_1.leftNameTxt_.text = var_30_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_19 = arg_27_1:GetWordFromCfg(322061006)
				local var_30_20 = arg_27_1:FormatText(var_30_19.content)

				arg_27_1.text_.text = var_30_20

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_21 = 43
				local var_30_22 = utf8.len(var_30_20)
				local var_30_23 = var_30_21 <= 0 and var_30_17 or var_30_17 * (var_30_22 / var_30_21)

				if var_30_23 > 0 and var_30_17 < var_30_23 then
					arg_27_1.talkMaxDuration = var_30_23

					if var_30_23 + var_30_16 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_23 + var_30_16
					end
				end

				arg_27_1.text_.text = var_30_20
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061006", "story_v_out_322061.awb") ~= 0 then
					local var_30_24 = manager.audio:GetVoiceLength("story_v_out_322061", "322061006", "story_v_out_322061.awb") / 1000

					if var_30_24 + var_30_16 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_24 + var_30_16
					end

					if var_30_19.prefab_name ~= "" and arg_27_1.actors_[var_30_19.prefab_name] ~= nil then
						local var_30_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_19.prefab_name].transform, "story_v_out_322061", "322061006", "story_v_out_322061.awb")

						arg_27_1:RecordAudio("322061006", var_30_25)
						arg_27_1:RecordAudio("322061006", var_30_25)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_322061", "322061006", "story_v_out_322061.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_322061", "322061006", "story_v_out_322061.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_26 = math.max(var_30_17, arg_27_1.talkMaxDuration)

			if var_30_16 <= arg_27_1.time_ and arg_27_1.time_ < var_30_16 + var_30_26 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_16) / var_30_26

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_16 + var_30_26 and arg_27_1.time_ < var_30_16 + var_30_26 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play322061007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 322061007
		arg_31_1.duration_ = 16.57

		local var_31_0 = {
			zh = 14.3,
			ja = 16.566
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
				arg_31_0:Play322061008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 1.35

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_2 = arg_31_1:FormatText(StoryNameCfg[1031].name)

				arg_31_1.leftNameTxt_.text = var_34_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_3 = arg_31_1:GetWordFromCfg(322061007)
				local var_34_4 = arg_31_1:FormatText(var_34_3.content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 54
				local var_34_6 = utf8.len(var_34_4)
				local var_34_7 = var_34_5 <= 0 and var_34_1 or var_34_1 * (var_34_6 / var_34_5)

				if var_34_7 > 0 and var_34_1 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_4
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061007", "story_v_out_322061.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_322061", "322061007", "story_v_out_322061.awb") / 1000

					if var_34_8 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_0
					end

					if var_34_3.prefab_name ~= "" and arg_31_1.actors_[var_34_3.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_3.prefab_name].transform, "story_v_out_322061", "322061007", "story_v_out_322061.awb")

						arg_31_1:RecordAudio("322061007", var_34_9)
						arg_31_1:RecordAudio("322061007", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_322061", "322061007", "story_v_out_322061.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_322061", "322061007", "story_v_out_322061.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_10 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_10

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_10 and arg_31_1.time_ < var_34_0 + var_34_10 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play322061008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 322061008
		arg_35_1.duration_ = 11.97

		local var_35_0 = {
			zh = 8.933,
			ja = 11.966
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
				arg_35_0:Play322061009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_38_2 = 0
			local var_38_3 = 0.9

			if var_38_2 < arg_35_1.time_ and arg_35_1.time_ <= var_38_2 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_4 = arg_35_1:FormatText(StoryNameCfg[1031].name)

				arg_35_1.leftNameTxt_.text = var_38_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_5 = arg_35_1:GetWordFromCfg(322061008)
				local var_38_6 = arg_35_1:FormatText(var_38_5.content)

				arg_35_1.text_.text = var_38_6

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 36
				local var_38_8 = utf8.len(var_38_6)
				local var_38_9 = var_38_7 <= 0 and var_38_3 or var_38_3 * (var_38_8 / var_38_7)

				if var_38_9 > 0 and var_38_3 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_2
					end
				end

				arg_35_1.text_.text = var_38_6
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061008", "story_v_out_322061.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_322061", "322061008", "story_v_out_322061.awb") / 1000

					if var_38_10 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_2
					end

					if var_38_5.prefab_name ~= "" and arg_35_1.actors_[var_38_5.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_5.prefab_name].transform, "story_v_out_322061", "322061008", "story_v_out_322061.awb")

						arg_35_1:RecordAudio("322061008", var_38_11)
						arg_35_1:RecordAudio("322061008", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_322061", "322061008", "story_v_out_322061.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_322061", "322061008", "story_v_out_322061.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_12 = math.max(var_38_3, arg_35_1.talkMaxDuration)

			if var_38_2 <= arg_35_1.time_ and arg_35_1.time_ < var_38_2 + var_38_12 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_2) / var_38_12

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_2 + var_38_12 and arg_35_1.time_ < var_38_2 + var_38_12 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play322061009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 322061009
		arg_39_1.duration_ = 12.9

		local var_39_0 = {
			zh = 9.2,
			ja = 12.9
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
				arg_39_0:Play322061010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1089ui_story"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1089ui_story == nil then
				arg_39_1.var_.characterEffect1089ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.characterEffect1089ui_story and not isNil(var_42_0) then
					local var_42_4 = Mathf.Lerp(0, 0.5, var_42_3)

					arg_39_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1089ui_story.fillRatio = var_42_4
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1089ui_story then
				local var_42_5 = 0.5

				arg_39_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1089ui_story.fillRatio = var_42_5
			end

			local var_42_6 = 0
			local var_42_7 = 0.975

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_8 = arg_39_1:FormatText(StoryNameCfg[36].name)

				arg_39_1.leftNameTxt_.text = var_42_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_9 = arg_39_1:GetWordFromCfg(322061009)
				local var_42_10 = arg_39_1:FormatText(var_42_9.content)

				arg_39_1.text_.text = var_42_10

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_11 = 39
				local var_42_12 = utf8.len(var_42_10)
				local var_42_13 = var_42_11 <= 0 and var_42_7 or var_42_7 * (var_42_12 / var_42_11)

				if var_42_13 > 0 and var_42_7 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_6
					end
				end

				arg_39_1.text_.text = var_42_10
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061009", "story_v_out_322061.awb") ~= 0 then
					local var_42_14 = manager.audio:GetVoiceLength("story_v_out_322061", "322061009", "story_v_out_322061.awb") / 1000

					if var_42_14 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_14 + var_42_6
					end

					if var_42_9.prefab_name ~= "" and arg_39_1.actors_[var_42_9.prefab_name] ~= nil then
						local var_42_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_9.prefab_name].transform, "story_v_out_322061", "322061009", "story_v_out_322061.awb")

						arg_39_1:RecordAudio("322061009", var_42_15)
						arg_39_1:RecordAudio("322061009", var_42_15)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_322061", "322061009", "story_v_out_322061.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_322061", "322061009", "story_v_out_322061.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_16 = math.max(var_42_7, arg_39_1.talkMaxDuration)

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_16 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_16

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_16 and arg_39_1.time_ < var_42_6 + var_42_16 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play322061010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 322061010
		arg_43_1.duration_ = 4.7

		local var_43_0 = {
			zh = 3.8,
			ja = 4.7
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play322061011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1089ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1089ui_story == nil then
				arg_43_1.var_.characterEffect1089ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect1089ui_story and not isNil(var_46_0) then
					arg_43_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1089ui_story then
				arg_43_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_46_4 = 0
			local var_46_5 = 0.375

			if var_46_4 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_6 = arg_43_1:FormatText(StoryNameCfg[1031].name)

				arg_43_1.leftNameTxt_.text = var_46_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_7 = arg_43_1:GetWordFromCfg(322061010)
				local var_46_8 = arg_43_1:FormatText(var_46_7.content)

				arg_43_1.text_.text = var_46_8

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 15
				local var_46_10 = utf8.len(var_46_8)
				local var_46_11 = var_46_9 <= 0 and var_46_5 or var_46_5 * (var_46_10 / var_46_9)

				if var_46_11 > 0 and var_46_5 < var_46_11 then
					arg_43_1.talkMaxDuration = var_46_11

					if var_46_11 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_11 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_8
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061010", "story_v_out_322061.awb") ~= 0 then
					local var_46_12 = manager.audio:GetVoiceLength("story_v_out_322061", "322061010", "story_v_out_322061.awb") / 1000

					if var_46_12 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_12 + var_46_4
					end

					if var_46_7.prefab_name ~= "" and arg_43_1.actors_[var_46_7.prefab_name] ~= nil then
						local var_46_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_7.prefab_name].transform, "story_v_out_322061", "322061010", "story_v_out_322061.awb")

						arg_43_1:RecordAudio("322061010", var_46_13)
						arg_43_1:RecordAudio("322061010", var_46_13)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_322061", "322061010", "story_v_out_322061.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_322061", "322061010", "story_v_out_322061.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_14 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_14 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_14

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_14 and arg_43_1.time_ < var_46_4 + var_46_14 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play322061011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 322061011
		arg_47_1.duration_ = 5.27

		local var_47_0 = {
			zh = 3.633,
			ja = 5.266
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
				arg_47_0:Play322061012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1089ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1089ui_story == nil then
				arg_47_1.var_.characterEffect1089ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect1089ui_story and not isNil(var_50_0) then
					local var_50_4 = Mathf.Lerp(0, 0.5, var_50_3)

					arg_47_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1089ui_story.fillRatio = var_50_4
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1089ui_story then
				local var_50_5 = 0.5

				arg_47_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1089ui_story.fillRatio = var_50_5
			end

			local var_50_6 = 0
			local var_50_7 = 0.375

			if var_50_6 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_8 = arg_47_1:FormatText(StoryNameCfg[36].name)

				arg_47_1.leftNameTxt_.text = var_50_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_9 = arg_47_1:GetWordFromCfg(322061011)
				local var_50_10 = arg_47_1:FormatText(var_50_9.content)

				arg_47_1.text_.text = var_50_10

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_11 = 15
				local var_50_12 = utf8.len(var_50_10)
				local var_50_13 = var_50_11 <= 0 and var_50_7 or var_50_7 * (var_50_12 / var_50_11)

				if var_50_13 > 0 and var_50_7 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_6
					end
				end

				arg_47_1.text_.text = var_50_10
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061011", "story_v_out_322061.awb") ~= 0 then
					local var_50_14 = manager.audio:GetVoiceLength("story_v_out_322061", "322061011", "story_v_out_322061.awb") / 1000

					if var_50_14 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_6
					end

					if var_50_9.prefab_name ~= "" and arg_47_1.actors_[var_50_9.prefab_name] ~= nil then
						local var_50_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_9.prefab_name].transform, "story_v_out_322061", "322061011", "story_v_out_322061.awb")

						arg_47_1:RecordAudio("322061011", var_50_15)
						arg_47_1:RecordAudio("322061011", var_50_15)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_322061", "322061011", "story_v_out_322061.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_322061", "322061011", "story_v_out_322061.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_7, arg_47_1.talkMaxDuration)

			if var_50_6 <= arg_47_1.time_ and arg_47_1.time_ < var_50_6 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_6) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_6 + var_50_16 and arg_47_1.time_ < var_50_6 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play322061012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 322061012
		arg_51_1.duration_ = 6.7

		local var_51_0 = {
			zh = 2.133,
			ja = 6.7
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play322061013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1089ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1089ui_story == nil then
				arg_51_1.var_.characterEffect1089ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect1089ui_story and not isNil(var_54_0) then
					arg_51_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1089ui_story then
				arg_51_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_54_4 = 0

			if var_54_4 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			local var_54_5 = 0
			local var_54_6 = 0.25

			if var_54_5 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_7 = arg_51_1:FormatText(StoryNameCfg[1031].name)

				arg_51_1.leftNameTxt_.text = var_54_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_8 = arg_51_1:GetWordFromCfg(322061012)
				local var_54_9 = arg_51_1:FormatText(var_54_8.content)

				arg_51_1.text_.text = var_54_9

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_10 = 10
				local var_54_11 = utf8.len(var_54_9)
				local var_54_12 = var_54_10 <= 0 and var_54_6 or var_54_6 * (var_54_11 / var_54_10)

				if var_54_12 > 0 and var_54_6 < var_54_12 then
					arg_51_1.talkMaxDuration = var_54_12

					if var_54_12 + var_54_5 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_12 + var_54_5
					end
				end

				arg_51_1.text_.text = var_54_9
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061012", "story_v_out_322061.awb") ~= 0 then
					local var_54_13 = manager.audio:GetVoiceLength("story_v_out_322061", "322061012", "story_v_out_322061.awb") / 1000

					if var_54_13 + var_54_5 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_5
					end

					if var_54_8.prefab_name ~= "" and arg_51_1.actors_[var_54_8.prefab_name] ~= nil then
						local var_54_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_8.prefab_name].transform, "story_v_out_322061", "322061012", "story_v_out_322061.awb")

						arg_51_1:RecordAudio("322061012", var_54_14)
						arg_51_1:RecordAudio("322061012", var_54_14)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_322061", "322061012", "story_v_out_322061.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_322061", "322061012", "story_v_out_322061.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_15 = math.max(var_54_6, arg_51_1.talkMaxDuration)

			if var_54_5 <= arg_51_1.time_ and arg_51_1.time_ < var_54_5 + var_54_15 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_5) / var_54_15

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_5 + var_54_15 and arg_51_1.time_ < var_54_5 + var_54_15 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play322061013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 322061013
		arg_55_1.duration_ = 10.2

		local var_55_0 = {
			zh = 8,
			ja = 10.2
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
				arg_55_0:Play322061014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_58_2 = 0
			local var_58_3 = 0.75

			if var_58_2 < arg_55_1.time_ and arg_55_1.time_ <= var_58_2 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_4 = arg_55_1:FormatText(StoryNameCfg[1031].name)

				arg_55_1.leftNameTxt_.text = var_58_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_5 = arg_55_1:GetWordFromCfg(322061013)
				local var_58_6 = arg_55_1:FormatText(var_58_5.content)

				arg_55_1.text_.text = var_58_6

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_7 = 30
				local var_58_8 = utf8.len(var_58_6)
				local var_58_9 = var_58_7 <= 0 and var_58_3 or var_58_3 * (var_58_8 / var_58_7)

				if var_58_9 > 0 and var_58_3 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_2 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_2
					end
				end

				arg_55_1.text_.text = var_58_6
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061013", "story_v_out_322061.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_out_322061", "322061013", "story_v_out_322061.awb") / 1000

					if var_58_10 + var_58_2 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_2
					end

					if var_58_5.prefab_name ~= "" and arg_55_1.actors_[var_58_5.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_5.prefab_name].transform, "story_v_out_322061", "322061013", "story_v_out_322061.awb")

						arg_55_1:RecordAudio("322061013", var_58_11)
						arg_55_1:RecordAudio("322061013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_322061", "322061013", "story_v_out_322061.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_322061", "322061013", "story_v_out_322061.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_3, arg_55_1.talkMaxDuration)

			if var_58_2 <= arg_55_1.time_ and arg_55_1.time_ < var_58_2 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_2) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_2 + var_58_12 and arg_55_1.time_ < var_58_2 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play322061014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 322061014
		arg_59_1.duration_ = 5.47

		local var_59_0 = {
			zh = 4.3,
			ja = 5.466
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
				arg_59_0:Play322061015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1089ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1089ui_story == nil then
				arg_59_1.var_.characterEffect1089ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1089ui_story and not isNil(var_62_0) then
					local var_62_4 = Mathf.Lerp(0, 0.5, var_62_3)

					arg_59_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1089ui_story.fillRatio = var_62_4
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1089ui_story then
				local var_62_5 = 0.5

				arg_59_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1089ui_story.fillRatio = var_62_5
			end

			local var_62_6 = 0
			local var_62_7 = 0.4

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_8 = arg_59_1:FormatText(StoryNameCfg[36].name)

				arg_59_1.leftNameTxt_.text = var_62_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_9 = arg_59_1:GetWordFromCfg(322061014)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 16
				local var_62_12 = utf8.len(var_62_10)
				local var_62_13 = var_62_11 <= 0 and var_62_7 or var_62_7 * (var_62_12 / var_62_11)

				if var_62_13 > 0 and var_62_7 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061014", "story_v_out_322061.awb") ~= 0 then
					local var_62_14 = manager.audio:GetVoiceLength("story_v_out_322061", "322061014", "story_v_out_322061.awb") / 1000

					if var_62_14 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_6
					end

					if var_62_9.prefab_name ~= "" and arg_59_1.actors_[var_62_9.prefab_name] ~= nil then
						local var_62_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_9.prefab_name].transform, "story_v_out_322061", "322061014", "story_v_out_322061.awb")

						arg_59_1:RecordAudio("322061014", var_62_15)
						arg_59_1:RecordAudio("322061014", var_62_15)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_322061", "322061014", "story_v_out_322061.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_322061", "322061014", "story_v_out_322061.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_16 and arg_59_1.time_ < var_62_6 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play322061015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 322061015
		arg_63_1.duration_ = 16.23

		local var_63_0 = {
			zh = 8.6,
			ja = 16.233
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play322061016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 1

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[36].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(322061015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 40
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061015", "story_v_out_322061.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_322061", "322061015", "story_v_out_322061.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_322061", "322061015", "story_v_out_322061.awb")

						arg_63_1:RecordAudio("322061015", var_66_9)
						arg_63_1:RecordAudio("322061015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_322061", "322061015", "story_v_out_322061.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_322061", "322061015", "story_v_out_322061.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_10 and arg_63_1.time_ < var_66_0 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play322061016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 322061016
		arg_67_1.duration_ = 6.27

		local var_67_0 = {
			zh = 4.433,
			ja = 6.266
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play322061017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1089ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1089ui_story == nil then
				arg_67_1.var_.characterEffect1089ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect1089ui_story and not isNil(var_70_0) then
					arg_67_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1089ui_story then
				arg_67_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_70_4 = 0

			if var_70_4 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_70_5 = 0

			if var_70_5 < arg_67_1.time_ and arg_67_1.time_ <= var_70_5 + arg_70_0 then
				arg_67_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_70_6 = 0
			local var_70_7 = 0.425

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_8 = arg_67_1:FormatText(StoryNameCfg[1031].name)

				arg_67_1.leftNameTxt_.text = var_70_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_9 = arg_67_1:GetWordFromCfg(322061016)
				local var_70_10 = arg_67_1:FormatText(var_70_9.content)

				arg_67_1.text_.text = var_70_10

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_11 = 17
				local var_70_12 = utf8.len(var_70_10)
				local var_70_13 = var_70_11 <= 0 and var_70_7 or var_70_7 * (var_70_12 / var_70_11)

				if var_70_13 > 0 and var_70_7 < var_70_13 then
					arg_67_1.talkMaxDuration = var_70_13

					if var_70_13 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_13 + var_70_6
					end
				end

				arg_67_1.text_.text = var_70_10
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061016", "story_v_out_322061.awb") ~= 0 then
					local var_70_14 = manager.audio:GetVoiceLength("story_v_out_322061", "322061016", "story_v_out_322061.awb") / 1000

					if var_70_14 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_14 + var_70_6
					end

					if var_70_9.prefab_name ~= "" and arg_67_1.actors_[var_70_9.prefab_name] ~= nil then
						local var_70_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_9.prefab_name].transform, "story_v_out_322061", "322061016", "story_v_out_322061.awb")

						arg_67_1:RecordAudio("322061016", var_70_15)
						arg_67_1:RecordAudio("322061016", var_70_15)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_322061", "322061016", "story_v_out_322061.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_322061", "322061016", "story_v_out_322061.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_16 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_16 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_16

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_16 and arg_67_1.time_ < var_70_6 + var_70_16 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play322061017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 322061017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play322061018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1089ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1089ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, 100, 0)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1089ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, 100, 0)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = arg_71_1.actors_["1089ui_story"]
			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1089ui_story == nil then
				arg_71_1.var_.characterEffect1089ui_story = var_74_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_11 = 0.200000002980232

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_11 and not isNil(var_74_9) then
				local var_74_12 = (arg_71_1.time_ - var_74_10) / var_74_11

				if arg_71_1.var_.characterEffect1089ui_story and not isNil(var_74_9) then
					local var_74_13 = Mathf.Lerp(0, 0.5, var_74_12)

					arg_71_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1089ui_story.fillRatio = var_74_13
				end
			end

			if arg_71_1.time_ >= var_74_10 + var_74_11 and arg_71_1.time_ < var_74_10 + var_74_11 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1089ui_story then
				local var_74_14 = 0.5

				arg_71_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1089ui_story.fillRatio = var_74_14
			end

			local var_74_15 = 0
			local var_74_16 = 1.15

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_17 = arg_71_1:GetWordFromCfg(322061017)
				local var_74_18 = arg_71_1:FormatText(var_74_17.content)

				arg_71_1.text_.text = var_74_18

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_19 = 46
				local var_74_20 = utf8.len(var_74_18)
				local var_74_21 = var_74_19 <= 0 and var_74_16 or var_74_16 * (var_74_20 / var_74_19)

				if var_74_21 > 0 and var_74_16 < var_74_21 then
					arg_71_1.talkMaxDuration = var_74_21

					if var_74_21 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_21 + var_74_15
					end
				end

				arg_71_1.text_.text = var_74_18
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_22 = math.max(var_74_16, arg_71_1.talkMaxDuration)

			if var_74_15 <= arg_71_1.time_ and arg_71_1.time_ < var_74_15 + var_74_22 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_15) / var_74_22

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_15 + var_74_22 and arg_71_1.time_ < var_74_15 + var_74_22 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play322061018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 322061018
		arg_75_1.duration_ = 5.47

		local var_75_0 = {
			zh = 5.233,
			ja = 5.466
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
				arg_75_0:Play322061019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = "L15h"

			if arg_75_1.bgs_[var_78_0] == nil then
				local var_78_1 = Object.Instantiate(arg_75_1.paintGo_)

				var_78_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_78_0)
				var_78_1.name = var_78_0
				var_78_1.transform.parent = arg_75_1.stage_.transform
				var_78_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.bgs_[var_78_0] = var_78_1
			end

			local var_78_2 = 2

			if var_78_2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				local var_78_3 = manager.ui.mainCamera.transform.localPosition
				local var_78_4 = Vector3.New(0, 0, 10) + Vector3.New(var_78_3.x, var_78_3.y, 0)
				local var_78_5 = arg_75_1.bgs_.L15h

				var_78_5.transform.localPosition = var_78_4
				var_78_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_78_6 = var_78_5:GetComponent("SpriteRenderer")

				if var_78_6 and var_78_6.sprite then
					local var_78_7 = (var_78_5.transform.localPosition - var_78_3).z
					local var_78_8 = manager.ui.mainCameraCom_
					local var_78_9 = 2 * var_78_7 * Mathf.Tan(var_78_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_78_10 = var_78_9 * var_78_8.aspect
					local var_78_11 = var_78_6.sprite.bounds.size.x
					local var_78_12 = var_78_6.sprite.bounds.size.y
					local var_78_13 = var_78_10 / var_78_11
					local var_78_14 = var_78_9 / var_78_12
					local var_78_15 = var_78_14 < var_78_13 and var_78_13 or var_78_14

					var_78_5.transform.localScale = Vector3.New(var_78_15, var_78_15, 0)
				end

				for iter_78_0, iter_78_1 in pairs(arg_75_1.bgs_) do
					if iter_78_0 ~= "L15h" then
						iter_78_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_78_16 = 4

			if var_78_16 < arg_75_1.time_ and arg_75_1.time_ <= var_78_16 + arg_78_0 then
				arg_75_1.allBtn_.enabled = false
			end

			local var_78_17 = 0.3

			if arg_75_1.time_ >= var_78_16 + var_78_17 and arg_75_1.time_ < var_78_16 + var_78_17 + arg_78_0 then
				arg_75_1.allBtn_.enabled = true
			end

			local var_78_18 = 0

			if var_78_18 < arg_75_1.time_ and arg_75_1.time_ <= var_78_18 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_19 = 2

			if var_78_18 <= arg_75_1.time_ and arg_75_1.time_ < var_78_18 + var_78_19 then
				local var_78_20 = (arg_75_1.time_ - var_78_18) / var_78_19
				local var_78_21 = Color.New(0, 0, 0)

				var_78_21.a = Mathf.Lerp(0, 1, var_78_20)
				arg_75_1.mask_.color = var_78_21
			end

			if arg_75_1.time_ >= var_78_18 + var_78_19 and arg_75_1.time_ < var_78_18 + var_78_19 + arg_78_0 then
				local var_78_22 = Color.New(0, 0, 0)

				var_78_22.a = 1
				arg_75_1.mask_.color = var_78_22
			end

			local var_78_23 = 2

			if var_78_23 < arg_75_1.time_ and arg_75_1.time_ <= var_78_23 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_24 = 2

			if var_78_23 <= arg_75_1.time_ and arg_75_1.time_ < var_78_23 + var_78_24 then
				local var_78_25 = (arg_75_1.time_ - var_78_23) / var_78_24
				local var_78_26 = Color.New(0, 0, 0)

				var_78_26.a = Mathf.Lerp(1, 0, var_78_25)
				arg_75_1.mask_.color = var_78_26
			end

			if arg_75_1.time_ >= var_78_23 + var_78_24 and arg_75_1.time_ < var_78_23 + var_78_24 + arg_78_0 then
				local var_78_27 = Color.New(0, 0, 0)
				local var_78_28 = 0

				arg_75_1.mask_.enabled = false
				var_78_27.a = var_78_28
				arg_75_1.mask_.color = var_78_27
			end

			local var_78_29 = 0.1
			local var_78_30 = 1

			if var_78_29 < arg_75_1.time_ and arg_75_1.time_ <= var_78_29 + arg_78_0 then
				local var_78_31 = "stop"
				local var_78_32 = "effect"

				arg_75_1:AudioAction(var_78_31, var_78_32, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_78_33 = 1.66666666666667
			local var_78_34 = 1

			if var_78_33 < arg_75_1.time_ and arg_75_1.time_ <= var_78_33 + arg_78_0 then
				local var_78_35 = "play"
				local var_78_36 = "effect"

				arg_75_1:AudioAction(var_78_35, var_78_36, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_78_37 = 1.66666666666667
			local var_78_38 = 1

			if var_78_37 < arg_75_1.time_ and arg_75_1.time_ <= var_78_37 + arg_78_0 then
				local var_78_39 = "play"
				local var_78_40 = "music"

				arg_75_1:AudioAction(var_78_39, var_78_40, "bgm_activity_4_5_story_serious", "battle", "bgm_activity_4_5_story_serious.awb")

				local var_78_41 = ""
				local var_78_42 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "battle")

				if var_78_42 ~= "" then
					if arg_75_1.bgmTxt_.text ~= var_78_42 and arg_75_1.bgmTxt_.text ~= "" then
						if arg_75_1.bgmTxt2_.text ~= "" then
							arg_75_1.bgmTxt_.text = arg_75_1.bgmTxt2_.text
						end

						arg_75_1.bgmTxt2_.text = var_78_42

						arg_75_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_75_1.bgmTxt_.text = var_78_42
						arg_75_1.bgmTxt2_.text = var_78_42
					end

					if arg_75_1.bgmTimer then
						arg_75_1.bgmTimer:Stop()

						arg_75_1.bgmTimer = nil
					end

					if arg_75_1.settingData.show_music_name == 1 then
						arg_75_1.musicController:SetSelectedState("show")
						arg_75_1.musicAnimator_:Play("open", 0, 0)

						if arg_75_1.settingData.music_time ~= 0 then
							arg_75_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_75_1.settingData.music_time), function()
								if arg_75_1 == nil or isNil(arg_75_1.bgmTxt_) then
									return
								end

								arg_75_1.musicController:SetSelectedState("hide")
								arg_75_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_75_1.frameCnt_ <= 1 then
				arg_75_1.dialog_:SetActive(false)
			end

			local var_78_43 = 4
			local var_78_44 = 0.125

			if var_78_43 < arg_75_1.time_ and arg_75_1.time_ <= var_78_43 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				arg_75_1.dialog_:SetActive(true)

				arg_75_1.dialogCg_.alpha = 0

				local var_78_45 = LeanTween.value(arg_75_1.dialog_, 0, 1, 0.3)

				var_78_45:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_75_1.dialogCg_.alpha = arg_80_0
				end))
				var_78_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_75_1.dialog_)
					var_78_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_75_1.duration_ = arg_75_1.duration_ + 0.3

				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_46 = arg_75_1:FormatText(StoryNameCfg[6].name)

				arg_75_1.leftNameTxt_.text = var_78_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_47 = arg_75_1:GetWordFromCfg(322061018)
				local var_78_48 = arg_75_1:FormatText(var_78_47.content)

				arg_75_1.text_.text = var_78_48

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_49 = 3
				local var_78_50 = utf8.len(var_78_48)
				local var_78_51 = var_78_49 <= 0 and var_78_44 or var_78_44 * (var_78_50 / var_78_49)

				if var_78_51 > 0 and var_78_44 < var_78_51 then
					arg_75_1.talkMaxDuration = var_78_51
					var_78_43 = var_78_43 + 0.3

					if var_78_51 + var_78_43 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_51 + var_78_43
					end
				end

				arg_75_1.text_.text = var_78_48
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061018", "story_v_out_322061.awb") ~= 0 then
					local var_78_52 = manager.audio:GetVoiceLength("story_v_out_322061", "322061018", "story_v_out_322061.awb") / 1000

					if var_78_52 + var_78_43 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_52 + var_78_43
					end

					if var_78_47.prefab_name ~= "" and arg_75_1.actors_[var_78_47.prefab_name] ~= nil then
						local var_78_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_47.prefab_name].transform, "story_v_out_322061", "322061018", "story_v_out_322061.awb")

						arg_75_1:RecordAudio("322061018", var_78_53)
						arg_75_1:RecordAudio("322061018", var_78_53)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_322061", "322061018", "story_v_out_322061.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_322061", "322061018", "story_v_out_322061.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_54 = var_78_43 + 0.3
			local var_78_55 = math.max(var_78_44, arg_75_1.talkMaxDuration)

			if var_78_54 <= arg_75_1.time_ and arg_75_1.time_ < var_78_54 + var_78_55 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_54) / var_78_55

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_54 + var_78_55 and arg_75_1.time_ < var_78_54 + var_78_55 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play322061019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 322061019
		arg_82_1.duration_ = 3.27

		local var_82_0 = {
			zh = 3.033,
			ja = 3.266
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
				arg_82_0:Play322061020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = "404001ui_story"

			if arg_82_1.actors_[var_85_0] == nil then
				local var_85_1 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_85_1) then
					local var_85_2 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_82_1.stage_.transform)

					var_85_2.name = var_85_0
					var_85_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_82_1.actors_[var_85_0] = var_85_2

					local var_85_3 = var_85_2:GetComponentInChildren(typeof(CharacterEffect))

					var_85_3.enabled = true

					local var_85_4 = GameObjectTools.GetOrAddComponent(var_85_2, typeof(DynamicBoneHelper))

					if var_85_4 then
						var_85_4:EnableDynamicBone(false)
					end

					arg_82_1:ShowWeapon(var_85_3.transform, false)

					arg_82_1.var_[var_85_0 .. "Animator"] = var_85_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_82_1.var_[var_85_0 .. "Animator"].applyRootMotion = true
					arg_82_1.var_[var_85_0 .. "LipSync"] = var_85_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_85_5 = arg_82_1.actors_["404001ui_story"].transform
			local var_85_6 = 0

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.var_.moveOldPos404001ui_story = var_85_5.localPosition
			end

			local var_85_7 = 0.001

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_7 then
				local var_85_8 = (arg_82_1.time_ - var_85_6) / var_85_7
				local var_85_9 = Vector3.New(0, -1.55, -5.5)

				var_85_5.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos404001ui_story, var_85_9, var_85_8)

				local var_85_10 = manager.ui.mainCamera.transform.position - var_85_5.position

				var_85_5.forward = Vector3.New(var_85_10.x, var_85_10.y, var_85_10.z)

				local var_85_11 = var_85_5.localEulerAngles

				var_85_11.z = 0
				var_85_11.x = 0
				var_85_5.localEulerAngles = var_85_11
			end

			if arg_82_1.time_ >= var_85_6 + var_85_7 and arg_82_1.time_ < var_85_6 + var_85_7 + arg_85_0 then
				var_85_5.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_85_12 = manager.ui.mainCamera.transform.position - var_85_5.position

				var_85_5.forward = Vector3.New(var_85_12.x, var_85_12.y, var_85_12.z)

				local var_85_13 = var_85_5.localEulerAngles

				var_85_13.z = 0
				var_85_13.x = 0
				var_85_5.localEulerAngles = var_85_13
			end

			local var_85_14 = arg_82_1.actors_["404001ui_story"]
			local var_85_15 = 0

			if var_85_15 < arg_82_1.time_ and arg_82_1.time_ <= var_85_15 + arg_85_0 and not isNil(var_85_14) and arg_82_1.var_.characterEffect404001ui_story == nil then
				arg_82_1.var_.characterEffect404001ui_story = var_85_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_16 = 0.200000002980232

			if var_85_15 <= arg_82_1.time_ and arg_82_1.time_ < var_85_15 + var_85_16 and not isNil(var_85_14) then
				local var_85_17 = (arg_82_1.time_ - var_85_15) / var_85_16

				if arg_82_1.var_.characterEffect404001ui_story and not isNil(var_85_14) then
					arg_82_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_15 + var_85_16 and arg_82_1.time_ < var_85_15 + var_85_16 + arg_85_0 and not isNil(var_85_14) and arg_82_1.var_.characterEffect404001ui_story then
				arg_82_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_85_18 = 0

			if var_85_18 < arg_82_1.time_ and arg_82_1.time_ <= var_85_18 + arg_85_0 then
				arg_82_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_85_19 = 0

			if var_85_19 < arg_82_1.time_ and arg_82_1.time_ <= var_85_19 + arg_85_0 then
				arg_82_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_85_20 = 0
			local var_85_21 = 0.275

			if var_85_20 < arg_82_1.time_ and arg_82_1.time_ <= var_85_20 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_22 = arg_82_1:FormatText(StoryNameCfg[668].name)

				arg_82_1.leftNameTxt_.text = var_85_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_23 = arg_82_1:GetWordFromCfg(322061019)
				local var_85_24 = arg_82_1:FormatText(var_85_23.content)

				arg_82_1.text_.text = var_85_24

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_25 = 11
				local var_85_26 = utf8.len(var_85_24)
				local var_85_27 = var_85_25 <= 0 and var_85_21 or var_85_21 * (var_85_26 / var_85_25)

				if var_85_27 > 0 and var_85_21 < var_85_27 then
					arg_82_1.talkMaxDuration = var_85_27

					if var_85_27 + var_85_20 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_27 + var_85_20
					end
				end

				arg_82_1.text_.text = var_85_24
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061019", "story_v_out_322061.awb") ~= 0 then
					local var_85_28 = manager.audio:GetVoiceLength("story_v_out_322061", "322061019", "story_v_out_322061.awb") / 1000

					if var_85_28 + var_85_20 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_28 + var_85_20
					end

					if var_85_23.prefab_name ~= "" and arg_82_1.actors_[var_85_23.prefab_name] ~= nil then
						local var_85_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_23.prefab_name].transform, "story_v_out_322061", "322061019", "story_v_out_322061.awb")

						arg_82_1:RecordAudio("322061019", var_85_29)
						arg_82_1:RecordAudio("322061019", var_85_29)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_322061", "322061019", "story_v_out_322061.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_322061", "322061019", "story_v_out_322061.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_30 = math.max(var_85_21, arg_82_1.talkMaxDuration)

			if var_85_20 <= arg_82_1.time_ and arg_82_1.time_ < var_85_20 + var_85_30 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_20) / var_85_30

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_20 + var_85_30 and arg_82_1.time_ < var_85_20 + var_85_30 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play322061020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 322061020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play322061021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["404001ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos404001ui_story = var_89_0.localPosition
			end

			local var_89_2 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2
				local var_89_4 = Vector3.New(0, 100, 0)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos404001ui_story, var_89_4, var_89_3)

				local var_89_5 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_5.x, var_89_5.y, var_89_5.z)

				local var_89_6 = var_89_0.localEulerAngles

				var_89_6.z = 0
				var_89_6.x = 0
				var_89_0.localEulerAngles = var_89_6
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0, 100, 0)

				local var_89_7 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_7.x, var_89_7.y, var_89_7.z)

				local var_89_8 = var_89_0.localEulerAngles

				var_89_8.z = 0
				var_89_8.x = 0
				var_89_0.localEulerAngles = var_89_8
			end

			local var_89_9 = arg_86_1.actors_["404001ui_story"]
			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect404001ui_story == nil then
				arg_86_1.var_.characterEffect404001ui_story = var_89_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_11 = 0.200000002980232

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_11 and not isNil(var_89_9) then
				local var_89_12 = (arg_86_1.time_ - var_89_10) / var_89_11

				if arg_86_1.var_.characterEffect404001ui_story and not isNil(var_89_9) then
					local var_89_13 = Mathf.Lerp(0, 0.5, var_89_12)

					arg_86_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_86_1.var_.characterEffect404001ui_story.fillRatio = var_89_13
				end
			end

			if arg_86_1.time_ >= var_89_10 + var_89_11 and arg_86_1.time_ < var_89_10 + var_89_11 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect404001ui_story then
				local var_89_14 = 0.5

				arg_86_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_86_1.var_.characterEffect404001ui_story.fillRatio = var_89_14
			end

			local var_89_15 = 0
			local var_89_16 = 1.1

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_17 = arg_86_1:GetWordFromCfg(322061020)
				local var_89_18 = arg_86_1:FormatText(var_89_17.content)

				arg_86_1.text_.text = var_89_18

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_19 = 44
				local var_89_20 = utf8.len(var_89_18)
				local var_89_21 = var_89_19 <= 0 and var_89_16 or var_89_16 * (var_89_20 / var_89_19)

				if var_89_21 > 0 and var_89_16 < var_89_21 then
					arg_86_1.talkMaxDuration = var_89_21

					if var_89_21 + var_89_15 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_21 + var_89_15
					end
				end

				arg_86_1.text_.text = var_89_18
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_22 = math.max(var_89_16, arg_86_1.talkMaxDuration)

			if var_89_15 <= arg_86_1.time_ and arg_86_1.time_ < var_89_15 + var_89_22 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_15) / var_89_22

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_15 + var_89_22 and arg_86_1.time_ < var_89_15 + var_89_22 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play322061021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 322061021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play322061022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 1.5

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_2 = arg_90_1:GetWordFromCfg(322061021)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 60
				local var_93_5 = utf8.len(var_93_3)
				local var_93_6 = var_93_4 <= 0 and var_93_1 or var_93_1 * (var_93_5 / var_93_4)

				if var_93_6 > 0 and var_93_1 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_7 and arg_90_1.time_ < var_93_0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play322061022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 322061022
		arg_94_1.duration_ = 3.93

		local var_94_0 = {
			zh = 2.766,
			ja = 3.933
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play322061023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = "1156ui_story"

			if arg_94_1.actors_[var_97_0] == nil then
				local var_97_1 = Asset.Load("Char/" .. "1156ui_story")

				if not isNil(var_97_1) then
					local var_97_2 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_94_1.stage_.transform)

					var_97_2.name = var_97_0
					var_97_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_94_1.actors_[var_97_0] = var_97_2

					local var_97_3 = var_97_2:GetComponentInChildren(typeof(CharacterEffect))

					var_97_3.enabled = true

					local var_97_4 = GameObjectTools.GetOrAddComponent(var_97_2, typeof(DynamicBoneHelper))

					if var_97_4 then
						var_97_4:EnableDynamicBone(false)
					end

					arg_94_1:ShowWeapon(var_97_3.transform, false)

					arg_94_1.var_[var_97_0 .. "Animator"] = var_97_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_94_1.var_[var_97_0 .. "Animator"].applyRootMotion = true
					arg_94_1.var_[var_97_0 .. "LipSync"] = var_97_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_97_5 = arg_94_1.actors_["1156ui_story"].transform
			local var_97_6 = 0

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.var_.moveOldPos1156ui_story = var_97_5.localPosition
			end

			local var_97_7 = 0.001

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_7 then
				local var_97_8 = (arg_94_1.time_ - var_97_6) / var_97_7
				local var_97_9 = Vector3.New(-0.9, -1.1, -6.18)

				var_97_5.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1156ui_story, var_97_9, var_97_8)

				local var_97_10 = manager.ui.mainCamera.transform.position - var_97_5.position

				var_97_5.forward = Vector3.New(var_97_10.x, var_97_10.y, var_97_10.z)

				local var_97_11 = var_97_5.localEulerAngles

				var_97_11.z = 0
				var_97_11.x = 0
				var_97_5.localEulerAngles = var_97_11
			end

			if arg_94_1.time_ >= var_97_6 + var_97_7 and arg_94_1.time_ < var_97_6 + var_97_7 + arg_97_0 then
				var_97_5.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_97_12 = manager.ui.mainCamera.transform.position - var_97_5.position

				var_97_5.forward = Vector3.New(var_97_12.x, var_97_12.y, var_97_12.z)

				local var_97_13 = var_97_5.localEulerAngles

				var_97_13.z = 0
				var_97_13.x = 0
				var_97_5.localEulerAngles = var_97_13
			end

			local var_97_14 = arg_94_1.actors_["1156ui_story"]
			local var_97_15 = 0

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 and not isNil(var_97_14) and arg_94_1.var_.characterEffect1156ui_story == nil then
				arg_94_1.var_.characterEffect1156ui_story = var_97_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_16 = 0.200000002980232

			if var_97_15 <= arg_94_1.time_ and arg_94_1.time_ < var_97_15 + var_97_16 and not isNil(var_97_14) then
				local var_97_17 = (arg_94_1.time_ - var_97_15) / var_97_16

				if arg_94_1.var_.characterEffect1156ui_story and not isNil(var_97_14) then
					arg_94_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_15 + var_97_16 and arg_94_1.time_ < var_97_15 + var_97_16 + arg_97_0 and not isNil(var_97_14) and arg_94_1.var_.characterEffect1156ui_story then
				arg_94_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_97_18 = 0

			if var_97_18 < arg_94_1.time_ and arg_94_1.time_ <= var_97_18 + arg_97_0 then
				arg_94_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_97_19 = 0

			if var_97_19 < arg_94_1.time_ and arg_94_1.time_ <= var_97_19 + arg_97_0 then
				arg_94_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_97_20 = 0
			local var_97_21 = 0.375

			if var_97_20 < arg_94_1.time_ and arg_94_1.time_ <= var_97_20 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_22 = arg_94_1:FormatText(StoryNameCfg[605].name)

				arg_94_1.leftNameTxt_.text = var_97_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_23 = arg_94_1:GetWordFromCfg(322061022)
				local var_97_24 = arg_94_1:FormatText(var_97_23.content)

				arg_94_1.text_.text = var_97_24

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_25 = 15
				local var_97_26 = utf8.len(var_97_24)
				local var_97_27 = var_97_25 <= 0 and var_97_21 or var_97_21 * (var_97_26 / var_97_25)

				if var_97_27 > 0 and var_97_21 < var_97_27 then
					arg_94_1.talkMaxDuration = var_97_27

					if var_97_27 + var_97_20 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_27 + var_97_20
					end
				end

				arg_94_1.text_.text = var_97_24
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061022", "story_v_out_322061.awb") ~= 0 then
					local var_97_28 = manager.audio:GetVoiceLength("story_v_out_322061", "322061022", "story_v_out_322061.awb") / 1000

					if var_97_28 + var_97_20 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_28 + var_97_20
					end

					if var_97_23.prefab_name ~= "" and arg_94_1.actors_[var_97_23.prefab_name] ~= nil then
						local var_97_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_23.prefab_name].transform, "story_v_out_322061", "322061022", "story_v_out_322061.awb")

						arg_94_1:RecordAudio("322061022", var_97_29)
						arg_94_1:RecordAudio("322061022", var_97_29)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_322061", "322061022", "story_v_out_322061.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_322061", "322061022", "story_v_out_322061.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_30 = math.max(var_97_21, arg_94_1.talkMaxDuration)

			if var_97_20 <= arg_94_1.time_ and arg_94_1.time_ < var_97_20 + var_97_30 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_20) / var_97_30

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_20 + var_97_30 and arg_94_1.time_ < var_97_20 + var_97_30 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play322061023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 322061023
		arg_98_1.duration_ = 3.2

		local var_98_0 = {
			zh = 1.766,
			ja = 3.2
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play322061024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["404001ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos404001ui_story = var_101_0.localPosition
			end

			local var_101_2 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2
				local var_101_4 = Vector3.New(0.8, -1.55, -5.5)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos404001ui_story, var_101_4, var_101_3)

				local var_101_5 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_5.x, var_101_5.y, var_101_5.z)

				local var_101_6 = var_101_0.localEulerAngles

				var_101_6.z = 0
				var_101_6.x = 0
				var_101_0.localEulerAngles = var_101_6
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_101_7 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_7.x, var_101_7.y, var_101_7.z)

				local var_101_8 = var_101_0.localEulerAngles

				var_101_8.z = 0
				var_101_8.x = 0
				var_101_0.localEulerAngles = var_101_8
			end

			local var_101_9 = arg_98_1.actors_["404001ui_story"]
			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect404001ui_story == nil then
				arg_98_1.var_.characterEffect404001ui_story = var_101_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_11 = 0.200000002980232

			if var_101_10 <= arg_98_1.time_ and arg_98_1.time_ < var_101_10 + var_101_11 and not isNil(var_101_9) then
				local var_101_12 = (arg_98_1.time_ - var_101_10) / var_101_11

				if arg_98_1.var_.characterEffect404001ui_story and not isNil(var_101_9) then
					arg_98_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_10 + var_101_11 and arg_98_1.time_ < var_101_10 + var_101_11 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect404001ui_story then
				arg_98_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_101_13 = arg_98_1.actors_["1156ui_story"]
			local var_101_14 = 0

			if var_101_14 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 and not isNil(var_101_13) and arg_98_1.var_.characterEffect1156ui_story == nil then
				arg_98_1.var_.characterEffect1156ui_story = var_101_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_15 = 0.200000002980232

			if var_101_14 <= arg_98_1.time_ and arg_98_1.time_ < var_101_14 + var_101_15 and not isNil(var_101_13) then
				local var_101_16 = (arg_98_1.time_ - var_101_14) / var_101_15

				if arg_98_1.var_.characterEffect1156ui_story and not isNil(var_101_13) then
					local var_101_17 = Mathf.Lerp(0, 0.5, var_101_16)

					arg_98_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1156ui_story.fillRatio = var_101_17
				end
			end

			if arg_98_1.time_ >= var_101_14 + var_101_15 and arg_98_1.time_ < var_101_14 + var_101_15 + arg_101_0 and not isNil(var_101_13) and arg_98_1.var_.characterEffect1156ui_story then
				local var_101_18 = 0.5

				arg_98_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1156ui_story.fillRatio = var_101_18
			end

			local var_101_19 = 0

			if var_101_19 < arg_98_1.time_ and arg_98_1.time_ <= var_101_19 + arg_101_0 then
				arg_98_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_101_20 = 0

			if var_101_20 < arg_98_1.time_ and arg_98_1.time_ <= var_101_20 + arg_101_0 then
				arg_98_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_101_21 = 0
			local var_101_22 = 0.2

			if var_101_21 < arg_98_1.time_ and arg_98_1.time_ <= var_101_21 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_23 = arg_98_1:FormatText(StoryNameCfg[668].name)

				arg_98_1.leftNameTxt_.text = var_101_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_24 = arg_98_1:GetWordFromCfg(322061023)
				local var_101_25 = arg_98_1:FormatText(var_101_24.content)

				arg_98_1.text_.text = var_101_25

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_26 = 8
				local var_101_27 = utf8.len(var_101_25)
				local var_101_28 = var_101_26 <= 0 and var_101_22 or var_101_22 * (var_101_27 / var_101_26)

				if var_101_28 > 0 and var_101_22 < var_101_28 then
					arg_98_1.talkMaxDuration = var_101_28

					if var_101_28 + var_101_21 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_28 + var_101_21
					end
				end

				arg_98_1.text_.text = var_101_25
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061023", "story_v_out_322061.awb") ~= 0 then
					local var_101_29 = manager.audio:GetVoiceLength("story_v_out_322061", "322061023", "story_v_out_322061.awb") / 1000

					if var_101_29 + var_101_21 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_29 + var_101_21
					end

					if var_101_24.prefab_name ~= "" and arg_98_1.actors_[var_101_24.prefab_name] ~= nil then
						local var_101_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_24.prefab_name].transform, "story_v_out_322061", "322061023", "story_v_out_322061.awb")

						arg_98_1:RecordAudio("322061023", var_101_30)
						arg_98_1:RecordAudio("322061023", var_101_30)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_322061", "322061023", "story_v_out_322061.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_322061", "322061023", "story_v_out_322061.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_31 = math.max(var_101_22, arg_98_1.talkMaxDuration)

			if var_101_21 <= arg_98_1.time_ and arg_98_1.time_ < var_101_21 + var_101_31 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_21) / var_101_31

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_21 + var_101_31 and arg_98_1.time_ < var_101_21 + var_101_31 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play322061024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 322061024
		arg_102_1.duration_ = 7.2

		local var_102_0 = {
			zh = 4.833,
			ja = 7.2
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play322061025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1156ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos1156ui_story = var_105_0.localPosition
			end

			local var_105_2 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2
				local var_105_4 = Vector3.New(-0.9, -1.1, -6.18)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1156ui_story, var_105_4, var_105_3)

				local var_105_5 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_5.x, var_105_5.y, var_105_5.z)

				local var_105_6 = var_105_0.localEulerAngles

				var_105_6.z = 0
				var_105_6.x = 0
				var_105_0.localEulerAngles = var_105_6
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_105_7 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_7.x, var_105_7.y, var_105_7.z)

				local var_105_8 = var_105_0.localEulerAngles

				var_105_8.z = 0
				var_105_8.x = 0
				var_105_0.localEulerAngles = var_105_8
			end

			local var_105_9 = arg_102_1.actors_["1156ui_story"]
			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 and not isNil(var_105_9) and arg_102_1.var_.characterEffect1156ui_story == nil then
				arg_102_1.var_.characterEffect1156ui_story = var_105_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_11 = 0.200000002980232

			if var_105_10 <= arg_102_1.time_ and arg_102_1.time_ < var_105_10 + var_105_11 and not isNil(var_105_9) then
				local var_105_12 = (arg_102_1.time_ - var_105_10) / var_105_11

				if arg_102_1.var_.characterEffect1156ui_story and not isNil(var_105_9) then
					arg_102_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_10 + var_105_11 and arg_102_1.time_ < var_105_10 + var_105_11 + arg_105_0 and not isNil(var_105_9) and arg_102_1.var_.characterEffect1156ui_story then
				arg_102_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_105_13 = arg_102_1.actors_["404001ui_story"]
			local var_105_14 = 0

			if var_105_14 < arg_102_1.time_ and arg_102_1.time_ <= var_105_14 + arg_105_0 and not isNil(var_105_13) and arg_102_1.var_.characterEffect404001ui_story == nil then
				arg_102_1.var_.characterEffect404001ui_story = var_105_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_15 = 0.200000002980232

			if var_105_14 <= arg_102_1.time_ and arg_102_1.time_ < var_105_14 + var_105_15 and not isNil(var_105_13) then
				local var_105_16 = (arg_102_1.time_ - var_105_14) / var_105_15

				if arg_102_1.var_.characterEffect404001ui_story and not isNil(var_105_13) then
					local var_105_17 = Mathf.Lerp(0, 0.5, var_105_16)

					arg_102_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_102_1.var_.characterEffect404001ui_story.fillRatio = var_105_17
				end
			end

			if arg_102_1.time_ >= var_105_14 + var_105_15 and arg_102_1.time_ < var_105_14 + var_105_15 + arg_105_0 and not isNil(var_105_13) and arg_102_1.var_.characterEffect404001ui_story then
				local var_105_18 = 0.5

				arg_102_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_102_1.var_.characterEffect404001ui_story.fillRatio = var_105_18
			end

			local var_105_19 = 0

			if var_105_19 < arg_102_1.time_ and arg_102_1.time_ <= var_105_19 + arg_105_0 then
				arg_102_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_1")
			end

			local var_105_20 = 0

			if var_105_20 < arg_102_1.time_ and arg_102_1.time_ <= var_105_20 + arg_105_0 then
				arg_102_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_105_21 = 0
			local var_105_22 = 0.725

			if var_105_21 < arg_102_1.time_ and arg_102_1.time_ <= var_105_21 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_23 = arg_102_1:FormatText(StoryNameCfg[605].name)

				arg_102_1.leftNameTxt_.text = var_105_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_24 = arg_102_1:GetWordFromCfg(322061024)
				local var_105_25 = arg_102_1:FormatText(var_105_24.content)

				arg_102_1.text_.text = var_105_25

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_26 = 29
				local var_105_27 = utf8.len(var_105_25)
				local var_105_28 = var_105_26 <= 0 and var_105_22 or var_105_22 * (var_105_27 / var_105_26)

				if var_105_28 > 0 and var_105_22 < var_105_28 then
					arg_102_1.talkMaxDuration = var_105_28

					if var_105_28 + var_105_21 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_28 + var_105_21
					end
				end

				arg_102_1.text_.text = var_105_25
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061024", "story_v_out_322061.awb") ~= 0 then
					local var_105_29 = manager.audio:GetVoiceLength("story_v_out_322061", "322061024", "story_v_out_322061.awb") / 1000

					if var_105_29 + var_105_21 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_29 + var_105_21
					end

					if var_105_24.prefab_name ~= "" and arg_102_1.actors_[var_105_24.prefab_name] ~= nil then
						local var_105_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_24.prefab_name].transform, "story_v_out_322061", "322061024", "story_v_out_322061.awb")

						arg_102_1:RecordAudio("322061024", var_105_30)
						arg_102_1:RecordAudio("322061024", var_105_30)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_322061", "322061024", "story_v_out_322061.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_322061", "322061024", "story_v_out_322061.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_31 = math.max(var_105_22, arg_102_1.talkMaxDuration)

			if var_105_21 <= arg_102_1.time_ and arg_102_1.time_ < var_105_21 + var_105_31 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_21) / var_105_31

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_21 + var_105_31 and arg_102_1.time_ < var_105_21 + var_105_31 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play322061025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 322061025
		arg_106_1.duration_ = 4.6

		local var_106_0 = {
			zh = 3.4,
			ja = 4.6
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play322061026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["404001ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect404001ui_story == nil then
				arg_106_1.var_.characterEffect404001ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect404001ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect404001ui_story then
				arg_106_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_109_4 = arg_106_1.actors_["1156ui_story"]
			local var_109_5 = 0

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect1156ui_story == nil then
				arg_106_1.var_.characterEffect1156ui_story = var_109_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_6 = 0.200000002980232

			if var_109_5 <= arg_106_1.time_ and arg_106_1.time_ < var_109_5 + var_109_6 and not isNil(var_109_4) then
				local var_109_7 = (arg_106_1.time_ - var_109_5) / var_109_6

				if arg_106_1.var_.characterEffect1156ui_story and not isNil(var_109_4) then
					local var_109_8 = Mathf.Lerp(0, 0.5, var_109_7)

					arg_106_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1156ui_story.fillRatio = var_109_8
				end
			end

			if arg_106_1.time_ >= var_109_5 + var_109_6 and arg_106_1.time_ < var_109_5 + var_109_6 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect1156ui_story then
				local var_109_9 = 0.5

				arg_106_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1156ui_story.fillRatio = var_109_9
			end

			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 then
				arg_106_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_109_11 = 0

			if var_109_11 < arg_106_1.time_ and arg_106_1.time_ <= var_109_11 + arg_109_0 then
				arg_106_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_109_12 = 0
			local var_109_13 = 0.275

			if var_109_12 < arg_106_1.time_ and arg_106_1.time_ <= var_109_12 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_14 = arg_106_1:FormatText(StoryNameCfg[668].name)

				arg_106_1.leftNameTxt_.text = var_109_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_15 = arg_106_1:GetWordFromCfg(322061025)
				local var_109_16 = arg_106_1:FormatText(var_109_15.content)

				arg_106_1.text_.text = var_109_16

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_17 = 11
				local var_109_18 = utf8.len(var_109_16)
				local var_109_19 = var_109_17 <= 0 and var_109_13 or var_109_13 * (var_109_18 / var_109_17)

				if var_109_19 > 0 and var_109_13 < var_109_19 then
					arg_106_1.talkMaxDuration = var_109_19

					if var_109_19 + var_109_12 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_19 + var_109_12
					end
				end

				arg_106_1.text_.text = var_109_16
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061025", "story_v_out_322061.awb") ~= 0 then
					local var_109_20 = manager.audio:GetVoiceLength("story_v_out_322061", "322061025", "story_v_out_322061.awb") / 1000

					if var_109_20 + var_109_12 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_20 + var_109_12
					end

					if var_109_15.prefab_name ~= "" and arg_106_1.actors_[var_109_15.prefab_name] ~= nil then
						local var_109_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_15.prefab_name].transform, "story_v_out_322061", "322061025", "story_v_out_322061.awb")

						arg_106_1:RecordAudio("322061025", var_109_21)
						arg_106_1:RecordAudio("322061025", var_109_21)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_322061", "322061025", "story_v_out_322061.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_322061", "322061025", "story_v_out_322061.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_22 = math.max(var_109_13, arg_106_1.talkMaxDuration)

			if var_109_12 <= arg_106_1.time_ and arg_106_1.time_ < var_109_12 + var_109_22 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_12) / var_109_22

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_12 + var_109_22 and arg_106_1.time_ < var_109_12 + var_109_22 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play322061026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 322061026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play322061027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["404001ui_story"].transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPos404001ui_story = var_113_0.localPosition
			end

			local var_113_2 = 0.001

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2
				local var_113_4 = Vector3.New(0, 100, 0)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos404001ui_story, var_113_4, var_113_3)

				local var_113_5 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_5.x, var_113_5.y, var_113_5.z)

				local var_113_6 = var_113_0.localEulerAngles

				var_113_6.z = 0
				var_113_6.x = 0
				var_113_0.localEulerAngles = var_113_6
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(0, 100, 0)

				local var_113_7 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_7.x, var_113_7.y, var_113_7.z)

				local var_113_8 = var_113_0.localEulerAngles

				var_113_8.z = 0
				var_113_8.x = 0
				var_113_0.localEulerAngles = var_113_8
			end

			local var_113_9 = arg_110_1.actors_["1156ui_story"].transform
			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1.var_.moveOldPos1156ui_story = var_113_9.localPosition
			end

			local var_113_11 = 0.001

			if var_113_10 <= arg_110_1.time_ and arg_110_1.time_ < var_113_10 + var_113_11 then
				local var_113_12 = (arg_110_1.time_ - var_113_10) / var_113_11
				local var_113_13 = Vector3.New(0, 100, 0)

				var_113_9.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1156ui_story, var_113_13, var_113_12)

				local var_113_14 = manager.ui.mainCamera.transform.position - var_113_9.position

				var_113_9.forward = Vector3.New(var_113_14.x, var_113_14.y, var_113_14.z)

				local var_113_15 = var_113_9.localEulerAngles

				var_113_15.z = 0
				var_113_15.x = 0
				var_113_9.localEulerAngles = var_113_15
			end

			if arg_110_1.time_ >= var_113_10 + var_113_11 and arg_110_1.time_ < var_113_10 + var_113_11 + arg_113_0 then
				var_113_9.localPosition = Vector3.New(0, 100, 0)

				local var_113_16 = manager.ui.mainCamera.transform.position - var_113_9.position

				var_113_9.forward = Vector3.New(var_113_16.x, var_113_16.y, var_113_16.z)

				local var_113_17 = var_113_9.localEulerAngles

				var_113_17.z = 0
				var_113_17.x = 0
				var_113_9.localEulerAngles = var_113_17
			end

			local var_113_18 = arg_110_1.actors_["404001ui_story"]
			local var_113_19 = 0

			if var_113_19 < arg_110_1.time_ and arg_110_1.time_ <= var_113_19 + arg_113_0 and not isNil(var_113_18) and arg_110_1.var_.characterEffect404001ui_story == nil then
				arg_110_1.var_.characterEffect404001ui_story = var_113_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_20 = 0.200000002980232

			if var_113_19 <= arg_110_1.time_ and arg_110_1.time_ < var_113_19 + var_113_20 and not isNil(var_113_18) then
				local var_113_21 = (arg_110_1.time_ - var_113_19) / var_113_20

				if arg_110_1.var_.characterEffect404001ui_story and not isNil(var_113_18) then
					local var_113_22 = Mathf.Lerp(0, 0.5, var_113_21)

					arg_110_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_110_1.var_.characterEffect404001ui_story.fillRatio = var_113_22
				end
			end

			if arg_110_1.time_ >= var_113_19 + var_113_20 and arg_110_1.time_ < var_113_19 + var_113_20 + arg_113_0 and not isNil(var_113_18) and arg_110_1.var_.characterEffect404001ui_story then
				local var_113_23 = 0.5

				arg_110_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_110_1.var_.characterEffect404001ui_story.fillRatio = var_113_23
			end

			local var_113_24 = 0.733333333333333
			local var_113_25 = 1

			if var_113_24 < arg_110_1.time_ and arg_110_1.time_ <= var_113_24 + arg_113_0 then
				local var_113_26 = "play"
				local var_113_27 = "effect"

				arg_110_1:AudioAction(var_113_26, var_113_27, "se_story_1310", "se_story_1310_footstep02", "")
			end

			local var_113_28 = 0
			local var_113_29 = 1.175

			if var_113_28 < arg_110_1.time_ and arg_110_1.time_ <= var_113_28 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_30 = arg_110_1:GetWordFromCfg(322061026)
				local var_113_31 = arg_110_1:FormatText(var_113_30.content)

				arg_110_1.text_.text = var_113_31

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_32 = 47
				local var_113_33 = utf8.len(var_113_31)
				local var_113_34 = var_113_32 <= 0 and var_113_29 or var_113_29 * (var_113_33 / var_113_32)

				if var_113_34 > 0 and var_113_29 < var_113_34 then
					arg_110_1.talkMaxDuration = var_113_34

					if var_113_34 + var_113_28 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_34 + var_113_28
					end
				end

				arg_110_1.text_.text = var_113_31
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_35 = math.max(var_113_29, arg_110_1.talkMaxDuration)

			if var_113_28 <= arg_110_1.time_ and arg_110_1.time_ < var_113_28 + var_113_35 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_28) / var_113_35

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_28 + var_113_35 and arg_110_1.time_ < var_113_28 + var_113_35 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play322061027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 322061027
		arg_114_1.duration_ = 5.7

		local var_114_0 = {
			zh = 3.633,
			ja = 5.7
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play322061028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1156ui_story"].transform
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos1156ui_story = var_117_0.localPosition
			end

			local var_117_2 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2
				local var_117_4 = Vector3.New(-0.9, -1.1, -6.18)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1156ui_story, var_117_4, var_117_3)

				local var_117_5 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_5.x, var_117_5.y, var_117_5.z)

				local var_117_6 = var_117_0.localEulerAngles

				var_117_6.z = 0
				var_117_6.x = 0
				var_117_0.localEulerAngles = var_117_6
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_117_7 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_7.x, var_117_7.y, var_117_7.z)

				local var_117_8 = var_117_0.localEulerAngles

				var_117_8.z = 0
				var_117_8.x = 0
				var_117_0.localEulerAngles = var_117_8
			end

			local var_117_9 = arg_114_1.actors_["1156ui_story"]
			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 and not isNil(var_117_9) and arg_114_1.var_.characterEffect1156ui_story == nil then
				arg_114_1.var_.characterEffect1156ui_story = var_117_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_11 = 0.200000002980232

			if var_117_10 <= arg_114_1.time_ and arg_114_1.time_ < var_117_10 + var_117_11 and not isNil(var_117_9) then
				local var_117_12 = (arg_114_1.time_ - var_117_10) / var_117_11

				if arg_114_1.var_.characterEffect1156ui_story and not isNil(var_117_9) then
					arg_114_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_10 + var_117_11 and arg_114_1.time_ < var_117_10 + var_117_11 + arg_117_0 and not isNil(var_117_9) and arg_114_1.var_.characterEffect1156ui_story then
				arg_114_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_117_13 = 0

			if var_117_13 < arg_114_1.time_ and arg_114_1.time_ <= var_117_13 + arg_117_0 then
				arg_114_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_2")
			end

			local var_117_14 = 0

			if var_117_14 < arg_114_1.time_ and arg_114_1.time_ <= var_117_14 + arg_117_0 then
				arg_114_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_117_15 = 0
			local var_117_16 = 0.45

			if var_117_15 < arg_114_1.time_ and arg_114_1.time_ <= var_117_15 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_17 = arg_114_1:FormatText(StoryNameCfg[605].name)

				arg_114_1.leftNameTxt_.text = var_117_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_18 = arg_114_1:GetWordFromCfg(322061027)
				local var_117_19 = arg_114_1:FormatText(var_117_18.content)

				arg_114_1.text_.text = var_117_19

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_20 = 18
				local var_117_21 = utf8.len(var_117_19)
				local var_117_22 = var_117_20 <= 0 and var_117_16 or var_117_16 * (var_117_21 / var_117_20)

				if var_117_22 > 0 and var_117_16 < var_117_22 then
					arg_114_1.talkMaxDuration = var_117_22

					if var_117_22 + var_117_15 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_22 + var_117_15
					end
				end

				arg_114_1.text_.text = var_117_19
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061027", "story_v_out_322061.awb") ~= 0 then
					local var_117_23 = manager.audio:GetVoiceLength("story_v_out_322061", "322061027", "story_v_out_322061.awb") / 1000

					if var_117_23 + var_117_15 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_23 + var_117_15
					end

					if var_117_18.prefab_name ~= "" and arg_114_1.actors_[var_117_18.prefab_name] ~= nil then
						local var_117_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_18.prefab_name].transform, "story_v_out_322061", "322061027", "story_v_out_322061.awb")

						arg_114_1:RecordAudio("322061027", var_117_24)
						arg_114_1:RecordAudio("322061027", var_117_24)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_322061", "322061027", "story_v_out_322061.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_322061", "322061027", "story_v_out_322061.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_25 = math.max(var_117_16, arg_114_1.talkMaxDuration)

			if var_117_15 <= arg_114_1.time_ and arg_114_1.time_ < var_117_15 + var_117_25 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_15) / var_117_25

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_15 + var_117_25 and arg_114_1.time_ < var_117_15 + var_117_25 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play322061028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 322061028
		arg_118_1.duration_ = 10.37

		local var_118_0 = {
			zh = 9.4,
			ja = 10.366
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play322061029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["404001ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos404001ui_story = var_121_0.localPosition
			end

			local var_121_2 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2
				local var_121_4 = Vector3.New(0.8, -1.55, -5.5)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos404001ui_story, var_121_4, var_121_3)

				local var_121_5 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_5.x, var_121_5.y, var_121_5.z)

				local var_121_6 = var_121_0.localEulerAngles

				var_121_6.z = 0
				var_121_6.x = 0
				var_121_0.localEulerAngles = var_121_6
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_121_7 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_7.x, var_121_7.y, var_121_7.z)

				local var_121_8 = var_121_0.localEulerAngles

				var_121_8.z = 0
				var_121_8.x = 0
				var_121_0.localEulerAngles = var_121_8
			end

			local var_121_9 = arg_118_1.actors_["404001ui_story"]
			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect404001ui_story == nil then
				arg_118_1.var_.characterEffect404001ui_story = var_121_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_11 = 0.200000002980232

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_11 and not isNil(var_121_9) then
				local var_121_12 = (arg_118_1.time_ - var_121_10) / var_121_11

				if arg_118_1.var_.characterEffect404001ui_story and not isNil(var_121_9) then
					arg_118_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_10 + var_121_11 and arg_118_1.time_ < var_121_10 + var_121_11 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect404001ui_story then
				arg_118_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_121_13 = arg_118_1.actors_["1156ui_story"]
			local var_121_14 = 0

			if var_121_14 < arg_118_1.time_ and arg_118_1.time_ <= var_121_14 + arg_121_0 and not isNil(var_121_13) and arg_118_1.var_.characterEffect1156ui_story == nil then
				arg_118_1.var_.characterEffect1156ui_story = var_121_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_15 = 0.200000002980232

			if var_121_14 <= arg_118_1.time_ and arg_118_1.time_ < var_121_14 + var_121_15 and not isNil(var_121_13) then
				local var_121_16 = (arg_118_1.time_ - var_121_14) / var_121_15

				if arg_118_1.var_.characterEffect1156ui_story and not isNil(var_121_13) then
					local var_121_17 = Mathf.Lerp(0, 0.5, var_121_16)

					arg_118_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1156ui_story.fillRatio = var_121_17
				end
			end

			if arg_118_1.time_ >= var_121_14 + var_121_15 and arg_118_1.time_ < var_121_14 + var_121_15 + arg_121_0 and not isNil(var_121_13) and arg_118_1.var_.characterEffect1156ui_story then
				local var_121_18 = 0.5

				arg_118_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1156ui_story.fillRatio = var_121_18
			end

			local var_121_19 = 0

			if var_121_19 < arg_118_1.time_ and arg_118_1.time_ <= var_121_19 + arg_121_0 then
				arg_118_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_121_20 = 0

			if var_121_20 < arg_118_1.time_ and arg_118_1.time_ <= var_121_20 + arg_121_0 then
				arg_118_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_121_21 = 0
			local var_121_22 = 0.85

			if var_121_21 < arg_118_1.time_ and arg_118_1.time_ <= var_121_21 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_23 = arg_118_1:FormatText(StoryNameCfg[668].name)

				arg_118_1.leftNameTxt_.text = var_121_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_24 = arg_118_1:GetWordFromCfg(322061028)
				local var_121_25 = arg_118_1:FormatText(var_121_24.content)

				arg_118_1.text_.text = var_121_25

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_26 = 34
				local var_121_27 = utf8.len(var_121_25)
				local var_121_28 = var_121_26 <= 0 and var_121_22 or var_121_22 * (var_121_27 / var_121_26)

				if var_121_28 > 0 and var_121_22 < var_121_28 then
					arg_118_1.talkMaxDuration = var_121_28

					if var_121_28 + var_121_21 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_28 + var_121_21
					end
				end

				arg_118_1.text_.text = var_121_25
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061028", "story_v_out_322061.awb") ~= 0 then
					local var_121_29 = manager.audio:GetVoiceLength("story_v_out_322061", "322061028", "story_v_out_322061.awb") / 1000

					if var_121_29 + var_121_21 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_29 + var_121_21
					end

					if var_121_24.prefab_name ~= "" and arg_118_1.actors_[var_121_24.prefab_name] ~= nil then
						local var_121_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_24.prefab_name].transform, "story_v_out_322061", "322061028", "story_v_out_322061.awb")

						arg_118_1:RecordAudio("322061028", var_121_30)
						arg_118_1:RecordAudio("322061028", var_121_30)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_322061", "322061028", "story_v_out_322061.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_322061", "322061028", "story_v_out_322061.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_31 = math.max(var_121_22, arg_118_1.talkMaxDuration)

			if var_121_21 <= arg_118_1.time_ and arg_118_1.time_ < var_121_21 + var_121_31 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_21) / var_121_31

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_21 + var_121_31 and arg_118_1.time_ < var_121_21 + var_121_31 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play322061029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 322061029
		arg_122_1.duration_ = 6.47

		local var_122_0 = {
			zh = 6.166,
			ja = 6.466
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play322061030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["404001ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos404001ui_story = var_125_0.localPosition
			end

			local var_125_2 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2
				local var_125_4 = Vector3.New(0.8, -1.55, -5.5)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos404001ui_story, var_125_4, var_125_3)

				local var_125_5 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_5.x, var_125_5.y, var_125_5.z)

				local var_125_6 = var_125_0.localEulerAngles

				var_125_6.z = 0
				var_125_6.x = 0
				var_125_0.localEulerAngles = var_125_6
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_125_7 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_7.x, var_125_7.y, var_125_7.z)

				local var_125_8 = var_125_0.localEulerAngles

				var_125_8.z = 0
				var_125_8.x = 0
				var_125_0.localEulerAngles = var_125_8
			end

			local var_125_9 = 0

			if var_125_9 < arg_122_1.time_ and arg_122_1.time_ <= var_125_9 + arg_125_0 then
				arg_122_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_125_10 = 0

			if var_125_10 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 then
				arg_122_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_125_11 = 0
			local var_125_12 = 0.65

			if var_125_11 < arg_122_1.time_ and arg_122_1.time_ <= var_125_11 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_13 = arg_122_1:FormatText(StoryNameCfg[668].name)

				arg_122_1.leftNameTxt_.text = var_125_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_14 = arg_122_1:GetWordFromCfg(322061029)
				local var_125_15 = arg_122_1:FormatText(var_125_14.content)

				arg_122_1.text_.text = var_125_15

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_16 = 26
				local var_125_17 = utf8.len(var_125_15)
				local var_125_18 = var_125_16 <= 0 and var_125_12 or var_125_12 * (var_125_17 / var_125_16)

				if var_125_18 > 0 and var_125_12 < var_125_18 then
					arg_122_1.talkMaxDuration = var_125_18

					if var_125_18 + var_125_11 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_18 + var_125_11
					end
				end

				arg_122_1.text_.text = var_125_15
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061029", "story_v_out_322061.awb") ~= 0 then
					local var_125_19 = manager.audio:GetVoiceLength("story_v_out_322061", "322061029", "story_v_out_322061.awb") / 1000

					if var_125_19 + var_125_11 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_19 + var_125_11
					end

					if var_125_14.prefab_name ~= "" and arg_122_1.actors_[var_125_14.prefab_name] ~= nil then
						local var_125_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_14.prefab_name].transform, "story_v_out_322061", "322061029", "story_v_out_322061.awb")

						arg_122_1:RecordAudio("322061029", var_125_20)
						arg_122_1:RecordAudio("322061029", var_125_20)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_322061", "322061029", "story_v_out_322061.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_322061", "322061029", "story_v_out_322061.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_21 = math.max(var_125_12, arg_122_1.talkMaxDuration)

			if var_125_11 <= arg_122_1.time_ and arg_122_1.time_ < var_125_11 + var_125_21 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_11) / var_125_21

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_11 + var_125_21 and arg_122_1.time_ < var_125_11 + var_125_21 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play322061030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 322061030
		arg_126_1.duration_ = 2.23

		local var_126_0 = {
			zh = 1.999999999999,
			ja = 2.233
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play322061031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1156ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1156ui_story == nil then
				arg_126_1.var_.characterEffect1156ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1156ui_story and not isNil(var_129_0) then
					arg_126_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1156ui_story then
				arg_126_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_129_4 = arg_126_1.actors_["404001ui_story"]
			local var_129_5 = 0

			if var_129_5 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect404001ui_story == nil then
				arg_126_1.var_.characterEffect404001ui_story = var_129_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_6 = 0.200000002980232

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_6 and not isNil(var_129_4) then
				local var_129_7 = (arg_126_1.time_ - var_129_5) / var_129_6

				if arg_126_1.var_.characterEffect404001ui_story and not isNil(var_129_4) then
					local var_129_8 = Mathf.Lerp(0, 0.5, var_129_7)

					arg_126_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_126_1.var_.characterEffect404001ui_story.fillRatio = var_129_8
				end
			end

			if arg_126_1.time_ >= var_129_5 + var_129_6 and arg_126_1.time_ < var_129_5 + var_129_6 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect404001ui_story then
				local var_129_9 = 0.5

				arg_126_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_126_1.var_.characterEffect404001ui_story.fillRatio = var_129_9
			end

			local var_129_10 = 0

			if var_129_10 < arg_126_1.time_ and arg_126_1.time_ <= var_129_10 + arg_129_0 then
				arg_126_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action13_1")
			end

			local var_129_11 = 0
			local var_129_12 = 0.15

			if var_129_11 < arg_126_1.time_ and arg_126_1.time_ <= var_129_11 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_13 = arg_126_1:FormatText(StoryNameCfg[605].name)

				arg_126_1.leftNameTxt_.text = var_129_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_14 = arg_126_1:GetWordFromCfg(322061030)
				local var_129_15 = arg_126_1:FormatText(var_129_14.content)

				arg_126_1.text_.text = var_129_15

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_16 = 6
				local var_129_17 = utf8.len(var_129_15)
				local var_129_18 = var_129_16 <= 0 and var_129_12 or var_129_12 * (var_129_17 / var_129_16)

				if var_129_18 > 0 and var_129_12 < var_129_18 then
					arg_126_1.talkMaxDuration = var_129_18

					if var_129_18 + var_129_11 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_18 + var_129_11
					end
				end

				arg_126_1.text_.text = var_129_15
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061030", "story_v_out_322061.awb") ~= 0 then
					local var_129_19 = manager.audio:GetVoiceLength("story_v_out_322061", "322061030", "story_v_out_322061.awb") / 1000

					if var_129_19 + var_129_11 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_19 + var_129_11
					end

					if var_129_14.prefab_name ~= "" and arg_126_1.actors_[var_129_14.prefab_name] ~= nil then
						local var_129_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_14.prefab_name].transform, "story_v_out_322061", "322061030", "story_v_out_322061.awb")

						arg_126_1:RecordAudio("322061030", var_129_20)
						arg_126_1:RecordAudio("322061030", var_129_20)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_322061", "322061030", "story_v_out_322061.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_322061", "322061030", "story_v_out_322061.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_21 = math.max(var_129_12, arg_126_1.talkMaxDuration)

			if var_129_11 <= arg_126_1.time_ and arg_126_1.time_ < var_129_11 + var_129_21 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_11) / var_129_21

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_11 + var_129_21 and arg_126_1.time_ < var_129_11 + var_129_21 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play322061031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 322061031
		arg_130_1.duration_ = 9.23

		local var_130_0 = {
			zh = 6.9,
			ja = 9.233
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
				arg_130_0:Play322061032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["404001ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect404001ui_story == nil then
				arg_130_1.var_.characterEffect404001ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect404001ui_story and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect404001ui_story then
				arg_130_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_133_4 = arg_130_1.actors_["1156ui_story"]
			local var_133_5 = 0

			if var_133_5 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect1156ui_story == nil then
				arg_130_1.var_.characterEffect1156ui_story = var_133_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_6 = 0.200000002980232

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_6 and not isNil(var_133_4) then
				local var_133_7 = (arg_130_1.time_ - var_133_5) / var_133_6

				if arg_130_1.var_.characterEffect1156ui_story and not isNil(var_133_4) then
					local var_133_8 = Mathf.Lerp(0, 0.5, var_133_7)

					arg_130_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1156ui_story.fillRatio = var_133_8
				end
			end

			if arg_130_1.time_ >= var_133_5 + var_133_6 and arg_130_1.time_ < var_133_5 + var_133_6 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect1156ui_story then
				local var_133_9 = 0.5

				arg_130_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1156ui_story.fillRatio = var_133_9
			end

			local var_133_10 = 0

			if var_133_10 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 then
				arg_130_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_133_11 = 0
			local var_133_12 = 0.8

			if var_133_11 < arg_130_1.time_ and arg_130_1.time_ <= var_133_11 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_13 = arg_130_1:FormatText(StoryNameCfg[668].name)

				arg_130_1.leftNameTxt_.text = var_133_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_14 = arg_130_1:GetWordFromCfg(322061031)
				local var_133_15 = arg_130_1:FormatText(var_133_14.content)

				arg_130_1.text_.text = var_133_15

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_16 = 32
				local var_133_17 = utf8.len(var_133_15)
				local var_133_18 = var_133_16 <= 0 and var_133_12 or var_133_12 * (var_133_17 / var_133_16)

				if var_133_18 > 0 and var_133_12 < var_133_18 then
					arg_130_1.talkMaxDuration = var_133_18

					if var_133_18 + var_133_11 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_18 + var_133_11
					end
				end

				arg_130_1.text_.text = var_133_15
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061031", "story_v_out_322061.awb") ~= 0 then
					local var_133_19 = manager.audio:GetVoiceLength("story_v_out_322061", "322061031", "story_v_out_322061.awb") / 1000

					if var_133_19 + var_133_11 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_19 + var_133_11
					end

					if var_133_14.prefab_name ~= "" and arg_130_1.actors_[var_133_14.prefab_name] ~= nil then
						local var_133_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_14.prefab_name].transform, "story_v_out_322061", "322061031", "story_v_out_322061.awb")

						arg_130_1:RecordAudio("322061031", var_133_20)
						arg_130_1:RecordAudio("322061031", var_133_20)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_322061", "322061031", "story_v_out_322061.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_322061", "322061031", "story_v_out_322061.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_21 = math.max(var_133_12, arg_130_1.talkMaxDuration)

			if var_133_11 <= arg_130_1.time_ and arg_130_1.time_ < var_133_11 + var_133_21 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_11) / var_133_21

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_11 + var_133_21 and arg_130_1.time_ < var_133_11 + var_133_21 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play322061032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 322061032
		arg_134_1.duration_ = 3.57

		local var_134_0 = {
			zh = 2.233,
			ja = 3.566
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
				arg_134_0:Play322061033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["404001ui_story"].transform
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.var_.moveOldPos404001ui_story = var_137_0.localPosition
			end

			local var_137_2 = 0.001

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2
				local var_137_4 = Vector3.New(0, 100, 0)

				var_137_0.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos404001ui_story, var_137_4, var_137_3)

				local var_137_5 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_5.x, var_137_5.y, var_137_5.z)

				local var_137_6 = var_137_0.localEulerAngles

				var_137_6.z = 0
				var_137_6.x = 0
				var_137_0.localEulerAngles = var_137_6
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 then
				var_137_0.localPosition = Vector3.New(0, 100, 0)

				local var_137_7 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_7.x, var_137_7.y, var_137_7.z)

				local var_137_8 = var_137_0.localEulerAngles

				var_137_8.z = 0
				var_137_8.x = 0
				var_137_0.localEulerAngles = var_137_8
			end

			local var_137_9 = arg_134_1.actors_["1156ui_story"].transform
			local var_137_10 = 0

			if var_137_10 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 then
				arg_134_1.var_.moveOldPos1156ui_story = var_137_9.localPosition
			end

			local var_137_11 = 0.001

			if var_137_10 <= arg_134_1.time_ and arg_134_1.time_ < var_137_10 + var_137_11 then
				local var_137_12 = (arg_134_1.time_ - var_137_10) / var_137_11
				local var_137_13 = Vector3.New(0, 100, 0)

				var_137_9.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1156ui_story, var_137_13, var_137_12)

				local var_137_14 = manager.ui.mainCamera.transform.position - var_137_9.position

				var_137_9.forward = Vector3.New(var_137_14.x, var_137_14.y, var_137_14.z)

				local var_137_15 = var_137_9.localEulerAngles

				var_137_15.z = 0
				var_137_15.x = 0
				var_137_9.localEulerAngles = var_137_15
			end

			if arg_134_1.time_ >= var_137_10 + var_137_11 and arg_134_1.time_ < var_137_10 + var_137_11 + arg_137_0 then
				var_137_9.localPosition = Vector3.New(0, 100, 0)

				local var_137_16 = manager.ui.mainCamera.transform.position - var_137_9.position

				var_137_9.forward = Vector3.New(var_137_16.x, var_137_16.y, var_137_16.z)

				local var_137_17 = var_137_9.localEulerAngles

				var_137_17.z = 0
				var_137_17.x = 0
				var_137_9.localEulerAngles = var_137_17
			end

			local var_137_18 = 0
			local var_137_19 = 0.3

			if var_137_18 < arg_134_1.time_ and arg_134_1.time_ <= var_137_18 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_20 = arg_134_1:FormatText(StoryNameCfg[1030].name)

				arg_134_1.leftNameTxt_.text = var_137_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_134_1.callingController_:SetSelectedState("calling")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_21 = arg_134_1:GetWordFromCfg(322061032)
				local var_137_22 = arg_134_1:FormatText(var_137_21.content)

				arg_134_1.text_.text = var_137_22

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_23 = 12
				local var_137_24 = utf8.len(var_137_22)
				local var_137_25 = var_137_23 <= 0 and var_137_19 or var_137_19 * (var_137_24 / var_137_23)

				if var_137_25 > 0 and var_137_19 < var_137_25 then
					arg_134_1.talkMaxDuration = var_137_25

					if var_137_25 + var_137_18 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_25 + var_137_18
					end
				end

				arg_134_1.text_.text = var_137_22
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061032", "story_v_out_322061.awb") ~= 0 then
					local var_137_26 = manager.audio:GetVoiceLength("story_v_out_322061", "322061032", "story_v_out_322061.awb") / 1000

					if var_137_26 + var_137_18 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_26 + var_137_18
					end

					if var_137_21.prefab_name ~= "" and arg_134_1.actors_[var_137_21.prefab_name] ~= nil then
						local var_137_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_21.prefab_name].transform, "story_v_out_322061", "322061032", "story_v_out_322061.awb")

						arg_134_1:RecordAudio("322061032", var_137_27)
						arg_134_1:RecordAudio("322061032", var_137_27)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_322061", "322061032", "story_v_out_322061.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_322061", "322061032", "story_v_out_322061.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_28 = math.max(var_137_19, arg_134_1.talkMaxDuration)

			if var_137_18 <= arg_134_1.time_ and arg_134_1.time_ < var_137_18 + var_137_28 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_18) / var_137_28

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_18 + var_137_28 and arg_134_1.time_ < var_137_18 + var_137_28 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play322061033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 322061033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play322061034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 1.125

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_2 = arg_138_1:GetWordFromCfg(322061033)
				local var_141_3 = arg_138_1:FormatText(var_141_2.content)

				arg_138_1.text_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_4 = 45
				local var_141_5 = utf8.len(var_141_3)
				local var_141_6 = var_141_4 <= 0 and var_141_1 or var_141_1 * (var_141_5 / var_141_4)

				if var_141_6 > 0 and var_141_1 < var_141_6 then
					arg_138_1.talkMaxDuration = var_141_6

					if var_141_6 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_6 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_3
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_7 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_7 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_7

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_7 and arg_138_1.time_ < var_141_0 + var_141_7 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play322061034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 322061034
		arg_142_1.duration_ = 3

		local var_142_0 = {
			zh = 3,
			ja = 2.7
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
				arg_142_0:Play322061035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["404001ui_story"].transform
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.var_.moveOldPos404001ui_story = var_145_0.localPosition
			end

			local var_145_2 = 0.001

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2
				local var_145_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_145_0.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos404001ui_story, var_145_4, var_145_3)

				local var_145_5 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_5.x, var_145_5.y, var_145_5.z)

				local var_145_6 = var_145_0.localEulerAngles

				var_145_6.z = 0
				var_145_6.x = 0
				var_145_0.localEulerAngles = var_145_6
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 then
				var_145_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_145_7 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_7.x, var_145_7.y, var_145_7.z)

				local var_145_8 = var_145_0.localEulerAngles

				var_145_8.z = 0
				var_145_8.x = 0
				var_145_0.localEulerAngles = var_145_8
			end

			local var_145_9 = arg_142_1.actors_["404001ui_story"]
			local var_145_10 = 0

			if var_145_10 < arg_142_1.time_ and arg_142_1.time_ <= var_145_10 + arg_145_0 and not isNil(var_145_9) and arg_142_1.var_.characterEffect404001ui_story == nil then
				arg_142_1.var_.characterEffect404001ui_story = var_145_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_11 = 0.200000002980232

			if var_145_10 <= arg_142_1.time_ and arg_142_1.time_ < var_145_10 + var_145_11 and not isNil(var_145_9) then
				local var_145_12 = (arg_142_1.time_ - var_145_10) / var_145_11

				if arg_142_1.var_.characterEffect404001ui_story and not isNil(var_145_9) then
					arg_142_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_10 + var_145_11 and arg_142_1.time_ < var_145_10 + var_145_11 + arg_145_0 and not isNil(var_145_9) and arg_142_1.var_.characterEffect404001ui_story then
				arg_142_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_145_13 = 0

			if var_145_13 < arg_142_1.time_ and arg_142_1.time_ <= var_145_13 + arg_145_0 then
				arg_142_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_145_14 = 0

			if var_145_14 < arg_142_1.time_ and arg_142_1.time_ <= var_145_14 + arg_145_0 then
				arg_142_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_145_15 = 0
			local var_145_16 = 0.275

			if var_145_15 < arg_142_1.time_ and arg_142_1.time_ <= var_145_15 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_17 = arg_142_1:FormatText(StoryNameCfg[668].name)

				arg_142_1.leftNameTxt_.text = var_145_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_18 = arg_142_1:GetWordFromCfg(322061034)
				local var_145_19 = arg_142_1:FormatText(var_145_18.content)

				arg_142_1.text_.text = var_145_19

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_20 = 11
				local var_145_21 = utf8.len(var_145_19)
				local var_145_22 = var_145_20 <= 0 and var_145_16 or var_145_16 * (var_145_21 / var_145_20)

				if var_145_22 > 0 and var_145_16 < var_145_22 then
					arg_142_1.talkMaxDuration = var_145_22

					if var_145_22 + var_145_15 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_22 + var_145_15
					end
				end

				arg_142_1.text_.text = var_145_19
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061034", "story_v_out_322061.awb") ~= 0 then
					local var_145_23 = manager.audio:GetVoiceLength("story_v_out_322061", "322061034", "story_v_out_322061.awb") / 1000

					if var_145_23 + var_145_15 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_23 + var_145_15
					end

					if var_145_18.prefab_name ~= "" and arg_142_1.actors_[var_145_18.prefab_name] ~= nil then
						local var_145_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_18.prefab_name].transform, "story_v_out_322061", "322061034", "story_v_out_322061.awb")

						arg_142_1:RecordAudio("322061034", var_145_24)
						arg_142_1:RecordAudio("322061034", var_145_24)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_322061", "322061034", "story_v_out_322061.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_322061", "322061034", "story_v_out_322061.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_25 = math.max(var_145_16, arg_142_1.talkMaxDuration)

			if var_145_15 <= arg_142_1.time_ and arg_142_1.time_ < var_145_15 + var_145_25 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_15) / var_145_25

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_15 + var_145_25 and arg_142_1.time_ < var_145_15 + var_145_25 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play322061035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 322061035
		arg_146_1.duration_ = 7.73

		local var_146_0 = {
			zh = 4.999999999999,
			ja = 7.733
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
				arg_146_0:Play322061036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = "10104ui_story"

			if arg_146_1.actors_[var_149_0] == nil then
				local var_149_1 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_149_1) then
					local var_149_2 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_146_1.stage_.transform)

					var_149_2.name = var_149_0
					var_149_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_146_1.actors_[var_149_0] = var_149_2

					local var_149_3 = var_149_2:GetComponentInChildren(typeof(CharacterEffect))

					var_149_3.enabled = true

					local var_149_4 = GameObjectTools.GetOrAddComponent(var_149_2, typeof(DynamicBoneHelper))

					if var_149_4 then
						var_149_4:EnableDynamicBone(false)
					end

					arg_146_1:ShowWeapon(var_149_3.transform, false)

					arg_146_1.var_[var_149_0 .. "Animator"] = var_149_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_146_1.var_[var_149_0 .. "Animator"].applyRootMotion = true
					arg_146_1.var_[var_149_0 .. "LipSync"] = var_149_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_149_5 = arg_146_1.actors_["10104ui_story"].transform
			local var_149_6 = 0

			if var_149_6 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.var_.moveOldPos10104ui_story = var_149_5.localPosition
			end

			local var_149_7 = 0.001

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_7 then
				local var_149_8 = (arg_146_1.time_ - var_149_6) / var_149_7
				local var_149_9 = Vector3.New(0.99, -1.12, -5.99)

				var_149_5.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10104ui_story, var_149_9, var_149_8)

				local var_149_10 = manager.ui.mainCamera.transform.position - var_149_5.position

				var_149_5.forward = Vector3.New(var_149_10.x, var_149_10.y, var_149_10.z)

				local var_149_11 = var_149_5.localEulerAngles

				var_149_11.z = 0
				var_149_11.x = 0
				var_149_5.localEulerAngles = var_149_11
			end

			if arg_146_1.time_ >= var_149_6 + var_149_7 and arg_146_1.time_ < var_149_6 + var_149_7 + arg_149_0 then
				var_149_5.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_149_12 = manager.ui.mainCamera.transform.position - var_149_5.position

				var_149_5.forward = Vector3.New(var_149_12.x, var_149_12.y, var_149_12.z)

				local var_149_13 = var_149_5.localEulerAngles

				var_149_13.z = 0
				var_149_13.x = 0
				var_149_5.localEulerAngles = var_149_13
			end

			local var_149_14 = arg_146_1.actors_["10104ui_story"]
			local var_149_15 = 0

			if var_149_15 < arg_146_1.time_ and arg_146_1.time_ <= var_149_15 + arg_149_0 and not isNil(var_149_14) and arg_146_1.var_.characterEffect10104ui_story == nil then
				arg_146_1.var_.characterEffect10104ui_story = var_149_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_16 = 0.200000002980232

			if var_149_15 <= arg_146_1.time_ and arg_146_1.time_ < var_149_15 + var_149_16 and not isNil(var_149_14) then
				local var_149_17 = (arg_146_1.time_ - var_149_15) / var_149_16

				if arg_146_1.var_.characterEffect10104ui_story and not isNil(var_149_14) then
					arg_146_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_15 + var_149_16 and arg_146_1.time_ < var_149_15 + var_149_16 + arg_149_0 and not isNil(var_149_14) and arg_146_1.var_.characterEffect10104ui_story then
				arg_146_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_149_18 = arg_146_1.actors_["404001ui_story"]
			local var_149_19 = 0

			if var_149_19 < arg_146_1.time_ and arg_146_1.time_ <= var_149_19 + arg_149_0 and not isNil(var_149_18) and arg_146_1.var_.characterEffect404001ui_story == nil then
				arg_146_1.var_.characterEffect404001ui_story = var_149_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_20 = 0.200000002980232

			if var_149_19 <= arg_146_1.time_ and arg_146_1.time_ < var_149_19 + var_149_20 and not isNil(var_149_18) then
				local var_149_21 = (arg_146_1.time_ - var_149_19) / var_149_20

				if arg_146_1.var_.characterEffect404001ui_story and not isNil(var_149_18) then
					local var_149_22 = Mathf.Lerp(0, 0.5, var_149_21)

					arg_146_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_146_1.var_.characterEffect404001ui_story.fillRatio = var_149_22
				end
			end

			if arg_146_1.time_ >= var_149_19 + var_149_20 and arg_146_1.time_ < var_149_19 + var_149_20 + arg_149_0 and not isNil(var_149_18) and arg_146_1.var_.characterEffect404001ui_story then
				local var_149_23 = 0.5

				arg_146_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_146_1.var_.characterEffect404001ui_story.fillRatio = var_149_23
			end

			local var_149_24 = 0

			if var_149_24 < arg_146_1.time_ and arg_146_1.time_ <= var_149_24 + arg_149_0 then
				arg_146_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			local var_149_25 = 0

			if var_149_25 < arg_146_1.time_ and arg_146_1.time_ <= var_149_25 + arg_149_0 then
				arg_146_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_149_26 = arg_146_1.actors_["10104ui_story"]
			local var_149_27 = 0

			if var_149_27 < arg_146_1.time_ and arg_146_1.time_ <= var_149_27 + arg_149_0 then
				if arg_146_1.var_.characterEffect10104ui_story == nil then
					arg_146_1.var_.characterEffect10104ui_story = var_149_26:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_149_28 = arg_146_1.var_.characterEffect10104ui_story

				var_149_28.imageEffect:turnOff()

				var_149_28.interferenceEffect.enabled = true
				var_149_28.interferenceEffect.noise = 0.001
				var_149_28.interferenceEffect.simTimeScale = 1
				var_149_28.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_149_29 = arg_146_1.actors_["10104ui_story"]
			local var_149_30 = 0
			local var_149_31 = 5

			if var_149_30 < arg_146_1.time_ and arg_146_1.time_ <= var_149_30 + arg_149_0 then
				if arg_146_1.var_.characterEffect10104ui_story == nil then
					arg_146_1.var_.characterEffect10104ui_story = var_149_29:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_146_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_149_32 = 0
			local var_149_33 = 0.375

			if var_149_32 < arg_146_1.time_ and arg_146_1.time_ <= var_149_32 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_34 = arg_146_1:FormatText(StoryNameCfg[1030].name)

				arg_146_1.leftNameTxt_.text = var_149_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_35 = arg_146_1:GetWordFromCfg(322061035)
				local var_149_36 = arg_146_1:FormatText(var_149_35.content)

				arg_146_1.text_.text = var_149_36

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_37 = 15
				local var_149_38 = utf8.len(var_149_36)
				local var_149_39 = var_149_37 <= 0 and var_149_33 or var_149_33 * (var_149_38 / var_149_37)

				if var_149_39 > 0 and var_149_33 < var_149_39 then
					arg_146_1.talkMaxDuration = var_149_39

					if var_149_39 + var_149_32 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_39 + var_149_32
					end
				end

				arg_146_1.text_.text = var_149_36
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061035", "story_v_out_322061.awb") ~= 0 then
					local var_149_40 = manager.audio:GetVoiceLength("story_v_out_322061", "322061035", "story_v_out_322061.awb") / 1000

					if var_149_40 + var_149_32 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_40 + var_149_32
					end

					if var_149_35.prefab_name ~= "" and arg_146_1.actors_[var_149_35.prefab_name] ~= nil then
						local var_149_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_35.prefab_name].transform, "story_v_out_322061", "322061035", "story_v_out_322061.awb")

						arg_146_1:RecordAudio("322061035", var_149_41)
						arg_146_1:RecordAudio("322061035", var_149_41)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_322061", "322061035", "story_v_out_322061.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_322061", "322061035", "story_v_out_322061.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_42 = math.max(var_149_33, arg_146_1.talkMaxDuration)

			if var_149_32 <= arg_146_1.time_ and arg_146_1.time_ < var_149_32 + var_149_42 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_32) / var_149_42

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_32 + var_149_42 and arg_146_1.time_ < var_149_32 + var_149_42 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
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

		arg_146_1:InitPlayNodeList()
	end,
	Play322061036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 322061036
		arg_150_1.duration_ = 9.3

		local var_150_0 = {
			zh = 5.533,
			ja = 9.3
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play322061037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = "1284ui_story"

			if arg_150_1.actors_[var_153_0] == nil then
				local var_153_1 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_153_1) then
					local var_153_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_150_1.stage_.transform)

					var_153_2.name = var_153_0
					var_153_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_150_1.actors_[var_153_0] = var_153_2

					local var_153_3 = var_153_2:GetComponentInChildren(typeof(CharacterEffect))

					var_153_3.enabled = true

					local var_153_4 = GameObjectTools.GetOrAddComponent(var_153_2, typeof(DynamicBoneHelper))

					if var_153_4 then
						var_153_4:EnableDynamicBone(false)
					end

					arg_150_1:ShowWeapon(var_153_3.transform, false)

					arg_150_1.var_[var_153_0 .. "Animator"] = var_153_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_150_1.var_[var_153_0 .. "Animator"].applyRootMotion = true
					arg_150_1.var_[var_153_0 .. "LipSync"] = var_153_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_153_5 = arg_150_1.actors_["1284ui_story"].transform
			local var_153_6 = 0

			if var_153_6 < arg_150_1.time_ and arg_150_1.time_ <= var_153_6 + arg_153_0 then
				arg_150_1.var_.moveOldPos1284ui_story = var_153_5.localPosition

				local var_153_7 = "1284ui_story"

				arg_150_1:ShowWeapon(arg_150_1.var_[var_153_7 .. "Animator"].transform, false)
			end

			local var_153_8 = 0.001

			if var_153_6 <= arg_150_1.time_ and arg_150_1.time_ < var_153_6 + var_153_8 then
				local var_153_9 = (arg_150_1.time_ - var_153_6) / var_153_8
				local var_153_10 = Vector3.New(-0.7, -0.985, -6.22)

				var_153_5.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1284ui_story, var_153_10, var_153_9)

				local var_153_11 = manager.ui.mainCamera.transform.position - var_153_5.position

				var_153_5.forward = Vector3.New(var_153_11.x, var_153_11.y, var_153_11.z)

				local var_153_12 = var_153_5.localEulerAngles

				var_153_12.z = 0
				var_153_12.x = 0
				var_153_5.localEulerAngles = var_153_12
			end

			if arg_150_1.time_ >= var_153_6 + var_153_8 and arg_150_1.time_ < var_153_6 + var_153_8 + arg_153_0 then
				var_153_5.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_153_13 = manager.ui.mainCamera.transform.position - var_153_5.position

				var_153_5.forward = Vector3.New(var_153_13.x, var_153_13.y, var_153_13.z)

				local var_153_14 = var_153_5.localEulerAngles

				var_153_14.z = 0
				var_153_14.x = 0
				var_153_5.localEulerAngles = var_153_14
			end

			local var_153_15 = arg_150_1.actors_["404001ui_story"].transform
			local var_153_16 = 0

			if var_153_16 < arg_150_1.time_ and arg_150_1.time_ <= var_153_16 + arg_153_0 then
				arg_150_1.var_.moveOldPos404001ui_story = var_153_15.localPosition
			end

			local var_153_17 = 0.001

			if var_153_16 <= arg_150_1.time_ and arg_150_1.time_ < var_153_16 + var_153_17 then
				local var_153_18 = (arg_150_1.time_ - var_153_16) / var_153_17
				local var_153_19 = Vector3.New(0, 100, 0)

				var_153_15.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos404001ui_story, var_153_19, var_153_18)

				local var_153_20 = manager.ui.mainCamera.transform.position - var_153_15.position

				var_153_15.forward = Vector3.New(var_153_20.x, var_153_20.y, var_153_20.z)

				local var_153_21 = var_153_15.localEulerAngles

				var_153_21.z = 0
				var_153_21.x = 0
				var_153_15.localEulerAngles = var_153_21
			end

			if arg_150_1.time_ >= var_153_16 + var_153_17 and arg_150_1.time_ < var_153_16 + var_153_17 + arg_153_0 then
				var_153_15.localPosition = Vector3.New(0, 100, 0)

				local var_153_22 = manager.ui.mainCamera.transform.position - var_153_15.position

				var_153_15.forward = Vector3.New(var_153_22.x, var_153_22.y, var_153_22.z)

				local var_153_23 = var_153_15.localEulerAngles

				var_153_23.z = 0
				var_153_23.x = 0
				var_153_15.localEulerAngles = var_153_23
			end

			local var_153_24 = arg_150_1.actors_["1284ui_story"]
			local var_153_25 = 0

			if var_153_25 < arg_150_1.time_ and arg_150_1.time_ <= var_153_25 + arg_153_0 and not isNil(var_153_24) and arg_150_1.var_.characterEffect1284ui_story == nil then
				arg_150_1.var_.characterEffect1284ui_story = var_153_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_26 = 0.200000002980232

			if var_153_25 <= arg_150_1.time_ and arg_150_1.time_ < var_153_25 + var_153_26 and not isNil(var_153_24) then
				local var_153_27 = (arg_150_1.time_ - var_153_25) / var_153_26

				if arg_150_1.var_.characterEffect1284ui_story and not isNil(var_153_24) then
					arg_150_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_25 + var_153_26 and arg_150_1.time_ < var_153_25 + var_153_26 + arg_153_0 and not isNil(var_153_24) and arg_150_1.var_.characterEffect1284ui_story then
				arg_150_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_153_28 = arg_150_1.actors_["10104ui_story"]
			local var_153_29 = 0

			if var_153_29 < arg_150_1.time_ and arg_150_1.time_ <= var_153_29 + arg_153_0 and not isNil(var_153_28) and arg_150_1.var_.characterEffect10104ui_story == nil then
				arg_150_1.var_.characterEffect10104ui_story = var_153_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_30 = 0.200000002980232

			if var_153_29 <= arg_150_1.time_ and arg_150_1.time_ < var_153_29 + var_153_30 and not isNil(var_153_28) then
				local var_153_31 = (arg_150_1.time_ - var_153_29) / var_153_30

				if arg_150_1.var_.characterEffect10104ui_story and not isNil(var_153_28) then
					local var_153_32 = Mathf.Lerp(0, 0.5, var_153_31)

					arg_150_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_150_1.var_.characterEffect10104ui_story.fillRatio = var_153_32
				end
			end

			if arg_150_1.time_ >= var_153_29 + var_153_30 and arg_150_1.time_ < var_153_29 + var_153_30 + arg_153_0 and not isNil(var_153_28) and arg_150_1.var_.characterEffect10104ui_story then
				local var_153_33 = 0.5

				arg_150_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_150_1.var_.characterEffect10104ui_story.fillRatio = var_153_33
			end

			local var_153_34 = 0

			if var_153_34 < arg_150_1.time_ and arg_150_1.time_ <= var_153_34 + arg_153_0 then
				arg_150_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_153_35 = 0

			if var_153_35 < arg_150_1.time_ and arg_150_1.time_ <= var_153_35 + arg_153_0 then
				arg_150_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_153_36 = 0
			local var_153_37 = 0.6

			if var_153_36 < arg_150_1.time_ and arg_150_1.time_ <= var_153_36 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_38 = arg_150_1:FormatText(StoryNameCfg[6].name)

				arg_150_1.leftNameTxt_.text = var_153_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_39 = arg_150_1:GetWordFromCfg(322061036)
				local var_153_40 = arg_150_1:FormatText(var_153_39.content)

				arg_150_1.text_.text = var_153_40

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_41 = 24
				local var_153_42 = utf8.len(var_153_40)
				local var_153_43 = var_153_41 <= 0 and var_153_37 or var_153_37 * (var_153_42 / var_153_41)

				if var_153_43 > 0 and var_153_37 < var_153_43 then
					arg_150_1.talkMaxDuration = var_153_43

					if var_153_43 + var_153_36 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_43 + var_153_36
					end
				end

				arg_150_1.text_.text = var_153_40
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061036", "story_v_out_322061.awb") ~= 0 then
					local var_153_44 = manager.audio:GetVoiceLength("story_v_out_322061", "322061036", "story_v_out_322061.awb") / 1000

					if var_153_44 + var_153_36 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_44 + var_153_36
					end

					if var_153_39.prefab_name ~= "" and arg_150_1.actors_[var_153_39.prefab_name] ~= nil then
						local var_153_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_39.prefab_name].transform, "story_v_out_322061", "322061036", "story_v_out_322061.awb")

						arg_150_1:RecordAudio("322061036", var_153_45)
						arg_150_1:RecordAudio("322061036", var_153_45)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_322061", "322061036", "story_v_out_322061.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_322061", "322061036", "story_v_out_322061.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_46 = math.max(var_153_37, arg_150_1.talkMaxDuration)

			if var_153_36 <= arg_150_1.time_ and arg_150_1.time_ < var_153_36 + var_153_46 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_36) / var_153_46

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_36 + var_153_46 and arg_150_1.time_ < var_153_36 + var_153_46 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
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
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play322061037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 322061037
		arg_154_1.duration_ = 5.8

		local var_154_0 = {
			zh = 4.1,
			ja = 5.8
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
				arg_154_0:Play322061038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["10104ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect10104ui_story == nil then
				arg_154_1.var_.characterEffect10104ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect10104ui_story and not isNil(var_157_0) then
					arg_154_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect10104ui_story then
				arg_154_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_157_4 = arg_154_1.actors_["1284ui_story"]
			local var_157_5 = 0

			if var_157_5 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 and not isNil(var_157_4) and arg_154_1.var_.characterEffect1284ui_story == nil then
				arg_154_1.var_.characterEffect1284ui_story = var_157_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_6 = 0.200000002980232

			if var_157_5 <= arg_154_1.time_ and arg_154_1.time_ < var_157_5 + var_157_6 and not isNil(var_157_4) then
				local var_157_7 = (arg_154_1.time_ - var_157_5) / var_157_6

				if arg_154_1.var_.characterEffect1284ui_story and not isNil(var_157_4) then
					local var_157_8 = Mathf.Lerp(0, 0.5, var_157_7)

					arg_154_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1284ui_story.fillRatio = var_157_8
				end
			end

			if arg_154_1.time_ >= var_157_5 + var_157_6 and arg_154_1.time_ < var_157_5 + var_157_6 + arg_157_0 and not isNil(var_157_4) and arg_154_1.var_.characterEffect1284ui_story then
				local var_157_9 = 0.5

				arg_154_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1284ui_story.fillRatio = var_157_9
			end

			local var_157_10 = 0

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 then
				arg_154_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			local var_157_11 = 0

			if var_157_11 < arg_154_1.time_ and arg_154_1.time_ <= var_157_11 + arg_157_0 then
				arg_154_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_157_12 = 0
			local var_157_13 = 0.55

			if var_157_12 < arg_154_1.time_ and arg_154_1.time_ <= var_157_12 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_14 = arg_154_1:FormatText(StoryNameCfg[1030].name)

				arg_154_1.leftNameTxt_.text = var_157_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_15 = arg_154_1:GetWordFromCfg(322061037)
				local var_157_16 = arg_154_1:FormatText(var_157_15.content)

				arg_154_1.text_.text = var_157_16

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_17 = 22
				local var_157_18 = utf8.len(var_157_16)
				local var_157_19 = var_157_17 <= 0 and var_157_13 or var_157_13 * (var_157_18 / var_157_17)

				if var_157_19 > 0 and var_157_13 < var_157_19 then
					arg_154_1.talkMaxDuration = var_157_19

					if var_157_19 + var_157_12 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_19 + var_157_12
					end
				end

				arg_154_1.text_.text = var_157_16
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061037", "story_v_out_322061.awb") ~= 0 then
					local var_157_20 = manager.audio:GetVoiceLength("story_v_out_322061", "322061037", "story_v_out_322061.awb") / 1000

					if var_157_20 + var_157_12 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_20 + var_157_12
					end

					if var_157_15.prefab_name ~= "" and arg_154_1.actors_[var_157_15.prefab_name] ~= nil then
						local var_157_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_15.prefab_name].transform, "story_v_out_322061", "322061037", "story_v_out_322061.awb")

						arg_154_1:RecordAudio("322061037", var_157_21)
						arg_154_1:RecordAudio("322061037", var_157_21)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_322061", "322061037", "story_v_out_322061.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_322061", "322061037", "story_v_out_322061.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_22 = math.max(var_157_13, arg_154_1.talkMaxDuration)

			if var_157_12 <= arg_154_1.time_ and arg_154_1.time_ < var_157_12 + var_157_22 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_12) / var_157_22

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_12 + var_157_22 and arg_154_1.time_ < var_157_12 + var_157_22 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play322061038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 322061038
		arg_158_1.duration_ = 10.03

		local var_158_0 = {
			zh = 8.633,
			ja = 10.033
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play322061039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["10104ui_story"].transform
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.var_.moveOldPos10104ui_story = var_161_0.localPosition
			end

			local var_161_2 = 0.001

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2
				local var_161_4 = Vector3.New(0.99, -1.12, -5.99)

				var_161_0.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos10104ui_story, var_161_4, var_161_3)

				local var_161_5 = manager.ui.mainCamera.transform.position - var_161_0.position

				var_161_0.forward = Vector3.New(var_161_5.x, var_161_5.y, var_161_5.z)

				local var_161_6 = var_161_0.localEulerAngles

				var_161_6.z = 0
				var_161_6.x = 0
				var_161_0.localEulerAngles = var_161_6
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 then
				var_161_0.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_161_7 = manager.ui.mainCamera.transform.position - var_161_0.position

				var_161_0.forward = Vector3.New(var_161_7.x, var_161_7.y, var_161_7.z)

				local var_161_8 = var_161_0.localEulerAngles

				var_161_8.z = 0
				var_161_8.x = 0
				var_161_0.localEulerAngles = var_161_8
			end

			local var_161_9 = 0

			if var_161_9 < arg_158_1.time_ and arg_158_1.time_ <= var_161_9 + arg_161_0 then
				arg_158_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_161_10 = 0

			if var_161_10 < arg_158_1.time_ and arg_158_1.time_ <= var_161_10 + arg_161_0 then
				arg_158_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_161_11 = arg_158_1.actors_["10104ui_story"]
			local var_161_12 = 0

			if var_161_12 < arg_158_1.time_ and arg_158_1.time_ <= var_161_12 + arg_161_0 then
				if arg_158_1.var_.characterEffect10104ui_story == nil then
					arg_158_1.var_.characterEffect10104ui_story = var_161_11:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_161_13 = arg_158_1.var_.characterEffect10104ui_story

				var_161_13.imageEffect:turnOff()

				var_161_13.interferenceEffect.enabled = true
				var_161_13.interferenceEffect.noise = 0.001
				var_161_13.interferenceEffect.simTimeScale = 1
				var_161_13.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_161_14 = arg_158_1.actors_["10104ui_story"]
			local var_161_15 = 0
			local var_161_16 = 5

			if var_161_15 < arg_158_1.time_ and arg_158_1.time_ <= var_161_15 + arg_161_0 then
				if arg_158_1.var_.characterEffect10104ui_story == nil then
					arg_158_1.var_.characterEffect10104ui_story = var_161_14:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_158_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_161_17 = 0
			local var_161_18 = 1.125

			if var_161_17 < arg_158_1.time_ and arg_158_1.time_ <= var_161_17 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_19 = arg_158_1:FormatText(StoryNameCfg[1030].name)

				arg_158_1.leftNameTxt_.text = var_161_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_20 = arg_158_1:GetWordFromCfg(322061038)
				local var_161_21 = arg_158_1:FormatText(var_161_20.content)

				arg_158_1.text_.text = var_161_21

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_22 = 45
				local var_161_23 = utf8.len(var_161_21)
				local var_161_24 = var_161_22 <= 0 and var_161_18 or var_161_18 * (var_161_23 / var_161_22)

				if var_161_24 > 0 and var_161_18 < var_161_24 then
					arg_158_1.talkMaxDuration = var_161_24

					if var_161_24 + var_161_17 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_24 + var_161_17
					end
				end

				arg_158_1.text_.text = var_161_21
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061038", "story_v_out_322061.awb") ~= 0 then
					local var_161_25 = manager.audio:GetVoiceLength("story_v_out_322061", "322061038", "story_v_out_322061.awb") / 1000

					if var_161_25 + var_161_17 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_25 + var_161_17
					end

					if var_161_20.prefab_name ~= "" and arg_158_1.actors_[var_161_20.prefab_name] ~= nil then
						local var_161_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_20.prefab_name].transform, "story_v_out_322061", "322061038", "story_v_out_322061.awb")

						arg_158_1:RecordAudio("322061038", var_161_26)
						arg_158_1:RecordAudio("322061038", var_161_26)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_322061", "322061038", "story_v_out_322061.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_322061", "322061038", "story_v_out_322061.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_27 = math.max(var_161_18, arg_158_1.talkMaxDuration)

			if var_161_17 <= arg_158_1.time_ and arg_158_1.time_ < var_161_17 + var_161_27 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_17) / var_161_27

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_17 + var_161_27 and arg_158_1.time_ < var_161_17 + var_161_27 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
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

		arg_158_1:InitPlayNodeList()
	end,
	Play322061039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 322061039
		arg_162_1.duration_ = 3.5

		local var_162_0 = {
			zh = 3.3,
			ja = 3.5
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
				arg_162_0:Play322061040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1284ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1284ui_story == nil then
				arg_162_1.var_.characterEffect1284ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect1284ui_story and not isNil(var_165_0) then
					arg_162_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1284ui_story then
				arg_162_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_165_4 = arg_162_1.actors_["10104ui_story"]
			local var_165_5 = 0

			if var_165_5 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 and not isNil(var_165_4) and arg_162_1.var_.characterEffect10104ui_story == nil then
				arg_162_1.var_.characterEffect10104ui_story = var_165_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_6 = 0.200000002980232

			if var_165_5 <= arg_162_1.time_ and arg_162_1.time_ < var_165_5 + var_165_6 and not isNil(var_165_4) then
				local var_165_7 = (arg_162_1.time_ - var_165_5) / var_165_6

				if arg_162_1.var_.characterEffect10104ui_story and not isNil(var_165_4) then
					local var_165_8 = Mathf.Lerp(0, 0.5, var_165_7)

					arg_162_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_162_1.var_.characterEffect10104ui_story.fillRatio = var_165_8
				end
			end

			if arg_162_1.time_ >= var_165_5 + var_165_6 and arg_162_1.time_ < var_165_5 + var_165_6 + arg_165_0 and not isNil(var_165_4) and arg_162_1.var_.characterEffect10104ui_story then
				local var_165_9 = 0.5

				arg_162_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_162_1.var_.characterEffect10104ui_story.fillRatio = var_165_9
			end

			local var_165_10 = 0

			if var_165_10 < arg_162_1.time_ and arg_162_1.time_ <= var_165_10 + arg_165_0 then
				arg_162_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			local var_165_11 = 0

			if var_165_11 < arg_162_1.time_ and arg_162_1.time_ <= var_165_11 + arg_165_0 then
				arg_162_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_165_12 = 0
			local var_165_13 = 0.25

			if var_165_12 < arg_162_1.time_ and arg_162_1.time_ <= var_165_12 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_14 = arg_162_1:FormatText(StoryNameCfg[6].name)

				arg_162_1.leftNameTxt_.text = var_165_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_15 = arg_162_1:GetWordFromCfg(322061039)
				local var_165_16 = arg_162_1:FormatText(var_165_15.content)

				arg_162_1.text_.text = var_165_16

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_17 = 10
				local var_165_18 = utf8.len(var_165_16)
				local var_165_19 = var_165_17 <= 0 and var_165_13 or var_165_13 * (var_165_18 / var_165_17)

				if var_165_19 > 0 and var_165_13 < var_165_19 then
					arg_162_1.talkMaxDuration = var_165_19

					if var_165_19 + var_165_12 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_19 + var_165_12
					end
				end

				arg_162_1.text_.text = var_165_16
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061039", "story_v_out_322061.awb") ~= 0 then
					local var_165_20 = manager.audio:GetVoiceLength("story_v_out_322061", "322061039", "story_v_out_322061.awb") / 1000

					if var_165_20 + var_165_12 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_20 + var_165_12
					end

					if var_165_15.prefab_name ~= "" and arg_162_1.actors_[var_165_15.prefab_name] ~= nil then
						local var_165_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_15.prefab_name].transform, "story_v_out_322061", "322061039", "story_v_out_322061.awb")

						arg_162_1:RecordAudio("322061039", var_165_21)
						arg_162_1:RecordAudio("322061039", var_165_21)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_322061", "322061039", "story_v_out_322061.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_322061", "322061039", "story_v_out_322061.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_22 = math.max(var_165_13, arg_162_1.talkMaxDuration)

			if var_165_12 <= arg_162_1.time_ and arg_162_1.time_ < var_165_12 + var_165_22 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_12) / var_165_22

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_12 + var_165_22 and arg_162_1.time_ < var_165_12 + var_165_22 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play322061040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 322061040
		arg_166_1.duration_ = 14.4

		local var_166_0 = {
			zh = 8,
			ja = 14.4
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
				arg_166_0:Play322061041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["10104ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect10104ui_story == nil then
				arg_166_1.var_.characterEffect10104ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.200000002980232

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect10104ui_story and not isNil(var_169_0) then
					arg_166_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect10104ui_story then
				arg_166_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_169_4 = arg_166_1.actors_["1284ui_story"]
			local var_169_5 = 0

			if var_169_5 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.characterEffect1284ui_story == nil then
				arg_166_1.var_.characterEffect1284ui_story = var_169_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_6 = 0.200000002980232

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_6 and not isNil(var_169_4) then
				local var_169_7 = (arg_166_1.time_ - var_169_5) / var_169_6

				if arg_166_1.var_.characterEffect1284ui_story and not isNil(var_169_4) then
					local var_169_8 = Mathf.Lerp(0, 0.5, var_169_7)

					arg_166_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1284ui_story.fillRatio = var_169_8
				end
			end

			if arg_166_1.time_ >= var_169_5 + var_169_6 and arg_166_1.time_ < var_169_5 + var_169_6 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.characterEffect1284ui_story then
				local var_169_9 = 0.5

				arg_166_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1284ui_story.fillRatio = var_169_9
			end

			local var_169_10 = 0

			if var_169_10 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action4_1")
			end

			local var_169_11 = 0

			if var_169_11 < arg_166_1.time_ and arg_166_1.time_ <= var_169_11 + arg_169_0 then
				arg_166_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_169_12 = arg_166_1.actors_["10104ui_story"]
			local var_169_13 = 0

			if var_169_13 < arg_166_1.time_ and arg_166_1.time_ <= var_169_13 + arg_169_0 then
				if arg_166_1.var_.characterEffect10104ui_story == nil then
					arg_166_1.var_.characterEffect10104ui_story = var_169_12:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_169_14 = arg_166_1.var_.characterEffect10104ui_story

				var_169_14.imageEffect:turnOff()

				var_169_14.interferenceEffect.enabled = true
				var_169_14.interferenceEffect.noise = 0.001
				var_169_14.interferenceEffect.simTimeScale = 1
				var_169_14.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_169_15 = arg_166_1.actors_["10104ui_story"]
			local var_169_16 = 0
			local var_169_17 = 5

			if var_169_16 < arg_166_1.time_ and arg_166_1.time_ <= var_169_16 + arg_169_0 then
				if arg_166_1.var_.characterEffect10104ui_story == nil then
					arg_166_1.var_.characterEffect10104ui_story = var_169_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_166_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_169_18 = 0
			local var_169_19 = 1.075

			if var_169_18 < arg_166_1.time_ and arg_166_1.time_ <= var_169_18 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_20 = arg_166_1:FormatText(StoryNameCfg[1030].name)

				arg_166_1.leftNameTxt_.text = var_169_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_21 = arg_166_1:GetWordFromCfg(322061040)
				local var_169_22 = arg_166_1:FormatText(var_169_21.content)

				arg_166_1.text_.text = var_169_22

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_23 = 43
				local var_169_24 = utf8.len(var_169_22)
				local var_169_25 = var_169_23 <= 0 and var_169_19 or var_169_19 * (var_169_24 / var_169_23)

				if var_169_25 > 0 and var_169_19 < var_169_25 then
					arg_166_1.talkMaxDuration = var_169_25

					if var_169_25 + var_169_18 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_25 + var_169_18
					end
				end

				arg_166_1.text_.text = var_169_22
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061040", "story_v_out_322061.awb") ~= 0 then
					local var_169_26 = manager.audio:GetVoiceLength("story_v_out_322061", "322061040", "story_v_out_322061.awb") / 1000

					if var_169_26 + var_169_18 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_26 + var_169_18
					end

					if var_169_21.prefab_name ~= "" and arg_166_1.actors_[var_169_21.prefab_name] ~= nil then
						local var_169_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_21.prefab_name].transform, "story_v_out_322061", "322061040", "story_v_out_322061.awb")

						arg_166_1:RecordAudio("322061040", var_169_27)
						arg_166_1:RecordAudio("322061040", var_169_27)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_322061", "322061040", "story_v_out_322061.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_322061", "322061040", "story_v_out_322061.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_28 = math.max(var_169_19, arg_166_1.talkMaxDuration)

			if var_169_18 <= arg_166_1.time_ and arg_166_1.time_ < var_169_18 + var_169_28 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_18) / var_169_28

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_18 + var_169_28 and arg_166_1.time_ < var_169_18 + var_169_28 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play322061041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 322061041
		arg_170_1.duration_ = 9.9

		local var_170_0 = {
			zh = 8.166,
			ja = 9.9
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
				arg_170_0:Play322061042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10104ui_story"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				if arg_170_1.var_.characterEffect10104ui_story == nil then
					arg_170_1.var_.characterEffect10104ui_story = var_173_0:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_173_2 = arg_170_1.var_.characterEffect10104ui_story

				var_173_2.imageEffect:turnOff()

				var_173_2.interferenceEffect.enabled = true
				var_173_2.interferenceEffect.noise = 0.001
				var_173_2.interferenceEffect.simTimeScale = 1
				var_173_2.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_173_3 = arg_170_1.actors_["10104ui_story"]
			local var_173_4 = 0
			local var_173_5 = 5

			if var_173_4 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				if arg_170_1.var_.characterEffect10104ui_story == nil then
					arg_170_1.var_.characterEffect10104ui_story = var_173_3:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_170_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_173_6 = 0
			local var_173_7 = 1

			if var_173_6 < arg_170_1.time_ and arg_170_1.time_ <= var_173_6 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_8 = arg_170_1:FormatText(StoryNameCfg[1030].name)

				arg_170_1.leftNameTxt_.text = var_173_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_9 = arg_170_1:GetWordFromCfg(322061041)
				local var_173_10 = arg_170_1:FormatText(var_173_9.content)

				arg_170_1.text_.text = var_173_10

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_11 = 40
				local var_173_12 = utf8.len(var_173_10)
				local var_173_13 = var_173_11 <= 0 and var_173_7 or var_173_7 * (var_173_12 / var_173_11)

				if var_173_13 > 0 and var_173_7 < var_173_13 then
					arg_170_1.talkMaxDuration = var_173_13

					if var_173_13 + var_173_6 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_13 + var_173_6
					end
				end

				arg_170_1.text_.text = var_173_10
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061041", "story_v_out_322061.awb") ~= 0 then
					local var_173_14 = manager.audio:GetVoiceLength("story_v_out_322061", "322061041", "story_v_out_322061.awb") / 1000

					if var_173_14 + var_173_6 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_14 + var_173_6
					end

					if var_173_9.prefab_name ~= "" and arg_170_1.actors_[var_173_9.prefab_name] ~= nil then
						local var_173_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_9.prefab_name].transform, "story_v_out_322061", "322061041", "story_v_out_322061.awb")

						arg_170_1:RecordAudio("322061041", var_173_15)
						arg_170_1:RecordAudio("322061041", var_173_15)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_322061", "322061041", "story_v_out_322061.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_322061", "322061041", "story_v_out_322061.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_16 = math.max(var_173_7, arg_170_1.talkMaxDuration)

			if var_173_6 <= arg_170_1.time_ and arg_170_1.time_ < var_173_6 + var_173_16 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_6) / var_173_16

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_6 + var_173_16 and arg_170_1.time_ < var_173_6 + var_173_16 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play322061042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 322061042
		arg_174_1.duration_ = 13

		local var_174_0 = {
			zh = 10.6,
			ja = 13
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
				arg_174_0:Play322061043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action4_2")
			end

			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_177_2 = arg_174_1.actors_["10104ui_story"]
			local var_177_3 = 0

			if var_177_3 < arg_174_1.time_ and arg_174_1.time_ <= var_177_3 + arg_177_0 then
				if arg_174_1.var_.characterEffect10104ui_story == nil then
					arg_174_1.var_.characterEffect10104ui_story = var_177_2:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_177_4 = arg_174_1.var_.characterEffect10104ui_story

				var_177_4.imageEffect:turnOff()

				var_177_4.interferenceEffect.enabled = true
				var_177_4.interferenceEffect.noise = 0.001
				var_177_4.interferenceEffect.simTimeScale = 1
				var_177_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_177_5 = arg_174_1.actors_["10104ui_story"]
			local var_177_6 = 0
			local var_177_7 = 5

			if var_177_6 < arg_174_1.time_ and arg_174_1.time_ <= var_177_6 + arg_177_0 then
				if arg_174_1.var_.characterEffect10104ui_story == nil then
					arg_174_1.var_.characterEffect10104ui_story = var_177_5:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_174_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_177_8 = 0
			local var_177_9 = 1.45

			if var_177_8 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_10 = arg_174_1:FormatText(StoryNameCfg[1030].name)

				arg_174_1.leftNameTxt_.text = var_177_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_11 = arg_174_1:GetWordFromCfg(322061042)
				local var_177_12 = arg_174_1:FormatText(var_177_11.content)

				arg_174_1.text_.text = var_177_12

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_13 = 58
				local var_177_14 = utf8.len(var_177_12)
				local var_177_15 = var_177_13 <= 0 and var_177_9 or var_177_9 * (var_177_14 / var_177_13)

				if var_177_15 > 0 and var_177_9 < var_177_15 then
					arg_174_1.talkMaxDuration = var_177_15

					if var_177_15 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_15 + var_177_8
					end
				end

				arg_174_1.text_.text = var_177_12
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061042", "story_v_out_322061.awb") ~= 0 then
					local var_177_16 = manager.audio:GetVoiceLength("story_v_out_322061", "322061042", "story_v_out_322061.awb") / 1000

					if var_177_16 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_16 + var_177_8
					end

					if var_177_11.prefab_name ~= "" and arg_174_1.actors_[var_177_11.prefab_name] ~= nil then
						local var_177_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_11.prefab_name].transform, "story_v_out_322061", "322061042", "story_v_out_322061.awb")

						arg_174_1:RecordAudio("322061042", var_177_17)
						arg_174_1:RecordAudio("322061042", var_177_17)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_322061", "322061042", "story_v_out_322061.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_322061", "322061042", "story_v_out_322061.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_18 = math.max(var_177_9, arg_174_1.talkMaxDuration)

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_18 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_8) / var_177_18

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_8 + var_177_18 and arg_174_1.time_ < var_177_8 + var_177_18 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play322061043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 322061043
		arg_178_1.duration_ = 10.37

		local var_178_0 = {
			zh = 7.933,
			ja = 10.366
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
				arg_178_0:Play322061044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["404001ui_story"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos404001ui_story = var_181_0.localPosition
			end

			local var_181_2 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2
				local var_181_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos404001ui_story, var_181_4, var_181_3)

				local var_181_5 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_5.x, var_181_5.y, var_181_5.z)

				local var_181_6 = var_181_0.localEulerAngles

				var_181_6.z = 0
				var_181_6.x = 0
				var_181_0.localEulerAngles = var_181_6
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_181_7 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_7.x, var_181_7.y, var_181_7.z)

				local var_181_8 = var_181_0.localEulerAngles

				var_181_8.z = 0
				var_181_8.x = 0
				var_181_0.localEulerAngles = var_181_8
			end

			local var_181_9 = arg_178_1.actors_["1284ui_story"].transform
			local var_181_10 = 0

			if var_181_10 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 then
				arg_178_1.var_.moveOldPos1284ui_story = var_181_9.localPosition
			end

			local var_181_11 = 0.001

			if var_181_10 <= arg_178_1.time_ and arg_178_1.time_ < var_181_10 + var_181_11 then
				local var_181_12 = (arg_178_1.time_ - var_181_10) / var_181_11
				local var_181_13 = Vector3.New(0, 100, 0)

				var_181_9.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1284ui_story, var_181_13, var_181_12)

				local var_181_14 = manager.ui.mainCamera.transform.position - var_181_9.position

				var_181_9.forward = Vector3.New(var_181_14.x, var_181_14.y, var_181_14.z)

				local var_181_15 = var_181_9.localEulerAngles

				var_181_15.z = 0
				var_181_15.x = 0
				var_181_9.localEulerAngles = var_181_15
			end

			if arg_178_1.time_ >= var_181_10 + var_181_11 and arg_178_1.time_ < var_181_10 + var_181_11 + arg_181_0 then
				var_181_9.localPosition = Vector3.New(0, 100, 0)

				local var_181_16 = manager.ui.mainCamera.transform.position - var_181_9.position

				var_181_9.forward = Vector3.New(var_181_16.x, var_181_16.y, var_181_16.z)

				local var_181_17 = var_181_9.localEulerAngles

				var_181_17.z = 0
				var_181_17.x = 0
				var_181_9.localEulerAngles = var_181_17
			end

			local var_181_18 = arg_178_1.actors_["404001ui_story"]
			local var_181_19 = 0

			if var_181_19 < arg_178_1.time_ and arg_178_1.time_ <= var_181_19 + arg_181_0 and not isNil(var_181_18) and arg_178_1.var_.characterEffect404001ui_story == nil then
				arg_178_1.var_.characterEffect404001ui_story = var_181_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_20 = 0.200000002980232

			if var_181_19 <= arg_178_1.time_ and arg_178_1.time_ < var_181_19 + var_181_20 and not isNil(var_181_18) then
				local var_181_21 = (arg_178_1.time_ - var_181_19) / var_181_20

				if arg_178_1.var_.characterEffect404001ui_story and not isNil(var_181_18) then
					arg_178_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_19 + var_181_20 and arg_178_1.time_ < var_181_19 + var_181_20 + arg_181_0 and not isNil(var_181_18) and arg_178_1.var_.characterEffect404001ui_story then
				arg_178_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_181_22 = arg_178_1.actors_["10104ui_story"]
			local var_181_23 = 0

			if var_181_23 < arg_178_1.time_ and arg_178_1.time_ <= var_181_23 + arg_181_0 and not isNil(var_181_22) and arg_178_1.var_.characterEffect10104ui_story == nil then
				arg_178_1.var_.characterEffect10104ui_story = var_181_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_24 = 0.200000002980232

			if var_181_23 <= arg_178_1.time_ and arg_178_1.time_ < var_181_23 + var_181_24 and not isNil(var_181_22) then
				local var_181_25 = (arg_178_1.time_ - var_181_23) / var_181_24

				if arg_178_1.var_.characterEffect10104ui_story and not isNil(var_181_22) then
					local var_181_26 = Mathf.Lerp(0, 0.5, var_181_25)

					arg_178_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_178_1.var_.characterEffect10104ui_story.fillRatio = var_181_26
				end
			end

			if arg_178_1.time_ >= var_181_23 + var_181_24 and arg_178_1.time_ < var_181_23 + var_181_24 + arg_181_0 and not isNil(var_181_22) and arg_178_1.var_.characterEffect10104ui_story then
				local var_181_27 = 0.5

				arg_178_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_178_1.var_.characterEffect10104ui_story.fillRatio = var_181_27
			end

			local var_181_28 = 0

			if var_181_28 < arg_178_1.time_ and arg_178_1.time_ <= var_181_28 + arg_181_0 then
				arg_178_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_181_29 = 0

			if var_181_29 < arg_178_1.time_ and arg_178_1.time_ <= var_181_29 + arg_181_0 then
				arg_178_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_181_30 = 0
			local var_181_31 = 1

			if var_181_30 < arg_178_1.time_ and arg_178_1.time_ <= var_181_30 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_32 = arg_178_1:FormatText(StoryNameCfg[668].name)

				arg_178_1.leftNameTxt_.text = var_181_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_33 = arg_178_1:GetWordFromCfg(322061043)
				local var_181_34 = arg_178_1:FormatText(var_181_33.content)

				arg_178_1.text_.text = var_181_34

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_35 = 40
				local var_181_36 = utf8.len(var_181_34)
				local var_181_37 = var_181_35 <= 0 and var_181_31 or var_181_31 * (var_181_36 / var_181_35)

				if var_181_37 > 0 and var_181_31 < var_181_37 then
					arg_178_1.talkMaxDuration = var_181_37

					if var_181_37 + var_181_30 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_37 + var_181_30
					end
				end

				arg_178_1.text_.text = var_181_34
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061043", "story_v_out_322061.awb") ~= 0 then
					local var_181_38 = manager.audio:GetVoiceLength("story_v_out_322061", "322061043", "story_v_out_322061.awb") / 1000

					if var_181_38 + var_181_30 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_38 + var_181_30
					end

					if var_181_33.prefab_name ~= "" and arg_178_1.actors_[var_181_33.prefab_name] ~= nil then
						local var_181_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_33.prefab_name].transform, "story_v_out_322061", "322061043", "story_v_out_322061.awb")

						arg_178_1:RecordAudio("322061043", var_181_39)
						arg_178_1:RecordAudio("322061043", var_181_39)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_322061", "322061043", "story_v_out_322061.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_322061", "322061043", "story_v_out_322061.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_40 = math.max(var_181_31, arg_178_1.talkMaxDuration)

			if var_181_30 <= arg_178_1.time_ and arg_178_1.time_ < var_181_30 + var_181_40 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_30) / var_181_40

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_30 + var_181_40 and arg_178_1.time_ < var_181_30 + var_181_40 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_178_1:InitPlayNodeList()
	end,
	Play322061044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 322061044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play322061045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["10104ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect10104ui_story == nil then
				arg_182_1.var_.characterEffect10104ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect10104ui_story and not isNil(var_185_0) then
					arg_182_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect10104ui_story then
				arg_182_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_185_4 = arg_182_1.actors_["404001ui_story"]
			local var_185_5 = 0

			if var_185_5 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 and not isNil(var_185_4) and arg_182_1.var_.characterEffect404001ui_story == nil then
				arg_182_1.var_.characterEffect404001ui_story = var_185_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_6 = 0.200000002980232

			if var_185_5 <= arg_182_1.time_ and arg_182_1.time_ < var_185_5 + var_185_6 and not isNil(var_185_4) then
				local var_185_7 = (arg_182_1.time_ - var_185_5) / var_185_6

				if arg_182_1.var_.characterEffect404001ui_story and not isNil(var_185_4) then
					local var_185_8 = Mathf.Lerp(0, 0.5, var_185_7)

					arg_182_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_182_1.var_.characterEffect404001ui_story.fillRatio = var_185_8
				end
			end

			if arg_182_1.time_ >= var_185_5 + var_185_6 and arg_182_1.time_ < var_185_5 + var_185_6 + arg_185_0 and not isNil(var_185_4) and arg_182_1.var_.characterEffect404001ui_story then
				local var_185_9 = 0.5

				arg_182_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_182_1.var_.characterEffect404001ui_story.fillRatio = var_185_9
			end

			local var_185_10 = 0

			if var_185_10 < arg_182_1.time_ and arg_182_1.time_ <= var_185_10 + arg_185_0 then
				arg_182_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_185_11 = 0

			if var_185_11 < arg_182_1.time_ and arg_182_1.time_ <= var_185_11 + arg_185_0 then
				arg_182_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_185_12 = arg_182_1.actors_["10104ui_story"]
			local var_185_13 = 0

			if var_185_13 < arg_182_1.time_ and arg_182_1.time_ <= var_185_13 + arg_185_0 then
				if arg_182_1.var_.characterEffect10104ui_story == nil then
					arg_182_1.var_.characterEffect10104ui_story = var_185_12:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_185_14 = arg_182_1.var_.characterEffect10104ui_story

				var_185_14.imageEffect:turnOff()

				var_185_14.interferenceEffect.enabled = true
				var_185_14.interferenceEffect.noise = 0.001
				var_185_14.interferenceEffect.simTimeScale = 1
				var_185_14.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_185_15 = arg_182_1.actors_["10104ui_story"]
			local var_185_16 = 0
			local var_185_17 = 5

			if var_185_16 < arg_182_1.time_ and arg_182_1.time_ <= var_185_16 + arg_185_0 then
				if arg_182_1.var_.characterEffect10104ui_story == nil then
					arg_182_1.var_.characterEffect10104ui_story = var_185_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_182_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_185_18 = 0
			local var_185_19 = 0.375

			if var_185_18 < arg_182_1.time_ and arg_182_1.time_ <= var_185_18 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_20 = arg_182_1:FormatText(StoryNameCfg[1030].name)

				arg_182_1.leftNameTxt_.text = var_185_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_21 = arg_182_1:GetWordFromCfg(322061044)
				local var_185_22 = arg_182_1:FormatText(var_185_21.content)

				arg_182_1.text_.text = var_185_22

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_23 = 15
				local var_185_24 = utf8.len(var_185_22)
				local var_185_25 = var_185_23 <= 0 and var_185_19 or var_185_19 * (var_185_24 / var_185_23)

				if var_185_25 > 0 and var_185_19 < var_185_25 then
					arg_182_1.talkMaxDuration = var_185_25

					if var_185_25 + var_185_18 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_25 + var_185_18
					end
				end

				arg_182_1.text_.text = var_185_22
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061044", "story_v_out_322061.awb") ~= 0 then
					local var_185_26 = manager.audio:GetVoiceLength("story_v_out_322061", "322061044", "story_v_out_322061.awb") / 1000

					if var_185_26 + var_185_18 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_26 + var_185_18
					end

					if var_185_21.prefab_name ~= "" and arg_182_1.actors_[var_185_21.prefab_name] ~= nil then
						local var_185_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_21.prefab_name].transform, "story_v_out_322061", "322061044", "story_v_out_322061.awb")

						arg_182_1:RecordAudio("322061044", var_185_27)
						arg_182_1:RecordAudio("322061044", var_185_27)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_322061", "322061044", "story_v_out_322061.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_322061", "322061044", "story_v_out_322061.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_28 = math.max(var_185_19, arg_182_1.talkMaxDuration)

			if var_185_18 <= arg_182_1.time_ and arg_182_1.time_ < var_185_18 + var_185_28 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_18) / var_185_28

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_18 + var_185_28 and arg_182_1.time_ < var_185_18 + var_185_28 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play322061045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 322061045
		arg_186_1.duration_ = 2.93

		local var_186_0 = {
			zh = 2.2,
			ja = 2.933
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play322061046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["404001ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect404001ui_story == nil then
				arg_186_1.var_.characterEffect404001ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect404001ui_story and not isNil(var_189_0) then
					arg_186_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect404001ui_story then
				arg_186_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_189_4 = arg_186_1.actors_["10104ui_story"]
			local var_189_5 = 0

			if var_189_5 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 and not isNil(var_189_4) and arg_186_1.var_.characterEffect10104ui_story == nil then
				arg_186_1.var_.characterEffect10104ui_story = var_189_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_6 = 0.200000002980232

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_6 and not isNil(var_189_4) then
				local var_189_7 = (arg_186_1.time_ - var_189_5) / var_189_6

				if arg_186_1.var_.characterEffect10104ui_story and not isNil(var_189_4) then
					local var_189_8 = Mathf.Lerp(0, 0.5, var_189_7)

					arg_186_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_186_1.var_.characterEffect10104ui_story.fillRatio = var_189_8
				end
			end

			if arg_186_1.time_ >= var_189_5 + var_189_6 and arg_186_1.time_ < var_189_5 + var_189_6 + arg_189_0 and not isNil(var_189_4) and arg_186_1.var_.characterEffect10104ui_story then
				local var_189_9 = 0.5

				arg_186_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_186_1.var_.characterEffect10104ui_story.fillRatio = var_189_9
			end

			local var_189_10 = 0

			if var_189_10 < arg_186_1.time_ and arg_186_1.time_ <= var_189_10 + arg_189_0 then
				arg_186_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_189_11 = 0

			if var_189_11 < arg_186_1.time_ and arg_186_1.time_ <= var_189_11 + arg_189_0 then
				arg_186_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_189_12 = 0
			local var_189_13 = 0.175

			if var_189_12 < arg_186_1.time_ and arg_186_1.time_ <= var_189_12 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_14 = arg_186_1:FormatText(StoryNameCfg[668].name)

				arg_186_1.leftNameTxt_.text = var_189_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_15 = arg_186_1:GetWordFromCfg(322061045)
				local var_189_16 = arg_186_1:FormatText(var_189_15.content)

				arg_186_1.text_.text = var_189_16

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_17 = 7
				local var_189_18 = utf8.len(var_189_16)
				local var_189_19 = var_189_17 <= 0 and var_189_13 or var_189_13 * (var_189_18 / var_189_17)

				if var_189_19 > 0 and var_189_13 < var_189_19 then
					arg_186_1.talkMaxDuration = var_189_19

					if var_189_19 + var_189_12 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_19 + var_189_12
					end
				end

				arg_186_1.text_.text = var_189_16
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061045", "story_v_out_322061.awb") ~= 0 then
					local var_189_20 = manager.audio:GetVoiceLength("story_v_out_322061", "322061045", "story_v_out_322061.awb") / 1000

					if var_189_20 + var_189_12 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_20 + var_189_12
					end

					if var_189_15.prefab_name ~= "" and arg_186_1.actors_[var_189_15.prefab_name] ~= nil then
						local var_189_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_15.prefab_name].transform, "story_v_out_322061", "322061045", "story_v_out_322061.awb")

						arg_186_1:RecordAudio("322061045", var_189_21)
						arg_186_1:RecordAudio("322061045", var_189_21)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_322061", "322061045", "story_v_out_322061.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_322061", "322061045", "story_v_out_322061.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_22 = math.max(var_189_13, arg_186_1.talkMaxDuration)

			if var_189_12 <= arg_186_1.time_ and arg_186_1.time_ < var_189_12 + var_189_22 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_12) / var_189_22

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_12 + var_189_22 and arg_186_1.time_ < var_189_12 + var_189_22 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play322061046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 322061046
		arg_190_1.duration_ = 5.8

		local var_190_0 = {
			zh = 4.3,
			ja = 5.8
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
			arg_190_1.auto_ = false
		end

		function arg_190_1.playNext_(arg_192_0)
			arg_190_1.onStoryFinished_()
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_193_2 = 0
			local var_193_3 = 0.475

			if var_193_2 < arg_190_1.time_ and arg_190_1.time_ <= var_193_2 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_4 = arg_190_1:FormatText(StoryNameCfg[668].name)

				arg_190_1.leftNameTxt_.text = var_193_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_5 = arg_190_1:GetWordFromCfg(322061046)
				local var_193_6 = arg_190_1:FormatText(var_193_5.content)

				arg_190_1.text_.text = var_193_6

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_7 = 19
				local var_193_8 = utf8.len(var_193_6)
				local var_193_9 = var_193_7 <= 0 and var_193_3 or var_193_3 * (var_193_8 / var_193_7)

				if var_193_9 > 0 and var_193_3 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_2
					end
				end

				arg_190_1.text_.text = var_193_6
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322061", "322061046", "story_v_out_322061.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_out_322061", "322061046", "story_v_out_322061.awb") / 1000

					if var_193_10 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_2
					end

					if var_193_5.prefab_name ~= "" and arg_190_1.actors_[var_193_5.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_5.prefab_name].transform, "story_v_out_322061", "322061046", "story_v_out_322061.awb")

						arg_190_1:RecordAudio("322061046", var_193_11)
						arg_190_1:RecordAudio("322061046", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_322061", "322061046", "story_v_out_322061.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_322061", "322061046", "story_v_out_322061.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_12 = math.max(var_193_3, arg_190_1.talkMaxDuration)

			if var_193_2 <= arg_190_1.time_ and arg_190_1.time_ < var_193_2 + var_193_12 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_2) / var_193_12

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_2 + var_193_12 and arg_190_1.time_ < var_193_2 + var_193_12 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST61a",
		"TextureConfig/Background/L15h"
	},
	voices = {
		"story_v_out_322061.awb"
	}
}
