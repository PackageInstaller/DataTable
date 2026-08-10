return {
	Play104061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104061001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play104061002(arg_1_1)
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

			local var_4_10 = "B06a"

			if arg_1_1.bgs_[var_4_10] == nil then
				local var_4_11 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_10)
				var_4_11.name = var_4_10
				var_4_11.transform.parent = arg_1_1.stage_.transform
				var_4_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_10] = var_4_11
			end

			local var_4_12 = arg_1_1.bgs_.B06a
			local var_4_13 = 0

			if var_4_13 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				local var_4_14 = var_4_12:GetComponent("SpriteRenderer")

				if var_4_14 then
					arg_1_1.var_.alphaOldValueB06a = var_4_14.color.a
					arg_1_1.var_.alphaMatValueB06a = var_4_14
				end

				arg_1_1.var_.alphaOldValueB06a = 0
			end

			local var_4_15 = 1.5

			if var_4_13 <= arg_1_1.time_ and arg_1_1.time_ < var_4_13 + var_4_15 then
				local var_4_16 = (arg_1_1.time_ - var_4_13) / var_4_15
				local var_4_17 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB06a, 1, var_4_16)

				if arg_1_1.var_.alphaMatValueB06a then
					local var_4_18 = arg_1_1.var_.alphaMatValueB06a.color

					var_4_18.a = var_4_17
					arg_1_1.var_.alphaMatValueB06a.color = var_4_18
				end
			end

			if arg_1_1.time_ >= var_4_13 + var_4_15 and arg_1_1.time_ < var_4_13 + var_4_15 + arg_4_0 and arg_1_1.var_.alphaMatValueB06a then
				local var_4_19 = arg_1_1.var_.alphaMatValueB06a
				local var_4_20 = var_4_19.color

				var_4_20.a = 1
				var_4_19.color = var_4_20
			end

			local var_4_21 = 0

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				local var_4_22 = manager.ui.mainCamera.transform.localPosition
				local var_4_23 = Vector3.New(0, 0, 10) + Vector3.New(var_4_22.x, var_4_22.y, 0)
				local var_4_24 = arg_1_1.bgs_.B06a

				var_4_24.transform.localPosition = var_4_23
				var_4_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_25 = var_4_24:GetComponent("SpriteRenderer")

				if var_4_25 and var_4_25.sprite then
					local var_4_26 = (var_4_24.transform.localPosition - var_4_22).z
					local var_4_27 = manager.ui.mainCameraCom_
					local var_4_28 = 2 * var_4_26 * Mathf.Tan(var_4_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_29 = var_4_28 * var_4_27.aspect
					local var_4_30 = var_4_25.sprite.bounds.size.x
					local var_4_31 = var_4_25.sprite.bounds.size.y
					local var_4_32 = var_4_29 / var_4_30
					local var_4_33 = var_4_28 / var_4_31
					local var_4_34 = var_4_33 < var_4_32 and var_4_32 or var_4_33

					var_4_24.transform.localScale = Vector3.New(var_4_34, var_4_34, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B06a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_35 = 0

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_36 = 2

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_37 = 2
			local var_4_38 = 0.25

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_39 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_39:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_40 = arg_1_1:GetWordFromCfg(104061001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 10
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_38 or var_4_38 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_38 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_37 = var_4_37 + 0.3

					if var_4_44 + var_4_37 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_37
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_37 + 0.3
			local var_4_46 = math.max(var_4_38, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play104061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104061002
		arg_8_1.duration_ = 9.57

		local var_8_0 = {
			ja = 7.3,
			ko = 5.466,
			zh = 5.633,
			en = 9.566
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
				arg_8_0:Play104061003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1035ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1035ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1035ui_story"].transform
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.var_.moveOldPos1035ui_story = var_11_5.localPosition
			end

			local var_11_7 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7
				local var_11_9 = Vector3.New(0, -1.05, -5.6)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1035ui_story, var_11_9, var_11_8)

				local var_11_10 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_10.x, var_11_10.y, var_11_10.z)

				local var_11_11 = var_11_5.localEulerAngles

				var_11_11.z = 0
				var_11_11.x = 0
				var_11_5.localEulerAngles = var_11_11
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0, -1.05, -5.6)

				local var_11_12 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_12.x, var_11_12.y, var_11_12.z)

				local var_11_13 = var_11_5.localEulerAngles

				var_11_13.z = 0
				var_11_13.x = 0
				var_11_5.localEulerAngles = var_11_13
			end

			local var_11_14 = arg_8_1.actors_["1035ui_story"]
			local var_11_15 = 0

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect1035ui_story == nil then
				arg_8_1.var_.characterEffect1035ui_story = var_11_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_16 = 0.2

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_16 and not isNil(var_11_14) then
				local var_11_17 = (arg_8_1.time_ - var_11_15) / var_11_16

				if arg_8_1.var_.characterEffect1035ui_story and not isNil(var_11_14) then
					arg_8_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_15 + var_11_16 and arg_8_1.time_ < var_11_15 + var_11_16 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect1035ui_story then
				arg_8_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_11_18 = 0

			if var_11_18 < arg_8_1.time_ and arg_8_1.time_ <= var_11_18 + arg_11_0 then
				arg_8_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action6_1")
			end

			local var_11_19 = 0
			local var_11_20 = 0.675

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_21 = arg_8_1:FormatText(StoryNameCfg[21].name)

				arg_8_1.leftNameTxt_.text = var_11_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_22 = arg_8_1:GetWordFromCfg(104061002)
				local var_11_23 = arg_8_1:FormatText(var_11_22.content)

				arg_8_1.text_.text = var_11_23

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_24 = 27
				local var_11_25 = utf8.len(var_11_23)
				local var_11_26 = var_11_24 <= 0 and var_11_20 or var_11_20 * (var_11_25 / var_11_24)

				if var_11_26 > 0 and var_11_20 < var_11_26 then
					arg_8_1.talkMaxDuration = var_11_26

					if var_11_26 + var_11_19 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_26 + var_11_19
					end
				end

				arg_8_1.text_.text = var_11_23
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061002", "story_v_out_104061.awb") ~= 0 then
					local var_11_27 = manager.audio:GetVoiceLength("story_v_out_104061", "104061002", "story_v_out_104061.awb") / 1000

					if var_11_27 + var_11_19 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_27 + var_11_19
					end

					if var_11_22.prefab_name ~= "" and arg_8_1.actors_[var_11_22.prefab_name] ~= nil then
						local var_11_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_22.prefab_name].transform, "story_v_out_104061", "104061002", "story_v_out_104061.awb")

						arg_8_1:RecordAudio("104061002", var_11_28)
						arg_8_1:RecordAudio("104061002", var_11_28)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104061", "104061002", "story_v_out_104061.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104061", "104061002", "story_v_out_104061.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_29 = math.max(var_11_20, arg_8_1.talkMaxDuration)

			if var_11_19 <= arg_8_1.time_ and arg_8_1.time_ < var_11_19 + var_11_29 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_19) / var_11_29

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_19 + var_11_29 and arg_8_1.time_ < var_11_19 + var_11_29 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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
	Play104061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104061003
		arg_12_1.duration_ = 8.9

		local var_12_0 = {
			ja = 8.9,
			ko = 5.533,
			zh = 5.066,
			en = 7.2
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
				arg_12_0:Play104061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1148ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["1148ui_story"]
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1148ui_story == nil then
				arg_12_1.var_.characterEffect1148ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.1

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 and not isNil(var_15_5) then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7

				if arg_12_1.var_.characterEffect1148ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1148ui_story then
				arg_12_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_15_9 = arg_12_1.actors_["1148ui_story"].transform
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.var_.moveOldPos1148ui_story = var_15_9.localPosition
			end

			local var_15_11 = 0.001

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11
				local var_15_13 = Vector3.New(-0.7, -0.8, -6.2)

				var_15_9.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1148ui_story, var_15_13, var_15_12)

				local var_15_14 = manager.ui.mainCamera.transform.position - var_15_9.position

				var_15_9.forward = Vector3.New(var_15_14.x, var_15_14.y, var_15_14.z)

				local var_15_15 = var_15_9.localEulerAngles

				var_15_15.z = 0
				var_15_15.x = 0
				var_15_9.localEulerAngles = var_15_15
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 then
				var_15_9.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_15_16 = manager.ui.mainCamera.transform.position - var_15_9.position

				var_15_9.forward = Vector3.New(var_15_16.x, var_15_16.y, var_15_16.z)

				local var_15_17 = var_15_9.localEulerAngles

				var_15_17.z = 0
				var_15_17.x = 0
				var_15_9.localEulerAngles = var_15_17
			end

			local var_15_18 = 0

			if var_15_18 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_15_19 = arg_12_1.actors_["1035ui_story"].transform
			local var_15_20 = 0

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1.var_.moveOldPos1035ui_story = var_15_19.localPosition
			end

			local var_15_21 = 0.001

			if var_15_20 <= arg_12_1.time_ and arg_12_1.time_ < var_15_20 + var_15_21 then
				local var_15_22 = (arg_12_1.time_ - var_15_20) / var_15_21
				local var_15_23 = Vector3.New(0, 100, 0)

				var_15_19.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1035ui_story, var_15_23, var_15_22)

				local var_15_24 = manager.ui.mainCamera.transform.position - var_15_19.position

				var_15_19.forward = Vector3.New(var_15_24.x, var_15_24.y, var_15_24.z)

				local var_15_25 = var_15_19.localEulerAngles

				var_15_25.z = 0
				var_15_25.x = 0
				var_15_19.localEulerAngles = var_15_25
			end

			if arg_12_1.time_ >= var_15_20 + var_15_21 and arg_12_1.time_ < var_15_20 + var_15_21 + arg_15_0 then
				var_15_19.localPosition = Vector3.New(0, 100, 0)

				local var_15_26 = manager.ui.mainCamera.transform.position - var_15_19.position

				var_15_19.forward = Vector3.New(var_15_26.x, var_15_26.y, var_15_26.z)

				local var_15_27 = var_15_19.localEulerAngles

				var_15_27.z = 0
				var_15_27.x = 0
				var_15_19.localEulerAngles = var_15_27
			end

			local var_15_28 = 0

			if var_15_28 < arg_12_1.time_ and arg_12_1.time_ <= var_15_28 + arg_15_0 then
				arg_12_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_15_29 = 0
			local var_15_30 = 0.6

			if var_15_29 < arg_12_1.time_ and arg_12_1.time_ <= var_15_29 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_31 = arg_12_1:FormatText(StoryNameCfg[8].name)

				arg_12_1.leftNameTxt_.text = var_15_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_32 = arg_12_1:GetWordFromCfg(104061003)
				local var_15_33 = arg_12_1:FormatText(var_15_32.content)

				arg_12_1.text_.text = var_15_33

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_34 = 24
				local var_15_35 = utf8.len(var_15_33)
				local var_15_36 = var_15_34 <= 0 and var_15_30 or var_15_30 * (var_15_35 / var_15_34)

				if var_15_36 > 0 and var_15_30 < var_15_36 then
					arg_12_1.talkMaxDuration = var_15_36

					if var_15_36 + var_15_29 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_36 + var_15_29
					end
				end

				arg_12_1.text_.text = var_15_33
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061003", "story_v_out_104061.awb") ~= 0 then
					local var_15_37 = manager.audio:GetVoiceLength("story_v_out_104061", "104061003", "story_v_out_104061.awb") / 1000

					if var_15_37 + var_15_29 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_37 + var_15_29
					end

					if var_15_32.prefab_name ~= "" and arg_12_1.actors_[var_15_32.prefab_name] ~= nil then
						local var_15_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_32.prefab_name].transform, "story_v_out_104061", "104061003", "story_v_out_104061.awb")

						arg_12_1:RecordAudio("104061003", var_15_38)
						arg_12_1:RecordAudio("104061003", var_15_38)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104061", "104061003", "story_v_out_104061.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104061", "104061003", "story_v_out_104061.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_39 = math.max(var_15_30, arg_12_1.talkMaxDuration)

			if var_15_29 <= arg_12_1.time_ and arg_12_1.time_ < var_15_29 + var_15_39 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_29) / var_15_39

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_29 + var_15_39 and arg_12_1.time_ < var_15_29 + var_15_39 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play104061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104061004
		arg_16_1.duration_ = 4.1

		local var_16_0 = {
			ja = 3.766,
			ko = 2.466,
			zh = 4.1,
			en = 2.933
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
				arg_16_0:Play104061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1148ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos1148ui_story = var_19_0.localPosition
			end

			local var_19_2 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2
				local var_19_4 = Vector3.New(0, 100, 0)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1148ui_story, var_19_4, var_19_3)

				local var_19_5 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_5.x, var_19_5.y, var_19_5.z)

				local var_19_6 = var_19_0.localEulerAngles

				var_19_6.z = 0
				var_19_6.x = 0
				var_19_0.localEulerAngles = var_19_6
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, 100, 0)

				local var_19_7 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_7.x, var_19_7.y, var_19_7.z)

				local var_19_8 = var_19_0.localEulerAngles

				var_19_8.z = 0
				var_19_8.x = 0
				var_19_0.localEulerAngles = var_19_8
			end

			local var_19_9 = arg_16_1.actors_["1035ui_story"].transform
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.var_.moveOldPos1035ui_story = var_19_9.localPosition
			end

			local var_19_11 = 0.001

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11
				local var_19_13 = Vector3.New(0, -1.05, -5.6)

				var_19_9.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1035ui_story, var_19_13, var_19_12)

				local var_19_14 = manager.ui.mainCamera.transform.position - var_19_9.position

				var_19_9.forward = Vector3.New(var_19_14.x, var_19_14.y, var_19_14.z)

				local var_19_15 = var_19_9.localEulerAngles

				var_19_15.z = 0
				var_19_15.x = 0
				var_19_9.localEulerAngles = var_19_15
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 then
				var_19_9.localPosition = Vector3.New(0, -1.05, -5.6)

				local var_19_16 = manager.ui.mainCamera.transform.position - var_19_9.position

				var_19_9.forward = Vector3.New(var_19_16.x, var_19_16.y, var_19_16.z)

				local var_19_17 = var_19_9.localEulerAngles

				var_19_17.z = 0
				var_19_17.x = 0
				var_19_9.localEulerAngles = var_19_17
			end

			local var_19_18 = 0

			if var_19_18 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action7_1")
			end

			local var_19_19 = arg_16_1.actors_["1035ui_story"]
			local var_19_20 = 0

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 and not isNil(var_19_19) and arg_16_1.var_.characterEffect1035ui_story == nil then
				arg_16_1.var_.characterEffect1035ui_story = var_19_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_21 = 0.2

			if var_19_20 <= arg_16_1.time_ and arg_16_1.time_ < var_19_20 + var_19_21 and not isNil(var_19_19) then
				local var_19_22 = (arg_16_1.time_ - var_19_20) / var_19_21

				if arg_16_1.var_.characterEffect1035ui_story and not isNil(var_19_19) then
					arg_16_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_20 + var_19_21 and arg_16_1.time_ < var_19_20 + var_19_21 + arg_19_0 and not isNil(var_19_19) and arg_16_1.var_.characterEffect1035ui_story then
				arg_16_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_19_23 = 0
			local var_19_24 = 0.175

			if var_19_23 < arg_16_1.time_ and arg_16_1.time_ <= var_19_23 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_25 = arg_16_1:FormatText(StoryNameCfg[21].name)

				arg_16_1.leftNameTxt_.text = var_19_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_26 = arg_16_1:GetWordFromCfg(104061004)
				local var_19_27 = arg_16_1:FormatText(var_19_26.content)

				arg_16_1.text_.text = var_19_27

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_28 = 7
				local var_19_29 = utf8.len(var_19_27)
				local var_19_30 = var_19_28 <= 0 and var_19_24 or var_19_24 * (var_19_29 / var_19_28)

				if var_19_30 > 0 and var_19_24 < var_19_30 then
					arg_16_1.talkMaxDuration = var_19_30

					if var_19_30 + var_19_23 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_30 + var_19_23
					end
				end

				arg_16_1.text_.text = var_19_27
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061004", "story_v_out_104061.awb") ~= 0 then
					local var_19_31 = manager.audio:GetVoiceLength("story_v_out_104061", "104061004", "story_v_out_104061.awb") / 1000

					if var_19_31 + var_19_23 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_31 + var_19_23
					end

					if var_19_26.prefab_name ~= "" and arg_16_1.actors_[var_19_26.prefab_name] ~= nil then
						local var_19_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_26.prefab_name].transform, "story_v_out_104061", "104061004", "story_v_out_104061.awb")

						arg_16_1:RecordAudio("104061004", var_19_32)
						arg_16_1:RecordAudio("104061004", var_19_32)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104061", "104061004", "story_v_out_104061.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104061", "104061004", "story_v_out_104061.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_33 = math.max(var_19_24, arg_16_1.talkMaxDuration)

			if var_19_23 <= arg_16_1.time_ and arg_16_1.time_ < var_19_23 + var_19_33 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_23) / var_19_33

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_23 + var_19_33 and arg_16_1.time_ < var_19_23 + var_19_33 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play104061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104061005
		arg_20_1.duration_ = 8.2

		local var_20_0 = {
			ja = 7.533,
			ko = 6.1,
			zh = 8.2,
			en = 5.7
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
				arg_20_0:Play104061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "1059ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_20_1.stage_.transform)

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

			local var_23_5 = arg_20_1.actors_["1059ui_story"]
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1059ui_story == nil then
				arg_20_1.var_.characterEffect1059ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_7 = 0.1

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 and not isNil(var_23_5) then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7

				if arg_20_1.var_.characterEffect1059ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1059ui_story then
				arg_20_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_23_9 = arg_20_1.actors_["1148ui_story"].transform
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.var_.moveOldPos1148ui_story = var_23_9.localPosition
			end

			local var_23_11 = 0.001

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11
				local var_23_13 = Vector3.New(0, 100, 0)

				var_23_9.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1148ui_story, var_23_13, var_23_12)

				local var_23_14 = manager.ui.mainCamera.transform.position - var_23_9.position

				var_23_9.forward = Vector3.New(var_23_14.x, var_23_14.y, var_23_14.z)

				local var_23_15 = var_23_9.localEulerAngles

				var_23_15.z = 0
				var_23_15.x = 0
				var_23_9.localEulerAngles = var_23_15
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 then
				var_23_9.localPosition = Vector3.New(0, 100, 0)

				local var_23_16 = manager.ui.mainCamera.transform.position - var_23_9.position

				var_23_9.forward = Vector3.New(var_23_16.x, var_23_16.y, var_23_16.z)

				local var_23_17 = var_23_9.localEulerAngles

				var_23_17.z = 0
				var_23_17.x = 0
				var_23_9.localEulerAngles = var_23_17
			end

			local var_23_18 = arg_20_1.actors_["1059ui_story"].transform
			local var_23_19 = 0

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1.var_.moveOldPos1059ui_story = var_23_18.localPosition
			end

			local var_23_20 = 0.001

			if var_23_19 <= arg_20_1.time_ and arg_20_1.time_ < var_23_19 + var_23_20 then
				local var_23_21 = (arg_20_1.time_ - var_23_19) / var_23_20
				local var_23_22 = Vector3.New(0, -1.05, -6)

				var_23_18.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1059ui_story, var_23_22, var_23_21)

				local var_23_23 = manager.ui.mainCamera.transform.position - var_23_18.position

				var_23_18.forward = Vector3.New(var_23_23.x, var_23_23.y, var_23_23.z)

				local var_23_24 = var_23_18.localEulerAngles

				var_23_24.z = 0
				var_23_24.x = 0
				var_23_18.localEulerAngles = var_23_24
			end

			if arg_20_1.time_ >= var_23_19 + var_23_20 and arg_20_1.time_ < var_23_19 + var_23_20 + arg_23_0 then
				var_23_18.localPosition = Vector3.New(0, -1.05, -6)

				local var_23_25 = manager.ui.mainCamera.transform.position - var_23_18.position

				var_23_18.forward = Vector3.New(var_23_25.x, var_23_25.y, var_23_25.z)

				local var_23_26 = var_23_18.localEulerAngles

				var_23_26.z = 0
				var_23_26.x = 0
				var_23_18.localEulerAngles = var_23_26
			end

			local var_23_27 = 0

			if var_23_27 < arg_20_1.time_ and arg_20_1.time_ <= var_23_27 + arg_23_0 then
				arg_20_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			local var_23_28 = arg_20_1.actors_["1035ui_story"].transform
			local var_23_29 = 0

			if var_23_29 < arg_20_1.time_ and arg_20_1.time_ <= var_23_29 + arg_23_0 then
				arg_20_1.var_.moveOldPos1035ui_story = var_23_28.localPosition
			end

			local var_23_30 = 0.001

			if var_23_29 <= arg_20_1.time_ and arg_20_1.time_ < var_23_29 + var_23_30 then
				local var_23_31 = (arg_20_1.time_ - var_23_29) / var_23_30
				local var_23_32 = Vector3.New(0, 100, 0)

				var_23_28.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1035ui_story, var_23_32, var_23_31)

				local var_23_33 = manager.ui.mainCamera.transform.position - var_23_28.position

				var_23_28.forward = Vector3.New(var_23_33.x, var_23_33.y, var_23_33.z)

				local var_23_34 = var_23_28.localEulerAngles

				var_23_34.z = 0
				var_23_34.x = 0
				var_23_28.localEulerAngles = var_23_34
			end

			if arg_20_1.time_ >= var_23_29 + var_23_30 and arg_20_1.time_ < var_23_29 + var_23_30 + arg_23_0 then
				var_23_28.localPosition = Vector3.New(0, 100, 0)

				local var_23_35 = manager.ui.mainCamera.transform.position - var_23_28.position

				var_23_28.forward = Vector3.New(var_23_35.x, var_23_35.y, var_23_35.z)

				local var_23_36 = var_23_28.localEulerAngles

				var_23_36.z = 0
				var_23_36.x = 0
				var_23_28.localEulerAngles = var_23_36
			end

			local var_23_37 = 0

			if var_23_37 < arg_20_1.time_ and arg_20_1.time_ <= var_23_37 + arg_23_0 then
				arg_20_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_23_38 = 0
			local var_23_39 = 0.825

			if var_23_38 < arg_20_1.time_ and arg_20_1.time_ <= var_23_38 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_40 = arg_20_1:FormatText(StoryNameCfg[28].name)

				arg_20_1.leftNameTxt_.text = var_23_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_41 = arg_20_1:GetWordFromCfg(104061005)
				local var_23_42 = arg_20_1:FormatText(var_23_41.content)

				arg_20_1.text_.text = var_23_42

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_43 = 33
				local var_23_44 = utf8.len(var_23_42)
				local var_23_45 = var_23_43 <= 0 and var_23_39 or var_23_39 * (var_23_44 / var_23_43)

				if var_23_45 > 0 and var_23_39 < var_23_45 then
					arg_20_1.talkMaxDuration = var_23_45

					if var_23_45 + var_23_38 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_45 + var_23_38
					end
				end

				arg_20_1.text_.text = var_23_42
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061005", "story_v_out_104061.awb") ~= 0 then
					local var_23_46 = manager.audio:GetVoiceLength("story_v_out_104061", "104061005", "story_v_out_104061.awb") / 1000

					if var_23_46 + var_23_38 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_46 + var_23_38
					end

					if var_23_41.prefab_name ~= "" and arg_20_1.actors_[var_23_41.prefab_name] ~= nil then
						local var_23_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_41.prefab_name].transform, "story_v_out_104061", "104061005", "story_v_out_104061.awb")

						arg_20_1:RecordAudio("104061005", var_23_47)
						arg_20_1:RecordAudio("104061005", var_23_47)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104061", "104061005", "story_v_out_104061.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104061", "104061005", "story_v_out_104061.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_48 = math.max(var_23_39, arg_20_1.talkMaxDuration)

			if var_23_38 <= arg_20_1.time_ and arg_20_1.time_ < var_23_38 + var_23_48 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_38) / var_23_48

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_38 + var_23_48 and arg_20_1.time_ < var_23_38 + var_23_48 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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

		arg_20_1:InitPlayNodeList()
	end,
	Play104061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104061006
		arg_24_1.duration_ = 3.63

		local var_24_0 = {
			ja = 3.633,
			ko = 3.6,
			zh = 2.666,
			en = 3.166
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
				arg_24_0:Play104061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "2020_tpose"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "2020_tpose")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_24_1.stage_.transform)

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

			local var_27_5 = arg_24_1.actors_["2020_tpose"]
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect2020_tpose == nil then
				arg_24_1.var_.characterEffect2020_tpose = var_27_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_7 = 0.1

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 and not isNil(var_27_5) then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7

				if arg_24_1.var_.characterEffect2020_tpose and not isNil(var_27_5) then
					arg_24_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect2020_tpose then
				arg_24_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_27_9 = arg_24_1.actors_["1059ui_story"]
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1059ui_story == nil then
				arg_24_1.var_.characterEffect1059ui_story = var_27_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_11 = 0.1

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 and not isNil(var_27_9) then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11

				if arg_24_1.var_.characterEffect1059ui_story and not isNil(var_27_9) then
					local var_27_13 = Mathf.Lerp(0, 0.5, var_27_12)

					arg_24_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1059ui_story.fillRatio = var_27_13
				end
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1059ui_story then
				local var_27_14 = 0.5

				arg_24_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1059ui_story.fillRatio = var_27_14
			end

			local var_27_15 = arg_24_1.actors_["1059ui_story"].transform
			local var_27_16 = 0

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.var_.moveOldPos1059ui_story = var_27_15.localPosition
			end

			local var_27_17 = 0.001

			if var_27_16 <= arg_24_1.time_ and arg_24_1.time_ < var_27_16 + var_27_17 then
				local var_27_18 = (arg_24_1.time_ - var_27_16) / var_27_17
				local var_27_19 = Vector3.New(0, 100, 0)

				var_27_15.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1059ui_story, var_27_19, var_27_18)

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

			local var_27_24 = arg_24_1.actors_["2020_tpose"].transform
			local var_27_25 = 0

			if var_27_25 < arg_24_1.time_ and arg_24_1.time_ <= var_27_25 + arg_27_0 then
				arg_24_1.var_.moveOldPos2020_tpose = var_27_24.localPosition

				local var_27_26 = GameObjectTools.GetOrAddComponent(var_27_24.gameObject, typeof(DynamicBoneHelper))

				if var_27_26 then
					var_27_26:EnableDynamicBone(false)
				end
			end

			local var_27_27 = 0.001

			if var_27_25 <= arg_24_1.time_ and arg_24_1.time_ < var_27_25 + var_27_27 then
				local var_27_28 = (arg_24_1.time_ - var_27_25) / var_27_27
				local var_27_29 = Vector3.New(-0.7, -1.2, -4.1)

				var_27_24.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos2020_tpose, var_27_29, var_27_28)

				local var_27_30 = manager.ui.mainCamera.transform.position - var_27_24.position

				var_27_24.forward = Vector3.New(var_27_30.x, var_27_30.y, var_27_30.z)

				local var_27_31 = var_27_24.localEulerAngles

				var_27_31.z = 0
				var_27_31.x = 0
				var_27_24.localEulerAngles = var_27_31
			end

			if arg_24_1.time_ >= var_27_25 + var_27_27 and arg_24_1.time_ < var_27_25 + var_27_27 + arg_27_0 then
				var_27_24.localPosition = Vector3.New(-0.7, -1.2, -4.1)

				local var_27_32 = manager.ui.mainCamera.transform.position - var_27_24.position

				var_27_24.forward = Vector3.New(var_27_32.x, var_27_32.y, var_27_32.z)

				local var_27_33 = var_27_24.localEulerAngles

				var_27_33.z = 0
				var_27_33.x = 0
				var_27_24.localEulerAngles = var_27_33

				local var_27_34 = GameObjectTools.GetOrAddComponent(var_27_24.gameObject, typeof(DynamicBoneHelper))

				if var_27_34 then
					var_27_34:EnableDynamicBone(true)
				end
			end

			local var_27_35 = 0

			if var_27_35 < arg_24_1.time_ and arg_24_1.time_ <= var_27_35 + arg_27_0 then
				arg_24_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_27_36 = 0
			local var_27_37 = 0.375

			if var_27_36 < arg_24_1.time_ and arg_24_1.time_ <= var_27_36 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_38 = arg_24_1:FormatText(StoryNameCfg[34].name)

				arg_24_1.leftNameTxt_.text = var_27_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_39 = arg_24_1:GetWordFromCfg(104061006)
				local var_27_40 = arg_24_1:FormatText(var_27_39.content)

				arg_24_1.text_.text = var_27_40

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_41 = 15
				local var_27_42 = utf8.len(var_27_40)
				local var_27_43 = var_27_41 <= 0 and var_27_37 or var_27_37 * (var_27_42 / var_27_41)

				if var_27_43 > 0 and var_27_37 < var_27_43 then
					arg_24_1.talkMaxDuration = var_27_43

					if var_27_43 + var_27_36 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_43 + var_27_36
					end
				end

				arg_24_1.text_.text = var_27_40
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061006", "story_v_out_104061.awb") ~= 0 then
					local var_27_44 = manager.audio:GetVoiceLength("story_v_out_104061", "104061006", "story_v_out_104061.awb") / 1000

					if var_27_44 + var_27_36 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_44 + var_27_36
					end

					if var_27_39.prefab_name ~= "" and arg_24_1.actors_[var_27_39.prefab_name] ~= nil then
						local var_27_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_39.prefab_name].transform, "story_v_out_104061", "104061006", "story_v_out_104061.awb")

						arg_24_1:RecordAudio("104061006", var_27_45)
						arg_24_1:RecordAudio("104061006", var_27_45)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_104061", "104061006", "story_v_out_104061.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_104061", "104061006", "story_v_out_104061.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_46 = math.max(var_27_37, arg_24_1.talkMaxDuration)

			if var_27_36 <= arg_24_1.time_ and arg_24_1.time_ < var_27_36 + var_27_46 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_36) / var_27_46

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_36 + var_27_46 and arg_24_1.time_ < var_27_36 + var_27_46 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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
				actorName = "2020_tpose",
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
	Play104061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104061007
		arg_28_1.duration_ = 9

		local var_28_0 = {
			ja = 4.8,
			ko = 6.666,
			zh = 9,
			en = 6.733
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
				arg_28_0:Play104061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1035ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos1035ui_story = var_31_0.localPosition
			end

			local var_31_2 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2
				local var_31_4 = Vector3.New(0.7, -1.05, -5.6)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1035ui_story, var_31_4, var_31_3)

				local var_31_5 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_5.x, var_31_5.y, var_31_5.z)

				local var_31_6 = var_31_0.localEulerAngles

				var_31_6.z = 0
				var_31_6.x = 0
				var_31_0.localEulerAngles = var_31_6
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0.7, -1.05, -5.6)

				local var_31_7 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_7.x, var_31_7.y, var_31_7.z)

				local var_31_8 = var_31_0.localEulerAngles

				var_31_8.z = 0
				var_31_8.x = 0
				var_31_0.localEulerAngles = var_31_8
			end

			local var_31_9 = 0

			if var_31_9 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
				arg_28_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action1_1")
			end

			local var_31_10 = arg_28_1.actors_["2020_tpose"]
			local var_31_11 = 0

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 and not isNil(var_31_10) and arg_28_1.var_.characterEffect2020_tpose == nil then
				arg_28_1.var_.characterEffect2020_tpose = var_31_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_12 = 0.2

			if var_31_11 <= arg_28_1.time_ and arg_28_1.time_ < var_31_11 + var_31_12 and not isNil(var_31_10) then
				local var_31_13 = (arg_28_1.time_ - var_31_11) / var_31_12

				if arg_28_1.var_.characterEffect2020_tpose and not isNil(var_31_10) then
					local var_31_14 = Mathf.Lerp(0, 0.5, var_31_13)

					arg_28_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_28_1.var_.characterEffect2020_tpose.fillRatio = var_31_14
				end
			end

			if arg_28_1.time_ >= var_31_11 + var_31_12 and arg_28_1.time_ < var_31_11 + var_31_12 + arg_31_0 and not isNil(var_31_10) and arg_28_1.var_.characterEffect2020_tpose then
				local var_31_15 = 0.5

				arg_28_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_28_1.var_.characterEffect2020_tpose.fillRatio = var_31_15
			end

			local var_31_16 = arg_28_1.actors_["1035ui_story"]
			local var_31_17 = 0

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect1035ui_story == nil then
				arg_28_1.var_.characterEffect1035ui_story = var_31_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_18 = 0.2

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_18 and not isNil(var_31_16) then
				local var_31_19 = (arg_28_1.time_ - var_31_17) / var_31_18

				if arg_28_1.var_.characterEffect1035ui_story and not isNil(var_31_16) then
					arg_28_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_17 + var_31_18 and arg_28_1.time_ < var_31_17 + var_31_18 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect1035ui_story then
				arg_28_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_31_20 = 0
			local var_31_21 = 0.775

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_22 = arg_28_1:FormatText(StoryNameCfg[21].name)

				arg_28_1.leftNameTxt_.text = var_31_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_23 = arg_28_1:GetWordFromCfg(104061007)
				local var_31_24 = arg_28_1:FormatText(var_31_23.content)

				arg_28_1.text_.text = var_31_24

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_25 = 30
				local var_31_26 = utf8.len(var_31_24)
				local var_31_27 = var_31_25 <= 0 and var_31_21 or var_31_21 * (var_31_26 / var_31_25)

				if var_31_27 > 0 and var_31_21 < var_31_27 then
					arg_28_1.talkMaxDuration = var_31_27

					if var_31_27 + var_31_20 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_27 + var_31_20
					end
				end

				arg_28_1.text_.text = var_31_24
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061007", "story_v_out_104061.awb") ~= 0 then
					local var_31_28 = manager.audio:GetVoiceLength("story_v_out_104061", "104061007", "story_v_out_104061.awb") / 1000

					if var_31_28 + var_31_20 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_28 + var_31_20
					end

					if var_31_23.prefab_name ~= "" and arg_28_1.actors_[var_31_23.prefab_name] ~= nil then
						local var_31_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_23.prefab_name].transform, "story_v_out_104061", "104061007", "story_v_out_104061.awb")

						arg_28_1:RecordAudio("104061007", var_31_29)
						arg_28_1:RecordAudio("104061007", var_31_29)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_104061", "104061007", "story_v_out_104061.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_104061", "104061007", "story_v_out_104061.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_30 = math.max(var_31_21, arg_28_1.talkMaxDuration)

			if var_31_20 <= arg_28_1.time_ and arg_28_1.time_ < var_31_20 + var_31_30 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_20) / var_31_30

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_20 + var_31_30 and arg_28_1.time_ < var_31_20 + var_31_30 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play104061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104061008
		arg_32_1.duration_ = 6.73

		local var_32_0 = {
			ja = 6.733,
			ko = 4.8,
			zh = 4,
			en = 5.766
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
				arg_32_0:Play104061009(arg_32_1)
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

			local var_35_4 = arg_32_1.actors_["2020_tpose"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect2020_tpose == nil then
				arg_32_1.var_.characterEffect2020_tpose = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.2

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect2020_tpose and not isNil(var_35_4) then
					arg_32_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect2020_tpose then
				arg_32_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_35_8 = arg_32_1.actors_["1035ui_story"]
			local var_35_9 = 0

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.characterEffect1035ui_story == nil then
				arg_32_1.var_.characterEffect1035ui_story = var_35_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_10 = 0.2

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_10 and not isNil(var_35_8) then
				local var_35_11 = (arg_32_1.time_ - var_35_9) / var_35_10

				if arg_32_1.var_.characterEffect1035ui_story and not isNil(var_35_8) then
					local var_35_12 = Mathf.Lerp(0, 0.5, var_35_11)

					arg_32_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1035ui_story.fillRatio = var_35_12
				end
			end

			if arg_32_1.time_ >= var_35_9 + var_35_10 and arg_32_1.time_ < var_35_9 + var_35_10 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.characterEffect1035ui_story then
				local var_35_13 = 0.5

				arg_32_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1035ui_story.fillRatio = var_35_13
			end

			local var_35_14 = 0
			local var_35_15 = 0.55

			if var_35_14 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_16 = arg_32_1:FormatText(StoryNameCfg[34].name)

				arg_32_1.leftNameTxt_.text = var_35_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_17 = arg_32_1:GetWordFromCfg(104061008)
				local var_35_18 = arg_32_1:FormatText(var_35_17.content)

				arg_32_1.text_.text = var_35_18

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_19 = 22
				local var_35_20 = utf8.len(var_35_18)
				local var_35_21 = var_35_19 <= 0 and var_35_15 or var_35_15 * (var_35_20 / var_35_19)

				if var_35_21 > 0 and var_35_15 < var_35_21 then
					arg_32_1.talkMaxDuration = var_35_21

					if var_35_21 + var_35_14 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_21 + var_35_14
					end
				end

				arg_32_1.text_.text = var_35_18
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061008", "story_v_out_104061.awb") ~= 0 then
					local var_35_22 = manager.audio:GetVoiceLength("story_v_out_104061", "104061008", "story_v_out_104061.awb") / 1000

					if var_35_22 + var_35_14 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_22 + var_35_14
					end

					if var_35_17.prefab_name ~= "" and arg_32_1.actors_[var_35_17.prefab_name] ~= nil then
						local var_35_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_17.prefab_name].transform, "story_v_out_104061", "104061008", "story_v_out_104061.awb")

						arg_32_1:RecordAudio("104061008", var_35_23)
						arg_32_1:RecordAudio("104061008", var_35_23)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104061", "104061008", "story_v_out_104061.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104061", "104061008", "story_v_out_104061.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_24 = math.max(var_35_15, arg_32_1.talkMaxDuration)

			if var_35_14 <= arg_32_1.time_ and arg_32_1.time_ < var_35_14 + var_35_24 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_14) / var_35_24

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_14 + var_35_24 and arg_32_1.time_ < var_35_14 + var_35_24 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play104061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104061009
		arg_36_1.duration_ = 4.6

		local var_36_0 = {
			ja = 3.066,
			ko = 2.666,
			zh = 3.6,
			en = 4.6
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
				arg_36_0:Play104061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["2020_tpose"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect2020_tpose == nil then
				arg_36_1.var_.characterEffect2020_tpose = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect2020_tpose and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_36_1.var_.characterEffect2020_tpose.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect2020_tpose then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_36_1.var_.characterEffect2020_tpose.fillRatio = var_39_5
			end

			local var_39_6 = arg_36_1.actors_["1035ui_story"]
			local var_39_7 = 0

			if var_39_7 < arg_36_1.time_ and arg_36_1.time_ <= var_39_7 + arg_39_0 and not isNil(var_39_6) and arg_36_1.var_.characterEffect1035ui_story == nil then
				arg_36_1.var_.characterEffect1035ui_story = var_39_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_8 = 0.1

			if var_39_7 <= arg_36_1.time_ and arg_36_1.time_ < var_39_7 + var_39_8 and not isNil(var_39_6) then
				local var_39_9 = (arg_36_1.time_ - var_39_7) / var_39_8

				if arg_36_1.var_.characterEffect1035ui_story and not isNil(var_39_6) then
					arg_36_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_7 + var_39_8 and arg_36_1.time_ < var_39_7 + var_39_8 + arg_39_0 and not isNil(var_39_6) and arg_36_1.var_.characterEffect1035ui_story then
				arg_36_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_39_10 = 0
			local var_39_11 = 0.275

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_12 = arg_36_1:FormatText(StoryNameCfg[21].name)

				arg_36_1.leftNameTxt_.text = var_39_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_13 = arg_36_1:GetWordFromCfg(104061009)
				local var_39_14 = arg_36_1:FormatText(var_39_13.content)

				arg_36_1.text_.text = var_39_14

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 11
				local var_39_16 = utf8.len(var_39_14)
				local var_39_17 = var_39_15 <= 0 and var_39_11 or var_39_11 * (var_39_16 / var_39_15)

				if var_39_17 > 0 and var_39_11 < var_39_17 then
					arg_36_1.talkMaxDuration = var_39_17

					if var_39_17 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_10
					end
				end

				arg_36_1.text_.text = var_39_14
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061009", "story_v_out_104061.awb") ~= 0 then
					local var_39_18 = manager.audio:GetVoiceLength("story_v_out_104061", "104061009", "story_v_out_104061.awb") / 1000

					if var_39_18 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_10
					end

					if var_39_13.prefab_name ~= "" and arg_36_1.actors_[var_39_13.prefab_name] ~= nil then
						local var_39_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_13.prefab_name].transform, "story_v_out_104061", "104061009", "story_v_out_104061.awb")

						arg_36_1:RecordAudio("104061009", var_39_19)
						arg_36_1:RecordAudio("104061009", var_39_19)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104061", "104061009", "story_v_out_104061.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104061", "104061009", "story_v_out_104061.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_20 = math.max(var_39_11, arg_36_1.talkMaxDuration)

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_20 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_10) / var_39_20

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_10 + var_39_20 and arg_36_1.time_ < var_39_10 + var_39_20 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play104061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104061010
		arg_40_1.duration_ = 6.93

		local var_40_0 = {
			ja = 6.933,
			ko = 4.366,
			zh = 3.9,
			en = 4.433
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
				arg_40_0:Play104061011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1148ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1148ui_story == nil then
				arg_40_1.var_.characterEffect1148ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1148ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1148ui_story then
				arg_40_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["2020_tpose"].transform
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.var_.moveOldPos2020_tpose = var_43_4.localPosition

				local var_43_6 = GameObjectTools.GetOrAddComponent(var_43_4.gameObject, typeof(DynamicBoneHelper))

				if var_43_6 then
					var_43_6:EnableDynamicBone(false)
				end
			end

			local var_43_7 = 0.001

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_7 then
				local var_43_8 = (arg_40_1.time_ - var_43_5) / var_43_7
				local var_43_9 = Vector3.New(0, 100, 0)

				var_43_4.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos2020_tpose, var_43_9, var_43_8)

				local var_43_10 = manager.ui.mainCamera.transform.position - var_43_4.position

				var_43_4.forward = Vector3.New(var_43_10.x, var_43_10.y, var_43_10.z)

				local var_43_11 = var_43_4.localEulerAngles

				var_43_11.z = 0
				var_43_11.x = 0
				var_43_4.localEulerAngles = var_43_11
			end

			if arg_40_1.time_ >= var_43_5 + var_43_7 and arg_40_1.time_ < var_43_5 + var_43_7 + arg_43_0 then
				var_43_4.localPosition = Vector3.New(0, 100, 0)

				local var_43_12 = manager.ui.mainCamera.transform.position - var_43_4.position

				var_43_4.forward = Vector3.New(var_43_12.x, var_43_12.y, var_43_12.z)

				local var_43_13 = var_43_4.localEulerAngles

				var_43_13.z = 0
				var_43_13.x = 0
				var_43_4.localEulerAngles = var_43_13

				local var_43_14 = GameObjectTools.GetOrAddComponent(var_43_4.gameObject, typeof(DynamicBoneHelper))

				if var_43_14 then
					var_43_14:EnableDynamicBone(true)
				end
			end

			local var_43_15 = arg_40_1.actors_["1148ui_story"].transform
			local var_43_16 = 0

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.var_.moveOldPos1148ui_story = var_43_15.localPosition
			end

			local var_43_17 = 0.001

			if var_43_16 <= arg_40_1.time_ and arg_40_1.time_ < var_43_16 + var_43_17 then
				local var_43_18 = (arg_40_1.time_ - var_43_16) / var_43_17
				local var_43_19 = Vector3.New(0, -0.8, -6.2)

				var_43_15.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1148ui_story, var_43_19, var_43_18)

				local var_43_20 = manager.ui.mainCamera.transform.position - var_43_15.position

				var_43_15.forward = Vector3.New(var_43_20.x, var_43_20.y, var_43_20.z)

				local var_43_21 = var_43_15.localEulerAngles

				var_43_21.z = 0
				var_43_21.x = 0
				var_43_15.localEulerAngles = var_43_21
			end

			if arg_40_1.time_ >= var_43_16 + var_43_17 and arg_40_1.time_ < var_43_16 + var_43_17 + arg_43_0 then
				var_43_15.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_43_22 = manager.ui.mainCamera.transform.position - var_43_15.position

				var_43_15.forward = Vector3.New(var_43_22.x, var_43_22.y, var_43_22.z)

				local var_43_23 = var_43_15.localEulerAngles

				var_43_23.z = 0
				var_43_23.x = 0
				var_43_15.localEulerAngles = var_43_23
			end

			local var_43_24 = 0

			if var_43_24 < arg_40_1.time_ and arg_40_1.time_ <= var_43_24 + arg_43_0 then
				arg_40_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_43_25 = arg_40_1.actors_["1035ui_story"].transform
			local var_43_26 = 0

			if var_43_26 < arg_40_1.time_ and arg_40_1.time_ <= var_43_26 + arg_43_0 then
				arg_40_1.var_.moveOldPos1035ui_story = var_43_25.localPosition
			end

			local var_43_27 = 0.001

			if var_43_26 <= arg_40_1.time_ and arg_40_1.time_ < var_43_26 + var_43_27 then
				local var_43_28 = (arg_40_1.time_ - var_43_26) / var_43_27
				local var_43_29 = Vector3.New(0, 100, 0)

				var_43_25.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1035ui_story, var_43_29, var_43_28)

				local var_43_30 = manager.ui.mainCamera.transform.position - var_43_25.position

				var_43_25.forward = Vector3.New(var_43_30.x, var_43_30.y, var_43_30.z)

				local var_43_31 = var_43_25.localEulerAngles

				var_43_31.z = 0
				var_43_31.x = 0
				var_43_25.localEulerAngles = var_43_31
			end

			if arg_40_1.time_ >= var_43_26 + var_43_27 and arg_40_1.time_ < var_43_26 + var_43_27 + arg_43_0 then
				var_43_25.localPosition = Vector3.New(0, 100, 0)

				local var_43_32 = manager.ui.mainCamera.transform.position - var_43_25.position

				var_43_25.forward = Vector3.New(var_43_32.x, var_43_32.y, var_43_32.z)

				local var_43_33 = var_43_25.localEulerAngles

				var_43_33.z = 0
				var_43_33.x = 0
				var_43_25.localEulerAngles = var_43_33
			end

			local var_43_34 = 0

			if var_43_34 < arg_40_1.time_ and arg_40_1.time_ <= var_43_34 + arg_43_0 then
				arg_40_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_43_35 = 0
			local var_43_36 = 0.3

			if var_43_35 < arg_40_1.time_ and arg_40_1.time_ <= var_43_35 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_37 = arg_40_1:FormatText(StoryNameCfg[8].name)

				arg_40_1.leftNameTxt_.text = var_43_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_38 = arg_40_1:GetWordFromCfg(104061010)
				local var_43_39 = arg_40_1:FormatText(var_43_38.content)

				arg_40_1.text_.text = var_43_39

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_40 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061010", "story_v_out_104061.awb") ~= 0 then
					local var_43_43 = manager.audio:GetVoiceLength("story_v_out_104061", "104061010", "story_v_out_104061.awb") / 1000

					if var_43_43 + var_43_35 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_43 + var_43_35
					end

					if var_43_38.prefab_name ~= "" and arg_40_1.actors_[var_43_38.prefab_name] ~= nil then
						local var_43_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_38.prefab_name].transform, "story_v_out_104061", "104061010", "story_v_out_104061.awb")

						arg_40_1:RecordAudio("104061010", var_43_44)
						arg_40_1:RecordAudio("104061010", var_43_44)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_104061", "104061010", "story_v_out_104061.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_104061", "104061010", "story_v_out_104061.awb")
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

		arg_40_1:InitPlayNodeList()
	end,
	Play104061011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104061011
		arg_44_1.duration_ = 7.33

		local var_44_0 = {
			ja = 7.333,
			ko = 4.466,
			zh = 4.1,
			en = 5.7
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
				arg_44_0:Play104061012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1148ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1148ui_story == nil then
				arg_44_1.var_.characterEffect1148ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1148ui_story and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1148ui_story.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1148ui_story then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1148ui_story.fillRatio = var_47_5
			end

			local var_47_6 = 0
			local var_47_7 = 0.5

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_8 = arg_44_1:FormatText(StoryNameCfg[21].name)

				arg_44_1.leftNameTxt_.text = var_47_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1035")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_9 = arg_44_1:GetWordFromCfg(104061011)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 20
				local var_47_12 = utf8.len(var_47_10)
				local var_47_13 = var_47_11 <= 0 and var_47_7 or var_47_7 * (var_47_12 / var_47_11)

				if var_47_13 > 0 and var_47_7 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061011", "story_v_out_104061.awb") ~= 0 then
					local var_47_14 = manager.audio:GetVoiceLength("story_v_out_104061", "104061011", "story_v_out_104061.awb") / 1000

					if var_47_14 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_6
					end

					if var_47_9.prefab_name ~= "" and arg_44_1.actors_[var_47_9.prefab_name] ~= nil then
						local var_47_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_9.prefab_name].transform, "story_v_out_104061", "104061011", "story_v_out_104061.awb")

						arg_44_1:RecordAudio("104061011", var_47_15)
						arg_44_1:RecordAudio("104061011", var_47_15)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_104061", "104061011", "story_v_out_104061.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_104061", "104061011", "story_v_out_104061.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_16 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_16 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_16

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_16 and arg_44_1.time_ < var_47_6 + var_47_16 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play104061012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 104061012
		arg_48_1.duration_ = 4.1

		local var_48_0 = {
			ja = 2.833,
			ko = 4.1,
			zh = 2.9,
			en = 3.033
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
				arg_48_0:Play104061013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1059ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1059ui_story == nil then
				arg_48_1.var_.characterEffect1059ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1059ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1059ui_story then
				arg_48_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1148ui_story"].transform
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.var_.moveOldPos1148ui_story = var_51_4.localPosition
			end

			local var_51_6 = 0.001

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6
				local var_51_8 = Vector3.New(0, 100, 0)

				var_51_4.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1148ui_story, var_51_8, var_51_7)

				local var_51_9 = manager.ui.mainCamera.transform.position - var_51_4.position

				var_51_4.forward = Vector3.New(var_51_9.x, var_51_9.y, var_51_9.z)

				local var_51_10 = var_51_4.localEulerAngles

				var_51_10.z = 0
				var_51_10.x = 0
				var_51_4.localEulerAngles = var_51_10
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 then
				var_51_4.localPosition = Vector3.New(0, 100, 0)

				local var_51_11 = manager.ui.mainCamera.transform.position - var_51_4.position

				var_51_4.forward = Vector3.New(var_51_11.x, var_51_11.y, var_51_11.z)

				local var_51_12 = var_51_4.localEulerAngles

				var_51_12.z = 0
				var_51_12.x = 0
				var_51_4.localEulerAngles = var_51_12
			end

			local var_51_13 = arg_48_1.actors_["1059ui_story"].transform
			local var_51_14 = 0

			if var_51_14 < arg_48_1.time_ and arg_48_1.time_ <= var_51_14 + arg_51_0 then
				arg_48_1.var_.moveOldPos1059ui_story = var_51_13.localPosition
			end

			local var_51_15 = 0.001

			if var_51_14 <= arg_48_1.time_ and arg_48_1.time_ < var_51_14 + var_51_15 then
				local var_51_16 = (arg_48_1.time_ - var_51_14) / var_51_15
				local var_51_17 = Vector3.New(0, -1.05, -6)

				var_51_13.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1059ui_story, var_51_17, var_51_16)

				local var_51_18 = manager.ui.mainCamera.transform.position - var_51_13.position

				var_51_13.forward = Vector3.New(var_51_18.x, var_51_18.y, var_51_18.z)

				local var_51_19 = var_51_13.localEulerAngles

				var_51_19.z = 0
				var_51_19.x = 0
				var_51_13.localEulerAngles = var_51_19
			end

			if arg_48_1.time_ >= var_51_14 + var_51_15 and arg_48_1.time_ < var_51_14 + var_51_15 + arg_51_0 then
				var_51_13.localPosition = Vector3.New(0, -1.05, -6)

				local var_51_20 = manager.ui.mainCamera.transform.position - var_51_13.position

				var_51_13.forward = Vector3.New(var_51_20.x, var_51_20.y, var_51_20.z)

				local var_51_21 = var_51_13.localEulerAngles

				var_51_21.z = 0
				var_51_21.x = 0
				var_51_13.localEulerAngles = var_51_21
			end

			local var_51_22 = 0

			if var_51_22 < arg_48_1.time_ and arg_48_1.time_ <= var_51_22 + arg_51_0 then
				arg_48_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action6_1")
			end

			local var_51_23 = 0

			if var_51_23 < arg_48_1.time_ and arg_48_1.time_ <= var_51_23 + arg_51_0 then
				arg_48_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_51_24 = 0
			local var_51_25 = 0.375

			if var_51_24 < arg_48_1.time_ and arg_48_1.time_ <= var_51_24 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_26 = arg_48_1:FormatText(StoryNameCfg[28].name)

				arg_48_1.leftNameTxt_.text = var_51_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_27 = arg_48_1:GetWordFromCfg(104061012)
				local var_51_28 = arg_48_1:FormatText(var_51_27.content)

				arg_48_1.text_.text = var_51_28

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_29 = 15
				local var_51_30 = utf8.len(var_51_28)
				local var_51_31 = var_51_29 <= 0 and var_51_25 or var_51_25 * (var_51_30 / var_51_29)

				if var_51_31 > 0 and var_51_25 < var_51_31 then
					arg_48_1.talkMaxDuration = var_51_31

					if var_51_31 + var_51_24 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_31 + var_51_24
					end
				end

				arg_48_1.text_.text = var_51_28
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061012", "story_v_out_104061.awb") ~= 0 then
					local var_51_32 = manager.audio:GetVoiceLength("story_v_out_104061", "104061012", "story_v_out_104061.awb") / 1000

					if var_51_32 + var_51_24 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_32 + var_51_24
					end

					if var_51_27.prefab_name ~= "" and arg_48_1.actors_[var_51_27.prefab_name] ~= nil then
						local var_51_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_27.prefab_name].transform, "story_v_out_104061", "104061012", "story_v_out_104061.awb")

						arg_48_1:RecordAudio("104061012", var_51_33)
						arg_48_1:RecordAudio("104061012", var_51_33)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_104061", "104061012", "story_v_out_104061.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_104061", "104061012", "story_v_out_104061.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_34 = math.max(var_51_25, arg_48_1.talkMaxDuration)

			if var_51_24 <= arg_48_1.time_ and arg_48_1.time_ < var_51_24 + var_51_34 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_24) / var_51_34

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_24 + var_51_34 and arg_48_1.time_ < var_51_24 + var_51_34 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play104061013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 104061013
		arg_52_1.duration_ = 6.77

		local var_52_0 = {
			ja = 6.766,
			ko = 6.1,
			zh = 3.166,
			en = 3.7
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
				arg_52_0:Play104061015(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1148ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1148ui_story == nil then
				arg_52_1.var_.characterEffect1148ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1148ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1148ui_story then
				arg_52_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["1059ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1059ui_story == nil then
				arg_52_1.var_.characterEffect1059ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.1

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect1059ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1059ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1059ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1059ui_story.fillRatio = var_55_9
			end

			local var_55_10 = arg_52_1.actors_["1059ui_story"].transform
			local var_55_11 = 0

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1.var_.moveOldPos1059ui_story = var_55_10.localPosition
			end

			local var_55_12 = 0.001

			if var_55_11 <= arg_52_1.time_ and arg_52_1.time_ < var_55_11 + var_55_12 then
				local var_55_13 = (arg_52_1.time_ - var_55_11) / var_55_12
				local var_55_14 = Vector3.New(0, 100, 0)

				var_55_10.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1059ui_story, var_55_14, var_55_13)

				local var_55_15 = manager.ui.mainCamera.transform.position - var_55_10.position

				var_55_10.forward = Vector3.New(var_55_15.x, var_55_15.y, var_55_15.z)

				local var_55_16 = var_55_10.localEulerAngles

				var_55_16.z = 0
				var_55_16.x = 0
				var_55_10.localEulerAngles = var_55_16
			end

			if arg_52_1.time_ >= var_55_11 + var_55_12 and arg_52_1.time_ < var_55_11 + var_55_12 + arg_55_0 then
				var_55_10.localPosition = Vector3.New(0, 100, 0)

				local var_55_17 = manager.ui.mainCamera.transform.position - var_55_10.position

				var_55_10.forward = Vector3.New(var_55_17.x, var_55_17.y, var_55_17.z)

				local var_55_18 = var_55_10.localEulerAngles

				var_55_18.z = 0
				var_55_18.x = 0
				var_55_10.localEulerAngles = var_55_18
			end

			local var_55_19 = arg_52_1.actors_["1148ui_story"].transform
			local var_55_20 = 0

			if var_55_20 < arg_52_1.time_ and arg_52_1.time_ <= var_55_20 + arg_55_0 then
				arg_52_1.var_.moveOldPos1148ui_story = var_55_19.localPosition
			end

			local var_55_21 = 0.001

			if var_55_20 <= arg_52_1.time_ and arg_52_1.time_ < var_55_20 + var_55_21 then
				local var_55_22 = (arg_52_1.time_ - var_55_20) / var_55_21
				local var_55_23 = Vector3.New(0, -0.8, -6.2)

				var_55_19.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1148ui_story, var_55_23, var_55_22)

				local var_55_24 = manager.ui.mainCamera.transform.position - var_55_19.position

				var_55_19.forward = Vector3.New(var_55_24.x, var_55_24.y, var_55_24.z)

				local var_55_25 = var_55_19.localEulerAngles

				var_55_25.z = 0
				var_55_25.x = 0
				var_55_19.localEulerAngles = var_55_25
			end

			if arg_52_1.time_ >= var_55_20 + var_55_21 and arg_52_1.time_ < var_55_20 + var_55_21 + arg_55_0 then
				var_55_19.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_55_26 = manager.ui.mainCamera.transform.position - var_55_19.position

				var_55_19.forward = Vector3.New(var_55_26.x, var_55_26.y, var_55_26.z)

				local var_55_27 = var_55_19.localEulerAngles

				var_55_27.z = 0
				var_55_27.x = 0
				var_55_19.localEulerAngles = var_55_27
			end

			local var_55_28 = 0

			if var_55_28 < arg_52_1.time_ and arg_52_1.time_ <= var_55_28 + arg_55_0 then
				arg_52_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			local var_55_29 = 0

			if var_55_29 < arg_52_1.time_ and arg_52_1.time_ <= var_55_29 + arg_55_0 then
				arg_52_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_55_30 = 0
			local var_55_31 = 0.375

			if var_55_30 < arg_52_1.time_ and arg_52_1.time_ <= var_55_30 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_32 = arg_52_1:FormatText(StoryNameCfg[8].name)

				arg_52_1.leftNameTxt_.text = var_55_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_33 = arg_52_1:GetWordFromCfg(104061013)
				local var_55_34 = arg_52_1:FormatText(var_55_33.content)

				arg_52_1.text_.text = var_55_34

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_35 = 15
				local var_55_36 = utf8.len(var_55_34)
				local var_55_37 = var_55_35 <= 0 and var_55_31 or var_55_31 * (var_55_36 / var_55_35)

				if var_55_37 > 0 and var_55_31 < var_55_37 then
					arg_52_1.talkMaxDuration = var_55_37

					if var_55_37 + var_55_30 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_37 + var_55_30
					end
				end

				arg_52_1.text_.text = var_55_34
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061013", "story_v_out_104061.awb") ~= 0 then
					local var_55_38 = manager.audio:GetVoiceLength("story_v_out_104061", "104061013", "story_v_out_104061.awb") / 1000

					if var_55_38 + var_55_30 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_38 + var_55_30
					end

					if var_55_33.prefab_name ~= "" and arg_52_1.actors_[var_55_33.prefab_name] ~= nil then
						local var_55_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_33.prefab_name].transform, "story_v_out_104061", "104061013", "story_v_out_104061.awb")

						arg_52_1:RecordAudio("104061013", var_55_39)
						arg_52_1:RecordAudio("104061013", var_55_39)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_104061", "104061013", "story_v_out_104061.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_104061", "104061013", "story_v_out_104061.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_40 = math.max(var_55_31, arg_52_1.talkMaxDuration)

			if var_55_30 <= arg_52_1.time_ and arg_52_1.time_ < var_55_30 + var_55_40 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_30) / var_55_40

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_30 + var_55_40 and arg_52_1.time_ < var_55_30 + var_55_40 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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

		arg_52_1:InitPlayNodeList()
	end,
	Play104061015 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 104061015
		arg_56_1.duration_ = 6.27

		local var_56_0 = {
			ja = 6.266,
			ko = 4.733,
			zh = 4.366,
			en = 5.5
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
				arg_56_0:Play104061016(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 1

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				local var_59_2 = "play"
				local var_59_3 = "effect"

				arg_56_1:AudioAction(var_59_2, var_59_3, "se_story", "se_story_robot_long", "")
			end

			local var_59_4 = "3005_tpose"

			if arg_56_1.actors_[var_59_4] == nil then
				local var_59_5 = Asset.Load("Char/" .. "3005_tpose")

				if not isNil(var_59_5) then
					local var_59_6 = Object.Instantiate(Asset.Load("Char/" .. "3005_tpose"), arg_56_1.stage_.transform)

					var_59_6.name = var_59_4
					var_59_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_56_1.actors_[var_59_4] = var_59_6

					local var_59_7 = var_59_6:GetComponentInChildren(typeof(CharacterEffect))

					var_59_7.enabled = true

					local var_59_8 = GameObjectTools.GetOrAddComponent(var_59_6, typeof(DynamicBoneHelper))

					if var_59_8 then
						var_59_8:EnableDynamicBone(false)
					end

					arg_56_1:ShowWeapon(var_59_7.transform, false)

					arg_56_1.var_[var_59_4 .. "Animator"] = var_59_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_56_1.var_[var_59_4 .. "Animator"].applyRootMotion = true
					arg_56_1.var_[var_59_4 .. "LipSync"] = var_59_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_59_9 = arg_56_1.actors_["3005_tpose"]
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect3005_tpose == nil then
				arg_56_1.var_.characterEffect3005_tpose = var_59_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.1

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 and not isNil(var_59_9) then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11

				if arg_56_1.var_.characterEffect3005_tpose and not isNil(var_59_9) then
					arg_56_1.var_.characterEffect3005_tpose.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect3005_tpose then
				arg_56_1.var_.characterEffect3005_tpose.fillFlat = false
			end

			local var_59_13 = arg_56_1.actors_["1148ui_story"]
			local var_59_14 = 0

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 and not isNil(var_59_13) and arg_56_1.var_.characterEffect1148ui_story == nil then
				arg_56_1.var_.characterEffect1148ui_story = var_59_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_15 = 0.1

			if var_59_14 <= arg_56_1.time_ and arg_56_1.time_ < var_59_14 + var_59_15 and not isNil(var_59_13) then
				local var_59_16 = (arg_56_1.time_ - var_59_14) / var_59_15

				if arg_56_1.var_.characterEffect1148ui_story and not isNil(var_59_13) then
					local var_59_17 = Mathf.Lerp(0, 0.5, var_59_16)

					arg_56_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1148ui_story.fillRatio = var_59_17
				end
			end

			if arg_56_1.time_ >= var_59_14 + var_59_15 and arg_56_1.time_ < var_59_14 + var_59_15 + arg_59_0 and not isNil(var_59_13) and arg_56_1.var_.characterEffect1148ui_story then
				local var_59_18 = 0.5

				arg_56_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1148ui_story.fillRatio = var_59_18
			end

			local var_59_19 = arg_56_1.actors_["1148ui_story"].transform
			local var_59_20 = 0

			if var_59_20 < arg_56_1.time_ and arg_56_1.time_ <= var_59_20 + arg_59_0 then
				arg_56_1.var_.moveOldPos1148ui_story = var_59_19.localPosition
			end

			local var_59_21 = 0.001

			if var_59_20 <= arg_56_1.time_ and arg_56_1.time_ < var_59_20 + var_59_21 then
				local var_59_22 = (arg_56_1.time_ - var_59_20) / var_59_21
				local var_59_23 = Vector3.New(0, 100, 0)

				var_59_19.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1148ui_story, var_59_23, var_59_22)

				local var_59_24 = manager.ui.mainCamera.transform.position - var_59_19.position

				var_59_19.forward = Vector3.New(var_59_24.x, var_59_24.y, var_59_24.z)

				local var_59_25 = var_59_19.localEulerAngles

				var_59_25.z = 0
				var_59_25.x = 0
				var_59_19.localEulerAngles = var_59_25
			end

			if arg_56_1.time_ >= var_59_20 + var_59_21 and arg_56_1.time_ < var_59_20 + var_59_21 + arg_59_0 then
				var_59_19.localPosition = Vector3.New(0, 100, 0)

				local var_59_26 = manager.ui.mainCamera.transform.position - var_59_19.position

				var_59_19.forward = Vector3.New(var_59_26.x, var_59_26.y, var_59_26.z)

				local var_59_27 = var_59_19.localEulerAngles

				var_59_27.z = 0
				var_59_27.x = 0
				var_59_19.localEulerAngles = var_59_27
			end

			local var_59_28 = arg_56_1.actors_["3005_tpose"].transform
			local var_59_29 = 0

			if var_59_29 < arg_56_1.time_ and arg_56_1.time_ <= var_59_29 + arg_59_0 then
				arg_56_1.var_.moveOldPos3005_tpose = var_59_28.localPosition

				local var_59_30 = GameObjectTools.GetOrAddComponent(var_59_28.gameObject, typeof(DynamicBoneHelper))

				if var_59_30 then
					var_59_30:EnableDynamicBone(false)
				end
			end

			local var_59_31 = 0.001

			if var_59_29 <= arg_56_1.time_ and arg_56_1.time_ < var_59_29 + var_59_31 then
				local var_59_32 = (arg_56_1.time_ - var_59_29) / var_59_31
				local var_59_33 = Vector3.New(0, -1.95, -2.63)

				var_59_28.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos3005_tpose, var_59_33, var_59_32)

				local var_59_34 = manager.ui.mainCamera.transform.position - var_59_28.position

				var_59_28.forward = Vector3.New(var_59_34.x, var_59_34.y, var_59_34.z)

				local var_59_35 = var_59_28.localEulerAngles

				var_59_35.z = 0
				var_59_35.x = 0
				var_59_28.localEulerAngles = var_59_35
			end

			if arg_56_1.time_ >= var_59_29 + var_59_31 and arg_56_1.time_ < var_59_29 + var_59_31 + arg_59_0 then
				var_59_28.localPosition = Vector3.New(0, -1.95, -2.63)

				local var_59_36 = manager.ui.mainCamera.transform.position - var_59_28.position

				var_59_28.forward = Vector3.New(var_59_36.x, var_59_36.y, var_59_36.z)

				local var_59_37 = var_59_28.localEulerAngles

				var_59_37.z = 0
				var_59_37.x = 0
				var_59_28.localEulerAngles = var_59_37

				local var_59_38 = GameObjectTools.GetOrAddComponent(var_59_28.gameObject, typeof(DynamicBoneHelper))

				if var_59_38 then
					var_59_38:EnableDynamicBone(true)
				end
			end

			local var_59_39 = 0

			if var_59_39 < arg_56_1.time_ and arg_56_1.time_ <= var_59_39 + arg_59_0 then
				arg_56_1:PlayTimeline("3005_tpose", "StoryTimeline/CharAction/story3005/story3005action/3005action1_1")
			end

			local var_59_40 = 0
			local var_59_41 = 0.6

			if var_59_40 < arg_56_1.time_ and arg_56_1.time_ <= var_59_40 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_42 = arg_56_1:FormatText(StoryNameCfg[58].name)

				arg_56_1.leftNameTxt_.text = var_59_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_43 = arg_56_1:GetWordFromCfg(104061015)
				local var_59_44 = arg_56_1:FormatText(var_59_43.content)

				arg_56_1.text_.text = var_59_44

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_45 = 23
				local var_59_46 = utf8.len(var_59_44)
				local var_59_47 = var_59_45 <= 0 and var_59_41 or var_59_41 * (var_59_46 / var_59_45)

				if var_59_47 > 0 and var_59_41 < var_59_47 then
					arg_56_1.talkMaxDuration = var_59_47

					if var_59_47 + var_59_40 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_47 + var_59_40
					end
				end

				arg_56_1.text_.text = var_59_44
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061015", "story_v_out_104061.awb") ~= 0 then
					local var_59_48 = manager.audio:GetVoiceLength("story_v_out_104061", "104061015", "story_v_out_104061.awb") / 1000

					if var_59_48 + var_59_40 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_48 + var_59_40
					end

					if var_59_43.prefab_name ~= "" and arg_56_1.actors_[var_59_43.prefab_name] ~= nil then
						local var_59_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_43.prefab_name].transform, "story_v_out_104061", "104061015", "story_v_out_104061.awb")

						arg_56_1:RecordAudio("104061015", var_59_49)
						arg_56_1:RecordAudio("104061015", var_59_49)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_104061", "104061015", "story_v_out_104061.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_104061", "104061015", "story_v_out_104061.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_50 = math.max(var_59_41, arg_56_1.talkMaxDuration)

			if var_59_40 <= arg_56_1.time_ and arg_56_1.time_ < var_59_40 + var_59_50 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_40) / var_59_50

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_40 + var_59_50 and arg_56_1.time_ < var_59_40 + var_59_50 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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
				actorName = "3005_tpose",
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
	Play104061016 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 104061016
		arg_60_1.duration_ = 2.53

		local var_60_0 = {
			ja = 2.533,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.2
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
				arg_60_0:Play104061017(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1148ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1148ui_story == nil then
				arg_60_1.var_.characterEffect1148ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1148ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1148ui_story then
				arg_60_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["3005_tpose"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect3005_tpose == nil then
				arg_60_1.var_.characterEffect3005_tpose = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.1

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect3005_tpose and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect3005_tpose.fillFlat = true
					arg_60_1.var_.characterEffect3005_tpose.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect3005_tpose then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect3005_tpose.fillFlat = true
				arg_60_1.var_.characterEffect3005_tpose.fillRatio = var_63_9
			end

			local var_63_10 = arg_60_1.actors_["3005_tpose"].transform
			local var_63_11 = 0

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1.var_.moveOldPos3005_tpose = var_63_10.localPosition

				local var_63_12 = GameObjectTools.GetOrAddComponent(var_63_10.gameObject, typeof(DynamicBoneHelper))

				if var_63_12 then
					var_63_12:EnableDynamicBone(false)
				end
			end

			local var_63_13 = 0.001

			if var_63_11 <= arg_60_1.time_ and arg_60_1.time_ < var_63_11 + var_63_13 then
				local var_63_14 = (arg_60_1.time_ - var_63_11) / var_63_13
				local var_63_15 = Vector3.New(0, 100, 0)

				var_63_10.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos3005_tpose, var_63_15, var_63_14)

				local var_63_16 = manager.ui.mainCamera.transform.position - var_63_10.position

				var_63_10.forward = Vector3.New(var_63_16.x, var_63_16.y, var_63_16.z)

				local var_63_17 = var_63_10.localEulerAngles

				var_63_17.z = 0
				var_63_17.x = 0
				var_63_10.localEulerAngles = var_63_17
			end

			if arg_60_1.time_ >= var_63_11 + var_63_13 and arg_60_1.time_ < var_63_11 + var_63_13 + arg_63_0 then
				var_63_10.localPosition = Vector3.New(0, 100, 0)

				local var_63_18 = manager.ui.mainCamera.transform.position - var_63_10.position

				var_63_10.forward = Vector3.New(var_63_18.x, var_63_18.y, var_63_18.z)

				local var_63_19 = var_63_10.localEulerAngles

				var_63_19.z = 0
				var_63_19.x = 0
				var_63_10.localEulerAngles = var_63_19

				local var_63_20 = GameObjectTools.GetOrAddComponent(var_63_10.gameObject, typeof(DynamicBoneHelper))

				if var_63_20 then
					var_63_20:EnableDynamicBone(true)
				end
			end

			local var_63_21 = arg_60_1.actors_["1148ui_story"].transform
			local var_63_22 = 0

			if var_63_22 < arg_60_1.time_ and arg_60_1.time_ <= var_63_22 + arg_63_0 then
				arg_60_1.var_.moveOldPos1148ui_story = var_63_21.localPosition
			end

			local var_63_23 = 0.001

			if var_63_22 <= arg_60_1.time_ and arg_60_1.time_ < var_63_22 + var_63_23 then
				local var_63_24 = (arg_60_1.time_ - var_63_22) / var_63_23
				local var_63_25 = Vector3.New(0, -0.8, -6.2)

				var_63_21.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1148ui_story, var_63_25, var_63_24)

				local var_63_26 = manager.ui.mainCamera.transform.position - var_63_21.position

				var_63_21.forward = Vector3.New(var_63_26.x, var_63_26.y, var_63_26.z)

				local var_63_27 = var_63_21.localEulerAngles

				var_63_27.z = 0
				var_63_27.x = 0
				var_63_21.localEulerAngles = var_63_27
			end

			if arg_60_1.time_ >= var_63_22 + var_63_23 and arg_60_1.time_ < var_63_22 + var_63_23 + arg_63_0 then
				var_63_21.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_63_28 = manager.ui.mainCamera.transform.position - var_63_21.position

				var_63_21.forward = Vector3.New(var_63_28.x, var_63_28.y, var_63_28.z)

				local var_63_29 = var_63_21.localEulerAngles

				var_63_29.z = 0
				var_63_29.x = 0
				var_63_21.localEulerAngles = var_63_29
			end

			local var_63_30 = 0

			if var_63_30 < arg_60_1.time_ and arg_60_1.time_ <= var_63_30 + arg_63_0 then
				arg_60_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			local var_63_31 = 0

			if var_63_31 < arg_60_1.time_ and arg_60_1.time_ <= var_63_31 + arg_63_0 then
				arg_60_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_63_32 = 0
			local var_63_33 = 0.225

			if var_63_32 < arg_60_1.time_ and arg_60_1.time_ <= var_63_32 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_34 = arg_60_1:FormatText(StoryNameCfg[8].name)

				arg_60_1.leftNameTxt_.text = var_63_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_35 = arg_60_1:GetWordFromCfg(104061016)
				local var_63_36 = arg_60_1:FormatText(var_63_35.content)

				arg_60_1.text_.text = var_63_36

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_37 = 9
				local var_63_38 = utf8.len(var_63_36)
				local var_63_39 = var_63_37 <= 0 and var_63_33 or var_63_33 * (var_63_38 / var_63_37)

				if var_63_39 > 0 and var_63_33 < var_63_39 then
					arg_60_1.talkMaxDuration = var_63_39

					if var_63_39 + var_63_32 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_39 + var_63_32
					end
				end

				arg_60_1.text_.text = var_63_36
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061016", "story_v_out_104061.awb") ~= 0 then
					local var_63_40 = manager.audio:GetVoiceLength("story_v_out_104061", "104061016", "story_v_out_104061.awb") / 1000

					if var_63_40 + var_63_32 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_40 + var_63_32
					end

					if var_63_35.prefab_name ~= "" and arg_60_1.actors_[var_63_35.prefab_name] ~= nil then
						local var_63_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_35.prefab_name].transform, "story_v_out_104061", "104061016", "story_v_out_104061.awb")

						arg_60_1:RecordAudio("104061016", var_63_41)
						arg_60_1:RecordAudio("104061016", var_63_41)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_104061", "104061016", "story_v_out_104061.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_104061", "104061016", "story_v_out_104061.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_42 = math.max(var_63_33, arg_60_1.talkMaxDuration)

			if var_63_32 <= arg_60_1.time_ and arg_60_1.time_ < var_63_32 + var_63_42 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_32) / var_63_42

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_32 + var_63_42 and arg_60_1.time_ < var_63_32 + var_63_42 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3005_tpose",
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

		arg_60_1:InitPlayNodeList()
	end,
	Play104061017 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 104061017
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play104061018(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 1

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				local var_67_2 = "play"
				local var_67_3 = "effect"

				arg_64_1:AudioAction(var_67_2, var_67_3, "se_story_4", "se_story_4_arm_1", "")
			end

			local var_67_4 = arg_64_1.actors_["1148ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1148ui_story == nil then
				arg_64_1.var_.characterEffect1148ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.1

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect1148ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1148ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1148ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1148ui_story.fillRatio = var_67_9
			end

			local var_67_10 = manager.ui.mainCamera.transform
			local var_67_11 = 0

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.var_.shakeOldPosMainCamera = var_67_10.localPosition
			end

			local var_67_12 = 0.600000023841858

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_11) / 0.066
				local var_67_14, var_67_15 = math.modf(var_67_13)

				var_67_10.localPosition = Vector3.New(var_67_15 * 0.13, var_67_15 * 0.13, var_67_15 * 0.13) + arg_64_1.var_.shakeOldPosMainCamera
			end

			if arg_64_1.time_ >= var_67_11 + var_67_12 and arg_64_1.time_ < var_67_11 + var_67_12 + arg_67_0 then
				var_67_10.localPosition = arg_64_1.var_.shakeOldPosMainCamera
			end

			local var_67_16 = arg_64_1.actors_["1148ui_story"].transform
			local var_67_17 = 0

			if var_67_17 < arg_64_1.time_ and arg_64_1.time_ <= var_67_17 + arg_67_0 then
				arg_64_1.var_.moveOldPos1148ui_story = var_67_16.localPosition
			end

			local var_67_18 = 0.001

			if var_67_17 <= arg_64_1.time_ and arg_64_1.time_ < var_67_17 + var_67_18 then
				local var_67_19 = (arg_64_1.time_ - var_67_17) / var_67_18
				local var_67_20 = Vector3.New(0, 100, 0)

				var_67_16.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1148ui_story, var_67_20, var_67_19)

				local var_67_21 = manager.ui.mainCamera.transform.position - var_67_16.position

				var_67_16.forward = Vector3.New(var_67_21.x, var_67_21.y, var_67_21.z)

				local var_67_22 = var_67_16.localEulerAngles

				var_67_22.z = 0
				var_67_22.x = 0
				var_67_16.localEulerAngles = var_67_22
			end

			if arg_64_1.time_ >= var_67_17 + var_67_18 and arg_64_1.time_ < var_67_17 + var_67_18 + arg_67_0 then
				var_67_16.localPosition = Vector3.New(0, 100, 0)

				local var_67_23 = manager.ui.mainCamera.transform.position - var_67_16.position

				var_67_16.forward = Vector3.New(var_67_23.x, var_67_23.y, var_67_23.z)

				local var_67_24 = var_67_16.localEulerAngles

				var_67_24.z = 0
				var_67_24.x = 0
				var_67_16.localEulerAngles = var_67_24
			end

			local var_67_25 = 0
			local var_67_26 = 1.05

			if var_67_25 < arg_64_1.time_ and arg_64_1.time_ <= var_67_25 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_27 = arg_64_1:GetWordFromCfg(104061017)
				local var_67_28 = arg_64_1:FormatText(var_67_27.content)

				arg_64_1.text_.text = var_67_28

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_29 = 42
				local var_67_30 = utf8.len(var_67_28)
				local var_67_31 = var_67_29 <= 0 and var_67_26 or var_67_26 * (var_67_30 / var_67_29)

				if var_67_31 > 0 and var_67_26 < var_67_31 then
					arg_64_1.talkMaxDuration = var_67_31

					if var_67_31 + var_67_25 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_31 + var_67_25
					end
				end

				arg_64_1.text_.text = var_67_28
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_32 = math.max(var_67_26, arg_64_1.talkMaxDuration)

			if var_67_25 <= arg_64_1.time_ and arg_64_1.time_ < var_67_25 + var_67_32 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_25) / var_67_32

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_25 + var_67_32 and arg_64_1.time_ < var_67_25 + var_67_32 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play104061018 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 104061018
		arg_68_1.duration_ = 3.27

		local var_68_0 = {
			ja = 2.5,
			ko = 2.833,
			zh = 2.7,
			en = 3.266
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
				arg_68_0:Play104061019(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1059ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1059ui_story == nil then
				arg_68_1.var_.characterEffect1059ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1059ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1059ui_story then
				arg_68_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["1059ui_story"].transform
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.var_.moveOldPos1059ui_story = var_71_4.localPosition
			end

			local var_71_6 = 0.001

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6
				local var_71_8 = Vector3.New(0, -1.05, -6)

				var_71_4.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1059ui_story, var_71_8, var_71_7)

				local var_71_9 = manager.ui.mainCamera.transform.position - var_71_4.position

				var_71_4.forward = Vector3.New(var_71_9.x, var_71_9.y, var_71_9.z)

				local var_71_10 = var_71_4.localEulerAngles

				var_71_10.z = 0
				var_71_10.x = 0
				var_71_4.localEulerAngles = var_71_10
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 then
				var_71_4.localPosition = Vector3.New(0, -1.05, -6)

				local var_71_11 = manager.ui.mainCamera.transform.position - var_71_4.position

				var_71_4.forward = Vector3.New(var_71_11.x, var_71_11.y, var_71_11.z)

				local var_71_12 = var_71_4.localEulerAngles

				var_71_12.z = 0
				var_71_12.x = 0
				var_71_4.localEulerAngles = var_71_12
			end

			local var_71_13 = 0

			if var_71_13 < arg_68_1.time_ and arg_68_1.time_ <= var_71_13 + arg_71_0 then
				arg_68_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			local var_71_14 = 0

			if var_71_14 < arg_68_1.time_ and arg_68_1.time_ <= var_71_14 + arg_71_0 then
				arg_68_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_71_15 = 0
			local var_71_16 = 0.225

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_17 = arg_68_1:FormatText(StoryNameCfg[28].name)

				arg_68_1.leftNameTxt_.text = var_71_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_18 = arg_68_1:GetWordFromCfg(104061018)
				local var_71_19 = arg_68_1:FormatText(var_71_18.content)

				arg_68_1.text_.text = var_71_19

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_20 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061018", "story_v_out_104061.awb") ~= 0 then
					local var_71_23 = manager.audio:GetVoiceLength("story_v_out_104061", "104061018", "story_v_out_104061.awb") / 1000

					if var_71_23 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_23 + var_71_15
					end

					if var_71_18.prefab_name ~= "" and arg_68_1.actors_[var_71_18.prefab_name] ~= nil then
						local var_71_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_18.prefab_name].transform, "story_v_out_104061", "104061018", "story_v_out_104061.awb")

						arg_68_1:RecordAudio("104061018", var_71_24)
						arg_68_1:RecordAudio("104061018", var_71_24)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_104061", "104061018", "story_v_out_104061.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_104061", "104061018", "story_v_out_104061.awb")
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
				actorName = "1059ui_story",
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
	Play104061019 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 104061019
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play104061020(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1059ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1059ui_story == nil then
				arg_72_1.var_.characterEffect1059ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1059ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1059ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1059ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1059ui_story.fillRatio = var_75_5
			end

			local var_75_6 = 0
			local var_75_7 = 0.325

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_8 = arg_72_1:FormatText(StoryNameCfg[7].name)

				arg_72_1.leftNameTxt_.text = var_75_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_9 = arg_72_1:GetWordFromCfg(104061019)
				local var_75_10 = arg_72_1:FormatText(var_75_9.content)

				arg_72_1.text_.text = var_75_10

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 13
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
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play104061020 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 104061020
		arg_76_1.duration_ = 1.83

		local var_76_0 = {
			ja = 1.833,
			ko = 1.499999999999,
			zh = 1.733,
			en = 1.633
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
				arg_76_0:Play104061021(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1059ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1059ui_story == nil then
				arg_76_1.var_.characterEffect1059ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1059ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1059ui_story then
				arg_76_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_79_4 = 0

			if var_79_4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action426")
			end

			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 then
				arg_76_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_79_6 = 0
			local var_79_7 = 0.2

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_8 = arg_76_1:FormatText(StoryNameCfg[28].name)

				arg_76_1.leftNameTxt_.text = var_79_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_9 = arg_76_1:GetWordFromCfg(104061020)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 8
				local var_79_12 = utf8.len(var_79_10)
				local var_79_13 = var_79_11 <= 0 and var_79_7 or var_79_7 * (var_79_12 / var_79_11)

				if var_79_13 > 0 and var_79_7 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061020", "story_v_out_104061.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_out_104061", "104061020", "story_v_out_104061.awb") / 1000

					if var_79_14 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_6
					end

					if var_79_9.prefab_name ~= "" and arg_76_1.actors_[var_79_9.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_9.prefab_name].transform, "story_v_out_104061", "104061020", "story_v_out_104061.awb")

						arg_76_1:RecordAudio("104061020", var_79_15)
						arg_76_1:RecordAudio("104061020", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_104061", "104061020", "story_v_out_104061.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_104061", "104061020", "story_v_out_104061.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_16 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_16 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_16

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_16 and arg_76_1.time_ < var_79_6 + var_79_16 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play104061021 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 104061021
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play104061022(arg_80_1)
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
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1059ui_story.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1059ui_story then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1059ui_story.fillRatio = var_83_5
			end

			local var_83_6 = 0
			local var_83_7 = 0.775

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_8 = arg_80_1:FormatText(StoryNameCfg[7].name)

				arg_80_1.leftNameTxt_.text = var_83_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_9 = arg_80_1:GetWordFromCfg(104061021)
				local var_83_10 = arg_80_1:FormatText(var_83_9.content)

				arg_80_1.text_.text = var_83_10

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 31
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
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_14 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_14 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_6) / var_83_14

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_6 + var_83_14 and arg_80_1.time_ < var_83_6 + var_83_14 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play104061022 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 104061022
		arg_84_1.duration_ = 2.7

		local var_84_0 = {
			ja = 2.533,
			ko = 1.466,
			zh = 1.7,
			en = 2.7
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
				arg_84_0:Play104061023(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1059ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1059ui_story == nil then
				arg_84_1.var_.characterEffect1059ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1059ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1059ui_story then
				arg_84_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_87_4 = 0

			if var_87_4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_87_5 = 0
			local var_87_6 = 0.125

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_7 = arg_84_1:FormatText(StoryNameCfg[28].name)

				arg_84_1.leftNameTxt_.text = var_87_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_8 = arg_84_1:GetWordFromCfg(104061022)
				local var_87_9 = arg_84_1:FormatText(var_87_8.content)

				arg_84_1.text_.text = var_87_9

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_10 = 5
				local var_87_11 = utf8.len(var_87_9)
				local var_87_12 = var_87_10 <= 0 and var_87_6 or var_87_6 * (var_87_11 / var_87_10)

				if var_87_12 > 0 and var_87_6 < var_87_12 then
					arg_84_1.talkMaxDuration = var_87_12

					if var_87_12 + var_87_5 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_12 + var_87_5
					end
				end

				arg_84_1.text_.text = var_87_9
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061022", "story_v_out_104061.awb") ~= 0 then
					local var_87_13 = manager.audio:GetVoiceLength("story_v_out_104061", "104061022", "story_v_out_104061.awb") / 1000

					if var_87_13 + var_87_5 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_5
					end

					if var_87_8.prefab_name ~= "" and arg_84_1.actors_[var_87_8.prefab_name] ~= nil then
						local var_87_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_8.prefab_name].transform, "story_v_out_104061", "104061022", "story_v_out_104061.awb")

						arg_84_1:RecordAudio("104061022", var_87_14)
						arg_84_1:RecordAudio("104061022", var_87_14)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_104061", "104061022", "story_v_out_104061.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_104061", "104061022", "story_v_out_104061.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_15 = math.max(var_87_6, arg_84_1.talkMaxDuration)

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_15 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_5) / var_87_15

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_5 + var_87_15 and arg_84_1.time_ < var_87_5 + var_87_15 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play104061023 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 104061023
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play104061024(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1059ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1059ui_story == nil then
				arg_88_1.var_.characterEffect1059ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1059ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1059ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1059ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1059ui_story.fillRatio = var_91_5
			end

			local var_91_6 = 0
			local var_91_7 = 0.275

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_8 = arg_88_1:FormatText(StoryNameCfg[7].name)

				arg_88_1.leftNameTxt_.text = var_91_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_9 = arg_88_1:GetWordFromCfg(104061023)
				local var_91_10 = arg_88_1:FormatText(var_91_9.content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 11
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
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_14 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_14 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_14

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_14 and arg_88_1.time_ < var_91_6 + var_91_14 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play104061024 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 104061024
		arg_92_1.duration_ = 7.57

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play104061025(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 1

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				local var_95_2 = "play"
				local var_95_3 = "effect"

				arg_92_1:AudioAction(var_95_2, var_95_3, "se_story", "se_story_robot_short", "")
			end

			local var_95_4 = "2043_tpose"

			if arg_92_1.actors_[var_95_4] == nil then
				local var_95_5 = Asset.Load("Char/" .. "2043_tpose")

				if not isNil(var_95_5) then
					local var_95_6 = Object.Instantiate(Asset.Load("Char/" .. "2043_tpose"), arg_92_1.stage_.transform)

					var_95_6.name = var_95_4
					var_95_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_92_1.actors_[var_95_4] = var_95_6

					local var_95_7 = var_95_6:GetComponentInChildren(typeof(CharacterEffect))

					var_95_7.enabled = true

					local var_95_8 = GameObjectTools.GetOrAddComponent(var_95_6, typeof(DynamicBoneHelper))

					if var_95_8 then
						var_95_8:EnableDynamicBone(false)
					end

					arg_92_1:ShowWeapon(var_95_7.transform, false)

					arg_92_1.var_[var_95_4 .. "Animator"] = var_95_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_92_1.var_[var_95_4 .. "Animator"].applyRootMotion = true
					arg_92_1.var_[var_95_4 .. "LipSync"] = var_95_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_95_9 = arg_92_1.actors_["2043_tpose"]
			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 and not isNil(var_95_9) and arg_92_1.var_.characterEffect2043_tpose == nil then
				arg_92_1.var_.characterEffect2043_tpose = var_95_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_11 = 0.1

			if var_95_10 <= arg_92_1.time_ and arg_92_1.time_ < var_95_10 + var_95_11 and not isNil(var_95_9) then
				local var_95_12 = (arg_92_1.time_ - var_95_10) / var_95_11

				if arg_92_1.var_.characterEffect2043_tpose and not isNil(var_95_9) then
					arg_92_1.var_.characterEffect2043_tpose.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_10 + var_95_11 and arg_92_1.time_ < var_95_10 + var_95_11 + arg_95_0 and not isNil(var_95_9) and arg_92_1.var_.characterEffect2043_tpose then
				arg_92_1.var_.characterEffect2043_tpose.fillFlat = false
			end

			local var_95_13 = arg_92_1.actors_["3005_tpose"]
			local var_95_14 = 0

			if var_95_14 < arg_92_1.time_ and arg_92_1.time_ <= var_95_14 + arg_95_0 and not isNil(var_95_13) and arg_92_1.var_.characterEffect3005_tpose == nil then
				arg_92_1.var_.characterEffect3005_tpose = var_95_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_15 = 0.1

			if var_95_14 <= arg_92_1.time_ and arg_92_1.time_ < var_95_14 + var_95_15 and not isNil(var_95_13) then
				local var_95_16 = (arg_92_1.time_ - var_95_14) / var_95_15

				if arg_92_1.var_.characterEffect3005_tpose and not isNil(var_95_13) then
					arg_92_1.var_.characterEffect3005_tpose.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_14 + var_95_15 and arg_92_1.time_ < var_95_14 + var_95_15 + arg_95_0 and not isNil(var_95_13) and arg_92_1.var_.characterEffect3005_tpose then
				arg_92_1.var_.characterEffect3005_tpose.fillFlat = false
			end

			local var_95_17 = arg_92_1.actors_["1059ui_story"].transform
			local var_95_18 = 0

			if var_95_18 < arg_92_1.time_ and arg_92_1.time_ <= var_95_18 + arg_95_0 then
				arg_92_1.var_.moveOldPos1059ui_story = var_95_17.localPosition
			end

			local var_95_19 = 0.001

			if var_95_18 <= arg_92_1.time_ and arg_92_1.time_ < var_95_18 + var_95_19 then
				local var_95_20 = (arg_92_1.time_ - var_95_18) / var_95_19
				local var_95_21 = Vector3.New(0, 100, 0)

				var_95_17.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1059ui_story, var_95_21, var_95_20)

				local var_95_22 = manager.ui.mainCamera.transform.position - var_95_17.position

				var_95_17.forward = Vector3.New(var_95_22.x, var_95_22.y, var_95_22.z)

				local var_95_23 = var_95_17.localEulerAngles

				var_95_23.z = 0
				var_95_23.x = 0
				var_95_17.localEulerAngles = var_95_23
			end

			if arg_92_1.time_ >= var_95_18 + var_95_19 and arg_92_1.time_ < var_95_18 + var_95_19 + arg_95_0 then
				var_95_17.localPosition = Vector3.New(0, 100, 0)

				local var_95_24 = manager.ui.mainCamera.transform.position - var_95_17.position

				var_95_17.forward = Vector3.New(var_95_24.x, var_95_24.y, var_95_24.z)

				local var_95_25 = var_95_17.localEulerAngles

				var_95_25.z = 0
				var_95_25.x = 0
				var_95_17.localEulerAngles = var_95_25
			end

			local var_95_26 = arg_92_1.actors_["2043_tpose"].transform
			local var_95_27 = 0

			if var_95_27 < arg_92_1.time_ and arg_92_1.time_ <= var_95_27 + arg_95_0 then
				arg_92_1.var_.moveOldPos2043_tpose = var_95_26.localPosition

				local var_95_28 = GameObjectTools.GetOrAddComponent(var_95_26.gameObject, typeof(DynamicBoneHelper))

				if var_95_28 then
					var_95_28:EnableDynamicBone(false)
				end
			end

			local var_95_29 = 0.001

			if var_95_27 <= arg_92_1.time_ and arg_92_1.time_ < var_95_27 + var_95_29 then
				local var_95_30 = (arg_92_1.time_ - var_95_27) / var_95_29
				local var_95_31 = Vector3.New(-0.7, -0.95, -3.2)

				var_95_26.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos2043_tpose, var_95_31, var_95_30)

				local var_95_32 = manager.ui.mainCamera.transform.position - var_95_26.position

				var_95_26.forward = Vector3.New(var_95_32.x, var_95_32.y, var_95_32.z)

				local var_95_33 = var_95_26.localEulerAngles

				var_95_33.z = 0
				var_95_33.x = 0
				var_95_26.localEulerAngles = var_95_33
			end

			if arg_92_1.time_ >= var_95_27 + var_95_29 and arg_92_1.time_ < var_95_27 + var_95_29 + arg_95_0 then
				var_95_26.localPosition = Vector3.New(-0.7, -0.95, -3.2)

				local var_95_34 = manager.ui.mainCamera.transform.position - var_95_26.position

				var_95_26.forward = Vector3.New(var_95_34.x, var_95_34.y, var_95_34.z)

				local var_95_35 = var_95_26.localEulerAngles

				var_95_35.z = 0
				var_95_35.x = 0
				var_95_26.localEulerAngles = var_95_35

				local var_95_36 = GameObjectTools.GetOrAddComponent(var_95_26.gameObject, typeof(DynamicBoneHelper))

				if var_95_36 then
					var_95_36:EnableDynamicBone(true)
				end
			end

			local var_95_37 = 0

			if var_95_37 < arg_92_1.time_ and arg_92_1.time_ <= var_95_37 + arg_95_0 then
				arg_92_1:PlayTimeline("2043_tpose", "StoryTimeline/CharAction/story2043/story2043action/2043action1_1")
			end

			local var_95_38 = arg_92_1.actors_["3005_tpose"].transform
			local var_95_39 = 0

			if var_95_39 < arg_92_1.time_ and arg_92_1.time_ <= var_95_39 + arg_95_0 then
				arg_92_1.var_.moveOldPos3005_tpose = var_95_38.localPosition

				local var_95_40 = GameObjectTools.GetOrAddComponent(var_95_38.gameObject, typeof(DynamicBoneHelper))

				if var_95_40 then
					var_95_40:EnableDynamicBone(false)
				end
			end

			local var_95_41 = 0.001

			if var_95_39 <= arg_92_1.time_ and arg_92_1.time_ < var_95_39 + var_95_41 then
				local var_95_42 = (arg_92_1.time_ - var_95_39) / var_95_41
				local var_95_43 = Vector3.New(0.7, -1.95, -2.35)

				var_95_38.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos3005_tpose, var_95_43, var_95_42)

				local var_95_44 = manager.ui.mainCamera.transform.position - var_95_38.position

				var_95_38.forward = Vector3.New(var_95_44.x, var_95_44.y, var_95_44.z)

				local var_95_45 = var_95_38.localEulerAngles

				var_95_45.z = 0
				var_95_45.x = 0
				var_95_38.localEulerAngles = var_95_45
			end

			if arg_92_1.time_ >= var_95_39 + var_95_41 and arg_92_1.time_ < var_95_39 + var_95_41 + arg_95_0 then
				var_95_38.localPosition = Vector3.New(0.7, -1.95, -2.35)

				local var_95_46 = manager.ui.mainCamera.transform.position - var_95_38.position

				var_95_38.forward = Vector3.New(var_95_46.x, var_95_46.y, var_95_46.z)

				local var_95_47 = var_95_38.localEulerAngles

				var_95_47.z = 0
				var_95_47.x = 0
				var_95_38.localEulerAngles = var_95_47

				local var_95_48 = GameObjectTools.GetOrAddComponent(var_95_38.gameObject, typeof(DynamicBoneHelper))

				if var_95_48 then
					var_95_48:EnableDynamicBone(true)
				end
			end

			local var_95_49 = 0

			if var_95_49 < arg_92_1.time_ and arg_92_1.time_ <= var_95_49 + arg_95_0 then
				arg_92_1:PlayTimeline("3005_tpose", "StoryTimeline/CharAction/story3005/story3005action/3005action1_1")
			end

			local var_95_50 = 0
			local var_95_51 = 0.225

			if var_95_50 < arg_92_1.time_ and arg_92_1.time_ <= var_95_50 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_52 = arg_92_1:FormatText(StoryNameCfg[58].name)

				arg_92_1.leftNameTxt_.text = var_95_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_53 = arg_92_1:GetWordFromCfg(104061024)
				local var_95_54 = arg_92_1:FormatText(var_95_53.content)

				arg_92_1.text_.text = var_95_54

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_55 = 9
				local var_95_56 = utf8.len(var_95_54)
				local var_95_57 = var_95_55 <= 0 and var_95_51 or var_95_51 * (var_95_56 / var_95_55)

				if var_95_57 > 0 and var_95_51 < var_95_57 then
					arg_92_1.talkMaxDuration = var_95_57

					if var_95_57 + var_95_50 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_57 + var_95_50
					end
				end

				arg_92_1.text_.text = var_95_54
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061024", "story_v_out_104061.awb") ~= 0 then
					local var_95_58 = manager.audio:GetVoiceLength("story_v_out_104061", "104061024", "story_v_out_104061.awb") / 1000

					if var_95_58 + var_95_50 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_58 + var_95_50
					end

					if var_95_53.prefab_name ~= "" and arg_92_1.actors_[var_95_53.prefab_name] ~= nil then
						local var_95_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_53.prefab_name].transform, "story_v_out_104061", "104061024", "story_v_out_104061.awb")

						arg_92_1:RecordAudio("104061024", var_95_59)
						arg_92_1:RecordAudio("104061024", var_95_59)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_104061", "104061024", "story_v_out_104061.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_104061", "104061024", "story_v_out_104061.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_60 = math.max(var_95_51, arg_92_1.talkMaxDuration)

			if var_95_50 <= arg_92_1.time_ and arg_92_1.time_ < var_95_50 + var_95_60 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_50) / var_95_60

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_50 + var_95_60 and arg_92_1.time_ < var_95_50 + var_95_60 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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
				actorName = "2043_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3005_tpose",
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
	Play104061025 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 104061025
		arg_96_1.duration_ = 4.57

		local var_96_0 = {
			ja = 4.566,
			ko = 4.5,
			zh = 4.1,
			en = 4.5
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
				arg_96_0:Play104061026(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1148ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1148ui_story == nil then
				arg_96_1.var_.characterEffect1148ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1148ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1148ui_story then
				arg_96_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_99_4 = arg_96_1.actors_["2043_tpose"]
			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect2043_tpose == nil then
				arg_96_1.var_.characterEffect2043_tpose = var_99_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.1

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 and not isNil(var_99_4) then
				local var_99_7 = (arg_96_1.time_ - var_99_5) / var_99_6

				if arg_96_1.var_.characterEffect2043_tpose and not isNil(var_99_4) then
					local var_99_8 = Mathf.Lerp(0, 0.5, var_99_7)

					arg_96_1.var_.characterEffect2043_tpose.fillFlat = true
					arg_96_1.var_.characterEffect2043_tpose.fillRatio = var_99_8
				end
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect2043_tpose then
				local var_99_9 = 0.5

				arg_96_1.var_.characterEffect2043_tpose.fillFlat = true
				arg_96_1.var_.characterEffect2043_tpose.fillRatio = var_99_9
			end

			local var_99_10 = arg_96_1.actors_["3005_tpose"]
			local var_99_11 = 0

			if var_99_11 < arg_96_1.time_ and arg_96_1.time_ <= var_99_11 + arg_99_0 and not isNil(var_99_10) and arg_96_1.var_.characterEffect3005_tpose == nil then
				arg_96_1.var_.characterEffect3005_tpose = var_99_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_12 = 0.1

			if var_99_11 <= arg_96_1.time_ and arg_96_1.time_ < var_99_11 + var_99_12 and not isNil(var_99_10) then
				local var_99_13 = (arg_96_1.time_ - var_99_11) / var_99_12

				if arg_96_1.var_.characterEffect3005_tpose and not isNil(var_99_10) then
					local var_99_14 = Mathf.Lerp(0, 0.5, var_99_13)

					arg_96_1.var_.characterEffect3005_tpose.fillFlat = true
					arg_96_1.var_.characterEffect3005_tpose.fillRatio = var_99_14
				end
			end

			if arg_96_1.time_ >= var_99_11 + var_99_12 and arg_96_1.time_ < var_99_11 + var_99_12 + arg_99_0 and not isNil(var_99_10) and arg_96_1.var_.characterEffect3005_tpose then
				local var_99_15 = 0.5

				arg_96_1.var_.characterEffect3005_tpose.fillFlat = true
				arg_96_1.var_.characterEffect3005_tpose.fillRatio = var_99_15
			end

			local var_99_16 = arg_96_1.actors_["2043_tpose"].transform
			local var_99_17 = 0

			if var_99_17 < arg_96_1.time_ and arg_96_1.time_ <= var_99_17 + arg_99_0 then
				arg_96_1.var_.moveOldPos2043_tpose = var_99_16.localPosition

				local var_99_18 = GameObjectTools.GetOrAddComponent(var_99_16.gameObject, typeof(DynamicBoneHelper))

				if var_99_18 then
					var_99_18:EnableDynamicBone(false)
				end
			end

			local var_99_19 = 0.001

			if var_99_17 <= arg_96_1.time_ and arg_96_1.time_ < var_99_17 + var_99_19 then
				local var_99_20 = (arg_96_1.time_ - var_99_17) / var_99_19
				local var_99_21 = Vector3.New(0, 100, 0)

				var_99_16.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos2043_tpose, var_99_21, var_99_20)

				local var_99_22 = manager.ui.mainCamera.transform.position - var_99_16.position

				var_99_16.forward = Vector3.New(var_99_22.x, var_99_22.y, var_99_22.z)

				local var_99_23 = var_99_16.localEulerAngles

				var_99_23.z = 0
				var_99_23.x = 0
				var_99_16.localEulerAngles = var_99_23
			end

			if arg_96_1.time_ >= var_99_17 + var_99_19 and arg_96_1.time_ < var_99_17 + var_99_19 + arg_99_0 then
				var_99_16.localPosition = Vector3.New(0, 100, 0)

				local var_99_24 = manager.ui.mainCamera.transform.position - var_99_16.position

				var_99_16.forward = Vector3.New(var_99_24.x, var_99_24.y, var_99_24.z)

				local var_99_25 = var_99_16.localEulerAngles

				var_99_25.z = 0
				var_99_25.x = 0
				var_99_16.localEulerAngles = var_99_25

				local var_99_26 = GameObjectTools.GetOrAddComponent(var_99_16.gameObject, typeof(DynamicBoneHelper))

				if var_99_26 then
					var_99_26:EnableDynamicBone(true)
				end
			end

			local var_99_27 = arg_96_1.actors_["3005_tpose"].transform
			local var_99_28 = 0

			if var_99_28 < arg_96_1.time_ and arg_96_1.time_ <= var_99_28 + arg_99_0 then
				arg_96_1.var_.moveOldPos3005_tpose = var_99_27.localPosition

				local var_99_29 = GameObjectTools.GetOrAddComponent(var_99_27.gameObject, typeof(DynamicBoneHelper))

				if var_99_29 then
					var_99_29:EnableDynamicBone(false)
				end
			end

			local var_99_30 = 0.001

			if var_99_28 <= arg_96_1.time_ and arg_96_1.time_ < var_99_28 + var_99_30 then
				local var_99_31 = (arg_96_1.time_ - var_99_28) / var_99_30
				local var_99_32 = Vector3.New(0, 100, 0)

				var_99_27.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos3005_tpose, var_99_32, var_99_31)

				local var_99_33 = manager.ui.mainCamera.transform.position - var_99_27.position

				var_99_27.forward = Vector3.New(var_99_33.x, var_99_33.y, var_99_33.z)

				local var_99_34 = var_99_27.localEulerAngles

				var_99_34.z = 0
				var_99_34.x = 0
				var_99_27.localEulerAngles = var_99_34
			end

			if arg_96_1.time_ >= var_99_28 + var_99_30 and arg_96_1.time_ < var_99_28 + var_99_30 + arg_99_0 then
				var_99_27.localPosition = Vector3.New(0, 100, 0)

				local var_99_35 = manager.ui.mainCamera.transform.position - var_99_27.position

				var_99_27.forward = Vector3.New(var_99_35.x, var_99_35.y, var_99_35.z)

				local var_99_36 = var_99_27.localEulerAngles

				var_99_36.z = 0
				var_99_36.x = 0
				var_99_27.localEulerAngles = var_99_36

				local var_99_37 = GameObjectTools.GetOrAddComponent(var_99_27.gameObject, typeof(DynamicBoneHelper))

				if var_99_37 then
					var_99_37:EnableDynamicBone(true)
				end
			end

			local var_99_38 = arg_96_1.actors_["1148ui_story"].transform
			local var_99_39 = 0

			if var_99_39 < arg_96_1.time_ and arg_96_1.time_ <= var_99_39 + arg_99_0 then
				arg_96_1.var_.moveOldPos1148ui_story = var_99_38.localPosition
			end

			local var_99_40 = 0.001

			if var_99_39 <= arg_96_1.time_ and arg_96_1.time_ < var_99_39 + var_99_40 then
				local var_99_41 = (arg_96_1.time_ - var_99_39) / var_99_40
				local var_99_42 = Vector3.New(0, -0.8, -6.2)

				var_99_38.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1148ui_story, var_99_42, var_99_41)

				local var_99_43 = manager.ui.mainCamera.transform.position - var_99_38.position

				var_99_38.forward = Vector3.New(var_99_43.x, var_99_43.y, var_99_43.z)

				local var_99_44 = var_99_38.localEulerAngles

				var_99_44.z = 0
				var_99_44.x = 0
				var_99_38.localEulerAngles = var_99_44
			end

			if arg_96_1.time_ >= var_99_39 + var_99_40 and arg_96_1.time_ < var_99_39 + var_99_40 + arg_99_0 then
				var_99_38.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_99_45 = manager.ui.mainCamera.transform.position - var_99_38.position

				var_99_38.forward = Vector3.New(var_99_45.x, var_99_45.y, var_99_45.z)

				local var_99_46 = var_99_38.localEulerAngles

				var_99_46.z = 0
				var_99_46.x = 0
				var_99_38.localEulerAngles = var_99_46
			end

			local var_99_47 = 0

			if var_99_47 < arg_96_1.time_ and arg_96_1.time_ <= var_99_47 + arg_99_0 then
				arg_96_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_99_48 = 0

			if var_99_48 < arg_96_1.time_ and arg_96_1.time_ <= var_99_48 + arg_99_0 then
				arg_96_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_99_49 = 0
			local var_99_50 = 0.4

			if var_99_49 < arg_96_1.time_ and arg_96_1.time_ <= var_99_49 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_51 = arg_96_1:FormatText(StoryNameCfg[8].name)

				arg_96_1.leftNameTxt_.text = var_99_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_52 = arg_96_1:GetWordFromCfg(104061025)
				local var_99_53 = arg_96_1:FormatText(var_99_52.content)

				arg_96_1.text_.text = var_99_53

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_54 = 16
				local var_99_55 = utf8.len(var_99_53)
				local var_99_56 = var_99_54 <= 0 and var_99_50 or var_99_50 * (var_99_55 / var_99_54)

				if var_99_56 > 0 and var_99_50 < var_99_56 then
					arg_96_1.talkMaxDuration = var_99_56

					if var_99_56 + var_99_49 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_56 + var_99_49
					end
				end

				arg_96_1.text_.text = var_99_53
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061025", "story_v_out_104061.awb") ~= 0 then
					local var_99_57 = manager.audio:GetVoiceLength("story_v_out_104061", "104061025", "story_v_out_104061.awb") / 1000

					if var_99_57 + var_99_49 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_57 + var_99_49
					end

					if var_99_52.prefab_name ~= "" and arg_96_1.actors_[var_99_52.prefab_name] ~= nil then
						local var_99_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_52.prefab_name].transform, "story_v_out_104061", "104061025", "story_v_out_104061.awb")

						arg_96_1:RecordAudio("104061025", var_99_58)
						arg_96_1:RecordAudio("104061025", var_99_58)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_104061", "104061025", "story_v_out_104061.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_104061", "104061025", "story_v_out_104061.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_59 = math.max(var_99_50, arg_96_1.talkMaxDuration)

			if var_99_49 <= arg_96_1.time_ and arg_96_1.time_ < var_99_49 + var_99_59 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_49) / var_99_59

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_49 + var_99_59 and arg_96_1.time_ < var_99_49 + var_99_59 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2043_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3005_tpose",
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

		arg_96_1:InitPlayNodeList()
	end,
	Play104061026 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 104061026
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play104061027(arg_100_1)
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
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1148ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1148ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1148ui_story.fillRatio = var_103_5
			end

			local var_103_6 = arg_100_1.actors_["1148ui_story"].transform
			local var_103_7 = 0

			if var_103_7 < arg_100_1.time_ and arg_100_1.time_ <= var_103_7 + arg_103_0 then
				arg_100_1.var_.moveOldPos1148ui_story = var_103_6.localPosition
			end

			local var_103_8 = 0.001

			if var_103_7 <= arg_100_1.time_ and arg_100_1.time_ < var_103_7 + var_103_8 then
				local var_103_9 = (arg_100_1.time_ - var_103_7) / var_103_8
				local var_103_10 = Vector3.New(0, 100, 0)

				var_103_6.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1148ui_story, var_103_10, var_103_9)

				local var_103_11 = manager.ui.mainCamera.transform.position - var_103_6.position

				var_103_6.forward = Vector3.New(var_103_11.x, var_103_11.y, var_103_11.z)

				local var_103_12 = var_103_6.localEulerAngles

				var_103_12.z = 0
				var_103_12.x = 0
				var_103_6.localEulerAngles = var_103_12
			end

			if arg_100_1.time_ >= var_103_7 + var_103_8 and arg_100_1.time_ < var_103_7 + var_103_8 + arg_103_0 then
				var_103_6.localPosition = Vector3.New(0, 100, 0)

				local var_103_13 = manager.ui.mainCamera.transform.position - var_103_6.position

				var_103_6.forward = Vector3.New(var_103_13.x, var_103_13.y, var_103_13.z)

				local var_103_14 = var_103_6.localEulerAngles

				var_103_14.z = 0
				var_103_14.x = 0
				var_103_6.localEulerAngles = var_103_14
			end

			local var_103_15 = 0

			if var_103_15 < arg_100_1.time_ and arg_100_1.time_ <= var_103_15 + arg_103_0 then
				arg_100_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			local var_103_16 = 0
			local var_103_17 = 1.275

			if var_103_16 < arg_100_1.time_ and arg_100_1.time_ <= var_103_16 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_18 = arg_100_1:GetWordFromCfg(104061026)
				local var_103_19 = arg_100_1:FormatText(var_103_18.content)

				arg_100_1.text_.text = var_103_19

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_20 = 51
				local var_103_21 = utf8.len(var_103_19)
				local var_103_22 = var_103_20 <= 0 and var_103_17 or var_103_17 * (var_103_21 / var_103_20)

				if var_103_22 > 0 and var_103_17 < var_103_22 then
					arg_100_1.talkMaxDuration = var_103_22

					if var_103_22 + var_103_16 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_22 + var_103_16
					end
				end

				arg_100_1.text_.text = var_103_19
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_23 = math.max(var_103_17, arg_100_1.talkMaxDuration)

			if var_103_16 <= arg_100_1.time_ and arg_100_1.time_ < var_103_16 + var_103_23 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_16) / var_103_23

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_16 + var_103_23 and arg_100_1.time_ < var_103_16 + var_103_23 + arg_103_0 then
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
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play104061027 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 104061027
		arg_104_1.duration_ = 4.3

		local var_104_0 = {
			ja = 4.3,
			ko = 3.033,
			zh = 3.766,
			en = 3.2
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
				arg_104_0:Play104061028(arg_104_1)
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

			local var_107_4 = arg_104_1.actors_["1059ui_story"].transform
			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 then
				arg_104_1.var_.moveOldPos1059ui_story = var_107_4.localPosition
			end

			local var_107_6 = 0.001

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_6 then
				local var_107_7 = (arg_104_1.time_ - var_107_5) / var_107_6
				local var_107_8 = Vector3.New(0, -1.05, -6)

				var_107_4.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1059ui_story, var_107_8, var_107_7)

				local var_107_9 = manager.ui.mainCamera.transform.position - var_107_4.position

				var_107_4.forward = Vector3.New(var_107_9.x, var_107_9.y, var_107_9.z)

				local var_107_10 = var_107_4.localEulerAngles

				var_107_10.z = 0
				var_107_10.x = 0
				var_107_4.localEulerAngles = var_107_10
			end

			if arg_104_1.time_ >= var_107_5 + var_107_6 and arg_104_1.time_ < var_107_5 + var_107_6 + arg_107_0 then
				var_107_4.localPosition = Vector3.New(0, -1.05, -6)

				local var_107_11 = manager.ui.mainCamera.transform.position - var_107_4.position

				var_107_4.forward = Vector3.New(var_107_11.x, var_107_11.y, var_107_11.z)

				local var_107_12 = var_107_4.localEulerAngles

				var_107_12.z = 0
				var_107_12.x = 0
				var_107_4.localEulerAngles = var_107_12
			end

			local var_107_13 = 0

			if var_107_13 < arg_104_1.time_ and arg_104_1.time_ <= var_107_13 + arg_107_0 then
				arg_104_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_107_14 = 0
			local var_107_15 = 0.4

			if var_107_14 < arg_104_1.time_ and arg_104_1.time_ <= var_107_14 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_16 = arg_104_1:FormatText(StoryNameCfg[28].name)

				arg_104_1.leftNameTxt_.text = var_107_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_17 = arg_104_1:GetWordFromCfg(104061027)
				local var_107_18 = arg_104_1:FormatText(var_107_17.content)

				arg_104_1.text_.text = var_107_18

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_19 = 16
				local var_107_20 = utf8.len(var_107_18)
				local var_107_21 = var_107_19 <= 0 and var_107_15 or var_107_15 * (var_107_20 / var_107_19)

				if var_107_21 > 0 and var_107_15 < var_107_21 then
					arg_104_1.talkMaxDuration = var_107_21

					if var_107_21 + var_107_14 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_21 + var_107_14
					end
				end

				arg_104_1.text_.text = var_107_18
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061027", "story_v_out_104061.awb") ~= 0 then
					local var_107_22 = manager.audio:GetVoiceLength("story_v_out_104061", "104061027", "story_v_out_104061.awb") / 1000

					if var_107_22 + var_107_14 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_22 + var_107_14
					end

					if var_107_17.prefab_name ~= "" and arg_104_1.actors_[var_107_17.prefab_name] ~= nil then
						local var_107_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_17.prefab_name].transform, "story_v_out_104061", "104061027", "story_v_out_104061.awb")

						arg_104_1:RecordAudio("104061027", var_107_23)
						arg_104_1:RecordAudio("104061027", var_107_23)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_104061", "104061027", "story_v_out_104061.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_104061", "104061027", "story_v_out_104061.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_24 = math.max(var_107_15, arg_104_1.talkMaxDuration)

			if var_107_14 <= arg_104_1.time_ and arg_104_1.time_ < var_107_14 + var_107_24 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_14) / var_107_24

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_14 + var_107_24 and arg_104_1.time_ < var_107_14 + var_107_24 + arg_107_0 then
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
	Play104061028 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 104061028
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play104061029(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 1

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				local var_111_2 = "play"
				local var_111_3 = "effect"

				arg_108_1:AudioAction(var_111_2, var_111_3, "se_story_4", "se_story_4_arm_2", "")
			end

			local var_111_4 = arg_108_1.actors_["3005_tpose"]
			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect3005_tpose == nil then
				arg_108_1.var_.characterEffect3005_tpose = var_111_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_6 = 0.1

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_6 and not isNil(var_111_4) then
				local var_111_7 = (arg_108_1.time_ - var_111_5) / var_111_6

				if arg_108_1.var_.characterEffect3005_tpose and not isNil(var_111_4) then
					arg_108_1.var_.characterEffect3005_tpose.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_5 + var_111_6 and arg_108_1.time_ < var_111_5 + var_111_6 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect3005_tpose then
				arg_108_1.var_.characterEffect3005_tpose.fillFlat = false
			end

			local var_111_8 = arg_108_1.actors_["1059ui_story"]
			local var_111_9 = 0

			if var_111_9 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.characterEffect1059ui_story == nil then
				arg_108_1.var_.characterEffect1059ui_story = var_111_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_10 = 0.1

			if var_111_9 <= arg_108_1.time_ and arg_108_1.time_ < var_111_9 + var_111_10 and not isNil(var_111_8) then
				local var_111_11 = (arg_108_1.time_ - var_111_9) / var_111_10

				if arg_108_1.var_.characterEffect1059ui_story and not isNil(var_111_8) then
					local var_111_12 = Mathf.Lerp(0, 0.5, var_111_11)

					arg_108_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1059ui_story.fillRatio = var_111_12
				end
			end

			if arg_108_1.time_ >= var_111_9 + var_111_10 and arg_108_1.time_ < var_111_9 + var_111_10 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.characterEffect1059ui_story then
				local var_111_13 = 0.5

				arg_108_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1059ui_story.fillRatio = var_111_13
			end

			local var_111_14 = arg_108_1.actors_["1059ui_story"].transform
			local var_111_15 = 0

			if var_111_15 < arg_108_1.time_ and arg_108_1.time_ <= var_111_15 + arg_111_0 then
				arg_108_1.var_.moveOldPos1059ui_story = var_111_14.localPosition
			end

			local var_111_16 = 0.001

			if var_111_15 <= arg_108_1.time_ and arg_108_1.time_ < var_111_15 + var_111_16 then
				local var_111_17 = (arg_108_1.time_ - var_111_15) / var_111_16
				local var_111_18 = Vector3.New(0, 100, 0)

				var_111_14.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1059ui_story, var_111_18, var_111_17)

				local var_111_19 = manager.ui.mainCamera.transform.position - var_111_14.position

				var_111_14.forward = Vector3.New(var_111_19.x, var_111_19.y, var_111_19.z)

				local var_111_20 = var_111_14.localEulerAngles

				var_111_20.z = 0
				var_111_20.x = 0
				var_111_14.localEulerAngles = var_111_20
			end

			if arg_108_1.time_ >= var_111_15 + var_111_16 and arg_108_1.time_ < var_111_15 + var_111_16 + arg_111_0 then
				var_111_14.localPosition = Vector3.New(0, 100, 0)

				local var_111_21 = manager.ui.mainCamera.transform.position - var_111_14.position

				var_111_14.forward = Vector3.New(var_111_21.x, var_111_21.y, var_111_21.z)

				local var_111_22 = var_111_14.localEulerAngles

				var_111_22.z = 0
				var_111_22.x = 0
				var_111_14.localEulerAngles = var_111_22
			end

			local var_111_23 = arg_108_1.actors_["3005_tpose"].transform
			local var_111_24 = 0

			if var_111_24 < arg_108_1.time_ and arg_108_1.time_ <= var_111_24 + arg_111_0 then
				arg_108_1.var_.moveOldPos3005_tpose = var_111_23.localPosition

				local var_111_25 = GameObjectTools.GetOrAddComponent(var_111_23.gameObject, typeof(DynamicBoneHelper))

				if var_111_25 then
					var_111_25:EnableDynamicBone(false)
				end
			end

			local var_111_26 = 0.001

			if var_111_24 <= arg_108_1.time_ and arg_108_1.time_ < var_111_24 + var_111_26 then
				local var_111_27 = (arg_108_1.time_ - var_111_24) / var_111_26
				local var_111_28 = Vector3.New(0, -1.95, -2.63)

				var_111_23.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos3005_tpose, var_111_28, var_111_27)

				local var_111_29 = manager.ui.mainCamera.transform.position - var_111_23.position

				var_111_23.forward = Vector3.New(var_111_29.x, var_111_29.y, var_111_29.z)

				local var_111_30 = var_111_23.localEulerAngles

				var_111_30.z = 0
				var_111_30.x = 0
				var_111_23.localEulerAngles = var_111_30
			end

			if arg_108_1.time_ >= var_111_24 + var_111_26 and arg_108_1.time_ < var_111_24 + var_111_26 + arg_111_0 then
				var_111_23.localPosition = Vector3.New(0, -1.95, -2.63)

				local var_111_31 = manager.ui.mainCamera.transform.position - var_111_23.position

				var_111_23.forward = Vector3.New(var_111_31.x, var_111_31.y, var_111_31.z)

				local var_111_32 = var_111_23.localEulerAngles

				var_111_32.z = 0
				var_111_32.x = 0
				var_111_23.localEulerAngles = var_111_32

				local var_111_33 = GameObjectTools.GetOrAddComponent(var_111_23.gameObject, typeof(DynamicBoneHelper))

				if var_111_33 then
					var_111_33:EnableDynamicBone(true)
				end
			end

			local var_111_34 = 0

			if var_111_34 < arg_108_1.time_ and arg_108_1.time_ <= var_111_34 + arg_111_0 then
				arg_108_1:PlayTimeline("3005_tpose", "StoryTimeline/CharAction/story3005/story3005action/3005action1_1")
			end

			local var_111_35 = 0
			local var_111_36 = 0.525

			if var_111_35 < arg_108_1.time_ and arg_108_1.time_ <= var_111_35 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_37 = arg_108_1:GetWordFromCfg(104061028)
				local var_111_38 = arg_108_1:FormatText(var_111_37.content)

				arg_108_1.text_.text = var_111_38

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_39 = 21
				local var_111_40 = utf8.len(var_111_38)
				local var_111_41 = var_111_39 <= 0 and var_111_36 or var_111_36 * (var_111_40 / var_111_39)

				if var_111_41 > 0 and var_111_36 < var_111_41 then
					arg_108_1.talkMaxDuration = var_111_41

					if var_111_41 + var_111_35 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_41 + var_111_35
					end
				end

				arg_108_1.text_.text = var_111_38
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_42 = math.max(var_111_36, arg_108_1.talkMaxDuration)

			if var_111_35 <= arg_108_1.time_ and arg_108_1.time_ < var_111_35 + var_111_42 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_35) / var_111_42

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_35 + var_111_42 and arg_108_1.time_ < var_111_35 + var_111_42 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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
				actorName = "3005_tpose",
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
	Play104061029 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 104061029
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play104061030(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["3005_tpose"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect3005_tpose == nil then
				arg_112_1.var_.characterEffect3005_tpose = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.1

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect3005_tpose and not isNil(var_115_0) then
					local var_115_4 = Mathf.Lerp(0, 0.5, var_115_3)

					arg_112_1.var_.characterEffect3005_tpose.fillFlat = true
					arg_112_1.var_.characterEffect3005_tpose.fillRatio = var_115_4
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect3005_tpose then
				local var_115_5 = 0.5

				arg_112_1.var_.characterEffect3005_tpose.fillFlat = true
				arg_112_1.var_.characterEffect3005_tpose.fillRatio = var_115_5
			end

			local var_115_6 = arg_112_1.actors_["3005_tpose"].transform
			local var_115_7 = 0

			if var_115_7 < arg_112_1.time_ and arg_112_1.time_ <= var_115_7 + arg_115_0 then
				arg_112_1.var_.moveOldPos3005_tpose = var_115_6.localPosition

				local var_115_8 = GameObjectTools.GetOrAddComponent(var_115_6.gameObject, typeof(DynamicBoneHelper))

				if var_115_8 then
					var_115_8:EnableDynamicBone(false)
				end
			end

			local var_115_9 = 0.001

			if var_115_7 <= arg_112_1.time_ and arg_112_1.time_ < var_115_7 + var_115_9 then
				local var_115_10 = (arg_112_1.time_ - var_115_7) / var_115_9
				local var_115_11 = Vector3.New(0, 100, 0)

				var_115_6.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos3005_tpose, var_115_11, var_115_10)

				local var_115_12 = manager.ui.mainCamera.transform.position - var_115_6.position

				var_115_6.forward = Vector3.New(var_115_12.x, var_115_12.y, var_115_12.z)

				local var_115_13 = var_115_6.localEulerAngles

				var_115_13.z = 0
				var_115_13.x = 0
				var_115_6.localEulerAngles = var_115_13
			end

			if arg_112_1.time_ >= var_115_7 + var_115_9 and arg_112_1.time_ < var_115_7 + var_115_9 + arg_115_0 then
				var_115_6.localPosition = Vector3.New(0, 100, 0)

				local var_115_14 = manager.ui.mainCamera.transform.position - var_115_6.position

				var_115_6.forward = Vector3.New(var_115_14.x, var_115_14.y, var_115_14.z)

				local var_115_15 = var_115_6.localEulerAngles

				var_115_15.z = 0
				var_115_15.x = 0
				var_115_6.localEulerAngles = var_115_15

				local var_115_16 = GameObjectTools.GetOrAddComponent(var_115_6.gameObject, typeof(DynamicBoneHelper))

				if var_115_16 then
					var_115_16:EnableDynamicBone(true)
				end
			end

			local var_115_17 = 0
			local var_115_18 = 0.725

			if var_115_17 < arg_112_1.time_ and arg_112_1.time_ <= var_115_17 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_19 = arg_112_1:FormatText(StoryNameCfg[7].name)

				arg_112_1.leftNameTxt_.text = var_115_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_20 = arg_112_1:GetWordFromCfg(104061029)
				local var_115_21 = arg_112_1:FormatText(var_115_20.content)

				arg_112_1.text_.text = var_115_21

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_22 = 29
				local var_115_23 = utf8.len(var_115_21)
				local var_115_24 = var_115_22 <= 0 and var_115_18 or var_115_18 * (var_115_23 / var_115_22)

				if var_115_24 > 0 and var_115_18 < var_115_24 then
					arg_112_1.talkMaxDuration = var_115_24

					if var_115_24 + var_115_17 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_24 + var_115_17
					end
				end

				arg_112_1.text_.text = var_115_21
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_25 = math.max(var_115_18, arg_112_1.talkMaxDuration)

			if var_115_17 <= arg_112_1.time_ and arg_112_1.time_ < var_115_17 + var_115_25 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_17) / var_115_25

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_17 + var_115_25 and arg_112_1.time_ < var_115_17 + var_115_25 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3005_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play104061030 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 104061030
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play104061031(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 1.2

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[7].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:GetWordFromCfg(104061030)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 48
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_8 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_8 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_8

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_8 and arg_116_1.time_ < var_119_0 + var_119_8 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play104061031 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 104061031
		arg_120_1.duration_ = 8.83

		local var_120_0 = {
			ja = 8.833,
			ko = 5.033,
			zh = 7.3,
			en = 6.333
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
				arg_120_0:Play104061032(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1059ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1059ui_story == nil then
				arg_120_1.var_.characterEffect1059ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.1

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1059ui_story and not isNil(var_123_0) then
					arg_120_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1059ui_story then
				arg_120_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_123_4 = arg_120_1.actors_["1059ui_story"].transform
			local var_123_5 = 0

			if var_123_5 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1.var_.moveOldPos1059ui_story = var_123_4.localPosition
			end

			local var_123_6 = 0.001

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_6 then
				local var_123_7 = (arg_120_1.time_ - var_123_5) / var_123_6
				local var_123_8 = Vector3.New(0, -1.05, -6)

				var_123_4.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1059ui_story, var_123_8, var_123_7)

				local var_123_9 = manager.ui.mainCamera.transform.position - var_123_4.position

				var_123_4.forward = Vector3.New(var_123_9.x, var_123_9.y, var_123_9.z)

				local var_123_10 = var_123_4.localEulerAngles

				var_123_10.z = 0
				var_123_10.x = 0
				var_123_4.localEulerAngles = var_123_10
			end

			if arg_120_1.time_ >= var_123_5 + var_123_6 and arg_120_1.time_ < var_123_5 + var_123_6 + arg_123_0 then
				var_123_4.localPosition = Vector3.New(0, -1.05, -6)

				local var_123_11 = manager.ui.mainCamera.transform.position - var_123_4.position

				var_123_4.forward = Vector3.New(var_123_11.x, var_123_11.y, var_123_11.z)

				local var_123_12 = var_123_4.localEulerAngles

				var_123_12.z = 0
				var_123_12.x = 0
				var_123_4.localEulerAngles = var_123_12
			end

			local var_123_13 = 0

			if var_123_13 < arg_120_1.time_ and arg_120_1.time_ <= var_123_13 + arg_123_0 then
				arg_120_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			local var_123_14 = 0

			if var_123_14 < arg_120_1.time_ and arg_120_1.time_ <= var_123_14 + arg_123_0 then
				arg_120_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_123_15 = 0
			local var_123_16 = 0.725

			if var_123_15 < arg_120_1.time_ and arg_120_1.time_ <= var_123_15 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_17 = arg_120_1:FormatText(StoryNameCfg[28].name)

				arg_120_1.leftNameTxt_.text = var_123_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_18 = arg_120_1:GetWordFromCfg(104061031)
				local var_123_19 = arg_120_1:FormatText(var_123_18.content)

				arg_120_1.text_.text = var_123_19

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_20 = 29
				local var_123_21 = utf8.len(var_123_19)
				local var_123_22 = var_123_20 <= 0 and var_123_16 or var_123_16 * (var_123_21 / var_123_20)

				if var_123_22 > 0 and var_123_16 < var_123_22 then
					arg_120_1.talkMaxDuration = var_123_22

					if var_123_22 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_22 + var_123_15
					end
				end

				arg_120_1.text_.text = var_123_19
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061031", "story_v_out_104061.awb") ~= 0 then
					local var_123_23 = manager.audio:GetVoiceLength("story_v_out_104061", "104061031", "story_v_out_104061.awb") / 1000

					if var_123_23 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_23 + var_123_15
					end

					if var_123_18.prefab_name ~= "" and arg_120_1.actors_[var_123_18.prefab_name] ~= nil then
						local var_123_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_18.prefab_name].transform, "story_v_out_104061", "104061031", "story_v_out_104061.awb")

						arg_120_1:RecordAudio("104061031", var_123_24)
						arg_120_1:RecordAudio("104061031", var_123_24)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_104061", "104061031", "story_v_out_104061.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_104061", "104061031", "story_v_out_104061.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_25 = math.max(var_123_16, arg_120_1.talkMaxDuration)

			if var_123_15 <= arg_120_1.time_ and arg_120_1.time_ < var_123_15 + var_123_25 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_15) / var_123_25

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_15 + var_123_25 and arg_120_1.time_ < var_123_15 + var_123_25 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
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

		arg_120_1:InitPlayNodeList()
	end,
	Play104061032 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 104061032
		arg_124_1.duration_ = 0.1

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"

			SetActive(arg_124_1.choicesGo_, true)

			for iter_125_0, iter_125_1 in ipairs(arg_124_1.choices_) do
				local var_125_0 = iter_125_0 <= 2

				SetActive(iter_125_1.go, var_125_0)
			end

			arg_124_1.choices_[1].txt.text = arg_124_1:FormatText(StoryChoiceCfg[25].name)
			arg_124_1.choices_[2].txt.text = arg_124_1:FormatText(StoryChoiceCfg[26].name)
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play104061033(arg_124_1)
			end

			if arg_126_0 == 2 then
				arg_124_0:Play104061033(arg_124_1)
			end

			arg_124_1:RecordChoiceLog(104061032, 25, 26)
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1059ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1059ui_story == nil then
				arg_124_1.var_.characterEffect1059ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.1

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect1059ui_story and not isNil(var_127_0) then
					local var_127_4 = Mathf.Lerp(0, 0.5, var_127_3)

					arg_124_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1059ui_story.fillRatio = var_127_4
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1059ui_story then
				local var_127_5 = 0.5

				arg_124_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1059ui_story.fillRatio = var_127_5
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play104061033 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 104061033
		arg_128_1.duration_ = 3.17

		local var_128_0 = {
			ja = 2.466,
			ko = 2.9,
			zh = 3.166,
			en = 2.366
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
				arg_128_0:Play104061034(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1148ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1148ui_story == nil then
				arg_128_1.var_.characterEffect1148ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.1

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1148ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1148ui_story then
				arg_128_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["1059ui_story"].transform
			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.var_.moveOldPos1059ui_story = var_131_4.localPosition
			end

			local var_131_6 = 0.001

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_6 then
				local var_131_7 = (arg_128_1.time_ - var_131_5) / var_131_6
				local var_131_8 = Vector3.New(0, 100, 0)

				var_131_4.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1059ui_story, var_131_8, var_131_7)

				local var_131_9 = manager.ui.mainCamera.transform.position - var_131_4.position

				var_131_4.forward = Vector3.New(var_131_9.x, var_131_9.y, var_131_9.z)

				local var_131_10 = var_131_4.localEulerAngles

				var_131_10.z = 0
				var_131_10.x = 0
				var_131_4.localEulerAngles = var_131_10
			end

			if arg_128_1.time_ >= var_131_5 + var_131_6 and arg_128_1.time_ < var_131_5 + var_131_6 + arg_131_0 then
				var_131_4.localPosition = Vector3.New(0, 100, 0)

				local var_131_11 = manager.ui.mainCamera.transform.position - var_131_4.position

				var_131_4.forward = Vector3.New(var_131_11.x, var_131_11.y, var_131_11.z)

				local var_131_12 = var_131_4.localEulerAngles

				var_131_12.z = 0
				var_131_12.x = 0
				var_131_4.localEulerAngles = var_131_12
			end

			local var_131_13 = arg_128_1.actors_["1148ui_story"].transform
			local var_131_14 = 0

			if var_131_14 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 then
				arg_128_1.var_.moveOldPos1148ui_story = var_131_13.localPosition
			end

			local var_131_15 = 0.001

			if var_131_14 <= arg_128_1.time_ and arg_128_1.time_ < var_131_14 + var_131_15 then
				local var_131_16 = (arg_128_1.time_ - var_131_14) / var_131_15
				local var_131_17 = Vector3.New(0, -0.8, -6.2)

				var_131_13.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1148ui_story, var_131_17, var_131_16)

				local var_131_18 = manager.ui.mainCamera.transform.position - var_131_13.position

				var_131_13.forward = Vector3.New(var_131_18.x, var_131_18.y, var_131_18.z)

				local var_131_19 = var_131_13.localEulerAngles

				var_131_19.z = 0
				var_131_19.x = 0
				var_131_13.localEulerAngles = var_131_19
			end

			if arg_128_1.time_ >= var_131_14 + var_131_15 and arg_128_1.time_ < var_131_14 + var_131_15 + arg_131_0 then
				var_131_13.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_131_20 = manager.ui.mainCamera.transform.position - var_131_13.position

				var_131_13.forward = Vector3.New(var_131_20.x, var_131_20.y, var_131_20.z)

				local var_131_21 = var_131_13.localEulerAngles

				var_131_21.z = 0
				var_131_21.x = 0
				var_131_13.localEulerAngles = var_131_21
			end

			local var_131_22 = "1148ui_story"

			if arg_128_1.actors_[var_131_22] == nil then
				local var_131_23 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_131_23) then
					local var_131_24 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_128_1.stage_.transform)

					var_131_24.name = var_131_22
					var_131_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_128_1.actors_[var_131_22] = var_131_24

					local var_131_25 = var_131_24:GetComponentInChildren(typeof(CharacterEffect))

					var_131_25.enabled = true

					local var_131_26 = GameObjectTools.GetOrAddComponent(var_131_24, typeof(DynamicBoneHelper))

					if var_131_26 then
						var_131_26:EnableDynamicBone(false)
					end

					arg_128_1:ShowWeapon(var_131_25.transform, false)

					arg_128_1.var_[var_131_22 .. "Animator"] = var_131_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_128_1.var_[var_131_22 .. "Animator"].applyRootMotion = true
					arg_128_1.var_[var_131_22 .. "LipSync"] = var_131_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_131_27 = 0

			if var_131_27 < arg_128_1.time_ and arg_128_1.time_ <= var_131_27 + arg_131_0 then
				arg_128_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_131_28 = "1148ui_story"

			if arg_128_1.actors_[var_131_28] == nil then
				local var_131_29 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_131_29) then
					local var_131_30 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_128_1.stage_.transform)

					var_131_30.name = var_131_28
					var_131_30.transform.localPosition = Vector3.New(0, 100, 0)
					arg_128_1.actors_[var_131_28] = var_131_30

					local var_131_31 = var_131_30:GetComponentInChildren(typeof(CharacterEffect))

					var_131_31.enabled = true

					local var_131_32 = GameObjectTools.GetOrAddComponent(var_131_30, typeof(DynamicBoneHelper))

					if var_131_32 then
						var_131_32:EnableDynamicBone(false)
					end

					arg_128_1:ShowWeapon(var_131_31.transform, false)

					arg_128_1.var_[var_131_28 .. "Animator"] = var_131_31.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_128_1.var_[var_131_28 .. "Animator"].applyRootMotion = true
					arg_128_1.var_[var_131_28 .. "LipSync"] = var_131_31.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_131_33 = 0

			if var_131_33 < arg_128_1.time_ and arg_128_1.time_ <= var_131_33 + arg_131_0 then
				arg_128_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_131_34 = 0
			local var_131_35 = 0.25

			if var_131_34 < arg_128_1.time_ and arg_128_1.time_ <= var_131_34 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_36 = arg_128_1:FormatText(StoryNameCfg[8].name)

				arg_128_1.leftNameTxt_.text = var_131_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_37 = arg_128_1:GetWordFromCfg(104061033)
				local var_131_38 = arg_128_1:FormatText(var_131_37.content)

				arg_128_1.text_.text = var_131_38

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_39 = 10
				local var_131_40 = utf8.len(var_131_38)
				local var_131_41 = var_131_39 <= 0 and var_131_35 or var_131_35 * (var_131_40 / var_131_39)

				if var_131_41 > 0 and var_131_35 < var_131_41 then
					arg_128_1.talkMaxDuration = var_131_41

					if var_131_41 + var_131_34 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_41 + var_131_34
					end
				end

				arg_128_1.text_.text = var_131_38
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061033", "story_v_out_104061.awb") ~= 0 then
					local var_131_42 = manager.audio:GetVoiceLength("story_v_out_104061", "104061033", "story_v_out_104061.awb") / 1000

					if var_131_42 + var_131_34 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_42 + var_131_34
					end

					if var_131_37.prefab_name ~= "" and arg_128_1.actors_[var_131_37.prefab_name] ~= nil then
						local var_131_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_37.prefab_name].transform, "story_v_out_104061", "104061033", "story_v_out_104061.awb")

						arg_128_1:RecordAudio("104061033", var_131_43)
						arg_128_1:RecordAudio("104061033", var_131_43)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_104061", "104061033", "story_v_out_104061.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_104061", "104061033", "story_v_out_104061.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_44 = math.max(var_131_35, arg_128_1.talkMaxDuration)

			if var_131_34 <= arg_128_1.time_ and arg_128_1.time_ < var_131_34 + var_131_44 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_34) / var_131_44

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_34 + var_131_44 and arg_128_1.time_ < var_131_34 + var_131_44 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play104061034 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 104061034
		arg_132_1.duration_ = 6.37

		local var_132_0 = {
			ja = 6.366,
			ko = 4.266,
			zh = 4.2,
			en = 4.266
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
				arg_132_0:Play104061035(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 1

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				local var_135_2 = "play"
				local var_135_3 = "effect"

				arg_132_1:AudioAction(var_135_2, var_135_3, "se_story_4", "se_story_4_arm_3", "")
			end

			local var_135_4 = 0

			if var_135_4 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action432")
			end

			local var_135_5 = 0

			if var_135_5 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_135_6 = 0
			local var_135_7 = 0.45

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_8 = arg_132_1:FormatText(StoryNameCfg[8].name)

				arg_132_1.leftNameTxt_.text = var_135_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_9 = arg_132_1:GetWordFromCfg(104061034)
				local var_135_10 = arg_132_1:FormatText(var_135_9.content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 18
				local var_135_12 = utf8.len(var_135_10)
				local var_135_13 = var_135_11 <= 0 and var_135_7 or var_135_7 * (var_135_12 / var_135_11)

				if var_135_13 > 0 and var_135_7 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_10
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061034", "story_v_out_104061.awb") ~= 0 then
					local var_135_14 = manager.audio:GetVoiceLength("story_v_out_104061", "104061034", "story_v_out_104061.awb") / 1000

					if var_135_14 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_14 + var_135_6
					end

					if var_135_9.prefab_name ~= "" and arg_132_1.actors_[var_135_9.prefab_name] ~= nil then
						local var_135_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_9.prefab_name].transform, "story_v_out_104061", "104061034", "story_v_out_104061.awb")

						arg_132_1:RecordAudio("104061034", var_135_15)
						arg_132_1:RecordAudio("104061034", var_135_15)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_104061", "104061034", "story_v_out_104061.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_104061", "104061034", "story_v_out_104061.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_16 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_16 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_16

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_16 and arg_132_1.time_ < var_135_6 + var_135_16 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play104061035 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 104061035
		arg_136_1.duration_ = 6.4

		local var_136_0 = {
			ja = 6.4,
			ko = 6.033,
			zh = 5.566,
			en = 4.266
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
			arg_136_1.auto_ = false
		end

		function arg_136_1.playNext_(arg_138_0)
			arg_136_1.onStoryFinished_()
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
				local var_139_14 = Vector3.New(0, -0.8, -6.2)

				var_139_10.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1148ui_story, var_139_14, var_139_13)

				local var_139_15 = manager.ui.mainCamera.transform.position - var_139_10.position

				var_139_10.forward = Vector3.New(var_139_15.x, var_139_15.y, var_139_15.z)

				local var_139_16 = var_139_10.localEulerAngles

				var_139_16.z = 0
				var_139_16.x = 0
				var_139_10.localEulerAngles = var_139_16
			end

			if arg_136_1.time_ >= var_139_11 + var_139_12 and arg_136_1.time_ < var_139_11 + var_139_12 + arg_139_0 then
				var_139_10.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_139_17 = manager.ui.mainCamera.transform.position - var_139_10.position

				var_139_10.forward = Vector3.New(var_139_17.x, var_139_17.y, var_139_17.z)

				local var_139_18 = var_139_10.localEulerAngles

				var_139_18.z = 0
				var_139_18.x = 0
				var_139_10.localEulerAngles = var_139_18
			end

			local var_139_19 = arg_136_1.actors_["1148ui_story"].transform
			local var_139_20 = 0.033

			if var_139_20 < arg_136_1.time_ and arg_136_1.time_ <= var_139_20 + arg_139_0 then
				arg_136_1.var_.moveOldPos1148ui_story = var_139_19.localPosition
			end

			local var_139_21 = 0.5

			if var_139_20 <= arg_136_1.time_ and arg_136_1.time_ < var_139_20 + var_139_21 then
				local var_139_22 = (arg_136_1.time_ - var_139_20) / var_139_21
				local var_139_23 = Vector3.New(-0.7, -0.8, -6.2)

				var_139_19.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1148ui_story, var_139_23, var_139_22)

				local var_139_24 = manager.ui.mainCamera.transform.position - var_139_19.position

				var_139_19.forward = Vector3.New(var_139_24.x, var_139_24.y, var_139_24.z)

				local var_139_25 = var_139_19.localEulerAngles

				var_139_25.z = 0
				var_139_25.x = 0
				var_139_19.localEulerAngles = var_139_25
			end

			if arg_136_1.time_ >= var_139_20 + var_139_21 and arg_136_1.time_ < var_139_20 + var_139_21 + arg_139_0 then
				var_139_19.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_139_26 = manager.ui.mainCamera.transform.position - var_139_19.position

				var_139_19.forward = Vector3.New(var_139_26.x, var_139_26.y, var_139_26.z)

				local var_139_27 = var_139_19.localEulerAngles

				var_139_27.z = 0
				var_139_27.x = 0
				var_139_19.localEulerAngles = var_139_27
			end

			local var_139_28 = arg_136_1.actors_["1059ui_story"].transform
			local var_139_29 = 0

			if var_139_29 < arg_136_1.time_ and arg_136_1.time_ <= var_139_29 + arg_139_0 then
				arg_136_1.var_.moveOldPos1059ui_story = var_139_28.localPosition
			end

			local var_139_30 = 0.001

			if var_139_29 <= arg_136_1.time_ and arg_136_1.time_ < var_139_29 + var_139_30 then
				local var_139_31 = (arg_136_1.time_ - var_139_29) / var_139_30
				local var_139_32 = Vector3.New(0.7, -1.05, -6)

				var_139_28.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1059ui_story, var_139_32, var_139_31)

				local var_139_33 = manager.ui.mainCamera.transform.position - var_139_28.position

				var_139_28.forward = Vector3.New(var_139_33.x, var_139_33.y, var_139_33.z)

				local var_139_34 = var_139_28.localEulerAngles

				var_139_34.z = 0
				var_139_34.x = 0
				var_139_28.localEulerAngles = var_139_34
			end

			if arg_136_1.time_ >= var_139_29 + var_139_30 and arg_136_1.time_ < var_139_29 + var_139_30 + arg_139_0 then
				var_139_28.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_139_35 = manager.ui.mainCamera.transform.position - var_139_28.position

				var_139_28.forward = Vector3.New(var_139_35.x, var_139_35.y, var_139_35.z)

				local var_139_36 = var_139_28.localEulerAngles

				var_139_36.z = 0
				var_139_36.x = 0
				var_139_28.localEulerAngles = var_139_36
			end

			local var_139_37 = 0

			if var_139_37 < arg_136_1.time_ and arg_136_1.time_ <= var_139_37 + arg_139_0 then
				arg_136_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action6_1")
			end

			local var_139_38 = 0

			if var_139_38 < arg_136_1.time_ and arg_136_1.time_ <= var_139_38 + arg_139_0 then
				arg_136_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_139_39 = 0
			local var_139_40 = 0.7

			if var_139_39 < arg_136_1.time_ and arg_136_1.time_ <= var_139_39 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_41 = arg_136_1:FormatText(StoryNameCfg[28].name)

				arg_136_1.leftNameTxt_.text = var_139_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_42 = arg_136_1:GetWordFromCfg(104061035)
				local var_139_43 = arg_136_1:FormatText(var_139_42.content)

				arg_136_1.text_.text = var_139_43

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_44 = 28
				local var_139_45 = utf8.len(var_139_43)
				local var_139_46 = var_139_44 <= 0 and var_139_40 or var_139_40 * (var_139_45 / var_139_44)

				if var_139_46 > 0 and var_139_40 < var_139_46 then
					arg_136_1.talkMaxDuration = var_139_46

					if var_139_46 + var_139_39 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_46 + var_139_39
					end
				end

				arg_136_1.text_.text = var_139_43
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061035", "story_v_out_104061.awb") ~= 0 then
					local var_139_47 = manager.audio:GetVoiceLength("story_v_out_104061", "104061035", "story_v_out_104061.awb") / 1000

					if var_139_47 + var_139_39 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_47 + var_139_39
					end

					if var_139_42.prefab_name ~= "" and arg_136_1.actors_[var_139_42.prefab_name] ~= nil then
						local var_139_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_42.prefab_name].transform, "story_v_out_104061", "104061035", "story_v_out_104061.awb")

						arg_136_1:RecordAudio("104061035", var_139_48)
						arg_136_1:RecordAudio("104061035", var_139_48)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_104061", "104061035", "story_v_out_104061.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_104061", "104061035", "story_v_out_104061.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_49 = math.max(var_139_40, arg_136_1.talkMaxDuration)

			if var_139_39 <= arg_136_1.time_ and arg_136_1.time_ < var_139_39 + var_139_49 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_39) / var_139_49

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_39 + var_139_49 and arg_136_1.time_ < var_139_39 + var_139_49 + arg_139_0 then
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

		arg_136_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B06a"
	},
	voices = {
		"story_v_out_104061.awb"
	}
}
