return {
	Play101031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101031001
		arg_1_1.duration_ = 7.7

		local var_1_0 = {
			ja = 7.69933333333333,
			ko = 6.53333333333333,
			zh = 6.33333333333333,
			en = 6.93333333333333
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
				arg_1_0:Play101031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

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

			local var_4_6 = 0
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story", "se_story_fight_metal", "")
			end

			local var_4_10 = 0
			local var_4_11 = 1

			if var_4_10 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				local var_4_12 = "play"
				local var_4_13 = "effect"

				arg_1_1:AudioAction(var_4_12, var_4_13, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_14 = "B10a"

			if arg_1_1.bgs_[var_4_14] == nil then
				local var_4_15 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_14)
				var_4_15.name = var_4_14
				var_4_15.transform.parent = arg_1_1.stage_.transform
				var_4_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_14] = var_4_15
			end

			local var_4_16 = arg_1_1.bgs_.B10a
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueB10a = var_4_18.color.a
					arg_1_1.var_.alphaMatValueB10a = var_4_18
				end

				arg_1_1.var_.alphaOldValueB10a = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB10a, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueB10a then
					local var_4_22 = arg_1_1.var_.alphaMatValueB10a.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueB10a.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueB10a then
				local var_4_23 = arg_1_1.var_.alphaMatValueB10a
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_26 = manager.ui.mainCamera.transform.localPosition
				local var_4_27 = Vector3.New(0, 0, 10) + Vector3.New(var_4_26.x, var_4_26.y, 0)
				local var_4_28 = arg_1_1.bgs_.B10a

				var_4_28.transform.localPosition = var_4_27
				var_4_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_29 = var_4_28:GetComponent("SpriteRenderer")

				if var_4_29 and var_4_29.sprite then
					local var_4_30 = (var_4_28.transform.localPosition - var_4_26).z
					local var_4_31 = manager.ui.mainCameraCom_
					local var_4_32 = 2 * var_4_30 * Mathf.Tan(var_4_31.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_33 = var_4_32 * var_4_31.aspect
					local var_4_34 = var_4_29.sprite.bounds.size.x
					local var_4_35 = var_4_29.sprite.bounds.size.y
					local var_4_36 = var_4_33 / var_4_34
					local var_4_37 = var_4_32 / var_4_35
					local var_4_38 = var_4_37 < var_4_36 and var_4_36 or var_4_37

					var_4_28.transform.localScale = Vector3.New(var_4_38, var_4_38, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B10a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_39 = "1035ui_story"

			if arg_1_1.actors_[var_4_39] == nil then
				local var_4_40 = Asset.Load("Char/" .. "1035ui_story")

				if not isNil(var_4_40) then
					local var_4_41 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_1_1.stage_.transform)

					var_4_41.name = var_4_39
					var_4_41.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_39] = var_4_41

					local var_4_42 = var_4_41:GetComponentInChildren(typeof(CharacterEffect))

					var_4_42.enabled = true

					local var_4_43 = GameObjectTools.GetOrAddComponent(var_4_41, typeof(DynamicBoneHelper))

					if var_4_43 then
						var_4_43:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_42.transform, false)

					arg_1_1.var_[var_4_39 .. "Animator"] = var_4_42.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_39 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_39 .. "LipSync"] = var_4_42.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_44 = arg_1_1.actors_["1035ui_story"].transform
			local var_4_45 = 0.833333333333333

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1.var_.moveOldPos1035ui_story = var_4_44.localPosition
			end

			local var_4_46 = 0.001

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_45) / var_4_46
				local var_4_48 = Vector3.New(0, -1.05, -5.6)

				var_4_44.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1035ui_story, var_4_48, var_4_47)

				local var_4_49 = manager.ui.mainCamera.transform.position - var_4_44.position

				var_4_44.forward = Vector3.New(var_4_49.x, var_4_49.y, var_4_49.z)

				local var_4_50 = var_4_44.localEulerAngles

				var_4_50.z = 0
				var_4_50.x = 0
				var_4_44.localEulerAngles = var_4_50
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				var_4_44.localPosition = Vector3.New(0, -1.05, -5.6)

				local var_4_51 = manager.ui.mainCamera.transform.position - var_4_44.position

				var_4_44.forward = Vector3.New(var_4_51.x, var_4_51.y, var_4_51.z)

				local var_4_52 = var_4_44.localEulerAngles

				var_4_52.z = 0
				var_4_52.x = 0
				var_4_44.localEulerAngles = var_4_52
			end

			local var_4_53 = 0.833333333333333

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action7_1")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_54 = 0.833333333333333
			local var_4_55 = 0.5

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_56 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_56:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[21].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(101031001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031001", "story_v_out_101031.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_out_101031", "101031001", "story_v_out_101031.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_out_101031", "101031001", "story_v_out_101031.awb")

						arg_1_1:RecordAudio("101031001", var_4_64)
						arg_1_1:RecordAudio("101031001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_101031", "101031001", "story_v_out_101031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_101031", "101031001", "story_v_out_101031.awb")
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
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.833333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play101031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 101031002
		arg_8_1.duration_ = 7.8

		local var_8_0 = {
			ja = 7.8,
			ko = 5.466,
			zh = 7.133,
			en = 5.866
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
				arg_8_0:Play101031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story", "se_story_robot_broken", "")
			end

			local var_11_4 = "2044_tpose"

			if arg_8_1.actors_[var_11_4] == nil then
				local var_11_5 = Asset.Load("Char/" .. "2044_tpose")

				if not isNil(var_11_5) then
					local var_11_6 = Object.Instantiate(Asset.Load("Char/" .. "2044_tpose"), arg_8_1.stage_.transform)

					var_11_6.name = var_11_4
					var_11_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_4] = var_11_6

					local var_11_7 = var_11_6:GetComponentInChildren(typeof(CharacterEffect))

					var_11_7.enabled = true

					local var_11_8 = GameObjectTools.GetOrAddComponent(var_11_6, typeof(DynamicBoneHelper))

					if var_11_8 then
						var_11_8:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_7.transform, false)

					arg_8_1.var_[var_11_4 .. "Animator"] = var_11_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_4 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_4 .. "LipSync"] = var_11_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_9 = arg_8_1.actors_["2044_tpose"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect2044_tpose == nil then
				arg_8_1.var_.characterEffect2044_tpose = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.1

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect2044_tpose and not isNil(var_11_9) then
					arg_8_1.var_.characterEffect2044_tpose.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect2044_tpose then
				arg_8_1.var_.characterEffect2044_tpose.fillFlat = false
			end

			local var_11_13 = arg_8_1.actors_["2044_tpose"].transform
			local var_11_14 = 0

			if var_11_14 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 then
				arg_8_1.var_.moveOldPos2044_tpose = var_11_13.localPosition

				local var_11_15 = GameObjectTools.GetOrAddComponent(var_11_13.gameObject, typeof(DynamicBoneHelper))

				if var_11_15 then
					var_11_15:EnableDynamicBone(false)
				end
			end

			local var_11_16 = 0.001

			if var_11_14 <= arg_8_1.time_ and arg_8_1.time_ < var_11_14 + var_11_16 then
				local var_11_17 = (arg_8_1.time_ - var_11_14) / var_11_16
				local var_11_18 = Vector3.New(0, -1.15, -2.3)

				var_11_13.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos2044_tpose, var_11_18, var_11_17)

				local var_11_19 = manager.ui.mainCamera.transform.position - var_11_13.position

				var_11_13.forward = Vector3.New(var_11_19.x, var_11_19.y, var_11_19.z)

				local var_11_20 = var_11_13.localEulerAngles

				var_11_20.z = 0
				var_11_20.x = 0
				var_11_13.localEulerAngles = var_11_20
			end

			if arg_8_1.time_ >= var_11_14 + var_11_16 and arg_8_1.time_ < var_11_14 + var_11_16 + arg_11_0 then
				var_11_13.localPosition = Vector3.New(0, -1.15, -2.3)

				local var_11_21 = manager.ui.mainCamera.transform.position - var_11_13.position

				var_11_13.forward = Vector3.New(var_11_21.x, var_11_21.y, var_11_21.z)

				local var_11_22 = var_11_13.localEulerAngles

				var_11_22.z = 0
				var_11_22.x = 0
				var_11_13.localEulerAngles = var_11_22

				local var_11_23 = GameObjectTools.GetOrAddComponent(var_11_13.gameObject, typeof(DynamicBoneHelper))

				if var_11_23 then
					var_11_23:EnableDynamicBone(true)
				end
			end

			local var_11_24 = 0

			if var_11_24 < arg_8_1.time_ and arg_8_1.time_ <= var_11_24 + arg_11_0 then
				arg_8_1:PlayTimeline("2044_tpose", "StoryTimeline/CharAction/story2044/story2044action/2044action1_1")
			end

			local var_11_25 = arg_8_1.actors_["1035ui_story"].transform
			local var_11_26 = 0

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				arg_8_1.var_.moveOldPos1035ui_story = var_11_25.localPosition
			end

			local var_11_27 = 0.001

			if var_11_26 <= arg_8_1.time_ and arg_8_1.time_ < var_11_26 + var_11_27 then
				local var_11_28 = (arg_8_1.time_ - var_11_26) / var_11_27
				local var_11_29 = Vector3.New(0, 100, 0)

				var_11_25.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1035ui_story, var_11_29, var_11_28)

				local var_11_30 = manager.ui.mainCamera.transform.position - var_11_25.position

				var_11_25.forward = Vector3.New(var_11_30.x, var_11_30.y, var_11_30.z)

				local var_11_31 = var_11_25.localEulerAngles

				var_11_31.z = 0
				var_11_31.x = 0
				var_11_25.localEulerAngles = var_11_31
			end

			if arg_8_1.time_ >= var_11_26 + var_11_27 and arg_8_1.time_ < var_11_26 + var_11_27 + arg_11_0 then
				var_11_25.localPosition = Vector3.New(0, 100, 0)

				local var_11_32 = manager.ui.mainCamera.transform.position - var_11_25.position

				var_11_25.forward = Vector3.New(var_11_32.x, var_11_32.y, var_11_32.z)

				local var_11_33 = var_11_25.localEulerAngles

				var_11_33.z = 0
				var_11_33.x = 0
				var_11_25.localEulerAngles = var_11_33
			end

			local var_11_34 = 0
			local var_11_35 = 0.425

			if var_11_34 < arg_8_1.time_ and arg_8_1.time_ <= var_11_34 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_36 = arg_8_1:FormatText(StoryNameCfg[29].name)

				arg_8_1.leftNameTxt_.text = var_11_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_37 = arg_8_1:GetWordFromCfg(101031002)
				local var_11_38 = arg_8_1:FormatText(var_11_37.content)

				arg_8_1.text_.text = var_11_38

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_39 = 17
				local var_11_40 = utf8.len(var_11_38)
				local var_11_41 = var_11_39 <= 0 and var_11_35 or var_11_35 * (var_11_40 / var_11_39)

				if var_11_41 > 0 and var_11_35 < var_11_41 then
					arg_8_1.talkMaxDuration = var_11_41

					if var_11_41 + var_11_34 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_41 + var_11_34
					end
				end

				arg_8_1.text_.text = var_11_38
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031002", "story_v_out_101031.awb") ~= 0 then
					local var_11_42 = manager.audio:GetVoiceLength("story_v_out_101031", "101031002", "story_v_out_101031.awb") / 1000

					if var_11_42 + var_11_34 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_42 + var_11_34
					end

					if var_11_37.prefab_name ~= "" and arg_8_1.actors_[var_11_37.prefab_name] ~= nil then
						local var_11_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_37.prefab_name].transform, "story_v_out_101031", "101031002", "story_v_out_101031.awb")

						arg_8_1:RecordAudio("101031002", var_11_43)
						arg_8_1:RecordAudio("101031002", var_11_43)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_101031", "101031002", "story_v_out_101031.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_101031", "101031002", "story_v_out_101031.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_44 = math.max(var_11_35, arg_8_1.talkMaxDuration)

			if var_11_34 <= arg_8_1.time_ and arg_8_1.time_ < var_11_34 + var_11_44 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_34) / var_11_44

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_34 + var_11_44 and arg_8_1.time_ < var_11_34 + var_11_44 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2044_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play101031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 101031003
		arg_12_1.duration_ = 8.2

		local var_12_0 = {
			ja = 8.2,
			ko = 4.366,
			zh = 5.7,
			en = 3.966
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
				arg_12_0:Play101031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["2044_tpose"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect2044_tpose == nil then
				arg_12_1.var_.characterEffect2044_tpose = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect2044_tpose and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect2044_tpose.fillFlat = true
					arg_12_1.var_.characterEffect2044_tpose.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect2044_tpose then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect2044_tpose.fillFlat = true
				arg_12_1.var_.characterEffect2044_tpose.fillRatio = var_15_5
			end

			local var_15_6 = arg_12_1.actors_["2044_tpose"].transform
			local var_15_7 = 0

			if var_15_7 < arg_12_1.time_ and arg_12_1.time_ <= var_15_7 + arg_15_0 then
				arg_12_1.var_.moveOldPos2044_tpose = var_15_6.localPosition

				local var_15_8 = GameObjectTools.GetOrAddComponent(var_15_6.gameObject, typeof(DynamicBoneHelper))

				if var_15_8 then
					var_15_8:EnableDynamicBone(false)
				end
			end

			local var_15_9 = 0.001

			if var_15_7 <= arg_12_1.time_ and arg_12_1.time_ < var_15_7 + var_15_9 then
				local var_15_10 = (arg_12_1.time_ - var_15_7) / var_15_9
				local var_15_11 = Vector3.New(0, 100, 0)

				var_15_6.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos2044_tpose, var_15_11, var_15_10)

				local var_15_12 = manager.ui.mainCamera.transform.position - var_15_6.position

				var_15_6.forward = Vector3.New(var_15_12.x, var_15_12.y, var_15_12.z)

				local var_15_13 = var_15_6.localEulerAngles

				var_15_13.z = 0
				var_15_13.x = 0
				var_15_6.localEulerAngles = var_15_13
			end

			if arg_12_1.time_ >= var_15_7 + var_15_9 and arg_12_1.time_ < var_15_7 + var_15_9 + arg_15_0 then
				var_15_6.localPosition = Vector3.New(0, 100, 0)

				local var_15_14 = manager.ui.mainCamera.transform.position - var_15_6.position

				var_15_6.forward = Vector3.New(var_15_14.x, var_15_14.y, var_15_14.z)

				local var_15_15 = var_15_6.localEulerAngles

				var_15_15.z = 0
				var_15_15.x = 0
				var_15_6.localEulerAngles = var_15_15

				local var_15_16 = GameObjectTools.GetOrAddComponent(var_15_6.gameObject, typeof(DynamicBoneHelper))

				if var_15_16 then
					var_15_16:EnableDynamicBone(true)
				end
			end

			local var_15_17 = arg_12_1.actors_["1035ui_story"].transform
			local var_15_18 = 0

			if var_15_18 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1.var_.moveOldPos1035ui_story = var_15_17.localPosition
			end

			local var_15_19 = 0.001

			if var_15_18 <= arg_12_1.time_ and arg_12_1.time_ < var_15_18 + var_15_19 then
				local var_15_20 = (arg_12_1.time_ - var_15_18) / var_15_19
				local var_15_21 = Vector3.New(0, -1.05, -5.6)

				var_15_17.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1035ui_story, var_15_21, var_15_20)

				local var_15_22 = manager.ui.mainCamera.transform.position - var_15_17.position

				var_15_17.forward = Vector3.New(var_15_22.x, var_15_22.y, var_15_22.z)

				local var_15_23 = var_15_17.localEulerAngles

				var_15_23.z = 0
				var_15_23.x = 0
				var_15_17.localEulerAngles = var_15_23
			end

			if arg_12_1.time_ >= var_15_18 + var_15_19 and arg_12_1.time_ < var_15_18 + var_15_19 + arg_15_0 then
				var_15_17.localPosition = Vector3.New(0, -1.05, -5.6)

				local var_15_24 = manager.ui.mainCamera.transform.position - var_15_17.position

				var_15_17.forward = Vector3.New(var_15_24.x, var_15_24.y, var_15_24.z)

				local var_15_25 = var_15_17.localEulerAngles

				var_15_25.z = 0
				var_15_25.x = 0
				var_15_17.localEulerAngles = var_15_25
			end

			local var_15_26 = 0

			if var_15_26 < arg_12_1.time_ and arg_12_1.time_ <= var_15_26 + arg_15_0 then
				arg_12_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action5_1")
			end

			local var_15_27 = 0
			local var_15_28 = 0.525

			if var_15_27 < arg_12_1.time_ and arg_12_1.time_ <= var_15_27 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_29 = arg_12_1:FormatText(StoryNameCfg[21].name)

				arg_12_1.leftNameTxt_.text = var_15_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_30 = arg_12_1:GetWordFromCfg(101031003)
				local var_15_31 = arg_12_1:FormatText(var_15_30.content)

				arg_12_1.text_.text = var_15_31

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_32 = 21
				local var_15_33 = utf8.len(var_15_31)
				local var_15_34 = var_15_32 <= 0 and var_15_28 or var_15_28 * (var_15_33 / var_15_32)

				if var_15_34 > 0 and var_15_28 < var_15_34 then
					arg_12_1.talkMaxDuration = var_15_34

					if var_15_34 + var_15_27 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_34 + var_15_27
					end
				end

				arg_12_1.text_.text = var_15_31
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031003", "story_v_out_101031.awb") ~= 0 then
					local var_15_35 = manager.audio:GetVoiceLength("story_v_out_101031", "101031003", "story_v_out_101031.awb") / 1000

					if var_15_35 + var_15_27 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_35 + var_15_27
					end

					if var_15_30.prefab_name ~= "" and arg_12_1.actors_[var_15_30.prefab_name] ~= nil then
						local var_15_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_30.prefab_name].transform, "story_v_out_101031", "101031003", "story_v_out_101031.awb")

						arg_12_1:RecordAudio("101031003", var_15_36)
						arg_12_1:RecordAudio("101031003", var_15_36)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_101031", "101031003", "story_v_out_101031.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_101031", "101031003", "story_v_out_101031.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_37 = math.max(var_15_28, arg_12_1.talkMaxDuration)

			if var_15_27 <= arg_12_1.time_ and arg_12_1.time_ < var_15_27 + var_15_37 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_27) / var_15_37

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_27 + var_15_37 and arg_12_1.time_ < var_15_27 + var_15_37 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2044_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play101031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 101031004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play101031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = manager.ui.mainCamera.transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.shakeOldPosMainCamera = var_19_0.localPosition
			end

			local var_19_2 = 0.300000011920929

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / 0.066
				local var_19_4, var_19_5 = math.modf(var_19_3)

				var_19_0.localPosition = Vector3.New(var_19_5 * 0.13, var_19_5 * 0.13, var_19_5 * 0.13) + arg_16_1.var_.shakeOldPosMainCamera
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 then
				var_19_0.localPosition = arg_16_1.var_.shakeOldPosMainCamera
			end

			local var_19_6 = arg_16_1.actors_["1035ui_story"].transform
			local var_19_7 = 0

			if var_19_7 < arg_16_1.time_ and arg_16_1.time_ <= var_19_7 + arg_19_0 then
				arg_16_1.var_.moveOldPos1035ui_story = var_19_6.localPosition
			end

			local var_19_8 = 0.001

			if var_19_7 <= arg_16_1.time_ and arg_16_1.time_ < var_19_7 + var_19_8 then
				local var_19_9 = (arg_16_1.time_ - var_19_7) / var_19_8
				local var_19_10 = Vector3.New(0, 100, 0)

				var_19_6.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1035ui_story, var_19_10, var_19_9)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_6.position

				var_19_6.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_6.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_6.localEulerAngles = var_19_12
			end

			if arg_16_1.time_ >= var_19_7 + var_19_8 and arg_16_1.time_ < var_19_7 + var_19_8 + arg_19_0 then
				var_19_6.localPosition = Vector3.New(0, 100, 0)

				local var_19_13 = manager.ui.mainCamera.transform.position - var_19_6.position

				var_19_6.forward = Vector3.New(var_19_13.x, var_19_13.y, var_19_13.z)

				local var_19_14 = var_19_6.localEulerAngles

				var_19_14.z = 0
				var_19_14.x = 0
				var_19_6.localEulerAngles = var_19_14
			end

			local var_19_15 = 0
			local var_19_16 = 0.525

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_17 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_17:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
					arg_16_1.dialogCg_.alpha = arg_20_0
				end))
				var_19_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_18 = arg_16_1:GetWordFromCfg(101031004)
				local var_19_19 = arg_16_1:FormatText(var_19_18.content)

				arg_16_1.text_.text = var_19_19

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_20 = 21
				local var_19_21 = utf8.len(var_19_19)
				local var_19_22 = var_19_20 <= 0 and var_19_16 or var_19_16 * (var_19_21 / var_19_20)

				if var_19_22 > 0 and var_19_16 < var_19_22 then
					arg_16_1.talkMaxDuration = var_19_22
					var_19_15 = var_19_15 + 0.3

					if var_19_22 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_22 + var_19_15
					end
				end

				arg_16_1.text_.text = var_19_19
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_23 = var_19_15 + 0.3
			local var_19_24 = math.max(var_19_16, arg_16_1.talkMaxDuration)

			if var_19_23 <= arg_16_1.time_ and arg_16_1.time_ < var_19_23 + var_19_24 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_23) / var_19_24

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_23 + var_19_24 and arg_16_1.time_ < var_19_23 + var_19_24 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play101031005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 101031005
		arg_22_1.duration_ = 6.27

		local var_22_0 = {
			ja = 4.9,
			ko = 5.5,
			zh = 4.433,
			en = 6.266
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play101031006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = "3008ui_story"

			if arg_22_1.actors_[var_25_0] == nil then
				local var_25_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_25_1) then
					local var_25_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_22_1.stage_.transform)

					var_25_2.name = var_25_0
					var_25_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_22_1.actors_[var_25_0] = var_25_2

					local var_25_3 = var_25_2:GetComponentInChildren(typeof(CharacterEffect))

					var_25_3.enabled = true

					local var_25_4 = GameObjectTools.GetOrAddComponent(var_25_2, typeof(DynamicBoneHelper))

					if var_25_4 then
						var_25_4:EnableDynamicBone(false)
					end

					arg_22_1:ShowWeapon(var_25_3.transform, false)

					arg_22_1.var_[var_25_0 .. "Animator"] = var_25_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_22_1.var_[var_25_0 .. "Animator"].applyRootMotion = true
					arg_22_1.var_[var_25_0 .. "LipSync"] = var_25_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_25_5 = arg_22_1.actors_["3008ui_story"]
			local var_25_6 = 0

			if var_25_6 < arg_22_1.time_ and arg_22_1.time_ <= var_25_6 + arg_25_0 and not isNil(var_25_5) and arg_22_1.var_.characterEffect3008ui_story == nil then
				arg_22_1.var_.characterEffect3008ui_story = var_25_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_7 = 0.1

			if var_25_6 <= arg_22_1.time_ and arg_22_1.time_ < var_25_6 + var_25_7 and not isNil(var_25_5) then
				local var_25_8 = (arg_22_1.time_ - var_25_6) / var_25_7

				if arg_22_1.var_.characterEffect3008ui_story and not isNil(var_25_5) then
					arg_22_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= var_25_6 + var_25_7 and arg_22_1.time_ < var_25_6 + var_25_7 + arg_25_0 and not isNil(var_25_5) and arg_22_1.var_.characterEffect3008ui_story then
				arg_22_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_25_9 = arg_22_1.actors_["3008ui_story"].transform
			local var_25_10 = 0

			if var_25_10 < arg_22_1.time_ and arg_22_1.time_ <= var_25_10 + arg_25_0 then
				arg_22_1.var_.moveOldPos3008ui_story = var_25_9.localPosition
			end

			local var_25_11 = 0.001

			if var_25_10 <= arg_22_1.time_ and arg_22_1.time_ < var_25_10 + var_25_11 then
				local var_25_12 = (arg_22_1.time_ - var_25_10) / var_25_11
				local var_25_13 = Vector3.New(-0.7, -1.51, -4.3)

				var_25_9.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos3008ui_story, var_25_13, var_25_12)

				local var_25_14 = manager.ui.mainCamera.transform.position - var_25_9.position

				var_25_9.forward = Vector3.New(var_25_14.x, var_25_14.y, var_25_14.z)

				local var_25_15 = var_25_9.localEulerAngles

				var_25_15.z = 0
				var_25_15.x = 0
				var_25_9.localEulerAngles = var_25_15
			end

			if arg_22_1.time_ >= var_25_10 + var_25_11 and arg_22_1.time_ < var_25_10 + var_25_11 + arg_25_0 then
				var_25_9.localPosition = Vector3.New(-0.7, -1.51, -4.3)

				local var_25_16 = manager.ui.mainCamera.transform.position - var_25_9.position

				var_25_9.forward = Vector3.New(var_25_16.x, var_25_16.y, var_25_16.z)

				local var_25_17 = var_25_9.localEulerAngles

				var_25_17.z = 0
				var_25_17.x = 0
				var_25_9.localEulerAngles = var_25_17
			end

			local var_25_18 = 0

			if var_25_18 < arg_22_1.time_ and arg_22_1.time_ <= var_25_18 + arg_25_0 then
				arg_22_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			local var_25_19 = 0

			if var_25_19 < arg_22_1.time_ and arg_22_1.time_ <= var_25_19 + arg_25_0 then
				arg_22_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_25_20 = 0
			local var_25_21 = 0.625

			if var_25_20 < arg_22_1.time_ and arg_22_1.time_ <= var_25_20 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_22 = arg_22_1:FormatText(StoryNameCfg[20].name)

				arg_22_1.leftNameTxt_.text = var_25_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_23 = arg_22_1:GetWordFromCfg(101031005)
				local var_25_24 = arg_22_1:FormatText(var_25_23.content)

				arg_22_1.text_.text = var_25_24

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_25 = 25
				local var_25_26 = utf8.len(var_25_24)
				local var_25_27 = var_25_25 <= 0 and var_25_21 or var_25_21 * (var_25_26 / var_25_25)

				if var_25_27 > 0 and var_25_21 < var_25_27 then
					arg_22_1.talkMaxDuration = var_25_27

					if var_25_27 + var_25_20 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_27 + var_25_20
					end
				end

				arg_22_1.text_.text = var_25_24
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031005", "story_v_out_101031.awb") ~= 0 then
					local var_25_28 = manager.audio:GetVoiceLength("story_v_out_101031", "101031005", "story_v_out_101031.awb") / 1000

					if var_25_28 + var_25_20 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_28 + var_25_20
					end

					if var_25_23.prefab_name ~= "" and arg_22_1.actors_[var_25_23.prefab_name] ~= nil then
						local var_25_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_23.prefab_name].transform, "story_v_out_101031", "101031005", "story_v_out_101031.awb")

						arg_22_1:RecordAudio("101031005", var_25_29)
						arg_22_1:RecordAudio("101031005", var_25_29)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_101031", "101031005", "story_v_out_101031.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_101031", "101031005", "story_v_out_101031.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_30 = math.max(var_25_21, arg_22_1.talkMaxDuration)

			if var_25_20 <= arg_22_1.time_ and arg_22_1.time_ < var_25_20 + var_25_30 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_20) / var_25_30

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_20 + var_25_30 and arg_22_1.time_ < var_25_20 + var_25_30 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play101031006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 101031006
		arg_26_1.duration_ = 2.1

		local var_26_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.1,
			en = 1.999999999999
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play101031007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["3008ui_story"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect3008ui_story == nil then
				arg_26_1.var_.characterEffect3008ui_story = var_29_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.1

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.characterEffect3008ui_story and not isNil(var_29_0) then
					local var_29_4 = Mathf.Lerp(0, 0.5, var_29_3)

					arg_26_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_26_1.var_.characterEffect3008ui_story.fillRatio = var_29_4
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect3008ui_story then
				local var_29_5 = 0.5

				arg_26_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_26_1.var_.characterEffect3008ui_story.fillRatio = var_29_5
			end

			local var_29_6 = arg_26_1.actors_["1035ui_story"].transform
			local var_29_7 = 0

			if var_29_7 < arg_26_1.time_ and arg_26_1.time_ <= var_29_7 + arg_29_0 then
				arg_26_1.var_.moveOldPos1035ui_story = var_29_6.localPosition
			end

			local var_29_8 = 0.001

			if var_29_7 <= arg_26_1.time_ and arg_26_1.time_ < var_29_7 + var_29_8 then
				local var_29_9 = (arg_26_1.time_ - var_29_7) / var_29_8
				local var_29_10 = Vector3.New(0.7, -1.05, -5.6)

				var_29_6.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1035ui_story, var_29_10, var_29_9)

				local var_29_11 = manager.ui.mainCamera.transform.position - var_29_6.position

				var_29_6.forward = Vector3.New(var_29_11.x, var_29_11.y, var_29_11.z)

				local var_29_12 = var_29_6.localEulerAngles

				var_29_12.z = 0
				var_29_12.x = 0
				var_29_6.localEulerAngles = var_29_12
			end

			if arg_26_1.time_ >= var_29_7 + var_29_8 and arg_26_1.time_ < var_29_7 + var_29_8 + arg_29_0 then
				var_29_6.localPosition = Vector3.New(0.7, -1.05, -5.6)

				local var_29_13 = manager.ui.mainCamera.transform.position - var_29_6.position

				var_29_6.forward = Vector3.New(var_29_13.x, var_29_13.y, var_29_13.z)

				local var_29_14 = var_29_6.localEulerAngles

				var_29_14.z = 0
				var_29_14.x = 0
				var_29_6.localEulerAngles = var_29_14
			end

			local var_29_15 = arg_26_1.actors_["3008ui_story"].transform
			local var_29_16 = 0

			if var_29_16 < arg_26_1.time_ and arg_26_1.time_ <= var_29_16 + arg_29_0 then
				arg_26_1.var_.moveOldPos3008ui_story = var_29_15.localPosition
			end

			local var_29_17 = 0.001

			if var_29_16 <= arg_26_1.time_ and arg_26_1.time_ < var_29_16 + var_29_17 then
				local var_29_18 = (arg_26_1.time_ - var_29_16) / var_29_17
				local var_29_19 = Vector3.New(-0.7, -1.51, -4.3)

				var_29_15.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos3008ui_story, var_29_19, var_29_18)

				local var_29_20 = manager.ui.mainCamera.transform.position - var_29_15.position

				var_29_15.forward = Vector3.New(var_29_20.x, var_29_20.y, var_29_20.z)

				local var_29_21 = var_29_15.localEulerAngles

				var_29_21.z = 0
				var_29_21.x = 0
				var_29_15.localEulerAngles = var_29_21
			end

			if arg_26_1.time_ >= var_29_16 + var_29_17 and arg_26_1.time_ < var_29_16 + var_29_17 + arg_29_0 then
				var_29_15.localPosition = Vector3.New(-0.7, -1.51, -4.3)

				local var_29_22 = manager.ui.mainCamera.transform.position - var_29_15.position

				var_29_15.forward = Vector3.New(var_29_22.x, var_29_22.y, var_29_22.z)

				local var_29_23 = var_29_15.localEulerAngles

				var_29_23.z = 0
				var_29_23.x = 0
				var_29_15.localEulerAngles = var_29_23
			end

			local var_29_24 = 0

			if var_29_24 < arg_26_1.time_ and arg_26_1.time_ <= var_29_24 + arg_29_0 then
				arg_26_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action3_2")
			end

			local var_29_25 = arg_26_1.actors_["1035ui_story"]
			local var_29_26 = 0

			if var_29_26 < arg_26_1.time_ and arg_26_1.time_ <= var_29_26 + arg_29_0 and not isNil(var_29_25) and arg_26_1.var_.characterEffect1035ui_story == nil then
				arg_26_1.var_.characterEffect1035ui_story = var_29_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_27 = 0.1

			if var_29_26 <= arg_26_1.time_ and arg_26_1.time_ < var_29_26 + var_29_27 and not isNil(var_29_25) then
				local var_29_28 = (arg_26_1.time_ - var_29_26) / var_29_27

				if arg_26_1.var_.characterEffect1035ui_story and not isNil(var_29_25) then
					arg_26_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_26 + var_29_27 and arg_26_1.time_ < var_29_26 + var_29_27 + arg_29_0 and not isNil(var_29_25) and arg_26_1.var_.characterEffect1035ui_story then
				arg_26_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_29_29 = 0
			local var_29_30 = 0.1

			if var_29_29 < arg_26_1.time_ and arg_26_1.time_ <= var_29_29 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_31 = arg_26_1:FormatText(StoryNameCfg[21].name)

				arg_26_1.leftNameTxt_.text = var_29_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_32 = arg_26_1:GetWordFromCfg(101031006)
				local var_29_33 = arg_26_1:FormatText(var_29_32.content)

				arg_26_1.text_.text = var_29_33

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_34 = 4
				local var_29_35 = utf8.len(var_29_33)
				local var_29_36 = var_29_34 <= 0 and var_29_30 or var_29_30 * (var_29_35 / var_29_34)

				if var_29_36 > 0 and var_29_30 < var_29_36 then
					arg_26_1.talkMaxDuration = var_29_36

					if var_29_36 + var_29_29 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_36 + var_29_29
					end
				end

				arg_26_1.text_.text = var_29_33
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031006", "story_v_out_101031.awb") ~= 0 then
					local var_29_37 = manager.audio:GetVoiceLength("story_v_out_101031", "101031006", "story_v_out_101031.awb") / 1000

					if var_29_37 + var_29_29 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_37 + var_29_29
					end

					if var_29_32.prefab_name ~= "" and arg_26_1.actors_[var_29_32.prefab_name] ~= nil then
						local var_29_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_32.prefab_name].transform, "story_v_out_101031", "101031006", "story_v_out_101031.awb")

						arg_26_1:RecordAudio("101031006", var_29_38)
						arg_26_1:RecordAudio("101031006", var_29_38)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_101031", "101031006", "story_v_out_101031.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_101031", "101031006", "story_v_out_101031.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_39 = math.max(var_29_30, arg_26_1.talkMaxDuration)

			if var_29_29 <= arg_26_1.time_ and arg_26_1.time_ < var_29_29 + var_29_39 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_29) / var_29_39

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_29 + var_29_39 and arg_26_1.time_ < var_29_29 + var_29_39 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play101031007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 101031007
		arg_30_1.duration_ = 10.27

		local var_30_0 = {
			ja = 10.266,
			ko = 7.3,
			zh = 5.233,
			en = 6.366
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play101031008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["3008ui_story"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect3008ui_story == nil then
				arg_30_1.var_.characterEffect3008ui_story = var_33_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.1

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.characterEffect3008ui_story and not isNil(var_33_0) then
					arg_30_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect3008ui_story then
				arg_30_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_33_4 = arg_30_1.actors_["1035ui_story"]
			local var_33_5 = 0

			if var_33_5 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 and not isNil(var_33_4) and arg_30_1.var_.characterEffect1035ui_story == nil then
				arg_30_1.var_.characterEffect1035ui_story = var_33_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_6 = 0.1

			if var_33_5 <= arg_30_1.time_ and arg_30_1.time_ < var_33_5 + var_33_6 and not isNil(var_33_4) then
				local var_33_7 = (arg_30_1.time_ - var_33_5) / var_33_6

				if arg_30_1.var_.characterEffect1035ui_story and not isNil(var_33_4) then
					local var_33_8 = Mathf.Lerp(0, 0.5, var_33_7)

					arg_30_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_30_1.var_.characterEffect1035ui_story.fillRatio = var_33_8
				end
			end

			if arg_30_1.time_ >= var_33_5 + var_33_6 and arg_30_1.time_ < var_33_5 + var_33_6 + arg_33_0 and not isNil(var_33_4) and arg_30_1.var_.characterEffect1035ui_story then
				local var_33_9 = 0.5

				arg_30_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_30_1.var_.characterEffect1035ui_story.fillRatio = var_33_9
			end

			local var_33_10 = 0

			if var_33_10 < arg_30_1.time_ and arg_30_1.time_ <= var_33_10 + arg_33_0 then
				arg_30_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_2")
			end

			local var_33_11 = 0

			if var_33_11 < arg_30_1.time_ and arg_30_1.time_ <= var_33_11 + arg_33_0 then
				arg_30_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_33_12 = 0
			local var_33_13 = 0.625

			if var_33_12 < arg_30_1.time_ and arg_30_1.time_ <= var_33_12 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_14 = arg_30_1:FormatText(StoryNameCfg[20].name)

				arg_30_1.leftNameTxt_.text = var_33_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_15 = arg_30_1:GetWordFromCfg(101031007)
				local var_33_16 = arg_30_1:FormatText(var_33_15.content)

				arg_30_1.text_.text = var_33_16

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_17 = 25
				local var_33_18 = utf8.len(var_33_16)
				local var_33_19 = var_33_17 <= 0 and var_33_13 or var_33_13 * (var_33_18 / var_33_17)

				if var_33_19 > 0 and var_33_13 < var_33_19 then
					arg_30_1.talkMaxDuration = var_33_19

					if var_33_19 + var_33_12 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_19 + var_33_12
					end
				end

				arg_30_1.text_.text = var_33_16
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031007", "story_v_out_101031.awb") ~= 0 then
					local var_33_20 = manager.audio:GetVoiceLength("story_v_out_101031", "101031007", "story_v_out_101031.awb") / 1000

					if var_33_20 + var_33_12 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_20 + var_33_12
					end

					if var_33_15.prefab_name ~= "" and arg_30_1.actors_[var_33_15.prefab_name] ~= nil then
						local var_33_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_15.prefab_name].transform, "story_v_out_101031", "101031007", "story_v_out_101031.awb")

						arg_30_1:RecordAudio("101031007", var_33_21)
						arg_30_1:RecordAudio("101031007", var_33_21)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_101031", "101031007", "story_v_out_101031.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_101031", "101031007", "story_v_out_101031.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_22 = math.max(var_33_13, arg_30_1.talkMaxDuration)

			if var_33_12 <= arg_30_1.time_ and arg_30_1.time_ < var_33_12 + var_33_22 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_12) / var_33_22

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_12 + var_33_22 and arg_30_1.time_ < var_33_12 + var_33_22 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play101031008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 101031008
		arg_34_1.duration_ = 8.47

		local var_34_0 = {
			ja = 7.333,
			ko = 7.6,
			zh = 5.433,
			en = 8.466
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play101031009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_37_1 = 0
			local var_37_2 = 0.825

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_3 = arg_34_1:FormatText(StoryNameCfg[20].name)

				arg_34_1.leftNameTxt_.text = var_37_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_4 = arg_34_1:GetWordFromCfg(101031008)
				local var_37_5 = arg_34_1:FormatText(var_37_4.content)

				arg_34_1.text_.text = var_37_5

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_6 = 33
				local var_37_7 = utf8.len(var_37_5)
				local var_37_8 = var_37_6 <= 0 and var_37_2 or var_37_2 * (var_37_7 / var_37_6)

				if var_37_8 > 0 and var_37_2 < var_37_8 then
					arg_34_1.talkMaxDuration = var_37_8

					if var_37_8 + var_37_1 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_1
					end
				end

				arg_34_1.text_.text = var_37_5
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031008", "story_v_out_101031.awb") ~= 0 then
					local var_37_9 = manager.audio:GetVoiceLength("story_v_out_101031", "101031008", "story_v_out_101031.awb") / 1000

					if var_37_9 + var_37_1 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_9 + var_37_1
					end

					if var_37_4.prefab_name ~= "" and arg_34_1.actors_[var_37_4.prefab_name] ~= nil then
						local var_37_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_4.prefab_name].transform, "story_v_out_101031", "101031008", "story_v_out_101031.awb")

						arg_34_1:RecordAudio("101031008", var_37_10)
						arg_34_1:RecordAudio("101031008", var_37_10)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_101031", "101031008", "story_v_out_101031.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_101031", "101031008", "story_v_out_101031.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_11 = math.max(var_37_2, arg_34_1.talkMaxDuration)

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_11 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_1) / var_37_11

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_1 + var_37_11 and arg_34_1.time_ < var_37_1 + var_37_11 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play101031009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 101031009
		arg_38_1.duration_ = 3.57

		local var_38_0 = {
			ja = 3.566,
			ko = 1.999999999999,
			zh = 2.333,
			en = 3.3
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play101031010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["3008ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect3008ui_story == nil then
				arg_38_1.var_.characterEffect3008ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.1

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect3008ui_story and not isNil(var_41_0) then
					local var_41_4 = Mathf.Lerp(0, 0.5, var_41_3)

					arg_38_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_38_1.var_.characterEffect3008ui_story.fillRatio = var_41_4
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect3008ui_story then
				local var_41_5 = 0.5

				arg_38_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_38_1.var_.characterEffect3008ui_story.fillRatio = var_41_5
			end

			local var_41_6 = 0

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action4_1")
			end

			local var_41_7 = arg_38_1.actors_["1035ui_story"]
			local var_41_8 = 0

			if var_41_8 < arg_38_1.time_ and arg_38_1.time_ <= var_41_8 + arg_41_0 and not isNil(var_41_7) and arg_38_1.var_.characterEffect1035ui_story == nil then
				arg_38_1.var_.characterEffect1035ui_story = var_41_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_9 = 0.100000001490116

			if var_41_8 <= arg_38_1.time_ and arg_38_1.time_ < var_41_8 + var_41_9 and not isNil(var_41_7) then
				local var_41_10 = (arg_38_1.time_ - var_41_8) / var_41_9

				if arg_38_1.var_.characterEffect1035ui_story and not isNil(var_41_7) then
					arg_38_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_8 + var_41_9 and arg_38_1.time_ < var_41_8 + var_41_9 + arg_41_0 and not isNil(var_41_7) and arg_38_1.var_.characterEffect1035ui_story then
				arg_38_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_41_11 = 0
			local var_41_12 = 0.2

			if var_41_11 < arg_38_1.time_ and arg_38_1.time_ <= var_41_11 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_13 = arg_38_1:FormatText(StoryNameCfg[21].name)

				arg_38_1.leftNameTxt_.text = var_41_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_14 = arg_38_1:GetWordFromCfg(101031009)
				local var_41_15 = arg_38_1:FormatText(var_41_14.content)

				arg_38_1.text_.text = var_41_15

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_16 = 8
				local var_41_17 = utf8.len(var_41_15)
				local var_41_18 = var_41_16 <= 0 and var_41_12 or var_41_12 * (var_41_17 / var_41_16)

				if var_41_18 > 0 and var_41_12 < var_41_18 then
					arg_38_1.talkMaxDuration = var_41_18

					if var_41_18 + var_41_11 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_18 + var_41_11
					end
				end

				arg_38_1.text_.text = var_41_15
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031009", "story_v_out_101031.awb") ~= 0 then
					local var_41_19 = manager.audio:GetVoiceLength("story_v_out_101031", "101031009", "story_v_out_101031.awb") / 1000

					if var_41_19 + var_41_11 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_19 + var_41_11
					end

					if var_41_14.prefab_name ~= "" and arg_38_1.actors_[var_41_14.prefab_name] ~= nil then
						local var_41_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_14.prefab_name].transform, "story_v_out_101031", "101031009", "story_v_out_101031.awb")

						arg_38_1:RecordAudio("101031009", var_41_20)
						arg_38_1:RecordAudio("101031009", var_41_20)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_101031", "101031009", "story_v_out_101031.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_101031", "101031009", "story_v_out_101031.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_21 = math.max(var_41_12, arg_38_1.talkMaxDuration)

			if var_41_11 <= arg_38_1.time_ and arg_38_1.time_ < var_41_11 + var_41_21 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_11) / var_41_21

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_11 + var_41_21 and arg_38_1.time_ < var_41_11 + var_41_21 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play101031010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 101031010
		arg_42_1.duration_ = 3.37

		local var_42_0 = {
			ja = 3.366,
			ko = 2.3,
			zh = 2.466,
			en = 3.3
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play101031011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = "2020_tpose"

			if arg_42_1.actors_[var_45_0] == nil then
				local var_45_1 = Asset.Load("Char/" .. "2020_tpose")

				if not isNil(var_45_1) then
					local var_45_2 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_42_1.stage_.transform)

					var_45_2.name = var_45_0
					var_45_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_42_1.actors_[var_45_0] = var_45_2

					local var_45_3 = var_45_2:GetComponentInChildren(typeof(CharacterEffect))

					var_45_3.enabled = true

					local var_45_4 = GameObjectTools.GetOrAddComponent(var_45_2, typeof(DynamicBoneHelper))

					if var_45_4 then
						var_45_4:EnableDynamicBone(false)
					end

					arg_42_1:ShowWeapon(var_45_3.transform, false)

					arg_42_1.var_[var_45_0 .. "Animator"] = var_45_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_42_1.var_[var_45_0 .. "Animator"].applyRootMotion = true
					arg_42_1.var_[var_45_0 .. "LipSync"] = var_45_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_45_5 = arg_42_1.actors_["2020_tpose"]
			local var_45_6 = 0

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.characterEffect2020_tpose == nil then
				arg_42_1.var_.characterEffect2020_tpose = var_45_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_7 = 0.1

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_7 and not isNil(var_45_5) then
				local var_45_8 = (arg_42_1.time_ - var_45_6) / var_45_7

				if arg_42_1.var_.characterEffect2020_tpose and not isNil(var_45_5) then
					arg_42_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_6 + var_45_7 and arg_42_1.time_ < var_45_6 + var_45_7 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.characterEffect2020_tpose then
				arg_42_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_45_9 = arg_42_1.actors_["3008ui_story"].transform
			local var_45_10 = 0

			if var_45_10 < arg_42_1.time_ and arg_42_1.time_ <= var_45_10 + arg_45_0 then
				arg_42_1.var_.moveOldPos3008ui_story = var_45_9.localPosition
			end

			local var_45_11 = 0.001

			if var_45_10 <= arg_42_1.time_ and arg_42_1.time_ < var_45_10 + var_45_11 then
				local var_45_12 = (arg_42_1.time_ - var_45_10) / var_45_11
				local var_45_13 = Vector3.New(-0.7, -1.51, -4.3)

				var_45_9.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos3008ui_story, var_45_13, var_45_12)

				local var_45_14 = manager.ui.mainCamera.transform.position - var_45_9.position

				var_45_9.forward = Vector3.New(var_45_14.x, var_45_14.y, var_45_14.z)

				local var_45_15 = var_45_9.localEulerAngles

				var_45_15.z = 0
				var_45_15.x = 0
				var_45_9.localEulerAngles = var_45_15
			end

			if arg_42_1.time_ >= var_45_10 + var_45_11 and arg_42_1.time_ < var_45_10 + var_45_11 + arg_45_0 then
				var_45_9.localPosition = Vector3.New(-0.7, -1.51, -4.3)

				local var_45_16 = manager.ui.mainCamera.transform.position - var_45_9.position

				var_45_9.forward = Vector3.New(var_45_16.x, var_45_16.y, var_45_16.z)

				local var_45_17 = var_45_9.localEulerAngles

				var_45_17.z = 0
				var_45_17.x = 0
				var_45_9.localEulerAngles = var_45_17
			end

			local var_45_18 = arg_42_1.actors_["2020_tpose"].transform
			local var_45_19 = 0

			if var_45_19 < arg_42_1.time_ and arg_42_1.time_ <= var_45_19 + arg_45_0 then
				arg_42_1.var_.moveOldPos2020_tpose = var_45_18.localPosition

				local var_45_20 = GameObjectTools.GetOrAddComponent(var_45_18.gameObject, typeof(DynamicBoneHelper))

				if var_45_20 then
					var_45_20:EnableDynamicBone(false)
				end
			end

			local var_45_21 = 0.001

			if var_45_19 <= arg_42_1.time_ and arg_42_1.time_ < var_45_19 + var_45_21 then
				local var_45_22 = (arg_42_1.time_ - var_45_19) / var_45_21
				local var_45_23 = Vector3.New(0.7, -1.2, -4.1)

				var_45_18.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos2020_tpose, var_45_23, var_45_22)

				local var_45_24 = manager.ui.mainCamera.transform.position - var_45_18.position

				var_45_18.forward = Vector3.New(var_45_24.x, var_45_24.y, var_45_24.z)

				local var_45_25 = var_45_18.localEulerAngles

				var_45_25.z = 0
				var_45_25.x = 0
				var_45_18.localEulerAngles = var_45_25
			end

			if arg_42_1.time_ >= var_45_19 + var_45_21 and arg_42_1.time_ < var_45_19 + var_45_21 + arg_45_0 then
				var_45_18.localPosition = Vector3.New(0.7, -1.2, -4.1)

				local var_45_26 = manager.ui.mainCamera.transform.position - var_45_18.position

				var_45_18.forward = Vector3.New(var_45_26.x, var_45_26.y, var_45_26.z)

				local var_45_27 = var_45_18.localEulerAngles

				var_45_27.z = 0
				var_45_27.x = 0
				var_45_18.localEulerAngles = var_45_27

				local var_45_28 = GameObjectTools.GetOrAddComponent(var_45_18.gameObject, typeof(DynamicBoneHelper))

				if var_45_28 then
					var_45_28:EnableDynamicBone(true)
				end
			end

			local var_45_29 = 0

			if var_45_29 < arg_42_1.time_ and arg_42_1.time_ <= var_45_29 + arg_45_0 then
				arg_42_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_45_30 = arg_42_1.actors_["1035ui_story"].transform
			local var_45_31 = 0

			if var_45_31 < arg_42_1.time_ and arg_42_1.time_ <= var_45_31 + arg_45_0 then
				arg_42_1.var_.moveOldPos1035ui_story = var_45_30.localPosition
			end

			local var_45_32 = 0.001

			if var_45_31 <= arg_42_1.time_ and arg_42_1.time_ < var_45_31 + var_45_32 then
				local var_45_33 = (arg_42_1.time_ - var_45_31) / var_45_32
				local var_45_34 = Vector3.New(0, 100, 0)

				var_45_30.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1035ui_story, var_45_34, var_45_33)

				local var_45_35 = manager.ui.mainCamera.transform.position - var_45_30.position

				var_45_30.forward = Vector3.New(var_45_35.x, var_45_35.y, var_45_35.z)

				local var_45_36 = var_45_30.localEulerAngles

				var_45_36.z = 0
				var_45_36.x = 0
				var_45_30.localEulerAngles = var_45_36
			end

			if arg_42_1.time_ >= var_45_31 + var_45_32 and arg_42_1.time_ < var_45_31 + var_45_32 + arg_45_0 then
				var_45_30.localPosition = Vector3.New(0, 100, 0)

				local var_45_37 = manager.ui.mainCamera.transform.position - var_45_30.position

				var_45_30.forward = Vector3.New(var_45_37.x, var_45_37.y, var_45_37.z)

				local var_45_38 = var_45_30.localEulerAngles

				var_45_38.z = 0
				var_45_38.x = 0
				var_45_30.localEulerAngles = var_45_38
			end

			local var_45_39 = 0
			local var_45_40 = 0.3

			if var_45_39 < arg_42_1.time_ and arg_42_1.time_ <= var_45_39 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_41 = arg_42_1:FormatText(StoryNameCfg[19].name)

				arg_42_1.leftNameTxt_.text = var_45_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_42 = arg_42_1:GetWordFromCfg(101031010)
				local var_45_43 = arg_42_1:FormatText(var_45_42.content)

				arg_42_1.text_.text = var_45_43

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_44 = 12
				local var_45_45 = utf8.len(var_45_43)
				local var_45_46 = var_45_44 <= 0 and var_45_40 or var_45_40 * (var_45_45 / var_45_44)

				if var_45_46 > 0 and var_45_40 < var_45_46 then
					arg_42_1.talkMaxDuration = var_45_46

					if var_45_46 + var_45_39 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_46 + var_45_39
					end
				end

				arg_42_1.text_.text = var_45_43
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031010", "story_v_out_101031.awb") ~= 0 then
					local var_45_47 = manager.audio:GetVoiceLength("story_v_out_101031", "101031010", "story_v_out_101031.awb") / 1000

					if var_45_47 + var_45_39 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_47 + var_45_39
					end

					if var_45_42.prefab_name ~= "" and arg_42_1.actors_[var_45_42.prefab_name] ~= nil then
						local var_45_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_42.prefab_name].transform, "story_v_out_101031", "101031010", "story_v_out_101031.awb")

						arg_42_1:RecordAudio("101031010", var_45_48)
						arg_42_1:RecordAudio("101031010", var_45_48)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_101031", "101031010", "story_v_out_101031.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_101031", "101031010", "story_v_out_101031.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_49 = math.max(var_45_40, arg_42_1.talkMaxDuration)

			if var_45_39 <= arg_42_1.time_ and arg_42_1.time_ < var_45_39 + var_45_49 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_39) / var_45_49

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_39 + var_45_49 and arg_42_1.time_ < var_45_39 + var_45_49 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play101031011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 101031011
		arg_46_1.duration_ = 3.27

		local var_46_0 = {
			ja = 3.266,
			ko = 1.233,
			zh = 1.2,
			en = 1.366
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play101031012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0
			local var_49_1 = 0.1

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_2 = arg_46_1:FormatText(StoryNameCfg[19].name)

				arg_46_1.leftNameTxt_.text = var_49_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_3 = arg_46_1:GetWordFromCfg(101031011)
				local var_49_4 = arg_46_1:FormatText(var_49_3.content)

				arg_46_1.text_.text = var_49_4

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 4
				local var_49_6 = utf8.len(var_49_4)
				local var_49_7 = var_49_5 <= 0 and var_49_1 or var_49_1 * (var_49_6 / var_49_5)

				if var_49_7 > 0 and var_49_1 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_0
					end
				end

				arg_46_1.text_.text = var_49_4
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031011", "story_v_out_101031.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_101031", "101031011", "story_v_out_101031.awb") / 1000

					if var_49_8 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_0
					end

					if var_49_3.prefab_name ~= "" and arg_46_1.actors_[var_49_3.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_3.prefab_name].transform, "story_v_out_101031", "101031011", "story_v_out_101031.awb")

						arg_46_1:RecordAudio("101031011", var_49_9)
						arg_46_1:RecordAudio("101031011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_101031", "101031011", "story_v_out_101031.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_101031", "101031011", "story_v_out_101031.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_1, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_0) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_10 and arg_46_1.time_ < var_49_0 + var_49_10 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play101031012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 101031012
		arg_50_1.duration_ = 6.27

		local var_50_0 = {
			ja = 6.266,
			ko = 4.733,
			zh = 3.866,
			en = 5.2
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play101031013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["3008ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect3008ui_story == nil then
				arg_50_1.var_.characterEffect3008ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.1

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect3008ui_story and not isNil(var_53_0) then
					arg_50_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect3008ui_story then
				arg_50_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_53_4 = arg_50_1.actors_["2020_tpose"]
			local var_53_5 = 0

			if var_53_5 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 and not isNil(var_53_4) and arg_50_1.var_.characterEffect2020_tpose == nil then
				arg_50_1.var_.characterEffect2020_tpose = var_53_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_6 = 0.1

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_6 and not isNil(var_53_4) then
				local var_53_7 = (arg_50_1.time_ - var_53_5) / var_53_6

				if arg_50_1.var_.characterEffect2020_tpose and not isNil(var_53_4) then
					local var_53_8 = Mathf.Lerp(0, 0.5, var_53_7)

					arg_50_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_50_1.var_.characterEffect2020_tpose.fillRatio = var_53_8
				end
			end

			if arg_50_1.time_ >= var_53_5 + var_53_6 and arg_50_1.time_ < var_53_5 + var_53_6 + arg_53_0 and not isNil(var_53_4) and arg_50_1.var_.characterEffect2020_tpose then
				local var_53_9 = 0.5

				arg_50_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_50_1.var_.characterEffect2020_tpose.fillRatio = var_53_9
			end

			local var_53_10 = 0

			if var_53_10 < arg_50_1.time_ and arg_50_1.time_ <= var_53_10 + arg_53_0 then
				arg_50_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_1")
			end

			local var_53_11 = 0

			if var_53_11 < arg_50_1.time_ and arg_50_1.time_ <= var_53_11 + arg_53_0 then
				arg_50_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_53_12 = 0
			local var_53_13 = 0.5

			if var_53_12 < arg_50_1.time_ and arg_50_1.time_ <= var_53_12 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_14 = arg_50_1:FormatText(StoryNameCfg[20].name)

				arg_50_1.leftNameTxt_.text = var_53_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_15 = arg_50_1:GetWordFromCfg(101031012)
				local var_53_16 = arg_50_1:FormatText(var_53_15.content)

				arg_50_1.text_.text = var_53_16

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_17 = 20
				local var_53_18 = utf8.len(var_53_16)
				local var_53_19 = var_53_17 <= 0 and var_53_13 or var_53_13 * (var_53_18 / var_53_17)

				if var_53_19 > 0 and var_53_13 < var_53_19 then
					arg_50_1.talkMaxDuration = var_53_19

					if var_53_19 + var_53_12 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_19 + var_53_12
					end
				end

				arg_50_1.text_.text = var_53_16
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031012", "story_v_out_101031.awb") ~= 0 then
					local var_53_20 = manager.audio:GetVoiceLength("story_v_out_101031", "101031012", "story_v_out_101031.awb") / 1000

					if var_53_20 + var_53_12 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_20 + var_53_12
					end

					if var_53_15.prefab_name ~= "" and arg_50_1.actors_[var_53_15.prefab_name] ~= nil then
						local var_53_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_15.prefab_name].transform, "story_v_out_101031", "101031012", "story_v_out_101031.awb")

						arg_50_1:RecordAudio("101031012", var_53_21)
						arg_50_1:RecordAudio("101031012", var_53_21)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_101031", "101031012", "story_v_out_101031.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_101031", "101031012", "story_v_out_101031.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_22 = math.max(var_53_13, arg_50_1.talkMaxDuration)

			if var_53_12 <= arg_50_1.time_ and arg_50_1.time_ < var_53_12 + var_53_22 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_12) / var_53_22

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_12 + var_53_22 and arg_50_1.time_ < var_53_12 + var_53_22 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play101031013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 101031013
		arg_54_1.duration_ = 10.33

		local var_54_0 = {
			ja = 10.333,
			ko = 4.5,
			zh = 5.3,
			en = 7.133
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play101031014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["2020_tpose"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect2020_tpose == nil then
				arg_54_1.var_.characterEffect2020_tpose = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.1

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect2020_tpose and not isNil(var_57_0) then
					arg_54_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect2020_tpose then
				arg_54_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_57_4 = arg_54_1.actors_["3008ui_story"]
			local var_57_5 = 0

			if var_57_5 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.characterEffect3008ui_story == nil then
				arg_54_1.var_.characterEffect3008ui_story = var_57_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_6 = 0.1

			if var_57_5 <= arg_54_1.time_ and arg_54_1.time_ < var_57_5 + var_57_6 and not isNil(var_57_4) then
				local var_57_7 = (arg_54_1.time_ - var_57_5) / var_57_6

				if arg_54_1.var_.characterEffect3008ui_story and not isNil(var_57_4) then
					local var_57_8 = Mathf.Lerp(0, 0.5, var_57_7)

					arg_54_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_54_1.var_.characterEffect3008ui_story.fillRatio = var_57_8
				end
			end

			if arg_54_1.time_ >= var_57_5 + var_57_6 and arg_54_1.time_ < var_57_5 + var_57_6 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.characterEffect3008ui_story then
				local var_57_9 = 0.5

				arg_54_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_54_1.var_.characterEffect3008ui_story.fillRatio = var_57_9
			end

			local var_57_10 = 0
			local var_57_11 = 0.7

			if var_57_10 < arg_54_1.time_ and arg_54_1.time_ <= var_57_10 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_12 = arg_54_1:FormatText(StoryNameCfg[19].name)

				arg_54_1.leftNameTxt_.text = var_57_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_13 = arg_54_1:GetWordFromCfg(101031013)
				local var_57_14 = arg_54_1:FormatText(var_57_13.content)

				arg_54_1.text_.text = var_57_14

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_15 = 28
				local var_57_16 = utf8.len(var_57_14)
				local var_57_17 = var_57_15 <= 0 and var_57_11 or var_57_11 * (var_57_16 / var_57_15)

				if var_57_17 > 0 and var_57_11 < var_57_17 then
					arg_54_1.talkMaxDuration = var_57_17

					if var_57_17 + var_57_10 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_17 + var_57_10
					end
				end

				arg_54_1.text_.text = var_57_14
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031013", "story_v_out_101031.awb") ~= 0 then
					local var_57_18 = manager.audio:GetVoiceLength("story_v_out_101031", "101031013", "story_v_out_101031.awb") / 1000

					if var_57_18 + var_57_10 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_18 + var_57_10
					end

					if var_57_13.prefab_name ~= "" and arg_54_1.actors_[var_57_13.prefab_name] ~= nil then
						local var_57_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_13.prefab_name].transform, "story_v_out_101031", "101031013", "story_v_out_101031.awb")

						arg_54_1:RecordAudio("101031013", var_57_19)
						arg_54_1:RecordAudio("101031013", var_57_19)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_101031", "101031013", "story_v_out_101031.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_101031", "101031013", "story_v_out_101031.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_20 = math.max(var_57_11, arg_54_1.talkMaxDuration)

			if var_57_10 <= arg_54_1.time_ and arg_54_1.time_ < var_57_10 + var_57_20 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_10) / var_57_20

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_10 + var_57_20 and arg_54_1.time_ < var_57_10 + var_57_20 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play101031014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 101031014
		arg_58_1.duration_ = 2.47

		local var_58_0 = {
			ja = 2.466,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play101031015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["3008ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect3008ui_story == nil then
				arg_58_1.var_.characterEffect3008ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.1

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect3008ui_story and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect3008ui_story then
				arg_58_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_61_4 = arg_58_1.actors_["2020_tpose"]
			local var_61_5 = 0

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect2020_tpose == nil then
				arg_58_1.var_.characterEffect2020_tpose = var_61_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_6 = 0.1

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_6 and not isNil(var_61_4) then
				local var_61_7 = (arg_58_1.time_ - var_61_5) / var_61_6

				if arg_58_1.var_.characterEffect2020_tpose and not isNil(var_61_4) then
					local var_61_8 = Mathf.Lerp(0, 0.5, var_61_7)

					arg_58_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_58_1.var_.characterEffect2020_tpose.fillRatio = var_61_8
				end
			end

			if arg_58_1.time_ >= var_61_5 + var_61_6 and arg_58_1.time_ < var_61_5 + var_61_6 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect2020_tpose then
				local var_61_9 = 0.5

				arg_58_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_58_1.var_.characterEffect2020_tpose.fillRatio = var_61_9
			end

			local var_61_10 = 0

			if var_61_10 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 then
				arg_58_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_2")
			end

			local var_61_11 = 0

			if var_61_11 < arg_58_1.time_ and arg_58_1.time_ <= var_61_11 + arg_61_0 then
				arg_58_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_61_12 = 0
			local var_61_13 = 0.1

			if var_61_12 < arg_58_1.time_ and arg_58_1.time_ <= var_61_12 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_14 = arg_58_1:FormatText(StoryNameCfg[20].name)

				arg_58_1.leftNameTxt_.text = var_61_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_15 = arg_58_1:GetWordFromCfg(101031014)
				local var_61_16 = arg_58_1:FormatText(var_61_15.content)

				arg_58_1.text_.text = var_61_16

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_17 = 4
				local var_61_18 = utf8.len(var_61_16)
				local var_61_19 = var_61_17 <= 0 and var_61_13 or var_61_13 * (var_61_18 / var_61_17)

				if var_61_19 > 0 and var_61_13 < var_61_19 then
					arg_58_1.talkMaxDuration = var_61_19

					if var_61_19 + var_61_12 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_19 + var_61_12
					end
				end

				arg_58_1.text_.text = var_61_16
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031014", "story_v_out_101031.awb") ~= 0 then
					local var_61_20 = manager.audio:GetVoiceLength("story_v_out_101031", "101031014", "story_v_out_101031.awb") / 1000

					if var_61_20 + var_61_12 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_20 + var_61_12
					end

					if var_61_15.prefab_name ~= "" and arg_58_1.actors_[var_61_15.prefab_name] ~= nil then
						local var_61_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_15.prefab_name].transform, "story_v_out_101031", "101031014", "story_v_out_101031.awb")

						arg_58_1:RecordAudio("101031014", var_61_21)
						arg_58_1:RecordAudio("101031014", var_61_21)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_101031", "101031014", "story_v_out_101031.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_101031", "101031014", "story_v_out_101031.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_22 = math.max(var_61_13, arg_58_1.talkMaxDuration)

			if var_61_12 <= arg_58_1.time_ and arg_58_1.time_ < var_61_12 + var_61_22 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_12) / var_61_22

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_12 + var_61_22 and arg_58_1.time_ < var_61_12 + var_61_22 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play101031015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 101031015
		arg_62_1.duration_ = 9.7

		local var_62_0 = {
			ja = 9.7,
			ko = 7.6,
			zh = 7.233,
			en = 8.2
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play101031016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["2020_tpose"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect2020_tpose == nil then
				arg_62_1.var_.characterEffect2020_tpose = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.1

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect2020_tpose and not isNil(var_65_0) then
					arg_62_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect2020_tpose then
				arg_62_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_65_4 = arg_62_1.actors_["3008ui_story"]
			local var_65_5 = 0

			if var_65_5 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect3008ui_story == nil then
				arg_62_1.var_.characterEffect3008ui_story = var_65_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_6 = 0.1

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_6 and not isNil(var_65_4) then
				local var_65_7 = (arg_62_1.time_ - var_65_5) / var_65_6

				if arg_62_1.var_.characterEffect3008ui_story and not isNil(var_65_4) then
					local var_65_8 = Mathf.Lerp(0, 0.5, var_65_7)

					arg_62_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_62_1.var_.characterEffect3008ui_story.fillRatio = var_65_8
				end
			end

			if arg_62_1.time_ >= var_65_5 + var_65_6 and arg_62_1.time_ < var_65_5 + var_65_6 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect3008ui_story then
				local var_65_9 = 0.5

				arg_62_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_62_1.var_.characterEffect3008ui_story.fillRatio = var_65_9
			end

			local var_65_10 = 0
			local var_65_11 = 0.95

			if var_65_10 < arg_62_1.time_ and arg_62_1.time_ <= var_65_10 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_12 = arg_62_1:FormatText(StoryNameCfg[19].name)

				arg_62_1.leftNameTxt_.text = var_65_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_13 = arg_62_1:GetWordFromCfg(101031015)
				local var_65_14 = arg_62_1:FormatText(var_65_13.content)

				arg_62_1.text_.text = var_65_14

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_15 = 38
				local var_65_16 = utf8.len(var_65_14)
				local var_65_17 = var_65_15 <= 0 and var_65_11 or var_65_11 * (var_65_16 / var_65_15)

				if var_65_17 > 0 and var_65_11 < var_65_17 then
					arg_62_1.talkMaxDuration = var_65_17

					if var_65_17 + var_65_10 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_17 + var_65_10
					end
				end

				arg_62_1.text_.text = var_65_14
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031015", "story_v_out_101031.awb") ~= 0 then
					local var_65_18 = manager.audio:GetVoiceLength("story_v_out_101031", "101031015", "story_v_out_101031.awb") / 1000

					if var_65_18 + var_65_10 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_18 + var_65_10
					end

					if var_65_13.prefab_name ~= "" and arg_62_1.actors_[var_65_13.prefab_name] ~= nil then
						local var_65_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_13.prefab_name].transform, "story_v_out_101031", "101031015", "story_v_out_101031.awb")

						arg_62_1:RecordAudio("101031015", var_65_19)
						arg_62_1:RecordAudio("101031015", var_65_19)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_101031", "101031015", "story_v_out_101031.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_101031", "101031015", "story_v_out_101031.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_20 = math.max(var_65_11, arg_62_1.talkMaxDuration)

			if var_65_10 <= arg_62_1.time_ and arg_62_1.time_ < var_65_10 + var_65_20 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_10) / var_65_20

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_10 + var_65_20 and arg_62_1.time_ < var_65_10 + var_65_20 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play101031016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 101031016
		arg_66_1.duration_ = 6.13

		local var_66_0 = {
			ja = 6.133,
			ko = 3.8,
			zh = 3.766,
			en = 4.666
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
			arg_66_1.auto_ = false
		end

		function arg_66_1.playNext_(arg_68_0)
			arg_66_1.onStoryFinished_()
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["3008ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect3008ui_story == nil then
				arg_66_1.var_.characterEffect3008ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.1

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect3008ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect3008ui_story then
				arg_66_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_69_4 = arg_66_1.actors_["2020_tpose"]
			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect2020_tpose == nil then
				arg_66_1.var_.characterEffect2020_tpose = var_69_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_6 = 0.1

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_6 and not isNil(var_69_4) then
				local var_69_7 = (arg_66_1.time_ - var_69_5) / var_69_6

				if arg_66_1.var_.characterEffect2020_tpose and not isNil(var_69_4) then
					local var_69_8 = Mathf.Lerp(0, 0.5, var_69_7)

					arg_66_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_66_1.var_.characterEffect2020_tpose.fillRatio = var_69_8
				end
			end

			if arg_66_1.time_ >= var_69_5 + var_69_6 and arg_66_1.time_ < var_69_5 + var_69_6 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect2020_tpose then
				local var_69_9 = 0.5

				arg_66_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_66_1.var_.characterEffect2020_tpose.fillRatio = var_69_9
			end

			local var_69_10 = 0

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			local var_69_11 = 0

			if var_69_11 < arg_66_1.time_ and arg_66_1.time_ <= var_69_11 + arg_69_0 then
				arg_66_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_69_12 = 0
			local var_69_13 = 0.475

			if var_69_12 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_14 = arg_66_1:FormatText(StoryNameCfg[20].name)

				arg_66_1.leftNameTxt_.text = var_69_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_15 = arg_66_1:GetWordFromCfg(101031016)
				local var_69_16 = arg_66_1:FormatText(var_69_15.content)

				arg_66_1.text_.text = var_69_16

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_17 = 19
				local var_69_18 = utf8.len(var_69_16)
				local var_69_19 = var_69_17 <= 0 and var_69_13 or var_69_13 * (var_69_18 / var_69_17)

				if var_69_19 > 0 and var_69_13 < var_69_19 then
					arg_66_1.talkMaxDuration = var_69_19

					if var_69_19 + var_69_12 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_19 + var_69_12
					end
				end

				arg_66_1.text_.text = var_69_16
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031016", "story_v_out_101031.awb") ~= 0 then
					local var_69_20 = manager.audio:GetVoiceLength("story_v_out_101031", "101031016", "story_v_out_101031.awb") / 1000

					if var_69_20 + var_69_12 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_20 + var_69_12
					end

					if var_69_15.prefab_name ~= "" and arg_66_1.actors_[var_69_15.prefab_name] ~= nil then
						local var_69_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_15.prefab_name].transform, "story_v_out_101031", "101031016", "story_v_out_101031.awb")

						arg_66_1:RecordAudio("101031016", var_69_21)
						arg_66_1:RecordAudio("101031016", var_69_21)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_101031", "101031016", "story_v_out_101031.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_101031", "101031016", "story_v_out_101031.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_22 = math.max(var_69_13, arg_66_1.talkMaxDuration)

			if var_69_12 <= arg_66_1.time_ and arg_66_1.time_ < var_69_12 + var_69_22 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_12) / var_69_22

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_12 + var_69_22 and arg_66_1.time_ < var_69_12 + var_69_22 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10a"
	},
	voices = {
		"story_v_out_101031.awb"
	}
}
