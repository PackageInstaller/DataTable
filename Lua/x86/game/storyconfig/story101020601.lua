return {
	Play102061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 102061001
		arg_1_1.duration_ = 8

		local var_1_0 = {
			ja = 8,
			ko = 5.233,
			zh = 6.5,
			en = 4.933
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
				arg_1_0:Play102061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_10 = 0
			local var_4_11 = 1

			if var_4_10 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				local var_4_12 = "play"
				local var_4_13 = "effect"

				arg_1_1:AudioAction(var_4_12, var_4_13, "se_story", "se_story_robot_broken", "")
			end

			local var_4_14 = "2025_tpose"

			if arg_1_1.actors_[var_4_14] == nil then
				local var_4_15 = Asset.Load("Char/" .. "2025_tpose")

				if not isNil(var_4_15) then
					local var_4_16 = Object.Instantiate(Asset.Load("Char/" .. "2025_tpose"), arg_1_1.stage_.transform)

					var_4_16.name = var_4_14
					var_4_16.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_14] = var_4_16

					local var_4_17 = var_4_16:GetComponentInChildren(typeof(CharacterEffect))

					var_4_17.enabled = true

					local var_4_18 = GameObjectTools.GetOrAddComponent(var_4_16, typeof(DynamicBoneHelper))

					if var_4_18 then
						var_4_18:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_17.transform, false)

					arg_1_1.var_[var_4_14 .. "Animator"] = var_4_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_14 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_14 .. "LipSync"] = var_4_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_19 = arg_1_1.actors_["2025_tpose"]
			local var_4_20 = 2

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 and not isNil(var_4_19) and arg_1_1.var_.characterEffect2025_tpose == nil then
				arg_1_1.var_.characterEffect2025_tpose = var_4_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_21 = 0.1

			if var_4_20 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 and not isNil(var_4_19) then
				local var_4_22 = (arg_1_1.time_ - var_4_20) / var_4_21

				if arg_1_1.var_.characterEffect2025_tpose and not isNil(var_4_19) then
					arg_1_1.var_.characterEffect2025_tpose.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 and not isNil(var_4_19) and arg_1_1.var_.characterEffect2025_tpose then
				arg_1_1.var_.characterEffect2025_tpose.fillFlat = false
			end

			local var_4_23 = "B02a"

			if arg_1_1.bgs_[var_4_23] == nil then
				local var_4_24 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_24:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_23)
				var_4_24.name = var_4_23
				var_4_24.transform.parent = arg_1_1.stage_.transform
				var_4_24.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_23] = var_4_24
			end

			local var_4_25 = arg_1_1.bgs_.B02a
			local var_4_26 = 0

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_27 = var_4_25:GetComponent("SpriteRenderer")

				if var_4_27 then
					arg_1_1.var_.alphaOldValueB02a = var_4_27.color.a
					arg_1_1.var_.alphaMatValueB02a = var_4_27
				end

				arg_1_1.var_.alphaOldValueB02a = 0
			end

			local var_4_28 = 1.5

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_28 then
				local var_4_29 = (arg_1_1.time_ - var_4_26) / var_4_28
				local var_4_30 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB02a, 1, var_4_29)

				if arg_1_1.var_.alphaMatValueB02a then
					local var_4_31 = arg_1_1.var_.alphaMatValueB02a.color

					var_4_31.a = var_4_30
					arg_1_1.var_.alphaMatValueB02a.color = var_4_31
				end
			end

			if arg_1_1.time_ >= var_4_26 + var_4_28 and arg_1_1.time_ < var_4_26 + var_4_28 + arg_4_0 and arg_1_1.var_.alphaMatValueB02a then
				local var_4_32 = arg_1_1.var_.alphaMatValueB02a
				local var_4_33 = var_4_32.color

				var_4_33.a = 1
				var_4_32.color = var_4_33
			end

			local var_4_34 = 0

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_35 = manager.ui.mainCamera.transform.localPosition
				local var_4_36 = Vector3.New(0, 0, 10) + Vector3.New(var_4_35.x, var_4_35.y, 0)
				local var_4_37 = arg_1_1.bgs_.B02a

				var_4_37.transform.localPosition = var_4_36
				var_4_37.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_38 = var_4_37:GetComponent("SpriteRenderer")

				if var_4_38 and var_4_38.sprite then
					local var_4_39 = (var_4_37.transform.localPosition - var_4_35).z
					local var_4_40 = manager.ui.mainCameraCom_
					local var_4_41 = 2 * var_4_39 * Mathf.Tan(var_4_40.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_42 = var_4_41 * var_4_40.aspect
					local var_4_43 = var_4_38.sprite.bounds.size.x
					local var_4_44 = var_4_38.sprite.bounds.size.y
					local var_4_45 = var_4_42 / var_4_43
					local var_4_46 = var_4_41 / var_4_44
					local var_4_47 = var_4_46 < var_4_45 and var_4_45 or var_4_46

					var_4_37.transform.localScale = Vector3.New(var_4_47, var_4_47, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B02a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_48 = arg_1_1.actors_["2025_tpose"].transform
			local var_4_49 = 1.79999995231628

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.var_.moveOldPos2025_tpose = var_4_48.localPosition

				local var_4_50 = GameObjectTools.GetOrAddComponent(var_4_48.gameObject, typeof(DynamicBoneHelper))

				if var_4_50 then
					var_4_50:EnableDynamicBone(false)
				end
			end

			local var_4_51 = 0.001

			if var_4_49 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_51 then
				local var_4_52 = (arg_1_1.time_ - var_4_49) / var_4_51
				local var_4_53 = Vector3.New(0, -1.42, -4.3)

				var_4_48.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2025_tpose, var_4_53, var_4_52)

				local var_4_54 = manager.ui.mainCamera.transform.position - var_4_48.position

				var_4_48.forward = Vector3.New(var_4_54.x, var_4_54.y, var_4_54.z)

				local var_4_55 = var_4_48.localEulerAngles

				var_4_55.z = 0
				var_4_55.x = 0
				var_4_48.localEulerAngles = var_4_55
			end

			if arg_1_1.time_ >= var_4_49 + var_4_51 and arg_1_1.time_ < var_4_49 + var_4_51 + arg_4_0 then
				var_4_48.localPosition = Vector3.New(0, -1.42, -4.3)

				local var_4_56 = manager.ui.mainCamera.transform.position - var_4_48.position

				var_4_48.forward = Vector3.New(var_4_56.x, var_4_56.y, var_4_56.z)

				local var_4_57 = var_4_48.localEulerAngles

				var_4_57.z = 0
				var_4_57.x = 0
				var_4_48.localEulerAngles = var_4_57

				local var_4_58 = GameObjectTools.GetOrAddComponent(var_4_48.gameObject, typeof(DynamicBoneHelper))

				if var_4_58 then
					var_4_58:EnableDynamicBone(true)
				end
			end

			local var_4_59 = 0

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				arg_1_1:PlayTimeline("2025_tpose", "StoryTimeline/CharAction/story2025/story2025action/2025action1_1")
			end

			local var_4_60 = 0

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_61 = 2

			if arg_1_1.time_ >= var_4_60 + var_4_61 and arg_1_1.time_ < var_4_60 + var_4_61 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_62 = 2
			local var_4_63 = 0.25

			if var_4_62 < arg_1_1.time_ and arg_1_1.time_ <= var_4_62 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_64 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_64:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_65 = arg_1_1:FormatText(StoryNameCfg[29].name)

				arg_1_1.leftNameTxt_.text = var_4_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_66 = arg_1_1:GetWordFromCfg(102061001)
				local var_4_67 = arg_1_1:FormatText(var_4_66.content)

				arg_1_1.text_.text = var_4_67

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_68 = 10
				local var_4_69 = utf8.len(var_4_67)
				local var_4_70 = var_4_68 <= 0 and var_4_63 or var_4_63 * (var_4_69 / var_4_68)

				if var_4_70 > 0 and var_4_63 < var_4_70 then
					arg_1_1.talkMaxDuration = var_4_70
					var_4_62 = var_4_62 + 0.3

					if var_4_70 + var_4_62 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_62
					end
				end

				arg_1_1.text_.text = var_4_67
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061001", "story_v_out_102061.awb") ~= 0 then
					local var_4_71 = manager.audio:GetVoiceLength("story_v_out_102061", "102061001", "story_v_out_102061.awb") / 1000

					if var_4_71 + var_4_62 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_71 + var_4_62
					end

					if var_4_66.prefab_name ~= "" and arg_1_1.actors_[var_4_66.prefab_name] ~= nil then
						local var_4_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_66.prefab_name].transform, "story_v_out_102061", "102061001", "story_v_out_102061.awb")

						arg_1_1:RecordAudio("102061001", var_4_72)
						arg_1_1:RecordAudio("102061001", var_4_72)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_102061", "102061001", "story_v_out_102061.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_102061", "102061001", "story_v_out_102061.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_73 = var_4_62 + 0.3
			local var_4_74 = math.max(var_4_63, arg_1_1.talkMaxDuration)

			if var_4_73 <= arg_1_1.time_ and arg_1_1.time_ < var_4_73 + var_4_74 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_73) / var_4_74

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_73 + var_4_74 and arg_1_1.time_ < var_4_73 + var_4_74 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2025_tpose",
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
	Play102061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 102061002
		arg_8_1.duration_ = 5.53

		local var_8_0 = {
			ja = 4.266,
			ko = 4.733,
			zh = 5.533,
			en = 2.966
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
				arg_8_0:Play102061003(arg_8_1)
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

			local var_11_4 = 0
			local var_11_5 = 0.325

			if var_11_4 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_6 = arg_8_1:FormatText(StoryNameCfg[29].name)

				arg_8_1.leftNameTxt_.text = var_11_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_7 = arg_8_1:GetWordFromCfg(102061002)
				local var_11_8 = arg_8_1:FormatText(var_11_7.content)

				arg_8_1.text_.text = var_11_8

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_9 = 13
				local var_11_10 = utf8.len(var_11_8)
				local var_11_11 = var_11_9 <= 0 and var_11_5 or var_11_5 * (var_11_10 / var_11_9)

				if var_11_11 > 0 and var_11_5 < var_11_11 then
					arg_8_1.talkMaxDuration = var_11_11

					if var_11_11 + var_11_4 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_11 + var_11_4
					end
				end

				arg_8_1.text_.text = var_11_8
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061002", "story_v_out_102061.awb") ~= 0 then
					local var_11_12 = manager.audio:GetVoiceLength("story_v_out_102061", "102061002", "story_v_out_102061.awb") / 1000

					if var_11_12 + var_11_4 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_12 + var_11_4
					end

					if var_11_7.prefab_name ~= "" and arg_8_1.actors_[var_11_7.prefab_name] ~= nil then
						local var_11_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_7.prefab_name].transform, "story_v_out_102061", "102061002", "story_v_out_102061.awb")

						arg_8_1:RecordAudio("102061002", var_11_13)
						arg_8_1:RecordAudio("102061002", var_11_13)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_102061", "102061002", "story_v_out_102061.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_102061", "102061002", "story_v_out_102061.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_14 = math.max(var_11_5, arg_8_1.talkMaxDuration)

			if var_11_4 <= arg_8_1.time_ and arg_8_1.time_ < var_11_4 + var_11_14 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_4) / var_11_14

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_4 + var_11_14 and arg_8_1.time_ < var_11_4 + var_11_14 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play102061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 102061003
		arg_12_1.duration_ = 6.97

		local var_12_0 = {
			ja = 6.9,
			ko = 5.833,
			zh = 6.733,
			en = 6.966
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
				arg_12_0:Play102061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1084ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_12_1.stage_.transform)

					var_15_2.name = var_15_0
					var_15_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_0] = var_15_2

					local var_15_3 = var_15_2:GetComponentInChildren(typeof(CharacterEffect))

					var_15_3.enabled = true

					local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_2, typeof(DynamicBoneHelper))

					if var_15_4 then
						var_15_4:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_3.transform, false)

					arg_12_1.var_[var_15_0 .. "Animator"] = var_15_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_0 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_0 .. "LipSync"] = var_15_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_5 = arg_12_1.actors_["1084ui_story"]
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.1

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 and not isNil(var_15_5) then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7

				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_15_9 = arg_12_1.actors_["2025_tpose"]
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect2025_tpose == nil then
				arg_12_1.var_.characterEffect2025_tpose = var_15_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_11 = 0.1

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 and not isNil(var_15_9) then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11

				if arg_12_1.var_.characterEffect2025_tpose and not isNil(var_15_9) then
					local var_15_13 = Mathf.Lerp(0, 0.5, var_15_12)

					arg_12_1.var_.characterEffect2025_tpose.fillFlat = true
					arg_12_1.var_.characterEffect2025_tpose.fillRatio = var_15_13
				end
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect2025_tpose then
				local var_15_14 = 0.5

				arg_12_1.var_.characterEffect2025_tpose.fillFlat = true
				arg_12_1.var_.characterEffect2025_tpose.fillRatio = var_15_14
			end

			local var_15_15 = arg_12_1.actors_["2025_tpose"].transform
			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1.var_.moveOldPos2025_tpose = var_15_15.localPosition

				local var_15_17 = GameObjectTools.GetOrAddComponent(var_15_15.gameObject, typeof(DynamicBoneHelper))

				if var_15_17 then
					var_15_17:EnableDynamicBone(false)
				end
			end

			local var_15_18 = 0.001

			if var_15_16 <= arg_12_1.time_ and arg_12_1.time_ < var_15_16 + var_15_18 then
				local var_15_19 = (arg_12_1.time_ - var_15_16) / var_15_18
				local var_15_20 = Vector3.New(0, 100, 0)

				var_15_15.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos2025_tpose, var_15_20, var_15_19)

				local var_15_21 = manager.ui.mainCamera.transform.position - var_15_15.position

				var_15_15.forward = Vector3.New(var_15_21.x, var_15_21.y, var_15_21.z)

				local var_15_22 = var_15_15.localEulerAngles

				var_15_22.z = 0
				var_15_22.x = 0
				var_15_15.localEulerAngles = var_15_22
			end

			if arg_12_1.time_ >= var_15_16 + var_15_18 and arg_12_1.time_ < var_15_16 + var_15_18 + arg_15_0 then
				var_15_15.localPosition = Vector3.New(0, 100, 0)

				local var_15_23 = manager.ui.mainCamera.transform.position - var_15_15.position

				var_15_15.forward = Vector3.New(var_15_23.x, var_15_23.y, var_15_23.z)

				local var_15_24 = var_15_15.localEulerAngles

				var_15_24.z = 0
				var_15_24.x = 0
				var_15_15.localEulerAngles = var_15_24

				local var_15_25 = GameObjectTools.GetOrAddComponent(var_15_15.gameObject, typeof(DynamicBoneHelper))

				if var_15_25 then
					var_15_25:EnableDynamicBone(true)
				end
			end

			local var_15_26 = arg_12_1.actors_["1084ui_story"].transform
			local var_15_27 = 0

			if var_15_27 < arg_12_1.time_ and arg_12_1.time_ <= var_15_27 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_26.localPosition
			end

			local var_15_28 = 0.001

			if var_15_27 <= arg_12_1.time_ and arg_12_1.time_ < var_15_27 + var_15_28 then
				local var_15_29 = (arg_12_1.time_ - var_15_27) / var_15_28
				local var_15_30 = Vector3.New(-0.7, -0.97, -6)

				var_15_26.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, var_15_30, var_15_29)

				local var_15_31 = manager.ui.mainCamera.transform.position - var_15_26.position

				var_15_26.forward = Vector3.New(var_15_31.x, var_15_31.y, var_15_31.z)

				local var_15_32 = var_15_26.localEulerAngles

				var_15_32.z = 0
				var_15_32.x = 0
				var_15_26.localEulerAngles = var_15_32
			end

			if arg_12_1.time_ >= var_15_27 + var_15_28 and arg_12_1.time_ < var_15_27 + var_15_28 + arg_15_0 then
				var_15_26.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_15_33 = manager.ui.mainCamera.transform.position - var_15_26.position

				var_15_26.forward = Vector3.New(var_15_33.x, var_15_33.y, var_15_33.z)

				local var_15_34 = var_15_26.localEulerAngles

				var_15_34.z = 0
				var_15_34.x = 0
				var_15_26.localEulerAngles = var_15_34
			end

			local var_15_35 = 0

			if var_15_35 < arg_12_1.time_ and arg_12_1.time_ <= var_15_35 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_15_36 = 0

			if var_15_36 < arg_12_1.time_ and arg_12_1.time_ <= var_15_36 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_15_37 = 0
			local var_15_38 = 0.7

			if var_15_37 < arg_12_1.time_ and arg_12_1.time_ <= var_15_37 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_39 = arg_12_1:FormatText(StoryNameCfg[6].name)

				arg_12_1.leftNameTxt_.text = var_15_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_40 = arg_12_1:GetWordFromCfg(102061003)
				local var_15_41 = arg_12_1:FormatText(var_15_40.content)

				arg_12_1.text_.text = var_15_41

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_42 = 27
				local var_15_43 = utf8.len(var_15_41)
				local var_15_44 = var_15_42 <= 0 and var_15_38 or var_15_38 * (var_15_43 / var_15_42)

				if var_15_44 > 0 and var_15_38 < var_15_44 then
					arg_12_1.talkMaxDuration = var_15_44

					if var_15_44 + var_15_37 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_44 + var_15_37
					end
				end

				arg_12_1.text_.text = var_15_41
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061003", "story_v_out_102061.awb") ~= 0 then
					local var_15_45 = manager.audio:GetVoiceLength("story_v_out_102061", "102061003", "story_v_out_102061.awb") / 1000

					if var_15_45 + var_15_37 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_45 + var_15_37
					end

					if var_15_40.prefab_name ~= "" and arg_12_1.actors_[var_15_40.prefab_name] ~= nil then
						local var_15_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_40.prefab_name].transform, "story_v_out_102061", "102061003", "story_v_out_102061.awb")

						arg_12_1:RecordAudio("102061003", var_15_46)
						arg_12_1:RecordAudio("102061003", var_15_46)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_102061", "102061003", "story_v_out_102061.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_102061", "102061003", "story_v_out_102061.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_47 = math.max(var_15_38, arg_12_1.talkMaxDuration)

			if var_15_37 <= arg_12_1.time_ and arg_12_1.time_ < var_15_37 + var_15_47 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_37) / var_15_47

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_37 + var_15_47 and arg_12_1.time_ < var_15_37 + var_15_47 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2025_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play102061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 102061004
		arg_16_1.duration_ = 10.23

		local var_16_0 = {
			ja = 10.233,
			ko = 5.6,
			zh = 6.133,
			en = 9
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
				arg_16_0:Play102061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1019ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["1019ui_story"]
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1019ui_story == nil then
				arg_16_1.var_.characterEffect1019ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 and not isNil(var_19_5) then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7

				if arg_16_1.var_.characterEffect1019ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1019ui_story then
				arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_19_9 = arg_16_1.actors_["1084ui_story"]
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_11 = 0.1

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 and not isNil(var_19_9) then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_9) then
					local var_19_13 = Mathf.Lerp(0, 0.5, var_19_12)

					arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_13
				end
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1084ui_story then
				local var_19_14 = 0.5

				arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_14
			end

			local var_19_15 = arg_16_1.actors_["1019ui_story"].transform
			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.var_.moveOldPos1019ui_story = var_19_15.localPosition
			end

			local var_19_17 = 0.001

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_17 then
				local var_19_18 = (arg_16_1.time_ - var_19_16) / var_19_17
				local var_19_19 = Vector3.New(0.7, -1.08, -5.9)

				var_19_15.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1019ui_story, var_19_19, var_19_18)

				local var_19_20 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_20.x, var_19_20.y, var_19_20.z)

				local var_19_21 = var_19_15.localEulerAngles

				var_19_21.z = 0
				var_19_21.x = 0
				var_19_15.localEulerAngles = var_19_21
			end

			if arg_16_1.time_ >= var_19_16 + var_19_17 and arg_16_1.time_ < var_19_16 + var_19_17 + arg_19_0 then
				var_19_15.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_19_22 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_22.x, var_19_22.y, var_19_22.z)

				local var_19_23 = var_19_15.localEulerAngles

				var_19_23.z = 0
				var_19_23.x = 0
				var_19_15.localEulerAngles = var_19_23
			end

			local var_19_24 = 0

			if var_19_24 < arg_16_1.time_ and arg_16_1.time_ <= var_19_24 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_19_25 = 0

			if var_19_25 < arg_16_1.time_ and arg_16_1.time_ <= var_19_25 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_19_26 = 0
			local var_19_27 = 0.8

			if var_19_26 < arg_16_1.time_ and arg_16_1.time_ <= var_19_26 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_28 = arg_16_1:FormatText(StoryNameCfg[13].name)

				arg_16_1.leftNameTxt_.text = var_19_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_29 = arg_16_1:GetWordFromCfg(102061004)
				local var_19_30 = arg_16_1:FormatText(var_19_29.content)

				arg_16_1.text_.text = var_19_30

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_31 = 32
				local var_19_32 = utf8.len(var_19_30)
				local var_19_33 = var_19_31 <= 0 and var_19_27 or var_19_27 * (var_19_32 / var_19_31)

				if var_19_33 > 0 and var_19_27 < var_19_33 then
					arg_16_1.talkMaxDuration = var_19_33

					if var_19_33 + var_19_26 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_33 + var_19_26
					end
				end

				arg_16_1.text_.text = var_19_30
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061004", "story_v_out_102061.awb") ~= 0 then
					local var_19_34 = manager.audio:GetVoiceLength("story_v_out_102061", "102061004", "story_v_out_102061.awb") / 1000

					if var_19_34 + var_19_26 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_34 + var_19_26
					end

					if var_19_29.prefab_name ~= "" and arg_16_1.actors_[var_19_29.prefab_name] ~= nil then
						local var_19_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_29.prefab_name].transform, "story_v_out_102061", "102061004", "story_v_out_102061.awb")

						arg_16_1:RecordAudio("102061004", var_19_35)
						arg_16_1:RecordAudio("102061004", var_19_35)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_102061", "102061004", "story_v_out_102061.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_102061", "102061004", "story_v_out_102061.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_36 = math.max(var_19_27, arg_16_1.talkMaxDuration)

			if var_19_26 <= arg_16_1.time_ and arg_16_1.time_ < var_19_26 + var_19_36 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_26) / var_19_36

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_26 + var_19_36 and arg_16_1.time_ < var_19_26 + var_19_36 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play102061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 102061005
		arg_20_1.duration_ = 4.6

		local var_20_0 = {
			ja = 4.6,
			ko = 3.7,
			zh = 3.8,
			en = 3.133
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play102061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action452")
			end

			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_23_2 = 0
			local var_23_3 = 0.425

			if var_23_2 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_4 = arg_20_1:FormatText(StoryNameCfg[13].name)

				arg_20_1.leftNameTxt_.text = var_23_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_5 = arg_20_1:GetWordFromCfg(102061005)
				local var_23_6 = arg_20_1:FormatText(var_23_5.content)

				arg_20_1.text_.text = var_23_6

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_7 = 17
				local var_23_8 = utf8.len(var_23_6)
				local var_23_9 = var_23_7 <= 0 and var_23_3 or var_23_3 * (var_23_8 / var_23_7)

				if var_23_9 > 0 and var_23_3 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_2
					end
				end

				arg_20_1.text_.text = var_23_6
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061005", "story_v_out_102061.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_102061", "102061005", "story_v_out_102061.awb") / 1000

					if var_23_10 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_2
					end

					if var_23_5.prefab_name ~= "" and arg_20_1.actors_[var_23_5.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_5.prefab_name].transform, "story_v_out_102061", "102061005", "story_v_out_102061.awb")

						arg_20_1:RecordAudio("102061005", var_23_11)
						arg_20_1:RecordAudio("102061005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_102061", "102061005", "story_v_out_102061.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_102061", "102061005", "story_v_out_102061.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_3, arg_20_1.talkMaxDuration)

			if var_23_2 <= arg_20_1.time_ and arg_20_1.time_ < var_23_2 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_2) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_2 + var_23_12 and arg_20_1.time_ < var_23_2 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play102061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 102061006
		arg_24_1.duration_ = 6.37

		local var_24_0 = {
			ja = 6.366,
			ko = 5.6,
			zh = 5.8,
			en = 6
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
				arg_24_0:Play102061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "3008ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = arg_24_1.actors_["3008ui_story"]
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect3008ui_story == nil then
				arg_24_1.var_.characterEffect3008ui_story = var_27_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_7 = 0.1

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 and not isNil(var_27_5) then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7

				if arg_24_1.var_.characterEffect3008ui_story and not isNil(var_27_5) then
					arg_24_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect3008ui_story then
				arg_24_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_27_9 = arg_24_1.actors_["1019ui_story"]
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_11 = 0.1

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 and not isNil(var_27_9) then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11

				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_9) then
					local var_27_13 = Mathf.Lerp(0, 0.5, var_27_12)

					arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1019ui_story.fillRatio = var_27_13
				end
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1019ui_story then
				local var_27_14 = 0.5

				arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1019ui_story.fillRatio = var_27_14
			end

			local var_27_15 = arg_24_1.actors_["1019ui_story"].transform
			local var_27_16 = 0

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.var_.moveOldPos1019ui_story = var_27_15.localPosition
			end

			local var_27_17 = 0.001

			if var_27_16 <= arg_24_1.time_ and arg_24_1.time_ < var_27_16 + var_27_17 then
				local var_27_18 = (arg_24_1.time_ - var_27_16) / var_27_17
				local var_27_19 = Vector3.New(0, 100, 0)

				var_27_15.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1019ui_story, var_27_19, var_27_18)

				local var_27_20 = manager.ui.mainCamera.transform.position - var_27_15.position

				var_27_15.forward = Vector3.New(var_27_20.x, var_27_20.y, var_27_20.z)

				local var_27_21 = var_27_15.localEulerAngles

				var_27_21.z = 0
				var_27_21.x = 0
				var_27_15.localEulerAngles = var_27_21
			end

			if arg_24_1.time_ >= var_27_16 + var_27_17 and arg_24_1.time_ < var_27_16 + var_27_17 + arg_27_0 then
				var_27_15.localPosition = Vector3.New(0, 100, 0)

				local var_27_22 = manager.ui.mainCamera.transform.position - var_27_15.position

				var_27_15.forward = Vector3.New(var_27_22.x, var_27_22.y, var_27_22.z)

				local var_27_23 = var_27_15.localEulerAngles

				var_27_23.z = 0
				var_27_23.x = 0
				var_27_15.localEulerAngles = var_27_23
			end

			local var_27_24 = arg_24_1.actors_["1084ui_story"].transform
			local var_27_25 = 0

			if var_27_25 < arg_24_1.time_ and arg_24_1.time_ <= var_27_25 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = var_27_24.localPosition
			end

			local var_27_26 = 0.001

			if var_27_25 <= arg_24_1.time_ and arg_24_1.time_ < var_27_25 + var_27_26 then
				local var_27_27 = (arg_24_1.time_ - var_27_25) / var_27_26
				local var_27_28 = Vector3.New(0, 100, 0)

				var_27_24.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, var_27_28, var_27_27)

				local var_27_29 = manager.ui.mainCamera.transform.position - var_27_24.position

				var_27_24.forward = Vector3.New(var_27_29.x, var_27_29.y, var_27_29.z)

				local var_27_30 = var_27_24.localEulerAngles

				var_27_30.z = 0
				var_27_30.x = 0
				var_27_24.localEulerAngles = var_27_30
			end

			if arg_24_1.time_ >= var_27_25 + var_27_26 and arg_24_1.time_ < var_27_25 + var_27_26 + arg_27_0 then
				var_27_24.localPosition = Vector3.New(0, 100, 0)

				local var_27_31 = manager.ui.mainCamera.transform.position - var_27_24.position

				var_27_24.forward = Vector3.New(var_27_31.x, var_27_31.y, var_27_31.z)

				local var_27_32 = var_27_24.localEulerAngles

				var_27_32.z = 0
				var_27_32.x = 0
				var_27_24.localEulerAngles = var_27_32
			end

			local var_27_33 = arg_24_1.actors_["3008ui_story"].transform
			local var_27_34 = 0

			if var_27_34 < arg_24_1.time_ and arg_24_1.time_ <= var_27_34 + arg_27_0 then
				arg_24_1.var_.moveOldPos3008ui_story = var_27_33.localPosition
			end

			local var_27_35 = 0.001

			if var_27_34 <= arg_24_1.time_ and arg_24_1.time_ < var_27_34 + var_27_35 then
				local var_27_36 = (arg_24_1.time_ - var_27_34) / var_27_35
				local var_27_37 = Vector3.New(0, -1.51, -4.3)

				var_27_33.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos3008ui_story, var_27_37, var_27_36)

				local var_27_38 = manager.ui.mainCamera.transform.position - var_27_33.position

				var_27_33.forward = Vector3.New(var_27_38.x, var_27_38.y, var_27_38.z)

				local var_27_39 = var_27_33.localEulerAngles

				var_27_39.z = 0
				var_27_39.x = 0
				var_27_33.localEulerAngles = var_27_39
			end

			if arg_24_1.time_ >= var_27_34 + var_27_35 and arg_24_1.time_ < var_27_34 + var_27_35 + arg_27_0 then
				var_27_33.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_27_40 = manager.ui.mainCamera.transform.position - var_27_33.position

				var_27_33.forward = Vector3.New(var_27_40.x, var_27_40.y, var_27_40.z)

				local var_27_41 = var_27_33.localEulerAngles

				var_27_41.z = 0
				var_27_41.x = 0
				var_27_33.localEulerAngles = var_27_41
			end

			local var_27_42 = 0

			if var_27_42 < arg_24_1.time_ and arg_24_1.time_ <= var_27_42 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action5_1")
			end

			local var_27_43 = 0

			if var_27_43 < arg_24_1.time_ and arg_24_1.time_ <= var_27_43 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_27_44 = 0
			local var_27_45 = 0.675

			if var_27_44 < arg_24_1.time_ and arg_24_1.time_ <= var_27_44 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_46 = arg_24_1:FormatText(StoryNameCfg[20].name)

				arg_24_1.leftNameTxt_.text = var_27_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_47 = arg_24_1:GetWordFromCfg(102061006)
				local var_27_48 = arg_24_1:FormatText(var_27_47.content)

				arg_24_1.text_.text = var_27_48

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_49 = 26
				local var_27_50 = utf8.len(var_27_48)
				local var_27_51 = var_27_49 <= 0 and var_27_45 or var_27_45 * (var_27_50 / var_27_49)

				if var_27_51 > 0 and var_27_45 < var_27_51 then
					arg_24_1.talkMaxDuration = var_27_51

					if var_27_51 + var_27_44 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_51 + var_27_44
					end
				end

				arg_24_1.text_.text = var_27_48
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061006", "story_v_out_102061.awb") ~= 0 then
					local var_27_52 = manager.audio:GetVoiceLength("story_v_out_102061", "102061006", "story_v_out_102061.awb") / 1000

					if var_27_52 + var_27_44 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_52 + var_27_44
					end

					if var_27_47.prefab_name ~= "" and arg_24_1.actors_[var_27_47.prefab_name] ~= nil then
						local var_27_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_47.prefab_name].transform, "story_v_out_102061", "102061006", "story_v_out_102061.awb")

						arg_24_1:RecordAudio("102061006", var_27_53)
						arg_24_1:RecordAudio("102061006", var_27_53)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_102061", "102061006", "story_v_out_102061.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_102061", "102061006", "story_v_out_102061.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_54 = math.max(var_27_45, arg_24_1.talkMaxDuration)

			if var_27_44 <= arg_24_1.time_ and arg_24_1.time_ < var_27_44 + var_27_54 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_44) / var_27_54

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_44 + var_27_54 and arg_24_1.time_ < var_27_44 + var_27_54 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_24_1:InitPlayNodeList()
	end,
	Play102061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 102061007
		arg_28_1.duration_ = 8.57

		local var_28_0 = {
			ja = 8.566,
			ko = 6.366,
			zh = 6.233,
			en = 6.566
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
				arg_28_0:Play102061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["3008ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect3008ui_story == nil then
				arg_28_1.var_.characterEffect3008ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect3008ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect3008ui_story then
				arg_28_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_31_4 = 0

			if var_31_4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action5_2")
			end

			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_31_6 = 0
			local var_31_7 = 0.675

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[20].name)

				arg_28_1.leftNameTxt_.text = var_31_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_9 = arg_28_1:GetWordFromCfg(102061007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 27
				local var_31_12 = utf8.len(var_31_10)
				local var_31_13 = var_31_11 <= 0 and var_31_7 or var_31_7 * (var_31_12 / var_31_11)

				if var_31_13 > 0 and var_31_7 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_10
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061007", "story_v_out_102061.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_102061", "102061007", "story_v_out_102061.awb") / 1000

					if var_31_14 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_6
					end

					if var_31_9.prefab_name ~= "" and arg_28_1.actors_[var_31_9.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_9.prefab_name].transform, "story_v_out_102061", "102061007", "story_v_out_102061.awb")

						arg_28_1:RecordAudio("102061007", var_31_15)
						arg_28_1:RecordAudio("102061007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_102061", "102061007", "story_v_out_102061.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_102061", "102061007", "story_v_out_102061.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_16 and arg_28_1.time_ < var_31_6 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play102061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 102061008
		arg_32_1.duration_ = 2

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play102061009(arg_32_1)
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

			local var_35_4 = arg_32_1.actors_["3008ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect3008ui_story == nil then
				arg_32_1.var_.characterEffect3008ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.1

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect3008ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_32_1.var_.characterEffect3008ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect3008ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_32_1.var_.characterEffect3008ui_story.fillRatio = var_35_9
			end

			local var_35_10 = arg_32_1.actors_["3008ui_story"].transform
			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.var_.moveOldPos3008ui_story = var_35_10.localPosition
			end

			local var_35_12 = 0.001

			if var_35_11 <= arg_32_1.time_ and arg_32_1.time_ < var_35_11 + var_35_12 then
				local var_35_13 = (arg_32_1.time_ - var_35_11) / var_35_12
				local var_35_14 = Vector3.New(0, 100, 0)

				var_35_10.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos3008ui_story, var_35_14, var_35_13)

				local var_35_15 = manager.ui.mainCamera.transform.position - var_35_10.position

				var_35_10.forward = Vector3.New(var_35_15.x, var_35_15.y, var_35_15.z)

				local var_35_16 = var_35_10.localEulerAngles

				var_35_16.z = 0
				var_35_16.x = 0
				var_35_10.localEulerAngles = var_35_16
			end

			if arg_32_1.time_ >= var_35_11 + var_35_12 and arg_32_1.time_ < var_35_11 + var_35_12 + arg_35_0 then
				var_35_10.localPosition = Vector3.New(0, 100, 0)

				local var_35_17 = manager.ui.mainCamera.transform.position - var_35_10.position

				var_35_10.forward = Vector3.New(var_35_17.x, var_35_17.y, var_35_17.z)

				local var_35_18 = var_35_10.localEulerAngles

				var_35_18.z = 0
				var_35_18.x = 0
				var_35_10.localEulerAngles = var_35_18
			end

			local var_35_19 = 0

			if var_35_19 < arg_32_1.time_ and arg_32_1.time_ <= var_35_19 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_35_20 = arg_32_1.actors_["1019ui_story"].transform
			local var_35_21 = 0

			if var_35_21 < arg_32_1.time_ and arg_32_1.time_ <= var_35_21 + arg_35_0 then
				arg_32_1.var_.moveOldPos1019ui_story = var_35_20.localPosition
			end

			local var_35_22 = 0.001

			if var_35_21 <= arg_32_1.time_ and arg_32_1.time_ < var_35_21 + var_35_22 then
				local var_35_23 = (arg_32_1.time_ - var_35_21) / var_35_22
				local var_35_24 = Vector3.New(-0.2, -1.08, -5.9)

				var_35_20.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1019ui_story, var_35_24, var_35_23)

				local var_35_25 = manager.ui.mainCamera.transform.position - var_35_20.position

				var_35_20.forward = Vector3.New(var_35_25.x, var_35_25.y, var_35_25.z)

				local var_35_26 = var_35_20.localEulerAngles

				var_35_26.z = 0
				var_35_26.x = 0
				var_35_20.localEulerAngles = var_35_26
			end

			if arg_32_1.time_ >= var_35_21 + var_35_22 and arg_32_1.time_ < var_35_21 + var_35_22 + arg_35_0 then
				var_35_20.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_35_27 = manager.ui.mainCamera.transform.position - var_35_20.position

				var_35_20.forward = Vector3.New(var_35_27.x, var_35_27.y, var_35_27.z)

				local var_35_28 = var_35_20.localEulerAngles

				var_35_28.z = 0
				var_35_28.x = 0
				var_35_20.localEulerAngles = var_35_28
			end

			local var_35_29 = 0

			if var_35_29 < arg_32_1.time_ and arg_32_1.time_ <= var_35_29 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_35_30 = 0
			local var_35_31 = 0.2

			if var_35_30 < arg_32_1.time_ and arg_32_1.time_ <= var_35_30 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_32 = arg_32_1:FormatText(StoryNameCfg[13].name)

				arg_32_1.leftNameTxt_.text = var_35_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_33 = arg_32_1:GetWordFromCfg(102061008)
				local var_35_34 = arg_32_1:FormatText(var_35_33.content)

				arg_32_1.text_.text = var_35_34

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_35 = 8
				local var_35_36 = utf8.len(var_35_34)
				local var_35_37 = var_35_35 <= 0 and var_35_31 or var_35_31 * (var_35_36 / var_35_35)

				if var_35_37 > 0 and var_35_31 < var_35_37 then
					arg_32_1.talkMaxDuration = var_35_37

					if var_35_37 + var_35_30 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_37 + var_35_30
					end
				end

				arg_32_1.text_.text = var_35_34
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061008", "story_v_out_102061.awb") ~= 0 then
					local var_35_38 = manager.audio:GetVoiceLength("story_v_out_102061", "102061008", "story_v_out_102061.awb") / 1000

					if var_35_38 + var_35_30 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_38 + var_35_30
					end

					if var_35_33.prefab_name ~= "" and arg_32_1.actors_[var_35_33.prefab_name] ~= nil then
						local var_35_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_33.prefab_name].transform, "story_v_out_102061", "102061008", "story_v_out_102061.awb")

						arg_32_1:RecordAudio("102061008", var_35_39)
						arg_32_1:RecordAudio("102061008", var_35_39)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_102061", "102061008", "story_v_out_102061.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_102061", "102061008", "story_v_out_102061.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_40 = math.max(var_35_31, arg_32_1.talkMaxDuration)

			if var_35_30 <= arg_32_1.time_ and arg_32_1.time_ < var_35_30 + var_35_40 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_30) / var_35_40

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_30 + var_35_40 and arg_32_1.time_ < var_35_30 + var_35_40 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play102061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 102061009
		arg_36_1.duration_ = 4

		local var_36_0 = {
			ja = 4,
			ko = 3.6,
			zh = 3.966,
			en = 3.2
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
				arg_36_0:Play102061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_39_1 = 0
			local var_39_2 = 0.475

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_3 = arg_36_1:FormatText(StoryNameCfg[13].name)

				arg_36_1.leftNameTxt_.text = var_39_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:GetWordFromCfg(102061009)
				local var_39_5 = arg_36_1:FormatText(var_39_4.content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_6 = 19
				local var_39_7 = utf8.len(var_39_5)
				local var_39_8 = var_39_6 <= 0 and var_39_2 or var_39_2 * (var_39_7 / var_39_6)

				if var_39_8 > 0 and var_39_2 < var_39_8 then
					arg_36_1.talkMaxDuration = var_39_8

					if var_39_8 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061009", "story_v_out_102061.awb") ~= 0 then
					local var_39_9 = manager.audio:GetVoiceLength("story_v_out_102061", "102061009", "story_v_out_102061.awb") / 1000

					if var_39_9 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_1
					end

					if var_39_4.prefab_name ~= "" and arg_36_1.actors_[var_39_4.prefab_name] ~= nil then
						local var_39_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_4.prefab_name].transform, "story_v_out_102061", "102061009", "story_v_out_102061.awb")

						arg_36_1:RecordAudio("102061009", var_39_10)
						arg_36_1:RecordAudio("102061009", var_39_10)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_102061", "102061009", "story_v_out_102061.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_102061", "102061009", "story_v_out_102061.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_11 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_11 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_11

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_11 and arg_36_1.time_ < var_39_1 + var_39_11 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play102061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 102061010
		arg_40_1.duration_ = 4.33

		local var_40_0 = {
			ja = 4.333,
			ko = 2.866,
			zh = 3.333,
			en = 2.833
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
				arg_40_0:Play102061011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = "1011ui_story"

			if arg_40_1.actors_[var_43_0] == nil then
				local var_43_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_43_1) then
					local var_43_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_40_1.stage_.transform)

					var_43_2.name = var_43_0
					var_43_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_40_1.actors_[var_43_0] = var_43_2

					local var_43_3 = var_43_2:GetComponentInChildren(typeof(CharacterEffect))

					var_43_3.enabled = true

					local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_2, typeof(DynamicBoneHelper))

					if var_43_4 then
						var_43_4:EnableDynamicBone(false)
					end

					arg_40_1:ShowWeapon(var_43_3.transform, false)

					arg_40_1.var_[var_43_0 .. "Animator"] = var_43_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_40_1.var_[var_43_0 .. "Animator"].applyRootMotion = true
					arg_40_1.var_[var_43_0 .. "LipSync"] = var_43_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_43_5 = arg_40_1.actors_["1011ui_story"]
			local var_43_6 = 0

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect1011ui_story == nil then
				arg_40_1.var_.characterEffect1011ui_story = var_43_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_7 = 0.1

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_7 and not isNil(var_43_5) then
				local var_43_8 = (arg_40_1.time_ - var_43_6) / var_43_7

				if arg_40_1.var_.characterEffect1011ui_story and not isNil(var_43_5) then
					arg_40_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_6 + var_43_7 and arg_40_1.time_ < var_43_6 + var_43_7 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect1011ui_story then
				arg_40_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_43_9 = arg_40_1.actors_["1019ui_story"]
			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect1019ui_story == nil then
				arg_40_1.var_.characterEffect1019ui_story = var_43_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_11 = 0.1

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_11 and not isNil(var_43_9) then
				local var_43_12 = (arg_40_1.time_ - var_43_10) / var_43_11

				if arg_40_1.var_.characterEffect1019ui_story and not isNil(var_43_9) then
					local var_43_13 = Mathf.Lerp(0, 0.5, var_43_12)

					arg_40_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1019ui_story.fillRatio = var_43_13
				end
			end

			if arg_40_1.time_ >= var_43_10 + var_43_11 and arg_40_1.time_ < var_43_10 + var_43_11 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect1019ui_story then
				local var_43_14 = 0.5

				arg_40_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1019ui_story.fillRatio = var_43_14
			end

			local var_43_15 = arg_40_1.actors_["1019ui_story"].transform
			local var_43_16 = 0

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.var_.moveOldPos1019ui_story = var_43_15.localPosition
			end

			local var_43_17 = 0.001

			if var_43_16 <= arg_40_1.time_ and arg_40_1.time_ < var_43_16 + var_43_17 then
				local var_43_18 = (arg_40_1.time_ - var_43_16) / var_43_17
				local var_43_19 = Vector3.New(0, 100, 0)

				var_43_15.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1019ui_story, var_43_19, var_43_18)

				local var_43_20 = manager.ui.mainCamera.transform.position - var_43_15.position

				var_43_15.forward = Vector3.New(var_43_20.x, var_43_20.y, var_43_20.z)

				local var_43_21 = var_43_15.localEulerAngles

				var_43_21.z = 0
				var_43_21.x = 0
				var_43_15.localEulerAngles = var_43_21
			end

			if arg_40_1.time_ >= var_43_16 + var_43_17 and arg_40_1.time_ < var_43_16 + var_43_17 + arg_43_0 then
				var_43_15.localPosition = Vector3.New(0, 100, 0)

				local var_43_22 = manager.ui.mainCamera.transform.position - var_43_15.position

				var_43_15.forward = Vector3.New(var_43_22.x, var_43_22.y, var_43_22.z)

				local var_43_23 = var_43_15.localEulerAngles

				var_43_23.z = 0
				var_43_23.x = 0
				var_43_15.localEulerAngles = var_43_23
			end

			local var_43_24 = arg_40_1.actors_["1011ui_story"].transform
			local var_43_25 = 0

			if var_43_25 < arg_40_1.time_ and arg_40_1.time_ <= var_43_25 + arg_43_0 then
				arg_40_1.var_.moveOldPos1011ui_story = var_43_24.localPosition
			end

			local var_43_26 = 0.001

			if var_43_25 <= arg_40_1.time_ and arg_40_1.time_ < var_43_25 + var_43_26 then
				local var_43_27 = (arg_40_1.time_ - var_43_25) / var_43_26
				local var_43_28 = Vector3.New(-0.7, -0.71, -6)

				var_43_24.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1011ui_story, var_43_28, var_43_27)

				local var_43_29 = manager.ui.mainCamera.transform.position - var_43_24.position

				var_43_24.forward = Vector3.New(var_43_29.x, var_43_29.y, var_43_29.z)

				local var_43_30 = var_43_24.localEulerAngles

				var_43_30.z = 0
				var_43_30.x = 0
				var_43_24.localEulerAngles = var_43_30
			end

			if arg_40_1.time_ >= var_43_25 + var_43_26 and arg_40_1.time_ < var_43_25 + var_43_26 + arg_43_0 then
				var_43_24.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_43_31 = manager.ui.mainCamera.transform.position - var_43_24.position

				var_43_24.forward = Vector3.New(var_43_31.x, var_43_31.y, var_43_31.z)

				local var_43_32 = var_43_24.localEulerAngles

				var_43_32.z = 0
				var_43_32.x = 0
				var_43_24.localEulerAngles = var_43_32
			end

			local var_43_33 = 0

			if var_43_33 < arg_40_1.time_ and arg_40_1.time_ <= var_43_33 + arg_43_0 then
				arg_40_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_43_34 = 0

			if var_43_34 < arg_40_1.time_ and arg_40_1.time_ <= var_43_34 + arg_43_0 then
				arg_40_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_43_35 = 0
			local var_43_36 = 0.35

			if var_43_35 < arg_40_1.time_ and arg_40_1.time_ <= var_43_35 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_37 = arg_40_1:FormatText(StoryNameCfg[37].name)

				arg_40_1.leftNameTxt_.text = var_43_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_38 = arg_40_1:GetWordFromCfg(102061010)
				local var_43_39 = arg_40_1:FormatText(var_43_38.content)

				arg_40_1.text_.text = var_43_39

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_40 = 14
				local var_43_41 = utf8.len(var_43_39)
				local var_43_42 = var_43_40 <= 0 and var_43_36 or var_43_36 * (var_43_41 / var_43_40)

				if var_43_42 > 0 and var_43_36 < var_43_42 then
					arg_40_1.talkMaxDuration = var_43_42

					if var_43_42 + var_43_35 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_42 + var_43_35
					end
				end

				arg_40_1.text_.text = var_43_39
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061010", "story_v_out_102061.awb") ~= 0 then
					local var_43_43 = manager.audio:GetVoiceLength("story_v_out_102061", "102061010", "story_v_out_102061.awb") / 1000

					if var_43_43 + var_43_35 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_43 + var_43_35
					end

					if var_43_38.prefab_name ~= "" and arg_40_1.actors_[var_43_38.prefab_name] ~= nil then
						local var_43_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_38.prefab_name].transform, "story_v_out_102061", "102061010", "story_v_out_102061.awb")

						arg_40_1:RecordAudio("102061010", var_43_44)
						arg_40_1:RecordAudio("102061010", var_43_44)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_102061", "102061010", "story_v_out_102061.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_102061", "102061010", "story_v_out_102061.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_45 = math.max(var_43_36, arg_40_1.talkMaxDuration)

			if var_43_35 <= arg_40_1.time_ and arg_40_1.time_ < var_43_35 + var_43_45 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_35) / var_43_45

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_35 + var_43_45 and arg_40_1.time_ < var_43_35 + var_43_45 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play102061011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 102061011
		arg_44_1.duration_ = 6.87

		local var_44_0 = {
			ja = 6.866,
			ko = 3.433,
			zh = 4.733,
			en = 4.766
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
				arg_44_0:Play102061012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "2020_tpose"

			if arg_44_1.actors_[var_47_0] == nil then
				local var_47_1 = Asset.Load("Char/" .. "2020_tpose")

				if not isNil(var_47_1) then
					local var_47_2 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_44_1.stage_.transform)

					var_47_2.name = var_47_0
					var_47_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_44_1.actors_[var_47_0] = var_47_2

					local var_47_3 = var_47_2:GetComponentInChildren(typeof(CharacterEffect))

					var_47_3.enabled = true

					local var_47_4 = GameObjectTools.GetOrAddComponent(var_47_2, typeof(DynamicBoneHelper))

					if var_47_4 then
						var_47_4:EnableDynamicBone(false)
					end

					arg_44_1:ShowWeapon(var_47_3.transform, false)

					arg_44_1.var_[var_47_0 .. "Animator"] = var_47_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_44_1.var_[var_47_0 .. "Animator"].applyRootMotion = true
					arg_44_1.var_[var_47_0 .. "LipSync"] = var_47_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_47_5 = arg_44_1.actors_["2020_tpose"]
			local var_47_6 = 0

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect2020_tpose == nil then
				arg_44_1.var_.characterEffect2020_tpose = var_47_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_7 = 0.1

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_7 and not isNil(var_47_5) then
				local var_47_8 = (arg_44_1.time_ - var_47_6) / var_47_7

				if arg_44_1.var_.characterEffect2020_tpose and not isNil(var_47_5) then
					arg_44_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_6 + var_47_7 and arg_44_1.time_ < var_47_6 + var_47_7 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect2020_tpose then
				arg_44_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_47_9 = arg_44_1.actors_["1011ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1011ui_story == nil then
				arg_44_1.var_.characterEffect1011ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.1

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect1011ui_story and not isNil(var_47_9) then
					local var_47_13 = Mathf.Lerp(0, 0.5, var_47_12)

					arg_44_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1011ui_story.fillRatio = var_47_13
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1011ui_story then
				local var_47_14 = 0.5

				arg_44_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1011ui_story.fillRatio = var_47_14
			end

			local var_47_15 = arg_44_1.actors_["2020_tpose"].transform
			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.var_.moveOldPos2020_tpose = var_47_15.localPosition

				local var_47_17 = GameObjectTools.GetOrAddComponent(var_47_15.gameObject, typeof(DynamicBoneHelper))

				if var_47_17 then
					var_47_17:EnableDynamicBone(false)
				end
			end

			local var_47_18 = 0.001

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_18 then
				local var_47_19 = (arg_44_1.time_ - var_47_16) / var_47_18
				local var_47_20 = Vector3.New(0.7, -1.2, -4.1)

				var_47_15.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos2020_tpose, var_47_20, var_47_19)

				local var_47_21 = manager.ui.mainCamera.transform.position - var_47_15.position

				var_47_15.forward = Vector3.New(var_47_21.x, var_47_21.y, var_47_21.z)

				local var_47_22 = var_47_15.localEulerAngles

				var_47_22.z = 0
				var_47_22.x = 0
				var_47_15.localEulerAngles = var_47_22
			end

			if arg_44_1.time_ >= var_47_16 + var_47_18 and arg_44_1.time_ < var_47_16 + var_47_18 + arg_47_0 then
				var_47_15.localPosition = Vector3.New(0.7, -1.2, -4.1)

				local var_47_23 = manager.ui.mainCamera.transform.position - var_47_15.position

				var_47_15.forward = Vector3.New(var_47_23.x, var_47_23.y, var_47_23.z)

				local var_47_24 = var_47_15.localEulerAngles

				var_47_24.z = 0
				var_47_24.x = 0
				var_47_15.localEulerAngles = var_47_24

				local var_47_25 = GameObjectTools.GetOrAddComponent(var_47_15.gameObject, typeof(DynamicBoneHelper))

				if var_47_25 then
					var_47_25:EnableDynamicBone(true)
				end
			end

			local var_47_26 = 0

			if var_47_26 < arg_44_1.time_ and arg_44_1.time_ <= var_47_26 + arg_47_0 then
				arg_44_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_47_27 = 0
			local var_47_28 = 0.6

			if var_47_27 < arg_44_1.time_ and arg_44_1.time_ <= var_47_27 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_29 = arg_44_1:FormatText(StoryNameCfg[34].name)

				arg_44_1.leftNameTxt_.text = var_47_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_30 = arg_44_1:GetWordFromCfg(102061011)
				local var_47_31 = arg_44_1:FormatText(var_47_30.content)

				arg_44_1.text_.text = var_47_31

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_32 = 24
				local var_47_33 = utf8.len(var_47_31)
				local var_47_34 = var_47_32 <= 0 and var_47_28 or var_47_28 * (var_47_33 / var_47_32)

				if var_47_34 > 0 and var_47_28 < var_47_34 then
					arg_44_1.talkMaxDuration = var_47_34

					if var_47_34 + var_47_27 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_34 + var_47_27
					end
				end

				arg_44_1.text_.text = var_47_31
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061011", "story_v_out_102061.awb") ~= 0 then
					local var_47_35 = manager.audio:GetVoiceLength("story_v_out_102061", "102061011", "story_v_out_102061.awb") / 1000

					if var_47_35 + var_47_27 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_35 + var_47_27
					end

					if var_47_30.prefab_name ~= "" and arg_44_1.actors_[var_47_30.prefab_name] ~= nil then
						local var_47_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_30.prefab_name].transform, "story_v_out_102061", "102061011", "story_v_out_102061.awb")

						arg_44_1:RecordAudio("102061011", var_47_36)
						arg_44_1:RecordAudio("102061011", var_47_36)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_102061", "102061011", "story_v_out_102061.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_102061", "102061011", "story_v_out_102061.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_37 = math.max(var_47_28, arg_44_1.talkMaxDuration)

			if var_47_27 <= arg_44_1.time_ and arg_44_1.time_ < var_47_27 + var_47_37 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_27) / var_47_37

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_27 + var_47_37 and arg_44_1.time_ < var_47_27 + var_47_37 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play102061012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 102061012
		arg_48_1.duration_ = 3.4

		local var_48_0 = {
			ja = 3.4,
			ko = 2.866,
			zh = 2.5,
			en = 2.7
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
				arg_48_0:Play102061013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["3008ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect3008ui_story == nil then
				arg_48_1.var_.characterEffect3008ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect3008ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect3008ui_story then
				arg_48_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["2020_tpose"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect2020_tpose == nil then
				arg_48_1.var_.characterEffect2020_tpose = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect2020_tpose and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_48_1.var_.characterEffect2020_tpose.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect2020_tpose then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_48_1.var_.characterEffect2020_tpose.fillRatio = var_51_9
			end

			local var_51_10 = arg_48_1.actors_["1011ui_story"].transform
			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1.var_.moveOldPos1011ui_story = var_51_10.localPosition
			end

			local var_51_12 = 0.001

			if var_51_11 <= arg_48_1.time_ and arg_48_1.time_ < var_51_11 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_11) / var_51_12
				local var_51_14 = Vector3.New(0, 100, 0)

				var_51_10.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1011ui_story, var_51_14, var_51_13)

				local var_51_15 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_15.x, var_51_15.y, var_51_15.z)

				local var_51_16 = var_51_10.localEulerAngles

				var_51_16.z = 0
				var_51_16.x = 0
				var_51_10.localEulerAngles = var_51_16
			end

			if arg_48_1.time_ >= var_51_11 + var_51_12 and arg_48_1.time_ < var_51_11 + var_51_12 + arg_51_0 then
				var_51_10.localPosition = Vector3.New(0, 100, 0)

				local var_51_17 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_17.x, var_51_17.y, var_51_17.z)

				local var_51_18 = var_51_10.localEulerAngles

				var_51_18.z = 0
				var_51_18.x = 0
				var_51_10.localEulerAngles = var_51_18
			end

			local var_51_19 = arg_48_1.actors_["3008ui_story"].transform
			local var_51_20 = 0

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1.var_.moveOldPos3008ui_story = var_51_19.localPosition
			end

			local var_51_21 = 0.001

			if var_51_20 <= arg_48_1.time_ and arg_48_1.time_ < var_51_20 + var_51_21 then
				local var_51_22 = (arg_48_1.time_ - var_51_20) / var_51_21
				local var_51_23 = Vector3.New(-0.7, -1.51, -4.3)

				var_51_19.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos3008ui_story, var_51_23, var_51_22)

				local var_51_24 = manager.ui.mainCamera.transform.position - var_51_19.position

				var_51_19.forward = Vector3.New(var_51_24.x, var_51_24.y, var_51_24.z)

				local var_51_25 = var_51_19.localEulerAngles

				var_51_25.z = 0
				var_51_25.x = 0
				var_51_19.localEulerAngles = var_51_25
			end

			if arg_48_1.time_ >= var_51_20 + var_51_21 and arg_48_1.time_ < var_51_20 + var_51_21 + arg_51_0 then
				var_51_19.localPosition = Vector3.New(-0.7, -1.51, -4.3)

				local var_51_26 = manager.ui.mainCamera.transform.position - var_51_19.position

				var_51_19.forward = Vector3.New(var_51_26.x, var_51_26.y, var_51_26.z)

				local var_51_27 = var_51_19.localEulerAngles

				var_51_27.z = 0
				var_51_27.x = 0
				var_51_19.localEulerAngles = var_51_27
			end

			local var_51_28 = 0

			if var_51_28 < arg_48_1.time_ and arg_48_1.time_ <= var_51_28 + arg_51_0 then
				arg_48_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			local var_51_29 = 0

			if var_51_29 < arg_48_1.time_ and arg_48_1.time_ <= var_51_29 + arg_51_0 then
				arg_48_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_51_30 = 0
			local var_51_31 = 0.275

			if var_51_30 < arg_48_1.time_ and arg_48_1.time_ <= var_51_30 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_32 = arg_48_1:FormatText(StoryNameCfg[20].name)

				arg_48_1.leftNameTxt_.text = var_51_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_33 = arg_48_1:GetWordFromCfg(102061012)
				local var_51_34 = arg_48_1:FormatText(var_51_33.content)

				arg_48_1.text_.text = var_51_34

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_35 = 11
				local var_51_36 = utf8.len(var_51_34)
				local var_51_37 = var_51_35 <= 0 and var_51_31 or var_51_31 * (var_51_36 / var_51_35)

				if var_51_37 > 0 and var_51_31 < var_51_37 then
					arg_48_1.talkMaxDuration = var_51_37

					if var_51_37 + var_51_30 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_37 + var_51_30
					end
				end

				arg_48_1.text_.text = var_51_34
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061012", "story_v_out_102061.awb") ~= 0 then
					local var_51_38 = manager.audio:GetVoiceLength("story_v_out_102061", "102061012", "story_v_out_102061.awb") / 1000

					if var_51_38 + var_51_30 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_38 + var_51_30
					end

					if var_51_33.prefab_name ~= "" and arg_48_1.actors_[var_51_33.prefab_name] ~= nil then
						local var_51_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_33.prefab_name].transform, "story_v_out_102061", "102061012", "story_v_out_102061.awb")

						arg_48_1:RecordAudio("102061012", var_51_39)
						arg_48_1:RecordAudio("102061012", var_51_39)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_102061", "102061012", "story_v_out_102061.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_102061", "102061012", "story_v_out_102061.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_40 = math.max(var_51_31, arg_48_1.talkMaxDuration)

			if var_51_30 <= arg_48_1.time_ and arg_48_1.time_ < var_51_30 + var_51_40 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_30) / var_51_40

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_30 + var_51_40 and arg_48_1.time_ < var_51_30 + var_51_40 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_48_1:InitPlayNodeList()
	end,
	Play102061013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 102061013
		arg_52_1.duration_ = 2.5

		local var_52_0 = {
			ja = 2,
			ko = 2.2,
			zh = 2.5,
			en = 1.533
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
				arg_52_0:Play102061014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["2020_tpose"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect2020_tpose == nil then
				arg_52_1.var_.characterEffect2020_tpose = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect2020_tpose and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect2020_tpose then
				arg_52_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["3008ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect3008ui_story == nil then
				arg_52_1.var_.characterEffect3008ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.1

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect3008ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_52_1.var_.characterEffect3008ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect3008ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_52_1.var_.characterEffect3008ui_story.fillRatio = var_55_9
			end

			local var_55_10 = 0
			local var_55_11 = 0.225

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_12 = arg_52_1:FormatText(StoryNameCfg[34].name)

				arg_52_1.leftNameTxt_.text = var_55_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_13 = arg_52_1:GetWordFromCfg(102061013)
				local var_55_14 = arg_52_1:FormatText(var_55_13.content)

				arg_52_1.text_.text = var_55_14

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_15 = 9
				local var_55_16 = utf8.len(var_55_14)
				local var_55_17 = var_55_15 <= 0 and var_55_11 or var_55_11 * (var_55_16 / var_55_15)

				if var_55_17 > 0 and var_55_11 < var_55_17 then
					arg_52_1.talkMaxDuration = var_55_17

					if var_55_17 + var_55_10 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_17 + var_55_10
					end
				end

				arg_52_1.text_.text = var_55_14
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061013", "story_v_out_102061.awb") ~= 0 then
					local var_55_18 = manager.audio:GetVoiceLength("story_v_out_102061", "102061013", "story_v_out_102061.awb") / 1000

					if var_55_18 + var_55_10 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_18 + var_55_10
					end

					if var_55_13.prefab_name ~= "" and arg_52_1.actors_[var_55_13.prefab_name] ~= nil then
						local var_55_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_13.prefab_name].transform, "story_v_out_102061", "102061013", "story_v_out_102061.awb")

						arg_52_1:RecordAudio("102061013", var_55_19)
						arg_52_1:RecordAudio("102061013", var_55_19)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_102061", "102061013", "story_v_out_102061.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_102061", "102061013", "story_v_out_102061.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_20 = math.max(var_55_11, arg_52_1.talkMaxDuration)

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_20 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_10) / var_55_20

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_10 + var_55_20 and arg_52_1.time_ < var_55_10 + var_55_20 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play102061014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 102061014
		arg_56_1.duration_ = 11.33

		local var_56_0 = {
			ja = 11.333,
			ko = 6.933,
			zh = 6.2,
			en = 7.733
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
				arg_56_0:Play102061015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1011ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1011ui_story == nil then
				arg_56_1.var_.characterEffect1011ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1011ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1011ui_story then
				arg_56_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["2020_tpose"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect2020_tpose == nil then
				arg_56_1.var_.characterEffect2020_tpose = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.1

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect2020_tpose and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_56_1.var_.characterEffect2020_tpose.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect2020_tpose then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_56_1.var_.characterEffect2020_tpose.fillRatio = var_59_9
			end

			local var_59_10 = arg_56_1.actors_["2020_tpose"].transform
			local var_59_11 = 0

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.var_.moveOldPos2020_tpose = var_59_10.localPosition

				local var_59_12 = GameObjectTools.GetOrAddComponent(var_59_10.gameObject, typeof(DynamicBoneHelper))

				if var_59_12 then
					var_59_12:EnableDynamicBone(false)
				end
			end

			local var_59_13 = 0.001

			if var_59_11 <= arg_56_1.time_ and arg_56_1.time_ < var_59_11 + var_59_13 then
				local var_59_14 = (arg_56_1.time_ - var_59_11) / var_59_13
				local var_59_15 = Vector3.New(0, 100, 0)

				var_59_10.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos2020_tpose, var_59_15, var_59_14)

				local var_59_16 = manager.ui.mainCamera.transform.position - var_59_10.position

				var_59_10.forward = Vector3.New(var_59_16.x, var_59_16.y, var_59_16.z)

				local var_59_17 = var_59_10.localEulerAngles

				var_59_17.z = 0
				var_59_17.x = 0
				var_59_10.localEulerAngles = var_59_17
			end

			if arg_56_1.time_ >= var_59_11 + var_59_13 and arg_56_1.time_ < var_59_11 + var_59_13 + arg_59_0 then
				var_59_10.localPosition = Vector3.New(0, 100, 0)

				local var_59_18 = manager.ui.mainCamera.transform.position - var_59_10.position

				var_59_10.forward = Vector3.New(var_59_18.x, var_59_18.y, var_59_18.z)

				local var_59_19 = var_59_10.localEulerAngles

				var_59_19.z = 0
				var_59_19.x = 0
				var_59_10.localEulerAngles = var_59_19

				local var_59_20 = GameObjectTools.GetOrAddComponent(var_59_10.gameObject, typeof(DynamicBoneHelper))

				if var_59_20 then
					var_59_20:EnableDynamicBone(true)
				end
			end

			local var_59_21 = arg_56_1.actors_["1011ui_story"].transform
			local var_59_22 = 0

			if var_59_22 < arg_56_1.time_ and arg_56_1.time_ <= var_59_22 + arg_59_0 then
				arg_56_1.var_.moveOldPos1011ui_story = var_59_21.localPosition
			end

			local var_59_23 = 0.001

			if var_59_22 <= arg_56_1.time_ and arg_56_1.time_ < var_59_22 + var_59_23 then
				local var_59_24 = (arg_56_1.time_ - var_59_22) / var_59_23
				local var_59_25 = Vector3.New(0.7, -0.71, -6)

				var_59_21.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1011ui_story, var_59_25, var_59_24)

				local var_59_26 = manager.ui.mainCamera.transform.position - var_59_21.position

				var_59_21.forward = Vector3.New(var_59_26.x, var_59_26.y, var_59_26.z)

				local var_59_27 = var_59_21.localEulerAngles

				var_59_27.z = 0
				var_59_27.x = 0
				var_59_21.localEulerAngles = var_59_27
			end

			if arg_56_1.time_ >= var_59_22 + var_59_23 and arg_56_1.time_ < var_59_22 + var_59_23 + arg_59_0 then
				var_59_21.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_59_28 = manager.ui.mainCamera.transform.position - var_59_21.position

				var_59_21.forward = Vector3.New(var_59_28.x, var_59_28.y, var_59_28.z)

				local var_59_29 = var_59_21.localEulerAngles

				var_59_29.z = 0
				var_59_29.x = 0
				var_59_21.localEulerAngles = var_59_29
			end

			local var_59_30 = 0

			if var_59_30 < arg_56_1.time_ and arg_56_1.time_ <= var_59_30 + arg_59_0 then
				arg_56_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_59_31 = 0

			if var_59_31 < arg_56_1.time_ and arg_56_1.time_ <= var_59_31 + arg_59_0 then
				arg_56_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_59_32 = 0
			local var_59_33 = 0.75

			if var_59_32 < arg_56_1.time_ and arg_56_1.time_ <= var_59_32 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_34 = arg_56_1:FormatText(StoryNameCfg[37].name)

				arg_56_1.leftNameTxt_.text = var_59_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_35 = arg_56_1:GetWordFromCfg(102061014)
				local var_59_36 = arg_56_1:FormatText(var_59_35.content)

				arg_56_1.text_.text = var_59_36

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_37 = 30
				local var_59_38 = utf8.len(var_59_36)
				local var_59_39 = var_59_37 <= 0 and var_59_33 or var_59_33 * (var_59_38 / var_59_37)

				if var_59_39 > 0 and var_59_33 < var_59_39 then
					arg_56_1.talkMaxDuration = var_59_39

					if var_59_39 + var_59_32 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_39 + var_59_32
					end
				end

				arg_56_1.text_.text = var_59_36
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061014", "story_v_out_102061.awb") ~= 0 then
					local var_59_40 = manager.audio:GetVoiceLength("story_v_out_102061", "102061014", "story_v_out_102061.awb") / 1000

					if var_59_40 + var_59_32 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_40 + var_59_32
					end

					if var_59_35.prefab_name ~= "" and arg_56_1.actors_[var_59_35.prefab_name] ~= nil then
						local var_59_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_35.prefab_name].transform, "story_v_out_102061", "102061014", "story_v_out_102061.awb")

						arg_56_1:RecordAudio("102061014", var_59_41)
						arg_56_1:RecordAudio("102061014", var_59_41)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_102061", "102061014", "story_v_out_102061.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_102061", "102061014", "story_v_out_102061.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_42 = math.max(var_59_33, arg_56_1.talkMaxDuration)

			if var_59_32 <= arg_56_1.time_ and arg_56_1.time_ < var_59_32 + var_59_42 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_32) / var_59_42

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_32 + var_59_42 and arg_56_1.time_ < var_59_32 + var_59_42 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play102061015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 102061015
		arg_60_1.duration_ = 8.1

		local var_60_0 = {
			ja = 8.1,
			ko = 4.9,
			zh = 5.2,
			en = 5.5
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play102061016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["3008ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect3008ui_story == nil then
				arg_60_1.var_.characterEffect3008ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect3008ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect3008ui_story then
				arg_60_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["1011ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1011ui_story == nil then
				arg_60_1.var_.characterEffect1011ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.1

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect1011ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1011ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1011ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1011ui_story.fillRatio = var_63_9
			end

			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_63_11 = 0

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_2")
			end

			local var_63_12 = 0
			local var_63_13 = 0.575

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_14 = arg_60_1:FormatText(StoryNameCfg[20].name)

				arg_60_1.leftNameTxt_.text = var_63_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_15 = arg_60_1:GetWordFromCfg(102061015)
				local var_63_16 = arg_60_1:FormatText(var_63_15.content)

				arg_60_1.text_.text = var_63_16

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_17 = 23
				local var_63_18 = utf8.len(var_63_16)
				local var_63_19 = var_63_17 <= 0 and var_63_13 or var_63_13 * (var_63_18 / var_63_17)

				if var_63_19 > 0 and var_63_13 < var_63_19 then
					arg_60_1.talkMaxDuration = var_63_19

					if var_63_19 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_12
					end
				end

				arg_60_1.text_.text = var_63_16
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061015", "story_v_out_102061.awb") ~= 0 then
					local var_63_20 = manager.audio:GetVoiceLength("story_v_out_102061", "102061015", "story_v_out_102061.awb") / 1000

					if var_63_20 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_20 + var_63_12
					end

					if var_63_15.prefab_name ~= "" and arg_60_1.actors_[var_63_15.prefab_name] ~= nil then
						local var_63_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_15.prefab_name].transform, "story_v_out_102061", "102061015", "story_v_out_102061.awb")

						arg_60_1:RecordAudio("102061015", var_63_21)
						arg_60_1:RecordAudio("102061015", var_63_21)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_102061", "102061015", "story_v_out_102061.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_102061", "102061015", "story_v_out_102061.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_22 = math.max(var_63_13, arg_60_1.talkMaxDuration)

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_22 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_12) / var_63_22

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_12 + var_63_22 and arg_60_1.time_ < var_63_12 + var_63_22 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play102061016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 102061016
		arg_64_1.duration_ = 5.4

		local var_64_0 = {
			ja = 5.4,
			ko = 3.633,
			zh = 4.466,
			en = 3.833
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
				arg_64_0:Play102061017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1019ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1019ui_story == nil then
				arg_64_1.var_.characterEffect1019ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1019ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1019ui_story then
				arg_64_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["3008ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect3008ui_story == nil then
				arg_64_1.var_.characterEffect3008ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.1

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect3008ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_64_1.var_.characterEffect3008ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect3008ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_64_1.var_.characterEffect3008ui_story.fillRatio = var_67_9
			end

			local var_67_10 = arg_64_1.actors_["1011ui_story"].transform
			local var_67_11 = 0

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.var_.moveOldPos1011ui_story = var_67_10.localPosition
			end

			local var_67_12 = 0.001

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_11) / var_67_12
				local var_67_14 = Vector3.New(0, 100, 0)

				var_67_10.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1011ui_story, var_67_14, var_67_13)

				local var_67_15 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_15.x, var_67_15.y, var_67_15.z)

				local var_67_16 = var_67_10.localEulerAngles

				var_67_16.z = 0
				var_67_16.x = 0
				var_67_10.localEulerAngles = var_67_16
			end

			if arg_64_1.time_ >= var_67_11 + var_67_12 and arg_64_1.time_ < var_67_11 + var_67_12 + arg_67_0 then
				var_67_10.localPosition = Vector3.New(0, 100, 0)

				local var_67_17 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_17.x, var_67_17.y, var_67_17.z)

				local var_67_18 = var_67_10.localEulerAngles

				var_67_18.z = 0
				var_67_18.x = 0
				var_67_10.localEulerAngles = var_67_18
			end

			local var_67_19 = arg_64_1.actors_["1019ui_story"].transform
			local var_67_20 = 0

			if var_67_20 < arg_64_1.time_ and arg_64_1.time_ <= var_67_20 + arg_67_0 then
				arg_64_1.var_.moveOldPos1019ui_story = var_67_19.localPosition
			end

			local var_67_21 = 0.001

			if var_67_20 <= arg_64_1.time_ and arg_64_1.time_ < var_67_20 + var_67_21 then
				local var_67_22 = (arg_64_1.time_ - var_67_20) / var_67_21
				local var_67_23 = Vector3.New(0.7, -1.08, -5.9)

				var_67_19.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1019ui_story, var_67_23, var_67_22)

				local var_67_24 = manager.ui.mainCamera.transform.position - var_67_19.position

				var_67_19.forward = Vector3.New(var_67_24.x, var_67_24.y, var_67_24.z)

				local var_67_25 = var_67_19.localEulerAngles

				var_67_25.z = 0
				var_67_25.x = 0
				var_67_19.localEulerAngles = var_67_25
			end

			if arg_64_1.time_ >= var_67_20 + var_67_21 and arg_64_1.time_ < var_67_20 + var_67_21 + arg_67_0 then
				var_67_19.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_67_26 = manager.ui.mainCamera.transform.position - var_67_19.position

				var_67_19.forward = Vector3.New(var_67_26.x, var_67_26.y, var_67_26.z)

				local var_67_27 = var_67_19.localEulerAngles

				var_67_27.z = 0
				var_67_27.x = 0
				var_67_19.localEulerAngles = var_67_27
			end

			local var_67_28 = 0

			if var_67_28 < arg_64_1.time_ and arg_64_1.time_ <= var_67_28 + arg_67_0 then
				arg_64_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_67_29 = 0

			if var_67_29 < arg_64_1.time_ and arg_64_1.time_ <= var_67_29 + arg_67_0 then
				arg_64_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_67_30 = 0
			local var_67_31 = 0.55

			if var_67_30 < arg_64_1.time_ and arg_64_1.time_ <= var_67_30 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_32 = arg_64_1:FormatText(StoryNameCfg[13].name)

				arg_64_1.leftNameTxt_.text = var_67_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_33 = arg_64_1:GetWordFromCfg(102061016)
				local var_67_34 = arg_64_1:FormatText(var_67_33.content)

				arg_64_1.text_.text = var_67_34

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_35 = 22
				local var_67_36 = utf8.len(var_67_34)
				local var_67_37 = var_67_35 <= 0 and var_67_31 or var_67_31 * (var_67_36 / var_67_35)

				if var_67_37 > 0 and var_67_31 < var_67_37 then
					arg_64_1.talkMaxDuration = var_67_37

					if var_67_37 + var_67_30 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_37 + var_67_30
					end
				end

				arg_64_1.text_.text = var_67_34
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061016", "story_v_out_102061.awb") ~= 0 then
					local var_67_38 = manager.audio:GetVoiceLength("story_v_out_102061", "102061016", "story_v_out_102061.awb") / 1000

					if var_67_38 + var_67_30 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_38 + var_67_30
					end

					if var_67_33.prefab_name ~= "" and arg_64_1.actors_[var_67_33.prefab_name] ~= nil then
						local var_67_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_33.prefab_name].transform, "story_v_out_102061", "102061016", "story_v_out_102061.awb")

						arg_64_1:RecordAudio("102061016", var_67_39)
						arg_64_1:RecordAudio("102061016", var_67_39)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_102061", "102061016", "story_v_out_102061.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_102061", "102061016", "story_v_out_102061.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_40 = math.max(var_67_31, arg_64_1.talkMaxDuration)

			if var_67_30 <= arg_64_1.time_ and arg_64_1.time_ < var_67_30 + var_67_40 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_30) / var_67_40

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_30 + var_67_40 and arg_64_1.time_ < var_67_30 + var_67_40 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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

		arg_64_1:InitPlayNodeList()
	end,
	Play102061017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 102061017
		arg_68_1.duration_ = 5.9

		local var_68_0 = {
			ja = 5.433,
			ko = 4.3,
			zh = 4.9,
			en = 5.9
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
				arg_68_0:Play102061018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["3008ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect3008ui_story == nil then
				arg_68_1.var_.characterEffect3008ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect3008ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect3008ui_story then
				arg_68_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["1019ui_story"].transform
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.var_.moveOldPos1019ui_story = var_71_4.localPosition
			end

			local var_71_6 = 0.001

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6
				local var_71_8 = Vector3.New(0, 100, 0)

				var_71_4.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1019ui_story, var_71_8, var_71_7)

				local var_71_9 = manager.ui.mainCamera.transform.position - var_71_4.position

				var_71_4.forward = Vector3.New(var_71_9.x, var_71_9.y, var_71_9.z)

				local var_71_10 = var_71_4.localEulerAngles

				var_71_10.z = 0
				var_71_10.x = 0
				var_71_4.localEulerAngles = var_71_10
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 then
				var_71_4.localPosition = Vector3.New(0, 100, 0)

				local var_71_11 = manager.ui.mainCamera.transform.position - var_71_4.position

				var_71_4.forward = Vector3.New(var_71_11.x, var_71_11.y, var_71_11.z)

				local var_71_12 = var_71_4.localEulerAngles

				var_71_12.z = 0
				var_71_12.x = 0
				var_71_4.localEulerAngles = var_71_12
			end

			local var_71_13 = arg_68_1.actors_["3008ui_story"].transform
			local var_71_14 = 0

			if var_71_14 < arg_68_1.time_ and arg_68_1.time_ <= var_71_14 + arg_71_0 then
				arg_68_1.var_.moveOldPos3008ui_story = var_71_13.localPosition
			end

			local var_71_15 = 0.5

			if var_71_14 <= arg_68_1.time_ and arg_68_1.time_ < var_71_14 + var_71_15 then
				local var_71_16 = (arg_68_1.time_ - var_71_14) / var_71_15
				local var_71_17 = Vector3.New(0, -1.51, -4.3)

				var_71_13.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos3008ui_story, var_71_17, var_71_16)

				local var_71_18 = manager.ui.mainCamera.transform.position - var_71_13.position

				var_71_13.forward = Vector3.New(var_71_18.x, var_71_18.y, var_71_18.z)

				local var_71_19 = var_71_13.localEulerAngles

				var_71_19.z = 0
				var_71_19.x = 0
				var_71_13.localEulerAngles = var_71_19
			end

			if arg_68_1.time_ >= var_71_14 + var_71_15 and arg_68_1.time_ < var_71_14 + var_71_15 + arg_71_0 then
				var_71_13.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_71_20 = manager.ui.mainCamera.transform.position - var_71_13.position

				var_71_13.forward = Vector3.New(var_71_20.x, var_71_20.y, var_71_20.z)

				local var_71_21 = var_71_13.localEulerAngles

				var_71_21.z = 0
				var_71_21.x = 0
				var_71_13.localEulerAngles = var_71_21
			end

			local var_71_22 = 0

			if var_71_22 < arg_68_1.time_ and arg_68_1.time_ <= var_71_22 + arg_71_0 then
				arg_68_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_71_23 = 0
			local var_71_24 = 0.525

			if var_71_23 < arg_68_1.time_ and arg_68_1.time_ <= var_71_23 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_25 = arg_68_1:FormatText(StoryNameCfg[20].name)

				arg_68_1.leftNameTxt_.text = var_71_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_26 = arg_68_1:GetWordFromCfg(102061017)
				local var_71_27 = arg_68_1:FormatText(var_71_26.content)

				arg_68_1.text_.text = var_71_27

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_28 = 21
				local var_71_29 = utf8.len(var_71_27)
				local var_71_30 = var_71_28 <= 0 and var_71_24 or var_71_24 * (var_71_29 / var_71_28)

				if var_71_30 > 0 and var_71_24 < var_71_30 then
					arg_68_1.talkMaxDuration = var_71_30

					if var_71_30 + var_71_23 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_30 + var_71_23
					end
				end

				arg_68_1.text_.text = var_71_27
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061017", "story_v_out_102061.awb") ~= 0 then
					local var_71_31 = manager.audio:GetVoiceLength("story_v_out_102061", "102061017", "story_v_out_102061.awb") / 1000

					if var_71_31 + var_71_23 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_31 + var_71_23
					end

					if var_71_26.prefab_name ~= "" and arg_68_1.actors_[var_71_26.prefab_name] ~= nil then
						local var_71_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_26.prefab_name].transform, "story_v_out_102061", "102061017", "story_v_out_102061.awb")

						arg_68_1:RecordAudio("102061017", var_71_32)
						arg_68_1:RecordAudio("102061017", var_71_32)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_102061", "102061017", "story_v_out_102061.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_102061", "102061017", "story_v_out_102061.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_33 = math.max(var_71_24, arg_68_1.talkMaxDuration)

			if var_71_23 <= arg_68_1.time_ and arg_68_1.time_ < var_71_23 + var_71_33 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_23) / var_71_33

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_23 + var_71_33 and arg_68_1.time_ < var_71_23 + var_71_33 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play102061018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 102061018
		arg_72_1.duration_ = 5.77

		local var_72_0 = {
			ja = 5.766,
			ko = 3.8,
			zh = 5.333,
			en = 5.733
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
				arg_72_0:Play102061019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["3008ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect3008ui_story == nil then
				arg_72_1.var_.characterEffect3008ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect3008ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_72_1.var_.characterEffect3008ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect3008ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_72_1.var_.characterEffect3008ui_story.fillRatio = var_75_5
			end

			local var_75_6 = 0
			local var_75_7 = 0.575

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_8 = arg_72_1:FormatText(StoryNameCfg[34].name)

				arg_72_1.leftNameTxt_.text = var_75_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_9 = arg_72_1:GetWordFromCfg(102061018)
				local var_75_10 = arg_72_1:FormatText(var_75_9.content)

				arg_72_1.text_.text = var_75_10

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 23
				local var_75_12 = utf8.len(var_75_10)
				local var_75_13 = var_75_11 <= 0 and var_75_7 or var_75_7 * (var_75_12 / var_75_11)

				if var_75_13 > 0 and var_75_7 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_10
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061018", "story_v_out_102061.awb") ~= 0 then
					local var_75_14 = manager.audio:GetVoiceLength("story_v_out_102061", "102061018", "story_v_out_102061.awb") / 1000

					if var_75_14 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_6
					end

					if var_75_9.prefab_name ~= "" and arg_72_1.actors_[var_75_9.prefab_name] ~= nil then
						local var_75_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_9.prefab_name].transform, "story_v_out_102061", "102061018", "story_v_out_102061.awb")

						arg_72_1:RecordAudio("102061018", var_75_15)
						arg_72_1:RecordAudio("102061018", var_75_15)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_102061", "102061018", "story_v_out_102061.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_102061", "102061018", "story_v_out_102061.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_16 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_16 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_16

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_16 and arg_72_1.time_ < var_75_6 + var_75_16 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play102061019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 102061019
		arg_76_1.duration_ = 3.57

		local var_76_0 = {
			ja = 3.3,
			ko = 3.566,
			zh = 3,
			en = 2.566
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
				arg_76_0:Play102061020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["3008ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect3008ui_story == nil then
				arg_76_1.var_.characterEffect3008ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect3008ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect3008ui_story then
				arg_76_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_79_4 = 0

			if var_79_4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_79_5 = 0
			local var_79_6 = 0.275

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_7 = arg_76_1:FormatText(StoryNameCfg[20].name)

				arg_76_1.leftNameTxt_.text = var_79_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_8 = arg_76_1:GetWordFromCfg(102061019)
				local var_79_9 = arg_76_1:FormatText(var_79_8.content)

				arg_76_1.text_.text = var_79_9

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_10 = 11
				local var_79_11 = utf8.len(var_79_9)
				local var_79_12 = var_79_10 <= 0 and var_79_6 or var_79_6 * (var_79_11 / var_79_10)

				if var_79_12 > 0 and var_79_6 < var_79_12 then
					arg_76_1.talkMaxDuration = var_79_12

					if var_79_12 + var_79_5 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_5
					end
				end

				arg_76_1.text_.text = var_79_9
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061019", "story_v_out_102061.awb") ~= 0 then
					local var_79_13 = manager.audio:GetVoiceLength("story_v_out_102061", "102061019", "story_v_out_102061.awb") / 1000

					if var_79_13 + var_79_5 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_5
					end

					if var_79_8.prefab_name ~= "" and arg_76_1.actors_[var_79_8.prefab_name] ~= nil then
						local var_79_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_8.prefab_name].transform, "story_v_out_102061", "102061019", "story_v_out_102061.awb")

						arg_76_1:RecordAudio("102061019", var_79_14)
						arg_76_1:RecordAudio("102061019", var_79_14)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_102061", "102061019", "story_v_out_102061.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_102061", "102061019", "story_v_out_102061.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_15 = math.max(var_79_6, arg_76_1.talkMaxDuration)

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_15 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_5) / var_79_15

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_5 + var_79_15 and arg_76_1.time_ < var_79_5 + var_79_15 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play102061020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 102061020
		arg_80_1.duration_ = 7.1

		local var_80_0 = {
			ja = 6.766,
			ko = 7.1,
			zh = 6.9,
			en = 6.633
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
				arg_80_0:Play102061021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_83_1 = 0
			local var_83_2 = 0.75

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_3 = arg_80_1:FormatText(StoryNameCfg[20].name)

				arg_80_1.leftNameTxt_.text = var_83_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_4 = arg_80_1:GetWordFromCfg(102061020)
				local var_83_5 = arg_80_1:FormatText(var_83_4.content)

				arg_80_1.text_.text = var_83_5

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_6 = 30
				local var_83_7 = utf8.len(var_83_5)
				local var_83_8 = var_83_6 <= 0 and var_83_2 or var_83_2 * (var_83_7 / var_83_6)

				if var_83_8 > 0 and var_83_2 < var_83_8 then
					arg_80_1.talkMaxDuration = var_83_8

					if var_83_8 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_5
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061020", "story_v_out_102061.awb") ~= 0 then
					local var_83_9 = manager.audio:GetVoiceLength("story_v_out_102061", "102061020", "story_v_out_102061.awb") / 1000

					if var_83_9 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_1
					end

					if var_83_4.prefab_name ~= "" and arg_80_1.actors_[var_83_4.prefab_name] ~= nil then
						local var_83_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_4.prefab_name].transform, "story_v_out_102061", "102061020", "story_v_out_102061.awb")

						arg_80_1:RecordAudio("102061020", var_83_10)
						arg_80_1:RecordAudio("102061020", var_83_10)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_102061", "102061020", "story_v_out_102061.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_102061", "102061020", "story_v_out_102061.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_11 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_11 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_11

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_11 and arg_80_1.time_ < var_83_1 + var_83_11 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play102061021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 102061021
		arg_84_1.duration_ = 12.7

		local var_84_0 = {
			ja = 7.9,
			ko = 3.5,
			zh = 5.466,
			en = 12.7
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
			arg_84_1.auto_ = false
		end

		function arg_84_1.playNext_(arg_86_0)
			arg_84_1.onStoryFinished_()
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1011ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1011ui_story == nil then
				arg_84_1.var_.characterEffect1011ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1011ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1011ui_story then
				arg_84_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_87_4 = arg_84_1.actors_["3008ui_story"]
			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect3008ui_story == nil then
				arg_84_1.var_.characterEffect3008ui_story = var_87_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.1

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 and not isNil(var_87_4) then
				local var_87_7 = (arg_84_1.time_ - var_87_5) / var_87_6

				if arg_84_1.var_.characterEffect3008ui_story and not isNil(var_87_4) then
					local var_87_8 = Mathf.Lerp(0, 0.5, var_87_7)

					arg_84_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_84_1.var_.characterEffect3008ui_story.fillRatio = var_87_8
				end
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect3008ui_story then
				local var_87_9 = 0.5

				arg_84_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_84_1.var_.characterEffect3008ui_story.fillRatio = var_87_9
			end

			local var_87_10 = arg_84_1.actors_["3008ui_story"].transform
			local var_87_11 = 0

			if var_87_11 < arg_84_1.time_ and arg_84_1.time_ <= var_87_11 + arg_87_0 then
				arg_84_1.var_.moveOldPos3008ui_story = var_87_10.localPosition
			end

			local var_87_12 = 0.001

			if var_87_11 <= arg_84_1.time_ and arg_84_1.time_ < var_87_11 + var_87_12 then
				local var_87_13 = (arg_84_1.time_ - var_87_11) / var_87_12
				local var_87_14 = Vector3.New(0, 100, 0)

				var_87_10.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos3008ui_story, var_87_14, var_87_13)

				local var_87_15 = manager.ui.mainCamera.transform.position - var_87_10.position

				var_87_10.forward = Vector3.New(var_87_15.x, var_87_15.y, var_87_15.z)

				local var_87_16 = var_87_10.localEulerAngles

				var_87_16.z = 0
				var_87_16.x = 0
				var_87_10.localEulerAngles = var_87_16
			end

			if arg_84_1.time_ >= var_87_11 + var_87_12 and arg_84_1.time_ < var_87_11 + var_87_12 + arg_87_0 then
				var_87_10.localPosition = Vector3.New(0, 100, 0)

				local var_87_17 = manager.ui.mainCamera.transform.position - var_87_10.position

				var_87_10.forward = Vector3.New(var_87_17.x, var_87_17.y, var_87_17.z)

				local var_87_18 = var_87_10.localEulerAngles

				var_87_18.z = 0
				var_87_18.x = 0
				var_87_10.localEulerAngles = var_87_18
			end

			local var_87_19 = 0

			if var_87_19 < arg_84_1.time_ and arg_84_1.time_ <= var_87_19 + arg_87_0 then
				arg_84_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_87_20 = arg_84_1.actors_["1011ui_story"].transform
			local var_87_21 = 0

			if var_87_21 < arg_84_1.time_ and arg_84_1.time_ <= var_87_21 + arg_87_0 then
				arg_84_1.var_.moveOldPos1011ui_story = var_87_20.localPosition
			end

			local var_87_22 = 0.001

			if var_87_21 <= arg_84_1.time_ and arg_84_1.time_ < var_87_21 + var_87_22 then
				local var_87_23 = (arg_84_1.time_ - var_87_21) / var_87_22
				local var_87_24 = Vector3.New(0, -0.71, -6)

				var_87_20.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1011ui_story, var_87_24, var_87_23)

				local var_87_25 = manager.ui.mainCamera.transform.position - var_87_20.position

				var_87_20.forward = Vector3.New(var_87_25.x, var_87_25.y, var_87_25.z)

				local var_87_26 = var_87_20.localEulerAngles

				var_87_26.z = 0
				var_87_26.x = 0
				var_87_20.localEulerAngles = var_87_26
			end

			if arg_84_1.time_ >= var_87_21 + var_87_22 and arg_84_1.time_ < var_87_21 + var_87_22 + arg_87_0 then
				var_87_20.localPosition = Vector3.New(0, -0.71, -6)

				local var_87_27 = manager.ui.mainCamera.transform.position - var_87_20.position

				var_87_20.forward = Vector3.New(var_87_27.x, var_87_27.y, var_87_27.z)

				local var_87_28 = var_87_20.localEulerAngles

				var_87_28.z = 0
				var_87_28.x = 0
				var_87_20.localEulerAngles = var_87_28
			end

			local var_87_29 = 0

			if var_87_29 < arg_84_1.time_ and arg_84_1.time_ <= var_87_29 + arg_87_0 then
				arg_84_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_87_30 = 0
			local var_87_31 = 0.65

			if var_87_30 < arg_84_1.time_ and arg_84_1.time_ <= var_87_30 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_32 = arg_84_1:FormatText(StoryNameCfg[37].name)

				arg_84_1.leftNameTxt_.text = var_87_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_33 = arg_84_1:GetWordFromCfg(102061021)
				local var_87_34 = arg_84_1:FormatText(var_87_33.content)

				arg_84_1.text_.text = var_87_34

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_35 = 26
				local var_87_36 = utf8.len(var_87_34)
				local var_87_37 = var_87_35 <= 0 and var_87_31 or var_87_31 * (var_87_36 / var_87_35)

				if var_87_37 > 0 and var_87_31 < var_87_37 then
					arg_84_1.talkMaxDuration = var_87_37

					if var_87_37 + var_87_30 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_37 + var_87_30
					end
				end

				arg_84_1.text_.text = var_87_34
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102061", "102061021", "story_v_out_102061.awb") ~= 0 then
					local var_87_38 = manager.audio:GetVoiceLength("story_v_out_102061", "102061021", "story_v_out_102061.awb") / 1000

					if var_87_38 + var_87_30 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_38 + var_87_30
					end

					if var_87_33.prefab_name ~= "" and arg_84_1.actors_[var_87_33.prefab_name] ~= nil then
						local var_87_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_33.prefab_name].transform, "story_v_out_102061", "102061021", "story_v_out_102061.awb")

						arg_84_1:RecordAudio("102061021", var_87_39)
						arg_84_1:RecordAudio("102061021", var_87_39)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_102061", "102061021", "story_v_out_102061.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_102061", "102061021", "story_v_out_102061.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_40 = math.max(var_87_31, arg_84_1.talkMaxDuration)

			if var_87_30 <= arg_84_1.time_ and arg_84_1.time_ < var_87_30 + var_87_40 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_30) / var_87_40

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_30 + var_87_40 and arg_84_1.time_ < var_87_30 + var_87_40 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B02a"
	},
	voices = {
		"story_v_out_102061.awb"
	}
}
