return {
	Play103071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103071001
		arg_1_1.duration_ = 5.57

		local var_1_0 = {
			ja = 5.1,
			ko = 4.8,
			zh = 4.566,
			en = 5.566
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
				arg_1_0:Play103071002(arg_1_1)
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

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_10 = 0
			local var_4_11 = 1

			if var_4_10 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				local var_4_12 = "play"
				local var_4_13 = "effect"

				arg_1_1:AudioAction(var_4_12, var_4_13, "se_story", "se_story_machinegun", "")
			end

			local var_4_14 = "1148ui_story"

			if arg_1_1.actors_[var_4_14] == nil then
				local var_4_15 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_4_15) then
					local var_4_16 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_1_1.stage_.transform)

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

			local var_4_19 = arg_1_1.actors_["1148ui_story"]
			local var_4_20 = 2

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 and not isNil(var_4_19) and arg_1_1.var_.characterEffect1148ui_story == nil then
				arg_1_1.var_.characterEffect1148ui_story = var_4_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_21 = 0.1

			if var_4_20 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 and not isNil(var_4_19) then
				local var_4_22 = (arg_1_1.time_ - var_4_20) / var_4_21

				if arg_1_1.var_.characterEffect1148ui_story and not isNil(var_4_19) then
					arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 and not isNil(var_4_19) and arg_1_1.var_.characterEffect1148ui_story then
				arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_4_23 = "B06b"

			if arg_1_1.bgs_[var_4_23] == nil then
				local var_4_24 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_24:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_23)
				var_4_24.name = var_4_23
				var_4_24.transform.parent = arg_1_1.stage_.transform
				var_4_24.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_23] = var_4_24
			end

			local var_4_25 = arg_1_1.bgs_.B06b
			local var_4_26 = 0

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_27 = var_4_25:GetComponent("SpriteRenderer")

				if var_4_27 then
					arg_1_1.var_.alphaOldValueB06b = var_4_27.color.a
					arg_1_1.var_.alphaMatValueB06b = var_4_27
				end

				arg_1_1.var_.alphaOldValueB06b = 0
			end

			local var_4_28 = 1.5

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_28 then
				local var_4_29 = (arg_1_1.time_ - var_4_26) / var_4_28
				local var_4_30 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB06b, 1, var_4_29)

				if arg_1_1.var_.alphaMatValueB06b then
					local var_4_31 = arg_1_1.var_.alphaMatValueB06b.color

					var_4_31.a = var_4_30
					arg_1_1.var_.alphaMatValueB06b.color = var_4_31
				end
			end

			if arg_1_1.time_ >= var_4_26 + var_4_28 and arg_1_1.time_ < var_4_26 + var_4_28 + arg_4_0 and arg_1_1.var_.alphaMatValueB06b then
				local var_4_32 = arg_1_1.var_.alphaMatValueB06b
				local var_4_33 = var_4_32.color

				var_4_33.a = 1
				var_4_32.color = var_4_33
			end

			local var_4_34 = 0

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_35 = manager.ui.mainCamera.transform.localPosition
				local var_4_36 = Vector3.New(0, 0, 10) + Vector3.New(var_4_35.x, var_4_35.y, 0)
				local var_4_37 = arg_1_1.bgs_.B06b

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
					if iter_4_0 ~= "B06b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_48 = arg_1_1.actors_["1148ui_story"].transform
			local var_4_49 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.var_.moveOldPos1148ui_story = var_4_48.localPosition
			end

			local var_4_50 = 0.001

			if var_4_49 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_50 then
				local var_4_51 = (arg_1_1.time_ - var_4_49) / var_4_50
				local var_4_52 = Vector3.New(0, -0.8, -6.2)

				var_4_48.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1148ui_story, var_4_52, var_4_51)

				local var_4_53 = manager.ui.mainCamera.transform.position - var_4_48.position

				var_4_48.forward = Vector3.New(var_4_53.x, var_4_53.y, var_4_53.z)

				local var_4_54 = var_4_48.localEulerAngles

				var_4_54.z = 0
				var_4_54.x = 0
				var_4_48.localEulerAngles = var_4_54
			end

			if arg_1_1.time_ >= var_4_49 + var_4_50 and arg_1_1.time_ < var_4_49 + var_4_50 + arg_4_0 then
				var_4_48.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_4_55 = manager.ui.mainCamera.transform.position - var_4_48.position

				var_4_48.forward = Vector3.New(var_4_55.x, var_4_55.y, var_4_55.z)

				local var_4_56 = var_4_48.localEulerAngles

				var_4_56.z = 0
				var_4_56.x = 0
				var_4_48.localEulerAngles = var_4_56
			end

			local var_4_57 = 1

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				arg_1_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_4_58 = 0

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_59 = 2

			if arg_1_1.time_ >= var_4_58 + var_4_59 and arg_1_1.time_ < var_4_58 + var_4_59 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_60 = 0

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				arg_1_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_61 = 2
			local var_4_62 = 0.3

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_63 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_63:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[8].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(103071001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 12
				local var_4_68 = utf8.len(var_4_66)
				local var_4_69 = var_4_67 <= 0 and var_4_62 or var_4_62 * (var_4_68 / var_4_67)

				if var_4_69 > 0 and var_4_62 < var_4_69 then
					arg_1_1.talkMaxDuration = var_4_69
					var_4_61 = var_4_61 + 0.3

					if var_4_69 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_61
					end
				end

				arg_1_1.text_.text = var_4_66
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071001", "story_v_out_103071.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_103071", "103071001", "story_v_out_103071.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_103071", "103071001", "story_v_out_103071.awb")

						arg_1_1:RecordAudio("103071001", var_4_71)
						arg_1_1:RecordAudio("103071001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_103071", "103071001", "story_v_out_103071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_103071", "103071001", "story_v_out_103071.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_72 = var_4_61 + 0.3
			local var_4_73 = math.max(var_4_62, arg_1_1.talkMaxDuration)

			if var_4_72 <= arg_1_1.time_ and arg_1_1.time_ < var_4_72 + var_4_73 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_72) / var_4_73

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_72 + var_4_73 and arg_1_1.time_ < var_4_72 + var_4_73 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play103071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 103071002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play103071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1148ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1148ui_story == nil then
				arg_8_1.var_.characterEffect1148ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.1

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect1148ui_story and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1148ui_story.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1148ui_story then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1148ui_story.fillRatio = var_11_5
			end

			local var_11_6 = arg_8_1.actors_["1148ui_story"].transform
			local var_11_7 = 0

			if var_11_7 < arg_8_1.time_ and arg_8_1.time_ <= var_11_7 + arg_11_0 then
				arg_8_1.var_.moveOldPos1148ui_story = var_11_6.localPosition
			end

			local var_11_8 = 0.001

			if var_11_7 <= arg_8_1.time_ and arg_8_1.time_ < var_11_7 + var_11_8 then
				local var_11_9 = (arg_8_1.time_ - var_11_7) / var_11_8
				local var_11_10 = Vector3.New(0, 100, 0)

				var_11_6.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1148ui_story, var_11_10, var_11_9)

				local var_11_11 = manager.ui.mainCamera.transform.position - var_11_6.position

				var_11_6.forward = Vector3.New(var_11_11.x, var_11_11.y, var_11_11.z)

				local var_11_12 = var_11_6.localEulerAngles

				var_11_12.z = 0
				var_11_12.x = 0
				var_11_6.localEulerAngles = var_11_12
			end

			if arg_8_1.time_ >= var_11_7 + var_11_8 and arg_8_1.time_ < var_11_7 + var_11_8 + arg_11_0 then
				var_11_6.localPosition = Vector3.New(0, 100, 0)

				local var_11_13 = manager.ui.mainCamera.transform.position - var_11_6.position

				var_11_6.forward = Vector3.New(var_11_13.x, var_11_13.y, var_11_13.z)

				local var_11_14 = var_11_6.localEulerAngles

				var_11_14.z = 0
				var_11_14.x = 0
				var_11_6.localEulerAngles = var_11_14
			end

			local var_11_15 = 0
			local var_11_16 = 0.85

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_17 = arg_8_1:GetWordFromCfg(103071002)
				local var_11_18 = arg_8_1:FormatText(var_11_17.content)

				arg_8_1.text_.text = var_11_18

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_19 = 34
				local var_11_20 = utf8.len(var_11_18)
				local var_11_21 = var_11_19 <= 0 and var_11_16 or var_11_16 * (var_11_20 / var_11_19)

				if var_11_21 > 0 and var_11_16 < var_11_21 then
					arg_8_1.talkMaxDuration = var_11_21

					if var_11_21 + var_11_15 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_21 + var_11_15
					end
				end

				arg_8_1.text_.text = var_11_18
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_22 = math.max(var_11_16, arg_8_1.talkMaxDuration)

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_22 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_15) / var_11_22

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_15 + var_11_22 and arg_8_1.time_ < var_11_15 + var_11_22 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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
	Play103071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 103071003
		arg_12_1.duration_ = 4.9

		local var_12_0 = {
			ja = 4.4,
			ko = 4.9,
			zh = 3.9,
			en = 4.166
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
				arg_12_0:Play103071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1059ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["1059ui_story"]
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1059ui_story == nil then
				arg_12_1.var_.characterEffect1059ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.1

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 and not isNil(var_15_5) then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7

				if arg_12_1.var_.characterEffect1059ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1059ui_story then
				arg_12_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_15_9 = 0

			if var_15_9 < arg_12_1.time_ and arg_12_1.time_ <= var_15_9 + arg_15_0 then
				arg_12_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			local var_15_10 = arg_12_1.actors_["1059ui_story"].transform
			local var_15_11 = 0

			if var_15_11 < arg_12_1.time_ and arg_12_1.time_ <= var_15_11 + arg_15_0 then
				arg_12_1.var_.moveOldPos1059ui_story = var_15_10.localPosition
			end

			local var_15_12 = 0.001

			if var_15_11 <= arg_12_1.time_ and arg_12_1.time_ < var_15_11 + var_15_12 then
				local var_15_13 = (arg_12_1.time_ - var_15_11) / var_15_12
				local var_15_14 = Vector3.New(-0.7, -1.05, -6)

				var_15_10.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1059ui_story, var_15_14, var_15_13)

				local var_15_15 = manager.ui.mainCamera.transform.position - var_15_10.position

				var_15_10.forward = Vector3.New(var_15_15.x, var_15_15.y, var_15_15.z)

				local var_15_16 = var_15_10.localEulerAngles

				var_15_16.z = 0
				var_15_16.x = 0
				var_15_10.localEulerAngles = var_15_16
			end

			if arg_12_1.time_ >= var_15_11 + var_15_12 and arg_12_1.time_ < var_15_11 + var_15_12 + arg_15_0 then
				var_15_10.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_15_17 = manager.ui.mainCamera.transform.position - var_15_10.position

				var_15_10.forward = Vector3.New(var_15_17.x, var_15_17.y, var_15_17.z)

				local var_15_18 = var_15_10.localEulerAngles

				var_15_18.z = 0
				var_15_18.x = 0
				var_15_10.localEulerAngles = var_15_18
			end

			local var_15_19 = 0

			if var_15_19 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 then
				arg_12_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_15_20 = 0
			local var_15_21 = 0.525

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_22 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_22:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_23 = arg_12_1:FormatText(StoryNameCfg[28].name)

				arg_12_1.leftNameTxt_.text = var_15_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_24 = arg_12_1:GetWordFromCfg(103071003)
				local var_15_25 = arg_12_1:FormatText(var_15_24.content)

				arg_12_1.text_.text = var_15_25

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_26 = 21
				local var_15_27 = utf8.len(var_15_25)
				local var_15_28 = var_15_26 <= 0 and var_15_21 or var_15_21 * (var_15_27 / var_15_26)

				if var_15_28 > 0 and var_15_21 < var_15_28 then
					arg_12_1.talkMaxDuration = var_15_28
					var_15_20 = var_15_20 + 0.3

					if var_15_28 + var_15_20 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_28 + var_15_20
					end
				end

				arg_12_1.text_.text = var_15_25
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071003", "story_v_out_103071.awb") ~= 0 then
					local var_15_29 = manager.audio:GetVoiceLength("story_v_out_103071", "103071003", "story_v_out_103071.awb") / 1000

					if var_15_29 + var_15_20 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_29 + var_15_20
					end

					if var_15_24.prefab_name ~= "" and arg_12_1.actors_[var_15_24.prefab_name] ~= nil then
						local var_15_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_24.prefab_name].transform, "story_v_out_103071", "103071003", "story_v_out_103071.awb")

						arg_12_1:RecordAudio("103071003", var_15_30)
						arg_12_1:RecordAudio("103071003", var_15_30)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_103071", "103071003", "story_v_out_103071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_103071", "103071003", "story_v_out_103071.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_31 = var_15_20 + 0.3
			local var_15_32 = math.max(var_15_21, arg_12_1.talkMaxDuration)

			if var_15_31 <= arg_12_1.time_ and arg_12_1.time_ < var_15_31 + var_15_32 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_31) / var_15_32

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_31 + var_15_32 and arg_12_1.time_ < var_15_31 + var_15_32 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
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
	Play103071004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 103071004
		arg_18_1.duration_ = 4.7

		local var_18_0 = {
			ja = 3.666,
			ko = 3.166,
			zh = 3.033,
			en = 4.7
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play103071005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["1148ui_story"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.characterEffect1148ui_story == nil then
				arg_18_1.var_.characterEffect1148ui_story = var_21_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_2 = 0.1

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.characterEffect1148ui_story and not isNil(var_21_0) then
					arg_18_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.characterEffect1148ui_story then
				arg_18_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_21_4 = arg_18_1.actors_["1059ui_story"]
			local var_21_5 = 0

			if var_21_5 < arg_18_1.time_ and arg_18_1.time_ <= var_21_5 + arg_21_0 and not isNil(var_21_4) and arg_18_1.var_.characterEffect1059ui_story == nil then
				arg_18_1.var_.characterEffect1059ui_story = var_21_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_6 = 0.1

			if var_21_5 <= arg_18_1.time_ and arg_18_1.time_ < var_21_5 + var_21_6 and not isNil(var_21_4) then
				local var_21_7 = (arg_18_1.time_ - var_21_5) / var_21_6

				if arg_18_1.var_.characterEffect1059ui_story and not isNil(var_21_4) then
					local var_21_8 = Mathf.Lerp(0, 0.5, var_21_7)

					arg_18_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_18_1.var_.characterEffect1059ui_story.fillRatio = var_21_8
				end
			end

			if arg_18_1.time_ >= var_21_5 + var_21_6 and arg_18_1.time_ < var_21_5 + var_21_6 + arg_21_0 and not isNil(var_21_4) and arg_18_1.var_.characterEffect1059ui_story then
				local var_21_9 = 0.5

				arg_18_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_18_1.var_.characterEffect1059ui_story.fillRatio = var_21_9
			end

			local var_21_10 = arg_18_1.actors_["1148ui_story"].transform
			local var_21_11 = 0

			if var_21_11 < arg_18_1.time_ and arg_18_1.time_ <= var_21_11 + arg_21_0 then
				arg_18_1.var_.moveOldPos1148ui_story = var_21_10.localPosition
			end

			local var_21_12 = 0.001

			if var_21_11 <= arg_18_1.time_ and arg_18_1.time_ < var_21_11 + var_21_12 then
				local var_21_13 = (arg_18_1.time_ - var_21_11) / var_21_12
				local var_21_14 = Vector3.New(0.7, -0.8, -6.2)

				var_21_10.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1148ui_story, var_21_14, var_21_13)

				local var_21_15 = manager.ui.mainCamera.transform.position - var_21_10.position

				var_21_10.forward = Vector3.New(var_21_15.x, var_21_15.y, var_21_15.z)

				local var_21_16 = var_21_10.localEulerAngles

				var_21_16.z = 0
				var_21_16.x = 0
				var_21_10.localEulerAngles = var_21_16
			end

			if arg_18_1.time_ >= var_21_11 + var_21_12 and arg_18_1.time_ < var_21_11 + var_21_12 + arg_21_0 then
				var_21_10.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_21_17 = manager.ui.mainCamera.transform.position - var_21_10.position

				var_21_10.forward = Vector3.New(var_21_17.x, var_21_17.y, var_21_17.z)

				local var_21_18 = var_21_10.localEulerAngles

				var_21_18.z = 0
				var_21_18.x = 0
				var_21_10.localEulerAngles = var_21_18
			end

			local var_21_19 = 0

			if var_21_19 < arg_18_1.time_ and arg_18_1.time_ <= var_21_19 + arg_21_0 then
				arg_18_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_21_20 = 0

			if var_21_20 < arg_18_1.time_ and arg_18_1.time_ <= var_21_20 + arg_21_0 then
				arg_18_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_21_21 = 0
			local var_21_22 = 0.325

			if var_21_21 < arg_18_1.time_ and arg_18_1.time_ <= var_21_21 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_23 = arg_18_1:FormatText(StoryNameCfg[8].name)

				arg_18_1.leftNameTxt_.text = var_21_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_24 = arg_18_1:GetWordFromCfg(103071004)
				local var_21_25 = arg_18_1:FormatText(var_21_24.content)

				arg_18_1.text_.text = var_21_25

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_26 = 13
				local var_21_27 = utf8.len(var_21_25)
				local var_21_28 = var_21_26 <= 0 and var_21_22 or var_21_22 * (var_21_27 / var_21_26)

				if var_21_28 > 0 and var_21_22 < var_21_28 then
					arg_18_1.talkMaxDuration = var_21_28

					if var_21_28 + var_21_21 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_28 + var_21_21
					end
				end

				arg_18_1.text_.text = var_21_25
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071004", "story_v_out_103071.awb") ~= 0 then
					local var_21_29 = manager.audio:GetVoiceLength("story_v_out_103071", "103071004", "story_v_out_103071.awb") / 1000

					if var_21_29 + var_21_21 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_29 + var_21_21
					end

					if var_21_24.prefab_name ~= "" and arg_18_1.actors_[var_21_24.prefab_name] ~= nil then
						local var_21_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_24.prefab_name].transform, "story_v_out_103071", "103071004", "story_v_out_103071.awb")

						arg_18_1:RecordAudio("103071004", var_21_30)
						arg_18_1:RecordAudio("103071004", var_21_30)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_103071", "103071004", "story_v_out_103071.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_103071", "103071004", "story_v_out_103071.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_31 = math.max(var_21_22, arg_18_1.talkMaxDuration)

			if var_21_21 <= arg_18_1.time_ and arg_18_1.time_ < var_21_21 + var_21_31 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_21) / var_21_31

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_21 + var_21_31 and arg_18_1.time_ < var_21_21 + var_21_31 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play103071005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 103071005
		arg_22_1.duration_ = 5.07

		local var_22_0 = {
			ja = 5.066,
			ko = 2.6,
			zh = 2.866,
			en = 2.733
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
				arg_22_0:Play103071006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1059ui_story"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1059ui_story == nil then
				arg_22_1.var_.characterEffect1059ui_story = var_25_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_2 = 0.1

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.characterEffect1059ui_story and not isNil(var_25_0) then
					arg_22_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1059ui_story then
				arg_22_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_25_4 = arg_22_1.actors_["1148ui_story"]
			local var_25_5 = 0

			if var_25_5 < arg_22_1.time_ and arg_22_1.time_ <= var_25_5 + arg_25_0 and not isNil(var_25_4) and arg_22_1.var_.characterEffect1148ui_story == nil then
				arg_22_1.var_.characterEffect1148ui_story = var_25_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_6 = 0.1

			if var_25_5 <= arg_22_1.time_ and arg_22_1.time_ < var_25_5 + var_25_6 and not isNil(var_25_4) then
				local var_25_7 = (arg_22_1.time_ - var_25_5) / var_25_6

				if arg_22_1.var_.characterEffect1148ui_story and not isNil(var_25_4) then
					local var_25_8 = Mathf.Lerp(0, 0.5, var_25_7)

					arg_22_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_22_1.var_.characterEffect1148ui_story.fillRatio = var_25_8
				end
			end

			if arg_22_1.time_ >= var_25_5 + var_25_6 and arg_22_1.time_ < var_25_5 + var_25_6 + arg_25_0 and not isNil(var_25_4) and arg_22_1.var_.characterEffect1148ui_story then
				local var_25_9 = 0.5

				arg_22_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_22_1.var_.characterEffect1148ui_story.fillRatio = var_25_9
			end

			local var_25_10 = 0

			if var_25_10 < arg_22_1.time_ and arg_22_1.time_ <= var_25_10 + arg_25_0 then
				arg_22_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action424")
			end

			local var_25_11 = 0

			if var_25_11 < arg_22_1.time_ and arg_22_1.time_ <= var_25_11 + arg_25_0 then
				arg_22_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_25_12 = 0
			local var_25_13 = 0.275

			if var_25_12 < arg_22_1.time_ and arg_22_1.time_ <= var_25_12 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_14 = arg_22_1:FormatText(StoryNameCfg[28].name)

				arg_22_1.leftNameTxt_.text = var_25_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_15 = arg_22_1:GetWordFromCfg(103071005)
				local var_25_16 = arg_22_1:FormatText(var_25_15.content)

				arg_22_1.text_.text = var_25_16

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_17 = 11
				local var_25_18 = utf8.len(var_25_16)
				local var_25_19 = var_25_17 <= 0 and var_25_13 or var_25_13 * (var_25_18 / var_25_17)

				if var_25_19 > 0 and var_25_13 < var_25_19 then
					arg_22_1.talkMaxDuration = var_25_19

					if var_25_19 + var_25_12 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_19 + var_25_12
					end
				end

				arg_22_1.text_.text = var_25_16
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071005", "story_v_out_103071.awb") ~= 0 then
					local var_25_20 = manager.audio:GetVoiceLength("story_v_out_103071", "103071005", "story_v_out_103071.awb") / 1000

					if var_25_20 + var_25_12 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_20 + var_25_12
					end

					if var_25_15.prefab_name ~= "" and arg_22_1.actors_[var_25_15.prefab_name] ~= nil then
						local var_25_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_15.prefab_name].transform, "story_v_out_103071", "103071005", "story_v_out_103071.awb")

						arg_22_1:RecordAudio("103071005", var_25_21)
						arg_22_1:RecordAudio("103071005", var_25_21)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_103071", "103071005", "story_v_out_103071.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_103071", "103071005", "story_v_out_103071.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_22 = math.max(var_25_13, arg_22_1.talkMaxDuration)

			if var_25_12 <= arg_22_1.time_ and arg_22_1.time_ < var_25_12 + var_25_22 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_12) / var_25_22

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_12 + var_25_22 and arg_22_1.time_ < var_25_12 + var_25_22 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play103071006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 103071006
		arg_26_1.duration_ = 6.47

		local var_26_0 = {
			ja = 6.466,
			ko = 3.366,
			zh = 3,
			en = 3.9
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
				arg_26_0:Play103071007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["1148ui_story"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1148ui_story == nil then
				arg_26_1.var_.characterEffect1148ui_story = var_29_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.1

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.characterEffect1148ui_story and not isNil(var_29_0) then
					arg_26_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1148ui_story then
				arg_26_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_29_4 = arg_26_1.actors_["1059ui_story"]
			local var_29_5 = 0

			if var_29_5 < arg_26_1.time_ and arg_26_1.time_ <= var_29_5 + arg_29_0 and not isNil(var_29_4) and arg_26_1.var_.characterEffect1059ui_story == nil then
				arg_26_1.var_.characterEffect1059ui_story = var_29_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_6 = 0.1

			if var_29_5 <= arg_26_1.time_ and arg_26_1.time_ < var_29_5 + var_29_6 and not isNil(var_29_4) then
				local var_29_7 = (arg_26_1.time_ - var_29_5) / var_29_6

				if arg_26_1.var_.characterEffect1059ui_story and not isNil(var_29_4) then
					local var_29_8 = Mathf.Lerp(0, 0.5, var_29_7)

					arg_26_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_26_1.var_.characterEffect1059ui_story.fillRatio = var_29_8
				end
			end

			if arg_26_1.time_ >= var_29_5 + var_29_6 and arg_26_1.time_ < var_29_5 + var_29_6 + arg_29_0 and not isNil(var_29_4) and arg_26_1.var_.characterEffect1059ui_story then
				local var_29_9 = 0.5

				arg_26_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_26_1.var_.characterEffect1059ui_story.fillRatio = var_29_9
			end

			local var_29_10 = 0

			if var_29_10 < arg_26_1.time_ and arg_26_1.time_ <= var_29_10 + arg_29_0 then
				arg_26_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action454")
			end

			local var_29_11 = 0

			if var_29_11 < arg_26_1.time_ and arg_26_1.time_ <= var_29_11 + arg_29_0 then
				arg_26_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_29_12 = 0
			local var_29_13 = 0.375

			if var_29_12 < arg_26_1.time_ and arg_26_1.time_ <= var_29_12 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_14 = arg_26_1:FormatText(StoryNameCfg[8].name)

				arg_26_1.leftNameTxt_.text = var_29_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_15 = arg_26_1:GetWordFromCfg(103071006)
				local var_29_16 = arg_26_1:FormatText(var_29_15.content)

				arg_26_1.text_.text = var_29_16

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_17 = 15
				local var_29_18 = utf8.len(var_29_16)
				local var_29_19 = var_29_17 <= 0 and var_29_13 or var_29_13 * (var_29_18 / var_29_17)

				if var_29_19 > 0 and var_29_13 < var_29_19 then
					arg_26_1.talkMaxDuration = var_29_19

					if var_29_19 + var_29_12 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_19 + var_29_12
					end
				end

				arg_26_1.text_.text = var_29_16
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071006", "story_v_out_103071.awb") ~= 0 then
					local var_29_20 = manager.audio:GetVoiceLength("story_v_out_103071", "103071006", "story_v_out_103071.awb") / 1000

					if var_29_20 + var_29_12 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_20 + var_29_12
					end

					if var_29_15.prefab_name ~= "" and arg_26_1.actors_[var_29_15.prefab_name] ~= nil then
						local var_29_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_15.prefab_name].transform, "story_v_out_103071", "103071006", "story_v_out_103071.awb")

						arg_26_1:RecordAudio("103071006", var_29_21)
						arg_26_1:RecordAudio("103071006", var_29_21)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_103071", "103071006", "story_v_out_103071.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_103071", "103071006", "story_v_out_103071.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_22 = math.max(var_29_13, arg_26_1.talkMaxDuration)

			if var_29_12 <= arg_26_1.time_ and arg_26_1.time_ < var_29_12 + var_29_22 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_12) / var_29_22

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_12 + var_29_22 and arg_26_1.time_ < var_29_12 + var_29_22 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play103071007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 103071007
		arg_30_1.duration_ = 5.17

		local var_30_0 = {
			ja = 5.166,
			ko = 3.366,
			zh = 3.433,
			en = 4.566
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
				arg_30_0:Play103071008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 1

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				local var_33_2 = "play"
				local var_33_3 = "effect"

				arg_30_1:AudioAction(var_33_2, var_33_3, "se_story_3", "se_story_3_shoot", "")
			end

			local var_33_4 = 0

			if var_33_4 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_33_5 = 0

			if var_33_5 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 then
				arg_30_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_33_6 = 0
			local var_33_7 = 0.325

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_8 = arg_30_1:FormatText(StoryNameCfg[8].name)

				arg_30_1.leftNameTxt_.text = var_33_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_9 = arg_30_1:GetWordFromCfg(103071007)
				local var_33_10 = arg_30_1:FormatText(var_33_9.content)

				arg_30_1.text_.text = var_33_10

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_11 = 12
				local var_33_12 = utf8.len(var_33_10)
				local var_33_13 = var_33_11 <= 0 and var_33_7 or var_33_7 * (var_33_12 / var_33_11)

				if var_33_13 > 0 and var_33_7 < var_33_13 then
					arg_30_1.talkMaxDuration = var_33_13

					if var_33_13 + var_33_6 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_13 + var_33_6
					end
				end

				arg_30_1.text_.text = var_33_10
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071007", "story_v_out_103071.awb") ~= 0 then
					local var_33_14 = manager.audio:GetVoiceLength("story_v_out_103071", "103071007", "story_v_out_103071.awb") / 1000

					if var_33_14 + var_33_6 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_14 + var_33_6
					end

					if var_33_9.prefab_name ~= "" and arg_30_1.actors_[var_33_9.prefab_name] ~= nil then
						local var_33_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_9.prefab_name].transform, "story_v_out_103071", "103071007", "story_v_out_103071.awb")

						arg_30_1:RecordAudio("103071007", var_33_15)
						arg_30_1:RecordAudio("103071007", var_33_15)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_103071", "103071007", "story_v_out_103071.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_103071", "103071007", "story_v_out_103071.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_16 = math.max(var_33_7, arg_30_1.talkMaxDuration)

			if var_33_6 <= arg_30_1.time_ and arg_30_1.time_ < var_33_6 + var_33_16 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_6) / var_33_16

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_6 + var_33_16 and arg_30_1.time_ < var_33_6 + var_33_16 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play103071008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 103071008
		arg_34_1.duration_ = 2.23

		local var_34_0 = {
			ja = 2.233,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_34_0:Play103071009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = manager.ui.mainCamera.transform
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.var_.shakeOldPosMainCamera = var_37_0.localPosition
			end

			local var_37_2 = 0.600000023841858

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / 0.066
				local var_37_4, var_37_5 = math.modf(var_37_3)

				var_37_0.localPosition = Vector3.New(var_37_5 * 0.13, var_37_5 * 0.13, var_37_5 * 0.13) + arg_34_1.var_.shakeOldPosMainCamera
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 then
				var_37_0.localPosition = arg_34_1.var_.shakeOldPosMainCamera
			end

			local var_37_6 = "1035ui_story"

			if arg_34_1.actors_[var_37_6] == nil then
				local var_37_7 = Asset.Load("Char/" .. "1035ui_story")

				if not isNil(var_37_7) then
					local var_37_8 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_34_1.stage_.transform)

					var_37_8.name = var_37_6
					var_37_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_34_1.actors_[var_37_6] = var_37_8

					local var_37_9 = var_37_8:GetComponentInChildren(typeof(CharacterEffect))

					var_37_9.enabled = true

					local var_37_10 = GameObjectTools.GetOrAddComponent(var_37_8, typeof(DynamicBoneHelper))

					if var_37_10 then
						var_37_10:EnableDynamicBone(false)
					end

					arg_34_1:ShowWeapon(var_37_9.transform, false)

					arg_34_1.var_[var_37_6 .. "Animator"] = var_37_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_34_1.var_[var_37_6 .. "Animator"].applyRootMotion = true
					arg_34_1.var_[var_37_6 .. "LipSync"] = var_37_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_37_11 = 0

			if var_37_11 < arg_34_1.time_ and arg_34_1.time_ <= var_37_11 + arg_37_0 then
				arg_34_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action3_1")
			end

			local var_37_12 = arg_34_1.actors_["1035ui_story"].transform
			local var_37_13 = 0

			if var_37_13 < arg_34_1.time_ and arg_34_1.time_ <= var_37_13 + arg_37_0 then
				arg_34_1.var_.moveOldPos1035ui_story = var_37_12.localPosition
			end

			local var_37_14 = 0.001

			if var_37_13 <= arg_34_1.time_ and arg_34_1.time_ < var_37_13 + var_37_14 then
				local var_37_15 = (arg_34_1.time_ - var_37_13) / var_37_14
				local var_37_16 = Vector3.New(0, -1.05, -5.6)

				var_37_12.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1035ui_story, var_37_16, var_37_15)

				local var_37_17 = manager.ui.mainCamera.transform.position - var_37_12.position

				var_37_12.forward = Vector3.New(var_37_17.x, var_37_17.y, var_37_17.z)

				local var_37_18 = var_37_12.localEulerAngles

				var_37_18.z = 0
				var_37_18.x = 0
				var_37_12.localEulerAngles = var_37_18
			end

			if arg_34_1.time_ >= var_37_13 + var_37_14 and arg_34_1.time_ < var_37_13 + var_37_14 + arg_37_0 then
				var_37_12.localPosition = Vector3.New(0, -1.05, -5.6)

				local var_37_19 = manager.ui.mainCamera.transform.position - var_37_12.position

				var_37_12.forward = Vector3.New(var_37_19.x, var_37_19.y, var_37_19.z)

				local var_37_20 = var_37_12.localEulerAngles

				var_37_20.z = 0
				var_37_20.x = 0
				var_37_12.localEulerAngles = var_37_20
			end

			local var_37_21 = arg_34_1.actors_["1148ui_story"].transform
			local var_37_22 = 0

			if var_37_22 < arg_34_1.time_ and arg_34_1.time_ <= var_37_22 + arg_37_0 then
				arg_34_1.var_.moveOldPos1148ui_story = var_37_21.localPosition
			end

			local var_37_23 = 0.001

			if var_37_22 <= arg_34_1.time_ and arg_34_1.time_ < var_37_22 + var_37_23 then
				local var_37_24 = (arg_34_1.time_ - var_37_22) / var_37_23
				local var_37_25 = Vector3.New(0, 100, 0)

				var_37_21.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1148ui_story, var_37_25, var_37_24)

				local var_37_26 = manager.ui.mainCamera.transform.position - var_37_21.position

				var_37_21.forward = Vector3.New(var_37_26.x, var_37_26.y, var_37_26.z)

				local var_37_27 = var_37_21.localEulerAngles

				var_37_27.z = 0
				var_37_27.x = 0
				var_37_21.localEulerAngles = var_37_27
			end

			if arg_34_1.time_ >= var_37_22 + var_37_23 and arg_34_1.time_ < var_37_22 + var_37_23 + arg_37_0 then
				var_37_21.localPosition = Vector3.New(0, 100, 0)

				local var_37_28 = manager.ui.mainCamera.transform.position - var_37_21.position

				var_37_21.forward = Vector3.New(var_37_28.x, var_37_28.y, var_37_28.z)

				local var_37_29 = var_37_21.localEulerAngles

				var_37_29.z = 0
				var_37_29.x = 0
				var_37_21.localEulerAngles = var_37_29
			end

			local var_37_30 = arg_34_1.actors_["1059ui_story"].transform
			local var_37_31 = 0

			if var_37_31 < arg_34_1.time_ and arg_34_1.time_ <= var_37_31 + arg_37_0 then
				arg_34_1.var_.moveOldPos1059ui_story = var_37_30.localPosition
			end

			local var_37_32 = 0.001

			if var_37_31 <= arg_34_1.time_ and arg_34_1.time_ < var_37_31 + var_37_32 then
				local var_37_33 = (arg_34_1.time_ - var_37_31) / var_37_32
				local var_37_34 = Vector3.New(0, 100, 0)

				var_37_30.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1059ui_story, var_37_34, var_37_33)

				local var_37_35 = manager.ui.mainCamera.transform.position - var_37_30.position

				var_37_30.forward = Vector3.New(var_37_35.x, var_37_35.y, var_37_35.z)

				local var_37_36 = var_37_30.localEulerAngles

				var_37_36.z = 0
				var_37_36.x = 0
				var_37_30.localEulerAngles = var_37_36
			end

			if arg_34_1.time_ >= var_37_31 + var_37_32 and arg_34_1.time_ < var_37_31 + var_37_32 + arg_37_0 then
				var_37_30.localPosition = Vector3.New(0, 100, 0)

				local var_37_37 = manager.ui.mainCamera.transform.position - var_37_30.position

				var_37_30.forward = Vector3.New(var_37_37.x, var_37_37.y, var_37_37.z)

				local var_37_38 = var_37_30.localEulerAngles

				var_37_38.z = 0
				var_37_38.x = 0
				var_37_30.localEulerAngles = var_37_38
			end

			local var_37_39 = arg_34_1.actors_["1035ui_story"]
			local var_37_40 = 0

			if var_37_40 < arg_34_1.time_ and arg_34_1.time_ <= var_37_40 + arg_37_0 and not isNil(var_37_39) and arg_34_1.var_.characterEffect1035ui_story == nil then
				arg_34_1.var_.characterEffect1035ui_story = var_37_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_41 = 0.2

			if var_37_40 <= arg_34_1.time_ and arg_34_1.time_ < var_37_40 + var_37_41 and not isNil(var_37_39) then
				local var_37_42 = (arg_34_1.time_ - var_37_40) / var_37_41

				if arg_34_1.var_.characterEffect1035ui_story and not isNil(var_37_39) then
					arg_34_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_40 + var_37_41 and arg_34_1.time_ < var_37_40 + var_37_41 + arg_37_0 and not isNil(var_37_39) and arg_34_1.var_.characterEffect1035ui_story then
				arg_34_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_37_43 = 0
			local var_37_44 = 0.125

			if var_37_43 < arg_34_1.time_ and arg_34_1.time_ <= var_37_43 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_45 = arg_34_1:FormatText(StoryNameCfg[21].name)

				arg_34_1.leftNameTxt_.text = var_37_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_46 = arg_34_1:GetWordFromCfg(103071008)
				local var_37_47 = arg_34_1:FormatText(var_37_46.content)

				arg_34_1.text_.text = var_37_47

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_48 = 5
				local var_37_49 = utf8.len(var_37_47)
				local var_37_50 = var_37_48 <= 0 and var_37_44 or var_37_44 * (var_37_49 / var_37_48)

				if var_37_50 > 0 and var_37_44 < var_37_50 then
					arg_34_1.talkMaxDuration = var_37_50

					if var_37_50 + var_37_43 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_50 + var_37_43
					end
				end

				arg_34_1.text_.text = var_37_47
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071008", "story_v_out_103071.awb") ~= 0 then
					local var_37_51 = manager.audio:GetVoiceLength("story_v_out_103071", "103071008", "story_v_out_103071.awb") / 1000

					if var_37_51 + var_37_43 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_51 + var_37_43
					end

					if var_37_46.prefab_name ~= "" and arg_34_1.actors_[var_37_46.prefab_name] ~= nil then
						local var_37_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_46.prefab_name].transform, "story_v_out_103071", "103071008", "story_v_out_103071.awb")

						arg_34_1:RecordAudio("103071008", var_37_52)
						arg_34_1:RecordAudio("103071008", var_37_52)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_103071", "103071008", "story_v_out_103071.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_103071", "103071008", "story_v_out_103071.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_53 = math.max(var_37_44, arg_34_1.talkMaxDuration)

			if var_37_43 <= arg_34_1.time_ and arg_34_1.time_ < var_37_43 + var_37_53 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_43) / var_37_53

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_43 + var_37_53 and arg_34_1.time_ < var_37_43 + var_37_53 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play103071009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 103071009
		arg_38_1.duration_ = 10.47

		local var_38_0 = {
			ja = 10.466,
			ko = 7.933,
			zh = 7.266,
			en = 9.7
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
				arg_38_0:Play103071010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1148ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1148ui_story == nil then
				arg_38_1.var_.characterEffect1148ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.1

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect1148ui_story and not isNil(var_41_0) then
					arg_38_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1148ui_story then
				arg_38_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_41_4 = 0

			if var_41_4 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action465")
			end

			local var_41_5 = arg_38_1.actors_["1035ui_story"].transform
			local var_41_6 = 0

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.var_.moveOldPos1035ui_story = var_41_5.localPosition
			end

			local var_41_7 = 0.001

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_7 then
				local var_41_8 = (arg_38_1.time_ - var_41_6) / var_41_7
				local var_41_9 = Vector3.New(0, 100, 0)

				var_41_5.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1035ui_story, var_41_9, var_41_8)

				local var_41_10 = manager.ui.mainCamera.transform.position - var_41_5.position

				var_41_5.forward = Vector3.New(var_41_10.x, var_41_10.y, var_41_10.z)

				local var_41_11 = var_41_5.localEulerAngles

				var_41_11.z = 0
				var_41_11.x = 0
				var_41_5.localEulerAngles = var_41_11
			end

			if arg_38_1.time_ >= var_41_6 + var_41_7 and arg_38_1.time_ < var_41_6 + var_41_7 + arg_41_0 then
				var_41_5.localPosition = Vector3.New(0, 100, 0)

				local var_41_12 = manager.ui.mainCamera.transform.position - var_41_5.position

				var_41_5.forward = Vector3.New(var_41_12.x, var_41_12.y, var_41_12.z)

				local var_41_13 = var_41_5.localEulerAngles

				var_41_13.z = 0
				var_41_13.x = 0
				var_41_5.localEulerAngles = var_41_13
			end

			local var_41_14 = arg_38_1.actors_["1148ui_story"].transform
			local var_41_15 = 0

			if var_41_15 < arg_38_1.time_ and arg_38_1.time_ <= var_41_15 + arg_41_0 then
				arg_38_1.var_.moveOldPos1148ui_story = var_41_14.localPosition
			end

			local var_41_16 = 0.001

			if var_41_15 <= arg_38_1.time_ and arg_38_1.time_ < var_41_15 + var_41_16 then
				local var_41_17 = (arg_38_1.time_ - var_41_15) / var_41_16
				local var_41_18 = Vector3.New(0, -0.8, -6.2)

				var_41_14.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1148ui_story, var_41_18, var_41_17)

				local var_41_19 = manager.ui.mainCamera.transform.position - var_41_14.position

				var_41_14.forward = Vector3.New(var_41_19.x, var_41_19.y, var_41_19.z)

				local var_41_20 = var_41_14.localEulerAngles

				var_41_20.z = 0
				var_41_20.x = 0
				var_41_14.localEulerAngles = var_41_20
			end

			if arg_38_1.time_ >= var_41_15 + var_41_16 and arg_38_1.time_ < var_41_15 + var_41_16 + arg_41_0 then
				var_41_14.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_41_21 = manager.ui.mainCamera.transform.position - var_41_14.position

				var_41_14.forward = Vector3.New(var_41_21.x, var_41_21.y, var_41_21.z)

				local var_41_22 = var_41_14.localEulerAngles

				var_41_22.z = 0
				var_41_22.x = 0
				var_41_14.localEulerAngles = var_41_22
			end

			local var_41_23 = 0

			if var_41_23 < arg_38_1.time_ and arg_38_1.time_ <= var_41_23 + arg_41_0 then
				arg_38_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_41_24 = 0
			local var_41_25 = 0.875

			if var_41_24 < arg_38_1.time_ and arg_38_1.time_ <= var_41_24 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_26 = arg_38_1:FormatText(StoryNameCfg[8].name)

				arg_38_1.leftNameTxt_.text = var_41_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_27 = arg_38_1:GetWordFromCfg(103071009)
				local var_41_28 = arg_38_1:FormatText(var_41_27.content)

				arg_38_1.text_.text = var_41_28

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_29 = 35
				local var_41_30 = utf8.len(var_41_28)
				local var_41_31 = var_41_29 <= 0 and var_41_25 or var_41_25 * (var_41_30 / var_41_29)

				if var_41_31 > 0 and var_41_25 < var_41_31 then
					arg_38_1.talkMaxDuration = var_41_31

					if var_41_31 + var_41_24 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_31 + var_41_24
					end
				end

				arg_38_1.text_.text = var_41_28
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071009", "story_v_out_103071.awb") ~= 0 then
					local var_41_32 = manager.audio:GetVoiceLength("story_v_out_103071", "103071009", "story_v_out_103071.awb") / 1000

					if var_41_32 + var_41_24 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_32 + var_41_24
					end

					if var_41_27.prefab_name ~= "" and arg_38_1.actors_[var_41_27.prefab_name] ~= nil then
						local var_41_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_27.prefab_name].transform, "story_v_out_103071", "103071009", "story_v_out_103071.awb")

						arg_38_1:RecordAudio("103071009", var_41_33)
						arg_38_1:RecordAudio("103071009", var_41_33)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_103071", "103071009", "story_v_out_103071.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_103071", "103071009", "story_v_out_103071.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_34 = math.max(var_41_25, arg_38_1.talkMaxDuration)

			if var_41_24 <= arg_38_1.time_ and arg_38_1.time_ < var_41_24 + var_41_34 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_24) / var_41_34

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_24 + var_41_34 and arg_38_1.time_ < var_41_24 + var_41_34 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play103071010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 103071010
		arg_42_1.duration_ = 9.83

		local var_42_0 = {
			ja = 9.833,
			ko = 6.566,
			zh = 6.1,
			en = 7.866
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
				arg_42_0:Play103071011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action457")
			end

			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_45_2 = 0
			local var_45_3 = 0.575

			if var_45_2 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_4 = arg_42_1:FormatText(StoryNameCfg[8].name)

				arg_42_1.leftNameTxt_.text = var_45_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_5 = arg_42_1:GetWordFromCfg(103071010)
				local var_45_6 = arg_42_1:FormatText(var_45_5.content)

				arg_42_1.text_.text = var_45_6

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_7 = 24
				local var_45_8 = utf8.len(var_45_6)
				local var_45_9 = var_45_7 <= 0 and var_45_3 or var_45_3 * (var_45_8 / var_45_7)

				if var_45_9 > 0 and var_45_3 < var_45_9 then
					arg_42_1.talkMaxDuration = var_45_9

					if var_45_9 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_9 + var_45_2
					end
				end

				arg_42_1.text_.text = var_45_6
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071010", "story_v_out_103071.awb") ~= 0 then
					local var_45_10 = manager.audio:GetVoiceLength("story_v_out_103071", "103071010", "story_v_out_103071.awb") / 1000

					if var_45_10 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_10 + var_45_2
					end

					if var_45_5.prefab_name ~= "" and arg_42_1.actors_[var_45_5.prefab_name] ~= nil then
						local var_45_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_5.prefab_name].transform, "story_v_out_103071", "103071010", "story_v_out_103071.awb")

						arg_42_1:RecordAudio("103071010", var_45_11)
						arg_42_1:RecordAudio("103071010", var_45_11)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_103071", "103071010", "story_v_out_103071.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_103071", "103071010", "story_v_out_103071.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_12 = math.max(var_45_3, arg_42_1.talkMaxDuration)

			if var_45_2 <= arg_42_1.time_ and arg_42_1.time_ < var_45_2 + var_45_12 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_2) / var_45_12

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_2 + var_45_12 and arg_42_1.time_ < var_45_2 + var_45_12 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play103071011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 103071011
		arg_46_1.duration_ = 4.37

		local var_46_0 = {
			ja = 3.966,
			ko = 4.166,
			zh = 3.233,
			en = 4.366
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
				arg_46_0:Play103071012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1035ui_story"].transform
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.var_.moveOldPos1035ui_story = var_49_0.localPosition
			end

			local var_49_2 = 0.001

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2
				local var_49_4 = Vector3.New(0, -1.05, -5.6)

				var_49_0.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1035ui_story, var_49_4, var_49_3)

				local var_49_5 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_5.x, var_49_5.y, var_49_5.z)

				local var_49_6 = var_49_0.localEulerAngles

				var_49_6.z = 0
				var_49_6.x = 0
				var_49_0.localEulerAngles = var_49_6
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 then
				var_49_0.localPosition = Vector3.New(0, -1.05, -5.6)

				local var_49_7 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_7.x, var_49_7.y, var_49_7.z)

				local var_49_8 = var_49_0.localEulerAngles

				var_49_8.z = 0
				var_49_8.x = 0
				var_49_0.localEulerAngles = var_49_8
			end

			local var_49_9 = arg_46_1.actors_["1148ui_story"].transform
			local var_49_10 = 0

			if var_49_10 < arg_46_1.time_ and arg_46_1.time_ <= var_49_10 + arg_49_0 then
				arg_46_1.var_.moveOldPos1148ui_story = var_49_9.localPosition
			end

			local var_49_11 = 0.001

			if var_49_10 <= arg_46_1.time_ and arg_46_1.time_ < var_49_10 + var_49_11 then
				local var_49_12 = (arg_46_1.time_ - var_49_10) / var_49_11
				local var_49_13 = Vector3.New(0, 100, 0)

				var_49_9.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1148ui_story, var_49_13, var_49_12)

				local var_49_14 = manager.ui.mainCamera.transform.position - var_49_9.position

				var_49_9.forward = Vector3.New(var_49_14.x, var_49_14.y, var_49_14.z)

				local var_49_15 = var_49_9.localEulerAngles

				var_49_15.z = 0
				var_49_15.x = 0
				var_49_9.localEulerAngles = var_49_15
			end

			if arg_46_1.time_ >= var_49_10 + var_49_11 and arg_46_1.time_ < var_49_10 + var_49_11 + arg_49_0 then
				var_49_9.localPosition = Vector3.New(0, 100, 0)

				local var_49_16 = manager.ui.mainCamera.transform.position - var_49_9.position

				var_49_9.forward = Vector3.New(var_49_16.x, var_49_16.y, var_49_16.z)

				local var_49_17 = var_49_9.localEulerAngles

				var_49_17.z = 0
				var_49_17.x = 0
				var_49_9.localEulerAngles = var_49_17
			end

			local var_49_18 = 0

			if var_49_18 < arg_46_1.time_ and arg_46_1.time_ <= var_49_18 + arg_49_0 then
				arg_46_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action6_1")
			end

			local var_49_19 = 0
			local var_49_20 = 0.375

			if var_49_19 < arg_46_1.time_ and arg_46_1.time_ <= var_49_19 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_21 = arg_46_1:FormatText(StoryNameCfg[21].name)

				arg_46_1.leftNameTxt_.text = var_49_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_22 = arg_46_1:GetWordFromCfg(103071011)
				local var_49_23 = arg_46_1:FormatText(var_49_22.content)

				arg_46_1.text_.text = var_49_23

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_24 = 15
				local var_49_25 = utf8.len(var_49_23)
				local var_49_26 = var_49_24 <= 0 and var_49_20 or var_49_20 * (var_49_25 / var_49_24)

				if var_49_26 > 0 and var_49_20 < var_49_26 then
					arg_46_1.talkMaxDuration = var_49_26

					if var_49_26 + var_49_19 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_26 + var_49_19
					end
				end

				arg_46_1.text_.text = var_49_23
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071011", "story_v_out_103071.awb") ~= 0 then
					local var_49_27 = manager.audio:GetVoiceLength("story_v_out_103071", "103071011", "story_v_out_103071.awb") / 1000

					if var_49_27 + var_49_19 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_27 + var_49_19
					end

					if var_49_22.prefab_name ~= "" and arg_46_1.actors_[var_49_22.prefab_name] ~= nil then
						local var_49_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_22.prefab_name].transform, "story_v_out_103071", "103071011", "story_v_out_103071.awb")

						arg_46_1:RecordAudio("103071011", var_49_28)
						arg_46_1:RecordAudio("103071011", var_49_28)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_103071", "103071011", "story_v_out_103071.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_103071", "103071011", "story_v_out_103071.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_29 = math.max(var_49_20, arg_46_1.talkMaxDuration)

			if var_49_19 <= arg_46_1.time_ and arg_46_1.time_ < var_49_19 + var_49_29 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_19) / var_49_29

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_19 + var_49_29 and arg_46_1.time_ < var_49_19 + var_49_29 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play103071012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 103071012
		arg_50_1.duration_ = 4.07

		local var_50_0 = {
			ja = 3,
			ko = 3,
			zh = 2.333,
			en = 4.066
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
				arg_50_0:Play103071013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1148ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1148ui_story == nil then
				arg_50_1.var_.characterEffect1148ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.1

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect1148ui_story and not isNil(var_53_0) then
					arg_50_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1148ui_story then
				arg_50_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_53_4 = 0

			if var_53_4 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action472")
			end

			local var_53_5 = arg_50_1.actors_["1035ui_story"].transform
			local var_53_6 = 0

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.var_.moveOldPos1035ui_story = var_53_5.localPosition
			end

			local var_53_7 = 0.001

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_7 then
				local var_53_8 = (arg_50_1.time_ - var_53_6) / var_53_7
				local var_53_9 = Vector3.New(0, 100, 0)

				var_53_5.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1035ui_story, var_53_9, var_53_8)

				local var_53_10 = manager.ui.mainCamera.transform.position - var_53_5.position

				var_53_5.forward = Vector3.New(var_53_10.x, var_53_10.y, var_53_10.z)

				local var_53_11 = var_53_5.localEulerAngles

				var_53_11.z = 0
				var_53_11.x = 0
				var_53_5.localEulerAngles = var_53_11
			end

			if arg_50_1.time_ >= var_53_6 + var_53_7 and arg_50_1.time_ < var_53_6 + var_53_7 + arg_53_0 then
				var_53_5.localPosition = Vector3.New(0, 100, 0)

				local var_53_12 = manager.ui.mainCamera.transform.position - var_53_5.position

				var_53_5.forward = Vector3.New(var_53_12.x, var_53_12.y, var_53_12.z)

				local var_53_13 = var_53_5.localEulerAngles

				var_53_13.z = 0
				var_53_13.x = 0
				var_53_5.localEulerAngles = var_53_13
			end

			local var_53_14 = arg_50_1.actors_["1148ui_story"].transform
			local var_53_15 = 0

			if var_53_15 < arg_50_1.time_ and arg_50_1.time_ <= var_53_15 + arg_53_0 then
				arg_50_1.var_.moveOldPos1148ui_story = var_53_14.localPosition
			end

			local var_53_16 = 0.001

			if var_53_15 <= arg_50_1.time_ and arg_50_1.time_ < var_53_15 + var_53_16 then
				local var_53_17 = (arg_50_1.time_ - var_53_15) / var_53_16
				local var_53_18 = Vector3.New(0, -0.8, -6.2)

				var_53_14.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1148ui_story, var_53_18, var_53_17)

				local var_53_19 = manager.ui.mainCamera.transform.position - var_53_14.position

				var_53_14.forward = Vector3.New(var_53_19.x, var_53_19.y, var_53_19.z)

				local var_53_20 = var_53_14.localEulerAngles

				var_53_20.z = 0
				var_53_20.x = 0
				var_53_14.localEulerAngles = var_53_20
			end

			if arg_50_1.time_ >= var_53_15 + var_53_16 and arg_50_1.time_ < var_53_15 + var_53_16 + arg_53_0 then
				var_53_14.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_53_21 = manager.ui.mainCamera.transform.position - var_53_14.position

				var_53_14.forward = Vector3.New(var_53_21.x, var_53_21.y, var_53_21.z)

				local var_53_22 = var_53_14.localEulerAngles

				var_53_22.z = 0
				var_53_22.x = 0
				var_53_14.localEulerAngles = var_53_22
			end

			local var_53_23 = 0

			if var_53_23 < arg_50_1.time_ and arg_50_1.time_ <= var_53_23 + arg_53_0 then
				arg_50_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_53_24 = 0
			local var_53_25 = 0.225

			if var_53_24 < arg_50_1.time_ and arg_50_1.time_ <= var_53_24 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_26 = arg_50_1:FormatText(StoryNameCfg[8].name)

				arg_50_1.leftNameTxt_.text = var_53_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_27 = arg_50_1:GetWordFromCfg(103071012)
				local var_53_28 = arg_50_1:FormatText(var_53_27.content)

				arg_50_1.text_.text = var_53_28

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_29 = 9
				local var_53_30 = utf8.len(var_53_28)
				local var_53_31 = var_53_29 <= 0 and var_53_25 or var_53_25 * (var_53_30 / var_53_29)

				if var_53_31 > 0 and var_53_25 < var_53_31 then
					arg_50_1.talkMaxDuration = var_53_31

					if var_53_31 + var_53_24 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_31 + var_53_24
					end
				end

				arg_50_1.text_.text = var_53_28
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071012", "story_v_out_103071.awb") ~= 0 then
					local var_53_32 = manager.audio:GetVoiceLength("story_v_out_103071", "103071012", "story_v_out_103071.awb") / 1000

					if var_53_32 + var_53_24 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_32 + var_53_24
					end

					if var_53_27.prefab_name ~= "" and arg_50_1.actors_[var_53_27.prefab_name] ~= nil then
						local var_53_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_27.prefab_name].transform, "story_v_out_103071", "103071012", "story_v_out_103071.awb")

						arg_50_1:RecordAudio("103071012", var_53_33)
						arg_50_1:RecordAudio("103071012", var_53_33)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_103071", "103071012", "story_v_out_103071.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_103071", "103071012", "story_v_out_103071.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_34 = math.max(var_53_25, arg_50_1.talkMaxDuration)

			if var_53_24 <= arg_50_1.time_ and arg_50_1.time_ < var_53_24 + var_53_34 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_24) / var_53_34

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_24 + var_53_34 and arg_50_1.time_ < var_53_24 + var_53_34 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play103071013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 103071013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play103071014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1148ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1148ui_story == nil then
				arg_54_1.var_.characterEffect1148ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.1

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1148ui_story and not isNil(var_57_0) then
					local var_57_4 = Mathf.Lerp(0, 0.5, var_57_3)

					arg_54_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1148ui_story.fillRatio = var_57_4
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1148ui_story then
				local var_57_5 = 0.5

				arg_54_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1148ui_story.fillRatio = var_57_5
			end

			local var_57_6 = arg_54_1.actors_["1148ui_story"].transform
			local var_57_7 = 0

			if var_57_7 < arg_54_1.time_ and arg_54_1.time_ <= var_57_7 + arg_57_0 then
				arg_54_1.var_.moveOldPos1148ui_story = var_57_6.localPosition
			end

			local var_57_8 = 0.001

			if var_57_7 <= arg_54_1.time_ and arg_54_1.time_ < var_57_7 + var_57_8 then
				local var_57_9 = (arg_54_1.time_ - var_57_7) / var_57_8
				local var_57_10 = Vector3.New(0, 100, 0)

				var_57_6.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1148ui_story, var_57_10, var_57_9)

				local var_57_11 = manager.ui.mainCamera.transform.position - var_57_6.position

				var_57_6.forward = Vector3.New(var_57_11.x, var_57_11.y, var_57_11.z)

				local var_57_12 = var_57_6.localEulerAngles

				var_57_12.z = 0
				var_57_12.x = 0
				var_57_6.localEulerAngles = var_57_12
			end

			if arg_54_1.time_ >= var_57_7 + var_57_8 and arg_54_1.time_ < var_57_7 + var_57_8 + arg_57_0 then
				var_57_6.localPosition = Vector3.New(0, 100, 0)

				local var_57_13 = manager.ui.mainCamera.transform.position - var_57_6.position

				var_57_6.forward = Vector3.New(var_57_13.x, var_57_13.y, var_57_13.z)

				local var_57_14 = var_57_6.localEulerAngles

				var_57_14.z = 0
				var_57_14.x = 0
				var_57_6.localEulerAngles = var_57_14
			end

			local var_57_15 = 0
			local var_57_16 = 0.625

			if var_57_15 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_17 = arg_54_1:GetWordFromCfg(103071013)
				local var_57_18 = arg_54_1:FormatText(var_57_17.content)

				arg_54_1.text_.text = var_57_18

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_19 = 25
				local var_57_20 = utf8.len(var_57_18)
				local var_57_21 = var_57_19 <= 0 and var_57_16 or var_57_16 * (var_57_20 / var_57_19)

				if var_57_21 > 0 and var_57_16 < var_57_21 then
					arg_54_1.talkMaxDuration = var_57_21

					if var_57_21 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_21 + var_57_15
					end
				end

				arg_54_1.text_.text = var_57_18
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_22 = math.max(var_57_16, arg_54_1.talkMaxDuration)

			if var_57_15 <= arg_54_1.time_ and arg_54_1.time_ < var_57_15 + var_57_22 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_15) / var_57_22

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_15 + var_57_22 and arg_54_1.time_ < var_57_15 + var_57_22 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play103071014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 103071014
		arg_58_1.duration_ = 4.4

		local var_58_0 = {
			ja = 4.4,
			ko = 2.866,
			zh = 3.166,
			en = 3.9
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
				arg_58_0:Play103071015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action4_1")
			end

			local var_61_1 = arg_58_1.actors_["1035ui_story"].transform
			local var_61_2 = 0

			if var_61_2 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.var_.moveOldPos1035ui_story = var_61_1.localPosition
			end

			local var_61_3 = 0.001

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_3 then
				local var_61_4 = (arg_58_1.time_ - var_61_2) / var_61_3
				local var_61_5 = Vector3.New(0, -1.05, -5.6)

				var_61_1.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1035ui_story, var_61_5, var_61_4)

				local var_61_6 = manager.ui.mainCamera.transform.position - var_61_1.position

				var_61_1.forward = Vector3.New(var_61_6.x, var_61_6.y, var_61_6.z)

				local var_61_7 = var_61_1.localEulerAngles

				var_61_7.z = 0
				var_61_7.x = 0
				var_61_1.localEulerAngles = var_61_7
			end

			if arg_58_1.time_ >= var_61_2 + var_61_3 and arg_58_1.time_ < var_61_2 + var_61_3 + arg_61_0 then
				var_61_1.localPosition = Vector3.New(0, -1.05, -5.6)

				local var_61_8 = manager.ui.mainCamera.transform.position - var_61_1.position

				var_61_1.forward = Vector3.New(var_61_8.x, var_61_8.y, var_61_8.z)

				local var_61_9 = var_61_1.localEulerAngles

				var_61_9.z = 0
				var_61_9.x = 0
				var_61_1.localEulerAngles = var_61_9
			end

			local var_61_10 = 0
			local var_61_11 = 0.175

			if var_61_10 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_12 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_12:setOnUpdate(LuaHelper.FloatAction(function(arg_62_0)
					arg_58_1.dialogCg_.alpha = arg_62_0
				end))
				var_61_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_13 = arg_58_1:FormatText(StoryNameCfg[21].name)

				arg_58_1.leftNameTxt_.text = var_61_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_14 = arg_58_1:GetWordFromCfg(103071014)
				local var_61_15 = arg_58_1:FormatText(var_61_14.content)

				arg_58_1.text_.text = var_61_15

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_16 = 7
				local var_61_17 = utf8.len(var_61_15)
				local var_61_18 = var_61_16 <= 0 and var_61_11 or var_61_11 * (var_61_17 / var_61_16)

				if var_61_18 > 0 and var_61_11 < var_61_18 then
					arg_58_1.talkMaxDuration = var_61_18
					var_61_10 = var_61_10 + 0.3

					if var_61_18 + var_61_10 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_18 + var_61_10
					end
				end

				arg_58_1.text_.text = var_61_15
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071014", "story_v_out_103071.awb") ~= 0 then
					local var_61_19 = manager.audio:GetVoiceLength("story_v_out_103071", "103071014", "story_v_out_103071.awb") / 1000

					if var_61_19 + var_61_10 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_19 + var_61_10
					end

					if var_61_14.prefab_name ~= "" and arg_58_1.actors_[var_61_14.prefab_name] ~= nil then
						local var_61_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_14.prefab_name].transform, "story_v_out_103071", "103071014", "story_v_out_103071.awb")

						arg_58_1:RecordAudio("103071014", var_61_20)
						arg_58_1:RecordAudio("103071014", var_61_20)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_103071", "103071014", "story_v_out_103071.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_103071", "103071014", "story_v_out_103071.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_21 = var_61_10 + 0.3
			local var_61_22 = math.max(var_61_11, arg_58_1.talkMaxDuration)

			if var_61_21 <= arg_58_1.time_ and arg_58_1.time_ < var_61_21 + var_61_22 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_21) / var_61_22

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_21 + var_61_22 and arg_58_1.time_ < var_61_21 + var_61_22 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
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

		arg_58_1:InitPlayNodeList()
	end,
	Play103071015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 103071015
		arg_64_1.duration_ = 4.63

		local var_64_0 = {
			ja = 3.8,
			ko = 3.766,
			zh = 2.066,
			en = 4.633
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
				arg_64_0:Play103071016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action4_2")
			end

			local var_67_1 = 0
			local var_67_2 = 0.275

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_3 = arg_64_1:FormatText(StoryNameCfg[21].name)

				arg_64_1.leftNameTxt_.text = var_67_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_4 = arg_64_1:GetWordFromCfg(103071015)
				local var_67_5 = arg_64_1:FormatText(var_67_4.content)

				arg_64_1.text_.text = var_67_5

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_6 = 11
				local var_67_7 = utf8.len(var_67_5)
				local var_67_8 = var_67_6 <= 0 and var_67_2 or var_67_2 * (var_67_7 / var_67_6)

				if var_67_8 > 0 and var_67_2 < var_67_8 then
					arg_64_1.talkMaxDuration = var_67_8

					if var_67_8 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_5
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071015", "story_v_out_103071.awb") ~= 0 then
					local var_67_9 = manager.audio:GetVoiceLength("story_v_out_103071", "103071015", "story_v_out_103071.awb") / 1000

					if var_67_9 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_1
					end

					if var_67_4.prefab_name ~= "" and arg_64_1.actors_[var_67_4.prefab_name] ~= nil then
						local var_67_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_4.prefab_name].transform, "story_v_out_103071", "103071015", "story_v_out_103071.awb")

						arg_64_1:RecordAudio("103071015", var_67_10)
						arg_64_1:RecordAudio("103071015", var_67_10)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_103071", "103071015", "story_v_out_103071.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_103071", "103071015", "story_v_out_103071.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_11 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_11 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_11

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_11 and arg_64_1.time_ < var_67_1 + var_67_11 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play103071016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 103071016
		arg_68_1.duration_ = 9.47

		local var_68_0 = {
			ja = 9.466,
			ko = 8.033,
			zh = 6.733,
			en = 7.766
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
				arg_68_0:Play103071017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1148ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1148ui_story == nil then
				arg_68_1.var_.characterEffect1148ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1148ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1148ui_story then
				arg_68_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["1148ui_story"].transform
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.var_.moveOldPos1148ui_story = var_71_4.localPosition
			end

			local var_71_6 = 0.001

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6
				local var_71_8 = Vector3.New(0, -0.8, -6.2)

				var_71_4.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1148ui_story, var_71_8, var_71_7)

				local var_71_9 = manager.ui.mainCamera.transform.position - var_71_4.position

				var_71_4.forward = Vector3.New(var_71_9.x, var_71_9.y, var_71_9.z)

				local var_71_10 = var_71_4.localEulerAngles

				var_71_10.z = 0
				var_71_10.x = 0
				var_71_4.localEulerAngles = var_71_10
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 then
				var_71_4.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_71_11 = manager.ui.mainCamera.transform.position - var_71_4.position

				var_71_4.forward = Vector3.New(var_71_11.x, var_71_11.y, var_71_11.z)

				local var_71_12 = var_71_4.localEulerAngles

				var_71_12.z = 0
				var_71_12.x = 0
				var_71_4.localEulerAngles = var_71_12
			end

			local var_71_13 = 0

			if var_71_13 < arg_68_1.time_ and arg_68_1.time_ <= var_71_13 + arg_71_0 then
				arg_68_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			local var_71_14 = arg_68_1.actors_["1035ui_story"].transform
			local var_71_15 = 0

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1.var_.moveOldPos1035ui_story = var_71_14.localPosition
			end

			local var_71_16 = 0.001

			if var_71_15 <= arg_68_1.time_ and arg_68_1.time_ < var_71_15 + var_71_16 then
				local var_71_17 = (arg_68_1.time_ - var_71_15) / var_71_16
				local var_71_18 = Vector3.New(0, 100, 0)

				var_71_14.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1035ui_story, var_71_18, var_71_17)

				local var_71_19 = manager.ui.mainCamera.transform.position - var_71_14.position

				var_71_14.forward = Vector3.New(var_71_19.x, var_71_19.y, var_71_19.z)

				local var_71_20 = var_71_14.localEulerAngles

				var_71_20.z = 0
				var_71_20.x = 0
				var_71_14.localEulerAngles = var_71_20
			end

			if arg_68_1.time_ >= var_71_15 + var_71_16 and arg_68_1.time_ < var_71_15 + var_71_16 + arg_71_0 then
				var_71_14.localPosition = Vector3.New(0, 100, 0)

				local var_71_21 = manager.ui.mainCamera.transform.position - var_71_14.position

				var_71_14.forward = Vector3.New(var_71_21.x, var_71_21.y, var_71_21.z)

				local var_71_22 = var_71_14.localEulerAngles

				var_71_22.z = 0
				var_71_22.x = 0
				var_71_14.localEulerAngles = var_71_22
			end

			local var_71_23 = 0

			if var_71_23 < arg_68_1.time_ and arg_68_1.time_ <= var_71_23 + arg_71_0 then
				arg_68_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_71_24 = 0
			local var_71_25 = 0.8

			if var_71_24 < arg_68_1.time_ and arg_68_1.time_ <= var_71_24 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_26 = arg_68_1:FormatText(StoryNameCfg[8].name)

				arg_68_1.leftNameTxt_.text = var_71_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_27 = arg_68_1:GetWordFromCfg(103071016)
				local var_71_28 = arg_68_1:FormatText(var_71_27.content)

				arg_68_1.text_.text = var_71_28

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_29 = 32
				local var_71_30 = utf8.len(var_71_28)
				local var_71_31 = var_71_29 <= 0 and var_71_25 or var_71_25 * (var_71_30 / var_71_29)

				if var_71_31 > 0 and var_71_25 < var_71_31 then
					arg_68_1.talkMaxDuration = var_71_31

					if var_71_31 + var_71_24 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_31 + var_71_24
					end
				end

				arg_68_1.text_.text = var_71_28
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071016", "story_v_out_103071.awb") ~= 0 then
					local var_71_32 = manager.audio:GetVoiceLength("story_v_out_103071", "103071016", "story_v_out_103071.awb") / 1000

					if var_71_32 + var_71_24 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_32 + var_71_24
					end

					if var_71_27.prefab_name ~= "" and arg_68_1.actors_[var_71_27.prefab_name] ~= nil then
						local var_71_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_27.prefab_name].transform, "story_v_out_103071", "103071016", "story_v_out_103071.awb")

						arg_68_1:RecordAudio("103071016", var_71_33)
						arg_68_1:RecordAudio("103071016", var_71_33)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_103071", "103071016", "story_v_out_103071.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_103071", "103071016", "story_v_out_103071.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_34 = math.max(var_71_25, arg_68_1.talkMaxDuration)

			if var_71_24 <= arg_68_1.time_ and arg_68_1.time_ < var_71_24 + var_71_34 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_24) / var_71_34

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_24 + var_71_34 and arg_68_1.time_ < var_71_24 + var_71_34 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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

		arg_68_1:InitPlayNodeList()
	end,
	Play103071017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 103071017
		arg_72_1.duration_ = 11.93

		local var_72_0 = {
			ja = 11.666,
			ko = 11.933,
			zh = 7.7,
			en = 10.466
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
				arg_72_0:Play103071018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 1

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				local var_75_2 = "play"
				local var_75_3 = "effect"

				arg_72_1:AudioAction(var_75_2, var_75_3, "se_story_3", "se_story_3_snipe", "")
			end

			local var_75_4 = arg_72_1.actors_["1148ui_story"].transform
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 then
				arg_72_1.var_.moveOldPos1148ui_story = var_75_4.localPosition
			end

			local var_75_6 = 0.001

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6
				local var_75_8 = Vector3.New(0, 100, 0)

				var_75_4.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1148ui_story, var_75_8, var_75_7)

				local var_75_9 = manager.ui.mainCamera.transform.position - var_75_4.position

				var_75_4.forward = Vector3.New(var_75_9.x, var_75_9.y, var_75_9.z)

				local var_75_10 = var_75_4.localEulerAngles

				var_75_10.z = 0
				var_75_10.x = 0
				var_75_4.localEulerAngles = var_75_10
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 then
				var_75_4.localPosition = Vector3.New(0, 100, 0)

				local var_75_11 = manager.ui.mainCamera.transform.position - var_75_4.position

				var_75_4.forward = Vector3.New(var_75_11.x, var_75_11.y, var_75_11.z)

				local var_75_12 = var_75_4.localEulerAngles

				var_75_12.z = 0
				var_75_12.x = 0
				var_75_4.localEulerAngles = var_75_12
			end

			local var_75_13 = arg_72_1.actors_["1035ui_story"].transform
			local var_75_14 = 0

			if var_75_14 < arg_72_1.time_ and arg_72_1.time_ <= var_75_14 + arg_75_0 then
				arg_72_1.var_.moveOldPos1035ui_story = var_75_13.localPosition
			end

			local var_75_15 = 0.001

			if var_75_14 <= arg_72_1.time_ and arg_72_1.time_ < var_75_14 + var_75_15 then
				local var_75_16 = (arg_72_1.time_ - var_75_14) / var_75_15
				local var_75_17 = Vector3.New(0, -1.05, -5.6)

				var_75_13.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1035ui_story, var_75_17, var_75_16)

				local var_75_18 = manager.ui.mainCamera.transform.position - var_75_13.position

				var_75_13.forward = Vector3.New(var_75_18.x, var_75_18.y, var_75_18.z)

				local var_75_19 = var_75_13.localEulerAngles

				var_75_19.z = 0
				var_75_19.x = 0
				var_75_13.localEulerAngles = var_75_19
			end

			if arg_72_1.time_ >= var_75_14 + var_75_15 and arg_72_1.time_ < var_75_14 + var_75_15 + arg_75_0 then
				var_75_13.localPosition = Vector3.New(0, -1.05, -5.6)

				local var_75_20 = manager.ui.mainCamera.transform.position - var_75_13.position

				var_75_13.forward = Vector3.New(var_75_20.x, var_75_20.y, var_75_20.z)

				local var_75_21 = var_75_13.localEulerAngles

				var_75_21.z = 0
				var_75_21.x = 0
				var_75_13.localEulerAngles = var_75_21
			end

			local var_75_22 = 0

			if var_75_22 < arg_72_1.time_ and arg_72_1.time_ <= var_75_22 + arg_75_0 then
				arg_72_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action2_1")
			end

			local var_75_23 = 1.5

			if var_75_23 < arg_72_1.time_ and arg_72_1.time_ <= var_75_23 + arg_75_0 then
				arg_72_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action423")
			end

			local var_75_24 = manager.ui.mainCamera.transform
			local var_75_25 = 1.025

			if var_75_25 < arg_72_1.time_ and arg_72_1.time_ <= var_75_25 + arg_75_0 then
				arg_72_1.var_.shakeOldPos = var_75_24.localPosition
			end

			local var_75_26 = 0.4

			if var_75_25 <= arg_72_1.time_ and arg_72_1.time_ < var_75_25 + var_75_26 then
				local var_75_27 = (arg_72_1.time_ - var_75_25) / 0.099
				local var_75_28, var_75_29 = math.modf(var_75_27)

				var_75_24.localPosition = Vector3.New(var_75_29 * 0.13, var_75_29 * 0.13, var_75_29 * 0.13) + arg_72_1.var_.shakeOldPos
			end

			if arg_72_1.time_ >= var_75_25 + var_75_26 and arg_72_1.time_ < var_75_25 + var_75_26 + arg_75_0 then
				var_75_24.localPosition = arg_72_1.var_.shakeOldPos
			end

			local var_75_30 = 0
			local var_75_31 = 1.025

			if var_75_30 < arg_72_1.time_ and arg_72_1.time_ <= var_75_30 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_32 = arg_72_1:FormatText(StoryNameCfg[21].name)

				arg_72_1.leftNameTxt_.text = var_75_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_33 = arg_72_1:GetWordFromCfg(103071017)
				local var_75_34 = arg_72_1:FormatText(var_75_33.content)

				arg_72_1.text_.text = var_75_34

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_35 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071017", "story_v_out_103071.awb") ~= 0 then
					local var_75_38 = manager.audio:GetVoiceLength("story_v_out_103071", "103071017", "story_v_out_103071.awb") / 1000

					if var_75_38 + var_75_30 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_38 + var_75_30
					end

					if var_75_33.prefab_name ~= "" and arg_72_1.actors_[var_75_33.prefab_name] ~= nil then
						local var_75_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_33.prefab_name].transform, "story_v_out_103071", "103071017", "story_v_out_103071.awb")

						arg_72_1:RecordAudio("103071017", var_75_39)
						arg_72_1:RecordAudio("103071017", var_75_39)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_103071", "103071017", "story_v_out_103071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_103071", "103071017", "story_v_out_103071.awb")
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
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

		arg_72_1:InitPlayNodeList()
	end,
	Play103071018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 103071018
		arg_76_1.duration_ = 5.67

		local var_76_0 = {
			ja = 5.666,
			ko = 4.6,
			zh = 3.666,
			en = 4.933
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
				arg_76_0:Play103071019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1148ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1148ui_story == nil then
				arg_76_1.var_.characterEffect1148ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1148ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1148ui_story then
				arg_76_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_79_4 = 0

			if var_79_4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action497")
			end

			local var_79_5 = arg_76_1.actors_["1148ui_story"].transform
			local var_79_6 = 0

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.var_.moveOldPos1148ui_story = var_79_5.localPosition
			end

			local var_79_7 = 0.001

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_7 then
				local var_79_8 = (arg_76_1.time_ - var_79_6) / var_79_7
				local var_79_9 = Vector3.New(0, -0.8, -6.2)

				var_79_5.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1148ui_story, var_79_9, var_79_8)

				local var_79_10 = manager.ui.mainCamera.transform.position - var_79_5.position

				var_79_5.forward = Vector3.New(var_79_10.x, var_79_10.y, var_79_10.z)

				local var_79_11 = var_79_5.localEulerAngles

				var_79_11.z = 0
				var_79_11.x = 0
				var_79_5.localEulerAngles = var_79_11
			end

			if arg_76_1.time_ >= var_79_6 + var_79_7 and arg_76_1.time_ < var_79_6 + var_79_7 + arg_79_0 then
				var_79_5.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_79_12 = manager.ui.mainCamera.transform.position - var_79_5.position

				var_79_5.forward = Vector3.New(var_79_12.x, var_79_12.y, var_79_12.z)

				local var_79_13 = var_79_5.localEulerAngles

				var_79_13.z = 0
				var_79_13.x = 0
				var_79_5.localEulerAngles = var_79_13
			end

			local var_79_14 = arg_76_1.actors_["1035ui_story"].transform
			local var_79_15 = 0

			if var_79_15 < arg_76_1.time_ and arg_76_1.time_ <= var_79_15 + arg_79_0 then
				arg_76_1.var_.moveOldPos1035ui_story = var_79_14.localPosition
			end

			local var_79_16 = 0.001

			if var_79_15 <= arg_76_1.time_ and arg_76_1.time_ < var_79_15 + var_79_16 then
				local var_79_17 = (arg_76_1.time_ - var_79_15) / var_79_16
				local var_79_18 = Vector3.New(0, 100, 0)

				var_79_14.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1035ui_story, var_79_18, var_79_17)

				local var_79_19 = manager.ui.mainCamera.transform.position - var_79_14.position

				var_79_14.forward = Vector3.New(var_79_19.x, var_79_19.y, var_79_19.z)

				local var_79_20 = var_79_14.localEulerAngles

				var_79_20.z = 0
				var_79_20.x = 0
				var_79_14.localEulerAngles = var_79_20
			end

			if arg_76_1.time_ >= var_79_15 + var_79_16 and arg_76_1.time_ < var_79_15 + var_79_16 + arg_79_0 then
				var_79_14.localPosition = Vector3.New(0, 100, 0)

				local var_79_21 = manager.ui.mainCamera.transform.position - var_79_14.position

				var_79_14.forward = Vector3.New(var_79_21.x, var_79_21.y, var_79_21.z)

				local var_79_22 = var_79_14.localEulerAngles

				var_79_22.z = 0
				var_79_22.x = 0
				var_79_14.localEulerAngles = var_79_22
			end

			local var_79_23 = 0

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 then
				arg_76_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_79_24 = 0
			local var_79_25 = 0.35

			if var_79_24 < arg_76_1.time_ and arg_76_1.time_ <= var_79_24 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_26 = arg_76_1:FormatText(StoryNameCfg[8].name)

				arg_76_1.leftNameTxt_.text = var_79_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_27 = arg_76_1:GetWordFromCfg(103071018)
				local var_79_28 = arg_76_1:FormatText(var_79_27.content)

				arg_76_1.text_.text = var_79_28

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_29 = 14
				local var_79_30 = utf8.len(var_79_28)
				local var_79_31 = var_79_29 <= 0 and var_79_25 or var_79_25 * (var_79_30 / var_79_29)

				if var_79_31 > 0 and var_79_25 < var_79_31 then
					arg_76_1.talkMaxDuration = var_79_31

					if var_79_31 + var_79_24 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_31 + var_79_24
					end
				end

				arg_76_1.text_.text = var_79_28
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071018", "story_v_out_103071.awb") ~= 0 then
					local var_79_32 = manager.audio:GetVoiceLength("story_v_out_103071", "103071018", "story_v_out_103071.awb") / 1000

					if var_79_32 + var_79_24 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_32 + var_79_24
					end

					if var_79_27.prefab_name ~= "" and arg_76_1.actors_[var_79_27.prefab_name] ~= nil then
						local var_79_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_27.prefab_name].transform, "story_v_out_103071", "103071018", "story_v_out_103071.awb")

						arg_76_1:RecordAudio("103071018", var_79_33)
						arg_76_1:RecordAudio("103071018", var_79_33)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_103071", "103071018", "story_v_out_103071.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_103071", "103071018", "story_v_out_103071.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_34 = math.max(var_79_25, arg_76_1.talkMaxDuration)

			if var_79_24 <= arg_76_1.time_ and arg_76_1.time_ < var_79_24 + var_79_34 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_24) / var_79_34

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_24 + var_79_34 and arg_76_1.time_ < var_79_24 + var_79_34 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
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

		arg_76_1:InitPlayNodeList()
	end,
	Play103071019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 103071019
		arg_80_1.duration_ = 4.53

		local var_80_0 = {
			ja = 4.066,
			ko = 4.533,
			zh = 3.533,
			en = 2.733
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
				arg_80_0:Play103071020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1059ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1059ui_story == nil then
				arg_80_1.var_.characterEffect1059ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1059ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1059ui_story then
				arg_80_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["1148ui_story"]
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1148ui_story == nil then
				arg_80_1.var_.characterEffect1148ui_story = var_83_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.1

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 and not isNil(var_83_4) then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6

				if arg_80_1.var_.characterEffect1148ui_story and not isNil(var_83_4) then
					local var_83_8 = Mathf.Lerp(0, 0.5, var_83_7)

					arg_80_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1148ui_story.fillRatio = var_83_8
				end
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1148ui_story then
				local var_83_9 = 0.5

				arg_80_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1148ui_story.fillRatio = var_83_9
			end

			local var_83_10 = arg_80_1.actors_["1148ui_story"].transform
			local var_83_11 = 0

			if var_83_11 < arg_80_1.time_ and arg_80_1.time_ <= var_83_11 + arg_83_0 then
				arg_80_1.var_.moveOldPos1148ui_story = var_83_10.localPosition
			end

			local var_83_12 = 0.001

			if var_83_11 <= arg_80_1.time_ and arg_80_1.time_ < var_83_11 + var_83_12 then
				local var_83_13 = (arg_80_1.time_ - var_83_11) / var_83_12
				local var_83_14 = Vector3.New(0, -0.8, -6.2)

				var_83_10.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1148ui_story, var_83_14, var_83_13)

				local var_83_15 = manager.ui.mainCamera.transform.position - var_83_10.position

				var_83_10.forward = Vector3.New(var_83_15.x, var_83_15.y, var_83_15.z)

				local var_83_16 = var_83_10.localEulerAngles

				var_83_16.z = 0
				var_83_16.x = 0
				var_83_10.localEulerAngles = var_83_16
			end

			if arg_80_1.time_ >= var_83_11 + var_83_12 and arg_80_1.time_ < var_83_11 + var_83_12 + arg_83_0 then
				var_83_10.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_83_17 = manager.ui.mainCamera.transform.position - var_83_10.position

				var_83_10.forward = Vector3.New(var_83_17.x, var_83_17.y, var_83_17.z)

				local var_83_18 = var_83_10.localEulerAngles

				var_83_18.z = 0
				var_83_18.x = 0
				var_83_10.localEulerAngles = var_83_18
			end

			local var_83_19 = arg_80_1.actors_["1148ui_story"].transform
			local var_83_20 = 0.033

			if var_83_20 < arg_80_1.time_ and arg_80_1.time_ <= var_83_20 + arg_83_0 then
				arg_80_1.var_.moveOldPos1148ui_story = var_83_19.localPosition
			end

			local var_83_21 = 0.5

			if var_83_20 <= arg_80_1.time_ and arg_80_1.time_ < var_83_20 + var_83_21 then
				local var_83_22 = (arg_80_1.time_ - var_83_20) / var_83_21
				local var_83_23 = Vector3.New(-0.7, -0.8, -6.2)

				var_83_19.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1148ui_story, var_83_23, var_83_22)

				local var_83_24 = manager.ui.mainCamera.transform.position - var_83_19.position

				var_83_19.forward = Vector3.New(var_83_24.x, var_83_24.y, var_83_24.z)

				local var_83_25 = var_83_19.localEulerAngles

				var_83_25.z = 0
				var_83_25.x = 0
				var_83_19.localEulerAngles = var_83_25
			end

			if arg_80_1.time_ >= var_83_20 + var_83_21 and arg_80_1.time_ < var_83_20 + var_83_21 + arg_83_0 then
				var_83_19.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_83_26 = manager.ui.mainCamera.transform.position - var_83_19.position

				var_83_19.forward = Vector3.New(var_83_26.x, var_83_26.y, var_83_26.z)

				local var_83_27 = var_83_19.localEulerAngles

				var_83_27.z = 0
				var_83_27.x = 0
				var_83_19.localEulerAngles = var_83_27
			end

			local var_83_28 = arg_80_1.actors_["1059ui_story"].transform
			local var_83_29 = 0

			if var_83_29 < arg_80_1.time_ and arg_80_1.time_ <= var_83_29 + arg_83_0 then
				arg_80_1.var_.moveOldPos1059ui_story = var_83_28.localPosition
			end

			local var_83_30 = 0.001

			if var_83_29 <= arg_80_1.time_ and arg_80_1.time_ < var_83_29 + var_83_30 then
				local var_83_31 = (arg_80_1.time_ - var_83_29) / var_83_30
				local var_83_32 = Vector3.New(0.7, -1.05, -6)

				var_83_28.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1059ui_story, var_83_32, var_83_31)

				local var_83_33 = manager.ui.mainCamera.transform.position - var_83_28.position

				var_83_28.forward = Vector3.New(var_83_33.x, var_83_33.y, var_83_33.z)

				local var_83_34 = var_83_28.localEulerAngles

				var_83_34.z = 0
				var_83_34.x = 0
				var_83_28.localEulerAngles = var_83_34
			end

			if arg_80_1.time_ >= var_83_29 + var_83_30 and arg_80_1.time_ < var_83_29 + var_83_30 + arg_83_0 then
				var_83_28.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_83_35 = manager.ui.mainCamera.transform.position - var_83_28.position

				var_83_28.forward = Vector3.New(var_83_35.x, var_83_35.y, var_83_35.z)

				local var_83_36 = var_83_28.localEulerAngles

				var_83_36.z = 0
				var_83_36.x = 0
				var_83_28.localEulerAngles = var_83_36
			end

			local var_83_37 = 0

			if var_83_37 < arg_80_1.time_ and arg_80_1.time_ <= var_83_37 + arg_83_0 then
				arg_80_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action7_1")
			end

			local var_83_38 = 0

			if var_83_38 < arg_80_1.time_ and arg_80_1.time_ <= var_83_38 + arg_83_0 then
				arg_80_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_83_39 = 0
			local var_83_40 = 0.375

			if var_83_39 < arg_80_1.time_ and arg_80_1.time_ <= var_83_39 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_41 = arg_80_1:FormatText(StoryNameCfg[28].name)

				arg_80_1.leftNameTxt_.text = var_83_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_42 = arg_80_1:GetWordFromCfg(103071019)
				local var_83_43 = arg_80_1:FormatText(var_83_42.content)

				arg_80_1.text_.text = var_83_43

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_44 = 15
				local var_83_45 = utf8.len(var_83_43)
				local var_83_46 = var_83_44 <= 0 and var_83_40 or var_83_40 * (var_83_45 / var_83_44)

				if var_83_46 > 0 and var_83_40 < var_83_46 then
					arg_80_1.talkMaxDuration = var_83_46

					if var_83_46 + var_83_39 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_46 + var_83_39
					end
				end

				arg_80_1.text_.text = var_83_43
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071019", "story_v_out_103071.awb") ~= 0 then
					local var_83_47 = manager.audio:GetVoiceLength("story_v_out_103071", "103071019", "story_v_out_103071.awb") / 1000

					if var_83_47 + var_83_39 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_47 + var_83_39
					end

					if var_83_42.prefab_name ~= "" and arg_80_1.actors_[var_83_42.prefab_name] ~= nil then
						local var_83_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_42.prefab_name].transform, "story_v_out_103071", "103071019", "story_v_out_103071.awb")

						arg_80_1:RecordAudio("103071019", var_83_48)
						arg_80_1:RecordAudio("103071019", var_83_48)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_103071", "103071019", "story_v_out_103071.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_103071", "103071019", "story_v_out_103071.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_49 = math.max(var_83_40, arg_80_1.talkMaxDuration)

			if var_83_39 <= arg_80_1.time_ and arg_80_1.time_ < var_83_39 + var_83_49 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_39) / var_83_49

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_39 + var_83_49 and arg_80_1.time_ < var_83_39 + var_83_49 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
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
	Play103071020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 103071020
		arg_84_1.duration_ = 9

		local var_84_0 = {
			ja = 9,
			ko = 7.1,
			zh = 5.9,
			en = 8.9
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
				arg_84_0:Play103071021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1148ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1148ui_story == nil then
				arg_84_1.var_.characterEffect1148ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1148ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1148ui_story then
				arg_84_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_87_4 = arg_84_1.actors_["1059ui_story"]
			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1059ui_story == nil then
				arg_84_1.var_.characterEffect1059ui_story = var_87_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.1

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 and not isNil(var_87_4) then
				local var_87_7 = (arg_84_1.time_ - var_87_5) / var_87_6

				if arg_84_1.var_.characterEffect1059ui_story and not isNil(var_87_4) then
					local var_87_8 = Mathf.Lerp(0, 0.5, var_87_7)

					arg_84_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1059ui_story.fillRatio = var_87_8
				end
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1059ui_story then
				local var_87_9 = 0.5

				arg_84_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1059ui_story.fillRatio = var_87_9
			end

			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action473")
			end

			local var_87_11 = 0

			if var_87_11 < arg_84_1.time_ and arg_84_1.time_ <= var_87_11 + arg_87_0 then
				arg_84_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_87_12 = 0
			local var_87_13 = 0.7

			if var_87_12 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_14 = arg_84_1:FormatText(StoryNameCfg[8].name)

				arg_84_1.leftNameTxt_.text = var_87_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_15 = arg_84_1:GetWordFromCfg(103071020)
				local var_87_16 = arg_84_1:FormatText(var_87_15.content)

				arg_84_1.text_.text = var_87_16

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_17 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071020", "story_v_out_103071.awb") ~= 0 then
					local var_87_20 = manager.audio:GetVoiceLength("story_v_out_103071", "103071020", "story_v_out_103071.awb") / 1000

					if var_87_20 + var_87_12 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_20 + var_87_12
					end

					if var_87_15.prefab_name ~= "" and arg_84_1.actors_[var_87_15.prefab_name] ~= nil then
						local var_87_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_15.prefab_name].transform, "story_v_out_103071", "103071020", "story_v_out_103071.awb")

						arg_84_1:RecordAudio("103071020", var_87_21)
						arg_84_1:RecordAudio("103071020", var_87_21)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_103071", "103071020", "story_v_out_103071.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_103071", "103071020", "story_v_out_103071.awb")
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
	Play103071021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 103071021
		arg_88_1.duration_ = 6.1

		local var_88_0 = {
			ja = 6.1,
			ko = 4.833,
			zh = 3.133,
			en = 3.833
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
				arg_88_0:Play103071022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1035ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos1035ui_story = var_91_0.localPosition
			end

			local var_91_2 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2
				local var_91_4 = Vector3.New(0, -1.05, -5.6)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1035ui_story, var_91_4, var_91_3)

				local var_91_5 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_5.x, var_91_5.y, var_91_5.z)

				local var_91_6 = var_91_0.localEulerAngles

				var_91_6.z = 0
				var_91_6.x = 0
				var_91_0.localEulerAngles = var_91_6
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0, -1.05, -5.6)

				local var_91_7 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_7.x, var_91_7.y, var_91_7.z)

				local var_91_8 = var_91_0.localEulerAngles

				var_91_8.z = 0
				var_91_8.x = 0
				var_91_0.localEulerAngles = var_91_8
			end

			local var_91_9 = arg_88_1.actors_["1059ui_story"].transform
			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1.var_.moveOldPos1059ui_story = var_91_9.localPosition
			end

			local var_91_11 = 0.001

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_11 then
				local var_91_12 = (arg_88_1.time_ - var_91_10) / var_91_11
				local var_91_13 = Vector3.New(0, 100, 0)

				var_91_9.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1059ui_story, var_91_13, var_91_12)

				local var_91_14 = manager.ui.mainCamera.transform.position - var_91_9.position

				var_91_9.forward = Vector3.New(var_91_14.x, var_91_14.y, var_91_14.z)

				local var_91_15 = var_91_9.localEulerAngles

				var_91_15.z = 0
				var_91_15.x = 0
				var_91_9.localEulerAngles = var_91_15
			end

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 then
				var_91_9.localPosition = Vector3.New(0, 100, 0)

				local var_91_16 = manager.ui.mainCamera.transform.position - var_91_9.position

				var_91_9.forward = Vector3.New(var_91_16.x, var_91_16.y, var_91_16.z)

				local var_91_17 = var_91_9.localEulerAngles

				var_91_17.z = 0
				var_91_17.x = 0
				var_91_9.localEulerAngles = var_91_17
			end

			local var_91_18 = arg_88_1.actors_["1148ui_story"].transform
			local var_91_19 = 0

			if var_91_19 < arg_88_1.time_ and arg_88_1.time_ <= var_91_19 + arg_91_0 then
				arg_88_1.var_.moveOldPos1148ui_story = var_91_18.localPosition
			end

			local var_91_20 = 0.001

			if var_91_19 <= arg_88_1.time_ and arg_88_1.time_ < var_91_19 + var_91_20 then
				local var_91_21 = (arg_88_1.time_ - var_91_19) / var_91_20
				local var_91_22 = Vector3.New(0, 100, 0)

				var_91_18.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1148ui_story, var_91_22, var_91_21)

				local var_91_23 = manager.ui.mainCamera.transform.position - var_91_18.position

				var_91_18.forward = Vector3.New(var_91_23.x, var_91_23.y, var_91_23.z)

				local var_91_24 = var_91_18.localEulerAngles

				var_91_24.z = 0
				var_91_24.x = 0
				var_91_18.localEulerAngles = var_91_24
			end

			if arg_88_1.time_ >= var_91_19 + var_91_20 and arg_88_1.time_ < var_91_19 + var_91_20 + arg_91_0 then
				var_91_18.localPosition = Vector3.New(0, 100, 0)

				local var_91_25 = manager.ui.mainCamera.transform.position - var_91_18.position

				var_91_18.forward = Vector3.New(var_91_25.x, var_91_25.y, var_91_25.z)

				local var_91_26 = var_91_18.localEulerAngles

				var_91_26.z = 0
				var_91_26.x = 0
				var_91_18.localEulerAngles = var_91_26
			end

			local var_91_27 = 0

			if var_91_27 < arg_88_1.time_ and arg_88_1.time_ <= var_91_27 + arg_91_0 then
				arg_88_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action11_1")
			end

			local var_91_28 = arg_88_1.actors_["1035ui_story"]
			local var_91_29 = 0

			if var_91_29 < arg_88_1.time_ and arg_88_1.time_ <= var_91_29 + arg_91_0 and not isNil(var_91_28) and arg_88_1.var_.characterEffect1035ui_story == nil then
				arg_88_1.var_.characterEffect1035ui_story = var_91_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_30 = 0.2

			if var_91_29 <= arg_88_1.time_ and arg_88_1.time_ < var_91_29 + var_91_30 and not isNil(var_91_28) then
				local var_91_31 = (arg_88_1.time_ - var_91_29) / var_91_30

				if arg_88_1.var_.characterEffect1035ui_story and not isNil(var_91_28) then
					arg_88_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_29 + var_91_30 and arg_88_1.time_ < var_91_29 + var_91_30 + arg_91_0 and not isNil(var_91_28) and arg_88_1.var_.characterEffect1035ui_story then
				arg_88_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_91_32 = 0
			local var_91_33 = 0.375

			if var_91_32 < arg_88_1.time_ and arg_88_1.time_ <= var_91_32 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_34 = arg_88_1:FormatText(StoryNameCfg[21].name)

				arg_88_1.leftNameTxt_.text = var_91_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_35 = arg_88_1:GetWordFromCfg(103071021)
				local var_91_36 = arg_88_1:FormatText(var_91_35.content)

				arg_88_1.text_.text = var_91_36

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_37 = 15
				local var_91_38 = utf8.len(var_91_36)
				local var_91_39 = var_91_37 <= 0 and var_91_33 or var_91_33 * (var_91_38 / var_91_37)

				if var_91_39 > 0 and var_91_33 < var_91_39 then
					arg_88_1.talkMaxDuration = var_91_39

					if var_91_39 + var_91_32 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_39 + var_91_32
					end
				end

				arg_88_1.text_.text = var_91_36
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071021", "story_v_out_103071.awb") ~= 0 then
					local var_91_40 = manager.audio:GetVoiceLength("story_v_out_103071", "103071021", "story_v_out_103071.awb") / 1000

					if var_91_40 + var_91_32 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_40 + var_91_32
					end

					if var_91_35.prefab_name ~= "" and arg_88_1.actors_[var_91_35.prefab_name] ~= nil then
						local var_91_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_35.prefab_name].transform, "story_v_out_103071", "103071021", "story_v_out_103071.awb")

						arg_88_1:RecordAudio("103071021", var_91_41)
						arg_88_1:RecordAudio("103071021", var_91_41)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_103071", "103071021", "story_v_out_103071.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_103071", "103071021", "story_v_out_103071.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_42 = math.max(var_91_33, arg_88_1.talkMaxDuration)

			if var_91_32 <= arg_88_1.time_ and arg_88_1.time_ < var_91_32 + var_91_42 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_32) / var_91_42

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_32 + var_91_42 and arg_88_1.time_ < var_91_32 + var_91_42 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play103071022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 103071022
		arg_92_1.duration_ = 6.6

		local var_92_0 = {
			ja = 6.6,
			ko = 5.266,
			zh = 4.2,
			en = 5.433
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
				arg_92_0:Play103071023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action442")
			end

			local var_95_1 = 0
			local var_95_2 = 0.475

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_3 = arg_92_1:FormatText(StoryNameCfg[21].name)

				arg_92_1.leftNameTxt_.text = var_95_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_4 = arg_92_1:GetWordFromCfg(103071022)
				local var_95_5 = arg_92_1:FormatText(var_95_4.content)

				arg_92_1.text_.text = var_95_5

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_6 = 19
				local var_95_7 = utf8.len(var_95_5)
				local var_95_8 = var_95_6 <= 0 and var_95_2 or var_95_2 * (var_95_7 / var_95_6)

				if var_95_8 > 0 and var_95_2 < var_95_8 then
					arg_92_1.talkMaxDuration = var_95_8

					if var_95_8 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_5
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071022", "story_v_out_103071.awb") ~= 0 then
					local var_95_9 = manager.audio:GetVoiceLength("story_v_out_103071", "103071022", "story_v_out_103071.awb") / 1000

					if var_95_9 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_1
					end

					if var_95_4.prefab_name ~= "" and arg_92_1.actors_[var_95_4.prefab_name] ~= nil then
						local var_95_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_4.prefab_name].transform, "story_v_out_103071", "103071022", "story_v_out_103071.awb")

						arg_92_1:RecordAudio("103071022", var_95_10)
						arg_92_1:RecordAudio("103071022", var_95_10)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_103071", "103071022", "story_v_out_103071.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_103071", "103071022", "story_v_out_103071.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_11 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_11 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_11

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_11 and arg_92_1.time_ < var_95_1 + var_95_11 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play103071023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 103071023
		arg_96_1.duration_ = 9.03

		local var_96_0 = {
			ja = 9.033,
			ko = 6.066,
			zh = 6.933,
			en = 6.133
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
				arg_96_0:Play103071024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action426")
			end

			local var_99_1 = 1.5

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action467")
			end

			local var_99_2 = 0
			local var_99_3 = 0.675

			if var_99_2 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_4 = arg_96_1:FormatText(StoryNameCfg[21].name)

				arg_96_1.leftNameTxt_.text = var_99_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_5 = arg_96_1:GetWordFromCfg(103071023)
				local var_99_6 = arg_96_1:FormatText(var_99_5.content)

				arg_96_1.text_.text = var_99_6

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 27
				local var_99_8 = utf8.len(var_99_6)
				local var_99_9 = var_99_7 <= 0 and var_99_3 or var_99_3 * (var_99_8 / var_99_7)

				if var_99_9 > 0 and var_99_3 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_6
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071023", "story_v_out_103071.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_out_103071", "103071023", "story_v_out_103071.awb") / 1000

					if var_99_10 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_2
					end

					if var_99_5.prefab_name ~= "" and arg_96_1.actors_[var_99_5.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_5.prefab_name].transform, "story_v_out_103071", "103071023", "story_v_out_103071.awb")

						arg_96_1:RecordAudio("103071023", var_99_11)
						arg_96_1:RecordAudio("103071023", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_103071", "103071023", "story_v_out_103071.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_103071", "103071023", "story_v_out_103071.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_12 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_12 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_12

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_12 and arg_96_1.time_ < var_99_2 + var_99_12 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play103071024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 103071024
		arg_100_1.duration_ = 2.9

		local var_100_0 = {
			ja = 1.999999999999,
			ko = 2.533,
			zh = 1.999999999999,
			en = 2.9
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
				arg_100_0:Play103071025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1148ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1148ui_story == nil then
				arg_100_1.var_.characterEffect1148ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.1

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1148ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1148ui_story then
				arg_100_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_103_4 = arg_100_1.actors_["1148ui_story"].transform
			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 then
				arg_100_1.var_.moveOldPos1148ui_story = var_103_4.localPosition
			end

			local var_103_6 = 0.001

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_6 then
				local var_103_7 = (arg_100_1.time_ - var_103_5) / var_103_6
				local var_103_8 = Vector3.New(-0.7, -0.8, -6.2)

				var_103_4.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1148ui_story, var_103_8, var_103_7)

				local var_103_9 = manager.ui.mainCamera.transform.position - var_103_4.position

				var_103_4.forward = Vector3.New(var_103_9.x, var_103_9.y, var_103_9.z)

				local var_103_10 = var_103_4.localEulerAngles

				var_103_10.z = 0
				var_103_10.x = 0
				var_103_4.localEulerAngles = var_103_10
			end

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 then
				var_103_4.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_103_11 = manager.ui.mainCamera.transform.position - var_103_4.position

				var_103_4.forward = Vector3.New(var_103_11.x, var_103_11.y, var_103_11.z)

				local var_103_12 = var_103_4.localEulerAngles

				var_103_12.z = 0
				var_103_12.x = 0
				var_103_4.localEulerAngles = var_103_12
			end

			local var_103_13 = 0

			if var_103_13 < arg_100_1.time_ and arg_100_1.time_ <= var_103_13 + arg_103_0 then
				arg_100_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_103_14 = arg_100_1.actors_["1035ui_story"].transform
			local var_103_15 = 0

			if var_103_15 < arg_100_1.time_ and arg_100_1.time_ <= var_103_15 + arg_103_0 then
				arg_100_1.var_.moveOldPos1035ui_story = var_103_14.localPosition
			end

			local var_103_16 = 0.001

			if var_103_15 <= arg_100_1.time_ and arg_100_1.time_ < var_103_15 + var_103_16 then
				local var_103_17 = (arg_100_1.time_ - var_103_15) / var_103_16
				local var_103_18 = Vector3.New(0, 100, 0)

				var_103_14.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1035ui_story, var_103_18, var_103_17)

				local var_103_19 = manager.ui.mainCamera.transform.position - var_103_14.position

				var_103_14.forward = Vector3.New(var_103_19.x, var_103_19.y, var_103_19.z)

				local var_103_20 = var_103_14.localEulerAngles

				var_103_20.z = 0
				var_103_20.x = 0
				var_103_14.localEulerAngles = var_103_20
			end

			if arg_100_1.time_ >= var_103_15 + var_103_16 and arg_100_1.time_ < var_103_15 + var_103_16 + arg_103_0 then
				var_103_14.localPosition = Vector3.New(0, 100, 0)

				local var_103_21 = manager.ui.mainCamera.transform.position - var_103_14.position

				var_103_14.forward = Vector3.New(var_103_21.x, var_103_21.y, var_103_21.z)

				local var_103_22 = var_103_14.localEulerAngles

				var_103_22.z = 0
				var_103_22.x = 0
				var_103_14.localEulerAngles = var_103_22
			end

			local var_103_23 = 0

			if var_103_23 < arg_100_1.time_ and arg_100_1.time_ <= var_103_23 + arg_103_0 then
				arg_100_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_103_24 = 0
			local var_103_25 = 0.2

			if var_103_24 < arg_100_1.time_ and arg_100_1.time_ <= var_103_24 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_26 = arg_100_1:FormatText(StoryNameCfg[8].name)

				arg_100_1.leftNameTxt_.text = var_103_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_27 = arg_100_1:GetWordFromCfg(103071024)
				local var_103_28 = arg_100_1:FormatText(var_103_27.content)

				arg_100_1.text_.text = var_103_28

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_29 = 8
				local var_103_30 = utf8.len(var_103_28)
				local var_103_31 = var_103_29 <= 0 and var_103_25 or var_103_25 * (var_103_30 / var_103_29)

				if var_103_31 > 0 and var_103_25 < var_103_31 then
					arg_100_1.talkMaxDuration = var_103_31

					if var_103_31 + var_103_24 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_31 + var_103_24
					end
				end

				arg_100_1.text_.text = var_103_28
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071024", "story_v_out_103071.awb") ~= 0 then
					local var_103_32 = manager.audio:GetVoiceLength("story_v_out_103071", "103071024", "story_v_out_103071.awb") / 1000

					if var_103_32 + var_103_24 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_32 + var_103_24
					end

					if var_103_27.prefab_name ~= "" and arg_100_1.actors_[var_103_27.prefab_name] ~= nil then
						local var_103_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_27.prefab_name].transform, "story_v_out_103071", "103071024", "story_v_out_103071.awb")

						arg_100_1:RecordAudio("103071024", var_103_33)
						arg_100_1:RecordAudio("103071024", var_103_33)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_103071", "103071024", "story_v_out_103071.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_103071", "103071024", "story_v_out_103071.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_34 = math.max(var_103_25, arg_100_1.talkMaxDuration)

			if var_103_24 <= arg_100_1.time_ and arg_100_1.time_ < var_103_24 + var_103_34 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_24) / var_103_34

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_24 + var_103_34 and arg_100_1.time_ < var_103_24 + var_103_34 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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

		arg_100_1:InitPlayNodeList()
	end,
	Play103071025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 103071025
		arg_104_1.duration_ = 2

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play103071026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1059ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1059ui_story == nil then
				arg_104_1.var_.characterEffect1059ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.1

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1059ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1059ui_story then
				arg_104_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_107_4 = arg_104_1.actors_["1148ui_story"]
			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect1148ui_story == nil then
				arg_104_1.var_.characterEffect1148ui_story = var_107_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_6 = 0.1

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_6 and not isNil(var_107_4) then
				local var_107_7 = (arg_104_1.time_ - var_107_5) / var_107_6

				if arg_104_1.var_.characterEffect1148ui_story and not isNil(var_107_4) then
					local var_107_8 = Mathf.Lerp(0, 0.5, var_107_7)

					arg_104_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1148ui_story.fillRatio = var_107_8
				end
			end

			if arg_104_1.time_ >= var_107_5 + var_107_6 and arg_104_1.time_ < var_107_5 + var_107_6 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect1148ui_story then
				local var_107_9 = 0.5

				arg_104_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1148ui_story.fillRatio = var_107_9
			end

			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 then
				arg_104_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			local var_107_11 = arg_104_1.actors_["1059ui_story"].transform
			local var_107_12 = 0

			if var_107_12 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 then
				arg_104_1.var_.moveOldPos1059ui_story = var_107_11.localPosition
			end

			local var_107_13 = 0.001

			if var_107_12 <= arg_104_1.time_ and arg_104_1.time_ < var_107_12 + var_107_13 then
				local var_107_14 = (arg_104_1.time_ - var_107_12) / var_107_13
				local var_107_15 = Vector3.New(0.7, -1.05, -6)

				var_107_11.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1059ui_story, var_107_15, var_107_14)

				local var_107_16 = manager.ui.mainCamera.transform.position - var_107_11.position

				var_107_11.forward = Vector3.New(var_107_16.x, var_107_16.y, var_107_16.z)

				local var_107_17 = var_107_11.localEulerAngles

				var_107_17.z = 0
				var_107_17.x = 0
				var_107_11.localEulerAngles = var_107_17
			end

			if arg_104_1.time_ >= var_107_12 + var_107_13 and arg_104_1.time_ < var_107_12 + var_107_13 + arg_107_0 then
				var_107_11.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_107_18 = manager.ui.mainCamera.transform.position - var_107_11.position

				var_107_11.forward = Vector3.New(var_107_18.x, var_107_18.y, var_107_18.z)

				local var_107_19 = var_107_11.localEulerAngles

				var_107_19.z = 0
				var_107_19.x = 0
				var_107_11.localEulerAngles = var_107_19
			end

			local var_107_20 = 0

			if var_107_20 < arg_104_1.time_ and arg_104_1.time_ <= var_107_20 + arg_107_0 then
				arg_104_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_107_21 = 0
			local var_107_22 = 0.175

			if var_107_21 < arg_104_1.time_ and arg_104_1.time_ <= var_107_21 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_23 = arg_104_1:FormatText(StoryNameCfg[28].name)

				arg_104_1.leftNameTxt_.text = var_107_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_24 = arg_104_1:GetWordFromCfg(103071025)
				local var_107_25 = arg_104_1:FormatText(var_107_24.content)

				arg_104_1.text_.text = var_107_25

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_26 = 7
				local var_107_27 = utf8.len(var_107_25)
				local var_107_28 = var_107_26 <= 0 and var_107_22 or var_107_22 * (var_107_27 / var_107_26)

				if var_107_28 > 0 and var_107_22 < var_107_28 then
					arg_104_1.talkMaxDuration = var_107_28

					if var_107_28 + var_107_21 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_28 + var_107_21
					end
				end

				arg_104_1.text_.text = var_107_25
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071025", "story_v_out_103071.awb") ~= 0 then
					local var_107_29 = manager.audio:GetVoiceLength("story_v_out_103071", "103071025", "story_v_out_103071.awb") / 1000

					if var_107_29 + var_107_21 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_29 + var_107_21
					end

					if var_107_24.prefab_name ~= "" and arg_104_1.actors_[var_107_24.prefab_name] ~= nil then
						local var_107_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_24.prefab_name].transform, "story_v_out_103071", "103071025", "story_v_out_103071.awb")

						arg_104_1:RecordAudio("103071025", var_107_30)
						arg_104_1:RecordAudio("103071025", var_107_30)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_103071", "103071025", "story_v_out_103071.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_103071", "103071025", "story_v_out_103071.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_31 = math.max(var_107_22, arg_104_1.talkMaxDuration)

			if var_107_21 <= arg_104_1.time_ and arg_104_1.time_ < var_107_21 + var_107_31 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_21) / var_107_31

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_21 + var_107_31 and arg_104_1.time_ < var_107_21 + var_107_31 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
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
	Play103071026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 103071026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play103071027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1059ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1059ui_story == nil then
				arg_108_1.var_.characterEffect1059ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.1

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1059ui_story and not isNil(var_111_0) then
					local var_111_4 = Mathf.Lerp(0, 0.5, var_111_3)

					arg_108_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1059ui_story.fillRatio = var_111_4
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1059ui_story then
				local var_111_5 = 0.5

				arg_108_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1059ui_story.fillRatio = var_111_5
			end

			local var_111_6 = arg_108_1.actors_["1148ui_story"].transform
			local var_111_7 = 0

			if var_111_7 < arg_108_1.time_ and arg_108_1.time_ <= var_111_7 + arg_111_0 then
				arg_108_1.var_.moveOldPos1148ui_story = var_111_6.localPosition
			end

			local var_111_8 = 0.001

			if var_111_7 <= arg_108_1.time_ and arg_108_1.time_ < var_111_7 + var_111_8 then
				local var_111_9 = (arg_108_1.time_ - var_111_7) / var_111_8
				local var_111_10 = Vector3.New(0, 100, 0)

				var_111_6.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1148ui_story, var_111_10, var_111_9)

				local var_111_11 = manager.ui.mainCamera.transform.position - var_111_6.position

				var_111_6.forward = Vector3.New(var_111_11.x, var_111_11.y, var_111_11.z)

				local var_111_12 = var_111_6.localEulerAngles

				var_111_12.z = 0
				var_111_12.x = 0
				var_111_6.localEulerAngles = var_111_12
			end

			if arg_108_1.time_ >= var_111_7 + var_111_8 and arg_108_1.time_ < var_111_7 + var_111_8 + arg_111_0 then
				var_111_6.localPosition = Vector3.New(0, 100, 0)

				local var_111_13 = manager.ui.mainCamera.transform.position - var_111_6.position

				var_111_6.forward = Vector3.New(var_111_13.x, var_111_13.y, var_111_13.z)

				local var_111_14 = var_111_6.localEulerAngles

				var_111_14.z = 0
				var_111_14.x = 0
				var_111_6.localEulerAngles = var_111_14
			end

			local var_111_15 = arg_108_1.actors_["1059ui_story"].transform
			local var_111_16 = 0

			if var_111_16 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.var_.moveOldPos1059ui_story = var_111_15.localPosition
			end

			local var_111_17 = 0.001

			if var_111_16 <= arg_108_1.time_ and arg_108_1.time_ < var_111_16 + var_111_17 then
				local var_111_18 = (arg_108_1.time_ - var_111_16) / var_111_17
				local var_111_19 = Vector3.New(0, 100, 0)

				var_111_15.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1059ui_story, var_111_19, var_111_18)

				local var_111_20 = manager.ui.mainCamera.transform.position - var_111_15.position

				var_111_15.forward = Vector3.New(var_111_20.x, var_111_20.y, var_111_20.z)

				local var_111_21 = var_111_15.localEulerAngles

				var_111_21.z = 0
				var_111_21.x = 0
				var_111_15.localEulerAngles = var_111_21
			end

			if arg_108_1.time_ >= var_111_16 + var_111_17 and arg_108_1.time_ < var_111_16 + var_111_17 + arg_111_0 then
				var_111_15.localPosition = Vector3.New(0, 100, 0)

				local var_111_22 = manager.ui.mainCamera.transform.position - var_111_15.position

				var_111_15.forward = Vector3.New(var_111_22.x, var_111_22.y, var_111_22.z)

				local var_111_23 = var_111_15.localEulerAngles

				var_111_23.z = 0
				var_111_23.x = 0
				var_111_15.localEulerAngles = var_111_23
			end

			local var_111_24 = 0
			local var_111_25 = 0.425

			if var_111_24 < arg_108_1.time_ and arg_108_1.time_ <= var_111_24 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0

				arg_108_1.dialog_:SetActive(true)

				arg_108_1.dialogCg_.alpha = 0

				local var_111_26 = LeanTween.value(arg_108_1.dialog_, 0, 1, 0.3)

				var_111_26:setOnUpdate(LuaHelper.FloatAction(function(arg_112_0)
					arg_108_1.dialogCg_.alpha = arg_112_0
				end))
				var_111_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_108_1.dialog_)
					var_111_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_108_1.duration_ = arg_108_1.duration_ + 0.3

				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_27 = arg_108_1:GetWordFromCfg(103071026)
				local var_111_28 = arg_108_1:FormatText(var_111_27.content)

				arg_108_1.text_.text = var_111_28

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_29 = 17
				local var_111_30 = utf8.len(var_111_28)
				local var_111_31 = var_111_29 <= 0 and var_111_25 or var_111_25 * (var_111_30 / var_111_29)

				if var_111_31 > 0 and var_111_25 < var_111_31 then
					arg_108_1.talkMaxDuration = var_111_31
					var_111_24 = var_111_24 + 0.3

					if var_111_31 + var_111_24 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_31 + var_111_24
					end
				end

				arg_108_1.text_.text = var_111_28
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_32 = var_111_24 + 0.3
			local var_111_33 = math.max(var_111_25, arg_108_1.talkMaxDuration)

			if var_111_32 <= arg_108_1.time_ and arg_108_1.time_ < var_111_32 + var_111_33 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_32) / var_111_33

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_32 + var_111_33 and arg_108_1.time_ < var_111_32 + var_111_33 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
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
	Play103071027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 103071027
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play103071028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = false

				arg_114_1:SetGaussion(false)
			end

			local var_117_1 = 0.5

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_1 then
				local var_117_2 = (arg_114_1.time_ - var_117_0) / var_117_1
				local var_117_3 = Color.New(1, 1, 1)

				var_117_3.a = Mathf.Lerp(1, 0, var_117_2)
				arg_114_1.mask_.color = var_117_3
			end

			if arg_114_1.time_ >= var_117_0 + var_117_1 and arg_114_1.time_ < var_117_0 + var_117_1 + arg_117_0 then
				local var_117_4 = Color.New(1, 1, 1)
				local var_117_5 = 0

				arg_114_1.mask_.enabled = false
				var_117_4.a = var_117_5
				arg_114_1.mask_.color = var_117_4
			end

			local var_117_6 = manager.ui.mainCamera.transform
			local var_117_7 = 0

			if var_117_7 < arg_114_1.time_ and arg_114_1.time_ <= var_117_7 + arg_117_0 then
				arg_114_1.var_.shakeOldPosMainCamera = var_117_6.localPosition
			end

			local var_117_8 = 0.600000023841858

			if var_117_7 <= arg_114_1.time_ and arg_114_1.time_ < var_117_7 + var_117_8 then
				local var_117_9 = (arg_114_1.time_ - var_117_7) / 0.066
				local var_117_10, var_117_11 = math.modf(var_117_9)

				var_117_6.localPosition = Vector3.New(var_117_11 * 0.13, var_117_11 * 0.13, var_117_11 * 0.13) + arg_114_1.var_.shakeOldPosMainCamera
			end

			if arg_114_1.time_ >= var_117_7 + var_117_8 and arg_114_1.time_ < var_117_7 + var_117_8 + arg_117_0 then
				var_117_6.localPosition = arg_114_1.var_.shakeOldPosMainCamera
			end

			local var_117_12 = 0
			local var_117_13 = 1.325

			if var_117_12 < arg_114_1.time_ and arg_114_1.time_ <= var_117_12 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_14 = arg_114_1:GetWordFromCfg(103071027)
				local var_117_15 = arg_114_1:FormatText(var_117_14.content)

				arg_114_1.text_.text = var_117_15

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_16 = 53
				local var_117_17 = utf8.len(var_117_15)
				local var_117_18 = var_117_16 <= 0 and var_117_13 or var_117_13 * (var_117_17 / var_117_16)

				if var_117_18 > 0 and var_117_13 < var_117_18 then
					arg_114_1.talkMaxDuration = var_117_18

					if var_117_18 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_18 + var_117_12
					end
				end

				arg_114_1.text_.text = var_117_15
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_19 = math.max(var_117_13, arg_114_1.talkMaxDuration)

			if var_117_12 <= arg_114_1.time_ and arg_114_1.time_ < var_117_12 + var_117_19 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_12) / var_117_19

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_12 + var_117_19 and arg_114_1.time_ < var_117_12 + var_117_19 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play103071028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 103071028
		arg_118_1.duration_ = 2

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play103071029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1059ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1059ui_story == nil then
				arg_118_1.var_.characterEffect1059ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.1

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1059ui_story and not isNil(var_121_0) then
					arg_118_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1059ui_story then
				arg_118_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_121_4 = arg_118_1.actors_["1059ui_story"].transform
			local var_121_5 = 0

			if var_121_5 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 then
				arg_118_1.var_.moveOldPos1059ui_story = var_121_4.localPosition
			end

			local var_121_6 = 0.001

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 then
				local var_121_7 = (arg_118_1.time_ - var_121_5) / var_121_6
				local var_121_8 = Vector3.New(-0.7, -1.05, -6)

				var_121_4.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1059ui_story, var_121_8, var_121_7)

				local var_121_9 = manager.ui.mainCamera.transform.position - var_121_4.position

				var_121_4.forward = Vector3.New(var_121_9.x, var_121_9.y, var_121_9.z)

				local var_121_10 = var_121_4.localEulerAngles

				var_121_10.z = 0
				var_121_10.x = 0
				var_121_4.localEulerAngles = var_121_10
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 then
				var_121_4.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_121_11 = manager.ui.mainCamera.transform.position - var_121_4.position

				var_121_4.forward = Vector3.New(var_121_11.x, var_121_11.y, var_121_11.z)

				local var_121_12 = var_121_4.localEulerAngles

				var_121_12.z = 0
				var_121_12.x = 0
				var_121_4.localEulerAngles = var_121_12
			end

			local var_121_13 = 0

			if var_121_13 < arg_118_1.time_ and arg_118_1.time_ <= var_121_13 + arg_121_0 then
				arg_118_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			local var_121_14 = 0

			if var_121_14 < arg_118_1.time_ and arg_118_1.time_ <= var_121_14 + arg_121_0 then
				arg_118_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_121_15 = 0
			local var_121_16 = 0.1

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_17 = arg_118_1:FormatText(StoryNameCfg[28].name)

				arg_118_1.leftNameTxt_.text = var_121_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_18 = arg_118_1:GetWordFromCfg(103071028)
				local var_121_19 = arg_118_1:FormatText(var_121_18.content)

				arg_118_1.text_.text = var_121_19

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_20 = 4
				local var_121_21 = utf8.len(var_121_19)
				local var_121_22 = var_121_20 <= 0 and var_121_16 or var_121_16 * (var_121_21 / var_121_20)

				if var_121_22 > 0 and var_121_16 < var_121_22 then
					arg_118_1.talkMaxDuration = var_121_22

					if var_121_22 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_22 + var_121_15
					end
				end

				arg_118_1.text_.text = var_121_19
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071028", "story_v_out_103071.awb") ~= 0 then
					local var_121_23 = manager.audio:GetVoiceLength("story_v_out_103071", "103071028", "story_v_out_103071.awb") / 1000

					if var_121_23 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_23 + var_121_15
					end

					if var_121_18.prefab_name ~= "" and arg_118_1.actors_[var_121_18.prefab_name] ~= nil then
						local var_121_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_18.prefab_name].transform, "story_v_out_103071", "103071028", "story_v_out_103071.awb")

						arg_118_1:RecordAudio("103071028", var_121_24)
						arg_118_1:RecordAudio("103071028", var_121_24)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_103071", "103071028", "story_v_out_103071.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_103071", "103071028", "story_v_out_103071.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_25 = math.max(var_121_16, arg_118_1.talkMaxDuration)

			if var_121_15 <= arg_118_1.time_ and arg_118_1.time_ < var_121_15 + var_121_25 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_15) / var_121_25

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_15 + var_121_25 and arg_118_1.time_ < var_121_15 + var_121_25 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play103071029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 103071029
		arg_122_1.duration_ = 2

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play103071030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 1

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				local var_125_2 = "play"
				local var_125_3 = "effect"

				arg_122_1:AudioAction(var_125_2, var_125_3, "se_story_1", "se_story_1_apollo_bow", "")
			end

			local var_125_4 = arg_122_1.actors_["1148ui_story"]
			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1148ui_story == nil then
				arg_122_1.var_.characterEffect1148ui_story = var_125_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_6 = 0.1

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_6 and not isNil(var_125_4) then
				local var_125_7 = (arg_122_1.time_ - var_125_5) / var_125_6

				if arg_122_1.var_.characterEffect1148ui_story and not isNil(var_125_4) then
					arg_122_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_5 + var_125_6 and arg_122_1.time_ < var_125_5 + var_125_6 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1148ui_story then
				arg_122_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_125_8 = arg_122_1.actors_["1059ui_story"]
			local var_125_9 = 0

			if var_125_9 < arg_122_1.time_ and arg_122_1.time_ <= var_125_9 + arg_125_0 and not isNil(var_125_8) and arg_122_1.var_.characterEffect1059ui_story == nil then
				arg_122_1.var_.characterEffect1059ui_story = var_125_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_10 = 0.1

			if var_125_9 <= arg_122_1.time_ and arg_122_1.time_ < var_125_9 + var_125_10 and not isNil(var_125_8) then
				local var_125_11 = (arg_122_1.time_ - var_125_9) / var_125_10

				if arg_122_1.var_.characterEffect1059ui_story and not isNil(var_125_8) then
					local var_125_12 = Mathf.Lerp(0, 0.5, var_125_11)

					arg_122_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1059ui_story.fillRatio = var_125_12
				end
			end

			if arg_122_1.time_ >= var_125_9 + var_125_10 and arg_122_1.time_ < var_125_9 + var_125_10 + arg_125_0 and not isNil(var_125_8) and arg_122_1.var_.characterEffect1059ui_story then
				local var_125_13 = 0.5

				arg_122_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1059ui_story.fillRatio = var_125_13
			end

			local var_125_14 = arg_122_1.actors_["1148ui_story"].transform
			local var_125_15 = 0

			if var_125_15 < arg_122_1.time_ and arg_122_1.time_ <= var_125_15 + arg_125_0 then
				arg_122_1.var_.moveOldPos1148ui_story = var_125_14.localPosition
			end

			local var_125_16 = 0.001

			if var_125_15 <= arg_122_1.time_ and arg_122_1.time_ < var_125_15 + var_125_16 then
				local var_125_17 = (arg_122_1.time_ - var_125_15) / var_125_16
				local var_125_18 = Vector3.New(0.7, -0.8, -6.2)

				var_125_14.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1148ui_story, var_125_18, var_125_17)

				local var_125_19 = manager.ui.mainCamera.transform.position - var_125_14.position

				var_125_14.forward = Vector3.New(var_125_19.x, var_125_19.y, var_125_19.z)

				local var_125_20 = var_125_14.localEulerAngles

				var_125_20.z = 0
				var_125_20.x = 0
				var_125_14.localEulerAngles = var_125_20
			end

			if arg_122_1.time_ >= var_125_15 + var_125_16 and arg_122_1.time_ < var_125_15 + var_125_16 + arg_125_0 then
				var_125_14.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_125_21 = manager.ui.mainCamera.transform.position - var_125_14.position

				var_125_14.forward = Vector3.New(var_125_21.x, var_125_21.y, var_125_21.z)

				local var_125_22 = var_125_14.localEulerAngles

				var_125_22.z = 0
				var_125_22.x = 0
				var_125_14.localEulerAngles = var_125_22
			end

			local var_125_23 = 0

			if var_125_23 < arg_122_1.time_ and arg_122_1.time_ <= var_125_23 + arg_125_0 then
				arg_122_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			local var_125_24 = 0

			if var_125_24 < arg_122_1.time_ and arg_122_1.time_ <= var_125_24 + arg_125_0 then
				arg_122_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_125_25 = 0
			local var_125_26 = 0.125

			if var_125_25 < arg_122_1.time_ and arg_122_1.time_ <= var_125_25 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_27 = arg_122_1:FormatText(StoryNameCfg[8].name)

				arg_122_1.leftNameTxt_.text = var_125_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_28 = arg_122_1:GetWordFromCfg(103071029)
				local var_125_29 = arg_122_1:FormatText(var_125_28.content)

				arg_122_1.text_.text = var_125_29

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_30 = 5
				local var_125_31 = utf8.len(var_125_29)
				local var_125_32 = var_125_30 <= 0 and var_125_26 or var_125_26 * (var_125_31 / var_125_30)

				if var_125_32 > 0 and var_125_26 < var_125_32 then
					arg_122_1.talkMaxDuration = var_125_32

					if var_125_32 + var_125_25 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_32 + var_125_25
					end
				end

				arg_122_1.text_.text = var_125_29
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071029", "story_v_out_103071.awb") ~= 0 then
					local var_125_33 = manager.audio:GetVoiceLength("story_v_out_103071", "103071029", "story_v_out_103071.awb") / 1000

					if var_125_33 + var_125_25 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_33 + var_125_25
					end

					if var_125_28.prefab_name ~= "" and arg_122_1.actors_[var_125_28.prefab_name] ~= nil then
						local var_125_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_28.prefab_name].transform, "story_v_out_103071", "103071029", "story_v_out_103071.awb")

						arg_122_1:RecordAudio("103071029", var_125_34)
						arg_122_1:RecordAudio("103071029", var_125_34)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_103071", "103071029", "story_v_out_103071.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_103071", "103071029", "story_v_out_103071.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_35 = math.max(var_125_26, arg_122_1.talkMaxDuration)

			if var_125_25 <= arg_122_1.time_ and arg_122_1.time_ < var_125_25 + var_125_35 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_25) / var_125_35

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_25 + var_125_35 and arg_122_1.time_ < var_125_25 + var_125_35 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play103071030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 103071030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play103071031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1148ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1148ui_story == nil then
				arg_126_1.var_.characterEffect1148ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.1

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1148ui_story and not isNil(var_129_0) then
					local var_129_4 = Mathf.Lerp(0, 0.5, var_129_3)

					arg_126_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1148ui_story.fillRatio = var_129_4
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1148ui_story then
				local var_129_5 = 0.5

				arg_126_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1148ui_story.fillRatio = var_129_5
			end

			local var_129_6 = arg_126_1.actors_["1059ui_story"].transform
			local var_129_7 = 0

			if var_129_7 < arg_126_1.time_ and arg_126_1.time_ <= var_129_7 + arg_129_0 then
				arg_126_1.var_.moveOldPos1059ui_story = var_129_6.localPosition
			end

			local var_129_8 = 0.001

			if var_129_7 <= arg_126_1.time_ and arg_126_1.time_ < var_129_7 + var_129_8 then
				local var_129_9 = (arg_126_1.time_ - var_129_7) / var_129_8
				local var_129_10 = Vector3.New(0, 100, 0)

				var_129_6.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1059ui_story, var_129_10, var_129_9)

				local var_129_11 = manager.ui.mainCamera.transform.position - var_129_6.position

				var_129_6.forward = Vector3.New(var_129_11.x, var_129_11.y, var_129_11.z)

				local var_129_12 = var_129_6.localEulerAngles

				var_129_12.z = 0
				var_129_12.x = 0
				var_129_6.localEulerAngles = var_129_12
			end

			if arg_126_1.time_ >= var_129_7 + var_129_8 and arg_126_1.time_ < var_129_7 + var_129_8 + arg_129_0 then
				var_129_6.localPosition = Vector3.New(0, 100, 0)

				local var_129_13 = manager.ui.mainCamera.transform.position - var_129_6.position

				var_129_6.forward = Vector3.New(var_129_13.x, var_129_13.y, var_129_13.z)

				local var_129_14 = var_129_6.localEulerAngles

				var_129_14.z = 0
				var_129_14.x = 0
				var_129_6.localEulerAngles = var_129_14
			end

			local var_129_15 = arg_126_1.actors_["1148ui_story"].transform
			local var_129_16 = 0

			if var_129_16 < arg_126_1.time_ and arg_126_1.time_ <= var_129_16 + arg_129_0 then
				arg_126_1.var_.moveOldPos1148ui_story = var_129_15.localPosition
			end

			local var_129_17 = 0.001

			if var_129_16 <= arg_126_1.time_ and arg_126_1.time_ < var_129_16 + var_129_17 then
				local var_129_18 = (arg_126_1.time_ - var_129_16) / var_129_17
				local var_129_19 = Vector3.New(0, 100, 0)

				var_129_15.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1148ui_story, var_129_19, var_129_18)

				local var_129_20 = manager.ui.mainCamera.transform.position - var_129_15.position

				var_129_15.forward = Vector3.New(var_129_20.x, var_129_20.y, var_129_20.z)

				local var_129_21 = var_129_15.localEulerAngles

				var_129_21.z = 0
				var_129_21.x = 0
				var_129_15.localEulerAngles = var_129_21
			end

			if arg_126_1.time_ >= var_129_16 + var_129_17 and arg_126_1.time_ < var_129_16 + var_129_17 + arg_129_0 then
				var_129_15.localPosition = Vector3.New(0, 100, 0)

				local var_129_22 = manager.ui.mainCamera.transform.position - var_129_15.position

				var_129_15.forward = Vector3.New(var_129_22.x, var_129_22.y, var_129_22.z)

				local var_129_23 = var_129_15.localEulerAngles

				var_129_23.z = 0
				var_129_23.x = 0
				var_129_15.localEulerAngles = var_129_23
			end

			local var_129_24 = 0
			local var_129_25 = 1.35

			if var_129_24 < arg_126_1.time_ and arg_126_1.time_ <= var_129_24 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_26 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_26:setOnUpdate(LuaHelper.FloatAction(function(arg_130_0)
					arg_126_1.dialogCg_.alpha = arg_130_0
				end))
				var_129_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_27 = arg_126_1:GetWordFromCfg(103071030)
				local var_129_28 = arg_126_1:FormatText(var_129_27.content)

				arg_126_1.text_.text = var_129_28

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_29 = 54
				local var_129_30 = utf8.len(var_129_28)
				local var_129_31 = var_129_29 <= 0 and var_129_25 or var_129_25 * (var_129_30 / var_129_29)

				if var_129_31 > 0 and var_129_25 < var_129_31 then
					arg_126_1.talkMaxDuration = var_129_31
					var_129_24 = var_129_24 + 0.3

					if var_129_31 + var_129_24 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_31 + var_129_24
					end
				end

				arg_126_1.text_.text = var_129_28
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_32 = var_129_24 + 0.3
			local var_129_33 = math.max(var_129_25, arg_126_1.talkMaxDuration)

			if var_129_32 <= arg_126_1.time_ and arg_126_1.time_ < var_129_32 + var_129_33 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_32) / var_129_33

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_32 + var_129_33 and arg_126_1.time_ < var_129_32 + var_129_33 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
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
	Play103071031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 103071031
		arg_132_1.duration_ = 4.8

		local var_132_0 = {
			ja = 3.4,
			ko = 4.8,
			zh = 3,
			en = 3.2
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
				arg_132_0:Play103071032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1148ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1148ui_story == nil then
				arg_132_1.var_.characterEffect1148ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.1

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1148ui_story and not isNil(var_135_0) then
					arg_132_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1148ui_story then
				arg_132_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_135_4 = arg_132_1.actors_["1148ui_story"].transform
			local var_135_5 = 0

			if var_135_5 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1.var_.moveOldPos1148ui_story = var_135_4.localPosition
			end

			local var_135_6 = 0.001

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_6 then
				local var_135_7 = (arg_132_1.time_ - var_135_5) / var_135_6
				local var_135_8 = Vector3.New(0, 100, 0)

				var_135_4.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1148ui_story, var_135_8, var_135_7)

				local var_135_9 = manager.ui.mainCamera.transform.position - var_135_4.position

				var_135_4.forward = Vector3.New(var_135_9.x, var_135_9.y, var_135_9.z)

				local var_135_10 = var_135_4.localEulerAngles

				var_135_10.z = 0
				var_135_10.x = 0
				var_135_4.localEulerAngles = var_135_10
			end

			if arg_132_1.time_ >= var_135_5 + var_135_6 and arg_132_1.time_ < var_135_5 + var_135_6 + arg_135_0 then
				var_135_4.localPosition = Vector3.New(0, 100, 0)

				local var_135_11 = manager.ui.mainCamera.transform.position - var_135_4.position

				var_135_4.forward = Vector3.New(var_135_11.x, var_135_11.y, var_135_11.z)

				local var_135_12 = var_135_4.localEulerAngles

				var_135_12.z = 0
				var_135_12.x = 0
				var_135_4.localEulerAngles = var_135_12
			end

			local var_135_13 = 0

			if var_135_13 < arg_132_1.time_ and arg_132_1.time_ <= var_135_13 + arg_135_0 then
				arg_132_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action8_2")
			end

			local var_135_14 = 0

			if var_135_14 < arg_132_1.time_ and arg_132_1.time_ <= var_135_14 + arg_135_0 then
				arg_132_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_135_15 = 0
			local var_135_16 = 0.225

			if var_135_15 < arg_132_1.time_ and arg_132_1.time_ <= var_135_15 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_17 = arg_132_1:FormatText(StoryNameCfg[8].name)

				arg_132_1.leftNameTxt_.text = var_135_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_18 = arg_132_1:GetWordFromCfg(103071031)
				local var_135_19 = arg_132_1:FormatText(var_135_18.content)

				arg_132_1.text_.text = var_135_19

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_20 = 9
				local var_135_21 = utf8.len(var_135_19)
				local var_135_22 = var_135_20 <= 0 and var_135_16 or var_135_16 * (var_135_21 / var_135_20)

				if var_135_22 > 0 and var_135_16 < var_135_22 then
					arg_132_1.talkMaxDuration = var_135_22

					if var_135_22 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_22 + var_135_15
					end
				end

				arg_132_1.text_.text = var_135_19
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071031", "story_v_out_103071.awb") ~= 0 then
					local var_135_23 = manager.audio:GetVoiceLength("story_v_out_103071", "103071031", "story_v_out_103071.awb") / 1000

					if var_135_23 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_23 + var_135_15
					end

					if var_135_18.prefab_name ~= "" and arg_132_1.actors_[var_135_18.prefab_name] ~= nil then
						local var_135_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_18.prefab_name].transform, "story_v_out_103071", "103071031", "story_v_out_103071.awb")

						arg_132_1:RecordAudio("103071031", var_135_24)
						arg_132_1:RecordAudio("103071031", var_135_24)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_103071", "103071031", "story_v_out_103071.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_103071", "103071031", "story_v_out_103071.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_25 = math.max(var_135_16, arg_132_1.talkMaxDuration)

			if var_135_15 <= arg_132_1.time_ and arg_132_1.time_ < var_135_15 + var_135_25 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_15) / var_135_25

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_15 + var_135_25 and arg_132_1.time_ < var_135_15 + var_135_25 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play103071032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 103071032
		arg_136_1.duration_ = 8.7

		local var_136_0 = {
			ja = 8.7,
			ko = 4.3,
			zh = 6.6,
			en = 7.266
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
				arg_136_0:Play103071033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1059ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1059ui_story == nil then
				arg_136_1.var_.characterEffect1059ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.1

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1059ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1059ui_story then
				arg_136_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_139_4 = arg_136_1.actors_["1148ui_story"]
			local var_139_5 = 0

			if var_139_5 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1148ui_story == nil then
				arg_136_1.var_.characterEffect1148ui_story = var_139_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_6 = 0.1

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_6 and not isNil(var_139_4) then
				local var_139_7 = (arg_136_1.time_ - var_139_5) / var_139_6

				if arg_136_1.var_.characterEffect1148ui_story and not isNil(var_139_4) then
					local var_139_8 = Mathf.Lerp(0, 0.5, var_139_7)

					arg_136_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1148ui_story.fillRatio = var_139_8
				end
			end

			if arg_136_1.time_ >= var_139_5 + var_139_6 and arg_136_1.time_ < var_139_5 + var_139_6 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1148ui_story then
				local var_139_9 = 0.5

				arg_136_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1148ui_story.fillRatio = var_139_9
			end

			local var_139_10 = arg_136_1.actors_["1148ui_story"].transform
			local var_139_11 = 0

			if var_139_11 < arg_136_1.time_ and arg_136_1.time_ <= var_139_11 + arg_139_0 then
				arg_136_1.var_.moveOldPos1148ui_story = var_139_10.localPosition
			end

			local var_139_12 = 0.001

			if var_139_11 <= arg_136_1.time_ and arg_136_1.time_ < var_139_11 + var_139_12 then
				local var_139_13 = (arg_136_1.time_ - var_139_11) / var_139_12
				local var_139_14 = Vector3.New(0, 100, 0)

				var_139_10.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1148ui_story, var_139_14, var_139_13)

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

			local var_139_19 = arg_136_1.actors_["1059ui_story"].transform
			local var_139_20 = 0

			if var_139_20 < arg_136_1.time_ and arg_136_1.time_ <= var_139_20 + arg_139_0 then
				arg_136_1.var_.moveOldPos1059ui_story = var_139_19.localPosition
			end

			local var_139_21 = 0.001

			if var_139_20 <= arg_136_1.time_ and arg_136_1.time_ < var_139_20 + var_139_21 then
				local var_139_22 = (arg_136_1.time_ - var_139_20) / var_139_21
				local var_139_23 = Vector3.New(0, -1.05, -6)

				var_139_19.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1059ui_story, var_139_23, var_139_22)

				local var_139_24 = manager.ui.mainCamera.transform.position - var_139_19.position

				var_139_19.forward = Vector3.New(var_139_24.x, var_139_24.y, var_139_24.z)

				local var_139_25 = var_139_19.localEulerAngles

				var_139_25.z = 0
				var_139_25.x = 0
				var_139_19.localEulerAngles = var_139_25
			end

			if arg_136_1.time_ >= var_139_20 + var_139_21 and arg_136_1.time_ < var_139_20 + var_139_21 + arg_139_0 then
				var_139_19.localPosition = Vector3.New(0, -1.05, -6)

				local var_139_26 = manager.ui.mainCamera.transform.position - var_139_19.position

				var_139_19.forward = Vector3.New(var_139_26.x, var_139_26.y, var_139_26.z)

				local var_139_27 = var_139_19.localEulerAngles

				var_139_27.z = 0
				var_139_27.x = 0
				var_139_19.localEulerAngles = var_139_27
			end

			local var_139_28 = 0

			if var_139_28 < arg_136_1.time_ and arg_136_1.time_ <= var_139_28 + arg_139_0 then
				arg_136_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action6_1")
			end

			local var_139_29 = 0

			if var_139_29 < arg_136_1.time_ and arg_136_1.time_ <= var_139_29 + arg_139_0 then
				arg_136_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_139_30 = 0
			local var_139_31 = 0.725

			if var_139_30 < arg_136_1.time_ and arg_136_1.time_ <= var_139_30 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_32 = arg_136_1:FormatText(StoryNameCfg[28].name)

				arg_136_1.leftNameTxt_.text = var_139_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_33 = arg_136_1:GetWordFromCfg(103071032)
				local var_139_34 = arg_136_1:FormatText(var_139_33.content)

				arg_136_1.text_.text = var_139_34

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_35 = 29
				local var_139_36 = utf8.len(var_139_34)
				local var_139_37 = var_139_35 <= 0 and var_139_31 or var_139_31 * (var_139_36 / var_139_35)

				if var_139_37 > 0 and var_139_31 < var_139_37 then
					arg_136_1.talkMaxDuration = var_139_37

					if var_139_37 + var_139_30 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_37 + var_139_30
					end
				end

				arg_136_1.text_.text = var_139_34
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071032", "story_v_out_103071.awb") ~= 0 then
					local var_139_38 = manager.audio:GetVoiceLength("story_v_out_103071", "103071032", "story_v_out_103071.awb") / 1000

					if var_139_38 + var_139_30 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_38 + var_139_30
					end

					if var_139_33.prefab_name ~= "" and arg_136_1.actors_[var_139_33.prefab_name] ~= nil then
						local var_139_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_33.prefab_name].transform, "story_v_out_103071", "103071032", "story_v_out_103071.awb")

						arg_136_1:RecordAudio("103071032", var_139_39)
						arg_136_1:RecordAudio("103071032", var_139_39)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_103071", "103071032", "story_v_out_103071.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_103071", "103071032", "story_v_out_103071.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_40 = math.max(var_139_31, arg_136_1.talkMaxDuration)

			if var_139_30 <= arg_136_1.time_ and arg_136_1.time_ < var_139_30 + var_139_40 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_30) / var_139_40

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_30 + var_139_40 and arg_136_1.time_ < var_139_30 + var_139_40 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
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
	Play103071033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 103071033
		arg_140_1.duration_ = 10.17

		local var_140_0 = {
			ja = 10.166,
			ko = 5.766,
			zh = 5.733,
			en = 6.566
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
				arg_140_0:Play103071034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1148ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1148ui_story == nil then
				arg_140_1.var_.characterEffect1148ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.1

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1148ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1148ui_story then
				arg_140_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_143_4 = arg_140_1.actors_["1059ui_story"]
			local var_143_5 = 0

			if var_143_5 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect1059ui_story == nil then
				arg_140_1.var_.characterEffect1059ui_story = var_143_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_6 = 0.1

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_6 and not isNil(var_143_4) then
				local var_143_7 = (arg_140_1.time_ - var_143_5) / var_143_6

				if arg_140_1.var_.characterEffect1059ui_story and not isNil(var_143_4) then
					local var_143_8 = Mathf.Lerp(0, 0.5, var_143_7)

					arg_140_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1059ui_story.fillRatio = var_143_8
				end
			end

			if arg_140_1.time_ >= var_143_5 + var_143_6 and arg_140_1.time_ < var_143_5 + var_143_6 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect1059ui_story then
				local var_143_9 = 0.5

				arg_140_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1059ui_story.fillRatio = var_143_9
			end

			local var_143_10 = arg_140_1.actors_["1059ui_story"].transform
			local var_143_11 = 0

			if var_143_11 < arg_140_1.time_ and arg_140_1.time_ <= var_143_11 + arg_143_0 then
				arg_140_1.var_.moveOldPos1059ui_story = var_143_10.localPosition
			end

			local var_143_12 = 0.001

			if var_143_11 <= arg_140_1.time_ and arg_140_1.time_ < var_143_11 + var_143_12 then
				local var_143_13 = (arg_140_1.time_ - var_143_11) / var_143_12
				local var_143_14 = Vector3.New(-0.7, -1.05, -6)

				var_143_10.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1059ui_story, var_143_14, var_143_13)

				local var_143_15 = manager.ui.mainCamera.transform.position - var_143_10.position

				var_143_10.forward = Vector3.New(var_143_15.x, var_143_15.y, var_143_15.z)

				local var_143_16 = var_143_10.localEulerAngles

				var_143_16.z = 0
				var_143_16.x = 0
				var_143_10.localEulerAngles = var_143_16
			end

			if arg_140_1.time_ >= var_143_11 + var_143_12 and arg_140_1.time_ < var_143_11 + var_143_12 + arg_143_0 then
				var_143_10.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_143_17 = manager.ui.mainCamera.transform.position - var_143_10.position

				var_143_10.forward = Vector3.New(var_143_17.x, var_143_17.y, var_143_17.z)

				local var_143_18 = var_143_10.localEulerAngles

				var_143_18.z = 0
				var_143_18.x = 0
				var_143_10.localEulerAngles = var_143_18
			end

			local var_143_19 = arg_140_1.actors_["1059ui_story"].transform
			local var_143_20 = 0.033

			if var_143_20 < arg_140_1.time_ and arg_140_1.time_ <= var_143_20 + arg_143_0 then
				arg_140_1.var_.moveOldPos1059ui_story = var_143_19.localPosition
			end

			local var_143_21 = 0.5

			if var_143_20 <= arg_140_1.time_ and arg_140_1.time_ < var_143_20 + var_143_21 then
				local var_143_22 = (arg_140_1.time_ - var_143_20) / var_143_21
				local var_143_23 = Vector3.New(-0.7, -1.05, -6)

				var_143_19.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1059ui_story, var_143_23, var_143_22)

				local var_143_24 = manager.ui.mainCamera.transform.position - var_143_19.position

				var_143_19.forward = Vector3.New(var_143_24.x, var_143_24.y, var_143_24.z)

				local var_143_25 = var_143_19.localEulerAngles

				var_143_25.z = 0
				var_143_25.x = 0
				var_143_19.localEulerAngles = var_143_25
			end

			if arg_140_1.time_ >= var_143_20 + var_143_21 and arg_140_1.time_ < var_143_20 + var_143_21 + arg_143_0 then
				var_143_19.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_143_26 = manager.ui.mainCamera.transform.position - var_143_19.position

				var_143_19.forward = Vector3.New(var_143_26.x, var_143_26.y, var_143_26.z)

				local var_143_27 = var_143_19.localEulerAngles

				var_143_27.z = 0
				var_143_27.x = 0
				var_143_19.localEulerAngles = var_143_27
			end

			local var_143_28 = arg_140_1.actors_["1148ui_story"].transform
			local var_143_29 = 0

			if var_143_29 < arg_140_1.time_ and arg_140_1.time_ <= var_143_29 + arg_143_0 then
				arg_140_1.var_.moveOldPos1148ui_story = var_143_28.localPosition
			end

			local var_143_30 = 0.001

			if var_143_29 <= arg_140_1.time_ and arg_140_1.time_ < var_143_29 + var_143_30 then
				local var_143_31 = (arg_140_1.time_ - var_143_29) / var_143_30
				local var_143_32 = Vector3.New(0.7, -0.8, -6.2)

				var_143_28.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1148ui_story, var_143_32, var_143_31)

				local var_143_33 = manager.ui.mainCamera.transform.position - var_143_28.position

				var_143_28.forward = Vector3.New(var_143_33.x, var_143_33.y, var_143_33.z)

				local var_143_34 = var_143_28.localEulerAngles

				var_143_34.z = 0
				var_143_34.x = 0
				var_143_28.localEulerAngles = var_143_34
			end

			if arg_140_1.time_ >= var_143_29 + var_143_30 and arg_140_1.time_ < var_143_29 + var_143_30 + arg_143_0 then
				var_143_28.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_143_35 = manager.ui.mainCamera.transform.position - var_143_28.position

				var_143_28.forward = Vector3.New(var_143_35.x, var_143_35.y, var_143_35.z)

				local var_143_36 = var_143_28.localEulerAngles

				var_143_36.z = 0
				var_143_36.x = 0
				var_143_28.localEulerAngles = var_143_36
			end

			local var_143_37 = 0

			if var_143_37 < arg_140_1.time_ and arg_140_1.time_ <= var_143_37 + arg_143_0 then
				arg_140_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_143_38 = 0

			if var_143_38 < arg_140_1.time_ and arg_140_1.time_ <= var_143_38 + arg_143_0 then
				arg_140_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_143_39 = 0
			local var_143_40 = 0.8

			if var_143_39 < arg_140_1.time_ and arg_140_1.time_ <= var_143_39 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_41 = arg_140_1:FormatText(StoryNameCfg[8].name)

				arg_140_1.leftNameTxt_.text = var_143_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_42 = arg_140_1:GetWordFromCfg(103071033)
				local var_143_43 = arg_140_1:FormatText(var_143_42.content)

				arg_140_1.text_.text = var_143_43

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_44 = 32
				local var_143_45 = utf8.len(var_143_43)
				local var_143_46 = var_143_44 <= 0 and var_143_40 or var_143_40 * (var_143_45 / var_143_44)

				if var_143_46 > 0 and var_143_40 < var_143_46 then
					arg_140_1.talkMaxDuration = var_143_46

					if var_143_46 + var_143_39 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_46 + var_143_39
					end
				end

				arg_140_1.text_.text = var_143_43
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071033", "story_v_out_103071.awb") ~= 0 then
					local var_143_47 = manager.audio:GetVoiceLength("story_v_out_103071", "103071033", "story_v_out_103071.awb") / 1000

					if var_143_47 + var_143_39 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_47 + var_143_39
					end

					if var_143_42.prefab_name ~= "" and arg_140_1.actors_[var_143_42.prefab_name] ~= nil then
						local var_143_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_42.prefab_name].transform, "story_v_out_103071", "103071033", "story_v_out_103071.awb")

						arg_140_1:RecordAudio("103071033", var_143_48)
						arg_140_1:RecordAudio("103071033", var_143_48)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_103071", "103071033", "story_v_out_103071.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_103071", "103071033", "story_v_out_103071.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_49 = math.max(var_143_40, arg_140_1.talkMaxDuration)

			if var_143_39 <= arg_140_1.time_ and arg_140_1.time_ < var_143_39 + var_143_49 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_39) / var_143_49

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_39 + var_143_49 and arg_140_1.time_ < var_143_39 + var_143_49 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play103071034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 103071034
		arg_144_1.duration_ = 10.5

		local var_144_0 = {
			ja = 10.5,
			ko = 8.733,
			zh = 7.5,
			en = 8.2
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
				arg_144_0:Play103071035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1059ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1059ui_story == nil then
				arg_144_1.var_.characterEffect1059ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.1

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1059ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1059ui_story then
				arg_144_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_147_4 = arg_144_1.actors_["1148ui_story"]
			local var_147_5 = 0

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect1148ui_story == nil then
				arg_144_1.var_.characterEffect1148ui_story = var_147_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_6 = 0.1

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_6 and not isNil(var_147_4) then
				local var_147_7 = (arg_144_1.time_ - var_147_5) / var_147_6

				if arg_144_1.var_.characterEffect1148ui_story and not isNil(var_147_4) then
					local var_147_8 = Mathf.Lerp(0, 0.5, var_147_7)

					arg_144_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1148ui_story.fillRatio = var_147_8
				end
			end

			if arg_144_1.time_ >= var_147_5 + var_147_6 and arg_144_1.time_ < var_147_5 + var_147_6 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect1148ui_story then
				local var_147_9 = 0.5

				arg_144_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1148ui_story.fillRatio = var_147_9
			end

			local var_147_10 = 0

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 then
				arg_144_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action464")
			end

			local var_147_11 = 0

			if var_147_11 < arg_144_1.time_ and arg_144_1.time_ <= var_147_11 + arg_147_0 then
				arg_144_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_147_12 = 0
			local var_147_13 = 0.925

			if var_147_12 < arg_144_1.time_ and arg_144_1.time_ <= var_147_12 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_14 = arg_144_1:FormatText(StoryNameCfg[28].name)

				arg_144_1.leftNameTxt_.text = var_147_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_15 = arg_144_1:GetWordFromCfg(103071034)
				local var_147_16 = arg_144_1:FormatText(var_147_15.content)

				arg_144_1.text_.text = var_147_16

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_17 = 37
				local var_147_18 = utf8.len(var_147_16)
				local var_147_19 = var_147_17 <= 0 and var_147_13 or var_147_13 * (var_147_18 / var_147_17)

				if var_147_19 > 0 and var_147_13 < var_147_19 then
					arg_144_1.talkMaxDuration = var_147_19

					if var_147_19 + var_147_12 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_19 + var_147_12
					end
				end

				arg_144_1.text_.text = var_147_16
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071034", "story_v_out_103071.awb") ~= 0 then
					local var_147_20 = manager.audio:GetVoiceLength("story_v_out_103071", "103071034", "story_v_out_103071.awb") / 1000

					if var_147_20 + var_147_12 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_20 + var_147_12
					end

					if var_147_15.prefab_name ~= "" and arg_144_1.actors_[var_147_15.prefab_name] ~= nil then
						local var_147_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_15.prefab_name].transform, "story_v_out_103071", "103071034", "story_v_out_103071.awb")

						arg_144_1:RecordAudio("103071034", var_147_21)
						arg_144_1:RecordAudio("103071034", var_147_21)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_103071", "103071034", "story_v_out_103071.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_103071", "103071034", "story_v_out_103071.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_22 = math.max(var_147_13, arg_144_1.talkMaxDuration)

			if var_147_12 <= arg_144_1.time_ and arg_144_1.time_ < var_147_12 + var_147_22 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_12) / var_147_22

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_12 + var_147_22 and arg_144_1.time_ < var_147_12 + var_147_22 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play103071035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 103071035
		arg_148_1.duration_ = 8.37

		local var_148_0 = {
			ja = 8.366,
			ko = 7.166,
			zh = 7.4,
			en = 6.8
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
				arg_148_0:Play103071036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1035ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1035ui_story == nil then
				arg_148_1.var_.characterEffect1035ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.1

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect1035ui_story and not isNil(var_151_0) then
					arg_148_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1035ui_story then
				arg_148_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_151_4 = arg_148_1.actors_["1059ui_story"].transform
			local var_151_5 = 0

			if var_151_5 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1.var_.moveOldPos1059ui_story = var_151_4.localPosition
			end

			local var_151_6 = 0.001

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_6 then
				local var_151_7 = (arg_148_1.time_ - var_151_5) / var_151_6
				local var_151_8 = Vector3.New(0, 100, 0)

				var_151_4.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1059ui_story, var_151_8, var_151_7)

				local var_151_9 = manager.ui.mainCamera.transform.position - var_151_4.position

				var_151_4.forward = Vector3.New(var_151_9.x, var_151_9.y, var_151_9.z)

				local var_151_10 = var_151_4.localEulerAngles

				var_151_10.z = 0
				var_151_10.x = 0
				var_151_4.localEulerAngles = var_151_10
			end

			if arg_148_1.time_ >= var_151_5 + var_151_6 and arg_148_1.time_ < var_151_5 + var_151_6 + arg_151_0 then
				var_151_4.localPosition = Vector3.New(0, 100, 0)

				local var_151_11 = manager.ui.mainCamera.transform.position - var_151_4.position

				var_151_4.forward = Vector3.New(var_151_11.x, var_151_11.y, var_151_11.z)

				local var_151_12 = var_151_4.localEulerAngles

				var_151_12.z = 0
				var_151_12.x = 0
				var_151_4.localEulerAngles = var_151_12
			end

			local var_151_13 = arg_148_1.actors_["1148ui_story"].transform
			local var_151_14 = 0

			if var_151_14 < arg_148_1.time_ and arg_148_1.time_ <= var_151_14 + arg_151_0 then
				arg_148_1.var_.moveOldPos1148ui_story = var_151_13.localPosition
			end

			local var_151_15 = 0.001

			if var_151_14 <= arg_148_1.time_ and arg_148_1.time_ < var_151_14 + var_151_15 then
				local var_151_16 = (arg_148_1.time_ - var_151_14) / var_151_15
				local var_151_17 = Vector3.New(0, 100, 0)

				var_151_13.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1148ui_story, var_151_17, var_151_16)

				local var_151_18 = manager.ui.mainCamera.transform.position - var_151_13.position

				var_151_13.forward = Vector3.New(var_151_18.x, var_151_18.y, var_151_18.z)

				local var_151_19 = var_151_13.localEulerAngles

				var_151_19.z = 0
				var_151_19.x = 0
				var_151_13.localEulerAngles = var_151_19
			end

			if arg_148_1.time_ >= var_151_14 + var_151_15 and arg_148_1.time_ < var_151_14 + var_151_15 + arg_151_0 then
				var_151_13.localPosition = Vector3.New(0, 100, 0)

				local var_151_20 = manager.ui.mainCamera.transform.position - var_151_13.position

				var_151_13.forward = Vector3.New(var_151_20.x, var_151_20.y, var_151_20.z)

				local var_151_21 = var_151_13.localEulerAngles

				var_151_21.z = 0
				var_151_21.x = 0
				var_151_13.localEulerAngles = var_151_21
			end

			local var_151_22 = arg_148_1.actors_["1035ui_story"].transform
			local var_151_23 = 0

			if var_151_23 < arg_148_1.time_ and arg_148_1.time_ <= var_151_23 + arg_151_0 then
				arg_148_1.var_.moveOldPos1035ui_story = var_151_22.localPosition
			end

			local var_151_24 = 0.001

			if var_151_23 <= arg_148_1.time_ and arg_148_1.time_ < var_151_23 + var_151_24 then
				local var_151_25 = (arg_148_1.time_ - var_151_23) / var_151_24
				local var_151_26 = Vector3.New(0, -1.05, -5.6)

				var_151_22.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1035ui_story, var_151_26, var_151_25)

				local var_151_27 = manager.ui.mainCamera.transform.position - var_151_22.position

				var_151_22.forward = Vector3.New(var_151_27.x, var_151_27.y, var_151_27.z)

				local var_151_28 = var_151_22.localEulerAngles

				var_151_28.z = 0
				var_151_28.x = 0
				var_151_22.localEulerAngles = var_151_28
			end

			if arg_148_1.time_ >= var_151_23 + var_151_24 and arg_148_1.time_ < var_151_23 + var_151_24 + arg_151_0 then
				var_151_22.localPosition = Vector3.New(0, -1.05, -5.6)

				local var_151_29 = manager.ui.mainCamera.transform.position - var_151_22.position

				var_151_22.forward = Vector3.New(var_151_29.x, var_151_29.y, var_151_29.z)

				local var_151_30 = var_151_22.localEulerAngles

				var_151_30.z = 0
				var_151_30.x = 0
				var_151_22.localEulerAngles = var_151_30
			end

			local var_151_31 = 0

			if var_151_31 < arg_148_1.time_ and arg_148_1.time_ <= var_151_31 + arg_151_0 then
				arg_148_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action8_1")
			end

			local var_151_32 = 0
			local var_151_33 = 0.825

			if var_151_32 < arg_148_1.time_ and arg_148_1.time_ <= var_151_32 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_34 = arg_148_1:FormatText(StoryNameCfg[21].name)

				arg_148_1.leftNameTxt_.text = var_151_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_35 = arg_148_1:GetWordFromCfg(103071035)
				local var_151_36 = arg_148_1:FormatText(var_151_35.content)

				arg_148_1.text_.text = var_151_36

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_37 = 33
				local var_151_38 = utf8.len(var_151_36)
				local var_151_39 = var_151_37 <= 0 and var_151_33 or var_151_33 * (var_151_38 / var_151_37)

				if var_151_39 > 0 and var_151_33 < var_151_39 then
					arg_148_1.talkMaxDuration = var_151_39

					if var_151_39 + var_151_32 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_39 + var_151_32
					end
				end

				arg_148_1.text_.text = var_151_36
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071035", "story_v_out_103071.awb") ~= 0 then
					local var_151_40 = manager.audio:GetVoiceLength("story_v_out_103071", "103071035", "story_v_out_103071.awb") / 1000

					if var_151_40 + var_151_32 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_40 + var_151_32
					end

					if var_151_35.prefab_name ~= "" and arg_148_1.actors_[var_151_35.prefab_name] ~= nil then
						local var_151_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_35.prefab_name].transform, "story_v_out_103071", "103071035", "story_v_out_103071.awb")

						arg_148_1:RecordAudio("103071035", var_151_41)
						arg_148_1:RecordAudio("103071035", var_151_41)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_103071", "103071035", "story_v_out_103071.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_103071", "103071035", "story_v_out_103071.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_42 = math.max(var_151_33, arg_148_1.talkMaxDuration)

			if var_151_32 <= arg_148_1.time_ and arg_148_1.time_ < var_151_32 + var_151_42 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_32) / var_151_42

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_32 + var_151_42 and arg_148_1.time_ < var_151_32 + var_151_42 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
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

		arg_148_1:InitPlayNodeList()
	end,
	Play103071036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 103071036
		arg_152_1.duration_ = 6

		local var_152_0 = {
			ja = 6,
			ko = 3.866,
			zh = 3.866,
			en = 4.4
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
				arg_152_0:Play103071037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1059ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1059ui_story == nil then
				arg_152_1.var_.characterEffect1059ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.1

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect1059ui_story and not isNil(var_155_0) then
					arg_152_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1059ui_story then
				arg_152_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_155_4 = arg_152_1.actors_["1059ui_story"].transform
			local var_155_5 = 0

			if var_155_5 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 then
				arg_152_1.var_.moveOldPos1059ui_story = var_155_4.localPosition
			end

			local var_155_6 = 0.001

			if var_155_5 <= arg_152_1.time_ and arg_152_1.time_ < var_155_5 + var_155_6 then
				local var_155_7 = (arg_152_1.time_ - var_155_5) / var_155_6
				local var_155_8 = Vector3.New(0, -1.05, -6)

				var_155_4.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1059ui_story, var_155_8, var_155_7)

				local var_155_9 = manager.ui.mainCamera.transform.position - var_155_4.position

				var_155_4.forward = Vector3.New(var_155_9.x, var_155_9.y, var_155_9.z)

				local var_155_10 = var_155_4.localEulerAngles

				var_155_10.z = 0
				var_155_10.x = 0
				var_155_4.localEulerAngles = var_155_10
			end

			if arg_152_1.time_ >= var_155_5 + var_155_6 and arg_152_1.time_ < var_155_5 + var_155_6 + arg_155_0 then
				var_155_4.localPosition = Vector3.New(0, -1.05, -6)

				local var_155_11 = manager.ui.mainCamera.transform.position - var_155_4.position

				var_155_4.forward = Vector3.New(var_155_11.x, var_155_11.y, var_155_11.z)

				local var_155_12 = var_155_4.localEulerAngles

				var_155_12.z = 0
				var_155_12.x = 0
				var_155_4.localEulerAngles = var_155_12
			end

			local var_155_13 = 0

			if var_155_13 < arg_152_1.time_ and arg_152_1.time_ <= var_155_13 + arg_155_0 then
				arg_152_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			local var_155_14 = arg_152_1.actors_["1035ui_story"].transform
			local var_155_15 = 0

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.var_.moveOldPos1035ui_story = var_155_14.localPosition
			end

			local var_155_16 = 0.001

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_16 then
				local var_155_17 = (arg_152_1.time_ - var_155_15) / var_155_16
				local var_155_18 = Vector3.New(0, 100, 0)

				var_155_14.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1035ui_story, var_155_18, var_155_17)

				local var_155_19 = manager.ui.mainCamera.transform.position - var_155_14.position

				var_155_14.forward = Vector3.New(var_155_19.x, var_155_19.y, var_155_19.z)

				local var_155_20 = var_155_14.localEulerAngles

				var_155_20.z = 0
				var_155_20.x = 0
				var_155_14.localEulerAngles = var_155_20
			end

			if arg_152_1.time_ >= var_155_15 + var_155_16 and arg_152_1.time_ < var_155_15 + var_155_16 + arg_155_0 then
				var_155_14.localPosition = Vector3.New(0, 100, 0)

				local var_155_21 = manager.ui.mainCamera.transform.position - var_155_14.position

				var_155_14.forward = Vector3.New(var_155_21.x, var_155_21.y, var_155_21.z)

				local var_155_22 = var_155_14.localEulerAngles

				var_155_22.z = 0
				var_155_22.x = 0
				var_155_14.localEulerAngles = var_155_22
			end

			local var_155_23 = 0

			if var_155_23 < arg_152_1.time_ and arg_152_1.time_ <= var_155_23 + arg_155_0 then
				arg_152_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_155_24 = 0
			local var_155_25 = 0.45

			if var_155_24 < arg_152_1.time_ and arg_152_1.time_ <= var_155_24 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_26 = arg_152_1:FormatText(StoryNameCfg[28].name)

				arg_152_1.leftNameTxt_.text = var_155_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_27 = arg_152_1:GetWordFromCfg(103071036)
				local var_155_28 = arg_152_1:FormatText(var_155_27.content)

				arg_152_1.text_.text = var_155_28

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_29 = 18
				local var_155_30 = utf8.len(var_155_28)
				local var_155_31 = var_155_29 <= 0 and var_155_25 or var_155_25 * (var_155_30 / var_155_29)

				if var_155_31 > 0 and var_155_25 < var_155_31 then
					arg_152_1.talkMaxDuration = var_155_31

					if var_155_31 + var_155_24 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_31 + var_155_24
					end
				end

				arg_152_1.text_.text = var_155_28
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071036", "story_v_out_103071.awb") ~= 0 then
					local var_155_32 = manager.audio:GetVoiceLength("story_v_out_103071", "103071036", "story_v_out_103071.awb") / 1000

					if var_155_32 + var_155_24 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_32 + var_155_24
					end

					if var_155_27.prefab_name ~= "" and arg_152_1.actors_[var_155_27.prefab_name] ~= nil then
						local var_155_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_27.prefab_name].transform, "story_v_out_103071", "103071036", "story_v_out_103071.awb")

						arg_152_1:RecordAudio("103071036", var_155_33)
						arg_152_1:RecordAudio("103071036", var_155_33)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_103071", "103071036", "story_v_out_103071.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_103071", "103071036", "story_v_out_103071.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_34 = math.max(var_155_25, arg_152_1.talkMaxDuration)

			if var_155_24 <= arg_152_1.time_ and arg_152_1.time_ < var_155_24 + var_155_34 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_24) / var_155_34

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_24 + var_155_34 and arg_152_1.time_ < var_155_24 + var_155_34 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
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

		arg_152_1:InitPlayNodeList()
	end,
	Play103071037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 103071037
		arg_156_1.duration_ = 4

		local var_156_0 = {
			ja = 4,
			ko = 2.833,
			zh = 2.866,
			en = 2.566
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
			arg_156_1.auto_ = false
		end

		function arg_156_1.playNext_(arg_158_0)
			arg_156_1.onStoryFinished_()
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action423")
			end

			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_159_2 = 0
			local var_159_3 = 0.225

			if var_159_2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_2 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_4 = arg_156_1:FormatText(StoryNameCfg[28].name)

				arg_156_1.leftNameTxt_.text = var_159_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_5 = arg_156_1:GetWordFromCfg(103071037)
				local var_159_6 = arg_156_1:FormatText(var_159_5.content)

				arg_156_1.text_.text = var_159_6

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_7 = 9
				local var_159_8 = utf8.len(var_159_6)
				local var_159_9 = var_159_7 <= 0 and var_159_3 or var_159_3 * (var_159_8 / var_159_7)

				if var_159_9 > 0 and var_159_3 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_2
					end
				end

				arg_156_1.text_.text = var_159_6
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071037", "story_v_out_103071.awb") ~= 0 then
					local var_159_10 = manager.audio:GetVoiceLength("story_v_out_103071", "103071037", "story_v_out_103071.awb") / 1000

					if var_159_10 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_2
					end

					if var_159_5.prefab_name ~= "" and arg_156_1.actors_[var_159_5.prefab_name] ~= nil then
						local var_159_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_5.prefab_name].transform, "story_v_out_103071", "103071037", "story_v_out_103071.awb")

						arg_156_1:RecordAudio("103071037", var_159_11)
						arg_156_1:RecordAudio("103071037", var_159_11)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_103071", "103071037", "story_v_out_103071.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_103071", "103071037", "story_v_out_103071.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_12 = math.max(var_159_3, arg_156_1.talkMaxDuration)

			if var_159_2 <= arg_156_1.time_ and arg_156_1.time_ < var_159_2 + var_159_12 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_2) / var_159_12

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_2 + var_159_12 and arg_156_1.time_ < var_159_2 + var_159_12 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B06b"
	},
	voices = {
		"story_v_out_103071.awb"
	}
}
