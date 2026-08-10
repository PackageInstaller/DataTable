return {
	Play101041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101041001
		arg_1_1.duration_ = 17

		local var_1_0 = {
			ja = 17,
			ko = 11.8,
			zh = 11.766,
			en = 11.833
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
				arg_1_0:Play101041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_office", "bgm_story_office", "bgm_story_office")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			local var_4_6 = "1037ui_story"

			if arg_1_1.actors_[var_4_6] == nil then
				local var_4_7 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_4_7) then
					local var_4_8 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_1_1.stage_.transform)

					var_4_8.name = var_4_6
					var_4_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_6] = var_4_8

					local var_4_9 = var_4_8:GetComponentInChildren(typeof(CharacterEffect))

					var_4_9.enabled = true

					local var_4_10 = GameObjectTools.GetOrAddComponent(var_4_8, typeof(DynamicBoneHelper))

					if var_4_10 then
						var_4_10:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_9.transform, false)

					arg_1_1.var_[var_4_6 .. "Animator"] = var_4_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_6 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_6 .. "LipSync"] = var_4_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_11 = arg_1_1.actors_["1037ui_story"]
			local var_4_12 = 2

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 and not isNil(var_4_11) and arg_1_1.var_.characterEffect1037ui_story == nil then
				arg_1_1.var_.characterEffect1037ui_story = var_4_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_13 = 0.1

			if var_4_12 <= arg_1_1.time_ and arg_1_1.time_ < var_4_12 + var_4_13 and not isNil(var_4_11) then
				local var_4_14 = (arg_1_1.time_ - var_4_12) / var_4_13

				if arg_1_1.var_.characterEffect1037ui_story and not isNil(var_4_11) then
					arg_1_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_12 + var_4_13 and arg_1_1.time_ < var_4_12 + var_4_13 + arg_4_0 and not isNil(var_4_11) and arg_1_1.var_.characterEffect1037ui_story then
				arg_1_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_4_15 = "A00"

			if arg_1_1.bgs_[var_4_15] == nil then
				local var_4_16 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_16:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_15)
				var_4_16.name = var_4_15
				var_4_16.transform.parent = arg_1_1.stage_.transform
				var_4_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_15] = var_4_16
			end

			local var_4_17 = arg_1_1.bgs_.A00
			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				local var_4_19 = var_4_17:GetComponent("SpriteRenderer")

				if var_4_19 then
					arg_1_1.var_.alphaOldValueA00 = var_4_19.color.a
					arg_1_1.var_.alphaMatValueA00 = var_4_19
				end

				arg_1_1.var_.alphaOldValueA00 = 0
			end

			local var_4_20 = 1.5

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_20 then
				local var_4_21 = (arg_1_1.time_ - var_4_18) / var_4_20
				local var_4_22 = Mathf.Lerp(arg_1_1.var_.alphaOldValueA00, 1, var_4_21)

				if arg_1_1.var_.alphaMatValueA00 then
					local var_4_23 = arg_1_1.var_.alphaMatValueA00.color

					var_4_23.a = var_4_22
					arg_1_1.var_.alphaMatValueA00.color = var_4_23
				end
			end

			if arg_1_1.time_ >= var_4_18 + var_4_20 and arg_1_1.time_ < var_4_18 + var_4_20 + arg_4_0 and arg_1_1.var_.alphaMatValueA00 then
				local var_4_24 = arg_1_1.var_.alphaMatValueA00
				local var_4_25 = var_4_24.color

				var_4_25.a = 1
				var_4_24.color = var_4_25
			end

			local var_4_26 = 0

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_27 = manager.ui.mainCamera.transform.localPosition
				local var_4_28 = Vector3.New(0, 0, 10) + Vector3.New(var_4_27.x, var_4_27.y, 0)
				local var_4_29 = arg_1_1.bgs_.A00

				var_4_29.transform.localPosition = var_4_28
				var_4_29.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_30 = var_4_29:GetComponent("SpriteRenderer")

				if var_4_30 and var_4_30.sprite then
					local var_4_31 = (var_4_29.transform.localPosition - var_4_27).z
					local var_4_32 = manager.ui.mainCameraCom_
					local var_4_33 = 2 * var_4_31 * Mathf.Tan(var_4_32.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_34 = var_4_33 * var_4_32.aspect
					local var_4_35 = var_4_30.sprite.bounds.size.x
					local var_4_36 = var_4_30.sprite.bounds.size.y
					local var_4_37 = var_4_34 / var_4_35
					local var_4_38 = var_4_33 / var_4_36
					local var_4_39 = var_4_38 < var_4_37 and var_4_37 or var_4_38

					var_4_29.transform.localScale = Vector3.New(var_4_39, var_4_39, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A00" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_40 = arg_1_1.actors_["1037ui_story"].transform
			local var_4_41 = 1.79999995231628

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1.var_.moveOldPos1037ui_story = var_4_40.localPosition
			end

			local var_4_42 = 0.001

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42
				local var_4_44 = Vector3.New(0, -1.09, -5.81)

				var_4_40.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1037ui_story, var_4_44, var_4_43)

				local var_4_45 = manager.ui.mainCamera.transform.position - var_4_40.position

				var_4_40.forward = Vector3.New(var_4_45.x, var_4_45.y, var_4_45.z)

				local var_4_46 = var_4_40.localEulerAngles

				var_4_46.z = 0
				var_4_46.x = 0
				var_4_40.localEulerAngles = var_4_46
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				var_4_40.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_4_47 = manager.ui.mainCamera.transform.position - var_4_40.position

				var_4_40.forward = Vector3.New(var_4_47.x, var_4_47.y, var_4_47.z)

				local var_4_48 = var_4_40.localEulerAngles

				var_4_48.z = 0
				var_4_48.x = 0
				var_4_40.localEulerAngles = var_4_48
			end

			local var_4_49 = 1.79999995231628

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_4_50 = "1019ui_story"

			if arg_1_1.actors_[var_4_50] == nil then
				local var_4_51 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_4_51) then
					local var_4_52 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_1_1.stage_.transform)

					var_4_52.name = var_4_50
					var_4_52.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_50] = var_4_52

					local var_4_53 = var_4_52:GetComponentInChildren(typeof(CharacterEffect))

					var_4_53.enabled = true

					local var_4_54 = GameObjectTools.GetOrAddComponent(var_4_52, typeof(DynamicBoneHelper))

					if var_4_54 then
						var_4_54:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_53.transform, false)

					arg_1_1.var_[var_4_50 .. "Animator"] = var_4_53.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_50 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_50 .. "LipSync"] = var_4_53.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_55 = 0

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_4_56 = 0

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_57 = 1.5

			if arg_1_1.time_ >= var_4_56 + var_4_57 and arg_1_1.time_ < var_4_56 + var_4_57 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_58 = 0

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				arg_1_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_59 = 2
			local var_4_60 = 1.125

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

				local var_4_62 = arg_1_1:FormatText(StoryNameCfg[15].name)

				arg_1_1.leftNameTxt_.text = var_4_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(101041001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041001", "story_v_out_101041.awb") ~= 0 then
					local var_4_68 = manager.audio:GetVoiceLength("story_v_out_101041", "101041001", "story_v_out_101041.awb") / 1000

					if var_4_68 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_59
					end

					if var_4_63.prefab_name ~= "" and arg_1_1.actors_[var_4_63.prefab_name] ~= nil then
						local var_4_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_63.prefab_name].transform, "story_v_out_101041", "101041001", "story_v_out_101041.awb")

						arg_1_1:RecordAudio("101041001", var_4_69)
						arg_1_1:RecordAudio("101041001", var_4_69)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_101041", "101041001", "story_v_out_101041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_101041", "101041001", "story_v_out_101041.awb")
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
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play101041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 101041002
		arg_8_1.duration_ = 2.23

		local var_8_0 = {
			ja = 2.233,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_8_0:Play101041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1019ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.1

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_0) then
					arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1019ui_story then
				arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_11_4 = arg_8_1.actors_["1037ui_story"]
			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.characterEffect1037ui_story == nil then
				arg_8_1.var_.characterEffect1037ui_story = var_11_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_6 = 0.1

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_6 and not isNil(var_11_4) then
				local var_11_7 = (arg_8_1.time_ - var_11_5) / var_11_6

				if arg_8_1.var_.characterEffect1037ui_story and not isNil(var_11_4) then
					local var_11_8 = Mathf.Lerp(0, 0.5, var_11_7)

					arg_8_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1037ui_story.fillRatio = var_11_8
				end
			end

			if arg_8_1.time_ >= var_11_5 + var_11_6 and arg_8_1.time_ < var_11_5 + var_11_6 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.characterEffect1037ui_story then
				local var_11_9 = 0.5

				arg_8_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1037ui_story.fillRatio = var_11_9
			end

			local var_11_10 = arg_8_1.actors_["1037ui_story"].transform
			local var_11_11 = 0

			if var_11_11 < arg_8_1.time_ and arg_8_1.time_ <= var_11_11 + arg_11_0 then
				arg_8_1.var_.moveOldPos1037ui_story = var_11_10.localPosition
			end

			local var_11_12 = 0.001

			if var_11_11 <= arg_8_1.time_ and arg_8_1.time_ < var_11_11 + var_11_12 then
				local var_11_13 = (arg_8_1.time_ - var_11_11) / var_11_12
				local var_11_14 = Vector3.New(0, -1.09, -5.81)

				var_11_10.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1037ui_story, var_11_14, var_11_13)

				local var_11_15 = manager.ui.mainCamera.transform.position - var_11_10.position

				var_11_10.forward = Vector3.New(var_11_15.x, var_11_15.y, var_11_15.z)

				local var_11_16 = var_11_10.localEulerAngles

				var_11_16.z = 0
				var_11_16.x = 0
				var_11_10.localEulerAngles = var_11_16
			end

			if arg_8_1.time_ >= var_11_11 + var_11_12 and arg_8_1.time_ < var_11_11 + var_11_12 + arg_11_0 then
				var_11_10.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_11_17 = manager.ui.mainCamera.transform.position - var_11_10.position

				var_11_10.forward = Vector3.New(var_11_17.x, var_11_17.y, var_11_17.z)

				local var_11_18 = var_11_10.localEulerAngles

				var_11_18.z = 0
				var_11_18.x = 0
				var_11_10.localEulerAngles = var_11_18
			end

			local var_11_19 = arg_8_1.actors_["1037ui_story"].transform
			local var_11_20 = 0.033

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.var_.moveOldPos1037ui_story = var_11_19.localPosition
			end

			local var_11_21 = 0.5

			if var_11_20 <= arg_8_1.time_ and arg_8_1.time_ < var_11_20 + var_11_21 then
				local var_11_22 = (arg_8_1.time_ - var_11_20) / var_11_21
				local var_11_23 = Vector3.New(0.7, -1.09, -5.81)

				var_11_19.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1037ui_story, var_11_23, var_11_22)

				local var_11_24 = manager.ui.mainCamera.transform.position - var_11_19.position

				var_11_19.forward = Vector3.New(var_11_24.x, var_11_24.y, var_11_24.z)

				local var_11_25 = var_11_19.localEulerAngles

				var_11_25.z = 0
				var_11_25.x = 0
				var_11_19.localEulerAngles = var_11_25
			end

			if arg_8_1.time_ >= var_11_20 + var_11_21 and arg_8_1.time_ < var_11_20 + var_11_21 + arg_11_0 then
				var_11_19.localPosition = Vector3.New(0.7, -1.09, -5.81)

				local var_11_26 = manager.ui.mainCamera.transform.position - var_11_19.position

				var_11_19.forward = Vector3.New(var_11_26.x, var_11_26.y, var_11_26.z)

				local var_11_27 = var_11_19.localEulerAngles

				var_11_27.z = 0
				var_11_27.x = 0
				var_11_19.localEulerAngles = var_11_27
			end

			local var_11_28 = arg_8_1.actors_["1019ui_story"].transform
			local var_11_29 = 0

			if var_11_29 < arg_8_1.time_ and arg_8_1.time_ <= var_11_29 + arg_11_0 then
				arg_8_1.var_.moveOldPos1019ui_story = var_11_28.localPosition
			end

			local var_11_30 = 0.001

			if var_11_29 <= arg_8_1.time_ and arg_8_1.time_ < var_11_29 + var_11_30 then
				local var_11_31 = (arg_8_1.time_ - var_11_29) / var_11_30
				local var_11_32 = Vector3.New(-0.7, -1.08, -5.9)

				var_11_28.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1019ui_story, var_11_32, var_11_31)

				local var_11_33 = manager.ui.mainCamera.transform.position - var_11_28.position

				var_11_28.forward = Vector3.New(var_11_33.x, var_11_33.y, var_11_33.z)

				local var_11_34 = var_11_28.localEulerAngles

				var_11_34.z = 0
				var_11_34.x = 0
				var_11_28.localEulerAngles = var_11_34
			end

			if arg_8_1.time_ >= var_11_29 + var_11_30 and arg_8_1.time_ < var_11_29 + var_11_30 + arg_11_0 then
				var_11_28.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_11_35 = manager.ui.mainCamera.transform.position - var_11_28.position

				var_11_28.forward = Vector3.New(var_11_35.x, var_11_35.y, var_11_35.z)

				local var_11_36 = var_11_28.localEulerAngles

				var_11_36.z = 0
				var_11_36.x = 0
				var_11_28.localEulerAngles = var_11_36
			end

			local var_11_37 = 0

			if var_11_37 < arg_8_1.time_ and arg_8_1.time_ <= var_11_37 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_11_38 = 0
			local var_11_39 = 0.2

			if var_11_38 < arg_8_1.time_ and arg_8_1.time_ <= var_11_38 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_40 = arg_8_1:FormatText(StoryNameCfg[13].name)

				arg_8_1.leftNameTxt_.text = var_11_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_41 = arg_8_1:GetWordFromCfg(101041002)
				local var_11_42 = arg_8_1:FormatText(var_11_41.content)

				arg_8_1.text_.text = var_11_42

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_43 = 8
				local var_11_44 = utf8.len(var_11_42)
				local var_11_45 = var_11_43 <= 0 and var_11_39 or var_11_39 * (var_11_44 / var_11_43)

				if var_11_45 > 0 and var_11_39 < var_11_45 then
					arg_8_1.talkMaxDuration = var_11_45

					if var_11_45 + var_11_38 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_45 + var_11_38
					end
				end

				arg_8_1.text_.text = var_11_42
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041002", "story_v_out_101041.awb") ~= 0 then
					local var_11_46 = manager.audio:GetVoiceLength("story_v_out_101041", "101041002", "story_v_out_101041.awb") / 1000

					if var_11_46 + var_11_38 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_46 + var_11_38
					end

					if var_11_41.prefab_name ~= "" and arg_8_1.actors_[var_11_41.prefab_name] ~= nil then
						local var_11_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_41.prefab_name].transform, "story_v_out_101041", "101041002", "story_v_out_101041.awb")

						arg_8_1:RecordAudio("101041002", var_11_47)
						arg_8_1:RecordAudio("101041002", var_11_47)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_101041", "101041002", "story_v_out_101041.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_101041", "101041002", "story_v_out_101041.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_48 = math.max(var_11_39, arg_8_1.talkMaxDuration)

			if var_11_38 <= arg_8_1.time_ and arg_8_1.time_ < var_11_38 + var_11_48 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_38) / var_11_48

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_38 + var_11_48 and arg_8_1.time_ < var_11_38 + var_11_48 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play101041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 101041003
		arg_12_1.duration_ = 3.37

		local var_12_0 = {
			ja = 1.999999999999,
			ko = 2.466,
			zh = 2.666,
			en = 3.366
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play101041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1037ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1037ui_story == nil then
				arg_12_1.var_.characterEffect1037ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1037ui_story and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1037ui_story then
				arg_12_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_15_4 = arg_12_1.actors_["1019ui_story"]
			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect1019ui_story == nil then
				arg_12_1.var_.characterEffect1019ui_story = var_15_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.1

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 and not isNil(var_15_4) then
				local var_15_7 = (arg_12_1.time_ - var_15_5) / var_15_6

				if arg_12_1.var_.characterEffect1019ui_story and not isNil(var_15_4) then
					local var_15_8 = Mathf.Lerp(0, 0.5, var_15_7)

					arg_12_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1019ui_story.fillRatio = var_15_8
				end
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect1019ui_story then
				local var_15_9 = 0.5

				arg_12_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1019ui_story.fillRatio = var_15_9
			end

			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_15_11 = 0
			local var_15_12 = 0.2

			if var_15_11 < arg_12_1.time_ and arg_12_1.time_ <= var_15_11 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_13 = arg_12_1:FormatText(StoryNameCfg[15].name)

				arg_12_1.leftNameTxt_.text = var_15_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_14 = arg_12_1:GetWordFromCfg(101041003)
				local var_15_15 = arg_12_1:FormatText(var_15_14.content)

				arg_12_1.text_.text = var_15_15

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_16 = 8
				local var_15_17 = utf8.len(var_15_15)
				local var_15_18 = var_15_16 <= 0 and var_15_12 or var_15_12 * (var_15_17 / var_15_16)

				if var_15_18 > 0 and var_15_12 < var_15_18 then
					arg_12_1.talkMaxDuration = var_15_18

					if var_15_18 + var_15_11 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_18 + var_15_11
					end
				end

				arg_12_1.text_.text = var_15_15
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041003", "story_v_out_101041.awb") ~= 0 then
					local var_15_19 = manager.audio:GetVoiceLength("story_v_out_101041", "101041003", "story_v_out_101041.awb") / 1000

					if var_15_19 + var_15_11 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_19 + var_15_11
					end

					if var_15_14.prefab_name ~= "" and arg_12_1.actors_[var_15_14.prefab_name] ~= nil then
						local var_15_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_14.prefab_name].transform, "story_v_out_101041", "101041003", "story_v_out_101041.awb")

						arg_12_1:RecordAudio("101041003", var_15_20)
						arg_12_1:RecordAudio("101041003", var_15_20)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_101041", "101041003", "story_v_out_101041.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_101041", "101041003", "story_v_out_101041.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_21 = math.max(var_15_12, arg_12_1.talkMaxDuration)

			if var_15_11 <= arg_12_1.time_ and arg_12_1.time_ < var_15_11 + var_15_21 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_11) / var_15_21

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_11 + var_15_21 and arg_12_1.time_ < var_15_11 + var_15_21 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play101041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 101041004
		arg_16_1.duration_ = 3.67

		local var_16_0 = {
			ja = 3.666,
			ko = 2.6,
			zh = 2.7,
			en = 3.366
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play101041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_19_2 = 0
			local var_19_3 = 0.2

			if var_19_2 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_4 = arg_16_1:FormatText(StoryNameCfg[15].name)

				arg_16_1.leftNameTxt_.text = var_19_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_5 = arg_16_1:GetWordFromCfg(101041004)
				local var_19_6 = arg_16_1:FormatText(var_19_5.content)

				arg_16_1.text_.text = var_19_6

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_7 = 8
				local var_19_8 = utf8.len(var_19_6)
				local var_19_9 = var_19_7 <= 0 and var_19_3 or var_19_3 * (var_19_8 / var_19_7)

				if var_19_9 > 0 and var_19_3 < var_19_9 then
					arg_16_1.talkMaxDuration = var_19_9

					if var_19_9 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_2
					end
				end

				arg_16_1.text_.text = var_19_6
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041004", "story_v_out_101041.awb") ~= 0 then
					local var_19_10 = manager.audio:GetVoiceLength("story_v_out_101041", "101041004", "story_v_out_101041.awb") / 1000

					if var_19_10 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_2
					end

					if var_19_5.prefab_name ~= "" and arg_16_1.actors_[var_19_5.prefab_name] ~= nil then
						local var_19_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_5.prefab_name].transform, "story_v_out_101041", "101041004", "story_v_out_101041.awb")

						arg_16_1:RecordAudio("101041004", var_19_11)
						arg_16_1:RecordAudio("101041004", var_19_11)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_101041", "101041004", "story_v_out_101041.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_101041", "101041004", "story_v_out_101041.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_12 = math.max(var_19_3, arg_16_1.talkMaxDuration)

			if var_19_2 <= arg_16_1.time_ and arg_16_1.time_ < var_19_2 + var_19_12 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_2) / var_19_12

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_2 + var_19_12 and arg_16_1.time_ < var_19_2 + var_19_12 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play101041005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 101041005
		arg_20_1.duration_ = 2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play101041006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1019ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1019ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1019ui_story then
				arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_23_4 = arg_20_1.actors_["1037ui_story"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1037ui_story == nil then
				arg_20_1.var_.characterEffect1037ui_story = var_23_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.1

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.characterEffect1037ui_story and not isNil(var_23_4) then
					local var_23_8 = Mathf.Lerp(0, 0.5, var_23_7)

					arg_20_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1037ui_story.fillRatio = var_23_8
				end
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1037ui_story then
				local var_23_9 = 0.5

				arg_20_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1037ui_story.fillRatio = var_23_9
			end

			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_23_11 = 0
			local var_23_12 = 0.1

			if var_23_11 < arg_20_1.time_ and arg_20_1.time_ <= var_23_11 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_13 = arg_20_1:FormatText(StoryNameCfg[13].name)

				arg_20_1.leftNameTxt_.text = var_23_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_14 = arg_20_1:GetWordFromCfg(101041005)
				local var_23_15 = arg_20_1:FormatText(var_23_14.content)

				arg_20_1.text_.text = var_23_15

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_16 = 4
				local var_23_17 = utf8.len(var_23_15)
				local var_23_18 = var_23_16 <= 0 and var_23_12 or var_23_12 * (var_23_17 / var_23_16)

				if var_23_18 > 0 and var_23_12 < var_23_18 then
					arg_20_1.talkMaxDuration = var_23_18

					if var_23_18 + var_23_11 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_18 + var_23_11
					end
				end

				arg_20_1.text_.text = var_23_15
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041005", "story_v_out_101041.awb") ~= 0 then
					local var_23_19 = manager.audio:GetVoiceLength("story_v_out_101041", "101041005", "story_v_out_101041.awb") / 1000

					if var_23_19 + var_23_11 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_19 + var_23_11
					end

					if var_23_14.prefab_name ~= "" and arg_20_1.actors_[var_23_14.prefab_name] ~= nil then
						local var_23_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_14.prefab_name].transform, "story_v_out_101041", "101041005", "story_v_out_101041.awb")

						arg_20_1:RecordAudio("101041005", var_23_20)
						arg_20_1:RecordAudio("101041005", var_23_20)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_101041", "101041005", "story_v_out_101041.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_101041", "101041005", "story_v_out_101041.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_21 = math.max(var_23_12, arg_20_1.talkMaxDuration)

			if var_23_11 <= arg_20_1.time_ and arg_20_1.time_ < var_23_11 + var_23_21 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_11) / var_23_21

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_11 + var_23_21 and arg_20_1.time_ < var_23_11 + var_23_21 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play101041006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 101041006
		arg_24_1.duration_ = 4.7

		local var_24_0 = {
			ja = 4.7,
			ko = 2.9,
			zh = 2.366,
			en = 3
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play101041007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1037ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1037ui_story == nil then
				arg_24_1.var_.characterEffect1037ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1037ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1037ui_story then
				arg_24_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["1019ui_story"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.1

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_4) then
					local var_27_8 = Mathf.Lerp(0, 0.5, var_27_7)

					arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1019ui_story.fillRatio = var_27_8
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1019ui_story then
				local var_27_9 = 0.5

				arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1019ui_story.fillRatio = var_27_9
			end

			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_27_11 = 0
			local var_27_12 = 0.25

			if var_27_11 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_13 = arg_24_1:FormatText(StoryNameCfg[15].name)

				arg_24_1.leftNameTxt_.text = var_27_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_14 = arg_24_1:GetWordFromCfg(101041006)
				local var_27_15 = arg_24_1:FormatText(var_27_14.content)

				arg_24_1.text_.text = var_27_15

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_16 = 10
				local var_27_17 = utf8.len(var_27_15)
				local var_27_18 = var_27_16 <= 0 and var_27_12 or var_27_12 * (var_27_17 / var_27_16)

				if var_27_18 > 0 and var_27_12 < var_27_18 then
					arg_24_1.talkMaxDuration = var_27_18

					if var_27_18 + var_27_11 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_18 + var_27_11
					end
				end

				arg_24_1.text_.text = var_27_15
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041006", "story_v_out_101041.awb") ~= 0 then
					local var_27_19 = manager.audio:GetVoiceLength("story_v_out_101041", "101041006", "story_v_out_101041.awb") / 1000

					if var_27_19 + var_27_11 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_11
					end

					if var_27_14.prefab_name ~= "" and arg_24_1.actors_[var_27_14.prefab_name] ~= nil then
						local var_27_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_14.prefab_name].transform, "story_v_out_101041", "101041006", "story_v_out_101041.awb")

						arg_24_1:RecordAudio("101041006", var_27_20)
						arg_24_1:RecordAudio("101041006", var_27_20)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_101041", "101041006", "story_v_out_101041.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_101041", "101041006", "story_v_out_101041.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_21 = math.max(var_27_12, arg_24_1.talkMaxDuration)

			if var_27_11 <= arg_24_1.time_ and arg_24_1.time_ < var_27_11 + var_27_21 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_11) / var_27_21

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_11 + var_27_21 and arg_24_1.time_ < var_27_11 + var_27_21 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play101041007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 101041007
		arg_28_1.duration_ = 9.47

		local var_28_0 = {
			ja = 9.466,
			ko = 7.4,
			zh = 7.233,
			en = 8.533
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
				arg_28_0:Play101041008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_31_1 = 0
			local var_31_2 = 0.85

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_3 = arg_28_1:FormatText(StoryNameCfg[15].name)

				arg_28_1.leftNameTxt_.text = var_31_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_4 = arg_28_1:GetWordFromCfg(101041007)
				local var_31_5 = arg_28_1:FormatText(var_31_4.content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_6 = 33
				local var_31_7 = utf8.len(var_31_5)
				local var_31_8 = var_31_6 <= 0 and var_31_2 or var_31_2 * (var_31_7 / var_31_6)

				if var_31_8 > 0 and var_31_2 < var_31_8 then
					arg_28_1.talkMaxDuration = var_31_8

					if var_31_8 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041007", "story_v_out_101041.awb") ~= 0 then
					local var_31_9 = manager.audio:GetVoiceLength("story_v_out_101041", "101041007", "story_v_out_101041.awb") / 1000

					if var_31_9 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_1
					end

					if var_31_4.prefab_name ~= "" and arg_28_1.actors_[var_31_4.prefab_name] ~= nil then
						local var_31_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_4.prefab_name].transform, "story_v_out_101041", "101041007", "story_v_out_101041.awb")

						arg_28_1:RecordAudio("101041007", var_31_10)
						arg_28_1:RecordAudio("101041007", var_31_10)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_101041", "101041007", "story_v_out_101041.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_101041", "101041007", "story_v_out_101041.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_11 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_11 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_11

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_11 and arg_28_1.time_ < var_31_1 + var_31_11 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play101041008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 101041008
		arg_32_1.duration_ = 4.73

		local var_32_0 = {
			ja = 4.733,
			ko = 4.066,
			zh = 4.366,
			en = 4.166
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
				arg_32_0:Play101041009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1019ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1019ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1019ui_story then
				arg_32_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["1037ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1037ui_story == nil then
				arg_32_1.var_.characterEffect1037ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.1

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect1037ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1037ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1037ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1037ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action452")
			end

			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_35_12 = 0
			local var_35_13 = 0.35

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_14 = arg_32_1:FormatText(StoryNameCfg[13].name)

				arg_32_1.leftNameTxt_.text = var_35_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_15 = arg_32_1:GetWordFromCfg(101041008)
				local var_35_16 = arg_32_1:FormatText(var_35_15.content)

				arg_32_1.text_.text = var_35_16

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 14
				local var_35_18 = utf8.len(var_35_16)
				local var_35_19 = var_35_17 <= 0 and var_35_13 or var_35_13 * (var_35_18 / var_35_17)

				if var_35_19 > 0 and var_35_13 < var_35_19 then
					arg_32_1.talkMaxDuration = var_35_19

					if var_35_19 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_19 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_16
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041008", "story_v_out_101041.awb") ~= 0 then
					local var_35_20 = manager.audio:GetVoiceLength("story_v_out_101041", "101041008", "story_v_out_101041.awb") / 1000

					if var_35_20 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_20 + var_35_12
					end

					if var_35_15.prefab_name ~= "" and arg_32_1.actors_[var_35_15.prefab_name] ~= nil then
						local var_35_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_15.prefab_name].transform, "story_v_out_101041", "101041008", "story_v_out_101041.awb")

						arg_32_1:RecordAudio("101041008", var_35_21)
						arg_32_1:RecordAudio("101041008", var_35_21)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_101041", "101041008", "story_v_out_101041.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_101041", "101041008", "story_v_out_101041.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_22 = math.max(var_35_13, arg_32_1.talkMaxDuration)

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_22 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_12) / var_35_22

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_12 + var_35_22 and arg_32_1.time_ < var_35_12 + var_35_22 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play101041009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 101041009
		arg_36_1.duration_ = 2.1

		local var_36_0 = {
			ja = 2.1,
			ko = 1.999999999999,
			zh = 2.066,
			en = 2.033
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play101041010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1037ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1037ui_story == nil then
				arg_36_1.var_.characterEffect1037ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1037ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1037ui_story then
				arg_36_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1019ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.1

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1019ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1019ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1019ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1019ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_39_12 = 0
			local var_39_13 = 0.15

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_14 = arg_36_1:FormatText(StoryNameCfg[15].name)

				arg_36_1.leftNameTxt_.text = var_39_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_15 = arg_36_1:GetWordFromCfg(101041009)
				local var_39_16 = arg_36_1:FormatText(var_39_15.content)

				arg_36_1.text_.text = var_39_16

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_17 = 6
				local var_39_18 = utf8.len(var_39_16)
				local var_39_19 = var_39_17 <= 0 and var_39_13 or var_39_13 * (var_39_18 / var_39_17)

				if var_39_19 > 0 and var_39_13 < var_39_19 then
					arg_36_1.talkMaxDuration = var_39_19

					if var_39_19 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_19 + var_39_12
					end
				end

				arg_36_1.text_.text = var_39_16
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041009", "story_v_out_101041.awb") ~= 0 then
					local var_39_20 = manager.audio:GetVoiceLength("story_v_out_101041", "101041009", "story_v_out_101041.awb") / 1000

					if var_39_20 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_20 + var_39_12
					end

					if var_39_15.prefab_name ~= "" and arg_36_1.actors_[var_39_15.prefab_name] ~= nil then
						local var_39_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_15.prefab_name].transform, "story_v_out_101041", "101041009", "story_v_out_101041.awb")

						arg_36_1:RecordAudio("101041009", var_39_21)
						arg_36_1:RecordAudio("101041009", var_39_21)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_101041", "101041009", "story_v_out_101041.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_101041", "101041009", "story_v_out_101041.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_22 = math.max(var_39_13, arg_36_1.talkMaxDuration)

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_22 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_12) / var_39_22

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_12 + var_39_22 and arg_36_1.time_ < var_39_12 + var_39_22 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play101041010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 101041010
		arg_40_1.duration_ = 11.5

		local var_40_0 = {
			ja = 7.666,
			ko = 11,
			zh = 11.5,
			en = 10.1
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play101041011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1019ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1019ui_story == nil then
				arg_40_1.var_.characterEffect1019ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1019ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1019ui_story then
				arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["1037ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1037ui_story == nil then
				arg_40_1.var_.characterEffect1037ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.1

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect1037ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1037ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1037ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1037ui_story.fillRatio = var_43_9
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			local var_43_11 = 0

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_43_12 = 0
			local var_43_13 = 1.15

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_14 = arg_40_1:FormatText(StoryNameCfg[13].name)

				arg_40_1.leftNameTxt_.text = var_43_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_15 = arg_40_1:GetWordFromCfg(101041010)
				local var_43_16 = arg_40_1:FormatText(var_43_15.content)

				arg_40_1.text_.text = var_43_16

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 45
				local var_43_18 = utf8.len(var_43_16)
				local var_43_19 = var_43_17 <= 0 and var_43_13 or var_43_13 * (var_43_18 / var_43_17)

				if var_43_19 > 0 and var_43_13 < var_43_19 then
					arg_40_1.talkMaxDuration = var_43_19

					if var_43_19 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_16
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041010", "story_v_out_101041.awb") ~= 0 then
					local var_43_20 = manager.audio:GetVoiceLength("story_v_out_101041", "101041010", "story_v_out_101041.awb") / 1000

					if var_43_20 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_20 + var_43_12
					end

					if var_43_15.prefab_name ~= "" and arg_40_1.actors_[var_43_15.prefab_name] ~= nil then
						local var_43_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_15.prefab_name].transform, "story_v_out_101041", "101041010", "story_v_out_101041.awb")

						arg_40_1:RecordAudio("101041010", var_43_21)
						arg_40_1:RecordAudio("101041010", var_43_21)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_101041", "101041010", "story_v_out_101041.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_101041", "101041010", "story_v_out_101041.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_22 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_22 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_12) / var_43_22

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_12 + var_43_22 and arg_40_1.time_ < var_43_12 + var_43_22 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play101041011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 101041011
		arg_44_1.duration_ = 3.13

		local var_44_0 = {
			ja = 1.999999999999,
			ko = 2.133,
			zh = 1.999999999999,
			en = 3.133
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
				arg_44_0:Play101041012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1037ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1037ui_story == nil then
				arg_44_1.var_.characterEffect1037ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1037ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1037ui_story then
				arg_44_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["1019ui_story"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.1

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect1019ui_story and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1019ui_story.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1019ui_story then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1019ui_story.fillRatio = var_47_9
			end

			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_1")
			end

			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9902cva")
			end

			local var_47_12 = 0
			local var_47_13 = 0.1

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_14 = arg_44_1:FormatText(StoryNameCfg[15].name)

				arg_44_1.leftNameTxt_.text = var_47_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_15 = arg_44_1:GetWordFromCfg(101041011)
				local var_47_16 = arg_44_1:FormatText(var_47_15.content)

				arg_44_1.text_.text = var_47_16

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 4
				local var_47_18 = utf8.len(var_47_16)
				local var_47_19 = var_47_17 <= 0 and var_47_13 or var_47_13 * (var_47_18 / var_47_17)

				if var_47_19 > 0 and var_47_13 < var_47_19 then
					arg_44_1.talkMaxDuration = var_47_19

					if var_47_19 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_19 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_16
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041011", "story_v_out_101041.awb") ~= 0 then
					local var_47_20 = manager.audio:GetVoiceLength("story_v_out_101041", "101041011", "story_v_out_101041.awb") / 1000

					if var_47_20 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_20 + var_47_12
					end

					if var_47_15.prefab_name ~= "" and arg_44_1.actors_[var_47_15.prefab_name] ~= nil then
						local var_47_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_15.prefab_name].transform, "story_v_out_101041", "101041011", "story_v_out_101041.awb")

						arg_44_1:RecordAudio("101041011", var_47_21)
						arg_44_1:RecordAudio("101041011", var_47_21)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_101041", "101041011", "story_v_out_101041.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_101041", "101041011", "story_v_out_101041.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_22 and arg_44_1.time_ < var_47_12 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play101041012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 101041012
		arg_48_1.duration_ = 5.7

		local var_48_0 = {
			ja = 5.7,
			ko = 3.133,
			zh = 3.666,
			en = 3.3
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play101041013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_2")
			end

			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_51_2 = 0
			local var_51_3 = 0.35

			if var_51_2 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_4 = arg_48_1:FormatText(StoryNameCfg[15].name)

				arg_48_1.leftNameTxt_.text = var_51_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_5 = arg_48_1:GetWordFromCfg(101041012)
				local var_51_6 = arg_48_1:FormatText(var_51_5.content)

				arg_48_1.text_.text = var_51_6

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 14
				local var_51_8 = utf8.len(var_51_6)
				local var_51_9 = var_51_7 <= 0 and var_51_3 or var_51_3 * (var_51_8 / var_51_7)

				if var_51_9 > 0 and var_51_3 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_2
					end
				end

				arg_48_1.text_.text = var_51_6
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041012", "story_v_out_101041.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_101041", "101041012", "story_v_out_101041.awb") / 1000

					if var_51_10 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_2
					end

					if var_51_5.prefab_name ~= "" and arg_48_1.actors_[var_51_5.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_5.prefab_name].transform, "story_v_out_101041", "101041012", "story_v_out_101041.awb")

						arg_48_1:RecordAudio("101041012", var_51_11)
						arg_48_1:RecordAudio("101041012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_101041", "101041012", "story_v_out_101041.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_101041", "101041012", "story_v_out_101041.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_3, arg_48_1.talkMaxDuration)

			if var_51_2 <= arg_48_1.time_ and arg_48_1.time_ < var_51_2 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_2) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_2 + var_51_12 and arg_48_1.time_ < var_51_2 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play101041013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 101041013
		arg_52_1.duration_ = 3.37

		local var_52_0 = {
			ja = 2.4,
			ko = 3.366,
			zh = 2.333,
			en = 3
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
				arg_52_0:Play101041014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "1036ui_story"

			if arg_52_1.actors_[var_55_0] == nil then
				local var_55_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_55_1) then
					local var_55_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_52_1.stage_.transform)

					var_55_2.name = var_55_0
					var_55_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_52_1.actors_[var_55_0] = var_55_2

					local var_55_3 = var_55_2:GetComponentInChildren(typeof(CharacterEffect))

					var_55_3.enabled = true

					local var_55_4 = GameObjectTools.GetOrAddComponent(var_55_2, typeof(DynamicBoneHelper))

					if var_55_4 then
						var_55_4:EnableDynamicBone(false)
					end

					arg_52_1:ShowWeapon(var_55_3.transform, false)

					arg_52_1.var_[var_55_0 .. "Animator"] = var_55_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_52_1.var_[var_55_0 .. "Animator"].applyRootMotion = true
					arg_52_1.var_[var_55_0 .. "LipSync"] = var_55_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_55_5 = arg_52_1.actors_["1036ui_story"]
			local var_55_6 = 0

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect1036ui_story == nil then
				arg_52_1.var_.characterEffect1036ui_story = var_55_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_7 = 0.1

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_7 and not isNil(var_55_5) then
				local var_55_8 = (arg_52_1.time_ - var_55_6) / var_55_7

				if arg_52_1.var_.characterEffect1036ui_story and not isNil(var_55_5) then
					arg_52_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_6 + var_55_7 and arg_52_1.time_ < var_55_6 + var_55_7 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect1036ui_story then
				arg_52_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_55_9 = arg_52_1.actors_["1037ui_story"].transform
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1.var_.moveOldPos1037ui_story = var_55_9.localPosition
			end

			local var_55_11 = 0.001

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11
				local var_55_13 = Vector3.New(0, 100, 0)

				var_55_9.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1037ui_story, var_55_13, var_55_12)

				local var_55_14 = manager.ui.mainCamera.transform.position - var_55_9.position

				var_55_9.forward = Vector3.New(var_55_14.x, var_55_14.y, var_55_14.z)

				local var_55_15 = var_55_9.localEulerAngles

				var_55_15.z = 0
				var_55_15.x = 0
				var_55_9.localEulerAngles = var_55_15
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 then
				var_55_9.localPosition = Vector3.New(0, 100, 0)

				local var_55_16 = manager.ui.mainCamera.transform.position - var_55_9.position

				var_55_9.forward = Vector3.New(var_55_16.x, var_55_16.y, var_55_16.z)

				local var_55_17 = var_55_9.localEulerAngles

				var_55_17.z = 0
				var_55_17.x = 0
				var_55_9.localEulerAngles = var_55_17
			end

			local var_55_18 = arg_52_1.actors_["1019ui_story"].transform
			local var_55_19 = 0

			if var_55_19 < arg_52_1.time_ and arg_52_1.time_ <= var_55_19 + arg_55_0 then
				arg_52_1.var_.moveOldPos1019ui_story = var_55_18.localPosition
			end

			local var_55_20 = 0.001

			if var_55_19 <= arg_52_1.time_ and arg_52_1.time_ < var_55_19 + var_55_20 then
				local var_55_21 = (arg_52_1.time_ - var_55_19) / var_55_20
				local var_55_22 = Vector3.New(0.7, -1.08, -5.9)

				var_55_18.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1019ui_story, var_55_22, var_55_21)

				local var_55_23 = manager.ui.mainCamera.transform.position - var_55_18.position

				var_55_18.forward = Vector3.New(var_55_23.x, var_55_23.y, var_55_23.z)

				local var_55_24 = var_55_18.localEulerAngles

				var_55_24.z = 0
				var_55_24.x = 0
				var_55_18.localEulerAngles = var_55_24
			end

			if arg_52_1.time_ >= var_55_19 + var_55_20 and arg_52_1.time_ < var_55_19 + var_55_20 + arg_55_0 then
				var_55_18.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_55_25 = manager.ui.mainCamera.transform.position - var_55_18.position

				var_55_18.forward = Vector3.New(var_55_25.x, var_55_25.y, var_55_25.z)

				local var_55_26 = var_55_18.localEulerAngles

				var_55_26.z = 0
				var_55_26.x = 0
				var_55_18.localEulerAngles = var_55_26
			end

			local var_55_27 = arg_52_1.actors_["1036ui_story"].transform
			local var_55_28 = 0

			if var_55_28 < arg_52_1.time_ and arg_52_1.time_ <= var_55_28 + arg_55_0 then
				arg_52_1.var_.moveOldPos1036ui_story = var_55_27.localPosition
			end

			local var_55_29 = 0.001

			if var_55_28 <= arg_52_1.time_ and arg_52_1.time_ < var_55_28 + var_55_29 then
				local var_55_30 = (arg_52_1.time_ - var_55_28) / var_55_29
				local var_55_31 = Vector3.New(-0.7, -1.09, -5.78)

				var_55_27.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1036ui_story, var_55_31, var_55_30)

				local var_55_32 = manager.ui.mainCamera.transform.position - var_55_27.position

				var_55_27.forward = Vector3.New(var_55_32.x, var_55_32.y, var_55_32.z)

				local var_55_33 = var_55_27.localEulerAngles

				var_55_33.z = 0
				var_55_33.x = 0
				var_55_27.localEulerAngles = var_55_33
			end

			if arg_52_1.time_ >= var_55_28 + var_55_29 and arg_52_1.time_ < var_55_28 + var_55_29 + arg_55_0 then
				var_55_27.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_55_34 = manager.ui.mainCamera.transform.position - var_55_27.position

				var_55_27.forward = Vector3.New(var_55_34.x, var_55_34.y, var_55_34.z)

				local var_55_35 = var_55_27.localEulerAngles

				var_55_35.z = 0
				var_55_35.x = 0
				var_55_27.localEulerAngles = var_55_35
			end

			local var_55_36 = 0

			if var_55_36 < arg_52_1.time_ and arg_52_1.time_ <= var_55_36 + arg_55_0 then
				arg_52_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action1_1")
			end

			local var_55_37 = 0

			if var_55_37 < arg_52_1.time_ and arg_52_1.time_ <= var_55_37 + arg_55_0 then
				arg_52_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_55_38 = 0
			local var_55_39 = 0.25

			if var_55_38 < arg_52_1.time_ and arg_52_1.time_ <= var_55_38 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_40 = arg_52_1:FormatText(StoryNameCfg[5].name)

				arg_52_1.leftNameTxt_.text = var_55_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_41 = arg_52_1:GetWordFromCfg(101041013)
				local var_55_42 = arg_52_1:FormatText(var_55_41.content)

				arg_52_1.text_.text = var_55_42

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_43 = 10
				local var_55_44 = utf8.len(var_55_42)
				local var_55_45 = var_55_43 <= 0 and var_55_39 or var_55_39 * (var_55_44 / var_55_43)

				if var_55_45 > 0 and var_55_39 < var_55_45 then
					arg_52_1.talkMaxDuration = var_55_45

					if var_55_45 + var_55_38 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_45 + var_55_38
					end
				end

				arg_52_1.text_.text = var_55_42
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041013", "story_v_out_101041.awb") ~= 0 then
					local var_55_46 = manager.audio:GetVoiceLength("story_v_out_101041", "101041013", "story_v_out_101041.awb") / 1000

					if var_55_46 + var_55_38 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_46 + var_55_38
					end

					if var_55_41.prefab_name ~= "" and arg_52_1.actors_[var_55_41.prefab_name] ~= nil then
						local var_55_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_41.prefab_name].transform, "story_v_out_101041", "101041013", "story_v_out_101041.awb")

						arg_52_1:RecordAudio("101041013", var_55_47)
						arg_52_1:RecordAudio("101041013", var_55_47)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_101041", "101041013", "story_v_out_101041.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_101041", "101041013", "story_v_out_101041.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_48 = math.max(var_55_39, arg_52_1.talkMaxDuration)

			if var_55_38 <= arg_52_1.time_ and arg_52_1.time_ < var_55_38 + var_55_48 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_38) / var_55_48

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_38 + var_55_48 and arg_52_1.time_ < var_55_38 + var_55_48 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play101041014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 101041014
		arg_56_1.duration_ = 5.47

		local var_56_0 = {
			ja = 5.466,
			ko = 4.066,
			zh = 3.533,
			en = 3.166
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play101041015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1036ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1036ui_story == nil then
				arg_56_1.var_.characterEffect1036ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1036ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1036ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1036ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1036ui_story.fillRatio = var_59_5
			end

			local var_59_6 = 0
			local var_59_7 = 0.35

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_8 = arg_56_1:FormatText(StoryNameCfg[15].name)

				arg_56_1.leftNameTxt_.text = var_59_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_9 = arg_56_1:GetWordFromCfg(101041014)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 14
				local var_59_12 = utf8.len(var_59_10)
				local var_59_13 = var_59_11 <= 0 and var_59_7 or var_59_7 * (var_59_12 / var_59_11)

				if var_59_13 > 0 and var_59_7 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041014", "story_v_out_101041.awb") ~= 0 then
					local var_59_14 = manager.audio:GetVoiceLength("story_v_out_101041", "101041014", "story_v_out_101041.awb") / 1000

					if var_59_14 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_14 + var_59_6
					end

					if var_59_9.prefab_name ~= "" and arg_56_1.actors_[var_59_9.prefab_name] ~= nil then
						local var_59_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_9.prefab_name].transform, "story_v_out_101041", "101041014", "story_v_out_101041.awb")

						arg_56_1:RecordAudio("101041014", var_59_15)
						arg_56_1:RecordAudio("101041014", var_59_15)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_101041", "101041014", "story_v_out_101041.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_101041", "101041014", "story_v_out_101041.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_16 and arg_56_1.time_ < var_59_6 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play101041015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 101041015
		arg_60_1.duration_ = 2

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play101041016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 1

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				local var_63_2 = "play"
				local var_63_3 = "effect"

				arg_60_1:AudioAction(var_63_2, var_63_3, "se_story", "se_story_gasgate_open", "")
			end

			local var_63_4 = 0

			if var_63_4 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action2_1")
			end

			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_63_6 = arg_60_1.actors_["1036ui_story"]
			local var_63_7 = 0

			if var_63_7 < arg_60_1.time_ and arg_60_1.time_ <= var_63_7 + arg_63_0 and not isNil(var_63_6) and arg_60_1.var_.characterEffect1036ui_story == nil then
				arg_60_1.var_.characterEffect1036ui_story = var_63_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_8 = 0.1

			if var_63_7 <= arg_60_1.time_ and arg_60_1.time_ < var_63_7 + var_63_8 and not isNil(var_63_6) then
				local var_63_9 = (arg_60_1.time_ - var_63_7) / var_63_8

				if arg_60_1.var_.characterEffect1036ui_story and not isNil(var_63_6) then
					arg_60_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_7 + var_63_8 and arg_60_1.time_ < var_63_7 + var_63_8 + arg_63_0 and not isNil(var_63_6) and arg_60_1.var_.characterEffect1036ui_story then
				arg_60_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_63_10 = 0
			local var_63_11 = 0.1

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_12 = arg_60_1:FormatText(StoryNameCfg[5].name)

				arg_60_1.leftNameTxt_.text = var_63_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_13 = arg_60_1:GetWordFromCfg(101041015)
				local var_63_14 = arg_60_1:FormatText(var_63_13.content)

				arg_60_1.text_.text = var_63_14

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_15 = 4
				local var_63_16 = utf8.len(var_63_14)
				local var_63_17 = var_63_15 <= 0 and var_63_11 or var_63_11 * (var_63_16 / var_63_15)

				if var_63_17 > 0 and var_63_11 < var_63_17 then
					arg_60_1.talkMaxDuration = var_63_17

					if var_63_17 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_17 + var_63_10
					end
				end

				arg_60_1.text_.text = var_63_14
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041015", "story_v_out_101041.awb") ~= 0 then
					local var_63_18 = manager.audio:GetVoiceLength("story_v_out_101041", "101041015", "story_v_out_101041.awb") / 1000

					if var_63_18 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_18 + var_63_10
					end

					if var_63_13.prefab_name ~= "" and arg_60_1.actors_[var_63_13.prefab_name] ~= nil then
						local var_63_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_13.prefab_name].transform, "story_v_out_101041", "101041015", "story_v_out_101041.awb")

						arg_60_1:RecordAudio("101041015", var_63_19)
						arg_60_1:RecordAudio("101041015", var_63_19)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_101041", "101041015", "story_v_out_101041.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_101041", "101041015", "story_v_out_101041.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_20 = math.max(var_63_11, arg_60_1.talkMaxDuration)

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_20 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_10) / var_63_20

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_10 + var_63_20 and arg_60_1.time_ < var_63_10 + var_63_20 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play101041016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 101041016
		arg_64_1.duration_ = 3.27

		local var_64_0 = {
			ja = 3.266,
			ko = 1.999999999999,
			zh = 2.466,
			en = 3
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play101041017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 1

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				local var_67_2 = "play"
				local var_67_3 = "effect"

				arg_64_1:AudioAction(var_67_2, var_67_3, "se_story", "se_story_gasgate_close", "")
			end

			local var_67_4 = 0

			if var_67_4 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action424")
			end

			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_67_6 = 0

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_67_7 = 0
			local var_67_8 = 0.25

			if var_67_7 < arg_64_1.time_ and arg_64_1.time_ <= var_67_7 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_9 = arg_64_1:FormatText(StoryNameCfg[5].name)

				arg_64_1.leftNameTxt_.text = var_67_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_10 = arg_64_1:GetWordFromCfg(101041016)
				local var_67_11 = arg_64_1:FormatText(var_67_10.content)

				arg_64_1.text_.text = var_67_11

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_12 = 10
				local var_67_13 = utf8.len(var_67_11)
				local var_67_14 = var_67_12 <= 0 and var_67_8 or var_67_8 * (var_67_13 / var_67_12)

				if var_67_14 > 0 and var_67_8 < var_67_14 then
					arg_64_1.talkMaxDuration = var_67_14

					if var_67_14 + var_67_7 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_14 + var_67_7
					end
				end

				arg_64_1.text_.text = var_67_11
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041016", "story_v_out_101041.awb") ~= 0 then
					local var_67_15 = manager.audio:GetVoiceLength("story_v_out_101041", "101041016", "story_v_out_101041.awb") / 1000

					if var_67_15 + var_67_7 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_15 + var_67_7
					end

					if var_67_10.prefab_name ~= "" and arg_64_1.actors_[var_67_10.prefab_name] ~= nil then
						local var_67_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_10.prefab_name].transform, "story_v_out_101041", "101041016", "story_v_out_101041.awb")

						arg_64_1:RecordAudio("101041016", var_67_16)
						arg_64_1:RecordAudio("101041016", var_67_16)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_101041", "101041016", "story_v_out_101041.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_101041", "101041016", "story_v_out_101041.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_17 = math.max(var_67_8, arg_64_1.talkMaxDuration)

			if var_67_7 <= arg_64_1.time_ and arg_64_1.time_ < var_67_7 + var_67_17 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_7) / var_67_17

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_7 + var_67_17 and arg_64_1.time_ < var_67_7 + var_67_17 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play101041017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 101041017
		arg_68_1.duration_ = 4.7

		local var_68_0 = {
			ja = 4.7,
			ko = 2.066,
			zh = 3.233,
			en = 2.2
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play101041018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1019ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1019ui_story == nil then
				arg_68_1.var_.characterEffect1019ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1019ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1019ui_story then
				arg_68_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["1036ui_story"]
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1036ui_story == nil then
				arg_68_1.var_.characterEffect1036ui_story = var_71_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_6 = 0.1

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 and not isNil(var_71_4) then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6

				if arg_68_1.var_.characterEffect1036ui_story and not isNil(var_71_4) then
					local var_71_8 = Mathf.Lerp(0, 0.5, var_71_7)

					arg_68_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1036ui_story.fillRatio = var_71_8
				end
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1036ui_story then
				local var_71_9 = 0.5

				arg_68_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1036ui_story.fillRatio = var_71_9
			end

			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_71_11 = 0
			local var_71_12 = 0.225

			if var_71_11 < arg_68_1.time_ and arg_68_1.time_ <= var_71_11 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_13 = arg_68_1:FormatText(StoryNameCfg[13].name)

				arg_68_1.leftNameTxt_.text = var_71_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_14 = arg_68_1:GetWordFromCfg(101041017)
				local var_71_15 = arg_68_1:FormatText(var_71_14.content)

				arg_68_1.text_.text = var_71_15

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_16 = 9
				local var_71_17 = utf8.len(var_71_15)
				local var_71_18 = var_71_16 <= 0 and var_71_12 or var_71_12 * (var_71_17 / var_71_16)

				if var_71_18 > 0 and var_71_12 < var_71_18 then
					arg_68_1.talkMaxDuration = var_71_18

					if var_71_18 + var_71_11 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_18 + var_71_11
					end
				end

				arg_68_1.text_.text = var_71_15
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041017", "story_v_out_101041.awb") ~= 0 then
					local var_71_19 = manager.audio:GetVoiceLength("story_v_out_101041", "101041017", "story_v_out_101041.awb") / 1000

					if var_71_19 + var_71_11 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_19 + var_71_11
					end

					if var_71_14.prefab_name ~= "" and arg_68_1.actors_[var_71_14.prefab_name] ~= nil then
						local var_71_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_14.prefab_name].transform, "story_v_out_101041", "101041017", "story_v_out_101041.awb")

						arg_68_1:RecordAudio("101041017", var_71_20)
						arg_68_1:RecordAudio("101041017", var_71_20)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_101041", "101041017", "story_v_out_101041.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_101041", "101041017", "story_v_out_101041.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_21 = math.max(var_71_12, arg_68_1.talkMaxDuration)

			if var_71_11 <= arg_68_1.time_ and arg_68_1.time_ < var_71_11 + var_71_21 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_11) / var_71_21

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_11 + var_71_21 and arg_68_1.time_ < var_71_11 + var_71_21 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play101041018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 101041018
		arg_72_1.duration_ = 6.9

		local var_72_0 = {
			ja = 6.9,
			ko = 5.1,
			zh = 4.133,
			en = 4.533
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play101041019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1036ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1036ui_story == nil then
				arg_72_1.var_.characterEffect1036ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1036ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1036ui_story then
				arg_72_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_75_4 = arg_72_1.actors_["1019ui_story"]
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect1019ui_story == nil then
				arg_72_1.var_.characterEffect1019ui_story = var_75_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.1

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 and not isNil(var_75_4) then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6

				if arg_72_1.var_.characterEffect1019ui_story and not isNil(var_75_4) then
					local var_75_8 = Mathf.Lerp(0, 0.5, var_75_7)

					arg_72_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1019ui_story.fillRatio = var_75_8
				end
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect1019ui_story then
				local var_75_9 = 0.5

				arg_72_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1019ui_story.fillRatio = var_75_9
			end

			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 then
				arg_72_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action445")
			end

			local var_75_11 = 0

			if var_75_11 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 then
				arg_72_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_75_12 = 0
			local var_75_13 = 0.375

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_14 = arg_72_1:FormatText(StoryNameCfg[5].name)

				arg_72_1.leftNameTxt_.text = var_75_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_15 = arg_72_1:GetWordFromCfg(101041018)
				local var_75_16 = arg_72_1:FormatText(var_75_15.content)

				arg_72_1.text_.text = var_75_16

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_17 = 15
				local var_75_18 = utf8.len(var_75_16)
				local var_75_19 = var_75_17 <= 0 and var_75_13 or var_75_13 * (var_75_18 / var_75_17)

				if var_75_19 > 0 and var_75_13 < var_75_19 then
					arg_72_1.talkMaxDuration = var_75_19

					if var_75_19 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_19 + var_75_12
					end
				end

				arg_72_1.text_.text = var_75_16
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041018", "story_v_out_101041.awb") ~= 0 then
					local var_75_20 = manager.audio:GetVoiceLength("story_v_out_101041", "101041018", "story_v_out_101041.awb") / 1000

					if var_75_20 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_20 + var_75_12
					end

					if var_75_15.prefab_name ~= "" and arg_72_1.actors_[var_75_15.prefab_name] ~= nil then
						local var_75_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_15.prefab_name].transform, "story_v_out_101041", "101041018", "story_v_out_101041.awb")

						arg_72_1:RecordAudio("101041018", var_75_21)
						arg_72_1:RecordAudio("101041018", var_75_21)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_101041", "101041018", "story_v_out_101041.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_101041", "101041018", "story_v_out_101041.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_22 = math.max(var_75_13, arg_72_1.talkMaxDuration)

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_22 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_12) / var_75_22

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_12 + var_75_22 and arg_72_1.time_ < var_75_12 + var_75_22 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play101041019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 101041019
		arg_76_1.duration_ = 4.8

		local var_76_0 = {
			ja = 4.8,
			ko = 2.566,
			zh = 3.533,
			en = 2.533
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play101041020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1019ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1019ui_story == nil then
				arg_76_1.var_.characterEffect1019ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1019ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1019ui_story then
				arg_76_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["1036ui_story"]
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1036ui_story == nil then
				arg_76_1.var_.characterEffect1036ui_story = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_6 = 0.1

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 and not isNil(var_79_4) then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6

				if arg_76_1.var_.characterEffect1036ui_story and not isNil(var_79_4) then
					local var_79_8 = Mathf.Lerp(0, 0.5, var_79_7)

					arg_76_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1036ui_story.fillRatio = var_79_8
				end
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1036ui_story then
				local var_79_9 = 0.5

				arg_76_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1036ui_story.fillRatio = var_79_9
			end

			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_79_11 = 0
			local var_79_12 = 0.325

			if var_79_11 < arg_76_1.time_ and arg_76_1.time_ <= var_79_11 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_13 = arg_76_1:FormatText(StoryNameCfg[13].name)

				arg_76_1.leftNameTxt_.text = var_79_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_14 = arg_76_1:GetWordFromCfg(101041019)
				local var_79_15 = arg_76_1:FormatText(var_79_14.content)

				arg_76_1.text_.text = var_79_15

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_16 = 13
				local var_79_17 = utf8.len(var_79_15)
				local var_79_18 = var_79_16 <= 0 and var_79_12 or var_79_12 * (var_79_17 / var_79_16)

				if var_79_18 > 0 and var_79_12 < var_79_18 then
					arg_76_1.talkMaxDuration = var_79_18

					if var_79_18 + var_79_11 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_18 + var_79_11
					end
				end

				arg_76_1.text_.text = var_79_15
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041019", "story_v_out_101041.awb") ~= 0 then
					local var_79_19 = manager.audio:GetVoiceLength("story_v_out_101041", "101041019", "story_v_out_101041.awb") / 1000

					if var_79_19 + var_79_11 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_19 + var_79_11
					end

					if var_79_14.prefab_name ~= "" and arg_76_1.actors_[var_79_14.prefab_name] ~= nil then
						local var_79_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_14.prefab_name].transform, "story_v_out_101041", "101041019", "story_v_out_101041.awb")

						arg_76_1:RecordAudio("101041019", var_79_20)
						arg_76_1:RecordAudio("101041019", var_79_20)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_101041", "101041019", "story_v_out_101041.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_101041", "101041019", "story_v_out_101041.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_21 = math.max(var_79_12, arg_76_1.talkMaxDuration)

			if var_79_11 <= arg_76_1.time_ and arg_76_1.time_ < var_79_11 + var_79_21 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_11) / var_79_21

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_11 + var_79_21 and arg_76_1.time_ < var_79_11 + var_79_21 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play101041020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 101041020
		arg_80_1.duration_ = 3.83

		local var_80_0 = {
			ja = 3.833,
			ko = 2.033,
			zh = 2.3,
			en = 2.8
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play101041021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1036ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1036ui_story == nil then
				arg_80_1.var_.characterEffect1036ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1036ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1036ui_story then
				arg_80_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["1019ui_story"]
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1019ui_story == nil then
				arg_80_1.var_.characterEffect1019ui_story = var_83_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.1

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 and not isNil(var_83_4) then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6

				if arg_80_1.var_.characterEffect1019ui_story and not isNil(var_83_4) then
					local var_83_8 = Mathf.Lerp(0, 0.5, var_83_7)

					arg_80_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1019ui_story.fillRatio = var_83_8
				end
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1019ui_story then
				local var_83_9 = 0.5

				arg_80_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1019ui_story.fillRatio = var_83_9
			end

			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action456")
			end

			local var_83_11 = 0

			if var_83_11 < arg_80_1.time_ and arg_80_1.time_ <= var_83_11 + arg_83_0 then
				arg_80_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_83_12 = 0
			local var_83_13 = 0.175

			if var_83_12 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_14 = arg_80_1:FormatText(StoryNameCfg[5].name)

				arg_80_1.leftNameTxt_.text = var_83_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_15 = arg_80_1:GetWordFromCfg(101041020)
				local var_83_16 = arg_80_1:FormatText(var_83_15.content)

				arg_80_1.text_.text = var_83_16

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_17 = 7
				local var_83_18 = utf8.len(var_83_16)
				local var_83_19 = var_83_17 <= 0 and var_83_13 or var_83_13 * (var_83_18 / var_83_17)

				if var_83_19 > 0 and var_83_13 < var_83_19 then
					arg_80_1.talkMaxDuration = var_83_19

					if var_83_19 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_19 + var_83_12
					end
				end

				arg_80_1.text_.text = var_83_16
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041020", "story_v_out_101041.awb") ~= 0 then
					local var_83_20 = manager.audio:GetVoiceLength("story_v_out_101041", "101041020", "story_v_out_101041.awb") / 1000

					if var_83_20 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_20 + var_83_12
					end

					if var_83_15.prefab_name ~= "" and arg_80_1.actors_[var_83_15.prefab_name] ~= nil then
						local var_83_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_15.prefab_name].transform, "story_v_out_101041", "101041020", "story_v_out_101041.awb")

						arg_80_1:RecordAudio("101041020", var_83_21)
						arg_80_1:RecordAudio("101041020", var_83_21)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_101041", "101041020", "story_v_out_101041.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_101041", "101041020", "story_v_out_101041.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_22 = math.max(var_83_13, arg_80_1.talkMaxDuration)

			if var_83_12 <= arg_80_1.time_ and arg_80_1.time_ < var_83_12 + var_83_22 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_12) / var_83_22

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_12 + var_83_22 and arg_80_1.time_ < var_83_12 + var_83_22 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play101041021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 101041021
		arg_84_1.duration_ = 4.83

		local var_84_0 = {
			ja = 4.833,
			ko = 3.2,
			zh = 3.8,
			en = 3.866
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play101041022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1019ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1019ui_story == nil then
				arg_84_1.var_.characterEffect1019ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1019ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1019ui_story then
				arg_84_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_87_4 = arg_84_1.actors_["1036ui_story"]
			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1036ui_story == nil then
				arg_84_1.var_.characterEffect1036ui_story = var_87_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.1

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 and not isNil(var_87_4) then
				local var_87_7 = (arg_84_1.time_ - var_87_5) / var_87_6

				if arg_84_1.var_.characterEffect1036ui_story and not isNil(var_87_4) then
					local var_87_8 = Mathf.Lerp(0, 0.5, var_87_7)

					arg_84_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1036ui_story.fillRatio = var_87_8
				end
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1036ui_story then
				local var_87_9 = 0.5

				arg_84_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1036ui_story.fillRatio = var_87_9
			end

			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_87_11 = 0

			if var_87_11 < arg_84_1.time_ and arg_84_1.time_ <= var_87_11 + arg_87_0 then
				arg_84_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_87_12 = 0
			local var_87_13 = 0.4

			if var_87_12 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_14 = arg_84_1:FormatText(StoryNameCfg[13].name)

				arg_84_1.leftNameTxt_.text = var_87_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_15 = arg_84_1:GetWordFromCfg(101041021)
				local var_87_16 = arg_84_1:FormatText(var_87_15.content)

				arg_84_1.text_.text = var_87_16

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_17 = 16
				local var_87_18 = utf8.len(var_87_16)
				local var_87_19 = var_87_17 <= 0 and var_87_13 or var_87_13 * (var_87_18 / var_87_17)

				if var_87_19 > 0 and var_87_13 < var_87_19 then
					arg_84_1.talkMaxDuration = var_87_19

					if var_87_19 + var_87_12 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_19 + var_87_12
					end
				end

				arg_84_1.text_.text = var_87_16
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041021", "story_v_out_101041.awb") ~= 0 then
					local var_87_20 = manager.audio:GetVoiceLength("story_v_out_101041", "101041021", "story_v_out_101041.awb") / 1000

					if var_87_20 + var_87_12 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_20 + var_87_12
					end

					if var_87_15.prefab_name ~= "" and arg_84_1.actors_[var_87_15.prefab_name] ~= nil then
						local var_87_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_15.prefab_name].transform, "story_v_out_101041", "101041021", "story_v_out_101041.awb")

						arg_84_1:RecordAudio("101041021", var_87_21)
						arg_84_1:RecordAudio("101041021", var_87_21)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_101041", "101041021", "story_v_out_101041.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_101041", "101041021", "story_v_out_101041.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_22 = math.max(var_87_13, arg_84_1.talkMaxDuration)

			if var_87_12 <= arg_84_1.time_ and arg_84_1.time_ < var_87_12 + var_87_22 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_12) / var_87_22

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_12 + var_87_22 and arg_84_1.time_ < var_87_12 + var_87_22 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play101041022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 101041022
		arg_88_1.duration_ = 3.7

		local var_88_0 = {
			ja = 3.7,
			ko = 3,
			zh = 2.433,
			en = 3.4
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play101041023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action6_2")
			end

			local var_91_2 = 0

			if var_91_2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_91_3 = 0
			local var_91_4 = 0.3

			if var_91_3 < arg_88_1.time_ and arg_88_1.time_ <= var_91_3 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_5 = arg_88_1:FormatText(StoryNameCfg[13].name)

				arg_88_1.leftNameTxt_.text = var_91_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_6 = arg_88_1:GetWordFromCfg(101041022)
				local var_91_7 = arg_88_1:FormatText(var_91_6.content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_8 = 10
				local var_91_9 = utf8.len(var_91_7)
				local var_91_10 = var_91_8 <= 0 and var_91_4 or var_91_4 * (var_91_9 / var_91_8)

				if var_91_10 > 0 and var_91_4 < var_91_10 then
					arg_88_1.talkMaxDuration = var_91_10

					if var_91_10 + var_91_3 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_3
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041022", "story_v_out_101041.awb") ~= 0 then
					local var_91_11 = manager.audio:GetVoiceLength("story_v_out_101041", "101041022", "story_v_out_101041.awb") / 1000

					if var_91_11 + var_91_3 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_11 + var_91_3
					end

					if var_91_6.prefab_name ~= "" and arg_88_1.actors_[var_91_6.prefab_name] ~= nil then
						local var_91_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_6.prefab_name].transform, "story_v_out_101041", "101041022", "story_v_out_101041.awb")

						arg_88_1:RecordAudio("101041022", var_91_12)
						arg_88_1:RecordAudio("101041022", var_91_12)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_101041", "101041022", "story_v_out_101041.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_101041", "101041022", "story_v_out_101041.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_13 = math.max(var_91_4, arg_88_1.talkMaxDuration)

			if var_91_3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_3 + var_91_13 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_3) / var_91_13

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_3 + var_91_13 and arg_88_1.time_ < var_91_3 + var_91_13 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play101041023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 101041023
		arg_92_1.duration_ = 9.3

		local var_92_0 = {
			ja = 9.3,
			ko = 5.866,
			zh = 5.5,
			en = 4.2
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
				arg_92_0:Play101041024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1036ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1036ui_story == nil then
				arg_92_1.var_.characterEffect1036ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.1

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1036ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1036ui_story then
				arg_92_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_95_4 = arg_92_1.actors_["1019ui_story"]
			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1019ui_story == nil then
				arg_92_1.var_.characterEffect1019ui_story = var_95_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.1

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 and not isNil(var_95_4) then
				local var_95_7 = (arg_92_1.time_ - var_95_5) / var_95_6

				if arg_92_1.var_.characterEffect1019ui_story and not isNil(var_95_4) then
					local var_95_8 = Mathf.Lerp(0, 0.5, var_95_7)

					arg_92_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1019ui_story.fillRatio = var_95_8
				end
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1019ui_story then
				local var_95_9 = 0.5

				arg_92_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1019ui_story.fillRatio = var_95_9
			end

			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			local var_95_11 = 0

			if var_95_11 < arg_92_1.time_ and arg_92_1.time_ <= var_95_11 + arg_95_0 then
				arg_92_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_95_12 = 0
			local var_95_13 = 0.575

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_14 = arg_92_1:FormatText(StoryNameCfg[5].name)

				arg_92_1.leftNameTxt_.text = var_95_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_15 = arg_92_1:GetWordFromCfg(101041023)
				local var_95_16 = arg_92_1:FormatText(var_95_15.content)

				arg_92_1.text_.text = var_95_16

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_17 = 23
				local var_95_18 = utf8.len(var_95_16)
				local var_95_19 = var_95_17 <= 0 and var_95_13 or var_95_13 * (var_95_18 / var_95_17)

				if var_95_19 > 0 and var_95_13 < var_95_19 then
					arg_92_1.talkMaxDuration = var_95_19

					if var_95_19 + var_95_12 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_19 + var_95_12
					end
				end

				arg_92_1.text_.text = var_95_16
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041023", "story_v_out_101041.awb") ~= 0 then
					local var_95_20 = manager.audio:GetVoiceLength("story_v_out_101041", "101041023", "story_v_out_101041.awb") / 1000

					if var_95_20 + var_95_12 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_20 + var_95_12
					end

					if var_95_15.prefab_name ~= "" and arg_92_1.actors_[var_95_15.prefab_name] ~= nil then
						local var_95_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_15.prefab_name].transform, "story_v_out_101041", "101041023", "story_v_out_101041.awb")

						arg_92_1:RecordAudio("101041023", var_95_21)
						arg_92_1:RecordAudio("101041023", var_95_21)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_101041", "101041023", "story_v_out_101041.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_101041", "101041023", "story_v_out_101041.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_22 = math.max(var_95_13, arg_92_1.talkMaxDuration)

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_22 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_12) / var_95_22

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_12 + var_95_22 and arg_92_1.time_ < var_95_12 + var_95_22 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play101041024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 101041024
		arg_96_1.duration_ = 14.1

		local var_96_0 = {
			ja = 14.1,
			ko = 7.866,
			zh = 9.4,
			en = 7.333
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
				arg_96_0:Play101041025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1019ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1019ui_story == nil then
				arg_96_1.var_.characterEffect1019ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1019ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1019ui_story then
				arg_96_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_99_4 = arg_96_1.actors_["1036ui_story"]
			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1036ui_story == nil then
				arg_96_1.var_.characterEffect1036ui_story = var_99_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.1

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 and not isNil(var_99_4) then
				local var_99_7 = (arg_96_1.time_ - var_99_5) / var_99_6

				if arg_96_1.var_.characterEffect1036ui_story and not isNil(var_99_4) then
					local var_99_8 = Mathf.Lerp(0, 0.5, var_99_7)

					arg_96_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1036ui_story.fillRatio = var_99_8
				end
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1036ui_story then
				local var_99_9 = 0.5

				arg_96_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1036ui_story.fillRatio = var_99_9
			end

			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action452")
			end

			local var_99_11 = 0

			if var_99_11 < arg_96_1.time_ and arg_96_1.time_ <= var_99_11 + arg_99_0 then
				arg_96_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_99_12 = 0
			local var_99_13 = 1.075

			if var_99_12 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_14 = arg_96_1:FormatText(StoryNameCfg[13].name)

				arg_96_1.leftNameTxt_.text = var_99_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_15 = arg_96_1:GetWordFromCfg(101041024)
				local var_99_16 = arg_96_1:FormatText(var_99_15.content)

				arg_96_1.text_.text = var_99_16

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_17 = 43
				local var_99_18 = utf8.len(var_99_16)
				local var_99_19 = var_99_17 <= 0 and var_99_13 or var_99_13 * (var_99_18 / var_99_17)

				if var_99_19 > 0 and var_99_13 < var_99_19 then
					arg_96_1.talkMaxDuration = var_99_19

					if var_99_19 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_19 + var_99_12
					end
				end

				arg_96_1.text_.text = var_99_16
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041024", "story_v_out_101041.awb") ~= 0 then
					local var_99_20 = manager.audio:GetVoiceLength("story_v_out_101041", "101041024", "story_v_out_101041.awb") / 1000

					if var_99_20 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_20 + var_99_12
					end

					if var_99_15.prefab_name ~= "" and arg_96_1.actors_[var_99_15.prefab_name] ~= nil then
						local var_99_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_15.prefab_name].transform, "story_v_out_101041", "101041024", "story_v_out_101041.awb")

						arg_96_1:RecordAudio("101041024", var_99_21)
						arg_96_1:RecordAudio("101041024", var_99_21)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_101041", "101041024", "story_v_out_101041.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_101041", "101041024", "story_v_out_101041.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_22 = math.max(var_99_13, arg_96_1.talkMaxDuration)

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_22 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_12) / var_99_22

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_12 + var_99_22 and arg_96_1.time_ < var_99_12 + var_99_22 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play101041025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 101041025
		arg_100_1.duration_ = 8.73

		local var_100_0 = {
			ja = 8.733,
			ko = 4.066,
			zh = 4.333,
			en = 4.433
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
				arg_100_0:Play101041026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1036ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1036ui_story == nil then
				arg_100_1.var_.characterEffect1036ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.1

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1036ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1036ui_story then
				arg_100_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_103_4 = arg_100_1.actors_["1019ui_story"]
			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect1019ui_story == nil then
				arg_100_1.var_.characterEffect1019ui_story = var_103_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.1

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_6 and not isNil(var_103_4) then
				local var_103_7 = (arg_100_1.time_ - var_103_5) / var_103_6

				if arg_100_1.var_.characterEffect1019ui_story and not isNil(var_103_4) then
					local var_103_8 = Mathf.Lerp(0, 0.5, var_103_7)

					arg_100_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1019ui_story.fillRatio = var_103_8
				end
			end

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect1019ui_story then
				local var_103_9 = 0.5

				arg_100_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1019ui_story.fillRatio = var_103_9
			end

			local var_103_10 = 0

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action442")
			end

			local var_103_11 = 0

			if var_103_11 < arg_100_1.time_ and arg_100_1.time_ <= var_103_11 + arg_103_0 then
				arg_100_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_103_12 = 0
			local var_103_13 = 0.575

			if var_103_12 < arg_100_1.time_ and arg_100_1.time_ <= var_103_12 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_14 = arg_100_1:FormatText(StoryNameCfg[5].name)

				arg_100_1.leftNameTxt_.text = var_103_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_15 = arg_100_1:GetWordFromCfg(101041025)
				local var_103_16 = arg_100_1:FormatText(var_103_15.content)

				arg_100_1.text_.text = var_103_16

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_17 = 22
				local var_103_18 = utf8.len(var_103_16)
				local var_103_19 = var_103_17 <= 0 and var_103_13 or var_103_13 * (var_103_18 / var_103_17)

				if var_103_19 > 0 and var_103_13 < var_103_19 then
					arg_100_1.talkMaxDuration = var_103_19

					if var_103_19 + var_103_12 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_19 + var_103_12
					end
				end

				arg_100_1.text_.text = var_103_16
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041025", "story_v_out_101041.awb") ~= 0 then
					local var_103_20 = manager.audio:GetVoiceLength("story_v_out_101041", "101041025", "story_v_out_101041.awb") / 1000

					if var_103_20 + var_103_12 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_20 + var_103_12
					end

					if var_103_15.prefab_name ~= "" and arg_100_1.actors_[var_103_15.prefab_name] ~= nil then
						local var_103_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_15.prefab_name].transform, "story_v_out_101041", "101041025", "story_v_out_101041.awb")

						arg_100_1:RecordAudio("101041025", var_103_21)
						arg_100_1:RecordAudio("101041025", var_103_21)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_101041", "101041025", "story_v_out_101041.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_101041", "101041025", "story_v_out_101041.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_22 = math.max(var_103_13, arg_100_1.talkMaxDuration)

			if var_103_12 <= arg_100_1.time_ and arg_100_1.time_ < var_103_12 + var_103_22 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_12) / var_103_22

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_12 + var_103_22 and arg_100_1.time_ < var_103_12 + var_103_22 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play101041026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 101041026
		arg_104_1.duration_ = 2.47

		local var_104_0 = {
			ja = 2.466,
			ko = 2.1,
			zh = 2.266,
			en = 2.266
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play101041027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1019ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1019ui_story == nil then
				arg_104_1.var_.characterEffect1019ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.1

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1019ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1019ui_story then
				arg_104_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_107_4 = arg_104_1.actors_["1036ui_story"]
			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect1036ui_story == nil then
				arg_104_1.var_.characterEffect1036ui_story = var_107_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_6 = 0.1

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_6 and not isNil(var_107_4) then
				local var_107_7 = (arg_104_1.time_ - var_107_5) / var_107_6

				if arg_104_1.var_.characterEffect1036ui_story and not isNil(var_107_4) then
					local var_107_8 = Mathf.Lerp(0, 0.5, var_107_7)

					arg_104_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1036ui_story.fillRatio = var_107_8
				end
			end

			if arg_104_1.time_ >= var_107_5 + var_107_6 and arg_104_1.time_ < var_107_5 + var_107_6 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect1036ui_story then
				local var_107_9 = 0.5

				arg_104_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1036ui_story.fillRatio = var_107_9
			end

			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 then
				arg_104_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			local var_107_11 = 0

			if var_107_11 < arg_104_1.time_ and arg_104_1.time_ <= var_107_11 + arg_107_0 then
				arg_104_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_107_12 = 0
			local var_107_13 = 0.25

			if var_107_12 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_14 = arg_104_1:FormatText(StoryNameCfg[13].name)

				arg_104_1.leftNameTxt_.text = var_107_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_15 = arg_104_1:GetWordFromCfg(101041026)
				local var_107_16 = arg_104_1:FormatText(var_107_15.content)

				arg_104_1.text_.text = var_107_16

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_17 = 10
				local var_107_18 = utf8.len(var_107_16)
				local var_107_19 = var_107_17 <= 0 and var_107_13 or var_107_13 * (var_107_18 / var_107_17)

				if var_107_19 > 0 and var_107_13 < var_107_19 then
					arg_104_1.talkMaxDuration = var_107_19

					if var_107_19 + var_107_12 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_19 + var_107_12
					end
				end

				arg_104_1.text_.text = var_107_16
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041026", "story_v_out_101041.awb") ~= 0 then
					local var_107_20 = manager.audio:GetVoiceLength("story_v_out_101041", "101041026", "story_v_out_101041.awb") / 1000

					if var_107_20 + var_107_12 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_20 + var_107_12
					end

					if var_107_15.prefab_name ~= "" and arg_104_1.actors_[var_107_15.prefab_name] ~= nil then
						local var_107_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_15.prefab_name].transform, "story_v_out_101041", "101041026", "story_v_out_101041.awb")

						arg_104_1:RecordAudio("101041026", var_107_21)
						arg_104_1:RecordAudio("101041026", var_107_21)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_101041", "101041026", "story_v_out_101041.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_101041", "101041026", "story_v_out_101041.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_22 = math.max(var_107_13, arg_104_1.talkMaxDuration)

			if var_107_12 <= arg_104_1.time_ and arg_104_1.time_ < var_107_12 + var_107_22 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_12) / var_107_22

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_12 + var_107_22 and arg_104_1.time_ < var_107_12 + var_107_22 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play101041027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 101041027
		arg_108_1.duration_ = 3.53

		local var_108_0 = {
			ja = 3.533,
			ko = 3.2,
			zh = 3.266,
			en = 3.133
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
				arg_108_0:Play101041028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1019ui_story"]
			local var_111_1 = 2

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1019ui_story == nil then
				arg_108_1.var_.characterEffect1019ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.1

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1019ui_story and not isNil(var_111_0) then
					local var_111_4 = Mathf.Lerp(0, 0.5, var_111_3)

					arg_108_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1019ui_story.fillRatio = var_111_4
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1019ui_story then
				local var_111_5 = 0.5

				arg_108_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1019ui_story.fillRatio = var_111_5
			end

			local var_111_6 = arg_108_1.bgs_.A00
			local var_111_7 = 0

			if var_111_7 < arg_108_1.time_ and arg_108_1.time_ <= var_111_7 + arg_111_0 then
				local var_111_8 = var_111_6:GetComponent("SpriteRenderer")

				if var_111_8 then
					arg_108_1.var_.alphaOldValueA00 = var_111_8.color.a
					arg_108_1.var_.alphaMatValueA00 = var_111_8
				end

				arg_108_1.var_.alphaOldValueA00 = 1
			end

			local var_111_9 = 1.5

			if var_111_7 <= arg_108_1.time_ and arg_108_1.time_ < var_111_7 + var_111_9 then
				local var_111_10 = (arg_108_1.time_ - var_111_7) / var_111_9
				local var_111_11 = Mathf.Lerp(arg_108_1.var_.alphaOldValueA00, 0, var_111_10)

				if arg_108_1.var_.alphaMatValueA00 then
					local var_111_12 = arg_108_1.var_.alphaMatValueA00.color

					var_111_12.a = var_111_11
					arg_108_1.var_.alphaMatValueA00.color = var_111_12
				end
			end

			if arg_108_1.time_ >= var_111_7 + var_111_9 and arg_108_1.time_ < var_111_7 + var_111_9 + arg_111_0 and arg_108_1.var_.alphaMatValueA00 then
				local var_111_13 = arg_108_1.var_.alphaMatValueA00
				local var_111_14 = var_111_13.color

				var_111_14.a = 0
				var_111_13.color = var_111_14
			end

			local var_111_15 = arg_108_1.bgs_.A00.transform
			local var_111_16 = 1.5

			if var_111_16 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.var_.moveOldPosA00 = var_111_15.localPosition
			end

			local var_111_17 = 0.001

			if var_111_16 <= arg_108_1.time_ and arg_108_1.time_ < var_111_16 + var_111_17 then
				local var_111_18 = (arg_108_1.time_ - var_111_16) / var_111_17
				local var_111_19 = Vector3.New(0, -100, 10)

				var_111_15.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPosA00, var_111_19, var_111_18)
			end

			if arg_108_1.time_ >= var_111_16 + var_111_17 and arg_108_1.time_ < var_111_16 + var_111_17 + arg_111_0 then
				var_111_15.localPosition = Vector3.New(0, -100, 10)
			end

			local var_111_20 = "ST10"

			if arg_108_1.bgs_[var_111_20] == nil then
				local var_111_21 = Object.Instantiate(arg_108_1.paintGo_)

				var_111_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_111_20)
				var_111_21.name = var_111_20
				var_111_21.transform.parent = arg_108_1.stage_.transform
				var_111_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_108_1.bgs_[var_111_20] = var_111_21
			end

			local var_111_22 = arg_108_1.bgs_.ST10
			local var_111_23 = 1.5

			if var_111_23 < arg_108_1.time_ and arg_108_1.time_ <= var_111_23 + arg_111_0 then
				local var_111_24 = var_111_22:GetComponent("SpriteRenderer")

				if var_111_24 then
					arg_108_1.var_.alphaOldValueST10 = var_111_24.color.a
					arg_108_1.var_.alphaMatValueST10 = var_111_24
				end

				arg_108_1.var_.alphaOldValueST10 = 0
			end

			local var_111_25 = 1

			if var_111_23 <= arg_108_1.time_ and arg_108_1.time_ < var_111_23 + var_111_25 then
				local var_111_26 = (arg_108_1.time_ - var_111_23) / var_111_25
				local var_111_27 = Mathf.Lerp(arg_108_1.var_.alphaOldValueST10, 1, var_111_26)

				if arg_108_1.var_.alphaMatValueST10 then
					local var_111_28 = arg_108_1.var_.alphaMatValueST10.color

					var_111_28.a = var_111_27
					arg_108_1.var_.alphaMatValueST10.color = var_111_28
				end
			end

			if arg_108_1.time_ >= var_111_23 + var_111_25 and arg_108_1.time_ < var_111_23 + var_111_25 + arg_111_0 and arg_108_1.var_.alphaMatValueST10 then
				local var_111_29 = arg_108_1.var_.alphaMatValueST10
				local var_111_30 = var_111_29.color

				var_111_30.a = 1
				var_111_29.color = var_111_30
			end

			local var_111_31 = 1.5

			if var_111_31 < arg_108_1.time_ and arg_108_1.time_ <= var_111_31 + arg_111_0 then
				local var_111_32 = manager.ui.mainCamera.transform.localPosition
				local var_111_33 = Vector3.New(0, 0, 10) + Vector3.New(var_111_32.x, var_111_32.y, 0)
				local var_111_34 = arg_108_1.bgs_.ST10

				var_111_34.transform.localPosition = var_111_33
				var_111_34.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_111_35 = var_111_34:GetComponent("SpriteRenderer")

				if var_111_35 and var_111_35.sprite then
					local var_111_36 = (var_111_34.transform.localPosition - var_111_32).z
					local var_111_37 = manager.ui.mainCameraCom_
					local var_111_38 = 2 * var_111_36 * Mathf.Tan(var_111_37.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_111_39 = var_111_38 * var_111_37.aspect
					local var_111_40 = var_111_35.sprite.bounds.size.x
					local var_111_41 = var_111_35.sprite.bounds.size.y
					local var_111_42 = var_111_39 / var_111_40
					local var_111_43 = var_111_38 / var_111_41
					local var_111_44 = var_111_43 < var_111_42 and var_111_42 or var_111_43

					var_111_34.transform.localScale = Vector3.New(var_111_44, var_111_44, 0)
				end

				for iter_111_0, iter_111_1 in pairs(arg_108_1.bgs_) do
					if iter_111_0 ~= "ST10" then
						iter_111_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_111_45 = arg_108_1.actors_["1019ui_story"].transform
			local var_111_46 = 0

			if var_111_46 < arg_108_1.time_ and arg_108_1.time_ <= var_111_46 + arg_111_0 then
				arg_108_1.var_.moveOldPos1019ui_story = var_111_45.localPosition
			end

			local var_111_47 = 0.001

			if var_111_46 <= arg_108_1.time_ and arg_108_1.time_ < var_111_46 + var_111_47 then
				local var_111_48 = (arg_108_1.time_ - var_111_46) / var_111_47
				local var_111_49 = Vector3.New(0, 100, 0)

				var_111_45.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1019ui_story, var_111_49, var_111_48)

				local var_111_50 = manager.ui.mainCamera.transform.position - var_111_45.position

				var_111_45.forward = Vector3.New(var_111_50.x, var_111_50.y, var_111_50.z)

				local var_111_51 = var_111_45.localEulerAngles

				var_111_51.z = 0
				var_111_51.x = 0
				var_111_45.localEulerAngles = var_111_51
			end

			if arg_108_1.time_ >= var_111_46 + var_111_47 and arg_108_1.time_ < var_111_46 + var_111_47 + arg_111_0 then
				var_111_45.localPosition = Vector3.New(0, 100, 0)

				local var_111_52 = manager.ui.mainCamera.transform.position - var_111_45.position

				var_111_45.forward = Vector3.New(var_111_52.x, var_111_52.y, var_111_52.z)

				local var_111_53 = var_111_45.localEulerAngles

				var_111_53.z = 0
				var_111_53.x = 0
				var_111_45.localEulerAngles = var_111_53
			end

			local var_111_54 = arg_108_1.actors_["1036ui_story"].transform
			local var_111_55 = 0

			if var_111_55 < arg_108_1.time_ and arg_108_1.time_ <= var_111_55 + arg_111_0 then
				arg_108_1.var_.moveOldPos1036ui_story = var_111_54.localPosition
			end

			local var_111_56 = 0.001

			if var_111_55 <= arg_108_1.time_ and arg_108_1.time_ < var_111_55 + var_111_56 then
				local var_111_57 = (arg_108_1.time_ - var_111_55) / var_111_56
				local var_111_58 = Vector3.New(0, 100, 0)

				var_111_54.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1036ui_story, var_111_58, var_111_57)

				local var_111_59 = manager.ui.mainCamera.transform.position - var_111_54.position

				var_111_54.forward = Vector3.New(var_111_59.x, var_111_59.y, var_111_59.z)

				local var_111_60 = var_111_54.localEulerAngles

				var_111_60.z = 0
				var_111_60.x = 0
				var_111_54.localEulerAngles = var_111_60
			end

			if arg_108_1.time_ >= var_111_55 + var_111_56 and arg_108_1.time_ < var_111_55 + var_111_56 + arg_111_0 then
				var_111_54.localPosition = Vector3.New(0, 100, 0)

				local var_111_61 = manager.ui.mainCamera.transform.position - var_111_54.position

				var_111_54.forward = Vector3.New(var_111_61.x, var_111_61.y, var_111_61.z)

				local var_111_62 = var_111_54.localEulerAngles

				var_111_62.z = 0
				var_111_62.x = 0
				var_111_54.localEulerAngles = var_111_62
			end

			local var_111_63 = 0

			if var_111_63 < arg_108_1.time_ and arg_108_1.time_ <= var_111_63 + arg_111_0 then
				arg_108_1.allBtn_.enabled = false
			end

			local var_111_64 = 1.5

			if arg_108_1.time_ >= var_111_63 + var_111_64 and arg_108_1.time_ < var_111_63 + var_111_64 + arg_111_0 then
				arg_108_1.allBtn_.enabled = true
			end

			if arg_108_1.frameCnt_ <= 1 then
				arg_108_1.dialog_:SetActive(false)
			end

			local var_111_65 = 2
			local var_111_66 = 0.1

			if var_111_65 < arg_108_1.time_ and arg_108_1.time_ <= var_111_65 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0

				arg_108_1.dialog_:SetActive(true)

				arg_108_1.dialogCg_.alpha = 0

				local var_111_67 = LeanTween.value(arg_108_1.dialog_, 0, 1, 0.3)

				var_111_67:setOnUpdate(LuaHelper.FloatAction(function(arg_112_0)
					arg_108_1.dialogCg_.alpha = arg_112_0
				end))
				var_111_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_108_1.dialog_)
					var_111_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_108_1.duration_ = arg_108_1.duration_ + 0.3

				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_68 = arg_108_1:FormatText(StoryNameCfg[13].name)

				arg_108_1.leftNameTxt_.text = var_111_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_69 = arg_108_1:GetWordFromCfg(101041027)
				local var_111_70 = arg_108_1:FormatText(var_111_69.content)

				arg_108_1.text_.text = var_111_70

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_71 = 4
				local var_111_72 = utf8.len(var_111_70)
				local var_111_73 = var_111_71 <= 0 and var_111_66 or var_111_66 * (var_111_72 / var_111_71)

				if var_111_73 > 0 and var_111_66 < var_111_73 then
					arg_108_1.talkMaxDuration = var_111_73
					var_111_65 = var_111_65 + 0.3

					if var_111_73 + var_111_65 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_73 + var_111_65
					end
				end

				arg_108_1.text_.text = var_111_70
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041027", "story_v_out_101041.awb") ~= 0 then
					local var_111_74 = manager.audio:GetVoiceLength("story_v_out_101041", "101041027", "story_v_out_101041.awb") / 1000

					if var_111_74 + var_111_65 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_74 + var_111_65
					end

					if var_111_69.prefab_name ~= "" and arg_108_1.actors_[var_111_69.prefab_name] ~= nil then
						local var_111_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_69.prefab_name].transform, "story_v_out_101041", "101041027", "story_v_out_101041.awb")

						arg_108_1:RecordAudio("101041027", var_111_75)
						arg_108_1:RecordAudio("101041027", var_111_75)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_101041", "101041027", "story_v_out_101041.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_101041", "101041027", "story_v_out_101041.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_76 = var_111_65 + 0.3
			local var_111_77 = math.max(var_111_66, arg_108_1.talkMaxDuration)

			if var_111_76 <= arg_108_1.time_ and arg_108_1.time_ < var_111_76 + var_111_77 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_76) / var_111_77

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_76 + var_111_77 and arg_108_1.time_ < var_111_76 + var_111_77 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "A00",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play101041028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 101041028
		arg_114_1.duration_ = 12.83

		local var_114_0 = {
			ja = 12.833,
			ko = 10.733,
			zh = 9.6,
			en = 9.766
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
				arg_114_0:Play101041029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 1.2

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[32].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_3 = arg_114_1:GetWordFromCfg(101041028)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 48
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041028", "story_v_out_101041.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_101041", "101041028", "story_v_out_101041.awb") / 1000

					if var_117_8 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_0
					end

					if var_117_3.prefab_name ~= "" and arg_114_1.actors_[var_117_3.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_3.prefab_name].transform, "story_v_out_101041", "101041028", "story_v_out_101041.awb")

						arg_114_1:RecordAudio("101041028", var_117_9)
						arg_114_1:RecordAudio("101041028", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_101041", "101041028", "story_v_out_101041.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_101041", "101041028", "story_v_out_101041.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_10 and arg_114_1.time_ < var_117_0 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play101041029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 101041029
		arg_118_1.duration_ = 5.03

		local var_118_0 = {
			ja = 5.033,
			ko = 2.6,
			zh = 2.4,
			en = 4.2
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
				arg_118_0:Play101041030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.275

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_2 = arg_118_1:FormatText(StoryNameCfg[5].name)

				arg_118_1.leftNameTxt_.text = var_121_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:GetWordFromCfg(101041029)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 11
				local var_121_6 = utf8.len(var_121_4)
				local var_121_7 = var_121_5 <= 0 and var_121_1 or var_121_1 * (var_121_6 / var_121_5)

				if var_121_7 > 0 and var_121_1 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041029", "story_v_out_101041.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_101041", "101041029", "story_v_out_101041.awb") / 1000

					if var_121_8 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_0
					end

					if var_121_3.prefab_name ~= "" and arg_118_1.actors_[var_121_3.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_3.prefab_name].transform, "story_v_out_101041", "101041029", "story_v_out_101041.awb")

						arg_118_1:RecordAudio("101041029", var_121_9)
						arg_118_1:RecordAudio("101041029", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_101041", "101041029", "story_v_out_101041.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_101041", "101041029", "story_v_out_101041.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_10 and arg_118_1.time_ < var_121_0 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play101041030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 101041030
		arg_122_1.duration_ = 14.7

		local var_122_0 = {
			ja = 13.6,
			ko = 14.7,
			zh = 9.266,
			en = 9.8
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
				arg_122_0:Play101041031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 1.075

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_2 = arg_122_1:FormatText(StoryNameCfg[32].name)

				arg_122_1.leftNameTxt_.text = var_125_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:GetWordFromCfg(101041030)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 43
				local var_125_6 = utf8.len(var_125_4)
				local var_125_7 = var_125_5 <= 0 and var_125_1 or var_125_1 * (var_125_6 / var_125_5)

				if var_125_7 > 0 and var_125_1 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041030", "story_v_out_101041.awb") ~= 0 then
					local var_125_8 = manager.audio:GetVoiceLength("story_v_out_101041", "101041030", "story_v_out_101041.awb") / 1000

					if var_125_8 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_0
					end

					if var_125_3.prefab_name ~= "" and arg_122_1.actors_[var_125_3.prefab_name] ~= nil then
						local var_125_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_3.prefab_name].transform, "story_v_out_101041", "101041030", "story_v_out_101041.awb")

						arg_122_1:RecordAudio("101041030", var_125_9)
						arg_122_1:RecordAudio("101041030", var_125_9)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_101041", "101041030", "story_v_out_101041.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_101041", "101041030", "story_v_out_101041.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_10 and arg_122_1.time_ < var_125_0 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play101041031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 101041031
		arg_126_1.duration_ = 5.17

		local var_126_0 = {
			ja = 5.066,
			ko = 2.7,
			zh = 4.233,
			en = 5.166
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
				arg_126_0:Play101041032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1019ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1019ui_story == nil then
				arg_126_1.var_.characterEffect1019ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.1

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1019ui_story and not isNil(var_129_0) then
					arg_126_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1019ui_story then
				arg_126_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_129_4 = arg_126_1.actors_["1019ui_story"].transform
			local var_129_5 = 0

			if var_129_5 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 then
				arg_126_1.var_.moveOldPos1019ui_story = var_129_4.localPosition
			end

			local var_129_6 = 0.001

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_6 then
				local var_129_7 = (arg_126_1.time_ - var_129_5) / var_129_6
				local var_129_8 = Vector3.New(-0.7, -1.08, -5.9)

				var_129_4.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1019ui_story, var_129_8, var_129_7)

				local var_129_9 = manager.ui.mainCamera.transform.position - var_129_4.position

				var_129_4.forward = Vector3.New(var_129_9.x, var_129_9.y, var_129_9.z)

				local var_129_10 = var_129_4.localEulerAngles

				var_129_10.z = 0
				var_129_10.x = 0
				var_129_4.localEulerAngles = var_129_10
			end

			if arg_126_1.time_ >= var_129_5 + var_129_6 and arg_126_1.time_ < var_129_5 + var_129_6 + arg_129_0 then
				var_129_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_129_11 = manager.ui.mainCamera.transform.position - var_129_4.position

				var_129_4.forward = Vector3.New(var_129_11.x, var_129_11.y, var_129_11.z)

				local var_129_12 = var_129_4.localEulerAngles

				var_129_12.z = 0
				var_129_12.x = 0
				var_129_4.localEulerAngles = var_129_12
			end

			local var_129_13 = 0

			if var_129_13 < arg_126_1.time_ and arg_126_1.time_ <= var_129_13 + arg_129_0 then
				arg_126_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_129_14 = 0

			if var_129_14 < arg_126_1.time_ and arg_126_1.time_ <= var_129_14 + arg_129_0 then
				arg_126_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_129_15 = 0
			local var_129_16 = 0.45

			if var_129_15 < arg_126_1.time_ and arg_126_1.time_ <= var_129_15 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_17 = arg_126_1:FormatText(StoryNameCfg[13].name)

				arg_126_1.leftNameTxt_.text = var_129_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_18 = arg_126_1:GetWordFromCfg(101041031)
				local var_129_19 = arg_126_1:FormatText(var_129_18.content)

				arg_126_1.text_.text = var_129_19

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_20 = 18
				local var_129_21 = utf8.len(var_129_19)
				local var_129_22 = var_129_20 <= 0 and var_129_16 or var_129_16 * (var_129_21 / var_129_20)

				if var_129_22 > 0 and var_129_16 < var_129_22 then
					arg_126_1.talkMaxDuration = var_129_22

					if var_129_22 + var_129_15 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_22 + var_129_15
					end
				end

				arg_126_1.text_.text = var_129_19
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041031", "story_v_out_101041.awb") ~= 0 then
					local var_129_23 = manager.audio:GetVoiceLength("story_v_out_101041", "101041031", "story_v_out_101041.awb") / 1000

					if var_129_23 + var_129_15 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_23 + var_129_15
					end

					if var_129_18.prefab_name ~= "" and arg_126_1.actors_[var_129_18.prefab_name] ~= nil then
						local var_129_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_18.prefab_name].transform, "story_v_out_101041", "101041031", "story_v_out_101041.awb")

						arg_126_1:RecordAudio("101041031", var_129_24)
						arg_126_1:RecordAudio("101041031", var_129_24)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_101041", "101041031", "story_v_out_101041.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_101041", "101041031", "story_v_out_101041.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_25 = math.max(var_129_16, arg_126_1.talkMaxDuration)

			if var_129_15 <= arg_126_1.time_ and arg_126_1.time_ < var_129_15 + var_129_25 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_15) / var_129_25

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_15 + var_129_25 and arg_126_1.time_ < var_129_15 + var_129_25 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play101041032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 101041032
		arg_130_1.duration_ = 4.77

		local var_130_0 = {
			ja = 2.8,
			ko = 4.766,
			zh = 3.4,
			en = 4.366
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
				arg_130_0:Play101041033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = "1066ui_story"

			if arg_130_1.actors_[var_133_0] == nil then
				local var_133_1 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_133_1) then
					local var_133_2 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_130_1.stage_.transform)

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

			local var_133_5 = arg_130_1.actors_["1066ui_story"]
			local var_133_6 = 0

			if var_133_6 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 and not isNil(var_133_5) and arg_130_1.var_.characterEffect1066ui_story == nil then
				arg_130_1.var_.characterEffect1066ui_story = var_133_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_7 = 0.1

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_7 and not isNil(var_133_5) then
				local var_133_8 = (arg_130_1.time_ - var_133_6) / var_133_7

				if arg_130_1.var_.characterEffect1066ui_story and not isNil(var_133_5) then
					arg_130_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_6 + var_133_7 and arg_130_1.time_ < var_133_6 + var_133_7 + arg_133_0 and not isNil(var_133_5) and arg_130_1.var_.characterEffect1066ui_story then
				arg_130_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_133_9 = arg_130_1.actors_["1019ui_story"]
			local var_133_10 = 0

			if var_133_10 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 and not isNil(var_133_9) and arg_130_1.var_.characterEffect1019ui_story == nil then
				arg_130_1.var_.characterEffect1019ui_story = var_133_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_11 = 0.1

			if var_133_10 <= arg_130_1.time_ and arg_130_1.time_ < var_133_10 + var_133_11 and not isNil(var_133_9) then
				local var_133_12 = (arg_130_1.time_ - var_133_10) / var_133_11

				if arg_130_1.var_.characterEffect1019ui_story and not isNil(var_133_9) then
					local var_133_13 = Mathf.Lerp(0, 0.5, var_133_12)

					arg_130_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1019ui_story.fillRatio = var_133_13
				end
			end

			if arg_130_1.time_ >= var_133_10 + var_133_11 and arg_130_1.time_ < var_133_10 + var_133_11 + arg_133_0 and not isNil(var_133_9) and arg_130_1.var_.characterEffect1019ui_story then
				local var_133_14 = 0.5

				arg_130_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1019ui_story.fillRatio = var_133_14
			end

			local var_133_15 = arg_130_1.actors_["1066ui_story"].transform
			local var_133_16 = 0

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1.var_.moveOldPos1066ui_story = var_133_15.localPosition
			end

			local var_133_17 = 0.001

			if var_133_16 <= arg_130_1.time_ and arg_130_1.time_ < var_133_16 + var_133_17 then
				local var_133_18 = (arg_130_1.time_ - var_133_16) / var_133_17
				local var_133_19 = Vector3.New(0.7, -0.77, -6.1)

				var_133_15.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1066ui_story, var_133_19, var_133_18)

				local var_133_20 = manager.ui.mainCamera.transform.position - var_133_15.position

				var_133_15.forward = Vector3.New(var_133_20.x, var_133_20.y, var_133_20.z)

				local var_133_21 = var_133_15.localEulerAngles

				var_133_21.z = 0
				var_133_21.x = 0
				var_133_15.localEulerAngles = var_133_21
			end

			if arg_130_1.time_ >= var_133_16 + var_133_17 and arg_130_1.time_ < var_133_16 + var_133_17 + arg_133_0 then
				var_133_15.localPosition = Vector3.New(0.7, -0.77, -6.1)

				local var_133_22 = manager.ui.mainCamera.transform.position - var_133_15.position

				var_133_15.forward = Vector3.New(var_133_22.x, var_133_22.y, var_133_22.z)

				local var_133_23 = var_133_15.localEulerAngles

				var_133_23.z = 0
				var_133_23.x = 0
				var_133_15.localEulerAngles = var_133_23
			end

			local var_133_24 = 0

			if var_133_24 < arg_130_1.time_ and arg_130_1.time_ <= var_133_24 + arg_133_0 then
				arg_130_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			local var_133_25 = 0

			if var_133_25 < arg_130_1.time_ and arg_130_1.time_ <= var_133_25 + arg_133_0 then
				arg_130_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_133_26 = 0
			local var_133_27 = 0.375

			if var_133_26 < arg_130_1.time_ and arg_130_1.time_ <= var_133_26 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_28 = arg_130_1:FormatText(StoryNameCfg[32].name)

				arg_130_1.leftNameTxt_.text = var_133_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_29 = arg_130_1:GetWordFromCfg(101041032)
				local var_133_30 = arg_130_1:FormatText(var_133_29.content)

				arg_130_1.text_.text = var_133_30

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_31 = 15
				local var_133_32 = utf8.len(var_133_30)
				local var_133_33 = var_133_31 <= 0 and var_133_27 or var_133_27 * (var_133_32 / var_133_31)

				if var_133_33 > 0 and var_133_27 < var_133_33 then
					arg_130_1.talkMaxDuration = var_133_33

					if var_133_33 + var_133_26 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_33 + var_133_26
					end
				end

				arg_130_1.text_.text = var_133_30
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041032", "story_v_out_101041.awb") ~= 0 then
					local var_133_34 = manager.audio:GetVoiceLength("story_v_out_101041", "101041032", "story_v_out_101041.awb") / 1000

					if var_133_34 + var_133_26 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_34 + var_133_26
					end

					if var_133_29.prefab_name ~= "" and arg_130_1.actors_[var_133_29.prefab_name] ~= nil then
						local var_133_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_29.prefab_name].transform, "story_v_out_101041", "101041032", "story_v_out_101041.awb")

						arg_130_1:RecordAudio("101041032", var_133_35)
						arg_130_1:RecordAudio("101041032", var_133_35)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_101041", "101041032", "story_v_out_101041.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_101041", "101041032", "story_v_out_101041.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_36 = math.max(var_133_27, arg_130_1.talkMaxDuration)

			if var_133_26 <= arg_130_1.time_ and arg_130_1.time_ < var_133_26 + var_133_36 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_26) / var_133_36

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_26 + var_133_36 and arg_130_1.time_ < var_133_26 + var_133_36 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play101041033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 101041033
		arg_134_1.duration_ = 3.4

		local var_134_0 = {
			ja = 1.999999999999,
			ko = 3.2,
			zh = 3.4,
			en = 2.466
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
				arg_134_0:Play101041034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1036ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1036ui_story == nil then
				arg_134_1.var_.characterEffect1036ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.1

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1036ui_story and not isNil(var_137_0) then
					arg_134_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1036ui_story then
				arg_134_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_137_4 = arg_134_1.actors_["1066ui_story"]
			local var_137_5 = 0

			if var_137_5 < arg_134_1.time_ and arg_134_1.time_ <= var_137_5 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect1066ui_story == nil then
				arg_134_1.var_.characterEffect1066ui_story = var_137_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_6 = 0.1

			if var_137_5 <= arg_134_1.time_ and arg_134_1.time_ < var_137_5 + var_137_6 and not isNil(var_137_4) then
				local var_137_7 = (arg_134_1.time_ - var_137_5) / var_137_6

				if arg_134_1.var_.characterEffect1066ui_story and not isNil(var_137_4) then
					local var_137_8 = Mathf.Lerp(0, 0.5, var_137_7)

					arg_134_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1066ui_story.fillRatio = var_137_8
				end
			end

			if arg_134_1.time_ >= var_137_5 + var_137_6 and arg_134_1.time_ < var_137_5 + var_137_6 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect1066ui_story then
				local var_137_9 = 0.5

				arg_134_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1066ui_story.fillRatio = var_137_9
			end

			local var_137_10 = arg_134_1.actors_["1019ui_story"].transform
			local var_137_11 = 0

			if var_137_11 < arg_134_1.time_ and arg_134_1.time_ <= var_137_11 + arg_137_0 then
				arg_134_1.var_.moveOldPos1019ui_story = var_137_10.localPosition
			end

			local var_137_12 = 0.001

			if var_137_11 <= arg_134_1.time_ and arg_134_1.time_ < var_137_11 + var_137_12 then
				local var_137_13 = (arg_134_1.time_ - var_137_11) / var_137_12
				local var_137_14 = Vector3.New(0, 100, 0)

				var_137_10.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1019ui_story, var_137_14, var_137_13)

				local var_137_15 = manager.ui.mainCamera.transform.position - var_137_10.position

				var_137_10.forward = Vector3.New(var_137_15.x, var_137_15.y, var_137_15.z)

				local var_137_16 = var_137_10.localEulerAngles

				var_137_16.z = 0
				var_137_16.x = 0
				var_137_10.localEulerAngles = var_137_16
			end

			if arg_134_1.time_ >= var_137_11 + var_137_12 and arg_134_1.time_ < var_137_11 + var_137_12 + arg_137_0 then
				var_137_10.localPosition = Vector3.New(0, 100, 0)

				local var_137_17 = manager.ui.mainCamera.transform.position - var_137_10.position

				var_137_10.forward = Vector3.New(var_137_17.x, var_137_17.y, var_137_17.z)

				local var_137_18 = var_137_10.localEulerAngles

				var_137_18.z = 0
				var_137_18.x = 0
				var_137_10.localEulerAngles = var_137_18
			end

			local var_137_19 = arg_134_1.actors_["1036ui_story"].transform
			local var_137_20 = 0

			if var_137_20 < arg_134_1.time_ and arg_134_1.time_ <= var_137_20 + arg_137_0 then
				arg_134_1.var_.moveOldPos1036ui_story = var_137_19.localPosition
			end

			local var_137_21 = 0.001

			if var_137_20 <= arg_134_1.time_ and arg_134_1.time_ < var_137_20 + var_137_21 then
				local var_137_22 = (arg_134_1.time_ - var_137_20) / var_137_21
				local var_137_23 = Vector3.New(-0.7, -1.09, -5.78)

				var_137_19.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1036ui_story, var_137_23, var_137_22)

				local var_137_24 = manager.ui.mainCamera.transform.position - var_137_19.position

				var_137_19.forward = Vector3.New(var_137_24.x, var_137_24.y, var_137_24.z)

				local var_137_25 = var_137_19.localEulerAngles

				var_137_25.z = 0
				var_137_25.x = 0
				var_137_19.localEulerAngles = var_137_25
			end

			if arg_134_1.time_ >= var_137_20 + var_137_21 and arg_134_1.time_ < var_137_20 + var_137_21 + arg_137_0 then
				var_137_19.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_137_26 = manager.ui.mainCamera.transform.position - var_137_19.position

				var_137_19.forward = Vector3.New(var_137_26.x, var_137_26.y, var_137_26.z)

				local var_137_27 = var_137_19.localEulerAngles

				var_137_27.z = 0
				var_137_27.x = 0
				var_137_19.localEulerAngles = var_137_27
			end

			local var_137_28 = 0

			if var_137_28 < arg_134_1.time_ and arg_134_1.time_ <= var_137_28 + arg_137_0 then
				arg_134_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			local var_137_29 = 0

			if var_137_29 < arg_134_1.time_ and arg_134_1.time_ <= var_137_29 + arg_137_0 then
				arg_134_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_137_30 = 0
			local var_137_31 = 0.275

			if var_137_30 < arg_134_1.time_ and arg_134_1.time_ <= var_137_30 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_32 = arg_134_1:FormatText(StoryNameCfg[5].name)

				arg_134_1.leftNameTxt_.text = var_137_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_33 = arg_134_1:GetWordFromCfg(101041033)
				local var_137_34 = arg_134_1:FormatText(var_137_33.content)

				arg_134_1.text_.text = var_137_34

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_35 = 11
				local var_137_36 = utf8.len(var_137_34)
				local var_137_37 = var_137_35 <= 0 and var_137_31 or var_137_31 * (var_137_36 / var_137_35)

				if var_137_37 > 0 and var_137_31 < var_137_37 then
					arg_134_1.talkMaxDuration = var_137_37

					if var_137_37 + var_137_30 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_37 + var_137_30
					end
				end

				arg_134_1.text_.text = var_137_34
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041033", "story_v_out_101041.awb") ~= 0 then
					local var_137_38 = manager.audio:GetVoiceLength("story_v_out_101041", "101041033", "story_v_out_101041.awb") / 1000

					if var_137_38 + var_137_30 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_38 + var_137_30
					end

					if var_137_33.prefab_name ~= "" and arg_134_1.actors_[var_137_33.prefab_name] ~= nil then
						local var_137_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_33.prefab_name].transform, "story_v_out_101041", "101041033", "story_v_out_101041.awb")

						arg_134_1:RecordAudio("101041033", var_137_39)
						arg_134_1:RecordAudio("101041033", var_137_39)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_101041", "101041033", "story_v_out_101041.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_101041", "101041033", "story_v_out_101041.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_40 = math.max(var_137_31, arg_134_1.talkMaxDuration)

			if var_137_30 <= arg_134_1.time_ and arg_134_1.time_ < var_137_30 + var_137_40 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_30) / var_137_40

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_30 + var_137_40 and arg_134_1.time_ < var_137_30 + var_137_40 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play101041034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 101041034
		arg_138_1.duration_ = 3.5

		local var_138_0 = {
			ja = 3.2,
			ko = 3.266,
			zh = 3.5,
			en = 2.8
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
				arg_138_0:Play101041035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1066ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1066ui_story == nil then
				arg_138_1.var_.characterEffect1066ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.1

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1066ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1066ui_story then
				arg_138_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_141_4 = arg_138_1.actors_["1036ui_story"]
			local var_141_5 = 0

			if var_141_5 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect1036ui_story == nil then
				arg_138_1.var_.characterEffect1036ui_story = var_141_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_6 = 0.1

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_6 and not isNil(var_141_4) then
				local var_141_7 = (arg_138_1.time_ - var_141_5) / var_141_6

				if arg_138_1.var_.characterEffect1036ui_story and not isNil(var_141_4) then
					local var_141_8 = Mathf.Lerp(0, 0.5, var_141_7)

					arg_138_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1036ui_story.fillRatio = var_141_8
				end
			end

			if arg_138_1.time_ >= var_141_5 + var_141_6 and arg_138_1.time_ < var_141_5 + var_141_6 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect1036ui_story then
				local var_141_9 = 0.5

				arg_138_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1036ui_story.fillRatio = var_141_9
			end

			local var_141_10 = 0

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 then
				arg_138_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action443")
			end

			local var_141_11 = 0

			if var_141_11 < arg_138_1.time_ and arg_138_1.time_ <= var_141_11 + arg_141_0 then
				arg_138_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_141_12 = 0
			local var_141_13 = 0.4

			if var_141_12 < arg_138_1.time_ and arg_138_1.time_ <= var_141_12 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_14 = arg_138_1:FormatText(StoryNameCfg[32].name)

				arg_138_1.leftNameTxt_.text = var_141_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_15 = arg_138_1:GetWordFromCfg(101041034)
				local var_141_16 = arg_138_1:FormatText(var_141_15.content)

				arg_138_1.text_.text = var_141_16

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_17 = 16
				local var_141_18 = utf8.len(var_141_16)
				local var_141_19 = var_141_17 <= 0 and var_141_13 or var_141_13 * (var_141_18 / var_141_17)

				if var_141_19 > 0 and var_141_13 < var_141_19 then
					arg_138_1.talkMaxDuration = var_141_19

					if var_141_19 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_19 + var_141_12
					end
				end

				arg_138_1.text_.text = var_141_16
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041034", "story_v_out_101041.awb") ~= 0 then
					local var_141_20 = manager.audio:GetVoiceLength("story_v_out_101041", "101041034", "story_v_out_101041.awb") / 1000

					if var_141_20 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_20 + var_141_12
					end

					if var_141_15.prefab_name ~= "" and arg_138_1.actors_[var_141_15.prefab_name] ~= nil then
						local var_141_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_15.prefab_name].transform, "story_v_out_101041", "101041034", "story_v_out_101041.awb")

						arg_138_1:RecordAudio("101041034", var_141_21)
						arg_138_1:RecordAudio("101041034", var_141_21)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_101041", "101041034", "story_v_out_101041.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_101041", "101041034", "story_v_out_101041.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_22 = math.max(var_141_13, arg_138_1.talkMaxDuration)

			if var_141_12 <= arg_138_1.time_ and arg_138_1.time_ < var_141_12 + var_141_22 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_12) / var_141_22

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_12 + var_141_22 and arg_138_1.time_ < var_141_12 + var_141_22 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play101041035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 101041035
		arg_142_1.duration_ = 4.57

		local var_142_0 = {
			ja = 2.866,
			ko = 3.566,
			zh = 4.566,
			en = 3.3
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
				arg_142_0:Play101041036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1036ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1036ui_story == nil then
				arg_142_1.var_.characterEffect1036ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.1

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1036ui_story and not isNil(var_145_0) then
					arg_142_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1036ui_story then
				arg_142_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_145_4 = arg_142_1.actors_["1066ui_story"]
			local var_145_5 = 0

			if var_145_5 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 and not isNil(var_145_4) and arg_142_1.var_.characterEffect1066ui_story == nil then
				arg_142_1.var_.characterEffect1066ui_story = var_145_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_6 = 0.1

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_6 and not isNil(var_145_4) then
				local var_145_7 = (arg_142_1.time_ - var_145_5) / var_145_6

				if arg_142_1.var_.characterEffect1066ui_story and not isNil(var_145_4) then
					local var_145_8 = Mathf.Lerp(0, 0.5, var_145_7)

					arg_142_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1066ui_story.fillRatio = var_145_8
				end
			end

			if arg_142_1.time_ >= var_145_5 + var_145_6 and arg_142_1.time_ < var_145_5 + var_145_6 + arg_145_0 and not isNil(var_145_4) and arg_142_1.var_.characterEffect1066ui_story then
				local var_145_9 = 0.5

				arg_142_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1066ui_story.fillRatio = var_145_9
			end

			local var_145_10 = 0

			if var_145_10 < arg_142_1.time_ and arg_142_1.time_ <= var_145_10 + arg_145_0 then
				arg_142_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action446")
			end

			local var_145_11 = 0

			if var_145_11 < arg_142_1.time_ and arg_142_1.time_ <= var_145_11 + arg_145_0 then
				arg_142_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_145_12 = 0

			if var_145_12 < arg_142_1.time_ and arg_142_1.time_ <= var_145_12 + arg_145_0 then
				arg_142_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_145_13 = 0
			local var_145_14 = 0.3

			if var_145_13 < arg_142_1.time_ and arg_142_1.time_ <= var_145_13 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_15 = arg_142_1:FormatText(StoryNameCfg[5].name)

				arg_142_1.leftNameTxt_.text = var_145_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_16 = arg_142_1:GetWordFromCfg(101041035)
				local var_145_17 = arg_142_1:FormatText(var_145_16.content)

				arg_142_1.text_.text = var_145_17

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_18 = 12
				local var_145_19 = utf8.len(var_145_17)
				local var_145_20 = var_145_18 <= 0 and var_145_14 or var_145_14 * (var_145_19 / var_145_18)

				if var_145_20 > 0 and var_145_14 < var_145_20 then
					arg_142_1.talkMaxDuration = var_145_20

					if var_145_20 + var_145_13 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_20 + var_145_13
					end
				end

				arg_142_1.text_.text = var_145_17
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041035", "story_v_out_101041.awb") ~= 0 then
					local var_145_21 = manager.audio:GetVoiceLength("story_v_out_101041", "101041035", "story_v_out_101041.awb") / 1000

					if var_145_21 + var_145_13 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_21 + var_145_13
					end

					if var_145_16.prefab_name ~= "" and arg_142_1.actors_[var_145_16.prefab_name] ~= nil then
						local var_145_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_16.prefab_name].transform, "story_v_out_101041", "101041035", "story_v_out_101041.awb")

						arg_142_1:RecordAudio("101041035", var_145_22)
						arg_142_1:RecordAudio("101041035", var_145_22)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_101041", "101041035", "story_v_out_101041.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_101041", "101041035", "story_v_out_101041.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_23 = math.max(var_145_14, arg_142_1.talkMaxDuration)

			if var_145_13 <= arg_142_1.time_ and arg_142_1.time_ < var_145_13 + var_145_23 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_13) / var_145_23

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_13 + var_145_23 and arg_142_1.time_ < var_145_13 + var_145_23 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play101041036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 101041036
		arg_146_1.duration_ = 13.4

		local var_146_0 = {
			ja = 13.4,
			ko = 7.8,
			zh = 9.5,
			en = 7.033
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
				arg_146_0:Play101041037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1019ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1019ui_story == nil then
				arg_146_1.var_.characterEffect1019ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.1

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1019ui_story and not isNil(var_149_0) then
					arg_146_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1019ui_story then
				arg_146_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_149_4 = arg_146_1.actors_["1036ui_story"]
			local var_149_5 = 0

			if var_149_5 < arg_146_1.time_ and arg_146_1.time_ <= var_149_5 + arg_149_0 and not isNil(var_149_4) and arg_146_1.var_.characterEffect1036ui_story == nil then
				arg_146_1.var_.characterEffect1036ui_story = var_149_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_6 = 0.1

			if var_149_5 <= arg_146_1.time_ and arg_146_1.time_ < var_149_5 + var_149_6 and not isNil(var_149_4) then
				local var_149_7 = (arg_146_1.time_ - var_149_5) / var_149_6

				if arg_146_1.var_.characterEffect1036ui_story and not isNil(var_149_4) then
					local var_149_8 = Mathf.Lerp(0, 0.5, var_149_7)

					arg_146_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1036ui_story.fillRatio = var_149_8
				end
			end

			if arg_146_1.time_ >= var_149_5 + var_149_6 and arg_146_1.time_ < var_149_5 + var_149_6 + arg_149_0 and not isNil(var_149_4) and arg_146_1.var_.characterEffect1036ui_story then
				local var_149_9 = 0.5

				arg_146_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1036ui_story.fillRatio = var_149_9
			end

			local var_149_10 = arg_146_1.actors_["1036ui_story"].transform
			local var_149_11 = 0

			if var_149_11 < arg_146_1.time_ and arg_146_1.time_ <= var_149_11 + arg_149_0 then
				arg_146_1.var_.moveOldPos1036ui_story = var_149_10.localPosition
			end

			local var_149_12 = 0.001

			if var_149_11 <= arg_146_1.time_ and arg_146_1.time_ < var_149_11 + var_149_12 then
				local var_149_13 = (arg_146_1.time_ - var_149_11) / var_149_12
				local var_149_14 = Vector3.New(0, 100, 0)

				var_149_10.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1036ui_story, var_149_14, var_149_13)

				local var_149_15 = manager.ui.mainCamera.transform.position - var_149_10.position

				var_149_10.forward = Vector3.New(var_149_15.x, var_149_15.y, var_149_15.z)

				local var_149_16 = var_149_10.localEulerAngles

				var_149_16.z = 0
				var_149_16.x = 0
				var_149_10.localEulerAngles = var_149_16
			end

			if arg_146_1.time_ >= var_149_11 + var_149_12 and arg_146_1.time_ < var_149_11 + var_149_12 + arg_149_0 then
				var_149_10.localPosition = Vector3.New(0, 100, 0)

				local var_149_17 = manager.ui.mainCamera.transform.position - var_149_10.position

				var_149_10.forward = Vector3.New(var_149_17.x, var_149_17.y, var_149_17.z)

				local var_149_18 = var_149_10.localEulerAngles

				var_149_18.z = 0
				var_149_18.x = 0
				var_149_10.localEulerAngles = var_149_18
			end

			local var_149_19 = arg_146_1.actors_["1019ui_story"].transform
			local var_149_20 = 0

			if var_149_20 < arg_146_1.time_ and arg_146_1.time_ <= var_149_20 + arg_149_0 then
				arg_146_1.var_.moveOldPos1019ui_story = var_149_19.localPosition
			end

			local var_149_21 = 0.001

			if var_149_20 <= arg_146_1.time_ and arg_146_1.time_ < var_149_20 + var_149_21 then
				local var_149_22 = (arg_146_1.time_ - var_149_20) / var_149_21
				local var_149_23 = Vector3.New(-0.7, -1.08, -5.9)

				var_149_19.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1019ui_story, var_149_23, var_149_22)

				local var_149_24 = manager.ui.mainCamera.transform.position - var_149_19.position

				var_149_19.forward = Vector3.New(var_149_24.x, var_149_24.y, var_149_24.z)

				local var_149_25 = var_149_19.localEulerAngles

				var_149_25.z = 0
				var_149_25.x = 0
				var_149_19.localEulerAngles = var_149_25
			end

			if arg_146_1.time_ >= var_149_20 + var_149_21 and arg_146_1.time_ < var_149_20 + var_149_21 + arg_149_0 then
				var_149_19.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_149_26 = manager.ui.mainCamera.transform.position - var_149_19.position

				var_149_19.forward = Vector3.New(var_149_26.x, var_149_26.y, var_149_26.z)

				local var_149_27 = var_149_19.localEulerAngles

				var_149_27.z = 0
				var_149_27.x = 0
				var_149_19.localEulerAngles = var_149_27
			end

			local var_149_28 = 0

			if var_149_28 < arg_146_1.time_ and arg_146_1.time_ <= var_149_28 + arg_149_0 then
				arg_146_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_149_29 = 0
			local var_149_30 = 0.95

			if var_149_29 < arg_146_1.time_ and arg_146_1.time_ <= var_149_29 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_31 = arg_146_1:FormatText(StoryNameCfg[13].name)

				arg_146_1.leftNameTxt_.text = var_149_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_32 = arg_146_1:GetWordFromCfg(101041036)
				local var_149_33 = arg_146_1:FormatText(var_149_32.content)

				arg_146_1.text_.text = var_149_33

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_34 = 38
				local var_149_35 = utf8.len(var_149_33)
				local var_149_36 = var_149_34 <= 0 and var_149_30 or var_149_30 * (var_149_35 / var_149_34)

				if var_149_36 > 0 and var_149_30 < var_149_36 then
					arg_146_1.talkMaxDuration = var_149_36

					if var_149_36 + var_149_29 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_36 + var_149_29
					end
				end

				arg_146_1.text_.text = var_149_33
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041036", "story_v_out_101041.awb") ~= 0 then
					local var_149_37 = manager.audio:GetVoiceLength("story_v_out_101041", "101041036", "story_v_out_101041.awb") / 1000

					if var_149_37 + var_149_29 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_37 + var_149_29
					end

					if var_149_32.prefab_name ~= "" and arg_146_1.actors_[var_149_32.prefab_name] ~= nil then
						local var_149_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_32.prefab_name].transform, "story_v_out_101041", "101041036", "story_v_out_101041.awb")

						arg_146_1:RecordAudio("101041036", var_149_38)
						arg_146_1:RecordAudio("101041036", var_149_38)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_101041", "101041036", "story_v_out_101041.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_101041", "101041036", "story_v_out_101041.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_39 = math.max(var_149_30, arg_146_1.talkMaxDuration)

			if var_149_29 <= arg_146_1.time_ and arg_146_1.time_ < var_149_29 + var_149_39 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_29) / var_149_39

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_29 + var_149_39 and arg_146_1.time_ < var_149_29 + var_149_39 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play101041037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 101041037
		arg_150_1.duration_ = 1.57

		local var_150_0 = {
			ja = 1.3,
			ko = 0.999999999999,
			zh = 1.066,
			en = 1.566
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
				arg_150_0:Play101041038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1066ui_story"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1066ui_story == nil then
				arg_150_1.var_.characterEffect1066ui_story = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.1

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect1066ui_story and not isNil(var_153_0) then
					arg_150_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1066ui_story then
				arg_150_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_153_4 = arg_150_1.actors_["1019ui_story"]
			local var_153_5 = 0

			if var_153_5 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect1019ui_story == nil then
				arg_150_1.var_.characterEffect1019ui_story = var_153_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_6 = 0.1

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_6 and not isNil(var_153_4) then
				local var_153_7 = (arg_150_1.time_ - var_153_5) / var_153_6

				if arg_150_1.var_.characterEffect1019ui_story and not isNil(var_153_4) then
					local var_153_8 = Mathf.Lerp(0, 0.5, var_153_7)

					arg_150_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1019ui_story.fillRatio = var_153_8
				end
			end

			if arg_150_1.time_ >= var_153_5 + var_153_6 and arg_150_1.time_ < var_153_5 + var_153_6 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect1019ui_story then
				local var_153_9 = 0.5

				arg_150_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1019ui_story.fillRatio = var_153_9
			end

			local var_153_10 = 0

			if var_153_10 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 then
				arg_150_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_153_11 = 0
			local var_153_12 = 0.075

			if var_153_11 < arg_150_1.time_ and arg_150_1.time_ <= var_153_11 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_13 = arg_150_1:FormatText(StoryNameCfg[32].name)

				arg_150_1.leftNameTxt_.text = var_153_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_14 = arg_150_1:GetWordFromCfg(101041037)
				local var_153_15 = arg_150_1:FormatText(var_153_14.content)

				arg_150_1.text_.text = var_153_15

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_16 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041037", "story_v_out_101041.awb") ~= 0 then
					local var_153_19 = manager.audio:GetVoiceLength("story_v_out_101041", "101041037", "story_v_out_101041.awb") / 1000

					if var_153_19 + var_153_11 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_19 + var_153_11
					end

					if var_153_14.prefab_name ~= "" and arg_150_1.actors_[var_153_14.prefab_name] ~= nil then
						local var_153_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_14.prefab_name].transform, "story_v_out_101041", "101041037", "story_v_out_101041.awb")

						arg_150_1:RecordAudio("101041037", var_153_20)
						arg_150_1:RecordAudio("101041037", var_153_20)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_101041", "101041037", "story_v_out_101041.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_101041", "101041037", "story_v_out_101041.awb")
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
	Play101041038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 101041038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play101041039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1019ui_story"].transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPos1019ui_story = var_157_0.localPosition
			end

			local var_157_2 = 0.001

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2
				local var_157_4 = Vector3.New(0, 100, 0)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1019ui_story, var_157_4, var_157_3)

				local var_157_5 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_5.x, var_157_5.y, var_157_5.z)

				local var_157_6 = var_157_0.localEulerAngles

				var_157_6.z = 0
				var_157_6.x = 0
				var_157_0.localEulerAngles = var_157_6
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(0, 100, 0)

				local var_157_7 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_7.x, var_157_7.y, var_157_7.z)

				local var_157_8 = var_157_0.localEulerAngles

				var_157_8.z = 0
				var_157_8.x = 0
				var_157_0.localEulerAngles = var_157_8
			end

			local var_157_9 = arg_154_1.actors_["1066ui_story"].transform
			local var_157_10 = 0

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 then
				arg_154_1.var_.moveOldPos1066ui_story = var_157_9.localPosition
			end

			local var_157_11 = 0.001

			if var_157_10 <= arg_154_1.time_ and arg_154_1.time_ < var_157_10 + var_157_11 then
				local var_157_12 = (arg_154_1.time_ - var_157_10) / var_157_11
				local var_157_13 = Vector3.New(0, 100, 0)

				var_157_9.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1066ui_story, var_157_13, var_157_12)

				local var_157_14 = manager.ui.mainCamera.transform.position - var_157_9.position

				var_157_9.forward = Vector3.New(var_157_14.x, var_157_14.y, var_157_14.z)

				local var_157_15 = var_157_9.localEulerAngles

				var_157_15.z = 0
				var_157_15.x = 0
				var_157_9.localEulerAngles = var_157_15
			end

			if arg_154_1.time_ >= var_157_10 + var_157_11 and arg_154_1.time_ < var_157_10 + var_157_11 + arg_157_0 then
				var_157_9.localPosition = Vector3.New(0, 100, 0)

				local var_157_16 = manager.ui.mainCamera.transform.position - var_157_9.position

				var_157_9.forward = Vector3.New(var_157_16.x, var_157_16.y, var_157_16.z)

				local var_157_17 = var_157_9.localEulerAngles

				var_157_17.z = 0
				var_157_17.x = 0
				var_157_9.localEulerAngles = var_157_17
			end

			local var_157_18 = 0
			local var_157_19 = 0.375

			if var_157_18 < arg_154_1.time_ and arg_154_1.time_ <= var_157_18 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_20 = arg_154_1:GetWordFromCfg(101041038)
				local var_157_21 = arg_154_1:FormatText(var_157_20.content)

				arg_154_1.text_.text = var_157_21

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_22 = 15
				local var_157_23 = utf8.len(var_157_21)
				local var_157_24 = var_157_22 <= 0 and var_157_19 or var_157_19 * (var_157_23 / var_157_22)

				if var_157_24 > 0 and var_157_19 < var_157_24 then
					arg_154_1.talkMaxDuration = var_157_24

					if var_157_24 + var_157_18 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_24 + var_157_18
					end
				end

				arg_154_1.text_.text = var_157_21
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_25 = math.max(var_157_19, arg_154_1.talkMaxDuration)

			if var_157_18 <= arg_154_1.time_ and arg_154_1.time_ < var_157_18 + var_157_25 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_18) / var_157_25

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_18 + var_157_25 and arg_154_1.time_ < var_157_18 + var_157_25 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play101041039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 101041039
		arg_158_1.duration_ = 3.37

		local var_158_0 = {
			ja = 3.166,
			ko = 2.966,
			zh = 3.366,
			en = 2
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
				arg_158_0:Play101041040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1066ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1066ui_story == nil then
				arg_158_1.var_.characterEffect1066ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.1

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect1066ui_story and not isNil(var_161_0) then
					local var_161_4 = Mathf.Lerp(0, 0.5, var_161_3)

					arg_158_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1066ui_story.fillRatio = var_161_4
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1066ui_story then
				local var_161_5 = 0.5

				arg_158_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1066ui_story.fillRatio = var_161_5
			end

			local var_161_6 = 0
			local var_161_7 = 0.25

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_8 = arg_158_1:FormatText(StoryNameCfg[5].name)

				arg_158_1.leftNameTxt_.text = var_161_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_9 = arg_158_1:GetWordFromCfg(101041039)
				local var_161_10 = arg_158_1:FormatText(var_161_9.content)

				arg_158_1.text_.text = var_161_10

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_11 = 10
				local var_161_12 = utf8.len(var_161_10)
				local var_161_13 = var_161_11 <= 0 and var_161_7 or var_161_7 * (var_161_12 / var_161_11)

				if var_161_13 > 0 and var_161_7 < var_161_13 then
					arg_158_1.talkMaxDuration = var_161_13

					if var_161_13 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_13 + var_161_6
					end
				end

				arg_158_1.text_.text = var_161_10
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041039", "story_v_out_101041.awb") ~= 0 then
					local var_161_14 = manager.audio:GetVoiceLength("story_v_out_101041", "101041039", "story_v_out_101041.awb") / 1000

					if var_161_14 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_14 + var_161_6
					end

					if var_161_9.prefab_name ~= "" and arg_158_1.actors_[var_161_9.prefab_name] ~= nil then
						local var_161_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_9.prefab_name].transform, "story_v_out_101041", "101041039", "story_v_out_101041.awb")

						arg_158_1:RecordAudio("101041039", var_161_15)
						arg_158_1:RecordAudio("101041039", var_161_15)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_101041", "101041039", "story_v_out_101041.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_101041", "101041039", "story_v_out_101041.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_16 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_16 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_16

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_16 and arg_158_1.time_ < var_161_6 + var_161_16 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play101041040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 101041040
		arg_162_1.duration_ = 2.33

		local var_162_0 = {
			ja = 2.333,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_162_0:Play101041041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			local var_165_1 = 0
			local var_165_2 = 0.175

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_3 = arg_162_1:FormatText(StoryNameCfg[13].name)

				arg_162_1.leftNameTxt_.text = var_165_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_4 = arg_162_1:GetWordFromCfg(101041040)
				local var_165_5 = arg_162_1:FormatText(var_165_4.content)

				arg_162_1.text_.text = var_165_5

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_6 = 7
				local var_165_7 = utf8.len(var_165_5)
				local var_165_8 = var_165_6 <= 0 and var_165_2 or var_165_2 * (var_165_7 / var_165_6)

				if var_165_8 > 0 and var_165_2 < var_165_8 then
					arg_162_1.talkMaxDuration = var_165_8

					if var_165_8 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_8 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_5
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041040", "story_v_out_101041.awb") ~= 0 then
					local var_165_9 = manager.audio:GetVoiceLength("story_v_out_101041", "101041040", "story_v_out_101041.awb") / 1000

					if var_165_9 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_9 + var_165_1
					end

					if var_165_4.prefab_name ~= "" and arg_162_1.actors_[var_165_4.prefab_name] ~= nil then
						local var_165_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_4.prefab_name].transform, "story_v_out_101041", "101041040", "story_v_out_101041.awb")

						arg_162_1:RecordAudio("101041040", var_165_10)
						arg_162_1:RecordAudio("101041040", var_165_10)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_101041", "101041040", "story_v_out_101041.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_101041", "101041040", "story_v_out_101041.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_11 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_11 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_11

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_11 and arg_162_1.time_ < var_165_1 + var_165_11 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play101041041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 101041041
		arg_166_1.duration_ = 10.47

		local var_166_0 = {
			ja = 8.4,
			ko = 8.166,
			zh = 8.9,
			en = 10.466
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
				arg_166_0:Play101041042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1019ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1019ui_story == nil then
				arg_166_1.var_.characterEffect1019ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.1

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect1019ui_story and not isNil(var_169_0) then
					arg_166_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1019ui_story then
				arg_166_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_169_4 = arg_166_1.actors_["1066ui_story"].transform
			local var_169_5 = 0

			if var_169_5 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 then
				arg_166_1.var_.moveOldPos1066ui_story = var_169_4.localPosition
			end

			local var_169_6 = 0.001

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_6 then
				local var_169_7 = (arg_166_1.time_ - var_169_5) / var_169_6
				local var_169_8 = Vector3.New(0.7, -0.77, -6.1)

				var_169_4.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1066ui_story, var_169_8, var_169_7)

				local var_169_9 = manager.ui.mainCamera.transform.position - var_169_4.position

				var_169_4.forward = Vector3.New(var_169_9.x, var_169_9.y, var_169_9.z)

				local var_169_10 = var_169_4.localEulerAngles

				var_169_10.z = 0
				var_169_10.x = 0
				var_169_4.localEulerAngles = var_169_10
			end

			if arg_166_1.time_ >= var_169_5 + var_169_6 and arg_166_1.time_ < var_169_5 + var_169_6 + arg_169_0 then
				var_169_4.localPosition = Vector3.New(0.7, -0.77, -6.1)

				local var_169_11 = manager.ui.mainCamera.transform.position - var_169_4.position

				var_169_4.forward = Vector3.New(var_169_11.x, var_169_11.y, var_169_11.z)

				local var_169_12 = var_169_4.localEulerAngles

				var_169_12.z = 0
				var_169_12.x = 0
				var_169_4.localEulerAngles = var_169_12
			end

			local var_169_13 = arg_166_1.actors_["1019ui_story"].transform
			local var_169_14 = 0

			if var_169_14 < arg_166_1.time_ and arg_166_1.time_ <= var_169_14 + arg_169_0 then
				arg_166_1.var_.moveOldPos1019ui_story = var_169_13.localPosition
			end

			local var_169_15 = 0.001

			if var_169_14 <= arg_166_1.time_ and arg_166_1.time_ < var_169_14 + var_169_15 then
				local var_169_16 = (arg_166_1.time_ - var_169_14) / var_169_15
				local var_169_17 = Vector3.New(-0.7, -1.08, -5.9)

				var_169_13.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1019ui_story, var_169_17, var_169_16)

				local var_169_18 = manager.ui.mainCamera.transform.position - var_169_13.position

				var_169_13.forward = Vector3.New(var_169_18.x, var_169_18.y, var_169_18.z)

				local var_169_19 = var_169_13.localEulerAngles

				var_169_19.z = 0
				var_169_19.x = 0
				var_169_13.localEulerAngles = var_169_19
			end

			if arg_166_1.time_ >= var_169_14 + var_169_15 and arg_166_1.time_ < var_169_14 + var_169_15 + arg_169_0 then
				var_169_13.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_169_20 = manager.ui.mainCamera.transform.position - var_169_13.position

				var_169_13.forward = Vector3.New(var_169_20.x, var_169_20.y, var_169_20.z)

				local var_169_21 = var_169_13.localEulerAngles

				var_169_21.z = 0
				var_169_21.x = 0
				var_169_13.localEulerAngles = var_169_21
			end

			local var_169_22 = 0

			if var_169_22 < arg_166_1.time_ and arg_166_1.time_ <= var_169_22 + arg_169_0 then
				arg_166_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_169_23 = 0

			if var_169_23 < arg_166_1.time_ and arg_166_1.time_ <= var_169_23 + arg_169_0 then
				arg_166_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_169_24 = 0
			local var_169_25 = 1.125

			if var_169_24 < arg_166_1.time_ and arg_166_1.time_ <= var_169_24 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_26 = arg_166_1:FormatText(StoryNameCfg[13].name)

				arg_166_1.leftNameTxt_.text = var_169_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_27 = arg_166_1:GetWordFromCfg(101041041)
				local var_169_28 = arg_166_1:FormatText(var_169_27.content)

				arg_166_1.text_.text = var_169_28

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_29 = 45
				local var_169_30 = utf8.len(var_169_28)
				local var_169_31 = var_169_29 <= 0 and var_169_25 or var_169_25 * (var_169_30 / var_169_29)

				if var_169_31 > 0 and var_169_25 < var_169_31 then
					arg_166_1.talkMaxDuration = var_169_31

					if var_169_31 + var_169_24 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_31 + var_169_24
					end
				end

				arg_166_1.text_.text = var_169_28
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041041", "story_v_out_101041.awb") ~= 0 then
					local var_169_32 = manager.audio:GetVoiceLength("story_v_out_101041", "101041041", "story_v_out_101041.awb") / 1000

					if var_169_32 + var_169_24 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_32 + var_169_24
					end

					if var_169_27.prefab_name ~= "" and arg_166_1.actors_[var_169_27.prefab_name] ~= nil then
						local var_169_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_27.prefab_name].transform, "story_v_out_101041", "101041041", "story_v_out_101041.awb")

						arg_166_1:RecordAudio("101041041", var_169_33)
						arg_166_1:RecordAudio("101041041", var_169_33)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_101041", "101041041", "story_v_out_101041.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_101041", "101041041", "story_v_out_101041.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_34 = math.max(var_169_25, arg_166_1.talkMaxDuration)

			if var_169_24 <= arg_166_1.time_ and arg_166_1.time_ < var_169_24 + var_169_34 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_24) / var_169_34

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_24 + var_169_34 and arg_166_1.time_ < var_169_24 + var_169_34 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play101041042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 101041042
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play101041043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1066ui_story"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect1066ui_story == nil then
				arg_170_1.var_.characterEffect1066ui_story = var_173_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.1

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.characterEffect1066ui_story and not isNil(var_173_0) then
					arg_170_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect1066ui_story then
				arg_170_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_173_4 = arg_170_1.actors_["1019ui_story"]
			local var_173_5 = 0

			if var_173_5 < arg_170_1.time_ and arg_170_1.time_ <= var_173_5 + arg_173_0 and not isNil(var_173_4) and arg_170_1.var_.characterEffect1019ui_story == nil then
				arg_170_1.var_.characterEffect1019ui_story = var_173_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_6 = 0.1

			if var_173_5 <= arg_170_1.time_ and arg_170_1.time_ < var_173_5 + var_173_6 and not isNil(var_173_4) then
				local var_173_7 = (arg_170_1.time_ - var_173_5) / var_173_6

				if arg_170_1.var_.characterEffect1019ui_story and not isNil(var_173_4) then
					local var_173_8 = Mathf.Lerp(0, 0.5, var_173_7)

					arg_170_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1019ui_story.fillRatio = var_173_8
				end
			end

			if arg_170_1.time_ >= var_173_5 + var_173_6 and arg_170_1.time_ < var_173_5 + var_173_6 + arg_173_0 and not isNil(var_173_4) and arg_170_1.var_.characterEffect1019ui_story then
				local var_173_9 = 0.5

				arg_170_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1019ui_story.fillRatio = var_173_9
			end

			local var_173_10 = 0

			if var_173_10 < arg_170_1.time_ and arg_170_1.time_ <= var_173_10 + arg_173_0 then
				arg_170_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action432")
			end

			local var_173_11 = 0

			if var_173_11 < arg_170_1.time_ and arg_170_1.time_ <= var_173_11 + arg_173_0 then
				arg_170_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_173_12 = 0
			local var_173_13 = 0.7

			if var_173_12 < arg_170_1.time_ and arg_170_1.time_ <= var_173_12 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_14 = arg_170_1:GetWordFromCfg(101041042)
				local var_173_15 = arg_170_1:FormatText(var_173_14.content)

				arg_170_1.text_.text = var_173_15

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_16 = 28
				local var_173_17 = utf8.len(var_173_15)
				local var_173_18 = var_173_16 <= 0 and var_173_13 or var_173_13 * (var_173_17 / var_173_16)

				if var_173_18 > 0 and var_173_13 < var_173_18 then
					arg_170_1.talkMaxDuration = var_173_18

					if var_173_18 + var_173_12 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_18 + var_173_12
					end
				end

				arg_170_1.text_.text = var_173_15
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_19 = math.max(var_173_13, arg_170_1.talkMaxDuration)

			if var_173_12 <= arg_170_1.time_ and arg_170_1.time_ < var_173_12 + var_173_19 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_12) / var_173_19

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_12 + var_173_19 and arg_170_1.time_ < var_173_12 + var_173_19 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play101041043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 101041043
		arg_174_1.duration_ = 10.77

		local var_174_0 = {
			ja = 10.766,
			ko = 7.666,
			zh = 10.166,
			en = 9.433
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
				arg_174_0:Play101041044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1019ui_story"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1019ui_story == nil then
				arg_174_1.var_.characterEffect1019ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.1

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.characterEffect1019ui_story and not isNil(var_177_0) then
					arg_174_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1019ui_story then
				arg_174_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_177_4 = arg_174_1.actors_["1066ui_story"]
			local var_177_5 = 0

			if var_177_5 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 and not isNil(var_177_4) and arg_174_1.var_.characterEffect1066ui_story == nil then
				arg_174_1.var_.characterEffect1066ui_story = var_177_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_6 = 0.1

			if var_177_5 <= arg_174_1.time_ and arg_174_1.time_ < var_177_5 + var_177_6 and not isNil(var_177_4) then
				local var_177_7 = (arg_174_1.time_ - var_177_5) / var_177_6

				if arg_174_1.var_.characterEffect1066ui_story and not isNil(var_177_4) then
					local var_177_8 = Mathf.Lerp(0, 0.5, var_177_7)

					arg_174_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1066ui_story.fillRatio = var_177_8
				end
			end

			if arg_174_1.time_ >= var_177_5 + var_177_6 and arg_174_1.time_ < var_177_5 + var_177_6 + arg_177_0 and not isNil(var_177_4) and arg_174_1.var_.characterEffect1066ui_story then
				local var_177_9 = 0.5

				arg_174_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1066ui_story.fillRatio = var_177_9
			end

			local var_177_10 = 0

			if var_177_10 < arg_174_1.time_ and arg_174_1.time_ <= var_177_10 + arg_177_0 then
				arg_174_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_177_11 = 0

			if var_177_11 < arg_174_1.time_ and arg_174_1.time_ <= var_177_11 + arg_177_0 then
				arg_174_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_177_12 = 0
			local var_177_13 = 1.025

			if var_177_12 < arg_174_1.time_ and arg_174_1.time_ <= var_177_12 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_14 = arg_174_1:FormatText(StoryNameCfg[13].name)

				arg_174_1.leftNameTxt_.text = var_177_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_15 = arg_174_1:GetWordFromCfg(101041043)
				local var_177_16 = arg_174_1:FormatText(var_177_15.content)

				arg_174_1.text_.text = var_177_16

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_17 = 43
				local var_177_18 = utf8.len(var_177_16)
				local var_177_19 = var_177_17 <= 0 and var_177_13 or var_177_13 * (var_177_18 / var_177_17)

				if var_177_19 > 0 and var_177_13 < var_177_19 then
					arg_174_1.talkMaxDuration = var_177_19

					if var_177_19 + var_177_12 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_19 + var_177_12
					end
				end

				arg_174_1.text_.text = var_177_16
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041043", "story_v_out_101041.awb") ~= 0 then
					local var_177_20 = manager.audio:GetVoiceLength("story_v_out_101041", "101041043", "story_v_out_101041.awb") / 1000

					if var_177_20 + var_177_12 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_20 + var_177_12
					end

					if var_177_15.prefab_name ~= "" and arg_174_1.actors_[var_177_15.prefab_name] ~= nil then
						local var_177_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_15.prefab_name].transform, "story_v_out_101041", "101041043", "story_v_out_101041.awb")

						arg_174_1:RecordAudio("101041043", var_177_21)
						arg_174_1:RecordAudio("101041043", var_177_21)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_101041", "101041043", "story_v_out_101041.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_101041", "101041043", "story_v_out_101041.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_22 = math.max(var_177_13, arg_174_1.talkMaxDuration)

			if var_177_12 <= arg_174_1.time_ and arg_174_1.time_ < var_177_12 + var_177_22 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_12) / var_177_22

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_12 + var_177_22 and arg_174_1.time_ < var_177_12 + var_177_22 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play101041044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 101041044
		arg_178_1.duration_ = 2

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play101041045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1066ui_story"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1066ui_story == nil then
				arg_178_1.var_.characterEffect1066ui_story = var_181_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.1

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.characterEffect1066ui_story and not isNil(var_181_0) then
					arg_178_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1066ui_story then
				arg_178_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_181_4 = arg_178_1.actors_["1019ui_story"]
			local var_181_5 = 0

			if var_181_5 < arg_178_1.time_ and arg_178_1.time_ <= var_181_5 + arg_181_0 and not isNil(var_181_4) and arg_178_1.var_.characterEffect1019ui_story == nil then
				arg_178_1.var_.characterEffect1019ui_story = var_181_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_6 = 0.1

			if var_181_5 <= arg_178_1.time_ and arg_178_1.time_ < var_181_5 + var_181_6 and not isNil(var_181_4) then
				local var_181_7 = (arg_178_1.time_ - var_181_5) / var_181_6

				if arg_178_1.var_.characterEffect1019ui_story and not isNil(var_181_4) then
					local var_181_8 = Mathf.Lerp(0, 0.5, var_181_7)

					arg_178_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1019ui_story.fillRatio = var_181_8
				end
			end

			if arg_178_1.time_ >= var_181_5 + var_181_6 and arg_178_1.time_ < var_181_5 + var_181_6 + arg_181_0 and not isNil(var_181_4) and arg_178_1.var_.characterEffect1019ui_story then
				local var_181_9 = 0.5

				arg_178_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1019ui_story.fillRatio = var_181_9
			end

			local var_181_10 = 0

			if var_181_10 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 then
				arg_178_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action429")
			end

			local var_181_11 = 0

			if var_181_11 < arg_178_1.time_ and arg_178_1.time_ <= var_181_11 + arg_181_0 then
				arg_178_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_181_12 = 0
			local var_181_13 = 0.075

			if var_181_12 < arg_178_1.time_ and arg_178_1.time_ <= var_181_12 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_14 = arg_178_1:FormatText(StoryNameCfg[32].name)

				arg_178_1.leftNameTxt_.text = var_181_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_15 = arg_178_1:GetWordFromCfg(101041044)
				local var_181_16 = arg_178_1:FormatText(var_181_15.content)

				arg_178_1.text_.text = var_181_16

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_17 = 3
				local var_181_18 = utf8.len(var_181_16)
				local var_181_19 = var_181_17 <= 0 and var_181_13 or var_181_13 * (var_181_18 / var_181_17)

				if var_181_19 > 0 and var_181_13 < var_181_19 then
					arg_178_1.talkMaxDuration = var_181_19

					if var_181_19 + var_181_12 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_19 + var_181_12
					end
				end

				arg_178_1.text_.text = var_181_16
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041044", "story_v_out_101041.awb") ~= 0 then
					local var_181_20 = manager.audio:GetVoiceLength("story_v_out_101041", "101041044", "story_v_out_101041.awb") / 1000

					if var_181_20 + var_181_12 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_20 + var_181_12
					end

					if var_181_15.prefab_name ~= "" and arg_178_1.actors_[var_181_15.prefab_name] ~= nil then
						local var_181_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_15.prefab_name].transform, "story_v_out_101041", "101041044", "story_v_out_101041.awb")

						arg_178_1:RecordAudio("101041044", var_181_21)
						arg_178_1:RecordAudio("101041044", var_181_21)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_101041", "101041044", "story_v_out_101041.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_101041", "101041044", "story_v_out_101041.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_22 = math.max(var_181_13, arg_178_1.talkMaxDuration)

			if var_181_12 <= arg_178_1.time_ and arg_178_1.time_ < var_181_12 + var_181_22 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_12) / var_181_22

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_12 + var_181_22 and arg_178_1.time_ < var_181_12 + var_181_22 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play101041045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 101041045
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play101041046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1066ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1066ui_story == nil then
				arg_182_1.var_.characterEffect1066ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.1

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect1066ui_story and not isNil(var_185_0) then
					local var_185_4 = Mathf.Lerp(0, 0.5, var_185_3)

					arg_182_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1066ui_story.fillRatio = var_185_4
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1066ui_story then
				local var_185_5 = 0.5

				arg_182_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1066ui_story.fillRatio = var_185_5
			end

			local var_185_6 = arg_182_1.actors_["1066ui_story"].transform
			local var_185_7 = 0

			if var_185_7 < arg_182_1.time_ and arg_182_1.time_ <= var_185_7 + arg_185_0 then
				arg_182_1.var_.moveOldPos1066ui_story = var_185_6.localPosition
			end

			local var_185_8 = 0.001

			if var_185_7 <= arg_182_1.time_ and arg_182_1.time_ < var_185_7 + var_185_8 then
				local var_185_9 = (arg_182_1.time_ - var_185_7) / var_185_8
				local var_185_10 = Vector3.New(0, 100, 0)

				var_185_6.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1066ui_story, var_185_10, var_185_9)

				local var_185_11 = manager.ui.mainCamera.transform.position - var_185_6.position

				var_185_6.forward = Vector3.New(var_185_11.x, var_185_11.y, var_185_11.z)

				local var_185_12 = var_185_6.localEulerAngles

				var_185_12.z = 0
				var_185_12.x = 0
				var_185_6.localEulerAngles = var_185_12
			end

			if arg_182_1.time_ >= var_185_7 + var_185_8 and arg_182_1.time_ < var_185_7 + var_185_8 + arg_185_0 then
				var_185_6.localPosition = Vector3.New(0, 100, 0)

				local var_185_13 = manager.ui.mainCamera.transform.position - var_185_6.position

				var_185_6.forward = Vector3.New(var_185_13.x, var_185_13.y, var_185_13.z)

				local var_185_14 = var_185_6.localEulerAngles

				var_185_14.z = 0
				var_185_14.x = 0
				var_185_6.localEulerAngles = var_185_14
			end

			local var_185_15 = arg_182_1.actors_["1019ui_story"].transform
			local var_185_16 = 0

			if var_185_16 < arg_182_1.time_ and arg_182_1.time_ <= var_185_16 + arg_185_0 then
				arg_182_1.var_.moveOldPos1019ui_story = var_185_15.localPosition
			end

			local var_185_17 = 0.001

			if var_185_16 <= arg_182_1.time_ and arg_182_1.time_ < var_185_16 + var_185_17 then
				local var_185_18 = (arg_182_1.time_ - var_185_16) / var_185_17
				local var_185_19 = Vector3.New(0, 100, 0)

				var_185_15.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1019ui_story, var_185_19, var_185_18)

				local var_185_20 = manager.ui.mainCamera.transform.position - var_185_15.position

				var_185_15.forward = Vector3.New(var_185_20.x, var_185_20.y, var_185_20.z)

				local var_185_21 = var_185_15.localEulerAngles

				var_185_21.z = 0
				var_185_21.x = 0
				var_185_15.localEulerAngles = var_185_21
			end

			if arg_182_1.time_ >= var_185_16 + var_185_17 and arg_182_1.time_ < var_185_16 + var_185_17 + arg_185_0 then
				var_185_15.localPosition = Vector3.New(0, 100, 0)

				local var_185_22 = manager.ui.mainCamera.transform.position - var_185_15.position

				var_185_15.forward = Vector3.New(var_185_22.x, var_185_22.y, var_185_22.z)

				local var_185_23 = var_185_15.localEulerAngles

				var_185_23.z = 0
				var_185_23.x = 0
				var_185_15.localEulerAngles = var_185_23
			end

			local var_185_24 = 0
			local var_185_25 = 0.6

			if var_185_24 < arg_182_1.time_ and arg_182_1.time_ <= var_185_24 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_26 = arg_182_1:GetWordFromCfg(101041045)
				local var_185_27 = arg_182_1:FormatText(var_185_26.content)

				arg_182_1.text_.text = var_185_27

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_28 = 24
				local var_185_29 = utf8.len(var_185_27)
				local var_185_30 = var_185_28 <= 0 and var_185_25 or var_185_25 * (var_185_29 / var_185_28)

				if var_185_30 > 0 and var_185_25 < var_185_30 then
					arg_182_1.talkMaxDuration = var_185_30

					if var_185_30 + var_185_24 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_30 + var_185_24
					end
				end

				arg_182_1.text_.text = var_185_27
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_31 = math.max(var_185_25, arg_182_1.talkMaxDuration)

			if var_185_24 <= arg_182_1.time_ and arg_182_1.time_ < var_185_24 + var_185_31 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_24) / var_185_31

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_24 + var_185_31 and arg_182_1.time_ < var_185_24 + var_185_31 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play101041046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 101041046
		arg_186_1.duration_ = 5.53

		local var_186_0 = {
			ja = 5.533,
			ko = 4.4,
			zh = 3.2,
			en = 4.9
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
				arg_186_0:Play101041047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1066ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1066ui_story == nil then
				arg_186_1.var_.characterEffect1066ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.1

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect1066ui_story and not isNil(var_189_0) then
					arg_186_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1066ui_story then
				arg_186_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_189_4 = arg_186_1.actors_["1066ui_story"].transform
			local var_189_5 = 0

			if var_189_5 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1.var_.moveOldPos1066ui_story = var_189_4.localPosition
			end

			local var_189_6 = 0.001

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_6 then
				local var_189_7 = (arg_186_1.time_ - var_189_5) / var_189_6
				local var_189_8 = Vector3.New(0, -0.77, -6.1)

				var_189_4.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1066ui_story, var_189_8, var_189_7)

				local var_189_9 = manager.ui.mainCamera.transform.position - var_189_4.position

				var_189_4.forward = Vector3.New(var_189_9.x, var_189_9.y, var_189_9.z)

				local var_189_10 = var_189_4.localEulerAngles

				var_189_10.z = 0
				var_189_10.x = 0
				var_189_4.localEulerAngles = var_189_10
			end

			if arg_186_1.time_ >= var_189_5 + var_189_6 and arg_186_1.time_ < var_189_5 + var_189_6 + arg_189_0 then
				var_189_4.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_189_11 = manager.ui.mainCamera.transform.position - var_189_4.position

				var_189_4.forward = Vector3.New(var_189_11.x, var_189_11.y, var_189_11.z)

				local var_189_12 = var_189_4.localEulerAngles

				var_189_12.z = 0
				var_189_12.x = 0
				var_189_4.localEulerAngles = var_189_12
			end

			local var_189_13 = 0

			if var_189_13 < arg_186_1.time_ and arg_186_1.time_ <= var_189_13 + arg_189_0 then
				arg_186_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			local var_189_14 = 0

			if var_189_14 < arg_186_1.time_ and arg_186_1.time_ <= var_189_14 + arg_189_0 then
				arg_186_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_189_15 = 0
			local var_189_16 = 0.4

			if var_189_15 < arg_186_1.time_ and arg_186_1.time_ <= var_189_15 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_17 = arg_186_1:FormatText(StoryNameCfg[32].name)

				arg_186_1.leftNameTxt_.text = var_189_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_18 = arg_186_1:GetWordFromCfg(101041046)
				local var_189_19 = arg_186_1:FormatText(var_189_18.content)

				arg_186_1.text_.text = var_189_19

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_20 = 16
				local var_189_21 = utf8.len(var_189_19)
				local var_189_22 = var_189_20 <= 0 and var_189_16 or var_189_16 * (var_189_21 / var_189_20)

				if var_189_22 > 0 and var_189_16 < var_189_22 then
					arg_186_1.talkMaxDuration = var_189_22

					if var_189_22 + var_189_15 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_22 + var_189_15
					end
				end

				arg_186_1.text_.text = var_189_19
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041046", "story_v_out_101041.awb") ~= 0 then
					local var_189_23 = manager.audio:GetVoiceLength("story_v_out_101041", "101041046", "story_v_out_101041.awb") / 1000

					if var_189_23 + var_189_15 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_23 + var_189_15
					end

					if var_189_18.prefab_name ~= "" and arg_186_1.actors_[var_189_18.prefab_name] ~= nil then
						local var_189_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_18.prefab_name].transform, "story_v_out_101041", "101041046", "story_v_out_101041.awb")

						arg_186_1:RecordAudio("101041046", var_189_24)
						arg_186_1:RecordAudio("101041046", var_189_24)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_101041", "101041046", "story_v_out_101041.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_101041", "101041046", "story_v_out_101041.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_25 = math.max(var_189_16, arg_186_1.talkMaxDuration)

			if var_189_15 <= arg_186_1.time_ and arg_186_1.time_ < var_189_15 + var_189_25 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_15) / var_189_25

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_15 + var_189_25 and arg_186_1.time_ < var_189_15 + var_189_25 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play101041047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 101041047
		arg_190_1.duration_ = 2.7

		local var_190_0 = {
			ja = 2.633,
			ko = 2.7,
			zh = 2.7,
			en = 1.999999999999
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
				arg_190_0:Play101041048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1036ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1036ui_story == nil then
				arg_190_1.var_.characterEffect1036ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.1

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1036ui_story and not isNil(var_193_0) then
					arg_190_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1036ui_story then
				arg_190_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_193_4 = arg_190_1.actors_["1066ui_story"]
			local var_193_5 = 0

			if var_193_5 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 and not isNil(var_193_4) and arg_190_1.var_.characterEffect1066ui_story == nil then
				arg_190_1.var_.characterEffect1066ui_story = var_193_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_6 = 0.1

			if var_193_5 <= arg_190_1.time_ and arg_190_1.time_ < var_193_5 + var_193_6 and not isNil(var_193_4) then
				local var_193_7 = (arg_190_1.time_ - var_193_5) / var_193_6

				if arg_190_1.var_.characterEffect1066ui_story and not isNil(var_193_4) then
					local var_193_8 = Mathf.Lerp(0, 0.5, var_193_7)

					arg_190_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1066ui_story.fillRatio = var_193_8
				end
			end

			if arg_190_1.time_ >= var_193_5 + var_193_6 and arg_190_1.time_ < var_193_5 + var_193_6 + arg_193_0 and not isNil(var_193_4) and arg_190_1.var_.characterEffect1066ui_story then
				local var_193_9 = 0.5

				arg_190_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1066ui_story.fillRatio = var_193_9
			end

			local var_193_10 = arg_190_1.actors_["1066ui_story"].transform
			local var_193_11 = 0

			if var_193_11 < arg_190_1.time_ and arg_190_1.time_ <= var_193_11 + arg_193_0 then
				arg_190_1.var_.moveOldPos1066ui_story = var_193_10.localPosition
			end

			local var_193_12 = 0.001

			if var_193_11 <= arg_190_1.time_ and arg_190_1.time_ < var_193_11 + var_193_12 then
				local var_193_13 = (arg_190_1.time_ - var_193_11) / var_193_12
				local var_193_14 = Vector3.New(0, -0.77, -6.1)

				var_193_10.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1066ui_story, var_193_14, var_193_13)

				local var_193_15 = manager.ui.mainCamera.transform.position - var_193_10.position

				var_193_10.forward = Vector3.New(var_193_15.x, var_193_15.y, var_193_15.z)

				local var_193_16 = var_193_10.localEulerAngles

				var_193_16.z = 0
				var_193_16.x = 0
				var_193_10.localEulerAngles = var_193_16
			end

			if arg_190_1.time_ >= var_193_11 + var_193_12 and arg_190_1.time_ < var_193_11 + var_193_12 + arg_193_0 then
				var_193_10.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_193_17 = manager.ui.mainCamera.transform.position - var_193_10.position

				var_193_10.forward = Vector3.New(var_193_17.x, var_193_17.y, var_193_17.z)

				local var_193_18 = var_193_10.localEulerAngles

				var_193_18.z = 0
				var_193_18.x = 0
				var_193_10.localEulerAngles = var_193_18
			end

			local var_193_19 = arg_190_1.actors_["1066ui_story"].transform
			local var_193_20 = 0.033

			if var_193_20 < arg_190_1.time_ and arg_190_1.time_ <= var_193_20 + arg_193_0 then
				arg_190_1.var_.moveOldPos1066ui_story = var_193_19.localPosition
			end

			local var_193_21 = 0.5

			if var_193_20 <= arg_190_1.time_ and arg_190_1.time_ < var_193_20 + var_193_21 then
				local var_193_22 = (arg_190_1.time_ - var_193_20) / var_193_21
				local var_193_23 = Vector3.New(0.7, -0.77, -6.1)

				var_193_19.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1066ui_story, var_193_23, var_193_22)

				local var_193_24 = manager.ui.mainCamera.transform.position - var_193_19.position

				var_193_19.forward = Vector3.New(var_193_24.x, var_193_24.y, var_193_24.z)

				local var_193_25 = var_193_19.localEulerAngles

				var_193_25.z = 0
				var_193_25.x = 0
				var_193_19.localEulerAngles = var_193_25
			end

			if arg_190_1.time_ >= var_193_20 + var_193_21 and arg_190_1.time_ < var_193_20 + var_193_21 + arg_193_0 then
				var_193_19.localPosition = Vector3.New(0.7, -0.77, -6.1)

				local var_193_26 = manager.ui.mainCamera.transform.position - var_193_19.position

				var_193_19.forward = Vector3.New(var_193_26.x, var_193_26.y, var_193_26.z)

				local var_193_27 = var_193_19.localEulerAngles

				var_193_27.z = 0
				var_193_27.x = 0
				var_193_19.localEulerAngles = var_193_27
			end

			local var_193_28 = arg_190_1.actors_["1036ui_story"].transform
			local var_193_29 = 0

			if var_193_29 < arg_190_1.time_ and arg_190_1.time_ <= var_193_29 + arg_193_0 then
				arg_190_1.var_.moveOldPos1036ui_story = var_193_28.localPosition
			end

			local var_193_30 = 0.001

			if var_193_29 <= arg_190_1.time_ and arg_190_1.time_ < var_193_29 + var_193_30 then
				local var_193_31 = (arg_190_1.time_ - var_193_29) / var_193_30
				local var_193_32 = Vector3.New(-0.7, -1.09, -5.78)

				var_193_28.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1036ui_story, var_193_32, var_193_31)

				local var_193_33 = manager.ui.mainCamera.transform.position - var_193_28.position

				var_193_28.forward = Vector3.New(var_193_33.x, var_193_33.y, var_193_33.z)

				local var_193_34 = var_193_28.localEulerAngles

				var_193_34.z = 0
				var_193_34.x = 0
				var_193_28.localEulerAngles = var_193_34
			end

			if arg_190_1.time_ >= var_193_29 + var_193_30 and arg_190_1.time_ < var_193_29 + var_193_30 + arg_193_0 then
				var_193_28.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_193_35 = manager.ui.mainCamera.transform.position - var_193_28.position

				var_193_28.forward = Vector3.New(var_193_35.x, var_193_35.y, var_193_35.z)

				local var_193_36 = var_193_28.localEulerAngles

				var_193_36.z = 0
				var_193_36.x = 0
				var_193_28.localEulerAngles = var_193_36
			end

			local var_193_37 = 0

			if var_193_37 < arg_190_1.time_ and arg_190_1.time_ <= var_193_37 + arg_193_0 then
				arg_190_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_193_38 = 0

			if var_193_38 < arg_190_1.time_ and arg_190_1.time_ <= var_193_38 + arg_193_0 then
				arg_190_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_193_39 = 0
			local var_193_40 = 0.2

			if var_193_39 < arg_190_1.time_ and arg_190_1.time_ <= var_193_39 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_41 = arg_190_1:FormatText(StoryNameCfg[5].name)

				arg_190_1.leftNameTxt_.text = var_193_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_42 = arg_190_1:GetWordFromCfg(101041047)
				local var_193_43 = arg_190_1:FormatText(var_193_42.content)

				arg_190_1.text_.text = var_193_43

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_44 = 8
				local var_193_45 = utf8.len(var_193_43)
				local var_193_46 = var_193_44 <= 0 and var_193_40 or var_193_40 * (var_193_45 / var_193_44)

				if var_193_46 > 0 and var_193_40 < var_193_46 then
					arg_190_1.talkMaxDuration = var_193_46

					if var_193_46 + var_193_39 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_46 + var_193_39
					end
				end

				arg_190_1.text_.text = var_193_43
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041047", "story_v_out_101041.awb") ~= 0 then
					local var_193_47 = manager.audio:GetVoiceLength("story_v_out_101041", "101041047", "story_v_out_101041.awb") / 1000

					if var_193_47 + var_193_39 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_47 + var_193_39
					end

					if var_193_42.prefab_name ~= "" and arg_190_1.actors_[var_193_42.prefab_name] ~= nil then
						local var_193_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_42.prefab_name].transform, "story_v_out_101041", "101041047", "story_v_out_101041.awb")

						arg_190_1:RecordAudio("101041047", var_193_48)
						arg_190_1:RecordAudio("101041047", var_193_48)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_101041", "101041047", "story_v_out_101041.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_101041", "101041047", "story_v_out_101041.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_49 = math.max(var_193_40, arg_190_1.talkMaxDuration)

			if var_193_39 <= arg_190_1.time_ and arg_190_1.time_ < var_193_39 + var_193_49 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_39) / var_193_49

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_39 + var_193_49 and arg_190_1.time_ < var_193_39 + var_193_49 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play101041048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 101041048
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play101041049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1066ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1066ui_story == nil then
				arg_194_1.var_.characterEffect1066ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.1

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect1066ui_story and not isNil(var_197_0) then
					local var_197_4 = Mathf.Lerp(0, 0.5, var_197_3)

					arg_194_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1066ui_story.fillRatio = var_197_4
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1066ui_story then
				local var_197_5 = 0.5

				arg_194_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1066ui_story.fillRatio = var_197_5
			end

			local var_197_6 = arg_194_1.actors_["1066ui_story"].transform
			local var_197_7 = 0

			if var_197_7 < arg_194_1.time_ and arg_194_1.time_ <= var_197_7 + arg_197_0 then
				arg_194_1.var_.moveOldPos1066ui_story = var_197_6.localPosition
			end

			local var_197_8 = 0.001

			if var_197_7 <= arg_194_1.time_ and arg_194_1.time_ < var_197_7 + var_197_8 then
				local var_197_9 = (arg_194_1.time_ - var_197_7) / var_197_8
				local var_197_10 = Vector3.New(0, 100, 0)

				var_197_6.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1066ui_story, var_197_10, var_197_9)

				local var_197_11 = manager.ui.mainCamera.transform.position - var_197_6.position

				var_197_6.forward = Vector3.New(var_197_11.x, var_197_11.y, var_197_11.z)

				local var_197_12 = var_197_6.localEulerAngles

				var_197_12.z = 0
				var_197_12.x = 0
				var_197_6.localEulerAngles = var_197_12
			end

			if arg_194_1.time_ >= var_197_7 + var_197_8 and arg_194_1.time_ < var_197_7 + var_197_8 + arg_197_0 then
				var_197_6.localPosition = Vector3.New(0, 100, 0)

				local var_197_13 = manager.ui.mainCamera.transform.position - var_197_6.position

				var_197_6.forward = Vector3.New(var_197_13.x, var_197_13.y, var_197_13.z)

				local var_197_14 = var_197_6.localEulerAngles

				var_197_14.z = 0
				var_197_14.x = 0
				var_197_6.localEulerAngles = var_197_14
			end

			local var_197_15 = arg_194_1.actors_["1036ui_story"].transform
			local var_197_16 = 0

			if var_197_16 < arg_194_1.time_ and arg_194_1.time_ <= var_197_16 + arg_197_0 then
				arg_194_1.var_.moveOldPos1036ui_story = var_197_15.localPosition
			end

			local var_197_17 = 0.001

			if var_197_16 <= arg_194_1.time_ and arg_194_1.time_ < var_197_16 + var_197_17 then
				local var_197_18 = (arg_194_1.time_ - var_197_16) / var_197_17
				local var_197_19 = Vector3.New(0, 100, 0)

				var_197_15.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1036ui_story, var_197_19, var_197_18)

				local var_197_20 = manager.ui.mainCamera.transform.position - var_197_15.position

				var_197_15.forward = Vector3.New(var_197_20.x, var_197_20.y, var_197_20.z)

				local var_197_21 = var_197_15.localEulerAngles

				var_197_21.z = 0
				var_197_21.x = 0
				var_197_15.localEulerAngles = var_197_21
			end

			if arg_194_1.time_ >= var_197_16 + var_197_17 and arg_194_1.time_ < var_197_16 + var_197_17 + arg_197_0 then
				var_197_15.localPosition = Vector3.New(0, 100, 0)

				local var_197_22 = manager.ui.mainCamera.transform.position - var_197_15.position

				var_197_15.forward = Vector3.New(var_197_22.x, var_197_22.y, var_197_22.z)

				local var_197_23 = var_197_15.localEulerAngles

				var_197_23.z = 0
				var_197_23.x = 0
				var_197_15.localEulerAngles = var_197_23
			end

			local var_197_24 = 0
			local var_197_25 = 0.475

			if var_197_24 < arg_194_1.time_ and arg_194_1.time_ <= var_197_24 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, false)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_26 = arg_194_1:GetWordFromCfg(101041048)
				local var_197_27 = arg_194_1:FormatText(var_197_26.content)

				arg_194_1.text_.text = var_197_27

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_28 = 19
				local var_197_29 = utf8.len(var_197_27)
				local var_197_30 = var_197_28 <= 0 and var_197_25 or var_197_25 * (var_197_29 / var_197_28)

				if var_197_30 > 0 and var_197_25 < var_197_30 then
					arg_194_1.talkMaxDuration = var_197_30

					if var_197_30 + var_197_24 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_30 + var_197_24
					end
				end

				arg_194_1.text_.text = var_197_27
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_31 = math.max(var_197_25, arg_194_1.talkMaxDuration)

			if var_197_24 <= arg_194_1.time_ and arg_194_1.time_ < var_197_24 + var_197_31 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_24) / var_197_31

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_24 + var_197_31 and arg_194_1.time_ < var_197_24 + var_197_31 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play101041049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 101041049
		arg_198_1.duration_ = 8.2

		local var_198_0 = {
			ja = 8.2,
			ko = 7.233,
			zh = 6.633,
			en = 7.333
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
				arg_198_0:Play101041050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1036ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1036ui_story == nil then
				arg_198_1.var_.characterEffect1036ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.1

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect1036ui_story and not isNil(var_201_0) then
					arg_198_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1036ui_story then
				arg_198_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_201_4 = arg_198_1.actors_["1036ui_story"].transform
			local var_201_5 = 0

			if var_201_5 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.var_.moveOldPos1036ui_story = var_201_4.localPosition
			end

			local var_201_6 = 0.001

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_6 then
				local var_201_7 = (arg_198_1.time_ - var_201_5) / var_201_6
				local var_201_8 = Vector3.New(0.7, -1.09, -5.78)

				var_201_4.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1036ui_story, var_201_8, var_201_7)

				local var_201_9 = manager.ui.mainCamera.transform.position - var_201_4.position

				var_201_4.forward = Vector3.New(var_201_9.x, var_201_9.y, var_201_9.z)

				local var_201_10 = var_201_4.localEulerAngles

				var_201_10.z = 0
				var_201_10.x = 0
				var_201_4.localEulerAngles = var_201_10
			end

			if arg_198_1.time_ >= var_201_5 + var_201_6 and arg_198_1.time_ < var_201_5 + var_201_6 + arg_201_0 then
				var_201_4.localPosition = Vector3.New(0.7, -1.09, -5.78)

				local var_201_11 = manager.ui.mainCamera.transform.position - var_201_4.position

				var_201_4.forward = Vector3.New(var_201_11.x, var_201_11.y, var_201_11.z)

				local var_201_12 = var_201_4.localEulerAngles

				var_201_12.z = 0
				var_201_12.x = 0
				var_201_4.localEulerAngles = var_201_12
			end

			local var_201_13 = 0

			if var_201_13 < arg_198_1.time_ and arg_198_1.time_ <= var_201_13 + arg_201_0 then
				arg_198_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action6_1")
			end

			local var_201_14 = 0

			if var_201_14 < arg_198_1.time_ and arg_198_1.time_ <= var_201_14 + arg_201_0 then
				arg_198_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_201_15 = 0
			local var_201_16 = 0.7

			if var_201_15 < arg_198_1.time_ and arg_198_1.time_ <= var_201_15 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_17 = arg_198_1:FormatText(StoryNameCfg[5].name)

				arg_198_1.leftNameTxt_.text = var_201_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_18 = arg_198_1:GetWordFromCfg(101041049)
				local var_201_19 = arg_198_1:FormatText(var_201_18.content)

				arg_198_1.text_.text = var_201_19

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_20 = 28
				local var_201_21 = utf8.len(var_201_19)
				local var_201_22 = var_201_20 <= 0 and var_201_16 or var_201_16 * (var_201_21 / var_201_20)

				if var_201_22 > 0 and var_201_16 < var_201_22 then
					arg_198_1.talkMaxDuration = var_201_22

					if var_201_22 + var_201_15 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_22 + var_201_15
					end
				end

				arg_198_1.text_.text = var_201_19
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041049", "story_v_out_101041.awb") ~= 0 then
					local var_201_23 = manager.audio:GetVoiceLength("story_v_out_101041", "101041049", "story_v_out_101041.awb") / 1000

					if var_201_23 + var_201_15 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_23 + var_201_15
					end

					if var_201_18.prefab_name ~= "" and arg_198_1.actors_[var_201_18.prefab_name] ~= nil then
						local var_201_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_18.prefab_name].transform, "story_v_out_101041", "101041049", "story_v_out_101041.awb")

						arg_198_1:RecordAudio("101041049", var_201_24)
						arg_198_1:RecordAudio("101041049", var_201_24)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_101041", "101041049", "story_v_out_101041.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_101041", "101041049", "story_v_out_101041.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_25 = math.max(var_201_16, arg_198_1.talkMaxDuration)

			if var_201_15 <= arg_198_1.time_ and arg_198_1.time_ < var_201_15 + var_201_25 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_15) / var_201_25

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_15 + var_201_25 and arg_198_1.time_ < var_201_15 + var_201_25 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play101041050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 101041050
		arg_202_1.duration_ = 14.47

		local var_202_0 = {
			ja = 14.466,
			ko = 9.566,
			zh = 8.466,
			en = 8.166
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
			arg_202_1.auto_ = false
		end

		function arg_202_1.playNext_(arg_204_0)
			arg_202_1.onStoryFinished_()
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1019ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1019ui_story == nil then
				arg_202_1.var_.characterEffect1019ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.1

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect1019ui_story and not isNil(var_205_0) then
					arg_202_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1019ui_story then
				arg_202_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_205_4 = arg_202_1.actors_["1036ui_story"]
			local var_205_5 = 0

			if var_205_5 < arg_202_1.time_ and arg_202_1.time_ <= var_205_5 + arg_205_0 and not isNil(var_205_4) and arg_202_1.var_.characterEffect1036ui_story == nil then
				arg_202_1.var_.characterEffect1036ui_story = var_205_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_6 = 0.1

			if var_205_5 <= arg_202_1.time_ and arg_202_1.time_ < var_205_5 + var_205_6 and not isNil(var_205_4) then
				local var_205_7 = (arg_202_1.time_ - var_205_5) / var_205_6

				if arg_202_1.var_.characterEffect1036ui_story and not isNil(var_205_4) then
					local var_205_8 = Mathf.Lerp(0, 0.5, var_205_7)

					arg_202_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1036ui_story.fillRatio = var_205_8
				end
			end

			if arg_202_1.time_ >= var_205_5 + var_205_6 and arg_202_1.time_ < var_205_5 + var_205_6 + arg_205_0 and not isNil(var_205_4) and arg_202_1.var_.characterEffect1036ui_story then
				local var_205_9 = 0.5

				arg_202_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1036ui_story.fillRatio = var_205_9
			end

			local var_205_10 = arg_202_1.actors_["1019ui_story"].transform
			local var_205_11 = 0

			if var_205_11 < arg_202_1.time_ and arg_202_1.time_ <= var_205_11 + arg_205_0 then
				arg_202_1.var_.moveOldPos1019ui_story = var_205_10.localPosition
			end

			local var_205_12 = 0.001

			if var_205_11 <= arg_202_1.time_ and arg_202_1.time_ < var_205_11 + var_205_12 then
				local var_205_13 = (arg_202_1.time_ - var_205_11) / var_205_12
				local var_205_14 = Vector3.New(-0.7, -1.08, -5.9)

				var_205_10.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1019ui_story, var_205_14, var_205_13)

				local var_205_15 = manager.ui.mainCamera.transform.position - var_205_10.position

				var_205_10.forward = Vector3.New(var_205_15.x, var_205_15.y, var_205_15.z)

				local var_205_16 = var_205_10.localEulerAngles

				var_205_16.z = 0
				var_205_16.x = 0
				var_205_10.localEulerAngles = var_205_16
			end

			if arg_202_1.time_ >= var_205_11 + var_205_12 and arg_202_1.time_ < var_205_11 + var_205_12 + arg_205_0 then
				var_205_10.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_205_17 = manager.ui.mainCamera.transform.position - var_205_10.position

				var_205_10.forward = Vector3.New(var_205_17.x, var_205_17.y, var_205_17.z)

				local var_205_18 = var_205_10.localEulerAngles

				var_205_18.z = 0
				var_205_18.x = 0
				var_205_10.localEulerAngles = var_205_18
			end

			local var_205_19 = 0

			if var_205_19 < arg_202_1.time_ and arg_202_1.time_ <= var_205_19 + arg_205_0 then
				arg_202_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_205_20 = 0

			if var_205_20 < arg_202_1.time_ and arg_202_1.time_ <= var_205_20 + arg_205_0 then
				arg_202_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_205_21 = 0
			local var_205_22 = 0.9

			if var_205_21 < arg_202_1.time_ and arg_202_1.time_ <= var_205_21 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_23 = arg_202_1:FormatText(StoryNameCfg[13].name)

				arg_202_1.leftNameTxt_.text = var_205_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_24 = arg_202_1:GetWordFromCfg(101041050)
				local var_205_25 = arg_202_1:FormatText(var_205_24.content)

				arg_202_1.text_.text = var_205_25

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_26 = 36
				local var_205_27 = utf8.len(var_205_25)
				local var_205_28 = var_205_26 <= 0 and var_205_22 or var_205_22 * (var_205_27 / var_205_26)

				if var_205_28 > 0 and var_205_22 < var_205_28 then
					arg_202_1.talkMaxDuration = var_205_28

					if var_205_28 + var_205_21 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_28 + var_205_21
					end
				end

				arg_202_1.text_.text = var_205_25
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101041", "101041050", "story_v_out_101041.awb") ~= 0 then
					local var_205_29 = manager.audio:GetVoiceLength("story_v_out_101041", "101041050", "story_v_out_101041.awb") / 1000

					if var_205_29 + var_205_21 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_29 + var_205_21
					end

					if var_205_24.prefab_name ~= "" and arg_202_1.actors_[var_205_24.prefab_name] ~= nil then
						local var_205_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_24.prefab_name].transform, "story_v_out_101041", "101041050", "story_v_out_101041.awb")

						arg_202_1:RecordAudio("101041050", var_205_30)
						arg_202_1:RecordAudio("101041050", var_205_30)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_101041", "101041050", "story_v_out_101041.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_101041", "101041050", "story_v_out_101041.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_31 = math.max(var_205_22, arg_202_1.talkMaxDuration)

			if var_205_21 <= arg_202_1.time_ and arg_202_1.time_ < var_205_21 + var_205_31 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_21) / var_205_31

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_21 + var_205_31 and arg_202_1.time_ < var_205_21 + var_205_31 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A00",
		"TextureConfig/Background/ST10"
	},
	voices = {
		"story_v_out_101041.awb"
	}
}
