return {
	Play1106606001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1106606001
		arg_1_1.duration_ = 6.77

		local var_1_0 = {
			zh = 6,
			ja = 6.766
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
				arg_1_0:Play1106606002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST10"

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
				local var_4_5 = arg_1_1.bgs_.ST10

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
					if iter_4_0 ~= "ST10" then
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

			local var_4_22 = "1066ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1066ui_story"].transform
			local var_4_28 = 2

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1066ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -0.77, -6.1)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1066ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["1066ui_story"]
			local var_4_37 = 2

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1066ui_story == nil then
				arg_1_1.var_.characterEffect1066ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect1066ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1066ui_story then
				arg_1_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_4_40 = 2

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_4_41 = 2

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_42 = 0
			local var_4_43 = 0.533333333333333

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

			local var_4_48 = 0.633333333333333
			local var_4_49 = 1

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

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

			local var_4_54 = 2
			local var_4_55 = 0.4

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

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[32].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(1106606001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 16
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606001", "story_v_side_new_1106606.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606001", "story_v_side_new_1106606.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_side_new_1106606", "1106606001", "story_v_side_new_1106606.awb")

						arg_1_1:RecordAudio("1106606001", var_4_64)
						arg_1_1:RecordAudio("1106606001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606001", "story_v_side_new_1106606.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606001", "story_v_side_new_1106606.awb")
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
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play1106606002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1106606002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1106606003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1066ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1066ui_story == nil then
				arg_9_1.var_.characterEffect1066ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect1066ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1066ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1066ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1066ui_story.fillRatio = var_12_5
			end

			local var_12_6 = 0
			local var_12_7 = 1.2

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_8 = arg_9_1:GetWordFromCfg(1106606002)
				local var_12_9 = arg_9_1:FormatText(var_12_8.content)

				arg_9_1.text_.text = var_12_9

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_10 = 48
				local var_12_11 = utf8.len(var_12_9)
				local var_12_12 = var_12_10 <= 0 and var_12_7 or var_12_7 * (var_12_11 / var_12_10)

				if var_12_12 > 0 and var_12_7 < var_12_12 then
					arg_9_1.talkMaxDuration = var_12_12

					if var_12_12 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_12 + var_12_6
					end
				end

				arg_9_1.text_.text = var_12_9
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_13 = math.max(var_12_7, arg_9_1.talkMaxDuration)

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_13 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_6) / var_12_13

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_6 + var_12_13 and arg_9_1.time_ < var_12_6 + var_12_13 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1106606003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1106606003
		arg_13_1.duration_ = 1.9

		local var_13_0 = {
			zh = 1.9,
			ja = 1.566
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
				arg_13_0:Play1106606004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.15

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[138].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(1106606003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 6
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606003", "story_v_side_new_1106606.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606003", "story_v_side_new_1106606.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_side_new_1106606", "1106606003", "story_v_side_new_1106606.awb")

						arg_13_1:RecordAudio("1106606003", var_16_9)
						arg_13_1:RecordAudio("1106606003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606003", "story_v_side_new_1106606.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606003", "story_v_side_new_1106606.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1106606004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1106606004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1106606005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.05

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(1106606004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 42
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1106606005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1106606005
		arg_21_1.duration_ = 6.6

		local var_21_0 = {
			zh = 4.733,
			ja = 6.6
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
				arg_21_0:Play1106606006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1066ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1066ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, -0.77, -6.1)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1066ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["1066ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1066ui_story == nil then
				arg_21_1.var_.characterEffect1066ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect1066ui_story and not isNil(var_24_9) then
					arg_21_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1066ui_story then
				arg_21_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			local var_24_14 = 0

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_15 = 0
			local var_24_16 = 0.625

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[32].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(1106606005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 25
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606005", "story_v_side_new_1106606.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606005", "story_v_side_new_1106606.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_side_new_1106606", "1106606005", "story_v_side_new_1106606.awb")

						arg_21_1:RecordAudio("1106606005", var_24_24)
						arg_21_1:RecordAudio("1106606005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606005", "story_v_side_new_1106606.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606005", "story_v_side_new_1106606.awb")
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
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play1106606006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1106606006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1106606007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1066ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1066ui_story == nil then
				arg_25_1.var_.characterEffect1066ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1066ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1066ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1066ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1066ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 1.85

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_9 = arg_25_1:GetWordFromCfg(1106606006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 74
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
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1106606007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1106606007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1106606008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.4

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(1106606007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 56
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
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1106606008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1106606008
		arg_33_1.duration_ = 3.1

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1106606009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1066ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1066ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, -0.77, -6.1)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1066ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1066ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1066ui_story == nil then
				arg_33_1.var_.characterEffect1066ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect1066ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1066ui_story then
				arg_33_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action423")
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_15 = 0
			local var_36_16 = 0.275

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[32].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(1106606008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 11
				local var_36_21 = utf8.len(var_36_19)
				local var_36_22 = var_36_20 <= 0 and var_36_16 or var_36_16 * (var_36_21 / var_36_20)

				if var_36_22 > 0 and var_36_16 < var_36_22 then
					arg_33_1.talkMaxDuration = var_36_22

					if var_36_22 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_15
					end
				end

				arg_33_1.text_.text = var_36_19
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606008", "story_v_side_new_1106606.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606008", "story_v_side_new_1106606.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_side_new_1106606", "1106606008", "story_v_side_new_1106606.awb")

						arg_33_1:RecordAudio("1106606008", var_36_24)
						arg_33_1:RecordAudio("1106606008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606008", "story_v_side_new_1106606.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606008", "story_v_side_new_1106606.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_25 = math.max(var_36_16, arg_33_1.talkMaxDuration)

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_25 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_15) / var_36_25

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_15 + var_36_25 and arg_33_1.time_ < var_36_15 + var_36_25 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play1106606009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1106606009
		arg_37_1.duration_ = 2.67

		local var_37_0 = {
			zh = 2.666,
			ja = 1.766
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
				arg_37_0:Play1106606010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1066ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1066ui_story == nil then
				arg_37_1.var_.characterEffect1066ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1066ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1066ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1066ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1066ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 0.15

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[138].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_9 = arg_37_1:GetWordFromCfg(1106606009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 6
				local var_40_12 = utf8.len(var_40_10)
				local var_40_13 = var_40_11 <= 0 and var_40_7 or var_40_7 * (var_40_12 / var_40_11)

				if var_40_13 > 0 and var_40_7 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606009", "story_v_side_new_1106606.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606009", "story_v_side_new_1106606.awb") / 1000

					if var_40_14 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_6
					end

					if var_40_9.prefab_name ~= "" and arg_37_1.actors_[var_40_9.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_9.prefab_name].transform, "story_v_side_new_1106606", "1106606009", "story_v_side_new_1106606.awb")

						arg_37_1:RecordAudio("1106606009", var_40_15)
						arg_37_1:RecordAudio("1106606009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606009", "story_v_side_new_1106606.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606009", "story_v_side_new_1106606.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_16 and arg_37_1.time_ < var_40_6 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1106606010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1106606010
		arg_41_1.duration_ = 3.1

		local var_41_0 = {
			zh = 3.1,
			ja = 2.333
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
				arg_41_0:Play1106606011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1066ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1066ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(0, -0.77, -6.1)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1066ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["1066ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1066ui_story == nil then
				arg_41_1.var_.characterEffect1066ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect1066ui_story and not isNil(var_44_9) then
					arg_41_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1066ui_story then
				arg_41_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_44_13 = 0

			if var_44_13 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_44_14 = 0
			local var_44_15 = 0.375

			if var_44_14 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_16 = arg_41_1:FormatText(StoryNameCfg[32].name)

				arg_41_1.leftNameTxt_.text = var_44_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_17 = arg_41_1:GetWordFromCfg(1106606010)
				local var_44_18 = arg_41_1:FormatText(var_44_17.content)

				arg_41_1.text_.text = var_44_18

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_19 = 15
				local var_44_20 = utf8.len(var_44_18)
				local var_44_21 = var_44_19 <= 0 and var_44_15 or var_44_15 * (var_44_20 / var_44_19)

				if var_44_21 > 0 and var_44_15 < var_44_21 then
					arg_41_1.talkMaxDuration = var_44_21

					if var_44_21 + var_44_14 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_21 + var_44_14
					end
				end

				arg_41_1.text_.text = var_44_18
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606010", "story_v_side_new_1106606.awb") ~= 0 then
					local var_44_22 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606010", "story_v_side_new_1106606.awb") / 1000

					if var_44_22 + var_44_14 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_22 + var_44_14
					end

					if var_44_17.prefab_name ~= "" and arg_41_1.actors_[var_44_17.prefab_name] ~= nil then
						local var_44_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_17.prefab_name].transform, "story_v_side_new_1106606", "1106606010", "story_v_side_new_1106606.awb")

						arg_41_1:RecordAudio("1106606010", var_44_23)
						arg_41_1:RecordAudio("1106606010", var_44_23)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606010", "story_v_side_new_1106606.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606010", "story_v_side_new_1106606.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_24 = math.max(var_44_15, arg_41_1.talkMaxDuration)

			if var_44_14 <= arg_41_1.time_ and arg_41_1.time_ < var_44_14 + var_44_24 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_14) / var_44_24

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_14 + var_44_24 and arg_41_1.time_ < var_44_14 + var_44_24 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play1106606011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1106606011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1106606012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1066ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1066ui_story == nil then
				arg_45_1.var_.characterEffect1066ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1066ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1066ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1066ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1066ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 0.3

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[7].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_9 = arg_45_1:GetWordFromCfg(1106606011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 12
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
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1106606012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1106606012
		arg_49_1.duration_ = 5.17

		local var_49_0 = {
			zh = 5.166,
			ja = 4.5
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
				arg_49_0:Play1106606013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1066ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1066ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0, -0.77, -6.1)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1066ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["1066ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1066ui_story == nil then
				arg_49_1.var_.characterEffect1066ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect1066ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1066ui_story then
				arg_49_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_52_14 = 0
			local var_52_15 = 0.575

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_16 = arg_49_1:FormatText(StoryNameCfg[32].name)

				arg_49_1.leftNameTxt_.text = var_52_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_17 = arg_49_1:GetWordFromCfg(1106606012)
				local var_52_18 = arg_49_1:FormatText(var_52_17.content)

				arg_49_1.text_.text = var_52_18

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_19 = 23
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606012", "story_v_side_new_1106606.awb") ~= 0 then
					local var_52_22 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606012", "story_v_side_new_1106606.awb") / 1000

					if var_52_22 + var_52_14 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_14
					end

					if var_52_17.prefab_name ~= "" and arg_49_1.actors_[var_52_17.prefab_name] ~= nil then
						local var_52_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_17.prefab_name].transform, "story_v_side_new_1106606", "1106606012", "story_v_side_new_1106606.awb")

						arg_49_1:RecordAudio("1106606012", var_52_23)
						arg_49_1:RecordAudio("1106606012", var_52_23)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606012", "story_v_side_new_1106606.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606012", "story_v_side_new_1106606.awb")
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
				actorName = "1066ui_story",
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
	Play1106606013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1106606013
		arg_53_1.duration_ = 1

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"

			SetActive(arg_53_1.choicesGo_, true)

			for iter_54_0, iter_54_1 in ipairs(arg_53_1.choices_) do
				local var_54_0 = iter_54_0 <= 2

				SetActive(iter_54_1.go, var_54_0)
			end

			arg_53_1.choices_[1].txt.text = arg_53_1:FormatText(StoryChoiceCfg[556].name)
			arg_53_1.choices_[2].txt.text = arg_53_1:FormatText(StoryChoiceCfg[557].name)
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1106606014(arg_53_1)
			end

			if arg_55_0 == 2 then
				arg_53_0:Play1106606015(arg_53_1)
			end

			arg_53_1:RecordChoiceLog(1106606013, 556, 557)
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1066ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1066ui_story == nil then
				arg_53_1.var_.characterEffect1066ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1066ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1066ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1066ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1066ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			local var_56_7 = 0.5

			if arg_53_1.time_ >= var_56_6 + var_56_7 and arg_53_1.time_ < var_56_6 + var_56_7 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1106606014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1106606014
		arg_57_1.duration_ = 5.43

		local var_57_0 = {
			zh = 2.999999999999,
			ja = 5.433
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
				arg_57_0:Play1106606016(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1066ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1066ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0, -0.77, -6.1)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1066ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["1066ui_story"]
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1066ui_story == nil then
				arg_57_1.var_.characterEffect1066ui_story = var_60_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.200000002980232

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 and not isNil(var_60_9) then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.characterEffect1066ui_story and not isNil(var_60_9) then
					arg_57_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1066ui_story then
				arg_57_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action436")
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_60_15 = 0

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			local var_60_16 = 3

			if arg_57_1.time_ >= var_60_15 + var_60_16 and arg_57_1.time_ < var_60_15 + var_60_16 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			local var_60_17 = 0
			local var_60_18 = 0.2

			if var_60_17 < arg_57_1.time_ and arg_57_1.time_ <= var_60_17 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_19 = arg_57_1:FormatText(StoryNameCfg[32].name)

				arg_57_1.leftNameTxt_.text = var_60_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_20 = arg_57_1:GetWordFromCfg(1106606014)
				local var_60_21 = arg_57_1:FormatText(var_60_20.content)

				arg_57_1.text_.text = var_60_21

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_22 = 8
				local var_60_23 = utf8.len(var_60_21)
				local var_60_24 = var_60_22 <= 0 and var_60_18 or var_60_18 * (var_60_23 / var_60_22)

				if var_60_24 > 0 and var_60_18 < var_60_24 then
					arg_57_1.talkMaxDuration = var_60_24

					if var_60_24 + var_60_17 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_24 + var_60_17
					end
				end

				arg_57_1.text_.text = var_60_21
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606014", "story_v_side_new_1106606.awb") ~= 0 then
					local var_60_25 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606014", "story_v_side_new_1106606.awb") / 1000

					if var_60_25 + var_60_17 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_25 + var_60_17
					end

					if var_60_20.prefab_name ~= "" and arg_57_1.actors_[var_60_20.prefab_name] ~= nil then
						local var_60_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_20.prefab_name].transform, "story_v_side_new_1106606", "1106606014", "story_v_side_new_1106606.awb")

						arg_57_1:RecordAudio("1106606014", var_60_26)
						arg_57_1:RecordAudio("1106606014", var_60_26)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606014", "story_v_side_new_1106606.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606014", "story_v_side_new_1106606.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_27 = math.max(var_60_18, arg_57_1.talkMaxDuration)

			if var_60_17 <= arg_57_1.time_ and arg_57_1.time_ < var_60_17 + var_60_27 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_17) / var_60_27

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_17 + var_60_27 and arg_57_1.time_ < var_60_17 + var_60_27 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play1106606016 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1106606016
		arg_61_1.duration_ = 9.3

		local var_61_0 = {
			zh = 3.066,
			ja = 9.3
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
				arg_61_0:Play1106606017(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1066ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1066ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, -0.77, -6.1)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1066ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["1066ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1066ui_story == nil then
				arg_61_1.var_.characterEffect1066ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect1066ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1066ui_story then
				arg_61_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_64_13 = 0

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action6_2")
			end

			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_15 = 0
			local var_64_16 = 0.275

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_17 = arg_61_1:FormatText(StoryNameCfg[32].name)

				arg_61_1.leftNameTxt_.text = var_64_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_18 = arg_61_1:GetWordFromCfg(1106606016)
				local var_64_19 = arg_61_1:FormatText(var_64_18.content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 11
				local var_64_21 = utf8.len(var_64_19)
				local var_64_22 = var_64_20 <= 0 and var_64_16 or var_64_16 * (var_64_21 / var_64_20)

				if var_64_22 > 0 and var_64_16 < var_64_22 then
					arg_61_1.talkMaxDuration = var_64_22

					if var_64_22 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_22 + var_64_15
					end
				end

				arg_61_1.text_.text = var_64_19
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606016", "story_v_side_new_1106606.awb") ~= 0 then
					local var_64_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606016", "story_v_side_new_1106606.awb") / 1000

					if var_64_23 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_15
					end

					if var_64_18.prefab_name ~= "" and arg_61_1.actors_[var_64_18.prefab_name] ~= nil then
						local var_64_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_18.prefab_name].transform, "story_v_side_new_1106606", "1106606016", "story_v_side_new_1106606.awb")

						arg_61_1:RecordAudio("1106606016", var_64_24)
						arg_61_1:RecordAudio("1106606016", var_64_24)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606016", "story_v_side_new_1106606.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606016", "story_v_side_new_1106606.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_25 = math.max(var_64_16, arg_61_1.talkMaxDuration)

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_25 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_15) / var_64_25

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_15 + var_64_25 and arg_61_1.time_ < var_64_15 + var_64_25 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play1106606017 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1106606017
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1106606018(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1066ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1066ui_story == nil then
				arg_65_1.var_.characterEffect1066ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1066ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1066ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1066ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1066ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 1.55

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_9 = arg_65_1:GetWordFromCfg(1106606017)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 62
				local var_68_12 = utf8.len(var_68_10)
				local var_68_13 = var_68_11 <= 0 and var_68_7 or var_68_7 * (var_68_12 / var_68_11)

				if var_68_13 > 0 and var_68_7 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1106606018 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1106606018
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1106606019(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.225

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[7].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(1106606018)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 49
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
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_8 and arg_69_1.time_ < var_72_0 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1106606019 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1106606019
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1106606020(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_76_1 = 0
			local var_76_2 = 0.575

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_3 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_4 = arg_73_1:GetWordFromCfg(1106606019)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 23
				local var_76_7 = utf8.len(var_76_5)
				local var_76_8 = var_76_6 <= 0 and var_76_2 or var_76_2 * (var_76_7 / var_76_6)

				if var_76_8 > 0 and var_76_2 < var_76_8 then
					arg_73_1.talkMaxDuration = var_76_8

					if var_76_8 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_9 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_9 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_9

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_9 and arg_73_1.time_ < var_76_1 + var_76_9 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1106606020 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1106606020
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1106606021(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.725

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(1106606020)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 29
				local var_80_5 = utf8.len(var_80_3)
				local var_80_6 = var_80_4 <= 0 and var_80_1 or var_80_1 * (var_80_5 / var_80_4)

				if var_80_6 > 0 and var_80_1 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_7 and arg_77_1.time_ < var_80_0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1106606021 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1106606021
		arg_81_1.duration_ = 3.2

		local var_81_0 = {
			zh = 2.566,
			ja = 3.2
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
				arg_81_0:Play1106606022(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1066ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1066ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0, -0.77, -6.1)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1066ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["1066ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1066ui_story == nil then
				arg_81_1.var_.characterEffect1066ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect1066ui_story and not isNil(var_84_9) then
					arg_81_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1066ui_story then
				arg_81_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 then
				arg_81_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			local var_84_14 = 0

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_15 = 0
			local var_84_16 = 0.2

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_17 = arg_81_1:FormatText(StoryNameCfg[32].name)

				arg_81_1.leftNameTxt_.text = var_84_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_18 = arg_81_1:GetWordFromCfg(1106606021)
				local var_84_19 = arg_81_1:FormatText(var_84_18.content)

				arg_81_1.text_.text = var_84_19

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_20 = 8
				local var_84_21 = utf8.len(var_84_19)
				local var_84_22 = var_84_20 <= 0 and var_84_16 or var_84_16 * (var_84_21 / var_84_20)

				if var_84_22 > 0 and var_84_16 < var_84_22 then
					arg_81_1.talkMaxDuration = var_84_22

					if var_84_22 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_22 + var_84_15
					end
				end

				arg_81_1.text_.text = var_84_19
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606021", "story_v_side_new_1106606.awb") ~= 0 then
					local var_84_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606021", "story_v_side_new_1106606.awb") / 1000

					if var_84_23 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_23 + var_84_15
					end

					if var_84_18.prefab_name ~= "" and arg_81_1.actors_[var_84_18.prefab_name] ~= nil then
						local var_84_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_18.prefab_name].transform, "story_v_side_new_1106606", "1106606021", "story_v_side_new_1106606.awb")

						arg_81_1:RecordAudio("1106606021", var_84_24)
						arg_81_1:RecordAudio("1106606021", var_84_24)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606021", "story_v_side_new_1106606.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606021", "story_v_side_new_1106606.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_25 = math.max(var_84_16, arg_81_1.talkMaxDuration)

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_25 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_15) / var_84_25

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_15 + var_84_25 and arg_81_1.time_ < var_84_15 + var_84_25 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play1106606022 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1106606022
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1106606023(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1066ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1066ui_story == nil then
				arg_85_1.var_.characterEffect1066ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1066ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1066ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1066ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1066ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.075

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

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(1106606022)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 3
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
	Play1106606023 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1106606023
		arg_89_1.duration_ = 16.27

		local var_89_0 = {
			zh = 2.8,
			ja = 16.266
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
				arg_89_0:Play1106606024(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1066ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1066ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, -0.77, -6.1)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1066ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["1066ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1066ui_story == nil then
				arg_89_1.var_.characterEffect1066ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect1066ui_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1066ui_story then
				arg_89_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_92_13 = 0

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_92_14 = 0
			local var_92_15 = 0.325

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_16 = arg_89_1:FormatText(StoryNameCfg[32].name)

				arg_89_1.leftNameTxt_.text = var_92_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_17 = arg_89_1:GetWordFromCfg(1106606023)
				local var_92_18 = arg_89_1:FormatText(var_92_17.content)

				arg_89_1.text_.text = var_92_18

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_19 = 13
				local var_92_20 = utf8.len(var_92_18)
				local var_92_21 = var_92_19 <= 0 and var_92_15 or var_92_15 * (var_92_20 / var_92_19)

				if var_92_21 > 0 and var_92_15 < var_92_21 then
					arg_89_1.talkMaxDuration = var_92_21

					if var_92_21 + var_92_14 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_21 + var_92_14
					end
				end

				arg_89_1.text_.text = var_92_18
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606023", "story_v_side_new_1106606.awb") ~= 0 then
					local var_92_22 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606023", "story_v_side_new_1106606.awb") / 1000

					if var_92_22 + var_92_14 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_14
					end

					if var_92_17.prefab_name ~= "" and arg_89_1.actors_[var_92_17.prefab_name] ~= nil then
						local var_92_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_17.prefab_name].transform, "story_v_side_new_1106606", "1106606023", "story_v_side_new_1106606.awb")

						arg_89_1:RecordAudio("1106606023", var_92_23)
						arg_89_1:RecordAudio("1106606023", var_92_23)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606023", "story_v_side_new_1106606.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606023", "story_v_side_new_1106606.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_24 = math.max(var_92_15, arg_89_1.talkMaxDuration)

			if var_92_14 <= arg_89_1.time_ and arg_89_1.time_ < var_92_14 + var_92_24 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_14) / var_92_24

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_14 + var_92_24 and arg_89_1.time_ < var_92_14 + var_92_24 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play1106606024 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1106606024
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1106606025(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1066ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1066ui_story == nil then
				arg_93_1.var_.characterEffect1066ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1066ui_story and not isNil(var_96_0) then
					local var_96_4 = Mathf.Lerp(0, 0.5, var_96_3)

					arg_93_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1066ui_story.fillRatio = var_96_4
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1066ui_story then
				local var_96_5 = 0.5

				arg_93_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1066ui_story.fillRatio = var_96_5
			end

			local var_96_6 = 0
			local var_96_7 = 0.275

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_8 = arg_93_1:FormatText(StoryNameCfg[7].name)

				arg_93_1.leftNameTxt_.text = var_96_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_9 = arg_93_1:GetWordFromCfg(1106606024)
				local var_96_10 = arg_93_1:FormatText(var_96_9.content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 11
				local var_96_12 = utf8.len(var_96_10)
				local var_96_13 = var_96_11 <= 0 and var_96_7 or var_96_7 * (var_96_12 / var_96_11)

				if var_96_13 > 0 and var_96_7 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_10
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_14 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_14 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_14

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_14 and arg_93_1.time_ < var_96_6 + var_96_14 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1106606025 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1106606025
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1106606026(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 1.15

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

				local var_100_2 = arg_97_1:GetWordFromCfg(1106606025)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 46
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
	Play1106606026 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1106606026
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1106606027(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.275

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[7].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(1106606026)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 11
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_1 or var_104_1 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_1 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_8 and arg_101_1.time_ < var_104_0 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1106606027 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1106606027
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1106606028(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.4

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[7].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:GetWordFromCfg(1106606027)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 16
				local var_108_6 = utf8.len(var_108_4)
				local var_108_7 = var_108_5 <= 0 and var_108_1 or var_108_1 * (var_108_6 / var_108_5)

				if var_108_7 > 0 and var_108_1 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_8 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_8 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_8

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_8 and arg_105_1.time_ < var_108_0 + var_108_8 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1106606028 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1106606028
		arg_109_1.duration_ = 7.93

		local var_109_0 = {
			zh = 6.3,
			ja = 7.933
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1106606029(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1066ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1066ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, -0.77, -6.1)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1066ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["1066ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1066ui_story == nil then
				arg_109_1.var_.characterEffect1066ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect1066ui_story and not isNil(var_112_9) then
					arg_109_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1066ui_story then
				arg_109_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_112_14 = 0
			local var_112_15 = 0.45

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_16 = arg_109_1:FormatText(StoryNameCfg[32].name)

				arg_109_1.leftNameTxt_.text = var_112_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_17 = arg_109_1:GetWordFromCfg(1106606028)
				local var_112_18 = arg_109_1:FormatText(var_112_17.content)

				arg_109_1.text_.text = var_112_18

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_19 = 18
				local var_112_20 = utf8.len(var_112_18)
				local var_112_21 = var_112_19 <= 0 and var_112_15 or var_112_15 * (var_112_20 / var_112_19)

				if var_112_21 > 0 and var_112_15 < var_112_21 then
					arg_109_1.talkMaxDuration = var_112_21

					if var_112_21 + var_112_14 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_21 + var_112_14
					end
				end

				arg_109_1.text_.text = var_112_18
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606028", "story_v_side_new_1106606.awb") ~= 0 then
					local var_112_22 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606028", "story_v_side_new_1106606.awb") / 1000

					if var_112_22 + var_112_14 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_22 + var_112_14
					end

					if var_112_17.prefab_name ~= "" and arg_109_1.actors_[var_112_17.prefab_name] ~= nil then
						local var_112_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_17.prefab_name].transform, "story_v_side_new_1106606", "1106606028", "story_v_side_new_1106606.awb")

						arg_109_1:RecordAudio("1106606028", var_112_23)
						arg_109_1:RecordAudio("1106606028", var_112_23)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606028", "story_v_side_new_1106606.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606028", "story_v_side_new_1106606.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_24 = math.max(var_112_15, arg_109_1.talkMaxDuration)

			if var_112_14 <= arg_109_1.time_ and arg_109_1.time_ < var_112_14 + var_112_24 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_14) / var_112_24

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_14 + var_112_24 and arg_109_1.time_ < var_112_14 + var_112_24 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play1106606029 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1106606029
		arg_113_1.duration_ = 7.13

		local var_113_0 = {
			zh = 7.133,
			ja = 5.833
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1106606030(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1066ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1066ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0, -0.77, -6.1)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1066ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["1066ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1066ui_story == nil then
				arg_113_1.var_.characterEffect1066ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 and not isNil(var_116_9) then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect1066ui_story and not isNil(var_116_9) then
					arg_113_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1066ui_story then
				arg_113_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_116_13 = 0

			if var_116_13 < arg_113_1.time_ and arg_113_1.time_ <= var_116_13 + arg_116_0 then
				arg_113_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			local var_116_14 = 0

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_116_15 = 0
			local var_116_16 = 0.8

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_17 = arg_113_1:FormatText(StoryNameCfg[32].name)

				arg_113_1.leftNameTxt_.text = var_116_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_18 = arg_113_1:GetWordFromCfg(1106606029)
				local var_116_19 = arg_113_1:FormatText(var_116_18.content)

				arg_113_1.text_.text = var_116_19

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_20 = 32
				local var_116_21 = utf8.len(var_116_19)
				local var_116_22 = var_116_20 <= 0 and var_116_16 or var_116_16 * (var_116_21 / var_116_20)

				if var_116_22 > 0 and var_116_16 < var_116_22 then
					arg_113_1.talkMaxDuration = var_116_22

					if var_116_22 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_22 + var_116_15
					end
				end

				arg_113_1.text_.text = var_116_19
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606029", "story_v_side_new_1106606.awb") ~= 0 then
					local var_116_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606029", "story_v_side_new_1106606.awb") / 1000

					if var_116_23 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_23 + var_116_15
					end

					if var_116_18.prefab_name ~= "" and arg_113_1.actors_[var_116_18.prefab_name] ~= nil then
						local var_116_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_18.prefab_name].transform, "story_v_side_new_1106606", "1106606029", "story_v_side_new_1106606.awb")

						arg_113_1:RecordAudio("1106606029", var_116_24)
						arg_113_1:RecordAudio("1106606029", var_116_24)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606029", "story_v_side_new_1106606.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606029", "story_v_side_new_1106606.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_25 = math.max(var_116_16, arg_113_1.talkMaxDuration)

			if var_116_15 <= arg_113_1.time_ and arg_113_1.time_ < var_116_15 + var_116_25 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_15) / var_116_25

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_15 + var_116_25 and arg_113_1.time_ < var_116_15 + var_116_25 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play1106606030 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1106606030
		arg_117_1.duration_ = 9

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1106606031(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 2

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				local var_120_1 = manager.ui.mainCamera.transform.localPosition
				local var_120_2 = Vector3.New(0, 0, 10) + Vector3.New(var_120_1.x, var_120_1.y, 0)
				local var_120_3 = arg_117_1.bgs_.ST10

				var_120_3.transform.localPosition = var_120_2
				var_120_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_4 = var_120_3:GetComponent("SpriteRenderer")

				if var_120_4 and var_120_4.sprite then
					local var_120_5 = (var_120_3.transform.localPosition - var_120_1).z
					local var_120_6 = manager.ui.mainCameraCom_
					local var_120_7 = 2 * var_120_5 * Mathf.Tan(var_120_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_120_8 = var_120_7 * var_120_6.aspect
					local var_120_9 = var_120_4.sprite.bounds.size.x
					local var_120_10 = var_120_4.sprite.bounds.size.y
					local var_120_11 = var_120_8 / var_120_9
					local var_120_12 = var_120_7 / var_120_10
					local var_120_13 = var_120_12 < var_120_11 and var_120_11 or var_120_12

					var_120_3.transform.localScale = Vector3.New(var_120_13, var_120_13, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "ST10" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_14 = 0

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_15 = 2

			if var_120_14 <= arg_117_1.time_ and arg_117_1.time_ < var_120_14 + var_120_15 then
				local var_120_16 = (arg_117_1.time_ - var_120_14) / var_120_15
				local var_120_17 = Color.New(0, 0, 0)

				var_120_17.a = Mathf.Lerp(0, 1, var_120_16)
				arg_117_1.mask_.color = var_120_17
			end

			if arg_117_1.time_ >= var_120_14 + var_120_15 and arg_117_1.time_ < var_120_14 + var_120_15 + arg_120_0 then
				local var_120_18 = Color.New(0, 0, 0)

				var_120_18.a = 1
				arg_117_1.mask_.color = var_120_18
			end

			local var_120_19 = 2

			if var_120_19 < arg_117_1.time_ and arg_117_1.time_ <= var_120_19 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_20 = 2

			if var_120_19 <= arg_117_1.time_ and arg_117_1.time_ < var_120_19 + var_120_20 then
				local var_120_21 = (arg_117_1.time_ - var_120_19) / var_120_20
				local var_120_22 = Color.New(0, 0, 0)

				var_120_22.a = Mathf.Lerp(1, 0, var_120_21)
				arg_117_1.mask_.color = var_120_22
			end

			if arg_117_1.time_ >= var_120_19 + var_120_20 and arg_117_1.time_ < var_120_19 + var_120_20 + arg_120_0 then
				local var_120_23 = Color.New(0, 0, 0)
				local var_120_24 = 0

				arg_117_1.mask_.enabled = false
				var_120_23.a = var_120_24
				arg_117_1.mask_.color = var_120_23
			end

			local var_120_25 = arg_117_1.actors_["1066ui_story"].transform
			local var_120_26 = 2

			if var_120_26 < arg_117_1.time_ and arg_117_1.time_ <= var_120_26 + arg_120_0 then
				arg_117_1.var_.moveOldPos1066ui_story = var_120_25.localPosition
			end

			local var_120_27 = 0.001

			if var_120_26 <= arg_117_1.time_ and arg_117_1.time_ < var_120_26 + var_120_27 then
				local var_120_28 = (arg_117_1.time_ - var_120_26) / var_120_27
				local var_120_29 = Vector3.New(0, 100, 0)

				var_120_25.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1066ui_story, var_120_29, var_120_28)

				local var_120_30 = manager.ui.mainCamera.transform.position - var_120_25.position

				var_120_25.forward = Vector3.New(var_120_30.x, var_120_30.y, var_120_30.z)

				local var_120_31 = var_120_25.localEulerAngles

				var_120_31.z = 0
				var_120_31.x = 0
				var_120_25.localEulerAngles = var_120_31
			end

			if arg_117_1.time_ >= var_120_26 + var_120_27 and arg_117_1.time_ < var_120_26 + var_120_27 + arg_120_0 then
				var_120_25.localPosition = Vector3.New(0, 100, 0)

				local var_120_32 = manager.ui.mainCamera.transform.position - var_120_25.position

				var_120_25.forward = Vector3.New(var_120_32.x, var_120_32.y, var_120_32.z)

				local var_120_33 = var_120_25.localEulerAngles

				var_120_33.z = 0
				var_120_33.x = 0
				var_120_25.localEulerAngles = var_120_33
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_34 = 4
			local var_120_35 = 0.975

			if var_120_34 < arg_117_1.time_ and arg_117_1.time_ <= var_120_34 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_36 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_36:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_37 = arg_117_1:GetWordFromCfg(1106606030)
				local var_120_38 = arg_117_1:FormatText(var_120_37.content)

				arg_117_1.text_.text = var_120_38

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_39 = 39
				local var_120_40 = utf8.len(var_120_38)
				local var_120_41 = var_120_39 <= 0 and var_120_35 or var_120_35 * (var_120_40 / var_120_39)

				if var_120_41 > 0 and var_120_35 < var_120_41 then
					arg_117_1.talkMaxDuration = var_120_41
					var_120_34 = var_120_34 + 0.3

					if var_120_41 + var_120_34 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_41 + var_120_34
					end
				end

				arg_117_1.text_.text = var_120_38
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_42 = var_120_34 + 0.3
			local var_120_43 = math.max(var_120_35, arg_117_1.talkMaxDuration)

			if var_120_42 <= arg_117_1.time_ and arg_117_1.time_ < var_120_42 + var_120_43 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_42) / var_120_43

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_42 + var_120_43 and arg_117_1.time_ < var_120_42 + var_120_43 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play1106606031 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1106606031
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1106606032(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 1.7

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

				local var_126_2 = arg_123_1:GetWordFromCfg(1106606031)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 68
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
	Play1106606032 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1106606032
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1106606033(arg_127_1)
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

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[7].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(1106606032)
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
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_8 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_8 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_8

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_8 and arg_127_1.time_ < var_130_0 + var_130_8 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1106606033 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1106606033
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1106606034(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 1.125

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_2 = arg_131_1:GetWordFromCfg(1106606033)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 45
				local var_134_5 = utf8.len(var_134_3)
				local var_134_6 = var_134_4 <= 0 and var_134_1 or var_134_1 * (var_134_5 / var_134_4)

				if var_134_6 > 0 and var_134_1 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_7 and arg_131_1.time_ < var_134_0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play1106606034 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1106606034
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1106606035(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.675

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_2 = arg_135_1:GetWordFromCfg(1106606034)
				local var_138_3 = arg_135_1:FormatText(var_138_2.content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 27
				local var_138_5 = utf8.len(var_138_3)
				local var_138_6 = var_138_4 <= 0 and var_138_1 or var_138_1 * (var_138_5 / var_138_4)

				if var_138_6 > 0 and var_138_1 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_7 and arg_135_1.time_ < var_138_0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1106606035 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1106606035
		arg_139_1.duration_ = 2.23

		local var_139_0 = {
			zh = 2.233,
			ja = 1.999999999999
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
				arg_139_0:Play1106606036(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1066ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1066ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0, -0.77, -6.1)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1066ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["1066ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1066ui_story == nil then
				arg_139_1.var_.characterEffect1066ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect1066ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1066ui_story then
				arg_139_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_142_14 = 0
			local var_142_15 = 0.125

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_16 = arg_139_1:FormatText(StoryNameCfg[579].name)

				arg_139_1.leftNameTxt_.text = var_142_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_17 = arg_139_1:GetWordFromCfg(1106606035)
				local var_142_18 = arg_139_1:FormatText(var_142_17.content)

				arg_139_1.text_.text = var_142_18

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_19 = 5
				local var_142_20 = utf8.len(var_142_18)
				local var_142_21 = var_142_19 <= 0 and var_142_15 or var_142_15 * (var_142_20 / var_142_19)

				if var_142_21 > 0 and var_142_15 < var_142_21 then
					arg_139_1.talkMaxDuration = var_142_21

					if var_142_21 + var_142_14 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_21 + var_142_14
					end
				end

				arg_139_1.text_.text = var_142_18
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606035", "story_v_side_new_1106606.awb") ~= 0 then
					local var_142_22 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606035", "story_v_side_new_1106606.awb") / 1000

					if var_142_22 + var_142_14 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_22 + var_142_14
					end

					if var_142_17.prefab_name ~= "" and arg_139_1.actors_[var_142_17.prefab_name] ~= nil then
						local var_142_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_17.prefab_name].transform, "story_v_side_new_1106606", "1106606035", "story_v_side_new_1106606.awb")

						arg_139_1:RecordAudio("1106606035", var_142_23)
						arg_139_1:RecordAudio("1106606035", var_142_23)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606035", "story_v_side_new_1106606.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606035", "story_v_side_new_1106606.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_24 = math.max(var_142_15, arg_139_1.talkMaxDuration)

			if var_142_14 <= arg_139_1.time_ and arg_139_1.time_ < var_142_14 + var_142_24 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_14) / var_142_24

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_14 + var_142_24 and arg_139_1.time_ < var_142_14 + var_142_24 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play1106606036 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1106606036
		arg_143_1.duration_ = 4.3

		local var_143_0 = {
			zh = 3.8,
			ja = 4.3
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1106606037(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1066ui_story"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos1066ui_story = var_146_0.localPosition
			end

			local var_146_2 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2
				local var_146_4 = Vector3.New(0, -0.77, -6.1)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1066ui_story, var_146_4, var_146_3)

				local var_146_5 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_5.x, var_146_5.y, var_146_5.z)

				local var_146_6 = var_146_0.localEulerAngles

				var_146_6.z = 0
				var_146_6.x = 0
				var_146_0.localEulerAngles = var_146_6
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_146_7 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_7.x, var_146_7.y, var_146_7.z)

				local var_146_8 = var_146_0.localEulerAngles

				var_146_8.z = 0
				var_146_8.x = 0
				var_146_0.localEulerAngles = var_146_8
			end

			local var_146_9 = 0

			if var_146_9 < arg_143_1.time_ and arg_143_1.time_ <= var_146_9 + arg_146_0 then
				arg_143_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 then
				arg_143_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_11 = 0
			local var_146_12 = 0.45

			if var_146_11 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_13 = arg_143_1:FormatText(StoryNameCfg[32].name)

				arg_143_1.leftNameTxt_.text = var_146_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_14 = arg_143_1:GetWordFromCfg(1106606036)
				local var_146_15 = arg_143_1:FormatText(var_146_14.content)

				arg_143_1.text_.text = var_146_15

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_16 = 18
				local var_146_17 = utf8.len(var_146_15)
				local var_146_18 = var_146_16 <= 0 and var_146_12 or var_146_12 * (var_146_17 / var_146_16)

				if var_146_18 > 0 and var_146_12 < var_146_18 then
					arg_143_1.talkMaxDuration = var_146_18

					if var_146_18 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_18 + var_146_11
					end
				end

				arg_143_1.text_.text = var_146_15
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606036", "story_v_side_new_1106606.awb") ~= 0 then
					local var_146_19 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606036", "story_v_side_new_1106606.awb") / 1000

					if var_146_19 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_19 + var_146_11
					end

					if var_146_14.prefab_name ~= "" and arg_143_1.actors_[var_146_14.prefab_name] ~= nil then
						local var_146_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_14.prefab_name].transform, "story_v_side_new_1106606", "1106606036", "story_v_side_new_1106606.awb")

						arg_143_1:RecordAudio("1106606036", var_146_20)
						arg_143_1:RecordAudio("1106606036", var_146_20)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606036", "story_v_side_new_1106606.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606036", "story_v_side_new_1106606.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_21 = math.max(var_146_12, arg_143_1.talkMaxDuration)

			if var_146_11 <= arg_143_1.time_ and arg_143_1.time_ < var_146_11 + var_146_21 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_11) / var_146_21

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_11 + var_146_21 and arg_143_1.time_ < var_146_11 + var_146_21 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play1106606037 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1106606037
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1106606038(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1066ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1066ui_story == nil then
				arg_147_1.var_.characterEffect1066ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect1066ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1066ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1066ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1066ui_story.fillRatio = var_150_5
			end

			local var_150_6 = 0
			local var_150_7 = 0.65

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_8 = arg_147_1:FormatText(StoryNameCfg[7].name)

				arg_147_1.leftNameTxt_.text = var_150_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_9 = arg_147_1:GetWordFromCfg(1106606037)
				local var_150_10 = arg_147_1:FormatText(var_150_9.content)

				arg_147_1.text_.text = var_150_10

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_11 = 26
				local var_150_12 = utf8.len(var_150_10)
				local var_150_13 = var_150_11 <= 0 and var_150_7 or var_150_7 * (var_150_12 / var_150_11)

				if var_150_13 > 0 and var_150_7 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_10
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_14 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_14 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_14

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_14 and arg_147_1.time_ < var_150_6 + var_150_14 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1106606038 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1106606038
		arg_151_1.duration_ = 2.37

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1106606039(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1066ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos1066ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(0, -0.77, -6.1)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1066ui_story, var_154_4, var_154_3)

				local var_154_5 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_5.x, var_154_5.y, var_154_5.z)

				local var_154_6 = var_154_0.localEulerAngles

				var_154_6.z = 0
				var_154_6.x = 0
				var_154_0.localEulerAngles = var_154_6
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_154_7 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_7.x, var_154_7.y, var_154_7.z)

				local var_154_8 = var_154_0.localEulerAngles

				var_154_8.z = 0
				var_154_8.x = 0
				var_154_0.localEulerAngles = var_154_8
			end

			local var_154_9 = arg_151_1.actors_["1066ui_story"]
			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect1066ui_story == nil then
				arg_151_1.var_.characterEffect1066ui_story = var_154_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_11 = 0.200000002980232

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_11 and not isNil(var_154_9) then
				local var_154_12 = (arg_151_1.time_ - var_154_10) / var_154_11

				if arg_151_1.var_.characterEffect1066ui_story and not isNil(var_154_9) then
					arg_151_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_10 + var_154_11 and arg_151_1.time_ < var_154_10 + var_154_11 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect1066ui_story then
				arg_151_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_154_13 = 0

			if var_154_13 < arg_151_1.time_ and arg_151_1.time_ <= var_154_13 + arg_154_0 then
				arg_151_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action6_1")
			end

			local var_154_14 = 0

			if var_154_14 < arg_151_1.time_ and arg_151_1.time_ <= var_154_14 + arg_154_0 then
				arg_151_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_154_15 = 0

			if var_154_15 < arg_151_1.time_ and arg_151_1.time_ <= var_154_15 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			local var_154_16 = 2.36666666666667

			if arg_151_1.time_ >= var_154_15 + var_154_16 and arg_151_1.time_ < var_154_15 + var_154_16 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			local var_154_17 = 0
			local var_154_18 = 0.25

			if var_154_17 < arg_151_1.time_ and arg_151_1.time_ <= var_154_17 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_19 = arg_151_1:FormatText(StoryNameCfg[32].name)

				arg_151_1.leftNameTxt_.text = var_154_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_20 = arg_151_1:GetWordFromCfg(1106606038)
				local var_154_21 = arg_151_1:FormatText(var_154_20.content)

				arg_151_1.text_.text = var_154_21

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_22 = 10
				local var_154_23 = utf8.len(var_154_21)
				local var_154_24 = var_154_22 <= 0 and var_154_18 or var_154_18 * (var_154_23 / var_154_22)

				if var_154_24 > 0 and var_154_18 < var_154_24 then
					arg_151_1.talkMaxDuration = var_154_24

					if var_154_24 + var_154_17 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_24 + var_154_17
					end
				end

				arg_151_1.text_.text = var_154_21
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606038", "story_v_side_new_1106606.awb") ~= 0 then
					local var_154_25 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606038", "story_v_side_new_1106606.awb") / 1000

					if var_154_25 + var_154_17 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_25 + var_154_17
					end

					if var_154_20.prefab_name ~= "" and arg_151_1.actors_[var_154_20.prefab_name] ~= nil then
						local var_154_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_20.prefab_name].transform, "story_v_side_new_1106606", "1106606038", "story_v_side_new_1106606.awb")

						arg_151_1:RecordAudio("1106606038", var_154_26)
						arg_151_1:RecordAudio("1106606038", var_154_26)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606038", "story_v_side_new_1106606.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606038", "story_v_side_new_1106606.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_27 = math.max(var_154_18, arg_151_1.talkMaxDuration)

			if var_154_17 <= arg_151_1.time_ and arg_151_1.time_ < var_154_17 + var_154_27 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_17) / var_154_27

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_17 + var_154_27 and arg_151_1.time_ < var_154_17 + var_154_27 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play1106606039 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1106606039
		arg_155_1.duration_ = 12.17

		local var_155_0 = {
			zh = 8.466,
			ja = 12.166
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
				arg_155_0:Play1106606040(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_158_1 = 0
			local var_158_2 = 1.05

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_3 = arg_155_1:FormatText(StoryNameCfg[32].name)

				arg_155_1.leftNameTxt_.text = var_158_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:GetWordFromCfg(1106606039)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_6 = 42
				local var_158_7 = utf8.len(var_158_5)
				local var_158_8 = var_158_6 <= 0 and var_158_2 or var_158_2 * (var_158_7 / var_158_6)

				if var_158_8 > 0 and var_158_2 < var_158_8 then
					arg_155_1.talkMaxDuration = var_158_8

					if var_158_8 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_1
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606039", "story_v_side_new_1106606.awb") ~= 0 then
					local var_158_9 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606039", "story_v_side_new_1106606.awb") / 1000

					if var_158_9 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_1
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_side_new_1106606", "1106606039", "story_v_side_new_1106606.awb")

						arg_155_1:RecordAudio("1106606039", var_158_10)
						arg_155_1:RecordAudio("1106606039", var_158_10)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606039", "story_v_side_new_1106606.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606039", "story_v_side_new_1106606.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_11 = math.max(var_158_2, arg_155_1.talkMaxDuration)

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_11 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_1) / var_158_11

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_1 + var_158_11 and arg_155_1.time_ < var_158_1 + var_158_11 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1106606040 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1106606040
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1106606041(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1066ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1066ui_story == nil then
				arg_159_1.var_.characterEffect1066ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect1066ui_story and not isNil(var_162_0) then
					local var_162_4 = Mathf.Lerp(0, 0.5, var_162_3)

					arg_159_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1066ui_story.fillRatio = var_162_4
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1066ui_story then
				local var_162_5 = 0.5

				arg_159_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1066ui_story.fillRatio = var_162_5
			end

			local var_162_6 = 0
			local var_162_7 = 0.25

			if var_162_6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_8 = arg_159_1:FormatText(StoryNameCfg[7].name)

				arg_159_1.leftNameTxt_.text = var_162_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_9 = arg_159_1:GetWordFromCfg(1106606040)
				local var_162_10 = arg_159_1:FormatText(var_162_9.content)

				arg_159_1.text_.text = var_162_10

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 10
				local var_162_12 = utf8.len(var_162_10)
				local var_162_13 = var_162_11 <= 0 and var_162_7 or var_162_7 * (var_162_12 / var_162_11)

				if var_162_13 > 0 and var_162_7 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_10
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_14 and arg_159_1.time_ < var_162_6 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1106606041 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1106606041
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1106606042(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1066ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos1066ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0, 100, 0)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1066ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, 100, 0)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = 0
			local var_166_10 = 0.775

			if var_166_9 < arg_163_1.time_ and arg_163_1.time_ <= var_166_9 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_11 = arg_163_1:GetWordFromCfg(1106606041)
				local var_166_12 = arg_163_1:FormatText(var_166_11.content)

				arg_163_1.text_.text = var_166_12

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 31
				local var_166_14 = utf8.len(var_166_12)
				local var_166_15 = var_166_13 <= 0 and var_166_10 or var_166_10 * (var_166_14 / var_166_13)

				if var_166_15 > 0 and var_166_10 < var_166_15 then
					arg_163_1.talkMaxDuration = var_166_15

					if var_166_15 + var_166_9 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_15 + var_166_9
					end
				end

				arg_163_1.text_.text = var_166_12
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_10, arg_163_1.talkMaxDuration)

			if var_166_9 <= arg_163_1.time_ and arg_163_1.time_ < var_166_9 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_9) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_9 + var_166_16 and arg_163_1.time_ < var_166_9 + var_166_16 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play1106606042 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1106606042
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1106606043(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.7

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[7].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(1106606042)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 28
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_8 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_8 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_8

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_8 and arg_167_1.time_ < var_170_0 + var_170_8 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1106606043 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1106606043
		arg_171_1.duration_ = 6.4

		local var_171_0 = {
			zh = 6.4,
			ja = 6.1
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
				arg_171_0:Play1106606044(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1066ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1066ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0, -0.77, -6.1)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1066ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["1066ui_story"]
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect1066ui_story == nil then
				arg_171_1.var_.characterEffect1066ui_story = var_174_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_11 = 0.200000002980232

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 and not isNil(var_174_9) then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11

				if arg_171_1.var_.characterEffect1066ui_story and not isNil(var_174_9) then
					arg_171_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect1066ui_story then
				arg_171_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_174_13 = 0

			if var_174_13 < arg_171_1.time_ and arg_171_1.time_ <= var_174_13 + arg_174_0 then
				arg_171_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_174_14 = 0

			if var_174_14 < arg_171_1.time_ and arg_171_1.time_ <= var_174_14 + arg_174_0 then
				arg_171_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_174_15 = 0
			local var_174_16 = 0.7

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_17 = arg_171_1:FormatText(StoryNameCfg[32].name)

				arg_171_1.leftNameTxt_.text = var_174_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_18 = arg_171_1:GetWordFromCfg(1106606043)
				local var_174_19 = arg_171_1:FormatText(var_174_18.content)

				arg_171_1.text_.text = var_174_19

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_20 = 28
				local var_174_21 = utf8.len(var_174_19)
				local var_174_22 = var_174_20 <= 0 and var_174_16 or var_174_16 * (var_174_21 / var_174_20)

				if var_174_22 > 0 and var_174_16 < var_174_22 then
					arg_171_1.talkMaxDuration = var_174_22

					if var_174_22 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_22 + var_174_15
					end
				end

				arg_171_1.text_.text = var_174_19
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606043", "story_v_side_new_1106606.awb") ~= 0 then
					local var_174_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606043", "story_v_side_new_1106606.awb") / 1000

					if var_174_23 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_15
					end

					if var_174_18.prefab_name ~= "" and arg_171_1.actors_[var_174_18.prefab_name] ~= nil then
						local var_174_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_18.prefab_name].transform, "story_v_side_new_1106606", "1106606043", "story_v_side_new_1106606.awb")

						arg_171_1:RecordAudio("1106606043", var_174_24)
						arg_171_1:RecordAudio("1106606043", var_174_24)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606043", "story_v_side_new_1106606.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606043", "story_v_side_new_1106606.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_25 = math.max(var_174_16, arg_171_1.talkMaxDuration)

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_25 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_15) / var_174_25

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_15 + var_174_25 and arg_171_1.time_ < var_174_15 + var_174_25 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play1106606044 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1106606044
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1106606045(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1066ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1066ui_story == nil then
				arg_175_1.var_.characterEffect1066ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1066ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1066ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1066ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1066ui_story.fillRatio = var_178_5
			end

			local var_178_6 = 0
			local var_178_7 = 0.25

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_8 = arg_175_1:FormatText(StoryNameCfg[7].name)

				arg_175_1.leftNameTxt_.text = var_178_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_9 = arg_175_1:GetWordFromCfg(1106606044)
				local var_178_10 = arg_175_1:FormatText(var_178_9.content)

				arg_175_1.text_.text = var_178_10

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 10
				local var_178_12 = utf8.len(var_178_10)
				local var_178_13 = var_178_11 <= 0 and var_178_7 or var_178_7 * (var_178_12 / var_178_11)

				if var_178_13 > 0 and var_178_7 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_10
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_14 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_14 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_14

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_14 and arg_175_1.time_ < var_178_6 + var_178_14 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1106606045 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1106606045
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1106606046(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.775

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[7].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:GetWordFromCfg(1106606045)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 31
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_8 and arg_179_1.time_ < var_182_0 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1106606046 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1106606046
		arg_183_1.duration_ = 5

		local var_183_0 = {
			zh = 4.7,
			ja = 5
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
				arg_183_0:Play1106606047(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1066ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos1066ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0, -0.77, -6.1)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1066ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["1066ui_story"]
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1066ui_story == nil then
				arg_183_1.var_.characterEffect1066ui_story = var_186_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 and not isNil(var_186_9) then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11

				if arg_183_1.var_.characterEffect1066ui_story and not isNil(var_186_9) then
					arg_183_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1066ui_story then
				arg_183_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_186_13 = 0

			if var_186_13 < arg_183_1.time_ and arg_183_1.time_ <= var_186_13 + arg_186_0 then
				arg_183_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			local var_186_14 = 0

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_186_15 = 0
			local var_186_16 = 0.475

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_17 = arg_183_1:FormatText(StoryNameCfg[32].name)

				arg_183_1.leftNameTxt_.text = var_186_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_18 = arg_183_1:GetWordFromCfg(1106606046)
				local var_186_19 = arg_183_1:FormatText(var_186_18.content)

				arg_183_1.text_.text = var_186_19

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 19
				local var_186_21 = utf8.len(var_186_19)
				local var_186_22 = var_186_20 <= 0 and var_186_16 or var_186_16 * (var_186_21 / var_186_20)

				if var_186_22 > 0 and var_186_16 < var_186_22 then
					arg_183_1.talkMaxDuration = var_186_22

					if var_186_22 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_19
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606046", "story_v_side_new_1106606.awb") ~= 0 then
					local var_186_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606046", "story_v_side_new_1106606.awb") / 1000

					if var_186_23 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_15
					end

					if var_186_18.prefab_name ~= "" and arg_183_1.actors_[var_186_18.prefab_name] ~= nil then
						local var_186_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_18.prefab_name].transform, "story_v_side_new_1106606", "1106606046", "story_v_side_new_1106606.awb")

						arg_183_1:RecordAudio("1106606046", var_186_24)
						arg_183_1:RecordAudio("1106606046", var_186_24)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606046", "story_v_side_new_1106606.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606046", "story_v_side_new_1106606.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_25 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_25 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_25

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_25 and arg_183_1.time_ < var_186_15 + var_186_25 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play1106606047 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1106606047
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1106606048(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1066ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1066ui_story == nil then
				arg_187_1.var_.characterEffect1066ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1066ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1066ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1066ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1066ui_story.fillRatio = var_190_5
			end

			local var_190_6 = 0
			local var_190_7 = 0.35

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_8 = arg_187_1:FormatText(StoryNameCfg[7].name)

				arg_187_1.leftNameTxt_.text = var_190_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_9 = arg_187_1:GetWordFromCfg(1106606047)
				local var_190_10 = arg_187_1:FormatText(var_190_9.content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 14
				local var_190_12 = utf8.len(var_190_10)
				local var_190_13 = var_190_11 <= 0 and var_190_7 or var_190_7 * (var_190_12 / var_190_11)

				if var_190_13 > 0 and var_190_7 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_6
					end
				end

				arg_187_1.text_.text = var_190_10
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_14 = math.max(var_190_7, arg_187_1.talkMaxDuration)

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_14 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_6) / var_190_14

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_6 + var_190_14 and arg_187_1.time_ < var_190_6 + var_190_14 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1106606048 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1106606048
		arg_191_1.duration_ = 10.47

		local var_191_0 = {
			zh = 6.366,
			ja = 10.466
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1106606049(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1066ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos1066ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0, -0.77, -6.1)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1066ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = arg_191_1.actors_["1066ui_story"]
			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect1066ui_story == nil then
				arg_191_1.var_.characterEffect1066ui_story = var_194_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_11 = 0.200000002980232

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_11 and not isNil(var_194_9) then
				local var_194_12 = (arg_191_1.time_ - var_194_10) / var_194_11

				if arg_191_1.var_.characterEffect1066ui_story and not isNil(var_194_9) then
					arg_191_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_10 + var_194_11 and arg_191_1.time_ < var_194_10 + var_194_11 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect1066ui_story then
				arg_191_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_194_13 = 0

			if var_194_13 < arg_191_1.time_ and arg_191_1.time_ <= var_194_13 + arg_194_0 then
				arg_191_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			local var_194_14 = 0

			if var_194_14 < arg_191_1.time_ and arg_191_1.time_ <= var_194_14 + arg_194_0 then
				arg_191_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_15 = 0
			local var_194_16 = 0.75

			if var_194_15 < arg_191_1.time_ and arg_191_1.time_ <= var_194_15 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_17 = arg_191_1:FormatText(StoryNameCfg[32].name)

				arg_191_1.leftNameTxt_.text = var_194_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_18 = arg_191_1:GetWordFromCfg(1106606048)
				local var_194_19 = arg_191_1:FormatText(var_194_18.content)

				arg_191_1.text_.text = var_194_19

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_20 = 30
				local var_194_21 = utf8.len(var_194_19)
				local var_194_22 = var_194_20 <= 0 and var_194_16 or var_194_16 * (var_194_21 / var_194_20)

				if var_194_22 > 0 and var_194_16 < var_194_22 then
					arg_191_1.talkMaxDuration = var_194_22

					if var_194_22 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_22 + var_194_15
					end
				end

				arg_191_1.text_.text = var_194_19
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606048", "story_v_side_new_1106606.awb") ~= 0 then
					local var_194_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606048", "story_v_side_new_1106606.awb") / 1000

					if var_194_23 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_23 + var_194_15
					end

					if var_194_18.prefab_name ~= "" and arg_191_1.actors_[var_194_18.prefab_name] ~= nil then
						local var_194_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_18.prefab_name].transform, "story_v_side_new_1106606", "1106606048", "story_v_side_new_1106606.awb")

						arg_191_1:RecordAudio("1106606048", var_194_24)
						arg_191_1:RecordAudio("1106606048", var_194_24)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606048", "story_v_side_new_1106606.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606048", "story_v_side_new_1106606.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_25 = math.max(var_194_16, arg_191_1.talkMaxDuration)

			if var_194_15 <= arg_191_1.time_ and arg_191_1.time_ < var_194_15 + var_194_25 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_15) / var_194_25

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_15 + var_194_25 and arg_191_1.time_ < var_194_15 + var_194_25 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play1106606049 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1106606049
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1106606050(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1066ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1066ui_story == nil then
				arg_195_1.var_.characterEffect1066ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect1066ui_story and not isNil(var_198_0) then
					local var_198_4 = Mathf.Lerp(0, 0.5, var_198_3)

					arg_195_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1066ui_story.fillRatio = var_198_4
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1066ui_story then
				local var_198_5 = 0.5

				arg_195_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1066ui_story.fillRatio = var_198_5
			end

			local var_198_6 = 0
			local var_198_7 = 0.85

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_8 = arg_195_1:FormatText(StoryNameCfg[7].name)

				arg_195_1.leftNameTxt_.text = var_198_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_9 = arg_195_1:GetWordFromCfg(1106606049)
				local var_198_10 = arg_195_1:FormatText(var_198_9.content)

				arg_195_1.text_.text = var_198_10

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 34
				local var_198_12 = utf8.len(var_198_10)
				local var_198_13 = var_198_11 <= 0 and var_198_7 or var_198_7 * (var_198_12 / var_198_11)

				if var_198_13 > 0 and var_198_7 < var_198_13 then
					arg_195_1.talkMaxDuration = var_198_13

					if var_198_13 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_10
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_14 and arg_195_1.time_ < var_198_6 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1106606050 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1106606050
		arg_199_1.duration_ = 5.57

		local var_199_0 = {
			zh = 1.999999999999,
			ja = 5.566
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1106606051(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1066ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos1066ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(0, -0.77, -6.1)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1066ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = arg_199_1.actors_["1066ui_story"]
			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect1066ui_story == nil then
				arg_199_1.var_.characterEffect1066ui_story = var_202_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_11 = 0.200000002980232

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 and not isNil(var_202_9) then
				local var_202_12 = (arg_199_1.time_ - var_202_10) / var_202_11

				if arg_199_1.var_.characterEffect1066ui_story and not isNil(var_202_9) then
					arg_199_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect1066ui_story then
				arg_199_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_202_13 = 0

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action9_1")
			end

			local var_202_14 = 0

			if var_202_14 < arg_199_1.time_ and arg_199_1.time_ <= var_202_14 + arg_202_0 then
				arg_199_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_202_15 = 0
			local var_202_16 = 0.15

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_17 = arg_199_1:FormatText(StoryNameCfg[32].name)

				arg_199_1.leftNameTxt_.text = var_202_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_18 = arg_199_1:GetWordFromCfg(1106606050)
				local var_202_19 = arg_199_1:FormatText(var_202_18.content)

				arg_199_1.text_.text = var_202_19

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_20 = 6
				local var_202_21 = utf8.len(var_202_19)
				local var_202_22 = var_202_20 <= 0 and var_202_16 or var_202_16 * (var_202_21 / var_202_20)

				if var_202_22 > 0 and var_202_16 < var_202_22 then
					arg_199_1.talkMaxDuration = var_202_22

					if var_202_22 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_22 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_19
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606050", "story_v_side_new_1106606.awb") ~= 0 then
					local var_202_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606050", "story_v_side_new_1106606.awb") / 1000

					if var_202_23 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_23 + var_202_15
					end

					if var_202_18.prefab_name ~= "" and arg_199_1.actors_[var_202_18.prefab_name] ~= nil then
						local var_202_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_18.prefab_name].transform, "story_v_side_new_1106606", "1106606050", "story_v_side_new_1106606.awb")

						arg_199_1:RecordAudio("1106606050", var_202_24)
						arg_199_1:RecordAudio("1106606050", var_202_24)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606050", "story_v_side_new_1106606.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606050", "story_v_side_new_1106606.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_25 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_25 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_25

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_25 and arg_199_1.time_ < var_202_15 + var_202_25 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play1106606051 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1106606051
		arg_203_1.duration_ = 9

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1106606052(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 2

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				local var_206_1 = manager.ui.mainCamera.transform.localPosition
				local var_206_2 = Vector3.New(0, 0, 10) + Vector3.New(var_206_1.x, var_206_1.y, 0)
				local var_206_3 = arg_203_1.bgs_.ST10

				var_206_3.transform.localPosition = var_206_2
				var_206_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_4 = var_206_3:GetComponent("SpriteRenderer")

				if var_206_4 and var_206_4.sprite then
					local var_206_5 = (var_206_3.transform.localPosition - var_206_1).z
					local var_206_6 = manager.ui.mainCameraCom_
					local var_206_7 = 2 * var_206_5 * Mathf.Tan(var_206_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_206_8 = var_206_7 * var_206_6.aspect
					local var_206_9 = var_206_4.sprite.bounds.size.x
					local var_206_10 = var_206_4.sprite.bounds.size.y
					local var_206_11 = var_206_8 / var_206_9
					local var_206_12 = var_206_7 / var_206_10
					local var_206_13 = var_206_12 < var_206_11 and var_206_11 or var_206_12

					var_206_3.transform.localScale = Vector3.New(var_206_13, var_206_13, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "ST10" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_14 = 0

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_15 = 2

			if var_206_14 <= arg_203_1.time_ and arg_203_1.time_ < var_206_14 + var_206_15 then
				local var_206_16 = (arg_203_1.time_ - var_206_14) / var_206_15
				local var_206_17 = Color.New(0, 0, 0)

				var_206_17.a = Mathf.Lerp(0, 1, var_206_16)
				arg_203_1.mask_.color = var_206_17
			end

			if arg_203_1.time_ >= var_206_14 + var_206_15 and arg_203_1.time_ < var_206_14 + var_206_15 + arg_206_0 then
				local var_206_18 = Color.New(0, 0, 0)

				var_206_18.a = 1
				arg_203_1.mask_.color = var_206_18
			end

			local var_206_19 = 2

			if var_206_19 < arg_203_1.time_ and arg_203_1.time_ <= var_206_19 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_20 = 2

			if var_206_19 <= arg_203_1.time_ and arg_203_1.time_ < var_206_19 + var_206_20 then
				local var_206_21 = (arg_203_1.time_ - var_206_19) / var_206_20
				local var_206_22 = Color.New(0, 0, 0)

				var_206_22.a = Mathf.Lerp(1, 0, var_206_21)
				arg_203_1.mask_.color = var_206_22
			end

			if arg_203_1.time_ >= var_206_19 + var_206_20 and arg_203_1.time_ < var_206_19 + var_206_20 + arg_206_0 then
				local var_206_23 = Color.New(0, 0, 0)
				local var_206_24 = 0

				arg_203_1.mask_.enabled = false
				var_206_23.a = var_206_24
				arg_203_1.mask_.color = var_206_23
			end

			local var_206_25 = arg_203_1.actors_["1066ui_story"].transform
			local var_206_26 = 2

			if var_206_26 < arg_203_1.time_ and arg_203_1.time_ <= var_206_26 + arg_206_0 then
				arg_203_1.var_.moveOldPos1066ui_story = var_206_25.localPosition
			end

			local var_206_27 = 0.001

			if var_206_26 <= arg_203_1.time_ and arg_203_1.time_ < var_206_26 + var_206_27 then
				local var_206_28 = (arg_203_1.time_ - var_206_26) / var_206_27
				local var_206_29 = Vector3.New(0, 100, 0)

				var_206_25.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1066ui_story, var_206_29, var_206_28)

				local var_206_30 = manager.ui.mainCamera.transform.position - var_206_25.position

				var_206_25.forward = Vector3.New(var_206_30.x, var_206_30.y, var_206_30.z)

				local var_206_31 = var_206_25.localEulerAngles

				var_206_31.z = 0
				var_206_31.x = 0
				var_206_25.localEulerAngles = var_206_31
			end

			if arg_203_1.time_ >= var_206_26 + var_206_27 and arg_203_1.time_ < var_206_26 + var_206_27 + arg_206_0 then
				var_206_25.localPosition = Vector3.New(0, 100, 0)

				local var_206_32 = manager.ui.mainCamera.transform.position - var_206_25.position

				var_206_25.forward = Vector3.New(var_206_32.x, var_206_32.y, var_206_32.z)

				local var_206_33 = var_206_25.localEulerAngles

				var_206_33.z = 0
				var_206_33.x = 0
				var_206_25.localEulerAngles = var_206_33
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_34 = 4
			local var_206_35 = 1.125

			if var_206_34 < arg_203_1.time_ and arg_203_1.time_ <= var_206_34 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_36 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_36:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_37 = arg_203_1:GetWordFromCfg(1106606051)
				local var_206_38 = arg_203_1:FormatText(var_206_37.content)

				arg_203_1.text_.text = var_206_38

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_39 = 45
				local var_206_40 = utf8.len(var_206_38)
				local var_206_41 = var_206_39 <= 0 and var_206_35 or var_206_35 * (var_206_40 / var_206_39)

				if var_206_41 > 0 and var_206_35 < var_206_41 then
					arg_203_1.talkMaxDuration = var_206_41
					var_206_34 = var_206_34 + 0.3

					if var_206_41 + var_206_34 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_41 + var_206_34
					end
				end

				arg_203_1.text_.text = var_206_38
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_42 = var_206_34 + 0.3
			local var_206_43 = math.max(var_206_35, arg_203_1.talkMaxDuration)

			if var_206_42 <= arg_203_1.time_ and arg_203_1.time_ < var_206_42 + var_206_43 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_42) / var_206_43

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_42 + var_206_43 and arg_203_1.time_ < var_206_42 + var_206_43 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play1106606052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1106606052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1106606053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 1.625

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

				local var_212_2 = arg_209_1:GetWordFromCfg(1106606052)
				local var_212_3 = arg_209_1:FormatText(var_212_2.content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 65
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
	Play1106606053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1106606053
		arg_213_1.duration_ = 1.97

		local var_213_0 = {
			zh = 1.633,
			ja = 1.966
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
				arg_213_0:Play1106606054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1066ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos1066ui_story = var_216_0.localPosition
			end

			local var_216_2 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2
				local var_216_4 = Vector3.New(0, -0.77, -6.1)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1066ui_story, var_216_4, var_216_3)

				local var_216_5 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_5.x, var_216_5.y, var_216_5.z)

				local var_216_6 = var_216_0.localEulerAngles

				var_216_6.z = 0
				var_216_6.x = 0
				var_216_0.localEulerAngles = var_216_6
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_216_7 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_7.x, var_216_7.y, var_216_7.z)

				local var_216_8 = var_216_0.localEulerAngles

				var_216_8.z = 0
				var_216_8.x = 0
				var_216_0.localEulerAngles = var_216_8
			end

			local var_216_9 = arg_213_1.actors_["1066ui_story"]
			local var_216_10 = 0

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1066ui_story == nil then
				arg_213_1.var_.characterEffect1066ui_story = var_216_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_11 = 0.200000002980232

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_11 and not isNil(var_216_9) then
				local var_216_12 = (arg_213_1.time_ - var_216_10) / var_216_11

				if arg_213_1.var_.characterEffect1066ui_story and not isNil(var_216_9) then
					arg_213_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_10 + var_216_11 and arg_213_1.time_ < var_216_10 + var_216_11 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1066ui_story then
				arg_213_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_216_13 = 0

			if var_216_13 < arg_213_1.time_ and arg_213_1.time_ <= var_216_13 + arg_216_0 then
				arg_213_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_216_14 = 0

			if var_216_14 < arg_213_1.time_ and arg_213_1.time_ <= var_216_14 + arg_216_0 then
				arg_213_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_216_15 = 0
			local var_216_16 = 0.15

			if var_216_15 < arg_213_1.time_ and arg_213_1.time_ <= var_216_15 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_17 = arg_213_1:FormatText(StoryNameCfg[32].name)

				arg_213_1.leftNameTxt_.text = var_216_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_18 = arg_213_1:GetWordFromCfg(1106606053)
				local var_216_19 = arg_213_1:FormatText(var_216_18.content)

				arg_213_1.text_.text = var_216_19

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_20 = 6
				local var_216_21 = utf8.len(var_216_19)
				local var_216_22 = var_216_20 <= 0 and var_216_16 or var_216_16 * (var_216_21 / var_216_20)

				if var_216_22 > 0 and var_216_16 < var_216_22 then
					arg_213_1.talkMaxDuration = var_216_22

					if var_216_22 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_22 + var_216_15
					end
				end

				arg_213_1.text_.text = var_216_19
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606053", "story_v_side_new_1106606.awb") ~= 0 then
					local var_216_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606053", "story_v_side_new_1106606.awb") / 1000

					if var_216_23 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_23 + var_216_15
					end

					if var_216_18.prefab_name ~= "" and arg_213_1.actors_[var_216_18.prefab_name] ~= nil then
						local var_216_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_18.prefab_name].transform, "story_v_side_new_1106606", "1106606053", "story_v_side_new_1106606.awb")

						arg_213_1:RecordAudio("1106606053", var_216_24)
						arg_213_1:RecordAudio("1106606053", var_216_24)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606053", "story_v_side_new_1106606.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606053", "story_v_side_new_1106606.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_25 = math.max(var_216_16, arg_213_1.talkMaxDuration)

			if var_216_15 <= arg_213_1.time_ and arg_213_1.time_ < var_216_15 + var_216_25 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_15) / var_216_25

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_15 + var_216_25 and arg_213_1.time_ < var_216_15 + var_216_25 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play1106606054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1106606054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1106606055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1066ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1066ui_story == nil then
				arg_217_1.var_.characterEffect1066ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1066ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1066ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1066ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1066ui_story.fillRatio = var_220_5
			end

			local var_220_6 = 0
			local var_220_7 = 0.35

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_8 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_9 = arg_217_1:GetWordFromCfg(1106606054)
				local var_220_10 = arg_217_1:FormatText(var_220_9.content)

				arg_217_1.text_.text = var_220_10

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 14
				local var_220_12 = utf8.len(var_220_10)
				local var_220_13 = var_220_11 <= 0 and var_220_7 or var_220_7 * (var_220_12 / var_220_11)

				if var_220_13 > 0 and var_220_7 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_10
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1106606055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1106606055
		arg_221_1.duration_ = 3.77

		local var_221_0 = {
			zh = 3.766,
			ja = 2.033
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
				arg_221_0:Play1106606056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1066ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1066ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0, -0.77, -6.1)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1066ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = arg_221_1.actors_["1066ui_story"]
			local var_224_10 = 0

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1066ui_story == nil then
				arg_221_1.var_.characterEffect1066ui_story = var_224_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_11 = 0.200000002980232

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_11 and not isNil(var_224_9) then
				local var_224_12 = (arg_221_1.time_ - var_224_10) / var_224_11

				if arg_221_1.var_.characterEffect1066ui_story and not isNil(var_224_9) then
					arg_221_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_10 + var_224_11 and arg_221_1.time_ < var_224_10 + var_224_11 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1066ui_story then
				arg_221_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_224_13 = 0

			if var_224_13 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				arg_221_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_224_14 = 0
			local var_224_15 = 0.425

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_16 = arg_221_1:FormatText(StoryNameCfg[32].name)

				arg_221_1.leftNameTxt_.text = var_224_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_17 = arg_221_1:GetWordFromCfg(1106606055)
				local var_224_18 = arg_221_1:FormatText(var_224_17.content)

				arg_221_1.text_.text = var_224_18

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_19 = 17
				local var_224_20 = utf8.len(var_224_18)
				local var_224_21 = var_224_19 <= 0 and var_224_15 or var_224_15 * (var_224_20 / var_224_19)

				if var_224_21 > 0 and var_224_15 < var_224_21 then
					arg_221_1.talkMaxDuration = var_224_21

					if var_224_21 + var_224_14 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_21 + var_224_14
					end
				end

				arg_221_1.text_.text = var_224_18
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606055", "story_v_side_new_1106606.awb") ~= 0 then
					local var_224_22 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606055", "story_v_side_new_1106606.awb") / 1000

					if var_224_22 + var_224_14 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_22 + var_224_14
					end

					if var_224_17.prefab_name ~= "" and arg_221_1.actors_[var_224_17.prefab_name] ~= nil then
						local var_224_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_17.prefab_name].transform, "story_v_side_new_1106606", "1106606055", "story_v_side_new_1106606.awb")

						arg_221_1:RecordAudio("1106606055", var_224_23)
						arg_221_1:RecordAudio("1106606055", var_224_23)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606055", "story_v_side_new_1106606.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606055", "story_v_side_new_1106606.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_24 = math.max(var_224_15, arg_221_1.talkMaxDuration)

			if var_224_14 <= arg_221_1.time_ and arg_221_1.time_ < var_224_14 + var_224_24 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_14) / var_224_24

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_14 + var_224_24 and arg_221_1.time_ < var_224_14 + var_224_24 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play1106606056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1106606056
		arg_225_1.duration_ = 3.63

		local var_225_0 = {
			zh = 3.633,
			ja = 3.5
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
				arg_225_0:Play1106606057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1066ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos1066ui_story = var_228_0.localPosition
			end

			local var_228_2 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2
				local var_228_4 = Vector3.New(0, -0.77, -6.1)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1066ui_story, var_228_4, var_228_3)

				local var_228_5 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_5.x, var_228_5.y, var_228_5.z)

				local var_228_6 = var_228_0.localEulerAngles

				var_228_6.z = 0
				var_228_6.x = 0
				var_228_0.localEulerAngles = var_228_6
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_228_7 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_7.x, var_228_7.y, var_228_7.z)

				local var_228_8 = var_228_0.localEulerAngles

				var_228_8.z = 0
				var_228_8.x = 0
				var_228_0.localEulerAngles = var_228_8
			end

			local var_228_9 = arg_225_1.actors_["1066ui_story"]
			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1066ui_story == nil then
				arg_225_1.var_.characterEffect1066ui_story = var_228_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_11 = 0.200000002980232

			if var_228_10 <= arg_225_1.time_ and arg_225_1.time_ < var_228_10 + var_228_11 and not isNil(var_228_9) then
				local var_228_12 = (arg_225_1.time_ - var_228_10) / var_228_11

				if arg_225_1.var_.characterEffect1066ui_story and not isNil(var_228_9) then
					arg_225_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_10 + var_228_11 and arg_225_1.time_ < var_228_10 + var_228_11 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1066ui_story then
				arg_225_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_228_13 = 0

			if var_228_13 < arg_225_1.time_ and arg_225_1.time_ <= var_228_13 + arg_228_0 then
				arg_225_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			local var_228_14 = 0

			if var_228_14 < arg_225_1.time_ and arg_225_1.time_ <= var_228_14 + arg_228_0 then
				arg_225_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_228_15 = 0
			local var_228_16 = 0.3

			if var_228_15 < arg_225_1.time_ and arg_225_1.time_ <= var_228_15 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_17 = arg_225_1:FormatText(StoryNameCfg[32].name)

				arg_225_1.leftNameTxt_.text = var_228_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_18 = arg_225_1:GetWordFromCfg(1106606056)
				local var_228_19 = arg_225_1:FormatText(var_228_18.content)

				arg_225_1.text_.text = var_228_19

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_20 = 12
				local var_228_21 = utf8.len(var_228_19)
				local var_228_22 = var_228_20 <= 0 and var_228_16 or var_228_16 * (var_228_21 / var_228_20)

				if var_228_22 > 0 and var_228_16 < var_228_22 then
					arg_225_1.talkMaxDuration = var_228_22

					if var_228_22 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_22 + var_228_15
					end
				end

				arg_225_1.text_.text = var_228_19
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606056", "story_v_side_new_1106606.awb") ~= 0 then
					local var_228_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606056", "story_v_side_new_1106606.awb") / 1000

					if var_228_23 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_23 + var_228_15
					end

					if var_228_18.prefab_name ~= "" and arg_225_1.actors_[var_228_18.prefab_name] ~= nil then
						local var_228_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_18.prefab_name].transform, "story_v_side_new_1106606", "1106606056", "story_v_side_new_1106606.awb")

						arg_225_1:RecordAudio("1106606056", var_228_24)
						arg_225_1:RecordAudio("1106606056", var_228_24)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606056", "story_v_side_new_1106606.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606056", "story_v_side_new_1106606.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_25 = math.max(var_228_16, arg_225_1.talkMaxDuration)

			if var_228_15 <= arg_225_1.time_ and arg_225_1.time_ < var_228_15 + var_228_25 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_15) / var_228_25

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_15 + var_228_25 and arg_225_1.time_ < var_228_15 + var_228_25 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play1106606057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1106606057
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1106606058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1066ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1066ui_story == nil then
				arg_229_1.var_.characterEffect1066ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1066ui_story and not isNil(var_232_0) then
					local var_232_4 = Mathf.Lerp(0, 0.5, var_232_3)

					arg_229_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1066ui_story.fillRatio = var_232_4
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1066ui_story then
				local var_232_5 = 0.5

				arg_229_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1066ui_story.fillRatio = var_232_5
			end

			local var_232_6 = 0
			local var_232_7 = 1.05

			if var_232_6 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_8 = arg_229_1:FormatText(StoryNameCfg[7].name)

				arg_229_1.leftNameTxt_.text = var_232_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_9 = arg_229_1:GetWordFromCfg(1106606057)
				local var_232_10 = arg_229_1:FormatText(var_232_9.content)

				arg_229_1.text_.text = var_232_10

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_11 = 42
				local var_232_12 = utf8.len(var_232_10)
				local var_232_13 = var_232_11 <= 0 and var_232_7 or var_232_7 * (var_232_12 / var_232_11)

				if var_232_13 > 0 and var_232_7 < var_232_13 then
					arg_229_1.talkMaxDuration = var_232_13

					if var_232_13 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_13 + var_232_6
					end
				end

				arg_229_1.text_.text = var_232_10
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_14 = math.max(var_232_7, arg_229_1.talkMaxDuration)

			if var_232_6 <= arg_229_1.time_ and arg_229_1.time_ < var_232_6 + var_232_14 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_6) / var_232_14

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_6 + var_232_14 and arg_229_1.time_ < var_232_6 + var_232_14 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1106606058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1106606058
		arg_233_1.duration_ = 2.53

		local var_233_0 = {
			zh = 2.533,
			ja = 1.999999999999
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1106606059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1066ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1066ui_story = var_236_0.localPosition
			end

			local var_236_2 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2
				local var_236_4 = Vector3.New(0, -0.77, -6.1)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1066ui_story, var_236_4, var_236_3)

				local var_236_5 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_5.x, var_236_5.y, var_236_5.z)

				local var_236_6 = var_236_0.localEulerAngles

				var_236_6.z = 0
				var_236_6.x = 0
				var_236_0.localEulerAngles = var_236_6
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_236_7 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_7.x, var_236_7.y, var_236_7.z)

				local var_236_8 = var_236_0.localEulerAngles

				var_236_8.z = 0
				var_236_8.x = 0
				var_236_0.localEulerAngles = var_236_8
			end

			local var_236_9 = arg_233_1.actors_["1066ui_story"]
			local var_236_10 = 0

			if var_236_10 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect1066ui_story == nil then
				arg_233_1.var_.characterEffect1066ui_story = var_236_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_11 = 0.200000002980232

			if var_236_10 <= arg_233_1.time_ and arg_233_1.time_ < var_236_10 + var_236_11 and not isNil(var_236_9) then
				local var_236_12 = (arg_233_1.time_ - var_236_10) / var_236_11

				if arg_233_1.var_.characterEffect1066ui_story and not isNil(var_236_9) then
					arg_233_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_10 + var_236_11 and arg_233_1.time_ < var_236_10 + var_236_11 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect1066ui_story then
				arg_233_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_236_13 = 0

			if var_236_13 < arg_233_1.time_ and arg_233_1.time_ <= var_236_13 + arg_236_0 then
				arg_233_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_236_14 = 0
			local var_236_15 = 0.25

			if var_236_14 < arg_233_1.time_ and arg_233_1.time_ <= var_236_14 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_16 = arg_233_1:FormatText(StoryNameCfg[32].name)

				arg_233_1.leftNameTxt_.text = var_236_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_17 = arg_233_1:GetWordFromCfg(1106606058)
				local var_236_18 = arg_233_1:FormatText(var_236_17.content)

				arg_233_1.text_.text = var_236_18

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_19 = 10
				local var_236_20 = utf8.len(var_236_18)
				local var_236_21 = var_236_19 <= 0 and var_236_15 or var_236_15 * (var_236_20 / var_236_19)

				if var_236_21 > 0 and var_236_15 < var_236_21 then
					arg_233_1.talkMaxDuration = var_236_21

					if var_236_21 + var_236_14 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_21 + var_236_14
					end
				end

				arg_233_1.text_.text = var_236_18
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606058", "story_v_side_new_1106606.awb") ~= 0 then
					local var_236_22 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606058", "story_v_side_new_1106606.awb") / 1000

					if var_236_22 + var_236_14 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_22 + var_236_14
					end

					if var_236_17.prefab_name ~= "" and arg_233_1.actors_[var_236_17.prefab_name] ~= nil then
						local var_236_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_17.prefab_name].transform, "story_v_side_new_1106606", "1106606058", "story_v_side_new_1106606.awb")

						arg_233_1:RecordAudio("1106606058", var_236_23)
						arg_233_1:RecordAudio("1106606058", var_236_23)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606058", "story_v_side_new_1106606.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606058", "story_v_side_new_1106606.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_24 = math.max(var_236_15, arg_233_1.talkMaxDuration)

			if var_236_14 <= arg_233_1.time_ and arg_233_1.time_ < var_236_14 + var_236_24 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_14) / var_236_24

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_14 + var_236_24 and arg_233_1.time_ < var_236_14 + var_236_24 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play1106606059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1106606059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1106606060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1066ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1066ui_story == nil then
				arg_237_1.var_.characterEffect1066ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect1066ui_story and not isNil(var_240_0) then
					local var_240_4 = Mathf.Lerp(0, 0.5, var_240_3)

					arg_237_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1066ui_story.fillRatio = var_240_4
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1066ui_story then
				local var_240_5 = 0.5

				arg_237_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1066ui_story.fillRatio = var_240_5
			end

			local var_240_6 = 0
			local var_240_7 = 0.625

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_8 = arg_237_1:GetWordFromCfg(1106606059)
				local var_240_9 = arg_237_1:FormatText(var_240_8.content)

				arg_237_1.text_.text = var_240_9

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_10 = 25
				local var_240_11 = utf8.len(var_240_9)
				local var_240_12 = var_240_10 <= 0 and var_240_7 or var_240_7 * (var_240_11 / var_240_10)

				if var_240_12 > 0 and var_240_7 < var_240_12 then
					arg_237_1.talkMaxDuration = var_240_12

					if var_240_12 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_12 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_9
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_13 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_13 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_13

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_13 and arg_237_1.time_ < var_240_6 + var_240_13 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1106606060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1106606060
		arg_241_1.duration_ = 6.83

		local var_241_0 = {
			zh = 6.833,
			ja = 6.366
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
				arg_241_0:Play1106606061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1066ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1066ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, -0.77, -6.1)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1066ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = arg_241_1.actors_["1066ui_story"]
			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1066ui_story == nil then
				arg_241_1.var_.characterEffect1066ui_story = var_244_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_11 = 0.200000002980232

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_11 and not isNil(var_244_9) then
				local var_244_12 = (arg_241_1.time_ - var_244_10) / var_244_11

				if arg_241_1.var_.characterEffect1066ui_story and not isNil(var_244_9) then
					arg_241_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_10 + var_244_11 and arg_241_1.time_ < var_244_10 + var_244_11 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1066ui_story then
				arg_241_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_244_13 = 0

			if var_244_13 < arg_241_1.time_ and arg_241_1.time_ <= var_244_13 + arg_244_0 then
				arg_241_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_244_14 = 0
			local var_244_15 = 0.775

			if var_244_14 < arg_241_1.time_ and arg_241_1.time_ <= var_244_14 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_16 = arg_241_1:FormatText(StoryNameCfg[32].name)

				arg_241_1.leftNameTxt_.text = var_244_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_17 = arg_241_1:GetWordFromCfg(1106606060)
				local var_244_18 = arg_241_1:FormatText(var_244_17.content)

				arg_241_1.text_.text = var_244_18

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_19 = 31
				local var_244_20 = utf8.len(var_244_18)
				local var_244_21 = var_244_19 <= 0 and var_244_15 or var_244_15 * (var_244_20 / var_244_19)

				if var_244_21 > 0 and var_244_15 < var_244_21 then
					arg_241_1.talkMaxDuration = var_244_21

					if var_244_21 + var_244_14 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_21 + var_244_14
					end
				end

				arg_241_1.text_.text = var_244_18
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606060", "story_v_side_new_1106606.awb") ~= 0 then
					local var_244_22 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606060", "story_v_side_new_1106606.awb") / 1000

					if var_244_22 + var_244_14 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_22 + var_244_14
					end

					if var_244_17.prefab_name ~= "" and arg_241_1.actors_[var_244_17.prefab_name] ~= nil then
						local var_244_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_17.prefab_name].transform, "story_v_side_new_1106606", "1106606060", "story_v_side_new_1106606.awb")

						arg_241_1:RecordAudio("1106606060", var_244_23)
						arg_241_1:RecordAudio("1106606060", var_244_23)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606060", "story_v_side_new_1106606.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606060", "story_v_side_new_1106606.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_24 = math.max(var_244_15, arg_241_1.talkMaxDuration)

			if var_244_14 <= arg_241_1.time_ and arg_241_1.time_ < var_244_14 + var_244_24 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_14) / var_244_24

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_14 + var_244_24 and arg_241_1.time_ < var_244_14 + var_244_24 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play1106606061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1106606061
		arg_245_1.duration_ = 9

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1106606062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 2

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				local var_248_1 = manager.ui.mainCamera.transform.localPosition
				local var_248_2 = Vector3.New(0, 0, 10) + Vector3.New(var_248_1.x, var_248_1.y, 0)
				local var_248_3 = arg_245_1.bgs_.ST10

				var_248_3.transform.localPosition = var_248_2
				var_248_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_248_4 = var_248_3:GetComponent("SpriteRenderer")

				if var_248_4 and var_248_4.sprite then
					local var_248_5 = (var_248_3.transform.localPosition - var_248_1).z
					local var_248_6 = manager.ui.mainCameraCom_
					local var_248_7 = 2 * var_248_5 * Mathf.Tan(var_248_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_248_8 = var_248_7 * var_248_6.aspect
					local var_248_9 = var_248_4.sprite.bounds.size.x
					local var_248_10 = var_248_4.sprite.bounds.size.y
					local var_248_11 = var_248_8 / var_248_9
					local var_248_12 = var_248_7 / var_248_10
					local var_248_13 = var_248_12 < var_248_11 and var_248_11 or var_248_12

					var_248_3.transform.localScale = Vector3.New(var_248_13, var_248_13, 0)
				end

				for iter_248_0, iter_248_1 in pairs(arg_245_1.bgs_) do
					if iter_248_0 ~= "ST10" then
						iter_248_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_248_14 = 0

			if var_248_14 < arg_245_1.time_ and arg_245_1.time_ <= var_248_14 + arg_248_0 then
				arg_245_1.mask_.enabled = true
				arg_245_1.mask_.raycastTarget = true

				arg_245_1:SetGaussion(false)
			end

			local var_248_15 = 2

			if var_248_14 <= arg_245_1.time_ and arg_245_1.time_ < var_248_14 + var_248_15 then
				local var_248_16 = (arg_245_1.time_ - var_248_14) / var_248_15
				local var_248_17 = Color.New(0, 0, 0)

				var_248_17.a = Mathf.Lerp(0, 1, var_248_16)
				arg_245_1.mask_.color = var_248_17
			end

			if arg_245_1.time_ >= var_248_14 + var_248_15 and arg_245_1.time_ < var_248_14 + var_248_15 + arg_248_0 then
				local var_248_18 = Color.New(0, 0, 0)

				var_248_18.a = 1
				arg_245_1.mask_.color = var_248_18
			end

			local var_248_19 = 2

			if var_248_19 < arg_245_1.time_ and arg_245_1.time_ <= var_248_19 + arg_248_0 then
				arg_245_1.mask_.enabled = true
				arg_245_1.mask_.raycastTarget = true

				arg_245_1:SetGaussion(false)
			end

			local var_248_20 = 2

			if var_248_19 <= arg_245_1.time_ and arg_245_1.time_ < var_248_19 + var_248_20 then
				local var_248_21 = (arg_245_1.time_ - var_248_19) / var_248_20
				local var_248_22 = Color.New(0, 0, 0)

				var_248_22.a = Mathf.Lerp(1, 0, var_248_21)
				arg_245_1.mask_.color = var_248_22
			end

			if arg_245_1.time_ >= var_248_19 + var_248_20 and arg_245_1.time_ < var_248_19 + var_248_20 + arg_248_0 then
				local var_248_23 = Color.New(0, 0, 0)
				local var_248_24 = 0

				arg_245_1.mask_.enabled = false
				var_248_23.a = var_248_24
				arg_245_1.mask_.color = var_248_23
			end

			local var_248_25 = arg_245_1.actors_["1066ui_story"].transform
			local var_248_26 = 2

			if var_248_26 < arg_245_1.time_ and arg_245_1.time_ <= var_248_26 + arg_248_0 then
				arg_245_1.var_.moveOldPos1066ui_story = var_248_25.localPosition
			end

			local var_248_27 = 0.001

			if var_248_26 <= arg_245_1.time_ and arg_245_1.time_ < var_248_26 + var_248_27 then
				local var_248_28 = (arg_245_1.time_ - var_248_26) / var_248_27
				local var_248_29 = Vector3.New(0, 100, 0)

				var_248_25.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1066ui_story, var_248_29, var_248_28)

				local var_248_30 = manager.ui.mainCamera.transform.position - var_248_25.position

				var_248_25.forward = Vector3.New(var_248_30.x, var_248_30.y, var_248_30.z)

				local var_248_31 = var_248_25.localEulerAngles

				var_248_31.z = 0
				var_248_31.x = 0
				var_248_25.localEulerAngles = var_248_31
			end

			if arg_245_1.time_ >= var_248_26 + var_248_27 and arg_245_1.time_ < var_248_26 + var_248_27 + arg_248_0 then
				var_248_25.localPosition = Vector3.New(0, 100, 0)

				local var_248_32 = manager.ui.mainCamera.transform.position - var_248_25.position

				var_248_25.forward = Vector3.New(var_248_32.x, var_248_32.y, var_248_32.z)

				local var_248_33 = var_248_25.localEulerAngles

				var_248_33.z = 0
				var_248_33.x = 0
				var_248_25.localEulerAngles = var_248_33
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_34 = 4
			local var_248_35 = 1.2

			if var_248_34 < arg_245_1.time_ and arg_245_1.time_ <= var_248_34 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_36 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_36:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_37 = arg_245_1:GetWordFromCfg(1106606061)
				local var_248_38 = arg_245_1:FormatText(var_248_37.content)

				arg_245_1.text_.text = var_248_38

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_39 = 48
				local var_248_40 = utf8.len(var_248_38)
				local var_248_41 = var_248_39 <= 0 and var_248_35 or var_248_35 * (var_248_40 / var_248_39)

				if var_248_41 > 0 and var_248_35 < var_248_41 then
					arg_245_1.talkMaxDuration = var_248_41
					var_248_34 = var_248_34 + 0.3

					if var_248_41 + var_248_34 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_41 + var_248_34
					end
				end

				arg_245_1.text_.text = var_248_38
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_42 = var_248_34 + 0.3
			local var_248_43 = math.max(var_248_35, arg_245_1.talkMaxDuration)

			if var_248_42 <= arg_245_1.time_ and arg_245_1.time_ < var_248_42 + var_248_43 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_42) / var_248_43

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_42 + var_248_43 and arg_245_1.time_ < var_248_42 + var_248_43 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play1106606062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1106606062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1106606063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.75

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_2 = arg_251_1:GetWordFromCfg(1106606062)
				local var_254_3 = arg_251_1:FormatText(var_254_2.content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 30
				local var_254_5 = utf8.len(var_254_3)
				local var_254_6 = var_254_4 <= 0 and var_254_1 or var_254_1 * (var_254_5 / var_254_4)

				if var_254_6 > 0 and var_254_1 < var_254_6 then
					arg_251_1.talkMaxDuration = var_254_6

					if var_254_6 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_7 and arg_251_1.time_ < var_254_0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1106606063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1106606063
		arg_255_1.duration_ = 2

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1106606064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1066ui_story"].transform
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.var_.moveOldPos1066ui_story = var_258_0.localPosition
			end

			local var_258_2 = 0.001

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2
				local var_258_4 = Vector3.New(0, -0.77, -6.1)

				var_258_0.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1066ui_story, var_258_4, var_258_3)

				local var_258_5 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_5.x, var_258_5.y, var_258_5.z)

				local var_258_6 = var_258_0.localEulerAngles

				var_258_6.z = 0
				var_258_6.x = 0
				var_258_0.localEulerAngles = var_258_6
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 then
				var_258_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_258_7 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_7.x, var_258_7.y, var_258_7.z)

				local var_258_8 = var_258_0.localEulerAngles

				var_258_8.z = 0
				var_258_8.x = 0
				var_258_0.localEulerAngles = var_258_8
			end

			local var_258_9 = arg_255_1.actors_["1066ui_story"]
			local var_258_10 = 0

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 and not isNil(var_258_9) and arg_255_1.var_.characterEffect1066ui_story == nil then
				arg_255_1.var_.characterEffect1066ui_story = var_258_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_11 = 0.200000002980232

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_11 and not isNil(var_258_9) then
				local var_258_12 = (arg_255_1.time_ - var_258_10) / var_258_11

				if arg_255_1.var_.characterEffect1066ui_story and not isNil(var_258_9) then
					arg_255_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_10 + var_258_11 and arg_255_1.time_ < var_258_10 + var_258_11 + arg_258_0 and not isNil(var_258_9) and arg_255_1.var_.characterEffect1066ui_story then
				arg_255_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_258_13 = 0

			if var_258_13 < arg_255_1.time_ and arg_255_1.time_ <= var_258_13 + arg_258_0 then
				arg_255_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			local var_258_14 = 0

			if var_258_14 < arg_255_1.time_ and arg_255_1.time_ <= var_258_14 + arg_258_0 then
				arg_255_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_258_15 = 0
			local var_258_16 = 0.1

			if var_258_15 < arg_255_1.time_ and arg_255_1.time_ <= var_258_15 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_17 = arg_255_1:FormatText(StoryNameCfg[32].name)

				arg_255_1.leftNameTxt_.text = var_258_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_18 = arg_255_1:GetWordFromCfg(1106606063)
				local var_258_19 = arg_255_1:FormatText(var_258_18.content)

				arg_255_1.text_.text = var_258_19

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_20 = 4
				local var_258_21 = utf8.len(var_258_19)
				local var_258_22 = var_258_20 <= 0 and var_258_16 or var_258_16 * (var_258_21 / var_258_20)

				if var_258_22 > 0 and var_258_16 < var_258_22 then
					arg_255_1.talkMaxDuration = var_258_22

					if var_258_22 + var_258_15 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_22 + var_258_15
					end
				end

				arg_255_1.text_.text = var_258_19
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606063", "story_v_side_new_1106606.awb") ~= 0 then
					local var_258_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606063", "story_v_side_new_1106606.awb") / 1000

					if var_258_23 + var_258_15 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_23 + var_258_15
					end

					if var_258_18.prefab_name ~= "" and arg_255_1.actors_[var_258_18.prefab_name] ~= nil then
						local var_258_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_18.prefab_name].transform, "story_v_side_new_1106606", "1106606063", "story_v_side_new_1106606.awb")

						arg_255_1:RecordAudio("1106606063", var_258_24)
						arg_255_1:RecordAudio("1106606063", var_258_24)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606063", "story_v_side_new_1106606.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606063", "story_v_side_new_1106606.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_25 = math.max(var_258_16, arg_255_1.talkMaxDuration)

			if var_258_15 <= arg_255_1.time_ and arg_255_1.time_ < var_258_15 + var_258_25 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_15) / var_258_25

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_15 + var_258_25 and arg_255_1.time_ < var_258_15 + var_258_25 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play1106606064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1106606064
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1106606065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1066ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1066ui_story == nil then
				arg_259_1.var_.characterEffect1066ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect1066ui_story and not isNil(var_262_0) then
					local var_262_4 = Mathf.Lerp(0, 0.5, var_262_3)

					arg_259_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1066ui_story.fillRatio = var_262_4
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1066ui_story then
				local var_262_5 = 0.5

				arg_259_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1066ui_story.fillRatio = var_262_5
			end

			local var_262_6 = 0
			local var_262_7 = 0.25

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_8 = arg_259_1:FormatText(StoryNameCfg[7].name)

				arg_259_1.leftNameTxt_.text = var_262_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_9 = arg_259_1:GetWordFromCfg(1106606064)
				local var_262_10 = arg_259_1:FormatText(var_262_9.content)

				arg_259_1.text_.text = var_262_10

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 10
				local var_262_12 = utf8.len(var_262_10)
				local var_262_13 = var_262_11 <= 0 and var_262_7 or var_262_7 * (var_262_12 / var_262_11)

				if var_262_13 > 0 and var_262_7 < var_262_13 then
					arg_259_1.talkMaxDuration = var_262_13

					if var_262_13 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_13 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_10
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_14 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_14 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_14

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_14 and arg_259_1.time_ < var_262_6 + var_262_14 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1106606065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1106606065
		arg_263_1.duration_ = 2.6

		local var_263_0 = {
			zh = 2.6,
			ja = 1.999999999999
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
				arg_263_0:Play1106606066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1066ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1066ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(0, -0.77, -6.1)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1066ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = arg_263_1.actors_["1066ui_story"]
			local var_266_10 = 0

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1066ui_story == nil then
				arg_263_1.var_.characterEffect1066ui_story = var_266_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_11 = 0.200000002980232

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_11 and not isNil(var_266_9) then
				local var_266_12 = (arg_263_1.time_ - var_266_10) / var_266_11

				if arg_263_1.var_.characterEffect1066ui_story and not isNil(var_266_9) then
					arg_263_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_10 + var_266_11 and arg_263_1.time_ < var_266_10 + var_266_11 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1066ui_story then
				arg_263_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_266_13 = 0

			if var_266_13 < arg_263_1.time_ and arg_263_1.time_ <= var_266_13 + arg_266_0 then
				arg_263_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_266_14 = 0
			local var_266_15 = 0.25

			if var_266_14 < arg_263_1.time_ and arg_263_1.time_ <= var_266_14 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_16 = arg_263_1:FormatText(StoryNameCfg[32].name)

				arg_263_1.leftNameTxt_.text = var_266_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_17 = arg_263_1:GetWordFromCfg(1106606065)
				local var_266_18 = arg_263_1:FormatText(var_266_17.content)

				arg_263_1.text_.text = var_266_18

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_19 = 10
				local var_266_20 = utf8.len(var_266_18)
				local var_266_21 = var_266_19 <= 0 and var_266_15 or var_266_15 * (var_266_20 / var_266_19)

				if var_266_21 > 0 and var_266_15 < var_266_21 then
					arg_263_1.talkMaxDuration = var_266_21

					if var_266_21 + var_266_14 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_21 + var_266_14
					end
				end

				arg_263_1.text_.text = var_266_18
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606065", "story_v_side_new_1106606.awb") ~= 0 then
					local var_266_22 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606065", "story_v_side_new_1106606.awb") / 1000

					if var_266_22 + var_266_14 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_22 + var_266_14
					end

					if var_266_17.prefab_name ~= "" and arg_263_1.actors_[var_266_17.prefab_name] ~= nil then
						local var_266_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_17.prefab_name].transform, "story_v_side_new_1106606", "1106606065", "story_v_side_new_1106606.awb")

						arg_263_1:RecordAudio("1106606065", var_266_23)
						arg_263_1:RecordAudio("1106606065", var_266_23)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606065", "story_v_side_new_1106606.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606065", "story_v_side_new_1106606.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_24 = math.max(var_266_15, arg_263_1.talkMaxDuration)

			if var_266_14 <= arg_263_1.time_ and arg_263_1.time_ < var_266_14 + var_266_24 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_14) / var_266_24

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_14 + var_266_24 and arg_263_1.time_ < var_266_14 + var_266_24 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play1106606066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1106606066
		arg_267_1.duration_ = 1

		SetActive(arg_267_1.tipsGo_, true)

		arg_267_1.tipsText_.text = StoryTipsCfg[106601].name

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"

			SetActive(arg_267_1.choicesGo_, true)

			for iter_268_0, iter_268_1 in ipairs(arg_267_1.choices_) do
				local var_268_0 = iter_268_0 <= 2

				SetActive(iter_268_1.go, var_268_0)
			end

			arg_267_1.choices_[1].txt.text = arg_267_1:FormatText(StoryChoiceCfg[558].name)
			arg_267_1.choices_[2].txt.text = arg_267_1:FormatText(StoryChoiceCfg[559].name)
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				PlayerAction.UseStoryTrigger(1066014, 210660106, 1106606066, 1)
				arg_267_0:Play1106606067(arg_267_1)
			end

			if arg_269_0 == 2 then
				arg_267_0:Play1106606069(arg_267_1)
			end

			arg_267_1:RecordChoiceLog(1106606066, 558, 559)
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1066ui_story"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1066ui_story == nil then
				arg_267_1.var_.characterEffect1066ui_story = var_270_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.characterEffect1066ui_story and not isNil(var_270_0) then
					local var_270_4 = Mathf.Lerp(0, 0.5, var_270_3)

					arg_267_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1066ui_story.fillRatio = var_270_4
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1066ui_story then
				local var_270_5 = 0.5

				arg_267_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1066ui_story.fillRatio = var_270_5
			end

			local var_270_6 = 0

			if var_270_6 < arg_267_1.time_ and arg_267_1.time_ <= var_270_6 + arg_270_0 then
				arg_267_1.allBtn_.enabled = false
			end

			local var_270_7 = 0.5

			if arg_267_1.time_ >= var_270_6 + var_270_7 and arg_267_1.time_ < var_270_6 + var_270_7 + arg_270_0 then
				arg_267_1.allBtn_.enabled = true
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1106606067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1106606067
		arg_271_1.duration_ = 3.3

		local var_271_0 = {
			zh = 3.3,
			ja = 2.166
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1106606068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1066ui_story"].transform
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.var_.moveOldPos1066ui_story = var_274_0.localPosition
			end

			local var_274_2 = 0.001

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2
				local var_274_4 = Vector3.New(0, -0.77, -6.1)

				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1066ui_story, var_274_4, var_274_3)

				local var_274_5 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_5.x, var_274_5.y, var_274_5.z)

				local var_274_6 = var_274_0.localEulerAngles

				var_274_6.z = 0
				var_274_6.x = 0
				var_274_0.localEulerAngles = var_274_6
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_274_7 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_7.x, var_274_7.y, var_274_7.z)

				local var_274_8 = var_274_0.localEulerAngles

				var_274_8.z = 0
				var_274_8.x = 0
				var_274_0.localEulerAngles = var_274_8
			end

			local var_274_9 = arg_271_1.actors_["1066ui_story"]
			local var_274_10 = 0

			if var_274_10 < arg_271_1.time_ and arg_271_1.time_ <= var_274_10 + arg_274_0 and not isNil(var_274_9) and arg_271_1.var_.characterEffect1066ui_story == nil then
				arg_271_1.var_.characterEffect1066ui_story = var_274_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_11 = 0.200000002980232

			if var_274_10 <= arg_271_1.time_ and arg_271_1.time_ < var_274_10 + var_274_11 and not isNil(var_274_9) then
				local var_274_12 = (arg_271_1.time_ - var_274_10) / var_274_11

				if arg_271_1.var_.characterEffect1066ui_story and not isNil(var_274_9) then
					arg_271_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_10 + var_274_11 and arg_271_1.time_ < var_274_10 + var_274_11 + arg_274_0 and not isNil(var_274_9) and arg_271_1.var_.characterEffect1066ui_story then
				arg_271_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_274_13 = 0

			if var_274_13 < arg_271_1.time_ and arg_271_1.time_ <= var_274_13 + arg_274_0 then
				arg_271_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_2")
			end

			local var_274_14 = 0

			if var_274_14 < arg_271_1.time_ and arg_271_1.time_ <= var_274_14 + arg_274_0 then
				arg_271_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_274_15 = 0
			local var_274_16 = 0.35

			if var_274_15 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_17 = arg_271_1:FormatText(StoryNameCfg[32].name)

				arg_271_1.leftNameTxt_.text = var_274_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_18 = arg_271_1:GetWordFromCfg(1106606067)
				local var_274_19 = arg_271_1:FormatText(var_274_18.content)

				arg_271_1.text_.text = var_274_19

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_20 = 14
				local var_274_21 = utf8.len(var_274_19)
				local var_274_22 = var_274_20 <= 0 and var_274_16 or var_274_16 * (var_274_21 / var_274_20)

				if var_274_22 > 0 and var_274_16 < var_274_22 then
					arg_271_1.talkMaxDuration = var_274_22

					if var_274_22 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_22 + var_274_15
					end
				end

				arg_271_1.text_.text = var_274_19
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606067", "story_v_side_new_1106606.awb") ~= 0 then
					local var_274_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606067", "story_v_side_new_1106606.awb") / 1000

					if var_274_23 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_23 + var_274_15
					end

					if var_274_18.prefab_name ~= "" and arg_271_1.actors_[var_274_18.prefab_name] ~= nil then
						local var_274_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_18.prefab_name].transform, "story_v_side_new_1106606", "1106606067", "story_v_side_new_1106606.awb")

						arg_271_1:RecordAudio("1106606067", var_274_24)
						arg_271_1:RecordAudio("1106606067", var_274_24)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606067", "story_v_side_new_1106606.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606067", "story_v_side_new_1106606.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_25 = math.max(var_274_16, arg_271_1.talkMaxDuration)

			if var_274_15 <= arg_271_1.time_ and arg_271_1.time_ < var_274_15 + var_274_25 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_15) / var_274_25

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_15 + var_274_25 and arg_271_1.time_ < var_274_15 + var_274_25 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play1106606068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1106606068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1106606071(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1066ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1066ui_story == nil then
				arg_275_1.var_.characterEffect1066ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect1066ui_story and not isNil(var_278_0) then
					local var_278_4 = Mathf.Lerp(0, 0.5, var_278_3)

					arg_275_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1066ui_story.fillRatio = var_278_4
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1066ui_story then
				local var_278_5 = 0.5

				arg_275_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1066ui_story.fillRatio = var_278_5
			end

			local var_278_6 = 0
			local var_278_7 = 0.25

			if var_278_6 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_8 = arg_275_1:FormatText(StoryNameCfg[7].name)

				arg_275_1.leftNameTxt_.text = var_278_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_9 = arg_275_1:GetWordFromCfg(1106606068)
				local var_278_10 = arg_275_1:FormatText(var_278_9.content)

				arg_275_1.text_.text = var_278_10

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_11 = 10
				local var_278_12 = utf8.len(var_278_10)
				local var_278_13 = var_278_11 <= 0 and var_278_7 or var_278_7 * (var_278_12 / var_278_11)

				if var_278_13 > 0 and var_278_7 < var_278_13 then
					arg_275_1.talkMaxDuration = var_278_13

					if var_278_13 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_13 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_10
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_14 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_14 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_14

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_14 and arg_275_1.time_ < var_278_6 + var_278_14 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1106606071 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1106606071
		arg_279_1.duration_ = 5.37

		local var_279_0 = {
			zh = 5.366,
			ja = 3.533
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1106606072(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1066ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos1066ui_story = var_282_0.localPosition
			end

			local var_282_2 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2
				local var_282_4 = Vector3.New(0, -0.77, -6.1)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1066ui_story, var_282_4, var_282_3)

				local var_282_5 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_5.x, var_282_5.y, var_282_5.z)

				local var_282_6 = var_282_0.localEulerAngles

				var_282_6.z = 0
				var_282_6.x = 0
				var_282_0.localEulerAngles = var_282_6
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_282_7 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_7.x, var_282_7.y, var_282_7.z)

				local var_282_8 = var_282_0.localEulerAngles

				var_282_8.z = 0
				var_282_8.x = 0
				var_282_0.localEulerAngles = var_282_8
			end

			local var_282_9 = arg_279_1.actors_["1066ui_story"]
			local var_282_10 = 0

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect1066ui_story == nil then
				arg_279_1.var_.characterEffect1066ui_story = var_282_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_11 = 0.200000002980232

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_11 and not isNil(var_282_9) then
				local var_282_12 = (arg_279_1.time_ - var_282_10) / var_282_11

				if arg_279_1.var_.characterEffect1066ui_story and not isNil(var_282_9) then
					arg_279_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_10 + var_282_11 and arg_279_1.time_ < var_282_10 + var_282_11 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect1066ui_story then
				arg_279_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_282_13 = 0

			if var_282_13 < arg_279_1.time_ and arg_279_1.time_ <= var_282_13 + arg_282_0 then
				arg_279_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			local var_282_14 = 0

			if var_282_14 < arg_279_1.time_ and arg_279_1.time_ <= var_282_14 + arg_282_0 then
				arg_279_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_282_15 = 0
			local var_282_16 = 0.725

			if var_282_15 < arg_279_1.time_ and arg_279_1.time_ <= var_282_15 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_17 = arg_279_1:FormatText(StoryNameCfg[32].name)

				arg_279_1.leftNameTxt_.text = var_282_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_18 = arg_279_1:GetWordFromCfg(1106606071)
				local var_282_19 = arg_279_1:FormatText(var_282_18.content)

				arg_279_1.text_.text = var_282_19

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_20 = 29
				local var_282_21 = utf8.len(var_282_19)
				local var_282_22 = var_282_20 <= 0 and var_282_16 or var_282_16 * (var_282_21 / var_282_20)

				if var_282_22 > 0 and var_282_16 < var_282_22 then
					arg_279_1.talkMaxDuration = var_282_22

					if var_282_22 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_22 + var_282_15
					end
				end

				arg_279_1.text_.text = var_282_19
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606071", "story_v_side_new_1106606.awb") ~= 0 then
					local var_282_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606071", "story_v_side_new_1106606.awb") / 1000

					if var_282_23 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_23 + var_282_15
					end

					if var_282_18.prefab_name ~= "" and arg_279_1.actors_[var_282_18.prefab_name] ~= nil then
						local var_282_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_18.prefab_name].transform, "story_v_side_new_1106606", "1106606071", "story_v_side_new_1106606.awb")

						arg_279_1:RecordAudio("1106606071", var_282_24)
						arg_279_1:RecordAudio("1106606071", var_282_24)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606071", "story_v_side_new_1106606.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606071", "story_v_side_new_1106606.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_25 = math.max(var_282_16, arg_279_1.talkMaxDuration)

			if var_282_15 <= arg_279_1.time_ and arg_279_1.time_ < var_282_15 + var_282_25 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_15) / var_282_25

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_15 + var_282_25 and arg_279_1.time_ < var_282_15 + var_282_25 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play1106606072 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1106606072
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1106606073(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1066ui_story"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos1066ui_story = var_286_0.localPosition
			end

			local var_286_2 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2
				local var_286_4 = Vector3.New(0, 100, 0)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1066ui_story, var_286_4, var_286_3)

				local var_286_5 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_5.x, var_286_5.y, var_286_5.z)

				local var_286_6 = var_286_0.localEulerAngles

				var_286_6.z = 0
				var_286_6.x = 0
				var_286_0.localEulerAngles = var_286_6
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(0, 100, 0)

				local var_286_7 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_7.x, var_286_7.y, var_286_7.z)

				local var_286_8 = var_286_0.localEulerAngles

				var_286_8.z = 0
				var_286_8.x = 0
				var_286_0.localEulerAngles = var_286_8
			end

			local var_286_9 = arg_283_1.actors_["1066ui_story"]
			local var_286_10 = 0

			if var_286_10 < arg_283_1.time_ and arg_283_1.time_ <= var_286_10 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect1066ui_story == nil then
				arg_283_1.var_.characterEffect1066ui_story = var_286_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_11 = 0.200000002980232

			if var_286_10 <= arg_283_1.time_ and arg_283_1.time_ < var_286_10 + var_286_11 and not isNil(var_286_9) then
				local var_286_12 = (arg_283_1.time_ - var_286_10) / var_286_11

				if arg_283_1.var_.characterEffect1066ui_story and not isNil(var_286_9) then
					local var_286_13 = Mathf.Lerp(0, 0.5, var_286_12)

					arg_283_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1066ui_story.fillRatio = var_286_13
				end
			end

			if arg_283_1.time_ >= var_286_10 + var_286_11 and arg_283_1.time_ < var_286_10 + var_286_11 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect1066ui_story then
				local var_286_14 = 0.5

				arg_283_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1066ui_story.fillRatio = var_286_14
			end

			local var_286_15 = 0
			local var_286_16 = 1.5

			if var_286_15 < arg_283_1.time_ and arg_283_1.time_ <= var_286_15 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_17 = arg_283_1:GetWordFromCfg(1106606072)
				local var_286_18 = arg_283_1:FormatText(var_286_17.content)

				arg_283_1.text_.text = var_286_18

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_19 = 60
				local var_286_20 = utf8.len(var_286_18)
				local var_286_21 = var_286_19 <= 0 and var_286_16 or var_286_16 * (var_286_20 / var_286_19)

				if var_286_21 > 0 and var_286_16 < var_286_21 then
					arg_283_1.talkMaxDuration = var_286_21

					if var_286_21 + var_286_15 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_21 + var_286_15
					end
				end

				arg_283_1.text_.text = var_286_18
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_22 = math.max(var_286_16, arg_283_1.talkMaxDuration)

			if var_286_15 <= arg_283_1.time_ and arg_283_1.time_ < var_286_15 + var_286_22 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_15) / var_286_22

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_15 + var_286_22 and arg_283_1.time_ < var_286_15 + var_286_22 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play1106606073 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1106606073
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1106606074(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0
			local var_290_1 = 1.175

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_2 = arg_287_1:GetWordFromCfg(1106606073)
				local var_290_3 = arg_287_1:FormatText(var_290_2.content)

				arg_287_1.text_.text = var_290_3

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 47
				local var_290_5 = utf8.len(var_290_3)
				local var_290_6 = var_290_4 <= 0 and var_290_1 or var_290_1 * (var_290_5 / var_290_4)

				if var_290_6 > 0 and var_290_1 < var_290_6 then
					arg_287_1.talkMaxDuration = var_290_6

					if var_290_6 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_6 + var_290_0
					end
				end

				arg_287_1.text_.text = var_290_3
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_1, arg_287_1.talkMaxDuration)

			if var_290_0 <= arg_287_1.time_ and arg_287_1.time_ < var_290_0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_0 + var_290_7 and arg_287_1.time_ < var_290_0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1106606074 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1106606074
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1106606075(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 0.6

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_2 = arg_291_1:FormatText(StoryNameCfg[7].name)

				arg_291_1.leftNameTxt_.text = var_294_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_3 = arg_291_1:GetWordFromCfg(1106606074)
				local var_294_4 = arg_291_1:FormatText(var_294_3.content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 24
				local var_294_6 = utf8.len(var_294_4)
				local var_294_7 = var_294_5 <= 0 and var_294_1 or var_294_1 * (var_294_6 / var_294_5)

				if var_294_7 > 0 and var_294_1 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_8 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_8 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_8

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_8 and arg_291_1.time_ < var_294_0 + var_294_8 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1106606075 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1106606075
		arg_295_1.duration_ = 3.1

		local var_295_0 = {
			zh = 3.1,
			ja = 2.4
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1106606076(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1066ui_story"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos1066ui_story = var_298_0.localPosition
			end

			local var_298_2 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2
				local var_298_4 = Vector3.New(0, -0.77, -6.1)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1066ui_story, var_298_4, var_298_3)

				local var_298_5 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_5.x, var_298_5.y, var_298_5.z)

				local var_298_6 = var_298_0.localEulerAngles

				var_298_6.z = 0
				var_298_6.x = 0
				var_298_0.localEulerAngles = var_298_6
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_298_7 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_7.x, var_298_7.y, var_298_7.z)

				local var_298_8 = var_298_0.localEulerAngles

				var_298_8.z = 0
				var_298_8.x = 0
				var_298_0.localEulerAngles = var_298_8
			end

			local var_298_9 = arg_295_1.actors_["1066ui_story"]
			local var_298_10 = 0

			if var_298_10 < arg_295_1.time_ and arg_295_1.time_ <= var_298_10 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1066ui_story == nil then
				arg_295_1.var_.characterEffect1066ui_story = var_298_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_11 = 0.200000002980232

			if var_298_10 <= arg_295_1.time_ and arg_295_1.time_ < var_298_10 + var_298_11 and not isNil(var_298_9) then
				local var_298_12 = (arg_295_1.time_ - var_298_10) / var_298_11

				if arg_295_1.var_.characterEffect1066ui_story and not isNil(var_298_9) then
					arg_295_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= var_298_10 + var_298_11 and arg_295_1.time_ < var_298_10 + var_298_11 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1066ui_story then
				arg_295_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_298_13 = 0

			if var_298_13 < arg_295_1.time_ and arg_295_1.time_ <= var_298_13 + arg_298_0 then
				arg_295_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_298_14 = 0
			local var_298_15 = 0.4

			if var_298_14 < arg_295_1.time_ and arg_295_1.time_ <= var_298_14 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_16 = arg_295_1:FormatText(StoryNameCfg[32].name)

				arg_295_1.leftNameTxt_.text = var_298_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_17 = arg_295_1:GetWordFromCfg(1106606075)
				local var_298_18 = arg_295_1:FormatText(var_298_17.content)

				arg_295_1.text_.text = var_298_18

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_19 = 16
				local var_298_20 = utf8.len(var_298_18)
				local var_298_21 = var_298_19 <= 0 and var_298_15 or var_298_15 * (var_298_20 / var_298_19)

				if var_298_21 > 0 and var_298_15 < var_298_21 then
					arg_295_1.talkMaxDuration = var_298_21

					if var_298_21 + var_298_14 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_21 + var_298_14
					end
				end

				arg_295_1.text_.text = var_298_18
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606075", "story_v_side_new_1106606.awb") ~= 0 then
					local var_298_22 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606075", "story_v_side_new_1106606.awb") / 1000

					if var_298_22 + var_298_14 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_22 + var_298_14
					end

					if var_298_17.prefab_name ~= "" and arg_295_1.actors_[var_298_17.prefab_name] ~= nil then
						local var_298_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_17.prefab_name].transform, "story_v_side_new_1106606", "1106606075", "story_v_side_new_1106606.awb")

						arg_295_1:RecordAudio("1106606075", var_298_23)
						arg_295_1:RecordAudio("1106606075", var_298_23)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606075", "story_v_side_new_1106606.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606075", "story_v_side_new_1106606.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_24 = math.max(var_298_15, arg_295_1.talkMaxDuration)

			if var_298_14 <= arg_295_1.time_ and arg_295_1.time_ < var_298_14 + var_298_24 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_14) / var_298_24

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_14 + var_298_24 and arg_295_1.time_ < var_298_14 + var_298_24 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play1106606076 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1106606076
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1106606077(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1066ui_story"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1066ui_story == nil then
				arg_299_1.var_.characterEffect1066ui_story = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.characterEffect1066ui_story and not isNil(var_302_0) then
					local var_302_4 = Mathf.Lerp(0, 0.5, var_302_3)

					arg_299_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1066ui_story.fillRatio = var_302_4
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1066ui_story then
				local var_302_5 = 0.5

				arg_299_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1066ui_story.fillRatio = var_302_5
			end

			local var_302_6 = 0
			local var_302_7 = 0.6

			if var_302_6 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_8 = arg_299_1:FormatText(StoryNameCfg[7].name)

				arg_299_1.leftNameTxt_.text = var_302_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_9 = arg_299_1:GetWordFromCfg(1106606076)
				local var_302_10 = arg_299_1:FormatText(var_302_9.content)

				arg_299_1.text_.text = var_302_10

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_11 = 24
				local var_302_12 = utf8.len(var_302_10)
				local var_302_13 = var_302_11 <= 0 and var_302_7 or var_302_7 * (var_302_12 / var_302_11)

				if var_302_13 > 0 and var_302_7 < var_302_13 then
					arg_299_1.talkMaxDuration = var_302_13

					if var_302_13 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_13 + var_302_6
					end
				end

				arg_299_1.text_.text = var_302_10
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_14 = math.max(var_302_7, arg_299_1.talkMaxDuration)

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_14 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_6) / var_302_14

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_6 + var_302_14 and arg_299_1.time_ < var_302_6 + var_302_14 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1106606077 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1106606077
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1106606078(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_2")
			end

			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_306_2 = 0
			local var_306_3 = 0.575

			if var_306_2 < arg_303_1.time_ and arg_303_1.time_ <= var_306_2 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_4 = arg_303_1:GetWordFromCfg(1106606077)
				local var_306_5 = arg_303_1:FormatText(var_306_4.content)

				arg_303_1.text_.text = var_306_5

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_6 = 23
				local var_306_7 = utf8.len(var_306_5)
				local var_306_8 = var_306_6 <= 0 and var_306_3 or var_306_3 * (var_306_7 / var_306_6)

				if var_306_8 > 0 and var_306_3 < var_306_8 then
					arg_303_1.talkMaxDuration = var_306_8

					if var_306_8 + var_306_2 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_2
					end
				end

				arg_303_1.text_.text = var_306_5
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_9 = math.max(var_306_3, arg_303_1.talkMaxDuration)

			if var_306_2 <= arg_303_1.time_ and arg_303_1.time_ < var_306_2 + var_306_9 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_2) / var_306_9

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_2 + var_306_9 and arg_303_1.time_ < var_306_2 + var_306_9 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1106606078 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1106606078
		arg_307_1.duration_ = 5.13

		local var_307_0 = {
			zh = 3.6,
			ja = 5.133
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
				arg_307_0:Play1106606079(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1066ui_story"].transform
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.var_.moveOldPos1066ui_story = var_310_0.localPosition
			end

			local var_310_2 = 0.001

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2
				local var_310_4 = Vector3.New(0, -0.77, -6.1)

				var_310_0.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1066ui_story, var_310_4, var_310_3)

				local var_310_5 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_5.x, var_310_5.y, var_310_5.z)

				local var_310_6 = var_310_0.localEulerAngles

				var_310_6.z = 0
				var_310_6.x = 0
				var_310_0.localEulerAngles = var_310_6
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 then
				var_310_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_310_7 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_7.x, var_310_7.y, var_310_7.z)

				local var_310_8 = var_310_0.localEulerAngles

				var_310_8.z = 0
				var_310_8.x = 0
				var_310_0.localEulerAngles = var_310_8
			end

			local var_310_9 = arg_307_1.actors_["1066ui_story"]
			local var_310_10 = 0

			if var_310_10 < arg_307_1.time_ and arg_307_1.time_ <= var_310_10 + arg_310_0 and not isNil(var_310_9) and arg_307_1.var_.characterEffect1066ui_story == nil then
				arg_307_1.var_.characterEffect1066ui_story = var_310_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_11 = 0.200000002980232

			if var_310_10 <= arg_307_1.time_ and arg_307_1.time_ < var_310_10 + var_310_11 and not isNil(var_310_9) then
				local var_310_12 = (arg_307_1.time_ - var_310_10) / var_310_11

				if arg_307_1.var_.characterEffect1066ui_story and not isNil(var_310_9) then
					arg_307_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= var_310_10 + var_310_11 and arg_307_1.time_ < var_310_10 + var_310_11 + arg_310_0 and not isNil(var_310_9) and arg_307_1.var_.characterEffect1066ui_story then
				arg_307_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_310_13 = 0

			if var_310_13 < arg_307_1.time_ and arg_307_1.time_ <= var_310_13 + arg_310_0 then
				arg_307_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			local var_310_14 = 0

			if var_310_14 < arg_307_1.time_ and arg_307_1.time_ <= var_310_14 + arg_310_0 then
				arg_307_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_310_15 = 0
			local var_310_16 = 0.4

			if var_310_15 < arg_307_1.time_ and arg_307_1.time_ <= var_310_15 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_17 = arg_307_1:FormatText(StoryNameCfg[32].name)

				arg_307_1.leftNameTxt_.text = var_310_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_18 = arg_307_1:GetWordFromCfg(1106606078)
				local var_310_19 = arg_307_1:FormatText(var_310_18.content)

				arg_307_1.text_.text = var_310_19

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_20 = 16
				local var_310_21 = utf8.len(var_310_19)
				local var_310_22 = var_310_20 <= 0 and var_310_16 or var_310_16 * (var_310_21 / var_310_20)

				if var_310_22 > 0 and var_310_16 < var_310_22 then
					arg_307_1.talkMaxDuration = var_310_22

					if var_310_22 + var_310_15 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_22 + var_310_15
					end
				end

				arg_307_1.text_.text = var_310_19
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606078", "story_v_side_new_1106606.awb") ~= 0 then
					local var_310_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606078", "story_v_side_new_1106606.awb") / 1000

					if var_310_23 + var_310_15 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_23 + var_310_15
					end

					if var_310_18.prefab_name ~= "" and arg_307_1.actors_[var_310_18.prefab_name] ~= nil then
						local var_310_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_18.prefab_name].transform, "story_v_side_new_1106606", "1106606078", "story_v_side_new_1106606.awb")

						arg_307_1:RecordAudio("1106606078", var_310_24)
						arg_307_1:RecordAudio("1106606078", var_310_24)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606078", "story_v_side_new_1106606.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606078", "story_v_side_new_1106606.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_25 = math.max(var_310_16, arg_307_1.talkMaxDuration)

			if var_310_15 <= arg_307_1.time_ and arg_307_1.time_ < var_310_15 + var_310_25 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_15) / var_310_25

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_15 + var_310_25 and arg_307_1.time_ < var_310_15 + var_310_25 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play1106606079 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1106606079
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1106606080(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1066ui_story"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1066ui_story == nil then
				arg_311_1.var_.characterEffect1066ui_story = var_314_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.characterEffect1066ui_story and not isNil(var_314_0) then
					local var_314_4 = Mathf.Lerp(0, 0.5, var_314_3)

					arg_311_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1066ui_story.fillRatio = var_314_4
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1066ui_story then
				local var_314_5 = 0.5

				arg_311_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1066ui_story.fillRatio = var_314_5
			end

			local var_314_6 = 0
			local var_314_7 = 0.225

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

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_9 = arg_311_1:GetWordFromCfg(1106606079)
				local var_314_10 = arg_311_1:FormatText(var_314_9.content)

				arg_311_1.text_.text = var_314_10

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_11 = 9
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
	Play1106606080 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1106606080
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1106606081(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 0.075

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_2 = arg_315_1:FormatText(StoryNameCfg[7].name)

				arg_315_1.leftNameTxt_.text = var_318_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_3 = arg_315_1:GetWordFromCfg(1106606080)
				local var_318_4 = arg_315_1:FormatText(var_318_3.content)

				arg_315_1.text_.text = var_318_4

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 3
				local var_318_6 = utf8.len(var_318_4)
				local var_318_7 = var_318_5 <= 0 and var_318_1 or var_318_1 * (var_318_6 / var_318_5)

				if var_318_7 > 0 and var_318_1 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_0
					end
				end

				arg_315_1.text_.text = var_318_4
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_8 = math.max(var_318_1, arg_315_1.talkMaxDuration)

			if var_318_0 <= arg_315_1.time_ and arg_315_1.time_ < var_318_0 + var_318_8 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_0) / var_318_8

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_0 + var_318_8 and arg_315_1.time_ < var_318_0 + var_318_8 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1106606081 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1106606081
		arg_319_1.duration_ = 2.3

		local var_319_0 = {
			zh = 2.3,
			ja = 2.166
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1106606082(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1066ui_story"].transform
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.var_.moveOldPos1066ui_story = var_322_0.localPosition
			end

			local var_322_2 = 0.001

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2
				local var_322_4 = Vector3.New(0, -0.77, -6.1)

				var_322_0.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1066ui_story, var_322_4, var_322_3)

				local var_322_5 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_5.x, var_322_5.y, var_322_5.z)

				local var_322_6 = var_322_0.localEulerAngles

				var_322_6.z = 0
				var_322_6.x = 0
				var_322_0.localEulerAngles = var_322_6
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 then
				var_322_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_322_7 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_7.x, var_322_7.y, var_322_7.z)

				local var_322_8 = var_322_0.localEulerAngles

				var_322_8.z = 0
				var_322_8.x = 0
				var_322_0.localEulerAngles = var_322_8
			end

			local var_322_9 = arg_319_1.actors_["1066ui_story"]
			local var_322_10 = 0

			if var_322_10 < arg_319_1.time_ and arg_319_1.time_ <= var_322_10 + arg_322_0 and not isNil(var_322_9) and arg_319_1.var_.characterEffect1066ui_story == nil then
				arg_319_1.var_.characterEffect1066ui_story = var_322_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_11 = 0.200000002980232

			if var_322_10 <= arg_319_1.time_ and arg_319_1.time_ < var_322_10 + var_322_11 and not isNil(var_322_9) then
				local var_322_12 = (arg_319_1.time_ - var_322_10) / var_322_11

				if arg_319_1.var_.characterEffect1066ui_story and not isNil(var_322_9) then
					arg_319_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= var_322_10 + var_322_11 and arg_319_1.time_ < var_322_10 + var_322_11 + arg_322_0 and not isNil(var_322_9) and arg_319_1.var_.characterEffect1066ui_story then
				arg_319_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_322_13 = 0

			if var_322_13 < arg_319_1.time_ and arg_319_1.time_ <= var_322_13 + arg_322_0 then
				arg_319_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_2")
			end

			local var_322_14 = 0

			if var_322_14 < arg_319_1.time_ and arg_319_1.time_ <= var_322_14 + arg_322_0 then
				arg_319_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_322_15 = 0
			local var_322_16 = 0.175

			if var_322_15 < arg_319_1.time_ and arg_319_1.time_ <= var_322_15 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_17 = arg_319_1:FormatText(StoryNameCfg[32].name)

				arg_319_1.leftNameTxt_.text = var_322_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_18 = arg_319_1:GetWordFromCfg(1106606081)
				local var_322_19 = arg_319_1:FormatText(var_322_18.content)

				arg_319_1.text_.text = var_322_19

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_20 = 7
				local var_322_21 = utf8.len(var_322_19)
				local var_322_22 = var_322_20 <= 0 and var_322_16 or var_322_16 * (var_322_21 / var_322_20)

				if var_322_22 > 0 and var_322_16 < var_322_22 then
					arg_319_1.talkMaxDuration = var_322_22

					if var_322_22 + var_322_15 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_22 + var_322_15
					end
				end

				arg_319_1.text_.text = var_322_19
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606081", "story_v_side_new_1106606.awb") ~= 0 then
					local var_322_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606081", "story_v_side_new_1106606.awb") / 1000

					if var_322_23 + var_322_15 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_23 + var_322_15
					end

					if var_322_18.prefab_name ~= "" and arg_319_1.actors_[var_322_18.prefab_name] ~= nil then
						local var_322_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_18.prefab_name].transform, "story_v_side_new_1106606", "1106606081", "story_v_side_new_1106606.awb")

						arg_319_1:RecordAudio("1106606081", var_322_24)
						arg_319_1:RecordAudio("1106606081", var_322_24)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606081", "story_v_side_new_1106606.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606081", "story_v_side_new_1106606.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_25 = math.max(var_322_16, arg_319_1.talkMaxDuration)

			if var_322_15 <= arg_319_1.time_ and arg_319_1.time_ < var_322_15 + var_322_25 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_15) / var_322_25

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_15 + var_322_25 and arg_319_1.time_ < var_322_15 + var_322_25 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play1106606082 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1106606082
		arg_323_1.duration_ = 9

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1106606083(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = "STblack"

			if arg_323_1.bgs_[var_326_0] == nil then
				local var_326_1 = Object.Instantiate(arg_323_1.paintGo_)

				var_326_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_326_0)
				var_326_1.name = var_326_0
				var_326_1.transform.parent = arg_323_1.stage_.transform
				var_326_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_323_1.bgs_[var_326_0] = var_326_1
			end

			local var_326_2 = 2

			if var_326_2 < arg_323_1.time_ and arg_323_1.time_ <= var_326_2 + arg_326_0 then
				local var_326_3 = manager.ui.mainCamera.transform.localPosition
				local var_326_4 = Vector3.New(0, 0, 10) + Vector3.New(var_326_3.x, var_326_3.y, 0)
				local var_326_5 = arg_323_1.bgs_.STblack

				var_326_5.transform.localPosition = var_326_4
				var_326_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_326_6 = var_326_5:GetComponent("SpriteRenderer")

				if var_326_6 and var_326_6.sprite then
					local var_326_7 = (var_326_5.transform.localPosition - var_326_3).z
					local var_326_8 = manager.ui.mainCameraCom_
					local var_326_9 = 2 * var_326_7 * Mathf.Tan(var_326_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_326_10 = var_326_9 * var_326_8.aspect
					local var_326_11 = var_326_6.sprite.bounds.size.x
					local var_326_12 = var_326_6.sprite.bounds.size.y
					local var_326_13 = var_326_10 / var_326_11
					local var_326_14 = var_326_9 / var_326_12
					local var_326_15 = var_326_14 < var_326_13 and var_326_13 or var_326_14

					var_326_5.transform.localScale = Vector3.New(var_326_15, var_326_15, 0)
				end

				for iter_326_0, iter_326_1 in pairs(arg_323_1.bgs_) do
					if iter_326_0 ~= "STblack" then
						iter_326_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_326_16 = arg_323_1.actors_["1066ui_story"].transform
			local var_326_17 = 2

			if var_326_17 < arg_323_1.time_ and arg_323_1.time_ <= var_326_17 + arg_326_0 then
				arg_323_1.var_.moveOldPos1066ui_story = var_326_16.localPosition
			end

			local var_326_18 = 0.001

			if var_326_17 <= arg_323_1.time_ and arg_323_1.time_ < var_326_17 + var_326_18 then
				local var_326_19 = (arg_323_1.time_ - var_326_17) / var_326_18
				local var_326_20 = Vector3.New(0, 100, 0)

				var_326_16.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1066ui_story, var_326_20, var_326_19)

				local var_326_21 = manager.ui.mainCamera.transform.position - var_326_16.position

				var_326_16.forward = Vector3.New(var_326_21.x, var_326_21.y, var_326_21.z)

				local var_326_22 = var_326_16.localEulerAngles

				var_326_22.z = 0
				var_326_22.x = 0
				var_326_16.localEulerAngles = var_326_22
			end

			if arg_323_1.time_ >= var_326_17 + var_326_18 and arg_323_1.time_ < var_326_17 + var_326_18 + arg_326_0 then
				var_326_16.localPosition = Vector3.New(0, 100, 0)

				local var_326_23 = manager.ui.mainCamera.transform.position - var_326_16.position

				var_326_16.forward = Vector3.New(var_326_23.x, var_326_23.y, var_326_23.z)

				local var_326_24 = var_326_16.localEulerAngles

				var_326_24.z = 0
				var_326_24.x = 0
				var_326_16.localEulerAngles = var_326_24
			end

			local var_326_25 = 0
			local var_326_26 = 0.533333333333333

			if var_326_25 < arg_323_1.time_ and arg_323_1.time_ <= var_326_25 + arg_326_0 then
				local var_326_27 = "play"
				local var_326_28 = "music"

				arg_323_1:AudioAction(var_326_27, var_326_28, "ui_battle", "ui_battle_stopbgm", "")

				local var_326_29 = ""
				local var_326_30 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_326_30 ~= "" then
					if arg_323_1.bgmTxt_.text ~= var_326_30 and arg_323_1.bgmTxt_.text ~= "" then
						if arg_323_1.bgmTxt2_.text ~= "" then
							arg_323_1.bgmTxt_.text = arg_323_1.bgmTxt2_.text
						end

						arg_323_1.bgmTxt2_.text = var_326_30

						arg_323_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_323_1.bgmTxt_.text = var_326_30
						arg_323_1.bgmTxt2_.text = var_326_30
					end

					if arg_323_1.bgmTimer then
						arg_323_1.bgmTimer:Stop()

						arg_323_1.bgmTimer = nil
					end

					if arg_323_1.settingData.show_music_name == 1 then
						arg_323_1.musicController:SetSelectedState("show")
						arg_323_1.musicAnimator_:Play("open", 0, 0)

						if arg_323_1.settingData.music_time ~= 0 then
							arg_323_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_323_1.settingData.music_time), function()
								if arg_323_1 == nil or isNil(arg_323_1.bgmTxt_) then
									return
								end

								arg_323_1.musicController:SetSelectedState("hide")
								arg_323_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_326_31 = 0

			if var_326_31 < arg_323_1.time_ and arg_323_1.time_ <= var_326_31 + arg_326_0 then
				arg_323_1.mask_.enabled = true
				arg_323_1.mask_.raycastTarget = true

				arg_323_1:SetGaussion(false)
			end

			local var_326_32 = 2

			if var_326_31 <= arg_323_1.time_ and arg_323_1.time_ < var_326_31 + var_326_32 then
				local var_326_33 = (arg_323_1.time_ - var_326_31) / var_326_32
				local var_326_34 = Color.New(0, 0, 0)

				var_326_34.a = Mathf.Lerp(0, 1, var_326_33)
				arg_323_1.mask_.color = var_326_34
			end

			if arg_323_1.time_ >= var_326_31 + var_326_32 and arg_323_1.time_ < var_326_31 + var_326_32 + arg_326_0 then
				local var_326_35 = Color.New(0, 0, 0)

				var_326_35.a = 1
				arg_323_1.mask_.color = var_326_35
			end

			local var_326_36 = 2

			if var_326_36 < arg_323_1.time_ and arg_323_1.time_ <= var_326_36 + arg_326_0 then
				arg_323_1.mask_.enabled = true
				arg_323_1.mask_.raycastTarget = true

				arg_323_1:SetGaussion(false)
			end

			local var_326_37 = 2

			if var_326_36 <= arg_323_1.time_ and arg_323_1.time_ < var_326_36 + var_326_37 then
				local var_326_38 = (arg_323_1.time_ - var_326_36) / var_326_37
				local var_326_39 = Color.New(0, 0, 0)

				var_326_39.a = Mathf.Lerp(1, 0, var_326_38)
				arg_323_1.mask_.color = var_326_39
			end

			if arg_323_1.time_ >= var_326_36 + var_326_37 and arg_323_1.time_ < var_326_36 + var_326_37 + arg_326_0 then
				local var_326_40 = Color.New(0, 0, 0)
				local var_326_41 = 0

				arg_323_1.mask_.enabled = false
				var_326_40.a = var_326_41
				arg_323_1.mask_.color = var_326_40
			end

			if arg_323_1.frameCnt_ <= 1 then
				arg_323_1.dialog_:SetActive(false)
			end

			local var_326_42 = 4
			local var_326_43 = 0.875

			if var_326_42 < arg_323_1.time_ and arg_323_1.time_ <= var_326_42 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0

				arg_323_1.dialog_:SetActive(true)

				arg_323_1.dialogCg_.alpha = 0

				local var_326_44 = LeanTween.value(arg_323_1.dialog_, 0, 1, 0.3)

				var_326_44:setOnUpdate(LuaHelper.FloatAction(function(arg_328_0)
					arg_323_1.dialogCg_.alpha = arg_328_0
				end))
				var_326_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_323_1.dialog_)
					var_326_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_323_1.duration_ = arg_323_1.duration_ + 0.3

				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_45 = arg_323_1:GetWordFromCfg(1106606082)
				local var_326_46 = arg_323_1:FormatText(var_326_45.content)

				arg_323_1.text_.text = var_326_46

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_47 = 35
				local var_326_48 = utf8.len(var_326_46)
				local var_326_49 = var_326_47 <= 0 and var_326_43 or var_326_43 * (var_326_48 / var_326_47)

				if var_326_49 > 0 and var_326_43 < var_326_49 then
					arg_323_1.talkMaxDuration = var_326_49
					var_326_42 = var_326_42 + 0.3

					if var_326_49 + var_326_42 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_49 + var_326_42
					end
				end

				arg_323_1.text_.text = var_326_46
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_50 = var_326_42 + 0.3
			local var_326_51 = math.max(var_326_43, arg_323_1.talkMaxDuration)

			if var_326_50 <= arg_323_1.time_ and arg_323_1.time_ < var_326_50 + var_326_51 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_50) / var_326_51

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_50 + var_326_51 and arg_323_1.time_ < var_326_50 + var_326_51 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play1106606083 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1106606083
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1106606084(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 0.85

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_2 = arg_330_1:GetWordFromCfg(1106606083)
				local var_333_3 = arg_330_1:FormatText(var_333_2.content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 34
				local var_333_5 = utf8.len(var_333_3)
				local var_333_6 = var_333_4 <= 0 and var_333_1 or var_333_1 * (var_333_5 / var_333_4)

				if var_333_6 > 0 and var_333_1 < var_333_6 then
					arg_330_1.talkMaxDuration = var_333_6

					if var_333_6 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_6 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_7 and arg_330_1.time_ < var_333_0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1106606084 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1106606084
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1106606085(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.6

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_2 = arg_334_1:GetWordFromCfg(1106606084)
				local var_337_3 = arg_334_1:FormatText(var_337_2.content)

				arg_334_1.text_.text = var_337_3

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_4 = 24
				local var_337_5 = utf8.len(var_337_3)
				local var_337_6 = var_337_4 <= 0 and var_337_1 or var_337_1 * (var_337_5 / var_337_4)

				if var_337_6 > 0 and var_337_1 < var_337_6 then
					arg_334_1.talkMaxDuration = var_337_6

					if var_337_6 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_6 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_3
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_7 and arg_334_1.time_ < var_337_0 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play1106606085 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1106606085
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1106606086(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0
			local var_341_1 = 0.925

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_2 = arg_338_1:GetWordFromCfg(1106606085)
				local var_341_3 = arg_338_1:FormatText(var_341_2.content)

				arg_338_1.text_.text = var_341_3

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_4 = 37
				local var_341_5 = utf8.len(var_341_3)
				local var_341_6 = var_341_4 <= 0 and var_341_1 or var_341_1 * (var_341_5 / var_341_4)

				if var_341_6 > 0 and var_341_1 < var_341_6 then
					arg_338_1.talkMaxDuration = var_341_6

					if var_341_6 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_6 + var_341_0
					end
				end

				arg_338_1.text_.text = var_341_3
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_7 = math.max(var_341_1, arg_338_1.talkMaxDuration)

			if var_341_0 <= arg_338_1.time_ and arg_338_1.time_ < var_341_0 + var_341_7 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_0) / var_341_7

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_0 + var_341_7 and arg_338_1.time_ < var_341_0 + var_341_7 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play1106606086 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1106606086
		arg_342_1.duration_ = 9.02

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1106606087(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = "R6602"

			if arg_342_1.bgs_[var_345_0] == nil then
				local var_345_1 = Object.Instantiate(arg_342_1.paintGo_)

				var_345_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_345_0)
				var_345_1.name = var_345_0
				var_345_1.transform.parent = arg_342_1.stage_.transform
				var_345_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_342_1.bgs_[var_345_0] = var_345_1
			end

			local var_345_2 = 2

			if var_345_2 < arg_342_1.time_ and arg_342_1.time_ <= var_345_2 + arg_345_0 then
				local var_345_3 = manager.ui.mainCamera.transform.localPosition
				local var_345_4 = Vector3.New(0, 0, 10) + Vector3.New(var_345_3.x, var_345_3.y, 0)
				local var_345_5 = arg_342_1.bgs_.R6602

				var_345_5.transform.localPosition = var_345_4
				var_345_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_345_6 = var_345_5:GetComponent("SpriteRenderer")

				if var_345_6 and var_345_6.sprite then
					local var_345_7 = (var_345_5.transform.localPosition - var_345_3).z
					local var_345_8 = manager.ui.mainCameraCom_
					local var_345_9 = 2 * var_345_7 * Mathf.Tan(var_345_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_345_10 = var_345_9 * var_345_8.aspect
					local var_345_11 = var_345_6.sprite.bounds.size.x
					local var_345_12 = var_345_6.sprite.bounds.size.y
					local var_345_13 = var_345_10 / var_345_11
					local var_345_14 = var_345_9 / var_345_12
					local var_345_15 = var_345_14 < var_345_13 and var_345_13 or var_345_14

					var_345_5.transform.localScale = Vector3.New(var_345_15, var_345_15, 0)
				end

				for iter_345_0, iter_345_1 in pairs(arg_342_1.bgs_) do
					if iter_345_0 ~= "R6602" then
						iter_345_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_345_16 = 0

			if var_345_16 < arg_342_1.time_ and arg_342_1.time_ <= var_345_16 + arg_345_0 then
				arg_342_1.mask_.enabled = true
				arg_342_1.mask_.raycastTarget = true

				arg_342_1:SetGaussion(false)
			end

			local var_345_17 = 2

			if var_345_16 <= arg_342_1.time_ and arg_342_1.time_ < var_345_16 + var_345_17 then
				local var_345_18 = (arg_342_1.time_ - var_345_16) / var_345_17
				local var_345_19 = Color.New(0, 0, 0)

				var_345_19.a = Mathf.Lerp(0, 1, var_345_18)
				arg_342_1.mask_.color = var_345_19
			end

			if arg_342_1.time_ >= var_345_16 + var_345_17 and arg_342_1.time_ < var_345_16 + var_345_17 + arg_345_0 then
				local var_345_20 = Color.New(0, 0, 0)

				var_345_20.a = 1
				arg_342_1.mask_.color = var_345_20
			end

			local var_345_21 = 2

			if var_345_21 < arg_342_1.time_ and arg_342_1.time_ <= var_345_21 + arg_345_0 then
				arg_342_1.mask_.enabled = true
				arg_342_1.mask_.raycastTarget = true

				arg_342_1:SetGaussion(false)
			end

			local var_345_22 = 2

			if var_345_21 <= arg_342_1.time_ and arg_342_1.time_ < var_345_21 + var_345_22 then
				local var_345_23 = (arg_342_1.time_ - var_345_21) / var_345_22
				local var_345_24 = Color.New(0, 0, 0)

				var_345_24.a = Mathf.Lerp(1, 0, var_345_23)
				arg_342_1.mask_.color = var_345_24
			end

			if arg_342_1.time_ >= var_345_21 + var_345_22 and arg_342_1.time_ < var_345_21 + var_345_22 + arg_345_0 then
				local var_345_25 = Color.New(0, 0, 0)
				local var_345_26 = 0

				arg_342_1.mask_.enabled = false
				var_345_25.a = var_345_26
				arg_342_1.mask_.color = var_345_25
			end

			local var_345_27 = 0
			local var_345_28 = 0.533333333333333

			if var_345_27 < arg_342_1.time_ and arg_342_1.time_ <= var_345_27 + arg_345_0 then
				local var_345_29 = "play"
				local var_345_30 = "music"

				arg_342_1:AudioAction(var_345_29, var_345_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_345_31 = ""
				local var_345_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_345_32 ~= "" then
					if arg_342_1.bgmTxt_.text ~= var_345_32 and arg_342_1.bgmTxt_.text ~= "" then
						if arg_342_1.bgmTxt2_.text ~= "" then
							arg_342_1.bgmTxt_.text = arg_342_1.bgmTxt2_.text
						end

						arg_342_1.bgmTxt2_.text = var_345_32

						arg_342_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_342_1.bgmTxt_.text = var_345_32
						arg_342_1.bgmTxt2_.text = var_345_32
					end

					if arg_342_1.bgmTimer then
						arg_342_1.bgmTimer:Stop()

						arg_342_1.bgmTimer = nil
					end

					if arg_342_1.settingData.show_music_name == 1 then
						arg_342_1.musicController:SetSelectedState("show")
						arg_342_1.musicAnimator_:Play("open", 0, 0)

						if arg_342_1.settingData.music_time ~= 0 then
							arg_342_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_342_1.settingData.music_time), function()
								if arg_342_1 == nil or isNil(arg_342_1.bgmTxt_) then
									return
								end

								arg_342_1.musicController:SetSelectedState("hide")
								arg_342_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_345_33 = 0.633333333333333
			local var_345_34 = 1

			if var_345_33 < arg_342_1.time_ and arg_342_1.time_ <= var_345_33 + arg_345_0 then
				local var_345_35 = "play"
				local var_345_36 = "music"

				arg_342_1:AudioAction(var_345_35, var_345_36, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_345_37 = ""
				local var_345_38 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_345_38 ~= "" then
					if arg_342_1.bgmTxt_.text ~= var_345_38 and arg_342_1.bgmTxt_.text ~= "" then
						if arg_342_1.bgmTxt2_.text ~= "" then
							arg_342_1.bgmTxt_.text = arg_342_1.bgmTxt2_.text
						end

						arg_342_1.bgmTxt2_.text = var_345_38

						arg_342_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_342_1.bgmTxt_.text = var_345_38
						arg_342_1.bgmTxt2_.text = var_345_38
					end

					if arg_342_1.bgmTimer then
						arg_342_1.bgmTimer:Stop()

						arg_342_1.bgmTimer = nil
					end

					if arg_342_1.settingData.show_music_name == 1 then
						arg_342_1.musicController:SetSelectedState("show")
						arg_342_1.musicAnimator_:Play("open", 0, 0)

						if arg_342_1.settingData.music_time ~= 0 then
							arg_342_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_342_1.settingData.music_time), function()
								if arg_342_1 == nil or isNil(arg_342_1.bgmTxt_) then
									return
								end

								arg_342_1.musicController:SetSelectedState("hide")
								arg_342_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_345_39 = arg_342_1.bgs_.R6602.transform
			local var_345_40 = 2

			if var_345_40 < arg_342_1.time_ and arg_342_1.time_ <= var_345_40 + arg_345_0 then
				arg_342_1.var_.moveOldPosR6602 = var_345_39.localPosition
			end

			local var_345_41 = 0.001

			if var_345_40 <= arg_342_1.time_ and arg_342_1.time_ < var_345_40 + var_345_41 then
				local var_345_42 = (arg_342_1.time_ - var_345_40) / var_345_41
				local var_345_43 = Vector3.New(0.83, 0.32, 6.22)

				var_345_39.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPosR6602, var_345_43, var_345_42)
			end

			if arg_342_1.time_ >= var_345_40 + var_345_41 and arg_342_1.time_ < var_345_40 + var_345_41 + arg_345_0 then
				var_345_39.localPosition = Vector3.New(0.83, 0.32, 6.22)
			end

			local var_345_44 = arg_342_1.bgs_.R6602.transform
			local var_345_45 = 2.01666666666667

			if var_345_45 < arg_342_1.time_ and arg_342_1.time_ <= var_345_45 + arg_345_0 then
				arg_342_1.var_.moveOldPosR6602 = var_345_44.localPosition
			end

			local var_345_46 = 7

			if var_345_45 <= arg_342_1.time_ and arg_342_1.time_ < var_345_45 + var_345_46 then
				local var_345_47 = (arg_342_1.time_ - var_345_45) / var_345_46
				local var_345_48 = Vector3.New(0.83, 1.13, 6.22)

				var_345_44.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPosR6602, var_345_48, var_345_47)
			end

			if arg_342_1.time_ >= var_345_45 + var_345_46 and arg_342_1.time_ < var_345_45 + var_345_46 + arg_345_0 then
				var_345_44.localPosition = Vector3.New(0.83, 1.13, 6.22)
			end

			local var_345_49 = 4

			if var_345_49 < arg_342_1.time_ and arg_342_1.time_ <= var_345_49 + arg_345_0 then
				arg_342_1.allBtn_.enabled = false
			end

			local var_345_50 = 3.3

			if arg_342_1.time_ >= var_345_49 + var_345_50 and arg_342_1.time_ < var_345_49 + var_345_50 + arg_345_0 then
				arg_342_1.allBtn_.enabled = true
			end

			if arg_342_1.frameCnt_ <= 1 then
				arg_342_1.dialog_:SetActive(false)
			end

			local var_345_51 = 4
			local var_345_52 = 1.65

			if var_345_51 < arg_342_1.time_ and arg_342_1.time_ <= var_345_51 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0

				arg_342_1.dialog_:SetActive(true)

				arg_342_1.dialogCg_.alpha = 0

				local var_345_53 = LeanTween.value(arg_342_1.dialog_, 0, 1, 0.3)

				var_345_53:setOnUpdate(LuaHelper.FloatAction(function(arg_348_0)
					arg_342_1.dialogCg_.alpha = arg_348_0
				end))
				var_345_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_342_1.dialog_)
					var_345_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_342_1.duration_ = arg_342_1.duration_ + 0.3

				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_54 = arg_342_1:GetWordFromCfg(1106606086)
				local var_345_55 = arg_342_1:FormatText(var_345_54.content)

				arg_342_1.text_.text = var_345_55

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_56 = 66
				local var_345_57 = utf8.len(var_345_55)
				local var_345_58 = var_345_56 <= 0 and var_345_52 or var_345_52 * (var_345_57 / var_345_56)

				if var_345_58 > 0 and var_345_52 < var_345_58 then
					arg_342_1.talkMaxDuration = var_345_58
					var_345_51 = var_345_51 + 0.3

					if var_345_58 + var_345_51 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_58 + var_345_51
					end
				end

				arg_342_1.text_.text = var_345_55
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_59 = var_345_51 + 0.3
			local var_345_60 = math.max(var_345_52, arg_342_1.talkMaxDuration)

			if var_345_59 <= arg_342_1.time_ and arg_342_1.time_ < var_345_59 + var_345_60 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_59) / var_345_60

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_59 + var_345_60 and arg_342_1.time_ < var_345_59 + var_345_60 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R6602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R6602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 7,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play1106606087 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1106606087
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1106606088(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 0.1

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_2 = arg_350_1:FormatText(StoryNameCfg[7].name)

				arg_350_1.leftNameTxt_.text = var_353_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_3 = arg_350_1:GetWordFromCfg(1106606087)
				local var_353_4 = arg_350_1:FormatText(var_353_3.content)

				arg_350_1.text_.text = var_353_4

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 4
				local var_353_6 = utf8.len(var_353_4)
				local var_353_7 = var_353_5 <= 0 and var_353_1 or var_353_1 * (var_353_6 / var_353_5)

				if var_353_7 > 0 and var_353_1 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_0
					end
				end

				arg_350_1.text_.text = var_353_4
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_8 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_8 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_8

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_8 and arg_350_1.time_ < var_353_0 + var_353_8 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play1106606088 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1106606088
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1106606089(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0
			local var_357_1 = 1.375

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_2 = arg_354_1:GetWordFromCfg(1106606088)
				local var_357_3 = arg_354_1:FormatText(var_357_2.content)

				arg_354_1.text_.text = var_357_3

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_4 = 55
				local var_357_5 = utf8.len(var_357_3)
				local var_357_6 = var_357_4 <= 0 and var_357_1 or var_357_1 * (var_357_5 / var_357_4)

				if var_357_6 > 0 and var_357_1 < var_357_6 then
					arg_354_1.talkMaxDuration = var_357_6

					if var_357_6 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_6 + var_357_0
					end
				end

				arg_354_1.text_.text = var_357_3
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_7 = math.max(var_357_1, arg_354_1.talkMaxDuration)

			if var_357_0 <= arg_354_1.time_ and arg_354_1.time_ < var_357_0 + var_357_7 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_0) / var_357_7

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_0 + var_357_7 and arg_354_1.time_ < var_357_0 + var_357_7 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play1106606089 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1106606089
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1106606090(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 0.8

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_2 = arg_358_1:FormatText(StoryNameCfg[7].name)

				arg_358_1.leftNameTxt_.text = var_361_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:GetWordFromCfg(1106606089)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 32
				local var_361_6 = utf8.len(var_361_4)
				local var_361_7 = var_361_5 <= 0 and var_361_1 or var_361_1 * (var_361_6 / var_361_5)

				if var_361_7 > 0 and var_361_1 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_0
					end
				end

				arg_358_1.text_.text = var_361_4
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_8 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_8 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_8

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_8 and arg_358_1.time_ < var_361_0 + var_361_8 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play1106606090 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1106606090
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1106606091(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0
			local var_365_1 = 1.725

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, false)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_2 = arg_362_1:GetWordFromCfg(1106606090)
				local var_365_3 = arg_362_1:FormatText(var_365_2.content)

				arg_362_1.text_.text = var_365_3

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_4 = 69
				local var_365_5 = utf8.len(var_365_3)
				local var_365_6 = var_365_4 <= 0 and var_365_1 or var_365_1 * (var_365_5 / var_365_4)

				if var_365_6 > 0 and var_365_1 < var_365_6 then
					arg_362_1.talkMaxDuration = var_365_6

					if var_365_6 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_6 + var_365_0
					end
				end

				arg_362_1.text_.text = var_365_3
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_7 = math.max(var_365_1, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_7 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_0) / var_365_7

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_7 and arg_362_1.time_ < var_365_0 + var_365_7 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1106606091 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1106606091
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1106606092(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0
			local var_369_1 = 0.7

			if var_369_0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_2 = arg_366_1:GetWordFromCfg(1106606091)
				local var_369_3 = arg_366_1:FormatText(var_369_2.content)

				arg_366_1.text_.text = var_369_3

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_4 = 28
				local var_369_5 = utf8.len(var_369_3)
				local var_369_6 = var_369_4 <= 0 and var_369_1 or var_369_1 * (var_369_5 / var_369_4)

				if var_369_6 > 0 and var_369_1 < var_369_6 then
					arg_366_1.talkMaxDuration = var_369_6

					if var_369_6 + var_369_0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_6 + var_369_0
					end
				end

				arg_366_1.text_.text = var_369_3
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_7 = math.max(var_369_1, arg_366_1.talkMaxDuration)

			if var_369_0 <= arg_366_1.time_ and arg_366_1.time_ < var_369_0 + var_369_7 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_0) / var_369_7

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_0 + var_369_7 and arg_366_1.time_ < var_369_0 + var_369_7 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1106606092 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1106606092
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1106606093(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0
			local var_373_1 = 0.275

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_2 = arg_370_1:FormatText(StoryNameCfg[7].name)

				arg_370_1.leftNameTxt_.text = var_373_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_3 = arg_370_1:GetWordFromCfg(1106606092)
				local var_373_4 = arg_370_1:FormatText(var_373_3.content)

				arg_370_1.text_.text = var_373_4

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 11
				local var_373_6 = utf8.len(var_373_4)
				local var_373_7 = var_373_5 <= 0 and var_373_1 or var_373_1 * (var_373_6 / var_373_5)

				if var_373_7 > 0 and var_373_1 < var_373_7 then
					arg_370_1.talkMaxDuration = var_373_7

					if var_373_7 + var_373_0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_7 + var_373_0
					end
				end

				arg_370_1.text_.text = var_373_4
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_8 = math.max(var_373_1, arg_370_1.talkMaxDuration)

			if var_373_0 <= arg_370_1.time_ and arg_370_1.time_ < var_373_0 + var_373_8 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_0) / var_373_8

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_0 + var_373_8 and arg_370_1.time_ < var_373_0 + var_373_8 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play1106606093 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1106606093
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1106606094(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0
			local var_377_1 = 0.8

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_2 = arg_374_1:GetWordFromCfg(1106606093)
				local var_377_3 = arg_374_1:FormatText(var_377_2.content)

				arg_374_1.text_.text = var_377_3

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 32
				local var_377_5 = utf8.len(var_377_3)
				local var_377_6 = var_377_4 <= 0 and var_377_1 or var_377_1 * (var_377_5 / var_377_4)

				if var_377_6 > 0 and var_377_1 < var_377_6 then
					arg_374_1.talkMaxDuration = var_377_6

					if var_377_6 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_6 + var_377_0
					end
				end

				arg_374_1.text_.text = var_377_3
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_7 = math.max(var_377_1, arg_374_1.talkMaxDuration)

			if var_377_0 <= arg_374_1.time_ and arg_374_1.time_ < var_377_0 + var_377_7 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_0) / var_377_7

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_0 + var_377_7 and arg_374_1.time_ < var_377_0 + var_377_7 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play1106606094 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1106606094
		arg_378_1.duration_ = 3.4

		local var_378_0 = {
			zh = 2.933,
			ja = 3.4
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1106606095(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0
			local var_381_1 = 0.225

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_2 = arg_378_1:FormatText(StoryNameCfg[32].name)

				arg_378_1.leftNameTxt_.text = var_381_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_3 = arg_378_1:GetWordFromCfg(1106606094)
				local var_381_4 = arg_378_1:FormatText(var_381_3.content)

				arg_378_1.text_.text = var_381_4

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 9
				local var_381_6 = utf8.len(var_381_4)
				local var_381_7 = var_381_5 <= 0 and var_381_1 or var_381_1 * (var_381_6 / var_381_5)

				if var_381_7 > 0 and var_381_1 < var_381_7 then
					arg_378_1.talkMaxDuration = var_381_7

					if var_381_7 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_0
					end
				end

				arg_378_1.text_.text = var_381_4
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606094", "story_v_side_new_1106606.awb") ~= 0 then
					local var_381_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606094", "story_v_side_new_1106606.awb") / 1000

					if var_381_8 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_8 + var_381_0
					end

					if var_381_3.prefab_name ~= "" and arg_378_1.actors_[var_381_3.prefab_name] ~= nil then
						local var_381_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_3.prefab_name].transform, "story_v_side_new_1106606", "1106606094", "story_v_side_new_1106606.awb")

						arg_378_1:RecordAudio("1106606094", var_381_9)
						arg_378_1:RecordAudio("1106606094", var_381_9)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606094", "story_v_side_new_1106606.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606094", "story_v_side_new_1106606.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_10 = math.max(var_381_1, arg_378_1.talkMaxDuration)

			if var_381_0 <= arg_378_1.time_ and arg_378_1.time_ < var_381_0 + var_381_10 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_0) / var_381_10

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_0 + var_381_10 and arg_378_1.time_ < var_381_0 + var_381_10 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1106606095 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1106606095
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1106606096(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0
			local var_385_1 = 0.275

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_2 = arg_382_1:FormatText(StoryNameCfg[7].name)

				arg_382_1.leftNameTxt_.text = var_385_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_3 = arg_382_1:GetWordFromCfg(1106606095)
				local var_385_4 = arg_382_1:FormatText(var_385_3.content)

				arg_382_1.text_.text = var_385_4

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 11
				local var_385_6 = utf8.len(var_385_4)
				local var_385_7 = var_385_5 <= 0 and var_385_1 or var_385_1 * (var_385_6 / var_385_5)

				if var_385_7 > 0 and var_385_1 < var_385_7 then
					arg_382_1.talkMaxDuration = var_385_7

					if var_385_7 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_7 + var_385_0
					end
				end

				arg_382_1.text_.text = var_385_4
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_8 = math.max(var_385_1, arg_382_1.talkMaxDuration)

			if var_385_0 <= arg_382_1.time_ and arg_382_1.time_ < var_385_0 + var_385_8 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_0) / var_385_8

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_0 + var_385_8 and arg_382_1.time_ < var_385_0 + var_385_8 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play1106606096 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1106606096
		arg_386_1.duration_ = 4

		local var_386_0 = {
			zh = 4,
			ja = 2.333
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1106606097(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0
			local var_389_1 = 0.325

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_2 = arg_386_1:FormatText(StoryNameCfg[32].name)

				arg_386_1.leftNameTxt_.text = var_389_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_3 = arg_386_1:GetWordFromCfg(1106606096)
				local var_389_4 = arg_386_1:FormatText(var_389_3.content)

				arg_386_1.text_.text = var_389_4

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 13
				local var_389_6 = utf8.len(var_389_4)
				local var_389_7 = var_389_5 <= 0 and var_389_1 or var_389_1 * (var_389_6 / var_389_5)

				if var_389_7 > 0 and var_389_1 < var_389_7 then
					arg_386_1.talkMaxDuration = var_389_7

					if var_389_7 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_7 + var_389_0
					end
				end

				arg_386_1.text_.text = var_389_4
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606096", "story_v_side_new_1106606.awb") ~= 0 then
					local var_389_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606096", "story_v_side_new_1106606.awb") / 1000

					if var_389_8 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_8 + var_389_0
					end

					if var_389_3.prefab_name ~= "" and arg_386_1.actors_[var_389_3.prefab_name] ~= nil then
						local var_389_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_3.prefab_name].transform, "story_v_side_new_1106606", "1106606096", "story_v_side_new_1106606.awb")

						arg_386_1:RecordAudio("1106606096", var_389_9)
						arg_386_1:RecordAudio("1106606096", var_389_9)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606096", "story_v_side_new_1106606.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606096", "story_v_side_new_1106606.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_10 = math.max(var_389_1, arg_386_1.talkMaxDuration)

			if var_389_0 <= arg_386_1.time_ and arg_386_1.time_ < var_389_0 + var_389_10 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_0) / var_389_10

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_0 + var_389_10 and arg_386_1.time_ < var_389_0 + var_389_10 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play1106606097 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1106606097
		arg_390_1.duration_ = 3.27

		local var_390_0 = {
			zh = 2.5,
			ja = 3.266
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1106606098(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0
			local var_393_1 = 0.2

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_2 = arg_390_1:FormatText(StoryNameCfg[32].name)

				arg_390_1.leftNameTxt_.text = var_393_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_3 = arg_390_1:GetWordFromCfg(1106606097)
				local var_393_4 = arg_390_1:FormatText(var_393_3.content)

				arg_390_1.text_.text = var_393_4

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_5 = 8
				local var_393_6 = utf8.len(var_393_4)
				local var_393_7 = var_393_5 <= 0 and var_393_1 or var_393_1 * (var_393_6 / var_393_5)

				if var_393_7 > 0 and var_393_1 < var_393_7 then
					arg_390_1.talkMaxDuration = var_393_7

					if var_393_7 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_7 + var_393_0
					end
				end

				arg_390_1.text_.text = var_393_4
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606097", "story_v_side_new_1106606.awb") ~= 0 then
					local var_393_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606097", "story_v_side_new_1106606.awb") / 1000

					if var_393_8 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_8 + var_393_0
					end

					if var_393_3.prefab_name ~= "" and arg_390_1.actors_[var_393_3.prefab_name] ~= nil then
						local var_393_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_3.prefab_name].transform, "story_v_side_new_1106606", "1106606097", "story_v_side_new_1106606.awb")

						arg_390_1:RecordAudio("1106606097", var_393_9)
						arg_390_1:RecordAudio("1106606097", var_393_9)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606097", "story_v_side_new_1106606.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606097", "story_v_side_new_1106606.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_10 = math.max(var_393_1, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_10 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_0) / var_393_10

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_10 and arg_390_1.time_ < var_393_0 + var_393_10 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play1106606098 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1106606098
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1106606099(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0
			local var_397_1 = 0.4

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_2 = arg_394_1:FormatText(StoryNameCfg[7].name)

				arg_394_1.leftNameTxt_.text = var_397_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_3 = arg_394_1:GetWordFromCfg(1106606098)
				local var_397_4 = arg_394_1:FormatText(var_397_3.content)

				arg_394_1.text_.text = var_397_4

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_5 = 16
				local var_397_6 = utf8.len(var_397_4)
				local var_397_7 = var_397_5 <= 0 and var_397_1 or var_397_1 * (var_397_6 / var_397_5)

				if var_397_7 > 0 and var_397_1 < var_397_7 then
					arg_394_1.talkMaxDuration = var_397_7

					if var_397_7 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_7 + var_397_0
					end
				end

				arg_394_1.text_.text = var_397_4
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_8 = math.max(var_397_1, arg_394_1.talkMaxDuration)

			if var_397_0 <= arg_394_1.time_ and arg_394_1.time_ < var_397_0 + var_397_8 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_0) / var_397_8

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_0 + var_397_8 and arg_394_1.time_ < var_397_0 + var_397_8 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1106606099 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1106606099
		arg_398_1.duration_ = 3.37

		local var_398_0 = {
			zh = 3.366,
			ja = 2.733
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1106606100(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 0.15

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_2 = arg_398_1:FormatText(StoryNameCfg[32].name)

				arg_398_1.leftNameTxt_.text = var_401_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_3 = arg_398_1:GetWordFromCfg(1106606099)
				local var_401_4 = arg_398_1:FormatText(var_401_3.content)

				arg_398_1.text_.text = var_401_4

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 6
				local var_401_6 = utf8.len(var_401_4)
				local var_401_7 = var_401_5 <= 0 and var_401_1 or var_401_1 * (var_401_6 / var_401_5)

				if var_401_7 > 0 and var_401_1 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_4
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606099", "story_v_side_new_1106606.awb") ~= 0 then
					local var_401_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606099", "story_v_side_new_1106606.awb") / 1000

					if var_401_8 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_8 + var_401_0
					end

					if var_401_3.prefab_name ~= "" and arg_398_1.actors_[var_401_3.prefab_name] ~= nil then
						local var_401_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_3.prefab_name].transform, "story_v_side_new_1106606", "1106606099", "story_v_side_new_1106606.awb")

						arg_398_1:RecordAudio("1106606099", var_401_9)
						arg_398_1:RecordAudio("1106606099", var_401_9)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606099", "story_v_side_new_1106606.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606099", "story_v_side_new_1106606.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_10 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_10 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_10

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_10 and arg_398_1.time_ < var_401_0 + var_401_10 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1106606100 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1106606100
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1106606101(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0
			local var_405_1 = 0.15

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_2 = arg_402_1:FormatText(StoryNameCfg[7].name)

				arg_402_1.leftNameTxt_.text = var_405_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_3 = arg_402_1:GetWordFromCfg(1106606100)
				local var_405_4 = arg_402_1:FormatText(var_405_3.content)

				arg_402_1.text_.text = var_405_4

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 6
				local var_405_6 = utf8.len(var_405_4)
				local var_405_7 = var_405_5 <= 0 and var_405_1 or var_405_1 * (var_405_6 / var_405_5)

				if var_405_7 > 0 and var_405_1 < var_405_7 then
					arg_402_1.talkMaxDuration = var_405_7

					if var_405_7 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_7 + var_405_0
					end
				end

				arg_402_1.text_.text = var_405_4
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_8 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_8 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_8

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_8 and arg_402_1.time_ < var_405_0 + var_405_8 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1106606101 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1106606101
		arg_406_1.duration_ = 1

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"

			SetActive(arg_406_1.choicesGo_, true)

			for iter_407_0, iter_407_1 in ipairs(arg_406_1.choices_) do
				local var_407_0 = iter_407_0 <= 2

				SetActive(iter_407_1.go, var_407_0)
			end

			arg_406_1.choices_[1].txt.text = arg_406_1:FormatText(StoryChoiceCfg[560].name)
			arg_406_1.choices_[2].txt.text = arg_406_1:FormatText(StoryChoiceCfg[561].name)
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1106606102(arg_406_1)
			end

			if arg_408_0 == 2 then
				arg_406_0:Play1106606104(arg_406_1)
			end

			arg_406_1:RecordChoiceLog(1106606101, 560, 561)
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0

			if var_409_0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_0 + arg_409_0 then
				arg_406_1.allBtn_.enabled = false
			end

			local var_409_1 = 0.5

			if arg_406_1.time_ >= var_409_0 + var_409_1 and arg_406_1.time_ < var_409_0 + var_409_1 + arg_409_0 then
				arg_406_1.allBtn_.enabled = true
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play1106606102 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1106606102
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1106606103(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0
			local var_413_1 = 0.625

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_2 = arg_410_1:GetWordFromCfg(1106606102)
				local var_413_3 = arg_410_1:FormatText(var_413_2.content)

				arg_410_1.text_.text = var_413_3

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_4 = 25
				local var_413_5 = utf8.len(var_413_3)
				local var_413_6 = var_413_4 <= 0 and var_413_1 or var_413_1 * (var_413_5 / var_413_4)

				if var_413_6 > 0 and var_413_1 < var_413_6 then
					arg_410_1.talkMaxDuration = var_413_6

					if var_413_6 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_6 + var_413_0
					end
				end

				arg_410_1.text_.text = var_413_3
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_7 = math.max(var_413_1, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_7 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_0) / var_413_7

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_7 and arg_410_1.time_ < var_413_0 + var_413_7 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play1106606103 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1106606103
		arg_414_1.duration_ = 4.03

		local var_414_0 = {
			zh = 4.033,
			ja = 2.866
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1106606106(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 0.275

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_2 = arg_414_1:FormatText(StoryNameCfg[32].name)

				arg_414_1.leftNameTxt_.text = var_417_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_3 = arg_414_1:GetWordFromCfg(1106606103)
				local var_417_4 = arg_414_1:FormatText(var_417_3.content)

				arg_414_1.text_.text = var_417_4

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_5 = 11
				local var_417_6 = utf8.len(var_417_4)
				local var_417_7 = var_417_5 <= 0 and var_417_1 or var_417_1 * (var_417_6 / var_417_5)

				if var_417_7 > 0 and var_417_1 < var_417_7 then
					arg_414_1.talkMaxDuration = var_417_7

					if var_417_7 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_7 + var_417_0
					end
				end

				arg_414_1.text_.text = var_417_4
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606103", "story_v_side_new_1106606.awb") ~= 0 then
					local var_417_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606103", "story_v_side_new_1106606.awb") / 1000

					if var_417_8 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_8 + var_417_0
					end

					if var_417_3.prefab_name ~= "" and arg_414_1.actors_[var_417_3.prefab_name] ~= nil then
						local var_417_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_3.prefab_name].transform, "story_v_side_new_1106606", "1106606103", "story_v_side_new_1106606.awb")

						arg_414_1:RecordAudio("1106606103", var_417_9)
						arg_414_1:RecordAudio("1106606103", var_417_9)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606103", "story_v_side_new_1106606.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606103", "story_v_side_new_1106606.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_10 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_10 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_10

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_10 and arg_414_1.time_ < var_417_0 + var_417_10 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play1106606106 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1106606106
		arg_418_1.duration_ = 0.5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"

			SetActive(arg_418_1.choicesGo_, true)

			for iter_419_0, iter_419_1 in ipairs(arg_418_1.choices_) do
				local var_419_0 = iter_419_0 <= 2

				SetActive(iter_419_1.go, var_419_0)
			end

			arg_418_1.choices_[1].txt.text = arg_418_1:FormatText(StoryChoiceCfg[562].name)
			arg_418_1.choices_[2].txt.text = arg_418_1:FormatText(StoryChoiceCfg[563].name)
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1106606107(arg_418_1)
			end

			if arg_420_0 == 2 then
				arg_418_0:Play1106606109(arg_418_1)
			end

			arg_418_1:RecordChoiceLog(1106606106, 562, 563)
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0

			if var_421_0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1.allBtn_.enabled = false
			end

			local var_421_1 = 0.5

			if arg_418_1.time_ >= var_421_0 + var_421_1 and arg_418_1.time_ < var_421_0 + var_421_1 + arg_421_0 then
				arg_418_1.allBtn_.enabled = true
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play1106606107 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1106606107
		arg_422_1.duration_ = 4.43

		local var_422_0 = {
			zh = 4.433,
			ja = 3.266
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play1106606108(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0
			local var_425_1 = 0.325

			if var_425_0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_2 = arg_422_1:FormatText(StoryNameCfg[32].name)

				arg_422_1.leftNameTxt_.text = var_425_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_3 = arg_422_1:GetWordFromCfg(1106606107)
				local var_425_4 = arg_422_1:FormatText(var_425_3.content)

				arg_422_1.text_.text = var_425_4

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_5 = 13
				local var_425_6 = utf8.len(var_425_4)
				local var_425_7 = var_425_5 <= 0 and var_425_1 or var_425_1 * (var_425_6 / var_425_5)

				if var_425_7 > 0 and var_425_1 < var_425_7 then
					arg_422_1.talkMaxDuration = var_425_7

					if var_425_7 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_7 + var_425_0
					end
				end

				arg_422_1.text_.text = var_425_4
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606107", "story_v_side_new_1106606.awb") ~= 0 then
					local var_425_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606107", "story_v_side_new_1106606.awb") / 1000

					if var_425_8 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_8 + var_425_0
					end

					if var_425_3.prefab_name ~= "" and arg_422_1.actors_[var_425_3.prefab_name] ~= nil then
						local var_425_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_3.prefab_name].transform, "story_v_side_new_1106606", "1106606107", "story_v_side_new_1106606.awb")

						arg_422_1:RecordAudio("1106606107", var_425_9)
						arg_422_1:RecordAudio("1106606107", var_425_9)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606107", "story_v_side_new_1106606.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606107", "story_v_side_new_1106606.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_10 = math.max(var_425_1, arg_422_1.talkMaxDuration)

			if var_425_0 <= arg_422_1.time_ and arg_422_1.time_ < var_425_0 + var_425_10 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_0) / var_425_10

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_0 + var_425_10 and arg_422_1.time_ < var_425_0 + var_425_10 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play1106606108 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1106606108
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1106606111(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0
			local var_429_1 = 0.825

			if var_429_0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_2 = arg_426_1:GetWordFromCfg(1106606108)
				local var_429_3 = arg_426_1:FormatText(var_429_2.content)

				arg_426_1.text_.text = var_429_3

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_4 = 33
				local var_429_5 = utf8.len(var_429_3)
				local var_429_6 = var_429_4 <= 0 and var_429_1 or var_429_1 * (var_429_5 / var_429_4)

				if var_429_6 > 0 and var_429_1 < var_429_6 then
					arg_426_1.talkMaxDuration = var_429_6

					if var_429_6 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_6 + var_429_0
					end
				end

				arg_426_1.text_.text = var_429_3
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_7 = math.max(var_429_1, arg_426_1.talkMaxDuration)

			if var_429_0 <= arg_426_1.time_ and arg_426_1.time_ < var_429_0 + var_429_7 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_0) / var_429_7

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_0 + var_429_7 and arg_426_1.time_ < var_429_0 + var_429_7 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play1106606111 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1106606111
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1106606112(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0
			local var_433_1 = 0.65

			if var_433_0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_2 = arg_430_1:FormatText(StoryNameCfg[7].name)

				arg_430_1.leftNameTxt_.text = var_433_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_3 = arg_430_1:GetWordFromCfg(1106606111)
				local var_433_4 = arg_430_1:FormatText(var_433_3.content)

				arg_430_1.text_.text = var_433_4

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_5 = 26
				local var_433_6 = utf8.len(var_433_4)
				local var_433_7 = var_433_5 <= 0 and var_433_1 or var_433_1 * (var_433_6 / var_433_5)

				if var_433_7 > 0 and var_433_1 < var_433_7 then
					arg_430_1.talkMaxDuration = var_433_7

					if var_433_7 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_7 + var_433_0
					end
				end

				arg_430_1.text_.text = var_433_4
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_8 = math.max(var_433_1, arg_430_1.talkMaxDuration)

			if var_433_0 <= arg_430_1.time_ and arg_430_1.time_ < var_433_0 + var_433_8 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_0) / var_433_8

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_0 + var_433_8 and arg_430_1.time_ < var_433_0 + var_433_8 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play1106606112 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1106606112
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1106606113(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0
			local var_437_1 = 1.35

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_2 = arg_434_1:GetWordFromCfg(1106606112)
				local var_437_3 = arg_434_1:FormatText(var_437_2.content)

				arg_434_1.text_.text = var_437_3

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_4 = 54
				local var_437_5 = utf8.len(var_437_3)
				local var_437_6 = var_437_4 <= 0 and var_437_1 or var_437_1 * (var_437_5 / var_437_4)

				if var_437_6 > 0 and var_437_1 < var_437_6 then
					arg_434_1.talkMaxDuration = var_437_6

					if var_437_6 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_6 + var_437_0
					end
				end

				arg_434_1.text_.text = var_437_3
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_7 = math.max(var_437_1, arg_434_1.talkMaxDuration)

			if var_437_0 <= arg_434_1.time_ and arg_434_1.time_ < var_437_0 + var_437_7 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_0) / var_437_7

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_0 + var_437_7 and arg_434_1.time_ < var_437_0 + var_437_7 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1106606113 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1106606113
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1106606114(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0
			local var_441_1 = 0.85

			if var_441_0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_2 = arg_438_1:GetWordFromCfg(1106606113)
				local var_441_3 = arg_438_1:FormatText(var_441_2.content)

				arg_438_1.text_.text = var_441_3

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_4 = 34
				local var_441_5 = utf8.len(var_441_3)
				local var_441_6 = var_441_4 <= 0 and var_441_1 or var_441_1 * (var_441_5 / var_441_4)

				if var_441_6 > 0 and var_441_1 < var_441_6 then
					arg_438_1.talkMaxDuration = var_441_6

					if var_441_6 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_6 + var_441_0
					end
				end

				arg_438_1.text_.text = var_441_3
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_7 = math.max(var_441_1, arg_438_1.talkMaxDuration)

			if var_441_0 <= arg_438_1.time_ and arg_438_1.time_ < var_441_0 + var_441_7 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_0) / var_441_7

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_0 + var_441_7 and arg_438_1.time_ < var_441_0 + var_441_7 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play1106606114 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1106606114
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1106606115(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0
			local var_445_1 = 0.325

			if var_445_0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_2 = arg_442_1:FormatText(StoryNameCfg[7].name)

				arg_442_1.leftNameTxt_.text = var_445_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_3 = arg_442_1:GetWordFromCfg(1106606114)
				local var_445_4 = arg_442_1:FormatText(var_445_3.content)

				arg_442_1.text_.text = var_445_4

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_5 = 13
				local var_445_6 = utf8.len(var_445_4)
				local var_445_7 = var_445_5 <= 0 and var_445_1 or var_445_1 * (var_445_6 / var_445_5)

				if var_445_7 > 0 and var_445_1 < var_445_7 then
					arg_442_1.talkMaxDuration = var_445_7

					if var_445_7 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_7 + var_445_0
					end
				end

				arg_442_1.text_.text = var_445_4
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_8 = math.max(var_445_1, arg_442_1.talkMaxDuration)

			if var_445_0 <= arg_442_1.time_ and arg_442_1.time_ < var_445_0 + var_445_8 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_0) / var_445_8

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_0 + var_445_8 and arg_442_1.time_ < var_445_0 + var_445_8 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play1106606115 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1106606115
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1106606116(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0
			local var_449_1 = 0.725

			if var_449_0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_2 = arg_446_1:GetWordFromCfg(1106606115)
				local var_449_3 = arg_446_1:FormatText(var_449_2.content)

				arg_446_1.text_.text = var_449_3

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_4 = 29
				local var_449_5 = utf8.len(var_449_3)
				local var_449_6 = var_449_4 <= 0 and var_449_1 or var_449_1 * (var_449_5 / var_449_4)

				if var_449_6 > 0 and var_449_1 < var_449_6 then
					arg_446_1.talkMaxDuration = var_449_6

					if var_449_6 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_6 + var_449_0
					end
				end

				arg_446_1.text_.text = var_449_3
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_7 = math.max(var_449_1, arg_446_1.talkMaxDuration)

			if var_449_0 <= arg_446_1.time_ and arg_446_1.time_ < var_449_0 + var_449_7 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_0) / var_449_7

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_0 + var_449_7 and arg_446_1.time_ < var_449_0 + var_449_7 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play1106606116 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1106606116
		arg_450_1.duration_ = 15.07

		local var_450_0 = {
			zh = 13.6,
			ja = 15.066
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1106606117(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = "R6602a"

			if arg_450_1.bgs_[var_453_0] == nil then
				local var_453_1 = Object.Instantiate(arg_450_1.paintGo_)

				var_453_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_453_0)
				var_453_1.name = var_453_0
				var_453_1.transform.parent = arg_450_1.stage_.transform
				var_453_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_450_1.bgs_[var_453_0] = var_453_1
			end

			local var_453_2 = 2

			if var_453_2 < arg_450_1.time_ and arg_450_1.time_ <= var_453_2 + arg_453_0 then
				local var_453_3 = manager.ui.mainCamera.transform.localPosition
				local var_453_4 = Vector3.New(0, 0, 10) + Vector3.New(var_453_3.x, var_453_3.y, 0)
				local var_453_5 = arg_450_1.bgs_.R6602a

				var_453_5.transform.localPosition = var_453_4
				var_453_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_453_6 = var_453_5:GetComponent("SpriteRenderer")

				if var_453_6 and var_453_6.sprite then
					local var_453_7 = (var_453_5.transform.localPosition - var_453_3).z
					local var_453_8 = manager.ui.mainCameraCom_
					local var_453_9 = 2 * var_453_7 * Mathf.Tan(var_453_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_453_10 = var_453_9 * var_453_8.aspect
					local var_453_11 = var_453_6.sprite.bounds.size.x
					local var_453_12 = var_453_6.sprite.bounds.size.y
					local var_453_13 = var_453_10 / var_453_11
					local var_453_14 = var_453_9 / var_453_12
					local var_453_15 = var_453_14 < var_453_13 and var_453_13 or var_453_14

					var_453_5.transform.localScale = Vector3.New(var_453_15, var_453_15, 0)
				end

				for iter_453_0, iter_453_1 in pairs(arg_450_1.bgs_) do
					if iter_453_0 ~= "R6602a" then
						iter_453_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_453_16 = 0

			if var_453_16 < arg_450_1.time_ and arg_450_1.time_ <= var_453_16 + arg_453_0 then
				arg_450_1.mask_.enabled = true
				arg_450_1.mask_.raycastTarget = true

				arg_450_1:SetGaussion(false)
			end

			local var_453_17 = 2

			if var_453_16 <= arg_450_1.time_ and arg_450_1.time_ < var_453_16 + var_453_17 then
				local var_453_18 = (arg_450_1.time_ - var_453_16) / var_453_17
				local var_453_19 = Color.New(0, 0, 0)

				var_453_19.a = Mathf.Lerp(0, 1, var_453_18)
				arg_450_1.mask_.color = var_453_19
			end

			if arg_450_1.time_ >= var_453_16 + var_453_17 and arg_450_1.time_ < var_453_16 + var_453_17 + arg_453_0 then
				local var_453_20 = Color.New(0, 0, 0)

				var_453_20.a = 1
				arg_450_1.mask_.color = var_453_20
			end

			local var_453_21 = 2

			if var_453_21 < arg_450_1.time_ and arg_450_1.time_ <= var_453_21 + arg_453_0 then
				arg_450_1.mask_.enabled = true
				arg_450_1.mask_.raycastTarget = true

				arg_450_1:SetGaussion(false)
			end

			local var_453_22 = 2

			if var_453_21 <= arg_450_1.time_ and arg_450_1.time_ < var_453_21 + var_453_22 then
				local var_453_23 = (arg_450_1.time_ - var_453_21) / var_453_22
				local var_453_24 = Color.New(0, 0, 0)

				var_453_24.a = Mathf.Lerp(1, 0, var_453_23)
				arg_450_1.mask_.color = var_453_24
			end

			if arg_450_1.time_ >= var_453_21 + var_453_22 and arg_450_1.time_ < var_453_21 + var_453_22 + arg_453_0 then
				local var_453_25 = Color.New(0, 0, 0)
				local var_453_26 = 0

				arg_450_1.mask_.enabled = false
				var_453_25.a = var_453_26
				arg_450_1.mask_.color = var_453_25
			end

			if arg_450_1.frameCnt_ <= 1 then
				arg_450_1.dialog_:SetActive(false)
			end

			local var_453_27 = 4
			local var_453_28 = 0.625

			if var_453_27 < arg_450_1.time_ and arg_450_1.time_ <= var_453_27 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0

				arg_450_1.dialog_:SetActive(true)

				arg_450_1.dialogCg_.alpha = 0

				local var_453_29 = LeanTween.value(arg_450_1.dialog_, 0, 1, 0.3)

				var_453_29:setOnUpdate(LuaHelper.FloatAction(function(arg_454_0)
					arg_450_1.dialogCg_.alpha = arg_454_0
				end))
				var_453_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_450_1.dialog_)
					var_453_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_450_1.duration_ = arg_450_1.duration_ + 0.3

				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_30 = arg_450_1:FormatText(StoryNameCfg[32].name)

				arg_450_1.leftNameTxt_.text = var_453_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_31 = arg_450_1:GetWordFromCfg(1106606116)
				local var_453_32 = arg_450_1:FormatText(var_453_31.content)

				arg_450_1.text_.text = var_453_32

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_33 = 25
				local var_453_34 = utf8.len(var_453_32)
				local var_453_35 = var_453_33 <= 0 and var_453_28 or var_453_28 * (var_453_34 / var_453_33)

				if var_453_35 > 0 and var_453_28 < var_453_35 then
					arg_450_1.talkMaxDuration = var_453_35
					var_453_27 = var_453_27 + 0.3

					if var_453_35 + var_453_27 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_35 + var_453_27
					end
				end

				arg_450_1.text_.text = var_453_32
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606116", "story_v_side_new_1106606.awb") ~= 0 then
					local var_453_36 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606116", "story_v_side_new_1106606.awb") / 1000

					if var_453_36 + var_453_27 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_36 + var_453_27
					end

					if var_453_31.prefab_name ~= "" and arg_450_1.actors_[var_453_31.prefab_name] ~= nil then
						local var_453_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_31.prefab_name].transform, "story_v_side_new_1106606", "1106606116", "story_v_side_new_1106606.awb")

						arg_450_1:RecordAudio("1106606116", var_453_37)
						arg_450_1:RecordAudio("1106606116", var_453_37)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606116", "story_v_side_new_1106606.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606116", "story_v_side_new_1106606.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_38 = var_453_27 + 0.3
			local var_453_39 = math.max(var_453_28, arg_450_1.talkMaxDuration)

			if var_453_38 <= arg_450_1.time_ and arg_450_1.time_ < var_453_38 + var_453_39 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_38) / var_453_39

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_38 + var_453_39 and arg_450_1.time_ < var_453_38 + var_453_39 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play1106606117 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1106606117
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1106606118(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0
			local var_459_1 = 1.3

			if var_459_0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_2 = arg_456_1:GetWordFromCfg(1106606117)
				local var_459_3 = arg_456_1:FormatText(var_459_2.content)

				arg_456_1.text_.text = var_459_3

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_4 = 52
				local var_459_5 = utf8.len(var_459_3)
				local var_459_6 = var_459_4 <= 0 and var_459_1 or var_459_1 * (var_459_5 / var_459_4)

				if var_459_6 > 0 and var_459_1 < var_459_6 then
					arg_456_1.talkMaxDuration = var_459_6

					if var_459_6 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_6 + var_459_0
					end
				end

				arg_456_1.text_.text = var_459_3
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_7 = math.max(var_459_1, arg_456_1.talkMaxDuration)

			if var_459_0 <= arg_456_1.time_ and arg_456_1.time_ < var_459_0 + var_459_7 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_0) / var_459_7

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_0 + var_459_7 and arg_456_1.time_ < var_459_0 + var_459_7 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play1106606118 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1106606118
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1106606119(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0
			local var_463_1 = 0.525

			if var_463_0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_2 = arg_460_1:FormatText(StoryNameCfg[7].name)

				arg_460_1.leftNameTxt_.text = var_463_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_3 = arg_460_1:GetWordFromCfg(1106606118)
				local var_463_4 = arg_460_1:FormatText(var_463_3.content)

				arg_460_1.text_.text = var_463_4

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_5 = 21
				local var_463_6 = utf8.len(var_463_4)
				local var_463_7 = var_463_5 <= 0 and var_463_1 or var_463_1 * (var_463_6 / var_463_5)

				if var_463_7 > 0 and var_463_1 < var_463_7 then
					arg_460_1.talkMaxDuration = var_463_7

					if var_463_7 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_7 + var_463_0
					end
				end

				arg_460_1.text_.text = var_463_4
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_8 = math.max(var_463_1, arg_460_1.talkMaxDuration)

			if var_463_0 <= arg_460_1.time_ and arg_460_1.time_ < var_463_0 + var_463_8 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_0) / var_463_8

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_0 + var_463_8 and arg_460_1.time_ < var_463_0 + var_463_8 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play1106606119 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 1106606119
		arg_464_1.duration_ = 6.3

		local var_464_0 = {
			zh = 4.1,
			ja = 6.3
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play1106606120(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 0
			local var_467_1 = 0.425

			if var_467_0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_0 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_2 = arg_464_1:FormatText(StoryNameCfg[32].name)

				arg_464_1.leftNameTxt_.text = var_467_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_3 = arg_464_1:GetWordFromCfg(1106606119)
				local var_467_4 = arg_464_1:FormatText(var_467_3.content)

				arg_464_1.text_.text = var_467_4

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_5 = 17
				local var_467_6 = utf8.len(var_467_4)
				local var_467_7 = var_467_5 <= 0 and var_467_1 or var_467_1 * (var_467_6 / var_467_5)

				if var_467_7 > 0 and var_467_1 < var_467_7 then
					arg_464_1.talkMaxDuration = var_467_7

					if var_467_7 + var_467_0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_7 + var_467_0
					end
				end

				arg_464_1.text_.text = var_467_4
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606119", "story_v_side_new_1106606.awb") ~= 0 then
					local var_467_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606119", "story_v_side_new_1106606.awb") / 1000

					if var_467_8 + var_467_0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_8 + var_467_0
					end

					if var_467_3.prefab_name ~= "" and arg_464_1.actors_[var_467_3.prefab_name] ~= nil then
						local var_467_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_3.prefab_name].transform, "story_v_side_new_1106606", "1106606119", "story_v_side_new_1106606.awb")

						arg_464_1:RecordAudio("1106606119", var_467_9)
						arg_464_1:RecordAudio("1106606119", var_467_9)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606119", "story_v_side_new_1106606.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606119", "story_v_side_new_1106606.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_10 = math.max(var_467_1, arg_464_1.talkMaxDuration)

			if var_467_0 <= arg_464_1.time_ and arg_464_1.time_ < var_467_0 + var_467_10 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_0) / var_467_10

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_0 + var_467_10 and arg_464_1.time_ < var_467_0 + var_467_10 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play1106606120 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 1106606120
		arg_468_1.duration_ = 7.9

		local var_468_0 = {
			zh = 1.233,
			ja = 7.9
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play1106606121(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0
			local var_471_1 = 0.05

			if var_471_0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_2 = arg_468_1:FormatText(StoryNameCfg[32].name)

				arg_468_1.leftNameTxt_.text = var_471_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_3 = arg_468_1:GetWordFromCfg(1106606120)
				local var_471_4 = arg_468_1:FormatText(var_471_3.content)

				arg_468_1.text_.text = var_471_4

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_5 = 2
				local var_471_6 = utf8.len(var_471_4)
				local var_471_7 = var_471_5 <= 0 and var_471_1 or var_471_1 * (var_471_6 / var_471_5)

				if var_471_7 > 0 and var_471_1 < var_471_7 then
					arg_468_1.talkMaxDuration = var_471_7

					if var_471_7 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_7 + var_471_0
					end
				end

				arg_468_1.text_.text = var_471_4
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606120", "story_v_side_new_1106606.awb") ~= 0 then
					local var_471_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606120", "story_v_side_new_1106606.awb") / 1000

					if var_471_8 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_8 + var_471_0
					end

					if var_471_3.prefab_name ~= "" and arg_468_1.actors_[var_471_3.prefab_name] ~= nil then
						local var_471_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_3.prefab_name].transform, "story_v_side_new_1106606", "1106606120", "story_v_side_new_1106606.awb")

						arg_468_1:RecordAudio("1106606120", var_471_9)
						arg_468_1:RecordAudio("1106606120", var_471_9)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606120", "story_v_side_new_1106606.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606120", "story_v_side_new_1106606.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_10 = math.max(var_471_1, arg_468_1.talkMaxDuration)

			if var_471_0 <= arg_468_1.time_ and arg_468_1.time_ < var_471_0 + var_471_10 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_0) / var_471_10

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_0 + var_471_10 and arg_468_1.time_ < var_471_0 + var_471_10 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play1106606121 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 1106606121
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play1106606122(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0
			local var_475_1 = 0.95

			if var_475_0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, false)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_2 = arg_472_1:GetWordFromCfg(1106606121)
				local var_475_3 = arg_472_1:FormatText(var_475_2.content)

				arg_472_1.text_.text = var_475_3

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_4 = 38
				local var_475_5 = utf8.len(var_475_3)
				local var_475_6 = var_475_4 <= 0 and var_475_1 or var_475_1 * (var_475_5 / var_475_4)

				if var_475_6 > 0 and var_475_1 < var_475_6 then
					arg_472_1.talkMaxDuration = var_475_6

					if var_475_6 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_6 + var_475_0
					end
				end

				arg_472_1.text_.text = var_475_3
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_7 = math.max(var_475_1, arg_472_1.talkMaxDuration)

			if var_475_0 <= arg_472_1.time_ and arg_472_1.time_ < var_475_0 + var_475_7 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_0) / var_475_7

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_0 + var_475_7 and arg_472_1.time_ < var_475_0 + var_475_7 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play1106606122 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1106606122
		arg_476_1.duration_ = 3.97

		local var_476_0 = {
			zh = 3.966,
			ja = 3.9
		}
		local var_476_1 = manager.audio:GetLocalizationFlag()

		if var_476_0[var_476_1] ~= nil then
			arg_476_1.duration_ = var_476_0[var_476_1]
		end

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1106606123(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0
			local var_479_1 = 0.425

			if var_479_0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_2 = arg_476_1:FormatText(StoryNameCfg[32].name)

				arg_476_1.leftNameTxt_.text = var_479_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_3 = arg_476_1:GetWordFromCfg(1106606122)
				local var_479_4 = arg_476_1:FormatText(var_479_3.content)

				arg_476_1.text_.text = var_479_4

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 17
				local var_479_6 = utf8.len(var_479_4)
				local var_479_7 = var_479_5 <= 0 and var_479_1 or var_479_1 * (var_479_6 / var_479_5)

				if var_479_7 > 0 and var_479_1 < var_479_7 then
					arg_476_1.talkMaxDuration = var_479_7

					if var_479_7 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_7 + var_479_0
					end
				end

				arg_476_1.text_.text = var_479_4
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606122", "story_v_side_new_1106606.awb") ~= 0 then
					local var_479_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606122", "story_v_side_new_1106606.awb") / 1000

					if var_479_8 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_8 + var_479_0
					end

					if var_479_3.prefab_name ~= "" and arg_476_1.actors_[var_479_3.prefab_name] ~= nil then
						local var_479_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_3.prefab_name].transform, "story_v_side_new_1106606", "1106606122", "story_v_side_new_1106606.awb")

						arg_476_1:RecordAudio("1106606122", var_479_9)
						arg_476_1:RecordAudio("1106606122", var_479_9)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606122", "story_v_side_new_1106606.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606122", "story_v_side_new_1106606.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_10 = math.max(var_479_1, arg_476_1.talkMaxDuration)

			if var_479_0 <= arg_476_1.time_ and arg_476_1.time_ < var_479_0 + var_479_10 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_0) / var_479_10

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_0 + var_479_10 and arg_476_1.time_ < var_479_0 + var_479_10 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play1106606123 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 1106606123
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play1106606124(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0
			local var_483_1 = 0.425

			if var_483_0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_2 = arg_480_1:FormatText(StoryNameCfg[7].name)

				arg_480_1.leftNameTxt_.text = var_483_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, true)
				arg_480_1.iconController_:SetSelectedState("hero")

				arg_480_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_480_1.callingController_:SetSelectedState("normal")

				arg_480_1.keyicon_.color = Color.New(1, 1, 1)
				arg_480_1.icon_.color = Color.New(1, 1, 1)

				local var_483_3 = arg_480_1:GetWordFromCfg(1106606123)
				local var_483_4 = arg_480_1:FormatText(var_483_3.content)

				arg_480_1.text_.text = var_483_4

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_5 = 17
				local var_483_6 = utf8.len(var_483_4)
				local var_483_7 = var_483_5 <= 0 and var_483_1 or var_483_1 * (var_483_6 / var_483_5)

				if var_483_7 > 0 and var_483_1 < var_483_7 then
					arg_480_1.talkMaxDuration = var_483_7

					if var_483_7 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_7 + var_483_0
					end
				end

				arg_480_1.text_.text = var_483_4
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_8 = math.max(var_483_1, arg_480_1.talkMaxDuration)

			if var_483_0 <= arg_480_1.time_ and arg_480_1.time_ < var_483_0 + var_483_8 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_0) / var_483_8

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_0 + var_483_8 and arg_480_1.time_ < var_483_0 + var_483_8 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play1106606124 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 1106606124
		arg_484_1.duration_ = 3.27

		local var_484_0 = {
			zh = 3.266,
			ja = 2
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play1106606125(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0
			local var_487_1 = 0.15

			if var_487_0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_2 = arg_484_1:FormatText(StoryNameCfg[32].name)

				arg_484_1.leftNameTxt_.text = var_487_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_3 = arg_484_1:GetWordFromCfg(1106606124)
				local var_487_4 = arg_484_1:FormatText(var_487_3.content)

				arg_484_1.text_.text = var_487_4

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_5 = 6
				local var_487_6 = utf8.len(var_487_4)
				local var_487_7 = var_487_5 <= 0 and var_487_1 or var_487_1 * (var_487_6 / var_487_5)

				if var_487_7 > 0 and var_487_1 < var_487_7 then
					arg_484_1.talkMaxDuration = var_487_7

					if var_487_7 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_7 + var_487_0
					end
				end

				arg_484_1.text_.text = var_487_4
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606124", "story_v_side_new_1106606.awb") ~= 0 then
					local var_487_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606124", "story_v_side_new_1106606.awb") / 1000

					if var_487_8 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_8 + var_487_0
					end

					if var_487_3.prefab_name ~= "" and arg_484_1.actors_[var_487_3.prefab_name] ~= nil then
						local var_487_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_3.prefab_name].transform, "story_v_side_new_1106606", "1106606124", "story_v_side_new_1106606.awb")

						arg_484_1:RecordAudio("1106606124", var_487_9)
						arg_484_1:RecordAudio("1106606124", var_487_9)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606124", "story_v_side_new_1106606.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606124", "story_v_side_new_1106606.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_10 = math.max(var_487_1, arg_484_1.talkMaxDuration)

			if var_487_0 <= arg_484_1.time_ and arg_484_1.time_ < var_487_0 + var_487_10 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_0) / var_487_10

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_0 + var_487_10 and arg_484_1.time_ < var_487_0 + var_487_10 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play1106606125 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 1106606125
		arg_488_1.duration_ = 9

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play1106606126(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 2

			if var_491_0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_0 + arg_491_0 then
				local var_491_1 = manager.ui.mainCamera.transform.localPosition
				local var_491_2 = Vector3.New(0, 0, 10) + Vector3.New(var_491_1.x, var_491_1.y, 0)
				local var_491_3 = arg_488_1.bgs_.ST10

				var_491_3.transform.localPosition = var_491_2
				var_491_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_491_4 = var_491_3:GetComponent("SpriteRenderer")

				if var_491_4 and var_491_4.sprite then
					local var_491_5 = (var_491_3.transform.localPosition - var_491_1).z
					local var_491_6 = manager.ui.mainCameraCom_
					local var_491_7 = 2 * var_491_5 * Mathf.Tan(var_491_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_491_8 = var_491_7 * var_491_6.aspect
					local var_491_9 = var_491_4.sprite.bounds.size.x
					local var_491_10 = var_491_4.sprite.bounds.size.y
					local var_491_11 = var_491_8 / var_491_9
					local var_491_12 = var_491_7 / var_491_10
					local var_491_13 = var_491_12 < var_491_11 and var_491_11 or var_491_12

					var_491_3.transform.localScale = Vector3.New(var_491_13, var_491_13, 0)
				end

				for iter_491_0, iter_491_1 in pairs(arg_488_1.bgs_) do
					if iter_491_0 ~= "ST10" then
						iter_491_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_491_14 = 0

			if var_491_14 < arg_488_1.time_ and arg_488_1.time_ <= var_491_14 + arg_491_0 then
				arg_488_1.mask_.enabled = true
				arg_488_1.mask_.raycastTarget = true

				arg_488_1:SetGaussion(false)
			end

			local var_491_15 = 2

			if var_491_14 <= arg_488_1.time_ and arg_488_1.time_ < var_491_14 + var_491_15 then
				local var_491_16 = (arg_488_1.time_ - var_491_14) / var_491_15
				local var_491_17 = Color.New(0, 0, 0)

				var_491_17.a = Mathf.Lerp(0, 1, var_491_16)
				arg_488_1.mask_.color = var_491_17
			end

			if arg_488_1.time_ >= var_491_14 + var_491_15 and arg_488_1.time_ < var_491_14 + var_491_15 + arg_491_0 then
				local var_491_18 = Color.New(0, 0, 0)

				var_491_18.a = 1
				arg_488_1.mask_.color = var_491_18
			end

			local var_491_19 = 2

			if var_491_19 < arg_488_1.time_ and arg_488_1.time_ <= var_491_19 + arg_491_0 then
				arg_488_1.mask_.enabled = true
				arg_488_1.mask_.raycastTarget = true

				arg_488_1:SetGaussion(false)
			end

			local var_491_20 = 2

			if var_491_19 <= arg_488_1.time_ and arg_488_1.time_ < var_491_19 + var_491_20 then
				local var_491_21 = (arg_488_1.time_ - var_491_19) / var_491_20
				local var_491_22 = Color.New(0, 0, 0)

				var_491_22.a = Mathf.Lerp(1, 0, var_491_21)
				arg_488_1.mask_.color = var_491_22
			end

			if arg_488_1.time_ >= var_491_19 + var_491_20 and arg_488_1.time_ < var_491_19 + var_491_20 + arg_491_0 then
				local var_491_23 = Color.New(0, 0, 0)
				local var_491_24 = 0

				arg_488_1.mask_.enabled = false
				var_491_23.a = var_491_24
				arg_488_1.mask_.color = var_491_23
			end

			if arg_488_1.frameCnt_ <= 1 then
				arg_488_1.dialog_:SetActive(false)
			end

			local var_491_25 = 4
			local var_491_26 = 1.075

			if var_491_25 < arg_488_1.time_ and arg_488_1.time_ <= var_491_25 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0

				arg_488_1.dialog_:SetActive(true)

				arg_488_1.dialogCg_.alpha = 0

				local var_491_27 = LeanTween.value(arg_488_1.dialog_, 0, 1, 0.3)

				var_491_27:setOnUpdate(LuaHelper.FloatAction(function(arg_492_0)
					arg_488_1.dialogCg_.alpha = arg_492_0
				end))
				var_491_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_488_1.dialog_)
					var_491_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_488_1.duration_ = arg_488_1.duration_ + 0.3

				SetActive(arg_488_1.leftNameGo_, false)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_28 = arg_488_1:GetWordFromCfg(1106606125)
				local var_491_29 = arg_488_1:FormatText(var_491_28.content)

				arg_488_1.text_.text = var_491_29

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_30 = 43
				local var_491_31 = utf8.len(var_491_29)
				local var_491_32 = var_491_30 <= 0 and var_491_26 or var_491_26 * (var_491_31 / var_491_30)

				if var_491_32 > 0 and var_491_26 < var_491_32 then
					arg_488_1.talkMaxDuration = var_491_32
					var_491_25 = var_491_25 + 0.3

					if var_491_32 + var_491_25 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_32 + var_491_25
					end
				end

				arg_488_1.text_.text = var_491_29
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_33 = var_491_25 + 0.3
			local var_491_34 = math.max(var_491_26, arg_488_1.talkMaxDuration)

			if var_491_33 <= arg_488_1.time_ and arg_488_1.time_ < var_491_33 + var_491_34 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_33) / var_491_34

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_33 + var_491_34 and arg_488_1.time_ < var_491_33 + var_491_34 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play1106606126 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1106606126
		arg_494_1.duration_ = 6.27

		local var_494_0 = {
			zh = 6.266,
			ja = 5.8
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1106606127(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0
			local var_497_1 = 0.775

			if var_497_0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_2 = arg_494_1:FormatText(StoryNameCfg[32].name)

				arg_494_1.leftNameTxt_.text = var_497_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_3 = arg_494_1:GetWordFromCfg(1106606126)
				local var_497_4 = arg_494_1:FormatText(var_497_3.content)

				arg_494_1.text_.text = var_497_4

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_5 = 31
				local var_497_6 = utf8.len(var_497_4)
				local var_497_7 = var_497_5 <= 0 and var_497_1 or var_497_1 * (var_497_6 / var_497_5)

				if var_497_7 > 0 and var_497_1 < var_497_7 then
					arg_494_1.talkMaxDuration = var_497_7

					if var_497_7 + var_497_0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_7 + var_497_0
					end
				end

				arg_494_1.text_.text = var_497_4
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606126", "story_v_side_new_1106606.awb") ~= 0 then
					local var_497_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606126", "story_v_side_new_1106606.awb") / 1000

					if var_497_8 + var_497_0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_8 + var_497_0
					end

					if var_497_3.prefab_name ~= "" and arg_494_1.actors_[var_497_3.prefab_name] ~= nil then
						local var_497_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_3.prefab_name].transform, "story_v_side_new_1106606", "1106606126", "story_v_side_new_1106606.awb")

						arg_494_1:RecordAudio("1106606126", var_497_9)
						arg_494_1:RecordAudio("1106606126", var_497_9)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606126", "story_v_side_new_1106606.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606126", "story_v_side_new_1106606.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_10 = math.max(var_497_1, arg_494_1.talkMaxDuration)

			if var_497_0 <= arg_494_1.time_ and arg_494_1.time_ < var_497_0 + var_497_10 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_0) / var_497_10

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_0 + var_497_10 and arg_494_1.time_ < var_497_0 + var_497_10 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play1106606127 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1106606127
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play1106606128(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = 0
			local var_501_1 = 0.65

			if var_501_0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_0 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, false)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_2 = arg_498_1:GetWordFromCfg(1106606127)
				local var_501_3 = arg_498_1:FormatText(var_501_2.content)

				arg_498_1.text_.text = var_501_3

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_4 = 26
				local var_501_5 = utf8.len(var_501_3)
				local var_501_6 = var_501_4 <= 0 and var_501_1 or var_501_1 * (var_501_5 / var_501_4)

				if var_501_6 > 0 and var_501_1 < var_501_6 then
					arg_498_1.talkMaxDuration = var_501_6

					if var_501_6 + var_501_0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_6 + var_501_0
					end
				end

				arg_498_1.text_.text = var_501_3
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_7 = math.max(var_501_1, arg_498_1.talkMaxDuration)

			if var_501_0 <= arg_498_1.time_ and arg_498_1.time_ < var_501_0 + var_501_7 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_0) / var_501_7

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_0 + var_501_7 and arg_498_1.time_ < var_501_0 + var_501_7 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play1106606128 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1106606128
		arg_502_1.duration_ = 8

		local var_502_0 = {
			zh = 8,
			ja = 7.6
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play1106606129(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = arg_502_1.actors_["1066ui_story"].transform
			local var_505_1 = 0

			if var_505_1 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 then
				arg_502_1.var_.moveOldPos1066ui_story = var_505_0.localPosition
			end

			local var_505_2 = 0.001

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_2 then
				local var_505_3 = (arg_502_1.time_ - var_505_1) / var_505_2
				local var_505_4 = Vector3.New(0, -0.77, -6.1)

				var_505_0.localPosition = Vector3.Lerp(arg_502_1.var_.moveOldPos1066ui_story, var_505_4, var_505_3)

				local var_505_5 = manager.ui.mainCamera.transform.position - var_505_0.position

				var_505_0.forward = Vector3.New(var_505_5.x, var_505_5.y, var_505_5.z)

				local var_505_6 = var_505_0.localEulerAngles

				var_505_6.z = 0
				var_505_6.x = 0
				var_505_0.localEulerAngles = var_505_6
			end

			if arg_502_1.time_ >= var_505_1 + var_505_2 and arg_502_1.time_ < var_505_1 + var_505_2 + arg_505_0 then
				var_505_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_505_7 = manager.ui.mainCamera.transform.position - var_505_0.position

				var_505_0.forward = Vector3.New(var_505_7.x, var_505_7.y, var_505_7.z)

				local var_505_8 = var_505_0.localEulerAngles

				var_505_8.z = 0
				var_505_8.x = 0
				var_505_0.localEulerAngles = var_505_8
			end

			local var_505_9 = arg_502_1.actors_["1066ui_story"]
			local var_505_10 = 0

			if var_505_10 < arg_502_1.time_ and arg_502_1.time_ <= var_505_10 + arg_505_0 and not isNil(var_505_9) and arg_502_1.var_.characterEffect1066ui_story == nil then
				arg_502_1.var_.characterEffect1066ui_story = var_505_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_11 = 0.200000002980232

			if var_505_10 <= arg_502_1.time_ and arg_502_1.time_ < var_505_10 + var_505_11 and not isNil(var_505_9) then
				local var_505_12 = (arg_502_1.time_ - var_505_10) / var_505_11

				if arg_502_1.var_.characterEffect1066ui_story and not isNil(var_505_9) then
					arg_502_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_502_1.time_ >= var_505_10 + var_505_11 and arg_502_1.time_ < var_505_10 + var_505_11 + arg_505_0 and not isNil(var_505_9) and arg_502_1.var_.characterEffect1066ui_story then
				arg_502_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_505_13 = 0

			if var_505_13 < arg_502_1.time_ and arg_502_1.time_ <= var_505_13 + arg_505_0 then
				arg_502_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_505_14 = 0

			if var_505_14 < arg_502_1.time_ and arg_502_1.time_ <= var_505_14 + arg_505_0 then
				arg_502_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_505_15 = 0
			local var_505_16 = 0.775

			if var_505_15 < arg_502_1.time_ and arg_502_1.time_ <= var_505_15 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_17 = arg_502_1:FormatText(StoryNameCfg[32].name)

				arg_502_1.leftNameTxt_.text = var_505_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_18 = arg_502_1:GetWordFromCfg(1106606128)
				local var_505_19 = arg_502_1:FormatText(var_505_18.content)

				arg_502_1.text_.text = var_505_19

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_20 = 31
				local var_505_21 = utf8.len(var_505_19)
				local var_505_22 = var_505_20 <= 0 and var_505_16 or var_505_16 * (var_505_21 / var_505_20)

				if var_505_22 > 0 and var_505_16 < var_505_22 then
					arg_502_1.talkMaxDuration = var_505_22

					if var_505_22 + var_505_15 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_22 + var_505_15
					end
				end

				arg_502_1.text_.text = var_505_19
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606128", "story_v_side_new_1106606.awb") ~= 0 then
					local var_505_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606128", "story_v_side_new_1106606.awb") / 1000

					if var_505_23 + var_505_15 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_23 + var_505_15
					end

					if var_505_18.prefab_name ~= "" and arg_502_1.actors_[var_505_18.prefab_name] ~= nil then
						local var_505_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_18.prefab_name].transform, "story_v_side_new_1106606", "1106606128", "story_v_side_new_1106606.awb")

						arg_502_1:RecordAudio("1106606128", var_505_24)
						arg_502_1:RecordAudio("1106606128", var_505_24)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606128", "story_v_side_new_1106606.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606128", "story_v_side_new_1106606.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_25 = math.max(var_505_16, arg_502_1.talkMaxDuration)

			if var_505_15 <= arg_502_1.time_ and arg_502_1.time_ < var_505_15 + var_505_25 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_15) / var_505_25

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_15 + var_505_25 and arg_502_1.time_ < var_505_15 + var_505_25 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_502_1:InitPlayNodeList()
	end,
	Play1106606129 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 1106606129
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play1106606130(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = arg_506_1.actors_["1066ui_story"]
			local var_509_1 = 0

			if var_509_1 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.characterEffect1066ui_story == nil then
				arg_506_1.var_.characterEffect1066ui_story = var_509_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_2 = 0.200000002980232

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_2 and not isNil(var_509_0) then
				local var_509_3 = (arg_506_1.time_ - var_509_1) / var_509_2

				if arg_506_1.var_.characterEffect1066ui_story and not isNil(var_509_0) then
					local var_509_4 = Mathf.Lerp(0, 0.5, var_509_3)

					arg_506_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_506_1.var_.characterEffect1066ui_story.fillRatio = var_509_4
				end
			end

			if arg_506_1.time_ >= var_509_1 + var_509_2 and arg_506_1.time_ < var_509_1 + var_509_2 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.characterEffect1066ui_story then
				local var_509_5 = 0.5

				arg_506_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_506_1.var_.characterEffect1066ui_story.fillRatio = var_509_5
			end

			local var_509_6 = 0
			local var_509_7 = 0.125

			if var_509_6 < arg_506_1.time_ and arg_506_1.time_ <= var_509_6 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_8 = arg_506_1:FormatText(StoryNameCfg[7].name)

				arg_506_1.leftNameTxt_.text = var_509_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, true)
				arg_506_1.iconController_:SetSelectedState("hero")

				arg_506_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_506_1.callingController_:SetSelectedState("normal")

				arg_506_1.keyicon_.color = Color.New(1, 1, 1)
				arg_506_1.icon_.color = Color.New(1, 1, 1)

				local var_509_9 = arg_506_1:GetWordFromCfg(1106606129)
				local var_509_10 = arg_506_1:FormatText(var_509_9.content)

				arg_506_1.text_.text = var_509_10

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_11 = 5
				local var_509_12 = utf8.len(var_509_10)
				local var_509_13 = var_509_11 <= 0 and var_509_7 or var_509_7 * (var_509_12 / var_509_11)

				if var_509_13 > 0 and var_509_7 < var_509_13 then
					arg_506_1.talkMaxDuration = var_509_13

					if var_509_13 + var_509_6 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_13 + var_509_6
					end
				end

				arg_506_1.text_.text = var_509_10
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_14 = math.max(var_509_7, arg_506_1.talkMaxDuration)

			if var_509_6 <= arg_506_1.time_ and arg_506_1.time_ < var_509_6 + var_509_14 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_6) / var_509_14

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_6 + var_509_14 and arg_506_1.time_ < var_509_6 + var_509_14 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play1106606130 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 1106606130
		arg_510_1.duration_ = 8.57

		local var_510_0 = {
			zh = 6.8,
			ja = 8.566
		}
		local var_510_1 = manager.audio:GetLocalizationFlag()

		if var_510_0[var_510_1] ~= nil then
			arg_510_1.duration_ = var_510_0[var_510_1]
		end

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play1106606131(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["1066ui_story"].transform
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.var_.moveOldPos1066ui_story = var_513_0.localPosition
			end

			local var_513_2 = 0.001

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2
				local var_513_4 = Vector3.New(0, -0.77, -6.1)

				var_513_0.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos1066ui_story, var_513_4, var_513_3)

				local var_513_5 = manager.ui.mainCamera.transform.position - var_513_0.position

				var_513_0.forward = Vector3.New(var_513_5.x, var_513_5.y, var_513_5.z)

				local var_513_6 = var_513_0.localEulerAngles

				var_513_6.z = 0
				var_513_6.x = 0
				var_513_0.localEulerAngles = var_513_6
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 then
				var_513_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_513_7 = manager.ui.mainCamera.transform.position - var_513_0.position

				var_513_0.forward = Vector3.New(var_513_7.x, var_513_7.y, var_513_7.z)

				local var_513_8 = var_513_0.localEulerAngles

				var_513_8.z = 0
				var_513_8.x = 0
				var_513_0.localEulerAngles = var_513_8
			end

			local var_513_9 = arg_510_1.actors_["1066ui_story"]
			local var_513_10 = 0

			if var_513_10 < arg_510_1.time_ and arg_510_1.time_ <= var_513_10 + arg_513_0 and not isNil(var_513_9) and arg_510_1.var_.characterEffect1066ui_story == nil then
				arg_510_1.var_.characterEffect1066ui_story = var_513_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_11 = 0.200000002980232

			if var_513_10 <= arg_510_1.time_ and arg_510_1.time_ < var_513_10 + var_513_11 and not isNil(var_513_9) then
				local var_513_12 = (arg_510_1.time_ - var_513_10) / var_513_11

				if arg_510_1.var_.characterEffect1066ui_story and not isNil(var_513_9) then
					arg_510_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_510_1.time_ >= var_513_10 + var_513_11 and arg_510_1.time_ < var_513_10 + var_513_11 + arg_513_0 and not isNil(var_513_9) and arg_510_1.var_.characterEffect1066ui_story then
				arg_510_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_513_13 = 0

			if var_513_13 < arg_510_1.time_ and arg_510_1.time_ <= var_513_13 + arg_513_0 then
				arg_510_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			local var_513_14 = 0

			if var_513_14 < arg_510_1.time_ and arg_510_1.time_ <= var_513_14 + arg_513_0 then
				arg_510_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_513_15 = 0
			local var_513_16 = 0.7

			if var_513_15 < arg_510_1.time_ and arg_510_1.time_ <= var_513_15 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				local var_513_17 = arg_510_1:FormatText(StoryNameCfg[32].name)

				arg_510_1.leftNameTxt_.text = var_513_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_18 = arg_510_1:GetWordFromCfg(1106606130)
				local var_513_19 = arg_510_1:FormatText(var_513_18.content)

				arg_510_1.text_.text = var_513_19

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_20 = 28
				local var_513_21 = utf8.len(var_513_19)
				local var_513_22 = var_513_20 <= 0 and var_513_16 or var_513_16 * (var_513_21 / var_513_20)

				if var_513_22 > 0 and var_513_16 < var_513_22 then
					arg_510_1.talkMaxDuration = var_513_22

					if var_513_22 + var_513_15 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_22 + var_513_15
					end
				end

				arg_510_1.text_.text = var_513_19
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606130", "story_v_side_new_1106606.awb") ~= 0 then
					local var_513_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606130", "story_v_side_new_1106606.awb") / 1000

					if var_513_23 + var_513_15 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_23 + var_513_15
					end

					if var_513_18.prefab_name ~= "" and arg_510_1.actors_[var_513_18.prefab_name] ~= nil then
						local var_513_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_18.prefab_name].transform, "story_v_side_new_1106606", "1106606130", "story_v_side_new_1106606.awb")

						arg_510_1:RecordAudio("1106606130", var_513_24)
						arg_510_1:RecordAudio("1106606130", var_513_24)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606130", "story_v_side_new_1106606.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606130", "story_v_side_new_1106606.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_25 = math.max(var_513_16, arg_510_1.talkMaxDuration)

			if var_513_15 <= arg_510_1.time_ and arg_510_1.time_ < var_513_15 + var_513_25 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_15) / var_513_25

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_15 + var_513_25 and arg_510_1.time_ < var_513_15 + var_513_25 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_510_1:InitPlayNodeList()
	end,
	Play1106606131 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 1106606131
		arg_514_1.duration_ = 14.97

		local var_514_0 = {
			zh = 14.966,
			ja = 12.833
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play1106606132(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = 2

			if var_517_0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_0 + arg_517_0 then
				local var_517_1 = manager.ui.mainCamera.transform.localPosition
				local var_517_2 = Vector3.New(0, 0, 10) + Vector3.New(var_517_1.x, var_517_1.y, 0)
				local var_517_3 = arg_514_1.bgs_.ST10

				var_517_3.transform.localPosition = var_517_2
				var_517_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_517_4 = var_517_3:GetComponent("SpriteRenderer")

				if var_517_4 and var_517_4.sprite then
					local var_517_5 = (var_517_3.transform.localPosition - var_517_1).z
					local var_517_6 = manager.ui.mainCameraCom_
					local var_517_7 = 2 * var_517_5 * Mathf.Tan(var_517_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_517_8 = var_517_7 * var_517_6.aspect
					local var_517_9 = var_517_4.sprite.bounds.size.x
					local var_517_10 = var_517_4.sprite.bounds.size.y
					local var_517_11 = var_517_8 / var_517_9
					local var_517_12 = var_517_7 / var_517_10
					local var_517_13 = var_517_12 < var_517_11 and var_517_11 or var_517_12

					var_517_3.transform.localScale = Vector3.New(var_517_13, var_517_13, 0)
				end

				for iter_517_0, iter_517_1 in pairs(arg_514_1.bgs_) do
					if iter_517_0 ~= "ST10" then
						iter_517_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_517_14 = 0

			if var_517_14 < arg_514_1.time_ and arg_514_1.time_ <= var_517_14 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_15 = 2

			if var_517_14 <= arg_514_1.time_ and arg_514_1.time_ < var_517_14 + var_517_15 then
				local var_517_16 = (arg_514_1.time_ - var_517_14) / var_517_15
				local var_517_17 = Color.New(0, 0, 0)

				var_517_17.a = Mathf.Lerp(0, 1, var_517_16)
				arg_514_1.mask_.color = var_517_17
			end

			if arg_514_1.time_ >= var_517_14 + var_517_15 and arg_514_1.time_ < var_517_14 + var_517_15 + arg_517_0 then
				local var_517_18 = Color.New(0, 0, 0)

				var_517_18.a = 1
				arg_514_1.mask_.color = var_517_18
			end

			local var_517_19 = 2

			if var_517_19 < arg_514_1.time_ and arg_514_1.time_ <= var_517_19 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_20 = 2

			if var_517_19 <= arg_514_1.time_ and arg_514_1.time_ < var_517_19 + var_517_20 then
				local var_517_21 = (arg_514_1.time_ - var_517_19) / var_517_20
				local var_517_22 = Color.New(0, 0, 0)

				var_517_22.a = Mathf.Lerp(1, 0, var_517_21)
				arg_514_1.mask_.color = var_517_22
			end

			if arg_514_1.time_ >= var_517_19 + var_517_20 and arg_514_1.time_ < var_517_19 + var_517_20 + arg_517_0 then
				local var_517_23 = Color.New(0, 0, 0)
				local var_517_24 = 0

				arg_514_1.mask_.enabled = false
				var_517_23.a = var_517_24
				arg_514_1.mask_.color = var_517_23
			end

			local var_517_25 = arg_514_1.actors_["1066ui_story"].transform
			local var_517_26 = 4

			if var_517_26 < arg_514_1.time_ and arg_514_1.time_ <= var_517_26 + arg_517_0 then
				arg_514_1.var_.moveOldPos1066ui_story = var_517_25.localPosition
			end

			local var_517_27 = 0.001

			if var_517_26 <= arg_514_1.time_ and arg_514_1.time_ < var_517_26 + var_517_27 then
				local var_517_28 = (arg_514_1.time_ - var_517_26) / var_517_27
				local var_517_29 = Vector3.New(0, -0.77, -6.1)

				var_517_25.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1066ui_story, var_517_29, var_517_28)

				local var_517_30 = manager.ui.mainCamera.transform.position - var_517_25.position

				var_517_25.forward = Vector3.New(var_517_30.x, var_517_30.y, var_517_30.z)

				local var_517_31 = var_517_25.localEulerAngles

				var_517_31.z = 0
				var_517_31.x = 0
				var_517_25.localEulerAngles = var_517_31
			end

			if arg_514_1.time_ >= var_517_26 + var_517_27 and arg_514_1.time_ < var_517_26 + var_517_27 + arg_517_0 then
				var_517_25.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_517_32 = manager.ui.mainCamera.transform.position - var_517_25.position

				var_517_25.forward = Vector3.New(var_517_32.x, var_517_32.y, var_517_32.z)

				local var_517_33 = var_517_25.localEulerAngles

				var_517_33.z = 0
				var_517_33.x = 0
				var_517_25.localEulerAngles = var_517_33
			end

			local var_517_34 = arg_514_1.actors_["1066ui_story"]
			local var_517_35 = 4

			if var_517_35 < arg_514_1.time_ and arg_514_1.time_ <= var_517_35 + arg_517_0 and not isNil(var_517_34) and arg_514_1.var_.characterEffect1066ui_story == nil then
				arg_514_1.var_.characterEffect1066ui_story = var_517_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_36 = 0.200000002980232

			if var_517_35 <= arg_514_1.time_ and arg_514_1.time_ < var_517_35 + var_517_36 and not isNil(var_517_34) then
				local var_517_37 = (arg_514_1.time_ - var_517_35) / var_517_36

				if arg_514_1.var_.characterEffect1066ui_story and not isNil(var_517_34) then
					arg_514_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= var_517_35 + var_517_36 and arg_514_1.time_ < var_517_35 + var_517_36 + arg_517_0 and not isNil(var_517_34) and arg_514_1.var_.characterEffect1066ui_story then
				arg_514_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_517_38 = 4

			if var_517_38 < arg_514_1.time_ and arg_514_1.time_ <= var_517_38 + arg_517_0 then
				arg_514_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_517_39 = 4

			if var_517_39 < arg_514_1.time_ and arg_514_1.time_ <= var_517_39 + arg_517_0 then
				arg_514_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_517_40 = arg_514_1.actors_["1066ui_story"].transform
			local var_517_41 = 2

			if var_517_41 < arg_514_1.time_ and arg_514_1.time_ <= var_517_41 + arg_517_0 then
				arg_514_1.var_.moveOldPos1066ui_story = var_517_40.localPosition
			end

			local var_517_42 = 0.001

			if var_517_41 <= arg_514_1.time_ and arg_514_1.time_ < var_517_41 + var_517_42 then
				local var_517_43 = (arg_514_1.time_ - var_517_41) / var_517_42
				local var_517_44 = Vector3.New(0, 100, 0)

				var_517_40.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1066ui_story, var_517_44, var_517_43)

				local var_517_45 = manager.ui.mainCamera.transform.position - var_517_40.position

				var_517_40.forward = Vector3.New(var_517_45.x, var_517_45.y, var_517_45.z)

				local var_517_46 = var_517_40.localEulerAngles

				var_517_46.z = 0
				var_517_46.x = 0
				var_517_40.localEulerAngles = var_517_46
			end

			if arg_514_1.time_ >= var_517_41 + var_517_42 and arg_514_1.time_ < var_517_41 + var_517_42 + arg_517_0 then
				var_517_40.localPosition = Vector3.New(0, 100, 0)

				local var_517_47 = manager.ui.mainCamera.transform.position - var_517_40.position

				var_517_40.forward = Vector3.New(var_517_47.x, var_517_47.y, var_517_47.z)

				local var_517_48 = var_517_40.localEulerAngles

				var_517_48.z = 0
				var_517_48.x = 0
				var_517_40.localEulerAngles = var_517_48
			end

			if arg_514_1.frameCnt_ <= 1 then
				arg_514_1.dialog_:SetActive(false)
			end

			local var_517_49 = 4
			local var_517_50 = 1.325

			if var_517_49 < arg_514_1.time_ and arg_514_1.time_ <= var_517_49 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0

				arg_514_1.dialog_:SetActive(true)

				arg_514_1.dialogCg_.alpha = 0

				local var_517_51 = LeanTween.value(arg_514_1.dialog_, 0, 1, 0.3)

				var_517_51:setOnUpdate(LuaHelper.FloatAction(function(arg_518_0)
					arg_514_1.dialogCg_.alpha = arg_518_0
				end))
				var_517_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_514_1.dialog_)
					var_517_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_514_1.duration_ = arg_514_1.duration_ + 0.3

				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_52 = arg_514_1:FormatText(StoryNameCfg[32].name)

				arg_514_1.leftNameTxt_.text = var_517_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_53 = arg_514_1:GetWordFromCfg(1106606131)
				local var_517_54 = arg_514_1:FormatText(var_517_53.content)

				arg_514_1.text_.text = var_517_54

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_55 = 53
				local var_517_56 = utf8.len(var_517_54)
				local var_517_57 = var_517_55 <= 0 and var_517_50 or var_517_50 * (var_517_56 / var_517_55)

				if var_517_57 > 0 and var_517_50 < var_517_57 then
					arg_514_1.talkMaxDuration = var_517_57
					var_517_49 = var_517_49 + 0.3

					if var_517_57 + var_517_49 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_57 + var_517_49
					end
				end

				arg_514_1.text_.text = var_517_54
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606131", "story_v_side_new_1106606.awb") ~= 0 then
					local var_517_58 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606131", "story_v_side_new_1106606.awb") / 1000

					if var_517_58 + var_517_49 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_58 + var_517_49
					end

					if var_517_53.prefab_name ~= "" and arg_514_1.actors_[var_517_53.prefab_name] ~= nil then
						local var_517_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_53.prefab_name].transform, "story_v_side_new_1106606", "1106606131", "story_v_side_new_1106606.awb")

						arg_514_1:RecordAudio("1106606131", var_517_59)
						arg_514_1:RecordAudio("1106606131", var_517_59)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606131", "story_v_side_new_1106606.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606131", "story_v_side_new_1106606.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_60 = var_517_49 + 0.3
			local var_517_61 = math.max(var_517_50, arg_514_1.talkMaxDuration)

			if var_517_60 <= arg_514_1.time_ and arg_514_1.time_ < var_517_60 + var_517_61 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_60) / var_517_61

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_60 + var_517_61 and arg_514_1.time_ < var_517_60 + var_517_61 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play1106606132 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 1106606132
		arg_520_1.duration_ = 4.43

		local var_520_0 = {
			zh = 4.2,
			ja = 4.433
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play1106606133(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = arg_520_1.actors_["1066ui_story"].transform
			local var_523_1 = 0

			if var_523_1 < arg_520_1.time_ and arg_520_1.time_ <= var_523_1 + arg_523_0 then
				arg_520_1.var_.moveOldPos1066ui_story = var_523_0.localPosition
			end

			local var_523_2 = 0.001

			if var_523_1 <= arg_520_1.time_ and arg_520_1.time_ < var_523_1 + var_523_2 then
				local var_523_3 = (arg_520_1.time_ - var_523_1) / var_523_2
				local var_523_4 = Vector3.New(0, -0.77, -6.1)

				var_523_0.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos1066ui_story, var_523_4, var_523_3)

				local var_523_5 = manager.ui.mainCamera.transform.position - var_523_0.position

				var_523_0.forward = Vector3.New(var_523_5.x, var_523_5.y, var_523_5.z)

				local var_523_6 = var_523_0.localEulerAngles

				var_523_6.z = 0
				var_523_6.x = 0
				var_523_0.localEulerAngles = var_523_6
			end

			if arg_520_1.time_ >= var_523_1 + var_523_2 and arg_520_1.time_ < var_523_1 + var_523_2 + arg_523_0 then
				var_523_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_523_7 = manager.ui.mainCamera.transform.position - var_523_0.position

				var_523_0.forward = Vector3.New(var_523_7.x, var_523_7.y, var_523_7.z)

				local var_523_8 = var_523_0.localEulerAngles

				var_523_8.z = 0
				var_523_8.x = 0
				var_523_0.localEulerAngles = var_523_8
			end

			local var_523_9 = arg_520_1.actors_["1066ui_story"]
			local var_523_10 = 0

			if var_523_10 < arg_520_1.time_ and arg_520_1.time_ <= var_523_10 + arg_523_0 and not isNil(var_523_9) and arg_520_1.var_.characterEffect1066ui_story == nil then
				arg_520_1.var_.characterEffect1066ui_story = var_523_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_523_11 = 0.200000002980232

			if var_523_10 <= arg_520_1.time_ and arg_520_1.time_ < var_523_10 + var_523_11 and not isNil(var_523_9) then
				local var_523_12 = (arg_520_1.time_ - var_523_10) / var_523_11

				if arg_520_1.var_.characterEffect1066ui_story and not isNil(var_523_9) then
					arg_520_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_520_1.time_ >= var_523_10 + var_523_11 and arg_520_1.time_ < var_523_10 + var_523_11 + arg_523_0 and not isNil(var_523_9) and arg_520_1.var_.characterEffect1066ui_story then
				arg_520_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_523_13 = 0

			if var_523_13 < arg_520_1.time_ and arg_520_1.time_ <= var_523_13 + arg_523_0 then
				arg_520_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			local var_523_14 = 0

			if var_523_14 < arg_520_1.time_ and arg_520_1.time_ <= var_523_14 + arg_523_0 then
				arg_520_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_523_15 = 0
			local var_523_16 = 0.5

			if var_523_15 < arg_520_1.time_ and arg_520_1.time_ <= var_523_15 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_17 = arg_520_1:FormatText(StoryNameCfg[32].name)

				arg_520_1.leftNameTxt_.text = var_523_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_18 = arg_520_1:GetWordFromCfg(1106606132)
				local var_523_19 = arg_520_1:FormatText(var_523_18.content)

				arg_520_1.text_.text = var_523_19

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_20 = 20
				local var_523_21 = utf8.len(var_523_19)
				local var_523_22 = var_523_20 <= 0 and var_523_16 or var_523_16 * (var_523_21 / var_523_20)

				if var_523_22 > 0 and var_523_16 < var_523_22 then
					arg_520_1.talkMaxDuration = var_523_22

					if var_523_22 + var_523_15 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_22 + var_523_15
					end
				end

				arg_520_1.text_.text = var_523_19
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606132", "story_v_side_new_1106606.awb") ~= 0 then
					local var_523_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606132", "story_v_side_new_1106606.awb") / 1000

					if var_523_23 + var_523_15 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_23 + var_523_15
					end

					if var_523_18.prefab_name ~= "" and arg_520_1.actors_[var_523_18.prefab_name] ~= nil then
						local var_523_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_18.prefab_name].transform, "story_v_side_new_1106606", "1106606132", "story_v_side_new_1106606.awb")

						arg_520_1:RecordAudio("1106606132", var_523_24)
						arg_520_1:RecordAudio("1106606132", var_523_24)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606132", "story_v_side_new_1106606.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606132", "story_v_side_new_1106606.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_25 = math.max(var_523_16, arg_520_1.talkMaxDuration)

			if var_523_15 <= arg_520_1.time_ and arg_520_1.time_ < var_523_15 + var_523_25 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_15) / var_523_25

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_15 + var_523_25 and arg_520_1.time_ < var_523_15 + var_523_25 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_520_1:InitPlayNodeList()
	end,
	Play1106606133 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 1106606133
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play1106606134(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = arg_524_1.actors_["1066ui_story"]
			local var_527_1 = 0

			if var_527_1 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.characterEffect1066ui_story == nil then
				arg_524_1.var_.characterEffect1066ui_story = var_527_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_2 = 0.200000002980232

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_2 and not isNil(var_527_0) then
				local var_527_3 = (arg_524_1.time_ - var_527_1) / var_527_2

				if arg_524_1.var_.characterEffect1066ui_story and not isNil(var_527_0) then
					local var_527_4 = Mathf.Lerp(0, 0.5, var_527_3)

					arg_524_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_524_1.var_.characterEffect1066ui_story.fillRatio = var_527_4
				end
			end

			if arg_524_1.time_ >= var_527_1 + var_527_2 and arg_524_1.time_ < var_527_1 + var_527_2 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.characterEffect1066ui_story then
				local var_527_5 = 0.5

				arg_524_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_524_1.var_.characterEffect1066ui_story.fillRatio = var_527_5
			end

			local var_527_6 = 0
			local var_527_7 = 1.05

			if var_527_6 < arg_524_1.time_ and arg_524_1.time_ <= var_527_6 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, false)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_8 = arg_524_1:GetWordFromCfg(1106606133)
				local var_527_9 = arg_524_1:FormatText(var_527_8.content)

				arg_524_1.text_.text = var_527_9

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_10 = 42
				local var_527_11 = utf8.len(var_527_9)
				local var_527_12 = var_527_10 <= 0 and var_527_7 or var_527_7 * (var_527_11 / var_527_10)

				if var_527_12 > 0 and var_527_7 < var_527_12 then
					arg_524_1.talkMaxDuration = var_527_12

					if var_527_12 + var_527_6 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_12 + var_527_6
					end
				end

				arg_524_1.text_.text = var_527_9
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_13 = math.max(var_527_7, arg_524_1.talkMaxDuration)

			if var_527_6 <= arg_524_1.time_ and arg_524_1.time_ < var_527_6 + var_527_13 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_6) / var_527_13

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_6 + var_527_13 and arg_524_1.time_ < var_527_6 + var_527_13 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play1106606134 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 1106606134
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play1106606135(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0
			local var_531_1 = 0.3

			if var_531_0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_2 = arg_528_1:FormatText(StoryNameCfg[7].name)

				arg_528_1.leftNameTxt_.text = var_531_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, true)
				arg_528_1.iconController_:SetSelectedState("hero")

				arg_528_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_528_1.callingController_:SetSelectedState("normal")

				arg_528_1.keyicon_.color = Color.New(1, 1, 1)
				arg_528_1.icon_.color = Color.New(1, 1, 1)

				local var_531_3 = arg_528_1:GetWordFromCfg(1106606134)
				local var_531_4 = arg_528_1:FormatText(var_531_3.content)

				arg_528_1.text_.text = var_531_4

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_5 = 12
				local var_531_6 = utf8.len(var_531_4)
				local var_531_7 = var_531_5 <= 0 and var_531_1 or var_531_1 * (var_531_6 / var_531_5)

				if var_531_7 > 0 and var_531_1 < var_531_7 then
					arg_528_1.talkMaxDuration = var_531_7

					if var_531_7 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_7 + var_531_0
					end
				end

				arg_528_1.text_.text = var_531_4
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_8 = math.max(var_531_1, arg_528_1.talkMaxDuration)

			if var_531_0 <= arg_528_1.time_ and arg_528_1.time_ < var_531_0 + var_531_8 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_0) / var_531_8

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_0 + var_531_8 and arg_528_1.time_ < var_531_0 + var_531_8 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play1106606135 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 1106606135
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play1106606136(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0
			local var_535_1 = 0.75

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, false)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_2 = arg_532_1:GetWordFromCfg(1106606135)
				local var_535_3 = arg_532_1:FormatText(var_535_2.content)

				arg_532_1.text_.text = var_535_3

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_4 = 30
				local var_535_5 = utf8.len(var_535_3)
				local var_535_6 = var_535_4 <= 0 and var_535_1 or var_535_1 * (var_535_5 / var_535_4)

				if var_535_6 > 0 and var_535_1 < var_535_6 then
					arg_532_1.talkMaxDuration = var_535_6

					if var_535_6 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_6 + var_535_0
					end
				end

				arg_532_1.text_.text = var_535_3
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_7 = math.max(var_535_1, arg_532_1.talkMaxDuration)

			if var_535_0 <= arg_532_1.time_ and arg_532_1.time_ < var_535_0 + var_535_7 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_0) / var_535_7

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_0 + var_535_7 and arg_532_1.time_ < var_535_0 + var_535_7 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play1106606136 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 1106606136
		arg_536_1.duration_ = 2.33

		local var_536_0 = {
			zh = 2.333,
			ja = 2
		}
		local var_536_1 = manager.audio:GetLocalizationFlag()

		if var_536_0[var_536_1] ~= nil then
			arg_536_1.duration_ = var_536_0[var_536_1]
		end

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play1106606137(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = arg_536_1.actors_["1066ui_story"].transform
			local var_539_1 = 0

			if var_539_1 < arg_536_1.time_ and arg_536_1.time_ <= var_539_1 + arg_539_0 then
				arg_536_1.var_.moveOldPos1066ui_story = var_539_0.localPosition
			end

			local var_539_2 = 0.001

			if var_539_1 <= arg_536_1.time_ and arg_536_1.time_ < var_539_1 + var_539_2 then
				local var_539_3 = (arg_536_1.time_ - var_539_1) / var_539_2
				local var_539_4 = Vector3.New(0, -0.77, -6.1)

				var_539_0.localPosition = Vector3.Lerp(arg_536_1.var_.moveOldPos1066ui_story, var_539_4, var_539_3)

				local var_539_5 = manager.ui.mainCamera.transform.position - var_539_0.position

				var_539_0.forward = Vector3.New(var_539_5.x, var_539_5.y, var_539_5.z)

				local var_539_6 = var_539_0.localEulerAngles

				var_539_6.z = 0
				var_539_6.x = 0
				var_539_0.localEulerAngles = var_539_6
			end

			if arg_536_1.time_ >= var_539_1 + var_539_2 and arg_536_1.time_ < var_539_1 + var_539_2 + arg_539_0 then
				var_539_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_539_7 = manager.ui.mainCamera.transform.position - var_539_0.position

				var_539_0.forward = Vector3.New(var_539_7.x, var_539_7.y, var_539_7.z)

				local var_539_8 = var_539_0.localEulerAngles

				var_539_8.z = 0
				var_539_8.x = 0
				var_539_0.localEulerAngles = var_539_8
			end

			local var_539_9 = arg_536_1.actors_["1066ui_story"]
			local var_539_10 = 0

			if var_539_10 < arg_536_1.time_ and arg_536_1.time_ <= var_539_10 + arg_539_0 and not isNil(var_539_9) and arg_536_1.var_.characterEffect1066ui_story == nil then
				arg_536_1.var_.characterEffect1066ui_story = var_539_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_11 = 0.200000002980232

			if var_539_10 <= arg_536_1.time_ and arg_536_1.time_ < var_539_10 + var_539_11 and not isNil(var_539_9) then
				local var_539_12 = (arg_536_1.time_ - var_539_10) / var_539_11

				if arg_536_1.var_.characterEffect1066ui_story and not isNil(var_539_9) then
					arg_536_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_536_1.time_ >= var_539_10 + var_539_11 and arg_536_1.time_ < var_539_10 + var_539_11 + arg_539_0 and not isNil(var_539_9) and arg_536_1.var_.characterEffect1066ui_story then
				arg_536_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_539_13 = 0

			if var_539_13 < arg_536_1.time_ and arg_536_1.time_ <= var_539_13 + arg_539_0 then
				arg_536_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_539_14 = 0
			local var_539_15 = 0.275

			if var_539_14 < arg_536_1.time_ and arg_536_1.time_ <= var_539_14 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_16 = arg_536_1:FormatText(StoryNameCfg[32].name)

				arg_536_1.leftNameTxt_.text = var_539_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_17 = arg_536_1:GetWordFromCfg(1106606136)
				local var_539_18 = arg_536_1:FormatText(var_539_17.content)

				arg_536_1.text_.text = var_539_18

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_19 = 11
				local var_539_20 = utf8.len(var_539_18)
				local var_539_21 = var_539_19 <= 0 and var_539_15 or var_539_15 * (var_539_20 / var_539_19)

				if var_539_21 > 0 and var_539_15 < var_539_21 then
					arg_536_1.talkMaxDuration = var_539_21

					if var_539_21 + var_539_14 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_21 + var_539_14
					end
				end

				arg_536_1.text_.text = var_539_18
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606136", "story_v_side_new_1106606.awb") ~= 0 then
					local var_539_22 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606136", "story_v_side_new_1106606.awb") / 1000

					if var_539_22 + var_539_14 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_22 + var_539_14
					end

					if var_539_17.prefab_name ~= "" and arg_536_1.actors_[var_539_17.prefab_name] ~= nil then
						local var_539_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_17.prefab_name].transform, "story_v_side_new_1106606", "1106606136", "story_v_side_new_1106606.awb")

						arg_536_1:RecordAudio("1106606136", var_539_23)
						arg_536_1:RecordAudio("1106606136", var_539_23)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606136", "story_v_side_new_1106606.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606136", "story_v_side_new_1106606.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_24 = math.max(var_539_15, arg_536_1.talkMaxDuration)

			if var_539_14 <= arg_536_1.time_ and arg_536_1.time_ < var_539_14 + var_539_24 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_14) / var_539_24

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_14 + var_539_24 and arg_536_1.time_ < var_539_14 + var_539_24 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_536_1:InitPlayNodeList()
	end,
	Play1106606137 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 1106606137
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play1106606138(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = arg_540_1.actors_["1066ui_story"].transform
			local var_543_1 = 0

			if var_543_1 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 then
				arg_540_1.var_.moveOldPos1066ui_story = var_543_0.localPosition
			end

			local var_543_2 = 0.001

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_2 then
				local var_543_3 = (arg_540_1.time_ - var_543_1) / var_543_2
				local var_543_4 = Vector3.New(0, 100, 0)

				var_543_0.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos1066ui_story, var_543_4, var_543_3)

				local var_543_5 = manager.ui.mainCamera.transform.position - var_543_0.position

				var_543_0.forward = Vector3.New(var_543_5.x, var_543_5.y, var_543_5.z)

				local var_543_6 = var_543_0.localEulerAngles

				var_543_6.z = 0
				var_543_6.x = 0
				var_543_0.localEulerAngles = var_543_6
			end

			if arg_540_1.time_ >= var_543_1 + var_543_2 and arg_540_1.time_ < var_543_1 + var_543_2 + arg_543_0 then
				var_543_0.localPosition = Vector3.New(0, 100, 0)

				local var_543_7 = manager.ui.mainCamera.transform.position - var_543_0.position

				var_543_0.forward = Vector3.New(var_543_7.x, var_543_7.y, var_543_7.z)

				local var_543_8 = var_543_0.localEulerAngles

				var_543_8.z = 0
				var_543_8.x = 0
				var_543_0.localEulerAngles = var_543_8
			end

			local var_543_9 = 0
			local var_543_10 = 1.075

			if var_543_9 < arg_540_1.time_ and arg_540_1.time_ <= var_543_9 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, false)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_11 = arg_540_1:GetWordFromCfg(1106606137)
				local var_543_12 = arg_540_1:FormatText(var_543_11.content)

				arg_540_1.text_.text = var_543_12

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_13 = 43
				local var_543_14 = utf8.len(var_543_12)
				local var_543_15 = var_543_13 <= 0 and var_543_10 or var_543_10 * (var_543_14 / var_543_13)

				if var_543_15 > 0 and var_543_10 < var_543_15 then
					arg_540_1.talkMaxDuration = var_543_15

					if var_543_15 + var_543_9 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_15 + var_543_9
					end
				end

				arg_540_1.text_.text = var_543_12
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_16 = math.max(var_543_10, arg_540_1.talkMaxDuration)

			if var_543_9 <= arg_540_1.time_ and arg_540_1.time_ < var_543_9 + var_543_16 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_9) / var_543_16

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_9 + var_543_16 and arg_540_1.time_ < var_543_9 + var_543_16 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_540_1:InitPlayNodeList()
	end,
	Play1106606138 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 1106606138
		arg_544_1.duration_ = 1

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"

			SetActive(arg_544_1.choicesGo_, true)

			for iter_545_0, iter_545_1 in ipairs(arg_544_1.choices_) do
				local var_545_0 = iter_545_0 <= 1

				SetActive(iter_545_1.go, var_545_0)
			end

			arg_544_1.choices_[1].txt.text = arg_544_1:FormatText(StoryChoiceCfg[564].name)
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play1106606139(arg_544_1)
			end

			arg_544_1:RecordChoiceLog(1106606138, 564)
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0

			if var_547_0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_0 + arg_547_0 then
				arg_544_1.allBtn_.enabled = false
			end

			local var_547_1 = 0.5

			if arg_544_1.time_ >= var_547_0 + var_547_1 and arg_544_1.time_ < var_547_0 + var_547_1 + arg_547_0 then
				arg_544_1.allBtn_.enabled = true
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play1106606139 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 1106606139
		arg_548_1.duration_ = 1.73

		local var_548_0 = {
			zh = 1.733,
			ja = 1.433
		}
		local var_548_1 = manager.audio:GetLocalizationFlag()

		if var_548_0[var_548_1] ~= nil then
			arg_548_1.duration_ = var_548_0[var_548_1]
		end

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play1106606140(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0
			local var_551_1 = 0.325

			if var_551_0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				local var_551_2 = arg_548_1:FormatText(StoryNameCfg[137].name)

				arg_548_1.leftNameTxt_.text = var_551_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_3 = arg_548_1:GetWordFromCfg(1106606139)
				local var_551_4 = arg_548_1:FormatText(var_551_3.content)

				arg_548_1.text_.text = var_551_4

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_5 = 13
				local var_551_6 = utf8.len(var_551_4)
				local var_551_7 = var_551_5 <= 0 and var_551_1 or var_551_1 * (var_551_6 / var_551_5)

				if var_551_7 > 0 and var_551_1 < var_551_7 then
					arg_548_1.talkMaxDuration = var_551_7

					if var_551_7 + var_551_0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_7 + var_551_0
					end
				end

				arg_548_1.text_.text = var_551_4
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606139", "story_v_side_new_1106606.awb") ~= 0 then
					local var_551_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606139", "story_v_side_new_1106606.awb") / 1000

					if var_551_8 + var_551_0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_8 + var_551_0
					end

					if var_551_3.prefab_name ~= "" and arg_548_1.actors_[var_551_3.prefab_name] ~= nil then
						local var_551_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_3.prefab_name].transform, "story_v_side_new_1106606", "1106606139", "story_v_side_new_1106606.awb")

						arg_548_1:RecordAudio("1106606139", var_551_9)
						arg_548_1:RecordAudio("1106606139", var_551_9)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606139", "story_v_side_new_1106606.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606139", "story_v_side_new_1106606.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_10 = math.max(var_551_1, arg_548_1.talkMaxDuration)

			if var_551_0 <= arg_548_1.time_ and arg_548_1.time_ < var_551_0 + var_551_10 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_0) / var_551_10

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_0 + var_551_10 and arg_548_1.time_ < var_551_0 + var_551_10 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play1106606140 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 1106606140
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play1106606141(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0
			local var_555_1 = 0.175

			if var_555_0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				local var_555_2 = arg_552_1:FormatText(StoryNameCfg[7].name)

				arg_552_1.leftNameTxt_.text = var_555_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_3 = arg_552_1:GetWordFromCfg(1106606140)
				local var_555_4 = arg_552_1:FormatText(var_555_3.content)

				arg_552_1.text_.text = var_555_4

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_5 = 7
				local var_555_6 = utf8.len(var_555_4)
				local var_555_7 = var_555_5 <= 0 and var_555_1 or var_555_1 * (var_555_6 / var_555_5)

				if var_555_7 > 0 and var_555_1 < var_555_7 then
					arg_552_1.talkMaxDuration = var_555_7

					if var_555_7 + var_555_0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_7 + var_555_0
					end
				end

				arg_552_1.text_.text = var_555_4
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_8 = math.max(var_555_1, arg_552_1.talkMaxDuration)

			if var_555_0 <= arg_552_1.time_ and arg_552_1.time_ < var_555_0 + var_555_8 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_0) / var_555_8

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_0 + var_555_8 and arg_552_1.time_ < var_555_0 + var_555_8 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play1106606141 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 1106606141
		arg_556_1.duration_ = 4

		local var_556_0 = {
			zh = 2.8,
			ja = 4
		}
		local var_556_1 = manager.audio:GetLocalizationFlag()

		if var_556_0[var_556_1] ~= nil then
			arg_556_1.duration_ = var_556_0[var_556_1]
		end

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play1106606142(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 0
			local var_559_1 = 0.45

			if var_559_0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_0 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				local var_559_2 = arg_556_1:FormatText(StoryNameCfg[137].name)

				arg_556_1.leftNameTxt_.text = var_559_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_3 = arg_556_1:GetWordFromCfg(1106606141)
				local var_559_4 = arg_556_1:FormatText(var_559_3.content)

				arg_556_1.text_.text = var_559_4

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_5 = 18
				local var_559_6 = utf8.len(var_559_4)
				local var_559_7 = var_559_5 <= 0 and var_559_1 or var_559_1 * (var_559_6 / var_559_5)

				if var_559_7 > 0 and var_559_1 < var_559_7 then
					arg_556_1.talkMaxDuration = var_559_7

					if var_559_7 + var_559_0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_7 + var_559_0
					end
				end

				arg_556_1.text_.text = var_559_4
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606141", "story_v_side_new_1106606.awb") ~= 0 then
					local var_559_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606141", "story_v_side_new_1106606.awb") / 1000

					if var_559_8 + var_559_0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_8 + var_559_0
					end

					if var_559_3.prefab_name ~= "" and arg_556_1.actors_[var_559_3.prefab_name] ~= nil then
						local var_559_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_3.prefab_name].transform, "story_v_side_new_1106606", "1106606141", "story_v_side_new_1106606.awb")

						arg_556_1:RecordAudio("1106606141", var_559_9)
						arg_556_1:RecordAudio("1106606141", var_559_9)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606141", "story_v_side_new_1106606.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606141", "story_v_side_new_1106606.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_10 = math.max(var_559_1, arg_556_1.talkMaxDuration)

			if var_559_0 <= arg_556_1.time_ and arg_556_1.time_ < var_559_0 + var_559_10 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_0) / var_559_10

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_0 + var_559_10 and arg_556_1.time_ < var_559_0 + var_559_10 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play1106606142 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 1106606142
		arg_560_1.duration_ = 4.6

		local var_560_0 = {
			zh = 3.166,
			ja = 4.6
		}
		local var_560_1 = manager.audio:GetLocalizationFlag()

		if var_560_0[var_560_1] ~= nil then
			arg_560_1.duration_ = var_560_0[var_560_1]
		end

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play1106606143(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = 0
			local var_563_1 = 0.225

			if var_563_0 < arg_560_1.time_ and arg_560_1.time_ <= var_563_0 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				local var_563_2 = arg_560_1:FormatText(StoryNameCfg[137].name)

				arg_560_1.leftNameTxt_.text = var_563_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_3 = arg_560_1:GetWordFromCfg(1106606142)
				local var_563_4 = arg_560_1:FormatText(var_563_3.content)

				arg_560_1.text_.text = var_563_4

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_5 = 9
				local var_563_6 = utf8.len(var_563_4)
				local var_563_7 = var_563_5 <= 0 and var_563_1 or var_563_1 * (var_563_6 / var_563_5)

				if var_563_7 > 0 and var_563_1 < var_563_7 then
					arg_560_1.talkMaxDuration = var_563_7

					if var_563_7 + var_563_0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_7 + var_563_0
					end
				end

				arg_560_1.text_.text = var_563_4
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606142", "story_v_side_new_1106606.awb") ~= 0 then
					local var_563_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606142", "story_v_side_new_1106606.awb") / 1000

					if var_563_8 + var_563_0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_8 + var_563_0
					end

					if var_563_3.prefab_name ~= "" and arg_560_1.actors_[var_563_3.prefab_name] ~= nil then
						local var_563_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_3.prefab_name].transform, "story_v_side_new_1106606", "1106606142", "story_v_side_new_1106606.awb")

						arg_560_1:RecordAudio("1106606142", var_563_9)
						arg_560_1:RecordAudio("1106606142", var_563_9)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606142", "story_v_side_new_1106606.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606142", "story_v_side_new_1106606.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_10 = math.max(var_563_1, arg_560_1.talkMaxDuration)

			if var_563_0 <= arg_560_1.time_ and arg_560_1.time_ < var_563_0 + var_563_10 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_0) / var_563_10

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_0 + var_563_10 and arg_560_1.time_ < var_563_0 + var_563_10 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play1106606143 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 1106606143
		arg_564_1.duration_ = 5

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play1106606144(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = 0
			local var_567_1 = 0.375

			if var_567_0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_0 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				local var_567_2 = arg_564_1:FormatText(StoryNameCfg[7].name)

				arg_564_1.leftNameTxt_.text = var_567_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, true)
				arg_564_1.iconController_:SetSelectedState("hero")

				arg_564_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_564_1.callingController_:SetSelectedState("normal")

				arg_564_1.keyicon_.color = Color.New(1, 1, 1)
				arg_564_1.icon_.color = Color.New(1, 1, 1)

				local var_567_3 = arg_564_1:GetWordFromCfg(1106606143)
				local var_567_4 = arg_564_1:FormatText(var_567_3.content)

				arg_564_1.text_.text = var_567_4

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_5 = 15
				local var_567_6 = utf8.len(var_567_4)
				local var_567_7 = var_567_5 <= 0 and var_567_1 or var_567_1 * (var_567_6 / var_567_5)

				if var_567_7 > 0 and var_567_1 < var_567_7 then
					arg_564_1.talkMaxDuration = var_567_7

					if var_567_7 + var_567_0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_7 + var_567_0
					end
				end

				arg_564_1.text_.text = var_567_4
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_8 = math.max(var_567_1, arg_564_1.talkMaxDuration)

			if var_567_0 <= arg_564_1.time_ and arg_564_1.time_ < var_567_0 + var_567_8 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_0) / var_567_8

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_0 + var_567_8 and arg_564_1.time_ < var_567_0 + var_567_8 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play1106606144 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 1106606144
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play1106606145(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = 0
			local var_571_1 = 0.65

			if var_571_0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_0 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, false)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_2 = arg_568_1:GetWordFromCfg(1106606144)
				local var_571_3 = arg_568_1:FormatText(var_571_2.content)

				arg_568_1.text_.text = var_571_3

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_4 = 26
				local var_571_5 = utf8.len(var_571_3)
				local var_571_6 = var_571_4 <= 0 and var_571_1 or var_571_1 * (var_571_5 / var_571_4)

				if var_571_6 > 0 and var_571_1 < var_571_6 then
					arg_568_1.talkMaxDuration = var_571_6

					if var_571_6 + var_571_0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_6 + var_571_0
					end
				end

				arg_568_1.text_.text = var_571_3
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)
				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_7 = math.max(var_571_1, arg_568_1.talkMaxDuration)

			if var_571_0 <= arg_568_1.time_ and arg_568_1.time_ < var_571_0 + var_571_7 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_0) / var_571_7

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_0 + var_571_7 and arg_568_1.time_ < var_571_0 + var_571_7 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play1106606145 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 1106606145
		arg_572_1.duration_ = 5

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play1106606146(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = 0
			local var_575_1 = 0.6

			if var_575_0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_0 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, false)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_2 = arg_572_1:GetWordFromCfg(1106606145)
				local var_575_3 = arg_572_1:FormatText(var_575_2.content)

				arg_572_1.text_.text = var_575_3

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_4 = 24
				local var_575_5 = utf8.len(var_575_3)
				local var_575_6 = var_575_4 <= 0 and var_575_1 or var_575_1 * (var_575_5 / var_575_4)

				if var_575_6 > 0 and var_575_1 < var_575_6 then
					arg_572_1.talkMaxDuration = var_575_6

					if var_575_6 + var_575_0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_6 + var_575_0
					end
				end

				arg_572_1.text_.text = var_575_3
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)
				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_7 = math.max(var_575_1, arg_572_1.talkMaxDuration)

			if var_575_0 <= arg_572_1.time_ and arg_572_1.time_ < var_575_0 + var_575_7 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_0) / var_575_7

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_0 + var_575_7 and arg_572_1.time_ < var_575_0 + var_575_7 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play1106606146 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 1106606146
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play1106606147(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = 0
			local var_579_1 = 0.7

			if var_579_0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_0 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, false)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_2 = arg_576_1:GetWordFromCfg(1106606146)
				local var_579_3 = arg_576_1:FormatText(var_579_2.content)

				arg_576_1.text_.text = var_579_3

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_4 = 28
				local var_579_5 = utf8.len(var_579_3)
				local var_579_6 = var_579_4 <= 0 and var_579_1 or var_579_1 * (var_579_5 / var_579_4)

				if var_579_6 > 0 and var_579_1 < var_579_6 then
					arg_576_1.talkMaxDuration = var_579_6

					if var_579_6 + var_579_0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_6 + var_579_0
					end
				end

				arg_576_1.text_.text = var_579_3
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_7 = math.max(var_579_1, arg_576_1.talkMaxDuration)

			if var_579_0 <= arg_576_1.time_ and arg_576_1.time_ < var_579_0 + var_579_7 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_0) / var_579_7

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_0 + var_579_7 and arg_576_1.time_ < var_579_0 + var_579_7 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play1106606147 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 1106606147
		arg_580_1.duration_ = 5

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play1106606148(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = 0

			if var_583_0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_0 + arg_583_0 then
				arg_580_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action434")
			end

			local var_583_1 = 0
			local var_583_2 = 0.65

			if var_583_1 < arg_580_1.time_ and arg_580_1.time_ <= var_583_1 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				local var_583_3 = arg_580_1:FormatText(StoryNameCfg[7].name)

				arg_580_1.leftNameTxt_.text = var_583_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, true)
				arg_580_1.iconController_:SetSelectedState("hero")

				arg_580_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_580_1.callingController_:SetSelectedState("normal")

				arg_580_1.keyicon_.color = Color.New(1, 1, 1)
				arg_580_1.icon_.color = Color.New(1, 1, 1)

				local var_583_4 = arg_580_1:GetWordFromCfg(1106606147)
				local var_583_5 = arg_580_1:FormatText(var_583_4.content)

				arg_580_1.text_.text = var_583_5

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_6 = 26
				local var_583_7 = utf8.len(var_583_5)
				local var_583_8 = var_583_6 <= 0 and var_583_2 or var_583_2 * (var_583_7 / var_583_6)

				if var_583_8 > 0 and var_583_2 < var_583_8 then
					arg_580_1.talkMaxDuration = var_583_8

					if var_583_8 + var_583_1 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_8 + var_583_1
					end
				end

				arg_580_1.text_.text = var_583_5
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)
				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_9 = math.max(var_583_2, arg_580_1.talkMaxDuration)

			if var_583_1 <= arg_580_1.time_ and arg_580_1.time_ < var_583_1 + var_583_9 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_1) / var_583_9

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_1 + var_583_9 and arg_580_1.time_ < var_583_1 + var_583_9 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play1106606148 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 1106606148
		arg_584_1.duration_ = 2.83

		local var_584_0 = {
			zh = 2.833,
			ja = 2.366666666666
		}
		local var_584_1 = manager.audio:GetLocalizationFlag()

		if var_584_0[var_584_1] ~= nil then
			arg_584_1.duration_ = var_584_0[var_584_1]
		end

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play1106606149(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = arg_584_1.actors_["1066ui_story"].transform
			local var_587_1 = 0

			if var_587_1 < arg_584_1.time_ and arg_584_1.time_ <= var_587_1 + arg_587_0 then
				arg_584_1.var_.moveOldPos1066ui_story = var_587_0.localPosition
			end

			local var_587_2 = 0.001

			if var_587_1 <= arg_584_1.time_ and arg_584_1.time_ < var_587_1 + var_587_2 then
				local var_587_3 = (arg_584_1.time_ - var_587_1) / var_587_2
				local var_587_4 = Vector3.New(0, -0.77, -6.1)

				var_587_0.localPosition = Vector3.Lerp(arg_584_1.var_.moveOldPos1066ui_story, var_587_4, var_587_3)

				local var_587_5 = manager.ui.mainCamera.transform.position - var_587_0.position

				var_587_0.forward = Vector3.New(var_587_5.x, var_587_5.y, var_587_5.z)

				local var_587_6 = var_587_0.localEulerAngles

				var_587_6.z = 0
				var_587_6.x = 0
				var_587_0.localEulerAngles = var_587_6
			end

			if arg_584_1.time_ >= var_587_1 + var_587_2 and arg_584_1.time_ < var_587_1 + var_587_2 + arg_587_0 then
				var_587_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_587_7 = manager.ui.mainCamera.transform.position - var_587_0.position

				var_587_0.forward = Vector3.New(var_587_7.x, var_587_7.y, var_587_7.z)

				local var_587_8 = var_587_0.localEulerAngles

				var_587_8.z = 0
				var_587_8.x = 0
				var_587_0.localEulerAngles = var_587_8
			end

			local var_587_9 = arg_584_1.actors_["1066ui_story"]
			local var_587_10 = 0

			if var_587_10 < arg_584_1.time_ and arg_584_1.time_ <= var_587_10 + arg_587_0 and not isNil(var_587_9) and arg_584_1.var_.characterEffect1066ui_story == nil then
				arg_584_1.var_.characterEffect1066ui_story = var_587_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_587_11 = 0.200000002980232

			if var_587_10 <= arg_584_1.time_ and arg_584_1.time_ < var_587_10 + var_587_11 and not isNil(var_587_9) then
				local var_587_12 = (arg_584_1.time_ - var_587_10) / var_587_11

				if arg_584_1.var_.characterEffect1066ui_story and not isNil(var_587_9) then
					arg_584_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_584_1.time_ >= var_587_10 + var_587_11 and arg_584_1.time_ < var_587_10 + var_587_11 + arg_587_0 and not isNil(var_587_9) and arg_584_1.var_.characterEffect1066ui_story then
				arg_584_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_587_13 = 0

			if var_587_13 < arg_584_1.time_ and arg_584_1.time_ <= var_587_13 + arg_587_0 then
				arg_584_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_587_14 = 0

			if var_587_14 < arg_584_1.time_ and arg_584_1.time_ <= var_587_14 + arg_587_0 then
				arg_584_1.allBtn_.enabled = false
			end

			local var_587_15 = 2.36666666666667

			if arg_584_1.time_ >= var_587_14 + var_587_15 and arg_584_1.time_ < var_587_14 + var_587_15 + arg_587_0 then
				arg_584_1.allBtn_.enabled = true
			end

			local var_587_16 = 0
			local var_587_17 = 0.5

			if var_587_16 < arg_584_1.time_ and arg_584_1.time_ <= var_587_16 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				local var_587_18 = arg_584_1:FormatText(StoryNameCfg[32].name)

				arg_584_1.leftNameTxt_.text = var_587_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_19 = arg_584_1:GetWordFromCfg(1106606148)
				local var_587_20 = arg_584_1:FormatText(var_587_19.content)

				arg_584_1.text_.text = var_587_20

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_21 = 20
				local var_587_22 = utf8.len(var_587_20)
				local var_587_23 = var_587_21 <= 0 and var_587_17 or var_587_17 * (var_587_22 / var_587_21)

				if var_587_23 > 0 and var_587_17 < var_587_23 then
					arg_584_1.talkMaxDuration = var_587_23

					if var_587_23 + var_587_16 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_23 + var_587_16
					end
				end

				arg_584_1.text_.text = var_587_20
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606148", "story_v_side_new_1106606.awb") ~= 0 then
					local var_587_24 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606148", "story_v_side_new_1106606.awb") / 1000

					if var_587_24 + var_587_16 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_24 + var_587_16
					end

					if var_587_19.prefab_name ~= "" and arg_584_1.actors_[var_587_19.prefab_name] ~= nil then
						local var_587_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_19.prefab_name].transform, "story_v_side_new_1106606", "1106606148", "story_v_side_new_1106606.awb")

						arg_584_1:RecordAudio("1106606148", var_587_25)
						arg_584_1:RecordAudio("1106606148", var_587_25)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606148", "story_v_side_new_1106606.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606148", "story_v_side_new_1106606.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_26 = math.max(var_587_17, arg_584_1.talkMaxDuration)

			if var_587_16 <= arg_584_1.time_ and arg_584_1.time_ < var_587_16 + var_587_26 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_16) / var_587_26

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_16 + var_587_26 and arg_584_1.time_ < var_587_16 + var_587_26 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_584_1:InitPlayNodeList()
	end,
	Play1106606149 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 1106606149
		arg_588_1.duration_ = 15.67

		local var_588_0 = {
			zh = 15.666,
			ja = 15
		}
		local var_588_1 = manager.audio:GetLocalizationFlag()

		if var_588_0[var_588_1] ~= nil then
			arg_588_1.duration_ = var_588_0[var_588_1]
		end

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play1106606150(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = 0

			if var_591_0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_0 + arg_591_0 then
				arg_588_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_591_1 = 0
			local var_591_2 = 1.675

			if var_591_1 < arg_588_1.time_ and arg_588_1.time_ <= var_591_1 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				local var_591_3 = arg_588_1:FormatText(StoryNameCfg[32].name)

				arg_588_1.leftNameTxt_.text = var_591_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_4 = arg_588_1:GetWordFromCfg(1106606149)
				local var_591_5 = arg_588_1:FormatText(var_591_4.content)

				arg_588_1.text_.text = var_591_5

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_6 = 67
				local var_591_7 = utf8.len(var_591_5)
				local var_591_8 = var_591_6 <= 0 and var_591_2 or var_591_2 * (var_591_7 / var_591_6)

				if var_591_8 > 0 and var_591_2 < var_591_8 then
					arg_588_1.talkMaxDuration = var_591_8

					if var_591_8 + var_591_1 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_8 + var_591_1
					end
				end

				arg_588_1.text_.text = var_591_5
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606149", "story_v_side_new_1106606.awb") ~= 0 then
					local var_591_9 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606149", "story_v_side_new_1106606.awb") / 1000

					if var_591_9 + var_591_1 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_9 + var_591_1
					end

					if var_591_4.prefab_name ~= "" and arg_588_1.actors_[var_591_4.prefab_name] ~= nil then
						local var_591_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_588_1.actors_[var_591_4.prefab_name].transform, "story_v_side_new_1106606", "1106606149", "story_v_side_new_1106606.awb")

						arg_588_1:RecordAudio("1106606149", var_591_10)
						arg_588_1:RecordAudio("1106606149", var_591_10)
					else
						arg_588_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606149", "story_v_side_new_1106606.awb")
					end

					arg_588_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606149", "story_v_side_new_1106606.awb")
				end

				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_11 = math.max(var_591_2, arg_588_1.talkMaxDuration)

			if var_591_1 <= arg_588_1.time_ and arg_588_1.time_ < var_591_1 + var_591_11 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_1) / var_591_11

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_1 + var_591_11 and arg_588_1.time_ < var_591_1 + var_591_11 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play1106606150 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 1106606150
		arg_592_1.duration_ = 14.1

		local var_592_0 = {
			zh = 12.366,
			ja = 14.1
		}
		local var_592_1 = manager.audio:GetLocalizationFlag()

		if var_592_0[var_592_1] ~= nil then
			arg_592_1.duration_ = var_592_0[var_592_1]
		end

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play1106606151(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = 0
			local var_595_1 = 1.25

			if var_595_0 < arg_592_1.time_ and arg_592_1.time_ <= var_595_0 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				local var_595_2 = arg_592_1:FormatText(StoryNameCfg[32].name)

				arg_592_1.leftNameTxt_.text = var_595_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, false)
				arg_592_1.callingController_:SetSelectedState("normal")

				local var_595_3 = arg_592_1:GetWordFromCfg(1106606150)
				local var_595_4 = arg_592_1:FormatText(var_595_3.content)

				arg_592_1.text_.text = var_595_4

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_5 = 50
				local var_595_6 = utf8.len(var_595_4)
				local var_595_7 = var_595_5 <= 0 and var_595_1 or var_595_1 * (var_595_6 / var_595_5)

				if var_595_7 > 0 and var_595_1 < var_595_7 then
					arg_592_1.talkMaxDuration = var_595_7

					if var_595_7 + var_595_0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_7 + var_595_0
					end
				end

				arg_592_1.text_.text = var_595_4
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606150", "story_v_side_new_1106606.awb") ~= 0 then
					local var_595_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606150", "story_v_side_new_1106606.awb") / 1000

					if var_595_8 + var_595_0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_8 + var_595_0
					end

					if var_595_3.prefab_name ~= "" and arg_592_1.actors_[var_595_3.prefab_name] ~= nil then
						local var_595_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_592_1.actors_[var_595_3.prefab_name].transform, "story_v_side_new_1106606", "1106606150", "story_v_side_new_1106606.awb")

						arg_592_1:RecordAudio("1106606150", var_595_9)
						arg_592_1:RecordAudio("1106606150", var_595_9)
					else
						arg_592_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606150", "story_v_side_new_1106606.awb")
					end

					arg_592_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606150", "story_v_side_new_1106606.awb")
				end

				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_10 = math.max(var_595_1, arg_592_1.talkMaxDuration)

			if var_595_0 <= arg_592_1.time_ and arg_592_1.time_ < var_595_0 + var_595_10 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_0) / var_595_10

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_0 + var_595_10 and arg_592_1.time_ < var_595_0 + var_595_10 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play1106606151 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 1106606151
		arg_596_1.duration_ = 11.4

		local var_596_0 = {
			zh = 11.4,
			ja = 4.833
		}
		local var_596_1 = manager.audio:GetLocalizationFlag()

		if var_596_0[var_596_1] ~= nil then
			arg_596_1.duration_ = var_596_0[var_596_1]
		end

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play1106606152(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = 0

			if var_599_0 < arg_596_1.time_ and arg_596_1.time_ <= var_599_0 + arg_599_0 then
				arg_596_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_2")
			end

			local var_599_1 = 0

			if var_599_1 < arg_596_1.time_ and arg_596_1.time_ <= var_599_1 + arg_599_0 then
				arg_596_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_599_2 = 0
			local var_599_3 = 1.375

			if var_599_2 < arg_596_1.time_ and arg_596_1.time_ <= var_599_2 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				local var_599_4 = arg_596_1:FormatText(StoryNameCfg[32].name)

				arg_596_1.leftNameTxt_.text = var_599_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_5 = arg_596_1:GetWordFromCfg(1106606151)
				local var_599_6 = arg_596_1:FormatText(var_599_5.content)

				arg_596_1.text_.text = var_599_6

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_7 = 55
				local var_599_8 = utf8.len(var_599_6)
				local var_599_9 = var_599_7 <= 0 and var_599_3 or var_599_3 * (var_599_8 / var_599_7)

				if var_599_9 > 0 and var_599_3 < var_599_9 then
					arg_596_1.talkMaxDuration = var_599_9

					if var_599_9 + var_599_2 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_9 + var_599_2
					end
				end

				arg_596_1.text_.text = var_599_6
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606151", "story_v_side_new_1106606.awb") ~= 0 then
					local var_599_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606151", "story_v_side_new_1106606.awb") / 1000

					if var_599_10 + var_599_2 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_10 + var_599_2
					end

					if var_599_5.prefab_name ~= "" and arg_596_1.actors_[var_599_5.prefab_name] ~= nil then
						local var_599_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_5.prefab_name].transform, "story_v_side_new_1106606", "1106606151", "story_v_side_new_1106606.awb")

						arg_596_1:RecordAudio("1106606151", var_599_11)
						arg_596_1:RecordAudio("1106606151", var_599_11)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606151", "story_v_side_new_1106606.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606151", "story_v_side_new_1106606.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_12 = math.max(var_599_3, arg_596_1.talkMaxDuration)

			if var_599_2 <= arg_596_1.time_ and arg_596_1.time_ < var_599_2 + var_599_12 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_2) / var_599_12

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_2 + var_599_12 and arg_596_1.time_ < var_599_2 + var_599_12 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play1106606152 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 1106606152
		arg_600_1.duration_ = 5

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play1106606153(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = arg_600_1.actors_["1066ui_story"]
			local var_603_1 = 0

			if var_603_1 < arg_600_1.time_ and arg_600_1.time_ <= var_603_1 + arg_603_0 and not isNil(var_603_0) and arg_600_1.var_.characterEffect1066ui_story == nil then
				arg_600_1.var_.characterEffect1066ui_story = var_603_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_603_2 = 0.200000002980232

			if var_603_1 <= arg_600_1.time_ and arg_600_1.time_ < var_603_1 + var_603_2 and not isNil(var_603_0) then
				local var_603_3 = (arg_600_1.time_ - var_603_1) / var_603_2

				if arg_600_1.var_.characterEffect1066ui_story and not isNil(var_603_0) then
					local var_603_4 = Mathf.Lerp(0, 0.5, var_603_3)

					arg_600_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_600_1.var_.characterEffect1066ui_story.fillRatio = var_603_4
				end
			end

			if arg_600_1.time_ >= var_603_1 + var_603_2 and arg_600_1.time_ < var_603_1 + var_603_2 + arg_603_0 and not isNil(var_603_0) and arg_600_1.var_.characterEffect1066ui_story then
				local var_603_5 = 0.5

				arg_600_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_600_1.var_.characterEffect1066ui_story.fillRatio = var_603_5
			end

			local var_603_6 = 0
			local var_603_7 = 0.475

			if var_603_6 < arg_600_1.time_ and arg_600_1.time_ <= var_603_6 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, false)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_600_1.iconTrs_.gameObject, false)
				arg_600_1.callingController_:SetSelectedState("normal")

				local var_603_8 = arg_600_1:GetWordFromCfg(1106606152)
				local var_603_9 = arg_600_1:FormatText(var_603_8.content)

				arg_600_1.text_.text = var_603_9

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_10 = 19
				local var_603_11 = utf8.len(var_603_9)
				local var_603_12 = var_603_10 <= 0 and var_603_7 or var_603_7 * (var_603_11 / var_603_10)

				if var_603_12 > 0 and var_603_7 < var_603_12 then
					arg_600_1.talkMaxDuration = var_603_12

					if var_603_12 + var_603_6 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_12 + var_603_6
					end
				end

				arg_600_1.text_.text = var_603_9
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)
				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_13 = math.max(var_603_7, arg_600_1.talkMaxDuration)

			if var_603_6 <= arg_600_1.time_ and arg_600_1.time_ < var_603_6 + var_603_13 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_6) / var_603_13

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_6 + var_603_13 and arg_600_1.time_ < var_603_6 + var_603_13 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play1106606153 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 1106606153
		arg_604_1.duration_ = 13.43

		local var_604_0 = {
			zh = 7.6,
			ja = 13.433
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play1106606154(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = arg_604_1.actors_["1066ui_story"].transform
			local var_607_1 = 0

			if var_607_1 < arg_604_1.time_ and arg_604_1.time_ <= var_607_1 + arg_607_0 then
				arg_604_1.var_.moveOldPos1066ui_story = var_607_0.localPosition
			end

			local var_607_2 = 0.001

			if var_607_1 <= arg_604_1.time_ and arg_604_1.time_ < var_607_1 + var_607_2 then
				local var_607_3 = (arg_604_1.time_ - var_607_1) / var_607_2
				local var_607_4 = Vector3.New(0, -0.77, -6.1)

				var_607_0.localPosition = Vector3.Lerp(arg_604_1.var_.moveOldPos1066ui_story, var_607_4, var_607_3)

				local var_607_5 = manager.ui.mainCamera.transform.position - var_607_0.position

				var_607_0.forward = Vector3.New(var_607_5.x, var_607_5.y, var_607_5.z)

				local var_607_6 = var_607_0.localEulerAngles

				var_607_6.z = 0
				var_607_6.x = 0
				var_607_0.localEulerAngles = var_607_6
			end

			if arg_604_1.time_ >= var_607_1 + var_607_2 and arg_604_1.time_ < var_607_1 + var_607_2 + arg_607_0 then
				var_607_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_607_7 = manager.ui.mainCamera.transform.position - var_607_0.position

				var_607_0.forward = Vector3.New(var_607_7.x, var_607_7.y, var_607_7.z)

				local var_607_8 = var_607_0.localEulerAngles

				var_607_8.z = 0
				var_607_8.x = 0
				var_607_0.localEulerAngles = var_607_8
			end

			local var_607_9 = arg_604_1.actors_["1066ui_story"]
			local var_607_10 = 0

			if var_607_10 < arg_604_1.time_ and arg_604_1.time_ <= var_607_10 + arg_607_0 and not isNil(var_607_9) and arg_604_1.var_.characterEffect1066ui_story == nil then
				arg_604_1.var_.characterEffect1066ui_story = var_607_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_607_11 = 0.200000002980232

			if var_607_10 <= arg_604_1.time_ and arg_604_1.time_ < var_607_10 + var_607_11 and not isNil(var_607_9) then
				local var_607_12 = (arg_604_1.time_ - var_607_10) / var_607_11

				if arg_604_1.var_.characterEffect1066ui_story and not isNil(var_607_9) then
					arg_604_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_604_1.time_ >= var_607_10 + var_607_11 and arg_604_1.time_ < var_607_10 + var_607_11 + arg_607_0 and not isNil(var_607_9) and arg_604_1.var_.characterEffect1066ui_story then
				arg_604_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_607_13 = 0

			if var_607_13 < arg_604_1.time_ and arg_604_1.time_ <= var_607_13 + arg_607_0 then
				arg_604_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_607_14 = 0
			local var_607_15 = 0.875

			if var_607_14 < arg_604_1.time_ and arg_604_1.time_ <= var_607_14 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				local var_607_16 = arg_604_1:FormatText(StoryNameCfg[32].name)

				arg_604_1.leftNameTxt_.text = var_607_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_17 = arg_604_1:GetWordFromCfg(1106606153)
				local var_607_18 = arg_604_1:FormatText(var_607_17.content)

				arg_604_1.text_.text = var_607_18

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_19 = 35
				local var_607_20 = utf8.len(var_607_18)
				local var_607_21 = var_607_19 <= 0 and var_607_15 or var_607_15 * (var_607_20 / var_607_19)

				if var_607_21 > 0 and var_607_15 < var_607_21 then
					arg_604_1.talkMaxDuration = var_607_21

					if var_607_21 + var_607_14 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_21 + var_607_14
					end
				end

				arg_604_1.text_.text = var_607_18
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606153", "story_v_side_new_1106606.awb") ~= 0 then
					local var_607_22 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606153", "story_v_side_new_1106606.awb") / 1000

					if var_607_22 + var_607_14 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_22 + var_607_14
					end

					if var_607_17.prefab_name ~= "" and arg_604_1.actors_[var_607_17.prefab_name] ~= nil then
						local var_607_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_17.prefab_name].transform, "story_v_side_new_1106606", "1106606153", "story_v_side_new_1106606.awb")

						arg_604_1:RecordAudio("1106606153", var_607_23)
						arg_604_1:RecordAudio("1106606153", var_607_23)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606153", "story_v_side_new_1106606.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606153", "story_v_side_new_1106606.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_24 = math.max(var_607_15, arg_604_1.talkMaxDuration)

			if var_607_14 <= arg_604_1.time_ and arg_604_1.time_ < var_607_14 + var_607_24 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_14) / var_607_24

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_14 + var_607_24 and arg_604_1.time_ < var_607_14 + var_607_24 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_604_1:InitPlayNodeList()
	end,
	Play1106606154 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 1106606154
		arg_608_1.duration_ = 5.73

		local var_608_0 = {
			zh = 4.933,
			ja = 5.733
		}
		local var_608_1 = manager.audio:GetLocalizationFlag()

		if var_608_0[var_608_1] ~= nil then
			arg_608_1.duration_ = var_608_0[var_608_1]
		end

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play1106606155(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = arg_608_1.actors_["1066ui_story"].transform
			local var_611_1 = 0

			if var_611_1 < arg_608_1.time_ and arg_608_1.time_ <= var_611_1 + arg_611_0 then
				arg_608_1.var_.moveOldPos1066ui_story = var_611_0.localPosition
			end

			local var_611_2 = 0.001

			if var_611_1 <= arg_608_1.time_ and arg_608_1.time_ < var_611_1 + var_611_2 then
				local var_611_3 = (arg_608_1.time_ - var_611_1) / var_611_2
				local var_611_4 = Vector3.New(0, -0.77, -6.1)

				var_611_0.localPosition = Vector3.Lerp(arg_608_1.var_.moveOldPos1066ui_story, var_611_4, var_611_3)

				local var_611_5 = manager.ui.mainCamera.transform.position - var_611_0.position

				var_611_0.forward = Vector3.New(var_611_5.x, var_611_5.y, var_611_5.z)

				local var_611_6 = var_611_0.localEulerAngles

				var_611_6.z = 0
				var_611_6.x = 0
				var_611_0.localEulerAngles = var_611_6
			end

			if arg_608_1.time_ >= var_611_1 + var_611_2 and arg_608_1.time_ < var_611_1 + var_611_2 + arg_611_0 then
				var_611_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_611_7 = manager.ui.mainCamera.transform.position - var_611_0.position

				var_611_0.forward = Vector3.New(var_611_7.x, var_611_7.y, var_611_7.z)

				local var_611_8 = var_611_0.localEulerAngles

				var_611_8.z = 0
				var_611_8.x = 0
				var_611_0.localEulerAngles = var_611_8
			end

			local var_611_9 = arg_608_1.actors_["1066ui_story"]
			local var_611_10 = 0

			if var_611_10 < arg_608_1.time_ and arg_608_1.time_ <= var_611_10 + arg_611_0 and not isNil(var_611_9) and arg_608_1.var_.characterEffect1066ui_story == nil then
				arg_608_1.var_.characterEffect1066ui_story = var_611_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_611_11 = 0.200000002980232

			if var_611_10 <= arg_608_1.time_ and arg_608_1.time_ < var_611_10 + var_611_11 and not isNil(var_611_9) then
				local var_611_12 = (arg_608_1.time_ - var_611_10) / var_611_11

				if arg_608_1.var_.characterEffect1066ui_story and not isNil(var_611_9) then
					arg_608_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_608_1.time_ >= var_611_10 + var_611_11 and arg_608_1.time_ < var_611_10 + var_611_11 + arg_611_0 and not isNil(var_611_9) and arg_608_1.var_.characterEffect1066ui_story then
				arg_608_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_611_13 = 0

			if var_611_13 < arg_608_1.time_ and arg_608_1.time_ <= var_611_13 + arg_611_0 then
				arg_608_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_611_14 = 0

			if var_611_14 < arg_608_1.time_ and arg_608_1.time_ <= var_611_14 + arg_611_0 then
				arg_608_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_611_15 = 0
			local var_611_16 = 0.525

			if var_611_15 < arg_608_1.time_ and arg_608_1.time_ <= var_611_15 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				local var_611_17 = arg_608_1:FormatText(StoryNameCfg[32].name)

				arg_608_1.leftNameTxt_.text = var_611_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_18 = arg_608_1:GetWordFromCfg(1106606154)
				local var_611_19 = arg_608_1:FormatText(var_611_18.content)

				arg_608_1.text_.text = var_611_19

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_20 = 21
				local var_611_21 = utf8.len(var_611_19)
				local var_611_22 = var_611_20 <= 0 and var_611_16 or var_611_16 * (var_611_21 / var_611_20)

				if var_611_22 > 0 and var_611_16 < var_611_22 then
					arg_608_1.talkMaxDuration = var_611_22

					if var_611_22 + var_611_15 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_22 + var_611_15
					end
				end

				arg_608_1.text_.text = var_611_19
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606154", "story_v_side_new_1106606.awb") ~= 0 then
					local var_611_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606154", "story_v_side_new_1106606.awb") / 1000

					if var_611_23 + var_611_15 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_23 + var_611_15
					end

					if var_611_18.prefab_name ~= "" and arg_608_1.actors_[var_611_18.prefab_name] ~= nil then
						local var_611_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_608_1.actors_[var_611_18.prefab_name].transform, "story_v_side_new_1106606", "1106606154", "story_v_side_new_1106606.awb")

						arg_608_1:RecordAudio("1106606154", var_611_24)
						arg_608_1:RecordAudio("1106606154", var_611_24)
					else
						arg_608_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606154", "story_v_side_new_1106606.awb")
					end

					arg_608_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606154", "story_v_side_new_1106606.awb")
				end

				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_25 = math.max(var_611_16, arg_608_1.talkMaxDuration)

			if var_611_15 <= arg_608_1.time_ and arg_608_1.time_ < var_611_15 + var_611_25 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_15) / var_611_25

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_15 + var_611_25 and arg_608_1.time_ < var_611_15 + var_611_25 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_608_1:InitPlayNodeList()
	end,
	Play1106606155 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 1106606155
		arg_612_1.duration_ = 17.4

		local var_612_0 = {
			zh = 10.8,
			ja = 17.4
		}
		local var_612_1 = manager.audio:GetLocalizationFlag()

		if var_612_0[var_612_1] ~= nil then
			arg_612_1.duration_ = var_612_0[var_612_1]
		end

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play1106606156(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = arg_612_1.actors_["1066ui_story"].transform
			local var_615_1 = 0

			if var_615_1 < arg_612_1.time_ and arg_612_1.time_ <= var_615_1 + arg_615_0 then
				arg_612_1.var_.moveOldPos1066ui_story = var_615_0.localPosition
			end

			local var_615_2 = 0.001

			if var_615_1 <= arg_612_1.time_ and arg_612_1.time_ < var_615_1 + var_615_2 then
				local var_615_3 = (arg_612_1.time_ - var_615_1) / var_615_2
				local var_615_4 = Vector3.New(0, -0.77, -6.1)

				var_615_0.localPosition = Vector3.Lerp(arg_612_1.var_.moveOldPos1066ui_story, var_615_4, var_615_3)

				local var_615_5 = manager.ui.mainCamera.transform.position - var_615_0.position

				var_615_0.forward = Vector3.New(var_615_5.x, var_615_5.y, var_615_5.z)

				local var_615_6 = var_615_0.localEulerAngles

				var_615_6.z = 0
				var_615_6.x = 0
				var_615_0.localEulerAngles = var_615_6
			end

			if arg_612_1.time_ >= var_615_1 + var_615_2 and arg_612_1.time_ < var_615_1 + var_615_2 + arg_615_0 then
				var_615_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_615_7 = manager.ui.mainCamera.transform.position - var_615_0.position

				var_615_0.forward = Vector3.New(var_615_7.x, var_615_7.y, var_615_7.z)

				local var_615_8 = var_615_0.localEulerAngles

				var_615_8.z = 0
				var_615_8.x = 0
				var_615_0.localEulerAngles = var_615_8
			end

			local var_615_9 = arg_612_1.actors_["1066ui_story"]
			local var_615_10 = 0

			if var_615_10 < arg_612_1.time_ and arg_612_1.time_ <= var_615_10 + arg_615_0 and not isNil(var_615_9) and arg_612_1.var_.characterEffect1066ui_story == nil then
				arg_612_1.var_.characterEffect1066ui_story = var_615_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_615_11 = 0.200000002980232

			if var_615_10 <= arg_612_1.time_ and arg_612_1.time_ < var_615_10 + var_615_11 and not isNil(var_615_9) then
				local var_615_12 = (arg_612_1.time_ - var_615_10) / var_615_11

				if arg_612_1.var_.characterEffect1066ui_story and not isNil(var_615_9) then
					arg_612_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_612_1.time_ >= var_615_10 + var_615_11 and arg_612_1.time_ < var_615_10 + var_615_11 + arg_615_0 and not isNil(var_615_9) and arg_612_1.var_.characterEffect1066ui_story then
				arg_612_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_615_13 = 0

			if var_615_13 < arg_612_1.time_ and arg_612_1.time_ <= var_615_13 + arg_615_0 then
				arg_612_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			local var_615_14 = 0

			if var_615_14 < arg_612_1.time_ and arg_612_1.time_ <= var_615_14 + arg_615_0 then
				arg_612_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_615_15 = 0
			local var_615_16 = 1.25

			if var_615_15 < arg_612_1.time_ and arg_612_1.time_ <= var_615_15 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				local var_615_17 = arg_612_1:FormatText(StoryNameCfg[32].name)

				arg_612_1.leftNameTxt_.text = var_615_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_18 = arg_612_1:GetWordFromCfg(1106606155)
				local var_615_19 = arg_612_1:FormatText(var_615_18.content)

				arg_612_1.text_.text = var_615_19

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_20 = 50
				local var_615_21 = utf8.len(var_615_19)
				local var_615_22 = var_615_20 <= 0 and var_615_16 or var_615_16 * (var_615_21 / var_615_20)

				if var_615_22 > 0 and var_615_16 < var_615_22 then
					arg_612_1.talkMaxDuration = var_615_22

					if var_615_22 + var_615_15 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_22 + var_615_15
					end
				end

				arg_612_1.text_.text = var_615_19
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606155", "story_v_side_new_1106606.awb") ~= 0 then
					local var_615_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606155", "story_v_side_new_1106606.awb") / 1000

					if var_615_23 + var_615_15 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_23 + var_615_15
					end

					if var_615_18.prefab_name ~= "" and arg_612_1.actors_[var_615_18.prefab_name] ~= nil then
						local var_615_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_612_1.actors_[var_615_18.prefab_name].transform, "story_v_side_new_1106606", "1106606155", "story_v_side_new_1106606.awb")

						arg_612_1:RecordAudio("1106606155", var_615_24)
						arg_612_1:RecordAudio("1106606155", var_615_24)
					else
						arg_612_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606155", "story_v_side_new_1106606.awb")
					end

					arg_612_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606155", "story_v_side_new_1106606.awb")
				end

				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_25 = math.max(var_615_16, arg_612_1.talkMaxDuration)

			if var_615_15 <= arg_612_1.time_ and arg_612_1.time_ < var_615_15 + var_615_25 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_15) / var_615_25

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_15 + var_615_25 and arg_612_1.time_ < var_615_15 + var_615_25 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_612_1:InitPlayNodeList()
	end,
	Play1106606156 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 1106606156
		arg_616_1.duration_ = 5

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play1106606157(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = arg_616_1.actors_["1066ui_story"]
			local var_619_1 = 0

			if var_619_1 < arg_616_1.time_ and arg_616_1.time_ <= var_619_1 + arg_619_0 and not isNil(var_619_0) and arg_616_1.var_.characterEffect1066ui_story == nil then
				arg_616_1.var_.characterEffect1066ui_story = var_619_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_619_2 = 0.200000002980232

			if var_619_1 <= arg_616_1.time_ and arg_616_1.time_ < var_619_1 + var_619_2 and not isNil(var_619_0) then
				local var_619_3 = (arg_616_1.time_ - var_619_1) / var_619_2

				if arg_616_1.var_.characterEffect1066ui_story and not isNil(var_619_0) then
					local var_619_4 = Mathf.Lerp(0, 0.5, var_619_3)

					arg_616_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_616_1.var_.characterEffect1066ui_story.fillRatio = var_619_4
				end
			end

			if arg_616_1.time_ >= var_619_1 + var_619_2 and arg_616_1.time_ < var_619_1 + var_619_2 + arg_619_0 and not isNil(var_619_0) and arg_616_1.var_.characterEffect1066ui_story then
				local var_619_5 = 0.5

				arg_616_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_616_1.var_.characterEffect1066ui_story.fillRatio = var_619_5
			end

			local var_619_6 = 0
			local var_619_7 = 0.425

			if var_619_6 < arg_616_1.time_ and arg_616_1.time_ <= var_619_6 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, false)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_8 = arg_616_1:GetWordFromCfg(1106606156)
				local var_619_9 = arg_616_1:FormatText(var_619_8.content)

				arg_616_1.text_.text = var_619_9

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_10 = 17
				local var_619_11 = utf8.len(var_619_9)
				local var_619_12 = var_619_10 <= 0 and var_619_7 or var_619_7 * (var_619_11 / var_619_10)

				if var_619_12 > 0 and var_619_7 < var_619_12 then
					arg_616_1.talkMaxDuration = var_619_12

					if var_619_12 + var_619_6 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_12 + var_619_6
					end
				end

				arg_616_1.text_.text = var_619_9
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)
				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_13 = math.max(var_619_7, arg_616_1.talkMaxDuration)

			if var_619_6 <= arg_616_1.time_ and arg_616_1.time_ < var_619_6 + var_619_13 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_6) / var_619_13

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_6 + var_619_13 and arg_616_1.time_ < var_619_6 + var_619_13 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play1106606157 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 1106606157
		arg_620_1.duration_ = 9.3

		local var_620_0 = {
			zh = 9.3,
			ja = 4.733
		}
		local var_620_1 = manager.audio:GetLocalizationFlag()

		if var_620_0[var_620_1] ~= nil then
			arg_620_1.duration_ = var_620_0[var_620_1]
		end

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play1106606158(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = arg_620_1.actors_["1066ui_story"].transform
			local var_623_1 = 0

			if var_623_1 < arg_620_1.time_ and arg_620_1.time_ <= var_623_1 + arg_623_0 then
				arg_620_1.var_.moveOldPos1066ui_story = var_623_0.localPosition
			end

			local var_623_2 = 0.001

			if var_623_1 <= arg_620_1.time_ and arg_620_1.time_ < var_623_1 + var_623_2 then
				local var_623_3 = (arg_620_1.time_ - var_623_1) / var_623_2
				local var_623_4 = Vector3.New(0, -0.77, -6.1)

				var_623_0.localPosition = Vector3.Lerp(arg_620_1.var_.moveOldPos1066ui_story, var_623_4, var_623_3)

				local var_623_5 = manager.ui.mainCamera.transform.position - var_623_0.position

				var_623_0.forward = Vector3.New(var_623_5.x, var_623_5.y, var_623_5.z)

				local var_623_6 = var_623_0.localEulerAngles

				var_623_6.z = 0
				var_623_6.x = 0
				var_623_0.localEulerAngles = var_623_6
			end

			if arg_620_1.time_ >= var_623_1 + var_623_2 and arg_620_1.time_ < var_623_1 + var_623_2 + arg_623_0 then
				var_623_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_623_7 = manager.ui.mainCamera.transform.position - var_623_0.position

				var_623_0.forward = Vector3.New(var_623_7.x, var_623_7.y, var_623_7.z)

				local var_623_8 = var_623_0.localEulerAngles

				var_623_8.z = 0
				var_623_8.x = 0
				var_623_0.localEulerAngles = var_623_8
			end

			local var_623_9 = arg_620_1.actors_["1066ui_story"]
			local var_623_10 = 0

			if var_623_10 < arg_620_1.time_ and arg_620_1.time_ <= var_623_10 + arg_623_0 and not isNil(var_623_9) and arg_620_1.var_.characterEffect1066ui_story == nil then
				arg_620_1.var_.characterEffect1066ui_story = var_623_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_623_11 = 0.200000002980232

			if var_623_10 <= arg_620_1.time_ and arg_620_1.time_ < var_623_10 + var_623_11 and not isNil(var_623_9) then
				local var_623_12 = (arg_620_1.time_ - var_623_10) / var_623_11

				if arg_620_1.var_.characterEffect1066ui_story and not isNil(var_623_9) then
					arg_620_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_620_1.time_ >= var_623_10 + var_623_11 and arg_620_1.time_ < var_623_10 + var_623_11 + arg_623_0 and not isNil(var_623_9) and arg_620_1.var_.characterEffect1066ui_story then
				arg_620_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_623_13 = 0

			if var_623_13 < arg_620_1.time_ and arg_620_1.time_ <= var_623_13 + arg_623_0 then
				arg_620_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_2")
			end

			local var_623_14 = 0

			if var_623_14 < arg_620_1.time_ and arg_620_1.time_ <= var_623_14 + arg_623_0 then
				arg_620_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_623_15 = 0
			local var_623_16 = 0.75

			if var_623_15 < arg_620_1.time_ and arg_620_1.time_ <= var_623_15 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, true)

				local var_623_17 = arg_620_1:FormatText(StoryNameCfg[32].name)

				arg_620_1.leftNameTxt_.text = var_623_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_18 = arg_620_1:GetWordFromCfg(1106606157)
				local var_623_19 = arg_620_1:FormatText(var_623_18.content)

				arg_620_1.text_.text = var_623_19

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_20 = 30
				local var_623_21 = utf8.len(var_623_19)
				local var_623_22 = var_623_20 <= 0 and var_623_16 or var_623_16 * (var_623_21 / var_623_20)

				if var_623_22 > 0 and var_623_16 < var_623_22 then
					arg_620_1.talkMaxDuration = var_623_22

					if var_623_22 + var_623_15 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_22 + var_623_15
					end
				end

				arg_620_1.text_.text = var_623_19
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606157", "story_v_side_new_1106606.awb") ~= 0 then
					local var_623_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606157", "story_v_side_new_1106606.awb") / 1000

					if var_623_23 + var_623_15 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_23 + var_623_15
					end

					if var_623_18.prefab_name ~= "" and arg_620_1.actors_[var_623_18.prefab_name] ~= nil then
						local var_623_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_620_1.actors_[var_623_18.prefab_name].transform, "story_v_side_new_1106606", "1106606157", "story_v_side_new_1106606.awb")

						arg_620_1:RecordAudio("1106606157", var_623_24)
						arg_620_1:RecordAudio("1106606157", var_623_24)
					else
						arg_620_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606157", "story_v_side_new_1106606.awb")
					end

					arg_620_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606157", "story_v_side_new_1106606.awb")
				end

				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_25 = math.max(var_623_16, arg_620_1.talkMaxDuration)

			if var_623_15 <= arg_620_1.time_ and arg_620_1.time_ < var_623_15 + var_623_25 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_15) / var_623_25

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_15 + var_623_25 and arg_620_1.time_ < var_623_15 + var_623_25 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_620_1:InitPlayNodeList()
	end,
	Play1106606158 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 1106606158
		arg_624_1.duration_ = 5

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play1106606159(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = arg_624_1.actors_["1066ui_story"]
			local var_627_1 = 0

			if var_627_1 < arg_624_1.time_ and arg_624_1.time_ <= var_627_1 + arg_627_0 and not isNil(var_627_0) and arg_624_1.var_.characterEffect1066ui_story == nil then
				arg_624_1.var_.characterEffect1066ui_story = var_627_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_627_2 = 0.200000002980232

			if var_627_1 <= arg_624_1.time_ and arg_624_1.time_ < var_627_1 + var_627_2 and not isNil(var_627_0) then
				local var_627_3 = (arg_624_1.time_ - var_627_1) / var_627_2

				if arg_624_1.var_.characterEffect1066ui_story and not isNil(var_627_0) then
					local var_627_4 = Mathf.Lerp(0, 0.5, var_627_3)

					arg_624_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_624_1.var_.characterEffect1066ui_story.fillRatio = var_627_4
				end
			end

			if arg_624_1.time_ >= var_627_1 + var_627_2 and arg_624_1.time_ < var_627_1 + var_627_2 + arg_627_0 and not isNil(var_627_0) and arg_624_1.var_.characterEffect1066ui_story then
				local var_627_5 = 0.5

				arg_624_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_624_1.var_.characterEffect1066ui_story.fillRatio = var_627_5
			end

			local var_627_6 = arg_624_1.actors_["1066ui_story"].transform
			local var_627_7 = 0

			if var_627_7 < arg_624_1.time_ and arg_624_1.time_ <= var_627_7 + arg_627_0 then
				arg_624_1.var_.moveOldPos1066ui_story = var_627_6.localPosition
			end

			local var_627_8 = 0.001

			if var_627_7 <= arg_624_1.time_ and arg_624_1.time_ < var_627_7 + var_627_8 then
				local var_627_9 = (arg_624_1.time_ - var_627_7) / var_627_8
				local var_627_10 = Vector3.New(0, 100, 0)

				var_627_6.localPosition = Vector3.Lerp(arg_624_1.var_.moveOldPos1066ui_story, var_627_10, var_627_9)

				local var_627_11 = manager.ui.mainCamera.transform.position - var_627_6.position

				var_627_6.forward = Vector3.New(var_627_11.x, var_627_11.y, var_627_11.z)

				local var_627_12 = var_627_6.localEulerAngles

				var_627_12.z = 0
				var_627_12.x = 0
				var_627_6.localEulerAngles = var_627_12
			end

			if arg_624_1.time_ >= var_627_7 + var_627_8 and arg_624_1.time_ < var_627_7 + var_627_8 + arg_627_0 then
				var_627_6.localPosition = Vector3.New(0, 100, 0)

				local var_627_13 = manager.ui.mainCamera.transform.position - var_627_6.position

				var_627_6.forward = Vector3.New(var_627_13.x, var_627_13.y, var_627_13.z)

				local var_627_14 = var_627_6.localEulerAngles

				var_627_14.z = 0
				var_627_14.x = 0
				var_627_6.localEulerAngles = var_627_14
			end

			local var_627_15 = 0
			local var_627_16 = 0.65

			if var_627_15 < arg_624_1.time_ and arg_624_1.time_ <= var_627_15 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, false)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_624_1.iconTrs_.gameObject, false)
				arg_624_1.callingController_:SetSelectedState("normal")

				local var_627_17 = arg_624_1:GetWordFromCfg(1106606158)
				local var_627_18 = arg_624_1:FormatText(var_627_17.content)

				arg_624_1.text_.text = var_627_18

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_19 = 26
				local var_627_20 = utf8.len(var_627_18)
				local var_627_21 = var_627_19 <= 0 and var_627_16 or var_627_16 * (var_627_20 / var_627_19)

				if var_627_21 > 0 and var_627_16 < var_627_21 then
					arg_624_1.talkMaxDuration = var_627_21

					if var_627_21 + var_627_15 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_21 + var_627_15
					end
				end

				arg_624_1.text_.text = var_627_18
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)
				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_22 = math.max(var_627_16, arg_624_1.talkMaxDuration)

			if var_627_15 <= arg_624_1.time_ and arg_624_1.time_ < var_627_15 + var_627_22 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_15) / var_627_22

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_15 + var_627_22 and arg_624_1.time_ < var_627_15 + var_627_22 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_624_1:InitPlayNodeList()
	end,
	Play1106606159 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 1106606159
		arg_628_1.duration_ = 4.7

		local var_628_0 = {
			zh = 4.7,
			ja = 4.266
		}
		local var_628_1 = manager.audio:GetLocalizationFlag()

		if var_628_0[var_628_1] ~= nil then
			arg_628_1.duration_ = var_628_0[var_628_1]
		end

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play1106606160(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			local var_631_0 = arg_628_1.actors_["1066ui_story"].transform
			local var_631_1 = 0

			if var_631_1 < arg_628_1.time_ and arg_628_1.time_ <= var_631_1 + arg_631_0 then
				arg_628_1.var_.moveOldPos1066ui_story = var_631_0.localPosition
			end

			local var_631_2 = 0.001

			if var_631_1 <= arg_628_1.time_ and arg_628_1.time_ < var_631_1 + var_631_2 then
				local var_631_3 = (arg_628_1.time_ - var_631_1) / var_631_2
				local var_631_4 = Vector3.New(0, -0.77, -6.1)

				var_631_0.localPosition = Vector3.Lerp(arg_628_1.var_.moveOldPos1066ui_story, var_631_4, var_631_3)

				local var_631_5 = manager.ui.mainCamera.transform.position - var_631_0.position

				var_631_0.forward = Vector3.New(var_631_5.x, var_631_5.y, var_631_5.z)

				local var_631_6 = var_631_0.localEulerAngles

				var_631_6.z = 0
				var_631_6.x = 0
				var_631_0.localEulerAngles = var_631_6
			end

			if arg_628_1.time_ >= var_631_1 + var_631_2 and arg_628_1.time_ < var_631_1 + var_631_2 + arg_631_0 then
				var_631_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_631_7 = manager.ui.mainCamera.transform.position - var_631_0.position

				var_631_0.forward = Vector3.New(var_631_7.x, var_631_7.y, var_631_7.z)

				local var_631_8 = var_631_0.localEulerAngles

				var_631_8.z = 0
				var_631_8.x = 0
				var_631_0.localEulerAngles = var_631_8
			end

			local var_631_9 = arg_628_1.actors_["1066ui_story"]
			local var_631_10 = 0

			if var_631_10 < arg_628_1.time_ and arg_628_1.time_ <= var_631_10 + arg_631_0 and not isNil(var_631_9) and arg_628_1.var_.characterEffect1066ui_story == nil then
				arg_628_1.var_.characterEffect1066ui_story = var_631_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_631_11 = 0.200000002980232

			if var_631_10 <= arg_628_1.time_ and arg_628_1.time_ < var_631_10 + var_631_11 and not isNil(var_631_9) then
				local var_631_12 = (arg_628_1.time_ - var_631_10) / var_631_11

				if arg_628_1.var_.characterEffect1066ui_story and not isNil(var_631_9) then
					arg_628_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_628_1.time_ >= var_631_10 + var_631_11 and arg_628_1.time_ < var_631_10 + var_631_11 + arg_631_0 and not isNil(var_631_9) and arg_628_1.var_.characterEffect1066ui_story then
				arg_628_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_631_13 = 0

			if var_631_13 < arg_628_1.time_ and arg_628_1.time_ <= var_631_13 + arg_631_0 then
				arg_628_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_631_14 = 0

			if var_631_14 < arg_628_1.time_ and arg_628_1.time_ <= var_631_14 + arg_631_0 then
				arg_628_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_631_15 = 0
			local var_631_16 = 0.325

			if var_631_15 < arg_628_1.time_ and arg_628_1.time_ <= var_631_15 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				local var_631_17 = arg_628_1:FormatText(StoryNameCfg[32].name)

				arg_628_1.leftNameTxt_.text = var_631_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, false)
				arg_628_1.callingController_:SetSelectedState("normal")

				local var_631_18 = arg_628_1:GetWordFromCfg(1106606159)
				local var_631_19 = arg_628_1:FormatText(var_631_18.content)

				arg_628_1.text_.text = var_631_19

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_20 = 13
				local var_631_21 = utf8.len(var_631_19)
				local var_631_22 = var_631_20 <= 0 and var_631_16 or var_631_16 * (var_631_21 / var_631_20)

				if var_631_22 > 0 and var_631_16 < var_631_22 then
					arg_628_1.talkMaxDuration = var_631_22

					if var_631_22 + var_631_15 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_22 + var_631_15
					end
				end

				arg_628_1.text_.text = var_631_19
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606159", "story_v_side_new_1106606.awb") ~= 0 then
					local var_631_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606159", "story_v_side_new_1106606.awb") / 1000

					if var_631_23 + var_631_15 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_23 + var_631_15
					end

					if var_631_18.prefab_name ~= "" and arg_628_1.actors_[var_631_18.prefab_name] ~= nil then
						local var_631_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_628_1.actors_[var_631_18.prefab_name].transform, "story_v_side_new_1106606", "1106606159", "story_v_side_new_1106606.awb")

						arg_628_1:RecordAudio("1106606159", var_631_24)
						arg_628_1:RecordAudio("1106606159", var_631_24)
					else
						arg_628_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606159", "story_v_side_new_1106606.awb")
					end

					arg_628_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606159", "story_v_side_new_1106606.awb")
				end

				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_25 = math.max(var_631_16, arg_628_1.talkMaxDuration)

			if var_631_15 <= arg_628_1.time_ and arg_628_1.time_ < var_631_15 + var_631_25 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_15) / var_631_25

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_15 + var_631_25 and arg_628_1.time_ < var_631_15 + var_631_25 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_628_1:InitPlayNodeList()
	end,
	Play1106606160 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 1106606160
		arg_632_1.duration_ = 5

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play1106606161(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			local var_635_0 = arg_632_1.actors_["1066ui_story"]
			local var_635_1 = 0

			if var_635_1 < arg_632_1.time_ and arg_632_1.time_ <= var_635_1 + arg_635_0 and not isNil(var_635_0) and arg_632_1.var_.characterEffect1066ui_story == nil then
				arg_632_1.var_.characterEffect1066ui_story = var_635_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_635_2 = 0.200000002980232

			if var_635_1 <= arg_632_1.time_ and arg_632_1.time_ < var_635_1 + var_635_2 and not isNil(var_635_0) then
				local var_635_3 = (arg_632_1.time_ - var_635_1) / var_635_2

				if arg_632_1.var_.characterEffect1066ui_story and not isNil(var_635_0) then
					local var_635_4 = Mathf.Lerp(0, 0.5, var_635_3)

					arg_632_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_632_1.var_.characterEffect1066ui_story.fillRatio = var_635_4
				end
			end

			if arg_632_1.time_ >= var_635_1 + var_635_2 and arg_632_1.time_ < var_635_1 + var_635_2 + arg_635_0 and not isNil(var_635_0) and arg_632_1.var_.characterEffect1066ui_story then
				local var_635_5 = 0.5

				arg_632_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_632_1.var_.characterEffect1066ui_story.fillRatio = var_635_5
			end

			local var_635_6 = 0
			local var_635_7 = 0.925

			if var_635_6 < arg_632_1.time_ and arg_632_1.time_ <= var_635_6 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				local var_635_8 = arg_632_1:FormatText(StoryNameCfg[7].name)

				arg_632_1.leftNameTxt_.text = var_635_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, true)
				arg_632_1.iconController_:SetSelectedState("hero")

				arg_632_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_632_1.callingController_:SetSelectedState("normal")

				arg_632_1.keyicon_.color = Color.New(1, 1, 1)
				arg_632_1.icon_.color = Color.New(1, 1, 1)

				local var_635_9 = arg_632_1:GetWordFromCfg(1106606160)
				local var_635_10 = arg_632_1:FormatText(var_635_9.content)

				arg_632_1.text_.text = var_635_10

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_11 = 37
				local var_635_12 = utf8.len(var_635_10)
				local var_635_13 = var_635_11 <= 0 and var_635_7 or var_635_7 * (var_635_12 / var_635_11)

				if var_635_13 > 0 and var_635_7 < var_635_13 then
					arg_632_1.talkMaxDuration = var_635_13

					if var_635_13 + var_635_6 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_13 + var_635_6
					end
				end

				arg_632_1.text_.text = var_635_10
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)
				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_14 = math.max(var_635_7, arg_632_1.talkMaxDuration)

			if var_635_6 <= arg_632_1.time_ and arg_632_1.time_ < var_635_6 + var_635_14 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_6) / var_635_14

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_6 + var_635_14 and arg_632_1.time_ < var_635_6 + var_635_14 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {}

		arg_632_1:InitPlayNodeList()
	end,
	Play1106606161 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 1106606161
		arg_636_1.duration_ = 5

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play1106606162(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			local var_639_0 = 0
			local var_639_1 = 0.425

			if var_639_0 < arg_636_1.time_ and arg_636_1.time_ <= var_639_0 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, true)

				local var_639_2 = arg_636_1:FormatText(StoryNameCfg[7].name)

				arg_636_1.leftNameTxt_.text = var_639_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_636_1.leftNameTxt_.transform)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1.leftNameTxt_.text)
				SetActive(arg_636_1.iconTrs_.gameObject, true)
				arg_636_1.iconController_:SetSelectedState("hero")

				arg_636_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_636_1.callingController_:SetSelectedState("normal")

				arg_636_1.keyicon_.color = Color.New(1, 1, 1)
				arg_636_1.icon_.color = Color.New(1, 1, 1)

				local var_639_3 = arg_636_1:GetWordFromCfg(1106606161)
				local var_639_4 = arg_636_1:FormatText(var_639_3.content)

				arg_636_1.text_.text = var_639_4

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_5 = 17
				local var_639_6 = utf8.len(var_639_4)
				local var_639_7 = var_639_5 <= 0 and var_639_1 or var_639_1 * (var_639_6 / var_639_5)

				if var_639_7 > 0 and var_639_1 < var_639_7 then
					arg_636_1.talkMaxDuration = var_639_7

					if var_639_7 + var_639_0 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_7 + var_639_0
					end
				end

				arg_636_1.text_.text = var_639_4
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)
				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_8 = math.max(var_639_1, arg_636_1.talkMaxDuration)

			if var_639_0 <= arg_636_1.time_ and arg_636_1.time_ < var_639_0 + var_639_8 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - var_639_0) / var_639_8

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= var_639_0 + var_639_8 and arg_636_1.time_ < var_639_0 + var_639_8 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {}

		arg_636_1:InitPlayNodeList()
	end,
	Play1106606162 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 1106606162
		arg_640_1.duration_ = 4.1

		local var_640_0 = {
			zh = 2.7,
			ja = 4.1
		}
		local var_640_1 = manager.audio:GetLocalizationFlag()

		if var_640_0[var_640_1] ~= nil then
			arg_640_1.duration_ = var_640_0[var_640_1]
		end

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play1106606163(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			local var_643_0 = arg_640_1.actors_["1066ui_story"].transform
			local var_643_1 = 0

			if var_643_1 < arg_640_1.time_ and arg_640_1.time_ <= var_643_1 + arg_643_0 then
				arg_640_1.var_.moveOldPos1066ui_story = var_643_0.localPosition
			end

			local var_643_2 = 0.001

			if var_643_1 <= arg_640_1.time_ and arg_640_1.time_ < var_643_1 + var_643_2 then
				local var_643_3 = (arg_640_1.time_ - var_643_1) / var_643_2
				local var_643_4 = Vector3.New(0, -0.77, -6.1)

				var_643_0.localPosition = Vector3.Lerp(arg_640_1.var_.moveOldPos1066ui_story, var_643_4, var_643_3)

				local var_643_5 = manager.ui.mainCamera.transform.position - var_643_0.position

				var_643_0.forward = Vector3.New(var_643_5.x, var_643_5.y, var_643_5.z)

				local var_643_6 = var_643_0.localEulerAngles

				var_643_6.z = 0
				var_643_6.x = 0
				var_643_0.localEulerAngles = var_643_6
			end

			if arg_640_1.time_ >= var_643_1 + var_643_2 and arg_640_1.time_ < var_643_1 + var_643_2 + arg_643_0 then
				var_643_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_643_7 = manager.ui.mainCamera.transform.position - var_643_0.position

				var_643_0.forward = Vector3.New(var_643_7.x, var_643_7.y, var_643_7.z)

				local var_643_8 = var_643_0.localEulerAngles

				var_643_8.z = 0
				var_643_8.x = 0
				var_643_0.localEulerAngles = var_643_8
			end

			local var_643_9 = arg_640_1.actors_["1066ui_story"]
			local var_643_10 = 0

			if var_643_10 < arg_640_1.time_ and arg_640_1.time_ <= var_643_10 + arg_643_0 and not isNil(var_643_9) and arg_640_1.var_.characterEffect1066ui_story == nil then
				arg_640_1.var_.characterEffect1066ui_story = var_643_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_643_11 = 0.200000002980232

			if var_643_10 <= arg_640_1.time_ and arg_640_1.time_ < var_643_10 + var_643_11 and not isNil(var_643_9) then
				local var_643_12 = (arg_640_1.time_ - var_643_10) / var_643_11

				if arg_640_1.var_.characterEffect1066ui_story and not isNil(var_643_9) then
					arg_640_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_640_1.time_ >= var_643_10 + var_643_11 and arg_640_1.time_ < var_643_10 + var_643_11 + arg_643_0 and not isNil(var_643_9) and arg_640_1.var_.characterEffect1066ui_story then
				arg_640_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_643_13 = 0

			if var_643_13 < arg_640_1.time_ and arg_640_1.time_ <= var_643_13 + arg_643_0 then
				arg_640_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			local var_643_14 = 0

			if var_643_14 < arg_640_1.time_ and arg_640_1.time_ <= var_643_14 + arg_643_0 then
				arg_640_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_643_15 = 0
			local var_643_16 = 0.225

			if var_643_15 < arg_640_1.time_ and arg_640_1.time_ <= var_643_15 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, true)

				local var_643_17 = arg_640_1:FormatText(StoryNameCfg[32].name)

				arg_640_1.leftNameTxt_.text = var_643_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_640_1.leftNameTxt_.transform)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1.leftNameTxt_.text)
				SetActive(arg_640_1.iconTrs_.gameObject, false)
				arg_640_1.callingController_:SetSelectedState("normal")

				local var_643_18 = arg_640_1:GetWordFromCfg(1106606162)
				local var_643_19 = arg_640_1:FormatText(var_643_18.content)

				arg_640_1.text_.text = var_643_19

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_20 = 9
				local var_643_21 = utf8.len(var_643_19)
				local var_643_22 = var_643_20 <= 0 and var_643_16 or var_643_16 * (var_643_21 / var_643_20)

				if var_643_22 > 0 and var_643_16 < var_643_22 then
					arg_640_1.talkMaxDuration = var_643_22

					if var_643_22 + var_643_15 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_22 + var_643_15
					end
				end

				arg_640_1.text_.text = var_643_19
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606162", "story_v_side_new_1106606.awb") ~= 0 then
					local var_643_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606162", "story_v_side_new_1106606.awb") / 1000

					if var_643_23 + var_643_15 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_23 + var_643_15
					end

					if var_643_18.prefab_name ~= "" and arg_640_1.actors_[var_643_18.prefab_name] ~= nil then
						local var_643_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_640_1.actors_[var_643_18.prefab_name].transform, "story_v_side_new_1106606", "1106606162", "story_v_side_new_1106606.awb")

						arg_640_1:RecordAudio("1106606162", var_643_24)
						arg_640_1:RecordAudio("1106606162", var_643_24)
					else
						arg_640_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606162", "story_v_side_new_1106606.awb")
					end

					arg_640_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606162", "story_v_side_new_1106606.awb")
				end

				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_25 = math.max(var_643_16, arg_640_1.talkMaxDuration)

			if var_643_15 <= arg_640_1.time_ and arg_640_1.time_ < var_643_15 + var_643_25 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - var_643_15) / var_643_25

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= var_643_15 + var_643_25 and arg_640_1.time_ < var_643_15 + var_643_25 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_640_1:InitPlayNodeList()
	end,
	Play1106606163 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 1106606163
		arg_644_1.duration_ = 5

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play1106606164(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			local var_647_0 = arg_644_1.actors_["1066ui_story"]
			local var_647_1 = 0

			if var_647_1 < arg_644_1.time_ and arg_644_1.time_ <= var_647_1 + arg_647_0 and not isNil(var_647_0) and arg_644_1.var_.characterEffect1066ui_story == nil then
				arg_644_1.var_.characterEffect1066ui_story = var_647_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_647_2 = 0.200000002980232

			if var_647_1 <= arg_644_1.time_ and arg_644_1.time_ < var_647_1 + var_647_2 and not isNil(var_647_0) then
				local var_647_3 = (arg_644_1.time_ - var_647_1) / var_647_2

				if arg_644_1.var_.characterEffect1066ui_story and not isNil(var_647_0) then
					local var_647_4 = Mathf.Lerp(0, 0.5, var_647_3)

					arg_644_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_644_1.var_.characterEffect1066ui_story.fillRatio = var_647_4
				end
			end

			if arg_644_1.time_ >= var_647_1 + var_647_2 and arg_644_1.time_ < var_647_1 + var_647_2 + arg_647_0 and not isNil(var_647_0) and arg_644_1.var_.characterEffect1066ui_story then
				local var_647_5 = 0.5

				arg_644_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_644_1.var_.characterEffect1066ui_story.fillRatio = var_647_5
			end

			local var_647_6 = 0
			local var_647_7 = 0.725

			if var_647_6 < arg_644_1.time_ and arg_644_1.time_ <= var_647_6 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0
				arg_644_1.dialogCg_.alpha = 1

				arg_644_1.dialog_:SetActive(true)
				SetActive(arg_644_1.leftNameGo_, false)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_644_1.iconTrs_.gameObject, false)
				arg_644_1.callingController_:SetSelectedState("normal")

				local var_647_8 = arg_644_1:GetWordFromCfg(1106606163)
				local var_647_9 = arg_644_1:FormatText(var_647_8.content)

				arg_644_1.text_.text = var_647_9

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_10 = 29
				local var_647_11 = utf8.len(var_647_9)
				local var_647_12 = var_647_10 <= 0 and var_647_7 or var_647_7 * (var_647_11 / var_647_10)

				if var_647_12 > 0 and var_647_7 < var_647_12 then
					arg_644_1.talkMaxDuration = var_647_12

					if var_647_12 + var_647_6 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_12 + var_647_6
					end
				end

				arg_644_1.text_.text = var_647_9
				arg_644_1.typewritter.percent = 0

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(false)
				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_13 = math.max(var_647_7, arg_644_1.talkMaxDuration)

			if var_647_6 <= arg_644_1.time_ and arg_644_1.time_ < var_647_6 + var_647_13 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - var_647_6) / var_647_13

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= var_647_6 + var_647_13 and arg_644_1.time_ < var_647_6 + var_647_13 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {}

		arg_644_1:InitPlayNodeList()
	end,
	Play1106606164 = function(arg_648_0, arg_648_1)
		arg_648_1.time_ = 0
		arg_648_1.frameCnt_ = 0
		arg_648_1.state_ = "playing"
		arg_648_1.curTalkId_ = 1106606164
		arg_648_1.duration_ = 5

		SetActive(arg_648_1.tipsGo_, false)

		function arg_648_1.onSingleLineFinish_()
			arg_648_1.onSingleLineUpdate_ = nil
			arg_648_1.onSingleLineFinish_ = nil
			arg_648_1.state_ = "waiting"
		end

		function arg_648_1.playNext_(arg_650_0)
			if arg_650_0 == 1 then
				arg_648_0:Play1106606165(arg_648_1)
			end
		end

		function arg_648_1.onSingleLineUpdate_(arg_651_0)
			local var_651_0 = 0
			local var_651_1 = 0.525

			if var_651_0 < arg_648_1.time_ and arg_648_1.time_ <= var_651_0 + arg_651_0 then
				arg_648_1.talkMaxDuration = 0
				arg_648_1.dialogCg_.alpha = 1

				arg_648_1.dialog_:SetActive(true)
				SetActive(arg_648_1.leftNameGo_, true)

				local var_651_2 = arg_648_1:FormatText(StoryNameCfg[7].name)

				arg_648_1.leftNameTxt_.text = var_651_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_648_1.leftNameTxt_.transform)

				arg_648_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_648_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_648_1:RecordName(arg_648_1.leftNameTxt_.text)
				SetActive(arg_648_1.iconTrs_.gameObject, true)
				arg_648_1.iconController_:SetSelectedState("hero")

				arg_648_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_648_1.callingController_:SetSelectedState("normal")

				arg_648_1.keyicon_.color = Color.New(1, 1, 1)
				arg_648_1.icon_.color = Color.New(1, 1, 1)

				local var_651_3 = arg_648_1:GetWordFromCfg(1106606164)
				local var_651_4 = arg_648_1:FormatText(var_651_3.content)

				arg_648_1.text_.text = var_651_4

				LuaForUtil.ClearLinePrefixSymbol(arg_648_1.text_)

				local var_651_5 = 21
				local var_651_6 = utf8.len(var_651_4)
				local var_651_7 = var_651_5 <= 0 and var_651_1 or var_651_1 * (var_651_6 / var_651_5)

				if var_651_7 > 0 and var_651_1 < var_651_7 then
					arg_648_1.talkMaxDuration = var_651_7

					if var_651_7 + var_651_0 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_7 + var_651_0
					end
				end

				arg_648_1.text_.text = var_651_4
				arg_648_1.typewritter.percent = 0

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(false)
				arg_648_1:RecordContent(arg_648_1.text_.text)
			end

			local var_651_8 = math.max(var_651_1, arg_648_1.talkMaxDuration)

			if var_651_0 <= arg_648_1.time_ and arg_648_1.time_ < var_651_0 + var_651_8 then
				arg_648_1.typewritter.percent = (arg_648_1.time_ - var_651_0) / var_651_8

				arg_648_1.typewritter:SetDirty()
			end

			if arg_648_1.time_ >= var_651_0 + var_651_8 and arg_648_1.time_ < var_651_0 + var_651_8 + arg_651_0 then
				arg_648_1.typewritter.percent = 1

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(true)
			end
		end

		arg_648_1.nodeConfigList_ = {}

		arg_648_1:InitPlayNodeList()
	end,
	Play1106606165 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 1106606165
		arg_652_1.duration_ = 5

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play1106606166(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			local var_655_0 = 0
			local var_655_1 = 0.775

			if var_655_0 < arg_652_1.time_ and arg_652_1.time_ <= var_655_0 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, true)

				local var_655_2 = arg_652_1:FormatText(StoryNameCfg[7].name)

				arg_652_1.leftNameTxt_.text = var_655_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_652_1.leftNameTxt_.transform)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1.leftNameTxt_.text)
				SetActive(arg_652_1.iconTrs_.gameObject, true)
				arg_652_1.iconController_:SetSelectedState("hero")

				arg_652_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_652_1.callingController_:SetSelectedState("normal")

				arg_652_1.keyicon_.color = Color.New(1, 1, 1)
				arg_652_1.icon_.color = Color.New(1, 1, 1)

				local var_655_3 = arg_652_1:GetWordFromCfg(1106606165)
				local var_655_4 = arg_652_1:FormatText(var_655_3.content)

				arg_652_1.text_.text = var_655_4

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_5 = 31
				local var_655_6 = utf8.len(var_655_4)
				local var_655_7 = var_655_5 <= 0 and var_655_1 or var_655_1 * (var_655_6 / var_655_5)

				if var_655_7 > 0 and var_655_1 < var_655_7 then
					arg_652_1.talkMaxDuration = var_655_7

					if var_655_7 + var_655_0 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_7 + var_655_0
					end
				end

				arg_652_1.text_.text = var_655_4
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)
				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_8 = math.max(var_655_1, arg_652_1.talkMaxDuration)

			if var_655_0 <= arg_652_1.time_ and arg_652_1.time_ < var_655_0 + var_655_8 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_0) / var_655_8

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_0 + var_655_8 and arg_652_1.time_ < var_655_0 + var_655_8 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {}

		arg_652_1:InitPlayNodeList()
	end,
	Play1106606166 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 1106606166
		arg_656_1.duration_ = 7.9

		local var_656_0 = {
			zh = 7.9,
			ja = 6.833
		}
		local var_656_1 = manager.audio:GetLocalizationFlag()

		if var_656_0[var_656_1] ~= nil then
			arg_656_1.duration_ = var_656_0[var_656_1]
		end

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play1106606167(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			local var_659_0 = arg_656_1.actors_["1066ui_story"].transform
			local var_659_1 = 0

			if var_659_1 < arg_656_1.time_ and arg_656_1.time_ <= var_659_1 + arg_659_0 then
				arg_656_1.var_.moveOldPos1066ui_story = var_659_0.localPosition
			end

			local var_659_2 = 0.001

			if var_659_1 <= arg_656_1.time_ and arg_656_1.time_ < var_659_1 + var_659_2 then
				local var_659_3 = (arg_656_1.time_ - var_659_1) / var_659_2
				local var_659_4 = Vector3.New(0, -0.77, -6.1)

				var_659_0.localPosition = Vector3.Lerp(arg_656_1.var_.moveOldPos1066ui_story, var_659_4, var_659_3)

				local var_659_5 = manager.ui.mainCamera.transform.position - var_659_0.position

				var_659_0.forward = Vector3.New(var_659_5.x, var_659_5.y, var_659_5.z)

				local var_659_6 = var_659_0.localEulerAngles

				var_659_6.z = 0
				var_659_6.x = 0
				var_659_0.localEulerAngles = var_659_6
			end

			if arg_656_1.time_ >= var_659_1 + var_659_2 and arg_656_1.time_ < var_659_1 + var_659_2 + arg_659_0 then
				var_659_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_659_7 = manager.ui.mainCamera.transform.position - var_659_0.position

				var_659_0.forward = Vector3.New(var_659_7.x, var_659_7.y, var_659_7.z)

				local var_659_8 = var_659_0.localEulerAngles

				var_659_8.z = 0
				var_659_8.x = 0
				var_659_0.localEulerAngles = var_659_8
			end

			local var_659_9 = arg_656_1.actors_["1066ui_story"]
			local var_659_10 = 0

			if var_659_10 < arg_656_1.time_ and arg_656_1.time_ <= var_659_10 + arg_659_0 and not isNil(var_659_9) and arg_656_1.var_.characterEffect1066ui_story == nil then
				arg_656_1.var_.characterEffect1066ui_story = var_659_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_659_11 = 0.200000002980232

			if var_659_10 <= arg_656_1.time_ and arg_656_1.time_ < var_659_10 + var_659_11 and not isNil(var_659_9) then
				local var_659_12 = (arg_656_1.time_ - var_659_10) / var_659_11

				if arg_656_1.var_.characterEffect1066ui_story and not isNil(var_659_9) then
					arg_656_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_656_1.time_ >= var_659_10 + var_659_11 and arg_656_1.time_ < var_659_10 + var_659_11 + arg_659_0 and not isNil(var_659_9) and arg_656_1.var_.characterEffect1066ui_story then
				arg_656_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_659_13 = 0

			if var_659_13 < arg_656_1.time_ and arg_656_1.time_ <= var_659_13 + arg_659_0 then
				arg_656_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			local var_659_14 = 0

			if var_659_14 < arg_656_1.time_ and arg_656_1.time_ <= var_659_14 + arg_659_0 then
				arg_656_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_659_15 = 0
			local var_659_16 = 0.85

			if var_659_15 < arg_656_1.time_ and arg_656_1.time_ <= var_659_15 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, true)

				local var_659_17 = arg_656_1:FormatText(StoryNameCfg[32].name)

				arg_656_1.leftNameTxt_.text = var_659_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_656_1.leftNameTxt_.transform)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1.leftNameTxt_.text)
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_18 = arg_656_1:GetWordFromCfg(1106606166)
				local var_659_19 = arg_656_1:FormatText(var_659_18.content)

				arg_656_1.text_.text = var_659_19

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_20 = 34
				local var_659_21 = utf8.len(var_659_19)
				local var_659_22 = var_659_20 <= 0 and var_659_16 or var_659_16 * (var_659_21 / var_659_20)

				if var_659_22 > 0 and var_659_16 < var_659_22 then
					arg_656_1.talkMaxDuration = var_659_22

					if var_659_22 + var_659_15 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_22 + var_659_15
					end
				end

				arg_656_1.text_.text = var_659_19
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606166", "story_v_side_new_1106606.awb") ~= 0 then
					local var_659_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606166", "story_v_side_new_1106606.awb") / 1000

					if var_659_23 + var_659_15 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_23 + var_659_15
					end

					if var_659_18.prefab_name ~= "" and arg_656_1.actors_[var_659_18.prefab_name] ~= nil then
						local var_659_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_656_1.actors_[var_659_18.prefab_name].transform, "story_v_side_new_1106606", "1106606166", "story_v_side_new_1106606.awb")

						arg_656_1:RecordAudio("1106606166", var_659_24)
						arg_656_1:RecordAudio("1106606166", var_659_24)
					else
						arg_656_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606166", "story_v_side_new_1106606.awb")
					end

					arg_656_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606166", "story_v_side_new_1106606.awb")
				end

				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_25 = math.max(var_659_16, arg_656_1.talkMaxDuration)

			if var_659_15 <= arg_656_1.time_ and arg_656_1.time_ < var_659_15 + var_659_25 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_15) / var_659_25

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_15 + var_659_25 and arg_656_1.time_ < var_659_15 + var_659_25 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_656_1:InitPlayNodeList()
	end,
	Play1106606167 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 1106606167
		arg_660_1.duration_ = 6.3

		local var_660_0 = {
			zh = 5.3,
			ja = 6.3
		}
		local var_660_1 = manager.audio:GetLocalizationFlag()

		if var_660_0[var_660_1] ~= nil then
			arg_660_1.duration_ = var_660_0[var_660_1]
		end

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play1106606168(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = 0

			if var_663_0 < arg_660_1.time_ and arg_660_1.time_ <= var_663_0 + arg_663_0 then
				arg_660_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action9_1")
			end

			local var_663_1 = 0

			if var_663_1 < arg_660_1.time_ and arg_660_1.time_ <= var_663_1 + arg_663_0 then
				arg_660_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_663_2 = 0
			local var_663_3 = 0.5

			if var_663_2 < arg_660_1.time_ and arg_660_1.time_ <= var_663_2 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, true)

				local var_663_4 = arg_660_1:FormatText(StoryNameCfg[32].name)

				arg_660_1.leftNameTxt_.text = var_663_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_660_1.leftNameTxt_.transform)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1.leftNameTxt_.text)
				SetActive(arg_660_1.iconTrs_.gameObject, false)
				arg_660_1.callingController_:SetSelectedState("normal")

				local var_663_5 = arg_660_1:GetWordFromCfg(1106606167)
				local var_663_6 = arg_660_1:FormatText(var_663_5.content)

				arg_660_1.text_.text = var_663_6

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_7 = 20
				local var_663_8 = utf8.len(var_663_6)
				local var_663_9 = var_663_7 <= 0 and var_663_3 or var_663_3 * (var_663_8 / var_663_7)

				if var_663_9 > 0 and var_663_3 < var_663_9 then
					arg_660_1.talkMaxDuration = var_663_9

					if var_663_9 + var_663_2 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_9 + var_663_2
					end
				end

				arg_660_1.text_.text = var_663_6
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606167", "story_v_side_new_1106606.awb") ~= 0 then
					local var_663_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606167", "story_v_side_new_1106606.awb") / 1000

					if var_663_10 + var_663_2 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_10 + var_663_2
					end

					if var_663_5.prefab_name ~= "" and arg_660_1.actors_[var_663_5.prefab_name] ~= nil then
						local var_663_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_660_1.actors_[var_663_5.prefab_name].transform, "story_v_side_new_1106606", "1106606167", "story_v_side_new_1106606.awb")

						arg_660_1:RecordAudio("1106606167", var_663_11)
						arg_660_1:RecordAudio("1106606167", var_663_11)
					else
						arg_660_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606167", "story_v_side_new_1106606.awb")
					end

					arg_660_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606167", "story_v_side_new_1106606.awb")
				end

				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_12 = math.max(var_663_3, arg_660_1.talkMaxDuration)

			if var_663_2 <= arg_660_1.time_ and arg_660_1.time_ < var_663_2 + var_663_12 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_2) / var_663_12

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_2 + var_663_12 and arg_660_1.time_ < var_663_2 + var_663_12 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	Play1106606168 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 1106606168
		arg_664_1.duration_ = 9.57

		local var_664_0 = {
			zh = 9.566,
			ja = 8.333
		}
		local var_664_1 = manager.audio:GetLocalizationFlag()

		if var_664_0[var_664_1] ~= nil then
			arg_664_1.duration_ = var_664_0[var_664_1]
		end

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play1106606169(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			local var_667_0 = 0
			local var_667_1 = 0.925

			if var_667_0 < arg_664_1.time_ and arg_664_1.time_ <= var_667_0 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, true)

				local var_667_2 = arg_664_1:FormatText(StoryNameCfg[32].name)

				arg_664_1.leftNameTxt_.text = var_667_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_664_1.leftNameTxt_.transform)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1.leftNameTxt_.text)
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_3 = arg_664_1:GetWordFromCfg(1106606168)
				local var_667_4 = arg_664_1:FormatText(var_667_3.content)

				arg_664_1.text_.text = var_667_4

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_5 = 37
				local var_667_6 = utf8.len(var_667_4)
				local var_667_7 = var_667_5 <= 0 and var_667_1 or var_667_1 * (var_667_6 / var_667_5)

				if var_667_7 > 0 and var_667_1 < var_667_7 then
					arg_664_1.talkMaxDuration = var_667_7

					if var_667_7 + var_667_0 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_7 + var_667_0
					end
				end

				arg_664_1.text_.text = var_667_4
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606168", "story_v_side_new_1106606.awb") ~= 0 then
					local var_667_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606168", "story_v_side_new_1106606.awb") / 1000

					if var_667_8 + var_667_0 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_8 + var_667_0
					end

					if var_667_3.prefab_name ~= "" and arg_664_1.actors_[var_667_3.prefab_name] ~= nil then
						local var_667_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_664_1.actors_[var_667_3.prefab_name].transform, "story_v_side_new_1106606", "1106606168", "story_v_side_new_1106606.awb")

						arg_664_1:RecordAudio("1106606168", var_667_9)
						arg_664_1:RecordAudio("1106606168", var_667_9)
					else
						arg_664_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606168", "story_v_side_new_1106606.awb")
					end

					arg_664_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606168", "story_v_side_new_1106606.awb")
				end

				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_10 = math.max(var_667_1, arg_664_1.talkMaxDuration)

			if var_667_0 <= arg_664_1.time_ and arg_664_1.time_ < var_667_0 + var_667_10 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - var_667_0) / var_667_10

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= var_667_0 + var_667_10 and arg_664_1.time_ < var_667_0 + var_667_10 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {}

		arg_664_1:InitPlayNodeList()
	end,
	Play1106606169 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 1106606169
		arg_668_1.duration_ = 1

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"

			SetActive(arg_668_1.choicesGo_, true)

			for iter_669_0, iter_669_1 in ipairs(arg_668_1.choices_) do
				local var_669_0 = iter_669_0 <= 1

				SetActive(iter_669_1.go, var_669_0)
			end

			arg_668_1.choices_[1].txt.text = arg_668_1:FormatText(StoryChoiceCfg[565].name)
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play1106606170(arg_668_1)
			end

			arg_668_1:RecordChoiceLog(1106606169, 565)
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			local var_671_0 = arg_668_1.actors_["1066ui_story"]
			local var_671_1 = 0

			if var_671_1 < arg_668_1.time_ and arg_668_1.time_ <= var_671_1 + arg_671_0 and not isNil(var_671_0) and arg_668_1.var_.characterEffect1066ui_story == nil then
				arg_668_1.var_.characterEffect1066ui_story = var_671_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_671_2 = 0.200000002980232

			if var_671_1 <= arg_668_1.time_ and arg_668_1.time_ < var_671_1 + var_671_2 and not isNil(var_671_0) then
				local var_671_3 = (arg_668_1.time_ - var_671_1) / var_671_2

				if arg_668_1.var_.characterEffect1066ui_story and not isNil(var_671_0) then
					local var_671_4 = Mathf.Lerp(0, 0.5, var_671_3)

					arg_668_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_668_1.var_.characterEffect1066ui_story.fillRatio = var_671_4
				end
			end

			if arg_668_1.time_ >= var_671_1 + var_671_2 and arg_668_1.time_ < var_671_1 + var_671_2 + arg_671_0 and not isNil(var_671_0) and arg_668_1.var_.characterEffect1066ui_story then
				local var_671_5 = 0.5

				arg_668_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_668_1.var_.characterEffect1066ui_story.fillRatio = var_671_5
			end

			local var_671_6 = 0

			if var_671_6 < arg_668_1.time_ and arg_668_1.time_ <= var_671_6 + arg_671_0 then
				arg_668_1.allBtn_.enabled = false
			end

			local var_671_7 = 0.5

			if arg_668_1.time_ >= var_671_6 + var_671_7 and arg_668_1.time_ < var_671_6 + var_671_7 + arg_671_0 then
				arg_668_1.allBtn_.enabled = true
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play1106606170 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 1106606170
		arg_672_1.duration_ = 6.1

		local var_672_0 = {
			zh = 4.066,
			ja = 6.1
		}
		local var_672_1 = manager.audio:GetLocalizationFlag()

		if var_672_0[var_672_1] ~= nil then
			arg_672_1.duration_ = var_672_0[var_672_1]
		end

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play1106606171(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			local var_675_0 = arg_672_1.actors_["1066ui_story"].transform
			local var_675_1 = 0

			if var_675_1 < arg_672_1.time_ and arg_672_1.time_ <= var_675_1 + arg_675_0 then
				arg_672_1.var_.moveOldPos1066ui_story = var_675_0.localPosition
			end

			local var_675_2 = 0.001

			if var_675_1 <= arg_672_1.time_ and arg_672_1.time_ < var_675_1 + var_675_2 then
				local var_675_3 = (arg_672_1.time_ - var_675_1) / var_675_2
				local var_675_4 = Vector3.New(0, -0.77, -6.1)

				var_675_0.localPosition = Vector3.Lerp(arg_672_1.var_.moveOldPos1066ui_story, var_675_4, var_675_3)

				local var_675_5 = manager.ui.mainCamera.transform.position - var_675_0.position

				var_675_0.forward = Vector3.New(var_675_5.x, var_675_5.y, var_675_5.z)

				local var_675_6 = var_675_0.localEulerAngles

				var_675_6.z = 0
				var_675_6.x = 0
				var_675_0.localEulerAngles = var_675_6
			end

			if arg_672_1.time_ >= var_675_1 + var_675_2 and arg_672_1.time_ < var_675_1 + var_675_2 + arg_675_0 then
				var_675_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_675_7 = manager.ui.mainCamera.transform.position - var_675_0.position

				var_675_0.forward = Vector3.New(var_675_7.x, var_675_7.y, var_675_7.z)

				local var_675_8 = var_675_0.localEulerAngles

				var_675_8.z = 0
				var_675_8.x = 0
				var_675_0.localEulerAngles = var_675_8
			end

			local var_675_9 = arg_672_1.actors_["1066ui_story"]
			local var_675_10 = 0

			if var_675_10 < arg_672_1.time_ and arg_672_1.time_ <= var_675_10 + arg_675_0 and not isNil(var_675_9) and arg_672_1.var_.characterEffect1066ui_story == nil then
				arg_672_1.var_.characterEffect1066ui_story = var_675_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_675_11 = 0.200000002980232

			if var_675_10 <= arg_672_1.time_ and arg_672_1.time_ < var_675_10 + var_675_11 and not isNil(var_675_9) then
				local var_675_12 = (arg_672_1.time_ - var_675_10) / var_675_11

				if arg_672_1.var_.characterEffect1066ui_story and not isNil(var_675_9) then
					arg_672_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_672_1.time_ >= var_675_10 + var_675_11 and arg_672_1.time_ < var_675_10 + var_675_11 + arg_675_0 and not isNil(var_675_9) and arg_672_1.var_.characterEffect1066ui_story then
				arg_672_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_675_13 = 0

			if var_675_13 < arg_672_1.time_ and arg_672_1.time_ <= var_675_13 + arg_675_0 then
				arg_672_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action9_2")
			end

			local var_675_14 = 0

			if var_675_14 < arg_672_1.time_ and arg_672_1.time_ <= var_675_14 + arg_675_0 then
				arg_672_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_675_15 = 0
			local var_675_16 = 0.4

			if var_675_15 < arg_672_1.time_ and arg_672_1.time_ <= var_675_15 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0
				arg_672_1.dialogCg_.alpha = 1

				arg_672_1.dialog_:SetActive(true)
				SetActive(arg_672_1.leftNameGo_, true)

				local var_675_17 = arg_672_1:FormatText(StoryNameCfg[32].name)

				arg_672_1.leftNameTxt_.text = var_675_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_672_1.leftNameTxt_.transform)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1.leftNameTxt_.text)
				SetActive(arg_672_1.iconTrs_.gameObject, false)
				arg_672_1.callingController_:SetSelectedState("normal")

				local var_675_18 = arg_672_1:GetWordFromCfg(1106606170)
				local var_675_19 = arg_672_1:FormatText(var_675_18.content)

				arg_672_1.text_.text = var_675_19

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_20 = 16
				local var_675_21 = utf8.len(var_675_19)
				local var_675_22 = var_675_20 <= 0 and var_675_16 or var_675_16 * (var_675_21 / var_675_20)

				if var_675_22 > 0 and var_675_16 < var_675_22 then
					arg_672_1.talkMaxDuration = var_675_22

					if var_675_22 + var_675_15 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_22 + var_675_15
					end
				end

				arg_672_1.text_.text = var_675_19
				arg_672_1.typewritter.percent = 0

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606170", "story_v_side_new_1106606.awb") ~= 0 then
					local var_675_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606170", "story_v_side_new_1106606.awb") / 1000

					if var_675_23 + var_675_15 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_23 + var_675_15
					end

					if var_675_18.prefab_name ~= "" and arg_672_1.actors_[var_675_18.prefab_name] ~= nil then
						local var_675_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_672_1.actors_[var_675_18.prefab_name].transform, "story_v_side_new_1106606", "1106606170", "story_v_side_new_1106606.awb")

						arg_672_1:RecordAudio("1106606170", var_675_24)
						arg_672_1:RecordAudio("1106606170", var_675_24)
					else
						arg_672_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606170", "story_v_side_new_1106606.awb")
					end

					arg_672_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606170", "story_v_side_new_1106606.awb")
				end

				arg_672_1:RecordContent(arg_672_1.text_.text)
			end

			local var_675_25 = math.max(var_675_16, arg_672_1.talkMaxDuration)

			if var_675_15 <= arg_672_1.time_ and arg_672_1.time_ < var_675_15 + var_675_25 then
				arg_672_1.typewritter.percent = (arg_672_1.time_ - var_675_15) / var_675_25

				arg_672_1.typewritter:SetDirty()
			end

			if arg_672_1.time_ >= var_675_15 + var_675_25 and arg_672_1.time_ < var_675_15 + var_675_25 + arg_675_0 then
				arg_672_1.typewritter.percent = 1

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(true)
			end
		end

		arg_672_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_672_1:InitPlayNodeList()
	end,
	Play1106606171 = function(arg_676_0, arg_676_1)
		arg_676_1.time_ = 0
		arg_676_1.frameCnt_ = 0
		arg_676_1.state_ = "playing"
		arg_676_1.curTalkId_ = 1106606171
		arg_676_1.duration_ = 5

		SetActive(arg_676_1.tipsGo_, false)

		function arg_676_1.onSingleLineFinish_()
			arg_676_1.onSingleLineUpdate_ = nil
			arg_676_1.onSingleLineFinish_ = nil
			arg_676_1.state_ = "waiting"
		end

		function arg_676_1.playNext_(arg_678_0)
			if arg_678_0 == 1 then
				arg_676_0:Play1106606172(arg_676_1)
			end
		end

		function arg_676_1.onSingleLineUpdate_(arg_679_0)
			local var_679_0 = arg_676_1.actors_["1066ui_story"]
			local var_679_1 = 0

			if var_679_1 < arg_676_1.time_ and arg_676_1.time_ <= var_679_1 + arg_679_0 and not isNil(var_679_0) and arg_676_1.var_.characterEffect1066ui_story == nil then
				arg_676_1.var_.characterEffect1066ui_story = var_679_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_679_2 = 0.200000002980232

			if var_679_1 <= arg_676_1.time_ and arg_676_1.time_ < var_679_1 + var_679_2 and not isNil(var_679_0) then
				local var_679_3 = (arg_676_1.time_ - var_679_1) / var_679_2

				if arg_676_1.var_.characterEffect1066ui_story and not isNil(var_679_0) then
					local var_679_4 = Mathf.Lerp(0, 0.5, var_679_3)

					arg_676_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_676_1.var_.characterEffect1066ui_story.fillRatio = var_679_4
				end
			end

			if arg_676_1.time_ >= var_679_1 + var_679_2 and arg_676_1.time_ < var_679_1 + var_679_2 + arg_679_0 and not isNil(var_679_0) and arg_676_1.var_.characterEffect1066ui_story then
				local var_679_5 = 0.5

				arg_676_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_676_1.var_.characterEffect1066ui_story.fillRatio = var_679_5
			end

			local var_679_6 = 0
			local var_679_7 = 0.55

			if var_679_6 < arg_676_1.time_ and arg_676_1.time_ <= var_679_6 + arg_679_0 then
				arg_676_1.talkMaxDuration = 0
				arg_676_1.dialogCg_.alpha = 1

				arg_676_1.dialog_:SetActive(true)
				SetActive(arg_676_1.leftNameGo_, true)

				local var_679_8 = arg_676_1:FormatText(StoryNameCfg[7].name)

				arg_676_1.leftNameTxt_.text = var_679_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_676_1.leftNameTxt_.transform)

				arg_676_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_676_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_676_1:RecordName(arg_676_1.leftNameTxt_.text)
				SetActive(arg_676_1.iconTrs_.gameObject, true)
				arg_676_1.iconController_:SetSelectedState("hero")

				arg_676_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_676_1.callingController_:SetSelectedState("normal")

				arg_676_1.keyicon_.color = Color.New(1, 1, 1)
				arg_676_1.icon_.color = Color.New(1, 1, 1)

				local var_679_9 = arg_676_1:GetWordFromCfg(1106606171)
				local var_679_10 = arg_676_1:FormatText(var_679_9.content)

				arg_676_1.text_.text = var_679_10

				LuaForUtil.ClearLinePrefixSymbol(arg_676_1.text_)

				local var_679_11 = 22
				local var_679_12 = utf8.len(var_679_10)
				local var_679_13 = var_679_11 <= 0 and var_679_7 or var_679_7 * (var_679_12 / var_679_11)

				if var_679_13 > 0 and var_679_7 < var_679_13 then
					arg_676_1.talkMaxDuration = var_679_13

					if var_679_13 + var_679_6 > arg_676_1.duration_ then
						arg_676_1.duration_ = var_679_13 + var_679_6
					end
				end

				arg_676_1.text_.text = var_679_10
				arg_676_1.typewritter.percent = 0

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(false)
				arg_676_1:RecordContent(arg_676_1.text_.text)
			end

			local var_679_14 = math.max(var_679_7, arg_676_1.talkMaxDuration)

			if var_679_6 <= arg_676_1.time_ and arg_676_1.time_ < var_679_6 + var_679_14 then
				arg_676_1.typewritter.percent = (arg_676_1.time_ - var_679_6) / var_679_14

				arg_676_1.typewritter:SetDirty()
			end

			if arg_676_1.time_ >= var_679_6 + var_679_14 and arg_676_1.time_ < var_679_6 + var_679_14 + arg_679_0 then
				arg_676_1.typewritter.percent = 1

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(true)
			end
		end

		arg_676_1.nodeConfigList_ = {}

		arg_676_1:InitPlayNodeList()
	end,
	Play1106606172 = function(arg_680_0, arg_680_1)
		arg_680_1.time_ = 0
		arg_680_1.frameCnt_ = 0
		arg_680_1.state_ = "playing"
		arg_680_1.curTalkId_ = 1106606172
		arg_680_1.duration_ = 6.77

		local var_680_0 = {
			zh = 3.633,
			ja = 6.766
		}
		local var_680_1 = manager.audio:GetLocalizationFlag()

		if var_680_0[var_680_1] ~= nil then
			arg_680_1.duration_ = var_680_0[var_680_1]
		end

		SetActive(arg_680_1.tipsGo_, false)

		function arg_680_1.onSingleLineFinish_()
			arg_680_1.onSingleLineUpdate_ = nil
			arg_680_1.onSingleLineFinish_ = nil
			arg_680_1.state_ = "waiting"
		end

		function arg_680_1.playNext_(arg_682_0)
			if arg_682_0 == 1 then
				arg_680_0:Play1106606173(arg_680_1)
			end
		end

		function arg_680_1.onSingleLineUpdate_(arg_683_0)
			local var_683_0 = arg_680_1.actors_["1066ui_story"].transform
			local var_683_1 = 0

			if var_683_1 < arg_680_1.time_ and arg_680_1.time_ <= var_683_1 + arg_683_0 then
				arg_680_1.var_.moveOldPos1066ui_story = var_683_0.localPosition
			end

			local var_683_2 = 0.001

			if var_683_1 <= arg_680_1.time_ and arg_680_1.time_ < var_683_1 + var_683_2 then
				local var_683_3 = (arg_680_1.time_ - var_683_1) / var_683_2
				local var_683_4 = Vector3.New(0, -0.77, -6.1)

				var_683_0.localPosition = Vector3.Lerp(arg_680_1.var_.moveOldPos1066ui_story, var_683_4, var_683_3)

				local var_683_5 = manager.ui.mainCamera.transform.position - var_683_0.position

				var_683_0.forward = Vector3.New(var_683_5.x, var_683_5.y, var_683_5.z)

				local var_683_6 = var_683_0.localEulerAngles

				var_683_6.z = 0
				var_683_6.x = 0
				var_683_0.localEulerAngles = var_683_6
			end

			if arg_680_1.time_ >= var_683_1 + var_683_2 and arg_680_1.time_ < var_683_1 + var_683_2 + arg_683_0 then
				var_683_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_683_7 = manager.ui.mainCamera.transform.position - var_683_0.position

				var_683_0.forward = Vector3.New(var_683_7.x, var_683_7.y, var_683_7.z)

				local var_683_8 = var_683_0.localEulerAngles

				var_683_8.z = 0
				var_683_8.x = 0
				var_683_0.localEulerAngles = var_683_8
			end

			local var_683_9 = arg_680_1.actors_["1066ui_story"]
			local var_683_10 = 0

			if var_683_10 < arg_680_1.time_ and arg_680_1.time_ <= var_683_10 + arg_683_0 and not isNil(var_683_9) and arg_680_1.var_.characterEffect1066ui_story == nil then
				arg_680_1.var_.characterEffect1066ui_story = var_683_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_683_11 = 0.200000002980232

			if var_683_10 <= arg_680_1.time_ and arg_680_1.time_ < var_683_10 + var_683_11 and not isNil(var_683_9) then
				local var_683_12 = (arg_680_1.time_ - var_683_10) / var_683_11

				if arg_680_1.var_.characterEffect1066ui_story and not isNil(var_683_9) then
					arg_680_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_680_1.time_ >= var_683_10 + var_683_11 and arg_680_1.time_ < var_683_10 + var_683_11 + arg_683_0 and not isNil(var_683_9) and arg_680_1.var_.characterEffect1066ui_story then
				arg_680_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_683_13 = 0

			if var_683_13 < arg_680_1.time_ and arg_680_1.time_ <= var_683_13 + arg_683_0 then
				arg_680_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_683_14 = 0

			if var_683_14 < arg_680_1.time_ and arg_680_1.time_ <= var_683_14 + arg_683_0 then
				arg_680_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_683_15 = 0
			local var_683_16 = 0.2

			if var_683_15 < arg_680_1.time_ and arg_680_1.time_ <= var_683_15 + arg_683_0 then
				arg_680_1.talkMaxDuration = 0
				arg_680_1.dialogCg_.alpha = 1

				arg_680_1.dialog_:SetActive(true)
				SetActive(arg_680_1.leftNameGo_, true)

				local var_683_17 = arg_680_1:FormatText(StoryNameCfg[32].name)

				arg_680_1.leftNameTxt_.text = var_683_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_680_1.leftNameTxt_.transform)

				arg_680_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_680_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_680_1:RecordName(arg_680_1.leftNameTxt_.text)
				SetActive(arg_680_1.iconTrs_.gameObject, false)
				arg_680_1.callingController_:SetSelectedState("normal")

				local var_683_18 = arg_680_1:GetWordFromCfg(1106606172)
				local var_683_19 = arg_680_1:FormatText(var_683_18.content)

				arg_680_1.text_.text = var_683_19

				LuaForUtil.ClearLinePrefixSymbol(arg_680_1.text_)

				local var_683_20 = 8
				local var_683_21 = utf8.len(var_683_19)
				local var_683_22 = var_683_20 <= 0 and var_683_16 or var_683_16 * (var_683_21 / var_683_20)

				if var_683_22 > 0 and var_683_16 < var_683_22 then
					arg_680_1.talkMaxDuration = var_683_22

					if var_683_22 + var_683_15 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_22 + var_683_15
					end
				end

				arg_680_1.text_.text = var_683_19
				arg_680_1.typewritter.percent = 0

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606172", "story_v_side_new_1106606.awb") ~= 0 then
					local var_683_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606172", "story_v_side_new_1106606.awb") / 1000

					if var_683_23 + var_683_15 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_23 + var_683_15
					end

					if var_683_18.prefab_name ~= "" and arg_680_1.actors_[var_683_18.prefab_name] ~= nil then
						local var_683_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_680_1.actors_[var_683_18.prefab_name].transform, "story_v_side_new_1106606", "1106606172", "story_v_side_new_1106606.awb")

						arg_680_1:RecordAudio("1106606172", var_683_24)
						arg_680_1:RecordAudio("1106606172", var_683_24)
					else
						arg_680_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606172", "story_v_side_new_1106606.awb")
					end

					arg_680_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606172", "story_v_side_new_1106606.awb")
				end

				arg_680_1:RecordContent(arg_680_1.text_.text)
			end

			local var_683_25 = math.max(var_683_16, arg_680_1.talkMaxDuration)

			if var_683_15 <= arg_680_1.time_ and arg_680_1.time_ < var_683_15 + var_683_25 then
				arg_680_1.typewritter.percent = (arg_680_1.time_ - var_683_15) / var_683_25

				arg_680_1.typewritter:SetDirty()
			end

			if arg_680_1.time_ >= var_683_15 + var_683_25 and arg_680_1.time_ < var_683_15 + var_683_25 + arg_683_0 then
				arg_680_1.typewritter.percent = 1

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(true)
			end
		end

		arg_680_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_680_1:InitPlayNodeList()
	end,
	Play1106606173 = function(arg_684_0, arg_684_1)
		arg_684_1.time_ = 0
		arg_684_1.frameCnt_ = 0
		arg_684_1.state_ = "playing"
		arg_684_1.curTalkId_ = 1106606173
		arg_684_1.duration_ = 5

		SetActive(arg_684_1.tipsGo_, false)

		function arg_684_1.onSingleLineFinish_()
			arg_684_1.onSingleLineUpdate_ = nil
			arg_684_1.onSingleLineFinish_ = nil
			arg_684_1.state_ = "waiting"
		end

		function arg_684_1.playNext_(arg_686_0)
			if arg_686_0 == 1 then
				arg_684_0:Play1106606174(arg_684_1)
			end
		end

		function arg_684_1.onSingleLineUpdate_(arg_687_0)
			local var_687_0 = arg_684_1.actors_["1066ui_story"]
			local var_687_1 = 0

			if var_687_1 < arg_684_1.time_ and arg_684_1.time_ <= var_687_1 + arg_687_0 and not isNil(var_687_0) and arg_684_1.var_.characterEffect1066ui_story == nil then
				arg_684_1.var_.characterEffect1066ui_story = var_687_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_687_2 = 0.200000002980232

			if var_687_1 <= arg_684_1.time_ and arg_684_1.time_ < var_687_1 + var_687_2 and not isNil(var_687_0) then
				local var_687_3 = (arg_684_1.time_ - var_687_1) / var_687_2

				if arg_684_1.var_.characterEffect1066ui_story and not isNil(var_687_0) then
					local var_687_4 = Mathf.Lerp(0, 0.5, var_687_3)

					arg_684_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_684_1.var_.characterEffect1066ui_story.fillRatio = var_687_4
				end
			end

			if arg_684_1.time_ >= var_687_1 + var_687_2 and arg_684_1.time_ < var_687_1 + var_687_2 + arg_687_0 and not isNil(var_687_0) and arg_684_1.var_.characterEffect1066ui_story then
				local var_687_5 = 0.5

				arg_684_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_684_1.var_.characterEffect1066ui_story.fillRatio = var_687_5
			end

			local var_687_6 = 0
			local var_687_7 = 0.525

			if var_687_6 < arg_684_1.time_ and arg_684_1.time_ <= var_687_6 + arg_687_0 then
				arg_684_1.talkMaxDuration = 0
				arg_684_1.dialogCg_.alpha = 1

				arg_684_1.dialog_:SetActive(true)
				SetActive(arg_684_1.leftNameGo_, false)

				arg_684_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_684_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_684_1:RecordName(arg_684_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_684_1.iconTrs_.gameObject, false)
				arg_684_1.callingController_:SetSelectedState("normal")

				local var_687_8 = arg_684_1:GetWordFromCfg(1106606173)
				local var_687_9 = arg_684_1:FormatText(var_687_8.content)

				arg_684_1.text_.text = var_687_9

				LuaForUtil.ClearLinePrefixSymbol(arg_684_1.text_)

				local var_687_10 = 21
				local var_687_11 = utf8.len(var_687_9)
				local var_687_12 = var_687_10 <= 0 and var_687_7 or var_687_7 * (var_687_11 / var_687_10)

				if var_687_12 > 0 and var_687_7 < var_687_12 then
					arg_684_1.talkMaxDuration = var_687_12

					if var_687_12 + var_687_6 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_12 + var_687_6
					end
				end

				arg_684_1.text_.text = var_687_9
				arg_684_1.typewritter.percent = 0

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(false)
				arg_684_1:RecordContent(arg_684_1.text_.text)
			end

			local var_687_13 = math.max(var_687_7, arg_684_1.talkMaxDuration)

			if var_687_6 <= arg_684_1.time_ and arg_684_1.time_ < var_687_6 + var_687_13 then
				arg_684_1.typewritter.percent = (arg_684_1.time_ - var_687_6) / var_687_13

				arg_684_1.typewritter:SetDirty()
			end

			if arg_684_1.time_ >= var_687_6 + var_687_13 and arg_684_1.time_ < var_687_6 + var_687_13 + arg_687_0 then
				arg_684_1.typewritter.percent = 1

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(true)
			end
		end

		arg_684_1.nodeConfigList_ = {}

		arg_684_1:InitPlayNodeList()
	end,
	Play1106606174 = function(arg_688_0, arg_688_1)
		arg_688_1.time_ = 0
		arg_688_1.frameCnt_ = 0
		arg_688_1.state_ = "playing"
		arg_688_1.curTalkId_ = 1106606174
		arg_688_1.duration_ = 5

		SetActive(arg_688_1.tipsGo_, false)

		function arg_688_1.onSingleLineFinish_()
			arg_688_1.onSingleLineUpdate_ = nil
			arg_688_1.onSingleLineFinish_ = nil
			arg_688_1.state_ = "waiting"
		end

		function arg_688_1.playNext_(arg_690_0)
			if arg_690_0 == 1 then
				arg_688_0:Play1106606175(arg_688_1)
			end
		end

		function arg_688_1.onSingleLineUpdate_(arg_691_0)
			local var_691_0 = 0
			local var_691_1 = 0.8

			if var_691_0 < arg_688_1.time_ and arg_688_1.time_ <= var_691_0 + arg_691_0 then
				arg_688_1.talkMaxDuration = 0
				arg_688_1.dialogCg_.alpha = 1

				arg_688_1.dialog_:SetActive(true)
				SetActive(arg_688_1.leftNameGo_, false)

				arg_688_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_688_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_688_1:RecordName(arg_688_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_688_1.iconTrs_.gameObject, false)
				arg_688_1.callingController_:SetSelectedState("normal")

				local var_691_2 = arg_688_1:GetWordFromCfg(1106606174)
				local var_691_3 = arg_688_1:FormatText(var_691_2.content)

				arg_688_1.text_.text = var_691_3

				LuaForUtil.ClearLinePrefixSymbol(arg_688_1.text_)

				local var_691_4 = 32
				local var_691_5 = utf8.len(var_691_3)
				local var_691_6 = var_691_4 <= 0 and var_691_1 or var_691_1 * (var_691_5 / var_691_4)

				if var_691_6 > 0 and var_691_1 < var_691_6 then
					arg_688_1.talkMaxDuration = var_691_6

					if var_691_6 + var_691_0 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_6 + var_691_0
					end
				end

				arg_688_1.text_.text = var_691_3
				arg_688_1.typewritter.percent = 0

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(false)
				arg_688_1:RecordContent(arg_688_1.text_.text)
			end

			local var_691_7 = math.max(var_691_1, arg_688_1.talkMaxDuration)

			if var_691_0 <= arg_688_1.time_ and arg_688_1.time_ < var_691_0 + var_691_7 then
				arg_688_1.typewritter.percent = (arg_688_1.time_ - var_691_0) / var_691_7

				arg_688_1.typewritter:SetDirty()
			end

			if arg_688_1.time_ >= var_691_0 + var_691_7 and arg_688_1.time_ < var_691_0 + var_691_7 + arg_691_0 then
				arg_688_1.typewritter.percent = 1

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(true)
			end
		end

		arg_688_1.nodeConfigList_ = {}

		arg_688_1:InitPlayNodeList()
	end,
	Play1106606175 = function(arg_692_0, arg_692_1)
		arg_692_1.time_ = 0
		arg_692_1.frameCnt_ = 0
		arg_692_1.state_ = "playing"
		arg_692_1.curTalkId_ = 1106606175
		arg_692_1.duration_ = 7.67

		local var_692_0 = {
			zh = 4.566,
			ja = 7.666
		}
		local var_692_1 = manager.audio:GetLocalizationFlag()

		if var_692_0[var_692_1] ~= nil then
			arg_692_1.duration_ = var_692_0[var_692_1]
		end

		SetActive(arg_692_1.tipsGo_, false)

		function arg_692_1.onSingleLineFinish_()
			arg_692_1.onSingleLineUpdate_ = nil
			arg_692_1.onSingleLineFinish_ = nil
			arg_692_1.state_ = "waiting"
			arg_692_1.auto_ = false
		end

		function arg_692_1.playNext_(arg_694_0)
			arg_692_1.onStoryFinished_()
		end

		function arg_692_1.onSingleLineUpdate_(arg_695_0)
			local var_695_0 = arg_692_1.actors_["1066ui_story"].transform
			local var_695_1 = 0

			if var_695_1 < arg_692_1.time_ and arg_692_1.time_ <= var_695_1 + arg_695_0 then
				arg_692_1.var_.moveOldPos1066ui_story = var_695_0.localPosition
			end

			local var_695_2 = 0.001

			if var_695_1 <= arg_692_1.time_ and arg_692_1.time_ < var_695_1 + var_695_2 then
				local var_695_3 = (arg_692_1.time_ - var_695_1) / var_695_2
				local var_695_4 = Vector3.New(0, -0.77, -6.1)

				var_695_0.localPosition = Vector3.Lerp(arg_692_1.var_.moveOldPos1066ui_story, var_695_4, var_695_3)

				local var_695_5 = manager.ui.mainCamera.transform.position - var_695_0.position

				var_695_0.forward = Vector3.New(var_695_5.x, var_695_5.y, var_695_5.z)

				local var_695_6 = var_695_0.localEulerAngles

				var_695_6.z = 0
				var_695_6.x = 0
				var_695_0.localEulerAngles = var_695_6
			end

			if arg_692_1.time_ >= var_695_1 + var_695_2 and arg_692_1.time_ < var_695_1 + var_695_2 + arg_695_0 then
				var_695_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_695_7 = manager.ui.mainCamera.transform.position - var_695_0.position

				var_695_0.forward = Vector3.New(var_695_7.x, var_695_7.y, var_695_7.z)

				local var_695_8 = var_695_0.localEulerAngles

				var_695_8.z = 0
				var_695_8.x = 0
				var_695_0.localEulerAngles = var_695_8
			end

			local var_695_9 = arg_692_1.actors_["1066ui_story"]
			local var_695_10 = 0

			if var_695_10 < arg_692_1.time_ and arg_692_1.time_ <= var_695_10 + arg_695_0 and not isNil(var_695_9) and arg_692_1.var_.characterEffect1066ui_story == nil then
				arg_692_1.var_.characterEffect1066ui_story = var_695_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_695_11 = 0.200000002980232

			if var_695_10 <= arg_692_1.time_ and arg_692_1.time_ < var_695_10 + var_695_11 and not isNil(var_695_9) then
				local var_695_12 = (arg_692_1.time_ - var_695_10) / var_695_11

				if arg_692_1.var_.characterEffect1066ui_story and not isNil(var_695_9) then
					arg_692_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_692_1.time_ >= var_695_10 + var_695_11 and arg_692_1.time_ < var_695_10 + var_695_11 + arg_695_0 and not isNil(var_695_9) and arg_692_1.var_.characterEffect1066ui_story then
				arg_692_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_695_13 = 0

			if var_695_13 < arg_692_1.time_ and arg_692_1.time_ <= var_695_13 + arg_695_0 then
				arg_692_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			local var_695_14 = 0

			if var_695_14 < arg_692_1.time_ and arg_692_1.time_ <= var_695_14 + arg_695_0 then
				arg_692_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_695_15 = 0
			local var_695_16 = 0.35

			if var_695_15 < arg_692_1.time_ and arg_692_1.time_ <= var_695_15 + arg_695_0 then
				arg_692_1.talkMaxDuration = 0
				arg_692_1.dialogCg_.alpha = 1

				arg_692_1.dialog_:SetActive(true)
				SetActive(arg_692_1.leftNameGo_, true)

				local var_695_17 = arg_692_1:FormatText(StoryNameCfg[32].name)

				arg_692_1.leftNameTxt_.text = var_695_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_692_1.leftNameTxt_.transform)

				arg_692_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_692_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_692_1:RecordName(arg_692_1.leftNameTxt_.text)
				SetActive(arg_692_1.iconTrs_.gameObject, false)
				arg_692_1.callingController_:SetSelectedState("normal")

				local var_695_18 = arg_692_1:GetWordFromCfg(1106606175)
				local var_695_19 = arg_692_1:FormatText(var_695_18.content)

				arg_692_1.text_.text = var_695_19

				LuaForUtil.ClearLinePrefixSymbol(arg_692_1.text_)

				local var_695_20 = 14
				local var_695_21 = utf8.len(var_695_19)
				local var_695_22 = var_695_20 <= 0 and var_695_16 or var_695_16 * (var_695_21 / var_695_20)

				if var_695_22 > 0 and var_695_16 < var_695_22 then
					arg_692_1.talkMaxDuration = var_695_22

					if var_695_22 + var_695_15 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_22 + var_695_15
					end
				end

				arg_692_1.text_.text = var_695_19
				arg_692_1.typewritter.percent = 0

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606175", "story_v_side_new_1106606.awb") ~= 0 then
					local var_695_23 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606175", "story_v_side_new_1106606.awb") / 1000

					if var_695_23 + var_695_15 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_23 + var_695_15
					end

					if var_695_18.prefab_name ~= "" and arg_692_1.actors_[var_695_18.prefab_name] ~= nil then
						local var_695_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_692_1.actors_[var_695_18.prefab_name].transform, "story_v_side_new_1106606", "1106606175", "story_v_side_new_1106606.awb")

						arg_692_1:RecordAudio("1106606175", var_695_24)
						arg_692_1:RecordAudio("1106606175", var_695_24)
					else
						arg_692_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606175", "story_v_side_new_1106606.awb")
					end

					arg_692_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606175", "story_v_side_new_1106606.awb")
				end

				arg_692_1:RecordContent(arg_692_1.text_.text)
			end

			local var_695_25 = math.max(var_695_16, arg_692_1.talkMaxDuration)

			if var_695_15 <= arg_692_1.time_ and arg_692_1.time_ < var_695_15 + var_695_25 then
				arg_692_1.typewritter.percent = (arg_692_1.time_ - var_695_15) / var_695_25

				arg_692_1.typewritter:SetDirty()
			end

			if arg_692_1.time_ >= var_695_15 + var_695_25 and arg_692_1.time_ < var_695_15 + var_695_25 + arg_695_0 then
				arg_692_1.typewritter.percent = 1

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(true)
			end
		end

		arg_692_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_692_1:InitPlayNodeList()
	end,
	Play1106606109 = function(arg_696_0, arg_696_1)
		arg_696_1.time_ = 0
		arg_696_1.frameCnt_ = 0
		arg_696_1.state_ = "playing"
		arg_696_1.curTalkId_ = 1106606109
		arg_696_1.duration_ = 5.9

		local var_696_0 = {
			zh = 5.9,
			ja = 3.733
		}
		local var_696_1 = manager.audio:GetLocalizationFlag()

		if var_696_0[var_696_1] ~= nil then
			arg_696_1.duration_ = var_696_0[var_696_1]
		end

		SetActive(arg_696_1.tipsGo_, false)

		function arg_696_1.onSingleLineFinish_()
			arg_696_1.onSingleLineUpdate_ = nil
			arg_696_1.onSingleLineFinish_ = nil
			arg_696_1.state_ = "waiting"
		end

		function arg_696_1.playNext_(arg_698_0)
			if arg_698_0 == 1 then
				arg_696_0:Play1106606110(arg_696_1)
			end
		end

		function arg_696_1.onSingleLineUpdate_(arg_699_0)
			local var_699_0 = 0
			local var_699_1 = 0.45

			if var_699_0 < arg_696_1.time_ and arg_696_1.time_ <= var_699_0 + arg_699_0 then
				arg_696_1.talkMaxDuration = 0
				arg_696_1.dialogCg_.alpha = 1

				arg_696_1.dialog_:SetActive(true)
				SetActive(arg_696_1.leftNameGo_, true)

				local var_699_2 = arg_696_1:FormatText(StoryNameCfg[32].name)

				arg_696_1.leftNameTxt_.text = var_699_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_696_1.leftNameTxt_.transform)

				arg_696_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_696_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_696_1:RecordName(arg_696_1.leftNameTxt_.text)
				SetActive(arg_696_1.iconTrs_.gameObject, false)
				arg_696_1.callingController_:SetSelectedState("normal")

				local var_699_3 = arg_696_1:GetWordFromCfg(1106606109)
				local var_699_4 = arg_696_1:FormatText(var_699_3.content)

				arg_696_1.text_.text = var_699_4

				LuaForUtil.ClearLinePrefixSymbol(arg_696_1.text_)

				local var_699_5 = 18
				local var_699_6 = utf8.len(var_699_4)
				local var_699_7 = var_699_5 <= 0 and var_699_1 or var_699_1 * (var_699_6 / var_699_5)

				if var_699_7 > 0 and var_699_1 < var_699_7 then
					arg_696_1.talkMaxDuration = var_699_7

					if var_699_7 + var_699_0 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_7 + var_699_0
					end
				end

				arg_696_1.text_.text = var_699_4
				arg_696_1.typewritter.percent = 0

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606109", "story_v_side_new_1106606.awb") ~= 0 then
					local var_699_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606109", "story_v_side_new_1106606.awb") / 1000

					if var_699_8 + var_699_0 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_8 + var_699_0
					end

					if var_699_3.prefab_name ~= "" and arg_696_1.actors_[var_699_3.prefab_name] ~= nil then
						local var_699_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_696_1.actors_[var_699_3.prefab_name].transform, "story_v_side_new_1106606", "1106606109", "story_v_side_new_1106606.awb")

						arg_696_1:RecordAudio("1106606109", var_699_9)
						arg_696_1:RecordAudio("1106606109", var_699_9)
					else
						arg_696_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606109", "story_v_side_new_1106606.awb")
					end

					arg_696_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606109", "story_v_side_new_1106606.awb")
				end

				arg_696_1:RecordContent(arg_696_1.text_.text)
			end

			local var_699_10 = math.max(var_699_1, arg_696_1.talkMaxDuration)

			if var_699_0 <= arg_696_1.time_ and arg_696_1.time_ < var_699_0 + var_699_10 then
				arg_696_1.typewritter.percent = (arg_696_1.time_ - var_699_0) / var_699_10

				arg_696_1.typewritter:SetDirty()
			end

			if arg_696_1.time_ >= var_699_0 + var_699_10 and arg_696_1.time_ < var_699_0 + var_699_10 + arg_699_0 then
				arg_696_1.typewritter.percent = 1

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(true)
			end
		end

		arg_696_1.nodeConfigList_ = {}

		arg_696_1:InitPlayNodeList()
	end,
	Play1106606110 = function(arg_700_0, arg_700_1)
		arg_700_1.time_ = 0
		arg_700_1.frameCnt_ = 0
		arg_700_1.state_ = "playing"
		arg_700_1.curTalkId_ = 1106606110
		arg_700_1.duration_ = 5

		SetActive(arg_700_1.tipsGo_, false)

		function arg_700_1.onSingleLineFinish_()
			arg_700_1.onSingleLineUpdate_ = nil
			arg_700_1.onSingleLineFinish_ = nil
			arg_700_1.state_ = "waiting"
		end

		function arg_700_1.playNext_(arg_702_0)
			if arg_702_0 == 1 then
				arg_700_0:Play1106606111(arg_700_1)
			end
		end

		function arg_700_1.onSingleLineUpdate_(arg_703_0)
			local var_703_0 = 0
			local var_703_1 = 0.925

			if var_703_0 < arg_700_1.time_ and arg_700_1.time_ <= var_703_0 + arg_703_0 then
				arg_700_1.talkMaxDuration = 0
				arg_700_1.dialogCg_.alpha = 1

				arg_700_1.dialog_:SetActive(true)
				SetActive(arg_700_1.leftNameGo_, false)

				arg_700_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_700_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_700_1:RecordName(arg_700_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_700_1.iconTrs_.gameObject, false)
				arg_700_1.callingController_:SetSelectedState("normal")

				local var_703_2 = arg_700_1:GetWordFromCfg(1106606110)
				local var_703_3 = arg_700_1:FormatText(var_703_2.content)

				arg_700_1.text_.text = var_703_3

				LuaForUtil.ClearLinePrefixSymbol(arg_700_1.text_)

				local var_703_4 = 37
				local var_703_5 = utf8.len(var_703_3)
				local var_703_6 = var_703_4 <= 0 and var_703_1 or var_703_1 * (var_703_5 / var_703_4)

				if var_703_6 > 0 and var_703_1 < var_703_6 then
					arg_700_1.talkMaxDuration = var_703_6

					if var_703_6 + var_703_0 > arg_700_1.duration_ then
						arg_700_1.duration_ = var_703_6 + var_703_0
					end
				end

				arg_700_1.text_.text = var_703_3
				arg_700_1.typewritter.percent = 0

				arg_700_1.typewritter:SetDirty()
				arg_700_1:ShowNextGo(false)
				arg_700_1:RecordContent(arg_700_1.text_.text)
			end

			local var_703_7 = math.max(var_703_1, arg_700_1.talkMaxDuration)

			if var_703_0 <= arg_700_1.time_ and arg_700_1.time_ < var_703_0 + var_703_7 then
				arg_700_1.typewritter.percent = (arg_700_1.time_ - var_703_0) / var_703_7

				arg_700_1.typewritter:SetDirty()
			end

			if arg_700_1.time_ >= var_703_0 + var_703_7 and arg_700_1.time_ < var_703_0 + var_703_7 + arg_703_0 then
				arg_700_1.typewritter.percent = 1

				arg_700_1.typewritter:SetDirty()
				arg_700_1:ShowNextGo(true)
			end
		end

		arg_700_1.nodeConfigList_ = {}

		arg_700_1:InitPlayNodeList()
	end,
	Play1106606104 = function(arg_704_0, arg_704_1)
		arg_704_1.time_ = 0
		arg_704_1.frameCnt_ = 0
		arg_704_1.state_ = "playing"
		arg_704_1.curTalkId_ = 1106606104
		arg_704_1.duration_ = 5

		SetActive(arg_704_1.tipsGo_, false)

		function arg_704_1.onSingleLineFinish_()
			arg_704_1.onSingleLineUpdate_ = nil
			arg_704_1.onSingleLineFinish_ = nil
			arg_704_1.state_ = "waiting"
		end

		function arg_704_1.playNext_(arg_706_0)
			if arg_706_0 == 1 then
				arg_704_0:Play1106606105(arg_704_1)
			end
		end

		function arg_704_1.onSingleLineUpdate_(arg_707_0)
			local var_707_0 = 0
			local var_707_1 = 1.125

			if var_707_0 < arg_704_1.time_ and arg_704_1.time_ <= var_707_0 + arg_707_0 then
				arg_704_1.talkMaxDuration = 0
				arg_704_1.dialogCg_.alpha = 1

				arg_704_1.dialog_:SetActive(true)
				SetActive(arg_704_1.leftNameGo_, false)

				arg_704_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_704_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_704_1:RecordName(arg_704_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_704_1.iconTrs_.gameObject, false)
				arg_704_1.callingController_:SetSelectedState("normal")

				local var_707_2 = arg_704_1:GetWordFromCfg(1106606104)
				local var_707_3 = arg_704_1:FormatText(var_707_2.content)

				arg_704_1.text_.text = var_707_3

				LuaForUtil.ClearLinePrefixSymbol(arg_704_1.text_)

				local var_707_4 = 45
				local var_707_5 = utf8.len(var_707_3)
				local var_707_6 = var_707_4 <= 0 and var_707_1 or var_707_1 * (var_707_5 / var_707_4)

				if var_707_6 > 0 and var_707_1 < var_707_6 then
					arg_704_1.talkMaxDuration = var_707_6

					if var_707_6 + var_707_0 > arg_704_1.duration_ then
						arg_704_1.duration_ = var_707_6 + var_707_0
					end
				end

				arg_704_1.text_.text = var_707_3
				arg_704_1.typewritter.percent = 0

				arg_704_1.typewritter:SetDirty()
				arg_704_1:ShowNextGo(false)
				arg_704_1:RecordContent(arg_704_1.text_.text)
			end

			local var_707_7 = math.max(var_707_1, arg_704_1.talkMaxDuration)

			if var_707_0 <= arg_704_1.time_ and arg_704_1.time_ < var_707_0 + var_707_7 then
				arg_704_1.typewritter.percent = (arg_704_1.time_ - var_707_0) / var_707_7

				arg_704_1.typewritter:SetDirty()
			end

			if arg_704_1.time_ >= var_707_0 + var_707_7 and arg_704_1.time_ < var_707_0 + var_707_7 + arg_707_0 then
				arg_704_1.typewritter.percent = 1

				arg_704_1.typewritter:SetDirty()
				arg_704_1:ShowNextGo(true)
			end
		end

		arg_704_1.nodeConfigList_ = {}

		arg_704_1:InitPlayNodeList()
	end,
	Play1106606105 = function(arg_708_0, arg_708_1)
		arg_708_1.time_ = 0
		arg_708_1.frameCnt_ = 0
		arg_708_1.state_ = "playing"
		arg_708_1.curTalkId_ = 1106606105
		arg_708_1.duration_ = 4.37

		local var_708_0 = {
			zh = 4.366,
			ja = 3.8
		}
		local var_708_1 = manager.audio:GetLocalizationFlag()

		if var_708_0[var_708_1] ~= nil then
			arg_708_1.duration_ = var_708_0[var_708_1]
		end

		SetActive(arg_708_1.tipsGo_, false)

		function arg_708_1.onSingleLineFinish_()
			arg_708_1.onSingleLineUpdate_ = nil
			arg_708_1.onSingleLineFinish_ = nil
			arg_708_1.state_ = "waiting"
		end

		function arg_708_1.playNext_(arg_710_0)
			if arg_710_0 == 1 then
				arg_708_0:Play1106606106(arg_708_1)
			end
		end

		function arg_708_1.onSingleLineUpdate_(arg_711_0)
			local var_711_0 = 0
			local var_711_1 = 0.2

			if var_711_0 < arg_708_1.time_ and arg_708_1.time_ <= var_711_0 + arg_711_0 then
				arg_708_1.talkMaxDuration = 0
				arg_708_1.dialogCg_.alpha = 1

				arg_708_1.dialog_:SetActive(true)
				SetActive(arg_708_1.leftNameGo_, true)

				local var_711_2 = arg_708_1:FormatText(StoryNameCfg[32].name)

				arg_708_1.leftNameTxt_.text = var_711_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_708_1.leftNameTxt_.transform)

				arg_708_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_708_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_708_1:RecordName(arg_708_1.leftNameTxt_.text)
				SetActive(arg_708_1.iconTrs_.gameObject, false)
				arg_708_1.callingController_:SetSelectedState("normal")

				local var_711_3 = arg_708_1:GetWordFromCfg(1106606105)
				local var_711_4 = arg_708_1:FormatText(var_711_3.content)

				arg_708_1.text_.text = var_711_4

				LuaForUtil.ClearLinePrefixSymbol(arg_708_1.text_)

				local var_711_5 = 8
				local var_711_6 = utf8.len(var_711_4)
				local var_711_7 = var_711_5 <= 0 and var_711_1 or var_711_1 * (var_711_6 / var_711_5)

				if var_711_7 > 0 and var_711_1 < var_711_7 then
					arg_708_1.talkMaxDuration = var_711_7

					if var_711_7 + var_711_0 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_7 + var_711_0
					end
				end

				arg_708_1.text_.text = var_711_4
				arg_708_1.typewritter.percent = 0

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606105", "story_v_side_new_1106606.awb") ~= 0 then
					local var_711_8 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606105", "story_v_side_new_1106606.awb") / 1000

					if var_711_8 + var_711_0 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_8 + var_711_0
					end

					if var_711_3.prefab_name ~= "" and arg_708_1.actors_[var_711_3.prefab_name] ~= nil then
						local var_711_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_708_1.actors_[var_711_3.prefab_name].transform, "story_v_side_new_1106606", "1106606105", "story_v_side_new_1106606.awb")

						arg_708_1:RecordAudio("1106606105", var_711_9)
						arg_708_1:RecordAudio("1106606105", var_711_9)
					else
						arg_708_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606105", "story_v_side_new_1106606.awb")
					end

					arg_708_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606105", "story_v_side_new_1106606.awb")
				end

				arg_708_1:RecordContent(arg_708_1.text_.text)
			end

			local var_711_10 = math.max(var_711_1, arg_708_1.talkMaxDuration)

			if var_711_0 <= arg_708_1.time_ and arg_708_1.time_ < var_711_0 + var_711_10 then
				arg_708_1.typewritter.percent = (arg_708_1.time_ - var_711_0) / var_711_10

				arg_708_1.typewritter:SetDirty()
			end

			if arg_708_1.time_ >= var_711_0 + var_711_10 and arg_708_1.time_ < var_711_0 + var_711_10 + arg_711_0 then
				arg_708_1.typewritter.percent = 1

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(true)
			end
		end

		arg_708_1.nodeConfigList_ = {}

		arg_708_1:InitPlayNodeList()
	end,
	Play1106606069 = function(arg_712_0, arg_712_1)
		arg_712_1.time_ = 0
		arg_712_1.frameCnt_ = 0
		arg_712_1.state_ = "playing"
		arg_712_1.curTalkId_ = 1106606069
		arg_712_1.duration_ = 6.43

		local var_712_0 = {
			zh = 6.366,
			ja = 6.433
		}
		local var_712_1 = manager.audio:GetLocalizationFlag()

		if var_712_0[var_712_1] ~= nil then
			arg_712_1.duration_ = var_712_0[var_712_1]
		end

		SetActive(arg_712_1.tipsGo_, false)

		function arg_712_1.onSingleLineFinish_()
			arg_712_1.onSingleLineUpdate_ = nil
			arg_712_1.onSingleLineFinish_ = nil
			arg_712_1.state_ = "waiting"
		end

		function arg_712_1.playNext_(arg_714_0)
			if arg_714_0 == 1 then
				arg_712_0:Play1106606070(arg_712_1)
			end
		end

		function arg_712_1.onSingleLineUpdate_(arg_715_0)
			local var_715_0 = arg_712_1.actors_["1066ui_story"].transform
			local var_715_1 = 0

			if var_715_1 < arg_712_1.time_ and arg_712_1.time_ <= var_715_1 + arg_715_0 then
				arg_712_1.var_.moveOldPos1066ui_story = var_715_0.localPosition
			end

			local var_715_2 = 0.001

			if var_715_1 <= arg_712_1.time_ and arg_712_1.time_ < var_715_1 + var_715_2 then
				local var_715_3 = (arg_712_1.time_ - var_715_1) / var_715_2
				local var_715_4 = Vector3.New(0, -0.77, -6.1)

				var_715_0.localPosition = Vector3.Lerp(arg_712_1.var_.moveOldPos1066ui_story, var_715_4, var_715_3)

				local var_715_5 = manager.ui.mainCamera.transform.position - var_715_0.position

				var_715_0.forward = Vector3.New(var_715_5.x, var_715_5.y, var_715_5.z)

				local var_715_6 = var_715_0.localEulerAngles

				var_715_6.z = 0
				var_715_6.x = 0
				var_715_0.localEulerAngles = var_715_6
			end

			if arg_712_1.time_ >= var_715_1 + var_715_2 and arg_712_1.time_ < var_715_1 + var_715_2 + arg_715_0 then
				var_715_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_715_7 = manager.ui.mainCamera.transform.position - var_715_0.position

				var_715_0.forward = Vector3.New(var_715_7.x, var_715_7.y, var_715_7.z)

				local var_715_8 = var_715_0.localEulerAngles

				var_715_8.z = 0
				var_715_8.x = 0
				var_715_0.localEulerAngles = var_715_8
			end

			local var_715_9 = arg_712_1.actors_["1066ui_story"]
			local var_715_10 = 0

			if var_715_10 < arg_712_1.time_ and arg_712_1.time_ <= var_715_10 + arg_715_0 and not isNil(var_715_9) and arg_712_1.var_.characterEffect1066ui_story == nil then
				arg_712_1.var_.characterEffect1066ui_story = var_715_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_715_11 = 0.200000002980232

			if var_715_10 <= arg_712_1.time_ and arg_712_1.time_ < var_715_10 + var_715_11 and not isNil(var_715_9) then
				local var_715_12 = (arg_712_1.time_ - var_715_10) / var_715_11

				if arg_712_1.var_.characterEffect1066ui_story and not isNil(var_715_9) then
					arg_712_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_712_1.time_ >= var_715_10 + var_715_11 and arg_712_1.time_ < var_715_10 + var_715_11 + arg_715_0 and not isNil(var_715_9) and arg_712_1.var_.characterEffect1066ui_story then
				arg_712_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_715_13 = "1066ui_story"

			if arg_712_1.actors_[var_715_13] == nil then
				local var_715_14 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_715_14) then
					local var_715_15 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_712_1.stage_.transform)

					var_715_15.name = var_715_13
					var_715_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_712_1.actors_[var_715_13] = var_715_15

					local var_715_16 = var_715_15:GetComponentInChildren(typeof(CharacterEffect))

					var_715_16.enabled = true

					local var_715_17 = GameObjectTools.GetOrAddComponent(var_715_15, typeof(DynamicBoneHelper))

					if var_715_17 then
						var_715_17:EnableDynamicBone(false)
					end

					arg_712_1:ShowWeapon(var_715_16.transform, false)

					arg_712_1.var_[var_715_13 .. "Animator"] = var_715_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_712_1.var_[var_715_13 .. "Animator"].applyRootMotion = true
					arg_712_1.var_[var_715_13 .. "LipSync"] = var_715_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_715_18 = 0

			if var_715_18 < arg_712_1.time_ and arg_712_1.time_ <= var_715_18 + arg_715_0 then
				arg_712_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_2")
			end

			local var_715_19 = "1066ui_story"

			if arg_712_1.actors_[var_715_19] == nil then
				local var_715_20 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_715_20) then
					local var_715_21 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_712_1.stage_.transform)

					var_715_21.name = var_715_19
					var_715_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_712_1.actors_[var_715_19] = var_715_21

					local var_715_22 = var_715_21:GetComponentInChildren(typeof(CharacterEffect))

					var_715_22.enabled = true

					local var_715_23 = GameObjectTools.GetOrAddComponent(var_715_21, typeof(DynamicBoneHelper))

					if var_715_23 then
						var_715_23:EnableDynamicBone(false)
					end

					arg_712_1:ShowWeapon(var_715_22.transform, false)

					arg_712_1.var_[var_715_19 .. "Animator"] = var_715_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_712_1.var_[var_715_19 .. "Animator"].applyRootMotion = true
					arg_712_1.var_[var_715_19 .. "LipSync"] = var_715_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_715_24 = 0

			if var_715_24 < arg_712_1.time_ and arg_712_1.time_ <= var_715_24 + arg_715_0 then
				arg_712_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_715_25 = 0
			local var_715_26 = 0.65

			if var_715_25 < arg_712_1.time_ and arg_712_1.time_ <= var_715_25 + arg_715_0 then
				arg_712_1.talkMaxDuration = 0
				arg_712_1.dialogCg_.alpha = 1

				arg_712_1.dialog_:SetActive(true)
				SetActive(arg_712_1.leftNameGo_, true)

				local var_715_27 = arg_712_1:FormatText(StoryNameCfg[32].name)

				arg_712_1.leftNameTxt_.text = var_715_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_712_1.leftNameTxt_.transform)

				arg_712_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_712_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_712_1:RecordName(arg_712_1.leftNameTxt_.text)
				SetActive(arg_712_1.iconTrs_.gameObject, false)
				arg_712_1.callingController_:SetSelectedState("normal")

				local var_715_28 = arg_712_1:GetWordFromCfg(1106606069)
				local var_715_29 = arg_712_1:FormatText(var_715_28.content)

				arg_712_1.text_.text = var_715_29

				LuaForUtil.ClearLinePrefixSymbol(arg_712_1.text_)

				local var_715_30 = 26
				local var_715_31 = utf8.len(var_715_29)
				local var_715_32 = var_715_30 <= 0 and var_715_26 or var_715_26 * (var_715_31 / var_715_30)

				if var_715_32 > 0 and var_715_26 < var_715_32 then
					arg_712_1.talkMaxDuration = var_715_32

					if var_715_32 + var_715_25 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_32 + var_715_25
					end
				end

				arg_712_1.text_.text = var_715_29
				arg_712_1.typewritter.percent = 0

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606069", "story_v_side_new_1106606.awb") ~= 0 then
					local var_715_33 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606069", "story_v_side_new_1106606.awb") / 1000

					if var_715_33 + var_715_25 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_33 + var_715_25
					end

					if var_715_28.prefab_name ~= "" and arg_712_1.actors_[var_715_28.prefab_name] ~= nil then
						local var_715_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_712_1.actors_[var_715_28.prefab_name].transform, "story_v_side_new_1106606", "1106606069", "story_v_side_new_1106606.awb")

						arg_712_1:RecordAudio("1106606069", var_715_34)
						arg_712_1:RecordAudio("1106606069", var_715_34)
					else
						arg_712_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606069", "story_v_side_new_1106606.awb")
					end

					arg_712_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606069", "story_v_side_new_1106606.awb")
				end

				arg_712_1:RecordContent(arg_712_1.text_.text)
			end

			local var_715_35 = math.max(var_715_26, arg_712_1.talkMaxDuration)

			if var_715_25 <= arg_712_1.time_ and arg_712_1.time_ < var_715_25 + var_715_35 then
				arg_712_1.typewritter.percent = (arg_712_1.time_ - var_715_25) / var_715_35

				arg_712_1.typewritter:SetDirty()
			end

			if arg_712_1.time_ >= var_715_25 + var_715_35 and arg_712_1.time_ < var_715_25 + var_715_35 + arg_715_0 then
				arg_712_1.typewritter.percent = 1

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(true)
			end
		end

		arg_712_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_712_1:InitPlayNodeList()
	end,
	Play1106606070 = function(arg_716_0, arg_716_1)
		arg_716_1.time_ = 0
		arg_716_1.frameCnt_ = 0
		arg_716_1.state_ = "playing"
		arg_716_1.curTalkId_ = 1106606070
		arg_716_1.duration_ = 5

		SetActive(arg_716_1.tipsGo_, false)

		function arg_716_1.onSingleLineFinish_()
			arg_716_1.onSingleLineUpdate_ = nil
			arg_716_1.onSingleLineFinish_ = nil
			arg_716_1.state_ = "waiting"
		end

		function arg_716_1.playNext_(arg_718_0)
			if arg_718_0 == 1 then
				arg_716_0:Play1106606071(arg_716_1)
			end
		end

		function arg_716_1.onSingleLineUpdate_(arg_719_0)
			local var_719_0 = arg_716_1.actors_["1066ui_story"]
			local var_719_1 = 0

			if var_719_1 < arg_716_1.time_ and arg_716_1.time_ <= var_719_1 + arg_719_0 and not isNil(var_719_0) and arg_716_1.var_.characterEffect1066ui_story == nil then
				arg_716_1.var_.characterEffect1066ui_story = var_719_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_719_2 = 0.200000002980232

			if var_719_1 <= arg_716_1.time_ and arg_716_1.time_ < var_719_1 + var_719_2 and not isNil(var_719_0) then
				local var_719_3 = (arg_716_1.time_ - var_719_1) / var_719_2

				if arg_716_1.var_.characterEffect1066ui_story and not isNil(var_719_0) then
					local var_719_4 = Mathf.Lerp(0, 0.5, var_719_3)

					arg_716_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_716_1.var_.characterEffect1066ui_story.fillRatio = var_719_4
				end
			end

			if arg_716_1.time_ >= var_719_1 + var_719_2 and arg_716_1.time_ < var_719_1 + var_719_2 + arg_719_0 and not isNil(var_719_0) and arg_716_1.var_.characterEffect1066ui_story then
				local var_719_5 = 0.5

				arg_716_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_716_1.var_.characterEffect1066ui_story.fillRatio = var_719_5
			end

			local var_719_6 = 0
			local var_719_7 = 0.225

			if var_719_6 < arg_716_1.time_ and arg_716_1.time_ <= var_719_6 + arg_719_0 then
				arg_716_1.talkMaxDuration = 0
				arg_716_1.dialogCg_.alpha = 1

				arg_716_1.dialog_:SetActive(true)
				SetActive(arg_716_1.leftNameGo_, true)

				local var_719_8 = arg_716_1:FormatText(StoryNameCfg[7].name)

				arg_716_1.leftNameTxt_.text = var_719_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_716_1.leftNameTxt_.transform)

				arg_716_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_716_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_716_1:RecordName(arg_716_1.leftNameTxt_.text)
				SetActive(arg_716_1.iconTrs_.gameObject, true)
				arg_716_1.iconController_:SetSelectedState("hero")

				arg_716_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_716_1.callingController_:SetSelectedState("normal")

				arg_716_1.keyicon_.color = Color.New(1, 1, 1)
				arg_716_1.icon_.color = Color.New(1, 1, 1)

				local var_719_9 = arg_716_1:GetWordFromCfg(1106606070)
				local var_719_10 = arg_716_1:FormatText(var_719_9.content)

				arg_716_1.text_.text = var_719_10

				LuaForUtil.ClearLinePrefixSymbol(arg_716_1.text_)

				local var_719_11 = 9
				local var_719_12 = utf8.len(var_719_10)
				local var_719_13 = var_719_11 <= 0 and var_719_7 or var_719_7 * (var_719_12 / var_719_11)

				if var_719_13 > 0 and var_719_7 < var_719_13 then
					arg_716_1.talkMaxDuration = var_719_13

					if var_719_13 + var_719_6 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_13 + var_719_6
					end
				end

				arg_716_1.text_.text = var_719_10
				arg_716_1.typewritter.percent = 0

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(false)
				arg_716_1:RecordContent(arg_716_1.text_.text)
			end

			local var_719_14 = math.max(var_719_7, arg_716_1.talkMaxDuration)

			if var_719_6 <= arg_716_1.time_ and arg_716_1.time_ < var_719_6 + var_719_14 then
				arg_716_1.typewritter.percent = (arg_716_1.time_ - var_719_6) / var_719_14

				arg_716_1.typewritter:SetDirty()
			end

			if arg_716_1.time_ >= var_719_6 + var_719_14 and arg_716_1.time_ < var_719_6 + var_719_14 + arg_719_0 then
				arg_716_1.typewritter.percent = 1

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(true)
			end
		end

		arg_716_1.nodeConfigList_ = {}

		arg_716_1:InitPlayNodeList()
	end,
	Play1106606015 = function(arg_720_0, arg_720_1)
		arg_720_1.time_ = 0
		arg_720_1.frameCnt_ = 0
		arg_720_1.state_ = "playing"
		arg_720_1.curTalkId_ = 1106606015
		arg_720_1.duration_ = 8.57

		local var_720_0 = {
			zh = 4.533,
			ja = 8.566
		}
		local var_720_1 = manager.audio:GetLocalizationFlag()

		if var_720_0[var_720_1] ~= nil then
			arg_720_1.duration_ = var_720_0[var_720_1]
		end

		SetActive(arg_720_1.tipsGo_, false)

		function arg_720_1.onSingleLineFinish_()
			arg_720_1.onSingleLineUpdate_ = nil
			arg_720_1.onSingleLineFinish_ = nil
			arg_720_1.state_ = "waiting"
		end

		function arg_720_1.playNext_(arg_722_0)
			if arg_722_0 == 1 then
				arg_720_0:Play1106606016(arg_720_1)
			end
		end

		function arg_720_1.onSingleLineUpdate_(arg_723_0)
			local var_723_0 = arg_720_1.actors_["1066ui_story"].transform
			local var_723_1 = 0

			if var_723_1 < arg_720_1.time_ and arg_720_1.time_ <= var_723_1 + arg_723_0 then
				arg_720_1.var_.moveOldPos1066ui_story = var_723_0.localPosition
			end

			local var_723_2 = 0.001

			if var_723_1 <= arg_720_1.time_ and arg_720_1.time_ < var_723_1 + var_723_2 then
				local var_723_3 = (arg_720_1.time_ - var_723_1) / var_723_2
				local var_723_4 = Vector3.New(0, -0.77, -6.1)

				var_723_0.localPosition = Vector3.Lerp(arg_720_1.var_.moveOldPos1066ui_story, var_723_4, var_723_3)

				local var_723_5 = manager.ui.mainCamera.transform.position - var_723_0.position

				var_723_0.forward = Vector3.New(var_723_5.x, var_723_5.y, var_723_5.z)

				local var_723_6 = var_723_0.localEulerAngles

				var_723_6.z = 0
				var_723_6.x = 0
				var_723_0.localEulerAngles = var_723_6
			end

			if arg_720_1.time_ >= var_723_1 + var_723_2 and arg_720_1.time_ < var_723_1 + var_723_2 + arg_723_0 then
				var_723_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_723_7 = manager.ui.mainCamera.transform.position - var_723_0.position

				var_723_0.forward = Vector3.New(var_723_7.x, var_723_7.y, var_723_7.z)

				local var_723_8 = var_723_0.localEulerAngles

				var_723_8.z = 0
				var_723_8.x = 0
				var_723_0.localEulerAngles = var_723_8
			end

			local var_723_9 = arg_720_1.actors_["1066ui_story"]
			local var_723_10 = 0

			if var_723_10 < arg_720_1.time_ and arg_720_1.time_ <= var_723_10 + arg_723_0 and not isNil(var_723_9) and arg_720_1.var_.characterEffect1066ui_story == nil then
				arg_720_1.var_.characterEffect1066ui_story = var_723_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_723_11 = 0.200000002980232

			if var_723_10 <= arg_720_1.time_ and arg_720_1.time_ < var_723_10 + var_723_11 and not isNil(var_723_9) then
				local var_723_12 = (arg_720_1.time_ - var_723_10) / var_723_11

				if arg_720_1.var_.characterEffect1066ui_story and not isNil(var_723_9) then
					arg_720_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_720_1.time_ >= var_723_10 + var_723_11 and arg_720_1.time_ < var_723_10 + var_723_11 + arg_723_0 and not isNil(var_723_9) and arg_720_1.var_.characterEffect1066ui_story then
				arg_720_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_723_13 = "1066ui_story"

			if arg_720_1.actors_[var_723_13] == nil then
				local var_723_14 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_723_14) then
					local var_723_15 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_720_1.stage_.transform)

					var_723_15.name = var_723_13
					var_723_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_720_1.actors_[var_723_13] = var_723_15

					local var_723_16 = var_723_15:GetComponentInChildren(typeof(CharacterEffect))

					var_723_16.enabled = true

					local var_723_17 = GameObjectTools.GetOrAddComponent(var_723_15, typeof(DynamicBoneHelper))

					if var_723_17 then
						var_723_17:EnableDynamicBone(false)
					end

					arg_720_1:ShowWeapon(var_723_16.transform, false)

					arg_720_1.var_[var_723_13 .. "Animator"] = var_723_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_720_1.var_[var_723_13 .. "Animator"].applyRootMotion = true
					arg_720_1.var_[var_723_13 .. "LipSync"] = var_723_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_723_18 = 0

			if var_723_18 < arg_720_1.time_ and arg_720_1.time_ <= var_723_18 + arg_723_0 then
				arg_720_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action436")
			end

			local var_723_19 = "1066ui_story"

			if arg_720_1.actors_[var_723_19] == nil then
				local var_723_20 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_723_20) then
					local var_723_21 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_720_1.stage_.transform)

					var_723_21.name = var_723_19
					var_723_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_720_1.actors_[var_723_19] = var_723_21

					local var_723_22 = var_723_21:GetComponentInChildren(typeof(CharacterEffect))

					var_723_22.enabled = true

					local var_723_23 = GameObjectTools.GetOrAddComponent(var_723_21, typeof(DynamicBoneHelper))

					if var_723_23 then
						var_723_23:EnableDynamicBone(false)
					end

					arg_720_1:ShowWeapon(var_723_22.transform, false)

					arg_720_1.var_[var_723_19 .. "Animator"] = var_723_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_720_1.var_[var_723_19 .. "Animator"].applyRootMotion = true
					arg_720_1.var_[var_723_19 .. "LipSync"] = var_723_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_723_24 = 0

			if var_723_24 < arg_720_1.time_ and arg_720_1.time_ <= var_723_24 + arg_723_0 then
				arg_720_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_723_25 = 0

			if var_723_25 < arg_720_1.time_ and arg_720_1.time_ <= var_723_25 + arg_723_0 then
				arg_720_1.allBtn_.enabled = false
			end

			local var_723_26 = 2.66666666666667

			if arg_720_1.time_ >= var_723_25 + var_723_26 and arg_720_1.time_ < var_723_25 + var_723_26 + arg_723_0 then
				arg_720_1.allBtn_.enabled = true
			end

			local var_723_27 = 0
			local var_723_28 = 0.575

			if var_723_27 < arg_720_1.time_ and arg_720_1.time_ <= var_723_27 + arg_723_0 then
				arg_720_1.talkMaxDuration = 0
				arg_720_1.dialogCg_.alpha = 1

				arg_720_1.dialog_:SetActive(true)
				SetActive(arg_720_1.leftNameGo_, true)

				local var_723_29 = arg_720_1:FormatText(StoryNameCfg[32].name)

				arg_720_1.leftNameTxt_.text = var_723_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_720_1.leftNameTxt_.transform)

				arg_720_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_720_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_720_1:RecordName(arg_720_1.leftNameTxt_.text)
				SetActive(arg_720_1.iconTrs_.gameObject, false)
				arg_720_1.callingController_:SetSelectedState("normal")

				local var_723_30 = arg_720_1:GetWordFromCfg(1106606015)
				local var_723_31 = arg_720_1:FormatText(var_723_30.content)

				arg_720_1.text_.text = var_723_31

				LuaForUtil.ClearLinePrefixSymbol(arg_720_1.text_)

				local var_723_32 = 23
				local var_723_33 = utf8.len(var_723_31)
				local var_723_34 = var_723_32 <= 0 and var_723_28 or var_723_28 * (var_723_33 / var_723_32)

				if var_723_34 > 0 and var_723_28 < var_723_34 then
					arg_720_1.talkMaxDuration = var_723_34

					if var_723_34 + var_723_27 > arg_720_1.duration_ then
						arg_720_1.duration_ = var_723_34 + var_723_27
					end
				end

				arg_720_1.text_.text = var_723_31
				arg_720_1.typewritter.percent = 0

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606015", "story_v_side_new_1106606.awb") ~= 0 then
					local var_723_35 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606015", "story_v_side_new_1106606.awb") / 1000

					if var_723_35 + var_723_27 > arg_720_1.duration_ then
						arg_720_1.duration_ = var_723_35 + var_723_27
					end

					if var_723_30.prefab_name ~= "" and arg_720_1.actors_[var_723_30.prefab_name] ~= nil then
						local var_723_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_720_1.actors_[var_723_30.prefab_name].transform, "story_v_side_new_1106606", "1106606015", "story_v_side_new_1106606.awb")

						arg_720_1:RecordAudio("1106606015", var_723_36)
						arg_720_1:RecordAudio("1106606015", var_723_36)
					else
						arg_720_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606015", "story_v_side_new_1106606.awb")
					end

					arg_720_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606015", "story_v_side_new_1106606.awb")
				end

				arg_720_1:RecordContent(arg_720_1.text_.text)
			end

			local var_723_37 = math.max(var_723_28, arg_720_1.talkMaxDuration)

			if var_723_27 <= arg_720_1.time_ and arg_720_1.time_ < var_723_27 + var_723_37 then
				arg_720_1.typewritter.percent = (arg_720_1.time_ - var_723_27) / var_723_37

				arg_720_1.typewritter:SetDirty()
			end

			if arg_720_1.time_ >= var_723_27 + var_723_37 and arg_720_1.time_ < var_723_27 + var_723_37 + arg_723_0 then
				arg_720_1.typewritter.percent = 1

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(true)
			end
		end

		arg_720_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_720_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/R6602",
		"TextureConfig/Background/R6602a"
	},
	voices = {
		"story_v_side_new_1106606.awb"
	}
}
