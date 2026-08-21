return {
	Play1109704001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109704001
		arg_1_1.duration_ = 5.23

		local var_1_0 = {
			zh = 3.766666666666,
			ja = 5.233
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
				arg_1_0:Play1109704002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST01"

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
				local var_4_5 = arg_1_1.bgs_.ST01

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
					if iter_4_0 ~= "ST01" then
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

			local var_4_22 = "1097ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1097ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1097ui_story"].transform
			local var_4_28 = 1.76666666666667

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1097ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -0.54, -6.3)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1097ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["1097ui_story"]
			local var_4_37 = 1.76666666666667

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1097ui_story == nil then
				arg_1_1.var_.characterEffect1097ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect1097ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1097ui_story then
				arg_1_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_4_40 = 1.76666666666667

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_4_41 = 1.76666666666667

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			local var_4_54 = 2
			local var_4_55 = 0.2

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

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[216].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(1109704001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 8
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704001", "story_v_side_new_1109704.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704001", "story_v_side_new_1109704.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_side_new_1109704", "1109704001", "story_v_side_new_1109704.awb")

						arg_1_1:RecordAudio("1109704001", var_4_64)
						arg_1_1:RecordAudio("1109704001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704001", "story_v_side_new_1109704.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704001", "story_v_side_new_1109704.awb")
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
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play1109704002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1109704002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1109704003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1097ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1097ui_story == nil then
				arg_9_1.var_.characterEffect1097ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect1097ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1097ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1097ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1097ui_story.fillRatio = var_12_5
			end

			local var_12_6 = 0
			local var_12_7 = 0.725

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

				local var_12_8 = arg_9_1:GetWordFromCfg(1109704002)
				local var_12_9 = arg_9_1:FormatText(var_12_8.content)

				arg_9_1.text_.text = var_12_9

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_10 = 29
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
	Play1109704003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1109704003
		arg_13_1.duration_ = 5.07

		local var_13_0 = {
			zh = 4.4,
			ja = 5.066
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
				arg_13_0:Play1109704004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1097ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1097ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1097ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["1097ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1097ui_story == nil then
				arg_13_1.var_.characterEffect1097ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect1097ui_story and not isNil(var_16_9) then
					local var_16_13 = Mathf.Lerp(0, 0.5, var_16_12)

					arg_13_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1097ui_story.fillRatio = var_16_13
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1097ui_story then
				local var_16_14 = 0.5

				arg_13_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1097ui_story.fillRatio = var_16_14
			end

			local var_16_15 = "1027ui_story"

			if arg_13_1.actors_[var_16_15] == nil then
				local var_16_16 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_16_16) then
					local var_16_17 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_13_1.stage_.transform)

					var_16_17.name = var_16_15
					var_16_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_15] = var_16_17

					local var_16_18 = var_16_17:GetComponentInChildren(typeof(CharacterEffect))

					var_16_18.enabled = true

					local var_16_19 = GameObjectTools.GetOrAddComponent(var_16_17, typeof(DynamicBoneHelper))

					if var_16_19 then
						var_16_19:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_18.transform, false)

					arg_13_1.var_[var_16_15 .. "Animator"] = var_16_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_15 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_15 .. "LipSync"] = var_16_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_20 = arg_13_1.actors_["1027ui_story"].transform
			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.var_.moveOldPos1027ui_story = var_16_20.localPosition
			end

			local var_16_22 = 0.001

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_22 then
				local var_16_23 = (arg_13_1.time_ - var_16_21) / var_16_22
				local var_16_24 = Vector3.New(0.7, -0.81, -5.8)

				var_16_20.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1027ui_story, var_16_24, var_16_23)

				local var_16_25 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_25.x, var_16_25.y, var_16_25.z)

				local var_16_26 = var_16_20.localEulerAngles

				var_16_26.z = 0
				var_16_26.x = 0
				var_16_20.localEulerAngles = var_16_26
			end

			if arg_13_1.time_ >= var_16_21 + var_16_22 and arg_13_1.time_ < var_16_21 + var_16_22 + arg_16_0 then
				var_16_20.localPosition = Vector3.New(0.7, -0.81, -5.8)

				local var_16_27 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_27.x, var_16_27.y, var_16_27.z)

				local var_16_28 = var_16_20.localEulerAngles

				var_16_28.z = 0
				var_16_28.x = 0
				var_16_20.localEulerAngles = var_16_28
			end

			local var_16_29 = arg_13_1.actors_["1027ui_story"]
			local var_16_30 = 0

			if var_16_30 < arg_13_1.time_ and arg_13_1.time_ <= var_16_30 + arg_16_0 and not isNil(var_16_29) and arg_13_1.var_.characterEffect1027ui_story == nil then
				arg_13_1.var_.characterEffect1027ui_story = var_16_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_31 = 0.200000002980232

			if var_16_30 <= arg_13_1.time_ and arg_13_1.time_ < var_16_30 + var_16_31 and not isNil(var_16_29) then
				local var_16_32 = (arg_13_1.time_ - var_16_30) / var_16_31

				if arg_13_1.var_.characterEffect1027ui_story and not isNil(var_16_29) then
					arg_13_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_30 + var_16_31 and arg_13_1.time_ < var_16_30 + var_16_31 + arg_16_0 and not isNil(var_16_29) and arg_13_1.var_.characterEffect1027ui_story then
				arg_13_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_16_33 = 0

			if var_16_33 < arg_13_1.time_ and arg_13_1.time_ <= var_16_33 + arg_16_0 then
				arg_13_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_16_34 = 0

			if var_16_34 < arg_13_1.time_ and arg_13_1.time_ <= var_16_34 + arg_16_0 then
				arg_13_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_35 = 0
			local var_16_36 = 0.575

			if var_16_35 < arg_13_1.time_ and arg_13_1.time_ <= var_16_35 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_37 = arg_13_1:FormatText(StoryNameCfg[56].name)

				arg_13_1.leftNameTxt_.text = var_16_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_38 = arg_13_1:GetWordFromCfg(1109704003)
				local var_16_39 = arg_13_1:FormatText(var_16_38.content)

				arg_13_1.text_.text = var_16_39

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_40 = 23
				local var_16_41 = utf8.len(var_16_39)
				local var_16_42 = var_16_40 <= 0 and var_16_36 or var_16_36 * (var_16_41 / var_16_40)

				if var_16_42 > 0 and var_16_36 < var_16_42 then
					arg_13_1.talkMaxDuration = var_16_42

					if var_16_42 + var_16_35 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_42 + var_16_35
					end
				end

				arg_13_1.text_.text = var_16_39
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704003", "story_v_side_new_1109704.awb") ~= 0 then
					local var_16_43 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704003", "story_v_side_new_1109704.awb") / 1000

					if var_16_43 + var_16_35 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_43 + var_16_35
					end

					if var_16_38.prefab_name ~= "" and arg_13_1.actors_[var_16_38.prefab_name] ~= nil then
						local var_16_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_38.prefab_name].transform, "story_v_side_new_1109704", "1109704003", "story_v_side_new_1109704.awb")

						arg_13_1:RecordAudio("1109704003", var_16_44)
						arg_13_1:RecordAudio("1109704003", var_16_44)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704003", "story_v_side_new_1109704.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704003", "story_v_side_new_1109704.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_45 = math.max(var_16_36, arg_13_1.talkMaxDuration)

			if var_16_35 <= arg_13_1.time_ and arg_13_1.time_ < var_16_35 + var_16_45 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_35) / var_16_45

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_35 + var_16_45 and arg_13_1.time_ < var_16_35 + var_16_45 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
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
	Play1109704004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1109704004
		arg_17_1.duration_ = 2

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1109704005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1097ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1097ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1097ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1097ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1097ui_story == nil then
				arg_17_1.var_.characterEffect1097ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect1097ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1097ui_story then
				arg_17_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_1")
			end

			local var_20_14 = 0

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_20_15 = arg_17_1.actors_["1027ui_story"]
			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 and not isNil(var_20_15) and arg_17_1.var_.characterEffect1027ui_story == nil then
				arg_17_1.var_.characterEffect1027ui_story = var_20_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_17 = 0.200000002980232

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_17 and not isNil(var_20_15) then
				local var_20_18 = (arg_17_1.time_ - var_20_16) / var_20_17

				if arg_17_1.var_.characterEffect1027ui_story and not isNil(var_20_15) then
					local var_20_19 = Mathf.Lerp(0, 0.5, var_20_18)

					arg_17_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1027ui_story.fillRatio = var_20_19
				end
			end

			if arg_17_1.time_ >= var_20_16 + var_20_17 and arg_17_1.time_ < var_20_16 + var_20_17 + arg_20_0 and not isNil(var_20_15) and arg_17_1.var_.characterEffect1027ui_story then
				local var_20_20 = 0.5

				arg_17_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1027ui_story.fillRatio = var_20_20
			end

			local var_20_21 = 0
			local var_20_22 = 0.125

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_23 = arg_17_1:FormatText(StoryNameCfg[216].name)

				arg_17_1.leftNameTxt_.text = var_20_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_24 = arg_17_1:GetWordFromCfg(1109704004)
				local var_20_25 = arg_17_1:FormatText(var_20_24.content)

				arg_17_1.text_.text = var_20_25

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_26 = 5
				local var_20_27 = utf8.len(var_20_25)
				local var_20_28 = var_20_26 <= 0 and var_20_22 or var_20_22 * (var_20_27 / var_20_26)

				if var_20_28 > 0 and var_20_22 < var_20_28 then
					arg_17_1.talkMaxDuration = var_20_28

					if var_20_28 + var_20_21 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_21
					end
				end

				arg_17_1.text_.text = var_20_25
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704004", "story_v_side_new_1109704.awb") ~= 0 then
					local var_20_29 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704004", "story_v_side_new_1109704.awb") / 1000

					if var_20_29 + var_20_21 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_29 + var_20_21
					end

					if var_20_24.prefab_name ~= "" and arg_17_1.actors_[var_20_24.prefab_name] ~= nil then
						local var_20_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_24.prefab_name].transform, "story_v_side_new_1109704", "1109704004", "story_v_side_new_1109704.awb")

						arg_17_1:RecordAudio("1109704004", var_20_30)
						arg_17_1:RecordAudio("1109704004", var_20_30)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704004", "story_v_side_new_1109704.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704004", "story_v_side_new_1109704.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_31 = math.max(var_20_22, arg_17_1.talkMaxDuration)

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_31 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_21) / var_20_31

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_21 + var_20_31 and arg_17_1.time_ < var_20_21 + var_20_31 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play1109704005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1109704005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1109704006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1097ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1097ui_story == nil then
				arg_21_1.var_.characterEffect1097ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1097ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1097ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1097ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1097ui_story.fillRatio = var_24_5
			end

			local var_24_6 = arg_21_1.actors_["1097ui_story"].transform
			local var_24_7 = 0

			if var_24_7 < arg_21_1.time_ and arg_21_1.time_ <= var_24_7 + arg_24_0 then
				arg_21_1.var_.moveOldPos1097ui_story = var_24_6.localPosition
			end

			local var_24_8 = 0.001

			if var_24_7 <= arg_21_1.time_ and arg_21_1.time_ < var_24_7 + var_24_8 then
				local var_24_9 = (arg_21_1.time_ - var_24_7) / var_24_8
				local var_24_10 = Vector3.New(0, 100, 0)

				var_24_6.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1097ui_story, var_24_10, var_24_9)

				local var_24_11 = manager.ui.mainCamera.transform.position - var_24_6.position

				var_24_6.forward = Vector3.New(var_24_11.x, var_24_11.y, var_24_11.z)

				local var_24_12 = var_24_6.localEulerAngles

				var_24_12.z = 0
				var_24_12.x = 0
				var_24_6.localEulerAngles = var_24_12
			end

			if arg_21_1.time_ >= var_24_7 + var_24_8 and arg_21_1.time_ < var_24_7 + var_24_8 + arg_24_0 then
				var_24_6.localPosition = Vector3.New(0, 100, 0)

				local var_24_13 = manager.ui.mainCamera.transform.position - var_24_6.position

				var_24_6.forward = Vector3.New(var_24_13.x, var_24_13.y, var_24_13.z)

				local var_24_14 = var_24_6.localEulerAngles

				var_24_14.z = 0
				var_24_14.x = 0
				var_24_6.localEulerAngles = var_24_14
			end

			local var_24_15 = arg_21_1.actors_["1027ui_story"].transform
			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.var_.moveOldPos1027ui_story = var_24_15.localPosition
			end

			local var_24_17 = 0.001

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_17 then
				local var_24_18 = (arg_21_1.time_ - var_24_16) / var_24_17
				local var_24_19 = Vector3.New(0, 100, 0)

				var_24_15.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1027ui_story, var_24_19, var_24_18)

				local var_24_20 = manager.ui.mainCamera.transform.position - var_24_15.position

				var_24_15.forward = Vector3.New(var_24_20.x, var_24_20.y, var_24_20.z)

				local var_24_21 = var_24_15.localEulerAngles

				var_24_21.z = 0
				var_24_21.x = 0
				var_24_15.localEulerAngles = var_24_21
			end

			if arg_21_1.time_ >= var_24_16 + var_24_17 and arg_21_1.time_ < var_24_16 + var_24_17 + arg_24_0 then
				var_24_15.localPosition = Vector3.New(0, 100, 0)

				local var_24_22 = manager.ui.mainCamera.transform.position - var_24_15.position

				var_24_15.forward = Vector3.New(var_24_22.x, var_24_22.y, var_24_22.z)

				local var_24_23 = var_24_15.localEulerAngles

				var_24_23.z = 0
				var_24_23.x = 0
				var_24_15.localEulerAngles = var_24_23
			end

			local var_24_24 = manager.ui.mainCamera.transform
			local var_24_25 = 0

			if var_24_25 < arg_21_1.time_ and arg_21_1.time_ <= var_24_25 + arg_24_0 then
				arg_21_1.var_.shakeOldPos = var_24_24.localPosition
			end

			local var_24_26 = 0.6

			if var_24_25 <= arg_21_1.time_ and arg_21_1.time_ < var_24_25 + var_24_26 then
				local var_24_27 = (arg_21_1.time_ - var_24_25) / 0.066
				local var_24_28, var_24_29 = math.modf(var_24_27)

				var_24_24.localPosition = Vector3.New(var_24_29 * 0.13, var_24_29 * 0.13, var_24_29 * 0.13) + arg_21_1.var_.shakeOldPos
			end

			if arg_21_1.time_ >= var_24_25 + var_24_26 and arg_21_1.time_ < var_24_25 + var_24_26 + arg_24_0 then
				var_24_24.localPosition = arg_21_1.var_.shakeOldPos
			end

			local var_24_30 = 0

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 then
				arg_21_1.allBtn_.enabled = false
			end

			local var_24_31 = 0.6

			if arg_21_1.time_ >= var_24_30 + var_24_31 and arg_21_1.time_ < var_24_30 + var_24_31 + arg_24_0 then
				arg_21_1.allBtn_.enabled = true
			end

			local var_24_32 = 0
			local var_24_33 = 1.125

			if var_24_32 < arg_21_1.time_ and arg_21_1.time_ <= var_24_32 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_34 = arg_21_1:GetWordFromCfg(1109704005)
				local var_24_35 = arg_21_1:FormatText(var_24_34.content)

				arg_21_1.text_.text = var_24_35

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_36 = 45
				local var_24_37 = utf8.len(var_24_35)
				local var_24_38 = var_24_36 <= 0 and var_24_33 or var_24_33 * (var_24_37 / var_24_36)

				if var_24_38 > 0 and var_24_33 < var_24_38 then
					arg_21_1.talkMaxDuration = var_24_38

					if var_24_38 + var_24_32 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_38 + var_24_32
					end
				end

				arg_21_1.text_.text = var_24_35
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_39 = math.max(var_24_33, arg_21_1.talkMaxDuration)

			if var_24_32 <= arg_21_1.time_ and arg_21_1.time_ < var_24_32 + var_24_39 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_32) / var_24_39

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_32 + var_24_39 and arg_21_1.time_ < var_24_32 + var_24_39 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play1109704006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1109704006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1109704007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.55

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

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

				local var_28_3 = arg_25_1:GetWordFromCfg(1109704006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 22
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1109704007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1109704007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1109704008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.125

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(1109704007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 45
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1109704008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109704008
		arg_33_1.duration_ = 2.93

		local var_33_0 = {
			zh = 2.933,
			ja = 2.333
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
				arg_33_0:Play1109704009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1027ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1027ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0.7, -0.81, -5.8)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1027ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0.7, -0.81, -5.8)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1027ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1027ui_story == nil then
				arg_33_1.var_.characterEffect1027ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect1027ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1027ui_story then
				arg_33_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_36_15 = 0
			local var_36_16 = 0.175

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[56].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(1109704008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 7
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704008", "story_v_side_new_1109704.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704008", "story_v_side_new_1109704.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_side_new_1109704", "1109704008", "story_v_side_new_1109704.awb")

						arg_33_1:RecordAudio("1109704008", var_36_24)
						arg_33_1:RecordAudio("1109704008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704008", "story_v_side_new_1109704.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704008", "story_v_side_new_1109704.awb")
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
				actorName = "1027ui_story",
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
	Play1109704009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1109704009
		arg_37_1.duration_ = 6.3

		local var_37_0 = {
			zh = 5.233,
			ja = 6.3
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
				arg_37_0:Play1109704010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1097ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1097ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1097ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["1097ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1097ui_story == nil then
				arg_37_1.var_.characterEffect1097ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect1097ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1097ui_story then
				arg_37_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_40_15 = arg_37_1.actors_["1027ui_story"]
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.characterEffect1027ui_story == nil then
				arg_37_1.var_.characterEffect1027ui_story = var_40_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_17 = 0.200000002980232

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 and not isNil(var_40_15) then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17

				if arg_37_1.var_.characterEffect1027ui_story and not isNil(var_40_15) then
					local var_40_19 = Mathf.Lerp(0, 0.5, var_40_18)

					arg_37_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1027ui_story.fillRatio = var_40_19
				end
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.characterEffect1027ui_story then
				local var_40_20 = 0.5

				arg_37_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1027ui_story.fillRatio = var_40_20
			end

			local var_40_21 = 0
			local var_40_22 = 0.725

			if var_40_21 < arg_37_1.time_ and arg_37_1.time_ <= var_40_21 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_23 = arg_37_1:FormatText(StoryNameCfg[216].name)

				arg_37_1.leftNameTxt_.text = var_40_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_24 = arg_37_1:GetWordFromCfg(1109704009)
				local var_40_25 = arg_37_1:FormatText(var_40_24.content)

				arg_37_1.text_.text = var_40_25

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_26 = 29
				local var_40_27 = utf8.len(var_40_25)
				local var_40_28 = var_40_26 <= 0 and var_40_22 or var_40_22 * (var_40_27 / var_40_26)

				if var_40_28 > 0 and var_40_22 < var_40_28 then
					arg_37_1.talkMaxDuration = var_40_28

					if var_40_28 + var_40_21 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_28 + var_40_21
					end
				end

				arg_37_1.text_.text = var_40_25
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704009", "story_v_side_new_1109704.awb") ~= 0 then
					local var_40_29 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704009", "story_v_side_new_1109704.awb") / 1000

					if var_40_29 + var_40_21 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_29 + var_40_21
					end

					if var_40_24.prefab_name ~= "" and arg_37_1.actors_[var_40_24.prefab_name] ~= nil then
						local var_40_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_24.prefab_name].transform, "story_v_side_new_1109704", "1109704009", "story_v_side_new_1109704.awb")

						arg_37_1:RecordAudio("1109704009", var_40_30)
						arg_37_1:RecordAudio("1109704009", var_40_30)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704009", "story_v_side_new_1109704.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704009", "story_v_side_new_1109704.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_31 = math.max(var_40_22, arg_37_1.talkMaxDuration)

			if var_40_21 <= arg_37_1.time_ and arg_37_1.time_ < var_40_21 + var_40_31 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_21) / var_40_31

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_21 + var_40_31 and arg_37_1.time_ < var_40_21 + var_40_31 + arg_40_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play1109704010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1109704010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1109704011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1097ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1097ui_story == nil then
				arg_41_1.var_.characterEffect1097ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1097ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1097ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1097ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1097ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 1.075

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

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(1109704010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 43
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
	Play1109704011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1109704011
		arg_45_1.duration_ = 2

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1109704012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1097ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1097ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1097ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["1097ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1097ui_story == nil then
				arg_45_1.var_.characterEffect1097ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect1097ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1097ui_story then
				arg_45_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_48_13 = arg_45_1.actors_["1027ui_story"].transform
			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1.var_.moveOldPos1027ui_story = var_48_13.localPosition
			end

			local var_48_15 = 0.001

			if var_48_14 <= arg_45_1.time_ and arg_45_1.time_ < var_48_14 + var_48_15 then
				local var_48_16 = (arg_45_1.time_ - var_48_14) / var_48_15
				local var_48_17 = Vector3.New(0.7, -0.81, -5.8)

				var_48_13.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1027ui_story, var_48_17, var_48_16)

				local var_48_18 = manager.ui.mainCamera.transform.position - var_48_13.position

				var_48_13.forward = Vector3.New(var_48_18.x, var_48_18.y, var_48_18.z)

				local var_48_19 = var_48_13.localEulerAngles

				var_48_19.z = 0
				var_48_19.x = 0
				var_48_13.localEulerAngles = var_48_19
			end

			if arg_45_1.time_ >= var_48_14 + var_48_15 and arg_45_1.time_ < var_48_14 + var_48_15 + arg_48_0 then
				var_48_13.localPosition = Vector3.New(0.7, -0.81, -5.8)

				local var_48_20 = manager.ui.mainCamera.transform.position - var_48_13.position

				var_48_13.forward = Vector3.New(var_48_20.x, var_48_20.y, var_48_20.z)

				local var_48_21 = var_48_13.localEulerAngles

				var_48_21.z = 0
				var_48_21.x = 0
				var_48_13.localEulerAngles = var_48_21
			end

			local var_48_22 = arg_45_1.actors_["1027ui_story"]
			local var_48_23 = 0

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 and not isNil(var_48_22) and arg_45_1.var_.characterEffect1027ui_story == nil then
				arg_45_1.var_.characterEffect1027ui_story = var_48_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_24 = 0.200000002980232

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_24 and not isNil(var_48_22) then
				local var_48_25 = (arg_45_1.time_ - var_48_23) / var_48_24

				if arg_45_1.var_.characterEffect1027ui_story and not isNil(var_48_22) then
					arg_45_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_23 + var_48_24 and arg_45_1.time_ < var_48_23 + var_48_24 + arg_48_0 and not isNil(var_48_22) and arg_45_1.var_.characterEffect1027ui_story then
				arg_45_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_48_26 = 0

			if var_48_26 < arg_45_1.time_ and arg_45_1.time_ <= var_48_26 + arg_48_0 then
				arg_45_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_2")
			end

			local var_48_27 = 0

			if var_48_27 < arg_45_1.time_ and arg_45_1.time_ <= var_48_27 + arg_48_0 then
				arg_45_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_48_28 = 0
			local var_48_29 = 0.05

			if var_48_28 < arg_45_1.time_ and arg_45_1.time_ <= var_48_28 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_30 = arg_45_1:FormatText(StoryNameCfg[951].name)

				arg_45_1.leftNameTxt_.text = var_48_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_31 = arg_45_1:GetWordFromCfg(1109704011)
				local var_48_32 = arg_45_1:FormatText(var_48_31.content)

				arg_45_1.text_.text = var_48_32

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_33 = 2
				local var_48_34 = utf8.len(var_48_32)
				local var_48_35 = var_48_33 <= 0 and var_48_29 or var_48_29 * (var_48_34 / var_48_33)

				if var_48_35 > 0 and var_48_29 < var_48_35 then
					arg_45_1.talkMaxDuration = var_48_35

					if var_48_35 + var_48_28 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_35 + var_48_28
					end
				end

				arg_45_1.text_.text = var_48_32
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704011", "story_v_side_new_1109704.awb") ~= 0 then
					local var_48_36 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704011", "story_v_side_new_1109704.awb") / 1000

					if var_48_36 + var_48_28 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_36 + var_48_28
					end

					if var_48_31.prefab_name ~= "" and arg_45_1.actors_[var_48_31.prefab_name] ~= nil then
						local var_48_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_31.prefab_name].transform, "story_v_side_new_1109704", "1109704011", "story_v_side_new_1109704.awb")

						arg_45_1:RecordAudio("1109704011", var_48_37)
						arg_45_1:RecordAudio("1109704011", var_48_37)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704011", "story_v_side_new_1109704.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704011", "story_v_side_new_1109704.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_38 = math.max(var_48_29, arg_45_1.talkMaxDuration)

			if var_48_28 <= arg_45_1.time_ and arg_45_1.time_ < var_48_28 + var_48_38 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_28) / var_48_38

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_28 + var_48_38 and arg_45_1.time_ < var_48_28 + var_48_38 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
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
	Play1109704012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1109704012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1109704013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1027ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1027ui_story == nil then
				arg_49_1.var_.characterEffect1027ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1027ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1027ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1027ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1027ui_story.fillRatio = var_52_5
			end

			local var_52_6 = arg_49_1.actors_["1097ui_story"]
			local var_52_7 = 0

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1097ui_story == nil then
				arg_49_1.var_.characterEffect1097ui_story = var_52_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_8 = 0.200000002980232

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_8 and not isNil(var_52_6) then
				local var_52_9 = (arg_49_1.time_ - var_52_7) / var_52_8

				if arg_49_1.var_.characterEffect1097ui_story and not isNil(var_52_6) then
					local var_52_10 = Mathf.Lerp(0, 0.5, var_52_9)

					arg_49_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1097ui_story.fillRatio = var_52_10
				end
			end

			if arg_49_1.time_ >= var_52_7 + var_52_8 and arg_49_1.time_ < var_52_7 + var_52_8 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1097ui_story then
				local var_52_11 = 0.5

				arg_49_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1097ui_story.fillRatio = var_52_11
			end

			local var_52_12 = 0
			local var_52_13 = 1.225

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_14 = arg_49_1:GetWordFromCfg(1109704012)
				local var_52_15 = arg_49_1:FormatText(var_52_14.content)

				arg_49_1.text_.text = var_52_15

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_16 = 49
				local var_52_17 = utf8.len(var_52_15)
				local var_52_18 = var_52_16 <= 0 and var_52_13 or var_52_13 * (var_52_17 / var_52_16)

				if var_52_18 > 0 and var_52_13 < var_52_18 then
					arg_49_1.talkMaxDuration = var_52_18

					if var_52_18 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_15
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_19 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_19 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_12) / var_52_19

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_12 + var_52_19 and arg_49_1.time_ < var_52_12 + var_52_19 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1109704013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1109704013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1109704014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.425

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(1109704013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 17
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_8 and arg_53_1.time_ < var_56_0 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1109704014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1109704014
		arg_57_1.duration_ = 8.9

		local var_57_0 = {
			zh = 6.366,
			ja = 8.9
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
				arg_57_0:Play1109704015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1097ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1097ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1097ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["1097ui_story"]
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1097ui_story == nil then
				arg_57_1.var_.characterEffect1097ui_story = var_60_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.200000002980232

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 and not isNil(var_60_9) then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.characterEffect1097ui_story and not isNil(var_60_9) then
					arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1097ui_story then
				arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_60_15 = 0
			local var_60_16 = 0.625

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_17 = arg_57_1:FormatText(StoryNameCfg[216].name)

				arg_57_1.leftNameTxt_.text = var_60_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:GetWordFromCfg(1109704014)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 25
				local var_60_21 = utf8.len(var_60_19)
				local var_60_22 = var_60_20 <= 0 and var_60_16 or var_60_16 * (var_60_21 / var_60_20)

				if var_60_22 > 0 and var_60_16 < var_60_22 then
					arg_57_1.talkMaxDuration = var_60_22

					if var_60_22 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_22 + var_60_15
					end
				end

				arg_57_1.text_.text = var_60_19
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704014", "story_v_side_new_1109704.awb") ~= 0 then
					local var_60_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704014", "story_v_side_new_1109704.awb") / 1000

					if var_60_23 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_15
					end

					if var_60_18.prefab_name ~= "" and arg_57_1.actors_[var_60_18.prefab_name] ~= nil then
						local var_60_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_18.prefab_name].transform, "story_v_side_new_1109704", "1109704014", "story_v_side_new_1109704.awb")

						arg_57_1:RecordAudio("1109704014", var_60_24)
						arg_57_1:RecordAudio("1109704014", var_60_24)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704014", "story_v_side_new_1109704.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704014", "story_v_side_new_1109704.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_25 = math.max(var_60_16, arg_57_1.talkMaxDuration)

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_25 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_15) / var_60_25

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_15 + var_60_25 and arg_57_1.time_ < var_60_15 + var_60_25 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play1109704015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1109704015
		arg_61_1.duration_ = 3.4

		local var_61_0 = {
			zh = 3.033,
			ja = 3.4
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
				arg_61_0:Play1109704016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1027ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1027ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0.7, -0.81, -5.8)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1027ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0.7, -0.81, -5.8)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["1027ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1027ui_story == nil then
				arg_61_1.var_.characterEffect1027ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect1027ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1027ui_story then
				arg_61_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_64_13 = 0

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_15 = arg_61_1.actors_["1097ui_story"]
			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 and not isNil(var_64_15) and arg_61_1.var_.characterEffect1097ui_story == nil then
				arg_61_1.var_.characterEffect1097ui_story = var_64_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_17 = 0.200000002980232

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_17 and not isNil(var_64_15) then
				local var_64_18 = (arg_61_1.time_ - var_64_16) / var_64_17

				if arg_61_1.var_.characterEffect1097ui_story and not isNil(var_64_15) then
					local var_64_19 = Mathf.Lerp(0, 0.5, var_64_18)

					arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1097ui_story.fillRatio = var_64_19
				end
			end

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 and not isNil(var_64_15) and arg_61_1.var_.characterEffect1097ui_story then
				local var_64_20 = 0.5

				arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1097ui_story.fillRatio = var_64_20
			end

			local var_64_21 = 0
			local var_64_22 = 0.3

			if var_64_21 < arg_61_1.time_ and arg_61_1.time_ <= var_64_21 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_23 = arg_61_1:FormatText(StoryNameCfg[56].name)

				arg_61_1.leftNameTxt_.text = var_64_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_24 = arg_61_1:GetWordFromCfg(1109704015)
				local var_64_25 = arg_61_1:FormatText(var_64_24.content)

				arg_61_1.text_.text = var_64_25

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_26 = 12
				local var_64_27 = utf8.len(var_64_25)
				local var_64_28 = var_64_26 <= 0 and var_64_22 or var_64_22 * (var_64_27 / var_64_26)

				if var_64_28 > 0 and var_64_22 < var_64_28 then
					arg_61_1.talkMaxDuration = var_64_28

					if var_64_28 + var_64_21 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_28 + var_64_21
					end
				end

				arg_61_1.text_.text = var_64_25
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704015", "story_v_side_new_1109704.awb") ~= 0 then
					local var_64_29 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704015", "story_v_side_new_1109704.awb") / 1000

					if var_64_29 + var_64_21 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_29 + var_64_21
					end

					if var_64_24.prefab_name ~= "" and arg_61_1.actors_[var_64_24.prefab_name] ~= nil then
						local var_64_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_24.prefab_name].transform, "story_v_side_new_1109704", "1109704015", "story_v_side_new_1109704.awb")

						arg_61_1:RecordAudio("1109704015", var_64_30)
						arg_61_1:RecordAudio("1109704015", var_64_30)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704015", "story_v_side_new_1109704.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704015", "story_v_side_new_1109704.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_31 = math.max(var_64_22, arg_61_1.talkMaxDuration)

			if var_64_21 <= arg_61_1.time_ and arg_61_1.time_ < var_64_21 + var_64_31 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_21) / var_64_31

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_21 + var_64_31 and arg_61_1.time_ < var_64_21 + var_64_31 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play1109704016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1109704016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1109704017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1027ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1027ui_story == nil then
				arg_65_1.var_.characterEffect1027ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1027ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1027ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1027ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1027ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 1.275

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

				local var_68_9 = arg_65_1:GetWordFromCfg(1109704016)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 51
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
	Play1109704017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1109704017
		arg_69_1.duration_ = 9.4

		local var_69_0 = {
			zh = 2.733,
			ja = 9.4
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
				arg_69_0:Play1109704018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1027ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1027ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0.7, -0.81, -5.8)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1027ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0.7, -0.81, -5.8)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["1027ui_story"]
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1027ui_story == nil then
				arg_69_1.var_.characterEffect1027ui_story = var_72_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 and not isNil(var_72_9) then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11

				if arg_69_1.var_.characterEffect1027ui_story and not isNil(var_72_9) then
					arg_69_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1027ui_story then
				arg_69_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_72_13 = 0

			if var_72_13 < arg_69_1.time_ and arg_69_1.time_ <= var_72_13 + arg_72_0 then
				arg_69_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_72_14 = 0

			if var_72_14 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 then
				arg_69_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_15 = 0
			local var_72_16 = 0.275

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_17 = arg_69_1:FormatText(StoryNameCfg[56].name)

				arg_69_1.leftNameTxt_.text = var_72_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_18 = arg_69_1:GetWordFromCfg(1109704017)
				local var_72_19 = arg_69_1:FormatText(var_72_18.content)

				arg_69_1.text_.text = var_72_19

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_20 = 11
				local var_72_21 = utf8.len(var_72_19)
				local var_72_22 = var_72_20 <= 0 and var_72_16 or var_72_16 * (var_72_21 / var_72_20)

				if var_72_22 > 0 and var_72_16 < var_72_22 then
					arg_69_1.talkMaxDuration = var_72_22

					if var_72_22 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_22 + var_72_15
					end
				end

				arg_69_1.text_.text = var_72_19
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704017", "story_v_side_new_1109704.awb") ~= 0 then
					local var_72_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704017", "story_v_side_new_1109704.awb") / 1000

					if var_72_23 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_15
					end

					if var_72_18.prefab_name ~= "" and arg_69_1.actors_[var_72_18.prefab_name] ~= nil then
						local var_72_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_18.prefab_name].transform, "story_v_side_new_1109704", "1109704017", "story_v_side_new_1109704.awb")

						arg_69_1:RecordAudio("1109704017", var_72_24)
						arg_69_1:RecordAudio("1109704017", var_72_24)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704017", "story_v_side_new_1109704.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704017", "story_v_side_new_1109704.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_25 = math.max(var_72_16, arg_69_1.talkMaxDuration)

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_25 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_15) / var_72_25

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_15 + var_72_25 and arg_69_1.time_ < var_72_15 + var_72_25 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play1109704018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1109704018
		arg_73_1.duration_ = 5.2

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1109704019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1097ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1097ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1097ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["1097ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1097ui_story == nil then
				arg_73_1.var_.characterEffect1097ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect1097ui_story and not isNil(var_76_9) then
					arg_73_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1097ui_story then
				arg_73_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_76_13 = 0

			if var_76_13 < arg_73_1.time_ and arg_73_1.time_ <= var_76_13 + arg_76_0 then
				arg_73_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_76_14 = 0

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_76_15 = arg_73_1.actors_["1027ui_story"]
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.characterEffect1027ui_story == nil then
				arg_73_1.var_.characterEffect1027ui_story = var_76_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_17 = 0.200000002980232

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 and not isNil(var_76_15) then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17

				if arg_73_1.var_.characterEffect1027ui_story and not isNil(var_76_15) then
					local var_76_19 = Mathf.Lerp(0, 0.5, var_76_18)

					arg_73_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1027ui_story.fillRatio = var_76_19
				end
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.characterEffect1027ui_story then
				local var_76_20 = 0.5

				arg_73_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1027ui_story.fillRatio = var_76_20
			end

			local var_76_21 = 0
			local var_76_22 = 0.45

			if var_76_21 < arg_73_1.time_ and arg_73_1.time_ <= var_76_21 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_23 = arg_73_1:FormatText(StoryNameCfg[216].name)

				arg_73_1.leftNameTxt_.text = var_76_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_24 = arg_73_1:GetWordFromCfg(1109704018)
				local var_76_25 = arg_73_1:FormatText(var_76_24.content)

				arg_73_1.text_.text = var_76_25

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_26 = 18
				local var_76_27 = utf8.len(var_76_25)
				local var_76_28 = var_76_26 <= 0 and var_76_22 or var_76_22 * (var_76_27 / var_76_26)

				if var_76_28 > 0 and var_76_22 < var_76_28 then
					arg_73_1.talkMaxDuration = var_76_28

					if var_76_28 + var_76_21 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_28 + var_76_21
					end
				end

				arg_73_1.text_.text = var_76_25
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704018", "story_v_side_new_1109704.awb") ~= 0 then
					local var_76_29 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704018", "story_v_side_new_1109704.awb") / 1000

					if var_76_29 + var_76_21 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_29 + var_76_21
					end

					if var_76_24.prefab_name ~= "" and arg_73_1.actors_[var_76_24.prefab_name] ~= nil then
						local var_76_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_24.prefab_name].transform, "story_v_side_new_1109704", "1109704018", "story_v_side_new_1109704.awb")

						arg_73_1:RecordAudio("1109704018", var_76_30)
						arg_73_1:RecordAudio("1109704018", var_76_30)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704018", "story_v_side_new_1109704.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704018", "story_v_side_new_1109704.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_31 = math.max(var_76_22, arg_73_1.talkMaxDuration)

			if var_76_21 <= arg_73_1.time_ and arg_73_1.time_ < var_76_21 + var_76_31 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_21) / var_76_31

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_21 + var_76_31 and arg_73_1.time_ < var_76_21 + var_76_31 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play1109704019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1109704019
		arg_77_1.duration_ = 6.47

		local var_77_0 = {
			zh = 5.133,
			ja = 6.466
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1109704020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = "1080ui_story"

			if arg_77_1.actors_[var_80_0] == nil then
				local var_80_1 = Asset.Load("Char/" .. "1080ui_story")

				if not isNil(var_80_1) then
					local var_80_2 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_77_1.stage_.transform)

					var_80_2.name = var_80_0
					var_80_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_77_1.actors_[var_80_0] = var_80_2

					local var_80_3 = var_80_2:GetComponentInChildren(typeof(CharacterEffect))

					var_80_3.enabled = true

					local var_80_4 = GameObjectTools.GetOrAddComponent(var_80_2, typeof(DynamicBoneHelper))

					if var_80_4 then
						var_80_4:EnableDynamicBone(false)
					end

					arg_77_1:ShowWeapon(var_80_3.transform, false)

					arg_77_1.var_[var_80_0 .. "Animator"] = var_80_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_77_1.var_[var_80_0 .. "Animator"].applyRootMotion = true
					arg_77_1.var_[var_80_0 .. "LipSync"] = var_80_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_80_5 = arg_77_1.actors_["1080ui_story"].transform
			local var_80_6 = 0

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.var_.moveOldPos1080ui_story = var_80_5.localPosition
			end

			local var_80_7 = 0.001

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_7 then
				local var_80_8 = (arg_77_1.time_ - var_80_6) / var_80_7
				local var_80_9 = Vector3.New(0.7, -1.01, -6.05)

				var_80_5.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1080ui_story, var_80_9, var_80_8)

				local var_80_10 = manager.ui.mainCamera.transform.position - var_80_5.position

				var_80_5.forward = Vector3.New(var_80_10.x, var_80_10.y, var_80_10.z)

				local var_80_11 = var_80_5.localEulerAngles

				var_80_11.z = 0
				var_80_11.x = 0
				var_80_5.localEulerAngles = var_80_11
			end

			if arg_77_1.time_ >= var_80_6 + var_80_7 and arg_77_1.time_ < var_80_6 + var_80_7 + arg_80_0 then
				var_80_5.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_80_12 = manager.ui.mainCamera.transform.position - var_80_5.position

				var_80_5.forward = Vector3.New(var_80_12.x, var_80_12.y, var_80_12.z)

				local var_80_13 = var_80_5.localEulerAngles

				var_80_13.z = 0
				var_80_13.x = 0
				var_80_5.localEulerAngles = var_80_13
			end

			local var_80_14 = arg_77_1.actors_["1080ui_story"]
			local var_80_15 = 0

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 and not isNil(var_80_14) and arg_77_1.var_.characterEffect1080ui_story == nil then
				arg_77_1.var_.characterEffect1080ui_story = var_80_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_16 = 0.200000002980232

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_16 and not isNil(var_80_14) then
				local var_80_17 = (arg_77_1.time_ - var_80_15) / var_80_16

				if arg_77_1.var_.characterEffect1080ui_story and not isNil(var_80_14) then
					arg_77_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_15 + var_80_16 and arg_77_1.time_ < var_80_15 + var_80_16 + arg_80_0 and not isNil(var_80_14) and arg_77_1.var_.characterEffect1080ui_story then
				arg_77_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_80_18 = 0

			if var_80_18 < arg_77_1.time_ and arg_77_1.time_ <= var_80_18 + arg_80_0 then
				arg_77_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			local var_80_19 = 0

			if var_80_19 < arg_77_1.time_ and arg_77_1.time_ <= var_80_19 + arg_80_0 then
				arg_77_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_20 = arg_77_1.actors_["1027ui_story"].transform
			local var_80_21 = 0

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1.var_.moveOldPos1027ui_story = var_80_20.localPosition
			end

			local var_80_22 = 0.001

			if var_80_21 <= arg_77_1.time_ and arg_77_1.time_ < var_80_21 + var_80_22 then
				local var_80_23 = (arg_77_1.time_ - var_80_21) / var_80_22
				local var_80_24 = Vector3.New(0, 100, 0)

				var_80_20.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1027ui_story, var_80_24, var_80_23)

				local var_80_25 = manager.ui.mainCamera.transform.position - var_80_20.position

				var_80_20.forward = Vector3.New(var_80_25.x, var_80_25.y, var_80_25.z)

				local var_80_26 = var_80_20.localEulerAngles

				var_80_26.z = 0
				var_80_26.x = 0
				var_80_20.localEulerAngles = var_80_26
			end

			if arg_77_1.time_ >= var_80_21 + var_80_22 and arg_77_1.time_ < var_80_21 + var_80_22 + arg_80_0 then
				var_80_20.localPosition = Vector3.New(0, 100, 0)

				local var_80_27 = manager.ui.mainCamera.transform.position - var_80_20.position

				var_80_20.forward = Vector3.New(var_80_27.x, var_80_27.y, var_80_27.z)

				local var_80_28 = var_80_20.localEulerAngles

				var_80_28.z = 0
				var_80_28.x = 0
				var_80_20.localEulerAngles = var_80_28
			end

			local var_80_29 = arg_77_1.actors_["1027ui_story"]
			local var_80_30 = 0

			if var_80_30 < arg_77_1.time_ and arg_77_1.time_ <= var_80_30 + arg_80_0 and not isNil(var_80_29) and arg_77_1.var_.characterEffect1027ui_story == nil then
				arg_77_1.var_.characterEffect1027ui_story = var_80_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_31 = 0.200000002980232

			if var_80_30 <= arg_77_1.time_ and arg_77_1.time_ < var_80_30 + var_80_31 and not isNil(var_80_29) then
				local var_80_32 = (arg_77_1.time_ - var_80_30) / var_80_31

				if arg_77_1.var_.characterEffect1027ui_story and not isNil(var_80_29) then
					local var_80_33 = Mathf.Lerp(0, 0.5, var_80_32)

					arg_77_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1027ui_story.fillRatio = var_80_33
				end
			end

			if arg_77_1.time_ >= var_80_30 + var_80_31 and arg_77_1.time_ < var_80_30 + var_80_31 + arg_80_0 and not isNil(var_80_29) and arg_77_1.var_.characterEffect1027ui_story then
				local var_80_34 = 0.5

				arg_77_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1027ui_story.fillRatio = var_80_34
			end

			local var_80_35 = arg_77_1.actors_["1097ui_story"]
			local var_80_36 = 0

			if var_80_36 < arg_77_1.time_ and arg_77_1.time_ <= var_80_36 + arg_80_0 and not isNil(var_80_35) and arg_77_1.var_.characterEffect1097ui_story == nil then
				arg_77_1.var_.characterEffect1097ui_story = var_80_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_37 = 0.200000002980232

			if var_80_36 <= arg_77_1.time_ and arg_77_1.time_ < var_80_36 + var_80_37 and not isNil(var_80_35) then
				local var_80_38 = (arg_77_1.time_ - var_80_36) / var_80_37

				if arg_77_1.var_.characterEffect1097ui_story and not isNil(var_80_35) then
					local var_80_39 = Mathf.Lerp(0, 0.5, var_80_38)

					arg_77_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1097ui_story.fillRatio = var_80_39
				end
			end

			if arg_77_1.time_ >= var_80_36 + var_80_37 and arg_77_1.time_ < var_80_36 + var_80_37 + arg_80_0 and not isNil(var_80_35) and arg_77_1.var_.characterEffect1097ui_story then
				local var_80_40 = 0.5

				arg_77_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1097ui_story.fillRatio = var_80_40
			end

			local var_80_41 = 0
			local var_80_42 = 0.45

			if var_80_41 < arg_77_1.time_ and arg_77_1.time_ <= var_80_41 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_43 = arg_77_1:FormatText(StoryNameCfg[55].name)

				arg_77_1.leftNameTxt_.text = var_80_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_44 = arg_77_1:GetWordFromCfg(1109704019)
				local var_80_45 = arg_77_1:FormatText(var_80_44.content)

				arg_77_1.text_.text = var_80_45

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_46 = 18
				local var_80_47 = utf8.len(var_80_45)
				local var_80_48 = var_80_46 <= 0 and var_80_42 or var_80_42 * (var_80_47 / var_80_46)

				if var_80_48 > 0 and var_80_42 < var_80_48 then
					arg_77_1.talkMaxDuration = var_80_48

					if var_80_48 + var_80_41 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_48 + var_80_41
					end
				end

				arg_77_1.text_.text = var_80_45
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704019", "story_v_side_new_1109704.awb") ~= 0 then
					local var_80_49 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704019", "story_v_side_new_1109704.awb") / 1000

					if var_80_49 + var_80_41 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_49 + var_80_41
					end

					if var_80_44.prefab_name ~= "" and arg_77_1.actors_[var_80_44.prefab_name] ~= nil then
						local var_80_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_44.prefab_name].transform, "story_v_side_new_1109704", "1109704019", "story_v_side_new_1109704.awb")

						arg_77_1:RecordAudio("1109704019", var_80_50)
						arg_77_1:RecordAudio("1109704019", var_80_50)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704019", "story_v_side_new_1109704.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704019", "story_v_side_new_1109704.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_51 = math.max(var_80_42, arg_77_1.talkMaxDuration)

			if var_80_41 <= arg_77_1.time_ and arg_77_1.time_ < var_80_41 + var_80_51 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_41) / var_80_51

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_41 + var_80_51 and arg_77_1.time_ < var_80_41 + var_80_51 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play1109704020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1109704020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1109704021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1080ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1080ui_story == nil then
				arg_81_1.var_.characterEffect1080ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1080ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1080ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1080ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1080ui_story.fillRatio = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = 1.15

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:GetWordFromCfg(1109704020)
				local var_84_9 = arg_81_1:FormatText(var_84_8.content)

				arg_81_1.text_.text = var_84_9

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 46
				local var_84_11 = utf8.len(var_84_9)
				local var_84_12 = var_84_10 <= 0 and var_84_7 or var_84_7 * (var_84_11 / var_84_10)

				if var_84_12 > 0 and var_84_7 < var_84_12 then
					arg_81_1.talkMaxDuration = var_84_12

					if var_84_12 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_9
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_13 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_13 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_13

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_13 and arg_81_1.time_ < var_84_6 + var_84_13 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1109704021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1109704021
		arg_85_1.duration_ = 6.43

		local var_85_0 = {
			zh = 4.033,
			ja = 6.433
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
				arg_85_0:Play1109704022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1097ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1097ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1097ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["1097ui_story"]
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1097ui_story == nil then
				arg_85_1.var_.characterEffect1097ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.200000002980232

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 and not isNil(var_88_9) then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11

				if arg_85_1.var_.characterEffect1097ui_story and not isNil(var_88_9) then
					arg_85_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1097ui_story then
				arg_85_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_88_13 = 0

			if var_88_13 < arg_85_1.time_ and arg_85_1.time_ <= var_88_13 + arg_88_0 then
				arg_85_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			local var_88_14 = 0

			if var_88_14 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 then
				arg_85_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_15 = 0
			local var_88_16 = 0.35

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[216].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(1109704021)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704021", "story_v_side_new_1109704.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704021", "story_v_side_new_1109704.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_side_new_1109704", "1109704021", "story_v_side_new_1109704.awb")

						arg_85_1:RecordAudio("1109704021", var_88_24)
						arg_85_1:RecordAudio("1109704021", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704021", "story_v_side_new_1109704.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704021", "story_v_side_new_1109704.awb")
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
				actorName = "1097ui_story",
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
	Play1109704022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1109704022
		arg_89_1.duration_ = 2

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1109704023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1080ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1080ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0.7, -1.01, -6.05)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1080ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["1080ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1080ui_story == nil then
				arg_89_1.var_.characterEffect1080ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect1080ui_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1080ui_story then
				arg_89_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_92_13 = 0

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_92_15 = arg_89_1.actors_["1097ui_story"]
			local var_92_16 = 0

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.characterEffect1097ui_story == nil then
				arg_89_1.var_.characterEffect1097ui_story = var_92_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_17 = 0.200000002980232

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_17 and not isNil(var_92_15) then
				local var_92_18 = (arg_89_1.time_ - var_92_16) / var_92_17

				if arg_89_1.var_.characterEffect1097ui_story and not isNil(var_92_15) then
					local var_92_19 = Mathf.Lerp(0, 0.5, var_92_18)

					arg_89_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1097ui_story.fillRatio = var_92_19
				end
			end

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.characterEffect1097ui_story then
				local var_92_20 = 0.5

				arg_89_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1097ui_story.fillRatio = var_92_20
			end

			local var_92_21 = 0
			local var_92_22 = 0.075

			if var_92_21 < arg_89_1.time_ and arg_89_1.time_ <= var_92_21 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_23 = arg_89_1:FormatText(StoryNameCfg[55].name)

				arg_89_1.leftNameTxt_.text = var_92_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_24 = arg_89_1:GetWordFromCfg(1109704022)
				local var_92_25 = arg_89_1:FormatText(var_92_24.content)

				arg_89_1.text_.text = var_92_25

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_26 = 3
				local var_92_27 = utf8.len(var_92_25)
				local var_92_28 = var_92_26 <= 0 and var_92_22 or var_92_22 * (var_92_27 / var_92_26)

				if var_92_28 > 0 and var_92_22 < var_92_28 then
					arg_89_1.talkMaxDuration = var_92_28

					if var_92_28 + var_92_21 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_28 + var_92_21
					end
				end

				arg_89_1.text_.text = var_92_25
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704022", "story_v_side_new_1109704.awb") ~= 0 then
					local var_92_29 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704022", "story_v_side_new_1109704.awb") / 1000

					if var_92_29 + var_92_21 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_29 + var_92_21
					end

					if var_92_24.prefab_name ~= "" and arg_89_1.actors_[var_92_24.prefab_name] ~= nil then
						local var_92_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_24.prefab_name].transform, "story_v_side_new_1109704", "1109704022", "story_v_side_new_1109704.awb")

						arg_89_1:RecordAudio("1109704022", var_92_30)
						arg_89_1:RecordAudio("1109704022", var_92_30)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704022", "story_v_side_new_1109704.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704022", "story_v_side_new_1109704.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_31 = math.max(var_92_22, arg_89_1.talkMaxDuration)

			if var_92_21 <= arg_89_1.time_ and arg_89_1.time_ < var_92_21 + var_92_31 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_21) / var_92_31

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_21 + var_92_31 and arg_89_1.time_ < var_92_21 + var_92_31 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
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
	Play1109704023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1109704023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1109704024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1080ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1080ui_story == nil then
				arg_93_1.var_.characterEffect1080ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1080ui_story and not isNil(var_96_0) then
					local var_96_4 = Mathf.Lerp(0, 0.5, var_96_3)

					arg_93_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1080ui_story.fillRatio = var_96_4
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1080ui_story then
				local var_96_5 = 0.5

				arg_93_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1080ui_story.fillRatio = var_96_5
			end

			local var_96_6 = 0
			local var_96_7 = 0.65

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

				local var_96_8 = arg_93_1:GetWordFromCfg(1109704023)
				local var_96_9 = arg_93_1:FormatText(var_96_8.content)

				arg_93_1.text_.text = var_96_9

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 26
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
	Play1109704024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1109704024
		arg_97_1.duration_ = 9

		local var_97_0 = {
			zh = 6.6,
			ja = 9
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1109704025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1027ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1027ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0.7, -0.81, -5.8)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1027ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0.7, -0.81, -5.8)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["1027ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1027ui_story == nil then
				arg_97_1.var_.characterEffect1027ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect1027ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1027ui_story then
				arg_97_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_100_13 = 0

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			local var_100_14 = 0

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_15 = arg_97_1.actors_["1080ui_story"].transform
			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.var_.moveOldPos1080ui_story = var_100_15.localPosition
			end

			local var_100_17 = 0.001

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_17 then
				local var_100_18 = (arg_97_1.time_ - var_100_16) / var_100_17
				local var_100_19 = Vector3.New(0, 100, 0)

				var_100_15.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1080ui_story, var_100_19, var_100_18)

				local var_100_20 = manager.ui.mainCamera.transform.position - var_100_15.position

				var_100_15.forward = Vector3.New(var_100_20.x, var_100_20.y, var_100_20.z)

				local var_100_21 = var_100_15.localEulerAngles

				var_100_21.z = 0
				var_100_21.x = 0
				var_100_15.localEulerAngles = var_100_21
			end

			if arg_97_1.time_ >= var_100_16 + var_100_17 and arg_97_1.time_ < var_100_16 + var_100_17 + arg_100_0 then
				var_100_15.localPosition = Vector3.New(0, 100, 0)

				local var_100_22 = manager.ui.mainCamera.transform.position - var_100_15.position

				var_100_15.forward = Vector3.New(var_100_22.x, var_100_22.y, var_100_22.z)

				local var_100_23 = var_100_15.localEulerAngles

				var_100_23.z = 0
				var_100_23.x = 0
				var_100_15.localEulerAngles = var_100_23
			end

			local var_100_24 = arg_97_1.actors_["1080ui_story"]
			local var_100_25 = 0

			if var_100_25 < arg_97_1.time_ and arg_97_1.time_ <= var_100_25 + arg_100_0 and not isNil(var_100_24) and arg_97_1.var_.characterEffect1080ui_story == nil then
				arg_97_1.var_.characterEffect1080ui_story = var_100_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_26 = 0.200000002980232

			if var_100_25 <= arg_97_1.time_ and arg_97_1.time_ < var_100_25 + var_100_26 and not isNil(var_100_24) then
				local var_100_27 = (arg_97_1.time_ - var_100_25) / var_100_26

				if arg_97_1.var_.characterEffect1080ui_story and not isNil(var_100_24) then
					local var_100_28 = Mathf.Lerp(0, 0.5, var_100_27)

					arg_97_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1080ui_story.fillRatio = var_100_28
				end
			end

			if arg_97_1.time_ >= var_100_25 + var_100_26 and arg_97_1.time_ < var_100_25 + var_100_26 + arg_100_0 and not isNil(var_100_24) and arg_97_1.var_.characterEffect1080ui_story then
				local var_100_29 = 0.5

				arg_97_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1080ui_story.fillRatio = var_100_29
			end

			local var_100_30 = 0
			local var_100_31 = 0.85

			if var_100_30 < arg_97_1.time_ and arg_97_1.time_ <= var_100_30 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_32 = arg_97_1:FormatText(StoryNameCfg[56].name)

				arg_97_1.leftNameTxt_.text = var_100_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_33 = arg_97_1:GetWordFromCfg(1109704024)
				local var_100_34 = arg_97_1:FormatText(var_100_33.content)

				arg_97_1.text_.text = var_100_34

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_35 = 34
				local var_100_36 = utf8.len(var_100_34)
				local var_100_37 = var_100_35 <= 0 and var_100_31 or var_100_31 * (var_100_36 / var_100_35)

				if var_100_37 > 0 and var_100_31 < var_100_37 then
					arg_97_1.talkMaxDuration = var_100_37

					if var_100_37 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_37 + var_100_30
					end
				end

				arg_97_1.text_.text = var_100_34
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704024", "story_v_side_new_1109704.awb") ~= 0 then
					local var_100_38 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704024", "story_v_side_new_1109704.awb") / 1000

					if var_100_38 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_38 + var_100_30
					end

					if var_100_33.prefab_name ~= "" and arg_97_1.actors_[var_100_33.prefab_name] ~= nil then
						local var_100_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_33.prefab_name].transform, "story_v_side_new_1109704", "1109704024", "story_v_side_new_1109704.awb")

						arg_97_1:RecordAudio("1109704024", var_100_39)
						arg_97_1:RecordAudio("1109704024", var_100_39)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704024", "story_v_side_new_1109704.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704024", "story_v_side_new_1109704.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_40 = math.max(var_100_31, arg_97_1.talkMaxDuration)

			if var_100_30 <= arg_97_1.time_ and arg_97_1.time_ < var_100_30 + var_100_40 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_30) / var_100_40

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_30 + var_100_40 and arg_97_1.time_ < var_100_30 + var_100_40 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play1109704025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1109704025
		arg_101_1.duration_ = 7.7

		local var_101_0 = {
			zh = 6.533,
			ja = 7.7
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
				arg_101_0:Play1109704026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1080ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1080ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0.7, -1.01, -6.05)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1080ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1080ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1080ui_story == nil then
				arg_101_1.var_.characterEffect1080ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect1080ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1080ui_story then
				arg_101_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_15 = arg_101_1.actors_["1027ui_story"]
			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 and not isNil(var_104_15) and arg_101_1.var_.characterEffect1027ui_story == nil then
				arg_101_1.var_.characterEffect1027ui_story = var_104_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_17 = 0.200000002980232

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 and not isNil(var_104_15) then
				local var_104_18 = (arg_101_1.time_ - var_104_16) / var_104_17

				if arg_101_1.var_.characterEffect1027ui_story and not isNil(var_104_15) then
					local var_104_19 = Mathf.Lerp(0, 0.5, var_104_18)

					arg_101_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1027ui_story.fillRatio = var_104_19
				end
			end

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 and not isNil(var_104_15) and arg_101_1.var_.characterEffect1027ui_story then
				local var_104_20 = 0.5

				arg_101_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1027ui_story.fillRatio = var_104_20
			end

			local var_104_21 = arg_101_1.actors_["1027ui_story"].transform
			local var_104_22 = 0

			if var_104_22 < arg_101_1.time_ and arg_101_1.time_ <= var_104_22 + arg_104_0 then
				arg_101_1.var_.moveOldPos1027ui_story = var_104_21.localPosition
			end

			local var_104_23 = 0.001

			if var_104_22 <= arg_101_1.time_ and arg_101_1.time_ < var_104_22 + var_104_23 then
				local var_104_24 = (arg_101_1.time_ - var_104_22) / var_104_23
				local var_104_25 = Vector3.New(0, 100, 0)

				var_104_21.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1027ui_story, var_104_25, var_104_24)

				local var_104_26 = manager.ui.mainCamera.transform.position - var_104_21.position

				var_104_21.forward = Vector3.New(var_104_26.x, var_104_26.y, var_104_26.z)

				local var_104_27 = var_104_21.localEulerAngles

				var_104_27.z = 0
				var_104_27.x = 0
				var_104_21.localEulerAngles = var_104_27
			end

			if arg_101_1.time_ >= var_104_22 + var_104_23 and arg_101_1.time_ < var_104_22 + var_104_23 + arg_104_0 then
				var_104_21.localPosition = Vector3.New(0, 100, 0)

				local var_104_28 = manager.ui.mainCamera.transform.position - var_104_21.position

				var_104_21.forward = Vector3.New(var_104_28.x, var_104_28.y, var_104_28.z)

				local var_104_29 = var_104_21.localEulerAngles

				var_104_29.z = 0
				var_104_29.x = 0
				var_104_21.localEulerAngles = var_104_29
			end

			local var_104_30 = 0
			local var_104_31 = 0.6

			if var_104_30 < arg_101_1.time_ and arg_101_1.time_ <= var_104_30 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_32 = arg_101_1:FormatText(StoryNameCfg[55].name)

				arg_101_1.leftNameTxt_.text = var_104_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_33 = arg_101_1:GetWordFromCfg(1109704025)
				local var_104_34 = arg_101_1:FormatText(var_104_33.content)

				arg_101_1.text_.text = var_104_34

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_35 = 24
				local var_104_36 = utf8.len(var_104_34)
				local var_104_37 = var_104_35 <= 0 and var_104_31 or var_104_31 * (var_104_36 / var_104_35)

				if var_104_37 > 0 and var_104_31 < var_104_37 then
					arg_101_1.talkMaxDuration = var_104_37

					if var_104_37 + var_104_30 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_37 + var_104_30
					end
				end

				arg_101_1.text_.text = var_104_34
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704025", "story_v_side_new_1109704.awb") ~= 0 then
					local var_104_38 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704025", "story_v_side_new_1109704.awb") / 1000

					if var_104_38 + var_104_30 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_38 + var_104_30
					end

					if var_104_33.prefab_name ~= "" and arg_101_1.actors_[var_104_33.prefab_name] ~= nil then
						local var_104_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_33.prefab_name].transform, "story_v_side_new_1109704", "1109704025", "story_v_side_new_1109704.awb")

						arg_101_1:RecordAudio("1109704025", var_104_39)
						arg_101_1:RecordAudio("1109704025", var_104_39)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704025", "story_v_side_new_1109704.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704025", "story_v_side_new_1109704.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_40 = math.max(var_104_31, arg_101_1.talkMaxDuration)

			if var_104_30 <= arg_101_1.time_ and arg_101_1.time_ < var_104_30 + var_104_40 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_30) / var_104_40

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_30 + var_104_40 and arg_101_1.time_ < var_104_30 + var_104_40 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play1109704026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1109704026
		arg_105_1.duration_ = 5.7

		local var_105_0 = {
			zh = 5.333,
			ja = 5.7
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
				arg_105_0:Play1109704027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1027ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1027ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0.7, -0.81, -5.8)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1027ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0.7, -0.81, -5.8)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = arg_105_1.actors_["1027ui_story"]
			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect1027ui_story == nil then
				arg_105_1.var_.characterEffect1027ui_story = var_108_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_11 = 0.200000002980232

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_11 and not isNil(var_108_9) then
				local var_108_12 = (arg_105_1.time_ - var_108_10) / var_108_11

				if arg_105_1.var_.characterEffect1027ui_story and not isNil(var_108_9) then
					arg_105_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_10 + var_108_11 and arg_105_1.time_ < var_108_10 + var_108_11 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect1027ui_story then
				arg_105_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_108_13 = 0

			if var_108_13 < arg_105_1.time_ and arg_105_1.time_ <= var_108_13 + arg_108_0 then
				arg_105_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_108_14 = 0

			if var_108_14 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 then
				arg_105_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_108_15 = arg_105_1.actors_["1080ui_story"].transform
			local var_108_16 = 0

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.var_.moveOldPos1080ui_story = var_108_15.localPosition
			end

			local var_108_17 = 0.001

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_17 then
				local var_108_18 = (arg_105_1.time_ - var_108_16) / var_108_17
				local var_108_19 = Vector3.New(0, 100, 0)

				var_108_15.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1080ui_story, var_108_19, var_108_18)

				local var_108_20 = manager.ui.mainCamera.transform.position - var_108_15.position

				var_108_15.forward = Vector3.New(var_108_20.x, var_108_20.y, var_108_20.z)

				local var_108_21 = var_108_15.localEulerAngles

				var_108_21.z = 0
				var_108_21.x = 0
				var_108_15.localEulerAngles = var_108_21
			end

			if arg_105_1.time_ >= var_108_16 + var_108_17 and arg_105_1.time_ < var_108_16 + var_108_17 + arg_108_0 then
				var_108_15.localPosition = Vector3.New(0, 100, 0)

				local var_108_22 = manager.ui.mainCamera.transform.position - var_108_15.position

				var_108_15.forward = Vector3.New(var_108_22.x, var_108_22.y, var_108_22.z)

				local var_108_23 = var_108_15.localEulerAngles

				var_108_23.z = 0
				var_108_23.x = 0
				var_108_15.localEulerAngles = var_108_23
			end

			local var_108_24 = arg_105_1.actors_["1080ui_story"]
			local var_108_25 = 0

			if var_108_25 < arg_105_1.time_ and arg_105_1.time_ <= var_108_25 + arg_108_0 and not isNil(var_108_24) and arg_105_1.var_.characterEffect1080ui_story == nil then
				arg_105_1.var_.characterEffect1080ui_story = var_108_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_26 = 0.200000002980232

			if var_108_25 <= arg_105_1.time_ and arg_105_1.time_ < var_108_25 + var_108_26 and not isNil(var_108_24) then
				local var_108_27 = (arg_105_1.time_ - var_108_25) / var_108_26

				if arg_105_1.var_.characterEffect1080ui_story and not isNil(var_108_24) then
					local var_108_28 = Mathf.Lerp(0, 0.5, var_108_27)

					arg_105_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1080ui_story.fillRatio = var_108_28
				end
			end

			if arg_105_1.time_ >= var_108_25 + var_108_26 and arg_105_1.time_ < var_108_25 + var_108_26 + arg_108_0 and not isNil(var_108_24) and arg_105_1.var_.characterEffect1080ui_story then
				local var_108_29 = 0.5

				arg_105_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1080ui_story.fillRatio = var_108_29
			end

			local var_108_30 = 0
			local var_108_31 = 0.475

			if var_108_30 < arg_105_1.time_ and arg_105_1.time_ <= var_108_30 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_32 = arg_105_1:FormatText(StoryNameCfg[56].name)

				arg_105_1.leftNameTxt_.text = var_108_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_33 = arg_105_1:GetWordFromCfg(1109704026)
				local var_108_34 = arg_105_1:FormatText(var_108_33.content)

				arg_105_1.text_.text = var_108_34

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_35 = 19
				local var_108_36 = utf8.len(var_108_34)
				local var_108_37 = var_108_35 <= 0 and var_108_31 or var_108_31 * (var_108_36 / var_108_35)

				if var_108_37 > 0 and var_108_31 < var_108_37 then
					arg_105_1.talkMaxDuration = var_108_37

					if var_108_37 + var_108_30 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_37 + var_108_30
					end
				end

				arg_105_1.text_.text = var_108_34
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704026", "story_v_side_new_1109704.awb") ~= 0 then
					local var_108_38 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704026", "story_v_side_new_1109704.awb") / 1000

					if var_108_38 + var_108_30 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_38 + var_108_30
					end

					if var_108_33.prefab_name ~= "" and arg_105_1.actors_[var_108_33.prefab_name] ~= nil then
						local var_108_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_33.prefab_name].transform, "story_v_side_new_1109704", "1109704026", "story_v_side_new_1109704.awb")

						arg_105_1:RecordAudio("1109704026", var_108_39)
						arg_105_1:RecordAudio("1109704026", var_108_39)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704026", "story_v_side_new_1109704.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704026", "story_v_side_new_1109704.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_40 = math.max(var_108_31, arg_105_1.talkMaxDuration)

			if var_108_30 <= arg_105_1.time_ and arg_105_1.time_ < var_108_30 + var_108_40 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_30) / var_108_40

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_30 + var_108_40 and arg_105_1.time_ < var_108_30 + var_108_40 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play1109704027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1109704027
		arg_109_1.duration_ = 5.1

		local var_109_0 = {
			zh = 3.733,
			ja = 5.1
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
				arg_109_0:Play1109704028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1097ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1097ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1097ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["1097ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1097ui_story == nil then
				arg_109_1.var_.characterEffect1097ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect1097ui_story and not isNil(var_112_9) then
					arg_109_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1097ui_story then
				arg_109_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_15 = arg_109_1.actors_["1080ui_story"].transform
			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 then
				arg_109_1.var_.moveOldPos1080ui_story = var_112_15.localPosition
			end

			local var_112_17 = 0.001

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_17 then
				local var_112_18 = (arg_109_1.time_ - var_112_16) / var_112_17
				local var_112_19 = Vector3.New(0.7, -1.01, -6.05)

				var_112_15.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1080ui_story, var_112_19, var_112_18)

				local var_112_20 = manager.ui.mainCamera.transform.position - var_112_15.position

				var_112_15.forward = Vector3.New(var_112_20.x, var_112_20.y, var_112_20.z)

				local var_112_21 = var_112_15.localEulerAngles

				var_112_21.z = 0
				var_112_21.x = 0
				var_112_15.localEulerAngles = var_112_21
			end

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 then
				var_112_15.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_112_22 = manager.ui.mainCamera.transform.position - var_112_15.position

				var_112_15.forward = Vector3.New(var_112_22.x, var_112_22.y, var_112_22.z)

				local var_112_23 = var_112_15.localEulerAngles

				var_112_23.z = 0
				var_112_23.x = 0
				var_112_15.localEulerAngles = var_112_23
			end

			local var_112_24 = arg_109_1.actors_["1080ui_story"]
			local var_112_25 = 0

			if var_112_25 < arg_109_1.time_ and arg_109_1.time_ <= var_112_25 + arg_112_0 and not isNil(var_112_24) and arg_109_1.var_.characterEffect1080ui_story == nil then
				arg_109_1.var_.characterEffect1080ui_story = var_112_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_26 = 0.200000002980232

			if var_112_25 <= arg_109_1.time_ and arg_109_1.time_ < var_112_25 + var_112_26 and not isNil(var_112_24) then
				local var_112_27 = (arg_109_1.time_ - var_112_25) / var_112_26

				if arg_109_1.var_.characterEffect1080ui_story and not isNil(var_112_24) then
					local var_112_28 = Mathf.Lerp(0, 0.5, var_112_27)

					arg_109_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1080ui_story.fillRatio = var_112_28
				end
			end

			if arg_109_1.time_ >= var_112_25 + var_112_26 and arg_109_1.time_ < var_112_25 + var_112_26 + arg_112_0 and not isNil(var_112_24) and arg_109_1.var_.characterEffect1080ui_story then
				local var_112_29 = 0.5

				arg_109_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1080ui_story.fillRatio = var_112_29
			end

			local var_112_30 = arg_109_1.actors_["1027ui_story"].transform
			local var_112_31 = 0

			if var_112_31 < arg_109_1.time_ and arg_109_1.time_ <= var_112_31 + arg_112_0 then
				arg_109_1.var_.moveOldPos1027ui_story = var_112_30.localPosition
			end

			local var_112_32 = 0.001

			if var_112_31 <= arg_109_1.time_ and arg_109_1.time_ < var_112_31 + var_112_32 then
				local var_112_33 = (arg_109_1.time_ - var_112_31) / var_112_32
				local var_112_34 = Vector3.New(0, 100, 0)

				var_112_30.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1027ui_story, var_112_34, var_112_33)

				local var_112_35 = manager.ui.mainCamera.transform.position - var_112_30.position

				var_112_30.forward = Vector3.New(var_112_35.x, var_112_35.y, var_112_35.z)

				local var_112_36 = var_112_30.localEulerAngles

				var_112_36.z = 0
				var_112_36.x = 0
				var_112_30.localEulerAngles = var_112_36
			end

			if arg_109_1.time_ >= var_112_31 + var_112_32 and arg_109_1.time_ < var_112_31 + var_112_32 + arg_112_0 then
				var_112_30.localPosition = Vector3.New(0, 100, 0)

				local var_112_37 = manager.ui.mainCamera.transform.position - var_112_30.position

				var_112_30.forward = Vector3.New(var_112_37.x, var_112_37.y, var_112_37.z)

				local var_112_38 = var_112_30.localEulerAngles

				var_112_38.z = 0
				var_112_38.x = 0
				var_112_30.localEulerAngles = var_112_38
			end

			local var_112_39 = arg_109_1.actors_["1027ui_story"]
			local var_112_40 = 0

			if var_112_40 < arg_109_1.time_ and arg_109_1.time_ <= var_112_40 + arg_112_0 and not isNil(var_112_39) and arg_109_1.var_.characterEffect1027ui_story == nil then
				arg_109_1.var_.characterEffect1027ui_story = var_112_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_41 = 0.200000002980232

			if var_112_40 <= arg_109_1.time_ and arg_109_1.time_ < var_112_40 + var_112_41 and not isNil(var_112_39) then
				local var_112_42 = (arg_109_1.time_ - var_112_40) / var_112_41

				if arg_109_1.var_.characterEffect1027ui_story and not isNil(var_112_39) then
					local var_112_43 = Mathf.Lerp(0, 0.5, var_112_42)

					arg_109_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1027ui_story.fillRatio = var_112_43
				end
			end

			if arg_109_1.time_ >= var_112_40 + var_112_41 and arg_109_1.time_ < var_112_40 + var_112_41 + arg_112_0 and not isNil(var_112_39) and arg_109_1.var_.characterEffect1027ui_story then
				local var_112_44 = 0.5

				arg_109_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1027ui_story.fillRatio = var_112_44
			end

			local var_112_45 = 0
			local var_112_46 = 0.375

			if var_112_45 < arg_109_1.time_ and arg_109_1.time_ <= var_112_45 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_47 = arg_109_1:FormatText(StoryNameCfg[216].name)

				arg_109_1.leftNameTxt_.text = var_112_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_48 = arg_109_1:GetWordFromCfg(1109704027)
				local var_112_49 = arg_109_1:FormatText(var_112_48.content)

				arg_109_1.text_.text = var_112_49

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_50 = 15
				local var_112_51 = utf8.len(var_112_49)
				local var_112_52 = var_112_50 <= 0 and var_112_46 or var_112_46 * (var_112_51 / var_112_50)

				if var_112_52 > 0 and var_112_46 < var_112_52 then
					arg_109_1.talkMaxDuration = var_112_52

					if var_112_52 + var_112_45 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_52 + var_112_45
					end
				end

				arg_109_1.text_.text = var_112_49
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704027", "story_v_side_new_1109704.awb") ~= 0 then
					local var_112_53 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704027", "story_v_side_new_1109704.awb") / 1000

					if var_112_53 + var_112_45 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_53 + var_112_45
					end

					if var_112_48.prefab_name ~= "" and arg_109_1.actors_[var_112_48.prefab_name] ~= nil then
						local var_112_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_48.prefab_name].transform, "story_v_side_new_1109704", "1109704027", "story_v_side_new_1109704.awb")

						arg_109_1:RecordAudio("1109704027", var_112_54)
						arg_109_1:RecordAudio("1109704027", var_112_54)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704027", "story_v_side_new_1109704.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704027", "story_v_side_new_1109704.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_55 = math.max(var_112_46, arg_109_1.talkMaxDuration)

			if var_112_45 <= arg_109_1.time_ and arg_109_1.time_ < var_112_45 + var_112_55 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_45) / var_112_55

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_45 + var_112_55 and arg_109_1.time_ < var_112_45 + var_112_55 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play1109704028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1109704028
		arg_113_1.duration_ = 5.4

		local var_113_0 = {
			zh = 5.4,
			ja = 4.366
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
				arg_113_0:Play1109704029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_2 = 0
			local var_116_3 = 0.575

			if var_116_2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_4 = arg_113_1:FormatText(StoryNameCfg[216].name)

				arg_113_1.leftNameTxt_.text = var_116_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_5 = arg_113_1:GetWordFromCfg(1109704028)
				local var_116_6 = arg_113_1:FormatText(var_116_5.content)

				arg_113_1.text_.text = var_116_6

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 23
				local var_116_8 = utf8.len(var_116_6)
				local var_116_9 = var_116_7 <= 0 and var_116_3 or var_116_3 * (var_116_8 / var_116_7)

				if var_116_9 > 0 and var_116_3 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_6
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704028", "story_v_side_new_1109704.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704028", "story_v_side_new_1109704.awb") / 1000

					if var_116_10 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_2
					end

					if var_116_5.prefab_name ~= "" and arg_113_1.actors_[var_116_5.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_5.prefab_name].transform, "story_v_side_new_1109704", "1109704028", "story_v_side_new_1109704.awb")

						arg_113_1:RecordAudio("1109704028", var_116_11)
						arg_113_1:RecordAudio("1109704028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704028", "story_v_side_new_1109704.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704028", "story_v_side_new_1109704.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_3, arg_113_1.talkMaxDuration)

			if var_116_2 <= arg_113_1.time_ and arg_113_1.time_ < var_116_2 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_2) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_2 + var_116_12 and arg_113_1.time_ < var_116_2 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1109704029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1109704029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1109704030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1097ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1097ui_story == nil then
				arg_117_1.var_.characterEffect1097ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1097ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1097ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1097ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1097ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0
			local var_120_7 = 0.25

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_8 = arg_117_1:FormatText(StoryNameCfg[7].name)

				arg_117_1.leftNameTxt_.text = var_120_8

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

				local var_120_9 = arg_117_1:GetWordFromCfg(1109704029)
				local var_120_10 = arg_117_1:FormatText(var_120_9.content)

				arg_117_1.text_.text = var_120_10

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 10
				local var_120_12 = utf8.len(var_120_10)
				local var_120_13 = var_120_11 <= 0 and var_120_7 or var_120_7 * (var_120_12 / var_120_11)

				if var_120_13 > 0 and var_120_7 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_10
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1109704030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1109704030
		arg_121_1.duration_ = 4.27

		local var_121_0 = {
			zh = 3.666,
			ja = 4.266
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
				arg_121_0:Play1109704031(arg_121_1)
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
				arg_121_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_124_5 = 0

			if var_124_5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_124_6 = 0
			local var_124_7 = 0.575

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_8 = arg_121_1:FormatText(StoryNameCfg[216].name)

				arg_121_1.leftNameTxt_.text = var_124_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_9 = arg_121_1:GetWordFromCfg(1109704030)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 23
				local var_124_12 = utf8.len(var_124_10)
				local var_124_13 = var_124_11 <= 0 and var_124_7 or var_124_7 * (var_124_12 / var_124_11)

				if var_124_13 > 0 and var_124_7 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_10
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704030", "story_v_side_new_1109704.awb") ~= 0 then
					local var_124_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704030", "story_v_side_new_1109704.awb") / 1000

					if var_124_14 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_6
					end

					if var_124_9.prefab_name ~= "" and arg_121_1.actors_[var_124_9.prefab_name] ~= nil then
						local var_124_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_9.prefab_name].transform, "story_v_side_new_1109704", "1109704030", "story_v_side_new_1109704.awb")

						arg_121_1:RecordAudio("1109704030", var_124_15)
						arg_121_1:RecordAudio("1109704030", var_124_15)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704030", "story_v_side_new_1109704.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704030", "story_v_side_new_1109704.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_16 and arg_121_1.time_ < var_124_6 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1109704031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1109704031
		arg_125_1.duration_ = 7.8

		local var_125_0 = {
			zh = 6.666,
			ja = 7.8
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
				arg_125_0:Play1109704032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1027ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1027ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0.7, -0.81, -5.8)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1027ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0.7, -0.81, -5.8)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["1027ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1027ui_story == nil then
				arg_125_1.var_.characterEffect1027ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect1027ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1027ui_story then
				arg_125_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_128_13 = 0

			if var_128_13 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			local var_128_14 = 0

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 then
				arg_125_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_128_15 = arg_125_1.actors_["1080ui_story"].transform
			local var_128_16 = 0

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				arg_125_1.var_.moveOldPos1080ui_story = var_128_15.localPosition
			end

			local var_128_17 = 0.001

			if var_128_16 <= arg_125_1.time_ and arg_125_1.time_ < var_128_16 + var_128_17 then
				local var_128_18 = (arg_125_1.time_ - var_128_16) / var_128_17
				local var_128_19 = Vector3.New(0, 100, 0)

				var_128_15.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1080ui_story, var_128_19, var_128_18)

				local var_128_20 = manager.ui.mainCamera.transform.position - var_128_15.position

				var_128_15.forward = Vector3.New(var_128_20.x, var_128_20.y, var_128_20.z)

				local var_128_21 = var_128_15.localEulerAngles

				var_128_21.z = 0
				var_128_21.x = 0
				var_128_15.localEulerAngles = var_128_21
			end

			if arg_125_1.time_ >= var_128_16 + var_128_17 and arg_125_1.time_ < var_128_16 + var_128_17 + arg_128_0 then
				var_128_15.localPosition = Vector3.New(0, 100, 0)

				local var_128_22 = manager.ui.mainCamera.transform.position - var_128_15.position

				var_128_15.forward = Vector3.New(var_128_22.x, var_128_22.y, var_128_22.z)

				local var_128_23 = var_128_15.localEulerAngles

				var_128_23.z = 0
				var_128_23.x = 0
				var_128_15.localEulerAngles = var_128_23
			end

			local var_128_24 = arg_125_1.actors_["1080ui_story"]
			local var_128_25 = 0

			if var_128_25 < arg_125_1.time_ and arg_125_1.time_ <= var_128_25 + arg_128_0 and not isNil(var_128_24) and arg_125_1.var_.characterEffect1080ui_story == nil then
				arg_125_1.var_.characterEffect1080ui_story = var_128_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_26 = 0.200000002980232

			if var_128_25 <= arg_125_1.time_ and arg_125_1.time_ < var_128_25 + var_128_26 and not isNil(var_128_24) then
				local var_128_27 = (arg_125_1.time_ - var_128_25) / var_128_26

				if arg_125_1.var_.characterEffect1080ui_story and not isNil(var_128_24) then
					local var_128_28 = Mathf.Lerp(0, 0.5, var_128_27)

					arg_125_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1080ui_story.fillRatio = var_128_28
				end
			end

			if arg_125_1.time_ >= var_128_25 + var_128_26 and arg_125_1.time_ < var_128_25 + var_128_26 + arg_128_0 and not isNil(var_128_24) and arg_125_1.var_.characterEffect1080ui_story then
				local var_128_29 = 0.5

				arg_125_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1080ui_story.fillRatio = var_128_29
			end

			local var_128_30 = arg_125_1.actors_["1097ui_story"]
			local var_128_31 = 0

			if var_128_31 < arg_125_1.time_ and arg_125_1.time_ <= var_128_31 + arg_128_0 and not isNil(var_128_30) and arg_125_1.var_.characterEffect1097ui_story == nil then
				arg_125_1.var_.characterEffect1097ui_story = var_128_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_32 = 0.200000002980232

			if var_128_31 <= arg_125_1.time_ and arg_125_1.time_ < var_128_31 + var_128_32 and not isNil(var_128_30) then
				local var_128_33 = (arg_125_1.time_ - var_128_31) / var_128_32

				if arg_125_1.var_.characterEffect1097ui_story and not isNil(var_128_30) then
					local var_128_34 = Mathf.Lerp(0, 0.5, var_128_33)

					arg_125_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1097ui_story.fillRatio = var_128_34
				end
			end

			if arg_125_1.time_ >= var_128_31 + var_128_32 and arg_125_1.time_ < var_128_31 + var_128_32 + arg_128_0 and not isNil(var_128_30) and arg_125_1.var_.characterEffect1097ui_story then
				local var_128_35 = 0.5

				arg_125_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1097ui_story.fillRatio = var_128_35
			end

			local var_128_36 = 0
			local var_128_37 = 0.6

			if var_128_36 < arg_125_1.time_ and arg_125_1.time_ <= var_128_36 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_38 = arg_125_1:FormatText(StoryNameCfg[56].name)

				arg_125_1.leftNameTxt_.text = var_128_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_39 = arg_125_1:GetWordFromCfg(1109704031)
				local var_128_40 = arg_125_1:FormatText(var_128_39.content)

				arg_125_1.text_.text = var_128_40

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_41 = 24
				local var_128_42 = utf8.len(var_128_40)
				local var_128_43 = var_128_41 <= 0 and var_128_37 or var_128_37 * (var_128_42 / var_128_41)

				if var_128_43 > 0 and var_128_37 < var_128_43 then
					arg_125_1.talkMaxDuration = var_128_43

					if var_128_43 + var_128_36 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_43 + var_128_36
					end
				end

				arg_125_1.text_.text = var_128_40
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704031", "story_v_side_new_1109704.awb") ~= 0 then
					local var_128_44 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704031", "story_v_side_new_1109704.awb") / 1000

					if var_128_44 + var_128_36 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_44 + var_128_36
					end

					if var_128_39.prefab_name ~= "" and arg_125_1.actors_[var_128_39.prefab_name] ~= nil then
						local var_128_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_39.prefab_name].transform, "story_v_side_new_1109704", "1109704031", "story_v_side_new_1109704.awb")

						arg_125_1:RecordAudio("1109704031", var_128_45)
						arg_125_1:RecordAudio("1109704031", var_128_45)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704031", "story_v_side_new_1109704.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704031", "story_v_side_new_1109704.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_46 = math.max(var_128_37, arg_125_1.talkMaxDuration)

			if var_128_36 <= arg_125_1.time_ and arg_125_1.time_ < var_128_36 + var_128_46 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_36) / var_128_46

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_36 + var_128_46 and arg_125_1.time_ < var_128_36 + var_128_46 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play1109704032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1109704032
		arg_129_1.duration_ = 8.83

		local var_129_0 = {
			zh = 4.9,
			ja = 8.833
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
				arg_129_0:Play1109704033(arg_129_1)
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
				arg_129_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_132_5 = 0

			if var_132_5 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_6 = arg_129_1.actors_["1027ui_story"]
			local var_132_7 = 0

			if var_132_7 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 and not isNil(var_132_6) and arg_129_1.var_.characterEffect1027ui_story == nil then
				arg_129_1.var_.characterEffect1027ui_story = var_132_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_8 = 0.200000002980232

			if var_132_7 <= arg_129_1.time_ and arg_129_1.time_ < var_132_7 + var_132_8 and not isNil(var_132_6) then
				local var_132_9 = (arg_129_1.time_ - var_132_7) / var_132_8

				if arg_129_1.var_.characterEffect1027ui_story and not isNil(var_132_6) then
					local var_132_10 = Mathf.Lerp(0, 0.5, var_132_9)

					arg_129_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1027ui_story.fillRatio = var_132_10
				end
			end

			if arg_129_1.time_ >= var_132_7 + var_132_8 and arg_129_1.time_ < var_132_7 + var_132_8 + arg_132_0 and not isNil(var_132_6) and arg_129_1.var_.characterEffect1027ui_story then
				local var_132_11 = 0.5

				arg_129_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1027ui_story.fillRatio = var_132_11
			end

			local var_132_12 = 0
			local var_132_13 = 0.55

			if var_132_12 < arg_129_1.time_ and arg_129_1.time_ <= var_132_12 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_14 = arg_129_1:FormatText(StoryNameCfg[216].name)

				arg_129_1.leftNameTxt_.text = var_132_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_15 = arg_129_1:GetWordFromCfg(1109704032)
				local var_132_16 = arg_129_1:FormatText(var_132_15.content)

				arg_129_1.text_.text = var_132_16

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_17 = 22
				local var_132_18 = utf8.len(var_132_16)
				local var_132_19 = var_132_17 <= 0 and var_132_13 or var_132_13 * (var_132_18 / var_132_17)

				if var_132_19 > 0 and var_132_13 < var_132_19 then
					arg_129_1.talkMaxDuration = var_132_19

					if var_132_19 + var_132_12 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_19 + var_132_12
					end
				end

				arg_129_1.text_.text = var_132_16
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704032", "story_v_side_new_1109704.awb") ~= 0 then
					local var_132_20 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704032", "story_v_side_new_1109704.awb") / 1000

					if var_132_20 + var_132_12 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_20 + var_132_12
					end

					if var_132_15.prefab_name ~= "" and arg_129_1.actors_[var_132_15.prefab_name] ~= nil then
						local var_132_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_15.prefab_name].transform, "story_v_side_new_1109704", "1109704032", "story_v_side_new_1109704.awb")

						arg_129_1:RecordAudio("1109704032", var_132_21)
						arg_129_1:RecordAudio("1109704032", var_132_21)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704032", "story_v_side_new_1109704.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704032", "story_v_side_new_1109704.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_22 = math.max(var_132_13, arg_129_1.talkMaxDuration)

			if var_132_12 <= arg_129_1.time_ and arg_129_1.time_ < var_132_12 + var_132_22 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_12) / var_132_22

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_12 + var_132_22 and arg_129_1.time_ < var_132_12 + var_132_22 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1109704033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1109704033
		arg_133_1.duration_ = 5.6

		local var_133_0 = {
			zh = 5.6,
			ja = 5.333
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
				arg_133_0:Play1109704034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1027ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1027ui_story == nil then
				arg_133_1.var_.characterEffect1027ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1027ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1027ui_story then
				arg_133_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_136_4 = 0

			if var_136_4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_2")
			end

			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_6 = arg_133_1.actors_["1097ui_story"]
			local var_136_7 = 0

			if var_136_7 < arg_133_1.time_ and arg_133_1.time_ <= var_136_7 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1097ui_story == nil then
				arg_133_1.var_.characterEffect1097ui_story = var_136_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_8 = 0.200000002980232

			if var_136_7 <= arg_133_1.time_ and arg_133_1.time_ < var_136_7 + var_136_8 and not isNil(var_136_6) then
				local var_136_9 = (arg_133_1.time_ - var_136_7) / var_136_8

				if arg_133_1.var_.characterEffect1097ui_story and not isNil(var_136_6) then
					local var_136_10 = Mathf.Lerp(0, 0.5, var_136_9)

					arg_133_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1097ui_story.fillRatio = var_136_10
				end
			end

			if arg_133_1.time_ >= var_136_7 + var_136_8 and arg_133_1.time_ < var_136_7 + var_136_8 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1097ui_story then
				local var_136_11 = 0.5

				arg_133_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1097ui_story.fillRatio = var_136_11
			end

			local var_136_12 = 0
			local var_136_13 = 0.55

			if var_136_12 < arg_133_1.time_ and arg_133_1.time_ <= var_136_12 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_14 = arg_133_1:FormatText(StoryNameCfg[56].name)

				arg_133_1.leftNameTxt_.text = var_136_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_15 = arg_133_1:GetWordFromCfg(1109704033)
				local var_136_16 = arg_133_1:FormatText(var_136_15.content)

				arg_133_1.text_.text = var_136_16

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_17 = 22
				local var_136_18 = utf8.len(var_136_16)
				local var_136_19 = var_136_17 <= 0 and var_136_13 or var_136_13 * (var_136_18 / var_136_17)

				if var_136_19 > 0 and var_136_13 < var_136_19 then
					arg_133_1.talkMaxDuration = var_136_19

					if var_136_19 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_19 + var_136_12
					end
				end

				arg_133_1.text_.text = var_136_16
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704033", "story_v_side_new_1109704.awb") ~= 0 then
					local var_136_20 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704033", "story_v_side_new_1109704.awb") / 1000

					if var_136_20 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_20 + var_136_12
					end

					if var_136_15.prefab_name ~= "" and arg_133_1.actors_[var_136_15.prefab_name] ~= nil then
						local var_136_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_15.prefab_name].transform, "story_v_side_new_1109704", "1109704033", "story_v_side_new_1109704.awb")

						arg_133_1:RecordAudio("1109704033", var_136_21)
						arg_133_1:RecordAudio("1109704033", var_136_21)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704033", "story_v_side_new_1109704.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704033", "story_v_side_new_1109704.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_22 = math.max(var_136_13, arg_133_1.talkMaxDuration)

			if var_136_12 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_22 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_12) / var_136_22

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_12 + var_136_22 and arg_133_1.time_ < var_136_12 + var_136_22 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1109704034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1109704034
		arg_137_1.duration_ = 7.23

		local var_137_0 = {
			zh = 7.233,
			ja = 5.966
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1109704035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1097ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1097ui_story == nil then
				arg_137_1.var_.characterEffect1097ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1097ui_story and not isNil(var_140_0) then
					arg_137_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1097ui_story then
				arg_137_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_140_4 = 0

			if var_140_4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_140_5 = 0

			if var_140_5 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_6 = arg_137_1.actors_["1027ui_story"]
			local var_140_7 = 0

			if var_140_7 < arg_137_1.time_ and arg_137_1.time_ <= var_140_7 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect1027ui_story == nil then
				arg_137_1.var_.characterEffect1027ui_story = var_140_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_8 = 0.200000002980232

			if var_140_7 <= arg_137_1.time_ and arg_137_1.time_ < var_140_7 + var_140_8 and not isNil(var_140_6) then
				local var_140_9 = (arg_137_1.time_ - var_140_7) / var_140_8

				if arg_137_1.var_.characterEffect1027ui_story and not isNil(var_140_6) then
					local var_140_10 = Mathf.Lerp(0, 0.5, var_140_9)

					arg_137_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1027ui_story.fillRatio = var_140_10
				end
			end

			if arg_137_1.time_ >= var_140_7 + var_140_8 and arg_137_1.time_ < var_140_7 + var_140_8 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect1027ui_story then
				local var_140_11 = 0.5

				arg_137_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1027ui_story.fillRatio = var_140_11
			end

			local var_140_12 = 0
			local var_140_13 = 0.825

			if var_140_12 < arg_137_1.time_ and arg_137_1.time_ <= var_140_12 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_14 = arg_137_1:FormatText(StoryNameCfg[216].name)

				arg_137_1.leftNameTxt_.text = var_140_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_15 = arg_137_1:GetWordFromCfg(1109704034)
				local var_140_16 = arg_137_1:FormatText(var_140_15.content)

				arg_137_1.text_.text = var_140_16

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_17 = 33
				local var_140_18 = utf8.len(var_140_16)
				local var_140_19 = var_140_17 <= 0 and var_140_13 or var_140_13 * (var_140_18 / var_140_17)

				if var_140_19 > 0 and var_140_13 < var_140_19 then
					arg_137_1.talkMaxDuration = var_140_19

					if var_140_19 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_19 + var_140_12
					end
				end

				arg_137_1.text_.text = var_140_16
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704034", "story_v_side_new_1109704.awb") ~= 0 then
					local var_140_20 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704034", "story_v_side_new_1109704.awb") / 1000

					if var_140_20 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_20 + var_140_12
					end

					if var_140_15.prefab_name ~= "" and arg_137_1.actors_[var_140_15.prefab_name] ~= nil then
						local var_140_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_15.prefab_name].transform, "story_v_side_new_1109704", "1109704034", "story_v_side_new_1109704.awb")

						arg_137_1:RecordAudio("1109704034", var_140_21)
						arg_137_1:RecordAudio("1109704034", var_140_21)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704034", "story_v_side_new_1109704.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704034", "story_v_side_new_1109704.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_22 = math.max(var_140_13, arg_137_1.talkMaxDuration)

			if var_140_12 <= arg_137_1.time_ and arg_137_1.time_ < var_140_12 + var_140_22 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_12) / var_140_22

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_12 + var_140_22 and arg_137_1.time_ < var_140_12 + var_140_22 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1109704035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1109704035
		arg_141_1.duration_ = 3.1

		local var_141_0 = {
			zh = 2.566,
			ja = 3.1
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
				arg_141_0:Play1109704036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1027ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1027ui_story == nil then
				arg_141_1.var_.characterEffect1027ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1027ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1027ui_story then
				arg_141_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_144_4 = 0

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_144_6 = arg_141_1.actors_["1097ui_story"]
			local var_144_7 = 0

			if var_144_7 < arg_141_1.time_ and arg_141_1.time_ <= var_144_7 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1097ui_story == nil then
				arg_141_1.var_.characterEffect1097ui_story = var_144_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_8 = 0.200000002980232

			if var_144_7 <= arg_141_1.time_ and arg_141_1.time_ < var_144_7 + var_144_8 and not isNil(var_144_6) then
				local var_144_9 = (arg_141_1.time_ - var_144_7) / var_144_8

				if arg_141_1.var_.characterEffect1097ui_story and not isNil(var_144_6) then
					local var_144_10 = Mathf.Lerp(0, 0.5, var_144_9)

					arg_141_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1097ui_story.fillRatio = var_144_10
				end
			end

			if arg_141_1.time_ >= var_144_7 + var_144_8 and arg_141_1.time_ < var_144_7 + var_144_8 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1097ui_story then
				local var_144_11 = 0.5

				arg_141_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1097ui_story.fillRatio = var_144_11
			end

			local var_144_12 = 0
			local var_144_13 = 0.125

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_14 = arg_141_1:FormatText(StoryNameCfg[56].name)

				arg_141_1.leftNameTxt_.text = var_144_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_15 = arg_141_1:GetWordFromCfg(1109704035)
				local var_144_16 = arg_141_1:FormatText(var_144_15.content)

				arg_141_1.text_.text = var_144_16

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_17 = 5
				local var_144_18 = utf8.len(var_144_16)
				local var_144_19 = var_144_17 <= 0 and var_144_13 or var_144_13 * (var_144_18 / var_144_17)

				if var_144_19 > 0 and var_144_13 < var_144_19 then
					arg_141_1.talkMaxDuration = var_144_19

					if var_144_19 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_19 + var_144_12
					end
				end

				arg_141_1.text_.text = var_144_16
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704035", "story_v_side_new_1109704.awb") ~= 0 then
					local var_144_20 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704035", "story_v_side_new_1109704.awb") / 1000

					if var_144_20 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_20 + var_144_12
					end

					if var_144_15.prefab_name ~= "" and arg_141_1.actors_[var_144_15.prefab_name] ~= nil then
						local var_144_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_15.prefab_name].transform, "story_v_side_new_1109704", "1109704035", "story_v_side_new_1109704.awb")

						arg_141_1:RecordAudio("1109704035", var_144_21)
						arg_141_1:RecordAudio("1109704035", var_144_21)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704035", "story_v_side_new_1109704.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704035", "story_v_side_new_1109704.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_22 = math.max(var_144_13, arg_141_1.talkMaxDuration)

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_22 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_12) / var_144_22

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_12 + var_144_22 and arg_141_1.time_ < var_144_12 + var_144_22 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1109704036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1109704036
		arg_145_1.duration_ = 5

		local var_145_0 = {
			zh = 5,
			ja = 3.066
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1109704037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1097ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1097ui_story == nil then
				arg_145_1.var_.characterEffect1097ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect1097ui_story and not isNil(var_148_0) then
					arg_145_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1097ui_story then
				arg_145_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_148_4 = 0

			if var_148_4 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_148_5 = 0

			if var_148_5 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_148_6 = arg_145_1.actors_["1027ui_story"]
			local var_148_7 = 0

			if var_148_7 < arg_145_1.time_ and arg_145_1.time_ <= var_148_7 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1027ui_story == nil then
				arg_145_1.var_.characterEffect1027ui_story = var_148_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_8 = 0.200000002980232

			if var_148_7 <= arg_145_1.time_ and arg_145_1.time_ < var_148_7 + var_148_8 and not isNil(var_148_6) then
				local var_148_9 = (arg_145_1.time_ - var_148_7) / var_148_8

				if arg_145_1.var_.characterEffect1027ui_story and not isNil(var_148_6) then
					local var_148_10 = Mathf.Lerp(0, 0.5, var_148_9)

					arg_145_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1027ui_story.fillRatio = var_148_10
				end
			end

			if arg_145_1.time_ >= var_148_7 + var_148_8 and arg_145_1.time_ < var_148_7 + var_148_8 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1027ui_story then
				local var_148_11 = 0.5

				arg_145_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1027ui_story.fillRatio = var_148_11
			end

			local var_148_12 = 0
			local var_148_13 = 0.4

			if var_148_12 < arg_145_1.time_ and arg_145_1.time_ <= var_148_12 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_14 = arg_145_1:FormatText(StoryNameCfg[216].name)

				arg_145_1.leftNameTxt_.text = var_148_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_15 = arg_145_1:GetWordFromCfg(1109704036)
				local var_148_16 = arg_145_1:FormatText(var_148_15.content)

				arg_145_1.text_.text = var_148_16

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_17 = 16
				local var_148_18 = utf8.len(var_148_16)
				local var_148_19 = var_148_17 <= 0 and var_148_13 or var_148_13 * (var_148_18 / var_148_17)

				if var_148_19 > 0 and var_148_13 < var_148_19 then
					arg_145_1.talkMaxDuration = var_148_19

					if var_148_19 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_19 + var_148_12
					end
				end

				arg_145_1.text_.text = var_148_16
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704036", "story_v_side_new_1109704.awb") ~= 0 then
					local var_148_20 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704036", "story_v_side_new_1109704.awb") / 1000

					if var_148_20 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_20 + var_148_12
					end

					if var_148_15.prefab_name ~= "" and arg_145_1.actors_[var_148_15.prefab_name] ~= nil then
						local var_148_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_15.prefab_name].transform, "story_v_side_new_1109704", "1109704036", "story_v_side_new_1109704.awb")

						arg_145_1:RecordAudio("1109704036", var_148_21)
						arg_145_1:RecordAudio("1109704036", var_148_21)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704036", "story_v_side_new_1109704.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704036", "story_v_side_new_1109704.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_22 = math.max(var_148_13, arg_145_1.talkMaxDuration)

			if var_148_12 <= arg_145_1.time_ and arg_145_1.time_ < var_148_12 + var_148_22 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_12) / var_148_22

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_12 + var_148_22 and arg_145_1.time_ < var_148_12 + var_148_22 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1109704037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1109704037
		arg_149_1.duration_ = 4.2

		local var_149_0 = {
			zh = 2.966,
			ja = 4.2
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1109704038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1027ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1027ui_story == nil then
				arg_149_1.var_.characterEffect1027ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect1027ui_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1027ui_story then
				arg_149_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_152_4 = 0

			if var_152_4 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_152_5 = 0

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_152_6 = arg_149_1.actors_["1097ui_story"]
			local var_152_7 = 0

			if var_152_7 < arg_149_1.time_ and arg_149_1.time_ <= var_152_7 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect1097ui_story == nil then
				arg_149_1.var_.characterEffect1097ui_story = var_152_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_8 = 0.200000002980232

			if var_152_7 <= arg_149_1.time_ and arg_149_1.time_ < var_152_7 + var_152_8 and not isNil(var_152_6) then
				local var_152_9 = (arg_149_1.time_ - var_152_7) / var_152_8

				if arg_149_1.var_.characterEffect1097ui_story and not isNil(var_152_6) then
					local var_152_10 = Mathf.Lerp(0, 0.5, var_152_9)

					arg_149_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1097ui_story.fillRatio = var_152_10
				end
			end

			if arg_149_1.time_ >= var_152_7 + var_152_8 and arg_149_1.time_ < var_152_7 + var_152_8 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect1097ui_story then
				local var_152_11 = 0.5

				arg_149_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1097ui_story.fillRatio = var_152_11
			end

			local var_152_12 = 0
			local var_152_13 = 0.3

			if var_152_12 < arg_149_1.time_ and arg_149_1.time_ <= var_152_12 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_14 = arg_149_1:FormatText(StoryNameCfg[56].name)

				arg_149_1.leftNameTxt_.text = var_152_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_15 = arg_149_1:GetWordFromCfg(1109704037)
				local var_152_16 = arg_149_1:FormatText(var_152_15.content)

				arg_149_1.text_.text = var_152_16

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_17 = 12
				local var_152_18 = utf8.len(var_152_16)
				local var_152_19 = var_152_17 <= 0 and var_152_13 or var_152_13 * (var_152_18 / var_152_17)

				if var_152_19 > 0 and var_152_13 < var_152_19 then
					arg_149_1.talkMaxDuration = var_152_19

					if var_152_19 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_19 + var_152_12
					end
				end

				arg_149_1.text_.text = var_152_16
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704037", "story_v_side_new_1109704.awb") ~= 0 then
					local var_152_20 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704037", "story_v_side_new_1109704.awb") / 1000

					if var_152_20 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_20 + var_152_12
					end

					if var_152_15.prefab_name ~= "" and arg_149_1.actors_[var_152_15.prefab_name] ~= nil then
						local var_152_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_15.prefab_name].transform, "story_v_side_new_1109704", "1109704037", "story_v_side_new_1109704.awb")

						arg_149_1:RecordAudio("1109704037", var_152_21)
						arg_149_1:RecordAudio("1109704037", var_152_21)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704037", "story_v_side_new_1109704.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704037", "story_v_side_new_1109704.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_22 = math.max(var_152_13, arg_149_1.talkMaxDuration)

			if var_152_12 <= arg_149_1.time_ and arg_149_1.time_ < var_152_12 + var_152_22 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_12) / var_152_22

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_12 + var_152_22 and arg_149_1.time_ < var_152_12 + var_152_22 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1109704038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1109704038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1109704039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1027ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1027ui_story = var_156_0.localPosition
			end

			local var_156_2 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2
				local var_156_4 = Vector3.New(0, 100, 0)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1027ui_story, var_156_4, var_156_3)

				local var_156_5 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_5.x, var_156_5.y, var_156_5.z)

				local var_156_6 = var_156_0.localEulerAngles

				var_156_6.z = 0
				var_156_6.x = 0
				var_156_0.localEulerAngles = var_156_6
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0, 100, 0)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_0.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_0.localEulerAngles = var_156_8
			end

			local var_156_9 = arg_153_1.actors_["1027ui_story"]
			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1027ui_story == nil then
				arg_153_1.var_.characterEffect1027ui_story = var_156_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_11 = 0.200000002980232

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_11 and not isNil(var_156_9) then
				local var_156_12 = (arg_153_1.time_ - var_156_10) / var_156_11

				if arg_153_1.var_.characterEffect1027ui_story and not isNil(var_156_9) then
					local var_156_13 = Mathf.Lerp(0, 0.5, var_156_12)

					arg_153_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1027ui_story.fillRatio = var_156_13
				end
			end

			if arg_153_1.time_ >= var_156_10 + var_156_11 and arg_153_1.time_ < var_156_10 + var_156_11 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1027ui_story then
				local var_156_14 = 0.5

				arg_153_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1027ui_story.fillRatio = var_156_14
			end

			local var_156_15 = arg_153_1.actors_["1097ui_story"].transform
			local var_156_16 = 0

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.var_.moveOldPos1097ui_story = var_156_15.localPosition
			end

			local var_156_17 = 0.001

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_17 then
				local var_156_18 = (arg_153_1.time_ - var_156_16) / var_156_17
				local var_156_19 = Vector3.New(0, 100, 0)

				var_156_15.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1097ui_story, var_156_19, var_156_18)

				local var_156_20 = manager.ui.mainCamera.transform.position - var_156_15.position

				var_156_15.forward = Vector3.New(var_156_20.x, var_156_20.y, var_156_20.z)

				local var_156_21 = var_156_15.localEulerAngles

				var_156_21.z = 0
				var_156_21.x = 0
				var_156_15.localEulerAngles = var_156_21
			end

			if arg_153_1.time_ >= var_156_16 + var_156_17 and arg_153_1.time_ < var_156_16 + var_156_17 + arg_156_0 then
				var_156_15.localPosition = Vector3.New(0, 100, 0)

				local var_156_22 = manager.ui.mainCamera.transform.position - var_156_15.position

				var_156_15.forward = Vector3.New(var_156_22.x, var_156_22.y, var_156_22.z)

				local var_156_23 = var_156_15.localEulerAngles

				var_156_23.z = 0
				var_156_23.x = 0
				var_156_15.localEulerAngles = var_156_23
			end

			local var_156_24 = arg_153_1.actors_["1097ui_story"]
			local var_156_25 = 0

			if var_156_25 < arg_153_1.time_ and arg_153_1.time_ <= var_156_25 + arg_156_0 and not isNil(var_156_24) and arg_153_1.var_.characterEffect1097ui_story == nil then
				arg_153_1.var_.characterEffect1097ui_story = var_156_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_26 = 0.200000002980232

			if var_156_25 <= arg_153_1.time_ and arg_153_1.time_ < var_156_25 + var_156_26 and not isNil(var_156_24) then
				local var_156_27 = (arg_153_1.time_ - var_156_25) / var_156_26

				if arg_153_1.var_.characterEffect1097ui_story and not isNil(var_156_24) then
					local var_156_28 = Mathf.Lerp(0, 0.5, var_156_27)

					arg_153_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1097ui_story.fillRatio = var_156_28
				end
			end

			if arg_153_1.time_ >= var_156_25 + var_156_26 and arg_153_1.time_ < var_156_25 + var_156_26 + arg_156_0 and not isNil(var_156_24) and arg_153_1.var_.characterEffect1097ui_story then
				local var_156_29 = 0.5

				arg_153_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1097ui_story.fillRatio = var_156_29
			end

			local var_156_30 = 0
			local var_156_31 = 0.9

			if var_156_30 < arg_153_1.time_ and arg_153_1.time_ <= var_156_30 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_32 = arg_153_1:GetWordFromCfg(1109704038)
				local var_156_33 = arg_153_1:FormatText(var_156_32.content)

				arg_153_1.text_.text = var_156_33

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_34 = 29
				local var_156_35 = utf8.len(var_156_33)
				local var_156_36 = var_156_34 <= 0 and var_156_31 or var_156_31 * (var_156_35 / var_156_34)

				if var_156_36 > 0 and var_156_31 < var_156_36 then
					arg_153_1.talkMaxDuration = var_156_36

					if var_156_36 + var_156_30 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_36 + var_156_30
					end
				end

				arg_153_1.text_.text = var_156_33
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_37 = math.max(var_156_31, arg_153_1.talkMaxDuration)

			if var_156_30 <= arg_153_1.time_ and arg_153_1.time_ < var_156_30 + var_156_37 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_30) / var_156_37

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_30 + var_156_37 and arg_153_1.time_ < var_156_30 + var_156_37 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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

		arg_153_1:InitPlayNodeList()
	end,
	Play1109704039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1109704039
		arg_157_1.duration_ = 7.6

		local var_157_0 = {
			zh = 7.6,
			ja = 7.1
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1109704040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1097ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1097ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(0, -0.54, -6.3)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1097ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["1097ui_story"]
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1097ui_story == nil then
				arg_157_1.var_.characterEffect1097ui_story = var_160_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_11 = 0.200000002980232

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 and not isNil(var_160_9) then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11

				if arg_157_1.var_.characterEffect1097ui_story and not isNil(var_160_9) then
					arg_157_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1097ui_story then
				arg_157_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_160_13 = 0

			if var_160_13 < arg_157_1.time_ and arg_157_1.time_ <= var_160_13 + arg_160_0 then
				arg_157_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_160_14 = 0

			if var_160_14 < arg_157_1.time_ and arg_157_1.time_ <= var_160_14 + arg_160_0 then
				arg_157_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_160_15 = 0
			local var_160_16 = 0.95

			if var_160_15 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_17 = arg_157_1:FormatText(StoryNameCfg[216].name)

				arg_157_1.leftNameTxt_.text = var_160_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_18 = arg_157_1:GetWordFromCfg(1109704039)
				local var_160_19 = arg_157_1:FormatText(var_160_18.content)

				arg_157_1.text_.text = var_160_19

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_20 = 38
				local var_160_21 = utf8.len(var_160_19)
				local var_160_22 = var_160_20 <= 0 and var_160_16 or var_160_16 * (var_160_21 / var_160_20)

				if var_160_22 > 0 and var_160_16 < var_160_22 then
					arg_157_1.talkMaxDuration = var_160_22

					if var_160_22 + var_160_15 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_22 + var_160_15
					end
				end

				arg_157_1.text_.text = var_160_19
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704039", "story_v_side_new_1109704.awb") ~= 0 then
					local var_160_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704039", "story_v_side_new_1109704.awb") / 1000

					if var_160_23 + var_160_15 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_23 + var_160_15
					end

					if var_160_18.prefab_name ~= "" and arg_157_1.actors_[var_160_18.prefab_name] ~= nil then
						local var_160_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_18.prefab_name].transform, "story_v_side_new_1109704", "1109704039", "story_v_side_new_1109704.awb")

						arg_157_1:RecordAudio("1109704039", var_160_24)
						arg_157_1:RecordAudio("1109704039", var_160_24)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704039", "story_v_side_new_1109704.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704039", "story_v_side_new_1109704.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_25 = math.max(var_160_16, arg_157_1.talkMaxDuration)

			if var_160_15 <= arg_157_1.time_ and arg_157_1.time_ < var_160_15 + var_160_25 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_15) / var_160_25

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_15 + var_160_25 and arg_157_1.time_ < var_160_15 + var_160_25 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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

		arg_157_1:InitPlayNodeList()
	end,
	Play1109704040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1109704040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1109704041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1097ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1097ui_story == nil then
				arg_161_1.var_.characterEffect1097ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1097ui_story and not isNil(var_164_0) then
					local var_164_4 = Mathf.Lerp(0, 0.5, var_164_3)

					arg_161_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1097ui_story.fillRatio = var_164_4
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1097ui_story then
				local var_164_5 = 0.5

				arg_161_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1097ui_story.fillRatio = var_164_5
			end

			local var_164_6 = 0
			local var_164_7 = 0.225

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_8 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_9 = arg_161_1:GetWordFromCfg(1109704040)
				local var_164_10 = arg_161_1:FormatText(var_164_9.content)

				arg_161_1.text_.text = var_164_10

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 9
				local var_164_12 = utf8.len(var_164_10)
				local var_164_13 = var_164_11 <= 0 and var_164_7 or var_164_7 * (var_164_12 / var_164_11)

				if var_164_13 > 0 and var_164_7 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_10
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_14 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_14 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_14

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_14 and arg_161_1.time_ < var_164_6 + var_164_14 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play1109704041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1109704041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1109704042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 1.025

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_2 = arg_165_1:GetWordFromCfg(1109704041)
				local var_168_3 = arg_165_1:FormatText(var_168_2.content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 41
				local var_168_5 = utf8.len(var_168_3)
				local var_168_6 = var_168_4 <= 0 and var_168_1 or var_168_1 * (var_168_5 / var_168_4)

				if var_168_6 > 0 and var_168_1 < var_168_6 then
					arg_165_1.talkMaxDuration = var_168_6

					if var_168_6 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_6 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_7 and arg_165_1.time_ < var_168_0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play1109704042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1109704042
		arg_169_1.duration_ = 3.7

		local var_169_0 = {
			zh = 3.7,
			ja = 3.533
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1109704043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1097ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1097ui_story == nil then
				arg_169_1.var_.characterEffect1097ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect1097ui_story and not isNil(var_172_0) then
					arg_169_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1097ui_story then
				arg_169_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_172_4 = 0

			if var_172_4 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_172_5 = 0

			if var_172_5 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_6 = 0
			local var_172_7 = 0.65

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_8 = arg_169_1:FormatText(StoryNameCfg[216].name)

				arg_169_1.leftNameTxt_.text = var_172_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_9 = arg_169_1:GetWordFromCfg(1109704042)
				local var_172_10 = arg_169_1:FormatText(var_172_9.content)

				arg_169_1.text_.text = var_172_10

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 26
				local var_172_12 = utf8.len(var_172_10)
				local var_172_13 = var_172_11 <= 0 and var_172_7 or var_172_7 * (var_172_12 / var_172_11)

				if var_172_13 > 0 and var_172_7 < var_172_13 then
					arg_169_1.talkMaxDuration = var_172_13

					if var_172_13 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_10
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704042", "story_v_side_new_1109704.awb") ~= 0 then
					local var_172_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704042", "story_v_side_new_1109704.awb") / 1000

					if var_172_14 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_14 + var_172_6
					end

					if var_172_9.prefab_name ~= "" and arg_169_1.actors_[var_172_9.prefab_name] ~= nil then
						local var_172_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_9.prefab_name].transform, "story_v_side_new_1109704", "1109704042", "story_v_side_new_1109704.awb")

						arg_169_1:RecordAudio("1109704042", var_172_15)
						arg_169_1:RecordAudio("1109704042", var_172_15)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704042", "story_v_side_new_1109704.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704042", "story_v_side_new_1109704.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_16 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_16 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_16

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_16 and arg_169_1.time_ < var_172_6 + var_172_16 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1109704043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1109704043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1109704044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1097ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1097ui_story == nil then
				arg_173_1.var_.characterEffect1097ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1097ui_story and not isNil(var_176_0) then
					local var_176_4 = Mathf.Lerp(0, 0.5, var_176_3)

					arg_173_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1097ui_story.fillRatio = var_176_4
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1097ui_story then
				local var_176_5 = 0.5

				arg_173_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1097ui_story.fillRatio = var_176_5
			end

			local var_176_6 = 0
			local var_176_7 = 0.4

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_8 = arg_173_1:FormatText(StoryNameCfg[7].name)

				arg_173_1.leftNameTxt_.text = var_176_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_9 = arg_173_1:GetWordFromCfg(1109704043)
				local var_176_10 = arg_173_1:FormatText(var_176_9.content)

				arg_173_1.text_.text = var_176_10

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 16
				local var_176_12 = utf8.len(var_176_10)
				local var_176_13 = var_176_11 <= 0 and var_176_7 or var_176_7 * (var_176_12 / var_176_11)

				if var_176_13 > 0 and var_176_7 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_10
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_14 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_14 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_14

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_14 and arg_173_1.time_ < var_176_6 + var_176_14 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1109704044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1109704044
		arg_177_1.duration_ = 5.13

		local var_177_0 = {
			zh = 4.433,
			ja = 5.133
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1109704045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1097ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1097ui_story == nil then
				arg_177_1.var_.characterEffect1097ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1097ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1097ui_story then
				arg_177_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_180_4 = 0

			if var_180_4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_180_5 = 0

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_180_6 = 0
			local var_180_7 = 0.475

			if var_180_6 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_8 = arg_177_1:FormatText(StoryNameCfg[216].name)

				arg_177_1.leftNameTxt_.text = var_180_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_9 = arg_177_1:GetWordFromCfg(1109704044)
				local var_180_10 = arg_177_1:FormatText(var_180_9.content)

				arg_177_1.text_.text = var_180_10

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 19
				local var_180_12 = utf8.len(var_180_10)
				local var_180_13 = var_180_11 <= 0 and var_180_7 or var_180_7 * (var_180_12 / var_180_11)

				if var_180_13 > 0 and var_180_7 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_10
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704044", "story_v_side_new_1109704.awb") ~= 0 then
					local var_180_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704044", "story_v_side_new_1109704.awb") / 1000

					if var_180_14 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_6
					end

					if var_180_9.prefab_name ~= "" and arg_177_1.actors_[var_180_9.prefab_name] ~= nil then
						local var_180_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_9.prefab_name].transform, "story_v_side_new_1109704", "1109704044", "story_v_side_new_1109704.awb")

						arg_177_1:RecordAudio("1109704044", var_180_15)
						arg_177_1:RecordAudio("1109704044", var_180_15)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704044", "story_v_side_new_1109704.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704044", "story_v_side_new_1109704.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_16 and arg_177_1.time_ < var_180_6 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1109704045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1109704045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1109704046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1097ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1097ui_story == nil then
				arg_181_1.var_.characterEffect1097ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1097ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1097ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1097ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1097ui_story.fillRatio = var_184_5
			end

			local var_184_6 = 0
			local var_184_7 = 1.05

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_8 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_9 = arg_181_1:GetWordFromCfg(1109704045)
				local var_184_10 = arg_181_1:FormatText(var_184_9.content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 42
				local var_184_12 = utf8.len(var_184_10)
				local var_184_13 = var_184_11 <= 0 and var_184_7 or var_184_7 * (var_184_12 / var_184_11)

				if var_184_13 > 0 and var_184_7 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play1109704046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1109704046
		arg_185_1.duration_ = 9.97

		local var_185_0 = {
			zh = 2.766,
			ja = 9.966
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1109704047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1097ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1097ui_story == nil then
				arg_185_1.var_.characterEffect1097ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1097ui_story and not isNil(var_188_0) then
					arg_185_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1097ui_story then
				arg_185_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_188_4 = 0

			if var_188_4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_188_5 = 0

			if var_188_5 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_188_6 = 0
			local var_188_7 = 0.3

			if var_188_6 < arg_185_1.time_ and arg_185_1.time_ <= var_188_6 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_8 = arg_185_1:FormatText(StoryNameCfg[216].name)

				arg_185_1.leftNameTxt_.text = var_188_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_9 = arg_185_1:GetWordFromCfg(1109704046)
				local var_188_10 = arg_185_1:FormatText(var_188_9.content)

				arg_185_1.text_.text = var_188_10

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_11 = 12
				local var_188_12 = utf8.len(var_188_10)
				local var_188_13 = var_188_11 <= 0 and var_188_7 or var_188_7 * (var_188_12 / var_188_11)

				if var_188_13 > 0 and var_188_7 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_6
					end
				end

				arg_185_1.text_.text = var_188_10
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704046", "story_v_side_new_1109704.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704046", "story_v_side_new_1109704.awb") / 1000

					if var_188_14 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_6
					end

					if var_188_9.prefab_name ~= "" and arg_185_1.actors_[var_188_9.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_9.prefab_name].transform, "story_v_side_new_1109704", "1109704046", "story_v_side_new_1109704.awb")

						arg_185_1:RecordAudio("1109704046", var_188_15)
						arg_185_1:RecordAudio("1109704046", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704046", "story_v_side_new_1109704.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704046", "story_v_side_new_1109704.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_7, arg_185_1.talkMaxDuration)

			if var_188_6 <= arg_185_1.time_ and arg_185_1.time_ < var_188_6 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_6) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_6 + var_188_16 and arg_185_1.time_ < var_188_6 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1109704047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1109704047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1109704048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1097ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1097ui_story == nil then
				arg_189_1.var_.characterEffect1097ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect1097ui_story and not isNil(var_192_0) then
					local var_192_4 = Mathf.Lerp(0, 0.5, var_192_3)

					arg_189_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1097ui_story.fillRatio = var_192_4
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1097ui_story then
				local var_192_5 = 0.5

				arg_189_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1097ui_story.fillRatio = var_192_5
			end

			local var_192_6 = 0
			local var_192_7 = 0.9

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_8 = arg_189_1:GetWordFromCfg(1109704047)
				local var_192_9 = arg_189_1:FormatText(var_192_8.content)

				arg_189_1.text_.text = var_192_9

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 36
				local var_192_11 = utf8.len(var_192_9)
				local var_192_12 = var_192_10 <= 0 and var_192_7 or var_192_7 * (var_192_11 / var_192_10)

				if var_192_12 > 0 and var_192_7 < var_192_12 then
					arg_189_1.talkMaxDuration = var_192_12

					if var_192_12 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_12 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_9
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_13 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_13 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_13

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_13 and arg_189_1.time_ < var_192_6 + var_192_13 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1109704048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1109704048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1109704049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.725

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[7].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_3 = arg_193_1:GetWordFromCfg(1109704048)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 29
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_8 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_8 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_8

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_8 and arg_193_1.time_ < var_196_0 + var_196_8 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1109704049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1109704049
		arg_197_1.duration_ = 4.03

		local var_197_0 = {
			zh = 4.033,
			ja = 4
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1109704050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1097ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos1097ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0, -0.54, -6.3)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1097ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["1097ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1097ui_story == nil then
				arg_197_1.var_.characterEffect1097ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect1097ui_story and not isNil(var_200_9) then
					arg_197_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1097ui_story then
				arg_197_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_200_13 = 0

			if var_200_13 < arg_197_1.time_ and arg_197_1.time_ <= var_200_13 + arg_200_0 then
				arg_197_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			local var_200_14 = 0

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				arg_197_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_200_15 = 0
			local var_200_16 = 0.3

			if var_200_15 < arg_197_1.time_ and arg_197_1.time_ <= var_200_15 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_17 = arg_197_1:FormatText(StoryNameCfg[216].name)

				arg_197_1.leftNameTxt_.text = var_200_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_18 = arg_197_1:GetWordFromCfg(1109704049)
				local var_200_19 = arg_197_1:FormatText(var_200_18.content)

				arg_197_1.text_.text = var_200_19

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_20 = 12
				local var_200_21 = utf8.len(var_200_19)
				local var_200_22 = var_200_20 <= 0 and var_200_16 or var_200_16 * (var_200_21 / var_200_20)

				if var_200_22 > 0 and var_200_16 < var_200_22 then
					arg_197_1.talkMaxDuration = var_200_22

					if var_200_22 + var_200_15 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_22 + var_200_15
					end
				end

				arg_197_1.text_.text = var_200_19
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704049", "story_v_side_new_1109704.awb") ~= 0 then
					local var_200_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704049", "story_v_side_new_1109704.awb") / 1000

					if var_200_23 + var_200_15 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_23 + var_200_15
					end

					if var_200_18.prefab_name ~= "" and arg_197_1.actors_[var_200_18.prefab_name] ~= nil then
						local var_200_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_18.prefab_name].transform, "story_v_side_new_1109704", "1109704049", "story_v_side_new_1109704.awb")

						arg_197_1:RecordAudio("1109704049", var_200_24)
						arg_197_1:RecordAudio("1109704049", var_200_24)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704049", "story_v_side_new_1109704.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704049", "story_v_side_new_1109704.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_25 = math.max(var_200_16, arg_197_1.talkMaxDuration)

			if var_200_15 <= arg_197_1.time_ and arg_197_1.time_ < var_200_15 + var_200_25 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_15) / var_200_25

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_15 + var_200_25 and arg_197_1.time_ < var_200_15 + var_200_25 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
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

		arg_197_1:InitPlayNodeList()
	end,
	Play1109704050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1109704050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1109704051(arg_201_1)
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
					local var_204_4 = Mathf.Lerp(0, 0.5, var_204_3)

					arg_201_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1097ui_story.fillRatio = var_204_4
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1097ui_story then
				local var_204_5 = 0.5

				arg_201_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1097ui_story.fillRatio = var_204_5
			end

			local var_204_6 = 0
			local var_204_7 = 0.625

			if var_204_6 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_8 = arg_201_1:GetWordFromCfg(1109704050)
				local var_204_9 = arg_201_1:FormatText(var_204_8.content)

				arg_201_1.text_.text = var_204_9

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_10 = 25
				local var_204_11 = utf8.len(var_204_9)
				local var_204_12 = var_204_10 <= 0 and var_204_7 or var_204_7 * (var_204_11 / var_204_10)

				if var_204_12 > 0 and var_204_7 < var_204_12 then
					arg_201_1.talkMaxDuration = var_204_12

					if var_204_12 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_12 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_9
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_13 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_13 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_13

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_13 and arg_201_1.time_ < var_204_6 + var_204_13 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1109704051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1109704051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1109704052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.55

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_2 = arg_205_1:GetWordFromCfg(1109704051)
				local var_208_3 = arg_205_1:FormatText(var_208_2.content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 22
				local var_208_5 = utf8.len(var_208_3)
				local var_208_6 = var_208_4 <= 0 and var_208_1 or var_208_1 * (var_208_5 / var_208_4)

				if var_208_6 > 0 and var_208_1 < var_208_6 then
					arg_205_1.talkMaxDuration = var_208_6

					if var_208_6 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_7 and arg_205_1.time_ < var_208_0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play1109704052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1109704052
		arg_209_1.duration_ = 7.13

		local var_209_0 = {
			zh = 2.933,
			ja = 7.133
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1109704053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1097ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1097ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1097ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = arg_209_1.actors_["1027ui_story"].transform
			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 then
				arg_209_1.var_.moveOldPos1027ui_story = var_212_9.localPosition
			end

			local var_212_11 = 0.001

			if var_212_10 <= arg_209_1.time_ and arg_209_1.time_ < var_212_10 + var_212_11 then
				local var_212_12 = (arg_209_1.time_ - var_212_10) / var_212_11
				local var_212_13 = Vector3.New(0.7, -0.81, -5.8)

				var_212_9.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1027ui_story, var_212_13, var_212_12)

				local var_212_14 = manager.ui.mainCamera.transform.position - var_212_9.position

				var_212_9.forward = Vector3.New(var_212_14.x, var_212_14.y, var_212_14.z)

				local var_212_15 = var_212_9.localEulerAngles

				var_212_15.z = 0
				var_212_15.x = 0
				var_212_9.localEulerAngles = var_212_15
			end

			if arg_209_1.time_ >= var_212_10 + var_212_11 and arg_209_1.time_ < var_212_10 + var_212_11 + arg_212_0 then
				var_212_9.localPosition = Vector3.New(0.7, -0.81, -5.8)

				local var_212_16 = manager.ui.mainCamera.transform.position - var_212_9.position

				var_212_9.forward = Vector3.New(var_212_16.x, var_212_16.y, var_212_16.z)

				local var_212_17 = var_212_9.localEulerAngles

				var_212_17.z = 0
				var_212_17.x = 0
				var_212_9.localEulerAngles = var_212_17
			end

			local var_212_18 = arg_209_1.actors_["1027ui_story"]
			local var_212_19 = 0

			if var_212_19 < arg_209_1.time_ and arg_209_1.time_ <= var_212_19 + arg_212_0 and not isNil(var_212_18) and arg_209_1.var_.characterEffect1027ui_story == nil then
				arg_209_1.var_.characterEffect1027ui_story = var_212_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_20 = 0.200000002980232

			if var_212_19 <= arg_209_1.time_ and arg_209_1.time_ < var_212_19 + var_212_20 and not isNil(var_212_18) then
				local var_212_21 = (arg_209_1.time_ - var_212_19) / var_212_20

				if arg_209_1.var_.characterEffect1027ui_story and not isNil(var_212_18) then
					arg_209_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_19 + var_212_20 and arg_209_1.time_ < var_212_19 + var_212_20 + arg_212_0 and not isNil(var_212_18) and arg_209_1.var_.characterEffect1027ui_story then
				arg_209_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_212_22 = 0

			if var_212_22 < arg_209_1.time_ and arg_209_1.time_ <= var_212_22 + arg_212_0 then
				arg_209_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			local var_212_23 = 0

			if var_212_23 < arg_209_1.time_ and arg_209_1.time_ <= var_212_23 + arg_212_0 then
				arg_209_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_212_24 = 0
			local var_212_25 = 0.375

			if var_212_24 < arg_209_1.time_ and arg_209_1.time_ <= var_212_24 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_26 = arg_209_1:FormatText(StoryNameCfg[56].name)

				arg_209_1.leftNameTxt_.text = var_212_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_27 = arg_209_1:GetWordFromCfg(1109704052)
				local var_212_28 = arg_209_1:FormatText(var_212_27.content)

				arg_209_1.text_.text = var_212_28

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_29 = 15
				local var_212_30 = utf8.len(var_212_28)
				local var_212_31 = var_212_29 <= 0 and var_212_25 or var_212_25 * (var_212_30 / var_212_29)

				if var_212_31 > 0 and var_212_25 < var_212_31 then
					arg_209_1.talkMaxDuration = var_212_31

					if var_212_31 + var_212_24 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_31 + var_212_24
					end
				end

				arg_209_1.text_.text = var_212_28
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704052", "story_v_side_new_1109704.awb") ~= 0 then
					local var_212_32 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704052", "story_v_side_new_1109704.awb") / 1000

					if var_212_32 + var_212_24 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_32 + var_212_24
					end

					if var_212_27.prefab_name ~= "" and arg_209_1.actors_[var_212_27.prefab_name] ~= nil then
						local var_212_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_27.prefab_name].transform, "story_v_side_new_1109704", "1109704052", "story_v_side_new_1109704.awb")

						arg_209_1:RecordAudio("1109704052", var_212_33)
						arg_209_1:RecordAudio("1109704052", var_212_33)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704052", "story_v_side_new_1109704.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704052", "story_v_side_new_1109704.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_34 = math.max(var_212_25, arg_209_1.talkMaxDuration)

			if var_212_24 <= arg_209_1.time_ and arg_209_1.time_ < var_212_24 + var_212_34 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_24) / var_212_34

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_24 + var_212_34 and arg_209_1.time_ < var_212_24 + var_212_34 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play1109704053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1109704053
		arg_213_1.duration_ = 6.2

		local var_213_0 = {
			zh = 3.7,
			ja = 6.2
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
				arg_213_0:Play1109704054(arg_213_1)
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
				arg_213_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_216_5 = 0

			if var_216_5 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_216_6 = arg_213_1.actors_["1027ui_story"]
			local var_216_7 = 0

			if var_216_7 < arg_213_1.time_ and arg_213_1.time_ <= var_216_7 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1027ui_story == nil then
				arg_213_1.var_.characterEffect1027ui_story = var_216_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_8 = 0.200000002980232

			if var_216_7 <= arg_213_1.time_ and arg_213_1.time_ < var_216_7 + var_216_8 and not isNil(var_216_6) then
				local var_216_9 = (arg_213_1.time_ - var_216_7) / var_216_8

				if arg_213_1.var_.characterEffect1027ui_story and not isNil(var_216_6) then
					local var_216_10 = Mathf.Lerp(0, 0.5, var_216_9)

					arg_213_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1027ui_story.fillRatio = var_216_10
				end
			end

			if arg_213_1.time_ >= var_216_7 + var_216_8 and arg_213_1.time_ < var_216_7 + var_216_8 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1027ui_story then
				local var_216_11 = 0.5

				arg_213_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1027ui_story.fillRatio = var_216_11
			end

			local var_216_12 = 0
			local var_216_13 = 0.425

			if var_216_12 < arg_213_1.time_ and arg_213_1.time_ <= var_216_12 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_14 = arg_213_1:FormatText(StoryNameCfg[216].name)

				arg_213_1.leftNameTxt_.text = var_216_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_15 = arg_213_1:GetWordFromCfg(1109704053)
				local var_216_16 = arg_213_1:FormatText(var_216_15.content)

				arg_213_1.text_.text = var_216_16

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_17 = 17
				local var_216_18 = utf8.len(var_216_16)
				local var_216_19 = var_216_17 <= 0 and var_216_13 or var_216_13 * (var_216_18 / var_216_17)

				if var_216_19 > 0 and var_216_13 < var_216_19 then
					arg_213_1.talkMaxDuration = var_216_19

					if var_216_19 + var_216_12 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_19 + var_216_12
					end
				end

				arg_213_1.text_.text = var_216_16
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704053", "story_v_side_new_1109704.awb") ~= 0 then
					local var_216_20 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704053", "story_v_side_new_1109704.awb") / 1000

					if var_216_20 + var_216_12 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_20 + var_216_12
					end

					if var_216_15.prefab_name ~= "" and arg_213_1.actors_[var_216_15.prefab_name] ~= nil then
						local var_216_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_15.prefab_name].transform, "story_v_side_new_1109704", "1109704053", "story_v_side_new_1109704.awb")

						arg_213_1:RecordAudio("1109704053", var_216_21)
						arg_213_1:RecordAudio("1109704053", var_216_21)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704053", "story_v_side_new_1109704.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704053", "story_v_side_new_1109704.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_22 = math.max(var_216_13, arg_213_1.talkMaxDuration)

			if var_216_12 <= arg_213_1.time_ and arg_213_1.time_ < var_216_12 + var_216_22 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_12) / var_216_22

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_12 + var_216_22 and arg_213_1.time_ < var_216_12 + var_216_22 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1109704054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1109704054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1109704055(arg_217_1)
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
			local var_220_7 = 0.375

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

				local var_220_9 = arg_217_1:GetWordFromCfg(1109704054)
				local var_220_10 = arg_217_1:FormatText(var_220_9.content)

				arg_217_1.text_.text = var_220_10

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 15
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
	Play1109704055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1109704055
		arg_221_1.duration_ = 4.8

		local var_221_0 = {
			zh = 4.8,
			ja = 4.633
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
				arg_221_0:Play1109704056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1027ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1027ui_story == nil then
				arg_221_1.var_.characterEffect1027ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect1027ui_story and not isNil(var_224_0) then
					arg_221_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1027ui_story then
				arg_221_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_224_4 = 0

			if var_224_4 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_224_5 = 0

			if var_224_5 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_224_6 = 0
			local var_224_7 = 0.525

			if var_224_6 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_8 = arg_221_1:FormatText(StoryNameCfg[56].name)

				arg_221_1.leftNameTxt_.text = var_224_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_9 = arg_221_1:GetWordFromCfg(1109704055)
				local var_224_10 = arg_221_1:FormatText(var_224_9.content)

				arg_221_1.text_.text = var_224_10

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_11 = 21
				local var_224_12 = utf8.len(var_224_10)
				local var_224_13 = var_224_11 <= 0 and var_224_7 or var_224_7 * (var_224_12 / var_224_11)

				if var_224_13 > 0 and var_224_7 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_6
					end
				end

				arg_221_1.text_.text = var_224_10
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704055", "story_v_side_new_1109704.awb") ~= 0 then
					local var_224_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704055", "story_v_side_new_1109704.awb") / 1000

					if var_224_14 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_14 + var_224_6
					end

					if var_224_9.prefab_name ~= "" and arg_221_1.actors_[var_224_9.prefab_name] ~= nil then
						local var_224_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_9.prefab_name].transform, "story_v_side_new_1109704", "1109704055", "story_v_side_new_1109704.awb")

						arg_221_1:RecordAudio("1109704055", var_224_15)
						arg_221_1:RecordAudio("1109704055", var_224_15)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704055", "story_v_side_new_1109704.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704055", "story_v_side_new_1109704.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_7, arg_221_1.talkMaxDuration)

			if var_224_6 <= arg_221_1.time_ and arg_221_1.time_ < var_224_6 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_6) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_6 + var_224_16 and arg_221_1.time_ < var_224_6 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1109704056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1109704056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1109704057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1027ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1027ui_story == nil then
				arg_225_1.var_.characterEffect1027ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1027ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1027ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1027ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1027ui_story.fillRatio = var_228_5
			end

			local var_228_6 = 0
			local var_228_7 = 0.3

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_8 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_8

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

				local var_228_9 = arg_225_1:GetWordFromCfg(1109704056)
				local var_228_10 = arg_225_1:FormatText(var_228_9.content)

				arg_225_1.text_.text = var_228_10

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 12
				local var_228_12 = utf8.len(var_228_10)
				local var_228_13 = var_228_11 <= 0 and var_228_7 or var_228_7 * (var_228_12 / var_228_11)

				if var_228_13 > 0 and var_228_7 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_10
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1109704057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1109704057
		arg_229_1.duration_ = 2

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1109704058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1027ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1027ui_story == nil then
				arg_229_1.var_.characterEffect1027ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1027ui_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1027ui_story then
				arg_229_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_232_4 = 0

			if var_232_4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_2")
			end

			local var_232_5 = 0

			if var_232_5 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_232_6 = 0
			local var_232_7 = 0.1

			if var_232_6 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_8 = arg_229_1:FormatText(StoryNameCfg[56].name)

				arg_229_1.leftNameTxt_.text = var_232_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_9 = arg_229_1:GetWordFromCfg(1109704057)
				local var_232_10 = arg_229_1:FormatText(var_232_9.content)

				arg_229_1.text_.text = var_232_10

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_11 = 4
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704057", "story_v_side_new_1109704.awb") ~= 0 then
					local var_232_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704057", "story_v_side_new_1109704.awb") / 1000

					if var_232_14 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_14 + var_232_6
					end

					if var_232_9.prefab_name ~= "" and arg_229_1.actors_[var_232_9.prefab_name] ~= nil then
						local var_232_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_9.prefab_name].transform, "story_v_side_new_1109704", "1109704057", "story_v_side_new_1109704.awb")

						arg_229_1:RecordAudio("1109704057", var_232_15)
						arg_229_1:RecordAudio("1109704057", var_232_15)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704057", "story_v_side_new_1109704.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704057", "story_v_side_new_1109704.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_16 = math.max(var_232_7, arg_229_1.talkMaxDuration)

			if var_232_6 <= arg_229_1.time_ and arg_229_1.time_ < var_232_6 + var_232_16 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_6) / var_232_16

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_6 + var_232_16 and arg_229_1.time_ < var_232_6 + var_232_16 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1109704058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1109704058
		arg_233_1.duration_ = 6.93

		local var_233_0 = {
			zh = 5.7,
			ja = 6.933
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
				arg_233_0:Play1109704059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1097ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1097ui_story == nil then
				arg_233_1.var_.characterEffect1097ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1097ui_story and not isNil(var_236_0) then
					arg_233_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1097ui_story then
				arg_233_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_236_4 = 0

			if var_236_4 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_236_5 = 0

			if var_236_5 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_236_6 = arg_233_1.actors_["1027ui_story"]
			local var_236_7 = 0

			if var_236_7 < arg_233_1.time_ and arg_233_1.time_ <= var_236_7 + arg_236_0 and not isNil(var_236_6) and arg_233_1.var_.characterEffect1027ui_story == nil then
				arg_233_1.var_.characterEffect1027ui_story = var_236_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_8 = 0.200000002980232

			if var_236_7 <= arg_233_1.time_ and arg_233_1.time_ < var_236_7 + var_236_8 and not isNil(var_236_6) then
				local var_236_9 = (arg_233_1.time_ - var_236_7) / var_236_8

				if arg_233_1.var_.characterEffect1027ui_story and not isNil(var_236_6) then
					local var_236_10 = Mathf.Lerp(0, 0.5, var_236_9)

					arg_233_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1027ui_story.fillRatio = var_236_10
				end
			end

			if arg_233_1.time_ >= var_236_7 + var_236_8 and arg_233_1.time_ < var_236_7 + var_236_8 + arg_236_0 and not isNil(var_236_6) and arg_233_1.var_.characterEffect1027ui_story then
				local var_236_11 = 0.5

				arg_233_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1027ui_story.fillRatio = var_236_11
			end

			local var_236_12 = 0
			local var_236_13 = 0.775

			if var_236_12 < arg_233_1.time_ and arg_233_1.time_ <= var_236_12 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_14 = arg_233_1:FormatText(StoryNameCfg[216].name)

				arg_233_1.leftNameTxt_.text = var_236_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_15 = arg_233_1:GetWordFromCfg(1109704058)
				local var_236_16 = arg_233_1:FormatText(var_236_15.content)

				arg_233_1.text_.text = var_236_16

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_17 = 31
				local var_236_18 = utf8.len(var_236_16)
				local var_236_19 = var_236_17 <= 0 and var_236_13 or var_236_13 * (var_236_18 / var_236_17)

				if var_236_19 > 0 and var_236_13 < var_236_19 then
					arg_233_1.talkMaxDuration = var_236_19

					if var_236_19 + var_236_12 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_19 + var_236_12
					end
				end

				arg_233_1.text_.text = var_236_16
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704058", "story_v_side_new_1109704.awb") ~= 0 then
					local var_236_20 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704058", "story_v_side_new_1109704.awb") / 1000

					if var_236_20 + var_236_12 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_20 + var_236_12
					end

					if var_236_15.prefab_name ~= "" and arg_233_1.actors_[var_236_15.prefab_name] ~= nil then
						local var_236_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_15.prefab_name].transform, "story_v_side_new_1109704", "1109704058", "story_v_side_new_1109704.awb")

						arg_233_1:RecordAudio("1109704058", var_236_21)
						arg_233_1:RecordAudio("1109704058", var_236_21)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704058", "story_v_side_new_1109704.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704058", "story_v_side_new_1109704.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_22 = math.max(var_236_13, arg_233_1.talkMaxDuration)

			if var_236_12 <= arg_233_1.time_ and arg_233_1.time_ < var_236_12 + var_236_22 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_12) / var_236_22

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_12 + var_236_22 and arg_233_1.time_ < var_236_12 + var_236_22 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1109704059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1109704059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1109704060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1097ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1097ui_story == nil then
				arg_237_1.var_.characterEffect1097ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect1097ui_story and not isNil(var_240_0) then
					local var_240_4 = Mathf.Lerp(0, 0.5, var_240_3)

					arg_237_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1097ui_story.fillRatio = var_240_4
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1097ui_story then
				local var_240_5 = 0.5

				arg_237_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1097ui_story.fillRatio = var_240_5
			end

			local var_240_6 = 0
			local var_240_7 = 0.55

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_8 = arg_237_1:FormatText(StoryNameCfg[7].name)

				arg_237_1.leftNameTxt_.text = var_240_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_9 = arg_237_1:GetWordFromCfg(1109704059)
				local var_240_10 = arg_237_1:FormatText(var_240_9.content)

				arg_237_1.text_.text = var_240_10

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 22
				local var_240_12 = utf8.len(var_240_10)
				local var_240_13 = var_240_11 <= 0 and var_240_7 or var_240_7 * (var_240_12 / var_240_11)

				if var_240_13 > 0 and var_240_7 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_10
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_14 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_14 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_14

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_14 and arg_237_1.time_ < var_240_6 + var_240_14 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1109704060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1109704060
		arg_241_1.duration_ = 5.1

		local var_241_0 = {
			zh = 3.5,
			ja = 5.1
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
				arg_241_0:Play1109704061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1097ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1097ui_story == nil then
				arg_241_1.var_.characterEffect1097ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect1097ui_story and not isNil(var_244_0) then
					arg_241_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1097ui_story then
				arg_241_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_244_4 = 0

			if var_244_4 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_244_5 = 0

			if var_244_5 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_244_6 = 0
			local var_244_7 = 0.575

			if var_244_6 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_8 = arg_241_1:FormatText(StoryNameCfg[216].name)

				arg_241_1.leftNameTxt_.text = var_244_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_9 = arg_241_1:GetWordFromCfg(1109704060)
				local var_244_10 = arg_241_1:FormatText(var_244_9.content)

				arg_241_1.text_.text = var_244_10

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_11 = 23
				local var_244_12 = utf8.len(var_244_10)
				local var_244_13 = var_244_11 <= 0 and var_244_7 or var_244_7 * (var_244_12 / var_244_11)

				if var_244_13 > 0 and var_244_7 < var_244_13 then
					arg_241_1.talkMaxDuration = var_244_13

					if var_244_13 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_6
					end
				end

				arg_241_1.text_.text = var_244_10
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704060", "story_v_side_new_1109704.awb") ~= 0 then
					local var_244_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704060", "story_v_side_new_1109704.awb") / 1000

					if var_244_14 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_14 + var_244_6
					end

					if var_244_9.prefab_name ~= "" and arg_241_1.actors_[var_244_9.prefab_name] ~= nil then
						local var_244_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_9.prefab_name].transform, "story_v_side_new_1109704", "1109704060", "story_v_side_new_1109704.awb")

						arg_241_1:RecordAudio("1109704060", var_244_15)
						arg_241_1:RecordAudio("1109704060", var_244_15)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704060", "story_v_side_new_1109704.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704060", "story_v_side_new_1109704.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_16 = math.max(var_244_7, arg_241_1.talkMaxDuration)

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_16 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_6) / var_244_16

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_6 + var_244_16 and arg_241_1.time_ < var_244_6 + var_244_16 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1109704061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1109704061
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1109704062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1097ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1097ui_story == nil then
				arg_245_1.var_.characterEffect1097ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect1097ui_story and not isNil(var_248_0) then
					local var_248_4 = Mathf.Lerp(0, 0.5, var_248_3)

					arg_245_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1097ui_story.fillRatio = var_248_4
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1097ui_story then
				local var_248_5 = 0.5

				arg_245_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1097ui_story.fillRatio = var_248_5
			end

			local var_248_6 = 0
			local var_248_7 = 0.7

			if var_248_6 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_8 = arg_245_1:FormatText(StoryNameCfg[7].name)

				arg_245_1.leftNameTxt_.text = var_248_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_9 = arg_245_1:GetWordFromCfg(1109704061)
				local var_248_10 = arg_245_1:FormatText(var_248_9.content)

				arg_245_1.text_.text = var_248_10

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_11 = 28
				local var_248_12 = utf8.len(var_248_10)
				local var_248_13 = var_248_11 <= 0 and var_248_7 or var_248_7 * (var_248_12 / var_248_11)

				if var_248_13 > 0 and var_248_7 < var_248_13 then
					arg_245_1.talkMaxDuration = var_248_13

					if var_248_13 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_13 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_10
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_14 = math.max(var_248_7, arg_245_1.talkMaxDuration)

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_14 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_6) / var_248_14

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_6 + var_248_14 and arg_245_1.time_ < var_248_6 + var_248_14 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1109704062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1109704062
		arg_249_1.duration_ = 2.83

		local var_249_0 = {
			zh = 1.999999999999,
			ja = 2.833
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1109704063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1097ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1097ui_story == nil then
				arg_249_1.var_.characterEffect1097ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1097ui_story and not isNil(var_252_0) then
					arg_249_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1097ui_story then
				arg_249_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_252_4 = 0

			if var_252_4 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_252_5 = 0

			if var_252_5 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_252_6 = 0
			local var_252_7 = 0.1

			if var_252_6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_8 = arg_249_1:FormatText(StoryNameCfg[216].name)

				arg_249_1.leftNameTxt_.text = var_252_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_9 = arg_249_1:GetWordFromCfg(1109704062)
				local var_252_10 = arg_249_1:FormatText(var_252_9.content)

				arg_249_1.text_.text = var_252_10

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_11 = 4
				local var_252_12 = utf8.len(var_252_10)
				local var_252_13 = var_252_11 <= 0 and var_252_7 or var_252_7 * (var_252_12 / var_252_11)

				if var_252_13 > 0 and var_252_7 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_6
					end
				end

				arg_249_1.text_.text = var_252_10
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704062", "story_v_side_new_1109704.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704062", "story_v_side_new_1109704.awb") / 1000

					if var_252_14 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_6
					end

					if var_252_9.prefab_name ~= "" and arg_249_1.actors_[var_252_9.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_9.prefab_name].transform, "story_v_side_new_1109704", "1109704062", "story_v_side_new_1109704.awb")

						arg_249_1:RecordAudio("1109704062", var_252_15)
						arg_249_1:RecordAudio("1109704062", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704062", "story_v_side_new_1109704.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704062", "story_v_side_new_1109704.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_16 = math.max(var_252_7, arg_249_1.talkMaxDuration)

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_16 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_6) / var_252_16

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_6 + var_252_16 and arg_249_1.time_ < var_252_6 + var_252_16 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1109704063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1109704063
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1109704064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1097ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1097ui_story == nil then
				arg_253_1.var_.characterEffect1097ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect1097ui_story and not isNil(var_256_0) then
					local var_256_4 = Mathf.Lerp(0, 0.5, var_256_3)

					arg_253_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1097ui_story.fillRatio = var_256_4
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1097ui_story then
				local var_256_5 = 0.5

				arg_253_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1097ui_story.fillRatio = var_256_5
			end

			local var_256_6 = 0
			local var_256_7 = 0.95

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_8 = arg_253_1:GetWordFromCfg(1109704063)
				local var_256_9 = arg_253_1:FormatText(var_256_8.content)

				arg_253_1.text_.text = var_256_9

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_10 = 38
				local var_256_11 = utf8.len(var_256_9)
				local var_256_12 = var_256_10 <= 0 and var_256_7 or var_256_7 * (var_256_11 / var_256_10)

				if var_256_12 > 0 and var_256_7 < var_256_12 then
					arg_253_1.talkMaxDuration = var_256_12

					if var_256_12 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_12 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_9
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_13 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_13 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_13

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_13 and arg_253_1.time_ < var_256_6 + var_256_13 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1109704064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1109704064
		arg_257_1.duration_ = 7

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1109704065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = "STwhite"

			if arg_257_1.bgs_[var_260_0] == nil then
				local var_260_1 = Object.Instantiate(arg_257_1.paintGo_)

				var_260_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_260_0)
				var_260_1.name = var_260_0
				var_260_1.transform.parent = arg_257_1.stage_.transform
				var_260_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.bgs_[var_260_0] = var_260_1
			end

			local var_260_2 = 0

			if var_260_2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				local var_260_3 = manager.ui.mainCamera.transform.localPosition
				local var_260_4 = Vector3.New(0, 0, 10) + Vector3.New(var_260_3.x, var_260_3.y, 0)
				local var_260_5 = arg_257_1.bgs_.STwhite

				var_260_5.transform.localPosition = var_260_4
				var_260_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_260_6 = var_260_5:GetComponent("SpriteRenderer")

				if var_260_6 and var_260_6.sprite then
					local var_260_7 = (var_260_5.transform.localPosition - var_260_3).z
					local var_260_8 = manager.ui.mainCameraCom_
					local var_260_9 = 2 * var_260_7 * Mathf.Tan(var_260_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_260_10 = var_260_9 * var_260_8.aspect
					local var_260_11 = var_260_6.sprite.bounds.size.x
					local var_260_12 = var_260_6.sprite.bounds.size.y
					local var_260_13 = var_260_10 / var_260_11
					local var_260_14 = var_260_9 / var_260_12
					local var_260_15 = var_260_14 < var_260_13 and var_260_13 or var_260_14

					var_260_5.transform.localScale = Vector3.New(var_260_15, var_260_15, 0)
				end

				for iter_260_0, iter_260_1 in pairs(arg_257_1.bgs_) do
					if iter_260_0 ~= "STwhite" then
						iter_260_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_260_16 = 2

			if var_260_16 < arg_257_1.time_ and arg_257_1.time_ <= var_260_16 + arg_260_0 then
				arg_257_1.allBtn_.enabled = false
			end

			local var_260_17 = 0.3

			if arg_257_1.time_ >= var_260_16 + var_260_17 and arg_257_1.time_ < var_260_16 + var_260_17 + arg_260_0 then
				arg_257_1.allBtn_.enabled = true
			end

			local var_260_18 = 0

			if var_260_18 < arg_257_1.time_ and arg_257_1.time_ <= var_260_18 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_19 = 2

			if var_260_18 <= arg_257_1.time_ and arg_257_1.time_ < var_260_18 + var_260_19 then
				local var_260_20 = (arg_257_1.time_ - var_260_18) / var_260_19
				local var_260_21 = Color.New(1, 1, 1)

				var_260_21.a = Mathf.Lerp(1, 0, var_260_20)
				arg_257_1.mask_.color = var_260_21
			end

			if arg_257_1.time_ >= var_260_18 + var_260_19 and arg_257_1.time_ < var_260_18 + var_260_19 + arg_260_0 then
				local var_260_22 = Color.New(1, 1, 1)
				local var_260_23 = 0

				arg_257_1.mask_.enabled = false
				var_260_22.a = var_260_23
				arg_257_1.mask_.color = var_260_22
			end

			local var_260_24 = arg_257_1.actors_["1097ui_story"].transform
			local var_260_25 = 0

			if var_260_25 < arg_257_1.time_ and arg_257_1.time_ <= var_260_25 + arg_260_0 then
				arg_257_1.var_.moveOldPos1097ui_story = var_260_24.localPosition
			end

			local var_260_26 = 0.001

			if var_260_25 <= arg_257_1.time_ and arg_257_1.time_ < var_260_25 + var_260_26 then
				local var_260_27 = (arg_257_1.time_ - var_260_25) / var_260_26
				local var_260_28 = Vector3.New(0, 100, 0)

				var_260_24.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1097ui_story, var_260_28, var_260_27)

				local var_260_29 = manager.ui.mainCamera.transform.position - var_260_24.position

				var_260_24.forward = Vector3.New(var_260_29.x, var_260_29.y, var_260_29.z)

				local var_260_30 = var_260_24.localEulerAngles

				var_260_30.z = 0
				var_260_30.x = 0
				var_260_24.localEulerAngles = var_260_30
			end

			if arg_257_1.time_ >= var_260_25 + var_260_26 and arg_257_1.time_ < var_260_25 + var_260_26 + arg_260_0 then
				var_260_24.localPosition = Vector3.New(0, 100, 0)

				local var_260_31 = manager.ui.mainCamera.transform.position - var_260_24.position

				var_260_24.forward = Vector3.New(var_260_31.x, var_260_31.y, var_260_31.z)

				local var_260_32 = var_260_24.localEulerAngles

				var_260_32.z = 0
				var_260_32.x = 0
				var_260_24.localEulerAngles = var_260_32
			end

			local var_260_33 = arg_257_1.actors_["1097ui_story"]
			local var_260_34 = 0

			if var_260_34 < arg_257_1.time_ and arg_257_1.time_ <= var_260_34 + arg_260_0 and not isNil(var_260_33) and arg_257_1.var_.characterEffect1097ui_story == nil then
				arg_257_1.var_.characterEffect1097ui_story = var_260_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_35 = 0.034000001847744

			if var_260_34 <= arg_257_1.time_ and arg_257_1.time_ < var_260_34 + var_260_35 and not isNil(var_260_33) then
				local var_260_36 = (arg_257_1.time_ - var_260_34) / var_260_35

				if arg_257_1.var_.characterEffect1097ui_story and not isNil(var_260_33) then
					local var_260_37 = Mathf.Lerp(0, 0.5, var_260_36)

					arg_257_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1097ui_story.fillRatio = var_260_37
				end
			end

			if arg_257_1.time_ >= var_260_34 + var_260_35 and arg_257_1.time_ < var_260_34 + var_260_35 + arg_260_0 and not isNil(var_260_33) and arg_257_1.var_.characterEffect1097ui_story then
				local var_260_38 = 0.5

				arg_257_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1097ui_story.fillRatio = var_260_38
			end

			local var_260_39 = arg_257_1.actors_["1027ui_story"].transform
			local var_260_40 = 0

			if var_260_40 < arg_257_1.time_ and arg_257_1.time_ <= var_260_40 + arg_260_0 then
				arg_257_1.var_.moveOldPos1027ui_story = var_260_39.localPosition
			end

			local var_260_41 = 0.001

			if var_260_40 <= arg_257_1.time_ and arg_257_1.time_ < var_260_40 + var_260_41 then
				local var_260_42 = (arg_257_1.time_ - var_260_40) / var_260_41
				local var_260_43 = Vector3.New(0, 100, 0)

				var_260_39.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1027ui_story, var_260_43, var_260_42)

				local var_260_44 = manager.ui.mainCamera.transform.position - var_260_39.position

				var_260_39.forward = Vector3.New(var_260_44.x, var_260_44.y, var_260_44.z)

				local var_260_45 = var_260_39.localEulerAngles

				var_260_45.z = 0
				var_260_45.x = 0
				var_260_39.localEulerAngles = var_260_45
			end

			if arg_257_1.time_ >= var_260_40 + var_260_41 and arg_257_1.time_ < var_260_40 + var_260_41 + arg_260_0 then
				var_260_39.localPosition = Vector3.New(0, 100, 0)

				local var_260_46 = manager.ui.mainCamera.transform.position - var_260_39.position

				var_260_39.forward = Vector3.New(var_260_46.x, var_260_46.y, var_260_46.z)

				local var_260_47 = var_260_39.localEulerAngles

				var_260_47.z = 0
				var_260_47.x = 0
				var_260_39.localEulerAngles = var_260_47
			end

			if arg_257_1.frameCnt_ <= 1 then
				arg_257_1.dialog_:SetActive(false)
			end

			local var_260_48 = 2
			local var_260_49 = 0.875

			if var_260_48 < arg_257_1.time_ and arg_257_1.time_ <= var_260_48 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0

				arg_257_1.dialog_:SetActive(true)

				arg_257_1.dialogCg_.alpha = 0

				local var_260_50 = LeanTween.value(arg_257_1.dialog_, 0, 1, 0.3)

				var_260_50:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_257_1.dialogCg_.alpha = arg_261_0
				end))
				var_260_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_257_1.dialog_)
					var_260_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_257_1.duration_ = arg_257_1.duration_ + 0.3

				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_51 = arg_257_1:GetWordFromCfg(1109704064)
				local var_260_52 = arg_257_1:FormatText(var_260_51.content)

				arg_257_1.text_.text = var_260_52

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_53 = 35
				local var_260_54 = utf8.len(var_260_52)
				local var_260_55 = var_260_53 <= 0 and var_260_49 or var_260_49 * (var_260_54 / var_260_53)

				if var_260_55 > 0 and var_260_49 < var_260_55 then
					arg_257_1.talkMaxDuration = var_260_55
					var_260_48 = var_260_48 + 0.3

					if var_260_55 + var_260_48 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_55 + var_260_48
					end
				end

				arg_257_1.text_.text = var_260_52
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_56 = var_260_48 + 0.3
			local var_260_57 = math.max(var_260_49, arg_257_1.talkMaxDuration)

			if var_260_56 <= arg_257_1.time_ and arg_257_1.time_ < var_260_56 + var_260_57 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_56) / var_260_57

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_56 + var_260_57 and arg_257_1.time_ < var_260_56 + var_260_57 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play1109704065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1109704065
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1109704066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 1.35

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_2 = arg_263_1:GetWordFromCfg(1109704065)
				local var_266_3 = arg_263_1:FormatText(var_266_2.content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 54
				local var_266_5 = utf8.len(var_266_3)
				local var_266_6 = var_266_4 <= 0 and var_266_1 or var_266_1 * (var_266_5 / var_266_4)

				if var_266_6 > 0 and var_266_1 < var_266_6 then
					arg_263_1.talkMaxDuration = var_266_6

					if var_266_6 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_0
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_1, arg_263_1.talkMaxDuration)

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_0) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_0 + var_266_7 and arg_263_1.time_ < var_266_0 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play1109704066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1109704066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1109704067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 1.175

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_2 = arg_267_1:GetWordFromCfg(1109704066)
				local var_270_3 = arg_267_1:FormatText(var_270_2.content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 47
				local var_270_5 = utf8.len(var_270_3)
				local var_270_6 = var_270_4 <= 0 and var_270_1 or var_270_1 * (var_270_5 / var_270_4)

				if var_270_6 > 0 and var_270_1 < var_270_6 then
					arg_267_1.talkMaxDuration = var_270_6

					if var_270_6 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_6 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_7 and arg_267_1.time_ < var_270_0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1109704067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1109704067
		arg_271_1.duration_ = 8.4

		local var_271_0 = {
			zh = 6.133,
			ja = 8.4
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
				arg_271_0:Play1109704068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 0.6

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_2 = arg_271_1:FormatText(StoryNameCfg[56].name)

				arg_271_1.leftNameTxt_.text = var_274_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_3 = arg_271_1:GetWordFromCfg(1109704067)
				local var_274_4 = arg_271_1:FormatText(var_274_3.content)

				arg_271_1.text_.text = var_274_4

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704067", "story_v_side_new_1109704.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704067", "story_v_side_new_1109704.awb") / 1000

					if var_274_8 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_0
					end

					if var_274_3.prefab_name ~= "" and arg_271_1.actors_[var_274_3.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_3.prefab_name].transform, "story_v_side_new_1109704", "1109704067", "story_v_side_new_1109704.awb")

						arg_271_1:RecordAudio("1109704067", var_274_9)
						arg_271_1:RecordAudio("1109704067", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704067", "story_v_side_new_1109704.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704067", "story_v_side_new_1109704.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_10 and arg_271_1.time_ < var_274_0 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1109704068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1109704068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1109704069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0
			local var_278_1 = 1.175

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_2 = arg_275_1:GetWordFromCfg(1109704068)
				local var_278_3 = arg_275_1:FormatText(var_278_2.content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 47
				local var_278_5 = utf8.len(var_278_3)
				local var_278_6 = var_278_4 <= 0 and var_278_1 or var_278_1 * (var_278_5 / var_278_4)

				if var_278_6 > 0 and var_278_1 < var_278_6 then
					arg_275_1.talkMaxDuration = var_278_6

					if var_278_6 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_6 + var_278_0
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_1, arg_275_1.talkMaxDuration)

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_0 + var_278_7 and arg_275_1.time_ < var_278_0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1109704069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1109704069
		arg_279_1.duration_ = 9

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1109704070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = "ST60"

			if arg_279_1.bgs_[var_282_0] == nil then
				local var_282_1 = Object.Instantiate(arg_279_1.paintGo_)

				var_282_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_282_0)
				var_282_1.name = var_282_0
				var_282_1.transform.parent = arg_279_1.stage_.transform
				var_282_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_279_1.bgs_[var_282_0] = var_282_1
			end

			local var_282_2 = 1.999999999999

			if var_282_2 < arg_279_1.time_ and arg_279_1.time_ <= var_282_2 + arg_282_0 then
				local var_282_3 = manager.ui.mainCamera.transform.localPosition
				local var_282_4 = Vector3.New(0, 0, 10) + Vector3.New(var_282_3.x, var_282_3.y, 0)
				local var_282_5 = arg_279_1.bgs_.ST60

				var_282_5.transform.localPosition = var_282_4
				var_282_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_282_6 = var_282_5:GetComponent("SpriteRenderer")

				if var_282_6 and var_282_6.sprite then
					local var_282_7 = (var_282_5.transform.localPosition - var_282_3).z
					local var_282_8 = manager.ui.mainCameraCom_
					local var_282_9 = 2 * var_282_7 * Mathf.Tan(var_282_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_282_10 = var_282_9 * var_282_8.aspect
					local var_282_11 = var_282_6.sprite.bounds.size.x
					local var_282_12 = var_282_6.sprite.bounds.size.y
					local var_282_13 = var_282_10 / var_282_11
					local var_282_14 = var_282_9 / var_282_12
					local var_282_15 = var_282_14 < var_282_13 and var_282_13 or var_282_14

					var_282_5.transform.localScale = Vector3.New(var_282_15, var_282_15, 0)
				end

				for iter_282_0, iter_282_1 in pairs(arg_279_1.bgs_) do
					if iter_282_0 ~= "ST60" then
						iter_282_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_282_16 = 3.999999999999

			if var_282_16 < arg_279_1.time_ and arg_279_1.time_ <= var_282_16 + arg_282_0 then
				arg_279_1.allBtn_.enabled = false
			end

			local var_282_17 = 0.3

			if arg_279_1.time_ >= var_282_16 + var_282_17 and arg_279_1.time_ < var_282_16 + var_282_17 + arg_282_0 then
				arg_279_1.allBtn_.enabled = true
			end

			local var_282_18 = 0

			if var_282_18 < arg_279_1.time_ and arg_279_1.time_ <= var_282_18 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_19 = 2

			if var_282_18 <= arg_279_1.time_ and arg_279_1.time_ < var_282_18 + var_282_19 then
				local var_282_20 = (arg_279_1.time_ - var_282_18) / var_282_19
				local var_282_21 = Color.New(1, 1, 1)

				var_282_21.a = Mathf.Lerp(0, 1, var_282_20)
				arg_279_1.mask_.color = var_282_21
			end

			if arg_279_1.time_ >= var_282_18 + var_282_19 and arg_279_1.time_ < var_282_18 + var_282_19 + arg_282_0 then
				local var_282_22 = Color.New(1, 1, 1)

				var_282_22.a = 1
				arg_279_1.mask_.color = var_282_22
			end

			local var_282_23 = 2

			if var_282_23 < arg_279_1.time_ and arg_279_1.time_ <= var_282_23 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_24 = 2

			if var_282_23 <= arg_279_1.time_ and arg_279_1.time_ < var_282_23 + var_282_24 then
				local var_282_25 = (arg_279_1.time_ - var_282_23) / var_282_24
				local var_282_26 = Color.New(1, 1, 1)

				var_282_26.a = Mathf.Lerp(1, 0, var_282_25)
				arg_279_1.mask_.color = var_282_26
			end

			if arg_279_1.time_ >= var_282_23 + var_282_24 and arg_279_1.time_ < var_282_23 + var_282_24 + arg_282_0 then
				local var_282_27 = Color.New(1, 1, 1)
				local var_282_28 = 0

				arg_279_1.mask_.enabled = false
				var_282_27.a = var_282_28
				arg_279_1.mask_.color = var_282_27
			end

			if arg_279_1.frameCnt_ <= 1 then
				arg_279_1.dialog_:SetActive(false)
			end

			local var_282_29 = 4
			local var_282_30 = 0.325

			if var_282_29 < arg_279_1.time_ and arg_279_1.time_ <= var_282_29 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0

				arg_279_1.dialog_:SetActive(true)

				arg_279_1.dialogCg_.alpha = 0

				local var_282_31 = LeanTween.value(arg_279_1.dialog_, 0, 1, 0.3)

				var_282_31:setOnUpdate(LuaHelper.FloatAction(function(arg_283_0)
					arg_279_1.dialogCg_.alpha = arg_283_0
				end))
				var_282_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_279_1.dialog_)
					var_282_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_279_1.duration_ = arg_279_1.duration_ + 0.3

				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_32 = arg_279_1:FormatText(StoryNameCfg[7].name)

				arg_279_1.leftNameTxt_.text = var_282_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_33 = arg_279_1:GetWordFromCfg(1109704069)
				local var_282_34 = arg_279_1:FormatText(var_282_33.content)

				arg_279_1.text_.text = var_282_34

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_35 = 13
				local var_282_36 = utf8.len(var_282_34)
				local var_282_37 = var_282_35 <= 0 and var_282_30 or var_282_30 * (var_282_36 / var_282_35)

				if var_282_37 > 0 and var_282_30 < var_282_37 then
					arg_279_1.talkMaxDuration = var_282_37
					var_282_29 = var_282_29 + 0.3

					if var_282_37 + var_282_29 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_37 + var_282_29
					end
				end

				arg_279_1.text_.text = var_282_34
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_38 = var_282_29 + 0.3
			local var_282_39 = math.max(var_282_30, arg_279_1.talkMaxDuration)

			if var_282_38 <= arg_279_1.time_ and arg_279_1.time_ < var_282_38 + var_282_39 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_38) / var_282_39

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_38 + var_282_39 and arg_279_1.time_ < var_282_38 + var_282_39 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1109704070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1109704070
		arg_285_1.duration_ = 5.2

		local var_285_0 = {
			zh = 3.9,
			ja = 5.2
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1109704071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1097ui_story"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos1097ui_story = var_288_0.localPosition
			end

			local var_288_2 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2
				local var_288_4 = Vector3.New(0, -0.54, -6.3)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1097ui_story, var_288_4, var_288_3)

				local var_288_5 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_5.x, var_288_5.y, var_288_5.z)

				local var_288_6 = var_288_0.localEulerAngles

				var_288_6.z = 0
				var_288_6.x = 0
				var_288_0.localEulerAngles = var_288_6
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_288_7 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_7.x, var_288_7.y, var_288_7.z)

				local var_288_8 = var_288_0.localEulerAngles

				var_288_8.z = 0
				var_288_8.x = 0
				var_288_0.localEulerAngles = var_288_8
			end

			local var_288_9 = arg_285_1.actors_["1097ui_story"]
			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect1097ui_story == nil then
				arg_285_1.var_.characterEffect1097ui_story = var_288_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_11 = 0.200000002980232

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_11 and not isNil(var_288_9) then
				local var_288_12 = (arg_285_1.time_ - var_288_10) / var_288_11

				if arg_285_1.var_.characterEffect1097ui_story and not isNil(var_288_9) then
					arg_285_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_10 + var_288_11 and arg_285_1.time_ < var_288_10 + var_288_11 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect1097ui_story then
				arg_285_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_288_13 = 0

			if var_288_13 < arg_285_1.time_ and arg_285_1.time_ <= var_288_13 + arg_288_0 then
				arg_285_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_288_14 = 0

			if var_288_14 < arg_285_1.time_ and arg_285_1.time_ <= var_288_14 + arg_288_0 then
				arg_285_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_288_15 = 0
			local var_288_16 = 0.3

			if var_288_15 < arg_285_1.time_ and arg_285_1.time_ <= var_288_15 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_17 = arg_285_1:FormatText(StoryNameCfg[216].name)

				arg_285_1.leftNameTxt_.text = var_288_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_18 = arg_285_1:GetWordFromCfg(1109704070)
				local var_288_19 = arg_285_1:FormatText(var_288_18.content)

				arg_285_1.text_.text = var_288_19

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_20 = 12
				local var_288_21 = utf8.len(var_288_19)
				local var_288_22 = var_288_20 <= 0 and var_288_16 or var_288_16 * (var_288_21 / var_288_20)

				if var_288_22 > 0 and var_288_16 < var_288_22 then
					arg_285_1.talkMaxDuration = var_288_22

					if var_288_22 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_22 + var_288_15
					end
				end

				arg_285_1.text_.text = var_288_19
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704070", "story_v_side_new_1109704.awb") ~= 0 then
					local var_288_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704070", "story_v_side_new_1109704.awb") / 1000

					if var_288_23 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_23 + var_288_15
					end

					if var_288_18.prefab_name ~= "" and arg_285_1.actors_[var_288_18.prefab_name] ~= nil then
						local var_288_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_18.prefab_name].transform, "story_v_side_new_1109704", "1109704070", "story_v_side_new_1109704.awb")

						arg_285_1:RecordAudio("1109704070", var_288_24)
						arg_285_1:RecordAudio("1109704070", var_288_24)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704070", "story_v_side_new_1109704.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704070", "story_v_side_new_1109704.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_25 = math.max(var_288_16, arg_285_1.talkMaxDuration)

			if var_288_15 <= arg_285_1.time_ and arg_285_1.time_ < var_288_15 + var_288_25 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_15) / var_288_25

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_15 + var_288_25 and arg_285_1.time_ < var_288_15 + var_288_25 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
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

		arg_285_1:InitPlayNodeList()
	end,
	Play1109704071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1109704071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1109704072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1097ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1097ui_story == nil then
				arg_289_1.var_.characterEffect1097ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1097ui_story and not isNil(var_292_0) then
					local var_292_4 = Mathf.Lerp(0, 0.5, var_292_3)

					arg_289_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1097ui_story.fillRatio = var_292_4
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1097ui_story then
				local var_292_5 = 0.5

				arg_289_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1097ui_story.fillRatio = var_292_5
			end

			local var_292_6 = 0
			local var_292_7 = 0.85

			if var_292_6 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_8 = arg_289_1:FormatText(StoryNameCfg[7].name)

				arg_289_1.leftNameTxt_.text = var_292_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_9 = arg_289_1:GetWordFromCfg(1109704071)
				local var_292_10 = arg_289_1:FormatText(var_292_9.content)

				arg_289_1.text_.text = var_292_10

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_11 = 34
				local var_292_12 = utf8.len(var_292_10)
				local var_292_13 = var_292_11 <= 0 and var_292_7 or var_292_7 * (var_292_12 / var_292_11)

				if var_292_13 > 0 and var_292_7 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13

					if var_292_13 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_6
					end
				end

				arg_289_1.text_.text = var_292_10
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_14 = math.max(var_292_7, arg_289_1.talkMaxDuration)

			if var_292_6 <= arg_289_1.time_ and arg_289_1.time_ < var_292_6 + var_292_14 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_6) / var_292_14

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_6 + var_292_14 and arg_289_1.time_ < var_292_6 + var_292_14 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1109704072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1109704072
		arg_293_1.duration_ = 6.43

		local var_293_0 = {
			zh = 4.2,
			ja = 6.433
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1109704073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1097ui_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos1097ui_story = var_296_0.localPosition
			end

			local var_296_2 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2
				local var_296_4 = Vector3.New(0, -0.54, -6.3)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1097ui_story, var_296_4, var_296_3)

				local var_296_5 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_5.x, var_296_5.y, var_296_5.z)

				local var_296_6 = var_296_0.localEulerAngles

				var_296_6.z = 0
				var_296_6.x = 0
				var_296_0.localEulerAngles = var_296_6
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_296_7 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_7.x, var_296_7.y, var_296_7.z)

				local var_296_8 = var_296_0.localEulerAngles

				var_296_8.z = 0
				var_296_8.x = 0
				var_296_0.localEulerAngles = var_296_8
			end

			local var_296_9 = arg_293_1.actors_["1097ui_story"]
			local var_296_10 = 0

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect1097ui_story == nil then
				arg_293_1.var_.characterEffect1097ui_story = var_296_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_11 = 0.200000002980232

			if var_296_10 <= arg_293_1.time_ and arg_293_1.time_ < var_296_10 + var_296_11 and not isNil(var_296_9) then
				local var_296_12 = (arg_293_1.time_ - var_296_10) / var_296_11

				if arg_293_1.var_.characterEffect1097ui_story and not isNil(var_296_9) then
					arg_293_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_10 + var_296_11 and arg_293_1.time_ < var_296_10 + var_296_11 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect1097ui_story then
				arg_293_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_296_13 = 0

			if var_296_13 < arg_293_1.time_ and arg_293_1.time_ <= var_296_13 + arg_296_0 then
				arg_293_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_296_14 = 0

			if var_296_14 < arg_293_1.time_ and arg_293_1.time_ <= var_296_14 + arg_296_0 then
				arg_293_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_296_15 = 0
			local var_296_16 = 0.3

			if var_296_15 < arg_293_1.time_ and arg_293_1.time_ <= var_296_15 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_17 = arg_293_1:FormatText(StoryNameCfg[216].name)

				arg_293_1.leftNameTxt_.text = var_296_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_18 = arg_293_1:GetWordFromCfg(1109704072)
				local var_296_19 = arg_293_1:FormatText(var_296_18.content)

				arg_293_1.text_.text = var_296_19

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_20 = 12
				local var_296_21 = utf8.len(var_296_19)
				local var_296_22 = var_296_20 <= 0 and var_296_16 or var_296_16 * (var_296_21 / var_296_20)

				if var_296_22 > 0 and var_296_16 < var_296_22 then
					arg_293_1.talkMaxDuration = var_296_22

					if var_296_22 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_22 + var_296_15
					end
				end

				arg_293_1.text_.text = var_296_19
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704072", "story_v_side_new_1109704.awb") ~= 0 then
					local var_296_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704072", "story_v_side_new_1109704.awb") / 1000

					if var_296_23 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_23 + var_296_15
					end

					if var_296_18.prefab_name ~= "" and arg_293_1.actors_[var_296_18.prefab_name] ~= nil then
						local var_296_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_18.prefab_name].transform, "story_v_side_new_1109704", "1109704072", "story_v_side_new_1109704.awb")

						arg_293_1:RecordAudio("1109704072", var_296_24)
						arg_293_1:RecordAudio("1109704072", var_296_24)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704072", "story_v_side_new_1109704.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704072", "story_v_side_new_1109704.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_25 = math.max(var_296_16, arg_293_1.talkMaxDuration)

			if var_296_15 <= arg_293_1.time_ and arg_293_1.time_ < var_296_15 + var_296_25 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_15) / var_296_25

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_15 + var_296_25 and arg_293_1.time_ < var_296_15 + var_296_25 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
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

		arg_293_1:InitPlayNodeList()
	end,
	Play1109704073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1109704073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1109704074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1097ui_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1097ui_story == nil then
				arg_297_1.var_.characterEffect1097ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect1097ui_story and not isNil(var_300_0) then
					local var_300_4 = Mathf.Lerp(0, 0.5, var_300_3)

					arg_297_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1097ui_story.fillRatio = var_300_4
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1097ui_story then
				local var_300_5 = 0.5

				arg_297_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1097ui_story.fillRatio = var_300_5
			end

			local var_300_6 = 0
			local var_300_7 = 0.725

			if var_300_6 < arg_297_1.time_ and arg_297_1.time_ <= var_300_6 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_8 = arg_297_1:FormatText(StoryNameCfg[7].name)

				arg_297_1.leftNameTxt_.text = var_300_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_9 = arg_297_1:GetWordFromCfg(1109704073)
				local var_300_10 = arg_297_1:FormatText(var_300_9.content)

				arg_297_1.text_.text = var_300_10

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_11 = 29
				local var_300_12 = utf8.len(var_300_10)
				local var_300_13 = var_300_11 <= 0 and var_300_7 or var_300_7 * (var_300_12 / var_300_11)

				if var_300_13 > 0 and var_300_7 < var_300_13 then
					arg_297_1.talkMaxDuration = var_300_13

					if var_300_13 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_6
					end
				end

				arg_297_1.text_.text = var_300_10
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_14 = math.max(var_300_7, arg_297_1.talkMaxDuration)

			if var_300_6 <= arg_297_1.time_ and arg_297_1.time_ < var_300_6 + var_300_14 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_6) / var_300_14

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_6 + var_300_14 and arg_297_1.time_ < var_300_6 + var_300_14 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1109704074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1109704074
		arg_301_1.duration_ = 4.07

		local var_301_0 = {
			zh = 4.066,
			ja = 2.933
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1109704075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1097ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1097ui_story = var_304_0.localPosition
			end

			local var_304_2 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2
				local var_304_4 = Vector3.New(0, -0.54, -6.3)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1097ui_story, var_304_4, var_304_3)

				local var_304_5 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_5.x, var_304_5.y, var_304_5.z)

				local var_304_6 = var_304_0.localEulerAngles

				var_304_6.z = 0
				var_304_6.x = 0
				var_304_0.localEulerAngles = var_304_6
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_304_7 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_7.x, var_304_7.y, var_304_7.z)

				local var_304_8 = var_304_0.localEulerAngles

				var_304_8.z = 0
				var_304_8.x = 0
				var_304_0.localEulerAngles = var_304_8
			end

			local var_304_9 = arg_301_1.actors_["1097ui_story"]
			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1097ui_story == nil then
				arg_301_1.var_.characterEffect1097ui_story = var_304_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_11 = 0.200000002980232

			if var_304_10 <= arg_301_1.time_ and arg_301_1.time_ < var_304_10 + var_304_11 and not isNil(var_304_9) then
				local var_304_12 = (arg_301_1.time_ - var_304_10) / var_304_11

				if arg_301_1.var_.characterEffect1097ui_story and not isNil(var_304_9) then
					arg_301_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_10 + var_304_11 and arg_301_1.time_ < var_304_10 + var_304_11 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1097ui_story then
				arg_301_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_304_13 = 0

			if var_304_13 < arg_301_1.time_ and arg_301_1.time_ <= var_304_13 + arg_304_0 then
				arg_301_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_304_14 = 0

			if var_304_14 < arg_301_1.time_ and arg_301_1.time_ <= var_304_14 + arg_304_0 then
				arg_301_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_304_15 = 0
			local var_304_16 = 0.3

			if var_304_15 < arg_301_1.time_ and arg_301_1.time_ <= var_304_15 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_17 = arg_301_1:FormatText(StoryNameCfg[216].name)

				arg_301_1.leftNameTxt_.text = var_304_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_18 = arg_301_1:GetWordFromCfg(1109704074)
				local var_304_19 = arg_301_1:FormatText(var_304_18.content)

				arg_301_1.text_.text = var_304_19

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_20 = 12
				local var_304_21 = utf8.len(var_304_19)
				local var_304_22 = var_304_20 <= 0 and var_304_16 or var_304_16 * (var_304_21 / var_304_20)

				if var_304_22 > 0 and var_304_16 < var_304_22 then
					arg_301_1.talkMaxDuration = var_304_22

					if var_304_22 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_22 + var_304_15
					end
				end

				arg_301_1.text_.text = var_304_19
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704074", "story_v_side_new_1109704.awb") ~= 0 then
					local var_304_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704074", "story_v_side_new_1109704.awb") / 1000

					if var_304_23 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_23 + var_304_15
					end

					if var_304_18.prefab_name ~= "" and arg_301_1.actors_[var_304_18.prefab_name] ~= nil then
						local var_304_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_18.prefab_name].transform, "story_v_side_new_1109704", "1109704074", "story_v_side_new_1109704.awb")

						arg_301_1:RecordAudio("1109704074", var_304_24)
						arg_301_1:RecordAudio("1109704074", var_304_24)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704074", "story_v_side_new_1109704.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704074", "story_v_side_new_1109704.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_25 = math.max(var_304_16, arg_301_1.talkMaxDuration)

			if var_304_15 <= arg_301_1.time_ and arg_301_1.time_ < var_304_15 + var_304_25 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_15) / var_304_25

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_15 + var_304_25 and arg_301_1.time_ < var_304_15 + var_304_25 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play1109704075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1109704075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1109704076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1097ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1097ui_story == nil then
				arg_305_1.var_.characterEffect1097ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect1097ui_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1097ui_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1097ui_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1097ui_story.fillRatio = var_308_5
			end

			local var_308_6 = 0
			local var_308_7 = 0.825

			if var_308_6 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_8 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_9 = arg_305_1:GetWordFromCfg(1109704075)
				local var_308_10 = arg_305_1:FormatText(var_308_9.content)

				arg_305_1.text_.text = var_308_10

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_11 = 33
				local var_308_12 = utf8.len(var_308_10)
				local var_308_13 = var_308_11 <= 0 and var_308_7 or var_308_7 * (var_308_12 / var_308_11)

				if var_308_13 > 0 and var_308_7 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_6
					end
				end

				arg_305_1.text_.text = var_308_10
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_14 = math.max(var_308_7, arg_305_1.talkMaxDuration)

			if var_308_6 <= arg_305_1.time_ and arg_305_1.time_ < var_308_6 + var_308_14 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_6) / var_308_14

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_6 + var_308_14 and arg_305_1.time_ < var_308_6 + var_308_14 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1109704076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1109704076
		arg_309_1.duration_ = 2

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1109704077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1097ui_story"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos1097ui_story = var_312_0.localPosition
			end

			local var_312_2 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2
				local var_312_4 = Vector3.New(0, -0.54, -6.3)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1097ui_story, var_312_4, var_312_3)

				local var_312_5 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_5.x, var_312_5.y, var_312_5.z)

				local var_312_6 = var_312_0.localEulerAngles

				var_312_6.z = 0
				var_312_6.x = 0
				var_312_0.localEulerAngles = var_312_6
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_312_7 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_7.x, var_312_7.y, var_312_7.z)

				local var_312_8 = var_312_0.localEulerAngles

				var_312_8.z = 0
				var_312_8.x = 0
				var_312_0.localEulerAngles = var_312_8
			end

			local var_312_9 = arg_309_1.actors_["1097ui_story"]
			local var_312_10 = 0

			if var_312_10 < arg_309_1.time_ and arg_309_1.time_ <= var_312_10 + arg_312_0 and not isNil(var_312_9) and arg_309_1.var_.characterEffect1097ui_story == nil then
				arg_309_1.var_.characterEffect1097ui_story = var_312_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_11 = 0.200000002980232

			if var_312_10 <= arg_309_1.time_ and arg_309_1.time_ < var_312_10 + var_312_11 and not isNil(var_312_9) then
				local var_312_12 = (arg_309_1.time_ - var_312_10) / var_312_11

				if arg_309_1.var_.characterEffect1097ui_story and not isNil(var_312_9) then
					arg_309_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_10 + var_312_11 and arg_309_1.time_ < var_312_10 + var_312_11 + arg_312_0 and not isNil(var_312_9) and arg_309_1.var_.characterEffect1097ui_story then
				arg_309_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_312_13 = 0

			if var_312_13 < arg_309_1.time_ and arg_309_1.time_ <= var_312_13 + arg_312_0 then
				arg_309_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_312_14 = 0

			if var_312_14 < arg_309_1.time_ and arg_309_1.time_ <= var_312_14 + arg_312_0 then
				arg_309_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_312_15 = 0
			local var_312_16 = 0.05

			if var_312_15 < arg_309_1.time_ and arg_309_1.time_ <= var_312_15 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_17 = arg_309_1:FormatText(StoryNameCfg[216].name)

				arg_309_1.leftNameTxt_.text = var_312_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_18 = arg_309_1:GetWordFromCfg(1109704076)
				local var_312_19 = arg_309_1:FormatText(var_312_18.content)

				arg_309_1.text_.text = var_312_19

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_20 = 2
				local var_312_21 = utf8.len(var_312_19)
				local var_312_22 = var_312_20 <= 0 and var_312_16 or var_312_16 * (var_312_21 / var_312_20)

				if var_312_22 > 0 and var_312_16 < var_312_22 then
					arg_309_1.talkMaxDuration = var_312_22

					if var_312_22 + var_312_15 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_22 + var_312_15
					end
				end

				arg_309_1.text_.text = var_312_19
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704076", "story_v_side_new_1109704.awb") ~= 0 then
					local var_312_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704076", "story_v_side_new_1109704.awb") / 1000

					if var_312_23 + var_312_15 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_23 + var_312_15
					end

					if var_312_18.prefab_name ~= "" and arg_309_1.actors_[var_312_18.prefab_name] ~= nil then
						local var_312_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_18.prefab_name].transform, "story_v_side_new_1109704", "1109704076", "story_v_side_new_1109704.awb")

						arg_309_1:RecordAudio("1109704076", var_312_24)
						arg_309_1:RecordAudio("1109704076", var_312_24)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704076", "story_v_side_new_1109704.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704076", "story_v_side_new_1109704.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_25 = math.max(var_312_16, arg_309_1.talkMaxDuration)

			if var_312_15 <= arg_309_1.time_ and arg_309_1.time_ < var_312_15 + var_312_25 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_15) / var_312_25

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_15 + var_312_25 and arg_309_1.time_ < var_312_15 + var_312_25 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
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

		arg_309_1:InitPlayNodeList()
	end,
	Play1109704077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1109704077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1109704078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1097ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1097ui_story == nil then
				arg_313_1.var_.characterEffect1097ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1097ui_story and not isNil(var_316_0) then
					local var_316_4 = Mathf.Lerp(0, 0.5, var_316_3)

					arg_313_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1097ui_story.fillRatio = var_316_4
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1097ui_story then
				local var_316_5 = 0.5

				arg_313_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1097ui_story.fillRatio = var_316_5
			end

			local var_316_6 = 0
			local var_316_7 = 1.1

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_8 = arg_313_1:GetWordFromCfg(1109704077)
				local var_316_9 = arg_313_1:FormatText(var_316_8.content)

				arg_313_1.text_.text = var_316_9

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_10 = 44
				local var_316_11 = utf8.len(var_316_9)
				local var_316_12 = var_316_10 <= 0 and var_316_7 or var_316_7 * (var_316_11 / var_316_10)

				if var_316_12 > 0 and var_316_7 < var_316_12 then
					arg_313_1.talkMaxDuration = var_316_12

					if var_316_12 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_12 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_9
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_13 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_13 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_13

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_13 and arg_313_1.time_ < var_316_6 + var_316_13 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1109704078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1109704078
		arg_317_1.duration_ = 2.53

		local var_317_0 = {
			zh = 1.999999999999,
			ja = 2.533
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1109704079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1097ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1097ui_story == nil then
				arg_317_1.var_.characterEffect1097ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect1097ui_story and not isNil(var_320_0) then
					arg_317_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1097ui_story then
				arg_317_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_320_4 = 0

			if var_320_4 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_320_5 = 0

			if var_320_5 < arg_317_1.time_ and arg_317_1.time_ <= var_320_5 + arg_320_0 then
				arg_317_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_320_6 = 0
			local var_320_7 = 0.125

			if var_320_6 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_8 = arg_317_1:FormatText(StoryNameCfg[216].name)

				arg_317_1.leftNameTxt_.text = var_320_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_9 = arg_317_1:GetWordFromCfg(1109704078)
				local var_320_10 = arg_317_1:FormatText(var_320_9.content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 5
				local var_320_12 = utf8.len(var_320_10)
				local var_320_13 = var_320_11 <= 0 and var_320_7 or var_320_7 * (var_320_12 / var_320_11)

				if var_320_13 > 0 and var_320_7 < var_320_13 then
					arg_317_1.talkMaxDuration = var_320_13

					if var_320_13 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_6
					end
				end

				arg_317_1.text_.text = var_320_10
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704078", "story_v_side_new_1109704.awb") ~= 0 then
					local var_320_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704078", "story_v_side_new_1109704.awb") / 1000

					if var_320_14 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_14 + var_320_6
					end

					if var_320_9.prefab_name ~= "" and arg_317_1.actors_[var_320_9.prefab_name] ~= nil then
						local var_320_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_9.prefab_name].transform, "story_v_side_new_1109704", "1109704078", "story_v_side_new_1109704.awb")

						arg_317_1:RecordAudio("1109704078", var_320_15)
						arg_317_1:RecordAudio("1109704078", var_320_15)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704078", "story_v_side_new_1109704.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704078", "story_v_side_new_1109704.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_16 = math.max(var_320_7, arg_317_1.talkMaxDuration)

			if var_320_6 <= arg_317_1.time_ and arg_317_1.time_ < var_320_6 + var_320_16 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_6) / var_320_16

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_6 + var_320_16 and arg_317_1.time_ < var_320_6 + var_320_16 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1109704079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1109704079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1109704080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1097ui_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1097ui_story == nil then
				arg_321_1.var_.characterEffect1097ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect1097ui_story and not isNil(var_324_0) then
					local var_324_4 = Mathf.Lerp(0, 0.5, var_324_3)

					arg_321_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1097ui_story.fillRatio = var_324_4
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1097ui_story then
				local var_324_5 = 0.5

				arg_321_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1097ui_story.fillRatio = var_324_5
			end

			local var_324_6 = 0
			local var_324_7 = 0.7

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

				local var_324_9 = arg_321_1:GetWordFromCfg(1109704079)
				local var_324_10 = arg_321_1:FormatText(var_324_9.content)

				arg_321_1.text_.text = var_324_10

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_11 = 28
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
	Play1109704080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1109704080
		arg_325_1.duration_ = 6.3

		local var_325_0 = {
			zh = 6.3,
			ja = 6.2
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
				arg_325_0:Play1109704081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1097ui_story"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos1097ui_story = var_328_0.localPosition
			end

			local var_328_2 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2
				local var_328_4 = Vector3.New(0, -0.54, -6.3)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1097ui_story, var_328_4, var_328_3)

				local var_328_5 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_5.x, var_328_5.y, var_328_5.z)

				local var_328_6 = var_328_0.localEulerAngles

				var_328_6.z = 0
				var_328_6.x = 0
				var_328_0.localEulerAngles = var_328_6
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_328_7 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_7.x, var_328_7.y, var_328_7.z)

				local var_328_8 = var_328_0.localEulerAngles

				var_328_8.z = 0
				var_328_8.x = 0
				var_328_0.localEulerAngles = var_328_8
			end

			local var_328_9 = arg_325_1.actors_["1097ui_story"]
			local var_328_10 = 0

			if var_328_10 < arg_325_1.time_ and arg_325_1.time_ <= var_328_10 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1097ui_story == nil then
				arg_325_1.var_.characterEffect1097ui_story = var_328_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_11 = 0.200000002980232

			if var_328_10 <= arg_325_1.time_ and arg_325_1.time_ < var_328_10 + var_328_11 and not isNil(var_328_9) then
				local var_328_12 = (arg_325_1.time_ - var_328_10) / var_328_11

				if arg_325_1.var_.characterEffect1097ui_story and not isNil(var_328_9) then
					arg_325_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_10 + var_328_11 and arg_325_1.time_ < var_328_10 + var_328_11 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1097ui_story then
				arg_325_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_328_13 = 0

			if var_328_13 < arg_325_1.time_ and arg_325_1.time_ <= var_328_13 + arg_328_0 then
				arg_325_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_328_14 = 0

			if var_328_14 < arg_325_1.time_ and arg_325_1.time_ <= var_328_14 + arg_328_0 then
				arg_325_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_328_15 = 0
			local var_328_16 = 0.525

			if var_328_15 < arg_325_1.time_ and arg_325_1.time_ <= var_328_15 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_17 = arg_325_1:FormatText(StoryNameCfg[216].name)

				arg_325_1.leftNameTxt_.text = var_328_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_18 = arg_325_1:GetWordFromCfg(1109704080)
				local var_328_19 = arg_325_1:FormatText(var_328_18.content)

				arg_325_1.text_.text = var_328_19

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_20 = 21
				local var_328_21 = utf8.len(var_328_19)
				local var_328_22 = var_328_20 <= 0 and var_328_16 or var_328_16 * (var_328_21 / var_328_20)

				if var_328_22 > 0 and var_328_16 < var_328_22 then
					arg_325_1.talkMaxDuration = var_328_22

					if var_328_22 + var_328_15 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_22 + var_328_15
					end
				end

				arg_325_1.text_.text = var_328_19
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704080", "story_v_side_new_1109704.awb") ~= 0 then
					local var_328_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704080", "story_v_side_new_1109704.awb") / 1000

					if var_328_23 + var_328_15 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_23 + var_328_15
					end

					if var_328_18.prefab_name ~= "" and arg_325_1.actors_[var_328_18.prefab_name] ~= nil then
						local var_328_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_18.prefab_name].transform, "story_v_side_new_1109704", "1109704080", "story_v_side_new_1109704.awb")

						arg_325_1:RecordAudio("1109704080", var_328_24)
						arg_325_1:RecordAudio("1109704080", var_328_24)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704080", "story_v_side_new_1109704.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704080", "story_v_side_new_1109704.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_25 = math.max(var_328_16, arg_325_1.talkMaxDuration)

			if var_328_15 <= arg_325_1.time_ and arg_325_1.time_ < var_328_15 + var_328_25 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_15) / var_328_25

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_15 + var_328_25 and arg_325_1.time_ < var_328_15 + var_328_25 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
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

		arg_325_1:InitPlayNodeList()
	end,
	Play1109704081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1109704081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1109704082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1097ui_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1097ui_story == nil then
				arg_329_1.var_.characterEffect1097ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect1097ui_story and not isNil(var_332_0) then
					local var_332_4 = Mathf.Lerp(0, 0.5, var_332_3)

					arg_329_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1097ui_story.fillRatio = var_332_4
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1097ui_story then
				local var_332_5 = 0.5

				arg_329_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1097ui_story.fillRatio = var_332_5
			end

			local var_332_6 = 0
			local var_332_7 = 0.075

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

				local var_332_9 = arg_329_1:GetWordFromCfg(1109704081)
				local var_332_10 = arg_329_1:FormatText(var_332_9.content)

				arg_329_1.text_.text = var_332_10

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_11 = 3
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
	Play1109704082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1109704082
		arg_333_1.duration_ = 8.93

		local var_333_0 = {
			zh = 8.933,
			ja = 8.466
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
				arg_333_0:Play1109704083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1097ui_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1097ui_story == nil then
				arg_333_1.var_.characterEffect1097ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect1097ui_story and not isNil(var_336_0) then
					arg_333_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1097ui_story then
				arg_333_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_336_4 = 0

			if var_336_4 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_336_5 = 0

			if var_336_5 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 then
				arg_333_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_336_6 = 0
			local var_336_7 = 0.65

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_8 = arg_333_1:FormatText(StoryNameCfg[216].name)

				arg_333_1.leftNameTxt_.text = var_336_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_9 = arg_333_1:GetWordFromCfg(1109704082)
				local var_336_10 = arg_333_1:FormatText(var_336_9.content)

				arg_333_1.text_.text = var_336_10

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 26
				local var_336_12 = utf8.len(var_336_10)
				local var_336_13 = var_336_11 <= 0 and var_336_7 or var_336_7 * (var_336_12 / var_336_11)

				if var_336_13 > 0 and var_336_7 < var_336_13 then
					arg_333_1.talkMaxDuration = var_336_13

					if var_336_13 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_13 + var_336_6
					end
				end

				arg_333_1.text_.text = var_336_10
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704082", "story_v_side_new_1109704.awb") ~= 0 then
					local var_336_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704082", "story_v_side_new_1109704.awb") / 1000

					if var_336_14 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_14 + var_336_6
					end

					if var_336_9.prefab_name ~= "" and arg_333_1.actors_[var_336_9.prefab_name] ~= nil then
						local var_336_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_9.prefab_name].transform, "story_v_side_new_1109704", "1109704082", "story_v_side_new_1109704.awb")

						arg_333_1:RecordAudio("1109704082", var_336_15)
						arg_333_1:RecordAudio("1109704082", var_336_15)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704082", "story_v_side_new_1109704.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704082", "story_v_side_new_1109704.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_16 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_16 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_16

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_16 and arg_333_1.time_ < var_336_6 + var_336_16 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1109704083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1109704083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1109704084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1097ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1097ui_story == nil then
				arg_337_1.var_.characterEffect1097ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect1097ui_story and not isNil(var_340_0) then
					local var_340_4 = Mathf.Lerp(0, 0.5, var_340_3)

					arg_337_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1097ui_story.fillRatio = var_340_4
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1097ui_story then
				local var_340_5 = 0.5

				arg_337_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1097ui_story.fillRatio = var_340_5
			end

			local var_340_6 = 0
			local var_340_7 = 1.375

			if var_340_6 < arg_337_1.time_ and arg_337_1.time_ <= var_340_6 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_8 = arg_337_1:FormatText(StoryNameCfg[7].name)

				arg_337_1.leftNameTxt_.text = var_340_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_9 = arg_337_1:GetWordFromCfg(1109704083)
				local var_340_10 = arg_337_1:FormatText(var_340_9.content)

				arg_337_1.text_.text = var_340_10

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_11 = 55
				local var_340_12 = utf8.len(var_340_10)
				local var_340_13 = var_340_11 <= 0 and var_340_7 or var_340_7 * (var_340_12 / var_340_11)

				if var_340_13 > 0 and var_340_7 < var_340_13 then
					arg_337_1.talkMaxDuration = var_340_13

					if var_340_13 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_6
					end
				end

				arg_337_1.text_.text = var_340_10
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_14 = math.max(var_340_7, arg_337_1.talkMaxDuration)

			if var_340_6 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_14 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_14

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_14 and arg_337_1.time_ < var_340_6 + var_340_14 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1109704084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1109704084
		arg_341_1.duration_ = 2.7

		local var_341_0 = {
			zh = 1.999999999999,
			ja = 2.7
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1109704085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1097ui_story"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1097ui_story == nil then
				arg_341_1.var_.characterEffect1097ui_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.characterEffect1097ui_story and not isNil(var_344_0) then
					arg_341_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1097ui_story then
				arg_341_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_344_4 = 0

			if var_344_4 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_344_5 = 0

			if var_344_5 < arg_341_1.time_ and arg_341_1.time_ <= var_344_5 + arg_344_0 then
				arg_341_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_344_6 = 0
			local var_344_7 = 0.1

			if var_344_6 < arg_341_1.time_ and arg_341_1.time_ <= var_344_6 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_8 = arg_341_1:FormatText(StoryNameCfg[216].name)

				arg_341_1.leftNameTxt_.text = var_344_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_9 = arg_341_1:GetWordFromCfg(1109704084)
				local var_344_10 = arg_341_1:FormatText(var_344_9.content)

				arg_341_1.text_.text = var_344_10

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_11 = 4
				local var_344_12 = utf8.len(var_344_10)
				local var_344_13 = var_344_11 <= 0 and var_344_7 or var_344_7 * (var_344_12 / var_344_11)

				if var_344_13 > 0 and var_344_7 < var_344_13 then
					arg_341_1.talkMaxDuration = var_344_13

					if var_344_13 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_13 + var_344_6
					end
				end

				arg_341_1.text_.text = var_344_10
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704084", "story_v_side_new_1109704.awb") ~= 0 then
					local var_344_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704084", "story_v_side_new_1109704.awb") / 1000

					if var_344_14 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_14 + var_344_6
					end

					if var_344_9.prefab_name ~= "" and arg_341_1.actors_[var_344_9.prefab_name] ~= nil then
						local var_344_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_9.prefab_name].transform, "story_v_side_new_1109704", "1109704084", "story_v_side_new_1109704.awb")

						arg_341_1:RecordAudio("1109704084", var_344_15)
						arg_341_1:RecordAudio("1109704084", var_344_15)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704084", "story_v_side_new_1109704.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704084", "story_v_side_new_1109704.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_16 = math.max(var_344_7, arg_341_1.talkMaxDuration)

			if var_344_6 <= arg_341_1.time_ and arg_341_1.time_ < var_344_6 + var_344_16 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_6) / var_344_16

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_6 + var_344_16 and arg_341_1.time_ < var_344_6 + var_344_16 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play1109704085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1109704085
		arg_345_1.duration_ = 12.37

		local var_345_0 = {
			zh = 8.965999999999,
			ja = 12.365999999999
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1109704086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 2.00000000298023

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				local var_348_1 = manager.ui.mainCamera.transform.localPosition
				local var_348_2 = Vector3.New(0, 0, 10) + Vector3.New(var_348_1.x, var_348_1.y, 0)
				local var_348_3 = arg_345_1.bgs_.ST60

				var_348_3.transform.localPosition = var_348_2
				var_348_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_348_4 = var_348_3:GetComponent("SpriteRenderer")

				if var_348_4 and var_348_4.sprite then
					local var_348_5 = (var_348_3.transform.localPosition - var_348_1).z
					local var_348_6 = manager.ui.mainCameraCom_
					local var_348_7 = 2 * var_348_5 * Mathf.Tan(var_348_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_348_8 = var_348_7 * var_348_6.aspect
					local var_348_9 = var_348_4.sprite.bounds.size.x
					local var_348_10 = var_348_4.sprite.bounds.size.y
					local var_348_11 = var_348_8 / var_348_9
					local var_348_12 = var_348_7 / var_348_10
					local var_348_13 = var_348_12 < var_348_11 and var_348_11 or var_348_12

					var_348_3.transform.localScale = Vector3.New(var_348_13, var_348_13, 0)
				end

				for iter_348_0, iter_348_1 in pairs(arg_345_1.bgs_) do
					if iter_348_0 ~= "ST60" then
						iter_348_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_348_14 = 3.999999999999

			if var_348_14 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			local var_348_15 = 0.3

			if arg_345_1.time_ >= var_348_14 + var_348_15 and arg_345_1.time_ < var_348_14 + var_348_15 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end

			local var_348_16 = 0

			if var_348_16 < arg_345_1.time_ and arg_345_1.time_ <= var_348_16 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_17 = 2

			if var_348_16 <= arg_345_1.time_ and arg_345_1.time_ < var_348_16 + var_348_17 then
				local var_348_18 = (arg_345_1.time_ - var_348_16) / var_348_17
				local var_348_19 = Color.New(1, 1, 1)

				var_348_19.a = Mathf.Lerp(0, 1, var_348_18)
				arg_345_1.mask_.color = var_348_19
			end

			if arg_345_1.time_ >= var_348_16 + var_348_17 and arg_345_1.time_ < var_348_16 + var_348_17 + arg_348_0 then
				local var_348_20 = Color.New(1, 1, 1)

				var_348_20.a = 1
				arg_345_1.mask_.color = var_348_20
			end

			local var_348_21 = 2

			if var_348_21 < arg_345_1.time_ and arg_345_1.time_ <= var_348_21 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_22 = 2

			if var_348_21 <= arg_345_1.time_ and arg_345_1.time_ < var_348_21 + var_348_22 then
				local var_348_23 = (arg_345_1.time_ - var_348_21) / var_348_22
				local var_348_24 = Color.New(1, 1, 1)

				var_348_24.a = Mathf.Lerp(1, 0, var_348_23)
				arg_345_1.mask_.color = var_348_24
			end

			if arg_345_1.time_ >= var_348_21 + var_348_22 and arg_345_1.time_ < var_348_21 + var_348_22 + arg_348_0 then
				local var_348_25 = Color.New(1, 1, 1)
				local var_348_26 = 0

				arg_345_1.mask_.enabled = false
				var_348_25.a = var_348_26
				arg_345_1.mask_.color = var_348_25
			end

			local var_348_27 = arg_345_1.actors_["1097ui_story"].transform
			local var_348_28 = 3.8

			if var_348_28 < arg_345_1.time_ and arg_345_1.time_ <= var_348_28 + arg_348_0 then
				arg_345_1.var_.moveOldPos1097ui_story = var_348_27.localPosition
			end

			local var_348_29 = 0.001

			if var_348_28 <= arg_345_1.time_ and arg_345_1.time_ < var_348_28 + var_348_29 then
				local var_348_30 = (arg_345_1.time_ - var_348_28) / var_348_29
				local var_348_31 = Vector3.New(0, -0.54, -6.3)

				var_348_27.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1097ui_story, var_348_31, var_348_30)

				local var_348_32 = manager.ui.mainCamera.transform.position - var_348_27.position

				var_348_27.forward = Vector3.New(var_348_32.x, var_348_32.y, var_348_32.z)

				local var_348_33 = var_348_27.localEulerAngles

				var_348_33.z = 0
				var_348_33.x = 0
				var_348_27.localEulerAngles = var_348_33
			end

			if arg_345_1.time_ >= var_348_28 + var_348_29 and arg_345_1.time_ < var_348_28 + var_348_29 + arg_348_0 then
				var_348_27.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_348_34 = manager.ui.mainCamera.transform.position - var_348_27.position

				var_348_27.forward = Vector3.New(var_348_34.x, var_348_34.y, var_348_34.z)

				local var_348_35 = var_348_27.localEulerAngles

				var_348_35.z = 0
				var_348_35.x = 0
				var_348_27.localEulerAngles = var_348_35
			end

			local var_348_36 = arg_345_1.actors_["1097ui_story"]
			local var_348_37 = 3.8

			if var_348_37 < arg_345_1.time_ and arg_345_1.time_ <= var_348_37 + arg_348_0 and not isNil(var_348_36) and arg_345_1.var_.characterEffect1097ui_story == nil then
				arg_345_1.var_.characterEffect1097ui_story = var_348_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_38 = 0.200000002980232

			if var_348_37 <= arg_345_1.time_ and arg_345_1.time_ < var_348_37 + var_348_38 and not isNil(var_348_36) then
				local var_348_39 = (arg_345_1.time_ - var_348_37) / var_348_38

				if arg_345_1.var_.characterEffect1097ui_story and not isNil(var_348_36) then
					arg_345_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_37 + var_348_38 and arg_345_1.time_ < var_348_37 + var_348_38 + arg_348_0 and not isNil(var_348_36) and arg_345_1.var_.characterEffect1097ui_story then
				arg_345_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_348_40 = 3.8

			if var_348_40 < arg_345_1.time_ and arg_345_1.time_ <= var_348_40 + arg_348_0 then
				arg_345_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_348_41 = 3.8

			if var_348_41 < arg_345_1.time_ and arg_345_1.time_ <= var_348_41 + arg_348_0 then
				arg_345_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_348_42 = arg_345_1.actors_["1097ui_story"].transform
			local var_348_43 = 1.96599999815226

			if var_348_43 < arg_345_1.time_ and arg_345_1.time_ <= var_348_43 + arg_348_0 then
				arg_345_1.var_.moveOldPos1097ui_story = var_348_42.localPosition
			end

			local var_348_44 = 0.001

			if var_348_43 <= arg_345_1.time_ and arg_345_1.time_ < var_348_43 + var_348_44 then
				local var_348_45 = (arg_345_1.time_ - var_348_43) / var_348_44
				local var_348_46 = Vector3.New(0, 100, 0)

				var_348_42.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1097ui_story, var_348_46, var_348_45)

				local var_348_47 = manager.ui.mainCamera.transform.position - var_348_42.position

				var_348_42.forward = Vector3.New(var_348_47.x, var_348_47.y, var_348_47.z)

				local var_348_48 = var_348_42.localEulerAngles

				var_348_48.z = 0
				var_348_48.x = 0
				var_348_42.localEulerAngles = var_348_48
			end

			if arg_345_1.time_ >= var_348_43 + var_348_44 and arg_345_1.time_ < var_348_43 + var_348_44 + arg_348_0 then
				var_348_42.localPosition = Vector3.New(0, 100, 0)

				local var_348_49 = manager.ui.mainCamera.transform.position - var_348_42.position

				var_348_42.forward = Vector3.New(var_348_49.x, var_348_49.y, var_348_49.z)

				local var_348_50 = var_348_42.localEulerAngles

				var_348_50.z = 0
				var_348_50.x = 0
				var_348_42.localEulerAngles = var_348_50
			end

			if arg_345_1.frameCnt_ <= 1 then
				arg_345_1.dialog_:SetActive(false)
			end

			local var_348_51 = 3.999999999999
			local var_348_52 = 0.375

			if var_348_51 < arg_345_1.time_ and arg_345_1.time_ <= var_348_51 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0

				arg_345_1.dialog_:SetActive(true)

				arg_345_1.dialogCg_.alpha = 0

				local var_348_53 = LeanTween.value(arg_345_1.dialog_, 0, 1, 0.3)

				var_348_53:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_345_1.dialogCg_.alpha = arg_349_0
				end))
				var_348_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_345_1.dialog_)
					var_348_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_345_1.duration_ = arg_345_1.duration_ + 0.3

				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_54 = arg_345_1:FormatText(StoryNameCfg[216].name)

				arg_345_1.leftNameTxt_.text = var_348_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_55 = arg_345_1:GetWordFromCfg(1109704085)
				local var_348_56 = arg_345_1:FormatText(var_348_55.content)

				arg_345_1.text_.text = var_348_56

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_57 = 15
				local var_348_58 = utf8.len(var_348_56)
				local var_348_59 = var_348_57 <= 0 and var_348_52 or var_348_52 * (var_348_58 / var_348_57)

				if var_348_59 > 0 and var_348_52 < var_348_59 then
					arg_345_1.talkMaxDuration = var_348_59
					var_348_51 = var_348_51 + 0.3

					if var_348_59 + var_348_51 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_59 + var_348_51
					end
				end

				arg_345_1.text_.text = var_348_56
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704085", "story_v_side_new_1109704.awb") ~= 0 then
					local var_348_60 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704085", "story_v_side_new_1109704.awb") / 1000

					if var_348_60 + var_348_51 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_60 + var_348_51
					end

					if var_348_55.prefab_name ~= "" and arg_345_1.actors_[var_348_55.prefab_name] ~= nil then
						local var_348_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_55.prefab_name].transform, "story_v_side_new_1109704", "1109704085", "story_v_side_new_1109704.awb")

						arg_345_1:RecordAudio("1109704085", var_348_61)
						arg_345_1:RecordAudio("1109704085", var_348_61)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704085", "story_v_side_new_1109704.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704085", "story_v_side_new_1109704.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_62 = var_348_51 + 0.3
			local var_348_63 = math.max(var_348_52, arg_345_1.talkMaxDuration)

			if var_348_62 <= arg_345_1.time_ and arg_345_1.time_ < var_348_62 + var_348_63 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_62) / var_348_63

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_62 + var_348_63 and arg_345_1.time_ < var_348_62 + var_348_63 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
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
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play1109704086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1109704086
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1109704087(arg_351_1)
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
					local var_354_4 = Mathf.Lerp(0, 0.5, var_354_3)

					arg_351_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1097ui_story.fillRatio = var_354_4
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1097ui_story then
				local var_354_5 = 0.5

				arg_351_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1097ui_story.fillRatio = var_354_5
			end

			local var_354_6 = 0
			local var_354_7 = 0.425

			if var_354_6 < arg_351_1.time_ and arg_351_1.time_ <= var_354_6 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_8 = arg_351_1:FormatText(StoryNameCfg[7].name)

				arg_351_1.leftNameTxt_.text = var_354_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_9 = arg_351_1:GetWordFromCfg(1109704086)
				local var_354_10 = arg_351_1:FormatText(var_354_9.content)

				arg_351_1.text_.text = var_354_10

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_11 = 17
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
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_14 = math.max(var_354_7, arg_351_1.talkMaxDuration)

			if var_354_6 <= arg_351_1.time_ and arg_351_1.time_ < var_354_6 + var_354_14 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_6) / var_354_14

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_6 + var_354_14 and arg_351_1.time_ < var_354_6 + var_354_14 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1109704087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1109704087
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1109704088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0
			local var_358_1 = 1.6

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_2 = arg_355_1:GetWordFromCfg(1109704087)
				local var_358_3 = arg_355_1:FormatText(var_358_2.content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 64
				local var_358_5 = utf8.len(var_358_3)
				local var_358_6 = var_358_4 <= 0 and var_358_1 or var_358_1 * (var_358_5 / var_358_4)

				if var_358_6 > 0 and var_358_1 < var_358_6 then
					arg_355_1.talkMaxDuration = var_358_6

					if var_358_6 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_6 + var_358_0
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_1, arg_355_1.talkMaxDuration)

			if var_358_0 <= arg_355_1.time_ and arg_355_1.time_ < var_358_0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_0 + var_358_7 and arg_355_1.time_ < var_358_0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1109704088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1109704088
		arg_359_1.duration_ = 4.3

		local var_359_0 = {
			zh = 4.3,
			ja = 3.566
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1109704089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1097ui_story"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect1097ui_story == nil then
				arg_359_1.var_.characterEffect1097ui_story = var_362_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 and not isNil(var_362_0) then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.characterEffect1097ui_story and not isNil(var_362_0) then
					arg_359_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect1097ui_story then
				arg_359_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_362_4 = 0

			if var_362_4 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_362_5 = 0

			if var_362_5 < arg_359_1.time_ and arg_359_1.time_ <= var_362_5 + arg_362_0 then
				arg_359_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_362_6 = 0
			local var_362_7 = 0.575

			if var_362_6 < arg_359_1.time_ and arg_359_1.time_ <= var_362_6 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_8 = arg_359_1:FormatText(StoryNameCfg[216].name)

				arg_359_1.leftNameTxt_.text = var_362_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_9 = arg_359_1:GetWordFromCfg(1109704088)
				local var_362_10 = arg_359_1:FormatText(var_362_9.content)

				arg_359_1.text_.text = var_362_10

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_11 = 23
				local var_362_12 = utf8.len(var_362_10)
				local var_362_13 = var_362_11 <= 0 and var_362_7 or var_362_7 * (var_362_12 / var_362_11)

				if var_362_13 > 0 and var_362_7 < var_362_13 then
					arg_359_1.talkMaxDuration = var_362_13

					if var_362_13 + var_362_6 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_13 + var_362_6
					end
				end

				arg_359_1.text_.text = var_362_10
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704088", "story_v_side_new_1109704.awb") ~= 0 then
					local var_362_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704088", "story_v_side_new_1109704.awb") / 1000

					if var_362_14 + var_362_6 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_14 + var_362_6
					end

					if var_362_9.prefab_name ~= "" and arg_359_1.actors_[var_362_9.prefab_name] ~= nil then
						local var_362_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_9.prefab_name].transform, "story_v_side_new_1109704", "1109704088", "story_v_side_new_1109704.awb")

						arg_359_1:RecordAudio("1109704088", var_362_15)
						arg_359_1:RecordAudio("1109704088", var_362_15)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704088", "story_v_side_new_1109704.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704088", "story_v_side_new_1109704.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_16 = math.max(var_362_7, arg_359_1.talkMaxDuration)

			if var_362_6 <= arg_359_1.time_ and arg_359_1.time_ < var_362_6 + var_362_16 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_6) / var_362_16

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_6 + var_362_16 and arg_359_1.time_ < var_362_6 + var_362_16 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1109704089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1109704089
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1109704090(arg_363_1)
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
			local var_366_7 = 0.6

			if var_366_6 < arg_363_1.time_ and arg_363_1.time_ <= var_366_6 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_8 = arg_363_1:FormatText(StoryNameCfg[7].name)

				arg_363_1.leftNameTxt_.text = var_366_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_9 = arg_363_1:GetWordFromCfg(1109704089)
				local var_366_10 = arg_363_1:FormatText(var_366_9.content)

				arg_363_1.text_.text = var_366_10

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_11 = 24
				local var_366_12 = utf8.len(var_366_10)
				local var_366_13 = var_366_11 <= 0 and var_366_7 or var_366_7 * (var_366_12 / var_366_11)

				if var_366_13 > 0 and var_366_7 < var_366_13 then
					arg_363_1.talkMaxDuration = var_366_13

					if var_366_13 + var_366_6 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_13 + var_366_6
					end
				end

				arg_363_1.text_.text = var_366_10
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_14 = math.max(var_366_7, arg_363_1.talkMaxDuration)

			if var_366_6 <= arg_363_1.time_ and arg_363_1.time_ < var_366_6 + var_366_14 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_6) / var_366_14

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_6 + var_366_14 and arg_363_1.time_ < var_366_6 + var_366_14 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1109704090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1109704090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1109704091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 0.3

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_2 = arg_367_1:GetWordFromCfg(1109704090)
				local var_370_3 = arg_367_1:FormatText(var_370_2.content)

				arg_367_1.text_.text = var_370_3

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 12
				local var_370_5 = utf8.len(var_370_3)
				local var_370_6 = var_370_4 <= 0 and var_370_1 or var_370_1 * (var_370_5 / var_370_4)

				if var_370_6 > 0 and var_370_1 < var_370_6 then
					arg_367_1.talkMaxDuration = var_370_6

					if var_370_6 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_6 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_3
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_7 and arg_367_1.time_ < var_370_0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1109704091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1109704091
		arg_371_1.duration_ = 4.33

		local var_371_0 = {
			zh = 4.333,
			ja = 2.933
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1109704092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1097ui_story"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1097ui_story == nil then
				arg_371_1.var_.characterEffect1097ui_story = var_374_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.characterEffect1097ui_story and not isNil(var_374_0) then
					arg_371_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1097ui_story then
				arg_371_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_374_4 = 0

			if var_374_4 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			local var_374_5 = 0

			if var_374_5 < arg_371_1.time_ and arg_371_1.time_ <= var_374_5 + arg_374_0 then
				arg_371_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_374_6 = 0
			local var_374_7 = 0.575

			if var_374_6 < arg_371_1.time_ and arg_371_1.time_ <= var_374_6 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_8 = arg_371_1:FormatText(StoryNameCfg[216].name)

				arg_371_1.leftNameTxt_.text = var_374_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_9 = arg_371_1:GetWordFromCfg(1109704091)
				local var_374_10 = arg_371_1:FormatText(var_374_9.content)

				arg_371_1.text_.text = var_374_10

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_11 = 23
				local var_374_12 = utf8.len(var_374_10)
				local var_374_13 = var_374_11 <= 0 and var_374_7 or var_374_7 * (var_374_12 / var_374_11)

				if var_374_13 > 0 and var_374_7 < var_374_13 then
					arg_371_1.talkMaxDuration = var_374_13

					if var_374_13 + var_374_6 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_13 + var_374_6
					end
				end

				arg_371_1.text_.text = var_374_10
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704091", "story_v_side_new_1109704.awb") ~= 0 then
					local var_374_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704091", "story_v_side_new_1109704.awb") / 1000

					if var_374_14 + var_374_6 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_14 + var_374_6
					end

					if var_374_9.prefab_name ~= "" and arg_371_1.actors_[var_374_9.prefab_name] ~= nil then
						local var_374_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_9.prefab_name].transform, "story_v_side_new_1109704", "1109704091", "story_v_side_new_1109704.awb")

						arg_371_1:RecordAudio("1109704091", var_374_15)
						arg_371_1:RecordAudio("1109704091", var_374_15)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704091", "story_v_side_new_1109704.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704091", "story_v_side_new_1109704.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_16 = math.max(var_374_7, arg_371_1.talkMaxDuration)

			if var_374_6 <= arg_371_1.time_ and arg_371_1.time_ < var_374_6 + var_374_16 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_6) / var_374_16

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_6 + var_374_16 and arg_371_1.time_ < var_374_6 + var_374_16 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1109704092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1109704092
		arg_375_1.duration_ = 9.07

		local var_375_0 = {
			zh = 7.433,
			ja = 9.066
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1109704093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_378_2 = 0
			local var_378_3 = 0.9

			if var_378_2 < arg_375_1.time_ and arg_375_1.time_ <= var_378_2 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_4 = arg_375_1:FormatText(StoryNameCfg[216].name)

				arg_375_1.leftNameTxt_.text = var_378_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_5 = arg_375_1:GetWordFromCfg(1109704092)
				local var_378_6 = arg_375_1:FormatText(var_378_5.content)

				arg_375_1.text_.text = var_378_6

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_7 = 36
				local var_378_8 = utf8.len(var_378_6)
				local var_378_9 = var_378_7 <= 0 and var_378_3 or var_378_3 * (var_378_8 / var_378_7)

				if var_378_9 > 0 and var_378_3 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_2 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_2
					end
				end

				arg_375_1.text_.text = var_378_6
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704092", "story_v_side_new_1109704.awb") ~= 0 then
					local var_378_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704092", "story_v_side_new_1109704.awb") / 1000

					if var_378_10 + var_378_2 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_2
					end

					if var_378_5.prefab_name ~= "" and arg_375_1.actors_[var_378_5.prefab_name] ~= nil then
						local var_378_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_5.prefab_name].transform, "story_v_side_new_1109704", "1109704092", "story_v_side_new_1109704.awb")

						arg_375_1:RecordAudio("1109704092", var_378_11)
						arg_375_1:RecordAudio("1109704092", var_378_11)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704092", "story_v_side_new_1109704.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704092", "story_v_side_new_1109704.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_12 = math.max(var_378_3, arg_375_1.talkMaxDuration)

			if var_378_2 <= arg_375_1.time_ and arg_375_1.time_ < var_378_2 + var_378_12 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_2) / var_378_12

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_2 + var_378_12 and arg_375_1.time_ < var_378_2 + var_378_12 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1109704093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1109704093
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1109704094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1097ui_story"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1097ui_story == nil then
				arg_379_1.var_.characterEffect1097ui_story = var_382_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.characterEffect1097ui_story and not isNil(var_382_0) then
					local var_382_4 = Mathf.Lerp(0, 0.5, var_382_3)

					arg_379_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1097ui_story.fillRatio = var_382_4
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1097ui_story then
				local var_382_5 = 0.5

				arg_379_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1097ui_story.fillRatio = var_382_5
			end

			local var_382_6 = 0
			local var_382_7 = 1.15

			if var_382_6 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_8 = arg_379_1:GetWordFromCfg(1109704093)
				local var_382_9 = arg_379_1:FormatText(var_382_8.content)

				arg_379_1.text_.text = var_382_9

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_10 = 46
				local var_382_11 = utf8.len(var_382_9)
				local var_382_12 = var_382_10 <= 0 and var_382_7 or var_382_7 * (var_382_11 / var_382_10)

				if var_382_12 > 0 and var_382_7 < var_382_12 then
					arg_379_1.talkMaxDuration = var_382_12

					if var_382_12 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_12 + var_382_6
					end
				end

				arg_379_1.text_.text = var_382_9
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_13 = math.max(var_382_7, arg_379_1.talkMaxDuration)

			if var_382_6 <= arg_379_1.time_ and arg_379_1.time_ < var_382_6 + var_382_13 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_6) / var_382_13

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_6 + var_382_13 and arg_379_1.time_ < var_382_6 + var_382_13 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1109704094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1109704094
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1109704095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0
			local var_386_1 = 0.15

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_2 = arg_383_1:FormatText(StoryNameCfg[7].name)

				arg_383_1.leftNameTxt_.text = var_386_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_3 = arg_383_1:GetWordFromCfg(1109704094)
				local var_386_4 = arg_383_1:FormatText(var_386_3.content)

				arg_383_1.text_.text = var_386_4

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 6
				local var_386_6 = utf8.len(var_386_4)
				local var_386_7 = var_386_5 <= 0 and var_386_1 or var_386_1 * (var_386_6 / var_386_5)

				if var_386_7 > 0 and var_386_1 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_0
					end
				end

				arg_383_1.text_.text = var_386_4
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_8 = math.max(var_386_1, arg_383_1.talkMaxDuration)

			if var_386_0 <= arg_383_1.time_ and arg_383_1.time_ < var_386_0 + var_386_8 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_0) / var_386_8

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_0 + var_386_8 and arg_383_1.time_ < var_386_0 + var_386_8 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1109704095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1109704095
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1109704096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 0.975

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_2 = arg_387_1:GetWordFromCfg(1109704095)
				local var_390_3 = arg_387_1:FormatText(var_390_2.content)

				arg_387_1.text_.text = var_390_3

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_4 = 39
				local var_390_5 = utf8.len(var_390_3)
				local var_390_6 = var_390_4 <= 0 and var_390_1 or var_390_1 * (var_390_5 / var_390_4)

				if var_390_6 > 0 and var_390_1 < var_390_6 then
					arg_387_1.talkMaxDuration = var_390_6

					if var_390_6 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_6 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_3
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_7 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_7 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_7

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_7 and arg_387_1.time_ < var_390_0 + var_390_7 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1109704096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1109704096
		arg_391_1.duration_ = 4.23

		local var_391_0 = {
			zh = 3.733,
			ja = 4.233
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1109704097(arg_391_1)
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
			local var_394_7 = 0.65

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

				local var_394_9 = arg_391_1:GetWordFromCfg(1109704096)
				local var_394_10 = arg_391_1:FormatText(var_394_9.content)

				arg_391_1.text_.text = var_394_10

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_11 = 26
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704096", "story_v_side_new_1109704.awb") ~= 0 then
					local var_394_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704096", "story_v_side_new_1109704.awb") / 1000

					if var_394_14 + var_394_6 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_14 + var_394_6
					end

					if var_394_9.prefab_name ~= "" and arg_391_1.actors_[var_394_9.prefab_name] ~= nil then
						local var_394_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_9.prefab_name].transform, "story_v_side_new_1109704", "1109704096", "story_v_side_new_1109704.awb")

						arg_391_1:RecordAudio("1109704096", var_394_15)
						arg_391_1:RecordAudio("1109704096", var_394_15)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704096", "story_v_side_new_1109704.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704096", "story_v_side_new_1109704.awb")
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
	Play1109704097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1109704097
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1109704098(arg_395_1)
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
			local var_398_7 = 0.825

			if var_398_6 < arg_395_1.time_ and arg_395_1.time_ <= var_398_6 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_8 = arg_395_1:GetWordFromCfg(1109704097)
				local var_398_9 = arg_395_1:FormatText(var_398_8.content)

				arg_395_1.text_.text = var_398_9

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_10 = 33
				local var_398_11 = utf8.len(var_398_9)
				local var_398_12 = var_398_10 <= 0 and var_398_7 or var_398_7 * (var_398_11 / var_398_10)

				if var_398_12 > 0 and var_398_7 < var_398_12 then
					arg_395_1.talkMaxDuration = var_398_12

					if var_398_12 + var_398_6 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_12 + var_398_6
					end
				end

				arg_395_1.text_.text = var_398_9
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_13 = math.max(var_398_7, arg_395_1.talkMaxDuration)

			if var_398_6 <= arg_395_1.time_ and arg_395_1.time_ < var_398_6 + var_398_13 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_6) / var_398_13

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_6 + var_398_13 and arg_395_1.time_ < var_398_6 + var_398_13 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1109704098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1109704098
		arg_399_1.duration_ = 10.03

		local var_399_0 = {
			zh = 10.033,
			ja = 7.966
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1109704099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["1097ui_story"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1097ui_story == nil then
				arg_399_1.var_.characterEffect1097ui_story = var_402_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.200000002980232

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 and not isNil(var_402_0) then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2

				if arg_399_1.var_.characterEffect1097ui_story and not isNil(var_402_0) then
					arg_399_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1097ui_story then
				arg_399_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_402_4 = 0

			if var_402_4 < arg_399_1.time_ and arg_399_1.time_ <= var_402_4 + arg_402_0 then
				arg_399_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			local var_402_5 = 0

			if var_402_5 < arg_399_1.time_ and arg_399_1.time_ <= var_402_5 + arg_402_0 then
				arg_399_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_402_6 = 0
			local var_402_7 = 1.225

			if var_402_6 < arg_399_1.time_ and arg_399_1.time_ <= var_402_6 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_8 = arg_399_1:FormatText(StoryNameCfg[216].name)

				arg_399_1.leftNameTxt_.text = var_402_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_9 = arg_399_1:GetWordFromCfg(1109704098)
				local var_402_10 = arg_399_1:FormatText(var_402_9.content)

				arg_399_1.text_.text = var_402_10

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_11 = 49
				local var_402_12 = utf8.len(var_402_10)
				local var_402_13 = var_402_11 <= 0 and var_402_7 or var_402_7 * (var_402_12 / var_402_11)

				if var_402_13 > 0 and var_402_7 < var_402_13 then
					arg_399_1.talkMaxDuration = var_402_13

					if var_402_13 + var_402_6 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_13 + var_402_6
					end
				end

				arg_399_1.text_.text = var_402_10
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704098", "story_v_side_new_1109704.awb") ~= 0 then
					local var_402_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704098", "story_v_side_new_1109704.awb") / 1000

					if var_402_14 + var_402_6 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_14 + var_402_6
					end

					if var_402_9.prefab_name ~= "" and arg_399_1.actors_[var_402_9.prefab_name] ~= nil then
						local var_402_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_9.prefab_name].transform, "story_v_side_new_1109704", "1109704098", "story_v_side_new_1109704.awb")

						arg_399_1:RecordAudio("1109704098", var_402_15)
						arg_399_1:RecordAudio("1109704098", var_402_15)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704098", "story_v_side_new_1109704.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704098", "story_v_side_new_1109704.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_16 = math.max(var_402_7, arg_399_1.talkMaxDuration)

			if var_402_6 <= arg_399_1.time_ and arg_399_1.time_ < var_402_6 + var_402_16 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_6) / var_402_16

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_6 + var_402_16 and arg_399_1.time_ < var_402_6 + var_402_16 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1109704099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1109704099
		arg_403_1.duration_ = 9.17

		local var_403_0 = {
			zh = 9.166,
			ja = 7.733
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1109704100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_406_2 = 0
			local var_406_3 = 1.025

			if var_406_2 < arg_403_1.time_ and arg_403_1.time_ <= var_406_2 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_4 = arg_403_1:FormatText(StoryNameCfg[216].name)

				arg_403_1.leftNameTxt_.text = var_406_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_5 = arg_403_1:GetWordFromCfg(1109704099)
				local var_406_6 = arg_403_1:FormatText(var_406_5.content)

				arg_403_1.text_.text = var_406_6

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_7 = 35
				local var_406_8 = utf8.len(var_406_6)
				local var_406_9 = var_406_7 <= 0 and var_406_3 or var_406_3 * (var_406_8 / var_406_7)

				if var_406_9 > 0 and var_406_3 < var_406_9 then
					arg_403_1.talkMaxDuration = var_406_9

					if var_406_9 + var_406_2 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_9 + var_406_2
					end
				end

				arg_403_1.text_.text = var_406_6
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704099", "story_v_side_new_1109704.awb") ~= 0 then
					local var_406_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704099", "story_v_side_new_1109704.awb") / 1000

					if var_406_10 + var_406_2 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_10 + var_406_2
					end

					if var_406_5.prefab_name ~= "" and arg_403_1.actors_[var_406_5.prefab_name] ~= nil then
						local var_406_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_5.prefab_name].transform, "story_v_side_new_1109704", "1109704099", "story_v_side_new_1109704.awb")

						arg_403_1:RecordAudio("1109704099", var_406_11)
						arg_403_1:RecordAudio("1109704099", var_406_11)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704099", "story_v_side_new_1109704.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704099", "story_v_side_new_1109704.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_12 = math.max(var_406_3, arg_403_1.talkMaxDuration)

			if var_406_2 <= arg_403_1.time_ and arg_403_1.time_ < var_406_2 + var_406_12 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_2) / var_406_12

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_2 + var_406_12 and arg_403_1.time_ < var_406_2 + var_406_12 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1109704100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1109704100
		arg_407_1.duration_ = 7.9

		local var_407_0 = {
			zh = 7.9,
			ja = 5.933
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1109704101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_410_2 = 0
			local var_410_3 = 1.1

			if var_410_2 < arg_407_1.time_ and arg_407_1.time_ <= var_410_2 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_4 = arg_407_1:FormatText(StoryNameCfg[216].name)

				arg_407_1.leftNameTxt_.text = var_410_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_5 = arg_407_1:GetWordFromCfg(1109704100)
				local var_410_6 = arg_407_1:FormatText(var_410_5.content)

				arg_407_1.text_.text = var_410_6

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_7 = 44
				local var_410_8 = utf8.len(var_410_6)
				local var_410_9 = var_410_7 <= 0 and var_410_3 or var_410_3 * (var_410_8 / var_410_7)

				if var_410_9 > 0 and var_410_3 < var_410_9 then
					arg_407_1.talkMaxDuration = var_410_9

					if var_410_9 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_9 + var_410_2
					end
				end

				arg_407_1.text_.text = var_410_6
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704100", "story_v_side_new_1109704.awb") ~= 0 then
					local var_410_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704100", "story_v_side_new_1109704.awb") / 1000

					if var_410_10 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_10 + var_410_2
					end

					if var_410_5.prefab_name ~= "" and arg_407_1.actors_[var_410_5.prefab_name] ~= nil then
						local var_410_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_5.prefab_name].transform, "story_v_side_new_1109704", "1109704100", "story_v_side_new_1109704.awb")

						arg_407_1:RecordAudio("1109704100", var_410_11)
						arg_407_1:RecordAudio("1109704100", var_410_11)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704100", "story_v_side_new_1109704.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704100", "story_v_side_new_1109704.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_12 = math.max(var_410_3, arg_407_1.talkMaxDuration)

			if var_410_2 <= arg_407_1.time_ and arg_407_1.time_ < var_410_2 + var_410_12 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_2) / var_410_12

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_2 + var_410_12 and arg_407_1.time_ < var_410_2 + var_410_12 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1109704101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1109704101
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1109704102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1097ui_story"]
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1097ui_story == nil then
				arg_411_1.var_.characterEffect1097ui_story = var_414_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.200000002980232

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 and not isNil(var_414_0) then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2

				if arg_411_1.var_.characterEffect1097ui_story and not isNil(var_414_0) then
					local var_414_4 = Mathf.Lerp(0, 0.5, var_414_3)

					arg_411_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1097ui_story.fillRatio = var_414_4
				end
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1097ui_story then
				local var_414_5 = 0.5

				arg_411_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1097ui_story.fillRatio = var_414_5
			end

			local var_414_6 = 0
			local var_414_7 = 0.05

			if var_414_6 < arg_411_1.time_ and arg_411_1.time_ <= var_414_6 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_8 = arg_411_1:FormatText(StoryNameCfg[7].name)

				arg_411_1.leftNameTxt_.text = var_414_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_9 = arg_411_1:GetWordFromCfg(1109704101)
				local var_414_10 = arg_411_1:FormatText(var_414_9.content)

				arg_411_1.text_.text = var_414_10

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_11 = 2
				local var_414_12 = utf8.len(var_414_10)
				local var_414_13 = var_414_11 <= 0 and var_414_7 or var_414_7 * (var_414_12 / var_414_11)

				if var_414_13 > 0 and var_414_7 < var_414_13 then
					arg_411_1.talkMaxDuration = var_414_13

					if var_414_13 + var_414_6 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_13 + var_414_6
					end
				end

				arg_411_1.text_.text = var_414_10
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_14 = math.max(var_414_7, arg_411_1.talkMaxDuration)

			if var_414_6 <= arg_411_1.time_ and arg_411_1.time_ < var_414_6 + var_414_14 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_6) / var_414_14

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_6 + var_414_14 and arg_411_1.time_ < var_414_6 + var_414_14 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1109704102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1109704102
		arg_415_1.duration_ = 7.23

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1109704103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.5

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				local var_418_1 = manager.ui.mainCamera.transform.localPosition
				local var_418_2 = Vector3.New(0, 0, 10) + Vector3.New(var_418_1.x, var_418_1.y, 0)
				local var_418_3 = arg_415_1.bgs_.STwhite

				var_418_3.transform.localPosition = var_418_2
				var_418_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_418_4 = var_418_3:GetComponent("SpriteRenderer")

				if var_418_4 and var_418_4.sprite then
					local var_418_5 = (var_418_3.transform.localPosition - var_418_1).z
					local var_418_6 = manager.ui.mainCameraCom_
					local var_418_7 = 2 * var_418_5 * Mathf.Tan(var_418_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_418_8 = var_418_7 * var_418_6.aspect
					local var_418_9 = var_418_4.sprite.bounds.size.x
					local var_418_10 = var_418_4.sprite.bounds.size.y
					local var_418_11 = var_418_8 / var_418_9
					local var_418_12 = var_418_7 / var_418_10
					local var_418_13 = var_418_12 < var_418_11 and var_418_11 or var_418_12

					var_418_3.transform.localScale = Vector3.New(var_418_13, var_418_13, 0)
				end

				for iter_418_0, iter_418_1 in pairs(arg_415_1.bgs_) do
					if iter_418_0 ~= "STwhite" then
						iter_418_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_418_14 = 2.233332999999

			if var_418_14 < arg_415_1.time_ and arg_415_1.time_ <= var_418_14 + arg_418_0 then
				arg_415_1.allBtn_.enabled = false
			end

			local var_418_15 = 0.3

			if arg_415_1.time_ >= var_418_14 + var_418_15 and arg_415_1.time_ < var_418_14 + var_418_15 + arg_418_0 then
				arg_415_1.allBtn_.enabled = true
			end

			local var_418_16 = 0.5

			if var_418_16 < arg_415_1.time_ and arg_415_1.time_ <= var_418_16 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_17 = 2.033333

			if var_418_16 <= arg_415_1.time_ and arg_415_1.time_ < var_418_16 + var_418_17 then
				local var_418_18 = (arg_415_1.time_ - var_418_16) / var_418_17
				local var_418_19 = Color.New(1, 1, 1)

				var_418_19.a = Mathf.Lerp(1, 0, var_418_18)
				arg_415_1.mask_.color = var_418_19
			end

			if arg_415_1.time_ >= var_418_16 + var_418_17 and arg_415_1.time_ < var_418_16 + var_418_17 + arg_418_0 then
				local var_418_20 = Color.New(1, 1, 1)
				local var_418_21 = 0

				arg_415_1.mask_.enabled = false
				var_418_20.a = var_418_21
				arg_415_1.mask_.color = var_418_20
			end

			local var_418_22 = arg_415_1.actors_["1097ui_story"].transform
			local var_418_23 = 0.5

			if var_418_23 < arg_415_1.time_ and arg_415_1.time_ <= var_418_23 + arg_418_0 then
				arg_415_1.var_.moveOldPos1097ui_story = var_418_22.localPosition
			end

			local var_418_24 = 0.001

			if var_418_23 <= arg_415_1.time_ and arg_415_1.time_ < var_418_23 + var_418_24 then
				local var_418_25 = (arg_415_1.time_ - var_418_23) / var_418_24
				local var_418_26 = Vector3.New(0, 100, 0)

				var_418_22.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1097ui_story, var_418_26, var_418_25)

				local var_418_27 = manager.ui.mainCamera.transform.position - var_418_22.position

				var_418_22.forward = Vector3.New(var_418_27.x, var_418_27.y, var_418_27.z)

				local var_418_28 = var_418_22.localEulerAngles

				var_418_28.z = 0
				var_418_28.x = 0
				var_418_22.localEulerAngles = var_418_28
			end

			if arg_415_1.time_ >= var_418_23 + var_418_24 and arg_415_1.time_ < var_418_23 + var_418_24 + arg_418_0 then
				var_418_22.localPosition = Vector3.New(0, 100, 0)

				local var_418_29 = manager.ui.mainCamera.transform.position - var_418_22.position

				var_418_22.forward = Vector3.New(var_418_29.x, var_418_29.y, var_418_29.z)

				local var_418_30 = var_418_22.localEulerAngles

				var_418_30.z = 0
				var_418_30.x = 0
				var_418_22.localEulerAngles = var_418_30
			end

			local var_418_31 = arg_415_1.actors_["1097ui_story"]
			local var_418_32 = 0.5

			if var_418_32 < arg_415_1.time_ and arg_415_1.time_ <= var_418_32 + arg_418_0 and not isNil(var_418_31) and arg_415_1.var_.characterEffect1097ui_story == nil then
				arg_415_1.var_.characterEffect1097ui_story = var_418_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_33 = 0.034000001847744

			if var_418_32 <= arg_415_1.time_ and arg_415_1.time_ < var_418_32 + var_418_33 and not isNil(var_418_31) then
				local var_418_34 = (arg_415_1.time_ - var_418_32) / var_418_33

				if arg_415_1.var_.characterEffect1097ui_story and not isNil(var_418_31) then
					local var_418_35 = Mathf.Lerp(0, 0.5, var_418_34)

					arg_415_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_415_1.var_.characterEffect1097ui_story.fillRatio = var_418_35
				end
			end

			if arg_415_1.time_ >= var_418_32 + var_418_33 and arg_415_1.time_ < var_418_32 + var_418_33 + arg_418_0 and not isNil(var_418_31) and arg_415_1.var_.characterEffect1097ui_story then
				local var_418_36 = 0.5

				arg_415_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_415_1.var_.characterEffect1097ui_story.fillRatio = var_418_36
			end

			if arg_415_1.frameCnt_ <= 1 then
				arg_415_1.dialog_:SetActive(false)
			end

			local var_418_37 = 2.233332999999
			local var_418_38 = 0.625

			if var_418_37 < arg_415_1.time_ and arg_415_1.time_ <= var_418_37 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				arg_415_1.dialog_:SetActive(true)

				arg_415_1.dialogCg_.alpha = 0

				local var_418_39 = LeanTween.value(arg_415_1.dialog_, 0, 1, 0.3)

				var_418_39:setOnUpdate(LuaHelper.FloatAction(function(arg_419_0)
					arg_415_1.dialogCg_.alpha = arg_419_0
				end))
				var_418_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_415_1.dialog_)
					var_418_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_415_1.duration_ = arg_415_1.duration_ + 0.3

				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_40 = arg_415_1:GetWordFromCfg(1109704102)
				local var_418_41 = arg_415_1:FormatText(var_418_40.content)

				arg_415_1.text_.text = var_418_41

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_42 = 25
				local var_418_43 = utf8.len(var_418_41)
				local var_418_44 = var_418_42 <= 0 and var_418_38 or var_418_38 * (var_418_43 / var_418_42)

				if var_418_44 > 0 and var_418_38 < var_418_44 then
					arg_415_1.talkMaxDuration = var_418_44
					var_418_37 = var_418_37 + 0.3

					if var_418_44 + var_418_37 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_44 + var_418_37
					end
				end

				arg_415_1.text_.text = var_418_41
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_45 = var_418_37 + 0.3
			local var_418_46 = math.max(var_418_38, arg_415_1.talkMaxDuration)

			if var_418_45 <= arg_415_1.time_ and arg_415_1.time_ < var_418_45 + var_418_46 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_45) / var_418_46

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_45 + var_418_46 and arg_415_1.time_ < var_418_45 + var_418_46 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play1109704103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1109704103
		arg_421_1.duration_ = 9

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1109704104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = "R9701"

			if arg_421_1.bgs_[var_424_0] == nil then
				local var_424_1 = Object.Instantiate(arg_421_1.paintGo_)

				var_424_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_424_0)
				var_424_1.name = var_424_0
				var_424_1.transform.parent = arg_421_1.stage_.transform
				var_424_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_421_1.bgs_[var_424_0] = var_424_1
			end

			local var_424_2 = 1.83333333333333

			if var_424_2 < arg_421_1.time_ and arg_421_1.time_ <= var_424_2 + arg_424_0 then
				local var_424_3 = manager.ui.mainCamera.transform.localPosition
				local var_424_4 = Vector3.New(0, 0, 10) + Vector3.New(var_424_3.x, var_424_3.y, 0)
				local var_424_5 = arg_421_1.bgs_.R9701

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
					if iter_424_0 ~= "R9701" then
						iter_424_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_424_16 = 4

			if var_424_16 < arg_421_1.time_ and arg_421_1.time_ <= var_424_16 + arg_424_0 then
				arg_421_1.allBtn_.enabled = false
			end

			local var_424_17 = 0.3

			if arg_421_1.time_ >= var_424_16 + var_424_17 and arg_421_1.time_ < var_424_16 + var_424_17 + arg_424_0 then
				arg_421_1.allBtn_.enabled = true
			end

			local var_424_18 = 0

			if var_424_18 < arg_421_1.time_ and arg_421_1.time_ <= var_424_18 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_19 = 2

			if var_424_18 <= arg_421_1.time_ and arg_421_1.time_ < var_424_18 + var_424_19 then
				local var_424_20 = (arg_421_1.time_ - var_424_18) / var_424_19
				local var_424_21 = Color.New(0, 0, 0)

				var_424_21.a = Mathf.Lerp(0, 1, var_424_20)
				arg_421_1.mask_.color = var_424_21
			end

			if arg_421_1.time_ >= var_424_18 + var_424_19 and arg_421_1.time_ < var_424_18 + var_424_19 + arg_424_0 then
				local var_424_22 = Color.New(0, 0, 0)

				var_424_22.a = 1
				arg_421_1.mask_.color = var_424_22
			end

			local var_424_23 = 2

			if var_424_23 < arg_421_1.time_ and arg_421_1.time_ <= var_424_23 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_24 = 2

			if var_424_23 <= arg_421_1.time_ and arg_421_1.time_ < var_424_23 + var_424_24 then
				local var_424_25 = (arg_421_1.time_ - var_424_23) / var_424_24
				local var_424_26 = Color.New(0, 0, 0)

				var_424_26.a = Mathf.Lerp(1, 0, var_424_25)
				arg_421_1.mask_.color = var_424_26
			end

			if arg_421_1.time_ >= var_424_23 + var_424_24 and arg_421_1.time_ < var_424_23 + var_424_24 + arg_424_0 then
				local var_424_27 = Color.New(0, 0, 0)
				local var_424_28 = 0

				arg_421_1.mask_.enabled = false
				var_424_27.a = var_424_28
				arg_421_1.mask_.color = var_424_27
			end

			local var_424_29 = arg_421_1.actors_["1097ui_story"].transform
			local var_424_30 = 1.96599999815226

			if var_424_30 < arg_421_1.time_ and arg_421_1.time_ <= var_424_30 + arg_424_0 then
				arg_421_1.var_.moveOldPos1097ui_story = var_424_29.localPosition
			end

			local var_424_31 = 0.001

			if var_424_30 <= arg_421_1.time_ and arg_421_1.time_ < var_424_30 + var_424_31 then
				local var_424_32 = (arg_421_1.time_ - var_424_30) / var_424_31
				local var_424_33 = Vector3.New(0, 100, 0)

				var_424_29.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1097ui_story, var_424_33, var_424_32)

				local var_424_34 = manager.ui.mainCamera.transform.position - var_424_29.position

				var_424_29.forward = Vector3.New(var_424_34.x, var_424_34.y, var_424_34.z)

				local var_424_35 = var_424_29.localEulerAngles

				var_424_35.z = 0
				var_424_35.x = 0
				var_424_29.localEulerAngles = var_424_35
			end

			if arg_421_1.time_ >= var_424_30 + var_424_31 and arg_421_1.time_ < var_424_30 + var_424_31 + arg_424_0 then
				var_424_29.localPosition = Vector3.New(0, 100, 0)

				local var_424_36 = manager.ui.mainCamera.transform.position - var_424_29.position

				var_424_29.forward = Vector3.New(var_424_36.x, var_424_36.y, var_424_36.z)

				local var_424_37 = var_424_29.localEulerAngles

				var_424_37.z = 0
				var_424_37.x = 0
				var_424_29.localEulerAngles = var_424_37
			end

			local var_424_38 = arg_421_1.actors_["1097ui_story"]
			local var_424_39 = 1.96599999815226

			if var_424_39 < arg_421_1.time_ and arg_421_1.time_ <= var_424_39 + arg_424_0 and not isNil(var_424_38) and arg_421_1.var_.characterEffect1097ui_story == nil then
				arg_421_1.var_.characterEffect1097ui_story = var_424_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_40 = 0.034000001847744

			if var_424_39 <= arg_421_1.time_ and arg_421_1.time_ < var_424_39 + var_424_40 and not isNil(var_424_38) then
				local var_424_41 = (arg_421_1.time_ - var_424_39) / var_424_40

				if arg_421_1.var_.characterEffect1097ui_story and not isNil(var_424_38) then
					local var_424_42 = Mathf.Lerp(0, 0.5, var_424_41)

					arg_421_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1097ui_story.fillRatio = var_424_42
				end
			end

			if arg_421_1.time_ >= var_424_39 + var_424_40 and arg_421_1.time_ < var_424_39 + var_424_40 + arg_424_0 and not isNil(var_424_38) and arg_421_1.var_.characterEffect1097ui_story then
				local var_424_43 = 0.5

				arg_421_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1097ui_story.fillRatio = var_424_43
			end

			local var_424_44 = arg_421_1.bgs_.R9701.transform
			local var_424_45 = 2

			if var_424_45 < arg_421_1.time_ and arg_421_1.time_ <= var_424_45 + arg_424_0 then
				arg_421_1.var_.moveOldPosR9701 = var_424_44.localPosition
			end

			local var_424_46 = 0.001

			if var_424_45 <= arg_421_1.time_ and arg_421_1.time_ < var_424_45 + var_424_46 then
				local var_424_47 = (arg_421_1.time_ - var_424_45) / var_424_46
				local var_424_48 = Vector3.New(-1, 0.7, 3.6)

				var_424_44.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPosR9701, var_424_48, var_424_47)
			end

			if arg_421_1.time_ >= var_424_45 + var_424_46 and arg_421_1.time_ < var_424_45 + var_424_46 + arg_424_0 then
				var_424_44.localPosition = Vector3.New(-1, 0.7, 3.6)
			end

			local var_424_49 = arg_421_1.bgs_.R9701.transform
			local var_424_50 = 2.01666666666667

			if var_424_50 < arg_421_1.time_ and arg_421_1.time_ <= var_424_50 + arg_424_0 then
				arg_421_1.var_.moveOldPosR9701 = var_424_49.localPosition
			end

			local var_424_51 = 3.6

			if var_424_50 <= arg_421_1.time_ and arg_421_1.time_ < var_424_50 + var_424_51 then
				local var_424_52 = (arg_421_1.time_ - var_424_50) / var_424_51
				local var_424_53 = Vector3.New(-1, 0.2, 3.6)

				var_424_49.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPosR9701, var_424_53, var_424_52)
			end

			if arg_421_1.time_ >= var_424_50 + var_424_51 and arg_421_1.time_ < var_424_50 + var_424_51 + arg_424_0 then
				var_424_49.localPosition = Vector3.New(-1, 0.2, 3.6)
			end

			local var_424_54 = 4

			if var_424_54 < arg_421_1.time_ and arg_421_1.time_ <= var_424_54 + arg_424_0 then
				arg_421_1.allBtn_.enabled = false
			end

			local var_424_55 = 1.61666666666667

			if arg_421_1.time_ >= var_424_54 + var_424_55 and arg_421_1.time_ < var_424_54 + var_424_55 + arg_424_0 then
				arg_421_1.allBtn_.enabled = true
			end

			if arg_421_1.frameCnt_ <= 1 then
				arg_421_1.dialog_:SetActive(false)
			end

			local var_424_56 = 4.00000000298023
			local var_424_57 = 0.225

			if var_424_56 < arg_421_1.time_ and arg_421_1.time_ <= var_424_56 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0

				arg_421_1.dialog_:SetActive(true)

				arg_421_1.dialogCg_.alpha = 0

				local var_424_58 = LeanTween.value(arg_421_1.dialog_, 0, 1, 0.3)

				var_424_58:setOnUpdate(LuaHelper.FloatAction(function(arg_425_0)
					arg_421_1.dialogCg_.alpha = arg_425_0
				end))
				var_424_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_421_1.dialog_)
					var_424_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_421_1.duration_ = arg_421_1.duration_ + 0.3

				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_59 = arg_421_1:FormatText(StoryNameCfg[7].name)

				arg_421_1.leftNameTxt_.text = var_424_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_60 = arg_421_1:GetWordFromCfg(1109704103)
				local var_424_61 = arg_421_1:FormatText(var_424_60.content)

				arg_421_1.text_.text = var_424_61

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_62 = 9
				local var_424_63 = utf8.len(var_424_61)
				local var_424_64 = var_424_62 <= 0 and var_424_57 or var_424_57 * (var_424_63 / var_424_62)

				if var_424_64 > 0 and var_424_57 < var_424_64 then
					arg_421_1.talkMaxDuration = var_424_64
					var_424_56 = var_424_56 + 0.3

					if var_424_64 + var_424_56 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_64 + var_424_56
					end
				end

				arg_421_1.text_.text = var_424_61
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_65 = var_424_56 + 0.3
			local var_424_66 = math.max(var_424_57, arg_421_1.talkMaxDuration)

			if var_424_65 <= arg_421_1.time_ and arg_421_1.time_ < var_424_65 + var_424_66 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_65) / var_424_66

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_65 + var_424_66 and arg_421_1.time_ < var_424_65 + var_424_66 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
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
				actorName = "R9701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R9701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.6,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play1109704104 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1109704104
		arg_427_1.duration_ = 4.4

		local var_427_0 = {
			zh = 4.4,
			ja = 4.366
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1109704105(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0
			local var_430_1 = 0.575

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_2 = arg_427_1:FormatText(StoryNameCfg[216].name)

				arg_427_1.leftNameTxt_.text = var_430_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_3 = arg_427_1:GetWordFromCfg(1109704104)
				local var_430_4 = arg_427_1:FormatText(var_430_3.content)

				arg_427_1.text_.text = var_430_4

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 23
				local var_430_6 = utf8.len(var_430_4)
				local var_430_7 = var_430_5 <= 0 and var_430_1 or var_430_1 * (var_430_6 / var_430_5)

				if var_430_7 > 0 and var_430_1 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_0
					end
				end

				arg_427_1.text_.text = var_430_4
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704104", "story_v_side_new_1109704.awb") ~= 0 then
					local var_430_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704104", "story_v_side_new_1109704.awb") / 1000

					if var_430_8 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_8 + var_430_0
					end

					if var_430_3.prefab_name ~= "" and arg_427_1.actors_[var_430_3.prefab_name] ~= nil then
						local var_430_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_3.prefab_name].transform, "story_v_side_new_1109704", "1109704104", "story_v_side_new_1109704.awb")

						arg_427_1:RecordAudio("1109704104", var_430_9)
						arg_427_1:RecordAudio("1109704104", var_430_9)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704104", "story_v_side_new_1109704.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704104", "story_v_side_new_1109704.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_10 = math.max(var_430_1, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_10 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_0) / var_430_10

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_10 and arg_427_1.time_ < var_430_0 + var_430_10 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1109704105 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1109704105
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1109704106(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1097ui_story"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1097ui_story == nil then
				arg_431_1.var_.characterEffect1097ui_story = var_434_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.200000002980232

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 and not isNil(var_434_0) then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.characterEffect1097ui_story and not isNil(var_434_0) then
					local var_434_4 = Mathf.Lerp(0, 0.5, var_434_3)

					arg_431_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1097ui_story.fillRatio = var_434_4
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1097ui_story then
				local var_434_5 = 0.5

				arg_431_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1097ui_story.fillRatio = var_434_5
			end

			local var_434_6 = 0
			local var_434_7 = 0.8

			if var_434_6 < arg_431_1.time_ and arg_431_1.time_ <= var_434_6 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_8 = arg_431_1:FormatText(StoryNameCfg[7].name)

				arg_431_1.leftNameTxt_.text = var_434_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_9 = arg_431_1:GetWordFromCfg(1109704105)
				local var_434_10 = arg_431_1:FormatText(var_434_9.content)

				arg_431_1.text_.text = var_434_10

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_11 = 32
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
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_14 = math.max(var_434_7, arg_431_1.talkMaxDuration)

			if var_434_6 <= arg_431_1.time_ and arg_431_1.time_ < var_434_6 + var_434_14 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_6) / var_434_14

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_6 + var_434_14 and arg_431_1.time_ < var_434_6 + var_434_14 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1109704106 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1109704106
		arg_435_1.duration_ = 4.13

		local var_435_0 = {
			zh = 3.466,
			ja = 4.133
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1109704107(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0
			local var_438_1 = 0.475

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_2 = arg_435_1:FormatText(StoryNameCfg[216].name)

				arg_435_1.leftNameTxt_.text = var_438_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_3 = arg_435_1:GetWordFromCfg(1109704106)
				local var_438_4 = arg_435_1:FormatText(var_438_3.content)

				arg_435_1.text_.text = var_438_4

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 19
				local var_438_6 = utf8.len(var_438_4)
				local var_438_7 = var_438_5 <= 0 and var_438_1 or var_438_1 * (var_438_6 / var_438_5)

				if var_438_7 > 0 and var_438_1 < var_438_7 then
					arg_435_1.talkMaxDuration = var_438_7

					if var_438_7 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_7 + var_438_0
					end
				end

				arg_435_1.text_.text = var_438_4
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704106", "story_v_side_new_1109704.awb") ~= 0 then
					local var_438_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704106", "story_v_side_new_1109704.awb") / 1000

					if var_438_8 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_8 + var_438_0
					end

					if var_438_3.prefab_name ~= "" and arg_435_1.actors_[var_438_3.prefab_name] ~= nil then
						local var_438_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_3.prefab_name].transform, "story_v_side_new_1109704", "1109704106", "story_v_side_new_1109704.awb")

						arg_435_1:RecordAudio("1109704106", var_438_9)
						arg_435_1:RecordAudio("1109704106", var_438_9)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704106", "story_v_side_new_1109704.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704106", "story_v_side_new_1109704.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_10 = math.max(var_438_1, arg_435_1.talkMaxDuration)

			if var_438_0 <= arg_435_1.time_ and arg_435_1.time_ < var_438_0 + var_438_10 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_0) / var_438_10

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_0 + var_438_10 and arg_435_1.time_ < var_438_0 + var_438_10 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1109704107 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1109704107
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1109704108(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 0.65

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_2 = arg_439_1:FormatText(StoryNameCfg[7].name)

				arg_439_1.leftNameTxt_.text = var_442_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_3 = arg_439_1:GetWordFromCfg(1109704107)
				local var_442_4 = arg_439_1:FormatText(var_442_3.content)

				arg_439_1.text_.text = var_442_4

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 26
				local var_442_6 = utf8.len(var_442_4)
				local var_442_7 = var_442_5 <= 0 and var_442_1 or var_442_1 * (var_442_6 / var_442_5)

				if var_442_7 > 0 and var_442_1 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_4
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_8 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_8 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_8

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_8 and arg_439_1.time_ < var_442_0 + var_442_8 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1109704108 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1109704108
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1109704109(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0
			local var_446_1 = 0.675

			if var_446_0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_2 = arg_443_1:GetWordFromCfg(1109704108)
				local var_446_3 = arg_443_1:FormatText(var_446_2.content)

				arg_443_1.text_.text = var_446_3

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_4 = 27
				local var_446_5 = utf8.len(var_446_3)
				local var_446_6 = var_446_4 <= 0 and var_446_1 or var_446_1 * (var_446_5 / var_446_4)

				if var_446_6 > 0 and var_446_1 < var_446_6 then
					arg_443_1.talkMaxDuration = var_446_6

					if var_446_6 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_6 + var_446_0
					end
				end

				arg_443_1.text_.text = var_446_3
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_7 = math.max(var_446_1, arg_443_1.talkMaxDuration)

			if var_446_0 <= arg_443_1.time_ and arg_443_1.time_ < var_446_0 + var_446_7 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_0) / var_446_7

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_0 + var_446_7 and arg_443_1.time_ < var_446_0 + var_446_7 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play1109704109 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1109704109
		arg_447_1.duration_ = 3.4

		local var_447_0 = {
			zh = 1.2,
			ja = 3.4
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1109704110(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0
			local var_450_1 = 0.05

			if var_450_0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_2 = arg_447_1:FormatText(StoryNameCfg[216].name)

				arg_447_1.leftNameTxt_.text = var_450_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_3 = arg_447_1:GetWordFromCfg(1109704109)
				local var_450_4 = arg_447_1:FormatText(var_450_3.content)

				arg_447_1.text_.text = var_450_4

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_5 = 2
				local var_450_6 = utf8.len(var_450_4)
				local var_450_7 = var_450_5 <= 0 and var_450_1 or var_450_1 * (var_450_6 / var_450_5)

				if var_450_7 > 0 and var_450_1 < var_450_7 then
					arg_447_1.talkMaxDuration = var_450_7

					if var_450_7 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_7 + var_450_0
					end
				end

				arg_447_1.text_.text = var_450_4
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704109", "story_v_side_new_1109704.awb") ~= 0 then
					local var_450_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704109", "story_v_side_new_1109704.awb") / 1000

					if var_450_8 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_8 + var_450_0
					end

					if var_450_3.prefab_name ~= "" and arg_447_1.actors_[var_450_3.prefab_name] ~= nil then
						local var_450_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_3.prefab_name].transform, "story_v_side_new_1109704", "1109704109", "story_v_side_new_1109704.awb")

						arg_447_1:RecordAudio("1109704109", var_450_9)
						arg_447_1:RecordAudio("1109704109", var_450_9)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704109", "story_v_side_new_1109704.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704109", "story_v_side_new_1109704.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_10 = math.max(var_450_1, arg_447_1.talkMaxDuration)

			if var_450_0 <= arg_447_1.time_ and arg_447_1.time_ < var_450_0 + var_450_10 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_0) / var_450_10

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_0 + var_450_10 and arg_447_1.time_ < var_450_0 + var_450_10 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play1109704110 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1109704110
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1109704111(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["1097ui_story"]
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.characterEffect1097ui_story == nil then
				arg_451_1.var_.characterEffect1097ui_story = var_454_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_2 = 0.200000002980232

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 and not isNil(var_454_0) then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2

				if arg_451_1.var_.characterEffect1097ui_story and not isNil(var_454_0) then
					local var_454_4 = Mathf.Lerp(0, 0.5, var_454_3)

					arg_451_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1097ui_story.fillRatio = var_454_4
				end
			end

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.characterEffect1097ui_story then
				local var_454_5 = 0.5

				arg_451_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1097ui_story.fillRatio = var_454_5
			end

			local var_454_6 = 0
			local var_454_7 = 0.175

			if var_454_6 < arg_451_1.time_ and arg_451_1.time_ <= var_454_6 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_8 = arg_451_1:FormatText(StoryNameCfg[7].name)

				arg_451_1.leftNameTxt_.text = var_454_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_9 = arg_451_1:GetWordFromCfg(1109704110)
				local var_454_10 = arg_451_1:FormatText(var_454_9.content)

				arg_451_1.text_.text = var_454_10

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_11 = 7
				local var_454_12 = utf8.len(var_454_10)
				local var_454_13 = var_454_11 <= 0 and var_454_7 or var_454_7 * (var_454_12 / var_454_11)

				if var_454_13 > 0 and var_454_7 < var_454_13 then
					arg_451_1.talkMaxDuration = var_454_13

					if var_454_13 + var_454_6 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_13 + var_454_6
					end
				end

				arg_451_1.text_.text = var_454_10
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_14 = math.max(var_454_7, arg_451_1.talkMaxDuration)

			if var_454_6 <= arg_451_1.time_ and arg_451_1.time_ < var_454_6 + var_454_14 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_6) / var_454_14

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_6 + var_454_14 and arg_451_1.time_ < var_454_6 + var_454_14 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play1109704111 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1109704111
		arg_455_1.duration_ = 2.6

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1109704112(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.bgs_.R9701.transform
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.var_.moveOldPosR9701 = var_458_0.localPosition
			end

			local var_458_2 = 0.001

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2
				local var_458_4 = Vector3.New(-1.5, -1.5, 1)

				var_458_0.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPosR9701, var_458_4, var_458_3)
			end

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 then
				var_458_0.localPosition = Vector3.New(-1.5, -1.5, 1)
			end

			local var_458_5 = arg_455_1.bgs_.R9701.transform
			local var_458_6 = 0.0166666666666666

			if var_458_6 < arg_455_1.time_ and arg_455_1.time_ <= var_458_6 + arg_458_0 then
				arg_455_1.var_.moveOldPosR9701 = var_458_5.localPosition
			end

			local var_458_7 = 2.583334

			if var_458_6 <= arg_455_1.time_ and arg_455_1.time_ < var_458_6 + var_458_7 then
				local var_458_8 = (arg_455_1.time_ - var_458_6) / var_458_7
				local var_458_9 = Vector3.New(-1.5, -1.5, 0.5)

				var_458_5.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPosR9701, var_458_9, var_458_8)
			end

			if arg_455_1.time_ >= var_458_6 + var_458_7 and arg_455_1.time_ < var_458_6 + var_458_7 + arg_458_0 then
				var_458_5.localPosition = Vector3.New(-1.5, -1.5, 0.5)
			end

			local var_458_10 = 0

			if var_458_10 < arg_455_1.time_ and arg_455_1.time_ <= var_458_10 + arg_458_0 then
				arg_455_1.mask_.enabled = true
				arg_455_1.mask_.raycastTarget = true

				arg_455_1:SetGaussion(false)
			end

			local var_458_11 = 0.5

			if var_458_10 <= arg_455_1.time_ and arg_455_1.time_ < var_458_10 + var_458_11 then
				local var_458_12 = (arg_455_1.time_ - var_458_10) / var_458_11
				local var_458_13 = Color.New(0, 0, 0)

				var_458_13.a = Mathf.Lerp(0, 1, var_458_12)
				arg_455_1.mask_.color = var_458_13
			end

			if arg_455_1.time_ >= var_458_10 + var_458_11 and arg_455_1.time_ < var_458_10 + var_458_11 + arg_458_0 then
				local var_458_14 = Color.New(0, 0, 0)

				var_458_14.a = 1
				arg_455_1.mask_.color = var_458_14
			end

			local var_458_15 = 0.5

			if var_458_15 < arg_455_1.time_ and arg_455_1.time_ <= var_458_15 + arg_458_0 then
				arg_455_1.mask_.enabled = true
				arg_455_1.mask_.raycastTarget = true

				arg_455_1:SetGaussion(false)
			end

			local var_458_16 = 0.5

			if var_458_15 <= arg_455_1.time_ and arg_455_1.time_ < var_458_15 + var_458_16 then
				local var_458_17 = (arg_455_1.time_ - var_458_15) / var_458_16
				local var_458_18 = Color.New(0, 0, 0)

				var_458_18.a = Mathf.Lerp(1, 0, var_458_17)
				arg_455_1.mask_.color = var_458_18
			end

			if arg_455_1.time_ >= var_458_15 + var_458_16 and arg_455_1.time_ < var_458_15 + var_458_16 + arg_458_0 then
				local var_458_19 = Color.New(0, 0, 0)
				local var_458_20 = 0

				arg_455_1.mask_.enabled = false
				var_458_19.a = var_458_20
				arg_455_1.mask_.color = var_458_19
			end

			local var_458_21 = 1

			if var_458_21 < arg_455_1.time_ and arg_455_1.time_ <= var_458_21 + arg_458_0 then
				arg_455_1.allBtn_.enabled = false
			end

			local var_458_22 = 1.60000066666667

			if arg_455_1.time_ >= var_458_21 + var_458_22 and arg_455_1.time_ < var_458_21 + var_458_22 + arg_458_0 then
				arg_455_1.allBtn_.enabled = true
			end

			local var_458_23 = 0.9
			local var_458_24 = 0.1

			if var_458_23 < arg_455_1.time_ and arg_455_1.time_ <= var_458_23 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_25 = arg_455_1:FormatText(StoryNameCfg[216].name)

				arg_455_1.leftNameTxt_.text = var_458_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_26 = arg_455_1:GetWordFromCfg(1109704111)
				local var_458_27 = arg_455_1:FormatText(var_458_26.content)

				arg_455_1.text_.text = var_458_27

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_28 = 4
				local var_458_29 = utf8.len(var_458_27)
				local var_458_30 = var_458_28 <= 0 and var_458_24 or var_458_24 * (var_458_29 / var_458_28)

				if var_458_30 > 0 and var_458_24 < var_458_30 then
					arg_455_1.talkMaxDuration = var_458_30

					if var_458_30 + var_458_23 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_30 + var_458_23
					end
				end

				arg_455_1.text_.text = var_458_27
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704111", "story_v_side_new_1109704.awb") ~= 0 then
					local var_458_31 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704111", "story_v_side_new_1109704.awb") / 1000

					if var_458_31 + var_458_23 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_31 + var_458_23
					end

					if var_458_26.prefab_name ~= "" and arg_455_1.actors_[var_458_26.prefab_name] ~= nil then
						local var_458_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_26.prefab_name].transform, "story_v_side_new_1109704", "1109704111", "story_v_side_new_1109704.awb")

						arg_455_1:RecordAudio("1109704111", var_458_32)
						arg_455_1:RecordAudio("1109704111", var_458_32)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704111", "story_v_side_new_1109704.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704111", "story_v_side_new_1109704.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_33 = math.max(var_458_24, arg_455_1.talkMaxDuration)

			if var_458_23 <= arg_455_1.time_ and arg_455_1.time_ < var_458_23 + var_458_33 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_23) / var_458_33

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_23 + var_458_33 and arg_455_1.time_ < var_458_23 + var_458_33 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R9701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R9701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.583334,
				className = "StoryMoveNode",
				startTime = 0.0166666666666666,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play1109704112 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1109704112
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1109704113(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0
			local var_462_1 = 0.9

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_2 = arg_459_1:GetWordFromCfg(1109704112)
				local var_462_3 = arg_459_1:FormatText(var_462_2.content)

				arg_459_1.text_.text = var_462_3

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_4 = 36
				local var_462_5 = utf8.len(var_462_3)
				local var_462_6 = var_462_4 <= 0 and var_462_1 or var_462_1 * (var_462_5 / var_462_4)

				if var_462_6 > 0 and var_462_1 < var_462_6 then
					arg_459_1.talkMaxDuration = var_462_6

					if var_462_6 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_6 + var_462_0
					end
				end

				arg_459_1.text_.text = var_462_3
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_7 = math.max(var_462_1, arg_459_1.talkMaxDuration)

			if var_462_0 <= arg_459_1.time_ and arg_459_1.time_ < var_462_0 + var_462_7 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_0) / var_462_7

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_0 + var_462_7 and arg_459_1.time_ < var_462_0 + var_462_7 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play1109704113 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1109704113
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1109704114(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0
			local var_466_1 = 0.15

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_2 = arg_463_1:FormatText(StoryNameCfg[7].name)

				arg_463_1.leftNameTxt_.text = var_466_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_3 = arg_463_1:GetWordFromCfg(1109704113)
				local var_466_4 = arg_463_1:FormatText(var_466_3.content)

				arg_463_1.text_.text = var_466_4

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_5 = 6
				local var_466_6 = utf8.len(var_466_4)
				local var_466_7 = var_466_5 <= 0 and var_466_1 or var_466_1 * (var_466_6 / var_466_5)

				if var_466_7 > 0 and var_466_1 < var_466_7 then
					arg_463_1.talkMaxDuration = var_466_7

					if var_466_7 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_7 + var_466_0
					end
				end

				arg_463_1.text_.text = var_466_4
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_8 = math.max(var_466_1, arg_463_1.talkMaxDuration)

			if var_466_0 <= arg_463_1.time_ and arg_463_1.time_ < var_466_0 + var_466_8 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_0) / var_466_8

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_0 + var_466_8 and arg_463_1.time_ < var_466_0 + var_466_8 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play1109704114 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1109704114
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1109704115(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0
			local var_470_1 = 0.75

			if var_470_0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_2 = arg_467_1:GetWordFromCfg(1109704114)
				local var_470_3 = arg_467_1:FormatText(var_470_2.content)

				arg_467_1.text_.text = var_470_3

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_4 = 30
				local var_470_5 = utf8.len(var_470_3)
				local var_470_6 = var_470_4 <= 0 and var_470_1 or var_470_1 * (var_470_5 / var_470_4)

				if var_470_6 > 0 and var_470_1 < var_470_6 then
					arg_467_1.talkMaxDuration = var_470_6

					if var_470_6 + var_470_0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_6 + var_470_0
					end
				end

				arg_467_1.text_.text = var_470_3
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_7 = math.max(var_470_1, arg_467_1.talkMaxDuration)

			if var_470_0 <= arg_467_1.time_ and arg_467_1.time_ < var_470_0 + var_470_7 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_0) / var_470_7

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_0 + var_470_7 and arg_467_1.time_ < var_470_0 + var_470_7 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1109704115 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1109704115
		arg_471_1.duration_ = 3.97

		local var_471_0 = {
			zh = 3.966,
			ja = 2.533
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1109704116(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0
			local var_474_1 = 0.525

			if var_474_0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_2 = arg_471_1:FormatText(StoryNameCfg[216].name)

				arg_471_1.leftNameTxt_.text = var_474_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_3 = arg_471_1:GetWordFromCfg(1109704115)
				local var_474_4 = arg_471_1:FormatText(var_474_3.content)

				arg_471_1.text_.text = var_474_4

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_5 = 21
				local var_474_6 = utf8.len(var_474_4)
				local var_474_7 = var_474_5 <= 0 and var_474_1 or var_474_1 * (var_474_6 / var_474_5)

				if var_474_7 > 0 and var_474_1 < var_474_7 then
					arg_471_1.talkMaxDuration = var_474_7

					if var_474_7 + var_474_0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_7 + var_474_0
					end
				end

				arg_471_1.text_.text = var_474_4
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704115", "story_v_side_new_1109704.awb") ~= 0 then
					local var_474_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704115", "story_v_side_new_1109704.awb") / 1000

					if var_474_8 + var_474_0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_8 + var_474_0
					end

					if var_474_3.prefab_name ~= "" and arg_471_1.actors_[var_474_3.prefab_name] ~= nil then
						local var_474_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_3.prefab_name].transform, "story_v_side_new_1109704", "1109704115", "story_v_side_new_1109704.awb")

						arg_471_1:RecordAudio("1109704115", var_474_9)
						arg_471_1:RecordAudio("1109704115", var_474_9)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704115", "story_v_side_new_1109704.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704115", "story_v_side_new_1109704.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_10 = math.max(var_474_1, arg_471_1.talkMaxDuration)

			if var_474_0 <= arg_471_1.time_ and arg_471_1.time_ < var_474_0 + var_474_10 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_0) / var_474_10

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_0 + var_474_10 and arg_471_1.time_ < var_474_0 + var_474_10 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play1109704116 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 1109704116
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play1109704117(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = arg_475_1.actors_["1097ui_story"]
			local var_478_1 = 0

			if var_478_1 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.characterEffect1097ui_story == nil then
				arg_475_1.var_.characterEffect1097ui_story = var_478_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_2 = 0.200000002980232

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_2 and not isNil(var_478_0) then
				local var_478_3 = (arg_475_1.time_ - var_478_1) / var_478_2

				if arg_475_1.var_.characterEffect1097ui_story and not isNil(var_478_0) then
					local var_478_4 = Mathf.Lerp(0, 0.5, var_478_3)

					arg_475_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_475_1.var_.characterEffect1097ui_story.fillRatio = var_478_4
				end
			end

			if arg_475_1.time_ >= var_478_1 + var_478_2 and arg_475_1.time_ < var_478_1 + var_478_2 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.characterEffect1097ui_story then
				local var_478_5 = 0.5

				arg_475_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_475_1.var_.characterEffect1097ui_story.fillRatio = var_478_5
			end

			local var_478_6 = 0
			local var_478_7 = 0.125

			if var_478_6 < arg_475_1.time_ and arg_475_1.time_ <= var_478_6 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_8 = arg_475_1:FormatText(StoryNameCfg[7].name)

				arg_475_1.leftNameTxt_.text = var_478_8

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

				local var_478_9 = arg_475_1:GetWordFromCfg(1109704116)
				local var_478_10 = arg_475_1:FormatText(var_478_9.content)

				arg_475_1.text_.text = var_478_10

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_11 = 5
				local var_478_12 = utf8.len(var_478_10)
				local var_478_13 = var_478_11 <= 0 and var_478_7 or var_478_7 * (var_478_12 / var_478_11)

				if var_478_13 > 0 and var_478_7 < var_478_13 then
					arg_475_1.talkMaxDuration = var_478_13

					if var_478_13 + var_478_6 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_13 + var_478_6
					end
				end

				arg_475_1.text_.text = var_478_10
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_14 = math.max(var_478_7, arg_475_1.talkMaxDuration)

			if var_478_6 <= arg_475_1.time_ and arg_475_1.time_ < var_478_6 + var_478_14 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_6) / var_478_14

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_6 + var_478_14 and arg_475_1.time_ < var_478_6 + var_478_14 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play1109704117 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 1109704117
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play1109704118(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0
			local var_482_1 = 0.925

			if var_482_0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, false)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_2 = arg_479_1:GetWordFromCfg(1109704117)
				local var_482_3 = arg_479_1:FormatText(var_482_2.content)

				arg_479_1.text_.text = var_482_3

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_4 = 37
				local var_482_5 = utf8.len(var_482_3)
				local var_482_6 = var_482_4 <= 0 and var_482_1 or var_482_1 * (var_482_5 / var_482_4)

				if var_482_6 > 0 and var_482_1 < var_482_6 then
					arg_479_1.talkMaxDuration = var_482_6

					if var_482_6 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_6 + var_482_0
					end
				end

				arg_479_1.text_.text = var_482_3
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_7 = math.max(var_482_1, arg_479_1.talkMaxDuration)

			if var_482_0 <= arg_479_1.time_ and arg_479_1.time_ < var_482_0 + var_482_7 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_0) / var_482_7

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_0 + var_482_7 and arg_479_1.time_ < var_482_0 + var_482_7 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play1109704118 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1109704118
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play1109704119(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 0.55

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_2 = arg_483_1:GetWordFromCfg(1109704118)
				local var_486_3 = arg_483_1:FormatText(var_486_2.content)

				arg_483_1.text_.text = var_486_3

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_4 = 22
				local var_486_5 = utf8.len(var_486_3)
				local var_486_6 = var_486_4 <= 0 and var_486_1 or var_486_1 * (var_486_5 / var_486_4)

				if var_486_6 > 0 and var_486_1 < var_486_6 then
					arg_483_1.talkMaxDuration = var_486_6

					if var_486_6 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_6 + var_486_0
					end
				end

				arg_483_1.text_.text = var_486_3
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_7 = math.max(var_486_1, arg_483_1.talkMaxDuration)

			if var_486_0 <= arg_483_1.time_ and arg_483_1.time_ < var_486_0 + var_486_7 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_0) / var_486_7

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_0 + var_486_7 and arg_483_1.time_ < var_486_0 + var_486_7 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play1109704119 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 1109704119
		arg_487_1.duration_ = 9

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play1109704120(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 2

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				local var_490_1 = manager.ui.mainCamera.transform.localPosition
				local var_490_2 = Vector3.New(0, 0, 10) + Vector3.New(var_490_1.x, var_490_1.y, 0)
				local var_490_3 = arg_487_1.bgs_.ST60

				var_490_3.transform.localPosition = var_490_2
				var_490_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_490_4 = var_490_3:GetComponent("SpriteRenderer")

				if var_490_4 and var_490_4.sprite then
					local var_490_5 = (var_490_3.transform.localPosition - var_490_1).z
					local var_490_6 = manager.ui.mainCameraCom_
					local var_490_7 = 2 * var_490_5 * Mathf.Tan(var_490_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_490_8 = var_490_7 * var_490_6.aspect
					local var_490_9 = var_490_4.sprite.bounds.size.x
					local var_490_10 = var_490_4.sprite.bounds.size.y
					local var_490_11 = var_490_8 / var_490_9
					local var_490_12 = var_490_7 / var_490_10
					local var_490_13 = var_490_12 < var_490_11 and var_490_11 or var_490_12

					var_490_3.transform.localScale = Vector3.New(var_490_13, var_490_13, 0)
				end

				for iter_490_0, iter_490_1 in pairs(arg_487_1.bgs_) do
					if iter_490_0 ~= "ST60" then
						iter_490_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_490_14 = 4

			if var_490_14 < arg_487_1.time_ and arg_487_1.time_ <= var_490_14 + arg_490_0 then
				arg_487_1.allBtn_.enabled = false
			end

			local var_490_15 = 0.3

			if arg_487_1.time_ >= var_490_14 + var_490_15 and arg_487_1.time_ < var_490_14 + var_490_15 + arg_490_0 then
				arg_487_1.allBtn_.enabled = true
			end

			local var_490_16 = 0

			if var_490_16 < arg_487_1.time_ and arg_487_1.time_ <= var_490_16 + arg_490_0 then
				arg_487_1.mask_.enabled = true
				arg_487_1.mask_.raycastTarget = true

				arg_487_1:SetGaussion(false)
			end

			local var_490_17 = 2

			if var_490_16 <= arg_487_1.time_ and arg_487_1.time_ < var_490_16 + var_490_17 then
				local var_490_18 = (arg_487_1.time_ - var_490_16) / var_490_17
				local var_490_19 = Color.New(1, 1, 1)

				var_490_19.a = Mathf.Lerp(0, 1, var_490_18)
				arg_487_1.mask_.color = var_490_19
			end

			if arg_487_1.time_ >= var_490_16 + var_490_17 and arg_487_1.time_ < var_490_16 + var_490_17 + arg_490_0 then
				local var_490_20 = Color.New(1, 1, 1)

				var_490_20.a = 1
				arg_487_1.mask_.color = var_490_20
			end

			local var_490_21 = 2

			if var_490_21 < arg_487_1.time_ and arg_487_1.time_ <= var_490_21 + arg_490_0 then
				arg_487_1.mask_.enabled = true
				arg_487_1.mask_.raycastTarget = true

				arg_487_1:SetGaussion(false)
			end

			local var_490_22 = 2

			if var_490_21 <= arg_487_1.time_ and arg_487_1.time_ < var_490_21 + var_490_22 then
				local var_490_23 = (arg_487_1.time_ - var_490_21) / var_490_22
				local var_490_24 = Color.New(1, 1, 1)

				var_490_24.a = Mathf.Lerp(1, 0, var_490_23)
				arg_487_1.mask_.color = var_490_24
			end

			if arg_487_1.time_ >= var_490_21 + var_490_22 and arg_487_1.time_ < var_490_21 + var_490_22 + arg_490_0 then
				local var_490_25 = Color.New(1, 1, 1)
				local var_490_26 = 0

				arg_487_1.mask_.enabled = false
				var_490_25.a = var_490_26
				arg_487_1.mask_.color = var_490_25
			end

			if arg_487_1.frameCnt_ <= 1 then
				arg_487_1.dialog_:SetActive(false)
			end

			local var_490_27 = 4
			local var_490_28 = 0.6

			if var_490_27 < arg_487_1.time_ and arg_487_1.time_ <= var_490_27 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0

				arg_487_1.dialog_:SetActive(true)

				arg_487_1.dialogCg_.alpha = 0

				local var_490_29 = LeanTween.value(arg_487_1.dialog_, 0, 1, 0.3)

				var_490_29:setOnUpdate(LuaHelper.FloatAction(function(arg_491_0)
					arg_487_1.dialogCg_.alpha = arg_491_0
				end))
				var_490_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_487_1.dialog_)
					var_490_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_487_1.duration_ = arg_487_1.duration_ + 0.3

				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_30 = arg_487_1:FormatText(StoryNameCfg[7].name)

				arg_487_1.leftNameTxt_.text = var_490_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_31 = arg_487_1:GetWordFromCfg(1109704119)
				local var_490_32 = arg_487_1:FormatText(var_490_31.content)

				arg_487_1.text_.text = var_490_32

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_33 = 24
				local var_490_34 = utf8.len(var_490_32)
				local var_490_35 = var_490_33 <= 0 and var_490_28 or var_490_28 * (var_490_34 / var_490_33)

				if var_490_35 > 0 and var_490_28 < var_490_35 then
					arg_487_1.talkMaxDuration = var_490_35
					var_490_27 = var_490_27 + 0.3

					if var_490_35 + var_490_27 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_35 + var_490_27
					end
				end

				arg_487_1.text_.text = var_490_32
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_36 = var_490_27 + 0.3
			local var_490_37 = math.max(var_490_28, arg_487_1.talkMaxDuration)

			if var_490_36 <= arg_487_1.time_ and arg_487_1.time_ < var_490_36 + var_490_37 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_36) / var_490_37

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_36 + var_490_37 and arg_487_1.time_ < var_490_36 + var_490_37 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play1109704120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1109704120
		arg_493_1.duration_ = 4.4

		local var_493_0 = {
			zh = 4.366,
			ja = 4.4
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1109704121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["1097ui_story"].transform
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 then
				arg_493_1.var_.moveOldPos1097ui_story = var_496_0.localPosition
			end

			local var_496_2 = 0.001

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_2 then
				local var_496_3 = (arg_493_1.time_ - var_496_1) / var_496_2
				local var_496_4 = Vector3.New(0, -0.54, -6.3)

				var_496_0.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1097ui_story, var_496_4, var_496_3)

				local var_496_5 = manager.ui.mainCamera.transform.position - var_496_0.position

				var_496_0.forward = Vector3.New(var_496_5.x, var_496_5.y, var_496_5.z)

				local var_496_6 = var_496_0.localEulerAngles

				var_496_6.z = 0
				var_496_6.x = 0
				var_496_0.localEulerAngles = var_496_6
			end

			if arg_493_1.time_ >= var_496_1 + var_496_2 and arg_493_1.time_ < var_496_1 + var_496_2 + arg_496_0 then
				var_496_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_496_7 = manager.ui.mainCamera.transform.position - var_496_0.position

				var_496_0.forward = Vector3.New(var_496_7.x, var_496_7.y, var_496_7.z)

				local var_496_8 = var_496_0.localEulerAngles

				var_496_8.z = 0
				var_496_8.x = 0
				var_496_0.localEulerAngles = var_496_8
			end

			local var_496_9 = arg_493_1.actors_["1097ui_story"]
			local var_496_10 = 0

			if var_496_10 < arg_493_1.time_ and arg_493_1.time_ <= var_496_10 + arg_496_0 and not isNil(var_496_9) and arg_493_1.var_.characterEffect1097ui_story == nil then
				arg_493_1.var_.characterEffect1097ui_story = var_496_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_11 = 0.200000002980232

			if var_496_10 <= arg_493_1.time_ and arg_493_1.time_ < var_496_10 + var_496_11 and not isNil(var_496_9) then
				local var_496_12 = (arg_493_1.time_ - var_496_10) / var_496_11

				if arg_493_1.var_.characterEffect1097ui_story and not isNil(var_496_9) then
					arg_493_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= var_496_10 + var_496_11 and arg_493_1.time_ < var_496_10 + var_496_11 + arg_496_0 and not isNil(var_496_9) and arg_493_1.var_.characterEffect1097ui_story then
				arg_493_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_496_13 = 0

			if var_496_13 < arg_493_1.time_ and arg_493_1.time_ <= var_496_13 + arg_496_0 then
				arg_493_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_496_14 = 0

			if var_496_14 < arg_493_1.time_ and arg_493_1.time_ <= var_496_14 + arg_496_0 then
				arg_493_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_496_15 = 0
			local var_496_16 = 0.6

			if var_496_15 < arg_493_1.time_ and arg_493_1.time_ <= var_496_15 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_17 = arg_493_1:FormatText(StoryNameCfg[216].name)

				arg_493_1.leftNameTxt_.text = var_496_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_18 = arg_493_1:GetWordFromCfg(1109704120)
				local var_496_19 = arg_493_1:FormatText(var_496_18.content)

				arg_493_1.text_.text = var_496_19

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_20 = 24
				local var_496_21 = utf8.len(var_496_19)
				local var_496_22 = var_496_20 <= 0 and var_496_16 or var_496_16 * (var_496_21 / var_496_20)

				if var_496_22 > 0 and var_496_16 < var_496_22 then
					arg_493_1.talkMaxDuration = var_496_22

					if var_496_22 + var_496_15 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_22 + var_496_15
					end
				end

				arg_493_1.text_.text = var_496_19
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704120", "story_v_side_new_1109704.awb") ~= 0 then
					local var_496_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704120", "story_v_side_new_1109704.awb") / 1000

					if var_496_23 + var_496_15 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_23 + var_496_15
					end

					if var_496_18.prefab_name ~= "" and arg_493_1.actors_[var_496_18.prefab_name] ~= nil then
						local var_496_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_18.prefab_name].transform, "story_v_side_new_1109704", "1109704120", "story_v_side_new_1109704.awb")

						arg_493_1:RecordAudio("1109704120", var_496_24)
						arg_493_1:RecordAudio("1109704120", var_496_24)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704120", "story_v_side_new_1109704.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704120", "story_v_side_new_1109704.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_25 = math.max(var_496_16, arg_493_1.talkMaxDuration)

			if var_496_15 <= arg_493_1.time_ and arg_493_1.time_ < var_496_15 + var_496_25 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_15) / var_496_25

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_15 + var_496_25 and arg_493_1.time_ < var_496_15 + var_496_25 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
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

		arg_493_1:InitPlayNodeList()
	end,
	Play1109704121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1109704121
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1109704122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = arg_497_1.actors_["1097ui_story"]
			local var_500_1 = 0

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1097ui_story == nil then
				arg_497_1.var_.characterEffect1097ui_story = var_500_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_2 = 0.200000002980232

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_2 and not isNil(var_500_0) then
				local var_500_3 = (arg_497_1.time_ - var_500_1) / var_500_2

				if arg_497_1.var_.characterEffect1097ui_story and not isNil(var_500_0) then
					local var_500_4 = Mathf.Lerp(0, 0.5, var_500_3)

					arg_497_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_497_1.var_.characterEffect1097ui_story.fillRatio = var_500_4
				end
			end

			if arg_497_1.time_ >= var_500_1 + var_500_2 and arg_497_1.time_ < var_500_1 + var_500_2 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1097ui_story then
				local var_500_5 = 0.5

				arg_497_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_497_1.var_.characterEffect1097ui_story.fillRatio = var_500_5
			end

			local var_500_6 = 0
			local var_500_7 = 0.25

			if var_500_6 < arg_497_1.time_ and arg_497_1.time_ <= var_500_6 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_8 = arg_497_1:FormatText(StoryNameCfg[7].name)

				arg_497_1.leftNameTxt_.text = var_500_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_9 = arg_497_1:GetWordFromCfg(1109704121)
				local var_500_10 = arg_497_1:FormatText(var_500_9.content)

				arg_497_1.text_.text = var_500_10

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_11 = 10
				local var_500_12 = utf8.len(var_500_10)
				local var_500_13 = var_500_11 <= 0 and var_500_7 or var_500_7 * (var_500_12 / var_500_11)

				if var_500_13 > 0 and var_500_7 < var_500_13 then
					arg_497_1.talkMaxDuration = var_500_13

					if var_500_13 + var_500_6 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_13 + var_500_6
					end
				end

				arg_497_1.text_.text = var_500_10
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_14 = math.max(var_500_7, arg_497_1.talkMaxDuration)

			if var_500_6 <= arg_497_1.time_ and arg_497_1.time_ < var_500_6 + var_500_14 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_6) / var_500_14

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_6 + var_500_14 and arg_497_1.time_ < var_500_6 + var_500_14 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1109704122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1109704122
		arg_501_1.duration_ = 2.83

		local var_501_0 = {
			zh = 2.333,
			ja = 2.833
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1109704123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0
			local var_504_1 = 0.25

			if var_504_0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_2 = arg_501_1:FormatText(StoryNameCfg[36].name)

				arg_501_1.leftNameTxt_.text = var_504_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2070")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_3 = arg_501_1:GetWordFromCfg(1109704122)
				local var_504_4 = arg_501_1:FormatText(var_504_3.content)

				arg_501_1.text_.text = var_504_4

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_5 = 10
				local var_504_6 = utf8.len(var_504_4)
				local var_504_7 = var_504_5 <= 0 and var_504_1 or var_504_1 * (var_504_6 / var_504_5)

				if var_504_7 > 0 and var_504_1 < var_504_7 then
					arg_501_1.talkMaxDuration = var_504_7

					if var_504_7 + var_504_0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_7 + var_504_0
					end
				end

				arg_501_1.text_.text = var_504_4
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704122", "story_v_side_new_1109704.awb") ~= 0 then
					local var_504_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704122", "story_v_side_new_1109704.awb") / 1000

					if var_504_8 + var_504_0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_8 + var_504_0
					end

					if var_504_3.prefab_name ~= "" and arg_501_1.actors_[var_504_3.prefab_name] ~= nil then
						local var_504_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_3.prefab_name].transform, "story_v_side_new_1109704", "1109704122", "story_v_side_new_1109704.awb")

						arg_501_1:RecordAudio("1109704122", var_504_9)
						arg_501_1:RecordAudio("1109704122", var_504_9)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704122", "story_v_side_new_1109704.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704122", "story_v_side_new_1109704.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_10 = math.max(var_504_1, arg_501_1.talkMaxDuration)

			if var_504_0 <= arg_501_1.time_ and arg_501_1.time_ < var_504_0 + var_504_10 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_0) / var_504_10

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_0 + var_504_10 and arg_501_1.time_ < var_504_0 + var_504_10 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1109704123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1109704123
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1109704124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0
			local var_508_1 = 1.35

			if var_508_0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_2 = arg_505_1:GetWordFromCfg(1109704123)
				local var_508_3 = arg_505_1:FormatText(var_508_2.content)

				arg_505_1.text_.text = var_508_3

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_4 = 54
				local var_508_5 = utf8.len(var_508_3)
				local var_508_6 = var_508_4 <= 0 and var_508_1 or var_508_1 * (var_508_5 / var_508_4)

				if var_508_6 > 0 and var_508_1 < var_508_6 then
					arg_505_1.talkMaxDuration = var_508_6

					if var_508_6 + var_508_0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_6 + var_508_0
					end
				end

				arg_505_1.text_.text = var_508_3
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_7 = math.max(var_508_1, arg_505_1.talkMaxDuration)

			if var_508_0 <= arg_505_1.time_ and arg_505_1.time_ < var_508_0 + var_508_7 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_0) / var_508_7

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_0 + var_508_7 and arg_505_1.time_ < var_508_0 + var_508_7 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1109704124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1109704124
		arg_509_1.duration_ = 2.67

		local var_509_0 = {
			zh = 2.633,
			ja = 2.666
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1109704125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = arg_509_1.actors_["1097ui_story"].transform
			local var_512_1 = 0

			if var_512_1 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 then
				arg_509_1.var_.moveOldPos1097ui_story = var_512_0.localPosition
			end

			local var_512_2 = 0.001

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_2 then
				local var_512_3 = (arg_509_1.time_ - var_512_1) / var_512_2
				local var_512_4 = Vector3.New(0, -0.54, -6.3)

				var_512_0.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos1097ui_story, var_512_4, var_512_3)

				local var_512_5 = manager.ui.mainCamera.transform.position - var_512_0.position

				var_512_0.forward = Vector3.New(var_512_5.x, var_512_5.y, var_512_5.z)

				local var_512_6 = var_512_0.localEulerAngles

				var_512_6.z = 0
				var_512_6.x = 0
				var_512_0.localEulerAngles = var_512_6
			end

			if arg_509_1.time_ >= var_512_1 + var_512_2 and arg_509_1.time_ < var_512_1 + var_512_2 + arg_512_0 then
				var_512_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_512_7 = manager.ui.mainCamera.transform.position - var_512_0.position

				var_512_0.forward = Vector3.New(var_512_7.x, var_512_7.y, var_512_7.z)

				local var_512_8 = var_512_0.localEulerAngles

				var_512_8.z = 0
				var_512_8.x = 0
				var_512_0.localEulerAngles = var_512_8
			end

			local var_512_9 = arg_509_1.actors_["1097ui_story"]
			local var_512_10 = 0

			if var_512_10 < arg_509_1.time_ and arg_509_1.time_ <= var_512_10 + arg_512_0 and not isNil(var_512_9) and arg_509_1.var_.characterEffect1097ui_story == nil then
				arg_509_1.var_.characterEffect1097ui_story = var_512_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_11 = 0.200000002980232

			if var_512_10 <= arg_509_1.time_ and arg_509_1.time_ < var_512_10 + var_512_11 and not isNil(var_512_9) then
				local var_512_12 = (arg_509_1.time_ - var_512_10) / var_512_11

				if arg_509_1.var_.characterEffect1097ui_story and not isNil(var_512_9) then
					arg_509_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_509_1.time_ >= var_512_10 + var_512_11 and arg_509_1.time_ < var_512_10 + var_512_11 + arg_512_0 and not isNil(var_512_9) and arg_509_1.var_.characterEffect1097ui_story then
				arg_509_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_512_13 = 0

			if var_512_13 < arg_509_1.time_ and arg_509_1.time_ <= var_512_13 + arg_512_0 then
				arg_509_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_512_14 = 0

			if var_512_14 < arg_509_1.time_ and arg_509_1.time_ <= var_512_14 + arg_512_0 then
				arg_509_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_512_15 = 0
			local var_512_16 = 0.375

			if var_512_15 < arg_509_1.time_ and arg_509_1.time_ <= var_512_15 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_17 = arg_509_1:FormatText(StoryNameCfg[952].name)

				arg_509_1.leftNameTxt_.text = var_512_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_18 = arg_509_1:GetWordFromCfg(1109704124)
				local var_512_19 = arg_509_1:FormatText(var_512_18.content)

				arg_509_1.text_.text = var_512_19

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_20 = 15
				local var_512_21 = utf8.len(var_512_19)
				local var_512_22 = var_512_20 <= 0 and var_512_16 or var_512_16 * (var_512_21 / var_512_20)

				if var_512_22 > 0 and var_512_16 < var_512_22 then
					arg_509_1.talkMaxDuration = var_512_22

					if var_512_22 + var_512_15 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_22 + var_512_15
					end
				end

				arg_509_1.text_.text = var_512_19
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704124", "story_v_side_new_1109704.awb") ~= 0 then
					local var_512_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704124", "story_v_side_new_1109704.awb") / 1000

					if var_512_23 + var_512_15 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_23 + var_512_15
					end

					if var_512_18.prefab_name ~= "" and arg_509_1.actors_[var_512_18.prefab_name] ~= nil then
						local var_512_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_18.prefab_name].transform, "story_v_side_new_1109704", "1109704124", "story_v_side_new_1109704.awb")

						arg_509_1:RecordAudio("1109704124", var_512_24)
						arg_509_1:RecordAudio("1109704124", var_512_24)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704124", "story_v_side_new_1109704.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704124", "story_v_side_new_1109704.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_25 = math.max(var_512_16, arg_509_1.talkMaxDuration)

			if var_512_15 <= arg_509_1.time_ and arg_509_1.time_ < var_512_15 + var_512_25 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_15) / var_512_25

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_15 + var_512_25 and arg_509_1.time_ < var_512_15 + var_512_25 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {
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

		arg_509_1:InitPlayNodeList()
	end,
	Play1109704125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1109704125
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1109704126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = arg_513_1.actors_["1097ui_story"]
			local var_516_1 = 0

			if var_516_1 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.characterEffect1097ui_story == nil then
				arg_513_1.var_.characterEffect1097ui_story = var_516_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_2 = 0.200000002980232

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_2 and not isNil(var_516_0) then
				local var_516_3 = (arg_513_1.time_ - var_516_1) / var_516_2

				if arg_513_1.var_.characterEffect1097ui_story and not isNil(var_516_0) then
					local var_516_4 = Mathf.Lerp(0, 0.5, var_516_3)

					arg_513_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_513_1.var_.characterEffect1097ui_story.fillRatio = var_516_4
				end
			end

			if arg_513_1.time_ >= var_516_1 + var_516_2 and arg_513_1.time_ < var_516_1 + var_516_2 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.characterEffect1097ui_story then
				local var_516_5 = 0.5

				arg_513_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_513_1.var_.characterEffect1097ui_story.fillRatio = var_516_5
			end

			local var_516_6 = 0
			local var_516_7 = 0.95

			if var_516_6 < arg_513_1.time_ and arg_513_1.time_ <= var_516_6 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_8 = arg_513_1:GetWordFromCfg(1109704125)
				local var_516_9 = arg_513_1:FormatText(var_516_8.content)

				arg_513_1.text_.text = var_516_9

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_10 = 38
				local var_516_11 = utf8.len(var_516_9)
				local var_516_12 = var_516_10 <= 0 and var_516_7 or var_516_7 * (var_516_11 / var_516_10)

				if var_516_12 > 0 and var_516_7 < var_516_12 then
					arg_513_1.talkMaxDuration = var_516_12

					if var_516_12 + var_516_6 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_12 + var_516_6
					end
				end

				arg_513_1.text_.text = var_516_9
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_13 = math.max(var_516_7, arg_513_1.talkMaxDuration)

			if var_516_6 <= arg_513_1.time_ and arg_513_1.time_ < var_516_6 + var_516_13 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_6) / var_516_13

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_6 + var_516_13 and arg_513_1.time_ < var_516_6 + var_516_13 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1109704126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1109704126
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1109704127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0
			local var_520_1 = 0.725

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_2 = arg_517_1:FormatText(StoryNameCfg[7].name)

				arg_517_1.leftNameTxt_.text = var_520_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_3 = arg_517_1:GetWordFromCfg(1109704126)
				local var_520_4 = arg_517_1:FormatText(var_520_3.content)

				arg_517_1.text_.text = var_520_4

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_5 = 29
				local var_520_6 = utf8.len(var_520_4)
				local var_520_7 = var_520_5 <= 0 and var_520_1 or var_520_1 * (var_520_6 / var_520_5)

				if var_520_7 > 0 and var_520_1 < var_520_7 then
					arg_517_1.talkMaxDuration = var_520_7

					if var_520_7 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_0
					end
				end

				arg_517_1.text_.text = var_520_4
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_8 = math.max(var_520_1, arg_517_1.talkMaxDuration)

			if var_520_0 <= arg_517_1.time_ and arg_517_1.time_ < var_520_0 + var_520_8 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_0) / var_520_8

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_0 + var_520_8 and arg_517_1.time_ < var_520_0 + var_520_8 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1109704127 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1109704127
		arg_521_1.duration_ = 7

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1109704128(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0

			if var_524_0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				local var_524_1 = manager.ui.mainCamera.transform.localPosition
				local var_524_2 = Vector3.New(0, 0, 10) + Vector3.New(var_524_1.x, var_524_1.y, 0)
				local var_524_3 = arg_521_1.bgs_.ST60

				var_524_3.transform.localPosition = var_524_2
				var_524_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_524_4 = var_524_3:GetComponent("SpriteRenderer")

				if var_524_4 and var_524_4.sprite then
					local var_524_5 = (var_524_3.transform.localPosition - var_524_1).z
					local var_524_6 = manager.ui.mainCameraCom_
					local var_524_7 = 2 * var_524_5 * Mathf.Tan(var_524_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_524_8 = var_524_7 * var_524_6.aspect
					local var_524_9 = var_524_4.sprite.bounds.size.x
					local var_524_10 = var_524_4.sprite.bounds.size.y
					local var_524_11 = var_524_8 / var_524_9
					local var_524_12 = var_524_7 / var_524_10
					local var_524_13 = var_524_12 < var_524_11 and var_524_11 or var_524_12

					var_524_3.transform.localScale = Vector3.New(var_524_13, var_524_13, 0)
				end

				for iter_524_0, iter_524_1 in pairs(arg_521_1.bgs_) do
					if iter_524_0 ~= "ST60" then
						iter_524_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_524_14 = 2

			if var_524_14 < arg_521_1.time_ and arg_521_1.time_ <= var_524_14 + arg_524_0 then
				arg_521_1.allBtn_.enabled = false
			end

			local var_524_15 = 0.3

			if arg_521_1.time_ >= var_524_14 + var_524_15 and arg_521_1.time_ < var_524_14 + var_524_15 + arg_524_0 then
				arg_521_1.allBtn_.enabled = true
			end

			local var_524_16 = 0

			if var_524_16 < arg_521_1.time_ and arg_521_1.time_ <= var_524_16 + arg_524_0 then
				arg_521_1.mask_.enabled = true
				arg_521_1.mask_.raycastTarget = true

				arg_521_1:SetGaussion(false)
			end

			local var_524_17 = 2

			if var_524_16 <= arg_521_1.time_ and arg_521_1.time_ < var_524_16 + var_524_17 then
				local var_524_18 = (arg_521_1.time_ - var_524_16) / var_524_17
				local var_524_19 = Color.New(1, 1, 1)

				var_524_19.a = Mathf.Lerp(1, 0, var_524_18)
				arg_521_1.mask_.color = var_524_19
			end

			if arg_521_1.time_ >= var_524_16 + var_524_17 and arg_521_1.time_ < var_524_16 + var_524_17 + arg_524_0 then
				local var_524_20 = Color.New(1, 1, 1)
				local var_524_21 = 0

				arg_521_1.mask_.enabled = false
				var_524_20.a = var_524_21
				arg_521_1.mask_.color = var_524_20
			end

			local var_524_22 = 0
			local var_524_23 = 0.2

			if var_524_22 < arg_521_1.time_ and arg_521_1.time_ <= var_524_22 + arg_524_0 then
				local var_524_24 = "play"
				local var_524_25 = "music"

				arg_521_1:AudioAction(var_524_24, var_524_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_524_26 = ""
				local var_524_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_524_27 ~= "" then
					if arg_521_1.bgmTxt_.text ~= var_524_27 and arg_521_1.bgmTxt_.text ~= "" then
						if arg_521_1.bgmTxt2_.text ~= "" then
							arg_521_1.bgmTxt_.text = arg_521_1.bgmTxt2_.text
						end

						arg_521_1.bgmTxt2_.text = var_524_27

						arg_521_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_521_1.bgmTxt_.text = var_524_27
						arg_521_1.bgmTxt2_.text = var_524_27
					end

					if arg_521_1.bgmTimer then
						arg_521_1.bgmTimer:Stop()

						arg_521_1.bgmTimer = nil
					end

					if arg_521_1.settingData.show_music_name == 1 then
						arg_521_1.musicController:SetSelectedState("show")
						arg_521_1.musicAnimator_:Play("open", 0, 0)

						if arg_521_1.settingData.music_time ~= 0 then
							arg_521_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_521_1.settingData.music_time), function()
								if arg_521_1 == nil or isNil(arg_521_1.bgmTxt_) then
									return
								end

								arg_521_1.musicController:SetSelectedState("hide")
								arg_521_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_521_1.frameCnt_ <= 1 then
				arg_521_1.dialog_:SetActive(false)
			end

			local var_524_28 = 2
			local var_524_29 = 0.15

			if var_524_28 < arg_521_1.time_ and arg_521_1.time_ <= var_524_28 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0

				arg_521_1.dialog_:SetActive(true)

				arg_521_1.dialogCg_.alpha = 0

				local var_524_30 = LeanTween.value(arg_521_1.dialog_, 0, 1, 0.3)

				var_524_30:setOnUpdate(LuaHelper.FloatAction(function(arg_526_0)
					arg_521_1.dialogCg_.alpha = arg_526_0
				end))
				var_524_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_521_1.dialog_)
					var_524_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_521_1.duration_ = arg_521_1.duration_ + 0.3

				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_31 = arg_521_1:GetWordFromCfg(1109704127)
				local var_524_32 = arg_521_1:FormatText(var_524_31.content)

				arg_521_1.text_.text = var_524_32

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_33 = 6
				local var_524_34 = utf8.len(var_524_32)
				local var_524_35 = var_524_33 <= 0 and var_524_29 or var_524_29 * (var_524_34 / var_524_33)

				if var_524_35 > 0 and var_524_29 < var_524_35 then
					arg_521_1.talkMaxDuration = var_524_35
					var_524_28 = var_524_28 + 0.3

					if var_524_35 + var_524_28 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_35 + var_524_28
					end
				end

				arg_521_1.text_.text = var_524_32
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_36 = var_524_28 + 0.3
			local var_524_37 = math.max(var_524_29, arg_521_1.talkMaxDuration)

			if var_524_36 <= arg_521_1.time_ and arg_521_1.time_ < var_524_36 + var_524_37 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_36) / var_524_37

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_36 + var_524_37 and arg_521_1.time_ < var_524_36 + var_524_37 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play1109704128 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 1109704128
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play1109704129(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0
			local var_531_1 = 1.225

			if var_531_0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, false)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_2 = arg_528_1:GetWordFromCfg(1109704128)
				local var_531_3 = arg_528_1:FormatText(var_531_2.content)

				arg_528_1.text_.text = var_531_3

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_4 = 49
				local var_531_5 = utf8.len(var_531_3)
				local var_531_6 = var_531_4 <= 0 and var_531_1 or var_531_1 * (var_531_5 / var_531_4)

				if var_531_6 > 0 and var_531_1 < var_531_6 then
					arg_528_1.talkMaxDuration = var_531_6

					if var_531_6 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_6 + var_531_0
					end
				end

				arg_528_1.text_.text = var_531_3
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_7 = math.max(var_531_1, arg_528_1.talkMaxDuration)

			if var_531_0 <= arg_528_1.time_ and arg_528_1.time_ < var_531_0 + var_531_7 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_0) / var_531_7

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_0 + var_531_7 and arg_528_1.time_ < var_531_0 + var_531_7 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play1109704129 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 1109704129
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play1109704130(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0
			local var_535_1 = 0.05

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_2 = arg_532_1:FormatText(StoryNameCfg[7].name)

				arg_532_1.leftNameTxt_.text = var_535_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_3 = arg_532_1:GetWordFromCfg(1109704129)
				local var_535_4 = arg_532_1:FormatText(var_535_3.content)

				arg_532_1.text_.text = var_535_4

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_5 = 2
				local var_535_6 = utf8.len(var_535_4)
				local var_535_7 = var_535_5 <= 0 and var_535_1 or var_535_1 * (var_535_6 / var_535_5)

				if var_535_7 > 0 and var_535_1 < var_535_7 then
					arg_532_1.talkMaxDuration = var_535_7

					if var_535_7 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_7 + var_535_0
					end
				end

				arg_532_1.text_.text = var_535_4
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_8 = math.max(var_535_1, arg_532_1.talkMaxDuration)

			if var_535_0 <= arg_532_1.time_ and arg_532_1.time_ < var_535_0 + var_535_8 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_0) / var_535_8

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_0 + var_535_8 and arg_532_1.time_ < var_535_0 + var_535_8 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play1109704130 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 1109704130
		arg_536_1.duration_ = 1.7

		local var_536_0 = {
			zh = 1.7,
			ja = 1.466
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
				arg_536_0:Play1109704131(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = arg_536_1.actors_["1097ui_story"].transform
			local var_539_1 = 0

			if var_539_1 < arg_536_1.time_ and arg_536_1.time_ <= var_539_1 + arg_539_0 then
				arg_536_1.var_.moveOldPos1097ui_story = var_539_0.localPosition
			end

			local var_539_2 = 0.001

			if var_539_1 <= arg_536_1.time_ and arg_536_1.time_ < var_539_1 + var_539_2 then
				local var_539_3 = (arg_536_1.time_ - var_539_1) / var_539_2
				local var_539_4 = Vector3.New(0, -0.54, -6.3)

				var_539_0.localPosition = Vector3.Lerp(arg_536_1.var_.moveOldPos1097ui_story, var_539_4, var_539_3)

				local var_539_5 = manager.ui.mainCamera.transform.position - var_539_0.position

				var_539_0.forward = Vector3.New(var_539_5.x, var_539_5.y, var_539_5.z)

				local var_539_6 = var_539_0.localEulerAngles

				var_539_6.z = 0
				var_539_6.x = 0
				var_539_0.localEulerAngles = var_539_6
			end

			if arg_536_1.time_ >= var_539_1 + var_539_2 and arg_536_1.time_ < var_539_1 + var_539_2 + arg_539_0 then
				var_539_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_539_7 = manager.ui.mainCamera.transform.position - var_539_0.position

				var_539_0.forward = Vector3.New(var_539_7.x, var_539_7.y, var_539_7.z)

				local var_539_8 = var_539_0.localEulerAngles

				var_539_8.z = 0
				var_539_8.x = 0
				var_539_0.localEulerAngles = var_539_8
			end

			local var_539_9 = arg_536_1.actors_["1097ui_story"]
			local var_539_10 = 0

			if var_539_10 < arg_536_1.time_ and arg_536_1.time_ <= var_539_10 + arg_539_0 and not isNil(var_539_9) and arg_536_1.var_.characterEffect1097ui_story == nil then
				arg_536_1.var_.characterEffect1097ui_story = var_539_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_11 = 0.200000002980232

			if var_539_10 <= arg_536_1.time_ and arg_536_1.time_ < var_539_10 + var_539_11 and not isNil(var_539_9) then
				local var_539_12 = (arg_536_1.time_ - var_539_10) / var_539_11

				if arg_536_1.var_.characterEffect1097ui_story and not isNil(var_539_9) then
					arg_536_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_536_1.time_ >= var_539_10 + var_539_11 and arg_536_1.time_ < var_539_10 + var_539_11 + arg_539_0 and not isNil(var_539_9) and arg_536_1.var_.characterEffect1097ui_story then
				arg_536_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_539_13 = 0

			if var_539_13 < arg_536_1.time_ and arg_536_1.time_ <= var_539_13 + arg_539_0 then
				arg_536_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_539_14 = 0

			if var_539_14 < arg_536_1.time_ and arg_536_1.time_ <= var_539_14 + arg_539_0 then
				arg_536_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_539_15 = 0
			local var_539_16 = 0.35

			if var_539_15 < arg_536_1.time_ and arg_536_1.time_ <= var_539_15 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_17 = arg_536_1:FormatText(StoryNameCfg[216].name)

				arg_536_1.leftNameTxt_.text = var_539_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_18 = arg_536_1:GetWordFromCfg(1109704130)
				local var_539_19 = arg_536_1:FormatText(var_539_18.content)

				arg_536_1.text_.text = var_539_19

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_20 = 14
				local var_539_21 = utf8.len(var_539_19)
				local var_539_22 = var_539_20 <= 0 and var_539_16 or var_539_16 * (var_539_21 / var_539_20)

				if var_539_22 > 0 and var_539_16 < var_539_22 then
					arg_536_1.talkMaxDuration = var_539_22

					if var_539_22 + var_539_15 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_22 + var_539_15
					end
				end

				arg_536_1.text_.text = var_539_19
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704130", "story_v_side_new_1109704.awb") ~= 0 then
					local var_539_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704130", "story_v_side_new_1109704.awb") / 1000

					if var_539_23 + var_539_15 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_23 + var_539_15
					end

					if var_539_18.prefab_name ~= "" and arg_536_1.actors_[var_539_18.prefab_name] ~= nil then
						local var_539_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_18.prefab_name].transform, "story_v_side_new_1109704", "1109704130", "story_v_side_new_1109704.awb")

						arg_536_1:RecordAudio("1109704130", var_539_24)
						arg_536_1:RecordAudio("1109704130", var_539_24)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704130", "story_v_side_new_1109704.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704130", "story_v_side_new_1109704.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_25 = math.max(var_539_16, arg_536_1.talkMaxDuration)

			if var_539_15 <= arg_536_1.time_ and arg_536_1.time_ < var_539_15 + var_539_25 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_15) / var_539_25

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_15 + var_539_25 and arg_536_1.time_ < var_539_15 + var_539_25 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {
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

		arg_536_1:InitPlayNodeList()
	end,
	Play1109704131 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 1109704131
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play1109704132(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = arg_540_1.actors_["1097ui_story"]
			local var_543_1 = 0

			if var_543_1 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 and not isNil(var_543_0) and arg_540_1.var_.characterEffect1097ui_story == nil then
				arg_540_1.var_.characterEffect1097ui_story = var_543_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_543_2 = 0.200000002980232

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_2 and not isNil(var_543_0) then
				local var_543_3 = (arg_540_1.time_ - var_543_1) / var_543_2

				if arg_540_1.var_.characterEffect1097ui_story and not isNil(var_543_0) then
					local var_543_4 = Mathf.Lerp(0, 0.5, var_543_3)

					arg_540_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_540_1.var_.characterEffect1097ui_story.fillRatio = var_543_4
				end
			end

			if arg_540_1.time_ >= var_543_1 + var_543_2 and arg_540_1.time_ < var_543_1 + var_543_2 + arg_543_0 and not isNil(var_543_0) and arg_540_1.var_.characterEffect1097ui_story then
				local var_543_5 = 0.5

				arg_540_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_540_1.var_.characterEffect1097ui_story.fillRatio = var_543_5
			end

			local var_543_6 = 0
			local var_543_7 = 0.6

			if var_543_6 < arg_540_1.time_ and arg_540_1.time_ <= var_543_6 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				local var_543_8 = arg_540_1:FormatText(StoryNameCfg[7].name)

				arg_540_1.leftNameTxt_.text = var_543_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_9 = arg_540_1:GetWordFromCfg(1109704131)
				local var_543_10 = arg_540_1:FormatText(var_543_9.content)

				arg_540_1.text_.text = var_543_10

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_11 = 24
				local var_543_12 = utf8.len(var_543_10)
				local var_543_13 = var_543_11 <= 0 and var_543_7 or var_543_7 * (var_543_12 / var_543_11)

				if var_543_13 > 0 and var_543_7 < var_543_13 then
					arg_540_1.talkMaxDuration = var_543_13

					if var_543_13 + var_543_6 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_13 + var_543_6
					end
				end

				arg_540_1.text_.text = var_543_10
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_14 = math.max(var_543_7, arg_540_1.talkMaxDuration)

			if var_543_6 <= arg_540_1.time_ and arg_540_1.time_ < var_543_6 + var_543_14 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_6) / var_543_14

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_6 + var_543_14 and arg_540_1.time_ < var_543_6 + var_543_14 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play1109704132 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 1109704132
		arg_544_1.duration_ = 7

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play1109704133(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0

			if var_547_0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_0 + arg_547_0 then
				local var_547_1 = manager.ui.mainCamera.transform.localPosition
				local var_547_2 = Vector3.New(0, 0, 10) + Vector3.New(var_547_1.x, var_547_1.y, 0)
				local var_547_3 = arg_544_1.bgs_.STwhite

				var_547_3.transform.localPosition = var_547_2
				var_547_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_547_4 = var_547_3:GetComponent("SpriteRenderer")

				if var_547_4 and var_547_4.sprite then
					local var_547_5 = (var_547_3.transform.localPosition - var_547_1).z
					local var_547_6 = manager.ui.mainCameraCom_
					local var_547_7 = 2 * var_547_5 * Mathf.Tan(var_547_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_547_8 = var_547_7 * var_547_6.aspect
					local var_547_9 = var_547_4.sprite.bounds.size.x
					local var_547_10 = var_547_4.sprite.bounds.size.y
					local var_547_11 = var_547_8 / var_547_9
					local var_547_12 = var_547_7 / var_547_10
					local var_547_13 = var_547_12 < var_547_11 and var_547_11 or var_547_12

					var_547_3.transform.localScale = Vector3.New(var_547_13, var_547_13, 0)
				end

				for iter_547_0, iter_547_1 in pairs(arg_544_1.bgs_) do
					if iter_547_0 ~= "STwhite" then
						iter_547_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_547_14 = 2

			if var_547_14 < arg_544_1.time_ and arg_544_1.time_ <= var_547_14 + arg_547_0 then
				arg_544_1.allBtn_.enabled = false
			end

			local var_547_15 = 0.3

			if arg_544_1.time_ >= var_547_14 + var_547_15 and arg_544_1.time_ < var_547_14 + var_547_15 + arg_547_0 then
				arg_544_1.allBtn_.enabled = true
			end

			local var_547_16 = 0

			if var_547_16 < arg_544_1.time_ and arg_544_1.time_ <= var_547_16 + arg_547_0 then
				arg_544_1.mask_.enabled = true
				arg_544_1.mask_.raycastTarget = true

				arg_544_1:SetGaussion(false)
			end

			local var_547_17 = 2

			if var_547_16 <= arg_544_1.time_ and arg_544_1.time_ < var_547_16 + var_547_17 then
				local var_547_18 = (arg_544_1.time_ - var_547_16) / var_547_17
				local var_547_19 = Color.New(1, 1, 1)

				var_547_19.a = Mathf.Lerp(1, 0, var_547_18)
				arg_544_1.mask_.color = var_547_19
			end

			if arg_544_1.time_ >= var_547_16 + var_547_17 and arg_544_1.time_ < var_547_16 + var_547_17 + arg_547_0 then
				local var_547_20 = Color.New(1, 1, 1)
				local var_547_21 = 0

				arg_544_1.mask_.enabled = false
				var_547_20.a = var_547_21
				arg_544_1.mask_.color = var_547_20
			end

			local var_547_22 = arg_544_1.actors_["1097ui_story"].transform
			local var_547_23 = 0

			if var_547_23 < arg_544_1.time_ and arg_544_1.time_ <= var_547_23 + arg_547_0 then
				arg_544_1.var_.moveOldPos1097ui_story = var_547_22.localPosition
			end

			local var_547_24 = 0.001

			if var_547_23 <= arg_544_1.time_ and arg_544_1.time_ < var_547_23 + var_547_24 then
				local var_547_25 = (arg_544_1.time_ - var_547_23) / var_547_24
				local var_547_26 = Vector3.New(0, 100, 0)

				var_547_22.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos1097ui_story, var_547_26, var_547_25)

				local var_547_27 = manager.ui.mainCamera.transform.position - var_547_22.position

				var_547_22.forward = Vector3.New(var_547_27.x, var_547_27.y, var_547_27.z)

				local var_547_28 = var_547_22.localEulerAngles

				var_547_28.z = 0
				var_547_28.x = 0
				var_547_22.localEulerAngles = var_547_28
			end

			if arg_544_1.time_ >= var_547_23 + var_547_24 and arg_544_1.time_ < var_547_23 + var_547_24 + arg_547_0 then
				var_547_22.localPosition = Vector3.New(0, 100, 0)

				local var_547_29 = manager.ui.mainCamera.transform.position - var_547_22.position

				var_547_22.forward = Vector3.New(var_547_29.x, var_547_29.y, var_547_29.z)

				local var_547_30 = var_547_22.localEulerAngles

				var_547_30.z = 0
				var_547_30.x = 0
				var_547_22.localEulerAngles = var_547_30
			end

			local var_547_31 = 0
			local var_547_32 = 0.2

			if var_547_31 < arg_544_1.time_ and arg_544_1.time_ <= var_547_31 + arg_547_0 then
				local var_547_33 = "play"
				local var_547_34 = "music"

				arg_544_1:AudioAction(var_547_33, var_547_34, "ui_battle", "ui_battle_stopbgm", "")

				local var_547_35 = ""
				local var_547_36 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_547_36 ~= "" then
					if arg_544_1.bgmTxt_.text ~= var_547_36 and arg_544_1.bgmTxt_.text ~= "" then
						if arg_544_1.bgmTxt2_.text ~= "" then
							arg_544_1.bgmTxt_.text = arg_544_1.bgmTxt2_.text
						end

						arg_544_1.bgmTxt2_.text = var_547_36

						arg_544_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_544_1.bgmTxt_.text = var_547_36
						arg_544_1.bgmTxt2_.text = var_547_36
					end

					if arg_544_1.bgmTimer then
						arg_544_1.bgmTimer:Stop()

						arg_544_1.bgmTimer = nil
					end

					if arg_544_1.settingData.show_music_name == 1 then
						arg_544_1.musicController:SetSelectedState("show")
						arg_544_1.musicAnimator_:Play("open", 0, 0)

						if arg_544_1.settingData.music_time ~= 0 then
							arg_544_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_544_1.settingData.music_time), function()
								if arg_544_1 == nil or isNil(arg_544_1.bgmTxt_) then
									return
								end

								arg_544_1.musicController:SetSelectedState("hide")
								arg_544_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_547_37 = 0.3
			local var_547_38 = 0.9

			if var_547_37 < arg_544_1.time_ and arg_544_1.time_ <= var_547_37 + arg_547_0 then
				local var_547_39 = "play"
				local var_547_40 = "music"

				arg_544_1:AudioAction(var_547_39, var_547_40, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_547_41 = ""
				local var_547_42 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_547_42 ~= "" then
					if arg_544_1.bgmTxt_.text ~= var_547_42 and arg_544_1.bgmTxt_.text ~= "" then
						if arg_544_1.bgmTxt2_.text ~= "" then
							arg_544_1.bgmTxt_.text = arg_544_1.bgmTxt2_.text
						end

						arg_544_1.bgmTxt2_.text = var_547_42

						arg_544_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_544_1.bgmTxt_.text = var_547_42
						arg_544_1.bgmTxt2_.text = var_547_42
					end

					if arg_544_1.bgmTimer then
						arg_544_1.bgmTimer:Stop()

						arg_544_1.bgmTimer = nil
					end

					if arg_544_1.settingData.show_music_name == 1 then
						arg_544_1.musicController:SetSelectedState("show")
						arg_544_1.musicAnimator_:Play("open", 0, 0)

						if arg_544_1.settingData.music_time ~= 0 then
							arg_544_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_544_1.settingData.music_time), function()
								if arg_544_1 == nil or isNil(arg_544_1.bgmTxt_) then
									return
								end

								arg_544_1.musicController:SetSelectedState("hide")
								arg_544_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_544_1.frameCnt_ <= 1 then
				arg_544_1.dialog_:SetActive(false)
			end

			local var_547_43 = 2
			local var_547_44 = 0.85

			if var_547_43 < arg_544_1.time_ and arg_544_1.time_ <= var_547_43 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0

				arg_544_1.dialog_:SetActive(true)

				arg_544_1.dialogCg_.alpha = 0

				local var_547_45 = LeanTween.value(arg_544_1.dialog_, 0, 1, 0.3)

				var_547_45:setOnUpdate(LuaHelper.FloatAction(function(arg_550_0)
					arg_544_1.dialogCg_.alpha = arg_550_0
				end))
				var_547_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_544_1.dialog_)
					var_547_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_544_1.duration_ = arg_544_1.duration_ + 0.3

				SetActive(arg_544_1.leftNameGo_, false)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_46 = arg_544_1:GetWordFromCfg(1109704132)
				local var_547_47 = arg_544_1:FormatText(var_547_46.content)

				arg_544_1.text_.text = var_547_47

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_48 = 34
				local var_547_49 = utf8.len(var_547_47)
				local var_547_50 = var_547_48 <= 0 and var_547_44 or var_547_44 * (var_547_49 / var_547_48)

				if var_547_50 > 0 and var_547_44 < var_547_50 then
					arg_544_1.talkMaxDuration = var_547_50
					var_547_43 = var_547_43 + 0.3

					if var_547_50 + var_547_43 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_50 + var_547_43
					end
				end

				arg_544_1.text_.text = var_547_47
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_51 = var_547_43 + 0.3
			local var_547_52 = math.max(var_547_44, arg_544_1.talkMaxDuration)

			if var_547_51 <= arg_544_1.time_ and arg_544_1.time_ < var_547_51 + var_547_52 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_51) / var_547_52

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_51 + var_547_52 and arg_544_1.time_ < var_547_51 + var_547_52 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_544_1:InitPlayNodeList()
	end,
	Play1109704133 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 1109704133
		arg_552_1.duration_ = 8.57

		local var_552_0 = {
			zh = 8.566,
			ja = 5.366
		}
		local var_552_1 = manager.audio:GetLocalizationFlag()

		if var_552_0[var_552_1] ~= nil then
			arg_552_1.duration_ = var_552_0[var_552_1]
		end

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play1109704134(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0
			local var_555_1 = 1.15

			if var_555_0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				local var_555_2 = arg_552_1:FormatText(StoryNameCfg[216].name)

				arg_552_1.leftNameTxt_.text = var_555_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_3 = arg_552_1:GetWordFromCfg(1109704133)
				local var_555_4 = arg_552_1:FormatText(var_555_3.content)

				arg_552_1.text_.text = var_555_4

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704133", "story_v_side_new_1109704.awb") ~= 0 then
					local var_555_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704133", "story_v_side_new_1109704.awb") / 1000

					if var_555_8 + var_555_0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_8 + var_555_0
					end

					if var_555_3.prefab_name ~= "" and arg_552_1.actors_[var_555_3.prefab_name] ~= nil then
						local var_555_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_3.prefab_name].transform, "story_v_side_new_1109704", "1109704133", "story_v_side_new_1109704.awb")

						arg_552_1:RecordAudio("1109704133", var_555_9)
						arg_552_1:RecordAudio("1109704133", var_555_9)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704133", "story_v_side_new_1109704.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704133", "story_v_side_new_1109704.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_10 = math.max(var_555_1, arg_552_1.talkMaxDuration)

			if var_555_0 <= arg_552_1.time_ and arg_552_1.time_ < var_555_0 + var_555_10 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_0) / var_555_10

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_0 + var_555_10 and arg_552_1.time_ < var_555_0 + var_555_10 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play1109704134 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 1109704134
		arg_556_1.duration_ = 5

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play1109704135(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = arg_556_1.actors_["1097ui_story"]
			local var_559_1 = 0

			if var_559_1 < arg_556_1.time_ and arg_556_1.time_ <= var_559_1 + arg_559_0 and not isNil(var_559_0) and arg_556_1.var_.characterEffect1097ui_story == nil then
				arg_556_1.var_.characterEffect1097ui_story = var_559_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_559_2 = 0.200000002980232

			if var_559_1 <= arg_556_1.time_ and arg_556_1.time_ < var_559_1 + var_559_2 and not isNil(var_559_0) then
				local var_559_3 = (arg_556_1.time_ - var_559_1) / var_559_2

				if arg_556_1.var_.characterEffect1097ui_story and not isNil(var_559_0) then
					local var_559_4 = Mathf.Lerp(0, 0.5, var_559_3)

					arg_556_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_556_1.var_.characterEffect1097ui_story.fillRatio = var_559_4
				end
			end

			if arg_556_1.time_ >= var_559_1 + var_559_2 and arg_556_1.time_ < var_559_1 + var_559_2 + arg_559_0 and not isNil(var_559_0) and arg_556_1.var_.characterEffect1097ui_story then
				local var_559_5 = 0.5

				arg_556_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_556_1.var_.characterEffect1097ui_story.fillRatio = var_559_5
			end

			local var_559_6 = 0
			local var_559_7 = 0.05

			if var_559_6 < arg_556_1.time_ and arg_556_1.time_ <= var_559_6 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				local var_559_8 = arg_556_1:FormatText(StoryNameCfg[7].name)

				arg_556_1.leftNameTxt_.text = var_559_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, true)
				arg_556_1.iconController_:SetSelectedState("hero")

				arg_556_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_556_1.callingController_:SetSelectedState("normal")

				arg_556_1.keyicon_.color = Color.New(1, 1, 1)
				arg_556_1.icon_.color = Color.New(1, 1, 1)

				local var_559_9 = arg_556_1:GetWordFromCfg(1109704134)
				local var_559_10 = arg_556_1:FormatText(var_559_9.content)

				arg_556_1.text_.text = var_559_10

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_11 = 2
				local var_559_12 = utf8.len(var_559_10)
				local var_559_13 = var_559_11 <= 0 and var_559_7 or var_559_7 * (var_559_12 / var_559_11)

				if var_559_13 > 0 and var_559_7 < var_559_13 then
					arg_556_1.talkMaxDuration = var_559_13

					if var_559_13 + var_559_6 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_13 + var_559_6
					end
				end

				arg_556_1.text_.text = var_559_10
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_14 = math.max(var_559_7, arg_556_1.talkMaxDuration)

			if var_559_6 <= arg_556_1.time_ and arg_556_1.time_ < var_559_6 + var_559_14 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_6) / var_559_14

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_6 + var_559_14 and arg_556_1.time_ < var_559_6 + var_559_14 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play1109704135 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 1109704135
		arg_560_1.duration_ = 6.3

		local var_560_0 = {
			zh = 6.3,
			ja = 4.566
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
				arg_560_0:Play1109704136(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = 0
			local var_563_1 = 0.675

			if var_563_0 < arg_560_1.time_ and arg_560_1.time_ <= var_563_0 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				local var_563_2 = arg_560_1:FormatText(StoryNameCfg[216].name)

				arg_560_1.leftNameTxt_.text = var_563_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, true)
				arg_560_1.iconController_:SetSelectedState("hero")

				arg_560_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_560_1.callingController_:SetSelectedState("normal")

				arg_560_1.keyicon_.color = Color.New(1, 1, 1)
				arg_560_1.icon_.color = Color.New(1, 1, 1)

				local var_563_3 = arg_560_1:GetWordFromCfg(1109704135)
				local var_563_4 = arg_560_1:FormatText(var_563_3.content)

				arg_560_1.text_.text = var_563_4

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704135", "story_v_side_new_1109704.awb") ~= 0 then
					local var_563_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704135", "story_v_side_new_1109704.awb") / 1000

					if var_563_8 + var_563_0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_8 + var_563_0
					end

					if var_563_3.prefab_name ~= "" and arg_560_1.actors_[var_563_3.prefab_name] ~= nil then
						local var_563_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_3.prefab_name].transform, "story_v_side_new_1109704", "1109704135", "story_v_side_new_1109704.awb")

						arg_560_1:RecordAudio("1109704135", var_563_9)
						arg_560_1:RecordAudio("1109704135", var_563_9)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704135", "story_v_side_new_1109704.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704135", "story_v_side_new_1109704.awb")
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
	Play1109704136 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 1109704136
		arg_564_1.duration_ = 5

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play1109704137(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = arg_564_1.actors_["1097ui_story"]
			local var_567_1 = 0

			if var_567_1 < arg_564_1.time_ and arg_564_1.time_ <= var_567_1 + arg_567_0 and not isNil(var_567_0) and arg_564_1.var_.characterEffect1097ui_story == nil then
				arg_564_1.var_.characterEffect1097ui_story = var_567_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_567_2 = 0.200000002980232

			if var_567_1 <= arg_564_1.time_ and arg_564_1.time_ < var_567_1 + var_567_2 and not isNil(var_567_0) then
				local var_567_3 = (arg_564_1.time_ - var_567_1) / var_567_2

				if arg_564_1.var_.characterEffect1097ui_story and not isNil(var_567_0) then
					local var_567_4 = Mathf.Lerp(0, 0.5, var_567_3)

					arg_564_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_564_1.var_.characterEffect1097ui_story.fillRatio = var_567_4
				end
			end

			if arg_564_1.time_ >= var_567_1 + var_567_2 and arg_564_1.time_ < var_567_1 + var_567_2 + arg_567_0 and not isNil(var_567_0) and arg_564_1.var_.characterEffect1097ui_story then
				local var_567_5 = 0.5

				arg_564_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_564_1.var_.characterEffect1097ui_story.fillRatio = var_567_5
			end

			local var_567_6 = 0
			local var_567_7 = 0.825

			if var_567_6 < arg_564_1.time_ and arg_564_1.time_ <= var_567_6 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, false)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_8 = arg_564_1:GetWordFromCfg(1109704136)
				local var_567_9 = arg_564_1:FormatText(var_567_8.content)

				arg_564_1.text_.text = var_567_9

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_10 = 33
				local var_567_11 = utf8.len(var_567_9)
				local var_567_12 = var_567_10 <= 0 and var_567_7 or var_567_7 * (var_567_11 / var_567_10)

				if var_567_12 > 0 and var_567_7 < var_567_12 then
					arg_564_1.talkMaxDuration = var_567_12

					if var_567_12 + var_567_6 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_12 + var_567_6
					end
				end

				arg_564_1.text_.text = var_567_9
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_13 = math.max(var_567_7, arg_564_1.talkMaxDuration)

			if var_567_6 <= arg_564_1.time_ and arg_564_1.time_ < var_567_6 + var_567_13 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_6) / var_567_13

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_6 + var_567_13 and arg_564_1.time_ < var_567_6 + var_567_13 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play1109704137 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 1109704137
		arg_568_1.duration_ = 10.8

		local var_568_0 = {
			zh = 8.7,
			ja = 10.8
		}
		local var_568_1 = manager.audio:GetLocalizationFlag()

		if var_568_0[var_568_1] ~= nil then
			arg_568_1.duration_ = var_568_0[var_568_1]
		end

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play1109704138(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = 0
			local var_571_1 = 1.2

			if var_571_0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_0 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				local var_571_2 = arg_568_1:FormatText(StoryNameCfg[216].name)

				arg_568_1.leftNameTxt_.text = var_571_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, true)
				arg_568_1.iconController_:SetSelectedState("hero")

				arg_568_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_568_1.callingController_:SetSelectedState("normal")

				arg_568_1.keyicon_.color = Color.New(1, 1, 1)
				arg_568_1.icon_.color = Color.New(1, 1, 1)

				local var_571_3 = arg_568_1:GetWordFromCfg(1109704137)
				local var_571_4 = arg_568_1:FormatText(var_571_3.content)

				arg_568_1.text_.text = var_571_4

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_5 = 48
				local var_571_6 = utf8.len(var_571_4)
				local var_571_7 = var_571_5 <= 0 and var_571_1 or var_571_1 * (var_571_6 / var_571_5)

				if var_571_7 > 0 and var_571_1 < var_571_7 then
					arg_568_1.talkMaxDuration = var_571_7

					if var_571_7 + var_571_0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_7 + var_571_0
					end
				end

				arg_568_1.text_.text = var_571_4
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704137", "story_v_side_new_1109704.awb") ~= 0 then
					local var_571_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704137", "story_v_side_new_1109704.awb") / 1000

					if var_571_8 + var_571_0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_8 + var_571_0
					end

					if var_571_3.prefab_name ~= "" and arg_568_1.actors_[var_571_3.prefab_name] ~= nil then
						local var_571_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_568_1.actors_[var_571_3.prefab_name].transform, "story_v_side_new_1109704", "1109704137", "story_v_side_new_1109704.awb")

						arg_568_1:RecordAudio("1109704137", var_571_9)
						arg_568_1:RecordAudio("1109704137", var_571_9)
					else
						arg_568_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704137", "story_v_side_new_1109704.awb")
					end

					arg_568_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704137", "story_v_side_new_1109704.awb")
				end

				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_10 = math.max(var_571_1, arg_568_1.talkMaxDuration)

			if var_571_0 <= arg_568_1.time_ and arg_568_1.time_ < var_571_0 + var_571_10 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_0) / var_571_10

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_0 + var_571_10 and arg_568_1.time_ < var_571_0 + var_571_10 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play1109704138 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 1109704138
		arg_572_1.duration_ = 11.37

		local var_572_0 = {
			zh = 8.966,
			ja = 11.366
		}
		local var_572_1 = manager.audio:GetLocalizationFlag()

		if var_572_0[var_572_1] ~= nil then
			arg_572_1.duration_ = var_572_0[var_572_1]
		end

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play1109704139(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = 0
			local var_575_1 = 0.825

			if var_575_0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_0 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				local var_575_2 = arg_572_1:FormatText(StoryNameCfg[216].name)

				arg_572_1.leftNameTxt_.text = var_575_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, true)
				arg_572_1.iconController_:SetSelectedState("hero")

				arg_572_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_572_1.callingController_:SetSelectedState("normal")

				arg_572_1.keyicon_.color = Color.New(1, 1, 1)
				arg_572_1.icon_.color = Color.New(1, 1, 1)

				local var_575_3 = arg_572_1:GetWordFromCfg(1109704138)
				local var_575_4 = arg_572_1:FormatText(var_575_3.content)

				arg_572_1.text_.text = var_575_4

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_5 = 33
				local var_575_6 = utf8.len(var_575_4)
				local var_575_7 = var_575_5 <= 0 and var_575_1 or var_575_1 * (var_575_6 / var_575_5)

				if var_575_7 > 0 and var_575_1 < var_575_7 then
					arg_572_1.talkMaxDuration = var_575_7

					if var_575_7 + var_575_0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_7 + var_575_0
					end
				end

				arg_572_1.text_.text = var_575_4
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704138", "story_v_side_new_1109704.awb") ~= 0 then
					local var_575_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704138", "story_v_side_new_1109704.awb") / 1000

					if var_575_8 + var_575_0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_8 + var_575_0
					end

					if var_575_3.prefab_name ~= "" and arg_572_1.actors_[var_575_3.prefab_name] ~= nil then
						local var_575_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_3.prefab_name].transform, "story_v_side_new_1109704", "1109704138", "story_v_side_new_1109704.awb")

						arg_572_1:RecordAudio("1109704138", var_575_9)
						arg_572_1:RecordAudio("1109704138", var_575_9)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704138", "story_v_side_new_1109704.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704138", "story_v_side_new_1109704.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_10 = math.max(var_575_1, arg_572_1.talkMaxDuration)

			if var_575_0 <= arg_572_1.time_ and arg_572_1.time_ < var_575_0 + var_575_10 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_0) / var_575_10

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_0 + var_575_10 and arg_572_1.time_ < var_575_0 + var_575_10 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play1109704139 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 1109704139
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play1109704140(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = 0
			local var_579_1 = 0.6

			if var_579_0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_0 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0

				arg_576_1.dialog_:SetActive(true)

				arg_576_1.dialogCg_.alpha = 0

				local var_579_2 = LeanTween.value(arg_576_1.dialog_, 0, 1, 0.3)

				var_579_2:setOnUpdate(LuaHelper.FloatAction(function(arg_580_0)
					arg_576_1.dialogCg_.alpha = arg_580_0
				end))
				var_579_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_576_1.dialog_)
					var_579_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_576_1.duration_ = arg_576_1.duration_ + 0.3

				SetActive(arg_576_1.leftNameGo_, false)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_3 = arg_576_1:GetWordFromCfg(1109704139)
				local var_579_4 = arg_576_1:FormatText(var_579_3.content)

				arg_576_1.text_.text = var_579_4

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_5 = 24
				local var_579_6 = utf8.len(var_579_4)
				local var_579_7 = var_579_5 <= 0 and var_579_1 or var_579_1 * (var_579_6 / var_579_5)

				if var_579_7 > 0 and var_579_1 < var_579_7 then
					arg_576_1.talkMaxDuration = var_579_7
					var_579_0 = var_579_0 + 0.3

					if var_579_7 + var_579_0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_7 + var_579_0
					end
				end

				arg_576_1.text_.text = var_579_4
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_8 = var_579_0 + 0.3
			local var_579_9 = math.max(var_579_1, arg_576_1.talkMaxDuration)

			if var_579_8 <= arg_576_1.time_ and arg_576_1.time_ < var_579_8 + var_579_9 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_8) / var_579_9

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_8 + var_579_9 and arg_576_1.time_ < var_579_8 + var_579_9 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play1109704140 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 1109704140
		arg_582_1.duration_ = 5

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play1109704141(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = 0
			local var_585_1 = 0.1

			if var_585_0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_0 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, false)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_2 = arg_582_1:GetWordFromCfg(1109704140)
				local var_585_3 = arg_582_1:FormatText(var_585_2.content)

				arg_582_1.text_.text = var_585_3

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_4 = 4
				local var_585_5 = utf8.len(var_585_3)
				local var_585_6 = var_585_4 <= 0 and var_585_1 or var_585_1 * (var_585_5 / var_585_4)

				if var_585_6 > 0 and var_585_1 < var_585_6 then
					arg_582_1.talkMaxDuration = var_585_6

					if var_585_6 + var_585_0 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_6 + var_585_0
					end
				end

				arg_582_1.text_.text = var_585_3
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_7 = math.max(var_585_1, arg_582_1.talkMaxDuration)

			if var_585_0 <= arg_582_1.time_ and arg_582_1.time_ < var_585_0 + var_585_7 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_0) / var_585_7

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_0 + var_585_7 and arg_582_1.time_ < var_585_0 + var_585_7 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play1109704141 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 1109704141
		arg_586_1.duration_ = 5

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play1109704142(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = 0
			local var_589_1 = 0.05

			if var_589_0 < arg_586_1.time_ and arg_586_1.time_ <= var_589_0 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, false)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_2 = arg_586_1:GetWordFromCfg(1109704141)
				local var_589_3 = arg_586_1:FormatText(var_589_2.content)

				arg_586_1.text_.text = var_589_3

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_4 = 2
				local var_589_5 = utf8.len(var_589_3)
				local var_589_6 = var_589_4 <= 0 and var_589_1 or var_589_1 * (var_589_5 / var_589_4)

				if var_589_6 > 0 and var_589_1 < var_589_6 then
					arg_586_1.talkMaxDuration = var_589_6

					if var_589_6 + var_589_0 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_6 + var_589_0
					end
				end

				arg_586_1.text_.text = var_589_3
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)
				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_7 = math.max(var_589_1, arg_586_1.talkMaxDuration)

			if var_589_0 <= arg_586_1.time_ and arg_586_1.time_ < var_589_0 + var_589_7 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_0) / var_589_7

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_0 + var_589_7 and arg_586_1.time_ < var_589_0 + var_589_7 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {}

		arg_586_1:InitPlayNodeList()
	end,
	Play1109704142 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 1109704142
		arg_590_1.duration_ = 9

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play1109704143(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			local var_593_0 = "F01"

			if arg_590_1.bgs_[var_593_0] == nil then
				local var_593_1 = Object.Instantiate(arg_590_1.paintGo_)

				var_593_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_593_0)
				var_593_1.name = var_593_0
				var_593_1.transform.parent = arg_590_1.stage_.transform
				var_593_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_590_1.bgs_[var_593_0] = var_593_1
			end

			local var_593_2 = 1.999999999999

			if var_593_2 < arg_590_1.time_ and arg_590_1.time_ <= var_593_2 + arg_593_0 then
				local var_593_3 = manager.ui.mainCamera.transform.localPosition
				local var_593_4 = Vector3.New(0, 0, 10) + Vector3.New(var_593_3.x, var_593_3.y, 0)
				local var_593_5 = arg_590_1.bgs_.F01

				var_593_5.transform.localPosition = var_593_4
				var_593_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_593_6 = var_593_5:GetComponent("SpriteRenderer")

				if var_593_6 and var_593_6.sprite then
					local var_593_7 = (var_593_5.transform.localPosition - var_593_3).z
					local var_593_8 = manager.ui.mainCameraCom_
					local var_593_9 = 2 * var_593_7 * Mathf.Tan(var_593_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_593_10 = var_593_9 * var_593_8.aspect
					local var_593_11 = var_593_6.sprite.bounds.size.x
					local var_593_12 = var_593_6.sprite.bounds.size.y
					local var_593_13 = var_593_10 / var_593_11
					local var_593_14 = var_593_9 / var_593_12
					local var_593_15 = var_593_14 < var_593_13 and var_593_13 or var_593_14

					var_593_5.transform.localScale = Vector3.New(var_593_15, var_593_15, 0)
				end

				for iter_593_0, iter_593_1 in pairs(arg_590_1.bgs_) do
					if iter_593_0 ~= "F01" then
						iter_593_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_593_16 = 3.999999999999

			if var_593_16 < arg_590_1.time_ and arg_590_1.time_ <= var_593_16 + arg_593_0 then
				arg_590_1.allBtn_.enabled = false
			end

			local var_593_17 = 0.3

			if arg_590_1.time_ >= var_593_16 + var_593_17 and arg_590_1.time_ < var_593_16 + var_593_17 + arg_593_0 then
				arg_590_1.allBtn_.enabled = true
			end

			local var_593_18 = 0

			if var_593_18 < arg_590_1.time_ and arg_590_1.time_ <= var_593_18 + arg_593_0 then
				arg_590_1.mask_.enabled = true
				arg_590_1.mask_.raycastTarget = true

				arg_590_1:SetGaussion(false)
			end

			local var_593_19 = 2

			if var_593_18 <= arg_590_1.time_ and arg_590_1.time_ < var_593_18 + var_593_19 then
				local var_593_20 = (arg_590_1.time_ - var_593_18) / var_593_19
				local var_593_21 = Color.New(1, 1, 1)

				var_593_21.a = Mathf.Lerp(0, 1, var_593_20)
				arg_590_1.mask_.color = var_593_21
			end

			if arg_590_1.time_ >= var_593_18 + var_593_19 and arg_590_1.time_ < var_593_18 + var_593_19 + arg_593_0 then
				local var_593_22 = Color.New(1, 1, 1)

				var_593_22.a = 1
				arg_590_1.mask_.color = var_593_22
			end

			local var_593_23 = 2

			if var_593_23 < arg_590_1.time_ and arg_590_1.time_ <= var_593_23 + arg_593_0 then
				arg_590_1.mask_.enabled = true
				arg_590_1.mask_.raycastTarget = true

				arg_590_1:SetGaussion(false)
			end

			local var_593_24 = 2

			if var_593_23 <= arg_590_1.time_ and arg_590_1.time_ < var_593_23 + var_593_24 then
				local var_593_25 = (arg_590_1.time_ - var_593_23) / var_593_24
				local var_593_26 = Color.New(1, 1, 1)

				var_593_26.a = Mathf.Lerp(1, 0, var_593_25)
				arg_590_1.mask_.color = var_593_26
			end

			if arg_590_1.time_ >= var_593_23 + var_593_24 and arg_590_1.time_ < var_593_23 + var_593_24 + arg_593_0 then
				local var_593_27 = Color.New(1, 1, 1)
				local var_593_28 = 0

				arg_590_1.mask_.enabled = false
				var_593_27.a = var_593_28
				arg_590_1.mask_.color = var_593_27
			end

			if arg_590_1.frameCnt_ <= 1 then
				arg_590_1.dialog_:SetActive(false)
			end

			local var_593_29 = 3.999999999999
			local var_593_30 = 0.15

			if var_593_29 < arg_590_1.time_ and arg_590_1.time_ <= var_593_29 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0

				arg_590_1.dialog_:SetActive(true)

				arg_590_1.dialogCg_.alpha = 0

				local var_593_31 = LeanTween.value(arg_590_1.dialog_, 0, 1, 0.3)

				var_593_31:setOnUpdate(LuaHelper.FloatAction(function(arg_594_0)
					arg_590_1.dialogCg_.alpha = arg_594_0
				end))
				var_593_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_590_1.dialog_)
					var_593_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_590_1.duration_ = arg_590_1.duration_ + 0.3

				SetActive(arg_590_1.leftNameGo_, true)

				local var_593_32 = arg_590_1:FormatText(StoryNameCfg[7].name)

				arg_590_1.leftNameTxt_.text = var_593_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, true)
				arg_590_1.iconController_:SetSelectedState("hero")

				arg_590_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_590_1.callingController_:SetSelectedState("normal")

				arg_590_1.keyicon_.color = Color.New(1, 1, 1)
				arg_590_1.icon_.color = Color.New(1, 1, 1)

				local var_593_33 = arg_590_1:GetWordFromCfg(1109704142)
				local var_593_34 = arg_590_1:FormatText(var_593_33.content)

				arg_590_1.text_.text = var_593_34

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_35 = 6
				local var_593_36 = utf8.len(var_593_34)
				local var_593_37 = var_593_35 <= 0 and var_593_30 or var_593_30 * (var_593_36 / var_593_35)

				if var_593_37 > 0 and var_593_30 < var_593_37 then
					arg_590_1.talkMaxDuration = var_593_37
					var_593_29 = var_593_29 + 0.3

					if var_593_37 + var_593_29 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_37 + var_593_29
					end
				end

				arg_590_1.text_.text = var_593_34
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)
				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_38 = var_593_29 + 0.3
			local var_593_39 = math.max(var_593_30, arg_590_1.talkMaxDuration)

			if var_593_38 <= arg_590_1.time_ and arg_590_1.time_ < var_593_38 + var_593_39 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_38) / var_593_39

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_38 + var_593_39 and arg_590_1.time_ < var_593_38 + var_593_39 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {}

		arg_590_1:InitPlayNodeList()
	end,
	Play1109704143 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 1109704143
		arg_596_1.duration_ = 10.9

		local var_596_0 = {
			zh = 7.433,
			ja = 10.9
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
				arg_596_0:Play1109704144(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = "1042ui_story"

			if arg_596_1.actors_[var_599_0] == nil then
				local var_599_1 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_599_1) then
					local var_599_2 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_596_1.stage_.transform)

					var_599_2.name = var_599_0
					var_599_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_596_1.actors_[var_599_0] = var_599_2

					local var_599_3 = var_599_2:GetComponentInChildren(typeof(CharacterEffect))

					var_599_3.enabled = true

					local var_599_4 = GameObjectTools.GetOrAddComponent(var_599_2, typeof(DynamicBoneHelper))

					if var_599_4 then
						var_599_4:EnableDynamicBone(false)
					end

					arg_596_1:ShowWeapon(var_599_3.transform, false)

					arg_596_1.var_[var_599_0 .. "Animator"] = var_599_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_596_1.var_[var_599_0 .. "Animator"].applyRootMotion = true
					arg_596_1.var_[var_599_0 .. "LipSync"] = var_599_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_599_5 = arg_596_1.actors_["1042ui_story"].transform
			local var_599_6 = 0

			if var_599_6 < arg_596_1.time_ and arg_596_1.time_ <= var_599_6 + arg_599_0 then
				arg_596_1.var_.moveOldPos1042ui_story = var_599_5.localPosition
			end

			local var_599_7 = 0.001

			if var_599_6 <= arg_596_1.time_ and arg_596_1.time_ < var_599_6 + var_599_7 then
				local var_599_8 = (arg_596_1.time_ - var_599_6) / var_599_7
				local var_599_9 = Vector3.New(0, -1.06, -6.2)

				var_599_5.localPosition = Vector3.Lerp(arg_596_1.var_.moveOldPos1042ui_story, var_599_9, var_599_8)

				local var_599_10 = manager.ui.mainCamera.transform.position - var_599_5.position

				var_599_5.forward = Vector3.New(var_599_10.x, var_599_10.y, var_599_10.z)

				local var_599_11 = var_599_5.localEulerAngles

				var_599_11.z = 0
				var_599_11.x = 0
				var_599_5.localEulerAngles = var_599_11
			end

			if arg_596_1.time_ >= var_599_6 + var_599_7 and arg_596_1.time_ < var_599_6 + var_599_7 + arg_599_0 then
				var_599_5.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_599_12 = manager.ui.mainCamera.transform.position - var_599_5.position

				var_599_5.forward = Vector3.New(var_599_12.x, var_599_12.y, var_599_12.z)

				local var_599_13 = var_599_5.localEulerAngles

				var_599_13.z = 0
				var_599_13.x = 0
				var_599_5.localEulerAngles = var_599_13
			end

			local var_599_14 = arg_596_1.actors_["1042ui_story"]
			local var_599_15 = 0

			if var_599_15 < arg_596_1.time_ and arg_596_1.time_ <= var_599_15 + arg_599_0 and not isNil(var_599_14) and arg_596_1.var_.characterEffect1042ui_story == nil then
				arg_596_1.var_.characterEffect1042ui_story = var_599_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_599_16 = 0.200000002980232

			if var_599_15 <= arg_596_1.time_ and arg_596_1.time_ < var_599_15 + var_599_16 and not isNil(var_599_14) then
				local var_599_17 = (arg_596_1.time_ - var_599_15) / var_599_16

				if arg_596_1.var_.characterEffect1042ui_story and not isNil(var_599_14) then
					arg_596_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_596_1.time_ >= var_599_15 + var_599_16 and arg_596_1.time_ < var_599_15 + var_599_16 + arg_599_0 and not isNil(var_599_14) and arg_596_1.var_.characterEffect1042ui_story then
				arg_596_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_599_18 = 0

			if var_599_18 < arg_596_1.time_ and arg_596_1.time_ <= var_599_18 + arg_599_0 then
				arg_596_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_599_19 = 0

			if var_599_19 < arg_596_1.time_ and arg_596_1.time_ <= var_599_19 + arg_599_0 then
				arg_596_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_599_20 = 0
			local var_599_21 = 0.725

			if var_599_20 < arg_596_1.time_ and arg_596_1.time_ <= var_599_20 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				local var_599_22 = arg_596_1:FormatText(StoryNameCfg[205].name)

				arg_596_1.leftNameTxt_.text = var_599_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_23 = arg_596_1:GetWordFromCfg(1109704143)
				local var_599_24 = arg_596_1:FormatText(var_599_23.content)

				arg_596_1.text_.text = var_599_24

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_25 = 29
				local var_599_26 = utf8.len(var_599_24)
				local var_599_27 = var_599_25 <= 0 and var_599_21 or var_599_21 * (var_599_26 / var_599_25)

				if var_599_27 > 0 and var_599_21 < var_599_27 then
					arg_596_1.talkMaxDuration = var_599_27

					if var_599_27 + var_599_20 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_27 + var_599_20
					end
				end

				arg_596_1.text_.text = var_599_24
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704143", "story_v_side_new_1109704.awb") ~= 0 then
					local var_599_28 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704143", "story_v_side_new_1109704.awb") / 1000

					if var_599_28 + var_599_20 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_28 + var_599_20
					end

					if var_599_23.prefab_name ~= "" and arg_596_1.actors_[var_599_23.prefab_name] ~= nil then
						local var_599_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_23.prefab_name].transform, "story_v_side_new_1109704", "1109704143", "story_v_side_new_1109704.awb")

						arg_596_1:RecordAudio("1109704143", var_599_29)
						arg_596_1:RecordAudio("1109704143", var_599_29)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704143", "story_v_side_new_1109704.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704143", "story_v_side_new_1109704.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_30 = math.max(var_599_21, arg_596_1.talkMaxDuration)

			if var_599_20 <= arg_596_1.time_ and arg_596_1.time_ < var_599_20 + var_599_30 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_20) / var_599_30

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_20 + var_599_30 and arg_596_1.time_ < var_599_20 + var_599_30 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_596_1:InitPlayNodeList()
	end,
	Play1109704144 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 1109704144
		arg_600_1.duration_ = 5

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play1109704145(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = arg_600_1.actors_["1042ui_story"]
			local var_603_1 = 0

			if var_603_1 < arg_600_1.time_ and arg_600_1.time_ <= var_603_1 + arg_603_0 and not isNil(var_603_0) and arg_600_1.var_.characterEffect1042ui_story == nil then
				arg_600_1.var_.characterEffect1042ui_story = var_603_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_603_2 = 0.200000002980232

			if var_603_1 <= arg_600_1.time_ and arg_600_1.time_ < var_603_1 + var_603_2 and not isNil(var_603_0) then
				local var_603_3 = (arg_600_1.time_ - var_603_1) / var_603_2

				if arg_600_1.var_.characterEffect1042ui_story and not isNil(var_603_0) then
					local var_603_4 = Mathf.Lerp(0, 0.5, var_603_3)

					arg_600_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_600_1.var_.characterEffect1042ui_story.fillRatio = var_603_4
				end
			end

			if arg_600_1.time_ >= var_603_1 + var_603_2 and arg_600_1.time_ < var_603_1 + var_603_2 + arg_603_0 and not isNil(var_603_0) and arg_600_1.var_.characterEffect1042ui_story then
				local var_603_5 = 0.5

				arg_600_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_600_1.var_.characterEffect1042ui_story.fillRatio = var_603_5
			end

			local var_603_6 = 0
			local var_603_7 = 0.05

			if var_603_6 < arg_600_1.time_ and arg_600_1.time_ <= var_603_6 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, true)

				local var_603_8 = arg_600_1:FormatText(StoryNameCfg[7].name)

				arg_600_1.leftNameTxt_.text = var_603_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_600_1.leftNameTxt_.transform)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1.leftNameTxt_.text)
				SetActive(arg_600_1.iconTrs_.gameObject, true)
				arg_600_1.iconController_:SetSelectedState("hero")

				arg_600_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_600_1.callingController_:SetSelectedState("normal")

				arg_600_1.keyicon_.color = Color.New(1, 1, 1)
				arg_600_1.icon_.color = Color.New(1, 1, 1)

				local var_603_9 = arg_600_1:GetWordFromCfg(1109704144)
				local var_603_10 = arg_600_1:FormatText(var_603_9.content)

				arg_600_1.text_.text = var_603_10

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_11 = 2
				local var_603_12 = utf8.len(var_603_10)
				local var_603_13 = var_603_11 <= 0 and var_603_7 or var_603_7 * (var_603_12 / var_603_11)

				if var_603_13 > 0 and var_603_7 < var_603_13 then
					arg_600_1.talkMaxDuration = var_603_13

					if var_603_13 + var_603_6 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_13 + var_603_6
					end
				end

				arg_600_1.text_.text = var_603_10
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)
				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_14 = math.max(var_603_7, arg_600_1.talkMaxDuration)

			if var_603_6 <= arg_600_1.time_ and arg_600_1.time_ < var_603_6 + var_603_14 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_6) / var_603_14

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_6 + var_603_14 and arg_600_1.time_ < var_603_6 + var_603_14 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play1109704145 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 1109704145
		arg_604_1.duration_ = 5

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play1109704146(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = 0
			local var_607_1 = 1.275

			if var_607_0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_0 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, false)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_2 = arg_604_1:GetWordFromCfg(1109704145)
				local var_607_3 = arg_604_1:FormatText(var_607_2.content)

				arg_604_1.text_.text = var_607_3

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_4 = 51
				local var_607_5 = utf8.len(var_607_3)
				local var_607_6 = var_607_4 <= 0 and var_607_1 or var_607_1 * (var_607_5 / var_607_4)

				if var_607_6 > 0 and var_607_1 < var_607_6 then
					arg_604_1.talkMaxDuration = var_607_6

					if var_607_6 + var_607_0 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_6 + var_607_0
					end
				end

				arg_604_1.text_.text = var_607_3
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)
				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_7 = math.max(var_607_1, arg_604_1.talkMaxDuration)

			if var_607_0 <= arg_604_1.time_ and arg_604_1.time_ < var_607_0 + var_607_7 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_0) / var_607_7

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_0 + var_607_7 and arg_604_1.time_ < var_607_0 + var_607_7 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play1109704146 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 1109704146
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play1109704147(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = 0
			local var_611_1 = 0.75

			if var_611_0 < arg_608_1.time_ and arg_608_1.time_ <= var_611_0 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				local var_611_2 = arg_608_1:FormatText(StoryNameCfg[7].name)

				arg_608_1.leftNameTxt_.text = var_611_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, true)
				arg_608_1.iconController_:SetSelectedState("hero")

				arg_608_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_608_1.callingController_:SetSelectedState("normal")

				arg_608_1.keyicon_.color = Color.New(1, 1, 1)
				arg_608_1.icon_.color = Color.New(1, 1, 1)

				local var_611_3 = arg_608_1:GetWordFromCfg(1109704146)
				local var_611_4 = arg_608_1:FormatText(var_611_3.content)

				arg_608_1.text_.text = var_611_4

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_5 = 30
				local var_611_6 = utf8.len(var_611_4)
				local var_611_7 = var_611_5 <= 0 and var_611_1 or var_611_1 * (var_611_6 / var_611_5)

				if var_611_7 > 0 and var_611_1 < var_611_7 then
					arg_608_1.talkMaxDuration = var_611_7

					if var_611_7 + var_611_0 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_7 + var_611_0
					end
				end

				arg_608_1.text_.text = var_611_4
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_8 = math.max(var_611_1, arg_608_1.talkMaxDuration)

			if var_611_0 <= arg_608_1.time_ and arg_608_1.time_ < var_611_0 + var_611_8 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_0) / var_611_8

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_0 + var_611_8 and arg_608_1.time_ < var_611_0 + var_611_8 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {}

		arg_608_1:InitPlayNodeList()
	end,
	Play1109704147 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 1109704147
		arg_612_1.duration_ = 8.83

		local var_612_0 = {
			zh = 8.8,
			ja = 8.833
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
				arg_612_0:Play1109704148(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = arg_612_1.actors_["1042ui_story"].transform
			local var_615_1 = 0

			if var_615_1 < arg_612_1.time_ and arg_612_1.time_ <= var_615_1 + arg_615_0 then
				arg_612_1.var_.moveOldPos1042ui_story = var_615_0.localPosition
			end

			local var_615_2 = 0.001

			if var_615_1 <= arg_612_1.time_ and arg_612_1.time_ < var_615_1 + var_615_2 then
				local var_615_3 = (arg_612_1.time_ - var_615_1) / var_615_2
				local var_615_4 = Vector3.New(0, -1.06, -6.2)

				var_615_0.localPosition = Vector3.Lerp(arg_612_1.var_.moveOldPos1042ui_story, var_615_4, var_615_3)

				local var_615_5 = manager.ui.mainCamera.transform.position - var_615_0.position

				var_615_0.forward = Vector3.New(var_615_5.x, var_615_5.y, var_615_5.z)

				local var_615_6 = var_615_0.localEulerAngles

				var_615_6.z = 0
				var_615_6.x = 0
				var_615_0.localEulerAngles = var_615_6
			end

			if arg_612_1.time_ >= var_615_1 + var_615_2 and arg_612_1.time_ < var_615_1 + var_615_2 + arg_615_0 then
				var_615_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_615_7 = manager.ui.mainCamera.transform.position - var_615_0.position

				var_615_0.forward = Vector3.New(var_615_7.x, var_615_7.y, var_615_7.z)

				local var_615_8 = var_615_0.localEulerAngles

				var_615_8.z = 0
				var_615_8.x = 0
				var_615_0.localEulerAngles = var_615_8
			end

			local var_615_9 = arg_612_1.actors_["1042ui_story"]
			local var_615_10 = 0

			if var_615_10 < arg_612_1.time_ and arg_612_1.time_ <= var_615_10 + arg_615_0 and not isNil(var_615_9) and arg_612_1.var_.characterEffect1042ui_story == nil then
				arg_612_1.var_.characterEffect1042ui_story = var_615_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_615_11 = 0.200000002980232

			if var_615_10 <= arg_612_1.time_ and arg_612_1.time_ < var_615_10 + var_615_11 and not isNil(var_615_9) then
				local var_615_12 = (arg_612_1.time_ - var_615_10) / var_615_11

				if arg_612_1.var_.characterEffect1042ui_story and not isNil(var_615_9) then
					arg_612_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_612_1.time_ >= var_615_10 + var_615_11 and arg_612_1.time_ < var_615_10 + var_615_11 + arg_615_0 and not isNil(var_615_9) and arg_612_1.var_.characterEffect1042ui_story then
				arg_612_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_615_13 = 0

			if var_615_13 < arg_612_1.time_ and arg_612_1.time_ <= var_615_13 + arg_615_0 then
				arg_612_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_615_14 = 0

			if var_615_14 < arg_612_1.time_ and arg_612_1.time_ <= var_615_14 + arg_615_0 then
				arg_612_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_615_15 = 0
			local var_615_16 = 0.975

			if var_615_15 < arg_612_1.time_ and arg_612_1.time_ <= var_615_15 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				local var_615_17 = arg_612_1:FormatText(StoryNameCfg[205].name)

				arg_612_1.leftNameTxt_.text = var_615_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_18 = arg_612_1:GetWordFromCfg(1109704147)
				local var_615_19 = arg_612_1:FormatText(var_615_18.content)

				arg_612_1.text_.text = var_615_19

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_20 = 39
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704147", "story_v_side_new_1109704.awb") ~= 0 then
					local var_615_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704147", "story_v_side_new_1109704.awb") / 1000

					if var_615_23 + var_615_15 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_23 + var_615_15
					end

					if var_615_18.prefab_name ~= "" and arg_612_1.actors_[var_615_18.prefab_name] ~= nil then
						local var_615_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_612_1.actors_[var_615_18.prefab_name].transform, "story_v_side_new_1109704", "1109704147", "story_v_side_new_1109704.awb")

						arg_612_1:RecordAudio("1109704147", var_615_24)
						arg_612_1:RecordAudio("1109704147", var_615_24)
					else
						arg_612_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704147", "story_v_side_new_1109704.awb")
					end

					arg_612_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704147", "story_v_side_new_1109704.awb")
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
				actorName = "1042ui_story",
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
	Play1109704148 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 1109704148
		arg_616_1.duration_ = 5

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play1109704149(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = arg_616_1.actors_["1042ui_story"]
			local var_619_1 = 0

			if var_619_1 < arg_616_1.time_ and arg_616_1.time_ <= var_619_1 + arg_619_0 and not isNil(var_619_0) and arg_616_1.var_.characterEffect1042ui_story == nil then
				arg_616_1.var_.characterEffect1042ui_story = var_619_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_619_2 = 0.200000002980232

			if var_619_1 <= arg_616_1.time_ and arg_616_1.time_ < var_619_1 + var_619_2 and not isNil(var_619_0) then
				local var_619_3 = (arg_616_1.time_ - var_619_1) / var_619_2

				if arg_616_1.var_.characterEffect1042ui_story and not isNil(var_619_0) then
					local var_619_4 = Mathf.Lerp(0, 0.5, var_619_3)

					arg_616_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_616_1.var_.characterEffect1042ui_story.fillRatio = var_619_4
				end
			end

			if arg_616_1.time_ >= var_619_1 + var_619_2 and arg_616_1.time_ < var_619_1 + var_619_2 + arg_619_0 and not isNil(var_619_0) and arg_616_1.var_.characterEffect1042ui_story then
				local var_619_5 = 0.5

				arg_616_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_616_1.var_.characterEffect1042ui_story.fillRatio = var_619_5
			end

			local var_619_6 = 0
			local var_619_7 = 0.075

			if var_619_6 < arg_616_1.time_ and arg_616_1.time_ <= var_619_6 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, true)

				local var_619_8 = arg_616_1:FormatText(StoryNameCfg[7].name)

				arg_616_1.leftNameTxt_.text = var_619_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_616_1.leftNameTxt_.transform)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1.leftNameTxt_.text)
				SetActive(arg_616_1.iconTrs_.gameObject, true)
				arg_616_1.iconController_:SetSelectedState("hero")

				arg_616_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_616_1.callingController_:SetSelectedState("normal")

				arg_616_1.keyicon_.color = Color.New(1, 1, 1)
				arg_616_1.icon_.color = Color.New(1, 1, 1)

				local var_619_9 = arg_616_1:GetWordFromCfg(1109704148)
				local var_619_10 = arg_616_1:FormatText(var_619_9.content)

				arg_616_1.text_.text = var_619_10

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_11 = 3
				local var_619_12 = utf8.len(var_619_10)
				local var_619_13 = var_619_11 <= 0 and var_619_7 or var_619_7 * (var_619_12 / var_619_11)

				if var_619_13 > 0 and var_619_7 < var_619_13 then
					arg_616_1.talkMaxDuration = var_619_13

					if var_619_13 + var_619_6 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_13 + var_619_6
					end
				end

				arg_616_1.text_.text = var_619_10
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)
				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_14 = math.max(var_619_7, arg_616_1.talkMaxDuration)

			if var_619_6 <= arg_616_1.time_ and arg_616_1.time_ < var_619_6 + var_619_14 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_6) / var_619_14

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_6 + var_619_14 and arg_616_1.time_ < var_619_6 + var_619_14 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play1109704149 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 1109704149
		arg_620_1.duration_ = 5

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play1109704150(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 0
			local var_623_1 = 1.475

			if var_623_0 < arg_620_1.time_ and arg_620_1.time_ <= var_623_0 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, false)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_2 = arg_620_1:GetWordFromCfg(1109704149)
				local var_623_3 = arg_620_1:FormatText(var_623_2.content)

				arg_620_1.text_.text = var_623_3

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_4 = 59
				local var_623_5 = utf8.len(var_623_3)
				local var_623_6 = var_623_4 <= 0 and var_623_1 or var_623_1 * (var_623_5 / var_623_4)

				if var_623_6 > 0 and var_623_1 < var_623_6 then
					arg_620_1.talkMaxDuration = var_623_6

					if var_623_6 + var_623_0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_6 + var_623_0
					end
				end

				arg_620_1.text_.text = var_623_3
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)
				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_7 = math.max(var_623_1, arg_620_1.talkMaxDuration)

			if var_623_0 <= arg_620_1.time_ and arg_620_1.time_ < var_623_0 + var_623_7 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_0) / var_623_7

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_0 + var_623_7 and arg_620_1.time_ < var_623_0 + var_623_7 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play1109704150 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 1109704150
		arg_624_1.duration_ = 5

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play1109704151(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = 0
			local var_627_1 = 0.625

			if var_627_0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_0 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				local var_627_2 = arg_624_1:FormatText(StoryNameCfg[7].name)

				arg_624_1.leftNameTxt_.text = var_627_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, true)
				arg_624_1.iconController_:SetSelectedState("hero")

				arg_624_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_624_1.callingController_:SetSelectedState("normal")

				arg_624_1.keyicon_.color = Color.New(1, 1, 1)
				arg_624_1.icon_.color = Color.New(1, 1, 1)

				local var_627_3 = arg_624_1:GetWordFromCfg(1109704150)
				local var_627_4 = arg_624_1:FormatText(var_627_3.content)

				arg_624_1.text_.text = var_627_4

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_5 = 25
				local var_627_6 = utf8.len(var_627_4)
				local var_627_7 = var_627_5 <= 0 and var_627_1 or var_627_1 * (var_627_6 / var_627_5)

				if var_627_7 > 0 and var_627_1 < var_627_7 then
					arg_624_1.talkMaxDuration = var_627_7

					if var_627_7 + var_627_0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_7 + var_627_0
					end
				end

				arg_624_1.text_.text = var_627_4
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)
				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_8 = math.max(var_627_1, arg_624_1.talkMaxDuration)

			if var_627_0 <= arg_624_1.time_ and arg_624_1.time_ < var_627_0 + var_627_8 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_0) / var_627_8

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_0 + var_627_8 and arg_624_1.time_ < var_627_0 + var_627_8 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {}

		arg_624_1:InitPlayNodeList()
	end,
	Play1109704151 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 1109704151
		arg_628_1.duration_ = 3.5

		local var_628_0 = {
			zh = 3.4,
			ja = 3.5
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
				arg_628_0:Play1109704152(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			local var_631_0 = arg_628_1.actors_["1042ui_story"].transform
			local var_631_1 = 0

			if var_631_1 < arg_628_1.time_ and arg_628_1.time_ <= var_631_1 + arg_631_0 then
				arg_628_1.var_.moveOldPos1042ui_story = var_631_0.localPosition
			end

			local var_631_2 = 0.001

			if var_631_1 <= arg_628_1.time_ and arg_628_1.time_ < var_631_1 + var_631_2 then
				local var_631_3 = (arg_628_1.time_ - var_631_1) / var_631_2
				local var_631_4 = Vector3.New(0, -1.06, -6.2)

				var_631_0.localPosition = Vector3.Lerp(arg_628_1.var_.moveOldPos1042ui_story, var_631_4, var_631_3)

				local var_631_5 = manager.ui.mainCamera.transform.position - var_631_0.position

				var_631_0.forward = Vector3.New(var_631_5.x, var_631_5.y, var_631_5.z)

				local var_631_6 = var_631_0.localEulerAngles

				var_631_6.z = 0
				var_631_6.x = 0
				var_631_0.localEulerAngles = var_631_6
			end

			if arg_628_1.time_ >= var_631_1 + var_631_2 and arg_628_1.time_ < var_631_1 + var_631_2 + arg_631_0 then
				var_631_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_631_7 = manager.ui.mainCamera.transform.position - var_631_0.position

				var_631_0.forward = Vector3.New(var_631_7.x, var_631_7.y, var_631_7.z)

				local var_631_8 = var_631_0.localEulerAngles

				var_631_8.z = 0
				var_631_8.x = 0
				var_631_0.localEulerAngles = var_631_8
			end

			local var_631_9 = arg_628_1.actors_["1042ui_story"]
			local var_631_10 = 0

			if var_631_10 < arg_628_1.time_ and arg_628_1.time_ <= var_631_10 + arg_631_0 and not isNil(var_631_9) and arg_628_1.var_.characterEffect1042ui_story == nil then
				arg_628_1.var_.characterEffect1042ui_story = var_631_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_631_11 = 0.200000002980232

			if var_631_10 <= arg_628_1.time_ and arg_628_1.time_ < var_631_10 + var_631_11 and not isNil(var_631_9) then
				local var_631_12 = (arg_628_1.time_ - var_631_10) / var_631_11

				if arg_628_1.var_.characterEffect1042ui_story and not isNil(var_631_9) then
					arg_628_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_628_1.time_ >= var_631_10 + var_631_11 and arg_628_1.time_ < var_631_10 + var_631_11 + arg_631_0 and not isNil(var_631_9) and arg_628_1.var_.characterEffect1042ui_story then
				arg_628_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_631_13 = 0

			if var_631_13 < arg_628_1.time_ and arg_628_1.time_ <= var_631_13 + arg_631_0 then
				arg_628_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_631_14 = 0

			if var_631_14 < arg_628_1.time_ and arg_628_1.time_ <= var_631_14 + arg_631_0 then
				arg_628_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_631_15 = 0
			local var_631_16 = 0.35

			if var_631_15 < arg_628_1.time_ and arg_628_1.time_ <= var_631_15 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				local var_631_17 = arg_628_1:FormatText(StoryNameCfg[205].name)

				arg_628_1.leftNameTxt_.text = var_631_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, false)
				arg_628_1.callingController_:SetSelectedState("normal")

				local var_631_18 = arg_628_1:GetWordFromCfg(1109704151)
				local var_631_19 = arg_628_1:FormatText(var_631_18.content)

				arg_628_1.text_.text = var_631_19

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704151", "story_v_side_new_1109704.awb") ~= 0 then
					local var_631_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704151", "story_v_side_new_1109704.awb") / 1000

					if var_631_23 + var_631_15 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_23 + var_631_15
					end

					if var_631_18.prefab_name ~= "" and arg_628_1.actors_[var_631_18.prefab_name] ~= nil then
						local var_631_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_628_1.actors_[var_631_18.prefab_name].transform, "story_v_side_new_1109704", "1109704151", "story_v_side_new_1109704.awb")

						arg_628_1:RecordAudio("1109704151", var_631_24)
						arg_628_1:RecordAudio("1109704151", var_631_24)
					else
						arg_628_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704151", "story_v_side_new_1109704.awb")
					end

					arg_628_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704151", "story_v_side_new_1109704.awb")
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
				actorName = "1042ui_story",
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
	Play1109704152 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 1109704152
		arg_632_1.duration_ = 10.93

		local var_632_0 = {
			zh = 10.933,
			ja = 8.9
		}
		local var_632_1 = manager.audio:GetLocalizationFlag()

		if var_632_0[var_632_1] ~= nil then
			arg_632_1.duration_ = var_632_0[var_632_1]
		end

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play1109704153(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			local var_635_0 = 0

			if var_635_0 < arg_632_1.time_ and arg_632_1.time_ <= var_635_0 + arg_635_0 then
				arg_632_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action6_1")
			end

			local var_635_1 = 0

			if var_635_1 < arg_632_1.time_ and arg_632_1.time_ <= var_635_1 + arg_635_0 then
				arg_632_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_635_2 = 0
			local var_635_3 = 1.225

			if var_635_2 < arg_632_1.time_ and arg_632_1.time_ <= var_635_2 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				local var_635_4 = arg_632_1:FormatText(StoryNameCfg[205].name)

				arg_632_1.leftNameTxt_.text = var_635_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, false)
				arg_632_1.callingController_:SetSelectedState("normal")

				local var_635_5 = arg_632_1:GetWordFromCfg(1109704152)
				local var_635_6 = arg_632_1:FormatText(var_635_5.content)

				arg_632_1.text_.text = var_635_6

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_7 = 49
				local var_635_8 = utf8.len(var_635_6)
				local var_635_9 = var_635_7 <= 0 and var_635_3 or var_635_3 * (var_635_8 / var_635_7)

				if var_635_9 > 0 and var_635_3 < var_635_9 then
					arg_632_1.talkMaxDuration = var_635_9

					if var_635_9 + var_635_2 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_9 + var_635_2
					end
				end

				arg_632_1.text_.text = var_635_6
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704152", "story_v_side_new_1109704.awb") ~= 0 then
					local var_635_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704152", "story_v_side_new_1109704.awb") / 1000

					if var_635_10 + var_635_2 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_10 + var_635_2
					end

					if var_635_5.prefab_name ~= "" and arg_632_1.actors_[var_635_5.prefab_name] ~= nil then
						local var_635_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_632_1.actors_[var_635_5.prefab_name].transform, "story_v_side_new_1109704", "1109704152", "story_v_side_new_1109704.awb")

						arg_632_1:RecordAudio("1109704152", var_635_11)
						arg_632_1:RecordAudio("1109704152", var_635_11)
					else
						arg_632_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704152", "story_v_side_new_1109704.awb")
					end

					arg_632_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704152", "story_v_side_new_1109704.awb")
				end

				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_12 = math.max(var_635_3, arg_632_1.talkMaxDuration)

			if var_635_2 <= arg_632_1.time_ and arg_632_1.time_ < var_635_2 + var_635_12 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_2) / var_635_12

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_2 + var_635_12 and arg_632_1.time_ < var_635_2 + var_635_12 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {}

		arg_632_1:InitPlayNodeList()
	end,
	Play1109704153 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 1109704153
		arg_636_1.duration_ = 5

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play1109704154(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			local var_639_0 = arg_636_1.actors_["1042ui_story"]
			local var_639_1 = 0

			if var_639_1 < arg_636_1.time_ and arg_636_1.time_ <= var_639_1 + arg_639_0 and not isNil(var_639_0) and arg_636_1.var_.characterEffect1042ui_story == nil then
				arg_636_1.var_.characterEffect1042ui_story = var_639_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_639_2 = 0.200000002980232

			if var_639_1 <= arg_636_1.time_ and arg_636_1.time_ < var_639_1 + var_639_2 and not isNil(var_639_0) then
				local var_639_3 = (arg_636_1.time_ - var_639_1) / var_639_2

				if arg_636_1.var_.characterEffect1042ui_story and not isNil(var_639_0) then
					local var_639_4 = Mathf.Lerp(0, 0.5, var_639_3)

					arg_636_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_636_1.var_.characterEffect1042ui_story.fillRatio = var_639_4
				end
			end

			if arg_636_1.time_ >= var_639_1 + var_639_2 and arg_636_1.time_ < var_639_1 + var_639_2 + arg_639_0 and not isNil(var_639_0) and arg_636_1.var_.characterEffect1042ui_story then
				local var_639_5 = 0.5

				arg_636_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_636_1.var_.characterEffect1042ui_story.fillRatio = var_639_5
			end

			local var_639_6 = 0
			local var_639_7 = 0.3

			if var_639_6 < arg_636_1.time_ and arg_636_1.time_ <= var_639_6 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, true)

				local var_639_8 = arg_636_1:FormatText(StoryNameCfg[7].name)

				arg_636_1.leftNameTxt_.text = var_639_8

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

				local var_639_9 = arg_636_1:GetWordFromCfg(1109704153)
				local var_639_10 = arg_636_1:FormatText(var_639_9.content)

				arg_636_1.text_.text = var_639_10

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_11 = 12
				local var_639_12 = utf8.len(var_639_10)
				local var_639_13 = var_639_11 <= 0 and var_639_7 or var_639_7 * (var_639_12 / var_639_11)

				if var_639_13 > 0 and var_639_7 < var_639_13 then
					arg_636_1.talkMaxDuration = var_639_13

					if var_639_13 + var_639_6 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_13 + var_639_6
					end
				end

				arg_636_1.text_.text = var_639_10
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)
				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_14 = math.max(var_639_7, arg_636_1.talkMaxDuration)

			if var_639_6 <= arg_636_1.time_ and arg_636_1.time_ < var_639_6 + var_639_14 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - var_639_6) / var_639_14

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= var_639_6 + var_639_14 and arg_636_1.time_ < var_639_6 + var_639_14 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {}

		arg_636_1:InitPlayNodeList()
	end,
	Play1109704154 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 1109704154
		arg_640_1.duration_ = 5

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play1109704155(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			local var_643_0 = arg_640_1.actors_["1042ui_story"].transform
			local var_643_1 = 0

			if var_643_1 < arg_640_1.time_ and arg_640_1.time_ <= var_643_1 + arg_643_0 then
				arg_640_1.var_.moveOldPos1042ui_story = var_643_0.localPosition
			end

			local var_643_2 = 0.001

			if var_643_1 <= arg_640_1.time_ and arg_640_1.time_ < var_643_1 + var_643_2 then
				local var_643_3 = (arg_640_1.time_ - var_643_1) / var_643_2
				local var_643_4 = Vector3.New(0, 100, 0)

				var_643_0.localPosition = Vector3.Lerp(arg_640_1.var_.moveOldPos1042ui_story, var_643_4, var_643_3)

				local var_643_5 = manager.ui.mainCamera.transform.position - var_643_0.position

				var_643_0.forward = Vector3.New(var_643_5.x, var_643_5.y, var_643_5.z)

				local var_643_6 = var_643_0.localEulerAngles

				var_643_6.z = 0
				var_643_6.x = 0
				var_643_0.localEulerAngles = var_643_6
			end

			if arg_640_1.time_ >= var_643_1 + var_643_2 and arg_640_1.time_ < var_643_1 + var_643_2 + arg_643_0 then
				var_643_0.localPosition = Vector3.New(0, 100, 0)

				local var_643_7 = manager.ui.mainCamera.transform.position - var_643_0.position

				var_643_0.forward = Vector3.New(var_643_7.x, var_643_7.y, var_643_7.z)

				local var_643_8 = var_643_0.localEulerAngles

				var_643_8.z = 0
				var_643_8.x = 0
				var_643_0.localEulerAngles = var_643_8
			end

			local var_643_9 = arg_640_1.actors_["1042ui_story"]
			local var_643_10 = 0

			if var_643_10 < arg_640_1.time_ and arg_640_1.time_ <= var_643_10 + arg_643_0 and not isNil(var_643_9) and arg_640_1.var_.characterEffect1042ui_story == nil then
				arg_640_1.var_.characterEffect1042ui_story = var_643_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_643_11 = 0.200000002980232

			if var_643_10 <= arg_640_1.time_ and arg_640_1.time_ < var_643_10 + var_643_11 and not isNil(var_643_9) then
				local var_643_12 = (arg_640_1.time_ - var_643_10) / var_643_11

				if arg_640_1.var_.characterEffect1042ui_story and not isNil(var_643_9) then
					local var_643_13 = Mathf.Lerp(0, 0.5, var_643_12)

					arg_640_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_640_1.var_.characterEffect1042ui_story.fillRatio = var_643_13
				end
			end

			if arg_640_1.time_ >= var_643_10 + var_643_11 and arg_640_1.time_ < var_643_10 + var_643_11 + arg_643_0 and not isNil(var_643_9) and arg_640_1.var_.characterEffect1042ui_story then
				local var_643_14 = 0.5

				arg_640_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_640_1.var_.characterEffect1042ui_story.fillRatio = var_643_14
			end

			local var_643_15 = 0
			local var_643_16 = 0.6

			if var_643_15 < arg_640_1.time_ and arg_640_1.time_ <= var_643_15 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, false)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_640_1.iconTrs_.gameObject, false)
				arg_640_1.callingController_:SetSelectedState("normal")

				local var_643_17 = arg_640_1:GetWordFromCfg(1109704154)
				local var_643_18 = arg_640_1:FormatText(var_643_17.content)

				arg_640_1.text_.text = var_643_18

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_19 = 24
				local var_643_20 = utf8.len(var_643_18)
				local var_643_21 = var_643_19 <= 0 and var_643_16 or var_643_16 * (var_643_20 / var_643_19)

				if var_643_21 > 0 and var_643_16 < var_643_21 then
					arg_640_1.talkMaxDuration = var_643_21

					if var_643_21 + var_643_15 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_21 + var_643_15
					end
				end

				arg_640_1.text_.text = var_643_18
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)
				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_22 = math.max(var_643_16, arg_640_1.talkMaxDuration)

			if var_643_15 <= arg_640_1.time_ and arg_640_1.time_ < var_643_15 + var_643_22 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - var_643_15) / var_643_22

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= var_643_15 + var_643_22 and arg_640_1.time_ < var_643_15 + var_643_22 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
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
	Play1109704155 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 1109704155
		arg_644_1.duration_ = 8.93

		local var_644_0 = {
			zh = 8.933,
			ja = 7
		}
		local var_644_1 = manager.audio:GetLocalizationFlag()

		if var_644_0[var_644_1] ~= nil then
			arg_644_1.duration_ = var_644_0[var_644_1]
		end

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play1109704156(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			local var_647_0 = arg_644_1.actors_["1097ui_story"].transform
			local var_647_1 = 0

			if var_647_1 < arg_644_1.time_ and arg_644_1.time_ <= var_647_1 + arg_647_0 then
				arg_644_1.var_.moveOldPos1097ui_story = var_647_0.localPosition
			end

			local var_647_2 = 0.001

			if var_647_1 <= arg_644_1.time_ and arg_644_1.time_ < var_647_1 + var_647_2 then
				local var_647_3 = (arg_644_1.time_ - var_647_1) / var_647_2
				local var_647_4 = Vector3.New(0, -0.54, -6.3)

				var_647_0.localPosition = Vector3.Lerp(arg_644_1.var_.moveOldPos1097ui_story, var_647_4, var_647_3)

				local var_647_5 = manager.ui.mainCamera.transform.position - var_647_0.position

				var_647_0.forward = Vector3.New(var_647_5.x, var_647_5.y, var_647_5.z)

				local var_647_6 = var_647_0.localEulerAngles

				var_647_6.z = 0
				var_647_6.x = 0
				var_647_0.localEulerAngles = var_647_6
			end

			if arg_644_1.time_ >= var_647_1 + var_647_2 and arg_644_1.time_ < var_647_1 + var_647_2 + arg_647_0 then
				var_647_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_647_7 = manager.ui.mainCamera.transform.position - var_647_0.position

				var_647_0.forward = Vector3.New(var_647_7.x, var_647_7.y, var_647_7.z)

				local var_647_8 = var_647_0.localEulerAngles

				var_647_8.z = 0
				var_647_8.x = 0
				var_647_0.localEulerAngles = var_647_8
			end

			local var_647_9 = arg_644_1.actors_["1097ui_story"]
			local var_647_10 = 0

			if var_647_10 < arg_644_1.time_ and arg_644_1.time_ <= var_647_10 + arg_647_0 and not isNil(var_647_9) and arg_644_1.var_.characterEffect1097ui_story == nil then
				arg_644_1.var_.characterEffect1097ui_story = var_647_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_647_11 = 0.200000002980232

			if var_647_10 <= arg_644_1.time_ and arg_644_1.time_ < var_647_10 + var_647_11 and not isNil(var_647_9) then
				local var_647_12 = (arg_644_1.time_ - var_647_10) / var_647_11

				if arg_644_1.var_.characterEffect1097ui_story and not isNil(var_647_9) then
					arg_644_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_644_1.time_ >= var_647_10 + var_647_11 and arg_644_1.time_ < var_647_10 + var_647_11 + arg_647_0 and not isNil(var_647_9) and arg_644_1.var_.characterEffect1097ui_story then
				arg_644_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_647_13 = 0

			if var_647_13 < arg_644_1.time_ and arg_644_1.time_ <= var_647_13 + arg_647_0 then
				arg_644_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_647_14 = 0

			if var_647_14 < arg_644_1.time_ and arg_644_1.time_ <= var_647_14 + arg_647_0 then
				arg_644_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_647_15 = 0
			local var_647_16 = 0.775

			if var_647_15 < arg_644_1.time_ and arg_644_1.time_ <= var_647_15 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0
				arg_644_1.dialogCg_.alpha = 1

				arg_644_1.dialog_:SetActive(true)
				SetActive(arg_644_1.leftNameGo_, true)

				local var_647_17 = arg_644_1:FormatText(StoryNameCfg[216].name)

				arg_644_1.leftNameTxt_.text = var_647_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_644_1.leftNameTxt_.transform)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1.leftNameTxt_.text)
				SetActive(arg_644_1.iconTrs_.gameObject, false)
				arg_644_1.callingController_:SetSelectedState("normal")

				local var_647_18 = arg_644_1:GetWordFromCfg(1109704155)
				local var_647_19 = arg_644_1:FormatText(var_647_18.content)

				arg_644_1.text_.text = var_647_19

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_20 = 31
				local var_647_21 = utf8.len(var_647_19)
				local var_647_22 = var_647_20 <= 0 and var_647_16 or var_647_16 * (var_647_21 / var_647_20)

				if var_647_22 > 0 and var_647_16 < var_647_22 then
					arg_644_1.talkMaxDuration = var_647_22

					if var_647_22 + var_647_15 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_22 + var_647_15
					end
				end

				arg_644_1.text_.text = var_647_19
				arg_644_1.typewritter.percent = 0

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704155", "story_v_side_new_1109704.awb") ~= 0 then
					local var_647_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704155", "story_v_side_new_1109704.awb") / 1000

					if var_647_23 + var_647_15 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_23 + var_647_15
					end

					if var_647_18.prefab_name ~= "" and arg_644_1.actors_[var_647_18.prefab_name] ~= nil then
						local var_647_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_644_1.actors_[var_647_18.prefab_name].transform, "story_v_side_new_1109704", "1109704155", "story_v_side_new_1109704.awb")

						arg_644_1:RecordAudio("1109704155", var_647_24)
						arg_644_1:RecordAudio("1109704155", var_647_24)
					else
						arg_644_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704155", "story_v_side_new_1109704.awb")
					end

					arg_644_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704155", "story_v_side_new_1109704.awb")
				end

				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_25 = math.max(var_647_16, arg_644_1.talkMaxDuration)

			if var_647_15 <= arg_644_1.time_ and arg_644_1.time_ < var_647_15 + var_647_25 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - var_647_15) / var_647_25

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= var_647_15 + var_647_25 and arg_644_1.time_ < var_647_15 + var_647_25 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {
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

		arg_644_1:InitPlayNodeList()
	end,
	Play1109704156 = function(arg_648_0, arg_648_1)
		arg_648_1.time_ = 0
		arg_648_1.frameCnt_ = 0
		arg_648_1.state_ = "playing"
		arg_648_1.curTalkId_ = 1109704156
		arg_648_1.duration_ = 5

		SetActive(arg_648_1.tipsGo_, false)

		function arg_648_1.onSingleLineFinish_()
			arg_648_1.onSingleLineUpdate_ = nil
			arg_648_1.onSingleLineFinish_ = nil
			arg_648_1.state_ = "waiting"
		end

		function arg_648_1.playNext_(arg_650_0)
			if arg_650_0 == 1 then
				arg_648_0:Play1109704157(arg_648_1)
			end
		end

		function arg_648_1.onSingleLineUpdate_(arg_651_0)
			local var_651_0 = arg_648_1.actors_["1097ui_story"]
			local var_651_1 = 0

			if var_651_1 < arg_648_1.time_ and arg_648_1.time_ <= var_651_1 + arg_651_0 and not isNil(var_651_0) and arg_648_1.var_.characterEffect1097ui_story == nil then
				arg_648_1.var_.characterEffect1097ui_story = var_651_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_651_2 = 0.200000002980232

			if var_651_1 <= arg_648_1.time_ and arg_648_1.time_ < var_651_1 + var_651_2 and not isNil(var_651_0) then
				local var_651_3 = (arg_648_1.time_ - var_651_1) / var_651_2

				if arg_648_1.var_.characterEffect1097ui_story and not isNil(var_651_0) then
					local var_651_4 = Mathf.Lerp(0, 0.5, var_651_3)

					arg_648_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_648_1.var_.characterEffect1097ui_story.fillRatio = var_651_4
				end
			end

			if arg_648_1.time_ >= var_651_1 + var_651_2 and arg_648_1.time_ < var_651_1 + var_651_2 + arg_651_0 and not isNil(var_651_0) and arg_648_1.var_.characterEffect1097ui_story then
				local var_651_5 = 0.5

				arg_648_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_648_1.var_.characterEffect1097ui_story.fillRatio = var_651_5
			end

			local var_651_6 = 0
			local var_651_7 = 0.275

			if var_651_6 < arg_648_1.time_ and arg_648_1.time_ <= var_651_6 + arg_651_0 then
				arg_648_1.talkMaxDuration = 0
				arg_648_1.dialogCg_.alpha = 1

				arg_648_1.dialog_:SetActive(true)
				SetActive(arg_648_1.leftNameGo_, true)

				local var_651_8 = arg_648_1:FormatText(StoryNameCfg[7].name)

				arg_648_1.leftNameTxt_.text = var_651_8

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

				local var_651_9 = arg_648_1:GetWordFromCfg(1109704156)
				local var_651_10 = arg_648_1:FormatText(var_651_9.content)

				arg_648_1.text_.text = var_651_10

				LuaForUtil.ClearLinePrefixSymbol(arg_648_1.text_)

				local var_651_11 = 11
				local var_651_12 = utf8.len(var_651_10)
				local var_651_13 = var_651_11 <= 0 and var_651_7 or var_651_7 * (var_651_12 / var_651_11)

				if var_651_13 > 0 and var_651_7 < var_651_13 then
					arg_648_1.talkMaxDuration = var_651_13

					if var_651_13 + var_651_6 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_13 + var_651_6
					end
				end

				arg_648_1.text_.text = var_651_10
				arg_648_1.typewritter.percent = 0

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(false)
				arg_648_1:RecordContent(arg_648_1.text_.text)
			end

			local var_651_14 = math.max(var_651_7, arg_648_1.talkMaxDuration)

			if var_651_6 <= arg_648_1.time_ and arg_648_1.time_ < var_651_6 + var_651_14 then
				arg_648_1.typewritter.percent = (arg_648_1.time_ - var_651_6) / var_651_14

				arg_648_1.typewritter:SetDirty()
			end

			if arg_648_1.time_ >= var_651_6 + var_651_14 and arg_648_1.time_ < var_651_6 + var_651_14 + arg_651_0 then
				arg_648_1.typewritter.percent = 1

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(true)
			end
		end

		arg_648_1.nodeConfigList_ = {}

		arg_648_1:InitPlayNodeList()
	end,
	Play1109704157 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 1109704157
		arg_652_1.duration_ = 2.3

		local var_652_0 = {
			zh = 2.3,
			ja = 2
		}
		local var_652_1 = manager.audio:GetLocalizationFlag()

		if var_652_0[var_652_1] ~= nil then
			arg_652_1.duration_ = var_652_0[var_652_1]
		end

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play1109704158(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			local var_655_0 = arg_652_1.actors_["1097ui_story"]
			local var_655_1 = 0

			if var_655_1 < arg_652_1.time_ and arg_652_1.time_ <= var_655_1 + arg_655_0 and not isNil(var_655_0) and arg_652_1.var_.characterEffect1097ui_story == nil then
				arg_652_1.var_.characterEffect1097ui_story = var_655_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_655_2 = 0.200000002980232

			if var_655_1 <= arg_652_1.time_ and arg_652_1.time_ < var_655_1 + var_655_2 and not isNil(var_655_0) then
				local var_655_3 = (arg_652_1.time_ - var_655_1) / var_655_2

				if arg_652_1.var_.characterEffect1097ui_story and not isNil(var_655_0) then
					arg_652_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_652_1.time_ >= var_655_1 + var_655_2 and arg_652_1.time_ < var_655_1 + var_655_2 + arg_655_0 and not isNil(var_655_0) and arg_652_1.var_.characterEffect1097ui_story then
				arg_652_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_655_4 = 0

			if var_655_4 < arg_652_1.time_ and arg_652_1.time_ <= var_655_4 + arg_655_0 then
				arg_652_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_655_5 = 0

			if var_655_5 < arg_652_1.time_ and arg_652_1.time_ <= var_655_5 + arg_655_0 then
				arg_652_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_655_6 = 0
			local var_655_7 = 0.425

			if var_655_6 < arg_652_1.time_ and arg_652_1.time_ <= var_655_6 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, true)

				local var_655_8 = arg_652_1:FormatText(StoryNameCfg[216].name)

				arg_652_1.leftNameTxt_.text = var_655_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_652_1.leftNameTxt_.transform)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1.leftNameTxt_.text)
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_9 = arg_652_1:GetWordFromCfg(1109704157)
				local var_655_10 = arg_652_1:FormatText(var_655_9.content)

				arg_652_1.text_.text = var_655_10

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_11 = 17
				local var_655_12 = utf8.len(var_655_10)
				local var_655_13 = var_655_11 <= 0 and var_655_7 or var_655_7 * (var_655_12 / var_655_11)

				if var_655_13 > 0 and var_655_7 < var_655_13 then
					arg_652_1.talkMaxDuration = var_655_13

					if var_655_13 + var_655_6 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_13 + var_655_6
					end
				end

				arg_652_1.text_.text = var_655_10
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704157", "story_v_side_new_1109704.awb") ~= 0 then
					local var_655_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704157", "story_v_side_new_1109704.awb") / 1000

					if var_655_14 + var_655_6 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_14 + var_655_6
					end

					if var_655_9.prefab_name ~= "" and arg_652_1.actors_[var_655_9.prefab_name] ~= nil then
						local var_655_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_652_1.actors_[var_655_9.prefab_name].transform, "story_v_side_new_1109704", "1109704157", "story_v_side_new_1109704.awb")

						arg_652_1:RecordAudio("1109704157", var_655_15)
						arg_652_1:RecordAudio("1109704157", var_655_15)
					else
						arg_652_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704157", "story_v_side_new_1109704.awb")
					end

					arg_652_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704157", "story_v_side_new_1109704.awb")
				end

				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_16 = math.max(var_655_7, arg_652_1.talkMaxDuration)

			if var_655_6 <= arg_652_1.time_ and arg_652_1.time_ < var_655_6 + var_655_16 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_6) / var_655_16

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_6 + var_655_16 and arg_652_1.time_ < var_655_6 + var_655_16 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {}

		arg_652_1:InitPlayNodeList()
	end,
	Play1109704158 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 1109704158
		arg_656_1.duration_ = 5

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play1109704159(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			local var_659_0 = arg_656_1.actors_["1097ui_story"]
			local var_659_1 = 0

			if var_659_1 < arg_656_1.time_ and arg_656_1.time_ <= var_659_1 + arg_659_0 and not isNil(var_659_0) and arg_656_1.var_.characterEffect1097ui_story == nil then
				arg_656_1.var_.characterEffect1097ui_story = var_659_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_659_2 = 0.200000002980232

			if var_659_1 <= arg_656_1.time_ and arg_656_1.time_ < var_659_1 + var_659_2 and not isNil(var_659_0) then
				local var_659_3 = (arg_656_1.time_ - var_659_1) / var_659_2

				if arg_656_1.var_.characterEffect1097ui_story and not isNil(var_659_0) then
					local var_659_4 = Mathf.Lerp(0, 0.5, var_659_3)

					arg_656_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_656_1.var_.characterEffect1097ui_story.fillRatio = var_659_4
				end
			end

			if arg_656_1.time_ >= var_659_1 + var_659_2 and arg_656_1.time_ < var_659_1 + var_659_2 + arg_659_0 and not isNil(var_659_0) and arg_656_1.var_.characterEffect1097ui_story then
				local var_659_5 = 0.5

				arg_656_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_656_1.var_.characterEffect1097ui_story.fillRatio = var_659_5
			end

			local var_659_6 = arg_656_1.actors_["1097ui_story"].transform
			local var_659_7 = 0

			if var_659_7 < arg_656_1.time_ and arg_656_1.time_ <= var_659_7 + arg_659_0 then
				arg_656_1.var_.moveOldPos1097ui_story = var_659_6.localPosition
			end

			local var_659_8 = 0.001

			if var_659_7 <= arg_656_1.time_ and arg_656_1.time_ < var_659_7 + var_659_8 then
				local var_659_9 = (arg_656_1.time_ - var_659_7) / var_659_8
				local var_659_10 = Vector3.New(0, 100, 0)

				var_659_6.localPosition = Vector3.Lerp(arg_656_1.var_.moveOldPos1097ui_story, var_659_10, var_659_9)

				local var_659_11 = manager.ui.mainCamera.transform.position - var_659_6.position

				var_659_6.forward = Vector3.New(var_659_11.x, var_659_11.y, var_659_11.z)

				local var_659_12 = var_659_6.localEulerAngles

				var_659_12.z = 0
				var_659_12.x = 0
				var_659_6.localEulerAngles = var_659_12
			end

			if arg_656_1.time_ >= var_659_7 + var_659_8 and arg_656_1.time_ < var_659_7 + var_659_8 + arg_659_0 then
				var_659_6.localPosition = Vector3.New(0, 100, 0)

				local var_659_13 = manager.ui.mainCamera.transform.position - var_659_6.position

				var_659_6.forward = Vector3.New(var_659_13.x, var_659_13.y, var_659_13.z)

				local var_659_14 = var_659_6.localEulerAngles

				var_659_14.z = 0
				var_659_14.x = 0
				var_659_6.localEulerAngles = var_659_14
			end

			local var_659_15 = manager.ui.mainCamera.transform
			local var_659_16 = 0.4

			if var_659_16 < arg_656_1.time_ and arg_656_1.time_ <= var_659_16 + arg_659_0 then
				arg_656_1.var_.shakeOldPos = var_659_15.localPosition
			end

			local var_659_17 = 0.6

			if var_659_16 <= arg_656_1.time_ and arg_656_1.time_ < var_659_16 + var_659_17 then
				local var_659_18 = (arg_656_1.time_ - var_659_16) / 0.066
				local var_659_19, var_659_20 = math.modf(var_659_18)

				var_659_15.localPosition = Vector3.New(var_659_20 * 0.13, var_659_20 * 0.13, var_659_20 * 0.13) + arg_656_1.var_.shakeOldPos
			end

			if arg_656_1.time_ >= var_659_16 + var_659_17 and arg_656_1.time_ < var_659_16 + var_659_17 + arg_659_0 then
				var_659_15.localPosition = arg_656_1.var_.shakeOldPos
			end

			local var_659_21 = 0

			if var_659_21 < arg_656_1.time_ and arg_656_1.time_ <= var_659_21 + arg_659_0 then
				arg_656_1.allBtn_.enabled = false
			end

			local var_659_22 = 1

			if arg_656_1.time_ >= var_659_21 + var_659_22 and arg_656_1.time_ < var_659_21 + var_659_22 + arg_659_0 then
				arg_656_1.allBtn_.enabled = true
			end

			local var_659_23 = 0
			local var_659_24 = 1.425

			if var_659_23 < arg_656_1.time_ and arg_656_1.time_ <= var_659_23 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, true)

				local var_659_25 = arg_656_1:FormatText(StoryNameCfg[7].name)

				arg_656_1.leftNameTxt_.text = var_659_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_656_1.leftNameTxt_.transform)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1.leftNameTxt_.text)
				SetActive(arg_656_1.iconTrs_.gameObject, true)
				arg_656_1.iconController_:SetSelectedState("hero")

				arg_656_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_656_1.callingController_:SetSelectedState("normal")

				arg_656_1.keyicon_.color = Color.New(1, 1, 1)
				arg_656_1.icon_.color = Color.New(1, 1, 1)

				local var_659_26 = arg_656_1:GetWordFromCfg(1109704158)
				local var_659_27 = arg_656_1:FormatText(var_659_26.content)

				arg_656_1.text_.text = var_659_27

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_28 = 57
				local var_659_29 = utf8.len(var_659_27)
				local var_659_30 = var_659_28 <= 0 and var_659_24 or var_659_24 * (var_659_29 / var_659_28)

				if var_659_30 > 0 and var_659_24 < var_659_30 then
					arg_656_1.talkMaxDuration = var_659_30

					if var_659_30 + var_659_23 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_30 + var_659_23
					end
				end

				arg_656_1.text_.text = var_659_27
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)
				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_31 = math.max(var_659_24, arg_656_1.talkMaxDuration)

			if var_659_23 <= arg_656_1.time_ and arg_656_1.time_ < var_659_23 + var_659_31 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_23) / var_659_31

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_23 + var_659_31 and arg_656_1.time_ < var_659_23 + var_659_31 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_656_1:InitPlayNodeList()
	end,
	Play1109704159 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 1109704159
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play1109704160(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = 0
			local var_663_1 = 0.55

			if var_663_0 < arg_660_1.time_ and arg_660_1.time_ <= var_663_0 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, false)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_660_1.iconTrs_.gameObject, false)
				arg_660_1.callingController_:SetSelectedState("normal")

				local var_663_2 = arg_660_1:GetWordFromCfg(1109704159)
				local var_663_3 = arg_660_1:FormatText(var_663_2.content)

				arg_660_1.text_.text = var_663_3

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_4 = 22
				local var_663_5 = utf8.len(var_663_3)
				local var_663_6 = var_663_4 <= 0 and var_663_1 or var_663_1 * (var_663_5 / var_663_4)

				if var_663_6 > 0 and var_663_1 < var_663_6 then
					arg_660_1.talkMaxDuration = var_663_6

					if var_663_6 + var_663_0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_6 + var_663_0
					end
				end

				arg_660_1.text_.text = var_663_3
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_7 = math.max(var_663_1, arg_660_1.talkMaxDuration)

			if var_663_0 <= arg_660_1.time_ and arg_660_1.time_ < var_663_0 + var_663_7 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_0) / var_663_7

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_0 + var_663_7 and arg_660_1.time_ < var_663_0 + var_663_7 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	Play1109704160 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 1109704160
		arg_664_1.duration_ = 6.73

		local var_664_0 = {
			zh = 6.733,
			ja = 6.5
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
				arg_664_0:Play1109704161(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			local var_667_0 = arg_664_1.actors_["1097ui_story"].transform
			local var_667_1 = 0

			if var_667_1 < arg_664_1.time_ and arg_664_1.time_ <= var_667_1 + arg_667_0 then
				arg_664_1.var_.moveOldPos1097ui_story = var_667_0.localPosition
			end

			local var_667_2 = 0.001

			if var_667_1 <= arg_664_1.time_ and arg_664_1.time_ < var_667_1 + var_667_2 then
				local var_667_3 = (arg_664_1.time_ - var_667_1) / var_667_2
				local var_667_4 = Vector3.New(0, -0.54, -6.3)

				var_667_0.localPosition = Vector3.Lerp(arg_664_1.var_.moveOldPos1097ui_story, var_667_4, var_667_3)

				local var_667_5 = manager.ui.mainCamera.transform.position - var_667_0.position

				var_667_0.forward = Vector3.New(var_667_5.x, var_667_5.y, var_667_5.z)

				local var_667_6 = var_667_0.localEulerAngles

				var_667_6.z = 0
				var_667_6.x = 0
				var_667_0.localEulerAngles = var_667_6
			end

			if arg_664_1.time_ >= var_667_1 + var_667_2 and arg_664_1.time_ < var_667_1 + var_667_2 + arg_667_0 then
				var_667_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_667_7 = manager.ui.mainCamera.transform.position - var_667_0.position

				var_667_0.forward = Vector3.New(var_667_7.x, var_667_7.y, var_667_7.z)

				local var_667_8 = var_667_0.localEulerAngles

				var_667_8.z = 0
				var_667_8.x = 0
				var_667_0.localEulerAngles = var_667_8
			end

			local var_667_9 = arg_664_1.actors_["1097ui_story"]
			local var_667_10 = 0

			if var_667_10 < arg_664_1.time_ and arg_664_1.time_ <= var_667_10 + arg_667_0 and not isNil(var_667_9) and arg_664_1.var_.characterEffect1097ui_story == nil then
				arg_664_1.var_.characterEffect1097ui_story = var_667_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_667_11 = 0.200000002980232

			if var_667_10 <= arg_664_1.time_ and arg_664_1.time_ < var_667_10 + var_667_11 and not isNil(var_667_9) then
				local var_667_12 = (arg_664_1.time_ - var_667_10) / var_667_11

				if arg_664_1.var_.characterEffect1097ui_story and not isNil(var_667_9) then
					arg_664_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_664_1.time_ >= var_667_10 + var_667_11 and arg_664_1.time_ < var_667_10 + var_667_11 + arg_667_0 and not isNil(var_667_9) and arg_664_1.var_.characterEffect1097ui_story then
				arg_664_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_667_13 = 0

			if var_667_13 < arg_664_1.time_ and arg_664_1.time_ <= var_667_13 + arg_667_0 then
				arg_664_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_667_14 = 0

			if var_667_14 < arg_664_1.time_ and arg_664_1.time_ <= var_667_14 + arg_667_0 then
				arg_664_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_667_15 = 0
			local var_667_16 = 0.75

			if var_667_15 < arg_664_1.time_ and arg_664_1.time_ <= var_667_15 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, true)

				local var_667_17 = arg_664_1:FormatText(StoryNameCfg[216].name)

				arg_664_1.leftNameTxt_.text = var_667_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_664_1.leftNameTxt_.transform)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1.leftNameTxt_.text)
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_18 = arg_664_1:GetWordFromCfg(1109704160)
				local var_667_19 = arg_664_1:FormatText(var_667_18.content)

				arg_664_1.text_.text = var_667_19

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_20 = 30
				local var_667_21 = utf8.len(var_667_19)
				local var_667_22 = var_667_20 <= 0 and var_667_16 or var_667_16 * (var_667_21 / var_667_20)

				if var_667_22 > 0 and var_667_16 < var_667_22 then
					arg_664_1.talkMaxDuration = var_667_22

					if var_667_22 + var_667_15 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_22 + var_667_15
					end
				end

				arg_664_1.text_.text = var_667_19
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704160", "story_v_side_new_1109704.awb") ~= 0 then
					local var_667_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704160", "story_v_side_new_1109704.awb") / 1000

					if var_667_23 + var_667_15 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_23 + var_667_15
					end

					if var_667_18.prefab_name ~= "" and arg_664_1.actors_[var_667_18.prefab_name] ~= nil then
						local var_667_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_664_1.actors_[var_667_18.prefab_name].transform, "story_v_side_new_1109704", "1109704160", "story_v_side_new_1109704.awb")

						arg_664_1:RecordAudio("1109704160", var_667_24)
						arg_664_1:RecordAudio("1109704160", var_667_24)
					else
						arg_664_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704160", "story_v_side_new_1109704.awb")
					end

					arg_664_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704160", "story_v_side_new_1109704.awb")
				end

				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_25 = math.max(var_667_16, arg_664_1.talkMaxDuration)

			if var_667_15 <= arg_664_1.time_ and arg_664_1.time_ < var_667_15 + var_667_25 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - var_667_15) / var_667_25

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= var_667_15 + var_667_25 and arg_664_1.time_ < var_667_15 + var_667_25 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {
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

		arg_664_1:InitPlayNodeList()
	end,
	Play1109704161 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 1109704161
		arg_668_1.duration_ = 5

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play1109704162(arg_668_1)
			end
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			local var_671_0 = arg_668_1.actors_["1097ui_story"]
			local var_671_1 = 0

			if var_671_1 < arg_668_1.time_ and arg_668_1.time_ <= var_671_1 + arg_671_0 and not isNil(var_671_0) and arg_668_1.var_.characterEffect1097ui_story == nil then
				arg_668_1.var_.characterEffect1097ui_story = var_671_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_671_2 = 0.200000002980232

			if var_671_1 <= arg_668_1.time_ and arg_668_1.time_ < var_671_1 + var_671_2 and not isNil(var_671_0) then
				local var_671_3 = (arg_668_1.time_ - var_671_1) / var_671_2

				if arg_668_1.var_.characterEffect1097ui_story and not isNil(var_671_0) then
					local var_671_4 = Mathf.Lerp(0, 0.5, var_671_3)

					arg_668_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_668_1.var_.characterEffect1097ui_story.fillRatio = var_671_4
				end
			end

			if arg_668_1.time_ >= var_671_1 + var_671_2 and arg_668_1.time_ < var_671_1 + var_671_2 + arg_671_0 and not isNil(var_671_0) and arg_668_1.var_.characterEffect1097ui_story then
				local var_671_5 = 0.5

				arg_668_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_668_1.var_.characterEffect1097ui_story.fillRatio = var_671_5
			end

			local var_671_6 = 0
			local var_671_7 = 0.45

			if var_671_6 < arg_668_1.time_ and arg_668_1.time_ <= var_671_6 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0
				arg_668_1.dialogCg_.alpha = 1

				arg_668_1.dialog_:SetActive(true)
				SetActive(arg_668_1.leftNameGo_, true)

				local var_671_8 = arg_668_1:FormatText(StoryNameCfg[7].name)

				arg_668_1.leftNameTxt_.text = var_671_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_668_1.leftNameTxt_.transform)

				arg_668_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_668_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_668_1:RecordName(arg_668_1.leftNameTxt_.text)
				SetActive(arg_668_1.iconTrs_.gameObject, true)
				arg_668_1.iconController_:SetSelectedState("hero")

				arg_668_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_668_1.callingController_:SetSelectedState("normal")

				arg_668_1.keyicon_.color = Color.New(1, 1, 1)
				arg_668_1.icon_.color = Color.New(1, 1, 1)

				local var_671_9 = arg_668_1:GetWordFromCfg(1109704161)
				local var_671_10 = arg_668_1:FormatText(var_671_9.content)

				arg_668_1.text_.text = var_671_10

				LuaForUtil.ClearLinePrefixSymbol(arg_668_1.text_)

				local var_671_11 = 18
				local var_671_12 = utf8.len(var_671_10)
				local var_671_13 = var_671_11 <= 0 and var_671_7 or var_671_7 * (var_671_12 / var_671_11)

				if var_671_13 > 0 and var_671_7 < var_671_13 then
					arg_668_1.talkMaxDuration = var_671_13

					if var_671_13 + var_671_6 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_13 + var_671_6
					end
				end

				arg_668_1.text_.text = var_671_10
				arg_668_1.typewritter.percent = 0

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(false)
				arg_668_1:RecordContent(arg_668_1.text_.text)
			end

			local var_671_14 = math.max(var_671_7, arg_668_1.talkMaxDuration)

			if var_671_6 <= arg_668_1.time_ and arg_668_1.time_ < var_671_6 + var_671_14 then
				arg_668_1.typewritter.percent = (arg_668_1.time_ - var_671_6) / var_671_14

				arg_668_1.typewritter:SetDirty()
			end

			if arg_668_1.time_ >= var_671_6 + var_671_14 and arg_668_1.time_ < var_671_6 + var_671_14 + arg_671_0 then
				arg_668_1.typewritter.percent = 1

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(true)
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play1109704162 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 1109704162
		arg_672_1.duration_ = 5

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play1109704163(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			local var_675_0 = 0
			local var_675_1 = 1.075

			if var_675_0 < arg_672_1.time_ and arg_672_1.time_ <= var_675_0 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0
				arg_672_1.dialogCg_.alpha = 1

				arg_672_1.dialog_:SetActive(true)
				SetActive(arg_672_1.leftNameGo_, false)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_672_1.iconTrs_.gameObject, false)
				arg_672_1.callingController_:SetSelectedState("normal")

				local var_675_2 = arg_672_1:GetWordFromCfg(1109704162)
				local var_675_3 = arg_672_1:FormatText(var_675_2.content)

				arg_672_1.text_.text = var_675_3

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_4 = 43
				local var_675_5 = utf8.len(var_675_3)
				local var_675_6 = var_675_4 <= 0 and var_675_1 or var_675_1 * (var_675_5 / var_675_4)

				if var_675_6 > 0 and var_675_1 < var_675_6 then
					arg_672_1.talkMaxDuration = var_675_6

					if var_675_6 + var_675_0 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_6 + var_675_0
					end
				end

				arg_672_1.text_.text = var_675_3
				arg_672_1.typewritter.percent = 0

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(false)
				arg_672_1:RecordContent(arg_672_1.text_.text)
			end

			local var_675_7 = math.max(var_675_1, arg_672_1.talkMaxDuration)

			if var_675_0 <= arg_672_1.time_ and arg_672_1.time_ < var_675_0 + var_675_7 then
				arg_672_1.typewritter.percent = (arg_672_1.time_ - var_675_0) / var_675_7

				arg_672_1.typewritter:SetDirty()
			end

			if arg_672_1.time_ >= var_675_0 + var_675_7 and arg_672_1.time_ < var_675_0 + var_675_7 + arg_675_0 then
				arg_672_1.typewritter.percent = 1

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(true)
			end
		end

		arg_672_1.nodeConfigList_ = {}

		arg_672_1:InitPlayNodeList()
	end,
	Play1109704163 = function(arg_676_0, arg_676_1)
		arg_676_1.time_ = 0
		arg_676_1.frameCnt_ = 0
		arg_676_1.state_ = "playing"
		arg_676_1.curTalkId_ = 1109704163
		arg_676_1.duration_ = 5

		SetActive(arg_676_1.tipsGo_, false)

		function arg_676_1.onSingleLineFinish_()
			arg_676_1.onSingleLineUpdate_ = nil
			arg_676_1.onSingleLineFinish_ = nil
			arg_676_1.state_ = "waiting"
		end

		function arg_676_1.playNext_(arg_678_0)
			if arg_678_0 == 1 then
				arg_676_0:Play1109704164(arg_676_1)
			end
		end

		function arg_676_1.onSingleLineUpdate_(arg_679_0)
			local var_679_0 = 0
			local var_679_1 = 0.5

			if var_679_0 < arg_676_1.time_ and arg_676_1.time_ <= var_679_0 + arg_679_0 then
				arg_676_1.talkMaxDuration = 0
				arg_676_1.dialogCg_.alpha = 1

				arg_676_1.dialog_:SetActive(true)
				SetActive(arg_676_1.leftNameGo_, true)

				local var_679_2 = arg_676_1:FormatText(StoryNameCfg[7].name)

				arg_676_1.leftNameTxt_.text = var_679_2

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

				local var_679_3 = arg_676_1:GetWordFromCfg(1109704163)
				local var_679_4 = arg_676_1:FormatText(var_679_3.content)

				arg_676_1.text_.text = var_679_4

				LuaForUtil.ClearLinePrefixSymbol(arg_676_1.text_)

				local var_679_5 = 20
				local var_679_6 = utf8.len(var_679_4)
				local var_679_7 = var_679_5 <= 0 and var_679_1 or var_679_1 * (var_679_6 / var_679_5)

				if var_679_7 > 0 and var_679_1 < var_679_7 then
					arg_676_1.talkMaxDuration = var_679_7

					if var_679_7 + var_679_0 > arg_676_1.duration_ then
						arg_676_1.duration_ = var_679_7 + var_679_0
					end
				end

				arg_676_1.text_.text = var_679_4
				arg_676_1.typewritter.percent = 0

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(false)
				arg_676_1:RecordContent(arg_676_1.text_.text)
			end

			local var_679_8 = math.max(var_679_1, arg_676_1.talkMaxDuration)

			if var_679_0 <= arg_676_1.time_ and arg_676_1.time_ < var_679_0 + var_679_8 then
				arg_676_1.typewritter.percent = (arg_676_1.time_ - var_679_0) / var_679_8

				arg_676_1.typewritter:SetDirty()
			end

			if arg_676_1.time_ >= var_679_0 + var_679_8 and arg_676_1.time_ < var_679_0 + var_679_8 + arg_679_0 then
				arg_676_1.typewritter.percent = 1

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(true)
			end
		end

		arg_676_1.nodeConfigList_ = {}

		arg_676_1:InitPlayNodeList()
	end,
	Play1109704164 = function(arg_680_0, arg_680_1)
		arg_680_1.time_ = 0
		arg_680_1.frameCnt_ = 0
		arg_680_1.state_ = "playing"
		arg_680_1.curTalkId_ = 1109704164
		arg_680_1.duration_ = 5.1

		local var_680_0 = {
			zh = 1.999999999999,
			ja = 5.1
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
			arg_680_1.auto_ = false
		end

		function arg_680_1.playNext_(arg_682_0)
			arg_680_1.onStoryFinished_()
		end

		function arg_680_1.onSingleLineUpdate_(arg_683_0)
			local var_683_0 = arg_680_1.actors_["1097ui_story"].transform
			local var_683_1 = 0

			if var_683_1 < arg_680_1.time_ and arg_680_1.time_ <= var_683_1 + arg_683_0 then
				arg_680_1.var_.moveOldPos1097ui_story = var_683_0.localPosition
			end

			local var_683_2 = 0.001

			if var_683_1 <= arg_680_1.time_ and arg_680_1.time_ < var_683_1 + var_683_2 then
				local var_683_3 = (arg_680_1.time_ - var_683_1) / var_683_2
				local var_683_4 = Vector3.New(0, -0.54, -6.3)

				var_683_0.localPosition = Vector3.Lerp(arg_680_1.var_.moveOldPos1097ui_story, var_683_4, var_683_3)

				local var_683_5 = manager.ui.mainCamera.transform.position - var_683_0.position

				var_683_0.forward = Vector3.New(var_683_5.x, var_683_5.y, var_683_5.z)

				local var_683_6 = var_683_0.localEulerAngles

				var_683_6.z = 0
				var_683_6.x = 0
				var_683_0.localEulerAngles = var_683_6
			end

			if arg_680_1.time_ >= var_683_1 + var_683_2 and arg_680_1.time_ < var_683_1 + var_683_2 + arg_683_0 then
				var_683_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_683_7 = manager.ui.mainCamera.transform.position - var_683_0.position

				var_683_0.forward = Vector3.New(var_683_7.x, var_683_7.y, var_683_7.z)

				local var_683_8 = var_683_0.localEulerAngles

				var_683_8.z = 0
				var_683_8.x = 0
				var_683_0.localEulerAngles = var_683_8
			end

			local var_683_9 = arg_680_1.actors_["1097ui_story"]
			local var_683_10 = 0

			if var_683_10 < arg_680_1.time_ and arg_680_1.time_ <= var_683_10 + arg_683_0 and not isNil(var_683_9) and arg_680_1.var_.characterEffect1097ui_story == nil then
				arg_680_1.var_.characterEffect1097ui_story = var_683_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_683_11 = 0.200000002980232

			if var_683_10 <= arg_680_1.time_ and arg_680_1.time_ < var_683_10 + var_683_11 and not isNil(var_683_9) then
				local var_683_12 = (arg_680_1.time_ - var_683_10) / var_683_11

				if arg_680_1.var_.characterEffect1097ui_story and not isNil(var_683_9) then
					arg_680_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_680_1.time_ >= var_683_10 + var_683_11 and arg_680_1.time_ < var_683_10 + var_683_11 + arg_683_0 and not isNil(var_683_9) and arg_680_1.var_.characterEffect1097ui_story then
				arg_680_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_683_13 = 0

			if var_683_13 < arg_680_1.time_ and arg_680_1.time_ <= var_683_13 + arg_683_0 then
				arg_680_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_683_14 = 0

			if var_683_14 < arg_680_1.time_ and arg_680_1.time_ <= var_683_14 + arg_683_0 then
				arg_680_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_683_15 = 0
			local var_683_16 = 0.1

			if var_683_15 < arg_680_1.time_ and arg_680_1.time_ <= var_683_15 + arg_683_0 then
				arg_680_1.talkMaxDuration = 0
				arg_680_1.dialogCg_.alpha = 1

				arg_680_1.dialog_:SetActive(true)
				SetActive(arg_680_1.leftNameGo_, true)

				local var_683_17 = arg_680_1:FormatText(StoryNameCfg[216].name)

				arg_680_1.leftNameTxt_.text = var_683_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_680_1.leftNameTxt_.transform)

				arg_680_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_680_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_680_1:RecordName(arg_680_1.leftNameTxt_.text)
				SetActive(arg_680_1.iconTrs_.gameObject, false)
				arg_680_1.callingController_:SetSelectedState("normal")

				local var_683_18 = arg_680_1:GetWordFromCfg(1109704164)
				local var_683_19 = arg_680_1:FormatText(var_683_18.content)

				arg_680_1.text_.text = var_683_19

				LuaForUtil.ClearLinePrefixSymbol(arg_680_1.text_)

				local var_683_20 = 4
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704164", "story_v_side_new_1109704.awb") ~= 0 then
					local var_683_23 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704164", "story_v_side_new_1109704.awb") / 1000

					if var_683_23 + var_683_15 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_23 + var_683_15
					end

					if var_683_18.prefab_name ~= "" and arg_680_1.actors_[var_683_18.prefab_name] ~= nil then
						local var_683_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_680_1.actors_[var_683_18.prefab_name].transform, "story_v_side_new_1109704", "1109704164", "story_v_side_new_1109704.awb")

						arg_680_1:RecordAudio("1109704164", var_683_24)
						arg_680_1:RecordAudio("1109704164", var_683_24)
					else
						arg_680_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704164", "story_v_side_new_1109704.awb")
					end

					arg_680_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704164", "story_v_side_new_1109704.awb")
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
				actorName = "1097ui_story",
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
	assets = {
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/ST60",
		"TextureConfig/Background/R9701",
		"TextureConfig/Background/F01"
	},
	voices = {
		"story_v_side_new_1109704.awb"
	}
}
