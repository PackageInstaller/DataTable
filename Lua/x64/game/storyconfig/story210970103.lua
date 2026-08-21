return {
	Play1109703001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109703001
		arg_1_1.duration_ = 5.93

		local var_1_0 = {
			zh = 5.93333333518108,
			ja = 5.36733333518108
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
				arg_1_0:Play1109703002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B13"

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
				local var_4_5 = arg_1_1.bgs_.B13

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
					if iter_4_0 ~= "B13" then
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

			local var_4_22 = "1019ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1019ui_story"].transform
			local var_4_28 = 1.83333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1019ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(-0.2, -1.08, -5.9)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1019ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["1019ui_story"]
			local var_4_37 = 1.83333333333333

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1019ui_story == nil then
				arg_1_1.var_.characterEffect1019ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect1019ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1019ui_story then
				arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_4_40 = 1.83333333333333

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_4_41 = 1.83333333333333

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_42 = 0
			local var_4_43 = 0.2

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

			local var_4_48 = 0.3
			local var_4_49 = 0.9

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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

			local var_4_54 = 1.86733333518108
			local var_4_55 = 0.475

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

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[13].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(1109703001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 19
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703001", "story_v_side_new_1109703.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703001", "story_v_side_new_1109703.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_side_new_1109703", "1109703001", "story_v_side_new_1109703.awb")

						arg_1_1:RecordAudio("1109703001", var_4_64)
						arg_1_1:RecordAudio("1109703001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703001", "story_v_side_new_1109703.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703001", "story_v_side_new_1109703.awb")
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play1109703002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1109703002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1109703003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1019ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1019ui_story == nil then
				arg_9_1.var_.characterEffect1019ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect1019ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1019ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1019ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1019ui_story.fillRatio = var_12_5
			end

			local var_12_6 = 0
			local var_12_7 = 0.125

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_8 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_9 = arg_9_1:GetWordFromCfg(1109703002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 5
				local var_12_12 = utf8.len(var_12_10)
				local var_12_13 = var_12_11 <= 0 and var_12_7 or var_12_7 * (var_12_12 / var_12_11)

				if var_12_13 > 0 and var_12_7 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_6
					end
				end

				arg_9_1.text_.text = var_12_10
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_14 = math.max(var_12_7, arg_9_1.talkMaxDuration)

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_14 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_6) / var_12_14

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_6 + var_12_14 and arg_9_1.time_ < var_12_6 + var_12_14 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1109703003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1109703003
		arg_13_1.duration_ = 7.47

		local var_13_0 = {
			zh = 7.133,
			ja = 7.466
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
				arg_13_0:Play1109703004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1019ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1019ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1019ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["1019ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1019ui_story == nil then
				arg_13_1.var_.characterEffect1019ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect1019ui_story and not isNil(var_16_9) then
					arg_13_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1019ui_story then
				arg_13_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_16_14 = 0

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_15 = 0
			local var_16_16 = 0.875

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[13].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_18 = arg_13_1:GetWordFromCfg(1109703003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 35
				local var_16_21 = utf8.len(var_16_19)
				local var_16_22 = var_16_20 <= 0 and var_16_16 or var_16_16 * (var_16_21 / var_16_20)

				if var_16_22 > 0 and var_16_16 < var_16_22 then
					arg_13_1.talkMaxDuration = var_16_22

					if var_16_22 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_22 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_19
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703003", "story_v_side_new_1109703.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703003", "story_v_side_new_1109703.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_side_new_1109703", "1109703003", "story_v_side_new_1109703.awb")

						arg_13_1:RecordAudio("1109703003", var_16_24)
						arg_13_1:RecordAudio("1109703003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703003", "story_v_side_new_1109703.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703003", "story_v_side_new_1109703.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_25 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_25 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_25

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_25 and arg_13_1.time_ < var_16_15 + var_16_25 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play1109703004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1109703004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1109703005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1019ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1019ui_story == nil then
				arg_17_1.var_.characterEffect1019ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1019ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1019ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1019ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1019ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.225

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_9 = arg_17_1:GetWordFromCfg(1109703004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 9
				local var_20_12 = utf8.len(var_20_10)
				local var_20_13 = var_20_11 <= 0 and var_20_7 or var_20_7 * (var_20_12 / var_20_11)

				if var_20_13 > 0 and var_20_7 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_14 and arg_17_1.time_ < var_20_6 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1109703005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1109703005
		arg_21_1.duration_ = 9.3

		local var_21_0 = {
			zh = 5.266,
			ja = 9.3
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
				arg_21_0:Play1109703006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1019ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1019ui_story == nil then
				arg_21_1.var_.characterEffect1019ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1019ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1019ui_story then
				arg_21_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_24_4 = 0

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_24_6 = 0
			local var_24_7 = 0.675

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[13].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_9 = arg_21_1:GetWordFromCfg(1109703005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 27
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703005", "story_v_side_new_1109703.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703005", "story_v_side_new_1109703.awb") / 1000

					if var_24_14 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_6
					end

					if var_24_9.prefab_name ~= "" and arg_21_1.actors_[var_24_9.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_9.prefab_name].transform, "story_v_side_new_1109703", "1109703005", "story_v_side_new_1109703.awb")

						arg_21_1:RecordAudio("1109703005", var_24_15)
						arg_21_1:RecordAudio("1109703005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703005", "story_v_side_new_1109703.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703005", "story_v_side_new_1109703.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_16 and arg_21_1.time_ < var_24_6 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1109703006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1109703006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1109703007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1019ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1019ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1019ui_story, var_28_4, var_28_3)

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

			local var_28_9 = arg_25_1.actors_["1019ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1019ui_story == nil then
				arg_25_1.var_.characterEffect1019ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1019ui_story and not isNil(var_28_9) then
					local var_28_13 = Mathf.Lerp(0, 0.5, var_28_12)

					arg_25_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1019ui_story.fillRatio = var_28_13
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1019ui_story then
				local var_28_14 = 0.5

				arg_25_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1019ui_story.fillRatio = var_28_14
			end

			local var_28_15 = 0
			local var_28_16 = 0.4

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_17 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_17

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

				local var_28_18 = arg_25_1:GetWordFromCfg(1109703006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_20 = 16
				local var_28_21 = utf8.len(var_28_19)
				local var_28_22 = var_28_20 <= 0 and var_28_16 or var_28_16 * (var_28_21 / var_28_20)

				if var_28_22 > 0 and var_28_16 < var_28_22 then
					arg_25_1.talkMaxDuration = var_28_22

					if var_28_22 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_19
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_23 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_23 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_23

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_23 and arg_25_1.time_ < var_28_15 + var_28_23 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play1109703007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1109703007
		arg_29_1.duration_ = 3.9

		local var_29_0 = {
			zh = 3,
			ja = 3.9
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
				arg_29_0:Play1109703008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "1097ui_story"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Char/" .. "1097ui_story")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_29_1.stage_.transform)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentInChildren(typeof(CharacterEffect))

					var_32_3.enabled = true

					local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_2, typeof(DynamicBoneHelper))

					if var_32_4 then
						var_32_4:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_3.transform, false)

					arg_29_1.var_[var_32_0 .. "Animator"] = var_32_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_0 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_0 .. "LipSync"] = var_32_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_5 = arg_29_1.actors_["1097ui_story"].transform
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.var_.moveOldPos1097ui_story = var_32_5.localPosition
			end

			local var_32_7 = 0.001

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_7 then
				local var_32_8 = (arg_29_1.time_ - var_32_6) / var_32_7
				local var_32_9 = Vector3.New(0, -0.54, -6.3)

				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1097ui_story, var_32_9, var_32_8)

				local var_32_10 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_10.x, var_32_10.y, var_32_10.z)

				local var_32_11 = var_32_5.localEulerAngles

				var_32_11.z = 0
				var_32_11.x = 0
				var_32_5.localEulerAngles = var_32_11
			end

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_32_12 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_12.x, var_32_12.y, var_32_12.z)

				local var_32_13 = var_32_5.localEulerAngles

				var_32_13.z = 0
				var_32_13.x = 0
				var_32_5.localEulerAngles = var_32_13
			end

			local var_32_14 = arg_29_1.actors_["1097ui_story"]
			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect1097ui_story == nil then
				arg_29_1.var_.characterEffect1097ui_story = var_32_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_16 = 0.200000002980232

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_16 and not isNil(var_32_14) then
				local var_32_17 = (arg_29_1.time_ - var_32_15) / var_32_16

				if arg_29_1.var_.characterEffect1097ui_story and not isNil(var_32_14) then
					arg_29_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_15 + var_32_16 and arg_29_1.time_ < var_32_15 + var_32_16 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect1097ui_story then
				arg_29_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_32_18 = 0

			if var_32_18 < arg_29_1.time_ and arg_29_1.time_ <= var_32_18 + arg_32_0 then
				arg_29_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_32_19 = 0

			if var_32_19 < arg_29_1.time_ and arg_29_1.time_ <= var_32_19 + arg_32_0 then
				arg_29_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_32_20 = 0
			local var_32_21 = 0.25

			if var_32_20 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_22 = arg_29_1:FormatText(StoryNameCfg[216].name)

				arg_29_1.leftNameTxt_.text = var_32_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_23 = arg_29_1:GetWordFromCfg(1109703007)
				local var_32_24 = arg_29_1:FormatText(var_32_23.content)

				arg_29_1.text_.text = var_32_24

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_25 = 10
				local var_32_26 = utf8.len(var_32_24)
				local var_32_27 = var_32_25 <= 0 and var_32_21 or var_32_21 * (var_32_26 / var_32_25)

				if var_32_27 > 0 and var_32_21 < var_32_27 then
					arg_29_1.talkMaxDuration = var_32_27

					if var_32_27 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_27 + var_32_20
					end
				end

				arg_29_1.text_.text = var_32_24
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703007", "story_v_side_new_1109703.awb") ~= 0 then
					local var_32_28 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703007", "story_v_side_new_1109703.awb") / 1000

					if var_32_28 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_28 + var_32_20
					end

					if var_32_23.prefab_name ~= "" and arg_29_1.actors_[var_32_23.prefab_name] ~= nil then
						local var_32_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_23.prefab_name].transform, "story_v_side_new_1109703", "1109703007", "story_v_side_new_1109703.awb")

						arg_29_1:RecordAudio("1109703007", var_32_29)
						arg_29_1:RecordAudio("1109703007", var_32_29)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703007", "story_v_side_new_1109703.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703007", "story_v_side_new_1109703.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_30 = math.max(var_32_21, arg_29_1.talkMaxDuration)

			if var_32_20 <= arg_29_1.time_ and arg_29_1.time_ < var_32_20 + var_32_30 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_20) / var_32_30

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_20 + var_32_30 and arg_29_1.time_ < var_32_20 + var_32_30 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play1109703008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109703008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1109703009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1097ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1097ui_story == nil then
				arg_33_1.var_.characterEffect1097ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1097ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1097ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1097ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1097ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.375

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_9 = arg_33_1:GetWordFromCfg(1109703008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 15
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
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1109703009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1109703009
		arg_37_1.duration_ = 9

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1109703010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "ST12"

			if arg_37_1.bgs_[var_40_0] == nil then
				local var_40_1 = Object.Instantiate(arg_37_1.paintGo_)

				var_40_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_40_0)
				var_40_1.name = var_40_0
				var_40_1.transform.parent = arg_37_1.stage_.transform
				var_40_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.bgs_[var_40_0] = var_40_1
			end

			local var_40_2 = 2

			if var_40_2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				local var_40_3 = manager.ui.mainCamera.transform.localPosition
				local var_40_4 = Vector3.New(0, 0, 10) + Vector3.New(var_40_3.x, var_40_3.y, 0)
				local var_40_5 = arg_37_1.bgs_.ST12

				var_40_5.transform.localPosition = var_40_4
				var_40_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_6 = var_40_5:GetComponent("SpriteRenderer")

				if var_40_6 and var_40_6.sprite then
					local var_40_7 = (var_40_5.transform.localPosition - var_40_3).z
					local var_40_8 = manager.ui.mainCameraCom_
					local var_40_9 = 2 * var_40_7 * Mathf.Tan(var_40_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_40_10 = var_40_9 * var_40_8.aspect
					local var_40_11 = var_40_6.sprite.bounds.size.x
					local var_40_12 = var_40_6.sprite.bounds.size.y
					local var_40_13 = var_40_10 / var_40_11
					local var_40_14 = var_40_9 / var_40_12
					local var_40_15 = var_40_14 < var_40_13 and var_40_13 or var_40_14

					var_40_5.transform.localScale = Vector3.New(var_40_15, var_40_15, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "ST12" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_17 = 2

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17
				local var_40_19 = Color.New(0, 0, 0)

				var_40_19.a = Mathf.Lerp(0, 1, var_40_18)
				arg_37_1.mask_.color = var_40_19
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 then
				local var_40_20 = Color.New(0, 0, 0)

				var_40_20.a = 1
				arg_37_1.mask_.color = var_40_20
			end

			local var_40_21 = 2

			if var_40_21 < arg_37_1.time_ and arg_37_1.time_ <= var_40_21 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_22 = 2

			if var_40_21 <= arg_37_1.time_ and arg_37_1.time_ < var_40_21 + var_40_22 then
				local var_40_23 = (arg_37_1.time_ - var_40_21) / var_40_22
				local var_40_24 = Color.New(0, 0, 0)

				var_40_24.a = Mathf.Lerp(1, 0, var_40_23)
				arg_37_1.mask_.color = var_40_24
			end

			if arg_37_1.time_ >= var_40_21 + var_40_22 and arg_37_1.time_ < var_40_21 + var_40_22 + arg_40_0 then
				local var_40_25 = Color.New(0, 0, 0)
				local var_40_26 = 0

				arg_37_1.mask_.enabled = false
				var_40_25.a = var_40_26
				arg_37_1.mask_.color = var_40_25
			end

			local var_40_27 = arg_37_1.actors_["1097ui_story"].transform
			local var_40_28 = 1.966

			if var_40_28 < arg_37_1.time_ and arg_37_1.time_ <= var_40_28 + arg_40_0 then
				arg_37_1.var_.moveOldPos1097ui_story = var_40_27.localPosition
			end

			local var_40_29 = 0.001

			if var_40_28 <= arg_37_1.time_ and arg_37_1.time_ < var_40_28 + var_40_29 then
				local var_40_30 = (arg_37_1.time_ - var_40_28) / var_40_29
				local var_40_31 = Vector3.New(0, 100, 0)

				var_40_27.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1097ui_story, var_40_31, var_40_30)

				local var_40_32 = manager.ui.mainCamera.transform.position - var_40_27.position

				var_40_27.forward = Vector3.New(var_40_32.x, var_40_32.y, var_40_32.z)

				local var_40_33 = var_40_27.localEulerAngles

				var_40_33.z = 0
				var_40_33.x = 0
				var_40_27.localEulerAngles = var_40_33
			end

			if arg_37_1.time_ >= var_40_28 + var_40_29 and arg_37_1.time_ < var_40_28 + var_40_29 + arg_40_0 then
				var_40_27.localPosition = Vector3.New(0, 100, 0)

				local var_40_34 = manager.ui.mainCamera.transform.position - var_40_27.position

				var_40_27.forward = Vector3.New(var_40_34.x, var_40_34.y, var_40_34.z)

				local var_40_35 = var_40_27.localEulerAngles

				var_40_35.z = 0
				var_40_35.x = 0
				var_40_27.localEulerAngles = var_40_35
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_36 = 4
			local var_40_37 = 0.35

			if var_40_36 < arg_37_1.time_ and arg_37_1.time_ <= var_40_36 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_38 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_38:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_39 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_40 = arg_37_1:GetWordFromCfg(1109703009)
				local var_40_41 = arg_37_1:FormatText(var_40_40.content)

				arg_37_1.text_.text = var_40_41

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_42 = 14
				local var_40_43 = utf8.len(var_40_41)
				local var_40_44 = var_40_42 <= 0 and var_40_37 or var_40_37 * (var_40_43 / var_40_42)

				if var_40_44 > 0 and var_40_37 < var_40_44 then
					arg_37_1.talkMaxDuration = var_40_44
					var_40_36 = var_40_36 + 0.3

					if var_40_44 + var_40_36 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_44 + var_40_36
					end
				end

				arg_37_1.text_.text = var_40_41
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_45 = var_40_36 + 0.3
			local var_40_46 = math.max(var_40_37, arg_37_1.talkMaxDuration)

			if var_40_45 <= arg_37_1.time_ and arg_37_1.time_ < var_40_45 + var_40_46 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_45) / var_40_46

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_45 + var_40_46 and arg_37_1.time_ < var_40_45 + var_40_46 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play1109703010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1109703010
		arg_43_1.duration_ = 4.4

		local var_43_0 = {
			zh = 4.033,
			ja = 4.4
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
				arg_43_0:Play1109703011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1097ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos1097ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(0, -0.54, -6.3)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1097ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = arg_43_1.actors_["1097ui_story"]
			local var_46_10 = 0

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect1097ui_story == nil then
				arg_43_1.var_.characterEffect1097ui_story = var_46_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_11 = 0.200000002980232

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_11 and not isNil(var_46_9) then
				local var_46_12 = (arg_43_1.time_ - var_46_10) / var_46_11

				if arg_43_1.var_.characterEffect1097ui_story and not isNil(var_46_9) then
					arg_43_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_10 + var_46_11 and arg_43_1.time_ < var_46_10 + var_46_11 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect1097ui_story then
				arg_43_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_46_13 = 0

			if var_46_13 < arg_43_1.time_ and arg_43_1.time_ <= var_46_13 + arg_46_0 then
				arg_43_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_46_14 = 0

			if var_46_14 < arg_43_1.time_ and arg_43_1.time_ <= var_46_14 + arg_46_0 then
				arg_43_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_46_15 = 0
			local var_46_16 = 0.325

			if var_46_15 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_17 = arg_43_1:FormatText(StoryNameCfg[216].name)

				arg_43_1.leftNameTxt_.text = var_46_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_18 = arg_43_1:GetWordFromCfg(1109703010)
				local var_46_19 = arg_43_1:FormatText(var_46_18.content)

				arg_43_1.text_.text = var_46_19

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_20 = 13
				local var_46_21 = utf8.len(var_46_19)
				local var_46_22 = var_46_20 <= 0 and var_46_16 or var_46_16 * (var_46_21 / var_46_20)

				if var_46_22 > 0 and var_46_16 < var_46_22 then
					arg_43_1.talkMaxDuration = var_46_22

					if var_46_22 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_22 + var_46_15
					end
				end

				arg_43_1.text_.text = var_46_19
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703010", "story_v_side_new_1109703.awb") ~= 0 then
					local var_46_23 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703010", "story_v_side_new_1109703.awb") / 1000

					if var_46_23 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_23 + var_46_15
					end

					if var_46_18.prefab_name ~= "" and arg_43_1.actors_[var_46_18.prefab_name] ~= nil then
						local var_46_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_18.prefab_name].transform, "story_v_side_new_1109703", "1109703010", "story_v_side_new_1109703.awb")

						arg_43_1:RecordAudio("1109703010", var_46_24)
						arg_43_1:RecordAudio("1109703010", var_46_24)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703010", "story_v_side_new_1109703.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703010", "story_v_side_new_1109703.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_25 = math.max(var_46_16, arg_43_1.talkMaxDuration)

			if var_46_15 <= arg_43_1.time_ and arg_43_1.time_ < var_46_15 + var_46_25 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_15) / var_46_25

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_15 + var_46_25 and arg_43_1.time_ < var_46_15 + var_46_25 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play1109703011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1109703011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1109703012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1097ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1097ui_story == nil then
				arg_47_1.var_.characterEffect1097ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect1097ui_story and not isNil(var_50_0) then
					local var_50_4 = Mathf.Lerp(0, 0.5, var_50_3)

					arg_47_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1097ui_story.fillRatio = var_50_4
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1097ui_story then
				local var_50_5 = 0.5

				arg_47_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1097ui_story.fillRatio = var_50_5
			end

			local var_50_6 = 0
			local var_50_7 = 0.35

			if var_50_6 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_8 = arg_47_1:GetWordFromCfg(1109703011)
				local var_50_9 = arg_47_1:FormatText(var_50_8.content)

				arg_47_1.text_.text = var_50_9

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_10 = 14
				local var_50_11 = utf8.len(var_50_9)
				local var_50_12 = var_50_10 <= 0 and var_50_7 or var_50_7 * (var_50_11 / var_50_10)

				if var_50_12 > 0 and var_50_7 < var_50_12 then
					arg_47_1.talkMaxDuration = var_50_12

					if var_50_12 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_6
					end
				end

				arg_47_1.text_.text = var_50_9
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_13 = math.max(var_50_7, arg_47_1.talkMaxDuration)

			if var_50_6 <= arg_47_1.time_ and arg_47_1.time_ < var_50_6 + var_50_13 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_6) / var_50_13

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_6 + var_50_13 and arg_47_1.time_ < var_50_6 + var_50_13 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play1109703012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1109703012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1109703013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.475

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[7].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(1109703012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 19
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_8 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_8 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_8

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_8 and arg_51_1.time_ < var_54_0 + var_54_8 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play1109703013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1109703013
		arg_55_1.duration_ = 9.6

		local var_55_0 = {
			zh = 8.133,
			ja = 9.6
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
				arg_55_0:Play1109703014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1097ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1097ui_story == nil then
				arg_55_1.var_.characterEffect1097ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect1097ui_story and not isNil(var_58_0) then
					arg_55_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1097ui_story then
				arg_55_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_58_4 = 0

			if var_58_4 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_58_5 = 0

			if var_58_5 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 then
				arg_55_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_6 = 0
			local var_58_7 = 1

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_8 = arg_55_1:FormatText(StoryNameCfg[216].name)

				arg_55_1.leftNameTxt_.text = var_58_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_9 = arg_55_1:GetWordFromCfg(1109703013)
				local var_58_10 = arg_55_1:FormatText(var_58_9.content)

				arg_55_1.text_.text = var_58_10

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_11 = 40
				local var_58_12 = utf8.len(var_58_10)
				local var_58_13 = var_58_11 <= 0 and var_58_7 or var_58_7 * (var_58_12 / var_58_11)

				if var_58_13 > 0 and var_58_7 < var_58_13 then
					arg_55_1.talkMaxDuration = var_58_13

					if var_58_13 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_6
					end
				end

				arg_55_1.text_.text = var_58_10
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703013", "story_v_side_new_1109703.awb") ~= 0 then
					local var_58_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703013", "story_v_side_new_1109703.awb") / 1000

					if var_58_14 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_14 + var_58_6
					end

					if var_58_9.prefab_name ~= "" and arg_55_1.actors_[var_58_9.prefab_name] ~= nil then
						local var_58_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_9.prefab_name].transform, "story_v_side_new_1109703", "1109703013", "story_v_side_new_1109703.awb")

						arg_55_1:RecordAudio("1109703013", var_58_15)
						arg_55_1:RecordAudio("1109703013", var_58_15)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703013", "story_v_side_new_1109703.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703013", "story_v_side_new_1109703.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_16 = math.max(var_58_7, arg_55_1.talkMaxDuration)

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_16 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_6) / var_58_16

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_6 + var_58_16 and arg_55_1.time_ < var_58_6 + var_58_16 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1109703014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1109703014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1109703015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1097ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1097ui_story == nil then
				arg_59_1.var_.characterEffect1097ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1097ui_story and not isNil(var_62_0) then
					local var_62_4 = Mathf.Lerp(0, 0.5, var_62_3)

					arg_59_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1097ui_story.fillRatio = var_62_4
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1097ui_story then
				local var_62_5 = 0.5

				arg_59_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1097ui_story.fillRatio = var_62_5
			end

			local var_62_6 = 0
			local var_62_7 = 0.25

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_8 = arg_59_1:FormatText(StoryNameCfg[7].name)

				arg_59_1.leftNameTxt_.text = var_62_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_9 = arg_59_1:GetWordFromCfg(1109703014)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 10
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
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_14 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_14 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_14

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_14 and arg_59_1.time_ < var_62_6 + var_62_14 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play1109703015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1109703015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1109703016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.775

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_2 = arg_63_1:GetWordFromCfg(1109703015)
				local var_66_3 = arg_63_1:FormatText(var_66_2.content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 31
				local var_66_5 = utf8.len(var_66_3)
				local var_66_6 = var_66_4 <= 0 and var_66_1 or var_66_1 * (var_66_5 / var_66_4)

				if var_66_6 > 0 and var_66_1 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_7 and arg_63_1.time_ < var_66_0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1109703016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1109703016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1109703017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.8

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[7].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(1109703016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 32
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_8 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_8 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_8

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_8 and arg_67_1.time_ < var_70_0 + var_70_8 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1109703017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1109703017
		arg_71_1.duration_ = 7.23

		local var_71_0 = {
			zh = 5.133,
			ja = 7.233
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1109703018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1097ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1097ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, -0.54, -6.3)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1097ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = arg_71_1.actors_["1097ui_story"]
			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1097ui_story == nil then
				arg_71_1.var_.characterEffect1097ui_story = var_74_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_11 = 0.200000002980232

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_11 and not isNil(var_74_9) then
				local var_74_12 = (arg_71_1.time_ - var_74_10) / var_74_11

				if arg_71_1.var_.characterEffect1097ui_story and not isNil(var_74_9) then
					arg_71_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_10 + var_74_11 and arg_71_1.time_ < var_74_10 + var_74_11 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1097ui_story then
				arg_71_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_74_13 = 0

			if var_74_13 < arg_71_1.time_ and arg_71_1.time_ <= var_74_13 + arg_74_0 then
				arg_71_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_74_14 = 0

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_74_15 = 0
			local var_74_16 = 0.775

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_17 = arg_71_1:FormatText(StoryNameCfg[216].name)

				arg_71_1.leftNameTxt_.text = var_74_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_18 = arg_71_1:GetWordFromCfg(1109703017)
				local var_74_19 = arg_71_1:FormatText(var_74_18.content)

				arg_71_1.text_.text = var_74_19

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_20 = 31
				local var_74_21 = utf8.len(var_74_19)
				local var_74_22 = var_74_20 <= 0 and var_74_16 or var_74_16 * (var_74_21 / var_74_20)

				if var_74_22 > 0 and var_74_16 < var_74_22 then
					arg_71_1.talkMaxDuration = var_74_22

					if var_74_22 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_22 + var_74_15
					end
				end

				arg_71_1.text_.text = var_74_19
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703017", "story_v_side_new_1109703.awb") ~= 0 then
					local var_74_23 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703017", "story_v_side_new_1109703.awb") / 1000

					if var_74_23 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_23 + var_74_15
					end

					if var_74_18.prefab_name ~= "" and arg_71_1.actors_[var_74_18.prefab_name] ~= nil then
						local var_74_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_18.prefab_name].transform, "story_v_side_new_1109703", "1109703017", "story_v_side_new_1109703.awb")

						arg_71_1:RecordAudio("1109703017", var_74_24)
						arg_71_1:RecordAudio("1109703017", var_74_24)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703017", "story_v_side_new_1109703.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703017", "story_v_side_new_1109703.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_25 = math.max(var_74_16, arg_71_1.talkMaxDuration)

			if var_74_15 <= arg_71_1.time_ and arg_71_1.time_ < var_74_15 + var_74_25 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_15) / var_74_25

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_15 + var_74_25 and arg_71_1.time_ < var_74_15 + var_74_25 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play1109703018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1109703018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1109703019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1097ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1097ui_story == nil then
				arg_75_1.var_.characterEffect1097ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1097ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1097ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1097ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1097ui_story.fillRatio = var_78_5
			end

			local var_78_6 = 0
			local var_78_7 = 0.925

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_8 = arg_75_1:FormatText(StoryNameCfg[7].name)

				arg_75_1.leftNameTxt_.text = var_78_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_9 = arg_75_1:GetWordFromCfg(1109703018)
				local var_78_10 = arg_75_1:FormatText(var_78_9.content)

				arg_75_1.text_.text = var_78_10

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_11 = 37
				local var_78_12 = utf8.len(var_78_10)
				local var_78_13 = var_78_11 <= 0 and var_78_7 or var_78_7 * (var_78_12 / var_78_11)

				if var_78_13 > 0 and var_78_7 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_10
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_14 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_14 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_14

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_14 and arg_75_1.time_ < var_78_6 + var_78_14 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1109703019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1109703019
		arg_79_1.duration_ = 6.9

		local var_79_0 = {
			zh = 4.066,
			ja = 6.9
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1109703020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1097ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1097ui_story == nil then
				arg_79_1.var_.characterEffect1097ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect1097ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1097ui_story then
				arg_79_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_82_4 = 0

			if var_82_4 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_82_5 = 0

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_82_6 = 0
			local var_82_7 = 0.375

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_8 = arg_79_1:FormatText(StoryNameCfg[216].name)

				arg_79_1.leftNameTxt_.text = var_82_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_9 = arg_79_1:GetWordFromCfg(1109703019)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 15
				local var_82_12 = utf8.len(var_82_10)
				local var_82_13 = var_82_11 <= 0 and var_82_7 or var_82_7 * (var_82_12 / var_82_11)

				if var_82_13 > 0 and var_82_7 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703019", "story_v_side_new_1109703.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703019", "story_v_side_new_1109703.awb") / 1000

					if var_82_14 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_6
					end

					if var_82_9.prefab_name ~= "" and arg_79_1.actors_[var_82_9.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_9.prefab_name].transform, "story_v_side_new_1109703", "1109703019", "story_v_side_new_1109703.awb")

						arg_79_1:RecordAudio("1109703019", var_82_15)
						arg_79_1:RecordAudio("1109703019", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703019", "story_v_side_new_1109703.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703019", "story_v_side_new_1109703.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_16 and arg_79_1.time_ < var_82_6 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1109703020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1109703020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1109703021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1097ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1097ui_story == nil then
				arg_83_1.var_.characterEffect1097ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1097ui_story and not isNil(var_86_0) then
					local var_86_4 = Mathf.Lerp(0, 0.5, var_86_3)

					arg_83_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1097ui_story.fillRatio = var_86_4
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1097ui_story then
				local var_86_5 = 0.5

				arg_83_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1097ui_story.fillRatio = var_86_5
			end

			local var_86_6 = 0
			local var_86_7 = 1.075

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_8 = arg_83_1:GetWordFromCfg(1109703020)
				local var_86_9 = arg_83_1:FormatText(var_86_8.content)

				arg_83_1.text_.text = var_86_9

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 43
				local var_86_11 = utf8.len(var_86_9)
				local var_86_12 = var_86_10 <= 0 and var_86_7 or var_86_7 * (var_86_11 / var_86_10)

				if var_86_12 > 0 and var_86_7 < var_86_12 then
					arg_83_1.talkMaxDuration = var_86_12

					if var_86_12 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_12 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_9
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_13 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_13 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_13

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_13 and arg_83_1.time_ < var_86_6 + var_86_13 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play1109703021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1109703021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1109703022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.8

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

				local var_90_3 = arg_87_1:GetWordFromCfg(1109703021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 32
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
	Play1109703022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1109703022
		arg_91_1.duration_ = 3.97

		local var_91_0 = {
			zh = 3.4,
			ja = 3.966
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1109703023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1097ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1097ui_story == nil then
				arg_91_1.var_.characterEffect1097ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1097ui_story and not isNil(var_94_0) then
					arg_91_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1097ui_story then
				arg_91_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_94_4 = 0

			if var_94_4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_94_5 = 0
			local var_94_6 = 0.25

			if var_94_5 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_7 = arg_91_1:FormatText(StoryNameCfg[216].name)

				arg_91_1.leftNameTxt_.text = var_94_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_8 = arg_91_1:GetWordFromCfg(1109703022)
				local var_94_9 = arg_91_1:FormatText(var_94_8.content)

				arg_91_1.text_.text = var_94_9

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_10 = 10
				local var_94_11 = utf8.len(var_94_9)
				local var_94_12 = var_94_10 <= 0 and var_94_6 or var_94_6 * (var_94_11 / var_94_10)

				if var_94_12 > 0 and var_94_6 < var_94_12 then
					arg_91_1.talkMaxDuration = var_94_12

					if var_94_12 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_12 + var_94_5
					end
				end

				arg_91_1.text_.text = var_94_9
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703022", "story_v_side_new_1109703.awb") ~= 0 then
					local var_94_13 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703022", "story_v_side_new_1109703.awb") / 1000

					if var_94_13 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_13 + var_94_5
					end

					if var_94_8.prefab_name ~= "" and arg_91_1.actors_[var_94_8.prefab_name] ~= nil then
						local var_94_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_8.prefab_name].transform, "story_v_side_new_1109703", "1109703022", "story_v_side_new_1109703.awb")

						arg_91_1:RecordAudio("1109703022", var_94_14)
						arg_91_1:RecordAudio("1109703022", var_94_14)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703022", "story_v_side_new_1109703.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703022", "story_v_side_new_1109703.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_15 = math.max(var_94_6, arg_91_1.talkMaxDuration)

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_15 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_5) / var_94_15

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_5 + var_94_15 and arg_91_1.time_ < var_94_5 + var_94_15 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1109703023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1109703023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1109703024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1097ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1097ui_story == nil then
				arg_95_1.var_.characterEffect1097ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1097ui_story and not isNil(var_98_0) then
					local var_98_4 = Mathf.Lerp(0, 0.5, var_98_3)

					arg_95_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1097ui_story.fillRatio = var_98_4
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1097ui_story then
				local var_98_5 = 0.5

				arg_95_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1097ui_story.fillRatio = var_98_5
			end

			local var_98_6 = 0
			local var_98_7 = 0.675

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_8 = arg_95_1:FormatText(StoryNameCfg[7].name)

				arg_95_1.leftNameTxt_.text = var_98_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_9 = arg_95_1:GetWordFromCfg(1109703023)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 27
				local var_98_12 = utf8.len(var_98_10)
				local var_98_13 = var_98_11 <= 0 and var_98_7 or var_98_7 * (var_98_12 / var_98_11)

				if var_98_13 > 0 and var_98_7 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_14 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_14 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_14

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_14 and arg_95_1.time_ < var_98_6 + var_98_14 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1109703024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1109703024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1109703025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.775

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_2 = arg_99_1:GetWordFromCfg(1109703024)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 31
				local var_102_5 = utf8.len(var_102_3)
				local var_102_6 = var_102_4 <= 0 and var_102_1 or var_102_1 * (var_102_5 / var_102_4)

				if var_102_6 > 0 and var_102_1 < var_102_6 then
					arg_99_1.talkMaxDuration = var_102_6

					if var_102_6 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_7 and arg_99_1.time_ < var_102_0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1109703025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1109703025
		arg_103_1.duration_ = 6.37

		local var_103_0 = {
			zh = 4.1,
			ja = 6.366
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1109703026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1097ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1097ui_story == nil then
				arg_103_1.var_.characterEffect1097ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1097ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1097ui_story then
				arg_103_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_106_4 = 0

			if var_106_4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_106_5 = 0

			if var_106_5 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_106_6 = 0
			local var_106_7 = 0.45

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_8 = arg_103_1:FormatText(StoryNameCfg[216].name)

				arg_103_1.leftNameTxt_.text = var_106_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_9 = arg_103_1:GetWordFromCfg(1109703025)
				local var_106_10 = arg_103_1:FormatText(var_106_9.content)

				arg_103_1.text_.text = var_106_10

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_11 = 18
				local var_106_12 = utf8.len(var_106_10)
				local var_106_13 = var_106_11 <= 0 and var_106_7 or var_106_7 * (var_106_12 / var_106_11)

				if var_106_13 > 0 and var_106_7 < var_106_13 then
					arg_103_1.talkMaxDuration = var_106_13

					if var_106_13 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_6
					end
				end

				arg_103_1.text_.text = var_106_10
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703025", "story_v_side_new_1109703.awb") ~= 0 then
					local var_106_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703025", "story_v_side_new_1109703.awb") / 1000

					if var_106_14 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_14 + var_106_6
					end

					if var_106_9.prefab_name ~= "" and arg_103_1.actors_[var_106_9.prefab_name] ~= nil then
						local var_106_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_9.prefab_name].transform, "story_v_side_new_1109703", "1109703025", "story_v_side_new_1109703.awb")

						arg_103_1:RecordAudio("1109703025", var_106_15)
						arg_103_1:RecordAudio("1109703025", var_106_15)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703025", "story_v_side_new_1109703.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703025", "story_v_side_new_1109703.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_16 = math.max(var_106_7, arg_103_1.talkMaxDuration)

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_16 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_6) / var_106_16

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_6 + var_106_16 and arg_103_1.time_ < var_106_6 + var_106_16 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play1109703026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1109703026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1109703027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1097ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1097ui_story == nil then
				arg_107_1.var_.characterEffect1097ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect1097ui_story and not isNil(var_110_0) then
					local var_110_4 = Mathf.Lerp(0, 0.5, var_110_3)

					arg_107_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1097ui_story.fillRatio = var_110_4
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1097ui_story then
				local var_110_5 = 0.5

				arg_107_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1097ui_story.fillRatio = var_110_5
			end

			local var_110_6 = 0
			local var_110_7 = 0.325

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_8 = arg_107_1:GetWordFromCfg(1109703026)
				local var_110_9 = arg_107_1:FormatText(var_110_8.content)

				arg_107_1.text_.text = var_110_9

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_10 = 13
				local var_110_11 = utf8.len(var_110_9)
				local var_110_12 = var_110_10 <= 0 and var_110_7 or var_110_7 * (var_110_11 / var_110_10)

				if var_110_12 > 0 and var_110_7 < var_110_12 then
					arg_107_1.talkMaxDuration = var_110_12

					if var_110_12 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_12 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_9
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_13 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_13 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_13

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_13 and arg_107_1.time_ < var_110_6 + var_110_13 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play1109703027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1109703027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1109703028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_114_1 = 0
			local var_114_2 = 0.2

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_3 = arg_111_1:FormatText(StoryNameCfg[7].name)

				arg_111_1.leftNameTxt_.text = var_114_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_4 = arg_111_1:GetWordFromCfg(1109703027)
				local var_114_5 = arg_111_1:FormatText(var_114_4.content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_6 = 8
				local var_114_7 = utf8.len(var_114_5)
				local var_114_8 = var_114_6 <= 0 and var_114_2 or var_114_2 * (var_114_7 / var_114_6)

				if var_114_8 > 0 and var_114_2 < var_114_8 then
					arg_111_1.talkMaxDuration = var_114_8

					if var_114_8 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_9 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_9 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_9

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_9 and arg_111_1.time_ < var_114_1 + var_114_9 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1109703028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1109703028
		arg_115_1.duration_ = 10.6

		local var_115_0 = {
			zh = 8.165999999999,
			ja = 10.599999999999
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1109703029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 2

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				local var_118_1 = manager.ui.mainCamera.transform.localPosition
				local var_118_2 = Vector3.New(0, 0, 10) + Vector3.New(var_118_1.x, var_118_1.y, 0)
				local var_118_3 = arg_115_1.bgs_.ST12

				var_118_3.transform.localPosition = var_118_2
				var_118_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_118_4 = var_118_3:GetComponent("SpriteRenderer")

				if var_118_4 and var_118_4.sprite then
					local var_118_5 = (var_118_3.transform.localPosition - var_118_1).z
					local var_118_6 = manager.ui.mainCameraCom_
					local var_118_7 = 2 * var_118_5 * Mathf.Tan(var_118_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_118_8 = var_118_7 * var_118_6.aspect
					local var_118_9 = var_118_4.sprite.bounds.size.x
					local var_118_10 = var_118_4.sprite.bounds.size.y
					local var_118_11 = var_118_8 / var_118_9
					local var_118_12 = var_118_7 / var_118_10
					local var_118_13 = var_118_12 < var_118_11 and var_118_11 or var_118_12

					var_118_3.transform.localScale = Vector3.New(var_118_13, var_118_13, 0)
				end

				for iter_118_0, iter_118_1 in pairs(arg_115_1.bgs_) do
					if iter_118_0 ~= "ST12" then
						iter_118_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_118_14 = 0

			if var_118_14 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_15 = 2

			if var_118_14 <= arg_115_1.time_ and arg_115_1.time_ < var_118_14 + var_118_15 then
				local var_118_16 = (arg_115_1.time_ - var_118_14) / var_118_15
				local var_118_17 = Color.New(0, 0, 0)

				var_118_17.a = Mathf.Lerp(0, 1, var_118_16)
				arg_115_1.mask_.color = var_118_17
			end

			if arg_115_1.time_ >= var_118_14 + var_118_15 and arg_115_1.time_ < var_118_14 + var_118_15 + arg_118_0 then
				local var_118_18 = Color.New(0, 0, 0)

				var_118_18.a = 1
				arg_115_1.mask_.color = var_118_18
			end

			local var_118_19 = 2

			if var_118_19 < arg_115_1.time_ and arg_115_1.time_ <= var_118_19 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_20 = 2

			if var_118_19 <= arg_115_1.time_ and arg_115_1.time_ < var_118_19 + var_118_20 then
				local var_118_21 = (arg_115_1.time_ - var_118_19) / var_118_20
				local var_118_22 = Color.New(0, 0, 0)

				var_118_22.a = Mathf.Lerp(1, 0, var_118_21)
				arg_115_1.mask_.color = var_118_22
			end

			if arg_115_1.time_ >= var_118_19 + var_118_20 and arg_115_1.time_ < var_118_19 + var_118_20 + arg_118_0 then
				local var_118_23 = Color.New(0, 0, 0)
				local var_118_24 = 0

				arg_115_1.mask_.enabled = false
				var_118_23.a = var_118_24
				arg_115_1.mask_.color = var_118_23
			end

			local var_118_25 = arg_115_1.actors_["1097ui_story"].transform
			local var_118_26 = 1.96599999815226

			if var_118_26 < arg_115_1.time_ and arg_115_1.time_ <= var_118_26 + arg_118_0 then
				arg_115_1.var_.moveOldPos1097ui_story = var_118_25.localPosition
			end

			local var_118_27 = 0.001

			if var_118_26 <= arg_115_1.time_ and arg_115_1.time_ < var_118_26 + var_118_27 then
				local var_118_28 = (arg_115_1.time_ - var_118_26) / var_118_27
				local var_118_29 = Vector3.New(0, 100, 0)

				var_118_25.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1097ui_story, var_118_29, var_118_28)

				local var_118_30 = manager.ui.mainCamera.transform.position - var_118_25.position

				var_118_25.forward = Vector3.New(var_118_30.x, var_118_30.y, var_118_30.z)

				local var_118_31 = var_118_25.localEulerAngles

				var_118_31.z = 0
				var_118_31.x = 0
				var_118_25.localEulerAngles = var_118_31
			end

			if arg_115_1.time_ >= var_118_26 + var_118_27 and arg_115_1.time_ < var_118_26 + var_118_27 + arg_118_0 then
				var_118_25.localPosition = Vector3.New(0, 100, 0)

				local var_118_32 = manager.ui.mainCamera.transform.position - var_118_25.position

				var_118_25.forward = Vector3.New(var_118_32.x, var_118_32.y, var_118_32.z)

				local var_118_33 = var_118_25.localEulerAngles

				var_118_33.z = 0
				var_118_33.x = 0
				var_118_25.localEulerAngles = var_118_33
			end

			local var_118_34 = arg_115_1.actors_["1097ui_story"]
			local var_118_35 = 1.96599999815226

			if var_118_35 < arg_115_1.time_ and arg_115_1.time_ <= var_118_35 + arg_118_0 and not isNil(var_118_34) and arg_115_1.var_.characterEffect1097ui_story == nil then
				arg_115_1.var_.characterEffect1097ui_story = var_118_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_36 = 0.034000001847744

			if var_118_35 <= arg_115_1.time_ and arg_115_1.time_ < var_118_35 + var_118_36 and not isNil(var_118_34) then
				local var_118_37 = (arg_115_1.time_ - var_118_35) / var_118_36

				if arg_115_1.var_.characterEffect1097ui_story and not isNil(var_118_34) then
					local var_118_38 = Mathf.Lerp(0, 0.5, var_118_37)

					arg_115_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1097ui_story.fillRatio = var_118_38
				end
			end

			if arg_115_1.time_ >= var_118_35 + var_118_36 and arg_115_1.time_ < var_118_35 + var_118_36 + arg_118_0 and not isNil(var_118_34) and arg_115_1.var_.characterEffect1097ui_story then
				local var_118_39 = 0.5

				arg_115_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1097ui_story.fillRatio = var_118_39
			end

			local var_118_40 = "1042ui_story"

			if arg_115_1.actors_[var_118_40] == nil then
				local var_118_41 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_118_41) then
					local var_118_42 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_115_1.stage_.transform)

					var_118_42.name = var_118_40
					var_118_42.transform.localPosition = Vector3.New(0, 100, 0)
					arg_115_1.actors_[var_118_40] = var_118_42

					local var_118_43 = var_118_42:GetComponentInChildren(typeof(CharacterEffect))

					var_118_43.enabled = true

					local var_118_44 = GameObjectTools.GetOrAddComponent(var_118_42, typeof(DynamicBoneHelper))

					if var_118_44 then
						var_118_44:EnableDynamicBone(false)
					end

					arg_115_1:ShowWeapon(var_118_43.transform, false)

					arg_115_1.var_[var_118_40 .. "Animator"] = var_118_43.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_115_1.var_[var_118_40 .. "Animator"].applyRootMotion = true
					arg_115_1.var_[var_118_40 .. "LipSync"] = var_118_43.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_118_45 = arg_115_1.actors_["1042ui_story"].transform
			local var_118_46 = 3.8

			if var_118_46 < arg_115_1.time_ and arg_115_1.time_ <= var_118_46 + arg_118_0 then
				arg_115_1.var_.moveOldPos1042ui_story = var_118_45.localPosition
			end

			local var_118_47 = 0.001

			if var_118_46 <= arg_115_1.time_ and arg_115_1.time_ < var_118_46 + var_118_47 then
				local var_118_48 = (arg_115_1.time_ - var_118_46) / var_118_47
				local var_118_49 = Vector3.New(0.7, -1.06, -6.2)

				var_118_45.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1042ui_story, var_118_49, var_118_48)

				local var_118_50 = manager.ui.mainCamera.transform.position - var_118_45.position

				var_118_45.forward = Vector3.New(var_118_50.x, var_118_50.y, var_118_50.z)

				local var_118_51 = var_118_45.localEulerAngles

				var_118_51.z = 0
				var_118_51.x = 0
				var_118_45.localEulerAngles = var_118_51
			end

			if arg_115_1.time_ >= var_118_46 + var_118_47 and arg_115_1.time_ < var_118_46 + var_118_47 + arg_118_0 then
				var_118_45.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_118_52 = manager.ui.mainCamera.transform.position - var_118_45.position

				var_118_45.forward = Vector3.New(var_118_52.x, var_118_52.y, var_118_52.z)

				local var_118_53 = var_118_45.localEulerAngles

				var_118_53.z = 0
				var_118_53.x = 0
				var_118_45.localEulerAngles = var_118_53
			end

			local var_118_54 = arg_115_1.actors_["1042ui_story"]
			local var_118_55 = 3.8

			if var_118_55 < arg_115_1.time_ and arg_115_1.time_ <= var_118_55 + arg_118_0 and not isNil(var_118_54) and arg_115_1.var_.characterEffect1042ui_story == nil then
				arg_115_1.var_.characterEffect1042ui_story = var_118_54:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_56 = 0.200000002980232

			if var_118_55 <= arg_115_1.time_ and arg_115_1.time_ < var_118_55 + var_118_56 and not isNil(var_118_54) then
				local var_118_57 = (arg_115_1.time_ - var_118_55) / var_118_56

				if arg_115_1.var_.characterEffect1042ui_story and not isNil(var_118_54) then
					arg_115_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_55 + var_118_56 and arg_115_1.time_ < var_118_55 + var_118_56 + arg_118_0 and not isNil(var_118_54) and arg_115_1.var_.characterEffect1042ui_story then
				arg_115_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_118_58 = 3.8

			if var_118_58 < arg_115_1.time_ and arg_115_1.time_ <= var_118_58 + arg_118_0 then
				arg_115_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_118_59 = 3.8

			if var_118_59 < arg_115_1.time_ and arg_115_1.time_ <= var_118_59 + arg_118_0 then
				arg_115_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_60 = arg_115_1.actors_["1097ui_story"].transform
			local var_118_61 = 3.8

			if var_118_61 < arg_115_1.time_ and arg_115_1.time_ <= var_118_61 + arg_118_0 then
				arg_115_1.var_.moveOldPos1097ui_story = var_118_60.localPosition
			end

			local var_118_62 = 0.001

			if var_118_61 <= arg_115_1.time_ and arg_115_1.time_ < var_118_61 + var_118_62 then
				local var_118_63 = (arg_115_1.time_ - var_118_61) / var_118_62
				local var_118_64 = Vector3.New(-0.7, -0.54, -6.3)

				var_118_60.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1097ui_story, var_118_64, var_118_63)

				local var_118_65 = manager.ui.mainCamera.transform.position - var_118_60.position

				var_118_60.forward = Vector3.New(var_118_65.x, var_118_65.y, var_118_65.z)

				local var_118_66 = var_118_60.localEulerAngles

				var_118_66.z = 0
				var_118_66.x = 0
				var_118_60.localEulerAngles = var_118_66
			end

			if arg_115_1.time_ >= var_118_61 + var_118_62 and arg_115_1.time_ < var_118_61 + var_118_62 + arg_118_0 then
				var_118_60.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_118_67 = manager.ui.mainCamera.transform.position - var_118_60.position

				var_118_60.forward = Vector3.New(var_118_67.x, var_118_67.y, var_118_67.z)

				local var_118_68 = var_118_60.localEulerAngles

				var_118_68.z = 0
				var_118_68.x = 0
				var_118_60.localEulerAngles = var_118_68
			end

			local var_118_69 = arg_115_1.actors_["1042ui_story"]
			local var_118_70 = 3.8

			if var_118_70 < arg_115_1.time_ and arg_115_1.time_ <= var_118_70 + arg_118_0 then
				if arg_115_1.var_.characterEffect1042ui_story == nil then
					arg_115_1.var_.characterEffect1042ui_story = var_118_69:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_118_71 = arg_115_1.var_.characterEffect1042ui_story

				var_118_71.imageEffect:turnOff()

				var_118_71.interferenceEffect.enabled = true
				var_118_71.interferenceEffect.noise = 0.001
				var_118_71.interferenceEffect.simTimeScale = 1
				var_118_71.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_118_72 = arg_115_1.actors_["1042ui_story"]
			local var_118_73 = 3.8
			local var_118_74 = 0.199999999999

			if var_118_73 < arg_115_1.time_ and arg_115_1.time_ <= var_118_73 + arg_118_0 then
				if arg_115_1.var_.characterEffect1042ui_story == nil then
					arg_115_1.var_.characterEffect1042ui_story = var_118_72:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_115_1.var_.characterEffect1042ui_story.imageEffect:turnOn(false)
			end

			if arg_115_1.frameCnt_ <= 1 then
				arg_115_1.dialog_:SetActive(false)
			end

			local var_118_75 = 3.999999999999
			local var_118_76 = 0.475

			if var_118_75 < arg_115_1.time_ and arg_115_1.time_ <= var_118_75 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_77 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_77:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_77:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_77:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_78 = arg_115_1:FormatText(StoryNameCfg[205].name)

				arg_115_1.leftNameTxt_.text = var_118_78

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_79 = arg_115_1:GetWordFromCfg(1109703028)
				local var_118_80 = arg_115_1:FormatText(var_118_79.content)

				arg_115_1.text_.text = var_118_80

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_81 = 19
				local var_118_82 = utf8.len(var_118_80)
				local var_118_83 = var_118_81 <= 0 and var_118_76 or var_118_76 * (var_118_82 / var_118_81)

				if var_118_83 > 0 and var_118_76 < var_118_83 then
					arg_115_1.talkMaxDuration = var_118_83
					var_118_75 = var_118_75 + 0.3

					if var_118_83 + var_118_75 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_83 + var_118_75
					end
				end

				arg_115_1.text_.text = var_118_80
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703028", "story_v_side_new_1109703.awb") ~= 0 then
					local var_118_84 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703028", "story_v_side_new_1109703.awb") / 1000

					if var_118_84 + var_118_75 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_84 + var_118_75
					end

					if var_118_79.prefab_name ~= "" and arg_115_1.actors_[var_118_79.prefab_name] ~= nil then
						local var_118_85 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_79.prefab_name].transform, "story_v_side_new_1109703", "1109703028", "story_v_side_new_1109703.awb")

						arg_115_1:RecordAudio("1109703028", var_118_85)
						arg_115_1:RecordAudio("1109703028", var_118_85)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703028", "story_v_side_new_1109703.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703028", "story_v_side_new_1109703.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_86 = var_118_75 + 0.3
			local var_118_87 = math.max(var_118_76, arg_115_1.talkMaxDuration)

			if var_118_86 <= arg_115_1.time_ and arg_115_1.time_ < var_118_86 + var_118_87 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_86) / var_118_87

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_86 + var_118_87 and arg_115_1.time_ < var_118_86 + var_118_87 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play1109703029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1109703029
		arg_121_1.duration_ = 5.27

		local var_121_0 = {
			zh = 4.766,
			ja = 5.266
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1109703030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1097ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1097ui_story == nil then
				arg_121_1.var_.characterEffect1097ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1097ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1097ui_story then
				arg_121_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_124_4 = 0

			if var_124_4 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_124_5 = 0

			if var_124_5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_124_6 = arg_121_1.actors_["1042ui_story"]
			local var_124_7 = 0

			if var_124_7 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1042ui_story == nil then
				arg_121_1.var_.characterEffect1042ui_story = var_124_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_8 = 0.200000002980232

			if var_124_7 <= arg_121_1.time_ and arg_121_1.time_ < var_124_7 + var_124_8 and not isNil(var_124_6) then
				local var_124_9 = (arg_121_1.time_ - var_124_7) / var_124_8

				if arg_121_1.var_.characterEffect1042ui_story and not isNil(var_124_6) then
					local var_124_10 = Mathf.Lerp(0, 0.5, var_124_9)

					arg_121_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1042ui_story.fillRatio = var_124_10
				end
			end

			if arg_121_1.time_ >= var_124_7 + var_124_8 and arg_121_1.time_ < var_124_7 + var_124_8 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1042ui_story then
				local var_124_11 = 0.5

				arg_121_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1042ui_story.fillRatio = var_124_11
			end

			local var_124_12 = 0
			local var_124_13 = 0.5

			if var_124_12 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_14 = arg_121_1:FormatText(StoryNameCfg[216].name)

				arg_121_1.leftNameTxt_.text = var_124_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_15 = arg_121_1:GetWordFromCfg(1109703029)
				local var_124_16 = arg_121_1:FormatText(var_124_15.content)

				arg_121_1.text_.text = var_124_16

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_17 = 20
				local var_124_18 = utf8.len(var_124_16)
				local var_124_19 = var_124_17 <= 0 and var_124_13 or var_124_13 * (var_124_18 / var_124_17)

				if var_124_19 > 0 and var_124_13 < var_124_19 then
					arg_121_1.talkMaxDuration = var_124_19

					if var_124_19 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_19 + var_124_12
					end
				end

				arg_121_1.text_.text = var_124_16
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703029", "story_v_side_new_1109703.awb") ~= 0 then
					local var_124_20 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703029", "story_v_side_new_1109703.awb") / 1000

					if var_124_20 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_20 + var_124_12
					end

					if var_124_15.prefab_name ~= "" and arg_121_1.actors_[var_124_15.prefab_name] ~= nil then
						local var_124_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_15.prefab_name].transform, "story_v_side_new_1109703", "1109703029", "story_v_side_new_1109703.awb")

						arg_121_1:RecordAudio("1109703029", var_124_21)
						arg_121_1:RecordAudio("1109703029", var_124_21)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703029", "story_v_side_new_1109703.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703029", "story_v_side_new_1109703.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_22 = math.max(var_124_13, arg_121_1.talkMaxDuration)

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_22 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_12) / var_124_22

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_12 + var_124_22 and arg_121_1.time_ < var_124_12 + var_124_22 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1109703030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1109703030
		arg_125_1.duration_ = 5.83

		local var_125_0 = {
			zh = 5.233,
			ja = 5.833
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1109703031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1042ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1042ui_story == nil then
				arg_125_1.var_.characterEffect1042ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1042ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1042ui_story then
				arg_125_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_128_4 = 0

			if var_128_4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_128_5 = 0

			if var_128_5 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_6 = arg_125_1.actors_["1097ui_story"]
			local var_128_7 = 0

			if var_128_7 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1097ui_story == nil then
				arg_125_1.var_.characterEffect1097ui_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_8 = 0.200000002980232

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_8 and not isNil(var_128_6) then
				local var_128_9 = (arg_125_1.time_ - var_128_7) / var_128_8

				if arg_125_1.var_.characterEffect1097ui_story and not isNil(var_128_6) then
					local var_128_10 = Mathf.Lerp(0, 0.5, var_128_9)

					arg_125_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1097ui_story.fillRatio = var_128_10
				end
			end

			if arg_125_1.time_ >= var_128_7 + var_128_8 and arg_125_1.time_ < var_128_7 + var_128_8 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1097ui_story then
				local var_128_11 = 0.5

				arg_125_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1097ui_story.fillRatio = var_128_11
			end

			local var_128_12 = 0
			local var_128_13 = 0.55

			if var_128_12 < arg_125_1.time_ and arg_125_1.time_ <= var_128_12 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_14 = arg_125_1:FormatText(StoryNameCfg[205].name)

				arg_125_1.leftNameTxt_.text = var_128_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_15 = arg_125_1:GetWordFromCfg(1109703030)
				local var_128_16 = arg_125_1:FormatText(var_128_15.content)

				arg_125_1.text_.text = var_128_16

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_17 = 22
				local var_128_18 = utf8.len(var_128_16)
				local var_128_19 = var_128_17 <= 0 and var_128_13 or var_128_13 * (var_128_18 / var_128_17)

				if var_128_19 > 0 and var_128_13 < var_128_19 then
					arg_125_1.talkMaxDuration = var_128_19

					if var_128_19 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_19 + var_128_12
					end
				end

				arg_125_1.text_.text = var_128_16
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703030", "story_v_side_new_1109703.awb") ~= 0 then
					local var_128_20 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703030", "story_v_side_new_1109703.awb") / 1000

					if var_128_20 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_20 + var_128_12
					end

					if var_128_15.prefab_name ~= "" and arg_125_1.actors_[var_128_15.prefab_name] ~= nil then
						local var_128_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_15.prefab_name].transform, "story_v_side_new_1109703", "1109703030", "story_v_side_new_1109703.awb")

						arg_125_1:RecordAudio("1109703030", var_128_21)
						arg_125_1:RecordAudio("1109703030", var_128_21)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703030", "story_v_side_new_1109703.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703030", "story_v_side_new_1109703.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_22 = math.max(var_128_13, arg_125_1.talkMaxDuration)

			if var_128_12 <= arg_125_1.time_ and arg_125_1.time_ < var_128_12 + var_128_22 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_12) / var_128_22

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_12 + var_128_22 and arg_125_1.time_ < var_128_12 + var_128_22 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1109703031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1109703031
		arg_129_1.duration_ = 6.9

		local var_129_0 = {
			zh = 4.933,
			ja = 6.9
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1109703032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1097ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1097ui_story == nil then
				arg_129_1.var_.characterEffect1097ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1097ui_story and not isNil(var_132_0) then
					arg_129_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1097ui_story then
				arg_129_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_132_4 = 0

			if var_132_4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_132_5 = arg_129_1.actors_["1042ui_story"]
			local var_132_6 = 0

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1042ui_story == nil then
				arg_129_1.var_.characterEffect1042ui_story = var_132_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_7 = 0.200000002980232

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_7 and not isNil(var_132_5) then
				local var_132_8 = (arg_129_1.time_ - var_132_6) / var_132_7

				if arg_129_1.var_.characterEffect1042ui_story and not isNil(var_132_5) then
					local var_132_9 = Mathf.Lerp(0, 0.5, var_132_8)

					arg_129_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1042ui_story.fillRatio = var_132_9
				end
			end

			if arg_129_1.time_ >= var_132_6 + var_132_7 and arg_129_1.time_ < var_132_6 + var_132_7 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1042ui_story then
				local var_132_10 = 0.5

				arg_129_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1042ui_story.fillRatio = var_132_10
			end

			local var_132_11 = 0
			local var_132_12 = 0.6

			if var_132_11 < arg_129_1.time_ and arg_129_1.time_ <= var_132_11 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_13 = arg_129_1:FormatText(StoryNameCfg[216].name)

				arg_129_1.leftNameTxt_.text = var_132_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_14 = arg_129_1:GetWordFromCfg(1109703031)
				local var_132_15 = arg_129_1:FormatText(var_132_14.content)

				arg_129_1.text_.text = var_132_15

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_16 = 24
				local var_132_17 = utf8.len(var_132_15)
				local var_132_18 = var_132_16 <= 0 and var_132_12 or var_132_12 * (var_132_17 / var_132_16)

				if var_132_18 > 0 and var_132_12 < var_132_18 then
					arg_129_1.talkMaxDuration = var_132_18

					if var_132_18 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_18 + var_132_11
					end
				end

				arg_129_1.text_.text = var_132_15
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703031", "story_v_side_new_1109703.awb") ~= 0 then
					local var_132_19 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703031", "story_v_side_new_1109703.awb") / 1000

					if var_132_19 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_19 + var_132_11
					end

					if var_132_14.prefab_name ~= "" and arg_129_1.actors_[var_132_14.prefab_name] ~= nil then
						local var_132_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_14.prefab_name].transform, "story_v_side_new_1109703", "1109703031", "story_v_side_new_1109703.awb")

						arg_129_1:RecordAudio("1109703031", var_132_20)
						arg_129_1:RecordAudio("1109703031", var_132_20)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703031", "story_v_side_new_1109703.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703031", "story_v_side_new_1109703.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_21 = math.max(var_132_12, arg_129_1.talkMaxDuration)

			if var_132_11 <= arg_129_1.time_ and arg_129_1.time_ < var_132_11 + var_132_21 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_11) / var_132_21

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_11 + var_132_21 and arg_129_1.time_ < var_132_11 + var_132_21 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1109703032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1109703032
		arg_133_1.duration_ = 11.47

		local var_133_0 = {
			zh = 7.465999999999,
			ja = 11.465999999999
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1109703033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 2

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				local var_136_1 = manager.ui.mainCamera.transform.localPosition
				local var_136_2 = Vector3.New(0, 0, 10) + Vector3.New(var_136_1.x, var_136_1.y, 0)
				local var_136_3 = arg_133_1.bgs_.ST12

				var_136_3.transform.localPosition = var_136_2
				var_136_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_4 = var_136_3:GetComponent("SpriteRenderer")

				if var_136_4 and var_136_4.sprite then
					local var_136_5 = (var_136_3.transform.localPosition - var_136_1).z
					local var_136_6 = manager.ui.mainCameraCom_
					local var_136_7 = 2 * var_136_5 * Mathf.Tan(var_136_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_136_8 = var_136_7 * var_136_6.aspect
					local var_136_9 = var_136_4.sprite.bounds.size.x
					local var_136_10 = var_136_4.sprite.bounds.size.y
					local var_136_11 = var_136_8 / var_136_9
					local var_136_12 = var_136_7 / var_136_10
					local var_136_13 = var_136_12 < var_136_11 and var_136_11 or var_136_12

					var_136_3.transform.localScale = Vector3.New(var_136_13, var_136_13, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "ST12" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_136_14 = 0

			if var_136_14 < arg_133_1.time_ and arg_133_1.time_ <= var_136_14 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_15 = 2

			if var_136_14 <= arg_133_1.time_ and arg_133_1.time_ < var_136_14 + var_136_15 then
				local var_136_16 = (arg_133_1.time_ - var_136_14) / var_136_15
				local var_136_17 = Color.New(0, 0, 0)

				var_136_17.a = Mathf.Lerp(0, 1, var_136_16)
				arg_133_1.mask_.color = var_136_17
			end

			if arg_133_1.time_ >= var_136_14 + var_136_15 and arg_133_1.time_ < var_136_14 + var_136_15 + arg_136_0 then
				local var_136_18 = Color.New(0, 0, 0)

				var_136_18.a = 1
				arg_133_1.mask_.color = var_136_18
			end

			local var_136_19 = 2

			if var_136_19 < arg_133_1.time_ and arg_133_1.time_ <= var_136_19 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_20 = 2

			if var_136_19 <= arg_133_1.time_ and arg_133_1.time_ < var_136_19 + var_136_20 then
				local var_136_21 = (arg_133_1.time_ - var_136_19) / var_136_20
				local var_136_22 = Color.New(0, 0, 0)

				var_136_22.a = Mathf.Lerp(1, 0, var_136_21)
				arg_133_1.mask_.color = var_136_22
			end

			if arg_133_1.time_ >= var_136_19 + var_136_20 and arg_133_1.time_ < var_136_19 + var_136_20 + arg_136_0 then
				local var_136_23 = Color.New(0, 0, 0)
				local var_136_24 = 0

				arg_133_1.mask_.enabled = false
				var_136_23.a = var_136_24
				arg_133_1.mask_.color = var_136_23
			end

			local var_136_25 = arg_133_1.actors_["1097ui_story"].transform
			local var_136_26 = 3.8

			if var_136_26 < arg_133_1.time_ and arg_133_1.time_ <= var_136_26 + arg_136_0 then
				arg_133_1.var_.moveOldPos1097ui_story = var_136_25.localPosition
			end

			local var_136_27 = 0.001

			if var_136_26 <= arg_133_1.time_ and arg_133_1.time_ < var_136_26 + var_136_27 then
				local var_136_28 = (arg_133_1.time_ - var_136_26) / var_136_27
				local var_136_29 = Vector3.New(0, -0.54, -6.3)

				var_136_25.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1097ui_story, var_136_29, var_136_28)

				local var_136_30 = manager.ui.mainCamera.transform.position - var_136_25.position

				var_136_25.forward = Vector3.New(var_136_30.x, var_136_30.y, var_136_30.z)

				local var_136_31 = var_136_25.localEulerAngles

				var_136_31.z = 0
				var_136_31.x = 0
				var_136_25.localEulerAngles = var_136_31
			end

			if arg_133_1.time_ >= var_136_26 + var_136_27 and arg_133_1.time_ < var_136_26 + var_136_27 + arg_136_0 then
				var_136_25.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_136_32 = manager.ui.mainCamera.transform.position - var_136_25.position

				var_136_25.forward = Vector3.New(var_136_32.x, var_136_32.y, var_136_32.z)

				local var_136_33 = var_136_25.localEulerAngles

				var_136_33.z = 0
				var_136_33.x = 0
				var_136_25.localEulerAngles = var_136_33
			end

			local var_136_34 = arg_133_1.actors_["1097ui_story"]
			local var_136_35 = 3.8

			if var_136_35 < arg_133_1.time_ and arg_133_1.time_ <= var_136_35 + arg_136_0 and not isNil(var_136_34) and arg_133_1.var_.characterEffect1097ui_story == nil then
				arg_133_1.var_.characterEffect1097ui_story = var_136_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_36 = 0.200000002980232

			if var_136_35 <= arg_133_1.time_ and arg_133_1.time_ < var_136_35 + var_136_36 and not isNil(var_136_34) then
				local var_136_37 = (arg_133_1.time_ - var_136_35) / var_136_36

				if arg_133_1.var_.characterEffect1097ui_story and not isNil(var_136_34) then
					arg_133_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_35 + var_136_36 and arg_133_1.time_ < var_136_35 + var_136_36 + arg_136_0 and not isNil(var_136_34) and arg_133_1.var_.characterEffect1097ui_story then
				arg_133_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_136_38 = 3.8

			if var_136_38 < arg_133_1.time_ and arg_133_1.time_ <= var_136_38 + arg_136_0 then
				arg_133_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_136_39 = 3.8

			if var_136_39 < arg_133_1.time_ and arg_133_1.time_ <= var_136_39 + arg_136_0 then
				arg_133_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_40 = arg_133_1.actors_["1097ui_story"].transform
			local var_136_41 = 1.96599999815226

			if var_136_41 < arg_133_1.time_ and arg_133_1.time_ <= var_136_41 + arg_136_0 then
				arg_133_1.var_.moveOldPos1097ui_story = var_136_40.localPosition
			end

			local var_136_42 = 0.001

			if var_136_41 <= arg_133_1.time_ and arg_133_1.time_ < var_136_41 + var_136_42 then
				local var_136_43 = (arg_133_1.time_ - var_136_41) / var_136_42
				local var_136_44 = Vector3.New(0, 100, 0)

				var_136_40.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1097ui_story, var_136_44, var_136_43)

				local var_136_45 = manager.ui.mainCamera.transform.position - var_136_40.position

				var_136_40.forward = Vector3.New(var_136_45.x, var_136_45.y, var_136_45.z)

				local var_136_46 = var_136_40.localEulerAngles

				var_136_46.z = 0
				var_136_46.x = 0
				var_136_40.localEulerAngles = var_136_46
			end

			if arg_133_1.time_ >= var_136_41 + var_136_42 and arg_133_1.time_ < var_136_41 + var_136_42 + arg_136_0 then
				var_136_40.localPosition = Vector3.New(0, 100, 0)

				local var_136_47 = manager.ui.mainCamera.transform.position - var_136_40.position

				var_136_40.forward = Vector3.New(var_136_47.x, var_136_47.y, var_136_47.z)

				local var_136_48 = var_136_40.localEulerAngles

				var_136_48.z = 0
				var_136_48.x = 0
				var_136_40.localEulerAngles = var_136_48
			end

			local var_136_49 = arg_133_1.actors_["1042ui_story"].transform
			local var_136_50 = 1.96599999815226

			if var_136_50 < arg_133_1.time_ and arg_133_1.time_ <= var_136_50 + arg_136_0 then
				arg_133_1.var_.moveOldPos1042ui_story = var_136_49.localPosition
			end

			local var_136_51 = 0.001

			if var_136_50 <= arg_133_1.time_ and arg_133_1.time_ < var_136_50 + var_136_51 then
				local var_136_52 = (arg_133_1.time_ - var_136_50) / var_136_51
				local var_136_53 = Vector3.New(0, 100, 0)

				var_136_49.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1042ui_story, var_136_53, var_136_52)

				local var_136_54 = manager.ui.mainCamera.transform.position - var_136_49.position

				var_136_49.forward = Vector3.New(var_136_54.x, var_136_54.y, var_136_54.z)

				local var_136_55 = var_136_49.localEulerAngles

				var_136_55.z = 0
				var_136_55.x = 0
				var_136_49.localEulerAngles = var_136_55
			end

			if arg_133_1.time_ >= var_136_50 + var_136_51 and arg_133_1.time_ < var_136_50 + var_136_51 + arg_136_0 then
				var_136_49.localPosition = Vector3.New(0, 100, 0)

				local var_136_56 = manager.ui.mainCamera.transform.position - var_136_49.position

				var_136_49.forward = Vector3.New(var_136_56.x, var_136_56.y, var_136_56.z)

				local var_136_57 = var_136_49.localEulerAngles

				var_136_57.z = 0
				var_136_57.x = 0
				var_136_49.localEulerAngles = var_136_57
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_58 = 3.999999999999
			local var_136_59 = 0.275

			if var_136_58 < arg_133_1.time_ and arg_133_1.time_ <= var_136_58 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_60 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_60:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_61 = arg_133_1:FormatText(StoryNameCfg[216].name)

				arg_133_1.leftNameTxt_.text = var_136_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_62 = arg_133_1:GetWordFromCfg(1109703032)
				local var_136_63 = arg_133_1:FormatText(var_136_62.content)

				arg_133_1.text_.text = var_136_63

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_64 = 11
				local var_136_65 = utf8.len(var_136_63)
				local var_136_66 = var_136_64 <= 0 and var_136_59 or var_136_59 * (var_136_65 / var_136_64)

				if var_136_66 > 0 and var_136_59 < var_136_66 then
					arg_133_1.talkMaxDuration = var_136_66
					var_136_58 = var_136_58 + 0.3

					if var_136_66 + var_136_58 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_66 + var_136_58
					end
				end

				arg_133_1.text_.text = var_136_63
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703032", "story_v_side_new_1109703.awb") ~= 0 then
					local var_136_67 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703032", "story_v_side_new_1109703.awb") / 1000

					if var_136_67 + var_136_58 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_67 + var_136_58
					end

					if var_136_62.prefab_name ~= "" and arg_133_1.actors_[var_136_62.prefab_name] ~= nil then
						local var_136_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_62.prefab_name].transform, "story_v_side_new_1109703", "1109703032", "story_v_side_new_1109703.awb")

						arg_133_1:RecordAudio("1109703032", var_136_68)
						arg_133_1:RecordAudio("1109703032", var_136_68)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703032", "story_v_side_new_1109703.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703032", "story_v_side_new_1109703.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_69 = var_136_58 + 0.3
			local var_136_70 = math.max(var_136_59, arg_133_1.talkMaxDuration)

			if var_136_69 <= arg_133_1.time_ and arg_133_1.time_ < var_136_69 + var_136_70 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_69) / var_136_70

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_69 + var_136_70 and arg_133_1.time_ < var_136_69 + var_136_70 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play1109703033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1109703033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1109703034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1097ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1097ui_story == nil then
				arg_139_1.var_.characterEffect1097ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1097ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1097ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1097ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1097ui_story.fillRatio = var_142_5
			end

			local var_142_6 = 0
			local var_142_7 = 0.7

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

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_9 = arg_139_1:GetWordFromCfg(1109703033)
				local var_142_10 = arg_139_1:FormatText(var_142_9.content)

				arg_139_1.text_.text = var_142_10

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 28
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
	Play1109703034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1109703034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1109703035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.65

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_2 = arg_143_1:GetWordFromCfg(1109703034)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 26
				local var_146_5 = utf8.len(var_146_3)
				local var_146_6 = var_146_4 <= 0 and var_146_1 or var_146_1 * (var_146_5 / var_146_4)

				if var_146_6 > 0 and var_146_1 < var_146_6 then
					arg_143_1.talkMaxDuration = var_146_6

					if var_146_6 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_7 and arg_143_1.time_ < var_146_0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1109703035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1109703035
		arg_147_1.duration_ = 6.2

		local var_147_0 = {
			zh = 4.066,
			ja = 6.2
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
				arg_147_0:Play1109703036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1097ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1097ui_story == nil then
				arg_147_1.var_.characterEffect1097ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect1097ui_story and not isNil(var_150_0) then
					arg_147_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1097ui_story then
				arg_147_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_150_4 = 0

			if var_150_4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_150_5 = 0

			if var_150_5 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_150_6 = 0
			local var_150_7 = 0.4

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_8 = arg_147_1:FormatText(StoryNameCfg[216].name)

				arg_147_1.leftNameTxt_.text = var_150_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_9 = arg_147_1:GetWordFromCfg(1109703035)
				local var_150_10 = arg_147_1:FormatText(var_150_9.content)

				arg_147_1.text_.text = var_150_10

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_11 = 16
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703035", "story_v_side_new_1109703.awb") ~= 0 then
					local var_150_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703035", "story_v_side_new_1109703.awb") / 1000

					if var_150_14 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_14 + var_150_6
					end

					if var_150_9.prefab_name ~= "" and arg_147_1.actors_[var_150_9.prefab_name] ~= nil then
						local var_150_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_9.prefab_name].transform, "story_v_side_new_1109703", "1109703035", "story_v_side_new_1109703.awb")

						arg_147_1:RecordAudio("1109703035", var_150_15)
						arg_147_1:RecordAudio("1109703035", var_150_15)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703035", "story_v_side_new_1109703.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703035", "story_v_side_new_1109703.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_16 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_16 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_16

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_16 and arg_147_1.time_ < var_150_6 + var_150_16 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1109703036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1109703036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1109703037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1097ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1097ui_story == nil then
				arg_151_1.var_.characterEffect1097ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1097ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1097ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1097ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1097ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.45

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

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_9 = arg_151_1:GetWordFromCfg(1109703036)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 18
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
	Play1109703037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1109703037
		arg_155_1.duration_ = 6.9

		local var_155_0 = {
			zh = 4.466,
			ja = 6.9
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
				arg_155_0:Play1109703038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1097ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1097ui_story == nil then
				arg_155_1.var_.characterEffect1097ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1097ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1097ui_story then
				arg_155_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_158_4 = 0

			if var_158_4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_158_5 = 0

			if var_158_5 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_158_6 = 0
			local var_158_7 = 0.5

			if var_158_6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_8 = arg_155_1:FormatText(StoryNameCfg[216].name)

				arg_155_1.leftNameTxt_.text = var_158_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_9 = arg_155_1:GetWordFromCfg(1109703037)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 20
				local var_158_12 = utf8.len(var_158_10)
				local var_158_13 = var_158_11 <= 0 and var_158_7 or var_158_7 * (var_158_12 / var_158_11)

				if var_158_13 > 0 and var_158_7 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_10
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703037", "story_v_side_new_1109703.awb") ~= 0 then
					local var_158_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703037", "story_v_side_new_1109703.awb") / 1000

					if var_158_14 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_14 + var_158_6
					end

					if var_158_9.prefab_name ~= "" and arg_155_1.actors_[var_158_9.prefab_name] ~= nil then
						local var_158_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_9.prefab_name].transform, "story_v_side_new_1109703", "1109703037", "story_v_side_new_1109703.awb")

						arg_155_1:RecordAudio("1109703037", var_158_15)
						arg_155_1:RecordAudio("1109703037", var_158_15)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703037", "story_v_side_new_1109703.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703037", "story_v_side_new_1109703.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_16 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_16 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_16

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_16 and arg_155_1.time_ < var_158_6 + var_158_16 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1109703038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1109703038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1109703039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1097ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1097ui_story == nil then
				arg_159_1.var_.characterEffect1097ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect1097ui_story and not isNil(var_162_0) then
					local var_162_4 = Mathf.Lerp(0, 0.5, var_162_3)

					arg_159_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1097ui_story.fillRatio = var_162_4
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1097ui_story then
				local var_162_5 = 0.5

				arg_159_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1097ui_story.fillRatio = var_162_5
			end

			local var_162_6 = 0
			local var_162_7 = 0.475

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

				local var_162_9 = arg_159_1:GetWordFromCfg(1109703038)
				local var_162_10 = arg_159_1:FormatText(var_162_9.content)

				arg_159_1.text_.text = var_162_10

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 19
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
	Play1109703039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1109703039
		arg_163_1.duration_ = 6.47

		local var_163_0 = {
			zh = 3.033,
			ja = 6.466
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
				arg_163_0:Play1109703040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1097ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1097ui_story == nil then
				arg_163_1.var_.characterEffect1097ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1097ui_story and not isNil(var_166_0) then
					arg_163_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1097ui_story then
				arg_163_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_166_4 = 0

			if var_166_4 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_166_5 = 0

			if var_166_5 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_166_6 = 0
			local var_166_7 = 0.55

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_8 = arg_163_1:FormatText(StoryNameCfg[216].name)

				arg_163_1.leftNameTxt_.text = var_166_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_9 = arg_163_1:GetWordFromCfg(1109703039)
				local var_166_10 = arg_163_1:FormatText(var_166_9.content)

				arg_163_1.text_.text = var_166_10

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 22
				local var_166_12 = utf8.len(var_166_10)
				local var_166_13 = var_166_11 <= 0 and var_166_7 or var_166_7 * (var_166_12 / var_166_11)

				if var_166_13 > 0 and var_166_7 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_10
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703039", "story_v_side_new_1109703.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703039", "story_v_side_new_1109703.awb") / 1000

					if var_166_14 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_6
					end

					if var_166_9.prefab_name ~= "" and arg_163_1.actors_[var_166_9.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_9.prefab_name].transform, "story_v_side_new_1109703", "1109703039", "story_v_side_new_1109703.awb")

						arg_163_1:RecordAudio("1109703039", var_166_15)
						arg_163_1:RecordAudio("1109703039", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703039", "story_v_side_new_1109703.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703039", "story_v_side_new_1109703.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_16 and arg_163_1.time_ < var_166_6 + var_166_16 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1109703040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1109703040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1109703041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1097ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1097ui_story == nil then
				arg_167_1.var_.characterEffect1097ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect1097ui_story and not isNil(var_170_0) then
					local var_170_4 = Mathf.Lerp(0, 0.5, var_170_3)

					arg_167_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1097ui_story.fillRatio = var_170_4
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1097ui_story then
				local var_170_5 = 0.5

				arg_167_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1097ui_story.fillRatio = var_170_5
			end

			local var_170_6 = 0
			local var_170_7 = 0.5

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_8 = arg_167_1:FormatText(StoryNameCfg[7].name)

				arg_167_1.leftNameTxt_.text = var_170_8

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

				local var_170_9 = arg_167_1:GetWordFromCfg(1109703040)
				local var_170_10 = arg_167_1:FormatText(var_170_9.content)

				arg_167_1.text_.text = var_170_10

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 20
				local var_170_12 = utf8.len(var_170_10)
				local var_170_13 = var_170_11 <= 0 and var_170_7 or var_170_7 * (var_170_12 / var_170_11)

				if var_170_13 > 0 and var_170_7 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_10
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_14 and arg_167_1.time_ < var_170_6 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1109703041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1109703041
		arg_171_1.duration_ = 6.13

		local var_171_0 = {
			zh = 4,
			ja = 6.133
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
				arg_171_0:Play1109703042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1097ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1097ui_story == nil then
				arg_171_1.var_.characterEffect1097ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect1097ui_story and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1097ui_story then
				arg_171_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_174_4 = 0

			if var_174_4 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_1")
			end

			local var_174_5 = 0

			if var_174_5 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_174_6 = 0
			local var_174_7 = 0.625

			if var_174_6 < arg_171_1.time_ and arg_171_1.time_ <= var_174_6 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_8 = arg_171_1:FormatText(StoryNameCfg[216].name)

				arg_171_1.leftNameTxt_.text = var_174_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_9 = arg_171_1:GetWordFromCfg(1109703041)
				local var_174_10 = arg_171_1:FormatText(var_174_9.content)

				arg_171_1.text_.text = var_174_10

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_11 = 25
				local var_174_12 = utf8.len(var_174_10)
				local var_174_13 = var_174_11 <= 0 and var_174_7 or var_174_7 * (var_174_12 / var_174_11)

				if var_174_13 > 0 and var_174_7 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_6
					end
				end

				arg_171_1.text_.text = var_174_10
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703041", "story_v_side_new_1109703.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703041", "story_v_side_new_1109703.awb") / 1000

					if var_174_14 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_6
					end

					if var_174_9.prefab_name ~= "" and arg_171_1.actors_[var_174_9.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_9.prefab_name].transform, "story_v_side_new_1109703", "1109703041", "story_v_side_new_1109703.awb")

						arg_171_1:RecordAudio("1109703041", var_174_15)
						arg_171_1:RecordAudio("1109703041", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703041", "story_v_side_new_1109703.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703041", "story_v_side_new_1109703.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_16 = math.max(var_174_7, arg_171_1.talkMaxDuration)

			if var_174_6 <= arg_171_1.time_ and arg_171_1.time_ < var_174_6 + var_174_16 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_6) / var_174_16

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_6 + var_174_16 and arg_171_1.time_ < var_174_6 + var_174_16 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1109703042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1109703042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1109703043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1097ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1097ui_story == nil then
				arg_175_1.var_.characterEffect1097ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1097ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1097ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1097ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1097ui_story.fillRatio = var_178_5
			end

			local var_178_6 = 0
			local var_178_7 = 0.45

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

				local var_178_9 = arg_175_1:GetWordFromCfg(1109703042)
				local var_178_10 = arg_175_1:FormatText(var_178_9.content)

				arg_175_1.text_.text = var_178_10

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 18
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
	Play1109703043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1109703043
		arg_179_1.duration_ = 4.6

		local var_179_0 = {
			zh = 2.3,
			ja = 4.6
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1109703044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1097ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1097ui_story == nil then
				arg_179_1.var_.characterEffect1097ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect1097ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1097ui_story then
				arg_179_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_182_4 = 0

			if var_182_4 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_2")
			end

			local var_182_5 = 0

			if var_182_5 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_182_6 = 0
			local var_182_7 = 0.2

			if var_182_6 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_8 = arg_179_1:FormatText(StoryNameCfg[216].name)

				arg_179_1.leftNameTxt_.text = var_182_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_9 = arg_179_1:GetWordFromCfg(1109703043)
				local var_182_10 = arg_179_1:FormatText(var_182_9.content)

				arg_179_1.text_.text = var_182_10

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 8
				local var_182_12 = utf8.len(var_182_10)
				local var_182_13 = var_182_11 <= 0 and var_182_7 or var_182_7 * (var_182_12 / var_182_11)

				if var_182_13 > 0 and var_182_7 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_10
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703043", "story_v_side_new_1109703.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703043", "story_v_side_new_1109703.awb") / 1000

					if var_182_14 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_6
					end

					if var_182_9.prefab_name ~= "" and arg_179_1.actors_[var_182_9.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_9.prefab_name].transform, "story_v_side_new_1109703", "1109703043", "story_v_side_new_1109703.awb")

						arg_179_1:RecordAudio("1109703043", var_182_15)
						arg_179_1:RecordAudio("1109703043", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703043", "story_v_side_new_1109703.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703043", "story_v_side_new_1109703.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_16 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_16 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_16

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_16 and arg_179_1.time_ < var_182_6 + var_182_16 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1109703044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1109703044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1109703045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1097ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1097ui_story == nil then
				arg_183_1.var_.characterEffect1097ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1097ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1097ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1097ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1097ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0
			local var_186_7 = 0.775

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_8 = arg_183_1:FormatText(StoryNameCfg[7].name)

				arg_183_1.leftNameTxt_.text = var_186_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_9 = arg_183_1:GetWordFromCfg(1109703044)
				local var_186_10 = arg_183_1:FormatText(var_186_9.content)

				arg_183_1.text_.text = var_186_10

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 31
				local var_186_12 = utf8.len(var_186_10)
				local var_186_13 = var_186_11 <= 0 and var_186_7 or var_186_7 * (var_186_12 / var_186_11)

				if var_186_13 > 0 and var_186_7 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_10
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_14 and arg_183_1.time_ < var_186_6 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1109703045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1109703045
		arg_187_1.duration_ = 8.97

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1109703046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 1.96599999815226

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				local var_190_1 = manager.ui.mainCamera.transform.localPosition
				local var_190_2 = Vector3.New(0, 0, 10) + Vector3.New(var_190_1.x, var_190_1.y, 0)
				local var_190_3 = arg_187_1.bgs_.ST12

				var_190_3.transform.localPosition = var_190_2
				var_190_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_190_4 = var_190_3:GetComponent("SpriteRenderer")

				if var_190_4 and var_190_4.sprite then
					local var_190_5 = (var_190_3.transform.localPosition - var_190_1).z
					local var_190_6 = manager.ui.mainCameraCom_
					local var_190_7 = 2 * var_190_5 * Mathf.Tan(var_190_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_190_8 = var_190_7 * var_190_6.aspect
					local var_190_9 = var_190_4.sprite.bounds.size.x
					local var_190_10 = var_190_4.sprite.bounds.size.y
					local var_190_11 = var_190_8 / var_190_9
					local var_190_12 = var_190_7 / var_190_10
					local var_190_13 = var_190_12 < var_190_11 and var_190_11 or var_190_12

					var_190_3.transform.localScale = Vector3.New(var_190_13, var_190_13, 0)
				end

				for iter_190_0, iter_190_1 in pairs(arg_187_1.bgs_) do
					if iter_190_0 ~= "ST12" then
						iter_190_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_190_14 = 3.999999999999

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			local var_190_15 = 0.3

			if arg_187_1.time_ >= var_190_14 + var_190_15 and arg_187_1.time_ < var_190_14 + var_190_15 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			local var_190_16 = 0

			if var_190_16 < arg_187_1.time_ and arg_187_1.time_ <= var_190_16 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_17 = 2

			if var_190_16 <= arg_187_1.time_ and arg_187_1.time_ < var_190_16 + var_190_17 then
				local var_190_18 = (arg_187_1.time_ - var_190_16) / var_190_17
				local var_190_19 = Color.New(1, 1, 1)

				var_190_19.a = Mathf.Lerp(0, 1, var_190_18)
				arg_187_1.mask_.color = var_190_19
			end

			if arg_187_1.time_ >= var_190_16 + var_190_17 and arg_187_1.time_ < var_190_16 + var_190_17 + arg_190_0 then
				local var_190_20 = Color.New(1, 1, 1)

				var_190_20.a = 1
				arg_187_1.mask_.color = var_190_20
			end

			local var_190_21 = 2

			if var_190_21 < arg_187_1.time_ and arg_187_1.time_ <= var_190_21 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_22 = 2

			if var_190_21 <= arg_187_1.time_ and arg_187_1.time_ < var_190_21 + var_190_22 then
				local var_190_23 = (arg_187_1.time_ - var_190_21) / var_190_22
				local var_190_24 = Color.New(1, 1, 1)

				var_190_24.a = Mathf.Lerp(1, 0, var_190_23)
				arg_187_1.mask_.color = var_190_24
			end

			if arg_187_1.time_ >= var_190_21 + var_190_22 and arg_187_1.time_ < var_190_21 + var_190_22 + arg_190_0 then
				local var_190_25 = Color.New(1, 1, 1)
				local var_190_26 = 0

				arg_187_1.mask_.enabled = false
				var_190_25.a = var_190_26
				arg_187_1.mask_.color = var_190_25
			end

			local var_190_27 = arg_187_1.actors_["1097ui_story"].transform
			local var_190_28 = 1.96599999815226

			if var_190_28 < arg_187_1.time_ and arg_187_1.time_ <= var_190_28 + arg_190_0 then
				arg_187_1.var_.moveOldPos1097ui_story = var_190_27.localPosition
			end

			local var_190_29 = 0.001

			if var_190_28 <= arg_187_1.time_ and arg_187_1.time_ < var_190_28 + var_190_29 then
				local var_190_30 = (arg_187_1.time_ - var_190_28) / var_190_29
				local var_190_31 = Vector3.New(0, 100, 0)

				var_190_27.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1097ui_story, var_190_31, var_190_30)

				local var_190_32 = manager.ui.mainCamera.transform.position - var_190_27.position

				var_190_27.forward = Vector3.New(var_190_32.x, var_190_32.y, var_190_32.z)

				local var_190_33 = var_190_27.localEulerAngles

				var_190_33.z = 0
				var_190_33.x = 0
				var_190_27.localEulerAngles = var_190_33
			end

			if arg_187_1.time_ >= var_190_28 + var_190_29 and arg_187_1.time_ < var_190_28 + var_190_29 + arg_190_0 then
				var_190_27.localPosition = Vector3.New(0, 100, 0)

				local var_190_34 = manager.ui.mainCamera.transform.position - var_190_27.position

				var_190_27.forward = Vector3.New(var_190_34.x, var_190_34.y, var_190_34.z)

				local var_190_35 = var_190_27.localEulerAngles

				var_190_35.z = 0
				var_190_35.x = 0
				var_190_27.localEulerAngles = var_190_35
			end

			local var_190_36 = arg_187_1.actors_["1097ui_story"]
			local var_190_37 = 1.96599999815226

			if var_190_37 < arg_187_1.time_ and arg_187_1.time_ <= var_190_37 + arg_190_0 and not isNil(var_190_36) and arg_187_1.var_.characterEffect1097ui_story == nil then
				arg_187_1.var_.characterEffect1097ui_story = var_190_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_38 = 0.034000001847744

			if var_190_37 <= arg_187_1.time_ and arg_187_1.time_ < var_190_37 + var_190_38 and not isNil(var_190_36) then
				local var_190_39 = (arg_187_1.time_ - var_190_37) / var_190_38

				if arg_187_1.var_.characterEffect1097ui_story and not isNil(var_190_36) then
					local var_190_40 = Mathf.Lerp(0, 0.5, var_190_39)

					arg_187_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1097ui_story.fillRatio = var_190_40
				end
			end

			if arg_187_1.time_ >= var_190_37 + var_190_38 and arg_187_1.time_ < var_190_37 + var_190_38 + arg_190_0 and not isNil(var_190_36) and arg_187_1.var_.characterEffect1097ui_story then
				local var_190_41 = 0.5

				arg_187_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1097ui_story.fillRatio = var_190_41
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_42 = 3.96599999815226
			local var_190_43 = 0.575

			if var_190_42 < arg_187_1.time_ and arg_187_1.time_ <= var_190_42 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_44 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_44:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_45 = arg_187_1:FormatText(StoryNameCfg[7].name)

				arg_187_1.leftNameTxt_.text = var_190_45

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

				local var_190_46 = arg_187_1:GetWordFromCfg(1109703045)
				local var_190_47 = arg_187_1:FormatText(var_190_46.content)

				arg_187_1.text_.text = var_190_47

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_48 = 23
				local var_190_49 = utf8.len(var_190_47)
				local var_190_50 = var_190_48 <= 0 and var_190_43 or var_190_43 * (var_190_49 / var_190_48)

				if var_190_50 > 0 and var_190_43 < var_190_50 then
					arg_187_1.talkMaxDuration = var_190_50
					var_190_42 = var_190_42 + 0.3

					if var_190_50 + var_190_42 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_50 + var_190_42
					end
				end

				arg_187_1.text_.text = var_190_47
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_51 = var_190_42 + 0.3
			local var_190_52 = math.max(var_190_43, arg_187_1.talkMaxDuration)

			if var_190_51 <= arg_187_1.time_ and arg_187_1.time_ < var_190_51 + var_190_52 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_51) / var_190_52

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_51 + var_190_52 and arg_187_1.time_ < var_190_51 + var_190_52 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play1109703046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1109703046
		arg_193_1.duration_ = 6.2

		local var_193_0 = {
			zh = 3.7,
			ja = 6.2
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1109703047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1097ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1097ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(0, -0.54, -6.3)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1097ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["1097ui_story"]
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1097ui_story == nil then
				arg_193_1.var_.characterEffect1097ui_story = var_196_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_11 = 0.200000002980232

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 and not isNil(var_196_9) then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11

				if arg_193_1.var_.characterEffect1097ui_story and not isNil(var_196_9) then
					arg_193_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1097ui_story then
				arg_193_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_196_13 = 0

			if var_196_13 < arg_193_1.time_ and arg_193_1.time_ <= var_196_13 + arg_196_0 then
				arg_193_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_196_14 = 0

			if var_196_14 < arg_193_1.time_ and arg_193_1.time_ <= var_196_14 + arg_196_0 then
				arg_193_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_196_15 = 0
			local var_196_16 = 0.4

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_17 = arg_193_1:FormatText(StoryNameCfg[216].name)

				arg_193_1.leftNameTxt_.text = var_196_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_18 = arg_193_1:GetWordFromCfg(1109703046)
				local var_196_19 = arg_193_1:FormatText(var_196_18.content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_20 = 16
				local var_196_21 = utf8.len(var_196_19)
				local var_196_22 = var_196_20 <= 0 and var_196_16 or var_196_16 * (var_196_21 / var_196_20)

				if var_196_22 > 0 and var_196_16 < var_196_22 then
					arg_193_1.talkMaxDuration = var_196_22

					if var_196_22 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_22 + var_196_15
					end
				end

				arg_193_1.text_.text = var_196_19
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703046", "story_v_side_new_1109703.awb") ~= 0 then
					local var_196_23 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703046", "story_v_side_new_1109703.awb") / 1000

					if var_196_23 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_15
					end

					if var_196_18.prefab_name ~= "" and arg_193_1.actors_[var_196_18.prefab_name] ~= nil then
						local var_196_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_18.prefab_name].transform, "story_v_side_new_1109703", "1109703046", "story_v_side_new_1109703.awb")

						arg_193_1:RecordAudio("1109703046", var_196_24)
						arg_193_1:RecordAudio("1109703046", var_196_24)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703046", "story_v_side_new_1109703.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703046", "story_v_side_new_1109703.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_25 = math.max(var_196_16, arg_193_1.talkMaxDuration)

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_25 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_15) / var_196_25

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_15 + var_196_25 and arg_193_1.time_ < var_196_15 + var_196_25 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play1109703047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1109703047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1109703048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1097ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1097ui_story == nil then
				arg_197_1.var_.characterEffect1097ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1097ui_story and not isNil(var_200_0) then
					local var_200_4 = Mathf.Lerp(0, 0.5, var_200_3)

					arg_197_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1097ui_story.fillRatio = var_200_4
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1097ui_story then
				local var_200_5 = 0.5

				arg_197_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1097ui_story.fillRatio = var_200_5
			end

			local var_200_6 = 0
			local var_200_7 = 0.125

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_8 = arg_197_1:FormatText(StoryNameCfg[7].name)

				arg_197_1.leftNameTxt_.text = var_200_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_9 = arg_197_1:GetWordFromCfg(1109703047)
				local var_200_10 = arg_197_1:FormatText(var_200_9.content)

				arg_197_1.text_.text = var_200_10

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 5
				local var_200_12 = utf8.len(var_200_10)
				local var_200_13 = var_200_11 <= 0 and var_200_7 or var_200_7 * (var_200_12 / var_200_11)

				if var_200_13 > 0 and var_200_7 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_10
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_14 and arg_197_1.time_ < var_200_6 + var_200_14 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1109703048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1109703048
		arg_201_1.duration_ = 13.33

		local var_201_0 = {
			zh = 9.466,
			ja = 13.333
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1109703049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1097ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1097ui_story == nil then
				arg_201_1.var_.characterEffect1097ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1097ui_story and not isNil(var_204_0) then
					arg_201_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1097ui_story then
				arg_201_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_204_4 = 0

			if var_204_4 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_204_5 = 0

			if var_204_5 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_204_6 = 0
			local var_204_7 = 0.85

			if var_204_6 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_8 = arg_201_1:FormatText(StoryNameCfg[216].name)

				arg_201_1.leftNameTxt_.text = var_204_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_9 = arg_201_1:GetWordFromCfg(1109703048)
				local var_204_10 = arg_201_1:FormatText(var_204_9.content)

				arg_201_1.text_.text = var_204_10

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 34
				local var_204_12 = utf8.len(var_204_10)
				local var_204_13 = var_204_11 <= 0 and var_204_7 or var_204_7 * (var_204_12 / var_204_11)

				if var_204_13 > 0 and var_204_7 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_10
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703048", "story_v_side_new_1109703.awb") ~= 0 then
					local var_204_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703048", "story_v_side_new_1109703.awb") / 1000

					if var_204_14 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_6
					end

					if var_204_9.prefab_name ~= "" and arg_201_1.actors_[var_204_9.prefab_name] ~= nil then
						local var_204_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_9.prefab_name].transform, "story_v_side_new_1109703", "1109703048", "story_v_side_new_1109703.awb")

						arg_201_1:RecordAudio("1109703048", var_204_15)
						arg_201_1:RecordAudio("1109703048", var_204_15)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703048", "story_v_side_new_1109703.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703048", "story_v_side_new_1109703.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_16 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_16 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_16

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_16 and arg_201_1.time_ < var_204_6 + var_204_16 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1109703049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1109703049
		arg_205_1.duration_ = 11.77

		local var_205_0 = {
			zh = 11.766,
			ja = 11.466
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1109703050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1097ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1097ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(0, -0.54, -6.3)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1097ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = arg_205_1.actors_["1097ui_story"]
			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect1097ui_story == nil then
				arg_205_1.var_.characterEffect1097ui_story = var_208_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_11 = 0.200000002980232

			if var_208_10 <= arg_205_1.time_ and arg_205_1.time_ < var_208_10 + var_208_11 and not isNil(var_208_9) then
				local var_208_12 = (arg_205_1.time_ - var_208_10) / var_208_11

				if arg_205_1.var_.characterEffect1097ui_story and not isNil(var_208_9) then
					arg_205_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_10 + var_208_11 and arg_205_1.time_ < var_208_10 + var_208_11 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect1097ui_story then
				arg_205_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_208_13 = 0

			if var_208_13 < arg_205_1.time_ and arg_205_1.time_ <= var_208_13 + arg_208_0 then
				arg_205_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097actionlink/1097action476")
			end

			local var_208_14 = 0

			if var_208_14 < arg_205_1.time_ and arg_205_1.time_ <= var_208_14 + arg_208_0 then
				arg_205_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_208_15 = 0
			local var_208_16 = 0.95

			if var_208_15 < arg_205_1.time_ and arg_205_1.time_ <= var_208_15 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_17 = arg_205_1:FormatText(StoryNameCfg[216].name)

				arg_205_1.leftNameTxt_.text = var_208_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_18 = arg_205_1:GetWordFromCfg(1109703049)
				local var_208_19 = arg_205_1:FormatText(var_208_18.content)

				arg_205_1.text_.text = var_208_19

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_20 = 38
				local var_208_21 = utf8.len(var_208_19)
				local var_208_22 = var_208_20 <= 0 and var_208_16 or var_208_16 * (var_208_21 / var_208_20)

				if var_208_22 > 0 and var_208_16 < var_208_22 then
					arg_205_1.talkMaxDuration = var_208_22

					if var_208_22 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_22 + var_208_15
					end
				end

				arg_205_1.text_.text = var_208_19
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703049", "story_v_side_new_1109703.awb") ~= 0 then
					local var_208_23 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703049", "story_v_side_new_1109703.awb") / 1000

					if var_208_23 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_23 + var_208_15
					end

					if var_208_18.prefab_name ~= "" and arg_205_1.actors_[var_208_18.prefab_name] ~= nil then
						local var_208_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_18.prefab_name].transform, "story_v_side_new_1109703", "1109703049", "story_v_side_new_1109703.awb")

						arg_205_1:RecordAudio("1109703049", var_208_24)
						arg_205_1:RecordAudio("1109703049", var_208_24)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703049", "story_v_side_new_1109703.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703049", "story_v_side_new_1109703.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_25 = math.max(var_208_16, arg_205_1.talkMaxDuration)

			if var_208_15 <= arg_205_1.time_ and arg_205_1.time_ < var_208_15 + var_208_25 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_15) / var_208_25

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_15 + var_208_25 and arg_205_1.time_ < var_208_15 + var_208_25 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play1109703050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1109703050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1109703051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1097ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1097ui_story == nil then
				arg_209_1.var_.characterEffect1097ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1097ui_story and not isNil(var_212_0) then
					local var_212_4 = Mathf.Lerp(0, 0.5, var_212_3)

					arg_209_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1097ui_story.fillRatio = var_212_4
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1097ui_story then
				local var_212_5 = 0.5

				arg_209_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1097ui_story.fillRatio = var_212_5
			end

			local var_212_6 = 0
			local var_212_7 = 0.7

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_8 = arg_209_1:FormatText(StoryNameCfg[7].name)

				arg_209_1.leftNameTxt_.text = var_212_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_9 = arg_209_1:GetWordFromCfg(1109703050)
				local var_212_10 = arg_209_1:FormatText(var_212_9.content)

				arg_209_1.text_.text = var_212_10

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 28
				local var_212_12 = utf8.len(var_212_10)
				local var_212_13 = var_212_11 <= 0 and var_212_7 or var_212_7 * (var_212_12 / var_212_11)

				if var_212_13 > 0 and var_212_7 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_10
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_14 and arg_209_1.time_ < var_212_6 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1109703051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1109703051
		arg_213_1.duration_ = 13.5

		local var_213_0 = {
			zh = 13.5,
			ja = 12.5
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
				arg_213_0:Play1109703052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1097ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1097ui_story == nil then
				arg_213_1.var_.characterEffect1097ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1097ui_story and not isNil(var_216_0) then
					arg_213_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1097ui_story then
				arg_213_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_216_4 = 0

			if var_216_4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			local var_216_5 = 2

			if var_216_5 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action2_1")
			end

			local var_216_6 = 2

			if var_216_6 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_216_7 = 0
			local var_216_8 = 1.425

			if var_216_7 < arg_213_1.time_ and arg_213_1.time_ <= var_216_7 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_9 = arg_213_1:FormatText(StoryNameCfg[216].name)

				arg_213_1.leftNameTxt_.text = var_216_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_10 = arg_213_1:GetWordFromCfg(1109703051)
				local var_216_11 = arg_213_1:FormatText(var_216_10.content)

				arg_213_1.text_.text = var_216_11

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_12 = 57
				local var_216_13 = utf8.len(var_216_11)
				local var_216_14 = var_216_12 <= 0 and var_216_8 or var_216_8 * (var_216_13 / var_216_12)

				if var_216_14 > 0 and var_216_8 < var_216_14 then
					arg_213_1.talkMaxDuration = var_216_14

					if var_216_14 + var_216_7 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_7
					end
				end

				arg_213_1.text_.text = var_216_11
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703051", "story_v_side_new_1109703.awb") ~= 0 then
					local var_216_15 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703051", "story_v_side_new_1109703.awb") / 1000

					if var_216_15 + var_216_7 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_15 + var_216_7
					end

					if var_216_10.prefab_name ~= "" and arg_213_1.actors_[var_216_10.prefab_name] ~= nil then
						local var_216_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_10.prefab_name].transform, "story_v_side_new_1109703", "1109703051", "story_v_side_new_1109703.awb")

						arg_213_1:RecordAudio("1109703051", var_216_16)
						arg_213_1:RecordAudio("1109703051", var_216_16)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703051", "story_v_side_new_1109703.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703051", "story_v_side_new_1109703.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_17 = math.max(var_216_8, arg_213_1.talkMaxDuration)

			if var_216_7 <= arg_213_1.time_ and arg_213_1.time_ < var_216_7 + var_216_17 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_7) / var_216_17

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_7 + var_216_17 and arg_213_1.time_ < var_216_7 + var_216_17 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1109703052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1109703052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1109703053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1097ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1097ui_story == nil then
				arg_217_1.var_.characterEffect1097ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1097ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1097ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1097ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1097ui_story.fillRatio = var_220_5
			end

			local var_220_6 = 0

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_220_7 = 0

			if var_220_7 < arg_217_1.time_ and arg_217_1.time_ <= var_220_7 + arg_220_0 then
				arg_217_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action2_2")
			end

			local var_220_8 = 0
			local var_220_9 = 0.175

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_10 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_10

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

				local var_220_11 = arg_217_1:GetWordFromCfg(1109703052)
				local var_220_12 = arg_217_1:FormatText(var_220_11.content)

				arg_217_1.text_.text = var_220_12

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_13 = 7
				local var_220_14 = utf8.len(var_220_12)
				local var_220_15 = var_220_13 <= 0 and var_220_9 or var_220_9 * (var_220_14 / var_220_13)

				if var_220_15 > 0 and var_220_9 < var_220_15 then
					arg_217_1.talkMaxDuration = var_220_15

					if var_220_15 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_15 + var_220_8
					end
				end

				arg_217_1.text_.text = var_220_12
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_16 = math.max(var_220_9, arg_217_1.talkMaxDuration)

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_16 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_8) / var_220_16

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_8 + var_220_16 and arg_217_1.time_ < var_220_8 + var_220_16 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1109703053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1109703053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1109703054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1097ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1097ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0, 100, 0)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1097ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, 100, 0)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = arg_221_1.actors_["1097ui_story"]
			local var_224_10 = 0

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1097ui_story == nil then
				arg_221_1.var_.characterEffect1097ui_story = var_224_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_11 = 0.034000001847744

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_11 and not isNil(var_224_9) then
				local var_224_12 = (arg_221_1.time_ - var_224_10) / var_224_11

				if arg_221_1.var_.characterEffect1097ui_story and not isNil(var_224_9) then
					local var_224_13 = Mathf.Lerp(0, 0.5, var_224_12)

					arg_221_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1097ui_story.fillRatio = var_224_13
				end
			end

			if arg_221_1.time_ >= var_224_10 + var_224_11 and arg_221_1.time_ < var_224_10 + var_224_11 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1097ui_story then
				local var_224_14 = 0.5

				arg_221_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1097ui_story.fillRatio = var_224_14
			end

			local var_224_15 = 0
			local var_224_16 = 1.025

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_17 = arg_221_1:GetWordFromCfg(1109703053)
				local var_224_18 = arg_221_1:FormatText(var_224_17.content)

				arg_221_1.text_.text = var_224_18

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_19 = 41
				local var_224_20 = utf8.len(var_224_18)
				local var_224_21 = var_224_19 <= 0 and var_224_16 or var_224_16 * (var_224_20 / var_224_19)

				if var_224_21 > 0 and var_224_16 < var_224_21 then
					arg_221_1.talkMaxDuration = var_224_21

					if var_224_21 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_21 + var_224_15
					end
				end

				arg_221_1.text_.text = var_224_18
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_22 = math.max(var_224_16, arg_221_1.talkMaxDuration)

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_22 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_15) / var_224_22

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_15 + var_224_22 and arg_221_1.time_ < var_224_15 + var_224_22 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play1109703054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1109703054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1109703055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.45

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(1109703054)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 18
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_8 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_8 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_8

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_8 and arg_225_1.time_ < var_228_0 + var_228_8 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1109703055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1109703055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1109703056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.475

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[7].name)

				arg_229_1.leftNameTxt_.text = var_232_2

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

				local var_232_3 = arg_229_1:GetWordFromCfg(1109703055)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 19
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_8 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_8 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_8

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_8 and arg_229_1.time_ < var_232_0 + var_232_8 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1109703056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1109703056
		arg_233_1.duration_ = 10.63

		local var_233_0 = {
			zh = 8.7,
			ja = 10.633
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
				arg_233_0:Play1109703057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 1.999999999999

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				local var_236_1 = manager.ui.mainCamera.transform.localPosition
				local var_236_2 = Vector3.New(0, 0, 10) + Vector3.New(var_236_1.x, var_236_1.y, 0)
				local var_236_3 = arg_233_1.bgs_.ST12

				var_236_3.transform.localPosition = var_236_2
				var_236_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_4 = var_236_3:GetComponent("SpriteRenderer")

				if var_236_4 and var_236_4.sprite then
					local var_236_5 = (var_236_3.transform.localPosition - var_236_1).z
					local var_236_6 = manager.ui.mainCameraCom_
					local var_236_7 = 2 * var_236_5 * Mathf.Tan(var_236_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_236_8 = var_236_7 * var_236_6.aspect
					local var_236_9 = var_236_4.sprite.bounds.size.x
					local var_236_10 = var_236_4.sprite.bounds.size.y
					local var_236_11 = var_236_8 / var_236_9
					local var_236_12 = var_236_7 / var_236_10
					local var_236_13 = var_236_12 < var_236_11 and var_236_11 or var_236_12

					var_236_3.transform.localScale = Vector3.New(var_236_13, var_236_13, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "ST12" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_14 = 3.999999999999

			if var_236_14 < arg_233_1.time_ and arg_233_1.time_ <= var_236_14 + arg_236_0 then
				arg_233_1.allBtn_.enabled = false
			end

			local var_236_15 = 0.3

			if arg_233_1.time_ >= var_236_14 + var_236_15 and arg_233_1.time_ < var_236_14 + var_236_15 + arg_236_0 then
				arg_233_1.allBtn_.enabled = true
			end

			local var_236_16 = 0

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_17 = 2

			if var_236_16 <= arg_233_1.time_ and arg_233_1.time_ < var_236_16 + var_236_17 then
				local var_236_18 = (arg_233_1.time_ - var_236_16) / var_236_17
				local var_236_19 = Color.New(1, 1, 1)

				var_236_19.a = Mathf.Lerp(0, 1, var_236_18)
				arg_233_1.mask_.color = var_236_19
			end

			if arg_233_1.time_ >= var_236_16 + var_236_17 and arg_233_1.time_ < var_236_16 + var_236_17 + arg_236_0 then
				local var_236_20 = Color.New(1, 1, 1)

				var_236_20.a = 1
				arg_233_1.mask_.color = var_236_20
			end

			local var_236_21 = 2

			if var_236_21 < arg_233_1.time_ and arg_233_1.time_ <= var_236_21 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_22 = 2

			if var_236_21 <= arg_233_1.time_ and arg_233_1.time_ < var_236_21 + var_236_22 then
				local var_236_23 = (arg_233_1.time_ - var_236_21) / var_236_22
				local var_236_24 = Color.New(1, 1, 1)

				var_236_24.a = Mathf.Lerp(1, 0, var_236_23)
				arg_233_1.mask_.color = var_236_24
			end

			if arg_233_1.time_ >= var_236_21 + var_236_22 and arg_233_1.time_ < var_236_21 + var_236_22 + arg_236_0 then
				local var_236_25 = Color.New(1, 1, 1)
				local var_236_26 = 0

				arg_233_1.mask_.enabled = false
				var_236_25.a = var_236_26
				arg_233_1.mask_.color = var_236_25
			end

			local var_236_27 = "1084ui_story"

			if arg_233_1.actors_[var_236_27] == nil then
				local var_236_28 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_236_28) then
					local var_236_29 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_233_1.stage_.transform)

					var_236_29.name = var_236_27
					var_236_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_233_1.actors_[var_236_27] = var_236_29

					local var_236_30 = var_236_29:GetComponentInChildren(typeof(CharacterEffect))

					var_236_30.enabled = true

					local var_236_31 = GameObjectTools.GetOrAddComponent(var_236_29, typeof(DynamicBoneHelper))

					if var_236_31 then
						var_236_31:EnableDynamicBone(false)
					end

					arg_233_1:ShowWeapon(var_236_30.transform, false)

					arg_233_1.var_[var_236_27 .. "Animator"] = var_236_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_233_1.var_[var_236_27 .. "Animator"].applyRootMotion = true
					arg_233_1.var_[var_236_27 .. "LipSync"] = var_236_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_236_32 = arg_233_1.actors_["1084ui_story"].transform
			local var_236_33 = 3.8

			if var_236_33 < arg_233_1.time_ and arg_233_1.time_ <= var_236_33 + arg_236_0 then
				arg_233_1.var_.moveOldPos1084ui_story = var_236_32.localPosition
			end

			local var_236_34 = 0.001

			if var_236_33 <= arg_233_1.time_ and arg_233_1.time_ < var_236_33 + var_236_34 then
				local var_236_35 = (arg_233_1.time_ - var_236_33) / var_236_34
				local var_236_36 = Vector3.New(0, -0.97, -6)

				var_236_32.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1084ui_story, var_236_36, var_236_35)

				local var_236_37 = manager.ui.mainCamera.transform.position - var_236_32.position

				var_236_32.forward = Vector3.New(var_236_37.x, var_236_37.y, var_236_37.z)

				local var_236_38 = var_236_32.localEulerAngles

				var_236_38.z = 0
				var_236_38.x = 0
				var_236_32.localEulerAngles = var_236_38
			end

			if arg_233_1.time_ >= var_236_33 + var_236_34 and arg_233_1.time_ < var_236_33 + var_236_34 + arg_236_0 then
				var_236_32.localPosition = Vector3.New(0, -0.97, -6)

				local var_236_39 = manager.ui.mainCamera.transform.position - var_236_32.position

				var_236_32.forward = Vector3.New(var_236_39.x, var_236_39.y, var_236_39.z)

				local var_236_40 = var_236_32.localEulerAngles

				var_236_40.z = 0
				var_236_40.x = 0
				var_236_32.localEulerAngles = var_236_40
			end

			local var_236_41 = arg_233_1.actors_["1084ui_story"]
			local var_236_42 = 3.8

			if var_236_42 < arg_233_1.time_ and arg_233_1.time_ <= var_236_42 + arg_236_0 and not isNil(var_236_41) and arg_233_1.var_.characterEffect1084ui_story == nil then
				arg_233_1.var_.characterEffect1084ui_story = var_236_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_43 = 0.200000002980232

			if var_236_42 <= arg_233_1.time_ and arg_233_1.time_ < var_236_42 + var_236_43 and not isNil(var_236_41) then
				local var_236_44 = (arg_233_1.time_ - var_236_42) / var_236_43

				if arg_233_1.var_.characterEffect1084ui_story and not isNil(var_236_41) then
					arg_233_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_42 + var_236_43 and arg_233_1.time_ < var_236_42 + var_236_43 + arg_236_0 and not isNil(var_236_41) and arg_233_1.var_.characterEffect1084ui_story then
				arg_233_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_236_45 = 3.8

			if var_236_45 < arg_233_1.time_ and arg_233_1.time_ <= var_236_45 + arg_236_0 then
				arg_233_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			local var_236_46 = 3.8

			if var_236_46 < arg_233_1.time_ and arg_233_1.time_ <= var_236_46 + arg_236_0 then
				arg_233_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_236_47 = arg_233_1.actors_["1084ui_story"]
			local var_236_48 = 3.8

			if var_236_48 < arg_233_1.time_ and arg_233_1.time_ <= var_236_48 + arg_236_0 then
				if arg_233_1.var_.characterEffect1084ui_story == nil then
					arg_233_1.var_.characterEffect1084ui_story = var_236_47:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_236_49 = arg_233_1.var_.characterEffect1084ui_story

				var_236_49.imageEffect:turnOff()

				var_236_49.interferenceEffect.enabled = true
				var_236_49.interferenceEffect.noise = 0.001
				var_236_49.interferenceEffect.simTimeScale = 1
				var_236_49.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_236_50 = arg_233_1.actors_["1084ui_story"]
			local var_236_51 = 3.8
			local var_236_52 = 0.200000002980232

			if var_236_51 < arg_233_1.time_ and arg_233_1.time_ <= var_236_51 + arg_236_0 then
				if arg_233_1.var_.characterEffect1084ui_story == nil then
					arg_233_1.var_.characterEffect1084ui_story = var_236_50:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_233_1.var_.characterEffect1084ui_story.imageEffect:turnOn(false)
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_53 = 4
			local var_236_54 = 0.625

			if var_236_53 < arg_233_1.time_ and arg_233_1.time_ <= var_236_53 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_55 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_55:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_56 = arg_233_1:FormatText(StoryNameCfg[6].name)

				arg_233_1.leftNameTxt_.text = var_236_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_57 = arg_233_1:GetWordFromCfg(1109703056)
				local var_236_58 = arg_233_1:FormatText(var_236_57.content)

				arg_233_1.text_.text = var_236_58

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_59 = 25
				local var_236_60 = utf8.len(var_236_58)
				local var_236_61 = var_236_59 <= 0 and var_236_54 or var_236_54 * (var_236_60 / var_236_59)

				if var_236_61 > 0 and var_236_54 < var_236_61 then
					arg_233_1.talkMaxDuration = var_236_61
					var_236_53 = var_236_53 + 0.3

					if var_236_61 + var_236_53 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_61 + var_236_53
					end
				end

				arg_233_1.text_.text = var_236_58
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703056", "story_v_side_new_1109703.awb") ~= 0 then
					local var_236_62 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703056", "story_v_side_new_1109703.awb") / 1000

					if var_236_62 + var_236_53 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_62 + var_236_53
					end

					if var_236_57.prefab_name ~= "" and arg_233_1.actors_[var_236_57.prefab_name] ~= nil then
						local var_236_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_57.prefab_name].transform, "story_v_side_new_1109703", "1109703056", "story_v_side_new_1109703.awb")

						arg_233_1:RecordAudio("1109703056", var_236_63)
						arg_233_1:RecordAudio("1109703056", var_236_63)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703056", "story_v_side_new_1109703.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703056", "story_v_side_new_1109703.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_64 = var_236_53 + 0.3
			local var_236_65 = math.max(var_236_54, arg_233_1.talkMaxDuration)

			if var_236_64 <= arg_233_1.time_ and arg_233_1.time_ < var_236_64 + var_236_65 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_64) / var_236_65

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_64 + var_236_65 and arg_233_1.time_ < var_236_64 + var_236_65 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play1109703057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1109703057
		arg_239_1.duration_ = 14.47

		local var_239_0 = {
			zh = 10.166,
			ja = 14.466
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1109703058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1084ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1084ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0, 100, 0)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1084ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, 100, 0)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["1084ui_story"]
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1084ui_story == nil then
				arg_239_1.var_.characterEffect1084ui_story = var_242_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_11 = 0.200000002980232

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 and not isNil(var_242_9) then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11

				if arg_239_1.var_.characterEffect1084ui_story and not isNil(var_242_9) then
					local var_242_13 = Mathf.Lerp(0, 0.5, var_242_12)

					arg_239_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1084ui_story.fillRatio = var_242_13
				end
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1084ui_story then
				local var_242_14 = 0.5

				arg_239_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1084ui_story.fillRatio = var_242_14
			end

			local var_242_15 = "1011ui_story"

			if arg_239_1.actors_[var_242_15] == nil then
				local var_242_16 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_242_16) then
					local var_242_17 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_239_1.stage_.transform)

					var_242_17.name = var_242_15
					var_242_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_239_1.actors_[var_242_15] = var_242_17

					local var_242_18 = var_242_17:GetComponentInChildren(typeof(CharacterEffect))

					var_242_18.enabled = true

					local var_242_19 = GameObjectTools.GetOrAddComponent(var_242_17, typeof(DynamicBoneHelper))

					if var_242_19 then
						var_242_19:EnableDynamicBone(false)
					end

					arg_239_1:ShowWeapon(var_242_18.transform, false)

					arg_239_1.var_[var_242_15 .. "Animator"] = var_242_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_239_1.var_[var_242_15 .. "Animator"].applyRootMotion = true
					arg_239_1.var_[var_242_15 .. "LipSync"] = var_242_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_242_20 = arg_239_1.actors_["1011ui_story"].transform
			local var_242_21 = 0

			if var_242_21 < arg_239_1.time_ and arg_239_1.time_ <= var_242_21 + arg_242_0 then
				arg_239_1.var_.moveOldPos1011ui_story = var_242_20.localPosition
			end

			local var_242_22 = 0.001

			if var_242_21 <= arg_239_1.time_ and arg_239_1.time_ < var_242_21 + var_242_22 then
				local var_242_23 = (arg_239_1.time_ - var_242_21) / var_242_22
				local var_242_24 = Vector3.New(0, -0.71, -6)

				var_242_20.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1011ui_story, var_242_24, var_242_23)

				local var_242_25 = manager.ui.mainCamera.transform.position - var_242_20.position

				var_242_20.forward = Vector3.New(var_242_25.x, var_242_25.y, var_242_25.z)

				local var_242_26 = var_242_20.localEulerAngles

				var_242_26.z = 0
				var_242_26.x = 0
				var_242_20.localEulerAngles = var_242_26
			end

			if arg_239_1.time_ >= var_242_21 + var_242_22 and arg_239_1.time_ < var_242_21 + var_242_22 + arg_242_0 then
				var_242_20.localPosition = Vector3.New(0, -0.71, -6)

				local var_242_27 = manager.ui.mainCamera.transform.position - var_242_20.position

				var_242_20.forward = Vector3.New(var_242_27.x, var_242_27.y, var_242_27.z)

				local var_242_28 = var_242_20.localEulerAngles

				var_242_28.z = 0
				var_242_28.x = 0
				var_242_20.localEulerAngles = var_242_28
			end

			local var_242_29 = arg_239_1.actors_["1011ui_story"]
			local var_242_30 = 0

			if var_242_30 < arg_239_1.time_ and arg_239_1.time_ <= var_242_30 + arg_242_0 and not isNil(var_242_29) and arg_239_1.var_.characterEffect1011ui_story == nil then
				arg_239_1.var_.characterEffect1011ui_story = var_242_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_31 = 0.200000002980232

			if var_242_30 <= arg_239_1.time_ and arg_239_1.time_ < var_242_30 + var_242_31 and not isNil(var_242_29) then
				local var_242_32 = (arg_239_1.time_ - var_242_30) / var_242_31

				if arg_239_1.var_.characterEffect1011ui_story and not isNil(var_242_29) then
					arg_239_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_30 + var_242_31 and arg_239_1.time_ < var_242_30 + var_242_31 + arg_242_0 and not isNil(var_242_29) and arg_239_1.var_.characterEffect1011ui_story then
				arg_239_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_242_33 = 0

			if var_242_33 < arg_239_1.time_ and arg_239_1.time_ <= var_242_33 + arg_242_0 then
				arg_239_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_242_34 = 0

			if var_242_34 < arg_239_1.time_ and arg_239_1.time_ <= var_242_34 + arg_242_0 then
				arg_239_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_242_35 = arg_239_1.actors_["1011ui_story"]
			local var_242_36 = 0

			if var_242_36 < arg_239_1.time_ and arg_239_1.time_ <= var_242_36 + arg_242_0 then
				if arg_239_1.var_.characterEffect1011ui_story == nil then
					arg_239_1.var_.characterEffect1011ui_story = var_242_35:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_242_37 = arg_239_1.var_.characterEffect1011ui_story

				var_242_37.imageEffect:turnOff()

				var_242_37.interferenceEffect.enabled = true
				var_242_37.interferenceEffect.noise = 0.001
				var_242_37.interferenceEffect.simTimeScale = 1
				var_242_37.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_242_38 = arg_239_1.actors_["1011ui_story"]
			local var_242_39 = 0
			local var_242_40 = 0.200000002980232

			if var_242_39 < arg_239_1.time_ and arg_239_1.time_ <= var_242_39 + arg_242_0 then
				if arg_239_1.var_.characterEffect1011ui_story == nil then
					arg_239_1.var_.characterEffect1011ui_story = var_242_38:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_239_1.var_.characterEffect1011ui_story.imageEffect:turnOn(false)
			end

			local var_242_41 = 0
			local var_242_42 = 1.325

			if var_242_41 < arg_239_1.time_ and arg_239_1.time_ <= var_242_41 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_43 = arg_239_1:FormatText(StoryNameCfg[37].name)

				arg_239_1.leftNameTxt_.text = var_242_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_44 = arg_239_1:GetWordFromCfg(1109703057)
				local var_242_45 = arg_239_1:FormatText(var_242_44.content)

				arg_239_1.text_.text = var_242_45

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_46 = 53
				local var_242_47 = utf8.len(var_242_45)
				local var_242_48 = var_242_46 <= 0 and var_242_42 or var_242_42 * (var_242_47 / var_242_46)

				if var_242_48 > 0 and var_242_42 < var_242_48 then
					arg_239_1.talkMaxDuration = var_242_48

					if var_242_48 + var_242_41 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_48 + var_242_41
					end
				end

				arg_239_1.text_.text = var_242_45
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703057", "story_v_side_new_1109703.awb") ~= 0 then
					local var_242_49 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703057", "story_v_side_new_1109703.awb") / 1000

					if var_242_49 + var_242_41 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_49 + var_242_41
					end

					if var_242_44.prefab_name ~= "" and arg_239_1.actors_[var_242_44.prefab_name] ~= nil then
						local var_242_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_44.prefab_name].transform, "story_v_side_new_1109703", "1109703057", "story_v_side_new_1109703.awb")

						arg_239_1:RecordAudio("1109703057", var_242_50)
						arg_239_1:RecordAudio("1109703057", var_242_50)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703057", "story_v_side_new_1109703.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703057", "story_v_side_new_1109703.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_51 = math.max(var_242_42, arg_239_1.talkMaxDuration)

			if var_242_41 <= arg_239_1.time_ and arg_239_1.time_ < var_242_41 + var_242_51 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_41) / var_242_51

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_41 + var_242_51 and arg_239_1.time_ < var_242_41 + var_242_51 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1109703058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1109703058
		arg_243_1.duration_ = 8

		local var_243_0 = {
			zh = 8,
			ja = 6.866
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1109703059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1011ui_story"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos1011ui_story = var_246_0.localPosition
			end

			local var_246_2 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2
				local var_246_4 = Vector3.New(0, 100, 0)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1011ui_story, var_246_4, var_246_3)

				local var_246_5 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_5.x, var_246_5.y, var_246_5.z)

				local var_246_6 = var_246_0.localEulerAngles

				var_246_6.z = 0
				var_246_6.x = 0
				var_246_0.localEulerAngles = var_246_6
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(0, 100, 0)

				local var_246_7 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_7.x, var_246_7.y, var_246_7.z)

				local var_246_8 = var_246_0.localEulerAngles

				var_246_8.z = 0
				var_246_8.x = 0
				var_246_0.localEulerAngles = var_246_8
			end

			local var_246_9 = arg_243_1.actors_["1011ui_story"]
			local var_246_10 = 0

			if var_246_10 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1011ui_story == nil then
				arg_243_1.var_.characterEffect1011ui_story = var_246_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_11 = 0.200000002980232

			if var_246_10 <= arg_243_1.time_ and arg_243_1.time_ < var_246_10 + var_246_11 and not isNil(var_246_9) then
				local var_246_12 = (arg_243_1.time_ - var_246_10) / var_246_11

				if arg_243_1.var_.characterEffect1011ui_story and not isNil(var_246_9) then
					local var_246_13 = Mathf.Lerp(0, 0.5, var_246_12)

					arg_243_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1011ui_story.fillRatio = var_246_13
				end
			end

			if arg_243_1.time_ >= var_246_10 + var_246_11 and arg_243_1.time_ < var_246_10 + var_246_11 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1011ui_story then
				local var_246_14 = 0.5

				arg_243_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1011ui_story.fillRatio = var_246_14
			end

			local var_246_15 = "1037ui_story"

			if arg_243_1.actors_[var_246_15] == nil then
				local var_246_16 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_246_16) then
					local var_246_17 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_243_1.stage_.transform)

					var_246_17.name = var_246_15
					var_246_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_243_1.actors_[var_246_15] = var_246_17

					local var_246_18 = var_246_17:GetComponentInChildren(typeof(CharacterEffect))

					var_246_18.enabled = true

					local var_246_19 = GameObjectTools.GetOrAddComponent(var_246_17, typeof(DynamicBoneHelper))

					if var_246_19 then
						var_246_19:EnableDynamicBone(false)
					end

					arg_243_1:ShowWeapon(var_246_18.transform, false)

					arg_243_1.var_[var_246_15 .. "Animator"] = var_246_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_243_1.var_[var_246_15 .. "Animator"].applyRootMotion = true
					arg_243_1.var_[var_246_15 .. "LipSync"] = var_246_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_246_20 = arg_243_1.actors_["1037ui_story"].transform
			local var_246_21 = 0

			if var_246_21 < arg_243_1.time_ and arg_243_1.time_ <= var_246_21 + arg_246_0 then
				arg_243_1.var_.moveOldPos1037ui_story = var_246_20.localPosition
			end

			local var_246_22 = 0.001

			if var_246_21 <= arg_243_1.time_ and arg_243_1.time_ < var_246_21 + var_246_22 then
				local var_246_23 = (arg_243_1.time_ - var_246_21) / var_246_22
				local var_246_24 = Vector3.New(0, -1.09, -5.81)

				var_246_20.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1037ui_story, var_246_24, var_246_23)

				local var_246_25 = manager.ui.mainCamera.transform.position - var_246_20.position

				var_246_20.forward = Vector3.New(var_246_25.x, var_246_25.y, var_246_25.z)

				local var_246_26 = var_246_20.localEulerAngles

				var_246_26.z = 0
				var_246_26.x = 0
				var_246_20.localEulerAngles = var_246_26
			end

			if arg_243_1.time_ >= var_246_21 + var_246_22 and arg_243_1.time_ < var_246_21 + var_246_22 + arg_246_0 then
				var_246_20.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_246_27 = manager.ui.mainCamera.transform.position - var_246_20.position

				var_246_20.forward = Vector3.New(var_246_27.x, var_246_27.y, var_246_27.z)

				local var_246_28 = var_246_20.localEulerAngles

				var_246_28.z = 0
				var_246_28.x = 0
				var_246_20.localEulerAngles = var_246_28
			end

			local var_246_29 = arg_243_1.actors_["1037ui_story"]
			local var_246_30 = 0

			if var_246_30 < arg_243_1.time_ and arg_243_1.time_ <= var_246_30 + arg_246_0 and not isNil(var_246_29) and arg_243_1.var_.characterEffect1037ui_story == nil then
				arg_243_1.var_.characterEffect1037ui_story = var_246_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_31 = 0.200000002980232

			if var_246_30 <= arg_243_1.time_ and arg_243_1.time_ < var_246_30 + var_246_31 and not isNil(var_246_29) then
				local var_246_32 = (arg_243_1.time_ - var_246_30) / var_246_31

				if arg_243_1.var_.characterEffect1037ui_story and not isNil(var_246_29) then
					arg_243_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_30 + var_246_31 and arg_243_1.time_ < var_246_30 + var_246_31 + arg_246_0 and not isNil(var_246_29) and arg_243_1.var_.characterEffect1037ui_story then
				arg_243_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_246_33 = 0

			if var_246_33 < arg_243_1.time_ and arg_243_1.time_ <= var_246_33 + arg_246_0 then
				arg_243_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_246_34 = 0

			if var_246_34 < arg_243_1.time_ and arg_243_1.time_ <= var_246_34 + arg_246_0 then
				arg_243_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_246_35 = arg_243_1.actors_["1037ui_story"]
			local var_246_36 = 0

			if var_246_36 < arg_243_1.time_ and arg_243_1.time_ <= var_246_36 + arg_246_0 then
				if arg_243_1.var_.characterEffect1037ui_story == nil then
					arg_243_1.var_.characterEffect1037ui_story = var_246_35:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_246_37 = arg_243_1.var_.characterEffect1037ui_story

				var_246_37.imageEffect:turnOff()

				var_246_37.interferenceEffect.enabled = true
				var_246_37.interferenceEffect.noise = 0.001
				var_246_37.interferenceEffect.simTimeScale = 1
				var_246_37.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_246_38 = arg_243_1.actors_["1037ui_story"]
			local var_246_39 = 0
			local var_246_40 = 0.200000002980232

			if var_246_39 < arg_243_1.time_ and arg_243_1.time_ <= var_246_39 + arg_246_0 then
				if arg_243_1.var_.characterEffect1037ui_story == nil then
					arg_243_1.var_.characterEffect1037ui_story = var_246_38:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_243_1.var_.characterEffect1037ui_story.imageEffect:turnOn(false)
			end

			local var_246_41 = 0
			local var_246_42 = 0.9

			if var_246_41 < arg_243_1.time_ and arg_243_1.time_ <= var_246_41 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_43 = arg_243_1:FormatText(StoryNameCfg[15].name)

				arg_243_1.leftNameTxt_.text = var_246_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_44 = arg_243_1:GetWordFromCfg(1109703058)
				local var_246_45 = arg_243_1:FormatText(var_246_44.content)

				arg_243_1.text_.text = var_246_45

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_46 = 36
				local var_246_47 = utf8.len(var_246_45)
				local var_246_48 = var_246_46 <= 0 and var_246_42 or var_246_42 * (var_246_47 / var_246_46)

				if var_246_48 > 0 and var_246_42 < var_246_48 then
					arg_243_1.talkMaxDuration = var_246_48

					if var_246_48 + var_246_41 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_48 + var_246_41
					end
				end

				arg_243_1.text_.text = var_246_45
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703058", "story_v_side_new_1109703.awb") ~= 0 then
					local var_246_49 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703058", "story_v_side_new_1109703.awb") / 1000

					if var_246_49 + var_246_41 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_49 + var_246_41
					end

					if var_246_44.prefab_name ~= "" and arg_243_1.actors_[var_246_44.prefab_name] ~= nil then
						local var_246_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_44.prefab_name].transform, "story_v_side_new_1109703", "1109703058", "story_v_side_new_1109703.awb")

						arg_243_1:RecordAudio("1109703058", var_246_50)
						arg_243_1:RecordAudio("1109703058", var_246_50)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703058", "story_v_side_new_1109703.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703058", "story_v_side_new_1109703.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_51 = math.max(var_246_42, arg_243_1.talkMaxDuration)

			if var_246_41 <= arg_243_1.time_ and arg_243_1.time_ < var_246_41 + var_246_51 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_41) / var_246_51

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_41 + var_246_51 and arg_243_1.time_ < var_246_41 + var_246_51 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play1109703059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1109703059
		arg_247_1.duration_ = 3.97

		local var_247_0 = {
			zh = 2.933,
			ja = 3.966
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1109703060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1037ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos1037ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(0, 100, 0)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1037ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0, 100, 0)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["1037ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1037ui_story == nil then
				arg_247_1.var_.characterEffect1037ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect1037ui_story and not isNil(var_250_9) then
					local var_250_13 = Mathf.Lerp(0, 0.5, var_250_12)

					arg_247_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1037ui_story.fillRatio = var_250_13
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1037ui_story then
				local var_250_14 = 0.5

				arg_247_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1037ui_story.fillRatio = var_250_14
			end

			local var_250_15 = arg_247_1.actors_["1097ui_story"].transform
			local var_250_16 = 0

			if var_250_16 < arg_247_1.time_ and arg_247_1.time_ <= var_250_16 + arg_250_0 then
				arg_247_1.var_.moveOldPos1097ui_story = var_250_15.localPosition
			end

			local var_250_17 = 0.001

			if var_250_16 <= arg_247_1.time_ and arg_247_1.time_ < var_250_16 + var_250_17 then
				local var_250_18 = (arg_247_1.time_ - var_250_16) / var_250_17
				local var_250_19 = Vector3.New(0, -0.54, -6.3)

				var_250_15.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1097ui_story, var_250_19, var_250_18)

				local var_250_20 = manager.ui.mainCamera.transform.position - var_250_15.position

				var_250_15.forward = Vector3.New(var_250_20.x, var_250_20.y, var_250_20.z)

				local var_250_21 = var_250_15.localEulerAngles

				var_250_21.z = 0
				var_250_21.x = 0
				var_250_15.localEulerAngles = var_250_21
			end

			if arg_247_1.time_ >= var_250_16 + var_250_17 and arg_247_1.time_ < var_250_16 + var_250_17 + arg_250_0 then
				var_250_15.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_250_22 = manager.ui.mainCamera.transform.position - var_250_15.position

				var_250_15.forward = Vector3.New(var_250_22.x, var_250_22.y, var_250_22.z)

				local var_250_23 = var_250_15.localEulerAngles

				var_250_23.z = 0
				var_250_23.x = 0
				var_250_15.localEulerAngles = var_250_23
			end

			local var_250_24 = arg_247_1.actors_["1097ui_story"]
			local var_250_25 = 0

			if var_250_25 < arg_247_1.time_ and arg_247_1.time_ <= var_250_25 + arg_250_0 and not isNil(var_250_24) and arg_247_1.var_.characterEffect1097ui_story == nil then
				arg_247_1.var_.characterEffect1097ui_story = var_250_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_26 = 0.200000002980232

			if var_250_25 <= arg_247_1.time_ and arg_247_1.time_ < var_250_25 + var_250_26 and not isNil(var_250_24) then
				local var_250_27 = (arg_247_1.time_ - var_250_25) / var_250_26

				if arg_247_1.var_.characterEffect1097ui_story and not isNil(var_250_24) then
					arg_247_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_25 + var_250_26 and arg_247_1.time_ < var_250_25 + var_250_26 + arg_250_0 and not isNil(var_250_24) and arg_247_1.var_.characterEffect1097ui_story then
				arg_247_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_250_28 = 0

			if var_250_28 < arg_247_1.time_ and arg_247_1.time_ <= var_250_28 + arg_250_0 then
				arg_247_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_250_29 = 0

			if var_250_29 < arg_247_1.time_ and arg_247_1.time_ <= var_250_29 + arg_250_0 then
				arg_247_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_250_30 = 0
			local var_250_31 = 0.275

			if var_250_30 < arg_247_1.time_ and arg_247_1.time_ <= var_250_30 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_32 = arg_247_1:FormatText(StoryNameCfg[216].name)

				arg_247_1.leftNameTxt_.text = var_250_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_33 = arg_247_1:GetWordFromCfg(1109703059)
				local var_250_34 = arg_247_1:FormatText(var_250_33.content)

				arg_247_1.text_.text = var_250_34

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_35 = 11
				local var_250_36 = utf8.len(var_250_34)
				local var_250_37 = var_250_35 <= 0 and var_250_31 or var_250_31 * (var_250_36 / var_250_35)

				if var_250_37 > 0 and var_250_31 < var_250_37 then
					arg_247_1.talkMaxDuration = var_250_37

					if var_250_37 + var_250_30 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_37 + var_250_30
					end
				end

				arg_247_1.text_.text = var_250_34
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703059", "story_v_side_new_1109703.awb") ~= 0 then
					local var_250_38 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703059", "story_v_side_new_1109703.awb") / 1000

					if var_250_38 + var_250_30 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_38 + var_250_30
					end

					if var_250_33.prefab_name ~= "" and arg_247_1.actors_[var_250_33.prefab_name] ~= nil then
						local var_250_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_33.prefab_name].transform, "story_v_side_new_1109703", "1109703059", "story_v_side_new_1109703.awb")

						arg_247_1:RecordAudio("1109703059", var_250_39)
						arg_247_1:RecordAudio("1109703059", var_250_39)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703059", "story_v_side_new_1109703.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703059", "story_v_side_new_1109703.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_40 = math.max(var_250_31, arg_247_1.talkMaxDuration)

			if var_250_30 <= arg_247_1.time_ and arg_247_1.time_ < var_250_30 + var_250_40 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_30) / var_250_40

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_30 + var_250_40 and arg_247_1.time_ < var_250_30 + var_250_40 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play1109703060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1109703060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1109703061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1097ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1097ui_story == nil then
				arg_251_1.var_.characterEffect1097ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect1097ui_story and not isNil(var_254_0) then
					local var_254_4 = Mathf.Lerp(0, 0.5, var_254_3)

					arg_251_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1097ui_story.fillRatio = var_254_4
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1097ui_story then
				local var_254_5 = 0.5

				arg_251_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1097ui_story.fillRatio = var_254_5
			end

			local var_254_6 = 0
			local var_254_7 = 0.4

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

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_9 = arg_251_1:GetWordFromCfg(1109703060)
				local var_254_10 = arg_251_1:FormatText(var_254_9.content)

				arg_251_1.text_.text = var_254_10

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 16
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
	Play1109703061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1109703061
		arg_255_1.duration_ = 8.27

		local var_255_0 = {
			zh = 6.033,
			ja = 8.266
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1109703062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1097ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1097ui_story == nil then
				arg_255_1.var_.characterEffect1097ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect1097ui_story and not isNil(var_258_0) then
					arg_255_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1097ui_story then
				arg_255_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_258_4 = 0

			if var_258_4 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_258_5 = 0

			if var_258_5 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_258_6 = 0
			local var_258_7 = 0.6

			if var_258_6 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_8 = arg_255_1:FormatText(StoryNameCfg[216].name)

				arg_255_1.leftNameTxt_.text = var_258_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_9 = arg_255_1:GetWordFromCfg(1109703061)
				local var_258_10 = arg_255_1:FormatText(var_258_9.content)

				arg_255_1.text_.text = var_258_10

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_11 = 24
				local var_258_12 = utf8.len(var_258_10)
				local var_258_13 = var_258_11 <= 0 and var_258_7 or var_258_7 * (var_258_12 / var_258_11)

				if var_258_13 > 0 and var_258_7 < var_258_13 then
					arg_255_1.talkMaxDuration = var_258_13

					if var_258_13 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_13 + var_258_6
					end
				end

				arg_255_1.text_.text = var_258_10
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703061", "story_v_side_new_1109703.awb") ~= 0 then
					local var_258_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703061", "story_v_side_new_1109703.awb") / 1000

					if var_258_14 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_14 + var_258_6
					end

					if var_258_9.prefab_name ~= "" and arg_255_1.actors_[var_258_9.prefab_name] ~= nil then
						local var_258_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_9.prefab_name].transform, "story_v_side_new_1109703", "1109703061", "story_v_side_new_1109703.awb")

						arg_255_1:RecordAudio("1109703061", var_258_15)
						arg_255_1:RecordAudio("1109703061", var_258_15)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703061", "story_v_side_new_1109703.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703061", "story_v_side_new_1109703.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_16 = math.max(var_258_7, arg_255_1.talkMaxDuration)

			if var_258_6 <= arg_255_1.time_ and arg_255_1.time_ < var_258_6 + var_258_16 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_6) / var_258_16

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_6 + var_258_16 and arg_255_1.time_ < var_258_6 + var_258_16 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1109703062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1109703062
		arg_259_1.duration_ = 5.37

		local var_259_0 = {
			zh = 2.7,
			ja = 5.366
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
				arg_259_0:Play1109703063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 0.25

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_2 = arg_259_1:FormatText(StoryNameCfg[216].name)

				arg_259_1.leftNameTxt_.text = var_262_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_3 = arg_259_1:GetWordFromCfg(1109703062)
				local var_262_4 = arg_259_1:FormatText(var_262_3.content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 10
				local var_262_6 = utf8.len(var_262_4)
				local var_262_7 = var_262_5 <= 0 and var_262_1 or var_262_1 * (var_262_6 / var_262_5)

				if var_262_7 > 0 and var_262_1 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_4
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703062", "story_v_side_new_1109703.awb") ~= 0 then
					local var_262_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703062", "story_v_side_new_1109703.awb") / 1000

					if var_262_8 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_0
					end

					if var_262_3.prefab_name ~= "" and arg_259_1.actors_[var_262_3.prefab_name] ~= nil then
						local var_262_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_3.prefab_name].transform, "story_v_side_new_1109703", "1109703062", "story_v_side_new_1109703.awb")

						arg_259_1:RecordAudio("1109703062", var_262_9)
						arg_259_1:RecordAudio("1109703062", var_262_9)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703062", "story_v_side_new_1109703.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703062", "story_v_side_new_1109703.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_10 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_10 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_10

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_10 and arg_259_1.time_ < var_262_0 + var_262_10 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1109703063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1109703063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1109703064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1097ui_story"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect1097ui_story == nil then
				arg_263_1.var_.characterEffect1097ui_story = var_266_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.characterEffect1097ui_story and not isNil(var_266_0) then
					local var_266_4 = Mathf.Lerp(0, 0.5, var_266_3)

					arg_263_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1097ui_story.fillRatio = var_266_4
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect1097ui_story then
				local var_266_5 = 0.5

				arg_263_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1097ui_story.fillRatio = var_266_5
			end

			local var_266_6 = 0
			local var_266_7 = 0.75

			if var_266_6 < arg_263_1.time_ and arg_263_1.time_ <= var_266_6 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_8 = arg_263_1:FormatText(StoryNameCfg[7].name)

				arg_263_1.leftNameTxt_.text = var_266_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_9 = arg_263_1:GetWordFromCfg(1109703063)
				local var_266_10 = arg_263_1:FormatText(var_266_9.content)

				arg_263_1.text_.text = var_266_10

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_11 = 30
				local var_266_12 = utf8.len(var_266_10)
				local var_266_13 = var_266_11 <= 0 and var_266_7 or var_266_7 * (var_266_12 / var_266_11)

				if var_266_13 > 0 and var_266_7 < var_266_13 then
					arg_263_1.talkMaxDuration = var_266_13

					if var_266_13 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_13 + var_266_6
					end
				end

				arg_263_1.text_.text = var_266_10
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_14 = math.max(var_266_7, arg_263_1.talkMaxDuration)

			if var_266_6 <= arg_263_1.time_ and arg_263_1.time_ < var_266_6 + var_266_14 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_6) / var_266_14

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_6 + var_266_14 and arg_263_1.time_ < var_266_6 + var_266_14 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play1109703064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1109703064
		arg_267_1.duration_ = 2.23

		local var_267_0 = {
			zh = 2.233,
			ja = 2.199999999999
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1109703065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1097ui_story"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1097ui_story == nil then
				arg_267_1.var_.characterEffect1097ui_story = var_270_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.characterEffect1097ui_story and not isNil(var_270_0) then
					arg_267_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1097ui_story then
				arg_267_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_270_4 = 0

			if var_270_4 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action5_1")
			end

			local var_270_5 = 0

			if var_270_5 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_270_6 = arg_267_1.actors_["1097ui_story"].transform
			local var_270_7 = 0

			if var_270_7 < arg_267_1.time_ and arg_267_1.time_ <= var_270_7 + arg_270_0 then
				local var_270_8 = arg_267_1.var_.effect1097ui_storykaixinxiaokun1
				local var_270_9
				local var_270_10 = var_270_6

				if not var_270_8 then
					var_270_8 = Object.Instantiate(Asset.Load("Effect/Hero/1097/fx_1097_story_smoke"), var_270_10)
					var_270_8.name = "kaixinxiaokun1"
					arg_267_1.var_.effect1097ui_storykaixinxiaokun1 = var_270_8
				else
					var_270_8.transform:SetParent(var_270_10)
				end

				var_270_8.transform.localPosition = Vector3.New(0, 1.28, 0.3)
				var_270_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_270_11 = arg_267_1.actors_["1097ui_story"].transform
			local var_270_12 = 2

			if var_270_12 < arg_267_1.time_ and arg_267_1.time_ <= var_270_12 + arg_270_0 then
				local var_270_13 = arg_267_1.var_.effect1097ui_storykaixinxiaokun1

				if var_270_13 then
					Object.Destroy(var_270_13)

					arg_267_1.var_.effect1097ui_storykaixinxiaokun1 = nil
				end
			end

			local var_270_14 = 0
			local var_270_15 = 0.15

			if var_270_14 < arg_267_1.time_ and arg_267_1.time_ <= var_270_14 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_16 = arg_267_1:FormatText(StoryNameCfg[216].name)

				arg_267_1.leftNameTxt_.text = var_270_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_17 = arg_267_1:GetWordFromCfg(1109703064)
				local var_270_18 = arg_267_1:FormatText(var_270_17.content)

				arg_267_1.text_.text = var_270_18

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_19 = 6
				local var_270_20 = utf8.len(var_270_18)
				local var_270_21 = var_270_19 <= 0 and var_270_15 or var_270_15 * (var_270_20 / var_270_19)

				if var_270_21 > 0 and var_270_15 < var_270_21 then
					arg_267_1.talkMaxDuration = var_270_21

					if var_270_21 + var_270_14 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_21 + var_270_14
					end
				end

				arg_267_1.text_.text = var_270_18
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703064", "story_v_side_new_1109703.awb") ~= 0 then
					local var_270_22 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703064", "story_v_side_new_1109703.awb") / 1000

					if var_270_22 + var_270_14 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_22 + var_270_14
					end

					if var_270_17.prefab_name ~= "" and arg_267_1.actors_[var_270_17.prefab_name] ~= nil then
						local var_270_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_17.prefab_name].transform, "story_v_side_new_1109703", "1109703064", "story_v_side_new_1109703.awb")

						arg_267_1:RecordAudio("1109703064", var_270_23)
						arg_267_1:RecordAudio("1109703064", var_270_23)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703064", "story_v_side_new_1109703.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703064", "story_v_side_new_1109703.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_24 = math.max(var_270_15, arg_267_1.talkMaxDuration)

			if var_270_14 <= arg_267_1.time_ and arg_267_1.time_ < var_270_14 + var_270_24 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_14) / var_270_24

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_14 + var_270_24 and arg_267_1.time_ < var_270_14 + var_270_24 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1109703065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1109703065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1109703066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1097ui_story"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1097ui_story == nil then
				arg_271_1.var_.characterEffect1097ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.characterEffect1097ui_story and not isNil(var_274_0) then
					local var_274_4 = Mathf.Lerp(0, 0.5, var_274_3)

					arg_271_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1097ui_story.fillRatio = var_274_4
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1097ui_story then
				local var_274_5 = 0.5

				arg_271_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1097ui_story.fillRatio = var_274_5
			end

			local var_274_6 = 0
			local var_274_7 = 0.775

			if var_274_6 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_8 = arg_271_1:GetWordFromCfg(1109703065)
				local var_274_9 = arg_271_1:FormatText(var_274_8.content)

				arg_271_1.text_.text = var_274_9

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_10 = 31
				local var_274_11 = utf8.len(var_274_9)
				local var_274_12 = var_274_10 <= 0 and var_274_7 or var_274_7 * (var_274_11 / var_274_10)

				if var_274_12 > 0 and var_274_7 < var_274_12 then
					arg_271_1.talkMaxDuration = var_274_12

					if var_274_12 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_12 + var_274_6
					end
				end

				arg_271_1.text_.text = var_274_9
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_13 = math.max(var_274_7, arg_271_1.talkMaxDuration)

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_13 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_6) / var_274_13

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_6 + var_274_13 and arg_271_1.time_ < var_274_6 + var_274_13 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1109703066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1109703066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1109703067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0
			local var_278_1 = 0.45

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_2 = arg_275_1:FormatText(StoryNameCfg[7].name)

				arg_275_1.leftNameTxt_.text = var_278_2

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

				local var_278_3 = arg_275_1:GetWordFromCfg(1109703066)
				local var_278_4 = arg_275_1:FormatText(var_278_3.content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 18
				local var_278_6 = utf8.len(var_278_4)
				local var_278_7 = var_278_5 <= 0 and var_278_1 or var_278_1 * (var_278_6 / var_278_5)

				if var_278_7 > 0 and var_278_1 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_0
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_8 = math.max(var_278_1, arg_275_1.talkMaxDuration)

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_8 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_0) / var_278_8

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_0 + var_278_8 and arg_275_1.time_ < var_278_0 + var_278_8 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1109703067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1109703067
		arg_279_1.duration_ = 2.93

		local var_279_0 = {
			zh = 2.933,
			ja = 2.199999999999
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
				arg_279_0:Play1109703068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1097ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1097ui_story == nil then
				arg_279_1.var_.characterEffect1097ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect1097ui_story and not isNil(var_282_0) then
					arg_279_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1097ui_story then
				arg_279_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_282_4 = 0

			if var_282_4 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action5_2")
			end

			local var_282_5 = 0

			if var_282_5 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_282_6 = arg_279_1.actors_["1097ui_story"].transform
			local var_282_7 = 0

			if var_282_7 < arg_279_1.time_ and arg_279_1.time_ <= var_282_7 + arg_282_0 then
				local var_282_8 = arg_279_1.var_.effect1097ui_storykaixinxiaokun1
				local var_282_9
				local var_282_10 = var_282_6

				if not var_282_8 then
					var_282_8 = Object.Instantiate(Asset.Load("Effect/Hero/1097/fx_1097_story_smoke"), var_282_10)
					var_282_8.name = "kaixinxiaokun1"
					arg_279_1.var_.effect1097ui_storykaixinxiaokun1 = var_282_8
				else
					var_282_8.transform:SetParent(var_282_10)
				end

				var_282_8.transform.localPosition = Vector3.New(0, 1.28, 0.3)
				var_282_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_282_11 = arg_279_1.actors_["1097ui_story"].transform
			local var_282_12 = 2

			if var_282_12 < arg_279_1.time_ and arg_279_1.time_ <= var_282_12 + arg_282_0 then
				local var_282_13 = arg_279_1.var_.effect1097ui_storykaixinxiaokun1

				if var_282_13 then
					Object.Destroy(var_282_13)

					arg_279_1.var_.effect1097ui_storykaixinxiaokun1 = nil
				end
			end

			local var_282_14 = 0
			local var_282_15 = 0.275

			if var_282_14 < arg_279_1.time_ and arg_279_1.time_ <= var_282_14 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_16 = arg_279_1:FormatText(StoryNameCfg[216].name)

				arg_279_1.leftNameTxt_.text = var_282_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_17 = arg_279_1:GetWordFromCfg(1109703067)
				local var_282_18 = arg_279_1:FormatText(var_282_17.content)

				arg_279_1.text_.text = var_282_18

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_19 = 11
				local var_282_20 = utf8.len(var_282_18)
				local var_282_21 = var_282_19 <= 0 and var_282_15 or var_282_15 * (var_282_20 / var_282_19)

				if var_282_21 > 0 and var_282_15 < var_282_21 then
					arg_279_1.talkMaxDuration = var_282_21

					if var_282_21 + var_282_14 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_21 + var_282_14
					end
				end

				arg_279_1.text_.text = var_282_18
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703067", "story_v_side_new_1109703.awb") ~= 0 then
					local var_282_22 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703067", "story_v_side_new_1109703.awb") / 1000

					if var_282_22 + var_282_14 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_22 + var_282_14
					end

					if var_282_17.prefab_name ~= "" and arg_279_1.actors_[var_282_17.prefab_name] ~= nil then
						local var_282_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_17.prefab_name].transform, "story_v_side_new_1109703", "1109703067", "story_v_side_new_1109703.awb")

						arg_279_1:RecordAudio("1109703067", var_282_23)
						arg_279_1:RecordAudio("1109703067", var_282_23)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703067", "story_v_side_new_1109703.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703067", "story_v_side_new_1109703.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_24 = math.max(var_282_15, arg_279_1.talkMaxDuration)

			if var_282_14 <= arg_279_1.time_ and arg_279_1.time_ < var_282_14 + var_282_24 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_14) / var_282_24

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_14 + var_282_24 and arg_279_1.time_ < var_282_14 + var_282_24 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1109703068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1109703068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1109703069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1097ui_story"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1097ui_story == nil then
				arg_283_1.var_.characterEffect1097ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.characterEffect1097ui_story and not isNil(var_286_0) then
					local var_286_4 = Mathf.Lerp(0, 0.5, var_286_3)

					arg_283_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1097ui_story.fillRatio = var_286_4
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1097ui_story then
				local var_286_5 = 0.5

				arg_283_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1097ui_story.fillRatio = var_286_5
			end

			local var_286_6 = 0
			local var_286_7 = 1.075

			if var_286_6 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_8 = arg_283_1:FormatText(StoryNameCfg[7].name)

				arg_283_1.leftNameTxt_.text = var_286_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_9 = arg_283_1:GetWordFromCfg(1109703068)
				local var_286_10 = arg_283_1:FormatText(var_286_9.content)

				arg_283_1.text_.text = var_286_10

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 43
				local var_286_12 = utf8.len(var_286_10)
				local var_286_13 = var_286_11 <= 0 and var_286_7 or var_286_7 * (var_286_12 / var_286_11)

				if var_286_13 > 0 and var_286_7 < var_286_13 then
					arg_283_1.talkMaxDuration = var_286_13

					if var_286_13 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_10
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_14 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_14 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_14

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_14 and arg_283_1.time_ < var_286_6 + var_286_14 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1109703069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1109703069
		arg_287_1.duration_ = 6.9

		local var_287_0 = {
			zh = 6.9,
			ja = 5.7
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1109703070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1097ui_story"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1097ui_story == nil then
				arg_287_1.var_.characterEffect1097ui_story = var_290_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.characterEffect1097ui_story and not isNil(var_290_0) then
					arg_287_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1097ui_story then
				arg_287_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_290_4 = 0

			if var_290_4 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_290_5 = 0

			if var_290_5 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 then
				arg_287_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_290_6 = 0
			local var_290_7 = 0.6

			if var_290_6 < arg_287_1.time_ and arg_287_1.time_ <= var_290_6 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_8 = arg_287_1:FormatText(StoryNameCfg[216].name)

				arg_287_1.leftNameTxt_.text = var_290_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_9 = arg_287_1:GetWordFromCfg(1109703069)
				local var_290_10 = arg_287_1:FormatText(var_290_9.content)

				arg_287_1.text_.text = var_290_10

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_11 = 24
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703069", "story_v_side_new_1109703.awb") ~= 0 then
					local var_290_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703069", "story_v_side_new_1109703.awb") / 1000

					if var_290_14 + var_290_6 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_14 + var_290_6
					end

					if var_290_9.prefab_name ~= "" and arg_287_1.actors_[var_290_9.prefab_name] ~= nil then
						local var_290_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_9.prefab_name].transform, "story_v_side_new_1109703", "1109703069", "story_v_side_new_1109703.awb")

						arg_287_1:RecordAudio("1109703069", var_290_15)
						arg_287_1:RecordAudio("1109703069", var_290_15)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703069", "story_v_side_new_1109703.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703069", "story_v_side_new_1109703.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_16 = math.max(var_290_7, arg_287_1.talkMaxDuration)

			if var_290_6 <= arg_287_1.time_ and arg_287_1.time_ < var_290_6 + var_290_16 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_6) / var_290_16

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_6 + var_290_16 and arg_287_1.time_ < var_290_6 + var_290_16 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1109703070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1109703070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1109703071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1097ui_story"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1097ui_story == nil then
				arg_291_1.var_.characterEffect1097ui_story = var_294_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.characterEffect1097ui_story and not isNil(var_294_0) then
					local var_294_4 = Mathf.Lerp(0, 0.5, var_294_3)

					arg_291_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1097ui_story.fillRatio = var_294_4
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1097ui_story then
				local var_294_5 = 0.5

				arg_291_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1097ui_story.fillRatio = var_294_5
			end

			local var_294_6 = 0
			local var_294_7 = 0.775

			if var_294_6 < arg_291_1.time_ and arg_291_1.time_ <= var_294_6 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_8 = arg_291_1:FormatText(StoryNameCfg[7].name)

				arg_291_1.leftNameTxt_.text = var_294_8

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

				local var_294_9 = arg_291_1:GetWordFromCfg(1109703070)
				local var_294_10 = arg_291_1:FormatText(var_294_9.content)

				arg_291_1.text_.text = var_294_10

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_11 = 31
				local var_294_12 = utf8.len(var_294_10)
				local var_294_13 = var_294_11 <= 0 and var_294_7 or var_294_7 * (var_294_12 / var_294_11)

				if var_294_13 > 0 and var_294_7 < var_294_13 then
					arg_291_1.talkMaxDuration = var_294_13

					if var_294_13 + var_294_6 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_13 + var_294_6
					end
				end

				arg_291_1.text_.text = var_294_10
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_14 = math.max(var_294_7, arg_291_1.talkMaxDuration)

			if var_294_6 <= arg_291_1.time_ and arg_291_1.time_ < var_294_6 + var_294_14 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_6) / var_294_14

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_6 + var_294_14 and arg_291_1.time_ < var_294_6 + var_294_14 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1109703071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1109703071
		arg_295_1.duration_ = 3.8

		local var_295_0 = {
			zh = 3.8,
			ja = 3.1
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
				arg_295_0:Play1109703072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1097ui_story"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect1097ui_story == nil then
				arg_295_1.var_.characterEffect1097ui_story = var_298_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.characterEffect1097ui_story and not isNil(var_298_0) then
					arg_295_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect1097ui_story then
				arg_295_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_298_4 = 0

			if var_298_4 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_298_5 = 0

			if var_298_5 < arg_295_1.time_ and arg_295_1.time_ <= var_298_5 + arg_298_0 then
				arg_295_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_298_6 = 0
			local var_298_7 = 0.3

			if var_298_6 < arg_295_1.time_ and arg_295_1.time_ <= var_298_6 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_8 = arg_295_1:FormatText(StoryNameCfg[216].name)

				arg_295_1.leftNameTxt_.text = var_298_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_9 = arg_295_1:GetWordFromCfg(1109703071)
				local var_298_10 = arg_295_1:FormatText(var_298_9.content)

				arg_295_1.text_.text = var_298_10

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_11 = 12
				local var_298_12 = utf8.len(var_298_10)
				local var_298_13 = var_298_11 <= 0 and var_298_7 or var_298_7 * (var_298_12 / var_298_11)

				if var_298_13 > 0 and var_298_7 < var_298_13 then
					arg_295_1.talkMaxDuration = var_298_13

					if var_298_13 + var_298_6 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_13 + var_298_6
					end
				end

				arg_295_1.text_.text = var_298_10
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703071", "story_v_side_new_1109703.awb") ~= 0 then
					local var_298_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703071", "story_v_side_new_1109703.awb") / 1000

					if var_298_14 + var_298_6 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_14 + var_298_6
					end

					if var_298_9.prefab_name ~= "" and arg_295_1.actors_[var_298_9.prefab_name] ~= nil then
						local var_298_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_9.prefab_name].transform, "story_v_side_new_1109703", "1109703071", "story_v_side_new_1109703.awb")

						arg_295_1:RecordAudio("1109703071", var_298_15)
						arg_295_1:RecordAudio("1109703071", var_298_15)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703071", "story_v_side_new_1109703.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703071", "story_v_side_new_1109703.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_16 = math.max(var_298_7, arg_295_1.talkMaxDuration)

			if var_298_6 <= arg_295_1.time_ and arg_295_1.time_ < var_298_6 + var_298_16 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_6) / var_298_16

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_6 + var_298_16 and arg_295_1.time_ < var_298_6 + var_298_16 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1109703072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1109703072
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1109703073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1097ui_story"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1097ui_story == nil then
				arg_299_1.var_.characterEffect1097ui_story = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.characterEffect1097ui_story and not isNil(var_302_0) then
					local var_302_4 = Mathf.Lerp(0, 0.5, var_302_3)

					arg_299_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1097ui_story.fillRatio = var_302_4
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1097ui_story then
				local var_302_5 = 0.5

				arg_299_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1097ui_story.fillRatio = var_302_5
			end

			local var_302_6 = 0
			local var_302_7 = 1.6

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

				local var_302_9 = arg_299_1:GetWordFromCfg(1109703072)
				local var_302_10 = arg_299_1:FormatText(var_302_9.content)

				arg_299_1.text_.text = var_302_10

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_11 = 64
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
	Play1109703073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1109703073
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1109703074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 0.3

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_2 = arg_303_1:FormatText(StoryNameCfg[7].name)

				arg_303_1.leftNameTxt_.text = var_306_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_3 = arg_303_1:GetWordFromCfg(1109703073)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 12
				local var_306_6 = utf8.len(var_306_4)
				local var_306_7 = var_306_5 <= 0 and var_306_1 or var_306_1 * (var_306_6 / var_306_5)

				if var_306_7 > 0 and var_306_1 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_8 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_8 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_8

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_8 and arg_303_1.time_ < var_306_0 + var_306_8 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1109703074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1109703074
		arg_307_1.duration_ = 7.7

		local var_307_0 = {
			zh = 5.866,
			ja = 7.7
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
				arg_307_0:Play1109703075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1097ui_story"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1097ui_story == nil then
				arg_307_1.var_.characterEffect1097ui_story = var_310_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.characterEffect1097ui_story and not isNil(var_310_0) then
					arg_307_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1097ui_story then
				arg_307_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_310_4 = 0

			if var_310_4 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_310_5 = 0

			if var_310_5 < arg_307_1.time_ and arg_307_1.time_ <= var_310_5 + arg_310_0 then
				arg_307_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_310_6 = 0
			local var_310_7 = 0.775

			if var_310_6 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_8 = arg_307_1:FormatText(StoryNameCfg[216].name)

				arg_307_1.leftNameTxt_.text = var_310_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_9 = arg_307_1:GetWordFromCfg(1109703074)
				local var_310_10 = arg_307_1:FormatText(var_310_9.content)

				arg_307_1.text_.text = var_310_10

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_11 = 31
				local var_310_12 = utf8.len(var_310_10)
				local var_310_13 = var_310_11 <= 0 and var_310_7 or var_310_7 * (var_310_12 / var_310_11)

				if var_310_13 > 0 and var_310_7 < var_310_13 then
					arg_307_1.talkMaxDuration = var_310_13

					if var_310_13 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_13 + var_310_6
					end
				end

				arg_307_1.text_.text = var_310_10
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703074", "story_v_side_new_1109703.awb") ~= 0 then
					local var_310_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703074", "story_v_side_new_1109703.awb") / 1000

					if var_310_14 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_14 + var_310_6
					end

					if var_310_9.prefab_name ~= "" and arg_307_1.actors_[var_310_9.prefab_name] ~= nil then
						local var_310_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_9.prefab_name].transform, "story_v_side_new_1109703", "1109703074", "story_v_side_new_1109703.awb")

						arg_307_1:RecordAudio("1109703074", var_310_15)
						arg_307_1:RecordAudio("1109703074", var_310_15)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703074", "story_v_side_new_1109703.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703074", "story_v_side_new_1109703.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_16 = math.max(var_310_7, arg_307_1.talkMaxDuration)

			if var_310_6 <= arg_307_1.time_ and arg_307_1.time_ < var_310_6 + var_310_16 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_6) / var_310_16

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_6 + var_310_16 and arg_307_1.time_ < var_310_6 + var_310_16 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1109703075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1109703075
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1109703076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1097ui_story"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1097ui_story == nil then
				arg_311_1.var_.characterEffect1097ui_story = var_314_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.characterEffect1097ui_story and not isNil(var_314_0) then
					local var_314_4 = Mathf.Lerp(0, 0.5, var_314_3)

					arg_311_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1097ui_story.fillRatio = var_314_4
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1097ui_story then
				local var_314_5 = 0.5

				arg_311_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1097ui_story.fillRatio = var_314_5
			end

			local var_314_6 = 0
			local var_314_7 = 0.25

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

				local var_314_9 = arg_311_1:GetWordFromCfg(1109703075)
				local var_314_10 = arg_311_1:FormatText(var_314_9.content)

				arg_311_1.text_.text = var_314_10

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_11 = 10
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
	Play1109703076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1109703076
		arg_315_1.duration_ = 14.17

		local var_315_0 = {
			zh = 11.4330000029802,
			ja = 14.1660000029802
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1109703077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 2

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				local var_318_1 = manager.ui.mainCamera.transform.localPosition
				local var_318_2 = Vector3.New(0, 0, 10) + Vector3.New(var_318_1.x, var_318_1.y, 0)
				local var_318_3 = arg_315_1.bgs_.ST12

				var_318_3.transform.localPosition = var_318_2
				var_318_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_318_4 = var_318_3:GetComponent("SpriteRenderer")

				if var_318_4 and var_318_4.sprite then
					local var_318_5 = (var_318_3.transform.localPosition - var_318_1).z
					local var_318_6 = manager.ui.mainCameraCom_
					local var_318_7 = 2 * var_318_5 * Mathf.Tan(var_318_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_318_8 = var_318_7 * var_318_6.aspect
					local var_318_9 = var_318_4.sprite.bounds.size.x
					local var_318_10 = var_318_4.sprite.bounds.size.y
					local var_318_11 = var_318_8 / var_318_9
					local var_318_12 = var_318_7 / var_318_10
					local var_318_13 = var_318_12 < var_318_11 and var_318_11 or var_318_12

					var_318_3.transform.localScale = Vector3.New(var_318_13, var_318_13, 0)
				end

				for iter_318_0, iter_318_1 in pairs(arg_315_1.bgs_) do
					if iter_318_0 ~= "ST12" then
						iter_318_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_318_14 = 0

			if var_318_14 < arg_315_1.time_ and arg_315_1.time_ <= var_318_14 + arg_318_0 then
				arg_315_1.mask_.enabled = true
				arg_315_1.mask_.raycastTarget = true

				arg_315_1:SetGaussion(false)
			end

			local var_318_15 = 2

			if var_318_14 <= arg_315_1.time_ and arg_315_1.time_ < var_318_14 + var_318_15 then
				local var_318_16 = (arg_315_1.time_ - var_318_14) / var_318_15
				local var_318_17 = Color.New(1, 1, 1)

				var_318_17.a = Mathf.Lerp(0, 1, var_318_16)
				arg_315_1.mask_.color = var_318_17
			end

			if arg_315_1.time_ >= var_318_14 + var_318_15 and arg_315_1.time_ < var_318_14 + var_318_15 + arg_318_0 then
				local var_318_18 = Color.New(1, 1, 1)

				var_318_18.a = 1
				arg_315_1.mask_.color = var_318_18
			end

			local var_318_19 = 2

			if var_318_19 < arg_315_1.time_ and arg_315_1.time_ <= var_318_19 + arg_318_0 then
				arg_315_1.mask_.enabled = true
				arg_315_1.mask_.raycastTarget = true

				arg_315_1:SetGaussion(false)
			end

			local var_318_20 = 2

			if var_318_19 <= arg_315_1.time_ and arg_315_1.time_ < var_318_19 + var_318_20 then
				local var_318_21 = (arg_315_1.time_ - var_318_19) / var_318_20
				local var_318_22 = Color.New(1, 1, 1)

				var_318_22.a = Mathf.Lerp(1, 0, var_318_21)
				arg_315_1.mask_.color = var_318_22
			end

			if arg_315_1.time_ >= var_318_19 + var_318_20 and arg_315_1.time_ < var_318_19 + var_318_20 + arg_318_0 then
				local var_318_23 = Color.New(1, 1, 1)
				local var_318_24 = 0

				arg_315_1.mask_.enabled = false
				var_318_23.a = var_318_24
				arg_315_1.mask_.color = var_318_23
			end

			local var_318_25 = arg_315_1.actors_["1097ui_story"].transform
			local var_318_26 = 1.96599999815226

			if var_318_26 < arg_315_1.time_ and arg_315_1.time_ <= var_318_26 + arg_318_0 then
				arg_315_1.var_.moveOldPos1097ui_story = var_318_25.localPosition
			end

			local var_318_27 = 0.001

			if var_318_26 <= arg_315_1.time_ and arg_315_1.time_ < var_318_26 + var_318_27 then
				local var_318_28 = (arg_315_1.time_ - var_318_26) / var_318_27
				local var_318_29 = Vector3.New(0, 100, 0)

				var_318_25.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1097ui_story, var_318_29, var_318_28)

				local var_318_30 = manager.ui.mainCamera.transform.position - var_318_25.position

				var_318_25.forward = Vector3.New(var_318_30.x, var_318_30.y, var_318_30.z)

				local var_318_31 = var_318_25.localEulerAngles

				var_318_31.z = 0
				var_318_31.x = 0
				var_318_25.localEulerAngles = var_318_31
			end

			if arg_315_1.time_ >= var_318_26 + var_318_27 and arg_315_1.time_ < var_318_26 + var_318_27 + arg_318_0 then
				var_318_25.localPosition = Vector3.New(0, 100, 0)

				local var_318_32 = manager.ui.mainCamera.transform.position - var_318_25.position

				var_318_25.forward = Vector3.New(var_318_32.x, var_318_32.y, var_318_32.z)

				local var_318_33 = var_318_25.localEulerAngles

				var_318_33.z = 0
				var_318_33.x = 0
				var_318_25.localEulerAngles = var_318_33
			end

			local var_318_34 = arg_315_1.actors_["1097ui_story"]
			local var_318_35 = 1.96599999815226

			if var_318_35 < arg_315_1.time_ and arg_315_1.time_ <= var_318_35 + arg_318_0 and not isNil(var_318_34) and arg_315_1.var_.characterEffect1097ui_story == nil then
				arg_315_1.var_.characterEffect1097ui_story = var_318_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_36 = 0.034000001847744

			if var_318_35 <= arg_315_1.time_ and arg_315_1.time_ < var_318_35 + var_318_36 and not isNil(var_318_34) then
				local var_318_37 = (arg_315_1.time_ - var_318_35) / var_318_36

				if arg_315_1.var_.characterEffect1097ui_story and not isNil(var_318_34) then
					local var_318_38 = Mathf.Lerp(0, 0.5, var_318_37)

					arg_315_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1097ui_story.fillRatio = var_318_38
				end
			end

			if arg_315_1.time_ >= var_318_35 + var_318_36 and arg_315_1.time_ < var_318_35 + var_318_36 + arg_318_0 and not isNil(var_318_34) and arg_315_1.var_.characterEffect1097ui_story then
				local var_318_39 = 0.5

				arg_315_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1097ui_story.fillRatio = var_318_39
			end

			local var_318_40 = arg_315_1.actors_["1019ui_story"].transform
			local var_318_41 = 3.8

			if var_318_41 < arg_315_1.time_ and arg_315_1.time_ <= var_318_41 + arg_318_0 then
				arg_315_1.var_.moveOldPos1019ui_story = var_318_40.localPosition
			end

			local var_318_42 = 0.001

			if var_318_41 <= arg_315_1.time_ and arg_315_1.time_ < var_318_41 + var_318_42 then
				local var_318_43 = (arg_315_1.time_ - var_318_41) / var_318_42
				local var_318_44 = Vector3.New(-0.2, -1.08, -5.9)

				var_318_40.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1019ui_story, var_318_44, var_318_43)

				local var_318_45 = manager.ui.mainCamera.transform.position - var_318_40.position

				var_318_40.forward = Vector3.New(var_318_45.x, var_318_45.y, var_318_45.z)

				local var_318_46 = var_318_40.localEulerAngles

				var_318_46.z = 0
				var_318_46.x = 0
				var_318_40.localEulerAngles = var_318_46
			end

			if arg_315_1.time_ >= var_318_41 + var_318_42 and arg_315_1.time_ < var_318_41 + var_318_42 + arg_318_0 then
				var_318_40.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_318_47 = manager.ui.mainCamera.transform.position - var_318_40.position

				var_318_40.forward = Vector3.New(var_318_47.x, var_318_47.y, var_318_47.z)

				local var_318_48 = var_318_40.localEulerAngles

				var_318_48.z = 0
				var_318_48.x = 0
				var_318_40.localEulerAngles = var_318_48
			end

			local var_318_49 = arg_315_1.actors_["1019ui_story"]
			local var_318_50 = 3.8

			if var_318_50 < arg_315_1.time_ and arg_315_1.time_ <= var_318_50 + arg_318_0 and not isNil(var_318_49) and arg_315_1.var_.characterEffect1019ui_story == nil then
				arg_315_1.var_.characterEffect1019ui_story = var_318_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_51 = 0.200000002980232

			if var_318_50 <= arg_315_1.time_ and arg_315_1.time_ < var_318_50 + var_318_51 and not isNil(var_318_49) then
				local var_318_52 = (arg_315_1.time_ - var_318_50) / var_318_51

				if arg_315_1.var_.characterEffect1019ui_story and not isNil(var_318_49) then
					arg_315_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= var_318_50 + var_318_51 and arg_315_1.time_ < var_318_50 + var_318_51 + arg_318_0 and not isNil(var_318_49) and arg_315_1.var_.characterEffect1019ui_story then
				arg_315_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_318_53 = 3.8

			if var_318_53 < arg_315_1.time_ and arg_315_1.time_ <= var_318_53 + arg_318_0 then
				arg_315_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_318_54 = 3.8

			if var_318_54 < arg_315_1.time_ and arg_315_1.time_ <= var_318_54 + arg_318_0 then
				arg_315_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_318_55 = arg_315_1.actors_["1019ui_story"]
			local var_318_56 = 3.8
			local var_318_57 = 0.200000002980232

			if var_318_56 < arg_315_1.time_ and arg_315_1.time_ <= var_318_56 + arg_318_0 then
				if arg_315_1.var_.characterEffect1019ui_story == nil then
					arg_315_1.var_.characterEffect1019ui_story = var_318_55:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_315_1.var_.characterEffect1019ui_story.imageEffect:turnOn(false)
			end

			local var_318_58 = arg_315_1.actors_["1019ui_story"]
			local var_318_59 = 3.8

			if var_318_59 < arg_315_1.time_ and arg_315_1.time_ <= var_318_59 + arg_318_0 then
				if arg_315_1.var_.characterEffect1019ui_story == nil then
					arg_315_1.var_.characterEffect1019ui_story = var_318_58:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_318_60 = arg_315_1.var_.characterEffect1019ui_story

				var_318_60.imageEffect:turnOff()

				var_318_60.interferenceEffect.enabled = true
				var_318_60.interferenceEffect.noise = 0.001
				var_318_60.interferenceEffect.simTimeScale = 1
				var_318_60.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if arg_315_1.frameCnt_ <= 1 then
				arg_315_1.dialog_:SetActive(false)
			end

			local var_318_61 = 4.00000000298023
			local var_318_62 = 1.05

			if var_318_61 < arg_315_1.time_ and arg_315_1.time_ <= var_318_61 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0

				arg_315_1.dialog_:SetActive(true)

				arg_315_1.dialogCg_.alpha = 0

				local var_318_63 = LeanTween.value(arg_315_1.dialog_, 0, 1, 0.3)

				var_318_63:setOnUpdate(LuaHelper.FloatAction(function(arg_319_0)
					arg_315_1.dialogCg_.alpha = arg_319_0
				end))
				var_318_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_315_1.dialog_)
					var_318_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_315_1.duration_ = arg_315_1.duration_ + 0.3

				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_64 = arg_315_1:FormatText(StoryNameCfg[13].name)

				arg_315_1.leftNameTxt_.text = var_318_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_65 = arg_315_1:GetWordFromCfg(1109703076)
				local var_318_66 = arg_315_1:FormatText(var_318_65.content)

				arg_315_1.text_.text = var_318_66

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_67 = 42
				local var_318_68 = utf8.len(var_318_66)
				local var_318_69 = var_318_67 <= 0 and var_318_62 or var_318_62 * (var_318_68 / var_318_67)

				if var_318_69 > 0 and var_318_62 < var_318_69 then
					arg_315_1.talkMaxDuration = var_318_69
					var_318_61 = var_318_61 + 0.3

					if var_318_69 + var_318_61 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_69 + var_318_61
					end
				end

				arg_315_1.text_.text = var_318_66
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703076", "story_v_side_new_1109703.awb") ~= 0 then
					local var_318_70 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703076", "story_v_side_new_1109703.awb") / 1000

					if var_318_70 + var_318_61 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_70 + var_318_61
					end

					if var_318_65.prefab_name ~= "" and arg_315_1.actors_[var_318_65.prefab_name] ~= nil then
						local var_318_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_65.prefab_name].transform, "story_v_side_new_1109703", "1109703076", "story_v_side_new_1109703.awb")

						arg_315_1:RecordAudio("1109703076", var_318_71)
						arg_315_1:RecordAudio("1109703076", var_318_71)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703076", "story_v_side_new_1109703.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703076", "story_v_side_new_1109703.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_72 = var_318_61 + 0.3
			local var_318_73 = math.max(var_318_62, arg_315_1.talkMaxDuration)

			if var_318_72 <= arg_315_1.time_ and arg_315_1.time_ < var_318_72 + var_318_73 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_72) / var_318_73

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_72 + var_318_73 and arg_315_1.time_ < var_318_72 + var_318_73 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play1109703077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1109703077
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1109703078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1019ui_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1019ui_story == nil then
				arg_321_1.var_.characterEffect1019ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect1019ui_story and not isNil(var_324_0) then
					local var_324_4 = Mathf.Lerp(0, 0.5, var_324_3)

					arg_321_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1019ui_story.fillRatio = var_324_4
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1019ui_story then
				local var_324_5 = 0.5

				arg_321_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1019ui_story.fillRatio = var_324_5
			end

			local var_324_6 = 0
			local var_324_7 = 0.1

			if var_324_6 < arg_321_1.time_ and arg_321_1.time_ <= var_324_6 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_8 = arg_321_1:FormatText(StoryNameCfg[7].name)

				arg_321_1.leftNameTxt_.text = var_324_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_9 = arg_321_1:GetWordFromCfg(1109703077)
				local var_324_10 = arg_321_1:FormatText(var_324_9.content)

				arg_321_1.text_.text = var_324_10

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_11 = 4
				local var_324_12 = utf8.len(var_324_10)
				local var_324_13 = var_324_11 <= 0 and var_324_7 or var_324_7 * (var_324_12 / var_324_11)

				if var_324_13 > 0 and var_324_7 < var_324_13 then
					arg_321_1.talkMaxDuration = var_324_13

					if var_324_13 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_6
					end
				end

				arg_321_1.text_.text = var_324_10
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_14 = math.max(var_324_7, arg_321_1.talkMaxDuration)

			if var_324_6 <= arg_321_1.time_ and arg_321_1.time_ < var_324_6 + var_324_14 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_6) / var_324_14

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_6 + var_324_14 and arg_321_1.time_ < var_324_6 + var_324_14 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1109703078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1109703078
		arg_325_1.duration_ = 7.4

		local var_325_0 = {
			zh = 6.066,
			ja = 7.4
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1109703079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1019ui_story"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1019ui_story == nil then
				arg_325_1.var_.characterEffect1019ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.characterEffect1019ui_story and not isNil(var_328_0) then
					arg_325_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1019ui_story then
				arg_325_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_328_4 = 0

			if var_328_4 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			local var_328_5 = 0

			if var_328_5 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				arg_325_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_328_6 = 0
			local var_328_7 = 0.9

			if var_328_6 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_8 = arg_325_1:FormatText(StoryNameCfg[13].name)

				arg_325_1.leftNameTxt_.text = var_328_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_9 = arg_325_1:GetWordFromCfg(1109703078)
				local var_328_10 = arg_325_1:FormatText(var_328_9.content)

				arg_325_1.text_.text = var_328_10

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_11 = 36
				local var_328_12 = utf8.len(var_328_10)
				local var_328_13 = var_328_11 <= 0 and var_328_7 or var_328_7 * (var_328_12 / var_328_11)

				if var_328_13 > 0 and var_328_7 < var_328_13 then
					arg_325_1.talkMaxDuration = var_328_13

					if var_328_13 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_13 + var_328_6
					end
				end

				arg_325_1.text_.text = var_328_10
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703078", "story_v_side_new_1109703.awb") ~= 0 then
					local var_328_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703078", "story_v_side_new_1109703.awb") / 1000

					if var_328_14 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_14 + var_328_6
					end

					if var_328_9.prefab_name ~= "" and arg_325_1.actors_[var_328_9.prefab_name] ~= nil then
						local var_328_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_9.prefab_name].transform, "story_v_side_new_1109703", "1109703078", "story_v_side_new_1109703.awb")

						arg_325_1:RecordAudio("1109703078", var_328_15)
						arg_325_1:RecordAudio("1109703078", var_328_15)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703078", "story_v_side_new_1109703.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703078", "story_v_side_new_1109703.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_16 = math.max(var_328_7, arg_325_1.talkMaxDuration)

			if var_328_6 <= arg_325_1.time_ and arg_325_1.time_ < var_328_6 + var_328_16 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_6) / var_328_16

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_6 + var_328_16 and arg_325_1.time_ < var_328_6 + var_328_16 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1109703079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1109703079
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1109703080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1019ui_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1019ui_story == nil then
				arg_329_1.var_.characterEffect1019ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect1019ui_story and not isNil(var_332_0) then
					local var_332_4 = Mathf.Lerp(0, 0.5, var_332_3)

					arg_329_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1019ui_story.fillRatio = var_332_4
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1019ui_story then
				local var_332_5 = 0.5

				arg_329_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1019ui_story.fillRatio = var_332_5
			end

			local var_332_6 = 0
			local var_332_7 = 0.1

			if var_332_6 < arg_329_1.time_ and arg_329_1.time_ <= var_332_6 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_8 = arg_329_1:FormatText(StoryNameCfg[7].name)

				arg_329_1.leftNameTxt_.text = var_332_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_9 = arg_329_1:GetWordFromCfg(1109703079)
				local var_332_10 = arg_329_1:FormatText(var_332_9.content)

				arg_329_1.text_.text = var_332_10

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_11 = 4
				local var_332_12 = utf8.len(var_332_10)
				local var_332_13 = var_332_11 <= 0 and var_332_7 or var_332_7 * (var_332_12 / var_332_11)

				if var_332_13 > 0 and var_332_7 < var_332_13 then
					arg_329_1.talkMaxDuration = var_332_13

					if var_332_13 + var_332_6 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_6
					end
				end

				arg_329_1.text_.text = var_332_10
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_14 = math.max(var_332_7, arg_329_1.talkMaxDuration)

			if var_332_6 <= arg_329_1.time_ and arg_329_1.time_ < var_332_6 + var_332_14 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_6) / var_332_14

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_6 + var_332_14 and arg_329_1.time_ < var_332_6 + var_332_14 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1109703080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1109703080
		arg_333_1.duration_ = 7.07

		local var_333_0 = {
			zh = 5.799999999999,
			ja = 7.066
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1109703081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 2.00000000298023

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				local var_336_1 = manager.ui.mainCamera.transform.localPosition
				local var_336_2 = Vector3.New(0, 0, 10) + Vector3.New(var_336_1.x, var_336_1.y, 0)
				local var_336_3 = arg_333_1.bgs_.ST12

				var_336_3.transform.localPosition = var_336_2
				var_336_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_336_4 = var_336_3:GetComponent("SpriteRenderer")

				if var_336_4 and var_336_4.sprite then
					local var_336_5 = (var_336_3.transform.localPosition - var_336_1).z
					local var_336_6 = manager.ui.mainCameraCom_
					local var_336_7 = 2 * var_336_5 * Mathf.Tan(var_336_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_336_8 = var_336_7 * var_336_6.aspect
					local var_336_9 = var_336_4.sprite.bounds.size.x
					local var_336_10 = var_336_4.sprite.bounds.size.y
					local var_336_11 = var_336_8 / var_336_9
					local var_336_12 = var_336_7 / var_336_10
					local var_336_13 = var_336_12 < var_336_11 and var_336_11 or var_336_12

					var_336_3.transform.localScale = Vector3.New(var_336_13, var_336_13, 0)
				end

				for iter_336_0, iter_336_1 in pairs(arg_333_1.bgs_) do
					if iter_336_0 ~= "ST12" then
						iter_336_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_336_14 = 0

			if var_336_14 < arg_333_1.time_ and arg_333_1.time_ <= var_336_14 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_15 = 2

			if var_336_14 <= arg_333_1.time_ and arg_333_1.time_ < var_336_14 + var_336_15 then
				local var_336_16 = (arg_333_1.time_ - var_336_14) / var_336_15
				local var_336_17 = Color.New(1, 1, 1)

				var_336_17.a = Mathf.Lerp(0, 1, var_336_16)
				arg_333_1.mask_.color = var_336_17
			end

			if arg_333_1.time_ >= var_336_14 + var_336_15 and arg_333_1.time_ < var_336_14 + var_336_15 + arg_336_0 then
				local var_336_18 = Color.New(1, 1, 1)

				var_336_18.a = 1
				arg_333_1.mask_.color = var_336_18
			end

			local var_336_19 = 2

			if var_336_19 < arg_333_1.time_ and arg_333_1.time_ <= var_336_19 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_20 = 2

			if var_336_19 <= arg_333_1.time_ and arg_333_1.time_ < var_336_19 + var_336_20 then
				local var_336_21 = (arg_333_1.time_ - var_336_19) / var_336_20
				local var_336_22 = Color.New(1, 1, 1)

				var_336_22.a = Mathf.Lerp(1, 0, var_336_21)
				arg_333_1.mask_.color = var_336_22
			end

			if arg_333_1.time_ >= var_336_19 + var_336_20 and arg_333_1.time_ < var_336_19 + var_336_20 + arg_336_0 then
				local var_336_23 = Color.New(1, 1, 1)
				local var_336_24 = 0

				arg_333_1.mask_.enabled = false
				var_336_23.a = var_336_24
				arg_333_1.mask_.color = var_336_23
			end

			local var_336_25 = arg_333_1.actors_["1019ui_story"].transform
			local var_336_26 = 1.96599999815226

			if var_336_26 < arg_333_1.time_ and arg_333_1.time_ <= var_336_26 + arg_336_0 then
				arg_333_1.var_.moveOldPos1019ui_story = var_336_25.localPosition
			end

			local var_336_27 = 0.001

			if var_336_26 <= arg_333_1.time_ and arg_333_1.time_ < var_336_26 + var_336_27 then
				local var_336_28 = (arg_333_1.time_ - var_336_26) / var_336_27
				local var_336_29 = Vector3.New(0, 100, 0)

				var_336_25.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1019ui_story, var_336_29, var_336_28)

				local var_336_30 = manager.ui.mainCamera.transform.position - var_336_25.position

				var_336_25.forward = Vector3.New(var_336_30.x, var_336_30.y, var_336_30.z)

				local var_336_31 = var_336_25.localEulerAngles

				var_336_31.z = 0
				var_336_31.x = 0
				var_336_25.localEulerAngles = var_336_31
			end

			if arg_333_1.time_ >= var_336_26 + var_336_27 and arg_333_1.time_ < var_336_26 + var_336_27 + arg_336_0 then
				var_336_25.localPosition = Vector3.New(0, 100, 0)

				local var_336_32 = manager.ui.mainCamera.transform.position - var_336_25.position

				var_336_25.forward = Vector3.New(var_336_32.x, var_336_32.y, var_336_32.z)

				local var_336_33 = var_336_25.localEulerAngles

				var_336_33.z = 0
				var_336_33.x = 0
				var_336_25.localEulerAngles = var_336_33
			end

			local var_336_34 = arg_333_1.actors_["1019ui_story"]
			local var_336_35 = 1.96599999815226

			if var_336_35 < arg_333_1.time_ and arg_333_1.time_ <= var_336_35 + arg_336_0 and not isNil(var_336_34) and arg_333_1.var_.characterEffect1019ui_story == nil then
				arg_333_1.var_.characterEffect1019ui_story = var_336_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_36 = 0.034000001847744

			if var_336_35 <= arg_333_1.time_ and arg_333_1.time_ < var_336_35 + var_336_36 and not isNil(var_336_34) then
				local var_336_37 = (arg_333_1.time_ - var_336_35) / var_336_36

				if arg_333_1.var_.characterEffect1019ui_story and not isNil(var_336_34) then
					local var_336_38 = Mathf.Lerp(0, 0.5, var_336_37)

					arg_333_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1019ui_story.fillRatio = var_336_38
				end
			end

			if arg_333_1.time_ >= var_336_35 + var_336_36 and arg_333_1.time_ < var_336_35 + var_336_36 + arg_336_0 and not isNil(var_336_34) and arg_333_1.var_.characterEffect1019ui_story then
				local var_336_39 = 0.5

				arg_333_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1019ui_story.fillRatio = var_336_39
			end

			local var_336_40 = arg_333_1.actors_["1097ui_story"].transform
			local var_336_41 = 3.8

			if var_336_41 < arg_333_1.time_ and arg_333_1.time_ <= var_336_41 + arg_336_0 then
				arg_333_1.var_.moveOldPos1097ui_story = var_336_40.localPosition
			end

			local var_336_42 = 0.001

			if var_336_41 <= arg_333_1.time_ and arg_333_1.time_ < var_336_41 + var_336_42 then
				local var_336_43 = (arg_333_1.time_ - var_336_41) / var_336_42
				local var_336_44 = Vector3.New(0, -0.54, -6.3)

				var_336_40.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1097ui_story, var_336_44, var_336_43)

				local var_336_45 = manager.ui.mainCamera.transform.position - var_336_40.position

				var_336_40.forward = Vector3.New(var_336_45.x, var_336_45.y, var_336_45.z)

				local var_336_46 = var_336_40.localEulerAngles

				var_336_46.z = 0
				var_336_46.x = 0
				var_336_40.localEulerAngles = var_336_46
			end

			if arg_333_1.time_ >= var_336_41 + var_336_42 and arg_333_1.time_ < var_336_41 + var_336_42 + arg_336_0 then
				var_336_40.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_336_47 = manager.ui.mainCamera.transform.position - var_336_40.position

				var_336_40.forward = Vector3.New(var_336_47.x, var_336_47.y, var_336_47.z)

				local var_336_48 = var_336_40.localEulerAngles

				var_336_48.z = 0
				var_336_48.x = 0
				var_336_40.localEulerAngles = var_336_48
			end

			local var_336_49 = arg_333_1.actors_["1097ui_story"]
			local var_336_50 = 3.8

			if var_336_50 < arg_333_1.time_ and arg_333_1.time_ <= var_336_50 + arg_336_0 and not isNil(var_336_49) and arg_333_1.var_.characterEffect1097ui_story == nil then
				arg_333_1.var_.characterEffect1097ui_story = var_336_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_51 = 0.200000002980232

			if var_336_50 <= arg_333_1.time_ and arg_333_1.time_ < var_336_50 + var_336_51 and not isNil(var_336_49) then
				local var_336_52 = (arg_333_1.time_ - var_336_50) / var_336_51

				if arg_333_1.var_.characterEffect1097ui_story and not isNil(var_336_49) then
					arg_333_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_50 + var_336_51 and arg_333_1.time_ < var_336_50 + var_336_51 + arg_336_0 and not isNil(var_336_49) and arg_333_1.var_.characterEffect1097ui_story then
				arg_333_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_336_53 = 3.8

			if var_336_53 < arg_333_1.time_ and arg_333_1.time_ <= var_336_53 + arg_336_0 then
				arg_333_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_336_54 = 3.8

			if var_336_54 < arg_333_1.time_ and arg_333_1.time_ <= var_336_54 + arg_336_0 then
				arg_333_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_333_1.frameCnt_ <= 1 then
				arg_333_1.dialog_:SetActive(false)
			end

			local var_336_55 = 4
			local var_336_56 = 0.1

			if var_336_55 < arg_333_1.time_ and arg_333_1.time_ <= var_336_55 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0

				arg_333_1.dialog_:SetActive(true)

				arg_333_1.dialogCg_.alpha = 0

				local var_336_57 = LeanTween.value(arg_333_1.dialog_, 0, 1, 0.3)

				var_336_57:setOnUpdate(LuaHelper.FloatAction(function(arg_337_0)
					arg_333_1.dialogCg_.alpha = arg_337_0
				end))
				var_336_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_333_1.dialog_)
					var_336_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_333_1.duration_ = arg_333_1.duration_ + 0.3

				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_58 = arg_333_1:FormatText(StoryNameCfg[216].name)

				arg_333_1.leftNameTxt_.text = var_336_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_59 = arg_333_1:GetWordFromCfg(1109703080)
				local var_336_60 = arg_333_1:FormatText(var_336_59.content)

				arg_333_1.text_.text = var_336_60

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_61 = 4
				local var_336_62 = utf8.len(var_336_60)
				local var_336_63 = var_336_61 <= 0 and var_336_56 or var_336_56 * (var_336_62 / var_336_61)

				if var_336_63 > 0 and var_336_56 < var_336_63 then
					arg_333_1.talkMaxDuration = var_336_63
					var_336_55 = var_336_55 + 0.3

					if var_336_63 + var_336_55 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_63 + var_336_55
					end
				end

				arg_333_1.text_.text = var_336_60
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703080", "story_v_side_new_1109703.awb") ~= 0 then
					local var_336_64 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703080", "story_v_side_new_1109703.awb") / 1000

					if var_336_64 + var_336_55 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_64 + var_336_55
					end

					if var_336_59.prefab_name ~= "" and arg_333_1.actors_[var_336_59.prefab_name] ~= nil then
						local var_336_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_59.prefab_name].transform, "story_v_side_new_1109703", "1109703080", "story_v_side_new_1109703.awb")

						arg_333_1:RecordAudio("1109703080", var_336_65)
						arg_333_1:RecordAudio("1109703080", var_336_65)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703080", "story_v_side_new_1109703.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703080", "story_v_side_new_1109703.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_66 = var_336_55 + 0.3
			local var_336_67 = math.max(var_336_56, arg_333_1.talkMaxDuration)

			if var_336_66 <= arg_333_1.time_ and arg_333_1.time_ < var_336_66 + var_336_67 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_66) / var_336_67

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_66 + var_336_67 and arg_333_1.time_ < var_336_66 + var_336_67 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play1109703081 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1109703081
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1109703082(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1097ui_story"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1097ui_story == nil then
				arg_339_1.var_.characterEffect1097ui_story = var_342_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.characterEffect1097ui_story and not isNil(var_342_0) then
					local var_342_4 = Mathf.Lerp(0, 0.5, var_342_3)

					arg_339_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1097ui_story.fillRatio = var_342_4
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1097ui_story then
				local var_342_5 = 0.5

				arg_339_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1097ui_story.fillRatio = var_342_5
			end

			local var_342_6 = 0
			local var_342_7 = 0.8

			if var_342_6 < arg_339_1.time_ and arg_339_1.time_ <= var_342_6 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_8 = arg_339_1:FormatText(StoryNameCfg[7].name)

				arg_339_1.leftNameTxt_.text = var_342_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_9 = arg_339_1:GetWordFromCfg(1109703081)
				local var_342_10 = arg_339_1:FormatText(var_342_9.content)

				arg_339_1.text_.text = var_342_10

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_11 = 32
				local var_342_12 = utf8.len(var_342_10)
				local var_342_13 = var_342_11 <= 0 and var_342_7 or var_342_7 * (var_342_12 / var_342_11)

				if var_342_13 > 0 and var_342_7 < var_342_13 then
					arg_339_1.talkMaxDuration = var_342_13

					if var_342_13 + var_342_6 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_13 + var_342_6
					end
				end

				arg_339_1.text_.text = var_342_10
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_14 = math.max(var_342_7, arg_339_1.talkMaxDuration)

			if var_342_6 <= arg_339_1.time_ and arg_339_1.time_ < var_342_6 + var_342_14 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_6) / var_342_14

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_6 + var_342_14 and arg_339_1.time_ < var_342_6 + var_342_14 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1109703082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1109703082
		arg_343_1.duration_ = 8.83

		local var_343_0 = {
			zh = 5.233,
			ja = 8.833
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1109703083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1097ui_story"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect1097ui_story == nil then
				arg_343_1.var_.characterEffect1097ui_story = var_346_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.200000002980232

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.characterEffect1097ui_story and not isNil(var_346_0) then
					arg_343_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect1097ui_story then
				arg_343_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_346_4 = 0

			if var_346_4 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_346_5 = 0

			if var_346_5 < arg_343_1.time_ and arg_343_1.time_ <= var_346_5 + arg_346_0 then
				arg_343_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_346_6 = 0
			local var_346_7 = 0.55

			if var_346_6 < arg_343_1.time_ and arg_343_1.time_ <= var_346_6 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_8 = arg_343_1:FormatText(StoryNameCfg[216].name)

				arg_343_1.leftNameTxt_.text = var_346_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_9 = arg_343_1:GetWordFromCfg(1109703082)
				local var_346_10 = arg_343_1:FormatText(var_346_9.content)

				arg_343_1.text_.text = var_346_10

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_11 = 22
				local var_346_12 = utf8.len(var_346_10)
				local var_346_13 = var_346_11 <= 0 and var_346_7 or var_346_7 * (var_346_12 / var_346_11)

				if var_346_13 > 0 and var_346_7 < var_346_13 then
					arg_343_1.talkMaxDuration = var_346_13

					if var_346_13 + var_346_6 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_13 + var_346_6
					end
				end

				arg_343_1.text_.text = var_346_10
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703082", "story_v_side_new_1109703.awb") ~= 0 then
					local var_346_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703082", "story_v_side_new_1109703.awb") / 1000

					if var_346_14 + var_346_6 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_14 + var_346_6
					end

					if var_346_9.prefab_name ~= "" and arg_343_1.actors_[var_346_9.prefab_name] ~= nil then
						local var_346_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_9.prefab_name].transform, "story_v_side_new_1109703", "1109703082", "story_v_side_new_1109703.awb")

						arg_343_1:RecordAudio("1109703082", var_346_15)
						arg_343_1:RecordAudio("1109703082", var_346_15)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703082", "story_v_side_new_1109703.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703082", "story_v_side_new_1109703.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_16 = math.max(var_346_7, arg_343_1.talkMaxDuration)

			if var_346_6 <= arg_343_1.time_ and arg_343_1.time_ < var_346_6 + var_346_16 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_6) / var_346_16

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_6 + var_346_16 and arg_343_1.time_ < var_346_6 + var_346_16 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1109703083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1109703083
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1109703084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1097ui_story"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1097ui_story == nil then
				arg_347_1.var_.characterEffect1097ui_story = var_350_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.200000002980232

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.characterEffect1097ui_story and not isNil(var_350_0) then
					local var_350_4 = Mathf.Lerp(0, 0.5, var_350_3)

					arg_347_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1097ui_story.fillRatio = var_350_4
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1097ui_story then
				local var_350_5 = 0.5

				arg_347_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1097ui_story.fillRatio = var_350_5
			end

			local var_350_6 = 0
			local var_350_7 = 0.575

			if var_350_6 < arg_347_1.time_ and arg_347_1.time_ <= var_350_6 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_8 = arg_347_1:FormatText(StoryNameCfg[7].name)

				arg_347_1.leftNameTxt_.text = var_350_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_9 = arg_347_1:GetWordFromCfg(1109703083)
				local var_350_10 = arg_347_1:FormatText(var_350_9.content)

				arg_347_1.text_.text = var_350_10

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_11 = 23
				local var_350_12 = utf8.len(var_350_10)
				local var_350_13 = var_350_11 <= 0 and var_350_7 or var_350_7 * (var_350_12 / var_350_11)

				if var_350_13 > 0 and var_350_7 < var_350_13 then
					arg_347_1.talkMaxDuration = var_350_13

					if var_350_13 + var_350_6 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_13 + var_350_6
					end
				end

				arg_347_1.text_.text = var_350_10
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_14 = math.max(var_350_7, arg_347_1.talkMaxDuration)

			if var_350_6 <= arg_347_1.time_ and arg_347_1.time_ < var_350_6 + var_350_14 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_6) / var_350_14

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_6 + var_350_14 and arg_347_1.time_ < var_350_6 + var_350_14 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1109703084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1109703084
		arg_351_1.duration_ = 24.13

		local var_351_0 = {
			zh = 16,
			ja = 24.133
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1109703085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1097ui_story"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1097ui_story == nil then
				arg_351_1.var_.characterEffect1097ui_story = var_354_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.characterEffect1097ui_story and not isNil(var_354_0) then
					arg_351_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1097ui_story then
				arg_351_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_354_4 = 0

			if var_354_4 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_354_5 = 0

			if var_354_5 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_354_6 = 0
			local var_354_7 = 1.625

			if var_354_6 < arg_351_1.time_ and arg_351_1.time_ <= var_354_6 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_8 = arg_351_1:FormatText(StoryNameCfg[216].name)

				arg_351_1.leftNameTxt_.text = var_354_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_9 = arg_351_1:GetWordFromCfg(1109703084)
				local var_354_10 = arg_351_1:FormatText(var_354_9.content)

				arg_351_1.text_.text = var_354_10

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_11 = 65
				local var_354_12 = utf8.len(var_354_10)
				local var_354_13 = var_354_11 <= 0 and var_354_7 or var_354_7 * (var_354_12 / var_354_11)

				if var_354_13 > 0 and var_354_7 < var_354_13 then
					arg_351_1.talkMaxDuration = var_354_13

					if var_354_13 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_13 + var_354_6
					end
				end

				arg_351_1.text_.text = var_354_10
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703084", "story_v_side_new_1109703.awb") ~= 0 then
					local var_354_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703084", "story_v_side_new_1109703.awb") / 1000

					if var_354_14 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_14 + var_354_6
					end

					if var_354_9.prefab_name ~= "" and arg_351_1.actors_[var_354_9.prefab_name] ~= nil then
						local var_354_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_9.prefab_name].transform, "story_v_side_new_1109703", "1109703084", "story_v_side_new_1109703.awb")

						arg_351_1:RecordAudio("1109703084", var_354_15)
						arg_351_1:RecordAudio("1109703084", var_354_15)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703084", "story_v_side_new_1109703.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703084", "story_v_side_new_1109703.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_16 = math.max(var_354_7, arg_351_1.talkMaxDuration)

			if var_354_6 <= arg_351_1.time_ and arg_351_1.time_ < var_354_6 + var_354_16 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_6) / var_354_16

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_6 + var_354_16 and arg_351_1.time_ < var_354_6 + var_354_16 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1109703085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1109703085
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1109703086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1097ui_story"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1097ui_story == nil then
				arg_355_1.var_.characterEffect1097ui_story = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.characterEffect1097ui_story and not isNil(var_358_0) then
					local var_358_4 = Mathf.Lerp(0, 0.5, var_358_3)

					arg_355_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1097ui_story.fillRatio = var_358_4
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1097ui_story then
				local var_358_5 = 0.5

				arg_355_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1097ui_story.fillRatio = var_358_5
			end

			local var_358_6 = 0
			local var_358_7 = 0.4

			if var_358_6 < arg_355_1.time_ and arg_355_1.time_ <= var_358_6 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_8 = arg_355_1:FormatText(StoryNameCfg[7].name)

				arg_355_1.leftNameTxt_.text = var_358_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_9 = arg_355_1:GetWordFromCfg(1109703085)
				local var_358_10 = arg_355_1:FormatText(var_358_9.content)

				arg_355_1.text_.text = var_358_10

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_11 = 16
				local var_358_12 = utf8.len(var_358_10)
				local var_358_13 = var_358_11 <= 0 and var_358_7 or var_358_7 * (var_358_12 / var_358_11)

				if var_358_13 > 0 and var_358_7 < var_358_13 then
					arg_355_1.talkMaxDuration = var_358_13

					if var_358_13 + var_358_6 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_13 + var_358_6
					end
				end

				arg_355_1.text_.text = var_358_10
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_14 = math.max(var_358_7, arg_355_1.talkMaxDuration)

			if var_358_6 <= arg_355_1.time_ and arg_355_1.time_ < var_358_6 + var_358_14 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_6) / var_358_14

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_6 + var_358_14 and arg_355_1.time_ < var_358_6 + var_358_14 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1109703086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1109703086
		arg_359_1.duration_ = 2

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1109703087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1097ui_story"].transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.moveOldPos1097ui_story = var_362_0.localPosition
			end

			local var_362_2 = 0.001

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2
				local var_362_4 = Vector3.New(0, -0.54, -6.3)

				var_362_0.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1097ui_story, var_362_4, var_362_3)

				local var_362_5 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_5.x, var_362_5.y, var_362_5.z)

				local var_362_6 = var_362_0.localEulerAngles

				var_362_6.z = 0
				var_362_6.x = 0
				var_362_0.localEulerAngles = var_362_6
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 then
				var_362_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_362_7 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_7.x, var_362_7.y, var_362_7.z)

				local var_362_8 = var_362_0.localEulerAngles

				var_362_8.z = 0
				var_362_8.x = 0
				var_362_0.localEulerAngles = var_362_8
			end

			local var_362_9 = arg_359_1.actors_["1097ui_story"]
			local var_362_10 = 0

			if var_362_10 < arg_359_1.time_ and arg_359_1.time_ <= var_362_10 + arg_362_0 and not isNil(var_362_9) and arg_359_1.var_.characterEffect1097ui_story == nil then
				arg_359_1.var_.characterEffect1097ui_story = var_362_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_11 = 0.200000002980232

			if var_362_10 <= arg_359_1.time_ and arg_359_1.time_ < var_362_10 + var_362_11 and not isNil(var_362_9) then
				local var_362_12 = (arg_359_1.time_ - var_362_10) / var_362_11

				if arg_359_1.var_.characterEffect1097ui_story and not isNil(var_362_9) then
					arg_359_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= var_362_10 + var_362_11 and arg_359_1.time_ < var_362_10 + var_362_11 + arg_362_0 and not isNil(var_362_9) and arg_359_1.var_.characterEffect1097ui_story then
				arg_359_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_362_13 = 0

			if var_362_13 < arg_359_1.time_ and arg_359_1.time_ <= var_362_13 + arg_362_0 then
				arg_359_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			local var_362_14 = 0

			if var_362_14 < arg_359_1.time_ and arg_359_1.time_ <= var_362_14 + arg_362_0 then
				arg_359_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_362_15 = 0
			local var_362_16 = 0.125

			if var_362_15 < arg_359_1.time_ and arg_359_1.time_ <= var_362_15 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_17 = arg_359_1:FormatText(StoryNameCfg[216].name)

				arg_359_1.leftNameTxt_.text = var_362_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_18 = arg_359_1:GetWordFromCfg(1109703086)
				local var_362_19 = arg_359_1:FormatText(var_362_18.content)

				arg_359_1.text_.text = var_362_19

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_20 = 5
				local var_362_21 = utf8.len(var_362_19)
				local var_362_22 = var_362_20 <= 0 and var_362_16 or var_362_16 * (var_362_21 / var_362_20)

				if var_362_22 > 0 and var_362_16 < var_362_22 then
					arg_359_1.talkMaxDuration = var_362_22

					if var_362_22 + var_362_15 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_22 + var_362_15
					end
				end

				arg_359_1.text_.text = var_362_19
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703086", "story_v_side_new_1109703.awb") ~= 0 then
					local var_362_23 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703086", "story_v_side_new_1109703.awb") / 1000

					if var_362_23 + var_362_15 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_23 + var_362_15
					end

					if var_362_18.prefab_name ~= "" and arg_359_1.actors_[var_362_18.prefab_name] ~= nil then
						local var_362_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_18.prefab_name].transform, "story_v_side_new_1109703", "1109703086", "story_v_side_new_1109703.awb")

						arg_359_1:RecordAudio("1109703086", var_362_24)
						arg_359_1:RecordAudio("1109703086", var_362_24)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703086", "story_v_side_new_1109703.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703086", "story_v_side_new_1109703.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_25 = math.max(var_362_16, arg_359_1.talkMaxDuration)

			if var_362_15 <= arg_359_1.time_ and arg_359_1.time_ < var_362_15 + var_362_25 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_15) / var_362_25

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_15 + var_362_25 and arg_359_1.time_ < var_362_15 + var_362_25 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play1109703087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1109703087
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1109703088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1097ui_story"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1097ui_story == nil then
				arg_363_1.var_.characterEffect1097ui_story = var_366_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.200000002980232

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.characterEffect1097ui_story and not isNil(var_366_0) then
					local var_366_4 = Mathf.Lerp(0, 0.5, var_366_3)

					arg_363_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1097ui_story.fillRatio = var_366_4
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1097ui_story then
				local var_366_5 = 0.5

				arg_363_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1097ui_story.fillRatio = var_366_5
			end

			local var_366_6 = 0
			local var_366_7 = 0.675

			if var_366_6 < arg_363_1.time_ and arg_363_1.time_ <= var_366_6 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_8 = arg_363_1:GetWordFromCfg(1109703087)
				local var_366_9 = arg_363_1:FormatText(var_366_8.content)

				arg_363_1.text_.text = var_366_9

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_10 = 27
				local var_366_11 = utf8.len(var_366_9)
				local var_366_12 = var_366_10 <= 0 and var_366_7 or var_366_7 * (var_366_11 / var_366_10)

				if var_366_12 > 0 and var_366_7 < var_366_12 then
					arg_363_1.talkMaxDuration = var_366_12

					if var_366_12 + var_366_6 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_12 + var_366_6
					end
				end

				arg_363_1.text_.text = var_366_9
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_13 = math.max(var_366_7, arg_363_1.talkMaxDuration)

			if var_366_6 <= arg_363_1.time_ and arg_363_1.time_ < var_366_6 + var_366_13 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_6) / var_366_13

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_6 + var_366_13 and arg_363_1.time_ < var_366_6 + var_366_13 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1109703088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1109703088
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1109703089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 1.125

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_2 = arg_367_1:FormatText(StoryNameCfg[7].name)

				arg_367_1.leftNameTxt_.text = var_370_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:GetWordFromCfg(1109703088)
				local var_370_4 = arg_367_1:FormatText(var_370_3.content)

				arg_367_1.text_.text = var_370_4

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 45
				local var_370_6 = utf8.len(var_370_4)
				local var_370_7 = var_370_5 <= 0 and var_370_1 or var_370_1 * (var_370_6 / var_370_5)

				if var_370_7 > 0 and var_370_1 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_4
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_8 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_8 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_8

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_8 and arg_367_1.time_ < var_370_0 + var_370_8 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1109703089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1109703089
		arg_371_1.duration_ = 2

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1109703090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1097ui_story"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos1097ui_story = var_374_0.localPosition
			end

			local var_374_2 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2
				local var_374_4 = Vector3.New(0, -0.54, -6.3)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1097ui_story, var_374_4, var_374_3)

				local var_374_5 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_5.x, var_374_5.y, var_374_5.z)

				local var_374_6 = var_374_0.localEulerAngles

				var_374_6.z = 0
				var_374_6.x = 0
				var_374_0.localEulerAngles = var_374_6
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_374_7 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_7.x, var_374_7.y, var_374_7.z)

				local var_374_8 = var_374_0.localEulerAngles

				var_374_8.z = 0
				var_374_8.x = 0
				var_374_0.localEulerAngles = var_374_8
			end

			local var_374_9 = arg_371_1.actors_["1097ui_story"]
			local var_374_10 = 0

			if var_374_10 < arg_371_1.time_ and arg_371_1.time_ <= var_374_10 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1097ui_story == nil then
				arg_371_1.var_.characterEffect1097ui_story = var_374_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_11 = 0.200000002980232

			if var_374_10 <= arg_371_1.time_ and arg_371_1.time_ < var_374_10 + var_374_11 and not isNil(var_374_9) then
				local var_374_12 = (arg_371_1.time_ - var_374_10) / var_374_11

				if arg_371_1.var_.characterEffect1097ui_story and not isNil(var_374_9) then
					arg_371_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_10 + var_374_11 and arg_371_1.time_ < var_374_10 + var_374_11 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1097ui_story then
				arg_371_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_374_13 = 0

			if var_374_13 < arg_371_1.time_ and arg_371_1.time_ <= var_374_13 + arg_374_0 then
				arg_371_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_374_14 = 0

			if var_374_14 < arg_371_1.time_ and arg_371_1.time_ <= var_374_14 + arg_374_0 then
				arg_371_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_374_15 = 0
			local var_374_16 = 0.15

			if var_374_15 < arg_371_1.time_ and arg_371_1.time_ <= var_374_15 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_17 = arg_371_1:FormatText(StoryNameCfg[216].name)

				arg_371_1.leftNameTxt_.text = var_374_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_18 = arg_371_1:GetWordFromCfg(1109703089)
				local var_374_19 = arg_371_1:FormatText(var_374_18.content)

				arg_371_1.text_.text = var_374_19

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_20 = 6
				local var_374_21 = utf8.len(var_374_19)
				local var_374_22 = var_374_20 <= 0 and var_374_16 or var_374_16 * (var_374_21 / var_374_20)

				if var_374_22 > 0 and var_374_16 < var_374_22 then
					arg_371_1.talkMaxDuration = var_374_22

					if var_374_22 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_22 + var_374_15
					end
				end

				arg_371_1.text_.text = var_374_19
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703089", "story_v_side_new_1109703.awb") ~= 0 then
					local var_374_23 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703089", "story_v_side_new_1109703.awb") / 1000

					if var_374_23 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_23 + var_374_15
					end

					if var_374_18.prefab_name ~= "" and arg_371_1.actors_[var_374_18.prefab_name] ~= nil then
						local var_374_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_18.prefab_name].transform, "story_v_side_new_1109703", "1109703089", "story_v_side_new_1109703.awb")

						arg_371_1:RecordAudio("1109703089", var_374_24)
						arg_371_1:RecordAudio("1109703089", var_374_24)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703089", "story_v_side_new_1109703.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703089", "story_v_side_new_1109703.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_25 = math.max(var_374_16, arg_371_1.talkMaxDuration)

			if var_374_15 <= arg_371_1.time_ and arg_371_1.time_ < var_374_15 + var_374_25 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_15) / var_374_25

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_15 + var_374_25 and arg_371_1.time_ < var_374_15 + var_374_25 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play1109703090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1109703090
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1109703091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1097ui_story"]
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect1097ui_story == nil then
				arg_375_1.var_.characterEffect1097ui_story = var_378_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 and not isNil(var_378_0) then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2

				if arg_375_1.var_.characterEffect1097ui_story and not isNil(var_378_0) then
					local var_378_4 = Mathf.Lerp(0, 0.5, var_378_3)

					arg_375_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1097ui_story.fillRatio = var_378_4
				end
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect1097ui_story then
				local var_378_5 = 0.5

				arg_375_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1097ui_story.fillRatio = var_378_5
			end

			local var_378_6 = 0
			local var_378_7 = 1.125

			if var_378_6 < arg_375_1.time_ and arg_375_1.time_ <= var_378_6 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_8 = arg_375_1:FormatText(StoryNameCfg[7].name)

				arg_375_1.leftNameTxt_.text = var_378_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_9 = arg_375_1:GetWordFromCfg(1109703090)
				local var_378_10 = arg_375_1:FormatText(var_378_9.content)

				arg_375_1.text_.text = var_378_10

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_11 = 45
				local var_378_12 = utf8.len(var_378_10)
				local var_378_13 = var_378_11 <= 0 and var_378_7 or var_378_7 * (var_378_12 / var_378_11)

				if var_378_13 > 0 and var_378_7 < var_378_13 then
					arg_375_1.talkMaxDuration = var_378_13

					if var_378_13 + var_378_6 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_13 + var_378_6
					end
				end

				arg_375_1.text_.text = var_378_10
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_14 = math.max(var_378_7, arg_375_1.talkMaxDuration)

			if var_378_6 <= arg_375_1.time_ and arg_375_1.time_ < var_378_6 + var_378_14 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_6) / var_378_14

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_6 + var_378_14 and arg_375_1.time_ < var_378_6 + var_378_14 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1109703091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1109703091
		arg_379_1.duration_ = 5

		local var_379_0 = {
			zh = 5,
			ja = 4.8
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1109703092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1097ui_story"].transform
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.var_.moveOldPos1097ui_story = var_382_0.localPosition
			end

			local var_382_2 = 0.001

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2
				local var_382_4 = Vector3.New(0, -0.54, -6.3)

				var_382_0.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1097ui_story, var_382_4, var_382_3)

				local var_382_5 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_5.x, var_382_5.y, var_382_5.z)

				local var_382_6 = var_382_0.localEulerAngles

				var_382_6.z = 0
				var_382_6.x = 0
				var_382_0.localEulerAngles = var_382_6
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 then
				var_382_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_382_7 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_7.x, var_382_7.y, var_382_7.z)

				local var_382_8 = var_382_0.localEulerAngles

				var_382_8.z = 0
				var_382_8.x = 0
				var_382_0.localEulerAngles = var_382_8
			end

			local var_382_9 = arg_379_1.actors_["1097ui_story"]
			local var_382_10 = 0

			if var_382_10 < arg_379_1.time_ and arg_379_1.time_ <= var_382_10 + arg_382_0 and not isNil(var_382_9) and arg_379_1.var_.characterEffect1097ui_story == nil then
				arg_379_1.var_.characterEffect1097ui_story = var_382_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_11 = 0.200000002980232

			if var_382_10 <= arg_379_1.time_ and arg_379_1.time_ < var_382_10 + var_382_11 and not isNil(var_382_9) then
				local var_382_12 = (arg_379_1.time_ - var_382_10) / var_382_11

				if arg_379_1.var_.characterEffect1097ui_story and not isNil(var_382_9) then
					arg_379_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= var_382_10 + var_382_11 and arg_379_1.time_ < var_382_10 + var_382_11 + arg_382_0 and not isNil(var_382_9) and arg_379_1.var_.characterEffect1097ui_story then
				arg_379_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_382_13 = 0
			local var_382_14 = 0.55

			if var_382_13 < arg_379_1.time_ and arg_379_1.time_ <= var_382_13 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_15 = arg_379_1:FormatText(StoryNameCfg[216].name)

				arg_379_1.leftNameTxt_.text = var_382_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_16 = arg_379_1:GetWordFromCfg(1109703091)
				local var_382_17 = arg_379_1:FormatText(var_382_16.content)

				arg_379_1.text_.text = var_382_17

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_18 = 22
				local var_382_19 = utf8.len(var_382_17)
				local var_382_20 = var_382_18 <= 0 and var_382_14 or var_382_14 * (var_382_19 / var_382_18)

				if var_382_20 > 0 and var_382_14 < var_382_20 then
					arg_379_1.talkMaxDuration = var_382_20

					if var_382_20 + var_382_13 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_20 + var_382_13
					end
				end

				arg_379_1.text_.text = var_382_17
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703091", "story_v_side_new_1109703.awb") ~= 0 then
					local var_382_21 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703091", "story_v_side_new_1109703.awb") / 1000

					if var_382_21 + var_382_13 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_21 + var_382_13
					end

					if var_382_16.prefab_name ~= "" and arg_379_1.actors_[var_382_16.prefab_name] ~= nil then
						local var_382_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_16.prefab_name].transform, "story_v_side_new_1109703", "1109703091", "story_v_side_new_1109703.awb")

						arg_379_1:RecordAudio("1109703091", var_382_22)
						arg_379_1:RecordAudio("1109703091", var_382_22)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703091", "story_v_side_new_1109703.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703091", "story_v_side_new_1109703.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_23 = math.max(var_382_14, arg_379_1.talkMaxDuration)

			if var_382_13 <= arg_379_1.time_ and arg_379_1.time_ < var_382_13 + var_382_23 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_13) / var_382_23

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_13 + var_382_23 and arg_379_1.time_ < var_382_13 + var_382_23 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play1109703092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1109703092
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1109703093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1097ui_story"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1097ui_story == nil then
				arg_383_1.var_.characterEffect1097ui_story = var_386_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.characterEffect1097ui_story and not isNil(var_386_0) then
					local var_386_4 = Mathf.Lerp(0, 0.5, var_386_3)

					arg_383_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1097ui_story.fillRatio = var_386_4
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1097ui_story then
				local var_386_5 = 0.5

				arg_383_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1097ui_story.fillRatio = var_386_5
			end

			local var_386_6 = 0
			local var_386_7 = 0.35

			if var_386_6 < arg_383_1.time_ and arg_383_1.time_ <= var_386_6 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_8 = arg_383_1:GetWordFromCfg(1109703092)
				local var_386_9 = arg_383_1:FormatText(var_386_8.content)

				arg_383_1.text_.text = var_386_9

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_10 = 14
				local var_386_11 = utf8.len(var_386_9)
				local var_386_12 = var_386_10 <= 0 and var_386_7 or var_386_7 * (var_386_11 / var_386_10)

				if var_386_12 > 0 and var_386_7 < var_386_12 then
					arg_383_1.talkMaxDuration = var_386_12

					if var_386_12 + var_386_6 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_12 + var_386_6
					end
				end

				arg_383_1.text_.text = var_386_9
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_13 = math.max(var_386_7, arg_383_1.talkMaxDuration)

			if var_386_6 <= arg_383_1.time_ and arg_383_1.time_ < var_386_6 + var_386_13 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_6) / var_386_13

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_6 + var_386_13 and arg_383_1.time_ < var_386_6 + var_386_13 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1109703093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1109703093
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1109703094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 1.175

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_2 = arg_387_1:FormatText(StoryNameCfg[7].name)

				arg_387_1.leftNameTxt_.text = var_390_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_3 = arg_387_1:GetWordFromCfg(1109703093)
				local var_390_4 = arg_387_1:FormatText(var_390_3.content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 47
				local var_390_6 = utf8.len(var_390_4)
				local var_390_7 = var_390_5 <= 0 and var_390_1 or var_390_1 * (var_390_6 / var_390_5)

				if var_390_7 > 0 and var_390_1 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_8 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_8 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_8

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_8 and arg_387_1.time_ < var_390_0 + var_390_8 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1109703094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1109703094
		arg_391_1.duration_ = 3.8

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1109703095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1097ui_story"]
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1097ui_story == nil then
				arg_391_1.var_.characterEffect1097ui_story = var_394_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_2 = 0.200000002980232

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 and not isNil(var_394_0) then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2

				if arg_391_1.var_.characterEffect1097ui_story and not isNil(var_394_0) then
					arg_391_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1097ui_story then
				arg_391_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_394_4 = 0

			if var_394_4 < arg_391_1.time_ and arg_391_1.time_ <= var_394_4 + arg_394_0 then
				arg_391_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_394_5 = 0

			if var_394_5 < arg_391_1.time_ and arg_391_1.time_ <= var_394_5 + arg_394_0 then
				arg_391_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_394_6 = 0
			local var_394_7 = 0.45

			if var_394_6 < arg_391_1.time_ and arg_391_1.time_ <= var_394_6 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_8 = arg_391_1:FormatText(StoryNameCfg[216].name)

				arg_391_1.leftNameTxt_.text = var_394_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_9 = arg_391_1:GetWordFromCfg(1109703094)
				local var_394_10 = arg_391_1:FormatText(var_394_9.content)

				arg_391_1.text_.text = var_394_10

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_11 = 18
				local var_394_12 = utf8.len(var_394_10)
				local var_394_13 = var_394_11 <= 0 and var_394_7 or var_394_7 * (var_394_12 / var_394_11)

				if var_394_13 > 0 and var_394_7 < var_394_13 then
					arg_391_1.talkMaxDuration = var_394_13

					if var_394_13 + var_394_6 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_13 + var_394_6
					end
				end

				arg_391_1.text_.text = var_394_10
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703094", "story_v_side_new_1109703.awb") ~= 0 then
					local var_394_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703094", "story_v_side_new_1109703.awb") / 1000

					if var_394_14 + var_394_6 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_14 + var_394_6
					end

					if var_394_9.prefab_name ~= "" and arg_391_1.actors_[var_394_9.prefab_name] ~= nil then
						local var_394_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_9.prefab_name].transform, "story_v_side_new_1109703", "1109703094", "story_v_side_new_1109703.awb")

						arg_391_1:RecordAudio("1109703094", var_394_15)
						arg_391_1:RecordAudio("1109703094", var_394_15)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703094", "story_v_side_new_1109703.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703094", "story_v_side_new_1109703.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_16 = math.max(var_394_7, arg_391_1.talkMaxDuration)

			if var_394_6 <= arg_391_1.time_ and arg_391_1.time_ < var_394_6 + var_394_16 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_6) / var_394_16

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_6 + var_394_16 and arg_391_1.time_ < var_394_6 + var_394_16 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1109703095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1109703095
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1109703096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["1097ui_story"]
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1097ui_story == nil then
				arg_395_1.var_.characterEffect1097ui_story = var_398_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.200000002980232

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 and not isNil(var_398_0) then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2

				if arg_395_1.var_.characterEffect1097ui_story and not isNil(var_398_0) then
					local var_398_4 = Mathf.Lerp(0, 0.5, var_398_3)

					arg_395_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1097ui_story.fillRatio = var_398_4
				end
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1097ui_story then
				local var_398_5 = 0.5

				arg_395_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1097ui_story.fillRatio = var_398_5
			end

			local var_398_6 = 0
			local var_398_7 = 0.225

			if var_398_6 < arg_395_1.time_ and arg_395_1.time_ <= var_398_6 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_8 = arg_395_1:FormatText(StoryNameCfg[7].name)

				arg_395_1.leftNameTxt_.text = var_398_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_9 = arg_395_1:GetWordFromCfg(1109703095)
				local var_398_10 = arg_395_1:FormatText(var_398_9.content)

				arg_395_1.text_.text = var_398_10

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_11 = 9
				local var_398_12 = utf8.len(var_398_10)
				local var_398_13 = var_398_11 <= 0 and var_398_7 or var_398_7 * (var_398_12 / var_398_11)

				if var_398_13 > 0 and var_398_7 < var_398_13 then
					arg_395_1.talkMaxDuration = var_398_13

					if var_398_13 + var_398_6 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_13 + var_398_6
					end
				end

				arg_395_1.text_.text = var_398_10
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_14 = math.max(var_398_7, arg_395_1.talkMaxDuration)

			if var_398_6 <= arg_395_1.time_ and arg_395_1.time_ < var_398_6 + var_398_14 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_6) / var_398_14

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_6 + var_398_14 and arg_395_1.time_ < var_398_6 + var_398_14 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1109703096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1109703096
		arg_399_1.duration_ = 9

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1109703097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 2

			if var_402_0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_0 + arg_402_0 then
				local var_402_1 = manager.ui.mainCamera.transform.localPosition
				local var_402_2 = Vector3.New(0, 0, 10) + Vector3.New(var_402_1.x, var_402_1.y, 0)
				local var_402_3 = arg_399_1.bgs_.ST12

				var_402_3.transform.localPosition = var_402_2
				var_402_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_402_4 = var_402_3:GetComponent("SpriteRenderer")

				if var_402_4 and var_402_4.sprite then
					local var_402_5 = (var_402_3.transform.localPosition - var_402_1).z
					local var_402_6 = manager.ui.mainCameraCom_
					local var_402_7 = 2 * var_402_5 * Mathf.Tan(var_402_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_402_8 = var_402_7 * var_402_6.aspect
					local var_402_9 = var_402_4.sprite.bounds.size.x
					local var_402_10 = var_402_4.sprite.bounds.size.y
					local var_402_11 = var_402_8 / var_402_9
					local var_402_12 = var_402_7 / var_402_10
					local var_402_13 = var_402_12 < var_402_11 and var_402_11 or var_402_12

					var_402_3.transform.localScale = Vector3.New(var_402_13, var_402_13, 0)
				end

				for iter_402_0, iter_402_1 in pairs(arg_399_1.bgs_) do
					if iter_402_0 ~= "ST12" then
						iter_402_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_402_14 = 0

			if var_402_14 < arg_399_1.time_ and arg_399_1.time_ <= var_402_14 + arg_402_0 then
				arg_399_1.mask_.enabled = true
				arg_399_1.mask_.raycastTarget = true

				arg_399_1:SetGaussion(false)
			end

			local var_402_15 = 2

			if var_402_14 <= arg_399_1.time_ and arg_399_1.time_ < var_402_14 + var_402_15 then
				local var_402_16 = (arg_399_1.time_ - var_402_14) / var_402_15
				local var_402_17 = Color.New(1, 1, 1)

				var_402_17.a = Mathf.Lerp(0, 1, var_402_16)
				arg_399_1.mask_.color = var_402_17
			end

			if arg_399_1.time_ >= var_402_14 + var_402_15 and arg_399_1.time_ < var_402_14 + var_402_15 + arg_402_0 then
				local var_402_18 = Color.New(1, 1, 1)

				var_402_18.a = 1
				arg_399_1.mask_.color = var_402_18
			end

			local var_402_19 = 2

			if var_402_19 < arg_399_1.time_ and arg_399_1.time_ <= var_402_19 + arg_402_0 then
				arg_399_1.mask_.enabled = true
				arg_399_1.mask_.raycastTarget = true

				arg_399_1:SetGaussion(false)
			end

			local var_402_20 = 2

			if var_402_19 <= arg_399_1.time_ and arg_399_1.time_ < var_402_19 + var_402_20 then
				local var_402_21 = (arg_399_1.time_ - var_402_19) / var_402_20
				local var_402_22 = Color.New(1, 1, 1)

				var_402_22.a = Mathf.Lerp(1, 0, var_402_21)
				arg_399_1.mask_.color = var_402_22
			end

			if arg_399_1.time_ >= var_402_19 + var_402_20 and arg_399_1.time_ < var_402_19 + var_402_20 + arg_402_0 then
				local var_402_23 = Color.New(1, 1, 1)
				local var_402_24 = 0

				arg_399_1.mask_.enabled = false
				var_402_23.a = var_402_24
				arg_399_1.mask_.color = var_402_23
			end

			local var_402_25 = arg_399_1.actors_["1097ui_story"].transform
			local var_402_26 = 1.95

			if var_402_26 < arg_399_1.time_ and arg_399_1.time_ <= var_402_26 + arg_402_0 then
				arg_399_1.var_.moveOldPos1097ui_story = var_402_25.localPosition
			end

			local var_402_27 = 0.001

			if var_402_26 <= arg_399_1.time_ and arg_399_1.time_ < var_402_26 + var_402_27 then
				local var_402_28 = (arg_399_1.time_ - var_402_26) / var_402_27
				local var_402_29 = Vector3.New(0, 100, 0)

				var_402_25.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1097ui_story, var_402_29, var_402_28)

				local var_402_30 = manager.ui.mainCamera.transform.position - var_402_25.position

				var_402_25.forward = Vector3.New(var_402_30.x, var_402_30.y, var_402_30.z)

				local var_402_31 = var_402_25.localEulerAngles

				var_402_31.z = 0
				var_402_31.x = 0
				var_402_25.localEulerAngles = var_402_31
			end

			if arg_399_1.time_ >= var_402_26 + var_402_27 and arg_399_1.time_ < var_402_26 + var_402_27 + arg_402_0 then
				var_402_25.localPosition = Vector3.New(0, 100, 0)

				local var_402_32 = manager.ui.mainCamera.transform.position - var_402_25.position

				var_402_25.forward = Vector3.New(var_402_32.x, var_402_32.y, var_402_32.z)

				local var_402_33 = var_402_25.localEulerAngles

				var_402_33.z = 0
				var_402_33.x = 0
				var_402_25.localEulerAngles = var_402_33
			end

			local var_402_34 = arg_399_1.actors_["1097ui_story"]
			local var_402_35 = 1.95

			if var_402_35 < arg_399_1.time_ and arg_399_1.time_ <= var_402_35 + arg_402_0 and not isNil(var_402_34) and arg_399_1.var_.characterEffect1097ui_story == nil then
				arg_399_1.var_.characterEffect1097ui_story = var_402_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_36 = 0.05

			if var_402_35 <= arg_399_1.time_ and arg_399_1.time_ < var_402_35 + var_402_36 and not isNil(var_402_34) then
				local var_402_37 = (arg_399_1.time_ - var_402_35) / var_402_36

				if arg_399_1.var_.characterEffect1097ui_story and not isNil(var_402_34) then
					local var_402_38 = Mathf.Lerp(0, 0.5, var_402_37)

					arg_399_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1097ui_story.fillRatio = var_402_38
				end
			end

			if arg_399_1.time_ >= var_402_35 + var_402_36 and arg_399_1.time_ < var_402_35 + var_402_36 + arg_402_0 and not isNil(var_402_34) and arg_399_1.var_.characterEffect1097ui_story then
				local var_402_39 = 0.5

				arg_399_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1097ui_story.fillRatio = var_402_39
			end

			if arg_399_1.frameCnt_ <= 1 then
				arg_399_1.dialog_:SetActive(false)
			end

			local var_402_40 = 4
			local var_402_41 = 0.05

			if var_402_40 < arg_399_1.time_ and arg_399_1.time_ <= var_402_40 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0

				arg_399_1.dialog_:SetActive(true)

				arg_399_1.dialogCg_.alpha = 0

				local var_402_42 = LeanTween.value(arg_399_1.dialog_, 0, 1, 0.3)

				var_402_42:setOnUpdate(LuaHelper.FloatAction(function(arg_403_0)
					arg_399_1.dialogCg_.alpha = arg_403_0
				end))
				var_402_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_399_1.dialog_)
					var_402_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_399_1.duration_ = arg_399_1.duration_ + 0.3

				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_43 = arg_399_1:GetWordFromCfg(1109703096)
				local var_402_44 = arg_399_1:FormatText(var_402_43.content)

				arg_399_1.text_.text = var_402_44

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_45 = 2
				local var_402_46 = utf8.len(var_402_44)
				local var_402_47 = var_402_45 <= 0 and var_402_41 or var_402_41 * (var_402_46 / var_402_45)

				if var_402_47 > 0 and var_402_41 < var_402_47 then
					arg_399_1.talkMaxDuration = var_402_47
					var_402_40 = var_402_40 + 0.3

					if var_402_47 + var_402_40 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_47 + var_402_40
					end
				end

				arg_399_1.text_.text = var_402_44
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_48 = var_402_40 + 0.3
			local var_402_49 = math.max(var_402_41, arg_399_1.talkMaxDuration)

			if var_402_48 <= arg_399_1.time_ and arg_399_1.time_ < var_402_48 + var_402_49 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_48) / var_402_49

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_48 + var_402_49 and arg_399_1.time_ < var_402_48 + var_402_49 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.95,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play1109703097 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1109703097
		arg_405_1.duration_ = 5.9

		local var_405_0 = {
			zh = 5.9,
			ja = 4.633
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1109703098(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = "1027ui_story"

			if arg_405_1.actors_[var_408_0] == nil then
				local var_408_1 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_408_1) then
					local var_408_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_405_1.stage_.transform)

					var_408_2.name = var_408_0
					var_408_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_405_1.actors_[var_408_0] = var_408_2

					local var_408_3 = var_408_2:GetComponentInChildren(typeof(CharacterEffect))

					var_408_3.enabled = true

					local var_408_4 = GameObjectTools.GetOrAddComponent(var_408_2, typeof(DynamicBoneHelper))

					if var_408_4 then
						var_408_4:EnableDynamicBone(false)
					end

					arg_405_1:ShowWeapon(var_408_3.transform, false)

					arg_405_1.var_[var_408_0 .. "Animator"] = var_408_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_405_1.var_[var_408_0 .. "Animator"].applyRootMotion = true
					arg_405_1.var_[var_408_0 .. "LipSync"] = var_408_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_408_5 = arg_405_1.actors_["1027ui_story"].transform
			local var_408_6 = 0

			if var_408_6 < arg_405_1.time_ and arg_405_1.time_ <= var_408_6 + arg_408_0 then
				arg_405_1.var_.moveOldPos1027ui_story = var_408_5.localPosition
			end

			local var_408_7 = 0.001

			if var_408_6 <= arg_405_1.time_ and arg_405_1.time_ < var_408_6 + var_408_7 then
				local var_408_8 = (arg_405_1.time_ - var_408_6) / var_408_7
				local var_408_9 = Vector3.New(0, -0.81, -5.8)

				var_408_5.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1027ui_story, var_408_9, var_408_8)

				local var_408_10 = manager.ui.mainCamera.transform.position - var_408_5.position

				var_408_5.forward = Vector3.New(var_408_10.x, var_408_10.y, var_408_10.z)

				local var_408_11 = var_408_5.localEulerAngles

				var_408_11.z = 0
				var_408_11.x = 0
				var_408_5.localEulerAngles = var_408_11
			end

			if arg_405_1.time_ >= var_408_6 + var_408_7 and arg_405_1.time_ < var_408_6 + var_408_7 + arg_408_0 then
				var_408_5.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_408_12 = manager.ui.mainCamera.transform.position - var_408_5.position

				var_408_5.forward = Vector3.New(var_408_12.x, var_408_12.y, var_408_12.z)

				local var_408_13 = var_408_5.localEulerAngles

				var_408_13.z = 0
				var_408_13.x = 0
				var_408_5.localEulerAngles = var_408_13
			end

			local var_408_14 = arg_405_1.actors_["1027ui_story"]
			local var_408_15 = 0

			if var_408_15 < arg_405_1.time_ and arg_405_1.time_ <= var_408_15 + arg_408_0 and not isNil(var_408_14) and arg_405_1.var_.characterEffect1027ui_story == nil then
				arg_405_1.var_.characterEffect1027ui_story = var_408_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_16 = 0.2

			if var_408_15 <= arg_405_1.time_ and arg_405_1.time_ < var_408_15 + var_408_16 and not isNil(var_408_14) then
				local var_408_17 = (arg_405_1.time_ - var_408_15) / var_408_16

				if arg_405_1.var_.characterEffect1027ui_story and not isNil(var_408_14) then
					arg_405_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= var_408_15 + var_408_16 and arg_405_1.time_ < var_408_15 + var_408_16 + arg_408_0 and not isNil(var_408_14) and arg_405_1.var_.characterEffect1027ui_story then
				arg_405_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_408_18 = 0

			if var_408_18 < arg_405_1.time_ and arg_405_1.time_ <= var_408_18 + arg_408_0 then
				arg_405_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_408_19 = 0

			if var_408_19 < arg_405_1.time_ and arg_405_1.time_ <= var_408_19 + arg_408_0 then
				arg_405_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_408_20 = arg_405_1.actors_["1027ui_story"]
			local var_408_21 = 0

			if var_408_21 < arg_405_1.time_ and arg_405_1.time_ <= var_408_21 + arg_408_0 then
				if arg_405_1.var_.characterEffect1027ui_story == nil then
					arg_405_1.var_.characterEffect1027ui_story = var_408_20:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_408_22 = arg_405_1.var_.characterEffect1027ui_story

				var_408_22.imageEffect:turnOff()

				var_408_22.interferenceEffect.enabled = true
				var_408_22.interferenceEffect.noise = 0.01
				var_408_22.interferenceEffect.simTimeScale = 1
				var_408_22.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_408_23 = arg_405_1.actors_["1027ui_story"]
			local var_408_24 = 0
			local var_408_25 = 0.2

			if var_408_24 < arg_405_1.time_ and arg_405_1.time_ <= var_408_24 + arg_408_0 then
				if arg_405_1.var_.characterEffect1027ui_story == nil then
					arg_405_1.var_.characterEffect1027ui_story = var_408_23:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_405_1.var_.characterEffect1027ui_story.imageEffect:turnOn(false)
			end

			local var_408_26 = 0
			local var_408_27 = 0.525

			if var_408_26 < arg_405_1.time_ and arg_405_1.time_ <= var_408_26 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_28 = arg_405_1:FormatText(StoryNameCfg[56].name)

				arg_405_1.leftNameTxt_.text = var_408_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_29 = arg_405_1:GetWordFromCfg(1109703097)
				local var_408_30 = arg_405_1:FormatText(var_408_29.content)

				arg_405_1.text_.text = var_408_30

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_31 = 21
				local var_408_32 = utf8.len(var_408_30)
				local var_408_33 = var_408_31 <= 0 and var_408_27 or var_408_27 * (var_408_32 / var_408_31)

				if var_408_33 > 0 and var_408_27 < var_408_33 then
					arg_405_1.talkMaxDuration = var_408_33

					if var_408_33 + var_408_26 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_33 + var_408_26
					end
				end

				arg_405_1.text_.text = var_408_30
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703097", "story_v_side_new_1109703.awb") ~= 0 then
					local var_408_34 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703097", "story_v_side_new_1109703.awb") / 1000

					if var_408_34 + var_408_26 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_34 + var_408_26
					end

					if var_408_29.prefab_name ~= "" and arg_405_1.actors_[var_408_29.prefab_name] ~= nil then
						local var_408_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_29.prefab_name].transform, "story_v_side_new_1109703", "1109703097", "story_v_side_new_1109703.awb")

						arg_405_1:RecordAudio("1109703097", var_408_35)
						arg_405_1:RecordAudio("1109703097", var_408_35)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703097", "story_v_side_new_1109703.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703097", "story_v_side_new_1109703.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_36 = math.max(var_408_27, arg_405_1.talkMaxDuration)

			if var_408_26 <= arg_405_1.time_ and arg_405_1.time_ < var_408_26 + var_408_36 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_26) / var_408_36

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_26 + var_408_36 and arg_405_1.time_ < var_408_26 + var_408_36 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play1109703098 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1109703098
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1109703099(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1027ui_story"]
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect1027ui_story == nil then
				arg_409_1.var_.characterEffect1027ui_story = var_412_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.2

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 and not isNil(var_412_0) then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2

				if arg_409_1.var_.characterEffect1027ui_story and not isNil(var_412_0) then
					local var_412_4 = Mathf.Lerp(0, 0.5, var_412_3)

					arg_409_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1027ui_story.fillRatio = var_412_4
				end
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect1027ui_story then
				local var_412_5 = 0.5

				arg_409_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1027ui_story.fillRatio = var_412_5
			end

			local var_412_6 = 0
			local var_412_7 = 0.325

			if var_412_6 < arg_409_1.time_ and arg_409_1.time_ <= var_412_6 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_8 = arg_409_1:FormatText(StoryNameCfg[7].name)

				arg_409_1.leftNameTxt_.text = var_412_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_9 = arg_409_1:GetWordFromCfg(1109703098)
				local var_412_10 = arg_409_1:FormatText(var_412_9.content)

				arg_409_1.text_.text = var_412_10

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_11 = 13
				local var_412_12 = utf8.len(var_412_10)
				local var_412_13 = var_412_11 <= 0 and var_412_7 or var_412_7 * (var_412_12 / var_412_11)

				if var_412_13 > 0 and var_412_7 < var_412_13 then
					arg_409_1.talkMaxDuration = var_412_13

					if var_412_13 + var_412_6 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_13 + var_412_6
					end
				end

				arg_409_1.text_.text = var_412_10
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_14 = math.max(var_412_7, arg_409_1.talkMaxDuration)

			if var_412_6 <= arg_409_1.time_ and arg_409_1.time_ < var_412_6 + var_412_14 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_6) / var_412_14

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_6 + var_412_14 and arg_409_1.time_ < var_412_6 + var_412_14 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play1109703099 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1109703099
		arg_413_1.duration_ = 6.67

		local var_413_0 = {
			zh = 5.1,
			ja = 6.666
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1109703100(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1027ui_story"].transform
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.var_.moveOldPos1027ui_story = var_416_0.localPosition
			end

			local var_416_2 = 0.001

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2
				local var_416_4 = Vector3.New(0, -0.81, -5.8)

				var_416_0.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1027ui_story, var_416_4, var_416_3)

				local var_416_5 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_5.x, var_416_5.y, var_416_5.z)

				local var_416_6 = var_416_0.localEulerAngles

				var_416_6.z = 0
				var_416_6.x = 0
				var_416_0.localEulerAngles = var_416_6
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 then
				var_416_0.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_416_7 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_7.x, var_416_7.y, var_416_7.z)

				local var_416_8 = var_416_0.localEulerAngles

				var_416_8.z = 0
				var_416_8.x = 0
				var_416_0.localEulerAngles = var_416_8
			end

			local var_416_9 = arg_413_1.actors_["1027ui_story"]
			local var_416_10 = 0

			if var_416_10 < arg_413_1.time_ and arg_413_1.time_ <= var_416_10 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect1027ui_story == nil then
				arg_413_1.var_.characterEffect1027ui_story = var_416_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_11 = 0.200000002980232

			if var_416_10 <= arg_413_1.time_ and arg_413_1.time_ < var_416_10 + var_416_11 and not isNil(var_416_9) then
				local var_416_12 = (arg_413_1.time_ - var_416_10) / var_416_11

				if arg_413_1.var_.characterEffect1027ui_story and not isNil(var_416_9) then
					arg_413_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= var_416_10 + var_416_11 and arg_413_1.time_ < var_416_10 + var_416_11 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect1027ui_story then
				arg_413_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_416_13 = 0

			if var_416_13 < arg_413_1.time_ and arg_413_1.time_ <= var_416_13 + arg_416_0 then
				arg_413_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action425")
			end

			local var_416_14 = 0

			if var_416_14 < arg_413_1.time_ and arg_413_1.time_ <= var_416_14 + arg_416_0 then
				arg_413_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_416_15 = 0
			local var_416_16 = 0.6

			if var_416_15 < arg_413_1.time_ and arg_413_1.time_ <= var_416_15 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_17 = arg_413_1:FormatText(StoryNameCfg[56].name)

				arg_413_1.leftNameTxt_.text = var_416_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_18 = arg_413_1:GetWordFromCfg(1109703099)
				local var_416_19 = arg_413_1:FormatText(var_416_18.content)

				arg_413_1.text_.text = var_416_19

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_20 = 24
				local var_416_21 = utf8.len(var_416_19)
				local var_416_22 = var_416_20 <= 0 and var_416_16 or var_416_16 * (var_416_21 / var_416_20)

				if var_416_22 > 0 and var_416_16 < var_416_22 then
					arg_413_1.talkMaxDuration = var_416_22

					if var_416_22 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_22 + var_416_15
					end
				end

				arg_413_1.text_.text = var_416_19
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703099", "story_v_side_new_1109703.awb") ~= 0 then
					local var_416_23 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703099", "story_v_side_new_1109703.awb") / 1000

					if var_416_23 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_23 + var_416_15
					end

					if var_416_18.prefab_name ~= "" and arg_413_1.actors_[var_416_18.prefab_name] ~= nil then
						local var_416_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_18.prefab_name].transform, "story_v_side_new_1109703", "1109703099", "story_v_side_new_1109703.awb")

						arg_413_1:RecordAudio("1109703099", var_416_24)
						arg_413_1:RecordAudio("1109703099", var_416_24)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703099", "story_v_side_new_1109703.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703099", "story_v_side_new_1109703.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_25 = math.max(var_416_16, arg_413_1.talkMaxDuration)

			if var_416_15 <= arg_413_1.time_ and arg_413_1.time_ < var_416_15 + var_416_25 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_15) / var_416_25

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_15 + var_416_25 and arg_413_1.time_ < var_416_15 + var_416_25 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play1109703100 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1109703100
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1109703101(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["1027ui_story"]
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect1027ui_story == nil then
				arg_417_1.var_.characterEffect1027ui_story = var_420_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 and not isNil(var_420_0) then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2

				if arg_417_1.var_.characterEffect1027ui_story and not isNil(var_420_0) then
					local var_420_4 = Mathf.Lerp(0, 0.5, var_420_3)

					arg_417_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1027ui_story.fillRatio = var_420_4
				end
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect1027ui_story then
				local var_420_5 = 0.5

				arg_417_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1027ui_story.fillRatio = var_420_5
			end

			local var_420_6 = 0
			local var_420_7 = 0.05

			if var_420_6 < arg_417_1.time_ and arg_417_1.time_ <= var_420_6 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_8 = arg_417_1:FormatText(StoryNameCfg[7].name)

				arg_417_1.leftNameTxt_.text = var_420_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_9 = arg_417_1:GetWordFromCfg(1109703100)
				local var_420_10 = arg_417_1:FormatText(var_420_9.content)

				arg_417_1.text_.text = var_420_10

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_11 = 2
				local var_420_12 = utf8.len(var_420_10)
				local var_420_13 = var_420_11 <= 0 and var_420_7 or var_420_7 * (var_420_12 / var_420_11)

				if var_420_13 > 0 and var_420_7 < var_420_13 then
					arg_417_1.talkMaxDuration = var_420_13

					if var_420_13 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_13 + var_420_6
					end
				end

				arg_417_1.text_.text = var_420_10
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_14 = math.max(var_420_7, arg_417_1.talkMaxDuration)

			if var_420_6 <= arg_417_1.time_ and arg_417_1.time_ < var_420_6 + var_420_14 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_6) / var_420_14

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_6 + var_420_14 and arg_417_1.time_ < var_420_6 + var_420_14 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play1109703101 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1109703101
		arg_421_1.duration_ = 7.9

		local var_421_0 = {
			zh = 7.9,
			ja = 5.799999999999
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1109703102(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = "ST01"

			if arg_421_1.bgs_[var_424_0] == nil then
				local var_424_1 = Object.Instantiate(arg_421_1.paintGo_)

				var_424_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_424_0)
				var_424_1.name = var_424_0
				var_424_1.transform.parent = arg_421_1.stage_.transform
				var_424_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_421_1.bgs_[var_424_0] = var_424_1
			end

			local var_424_2 = 2

			if var_424_2 < arg_421_1.time_ and arg_421_1.time_ <= var_424_2 + arg_424_0 then
				local var_424_3 = manager.ui.mainCamera.transform.localPosition
				local var_424_4 = Vector3.New(0, 0, 10) + Vector3.New(var_424_3.x, var_424_3.y, 0)
				local var_424_5 = arg_421_1.bgs_.ST01

				var_424_5.transform.localPosition = var_424_4
				var_424_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_424_6 = var_424_5:GetComponent("SpriteRenderer")

				if var_424_6 and var_424_6.sprite then
					local var_424_7 = (var_424_5.transform.localPosition - var_424_3).z
					local var_424_8 = manager.ui.mainCameraCom_
					local var_424_9 = 2 * var_424_7 * Mathf.Tan(var_424_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_424_10 = var_424_9 * var_424_8.aspect
					local var_424_11 = var_424_6.sprite.bounds.size.x
					local var_424_12 = var_424_6.sprite.bounds.size.y
					local var_424_13 = var_424_10 / var_424_11
					local var_424_14 = var_424_9 / var_424_12
					local var_424_15 = var_424_14 < var_424_13 and var_424_13 or var_424_14

					var_424_5.transform.localScale = Vector3.New(var_424_15, var_424_15, 0)
				end

				for iter_424_0, iter_424_1 in pairs(arg_421_1.bgs_) do
					if iter_424_0 ~= "ST01" then
						iter_424_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_424_16 = 0

			if var_424_16 < arg_421_1.time_ and arg_421_1.time_ <= var_424_16 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_17 = 2

			if var_424_16 <= arg_421_1.time_ and arg_421_1.time_ < var_424_16 + var_424_17 then
				local var_424_18 = (arg_421_1.time_ - var_424_16) / var_424_17
				local var_424_19 = Color.New(0, 0, 0)

				var_424_19.a = Mathf.Lerp(0, 1, var_424_18)
				arg_421_1.mask_.color = var_424_19
			end

			if arg_421_1.time_ >= var_424_16 + var_424_17 and arg_421_1.time_ < var_424_16 + var_424_17 + arg_424_0 then
				local var_424_20 = Color.New(0, 0, 0)

				var_424_20.a = 1
				arg_421_1.mask_.color = var_424_20
			end

			local var_424_21 = 2

			if var_424_21 < arg_421_1.time_ and arg_421_1.time_ <= var_424_21 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_22 = 2

			if var_424_21 <= arg_421_1.time_ and arg_421_1.time_ < var_424_21 + var_424_22 then
				local var_424_23 = (arg_421_1.time_ - var_424_21) / var_424_22
				local var_424_24 = Color.New(0, 0, 0)

				var_424_24.a = Mathf.Lerp(1, 0, var_424_23)
				arg_421_1.mask_.color = var_424_24
			end

			if arg_421_1.time_ >= var_424_21 + var_424_22 and arg_421_1.time_ < var_424_21 + var_424_22 + arg_424_0 then
				local var_424_25 = Color.New(0, 0, 0)
				local var_424_26 = 0

				arg_421_1.mask_.enabled = false
				var_424_25.a = var_424_26
				arg_421_1.mask_.color = var_424_25
			end

			local var_424_27 = arg_421_1.actors_["1027ui_story"].transform
			local var_424_28 = 1.96599999815226

			if var_424_28 < arg_421_1.time_ and arg_421_1.time_ <= var_424_28 + arg_424_0 then
				arg_421_1.var_.moveOldPos1027ui_story = var_424_27.localPosition
			end

			local var_424_29 = 0.001

			if var_424_28 <= arg_421_1.time_ and arg_421_1.time_ < var_424_28 + var_424_29 then
				local var_424_30 = (arg_421_1.time_ - var_424_28) / var_424_29
				local var_424_31 = Vector3.New(0, 100, 0)

				var_424_27.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1027ui_story, var_424_31, var_424_30)

				local var_424_32 = manager.ui.mainCamera.transform.position - var_424_27.position

				var_424_27.forward = Vector3.New(var_424_32.x, var_424_32.y, var_424_32.z)

				local var_424_33 = var_424_27.localEulerAngles

				var_424_33.z = 0
				var_424_33.x = 0
				var_424_27.localEulerAngles = var_424_33
			end

			if arg_421_1.time_ >= var_424_28 + var_424_29 and arg_421_1.time_ < var_424_28 + var_424_29 + arg_424_0 then
				var_424_27.localPosition = Vector3.New(0, 100, 0)

				local var_424_34 = manager.ui.mainCamera.transform.position - var_424_27.position

				var_424_27.forward = Vector3.New(var_424_34.x, var_424_34.y, var_424_34.z)

				local var_424_35 = var_424_27.localEulerAngles

				var_424_35.z = 0
				var_424_35.x = 0
				var_424_27.localEulerAngles = var_424_35
			end

			local var_424_36 = arg_421_1.actors_["1027ui_story"]
			local var_424_37 = 1.96599999815226

			if var_424_37 < arg_421_1.time_ and arg_421_1.time_ <= var_424_37 + arg_424_0 and not isNil(var_424_36) and arg_421_1.var_.characterEffect1027ui_story == nil then
				arg_421_1.var_.characterEffect1027ui_story = var_424_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_38 = 0.034000001847744

			if var_424_37 <= arg_421_1.time_ and arg_421_1.time_ < var_424_37 + var_424_38 and not isNil(var_424_36) then
				local var_424_39 = (arg_421_1.time_ - var_424_37) / var_424_38

				if arg_421_1.var_.characterEffect1027ui_story and not isNil(var_424_36) then
					local var_424_40 = Mathf.Lerp(0, 0.5, var_424_39)

					arg_421_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1027ui_story.fillRatio = var_424_40
				end
			end

			if arg_421_1.time_ >= var_424_37 + var_424_38 and arg_421_1.time_ < var_424_37 + var_424_38 + arg_424_0 and not isNil(var_424_36) and arg_421_1.var_.characterEffect1027ui_story then
				local var_424_41 = 0.5

				arg_421_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1027ui_story.fillRatio = var_424_41
			end

			local var_424_42 = "1080ui_story"

			if arg_421_1.actors_[var_424_42] == nil then
				local var_424_43 = Asset.Load("Char/" .. "1080ui_story")

				if not isNil(var_424_43) then
					local var_424_44 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_421_1.stage_.transform)

					var_424_44.name = var_424_42
					var_424_44.transform.localPosition = Vector3.New(0, 100, 0)
					arg_421_1.actors_[var_424_42] = var_424_44

					local var_424_45 = var_424_44:GetComponentInChildren(typeof(CharacterEffect))

					var_424_45.enabled = true

					local var_424_46 = GameObjectTools.GetOrAddComponent(var_424_44, typeof(DynamicBoneHelper))

					if var_424_46 then
						var_424_46:EnableDynamicBone(false)
					end

					arg_421_1:ShowWeapon(var_424_45.transform, false)

					arg_421_1.var_[var_424_42 .. "Animator"] = var_424_45.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_421_1.var_[var_424_42 .. "Animator"].applyRootMotion = true
					arg_421_1.var_[var_424_42 .. "LipSync"] = var_424_45.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_424_47 = arg_421_1.actors_["1080ui_story"].transform
			local var_424_48 = 3.8

			if var_424_48 < arg_421_1.time_ and arg_421_1.time_ <= var_424_48 + arg_424_0 then
				arg_421_1.var_.moveOldPos1080ui_story = var_424_47.localPosition
			end

			local var_424_49 = 0.001

			if var_424_48 <= arg_421_1.time_ and arg_421_1.time_ < var_424_48 + var_424_49 then
				local var_424_50 = (arg_421_1.time_ - var_424_48) / var_424_49
				local var_424_51 = Vector3.New(0.7, -1.01, -6.05)

				var_424_47.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1080ui_story, var_424_51, var_424_50)

				local var_424_52 = manager.ui.mainCamera.transform.position - var_424_47.position

				var_424_47.forward = Vector3.New(var_424_52.x, var_424_52.y, var_424_52.z)

				local var_424_53 = var_424_47.localEulerAngles

				var_424_53.z = 0
				var_424_53.x = 0
				var_424_47.localEulerAngles = var_424_53
			end

			if arg_421_1.time_ >= var_424_48 + var_424_49 and arg_421_1.time_ < var_424_48 + var_424_49 + arg_424_0 then
				var_424_47.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_424_54 = manager.ui.mainCamera.transform.position - var_424_47.position

				var_424_47.forward = Vector3.New(var_424_54.x, var_424_54.y, var_424_54.z)

				local var_424_55 = var_424_47.localEulerAngles

				var_424_55.z = 0
				var_424_55.x = 0
				var_424_47.localEulerAngles = var_424_55
			end

			local var_424_56 = arg_421_1.actors_["1080ui_story"]
			local var_424_57 = 3.8

			if var_424_57 < arg_421_1.time_ and arg_421_1.time_ <= var_424_57 + arg_424_0 and not isNil(var_424_56) and arg_421_1.var_.characterEffect1080ui_story == nil then
				arg_421_1.var_.characterEffect1080ui_story = var_424_56:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_58 = 0.200000002980232

			if var_424_57 <= arg_421_1.time_ and arg_421_1.time_ < var_424_57 + var_424_58 and not isNil(var_424_56) then
				local var_424_59 = (arg_421_1.time_ - var_424_57) / var_424_58

				if arg_421_1.var_.characterEffect1080ui_story and not isNil(var_424_56) then
					arg_421_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= var_424_57 + var_424_58 and arg_421_1.time_ < var_424_57 + var_424_58 + arg_424_0 and not isNil(var_424_56) and arg_421_1.var_.characterEffect1080ui_story then
				arg_421_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_424_60 = 3.8

			if var_424_60 < arg_421_1.time_ and arg_421_1.time_ <= var_424_60 + arg_424_0 then
				arg_421_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			local var_424_61 = 3.8

			if var_424_61 < arg_421_1.time_ and arg_421_1.time_ <= var_424_61 + arg_424_0 then
				arg_421_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_424_62 = arg_421_1.actors_["1027ui_story"].transform
			local var_424_63 = 3.8

			if var_424_63 < arg_421_1.time_ and arg_421_1.time_ <= var_424_63 + arg_424_0 then
				arg_421_1.var_.moveOldPos1027ui_story = var_424_62.localPosition
			end

			local var_424_64 = 0.001

			if var_424_63 <= arg_421_1.time_ and arg_421_1.time_ < var_424_63 + var_424_64 then
				local var_424_65 = (arg_421_1.time_ - var_424_63) / var_424_64
				local var_424_66 = Vector3.New(-0.7, -0.81, -5.8)

				var_424_62.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1027ui_story, var_424_66, var_424_65)

				local var_424_67 = manager.ui.mainCamera.transform.position - var_424_62.position

				var_424_62.forward = Vector3.New(var_424_67.x, var_424_67.y, var_424_67.z)

				local var_424_68 = var_424_62.localEulerAngles

				var_424_68.z = 0
				var_424_68.x = 0
				var_424_62.localEulerAngles = var_424_68
			end

			if arg_421_1.time_ >= var_424_63 + var_424_64 and arg_421_1.time_ < var_424_63 + var_424_64 + arg_424_0 then
				var_424_62.localPosition = Vector3.New(-0.7, -0.81, -5.8)

				local var_424_69 = manager.ui.mainCamera.transform.position - var_424_62.position

				var_424_62.forward = Vector3.New(var_424_69.x, var_424_69.y, var_424_69.z)

				local var_424_70 = var_424_62.localEulerAngles

				var_424_70.z = 0
				var_424_70.x = 0
				var_424_62.localEulerAngles = var_424_70
			end

			local var_424_71 = arg_421_1.actors_["1027ui_story"]
			local var_424_72 = 3.8

			if var_424_72 < arg_421_1.time_ and arg_421_1.time_ <= var_424_72 + arg_424_0 and not isNil(var_424_71) and arg_421_1.var_.characterEffect1027ui_story == nil then
				arg_421_1.var_.characterEffect1027ui_story = var_424_71:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_73 = 0.200000002980232

			if var_424_72 <= arg_421_1.time_ and arg_421_1.time_ < var_424_72 + var_424_73 and not isNil(var_424_71) then
				local var_424_74 = (arg_421_1.time_ - var_424_72) / var_424_73

				if arg_421_1.var_.characterEffect1027ui_story and not isNil(var_424_71) then
					local var_424_75 = Mathf.Lerp(0, 0.5, var_424_74)

					arg_421_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1027ui_story.fillRatio = var_424_75
				end
			end

			if arg_421_1.time_ >= var_424_72 + var_424_73 and arg_421_1.time_ < var_424_72 + var_424_73 + arg_424_0 and not isNil(var_424_71) and arg_421_1.var_.characterEffect1027ui_story then
				local var_424_76 = 0.5

				arg_421_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1027ui_story.fillRatio = var_424_76
			end

			local var_424_77 = 3.8

			if var_424_77 < arg_421_1.time_ and arg_421_1.time_ <= var_424_77 + arg_424_0 then
				arg_421_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			local var_424_78 = arg_421_1.actors_["1027ui_story"]
			local var_424_79 = 3.80000000298023
			local var_424_80 = 0.2

			if var_424_79 < arg_421_1.time_ and arg_421_1.time_ <= var_424_79 + arg_424_0 then
				if arg_421_1.var_.characterEffect1027ui_story == nil then
					arg_421_1.var_.characterEffect1027ui_story = var_424_78:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_421_1.var_.characterEffect1027ui_story.imageEffect:turnOff()
			end

			local var_424_81 = arg_421_1.actors_["1027ui_story"]
			local var_424_82 = 3.8

			if var_424_82 < arg_421_1.time_ and arg_421_1.time_ <= var_424_82 + arg_424_0 then
				if arg_421_1.var_.characterEffect1027ui_story == nil then
					arg_421_1.var_.characterEffect1027ui_story = var_424_81:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_424_83 = arg_421_1.var_.characterEffect1027ui_story

				var_424_83.imageEffect:turnOff()

				var_424_83.interferenceEffect.enabled = false
				var_424_83.interferenceEffect.noise = 0.01
				var_424_83.interferenceEffect.simTimeScale = 1
				var_424_83.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if arg_421_1.frameCnt_ <= 1 then
				arg_421_1.dialog_:SetActive(false)
			end

			local var_424_84 = 4
			local var_424_85 = 0.35

			if var_424_84 < arg_421_1.time_ and arg_421_1.time_ <= var_424_84 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0

				arg_421_1.dialog_:SetActive(true)

				arg_421_1.dialogCg_.alpha = 0

				local var_424_86 = LeanTween.value(arg_421_1.dialog_, 0, 1, 0.3)

				var_424_86:setOnUpdate(LuaHelper.FloatAction(function(arg_425_0)
					arg_421_1.dialogCg_.alpha = arg_425_0
				end))
				var_424_86:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_421_1.dialog_)
					var_424_86:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_421_1.duration_ = arg_421_1.duration_ + 0.3

				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_87 = arg_421_1:FormatText(StoryNameCfg[55].name)

				arg_421_1.leftNameTxt_.text = var_424_87

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_88 = arg_421_1:GetWordFromCfg(1109703101)
				local var_424_89 = arg_421_1:FormatText(var_424_88.content)

				arg_421_1.text_.text = var_424_89

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_90 = 14
				local var_424_91 = utf8.len(var_424_89)
				local var_424_92 = var_424_90 <= 0 and var_424_85 or var_424_85 * (var_424_91 / var_424_90)

				if var_424_92 > 0 and var_424_85 < var_424_92 then
					arg_421_1.talkMaxDuration = var_424_92
					var_424_84 = var_424_84 + 0.3

					if var_424_92 + var_424_84 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_92 + var_424_84
					end
				end

				arg_421_1.text_.text = var_424_89
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703101", "story_v_side_new_1109703.awb") ~= 0 then
					local var_424_93 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703101", "story_v_side_new_1109703.awb") / 1000

					if var_424_93 + var_424_84 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_93 + var_424_84
					end

					if var_424_88.prefab_name ~= "" and arg_421_1.actors_[var_424_88.prefab_name] ~= nil then
						local var_424_94 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_88.prefab_name].transform, "story_v_side_new_1109703", "1109703101", "story_v_side_new_1109703.awb")

						arg_421_1:RecordAudio("1109703101", var_424_94)
						arg_421_1:RecordAudio("1109703101", var_424_94)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703101", "story_v_side_new_1109703.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703101", "story_v_side_new_1109703.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_95 = var_424_84 + 0.3
			local var_424_96 = math.max(var_424_85, arg_421_1.talkMaxDuration)

			if var_424_95 <= arg_421_1.time_ and arg_421_1.time_ < var_424_95 + var_424_96 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_95) / var_424_96

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_95 + var_424_96 and arg_421_1.time_ < var_424_95 + var_424_96 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play1109703102 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1109703102
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1109703103(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["1080ui_story"]
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect1080ui_story == nil then
				arg_427_1.var_.characterEffect1080ui_story = var_430_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.200000002980232

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 and not isNil(var_430_0) then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2

				if arg_427_1.var_.characterEffect1080ui_story and not isNil(var_430_0) then
					local var_430_4 = Mathf.Lerp(0, 0.5, var_430_3)

					arg_427_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1080ui_story.fillRatio = var_430_4
				end
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect1080ui_story then
				local var_430_5 = 0.5

				arg_427_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1080ui_story.fillRatio = var_430_5
			end

			local var_430_6 = 0
			local var_430_7 = 0.275

			if var_430_6 < arg_427_1.time_ and arg_427_1.time_ <= var_430_6 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_8 = arg_427_1:FormatText(StoryNameCfg[7].name)

				arg_427_1.leftNameTxt_.text = var_430_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_9 = arg_427_1:GetWordFromCfg(1109703102)
				local var_430_10 = arg_427_1:FormatText(var_430_9.content)

				arg_427_1.text_.text = var_430_10

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_11 = 11
				local var_430_12 = utf8.len(var_430_10)
				local var_430_13 = var_430_11 <= 0 and var_430_7 or var_430_7 * (var_430_12 / var_430_11)

				if var_430_13 > 0 and var_430_7 < var_430_13 then
					arg_427_1.talkMaxDuration = var_430_13

					if var_430_13 + var_430_6 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_13 + var_430_6
					end
				end

				arg_427_1.text_.text = var_430_10
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_14 = math.max(var_430_7, arg_427_1.talkMaxDuration)

			if var_430_6 <= arg_427_1.time_ and arg_427_1.time_ < var_430_6 + var_430_14 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_6) / var_430_14

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_6 + var_430_14 and arg_427_1.time_ < var_430_6 + var_430_14 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1109703103 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1109703103
		arg_431_1.duration_ = 8.23

		local var_431_0 = {
			zh = 8.233,
			ja = 8.2
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1109703104(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1027ui_story"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1027ui_story == nil then
				arg_431_1.var_.characterEffect1027ui_story = var_434_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.200000002980232

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 and not isNil(var_434_0) then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.characterEffect1027ui_story and not isNil(var_434_0) then
					arg_431_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1027ui_story then
				arg_431_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_434_4 = 0

			if var_434_4 < arg_431_1.time_ and arg_431_1.time_ <= var_434_4 + arg_434_0 then
				arg_431_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_434_5 = 0

			if var_434_5 < arg_431_1.time_ and arg_431_1.time_ <= var_434_5 + arg_434_0 then
				arg_431_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_434_6 = 0
			local var_434_7 = 0.925

			if var_434_6 < arg_431_1.time_ and arg_431_1.time_ <= var_434_6 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_8 = arg_431_1:FormatText(StoryNameCfg[56].name)

				arg_431_1.leftNameTxt_.text = var_434_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_9 = arg_431_1:GetWordFromCfg(1109703103)
				local var_434_10 = arg_431_1:FormatText(var_434_9.content)

				arg_431_1.text_.text = var_434_10

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_11 = 37
				local var_434_12 = utf8.len(var_434_10)
				local var_434_13 = var_434_11 <= 0 and var_434_7 or var_434_7 * (var_434_12 / var_434_11)

				if var_434_13 > 0 and var_434_7 < var_434_13 then
					arg_431_1.talkMaxDuration = var_434_13

					if var_434_13 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_13 + var_434_6
					end
				end

				arg_431_1.text_.text = var_434_10
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703103", "story_v_side_new_1109703.awb") ~= 0 then
					local var_434_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703103", "story_v_side_new_1109703.awb") / 1000

					if var_434_14 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_14 + var_434_6
					end

					if var_434_9.prefab_name ~= "" and arg_431_1.actors_[var_434_9.prefab_name] ~= nil then
						local var_434_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_9.prefab_name].transform, "story_v_side_new_1109703", "1109703103", "story_v_side_new_1109703.awb")

						arg_431_1:RecordAudio("1109703103", var_434_15)
						arg_431_1:RecordAudio("1109703103", var_434_15)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703103", "story_v_side_new_1109703.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703103", "story_v_side_new_1109703.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_16 = math.max(var_434_7, arg_431_1.talkMaxDuration)

			if var_434_6 <= arg_431_1.time_ and arg_431_1.time_ < var_434_6 + var_434_16 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_6) / var_434_16

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_6 + var_434_16 and arg_431_1.time_ < var_434_6 + var_434_16 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1109703104 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1109703104
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1109703105(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1027ui_story"]
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1027ui_story == nil then
				arg_435_1.var_.characterEffect1027ui_story = var_438_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.200000002980232

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 and not isNil(var_438_0) then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2

				if arg_435_1.var_.characterEffect1027ui_story and not isNil(var_438_0) then
					local var_438_4 = Mathf.Lerp(0, 0.5, var_438_3)

					arg_435_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1027ui_story.fillRatio = var_438_4
				end
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1027ui_story then
				local var_438_5 = 0.5

				arg_435_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1027ui_story.fillRatio = var_438_5
			end

			local var_438_6 = 0
			local var_438_7 = 1.25

			if var_438_6 < arg_435_1.time_ and arg_435_1.time_ <= var_438_6 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_8 = arg_435_1:FormatText(StoryNameCfg[7].name)

				arg_435_1.leftNameTxt_.text = var_438_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_9 = arg_435_1:GetWordFromCfg(1109703104)
				local var_438_10 = arg_435_1:FormatText(var_438_9.content)

				arg_435_1.text_.text = var_438_10

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_11 = 50
				local var_438_12 = utf8.len(var_438_10)
				local var_438_13 = var_438_11 <= 0 and var_438_7 or var_438_7 * (var_438_12 / var_438_11)

				if var_438_13 > 0 and var_438_7 < var_438_13 then
					arg_435_1.talkMaxDuration = var_438_13

					if var_438_13 + var_438_6 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_13 + var_438_6
					end
				end

				arg_435_1.text_.text = var_438_10
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_14 = math.max(var_438_7, arg_435_1.talkMaxDuration)

			if var_438_6 <= arg_435_1.time_ and arg_435_1.time_ < var_438_6 + var_438_14 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_6) / var_438_14

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_6 + var_438_14 and arg_435_1.time_ < var_438_6 + var_438_14 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1109703105 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1109703105
		arg_439_1.duration_ = 10.77

		local var_439_0 = {
			zh = 10.766,
			ja = 9.266
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1109703106(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = arg_439_1.actors_["1027ui_story"]
			local var_442_1 = 0

			if var_442_1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.characterEffect1027ui_story == nil then
				arg_439_1.var_.characterEffect1027ui_story = var_442_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_2 = 0.200000002980232

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_2 and not isNil(var_442_0) then
				local var_442_3 = (arg_439_1.time_ - var_442_1) / var_442_2

				if arg_439_1.var_.characterEffect1027ui_story and not isNil(var_442_0) then
					arg_439_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= var_442_1 + var_442_2 and arg_439_1.time_ < var_442_1 + var_442_2 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.characterEffect1027ui_story then
				arg_439_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_442_4 = 0

			if var_442_4 < arg_439_1.time_ and arg_439_1.time_ <= var_442_4 + arg_442_0 then
				arg_439_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action427")
			end

			local var_442_5 = 0

			if var_442_5 < arg_439_1.time_ and arg_439_1.time_ <= var_442_5 + arg_442_0 then
				arg_439_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_442_6 = 0
			local var_442_7 = 1.225

			if var_442_6 < arg_439_1.time_ and arg_439_1.time_ <= var_442_6 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_8 = arg_439_1:FormatText(StoryNameCfg[56].name)

				arg_439_1.leftNameTxt_.text = var_442_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_9 = arg_439_1:GetWordFromCfg(1109703105)
				local var_442_10 = arg_439_1:FormatText(var_442_9.content)

				arg_439_1.text_.text = var_442_10

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_11 = 49
				local var_442_12 = utf8.len(var_442_10)
				local var_442_13 = var_442_11 <= 0 and var_442_7 or var_442_7 * (var_442_12 / var_442_11)

				if var_442_13 > 0 and var_442_7 < var_442_13 then
					arg_439_1.talkMaxDuration = var_442_13

					if var_442_13 + var_442_6 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_13 + var_442_6
					end
				end

				arg_439_1.text_.text = var_442_10
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703105", "story_v_side_new_1109703.awb") ~= 0 then
					local var_442_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703105", "story_v_side_new_1109703.awb") / 1000

					if var_442_14 + var_442_6 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_14 + var_442_6
					end

					if var_442_9.prefab_name ~= "" and arg_439_1.actors_[var_442_9.prefab_name] ~= nil then
						local var_442_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_9.prefab_name].transform, "story_v_side_new_1109703", "1109703105", "story_v_side_new_1109703.awb")

						arg_439_1:RecordAudio("1109703105", var_442_15)
						arg_439_1:RecordAudio("1109703105", var_442_15)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703105", "story_v_side_new_1109703.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703105", "story_v_side_new_1109703.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_16 = math.max(var_442_7, arg_439_1.talkMaxDuration)

			if var_442_6 <= arg_439_1.time_ and arg_439_1.time_ < var_442_6 + var_442_16 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_6) / var_442_16

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_6 + var_442_16 and arg_439_1.time_ < var_442_6 + var_442_16 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1109703106 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1109703106
		arg_443_1.duration_ = 2

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1109703107(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["1080ui_story"]
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 and not isNil(var_446_0) and arg_443_1.var_.characterEffect1080ui_story == nil then
				arg_443_1.var_.characterEffect1080ui_story = var_446_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_2 = 0.200000002980232

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_2 and not isNil(var_446_0) then
				local var_446_3 = (arg_443_1.time_ - var_446_1) / var_446_2

				if arg_443_1.var_.characterEffect1080ui_story and not isNil(var_446_0) then
					arg_443_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_443_1.time_ >= var_446_1 + var_446_2 and arg_443_1.time_ < var_446_1 + var_446_2 + arg_446_0 and not isNil(var_446_0) and arg_443_1.var_.characterEffect1080ui_story then
				arg_443_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_446_4 = 0

			if var_446_4 < arg_443_1.time_ and arg_443_1.time_ <= var_446_4 + arg_446_0 then
				arg_443_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			local var_446_5 = 0

			if var_446_5 < arg_443_1.time_ and arg_443_1.time_ <= var_446_5 + arg_446_0 then
				arg_443_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_446_6 = arg_443_1.actors_["1027ui_story"]
			local var_446_7 = 0

			if var_446_7 < arg_443_1.time_ and arg_443_1.time_ <= var_446_7 + arg_446_0 and not isNil(var_446_6) and arg_443_1.var_.characterEffect1027ui_story == nil then
				arg_443_1.var_.characterEffect1027ui_story = var_446_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_8 = 0.200000002980232

			if var_446_7 <= arg_443_1.time_ and arg_443_1.time_ < var_446_7 + var_446_8 and not isNil(var_446_6) then
				local var_446_9 = (arg_443_1.time_ - var_446_7) / var_446_8

				if arg_443_1.var_.characterEffect1027ui_story and not isNil(var_446_6) then
					local var_446_10 = Mathf.Lerp(0, 0.5, var_446_9)

					arg_443_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1027ui_story.fillRatio = var_446_10
				end
			end

			if arg_443_1.time_ >= var_446_7 + var_446_8 and arg_443_1.time_ < var_446_7 + var_446_8 + arg_446_0 and not isNil(var_446_6) and arg_443_1.var_.characterEffect1027ui_story then
				local var_446_11 = 0.5

				arg_443_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1027ui_story.fillRatio = var_446_11
			end

			local var_446_12 = 0
			local var_446_13 = 0.125

			if var_446_12 < arg_443_1.time_ and arg_443_1.time_ <= var_446_12 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_14 = arg_443_1:FormatText(StoryNameCfg[55].name)

				arg_443_1.leftNameTxt_.text = var_446_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_15 = arg_443_1:GetWordFromCfg(1109703106)
				local var_446_16 = arg_443_1:FormatText(var_446_15.content)

				arg_443_1.text_.text = var_446_16

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_17 = 5
				local var_446_18 = utf8.len(var_446_16)
				local var_446_19 = var_446_17 <= 0 and var_446_13 or var_446_13 * (var_446_18 / var_446_17)

				if var_446_19 > 0 and var_446_13 < var_446_19 then
					arg_443_1.talkMaxDuration = var_446_19

					if var_446_19 + var_446_12 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_19 + var_446_12
					end
				end

				arg_443_1.text_.text = var_446_16
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703106", "story_v_side_new_1109703.awb") ~= 0 then
					local var_446_20 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703106", "story_v_side_new_1109703.awb") / 1000

					if var_446_20 + var_446_12 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_20 + var_446_12
					end

					if var_446_15.prefab_name ~= "" and arg_443_1.actors_[var_446_15.prefab_name] ~= nil then
						local var_446_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_15.prefab_name].transform, "story_v_side_new_1109703", "1109703106", "story_v_side_new_1109703.awb")

						arg_443_1:RecordAudio("1109703106", var_446_21)
						arg_443_1:RecordAudio("1109703106", var_446_21)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703106", "story_v_side_new_1109703.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703106", "story_v_side_new_1109703.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_22 = math.max(var_446_13, arg_443_1.talkMaxDuration)

			if var_446_12 <= arg_443_1.time_ and arg_443_1.time_ < var_446_12 + var_446_22 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_12) / var_446_22

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_12 + var_446_22 and arg_443_1.time_ < var_446_12 + var_446_22 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play1109703107 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1109703107
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1109703108(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["1080ui_story"]
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.characterEffect1080ui_story == nil then
				arg_447_1.var_.characterEffect1080ui_story = var_450_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_2 = 0.200000002980232

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_2 and not isNil(var_450_0) then
				local var_450_3 = (arg_447_1.time_ - var_450_1) / var_450_2

				if arg_447_1.var_.characterEffect1080ui_story and not isNil(var_450_0) then
					local var_450_4 = Mathf.Lerp(0, 0.5, var_450_3)

					arg_447_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_447_1.var_.characterEffect1080ui_story.fillRatio = var_450_4
				end
			end

			if arg_447_1.time_ >= var_450_1 + var_450_2 and arg_447_1.time_ < var_450_1 + var_450_2 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.characterEffect1080ui_story then
				local var_450_5 = 0.5

				arg_447_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_447_1.var_.characterEffect1080ui_story.fillRatio = var_450_5
			end

			local var_450_6 = 0
			local var_450_7 = 0.3

			if var_450_6 < arg_447_1.time_ and arg_447_1.time_ <= var_450_6 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_8 = arg_447_1:FormatText(StoryNameCfg[7].name)

				arg_447_1.leftNameTxt_.text = var_450_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_9 = arg_447_1:GetWordFromCfg(1109703107)
				local var_450_10 = arg_447_1:FormatText(var_450_9.content)

				arg_447_1.text_.text = var_450_10

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_11 = 12
				local var_450_12 = utf8.len(var_450_10)
				local var_450_13 = var_450_11 <= 0 and var_450_7 or var_450_7 * (var_450_12 / var_450_11)

				if var_450_13 > 0 and var_450_7 < var_450_13 then
					arg_447_1.talkMaxDuration = var_450_13

					if var_450_13 + var_450_6 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_13 + var_450_6
					end
				end

				arg_447_1.text_.text = var_450_10
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_14 = math.max(var_450_7, arg_447_1.talkMaxDuration)

			if var_450_6 <= arg_447_1.time_ and arg_447_1.time_ < var_450_6 + var_450_14 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_6) / var_450_14

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_6 + var_450_14 and arg_447_1.time_ < var_450_6 + var_450_14 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play1109703108 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1109703108
		arg_451_1.duration_ = 3.3

		local var_451_0 = {
			zh = 3.3,
			ja = 2.9
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1109703109(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["1097ui_story"].transform
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 then
				arg_451_1.var_.moveOldPos1097ui_story = var_454_0.localPosition
			end

			local var_454_2 = 0.001

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2
				local var_454_4 = Vector3.New(0, -0.54, -6.3)

				var_454_0.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1097ui_story, var_454_4, var_454_3)

				local var_454_5 = manager.ui.mainCamera.transform.position - var_454_0.position

				var_454_0.forward = Vector3.New(var_454_5.x, var_454_5.y, var_454_5.z)

				local var_454_6 = var_454_0.localEulerAngles

				var_454_6.z = 0
				var_454_6.x = 0
				var_454_0.localEulerAngles = var_454_6
			end

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 then
				var_454_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_454_7 = manager.ui.mainCamera.transform.position - var_454_0.position

				var_454_0.forward = Vector3.New(var_454_7.x, var_454_7.y, var_454_7.z)

				local var_454_8 = var_454_0.localEulerAngles

				var_454_8.z = 0
				var_454_8.x = 0
				var_454_0.localEulerAngles = var_454_8
			end

			local var_454_9 = arg_451_1.actors_["1097ui_story"]
			local var_454_10 = 0

			if var_454_10 < arg_451_1.time_ and arg_451_1.time_ <= var_454_10 + arg_454_0 and not isNil(var_454_9) and arg_451_1.var_.characterEffect1097ui_story == nil then
				arg_451_1.var_.characterEffect1097ui_story = var_454_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_11 = 0.200000002980232

			if var_454_10 <= arg_451_1.time_ and arg_451_1.time_ < var_454_10 + var_454_11 and not isNil(var_454_9) then
				local var_454_12 = (arg_451_1.time_ - var_454_10) / var_454_11

				if arg_451_1.var_.characterEffect1097ui_story and not isNil(var_454_9) then
					arg_451_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= var_454_10 + var_454_11 and arg_451_1.time_ < var_454_10 + var_454_11 + arg_454_0 and not isNil(var_454_9) and arg_451_1.var_.characterEffect1097ui_story then
				arg_451_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_454_13 = 0

			if var_454_13 < arg_451_1.time_ and arg_451_1.time_ <= var_454_13 + arg_454_0 then
				arg_451_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_454_14 = 0

			if var_454_14 < arg_451_1.time_ and arg_451_1.time_ <= var_454_14 + arg_454_0 then
				arg_451_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_454_15 = arg_451_1.actors_["1080ui_story"].transform
			local var_454_16 = 0

			if var_454_16 < arg_451_1.time_ and arg_451_1.time_ <= var_454_16 + arg_454_0 then
				arg_451_1.var_.moveOldPos1080ui_story = var_454_15.localPosition
			end

			local var_454_17 = 0.001

			if var_454_16 <= arg_451_1.time_ and arg_451_1.time_ < var_454_16 + var_454_17 then
				local var_454_18 = (arg_451_1.time_ - var_454_16) / var_454_17
				local var_454_19 = Vector3.New(0, 100, 0)

				var_454_15.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1080ui_story, var_454_19, var_454_18)

				local var_454_20 = manager.ui.mainCamera.transform.position - var_454_15.position

				var_454_15.forward = Vector3.New(var_454_20.x, var_454_20.y, var_454_20.z)

				local var_454_21 = var_454_15.localEulerAngles

				var_454_21.z = 0
				var_454_21.x = 0
				var_454_15.localEulerAngles = var_454_21
			end

			if arg_451_1.time_ >= var_454_16 + var_454_17 and arg_451_1.time_ < var_454_16 + var_454_17 + arg_454_0 then
				var_454_15.localPosition = Vector3.New(0, 100, 0)

				local var_454_22 = manager.ui.mainCamera.transform.position - var_454_15.position

				var_454_15.forward = Vector3.New(var_454_22.x, var_454_22.y, var_454_22.z)

				local var_454_23 = var_454_15.localEulerAngles

				var_454_23.z = 0
				var_454_23.x = 0
				var_454_15.localEulerAngles = var_454_23
			end

			local var_454_24 = arg_451_1.actors_["1080ui_story"]
			local var_454_25 = 0

			if var_454_25 < arg_451_1.time_ and arg_451_1.time_ <= var_454_25 + arg_454_0 and not isNil(var_454_24) and arg_451_1.var_.characterEffect1080ui_story == nil then
				arg_451_1.var_.characterEffect1080ui_story = var_454_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_26 = 0.200000002980232

			if var_454_25 <= arg_451_1.time_ and arg_451_1.time_ < var_454_25 + var_454_26 and not isNil(var_454_24) then
				local var_454_27 = (arg_451_1.time_ - var_454_25) / var_454_26

				if arg_451_1.var_.characterEffect1080ui_story and not isNil(var_454_24) then
					local var_454_28 = Mathf.Lerp(0, 0.5, var_454_27)

					arg_451_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1080ui_story.fillRatio = var_454_28
				end
			end

			if arg_451_1.time_ >= var_454_25 + var_454_26 and arg_451_1.time_ < var_454_25 + var_454_26 + arg_454_0 and not isNil(var_454_24) and arg_451_1.var_.characterEffect1080ui_story then
				local var_454_29 = 0.5

				arg_451_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1080ui_story.fillRatio = var_454_29
			end

			local var_454_30 = arg_451_1.actors_["1027ui_story"].transform
			local var_454_31 = 0

			if var_454_31 < arg_451_1.time_ and arg_451_1.time_ <= var_454_31 + arg_454_0 then
				arg_451_1.var_.moveOldPos1027ui_story = var_454_30.localPosition
			end

			local var_454_32 = 0.001

			if var_454_31 <= arg_451_1.time_ and arg_451_1.time_ < var_454_31 + var_454_32 then
				local var_454_33 = (arg_451_1.time_ - var_454_31) / var_454_32
				local var_454_34 = Vector3.New(0, 100, 0)

				var_454_30.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1027ui_story, var_454_34, var_454_33)

				local var_454_35 = manager.ui.mainCamera.transform.position - var_454_30.position

				var_454_30.forward = Vector3.New(var_454_35.x, var_454_35.y, var_454_35.z)

				local var_454_36 = var_454_30.localEulerAngles

				var_454_36.z = 0
				var_454_36.x = 0
				var_454_30.localEulerAngles = var_454_36
			end

			if arg_451_1.time_ >= var_454_31 + var_454_32 and arg_451_1.time_ < var_454_31 + var_454_32 + arg_454_0 then
				var_454_30.localPosition = Vector3.New(0, 100, 0)

				local var_454_37 = manager.ui.mainCamera.transform.position - var_454_30.position

				var_454_30.forward = Vector3.New(var_454_37.x, var_454_37.y, var_454_37.z)

				local var_454_38 = var_454_30.localEulerAngles

				var_454_38.z = 0
				var_454_38.x = 0
				var_454_30.localEulerAngles = var_454_38
			end

			local var_454_39 = arg_451_1.actors_["1027ui_story"]
			local var_454_40 = 0

			if var_454_40 < arg_451_1.time_ and arg_451_1.time_ <= var_454_40 + arg_454_0 and not isNil(var_454_39) and arg_451_1.var_.characterEffect1027ui_story == nil then
				arg_451_1.var_.characterEffect1027ui_story = var_454_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_41 = 0.200000002980232

			if var_454_40 <= arg_451_1.time_ and arg_451_1.time_ < var_454_40 + var_454_41 and not isNil(var_454_39) then
				local var_454_42 = (arg_451_1.time_ - var_454_40) / var_454_41

				if arg_451_1.var_.characterEffect1027ui_story and not isNil(var_454_39) then
					local var_454_43 = Mathf.Lerp(0, 0.5, var_454_42)

					arg_451_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1027ui_story.fillRatio = var_454_43
				end
			end

			if arg_451_1.time_ >= var_454_40 + var_454_41 and arg_451_1.time_ < var_454_40 + var_454_41 + arg_454_0 and not isNil(var_454_39) and arg_451_1.var_.characterEffect1027ui_story then
				local var_454_44 = 0.5

				arg_451_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1027ui_story.fillRatio = var_454_44
			end

			local var_454_45 = 0
			local var_454_46 = 0.3

			if var_454_45 < arg_451_1.time_ and arg_451_1.time_ <= var_454_45 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_47 = arg_451_1:FormatText(StoryNameCfg[216].name)

				arg_451_1.leftNameTxt_.text = var_454_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_48 = arg_451_1:GetWordFromCfg(1109703108)
				local var_454_49 = arg_451_1:FormatText(var_454_48.content)

				arg_451_1.text_.text = var_454_49

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_50 = 12
				local var_454_51 = utf8.len(var_454_49)
				local var_454_52 = var_454_50 <= 0 and var_454_46 or var_454_46 * (var_454_51 / var_454_50)

				if var_454_52 > 0 and var_454_46 < var_454_52 then
					arg_451_1.talkMaxDuration = var_454_52

					if var_454_52 + var_454_45 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_52 + var_454_45
					end
				end

				arg_451_1.text_.text = var_454_49
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703108", "story_v_side_new_1109703.awb") ~= 0 then
					local var_454_53 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703108", "story_v_side_new_1109703.awb") / 1000

					if var_454_53 + var_454_45 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_53 + var_454_45
					end

					if var_454_48.prefab_name ~= "" and arg_451_1.actors_[var_454_48.prefab_name] ~= nil then
						local var_454_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_48.prefab_name].transform, "story_v_side_new_1109703", "1109703108", "story_v_side_new_1109703.awb")

						arg_451_1:RecordAudio("1109703108", var_454_54)
						arg_451_1:RecordAudio("1109703108", var_454_54)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703108", "story_v_side_new_1109703.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703108", "story_v_side_new_1109703.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_55 = math.max(var_454_46, arg_451_1.talkMaxDuration)

			if var_454_45 <= arg_451_1.time_ and arg_451_1.time_ < var_454_45 + var_454_55 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_45) / var_454_55

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_45 + var_454_55 and arg_451_1.time_ < var_454_45 + var_454_55 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play1109703109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1109703109
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1109703110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["1097ui_story"].transform
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.var_.moveOldPos1097ui_story = var_458_0.localPosition
			end

			local var_458_2 = 0.001

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2
				local var_458_4 = Vector3.New(0, 100, 0)

				var_458_0.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos1097ui_story, var_458_4, var_458_3)

				local var_458_5 = manager.ui.mainCamera.transform.position - var_458_0.position

				var_458_0.forward = Vector3.New(var_458_5.x, var_458_5.y, var_458_5.z)

				local var_458_6 = var_458_0.localEulerAngles

				var_458_6.z = 0
				var_458_6.x = 0
				var_458_0.localEulerAngles = var_458_6
			end

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 then
				var_458_0.localPosition = Vector3.New(0, 100, 0)

				local var_458_7 = manager.ui.mainCamera.transform.position - var_458_0.position

				var_458_0.forward = Vector3.New(var_458_7.x, var_458_7.y, var_458_7.z)

				local var_458_8 = var_458_0.localEulerAngles

				var_458_8.z = 0
				var_458_8.x = 0
				var_458_0.localEulerAngles = var_458_8
			end

			local var_458_9 = arg_455_1.actors_["1097ui_story"]
			local var_458_10 = 0

			if var_458_10 < arg_455_1.time_ and arg_455_1.time_ <= var_458_10 + arg_458_0 and not isNil(var_458_9) and arg_455_1.var_.characterEffect1097ui_story == nil then
				arg_455_1.var_.characterEffect1097ui_story = var_458_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_11 = 0.200000002980232

			if var_458_10 <= arg_455_1.time_ and arg_455_1.time_ < var_458_10 + var_458_11 and not isNil(var_458_9) then
				local var_458_12 = (arg_455_1.time_ - var_458_10) / var_458_11

				if arg_455_1.var_.characterEffect1097ui_story and not isNil(var_458_9) then
					local var_458_13 = Mathf.Lerp(0, 0.5, var_458_12)

					arg_455_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_455_1.var_.characterEffect1097ui_story.fillRatio = var_458_13
				end
			end

			if arg_455_1.time_ >= var_458_10 + var_458_11 and arg_455_1.time_ < var_458_10 + var_458_11 + arg_458_0 and not isNil(var_458_9) and arg_455_1.var_.characterEffect1097ui_story then
				local var_458_14 = 0.5

				arg_455_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_455_1.var_.characterEffect1097ui_story.fillRatio = var_458_14
			end

			local var_458_15 = 0
			local var_458_16 = 0.5

			if var_458_15 < arg_455_1.time_ and arg_455_1.time_ <= var_458_15 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_17 = arg_455_1:GetWordFromCfg(1109703109)
				local var_458_18 = arg_455_1:FormatText(var_458_17.content)

				arg_455_1.text_.text = var_458_18

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_19 = 20
				local var_458_20 = utf8.len(var_458_18)
				local var_458_21 = var_458_19 <= 0 and var_458_16 or var_458_16 * (var_458_20 / var_458_19)

				if var_458_21 > 0 and var_458_16 < var_458_21 then
					arg_455_1.talkMaxDuration = var_458_21

					if var_458_21 + var_458_15 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_21 + var_458_15
					end
				end

				arg_455_1.text_.text = var_458_18
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_22 = math.max(var_458_16, arg_455_1.talkMaxDuration)

			if var_458_15 <= arg_455_1.time_ and arg_455_1.time_ < var_458_15 + var_458_22 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_15) / var_458_22

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_15 + var_458_22 and arg_455_1.time_ < var_458_15 + var_458_22 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play1109703110 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1109703110
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1109703111(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0
			local var_462_1 = 0.95

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_2 = arg_459_1:FormatText(StoryNameCfg[7].name)

				arg_459_1.leftNameTxt_.text = var_462_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, true)
				arg_459_1.iconController_:SetSelectedState("hero")

				arg_459_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_459_1.callingController_:SetSelectedState("normal")

				arg_459_1.keyicon_.color = Color.New(1, 1, 1)
				arg_459_1.icon_.color = Color.New(1, 1, 1)

				local var_462_3 = arg_459_1:GetWordFromCfg(1109703110)
				local var_462_4 = arg_459_1:FormatText(var_462_3.content)

				arg_459_1.text_.text = var_462_4

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_5 = 38
				local var_462_6 = utf8.len(var_462_4)
				local var_462_7 = var_462_5 <= 0 and var_462_1 or var_462_1 * (var_462_6 / var_462_5)

				if var_462_7 > 0 and var_462_1 < var_462_7 then
					arg_459_1.talkMaxDuration = var_462_7

					if var_462_7 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_7 + var_462_0
					end
				end

				arg_459_1.text_.text = var_462_4
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_8 = math.max(var_462_1, arg_459_1.talkMaxDuration)

			if var_462_0 <= arg_459_1.time_ and arg_459_1.time_ < var_462_0 + var_462_8 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_0) / var_462_8

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_0 + var_462_8 and arg_459_1.time_ < var_462_0 + var_462_8 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play1109703111 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1109703111
		arg_463_1.duration_ = 4.6

		local var_463_0 = {
			zh = 4.433,
			ja = 4.6
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1109703112(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = arg_463_1.actors_["1080ui_story"].transform
			local var_466_1 = 0

			if var_466_1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 then
				arg_463_1.var_.moveOldPos1080ui_story = var_466_0.localPosition
			end

			local var_466_2 = 0.001

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_2 then
				local var_466_3 = (arg_463_1.time_ - var_466_1) / var_466_2
				local var_466_4 = Vector3.New(0.7, -1.01, -6.05)

				var_466_0.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos1080ui_story, var_466_4, var_466_3)

				local var_466_5 = manager.ui.mainCamera.transform.position - var_466_0.position

				var_466_0.forward = Vector3.New(var_466_5.x, var_466_5.y, var_466_5.z)

				local var_466_6 = var_466_0.localEulerAngles

				var_466_6.z = 0
				var_466_6.x = 0
				var_466_0.localEulerAngles = var_466_6
			end

			if arg_463_1.time_ >= var_466_1 + var_466_2 and arg_463_1.time_ < var_466_1 + var_466_2 + arg_466_0 then
				var_466_0.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_466_7 = manager.ui.mainCamera.transform.position - var_466_0.position

				var_466_0.forward = Vector3.New(var_466_7.x, var_466_7.y, var_466_7.z)

				local var_466_8 = var_466_0.localEulerAngles

				var_466_8.z = 0
				var_466_8.x = 0
				var_466_0.localEulerAngles = var_466_8
			end

			local var_466_9 = arg_463_1.actors_["1080ui_story"]
			local var_466_10 = 0

			if var_466_10 < arg_463_1.time_ and arg_463_1.time_ <= var_466_10 + arg_466_0 and not isNil(var_466_9) and arg_463_1.var_.characterEffect1080ui_story == nil then
				arg_463_1.var_.characterEffect1080ui_story = var_466_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_11 = 0.200000002980232

			if var_466_10 <= arg_463_1.time_ and arg_463_1.time_ < var_466_10 + var_466_11 and not isNil(var_466_9) then
				local var_466_12 = (arg_463_1.time_ - var_466_10) / var_466_11

				if arg_463_1.var_.characterEffect1080ui_story and not isNil(var_466_9) then
					arg_463_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_463_1.time_ >= var_466_10 + var_466_11 and arg_463_1.time_ < var_466_10 + var_466_11 + arg_466_0 and not isNil(var_466_9) and arg_463_1.var_.characterEffect1080ui_story then
				arg_463_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_466_13 = 0

			if var_466_13 < arg_463_1.time_ and arg_463_1.time_ <= var_466_13 + arg_466_0 then
				arg_463_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			local var_466_14 = 0

			if var_466_14 < arg_463_1.time_ and arg_463_1.time_ <= var_466_14 + arg_466_0 then
				arg_463_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_466_15 = arg_463_1.actors_["1027ui_story"].transform
			local var_466_16 = 0

			if var_466_16 < arg_463_1.time_ and arg_463_1.time_ <= var_466_16 + arg_466_0 then
				arg_463_1.var_.moveOldPos1027ui_story = var_466_15.localPosition
			end

			local var_466_17 = 0.001

			if var_466_16 <= arg_463_1.time_ and arg_463_1.time_ < var_466_16 + var_466_17 then
				local var_466_18 = (arg_463_1.time_ - var_466_16) / var_466_17
				local var_466_19 = Vector3.New(-0.7, -0.81, -5.8)

				var_466_15.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos1027ui_story, var_466_19, var_466_18)

				local var_466_20 = manager.ui.mainCamera.transform.position - var_466_15.position

				var_466_15.forward = Vector3.New(var_466_20.x, var_466_20.y, var_466_20.z)

				local var_466_21 = var_466_15.localEulerAngles

				var_466_21.z = 0
				var_466_21.x = 0
				var_466_15.localEulerAngles = var_466_21
			end

			if arg_463_1.time_ >= var_466_16 + var_466_17 and arg_463_1.time_ < var_466_16 + var_466_17 + arg_466_0 then
				var_466_15.localPosition = Vector3.New(-0.7, -0.81, -5.8)

				local var_466_22 = manager.ui.mainCamera.transform.position - var_466_15.position

				var_466_15.forward = Vector3.New(var_466_22.x, var_466_22.y, var_466_22.z)

				local var_466_23 = var_466_15.localEulerAngles

				var_466_23.z = 0
				var_466_23.x = 0
				var_466_15.localEulerAngles = var_466_23
			end

			local var_466_24 = arg_463_1.actors_["1027ui_story"]
			local var_466_25 = 0

			if var_466_25 < arg_463_1.time_ and arg_463_1.time_ <= var_466_25 + arg_466_0 and not isNil(var_466_24) and arg_463_1.var_.characterEffect1027ui_story == nil then
				arg_463_1.var_.characterEffect1027ui_story = var_466_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_26 = 0.200000002980232

			if var_466_25 <= arg_463_1.time_ and arg_463_1.time_ < var_466_25 + var_466_26 and not isNil(var_466_24) then
				local var_466_27 = (arg_463_1.time_ - var_466_25) / var_466_26

				if arg_463_1.var_.characterEffect1027ui_story and not isNil(var_466_24) then
					local var_466_28 = Mathf.Lerp(0, 0.5, var_466_27)

					arg_463_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_463_1.var_.characterEffect1027ui_story.fillRatio = var_466_28
				end
			end

			if arg_463_1.time_ >= var_466_25 + var_466_26 and arg_463_1.time_ < var_466_25 + var_466_26 + arg_466_0 and not isNil(var_466_24) and arg_463_1.var_.characterEffect1027ui_story then
				local var_466_29 = 0.5

				arg_463_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_463_1.var_.characterEffect1027ui_story.fillRatio = var_466_29
			end

			local var_466_30 = 0

			if var_466_30 < arg_463_1.time_ and arg_463_1.time_ <= var_466_30 + arg_466_0 then
				arg_463_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action472")
			end

			local var_466_31 = 0
			local var_466_32 = 0.45

			if var_466_31 < arg_463_1.time_ and arg_463_1.time_ <= var_466_31 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_33 = arg_463_1:FormatText(StoryNameCfg[55].name)

				arg_463_1.leftNameTxt_.text = var_466_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_34 = arg_463_1:GetWordFromCfg(1109703111)
				local var_466_35 = arg_463_1:FormatText(var_466_34.content)

				arg_463_1.text_.text = var_466_35

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_36 = 18
				local var_466_37 = utf8.len(var_466_35)
				local var_466_38 = var_466_36 <= 0 and var_466_32 or var_466_32 * (var_466_37 / var_466_36)

				if var_466_38 > 0 and var_466_32 < var_466_38 then
					arg_463_1.talkMaxDuration = var_466_38

					if var_466_38 + var_466_31 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_38 + var_466_31
					end
				end

				arg_463_1.text_.text = var_466_35
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703111", "story_v_side_new_1109703.awb") ~= 0 then
					local var_466_39 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703111", "story_v_side_new_1109703.awb") / 1000

					if var_466_39 + var_466_31 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_39 + var_466_31
					end

					if var_466_34.prefab_name ~= "" and arg_463_1.actors_[var_466_34.prefab_name] ~= nil then
						local var_466_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_34.prefab_name].transform, "story_v_side_new_1109703", "1109703111", "story_v_side_new_1109703.awb")

						arg_463_1:RecordAudio("1109703111", var_466_40)
						arg_463_1:RecordAudio("1109703111", var_466_40)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703111", "story_v_side_new_1109703.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703111", "story_v_side_new_1109703.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_41 = math.max(var_466_32, arg_463_1.talkMaxDuration)

			if var_466_31 <= arg_463_1.time_ and arg_463_1.time_ < var_466_31 + var_466_41 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_31) / var_466_41

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_31 + var_466_41 and arg_463_1.time_ < var_466_31 + var_466_41 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_463_1:InitPlayNodeList()
	end,
	Play1109703112 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1109703112
		arg_467_1.duration_ = 5.57

		local var_467_0 = {
			zh = 4.533,
			ja = 5.566
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1109703113(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = arg_467_1.actors_["1027ui_story"]
			local var_470_1 = 0

			if var_470_1 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 and not isNil(var_470_0) and arg_467_1.var_.characterEffect1027ui_story == nil then
				arg_467_1.var_.characterEffect1027ui_story = var_470_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_2 = 0.200000002980232

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_2 and not isNil(var_470_0) then
				local var_470_3 = (arg_467_1.time_ - var_470_1) / var_470_2

				if arg_467_1.var_.characterEffect1027ui_story and not isNil(var_470_0) then
					arg_467_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= var_470_1 + var_470_2 and arg_467_1.time_ < var_470_1 + var_470_2 + arg_470_0 and not isNil(var_470_0) and arg_467_1.var_.characterEffect1027ui_story then
				arg_467_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_470_4 = arg_467_1.actors_["1080ui_story"]
			local var_470_5 = 0

			if var_470_5 < arg_467_1.time_ and arg_467_1.time_ <= var_470_5 + arg_470_0 and not isNil(var_470_4) and arg_467_1.var_.characterEffect1080ui_story == nil then
				arg_467_1.var_.characterEffect1080ui_story = var_470_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_6 = 0.200000002980232

			if var_470_5 <= arg_467_1.time_ and arg_467_1.time_ < var_470_5 + var_470_6 and not isNil(var_470_4) then
				local var_470_7 = (arg_467_1.time_ - var_470_5) / var_470_6

				if arg_467_1.var_.characterEffect1080ui_story and not isNil(var_470_4) then
					local var_470_8 = Mathf.Lerp(0, 0.5, var_470_7)

					arg_467_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_467_1.var_.characterEffect1080ui_story.fillRatio = var_470_8
				end
			end

			if arg_467_1.time_ >= var_470_5 + var_470_6 and arg_467_1.time_ < var_470_5 + var_470_6 + arg_470_0 and not isNil(var_470_4) and arg_467_1.var_.characterEffect1080ui_story then
				local var_470_9 = 0.5

				arg_467_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_467_1.var_.characterEffect1080ui_story.fillRatio = var_470_9
			end

			local var_470_10 = 0
			local var_470_11 = 0.55

			if var_470_10 < arg_467_1.time_ and arg_467_1.time_ <= var_470_10 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_12 = arg_467_1:FormatText(StoryNameCfg[56].name)

				arg_467_1.leftNameTxt_.text = var_470_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_13 = arg_467_1:GetWordFromCfg(1109703112)
				local var_470_14 = arg_467_1:FormatText(var_470_13.content)

				arg_467_1.text_.text = var_470_14

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_15 = 22
				local var_470_16 = utf8.len(var_470_14)
				local var_470_17 = var_470_15 <= 0 and var_470_11 or var_470_11 * (var_470_16 / var_470_15)

				if var_470_17 > 0 and var_470_11 < var_470_17 then
					arg_467_1.talkMaxDuration = var_470_17

					if var_470_17 + var_470_10 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_17 + var_470_10
					end
				end

				arg_467_1.text_.text = var_470_14
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703112", "story_v_side_new_1109703.awb") ~= 0 then
					local var_470_18 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703112", "story_v_side_new_1109703.awb") / 1000

					if var_470_18 + var_470_10 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_18 + var_470_10
					end

					if var_470_13.prefab_name ~= "" and arg_467_1.actors_[var_470_13.prefab_name] ~= nil then
						local var_470_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_13.prefab_name].transform, "story_v_side_new_1109703", "1109703112", "story_v_side_new_1109703.awb")

						arg_467_1:RecordAudio("1109703112", var_470_19)
						arg_467_1:RecordAudio("1109703112", var_470_19)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703112", "story_v_side_new_1109703.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703112", "story_v_side_new_1109703.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_20 = math.max(var_470_11, arg_467_1.talkMaxDuration)

			if var_470_10 <= arg_467_1.time_ and arg_467_1.time_ < var_470_10 + var_470_20 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_10) / var_470_20

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_10 + var_470_20 and arg_467_1.time_ < var_470_10 + var_470_20 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1109703113 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1109703113
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1109703114(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = arg_471_1.actors_["1027ui_story"]
			local var_474_1 = 0

			if var_474_1 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 and not isNil(var_474_0) and arg_471_1.var_.characterEffect1027ui_story == nil then
				arg_471_1.var_.characterEffect1027ui_story = var_474_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_2 = 0.200000002980232

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_2 and not isNil(var_474_0) then
				local var_474_3 = (arg_471_1.time_ - var_474_1) / var_474_2

				if arg_471_1.var_.characterEffect1027ui_story and not isNil(var_474_0) then
					local var_474_4 = Mathf.Lerp(0, 0.5, var_474_3)

					arg_471_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_471_1.var_.characterEffect1027ui_story.fillRatio = var_474_4
				end
			end

			if arg_471_1.time_ >= var_474_1 + var_474_2 and arg_471_1.time_ < var_474_1 + var_474_2 + arg_474_0 and not isNil(var_474_0) and arg_471_1.var_.characterEffect1027ui_story then
				local var_474_5 = 0.5

				arg_471_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_471_1.var_.characterEffect1027ui_story.fillRatio = var_474_5
			end

			local var_474_6 = 0
			local var_474_7 = 0.85

			if var_474_6 < arg_471_1.time_ and arg_471_1.time_ <= var_474_6 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_8 = arg_471_1:GetWordFromCfg(1109703113)
				local var_474_9 = arg_471_1:FormatText(var_474_8.content)

				arg_471_1.text_.text = var_474_9

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_10 = 34
				local var_474_11 = utf8.len(var_474_9)
				local var_474_12 = var_474_10 <= 0 and var_474_7 or var_474_7 * (var_474_11 / var_474_10)

				if var_474_12 > 0 and var_474_7 < var_474_12 then
					arg_471_1.talkMaxDuration = var_474_12

					if var_474_12 + var_474_6 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_12 + var_474_6
					end
				end

				arg_471_1.text_.text = var_474_9
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_13 = math.max(var_474_7, arg_471_1.talkMaxDuration)

			if var_474_6 <= arg_471_1.time_ and arg_471_1.time_ < var_474_6 + var_474_13 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_6) / var_474_13

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_6 + var_474_13 and arg_471_1.time_ < var_474_6 + var_474_13 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play1109703114 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 1109703114
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play1109703115(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = arg_475_1.actors_["1080ui_story"].transform
			local var_478_1 = 0

			if var_478_1 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 then
				arg_475_1.var_.moveOldPos1080ui_story = var_478_0.localPosition
			end

			local var_478_2 = 0.001

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_2 then
				local var_478_3 = (arg_475_1.time_ - var_478_1) / var_478_2
				local var_478_4 = Vector3.New(0, 100, 0)

				var_478_0.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1080ui_story, var_478_4, var_478_3)

				local var_478_5 = manager.ui.mainCamera.transform.position - var_478_0.position

				var_478_0.forward = Vector3.New(var_478_5.x, var_478_5.y, var_478_5.z)

				local var_478_6 = var_478_0.localEulerAngles

				var_478_6.z = 0
				var_478_6.x = 0
				var_478_0.localEulerAngles = var_478_6
			end

			if arg_475_1.time_ >= var_478_1 + var_478_2 and arg_475_1.time_ < var_478_1 + var_478_2 + arg_478_0 then
				var_478_0.localPosition = Vector3.New(0, 100, 0)

				local var_478_7 = manager.ui.mainCamera.transform.position - var_478_0.position

				var_478_0.forward = Vector3.New(var_478_7.x, var_478_7.y, var_478_7.z)

				local var_478_8 = var_478_0.localEulerAngles

				var_478_8.z = 0
				var_478_8.x = 0
				var_478_0.localEulerAngles = var_478_8
			end

			local var_478_9 = arg_475_1.actors_["1080ui_story"]
			local var_478_10 = 0

			if var_478_10 < arg_475_1.time_ and arg_475_1.time_ <= var_478_10 + arg_478_0 and not isNil(var_478_9) and arg_475_1.var_.characterEffect1080ui_story == nil then
				arg_475_1.var_.characterEffect1080ui_story = var_478_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_11 = 0.200000002980232

			if var_478_10 <= arg_475_1.time_ and arg_475_1.time_ < var_478_10 + var_478_11 and not isNil(var_478_9) then
				local var_478_12 = (arg_475_1.time_ - var_478_10) / var_478_11

				if arg_475_1.var_.characterEffect1080ui_story and not isNil(var_478_9) then
					local var_478_13 = Mathf.Lerp(0, 0.5, var_478_12)

					arg_475_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_475_1.var_.characterEffect1080ui_story.fillRatio = var_478_13
				end
			end

			if arg_475_1.time_ >= var_478_10 + var_478_11 and arg_475_1.time_ < var_478_10 + var_478_11 + arg_478_0 and not isNil(var_478_9) and arg_475_1.var_.characterEffect1080ui_story then
				local var_478_14 = 0.5

				arg_475_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_475_1.var_.characterEffect1080ui_story.fillRatio = var_478_14
			end

			local var_478_15 = arg_475_1.actors_["1027ui_story"].transform
			local var_478_16 = 0

			if var_478_16 < arg_475_1.time_ and arg_475_1.time_ <= var_478_16 + arg_478_0 then
				arg_475_1.var_.moveOldPos1027ui_story = var_478_15.localPosition
			end

			local var_478_17 = 0.001

			if var_478_16 <= arg_475_1.time_ and arg_475_1.time_ < var_478_16 + var_478_17 then
				local var_478_18 = (arg_475_1.time_ - var_478_16) / var_478_17
				local var_478_19 = Vector3.New(0, 100, 0)

				var_478_15.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1027ui_story, var_478_19, var_478_18)

				local var_478_20 = manager.ui.mainCamera.transform.position - var_478_15.position

				var_478_15.forward = Vector3.New(var_478_20.x, var_478_20.y, var_478_20.z)

				local var_478_21 = var_478_15.localEulerAngles

				var_478_21.z = 0
				var_478_21.x = 0
				var_478_15.localEulerAngles = var_478_21
			end

			if arg_475_1.time_ >= var_478_16 + var_478_17 and arg_475_1.time_ < var_478_16 + var_478_17 + arg_478_0 then
				var_478_15.localPosition = Vector3.New(0, 100, 0)

				local var_478_22 = manager.ui.mainCamera.transform.position - var_478_15.position

				var_478_15.forward = Vector3.New(var_478_22.x, var_478_22.y, var_478_22.z)

				local var_478_23 = var_478_15.localEulerAngles

				var_478_23.z = 0
				var_478_23.x = 0
				var_478_15.localEulerAngles = var_478_23
			end

			local var_478_24 = arg_475_1.actors_["1027ui_story"]
			local var_478_25 = 0

			if var_478_25 < arg_475_1.time_ and arg_475_1.time_ <= var_478_25 + arg_478_0 and not isNil(var_478_24) and arg_475_1.var_.characterEffect1027ui_story == nil then
				arg_475_1.var_.characterEffect1027ui_story = var_478_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_26 = 0.200000002980232

			if var_478_25 <= arg_475_1.time_ and arg_475_1.time_ < var_478_25 + var_478_26 and not isNil(var_478_24) then
				local var_478_27 = (arg_475_1.time_ - var_478_25) / var_478_26

				if arg_475_1.var_.characterEffect1027ui_story and not isNil(var_478_24) then
					local var_478_28 = Mathf.Lerp(0, 0.5, var_478_27)

					arg_475_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_475_1.var_.characterEffect1027ui_story.fillRatio = var_478_28
				end
			end

			if arg_475_1.time_ >= var_478_25 + var_478_26 and arg_475_1.time_ < var_478_25 + var_478_26 + arg_478_0 and not isNil(var_478_24) and arg_475_1.var_.characterEffect1027ui_story then
				local var_478_29 = 0.5

				arg_475_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_475_1.var_.characterEffect1027ui_story.fillRatio = var_478_29
			end

			local var_478_30 = 0
			local var_478_31 = 0.925

			if var_478_30 < arg_475_1.time_ and arg_475_1.time_ <= var_478_30 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_32 = arg_475_1:FormatText(StoryNameCfg[7].name)

				arg_475_1.leftNameTxt_.text = var_478_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_33 = arg_475_1:GetWordFromCfg(1109703114)
				local var_478_34 = arg_475_1:FormatText(var_478_33.content)

				arg_475_1.text_.text = var_478_34

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_35 = 37
				local var_478_36 = utf8.len(var_478_34)
				local var_478_37 = var_478_35 <= 0 and var_478_31 or var_478_31 * (var_478_36 / var_478_35)

				if var_478_37 > 0 and var_478_31 < var_478_37 then
					arg_475_1.talkMaxDuration = var_478_37

					if var_478_37 + var_478_30 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_37 + var_478_30
					end
				end

				arg_475_1.text_.text = var_478_34
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_38 = math.max(var_478_31, arg_475_1.talkMaxDuration)

			if var_478_30 <= arg_475_1.time_ and arg_475_1.time_ < var_478_30 + var_478_38 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_30) / var_478_38

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_30 + var_478_38 and arg_475_1.time_ < var_478_30 + var_478_38 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_475_1:InitPlayNodeList()
	end,
	Play1109703115 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 1109703115
		arg_479_1.duration_ = 5.63

		local var_479_0 = {
			zh = 1.533,
			ja = 5.633
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play1109703116(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = arg_479_1.actors_["1097ui_story"].transform
			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 then
				arg_479_1.var_.moveOldPos1097ui_story = var_482_0.localPosition
			end

			local var_482_2 = 0.001

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_2 then
				local var_482_3 = (arg_479_1.time_ - var_482_1) / var_482_2
				local var_482_4 = Vector3.New(0, -0.54, -6.3)

				var_482_0.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos1097ui_story, var_482_4, var_482_3)

				local var_482_5 = manager.ui.mainCamera.transform.position - var_482_0.position

				var_482_0.forward = Vector3.New(var_482_5.x, var_482_5.y, var_482_5.z)

				local var_482_6 = var_482_0.localEulerAngles

				var_482_6.z = 0
				var_482_6.x = 0
				var_482_0.localEulerAngles = var_482_6
			end

			if arg_479_1.time_ >= var_482_1 + var_482_2 and arg_479_1.time_ < var_482_1 + var_482_2 + arg_482_0 then
				var_482_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_482_7 = manager.ui.mainCamera.transform.position - var_482_0.position

				var_482_0.forward = Vector3.New(var_482_7.x, var_482_7.y, var_482_7.z)

				local var_482_8 = var_482_0.localEulerAngles

				var_482_8.z = 0
				var_482_8.x = 0
				var_482_0.localEulerAngles = var_482_8
			end

			local var_482_9 = arg_479_1.actors_["1097ui_story"]
			local var_482_10 = 0

			if var_482_10 < arg_479_1.time_ and arg_479_1.time_ <= var_482_10 + arg_482_0 and not isNil(var_482_9) and arg_479_1.var_.characterEffect1097ui_story == nil then
				arg_479_1.var_.characterEffect1097ui_story = var_482_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_11 = 0.200000002980232

			if var_482_10 <= arg_479_1.time_ and arg_479_1.time_ < var_482_10 + var_482_11 and not isNil(var_482_9) then
				local var_482_12 = (arg_479_1.time_ - var_482_10) / var_482_11

				if arg_479_1.var_.characterEffect1097ui_story and not isNil(var_482_9) then
					arg_479_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_479_1.time_ >= var_482_10 + var_482_11 and arg_479_1.time_ < var_482_10 + var_482_11 + arg_482_0 and not isNil(var_482_9) and arg_479_1.var_.characterEffect1097ui_story then
				arg_479_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_482_13 = 0

			if var_482_13 < arg_479_1.time_ and arg_479_1.time_ <= var_482_13 + arg_482_0 then
				arg_479_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_482_14 = 0

			if var_482_14 < arg_479_1.time_ and arg_479_1.time_ <= var_482_14 + arg_482_0 then
				arg_479_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_482_15 = 0
			local var_482_16 = 0.2

			if var_482_15 < arg_479_1.time_ and arg_479_1.time_ <= var_482_15 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_17 = arg_479_1:FormatText(StoryNameCfg[216].name)

				arg_479_1.leftNameTxt_.text = var_482_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_18 = arg_479_1:GetWordFromCfg(1109703115)
				local var_482_19 = arg_479_1:FormatText(var_482_18.content)

				arg_479_1.text_.text = var_482_19

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_20 = 8
				local var_482_21 = utf8.len(var_482_19)
				local var_482_22 = var_482_20 <= 0 and var_482_16 or var_482_16 * (var_482_21 / var_482_20)

				if var_482_22 > 0 and var_482_16 < var_482_22 then
					arg_479_1.talkMaxDuration = var_482_22

					if var_482_22 + var_482_15 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_22 + var_482_15
					end
				end

				arg_479_1.text_.text = var_482_19
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703115", "story_v_side_new_1109703.awb") ~= 0 then
					local var_482_23 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703115", "story_v_side_new_1109703.awb") / 1000

					if var_482_23 + var_482_15 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_23 + var_482_15
					end

					if var_482_18.prefab_name ~= "" and arg_479_1.actors_[var_482_18.prefab_name] ~= nil then
						local var_482_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_18.prefab_name].transform, "story_v_side_new_1109703", "1109703115", "story_v_side_new_1109703.awb")

						arg_479_1:RecordAudio("1109703115", var_482_24)
						arg_479_1:RecordAudio("1109703115", var_482_24)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703115", "story_v_side_new_1109703.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703115", "story_v_side_new_1109703.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_25 = math.max(var_482_16, arg_479_1.talkMaxDuration)

			if var_482_15 <= arg_479_1.time_ and arg_479_1.time_ < var_482_15 + var_482_25 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_15) / var_482_25

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_15 + var_482_25 and arg_479_1.time_ < var_482_15 + var_482_25 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_479_1:InitPlayNodeList()
	end,
	Play1109703116 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1109703116
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
			arg_483_1.auto_ = false
		end

		function arg_483_1.playNext_(arg_485_0)
			arg_483_1.onStoryFinished_()
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = arg_483_1.actors_["1097ui_story"]
			local var_486_1 = 0

			if var_486_1 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 and not isNil(var_486_0) and arg_483_1.var_.characterEffect1097ui_story == nil then
				arg_483_1.var_.characterEffect1097ui_story = var_486_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_2 = 0.200000002980232

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_2 and not isNil(var_486_0) then
				local var_486_3 = (arg_483_1.time_ - var_486_1) / var_486_2

				if arg_483_1.var_.characterEffect1097ui_story and not isNil(var_486_0) then
					local var_486_4 = Mathf.Lerp(0, 0.5, var_486_3)

					arg_483_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_483_1.var_.characterEffect1097ui_story.fillRatio = var_486_4
				end
			end

			if arg_483_1.time_ >= var_486_1 + var_486_2 and arg_483_1.time_ < var_486_1 + var_486_2 + arg_486_0 and not isNil(var_486_0) and arg_483_1.var_.characterEffect1097ui_story then
				local var_486_5 = 0.5

				arg_483_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_483_1.var_.characterEffect1097ui_story.fillRatio = var_486_5
			end

			local var_486_6 = 0
			local var_486_7 = 0.05

			if var_486_6 < arg_483_1.time_ and arg_483_1.time_ <= var_486_6 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				local var_486_8 = arg_483_1:FormatText(StoryNameCfg[7].name)

				arg_483_1.leftNameTxt_.text = var_486_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, true)
				arg_483_1.iconController_:SetSelectedState("hero")

				arg_483_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_483_1.callingController_:SetSelectedState("normal")

				arg_483_1.keyicon_.color = Color.New(1, 1, 1)
				arg_483_1.icon_.color = Color.New(1, 1, 1)

				local var_486_9 = arg_483_1:GetWordFromCfg(1109703116)
				local var_486_10 = arg_483_1:FormatText(var_486_9.content)

				arg_483_1.text_.text = var_486_10

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_11 = 2
				local var_486_12 = utf8.len(var_486_10)
				local var_486_13 = var_486_11 <= 0 and var_486_7 or var_486_7 * (var_486_12 / var_486_11)

				if var_486_13 > 0 and var_486_7 < var_486_13 then
					arg_483_1.talkMaxDuration = var_486_13

					if var_486_13 + var_486_6 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_13 + var_486_6
					end
				end

				arg_483_1.text_.text = var_486_10
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_14 = math.max(var_486_7, arg_483_1.talkMaxDuration)

			if var_486_6 <= arg_483_1.time_ and arg_483_1.time_ < var_486_6 + var_486_14 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_6) / var_486_14

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_6 + var_486_14 and arg_483_1.time_ < var_486_6 + var_486_14 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST01"
	},
	voices = {
		"story_v_side_new_1109703.awb"
	}
}
