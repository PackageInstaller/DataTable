return {
	Play111222001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111222001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111222002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "A07a"

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
				local var_4_5 = arg_1_1.bgs_.A07a

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
					if iter_4_0 ~= "A07a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.A07a
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueA07a = var_4_18.color.a
					arg_1_1.var_.alphaMatValueA07a = var_4_18
				end

				arg_1_1.var_.alphaOldValueA07a = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueA07a, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueA07a then
					local var_4_22 = arg_1_1.var_.alphaMatValueA07a.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueA07a.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueA07a then
				local var_4_23 = arg_1_1.var_.alphaMatValueA07a
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = manager.ui.mainCamera.transform
			local var_4_26 = 1.2

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_25.localPosition
			end

			local var_4_27 = 0.6

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				local var_4_28 = (arg_1_1.time_ - var_4_26) / 0.066
				local var_4_29, var_4_30 = math.modf(var_4_28)

				var_4_25.localPosition = Vector3.New(var_4_30 * 0.13, var_4_30 * 0.13, var_4_30 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				var_4_25.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_31 = 0

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_32 = 2

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_33 = 2
			local var_4_34 = 1

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "music"

				arg_1_1:AudioAction(var_4_35, var_4_36, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_37 = ""
				local var_4_38 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_38 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_38 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_38

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_38
						arg_1_1.bgmTxt2_.text = var_4_38
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

			local var_4_39 = 2
			local var_4_40 = 0.9

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_41 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_41:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_42 = arg_1_1:GetWordFromCfg(111222001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 36
				local var_4_45 = utf8.len(var_4_43)
				local var_4_46 = var_4_44 <= 0 and var_4_40 or var_4_40 * (var_4_45 / var_4_44)

				if var_4_46 > 0 and var_4_40 < var_4_46 then
					arg_1_1.talkMaxDuration = var_4_46
					var_4_39 = var_4_39 + 0.3

					if var_4_46 + var_4_39 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_39
					end
				end

				arg_1_1.text_.text = var_4_43
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_39 + 0.3
			local var_4_48 = math.max(var_4_40, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play111222002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111222002
		arg_8_1.duration_ = 4.1

		local var_8_0 = {
			ja = 3.9,
			ko = 4.1,
			zh = 3.366,
			en = 3.666
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
				arg_8_0:Play111222003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1096ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1096ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1096ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1096ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1096ui_story == nil then
				arg_8_1.var_.characterEffect1096ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.2

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1096ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1096ui_story then
				arg_8_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_11_9 = 0

			if var_11_9 < arg_8_1.time_ and arg_8_1.time_ <= var_11_9 + arg_11_0 then
				arg_8_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action1_1")
			end

			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_11_11 = arg_8_1.actors_["1096ui_story"].transform
			local var_11_12 = 0

			if var_11_12 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 then
				arg_8_1.var_.moveOldPos1096ui_story = var_11_11.localPosition
			end

			local var_11_13 = 0.001

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_13 then
				local var_11_14 = (arg_8_1.time_ - var_11_12) / var_11_13
				local var_11_15 = Vector3.New(0, -1.13, -5.6)

				var_11_11.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1096ui_story, var_11_15, var_11_14)

				local var_11_16 = manager.ui.mainCamera.transform.position - var_11_11.position

				var_11_11.forward = Vector3.New(var_11_16.x, var_11_16.y, var_11_16.z)

				local var_11_17 = var_11_11.localEulerAngles

				var_11_17.z = 0
				var_11_17.x = 0
				var_11_11.localEulerAngles = var_11_17
			end

			if arg_8_1.time_ >= var_11_12 + var_11_13 and arg_8_1.time_ < var_11_12 + var_11_13 + arg_11_0 then
				var_11_11.localPosition = Vector3.New(0, -1.13, -5.6)

				local var_11_18 = manager.ui.mainCamera.transform.position - var_11_11.position

				var_11_11.forward = Vector3.New(var_11_18.x, var_11_18.y, var_11_18.z)

				local var_11_19 = var_11_11.localEulerAngles

				var_11_19.z = 0
				var_11_19.x = 0
				var_11_11.localEulerAngles = var_11_19
			end

			local var_11_20 = 0
			local var_11_21 = 0.425

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_22 = arg_8_1:FormatText(StoryNameCfg[169].name)

				arg_8_1.leftNameTxt_.text = var_11_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_23 = arg_8_1:GetWordFromCfg(111222002)
				local var_11_24 = arg_8_1:FormatText(var_11_23.content)

				arg_8_1.text_.text = var_11_24

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_25 = 17
				local var_11_26 = utf8.len(var_11_24)
				local var_11_27 = var_11_25 <= 0 and var_11_21 or var_11_21 * (var_11_26 / var_11_25)

				if var_11_27 > 0 and var_11_21 < var_11_27 then
					arg_8_1.talkMaxDuration = var_11_27

					if var_11_27 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_27 + var_11_20
					end
				end

				arg_8_1.text_.text = var_11_24
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222002", "story_v_out_111222.awb") ~= 0 then
					local var_11_28 = manager.audio:GetVoiceLength("story_v_out_111222", "111222002", "story_v_out_111222.awb") / 1000

					if var_11_28 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_20
					end

					if var_11_23.prefab_name ~= "" and arg_8_1.actors_[var_11_23.prefab_name] ~= nil then
						local var_11_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_23.prefab_name].transform, "story_v_out_111222", "111222002", "story_v_out_111222.awb")

						arg_8_1:RecordAudio("111222002", var_11_29)
						arg_8_1:RecordAudio("111222002", var_11_29)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_111222", "111222002", "story_v_out_111222.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_111222", "111222002", "story_v_out_111222.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_30 = math.max(var_11_21, arg_8_1.talkMaxDuration)

			if var_11_20 <= arg_8_1.time_ and arg_8_1.time_ < var_11_20 + var_11_30 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_20) / var_11_30

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_20 + var_11_30 and arg_8_1.time_ < var_11_20 + var_11_30 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
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
	Play111222003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111222003
		arg_12_1.duration_ = 9.4

		local var_12_0 = {
			ja = 4.6,
			ko = 9.4,
			zh = 6.966,
			en = 6.4
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
				arg_12_0:Play111222004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1096ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1096ui_story == nil then
				arg_12_1.var_.characterEffect1096ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.2

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1096ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1096ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1096ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1096ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 1.05

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[32].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_9 = arg_12_1:GetWordFromCfg(111222003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 38
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_7 or var_15_7 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_7 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222003", "story_v_out_111222.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_111222", "111222003", "story_v_out_111222.awb") / 1000

					if var_15_14 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_6
					end

					if var_15_9.prefab_name ~= "" and arg_12_1.actors_[var_15_9.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_9.prefab_name].transform, "story_v_out_111222", "111222003", "story_v_out_111222.awb")

						arg_12_1:RecordAudio("111222003", var_15_15)
						arg_12_1:RecordAudio("111222003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_111222", "111222003", "story_v_out_111222.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_111222", "111222003", "story_v_out_111222.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_16 and arg_12_1.time_ < var_15_6 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play111222004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111222004
		arg_16_1.duration_ = 11

		local var_16_0 = {
			ja = 8.133,
			ko = 11,
			zh = 8.3,
			en = 8.066
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
				arg_16_0:Play111222005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.125

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[32].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(111222004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 45
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222004", "story_v_out_111222.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_111222", "111222004", "story_v_out_111222.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_111222", "111222004", "story_v_out_111222.awb")

						arg_16_1:RecordAudio("111222004", var_19_9)
						arg_16_1:RecordAudio("111222004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_111222", "111222004", "story_v_out_111222.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_111222", "111222004", "story_v_out_111222.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_10 and arg_16_1.time_ < var_19_0 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play111222005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 111222005
		arg_20_1.duration_ = 5.17

		local var_20_0 = {
			ja = 4.833,
			ko = 5.166,
			zh = 4.333,
			en = 3.566
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
				arg_20_0:Play111222006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1096ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1096ui_story == nil then
				arg_20_1.var_.characterEffect1096ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.2

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1096ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1096ui_story then
				arg_20_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_23_4 = 0

			if var_23_4 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action4_1")
			end

			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_23_6 = 0
			local var_23_7 = 0.65

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[32].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_9 = arg_20_1:GetWordFromCfg(111222005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 22
				local var_23_12 = utf8.len(var_23_10)
				local var_23_13 = var_23_11 <= 0 and var_23_7 or var_23_7 * (var_23_12 / var_23_11)

				if var_23_13 > 0 and var_23_7 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222005", "story_v_out_111222.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_111222", "111222005", "story_v_out_111222.awb") / 1000

					if var_23_14 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_6
					end

					if var_23_9.prefab_name ~= "" and arg_20_1.actors_[var_23_9.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_9.prefab_name].transform, "story_v_out_111222", "111222005", "story_v_out_111222.awb")

						arg_20_1:RecordAudio("111222005", var_23_15)
						arg_20_1:RecordAudio("111222005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_111222", "111222005", "story_v_out_111222.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_111222", "111222005", "story_v_out_111222.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_16 and arg_20_1.time_ < var_23_6 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play111222006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 111222006
		arg_24_1.duration_ = 2.7

		local var_24_0 = {
			ja = 2.2,
			ko = 2.333,
			zh = 1.999999999999,
			en = 2.7
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
				arg_24_0:Play111222007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_27_1 = 0
			local var_27_2 = 0.275

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_3 = arg_24_1:FormatText(StoryNameCfg[169].name)

				arg_24_1.leftNameTxt_.text = var_27_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:GetWordFromCfg(111222006)
				local var_27_5 = arg_24_1:FormatText(var_27_4.content)

				arg_24_1.text_.text = var_27_5

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 11
				local var_27_7 = utf8.len(var_27_5)
				local var_27_8 = var_27_6 <= 0 and var_27_2 or var_27_2 * (var_27_7 / var_27_6)

				if var_27_8 > 0 and var_27_2 < var_27_8 then
					arg_24_1.talkMaxDuration = var_27_8

					if var_27_8 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_5
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222006", "story_v_out_111222.awb") ~= 0 then
					local var_27_9 = manager.audio:GetVoiceLength("story_v_out_111222", "111222006", "story_v_out_111222.awb") / 1000

					if var_27_9 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_1
					end

					if var_27_4.prefab_name ~= "" and arg_24_1.actors_[var_27_4.prefab_name] ~= nil then
						local var_27_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_4.prefab_name].transform, "story_v_out_111222", "111222006", "story_v_out_111222.awb")

						arg_24_1:RecordAudio("111222006", var_27_10)
						arg_24_1:RecordAudio("111222006", var_27_10)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_111222", "111222006", "story_v_out_111222.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_111222", "111222006", "story_v_out_111222.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_11 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_11 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_11

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_11 and arg_24_1.time_ < var_27_1 + var_27_11 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play111222007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 111222007
		arg_28_1.duration_ = 5.73

		local var_28_0 = {
			ja = 3.4,
			ko = 5.733,
			zh = 4.4,
			en = 4.533
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
				arg_28_0:Play111222008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1096ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1096ui_story == nil then
				arg_28_1.var_.characterEffect1096ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.2

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1096ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1096ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1096ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1096ui_story.fillRatio = var_31_5
			end

			local var_31_6 = 0
			local var_31_7 = 0.6

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[32].name)

				arg_28_1.leftNameTxt_.text = var_31_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_9 = arg_28_1:GetWordFromCfg(111222007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222007", "story_v_out_111222.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_111222", "111222007", "story_v_out_111222.awb") / 1000

					if var_31_14 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_6
					end

					if var_31_9.prefab_name ~= "" and arg_28_1.actors_[var_31_9.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_9.prefab_name].transform, "story_v_out_111222", "111222007", "story_v_out_111222.awb")

						arg_28_1:RecordAudio("111222007", var_31_15)
						arg_28_1:RecordAudio("111222007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_111222", "111222007", "story_v_out_111222.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_111222", "111222007", "story_v_out_111222.awb")
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
	Play111222008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 111222008
		arg_32_1.duration_ = 10.33

		local var_32_0 = {
			ja = 10.333,
			ko = 9.866,
			zh = 8.7,
			en = 8.533
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
				arg_32_0:Play111222009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 1.25

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[32].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(111222008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 50
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222008", "story_v_out_111222.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_111222", "111222008", "story_v_out_111222.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_111222", "111222008", "story_v_out_111222.awb")

						arg_32_1:RecordAudio("111222008", var_35_9)
						arg_32_1:RecordAudio("111222008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_111222", "111222008", "story_v_out_111222.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_111222", "111222008", "story_v_out_111222.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play111222009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 111222009
		arg_36_1.duration_ = 12.4

		local var_36_0 = {
			ja = 12.4,
			ko = 11.266,
			zh = 9,
			en = 9.333
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
				arg_36_0:Play111222010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 1.2

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[32].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(111222009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 48
				local var_39_6 = utf8.len(var_39_4)
				local var_39_7 = var_39_5 <= 0 and var_39_1 or var_39_1 * (var_39_6 / var_39_5)

				if var_39_7 > 0 and var_39_1 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222009", "story_v_out_111222.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_111222", "111222009", "story_v_out_111222.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_111222", "111222009", "story_v_out_111222.awb")

						arg_36_1:RecordAudio("111222009", var_39_9)
						arg_36_1:RecordAudio("111222009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_111222", "111222009", "story_v_out_111222.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_111222", "111222009", "story_v_out_111222.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_10 and arg_36_1.time_ < var_39_0 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play111222010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 111222010
		arg_40_1.duration_ = 4.13

		local var_40_0 = {
			ja = 3.633,
			ko = 2.1,
			zh = 2.933,
			en = 4.133
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
				arg_40_0:Play111222011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1096ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1096ui_story == nil then
				arg_40_1.var_.characterEffect1096ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1096ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1096ui_story then
				arg_40_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_43_4 = 0

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action446")
			end

			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_43_6 = 0
			local var_43_7 = 1

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				local var_43_8 = "play"
				local var_43_9 = "music"

				arg_40_1:AudioAction(var_43_8, var_43_9, "ui_battle", "ui_battle_stopbgm", "")

				local var_43_10 = ""
				local var_43_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_43_11 ~= "" then
					if arg_40_1.bgmTxt_.text ~= var_43_11 and arg_40_1.bgmTxt_.text ~= "" then
						if arg_40_1.bgmTxt2_.text ~= "" then
							arg_40_1.bgmTxt_.text = arg_40_1.bgmTxt2_.text
						end

						arg_40_1.bgmTxt2_.text = var_43_11

						arg_40_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_40_1.bgmTxt_.text = var_43_11
						arg_40_1.bgmTxt2_.text = var_43_11
					end

					if arg_40_1.bgmTimer then
						arg_40_1.bgmTimer:Stop()

						arg_40_1.bgmTimer = nil
					end

					if arg_40_1.settingData.show_music_name == 1 then
						arg_40_1.musicController:SetSelectedState("show")
						arg_40_1.musicAnimator_:Play("open", 0, 0)

						if arg_40_1.settingData.music_time ~= 0 then
							arg_40_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_40_1.settingData.music_time), function()
								if arg_40_1 == nil or isNil(arg_40_1.bgmTxt_) then
									return
								end

								arg_40_1.musicController:SetSelectedState("hide")
								arg_40_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_43_12 = 0
			local var_43_13 = 0.4

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_14 = arg_40_1:FormatText(StoryNameCfg[169].name)

				arg_40_1.leftNameTxt_.text = var_43_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_15 = arg_40_1:GetWordFromCfg(111222010)
				local var_43_16 = arg_40_1:FormatText(var_43_15.content)

				arg_40_1.text_.text = var_43_16

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222010", "story_v_out_111222.awb") ~= 0 then
					local var_43_20 = manager.audio:GetVoiceLength("story_v_out_111222", "111222010", "story_v_out_111222.awb") / 1000

					if var_43_20 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_20 + var_43_12
					end

					if var_43_15.prefab_name ~= "" and arg_40_1.actors_[var_43_15.prefab_name] ~= nil then
						local var_43_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_15.prefab_name].transform, "story_v_out_111222", "111222010", "story_v_out_111222.awb")

						arg_40_1:RecordAudio("111222010", var_43_21)
						arg_40_1:RecordAudio("111222010", var_43_21)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_111222", "111222010", "story_v_out_111222.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_111222", "111222010", "story_v_out_111222.awb")
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
	Play111222011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 111222011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play111222012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1096ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1096ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, 100, 0)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1096ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, 100, 0)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = 0
			local var_48_10 = 1.1

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_11 = arg_45_1:GetWordFromCfg(111222011)
				local var_48_12 = arg_45_1:FormatText(var_48_11.content)

				arg_45_1.text_.text = var_48_12

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 44
				local var_48_14 = utf8.len(var_48_12)
				local var_48_15 = var_48_13 <= 0 and var_48_10 or var_48_10 * (var_48_14 / var_48_13)

				if var_48_15 > 0 and var_48_10 < var_48_15 then
					arg_45_1.talkMaxDuration = var_48_15

					if var_48_15 + var_48_9 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_9
					end
				end

				arg_45_1.text_.text = var_48_12
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_10, arg_45_1.talkMaxDuration)

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_9) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_9 + var_48_16 and arg_45_1.time_ < var_48_9 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play111222012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 111222012
		arg_49_1.duration_ = 3.93

		local var_49_0 = {
			ja = 3.9,
			ko = 3.766,
			zh = 3.8,
			en = 3.933
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
				arg_49_0:Play111222013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1096ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1096ui_story == nil then
				arg_49_1.var_.characterEffect1096ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1096ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1096ui_story then
				arg_49_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_52_4 = 0

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_52_5 = arg_49_1.actors_["1096ui_story"].transform
			local var_52_6 = 0

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.var_.moveOldPos1096ui_story = var_52_5.localPosition
			end

			local var_52_7 = 0.001

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_7 then
				local var_52_8 = (arg_49_1.time_ - var_52_6) / var_52_7
				local var_52_9 = Vector3.New(0, -1.13, -5.6)

				var_52_5.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1096ui_story, var_52_9, var_52_8)

				local var_52_10 = manager.ui.mainCamera.transform.position - var_52_5.position

				var_52_5.forward = Vector3.New(var_52_10.x, var_52_10.y, var_52_10.z)

				local var_52_11 = var_52_5.localEulerAngles

				var_52_11.z = 0
				var_52_11.x = 0
				var_52_5.localEulerAngles = var_52_11
			end

			if arg_49_1.time_ >= var_52_6 + var_52_7 and arg_49_1.time_ < var_52_6 + var_52_7 + arg_52_0 then
				var_52_5.localPosition = Vector3.New(0, -1.13, -5.6)

				local var_52_12 = manager.ui.mainCamera.transform.position - var_52_5.position

				var_52_5.forward = Vector3.New(var_52_12.x, var_52_12.y, var_52_12.z)

				local var_52_13 = var_52_5.localEulerAngles

				var_52_13.z = 0
				var_52_13.x = 0
				var_52_5.localEulerAngles = var_52_13
			end

			local var_52_14 = 0
			local var_52_15 = 1

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				local var_52_16 = "play"
				local var_52_17 = "music"

				arg_49_1:AudioAction(var_52_16, var_52_17, "bgm_activity_1_1_1_hermes_story", "bgm_activity_1_1_1_hermes_story", "bgm_activity_1_1_1_hermes_story.awb")

				local var_52_18 = ""
				local var_52_19 = manager.audio:GetAudioName("bgm_activity_1_1_1_hermes_story", "bgm_activity_1_1_1_hermes_story")

				if var_52_19 ~= "" then
					if arg_49_1.bgmTxt_.text ~= var_52_19 and arg_49_1.bgmTxt_.text ~= "" then
						if arg_49_1.bgmTxt2_.text ~= "" then
							arg_49_1.bgmTxt_.text = arg_49_1.bgmTxt2_.text
						end

						arg_49_1.bgmTxt2_.text = var_52_19

						arg_49_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_49_1.bgmTxt_.text = var_52_19
						arg_49_1.bgmTxt2_.text = var_52_19
					end

					if arg_49_1.bgmTimer then
						arg_49_1.bgmTimer:Stop()

						arg_49_1.bgmTimer = nil
					end

					if arg_49_1.settingData.show_music_name == 1 then
						arg_49_1.musicController:SetSelectedState("show")
						arg_49_1.musicAnimator_:Play("open", 0, 0)

						if arg_49_1.settingData.music_time ~= 0 then
							arg_49_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_49_1.settingData.music_time), function()
								if arg_49_1 == nil or isNil(arg_49_1.bgmTxt_) then
									return
								end

								arg_49_1.musicController:SetSelectedState("hide")
								arg_49_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_52_20 = 0
			local var_52_21 = 0.5

			if var_52_20 < arg_49_1.time_ and arg_49_1.time_ <= var_52_20 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_22 = arg_49_1:FormatText(StoryNameCfg[169].name)

				arg_49_1.leftNameTxt_.text = var_52_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_23 = arg_49_1:GetWordFromCfg(111222012)
				local var_52_24 = arg_49_1:FormatText(var_52_23.content)

				arg_49_1.text_.text = var_52_24

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_25 = 20
				local var_52_26 = utf8.len(var_52_24)
				local var_52_27 = var_52_25 <= 0 and var_52_21 or var_52_21 * (var_52_26 / var_52_25)

				if var_52_27 > 0 and var_52_21 < var_52_27 then
					arg_49_1.talkMaxDuration = var_52_27

					if var_52_27 + var_52_20 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_27 + var_52_20
					end
				end

				arg_49_1.text_.text = var_52_24
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222012", "story_v_out_111222.awb") ~= 0 then
					local var_52_28 = manager.audio:GetVoiceLength("story_v_out_111222", "111222012", "story_v_out_111222.awb") / 1000

					if var_52_28 + var_52_20 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_28 + var_52_20
					end

					if var_52_23.prefab_name ~= "" and arg_49_1.actors_[var_52_23.prefab_name] ~= nil then
						local var_52_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_23.prefab_name].transform, "story_v_out_111222", "111222012", "story_v_out_111222.awb")

						arg_49_1:RecordAudio("111222012", var_52_29)
						arg_49_1:RecordAudio("111222012", var_52_29)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_111222", "111222012", "story_v_out_111222.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_111222", "111222012", "story_v_out_111222.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_30 = math.max(var_52_21, arg_49_1.talkMaxDuration)

			if var_52_20 <= arg_49_1.time_ and arg_49_1.time_ < var_52_20 + var_52_30 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_20) / var_52_30

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_20 + var_52_30 and arg_49_1.time_ < var_52_20 + var_52_30 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play111222013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 111222013
		arg_54_1.duration_ = 11.2

		local var_54_0 = {
			ja = 8.566,
			ko = 11.2,
			zh = 6.4,
			en = 6.433
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
				arg_54_0:Play111222014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1096ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1096ui_story == nil then
				arg_54_1.var_.characterEffect1096ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.2

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1096ui_story and not isNil(var_57_0) then
					local var_57_4 = Mathf.Lerp(0, 0.5, var_57_3)

					arg_54_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1096ui_story.fillRatio = var_57_4
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1096ui_story then
				local var_57_5 = 0.5

				arg_54_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1096ui_story.fillRatio = var_57_5
			end

			local var_57_6 = 0
			local var_57_7 = 0.825

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_8 = arg_54_1:FormatText(StoryNameCfg[32].name)

				arg_54_1.leftNameTxt_.text = var_57_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_9 = arg_54_1:GetWordFromCfg(111222013)
				local var_57_10 = arg_54_1:FormatText(var_57_9.content)

				arg_54_1.text_.text = var_57_10

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_11 = 34
				local var_57_12 = utf8.len(var_57_10)
				local var_57_13 = var_57_11 <= 0 and var_57_7 or var_57_7 * (var_57_12 / var_57_11)

				if var_57_13 > 0 and var_57_7 < var_57_13 then
					arg_54_1.talkMaxDuration = var_57_13

					if var_57_13 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_13 + var_57_6
					end
				end

				arg_54_1.text_.text = var_57_10
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222013", "story_v_out_111222.awb") ~= 0 then
					local var_57_14 = manager.audio:GetVoiceLength("story_v_out_111222", "111222013", "story_v_out_111222.awb") / 1000

					if var_57_14 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_14 + var_57_6
					end

					if var_57_9.prefab_name ~= "" and arg_54_1.actors_[var_57_9.prefab_name] ~= nil then
						local var_57_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_9.prefab_name].transform, "story_v_out_111222", "111222013", "story_v_out_111222.awb")

						arg_54_1:RecordAudio("111222013", var_57_15)
						arg_54_1:RecordAudio("111222013", var_57_15)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_111222", "111222013", "story_v_out_111222.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_111222", "111222013", "story_v_out_111222.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_16 = math.max(var_57_7, arg_54_1.talkMaxDuration)

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_16 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_6) / var_57_16

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_6 + var_57_16 and arg_54_1.time_ < var_57_6 + var_57_16 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play111222014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 111222014
		arg_58_1.duration_ = 5.77

		local var_58_0 = {
			ja = 5.766,
			ko = 5.433,
			zh = 4.866,
			en = 4.633
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
				arg_58_0:Play111222015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action6_2")
			end

			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_61_2 = arg_58_1.actors_["1096ui_story"]
			local var_61_3 = 0

			if var_61_3 < arg_58_1.time_ and arg_58_1.time_ <= var_61_3 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect1096ui_story == nil then
				arg_58_1.var_.characterEffect1096ui_story = var_61_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_4 = 0.2

			if var_61_3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_3 + var_61_4 and not isNil(var_61_2) then
				local var_61_5 = (arg_58_1.time_ - var_61_3) / var_61_4

				if arg_58_1.var_.characterEffect1096ui_story and not isNil(var_61_2) then
					arg_58_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_3 + var_61_4 and arg_58_1.time_ < var_61_3 + var_61_4 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect1096ui_story then
				arg_58_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_61_6 = 0
			local var_61_7 = 0.675

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_8 = arg_58_1:FormatText(StoryNameCfg[169].name)

				arg_58_1.leftNameTxt_.text = var_61_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_9 = arg_58_1:GetWordFromCfg(111222014)
				local var_61_10 = arg_58_1:FormatText(var_61_9.content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 27
				local var_61_12 = utf8.len(var_61_10)
				local var_61_13 = var_61_11 <= 0 and var_61_7 or var_61_7 * (var_61_12 / var_61_11)

				if var_61_13 > 0 and var_61_7 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_10
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222014", "story_v_out_111222.awb") ~= 0 then
					local var_61_14 = manager.audio:GetVoiceLength("story_v_out_111222", "111222014", "story_v_out_111222.awb") / 1000

					if var_61_14 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_14 + var_61_6
					end

					if var_61_9.prefab_name ~= "" and arg_58_1.actors_[var_61_9.prefab_name] ~= nil then
						local var_61_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_9.prefab_name].transform, "story_v_out_111222", "111222014", "story_v_out_111222.awb")

						arg_58_1:RecordAudio("111222014", var_61_15)
						arg_58_1:RecordAudio("111222014", var_61_15)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_111222", "111222014", "story_v_out_111222.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_111222", "111222014", "story_v_out_111222.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_16 and arg_58_1.time_ < var_61_6 + var_61_16 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play111222015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 111222015
		arg_62_1.duration_ = 2.03

		local var_62_0 = {
			ja = 1.933,
			ko = 2.033,
			zh = 2.033,
			en = 1.2
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
				arg_62_0:Play111222016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1096ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1096ui_story == nil then
				arg_62_1.var_.characterEffect1096ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.2

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1096ui_story and not isNil(var_65_0) then
					local var_65_4 = Mathf.Lerp(0, 0.5, var_65_3)

					arg_62_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1096ui_story.fillRatio = var_65_4
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1096ui_story then
				local var_65_5 = 0.5

				arg_62_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1096ui_story.fillRatio = var_65_5
			end

			local var_65_6 = 0
			local var_65_7 = 0.25

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[32].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_9 = arg_62_1:GetWordFromCfg(111222015)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 6
				local var_65_12 = utf8.len(var_65_10)
				local var_65_13 = var_65_11 <= 0 and var_65_7 or var_65_7 * (var_65_12 / var_65_11)

				if var_65_13 > 0 and var_65_7 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_10
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222015", "story_v_out_111222.awb") ~= 0 then
					local var_65_14 = manager.audio:GetVoiceLength("story_v_out_111222", "111222015", "story_v_out_111222.awb") / 1000

					if var_65_14 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_6
					end

					if var_65_9.prefab_name ~= "" and arg_62_1.actors_[var_65_9.prefab_name] ~= nil then
						local var_65_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_9.prefab_name].transform, "story_v_out_111222", "111222015", "story_v_out_111222.awb")

						arg_62_1:RecordAudio("111222015", var_65_15)
						arg_62_1:RecordAudio("111222015", var_65_15)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_111222", "111222015", "story_v_out_111222.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_111222", "111222015", "story_v_out_111222.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_16 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_16 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_16

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_16 and arg_62_1.time_ < var_65_6 + var_65_16 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play111222016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 111222016
		arg_66_1.duration_ = 6.7

		local var_66_0 = {
			ja = 6.7,
			ko = 2.333,
			zh = 2.366,
			en = 1.999999999999
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
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play111222017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_69_1 = arg_66_1.actors_["1096ui_story"]
			local var_69_2 = 0

			if var_69_2 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 and not isNil(var_69_1) and arg_66_1.var_.characterEffect1096ui_story == nil then
				arg_66_1.var_.characterEffect1096ui_story = var_69_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_3 = 0.2

			if var_69_2 <= arg_66_1.time_ and arg_66_1.time_ < var_69_2 + var_69_3 and not isNil(var_69_1) then
				local var_69_4 = (arg_66_1.time_ - var_69_2) / var_69_3

				if arg_66_1.var_.characterEffect1096ui_story and not isNil(var_69_1) then
					arg_66_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_2 + var_69_3 and arg_66_1.time_ < var_69_2 + var_69_3 + arg_69_0 and not isNil(var_69_1) and arg_66_1.var_.characterEffect1096ui_story then
				arg_66_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_69_5 = 0
			local var_69_6 = 0.275

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_7 = arg_66_1:FormatText(StoryNameCfg[169].name)

				arg_66_1.leftNameTxt_.text = var_69_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_8 = arg_66_1:GetWordFromCfg(111222016)
				local var_69_9 = arg_66_1:FormatText(var_69_8.content)

				arg_66_1.text_.text = var_69_9

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_10 = 11
				local var_69_11 = utf8.len(var_69_9)
				local var_69_12 = var_69_10 <= 0 and var_69_6 or var_69_6 * (var_69_11 / var_69_10)

				if var_69_12 > 0 and var_69_6 < var_69_12 then
					arg_66_1.talkMaxDuration = var_69_12

					if var_69_12 + var_69_5 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_12 + var_69_5
					end
				end

				arg_66_1.text_.text = var_69_9
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222016", "story_v_out_111222.awb") ~= 0 then
					local var_69_13 = manager.audio:GetVoiceLength("story_v_out_111222", "111222016", "story_v_out_111222.awb") / 1000

					if var_69_13 + var_69_5 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_13 + var_69_5
					end

					if var_69_8.prefab_name ~= "" and arg_66_1.actors_[var_69_8.prefab_name] ~= nil then
						local var_69_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_8.prefab_name].transform, "story_v_out_111222", "111222016", "story_v_out_111222.awb")

						arg_66_1:RecordAudio("111222016", var_69_14)
						arg_66_1:RecordAudio("111222016", var_69_14)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_111222", "111222016", "story_v_out_111222.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_111222", "111222016", "story_v_out_111222.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_15 = math.max(var_69_6, arg_66_1.talkMaxDuration)

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_15 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_5) / var_69_15

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_5 + var_69_15 and arg_66_1.time_ < var_69_5 + var_69_15 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play111222017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 111222017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play111222018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1096ui_story"].transform
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.var_.moveOldPos1096ui_story = var_73_0.localPosition
			end

			local var_73_2 = 0.001

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2
				local var_73_4 = Vector3.New(0, 100, 0)

				var_73_0.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1096ui_story, var_73_4, var_73_3)

				local var_73_5 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_5.x, var_73_5.y, var_73_5.z)

				local var_73_6 = var_73_0.localEulerAngles

				var_73_6.z = 0
				var_73_6.x = 0
				var_73_0.localEulerAngles = var_73_6
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 then
				var_73_0.localPosition = Vector3.New(0, 100, 0)

				local var_73_7 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_7.x, var_73_7.y, var_73_7.z)

				local var_73_8 = var_73_0.localEulerAngles

				var_73_8.z = 0
				var_73_8.x = 0
				var_73_0.localEulerAngles = var_73_8
			end

			local var_73_9 = 0
			local var_73_10 = 0.95

			if var_73_9 < arg_70_1.time_ and arg_70_1.time_ <= var_73_9 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_11 = arg_70_1:GetWordFromCfg(111222017)
				local var_73_12 = arg_70_1:FormatText(var_73_11.content)

				arg_70_1.text_.text = var_73_12

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_13 = 38
				local var_73_14 = utf8.len(var_73_12)
				local var_73_15 = var_73_13 <= 0 and var_73_10 or var_73_10 * (var_73_14 / var_73_13)

				if var_73_15 > 0 and var_73_10 < var_73_15 then
					arg_70_1.talkMaxDuration = var_73_15

					if var_73_15 + var_73_9 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_15 + var_73_9
					end
				end

				arg_70_1.text_.text = var_73_12
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_16 = math.max(var_73_10, arg_70_1.talkMaxDuration)

			if var_73_9 <= arg_70_1.time_ and arg_70_1.time_ < var_73_9 + var_73_16 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_9) / var_73_16

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_9 + var_73_16 and arg_70_1.time_ < var_73_9 + var_73_16 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play111222018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 111222018
		arg_74_1.duration_ = 4.43

		local var_74_0 = {
			ja = 4.3,
			ko = 4.033,
			zh = 4.266,
			en = 4.433
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play111222019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1096ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1096ui_story == nil then
				arg_74_1.var_.characterEffect1096ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.2

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect1096ui_story and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1096ui_story then
				arg_74_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_77_4 = 0

			if var_77_4 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action1_1")
			end

			local var_77_5 = 0

			if var_77_5 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 then
				arg_74_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_77_6 = arg_74_1.actors_["1096ui_story"].transform
			local var_77_7 = 0

			if var_77_7 < arg_74_1.time_ and arg_74_1.time_ <= var_77_7 + arg_77_0 then
				arg_74_1.var_.moveOldPos1096ui_story = var_77_6.localPosition
			end

			local var_77_8 = 0.001

			if var_77_7 <= arg_74_1.time_ and arg_74_1.time_ < var_77_7 + var_77_8 then
				local var_77_9 = (arg_74_1.time_ - var_77_7) / var_77_8
				local var_77_10 = Vector3.New(0, -1.13, -5.6)

				var_77_6.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1096ui_story, var_77_10, var_77_9)

				local var_77_11 = manager.ui.mainCamera.transform.position - var_77_6.position

				var_77_6.forward = Vector3.New(var_77_11.x, var_77_11.y, var_77_11.z)

				local var_77_12 = var_77_6.localEulerAngles

				var_77_12.z = 0
				var_77_12.x = 0
				var_77_6.localEulerAngles = var_77_12
			end

			if arg_74_1.time_ >= var_77_7 + var_77_8 and arg_74_1.time_ < var_77_7 + var_77_8 + arg_77_0 then
				var_77_6.localPosition = Vector3.New(0, -1.13, -5.6)

				local var_77_13 = manager.ui.mainCamera.transform.position - var_77_6.position

				var_77_6.forward = Vector3.New(var_77_13.x, var_77_13.y, var_77_13.z)

				local var_77_14 = var_77_6.localEulerAngles

				var_77_14.z = 0
				var_77_14.x = 0
				var_77_6.localEulerAngles = var_77_14
			end

			local var_77_15 = 0
			local var_77_16 = 0.45

			if var_77_15 < arg_74_1.time_ and arg_74_1.time_ <= var_77_15 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_17 = arg_74_1:FormatText(StoryNameCfg[169].name)

				arg_74_1.leftNameTxt_.text = var_77_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_18 = arg_74_1:GetWordFromCfg(111222018)
				local var_77_19 = arg_74_1:FormatText(var_77_18.content)

				arg_74_1.text_.text = var_77_19

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_20 = 18
				local var_77_21 = utf8.len(var_77_19)
				local var_77_22 = var_77_20 <= 0 and var_77_16 or var_77_16 * (var_77_21 / var_77_20)

				if var_77_22 > 0 and var_77_16 < var_77_22 then
					arg_74_1.talkMaxDuration = var_77_22

					if var_77_22 + var_77_15 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_22 + var_77_15
					end
				end

				arg_74_1.text_.text = var_77_19
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222018", "story_v_out_111222.awb") ~= 0 then
					local var_77_23 = manager.audio:GetVoiceLength("story_v_out_111222", "111222018", "story_v_out_111222.awb") / 1000

					if var_77_23 + var_77_15 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_23 + var_77_15
					end

					if var_77_18.prefab_name ~= "" and arg_74_1.actors_[var_77_18.prefab_name] ~= nil then
						local var_77_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_18.prefab_name].transform, "story_v_out_111222", "111222018", "story_v_out_111222.awb")

						arg_74_1:RecordAudio("111222018", var_77_24)
						arg_74_1:RecordAudio("111222018", var_77_24)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_111222", "111222018", "story_v_out_111222.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_111222", "111222018", "story_v_out_111222.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_25 = math.max(var_77_16, arg_74_1.talkMaxDuration)

			if var_77_15 <= arg_74_1.time_ and arg_74_1.time_ < var_77_15 + var_77_25 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_15) / var_77_25

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_15 + var_77_25 and arg_74_1.time_ < var_77_15 + var_77_25 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play111222019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 111222019
		arg_78_1.duration_ = 7.83

		local var_78_0 = {
			ja = 6.533,
			ko = 7.833,
			zh = 7.5,
			en = 7.333
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play111222020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_81_1 = 0
			local var_81_2 = 1.025

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_3 = arg_78_1:FormatText(StoryNameCfg[169].name)

				arg_78_1.leftNameTxt_.text = var_81_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_4 = arg_78_1:GetWordFromCfg(111222019)
				local var_81_5 = arg_78_1:FormatText(var_81_4.content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_6 = 41
				local var_81_7 = utf8.len(var_81_5)
				local var_81_8 = var_81_6 <= 0 and var_81_2 or var_81_2 * (var_81_7 / var_81_6)

				if var_81_8 > 0 and var_81_2 < var_81_8 then
					arg_78_1.talkMaxDuration = var_81_8

					if var_81_8 + var_81_1 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_1
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222019", "story_v_out_111222.awb") ~= 0 then
					local var_81_9 = manager.audio:GetVoiceLength("story_v_out_111222", "111222019", "story_v_out_111222.awb") / 1000

					if var_81_9 + var_81_1 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_1
					end

					if var_81_4.prefab_name ~= "" and arg_78_1.actors_[var_81_4.prefab_name] ~= nil then
						local var_81_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_4.prefab_name].transform, "story_v_out_111222", "111222019", "story_v_out_111222.awb")

						arg_78_1:RecordAudio("111222019", var_81_10)
						arg_78_1:RecordAudio("111222019", var_81_10)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_111222", "111222019", "story_v_out_111222.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_111222", "111222019", "story_v_out_111222.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_11 = math.max(var_81_2, arg_78_1.talkMaxDuration)

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_11 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_1) / var_81_11

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_1 + var_81_11 and arg_78_1.time_ < var_81_1 + var_81_11 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play111222020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 111222020
		arg_82_1.duration_ = 12.73

		local var_82_0 = {
			ja = 12.733,
			ko = 8.5,
			zh = 12.166,
			en = 10.866
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play111222021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_85_1 = 0
			local var_85_2 = 1.3

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_3 = arg_82_1:FormatText(StoryNameCfg[169].name)

				arg_82_1.leftNameTxt_.text = var_85_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_4 = arg_82_1:GetWordFromCfg(111222020)
				local var_85_5 = arg_82_1:FormatText(var_85_4.content)

				arg_82_1.text_.text = var_85_5

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_6 = 52
				local var_85_7 = utf8.len(var_85_5)
				local var_85_8 = var_85_6 <= 0 and var_85_2 or var_85_2 * (var_85_7 / var_85_6)

				if var_85_8 > 0 and var_85_2 < var_85_8 then
					arg_82_1.talkMaxDuration = var_85_8

					if var_85_8 + var_85_1 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_1
					end
				end

				arg_82_1.text_.text = var_85_5
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222020", "story_v_out_111222.awb") ~= 0 then
					local var_85_9 = manager.audio:GetVoiceLength("story_v_out_111222", "111222020", "story_v_out_111222.awb") / 1000

					if var_85_9 + var_85_1 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_1
					end

					if var_85_4.prefab_name ~= "" and arg_82_1.actors_[var_85_4.prefab_name] ~= nil then
						local var_85_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_4.prefab_name].transform, "story_v_out_111222", "111222020", "story_v_out_111222.awb")

						arg_82_1:RecordAudio("111222020", var_85_10)
						arg_82_1:RecordAudio("111222020", var_85_10)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_111222", "111222020", "story_v_out_111222.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_111222", "111222020", "story_v_out_111222.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_11 = math.max(var_85_2, arg_82_1.talkMaxDuration)

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_11 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_1) / var_85_11

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_1 + var_85_11 and arg_82_1.time_ < var_85_1 + var_85_11 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play111222021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 111222021
		arg_86_1.duration_ = 8.5

		local var_86_0 = {
			ja = 8.5,
			ko = 4.9,
			zh = 6.033,
			en = 5.6
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play111222022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action3_1")
			end

			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_89_2 = 0
			local var_89_3 = 0.625

			if var_89_2 < arg_86_1.time_ and arg_86_1.time_ <= var_89_2 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_4 = arg_86_1:FormatText(StoryNameCfg[169].name)

				arg_86_1.leftNameTxt_.text = var_89_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_5 = arg_86_1:GetWordFromCfg(111222021)
				local var_89_6 = arg_86_1:FormatText(var_89_5.content)

				arg_86_1.text_.text = var_89_6

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_7 = 25
				local var_89_8 = utf8.len(var_89_6)
				local var_89_9 = var_89_7 <= 0 and var_89_3 or var_89_3 * (var_89_8 / var_89_7)

				if var_89_9 > 0 and var_89_3 < var_89_9 then
					arg_86_1.talkMaxDuration = var_89_9

					if var_89_9 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_2
					end
				end

				arg_86_1.text_.text = var_89_6
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222021", "story_v_out_111222.awb") ~= 0 then
					local var_89_10 = manager.audio:GetVoiceLength("story_v_out_111222", "111222021", "story_v_out_111222.awb") / 1000

					if var_89_10 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_2
					end

					if var_89_5.prefab_name ~= "" and arg_86_1.actors_[var_89_5.prefab_name] ~= nil then
						local var_89_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_5.prefab_name].transform, "story_v_out_111222", "111222021", "story_v_out_111222.awb")

						arg_86_1:RecordAudio("111222021", var_89_11)
						arg_86_1:RecordAudio("111222021", var_89_11)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_111222", "111222021", "story_v_out_111222.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_111222", "111222021", "story_v_out_111222.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_12 = math.max(var_89_3, arg_86_1.talkMaxDuration)

			if var_89_2 <= arg_86_1.time_ and arg_86_1.time_ < var_89_2 + var_89_12 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_2) / var_89_12

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_2 + var_89_12 and arg_86_1.time_ < var_89_2 + var_89_12 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play111222022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 111222022
		arg_90_1.duration_ = 6.33

		local var_90_0 = {
			ja = 6.333,
			ko = 3.9,
			zh = 5.1,
			en = 3.733
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play111222023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1096ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1096ui_story == nil then
				arg_90_1.var_.characterEffect1096ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1096ui_story and not isNil(var_93_0) then
					local var_93_4 = Mathf.Lerp(0, 0.5, var_93_3)

					arg_90_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1096ui_story.fillRatio = var_93_4
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1096ui_story then
				local var_93_5 = 0.5

				arg_90_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1096ui_story.fillRatio = var_93_5
			end

			local var_93_6 = 0
			local var_93_7 = 0.575

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_8 = arg_90_1:FormatText(StoryNameCfg[32].name)

				arg_90_1.leftNameTxt_.text = var_93_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_9 = arg_90_1:GetWordFromCfg(111222022)
				local var_93_10 = arg_90_1:FormatText(var_93_9.content)

				arg_90_1.text_.text = var_93_10

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 18
				local var_93_12 = utf8.len(var_93_10)
				local var_93_13 = var_93_11 <= 0 and var_93_7 or var_93_7 * (var_93_12 / var_93_11)

				if var_93_13 > 0 and var_93_7 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_10
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222022", "story_v_out_111222.awb") ~= 0 then
					local var_93_14 = manager.audio:GetVoiceLength("story_v_out_111222", "111222022", "story_v_out_111222.awb") / 1000

					if var_93_14 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_14 + var_93_6
					end

					if var_93_9.prefab_name ~= "" and arg_90_1.actors_[var_93_9.prefab_name] ~= nil then
						local var_93_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_9.prefab_name].transform, "story_v_out_111222", "111222022", "story_v_out_111222.awb")

						arg_90_1:RecordAudio("111222022", var_93_15)
						arg_90_1:RecordAudio("111222022", var_93_15)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_111222", "111222022", "story_v_out_111222.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_111222", "111222022", "story_v_out_111222.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_16 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_16 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_16

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_16 and arg_90_1.time_ < var_93_6 + var_93_16 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play111222023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 111222023
		arg_94_1.duration_ = 5.23

		local var_94_0 = {
			ja = 4.033,
			ko = 5.233,
			zh = 4.5,
			en = 2.9
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play111222024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action3_2")
			end

			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_97_2 = arg_94_1.actors_["1096ui_story"]
			local var_97_3 = 0

			if var_97_3 < arg_94_1.time_ and arg_94_1.time_ <= var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect1096ui_story == nil then
				arg_94_1.var_.characterEffect1096ui_story = var_97_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_4 = 0.2

			if var_97_3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_3 + var_97_4 and not isNil(var_97_2) then
				local var_97_5 = (arg_94_1.time_ - var_97_3) / var_97_4

				if arg_94_1.var_.characterEffect1096ui_story and not isNil(var_97_2) then
					arg_94_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_3 + var_97_4 and arg_94_1.time_ < var_97_3 + var_97_4 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect1096ui_story then
				arg_94_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_97_6 = 0
			local var_97_7 = 0.55

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_8 = arg_94_1:FormatText(StoryNameCfg[169].name)

				arg_94_1.leftNameTxt_.text = var_97_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_9 = arg_94_1:GetWordFromCfg(111222023)
				local var_97_10 = arg_94_1:FormatText(var_97_9.content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 22
				local var_97_12 = utf8.len(var_97_10)
				local var_97_13 = var_97_11 <= 0 and var_97_7 or var_97_7 * (var_97_12 / var_97_11)

				if var_97_13 > 0 and var_97_7 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_6
					end
				end

				arg_94_1.text_.text = var_97_10
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222023", "story_v_out_111222.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_111222", "111222023", "story_v_out_111222.awb") / 1000

					if var_97_14 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_6
					end

					if var_97_9.prefab_name ~= "" and arg_94_1.actors_[var_97_9.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_9.prefab_name].transform, "story_v_out_111222", "111222023", "story_v_out_111222.awb")

						arg_94_1:RecordAudio("111222023", var_97_15)
						arg_94_1:RecordAudio("111222023", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_111222", "111222023", "story_v_out_111222.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_111222", "111222023", "story_v_out_111222.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_16 and arg_94_1.time_ < var_97_6 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play111222024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 111222024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play111222025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1096ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos1096ui_story = var_101_0.localPosition
			end

			local var_101_2 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2
				local var_101_4 = Vector3.New(0, 100, 0)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1096ui_story, var_101_4, var_101_3)

				local var_101_5 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_5.x, var_101_5.y, var_101_5.z)

				local var_101_6 = var_101_0.localEulerAngles

				var_101_6.z = 0
				var_101_6.x = 0
				var_101_0.localEulerAngles = var_101_6
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(0, 100, 0)

				local var_101_7 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_7.x, var_101_7.y, var_101_7.z)

				local var_101_8 = var_101_0.localEulerAngles

				var_101_8.z = 0
				var_101_8.x = 0
				var_101_0.localEulerAngles = var_101_8
			end

			local var_101_9 = 0
			local var_101_10 = 0.6

			if var_101_9 < arg_98_1.time_ and arg_98_1.time_ <= var_101_9 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_11 = arg_98_1:GetWordFromCfg(111222024)
				local var_101_12 = arg_98_1:FormatText(var_101_11.content)

				arg_98_1.text_.text = var_101_12

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_13 = 24
				local var_101_14 = utf8.len(var_101_12)
				local var_101_15 = var_101_13 <= 0 and var_101_10 or var_101_10 * (var_101_14 / var_101_13)

				if var_101_15 > 0 and var_101_10 < var_101_15 then
					arg_98_1.talkMaxDuration = var_101_15

					if var_101_15 + var_101_9 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_15 + var_101_9
					end
				end

				arg_98_1.text_.text = var_101_12
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_16 = math.max(var_101_10, arg_98_1.talkMaxDuration)

			if var_101_9 <= arg_98_1.time_ and arg_98_1.time_ < var_101_9 + var_101_16 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_9) / var_101_16

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_9 + var_101_16 and arg_98_1.time_ < var_101_9 + var_101_16 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play111222025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 111222025
		arg_102_1.duration_ = 3.63

		local var_102_0 = {
			ja = 3.633,
			ko = 1.5,
			zh = 3,
			en = 3.6
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play111222026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.2

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_2 = arg_102_1:FormatText(StoryNameCfg[169].name)

				arg_102_1.leftNameTxt_.text = var_105_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1096")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_3 = arg_102_1:GetWordFromCfg(111222025)
				local var_105_4 = arg_102_1:FormatText(var_105_3.content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 8
				local var_105_6 = utf8.len(var_105_4)
				local var_105_7 = var_105_5 <= 0 and var_105_1 or var_105_1 * (var_105_6 / var_105_5)

				if var_105_7 > 0 and var_105_1 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_4
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222025", "story_v_out_111222.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_111222", "111222025", "story_v_out_111222.awb") / 1000

					if var_105_8 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_0
					end

					if var_105_3.prefab_name ~= "" and arg_102_1.actors_[var_105_3.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_3.prefab_name].transform, "story_v_out_111222", "111222025", "story_v_out_111222.awb")

						arg_102_1:RecordAudio("111222025", var_105_9)
						arg_102_1:RecordAudio("111222025", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_111222", "111222025", "story_v_out_111222.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_111222", "111222025", "story_v_out_111222.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_10 and arg_102_1.time_ < var_105_0 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play111222026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 111222026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play111222027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.bgs_.A07a.transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPosA07a = var_109_0.localPosition
			end

			local var_109_2 = 2

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2
				local var_109_4 = Vector3.New(0, 1, 9)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPosA07a, var_109_4, var_109_3)
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(0, 1, 9)
			end

			local var_109_5 = 0
			local var_109_6 = 1.3

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_7 = arg_106_1:GetWordFromCfg(111222026)
				local var_109_8 = arg_106_1:FormatText(var_109_7.content)

				arg_106_1.text_.text = var_109_8

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 52
				local var_109_10 = utf8.len(var_109_8)
				local var_109_11 = var_109_9 <= 0 and var_109_6 or var_109_6 * (var_109_10 / var_109_9)

				if var_109_11 > 0 and var_109_6 < var_109_11 then
					arg_106_1.talkMaxDuration = var_109_11

					if var_109_11 + var_109_5 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_11 + var_109_5
					end
				end

				arg_106_1.text_.text = var_109_8
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_12 = math.max(var_109_6, arg_106_1.talkMaxDuration)

			if var_109_5 <= arg_106_1.time_ and arg_106_1.time_ < var_109_5 + var_109_12 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_5) / var_109_12

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_5 + var_109_12 and arg_106_1.time_ < var_109_5 + var_109_12 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "A07a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play111222027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 111222027
		arg_110_1.duration_ = 6.5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play111222028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.bgs_.A07a.transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPosA07a = var_113_0.localPosition
			end

			local var_113_2 = 0.001

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2
				local var_113_4 = Vector3.New(0, 1, 9)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPosA07a, var_113_4, var_113_3)
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(0, 1, 9)
			end

			local var_113_5 = arg_110_1.bgs_.A07a.transform
			local var_113_6 = 0.0166666666666667

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.var_.moveOldPosA07a = var_113_5.localPosition
			end

			local var_113_7 = 0.1

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_7 then
				local var_113_8 = (arg_110_1.time_ - var_113_6) / var_113_7
				local var_113_9 = Vector3.New(1.5, 2, 1)

				var_113_5.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPosA07a, var_113_9, var_113_8)
			end

			if arg_110_1.time_ >= var_113_6 + var_113_7 and arg_110_1.time_ < var_113_6 + var_113_7 + arg_113_0 then
				var_113_5.localPosition = Vector3.New(1.5, 2, 1)
			end

			local var_113_10 = arg_110_1.bgs_.A07a
			local var_113_11 = 0.116666666666667

			if var_113_11 < arg_110_1.time_ and arg_110_1.time_ <= var_113_11 + arg_113_0 then
				local var_113_12 = var_113_10:GetComponent("SpriteRenderer")

				if var_113_12 then
					arg_110_1.var_.alphaOldValueA07a = var_113_12.color.a
					arg_110_1.var_.alphaMatValueA07a = var_113_12
				end

				arg_110_1.var_.alphaOldValueA07a = 1
			end

			local var_113_13 = 0.0166666666666667

			if var_113_11 <= arg_110_1.time_ and arg_110_1.time_ < var_113_11 + var_113_13 then
				local var_113_14 = (arg_110_1.time_ - var_113_11) / var_113_13
				local var_113_15 = Mathf.Lerp(arg_110_1.var_.alphaOldValueA07a, 0, var_113_14)

				if arg_110_1.var_.alphaMatValueA07a then
					local var_113_16 = arg_110_1.var_.alphaMatValueA07a.color

					var_113_16.a = var_113_15
					arg_110_1.var_.alphaMatValueA07a.color = var_113_16
				end
			end

			if arg_110_1.time_ >= var_113_11 + var_113_13 and arg_110_1.time_ < var_113_11 + var_113_13 + arg_113_0 and arg_110_1.var_.alphaMatValueA07a then
				local var_113_17 = arg_110_1.var_.alphaMatValueA07a
				local var_113_18 = var_113_17.color

				var_113_18.a = 0
				var_113_17.color = var_113_18
			end

			local var_113_19 = "STwhite"

			if arg_110_1.bgs_[var_113_19] == nil then
				local var_113_20 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_113_19)
				var_113_20.name = var_113_19
				var_113_20.transform.parent = arg_110_1.stage_.transform
				var_113_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_[var_113_19] = var_113_20
			end

			local var_113_21 = arg_110_1.bgs_.STwhite.transform
			local var_113_22 = 1.08266666666667

			if var_113_22 < arg_110_1.time_ and arg_110_1.time_ <= var_113_22 + arg_113_0 then
				arg_110_1.var_.moveOldPosSTwhite = var_113_21.localPosition
				var_113_21.localScale = Vector3.New(10, 10, 10)
			end

			local var_113_23 = 0.001

			if var_113_22 <= arg_110_1.time_ and arg_110_1.time_ < var_113_22 + var_113_23 then
				local var_113_24 = (arg_110_1.time_ - var_113_22) / var_113_23
				local var_113_25 = Vector3.New(0, 0, 0)

				var_113_21.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPosSTwhite, var_113_25, var_113_24)
			end

			if arg_110_1.time_ >= var_113_22 + var_113_23 and arg_110_1.time_ < var_113_22 + var_113_23 + arg_113_0 then
				var_113_21.localPosition = Vector3.New(0, 0, 0)
			end

			local var_113_26 = 0.116666666666667

			if var_113_26 < arg_110_1.time_ and arg_110_1.time_ <= var_113_26 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_27 = 1

			if var_113_26 <= arg_110_1.time_ and arg_110_1.time_ < var_113_26 + var_113_27 then
				local var_113_28 = (arg_110_1.time_ - var_113_26) / var_113_27
				local var_113_29 = Color.New(1, 1, 1)

				var_113_29.a = Mathf.Lerp(0, 1, var_113_28)
				arg_110_1.mask_.color = var_113_29
			end

			if arg_110_1.time_ >= var_113_26 + var_113_27 and arg_110_1.time_ < var_113_26 + var_113_27 + arg_113_0 then
				local var_113_30 = Color.New(1, 1, 1)

				var_113_30.a = 1
				arg_110_1.mask_.color = var_113_30
			end

			local var_113_31 = 1.11666666666667

			if var_113_31 < arg_110_1.time_ and arg_110_1.time_ <= var_113_31 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = false

				arg_110_1:SetGaussion(false)
			end

			local var_113_32 = 0.0166666666666667

			if var_113_31 <= arg_110_1.time_ and arg_110_1.time_ < var_113_31 + var_113_32 then
				local var_113_33 = (arg_110_1.time_ - var_113_31) / var_113_32
				local var_113_34 = Color.New(1, 1, 1)

				var_113_34.a = Mathf.Lerp(1, 0, var_113_33)
				arg_110_1.mask_.color = var_113_34
			end

			if arg_110_1.time_ >= var_113_31 + var_113_32 and arg_110_1.time_ < var_113_31 + var_113_32 + arg_113_0 then
				local var_113_35 = Color.New(1, 1, 1)
				local var_113_36 = 0

				arg_110_1.mask_.enabled = false
				var_113_35.a = var_113_36
				arg_110_1.mask_.color = var_113_35
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_37 = 1.5
			local var_113_38 = 0.975

			if var_113_37 < arg_110_1.time_ and arg_110_1.time_ <= var_113_37 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_39 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_39:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_40 = arg_110_1:GetWordFromCfg(111222027)
				local var_113_41 = arg_110_1:FormatText(var_113_40.content)

				arg_110_1.text_.text = var_113_41

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_42 = 39
				local var_113_43 = utf8.len(var_113_41)
				local var_113_44 = var_113_42 <= 0 and var_113_38 or var_113_38 * (var_113_43 / var_113_42)

				if var_113_44 > 0 and var_113_38 < var_113_44 then
					arg_110_1.talkMaxDuration = var_113_44
					var_113_37 = var_113_37 + 0.3

					if var_113_44 + var_113_37 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_44 + var_113_37
					end
				end

				arg_110_1.text_.text = var_113_41
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_45 = var_113_37 + 0.3
			local var_113_46 = math.max(var_113_38, arg_110_1.talkMaxDuration)

			if var_113_45 <= arg_110_1.time_ and arg_110_1.time_ < var_113_45 + var_113_46 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_45) / var_113_46

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_45 + var_113_46 and arg_110_1.time_ < var_113_45 + var_113_46 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "A07a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "A07a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.08266666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play111222028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 111222028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play111222029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 1.225

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_2 = arg_116_1:GetWordFromCfg(111222028)
				local var_119_3 = arg_116_1:FormatText(var_119_2.content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 49
				local var_119_5 = utf8.len(var_119_3)
				local var_119_6 = var_119_4 <= 0 and var_119_1 or var_119_1 * (var_119_5 / var_119_4)

				if var_119_6 > 0 and var_119_1 < var_119_6 then
					arg_116_1.talkMaxDuration = var_119_6

					if var_119_6 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_6 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_7 and arg_116_1.time_ < var_119_0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play111222029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 111222029
		arg_120_1.duration_ = 7

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play111222030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = "AS0109"

			if arg_120_1.bgs_[var_123_0] == nil then
				local var_123_1 = Object.Instantiate(arg_120_1.paintGo_)

				var_123_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_123_0)
				var_123_1.name = var_123_0
				var_123_1.transform.parent = arg_120_1.stage_.transform
				var_123_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_120_1.bgs_[var_123_0] = var_123_1
			end

			local var_123_2 = 0

			if var_123_2 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
				local var_123_3 = manager.ui.mainCamera.transform.localPosition
				local var_123_4 = Vector3.New(0, 0, 10) + Vector3.New(var_123_3.x, var_123_3.y, 0)
				local var_123_5 = arg_120_1.bgs_.AS0109

				var_123_5.transform.localPosition = var_123_4
				var_123_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_123_6 = var_123_5:GetComponent("SpriteRenderer")

				if var_123_6 and var_123_6.sprite then
					local var_123_7 = (var_123_5.transform.localPosition - var_123_3).z
					local var_123_8 = manager.ui.mainCameraCom_
					local var_123_9 = 2 * var_123_7 * Mathf.Tan(var_123_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_123_10 = var_123_9 * var_123_8.aspect
					local var_123_11 = var_123_6.sprite.bounds.size.x
					local var_123_12 = var_123_6.sprite.bounds.size.y
					local var_123_13 = var_123_10 / var_123_11
					local var_123_14 = var_123_9 / var_123_12
					local var_123_15 = var_123_14 < var_123_13 and var_123_13 or var_123_14

					var_123_5.transform.localScale = Vector3.New(var_123_15, var_123_15, 0)
				end

				for iter_123_0, iter_123_1 in pairs(arg_120_1.bgs_) do
					if iter_123_0 ~= "AS0109" then
						iter_123_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_123_16 = 0

			if var_123_16 < arg_120_1.time_ and arg_120_1.time_ <= var_123_16 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = false

				arg_120_1:SetGaussion(false)
			end

			local var_123_17 = 1.5

			if var_123_16 <= arg_120_1.time_ and arg_120_1.time_ < var_123_16 + var_123_17 then
				local var_123_18 = (arg_120_1.time_ - var_123_16) / var_123_17
				local var_123_19 = Color.New(1, 1, 1)

				var_123_19.a = Mathf.Lerp(1, 0, var_123_18)
				arg_120_1.mask_.color = var_123_19
			end

			if arg_120_1.time_ >= var_123_16 + var_123_17 and arg_120_1.time_ < var_123_16 + var_123_17 + arg_123_0 then
				local var_123_20 = Color.New(1, 1, 1)
				local var_123_21 = 0

				arg_120_1.mask_.enabled = false
				var_123_20.a = var_123_21
				arg_120_1.mask_.color = var_123_20
			end

			if arg_120_1.frameCnt_ <= 1 then
				arg_120_1.dialog_:SetActive(false)
			end

			local var_123_22 = 2
			local var_123_23 = 0.45

			if var_123_22 < arg_120_1.time_ and arg_120_1.time_ <= var_123_22 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0

				arg_120_1.dialog_:SetActive(true)

				arg_120_1.dialogCg_.alpha = 0

				local var_123_24 = LeanTween.value(arg_120_1.dialog_, 0, 1, 0.3)

				var_123_24:setOnUpdate(LuaHelper.FloatAction(function(arg_124_0)
					arg_120_1.dialogCg_.alpha = arg_124_0
				end))
				var_123_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_120_1.dialog_)
					var_123_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_120_1.duration_ = arg_120_1.duration_ + 0.3

				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_25 = arg_120_1:GetWordFromCfg(111222029)
				local var_123_26 = arg_120_1:FormatText(var_123_25.content)

				arg_120_1.text_.text = var_123_26

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_27 = 18
				local var_123_28 = utf8.len(var_123_26)
				local var_123_29 = var_123_27 <= 0 and var_123_23 or var_123_23 * (var_123_28 / var_123_27)

				if var_123_29 > 0 and var_123_23 < var_123_29 then
					arg_120_1.talkMaxDuration = var_123_29
					var_123_22 = var_123_22 + 0.3

					if var_123_29 + var_123_22 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_29 + var_123_22
					end
				end

				arg_120_1.text_.text = var_123_26
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_30 = var_123_22 + 0.3
			local var_123_31 = math.max(var_123_23, arg_120_1.talkMaxDuration)

			if var_123_30 <= arg_120_1.time_ and arg_120_1.time_ < var_123_30 + var_123_31 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_30) / var_123_31

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_30 + var_123_31 and arg_120_1.time_ < var_123_30 + var_123_31 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play111222030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 111222030
		arg_126_1.duration_ = 5.13

		local var_126_0 = {
			ja = 3.3,
			ko = 3.4,
			zh = 4.366,
			en = 5.133
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
				arg_126_0:Play111222031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = manager.ui.mainCamera.transform
			local var_129_1 = 0.2

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.var_.shakeOldPos = var_129_0.localPosition
			end

			local var_129_2 = 0.6

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / 0.066
				local var_129_4, var_129_5 = math.modf(var_129_3)

				var_129_0.localPosition = Vector3.New(var_129_5 * 0.13, var_129_5 * 0.13, var_129_5 * 0.13) + arg_126_1.var_.shakeOldPos
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 then
				var_129_0.localPosition = arg_126_1.var_.shakeOldPos
			end

			local var_129_6 = 0
			local var_129_7 = 0.2

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_8 = arg_126_1:FormatText(StoryNameCfg[169].name)

				arg_126_1.leftNameTxt_.text = var_129_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_9 = arg_126_1:GetWordFromCfg(111222030)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 8
				local var_129_12 = utf8.len(var_129_10)
				local var_129_13 = var_129_11 <= 0 and var_129_7 or var_129_7 * (var_129_12 / var_129_11)

				if var_129_13 > 0 and var_129_7 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_10
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222030", "story_v_out_111222.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_111222", "111222030", "story_v_out_111222.awb") / 1000

					if var_129_14 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_6
					end

					if var_129_9.prefab_name ~= "" and arg_126_1.actors_[var_129_9.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_9.prefab_name].transform, "story_v_out_111222", "111222030", "story_v_out_111222.awb")

						arg_126_1:RecordAudio("111222030", var_129_15)
						arg_126_1:RecordAudio("111222030", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_111222", "111222030", "story_v_out_111222.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_111222", "111222030", "story_v_out_111222.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_16 and arg_126_1.time_ < var_129_6 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play111222031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 111222031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play111222032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.6

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_2 = arg_130_1:GetWordFromCfg(111222031)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 24
				local var_133_5 = utf8.len(var_133_3)
				local var_133_6 = var_133_4 <= 0 and var_133_1 or var_133_1 * (var_133_5 / var_133_4)

				if var_133_6 > 0 and var_133_1 < var_133_6 then
					arg_130_1.talkMaxDuration = var_133_6

					if var_133_6 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_7 and arg_130_1.time_ < var_133_0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play111222032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 111222032
		arg_134_1.duration_ = 7.19

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
			arg_134_1.auto_ = false
		end

		function arg_134_1.playNext_(arg_136_0)
			arg_134_1.onStoryFinished_()
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.mask_.enabled = true
				arg_134_1.mask_.raycastTarget = true

				arg_134_1:SetGaussion(false)
			end

			local var_137_1 = 1.5

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_1 then
				local var_137_2 = (arg_134_1.time_ - var_137_0) / var_137_1
				local var_137_3 = Color.New(1, 1, 1)

				var_137_3.a = Mathf.Lerp(0, 1, var_137_2)
				arg_134_1.mask_.color = var_137_3
			end

			if arg_134_1.time_ >= var_137_0 + var_137_1 and arg_134_1.time_ < var_137_0 + var_137_1 + arg_137_0 then
				local var_137_4 = Color.New(1, 1, 1)

				var_137_4.a = 1
				arg_134_1.mask_.color = var_137_4
			end

			local var_137_5 = 1.5

			if var_137_5 < arg_134_1.time_ and arg_134_1.time_ <= var_137_5 + arg_137_0 then
				arg_134_1.mask_.enabled = true
				arg_134_1.mask_.raycastTarget = false

				arg_134_1:SetGaussion(false)
			end

			local var_137_6 = 0.0166666666666667

			if var_137_5 <= arg_134_1.time_ and arg_134_1.time_ < var_137_5 + var_137_6 then
				local var_137_7 = (arg_134_1.time_ - var_137_5) / var_137_6
				local var_137_8 = Color.New(1, 1, 1)

				var_137_8.a = Mathf.Lerp(1, 0, var_137_7)
				arg_134_1.mask_.color = var_137_8
			end

			if arg_134_1.time_ >= var_137_5 + var_137_6 and arg_134_1.time_ < var_137_5 + var_137_6 + arg_137_0 then
				local var_137_9 = Color.New(1, 1, 1)
				local var_137_10 = 0

				arg_134_1.mask_.enabled = false
				var_137_9.a = var_137_10
				arg_134_1.mask_.color = var_137_9
			end

			local var_137_11 = arg_134_1.bgs_.STwhite
			local var_137_12 = 1.51666666666667

			if var_137_12 < arg_134_1.time_ and arg_134_1.time_ <= var_137_12 + arg_137_0 then
				local var_137_13 = var_137_11:GetComponent("SpriteRenderer")

				if var_137_13 then
					arg_134_1.var_.alphaOldValueSTwhite = var_137_13.color.a
					arg_134_1.var_.alphaMatValueSTwhite = var_137_13
				end

				arg_134_1.var_.alphaOldValueSTwhite = 1
			end

			local var_137_14 = 1.5

			if var_137_12 <= arg_134_1.time_ and arg_134_1.time_ < var_137_12 + var_137_14 then
				local var_137_15 = (arg_134_1.time_ - var_137_12) / var_137_14
				local var_137_16 = Mathf.Lerp(arg_134_1.var_.alphaOldValueSTwhite, 0, var_137_15)

				if arg_134_1.var_.alphaMatValueSTwhite then
					local var_137_17 = arg_134_1.var_.alphaMatValueSTwhite.color

					var_137_17.a = var_137_16
					arg_134_1.var_.alphaMatValueSTwhite.color = var_137_17
				end
			end

			if arg_134_1.time_ >= var_137_12 + var_137_14 and arg_134_1.time_ < var_137_12 + var_137_14 + arg_137_0 and arg_134_1.var_.alphaMatValueSTwhite then
				local var_137_18 = arg_134_1.var_.alphaMatValueSTwhite
				local var_137_19 = var_137_18.color

				var_137_19.a = 0
				var_137_18.color = var_137_19
			end

			local var_137_20 = arg_134_1.bgs_.AS0109
			local var_137_21 = 0

			if var_137_21 < arg_134_1.time_ and arg_134_1.time_ <= var_137_21 + arg_137_0 then
				local var_137_22 = var_137_20:GetComponent("SpriteRenderer")

				if var_137_22 then
					arg_134_1.var_.alphaOldValueAS0109 = var_137_22.color.a
					arg_134_1.var_.alphaMatValueAS0109 = var_137_22
				end

				arg_134_1.var_.alphaOldValueAS0109 = 1
			end

			local var_137_23 = 0.0166666666666667

			if var_137_21 <= arg_134_1.time_ and arg_134_1.time_ < var_137_21 + var_137_23 then
				local var_137_24 = (arg_134_1.time_ - var_137_21) / var_137_23
				local var_137_25 = Mathf.Lerp(arg_134_1.var_.alphaOldValueAS0109, 0, var_137_24)

				if arg_134_1.var_.alphaMatValueAS0109 then
					local var_137_26 = arg_134_1.var_.alphaMatValueAS0109.color

					var_137_26.a = var_137_25
					arg_134_1.var_.alphaMatValueAS0109.color = var_137_26
				end
			end

			if arg_134_1.time_ >= var_137_21 + var_137_23 and arg_134_1.time_ < var_137_21 + var_137_23 + arg_137_0 and arg_134_1.var_.alphaMatValueAS0109 then
				local var_137_27 = arg_134_1.var_.alphaMatValueAS0109
				local var_137_28 = var_137_27.color

				var_137_28.a = 0
				var_137_27.color = var_137_28
			end

			local var_137_29 = arg_134_1.bgs_.STwhite.transform
			local var_137_30 = 1.466

			if var_137_30 < arg_134_1.time_ and arg_134_1.time_ <= var_137_30 + arg_137_0 then
				arg_134_1.var_.moveOldPosSTwhite = var_137_29.localPosition
				var_137_29.localScale = Vector3.New(10, 10, 10)
			end

			local var_137_31 = 0.001

			if var_137_30 <= arg_134_1.time_ and arg_134_1.time_ < var_137_30 + var_137_31 then
				local var_137_32 = (arg_134_1.time_ - var_137_30) / var_137_31
				local var_137_33 = Vector3.New(0, 0, 0)

				var_137_29.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPosSTwhite, var_137_33, var_137_32)
			end

			if arg_134_1.time_ >= var_137_30 + var_137_31 and arg_134_1.time_ < var_137_30 + var_137_31 + arg_137_0 then
				var_137_29.localPosition = Vector3.New(0, 0, 0)
			end

			local var_137_34 = 2.19166666666667
			local var_137_35 = 0.825

			if var_137_34 < arg_134_1.time_ and arg_134_1.time_ <= var_137_34 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_36 = arg_134_1:GetWordFromCfg(111222032)
				local var_137_37 = arg_134_1:FormatText(var_137_36.content)

				arg_134_1.text_.text = var_137_37

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_38 = 33
				local var_137_39 = utf8.len(var_137_37)
				local var_137_40 = var_137_38 <= 0 and var_137_35 or var_137_35 * (var_137_39 / var_137_38)

				if var_137_40 > 0 and var_137_35 < var_137_40 then
					arg_134_1.talkMaxDuration = var_137_40

					if var_137_40 + var_137_34 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_40 + var_137_34
					end
				end

				arg_134_1.text_.text = var_137_37
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_41 = math.max(var_137_35, arg_134_1.talkMaxDuration)

			if var_137_34 <= arg_134_1.time_ and arg_134_1.time_ < var_137_34 + var_137_41 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_34) / var_137_41

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_34 + var_137_41 and arg_134_1.time_ < var_137_34 + var_137_41 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.466,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A07a",
		"TextureConfig/Background/AS0109"
	},
	voices = {
		"story_v_out_111222.awb"
	}
}
