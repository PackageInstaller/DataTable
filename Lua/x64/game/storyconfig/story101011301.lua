return {
	Play101131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101131001
		arg_1_1.duration_ = 7.3

		local var_1_0 = {
			ja = 7.3,
			ko = 5.5,
			zh = 7.133,
			en = 4.366
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
				arg_1_0:Play101131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

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

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory.awb")
			end

			local var_4_10 = "2020_tpose"

			if arg_1_1.actors_[var_4_10] == nil then
				local var_4_11 = Asset.Load("Char/" .. "2020_tpose")

				if not isNil(var_4_11) then
					local var_4_12 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_1_1.stage_.transform)

					var_4_12.name = var_4_10
					var_4_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_10] = var_4_12

					local var_4_13 = var_4_12:GetComponentInChildren(typeof(CharacterEffect))

					var_4_13.enabled = true

					local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_12, typeof(DynamicBoneHelper))

					if var_4_14 then
						var_4_14:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_13.transform, false)

					arg_1_1.var_[var_4_10 .. "Animator"] = var_4_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_10 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_10 .. "LipSync"] = var_4_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_15 = arg_1_1.actors_["2020_tpose"]
			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect2020_tpose == nil then
				arg_1_1.var_.characterEffect2020_tpose = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_17 = 0.1

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 and not isNil(var_4_15) then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17

				if arg_1_1.var_.characterEffect2020_tpose and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect2020_tpose then
				arg_1_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_4_19 = "B02f"

			if arg_1_1.bgs_[var_4_19] == nil then
				local var_4_20 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_19)
				var_4_20.name = var_4_19
				var_4_20.transform.parent = arg_1_1.stage_.transform
				var_4_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_19] = var_4_20
			end

			local var_4_21 = arg_1_1.bgs_.B02f
			local var_4_22 = 0

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_23 = var_4_21:GetComponent("SpriteRenderer")

				if var_4_23 then
					arg_1_1.var_.alphaOldValueB02f = var_4_23.color.a
					arg_1_1.var_.alphaMatValueB02f = var_4_23
				end

				arg_1_1.var_.alphaOldValueB02f = 0
			end

			local var_4_24 = 1.5

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_24 then
				local var_4_25 = (arg_1_1.time_ - var_4_22) / var_4_24
				local var_4_26 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB02f, 1, var_4_25)

				if arg_1_1.var_.alphaMatValueB02f then
					local var_4_27 = arg_1_1.var_.alphaMatValueB02f.color

					var_4_27.a = var_4_26
					arg_1_1.var_.alphaMatValueB02f.color = var_4_27
				end
			end

			if arg_1_1.time_ >= var_4_22 + var_4_24 and arg_1_1.time_ < var_4_22 + var_4_24 + arg_4_0 and arg_1_1.var_.alphaMatValueB02f then
				local var_4_28 = arg_1_1.var_.alphaMatValueB02f
				local var_4_29 = var_4_28.color

				var_4_29.a = 1
				var_4_28.color = var_4_29
			end

			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_31 = manager.ui.mainCamera.transform.localPosition
				local var_4_32 = Vector3.New(0, 0, 10) + Vector3.New(var_4_31.x, var_4_31.y, 0)
				local var_4_33 = arg_1_1.bgs_.B02f

				var_4_33.transform.localPosition = var_4_32
				var_4_33.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_34 = var_4_33:GetComponent("SpriteRenderer")

				if var_4_34 and var_4_34.sprite then
					local var_4_35 = (var_4_33.transform.localPosition - var_4_31).z
					local var_4_36 = manager.ui.mainCameraCom_
					local var_4_37 = 2 * var_4_35 * Mathf.Tan(var_4_36.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_38 = var_4_37 * var_4_36.aspect
					local var_4_39 = var_4_34.sprite.bounds.size.x
					local var_4_40 = var_4_34.sprite.bounds.size.y
					local var_4_41 = var_4_38 / var_4_39
					local var_4_42 = var_4_37 / var_4_40
					local var_4_43 = var_4_42 < var_4_41 and var_4_41 or var_4_42

					var_4_33.transform.localScale = Vector3.New(var_4_43, var_4_43, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B02f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_44 = arg_1_1.actors_["2020_tpose"].transform
			local var_4_45 = 1.79999995231628

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1.var_.moveOldPos2020_tpose = var_4_44.localPosition

				local var_4_46 = GameObjectTools.GetOrAddComponent(var_4_44.gameObject, typeof(DynamicBoneHelper))

				if var_4_46 then
					var_4_46:EnableDynamicBone(false)
				end
			end

			local var_4_47 = 0.001

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_47 then
				local var_4_48 = (arg_1_1.time_ - var_4_45) / var_4_47
				local var_4_49 = Vector3.New(0, -1.2, -4.1)

				var_4_44.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2020_tpose, var_4_49, var_4_48)

				local var_4_50 = manager.ui.mainCamera.transform.position - var_4_44.position

				var_4_44.forward = Vector3.New(var_4_50.x, var_4_50.y, var_4_50.z)

				local var_4_51 = var_4_44.localEulerAngles

				var_4_51.z = 0
				var_4_51.x = 0
				var_4_44.localEulerAngles = var_4_51
			end

			if arg_1_1.time_ >= var_4_45 + var_4_47 and arg_1_1.time_ < var_4_45 + var_4_47 + arg_4_0 then
				var_4_44.localPosition = Vector3.New(0, -1.2, -4.1)

				local var_4_52 = manager.ui.mainCamera.transform.position - var_4_44.position

				var_4_44.forward = Vector3.New(var_4_52.x, var_4_52.y, var_4_52.z)

				local var_4_53 = var_4_44.localEulerAngles

				var_4_53.z = 0
				var_4_53.x = 0
				var_4_44.localEulerAngles = var_4_53

				local var_4_54 = GameObjectTools.GetOrAddComponent(var_4_44.gameObject, typeof(DynamicBoneHelper))

				if var_4_54 then
					var_4_54:EnableDynamicBone(true)
				end
			end

			local var_4_55 = 0

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				arg_1_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_4_56 = 0

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_57 = 2

			if arg_1_1.time_ >= var_4_56 + var_4_57 and arg_1_1.time_ < var_4_56 + var_4_57 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_58 = 2
			local var_4_59 = 0.375

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_60 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_60:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_61 = arg_1_1:FormatText(StoryNameCfg[19].name)

				arg_1_1.leftNameTxt_.text = var_4_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_62 = arg_1_1:GetWordFromCfg(101131001)
				local var_4_63 = arg_1_1:FormatText(var_4_62.content)

				arg_1_1.text_.text = var_4_63

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_64 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131001", "story_v_out_101131.awb") ~= 0 then
					local var_4_67 = manager.audio:GetVoiceLength("story_v_out_101131", "101131001", "story_v_out_101131.awb") / 1000

					if var_4_67 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_58
					end

					if var_4_62.prefab_name ~= "" and arg_1_1.actors_[var_4_62.prefab_name] ~= nil then
						local var_4_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_62.prefab_name].transform, "story_v_out_101131", "101131001", "story_v_out_101131.awb")

						arg_1_1:RecordAudio("101131001", var_4_68)
						arg_1_1:RecordAudio("101131001", var_4_68)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_101131", "101131001", "story_v_out_101131.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_101131", "101131001", "story_v_out_101131.awb")
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
				actorName = "2020_tpose",
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
	Play101131002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 101131002
		arg_8_1.duration_ = 5.3

		local var_8_0 = {
			ja = 5.3,
			ko = 4.2,
			zh = 3,
			en = 3.533
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
				arg_8_0:Play101131003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1084ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentInChildren(typeof(CharacterEffect))

					var_11_3.enabled = true

					local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_2, typeof(DynamicBoneHelper))

					if var_11_4 then
						var_11_4:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_3.transform, false)

					arg_8_1.var_[var_11_0 .. "Animator"] = var_11_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_0 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_0 .. "LipSync"] = var_11_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_5 = arg_8_1.actors_["1084ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["2020_tpose"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect2020_tpose == nil then
				arg_8_1.var_.characterEffect2020_tpose = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.1

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect2020_tpose and not isNil(var_11_9) then
					local var_11_13 = Mathf.Lerp(0, 0.5, var_11_12)

					arg_8_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_8_1.var_.characterEffect2020_tpose.fillRatio = var_11_13
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect2020_tpose then
				local var_11_14 = 0.5

				arg_8_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_8_1.var_.characterEffect2020_tpose.fillRatio = var_11_14
			end

			local var_11_15 = arg_8_1.actors_["2020_tpose"].transform
			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.var_.moveOldPos2020_tpose = var_11_15.localPosition

				local var_11_17 = GameObjectTools.GetOrAddComponent(var_11_15.gameObject, typeof(DynamicBoneHelper))

				if var_11_17 then
					var_11_17:EnableDynamicBone(false)
				end
			end

			local var_11_18 = 0.001

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_18 then
				local var_11_19 = (arg_8_1.time_ - var_11_16) / var_11_18
				local var_11_20 = Vector3.New(0.7, -1.2, -4.1)

				var_11_15.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos2020_tpose, var_11_20, var_11_19)

				local var_11_21 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_21.x, var_11_21.y, var_11_21.z)

				local var_11_22 = var_11_15.localEulerAngles

				var_11_22.z = 0
				var_11_22.x = 0
				var_11_15.localEulerAngles = var_11_22
			end

			if arg_8_1.time_ >= var_11_16 + var_11_18 and arg_8_1.time_ < var_11_16 + var_11_18 + arg_11_0 then
				var_11_15.localPosition = Vector3.New(0.7, -1.2, -4.1)

				local var_11_23 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_23.x, var_11_23.y, var_11_23.z)

				local var_11_24 = var_11_15.localEulerAngles

				var_11_24.z = 0
				var_11_24.x = 0
				var_11_15.localEulerAngles = var_11_24

				local var_11_25 = GameObjectTools.GetOrAddComponent(var_11_15.gameObject, typeof(DynamicBoneHelper))

				if var_11_25 then
					var_11_25:EnableDynamicBone(true)
				end
			end

			local var_11_26 = arg_8_1.actors_["1084ui_story"].transform
			local var_11_27 = 0

			if var_11_27 < arg_8_1.time_ and arg_8_1.time_ <= var_11_27 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_26.localPosition
			end

			local var_11_28 = 0.001

			if var_11_27 <= arg_8_1.time_ and arg_8_1.time_ < var_11_27 + var_11_28 then
				local var_11_29 = (arg_8_1.time_ - var_11_27) / var_11_28
				local var_11_30 = Vector3.New(-0.7, -0.97, -6)

				var_11_26.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, var_11_30, var_11_29)

				local var_11_31 = manager.ui.mainCamera.transform.position - var_11_26.position

				var_11_26.forward = Vector3.New(var_11_31.x, var_11_31.y, var_11_31.z)

				local var_11_32 = var_11_26.localEulerAngles

				var_11_32.z = 0
				var_11_32.x = 0
				var_11_26.localEulerAngles = var_11_32
			end

			if arg_8_1.time_ >= var_11_27 + var_11_28 and arg_8_1.time_ < var_11_27 + var_11_28 + arg_11_0 then
				var_11_26.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_11_33 = manager.ui.mainCamera.transform.position - var_11_26.position

				var_11_26.forward = Vector3.New(var_11_33.x, var_11_33.y, var_11_33.z)

				local var_11_34 = var_11_26.localEulerAngles

				var_11_34.z = 0
				var_11_34.x = 0
				var_11_26.localEulerAngles = var_11_34
			end

			local var_11_35 = 0

			if var_11_35 < arg_8_1.time_ and arg_8_1.time_ <= var_11_35 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_11_36 = 0

			if var_11_36 < arg_8_1.time_ and arg_8_1.time_ <= var_11_36 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_11_37 = 0
			local var_11_38 = 0.35

			if var_11_37 < arg_8_1.time_ and arg_8_1.time_ <= var_11_37 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_39 = arg_8_1:FormatText(StoryNameCfg[6].name)

				arg_8_1.leftNameTxt_.text = var_11_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_40 = arg_8_1:GetWordFromCfg(101131002)
				local var_11_41 = arg_8_1:FormatText(var_11_40.content)

				arg_8_1.text_.text = var_11_41

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_42 = 12
				local var_11_43 = utf8.len(var_11_41)
				local var_11_44 = var_11_42 <= 0 and var_11_38 or var_11_38 * (var_11_43 / var_11_42)

				if var_11_44 > 0 and var_11_38 < var_11_44 then
					arg_8_1.talkMaxDuration = var_11_44

					if var_11_44 + var_11_37 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_44 + var_11_37
					end
				end

				arg_8_1.text_.text = var_11_41
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131002", "story_v_out_101131.awb") ~= 0 then
					local var_11_45 = manager.audio:GetVoiceLength("story_v_out_101131", "101131002", "story_v_out_101131.awb") / 1000

					if var_11_45 + var_11_37 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_45 + var_11_37
					end

					if var_11_40.prefab_name ~= "" and arg_8_1.actors_[var_11_40.prefab_name] ~= nil then
						local var_11_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_40.prefab_name].transform, "story_v_out_101131", "101131002", "story_v_out_101131.awb")

						arg_8_1:RecordAudio("101131002", var_11_46)
						arg_8_1:RecordAudio("101131002", var_11_46)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_101131", "101131002", "story_v_out_101131.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_101131", "101131002", "story_v_out_101131.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_47 = math.max(var_11_38, arg_8_1.talkMaxDuration)

			if var_11_37 <= arg_8_1.time_ and arg_8_1.time_ < var_11_37 + var_11_47 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_37) / var_11_47

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_37 + var_11_47 and arg_8_1.time_ < var_11_37 + var_11_47 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
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
	Play101131003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 101131003
		arg_12_1.duration_ = 4.6

		local var_12_0 = {
			ja = 4.6,
			ko = 1.999999999999,
			zh = 2,
			en = 1.999999999999
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
				arg_12_0:Play101131004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["2020_tpose"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect2020_tpose == nil then
				arg_12_1.var_.characterEffect2020_tpose = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect2020_tpose and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect2020_tpose then
				arg_12_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_15_4 = arg_12_1.actors_["1084ui_story"]
			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.1

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 and not isNil(var_15_4) then
				local var_15_7 = (arg_12_1.time_ - var_15_5) / var_15_6

				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_4) then
					local var_15_8 = Mathf.Lerp(0, 0.5, var_15_7)

					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_8
				end
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect1084ui_story then
				local var_15_9 = 0.5

				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_9
			end

			local var_15_10 = arg_12_1.actors_["2020_tpose"].transform
			local var_15_11 = 0

			if var_15_11 < arg_12_1.time_ and arg_12_1.time_ <= var_15_11 + arg_15_0 then
				arg_12_1.var_.moveOldPos2020_tpose = var_15_10.localPosition

				local var_15_12 = GameObjectTools.GetOrAddComponent(var_15_10.gameObject, typeof(DynamicBoneHelper))

				if var_15_12 then
					var_15_12:EnableDynamicBone(false)
				end
			end

			local var_15_13 = 0.001

			if var_15_11 <= arg_12_1.time_ and arg_12_1.time_ < var_15_11 + var_15_13 then
				local var_15_14 = (arg_12_1.time_ - var_15_11) / var_15_13
				local var_15_15 = Vector3.New(0.7, -1.2, -4.1)

				var_15_10.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos2020_tpose, var_15_15, var_15_14)

				local var_15_16 = manager.ui.mainCamera.transform.position - var_15_10.position

				var_15_10.forward = Vector3.New(var_15_16.x, var_15_16.y, var_15_16.z)

				local var_15_17 = var_15_10.localEulerAngles

				var_15_17.z = 0
				var_15_17.x = 0
				var_15_10.localEulerAngles = var_15_17
			end

			if arg_12_1.time_ >= var_15_11 + var_15_13 and arg_12_1.time_ < var_15_11 + var_15_13 + arg_15_0 then
				var_15_10.localPosition = Vector3.New(0.7, -1.2, -4.1)

				local var_15_18 = manager.ui.mainCamera.transform.position - var_15_10.position

				var_15_10.forward = Vector3.New(var_15_18.x, var_15_18.y, var_15_18.z)

				local var_15_19 = var_15_10.localEulerAngles

				var_15_19.z = 0
				var_15_19.x = 0
				var_15_10.localEulerAngles = var_15_19

				local var_15_20 = GameObjectTools.GetOrAddComponent(var_15_10.gameObject, typeof(DynamicBoneHelper))

				if var_15_20 then
					var_15_20:EnableDynamicBone(true)
				end
			end

			local var_15_21 = 0

			if var_15_21 < arg_12_1.time_ and arg_12_1.time_ <= var_15_21 + arg_15_0 then
				arg_12_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_15_22 = 0
			local var_15_23 = 0.15

			if var_15_22 < arg_12_1.time_ and arg_12_1.time_ <= var_15_22 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_24 = arg_12_1:FormatText(StoryNameCfg[19].name)

				arg_12_1.leftNameTxt_.text = var_15_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_25 = arg_12_1:GetWordFromCfg(101131003)
				local var_15_26 = arg_12_1:FormatText(var_15_25.content)

				arg_12_1.text_.text = var_15_26

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_27 = 6
				local var_15_28 = utf8.len(var_15_26)
				local var_15_29 = var_15_27 <= 0 and var_15_23 or var_15_23 * (var_15_28 / var_15_27)

				if var_15_29 > 0 and var_15_23 < var_15_29 then
					arg_12_1.talkMaxDuration = var_15_29

					if var_15_29 + var_15_22 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_29 + var_15_22
					end
				end

				arg_12_1.text_.text = var_15_26
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131003", "story_v_out_101131.awb") ~= 0 then
					local var_15_30 = manager.audio:GetVoiceLength("story_v_out_101131", "101131003", "story_v_out_101131.awb") / 1000

					if var_15_30 + var_15_22 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_30 + var_15_22
					end

					if var_15_25.prefab_name ~= "" and arg_12_1.actors_[var_15_25.prefab_name] ~= nil then
						local var_15_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_25.prefab_name].transform, "story_v_out_101131", "101131003", "story_v_out_101131.awb")

						arg_12_1:RecordAudio("101131003", var_15_31)
						arg_12_1:RecordAudio("101131003", var_15_31)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_101131", "101131003", "story_v_out_101131.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_101131", "101131003", "story_v_out_101131.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_32 = math.max(var_15_23, arg_12_1.talkMaxDuration)

			if var_15_22 <= arg_12_1.time_ and arg_12_1.time_ < var_15_22 + var_15_32 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_22) / var_15_32

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_22 + var_15_32 and arg_12_1.time_ < var_15_22 + var_15_32 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play101131004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 101131004
		arg_16_1.duration_ = 7.5

		local var_16_0 = {
			ja = 7.5,
			ko = 6.566,
			zh = 6.6,
			en = 6.333
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
				arg_16_0:Play101131005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1011ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["1011ui_story"]
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1011ui_story == nil then
				arg_16_1.var_.characterEffect1011ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 and not isNil(var_19_5) then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7

				if arg_16_1.var_.characterEffect1011ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1011ui_story then
				arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_19_9 = arg_16_1.actors_["2020_tpose"]
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect2020_tpose == nil then
				arg_16_1.var_.characterEffect2020_tpose = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_11 = 0.1

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 and not isNil(var_19_9) then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11

				if arg_16_1.var_.characterEffect2020_tpose and not isNil(var_19_9) then
					local var_19_13 = Mathf.Lerp(0, 0.5, var_19_12)

					arg_16_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_16_1.var_.characterEffect2020_tpose.fillRatio = var_19_13
				end
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect2020_tpose then
				local var_19_14 = 0.5

				arg_16_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_16_1.var_.characterEffect2020_tpose.fillRatio = var_19_14
			end

			local var_19_15 = arg_16_1.actors_["1084ui_story"].transform
			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_15.localPosition
			end

			local var_19_17 = 0.001

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_17 then
				local var_19_18 = (arg_16_1.time_ - var_19_16) / var_19_17
				local var_19_19 = Vector3.New(0, 100, 0)

				var_19_15.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, var_19_19, var_19_18)

				local var_19_20 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_20.x, var_19_20.y, var_19_20.z)

				local var_19_21 = var_19_15.localEulerAngles

				var_19_21.z = 0
				var_19_21.x = 0
				var_19_15.localEulerAngles = var_19_21
			end

			if arg_16_1.time_ >= var_19_16 + var_19_17 and arg_16_1.time_ < var_19_16 + var_19_17 + arg_19_0 then
				var_19_15.localPosition = Vector3.New(0, 100, 0)

				local var_19_22 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_22.x, var_19_22.y, var_19_22.z)

				local var_19_23 = var_19_15.localEulerAngles

				var_19_23.z = 0
				var_19_23.x = 0
				var_19_15.localEulerAngles = var_19_23
			end

			local var_19_24 = arg_16_1.actors_["1011ui_story"].transform
			local var_19_25 = 0

			if var_19_25 < arg_16_1.time_ and arg_16_1.time_ <= var_19_25 + arg_19_0 then
				arg_16_1.var_.moveOldPos1011ui_story = var_19_24.localPosition
			end

			local var_19_26 = 0.001

			if var_19_25 <= arg_16_1.time_ and arg_16_1.time_ < var_19_25 + var_19_26 then
				local var_19_27 = (arg_16_1.time_ - var_19_25) / var_19_26
				local var_19_28 = Vector3.New(-0.7, -0.71, -6)

				var_19_24.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1011ui_story, var_19_28, var_19_27)

				local var_19_29 = manager.ui.mainCamera.transform.position - var_19_24.position

				var_19_24.forward = Vector3.New(var_19_29.x, var_19_29.y, var_19_29.z)

				local var_19_30 = var_19_24.localEulerAngles

				var_19_30.z = 0
				var_19_30.x = 0
				var_19_24.localEulerAngles = var_19_30
			end

			if arg_16_1.time_ >= var_19_25 + var_19_26 and arg_16_1.time_ < var_19_25 + var_19_26 + arg_19_0 then
				var_19_24.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_19_31 = manager.ui.mainCamera.transform.position - var_19_24.position

				var_19_24.forward = Vector3.New(var_19_31.x, var_19_31.y, var_19_31.z)

				local var_19_32 = var_19_24.localEulerAngles

				var_19_32.z = 0
				var_19_32.x = 0
				var_19_24.localEulerAngles = var_19_32
			end

			local var_19_33 = 0

			if var_19_33 < arg_16_1.time_ and arg_16_1.time_ <= var_19_33 + arg_19_0 then
				arg_16_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_19_34 = 0

			if var_19_34 < arg_16_1.time_ and arg_16_1.time_ <= var_19_34 + arg_19_0 then
				arg_16_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_19_35 = 0
			local var_19_36 = 0.8

			if var_19_35 < arg_16_1.time_ and arg_16_1.time_ <= var_19_35 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_37 = arg_16_1:FormatText(StoryNameCfg[37].name)

				arg_16_1.leftNameTxt_.text = var_19_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_38 = arg_16_1:GetWordFromCfg(101131004)
				local var_19_39 = arg_16_1:FormatText(var_19_38.content)

				arg_16_1.text_.text = var_19_39

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_40 = 30
				local var_19_41 = utf8.len(var_19_39)
				local var_19_42 = var_19_40 <= 0 and var_19_36 or var_19_36 * (var_19_41 / var_19_40)

				if var_19_42 > 0 and var_19_36 < var_19_42 then
					arg_16_1.talkMaxDuration = var_19_42

					if var_19_42 + var_19_35 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_42 + var_19_35
					end
				end

				arg_16_1.text_.text = var_19_39
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131004", "story_v_out_101131.awb") ~= 0 then
					local var_19_43 = manager.audio:GetVoiceLength("story_v_out_101131", "101131004", "story_v_out_101131.awb") / 1000

					if var_19_43 + var_19_35 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_43 + var_19_35
					end

					if var_19_38.prefab_name ~= "" and arg_16_1.actors_[var_19_38.prefab_name] ~= nil then
						local var_19_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_38.prefab_name].transform, "story_v_out_101131", "101131004", "story_v_out_101131.awb")

						arg_16_1:RecordAudio("101131004", var_19_44)
						arg_16_1:RecordAudio("101131004", var_19_44)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_101131", "101131004", "story_v_out_101131.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_101131", "101131004", "story_v_out_101131.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_45 = math.max(var_19_36, arg_16_1.talkMaxDuration)

			if var_19_35 <= arg_16_1.time_ and arg_16_1.time_ < var_19_35 + var_19_45 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_35) / var_19_45

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_35 + var_19_45 and arg_16_1.time_ < var_19_35 + var_19_45 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
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
	Play101131005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 101131005
		arg_20_1.duration_ = 6.67

		local var_20_0 = {
			ja = 5.966,
			ko = 5.6,
			zh = 6.466,
			en = 6.666
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
				arg_20_0:Play101131006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "1019ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_20_1.stage_.transform)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

					var_23_3.enabled = true

					local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

					if var_23_4 then
						var_23_4:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_3.transform, false)

					arg_20_1.var_[var_23_0 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_0 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_0 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_5 = arg_20_1.actors_["1019ui_story"]
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_7 = 0.1

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 and not isNil(var_23_5) then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7

				if arg_20_1.var_.characterEffect1019ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1019ui_story then
				arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_23_9 = arg_20_1.actors_["2020_tpose"]
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect2020_tpose == nil then
				arg_20_1.var_.characterEffect2020_tpose = var_23_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.1

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 and not isNil(var_23_9) then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11

				if arg_20_1.var_.characterEffect2020_tpose and not isNil(var_23_9) then
					local var_23_13 = Mathf.Lerp(0, 0.5, var_23_12)

					arg_20_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_20_1.var_.characterEffect2020_tpose.fillRatio = var_23_13
				end
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect2020_tpose then
				local var_23_14 = 0.5

				arg_20_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_20_1.var_.characterEffect2020_tpose.fillRatio = var_23_14
			end

			local var_23_15 = arg_20_1.actors_["1011ui_story"].transform
			local var_23_16 = 0

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.var_.moveOldPos1011ui_story = var_23_15.localPosition
			end

			local var_23_17 = 0.001

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_17 then
				local var_23_18 = (arg_20_1.time_ - var_23_16) / var_23_17
				local var_23_19 = Vector3.New(0.7, -0.71, -6)

				var_23_15.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1011ui_story, var_23_19, var_23_18)

				local var_23_20 = manager.ui.mainCamera.transform.position - var_23_15.position

				var_23_15.forward = Vector3.New(var_23_20.x, var_23_20.y, var_23_20.z)

				local var_23_21 = var_23_15.localEulerAngles

				var_23_21.z = 0
				var_23_21.x = 0
				var_23_15.localEulerAngles = var_23_21
			end

			if arg_20_1.time_ >= var_23_16 + var_23_17 and arg_20_1.time_ < var_23_16 + var_23_17 + arg_23_0 then
				var_23_15.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_23_22 = manager.ui.mainCamera.transform.position - var_23_15.position

				var_23_15.forward = Vector3.New(var_23_22.x, var_23_22.y, var_23_22.z)

				local var_23_23 = var_23_15.localEulerAngles

				var_23_23.z = 0
				var_23_23.x = 0
				var_23_15.localEulerAngles = var_23_23
			end

			local var_23_24 = 0

			if var_23_24 < arg_20_1.time_ and arg_20_1.time_ <= var_23_24 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_23_25 = arg_20_1.actors_["1019ui_story"].transform
			local var_23_26 = 0

			if var_23_26 < arg_20_1.time_ and arg_20_1.time_ <= var_23_26 + arg_23_0 then
				arg_20_1.var_.moveOldPos1019ui_story = var_23_25.localPosition
			end

			local var_23_27 = 0.001

			if var_23_26 <= arg_20_1.time_ and arg_20_1.time_ < var_23_26 + var_23_27 then
				local var_23_28 = (arg_20_1.time_ - var_23_26) / var_23_27
				local var_23_29 = Vector3.New(-0.7, -1.08, -5.9)

				var_23_25.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1019ui_story, var_23_29, var_23_28)

				local var_23_30 = manager.ui.mainCamera.transform.position - var_23_25.position

				var_23_25.forward = Vector3.New(var_23_30.x, var_23_30.y, var_23_30.z)

				local var_23_31 = var_23_25.localEulerAngles

				var_23_31.z = 0
				var_23_31.x = 0
				var_23_25.localEulerAngles = var_23_31
			end

			if arg_20_1.time_ >= var_23_26 + var_23_27 and arg_20_1.time_ < var_23_26 + var_23_27 + arg_23_0 then
				var_23_25.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_23_32 = manager.ui.mainCamera.transform.position - var_23_25.position

				var_23_25.forward = Vector3.New(var_23_32.x, var_23_32.y, var_23_32.z)

				local var_23_33 = var_23_25.localEulerAngles

				var_23_33.z = 0
				var_23_33.x = 0
				var_23_25.localEulerAngles = var_23_33
			end

			local var_23_34 = 0

			if var_23_34 < arg_20_1.time_ and arg_20_1.time_ <= var_23_34 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_23_35 = arg_20_1.actors_["2020_tpose"].transform
			local var_23_36 = 0

			if var_23_36 < arg_20_1.time_ and arg_20_1.time_ <= var_23_36 + arg_23_0 then
				arg_20_1.var_.moveOldPos2020_tpose = var_23_35.localPosition

				local var_23_37 = GameObjectTools.GetOrAddComponent(var_23_35.gameObject, typeof(DynamicBoneHelper))

				if var_23_37 then
					var_23_37:EnableDynamicBone(false)
				end
			end

			local var_23_38 = 0.001

			if var_23_36 <= arg_20_1.time_ and arg_20_1.time_ < var_23_36 + var_23_38 then
				local var_23_39 = (arg_20_1.time_ - var_23_36) / var_23_38
				local var_23_40 = Vector3.New(0, 100, 0)

				var_23_35.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos2020_tpose, var_23_40, var_23_39)

				local var_23_41 = manager.ui.mainCamera.transform.position - var_23_35.position

				var_23_35.forward = Vector3.New(var_23_41.x, var_23_41.y, var_23_41.z)

				local var_23_42 = var_23_35.localEulerAngles

				var_23_42.z = 0
				var_23_42.x = 0
				var_23_35.localEulerAngles = var_23_42
			end

			if arg_20_1.time_ >= var_23_36 + var_23_38 and arg_20_1.time_ < var_23_36 + var_23_38 + arg_23_0 then
				var_23_35.localPosition = Vector3.New(0, 100, 0)

				local var_23_43 = manager.ui.mainCamera.transform.position - var_23_35.position

				var_23_35.forward = Vector3.New(var_23_43.x, var_23_43.y, var_23_43.z)

				local var_23_44 = var_23_35.localEulerAngles

				var_23_44.z = 0
				var_23_44.x = 0
				var_23_35.localEulerAngles = var_23_44

				local var_23_45 = GameObjectTools.GetOrAddComponent(var_23_35.gameObject, typeof(DynamicBoneHelper))

				if var_23_45 then
					var_23_45:EnableDynamicBone(true)
				end
			end

			local var_23_46 = 0
			local var_23_47 = 0.8

			if var_23_46 < arg_20_1.time_ and arg_20_1.time_ <= var_23_46 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_48 = arg_20_1:FormatText(StoryNameCfg[13].name)

				arg_20_1.leftNameTxt_.text = var_23_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_49 = arg_20_1:GetWordFromCfg(101131005)
				local var_23_50 = arg_20_1:FormatText(var_23_49.content)

				arg_20_1.text_.text = var_23_50

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_51 = 32
				local var_23_52 = utf8.len(var_23_50)
				local var_23_53 = var_23_51 <= 0 and var_23_47 or var_23_47 * (var_23_52 / var_23_51)

				if var_23_53 > 0 and var_23_47 < var_23_53 then
					arg_20_1.talkMaxDuration = var_23_53

					if var_23_53 + var_23_46 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_53 + var_23_46
					end
				end

				arg_20_1.text_.text = var_23_50
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131005", "story_v_out_101131.awb") ~= 0 then
					local var_23_54 = manager.audio:GetVoiceLength("story_v_out_101131", "101131005", "story_v_out_101131.awb") / 1000

					if var_23_54 + var_23_46 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_54 + var_23_46
					end

					if var_23_49.prefab_name ~= "" and arg_20_1.actors_[var_23_49.prefab_name] ~= nil then
						local var_23_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_49.prefab_name].transform, "story_v_out_101131", "101131005", "story_v_out_101131.awb")

						arg_20_1:RecordAudio("101131005", var_23_55)
						arg_20_1:RecordAudio("101131005", var_23_55)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_101131", "101131005", "story_v_out_101131.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_101131", "101131005", "story_v_out_101131.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_56 = math.max(var_23_47, arg_20_1.talkMaxDuration)

			if var_23_46 <= arg_20_1.time_ and arg_20_1.time_ < var_23_46 + var_23_56 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_46) / var_23_56

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_46 + var_23_56 and arg_20_1.time_ < var_23_46 + var_23_56 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play101131006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 101131006
		arg_24_1.duration_ = 2.93

		local var_24_0 = {
			ja = 2.933,
			ko = 2.7,
			zh = 2.833,
			en = 2.733
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
				arg_24_0:Play101131007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["2020_tpose"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect2020_tpose == nil then
				arg_24_1.var_.characterEffect2020_tpose = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect2020_tpose and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect2020_tpose then
				arg_24_1.var_.characterEffect2020_tpose.fillFlat = false
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

			local var_27_10 = arg_24_1.actors_["2020_tpose"].transform
			local var_27_11 = 0

			if var_27_11 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				arg_24_1.var_.moveOldPos2020_tpose = var_27_10.localPosition

				local var_27_12 = GameObjectTools.GetOrAddComponent(var_27_10.gameObject, typeof(DynamicBoneHelper))

				if var_27_12 then
					var_27_12:EnableDynamicBone(false)
				end
			end

			local var_27_13 = 0.001

			if var_27_11 <= arg_24_1.time_ and arg_24_1.time_ < var_27_11 + var_27_13 then
				local var_27_14 = (arg_24_1.time_ - var_27_11) / var_27_13
				local var_27_15 = Vector3.New(0, -1.2, -4.1)

				var_27_10.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos2020_tpose, var_27_15, var_27_14)

				local var_27_16 = manager.ui.mainCamera.transform.position - var_27_10.position

				var_27_10.forward = Vector3.New(var_27_16.x, var_27_16.y, var_27_16.z)

				local var_27_17 = var_27_10.localEulerAngles

				var_27_17.z = 0
				var_27_17.x = 0
				var_27_10.localEulerAngles = var_27_17
			end

			if arg_24_1.time_ >= var_27_11 + var_27_13 and arg_24_1.time_ < var_27_11 + var_27_13 + arg_27_0 then
				var_27_10.localPosition = Vector3.New(0, -1.2, -4.1)

				local var_27_18 = manager.ui.mainCamera.transform.position - var_27_10.position

				var_27_10.forward = Vector3.New(var_27_18.x, var_27_18.y, var_27_18.z)

				local var_27_19 = var_27_10.localEulerAngles

				var_27_19.z = 0
				var_27_19.x = 0
				var_27_10.localEulerAngles = var_27_19

				local var_27_20 = GameObjectTools.GetOrAddComponent(var_27_10.gameObject, typeof(DynamicBoneHelper))

				if var_27_20 then
					var_27_20:EnableDynamicBone(true)
				end
			end

			local var_27_21 = arg_24_1.actors_["1019ui_story"].transform
			local var_27_22 = 0

			if var_27_22 < arg_24_1.time_ and arg_24_1.time_ <= var_27_22 + arg_27_0 then
				arg_24_1.var_.moveOldPos1019ui_story = var_27_21.localPosition
			end

			local var_27_23 = 0.001

			if var_27_22 <= arg_24_1.time_ and arg_24_1.time_ < var_27_22 + var_27_23 then
				local var_27_24 = (arg_24_1.time_ - var_27_22) / var_27_23
				local var_27_25 = Vector3.New(0, 100, 0)

				var_27_21.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1019ui_story, var_27_25, var_27_24)

				local var_27_26 = manager.ui.mainCamera.transform.position - var_27_21.position

				var_27_21.forward = Vector3.New(var_27_26.x, var_27_26.y, var_27_26.z)

				local var_27_27 = var_27_21.localEulerAngles

				var_27_27.z = 0
				var_27_27.x = 0
				var_27_21.localEulerAngles = var_27_27
			end

			if arg_24_1.time_ >= var_27_22 + var_27_23 and arg_24_1.time_ < var_27_22 + var_27_23 + arg_27_0 then
				var_27_21.localPosition = Vector3.New(0, 100, 0)

				local var_27_28 = manager.ui.mainCamera.transform.position - var_27_21.position

				var_27_21.forward = Vector3.New(var_27_28.x, var_27_28.y, var_27_28.z)

				local var_27_29 = var_27_21.localEulerAngles

				var_27_29.z = 0
				var_27_29.x = 0
				var_27_21.localEulerAngles = var_27_29
			end

			local var_27_30 = arg_24_1.actors_["1011ui_story"].transform
			local var_27_31 = 0

			if var_27_31 < arg_24_1.time_ and arg_24_1.time_ <= var_27_31 + arg_27_0 then
				arg_24_1.var_.moveOldPos1011ui_story = var_27_30.localPosition
			end

			local var_27_32 = 0.001

			if var_27_31 <= arg_24_1.time_ and arg_24_1.time_ < var_27_31 + var_27_32 then
				local var_27_33 = (arg_24_1.time_ - var_27_31) / var_27_32
				local var_27_34 = Vector3.New(0, 100, 0)

				var_27_30.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1011ui_story, var_27_34, var_27_33)

				local var_27_35 = manager.ui.mainCamera.transform.position - var_27_30.position

				var_27_30.forward = Vector3.New(var_27_35.x, var_27_35.y, var_27_35.z)

				local var_27_36 = var_27_30.localEulerAngles

				var_27_36.z = 0
				var_27_36.x = 0
				var_27_30.localEulerAngles = var_27_36
			end

			if arg_24_1.time_ >= var_27_31 + var_27_32 and arg_24_1.time_ < var_27_31 + var_27_32 + arg_27_0 then
				var_27_30.localPosition = Vector3.New(0, 100, 0)

				local var_27_37 = manager.ui.mainCamera.transform.position - var_27_30.position

				var_27_30.forward = Vector3.New(var_27_37.x, var_27_37.y, var_27_37.z)

				local var_27_38 = var_27_30.localEulerAngles

				var_27_38.z = 0
				var_27_38.x = 0
				var_27_30.localEulerAngles = var_27_38
			end

			local var_27_39 = 0
			local var_27_40 = 0.325

			if var_27_39 < arg_24_1.time_ and arg_24_1.time_ <= var_27_39 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_41 = arg_24_1:FormatText(StoryNameCfg[19].name)

				arg_24_1.leftNameTxt_.text = var_27_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_42 = arg_24_1:GetWordFromCfg(101131006)
				local var_27_43 = arg_24_1:FormatText(var_27_42.content)

				arg_24_1.text_.text = var_27_43

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_44 = 12
				local var_27_45 = utf8.len(var_27_43)
				local var_27_46 = var_27_44 <= 0 and var_27_40 or var_27_40 * (var_27_45 / var_27_44)

				if var_27_46 > 0 and var_27_40 < var_27_46 then
					arg_24_1.talkMaxDuration = var_27_46

					if var_27_46 + var_27_39 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_46 + var_27_39
					end
				end

				arg_24_1.text_.text = var_27_43
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131006", "story_v_out_101131.awb") ~= 0 then
					local var_27_47 = manager.audio:GetVoiceLength("story_v_out_101131", "101131006", "story_v_out_101131.awb") / 1000

					if var_27_47 + var_27_39 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_47 + var_27_39
					end

					if var_27_42.prefab_name ~= "" and arg_24_1.actors_[var_27_42.prefab_name] ~= nil then
						local var_27_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_42.prefab_name].transform, "story_v_out_101131", "101131006", "story_v_out_101131.awb")

						arg_24_1:RecordAudio("101131006", var_27_48)
						arg_24_1:RecordAudio("101131006", var_27_48)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_101131", "101131006", "story_v_out_101131.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_101131", "101131006", "story_v_out_101131.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_49 = math.max(var_27_40, arg_24_1.talkMaxDuration)

			if var_27_39 <= arg_24_1.time_ and arg_24_1.time_ < var_27_39 + var_27_49 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_39) / var_27_49

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_39 + var_27_49 and arg_24_1.time_ < var_27_39 + var_27_49 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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

		arg_24_1:InitPlayNodeList()
	end,
	Play101131007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 101131007
		arg_28_1.duration_ = 7.73

		local var_28_0 = {
			ja = 7.733,
			ko = 6.033,
			zh = 5,
			en = 3.766
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
				arg_28_0:Play101131008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1019ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["2020_tpose"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect2020_tpose == nil then
				arg_28_1.var_.characterEffect2020_tpose = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.1

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect2020_tpose and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_28_1.var_.characterEffect2020_tpose.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect2020_tpose then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_28_1.var_.characterEffect2020_tpose.fillRatio = var_31_9
			end

			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_31_11 = arg_28_1.actors_["1019ui_story"].transform
			local var_31_12 = 0

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.var_.moveOldPos1019ui_story = var_31_11.localPosition
			end

			local var_31_13 = 0.001

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_13 then
				local var_31_14 = (arg_28_1.time_ - var_31_12) / var_31_13
				local var_31_15 = Vector3.New(-0.7, -1.08, -5.9)

				var_31_11.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1019ui_story, var_31_15, var_31_14)

				local var_31_16 = manager.ui.mainCamera.transform.position - var_31_11.position

				var_31_11.forward = Vector3.New(var_31_16.x, var_31_16.y, var_31_16.z)

				local var_31_17 = var_31_11.localEulerAngles

				var_31_17.z = 0
				var_31_17.x = 0
				var_31_11.localEulerAngles = var_31_17
			end

			if arg_28_1.time_ >= var_31_12 + var_31_13 and arg_28_1.time_ < var_31_12 + var_31_13 + arg_31_0 then
				var_31_11.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_31_18 = manager.ui.mainCamera.transform.position - var_31_11.position

				var_31_11.forward = Vector3.New(var_31_18.x, var_31_18.y, var_31_18.z)

				local var_31_19 = var_31_11.localEulerAngles

				var_31_19.z = 0
				var_31_19.x = 0
				var_31_11.localEulerAngles = var_31_19
			end

			local var_31_20 = arg_28_1.actors_["1011ui_story"].transform
			local var_31_21 = 0

			if var_31_21 < arg_28_1.time_ and arg_28_1.time_ <= var_31_21 + arg_31_0 then
				arg_28_1.var_.moveOldPos1011ui_story = var_31_20.localPosition
			end

			local var_31_22 = 0.001

			if var_31_21 <= arg_28_1.time_ and arg_28_1.time_ < var_31_21 + var_31_22 then
				local var_31_23 = (arg_28_1.time_ - var_31_21) / var_31_22
				local var_31_24 = Vector3.New(0.7, -0.71, -6)

				var_31_20.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1011ui_story, var_31_24, var_31_23)

				local var_31_25 = manager.ui.mainCamera.transform.position - var_31_20.position

				var_31_20.forward = Vector3.New(var_31_25.x, var_31_25.y, var_31_25.z)

				local var_31_26 = var_31_20.localEulerAngles

				var_31_26.z = 0
				var_31_26.x = 0
				var_31_20.localEulerAngles = var_31_26
			end

			if arg_28_1.time_ >= var_31_21 + var_31_22 and arg_28_1.time_ < var_31_21 + var_31_22 + arg_31_0 then
				var_31_20.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_31_27 = manager.ui.mainCamera.transform.position - var_31_20.position

				var_31_20.forward = Vector3.New(var_31_27.x, var_31_27.y, var_31_27.z)

				local var_31_28 = var_31_20.localEulerAngles

				var_31_28.z = 0
				var_31_28.x = 0
				var_31_20.localEulerAngles = var_31_28
			end

			local var_31_29 = arg_28_1.actors_["2020_tpose"].transform
			local var_31_30 = 0

			if var_31_30 < arg_28_1.time_ and arg_28_1.time_ <= var_31_30 + arg_31_0 then
				arg_28_1.var_.moveOldPos2020_tpose = var_31_29.localPosition

				local var_31_31 = GameObjectTools.GetOrAddComponent(var_31_29.gameObject, typeof(DynamicBoneHelper))

				if var_31_31 then
					var_31_31:EnableDynamicBone(false)
				end
			end

			local var_31_32 = 0.001

			if var_31_30 <= arg_28_1.time_ and arg_28_1.time_ < var_31_30 + var_31_32 then
				local var_31_33 = (arg_28_1.time_ - var_31_30) / var_31_32
				local var_31_34 = Vector3.New(0, 100, 0)

				var_31_29.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos2020_tpose, var_31_34, var_31_33)

				local var_31_35 = manager.ui.mainCamera.transform.position - var_31_29.position

				var_31_29.forward = Vector3.New(var_31_35.x, var_31_35.y, var_31_35.z)

				local var_31_36 = var_31_29.localEulerAngles

				var_31_36.z = 0
				var_31_36.x = 0
				var_31_29.localEulerAngles = var_31_36
			end

			if arg_28_1.time_ >= var_31_30 + var_31_32 and arg_28_1.time_ < var_31_30 + var_31_32 + arg_31_0 then
				var_31_29.localPosition = Vector3.New(0, 100, 0)

				local var_31_37 = manager.ui.mainCamera.transform.position - var_31_29.position

				var_31_29.forward = Vector3.New(var_31_37.x, var_31_37.y, var_31_37.z)

				local var_31_38 = var_31_29.localEulerAngles

				var_31_38.z = 0
				var_31_38.x = 0
				var_31_29.localEulerAngles = var_31_38

				local var_31_39 = GameObjectTools.GetOrAddComponent(var_31_29.gameObject, typeof(DynamicBoneHelper))

				if var_31_39 then
					var_31_39:EnableDynamicBone(true)
				end
			end

			local var_31_40 = 0
			local var_31_41 = 0.725

			if var_31_40 < arg_28_1.time_ and arg_28_1.time_ <= var_31_40 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_42 = arg_28_1:FormatText(StoryNameCfg[13].name)

				arg_28_1.leftNameTxt_.text = var_31_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_43 = arg_28_1:GetWordFromCfg(101131007)
				local var_31_44 = arg_28_1:FormatText(var_31_43.content)

				arg_28_1.text_.text = var_31_44

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_45 = 27
				local var_31_46 = utf8.len(var_31_44)
				local var_31_47 = var_31_45 <= 0 and var_31_41 or var_31_41 * (var_31_46 / var_31_45)

				if var_31_47 > 0 and var_31_41 < var_31_47 then
					arg_28_1.talkMaxDuration = var_31_47

					if var_31_47 + var_31_40 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_47 + var_31_40
					end
				end

				arg_28_1.text_.text = var_31_44
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131007", "story_v_out_101131.awb") ~= 0 then
					local var_31_48 = manager.audio:GetVoiceLength("story_v_out_101131", "101131007", "story_v_out_101131.awb") / 1000

					if var_31_48 + var_31_40 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_48 + var_31_40
					end

					if var_31_43.prefab_name ~= "" and arg_28_1.actors_[var_31_43.prefab_name] ~= nil then
						local var_31_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_43.prefab_name].transform, "story_v_out_101131", "101131007", "story_v_out_101131.awb")

						arg_28_1:RecordAudio("101131007", var_31_49)
						arg_28_1:RecordAudio("101131007", var_31_49)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_101131", "101131007", "story_v_out_101131.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_101131", "101131007", "story_v_out_101131.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_50 = math.max(var_31_41, arg_28_1.talkMaxDuration)

			if var_31_40 <= arg_28_1.time_ and arg_28_1.time_ < var_31_40 + var_31_50 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_40) / var_31_50

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_40 + var_31_50 and arg_28_1.time_ < var_31_40 + var_31_50 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play101131008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 101131008
		arg_32_1.duration_ = 7.63

		local var_32_0 = {
			ja = 5.833,
			ko = 7.633,
			zh = 5.933,
			en = 6.166
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
				arg_32_0:Play101131009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["2020_tpose"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect2020_tpose == nil then
				arg_32_1.var_.characterEffect2020_tpose = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect2020_tpose and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect2020_tpose then
				arg_32_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["1019ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.1

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect1019ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1019ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1019ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1019ui_story.fillRatio = var_35_9
			end

			local var_35_10 = arg_32_1.actors_["1019ui_story"].transform
			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.var_.moveOldPos1019ui_story = var_35_10.localPosition
			end

			local var_35_12 = 0.001

			if var_35_11 <= arg_32_1.time_ and arg_32_1.time_ < var_35_11 + var_35_12 then
				local var_35_13 = (arg_32_1.time_ - var_35_11) / var_35_12
				local var_35_14 = Vector3.New(0, 100, 0)

				var_35_10.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1019ui_story, var_35_14, var_35_13)

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

			local var_35_19 = arg_32_1.actors_["1011ui_story"].transform
			local var_35_20 = 0

			if var_35_20 < arg_32_1.time_ and arg_32_1.time_ <= var_35_20 + arg_35_0 then
				arg_32_1.var_.moveOldPos1011ui_story = var_35_19.localPosition
			end

			local var_35_21 = 0.001

			if var_35_20 <= arg_32_1.time_ and arg_32_1.time_ < var_35_20 + var_35_21 then
				local var_35_22 = (arg_32_1.time_ - var_35_20) / var_35_21
				local var_35_23 = Vector3.New(0, 100, 0)

				var_35_19.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1011ui_story, var_35_23, var_35_22)

				local var_35_24 = manager.ui.mainCamera.transform.position - var_35_19.position

				var_35_19.forward = Vector3.New(var_35_24.x, var_35_24.y, var_35_24.z)

				local var_35_25 = var_35_19.localEulerAngles

				var_35_25.z = 0
				var_35_25.x = 0
				var_35_19.localEulerAngles = var_35_25
			end

			if arg_32_1.time_ >= var_35_20 + var_35_21 and arg_32_1.time_ < var_35_20 + var_35_21 + arg_35_0 then
				var_35_19.localPosition = Vector3.New(0, 100, 0)

				local var_35_26 = manager.ui.mainCamera.transform.position - var_35_19.position

				var_35_19.forward = Vector3.New(var_35_26.x, var_35_26.y, var_35_26.z)

				local var_35_27 = var_35_19.localEulerAngles

				var_35_27.z = 0
				var_35_27.x = 0
				var_35_19.localEulerAngles = var_35_27
			end

			local var_35_28 = arg_32_1.actors_["2020_tpose"].transform
			local var_35_29 = 0

			if var_35_29 < arg_32_1.time_ and arg_32_1.time_ <= var_35_29 + arg_35_0 then
				arg_32_1.var_.moveOldPos2020_tpose = var_35_28.localPosition

				local var_35_30 = GameObjectTools.GetOrAddComponent(var_35_28.gameObject, typeof(DynamicBoneHelper))

				if var_35_30 then
					var_35_30:EnableDynamicBone(false)
				end
			end

			local var_35_31 = 0.001

			if var_35_29 <= arg_32_1.time_ and arg_32_1.time_ < var_35_29 + var_35_31 then
				local var_35_32 = (arg_32_1.time_ - var_35_29) / var_35_31
				local var_35_33 = Vector3.New(0, -1.2, -4.1)

				var_35_28.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos2020_tpose, var_35_33, var_35_32)

				local var_35_34 = manager.ui.mainCamera.transform.position - var_35_28.position

				var_35_28.forward = Vector3.New(var_35_34.x, var_35_34.y, var_35_34.z)

				local var_35_35 = var_35_28.localEulerAngles

				var_35_35.z = 0
				var_35_35.x = 0
				var_35_28.localEulerAngles = var_35_35
			end

			if arg_32_1.time_ >= var_35_29 + var_35_31 and arg_32_1.time_ < var_35_29 + var_35_31 + arg_35_0 then
				var_35_28.localPosition = Vector3.New(0, -1.2, -4.1)

				local var_35_36 = manager.ui.mainCamera.transform.position - var_35_28.position

				var_35_28.forward = Vector3.New(var_35_36.x, var_35_36.y, var_35_36.z)

				local var_35_37 = var_35_28.localEulerAngles

				var_35_37.z = 0
				var_35_37.x = 0
				var_35_28.localEulerAngles = var_35_37

				local var_35_38 = GameObjectTools.GetOrAddComponent(var_35_28.gameObject, typeof(DynamicBoneHelper))

				if var_35_38 then
					var_35_38:EnableDynamicBone(true)
				end
			end

			local var_35_39 = 0
			local var_35_40 = 0.875

			if var_35_39 < arg_32_1.time_ and arg_32_1.time_ <= var_35_39 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_41 = arg_32_1:FormatText(StoryNameCfg[19].name)

				arg_32_1.leftNameTxt_.text = var_35_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_42 = arg_32_1:GetWordFromCfg(101131008)
				local var_35_43 = arg_32_1:FormatText(var_35_42.content)

				arg_32_1.text_.text = var_35_43

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_44 = 33
				local var_35_45 = utf8.len(var_35_43)
				local var_35_46 = var_35_44 <= 0 and var_35_40 or var_35_40 * (var_35_45 / var_35_44)

				if var_35_46 > 0 and var_35_40 < var_35_46 then
					arg_32_1.talkMaxDuration = var_35_46

					if var_35_46 + var_35_39 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_46 + var_35_39
					end
				end

				arg_32_1.text_.text = var_35_43
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131008", "story_v_out_101131.awb") ~= 0 then
					local var_35_47 = manager.audio:GetVoiceLength("story_v_out_101131", "101131008", "story_v_out_101131.awb") / 1000

					if var_35_47 + var_35_39 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_47 + var_35_39
					end

					if var_35_42.prefab_name ~= "" and arg_32_1.actors_[var_35_42.prefab_name] ~= nil then
						local var_35_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_42.prefab_name].transform, "story_v_out_101131", "101131008", "story_v_out_101131.awb")

						arg_32_1:RecordAudio("101131008", var_35_48)
						arg_32_1:RecordAudio("101131008", var_35_48)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_101131", "101131008", "story_v_out_101131.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_101131", "101131008", "story_v_out_101131.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_49 = math.max(var_35_40, arg_32_1.talkMaxDuration)

			if var_35_39 <= arg_32_1.time_ and arg_32_1.time_ < var_35_39 + var_35_49 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_39) / var_35_49

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_39 + var_35_49 and arg_32_1.time_ < var_35_39 + var_35_49 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play101131009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 101131009
		arg_36_1.duration_ = 5

		local var_36_0 = {
			ja = 5,
			ko = 4.166,
			zh = 3.5,
			en = 4.333
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
				arg_36_0:Play101131010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1019ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1019ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1019ui_story then
				arg_36_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["2020_tpose"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect2020_tpose == nil then
				arg_36_1.var_.characterEffect2020_tpose = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.1

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect2020_tpose and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_36_1.var_.characterEffect2020_tpose.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect2020_tpose then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_36_1.var_.characterEffect2020_tpose.fillRatio = var_39_9
			end

			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_39_11 = arg_36_1.actors_["1019ui_story"].transform
			local var_39_12 = 0

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.var_.moveOldPos1019ui_story = var_39_11.localPosition
			end

			local var_39_13 = 0.001

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_13 then
				local var_39_14 = (arg_36_1.time_ - var_39_12) / var_39_13
				local var_39_15 = Vector3.New(-0.7, -1.08, -5.9)

				var_39_11.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1019ui_story, var_39_15, var_39_14)

				local var_39_16 = manager.ui.mainCamera.transform.position - var_39_11.position

				var_39_11.forward = Vector3.New(var_39_16.x, var_39_16.y, var_39_16.z)

				local var_39_17 = var_39_11.localEulerAngles

				var_39_17.z = 0
				var_39_17.x = 0
				var_39_11.localEulerAngles = var_39_17
			end

			if arg_36_1.time_ >= var_39_12 + var_39_13 and arg_36_1.time_ < var_39_12 + var_39_13 + arg_39_0 then
				var_39_11.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_39_18 = manager.ui.mainCamera.transform.position - var_39_11.position

				var_39_11.forward = Vector3.New(var_39_18.x, var_39_18.y, var_39_18.z)

				local var_39_19 = var_39_11.localEulerAngles

				var_39_19.z = 0
				var_39_19.x = 0
				var_39_11.localEulerAngles = var_39_19
			end

			local var_39_20 = arg_36_1.actors_["1011ui_story"].transform
			local var_39_21 = 0

			if var_39_21 < arg_36_1.time_ and arg_36_1.time_ <= var_39_21 + arg_39_0 then
				arg_36_1.var_.moveOldPos1011ui_story = var_39_20.localPosition
			end

			local var_39_22 = 0.001

			if var_39_21 <= arg_36_1.time_ and arg_36_1.time_ < var_39_21 + var_39_22 then
				local var_39_23 = (arg_36_1.time_ - var_39_21) / var_39_22
				local var_39_24 = Vector3.New(0.7, -0.71, -6)

				var_39_20.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1011ui_story, var_39_24, var_39_23)

				local var_39_25 = manager.ui.mainCamera.transform.position - var_39_20.position

				var_39_20.forward = Vector3.New(var_39_25.x, var_39_25.y, var_39_25.z)

				local var_39_26 = var_39_20.localEulerAngles

				var_39_26.z = 0
				var_39_26.x = 0
				var_39_20.localEulerAngles = var_39_26
			end

			if arg_36_1.time_ >= var_39_21 + var_39_22 and arg_36_1.time_ < var_39_21 + var_39_22 + arg_39_0 then
				var_39_20.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_39_27 = manager.ui.mainCamera.transform.position - var_39_20.position

				var_39_20.forward = Vector3.New(var_39_27.x, var_39_27.y, var_39_27.z)

				local var_39_28 = var_39_20.localEulerAngles

				var_39_28.z = 0
				var_39_28.x = 0
				var_39_20.localEulerAngles = var_39_28
			end

			local var_39_29 = arg_36_1.actors_["2020_tpose"].transform
			local var_39_30 = 0

			if var_39_30 < arg_36_1.time_ and arg_36_1.time_ <= var_39_30 + arg_39_0 then
				arg_36_1.var_.moveOldPos2020_tpose = var_39_29.localPosition

				local var_39_31 = GameObjectTools.GetOrAddComponent(var_39_29.gameObject, typeof(DynamicBoneHelper))

				if var_39_31 then
					var_39_31:EnableDynamicBone(false)
				end
			end

			local var_39_32 = 0.001

			if var_39_30 <= arg_36_1.time_ and arg_36_1.time_ < var_39_30 + var_39_32 then
				local var_39_33 = (arg_36_1.time_ - var_39_30) / var_39_32
				local var_39_34 = Vector3.New(0, 100, 0)

				var_39_29.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos2020_tpose, var_39_34, var_39_33)

				local var_39_35 = manager.ui.mainCamera.transform.position - var_39_29.position

				var_39_29.forward = Vector3.New(var_39_35.x, var_39_35.y, var_39_35.z)

				local var_39_36 = var_39_29.localEulerAngles

				var_39_36.z = 0
				var_39_36.x = 0
				var_39_29.localEulerAngles = var_39_36
			end

			if arg_36_1.time_ >= var_39_30 + var_39_32 and arg_36_1.time_ < var_39_30 + var_39_32 + arg_39_0 then
				var_39_29.localPosition = Vector3.New(0, 100, 0)

				local var_39_37 = manager.ui.mainCamera.transform.position - var_39_29.position

				var_39_29.forward = Vector3.New(var_39_37.x, var_39_37.y, var_39_37.z)

				local var_39_38 = var_39_29.localEulerAngles

				var_39_38.z = 0
				var_39_38.x = 0
				var_39_29.localEulerAngles = var_39_38

				local var_39_39 = GameObjectTools.GetOrAddComponent(var_39_29.gameObject, typeof(DynamicBoneHelper))

				if var_39_39 then
					var_39_39:EnableDynamicBone(true)
				end
			end

			local var_39_40 = 0
			local var_39_41 = 0.375

			if var_39_40 < arg_36_1.time_ and arg_36_1.time_ <= var_39_40 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_42 = arg_36_1:FormatText(StoryNameCfg[13].name)

				arg_36_1.leftNameTxt_.text = var_39_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_43 = arg_36_1:GetWordFromCfg(101131009)
				local var_39_44 = arg_36_1:FormatText(var_39_43.content)

				arg_36_1.text_.text = var_39_44

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_45 = 15
				local var_39_46 = utf8.len(var_39_44)
				local var_39_47 = var_39_45 <= 0 and var_39_41 or var_39_41 * (var_39_46 / var_39_45)

				if var_39_47 > 0 and var_39_41 < var_39_47 then
					arg_36_1.talkMaxDuration = var_39_47

					if var_39_47 + var_39_40 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_47 + var_39_40
					end
				end

				arg_36_1.text_.text = var_39_44
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131009", "story_v_out_101131.awb") ~= 0 then
					local var_39_48 = manager.audio:GetVoiceLength("story_v_out_101131", "101131009", "story_v_out_101131.awb") / 1000

					if var_39_48 + var_39_40 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_48 + var_39_40
					end

					if var_39_43.prefab_name ~= "" and arg_36_1.actors_[var_39_43.prefab_name] ~= nil then
						local var_39_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_43.prefab_name].transform, "story_v_out_101131", "101131009", "story_v_out_101131.awb")

						arg_36_1:RecordAudio("101131009", var_39_49)
						arg_36_1:RecordAudio("101131009", var_39_49)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_101131", "101131009", "story_v_out_101131.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_101131", "101131009", "story_v_out_101131.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_50 = math.max(var_39_41, arg_36_1.talkMaxDuration)

			if var_39_40 <= arg_36_1.time_ and arg_36_1.time_ < var_39_40 + var_39_50 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_40) / var_39_50

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_40 + var_39_50 and arg_36_1.time_ < var_39_40 + var_39_50 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play101131010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 101131010
		arg_40_1.duration_ = 2.2

		local var_40_0 = {
			ja = 1.766,
			ko = 1.8,
			zh = 1.666,
			en = 2.2
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
				arg_40_0:Play101131011(arg_40_1)
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

			local var_43_4 = arg_40_1.actors_["2020_tpose"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect2020_tpose == nil then
				arg_40_1.var_.characterEffect2020_tpose = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.1

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect2020_tpose and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_40_1.var_.characterEffect2020_tpose.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect2020_tpose then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_40_1.var_.characterEffect2020_tpose.fillRatio = var_43_9
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_43_11 = 0
			local var_43_12 = 0.175

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_13 = arg_40_1:FormatText(StoryNameCfg[13].name)

				arg_40_1.leftNameTxt_.text = var_43_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_14 = arg_40_1:GetWordFromCfg(101131010)
				local var_43_15 = arg_40_1:FormatText(var_43_14.content)

				arg_40_1.text_.text = var_43_15

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_16 = 7
				local var_43_17 = utf8.len(var_43_15)
				local var_43_18 = var_43_16 <= 0 and var_43_12 or var_43_12 * (var_43_17 / var_43_16)

				if var_43_18 > 0 and var_43_12 < var_43_18 then
					arg_40_1.talkMaxDuration = var_43_18

					if var_43_18 + var_43_11 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_18 + var_43_11
					end
				end

				arg_40_1.text_.text = var_43_15
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131010", "story_v_out_101131.awb") ~= 0 then
					local var_43_19 = manager.audio:GetVoiceLength("story_v_out_101131", "101131010", "story_v_out_101131.awb") / 1000

					if var_43_19 + var_43_11 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_11
					end

					if var_43_14.prefab_name ~= "" and arg_40_1.actors_[var_43_14.prefab_name] ~= nil then
						local var_43_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_14.prefab_name].transform, "story_v_out_101131", "101131010", "story_v_out_101131.awb")

						arg_40_1:RecordAudio("101131010", var_43_20)
						arg_40_1:RecordAudio("101131010", var_43_20)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_101131", "101131010", "story_v_out_101131.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_101131", "101131010", "story_v_out_101131.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_21 = math.max(var_43_12, arg_40_1.talkMaxDuration)

			if var_43_11 <= arg_40_1.time_ and arg_40_1.time_ < var_43_11 + var_43_21 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_11) / var_43_21

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_11 + var_43_21 and arg_40_1.time_ < var_43_11 + var_43_21 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play101131011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 101131011
		arg_44_1.duration_ = 9.23

		local var_44_0 = {
			ja = 9.233,
			ko = 7.966,
			zh = 7.133,
			en = 6.433
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
				arg_44_0:Play101131012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["2020_tpose"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect2020_tpose == nil then
				arg_44_1.var_.characterEffect2020_tpose = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect2020_tpose and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect2020_tpose then
				arg_44_1.var_.characterEffect2020_tpose.fillFlat = false
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

			local var_47_10 = arg_44_1.actors_["1019ui_story"].transform
			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.var_.moveOldPos1019ui_story = var_47_10.localPosition
			end

			local var_47_12 = 0.001

			if var_47_11 <= arg_44_1.time_ and arg_44_1.time_ < var_47_11 + var_47_12 then
				local var_47_13 = (arg_44_1.time_ - var_47_11) / var_47_12
				local var_47_14 = Vector3.New(0, 100, 0)

				var_47_10.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1019ui_story, var_47_14, var_47_13)

				local var_47_15 = manager.ui.mainCamera.transform.position - var_47_10.position

				var_47_10.forward = Vector3.New(var_47_15.x, var_47_15.y, var_47_15.z)

				local var_47_16 = var_47_10.localEulerAngles

				var_47_16.z = 0
				var_47_16.x = 0
				var_47_10.localEulerAngles = var_47_16
			end

			if arg_44_1.time_ >= var_47_11 + var_47_12 and arg_44_1.time_ < var_47_11 + var_47_12 + arg_47_0 then
				var_47_10.localPosition = Vector3.New(0, 100, 0)

				local var_47_17 = manager.ui.mainCamera.transform.position - var_47_10.position

				var_47_10.forward = Vector3.New(var_47_17.x, var_47_17.y, var_47_17.z)

				local var_47_18 = var_47_10.localEulerAngles

				var_47_18.z = 0
				var_47_18.x = 0
				var_47_10.localEulerAngles = var_47_18
			end

			local var_47_19 = arg_44_1.actors_["1011ui_story"].transform
			local var_47_20 = 0

			if var_47_20 < arg_44_1.time_ and arg_44_1.time_ <= var_47_20 + arg_47_0 then
				arg_44_1.var_.moveOldPos1011ui_story = var_47_19.localPosition
			end

			local var_47_21 = 0.001

			if var_47_20 <= arg_44_1.time_ and arg_44_1.time_ < var_47_20 + var_47_21 then
				local var_47_22 = (arg_44_1.time_ - var_47_20) / var_47_21
				local var_47_23 = Vector3.New(0, 100, 0)

				var_47_19.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1011ui_story, var_47_23, var_47_22)

				local var_47_24 = manager.ui.mainCamera.transform.position - var_47_19.position

				var_47_19.forward = Vector3.New(var_47_24.x, var_47_24.y, var_47_24.z)

				local var_47_25 = var_47_19.localEulerAngles

				var_47_25.z = 0
				var_47_25.x = 0
				var_47_19.localEulerAngles = var_47_25
			end

			if arg_44_1.time_ >= var_47_20 + var_47_21 and arg_44_1.time_ < var_47_20 + var_47_21 + arg_47_0 then
				var_47_19.localPosition = Vector3.New(0, 100, 0)

				local var_47_26 = manager.ui.mainCamera.transform.position - var_47_19.position

				var_47_19.forward = Vector3.New(var_47_26.x, var_47_26.y, var_47_26.z)

				local var_47_27 = var_47_19.localEulerAngles

				var_47_27.z = 0
				var_47_27.x = 0
				var_47_19.localEulerAngles = var_47_27
			end

			local var_47_28 = arg_44_1.actors_["2020_tpose"].transform
			local var_47_29 = 0

			if var_47_29 < arg_44_1.time_ and arg_44_1.time_ <= var_47_29 + arg_47_0 then
				arg_44_1.var_.moveOldPos2020_tpose = var_47_28.localPosition

				local var_47_30 = GameObjectTools.GetOrAddComponent(var_47_28.gameObject, typeof(DynamicBoneHelper))

				if var_47_30 then
					var_47_30:EnableDynamicBone(false)
				end
			end

			local var_47_31 = 0.001

			if var_47_29 <= arg_44_1.time_ and arg_44_1.time_ < var_47_29 + var_47_31 then
				local var_47_32 = (arg_44_1.time_ - var_47_29) / var_47_31
				local var_47_33 = Vector3.New(0, -1.2, -4.1)

				var_47_28.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos2020_tpose, var_47_33, var_47_32)

				local var_47_34 = manager.ui.mainCamera.transform.position - var_47_28.position

				var_47_28.forward = Vector3.New(var_47_34.x, var_47_34.y, var_47_34.z)

				local var_47_35 = var_47_28.localEulerAngles

				var_47_35.z = 0
				var_47_35.x = 0
				var_47_28.localEulerAngles = var_47_35
			end

			if arg_44_1.time_ >= var_47_29 + var_47_31 and arg_44_1.time_ < var_47_29 + var_47_31 + arg_47_0 then
				var_47_28.localPosition = Vector3.New(0, -1.2, -4.1)

				local var_47_36 = manager.ui.mainCamera.transform.position - var_47_28.position

				var_47_28.forward = Vector3.New(var_47_36.x, var_47_36.y, var_47_36.z)

				local var_47_37 = var_47_28.localEulerAngles

				var_47_37.z = 0
				var_47_37.x = 0
				var_47_28.localEulerAngles = var_47_37

				local var_47_38 = GameObjectTools.GetOrAddComponent(var_47_28.gameObject, typeof(DynamicBoneHelper))

				if var_47_38 then
					var_47_38:EnableDynamicBone(true)
				end
			end

			local var_47_39 = 0
			local var_47_40 = 0.75

			if var_47_39 < arg_44_1.time_ and arg_44_1.time_ <= var_47_39 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_41 = arg_44_1:FormatText(StoryNameCfg[19].name)

				arg_44_1.leftNameTxt_.text = var_47_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_42 = arg_44_1:GetWordFromCfg(101131011)
				local var_47_43 = arg_44_1:FormatText(var_47_42.content)

				arg_44_1.text_.text = var_47_43

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_44 = 30
				local var_47_45 = utf8.len(var_47_43)
				local var_47_46 = var_47_44 <= 0 and var_47_40 or var_47_40 * (var_47_45 / var_47_44)

				if var_47_46 > 0 and var_47_40 < var_47_46 then
					arg_44_1.talkMaxDuration = var_47_46

					if var_47_46 + var_47_39 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_46 + var_47_39
					end
				end

				arg_44_1.text_.text = var_47_43
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131011", "story_v_out_101131.awb") ~= 0 then
					local var_47_47 = manager.audio:GetVoiceLength("story_v_out_101131", "101131011", "story_v_out_101131.awb") / 1000

					if var_47_47 + var_47_39 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_47 + var_47_39
					end

					if var_47_42.prefab_name ~= "" and arg_44_1.actors_[var_47_42.prefab_name] ~= nil then
						local var_47_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_42.prefab_name].transform, "story_v_out_101131", "101131011", "story_v_out_101131.awb")

						arg_44_1:RecordAudio("101131011", var_47_48)
						arg_44_1:RecordAudio("101131011", var_47_48)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_101131", "101131011", "story_v_out_101131.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_101131", "101131011", "story_v_out_101131.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_49 = math.max(var_47_40, arg_44_1.talkMaxDuration)

			if var_47_39 <= arg_44_1.time_ and arg_44_1.time_ < var_47_39 + var_47_49 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_39) / var_47_49

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_39 + var_47_49 and arg_44_1.time_ < var_47_39 + var_47_49 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play101131012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 101131012
		arg_48_1.duration_ = 4.3

		local var_48_0 = {
			ja = 4.3,
			ko = 3.8,
			zh = 3.7,
			en = 4.1
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
				arg_48_0:Play101131013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1019ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1019ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1019ui_story then
				arg_48_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1011ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1011ui_story == nil then
				arg_48_1.var_.characterEffect1011ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1011ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1011ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1011ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1011ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_51_11 = arg_48_1.actors_["1019ui_story"].transform
			local var_51_12 = 0

			if var_51_12 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 then
				arg_48_1.var_.moveOldPos1019ui_story = var_51_11.localPosition
			end

			local var_51_13 = 0.001

			if var_51_12 <= arg_48_1.time_ and arg_48_1.time_ < var_51_12 + var_51_13 then
				local var_51_14 = (arg_48_1.time_ - var_51_12) / var_51_13
				local var_51_15 = Vector3.New(-0.7, -1.08, -5.9)

				var_51_11.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1019ui_story, var_51_15, var_51_14)

				local var_51_16 = manager.ui.mainCamera.transform.position - var_51_11.position

				var_51_11.forward = Vector3.New(var_51_16.x, var_51_16.y, var_51_16.z)

				local var_51_17 = var_51_11.localEulerAngles

				var_51_17.z = 0
				var_51_17.x = 0
				var_51_11.localEulerAngles = var_51_17
			end

			if arg_48_1.time_ >= var_51_12 + var_51_13 and arg_48_1.time_ < var_51_12 + var_51_13 + arg_51_0 then
				var_51_11.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_51_18 = manager.ui.mainCamera.transform.position - var_51_11.position

				var_51_11.forward = Vector3.New(var_51_18.x, var_51_18.y, var_51_18.z)

				local var_51_19 = var_51_11.localEulerAngles

				var_51_19.z = 0
				var_51_19.x = 0
				var_51_11.localEulerAngles = var_51_19
			end

			local var_51_20 = arg_48_1.actors_["1011ui_story"].transform
			local var_51_21 = 0

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 then
				arg_48_1.var_.moveOldPos1011ui_story = var_51_20.localPosition
			end

			local var_51_22 = 0.001

			if var_51_21 <= arg_48_1.time_ and arg_48_1.time_ < var_51_21 + var_51_22 then
				local var_51_23 = (arg_48_1.time_ - var_51_21) / var_51_22
				local var_51_24 = Vector3.New(0.7, -0.71, -6)

				var_51_20.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1011ui_story, var_51_24, var_51_23)

				local var_51_25 = manager.ui.mainCamera.transform.position - var_51_20.position

				var_51_20.forward = Vector3.New(var_51_25.x, var_51_25.y, var_51_25.z)

				local var_51_26 = var_51_20.localEulerAngles

				var_51_26.z = 0
				var_51_26.x = 0
				var_51_20.localEulerAngles = var_51_26
			end

			if arg_48_1.time_ >= var_51_21 + var_51_22 and arg_48_1.time_ < var_51_21 + var_51_22 + arg_51_0 then
				var_51_20.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_51_27 = manager.ui.mainCamera.transform.position - var_51_20.position

				var_51_20.forward = Vector3.New(var_51_27.x, var_51_27.y, var_51_27.z)

				local var_51_28 = var_51_20.localEulerAngles

				var_51_28.z = 0
				var_51_28.x = 0
				var_51_20.localEulerAngles = var_51_28
			end

			local var_51_29 = arg_48_1.actors_["2020_tpose"].transform
			local var_51_30 = 0

			if var_51_30 < arg_48_1.time_ and arg_48_1.time_ <= var_51_30 + arg_51_0 then
				arg_48_1.var_.moveOldPos2020_tpose = var_51_29.localPosition

				local var_51_31 = GameObjectTools.GetOrAddComponent(var_51_29.gameObject, typeof(DynamicBoneHelper))

				if var_51_31 then
					var_51_31:EnableDynamicBone(false)
				end
			end

			local var_51_32 = 0.001

			if var_51_30 <= arg_48_1.time_ and arg_48_1.time_ < var_51_30 + var_51_32 then
				local var_51_33 = (arg_48_1.time_ - var_51_30) / var_51_32
				local var_51_34 = Vector3.New(0, 100, 0)

				var_51_29.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos2020_tpose, var_51_34, var_51_33)

				local var_51_35 = manager.ui.mainCamera.transform.position - var_51_29.position

				var_51_29.forward = Vector3.New(var_51_35.x, var_51_35.y, var_51_35.z)

				local var_51_36 = var_51_29.localEulerAngles

				var_51_36.z = 0
				var_51_36.x = 0
				var_51_29.localEulerAngles = var_51_36
			end

			if arg_48_1.time_ >= var_51_30 + var_51_32 and arg_48_1.time_ < var_51_30 + var_51_32 + arg_51_0 then
				var_51_29.localPosition = Vector3.New(0, 100, 0)

				local var_51_37 = manager.ui.mainCamera.transform.position - var_51_29.position

				var_51_29.forward = Vector3.New(var_51_37.x, var_51_37.y, var_51_37.z)

				local var_51_38 = var_51_29.localEulerAngles

				var_51_38.z = 0
				var_51_38.x = 0
				var_51_29.localEulerAngles = var_51_38

				local var_51_39 = GameObjectTools.GetOrAddComponent(var_51_29.gameObject, typeof(DynamicBoneHelper))

				if var_51_39 then
					var_51_39:EnableDynamicBone(true)
				end
			end

			local var_51_40 = 0
			local var_51_41 = 0.55

			if var_51_40 < arg_48_1.time_ and arg_48_1.time_ <= var_51_40 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_42 = arg_48_1:FormatText(StoryNameCfg[13].name)

				arg_48_1.leftNameTxt_.text = var_51_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_43 = arg_48_1:GetWordFromCfg(101131012)
				local var_51_44 = arg_48_1:FormatText(var_51_43.content)

				arg_48_1.text_.text = var_51_44

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_45 = 22
				local var_51_46 = utf8.len(var_51_44)
				local var_51_47 = var_51_45 <= 0 and var_51_41 or var_51_41 * (var_51_46 / var_51_45)

				if var_51_47 > 0 and var_51_41 < var_51_47 then
					arg_48_1.talkMaxDuration = var_51_47

					if var_51_47 + var_51_40 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_47 + var_51_40
					end
				end

				arg_48_1.text_.text = var_51_44
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131012", "story_v_out_101131.awb") ~= 0 then
					local var_51_48 = manager.audio:GetVoiceLength("story_v_out_101131", "101131012", "story_v_out_101131.awb") / 1000

					if var_51_48 + var_51_40 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_48 + var_51_40
					end

					if var_51_43.prefab_name ~= "" and arg_48_1.actors_[var_51_43.prefab_name] ~= nil then
						local var_51_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_43.prefab_name].transform, "story_v_out_101131", "101131012", "story_v_out_101131.awb")

						arg_48_1:RecordAudio("101131012", var_51_49)
						arg_48_1:RecordAudio("101131012", var_51_49)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_101131", "101131012", "story_v_out_101131.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_101131", "101131012", "story_v_out_101131.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_50 = math.max(var_51_41, arg_48_1.talkMaxDuration)

			if var_51_40 <= arg_48_1.time_ and arg_48_1.time_ < var_51_40 + var_51_50 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_40) / var_51_50

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_40 + var_51_50 and arg_48_1.time_ < var_51_40 + var_51_50 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play101131013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 101131013
		arg_52_1.duration_ = 15.23

		local var_52_0 = {
			ja = 15.233,
			ko = 11.566,
			zh = 12.3,
			en = 13.433
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
				arg_52_0:Play101131014(arg_52_1)
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

			local var_55_4 = arg_52_1.actors_["1019ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1019ui_story == nil then
				arg_52_1.var_.characterEffect1019ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.1

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect1019ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1019ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1019ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1019ui_story.fillRatio = var_55_9
			end

			local var_55_10 = 0
			local var_55_11 = 1.425

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_12 = arg_52_1:FormatText(StoryNameCfg[19].name)

				arg_52_1.leftNameTxt_.text = var_55_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_13 = arg_52_1:GetWordFromCfg(101131013)
				local var_55_14 = arg_52_1:FormatText(var_55_13.content)

				arg_52_1.text_.text = var_55_14

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_15 = 57
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

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131013", "story_v_out_101131.awb") ~= 0 then
					local var_55_18 = manager.audio:GetVoiceLength("story_v_out_101131", "101131013", "story_v_out_101131.awb") / 1000

					if var_55_18 + var_55_10 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_18 + var_55_10
					end

					if var_55_13.prefab_name ~= "" and arg_52_1.actors_[var_55_13.prefab_name] ~= nil then
						local var_55_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_13.prefab_name].transform, "story_v_out_101131", "101131013", "story_v_out_101131.awb")

						arg_52_1:RecordAudio("101131013", var_55_19)
						arg_52_1:RecordAudio("101131013", var_55_19)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_101131", "101131013", "story_v_out_101131.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_101131", "101131013", "story_v_out_101131.awb")
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
	Play101131014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 101131014
		arg_56_1.duration_ = 15.1

		local var_56_0 = {
			ja = 7.633,
			ko = 14.8,
			zh = 14,
			en = 15.1
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
				arg_56_0:Play101131015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["2020_tpose"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect2020_tpose == nil then
				arg_56_1.var_.characterEffect2020_tpose = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect2020_tpose and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect2020_tpose then
				arg_56_1.var_.characterEffect2020_tpose.fillFlat = false
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

			local var_59_10 = 0
			local var_59_11 = 1.65

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_12 = arg_56_1:FormatText(StoryNameCfg[19].name)

				arg_56_1.leftNameTxt_.text = var_59_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_13 = arg_56_1:GetWordFromCfg(101131014)
				local var_59_14 = arg_56_1:FormatText(var_59_13.content)

				arg_56_1.text_.text = var_59_14

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 66
				local var_59_16 = utf8.len(var_59_14)
				local var_59_17 = var_59_15 <= 0 and var_59_11 or var_59_11 * (var_59_16 / var_59_15)

				if var_59_17 > 0 and var_59_11 < var_59_17 then
					arg_56_1.talkMaxDuration = var_59_17

					if var_59_17 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_17 + var_59_10
					end
				end

				arg_56_1.text_.text = var_59_14
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131014", "story_v_out_101131.awb") ~= 0 then
					local var_59_18 = manager.audio:GetVoiceLength("story_v_out_101131", "101131014", "story_v_out_101131.awb") / 1000

					if var_59_18 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_10
					end

					if var_59_13.prefab_name ~= "" and arg_56_1.actors_[var_59_13.prefab_name] ~= nil then
						local var_59_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_13.prefab_name].transform, "story_v_out_101131", "101131014", "story_v_out_101131.awb")

						arg_56_1:RecordAudio("101131014", var_59_19)
						arg_56_1:RecordAudio("101131014", var_59_19)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_101131", "101131014", "story_v_out_101131.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_101131", "101131014", "story_v_out_101131.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_20 = math.max(var_59_11, arg_56_1.talkMaxDuration)

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_20 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_10) / var_59_20

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_10 + var_59_20 and arg_56_1.time_ < var_59_10 + var_59_20 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play101131015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 101131015
		arg_60_1.duration_ = 2.67

		local var_60_0 = {
			ja = 1.999999999999,
			ko = 2.666,
			zh = 2.033,
			en = 1.999999999999
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
				arg_60_0:Play101131016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1019ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1019ui_story == nil then
				arg_60_1.var_.characterEffect1019ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1019ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1019ui_story then
				arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["2020_tpose"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect2020_tpose == nil then
				arg_60_1.var_.characterEffect2020_tpose = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.1

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect2020_tpose and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_60_1.var_.characterEffect2020_tpose.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect2020_tpose then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_60_1.var_.characterEffect2020_tpose.fillRatio = var_63_9
			end

			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_63_11 = 0

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_63_12 = 0
			local var_63_13 = 0.2

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_14 = arg_60_1:FormatText(StoryNameCfg[13].name)

				arg_60_1.leftNameTxt_.text = var_63_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_15 = arg_60_1:GetWordFromCfg(101131015)
				local var_63_16 = arg_60_1:FormatText(var_63_15.content)

				arg_60_1.text_.text = var_63_16

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_17 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131015", "story_v_out_101131.awb") ~= 0 then
					local var_63_20 = manager.audio:GetVoiceLength("story_v_out_101131", "101131015", "story_v_out_101131.awb") / 1000

					if var_63_20 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_20 + var_63_12
					end

					if var_63_15.prefab_name ~= "" and arg_60_1.actors_[var_63_15.prefab_name] ~= nil then
						local var_63_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_15.prefab_name].transform, "story_v_out_101131", "101131015", "story_v_out_101131.awb")

						arg_60_1:RecordAudio("101131015", var_63_21)
						arg_60_1:RecordAudio("101131015", var_63_21)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_101131", "101131015", "story_v_out_101131.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_101131", "101131015", "story_v_out_101131.awb")
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
	Play101131016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 101131016
		arg_64_1.duration_ = 6.13

		local var_64_0 = {
			ja = 6.133,
			ko = 5.333,
			zh = 4.366,
			en = 4.5
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
				arg_64_0:Play101131017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1084ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1084ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["1019ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1019ui_story == nil then
				arg_64_1.var_.characterEffect1019ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.1

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect1019ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1019ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1019ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1019ui_story.fillRatio = var_67_9
			end

			local var_67_10 = arg_64_1.actors_["1019ui_story"].transform
			local var_67_11 = 0

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.var_.moveOldPos1019ui_story = var_67_10.localPosition
			end

			local var_67_12 = 0.001

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_11) / var_67_12
				local var_67_14 = Vector3.New(-0.7, -1.08, -5.9)

				var_67_10.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1019ui_story, var_67_14, var_67_13)

				local var_67_15 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_15.x, var_67_15.y, var_67_15.z)

				local var_67_16 = var_67_10.localEulerAngles

				var_67_16.z = 0
				var_67_16.x = 0
				var_67_10.localEulerAngles = var_67_16
			end

			if arg_64_1.time_ >= var_67_11 + var_67_12 and arg_64_1.time_ < var_67_11 + var_67_12 + arg_67_0 then
				var_67_10.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_67_17 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_17.x, var_67_17.y, var_67_17.z)

				local var_67_18 = var_67_10.localEulerAngles

				var_67_18.z = 0
				var_67_18.x = 0
				var_67_10.localEulerAngles = var_67_18
			end

			local var_67_19 = 0

			if var_67_19 < arg_64_1.time_ and arg_64_1.time_ <= var_67_19 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_67_20 = arg_64_1.actors_["1084ui_story"].transform
			local var_67_21 = 0

			if var_67_21 < arg_64_1.time_ and arg_64_1.time_ <= var_67_21 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = var_67_20.localPosition
			end

			local var_67_22 = 0.001

			if var_67_21 <= arg_64_1.time_ and arg_64_1.time_ < var_67_21 + var_67_22 then
				local var_67_23 = (arg_64_1.time_ - var_67_21) / var_67_22
				local var_67_24 = Vector3.New(0.7, -0.97, -6)

				var_67_20.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, var_67_24, var_67_23)

				local var_67_25 = manager.ui.mainCamera.transform.position - var_67_20.position

				var_67_20.forward = Vector3.New(var_67_25.x, var_67_25.y, var_67_25.z)

				local var_67_26 = var_67_20.localEulerAngles

				var_67_26.z = 0
				var_67_26.x = 0
				var_67_20.localEulerAngles = var_67_26
			end

			if arg_64_1.time_ >= var_67_21 + var_67_22 and arg_64_1.time_ < var_67_21 + var_67_22 + arg_67_0 then
				var_67_20.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_67_27 = manager.ui.mainCamera.transform.position - var_67_20.position

				var_67_20.forward = Vector3.New(var_67_27.x, var_67_27.y, var_67_27.z)

				local var_67_28 = var_67_20.localEulerAngles

				var_67_28.z = 0
				var_67_28.x = 0
				var_67_20.localEulerAngles = var_67_28
			end

			local var_67_29 = 0

			if var_67_29 < arg_64_1.time_ and arg_64_1.time_ <= var_67_29 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_67_30 = arg_64_1.actors_["1011ui_story"].transform
			local var_67_31 = 0

			if var_67_31 < arg_64_1.time_ and arg_64_1.time_ <= var_67_31 + arg_67_0 then
				arg_64_1.var_.moveOldPos1011ui_story = var_67_30.localPosition
			end

			local var_67_32 = 0.001

			if var_67_31 <= arg_64_1.time_ and arg_64_1.time_ < var_67_31 + var_67_32 then
				local var_67_33 = (arg_64_1.time_ - var_67_31) / var_67_32
				local var_67_34 = Vector3.New(0, 100, 0)

				var_67_30.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1011ui_story, var_67_34, var_67_33)

				local var_67_35 = manager.ui.mainCamera.transform.position - var_67_30.position

				var_67_30.forward = Vector3.New(var_67_35.x, var_67_35.y, var_67_35.z)

				local var_67_36 = var_67_30.localEulerAngles

				var_67_36.z = 0
				var_67_36.x = 0
				var_67_30.localEulerAngles = var_67_36
			end

			if arg_64_1.time_ >= var_67_31 + var_67_32 and arg_64_1.time_ < var_67_31 + var_67_32 + arg_67_0 then
				var_67_30.localPosition = Vector3.New(0, 100, 0)

				local var_67_37 = manager.ui.mainCamera.transform.position - var_67_30.position

				var_67_30.forward = Vector3.New(var_67_37.x, var_67_37.y, var_67_37.z)

				local var_67_38 = var_67_30.localEulerAngles

				var_67_38.z = 0
				var_67_38.x = 0
				var_67_30.localEulerAngles = var_67_38
			end

			local var_67_39 = 0
			local var_67_40 = 0.725

			if var_67_39 < arg_64_1.time_ and arg_64_1.time_ <= var_67_39 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_41 = arg_64_1:FormatText(StoryNameCfg[6].name)

				arg_64_1.leftNameTxt_.text = var_67_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_42 = arg_64_1:GetWordFromCfg(101131016)
				local var_67_43 = arg_64_1:FormatText(var_67_42.content)

				arg_64_1.text_.text = var_67_43

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_44 = 25
				local var_67_45 = utf8.len(var_67_43)
				local var_67_46 = var_67_44 <= 0 and var_67_40 or var_67_40 * (var_67_45 / var_67_44)

				if var_67_46 > 0 and var_67_40 < var_67_46 then
					arg_64_1.talkMaxDuration = var_67_46

					if var_67_46 + var_67_39 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_46 + var_67_39
					end
				end

				arg_64_1.text_.text = var_67_43
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131016", "story_v_out_101131.awb") ~= 0 then
					local var_67_47 = manager.audio:GetVoiceLength("story_v_out_101131", "101131016", "story_v_out_101131.awb") / 1000

					if var_67_47 + var_67_39 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_47 + var_67_39
					end

					if var_67_42.prefab_name ~= "" and arg_64_1.actors_[var_67_42.prefab_name] ~= nil then
						local var_67_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_42.prefab_name].transform, "story_v_out_101131", "101131016", "story_v_out_101131.awb")

						arg_64_1:RecordAudio("101131016", var_67_48)
						arg_64_1:RecordAudio("101131016", var_67_48)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_101131", "101131016", "story_v_out_101131.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_101131", "101131016", "story_v_out_101131.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_49 = math.max(var_67_40, arg_64_1.talkMaxDuration)

			if var_67_39 <= arg_64_1.time_ and arg_64_1.time_ < var_67_39 + var_67_49 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_39) / var_67_49

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_39 + var_67_49 and arg_64_1.time_ < var_67_39 + var_67_49 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
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
	Play101131017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 101131017
		arg_68_1.duration_ = 4.47

		local var_68_0 = {
			ja = 4.466,
			ko = 2.8,
			zh = 2.5,
			en = 2.666
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
				arg_68_0:Play101131018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = "3010_tpose"

			if arg_68_1.actors_[var_71_0] == nil then
				local var_71_1 = Asset.Load("Char/" .. "3010_tpose")

				if not isNil(var_71_1) then
					local var_71_2 = Object.Instantiate(Asset.Load("Char/" .. "3010_tpose"), arg_68_1.stage_.transform)

					var_71_2.name = var_71_0
					var_71_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_68_1.actors_[var_71_0] = var_71_2

					local var_71_3 = var_71_2:GetComponentInChildren(typeof(CharacterEffect))

					var_71_3.enabled = true

					local var_71_4 = GameObjectTools.GetOrAddComponent(var_71_2, typeof(DynamicBoneHelper))

					if var_71_4 then
						var_71_4:EnableDynamicBone(false)
					end

					arg_68_1:ShowWeapon(var_71_3.transform, false)

					arg_68_1.var_[var_71_0 .. "Animator"] = var_71_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_68_1.var_[var_71_0 .. "Animator"].applyRootMotion = true
					arg_68_1.var_[var_71_0 .. "LipSync"] = var_71_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_71_5 = arg_68_1.actors_["3010_tpose"]
			local var_71_6 = 0

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 and not isNil(var_71_5) and arg_68_1.var_.characterEffect3010_tpose == nil then
				arg_68_1.var_.characterEffect3010_tpose = var_71_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_7 = 0.1

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_7 and not isNil(var_71_5) then
				local var_71_8 = (arg_68_1.time_ - var_71_6) / var_71_7

				if arg_68_1.var_.characterEffect3010_tpose and not isNil(var_71_5) then
					arg_68_1.var_.characterEffect3010_tpose.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_6 + var_71_7 and arg_68_1.time_ < var_71_6 + var_71_7 + arg_71_0 and not isNil(var_71_5) and arg_68_1.var_.characterEffect3010_tpose then
				arg_68_1.var_.characterEffect3010_tpose.fillFlat = false
			end

			local var_71_9 = arg_68_1.actors_["1084ui_story"].transform
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = var_71_9.localPosition
			end

			local var_71_11 = 0.001

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11
				local var_71_13 = Vector3.New(0, 100, 0)

				var_71_9.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, var_71_13, var_71_12)

				local var_71_14 = manager.ui.mainCamera.transform.position - var_71_9.position

				var_71_9.forward = Vector3.New(var_71_14.x, var_71_14.y, var_71_14.z)

				local var_71_15 = var_71_9.localEulerAngles

				var_71_15.z = 0
				var_71_15.x = 0
				var_71_9.localEulerAngles = var_71_15
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 then
				var_71_9.localPosition = Vector3.New(0, 100, 0)

				local var_71_16 = manager.ui.mainCamera.transform.position - var_71_9.position

				var_71_9.forward = Vector3.New(var_71_16.x, var_71_16.y, var_71_16.z)

				local var_71_17 = var_71_9.localEulerAngles

				var_71_17.z = 0
				var_71_17.x = 0
				var_71_9.localEulerAngles = var_71_17
			end

			local var_71_18 = arg_68_1.actors_["1019ui_story"].transform
			local var_71_19 = 0

			if var_71_19 < arg_68_1.time_ and arg_68_1.time_ <= var_71_19 + arg_71_0 then
				arg_68_1.var_.moveOldPos1019ui_story = var_71_18.localPosition
			end

			local var_71_20 = 0.001

			if var_71_19 <= arg_68_1.time_ and arg_68_1.time_ < var_71_19 + var_71_20 then
				local var_71_21 = (arg_68_1.time_ - var_71_19) / var_71_20
				local var_71_22 = Vector3.New(0, 100, 0)

				var_71_18.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1019ui_story, var_71_22, var_71_21)

				local var_71_23 = manager.ui.mainCamera.transform.position - var_71_18.position

				var_71_18.forward = Vector3.New(var_71_23.x, var_71_23.y, var_71_23.z)

				local var_71_24 = var_71_18.localEulerAngles

				var_71_24.z = 0
				var_71_24.x = 0
				var_71_18.localEulerAngles = var_71_24
			end

			if arg_68_1.time_ >= var_71_19 + var_71_20 and arg_68_1.time_ < var_71_19 + var_71_20 + arg_71_0 then
				var_71_18.localPosition = Vector3.New(0, 100, 0)

				local var_71_25 = manager.ui.mainCamera.transform.position - var_71_18.position

				var_71_18.forward = Vector3.New(var_71_25.x, var_71_25.y, var_71_25.z)

				local var_71_26 = var_71_18.localEulerAngles

				var_71_26.z = 0
				var_71_26.x = 0
				var_71_18.localEulerAngles = var_71_26
			end

			local var_71_27 = arg_68_1.actors_["3010_tpose"].transform
			local var_71_28 = 0

			if var_71_28 < arg_68_1.time_ and arg_68_1.time_ <= var_71_28 + arg_71_0 then
				arg_68_1.var_.moveOldPos3010_tpose = var_71_27.localPosition

				local var_71_29 = GameObjectTools.GetOrAddComponent(var_71_27.gameObject, typeof(DynamicBoneHelper))

				if var_71_29 then
					var_71_29:EnableDynamicBone(false)
				end
			end

			local var_71_30 = 0.001

			if var_71_28 <= arg_68_1.time_ and arg_68_1.time_ < var_71_28 + var_71_30 then
				local var_71_31 = (arg_68_1.time_ - var_71_28) / var_71_30
				local var_71_32 = Vector3.New(0, -1.59, -1.6)

				var_71_27.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos3010_tpose, var_71_32, var_71_31)

				local var_71_33 = manager.ui.mainCamera.transform.position - var_71_27.position

				var_71_27.forward = Vector3.New(var_71_33.x, var_71_33.y, var_71_33.z)

				local var_71_34 = var_71_27.localEulerAngles

				var_71_34.z = 0
				var_71_34.x = 0
				var_71_27.localEulerAngles = var_71_34
			end

			if arg_68_1.time_ >= var_71_28 + var_71_30 and arg_68_1.time_ < var_71_28 + var_71_30 + arg_71_0 then
				var_71_27.localPosition = Vector3.New(0, -1.59, -1.6)

				local var_71_35 = manager.ui.mainCamera.transform.position - var_71_27.position

				var_71_27.forward = Vector3.New(var_71_35.x, var_71_35.y, var_71_35.z)

				local var_71_36 = var_71_27.localEulerAngles

				var_71_36.z = 0
				var_71_36.x = 0
				var_71_27.localEulerAngles = var_71_36

				local var_71_37 = GameObjectTools.GetOrAddComponent(var_71_27.gameObject, typeof(DynamicBoneHelper))

				if var_71_37 then
					var_71_37:EnableDynamicBone(true)
				end
			end

			local var_71_38 = 0

			if var_71_38 < arg_68_1.time_ and arg_68_1.time_ <= var_71_38 + arg_71_0 then
				arg_68_1:PlayTimeline("3010_tpose", "StoryTimeline/CharAction/story3010/story3010action/3010action1_1")
			end

			local var_71_39 = 0
			local var_71_40 = 0.25

			if var_71_39 < arg_68_1.time_ and arg_68_1.time_ <= var_71_39 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_41 = arg_68_1:FormatText(StoryNameCfg[40].name)

				arg_68_1.leftNameTxt_.text = var_71_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_42 = arg_68_1:GetWordFromCfg(101131017)
				local var_71_43 = arg_68_1:FormatText(var_71_42.content)

				arg_68_1.text_.text = var_71_43

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_44 = 10
				local var_71_45 = utf8.len(var_71_43)
				local var_71_46 = var_71_44 <= 0 and var_71_40 or var_71_40 * (var_71_45 / var_71_44)

				if var_71_46 > 0 and var_71_40 < var_71_46 then
					arg_68_1.talkMaxDuration = var_71_46

					if var_71_46 + var_71_39 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_46 + var_71_39
					end
				end

				arg_68_1.text_.text = var_71_43
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131017", "story_v_out_101131.awb") ~= 0 then
					local var_71_47 = manager.audio:GetVoiceLength("story_v_out_101131", "101131017", "story_v_out_101131.awb") / 1000

					if var_71_47 + var_71_39 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_47 + var_71_39
					end

					if var_71_42.prefab_name ~= "" and arg_68_1.actors_[var_71_42.prefab_name] ~= nil then
						local var_71_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_42.prefab_name].transform, "story_v_out_101131", "101131017", "story_v_out_101131.awb")

						arg_68_1:RecordAudio("101131017", var_71_48)
						arg_68_1:RecordAudio("101131017", var_71_48)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_101131", "101131017", "story_v_out_101131.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_101131", "101131017", "story_v_out_101131.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_49 = math.max(var_71_40, arg_68_1.talkMaxDuration)

			if var_71_39 <= arg_68_1.time_ and arg_68_1.time_ < var_71_39 + var_71_49 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_39) / var_71_49

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_39 + var_71_49 and arg_68_1.time_ < var_71_39 + var_71_49 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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
				actorName = "3010_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play101131018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 101131018
		arg_72_1.duration_ = 3.4

		local var_72_0 = {
			ja = 3.4,
			ko = 1.533,
			zh = 1.8,
			en = 1.633
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
				arg_72_0:Play101131019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["3010_tpose"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect3010_tpose == nil then
				arg_72_1.var_.characterEffect3010_tpose = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect3010_tpose and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect3010_tpose.fillFlat = true
					arg_72_1.var_.characterEffect3010_tpose.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect3010_tpose then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect3010_tpose.fillFlat = true
				arg_72_1.var_.characterEffect3010_tpose.fillRatio = var_75_5
			end

			local var_75_6 = 0
			local var_75_7 = 0.2

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_8 = arg_72_1:FormatText(StoryNameCfg[41].name)

				arg_72_1.leftNameTxt_.text = var_75_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_9 = arg_72_1:GetWordFromCfg(101131018)
				local var_75_10 = arg_72_1:FormatText(var_75_9.content)

				arg_72_1.text_.text = var_75_10

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131018", "story_v_out_101131.awb") ~= 0 then
					local var_75_14 = manager.audio:GetVoiceLength("story_v_out_101131", "101131018", "story_v_out_101131.awb") / 1000

					if var_75_14 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_6
					end

					if var_75_9.prefab_name ~= "" and arg_72_1.actors_[var_75_9.prefab_name] ~= nil then
						local var_75_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_9.prefab_name].transform, "story_v_out_101131", "101131018", "story_v_out_101131.awb")

						arg_72_1:RecordAudio("101131018", var_75_15)
						arg_72_1:RecordAudio("101131018", var_75_15)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_101131", "101131018", "story_v_out_101131.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_101131", "101131018", "story_v_out_101131.awb")
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
	Play101131019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 101131019
		arg_76_1.duration_ = 5.8

		local var_76_0 = {
			ja = 5.8,
			ko = 3.6,
			zh = 4.866,
			en = 4.833
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
				arg_76_0:Play101131020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["3010_tpose"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect3010_tpose == nil then
				arg_76_1.var_.characterEffect3010_tpose = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect3010_tpose and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect3010_tpose.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect3010_tpose then
				arg_76_1.var_.characterEffect3010_tpose.fillFlat = false
			end

			local var_79_4 = 0
			local var_79_5 = 0.55

			if var_79_4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_6 = arg_76_1:FormatText(StoryNameCfg[40].name)

				arg_76_1.leftNameTxt_.text = var_79_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_7 = arg_76_1:GetWordFromCfg(101131019)
				local var_79_8 = arg_76_1:FormatText(var_79_7.content)

				arg_76_1.text_.text = var_79_8

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 20
				local var_79_10 = utf8.len(var_79_8)
				local var_79_11 = var_79_9 <= 0 and var_79_5 or var_79_5 * (var_79_10 / var_79_9)

				if var_79_11 > 0 and var_79_5 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11

					if var_79_11 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_8
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131019", "story_v_out_101131.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_out_101131", "101131019", "story_v_out_101131.awb") / 1000

					if var_79_12 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_4
					end

					if var_79_7.prefab_name ~= "" and arg_76_1.actors_[var_79_7.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_7.prefab_name].transform, "story_v_out_101131", "101131019", "story_v_out_101131.awb")

						arg_76_1:RecordAudio("101131019", var_79_13)
						arg_76_1:RecordAudio("101131019", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_101131", "101131019", "story_v_out_101131.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_101131", "101131019", "story_v_out_101131.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_14 and arg_76_1.time_ < var_79_4 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play101131020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 101131020
		arg_80_1.duration_ = 4.13

		local var_80_0 = {
			ja = 2.933,
			ko = 3.2,
			zh = 3.233,
			en = 4.133
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
				arg_80_0:Play101131021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1011ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1011ui_story == nil then
				arg_80_1.var_.characterEffect1011ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1011ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1011ui_story then
				arg_80_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["3010_tpose"]
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect3010_tpose == nil then
				arg_80_1.var_.characterEffect3010_tpose = var_83_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.1

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 and not isNil(var_83_4) then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6

				if arg_80_1.var_.characterEffect3010_tpose and not isNil(var_83_4) then
					local var_83_8 = Mathf.Lerp(0, 0.5, var_83_7)

					arg_80_1.var_.characterEffect3010_tpose.fillFlat = true
					arg_80_1.var_.characterEffect3010_tpose.fillRatio = var_83_8
				end
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect3010_tpose then
				local var_83_9 = 0.5

				arg_80_1.var_.characterEffect3010_tpose.fillFlat = true
				arg_80_1.var_.characterEffect3010_tpose.fillRatio = var_83_9
			end

			local var_83_10 = arg_80_1.actors_["3010_tpose"].transform
			local var_83_11 = 0

			if var_83_11 < arg_80_1.time_ and arg_80_1.time_ <= var_83_11 + arg_83_0 then
				arg_80_1.var_.moveOldPos3010_tpose = var_83_10.localPosition

				local var_83_12 = GameObjectTools.GetOrAddComponent(var_83_10.gameObject, typeof(DynamicBoneHelper))

				if var_83_12 then
					var_83_12:EnableDynamicBone(false)
				end
			end

			local var_83_13 = 0.001

			if var_83_11 <= arg_80_1.time_ and arg_80_1.time_ < var_83_11 + var_83_13 then
				local var_83_14 = (arg_80_1.time_ - var_83_11) / var_83_13
				local var_83_15 = Vector3.New(0, 100, 0)

				var_83_10.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos3010_tpose, var_83_15, var_83_14)

				local var_83_16 = manager.ui.mainCamera.transform.position - var_83_10.position

				var_83_10.forward = Vector3.New(var_83_16.x, var_83_16.y, var_83_16.z)

				local var_83_17 = var_83_10.localEulerAngles

				var_83_17.z = 0
				var_83_17.x = 0
				var_83_10.localEulerAngles = var_83_17
			end

			if arg_80_1.time_ >= var_83_11 + var_83_13 and arg_80_1.time_ < var_83_11 + var_83_13 + arg_83_0 then
				var_83_10.localPosition = Vector3.New(0, 100, 0)

				local var_83_18 = manager.ui.mainCamera.transform.position - var_83_10.position

				var_83_10.forward = Vector3.New(var_83_18.x, var_83_18.y, var_83_18.z)

				local var_83_19 = var_83_10.localEulerAngles

				var_83_19.z = 0
				var_83_19.x = 0
				var_83_10.localEulerAngles = var_83_19

				local var_83_20 = GameObjectTools.GetOrAddComponent(var_83_10.gameObject, typeof(DynamicBoneHelper))

				if var_83_20 then
					var_83_20:EnableDynamicBone(true)
				end
			end

			local var_83_21 = 0

			if var_83_21 < arg_80_1.time_ and arg_80_1.time_ <= var_83_21 + arg_83_0 then
				arg_80_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_83_22 = arg_80_1.actors_["1011ui_story"].transform
			local var_83_23 = 0

			if var_83_23 < arg_80_1.time_ and arg_80_1.time_ <= var_83_23 + arg_83_0 then
				arg_80_1.var_.moveOldPos1011ui_story = var_83_22.localPosition
			end

			local var_83_24 = 0.001

			if var_83_23 <= arg_80_1.time_ and arg_80_1.time_ < var_83_23 + var_83_24 then
				local var_83_25 = (arg_80_1.time_ - var_83_23) / var_83_24
				local var_83_26 = Vector3.New(0, -0.71, -6)

				var_83_22.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1011ui_story, var_83_26, var_83_25)

				local var_83_27 = manager.ui.mainCamera.transform.position - var_83_22.position

				var_83_22.forward = Vector3.New(var_83_27.x, var_83_27.y, var_83_27.z)

				local var_83_28 = var_83_22.localEulerAngles

				var_83_28.z = 0
				var_83_28.x = 0
				var_83_22.localEulerAngles = var_83_28
			end

			if arg_80_1.time_ >= var_83_23 + var_83_24 and arg_80_1.time_ < var_83_23 + var_83_24 + arg_83_0 then
				var_83_22.localPosition = Vector3.New(0, -0.71, -6)

				local var_83_29 = manager.ui.mainCamera.transform.position - var_83_22.position

				var_83_22.forward = Vector3.New(var_83_29.x, var_83_29.y, var_83_29.z)

				local var_83_30 = var_83_22.localEulerAngles

				var_83_30.z = 0
				var_83_30.x = 0
				var_83_22.localEulerAngles = var_83_30
			end

			local var_83_31 = 0

			if var_83_31 < arg_80_1.time_ and arg_80_1.time_ <= var_83_31 + arg_83_0 then
				arg_80_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_83_32 = 0
			local var_83_33 = 0.325

			if var_83_32 < arg_80_1.time_ and arg_80_1.time_ <= var_83_32 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_34 = arg_80_1:FormatText(StoryNameCfg[37].name)

				arg_80_1.leftNameTxt_.text = var_83_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_35 = arg_80_1:GetWordFromCfg(101131020)
				local var_83_36 = arg_80_1:FormatText(var_83_35.content)

				arg_80_1.text_.text = var_83_36

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_37 = 13
				local var_83_38 = utf8.len(var_83_36)
				local var_83_39 = var_83_37 <= 0 and var_83_33 or var_83_33 * (var_83_38 / var_83_37)

				if var_83_39 > 0 and var_83_33 < var_83_39 then
					arg_80_1.talkMaxDuration = var_83_39

					if var_83_39 + var_83_32 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_39 + var_83_32
					end
				end

				arg_80_1.text_.text = var_83_36
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131020", "story_v_out_101131.awb") ~= 0 then
					local var_83_40 = manager.audio:GetVoiceLength("story_v_out_101131", "101131020", "story_v_out_101131.awb") / 1000

					if var_83_40 + var_83_32 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_40 + var_83_32
					end

					if var_83_35.prefab_name ~= "" and arg_80_1.actors_[var_83_35.prefab_name] ~= nil then
						local var_83_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_35.prefab_name].transform, "story_v_out_101131", "101131020", "story_v_out_101131.awb")

						arg_80_1:RecordAudio("101131020", var_83_41)
						arg_80_1:RecordAudio("101131020", var_83_41)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_101131", "101131020", "story_v_out_101131.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_101131", "101131020", "story_v_out_101131.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_42 = math.max(var_83_33, arg_80_1.talkMaxDuration)

			if var_83_32 <= arg_80_1.time_ and arg_80_1.time_ < var_83_32 + var_83_42 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_32) / var_83_42

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_32 + var_83_42 and arg_80_1.time_ < var_83_32 + var_83_42 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3010_tpose",
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

		arg_80_1:InitPlayNodeList()
	end,
	Play101131021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 101131021
		arg_84_1.duration_ = 7.67

		local var_84_0 = {
			ja = 7.566,
			ko = 4.4,
			zh = 7.666,
			en = 5.3
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
				arg_84_0:Play101131022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["3010_tpose"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect3010_tpose == nil then
				arg_84_1.var_.characterEffect3010_tpose = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect3010_tpose and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect3010_tpose.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect3010_tpose then
				arg_84_1.var_.characterEffect3010_tpose.fillFlat = false
			end

			local var_87_4 = arg_84_1.actors_["1011ui_story"]
			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1011ui_story == nil then
				arg_84_1.var_.characterEffect1011ui_story = var_87_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.1

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 and not isNil(var_87_4) then
				local var_87_7 = (arg_84_1.time_ - var_87_5) / var_87_6

				if arg_84_1.var_.characterEffect1011ui_story and not isNil(var_87_4) then
					local var_87_8 = Mathf.Lerp(0, 0.5, var_87_7)

					arg_84_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1011ui_story.fillRatio = var_87_8
				end
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1011ui_story then
				local var_87_9 = 0.5

				arg_84_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1011ui_story.fillRatio = var_87_9
			end

			local var_87_10 = arg_84_1.actors_["1011ui_story"].transform
			local var_87_11 = 0

			if var_87_11 < arg_84_1.time_ and arg_84_1.time_ <= var_87_11 + arg_87_0 then
				arg_84_1.var_.moveOldPos1011ui_story = var_87_10.localPosition
			end

			local var_87_12 = 0.001

			if var_87_11 <= arg_84_1.time_ and arg_84_1.time_ < var_87_11 + var_87_12 then
				local var_87_13 = (arg_84_1.time_ - var_87_11) / var_87_12
				local var_87_14 = Vector3.New(0, 100, 0)

				var_87_10.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1011ui_story, var_87_14, var_87_13)

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

			local var_87_19 = arg_84_1.actors_["1084ui_story"].transform
			local var_87_20 = 0

			if var_87_20 < arg_84_1.time_ and arg_84_1.time_ <= var_87_20 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = var_87_19.localPosition
			end

			local var_87_21 = 0.001

			if var_87_20 <= arg_84_1.time_ and arg_84_1.time_ < var_87_20 + var_87_21 then
				local var_87_22 = (arg_84_1.time_ - var_87_20) / var_87_21
				local var_87_23 = Vector3.New(0, 100, 0)

				var_87_19.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, var_87_23, var_87_22)

				local var_87_24 = manager.ui.mainCamera.transform.position - var_87_19.position

				var_87_19.forward = Vector3.New(var_87_24.x, var_87_24.y, var_87_24.z)

				local var_87_25 = var_87_19.localEulerAngles

				var_87_25.z = 0
				var_87_25.x = 0
				var_87_19.localEulerAngles = var_87_25
			end

			if arg_84_1.time_ >= var_87_20 + var_87_21 and arg_84_1.time_ < var_87_20 + var_87_21 + arg_87_0 then
				var_87_19.localPosition = Vector3.New(0, 100, 0)

				local var_87_26 = manager.ui.mainCamera.transform.position - var_87_19.position

				var_87_19.forward = Vector3.New(var_87_26.x, var_87_26.y, var_87_26.z)

				local var_87_27 = var_87_19.localEulerAngles

				var_87_27.z = 0
				var_87_27.x = 0
				var_87_19.localEulerAngles = var_87_27
			end

			local var_87_28 = arg_84_1.actors_["3010_tpose"].transform
			local var_87_29 = 0

			if var_87_29 < arg_84_1.time_ and arg_84_1.time_ <= var_87_29 + arg_87_0 then
				arg_84_1.var_.moveOldPos3010_tpose = var_87_28.localPosition

				local var_87_30 = GameObjectTools.GetOrAddComponent(var_87_28.gameObject, typeof(DynamicBoneHelper))

				if var_87_30 then
					var_87_30:EnableDynamicBone(false)
				end
			end

			local var_87_31 = 0.001

			if var_87_29 <= arg_84_1.time_ and arg_84_1.time_ < var_87_29 + var_87_31 then
				local var_87_32 = (arg_84_1.time_ - var_87_29) / var_87_31
				local var_87_33 = Vector3.New(0, -1.59, -1.6)

				var_87_28.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos3010_tpose, var_87_33, var_87_32)

				local var_87_34 = manager.ui.mainCamera.transform.position - var_87_28.position

				var_87_28.forward = Vector3.New(var_87_34.x, var_87_34.y, var_87_34.z)

				local var_87_35 = var_87_28.localEulerAngles

				var_87_35.z = 0
				var_87_35.x = 0
				var_87_28.localEulerAngles = var_87_35
			end

			if arg_84_1.time_ >= var_87_29 + var_87_31 and arg_84_1.time_ < var_87_29 + var_87_31 + arg_87_0 then
				var_87_28.localPosition = Vector3.New(0, -1.59, -1.6)

				local var_87_36 = manager.ui.mainCamera.transform.position - var_87_28.position

				var_87_28.forward = Vector3.New(var_87_36.x, var_87_36.y, var_87_36.z)

				local var_87_37 = var_87_28.localEulerAngles

				var_87_37.z = 0
				var_87_37.x = 0
				var_87_28.localEulerAngles = var_87_37

				local var_87_38 = GameObjectTools.GetOrAddComponent(var_87_28.gameObject, typeof(DynamicBoneHelper))

				if var_87_38 then
					var_87_38:EnableDynamicBone(true)
				end
			end

			local var_87_39 = 0

			if var_87_39 < arg_84_1.time_ and arg_84_1.time_ <= var_87_39 + arg_87_0 then
				arg_84_1:PlayTimeline("3010_tpose", "StoryTimeline/CharAction/story3010/story3010action/3010action1_1")
			end

			local var_87_40 = 0
			local var_87_41 = 0.85

			if var_87_40 < arg_84_1.time_ and arg_84_1.time_ <= var_87_40 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_42 = arg_84_1:FormatText(StoryNameCfg[40].name)

				arg_84_1.leftNameTxt_.text = var_87_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_43 = arg_84_1:GetWordFromCfg(101131021)
				local var_87_44 = arg_84_1:FormatText(var_87_43.content)

				arg_84_1.text_.text = var_87_44

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_45 = 32
				local var_87_46 = utf8.len(var_87_44)
				local var_87_47 = var_87_45 <= 0 and var_87_41 or var_87_41 * (var_87_46 / var_87_45)

				if var_87_47 > 0 and var_87_41 < var_87_47 then
					arg_84_1.talkMaxDuration = var_87_47

					if var_87_47 + var_87_40 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_47 + var_87_40
					end
				end

				arg_84_1.text_.text = var_87_44
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131021", "story_v_out_101131.awb") ~= 0 then
					local var_87_48 = manager.audio:GetVoiceLength("story_v_out_101131", "101131021", "story_v_out_101131.awb") / 1000

					if var_87_48 + var_87_40 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_48 + var_87_40
					end

					if var_87_43.prefab_name ~= "" and arg_84_1.actors_[var_87_43.prefab_name] ~= nil then
						local var_87_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_43.prefab_name].transform, "story_v_out_101131", "101131021", "story_v_out_101131.awb")

						arg_84_1:RecordAudio("101131021", var_87_49)
						arg_84_1:RecordAudio("101131021", var_87_49)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_101131", "101131021", "story_v_out_101131.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_101131", "101131021", "story_v_out_101131.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_50 = math.max(var_87_41, arg_84_1.talkMaxDuration)

			if var_87_40 <= arg_84_1.time_ and arg_84_1.time_ < var_87_40 + var_87_50 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_40) / var_87_50

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_40 + var_87_50 and arg_84_1.time_ < var_87_40 + var_87_50 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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
				actorName = "3010_tpose",
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
	Play101131022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 101131022
		arg_88_1.duration_ = 3.77

		local var_88_0 = {
			ja = 3.766,
			ko = 2.933,
			zh = 2.833,
			en = 2.933
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
				arg_88_0:Play101131023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["3010_tpose"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect3010_tpose == nil then
				arg_88_1.var_.characterEffect3010_tpose = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect3010_tpose and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect3010_tpose.fillFlat = true
					arg_88_1.var_.characterEffect3010_tpose.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect3010_tpose then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect3010_tpose.fillFlat = true
				arg_88_1.var_.characterEffect3010_tpose.fillRatio = var_91_5
			end

			local var_91_6 = 0
			local var_91_7 = 0.35

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_8 = arg_88_1:FormatText(StoryNameCfg[19].name)

				arg_88_1.leftNameTxt_.text = var_91_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_9 = arg_88_1:GetWordFromCfg(101131022)
				local var_91_10 = arg_88_1:FormatText(var_91_9.content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 12
				local var_91_12 = utf8.len(var_91_10)
				local var_91_13 = var_91_11 <= 0 and var_91_7 or var_91_7 * (var_91_12 / var_91_11)

				if var_91_13 > 0 and var_91_7 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_10
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131022", "story_v_out_101131.awb") ~= 0 then
					local var_91_14 = manager.audio:GetVoiceLength("story_v_out_101131", "101131022", "story_v_out_101131.awb") / 1000

					if var_91_14 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_6
					end

					if var_91_9.prefab_name ~= "" and arg_88_1.actors_[var_91_9.prefab_name] ~= nil then
						local var_91_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_9.prefab_name].transform, "story_v_out_101131", "101131022", "story_v_out_101131.awb")

						arg_88_1:RecordAudio("101131022", var_91_15)
						arg_88_1:RecordAudio("101131022", var_91_15)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_101131", "101131022", "story_v_out_101131.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_101131", "101131022", "story_v_out_101131.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_16 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_16 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_16

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_16 and arg_88_1.time_ < var_91_6 + var_91_16 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play101131023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 101131023
		arg_92_1.duration_ = 4.37

		local var_92_0 = {
			ja = 4.366,
			ko = 3.233,
			zh = 3.066,
			en = 2.8
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
				arg_92_0:Play101131024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 0.425

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[33].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(101131023)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131023", "story_v_out_101131.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_101131", "101131023", "story_v_out_101131.awb") / 1000

					if var_95_8 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_0
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_101131", "101131023", "story_v_out_101131.awb")

						arg_92_1:RecordAudio("101131023", var_95_9)
						arg_92_1:RecordAudio("101131023", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_101131", "101131023", "story_v_out_101131.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_101131", "101131023", "story_v_out_101131.awb")
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
	Play101131024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 101131024
		arg_96_1.duration_ = 4.23

		local var_96_0 = {
			ja = 3.6,
			ko = 3.1,
			zh = 2.8,
			en = 4.233
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
			arg_96_1.auto_ = false
		end

		function arg_96_1.playNext_(arg_98_0)
			arg_96_1.onStoryFinished_()
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 1

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				local var_99_2 = "play"
				local var_99_3 = "effect"

				arg_96_1:AudioAction(var_99_2, var_99_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_99_4 = arg_96_1.actors_["1084ui_story"]
			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1084ui_story == nil then
				arg_96_1.var_.characterEffect1084ui_story = var_99_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.1

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 and not isNil(var_99_4) then
				local var_99_7 = (arg_96_1.time_ - var_99_5) / var_99_6

				if arg_96_1.var_.characterEffect1084ui_story and not isNil(var_99_4) then
					arg_96_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1084ui_story then
				arg_96_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_99_8 = arg_96_1.actors_["3010_tpose"].transform
			local var_99_9 = 0

			if var_99_9 < arg_96_1.time_ and arg_96_1.time_ <= var_99_9 + arg_99_0 then
				arg_96_1.var_.moveOldPos3010_tpose = var_99_8.localPosition

				local var_99_10 = GameObjectTools.GetOrAddComponent(var_99_8.gameObject, typeof(DynamicBoneHelper))

				if var_99_10 then
					var_99_10:EnableDynamicBone(false)
				end
			end

			local var_99_11 = 0.001

			if var_99_9 <= arg_96_1.time_ and arg_96_1.time_ < var_99_9 + var_99_11 then
				local var_99_12 = (arg_96_1.time_ - var_99_9) / var_99_11
				local var_99_13 = Vector3.New(0, 100, 0)

				var_99_8.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos3010_tpose, var_99_13, var_99_12)

				local var_99_14 = manager.ui.mainCamera.transform.position - var_99_8.position

				var_99_8.forward = Vector3.New(var_99_14.x, var_99_14.y, var_99_14.z)

				local var_99_15 = var_99_8.localEulerAngles

				var_99_15.z = 0
				var_99_15.x = 0
				var_99_8.localEulerAngles = var_99_15
			end

			if arg_96_1.time_ >= var_99_9 + var_99_11 and arg_96_1.time_ < var_99_9 + var_99_11 + arg_99_0 then
				var_99_8.localPosition = Vector3.New(0, 100, 0)

				local var_99_16 = manager.ui.mainCamera.transform.position - var_99_8.position

				var_99_8.forward = Vector3.New(var_99_16.x, var_99_16.y, var_99_16.z)

				local var_99_17 = var_99_8.localEulerAngles

				var_99_17.z = 0
				var_99_17.x = 0
				var_99_8.localEulerAngles = var_99_17

				local var_99_18 = GameObjectTools.GetOrAddComponent(var_99_8.gameObject, typeof(DynamicBoneHelper))

				if var_99_18 then
					var_99_18:EnableDynamicBone(true)
				end
			end

			local var_99_19 = arg_96_1.actors_["1084ui_story"].transform
			local var_99_20 = 0

			if var_99_20 < arg_96_1.time_ and arg_96_1.time_ <= var_99_20 + arg_99_0 then
				arg_96_1.var_.moveOldPos1084ui_story = var_99_19.localPosition
			end

			local var_99_21 = 0.001

			if var_99_20 <= arg_96_1.time_ and arg_96_1.time_ < var_99_20 + var_99_21 then
				local var_99_22 = (arg_96_1.time_ - var_99_20) / var_99_21
				local var_99_23 = Vector3.New(0, -0.97, -6)

				var_99_19.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1084ui_story, var_99_23, var_99_22)

				local var_99_24 = manager.ui.mainCamera.transform.position - var_99_19.position

				var_99_19.forward = Vector3.New(var_99_24.x, var_99_24.y, var_99_24.z)

				local var_99_25 = var_99_19.localEulerAngles

				var_99_25.z = 0
				var_99_25.x = 0
				var_99_19.localEulerAngles = var_99_25
			end

			if arg_96_1.time_ >= var_99_20 + var_99_21 and arg_96_1.time_ < var_99_20 + var_99_21 + arg_99_0 then
				var_99_19.localPosition = Vector3.New(0, -0.97, -6)

				local var_99_26 = manager.ui.mainCamera.transform.position - var_99_19.position

				var_99_19.forward = Vector3.New(var_99_26.x, var_99_26.y, var_99_26.z)

				local var_99_27 = var_99_19.localEulerAngles

				var_99_27.z = 0
				var_99_27.x = 0
				var_99_19.localEulerAngles = var_99_27
			end

			local var_99_28 = 0

			if var_99_28 < arg_96_1.time_ and arg_96_1.time_ <= var_99_28 + arg_99_0 then
				arg_96_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_99_29 = 0

			if var_99_29 < arg_96_1.time_ and arg_96_1.time_ <= var_99_29 + arg_99_0 then
				arg_96_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_99_30 = 0
			local var_99_31 = 0.3

			if var_99_30 < arg_96_1.time_ and arg_96_1.time_ <= var_99_30 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_32 = arg_96_1:FormatText(StoryNameCfg[6].name)

				arg_96_1.leftNameTxt_.text = var_99_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_33 = arg_96_1:GetWordFromCfg(101131024)
				local var_99_34 = arg_96_1:FormatText(var_99_33.content)

				arg_96_1.text_.text = var_99_34

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_35 = 12
				local var_99_36 = utf8.len(var_99_34)
				local var_99_37 = var_99_35 <= 0 and var_99_31 or var_99_31 * (var_99_36 / var_99_35)

				if var_99_37 > 0 and var_99_31 < var_99_37 then
					arg_96_1.talkMaxDuration = var_99_37

					if var_99_37 + var_99_30 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_37 + var_99_30
					end
				end

				arg_96_1.text_.text = var_99_34
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131024", "story_v_out_101131.awb") ~= 0 then
					local var_99_38 = manager.audio:GetVoiceLength("story_v_out_101131", "101131024", "story_v_out_101131.awb") / 1000

					if var_99_38 + var_99_30 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_38 + var_99_30
					end

					if var_99_33.prefab_name ~= "" and arg_96_1.actors_[var_99_33.prefab_name] ~= nil then
						local var_99_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_33.prefab_name].transform, "story_v_out_101131", "101131024", "story_v_out_101131.awb")

						arg_96_1:RecordAudio("101131024", var_99_39)
						arg_96_1:RecordAudio("101131024", var_99_39)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_101131", "101131024", "story_v_out_101131.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_101131", "101131024", "story_v_out_101131.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_40 = math.max(var_99_31, arg_96_1.talkMaxDuration)

			if var_99_30 <= arg_96_1.time_ and arg_96_1.time_ < var_99_30 + var_99_40 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_30) / var_99_40

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_30 + var_99_40 and arg_96_1.time_ < var_99_30 + var_99_40 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3010_tpose",
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

		arg_96_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B02f"
	},
	voices = {
		"story_v_out_101131.awb"
	}
}
