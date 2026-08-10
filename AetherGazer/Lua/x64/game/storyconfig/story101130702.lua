return {
	Play113072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113072001
		arg_1_1.duration_ = 4.8

		local var_1_0 = {
			ja = 4.7,
			ko = 4.8,
			zh = 4.2,
			en = 4.7
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
				arg_1_0:Play113072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F02_1"

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
				local var_4_5 = arg_1_1.bgs_.F02_1

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
					if iter_4_0 ~= "F02_1" then
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

			local var_4_22 = "1041ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1041ui_story"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1041ui_story = var_4_27.localPosition

				local var_4_29 = "1041ui_story"

				arg_1_1:ShowWeapon(arg_1_1.var_[var_4_29 .. "Animator"].transform, true)
			end

			local var_4_30 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_28) / var_4_30
				local var_4_32 = Vector3.New(-0.7, -1.11, -5.9)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1041ui_story, var_4_32, var_4_31)

				local var_4_33 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_33.x, var_4_33.y, var_4_33.z)

				local var_4_34 = var_4_27.localEulerAngles

				var_4_34.z = 0
				var_4_34.x = 0
				var_4_27.localEulerAngles = var_4_34
			end

			if arg_1_1.time_ >= var_4_28 + var_4_30 and arg_1_1.time_ < var_4_28 + var_4_30 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_27.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_27.localEulerAngles = var_4_36
			end

			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action8_1")
			end

			local var_4_38 = 1.8

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_4_39 = arg_1_1.actors_["1041ui_story"]
			local var_4_40 = 1.8

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1041ui_story == nil then
				arg_1_1.var_.characterEffect1041ui_story = var_4_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_41 = 0.2

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 and not isNil(var_4_39) then
				local var_4_42 = (arg_1_1.time_ - var_4_40) / var_4_41

				if arg_1_1.var_.characterEffect1041ui_story and not isNil(var_4_39) then
					arg_1_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1041ui_story then
				arg_1_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_4_43 = 1.53333333333333
			local var_4_44 = 1

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "music"

				arg_1_1:AudioAction(var_4_45, var_4_46, "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_4_47 = ""
				local var_4_48 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

				if var_4_48 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_48 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_48

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_48
						arg_1_1.bgmTxt2_.text = var_4_48
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

			local var_4_49 = 2
			local var_4_50 = 0.275

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_51 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_51:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_52 = arg_1_1:FormatText(StoryNameCfg[208].name)

				arg_1_1.leftNameTxt_.text = var_4_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_53 = arg_1_1:GetWordFromCfg(113072001)
				local var_4_54 = arg_1_1:FormatText(var_4_53.content)

				arg_1_1.text_.text = var_4_54

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_55 = 11
				local var_4_56 = utf8.len(var_4_54)
				local var_4_57 = var_4_55 <= 0 and var_4_50 or var_4_50 * (var_4_56 / var_4_55)

				if var_4_57 > 0 and var_4_50 < var_4_57 then
					arg_1_1.talkMaxDuration = var_4_57
					var_4_49 = var_4_49 + 0.3

					if var_4_57 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_57 + var_4_49
					end
				end

				arg_1_1.text_.text = var_4_54
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072001", "story_v_out_113072.awb") ~= 0 then
					local var_4_58 = manager.audio:GetVoiceLength("story_v_out_113072", "113072001", "story_v_out_113072.awb") / 1000

					if var_4_58 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_58 + var_4_49
					end

					if var_4_53.prefab_name ~= "" and arg_1_1.actors_[var_4_53.prefab_name] ~= nil then
						local var_4_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_53.prefab_name].transform, "story_v_out_113072", "113072001", "story_v_out_113072.awb")

						arg_1_1:RecordAudio("113072001", var_4_59)
						arg_1_1:RecordAudio("113072001", var_4_59)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113072", "113072001", "story_v_out_113072.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113072", "113072001", "story_v_out_113072.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_60 = var_4_49 + 0.3
			local var_4_61 = math.max(var_4_50, arg_1_1.talkMaxDuration)

			if var_4_60 <= arg_1_1.time_ and arg_1_1.time_ < var_4_60 + var_4_61 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_60) / var_4_61

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_60 + var_4_61 and arg_1_1.time_ < var_4_60 + var_4_61 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play113072002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 113072002
		arg_8_1.duration_ = 4.27

		local var_8_0 = {
			ja = 3.6,
			ko = 3.2,
			zh = 4.266,
			en = 2.6
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
				arg_8_0:Play113072003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = manager.ui.mainCamera.transform
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.var_.shakeOldPosF02 = var_11_0.localPosition
			end

			local var_11_2 = 0.6

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / 0.066
				local var_11_4, var_11_5 = math.modf(var_11_3)

				var_11_0.localPosition = Vector3.New(var_11_5 * 0.13, var_11_5 * 0.13, var_11_5 * 0.13) + arg_8_1.var_.shakeOldPosF02
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 then
				var_11_0.localPosition = arg_8_1.var_.shakeOldPosF02
			end

			local var_11_6 = arg_8_1.actors_["1041ui_story"]
			local var_11_7 = 0

			if var_11_7 < arg_8_1.time_ and arg_8_1.time_ <= var_11_7 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect1041ui_story == nil then
				arg_8_1.var_.characterEffect1041ui_story = var_11_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_8 = 0.2

			if var_11_7 <= arg_8_1.time_ and arg_8_1.time_ < var_11_7 + var_11_8 and not isNil(var_11_6) then
				local var_11_9 = (arg_8_1.time_ - var_11_7) / var_11_8

				if arg_8_1.var_.characterEffect1041ui_story and not isNil(var_11_6) then
					local var_11_10 = Mathf.Lerp(0, 0.5, var_11_9)

					arg_8_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1041ui_story.fillRatio = var_11_10
				end
			end

			if arg_8_1.time_ >= var_11_7 + var_11_8 and arg_8_1.time_ < var_11_7 + var_11_8 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect1041ui_story then
				local var_11_11 = 0.5

				arg_8_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1041ui_story.fillRatio = var_11_11
			end

			local var_11_12 = 0

			if var_11_12 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 then
				arg_8_1.allBtn_.enabled = false
			end

			local var_11_13 = 0.6

			if arg_8_1.time_ >= var_11_12 + var_11_13 and arg_8_1.time_ < var_11_12 + var_11_13 + arg_11_0 then
				arg_8_1.allBtn_.enabled = true
			end

			local var_11_14 = 0
			local var_11_15 = 0.6

			if var_11_14 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 then
				local var_11_16 = "play"
				local var_11_17 = "effect"

				arg_8_1:AudioAction(var_11_16, var_11_17, "se_story_10", "se_story_10_monster", "")
			end

			local var_11_18 = 0
			local var_11_19 = 0.1

			if var_11_18 < arg_8_1.time_ and arg_8_1.time_ <= var_11_18 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_20 = arg_8_1:FormatText(StoryNameCfg[217].name)

				arg_8_1.leftNameTxt_.text = var_11_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3025")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_21 = arg_8_1:GetWordFromCfg(113072002)
				local var_11_22 = arg_8_1:FormatText(var_11_21.content)

				arg_8_1.text_.text = var_11_22

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_23 = 4
				local var_11_24 = utf8.len(var_11_22)
				local var_11_25 = var_11_23 <= 0 and var_11_19 or var_11_19 * (var_11_24 / var_11_23)

				if var_11_25 > 0 and var_11_19 < var_11_25 then
					arg_8_1.talkMaxDuration = var_11_25

					if var_11_25 + var_11_18 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_25 + var_11_18
					end
				end

				arg_8_1.text_.text = var_11_22
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072002", "story_v_out_113072.awb") ~= 0 then
					local var_11_26 = manager.audio:GetVoiceLength("story_v_out_113072", "113072002", "story_v_out_113072.awb") / 1000

					if var_11_26 + var_11_18 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_26 + var_11_18
					end

					if var_11_21.prefab_name ~= "" and arg_8_1.actors_[var_11_21.prefab_name] ~= nil then
						local var_11_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_21.prefab_name].transform, "story_v_out_113072", "113072002", "story_v_out_113072.awb")

						arg_8_1:RecordAudio("113072002", var_11_27)
						arg_8_1:RecordAudio("113072002", var_11_27)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_113072", "113072002", "story_v_out_113072.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_113072", "113072002", "story_v_out_113072.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_28 = math.max(var_11_19, arg_8_1.talkMaxDuration)

			if var_11_18 <= arg_8_1.time_ and arg_8_1.time_ < var_11_18 + var_11_28 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_18) / var_11_28

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_18 + var_11_28 and arg_8_1.time_ < var_11_18 + var_11_28 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play113072003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 113072003
		arg_12_1.duration_ = 2.73

		local var_12_0 = {
			ja = 2.2,
			ko = 2.4,
			zh = 1.999999999999,
			en = 2.733
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
				arg_12_0:Play113072004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1038ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["1038ui_story"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos1038ui_story = var_15_5.localPosition
			end

			local var_15_7 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7
				local var_15_9 = Vector3.New(0.7, -1.11, -5.9)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1038ui_story, var_15_9, var_15_8)

				local var_15_10 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_10.x, var_15_10.y, var_15_10.z)

				local var_15_11 = var_15_5.localEulerAngles

				var_15_11.z = 0
				var_15_11.x = 0
				var_15_5.localEulerAngles = var_15_11
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_15_12 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_12.x, var_15_12.y, var_15_12.z)

				local var_15_13 = var_15_5.localEulerAngles

				var_15_13.z = 0
				var_15_13.x = 0
				var_15_5.localEulerAngles = var_15_13
			end

			local var_15_14 = 0

			if var_15_14 < arg_12_1.time_ and arg_12_1.time_ <= var_15_14 + arg_15_0 then
				arg_12_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 then
				arg_12_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_15_16 = arg_12_1.actors_["1038ui_story"]
			local var_15_17 = 0

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 and not isNil(var_15_16) and arg_12_1.var_.characterEffect1038ui_story == nil then
				arg_12_1.var_.characterEffect1038ui_story = var_15_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_18 = 0.2

			if var_15_17 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_18 and not isNil(var_15_16) then
				local var_15_19 = (arg_12_1.time_ - var_15_17) / var_15_18

				if arg_12_1.var_.characterEffect1038ui_story and not isNil(var_15_16) then
					arg_12_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_17 + var_15_18 and arg_12_1.time_ < var_15_17 + var_15_18 + arg_15_0 and not isNil(var_15_16) and arg_12_1.var_.characterEffect1038ui_story then
				arg_12_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_15_20 = 0
			local var_15_21 = 0.2

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_22 = arg_12_1:FormatText(StoryNameCfg[94].name)

				arg_12_1.leftNameTxt_.text = var_15_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_23 = arg_12_1:GetWordFromCfg(113072003)
				local var_15_24 = arg_12_1:FormatText(var_15_23.content)

				arg_12_1.text_.text = var_15_24

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_25 = 8
				local var_15_26 = utf8.len(var_15_24)
				local var_15_27 = var_15_25 <= 0 and var_15_21 or var_15_21 * (var_15_26 / var_15_25)

				if var_15_27 > 0 and var_15_21 < var_15_27 then
					arg_12_1.talkMaxDuration = var_15_27

					if var_15_27 + var_15_20 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_27 + var_15_20
					end
				end

				arg_12_1.text_.text = var_15_24
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072003", "story_v_out_113072.awb") ~= 0 then
					local var_15_28 = manager.audio:GetVoiceLength("story_v_out_113072", "113072003", "story_v_out_113072.awb") / 1000

					if var_15_28 + var_15_20 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_28 + var_15_20
					end

					if var_15_23.prefab_name ~= "" and arg_12_1.actors_[var_15_23.prefab_name] ~= nil then
						local var_15_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_23.prefab_name].transform, "story_v_out_113072", "113072003", "story_v_out_113072.awb")

						arg_12_1:RecordAudio("113072003", var_15_29)
						arg_12_1:RecordAudio("113072003", var_15_29)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_113072", "113072003", "story_v_out_113072.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_113072", "113072003", "story_v_out_113072.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_30 = math.max(var_15_21, arg_12_1.talkMaxDuration)

			if var_15_20 <= arg_12_1.time_ and arg_12_1.time_ < var_15_20 + var_15_30 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_20) / var_15_30

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_20 + var_15_30 and arg_12_1.time_ < var_15_20 + var_15_30 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
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
	Play113072004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 113072004
		arg_16_1.duration_ = 2

		local var_16_0 = {
			ja = 2,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_16_0:Play113072005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1041ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos1041ui_story = var_19_0.localPosition

				local var_19_2 = "1041ui_story"

				arg_16_1:ShowWeapon(arg_16_1.var_[var_19_2 .. "Animator"].transform, false)
			end

			local var_19_3 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_3 then
				local var_19_4 = (arg_16_1.time_ - var_19_1) / var_19_3
				local var_19_5 = Vector3.New(0, 100, 0)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1041ui_story, var_19_5, var_19_4)

				local var_19_6 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_6.x, var_19_6.y, var_19_6.z)

				local var_19_7 = var_19_0.localEulerAngles

				var_19_7.z = 0
				var_19_7.x = 0
				var_19_0.localEulerAngles = var_19_7
			end

			if arg_16_1.time_ >= var_19_1 + var_19_3 and arg_16_1.time_ < var_19_1 + var_19_3 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, 100, 0)

				local var_19_8 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_8.x, var_19_8.y, var_19_8.z)

				local var_19_9 = var_19_0.localEulerAngles

				var_19_9.z = 0
				var_19_9.x = 0
				var_19_0.localEulerAngles = var_19_9
			end

			local var_19_10 = arg_16_1.actors_["1038ui_story"].transform
			local var_19_11 = 0

			if var_19_11 < arg_16_1.time_ and arg_16_1.time_ <= var_19_11 + arg_19_0 then
				arg_16_1.var_.moveOldPos1038ui_story = var_19_10.localPosition
			end

			local var_19_12 = 0.001

			if var_19_11 <= arg_16_1.time_ and arg_16_1.time_ < var_19_11 + var_19_12 then
				local var_19_13 = (arg_16_1.time_ - var_19_11) / var_19_12
				local var_19_14 = Vector3.New(0, 100, 0)

				var_19_10.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1038ui_story, var_19_14, var_19_13)

				local var_19_15 = manager.ui.mainCamera.transform.position - var_19_10.position

				var_19_10.forward = Vector3.New(var_19_15.x, var_19_15.y, var_19_15.z)

				local var_19_16 = var_19_10.localEulerAngles

				var_19_16.z = 0
				var_19_16.x = 0
				var_19_10.localEulerAngles = var_19_16
			end

			if arg_16_1.time_ >= var_19_11 + var_19_12 and arg_16_1.time_ < var_19_11 + var_19_12 + arg_19_0 then
				var_19_10.localPosition = Vector3.New(0, 100, 0)

				local var_19_17 = manager.ui.mainCamera.transform.position - var_19_10.position

				var_19_10.forward = Vector3.New(var_19_17.x, var_19_17.y, var_19_17.z)

				local var_19_18 = var_19_10.localEulerAngles

				var_19_18.z = 0
				var_19_18.x = 0
				var_19_10.localEulerAngles = var_19_18
			end

			local var_19_19 = "1042ui_story"

			if arg_16_1.actors_[var_19_19] == nil then
				local var_19_20 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_19_20) then
					local var_19_21 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_16_1.stage_.transform)

					var_19_21.name = var_19_19
					var_19_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_19] = var_19_21

					local var_19_22 = var_19_21:GetComponentInChildren(typeof(CharacterEffect))

					var_19_22.enabled = true

					local var_19_23 = GameObjectTools.GetOrAddComponent(var_19_21, typeof(DynamicBoneHelper))

					if var_19_23 then
						var_19_23:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_22.transform, false)

					arg_16_1.var_[var_19_19 .. "Animator"] = var_19_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_19 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_19 .. "LipSync"] = var_19_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_24 = arg_16_1.actors_["1042ui_story"].transform
			local var_19_25 = 0

			if var_19_25 < arg_16_1.time_ and arg_16_1.time_ <= var_19_25 + arg_19_0 then
				arg_16_1.var_.moveOldPos1042ui_story = var_19_24.localPosition
			end

			local var_19_26 = 0.001

			if var_19_25 <= arg_16_1.time_ and arg_16_1.time_ < var_19_25 + var_19_26 then
				local var_19_27 = (arg_16_1.time_ - var_19_25) / var_19_26
				local var_19_28 = Vector3.New(0, -1.06, -6.2)

				var_19_24.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1042ui_story, var_19_28, var_19_27)

				local var_19_29 = manager.ui.mainCamera.transform.position - var_19_24.position

				var_19_24.forward = Vector3.New(var_19_29.x, var_19_29.y, var_19_29.z)

				local var_19_30 = var_19_24.localEulerAngles

				var_19_30.z = 0
				var_19_30.x = 0
				var_19_24.localEulerAngles = var_19_30
			end

			if arg_16_1.time_ >= var_19_25 + var_19_26 and arg_16_1.time_ < var_19_25 + var_19_26 + arg_19_0 then
				var_19_24.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_19_31 = manager.ui.mainCamera.transform.position - var_19_24.position

				var_19_24.forward = Vector3.New(var_19_31.x, var_19_31.y, var_19_31.z)

				local var_19_32 = var_19_24.localEulerAngles

				var_19_32.z = 0
				var_19_32.x = 0
				var_19_24.localEulerAngles = var_19_32
			end

			local var_19_33 = 0

			if var_19_33 < arg_16_1.time_ and arg_16_1.time_ <= var_19_33 + arg_19_0 then
				arg_16_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action3_1")
			end

			local var_19_34 = 0

			if var_19_34 < arg_16_1.time_ and arg_16_1.time_ <= var_19_34 + arg_19_0 then
				arg_16_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_19_35 = arg_16_1.actors_["1042ui_story"]
			local var_19_36 = 0

			if var_19_36 < arg_16_1.time_ and arg_16_1.time_ <= var_19_36 + arg_19_0 and not isNil(var_19_35) and arg_16_1.var_.characterEffect1042ui_story == nil then
				arg_16_1.var_.characterEffect1042ui_story = var_19_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_37 = 0.2

			if var_19_36 <= arg_16_1.time_ and arg_16_1.time_ < var_19_36 + var_19_37 and not isNil(var_19_35) then
				local var_19_38 = (arg_16_1.time_ - var_19_36) / var_19_37

				if arg_16_1.var_.characterEffect1042ui_story and not isNil(var_19_35) then
					arg_16_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_36 + var_19_37 and arg_16_1.time_ < var_19_36 + var_19_37 + arg_19_0 and not isNil(var_19_35) and arg_16_1.var_.characterEffect1042ui_story then
				arg_16_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_19_39 = 0
			local var_19_40 = 0.15

			if var_19_39 < arg_16_1.time_ and arg_16_1.time_ <= var_19_39 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_41 = arg_16_1:FormatText(StoryNameCfg[205].name)

				arg_16_1.leftNameTxt_.text = var_19_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_42 = arg_16_1:GetWordFromCfg(113072004)
				local var_19_43 = arg_16_1:FormatText(var_19_42.content)

				arg_16_1.text_.text = var_19_43

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_44 = 6
				local var_19_45 = utf8.len(var_19_43)
				local var_19_46 = var_19_44 <= 0 and var_19_40 or var_19_40 * (var_19_45 / var_19_44)

				if var_19_46 > 0 and var_19_40 < var_19_46 then
					arg_16_1.talkMaxDuration = var_19_46

					if var_19_46 + var_19_39 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_46 + var_19_39
					end
				end

				arg_16_1.text_.text = var_19_43
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072004", "story_v_out_113072.awb") ~= 0 then
					local var_19_47 = manager.audio:GetVoiceLength("story_v_out_113072", "113072004", "story_v_out_113072.awb") / 1000

					if var_19_47 + var_19_39 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_47 + var_19_39
					end

					if var_19_42.prefab_name ~= "" and arg_16_1.actors_[var_19_42.prefab_name] ~= nil then
						local var_19_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_42.prefab_name].transform, "story_v_out_113072", "113072004", "story_v_out_113072.awb")

						arg_16_1:RecordAudio("113072004", var_19_48)
						arg_16_1:RecordAudio("113072004", var_19_48)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_113072", "113072004", "story_v_out_113072.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_113072", "113072004", "story_v_out_113072.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_49 = math.max(var_19_40, arg_16_1.talkMaxDuration)

			if var_19_39 <= arg_16_1.time_ and arg_16_1.time_ < var_19_39 + var_19_49 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_39) / var_19_49

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_39 + var_19_49 and arg_16_1.time_ < var_19_39 + var_19_49 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
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
	Play113072005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 113072005
		arg_20_1.duration_ = 2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play113072006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1042ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos1042ui_story = var_23_0.localPosition
			end

			local var_23_2 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2
				local var_23_4 = Vector3.New(0, 100, 0)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1042ui_story, var_23_4, var_23_3)

				local var_23_5 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_5.x, var_23_5.y, var_23_5.z)

				local var_23_6 = var_23_0.localEulerAngles

				var_23_6.z = 0
				var_23_6.x = 0
				var_23_0.localEulerAngles = var_23_6
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, 100, 0)

				local var_23_7 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_7.x, var_23_7.y, var_23_7.z)

				local var_23_8 = var_23_0.localEulerAngles

				var_23_8.z = 0
				var_23_8.x = 0
				var_23_0.localEulerAngles = var_23_8
			end

			local var_23_9 = "6045_story"

			if arg_20_1.actors_[var_23_9] == nil then
				local var_23_10 = Asset.Load("Char/" .. "6045_story")

				if not isNil(var_23_10) then
					local var_23_11 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_20_1.stage_.transform)

					var_23_11.name = var_23_9
					var_23_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_9] = var_23_11

					local var_23_12 = var_23_11:GetComponentInChildren(typeof(CharacterEffect))

					var_23_12.enabled = true

					local var_23_13 = GameObjectTools.GetOrAddComponent(var_23_11, typeof(DynamicBoneHelper))

					if var_23_13 then
						var_23_13:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_12.transform, false)

					arg_20_1.var_[var_23_9 .. "Animator"] = var_23_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_9 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_9 .. "LipSync"] = var_23_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_14 = arg_20_1.actors_["6045_story"].transform
			local var_23_15 = 0

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.var_.moveOldPos6045_story = var_23_14.localPosition

				local var_23_16 = GameObjectTools.GetOrAddComponent(var_23_14.gameObject, typeof(DynamicBoneHelper))

				if var_23_16 then
					var_23_16:EnableDynamicBone(false)
				end
			end

			local var_23_17 = 0.001

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_17 then
				local var_23_18 = (arg_20_1.time_ - var_23_15) / var_23_17
				local var_23_19 = Vector3.New(0.7, -0.5, -6.3)

				var_23_14.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos6045_story, var_23_19, var_23_18)

				local var_23_20 = manager.ui.mainCamera.transform.position - var_23_14.position

				var_23_14.forward = Vector3.New(var_23_20.x, var_23_20.y, var_23_20.z)

				local var_23_21 = var_23_14.localEulerAngles

				var_23_21.z = 0
				var_23_21.x = 0
				var_23_14.localEulerAngles = var_23_21
			end

			if arg_20_1.time_ >= var_23_15 + var_23_17 and arg_20_1.time_ < var_23_15 + var_23_17 + arg_23_0 then
				var_23_14.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_23_22 = manager.ui.mainCamera.transform.position - var_23_14.position

				var_23_14.forward = Vector3.New(var_23_22.x, var_23_22.y, var_23_22.z)

				local var_23_23 = var_23_14.localEulerAngles

				var_23_23.z = 0
				var_23_23.x = 0
				var_23_14.localEulerAngles = var_23_23

				local var_23_24 = GameObjectTools.GetOrAddComponent(var_23_14.gameObject, typeof(DynamicBoneHelper))

				if var_23_24 then
					var_23_24:EnableDynamicBone(true)
				end
			end

			local var_23_25 = "6046_story"

			if arg_20_1.actors_[var_23_25] == nil then
				local var_23_26 = Asset.Load("Char/" .. "6046_story")

				if not isNil(var_23_26) then
					local var_23_27 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_20_1.stage_.transform)

					var_23_27.name = var_23_25
					var_23_27.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_25] = var_23_27

					local var_23_28 = var_23_27:GetComponentInChildren(typeof(CharacterEffect))

					var_23_28.enabled = true

					local var_23_29 = GameObjectTools.GetOrAddComponent(var_23_27, typeof(DynamicBoneHelper))

					if var_23_29 then
						var_23_29:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_28.transform, false)

					arg_20_1.var_[var_23_25 .. "Animator"] = var_23_28.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_25 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_25 .. "LipSync"] = var_23_28.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_30 = arg_20_1.actors_["6046_story"].transform
			local var_23_31 = 0

			if var_23_31 < arg_20_1.time_ and arg_20_1.time_ <= var_23_31 + arg_23_0 then
				arg_20_1.var_.moveOldPos6046_story = var_23_30.localPosition

				local var_23_32 = GameObjectTools.GetOrAddComponent(var_23_30.gameObject, typeof(DynamicBoneHelper))

				if var_23_32 then
					var_23_32:EnableDynamicBone(false)
				end
			end

			local var_23_33 = 0.001

			if var_23_31 <= arg_20_1.time_ and arg_20_1.time_ < var_23_31 + var_23_33 then
				local var_23_34 = (arg_20_1.time_ - var_23_31) / var_23_33
				local var_23_35 = Vector3.New(-0.7, -0.5, -6.3)

				var_23_30.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos6046_story, var_23_35, var_23_34)

				local var_23_36 = manager.ui.mainCamera.transform.position - var_23_30.position

				var_23_30.forward = Vector3.New(var_23_36.x, var_23_36.y, var_23_36.z)

				local var_23_37 = var_23_30.localEulerAngles

				var_23_37.z = 0
				var_23_37.x = 0
				var_23_30.localEulerAngles = var_23_37
			end

			if arg_20_1.time_ >= var_23_31 + var_23_33 and arg_20_1.time_ < var_23_31 + var_23_33 + arg_23_0 then
				var_23_30.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_23_38 = manager.ui.mainCamera.transform.position - var_23_30.position

				var_23_30.forward = Vector3.New(var_23_38.x, var_23_38.y, var_23_38.z)

				local var_23_39 = var_23_30.localEulerAngles

				var_23_39.z = 0
				var_23_39.x = 0
				var_23_30.localEulerAngles = var_23_39

				local var_23_40 = GameObjectTools.GetOrAddComponent(var_23_30.gameObject, typeof(DynamicBoneHelper))

				if var_23_40 then
					var_23_40:EnableDynamicBone(true)
				end
			end

			local var_23_41 = 0

			if var_23_41 < arg_20_1.time_ and arg_20_1.time_ <= var_23_41 + arg_23_0 then
				arg_20_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_23_42 = 0

			if var_23_42 < arg_20_1.time_ and arg_20_1.time_ <= var_23_42 + arg_23_0 then
				arg_20_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_23_43 = 0

			if var_23_43 < arg_20_1.time_ and arg_20_1.time_ <= var_23_43 + arg_23_0 then
				arg_20_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_23_44 = 0

			if var_23_44 < arg_20_1.time_ and arg_20_1.time_ <= var_23_44 + arg_23_0 then
				arg_20_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_23_45 = arg_20_1.actors_["6046_story"]
			local var_23_46 = 0

			if var_23_46 < arg_20_1.time_ and arg_20_1.time_ <= var_23_46 + arg_23_0 and not isNil(var_23_45) and arg_20_1.var_.characterEffect6046_story == nil then
				arg_20_1.var_.characterEffect6046_story = var_23_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_47 = 0.2

			if var_23_46 <= arg_20_1.time_ and arg_20_1.time_ < var_23_46 + var_23_47 and not isNil(var_23_45) then
				local var_23_48 = (arg_20_1.time_ - var_23_46) / var_23_47

				if arg_20_1.var_.characterEffect6046_story and not isNil(var_23_45) then
					arg_20_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_46 + var_23_47 and arg_20_1.time_ < var_23_46 + var_23_47 + arg_23_0 and not isNil(var_23_45) and arg_20_1.var_.characterEffect6046_story then
				arg_20_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_23_49 = arg_20_1.actors_["6045_story"]
			local var_23_50 = 0

			if var_23_50 < arg_20_1.time_ and arg_20_1.time_ <= var_23_50 + arg_23_0 and not isNil(var_23_49) and arg_20_1.var_.characterEffect6045_story == nil then
				arg_20_1.var_.characterEffect6045_story = var_23_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_51 = 0.2

			if var_23_50 <= arg_20_1.time_ and arg_20_1.time_ < var_23_50 + var_23_51 and not isNil(var_23_49) then
				local var_23_52 = (arg_20_1.time_ - var_23_50) / var_23_51

				if arg_20_1.var_.characterEffect6045_story and not isNil(var_23_49) then
					arg_20_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_50 + var_23_51 and arg_20_1.time_ < var_23_50 + var_23_51 + arg_23_0 and not isNil(var_23_49) and arg_20_1.var_.characterEffect6045_story then
				arg_20_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_23_53 = 0
			local var_23_54 = 0.075

			if var_23_53 < arg_20_1.time_ and arg_20_1.time_ <= var_23_53 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_55 = arg_20_1:FormatText(StoryNameCfg[233].name)

				arg_20_1.leftNameTxt_.text = var_23_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_56 = arg_20_1:GetWordFromCfg(113072005)
				local var_23_57 = arg_20_1:FormatText(var_23_56.content)

				arg_20_1.text_.text = var_23_57

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_58 = 3
				local var_23_59 = utf8.len(var_23_57)
				local var_23_60 = var_23_58 <= 0 and var_23_54 or var_23_54 * (var_23_59 / var_23_58)

				if var_23_60 > 0 and var_23_54 < var_23_60 then
					arg_20_1.talkMaxDuration = var_23_60

					if var_23_60 + var_23_53 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_60 + var_23_53
					end
				end

				arg_20_1.text_.text = var_23_57
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072005", "story_v_out_113072.awb") ~= 0 then
					local var_23_61 = manager.audio:GetVoiceLength("story_v_out_113072", "113072005", "story_v_out_113072.awb") / 1000

					if var_23_61 + var_23_53 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_61 + var_23_53
					end

					if var_23_56.prefab_name ~= "" and arg_20_1.actors_[var_23_56.prefab_name] ~= nil then
						local var_23_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_56.prefab_name].transform, "story_v_out_113072", "113072005", "story_v_out_113072.awb")

						arg_20_1:RecordAudio("113072005", var_23_62)
						arg_20_1:RecordAudio("113072005", var_23_62)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_113072", "113072005", "story_v_out_113072.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_113072", "113072005", "story_v_out_113072.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_63 = math.max(var_23_54, arg_20_1.talkMaxDuration)

			if var_23_53 <= arg_20_1.time_ and arg_20_1.time_ < var_23_53 + var_23_63 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_53) / var_23_63

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_53 + var_23_63 and arg_20_1.time_ < var_23_53 + var_23_63 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play113072006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 113072006
		arg_24_1.duration_ = 2.5

		local var_24_0 = {
			ja = 2.5,
			ko = 2.466,
			zh = 2.3,
			en = 1.2
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
				arg_24_0:Play113072007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["6045_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos6045_story = var_27_0.localPosition

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end
			end

			local var_27_3 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_3 then
				local var_27_4 = (arg_24_1.time_ - var_27_1) / var_27_3
				local var_27_5 = Vector3.New(0, 100, 0)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos6045_story, var_27_5, var_27_4)

				local var_27_6 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_6.x, var_27_6.y, var_27_6.z)

				local var_27_7 = var_27_0.localEulerAngles

				var_27_7.z = 0
				var_27_7.x = 0
				var_27_0.localEulerAngles = var_27_7
			end

			if arg_24_1.time_ >= var_27_1 + var_27_3 and arg_24_1.time_ < var_27_1 + var_27_3 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, 100, 0)

				local var_27_8 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_8.x, var_27_8.y, var_27_8.z)

				local var_27_9 = var_27_0.localEulerAngles

				var_27_9.z = 0
				var_27_9.x = 0
				var_27_0.localEulerAngles = var_27_9

				local var_27_10 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_10 then
					var_27_10:EnableDynamicBone(true)
				end
			end

			local var_27_11 = arg_24_1.actors_["6046_story"].transform
			local var_27_12 = 0

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.var_.moveOldPos6046_story = var_27_11.localPosition

				local var_27_13 = GameObjectTools.GetOrAddComponent(var_27_11.gameObject, typeof(DynamicBoneHelper))

				if var_27_13 then
					var_27_13:EnableDynamicBone(false)
				end
			end

			local var_27_14 = 0.001

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_14 then
				local var_27_15 = (arg_24_1.time_ - var_27_12) / var_27_14
				local var_27_16 = Vector3.New(0, 100, 0)

				var_27_11.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos6046_story, var_27_16, var_27_15)

				local var_27_17 = manager.ui.mainCamera.transform.position - var_27_11.position

				var_27_11.forward = Vector3.New(var_27_17.x, var_27_17.y, var_27_17.z)

				local var_27_18 = var_27_11.localEulerAngles

				var_27_18.z = 0
				var_27_18.x = 0
				var_27_11.localEulerAngles = var_27_18
			end

			if arg_24_1.time_ >= var_27_12 + var_27_14 and arg_24_1.time_ < var_27_12 + var_27_14 + arg_27_0 then
				var_27_11.localPosition = Vector3.New(0, 100, 0)

				local var_27_19 = manager.ui.mainCamera.transform.position - var_27_11.position

				var_27_11.forward = Vector3.New(var_27_19.x, var_27_19.y, var_27_19.z)

				local var_27_20 = var_27_11.localEulerAngles

				var_27_20.z = 0
				var_27_20.x = 0
				var_27_11.localEulerAngles = var_27_20

				local var_27_21 = GameObjectTools.GetOrAddComponent(var_27_11.gameObject, typeof(DynamicBoneHelper))

				if var_27_21 then
					var_27_21:EnableDynamicBone(true)
				end
			end

			local var_27_22 = 0
			local var_27_23 = 0.175

			if var_27_22 < arg_24_1.time_ and arg_24_1.time_ <= var_27_22 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_24 = arg_24_1:FormatText(StoryNameCfg[214].name)

				arg_24_1.leftNameTxt_.text = var_27_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6046")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_25 = arg_24_1:GetWordFromCfg(113072006)
				local var_27_26 = arg_24_1:FormatText(var_27_25.content)

				arg_24_1.text_.text = var_27_26

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_27 = 7
				local var_27_28 = utf8.len(var_27_26)
				local var_27_29 = var_27_27 <= 0 and var_27_23 or var_27_23 * (var_27_28 / var_27_27)

				if var_27_29 > 0 and var_27_23 < var_27_29 then
					arg_24_1.talkMaxDuration = var_27_29

					if var_27_29 + var_27_22 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_29 + var_27_22
					end
				end

				arg_24_1.text_.text = var_27_26
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072006", "story_v_out_113072.awb") ~= 0 then
					local var_27_30 = manager.audio:GetVoiceLength("story_v_out_113072", "113072006", "story_v_out_113072.awb") / 1000

					if var_27_30 + var_27_22 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_30 + var_27_22
					end

					if var_27_25.prefab_name ~= "" and arg_24_1.actors_[var_27_25.prefab_name] ~= nil then
						local var_27_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_25.prefab_name].transform, "story_v_out_113072", "113072006", "story_v_out_113072.awb")

						arg_24_1:RecordAudio("113072006", var_27_31)
						arg_24_1:RecordAudio("113072006", var_27_31)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_113072", "113072006", "story_v_out_113072.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_113072", "113072006", "story_v_out_113072.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_32 = math.max(var_27_23, arg_24_1.talkMaxDuration)

			if var_27_22 <= arg_24_1.time_ and arg_24_1.time_ < var_27_22 + var_27_32 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_22) / var_27_32

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_22 + var_27_32 and arg_24_1.time_ < var_27_22 + var_27_32 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play113072007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 113072007
		arg_28_1.duration_ = 2.7

		local var_28_0 = {
			ja = 2.3,
			ko = 2.7,
			zh = 2.333,
			en = 2.2
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
				arg_28_0:Play113072008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.2

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[215].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(113072007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 8
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072007", "story_v_out_113072.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_113072", "113072007", "story_v_out_113072.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_113072", "113072007", "story_v_out_113072.awb")

						arg_28_1:RecordAudio("113072007", var_31_9)
						arg_28_1:RecordAudio("113072007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_113072", "113072007", "story_v_out_113072.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_113072", "113072007", "story_v_out_113072.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_10 and arg_28_1.time_ < var_31_0 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play113072008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 113072008
		arg_32_1.duration_ = 2

		local var_32_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2,
			en = 1.999999999999
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
				arg_32_0:Play113072009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["6045_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos6045_story = var_35_0.localPosition

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end
			end

			local var_35_3 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_3 then
				local var_35_4 = (arg_32_1.time_ - var_35_1) / var_35_3
				local var_35_5 = Vector3.New(0.7, -0.5, -6.3)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos6045_story, var_35_5, var_35_4)

				local var_35_6 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_6.x, var_35_6.y, var_35_6.z)

				local var_35_7 = var_35_0.localEulerAngles

				var_35_7.z = 0
				var_35_7.x = 0
				var_35_0.localEulerAngles = var_35_7
			end

			if arg_32_1.time_ >= var_35_1 + var_35_3 and arg_32_1.time_ < var_35_1 + var_35_3 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_35_8 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_8.x, var_35_8.y, var_35_8.z)

				local var_35_9 = var_35_0.localEulerAngles

				var_35_9.z = 0
				var_35_9.x = 0
				var_35_0.localEulerAngles = var_35_9

				local var_35_10 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_10 then
					var_35_10:EnableDynamicBone(true)
				end
			end

			local var_35_11 = arg_32_1.actors_["6046_story"].transform
			local var_35_12 = 0

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.var_.moveOldPos6046_story = var_35_11.localPosition

				local var_35_13 = GameObjectTools.GetOrAddComponent(var_35_11.gameObject, typeof(DynamicBoneHelper))

				if var_35_13 then
					var_35_13:EnableDynamicBone(false)
				end
			end

			local var_35_14 = 0.001

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_14 then
				local var_35_15 = (arg_32_1.time_ - var_35_12) / var_35_14
				local var_35_16 = Vector3.New(-0.7, -0.5, -6.3)

				var_35_11.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos6046_story, var_35_16, var_35_15)

				local var_35_17 = manager.ui.mainCamera.transform.position - var_35_11.position

				var_35_11.forward = Vector3.New(var_35_17.x, var_35_17.y, var_35_17.z)

				local var_35_18 = var_35_11.localEulerAngles

				var_35_18.z = 0
				var_35_18.x = 0
				var_35_11.localEulerAngles = var_35_18
			end

			if arg_32_1.time_ >= var_35_12 + var_35_14 and arg_32_1.time_ < var_35_12 + var_35_14 + arg_35_0 then
				var_35_11.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_35_19 = manager.ui.mainCamera.transform.position - var_35_11.position

				var_35_11.forward = Vector3.New(var_35_19.x, var_35_19.y, var_35_19.z)

				local var_35_20 = var_35_11.localEulerAngles

				var_35_20.z = 0
				var_35_20.x = 0
				var_35_11.localEulerAngles = var_35_20

				local var_35_21 = GameObjectTools.GetOrAddComponent(var_35_11.gameObject, typeof(DynamicBoneHelper))

				if var_35_21 then
					var_35_21:EnableDynamicBone(true)
				end
			end

			local var_35_22 = 0

			if var_35_22 < arg_32_1.time_ and arg_32_1.time_ <= var_35_22 + arg_35_0 then
				arg_32_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_35_23 = 0

			if var_35_23 < arg_32_1.time_ and arg_32_1.time_ <= var_35_23 + arg_35_0 then
				arg_32_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_35_24 = 0

			if var_35_24 < arg_32_1.time_ and arg_32_1.time_ <= var_35_24 + arg_35_0 then
				arg_32_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_35_25 = 0

			if var_35_25 < arg_32_1.time_ and arg_32_1.time_ <= var_35_25 + arg_35_0 then
				arg_32_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_35_26 = 0
			local var_35_27 = 0.125

			if var_35_26 < arg_32_1.time_ and arg_32_1.time_ <= var_35_26 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_28 = arg_32_1:FormatText(StoryNameCfg[233].name)

				arg_32_1.leftNameTxt_.text = var_35_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_29 = arg_32_1:GetWordFromCfg(113072008)
				local var_35_30 = arg_32_1:FormatText(var_35_29.content)

				arg_32_1.text_.text = var_35_30

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_31 = 5
				local var_35_32 = utf8.len(var_35_30)
				local var_35_33 = var_35_31 <= 0 and var_35_27 or var_35_27 * (var_35_32 / var_35_31)

				if var_35_33 > 0 and var_35_27 < var_35_33 then
					arg_32_1.talkMaxDuration = var_35_33

					if var_35_33 + var_35_26 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_33 + var_35_26
					end
				end

				arg_32_1.text_.text = var_35_30
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072008", "story_v_out_113072.awb") ~= 0 then
					local var_35_34 = manager.audio:GetVoiceLength("story_v_out_113072", "113072008", "story_v_out_113072.awb") / 1000

					if var_35_34 + var_35_26 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_34 + var_35_26
					end

					if var_35_29.prefab_name ~= "" and arg_32_1.actors_[var_35_29.prefab_name] ~= nil then
						local var_35_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_29.prefab_name].transform, "story_v_out_113072", "113072008", "story_v_out_113072.awb")

						arg_32_1:RecordAudio("113072008", var_35_35)
						arg_32_1:RecordAudio("113072008", var_35_35)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_113072", "113072008", "story_v_out_113072.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_113072", "113072008", "story_v_out_113072.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_36 = math.max(var_35_27, arg_32_1.talkMaxDuration)

			if var_35_26 <= arg_32_1.time_ and arg_32_1.time_ < var_35_26 + var_35_36 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_26) / var_35_36

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_26 + var_35_36 and arg_32_1.time_ < var_35_26 + var_35_36 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play113072009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 113072009
		arg_36_1.duration_ = 4.2

		local var_36_0 = {
			ja = 1.3,
			ko = 2.8,
			zh = 4.2,
			en = 3.1
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
				arg_36_0:Play113072010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["6046_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos6046_story = var_39_0.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_3 then
				local var_39_4 = (arg_36_1.time_ - var_39_1) / var_39_3
				local var_39_5 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos6046_story, var_39_5, var_39_4)

				local var_39_6 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_6.x, var_39_6.y, var_39_6.z)

				local var_39_7 = var_39_0.localEulerAngles

				var_39_7.z = 0
				var_39_7.x = 0
				var_39_0.localEulerAngles = var_39_7
			end

			if arg_36_1.time_ >= var_39_1 + var_39_3 and arg_36_1.time_ < var_39_1 + var_39_3 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, 100, 0)

				local var_39_8 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_8.x, var_39_8.y, var_39_8.z)

				local var_39_9 = var_39_0.localEulerAngles

				var_39_9.z = 0
				var_39_9.x = 0
				var_39_0.localEulerAngles = var_39_9

				local var_39_10 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_10 then
					var_39_10:EnableDynamicBone(true)
				end
			end

			local var_39_11 = arg_36_1.actors_["6045_story"].transform
			local var_39_12 = 0

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.var_.moveOldPos6045_story = var_39_11.localPosition

				local var_39_13 = GameObjectTools.GetOrAddComponent(var_39_11.gameObject, typeof(DynamicBoneHelper))

				if var_39_13 then
					var_39_13:EnableDynamicBone(false)
				end
			end

			local var_39_14 = 0.001

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_14 then
				local var_39_15 = (arg_36_1.time_ - var_39_12) / var_39_14
				local var_39_16 = Vector3.New(0, 100, 0)

				var_39_11.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos6045_story, var_39_16, var_39_15)

				local var_39_17 = manager.ui.mainCamera.transform.position - var_39_11.position

				var_39_11.forward = Vector3.New(var_39_17.x, var_39_17.y, var_39_17.z)

				local var_39_18 = var_39_11.localEulerAngles

				var_39_18.z = 0
				var_39_18.x = 0
				var_39_11.localEulerAngles = var_39_18
			end

			if arg_36_1.time_ >= var_39_12 + var_39_14 and arg_36_1.time_ < var_39_12 + var_39_14 + arg_39_0 then
				var_39_11.localPosition = Vector3.New(0, 100, 0)

				local var_39_19 = manager.ui.mainCamera.transform.position - var_39_11.position

				var_39_11.forward = Vector3.New(var_39_19.x, var_39_19.y, var_39_19.z)

				local var_39_20 = var_39_11.localEulerAngles

				var_39_20.z = 0
				var_39_20.x = 0
				var_39_11.localEulerAngles = var_39_20

				local var_39_21 = GameObjectTools.GetOrAddComponent(var_39_11.gameObject, typeof(DynamicBoneHelper))

				if var_39_21 then
					var_39_21:EnableDynamicBone(true)
				end
			end

			local var_39_22 = manager.ui.mainCamera.transform
			local var_39_23 = 0

			if var_39_23 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 then
				arg_36_1.var_.shakeOldPos = var_39_22.localPosition
			end

			local var_39_24 = 0.6

			if var_39_23 <= arg_36_1.time_ and arg_36_1.time_ < var_39_23 + var_39_24 then
				local var_39_25 = (arg_36_1.time_ - var_39_23) / 0.066
				local var_39_26, var_39_27 = math.modf(var_39_25)

				var_39_22.localPosition = Vector3.New(var_39_27 * 0.13, var_39_27 * 0.13, var_39_27 * 0.13) + arg_36_1.var_.shakeOldPos
			end

			if arg_36_1.time_ >= var_39_23 + var_39_24 and arg_36_1.time_ < var_39_23 + var_39_24 + arg_39_0 then
				var_39_22.localPosition = arg_36_1.var_.shakeOldPos
			end

			local var_39_28 = 0
			local var_39_29 = 0.6

			if var_39_28 < arg_36_1.time_ and arg_36_1.time_ <= var_39_28 + arg_39_0 then
				local var_39_30 = "play"
				local var_39_31 = "effect"

				arg_36_1:AudioAction(var_39_30, var_39_31, "se_story_10", "se_story_10_monster", "")
			end

			local var_39_32 = 0
			local var_39_33 = 0.1

			if var_39_32 < arg_36_1.time_ and arg_36_1.time_ <= var_39_32 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_34 = arg_36_1:FormatText(StoryNameCfg[217].name)

				arg_36_1.leftNameTxt_.text = var_39_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3025")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_35 = arg_36_1:GetWordFromCfg(113072009)
				local var_39_36 = arg_36_1:FormatText(var_39_35.content)

				arg_36_1.text_.text = var_39_36

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_37 = 4
				local var_39_38 = utf8.len(var_39_36)
				local var_39_39 = var_39_37 <= 0 and var_39_33 or var_39_33 * (var_39_38 / var_39_37)

				if var_39_39 > 0 and var_39_33 < var_39_39 then
					arg_36_1.talkMaxDuration = var_39_39

					if var_39_39 + var_39_32 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_39 + var_39_32
					end
				end

				arg_36_1.text_.text = var_39_36
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072009", "story_v_out_113072.awb") ~= 0 then
					local var_39_40 = manager.audio:GetVoiceLength("story_v_out_113072", "113072009", "story_v_out_113072.awb") / 1000

					if var_39_40 + var_39_32 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_40 + var_39_32
					end

					if var_39_35.prefab_name ~= "" and arg_36_1.actors_[var_39_35.prefab_name] ~= nil then
						local var_39_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_35.prefab_name].transform, "story_v_out_113072", "113072009", "story_v_out_113072.awb")

						arg_36_1:RecordAudio("113072009", var_39_41)
						arg_36_1:RecordAudio("113072009", var_39_41)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_113072", "113072009", "story_v_out_113072.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_113072", "113072009", "story_v_out_113072.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_42 = math.max(var_39_33, arg_36_1.talkMaxDuration)

			if var_39_32 <= arg_36_1.time_ and arg_36_1.time_ < var_39_32 + var_39_42 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_32) / var_39_42

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_32 + var_39_42 and arg_36_1.time_ < var_39_32 + var_39_42 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play113072010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 113072010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play113072011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.3
			local var_43_1 = 0.7

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				local var_43_2 = "play"
				local var_43_3 = "effect"

				arg_40_1:AudioAction(var_43_2, var_43_3, "se_story_10", "se_story_10_hit", "")
			end

			local var_43_4 = 0
			local var_43_5 = 1.425

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(113072010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_8 = 57
				local var_43_9 = utf8.len(var_43_7)
				local var_43_10 = var_43_8 <= 0 and var_43_5 or var_43_5 * (var_43_9 / var_43_8)

				if var_43_10 > 0 and var_43_5 < var_43_10 then
					arg_40_1.talkMaxDuration = var_43_10

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_11 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_11 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_11

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_11 and arg_40_1.time_ < var_43_4 + var_43_11 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play113072011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 113072011
		arg_44_1.duration_ = 3

		local var_44_0 = {
			ja = 2.6,
			ko = 2,
			zh = 3,
			en = 2.2
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
				arg_44_0:Play113072012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_1")
			end

			local var_47_1 = arg_44_1.actors_["6046_story"].transform
			local var_47_2 = 0

			if var_47_2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.var_.moveOldPos6046_story = var_47_1.localPosition

				local var_47_3 = GameObjectTools.GetOrAddComponent(var_47_1.gameObject, typeof(DynamicBoneHelper))

				if var_47_3 then
					var_47_3:EnableDynamicBone(false)
				end
			end

			local var_47_4 = 0.001

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_4 then
				local var_47_5 = (arg_44_1.time_ - var_47_2) / var_47_4
				local var_47_6 = Vector3.New(-0.7, -0.5, -6.3)

				var_47_1.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos6046_story, var_47_6, var_47_5)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_1.position

				var_47_1.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_1.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_1.localEulerAngles = var_47_8
			end

			if arg_44_1.time_ >= var_47_2 + var_47_4 and arg_44_1.time_ < var_47_2 + var_47_4 + arg_47_0 then
				var_47_1.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_47_9 = manager.ui.mainCamera.transform.position - var_47_1.position

				var_47_1.forward = Vector3.New(var_47_9.x, var_47_9.y, var_47_9.z)

				local var_47_10 = var_47_1.localEulerAngles

				var_47_10.z = 0
				var_47_10.x = 0
				var_47_1.localEulerAngles = var_47_10

				local var_47_11 = GameObjectTools.GetOrAddComponent(var_47_1.gameObject, typeof(DynamicBoneHelper))

				if var_47_11 then
					var_47_11:EnableDynamicBone(true)
				end
			end

			local var_47_12 = arg_44_1.actors_["6046_story"]
			local var_47_13 = 0

			if var_47_13 < arg_44_1.time_ and arg_44_1.time_ <= var_47_13 + arg_47_0 and not isNil(var_47_12) and arg_44_1.var_.characterEffect6046_story == nil then
				arg_44_1.var_.characterEffect6046_story = var_47_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_14 = 0.2

			if var_47_13 <= arg_44_1.time_ and arg_44_1.time_ < var_47_13 + var_47_14 and not isNil(var_47_12) then
				local var_47_15 = (arg_44_1.time_ - var_47_13) / var_47_14

				if arg_44_1.var_.characterEffect6046_story and not isNil(var_47_12) then
					arg_44_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_13 + var_47_14 and arg_44_1.time_ < var_47_13 + var_47_14 + arg_47_0 and not isNil(var_47_12) and arg_44_1.var_.characterEffect6046_story then
				arg_44_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_47_17 = 0
			local var_47_18 = 0.175

			if var_47_17 < arg_44_1.time_ and arg_44_1.time_ <= var_47_17 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_19 = arg_44_1:FormatText(StoryNameCfg[214].name)

				arg_44_1.leftNameTxt_.text = var_47_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_20 = arg_44_1:GetWordFromCfg(113072011)
				local var_47_21 = arg_44_1:FormatText(var_47_20.content)

				arg_44_1.text_.text = var_47_21

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_22 = 7
				local var_47_23 = utf8.len(var_47_21)
				local var_47_24 = var_47_22 <= 0 and var_47_18 or var_47_18 * (var_47_23 / var_47_22)

				if var_47_24 > 0 and var_47_18 < var_47_24 then
					arg_44_1.talkMaxDuration = var_47_24

					if var_47_24 + var_47_17 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_24 + var_47_17
					end
				end

				arg_44_1.text_.text = var_47_21
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072011", "story_v_out_113072.awb") ~= 0 then
					local var_47_25 = manager.audio:GetVoiceLength("story_v_out_113072", "113072011", "story_v_out_113072.awb") / 1000

					if var_47_25 + var_47_17 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_25 + var_47_17
					end

					if var_47_20.prefab_name ~= "" and arg_44_1.actors_[var_47_20.prefab_name] ~= nil then
						local var_47_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_20.prefab_name].transform, "story_v_out_113072", "113072011", "story_v_out_113072.awb")

						arg_44_1:RecordAudio("113072011", var_47_26)
						arg_44_1:RecordAudio("113072011", var_47_26)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_113072", "113072011", "story_v_out_113072.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_113072", "113072011", "story_v_out_113072.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_27 = math.max(var_47_18, arg_44_1.talkMaxDuration)

			if var_47_17 <= arg_44_1.time_ and arg_44_1.time_ < var_47_17 + var_47_27 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_17) / var_47_27

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_17 + var_47_27 and arg_44_1.time_ < var_47_17 + var_47_27 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play113072012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 113072012
		arg_48_1.duration_ = 8.1

		local var_48_0 = {
			ja = 8.1,
			ko = 5.8,
			zh = 6.7,
			en = 4.2
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
				arg_48_0:Play113072013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_51_1 = arg_48_1.actors_["6045_story"]
			local var_51_2 = 0

			if var_51_2 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect6045_story == nil then
				arg_48_1.var_.characterEffect6045_story = var_51_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.2

			if var_51_2 <= arg_48_1.time_ and arg_48_1.time_ < var_51_2 + var_51_3 and not isNil(var_51_1) then
				local var_51_4 = (arg_48_1.time_ - var_51_2) / var_51_3

				if arg_48_1.var_.characterEffect6045_story and not isNil(var_51_1) then
					arg_48_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_2 + var_51_3 and arg_48_1.time_ < var_51_2 + var_51_3 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect6045_story then
				arg_48_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_51_5 = arg_48_1.actors_["6045_story"].transform
			local var_51_6 = 0

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.var_.moveOldPos6045_story = var_51_5.localPosition

				local var_51_7 = GameObjectTools.GetOrAddComponent(var_51_5.gameObject, typeof(DynamicBoneHelper))

				if var_51_7 then
					var_51_7:EnableDynamicBone(false)
				end
			end

			local var_51_8 = 0.001

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_8 then
				local var_51_9 = (arg_48_1.time_ - var_51_6) / var_51_8
				local var_51_10 = Vector3.New(0.7, -0.5, -6.3)

				var_51_5.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos6045_story, var_51_10, var_51_9)

				local var_51_11 = manager.ui.mainCamera.transform.position - var_51_5.position

				var_51_5.forward = Vector3.New(var_51_11.x, var_51_11.y, var_51_11.z)

				local var_51_12 = var_51_5.localEulerAngles

				var_51_12.z = 0
				var_51_12.x = 0
				var_51_5.localEulerAngles = var_51_12
			end

			if arg_48_1.time_ >= var_51_6 + var_51_8 and arg_48_1.time_ < var_51_6 + var_51_8 + arg_51_0 then
				var_51_5.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_51_13 = manager.ui.mainCamera.transform.position - var_51_5.position

				var_51_5.forward = Vector3.New(var_51_13.x, var_51_13.y, var_51_13.z)

				local var_51_14 = var_51_5.localEulerAngles

				var_51_14.z = 0
				var_51_14.x = 0
				var_51_5.localEulerAngles = var_51_14

				local var_51_15 = GameObjectTools.GetOrAddComponent(var_51_5.gameObject, typeof(DynamicBoneHelper))

				if var_51_15 then
					var_51_15:EnableDynamicBone(true)
				end
			end

			local var_51_16 = 0

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				arg_48_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_51_17 = arg_48_1.actors_["6046_story"]
			local var_51_18 = 0

			if var_51_18 < arg_48_1.time_ and arg_48_1.time_ <= var_51_18 + arg_51_0 and not isNil(var_51_17) and arg_48_1.var_.characterEffect6046_story == nil then
				arg_48_1.var_.characterEffect6046_story = var_51_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_19 = 0.2

			if var_51_18 <= arg_48_1.time_ and arg_48_1.time_ < var_51_18 + var_51_19 and not isNil(var_51_17) then
				local var_51_20 = (arg_48_1.time_ - var_51_18) / var_51_19

				if arg_48_1.var_.characterEffect6046_story and not isNil(var_51_17) then
					local var_51_21 = Mathf.Lerp(0, 0.5, var_51_20)

					arg_48_1.var_.characterEffect6046_story.fillFlat = true
					arg_48_1.var_.characterEffect6046_story.fillRatio = var_51_21
				end
			end

			if arg_48_1.time_ >= var_51_18 + var_51_19 and arg_48_1.time_ < var_51_18 + var_51_19 + arg_51_0 and not isNil(var_51_17) and arg_48_1.var_.characterEffect6046_story then
				local var_51_22 = 0.5

				arg_48_1.var_.characterEffect6046_story.fillFlat = true
				arg_48_1.var_.characterEffect6046_story.fillRatio = var_51_22
			end

			local var_51_23 = 0
			local var_51_24 = 0.55

			if var_51_23 < arg_48_1.time_ and arg_48_1.time_ <= var_51_23 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_25 = arg_48_1:FormatText(StoryNameCfg[215].name)

				arg_48_1.leftNameTxt_.text = var_51_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_26 = arg_48_1:GetWordFromCfg(113072012)
				local var_51_27 = arg_48_1:FormatText(var_51_26.content)

				arg_48_1.text_.text = var_51_27

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_28 = 22
				local var_51_29 = utf8.len(var_51_27)
				local var_51_30 = var_51_28 <= 0 and var_51_24 or var_51_24 * (var_51_29 / var_51_28)

				if var_51_30 > 0 and var_51_24 < var_51_30 then
					arg_48_1.talkMaxDuration = var_51_30

					if var_51_30 + var_51_23 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_30 + var_51_23
					end
				end

				arg_48_1.text_.text = var_51_27
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072012", "story_v_out_113072.awb") ~= 0 then
					local var_51_31 = manager.audio:GetVoiceLength("story_v_out_113072", "113072012", "story_v_out_113072.awb") / 1000

					if var_51_31 + var_51_23 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_31 + var_51_23
					end

					if var_51_26.prefab_name ~= "" and arg_48_1.actors_[var_51_26.prefab_name] ~= nil then
						local var_51_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_26.prefab_name].transform, "story_v_out_113072", "113072012", "story_v_out_113072.awb")

						arg_48_1:RecordAudio("113072012", var_51_32)
						arg_48_1:RecordAudio("113072012", var_51_32)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_113072", "113072012", "story_v_out_113072.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_113072", "113072012", "story_v_out_113072.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_33 = math.max(var_51_24, arg_48_1.talkMaxDuration)

			if var_51_23 <= arg_48_1.time_ and arg_48_1.time_ < var_51_23 + var_51_33 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_23) / var_51_33

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_23 + var_51_33 and arg_48_1.time_ < var_51_23 + var_51_33 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play113072013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 113072013
		arg_52_1.duration_ = 6.03

		local var_52_0 = {
			ja = 6.033,
			ko = 4.5,
			zh = 4.4,
			en = 3.666
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
				arg_52_0:Play113072014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action424")
			end

			local var_55_1 = arg_52_1.actors_["6046_story"]
			local var_55_2 = 0

			if var_55_2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect6046_story == nil then
				arg_52_1.var_.characterEffect6046_story = var_55_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.2

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_3 and not isNil(var_55_1) then
				local var_55_4 = (arg_52_1.time_ - var_55_2) / var_55_3

				if arg_52_1.var_.characterEffect6046_story and not isNil(var_55_1) then
					arg_52_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_2 + var_55_3 and arg_52_1.time_ < var_55_2 + var_55_3 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect6046_story then
				arg_52_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_55_6 = arg_52_1.actors_["6045_story"]
			local var_55_7 = 0

			if var_55_7 < arg_52_1.time_ and arg_52_1.time_ <= var_55_7 + arg_55_0 and not isNil(var_55_6) and arg_52_1.var_.characterEffect6045_story == nil then
				arg_52_1.var_.characterEffect6045_story = var_55_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_8 = 0.2

			if var_55_7 <= arg_52_1.time_ and arg_52_1.time_ < var_55_7 + var_55_8 and not isNil(var_55_6) then
				local var_55_9 = (arg_52_1.time_ - var_55_7) / var_55_8

				if arg_52_1.var_.characterEffect6045_story and not isNil(var_55_6) then
					local var_55_10 = Mathf.Lerp(0, 0.5, var_55_9)

					arg_52_1.var_.characterEffect6045_story.fillFlat = true
					arg_52_1.var_.characterEffect6045_story.fillRatio = var_55_10
				end
			end

			if arg_52_1.time_ >= var_55_7 + var_55_8 and arg_52_1.time_ < var_55_7 + var_55_8 + arg_55_0 and not isNil(var_55_6) and arg_52_1.var_.characterEffect6045_story then
				local var_55_11 = 0.5

				arg_52_1.var_.characterEffect6045_story.fillFlat = true
				arg_52_1.var_.characterEffect6045_story.fillRatio = var_55_11
			end

			local var_55_12 = 0
			local var_55_13 = 0.425

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_14 = arg_52_1:FormatText(StoryNameCfg[214].name)

				arg_52_1.leftNameTxt_.text = var_55_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_15 = arg_52_1:GetWordFromCfg(113072013)
				local var_55_16 = arg_52_1:FormatText(var_55_15.content)

				arg_52_1.text_.text = var_55_16

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_17 = 17
				local var_55_18 = utf8.len(var_55_16)
				local var_55_19 = var_55_17 <= 0 and var_55_13 or var_55_13 * (var_55_18 / var_55_17)

				if var_55_19 > 0 and var_55_13 < var_55_19 then
					arg_52_1.talkMaxDuration = var_55_19

					if var_55_19 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_19 + var_55_12
					end
				end

				arg_52_1.text_.text = var_55_16
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072013", "story_v_out_113072.awb") ~= 0 then
					local var_55_20 = manager.audio:GetVoiceLength("story_v_out_113072", "113072013", "story_v_out_113072.awb") / 1000

					if var_55_20 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_20 + var_55_12
					end

					if var_55_15.prefab_name ~= "" and arg_52_1.actors_[var_55_15.prefab_name] ~= nil then
						local var_55_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_15.prefab_name].transform, "story_v_out_113072", "113072013", "story_v_out_113072.awb")

						arg_52_1:RecordAudio("113072013", var_55_21)
						arg_52_1:RecordAudio("113072013", var_55_21)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_113072", "113072013", "story_v_out_113072.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_113072", "113072013", "story_v_out_113072.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_22 = math.max(var_55_13, arg_52_1.talkMaxDuration)

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_22 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_12) / var_55_22

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_12 + var_55_22 and arg_52_1.time_ < var_55_12 + var_55_22 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play113072014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 113072014
		arg_56_1.duration_ = 2.2

		local var_56_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.2
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
				arg_56_0:Play113072015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["6045_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos6045_story = var_59_0.localPosition

				local var_59_2 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(false)
				end
			end

			local var_59_3 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_3 then
				local var_59_4 = (arg_56_1.time_ - var_59_1) / var_59_3
				local var_59_5 = Vector3.New(0, 100, 0)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos6045_story, var_59_5, var_59_4)

				local var_59_6 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_6.x, var_59_6.y, var_59_6.z)

				local var_59_7 = var_59_0.localEulerAngles

				var_59_7.z = 0
				var_59_7.x = 0
				var_59_0.localEulerAngles = var_59_7
			end

			if arg_56_1.time_ >= var_59_1 + var_59_3 and arg_56_1.time_ < var_59_1 + var_59_3 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, 100, 0)

				local var_59_8 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_8.x, var_59_8.y, var_59_8.z)

				local var_59_9 = var_59_0.localEulerAngles

				var_59_9.z = 0
				var_59_9.x = 0
				var_59_0.localEulerAngles = var_59_9

				local var_59_10 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_10 then
					var_59_10:EnableDynamicBone(true)
				end
			end

			local var_59_11 = arg_56_1.actors_["6046_story"].transform
			local var_59_12 = 0

			if var_59_12 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 then
				arg_56_1.var_.moveOldPos6046_story = var_59_11.localPosition

				local var_59_13 = GameObjectTools.GetOrAddComponent(var_59_11.gameObject, typeof(DynamicBoneHelper))

				if var_59_13 then
					var_59_13:EnableDynamicBone(false)
				end
			end

			local var_59_14 = 0.001

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_14 then
				local var_59_15 = (arg_56_1.time_ - var_59_12) / var_59_14
				local var_59_16 = Vector3.New(0, 100, 0)

				var_59_11.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos6046_story, var_59_16, var_59_15)

				local var_59_17 = manager.ui.mainCamera.transform.position - var_59_11.position

				var_59_11.forward = Vector3.New(var_59_17.x, var_59_17.y, var_59_17.z)

				local var_59_18 = var_59_11.localEulerAngles

				var_59_18.z = 0
				var_59_18.x = 0
				var_59_11.localEulerAngles = var_59_18
			end

			if arg_56_1.time_ >= var_59_12 + var_59_14 and arg_56_1.time_ < var_59_12 + var_59_14 + arg_59_0 then
				var_59_11.localPosition = Vector3.New(0, 100, 0)

				local var_59_19 = manager.ui.mainCamera.transform.position - var_59_11.position

				var_59_11.forward = Vector3.New(var_59_19.x, var_59_19.y, var_59_19.z)

				local var_59_20 = var_59_11.localEulerAngles

				var_59_20.z = 0
				var_59_20.x = 0
				var_59_11.localEulerAngles = var_59_20

				local var_59_21 = GameObjectTools.GetOrAddComponent(var_59_11.gameObject, typeof(DynamicBoneHelper))

				if var_59_21 then
					var_59_21:EnableDynamicBone(true)
				end
			end

			local var_59_22 = "1084ui_story"

			if arg_56_1.actors_[var_59_22] == nil then
				local var_59_23 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_59_23) then
					local var_59_24 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_56_1.stage_.transform)

					var_59_24.name = var_59_22
					var_59_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_56_1.actors_[var_59_22] = var_59_24

					local var_59_25 = var_59_24:GetComponentInChildren(typeof(CharacterEffect))

					var_59_25.enabled = true

					local var_59_26 = GameObjectTools.GetOrAddComponent(var_59_24, typeof(DynamicBoneHelper))

					if var_59_26 then
						var_59_26:EnableDynamicBone(false)
					end

					arg_56_1:ShowWeapon(var_59_25.transform, false)

					arg_56_1.var_[var_59_22 .. "Animator"] = var_59_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_56_1.var_[var_59_22 .. "Animator"].applyRootMotion = true
					arg_56_1.var_[var_59_22 .. "LipSync"] = var_59_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_59_27 = arg_56_1.actors_["1084ui_story"].transform
			local var_59_28 = 0

			if var_59_28 < arg_56_1.time_ and arg_56_1.time_ <= var_59_28 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_27.localPosition
			end

			local var_59_29 = 0.001

			if var_59_28 <= arg_56_1.time_ and arg_56_1.time_ < var_59_28 + var_59_29 then
				local var_59_30 = (arg_56_1.time_ - var_59_28) / var_59_29
				local var_59_31 = Vector3.New(-0.7, -0.97, -6)

				var_59_27.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, var_59_31, var_59_30)

				local var_59_32 = manager.ui.mainCamera.transform.position - var_59_27.position

				var_59_27.forward = Vector3.New(var_59_32.x, var_59_32.y, var_59_32.z)

				local var_59_33 = var_59_27.localEulerAngles

				var_59_33.z = 0
				var_59_33.x = 0
				var_59_27.localEulerAngles = var_59_33
			end

			if arg_56_1.time_ >= var_59_28 + var_59_29 and arg_56_1.time_ < var_59_28 + var_59_29 + arg_59_0 then
				var_59_27.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_59_34 = manager.ui.mainCamera.transform.position - var_59_27.position

				var_59_27.forward = Vector3.New(var_59_34.x, var_59_34.y, var_59_34.z)

				local var_59_35 = var_59_27.localEulerAngles

				var_59_35.z = 0
				var_59_35.x = 0
				var_59_27.localEulerAngles = var_59_35
			end

			local var_59_36 = 0

			if var_59_36 < arg_56_1.time_ and arg_56_1.time_ <= var_59_36 + arg_59_0 then
				arg_56_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_59_37 = 0

			if var_59_37 < arg_56_1.time_ and arg_56_1.time_ <= var_59_37 + arg_59_0 then
				arg_56_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_59_38 = arg_56_1.actors_["1084ui_story"]
			local var_59_39 = 0

			if var_59_39 < arg_56_1.time_ and arg_56_1.time_ <= var_59_39 + arg_59_0 and not isNil(var_59_38) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = var_59_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_40 = 0.2

			if var_59_39 <= arg_56_1.time_ and arg_56_1.time_ < var_59_39 + var_59_40 and not isNil(var_59_38) then
				local var_59_41 = (arg_56_1.time_ - var_59_39) / var_59_40

				if arg_56_1.var_.characterEffect1084ui_story and not isNil(var_59_38) then
					arg_56_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_39 + var_59_40 and arg_56_1.time_ < var_59_39 + var_59_40 + arg_59_0 and not isNil(var_59_38) and arg_56_1.var_.characterEffect1084ui_story then
				arg_56_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_59_42 = 0
			local var_59_43 = 0.15

			if var_59_42 < arg_56_1.time_ and arg_56_1.time_ <= var_59_42 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_44 = arg_56_1:FormatText(StoryNameCfg[6].name)

				arg_56_1.leftNameTxt_.text = var_59_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_45 = arg_56_1:GetWordFromCfg(113072014)
				local var_59_46 = arg_56_1:FormatText(var_59_45.content)

				arg_56_1.text_.text = var_59_46

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_47 = 6
				local var_59_48 = utf8.len(var_59_46)
				local var_59_49 = var_59_47 <= 0 and var_59_43 or var_59_43 * (var_59_48 / var_59_47)

				if var_59_49 > 0 and var_59_43 < var_59_49 then
					arg_56_1.talkMaxDuration = var_59_49

					if var_59_49 + var_59_42 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_49 + var_59_42
					end
				end

				arg_56_1.text_.text = var_59_46
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072014", "story_v_out_113072.awb") ~= 0 then
					local var_59_50 = manager.audio:GetVoiceLength("story_v_out_113072", "113072014", "story_v_out_113072.awb") / 1000

					if var_59_50 + var_59_42 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_50 + var_59_42
					end

					if var_59_45.prefab_name ~= "" and arg_56_1.actors_[var_59_45.prefab_name] ~= nil then
						local var_59_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_45.prefab_name].transform, "story_v_out_113072", "113072014", "story_v_out_113072.awb")

						arg_56_1:RecordAudio("113072014", var_59_51)
						arg_56_1:RecordAudio("113072014", var_59_51)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_113072", "113072014", "story_v_out_113072.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_113072", "113072014", "story_v_out_113072.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_52 = math.max(var_59_43, arg_56_1.talkMaxDuration)

			if var_59_42 <= arg_56_1.time_ and arg_56_1.time_ < var_59_42 + var_59_52 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_42) / var_59_52

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_42 + var_59_52 and arg_56_1.time_ < var_59_42 + var_59_52 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play113072015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 113072015
		arg_60_1.duration_ = 6.7

		local var_60_0 = {
			ja = 3.1,
			ko = 5.5,
			zh = 5.633,
			en = 6.7
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
				arg_60_0:Play113072016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1084ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.2

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1084ui_story and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1084ui_story.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1084ui_story then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1084ui_story.fillRatio = var_63_5
			end

			local var_63_6 = arg_60_1.actors_["1042ui_story"].transform
			local var_63_7 = 0

			if var_63_7 < arg_60_1.time_ and arg_60_1.time_ <= var_63_7 + arg_63_0 then
				arg_60_1.var_.moveOldPos1042ui_story = var_63_6.localPosition
			end

			local var_63_8 = 0.001

			if var_63_7 <= arg_60_1.time_ and arg_60_1.time_ < var_63_7 + var_63_8 then
				local var_63_9 = (arg_60_1.time_ - var_63_7) / var_63_8
				local var_63_10 = Vector3.New(0.7, -1.06, -6.2)

				var_63_6.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1042ui_story, var_63_10, var_63_9)

				local var_63_11 = manager.ui.mainCamera.transform.position - var_63_6.position

				var_63_6.forward = Vector3.New(var_63_11.x, var_63_11.y, var_63_11.z)

				local var_63_12 = var_63_6.localEulerAngles

				var_63_12.z = 0
				var_63_12.x = 0
				var_63_6.localEulerAngles = var_63_12
			end

			if arg_60_1.time_ >= var_63_7 + var_63_8 and arg_60_1.time_ < var_63_7 + var_63_8 + arg_63_0 then
				var_63_6.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_63_13 = manager.ui.mainCamera.transform.position - var_63_6.position

				var_63_6.forward = Vector3.New(var_63_13.x, var_63_13.y, var_63_13.z)

				local var_63_14 = var_63_6.localEulerAngles

				var_63_14.z = 0
				var_63_14.x = 0
				var_63_6.localEulerAngles = var_63_14
			end

			local var_63_15 = 0

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_63_16 = 0

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_63_17 = arg_60_1.actors_["1042ui_story"]
			local var_63_18 = 0

			if var_63_18 < arg_60_1.time_ and arg_60_1.time_ <= var_63_18 + arg_63_0 and not isNil(var_63_17) and arg_60_1.var_.characterEffect1042ui_story == nil then
				arg_60_1.var_.characterEffect1042ui_story = var_63_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_19 = 0.2

			if var_63_18 <= arg_60_1.time_ and arg_60_1.time_ < var_63_18 + var_63_19 and not isNil(var_63_17) then
				local var_63_20 = (arg_60_1.time_ - var_63_18) / var_63_19

				if arg_60_1.var_.characterEffect1042ui_story and not isNil(var_63_17) then
					arg_60_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_18 + var_63_19 and arg_60_1.time_ < var_63_18 + var_63_19 + arg_63_0 and not isNil(var_63_17) and arg_60_1.var_.characterEffect1042ui_story then
				arg_60_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_63_21 = 0
			local var_63_22 = 0.475

			if var_63_21 < arg_60_1.time_ and arg_60_1.time_ <= var_63_21 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_23 = arg_60_1:FormatText(StoryNameCfg[205].name)

				arg_60_1.leftNameTxt_.text = var_63_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_24 = arg_60_1:GetWordFromCfg(113072015)
				local var_63_25 = arg_60_1:FormatText(var_63_24.content)

				arg_60_1.text_.text = var_63_25

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_26 = 19
				local var_63_27 = utf8.len(var_63_25)
				local var_63_28 = var_63_26 <= 0 and var_63_22 or var_63_22 * (var_63_27 / var_63_26)

				if var_63_28 > 0 and var_63_22 < var_63_28 then
					arg_60_1.talkMaxDuration = var_63_28

					if var_63_28 + var_63_21 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_28 + var_63_21
					end
				end

				arg_60_1.text_.text = var_63_25
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072015", "story_v_out_113072.awb") ~= 0 then
					local var_63_29 = manager.audio:GetVoiceLength("story_v_out_113072", "113072015", "story_v_out_113072.awb") / 1000

					if var_63_29 + var_63_21 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_29 + var_63_21
					end

					if var_63_24.prefab_name ~= "" and arg_60_1.actors_[var_63_24.prefab_name] ~= nil then
						local var_63_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_24.prefab_name].transform, "story_v_out_113072", "113072015", "story_v_out_113072.awb")

						arg_60_1:RecordAudio("113072015", var_63_30)
						arg_60_1:RecordAudio("113072015", var_63_30)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_113072", "113072015", "story_v_out_113072.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_113072", "113072015", "story_v_out_113072.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_31 = math.max(var_63_22, arg_60_1.talkMaxDuration)

			if var_63_21 <= arg_60_1.time_ and arg_60_1.time_ < var_63_21 + var_63_31 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_21) / var_63_31

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_21 + var_63_31 and arg_60_1.time_ < var_63_21 + var_63_31 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play113072016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 113072016
		arg_64_1.duration_ = 7.1

		local var_64_0 = {
			ja = 4.633,
			ko = 5.1,
			zh = 7.1,
			en = 4.4
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
				arg_64_0:Play113072017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1084ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["1042ui_story"].transform
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.var_.moveOldPos1042ui_story = var_67_9.localPosition
			end

			local var_67_11 = 0.001

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11
				local var_67_13 = Vector3.New(0, 100, 0)

				var_67_9.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1042ui_story, var_67_13, var_67_12)

				local var_67_14 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_14.x, var_67_14.y, var_67_14.z)

				local var_67_15 = var_67_9.localEulerAngles

				var_67_15.z = 0
				var_67_15.x = 0
				var_67_9.localEulerAngles = var_67_15
			end

			if arg_64_1.time_ >= var_67_10 + var_67_11 and arg_64_1.time_ < var_67_10 + var_67_11 + arg_67_0 then
				var_67_9.localPosition = Vector3.New(0, 100, 0)

				local var_67_16 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_16.x, var_67_16.y, var_67_16.z)

				local var_67_17 = var_67_9.localEulerAngles

				var_67_17.z = 0
				var_67_17.x = 0
				var_67_9.localEulerAngles = var_67_17
			end

			local var_67_18 = 0
			local var_67_19 = 0.25

			if var_67_18 < arg_64_1.time_ and arg_64_1.time_ <= var_67_18 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_20 = arg_64_1:FormatText(StoryNameCfg[217].name)

				arg_64_1.leftNameTxt_.text = var_67_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3025")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_21 = arg_64_1:GetWordFromCfg(113072016)
				local var_67_22 = arg_64_1:FormatText(var_67_21.content)

				arg_64_1.text_.text = var_67_22

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_23 = 10
				local var_67_24 = utf8.len(var_67_22)
				local var_67_25 = var_67_23 <= 0 and var_67_19 or var_67_19 * (var_67_24 / var_67_23)

				if var_67_25 > 0 and var_67_19 < var_67_25 then
					arg_64_1.talkMaxDuration = var_67_25

					if var_67_25 + var_67_18 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_25 + var_67_18
					end
				end

				arg_64_1.text_.text = var_67_22
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072016", "story_v_out_113072.awb") ~= 0 then
					local var_67_26 = manager.audio:GetVoiceLength("story_v_out_113072", "113072016", "story_v_out_113072.awb") / 1000

					if var_67_26 + var_67_18 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_26 + var_67_18
					end

					if var_67_21.prefab_name ~= "" and arg_64_1.actors_[var_67_21.prefab_name] ~= nil then
						local var_67_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_21.prefab_name].transform, "story_v_out_113072", "113072016", "story_v_out_113072.awb")

						arg_64_1:RecordAudio("113072016", var_67_27)
						arg_64_1:RecordAudio("113072016", var_67_27)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_113072", "113072016", "story_v_out_113072.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_113072", "113072016", "story_v_out_113072.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_28 = math.max(var_67_19, arg_64_1.talkMaxDuration)

			if var_67_18 <= arg_64_1.time_ and arg_64_1.time_ < var_67_18 + var_67_28 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_18) / var_67_28

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_18 + var_67_28 and arg_64_1.time_ < var_67_18 + var_67_28 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play113072017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 113072017
		arg_68_1.duration_ = 2

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play113072018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1041ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1041ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0, -1.11, -5.9)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1041ui_story, var_71_4, var_71_3)

				local var_71_5 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_5.x, var_71_5.y, var_71_5.z)

				local var_71_6 = var_71_0.localEulerAngles

				var_71_6.z = 0
				var_71_6.x = 0
				var_71_0.localEulerAngles = var_71_6
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_0.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_0.localEulerAngles = var_71_8
			end

			local var_71_9 = 0

			if var_71_9 < arg_68_1.time_ and arg_68_1.time_ <= var_71_9 + arg_71_0 then
				arg_68_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_71_11 = arg_68_1.actors_["1041ui_story"]
			local var_71_12 = 0

			if var_71_12 < arg_68_1.time_ and arg_68_1.time_ <= var_71_12 + arg_71_0 and not isNil(var_71_11) and arg_68_1.var_.characterEffect1041ui_story == nil then
				arg_68_1.var_.characterEffect1041ui_story = var_71_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_13 = 0.2

			if var_71_12 <= arg_68_1.time_ and arg_68_1.time_ < var_71_12 + var_71_13 and not isNil(var_71_11) then
				local var_71_14 = (arg_68_1.time_ - var_71_12) / var_71_13

				if arg_68_1.var_.characterEffect1041ui_story and not isNil(var_71_11) then
					arg_68_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_12 + var_71_13 and arg_68_1.time_ < var_71_12 + var_71_13 + arg_71_0 and not isNil(var_71_11) and arg_68_1.var_.characterEffect1041ui_story then
				arg_68_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_71_15 = 0
			local var_71_16 = 0.05

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_17 = arg_68_1:FormatText(StoryNameCfg[208].name)

				arg_68_1.leftNameTxt_.text = var_71_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_18 = arg_68_1:GetWordFromCfg(113072017)
				local var_71_19 = arg_68_1:FormatText(var_71_18.content)

				arg_68_1.text_.text = var_71_19

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_20 = 2
				local var_71_21 = utf8.len(var_71_19)
				local var_71_22 = var_71_20 <= 0 and var_71_16 or var_71_16 * (var_71_21 / var_71_20)

				if var_71_22 > 0 and var_71_16 < var_71_22 then
					arg_68_1.talkMaxDuration = var_71_22

					if var_71_22 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_22 + var_71_15
					end
				end

				arg_68_1.text_.text = var_71_19
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072017", "story_v_out_113072.awb") ~= 0 then
					local var_71_23 = manager.audio:GetVoiceLength("story_v_out_113072", "113072017", "story_v_out_113072.awb") / 1000

					if var_71_23 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_23 + var_71_15
					end

					if var_71_18.prefab_name ~= "" and arg_68_1.actors_[var_71_18.prefab_name] ~= nil then
						local var_71_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_18.prefab_name].transform, "story_v_out_113072", "113072017", "story_v_out_113072.awb")

						arg_68_1:RecordAudio("113072017", var_71_24)
						arg_68_1:RecordAudio("113072017", var_71_24)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_113072", "113072017", "story_v_out_113072.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_113072", "113072017", "story_v_out_113072.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_25 = math.max(var_71_16, arg_68_1.talkMaxDuration)

			if var_71_15 <= arg_68_1.time_ and arg_68_1.time_ < var_71_15 + var_71_25 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_15) / var_71_25

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_15 + var_71_25 and arg_68_1.time_ < var_71_15 + var_71_25 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
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
	Play113072018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 113072018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play113072019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1041ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1041ui_story == nil then
				arg_72_1.var_.characterEffect1041ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1041ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1041ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1041ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1041ui_story.fillRatio = var_75_5
			end

			local var_75_6 = 0
			local var_75_7 = 0.725

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_8 = arg_72_1:GetWordFromCfg(113072018)
				local var_75_9 = arg_72_1:FormatText(var_75_8.content)

				arg_72_1.text_.text = var_75_9

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_10 = 29
				local var_75_11 = utf8.len(var_75_9)
				local var_75_12 = var_75_10 <= 0 and var_75_7 or var_75_7 * (var_75_11 / var_75_10)

				if var_75_12 > 0 and var_75_7 < var_75_12 then
					arg_72_1.talkMaxDuration = var_75_12

					if var_75_12 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_12 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_9
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_13 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_13 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_13

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_13 and arg_72_1.time_ < var_75_6 + var_75_13 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play113072019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 113072019
		arg_76_1.duration_ = 1.03

		local var_76_0 = {
			ja = 1,
			ko = 0.999999999999,
			zh = 0.999999999999,
			en = 1.033
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
				arg_76_0:Play113072020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.1

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[209].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(113072019)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 4
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072019", "story_v_out_113072.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_113072", "113072019", "story_v_out_113072.awb") / 1000

					if var_79_8 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_0
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_113072", "113072019", "story_v_out_113072.awb")

						arg_76_1:RecordAudio("113072019", var_79_9)
						arg_76_1:RecordAudio("113072019", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_113072", "113072019", "story_v_out_113072.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_113072", "113072019", "story_v_out_113072.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_10 and arg_76_1.time_ < var_79_0 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play113072020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 113072020
		arg_80_1.duration_ = 2

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play113072021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_83_2 = arg_80_1.actors_["1041ui_story"]
			local var_83_3 = 0

			if var_83_3 < arg_80_1.time_ and arg_80_1.time_ <= var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect1041ui_story == nil then
				arg_80_1.var_.characterEffect1041ui_story = var_83_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_4 = 0.2

			if var_83_3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_3 + var_83_4 and not isNil(var_83_2) then
				local var_83_5 = (arg_80_1.time_ - var_83_3) / var_83_4

				if arg_80_1.var_.characterEffect1041ui_story and not isNil(var_83_2) then
					arg_80_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_3 + var_83_4 and arg_80_1.time_ < var_83_3 + var_83_4 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect1041ui_story then
				arg_80_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_83_6 = 0
			local var_83_7 = 0.125

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_8 = arg_80_1:FormatText(StoryNameCfg[208].name)

				arg_80_1.leftNameTxt_.text = var_83_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_9 = arg_80_1:GetWordFromCfg(113072020)
				local var_83_10 = arg_80_1:FormatText(var_83_9.content)

				arg_80_1.text_.text = var_83_10

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072020", "story_v_out_113072.awb") ~= 0 then
					local var_83_14 = manager.audio:GetVoiceLength("story_v_out_113072", "113072020", "story_v_out_113072.awb") / 1000

					if var_83_14 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_14 + var_83_6
					end

					if var_83_9.prefab_name ~= "" and arg_80_1.actors_[var_83_9.prefab_name] ~= nil then
						local var_83_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_9.prefab_name].transform, "story_v_out_113072", "113072020", "story_v_out_113072.awb")

						arg_80_1:RecordAudio("113072020", var_83_15)
						arg_80_1:RecordAudio("113072020", var_83_15)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_113072", "113072020", "story_v_out_113072.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_113072", "113072020", "story_v_out_113072.awb")
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
	Play113072021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 113072021
		arg_84_1.duration_ = 8

		local var_84_0 = {
			ja = 5.8,
			ko = 8,
			zh = 6.3,
			en = 7.266
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
				arg_84_0:Play113072022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1041ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1041ui_story == nil then
				arg_84_1.var_.characterEffect1041ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.2

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1041ui_story and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1041ui_story.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1041ui_story then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1041ui_story.fillRatio = var_87_5
			end

			local var_87_6 = 0
			local var_87_7 = 0.875

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_8 = arg_84_1:FormatText(StoryNameCfg[209].name)

				arg_84_1.leftNameTxt_.text = var_87_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_9 = arg_84_1:GetWordFromCfg(113072021)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 35
				local var_87_12 = utf8.len(var_87_10)
				local var_87_13 = var_87_11 <= 0 and var_87_7 or var_87_7 * (var_87_12 / var_87_11)

				if var_87_13 > 0 and var_87_7 < var_87_13 then
					arg_84_1.talkMaxDuration = var_87_13

					if var_87_13 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_10
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072021", "story_v_out_113072.awb") ~= 0 then
					local var_87_14 = manager.audio:GetVoiceLength("story_v_out_113072", "113072021", "story_v_out_113072.awb") / 1000

					if var_87_14 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_6
					end

					if var_87_9.prefab_name ~= "" and arg_84_1.actors_[var_87_9.prefab_name] ~= nil then
						local var_87_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_9.prefab_name].transform, "story_v_out_113072", "113072021", "story_v_out_113072.awb")

						arg_84_1:RecordAudio("113072021", var_87_15)
						arg_84_1:RecordAudio("113072021", var_87_15)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_113072", "113072021", "story_v_out_113072.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_113072", "113072021", "story_v_out_113072.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_16 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_16 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_16

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_16 and arg_84_1.time_ < var_87_6 + var_87_16 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play113072022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 113072022
		arg_88_1.duration_ = 3.7

		local var_88_0 = {
			ja = 3.1,
			ko = 3.7,
			zh = 3.4,
			en = 3.266
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
				arg_88_0:Play113072023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_91_1 = arg_88_1.actors_["1041ui_story"]
			local var_91_2 = 0

			if var_91_2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1041ui_story == nil then
				arg_88_1.var_.characterEffect1041ui_story = var_91_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_3 = 0.2

			if var_91_2 <= arg_88_1.time_ and arg_88_1.time_ < var_91_2 + var_91_3 and not isNil(var_91_1) then
				local var_91_4 = (arg_88_1.time_ - var_91_2) / var_91_3

				if arg_88_1.var_.characterEffect1041ui_story and not isNil(var_91_1) then
					arg_88_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_2 + var_91_3 and arg_88_1.time_ < var_91_2 + var_91_3 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1041ui_story then
				arg_88_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_91_5 = 0
			local var_91_6 = 0.275

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_7 = arg_88_1:FormatText(StoryNameCfg[208].name)

				arg_88_1.leftNameTxt_.text = var_91_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_8 = arg_88_1:GetWordFromCfg(113072022)
				local var_91_9 = arg_88_1:FormatText(var_91_8.content)

				arg_88_1.text_.text = var_91_9

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_10 = 16
				local var_91_11 = utf8.len(var_91_9)
				local var_91_12 = var_91_10 <= 0 and var_91_6 or var_91_6 * (var_91_11 / var_91_10)

				if var_91_12 > 0 and var_91_6 < var_91_12 then
					arg_88_1.talkMaxDuration = var_91_12

					if var_91_12 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_12 + var_91_5
					end
				end

				arg_88_1.text_.text = var_91_9
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072022", "story_v_out_113072.awb") ~= 0 then
					local var_91_13 = manager.audio:GetVoiceLength("story_v_out_113072", "113072022", "story_v_out_113072.awb") / 1000

					if var_91_13 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_5
					end

					if var_91_8.prefab_name ~= "" and arg_88_1.actors_[var_91_8.prefab_name] ~= nil then
						local var_91_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_8.prefab_name].transform, "story_v_out_113072", "113072022", "story_v_out_113072.awb")

						arg_88_1:RecordAudio("113072022", var_91_14)
						arg_88_1:RecordAudio("113072022", var_91_14)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_113072", "113072022", "story_v_out_113072.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_113072", "113072022", "story_v_out_113072.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_15 = math.max(var_91_6, arg_88_1.talkMaxDuration)

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_15 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_5) / var_91_15

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_5 + var_91_15 and arg_88_1.time_ < var_91_5 + var_91_15 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play113072023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 113072023
		arg_92_1.duration_ = 8.6

		local var_92_0 = {
			ja = 7.333,
			ko = 8.6,
			zh = 7.066,
			en = 7
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
				arg_92_0:Play113072024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1041ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1041ui_story = var_95_0.localPosition
			end

			local var_95_2 = 0.5

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2
				local var_95_4 = Vector3.New(-0.7, -1.11, -5.9)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1041ui_story, var_95_4, var_95_3)

				local var_95_5 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_5.x, var_95_5.y, var_95_5.z)

				local var_95_6 = var_95_0.localEulerAngles

				var_95_6.z = 0
				var_95_6.x = 0
				var_95_0.localEulerAngles = var_95_6
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_95_7 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_7.x, var_95_7.y, var_95_7.z)

				local var_95_8 = var_95_0.localEulerAngles

				var_95_8.z = 0
				var_95_8.x = 0
				var_95_0.localEulerAngles = var_95_8
			end

			local var_95_9 = arg_92_1.actors_["1041ui_story"]
			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 and not isNil(var_95_9) and arg_92_1.var_.characterEffect1041ui_story == nil then
				arg_92_1.var_.characterEffect1041ui_story = var_95_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_11 = 0.2

			if var_95_10 <= arg_92_1.time_ and arg_92_1.time_ < var_95_10 + var_95_11 and not isNil(var_95_9) then
				local var_95_12 = (arg_92_1.time_ - var_95_10) / var_95_11

				if arg_92_1.var_.characterEffect1041ui_story and not isNil(var_95_9) then
					local var_95_13 = Mathf.Lerp(0, 0.5, var_95_12)

					arg_92_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1041ui_story.fillRatio = var_95_13
				end
			end

			if arg_92_1.time_ >= var_95_10 + var_95_11 and arg_92_1.time_ < var_95_10 + var_95_11 + arg_95_0 and not isNil(var_95_9) and arg_92_1.var_.characterEffect1041ui_story then
				local var_95_14 = 0.5

				arg_92_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1041ui_story.fillRatio = var_95_14
			end

			local var_95_15 = arg_92_1.actors_["1084ui_story"].transform
			local var_95_16 = 0

			if var_95_16 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 then
				arg_92_1.var_.moveOldPos1084ui_story = var_95_15.localPosition
			end

			local var_95_17 = 0.001

			if var_95_16 <= arg_92_1.time_ and arg_92_1.time_ < var_95_16 + var_95_17 then
				local var_95_18 = (arg_92_1.time_ - var_95_16) / var_95_17
				local var_95_19 = Vector3.New(0.7, -0.97, -6)

				var_95_15.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1084ui_story, var_95_19, var_95_18)

				local var_95_20 = manager.ui.mainCamera.transform.position - var_95_15.position

				var_95_15.forward = Vector3.New(var_95_20.x, var_95_20.y, var_95_20.z)

				local var_95_21 = var_95_15.localEulerAngles

				var_95_21.z = 0
				var_95_21.x = 0
				var_95_15.localEulerAngles = var_95_21
			end

			if arg_92_1.time_ >= var_95_16 + var_95_17 and arg_92_1.time_ < var_95_16 + var_95_17 + arg_95_0 then
				var_95_15.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_95_22 = manager.ui.mainCamera.transform.position - var_95_15.position

				var_95_15.forward = Vector3.New(var_95_22.x, var_95_22.y, var_95_22.z)

				local var_95_23 = var_95_15.localEulerAngles

				var_95_23.z = 0
				var_95_23.x = 0
				var_95_15.localEulerAngles = var_95_23
			end

			local var_95_24 = 0

			if var_95_24 < arg_92_1.time_ and arg_92_1.time_ <= var_95_24 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_95_25 = 0

			if var_95_25 < arg_92_1.time_ and arg_92_1.time_ <= var_95_25 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_95_26 = arg_92_1.actors_["1084ui_story"]
			local var_95_27 = 0

			if var_95_27 < arg_92_1.time_ and arg_92_1.time_ <= var_95_27 + arg_95_0 and not isNil(var_95_26) and arg_92_1.var_.characterEffect1084ui_story == nil then
				arg_92_1.var_.characterEffect1084ui_story = var_95_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_28 = 0.2

			if var_95_27 <= arg_92_1.time_ and arg_92_1.time_ < var_95_27 + var_95_28 and not isNil(var_95_26) then
				local var_95_29 = (arg_92_1.time_ - var_95_27) / var_95_28

				if arg_92_1.var_.characterEffect1084ui_story and not isNil(var_95_26) then
					arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_27 + var_95_28 and arg_92_1.time_ < var_95_27 + var_95_28 + arg_95_0 and not isNil(var_95_26) and arg_92_1.var_.characterEffect1084ui_story then
				arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_95_30 = 0
			local var_95_31 = 0.95

			if var_95_30 < arg_92_1.time_ and arg_92_1.time_ <= var_95_30 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_32 = arg_92_1:FormatText(StoryNameCfg[6].name)

				arg_92_1.leftNameTxt_.text = var_95_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_33 = arg_92_1:GetWordFromCfg(113072023)
				local var_95_34 = arg_92_1:FormatText(var_95_33.content)

				arg_92_1.text_.text = var_95_34

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_35 = 38
				local var_95_36 = utf8.len(var_95_34)
				local var_95_37 = var_95_35 <= 0 and var_95_31 or var_95_31 * (var_95_36 / var_95_35)

				if var_95_37 > 0 and var_95_31 < var_95_37 then
					arg_92_1.talkMaxDuration = var_95_37

					if var_95_37 + var_95_30 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_37 + var_95_30
					end
				end

				arg_92_1.text_.text = var_95_34
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072023", "story_v_out_113072.awb") ~= 0 then
					local var_95_38 = manager.audio:GetVoiceLength("story_v_out_113072", "113072023", "story_v_out_113072.awb") / 1000

					if var_95_38 + var_95_30 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_38 + var_95_30
					end

					if var_95_33.prefab_name ~= "" and arg_92_1.actors_[var_95_33.prefab_name] ~= nil then
						local var_95_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_33.prefab_name].transform, "story_v_out_113072", "113072023", "story_v_out_113072.awb")

						arg_92_1:RecordAudio("113072023", var_95_39)
						arg_92_1:RecordAudio("113072023", var_95_39)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_113072", "113072023", "story_v_out_113072.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_113072", "113072023", "story_v_out_113072.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_40 = math.max(var_95_31, arg_92_1.talkMaxDuration)

			if var_95_30 <= arg_92_1.time_ and arg_92_1.time_ < var_95_30 + var_95_40 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_30) / var_95_40

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_30 + var_95_40 and arg_92_1.time_ < var_95_30 + var_95_40 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play113072024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 113072024
		arg_96_1.duration_ = 2.2

		local var_96_0 = {
			ja = 2.2,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_96_0:Play113072025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1084ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1084ui_story == nil then
				arg_96_1.var_.characterEffect1084ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1084ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1084ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1084ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1084ui_story.fillRatio = var_99_5
			end

			local var_99_6 = 0

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_99_7 = arg_96_1.actors_["1041ui_story"]
			local var_99_8 = 0

			if var_99_8 < arg_96_1.time_ and arg_96_1.time_ <= var_99_8 + arg_99_0 and not isNil(var_99_7) and arg_96_1.var_.characterEffect1041ui_story == nil then
				arg_96_1.var_.characterEffect1041ui_story = var_99_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_9 = 0.2

			if var_99_8 <= arg_96_1.time_ and arg_96_1.time_ < var_99_8 + var_99_9 and not isNil(var_99_7) then
				local var_99_10 = (arg_96_1.time_ - var_99_8) / var_99_9

				if arg_96_1.var_.characterEffect1041ui_story and not isNil(var_99_7) then
					arg_96_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_8 + var_99_9 and arg_96_1.time_ < var_99_8 + var_99_9 + arg_99_0 and not isNil(var_99_7) and arg_96_1.var_.characterEffect1041ui_story then
				arg_96_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_99_11 = 0
			local var_99_12 = 0.15

			if var_99_11 < arg_96_1.time_ and arg_96_1.time_ <= var_99_11 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_13 = arg_96_1:FormatText(StoryNameCfg[208].name)

				arg_96_1.leftNameTxt_.text = var_99_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_14 = arg_96_1:GetWordFromCfg(113072024)
				local var_99_15 = arg_96_1:FormatText(var_99_14.content)

				arg_96_1.text_.text = var_99_15

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_16 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072024", "story_v_out_113072.awb") ~= 0 then
					local var_99_19 = manager.audio:GetVoiceLength("story_v_out_113072", "113072024", "story_v_out_113072.awb") / 1000

					if var_99_19 + var_99_11 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_19 + var_99_11
					end

					if var_99_14.prefab_name ~= "" and arg_96_1.actors_[var_99_14.prefab_name] ~= nil then
						local var_99_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_14.prefab_name].transform, "story_v_out_113072", "113072024", "story_v_out_113072.awb")

						arg_96_1:RecordAudio("113072024", var_99_20)
						arg_96_1:RecordAudio("113072024", var_99_20)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_113072", "113072024", "story_v_out_113072.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_113072", "113072024", "story_v_out_113072.awb")
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
	Play113072025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 113072025
		arg_100_1.duration_ = 2

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play113072026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1084ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1084ui_story == nil then
				arg_100_1.var_.characterEffect1084ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.2

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1084ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1084ui_story then
				arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_103_4 = arg_100_1.actors_["1041ui_story"]
			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect1041ui_story == nil then
				arg_100_1.var_.characterEffect1041ui_story = var_103_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.2

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_6 and not isNil(var_103_4) then
				local var_103_7 = (arg_100_1.time_ - var_103_5) / var_103_6

				if arg_100_1.var_.characterEffect1041ui_story and not isNil(var_103_4) then
					local var_103_8 = Mathf.Lerp(0, 0.5, var_103_7)

					arg_100_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1041ui_story.fillRatio = var_103_8
				end
			end

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect1041ui_story then
				local var_103_9 = 0.5

				arg_100_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1041ui_story.fillRatio = var_103_9
			end

			local var_103_10 = 0

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_103_11 = 0

			if var_103_11 < arg_100_1.time_ and arg_100_1.time_ <= var_103_11 + arg_103_0 then
				arg_100_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_103_12 = 0
			local var_103_13 = 0.05

			if var_103_12 < arg_100_1.time_ and arg_100_1.time_ <= var_103_12 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_14 = arg_100_1:FormatText(StoryNameCfg[6].name)

				arg_100_1.leftNameTxt_.text = var_103_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_15 = arg_100_1:GetWordFromCfg(113072025)
				local var_103_16 = arg_100_1:FormatText(var_103_15.content)

				arg_100_1.text_.text = var_103_16

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_17 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072025", "story_v_out_113072.awb") ~= 0 then
					local var_103_20 = manager.audio:GetVoiceLength("story_v_out_113072", "113072025", "story_v_out_113072.awb") / 1000

					if var_103_20 + var_103_12 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_20 + var_103_12
					end

					if var_103_15.prefab_name ~= "" and arg_100_1.actors_[var_103_15.prefab_name] ~= nil then
						local var_103_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_15.prefab_name].transform, "story_v_out_113072", "113072025", "story_v_out_113072.awb")

						arg_100_1:RecordAudio("113072025", var_103_21)
						arg_100_1:RecordAudio("113072025", var_103_21)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_113072", "113072025", "story_v_out_113072.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_113072", "113072025", "story_v_out_113072.awb")
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
	Play113072026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 113072026
		arg_104_1.duration_ = 11.8

		local var_104_0 = {
			ja = 8.1,
			ko = 6.7,
			zh = 7.533,
			en = 11.8
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
				arg_104_0:Play113072027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1084ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1084ui_story == nil then
				arg_104_1.var_.characterEffect1084ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.2

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1084ui_story and not isNil(var_107_0) then
					local var_107_4 = Mathf.Lerp(0, 0.5, var_107_3)

					arg_104_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1084ui_story.fillRatio = var_107_4
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1084ui_story then
				local var_107_5 = 0.5

				arg_104_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1084ui_story.fillRatio = var_107_5
			end

			local var_107_6 = 0

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_107_7 = arg_104_1.actors_["1041ui_story"]
			local var_107_8 = 0

			if var_107_8 < arg_104_1.time_ and arg_104_1.time_ <= var_107_8 + arg_107_0 and not isNil(var_107_7) and arg_104_1.var_.characterEffect1041ui_story == nil then
				arg_104_1.var_.characterEffect1041ui_story = var_107_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_9 = 0.2

			if var_107_8 <= arg_104_1.time_ and arg_104_1.time_ < var_107_8 + var_107_9 and not isNil(var_107_7) then
				local var_107_10 = (arg_104_1.time_ - var_107_8) / var_107_9

				if arg_104_1.var_.characterEffect1041ui_story and not isNil(var_107_7) then
					arg_104_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_8 + var_107_9 and arg_104_1.time_ < var_107_8 + var_107_9 + arg_107_0 and not isNil(var_107_7) and arg_104_1.var_.characterEffect1041ui_story then
				arg_104_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_107_11 = 0
			local var_107_12 = 1.05

			if var_107_11 < arg_104_1.time_ and arg_104_1.time_ <= var_107_11 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_13 = arg_104_1:FormatText(StoryNameCfg[208].name)

				arg_104_1.leftNameTxt_.text = var_107_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_14 = arg_104_1:GetWordFromCfg(113072026)
				local var_107_15 = arg_104_1:FormatText(var_107_14.content)

				arg_104_1.text_.text = var_107_15

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_16 = 42
				local var_107_17 = utf8.len(var_107_15)
				local var_107_18 = var_107_16 <= 0 and var_107_12 or var_107_12 * (var_107_17 / var_107_16)

				if var_107_18 > 0 and var_107_12 < var_107_18 then
					arg_104_1.talkMaxDuration = var_107_18

					if var_107_18 + var_107_11 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_18 + var_107_11
					end
				end

				arg_104_1.text_.text = var_107_15
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072026", "story_v_out_113072.awb") ~= 0 then
					local var_107_19 = manager.audio:GetVoiceLength("story_v_out_113072", "113072026", "story_v_out_113072.awb") / 1000

					if var_107_19 + var_107_11 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_19 + var_107_11
					end

					if var_107_14.prefab_name ~= "" and arg_104_1.actors_[var_107_14.prefab_name] ~= nil then
						local var_107_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_14.prefab_name].transform, "story_v_out_113072", "113072026", "story_v_out_113072.awb")

						arg_104_1:RecordAudio("113072026", var_107_20)
						arg_104_1:RecordAudio("113072026", var_107_20)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_113072", "113072026", "story_v_out_113072.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_113072", "113072026", "story_v_out_113072.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_21 = math.max(var_107_12, arg_104_1.talkMaxDuration)

			if var_107_11 <= arg_104_1.time_ and arg_104_1.time_ < var_107_11 + var_107_21 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_11) / var_107_21

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_11 + var_107_21 and arg_104_1.time_ < var_107_11 + var_107_21 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play113072027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 113072027
		arg_108_1.duration_ = 6.8

		local var_108_0 = {
			ja = 4.466,
			ko = 6.6,
			zh = 6.066,
			en = 6.8
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
				arg_108_0:Play113072028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action6_1")
			end

			local var_111_2 = 0
			local var_111_3 = 0.7

			if var_111_2 < arg_108_1.time_ and arg_108_1.time_ <= var_111_2 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_4 = arg_108_1:FormatText(StoryNameCfg[208].name)

				arg_108_1.leftNameTxt_.text = var_111_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_5 = arg_108_1:GetWordFromCfg(113072027)
				local var_111_6 = arg_108_1:FormatText(var_111_5.content)

				arg_108_1.text_.text = var_111_6

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_7 = 28
				local var_111_8 = utf8.len(var_111_6)
				local var_111_9 = var_111_7 <= 0 and var_111_3 or var_111_3 * (var_111_8 / var_111_7)

				if var_111_9 > 0 and var_111_3 < var_111_9 then
					arg_108_1.talkMaxDuration = var_111_9

					if var_111_9 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_2
					end
				end

				arg_108_1.text_.text = var_111_6
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072027", "story_v_out_113072.awb") ~= 0 then
					local var_111_10 = manager.audio:GetVoiceLength("story_v_out_113072", "113072027", "story_v_out_113072.awb") / 1000

					if var_111_10 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_2
					end

					if var_111_5.prefab_name ~= "" and arg_108_1.actors_[var_111_5.prefab_name] ~= nil then
						local var_111_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_5.prefab_name].transform, "story_v_out_113072", "113072027", "story_v_out_113072.awb")

						arg_108_1:RecordAudio("113072027", var_111_11)
						arg_108_1:RecordAudio("113072027", var_111_11)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_113072", "113072027", "story_v_out_113072.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_113072", "113072027", "story_v_out_113072.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_12 = math.max(var_111_3, arg_108_1.talkMaxDuration)

			if var_111_2 <= arg_108_1.time_ and arg_108_1.time_ < var_111_2 + var_111_12 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_2) / var_111_12

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_2 + var_111_12 and arg_108_1.time_ < var_111_2 + var_111_12 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play113072028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 113072028
		arg_112_1.duration_ = 12.7

		local var_112_0 = {
			ja = 12.466,
			ko = 11.966,
			zh = 9.333,
			en = 12.7
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play113072029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1038ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos1038ui_story = var_115_0.localPosition
			end

			local var_115_2 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2
				local var_115_4 = Vector3.New(0.7, -1.11, -5.9)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1038ui_story, var_115_4, var_115_3)

				local var_115_5 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_5.x, var_115_5.y, var_115_5.z)

				local var_115_6 = var_115_0.localEulerAngles

				var_115_6.z = 0
				var_115_6.x = 0
				var_115_0.localEulerAngles = var_115_6
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_115_7 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_7.x, var_115_7.y, var_115_7.z)

				local var_115_8 = var_115_0.localEulerAngles

				var_115_8.z = 0
				var_115_8.x = 0
				var_115_0.localEulerAngles = var_115_8
			end

			local var_115_9 = arg_112_1.actors_["1084ui_story"].transform
			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 then
				arg_112_1.var_.moveOldPos1084ui_story = var_115_9.localPosition
			end

			local var_115_11 = 0.001

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_11 then
				local var_115_12 = (arg_112_1.time_ - var_115_10) / var_115_11
				local var_115_13 = Vector3.New(0, 100, 0)

				var_115_9.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1084ui_story, var_115_13, var_115_12)

				local var_115_14 = manager.ui.mainCamera.transform.position - var_115_9.position

				var_115_9.forward = Vector3.New(var_115_14.x, var_115_14.y, var_115_14.z)

				local var_115_15 = var_115_9.localEulerAngles

				var_115_15.z = 0
				var_115_15.x = 0
				var_115_9.localEulerAngles = var_115_15
			end

			if arg_112_1.time_ >= var_115_10 + var_115_11 and arg_112_1.time_ < var_115_10 + var_115_11 + arg_115_0 then
				var_115_9.localPosition = Vector3.New(0, 100, 0)

				local var_115_16 = manager.ui.mainCamera.transform.position - var_115_9.position

				var_115_9.forward = Vector3.New(var_115_16.x, var_115_16.y, var_115_16.z)

				local var_115_17 = var_115_9.localEulerAngles

				var_115_17.z = 0
				var_115_17.x = 0
				var_115_9.localEulerAngles = var_115_17
			end

			local var_115_18 = 0

			if var_115_18 < arg_112_1.time_ and arg_112_1.time_ <= var_115_18 + arg_115_0 then
				arg_112_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_115_19 = 0

			if var_115_19 < arg_112_1.time_ and arg_112_1.time_ <= var_115_19 + arg_115_0 then
				arg_112_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_115_20 = arg_112_1.actors_["1038ui_story"]
			local var_115_21 = 0

			if var_115_21 < arg_112_1.time_ and arg_112_1.time_ <= var_115_21 + arg_115_0 and not isNil(var_115_20) and arg_112_1.var_.characterEffect1038ui_story == nil then
				arg_112_1.var_.characterEffect1038ui_story = var_115_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_22 = 0.2

			if var_115_21 <= arg_112_1.time_ and arg_112_1.time_ < var_115_21 + var_115_22 and not isNil(var_115_20) then
				local var_115_23 = (arg_112_1.time_ - var_115_21) / var_115_22

				if arg_112_1.var_.characterEffect1038ui_story and not isNil(var_115_20) then
					arg_112_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_21 + var_115_22 and arg_112_1.time_ < var_115_21 + var_115_22 + arg_115_0 and not isNil(var_115_20) and arg_112_1.var_.characterEffect1038ui_story then
				arg_112_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_115_24 = arg_112_1.actors_["1041ui_story"]
			local var_115_25 = 0

			if var_115_25 < arg_112_1.time_ and arg_112_1.time_ <= var_115_25 + arg_115_0 and not isNil(var_115_24) and arg_112_1.var_.characterEffect1041ui_story == nil then
				arg_112_1.var_.characterEffect1041ui_story = var_115_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_26 = 0.2

			if var_115_25 <= arg_112_1.time_ and arg_112_1.time_ < var_115_25 + var_115_26 and not isNil(var_115_24) then
				local var_115_27 = (arg_112_1.time_ - var_115_25) / var_115_26

				if arg_112_1.var_.characterEffect1041ui_story and not isNil(var_115_24) then
					local var_115_28 = Mathf.Lerp(0, 0.5, var_115_27)

					arg_112_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1041ui_story.fillRatio = var_115_28
				end
			end

			if arg_112_1.time_ >= var_115_25 + var_115_26 and arg_112_1.time_ < var_115_25 + var_115_26 + arg_115_0 and not isNil(var_115_24) and arg_112_1.var_.characterEffect1041ui_story then
				local var_115_29 = 0.5

				arg_112_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1041ui_story.fillRatio = var_115_29
			end

			local var_115_30 = 0
			local var_115_31 = 1.2

			if var_115_30 < arg_112_1.time_ and arg_112_1.time_ <= var_115_30 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_32 = arg_112_1:FormatText(StoryNameCfg[94].name)

				arg_112_1.leftNameTxt_.text = var_115_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_33 = arg_112_1:GetWordFromCfg(113072028)
				local var_115_34 = arg_112_1:FormatText(var_115_33.content)

				arg_112_1.text_.text = var_115_34

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_35 = 48
				local var_115_36 = utf8.len(var_115_34)
				local var_115_37 = var_115_35 <= 0 and var_115_31 or var_115_31 * (var_115_36 / var_115_35)

				if var_115_37 > 0 and var_115_31 < var_115_37 then
					arg_112_1.talkMaxDuration = var_115_37

					if var_115_37 + var_115_30 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_37 + var_115_30
					end
				end

				arg_112_1.text_.text = var_115_34
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072028", "story_v_out_113072.awb") ~= 0 then
					local var_115_38 = manager.audio:GetVoiceLength("story_v_out_113072", "113072028", "story_v_out_113072.awb") / 1000

					if var_115_38 + var_115_30 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_38 + var_115_30
					end

					if var_115_33.prefab_name ~= "" and arg_112_1.actors_[var_115_33.prefab_name] ~= nil then
						local var_115_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_33.prefab_name].transform, "story_v_out_113072", "113072028", "story_v_out_113072.awb")

						arg_112_1:RecordAudio("113072028", var_115_39)
						arg_112_1:RecordAudio("113072028", var_115_39)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_113072", "113072028", "story_v_out_113072.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_113072", "113072028", "story_v_out_113072.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_40 = math.max(var_115_31, arg_112_1.talkMaxDuration)

			if var_115_30 <= arg_112_1.time_ and arg_112_1.time_ < var_115_30 + var_115_40 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_30) / var_115_40

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_30 + var_115_40 and arg_112_1.time_ < var_115_30 + var_115_40 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play113072029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 113072029
		arg_116_1.duration_ = 4.17

		local var_116_0 = {
			ja = 2.466,
			ko = 3.3,
			zh = 2.2,
			en = 4.166
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
				arg_116_0:Play113072030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1038ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1038ui_story == nil then
				arg_116_1.var_.characterEffect1038ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.2

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1038ui_story and not isNil(var_119_0) then
					local var_119_4 = Mathf.Lerp(0, 0.5, var_119_3)

					arg_116_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1038ui_story.fillRatio = var_119_4
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1038ui_story then
				local var_119_5 = 0.5

				arg_116_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1038ui_story.fillRatio = var_119_5
			end

			local var_119_6 = 0

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_119_7 = 0

			if var_119_7 < arg_116_1.time_ and arg_116_1.time_ <= var_119_7 + arg_119_0 then
				arg_116_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action6_2")
			end

			local var_119_8 = arg_116_1.actors_["1041ui_story"]
			local var_119_9 = 0

			if var_119_9 < arg_116_1.time_ and arg_116_1.time_ <= var_119_9 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.characterEffect1041ui_story == nil then
				arg_116_1.var_.characterEffect1041ui_story = var_119_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_10 = 0.2

			if var_119_9 <= arg_116_1.time_ and arg_116_1.time_ < var_119_9 + var_119_10 and not isNil(var_119_8) then
				local var_119_11 = (arg_116_1.time_ - var_119_9) / var_119_10

				if arg_116_1.var_.characterEffect1041ui_story and not isNil(var_119_8) then
					arg_116_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_9 + var_119_10 and arg_116_1.time_ < var_119_9 + var_119_10 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.characterEffect1041ui_story then
				arg_116_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_119_12 = 0
			local var_119_13 = 0.275

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_14 = arg_116_1:FormatText(StoryNameCfg[208].name)

				arg_116_1.leftNameTxt_.text = var_119_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_15 = arg_116_1:GetWordFromCfg(113072029)
				local var_119_16 = arg_116_1:FormatText(var_119_15.content)

				arg_116_1.text_.text = var_119_16

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_17 = 11
				local var_119_18 = utf8.len(var_119_16)
				local var_119_19 = var_119_17 <= 0 and var_119_13 or var_119_13 * (var_119_18 / var_119_17)

				if var_119_19 > 0 and var_119_13 < var_119_19 then
					arg_116_1.talkMaxDuration = var_119_19

					if var_119_19 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_19 + var_119_12
					end
				end

				arg_116_1.text_.text = var_119_16
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072029", "story_v_out_113072.awb") ~= 0 then
					local var_119_20 = manager.audio:GetVoiceLength("story_v_out_113072", "113072029", "story_v_out_113072.awb") / 1000

					if var_119_20 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_20 + var_119_12
					end

					if var_119_15.prefab_name ~= "" and arg_116_1.actors_[var_119_15.prefab_name] ~= nil then
						local var_119_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_15.prefab_name].transform, "story_v_out_113072", "113072029", "story_v_out_113072.awb")

						arg_116_1:RecordAudio("113072029", var_119_21)
						arg_116_1:RecordAudio("113072029", var_119_21)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_113072", "113072029", "story_v_out_113072.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_113072", "113072029", "story_v_out_113072.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_22 = math.max(var_119_13, arg_116_1.talkMaxDuration)

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_22 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_12) / var_119_22

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_12 + var_119_22 and arg_116_1.time_ < var_119_12 + var_119_22 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play113072030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 113072030
		arg_120_1.duration_ = 10

		local var_120_0 = {
			ja = 7.733,
			ko = 10,
			zh = 6.266,
			en = 7.6
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
				arg_120_0:Play113072031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1041ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1041ui_story == nil then
				arg_120_1.var_.characterEffect1041ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.2

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1041ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1041ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1041ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1041ui_story.fillRatio = var_123_5
			end

			local var_123_6 = arg_120_1.actors_["1038ui_story"]
			local var_123_7 = 0

			if var_123_7 < arg_120_1.time_ and arg_120_1.time_ <= var_123_7 + arg_123_0 and not isNil(var_123_6) and arg_120_1.var_.characterEffect1038ui_story == nil then
				arg_120_1.var_.characterEffect1038ui_story = var_123_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_8 = 0.2

			if var_123_7 <= arg_120_1.time_ and arg_120_1.time_ < var_123_7 + var_123_8 and not isNil(var_123_6) then
				local var_123_9 = (arg_120_1.time_ - var_123_7) / var_123_8

				if arg_120_1.var_.characterEffect1038ui_story and not isNil(var_123_6) then
					arg_120_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_7 + var_123_8 and arg_120_1.time_ < var_123_7 + var_123_8 + arg_123_0 and not isNil(var_123_6) and arg_120_1.var_.characterEffect1038ui_story then
				arg_120_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_123_11 = 0
			local var_123_12 = 0.875

			if var_123_11 < arg_120_1.time_ and arg_120_1.time_ <= var_123_11 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_13 = arg_120_1:FormatText(StoryNameCfg[94].name)

				arg_120_1.leftNameTxt_.text = var_123_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_14 = arg_120_1:GetWordFromCfg(113072030)
				local var_123_15 = arg_120_1:FormatText(var_123_14.content)

				arg_120_1.text_.text = var_123_15

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_16 = 33
				local var_123_17 = utf8.len(var_123_15)
				local var_123_18 = var_123_16 <= 0 and var_123_12 or var_123_12 * (var_123_17 / var_123_16)

				if var_123_18 > 0 and var_123_12 < var_123_18 then
					arg_120_1.talkMaxDuration = var_123_18

					if var_123_18 + var_123_11 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_18 + var_123_11
					end
				end

				arg_120_1.text_.text = var_123_15
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072030", "story_v_out_113072.awb") ~= 0 then
					local var_123_19 = manager.audio:GetVoiceLength("story_v_out_113072", "113072030", "story_v_out_113072.awb") / 1000

					if var_123_19 + var_123_11 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_19 + var_123_11
					end

					if var_123_14.prefab_name ~= "" and arg_120_1.actors_[var_123_14.prefab_name] ~= nil then
						local var_123_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_14.prefab_name].transform, "story_v_out_113072", "113072030", "story_v_out_113072.awb")

						arg_120_1:RecordAudio("113072030", var_123_20)
						arg_120_1:RecordAudio("113072030", var_123_20)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_113072", "113072030", "story_v_out_113072.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_113072", "113072030", "story_v_out_113072.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_21 = math.max(var_123_12, arg_120_1.talkMaxDuration)

			if var_123_11 <= arg_120_1.time_ and arg_120_1.time_ < var_123_11 + var_123_21 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_11) / var_123_21

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_11 + var_123_21 and arg_120_1.time_ < var_123_11 + var_123_21 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play113072031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 113072031
		arg_124_1.duration_ = 9.4

		local var_124_0 = {
			ja = 7.766,
			ko = 9.4,
			zh = 7.533,
			en = 9.066
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play113072032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_127_2 = 0
			local var_127_3 = 0.95

			if var_127_2 < arg_124_1.time_ and arg_124_1.time_ <= var_127_2 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_4 = arg_124_1:FormatText(StoryNameCfg[94].name)

				arg_124_1.leftNameTxt_.text = var_127_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_5 = arg_124_1:GetWordFromCfg(113072031)
				local var_127_6 = arg_124_1:FormatText(var_127_5.content)

				arg_124_1.text_.text = var_127_6

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_7 = 38
				local var_127_8 = utf8.len(var_127_6)
				local var_127_9 = var_127_7 <= 0 and var_127_3 or var_127_3 * (var_127_8 / var_127_7)

				if var_127_9 > 0 and var_127_3 < var_127_9 then
					arg_124_1.talkMaxDuration = var_127_9

					if var_127_9 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_9 + var_127_2
					end
				end

				arg_124_1.text_.text = var_127_6
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072031", "story_v_out_113072.awb") ~= 0 then
					local var_127_10 = manager.audio:GetVoiceLength("story_v_out_113072", "113072031", "story_v_out_113072.awb") / 1000

					if var_127_10 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_2
					end

					if var_127_5.prefab_name ~= "" and arg_124_1.actors_[var_127_5.prefab_name] ~= nil then
						local var_127_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_5.prefab_name].transform, "story_v_out_113072", "113072031", "story_v_out_113072.awb")

						arg_124_1:RecordAudio("113072031", var_127_11)
						arg_124_1:RecordAudio("113072031", var_127_11)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_113072", "113072031", "story_v_out_113072.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_113072", "113072031", "story_v_out_113072.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_12 = math.max(var_127_3, arg_124_1.talkMaxDuration)

			if var_127_2 <= arg_124_1.time_ and arg_124_1.time_ < var_127_2 + var_127_12 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_2) / var_127_12

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_2 + var_127_12 and arg_124_1.time_ < var_127_2 + var_127_12 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play113072032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 113072032
		arg_128_1.duration_ = 5.57

		local var_128_0 = {
			ja = 4.933,
			ko = 4.6,
			zh = 4.666,
			en = 5.566
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
				arg_128_0:Play113072033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1038ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1038ui_story == nil then
				arg_128_1.var_.characterEffect1038ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.2

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1038ui_story and not isNil(var_131_0) then
					local var_131_4 = Mathf.Lerp(0, 0.5, var_131_3)

					arg_128_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1038ui_story.fillRatio = var_131_4
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1038ui_story then
				local var_131_5 = 0.5

				arg_128_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1038ui_story.fillRatio = var_131_5
			end

			local var_131_6 = 0

			if var_131_6 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_131_7 = arg_128_1.actors_["1041ui_story"]
			local var_131_8 = 0

			if var_131_8 < arg_128_1.time_ and arg_128_1.time_ <= var_131_8 + arg_131_0 and not isNil(var_131_7) and arg_128_1.var_.characterEffect1041ui_story == nil then
				arg_128_1.var_.characterEffect1041ui_story = var_131_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_9 = 0.2

			if var_131_8 <= arg_128_1.time_ and arg_128_1.time_ < var_131_8 + var_131_9 and not isNil(var_131_7) then
				local var_131_10 = (arg_128_1.time_ - var_131_8) / var_131_9

				if arg_128_1.var_.characterEffect1041ui_story and not isNil(var_131_7) then
					arg_128_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_8 + var_131_9 and arg_128_1.time_ < var_131_8 + var_131_9 + arg_131_0 and not isNil(var_131_7) and arg_128_1.var_.characterEffect1041ui_story then
				arg_128_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_131_11 = 0
			local var_131_12 = 0.65

			if var_131_11 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_13 = arg_128_1:FormatText(StoryNameCfg[208].name)

				arg_128_1.leftNameTxt_.text = var_131_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_14 = arg_128_1:GetWordFromCfg(113072032)
				local var_131_15 = arg_128_1:FormatText(var_131_14.content)

				arg_128_1.text_.text = var_131_15

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_16 = 26
				local var_131_17 = utf8.len(var_131_15)
				local var_131_18 = var_131_16 <= 0 and var_131_12 or var_131_12 * (var_131_17 / var_131_16)

				if var_131_18 > 0 and var_131_12 < var_131_18 then
					arg_128_1.talkMaxDuration = var_131_18

					if var_131_18 + var_131_11 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_18 + var_131_11
					end
				end

				arg_128_1.text_.text = var_131_15
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072032", "story_v_out_113072.awb") ~= 0 then
					local var_131_19 = manager.audio:GetVoiceLength("story_v_out_113072", "113072032", "story_v_out_113072.awb") / 1000

					if var_131_19 + var_131_11 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_19 + var_131_11
					end

					if var_131_14.prefab_name ~= "" and arg_128_1.actors_[var_131_14.prefab_name] ~= nil then
						local var_131_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_14.prefab_name].transform, "story_v_out_113072", "113072032", "story_v_out_113072.awb")

						arg_128_1:RecordAudio("113072032", var_131_20)
						arg_128_1:RecordAudio("113072032", var_131_20)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_113072", "113072032", "story_v_out_113072.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_113072", "113072032", "story_v_out_113072.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_21 = math.max(var_131_12, arg_128_1.talkMaxDuration)

			if var_131_11 <= arg_128_1.time_ and arg_128_1.time_ < var_131_11 + var_131_21 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_11) / var_131_21

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_11 + var_131_21 and arg_128_1.time_ < var_131_11 + var_131_21 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play113072033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 113072033
		arg_132_1.duration_ = 2.63

		local var_132_0 = {
			ja = 2.633,
			ko = 1.999999999999,
			zh = 2.1,
			en = 2.433
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
				arg_132_0:Play113072034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_2")
			end

			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_135_2 = arg_132_1.actors_["1038ui_story"]
			local var_135_3 = 0

			if var_135_3 < arg_132_1.time_ and arg_132_1.time_ <= var_135_3 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.characterEffect1038ui_story == nil then
				arg_132_1.var_.characterEffect1038ui_story = var_135_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_4 = 0.2

			if var_135_3 <= arg_132_1.time_ and arg_132_1.time_ < var_135_3 + var_135_4 and not isNil(var_135_2) then
				local var_135_5 = (arg_132_1.time_ - var_135_3) / var_135_4

				if arg_132_1.var_.characterEffect1038ui_story and not isNil(var_135_2) then
					arg_132_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_3 + var_135_4 and arg_132_1.time_ < var_135_3 + var_135_4 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.characterEffect1038ui_story then
				arg_132_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_135_6 = arg_132_1.actors_["1041ui_story"]
			local var_135_7 = 0

			if var_135_7 < arg_132_1.time_ and arg_132_1.time_ <= var_135_7 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect1041ui_story == nil then
				arg_132_1.var_.characterEffect1041ui_story = var_135_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_8 = 0.2

			if var_135_7 <= arg_132_1.time_ and arg_132_1.time_ < var_135_7 + var_135_8 and not isNil(var_135_6) then
				local var_135_9 = (arg_132_1.time_ - var_135_7) / var_135_8

				if arg_132_1.var_.characterEffect1041ui_story and not isNil(var_135_6) then
					local var_135_10 = Mathf.Lerp(0, 0.5, var_135_9)

					arg_132_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1041ui_story.fillRatio = var_135_10
				end
			end

			if arg_132_1.time_ >= var_135_7 + var_135_8 and arg_132_1.time_ < var_135_7 + var_135_8 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect1041ui_story then
				local var_135_11 = 0.5

				arg_132_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1041ui_story.fillRatio = var_135_11
			end

			local var_135_12 = 0
			local var_135_13 = 0.1

			if var_135_12 < arg_132_1.time_ and arg_132_1.time_ <= var_135_12 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_14 = arg_132_1:FormatText(StoryNameCfg[94].name)

				arg_132_1.leftNameTxt_.text = var_135_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_15 = arg_132_1:GetWordFromCfg(113072033)
				local var_135_16 = arg_132_1:FormatText(var_135_15.content)

				arg_132_1.text_.text = var_135_16

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_17 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072033", "story_v_out_113072.awb") ~= 0 then
					local var_135_20 = manager.audio:GetVoiceLength("story_v_out_113072", "113072033", "story_v_out_113072.awb") / 1000

					if var_135_20 + var_135_12 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_20 + var_135_12
					end

					if var_135_15.prefab_name ~= "" and arg_132_1.actors_[var_135_15.prefab_name] ~= nil then
						local var_135_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_15.prefab_name].transform, "story_v_out_113072", "113072033", "story_v_out_113072.awb")

						arg_132_1:RecordAudio("113072033", var_135_21)
						arg_132_1:RecordAudio("113072033", var_135_21)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_113072", "113072033", "story_v_out_113072.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_113072", "113072033", "story_v_out_113072.awb")
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
	Play113072034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 113072034
		arg_136_1.duration_ = 12.43

		local var_136_0 = {
			ja = 7.9,
			ko = 7.533,
			zh = 7.033,
			en = 12.433
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
				arg_136_0:Play113072035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1038ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1038ui_story == nil then
				arg_136_1.var_.characterEffect1038ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.2

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1038ui_story and not isNil(var_139_0) then
					local var_139_4 = Mathf.Lerp(0, 0.5, var_139_3)

					arg_136_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1038ui_story.fillRatio = var_139_4
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1038ui_story then
				local var_139_5 = 0.5

				arg_136_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1038ui_story.fillRatio = var_139_5
			end

			local var_139_6 = arg_136_1.actors_["1041ui_story"].transform
			local var_139_7 = 0

			if var_139_7 < arg_136_1.time_ and arg_136_1.time_ <= var_139_7 + arg_139_0 then
				arg_136_1.var_.moveOldPos1041ui_story = var_139_6.localPosition
			end

			local var_139_8 = 0.001

			if var_139_7 <= arg_136_1.time_ and arg_136_1.time_ < var_139_7 + var_139_8 then
				local var_139_9 = (arg_136_1.time_ - var_139_7) / var_139_8
				local var_139_10 = Vector3.New(0, 100, 0)

				var_139_6.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1041ui_story, var_139_10, var_139_9)

				local var_139_11 = manager.ui.mainCamera.transform.position - var_139_6.position

				var_139_6.forward = Vector3.New(var_139_11.x, var_139_11.y, var_139_11.z)

				local var_139_12 = var_139_6.localEulerAngles

				var_139_12.z = 0
				var_139_12.x = 0
				var_139_6.localEulerAngles = var_139_12
			end

			if arg_136_1.time_ >= var_139_7 + var_139_8 and arg_136_1.time_ < var_139_7 + var_139_8 + arg_139_0 then
				var_139_6.localPosition = Vector3.New(0, 100, 0)

				local var_139_13 = manager.ui.mainCamera.transform.position - var_139_6.position

				var_139_6.forward = Vector3.New(var_139_13.x, var_139_13.y, var_139_13.z)

				local var_139_14 = var_139_6.localEulerAngles

				var_139_14.z = 0
				var_139_14.x = 0
				var_139_6.localEulerAngles = var_139_14
			end

			local var_139_15 = arg_136_1.actors_["1042ui_story"].transform
			local var_139_16 = 0

			if var_139_16 < arg_136_1.time_ and arg_136_1.time_ <= var_139_16 + arg_139_0 then
				arg_136_1.var_.moveOldPos1042ui_story = var_139_15.localPosition
			end

			local var_139_17 = 0.001

			if var_139_16 <= arg_136_1.time_ and arg_136_1.time_ < var_139_16 + var_139_17 then
				local var_139_18 = (arg_136_1.time_ - var_139_16) / var_139_17
				local var_139_19 = Vector3.New(-0.7, -1.06, -6.2)

				var_139_15.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1042ui_story, var_139_19, var_139_18)

				local var_139_20 = manager.ui.mainCamera.transform.position - var_139_15.position

				var_139_15.forward = Vector3.New(var_139_20.x, var_139_20.y, var_139_20.z)

				local var_139_21 = var_139_15.localEulerAngles

				var_139_21.z = 0
				var_139_21.x = 0
				var_139_15.localEulerAngles = var_139_21
			end

			if arg_136_1.time_ >= var_139_16 + var_139_17 and arg_136_1.time_ < var_139_16 + var_139_17 + arg_139_0 then
				var_139_15.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_139_22 = manager.ui.mainCamera.transform.position - var_139_15.position

				var_139_15.forward = Vector3.New(var_139_22.x, var_139_22.y, var_139_22.z)

				local var_139_23 = var_139_15.localEulerAngles

				var_139_23.z = 0
				var_139_23.x = 0
				var_139_15.localEulerAngles = var_139_23
			end

			local var_139_24 = 0

			if var_139_24 < arg_136_1.time_ and arg_136_1.time_ <= var_139_24 + arg_139_0 then
				arg_136_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_139_25 = 0

			if var_139_25 < arg_136_1.time_ and arg_136_1.time_ <= var_139_25 + arg_139_0 then
				arg_136_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_139_26 = arg_136_1.actors_["1042ui_story"]
			local var_139_27 = 0

			if var_139_27 < arg_136_1.time_ and arg_136_1.time_ <= var_139_27 + arg_139_0 and not isNil(var_139_26) and arg_136_1.var_.characterEffect1042ui_story == nil then
				arg_136_1.var_.characterEffect1042ui_story = var_139_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_28 = 0.2

			if var_139_27 <= arg_136_1.time_ and arg_136_1.time_ < var_139_27 + var_139_28 and not isNil(var_139_26) then
				local var_139_29 = (arg_136_1.time_ - var_139_27) / var_139_28

				if arg_136_1.var_.characterEffect1042ui_story and not isNil(var_139_26) then
					arg_136_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_27 + var_139_28 and arg_136_1.time_ < var_139_27 + var_139_28 + arg_139_0 and not isNil(var_139_26) and arg_136_1.var_.characterEffect1042ui_story then
				arg_136_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_139_30 = 0
			local var_139_31 = 0.725

			if var_139_30 < arg_136_1.time_ and arg_136_1.time_ <= var_139_30 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_32 = arg_136_1:FormatText(StoryNameCfg[205].name)

				arg_136_1.leftNameTxt_.text = var_139_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_33 = arg_136_1:GetWordFromCfg(113072034)
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

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072034", "story_v_out_113072.awb") ~= 0 then
					local var_139_38 = manager.audio:GetVoiceLength("story_v_out_113072", "113072034", "story_v_out_113072.awb") / 1000

					if var_139_38 + var_139_30 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_38 + var_139_30
					end

					if var_139_33.prefab_name ~= "" and arg_136_1.actors_[var_139_33.prefab_name] ~= nil then
						local var_139_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_33.prefab_name].transform, "story_v_out_113072", "113072034", "story_v_out_113072.awb")

						arg_136_1:RecordAudio("113072034", var_139_39)
						arg_136_1:RecordAudio("113072034", var_139_39)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_113072", "113072034", "story_v_out_113072.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_113072", "113072034", "story_v_out_113072.awb")
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
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play113072035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 113072035
		arg_140_1.duration_ = 6.53

		local var_140_0 = {
			ja = 6.166,
			ko = 3,
			zh = 3.366,
			en = 6.533
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
				arg_140_0:Play113072036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1042ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos1042ui_story = var_143_0.localPosition
			end

			local var_143_2 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2
				local var_143_4 = Vector3.New(0, 100, 0)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1042ui_story, var_143_4, var_143_3)

				local var_143_5 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_5.x, var_143_5.y, var_143_5.z)

				local var_143_6 = var_143_0.localEulerAngles

				var_143_6.z = 0
				var_143_6.x = 0
				var_143_0.localEulerAngles = var_143_6
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0, 100, 0)

				local var_143_7 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_7.x, var_143_7.y, var_143_7.z)

				local var_143_8 = var_143_0.localEulerAngles

				var_143_8.z = 0
				var_143_8.x = 0
				var_143_0.localEulerAngles = var_143_8
			end

			local var_143_9 = arg_140_1.actors_["1041ui_story"].transform
			local var_143_10 = 0

			if var_143_10 < arg_140_1.time_ and arg_140_1.time_ <= var_143_10 + arg_143_0 then
				arg_140_1.var_.moveOldPos1041ui_story = var_143_9.localPosition
			end

			local var_143_11 = 0.001

			if var_143_10 <= arg_140_1.time_ and arg_140_1.time_ < var_143_10 + var_143_11 then
				local var_143_12 = (arg_140_1.time_ - var_143_10) / var_143_11
				local var_143_13 = Vector3.New(-0.7, -1.11, -5.9)

				var_143_9.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1041ui_story, var_143_13, var_143_12)

				local var_143_14 = manager.ui.mainCamera.transform.position - var_143_9.position

				var_143_9.forward = Vector3.New(var_143_14.x, var_143_14.y, var_143_14.z)

				local var_143_15 = var_143_9.localEulerAngles

				var_143_15.z = 0
				var_143_15.x = 0
				var_143_9.localEulerAngles = var_143_15
			end

			if arg_140_1.time_ >= var_143_10 + var_143_11 and arg_140_1.time_ < var_143_10 + var_143_11 + arg_143_0 then
				var_143_9.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_143_16 = manager.ui.mainCamera.transform.position - var_143_9.position

				var_143_9.forward = Vector3.New(var_143_16.x, var_143_16.y, var_143_16.z)

				local var_143_17 = var_143_9.localEulerAngles

				var_143_17.z = 0
				var_143_17.x = 0
				var_143_9.localEulerAngles = var_143_17
			end

			local var_143_18 = 0

			if var_143_18 < arg_140_1.time_ and arg_140_1.time_ <= var_143_18 + arg_143_0 then
				arg_140_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_143_19 = 0

			if var_143_19 < arg_140_1.time_ and arg_140_1.time_ <= var_143_19 + arg_143_0 then
				arg_140_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_1")
			end

			local var_143_20 = arg_140_1.actors_["1041ui_story"]
			local var_143_21 = 0

			if var_143_21 < arg_140_1.time_ and arg_140_1.time_ <= var_143_21 + arg_143_0 and not isNil(var_143_20) and arg_140_1.var_.characterEffect1041ui_story == nil then
				arg_140_1.var_.characterEffect1041ui_story = var_143_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_22 = 0.2

			if var_143_21 <= arg_140_1.time_ and arg_140_1.time_ < var_143_21 + var_143_22 and not isNil(var_143_20) then
				local var_143_23 = (arg_140_1.time_ - var_143_21) / var_143_22

				if arg_140_1.var_.characterEffect1041ui_story and not isNil(var_143_20) then
					arg_140_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_21 + var_143_22 and arg_140_1.time_ < var_143_21 + var_143_22 + arg_143_0 and not isNil(var_143_20) and arg_140_1.var_.characterEffect1041ui_story then
				arg_140_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_143_24 = 0
			local var_143_25 = 0.45

			if var_143_24 < arg_140_1.time_ and arg_140_1.time_ <= var_143_24 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_26 = arg_140_1:FormatText(StoryNameCfg[208].name)

				arg_140_1.leftNameTxt_.text = var_143_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_27 = arg_140_1:GetWordFromCfg(113072035)
				local var_143_28 = arg_140_1:FormatText(var_143_27.content)

				arg_140_1.text_.text = var_143_28

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_29 = 18
				local var_143_30 = utf8.len(var_143_28)
				local var_143_31 = var_143_29 <= 0 and var_143_25 or var_143_25 * (var_143_30 / var_143_29)

				if var_143_31 > 0 and var_143_25 < var_143_31 then
					arg_140_1.talkMaxDuration = var_143_31

					if var_143_31 + var_143_24 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_31 + var_143_24
					end
				end

				arg_140_1.text_.text = var_143_28
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072035", "story_v_out_113072.awb") ~= 0 then
					local var_143_32 = manager.audio:GetVoiceLength("story_v_out_113072", "113072035", "story_v_out_113072.awb") / 1000

					if var_143_32 + var_143_24 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_32 + var_143_24
					end

					if var_143_27.prefab_name ~= "" and arg_140_1.actors_[var_143_27.prefab_name] ~= nil then
						local var_143_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_27.prefab_name].transform, "story_v_out_113072", "113072035", "story_v_out_113072.awb")

						arg_140_1:RecordAudio("113072035", var_143_33)
						arg_140_1:RecordAudio("113072035", var_143_33)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_113072", "113072035", "story_v_out_113072.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_113072", "113072035", "story_v_out_113072.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_34 = math.max(var_143_25, arg_140_1.talkMaxDuration)

			if var_143_24 <= arg_140_1.time_ and arg_140_1.time_ < var_143_24 + var_143_34 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_24) / var_143_34

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_24 + var_143_34 and arg_140_1.time_ < var_143_24 + var_143_34 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play113072036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 113072036
		arg_144_1.duration_ = 10.13

		local var_144_0 = {
			ja = 8.366,
			ko = 10.133,
			zh = 6.633,
			en = 7.466
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
				arg_144_0:Play113072037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1041ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1041ui_story == nil then
				arg_144_1.var_.characterEffect1041ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.2

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1041ui_story and not isNil(var_147_0) then
					local var_147_4 = Mathf.Lerp(0, 0.5, var_147_3)

					arg_144_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1041ui_story.fillRatio = var_147_4
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1041ui_story then
				local var_147_5 = 0.5

				arg_144_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1041ui_story.fillRatio = var_147_5
			end

			local var_147_6 = 0

			if var_147_6 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_147_7 = 0

			if var_147_7 < arg_144_1.time_ and arg_144_1.time_ <= var_147_7 + arg_147_0 then
				arg_144_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_147_8 = arg_144_1.actors_["1038ui_story"]
			local var_147_9 = 0

			if var_147_9 < arg_144_1.time_ and arg_144_1.time_ <= var_147_9 + arg_147_0 and not isNil(var_147_8) and arg_144_1.var_.characterEffect1038ui_story == nil then
				arg_144_1.var_.characterEffect1038ui_story = var_147_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_10 = 0.2

			if var_147_9 <= arg_144_1.time_ and arg_144_1.time_ < var_147_9 + var_147_10 and not isNil(var_147_8) then
				local var_147_11 = (arg_144_1.time_ - var_147_9) / var_147_10

				if arg_144_1.var_.characterEffect1038ui_story and not isNil(var_147_8) then
					arg_144_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_9 + var_147_10 and arg_144_1.time_ < var_147_9 + var_147_10 + arg_147_0 and not isNil(var_147_8) and arg_144_1.var_.characterEffect1038ui_story then
				arg_144_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_147_12 = 0
			local var_147_13 = 0.9

			if var_147_12 < arg_144_1.time_ and arg_144_1.time_ <= var_147_12 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_14 = arg_144_1:FormatText(StoryNameCfg[94].name)

				arg_144_1.leftNameTxt_.text = var_147_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_15 = arg_144_1:GetWordFromCfg(113072036)
				local var_147_16 = arg_144_1:FormatText(var_147_15.content)

				arg_144_1.text_.text = var_147_16

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_17 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072036", "story_v_out_113072.awb") ~= 0 then
					local var_147_20 = manager.audio:GetVoiceLength("story_v_out_113072", "113072036", "story_v_out_113072.awb") / 1000

					if var_147_20 + var_147_12 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_20 + var_147_12
					end

					if var_147_15.prefab_name ~= "" and arg_144_1.actors_[var_147_15.prefab_name] ~= nil then
						local var_147_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_15.prefab_name].transform, "story_v_out_113072", "113072036", "story_v_out_113072.awb")

						arg_144_1:RecordAudio("113072036", var_147_21)
						arg_144_1:RecordAudio("113072036", var_147_21)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_113072", "113072036", "story_v_out_113072.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_113072", "113072036", "story_v_out_113072.awb")
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
	Play113072037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 113072037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play113072038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1038ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1038ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0, 100, 0)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1038ui_story, var_151_4, var_151_3)

				local var_151_5 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_5.x, var_151_5.y, var_151_5.z)

				local var_151_6 = var_151_0.localEulerAngles

				var_151_6.z = 0
				var_151_6.x = 0
				var_151_0.localEulerAngles = var_151_6
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0, 100, 0)

				local var_151_7 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_7.x, var_151_7.y, var_151_7.z)

				local var_151_8 = var_151_0.localEulerAngles

				var_151_8.z = 0
				var_151_8.x = 0
				var_151_0.localEulerAngles = var_151_8
			end

			local var_151_9 = arg_148_1.actors_["1041ui_story"].transform
			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 then
				arg_148_1.var_.moveOldPos1041ui_story = var_151_9.localPosition
			end

			local var_151_11 = 0.001

			if var_151_10 <= arg_148_1.time_ and arg_148_1.time_ < var_151_10 + var_151_11 then
				local var_151_12 = (arg_148_1.time_ - var_151_10) / var_151_11
				local var_151_13 = Vector3.New(0, 100, 0)

				var_151_9.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1041ui_story, var_151_13, var_151_12)

				local var_151_14 = manager.ui.mainCamera.transform.position - var_151_9.position

				var_151_9.forward = Vector3.New(var_151_14.x, var_151_14.y, var_151_14.z)

				local var_151_15 = var_151_9.localEulerAngles

				var_151_15.z = 0
				var_151_15.x = 0
				var_151_9.localEulerAngles = var_151_15
			end

			if arg_148_1.time_ >= var_151_10 + var_151_11 and arg_148_1.time_ < var_151_10 + var_151_11 + arg_151_0 then
				var_151_9.localPosition = Vector3.New(0, 100, 0)

				local var_151_16 = manager.ui.mainCamera.transform.position - var_151_9.position

				var_151_9.forward = Vector3.New(var_151_16.x, var_151_16.y, var_151_16.z)

				local var_151_17 = var_151_9.localEulerAngles

				var_151_17.z = 0
				var_151_17.x = 0
				var_151_9.localEulerAngles = var_151_17
			end

			local var_151_18 = 0
			local var_151_19 = 0.675

			if var_151_18 < arg_148_1.time_ and arg_148_1.time_ <= var_151_18 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_20 = arg_148_1:GetWordFromCfg(113072037)
				local var_151_21 = arg_148_1:FormatText(var_151_20.content)

				arg_148_1.text_.text = var_151_21

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_22 = 27
				local var_151_23 = utf8.len(var_151_21)
				local var_151_24 = var_151_22 <= 0 and var_151_19 or var_151_19 * (var_151_23 / var_151_22)

				if var_151_24 > 0 and var_151_19 < var_151_24 then
					arg_148_1.talkMaxDuration = var_151_24

					if var_151_24 + var_151_18 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_24 + var_151_18
					end
				end

				arg_148_1.text_.text = var_151_21
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_25 = math.max(var_151_19, arg_148_1.talkMaxDuration)

			if var_151_18 <= arg_148_1.time_ and arg_148_1.time_ < var_151_18 + var_151_25 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_18) / var_151_25

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_18 + var_151_25 and arg_148_1.time_ < var_151_18 + var_151_25 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
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
	Play113072038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 113072038
		arg_152_1.duration_ = 6.1

		local var_152_0 = {
			ja = 2.766,
			ko = 4.3,
			zh = 5.266,
			en = 6.1
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
				arg_152_0:Play113072039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1084ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos1084ui_story = var_155_0.localPosition
			end

			local var_155_2 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2
				local var_155_4 = Vector3.New(0, -0.97, -6)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1084ui_story, var_155_4, var_155_3)

				local var_155_5 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_5.x, var_155_5.y, var_155_5.z)

				local var_155_6 = var_155_0.localEulerAngles

				var_155_6.z = 0
				var_155_6.x = 0
				var_155_0.localEulerAngles = var_155_6
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_155_7 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_7.x, var_155_7.y, var_155_7.z)

				local var_155_8 = var_155_0.localEulerAngles

				var_155_8.z = 0
				var_155_8.x = 0
				var_155_0.localEulerAngles = var_155_8
			end

			local var_155_9 = 0

			if var_155_9 < arg_152_1.time_ and arg_152_1.time_ <= var_155_9 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_155_11 = arg_152_1.actors_["1084ui_story"]
			local var_155_12 = 0

			if var_155_12 < arg_152_1.time_ and arg_152_1.time_ <= var_155_12 + arg_155_0 and not isNil(var_155_11) and arg_152_1.var_.characterEffect1084ui_story == nil then
				arg_152_1.var_.characterEffect1084ui_story = var_155_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_13 = 0.2

			if var_155_12 <= arg_152_1.time_ and arg_152_1.time_ < var_155_12 + var_155_13 and not isNil(var_155_11) then
				local var_155_14 = (arg_152_1.time_ - var_155_12) / var_155_13

				if arg_152_1.var_.characterEffect1084ui_story and not isNil(var_155_11) then
					arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_12 + var_155_13 and arg_152_1.time_ < var_155_12 + var_155_13 + arg_155_0 and not isNil(var_155_11) and arg_152_1.var_.characterEffect1084ui_story then
				arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_155_15 = 0
			local var_155_16 = 0.5

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_17 = arg_152_1:FormatText(StoryNameCfg[6].name)

				arg_152_1.leftNameTxt_.text = var_155_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_18 = arg_152_1:GetWordFromCfg(113072038)
				local var_155_19 = arg_152_1:FormatText(var_155_18.content)

				arg_152_1.text_.text = var_155_19

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_20 = 20
				local var_155_21 = utf8.len(var_155_19)
				local var_155_22 = var_155_20 <= 0 and var_155_16 or var_155_16 * (var_155_21 / var_155_20)

				if var_155_22 > 0 and var_155_16 < var_155_22 then
					arg_152_1.talkMaxDuration = var_155_22

					if var_155_22 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_22 + var_155_15
					end
				end

				arg_152_1.text_.text = var_155_19
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072038", "story_v_out_113072.awb") ~= 0 then
					local var_155_23 = manager.audio:GetVoiceLength("story_v_out_113072", "113072038", "story_v_out_113072.awb") / 1000

					if var_155_23 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_23 + var_155_15
					end

					if var_155_18.prefab_name ~= "" and arg_152_1.actors_[var_155_18.prefab_name] ~= nil then
						local var_155_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_18.prefab_name].transform, "story_v_out_113072", "113072038", "story_v_out_113072.awb")

						arg_152_1:RecordAudio("113072038", var_155_24)
						arg_152_1:RecordAudio("113072038", var_155_24)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_113072", "113072038", "story_v_out_113072.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_113072", "113072038", "story_v_out_113072.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_25 = math.max(var_155_16, arg_152_1.talkMaxDuration)

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_25 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_15) / var_155_25

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_15 + var_155_25 and arg_152_1.time_ < var_155_15 + var_155_25 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play113072039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 113072039
		arg_156_1.duration_ = 0.2

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"

			SetActive(arg_156_1.choicesGo_, true)

			for iter_157_0, iter_157_1 in ipairs(arg_156_1.choices_) do
				local var_157_0 = iter_157_0 <= 2

				SetActive(iter_157_1.go, var_157_0)
			end

			arg_156_1.choices_[1].txt.text = arg_156_1:FormatText(StoryChoiceCfg[191].name)
			arg_156_1.choices_[2].txt.text = arg_156_1:FormatText(StoryChoiceCfg[192].name)
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play113072040(arg_156_1)
			end

			if arg_158_0 == 2 then
				arg_156_0:Play113072041(arg_156_1)
			end

			arg_156_1:RecordChoiceLog(113072039, 191, 192)
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1084ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1084ui_story == nil then
				arg_156_1.var_.characterEffect1084ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.2

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1084ui_story and not isNil(var_159_0) then
					local var_159_4 = Mathf.Lerp(0, 0.5, var_159_3)

					arg_156_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1084ui_story.fillRatio = var_159_4
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1084ui_story then
				local var_159_5 = 0.5

				arg_156_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1084ui_story.fillRatio = var_159_5
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play113072040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 113072040
		arg_160_1.duration_ = 7.57

		local var_160_0 = {
			ja = 7.566,
			ko = 4.433,
			zh = 3.766,
			en = 4.233
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
				arg_160_0:Play113072042(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4136")
			end

			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_163_2 = arg_160_1.actors_["1084ui_story"]
			local var_163_3 = 0

			if var_163_3 < arg_160_1.time_ and arg_160_1.time_ <= var_163_3 + arg_163_0 and not isNil(var_163_2) and arg_160_1.var_.characterEffect1084ui_story == nil then
				arg_160_1.var_.characterEffect1084ui_story = var_163_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_4 = 0.2

			if var_163_3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_3 + var_163_4 and not isNil(var_163_2) then
				local var_163_5 = (arg_160_1.time_ - var_163_3) / var_163_4

				if arg_160_1.var_.characterEffect1084ui_story and not isNil(var_163_2) then
					arg_160_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_3 + var_163_4 and arg_160_1.time_ < var_163_3 + var_163_4 + arg_163_0 and not isNil(var_163_2) and arg_160_1.var_.characterEffect1084ui_story then
				arg_160_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_163_6 = 0
			local var_163_7 = 0.425

			if var_163_6 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_8 = arg_160_1:FormatText(StoryNameCfg[6].name)

				arg_160_1.leftNameTxt_.text = var_163_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_9 = arg_160_1:GetWordFromCfg(113072040)
				local var_163_10 = arg_160_1:FormatText(var_163_9.content)

				arg_160_1.text_.text = var_163_10

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 17
				local var_163_12 = utf8.len(var_163_10)
				local var_163_13 = var_163_11 <= 0 and var_163_7 or var_163_7 * (var_163_12 / var_163_11)

				if var_163_13 > 0 and var_163_7 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_10
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072040", "story_v_out_113072.awb") ~= 0 then
					local var_163_14 = manager.audio:GetVoiceLength("story_v_out_113072", "113072040", "story_v_out_113072.awb") / 1000

					if var_163_14 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_14 + var_163_6
					end

					if var_163_9.prefab_name ~= "" and arg_160_1.actors_[var_163_9.prefab_name] ~= nil then
						local var_163_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_9.prefab_name].transform, "story_v_out_113072", "113072040", "story_v_out_113072.awb")

						arg_160_1:RecordAudio("113072040", var_163_15)
						arg_160_1:RecordAudio("113072040", var_163_15)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_113072", "113072040", "story_v_out_113072.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_113072", "113072040", "story_v_out_113072.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_16 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_16 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_16

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_16 and arg_160_1.time_ < var_163_6 + var_163_16 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play113072042 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 113072042
		arg_164_1.duration_ = 7.6

		local var_164_0 = {
			ja = 6.2,
			ko = 7.3,
			zh = 5.666,
			en = 7.6
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
			arg_164_1.auto_ = false
		end

		function arg_164_1.playNext_(arg_166_0)
			arg_164_1.onStoryFinished_()
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1084ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos1084ui_story = var_167_0.localPosition
			end

			local var_167_2 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2
				local var_167_4 = Vector3.New(0, 100, 0)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1084ui_story, var_167_4, var_167_3)

				local var_167_5 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_5.x, var_167_5.y, var_167_5.z)

				local var_167_6 = var_167_0.localEulerAngles

				var_167_6.z = 0
				var_167_6.x = 0
				var_167_0.localEulerAngles = var_167_6
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(0, 100, 0)

				local var_167_7 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_7.x, var_167_7.y, var_167_7.z)

				local var_167_8 = var_167_0.localEulerAngles

				var_167_8.z = 0
				var_167_8.x = 0
				var_167_0.localEulerAngles = var_167_8
			end

			local var_167_9 = arg_164_1.actors_["1041ui_story"].transform
			local var_167_10 = 0

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 then
				arg_164_1.var_.moveOldPos1041ui_story = var_167_9.localPosition
			end

			local var_167_11 = 0.001

			if var_167_10 <= arg_164_1.time_ and arg_164_1.time_ < var_167_10 + var_167_11 then
				local var_167_12 = (arg_164_1.time_ - var_167_10) / var_167_11
				local var_167_13 = Vector3.New(0, -1.11, -5.9)

				var_167_9.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1041ui_story, var_167_13, var_167_12)

				local var_167_14 = manager.ui.mainCamera.transform.position - var_167_9.position

				var_167_9.forward = Vector3.New(var_167_14.x, var_167_14.y, var_167_14.z)

				local var_167_15 = var_167_9.localEulerAngles

				var_167_15.z = 0
				var_167_15.x = 0
				var_167_9.localEulerAngles = var_167_15
			end

			if arg_164_1.time_ >= var_167_10 + var_167_11 and arg_164_1.time_ < var_167_10 + var_167_11 + arg_167_0 then
				var_167_9.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_167_16 = manager.ui.mainCamera.transform.position - var_167_9.position

				var_167_9.forward = Vector3.New(var_167_16.x, var_167_16.y, var_167_16.z)

				local var_167_17 = var_167_9.localEulerAngles

				var_167_17.z = 0
				var_167_17.x = 0
				var_167_9.localEulerAngles = var_167_17
			end

			local var_167_18 = 0

			if var_167_18 < arg_164_1.time_ and arg_164_1.time_ <= var_167_18 + arg_167_0 then
				arg_164_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_167_19 = 0

			if var_167_19 < arg_164_1.time_ and arg_164_1.time_ <= var_167_19 + arg_167_0 then
				arg_164_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_167_20 = arg_164_1.actors_["1041ui_story"]
			local var_167_21 = 0

			if var_167_21 < arg_164_1.time_ and arg_164_1.time_ <= var_167_21 + arg_167_0 and not isNil(var_167_20) and arg_164_1.var_.characterEffect1041ui_story == nil then
				arg_164_1.var_.characterEffect1041ui_story = var_167_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_22 = 0.2

			if var_167_21 <= arg_164_1.time_ and arg_164_1.time_ < var_167_21 + var_167_22 and not isNil(var_167_20) then
				local var_167_23 = (arg_164_1.time_ - var_167_21) / var_167_22

				if arg_164_1.var_.characterEffect1041ui_story and not isNil(var_167_20) then
					arg_164_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_21 + var_167_22 and arg_164_1.time_ < var_167_21 + var_167_22 + arg_167_0 and not isNil(var_167_20) and arg_164_1.var_.characterEffect1041ui_story then
				arg_164_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_167_24 = 0
			local var_167_25 = 0.6

			if var_167_24 < arg_164_1.time_ and arg_164_1.time_ <= var_167_24 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_26 = arg_164_1:FormatText(StoryNameCfg[208].name)

				arg_164_1.leftNameTxt_.text = var_167_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_27 = arg_164_1:GetWordFromCfg(113072042)
				local var_167_28 = arg_164_1:FormatText(var_167_27.content)

				arg_164_1.text_.text = var_167_28

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_29 = 24
				local var_167_30 = utf8.len(var_167_28)
				local var_167_31 = var_167_29 <= 0 and var_167_25 or var_167_25 * (var_167_30 / var_167_29)

				if var_167_31 > 0 and var_167_25 < var_167_31 then
					arg_164_1.talkMaxDuration = var_167_31

					if var_167_31 + var_167_24 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_31 + var_167_24
					end
				end

				arg_164_1.text_.text = var_167_28
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072042", "story_v_out_113072.awb") ~= 0 then
					local var_167_32 = manager.audio:GetVoiceLength("story_v_out_113072", "113072042", "story_v_out_113072.awb") / 1000

					if var_167_32 + var_167_24 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_32 + var_167_24
					end

					if var_167_27.prefab_name ~= "" and arg_164_1.actors_[var_167_27.prefab_name] ~= nil then
						local var_167_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_27.prefab_name].transform, "story_v_out_113072", "113072042", "story_v_out_113072.awb")

						arg_164_1:RecordAudio("113072042", var_167_33)
						arg_164_1:RecordAudio("113072042", var_167_33)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_113072", "113072042", "story_v_out_113072.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_113072", "113072042", "story_v_out_113072.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_34 = math.max(var_167_25, arg_164_1.talkMaxDuration)

			if var_167_24 <= arg_164_1.time_ and arg_164_1.time_ < var_167_24 + var_167_34 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_24) / var_167_34

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_24 + var_167_34 and arg_164_1.time_ < var_167_24 + var_167_34 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play113072041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 113072041
		arg_168_1.duration_ = 2.9

		local var_168_0 = {
			ja = 2.433,
			ko = 2.166,
			zh = 2.333,
			en = 2.9
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
				arg_168_0:Play113072042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = "1084ui_story"

			if arg_168_1.actors_[var_171_0] == nil then
				local var_171_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_171_1) then
					local var_171_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_168_1.stage_.transform)

					var_171_2.name = var_171_0
					var_171_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_168_1.actors_[var_171_0] = var_171_2

					local var_171_3 = var_171_2:GetComponentInChildren(typeof(CharacterEffect))

					var_171_3.enabled = true

					local var_171_4 = GameObjectTools.GetOrAddComponent(var_171_2, typeof(DynamicBoneHelper))

					if var_171_4 then
						var_171_4:EnableDynamicBone(false)
					end

					arg_168_1:ShowWeapon(var_171_3.transform, false)

					arg_168_1.var_[var_171_0 .. "Animator"] = var_171_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_168_1.var_[var_171_0 .. "Animator"].applyRootMotion = true
					arg_168_1.var_[var_171_0 .. "LipSync"] = var_171_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_171_5 = 0

			if var_171_5 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action41312")
			end

			local var_171_6 = "1084ui_story"

			if arg_168_1.actors_[var_171_6] == nil then
				local var_171_7 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_171_7) then
					local var_171_8 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_168_1.stage_.transform)

					var_171_8.name = var_171_6
					var_171_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_168_1.actors_[var_171_6] = var_171_8

					local var_171_9 = var_171_8:GetComponentInChildren(typeof(CharacterEffect))

					var_171_9.enabled = true

					local var_171_10 = GameObjectTools.GetOrAddComponent(var_171_8, typeof(DynamicBoneHelper))

					if var_171_10 then
						var_171_10:EnableDynamicBone(false)
					end

					arg_168_1:ShowWeapon(var_171_9.transform, false)

					arg_168_1.var_[var_171_6 .. "Animator"] = var_171_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_168_1.var_[var_171_6 .. "Animator"].applyRootMotion = true
					arg_168_1.var_[var_171_6 .. "LipSync"] = var_171_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_171_11 = 0

			if var_171_11 < arg_168_1.time_ and arg_168_1.time_ <= var_171_11 + arg_171_0 then
				arg_168_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_171_12 = arg_168_1.actors_["1084ui_story"]
			local var_171_13 = 0

			if var_171_13 < arg_168_1.time_ and arg_168_1.time_ <= var_171_13 + arg_171_0 and not isNil(var_171_12) and arg_168_1.var_.characterEffect1084ui_story == nil then
				arg_168_1.var_.characterEffect1084ui_story = var_171_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_14 = 0.2

			if var_171_13 <= arg_168_1.time_ and arg_168_1.time_ < var_171_13 + var_171_14 and not isNil(var_171_12) then
				local var_171_15 = (arg_168_1.time_ - var_171_13) / var_171_14

				if arg_168_1.var_.characterEffect1084ui_story and not isNil(var_171_12) then
					arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_13 + var_171_14 and arg_168_1.time_ < var_171_13 + var_171_14 + arg_171_0 and not isNil(var_171_12) and arg_168_1.var_.characterEffect1084ui_story then
				arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_171_16 = 0
			local var_171_17 = 0.15

			if var_171_16 < arg_168_1.time_ and arg_168_1.time_ <= var_171_16 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_18 = arg_168_1:FormatText(StoryNameCfg[6].name)

				arg_168_1.leftNameTxt_.text = var_171_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_19 = arg_168_1:GetWordFromCfg(113072041)
				local var_171_20 = arg_168_1:FormatText(var_171_19.content)

				arg_168_1.text_.text = var_171_20

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_21 = 6
				local var_171_22 = utf8.len(var_171_20)
				local var_171_23 = var_171_21 <= 0 and var_171_17 or var_171_17 * (var_171_22 / var_171_21)

				if var_171_23 > 0 and var_171_17 < var_171_23 then
					arg_168_1.talkMaxDuration = var_171_23

					if var_171_23 + var_171_16 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_23 + var_171_16
					end
				end

				arg_168_1.text_.text = var_171_20
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072041", "story_v_out_113072.awb") ~= 0 then
					local var_171_24 = manager.audio:GetVoiceLength("story_v_out_113072", "113072041", "story_v_out_113072.awb") / 1000

					if var_171_24 + var_171_16 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_24 + var_171_16
					end

					if var_171_19.prefab_name ~= "" and arg_168_1.actors_[var_171_19.prefab_name] ~= nil then
						local var_171_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_19.prefab_name].transform, "story_v_out_113072", "113072041", "story_v_out_113072.awb")

						arg_168_1:RecordAudio("113072041", var_171_25)
						arg_168_1:RecordAudio("113072041", var_171_25)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_113072", "113072041", "story_v_out_113072.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_113072", "113072041", "story_v_out_113072.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_26 = math.max(var_171_17, arg_168_1.talkMaxDuration)

			if var_171_16 <= arg_168_1.time_ and arg_168_1.time_ < var_171_16 + var_171_26 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_16) / var_171_26

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_16 + var_171_26 and arg_168_1.time_ < var_171_16 + var_171_26 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F02_1"
	},
	voices = {
		"story_v_out_113072.awb"
	}
}
