return {
	Play102021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 102021001
		arg_1_1.duration_ = 8.2

		local var_1_0 = {
			ja = 6.633,
			ko = 5.633,
			zh = 8.2,
			en = 7.3
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
				arg_1_0:Play102021002(arg_1_1)
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

			local var_4_10 = "3010_tpose"

			if arg_1_1.actors_[var_4_10] == nil then
				local var_4_11 = Asset.Load("Char/" .. "3010_tpose")

				if not isNil(var_4_11) then
					local var_4_12 = Object.Instantiate(Asset.Load("Char/" .. "3010_tpose"), arg_1_1.stage_.transform)

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

			local var_4_15 = arg_1_1.actors_["3010_tpose"]
			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect3010_tpose == nil then
				arg_1_1.var_.characterEffect3010_tpose = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_17 = 0.1

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 and not isNil(var_4_15) then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17

				if arg_1_1.var_.characterEffect3010_tpose and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect3010_tpose.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect3010_tpose then
				arg_1_1.var_.characterEffect3010_tpose.fillFlat = false
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

			local var_4_44 = arg_1_1.actors_["3010_tpose"].transform
			local var_4_45 = 1.79999995231628

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1.var_.moveOldPos3010_tpose = var_4_44.localPosition

				local var_4_46 = GameObjectTools.GetOrAddComponent(var_4_44.gameObject, typeof(DynamicBoneHelper))

				if var_4_46 then
					var_4_46:EnableDynamicBone(false)
				end
			end

			local var_4_47 = 0.001

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_47 then
				local var_4_48 = (arg_1_1.time_ - var_4_45) / var_4_47
				local var_4_49 = Vector3.New(0, -1.59, -1.6)

				var_4_44.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos3010_tpose, var_4_49, var_4_48)

				local var_4_50 = manager.ui.mainCamera.transform.position - var_4_44.position

				var_4_44.forward = Vector3.New(var_4_50.x, var_4_50.y, var_4_50.z)

				local var_4_51 = var_4_44.localEulerAngles

				var_4_51.z = 0
				var_4_51.x = 0
				var_4_44.localEulerAngles = var_4_51
			end

			if arg_1_1.time_ >= var_4_45 + var_4_47 and arg_1_1.time_ < var_4_45 + var_4_47 + arg_4_0 then
				var_4_44.localPosition = Vector3.New(0, -1.59, -1.6)

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

			local var_4_55 = 0.45

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				arg_1_1:PlayTimeline("3010_tpose", "StoryTimeline/CharAction/story3010/story3010action/3010action1_1")
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
			local var_4_59 = 0.45

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

				local var_4_61 = arg_1_1:FormatText(StoryNameCfg[40].name)

				arg_1_1.leftNameTxt_.text = var_4_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_62 = arg_1_1:GetWordFromCfg(102021001)
				local var_4_63 = arg_1_1:FormatText(var_4_62.content)

				arg_1_1.text_.text = var_4_63

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_64 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021001", "story_v_out_102021.awb") ~= 0 then
					local var_4_67 = manager.audio:GetVoiceLength("story_v_out_102021", "102021001", "story_v_out_102021.awb") / 1000

					if var_4_67 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_58
					end

					if var_4_62.prefab_name ~= "" and arg_1_1.actors_[var_4_62.prefab_name] ~= nil then
						local var_4_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_62.prefab_name].transform, "story_v_out_102021", "102021001", "story_v_out_102021.awb")

						arg_1_1:RecordAudio("102021001", var_4_68)
						arg_1_1:RecordAudio("102021001", var_4_68)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_102021", "102021001", "story_v_out_102021.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_102021", "102021001", "story_v_out_102021.awb")
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
				actorName = "3010_tpose",
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
	Play102021002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 102021002
		arg_8_1.duration_ = 7.8

		local var_8_0 = {
			ja = 7.8,
			ko = 5,
			zh = 6.133,
			en = 7.333
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
				arg_8_0:Play102021003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1011ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1011ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1011ui_story == nil then
				arg_8_1.var_.characterEffect1011ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1011ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1011ui_story then
				arg_8_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["3010_tpose"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect3010_tpose == nil then
				arg_8_1.var_.characterEffect3010_tpose = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.1

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect3010_tpose and not isNil(var_11_9) then
					local var_11_13 = Mathf.Lerp(0, 0.5, var_11_12)

					arg_8_1.var_.characterEffect3010_tpose.fillFlat = true
					arg_8_1.var_.characterEffect3010_tpose.fillRatio = var_11_13
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect3010_tpose then
				local var_11_14 = 0.5

				arg_8_1.var_.characterEffect3010_tpose.fillFlat = true
				arg_8_1.var_.characterEffect3010_tpose.fillRatio = var_11_14
			end

			local var_11_15 = arg_8_1.actors_["3010_tpose"].transform
			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.var_.moveOldPos3010_tpose = var_11_15.localPosition

				local var_11_17 = GameObjectTools.GetOrAddComponent(var_11_15.gameObject, typeof(DynamicBoneHelper))

				if var_11_17 then
					var_11_17:EnableDynamicBone(false)
				end
			end

			local var_11_18 = 0.001

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_18 then
				local var_11_19 = (arg_8_1.time_ - var_11_16) / var_11_18
				local var_11_20 = Vector3.New(0, 100, 0)

				var_11_15.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos3010_tpose, var_11_20, var_11_19)

				local var_11_21 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_21.x, var_11_21.y, var_11_21.z)

				local var_11_22 = var_11_15.localEulerAngles

				var_11_22.z = 0
				var_11_22.x = 0
				var_11_15.localEulerAngles = var_11_22
			end

			if arg_8_1.time_ >= var_11_16 + var_11_18 and arg_8_1.time_ < var_11_16 + var_11_18 + arg_11_0 then
				var_11_15.localPosition = Vector3.New(0, 100, 0)

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

			local var_11_26 = arg_8_1.actors_["1011ui_story"].transform
			local var_11_27 = 0

			if var_11_27 < arg_8_1.time_ and arg_8_1.time_ <= var_11_27 + arg_11_0 then
				arg_8_1.var_.moveOldPos1011ui_story = var_11_26.localPosition
			end

			local var_11_28 = 0.001

			if var_11_27 <= arg_8_1.time_ and arg_8_1.time_ < var_11_27 + var_11_28 then
				local var_11_29 = (arg_8_1.time_ - var_11_27) / var_11_28
				local var_11_30 = Vector3.New(-0.7, -0.71, -6)

				var_11_26.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1011ui_story, var_11_30, var_11_29)

				local var_11_31 = manager.ui.mainCamera.transform.position - var_11_26.position

				var_11_26.forward = Vector3.New(var_11_31.x, var_11_31.y, var_11_31.z)

				local var_11_32 = var_11_26.localEulerAngles

				var_11_32.z = 0
				var_11_32.x = 0
				var_11_26.localEulerAngles = var_11_32
			end

			if arg_8_1.time_ >= var_11_27 + var_11_28 and arg_8_1.time_ < var_11_27 + var_11_28 + arg_11_0 then
				var_11_26.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_11_33 = manager.ui.mainCamera.transform.position - var_11_26.position

				var_11_26.forward = Vector3.New(var_11_33.x, var_11_33.y, var_11_33.z)

				local var_11_34 = var_11_26.localEulerAngles

				var_11_34.z = 0
				var_11_34.x = 0
				var_11_26.localEulerAngles = var_11_34
			end

			local var_11_35 = 0

			if var_11_35 < arg_8_1.time_ and arg_8_1.time_ <= var_11_35 + arg_11_0 then
				arg_8_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_11_36 = 0

			if var_11_36 < arg_8_1.time_ and arg_8_1.time_ <= var_11_36 + arg_11_0 then
				arg_8_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_11_37 = 0
			local var_11_38 = 0.725

			if var_11_37 < arg_8_1.time_ and arg_8_1.time_ <= var_11_37 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_39 = arg_8_1:FormatText(StoryNameCfg[37].name)

				arg_8_1.leftNameTxt_.text = var_11_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_40 = arg_8_1:GetWordFromCfg(102021002)
				local var_11_41 = arg_8_1:FormatText(var_11_40.content)

				arg_8_1.text_.text = var_11_41

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_42 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021002", "story_v_out_102021.awb") ~= 0 then
					local var_11_45 = manager.audio:GetVoiceLength("story_v_out_102021", "102021002", "story_v_out_102021.awb") / 1000

					if var_11_45 + var_11_37 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_45 + var_11_37
					end

					if var_11_40.prefab_name ~= "" and arg_8_1.actors_[var_11_40.prefab_name] ~= nil then
						local var_11_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_40.prefab_name].transform, "story_v_out_102021", "102021002", "story_v_out_102021.awb")

						arg_8_1:RecordAudio("102021002", var_11_46)
						arg_8_1:RecordAudio("102021002", var_11_46)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_102021", "102021002", "story_v_out_102021.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_102021", "102021002", "story_v_out_102021.awb")
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

		arg_8_1:InitPlayNodeList()
	end,
	Play102021003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 102021003
		arg_12_1.duration_ = 4.67

		local var_12_0 = {
			ja = 4.5,
			ko = 4.066,
			zh = 4.2,
			en = 4.666
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
				arg_12_0:Play102021004(arg_12_1)
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

			local var_15_9 = arg_12_1.actors_["1011ui_story"]
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect1011ui_story == nil then
				arg_12_1.var_.characterEffect1011ui_story = var_15_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_11 = 0.1

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 and not isNil(var_15_9) then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11

				if arg_12_1.var_.characterEffect1011ui_story and not isNil(var_15_9) then
					local var_15_13 = Mathf.Lerp(0, 0.5, var_15_12)

					arg_12_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1011ui_story.fillRatio = var_15_13
				end
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect1011ui_story then
				local var_15_14 = 0.5

				arg_12_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1011ui_story.fillRatio = var_15_14
			end

			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_15_16 = arg_12_1.actors_["1084ui_story"].transform
			local var_15_17 = 0

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_16.localPosition
			end

			local var_15_18 = 0.001

			if var_15_17 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_18 then
				local var_15_19 = (arg_12_1.time_ - var_15_17) / var_15_18
				local var_15_20 = Vector3.New(0.7, -0.97, -6)

				var_15_16.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, var_15_20, var_15_19)

				local var_15_21 = manager.ui.mainCamera.transform.position - var_15_16.position

				var_15_16.forward = Vector3.New(var_15_21.x, var_15_21.y, var_15_21.z)

				local var_15_22 = var_15_16.localEulerAngles

				var_15_22.z = 0
				var_15_22.x = 0
				var_15_16.localEulerAngles = var_15_22
			end

			if arg_12_1.time_ >= var_15_17 + var_15_18 and arg_12_1.time_ < var_15_17 + var_15_18 + arg_15_0 then
				var_15_16.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_15_23 = manager.ui.mainCamera.transform.position - var_15_16.position

				var_15_16.forward = Vector3.New(var_15_23.x, var_15_23.y, var_15_23.z)

				local var_15_24 = var_15_16.localEulerAngles

				var_15_24.z = 0
				var_15_24.x = 0
				var_15_16.localEulerAngles = var_15_24
			end

			local var_15_25 = 0

			if var_15_25 < arg_12_1.time_ and arg_12_1.time_ <= var_15_25 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_15_26 = 0
			local var_15_27 = 0.6

			if var_15_26 < arg_12_1.time_ and arg_12_1.time_ <= var_15_26 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_28 = arg_12_1:FormatText(StoryNameCfg[6].name)

				arg_12_1.leftNameTxt_.text = var_15_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_29 = arg_12_1:GetWordFromCfg(102021003)
				local var_15_30 = arg_12_1:FormatText(var_15_29.content)

				arg_12_1.text_.text = var_15_30

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_31 = 24
				local var_15_32 = utf8.len(var_15_30)
				local var_15_33 = var_15_31 <= 0 and var_15_27 or var_15_27 * (var_15_32 / var_15_31)

				if var_15_33 > 0 and var_15_27 < var_15_33 then
					arg_12_1.talkMaxDuration = var_15_33

					if var_15_33 + var_15_26 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_33 + var_15_26
					end
				end

				arg_12_1.text_.text = var_15_30
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021003", "story_v_out_102021.awb") ~= 0 then
					local var_15_34 = manager.audio:GetVoiceLength("story_v_out_102021", "102021003", "story_v_out_102021.awb") / 1000

					if var_15_34 + var_15_26 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_34 + var_15_26
					end

					if var_15_29.prefab_name ~= "" and arg_12_1.actors_[var_15_29.prefab_name] ~= nil then
						local var_15_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_29.prefab_name].transform, "story_v_out_102021", "102021003", "story_v_out_102021.awb")

						arg_12_1:RecordAudio("102021003", var_15_35)
						arg_12_1:RecordAudio("102021003", var_15_35)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_102021", "102021003", "story_v_out_102021.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_102021", "102021003", "story_v_out_102021.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_36 = math.max(var_15_27, arg_12_1.talkMaxDuration)

			if var_15_26 <= arg_12_1.time_ and arg_12_1.time_ < var_15_26 + var_15_36 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_26) / var_15_36

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_26 + var_15_36 and arg_12_1.time_ < var_15_26 + var_15_36 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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
	Play102021004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 102021004
		arg_16_1.duration_ = 3.7

		local var_16_0 = {
			ja = 3.5,
			ko = 3.433,
			zh = 3.166,
			en = 3.7
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
				arg_16_0:Play102021005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_19_1 = 0
			local var_19_2 = 0.525

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_3 = arg_16_1:FormatText(StoryNameCfg[6].name)

				arg_16_1.leftNameTxt_.text = var_19_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_4 = arg_16_1:GetWordFromCfg(102021004)
				local var_19_5 = arg_16_1:FormatText(var_19_4.content)

				arg_16_1.text_.text = var_19_5

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 19
				local var_19_7 = utf8.len(var_19_5)
				local var_19_8 = var_19_6 <= 0 and var_19_2 or var_19_2 * (var_19_7 / var_19_6)

				if var_19_8 > 0 and var_19_2 < var_19_8 then
					arg_16_1.talkMaxDuration = var_19_8

					if var_19_8 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_5
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021004", "story_v_out_102021.awb") ~= 0 then
					local var_19_9 = manager.audio:GetVoiceLength("story_v_out_102021", "102021004", "story_v_out_102021.awb") / 1000

					if var_19_9 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_1
					end

					if var_19_4.prefab_name ~= "" and arg_16_1.actors_[var_19_4.prefab_name] ~= nil then
						local var_19_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_4.prefab_name].transform, "story_v_out_102021", "102021004", "story_v_out_102021.awb")

						arg_16_1:RecordAudio("102021004", var_19_10)
						arg_16_1:RecordAudio("102021004", var_19_10)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_102021", "102021004", "story_v_out_102021.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_102021", "102021004", "story_v_out_102021.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_11 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_11 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_11

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_11 and arg_16_1.time_ < var_19_1 + var_19_11 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play102021005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 102021005
		arg_20_1.duration_ = 2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play102021006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1011ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1011ui_story == nil then
				arg_20_1.var_.characterEffect1011ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1011ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1011ui_story then
				arg_20_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_23_4 = arg_20_1.actors_["1084ui_story"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = var_23_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.1

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.characterEffect1084ui_story and not isNil(var_23_4) then
					local var_23_8 = Mathf.Lerp(0, 0.5, var_23_7)

					arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1084ui_story.fillRatio = var_23_8
				end
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1084ui_story then
				local var_23_9 = 0.5

				arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1084ui_story.fillRatio = var_23_9
			end

			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action426")
			end

			local var_23_11 = 0

			if var_23_11 < arg_20_1.time_ and arg_20_1.time_ <= var_23_11 + arg_23_0 then
				arg_20_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_23_12 = 0
			local var_23_13 = 0.125

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_14 = arg_20_1:FormatText(StoryNameCfg[37].name)

				arg_20_1.leftNameTxt_.text = var_23_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_15 = arg_20_1:GetWordFromCfg(102021005)
				local var_23_16 = arg_20_1:FormatText(var_23_15.content)

				arg_20_1.text_.text = var_23_16

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_17 = 5
				local var_23_18 = utf8.len(var_23_16)
				local var_23_19 = var_23_17 <= 0 and var_23_13 or var_23_13 * (var_23_18 / var_23_17)

				if var_23_19 > 0 and var_23_13 < var_23_19 then
					arg_20_1.talkMaxDuration = var_23_19

					if var_23_19 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_19 + var_23_12
					end
				end

				arg_20_1.text_.text = var_23_16
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021005", "story_v_out_102021.awb") ~= 0 then
					local var_23_20 = manager.audio:GetVoiceLength("story_v_out_102021", "102021005", "story_v_out_102021.awb") / 1000

					if var_23_20 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_20 + var_23_12
					end

					if var_23_15.prefab_name ~= "" and arg_20_1.actors_[var_23_15.prefab_name] ~= nil then
						local var_23_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_15.prefab_name].transform, "story_v_out_102021", "102021005", "story_v_out_102021.awb")

						arg_20_1:RecordAudio("102021005", var_23_21)
						arg_20_1:RecordAudio("102021005", var_23_21)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_102021", "102021005", "story_v_out_102021.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_102021", "102021005", "story_v_out_102021.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_22 = math.max(var_23_13, arg_20_1.talkMaxDuration)

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_22 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_12) / var_23_22

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_12 + var_23_22 and arg_20_1.time_ < var_23_12 + var_23_22 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play102021006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 102021006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play102021007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1011ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos1011ui_story = var_27_0.localPosition
			end

			local var_27_2 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2
				local var_27_4 = Vector3.New(0, 100, 0)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1011ui_story, var_27_4, var_27_3)

				local var_27_5 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_5.x, var_27_5.y, var_27_5.z)

				local var_27_6 = var_27_0.localEulerAngles

				var_27_6.z = 0
				var_27_6.x = 0
				var_27_0.localEulerAngles = var_27_6
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, 100, 0)

				local var_27_7 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_7.x, var_27_7.y, var_27_7.z)

				local var_27_8 = var_27_0.localEulerAngles

				var_27_8.z = 0
				var_27_8.x = 0
				var_27_0.localEulerAngles = var_27_8
			end

			local var_27_9 = arg_24_1.actors_["1084ui_story"].transform
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = var_27_9.localPosition
			end

			local var_27_11 = 0.001

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11
				local var_27_13 = Vector3.New(0, 100, 0)

				var_27_9.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, var_27_13, var_27_12)

				local var_27_14 = manager.ui.mainCamera.transform.position - var_27_9.position

				var_27_9.forward = Vector3.New(var_27_14.x, var_27_14.y, var_27_14.z)

				local var_27_15 = var_27_9.localEulerAngles

				var_27_15.z = 0
				var_27_15.x = 0
				var_27_9.localEulerAngles = var_27_15
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 then
				var_27_9.localPosition = Vector3.New(0, 100, 0)

				local var_27_16 = manager.ui.mainCamera.transform.position - var_27_9.position

				var_27_9.forward = Vector3.New(var_27_16.x, var_27_16.y, var_27_16.z)

				local var_27_17 = var_27_9.localEulerAngles

				var_27_17.z = 0
				var_27_17.x = 0
				var_27_9.localEulerAngles = var_27_17
			end

			local var_27_18 = 0
			local var_27_19 = 0.6

			if var_27_18 < arg_24_1.time_ and arg_24_1.time_ <= var_27_18 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_20 = arg_24_1:GetWordFromCfg(102021006)
				local var_27_21 = arg_24_1:FormatText(var_27_20.content)

				arg_24_1.text_.text = var_27_21

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_22 = 24
				local var_27_23 = utf8.len(var_27_21)
				local var_27_24 = var_27_22 <= 0 and var_27_19 or var_27_19 * (var_27_23 / var_27_22)

				if var_27_24 > 0 and var_27_19 < var_27_24 then
					arg_24_1.talkMaxDuration = var_27_24

					if var_27_24 + var_27_18 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_24 + var_27_18
					end
				end

				arg_24_1.text_.text = var_27_21
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_25 = math.max(var_27_19, arg_24_1.talkMaxDuration)

			if var_27_18 <= arg_24_1.time_ and arg_24_1.time_ < var_27_18 + var_27_25 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_18) / var_27_25

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_18 + var_27_25 and arg_24_1.time_ < var_27_18 + var_27_25 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play102021007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 102021007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play102021008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_1 = 0.5

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_1 then
				local var_31_2 = (arg_28_1.time_ - var_31_0) / var_31_1
				local var_31_3 = Color.New(1, 1, 1)

				var_31_3.a = Mathf.Lerp(1, 0, var_31_2)
				arg_28_1.mask_.color = var_31_3
			end

			if arg_28_1.time_ >= var_31_0 + var_31_1 and arg_28_1.time_ < var_31_0 + var_31_1 + arg_31_0 then
				local var_31_4 = Color.New(1, 1, 1)
				local var_31_5 = 0

				arg_28_1.mask_.enabled = false
				var_31_4.a = var_31_5
				arg_28_1.mask_.color = var_31_4
			end

			local var_31_6 = 1

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_7 = 0.5

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7
				local var_31_9 = Color.New(1, 1, 1)

				var_31_9.a = Mathf.Lerp(1, 0, var_31_8)
				arg_28_1.mask_.color = var_31_9
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 then
				local var_31_10 = Color.New(1, 1, 1)
				local var_31_11 = 0

				arg_28_1.mask_.enabled = false
				var_31_10.a = var_31_11
				arg_28_1.mask_.color = var_31_10
			end

			local var_31_12 = manager.ui.mainCamera.transform
			local var_31_13 = 0

			if var_31_13 < arg_28_1.time_ and arg_28_1.time_ <= var_31_13 + arg_31_0 then
				arg_28_1.var_.shakeOldPosMainCamera = var_31_12.localPosition
			end

			local var_31_14 = 0.600000023841858

			if var_31_13 <= arg_28_1.time_ and arg_28_1.time_ < var_31_13 + var_31_14 then
				local var_31_15 = (arg_28_1.time_ - var_31_13) / 0.066
				local var_31_16, var_31_17 = math.modf(var_31_15)

				var_31_12.localPosition = Vector3.New(var_31_17 * 0.13, var_31_17 * 0.13, var_31_17 * 0.13) + arg_28_1.var_.shakeOldPosMainCamera
			end

			if arg_28_1.time_ >= var_31_13 + var_31_14 and arg_28_1.time_ < var_31_13 + var_31_14 + arg_31_0 then
				var_31_12.localPosition = arg_28_1.var_.shakeOldPosMainCamera
			end

			local var_31_18 = 0
			local var_31_19 = 1.25

			if var_31_18 < arg_28_1.time_ and arg_28_1.time_ <= var_31_18 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_20 = arg_28_1:GetWordFromCfg(102021007)
				local var_31_21 = arg_28_1:FormatText(var_31_20.content)

				arg_28_1.text_.text = var_31_21

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_22 = 50
				local var_31_23 = utf8.len(var_31_21)
				local var_31_24 = var_31_22 <= 0 and var_31_19 or var_31_19 * (var_31_23 / var_31_22)

				if var_31_24 > 0 and var_31_19 < var_31_24 then
					arg_28_1.talkMaxDuration = var_31_24

					if var_31_24 + var_31_18 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_24 + var_31_18
					end
				end

				arg_28_1.text_.text = var_31_21
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_25 = math.max(var_31_19, arg_28_1.talkMaxDuration)

			if var_31_18 <= arg_28_1.time_ and arg_28_1.time_ < var_31_18 + var_31_25 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_18) / var_31_25

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_18 + var_31_25 and arg_28_1.time_ < var_31_18 + var_31_25 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play102021008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 102021008
		arg_32_1.duration_ = 3.63

		local var_32_0 = {
			ja = 3.633,
			ko = 2.2,
			zh = 3.133,
			en = 2.2
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
				arg_32_0:Play102021009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["3010_tpose"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3010_tpose == nil then
				arg_32_1.var_.characterEffect3010_tpose = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect3010_tpose and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect3010_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3010_tpose then
				arg_32_1.var_.characterEffect3010_tpose.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["3010_tpose"].transform
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1.var_.moveOldPos3010_tpose = var_35_4.localPosition

				local var_35_6 = GameObjectTools.GetOrAddComponent(var_35_4.gameObject, typeof(DynamicBoneHelper))

				if var_35_6 then
					var_35_6:EnableDynamicBone(false)
				end
			end

			local var_35_7 = 0.001

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_7 then
				local var_35_8 = (arg_32_1.time_ - var_35_5) / var_35_7
				local var_35_9 = Vector3.New(0, -1.59, -1.6)

				var_35_4.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos3010_tpose, var_35_9, var_35_8)

				local var_35_10 = manager.ui.mainCamera.transform.position - var_35_4.position

				var_35_4.forward = Vector3.New(var_35_10.x, var_35_10.y, var_35_10.z)

				local var_35_11 = var_35_4.localEulerAngles

				var_35_11.z = 0
				var_35_11.x = 0
				var_35_4.localEulerAngles = var_35_11
			end

			if arg_32_1.time_ >= var_35_5 + var_35_7 and arg_32_1.time_ < var_35_5 + var_35_7 + arg_35_0 then
				var_35_4.localPosition = Vector3.New(0, -1.59, -1.6)

				local var_35_12 = manager.ui.mainCamera.transform.position - var_35_4.position

				var_35_4.forward = Vector3.New(var_35_12.x, var_35_12.y, var_35_12.z)

				local var_35_13 = var_35_4.localEulerAngles

				var_35_13.z = 0
				var_35_13.x = 0
				var_35_4.localEulerAngles = var_35_13

				local var_35_14 = GameObjectTools.GetOrAddComponent(var_35_4.gameObject, typeof(DynamicBoneHelper))

				if var_35_14 then
					var_35_14:EnableDynamicBone(true)
				end
			end

			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1:PlayTimeline("3010_tpose", "StoryTimeline/CharAction/story3010/story3010action/3010action1_1")
			end

			local var_35_16 = 0
			local var_35_17 = 0.275

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_18 = arg_32_1:FormatText(StoryNameCfg[40].name)

				arg_32_1.leftNameTxt_.text = var_35_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_19 = arg_32_1:GetWordFromCfg(102021008)
				local var_35_20 = arg_32_1:FormatText(var_35_19.content)

				arg_32_1.text_.text = var_35_20

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_21 = 11
				local var_35_22 = utf8.len(var_35_20)
				local var_35_23 = var_35_21 <= 0 and var_35_17 or var_35_17 * (var_35_22 / var_35_21)

				if var_35_23 > 0 and var_35_17 < var_35_23 then
					arg_32_1.talkMaxDuration = var_35_23

					if var_35_23 + var_35_16 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_23 + var_35_16
					end
				end

				arg_32_1.text_.text = var_35_20
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021008", "story_v_out_102021.awb") ~= 0 then
					local var_35_24 = manager.audio:GetVoiceLength("story_v_out_102021", "102021008", "story_v_out_102021.awb") / 1000

					if var_35_24 + var_35_16 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_24 + var_35_16
					end

					if var_35_19.prefab_name ~= "" and arg_32_1.actors_[var_35_19.prefab_name] ~= nil then
						local var_35_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_19.prefab_name].transform, "story_v_out_102021", "102021008", "story_v_out_102021.awb")

						arg_32_1:RecordAudio("102021008", var_35_25)
						arg_32_1:RecordAudio("102021008", var_35_25)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_102021", "102021008", "story_v_out_102021.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_102021", "102021008", "story_v_out_102021.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_26 = math.max(var_35_17, arg_32_1.talkMaxDuration)

			if var_35_16 <= arg_32_1.time_ and arg_32_1.time_ < var_35_16 + var_35_26 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_16) / var_35_26

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_16 + var_35_26 and arg_32_1.time_ < var_35_16 + var_35_26 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play102021009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 102021009
		arg_36_1.duration_ = 2.73

		local var_36_0 = {
			ja = 2,
			ko = 1.866,
			zh = 2.433,
			en = 2.733
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
				arg_36_0:Play102021010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1084ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["3010_tpose"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect3010_tpose == nil then
				arg_36_1.var_.characterEffect3010_tpose = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.1

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect3010_tpose and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect3010_tpose.fillFlat = true
					arg_36_1.var_.characterEffect3010_tpose.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect3010_tpose then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect3010_tpose.fillFlat = true
				arg_36_1.var_.characterEffect3010_tpose.fillRatio = var_39_9
			end

			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_39_11 = 0
			local var_39_12 = 0.275

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_13 = arg_36_1:FormatText(StoryNameCfg[6].name)

				arg_36_1.leftNameTxt_.text = var_39_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_14 = arg_36_1:GetWordFromCfg(102021009)
				local var_39_15 = arg_36_1:FormatText(var_39_14.content)

				arg_36_1.text_.text = var_39_15

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_16 = 11
				local var_39_17 = utf8.len(var_39_15)
				local var_39_18 = var_39_16 <= 0 and var_39_12 or var_39_12 * (var_39_17 / var_39_16)

				if var_39_18 > 0 and var_39_12 < var_39_18 then
					arg_36_1.talkMaxDuration = var_39_18

					if var_39_18 + var_39_11 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_11
					end
				end

				arg_36_1.text_.text = var_39_15
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021009", "story_v_out_102021.awb") ~= 0 then
					local var_39_19 = manager.audio:GetVoiceLength("story_v_out_102021", "102021009", "story_v_out_102021.awb") / 1000

					if var_39_19 + var_39_11 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_19 + var_39_11
					end

					if var_39_14.prefab_name ~= "" and arg_36_1.actors_[var_39_14.prefab_name] ~= nil then
						local var_39_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_14.prefab_name].transform, "story_v_out_102021", "102021009", "story_v_out_102021.awb")

						arg_36_1:RecordAudio("102021009", var_39_20)
						arg_36_1:RecordAudio("102021009", var_39_20)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_102021", "102021009", "story_v_out_102021.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_102021", "102021009", "story_v_out_102021.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_21 = math.max(var_39_12, arg_36_1.talkMaxDuration)

			if var_39_11 <= arg_36_1.time_ and arg_36_1.time_ < var_39_11 + var_39_21 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_11) / var_39_21

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_11 + var_39_21 and arg_36_1.time_ < var_39_11 + var_39_21 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play102021010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 102021010
		arg_40_1.duration_ = 1.6

		local var_40_0 = {
			ja = 1.033,
			ko = 0.999999999999,
			zh = 0.999999999999,
			en = 1.6
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
				arg_40_0:Play102021011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1084ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_5
			end

			local var_43_6 = 0

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_43_7 = 0
			local var_43_8 = 0.05

			if var_43_7 < arg_40_1.time_ and arg_40_1.time_ <= var_43_7 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_9 = arg_40_1:FormatText(StoryNameCfg[37].name)

				arg_40_1.leftNameTxt_.text = var_43_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_10 = arg_40_1:GetWordFromCfg(102021010)
				local var_43_11 = arg_40_1:FormatText(var_43_10.content)

				arg_40_1.text_.text = var_43_11

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_12 = 2
				local var_43_13 = utf8.len(var_43_11)
				local var_43_14 = var_43_12 <= 0 and var_43_8 or var_43_8 * (var_43_13 / var_43_12)

				if var_43_14 > 0 and var_43_8 < var_43_14 then
					arg_40_1.talkMaxDuration = var_43_14

					if var_43_14 + var_43_7 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_7
					end
				end

				arg_40_1.text_.text = var_43_11
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021010", "story_v_out_102021.awb") ~= 0 then
					local var_43_15 = manager.audio:GetVoiceLength("story_v_out_102021", "102021010", "story_v_out_102021.awb") / 1000

					if var_43_15 + var_43_7 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_15 + var_43_7
					end

					if var_43_10.prefab_name ~= "" and arg_40_1.actors_[var_43_10.prefab_name] ~= nil then
						local var_43_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_10.prefab_name].transform, "story_v_out_102021", "102021010", "story_v_out_102021.awb")

						arg_40_1:RecordAudio("102021010", var_43_16)
						arg_40_1:RecordAudio("102021010", var_43_16)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_102021", "102021010", "story_v_out_102021.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_102021", "102021010", "story_v_out_102021.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_17 = math.max(var_43_8, arg_40_1.talkMaxDuration)

			if var_43_7 <= arg_40_1.time_ and arg_40_1.time_ < var_43_7 + var_43_17 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_7) / var_43_17

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_7 + var_43_17 and arg_40_1.time_ < var_43_7 + var_43_17 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play102021011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 102021011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play102021012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["3010_tpose"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos3010_tpose = var_47_0.localPosition

				local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(false)
				end
			end

			local var_47_3 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_3 then
				local var_47_4 = (arg_44_1.time_ - var_47_1) / var_47_3
				local var_47_5 = Vector3.New(0, 100, 0)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos3010_tpose, var_47_5, var_47_4)

				local var_47_6 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_6.x, var_47_6.y, var_47_6.z)

				local var_47_7 = var_47_0.localEulerAngles

				var_47_7.z = 0
				var_47_7.x = 0
				var_47_0.localEulerAngles = var_47_7
			end

			if arg_44_1.time_ >= var_47_1 + var_47_3 and arg_44_1.time_ < var_47_1 + var_47_3 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, 100, 0)

				local var_47_8 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_8.x, var_47_8.y, var_47_8.z)

				local var_47_9 = var_47_0.localEulerAngles

				var_47_9.z = 0
				var_47_9.x = 0
				var_47_0.localEulerAngles = var_47_9

				local var_47_10 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_10 then
					var_47_10:EnableDynamicBone(true)
				end
			end

			local var_47_11 = 0
			local var_47_12 = 0.7

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_13 = arg_44_1:GetWordFromCfg(102021011)
				local var_47_14 = arg_44_1:FormatText(var_47_13.content)

				arg_44_1.text_.text = var_47_14

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_15 = 28
				local var_47_16 = utf8.len(var_47_14)
				local var_47_17 = var_47_15 <= 0 and var_47_12 or var_47_12 * (var_47_16 / var_47_15)

				if var_47_17 > 0 and var_47_12 < var_47_17 then
					arg_44_1.talkMaxDuration = var_47_17

					if var_47_17 + var_47_11 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_17 + var_47_11
					end
				end

				arg_44_1.text_.text = var_47_14
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_18 = math.max(var_47_12, arg_44_1.talkMaxDuration)

			if var_47_11 <= arg_44_1.time_ and arg_44_1.time_ < var_47_11 + var_47_18 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_11) / var_47_18

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_11 + var_47_18 and arg_44_1.time_ < var_47_11 + var_47_18 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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

		arg_44_1:InitPlayNodeList()
	end,
	Play102021012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 102021012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play102021013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_1 = 0.5

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_1 then
				local var_51_2 = (arg_48_1.time_ - var_51_0) / var_51_1
				local var_51_3 = Color.New(1, 1, 1)

				var_51_3.a = Mathf.Lerp(1, 0, var_51_2)
				arg_48_1.mask_.color = var_51_3
			end

			if arg_48_1.time_ >= var_51_0 + var_51_1 and arg_48_1.time_ < var_51_0 + var_51_1 + arg_51_0 then
				local var_51_4 = Color.New(1, 1, 1)
				local var_51_5 = 0

				arg_48_1.mask_.enabled = false
				var_51_4.a = var_51_5
				arg_48_1.mask_.color = var_51_4
			end

			local var_51_6 = 1

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_7 = 0.5

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_7 then
				local var_51_8 = (arg_48_1.time_ - var_51_6) / var_51_7
				local var_51_9 = Color.New(1, 1, 1)

				var_51_9.a = Mathf.Lerp(1, 0, var_51_8)
				arg_48_1.mask_.color = var_51_9
			end

			if arg_48_1.time_ >= var_51_6 + var_51_7 and arg_48_1.time_ < var_51_6 + var_51_7 + arg_51_0 then
				local var_51_10 = Color.New(1, 1, 1)
				local var_51_11 = 0

				arg_48_1.mask_.enabled = false
				var_51_10.a = var_51_11
				arg_48_1.mask_.color = var_51_10
			end

			local var_51_12 = manager.ui.mainCamera.transform
			local var_51_13 = 0

			if var_51_13 < arg_48_1.time_ and arg_48_1.time_ <= var_51_13 + arg_51_0 then
				arg_48_1.var_.shakeOldPosMainCamera = var_51_12.localPosition
			end

			local var_51_14 = 0.600000023841858

			if var_51_13 <= arg_48_1.time_ and arg_48_1.time_ < var_51_13 + var_51_14 then
				local var_51_15 = (arg_48_1.time_ - var_51_13) / 0.066
				local var_51_16, var_51_17 = math.modf(var_51_15)

				var_51_12.localPosition = Vector3.New(var_51_17 * 0.13, var_51_17 * 0.13, var_51_17 * 0.13) + arg_48_1.var_.shakeOldPosMainCamera
			end

			if arg_48_1.time_ >= var_51_13 + var_51_14 and arg_48_1.time_ < var_51_13 + var_51_14 + arg_51_0 then
				var_51_12.localPosition = arg_48_1.var_.shakeOldPosMainCamera
			end

			local var_51_18 = 0
			local var_51_19 = 1.375

			if var_51_18 < arg_48_1.time_ and arg_48_1.time_ <= var_51_18 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_20 = arg_48_1:GetWordFromCfg(102021012)
				local var_51_21 = arg_48_1:FormatText(var_51_20.content)

				arg_48_1.text_.text = var_51_21

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_22 = 55
				local var_51_23 = utf8.len(var_51_21)
				local var_51_24 = var_51_22 <= 0 and var_51_19 or var_51_19 * (var_51_23 / var_51_22)

				if var_51_24 > 0 and var_51_19 < var_51_24 then
					arg_48_1.talkMaxDuration = var_51_24

					if var_51_24 + var_51_18 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_24 + var_51_18
					end
				end

				arg_48_1.text_.text = var_51_21
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_25 = math.max(var_51_19, arg_48_1.talkMaxDuration)

			if var_51_18 <= arg_48_1.time_ and arg_48_1.time_ < var_51_18 + var_51_25 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_18) / var_51_25

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_18 + var_51_25 and arg_48_1.time_ < var_51_18 + var_51_25 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play102021013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 102021013
		arg_52_1.duration_ = 2.33

		local var_52_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.333,
			en = 1.999999999999
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
				arg_52_0:Play102021014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["3010_tpose"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect3010_tpose == nil then
				arg_52_1.var_.characterEffect3010_tpose = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect3010_tpose and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect3010_tpose.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect3010_tpose then
				arg_52_1.var_.characterEffect3010_tpose.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["3010_tpose"].transform
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.var_.moveOldPos3010_tpose = var_55_4.localPosition

				local var_55_6 = GameObjectTools.GetOrAddComponent(var_55_4.gameObject, typeof(DynamicBoneHelper))

				if var_55_6 then
					var_55_6:EnableDynamicBone(false)
				end
			end

			local var_55_7 = 0.001

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_7 then
				local var_55_8 = (arg_52_1.time_ - var_55_5) / var_55_7
				local var_55_9 = Vector3.New(0, -1.59, -1.6)

				var_55_4.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos3010_tpose, var_55_9, var_55_8)

				local var_55_10 = manager.ui.mainCamera.transform.position - var_55_4.position

				var_55_4.forward = Vector3.New(var_55_10.x, var_55_10.y, var_55_10.z)

				local var_55_11 = var_55_4.localEulerAngles

				var_55_11.z = 0
				var_55_11.x = 0
				var_55_4.localEulerAngles = var_55_11
			end

			if arg_52_1.time_ >= var_55_5 + var_55_7 and arg_52_1.time_ < var_55_5 + var_55_7 + arg_55_0 then
				var_55_4.localPosition = Vector3.New(0, -1.59, -1.6)

				local var_55_12 = manager.ui.mainCamera.transform.position - var_55_4.position

				var_55_4.forward = Vector3.New(var_55_12.x, var_55_12.y, var_55_12.z)

				local var_55_13 = var_55_4.localEulerAngles

				var_55_13.z = 0
				var_55_13.x = 0
				var_55_4.localEulerAngles = var_55_13

				local var_55_14 = GameObjectTools.GetOrAddComponent(var_55_4.gameObject, typeof(DynamicBoneHelper))

				if var_55_14 then
					var_55_14:EnableDynamicBone(true)
				end
			end

			local var_55_15 = 0

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1:PlayTimeline("3010_tpose", "StoryTimeline/CharAction/story3010/story3010action/3010action1_1")
			end

			local var_55_16 = 0
			local var_55_17 = 0.125

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_18 = arg_52_1:FormatText(StoryNameCfg[40].name)

				arg_52_1.leftNameTxt_.text = var_55_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_19 = arg_52_1:GetWordFromCfg(102021013)
				local var_55_20 = arg_52_1:FormatText(var_55_19.content)

				arg_52_1.text_.text = var_55_20

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_21 = 5
				local var_55_22 = utf8.len(var_55_20)
				local var_55_23 = var_55_21 <= 0 and var_55_17 or var_55_17 * (var_55_22 / var_55_21)

				if var_55_23 > 0 and var_55_17 < var_55_23 then
					arg_52_1.talkMaxDuration = var_55_23

					if var_55_23 + var_55_16 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_16
					end
				end

				arg_52_1.text_.text = var_55_20
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021013", "story_v_out_102021.awb") ~= 0 then
					local var_55_24 = manager.audio:GetVoiceLength("story_v_out_102021", "102021013", "story_v_out_102021.awb") / 1000

					if var_55_24 + var_55_16 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_24 + var_55_16
					end

					if var_55_19.prefab_name ~= "" and arg_52_1.actors_[var_55_19.prefab_name] ~= nil then
						local var_55_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_19.prefab_name].transform, "story_v_out_102021", "102021013", "story_v_out_102021.awb")

						arg_52_1:RecordAudio("102021013", var_55_25)
						arg_52_1:RecordAudio("102021013", var_55_25)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_102021", "102021013", "story_v_out_102021.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_102021", "102021013", "story_v_out_102021.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_26 = math.max(var_55_17, arg_52_1.talkMaxDuration)

			if var_55_16 <= arg_52_1.time_ and arg_52_1.time_ < var_55_16 + var_55_26 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_16) / var_55_26

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_16 + var_55_26 and arg_52_1.time_ < var_55_16 + var_55_26 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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

		arg_52_1:InitPlayNodeList()
	end,
	Play102021014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 102021014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play102021015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["3010_tpose"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect3010_tpose == nil then
				arg_56_1.var_.characterEffect3010_tpose = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect3010_tpose and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect3010_tpose.fillFlat = true
					arg_56_1.var_.characterEffect3010_tpose.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect3010_tpose then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect3010_tpose.fillFlat = true
				arg_56_1.var_.characterEffect3010_tpose.fillRatio = var_59_5
			end

			local var_59_6 = arg_56_1.actors_["3010_tpose"].transform
			local var_59_7 = 0

			if var_59_7 < arg_56_1.time_ and arg_56_1.time_ <= var_59_7 + arg_59_0 then
				arg_56_1.var_.moveOldPos3010_tpose = var_59_6.localPosition

				local var_59_8 = GameObjectTools.GetOrAddComponent(var_59_6.gameObject, typeof(DynamicBoneHelper))

				if var_59_8 then
					var_59_8:EnableDynamicBone(false)
				end
			end

			local var_59_9 = 0.001

			if var_59_7 <= arg_56_1.time_ and arg_56_1.time_ < var_59_7 + var_59_9 then
				local var_59_10 = (arg_56_1.time_ - var_59_7) / var_59_9
				local var_59_11 = Vector3.New(0, 100, 0)

				var_59_6.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos3010_tpose, var_59_11, var_59_10)

				local var_59_12 = manager.ui.mainCamera.transform.position - var_59_6.position

				var_59_6.forward = Vector3.New(var_59_12.x, var_59_12.y, var_59_12.z)

				local var_59_13 = var_59_6.localEulerAngles

				var_59_13.z = 0
				var_59_13.x = 0
				var_59_6.localEulerAngles = var_59_13
			end

			if arg_56_1.time_ >= var_59_7 + var_59_9 and arg_56_1.time_ < var_59_7 + var_59_9 + arg_59_0 then
				var_59_6.localPosition = Vector3.New(0, 100, 0)

				local var_59_14 = manager.ui.mainCamera.transform.position - var_59_6.position

				var_59_6.forward = Vector3.New(var_59_14.x, var_59_14.y, var_59_14.z)

				local var_59_15 = var_59_6.localEulerAngles

				var_59_15.z = 0
				var_59_15.x = 0
				var_59_6.localEulerAngles = var_59_15

				local var_59_16 = GameObjectTools.GetOrAddComponent(var_59_6.gameObject, typeof(DynamicBoneHelper))

				if var_59_16 then
					var_59_16:EnableDynamicBone(true)
				end
			end

			local var_59_17 = 0
			local var_59_18 = 0.65

			if var_59_17 < arg_56_1.time_ and arg_56_1.time_ <= var_59_17 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_19 = arg_56_1:GetWordFromCfg(102021014)
				local var_59_20 = arg_56_1:FormatText(var_59_19.content)

				arg_56_1.text_.text = var_59_20

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_21 = 26
				local var_59_22 = utf8.len(var_59_20)
				local var_59_23 = var_59_21 <= 0 and var_59_18 or var_59_18 * (var_59_22 / var_59_21)

				if var_59_23 > 0 and var_59_18 < var_59_23 then
					arg_56_1.talkMaxDuration = var_59_23

					if var_59_23 + var_59_17 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_23 + var_59_17
					end
				end

				arg_56_1.text_.text = var_59_20
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_24 = math.max(var_59_18, arg_56_1.talkMaxDuration)

			if var_59_17 <= arg_56_1.time_ and arg_56_1.time_ < var_59_17 + var_59_24 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_17) / var_59_24

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_17 + var_59_24 and arg_56_1.time_ < var_59_17 + var_59_24 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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

		arg_56_1:InitPlayNodeList()
	end,
	Play102021015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 102021015
		arg_60_1.duration_ = 2.93

		local var_60_0 = {
			ja = 2.933,
			ko = 2.633,
			zh = 1.999999999999,
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
				arg_60_0:Play102021016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1084ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1084ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1084ui_story then
				arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["1084ui_story"].transform
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1.var_.moveOldPos1084ui_story = var_63_4.localPosition
			end

			local var_63_6 = 0.001

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6
				local var_63_8 = Vector3.New(-0.7, -0.97, -6)

				var_63_4.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1084ui_story, var_63_8, var_63_7)

				local var_63_9 = manager.ui.mainCamera.transform.position - var_63_4.position

				var_63_4.forward = Vector3.New(var_63_9.x, var_63_9.y, var_63_9.z)

				local var_63_10 = var_63_4.localEulerAngles

				var_63_10.z = 0
				var_63_10.x = 0
				var_63_4.localEulerAngles = var_63_10
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 then
				var_63_4.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_63_11 = manager.ui.mainCamera.transform.position - var_63_4.position

				var_63_4.forward = Vector3.New(var_63_11.x, var_63_11.y, var_63_11.z)

				local var_63_12 = var_63_4.localEulerAngles

				var_63_12.z = 0
				var_63_12.x = 0
				var_63_4.localEulerAngles = var_63_12
			end

			local var_63_13 = 0

			if var_63_13 < arg_60_1.time_ and arg_60_1.time_ <= var_63_13 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_63_14 = 0

			if var_63_14 < arg_60_1.time_ and arg_60_1.time_ <= var_63_14 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_63_15 = 0
			local var_63_16 = 0.175

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_17 = arg_60_1:FormatText(StoryNameCfg[6].name)

				arg_60_1.leftNameTxt_.text = var_63_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_18 = arg_60_1:GetWordFromCfg(102021015)
				local var_63_19 = arg_60_1:FormatText(var_63_18.content)

				arg_60_1.text_.text = var_63_19

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_20 = 7
				local var_63_21 = utf8.len(var_63_19)
				local var_63_22 = var_63_20 <= 0 and var_63_16 or var_63_16 * (var_63_21 / var_63_20)

				if var_63_22 > 0 and var_63_16 < var_63_22 then
					arg_60_1.talkMaxDuration = var_63_22

					if var_63_22 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_22 + var_63_15
					end
				end

				arg_60_1.text_.text = var_63_19
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021015", "story_v_out_102021.awb") ~= 0 then
					local var_63_23 = manager.audio:GetVoiceLength("story_v_out_102021", "102021015", "story_v_out_102021.awb") / 1000

					if var_63_23 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_15
					end

					if var_63_18.prefab_name ~= "" and arg_60_1.actors_[var_63_18.prefab_name] ~= nil then
						local var_63_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_18.prefab_name].transform, "story_v_out_102021", "102021015", "story_v_out_102021.awb")

						arg_60_1:RecordAudio("102021015", var_63_24)
						arg_60_1:RecordAudio("102021015", var_63_24)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_102021", "102021015", "story_v_out_102021.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_102021", "102021015", "story_v_out_102021.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_25 = math.max(var_63_16, arg_60_1.talkMaxDuration)

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_25 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_15) / var_63_25

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_15 + var_63_25 and arg_60_1.time_ < var_63_15 + var_63_25 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play102021016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 102021016
		arg_64_1.duration_ = 3

		local var_64_0 = {
			ja = 2.666,
			ko = 3,
			zh = 2.833,
			en = 2.633
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
				arg_64_0:Play102021017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1011ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1011ui_story == nil then
				arg_64_1.var_.characterEffect1011ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1011ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1011ui_story then
				arg_64_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["1084ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.1

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect1084ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1084ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1084ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1084ui_story.fillRatio = var_67_9
			end

			local var_67_10 = arg_64_1.actors_["1011ui_story"].transform
			local var_67_11 = 0

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.var_.moveOldPos1011ui_story = var_67_10.localPosition
			end

			local var_67_12 = 0.001

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_11) / var_67_12
				local var_67_14 = Vector3.New(0.7, -0.71, -6)

				var_67_10.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1011ui_story, var_67_14, var_67_13)

				local var_67_15 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_15.x, var_67_15.y, var_67_15.z)

				local var_67_16 = var_67_10.localEulerAngles

				var_67_16.z = 0
				var_67_16.x = 0
				var_67_10.localEulerAngles = var_67_16
			end

			if arg_64_1.time_ >= var_67_11 + var_67_12 and arg_64_1.time_ < var_67_11 + var_67_12 + arg_67_0 then
				var_67_10.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_67_17 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_17.x, var_67_17.y, var_67_17.z)

				local var_67_18 = var_67_10.localEulerAngles

				var_67_18.z = 0
				var_67_18.x = 0
				var_67_10.localEulerAngles = var_67_18
			end

			local var_67_19 = 0

			if var_67_19 < arg_64_1.time_ and arg_64_1.time_ <= var_67_19 + arg_67_0 then
				arg_64_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_67_20 = 0

			if var_67_20 < arg_64_1.time_ and arg_64_1.time_ <= var_67_20 + arg_67_0 then
				arg_64_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_67_21 = 0
			local var_67_22 = 0.275

			if var_67_21 < arg_64_1.time_ and arg_64_1.time_ <= var_67_21 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_23 = arg_64_1:FormatText(StoryNameCfg[37].name)

				arg_64_1.leftNameTxt_.text = var_67_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_24 = arg_64_1:GetWordFromCfg(102021016)
				local var_67_25 = arg_64_1:FormatText(var_67_24.content)

				arg_64_1.text_.text = var_67_25

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_26 = 11
				local var_67_27 = utf8.len(var_67_25)
				local var_67_28 = var_67_26 <= 0 and var_67_22 or var_67_22 * (var_67_27 / var_67_26)

				if var_67_28 > 0 and var_67_22 < var_67_28 then
					arg_64_1.talkMaxDuration = var_67_28

					if var_67_28 + var_67_21 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_28 + var_67_21
					end
				end

				arg_64_1.text_.text = var_67_25
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021016", "story_v_out_102021.awb") ~= 0 then
					local var_67_29 = manager.audio:GetVoiceLength("story_v_out_102021", "102021016", "story_v_out_102021.awb") / 1000

					if var_67_29 + var_67_21 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_29 + var_67_21
					end

					if var_67_24.prefab_name ~= "" and arg_64_1.actors_[var_67_24.prefab_name] ~= nil then
						local var_67_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_24.prefab_name].transform, "story_v_out_102021", "102021016", "story_v_out_102021.awb")

						arg_64_1:RecordAudio("102021016", var_67_30)
						arg_64_1:RecordAudio("102021016", var_67_30)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_102021", "102021016", "story_v_out_102021.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_102021", "102021016", "story_v_out_102021.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_31 = math.max(var_67_22, arg_64_1.talkMaxDuration)

			if var_67_21 <= arg_64_1.time_ and arg_64_1.time_ < var_67_21 + var_67_31 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_21) / var_67_31

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_21 + var_67_31 and arg_64_1.time_ < var_67_21 + var_67_31 + arg_67_0 then
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
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play102021017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 102021017
		arg_68_1.duration_ = 3.63

		local var_68_0 = {
			ja = 3.466,
			ko = 2.966,
			zh = 3.4,
			en = 3.633
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
				arg_68_0:Play102021018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = "1019ui_story"

			if arg_68_1.actors_[var_71_0] == nil then
				local var_71_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_71_1) then
					local var_71_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_68_1.stage_.transform)

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

			local var_71_5 = arg_68_1.actors_["1019ui_story"]
			local var_71_6 = 0

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 and not isNil(var_71_5) and arg_68_1.var_.characterEffect1019ui_story == nil then
				arg_68_1.var_.characterEffect1019ui_story = var_71_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_7 = 0.1

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_7 and not isNil(var_71_5) then
				local var_71_8 = (arg_68_1.time_ - var_71_6) / var_71_7

				if arg_68_1.var_.characterEffect1019ui_story and not isNil(var_71_5) then
					arg_68_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_6 + var_71_7 and arg_68_1.time_ < var_71_6 + var_71_7 + arg_71_0 and not isNil(var_71_5) and arg_68_1.var_.characterEffect1019ui_story then
				arg_68_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_71_9 = arg_68_1.actors_["1011ui_story"]
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1011ui_story == nil then
				arg_68_1.var_.characterEffect1011ui_story = var_71_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_11 = 0.1

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 and not isNil(var_71_9) then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11

				if arg_68_1.var_.characterEffect1011ui_story and not isNil(var_71_9) then
					local var_71_13 = Mathf.Lerp(0, 0.5, var_71_12)

					arg_68_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1011ui_story.fillRatio = var_71_13
				end
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1011ui_story then
				local var_71_14 = 0.5

				arg_68_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1011ui_story.fillRatio = var_71_14
			end

			local var_71_15 = arg_68_1.actors_["1011ui_story"].transform
			local var_71_16 = 0

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1.var_.moveOldPos1011ui_story = var_71_15.localPosition
			end

			local var_71_17 = 0.001

			if var_71_16 <= arg_68_1.time_ and arg_68_1.time_ < var_71_16 + var_71_17 then
				local var_71_18 = (arg_68_1.time_ - var_71_16) / var_71_17
				local var_71_19 = Vector3.New(0, 100, 0)

				var_71_15.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1011ui_story, var_71_19, var_71_18)

				local var_71_20 = manager.ui.mainCamera.transform.position - var_71_15.position

				var_71_15.forward = Vector3.New(var_71_20.x, var_71_20.y, var_71_20.z)

				local var_71_21 = var_71_15.localEulerAngles

				var_71_21.z = 0
				var_71_21.x = 0
				var_71_15.localEulerAngles = var_71_21
			end

			if arg_68_1.time_ >= var_71_16 + var_71_17 and arg_68_1.time_ < var_71_16 + var_71_17 + arg_71_0 then
				var_71_15.localPosition = Vector3.New(0, 100, 0)

				local var_71_22 = manager.ui.mainCamera.transform.position - var_71_15.position

				var_71_15.forward = Vector3.New(var_71_22.x, var_71_22.y, var_71_22.z)

				local var_71_23 = var_71_15.localEulerAngles

				var_71_23.z = 0
				var_71_23.x = 0
				var_71_15.localEulerAngles = var_71_23
			end

			local var_71_24 = arg_68_1.actors_["1084ui_story"].transform
			local var_71_25 = 0

			if var_71_25 < arg_68_1.time_ and arg_68_1.time_ <= var_71_25 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = var_71_24.localPosition
			end

			local var_71_26 = 0.001

			if var_71_25 <= arg_68_1.time_ and arg_68_1.time_ < var_71_25 + var_71_26 then
				local var_71_27 = (arg_68_1.time_ - var_71_25) / var_71_26
				local var_71_28 = Vector3.New(0, 100, 0)

				var_71_24.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, var_71_28, var_71_27)

				local var_71_29 = manager.ui.mainCamera.transform.position - var_71_24.position

				var_71_24.forward = Vector3.New(var_71_29.x, var_71_29.y, var_71_29.z)

				local var_71_30 = var_71_24.localEulerAngles

				var_71_30.z = 0
				var_71_30.x = 0
				var_71_24.localEulerAngles = var_71_30
			end

			if arg_68_1.time_ >= var_71_25 + var_71_26 and arg_68_1.time_ < var_71_25 + var_71_26 + arg_71_0 then
				var_71_24.localPosition = Vector3.New(0, 100, 0)

				local var_71_31 = manager.ui.mainCamera.transform.position - var_71_24.position

				var_71_24.forward = Vector3.New(var_71_31.x, var_71_31.y, var_71_31.z)

				local var_71_32 = var_71_24.localEulerAngles

				var_71_32.z = 0
				var_71_32.x = 0
				var_71_24.localEulerAngles = var_71_32
			end

			local var_71_33 = arg_68_1.actors_["1019ui_story"].transform
			local var_71_34 = 0

			if var_71_34 < arg_68_1.time_ and arg_68_1.time_ <= var_71_34 + arg_71_0 then
				arg_68_1.var_.moveOldPos1019ui_story = var_71_33.localPosition
			end

			local var_71_35 = 0.001

			if var_71_34 <= arg_68_1.time_ and arg_68_1.time_ < var_71_34 + var_71_35 then
				local var_71_36 = (arg_68_1.time_ - var_71_34) / var_71_35
				local var_71_37 = Vector3.New(-0.2, -1.08, -5.9)

				var_71_33.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1019ui_story, var_71_37, var_71_36)

				local var_71_38 = manager.ui.mainCamera.transform.position - var_71_33.position

				var_71_33.forward = Vector3.New(var_71_38.x, var_71_38.y, var_71_38.z)

				local var_71_39 = var_71_33.localEulerAngles

				var_71_39.z = 0
				var_71_39.x = 0
				var_71_33.localEulerAngles = var_71_39
			end

			if arg_68_1.time_ >= var_71_34 + var_71_35 and arg_68_1.time_ < var_71_34 + var_71_35 + arg_71_0 then
				var_71_33.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_71_40 = manager.ui.mainCamera.transform.position - var_71_33.position

				var_71_33.forward = Vector3.New(var_71_40.x, var_71_40.y, var_71_40.z)

				local var_71_41 = var_71_33.localEulerAngles

				var_71_41.z = 0
				var_71_41.x = 0
				var_71_33.localEulerAngles = var_71_41
			end

			local var_71_42 = 0

			if var_71_42 < arg_68_1.time_ and arg_68_1.time_ <= var_71_42 + arg_71_0 then
				arg_68_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_71_43 = 0

			if var_71_43 < arg_68_1.time_ and arg_68_1.time_ <= var_71_43 + arg_71_0 then
				arg_68_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_71_44 = 0
			local var_71_45 = 0.375

			if var_71_44 < arg_68_1.time_ and arg_68_1.time_ <= var_71_44 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_46 = arg_68_1:FormatText(StoryNameCfg[13].name)

				arg_68_1.leftNameTxt_.text = var_71_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_47 = arg_68_1:GetWordFromCfg(102021017)
				local var_71_48 = arg_68_1:FormatText(var_71_47.content)

				arg_68_1.text_.text = var_71_48

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_49 = 15
				local var_71_50 = utf8.len(var_71_48)
				local var_71_51 = var_71_49 <= 0 and var_71_45 or var_71_45 * (var_71_50 / var_71_49)

				if var_71_51 > 0 and var_71_45 < var_71_51 then
					arg_68_1.talkMaxDuration = var_71_51

					if var_71_51 + var_71_44 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_51 + var_71_44
					end
				end

				arg_68_1.text_.text = var_71_48
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021017", "story_v_out_102021.awb") ~= 0 then
					local var_71_52 = manager.audio:GetVoiceLength("story_v_out_102021", "102021017", "story_v_out_102021.awb") / 1000

					if var_71_52 + var_71_44 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_52 + var_71_44
					end

					if var_71_47.prefab_name ~= "" and arg_68_1.actors_[var_71_47.prefab_name] ~= nil then
						local var_71_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_47.prefab_name].transform, "story_v_out_102021", "102021017", "story_v_out_102021.awb")

						arg_68_1:RecordAudio("102021017", var_71_53)
						arg_68_1:RecordAudio("102021017", var_71_53)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_102021", "102021017", "story_v_out_102021.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_102021", "102021017", "story_v_out_102021.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_54 = math.max(var_71_45, arg_68_1.talkMaxDuration)

			if var_71_44 <= arg_68_1.time_ and arg_68_1.time_ < var_71_44 + var_71_54 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_44) / var_71_54

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_44 + var_71_54 and arg_68_1.time_ < var_71_44 + var_71_54 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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
				actorName = "1019ui_story",
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
	Play102021018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 102021018
		arg_72_1.duration_ = 4.4

		local var_72_0 = {
			ja = 4.4,
			ko = 2.566,
			zh = 3.2,
			en = 2.666
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
				arg_72_0:Play102021019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = "2020_tpose"

			if arg_72_1.actors_[var_75_0] == nil then
				local var_75_1 = Asset.Load("Char/" .. "2020_tpose")

				if not isNil(var_75_1) then
					local var_75_2 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_72_1.stage_.transform)

					var_75_2.name = var_75_0
					var_75_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_72_1.actors_[var_75_0] = var_75_2

					local var_75_3 = var_75_2:GetComponentInChildren(typeof(CharacterEffect))

					var_75_3.enabled = true

					local var_75_4 = GameObjectTools.GetOrAddComponent(var_75_2, typeof(DynamicBoneHelper))

					if var_75_4 then
						var_75_4:EnableDynamicBone(false)
					end

					arg_72_1:ShowWeapon(var_75_3.transform, false)

					arg_72_1.var_[var_75_0 .. "Animator"] = var_75_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_72_1.var_[var_75_0 .. "Animator"].applyRootMotion = true
					arg_72_1.var_[var_75_0 .. "LipSync"] = var_75_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_75_5 = arg_72_1.actors_["2020_tpose"]
			local var_75_6 = 0

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.characterEffect2020_tpose == nil then
				arg_72_1.var_.characterEffect2020_tpose = var_75_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_7 = 0.1

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_7 and not isNil(var_75_5) then
				local var_75_8 = (arg_72_1.time_ - var_75_6) / var_75_7

				if arg_72_1.var_.characterEffect2020_tpose and not isNil(var_75_5) then
					arg_72_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_6 + var_75_7 and arg_72_1.time_ < var_75_6 + var_75_7 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.characterEffect2020_tpose then
				arg_72_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_75_9 = arg_72_1.actors_["1019ui_story"].transform
			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 then
				arg_72_1.var_.moveOldPos1019ui_story = var_75_9.localPosition
			end

			local var_75_11 = 0.001

			if var_75_10 <= arg_72_1.time_ and arg_72_1.time_ < var_75_10 + var_75_11 then
				local var_75_12 = (arg_72_1.time_ - var_75_10) / var_75_11
				local var_75_13 = Vector3.New(0, 100, 0)

				var_75_9.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1019ui_story, var_75_13, var_75_12)

				local var_75_14 = manager.ui.mainCamera.transform.position - var_75_9.position

				var_75_9.forward = Vector3.New(var_75_14.x, var_75_14.y, var_75_14.z)

				local var_75_15 = var_75_9.localEulerAngles

				var_75_15.z = 0
				var_75_15.x = 0
				var_75_9.localEulerAngles = var_75_15
			end

			if arg_72_1.time_ >= var_75_10 + var_75_11 and arg_72_1.time_ < var_75_10 + var_75_11 + arg_75_0 then
				var_75_9.localPosition = Vector3.New(0, 100, 0)

				local var_75_16 = manager.ui.mainCamera.transform.position - var_75_9.position

				var_75_9.forward = Vector3.New(var_75_16.x, var_75_16.y, var_75_16.z)

				local var_75_17 = var_75_9.localEulerAngles

				var_75_17.z = 0
				var_75_17.x = 0
				var_75_9.localEulerAngles = var_75_17
			end

			local var_75_18 = arg_72_1.actors_["2020_tpose"].transform
			local var_75_19 = 0

			if var_75_19 < arg_72_1.time_ and arg_72_1.time_ <= var_75_19 + arg_75_0 then
				arg_72_1.var_.moveOldPos2020_tpose = var_75_18.localPosition

				local var_75_20 = GameObjectTools.GetOrAddComponent(var_75_18.gameObject, typeof(DynamicBoneHelper))

				if var_75_20 then
					var_75_20:EnableDynamicBone(false)
				end
			end

			local var_75_21 = 0.001

			if var_75_19 <= arg_72_1.time_ and arg_72_1.time_ < var_75_19 + var_75_21 then
				local var_75_22 = (arg_72_1.time_ - var_75_19) / var_75_21
				local var_75_23 = Vector3.New(-0.7, -1.2, -4.1)

				var_75_18.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos2020_tpose, var_75_23, var_75_22)

				local var_75_24 = manager.ui.mainCamera.transform.position - var_75_18.position

				var_75_18.forward = Vector3.New(var_75_24.x, var_75_24.y, var_75_24.z)

				local var_75_25 = var_75_18.localEulerAngles

				var_75_25.z = 0
				var_75_25.x = 0
				var_75_18.localEulerAngles = var_75_25
			end

			if arg_72_1.time_ >= var_75_19 + var_75_21 and arg_72_1.time_ < var_75_19 + var_75_21 + arg_75_0 then
				var_75_18.localPosition = Vector3.New(-0.7, -1.2, -4.1)

				local var_75_26 = manager.ui.mainCamera.transform.position - var_75_18.position

				var_75_18.forward = Vector3.New(var_75_26.x, var_75_26.y, var_75_26.z)

				local var_75_27 = var_75_18.localEulerAngles

				var_75_27.z = 0
				var_75_27.x = 0
				var_75_18.localEulerAngles = var_75_27

				local var_75_28 = GameObjectTools.GetOrAddComponent(var_75_18.gameObject, typeof(DynamicBoneHelper))

				if var_75_28 then
					var_75_28:EnableDynamicBone(true)
				end
			end

			local var_75_29 = 0

			if var_75_29 < arg_72_1.time_ and arg_72_1.time_ <= var_75_29 + arg_75_0 then
				arg_72_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_75_30 = 0
			local var_75_31 = 0.35

			if var_75_30 < arg_72_1.time_ and arg_72_1.time_ <= var_75_30 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_32 = arg_72_1:FormatText(StoryNameCfg[19].name)

				arg_72_1.leftNameTxt_.text = var_75_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_33 = arg_72_1:GetWordFromCfg(102021018)
				local var_75_34 = arg_72_1:FormatText(var_75_33.content)

				arg_72_1.text_.text = var_75_34

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_35 = 14
				local var_75_36 = utf8.len(var_75_34)
				local var_75_37 = var_75_35 <= 0 and var_75_31 or var_75_31 * (var_75_36 / var_75_35)

				if var_75_37 > 0 and var_75_31 < var_75_37 then
					arg_72_1.talkMaxDuration = var_75_37

					if var_75_37 + var_75_30 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_37 + var_75_30
					end
				end

				arg_72_1.text_.text = var_75_34
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021018", "story_v_out_102021.awb") ~= 0 then
					local var_75_38 = manager.audio:GetVoiceLength("story_v_out_102021", "102021018", "story_v_out_102021.awb") / 1000

					if var_75_38 + var_75_30 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_38 + var_75_30
					end

					if var_75_33.prefab_name ~= "" and arg_72_1.actors_[var_75_33.prefab_name] ~= nil then
						local var_75_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_33.prefab_name].transform, "story_v_out_102021", "102021018", "story_v_out_102021.awb")

						arg_72_1:RecordAudio("102021018", var_75_39)
						arg_72_1:RecordAudio("102021018", var_75_39)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_102021", "102021018", "story_v_out_102021.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_102021", "102021018", "story_v_out_102021.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_40 = math.max(var_75_31, arg_72_1.talkMaxDuration)

			if var_75_30 <= arg_72_1.time_ and arg_72_1.time_ < var_75_30 + var_75_40 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_30) / var_75_40

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_30 + var_75_40 and arg_72_1.time_ < var_75_30 + var_75_40 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play102021019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 102021019
		arg_76_1.duration_ = 5.07

		local var_76_0 = {
			ja = 5.066,
			ko = 4.066,
			zh = 3.6,
			en = 4.633
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
				arg_76_0:Play102021020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = "2030_tpose"

			if arg_76_1.actors_[var_79_0] == nil then
				local var_79_1 = Asset.Load("Char/" .. "2030_tpose")

				if not isNil(var_79_1) then
					local var_79_2 = Object.Instantiate(Asset.Load("Char/" .. "2030_tpose"), arg_76_1.stage_.transform)

					var_79_2.name = var_79_0
					var_79_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_76_1.actors_[var_79_0] = var_79_2

					local var_79_3 = var_79_2:GetComponentInChildren(typeof(CharacterEffect))

					var_79_3.enabled = true

					local var_79_4 = GameObjectTools.GetOrAddComponent(var_79_2, typeof(DynamicBoneHelper))

					if var_79_4 then
						var_79_4:EnableDynamicBone(false)
					end

					arg_76_1:ShowWeapon(var_79_3.transform, false)

					arg_76_1.var_[var_79_0 .. "Animator"] = var_79_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_76_1.var_[var_79_0 .. "Animator"].applyRootMotion = true
					arg_76_1.var_[var_79_0 .. "LipSync"] = var_79_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_79_5 = arg_76_1.actors_["2030_tpose"]
			local var_79_6 = 0

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 and not isNil(var_79_5) and arg_76_1.var_.characterEffect2030_tpose == nil then
				arg_76_1.var_.characterEffect2030_tpose = var_79_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_7 = 0.1

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_7 and not isNil(var_79_5) then
				local var_79_8 = (arg_76_1.time_ - var_79_6) / var_79_7

				if arg_76_1.var_.characterEffect2030_tpose and not isNil(var_79_5) then
					arg_76_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_6 + var_79_7 and arg_76_1.time_ < var_79_6 + var_79_7 + arg_79_0 and not isNil(var_79_5) and arg_76_1.var_.characterEffect2030_tpose then
				arg_76_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_79_9 = arg_76_1.actors_["2020_tpose"]
			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect2020_tpose == nil then
				arg_76_1.var_.characterEffect2020_tpose = var_79_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_11 = 0.1

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_11 and not isNil(var_79_9) then
				local var_79_12 = (arg_76_1.time_ - var_79_10) / var_79_11

				if arg_76_1.var_.characterEffect2020_tpose and not isNil(var_79_9) then
					local var_79_13 = Mathf.Lerp(0, 0.5, var_79_12)

					arg_76_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_76_1.var_.characterEffect2020_tpose.fillRatio = var_79_13
				end
			end

			if arg_76_1.time_ >= var_79_10 + var_79_11 and arg_76_1.time_ < var_79_10 + var_79_11 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect2020_tpose then
				local var_79_14 = 0.5

				arg_76_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_76_1.var_.characterEffect2020_tpose.fillRatio = var_79_14
			end

			local var_79_15 = arg_76_1.actors_["2030_tpose"].transform
			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 then
				arg_76_1.var_.moveOldPos2030_tpose = var_79_15.localPosition

				local var_79_17 = GameObjectTools.GetOrAddComponent(var_79_15.gameObject, typeof(DynamicBoneHelper))

				if var_79_17 then
					var_79_17:EnableDynamicBone(false)
				end
			end

			local var_79_18 = 0.001

			if var_79_16 <= arg_76_1.time_ and arg_76_1.time_ < var_79_16 + var_79_18 then
				local var_79_19 = (arg_76_1.time_ - var_79_16) / var_79_18
				local var_79_20 = Vector3.New(0.7, -1.2, -4.2)

				var_79_15.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos2030_tpose, var_79_20, var_79_19)

				local var_79_21 = manager.ui.mainCamera.transform.position - var_79_15.position

				var_79_15.forward = Vector3.New(var_79_21.x, var_79_21.y, var_79_21.z)

				local var_79_22 = var_79_15.localEulerAngles

				var_79_22.z = 0
				var_79_22.x = 0
				var_79_15.localEulerAngles = var_79_22
			end

			if arg_76_1.time_ >= var_79_16 + var_79_18 and arg_76_1.time_ < var_79_16 + var_79_18 + arg_79_0 then
				var_79_15.localPosition = Vector3.New(0.7, -1.2, -4.2)

				local var_79_23 = manager.ui.mainCamera.transform.position - var_79_15.position

				var_79_15.forward = Vector3.New(var_79_23.x, var_79_23.y, var_79_23.z)

				local var_79_24 = var_79_15.localEulerAngles

				var_79_24.z = 0
				var_79_24.x = 0
				var_79_15.localEulerAngles = var_79_24

				local var_79_25 = GameObjectTools.GetOrAddComponent(var_79_15.gameObject, typeof(DynamicBoneHelper))

				if var_79_25 then
					var_79_25:EnableDynamicBone(true)
				end
			end

			local var_79_26 = 0

			if var_79_26 < arg_76_1.time_ and arg_76_1.time_ <= var_79_26 + arg_79_0 then
				arg_76_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_79_27 = 0
			local var_79_28 = 0.425

			if var_79_27 < arg_76_1.time_ and arg_76_1.time_ <= var_79_27 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_29 = arg_76_1:FormatText(StoryNameCfg[33].name)

				arg_76_1.leftNameTxt_.text = var_79_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_30 = arg_76_1:GetWordFromCfg(102021019)
				local var_79_31 = arg_76_1:FormatText(var_79_30.content)

				arg_76_1.text_.text = var_79_31

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_32 = 17
				local var_79_33 = utf8.len(var_79_31)
				local var_79_34 = var_79_32 <= 0 and var_79_28 or var_79_28 * (var_79_33 / var_79_32)

				if var_79_34 > 0 and var_79_28 < var_79_34 then
					arg_76_1.talkMaxDuration = var_79_34

					if var_79_34 + var_79_27 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_34 + var_79_27
					end
				end

				arg_76_1.text_.text = var_79_31
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021019", "story_v_out_102021.awb") ~= 0 then
					local var_79_35 = manager.audio:GetVoiceLength("story_v_out_102021", "102021019", "story_v_out_102021.awb") / 1000

					if var_79_35 + var_79_27 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_35 + var_79_27
					end

					if var_79_30.prefab_name ~= "" and arg_76_1.actors_[var_79_30.prefab_name] ~= nil then
						local var_79_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_30.prefab_name].transform, "story_v_out_102021", "102021019", "story_v_out_102021.awb")

						arg_76_1:RecordAudio("102021019", var_79_36)
						arg_76_1:RecordAudio("102021019", var_79_36)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_102021", "102021019", "story_v_out_102021.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_102021", "102021019", "story_v_out_102021.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_37 = math.max(var_79_28, arg_76_1.talkMaxDuration)

			if var_79_27 <= arg_76_1.time_ and arg_76_1.time_ < var_79_27 + var_79_37 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_27) / var_79_37

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_27 + var_79_37 and arg_76_1.time_ < var_79_27 + var_79_37 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play102021020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 102021020
		arg_80_1.duration_ = 4.97

		local var_80_0 = {
			ja = 4.966,
			ko = 2.1,
			zh = 3.733,
			en = 3.8
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
				arg_80_0:Play102021021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["2030_tpose"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect2030_tpose == nil then
				arg_80_1.var_.characterEffect2030_tpose = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect2030_tpose and not isNil(var_83_0) then
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_80_1.var_.characterEffect2030_tpose.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect2030_tpose then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_80_1.var_.characterEffect2030_tpose.fillRatio = var_83_5
			end

			local var_83_6 = 0
			local var_83_7 = 0.3

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_8 = arg_80_1:FormatText(StoryNameCfg[33].name)

				arg_80_1.leftNameTxt_.text = var_83_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_9 = arg_80_1:GetWordFromCfg(102021020)
				local var_83_10 = arg_80_1:FormatText(var_83_9.content)

				arg_80_1.text_.text = var_83_10

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 12
				local var_83_12 = utf8.len(var_83_10)
				local var_83_13 = var_83_11 <= 0 and var_83_7 or var_83_7 * (var_83_12 / var_83_11)

				if var_83_13 > 0 and var_83_7 < var_83_13 then
					arg_80_1.talkMaxDuration = var_83_13

					if var_83_13 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_13 + var_83_6
					end
				end

				arg_80_1.text_.text = var_83_10
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021020", "story_v_out_102021.awb") ~= 0 then
					local var_83_14 = manager.audio:GetVoiceLength("story_v_out_102021", "102021020", "story_v_out_102021.awb") / 1000

					if var_83_14 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_14 + var_83_6
					end

					if var_83_9.prefab_name ~= "" and arg_80_1.actors_[var_83_9.prefab_name] ~= nil then
						local var_83_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_9.prefab_name].transform, "story_v_out_102021", "102021020", "story_v_out_102021.awb")

						arg_80_1:RecordAudio("102021020", var_83_15)
						arg_80_1:RecordAudio("102021020", var_83_15)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_102021", "102021020", "story_v_out_102021.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_102021", "102021020", "story_v_out_102021.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_16 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_16 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_6) / var_83_16

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_6 + var_83_16 and arg_80_1.time_ < var_83_6 + var_83_16 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play102021021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 102021021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play102021022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["2030_tpose"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect2030_tpose == nil then
				arg_84_1.var_.characterEffect2030_tpose = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect2030_tpose and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_84_1.var_.characterEffect2030_tpose.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect2030_tpose then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_84_1.var_.characterEffect2030_tpose.fillRatio = var_87_5
			end

			local var_87_6 = arg_84_1.actors_["2030_tpose"].transform
			local var_87_7 = 0

			if var_87_7 < arg_84_1.time_ and arg_84_1.time_ <= var_87_7 + arg_87_0 then
				arg_84_1.var_.moveOldPos2030_tpose = var_87_6.localPosition

				local var_87_8 = GameObjectTools.GetOrAddComponent(var_87_6.gameObject, typeof(DynamicBoneHelper))

				if var_87_8 then
					var_87_8:EnableDynamicBone(false)
				end
			end

			local var_87_9 = 0.001

			if var_87_7 <= arg_84_1.time_ and arg_84_1.time_ < var_87_7 + var_87_9 then
				local var_87_10 = (arg_84_1.time_ - var_87_7) / var_87_9
				local var_87_11 = Vector3.New(0, 100, 0)

				var_87_6.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos2030_tpose, var_87_11, var_87_10)

				local var_87_12 = manager.ui.mainCamera.transform.position - var_87_6.position

				var_87_6.forward = Vector3.New(var_87_12.x, var_87_12.y, var_87_12.z)

				local var_87_13 = var_87_6.localEulerAngles

				var_87_13.z = 0
				var_87_13.x = 0
				var_87_6.localEulerAngles = var_87_13
			end

			if arg_84_1.time_ >= var_87_7 + var_87_9 and arg_84_1.time_ < var_87_7 + var_87_9 + arg_87_0 then
				var_87_6.localPosition = Vector3.New(0, 100, 0)

				local var_87_14 = manager.ui.mainCamera.transform.position - var_87_6.position

				var_87_6.forward = Vector3.New(var_87_14.x, var_87_14.y, var_87_14.z)

				local var_87_15 = var_87_6.localEulerAngles

				var_87_15.z = 0
				var_87_15.x = 0
				var_87_6.localEulerAngles = var_87_15

				local var_87_16 = GameObjectTools.GetOrAddComponent(var_87_6.gameObject, typeof(DynamicBoneHelper))

				if var_87_16 then
					var_87_16:EnableDynamicBone(true)
				end
			end

			local var_87_17 = arg_84_1.actors_["2020_tpose"].transform
			local var_87_18 = 0

			if var_87_18 < arg_84_1.time_ and arg_84_1.time_ <= var_87_18 + arg_87_0 then
				arg_84_1.var_.moveOldPos2020_tpose = var_87_17.localPosition

				local var_87_19 = GameObjectTools.GetOrAddComponent(var_87_17.gameObject, typeof(DynamicBoneHelper))

				if var_87_19 then
					var_87_19:EnableDynamicBone(false)
				end
			end

			local var_87_20 = 0.001

			if var_87_18 <= arg_84_1.time_ and arg_84_1.time_ < var_87_18 + var_87_20 then
				local var_87_21 = (arg_84_1.time_ - var_87_18) / var_87_20
				local var_87_22 = Vector3.New(0, 100, 0)

				var_87_17.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos2020_tpose, var_87_22, var_87_21)

				local var_87_23 = manager.ui.mainCamera.transform.position - var_87_17.position

				var_87_17.forward = Vector3.New(var_87_23.x, var_87_23.y, var_87_23.z)

				local var_87_24 = var_87_17.localEulerAngles

				var_87_24.z = 0
				var_87_24.x = 0
				var_87_17.localEulerAngles = var_87_24
			end

			if arg_84_1.time_ >= var_87_18 + var_87_20 and arg_84_1.time_ < var_87_18 + var_87_20 + arg_87_0 then
				var_87_17.localPosition = Vector3.New(0, 100, 0)

				local var_87_25 = manager.ui.mainCamera.transform.position - var_87_17.position

				var_87_17.forward = Vector3.New(var_87_25.x, var_87_25.y, var_87_25.z)

				local var_87_26 = var_87_17.localEulerAngles

				var_87_26.z = 0
				var_87_26.x = 0
				var_87_17.localEulerAngles = var_87_26

				local var_87_27 = GameObjectTools.GetOrAddComponent(var_87_17.gameObject, typeof(DynamicBoneHelper))

				if var_87_27 then
					var_87_27:EnableDynamicBone(true)
				end
			end

			local var_87_28 = 0
			local var_87_29 = 0.7

			if var_87_28 < arg_84_1.time_ and arg_84_1.time_ <= var_87_28 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_30 = arg_84_1:GetWordFromCfg(102021021)
				local var_87_31 = arg_84_1:FormatText(var_87_30.content)

				arg_84_1.text_.text = var_87_31

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_32 = 28
				local var_87_33 = utf8.len(var_87_31)
				local var_87_34 = var_87_32 <= 0 and var_87_29 or var_87_29 * (var_87_33 / var_87_32)

				if var_87_34 > 0 and var_87_29 < var_87_34 then
					arg_84_1.talkMaxDuration = var_87_34

					if var_87_34 + var_87_28 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_34 + var_87_28
					end
				end

				arg_84_1.text_.text = var_87_31
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_35 = math.max(var_87_29, arg_84_1.talkMaxDuration)

			if var_87_28 <= arg_84_1.time_ and arg_84_1.time_ < var_87_28 + var_87_35 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_28) / var_87_35

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_28 + var_87_35 and arg_84_1.time_ < var_87_28 + var_87_35 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
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

		arg_84_1:InitPlayNodeList()
	end,
	Play102021022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 102021022
		arg_88_1.duration_ = 3.33

		local var_88_0 = {
			ja = 2.833,
			ko = 3.033,
			zh = 2.933,
			en = 3.333
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
				arg_88_0:Play102021023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1019ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1019ui_story == nil then
				arg_88_1.var_.characterEffect1019ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1019ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1019ui_story then
				arg_88_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_91_4 = 0

			if var_91_4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_91_5 = arg_88_1.actors_["1019ui_story"].transform
			local var_91_6 = 0

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.var_.moveOldPos1019ui_story = var_91_5.localPosition
			end

			local var_91_7 = 0.001

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_7 then
				local var_91_8 = (arg_88_1.time_ - var_91_6) / var_91_7
				local var_91_9 = Vector3.New(-0.7, -1.08, -5.9)

				var_91_5.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1019ui_story, var_91_9, var_91_8)

				local var_91_10 = manager.ui.mainCamera.transform.position - var_91_5.position

				var_91_5.forward = Vector3.New(var_91_10.x, var_91_10.y, var_91_10.z)

				local var_91_11 = var_91_5.localEulerAngles

				var_91_11.z = 0
				var_91_11.x = 0
				var_91_5.localEulerAngles = var_91_11
			end

			if arg_88_1.time_ >= var_91_6 + var_91_7 and arg_88_1.time_ < var_91_6 + var_91_7 + arg_91_0 then
				var_91_5.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_91_12 = manager.ui.mainCamera.transform.position - var_91_5.position

				var_91_5.forward = Vector3.New(var_91_12.x, var_91_12.y, var_91_12.z)

				local var_91_13 = var_91_5.localEulerAngles

				var_91_13.z = 0
				var_91_13.x = 0
				var_91_5.localEulerAngles = var_91_13
			end

			local var_91_14 = 0

			if var_91_14 < arg_88_1.time_ and arg_88_1.time_ <= var_91_14 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_91_15 = 0
			local var_91_16 = 0.325

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_17 = arg_88_1:FormatText(StoryNameCfg[13].name)

				arg_88_1.leftNameTxt_.text = var_91_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_18 = arg_88_1:GetWordFromCfg(102021022)
				local var_91_19 = arg_88_1:FormatText(var_91_18.content)

				arg_88_1.text_.text = var_91_19

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_20 = 12
				local var_91_21 = utf8.len(var_91_19)
				local var_91_22 = var_91_20 <= 0 and var_91_16 or var_91_16 * (var_91_21 / var_91_20)

				if var_91_22 > 0 and var_91_16 < var_91_22 then
					arg_88_1.talkMaxDuration = var_91_22

					if var_91_22 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_22 + var_91_15
					end
				end

				arg_88_1.text_.text = var_91_19
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021022", "story_v_out_102021.awb") ~= 0 then
					local var_91_23 = manager.audio:GetVoiceLength("story_v_out_102021", "102021022", "story_v_out_102021.awb") / 1000

					if var_91_23 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_23 + var_91_15
					end

					if var_91_18.prefab_name ~= "" and arg_88_1.actors_[var_91_18.prefab_name] ~= nil then
						local var_91_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_18.prefab_name].transform, "story_v_out_102021", "102021022", "story_v_out_102021.awb")

						arg_88_1:RecordAudio("102021022", var_91_24)
						arg_88_1:RecordAudio("102021022", var_91_24)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_102021", "102021022", "story_v_out_102021.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_102021", "102021022", "story_v_out_102021.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_25 = math.max(var_91_16, arg_88_1.talkMaxDuration)

			if var_91_15 <= arg_88_1.time_ and arg_88_1.time_ < var_91_15 + var_91_25 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_15) / var_91_25

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_15 + var_91_25 and arg_88_1.time_ < var_91_15 + var_91_25 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	Play102021023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 102021023
		arg_92_1.duration_ = 5.2

		local var_92_0 = {
			ja = 5.2,
			ko = 3.4,
			zh = 4,
			en = 4.666
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
				arg_92_0:Play102021024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["2030_tpose"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect2030_tpose == nil then
				arg_92_1.var_.characterEffect2030_tpose = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.1

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect2030_tpose and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect2030_tpose then
				arg_92_1.var_.characterEffect2030_tpose.fillFlat = false
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

			local var_95_10 = arg_92_1.actors_["2030_tpose"].transform
			local var_95_11 = 0

			if var_95_11 < arg_92_1.time_ and arg_92_1.time_ <= var_95_11 + arg_95_0 then
				arg_92_1.var_.moveOldPos2030_tpose = var_95_10.localPosition

				local var_95_12 = GameObjectTools.GetOrAddComponent(var_95_10.gameObject, typeof(DynamicBoneHelper))

				if var_95_12 then
					var_95_12:EnableDynamicBone(false)
				end
			end

			local var_95_13 = 0.001

			if var_95_11 <= arg_92_1.time_ and arg_92_1.time_ < var_95_11 + var_95_13 then
				local var_95_14 = (arg_92_1.time_ - var_95_11) / var_95_13
				local var_95_15 = Vector3.New(0.7, -1.2, -4.2)

				var_95_10.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos2030_tpose, var_95_15, var_95_14)

				local var_95_16 = manager.ui.mainCamera.transform.position - var_95_10.position

				var_95_10.forward = Vector3.New(var_95_16.x, var_95_16.y, var_95_16.z)

				local var_95_17 = var_95_10.localEulerAngles

				var_95_17.z = 0
				var_95_17.x = 0
				var_95_10.localEulerAngles = var_95_17
			end

			if arg_92_1.time_ >= var_95_11 + var_95_13 and arg_92_1.time_ < var_95_11 + var_95_13 + arg_95_0 then
				var_95_10.localPosition = Vector3.New(0.7, -1.2, -4.2)

				local var_95_18 = manager.ui.mainCamera.transform.position - var_95_10.position

				var_95_10.forward = Vector3.New(var_95_18.x, var_95_18.y, var_95_18.z)

				local var_95_19 = var_95_10.localEulerAngles

				var_95_19.z = 0
				var_95_19.x = 0
				var_95_10.localEulerAngles = var_95_19

				local var_95_20 = GameObjectTools.GetOrAddComponent(var_95_10.gameObject, typeof(DynamicBoneHelper))

				if var_95_20 then
					var_95_20:EnableDynamicBone(true)
				end
			end

			local var_95_21 = 0

			if var_95_21 < arg_92_1.time_ and arg_92_1.time_ <= var_95_21 + arg_95_0 then
				arg_92_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_95_22 = 0
			local var_95_23 = 0.475

			if var_95_22 < arg_92_1.time_ and arg_92_1.time_ <= var_95_22 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_24 = arg_92_1:FormatText(StoryNameCfg[33].name)

				arg_92_1.leftNameTxt_.text = var_95_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_25 = arg_92_1:GetWordFromCfg(102021023)
				local var_95_26 = arg_92_1:FormatText(var_95_25.content)

				arg_92_1.text_.text = var_95_26

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_27 = 19
				local var_95_28 = utf8.len(var_95_26)
				local var_95_29 = var_95_27 <= 0 and var_95_23 or var_95_23 * (var_95_28 / var_95_27)

				if var_95_29 > 0 and var_95_23 < var_95_29 then
					arg_92_1.talkMaxDuration = var_95_29

					if var_95_29 + var_95_22 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_29 + var_95_22
					end
				end

				arg_92_1.text_.text = var_95_26
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021023", "story_v_out_102021.awb") ~= 0 then
					local var_95_30 = manager.audio:GetVoiceLength("story_v_out_102021", "102021023", "story_v_out_102021.awb") / 1000

					if var_95_30 + var_95_22 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_30 + var_95_22
					end

					if var_95_25.prefab_name ~= "" and arg_92_1.actors_[var_95_25.prefab_name] ~= nil then
						local var_95_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_25.prefab_name].transform, "story_v_out_102021", "102021023", "story_v_out_102021.awb")

						arg_92_1:RecordAudio("102021023", var_95_31)
						arg_92_1:RecordAudio("102021023", var_95_31)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_102021", "102021023", "story_v_out_102021.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_102021", "102021023", "story_v_out_102021.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_32 = math.max(var_95_23, arg_92_1.talkMaxDuration)

			if var_95_22 <= arg_92_1.time_ and arg_92_1.time_ < var_95_22 + var_95_32 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_22) / var_95_32

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_22 + var_95_32 and arg_92_1.time_ < var_95_22 + var_95_32 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play102021024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 102021024
		arg_96_1.duration_ = 8.4

		local var_96_0 = {
			ja = 8.4,
			ko = 5.8,
			zh = 4.966,
			en = 5.233
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
				arg_96_0:Play102021025(arg_96_1)
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

			local var_99_4 = arg_96_1.actors_["2030_tpose"]
			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect2030_tpose == nil then
				arg_96_1.var_.characterEffect2030_tpose = var_99_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.1

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 and not isNil(var_99_4) then
				local var_99_7 = (arg_96_1.time_ - var_99_5) / var_99_6

				if arg_96_1.var_.characterEffect2030_tpose and not isNil(var_99_4) then
					local var_99_8 = Mathf.Lerp(0, 0.5, var_99_7)

					arg_96_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_96_1.var_.characterEffect2030_tpose.fillRatio = var_99_8
				end
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect2030_tpose then
				local var_99_9 = 0.5

				arg_96_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_96_1.var_.characterEffect2030_tpose.fillRatio = var_99_9
			end

			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_99_11 = 0
			local var_99_12 = 0.575

			if var_99_11 < arg_96_1.time_ and arg_96_1.time_ <= var_99_11 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_13 = arg_96_1:FormatText(StoryNameCfg[13].name)

				arg_96_1.leftNameTxt_.text = var_99_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_14 = arg_96_1:GetWordFromCfg(102021024)
				local var_99_15 = arg_96_1:FormatText(var_99_14.content)

				arg_96_1.text_.text = var_99_15

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_16 = 23
				local var_99_17 = utf8.len(var_99_15)
				local var_99_18 = var_99_16 <= 0 and var_99_12 or var_99_12 * (var_99_17 / var_99_16)

				if var_99_18 > 0 and var_99_12 < var_99_18 then
					arg_96_1.talkMaxDuration = var_99_18

					if var_99_18 + var_99_11 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_18 + var_99_11
					end
				end

				arg_96_1.text_.text = var_99_15
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021024", "story_v_out_102021.awb") ~= 0 then
					local var_99_19 = manager.audio:GetVoiceLength("story_v_out_102021", "102021024", "story_v_out_102021.awb") / 1000

					if var_99_19 + var_99_11 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_19 + var_99_11
					end

					if var_99_14.prefab_name ~= "" and arg_96_1.actors_[var_99_14.prefab_name] ~= nil then
						local var_99_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_14.prefab_name].transform, "story_v_out_102021", "102021024", "story_v_out_102021.awb")

						arg_96_1:RecordAudio("102021024", var_99_20)
						arg_96_1:RecordAudio("102021024", var_99_20)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_102021", "102021024", "story_v_out_102021.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_102021", "102021024", "story_v_out_102021.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_21 = math.max(var_99_12, arg_96_1.talkMaxDuration)

			if var_99_11 <= arg_96_1.time_ and arg_96_1.time_ < var_99_11 + var_99_21 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_11) / var_99_21

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_11 + var_99_21 and arg_96_1.time_ < var_99_11 + var_99_21 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play102021025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 102021025
		arg_100_1.duration_ = 3.17

		local var_100_0 = {
			ja = 3.166,
			ko = 2.466,
			zh = 3.133,
			en = 2.4
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
				arg_100_0:Play102021026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["2030_tpose"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect2030_tpose == nil then
				arg_100_1.var_.characterEffect2030_tpose = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.1

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect2030_tpose and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect2030_tpose then
				arg_100_1.var_.characterEffect2030_tpose.fillFlat = false
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
			local var_103_11 = 0.175

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_12 = arg_100_1:FormatText(StoryNameCfg[33].name)

				arg_100_1.leftNameTxt_.text = var_103_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_13 = arg_100_1:GetWordFromCfg(102021025)
				local var_103_14 = arg_100_1:FormatText(var_103_13.content)

				arg_100_1.text_.text = var_103_14

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_15 = 7
				local var_103_16 = utf8.len(var_103_14)
				local var_103_17 = var_103_15 <= 0 and var_103_11 or var_103_11 * (var_103_16 / var_103_15)

				if var_103_17 > 0 and var_103_11 < var_103_17 then
					arg_100_1.talkMaxDuration = var_103_17

					if var_103_17 + var_103_10 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_17 + var_103_10
					end
				end

				arg_100_1.text_.text = var_103_14
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021025", "story_v_out_102021.awb") ~= 0 then
					local var_103_18 = manager.audio:GetVoiceLength("story_v_out_102021", "102021025", "story_v_out_102021.awb") / 1000

					if var_103_18 + var_103_10 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_18 + var_103_10
					end

					if var_103_13.prefab_name ~= "" and arg_100_1.actors_[var_103_13.prefab_name] ~= nil then
						local var_103_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_13.prefab_name].transform, "story_v_out_102021", "102021025", "story_v_out_102021.awb")

						arg_100_1:RecordAudio("102021025", var_103_19)
						arg_100_1:RecordAudio("102021025", var_103_19)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_102021", "102021025", "story_v_out_102021.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_102021", "102021025", "story_v_out_102021.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_20 = math.max(var_103_11, arg_100_1.talkMaxDuration)

			if var_103_10 <= arg_100_1.time_ and arg_100_1.time_ < var_103_10 + var_103_20 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_10) / var_103_20

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_10 + var_103_20 and arg_100_1.time_ < var_103_10 + var_103_20 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play102021026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 102021026
		arg_104_1.duration_ = 6.8

		local var_104_0 = {
			ja = 6.8,
			ko = 4.033,
			zh = 3.666,
			en = 4.3
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
				arg_104_0:Play102021027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = "3008ui_story"

			if arg_104_1.actors_[var_107_0] == nil then
				local var_107_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_107_1) then
					local var_107_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_104_1.stage_.transform)

					var_107_2.name = var_107_0
					var_107_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_104_1.actors_[var_107_0] = var_107_2

					local var_107_3 = var_107_2:GetComponentInChildren(typeof(CharacterEffect))

					var_107_3.enabled = true

					local var_107_4 = GameObjectTools.GetOrAddComponent(var_107_2, typeof(DynamicBoneHelper))

					if var_107_4 then
						var_107_4:EnableDynamicBone(false)
					end

					arg_104_1:ShowWeapon(var_107_3.transform, false)

					arg_104_1.var_[var_107_0 .. "Animator"] = var_107_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_104_1.var_[var_107_0 .. "Animator"].applyRootMotion = true
					arg_104_1.var_[var_107_0 .. "LipSync"] = var_107_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_107_5 = arg_104_1.actors_["3008ui_story"]
			local var_107_6 = 0

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 and not isNil(var_107_5) and arg_104_1.var_.characterEffect3008ui_story == nil then
				arg_104_1.var_.characterEffect3008ui_story = var_107_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_7 = 0.1

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_7 and not isNil(var_107_5) then
				local var_107_8 = (arg_104_1.time_ - var_107_6) / var_107_7

				if arg_104_1.var_.characterEffect3008ui_story and not isNil(var_107_5) then
					arg_104_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_6 + var_107_7 and arg_104_1.time_ < var_107_6 + var_107_7 + arg_107_0 and not isNil(var_107_5) and arg_104_1.var_.characterEffect3008ui_story then
				arg_104_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_107_9 = arg_104_1.actors_["2030_tpose"]
			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect2030_tpose == nil then
				arg_104_1.var_.characterEffect2030_tpose = var_107_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_11 = 0.1

			if var_107_10 <= arg_104_1.time_ and arg_104_1.time_ < var_107_10 + var_107_11 and not isNil(var_107_9) then
				local var_107_12 = (arg_104_1.time_ - var_107_10) / var_107_11

				if arg_104_1.var_.characterEffect2030_tpose and not isNil(var_107_9) then
					local var_107_13 = Mathf.Lerp(0, 0.5, var_107_12)

					arg_104_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_104_1.var_.characterEffect2030_tpose.fillRatio = var_107_13
				end
			end

			if arg_104_1.time_ >= var_107_10 + var_107_11 and arg_104_1.time_ < var_107_10 + var_107_11 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect2030_tpose then
				local var_107_14 = 0.5

				arg_104_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_104_1.var_.characterEffect2030_tpose.fillRatio = var_107_14
			end

			local var_107_15 = arg_104_1.actors_["1019ui_story"].transform
			local var_107_16 = 0

			if var_107_16 < arg_104_1.time_ and arg_104_1.time_ <= var_107_16 + arg_107_0 then
				arg_104_1.var_.moveOldPos1019ui_story = var_107_15.localPosition
			end

			local var_107_17 = 0.001

			if var_107_16 <= arg_104_1.time_ and arg_104_1.time_ < var_107_16 + var_107_17 then
				local var_107_18 = (arg_104_1.time_ - var_107_16) / var_107_17
				local var_107_19 = Vector3.New(0, 100, 0)

				var_107_15.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1019ui_story, var_107_19, var_107_18)

				local var_107_20 = manager.ui.mainCamera.transform.position - var_107_15.position

				var_107_15.forward = Vector3.New(var_107_20.x, var_107_20.y, var_107_20.z)

				local var_107_21 = var_107_15.localEulerAngles

				var_107_21.z = 0
				var_107_21.x = 0
				var_107_15.localEulerAngles = var_107_21
			end

			if arg_104_1.time_ >= var_107_16 + var_107_17 and arg_104_1.time_ < var_107_16 + var_107_17 + arg_107_0 then
				var_107_15.localPosition = Vector3.New(0, 100, 0)

				local var_107_22 = manager.ui.mainCamera.transform.position - var_107_15.position

				var_107_15.forward = Vector3.New(var_107_22.x, var_107_22.y, var_107_22.z)

				local var_107_23 = var_107_15.localEulerAngles

				var_107_23.z = 0
				var_107_23.x = 0
				var_107_15.localEulerAngles = var_107_23
			end

			local var_107_24 = arg_104_1.actors_["2030_tpose"].transform
			local var_107_25 = 0

			if var_107_25 < arg_104_1.time_ and arg_104_1.time_ <= var_107_25 + arg_107_0 then
				arg_104_1.var_.moveOldPos2030_tpose = var_107_24.localPosition

				local var_107_26 = GameObjectTools.GetOrAddComponent(var_107_24.gameObject, typeof(DynamicBoneHelper))

				if var_107_26 then
					var_107_26:EnableDynamicBone(false)
				end
			end

			local var_107_27 = 0.001

			if var_107_25 <= arg_104_1.time_ and arg_104_1.time_ < var_107_25 + var_107_27 then
				local var_107_28 = (arg_104_1.time_ - var_107_25) / var_107_27
				local var_107_29 = Vector3.New(0, 100, 0)

				var_107_24.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos2030_tpose, var_107_29, var_107_28)

				local var_107_30 = manager.ui.mainCamera.transform.position - var_107_24.position

				var_107_24.forward = Vector3.New(var_107_30.x, var_107_30.y, var_107_30.z)

				local var_107_31 = var_107_24.localEulerAngles

				var_107_31.z = 0
				var_107_31.x = 0
				var_107_24.localEulerAngles = var_107_31
			end

			if arg_104_1.time_ >= var_107_25 + var_107_27 and arg_104_1.time_ < var_107_25 + var_107_27 + arg_107_0 then
				var_107_24.localPosition = Vector3.New(0, 100, 0)

				local var_107_32 = manager.ui.mainCamera.transform.position - var_107_24.position

				var_107_24.forward = Vector3.New(var_107_32.x, var_107_32.y, var_107_32.z)

				local var_107_33 = var_107_24.localEulerAngles

				var_107_33.z = 0
				var_107_33.x = 0
				var_107_24.localEulerAngles = var_107_33

				local var_107_34 = GameObjectTools.GetOrAddComponent(var_107_24.gameObject, typeof(DynamicBoneHelper))

				if var_107_34 then
					var_107_34:EnableDynamicBone(true)
				end
			end

			local var_107_35 = arg_104_1.actors_["3008ui_story"].transform
			local var_107_36 = 0

			if var_107_36 < arg_104_1.time_ and arg_104_1.time_ <= var_107_36 + arg_107_0 then
				arg_104_1.var_.moveOldPos3008ui_story = var_107_35.localPosition
			end

			local var_107_37 = 0.001

			if var_107_36 <= arg_104_1.time_ and arg_104_1.time_ < var_107_36 + var_107_37 then
				local var_107_38 = (arg_104_1.time_ - var_107_36) / var_107_37
				local var_107_39 = Vector3.New(0, -1.51, -4.3)

				var_107_35.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos3008ui_story, var_107_39, var_107_38)

				local var_107_40 = manager.ui.mainCamera.transform.position - var_107_35.position

				var_107_35.forward = Vector3.New(var_107_40.x, var_107_40.y, var_107_40.z)

				local var_107_41 = var_107_35.localEulerAngles

				var_107_41.z = 0
				var_107_41.x = 0
				var_107_35.localEulerAngles = var_107_41
			end

			if arg_104_1.time_ >= var_107_36 + var_107_37 and arg_104_1.time_ < var_107_36 + var_107_37 + arg_107_0 then
				var_107_35.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_107_42 = manager.ui.mainCamera.transform.position - var_107_35.position

				var_107_35.forward = Vector3.New(var_107_42.x, var_107_42.y, var_107_42.z)

				local var_107_43 = var_107_35.localEulerAngles

				var_107_43.z = 0
				var_107_43.x = 0
				var_107_35.localEulerAngles = var_107_43
			end

			local var_107_44 = 0

			if var_107_44 < arg_104_1.time_ and arg_104_1.time_ <= var_107_44 + arg_107_0 then
				arg_104_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			local var_107_45 = 0

			if var_107_45 < arg_104_1.time_ and arg_104_1.time_ <= var_107_45 + arg_107_0 then
				arg_104_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_107_46 = 0
			local var_107_47 = 0.35

			if var_107_46 < arg_104_1.time_ and arg_104_1.time_ <= var_107_46 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_48 = arg_104_1:FormatText(StoryNameCfg[20].name)

				arg_104_1.leftNameTxt_.text = var_107_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_49 = arg_104_1:GetWordFromCfg(102021026)
				local var_107_50 = arg_104_1:FormatText(var_107_49.content)

				arg_104_1.text_.text = var_107_50

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_51 = 14
				local var_107_52 = utf8.len(var_107_50)
				local var_107_53 = var_107_51 <= 0 and var_107_47 or var_107_47 * (var_107_52 / var_107_51)

				if var_107_53 > 0 and var_107_47 < var_107_53 then
					arg_104_1.talkMaxDuration = var_107_53

					if var_107_53 + var_107_46 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_53 + var_107_46
					end
				end

				arg_104_1.text_.text = var_107_50
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021026", "story_v_out_102021.awb") ~= 0 then
					local var_107_54 = manager.audio:GetVoiceLength("story_v_out_102021", "102021026", "story_v_out_102021.awb") / 1000

					if var_107_54 + var_107_46 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_54 + var_107_46
					end

					if var_107_49.prefab_name ~= "" and arg_104_1.actors_[var_107_49.prefab_name] ~= nil then
						local var_107_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_49.prefab_name].transform, "story_v_out_102021", "102021026", "story_v_out_102021.awb")

						arg_104_1:RecordAudio("102021026", var_107_55)
						arg_104_1:RecordAudio("102021026", var_107_55)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_102021", "102021026", "story_v_out_102021.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_102021", "102021026", "story_v_out_102021.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_56 = math.max(var_107_47, arg_104_1.talkMaxDuration)

			if var_107_46 <= arg_104_1.time_ and arg_104_1.time_ < var_107_46 + var_107_56 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_46) / var_107_56

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_46 + var_107_56 and arg_104_1.time_ < var_107_46 + var_107_56 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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
				actorName = "2030_tpose",
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

		arg_104_1:InitPlayNodeList()
	end,
	Play102021027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 102021027
		arg_108_1.duration_ = 5.1

		local var_108_0 = {
			ja = 5.1,
			ko = 3.9,
			zh = 4.833,
			en = 4.033
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
				arg_108_0:Play102021028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["3008ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect3008ui_story == nil then
				arg_108_1.var_.characterEffect3008ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.1

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect3008ui_story and not isNil(var_111_0) then
					local var_111_4 = Mathf.Lerp(0, 0.5, var_111_3)

					arg_108_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_108_1.var_.characterEffect3008ui_story.fillRatio = var_111_4
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect3008ui_story then
				local var_111_5 = 0.5

				arg_108_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_108_1.var_.characterEffect3008ui_story.fillRatio = var_111_5
			end

			local var_111_6 = 0
			local var_111_7 = 0.525

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_8 = arg_108_1:FormatText(StoryNameCfg[33].name)

				arg_108_1.leftNameTxt_.text = var_111_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_9 = arg_108_1:GetWordFromCfg(102021027)
				local var_111_10 = arg_108_1:FormatText(var_111_9.content)

				arg_108_1.text_.text = var_111_10

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 20
				local var_111_12 = utf8.len(var_111_10)
				local var_111_13 = var_111_11 <= 0 and var_111_7 or var_111_7 * (var_111_12 / var_111_11)

				if var_111_13 > 0 and var_111_7 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_10
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021027", "story_v_out_102021.awb") ~= 0 then
					local var_111_14 = manager.audio:GetVoiceLength("story_v_out_102021", "102021027", "story_v_out_102021.awb") / 1000

					if var_111_14 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_6
					end

					if var_111_9.prefab_name ~= "" and arg_108_1.actors_[var_111_9.prefab_name] ~= nil then
						local var_111_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_9.prefab_name].transform, "story_v_out_102021", "102021027", "story_v_out_102021.awb")

						arg_108_1:RecordAudio("102021027", var_111_15)
						arg_108_1:RecordAudio("102021027", var_111_15)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_102021", "102021027", "story_v_out_102021.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_102021", "102021027", "story_v_out_102021.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_16 and arg_108_1.time_ < var_111_6 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play102021028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 102021028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play102021029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.875

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_2 = arg_112_1:GetWordFromCfg(102021028)
				local var_115_3 = arg_112_1:FormatText(var_115_2.content)

				arg_112_1.text_.text = var_115_3

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 35
				local var_115_5 = utf8.len(var_115_3)
				local var_115_6 = var_115_4 <= 0 and var_115_1 or var_115_1 * (var_115_5 / var_115_4)

				if var_115_6 > 0 and var_115_1 < var_115_6 then
					arg_112_1.talkMaxDuration = var_115_6

					if var_115_6 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_6 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_3
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_7 and arg_112_1.time_ < var_115_0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play102021029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 102021029
		arg_116_1.duration_ = 14.8

		local var_116_0 = {
			ja = 14.8,
			ko = 8.766,
			zh = 10.033,
			en = 13.533
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play102021030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["3008ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect3008ui_story == nil then
				arg_116_1.var_.characterEffect3008ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.1

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect3008ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect3008ui_story then
				arg_116_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_119_4 = arg_116_1.actors_["3008ui_story"].transform
			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1.var_.moveOldPos3008ui_story = var_119_4.localPosition
			end

			local var_119_6 = 0.5

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_6 then
				local var_119_7 = (arg_116_1.time_ - var_119_5) / var_119_6
				local var_119_8 = Vector3.New(0.7, -1.51, -4.3)

				var_119_4.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos3008ui_story, var_119_8, var_119_7)

				local var_119_9 = manager.ui.mainCamera.transform.position - var_119_4.position

				var_119_4.forward = Vector3.New(var_119_9.x, var_119_9.y, var_119_9.z)

				local var_119_10 = var_119_4.localEulerAngles

				var_119_10.z = 0
				var_119_10.x = 0
				var_119_4.localEulerAngles = var_119_10
			end

			if arg_116_1.time_ >= var_119_5 + var_119_6 and arg_116_1.time_ < var_119_5 + var_119_6 + arg_119_0 then
				var_119_4.localPosition = Vector3.New(0.7, -1.51, -4.3)

				local var_119_11 = manager.ui.mainCamera.transform.position - var_119_4.position

				var_119_4.forward = Vector3.New(var_119_11.x, var_119_11.y, var_119_11.z)

				local var_119_12 = var_119_4.localEulerAngles

				var_119_12.z = 0
				var_119_12.x = 0
				var_119_4.localEulerAngles = var_119_12
			end

			local var_119_13 = arg_116_1.actors_["2030_tpose"].transform
			local var_119_14 = 0

			if var_119_14 < arg_116_1.time_ and arg_116_1.time_ <= var_119_14 + arg_119_0 then
				arg_116_1.var_.moveOldPos2030_tpose = var_119_13.localPosition

				local var_119_15 = GameObjectTools.GetOrAddComponent(var_119_13.gameObject, typeof(DynamicBoneHelper))

				if var_119_15 then
					var_119_15:EnableDynamicBone(false)
				end
			end

			local var_119_16 = 0.001

			if var_119_14 <= arg_116_1.time_ and arg_116_1.time_ < var_119_14 + var_119_16 then
				local var_119_17 = (arg_116_1.time_ - var_119_14) / var_119_16
				local var_119_18 = Vector3.New(-0.7, -1.2, -4.2)

				var_119_13.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos2030_tpose, var_119_18, var_119_17)

				local var_119_19 = manager.ui.mainCamera.transform.position - var_119_13.position

				var_119_13.forward = Vector3.New(var_119_19.x, var_119_19.y, var_119_19.z)

				local var_119_20 = var_119_13.localEulerAngles

				var_119_20.z = 0
				var_119_20.x = 0
				var_119_13.localEulerAngles = var_119_20
			end

			if arg_116_1.time_ >= var_119_14 + var_119_16 and arg_116_1.time_ < var_119_14 + var_119_16 + arg_119_0 then
				var_119_13.localPosition = Vector3.New(-0.7, -1.2, -4.2)

				local var_119_21 = manager.ui.mainCamera.transform.position - var_119_13.position

				var_119_13.forward = Vector3.New(var_119_21.x, var_119_21.y, var_119_21.z)

				local var_119_22 = var_119_13.localEulerAngles

				var_119_22.z = 0
				var_119_22.x = 0
				var_119_13.localEulerAngles = var_119_22

				local var_119_23 = GameObjectTools.GetOrAddComponent(var_119_13.gameObject, typeof(DynamicBoneHelper))

				if var_119_23 then
					var_119_23:EnableDynamicBone(true)
				end
			end

			local var_119_24 = 0

			if var_119_24 < arg_116_1.time_ and arg_116_1.time_ <= var_119_24 + arg_119_0 then
				arg_116_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_119_25 = 0

			if var_119_25 < arg_116_1.time_ and arg_116_1.time_ <= var_119_25 + arg_119_0 then
				arg_116_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_119_26 = arg_116_1.actors_["2030_tpose"]
			local var_119_27 = 0

			if var_119_27 < arg_116_1.time_ and arg_116_1.time_ <= var_119_27 + arg_119_0 and not isNil(var_119_26) and arg_116_1.var_.characterEffect2030_tpose == nil then
				arg_116_1.var_.characterEffect2030_tpose = var_119_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_28 = 0.1

			if var_119_27 <= arg_116_1.time_ and arg_116_1.time_ < var_119_27 + var_119_28 and not isNil(var_119_26) then
				local var_119_29 = (arg_116_1.time_ - var_119_27) / var_119_28

				if arg_116_1.var_.characterEffect2030_tpose and not isNil(var_119_26) then
					local var_119_30 = Mathf.Lerp(0, 0.5, var_119_29)

					arg_116_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_116_1.var_.characterEffect2030_tpose.fillRatio = var_119_30
				end
			end

			if arg_116_1.time_ >= var_119_27 + var_119_28 and arg_116_1.time_ < var_119_27 + var_119_28 + arg_119_0 and not isNil(var_119_26) and arg_116_1.var_.characterEffect2030_tpose then
				local var_119_31 = 0.5

				arg_116_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_116_1.var_.characterEffect2030_tpose.fillRatio = var_119_31
			end

			local var_119_32 = 0
			local var_119_33 = 1.3

			if var_119_32 < arg_116_1.time_ and arg_116_1.time_ <= var_119_32 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_34 = arg_116_1:FormatText(StoryNameCfg[20].name)

				arg_116_1.leftNameTxt_.text = var_119_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_35 = arg_116_1:GetWordFromCfg(102021029)
				local var_119_36 = arg_116_1:FormatText(var_119_35.content)

				arg_116_1.text_.text = var_119_36

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_37 = 51
				local var_119_38 = utf8.len(var_119_36)
				local var_119_39 = var_119_37 <= 0 and var_119_33 or var_119_33 * (var_119_38 / var_119_37)

				if var_119_39 > 0 and var_119_33 < var_119_39 then
					arg_116_1.talkMaxDuration = var_119_39

					if var_119_39 + var_119_32 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_39 + var_119_32
					end
				end

				arg_116_1.text_.text = var_119_36
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021029", "story_v_out_102021.awb") ~= 0 then
					local var_119_40 = manager.audio:GetVoiceLength("story_v_out_102021", "102021029", "story_v_out_102021.awb") / 1000

					if var_119_40 + var_119_32 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_40 + var_119_32
					end

					if var_119_35.prefab_name ~= "" and arg_116_1.actors_[var_119_35.prefab_name] ~= nil then
						local var_119_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_35.prefab_name].transform, "story_v_out_102021", "102021029", "story_v_out_102021.awb")

						arg_116_1:RecordAudio("102021029", var_119_41)
						arg_116_1:RecordAudio("102021029", var_119_41)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_102021", "102021029", "story_v_out_102021.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_102021", "102021029", "story_v_out_102021.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_42 = math.max(var_119_33, arg_116_1.talkMaxDuration)

			if var_119_32 <= arg_116_1.time_ and arg_116_1.time_ < var_119_32 + var_119_42 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_32) / var_119_42

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_32 + var_119_42 and arg_116_1.time_ < var_119_32 + var_119_42 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play102021030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 102021030
		arg_120_1.duration_ = 7.57

		local var_120_0 = {
			ja = 7.566,
			ko = 6.133,
			zh = 6.766,
			en = 6.9
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play102021031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["2030_tpose"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect2030_tpose == nil then
				arg_120_1.var_.characterEffect2030_tpose = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.1

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect2030_tpose and not isNil(var_123_0) then
					arg_120_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect2030_tpose then
				arg_120_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_123_4 = arg_120_1.actors_["3008ui_story"]
			local var_123_5 = 0

			if var_123_5 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect3008ui_story == nil then
				arg_120_1.var_.characterEffect3008ui_story = var_123_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_6 = 0.1

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_6 and not isNil(var_123_4) then
				local var_123_7 = (arg_120_1.time_ - var_123_5) / var_123_6

				if arg_120_1.var_.characterEffect3008ui_story and not isNil(var_123_4) then
					local var_123_8 = Mathf.Lerp(0, 0.5, var_123_7)

					arg_120_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_120_1.var_.characterEffect3008ui_story.fillRatio = var_123_8
				end
			end

			if arg_120_1.time_ >= var_123_5 + var_123_6 and arg_120_1.time_ < var_123_5 + var_123_6 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect3008ui_story then
				local var_123_9 = 0.5

				arg_120_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_120_1.var_.characterEffect3008ui_story.fillRatio = var_123_9
			end

			local var_123_10 = 0
			local var_123_11 = 0.675

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_12 = arg_120_1:FormatText(StoryNameCfg[33].name)

				arg_120_1.leftNameTxt_.text = var_123_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_13 = arg_120_1:GetWordFromCfg(102021030)
				local var_123_14 = arg_120_1:FormatText(var_123_13.content)

				arg_120_1.text_.text = var_123_14

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_15 = 26
				local var_123_16 = utf8.len(var_123_14)
				local var_123_17 = var_123_15 <= 0 and var_123_11 or var_123_11 * (var_123_16 / var_123_15)

				if var_123_17 > 0 and var_123_11 < var_123_17 then
					arg_120_1.talkMaxDuration = var_123_17

					if var_123_17 + var_123_10 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_17 + var_123_10
					end
				end

				arg_120_1.text_.text = var_123_14
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021030", "story_v_out_102021.awb") ~= 0 then
					local var_123_18 = manager.audio:GetVoiceLength("story_v_out_102021", "102021030", "story_v_out_102021.awb") / 1000

					if var_123_18 + var_123_10 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_18 + var_123_10
					end

					if var_123_13.prefab_name ~= "" and arg_120_1.actors_[var_123_13.prefab_name] ~= nil then
						local var_123_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_13.prefab_name].transform, "story_v_out_102021", "102021030", "story_v_out_102021.awb")

						arg_120_1:RecordAudio("102021030", var_123_19)
						arg_120_1:RecordAudio("102021030", var_123_19)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_102021", "102021030", "story_v_out_102021.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_102021", "102021030", "story_v_out_102021.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_20 = math.max(var_123_11, arg_120_1.talkMaxDuration)

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_20 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_10) / var_123_20

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_10 + var_123_20 and arg_120_1.time_ < var_123_10 + var_123_20 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play102021031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 102021031
		arg_124_1.duration_ = 2

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play102021032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["3008ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect3008ui_story == nil then
				arg_124_1.var_.characterEffect3008ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.1

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect3008ui_story and not isNil(var_127_0) then
					arg_124_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect3008ui_story then
				arg_124_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_127_4 = arg_124_1.actors_["2030_tpose"]
			local var_127_5 = 0

			if var_127_5 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 and not isNil(var_127_4) and arg_124_1.var_.characterEffect2030_tpose == nil then
				arg_124_1.var_.characterEffect2030_tpose = var_127_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_6 = 0.1

			if var_127_5 <= arg_124_1.time_ and arg_124_1.time_ < var_127_5 + var_127_6 and not isNil(var_127_4) then
				local var_127_7 = (arg_124_1.time_ - var_127_5) / var_127_6

				if arg_124_1.var_.characterEffect2030_tpose and not isNil(var_127_4) then
					local var_127_8 = Mathf.Lerp(0, 0.5, var_127_7)

					arg_124_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_124_1.var_.characterEffect2030_tpose.fillRatio = var_127_8
				end
			end

			if arg_124_1.time_ >= var_127_5 + var_127_6 and arg_124_1.time_ < var_127_5 + var_127_6 + arg_127_0 and not isNil(var_127_4) and arg_124_1.var_.characterEffect2030_tpose then
				local var_127_9 = 0.5

				arg_124_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_124_1.var_.characterEffect2030_tpose.fillRatio = var_127_9
			end

			local var_127_10 = 0

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 then
				arg_124_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_127_11 = 0
			local var_127_12 = 0.1

			if var_127_11 < arg_124_1.time_ and arg_124_1.time_ <= var_127_11 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_13 = arg_124_1:FormatText(StoryNameCfg[20].name)

				arg_124_1.leftNameTxt_.text = var_127_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_14 = arg_124_1:GetWordFromCfg(102021031)
				local var_127_15 = arg_124_1:FormatText(var_127_14.content)

				arg_124_1.text_.text = var_127_15

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_16 = 4
				local var_127_17 = utf8.len(var_127_15)
				local var_127_18 = var_127_16 <= 0 and var_127_12 or var_127_12 * (var_127_17 / var_127_16)

				if var_127_18 > 0 and var_127_12 < var_127_18 then
					arg_124_1.talkMaxDuration = var_127_18

					if var_127_18 + var_127_11 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_18 + var_127_11
					end
				end

				arg_124_1.text_.text = var_127_15
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021031", "story_v_out_102021.awb") ~= 0 then
					local var_127_19 = manager.audio:GetVoiceLength("story_v_out_102021", "102021031", "story_v_out_102021.awb") / 1000

					if var_127_19 + var_127_11 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_19 + var_127_11
					end

					if var_127_14.prefab_name ~= "" and arg_124_1.actors_[var_127_14.prefab_name] ~= nil then
						local var_127_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_14.prefab_name].transform, "story_v_out_102021", "102021031", "story_v_out_102021.awb")

						arg_124_1:RecordAudio("102021031", var_127_20)
						arg_124_1:RecordAudio("102021031", var_127_20)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_102021", "102021031", "story_v_out_102021.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_102021", "102021031", "story_v_out_102021.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_21 = math.max(var_127_12, arg_124_1.talkMaxDuration)

			if var_127_11 <= arg_124_1.time_ and arg_124_1.time_ < var_127_11 + var_127_21 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_11) / var_127_21

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_11 + var_127_21 and arg_124_1.time_ < var_127_11 + var_127_21 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play102021032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 102021032
		arg_128_1.duration_ = 9.43

		local var_128_0 = {
			ja = 9.433,
			ko = 8.2,
			zh = 5.566,
			en = 7.3
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play102021033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1011ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1011ui_story == nil then
				arg_128_1.var_.characterEffect1011ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.1

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1011ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1011ui_story then
				arg_128_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["3008ui_story"]
			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect3008ui_story == nil then
				arg_128_1.var_.characterEffect3008ui_story = var_131_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_6 = 0.1

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_6 and not isNil(var_131_4) then
				local var_131_7 = (arg_128_1.time_ - var_131_5) / var_131_6

				if arg_128_1.var_.characterEffect3008ui_story and not isNil(var_131_4) then
					local var_131_8 = Mathf.Lerp(0, 0.5, var_131_7)

					arg_128_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_128_1.var_.characterEffect3008ui_story.fillRatio = var_131_8
				end
			end

			if arg_128_1.time_ >= var_131_5 + var_131_6 and arg_128_1.time_ < var_131_5 + var_131_6 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect3008ui_story then
				local var_131_9 = 0.5

				arg_128_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_128_1.var_.characterEffect3008ui_story.fillRatio = var_131_9
			end

			local var_131_10 = arg_128_1.actors_["2030_tpose"].transform
			local var_131_11 = 0

			if var_131_11 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 then
				arg_128_1.var_.moveOldPos2030_tpose = var_131_10.localPosition

				local var_131_12 = GameObjectTools.GetOrAddComponent(var_131_10.gameObject, typeof(DynamicBoneHelper))

				if var_131_12 then
					var_131_12:EnableDynamicBone(false)
				end
			end

			local var_131_13 = 0.001

			if var_131_11 <= arg_128_1.time_ and arg_128_1.time_ < var_131_11 + var_131_13 then
				local var_131_14 = (arg_128_1.time_ - var_131_11) / var_131_13
				local var_131_15 = Vector3.New(0, 100, 0)

				var_131_10.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos2030_tpose, var_131_15, var_131_14)

				local var_131_16 = manager.ui.mainCamera.transform.position - var_131_10.position

				var_131_10.forward = Vector3.New(var_131_16.x, var_131_16.y, var_131_16.z)

				local var_131_17 = var_131_10.localEulerAngles

				var_131_17.z = 0
				var_131_17.x = 0
				var_131_10.localEulerAngles = var_131_17
			end

			if arg_128_1.time_ >= var_131_11 + var_131_13 and arg_128_1.time_ < var_131_11 + var_131_13 + arg_131_0 then
				var_131_10.localPosition = Vector3.New(0, 100, 0)

				local var_131_18 = manager.ui.mainCamera.transform.position - var_131_10.position

				var_131_10.forward = Vector3.New(var_131_18.x, var_131_18.y, var_131_18.z)

				local var_131_19 = var_131_10.localEulerAngles

				var_131_19.z = 0
				var_131_19.x = 0
				var_131_10.localEulerAngles = var_131_19

				local var_131_20 = GameObjectTools.GetOrAddComponent(var_131_10.gameObject, typeof(DynamicBoneHelper))

				if var_131_20 then
					var_131_20:EnableDynamicBone(true)
				end
			end

			local var_131_21 = 0

			if var_131_21 < arg_128_1.time_ and arg_128_1.time_ <= var_131_21 + arg_131_0 then
				arg_128_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_131_22 = arg_128_1.actors_["1011ui_story"].transform
			local var_131_23 = 0

			if var_131_23 < arg_128_1.time_ and arg_128_1.time_ <= var_131_23 + arg_131_0 then
				arg_128_1.var_.moveOldPos1011ui_story = var_131_22.localPosition
			end

			local var_131_24 = 0.001

			if var_131_23 <= arg_128_1.time_ and arg_128_1.time_ < var_131_23 + var_131_24 then
				local var_131_25 = (arg_128_1.time_ - var_131_23) / var_131_24
				local var_131_26 = Vector3.New(-0.7, -0.71, -6)

				var_131_22.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1011ui_story, var_131_26, var_131_25)

				local var_131_27 = manager.ui.mainCamera.transform.position - var_131_22.position

				var_131_22.forward = Vector3.New(var_131_27.x, var_131_27.y, var_131_27.z)

				local var_131_28 = var_131_22.localEulerAngles

				var_131_28.z = 0
				var_131_28.x = 0
				var_131_22.localEulerAngles = var_131_28
			end

			if arg_128_1.time_ >= var_131_23 + var_131_24 and arg_128_1.time_ < var_131_23 + var_131_24 + arg_131_0 then
				var_131_22.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_131_29 = manager.ui.mainCamera.transform.position - var_131_22.position

				var_131_22.forward = Vector3.New(var_131_29.x, var_131_29.y, var_131_29.z)

				local var_131_30 = var_131_22.localEulerAngles

				var_131_30.z = 0
				var_131_30.x = 0
				var_131_22.localEulerAngles = var_131_30
			end

			local var_131_31 = 0

			if var_131_31 < arg_128_1.time_ and arg_128_1.time_ <= var_131_31 + arg_131_0 then
				arg_128_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_131_32 = 0
			local var_131_33 = 0.675

			if var_131_32 < arg_128_1.time_ and arg_128_1.time_ <= var_131_32 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_34 = arg_128_1:FormatText(StoryNameCfg[37].name)

				arg_128_1.leftNameTxt_.text = var_131_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_35 = arg_128_1:GetWordFromCfg(102021032)
				local var_131_36 = arg_128_1:FormatText(var_131_35.content)

				arg_128_1.text_.text = var_131_36

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_37 = 27
				local var_131_38 = utf8.len(var_131_36)
				local var_131_39 = var_131_37 <= 0 and var_131_33 or var_131_33 * (var_131_38 / var_131_37)

				if var_131_39 > 0 and var_131_33 < var_131_39 then
					arg_128_1.talkMaxDuration = var_131_39

					if var_131_39 + var_131_32 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_39 + var_131_32
					end
				end

				arg_128_1.text_.text = var_131_36
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021032", "story_v_out_102021.awb") ~= 0 then
					local var_131_40 = manager.audio:GetVoiceLength("story_v_out_102021", "102021032", "story_v_out_102021.awb") / 1000

					if var_131_40 + var_131_32 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_40 + var_131_32
					end

					if var_131_35.prefab_name ~= "" and arg_128_1.actors_[var_131_35.prefab_name] ~= nil then
						local var_131_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_35.prefab_name].transform, "story_v_out_102021", "102021032", "story_v_out_102021.awb")

						arg_128_1:RecordAudio("102021032", var_131_41)
						arg_128_1:RecordAudio("102021032", var_131_41)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_102021", "102021032", "story_v_out_102021.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_102021", "102021032", "story_v_out_102021.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_42 = math.max(var_131_33, arg_128_1.talkMaxDuration)

			if var_131_32 <= arg_128_1.time_ and arg_128_1.time_ < var_131_32 + var_131_42 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_32) / var_131_42

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_32 + var_131_42 and arg_128_1.time_ < var_131_32 + var_131_42 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
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

		arg_128_1:InitPlayNodeList()
	end,
	Play102021033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 102021033
		arg_132_1.duration_ = 11.03

		local var_132_0 = {
			ja = 11.033,
			ko = 9.1,
			zh = 9,
			en = 7.566
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play102021034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["3008ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect3008ui_story == nil then
				arg_132_1.var_.characterEffect3008ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.1

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect3008ui_story and not isNil(var_135_0) then
					arg_132_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect3008ui_story then
				arg_132_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_135_4 = arg_132_1.actors_["1011ui_story"]
			local var_135_5 = 0

			if var_135_5 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.characterEffect1011ui_story == nil then
				arg_132_1.var_.characterEffect1011ui_story = var_135_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_6 = 0.1

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_6 and not isNil(var_135_4) then
				local var_135_7 = (arg_132_1.time_ - var_135_5) / var_135_6

				if arg_132_1.var_.characterEffect1011ui_story and not isNil(var_135_4) then
					local var_135_8 = Mathf.Lerp(0, 0.5, var_135_7)

					arg_132_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1011ui_story.fillRatio = var_135_8
				end
			end

			if arg_132_1.time_ >= var_135_5 + var_135_6 and arg_132_1.time_ < var_135_5 + var_135_6 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.characterEffect1011ui_story then
				local var_135_9 = 0.5

				arg_132_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1011ui_story.fillRatio = var_135_9
			end

			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_1")
			end

			local var_135_11 = 0

			if var_135_11 < arg_132_1.time_ and arg_132_1.time_ <= var_135_11 + arg_135_0 then
				arg_132_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_135_12 = 0
			local var_135_13 = 0.925

			if var_135_12 < arg_132_1.time_ and arg_132_1.time_ <= var_135_12 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_14 = arg_132_1:FormatText(StoryNameCfg[20].name)

				arg_132_1.leftNameTxt_.text = var_135_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_15 = arg_132_1:GetWordFromCfg(102021033)
				local var_135_16 = arg_132_1:FormatText(var_135_15.content)

				arg_132_1.text_.text = var_135_16

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_17 = 36
				local var_135_18 = utf8.len(var_135_16)
				local var_135_19 = var_135_17 <= 0 and var_135_13 or var_135_13 * (var_135_18 / var_135_17)

				if var_135_19 > 0 and var_135_13 < var_135_19 then
					arg_132_1.talkMaxDuration = var_135_19

					if var_135_19 + var_135_12 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_19 + var_135_12
					end
				end

				arg_132_1.text_.text = var_135_16
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021033", "story_v_out_102021.awb") ~= 0 then
					local var_135_20 = manager.audio:GetVoiceLength("story_v_out_102021", "102021033", "story_v_out_102021.awb") / 1000

					if var_135_20 + var_135_12 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_20 + var_135_12
					end

					if var_135_15.prefab_name ~= "" and arg_132_1.actors_[var_135_15.prefab_name] ~= nil then
						local var_135_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_15.prefab_name].transform, "story_v_out_102021", "102021033", "story_v_out_102021.awb")

						arg_132_1:RecordAudio("102021033", var_135_21)
						arg_132_1:RecordAudio("102021033", var_135_21)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_102021", "102021033", "story_v_out_102021.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_102021", "102021033", "story_v_out_102021.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_22 = math.max(var_135_13, arg_132_1.talkMaxDuration)

			if var_135_12 <= arg_132_1.time_ and arg_132_1.time_ < var_135_12 + var_135_22 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_12) / var_135_22

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_12 + var_135_22 and arg_132_1.time_ < var_135_12 + var_135_22 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play102021034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 102021034
		arg_136_1.duration_ = 12.1

		local var_136_0 = {
			ja = 12.1,
			ko = 9.966,
			zh = 11.7,
			en = 10.266
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play102021035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1019ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1019ui_story == nil then
				arg_136_1.var_.characterEffect1019ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.1

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1019ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1019ui_story then
				arg_136_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_139_4 = arg_136_1.actors_["3008ui_story"]
			local var_139_5 = 0

			if var_139_5 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect3008ui_story == nil then
				arg_136_1.var_.characterEffect3008ui_story = var_139_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_6 = 0.1

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_6 and not isNil(var_139_4) then
				local var_139_7 = (arg_136_1.time_ - var_139_5) / var_139_6

				if arg_136_1.var_.characterEffect3008ui_story and not isNil(var_139_4) then
					local var_139_8 = Mathf.Lerp(0, 0.5, var_139_7)

					arg_136_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_136_1.var_.characterEffect3008ui_story.fillRatio = var_139_8
				end
			end

			if arg_136_1.time_ >= var_139_5 + var_139_6 and arg_136_1.time_ < var_139_5 + var_139_6 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect3008ui_story then
				local var_139_9 = 0.5

				arg_136_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_136_1.var_.characterEffect3008ui_story.fillRatio = var_139_9
			end

			local var_139_10 = arg_136_1.actors_["1011ui_story"].transform
			local var_139_11 = 0

			if var_139_11 < arg_136_1.time_ and arg_136_1.time_ <= var_139_11 + arg_139_0 then
				arg_136_1.var_.moveOldPos1011ui_story = var_139_10.localPosition
			end

			local var_139_12 = 0.001

			if var_139_11 <= arg_136_1.time_ and arg_136_1.time_ < var_139_11 + var_139_12 then
				local var_139_13 = (arg_136_1.time_ - var_139_11) / var_139_12
				local var_139_14 = Vector3.New(0, 100, 0)

				var_139_10.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1011ui_story, var_139_14, var_139_13)

				local var_139_15 = manager.ui.mainCamera.transform.position - var_139_10.position

				var_139_10.forward = Vector3.New(var_139_15.x, var_139_15.y, var_139_15.z)

				local var_139_16 = var_139_10.localEulerAngles

				var_139_16.z = 0
				var_139_16.x = 0
				var_139_10.localEulerAngles = var_139_16
			end

			if arg_136_1.time_ >= var_139_11 + var_139_12 and arg_136_1.time_ < var_139_11 + var_139_12 + arg_139_0 then
				var_139_10.localPosition = Vector3.New(0, 100, 0)

				local var_139_17 = manager.ui.mainCamera.transform.position - var_139_10.position

				var_139_10.forward = Vector3.New(var_139_17.x, var_139_17.y, var_139_17.z)

				local var_139_18 = var_139_10.localEulerAngles

				var_139_18.z = 0
				var_139_18.x = 0
				var_139_10.localEulerAngles = var_139_18
			end

			local var_139_19 = arg_136_1.actors_["1019ui_story"].transform
			local var_139_20 = 0

			if var_139_20 < arg_136_1.time_ and arg_136_1.time_ <= var_139_20 + arg_139_0 then
				arg_136_1.var_.moveOldPos1019ui_story = var_139_19.localPosition
			end

			local var_139_21 = 0.001

			if var_139_20 <= arg_136_1.time_ and arg_136_1.time_ < var_139_20 + var_139_21 then
				local var_139_22 = (arg_136_1.time_ - var_139_20) / var_139_21
				local var_139_23 = Vector3.New(-0.7, -1.08, -5.9)

				var_139_19.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1019ui_story, var_139_23, var_139_22)

				local var_139_24 = manager.ui.mainCamera.transform.position - var_139_19.position

				var_139_19.forward = Vector3.New(var_139_24.x, var_139_24.y, var_139_24.z)

				local var_139_25 = var_139_19.localEulerAngles

				var_139_25.z = 0
				var_139_25.x = 0
				var_139_19.localEulerAngles = var_139_25
			end

			if arg_136_1.time_ >= var_139_20 + var_139_21 and arg_136_1.time_ < var_139_20 + var_139_21 + arg_139_0 then
				var_139_19.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_139_26 = manager.ui.mainCamera.transform.position - var_139_19.position

				var_139_19.forward = Vector3.New(var_139_26.x, var_139_26.y, var_139_26.z)

				local var_139_27 = var_139_19.localEulerAngles

				var_139_27.z = 0
				var_139_27.x = 0
				var_139_19.localEulerAngles = var_139_27
			end

			local var_139_28 = 0

			if var_139_28 < arg_136_1.time_ and arg_136_1.time_ <= var_139_28 + arg_139_0 then
				arg_136_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_139_29 = 0
			local var_139_30 = 1.225

			if var_139_29 < arg_136_1.time_ and arg_136_1.time_ <= var_139_29 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_31 = arg_136_1:FormatText(StoryNameCfg[13].name)

				arg_136_1.leftNameTxt_.text = var_139_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_32 = arg_136_1:GetWordFromCfg(102021034)
				local var_139_33 = arg_136_1:FormatText(var_139_32.content)

				arg_136_1.text_.text = var_139_33

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_34 = 51
				local var_139_35 = utf8.len(var_139_33)
				local var_139_36 = var_139_34 <= 0 and var_139_30 or var_139_30 * (var_139_35 / var_139_34)

				if var_139_36 > 0 and var_139_30 < var_139_36 then
					arg_136_1.talkMaxDuration = var_139_36

					if var_139_36 + var_139_29 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_36 + var_139_29
					end
				end

				arg_136_1.text_.text = var_139_33
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021034", "story_v_out_102021.awb") ~= 0 then
					local var_139_37 = manager.audio:GetVoiceLength("story_v_out_102021", "102021034", "story_v_out_102021.awb") / 1000

					if var_139_37 + var_139_29 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_37 + var_139_29
					end

					if var_139_32.prefab_name ~= "" and arg_136_1.actors_[var_139_32.prefab_name] ~= nil then
						local var_139_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_32.prefab_name].transform, "story_v_out_102021", "102021034", "story_v_out_102021.awb")

						arg_136_1:RecordAudio("102021034", var_139_38)
						arg_136_1:RecordAudio("102021034", var_139_38)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_102021", "102021034", "story_v_out_102021.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_102021", "102021034", "story_v_out_102021.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_39 = math.max(var_139_30, arg_136_1.talkMaxDuration)

			if var_139_29 <= arg_136_1.time_ and arg_136_1.time_ < var_139_29 + var_139_39 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_29) / var_139_39

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_29 + var_139_39 and arg_136_1.time_ < var_139_29 + var_139_39 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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

		arg_136_1:InitPlayNodeList()
	end,
	Play102021035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 102021035
		arg_140_1.duration_ = 3.2

		local var_140_0 = {
			ja = 2.866,
			ko = 3.2,
			zh = 2.8,
			en = 2.6
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play102021036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["3008ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect3008ui_story == nil then
				arg_140_1.var_.characterEffect3008ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.1

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect3008ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect3008ui_story then
				arg_140_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_143_4 = arg_140_1.actors_["1019ui_story"]
			local var_143_5 = 0

			if var_143_5 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect1019ui_story == nil then
				arg_140_1.var_.characterEffect1019ui_story = var_143_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_6 = 0.1

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_6 and not isNil(var_143_4) then
				local var_143_7 = (arg_140_1.time_ - var_143_5) / var_143_6

				if arg_140_1.var_.characterEffect1019ui_story and not isNil(var_143_4) then
					local var_143_8 = Mathf.Lerp(0, 0.5, var_143_7)

					arg_140_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1019ui_story.fillRatio = var_143_8
				end
			end

			if arg_140_1.time_ >= var_143_5 + var_143_6 and arg_140_1.time_ < var_143_5 + var_143_6 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect1019ui_story then
				local var_143_9 = 0.5

				arg_140_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1019ui_story.fillRatio = var_143_9
			end

			local var_143_10 = 0

			if var_143_10 < arg_140_1.time_ and arg_140_1.time_ <= var_143_10 + arg_143_0 then
				arg_140_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_143_11 = 0
			local var_143_12 = 0.3

			if var_143_11 < arg_140_1.time_ and arg_140_1.time_ <= var_143_11 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_13 = arg_140_1:FormatText(StoryNameCfg[20].name)

				arg_140_1.leftNameTxt_.text = var_143_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_14 = arg_140_1:GetWordFromCfg(102021035)
				local var_143_15 = arg_140_1:FormatText(var_143_14.content)

				arg_140_1.text_.text = var_143_15

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_16 = 13
				local var_143_17 = utf8.len(var_143_15)
				local var_143_18 = var_143_16 <= 0 and var_143_12 or var_143_12 * (var_143_17 / var_143_16)

				if var_143_18 > 0 and var_143_12 < var_143_18 then
					arg_140_1.talkMaxDuration = var_143_18

					if var_143_18 + var_143_11 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_18 + var_143_11
					end
				end

				arg_140_1.text_.text = var_143_15
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021035", "story_v_out_102021.awb") ~= 0 then
					local var_143_19 = manager.audio:GetVoiceLength("story_v_out_102021", "102021035", "story_v_out_102021.awb") / 1000

					if var_143_19 + var_143_11 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_19 + var_143_11
					end

					if var_143_14.prefab_name ~= "" and arg_140_1.actors_[var_143_14.prefab_name] ~= nil then
						local var_143_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_14.prefab_name].transform, "story_v_out_102021", "102021035", "story_v_out_102021.awb")

						arg_140_1:RecordAudio("102021035", var_143_20)
						arg_140_1:RecordAudio("102021035", var_143_20)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_102021", "102021035", "story_v_out_102021.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_102021", "102021035", "story_v_out_102021.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_21 = math.max(var_143_12, arg_140_1.talkMaxDuration)

			if var_143_11 <= arg_140_1.time_ and arg_140_1.time_ < var_143_11 + var_143_21 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_11) / var_143_21

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_11 + var_143_21 and arg_140_1.time_ < var_143_11 + var_143_21 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play102021036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 102021036
		arg_144_1.duration_ = 3.77

		local var_144_0 = {
			ja = 3.766,
			ko = 2.333,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play102021037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1011ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1011ui_story == nil then
				arg_144_1.var_.characterEffect1011ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.1

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1011ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1011ui_story then
				arg_144_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_147_4 = arg_144_1.actors_["3008ui_story"]
			local var_147_5 = 0

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect3008ui_story == nil then
				arg_144_1.var_.characterEffect3008ui_story = var_147_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_6 = 0.1

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_6 and not isNil(var_147_4) then
				local var_147_7 = (arg_144_1.time_ - var_147_5) / var_147_6

				if arg_144_1.var_.characterEffect3008ui_story and not isNil(var_147_4) then
					local var_147_8 = Mathf.Lerp(0, 0.5, var_147_7)

					arg_144_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_144_1.var_.characterEffect3008ui_story.fillRatio = var_147_8
				end
			end

			if arg_144_1.time_ >= var_147_5 + var_147_6 and arg_144_1.time_ < var_147_5 + var_147_6 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect3008ui_story then
				local var_147_9 = 0.5

				arg_144_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_144_1.var_.characterEffect3008ui_story.fillRatio = var_147_9
			end

			local var_147_10 = arg_144_1.actors_["1019ui_story"].transform
			local var_147_11 = 0

			if var_147_11 < arg_144_1.time_ and arg_144_1.time_ <= var_147_11 + arg_147_0 then
				arg_144_1.var_.moveOldPos1019ui_story = var_147_10.localPosition
			end

			local var_147_12 = 0.001

			if var_147_11 <= arg_144_1.time_ and arg_144_1.time_ < var_147_11 + var_147_12 then
				local var_147_13 = (arg_144_1.time_ - var_147_11) / var_147_12
				local var_147_14 = Vector3.New(0, 100, 0)

				var_147_10.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1019ui_story, var_147_14, var_147_13)

				local var_147_15 = manager.ui.mainCamera.transform.position - var_147_10.position

				var_147_10.forward = Vector3.New(var_147_15.x, var_147_15.y, var_147_15.z)

				local var_147_16 = var_147_10.localEulerAngles

				var_147_16.z = 0
				var_147_16.x = 0
				var_147_10.localEulerAngles = var_147_16
			end

			if arg_144_1.time_ >= var_147_11 + var_147_12 and arg_144_1.time_ < var_147_11 + var_147_12 + arg_147_0 then
				var_147_10.localPosition = Vector3.New(0, 100, 0)

				local var_147_17 = manager.ui.mainCamera.transform.position - var_147_10.position

				var_147_10.forward = Vector3.New(var_147_17.x, var_147_17.y, var_147_17.z)

				local var_147_18 = var_147_10.localEulerAngles

				var_147_18.z = 0
				var_147_18.x = 0
				var_147_10.localEulerAngles = var_147_18
			end

			local var_147_19 = arg_144_1.actors_["1011ui_story"].transform
			local var_147_20 = 0

			if var_147_20 < arg_144_1.time_ and arg_144_1.time_ <= var_147_20 + arg_147_0 then
				arg_144_1.var_.moveOldPos1011ui_story = var_147_19.localPosition
			end

			local var_147_21 = 0.001

			if var_147_20 <= arg_144_1.time_ and arg_144_1.time_ < var_147_20 + var_147_21 then
				local var_147_22 = (arg_144_1.time_ - var_147_20) / var_147_21
				local var_147_23 = Vector3.New(-0.7, -0.71, -6)

				var_147_19.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1011ui_story, var_147_23, var_147_22)

				local var_147_24 = manager.ui.mainCamera.transform.position - var_147_19.position

				var_147_19.forward = Vector3.New(var_147_24.x, var_147_24.y, var_147_24.z)

				local var_147_25 = var_147_19.localEulerAngles

				var_147_25.z = 0
				var_147_25.x = 0
				var_147_19.localEulerAngles = var_147_25
			end

			if arg_144_1.time_ >= var_147_20 + var_147_21 and arg_144_1.time_ < var_147_20 + var_147_21 + arg_147_0 then
				var_147_19.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_147_26 = manager.ui.mainCamera.transform.position - var_147_19.position

				var_147_19.forward = Vector3.New(var_147_26.x, var_147_26.y, var_147_26.z)

				local var_147_27 = var_147_19.localEulerAngles

				var_147_27.z = 0
				var_147_27.x = 0
				var_147_19.localEulerAngles = var_147_27
			end

			local var_147_28 = 0

			if var_147_28 < arg_144_1.time_ and arg_144_1.time_ <= var_147_28 + arg_147_0 then
				arg_144_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_147_29 = 0

			if var_147_29 < arg_144_1.time_ and arg_144_1.time_ <= var_147_29 + arg_147_0 then
				arg_144_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_147_30 = 0
			local var_147_31 = 0.175

			if var_147_30 < arg_144_1.time_ and arg_144_1.time_ <= var_147_30 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_32 = arg_144_1:FormatText(StoryNameCfg[37].name)

				arg_144_1.leftNameTxt_.text = var_147_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_33 = arg_144_1:GetWordFromCfg(102021036)
				local var_147_34 = arg_144_1:FormatText(var_147_33.content)

				arg_144_1.text_.text = var_147_34

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_35 = 7
				local var_147_36 = utf8.len(var_147_34)
				local var_147_37 = var_147_35 <= 0 and var_147_31 or var_147_31 * (var_147_36 / var_147_35)

				if var_147_37 > 0 and var_147_31 < var_147_37 then
					arg_144_1.talkMaxDuration = var_147_37

					if var_147_37 + var_147_30 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_37 + var_147_30
					end
				end

				arg_144_1.text_.text = var_147_34
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021036", "story_v_out_102021.awb") ~= 0 then
					local var_147_38 = manager.audio:GetVoiceLength("story_v_out_102021", "102021036", "story_v_out_102021.awb") / 1000

					if var_147_38 + var_147_30 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_38 + var_147_30
					end

					if var_147_33.prefab_name ~= "" and arg_144_1.actors_[var_147_33.prefab_name] ~= nil then
						local var_147_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_33.prefab_name].transform, "story_v_out_102021", "102021036", "story_v_out_102021.awb")

						arg_144_1:RecordAudio("102021036", var_147_39)
						arg_144_1:RecordAudio("102021036", var_147_39)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_102021", "102021036", "story_v_out_102021.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_102021", "102021036", "story_v_out_102021.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_40 = math.max(var_147_31, arg_144_1.talkMaxDuration)

			if var_147_30 <= arg_144_1.time_ and arg_144_1.time_ < var_147_30 + var_147_40 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_30) / var_147_40

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_30 + var_147_40 and arg_144_1.time_ < var_147_30 + var_147_40 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
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

		arg_144_1:InitPlayNodeList()
	end,
	Play102021037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 102021037
		arg_148_1.duration_ = 7.13

		local var_148_0 = {
			ja = 7.133,
			ko = 5.3,
			zh = 5.8,
			en = 4.3
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play102021038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["3008ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect3008ui_story == nil then
				arg_148_1.var_.characterEffect3008ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.1

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect3008ui_story and not isNil(var_151_0) then
					arg_148_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect3008ui_story then
				arg_148_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_151_4 = arg_148_1.actors_["1011ui_story"]
			local var_151_5 = 0

			if var_151_5 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect1011ui_story == nil then
				arg_148_1.var_.characterEffect1011ui_story = var_151_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_6 = 0.1

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_6 and not isNil(var_151_4) then
				local var_151_7 = (arg_148_1.time_ - var_151_5) / var_151_6

				if arg_148_1.var_.characterEffect1011ui_story and not isNil(var_151_4) then
					local var_151_8 = Mathf.Lerp(0, 0.5, var_151_7)

					arg_148_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1011ui_story.fillRatio = var_151_8
				end
			end

			if arg_148_1.time_ >= var_151_5 + var_151_6 and arg_148_1.time_ < var_151_5 + var_151_6 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect1011ui_story then
				local var_151_9 = 0.5

				arg_148_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1011ui_story.fillRatio = var_151_9
			end

			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 then
				arg_148_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008actionlink/3008action467")
			end

			local var_151_11 = 0

			if var_151_11 < arg_148_1.time_ and arg_148_1.time_ <= var_151_11 + arg_151_0 then
				arg_148_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_151_12 = 0
			local var_151_13 = 0.425

			if var_151_12 < arg_148_1.time_ and arg_148_1.time_ <= var_151_12 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_14 = arg_148_1:FormatText(StoryNameCfg[20].name)

				arg_148_1.leftNameTxt_.text = var_151_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_15 = arg_148_1:GetWordFromCfg(102021037)
				local var_151_16 = arg_148_1:FormatText(var_151_15.content)

				arg_148_1.text_.text = var_151_16

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_17 = 17
				local var_151_18 = utf8.len(var_151_16)
				local var_151_19 = var_151_17 <= 0 and var_151_13 or var_151_13 * (var_151_18 / var_151_17)

				if var_151_19 > 0 and var_151_13 < var_151_19 then
					arg_148_1.talkMaxDuration = var_151_19

					if var_151_19 + var_151_12 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_19 + var_151_12
					end
				end

				arg_148_1.text_.text = var_151_16
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021037", "story_v_out_102021.awb") ~= 0 then
					local var_151_20 = manager.audio:GetVoiceLength("story_v_out_102021", "102021037", "story_v_out_102021.awb") / 1000

					if var_151_20 + var_151_12 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_20 + var_151_12
					end

					if var_151_15.prefab_name ~= "" and arg_148_1.actors_[var_151_15.prefab_name] ~= nil then
						local var_151_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_15.prefab_name].transform, "story_v_out_102021", "102021037", "story_v_out_102021.awb")

						arg_148_1:RecordAudio("102021037", var_151_21)
						arg_148_1:RecordAudio("102021037", var_151_21)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_102021", "102021037", "story_v_out_102021.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_102021", "102021037", "story_v_out_102021.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_22 = math.max(var_151_13, arg_148_1.talkMaxDuration)

			if var_151_12 <= arg_148_1.time_ and arg_148_1.time_ < var_151_12 + var_151_22 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_12) / var_151_22

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_12 + var_151_22 and arg_148_1.time_ < var_151_12 + var_151_22 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play102021038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 102021038
		arg_152_1.duration_ = 3.1

		local var_152_0 = {
			ja = 3.1,
			ko = 2.333,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play102021039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1084ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1084ui_story == nil then
				arg_152_1.var_.characterEffect1084ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.1

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect1084ui_story and not isNil(var_155_0) then
					arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1084ui_story then
				arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_155_4 = arg_152_1.actors_["3008ui_story"]
			local var_155_5 = 0

			if var_155_5 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect3008ui_story == nil then
				arg_152_1.var_.characterEffect3008ui_story = var_155_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_6 = 0.1

			if var_155_5 <= arg_152_1.time_ and arg_152_1.time_ < var_155_5 + var_155_6 and not isNil(var_155_4) then
				local var_155_7 = (arg_152_1.time_ - var_155_5) / var_155_6

				if arg_152_1.var_.characterEffect3008ui_story and not isNil(var_155_4) then
					local var_155_8 = Mathf.Lerp(0, 0.5, var_155_7)

					arg_152_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_152_1.var_.characterEffect3008ui_story.fillRatio = var_155_8
				end
			end

			if arg_152_1.time_ >= var_155_5 + var_155_6 and arg_152_1.time_ < var_155_5 + var_155_6 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect3008ui_story then
				local var_155_9 = 0.5

				arg_152_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_152_1.var_.characterEffect3008ui_story.fillRatio = var_155_9
			end

			local var_155_10 = arg_152_1.actors_["1011ui_story"].transform
			local var_155_11 = 0

			if var_155_11 < arg_152_1.time_ and arg_152_1.time_ <= var_155_11 + arg_155_0 then
				arg_152_1.var_.moveOldPos1011ui_story = var_155_10.localPosition
			end

			local var_155_12 = 0.001

			if var_155_11 <= arg_152_1.time_ and arg_152_1.time_ < var_155_11 + var_155_12 then
				local var_155_13 = (arg_152_1.time_ - var_155_11) / var_155_12
				local var_155_14 = Vector3.New(0, 100, 0)

				var_155_10.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1011ui_story, var_155_14, var_155_13)

				local var_155_15 = manager.ui.mainCamera.transform.position - var_155_10.position

				var_155_10.forward = Vector3.New(var_155_15.x, var_155_15.y, var_155_15.z)

				local var_155_16 = var_155_10.localEulerAngles

				var_155_16.z = 0
				var_155_16.x = 0
				var_155_10.localEulerAngles = var_155_16
			end

			if arg_152_1.time_ >= var_155_11 + var_155_12 and arg_152_1.time_ < var_155_11 + var_155_12 + arg_155_0 then
				var_155_10.localPosition = Vector3.New(0, 100, 0)

				local var_155_17 = manager.ui.mainCamera.transform.position - var_155_10.position

				var_155_10.forward = Vector3.New(var_155_17.x, var_155_17.y, var_155_17.z)

				local var_155_18 = var_155_10.localEulerAngles

				var_155_18.z = 0
				var_155_18.x = 0
				var_155_10.localEulerAngles = var_155_18
			end

			local var_155_19 = arg_152_1.actors_["1084ui_story"].transform
			local var_155_20 = 0

			if var_155_20 < arg_152_1.time_ and arg_152_1.time_ <= var_155_20 + arg_155_0 then
				arg_152_1.var_.moveOldPos1084ui_story = var_155_19.localPosition
			end

			local var_155_21 = 0.001

			if var_155_20 <= arg_152_1.time_ and arg_152_1.time_ < var_155_20 + var_155_21 then
				local var_155_22 = (arg_152_1.time_ - var_155_20) / var_155_21
				local var_155_23 = Vector3.New(-0.7, -0.97, -6)

				var_155_19.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1084ui_story, var_155_23, var_155_22)

				local var_155_24 = manager.ui.mainCamera.transform.position - var_155_19.position

				var_155_19.forward = Vector3.New(var_155_24.x, var_155_24.y, var_155_24.z)

				local var_155_25 = var_155_19.localEulerAngles

				var_155_25.z = 0
				var_155_25.x = 0
				var_155_19.localEulerAngles = var_155_25
			end

			if arg_152_1.time_ >= var_155_20 + var_155_21 and arg_152_1.time_ < var_155_20 + var_155_21 + arg_155_0 then
				var_155_19.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_155_26 = manager.ui.mainCamera.transform.position - var_155_19.position

				var_155_19.forward = Vector3.New(var_155_26.x, var_155_26.y, var_155_26.z)

				local var_155_27 = var_155_19.localEulerAngles

				var_155_27.z = 0
				var_155_27.x = 0
				var_155_19.localEulerAngles = var_155_27
			end

			local var_155_28 = 0

			if var_155_28 < arg_152_1.time_ and arg_152_1.time_ <= var_155_28 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_155_29 = 0

			if var_155_29 < arg_152_1.time_ and arg_152_1.time_ <= var_155_29 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_155_30 = 0
			local var_155_31 = 0.2

			if var_155_30 < arg_152_1.time_ and arg_152_1.time_ <= var_155_30 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_32 = arg_152_1:FormatText(StoryNameCfg[6].name)

				arg_152_1.leftNameTxt_.text = var_155_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_33 = arg_152_1:GetWordFromCfg(102021038)
				local var_155_34 = arg_152_1:FormatText(var_155_33.content)

				arg_152_1.text_.text = var_155_34

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_35 = 8
				local var_155_36 = utf8.len(var_155_34)
				local var_155_37 = var_155_35 <= 0 and var_155_31 or var_155_31 * (var_155_36 / var_155_35)

				if var_155_37 > 0 and var_155_31 < var_155_37 then
					arg_152_1.talkMaxDuration = var_155_37

					if var_155_37 + var_155_30 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_37 + var_155_30
					end
				end

				arg_152_1.text_.text = var_155_34
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021038", "story_v_out_102021.awb") ~= 0 then
					local var_155_38 = manager.audio:GetVoiceLength("story_v_out_102021", "102021038", "story_v_out_102021.awb") / 1000

					if var_155_38 + var_155_30 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_38 + var_155_30
					end

					if var_155_33.prefab_name ~= "" and arg_152_1.actors_[var_155_33.prefab_name] ~= nil then
						local var_155_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_33.prefab_name].transform, "story_v_out_102021", "102021038", "story_v_out_102021.awb")

						arg_152_1:RecordAudio("102021038", var_155_39)
						arg_152_1:RecordAudio("102021038", var_155_39)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_102021", "102021038", "story_v_out_102021.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_102021", "102021038", "story_v_out_102021.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_40 = math.max(var_155_31, arg_152_1.talkMaxDuration)

			if var_155_30 <= arg_152_1.time_ and arg_152_1.time_ < var_155_30 + var_155_40 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_30) / var_155_40

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_30 + var_155_40 and arg_152_1.time_ < var_155_30 + var_155_40 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play102021039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 102021039
		arg_156_1.duration_ = 4.47

		local var_156_0 = {
			ja = 4,
			ko = 3.266,
			zh = 4.1,
			en = 4.466
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play102021040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["3008ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect3008ui_story == nil then
				arg_156_1.var_.characterEffect3008ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.1

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect3008ui_story and not isNil(var_159_0) then
					arg_156_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect3008ui_story then
				arg_156_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_159_4 = arg_156_1.actors_["1084ui_story"]
			local var_159_5 = 0

			if var_159_5 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect1084ui_story == nil then
				arg_156_1.var_.characterEffect1084ui_story = var_159_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_6 = 0.1

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_6 and not isNil(var_159_4) then
				local var_159_7 = (arg_156_1.time_ - var_159_5) / var_159_6

				if arg_156_1.var_.characterEffect1084ui_story and not isNil(var_159_4) then
					local var_159_8 = Mathf.Lerp(0, 0.5, var_159_7)

					arg_156_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1084ui_story.fillRatio = var_159_8
				end
			end

			if arg_156_1.time_ >= var_159_5 + var_159_6 and arg_156_1.time_ < var_159_5 + var_159_6 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect1084ui_story then
				local var_159_9 = 0.5

				arg_156_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1084ui_story.fillRatio = var_159_9
			end

			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 then
				arg_156_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_159_11 = 0
			local var_159_12 = 0.4

			if var_159_11 < arg_156_1.time_ and arg_156_1.time_ <= var_159_11 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_13 = arg_156_1:FormatText(StoryNameCfg[20].name)

				arg_156_1.leftNameTxt_.text = var_159_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_14 = arg_156_1:GetWordFromCfg(102021039)
				local var_159_15 = arg_156_1:FormatText(var_159_14.content)

				arg_156_1.text_.text = var_159_15

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_16 = 16
				local var_159_17 = utf8.len(var_159_15)
				local var_159_18 = var_159_16 <= 0 and var_159_12 or var_159_12 * (var_159_17 / var_159_16)

				if var_159_18 > 0 and var_159_12 < var_159_18 then
					arg_156_1.talkMaxDuration = var_159_18

					if var_159_18 + var_159_11 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_18 + var_159_11
					end
				end

				arg_156_1.text_.text = var_159_15
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021039", "story_v_out_102021.awb") ~= 0 then
					local var_159_19 = manager.audio:GetVoiceLength("story_v_out_102021", "102021039", "story_v_out_102021.awb") / 1000

					if var_159_19 + var_159_11 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_19 + var_159_11
					end

					if var_159_14.prefab_name ~= "" and arg_156_1.actors_[var_159_14.prefab_name] ~= nil then
						local var_159_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_14.prefab_name].transform, "story_v_out_102021", "102021039", "story_v_out_102021.awb")

						arg_156_1:RecordAudio("102021039", var_159_20)
						arg_156_1:RecordAudio("102021039", var_159_20)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_102021", "102021039", "story_v_out_102021.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_102021", "102021039", "story_v_out_102021.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_21 = math.max(var_159_12, arg_156_1.talkMaxDuration)

			if var_159_11 <= arg_156_1.time_ and arg_156_1.time_ < var_159_11 + var_159_21 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_11) / var_159_21

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_11 + var_159_21 and arg_156_1.time_ < var_159_11 + var_159_21 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play102021040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 102021040
		arg_160_1.duration_ = 7.5

		local var_160_0 = {
			ja = 7,
			ko = 7.5,
			zh = 6.966,
			en = 7.333
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play102021041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_2")
			end

			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_163_2 = 0
			local var_163_3 = 0.725

			if var_163_2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_4 = arg_160_1:FormatText(StoryNameCfg[20].name)

				arg_160_1.leftNameTxt_.text = var_163_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_5 = arg_160_1:GetWordFromCfg(102021040)
				local var_163_6 = arg_160_1:FormatText(var_163_5.content)

				arg_160_1.text_.text = var_163_6

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_7 = 29
				local var_163_8 = utf8.len(var_163_6)
				local var_163_9 = var_163_7 <= 0 and var_163_3 or var_163_3 * (var_163_8 / var_163_7)

				if var_163_9 > 0 and var_163_3 < var_163_9 then
					arg_160_1.talkMaxDuration = var_163_9

					if var_163_9 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_9 + var_163_2
					end
				end

				arg_160_1.text_.text = var_163_6
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021040", "story_v_out_102021.awb") ~= 0 then
					local var_163_10 = manager.audio:GetVoiceLength("story_v_out_102021", "102021040", "story_v_out_102021.awb") / 1000

					if var_163_10 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_10 + var_163_2
					end

					if var_163_5.prefab_name ~= "" and arg_160_1.actors_[var_163_5.prefab_name] ~= nil then
						local var_163_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_5.prefab_name].transform, "story_v_out_102021", "102021040", "story_v_out_102021.awb")

						arg_160_1:RecordAudio("102021040", var_163_11)
						arg_160_1:RecordAudio("102021040", var_163_11)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_102021", "102021040", "story_v_out_102021.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_102021", "102021040", "story_v_out_102021.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_12 = math.max(var_163_3, arg_160_1.talkMaxDuration)

			if var_163_2 <= arg_160_1.time_ and arg_160_1.time_ < var_163_2 + var_163_12 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_2) / var_163_12

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_2 + var_163_12 and arg_160_1.time_ < var_163_2 + var_163_12 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play102021041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 102021041
		arg_164_1.duration_ = 13.2

		local var_164_0 = {
			ja = 12.5,
			ko = 11.666,
			zh = 13.2,
			en = 12.6
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play102021042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_167_1 = 0
			local var_167_2 = 1.475

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_3 = arg_164_1:FormatText(StoryNameCfg[20].name)

				arg_164_1.leftNameTxt_.text = var_167_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_4 = arg_164_1:GetWordFromCfg(102021041)
				local var_167_5 = arg_164_1:FormatText(var_167_4.content)

				arg_164_1.text_.text = var_167_5

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_6 = 58
				local var_167_7 = utf8.len(var_167_5)
				local var_167_8 = var_167_6 <= 0 and var_167_2 or var_167_2 * (var_167_7 / var_167_6)

				if var_167_8 > 0 and var_167_2 < var_167_8 then
					arg_164_1.talkMaxDuration = var_167_8

					if var_167_8 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_1
					end
				end

				arg_164_1.text_.text = var_167_5
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021041", "story_v_out_102021.awb") ~= 0 then
					local var_167_9 = manager.audio:GetVoiceLength("story_v_out_102021", "102021041", "story_v_out_102021.awb") / 1000

					if var_167_9 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_9 + var_167_1
					end

					if var_167_4.prefab_name ~= "" and arg_164_1.actors_[var_167_4.prefab_name] ~= nil then
						local var_167_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_4.prefab_name].transform, "story_v_out_102021", "102021041", "story_v_out_102021.awb")

						arg_164_1:RecordAudio("102021041", var_167_10)
						arg_164_1:RecordAudio("102021041", var_167_10)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_102021", "102021041", "story_v_out_102021.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_102021", "102021041", "story_v_out_102021.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_11 = math.max(var_167_2, arg_164_1.talkMaxDuration)

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_11 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_1) / var_167_11

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_1 + var_167_11 and arg_164_1.time_ < var_167_1 + var_167_11 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play102021042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 102021042
		arg_168_1.duration_ = 3.73

		local var_168_0 = {
			ja = 3.733,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play102021043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1084ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1084ui_story == nil then
				arg_168_1.var_.characterEffect1084ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.1

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1084ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1084ui_story then
				arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_171_4 = arg_168_1.actors_["3008ui_story"]
			local var_171_5 = 0

			if var_171_5 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 and not isNil(var_171_4) and arg_168_1.var_.characterEffect3008ui_story == nil then
				arg_168_1.var_.characterEffect3008ui_story = var_171_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_6 = 0.1

			if var_171_5 <= arg_168_1.time_ and arg_168_1.time_ < var_171_5 + var_171_6 and not isNil(var_171_4) then
				local var_171_7 = (arg_168_1.time_ - var_171_5) / var_171_6

				if arg_168_1.var_.characterEffect3008ui_story and not isNil(var_171_4) then
					local var_171_8 = Mathf.Lerp(0, 0.5, var_171_7)

					arg_168_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_168_1.var_.characterEffect3008ui_story.fillRatio = var_171_8
				end
			end

			if arg_168_1.time_ >= var_171_5 + var_171_6 and arg_168_1.time_ < var_171_5 + var_171_6 + arg_171_0 and not isNil(var_171_4) and arg_168_1.var_.characterEffect3008ui_story then
				local var_171_9 = 0.5

				arg_168_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_168_1.var_.characterEffect3008ui_story.fillRatio = var_171_9
			end

			local var_171_10 = 0

			if var_171_10 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 then
				arg_168_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4126")
			end

			local var_171_11 = 0

			if var_171_11 < arg_168_1.time_ and arg_168_1.time_ <= var_171_11 + arg_171_0 then
				arg_168_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_171_12 = 0
			local var_171_13 = 0.2

			if var_171_12 < arg_168_1.time_ and arg_168_1.time_ <= var_171_12 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_14 = arg_168_1:FormatText(StoryNameCfg[6].name)

				arg_168_1.leftNameTxt_.text = var_171_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_15 = arg_168_1:GetWordFromCfg(102021042)
				local var_171_16 = arg_168_1:FormatText(var_171_15.content)

				arg_168_1.text_.text = var_171_16

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_17 = 8
				local var_171_18 = utf8.len(var_171_16)
				local var_171_19 = var_171_17 <= 0 and var_171_13 or var_171_13 * (var_171_18 / var_171_17)

				if var_171_19 > 0 and var_171_13 < var_171_19 then
					arg_168_1.talkMaxDuration = var_171_19

					if var_171_19 + var_171_12 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_19 + var_171_12
					end
				end

				arg_168_1.text_.text = var_171_16
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021042", "story_v_out_102021.awb") ~= 0 then
					local var_171_20 = manager.audio:GetVoiceLength("story_v_out_102021", "102021042", "story_v_out_102021.awb") / 1000

					if var_171_20 + var_171_12 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_20 + var_171_12
					end

					if var_171_15.prefab_name ~= "" and arg_168_1.actors_[var_171_15.prefab_name] ~= nil then
						local var_171_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_15.prefab_name].transform, "story_v_out_102021", "102021042", "story_v_out_102021.awb")

						arg_168_1:RecordAudio("102021042", var_171_21)
						arg_168_1:RecordAudio("102021042", var_171_21)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_102021", "102021042", "story_v_out_102021.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_102021", "102021042", "story_v_out_102021.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_22 = math.max(var_171_13, arg_168_1.talkMaxDuration)

			if var_171_12 <= arg_168_1.time_ and arg_168_1.time_ < var_171_12 + var_171_22 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_12) / var_171_22

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_12 + var_171_22 and arg_168_1.time_ < var_171_12 + var_171_22 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play102021043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 102021043
		arg_172_1.duration_ = 2

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play102021044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["3008ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect3008ui_story == nil then
				arg_172_1.var_.characterEffect3008ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.1

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect3008ui_story and not isNil(var_175_0) then
					arg_172_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect3008ui_story then
				arg_172_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_175_4 = arg_172_1.actors_["1084ui_story"]
			local var_175_5 = 0

			if var_175_5 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 and not isNil(var_175_4) and arg_172_1.var_.characterEffect1084ui_story == nil then
				arg_172_1.var_.characterEffect1084ui_story = var_175_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_6 = 0.1

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_6 and not isNil(var_175_4) then
				local var_175_7 = (arg_172_1.time_ - var_175_5) / var_175_6

				if arg_172_1.var_.characterEffect1084ui_story and not isNil(var_175_4) then
					local var_175_8 = Mathf.Lerp(0, 0.5, var_175_7)

					arg_172_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1084ui_story.fillRatio = var_175_8
				end
			end

			if arg_172_1.time_ >= var_175_5 + var_175_6 and arg_172_1.time_ < var_175_5 + var_175_6 + arg_175_0 and not isNil(var_175_4) and arg_172_1.var_.characterEffect1084ui_story then
				local var_175_9 = 0.5

				arg_172_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1084ui_story.fillRatio = var_175_9
			end

			local var_175_10 = 0

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 then
				arg_172_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_175_11 = 0
			local var_175_12 = 0.125

			if var_175_11 < arg_172_1.time_ and arg_172_1.time_ <= var_175_11 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_13 = arg_172_1:FormatText(StoryNameCfg[20].name)

				arg_172_1.leftNameTxt_.text = var_175_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_14 = arg_172_1:GetWordFromCfg(102021043)
				local var_175_15 = arg_172_1:FormatText(var_175_14.content)

				arg_172_1.text_.text = var_175_15

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_16 = 5
				local var_175_17 = utf8.len(var_175_15)
				local var_175_18 = var_175_16 <= 0 and var_175_12 or var_175_12 * (var_175_17 / var_175_16)

				if var_175_18 > 0 and var_175_12 < var_175_18 then
					arg_172_1.talkMaxDuration = var_175_18

					if var_175_18 + var_175_11 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_18 + var_175_11
					end
				end

				arg_172_1.text_.text = var_175_15
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021043", "story_v_out_102021.awb") ~= 0 then
					local var_175_19 = manager.audio:GetVoiceLength("story_v_out_102021", "102021043", "story_v_out_102021.awb") / 1000

					if var_175_19 + var_175_11 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_19 + var_175_11
					end

					if var_175_14.prefab_name ~= "" and arg_172_1.actors_[var_175_14.prefab_name] ~= nil then
						local var_175_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_14.prefab_name].transform, "story_v_out_102021", "102021043", "story_v_out_102021.awb")

						arg_172_1:RecordAudio("102021043", var_175_20)
						arg_172_1:RecordAudio("102021043", var_175_20)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_102021", "102021043", "story_v_out_102021.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_102021", "102021043", "story_v_out_102021.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_21 = math.max(var_175_12, arg_172_1.talkMaxDuration)

			if var_175_11 <= arg_172_1.time_ and arg_172_1.time_ < var_175_11 + var_175_21 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_11) / var_175_21

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_11 + var_175_21 and arg_172_1.time_ < var_175_11 + var_175_21 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play102021044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 102021044
		arg_176_1.duration_ = 2.77

		local var_176_0 = {
			ja = 2.166,
			ko = 2.366,
			zh = 2.766,
			en = 2.233
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play102021045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["2020_tpose"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect2020_tpose == nil then
				arg_176_1.var_.characterEffect2020_tpose = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.1

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect2020_tpose and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect2020_tpose then
				arg_176_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_179_4 = arg_176_1.actors_["3008ui_story"]
			local var_179_5 = 0

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 and not isNil(var_179_4) and arg_176_1.var_.characterEffect3008ui_story == nil then
				arg_176_1.var_.characterEffect3008ui_story = var_179_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_6 = 0.1

			if var_179_5 <= arg_176_1.time_ and arg_176_1.time_ < var_179_5 + var_179_6 and not isNil(var_179_4) then
				local var_179_7 = (arg_176_1.time_ - var_179_5) / var_179_6

				if arg_176_1.var_.characterEffect3008ui_story and not isNil(var_179_4) then
					local var_179_8 = Mathf.Lerp(0, 0.5, var_179_7)

					arg_176_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_176_1.var_.characterEffect3008ui_story.fillRatio = var_179_8
				end
			end

			if arg_176_1.time_ >= var_179_5 + var_179_6 and arg_176_1.time_ < var_179_5 + var_179_6 + arg_179_0 and not isNil(var_179_4) and arg_176_1.var_.characterEffect3008ui_story then
				local var_179_9 = 0.5

				arg_176_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_176_1.var_.characterEffect3008ui_story.fillRatio = var_179_9
			end

			local var_179_10 = arg_176_1.actors_["1084ui_story"].transform
			local var_179_11 = 0

			if var_179_11 < arg_176_1.time_ and arg_176_1.time_ <= var_179_11 + arg_179_0 then
				arg_176_1.var_.moveOldPos1084ui_story = var_179_10.localPosition
			end

			local var_179_12 = 0.001

			if var_179_11 <= arg_176_1.time_ and arg_176_1.time_ < var_179_11 + var_179_12 then
				local var_179_13 = (arg_176_1.time_ - var_179_11) / var_179_12
				local var_179_14 = Vector3.New(0, 100, 0)

				var_179_10.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1084ui_story, var_179_14, var_179_13)

				local var_179_15 = manager.ui.mainCamera.transform.position - var_179_10.position

				var_179_10.forward = Vector3.New(var_179_15.x, var_179_15.y, var_179_15.z)

				local var_179_16 = var_179_10.localEulerAngles

				var_179_16.z = 0
				var_179_16.x = 0
				var_179_10.localEulerAngles = var_179_16
			end

			if arg_176_1.time_ >= var_179_11 + var_179_12 and arg_176_1.time_ < var_179_11 + var_179_12 + arg_179_0 then
				var_179_10.localPosition = Vector3.New(0, 100, 0)

				local var_179_17 = manager.ui.mainCamera.transform.position - var_179_10.position

				var_179_10.forward = Vector3.New(var_179_17.x, var_179_17.y, var_179_17.z)

				local var_179_18 = var_179_10.localEulerAngles

				var_179_18.z = 0
				var_179_18.x = 0
				var_179_10.localEulerAngles = var_179_18
			end

			local var_179_19 = arg_176_1.actors_["2020_tpose"].transform
			local var_179_20 = 0

			if var_179_20 < arg_176_1.time_ and arg_176_1.time_ <= var_179_20 + arg_179_0 then
				arg_176_1.var_.moveOldPos2020_tpose = var_179_19.localPosition

				local var_179_21 = GameObjectTools.GetOrAddComponent(var_179_19.gameObject, typeof(DynamicBoneHelper))

				if var_179_21 then
					var_179_21:EnableDynamicBone(false)
				end
			end

			local var_179_22 = 0.001

			if var_179_20 <= arg_176_1.time_ and arg_176_1.time_ < var_179_20 + var_179_22 then
				local var_179_23 = (arg_176_1.time_ - var_179_20) / var_179_22
				local var_179_24 = Vector3.New(-0.7, -1.2, -4.1)

				var_179_19.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos2020_tpose, var_179_24, var_179_23)

				local var_179_25 = manager.ui.mainCamera.transform.position - var_179_19.position

				var_179_19.forward = Vector3.New(var_179_25.x, var_179_25.y, var_179_25.z)

				local var_179_26 = var_179_19.localEulerAngles

				var_179_26.z = 0
				var_179_26.x = 0
				var_179_19.localEulerAngles = var_179_26
			end

			if arg_176_1.time_ >= var_179_20 + var_179_22 and arg_176_1.time_ < var_179_20 + var_179_22 + arg_179_0 then
				var_179_19.localPosition = Vector3.New(-0.7, -1.2, -4.1)

				local var_179_27 = manager.ui.mainCamera.transform.position - var_179_19.position

				var_179_19.forward = Vector3.New(var_179_27.x, var_179_27.y, var_179_27.z)

				local var_179_28 = var_179_19.localEulerAngles

				var_179_28.z = 0
				var_179_28.x = 0
				var_179_19.localEulerAngles = var_179_28

				local var_179_29 = GameObjectTools.GetOrAddComponent(var_179_19.gameObject, typeof(DynamicBoneHelper))

				if var_179_29 then
					var_179_29:EnableDynamicBone(true)
				end
			end

			local var_179_30 = 0

			if var_179_30 < arg_176_1.time_ and arg_176_1.time_ <= var_179_30 + arg_179_0 then
				arg_176_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_179_31 = 0
			local var_179_32 = 0.275

			if var_179_31 < arg_176_1.time_ and arg_176_1.time_ <= var_179_31 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_33 = arg_176_1:FormatText(StoryNameCfg[19].name)

				arg_176_1.leftNameTxt_.text = var_179_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_34 = arg_176_1:GetWordFromCfg(102021044)
				local var_179_35 = arg_176_1:FormatText(var_179_34.content)

				arg_176_1.text_.text = var_179_35

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_36 = 11
				local var_179_37 = utf8.len(var_179_35)
				local var_179_38 = var_179_36 <= 0 and var_179_32 or var_179_32 * (var_179_37 / var_179_36)

				if var_179_38 > 0 and var_179_32 < var_179_38 then
					arg_176_1.talkMaxDuration = var_179_38

					if var_179_38 + var_179_31 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_38 + var_179_31
					end
				end

				arg_176_1.text_.text = var_179_35
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021044", "story_v_out_102021.awb") ~= 0 then
					local var_179_39 = manager.audio:GetVoiceLength("story_v_out_102021", "102021044", "story_v_out_102021.awb") / 1000

					if var_179_39 + var_179_31 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_39 + var_179_31
					end

					if var_179_34.prefab_name ~= "" and arg_176_1.actors_[var_179_34.prefab_name] ~= nil then
						local var_179_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_34.prefab_name].transform, "story_v_out_102021", "102021044", "story_v_out_102021.awb")

						arg_176_1:RecordAudio("102021044", var_179_40)
						arg_176_1:RecordAudio("102021044", var_179_40)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_102021", "102021044", "story_v_out_102021.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_102021", "102021044", "story_v_out_102021.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_41 = math.max(var_179_32, arg_176_1.talkMaxDuration)

			if var_179_31 <= arg_176_1.time_ and arg_176_1.time_ < var_179_31 + var_179_41 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_31) / var_179_41

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_31 + var_179_41 and arg_176_1.time_ < var_179_31 + var_179_41 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play102021045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 102021045
		arg_180_1.duration_ = 6.77

		local var_180_0 = {
			ja = 5.9,
			ko = 5.566,
			zh = 6.2,
			en = 6.766
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play102021046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["3008ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect3008ui_story == nil then
				arg_180_1.var_.characterEffect3008ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.1

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect3008ui_story and not isNil(var_183_0) then
					arg_180_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect3008ui_story then
				arg_180_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_183_4 = arg_180_1.actors_["2020_tpose"]
			local var_183_5 = 0

			if var_183_5 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 and not isNil(var_183_4) and arg_180_1.var_.characterEffect2020_tpose == nil then
				arg_180_1.var_.characterEffect2020_tpose = var_183_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_6 = 0.1

			if var_183_5 <= arg_180_1.time_ and arg_180_1.time_ < var_183_5 + var_183_6 and not isNil(var_183_4) then
				local var_183_7 = (arg_180_1.time_ - var_183_5) / var_183_6

				if arg_180_1.var_.characterEffect2020_tpose and not isNil(var_183_4) then
					local var_183_8 = Mathf.Lerp(0, 0.5, var_183_7)

					arg_180_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_180_1.var_.characterEffect2020_tpose.fillRatio = var_183_8
				end
			end

			if arg_180_1.time_ >= var_183_5 + var_183_6 and arg_180_1.time_ < var_183_5 + var_183_6 + arg_183_0 and not isNil(var_183_4) and arg_180_1.var_.characterEffect2020_tpose then
				local var_183_9 = 0.5

				arg_180_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_180_1.var_.characterEffect2020_tpose.fillRatio = var_183_9
			end

			local var_183_10 = 0

			if var_183_10 < arg_180_1.time_ and arg_180_1.time_ <= var_183_10 + arg_183_0 then
				arg_180_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_183_11 = 0
			local var_183_12 = 0.775

			if var_183_11 < arg_180_1.time_ and arg_180_1.time_ <= var_183_11 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_13 = arg_180_1:FormatText(StoryNameCfg[20].name)

				arg_180_1.leftNameTxt_.text = var_183_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_14 = arg_180_1:GetWordFromCfg(102021045)
				local var_183_15 = arg_180_1:FormatText(var_183_14.content)

				arg_180_1.text_.text = var_183_15

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_16 = 31
				local var_183_17 = utf8.len(var_183_15)
				local var_183_18 = var_183_16 <= 0 and var_183_12 or var_183_12 * (var_183_17 / var_183_16)

				if var_183_18 > 0 and var_183_12 < var_183_18 then
					arg_180_1.talkMaxDuration = var_183_18

					if var_183_18 + var_183_11 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_18 + var_183_11
					end
				end

				arg_180_1.text_.text = var_183_15
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021045", "story_v_out_102021.awb") ~= 0 then
					local var_183_19 = manager.audio:GetVoiceLength("story_v_out_102021", "102021045", "story_v_out_102021.awb") / 1000

					if var_183_19 + var_183_11 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_19 + var_183_11
					end

					if var_183_14.prefab_name ~= "" and arg_180_1.actors_[var_183_14.prefab_name] ~= nil then
						local var_183_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_14.prefab_name].transform, "story_v_out_102021", "102021045", "story_v_out_102021.awb")

						arg_180_1:RecordAudio("102021045", var_183_20)
						arg_180_1:RecordAudio("102021045", var_183_20)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_102021", "102021045", "story_v_out_102021.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_102021", "102021045", "story_v_out_102021.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_21 = math.max(var_183_12, arg_180_1.talkMaxDuration)

			if var_183_11 <= arg_180_1.time_ and arg_180_1.time_ < var_183_11 + var_183_21 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_11) / var_183_21

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_11 + var_183_21 and arg_180_1.time_ < var_183_11 + var_183_21 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play102021046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 102021046
		arg_184_1.duration_ = 6.77

		local var_184_0 = {
			ja = 6.766,
			ko = 3.9,
			zh = 5.033,
			en = 4.566
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play102021047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1011ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1011ui_story == nil then
				arg_184_1.var_.characterEffect1011ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.1

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1011ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1011ui_story then
				arg_184_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_187_4 = arg_184_1.actors_["3008ui_story"]
			local var_187_5 = 0

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 and not isNil(var_187_4) and arg_184_1.var_.characterEffect3008ui_story == nil then
				arg_184_1.var_.characterEffect3008ui_story = var_187_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_6 = 0.1

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_6 and not isNil(var_187_4) then
				local var_187_7 = (arg_184_1.time_ - var_187_5) / var_187_6

				if arg_184_1.var_.characterEffect3008ui_story and not isNil(var_187_4) then
					local var_187_8 = Mathf.Lerp(0, 0.5, var_187_7)

					arg_184_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_184_1.var_.characterEffect3008ui_story.fillRatio = var_187_8
				end
			end

			if arg_184_1.time_ >= var_187_5 + var_187_6 and arg_184_1.time_ < var_187_5 + var_187_6 + arg_187_0 and not isNil(var_187_4) and arg_184_1.var_.characterEffect3008ui_story then
				local var_187_9 = 0.5

				arg_184_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_184_1.var_.characterEffect3008ui_story.fillRatio = var_187_9
			end

			local var_187_10 = arg_184_1.actors_["2020_tpose"].transform
			local var_187_11 = 0

			if var_187_11 < arg_184_1.time_ and arg_184_1.time_ <= var_187_11 + arg_187_0 then
				arg_184_1.var_.moveOldPos2020_tpose = var_187_10.localPosition

				local var_187_12 = GameObjectTools.GetOrAddComponent(var_187_10.gameObject, typeof(DynamicBoneHelper))

				if var_187_12 then
					var_187_12:EnableDynamicBone(false)
				end
			end

			local var_187_13 = 0.001

			if var_187_11 <= arg_184_1.time_ and arg_184_1.time_ < var_187_11 + var_187_13 then
				local var_187_14 = (arg_184_1.time_ - var_187_11) / var_187_13
				local var_187_15 = Vector3.New(0, 100, 0)

				var_187_10.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos2020_tpose, var_187_15, var_187_14)

				local var_187_16 = manager.ui.mainCamera.transform.position - var_187_10.position

				var_187_10.forward = Vector3.New(var_187_16.x, var_187_16.y, var_187_16.z)

				local var_187_17 = var_187_10.localEulerAngles

				var_187_17.z = 0
				var_187_17.x = 0
				var_187_10.localEulerAngles = var_187_17
			end

			if arg_184_1.time_ >= var_187_11 + var_187_13 and arg_184_1.time_ < var_187_11 + var_187_13 + arg_187_0 then
				var_187_10.localPosition = Vector3.New(0, 100, 0)

				local var_187_18 = manager.ui.mainCamera.transform.position - var_187_10.position

				var_187_10.forward = Vector3.New(var_187_18.x, var_187_18.y, var_187_18.z)

				local var_187_19 = var_187_10.localEulerAngles

				var_187_19.z = 0
				var_187_19.x = 0
				var_187_10.localEulerAngles = var_187_19

				local var_187_20 = GameObjectTools.GetOrAddComponent(var_187_10.gameObject, typeof(DynamicBoneHelper))

				if var_187_20 then
					var_187_20:EnableDynamicBone(true)
				end
			end

			local var_187_21 = arg_184_1.actors_["3008ui_story"].transform
			local var_187_22 = 0

			if var_187_22 < arg_184_1.time_ and arg_184_1.time_ <= var_187_22 + arg_187_0 then
				arg_184_1.var_.moveOldPos3008ui_story = var_187_21.localPosition
			end

			local var_187_23 = 0.001

			if var_187_22 <= arg_184_1.time_ and arg_184_1.time_ < var_187_22 + var_187_23 then
				local var_187_24 = (arg_184_1.time_ - var_187_22) / var_187_23
				local var_187_25 = Vector3.New(0, 100, 0)

				var_187_21.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos3008ui_story, var_187_25, var_187_24)

				local var_187_26 = manager.ui.mainCamera.transform.position - var_187_21.position

				var_187_21.forward = Vector3.New(var_187_26.x, var_187_26.y, var_187_26.z)

				local var_187_27 = var_187_21.localEulerAngles

				var_187_27.z = 0
				var_187_27.x = 0
				var_187_21.localEulerAngles = var_187_27
			end

			if arg_184_1.time_ >= var_187_22 + var_187_23 and arg_184_1.time_ < var_187_22 + var_187_23 + arg_187_0 then
				var_187_21.localPosition = Vector3.New(0, 100, 0)

				local var_187_28 = manager.ui.mainCamera.transform.position - var_187_21.position

				var_187_21.forward = Vector3.New(var_187_28.x, var_187_28.y, var_187_28.z)

				local var_187_29 = var_187_21.localEulerAngles

				var_187_29.z = 0
				var_187_29.x = 0
				var_187_21.localEulerAngles = var_187_29
			end

			local var_187_30 = arg_184_1.actors_["1011ui_story"].transform
			local var_187_31 = 0

			if var_187_31 < arg_184_1.time_ and arg_184_1.time_ <= var_187_31 + arg_187_0 then
				arg_184_1.var_.moveOldPos1011ui_story = var_187_30.localPosition
			end

			local var_187_32 = 0.001

			if var_187_31 <= arg_184_1.time_ and arg_184_1.time_ < var_187_31 + var_187_32 then
				local var_187_33 = (arg_184_1.time_ - var_187_31) / var_187_32
				local var_187_34 = Vector3.New(-0.7, -0.71, -6)

				var_187_30.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1011ui_story, var_187_34, var_187_33)

				local var_187_35 = manager.ui.mainCamera.transform.position - var_187_30.position

				var_187_30.forward = Vector3.New(var_187_35.x, var_187_35.y, var_187_35.z)

				local var_187_36 = var_187_30.localEulerAngles

				var_187_36.z = 0
				var_187_36.x = 0
				var_187_30.localEulerAngles = var_187_36
			end

			if arg_184_1.time_ >= var_187_31 + var_187_32 and arg_184_1.time_ < var_187_31 + var_187_32 + arg_187_0 then
				var_187_30.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_187_37 = manager.ui.mainCamera.transform.position - var_187_30.position

				var_187_30.forward = Vector3.New(var_187_37.x, var_187_37.y, var_187_37.z)

				local var_187_38 = var_187_30.localEulerAngles

				var_187_38.z = 0
				var_187_38.x = 0
				var_187_30.localEulerAngles = var_187_38
			end

			local var_187_39 = 0

			if var_187_39 < arg_184_1.time_ and arg_184_1.time_ <= var_187_39 + arg_187_0 then
				arg_184_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_187_40 = 0

			if var_187_40 < arg_184_1.time_ and arg_184_1.time_ <= var_187_40 + arg_187_0 then
				arg_184_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_187_41 = 0
			local var_187_42 = 0.4

			if var_187_41 < arg_184_1.time_ and arg_184_1.time_ <= var_187_41 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_43 = arg_184_1:FormatText(StoryNameCfg[37].name)

				arg_184_1.leftNameTxt_.text = var_187_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_44 = arg_184_1:GetWordFromCfg(102021046)
				local var_187_45 = arg_184_1:FormatText(var_187_44.content)

				arg_184_1.text_.text = var_187_45

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_46 = 16
				local var_187_47 = utf8.len(var_187_45)
				local var_187_48 = var_187_46 <= 0 and var_187_42 or var_187_42 * (var_187_47 / var_187_46)

				if var_187_48 > 0 and var_187_42 < var_187_48 then
					arg_184_1.talkMaxDuration = var_187_48

					if var_187_48 + var_187_41 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_48 + var_187_41
					end
				end

				arg_184_1.text_.text = var_187_45
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021046", "story_v_out_102021.awb") ~= 0 then
					local var_187_49 = manager.audio:GetVoiceLength("story_v_out_102021", "102021046", "story_v_out_102021.awb") / 1000

					if var_187_49 + var_187_41 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_49 + var_187_41
					end

					if var_187_44.prefab_name ~= "" and arg_184_1.actors_[var_187_44.prefab_name] ~= nil then
						local var_187_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_44.prefab_name].transform, "story_v_out_102021", "102021046", "story_v_out_102021.awb")

						arg_184_1:RecordAudio("102021046", var_187_50)
						arg_184_1:RecordAudio("102021046", var_187_50)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_102021", "102021046", "story_v_out_102021.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_102021", "102021046", "story_v_out_102021.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_51 = math.max(var_187_42, arg_184_1.talkMaxDuration)

			if var_187_41 <= arg_184_1.time_ and arg_184_1.time_ < var_187_41 + var_187_51 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_41) / var_187_51

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_41 + var_187_51 and arg_184_1.time_ < var_187_41 + var_187_51 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
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

		arg_184_1:InitPlayNodeList()
	end,
	Play102021047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 102021047
		arg_188_1.duration_ = 5.07

		local var_188_0 = {
			ja = 5.066,
			ko = 3.5,
			zh = 3.333,
			en = 4.266
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
			arg_188_1.auto_ = false
		end

		function arg_188_1.playNext_(arg_190_0)
			arg_188_1.onStoryFinished_()
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1019ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1019ui_story == nil then
				arg_188_1.var_.characterEffect1019ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.1

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect1019ui_story and not isNil(var_191_0) then
					arg_188_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1019ui_story then
				arg_188_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_191_4 = arg_188_1.actors_["1011ui_story"]
			local var_191_5 = 0

			if var_191_5 < arg_188_1.time_ and arg_188_1.time_ <= var_191_5 + arg_191_0 and not isNil(var_191_4) and arg_188_1.var_.characterEffect1011ui_story == nil then
				arg_188_1.var_.characterEffect1011ui_story = var_191_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_6 = 0.1

			if var_191_5 <= arg_188_1.time_ and arg_188_1.time_ < var_191_5 + var_191_6 and not isNil(var_191_4) then
				local var_191_7 = (arg_188_1.time_ - var_191_5) / var_191_6

				if arg_188_1.var_.characterEffect1011ui_story and not isNil(var_191_4) then
					local var_191_8 = Mathf.Lerp(0, 0.5, var_191_7)

					arg_188_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1011ui_story.fillRatio = var_191_8
				end
			end

			if arg_188_1.time_ >= var_191_5 + var_191_6 and arg_188_1.time_ < var_191_5 + var_191_6 + arg_191_0 and not isNil(var_191_4) and arg_188_1.var_.characterEffect1011ui_story then
				local var_191_9 = 0.5

				arg_188_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1011ui_story.fillRatio = var_191_9
			end

			local var_191_10 = arg_188_1.actors_["1019ui_story"].transform
			local var_191_11 = 0

			if var_191_11 < arg_188_1.time_ and arg_188_1.time_ <= var_191_11 + arg_191_0 then
				arg_188_1.var_.moveOldPos1019ui_story = var_191_10.localPosition
			end

			local var_191_12 = 0.001

			if var_191_11 <= arg_188_1.time_ and arg_188_1.time_ < var_191_11 + var_191_12 then
				local var_191_13 = (arg_188_1.time_ - var_191_11) / var_191_12
				local var_191_14 = Vector3.New(0.7, -1.08, -5.9)

				var_191_10.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1019ui_story, var_191_14, var_191_13)

				local var_191_15 = manager.ui.mainCamera.transform.position - var_191_10.position

				var_191_10.forward = Vector3.New(var_191_15.x, var_191_15.y, var_191_15.z)

				local var_191_16 = var_191_10.localEulerAngles

				var_191_16.z = 0
				var_191_16.x = 0
				var_191_10.localEulerAngles = var_191_16
			end

			if arg_188_1.time_ >= var_191_11 + var_191_12 and arg_188_1.time_ < var_191_11 + var_191_12 + arg_191_0 then
				var_191_10.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_191_17 = manager.ui.mainCamera.transform.position - var_191_10.position

				var_191_10.forward = Vector3.New(var_191_17.x, var_191_17.y, var_191_17.z)

				local var_191_18 = var_191_10.localEulerAngles

				var_191_18.z = 0
				var_191_18.x = 0
				var_191_10.localEulerAngles = var_191_18
			end

			local var_191_19 = 0

			if var_191_19 < arg_188_1.time_ and arg_188_1.time_ <= var_191_19 + arg_191_0 then
				arg_188_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			local var_191_20 = 0

			if var_191_20 < arg_188_1.time_ and arg_188_1.time_ <= var_191_20 + arg_191_0 then
				arg_188_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_191_21 = 0
			local var_191_22 = 0.375

			if var_191_21 < arg_188_1.time_ and arg_188_1.time_ <= var_191_21 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_23 = arg_188_1:FormatText(StoryNameCfg[13].name)

				arg_188_1.leftNameTxt_.text = var_191_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_24 = arg_188_1:GetWordFromCfg(102021047)
				local var_191_25 = arg_188_1:FormatText(var_191_24.content)

				arg_188_1.text_.text = var_191_25

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_26 = 14
				local var_191_27 = utf8.len(var_191_25)
				local var_191_28 = var_191_26 <= 0 and var_191_22 or var_191_22 * (var_191_27 / var_191_26)

				if var_191_28 > 0 and var_191_22 < var_191_28 then
					arg_188_1.talkMaxDuration = var_191_28

					if var_191_28 + var_191_21 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_28 + var_191_21
					end
				end

				arg_188_1.text_.text = var_191_25
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102021", "102021047", "story_v_out_102021.awb") ~= 0 then
					local var_191_29 = manager.audio:GetVoiceLength("story_v_out_102021", "102021047", "story_v_out_102021.awb") / 1000

					if var_191_29 + var_191_21 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_29 + var_191_21
					end

					if var_191_24.prefab_name ~= "" and arg_188_1.actors_[var_191_24.prefab_name] ~= nil then
						local var_191_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_24.prefab_name].transform, "story_v_out_102021", "102021047", "story_v_out_102021.awb")

						arg_188_1:RecordAudio("102021047", var_191_30)
						arg_188_1:RecordAudio("102021047", var_191_30)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_102021", "102021047", "story_v_out_102021.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_102021", "102021047", "story_v_out_102021.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_31 = math.max(var_191_22, arg_188_1.talkMaxDuration)

			if var_191_21 <= arg_188_1.time_ and arg_188_1.time_ < var_191_21 + var_191_31 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_21) / var_191_31

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_21 + var_191_31 and arg_188_1.time_ < var_191_21 + var_191_31 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
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

		arg_188_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B02f"
	},
	voices = {
		"story_v_out_102021.awb"
	}
}
