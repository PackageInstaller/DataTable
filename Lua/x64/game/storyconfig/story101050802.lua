return {
	Play105082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 105082001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play105082002(arg_1_1)
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

			local var_4_10 = "B14"

			if arg_1_1.bgs_[var_4_10] == nil then
				local var_4_11 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_10)
				var_4_11.name = var_4_10
				var_4_11.transform.parent = arg_1_1.stage_.transform
				var_4_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_10] = var_4_11
			end

			local var_4_12 = arg_1_1.bgs_.B14
			local var_4_13 = 0

			if var_4_13 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				local var_4_14 = var_4_12:GetComponent("SpriteRenderer")

				if var_4_14 then
					arg_1_1.var_.alphaOldValueB14 = var_4_14.color.a
					arg_1_1.var_.alphaMatValueB14 = var_4_14
				end

				arg_1_1.var_.alphaOldValueB14 = 0
			end

			local var_4_15 = 1.5

			if var_4_13 <= arg_1_1.time_ and arg_1_1.time_ < var_4_13 + var_4_15 then
				local var_4_16 = (arg_1_1.time_ - var_4_13) / var_4_15
				local var_4_17 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB14, 1, var_4_16)

				if arg_1_1.var_.alphaMatValueB14 then
					local var_4_18 = arg_1_1.var_.alphaMatValueB14.color

					var_4_18.a = var_4_17
					arg_1_1.var_.alphaMatValueB14.color = var_4_18
				end
			end

			if arg_1_1.time_ >= var_4_13 + var_4_15 and arg_1_1.time_ < var_4_13 + var_4_15 + arg_4_0 and arg_1_1.var_.alphaMatValueB14 then
				local var_4_19 = arg_1_1.var_.alphaMatValueB14
				local var_4_20 = var_4_19.color

				var_4_20.a = 1
				var_4_19.color = var_4_20
			end

			local var_4_21 = 0

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				local var_4_22 = manager.ui.mainCamera.transform.localPosition
				local var_4_23 = Vector3.New(0, 0, 10) + Vector3.New(var_4_22.x, var_4_22.y, 0)
				local var_4_24 = arg_1_1.bgs_.B14

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
					if iter_4_0 ~= "B14" then
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

				local var_4_40 = arg_1_1:GetWordFromCfg(105082001)
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
	Play105082002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 105082002
		arg_8_1.duration_ = 5.4

		local var_8_0 = {
			ja = 3.4,
			ko = 3.333,
			zh = 5.4,
			en = 4.733
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
				arg_8_0:Play105082003(arg_8_1)
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

			local var_11_14 = 0

			if var_11_14 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 then
				arg_8_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action6_1")
			end

			local var_11_15 = arg_8_1.actors_["1035ui_story"]
			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 and not isNil(var_11_15) and arg_8_1.var_.characterEffect1035ui_story == nil then
				arg_8_1.var_.characterEffect1035ui_story = var_11_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_17 = 0.2

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_17 and not isNil(var_11_15) then
				local var_11_18 = (arg_8_1.time_ - var_11_16) / var_11_17

				if arg_8_1.var_.characterEffect1035ui_story and not isNil(var_11_15) then
					arg_8_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_16 + var_11_17 and arg_8_1.time_ < var_11_16 + var_11_17 + arg_11_0 and not isNil(var_11_15) and arg_8_1.var_.characterEffect1035ui_story then
				arg_8_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_11_19 = 0
			local var_11_20 = 0.4

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

				local var_11_22 = arg_8_1:GetWordFromCfg(105082002)
				local var_11_23 = arg_8_1:FormatText(var_11_22.content)

				arg_8_1.text_.text = var_11_23

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_24 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082002", "story_v_out_105082.awb") ~= 0 then
					local var_11_27 = manager.audio:GetVoiceLength("story_v_out_105082", "105082002", "story_v_out_105082.awb") / 1000

					if var_11_27 + var_11_19 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_27 + var_11_19
					end

					if var_11_22.prefab_name ~= "" and arg_8_1.actors_[var_11_22.prefab_name] ~= nil then
						local var_11_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_22.prefab_name].transform, "story_v_out_105082", "105082002", "story_v_out_105082.awb")

						arg_8_1:RecordAudio("105082002", var_11_28)
						arg_8_1:RecordAudio("105082002", var_11_28)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_105082", "105082002", "story_v_out_105082.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_105082", "105082002", "story_v_out_105082.awb")
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
	Play105082003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 105082003
		arg_12_1.duration_ = 7

		local var_12_0 = {
			ja = 6.633,
			ko = 7,
			zh = 6.133,
			en = 4.766
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
				arg_12_0:Play105082004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "3008ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["3008ui_story"]
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect3008ui_story == nil then
				arg_12_1.var_.characterEffect3008ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.1

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 and not isNil(var_15_5) then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7

				if arg_12_1.var_.characterEffect3008ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect3008ui_story then
				arg_12_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_15_9 = arg_12_1.actors_["3008ui_story"].transform
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.var_.moveOldPos3008ui_story = var_15_9.localPosition
			end

			local var_15_11 = 0.001

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11
				local var_15_13 = Vector3.New(0, -1.51, -4.3)

				var_15_9.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3008ui_story, var_15_13, var_15_12)

				local var_15_14 = manager.ui.mainCamera.transform.position - var_15_9.position

				var_15_9.forward = Vector3.New(var_15_14.x, var_15_14.y, var_15_14.z)

				local var_15_15 = var_15_9.localEulerAngles

				var_15_15.z = 0
				var_15_15.x = 0
				var_15_9.localEulerAngles = var_15_15
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 then
				var_15_9.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_15_16 = manager.ui.mainCamera.transform.position - var_15_9.position

				var_15_9.forward = Vector3.New(var_15_16.x, var_15_16.y, var_15_16.z)

				local var_15_17 = var_15_9.localEulerAngles

				var_15_17.z = 0
				var_15_17.x = 0
				var_15_9.localEulerAngles = var_15_17
			end

			local var_15_18 = arg_12_1.actors_["1035ui_story"].transform
			local var_15_19 = 0

			if var_15_19 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 then
				arg_12_1.var_.moveOldPos1035ui_story = var_15_18.localPosition
			end

			local var_15_20 = 0.001

			if var_15_19 <= arg_12_1.time_ and arg_12_1.time_ < var_15_19 + var_15_20 then
				local var_15_21 = (arg_12_1.time_ - var_15_19) / var_15_20
				local var_15_22 = Vector3.New(0, 100, 0)

				var_15_18.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1035ui_story, var_15_22, var_15_21)

				local var_15_23 = manager.ui.mainCamera.transform.position - var_15_18.position

				var_15_18.forward = Vector3.New(var_15_23.x, var_15_23.y, var_15_23.z)

				local var_15_24 = var_15_18.localEulerAngles

				var_15_24.z = 0
				var_15_24.x = 0
				var_15_18.localEulerAngles = var_15_24
			end

			if arg_12_1.time_ >= var_15_19 + var_15_20 and arg_12_1.time_ < var_15_19 + var_15_20 + arg_15_0 then
				var_15_18.localPosition = Vector3.New(0, 100, 0)

				local var_15_25 = manager.ui.mainCamera.transform.position - var_15_18.position

				var_15_18.forward = Vector3.New(var_15_25.x, var_15_25.y, var_15_25.z)

				local var_15_26 = var_15_18.localEulerAngles

				var_15_26.z = 0
				var_15_26.x = 0
				var_15_18.localEulerAngles = var_15_26
			end

			local var_15_27 = 0

			if var_15_27 < arg_12_1.time_ and arg_12_1.time_ <= var_15_27 + arg_15_0 then
				arg_12_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action4_1")
			end

			local var_15_28 = 0

			if var_15_28 < arg_12_1.time_ and arg_12_1.time_ <= var_15_28 + arg_15_0 then
				arg_12_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_15_29 = 0
			local var_15_30 = 0.75

			if var_15_29 < arg_12_1.time_ and arg_12_1.time_ <= var_15_29 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_31 = arg_12_1:FormatText(StoryNameCfg[20].name)

				arg_12_1.leftNameTxt_.text = var_15_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_32 = arg_12_1:GetWordFromCfg(105082003)
				local var_15_33 = arg_12_1:FormatText(var_15_32.content)

				arg_12_1.text_.text = var_15_33

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_34 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082003", "story_v_out_105082.awb") ~= 0 then
					local var_15_37 = manager.audio:GetVoiceLength("story_v_out_105082", "105082003", "story_v_out_105082.awb") / 1000

					if var_15_37 + var_15_29 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_37 + var_15_29
					end

					if var_15_32.prefab_name ~= "" and arg_12_1.actors_[var_15_32.prefab_name] ~= nil then
						local var_15_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_32.prefab_name].transform, "story_v_out_105082", "105082003", "story_v_out_105082.awb")

						arg_12_1:RecordAudio("105082003", var_15_38)
						arg_12_1:RecordAudio("105082003", var_15_38)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_105082", "105082003", "story_v_out_105082.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_105082", "105082003", "story_v_out_105082.awb")
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
	Play105082004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 105082004
		arg_16_1.duration_ = 2.53

		local var_16_0 = {
			ja = 2.533,
			ko = 1.999999999999,
			zh = 2.2,
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
				arg_16_0:Play105082005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "4010ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["4010ui_story"]
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect4010ui_story == nil then
				arg_16_1.var_.characterEffect4010ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 and not isNil(var_19_5) then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7

				if arg_16_1.var_.characterEffect4010ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect4010ui_story then
				arg_16_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_19_9 = arg_16_1.actors_["3008ui_story"]
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect3008ui_story == nil then
				arg_16_1.var_.characterEffect3008ui_story = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_11 = 0.1

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 and not isNil(var_19_9) then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11

				if arg_16_1.var_.characterEffect3008ui_story and not isNil(var_19_9) then
					local var_19_13 = Mathf.Lerp(0, 0.5, var_19_12)

					arg_16_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_16_1.var_.characterEffect3008ui_story.fillRatio = var_19_13
				end
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect3008ui_story then
				local var_19_14 = 0.5

				arg_16_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_16_1.var_.characterEffect3008ui_story.fillRatio = var_19_14
			end

			local var_19_15 = arg_16_1.actors_["3008ui_story"].transform
			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.var_.moveOldPos3008ui_story = var_19_15.localPosition
			end

			local var_19_17 = 0.5

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_17 then
				local var_19_18 = (arg_16_1.time_ - var_19_16) / var_19_17
				local var_19_19 = Vector3.New(0.7, -1.51, -4.3)

				var_19_15.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3008ui_story, var_19_19, var_19_18)

				local var_19_20 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_20.x, var_19_20.y, var_19_20.z)

				local var_19_21 = var_19_15.localEulerAngles

				var_19_21.z = 0
				var_19_21.x = 0
				var_19_15.localEulerAngles = var_19_21
			end

			if arg_16_1.time_ >= var_19_16 + var_19_17 and arg_16_1.time_ < var_19_16 + var_19_17 + arg_19_0 then
				var_19_15.localPosition = Vector3.New(0.7, -1.51, -4.3)

				local var_19_22 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_22.x, var_19_22.y, var_19_22.z)

				local var_19_23 = var_19_15.localEulerAngles

				var_19_23.z = 0
				var_19_23.x = 0
				var_19_15.localEulerAngles = var_19_23
			end

			local var_19_24 = arg_16_1.actors_["4010ui_story"].transform
			local var_19_25 = 0

			if var_19_25 < arg_16_1.time_ and arg_16_1.time_ <= var_19_25 + arg_19_0 then
				arg_16_1.var_.moveOldPos4010ui_story = var_19_24.localPosition
			end

			local var_19_26 = 0.001

			if var_19_25 <= arg_16_1.time_ and arg_16_1.time_ < var_19_25 + var_19_26 then
				local var_19_27 = (arg_16_1.time_ - var_19_25) / var_19_26
				local var_19_28 = Vector3.New(-0.7, -1.59, -5.2)

				var_19_24.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos4010ui_story, var_19_28, var_19_27)

				local var_19_29 = manager.ui.mainCamera.transform.position - var_19_24.position

				var_19_24.forward = Vector3.New(var_19_29.x, var_19_29.y, var_19_29.z)

				local var_19_30 = var_19_24.localEulerAngles

				var_19_30.z = 0
				var_19_30.x = 0
				var_19_24.localEulerAngles = var_19_30
			end

			if arg_16_1.time_ >= var_19_25 + var_19_26 and arg_16_1.time_ < var_19_25 + var_19_26 + arg_19_0 then
				var_19_24.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_19_31 = manager.ui.mainCamera.transform.position - var_19_24.position

				var_19_24.forward = Vector3.New(var_19_31.x, var_19_31.y, var_19_31.z)

				local var_19_32 = var_19_24.localEulerAngles

				var_19_32.z = 0
				var_19_32.x = 0
				var_19_24.localEulerAngles = var_19_32
			end

			local var_19_33 = 0

			if var_19_33 < arg_16_1.time_ and arg_16_1.time_ <= var_19_33 + arg_19_0 then
				arg_16_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_19_34 = 0

			if var_19_34 < arg_16_1.time_ and arg_16_1.time_ <= var_19_34 + arg_19_0 then
				arg_16_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_19_35 = 0
			local var_19_36 = 0.1

			if var_19_35 < arg_16_1.time_ and arg_16_1.time_ <= var_19_35 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_37 = arg_16_1:FormatText(StoryNameCfg[42].name)

				arg_16_1.leftNameTxt_.text = var_19_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_38 = arg_16_1:GetWordFromCfg(105082004)
				local var_19_39 = arg_16_1:FormatText(var_19_38.content)

				arg_16_1.text_.text = var_19_39

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_40 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082004", "story_v_out_105082.awb") ~= 0 then
					local var_19_43 = manager.audio:GetVoiceLength("story_v_out_105082", "105082004", "story_v_out_105082.awb") / 1000

					if var_19_43 + var_19_35 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_43 + var_19_35
					end

					if var_19_38.prefab_name ~= "" and arg_16_1.actors_[var_19_38.prefab_name] ~= nil then
						local var_19_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_38.prefab_name].transform, "story_v_out_105082", "105082004", "story_v_out_105082.awb")

						arg_16_1:RecordAudio("105082004", var_19_44)
						arg_16_1:RecordAudio("105082004", var_19_44)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_105082", "105082004", "story_v_out_105082.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_105082", "105082004", "story_v_out_105082.awb")
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
				actorName = "4010ui_story",
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
	Play105082005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 105082005
		arg_20_1.duration_ = 7.6

		local var_20_0 = {
			ja = 7.6,
			ko = 5,
			zh = 4.366,
			en = 5.866
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
				arg_20_0:Play105082006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "3009ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "3009ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_20_1.stage_.transform)

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

			local var_23_5 = arg_20_1.actors_["3009ui_story"]
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect3009ui_story == nil then
				arg_20_1.var_.characterEffect3009ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_7 = 0.1

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 and not isNil(var_23_5) then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7

				if arg_20_1.var_.characterEffect3009ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect3009ui_story then
				arg_20_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_23_9 = arg_20_1.actors_["4010ui_story"]
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect4010ui_story == nil then
				arg_20_1.var_.characterEffect4010ui_story = var_23_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.1

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 and not isNil(var_23_9) then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11

				if arg_20_1.var_.characterEffect4010ui_story and not isNil(var_23_9) then
					local var_23_13 = Mathf.Lerp(0, 0.5, var_23_12)

					arg_20_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_20_1.var_.characterEffect4010ui_story.fillRatio = var_23_13
				end
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect4010ui_story then
				local var_23_14 = 0.5

				arg_20_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_20_1.var_.characterEffect4010ui_story.fillRatio = var_23_14
			end

			local var_23_15 = arg_20_1.actors_["3008ui_story"].transform
			local var_23_16 = 0

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.var_.moveOldPos3008ui_story = var_23_15.localPosition
			end

			local var_23_17 = 0.001

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_17 then
				local var_23_18 = (arg_20_1.time_ - var_23_16) / var_23_17
				local var_23_19 = Vector3.New(0, 100, 0)

				var_23_15.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos3008ui_story, var_23_19, var_23_18)

				local var_23_20 = manager.ui.mainCamera.transform.position - var_23_15.position

				var_23_15.forward = Vector3.New(var_23_20.x, var_23_20.y, var_23_20.z)

				local var_23_21 = var_23_15.localEulerAngles

				var_23_21.z = 0
				var_23_21.x = 0
				var_23_15.localEulerAngles = var_23_21
			end

			if arg_20_1.time_ >= var_23_16 + var_23_17 and arg_20_1.time_ < var_23_16 + var_23_17 + arg_23_0 then
				var_23_15.localPosition = Vector3.New(0, 100, 0)

				local var_23_22 = manager.ui.mainCamera.transform.position - var_23_15.position

				var_23_15.forward = Vector3.New(var_23_22.x, var_23_22.y, var_23_22.z)

				local var_23_23 = var_23_15.localEulerAngles

				var_23_23.z = 0
				var_23_23.x = 0
				var_23_15.localEulerAngles = var_23_23
			end

			local var_23_24 = arg_20_1.actors_["3009ui_story"].transform
			local var_23_25 = 0

			if var_23_25 < arg_20_1.time_ and arg_20_1.time_ <= var_23_25 + arg_23_0 then
				arg_20_1.var_.moveOldPos3009ui_story = var_23_24.localPosition
			end

			local var_23_26 = 0.001

			if var_23_25 <= arg_20_1.time_ and arg_20_1.time_ < var_23_25 + var_23_26 then
				local var_23_27 = (arg_20_1.time_ - var_23_25) / var_23_26
				local var_23_28 = Vector3.New(0.7, -1.75, -4.8)

				var_23_24.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos3009ui_story, var_23_28, var_23_27)

				local var_23_29 = manager.ui.mainCamera.transform.position - var_23_24.position

				var_23_24.forward = Vector3.New(var_23_29.x, var_23_29.y, var_23_29.z)

				local var_23_30 = var_23_24.localEulerAngles

				var_23_30.z = 0
				var_23_30.x = 0
				var_23_24.localEulerAngles = var_23_30
			end

			if arg_20_1.time_ >= var_23_25 + var_23_26 and arg_20_1.time_ < var_23_25 + var_23_26 + arg_23_0 then
				var_23_24.localPosition = Vector3.New(0.7, -1.75, -4.8)

				local var_23_31 = manager.ui.mainCamera.transform.position - var_23_24.position

				var_23_24.forward = Vector3.New(var_23_31.x, var_23_31.y, var_23_31.z)

				local var_23_32 = var_23_24.localEulerAngles

				var_23_32.z = 0
				var_23_32.x = 0
				var_23_24.localEulerAngles = var_23_32
			end

			local var_23_33 = 0

			if var_23_33 < arg_20_1.time_ and arg_20_1.time_ <= var_23_33 + arg_23_0 then
				arg_20_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action1_1")
			end

			local var_23_34 = 0

			if var_23_34 < arg_20_1.time_ and arg_20_1.time_ <= var_23_34 + arg_23_0 then
				arg_20_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_23_35 = 0
			local var_23_36 = 0.65

			if var_23_35 < arg_20_1.time_ and arg_20_1.time_ <= var_23_35 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_37 = arg_20_1:FormatText(StoryNameCfg[43].name)

				arg_20_1.leftNameTxt_.text = var_23_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_38 = arg_20_1:GetWordFromCfg(105082005)
				local var_23_39 = arg_20_1:FormatText(var_23_38.content)

				arg_20_1.text_.text = var_23_39

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_40 = 26
				local var_23_41 = utf8.len(var_23_39)
				local var_23_42 = var_23_40 <= 0 and var_23_36 or var_23_36 * (var_23_41 / var_23_40)

				if var_23_42 > 0 and var_23_36 < var_23_42 then
					arg_20_1.talkMaxDuration = var_23_42

					if var_23_42 + var_23_35 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_42 + var_23_35
					end
				end

				arg_20_1.text_.text = var_23_39
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082005", "story_v_out_105082.awb") ~= 0 then
					local var_23_43 = manager.audio:GetVoiceLength("story_v_out_105082", "105082005", "story_v_out_105082.awb") / 1000

					if var_23_43 + var_23_35 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_43 + var_23_35
					end

					if var_23_38.prefab_name ~= "" and arg_20_1.actors_[var_23_38.prefab_name] ~= nil then
						local var_23_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_38.prefab_name].transform, "story_v_out_105082", "105082005", "story_v_out_105082.awb")

						arg_20_1:RecordAudio("105082005", var_23_44)
						arg_20_1:RecordAudio("105082005", var_23_44)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_105082", "105082005", "story_v_out_105082.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_105082", "105082005", "story_v_out_105082.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_45 = math.max(var_23_36, arg_20_1.talkMaxDuration)

			if var_23_35 <= arg_20_1.time_ and arg_20_1.time_ < var_23_35 + var_23_45 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_35) / var_23_45

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_35 + var_23_45 and arg_20_1.time_ < var_23_35 + var_23_45 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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
				actorName = "3009ui_story",
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
	Play105082006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 105082006
		arg_24_1.duration_ = 2.1

		local var_24_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.1,
			en = 1.999999999999
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
				arg_24_0:Play105082007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["4010ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect4010ui_story == nil then
				arg_24_1.var_.characterEffect4010ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect4010ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect4010ui_story then
				arg_24_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["3009ui_story"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect3009ui_story == nil then
				arg_24_1.var_.characterEffect3009ui_story = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.1

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.characterEffect3009ui_story and not isNil(var_27_4) then
					local var_27_8 = Mathf.Lerp(0, 0.5, var_27_7)

					arg_24_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_24_1.var_.characterEffect3009ui_story.fillRatio = var_27_8
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect3009ui_story then
				local var_27_9 = 0.5

				arg_24_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_24_1.var_.characterEffect3009ui_story.fillRatio = var_27_9
			end

			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_27_11 = 0
			local var_27_12 = 0.075

			if var_27_11 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_13 = arg_24_1:FormatText(StoryNameCfg[42].name)

				arg_24_1.leftNameTxt_.text = var_27_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_14 = arg_24_1:GetWordFromCfg(105082006)
				local var_27_15 = arg_24_1:FormatText(var_27_14.content)

				arg_24_1.text_.text = var_27_15

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_16 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082006", "story_v_out_105082.awb") ~= 0 then
					local var_27_19 = manager.audio:GetVoiceLength("story_v_out_105082", "105082006", "story_v_out_105082.awb") / 1000

					if var_27_19 + var_27_11 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_11
					end

					if var_27_14.prefab_name ~= "" and arg_24_1.actors_[var_27_14.prefab_name] ~= nil then
						local var_27_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_14.prefab_name].transform, "story_v_out_105082", "105082006", "story_v_out_105082.awb")

						arg_24_1:RecordAudio("105082006", var_27_20)
						arg_24_1:RecordAudio("105082006", var_27_20)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_105082", "105082006", "story_v_out_105082.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_105082", "105082006", "story_v_out_105082.awb")
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
	Play105082007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 105082007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play105082008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["4010ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect4010ui_story == nil then
				arg_28_1.var_.characterEffect4010ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect4010ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_28_1.var_.characterEffect4010ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect4010ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_28_1.var_.characterEffect4010ui_story.fillRatio = var_31_5
			end

			local var_31_6 = arg_28_1.actors_["3009ui_story"].transform
			local var_31_7 = 0

			if var_31_7 < arg_28_1.time_ and arg_28_1.time_ <= var_31_7 + arg_31_0 then
				arg_28_1.var_.moveOldPos3009ui_story = var_31_6.localPosition
			end

			local var_31_8 = 0.001

			if var_31_7 <= arg_28_1.time_ and arg_28_1.time_ < var_31_7 + var_31_8 then
				local var_31_9 = (arg_28_1.time_ - var_31_7) / var_31_8
				local var_31_10 = Vector3.New(0, 100, 0)

				var_31_6.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3009ui_story, var_31_10, var_31_9)

				local var_31_11 = manager.ui.mainCamera.transform.position - var_31_6.position

				var_31_6.forward = Vector3.New(var_31_11.x, var_31_11.y, var_31_11.z)

				local var_31_12 = var_31_6.localEulerAngles

				var_31_12.z = 0
				var_31_12.x = 0
				var_31_6.localEulerAngles = var_31_12
			end

			if arg_28_1.time_ >= var_31_7 + var_31_8 and arg_28_1.time_ < var_31_7 + var_31_8 + arg_31_0 then
				var_31_6.localPosition = Vector3.New(0, 100, 0)

				local var_31_13 = manager.ui.mainCamera.transform.position - var_31_6.position

				var_31_6.forward = Vector3.New(var_31_13.x, var_31_13.y, var_31_13.z)

				local var_31_14 = var_31_6.localEulerAngles

				var_31_14.z = 0
				var_31_14.x = 0
				var_31_6.localEulerAngles = var_31_14
			end

			local var_31_15 = arg_28_1.actors_["4010ui_story"].transform
			local var_31_16 = 0

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.var_.moveOldPos4010ui_story = var_31_15.localPosition
			end

			local var_31_17 = 0.001

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_17 then
				local var_31_18 = (arg_28_1.time_ - var_31_16) / var_31_17
				local var_31_19 = Vector3.New(0, 100, 0)

				var_31_15.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos4010ui_story, var_31_19, var_31_18)

				local var_31_20 = manager.ui.mainCamera.transform.position - var_31_15.position

				var_31_15.forward = Vector3.New(var_31_20.x, var_31_20.y, var_31_20.z)

				local var_31_21 = var_31_15.localEulerAngles

				var_31_21.z = 0
				var_31_21.x = 0
				var_31_15.localEulerAngles = var_31_21
			end

			if arg_28_1.time_ >= var_31_16 + var_31_17 and arg_28_1.time_ < var_31_16 + var_31_17 + arg_31_0 then
				var_31_15.localPosition = Vector3.New(0, 100, 0)

				local var_31_22 = manager.ui.mainCamera.transform.position - var_31_15.position

				var_31_15.forward = Vector3.New(var_31_22.x, var_31_22.y, var_31_22.z)

				local var_31_23 = var_31_15.localEulerAngles

				var_31_23.z = 0
				var_31_23.x = 0
				var_31_15.localEulerAngles = var_31_23
			end

			local var_31_24 = 0
			local var_31_25 = 1.3

			if var_31_24 < arg_28_1.time_ and arg_28_1.time_ <= var_31_24 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_26 = arg_28_1:GetWordFromCfg(105082007)
				local var_31_27 = arg_28_1:FormatText(var_31_26.content)

				arg_28_1.text_.text = var_31_27

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_28 = 52
				local var_31_29 = utf8.len(var_31_27)
				local var_31_30 = var_31_28 <= 0 and var_31_25 or var_31_25 * (var_31_29 / var_31_28)

				if var_31_30 > 0 and var_31_25 < var_31_30 then
					arg_28_1.talkMaxDuration = var_31_30

					if var_31_30 + var_31_24 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_30 + var_31_24
					end
				end

				arg_28_1.text_.text = var_31_27
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_31 = math.max(var_31_25, arg_28_1.talkMaxDuration)

			if var_31_24 <= arg_28_1.time_ and arg_28_1.time_ < var_31_24 + var_31_31 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_24) / var_31_31

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_24 + var_31_31 and arg_28_1.time_ < var_31_24 + var_31_31 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play105082008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 105082008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play105082009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 1

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				local var_35_2 = "play"
				local var_35_3 = "effect"

				arg_32_1:AudioAction(var_35_2, var_35_3, "se_story_5", "se_story_5_signal", "")
			end

			local var_35_4 = 0
			local var_35_5 = 0.1

			if var_35_4 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(105082008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_8 = 4
				local var_35_9 = utf8.len(var_35_7)
				local var_35_10 = var_35_8 <= 0 and var_35_5 or var_35_5 * (var_35_9 / var_35_8)

				if var_35_10 > 0 and var_35_5 < var_35_10 then
					arg_32_1.talkMaxDuration = var_35_10

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_11 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_11 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_11

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_11 and arg_32_1.time_ < var_35_4 + var_35_11 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play105082009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 105082009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play105082010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.725

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_2 = arg_36_1:GetWordFromCfg(105082009)
				local var_39_3 = arg_36_1:FormatText(var_39_2.content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 29
				local var_39_5 = utf8.len(var_39_3)
				local var_39_6 = var_39_4 <= 0 and var_39_1 or var_39_1 * (var_39_5 / var_39_4)

				if var_39_6 > 0 and var_39_1 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_7 and arg_36_1.time_ < var_39_0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play105082010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 105082010
		arg_40_1.duration_ = 9.87

		local var_40_0 = {
			ja = 9.8,
			ko = 8.5,
			zh = 9.866,
			en = 7.2
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
				arg_40_0:Play105082011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["4010ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect4010ui_story == nil then
				arg_40_1.var_.characterEffect4010ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect4010ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect4010ui_story then
				arg_40_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_43_4 = 0

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_43_5 = arg_40_1.actors_["4010ui_story"].transform
			local var_43_6 = 0

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.var_.moveOldPos4010ui_story = var_43_5.localPosition
			end

			local var_43_7 = 0.001

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_7 then
				local var_43_8 = (arg_40_1.time_ - var_43_6) / var_43_7
				local var_43_9 = Vector3.New(0, -1.59, -5.2)

				var_43_5.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos4010ui_story, var_43_9, var_43_8)

				local var_43_10 = manager.ui.mainCamera.transform.position - var_43_5.position

				var_43_5.forward = Vector3.New(var_43_10.x, var_43_10.y, var_43_10.z)

				local var_43_11 = var_43_5.localEulerAngles

				var_43_11.z = 0
				var_43_11.x = 0
				var_43_5.localEulerAngles = var_43_11
			end

			if arg_40_1.time_ >= var_43_6 + var_43_7 and arg_40_1.time_ < var_43_6 + var_43_7 + arg_43_0 then
				var_43_5.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_43_12 = manager.ui.mainCamera.transform.position - var_43_5.position

				var_43_5.forward = Vector3.New(var_43_12.x, var_43_12.y, var_43_12.z)

				local var_43_13 = var_43_5.localEulerAngles

				var_43_13.z = 0
				var_43_13.x = 0
				var_43_5.localEulerAngles = var_43_13
			end

			local var_43_14 = 0

			if var_43_14 < arg_40_1.time_ and arg_40_1.time_ <= var_43_14 + arg_43_0 then
				arg_40_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_43_15 = 0
			local var_43_16 = 1.2

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_17 = arg_40_1:FormatText(StoryNameCfg[42].name)

				arg_40_1.leftNameTxt_.text = var_43_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_18 = arg_40_1:GetWordFromCfg(105082010)
				local var_43_19 = arg_40_1:FormatText(var_43_18.content)

				arg_40_1.text_.text = var_43_19

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 48
				local var_43_21 = utf8.len(var_43_19)
				local var_43_22 = var_43_20 <= 0 and var_43_16 or var_43_16 * (var_43_21 / var_43_20)

				if var_43_22 > 0 and var_43_16 < var_43_22 then
					arg_40_1.talkMaxDuration = var_43_22

					if var_43_22 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_22 + var_43_15
					end
				end

				arg_40_1.text_.text = var_43_19
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082010", "story_v_out_105082.awb") ~= 0 then
					local var_43_23 = manager.audio:GetVoiceLength("story_v_out_105082", "105082010", "story_v_out_105082.awb") / 1000

					if var_43_23 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_23 + var_43_15
					end

					if var_43_18.prefab_name ~= "" and arg_40_1.actors_[var_43_18.prefab_name] ~= nil then
						local var_43_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_18.prefab_name].transform, "story_v_out_105082", "105082010", "story_v_out_105082.awb")

						arg_40_1:RecordAudio("105082010", var_43_24)
						arg_40_1:RecordAudio("105082010", var_43_24)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_105082", "105082010", "story_v_out_105082.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_105082", "105082010", "story_v_out_105082.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_25 = math.max(var_43_16, arg_40_1.talkMaxDuration)

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_25 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_15) / var_43_25

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_15 + var_43_25 and arg_40_1.time_ < var_43_15 + var_43_25 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play105082011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 105082011
		arg_44_1.duration_ = 4.4

		local var_44_0 = {
			ja = 4.4,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.133
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
				arg_44_0:Play105082012(arg_44_1)
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

			local var_47_9 = arg_44_1.actors_["4010ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect4010ui_story == nil then
				arg_44_1.var_.characterEffect4010ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.1

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect4010ui_story and not isNil(var_47_9) then
					local var_47_13 = Mathf.Lerp(0, 0.5, var_47_12)

					arg_44_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_44_1.var_.characterEffect4010ui_story.fillRatio = var_47_13
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect4010ui_story then
				local var_47_14 = 0.5

				arg_44_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_44_1.var_.characterEffect4010ui_story.fillRatio = var_47_14
			end

			local var_47_15 = arg_44_1.actors_["4010ui_story"].transform
			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.var_.moveOldPos4010ui_story = var_47_15.localPosition
			end

			local var_47_17 = 0.001

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_17 then
				local var_47_18 = (arg_44_1.time_ - var_47_16) / var_47_17
				local var_47_19 = Vector3.New(0, 100, 0)

				var_47_15.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos4010ui_story, var_47_19, var_47_18)

				local var_47_20 = manager.ui.mainCamera.transform.position - var_47_15.position

				var_47_15.forward = Vector3.New(var_47_20.x, var_47_20.y, var_47_20.z)

				local var_47_21 = var_47_15.localEulerAngles

				var_47_21.z = 0
				var_47_21.x = 0
				var_47_15.localEulerAngles = var_47_21
			end

			if arg_44_1.time_ >= var_47_16 + var_47_17 and arg_44_1.time_ < var_47_16 + var_47_17 + arg_47_0 then
				var_47_15.localPosition = Vector3.New(0, 100, 0)

				local var_47_22 = manager.ui.mainCamera.transform.position - var_47_15.position

				var_47_15.forward = Vector3.New(var_47_22.x, var_47_22.y, var_47_22.z)

				local var_47_23 = var_47_15.localEulerAngles

				var_47_23.z = 0
				var_47_23.x = 0
				var_47_15.localEulerAngles = var_47_23
			end

			local var_47_24 = arg_44_1.actors_["2020_tpose"].transform
			local var_47_25 = 0

			if var_47_25 < arg_44_1.time_ and arg_44_1.time_ <= var_47_25 + arg_47_0 then
				arg_44_1.var_.moveOldPos2020_tpose = var_47_24.localPosition

				local var_47_26 = GameObjectTools.GetOrAddComponent(var_47_24.gameObject, typeof(DynamicBoneHelper))

				if var_47_26 then
					var_47_26:EnableDynamicBone(false)
				end
			end

			local var_47_27 = 0.001

			if var_47_25 <= arg_44_1.time_ and arg_44_1.time_ < var_47_25 + var_47_27 then
				local var_47_28 = (arg_44_1.time_ - var_47_25) / var_47_27
				local var_47_29 = Vector3.New(-0.7, -1.2, -4.1)

				var_47_24.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos2020_tpose, var_47_29, var_47_28)

				local var_47_30 = manager.ui.mainCamera.transform.position - var_47_24.position

				var_47_24.forward = Vector3.New(var_47_30.x, var_47_30.y, var_47_30.z)

				local var_47_31 = var_47_24.localEulerAngles

				var_47_31.z = 0
				var_47_31.x = 0
				var_47_24.localEulerAngles = var_47_31
			end

			if arg_44_1.time_ >= var_47_25 + var_47_27 and arg_44_1.time_ < var_47_25 + var_47_27 + arg_47_0 then
				var_47_24.localPosition = Vector3.New(-0.7, -1.2, -4.1)

				local var_47_32 = manager.ui.mainCamera.transform.position - var_47_24.position

				var_47_24.forward = Vector3.New(var_47_32.x, var_47_32.y, var_47_32.z)

				local var_47_33 = var_47_24.localEulerAngles

				var_47_33.z = 0
				var_47_33.x = 0
				var_47_24.localEulerAngles = var_47_33

				local var_47_34 = GameObjectTools.GetOrAddComponent(var_47_24.gameObject, typeof(DynamicBoneHelper))

				if var_47_34 then
					var_47_34:EnableDynamicBone(true)
				end
			end

			local var_47_35 = 0

			if var_47_35 < arg_44_1.time_ and arg_44_1.time_ <= var_47_35 + arg_47_0 then
				arg_44_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_47_36 = 0
			local var_47_37 = 0.175

			if var_47_36 < arg_44_1.time_ and arg_44_1.time_ <= var_47_36 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_38 = arg_44_1:FormatText(StoryNameCfg[34].name)

				arg_44_1.leftNameTxt_.text = var_47_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_39 = arg_44_1:GetWordFromCfg(105082011)
				local var_47_40 = arg_44_1:FormatText(var_47_39.content)

				arg_44_1.text_.text = var_47_40

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_41 = 7
				local var_47_42 = utf8.len(var_47_40)
				local var_47_43 = var_47_41 <= 0 and var_47_37 or var_47_37 * (var_47_42 / var_47_41)

				if var_47_43 > 0 and var_47_37 < var_47_43 then
					arg_44_1.talkMaxDuration = var_47_43

					if var_47_43 + var_47_36 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_43 + var_47_36
					end
				end

				arg_44_1.text_.text = var_47_40
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082011", "story_v_out_105082.awb") ~= 0 then
					local var_47_44 = manager.audio:GetVoiceLength("story_v_out_105082", "105082011", "story_v_out_105082.awb") / 1000

					if var_47_44 + var_47_36 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_44 + var_47_36
					end

					if var_47_39.prefab_name ~= "" and arg_44_1.actors_[var_47_39.prefab_name] ~= nil then
						local var_47_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_39.prefab_name].transform, "story_v_out_105082", "105082011", "story_v_out_105082.awb")

						arg_44_1:RecordAudio("105082011", var_47_45)
						arg_44_1:RecordAudio("105082011", var_47_45)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_105082", "105082011", "story_v_out_105082.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_105082", "105082011", "story_v_out_105082.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_46 = math.max(var_47_37, arg_44_1.talkMaxDuration)

			if var_47_36 <= arg_44_1.time_ and arg_44_1.time_ < var_47_36 + var_47_46 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_36) / var_47_46

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_36 + var_47_46 and arg_44_1.time_ < var_47_36 + var_47_46 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play105082012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 105082012
		arg_48_1.duration_ = 4.8

		local var_48_0 = {
			ja = 4.8,
			ko = 4.233,
			zh = 3.033,
			en = 3.833
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
				arg_48_0:Play105082013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 1

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				local var_51_2 = "play"
				local var_51_3 = "effect"

				arg_48_1:AudioAction(var_51_2, var_51_3, "se_story_5", "se_story_5_cheer", "")
			end

			local var_51_4 = "2030_tpose"

			if arg_48_1.actors_[var_51_4] == nil then
				local var_51_5 = Asset.Load("Char/" .. "2030_tpose")

				if not isNil(var_51_5) then
					local var_51_6 = Object.Instantiate(Asset.Load("Char/" .. "2030_tpose"), arg_48_1.stage_.transform)

					var_51_6.name = var_51_4
					var_51_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_48_1.actors_[var_51_4] = var_51_6

					local var_51_7 = var_51_6:GetComponentInChildren(typeof(CharacterEffect))

					var_51_7.enabled = true

					local var_51_8 = GameObjectTools.GetOrAddComponent(var_51_6, typeof(DynamicBoneHelper))

					if var_51_8 then
						var_51_8:EnableDynamicBone(false)
					end

					arg_48_1:ShowWeapon(var_51_7.transform, false)

					arg_48_1.var_[var_51_4 .. "Animator"] = var_51_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_48_1.var_[var_51_4 .. "Animator"].applyRootMotion = true
					arg_48_1.var_[var_51_4 .. "LipSync"] = var_51_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_51_9 = arg_48_1.actors_["2030_tpose"]
			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect2030_tpose == nil then
				arg_48_1.var_.characterEffect2030_tpose = var_51_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_11 = 0.1

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_11 and not isNil(var_51_9) then
				local var_51_12 = (arg_48_1.time_ - var_51_10) / var_51_11

				if arg_48_1.var_.characterEffect2030_tpose and not isNil(var_51_9) then
					arg_48_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_10 + var_51_11 and arg_48_1.time_ < var_51_10 + var_51_11 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect2030_tpose then
				arg_48_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_51_13 = arg_48_1.actors_["2020_tpose"]
			local var_51_14 = 0

			if var_51_14 < arg_48_1.time_ and arg_48_1.time_ <= var_51_14 + arg_51_0 and not isNil(var_51_13) and arg_48_1.var_.characterEffect2020_tpose == nil then
				arg_48_1.var_.characterEffect2020_tpose = var_51_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_15 = 0.1

			if var_51_14 <= arg_48_1.time_ and arg_48_1.time_ < var_51_14 + var_51_15 and not isNil(var_51_13) then
				local var_51_16 = (arg_48_1.time_ - var_51_14) / var_51_15

				if arg_48_1.var_.characterEffect2020_tpose and not isNil(var_51_13) then
					local var_51_17 = Mathf.Lerp(0, 0.5, var_51_16)

					arg_48_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_48_1.var_.characterEffect2020_tpose.fillRatio = var_51_17
				end
			end

			if arg_48_1.time_ >= var_51_14 + var_51_15 and arg_48_1.time_ < var_51_14 + var_51_15 + arg_51_0 and not isNil(var_51_13) and arg_48_1.var_.characterEffect2020_tpose then
				local var_51_18 = 0.5

				arg_48_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_48_1.var_.characterEffect2020_tpose.fillRatio = var_51_18
			end

			local var_51_19 = arg_48_1.actors_["2030_tpose"].transform
			local var_51_20 = 0

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1.var_.moveOldPos2030_tpose = var_51_19.localPosition

				local var_51_21 = GameObjectTools.GetOrAddComponent(var_51_19.gameObject, typeof(DynamicBoneHelper))

				if var_51_21 then
					var_51_21:EnableDynamicBone(false)
				end
			end

			local var_51_22 = 0.001

			if var_51_20 <= arg_48_1.time_ and arg_48_1.time_ < var_51_20 + var_51_22 then
				local var_51_23 = (arg_48_1.time_ - var_51_20) / var_51_22
				local var_51_24 = Vector3.New(0.7, -1.2, -4.2)

				var_51_19.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos2030_tpose, var_51_24, var_51_23)

				local var_51_25 = manager.ui.mainCamera.transform.position - var_51_19.position

				var_51_19.forward = Vector3.New(var_51_25.x, var_51_25.y, var_51_25.z)

				local var_51_26 = var_51_19.localEulerAngles

				var_51_26.z = 0
				var_51_26.x = 0
				var_51_19.localEulerAngles = var_51_26
			end

			if arg_48_1.time_ >= var_51_20 + var_51_22 and arg_48_1.time_ < var_51_20 + var_51_22 + arg_51_0 then
				var_51_19.localPosition = Vector3.New(0.7, -1.2, -4.2)

				local var_51_27 = manager.ui.mainCamera.transform.position - var_51_19.position

				var_51_19.forward = Vector3.New(var_51_27.x, var_51_27.y, var_51_27.z)

				local var_51_28 = var_51_19.localEulerAngles

				var_51_28.z = 0
				var_51_28.x = 0
				var_51_19.localEulerAngles = var_51_28

				local var_51_29 = GameObjectTools.GetOrAddComponent(var_51_19.gameObject, typeof(DynamicBoneHelper))

				if var_51_29 then
					var_51_29:EnableDynamicBone(true)
				end
			end

			local var_51_30 = 0

			if var_51_30 < arg_48_1.time_ and arg_48_1.time_ <= var_51_30 + arg_51_0 then
				arg_48_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_51_31 = 0
			local var_51_32 = 0.4

			if var_51_31 < arg_48_1.time_ and arg_48_1.time_ <= var_51_31 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_33 = arg_48_1:FormatText(StoryNameCfg[34].name)

				arg_48_1.leftNameTxt_.text = var_51_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_34 = arg_48_1:GetWordFromCfg(105082012)
				local var_51_35 = arg_48_1:FormatText(var_51_34.content)

				arg_48_1.text_.text = var_51_35

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_36 = 16
				local var_51_37 = utf8.len(var_51_35)
				local var_51_38 = var_51_36 <= 0 and var_51_32 or var_51_32 * (var_51_37 / var_51_36)

				if var_51_38 > 0 and var_51_32 < var_51_38 then
					arg_48_1.talkMaxDuration = var_51_38

					if var_51_38 + var_51_31 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_38 + var_51_31
					end
				end

				arg_48_1.text_.text = var_51_35
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082012", "story_v_out_105082.awb") ~= 0 then
					local var_51_39 = manager.audio:GetVoiceLength("story_v_out_105082", "105082012", "story_v_out_105082.awb") / 1000

					if var_51_39 + var_51_31 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_39 + var_51_31
					end

					if var_51_34.prefab_name ~= "" and arg_48_1.actors_[var_51_34.prefab_name] ~= nil then
						local var_51_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_34.prefab_name].transform, "story_v_out_105082", "105082012", "story_v_out_105082.awb")

						arg_48_1:RecordAudio("105082012", var_51_40)
						arg_48_1:RecordAudio("105082012", var_51_40)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_105082", "105082012", "story_v_out_105082.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_105082", "105082012", "story_v_out_105082.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_41 = math.max(var_51_32, arg_48_1.talkMaxDuration)

			if var_51_31 <= arg_48_1.time_ and arg_48_1.time_ < var_51_31 + var_51_41 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_31) / var_51_41

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_31 + var_51_41 and arg_48_1.time_ < var_51_31 + var_51_41 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play105082013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 105082013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play105082014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["2030_tpose"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect2030_tpose == nil then
				arg_52_1.var_.characterEffect2030_tpose = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect2030_tpose and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_52_1.var_.characterEffect2030_tpose.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect2030_tpose then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_52_1.var_.characterEffect2030_tpose.fillRatio = var_55_5
			end

			local var_55_6 = arg_52_1.actors_["2030_tpose"].transform
			local var_55_7 = 0

			if var_55_7 < arg_52_1.time_ and arg_52_1.time_ <= var_55_7 + arg_55_0 then
				arg_52_1.var_.moveOldPos2030_tpose = var_55_6.localPosition

				local var_55_8 = GameObjectTools.GetOrAddComponent(var_55_6.gameObject, typeof(DynamicBoneHelper))

				if var_55_8 then
					var_55_8:EnableDynamicBone(false)
				end
			end

			local var_55_9 = 0.001

			if var_55_7 <= arg_52_1.time_ and arg_52_1.time_ < var_55_7 + var_55_9 then
				local var_55_10 = (arg_52_1.time_ - var_55_7) / var_55_9
				local var_55_11 = Vector3.New(0, 100, 0)

				var_55_6.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos2030_tpose, var_55_11, var_55_10)

				local var_55_12 = manager.ui.mainCamera.transform.position - var_55_6.position

				var_55_6.forward = Vector3.New(var_55_12.x, var_55_12.y, var_55_12.z)

				local var_55_13 = var_55_6.localEulerAngles

				var_55_13.z = 0
				var_55_13.x = 0
				var_55_6.localEulerAngles = var_55_13
			end

			if arg_52_1.time_ >= var_55_7 + var_55_9 and arg_52_1.time_ < var_55_7 + var_55_9 + arg_55_0 then
				var_55_6.localPosition = Vector3.New(0, 100, 0)

				local var_55_14 = manager.ui.mainCamera.transform.position - var_55_6.position

				var_55_6.forward = Vector3.New(var_55_14.x, var_55_14.y, var_55_14.z)

				local var_55_15 = var_55_6.localEulerAngles

				var_55_15.z = 0
				var_55_15.x = 0
				var_55_6.localEulerAngles = var_55_15

				local var_55_16 = GameObjectTools.GetOrAddComponent(var_55_6.gameObject, typeof(DynamicBoneHelper))

				if var_55_16 then
					var_55_16:EnableDynamicBone(true)
				end
			end

			local var_55_17 = arg_52_1.actors_["2020_tpose"].transform
			local var_55_18 = 0

			if var_55_18 < arg_52_1.time_ and arg_52_1.time_ <= var_55_18 + arg_55_0 then
				arg_52_1.var_.moveOldPos2020_tpose = var_55_17.localPosition

				local var_55_19 = GameObjectTools.GetOrAddComponent(var_55_17.gameObject, typeof(DynamicBoneHelper))

				if var_55_19 then
					var_55_19:EnableDynamicBone(false)
				end
			end

			local var_55_20 = 0.001

			if var_55_18 <= arg_52_1.time_ and arg_52_1.time_ < var_55_18 + var_55_20 then
				local var_55_21 = (arg_52_1.time_ - var_55_18) / var_55_20
				local var_55_22 = Vector3.New(0, 100, 0)

				var_55_17.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos2020_tpose, var_55_22, var_55_21)

				local var_55_23 = manager.ui.mainCamera.transform.position - var_55_17.position

				var_55_17.forward = Vector3.New(var_55_23.x, var_55_23.y, var_55_23.z)

				local var_55_24 = var_55_17.localEulerAngles

				var_55_24.z = 0
				var_55_24.x = 0
				var_55_17.localEulerAngles = var_55_24
			end

			if arg_52_1.time_ >= var_55_18 + var_55_20 and arg_52_1.time_ < var_55_18 + var_55_20 + arg_55_0 then
				var_55_17.localPosition = Vector3.New(0, 100, 0)

				local var_55_25 = manager.ui.mainCamera.transform.position - var_55_17.position

				var_55_17.forward = Vector3.New(var_55_25.x, var_55_25.y, var_55_25.z)

				local var_55_26 = var_55_17.localEulerAngles

				var_55_26.z = 0
				var_55_26.x = 0
				var_55_17.localEulerAngles = var_55_26

				local var_55_27 = GameObjectTools.GetOrAddComponent(var_55_17.gameObject, typeof(DynamicBoneHelper))

				if var_55_27 then
					var_55_27:EnableDynamicBone(true)
				end
			end

			local var_55_28 = 0
			local var_55_29 = 1.175

			if var_55_28 < arg_52_1.time_ and arg_52_1.time_ <= var_55_28 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_30 = arg_52_1:GetWordFromCfg(105082013)
				local var_55_31 = arg_52_1:FormatText(var_55_30.content)

				arg_52_1.text_.text = var_55_31

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_32 = 47
				local var_55_33 = utf8.len(var_55_31)
				local var_55_34 = var_55_32 <= 0 and var_55_29 or var_55_29 * (var_55_33 / var_55_32)

				if var_55_34 > 0 and var_55_29 < var_55_34 then
					arg_52_1.talkMaxDuration = var_55_34

					if var_55_34 + var_55_28 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_34 + var_55_28
					end
				end

				arg_52_1.text_.text = var_55_31
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_35 = math.max(var_55_29, arg_52_1.talkMaxDuration)

			if var_55_28 <= arg_52_1.time_ and arg_52_1.time_ < var_55_28 + var_55_35 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_28) / var_55_35

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_28 + var_55_35 and arg_52_1.time_ < var_55_28 + var_55_35 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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

		arg_52_1:InitPlayNodeList()
	end,
	Play105082014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 105082014
		arg_56_1.duration_ = 9

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play105082015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_1 = 2

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_1 then
				local var_59_2 = (arg_56_1.time_ - var_59_0) / var_59_1
				local var_59_3 = Color.New(0, 0, 0)

				var_59_3.a = Mathf.Lerp(0, 1, var_59_2)
				arg_56_1.mask_.color = var_59_3
			end

			if arg_56_1.time_ >= var_59_0 + var_59_1 and arg_56_1.time_ < var_59_0 + var_59_1 + arg_59_0 then
				local var_59_4 = Color.New(0, 0, 0)

				var_59_4.a = 1
				arg_56_1.mask_.color = var_59_4
			end

			local var_59_5 = 2

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_6 = 2

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6
				local var_59_8 = Color.New(0, 0, 0)

				var_59_8.a = Mathf.Lerp(1, 0, var_59_7)
				arg_56_1.mask_.color = var_59_8
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 then
				local var_59_9 = Color.New(0, 0, 0)
				local var_59_10 = 0

				arg_56_1.mask_.enabled = false
				var_59_9.a = var_59_10
				arg_56_1.mask_.color = var_59_9
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_11 = 4
			local var_59_12 = 0.175

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_13 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_13:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_14 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_15 = arg_56_1:GetWordFromCfg(105082014)
				local var_59_16 = arg_56_1:FormatText(var_59_15.content)

				arg_56_1.text_.text = var_59_16

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_17 = 7
				local var_59_18 = utf8.len(var_59_16)
				local var_59_19 = var_59_17 <= 0 and var_59_12 or var_59_12 * (var_59_18 / var_59_17)

				if var_59_19 > 0 and var_59_12 < var_59_19 then
					arg_56_1.talkMaxDuration = var_59_19
					var_59_11 = var_59_11 + 0.3

					if var_59_19 + var_59_11 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_19 + var_59_11
					end
				end

				arg_56_1.text_.text = var_59_16
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_20 = var_59_11 + 0.3
			local var_59_21 = math.max(var_59_12, arg_56_1.talkMaxDuration)

			if var_59_20 <= arg_56_1.time_ and arg_56_1.time_ < var_59_20 + var_59_21 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_20) / var_59_21

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_20 + var_59_21 and arg_56_1.time_ < var_59_20 + var_59_21 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play105082015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 105082015
		arg_62_1.duration_ = 2

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play105082016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = "1059ui_story"

			if arg_62_1.actors_[var_65_0] == nil then
				local var_65_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_65_1) then
					local var_65_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_62_1.stage_.transform)

					var_65_2.name = var_65_0
					var_65_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_62_1.actors_[var_65_0] = var_65_2

					local var_65_3 = var_65_2:GetComponentInChildren(typeof(CharacterEffect))

					var_65_3.enabled = true

					local var_65_4 = GameObjectTools.GetOrAddComponent(var_65_2, typeof(DynamicBoneHelper))

					if var_65_4 then
						var_65_4:EnableDynamicBone(false)
					end

					arg_62_1:ShowWeapon(var_65_3.transform, false)

					arg_62_1.var_[var_65_0 .. "Animator"] = var_65_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_62_1.var_[var_65_0 .. "Animator"].applyRootMotion = true
					arg_62_1.var_[var_65_0 .. "LipSync"] = var_65_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_65_5 = arg_62_1.actors_["1059ui_story"]
			local var_65_6 = 0

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 and not isNil(var_65_5) and arg_62_1.var_.characterEffect1059ui_story == nil then
				arg_62_1.var_.characterEffect1059ui_story = var_65_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_7 = 0.1

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_7 and not isNil(var_65_5) then
				local var_65_8 = (arg_62_1.time_ - var_65_6) / var_65_7

				if arg_62_1.var_.characterEffect1059ui_story and not isNil(var_65_5) then
					arg_62_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_6 + var_65_7 and arg_62_1.time_ < var_65_6 + var_65_7 + arg_65_0 and not isNil(var_65_5) and arg_62_1.var_.characterEffect1059ui_story then
				arg_62_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_65_9 = arg_62_1.actors_["1059ui_story"].transform
			local var_65_10 = 0

			if var_65_10 < arg_62_1.time_ and arg_62_1.time_ <= var_65_10 + arg_65_0 then
				arg_62_1.var_.moveOldPos1059ui_story = var_65_9.localPosition
			end

			local var_65_11 = 0.001

			if var_65_10 <= arg_62_1.time_ and arg_62_1.time_ < var_65_10 + var_65_11 then
				local var_65_12 = (arg_62_1.time_ - var_65_10) / var_65_11
				local var_65_13 = Vector3.New(0, -1.05, -6)

				var_65_9.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1059ui_story, var_65_13, var_65_12)

				local var_65_14 = manager.ui.mainCamera.transform.position - var_65_9.position

				var_65_9.forward = Vector3.New(var_65_14.x, var_65_14.y, var_65_14.z)

				local var_65_15 = var_65_9.localEulerAngles

				var_65_15.z = 0
				var_65_15.x = 0
				var_65_9.localEulerAngles = var_65_15
			end

			if arg_62_1.time_ >= var_65_10 + var_65_11 and arg_62_1.time_ < var_65_10 + var_65_11 + arg_65_0 then
				var_65_9.localPosition = Vector3.New(0, -1.05, -6)

				local var_65_16 = manager.ui.mainCamera.transform.position - var_65_9.position

				var_65_9.forward = Vector3.New(var_65_16.x, var_65_16.y, var_65_16.z)

				local var_65_17 = var_65_9.localEulerAngles

				var_65_17.z = 0
				var_65_17.x = 0
				var_65_9.localEulerAngles = var_65_17
			end

			local var_65_18 = 0

			if var_65_18 < arg_62_1.time_ and arg_62_1.time_ <= var_65_18 + arg_65_0 then
				arg_62_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			local var_65_19 = 0

			if var_65_19 < arg_62_1.time_ and arg_62_1.time_ <= var_65_19 + arg_65_0 then
				arg_62_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_65_20 = 0
			local var_65_21 = 0.075

			if var_65_20 < arg_62_1.time_ and arg_62_1.time_ <= var_65_20 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_22 = arg_62_1:FormatText(StoryNameCfg[28].name)

				arg_62_1.leftNameTxt_.text = var_65_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_23 = arg_62_1:GetWordFromCfg(105082015)
				local var_65_24 = arg_62_1:FormatText(var_65_23.content)

				arg_62_1.text_.text = var_65_24

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_25 = 3
				local var_65_26 = utf8.len(var_65_24)
				local var_65_27 = var_65_25 <= 0 and var_65_21 or var_65_21 * (var_65_26 / var_65_25)

				if var_65_27 > 0 and var_65_21 < var_65_27 then
					arg_62_1.talkMaxDuration = var_65_27

					if var_65_27 + var_65_20 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_27 + var_65_20
					end
				end

				arg_62_1.text_.text = var_65_24
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082015", "story_v_out_105082.awb") ~= 0 then
					local var_65_28 = manager.audio:GetVoiceLength("story_v_out_105082", "105082015", "story_v_out_105082.awb") / 1000

					if var_65_28 + var_65_20 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_28 + var_65_20
					end

					if var_65_23.prefab_name ~= "" and arg_62_1.actors_[var_65_23.prefab_name] ~= nil then
						local var_65_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_23.prefab_name].transform, "story_v_out_105082", "105082015", "story_v_out_105082.awb")

						arg_62_1:RecordAudio("105082015", var_65_29)
						arg_62_1:RecordAudio("105082015", var_65_29)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_105082", "105082015", "story_v_out_105082.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_105082", "105082015", "story_v_out_105082.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_30 = math.max(var_65_21, arg_62_1.talkMaxDuration)

			if var_65_20 <= arg_62_1.time_ and arg_62_1.time_ < var_65_20 + var_65_30 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_20) / var_65_30

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_20 + var_65_30 and arg_62_1.time_ < var_65_20 + var_65_30 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
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

		arg_62_1:InitPlayNodeList()
	end,
	Play105082016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 105082016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play105082017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1059ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1059ui_story == nil then
				arg_66_1.var_.characterEffect1059ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.1

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1059ui_story and not isNil(var_69_0) then
					local var_69_4 = Mathf.Lerp(0, 0.5, var_69_3)

					arg_66_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1059ui_story.fillRatio = var_69_4
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1059ui_story then
				local var_69_5 = 0.5

				arg_66_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1059ui_story.fillRatio = var_69_5
			end

			local var_69_6 = arg_66_1.actors_["1059ui_story"].transform
			local var_69_7 = 0

			if var_69_7 < arg_66_1.time_ and arg_66_1.time_ <= var_69_7 + arg_69_0 then
				arg_66_1.var_.moveOldPos1059ui_story = var_69_6.localPosition
			end

			local var_69_8 = 0.001

			if var_69_7 <= arg_66_1.time_ and arg_66_1.time_ < var_69_7 + var_69_8 then
				local var_69_9 = (arg_66_1.time_ - var_69_7) / var_69_8
				local var_69_10 = Vector3.New(0, 100, 0)

				var_69_6.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1059ui_story, var_69_10, var_69_9)

				local var_69_11 = manager.ui.mainCamera.transform.position - var_69_6.position

				var_69_6.forward = Vector3.New(var_69_11.x, var_69_11.y, var_69_11.z)

				local var_69_12 = var_69_6.localEulerAngles

				var_69_12.z = 0
				var_69_12.x = 0
				var_69_6.localEulerAngles = var_69_12
			end

			if arg_66_1.time_ >= var_69_7 + var_69_8 and arg_66_1.time_ < var_69_7 + var_69_8 + arg_69_0 then
				var_69_6.localPosition = Vector3.New(0, 100, 0)

				local var_69_13 = manager.ui.mainCamera.transform.position - var_69_6.position

				var_69_6.forward = Vector3.New(var_69_13.x, var_69_13.y, var_69_13.z)

				local var_69_14 = var_69_6.localEulerAngles

				var_69_14.z = 0
				var_69_14.x = 0
				var_69_6.localEulerAngles = var_69_14
			end

			local var_69_15 = 0
			local var_69_16 = 1.25

			if var_69_15 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_17 = arg_66_1:GetWordFromCfg(105082016)
				local var_69_18 = arg_66_1:FormatText(var_69_17.content)

				arg_66_1.text_.text = var_69_18

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_19 = 49
				local var_69_20 = utf8.len(var_69_18)
				local var_69_21 = var_69_19 <= 0 and var_69_16 or var_69_16 * (var_69_20 / var_69_19)

				if var_69_21 > 0 and var_69_16 < var_69_21 then
					arg_66_1.talkMaxDuration = var_69_21

					if var_69_21 + var_69_15 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_21 + var_69_15
					end
				end

				arg_66_1.text_.text = var_69_18
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_22 = math.max(var_69_16, arg_66_1.talkMaxDuration)

			if var_69_15 <= arg_66_1.time_ and arg_66_1.time_ < var_69_15 + var_69_22 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_15) / var_69_22

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_15 + var_69_22 and arg_66_1.time_ < var_69_15 + var_69_22 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
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

		arg_66_1:InitPlayNodeList()
	end,
	Play105082017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 105082017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play105082018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 1

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				local var_73_2 = "play"
				local var_73_3 = "effect"

				arg_70_1:AudioAction(var_73_2, var_73_3, "se_story_5", "se_story_5_arrow", "")
			end

			local var_73_4 = 0
			local var_73_5 = 0.9

			if var_73_4 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_6 = arg_70_1:GetWordFromCfg(105082017)
				local var_73_7 = arg_70_1:FormatText(var_73_6.content)

				arg_70_1.text_.text = var_73_7

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_8 = 36
				local var_73_9 = utf8.len(var_73_7)
				local var_73_10 = var_73_8 <= 0 and var_73_5 or var_73_5 * (var_73_9 / var_73_8)

				if var_73_10 > 0 and var_73_5 < var_73_10 then
					arg_70_1.talkMaxDuration = var_73_10

					if var_73_10 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_4
					end
				end

				arg_70_1.text_.text = var_73_7
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_11 = math.max(var_73_5, arg_70_1.talkMaxDuration)

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_11 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_4) / var_73_11

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_4 + var_73_11 and arg_70_1.time_ < var_73_4 + var_73_11 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play105082018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 105082018
		arg_74_1.duration_ = 2.83

		local var_74_0 = {
			ja = 2.833,
			ko = 2.766,
			zh = 2.5,
			en = 2.2
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
				arg_74_0:Play105082019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = "1148ui_story"

			if arg_74_1.actors_[var_77_0] == nil then
				local var_77_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_77_1) then
					local var_77_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_74_1.stage_.transform)

					var_77_2.name = var_77_0
					var_77_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_74_1.actors_[var_77_0] = var_77_2

					local var_77_3 = var_77_2:GetComponentInChildren(typeof(CharacterEffect))

					var_77_3.enabled = true

					local var_77_4 = GameObjectTools.GetOrAddComponent(var_77_2, typeof(DynamicBoneHelper))

					if var_77_4 then
						var_77_4:EnableDynamicBone(false)
					end

					arg_74_1:ShowWeapon(var_77_3.transform, false)

					arg_74_1.var_[var_77_0 .. "Animator"] = var_77_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_74_1.var_[var_77_0 .. "Animator"].applyRootMotion = true
					arg_74_1.var_[var_77_0 .. "LipSync"] = var_77_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_77_5 = arg_74_1.actors_["1148ui_story"]
			local var_77_6 = 0

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 and not isNil(var_77_5) and arg_74_1.var_.characterEffect1148ui_story == nil then
				arg_74_1.var_.characterEffect1148ui_story = var_77_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_7 = 0.1

			if var_77_6 <= arg_74_1.time_ and arg_74_1.time_ < var_77_6 + var_77_7 and not isNil(var_77_5) then
				local var_77_8 = (arg_74_1.time_ - var_77_6) / var_77_7

				if arg_74_1.var_.characterEffect1148ui_story and not isNil(var_77_5) then
					arg_74_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_6 + var_77_7 and arg_74_1.time_ < var_77_6 + var_77_7 + arg_77_0 and not isNil(var_77_5) and arg_74_1.var_.characterEffect1148ui_story then
				arg_74_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_77_9 = arg_74_1.actors_["1148ui_story"].transform
			local var_77_10 = 0

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 then
				arg_74_1.var_.moveOldPos1148ui_story = var_77_9.localPosition
			end

			local var_77_11 = 0.001

			if var_77_10 <= arg_74_1.time_ and arg_74_1.time_ < var_77_10 + var_77_11 then
				local var_77_12 = (arg_74_1.time_ - var_77_10) / var_77_11
				local var_77_13 = Vector3.New(-0.7, -0.8, -6.2)

				var_77_9.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1148ui_story, var_77_13, var_77_12)

				local var_77_14 = manager.ui.mainCamera.transform.position - var_77_9.position

				var_77_9.forward = Vector3.New(var_77_14.x, var_77_14.y, var_77_14.z)

				local var_77_15 = var_77_9.localEulerAngles

				var_77_15.z = 0
				var_77_15.x = 0
				var_77_9.localEulerAngles = var_77_15
			end

			if arg_74_1.time_ >= var_77_10 + var_77_11 and arg_74_1.time_ < var_77_10 + var_77_11 + arg_77_0 then
				var_77_9.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_77_16 = manager.ui.mainCamera.transform.position - var_77_9.position

				var_77_9.forward = Vector3.New(var_77_16.x, var_77_16.y, var_77_16.z)

				local var_77_17 = var_77_9.localEulerAngles

				var_77_17.z = 0
				var_77_17.x = 0
				var_77_9.localEulerAngles = var_77_17
			end

			local var_77_18 = 0

			if var_77_18 < arg_74_1.time_ and arg_74_1.time_ <= var_77_18 + arg_77_0 then
				arg_74_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_77_19 = 0

			if var_77_19 < arg_74_1.time_ and arg_74_1.time_ <= var_77_19 + arg_77_0 then
				arg_74_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_77_20 = 0
			local var_77_21 = 0.225

			if var_77_20 < arg_74_1.time_ and arg_74_1.time_ <= var_77_20 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_22 = arg_74_1:FormatText(StoryNameCfg[8].name)

				arg_74_1.leftNameTxt_.text = var_77_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_23 = arg_74_1:GetWordFromCfg(105082018)
				local var_77_24 = arg_74_1:FormatText(var_77_23.content)

				arg_74_1.text_.text = var_77_24

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_25 = 9
				local var_77_26 = utf8.len(var_77_24)
				local var_77_27 = var_77_25 <= 0 and var_77_21 or var_77_21 * (var_77_26 / var_77_25)

				if var_77_27 > 0 and var_77_21 < var_77_27 then
					arg_74_1.talkMaxDuration = var_77_27

					if var_77_27 + var_77_20 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_27 + var_77_20
					end
				end

				arg_74_1.text_.text = var_77_24
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082018", "story_v_out_105082.awb") ~= 0 then
					local var_77_28 = manager.audio:GetVoiceLength("story_v_out_105082", "105082018", "story_v_out_105082.awb") / 1000

					if var_77_28 + var_77_20 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_28 + var_77_20
					end

					if var_77_23.prefab_name ~= "" and arg_74_1.actors_[var_77_23.prefab_name] ~= nil then
						local var_77_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_23.prefab_name].transform, "story_v_out_105082", "105082018", "story_v_out_105082.awb")

						arg_74_1:RecordAudio("105082018", var_77_29)
						arg_74_1:RecordAudio("105082018", var_77_29)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_105082", "105082018", "story_v_out_105082.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_105082", "105082018", "story_v_out_105082.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_30 = math.max(var_77_21, arg_74_1.talkMaxDuration)

			if var_77_20 <= arg_74_1.time_ and arg_74_1.time_ < var_77_20 + var_77_30 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_20) / var_77_30

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_20 + var_77_30 and arg_74_1.time_ < var_77_20 + var_77_30 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
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

		arg_74_1:InitPlayNodeList()
	end,
	Play105082019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 105082019
		arg_78_1.duration_ = 2.53

		local var_78_0 = {
			ja = 2.533,
			ko = 2.033,
			zh = 1.999999999999,
			en = 2.466
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
				arg_78_0:Play105082020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = "1027ui_story"

			if arg_78_1.actors_[var_81_0] == nil then
				local var_81_1 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_81_1) then
					local var_81_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_78_1.stage_.transform)

					var_81_2.name = var_81_0
					var_81_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_78_1.actors_[var_81_0] = var_81_2

					local var_81_3 = var_81_2:GetComponentInChildren(typeof(CharacterEffect))

					var_81_3.enabled = true

					local var_81_4 = GameObjectTools.GetOrAddComponent(var_81_2, typeof(DynamicBoneHelper))

					if var_81_4 then
						var_81_4:EnableDynamicBone(false)
					end

					arg_78_1:ShowWeapon(var_81_3.transform, false)

					arg_78_1.var_[var_81_0 .. "Animator"] = var_81_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_78_1.var_[var_81_0 .. "Animator"].applyRootMotion = true
					arg_78_1.var_[var_81_0 .. "LipSync"] = var_81_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_81_5 = arg_78_1.actors_["1027ui_story"]
			local var_81_6 = 0

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 and not isNil(var_81_5) and arg_78_1.var_.characterEffect1027ui_story == nil then
				arg_78_1.var_.characterEffect1027ui_story = var_81_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_7 = 0.1

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_7 and not isNil(var_81_5) then
				local var_81_8 = (arg_78_1.time_ - var_81_6) / var_81_7

				if arg_78_1.var_.characterEffect1027ui_story and not isNil(var_81_5) then
					arg_78_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_6 + var_81_7 and arg_78_1.time_ < var_81_6 + var_81_7 + arg_81_0 and not isNil(var_81_5) and arg_78_1.var_.characterEffect1027ui_story then
				arg_78_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_81_9 = arg_78_1.actors_["1148ui_story"]
			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 and not isNil(var_81_9) and arg_78_1.var_.characterEffect1148ui_story == nil then
				arg_78_1.var_.characterEffect1148ui_story = var_81_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_11 = 0.1

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_11 and not isNil(var_81_9) then
				local var_81_12 = (arg_78_1.time_ - var_81_10) / var_81_11

				if arg_78_1.var_.characterEffect1148ui_story and not isNil(var_81_9) then
					local var_81_13 = Mathf.Lerp(0, 0.5, var_81_12)

					arg_78_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1148ui_story.fillRatio = var_81_13
				end
			end

			if arg_78_1.time_ >= var_81_10 + var_81_11 and arg_78_1.time_ < var_81_10 + var_81_11 + arg_81_0 and not isNil(var_81_9) and arg_78_1.var_.characterEffect1148ui_story then
				local var_81_14 = 0.5

				arg_78_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1148ui_story.fillRatio = var_81_14
			end

			local var_81_15 = arg_78_1.actors_["1027ui_story"].transform
			local var_81_16 = 0

			if var_81_16 < arg_78_1.time_ and arg_78_1.time_ <= var_81_16 + arg_81_0 then
				arg_78_1.var_.moveOldPos1027ui_story = var_81_15.localPosition
			end

			local var_81_17 = 0.001

			if var_81_16 <= arg_78_1.time_ and arg_78_1.time_ < var_81_16 + var_81_17 then
				local var_81_18 = (arg_78_1.time_ - var_81_16) / var_81_17
				local var_81_19 = Vector3.New(0.7, -0.81, -5.8)

				var_81_15.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1027ui_story, var_81_19, var_81_18)

				local var_81_20 = manager.ui.mainCamera.transform.position - var_81_15.position

				var_81_15.forward = Vector3.New(var_81_20.x, var_81_20.y, var_81_20.z)

				local var_81_21 = var_81_15.localEulerAngles

				var_81_21.z = 0
				var_81_21.x = 0
				var_81_15.localEulerAngles = var_81_21
			end

			if arg_78_1.time_ >= var_81_16 + var_81_17 and arg_78_1.time_ < var_81_16 + var_81_17 + arg_81_0 then
				var_81_15.localPosition = Vector3.New(0.7, -0.81, -5.8)

				local var_81_22 = manager.ui.mainCamera.transform.position - var_81_15.position

				var_81_15.forward = Vector3.New(var_81_22.x, var_81_22.y, var_81_22.z)

				local var_81_23 = var_81_15.localEulerAngles

				var_81_23.z = 0
				var_81_23.x = 0
				var_81_15.localEulerAngles = var_81_23
			end

			local var_81_24 = 0

			if var_81_24 < arg_78_1.time_ and arg_78_1.time_ <= var_81_24 + arg_81_0 then
				arg_78_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_81_25 = 0

			if var_81_25 < arg_78_1.time_ and arg_78_1.time_ <= var_81_25 + arg_81_0 then
				arg_78_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_81_26 = 0
			local var_81_27 = 0.25

			if var_81_26 < arg_78_1.time_ and arg_78_1.time_ <= var_81_26 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_28 = arg_78_1:FormatText(StoryNameCfg[56].name)

				arg_78_1.leftNameTxt_.text = var_81_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_29 = arg_78_1:GetWordFromCfg(105082019)
				local var_81_30 = arg_78_1:FormatText(var_81_29.content)

				arg_78_1.text_.text = var_81_30

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_31 = 10
				local var_81_32 = utf8.len(var_81_30)
				local var_81_33 = var_81_31 <= 0 and var_81_27 or var_81_27 * (var_81_32 / var_81_31)

				if var_81_33 > 0 and var_81_27 < var_81_33 then
					arg_78_1.talkMaxDuration = var_81_33

					if var_81_33 + var_81_26 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_33 + var_81_26
					end
				end

				arg_78_1.text_.text = var_81_30
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082019", "story_v_out_105082.awb") ~= 0 then
					local var_81_34 = manager.audio:GetVoiceLength("story_v_out_105082", "105082019", "story_v_out_105082.awb") / 1000

					if var_81_34 + var_81_26 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_34 + var_81_26
					end

					if var_81_29.prefab_name ~= "" and arg_78_1.actors_[var_81_29.prefab_name] ~= nil then
						local var_81_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_29.prefab_name].transform, "story_v_out_105082", "105082019", "story_v_out_105082.awb")

						arg_78_1:RecordAudio("105082019", var_81_35)
						arg_78_1:RecordAudio("105082019", var_81_35)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_105082", "105082019", "story_v_out_105082.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_105082", "105082019", "story_v_out_105082.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_36 = math.max(var_81_27, arg_78_1.talkMaxDuration)

			if var_81_26 <= arg_78_1.time_ and arg_78_1.time_ < var_81_26 + var_81_36 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_26) / var_81_36

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_26 + var_81_36 and arg_78_1.time_ < var_81_26 + var_81_36 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play105082020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 105082020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play105082021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1027ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1027ui_story == nil then
				arg_82_1.var_.characterEffect1027ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.1

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect1027ui_story and not isNil(var_85_0) then
					local var_85_4 = Mathf.Lerp(0, 0.5, var_85_3)

					arg_82_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1027ui_story.fillRatio = var_85_4
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1027ui_story then
				local var_85_5 = 0.5

				arg_82_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1027ui_story.fillRatio = var_85_5
			end

			local var_85_6 = 0
			local var_85_7 = 0.775

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_8 = arg_82_1:GetWordFromCfg(105082020)
				local var_85_9 = arg_82_1:FormatText(var_85_8.content)

				arg_82_1.text_.text = var_85_9

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_10 = 31
				local var_85_11 = utf8.len(var_85_9)
				local var_85_12 = var_85_10 <= 0 and var_85_7 or var_85_7 * (var_85_11 / var_85_10)

				if var_85_12 > 0 and var_85_7 < var_85_12 then
					arg_82_1.talkMaxDuration = var_85_12

					if var_85_12 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_12 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_9
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_13 = math.max(var_85_7, arg_82_1.talkMaxDuration)

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_13 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_13

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_13 and arg_82_1.time_ < var_85_6 + var_85_13 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play105082021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 105082021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play105082022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1027ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos1027ui_story = var_89_0.localPosition
			end

			local var_89_2 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2
				local var_89_4 = Vector3.New(0, 100, 0)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1027ui_story, var_89_4, var_89_3)

				local var_89_5 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_5.x, var_89_5.y, var_89_5.z)

				local var_89_6 = var_89_0.localEulerAngles

				var_89_6.z = 0
				var_89_6.x = 0
				var_89_0.localEulerAngles = var_89_6
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0, 100, 0)

				local var_89_7 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_7.x, var_89_7.y, var_89_7.z)

				local var_89_8 = var_89_0.localEulerAngles

				var_89_8.z = 0
				var_89_8.x = 0
				var_89_0.localEulerAngles = var_89_8
			end

			local var_89_9 = arg_86_1.actors_["1148ui_story"].transform
			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.var_.moveOldPos1148ui_story = var_89_9.localPosition
			end

			local var_89_11 = 0.001

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_11 then
				local var_89_12 = (arg_86_1.time_ - var_89_10) / var_89_11
				local var_89_13 = Vector3.New(0, 100, 0)

				var_89_9.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1148ui_story, var_89_13, var_89_12)

				local var_89_14 = manager.ui.mainCamera.transform.position - var_89_9.position

				var_89_9.forward = Vector3.New(var_89_14.x, var_89_14.y, var_89_14.z)

				local var_89_15 = var_89_9.localEulerAngles

				var_89_15.z = 0
				var_89_15.x = 0
				var_89_9.localEulerAngles = var_89_15
			end

			if arg_86_1.time_ >= var_89_10 + var_89_11 and arg_86_1.time_ < var_89_10 + var_89_11 + arg_89_0 then
				var_89_9.localPosition = Vector3.New(0, 100, 0)

				local var_89_16 = manager.ui.mainCamera.transform.position - var_89_9.position

				var_89_9.forward = Vector3.New(var_89_16.x, var_89_16.y, var_89_16.z)

				local var_89_17 = var_89_9.localEulerAngles

				var_89_17.z = 0
				var_89_17.x = 0
				var_89_9.localEulerAngles = var_89_17
			end

			local var_89_18 = 0
			local var_89_19 = 1.125

			if var_89_18 < arg_86_1.time_ and arg_86_1.time_ <= var_89_18 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_20 = arg_86_1:GetWordFromCfg(105082021)
				local var_89_21 = arg_86_1:FormatText(var_89_20.content)

				arg_86_1.text_.text = var_89_21

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_22 = 45
				local var_89_23 = utf8.len(var_89_21)
				local var_89_24 = var_89_22 <= 0 and var_89_19 or var_89_19 * (var_89_23 / var_89_22)

				if var_89_24 > 0 and var_89_19 < var_89_24 then
					arg_86_1.talkMaxDuration = var_89_24

					if var_89_24 + var_89_18 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_24 + var_89_18
					end
				end

				arg_86_1.text_.text = var_89_21
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_25 = math.max(var_89_19, arg_86_1.talkMaxDuration)

			if var_89_18 <= arg_86_1.time_ and arg_86_1.time_ < var_89_18 + var_89_25 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_18) / var_89_25

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_18 + var_89_25 and arg_86_1.time_ < var_89_18 + var_89_25 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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

		arg_86_1:InitPlayNodeList()
	end,
	Play105082022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 105082022
		arg_90_1.duration_ = 10.6

		local var_90_0 = {
			ja = 10.166,
			ko = 7.333,
			zh = 9.066,
			en = 10.6
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
				arg_90_0:Play105082023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 1.175

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[10].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:GetWordFromCfg(105082022)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 46
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082022", "story_v_out_105082.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_105082", "105082022", "story_v_out_105082.awb") / 1000

					if var_93_8 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_0
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_105082", "105082022", "story_v_out_105082.awb")

						arg_90_1:RecordAudio("105082022", var_93_9)
						arg_90_1:RecordAudio("105082022", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_105082", "105082022", "story_v_out_105082.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_105082", "105082022", "story_v_out_105082.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_10 and arg_90_1.time_ < var_93_0 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play105082023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 105082023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play105082024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.125

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[7].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:GetWordFromCfg(105082023)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 5
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_8 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_8 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_8

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_8 and arg_94_1.time_ < var_97_0 + var_97_8 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play105082024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 105082024
		arg_98_1.duration_ = 13.07

		local var_98_0 = {
			ja = 13.066,
			ko = 5.7,
			zh = 7.566,
			en = 8.266
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play105082025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 1

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				local var_101_2 = "play"
				local var_101_3 = "effect"

				arg_98_1:AudioAction(var_101_2, var_101_3, "se_story", "se_story_robot_long", "")
			end

			local var_101_4 = "3005_tpose"

			if arg_98_1.actors_[var_101_4] == nil then
				local var_101_5 = Asset.Load("Char/" .. "3005_tpose")

				if not isNil(var_101_5) then
					local var_101_6 = Object.Instantiate(Asset.Load("Char/" .. "3005_tpose"), arg_98_1.stage_.transform)

					var_101_6.name = var_101_4
					var_101_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_98_1.actors_[var_101_4] = var_101_6

					local var_101_7 = var_101_6:GetComponentInChildren(typeof(CharacterEffect))

					var_101_7.enabled = true

					local var_101_8 = GameObjectTools.GetOrAddComponent(var_101_6, typeof(DynamicBoneHelper))

					if var_101_8 then
						var_101_8:EnableDynamicBone(false)
					end

					arg_98_1:ShowWeapon(var_101_7.transform, false)

					arg_98_1.var_[var_101_4 .. "Animator"] = var_101_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_98_1.var_[var_101_4 .. "Animator"].applyRootMotion = true
					arg_98_1.var_[var_101_4 .. "LipSync"] = var_101_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_101_9 = arg_98_1.actors_["3005_tpose"]
			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect3005_tpose == nil then
				arg_98_1.var_.characterEffect3005_tpose = var_101_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_11 = 0.1

			if var_101_10 <= arg_98_1.time_ and arg_98_1.time_ < var_101_10 + var_101_11 and not isNil(var_101_9) then
				local var_101_12 = (arg_98_1.time_ - var_101_10) / var_101_11

				if arg_98_1.var_.characterEffect3005_tpose and not isNil(var_101_9) then
					arg_98_1.var_.characterEffect3005_tpose.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_10 + var_101_11 and arg_98_1.time_ < var_101_10 + var_101_11 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect3005_tpose then
				arg_98_1.var_.characterEffect3005_tpose.fillFlat = false
			end

			local var_101_13 = arg_98_1.actors_["3005_tpose"].transform
			local var_101_14 = 0

			if var_101_14 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 then
				arg_98_1.var_.moveOldPos3005_tpose = var_101_13.localPosition

				local var_101_15 = GameObjectTools.GetOrAddComponent(var_101_13.gameObject, typeof(DynamicBoneHelper))

				if var_101_15 then
					var_101_15:EnableDynamicBone(false)
				end
			end

			local var_101_16 = 0.001

			if var_101_14 <= arg_98_1.time_ and arg_98_1.time_ < var_101_14 + var_101_16 then
				local var_101_17 = (arg_98_1.time_ - var_101_14) / var_101_16
				local var_101_18 = Vector3.New(0, -1.95, -2.63)

				var_101_13.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos3005_tpose, var_101_18, var_101_17)

				local var_101_19 = manager.ui.mainCamera.transform.position - var_101_13.position

				var_101_13.forward = Vector3.New(var_101_19.x, var_101_19.y, var_101_19.z)

				local var_101_20 = var_101_13.localEulerAngles

				var_101_20.z = 0
				var_101_20.x = 0
				var_101_13.localEulerAngles = var_101_20
			end

			if arg_98_1.time_ >= var_101_14 + var_101_16 and arg_98_1.time_ < var_101_14 + var_101_16 + arg_101_0 then
				var_101_13.localPosition = Vector3.New(0, -1.95, -2.63)

				local var_101_21 = manager.ui.mainCamera.transform.position - var_101_13.position

				var_101_13.forward = Vector3.New(var_101_21.x, var_101_21.y, var_101_21.z)

				local var_101_22 = var_101_13.localEulerAngles

				var_101_22.z = 0
				var_101_22.x = 0
				var_101_13.localEulerAngles = var_101_22

				local var_101_23 = GameObjectTools.GetOrAddComponent(var_101_13.gameObject, typeof(DynamicBoneHelper))

				if var_101_23 then
					var_101_23:EnableDynamicBone(true)
				end
			end

			local var_101_24 = 0

			if var_101_24 < arg_98_1.time_ and arg_98_1.time_ <= var_101_24 + arg_101_0 then
				arg_98_1:PlayTimeline("3005_tpose", "StoryTimeline/CharAction/story3005/story3005action/3005action1_1")
			end

			local var_101_25 = 0
			local var_101_26 = 0.6

			if var_101_25 < arg_98_1.time_ and arg_98_1.time_ <= var_101_25 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_27 = arg_98_1:FormatText(StoryNameCfg[58].name)

				arg_98_1.leftNameTxt_.text = var_101_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_28 = arg_98_1:GetWordFromCfg(105082024)
				local var_101_29 = arg_98_1:FormatText(var_101_28.content)

				arg_98_1.text_.text = var_101_29

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_30 = 24
				local var_101_31 = utf8.len(var_101_29)
				local var_101_32 = var_101_30 <= 0 and var_101_26 or var_101_26 * (var_101_31 / var_101_30)

				if var_101_32 > 0 and var_101_26 < var_101_32 then
					arg_98_1.talkMaxDuration = var_101_32

					if var_101_32 + var_101_25 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_32 + var_101_25
					end
				end

				arg_98_1.text_.text = var_101_29
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082024", "story_v_out_105082.awb") ~= 0 then
					local var_101_33 = manager.audio:GetVoiceLength("story_v_out_105082", "105082024", "story_v_out_105082.awb") / 1000

					if var_101_33 + var_101_25 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_33 + var_101_25
					end

					if var_101_28.prefab_name ~= "" and arg_98_1.actors_[var_101_28.prefab_name] ~= nil then
						local var_101_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_28.prefab_name].transform, "story_v_out_105082", "105082024", "story_v_out_105082.awb")

						arg_98_1:RecordAudio("105082024", var_101_34)
						arg_98_1:RecordAudio("105082024", var_101_34)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_105082", "105082024", "story_v_out_105082.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_105082", "105082024", "story_v_out_105082.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_35 = math.max(var_101_26, arg_98_1.talkMaxDuration)

			if var_101_25 <= arg_98_1.time_ and arg_98_1.time_ < var_101_25 + var_101_35 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_25) / var_101_35

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_25 + var_101_35 and arg_98_1.time_ < var_101_25 + var_101_35 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play105082025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 105082025
		arg_102_1.duration_ = 2.73

		local var_102_0 = {
			ja = 2.733,
			ko = 1.999999999999,
			zh = 2.366,
			en = 2.566
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
				arg_102_0:Play105082026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1027ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1027ui_story == nil then
				arg_102_1.var_.characterEffect1027ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.1

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1027ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1027ui_story then
				arg_102_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_105_4 = arg_102_1.actors_["3005_tpose"]
			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect3005_tpose == nil then
				arg_102_1.var_.characterEffect3005_tpose = var_105_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_6 = 0.1

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_6 and not isNil(var_105_4) then
				local var_105_7 = (arg_102_1.time_ - var_105_5) / var_105_6

				if arg_102_1.var_.characterEffect3005_tpose and not isNil(var_105_4) then
					local var_105_8 = Mathf.Lerp(0, 0.5, var_105_7)

					arg_102_1.var_.characterEffect3005_tpose.fillFlat = true
					arg_102_1.var_.characterEffect3005_tpose.fillRatio = var_105_8
				end
			end

			if arg_102_1.time_ >= var_105_5 + var_105_6 and arg_102_1.time_ < var_105_5 + var_105_6 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect3005_tpose then
				local var_105_9 = 0.5

				arg_102_1.var_.characterEffect3005_tpose.fillFlat = true
				arg_102_1.var_.characterEffect3005_tpose.fillRatio = var_105_9
			end

			local var_105_10 = arg_102_1.actors_["3005_tpose"].transform
			local var_105_11 = 0

			if var_105_11 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 then
				arg_102_1.var_.moveOldPos3005_tpose = var_105_10.localPosition

				local var_105_12 = GameObjectTools.GetOrAddComponent(var_105_10.gameObject, typeof(DynamicBoneHelper))

				if var_105_12 then
					var_105_12:EnableDynamicBone(false)
				end
			end

			local var_105_13 = 0.001

			if var_105_11 <= arg_102_1.time_ and arg_102_1.time_ < var_105_11 + var_105_13 then
				local var_105_14 = (arg_102_1.time_ - var_105_11) / var_105_13
				local var_105_15 = Vector3.New(0, 100, 0)

				var_105_10.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos3005_tpose, var_105_15, var_105_14)

				local var_105_16 = manager.ui.mainCamera.transform.position - var_105_10.position

				var_105_10.forward = Vector3.New(var_105_16.x, var_105_16.y, var_105_16.z)

				local var_105_17 = var_105_10.localEulerAngles

				var_105_17.z = 0
				var_105_17.x = 0
				var_105_10.localEulerAngles = var_105_17
			end

			if arg_102_1.time_ >= var_105_11 + var_105_13 and arg_102_1.time_ < var_105_11 + var_105_13 + arg_105_0 then
				var_105_10.localPosition = Vector3.New(0, 100, 0)

				local var_105_18 = manager.ui.mainCamera.transform.position - var_105_10.position

				var_105_10.forward = Vector3.New(var_105_18.x, var_105_18.y, var_105_18.z)

				local var_105_19 = var_105_10.localEulerAngles

				var_105_19.z = 0
				var_105_19.x = 0
				var_105_10.localEulerAngles = var_105_19

				local var_105_20 = GameObjectTools.GetOrAddComponent(var_105_10.gameObject, typeof(DynamicBoneHelper))

				if var_105_20 then
					var_105_20:EnableDynamicBone(true)
				end
			end

			local var_105_21 = arg_102_1.actors_["1027ui_story"].transform
			local var_105_22 = 0

			if var_105_22 < arg_102_1.time_ and arg_102_1.time_ <= var_105_22 + arg_105_0 then
				arg_102_1.var_.moveOldPos1027ui_story = var_105_21.localPosition
			end

			local var_105_23 = 0.001

			if var_105_22 <= arg_102_1.time_ and arg_102_1.time_ < var_105_22 + var_105_23 then
				local var_105_24 = (arg_102_1.time_ - var_105_22) / var_105_23
				local var_105_25 = Vector3.New(0, -0.81, -5.8)

				var_105_21.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1027ui_story, var_105_25, var_105_24)

				local var_105_26 = manager.ui.mainCamera.transform.position - var_105_21.position

				var_105_21.forward = Vector3.New(var_105_26.x, var_105_26.y, var_105_26.z)

				local var_105_27 = var_105_21.localEulerAngles

				var_105_27.z = 0
				var_105_27.x = 0
				var_105_21.localEulerAngles = var_105_27
			end

			if arg_102_1.time_ >= var_105_22 + var_105_23 and arg_102_1.time_ < var_105_22 + var_105_23 + arg_105_0 then
				var_105_21.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_105_28 = manager.ui.mainCamera.transform.position - var_105_21.position

				var_105_21.forward = Vector3.New(var_105_28.x, var_105_28.y, var_105_28.z)

				local var_105_29 = var_105_21.localEulerAngles

				var_105_29.z = 0
				var_105_29.x = 0
				var_105_21.localEulerAngles = var_105_29
			end

			local var_105_30 = 0

			if var_105_30 < arg_102_1.time_ and arg_102_1.time_ <= var_105_30 + arg_105_0 then
				arg_102_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			local var_105_31 = 0

			if var_105_31 < arg_102_1.time_ and arg_102_1.time_ <= var_105_31 + arg_105_0 then
				arg_102_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_105_32 = 0
			local var_105_33 = 0.25

			if var_105_32 < arg_102_1.time_ and arg_102_1.time_ <= var_105_32 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_34 = arg_102_1:FormatText(StoryNameCfg[56].name)

				arg_102_1.leftNameTxt_.text = var_105_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_35 = arg_102_1:GetWordFromCfg(105082025)
				local var_105_36 = arg_102_1:FormatText(var_105_35.content)

				arg_102_1.text_.text = var_105_36

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_37 = 10
				local var_105_38 = utf8.len(var_105_36)
				local var_105_39 = var_105_37 <= 0 and var_105_33 or var_105_33 * (var_105_38 / var_105_37)

				if var_105_39 > 0 and var_105_33 < var_105_39 then
					arg_102_1.talkMaxDuration = var_105_39

					if var_105_39 + var_105_32 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_39 + var_105_32
					end
				end

				arg_102_1.text_.text = var_105_36
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082025", "story_v_out_105082.awb") ~= 0 then
					local var_105_40 = manager.audio:GetVoiceLength("story_v_out_105082", "105082025", "story_v_out_105082.awb") / 1000

					if var_105_40 + var_105_32 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_40 + var_105_32
					end

					if var_105_35.prefab_name ~= "" and arg_102_1.actors_[var_105_35.prefab_name] ~= nil then
						local var_105_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_35.prefab_name].transform, "story_v_out_105082", "105082025", "story_v_out_105082.awb")

						arg_102_1:RecordAudio("105082025", var_105_41)
						arg_102_1:RecordAudio("105082025", var_105_41)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_105082", "105082025", "story_v_out_105082.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_105082", "105082025", "story_v_out_105082.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_42 = math.max(var_105_33, arg_102_1.talkMaxDuration)

			if var_105_32 <= arg_102_1.time_ and arg_102_1.time_ < var_105_32 + var_105_42 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_32) / var_105_42

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_32 + var_105_42 and arg_102_1.time_ < var_105_32 + var_105_42 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play105082026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 105082026
		arg_106_1.duration_ = 2

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play105082027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = "1080ui_story"

			if arg_106_1.actors_[var_109_0] == nil then
				local var_109_1 = Asset.Load("Char/" .. "1080ui_story")

				if not isNil(var_109_1) then
					local var_109_2 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_106_1.stage_.transform)

					var_109_2.name = var_109_0
					var_109_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_106_1.actors_[var_109_0] = var_109_2

					local var_109_3 = var_109_2:GetComponentInChildren(typeof(CharacterEffect))

					var_109_3.enabled = true

					local var_109_4 = GameObjectTools.GetOrAddComponent(var_109_2, typeof(DynamicBoneHelper))

					if var_109_4 then
						var_109_4:EnableDynamicBone(false)
					end

					arg_106_1:ShowWeapon(var_109_3.transform, false)

					arg_106_1.var_[var_109_0 .. "Animator"] = var_109_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_106_1.var_[var_109_0 .. "Animator"].applyRootMotion = true
					arg_106_1.var_[var_109_0 .. "LipSync"] = var_109_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_109_5 = arg_106_1.actors_["1080ui_story"]
			local var_109_6 = 0

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 and not isNil(var_109_5) and arg_106_1.var_.characterEffect1080ui_story == nil then
				arg_106_1.var_.characterEffect1080ui_story = var_109_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_7 = 0.1

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_7 and not isNil(var_109_5) then
				local var_109_8 = (arg_106_1.time_ - var_109_6) / var_109_7

				if arg_106_1.var_.characterEffect1080ui_story and not isNil(var_109_5) then
					arg_106_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_6 + var_109_7 and arg_106_1.time_ < var_109_6 + var_109_7 + arg_109_0 and not isNil(var_109_5) and arg_106_1.var_.characterEffect1080ui_story then
				arg_106_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_109_9 = arg_106_1.actors_["1027ui_story"]
			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1027ui_story == nil then
				arg_106_1.var_.characterEffect1027ui_story = var_109_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_11 = 0.1

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_11 and not isNil(var_109_9) then
				local var_109_12 = (arg_106_1.time_ - var_109_10) / var_109_11

				if arg_106_1.var_.characterEffect1027ui_story and not isNil(var_109_9) then
					local var_109_13 = Mathf.Lerp(0, 0.5, var_109_12)

					arg_106_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1027ui_story.fillRatio = var_109_13
				end
			end

			if arg_106_1.time_ >= var_109_10 + var_109_11 and arg_106_1.time_ < var_109_10 + var_109_11 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1027ui_story then
				local var_109_14 = 0.5

				arg_106_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1027ui_story.fillRatio = var_109_14
			end

			local var_109_15 = arg_106_1.actors_["1027ui_story"].transform
			local var_109_16 = 0

			if var_109_16 < arg_106_1.time_ and arg_106_1.time_ <= var_109_16 + arg_109_0 then
				arg_106_1.var_.moveOldPos1027ui_story = var_109_15.localPosition
			end

			local var_109_17 = 0.001

			if var_109_16 <= arg_106_1.time_ and arg_106_1.time_ < var_109_16 + var_109_17 then
				local var_109_18 = (arg_106_1.time_ - var_109_16) / var_109_17
				local var_109_19 = Vector3.New(0.7, -0.81, -5.8)

				var_109_15.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1027ui_story, var_109_19, var_109_18)

				local var_109_20 = manager.ui.mainCamera.transform.position - var_109_15.position

				var_109_15.forward = Vector3.New(var_109_20.x, var_109_20.y, var_109_20.z)

				local var_109_21 = var_109_15.localEulerAngles

				var_109_21.z = 0
				var_109_21.x = 0
				var_109_15.localEulerAngles = var_109_21
			end

			if arg_106_1.time_ >= var_109_16 + var_109_17 and arg_106_1.time_ < var_109_16 + var_109_17 + arg_109_0 then
				var_109_15.localPosition = Vector3.New(0.7, -0.81, -5.8)

				local var_109_22 = manager.ui.mainCamera.transform.position - var_109_15.position

				var_109_15.forward = Vector3.New(var_109_22.x, var_109_22.y, var_109_22.z)

				local var_109_23 = var_109_15.localEulerAngles

				var_109_23.z = 0
				var_109_23.x = 0
				var_109_15.localEulerAngles = var_109_23
			end

			local var_109_24 = arg_106_1.actors_["1027ui_story"].transform
			local var_109_25 = 0.033

			if var_109_25 < arg_106_1.time_ and arg_106_1.time_ <= var_109_25 + arg_109_0 then
				arg_106_1.var_.moveOldPos1027ui_story = var_109_24.localPosition
			end

			local var_109_26 = 0.5

			if var_109_25 <= arg_106_1.time_ and arg_106_1.time_ < var_109_25 + var_109_26 then
				local var_109_27 = (arg_106_1.time_ - var_109_25) / var_109_26
				local var_109_28 = Vector3.New(0.7, -0.81, -5.8)

				var_109_24.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1027ui_story, var_109_28, var_109_27)

				local var_109_29 = manager.ui.mainCamera.transform.position - var_109_24.position

				var_109_24.forward = Vector3.New(var_109_29.x, var_109_29.y, var_109_29.z)

				local var_109_30 = var_109_24.localEulerAngles

				var_109_30.z = 0
				var_109_30.x = 0
				var_109_24.localEulerAngles = var_109_30
			end

			if arg_106_1.time_ >= var_109_25 + var_109_26 and arg_106_1.time_ < var_109_25 + var_109_26 + arg_109_0 then
				var_109_24.localPosition = Vector3.New(0.7, -0.81, -5.8)

				local var_109_31 = manager.ui.mainCamera.transform.position - var_109_24.position

				var_109_24.forward = Vector3.New(var_109_31.x, var_109_31.y, var_109_31.z)

				local var_109_32 = var_109_24.localEulerAngles

				var_109_32.z = 0
				var_109_32.x = 0
				var_109_24.localEulerAngles = var_109_32
			end

			local var_109_33 = arg_106_1.actors_["1080ui_story"].transform
			local var_109_34 = 0

			if var_109_34 < arg_106_1.time_ and arg_106_1.time_ <= var_109_34 + arg_109_0 then
				arg_106_1.var_.moveOldPos1080ui_story = var_109_33.localPosition
			end

			local var_109_35 = 0.001

			if var_109_34 <= arg_106_1.time_ and arg_106_1.time_ < var_109_34 + var_109_35 then
				local var_109_36 = (arg_106_1.time_ - var_109_34) / var_109_35
				local var_109_37 = Vector3.New(-0.7, -1.01, -6.05)

				var_109_33.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1080ui_story, var_109_37, var_109_36)

				local var_109_38 = manager.ui.mainCamera.transform.position - var_109_33.position

				var_109_33.forward = Vector3.New(var_109_38.x, var_109_38.y, var_109_38.z)

				local var_109_39 = var_109_33.localEulerAngles

				var_109_39.z = 0
				var_109_39.x = 0
				var_109_33.localEulerAngles = var_109_39
			end

			if arg_106_1.time_ >= var_109_34 + var_109_35 and arg_106_1.time_ < var_109_34 + var_109_35 + arg_109_0 then
				var_109_33.localPosition = Vector3.New(-0.7, -1.01, -6.05)

				local var_109_40 = manager.ui.mainCamera.transform.position - var_109_33.position

				var_109_33.forward = Vector3.New(var_109_40.x, var_109_40.y, var_109_40.z)

				local var_109_41 = var_109_33.localEulerAngles

				var_109_41.z = 0
				var_109_41.x = 0
				var_109_33.localEulerAngles = var_109_41
			end

			local var_109_42 = 0

			if var_109_42 < arg_106_1.time_ and arg_106_1.time_ <= var_109_42 + arg_109_0 then
				arg_106_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			local var_109_43 = 0

			if var_109_43 < arg_106_1.time_ and arg_106_1.time_ <= var_109_43 + arg_109_0 then
				arg_106_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_109_44 = 0
			local var_109_45 = 0.075

			if var_109_44 < arg_106_1.time_ and arg_106_1.time_ <= var_109_44 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_46 = arg_106_1:FormatText(StoryNameCfg[55].name)

				arg_106_1.leftNameTxt_.text = var_109_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_47 = arg_106_1:GetWordFromCfg(105082026)
				local var_109_48 = arg_106_1:FormatText(var_109_47.content)

				arg_106_1.text_.text = var_109_48

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_49 = 3
				local var_109_50 = utf8.len(var_109_48)
				local var_109_51 = var_109_49 <= 0 and var_109_45 or var_109_45 * (var_109_50 / var_109_49)

				if var_109_51 > 0 and var_109_45 < var_109_51 then
					arg_106_1.talkMaxDuration = var_109_51

					if var_109_51 + var_109_44 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_51 + var_109_44
					end
				end

				arg_106_1.text_.text = var_109_48
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082026", "story_v_out_105082.awb") ~= 0 then
					local var_109_52 = manager.audio:GetVoiceLength("story_v_out_105082", "105082026", "story_v_out_105082.awb") / 1000

					if var_109_52 + var_109_44 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_52 + var_109_44
					end

					if var_109_47.prefab_name ~= "" and arg_106_1.actors_[var_109_47.prefab_name] ~= nil then
						local var_109_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_47.prefab_name].transform, "story_v_out_105082", "105082026", "story_v_out_105082.awb")

						arg_106_1:RecordAudio("105082026", var_109_53)
						arg_106_1:RecordAudio("105082026", var_109_53)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_105082", "105082026", "story_v_out_105082.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_105082", "105082026", "story_v_out_105082.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_54 = math.max(var_109_45, arg_106_1.talkMaxDuration)

			if var_109_44 <= arg_106_1.time_ and arg_106_1.time_ < var_109_44 + var_109_54 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_44) / var_109_54

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_44 + var_109_54 and arg_106_1.time_ < var_109_44 + var_109_54 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play105082027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 105082027
		arg_110_1.duration_ = 3.67

		local var_110_0 = {
			ja = 3.666,
			ko = 2.033,
			zh = 1.8,
			en = 2.5
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play105082028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1080ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1080ui_story == nil then
				arg_110_1.var_.characterEffect1080ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.1

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1080ui_story and not isNil(var_113_0) then
					local var_113_4 = Mathf.Lerp(0, 0.5, var_113_3)

					arg_110_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1080ui_story.fillRatio = var_113_4
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1080ui_story then
				local var_113_5 = 0.5

				arg_110_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1080ui_story.fillRatio = var_113_5
			end

			local var_113_6 = arg_110_1.actors_["1027ui_story"].transform
			local var_113_7 = 0

			if var_113_7 < arg_110_1.time_ and arg_110_1.time_ <= var_113_7 + arg_113_0 then
				arg_110_1.var_.moveOldPos1027ui_story = var_113_6.localPosition
			end

			local var_113_8 = 0.001

			if var_113_7 <= arg_110_1.time_ and arg_110_1.time_ < var_113_7 + var_113_8 then
				local var_113_9 = (arg_110_1.time_ - var_113_7) / var_113_8
				local var_113_10 = Vector3.New(0, 100, 0)

				var_113_6.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1027ui_story, var_113_10, var_113_9)

				local var_113_11 = manager.ui.mainCamera.transform.position - var_113_6.position

				var_113_6.forward = Vector3.New(var_113_11.x, var_113_11.y, var_113_11.z)

				local var_113_12 = var_113_6.localEulerAngles

				var_113_12.z = 0
				var_113_12.x = 0
				var_113_6.localEulerAngles = var_113_12
			end

			if arg_110_1.time_ >= var_113_7 + var_113_8 and arg_110_1.time_ < var_113_7 + var_113_8 + arg_113_0 then
				var_113_6.localPosition = Vector3.New(0, 100, 0)

				local var_113_13 = manager.ui.mainCamera.transform.position - var_113_6.position

				var_113_6.forward = Vector3.New(var_113_13.x, var_113_13.y, var_113_13.z)

				local var_113_14 = var_113_6.localEulerAngles

				var_113_14.z = 0
				var_113_14.x = 0
				var_113_6.localEulerAngles = var_113_14
			end

			local var_113_15 = arg_110_1.actors_["1080ui_story"].transform
			local var_113_16 = 0

			if var_113_16 < arg_110_1.time_ and arg_110_1.time_ <= var_113_16 + arg_113_0 then
				arg_110_1.var_.moveOldPos1080ui_story = var_113_15.localPosition
			end

			local var_113_17 = 0.001

			if var_113_16 <= arg_110_1.time_ and arg_110_1.time_ < var_113_16 + var_113_17 then
				local var_113_18 = (arg_110_1.time_ - var_113_16) / var_113_17
				local var_113_19 = Vector3.New(0, 100, 0)

				var_113_15.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1080ui_story, var_113_19, var_113_18)

				local var_113_20 = manager.ui.mainCamera.transform.position - var_113_15.position

				var_113_15.forward = Vector3.New(var_113_20.x, var_113_20.y, var_113_20.z)

				local var_113_21 = var_113_15.localEulerAngles

				var_113_21.z = 0
				var_113_21.x = 0
				var_113_15.localEulerAngles = var_113_21
			end

			if arg_110_1.time_ >= var_113_16 + var_113_17 and arg_110_1.time_ < var_113_16 + var_113_17 + arg_113_0 then
				var_113_15.localPosition = Vector3.New(0, 100, 0)

				local var_113_22 = manager.ui.mainCamera.transform.position - var_113_15.position

				var_113_15.forward = Vector3.New(var_113_22.x, var_113_22.y, var_113_22.z)

				local var_113_23 = var_113_15.localEulerAngles

				var_113_23.z = 0
				var_113_23.x = 0
				var_113_15.localEulerAngles = var_113_23
			end

			local var_113_24 = 0
			local var_113_25 = 0.2

			if var_113_24 < arg_110_1.time_ and arg_110_1.time_ <= var_113_24 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_26 = arg_110_1:FormatText(StoryNameCfg[10].name)

				arg_110_1.leftNameTxt_.text = var_113_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_27 = arg_110_1:GetWordFromCfg(105082027)
				local var_113_28 = arg_110_1:FormatText(var_113_27.content)

				arg_110_1.text_.text = var_113_28

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_29 = 8
				local var_113_30 = utf8.len(var_113_28)
				local var_113_31 = var_113_29 <= 0 and var_113_25 or var_113_25 * (var_113_30 / var_113_29)

				if var_113_31 > 0 and var_113_25 < var_113_31 then
					arg_110_1.talkMaxDuration = var_113_31

					if var_113_31 + var_113_24 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_31 + var_113_24
					end
				end

				arg_110_1.text_.text = var_113_28
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082027", "story_v_out_105082.awb") ~= 0 then
					local var_113_32 = manager.audio:GetVoiceLength("story_v_out_105082", "105082027", "story_v_out_105082.awb") / 1000

					if var_113_32 + var_113_24 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_32 + var_113_24
					end

					if var_113_27.prefab_name ~= "" and arg_110_1.actors_[var_113_27.prefab_name] ~= nil then
						local var_113_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_27.prefab_name].transform, "story_v_out_105082", "105082027", "story_v_out_105082.awb")

						arg_110_1:RecordAudio("105082027", var_113_33)
						arg_110_1:RecordAudio("105082027", var_113_33)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_105082", "105082027", "story_v_out_105082.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_105082", "105082027", "story_v_out_105082.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_34 = math.max(var_113_25, arg_110_1.talkMaxDuration)

			if var_113_24 <= arg_110_1.time_ and arg_110_1.time_ < var_113_24 + var_113_34 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_24) / var_113_34

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_24 + var_113_34 and arg_110_1.time_ < var_113_24 + var_113_34 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play105082028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 105082028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play105082029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.675

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[7].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_3 = arg_114_1:GetWordFromCfg(105082028)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 26
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
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_8 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_8 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_8

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_8 and arg_114_1.time_ < var_117_0 + var_117_8 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play105082029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 105082029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play105082030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.6

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_2 = arg_118_1:GetWordFromCfg(105082029)
				local var_121_3 = arg_118_1:FormatText(var_121_2.content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 24
				local var_121_5 = utf8.len(var_121_3)
				local var_121_6 = var_121_4 <= 0 and var_121_1 or var_121_1 * (var_121_5 / var_121_4)

				if var_121_6 > 0 and var_121_1 < var_121_6 then
					arg_118_1.talkMaxDuration = var_121_6

					if var_121_6 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_6 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_3
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_7 and arg_118_1.time_ < var_121_0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play105082030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 105082030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play105082031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 1

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				local var_125_2 = "play"
				local var_125_3 = "effect"

				arg_122_1:AudioAction(var_125_2, var_125_3, "se_story_5", "se_story_5_robotstop", "")
			end

			local var_125_4 = 0
			local var_125_5 = 1.2

			if var_125_4 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:GetWordFromCfg(105082030)
				local var_125_7 = arg_122_1:FormatText(var_125_6.content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_8 = 48
				local var_125_9 = utf8.len(var_125_7)
				local var_125_10 = var_125_8 <= 0 and var_125_5 or var_125_5 * (var_125_9 / var_125_8)

				if var_125_10 > 0 and var_125_5 < var_125_10 then
					arg_122_1.talkMaxDuration = var_125_10

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_11 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_11 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_4) / var_125_11

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_4 + var_125_11 and arg_122_1.time_ < var_125_4 + var_125_11 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play105082031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 105082031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play105082032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 1

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				local var_129_2 = "play"
				local var_129_3 = "effect"

				arg_126_1:AudioAction(var_129_2, var_129_3, "se_story_5", "se_story_5_robotcollapse", "")
			end

			local var_129_4 = 0
			local var_129_5 = 1.4

			if var_129_4 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_6 = arg_126_1:GetWordFromCfg(105082031)
				local var_129_7 = arg_126_1:FormatText(var_129_6.content)

				arg_126_1.text_.text = var_129_7

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_8 = 56
				local var_129_9 = utf8.len(var_129_7)
				local var_129_10 = var_129_8 <= 0 and var_129_5 or var_129_5 * (var_129_9 / var_129_8)

				if var_129_10 > 0 and var_129_5 < var_129_10 then
					arg_126_1.talkMaxDuration = var_129_10

					if var_129_10 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_10 + var_129_4
					end
				end

				arg_126_1.text_.text = var_129_7
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_11 = math.max(var_129_5, arg_126_1.talkMaxDuration)

			if var_129_4 <= arg_126_1.time_ and arg_126_1.time_ < var_129_4 + var_129_11 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_4) / var_129_11

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_4 + var_129_11 and arg_126_1.time_ < var_129_4 + var_129_11 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play105082032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 105082032
		arg_130_1.duration_ = 5.67

		local var_130_0 = {
			ja = 5.666,
			ko = 4.033,
			zh = 4.7,
			en = 3.3
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
				arg_130_0:Play105082033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.375

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_2 = arg_130_1:FormatText(StoryNameCfg[10].name)

				arg_130_1.leftNameTxt_.text = var_133_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_3 = arg_130_1:GetWordFromCfg(105082032)
				local var_133_4 = arg_130_1:FormatText(var_133_3.content)

				arg_130_1.text_.text = var_133_4

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 14
				local var_133_6 = utf8.len(var_133_4)
				local var_133_7 = var_133_5 <= 0 and var_133_1 or var_133_1 * (var_133_6 / var_133_5)

				if var_133_7 > 0 and var_133_1 < var_133_7 then
					arg_130_1.talkMaxDuration = var_133_7

					if var_133_7 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_7 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_4
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082032", "story_v_out_105082.awb") ~= 0 then
					local var_133_8 = manager.audio:GetVoiceLength("story_v_out_105082", "105082032", "story_v_out_105082.awb") / 1000

					if var_133_8 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_8 + var_133_0
					end

					if var_133_3.prefab_name ~= "" and arg_130_1.actors_[var_133_3.prefab_name] ~= nil then
						local var_133_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_3.prefab_name].transform, "story_v_out_105082", "105082032", "story_v_out_105082.awb")

						arg_130_1:RecordAudio("105082032", var_133_9)
						arg_130_1:RecordAudio("105082032", var_133_9)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_105082", "105082032", "story_v_out_105082.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_105082", "105082032", "story_v_out_105082.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_10 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_10 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_10

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_10 and arg_130_1.time_ < var_133_0 + var_133_10 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play105082033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 105082033
		arg_134_1.duration_ = 2.83

		local var_134_0 = {
			ja = 2.833,
			ko = 1.999999999999,
			zh = 2.533,
			en = 2.533
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
				arg_134_0:Play105082034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1027ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1027ui_story == nil then
				arg_134_1.var_.characterEffect1027ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.1

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1027ui_story and not isNil(var_137_0) then
					arg_134_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1027ui_story then
				arg_134_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_137_4 = arg_134_1.actors_["1027ui_story"].transform
			local var_137_5 = 0

			if var_137_5 < arg_134_1.time_ and arg_134_1.time_ <= var_137_5 + arg_137_0 then
				arg_134_1.var_.moveOldPos1027ui_story = var_137_4.localPosition
			end

			local var_137_6 = 0.001

			if var_137_5 <= arg_134_1.time_ and arg_134_1.time_ < var_137_5 + var_137_6 then
				local var_137_7 = (arg_134_1.time_ - var_137_5) / var_137_6
				local var_137_8 = Vector3.New(-0.7, -0.81, -5.8)

				var_137_4.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1027ui_story, var_137_8, var_137_7)

				local var_137_9 = manager.ui.mainCamera.transform.position - var_137_4.position

				var_137_4.forward = Vector3.New(var_137_9.x, var_137_9.y, var_137_9.z)

				local var_137_10 = var_137_4.localEulerAngles

				var_137_10.z = 0
				var_137_10.x = 0
				var_137_4.localEulerAngles = var_137_10
			end

			if arg_134_1.time_ >= var_137_5 + var_137_6 and arg_134_1.time_ < var_137_5 + var_137_6 + arg_137_0 then
				var_137_4.localPosition = Vector3.New(-0.7, -0.81, -5.8)

				local var_137_11 = manager.ui.mainCamera.transform.position - var_137_4.position

				var_137_4.forward = Vector3.New(var_137_11.x, var_137_11.y, var_137_11.z)

				local var_137_12 = var_137_4.localEulerAngles

				var_137_12.z = 0
				var_137_12.x = 0
				var_137_4.localEulerAngles = var_137_12
			end

			local var_137_13 = 0

			if var_137_13 < arg_134_1.time_ and arg_134_1.time_ <= var_137_13 + arg_137_0 then
				arg_134_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			local var_137_14 = 0

			if var_137_14 < arg_134_1.time_ and arg_134_1.time_ <= var_137_14 + arg_137_0 then
				arg_134_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_137_15 = 0
			local var_137_16 = 0.25

			if var_137_15 < arg_134_1.time_ and arg_134_1.time_ <= var_137_15 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_17 = arg_134_1:FormatText(StoryNameCfg[56].name)

				arg_134_1.leftNameTxt_.text = var_137_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_18 = arg_134_1:GetWordFromCfg(105082033)
				local var_137_19 = arg_134_1:FormatText(var_137_18.content)

				arg_134_1.text_.text = var_137_19

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_20 = 10
				local var_137_21 = utf8.len(var_137_19)
				local var_137_22 = var_137_20 <= 0 and var_137_16 or var_137_16 * (var_137_21 / var_137_20)

				if var_137_22 > 0 and var_137_16 < var_137_22 then
					arg_134_1.talkMaxDuration = var_137_22

					if var_137_22 + var_137_15 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_22 + var_137_15
					end
				end

				arg_134_1.text_.text = var_137_19
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082033", "story_v_out_105082.awb") ~= 0 then
					local var_137_23 = manager.audio:GetVoiceLength("story_v_out_105082", "105082033", "story_v_out_105082.awb") / 1000

					if var_137_23 + var_137_15 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_23 + var_137_15
					end

					if var_137_18.prefab_name ~= "" and arg_134_1.actors_[var_137_18.prefab_name] ~= nil then
						local var_137_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_18.prefab_name].transform, "story_v_out_105082", "105082033", "story_v_out_105082.awb")

						arg_134_1:RecordAudio("105082033", var_137_24)
						arg_134_1:RecordAudio("105082033", var_137_24)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_105082", "105082033", "story_v_out_105082.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_105082", "105082033", "story_v_out_105082.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_25 = math.max(var_137_16, arg_134_1.talkMaxDuration)

			if var_137_15 <= arg_134_1.time_ and arg_134_1.time_ < var_137_15 + var_137_25 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_15) / var_137_25

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_15 + var_137_25 and arg_134_1.time_ < var_137_15 + var_137_25 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play105082034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 105082034
		arg_138_1.duration_ = 3.8

		local var_138_0 = {
			ja = 3.8,
			ko = 2.4,
			zh = 2.066,
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
				arg_138_0:Play105082035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1059ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1059ui_story == nil then
				arg_138_1.var_.characterEffect1059ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.1

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1059ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1059ui_story then
				arg_138_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_141_4 = arg_138_1.actors_["1027ui_story"]
			local var_141_5 = 0

			if var_141_5 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect1027ui_story == nil then
				arg_138_1.var_.characterEffect1027ui_story = var_141_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_6 = 0.1

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_6 and not isNil(var_141_4) then
				local var_141_7 = (arg_138_1.time_ - var_141_5) / var_141_6

				if arg_138_1.var_.characterEffect1027ui_story and not isNil(var_141_4) then
					local var_141_8 = Mathf.Lerp(0, 0.5, var_141_7)

					arg_138_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1027ui_story.fillRatio = var_141_8
				end
			end

			if arg_138_1.time_ >= var_141_5 + var_141_6 and arg_138_1.time_ < var_141_5 + var_141_6 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect1027ui_story then
				local var_141_9 = 0.5

				arg_138_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1027ui_story.fillRatio = var_141_9
			end

			local var_141_10 = arg_138_1.actors_["1059ui_story"].transform
			local var_141_11 = 0

			if var_141_11 < arg_138_1.time_ and arg_138_1.time_ <= var_141_11 + arg_141_0 then
				arg_138_1.var_.moveOldPos1059ui_story = var_141_10.localPosition
			end

			local var_141_12 = 0.001

			if var_141_11 <= arg_138_1.time_ and arg_138_1.time_ < var_141_11 + var_141_12 then
				local var_141_13 = (arg_138_1.time_ - var_141_11) / var_141_12
				local var_141_14 = Vector3.New(0.7, -1.05, -6)

				var_141_10.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1059ui_story, var_141_14, var_141_13)

				local var_141_15 = manager.ui.mainCamera.transform.position - var_141_10.position

				var_141_10.forward = Vector3.New(var_141_15.x, var_141_15.y, var_141_15.z)

				local var_141_16 = var_141_10.localEulerAngles

				var_141_16.z = 0
				var_141_16.x = 0
				var_141_10.localEulerAngles = var_141_16
			end

			if arg_138_1.time_ >= var_141_11 + var_141_12 and arg_138_1.time_ < var_141_11 + var_141_12 + arg_141_0 then
				var_141_10.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_141_17 = manager.ui.mainCamera.transform.position - var_141_10.position

				var_141_10.forward = Vector3.New(var_141_17.x, var_141_17.y, var_141_17.z)

				local var_141_18 = var_141_10.localEulerAngles

				var_141_18.z = 0
				var_141_18.x = 0
				var_141_10.localEulerAngles = var_141_18
			end

			local var_141_19 = 0

			if var_141_19 < arg_138_1.time_ and arg_138_1.time_ <= var_141_19 + arg_141_0 then
				arg_138_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			local var_141_20 = 0

			if var_141_20 < arg_138_1.time_ and arg_138_1.time_ <= var_141_20 + arg_141_0 then
				arg_138_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_141_21 = 0
			local var_141_22 = 0.2

			if var_141_21 < arg_138_1.time_ and arg_138_1.time_ <= var_141_21 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_23 = arg_138_1:FormatText(StoryNameCfg[28].name)

				arg_138_1.leftNameTxt_.text = var_141_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_24 = arg_138_1:GetWordFromCfg(105082034)
				local var_141_25 = arg_138_1:FormatText(var_141_24.content)

				arg_138_1.text_.text = var_141_25

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_26 = 8
				local var_141_27 = utf8.len(var_141_25)
				local var_141_28 = var_141_26 <= 0 and var_141_22 or var_141_22 * (var_141_27 / var_141_26)

				if var_141_28 > 0 and var_141_22 < var_141_28 then
					arg_138_1.talkMaxDuration = var_141_28

					if var_141_28 + var_141_21 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_28 + var_141_21
					end
				end

				arg_138_1.text_.text = var_141_25
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082034", "story_v_out_105082.awb") ~= 0 then
					local var_141_29 = manager.audio:GetVoiceLength("story_v_out_105082", "105082034", "story_v_out_105082.awb") / 1000

					if var_141_29 + var_141_21 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_29 + var_141_21
					end

					if var_141_24.prefab_name ~= "" and arg_138_1.actors_[var_141_24.prefab_name] ~= nil then
						local var_141_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_24.prefab_name].transform, "story_v_out_105082", "105082034", "story_v_out_105082.awb")

						arg_138_1:RecordAudio("105082034", var_141_30)
						arg_138_1:RecordAudio("105082034", var_141_30)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_105082", "105082034", "story_v_out_105082.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_105082", "105082034", "story_v_out_105082.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_31 = math.max(var_141_22, arg_138_1.talkMaxDuration)

			if var_141_21 <= arg_138_1.time_ and arg_138_1.time_ < var_141_21 + var_141_31 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_21) / var_141_31

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_21 + var_141_31 and arg_138_1.time_ < var_141_21 + var_141_31 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
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

		arg_138_1:InitPlayNodeList()
	end,
	Play105082035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 105082035
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play105082036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1059ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1059ui_story == nil then
				arg_142_1.var_.characterEffect1059ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.1

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1059ui_story and not isNil(var_145_0) then
					local var_145_4 = Mathf.Lerp(0, 0.5, var_145_3)

					arg_142_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1059ui_story.fillRatio = var_145_4
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1059ui_story then
				local var_145_5 = 0.5

				arg_142_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1059ui_story.fillRatio = var_145_5
			end

			local var_145_6 = arg_142_1.actors_["1059ui_story"].transform
			local var_145_7 = 0

			if var_145_7 < arg_142_1.time_ and arg_142_1.time_ <= var_145_7 + arg_145_0 then
				arg_142_1.var_.moveOldPos1059ui_story = var_145_6.localPosition
			end

			local var_145_8 = 0.001

			if var_145_7 <= arg_142_1.time_ and arg_142_1.time_ < var_145_7 + var_145_8 then
				local var_145_9 = (arg_142_1.time_ - var_145_7) / var_145_8
				local var_145_10 = Vector3.New(0, 100, 0)

				var_145_6.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1059ui_story, var_145_10, var_145_9)

				local var_145_11 = manager.ui.mainCamera.transform.position - var_145_6.position

				var_145_6.forward = Vector3.New(var_145_11.x, var_145_11.y, var_145_11.z)

				local var_145_12 = var_145_6.localEulerAngles

				var_145_12.z = 0
				var_145_12.x = 0
				var_145_6.localEulerAngles = var_145_12
			end

			if arg_142_1.time_ >= var_145_7 + var_145_8 and arg_142_1.time_ < var_145_7 + var_145_8 + arg_145_0 then
				var_145_6.localPosition = Vector3.New(0, 100, 0)

				local var_145_13 = manager.ui.mainCamera.transform.position - var_145_6.position

				var_145_6.forward = Vector3.New(var_145_13.x, var_145_13.y, var_145_13.z)

				local var_145_14 = var_145_6.localEulerAngles

				var_145_14.z = 0
				var_145_14.x = 0
				var_145_6.localEulerAngles = var_145_14
			end

			local var_145_15 = arg_142_1.actors_["1027ui_story"].transform
			local var_145_16 = 0

			if var_145_16 < arg_142_1.time_ and arg_142_1.time_ <= var_145_16 + arg_145_0 then
				arg_142_1.var_.moveOldPos1027ui_story = var_145_15.localPosition
			end

			local var_145_17 = 0.001

			if var_145_16 <= arg_142_1.time_ and arg_142_1.time_ < var_145_16 + var_145_17 then
				local var_145_18 = (arg_142_1.time_ - var_145_16) / var_145_17
				local var_145_19 = Vector3.New(0, 100, 0)

				var_145_15.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1027ui_story, var_145_19, var_145_18)

				local var_145_20 = manager.ui.mainCamera.transform.position - var_145_15.position

				var_145_15.forward = Vector3.New(var_145_20.x, var_145_20.y, var_145_20.z)

				local var_145_21 = var_145_15.localEulerAngles

				var_145_21.z = 0
				var_145_21.x = 0
				var_145_15.localEulerAngles = var_145_21
			end

			if arg_142_1.time_ >= var_145_16 + var_145_17 and arg_142_1.time_ < var_145_16 + var_145_17 + arg_145_0 then
				var_145_15.localPosition = Vector3.New(0, 100, 0)

				local var_145_22 = manager.ui.mainCamera.transform.position - var_145_15.position

				var_145_15.forward = Vector3.New(var_145_22.x, var_145_22.y, var_145_22.z)

				local var_145_23 = var_145_15.localEulerAngles

				var_145_23.z = 0
				var_145_23.x = 0
				var_145_15.localEulerAngles = var_145_23
			end

			local var_145_24 = 0
			local var_145_25 = 0.575

			if var_145_24 < arg_142_1.time_ and arg_142_1.time_ <= var_145_24 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_26 = arg_142_1:GetWordFromCfg(105082035)
				local var_145_27 = arg_142_1:FormatText(var_145_26.content)

				arg_142_1.text_.text = var_145_27

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_28 = 23
				local var_145_29 = utf8.len(var_145_27)
				local var_145_30 = var_145_28 <= 0 and var_145_25 or var_145_25 * (var_145_29 / var_145_28)

				if var_145_30 > 0 and var_145_25 < var_145_30 then
					arg_142_1.talkMaxDuration = var_145_30

					if var_145_30 + var_145_24 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_30 + var_145_24
					end
				end

				arg_142_1.text_.text = var_145_27
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_31 = math.max(var_145_25, arg_142_1.talkMaxDuration)

			if var_145_24 <= arg_142_1.time_ and arg_142_1.time_ < var_145_24 + var_145_31 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_24) / var_145_31

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_24 + var_145_31 and arg_142_1.time_ < var_145_24 + var_145_31 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play105082036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 105082036
		arg_146_1.duration_ = 10.43

		local var_146_0 = {
			ja = 10.433,
			ko = 6.8,
			zh = 5.666,
			en = 7.3
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
				arg_146_0:Play105082037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1059ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1059ui_story == nil then
				arg_146_1.var_.characterEffect1059ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.1

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1059ui_story and not isNil(var_149_0) then
					arg_146_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1059ui_story then
				arg_146_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_149_4 = arg_146_1.actors_["1059ui_story"].transform
			local var_149_5 = 0

			if var_149_5 < arg_146_1.time_ and arg_146_1.time_ <= var_149_5 + arg_149_0 then
				arg_146_1.var_.moveOldPos1059ui_story = var_149_4.localPosition
			end

			local var_149_6 = 0.001

			if var_149_5 <= arg_146_1.time_ and arg_146_1.time_ < var_149_5 + var_149_6 then
				local var_149_7 = (arg_146_1.time_ - var_149_5) / var_149_6
				local var_149_8 = Vector3.New(0, -1.05, -6)

				var_149_4.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1059ui_story, var_149_8, var_149_7)

				local var_149_9 = manager.ui.mainCamera.transform.position - var_149_4.position

				var_149_4.forward = Vector3.New(var_149_9.x, var_149_9.y, var_149_9.z)

				local var_149_10 = var_149_4.localEulerAngles

				var_149_10.z = 0
				var_149_10.x = 0
				var_149_4.localEulerAngles = var_149_10
			end

			if arg_146_1.time_ >= var_149_5 + var_149_6 and arg_146_1.time_ < var_149_5 + var_149_6 + arg_149_0 then
				var_149_4.localPosition = Vector3.New(0, -1.05, -6)

				local var_149_11 = manager.ui.mainCamera.transform.position - var_149_4.position

				var_149_4.forward = Vector3.New(var_149_11.x, var_149_11.y, var_149_11.z)

				local var_149_12 = var_149_4.localEulerAngles

				var_149_12.z = 0
				var_149_12.x = 0
				var_149_4.localEulerAngles = var_149_12
			end

			local var_149_13 = 0

			if var_149_13 < arg_146_1.time_ and arg_146_1.time_ <= var_149_13 + arg_149_0 then
				arg_146_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			local var_149_14 = 0

			if var_149_14 < arg_146_1.time_ and arg_146_1.time_ <= var_149_14 + arg_149_0 then
				arg_146_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_149_15 = 0
			local var_149_16 = 0.675

			if var_149_15 < arg_146_1.time_ and arg_146_1.time_ <= var_149_15 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_17 = arg_146_1:FormatText(StoryNameCfg[28].name)

				arg_146_1.leftNameTxt_.text = var_149_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_18 = arg_146_1:GetWordFromCfg(105082036)
				local var_149_19 = arg_146_1:FormatText(var_149_18.content)

				arg_146_1.text_.text = var_149_19

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_20 = 27
				local var_149_21 = utf8.len(var_149_19)
				local var_149_22 = var_149_20 <= 0 and var_149_16 or var_149_16 * (var_149_21 / var_149_20)

				if var_149_22 > 0 and var_149_16 < var_149_22 then
					arg_146_1.talkMaxDuration = var_149_22

					if var_149_22 + var_149_15 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_22 + var_149_15
					end
				end

				arg_146_1.text_.text = var_149_19
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082036", "story_v_out_105082.awb") ~= 0 then
					local var_149_23 = manager.audio:GetVoiceLength("story_v_out_105082", "105082036", "story_v_out_105082.awb") / 1000

					if var_149_23 + var_149_15 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_23 + var_149_15
					end

					if var_149_18.prefab_name ~= "" and arg_146_1.actors_[var_149_18.prefab_name] ~= nil then
						local var_149_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_18.prefab_name].transform, "story_v_out_105082", "105082036", "story_v_out_105082.awb")

						arg_146_1:RecordAudio("105082036", var_149_24)
						arg_146_1:RecordAudio("105082036", var_149_24)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_105082", "105082036", "story_v_out_105082.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_105082", "105082036", "story_v_out_105082.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_25 = math.max(var_149_16, arg_146_1.talkMaxDuration)

			if var_149_15 <= arg_146_1.time_ and arg_146_1.time_ < var_149_15 + var_149_25 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_15) / var_149_25

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_15 + var_149_25 and arg_146_1.time_ < var_149_15 + var_149_25 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
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

		arg_146_1:InitPlayNodeList()
	end,
	Play105082037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 105082037
		arg_150_1.duration_ = 2.5

		local var_150_0 = {
			ja = 2.5,
			ko = 1.999999999999,
			zh = 2.233,
			en = 1.999999999999
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
				arg_150_0:Play105082038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1027ui_story"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1027ui_story == nil then
				arg_150_1.var_.characterEffect1027ui_story = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.1

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect1027ui_story and not isNil(var_153_0) then
					arg_150_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1027ui_story then
				arg_150_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_153_4 = arg_150_1.actors_["1059ui_story"]
			local var_153_5 = 0

			if var_153_5 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect1059ui_story == nil then
				arg_150_1.var_.characterEffect1059ui_story = var_153_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_6 = 0.1

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_6 and not isNil(var_153_4) then
				local var_153_7 = (arg_150_1.time_ - var_153_5) / var_153_6

				if arg_150_1.var_.characterEffect1059ui_story and not isNil(var_153_4) then
					local var_153_8 = Mathf.Lerp(0, 0.5, var_153_7)

					arg_150_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1059ui_story.fillRatio = var_153_8
				end
			end

			if arg_150_1.time_ >= var_153_5 + var_153_6 and arg_150_1.time_ < var_153_5 + var_153_6 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect1059ui_story then
				local var_153_9 = 0.5

				arg_150_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1059ui_story.fillRatio = var_153_9
			end

			local var_153_10 = arg_150_1.actors_["1059ui_story"].transform
			local var_153_11 = 0

			if var_153_11 < arg_150_1.time_ and arg_150_1.time_ <= var_153_11 + arg_153_0 then
				arg_150_1.var_.moveOldPos1059ui_story = var_153_10.localPosition
			end

			local var_153_12 = 0.001

			if var_153_11 <= arg_150_1.time_ and arg_150_1.time_ < var_153_11 + var_153_12 then
				local var_153_13 = (arg_150_1.time_ - var_153_11) / var_153_12
				local var_153_14 = Vector3.New(0, 100, 0)

				var_153_10.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1059ui_story, var_153_14, var_153_13)

				local var_153_15 = manager.ui.mainCamera.transform.position - var_153_10.position

				var_153_10.forward = Vector3.New(var_153_15.x, var_153_15.y, var_153_15.z)

				local var_153_16 = var_153_10.localEulerAngles

				var_153_16.z = 0
				var_153_16.x = 0
				var_153_10.localEulerAngles = var_153_16
			end

			if arg_150_1.time_ >= var_153_11 + var_153_12 and arg_150_1.time_ < var_153_11 + var_153_12 + arg_153_0 then
				var_153_10.localPosition = Vector3.New(0, 100, 0)

				local var_153_17 = manager.ui.mainCamera.transform.position - var_153_10.position

				var_153_10.forward = Vector3.New(var_153_17.x, var_153_17.y, var_153_17.z)

				local var_153_18 = var_153_10.localEulerAngles

				var_153_18.z = 0
				var_153_18.x = 0
				var_153_10.localEulerAngles = var_153_18
			end

			local var_153_19 = arg_150_1.actors_["1027ui_story"].transform
			local var_153_20 = 0

			if var_153_20 < arg_150_1.time_ and arg_150_1.time_ <= var_153_20 + arg_153_0 then
				arg_150_1.var_.moveOldPos1027ui_story = var_153_19.localPosition
			end

			local var_153_21 = 0.001

			if var_153_20 <= arg_150_1.time_ and arg_150_1.time_ < var_153_20 + var_153_21 then
				local var_153_22 = (arg_150_1.time_ - var_153_20) / var_153_21
				local var_153_23 = Vector3.New(-0.7, -0.81, -5.8)

				var_153_19.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1027ui_story, var_153_23, var_153_22)

				local var_153_24 = manager.ui.mainCamera.transform.position - var_153_19.position

				var_153_19.forward = Vector3.New(var_153_24.x, var_153_24.y, var_153_24.z)

				local var_153_25 = var_153_19.localEulerAngles

				var_153_25.z = 0
				var_153_25.x = 0
				var_153_19.localEulerAngles = var_153_25
			end

			if arg_150_1.time_ >= var_153_20 + var_153_21 and arg_150_1.time_ < var_153_20 + var_153_21 + arg_153_0 then
				var_153_19.localPosition = Vector3.New(-0.7, -0.81, -5.8)

				local var_153_26 = manager.ui.mainCamera.transform.position - var_153_19.position

				var_153_19.forward = Vector3.New(var_153_26.x, var_153_26.y, var_153_26.z)

				local var_153_27 = var_153_19.localEulerAngles

				var_153_27.z = 0
				var_153_27.x = 0
				var_153_19.localEulerAngles = var_153_27
			end

			local var_153_28 = 0

			if var_153_28 < arg_150_1.time_ and arg_150_1.time_ <= var_153_28 + arg_153_0 then
				arg_150_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			local var_153_29 = 0

			if var_153_29 < arg_150_1.time_ and arg_150_1.time_ <= var_153_29 + arg_153_0 then
				arg_150_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_153_30 = 0
			local var_153_31 = 0.175

			if var_153_30 < arg_150_1.time_ and arg_150_1.time_ <= var_153_30 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_32 = arg_150_1:FormatText(StoryNameCfg[56].name)

				arg_150_1.leftNameTxt_.text = var_153_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_33 = arg_150_1:GetWordFromCfg(105082037)
				local var_153_34 = arg_150_1:FormatText(var_153_33.content)

				arg_150_1.text_.text = var_153_34

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_35 = 7
				local var_153_36 = utf8.len(var_153_34)
				local var_153_37 = var_153_35 <= 0 and var_153_31 or var_153_31 * (var_153_36 / var_153_35)

				if var_153_37 > 0 and var_153_31 < var_153_37 then
					arg_150_1.talkMaxDuration = var_153_37

					if var_153_37 + var_153_30 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_37 + var_153_30
					end
				end

				arg_150_1.text_.text = var_153_34
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082037", "story_v_out_105082.awb") ~= 0 then
					local var_153_38 = manager.audio:GetVoiceLength("story_v_out_105082", "105082037", "story_v_out_105082.awb") / 1000

					if var_153_38 + var_153_30 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_38 + var_153_30
					end

					if var_153_33.prefab_name ~= "" and arg_150_1.actors_[var_153_33.prefab_name] ~= nil then
						local var_153_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_33.prefab_name].transform, "story_v_out_105082", "105082037", "story_v_out_105082.awb")

						arg_150_1:RecordAudio("105082037", var_153_39)
						arg_150_1:RecordAudio("105082037", var_153_39)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_105082", "105082037", "story_v_out_105082.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_105082", "105082037", "story_v_out_105082.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_40 = math.max(var_153_31, arg_150_1.talkMaxDuration)

			if var_153_30 <= arg_150_1.time_ and arg_150_1.time_ < var_153_30 + var_153_40 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_30) / var_153_40

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_30 + var_153_40 and arg_150_1.time_ < var_153_30 + var_153_40 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play105082038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 105082038
		arg_154_1.duration_ = 4.57

		local var_154_0 = {
			ja = 4.366,
			ko = 4.366,
			zh = 4.133,
			en = 4.566
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play105082039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1148ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1148ui_story == nil then
				arg_154_1.var_.characterEffect1148ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.1

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect1148ui_story and not isNil(var_157_0) then
					arg_154_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1148ui_story then
				arg_154_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_157_4 = arg_154_1.actors_["1027ui_story"]
			local var_157_5 = 0

			if var_157_5 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 and not isNil(var_157_4) and arg_154_1.var_.characterEffect1027ui_story == nil then
				arg_154_1.var_.characterEffect1027ui_story = var_157_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_6 = 0.1

			if var_157_5 <= arg_154_1.time_ and arg_154_1.time_ < var_157_5 + var_157_6 and not isNil(var_157_4) then
				local var_157_7 = (arg_154_1.time_ - var_157_5) / var_157_6

				if arg_154_1.var_.characterEffect1027ui_story and not isNil(var_157_4) then
					local var_157_8 = Mathf.Lerp(0, 0.5, var_157_7)

					arg_154_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1027ui_story.fillRatio = var_157_8
				end
			end

			if arg_154_1.time_ >= var_157_5 + var_157_6 and arg_154_1.time_ < var_157_5 + var_157_6 + arg_157_0 and not isNil(var_157_4) and arg_154_1.var_.characterEffect1027ui_story then
				local var_157_9 = 0.5

				arg_154_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1027ui_story.fillRatio = var_157_9
			end

			local var_157_10 = arg_154_1.actors_["1148ui_story"].transform
			local var_157_11 = 0

			if var_157_11 < arg_154_1.time_ and arg_154_1.time_ <= var_157_11 + arg_157_0 then
				arg_154_1.var_.moveOldPos1148ui_story = var_157_10.localPosition
			end

			local var_157_12 = 0.001

			if var_157_11 <= arg_154_1.time_ and arg_154_1.time_ < var_157_11 + var_157_12 then
				local var_157_13 = (arg_154_1.time_ - var_157_11) / var_157_12
				local var_157_14 = Vector3.New(0.7, -0.8, -6.2)

				var_157_10.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1148ui_story, var_157_14, var_157_13)

				local var_157_15 = manager.ui.mainCamera.transform.position - var_157_10.position

				var_157_10.forward = Vector3.New(var_157_15.x, var_157_15.y, var_157_15.z)

				local var_157_16 = var_157_10.localEulerAngles

				var_157_16.z = 0
				var_157_16.x = 0
				var_157_10.localEulerAngles = var_157_16
			end

			if arg_154_1.time_ >= var_157_11 + var_157_12 and arg_154_1.time_ < var_157_11 + var_157_12 + arg_157_0 then
				var_157_10.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_157_17 = manager.ui.mainCamera.transform.position - var_157_10.position

				var_157_10.forward = Vector3.New(var_157_17.x, var_157_17.y, var_157_17.z)

				local var_157_18 = var_157_10.localEulerAngles

				var_157_18.z = 0
				var_157_18.x = 0
				var_157_10.localEulerAngles = var_157_18
			end

			local var_157_19 = 0

			if var_157_19 < arg_154_1.time_ and arg_154_1.time_ <= var_157_19 + arg_157_0 then
				arg_154_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			local var_157_20 = 0

			if var_157_20 < arg_154_1.time_ and arg_154_1.time_ <= var_157_20 + arg_157_0 then
				arg_154_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_157_21 = 0
			local var_157_22 = 0.475

			if var_157_21 < arg_154_1.time_ and arg_154_1.time_ <= var_157_21 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_23 = arg_154_1:FormatText(StoryNameCfg[8].name)

				arg_154_1.leftNameTxt_.text = var_157_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_24 = arg_154_1:GetWordFromCfg(105082038)
				local var_157_25 = arg_154_1:FormatText(var_157_24.content)

				arg_154_1.text_.text = var_157_25

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_26 = 19
				local var_157_27 = utf8.len(var_157_25)
				local var_157_28 = var_157_26 <= 0 and var_157_22 or var_157_22 * (var_157_27 / var_157_26)

				if var_157_28 > 0 and var_157_22 < var_157_28 then
					arg_154_1.talkMaxDuration = var_157_28

					if var_157_28 + var_157_21 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_28 + var_157_21
					end
				end

				arg_154_1.text_.text = var_157_25
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082038", "story_v_out_105082.awb") ~= 0 then
					local var_157_29 = manager.audio:GetVoiceLength("story_v_out_105082", "105082038", "story_v_out_105082.awb") / 1000

					if var_157_29 + var_157_21 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_29 + var_157_21
					end

					if var_157_24.prefab_name ~= "" and arg_154_1.actors_[var_157_24.prefab_name] ~= nil then
						local var_157_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_24.prefab_name].transform, "story_v_out_105082", "105082038", "story_v_out_105082.awb")

						arg_154_1:RecordAudio("105082038", var_157_30)
						arg_154_1:RecordAudio("105082038", var_157_30)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_105082", "105082038", "story_v_out_105082.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_105082", "105082038", "story_v_out_105082.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_31 = math.max(var_157_22, arg_154_1.talkMaxDuration)

			if var_157_21 <= arg_154_1.time_ and arg_154_1.time_ < var_157_21 + var_157_31 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_21) / var_157_31

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_21 + var_157_31 and arg_154_1.time_ < var_157_21 + var_157_31 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
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

		arg_154_1:InitPlayNodeList()
	end,
	Play105082039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 105082039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play105082040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1148ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1148ui_story == nil then
				arg_158_1.var_.characterEffect1148ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.1

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect1148ui_story and not isNil(var_161_0) then
					local var_161_4 = Mathf.Lerp(0, 0.5, var_161_3)

					arg_158_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1148ui_story.fillRatio = var_161_4
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1148ui_story then
				local var_161_5 = 0.5

				arg_158_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1148ui_story.fillRatio = var_161_5
			end

			local var_161_6 = 0
			local var_161_7 = 0.625

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_8 = arg_158_1:FormatText(StoryNameCfg[7].name)

				arg_158_1.leftNameTxt_.text = var_161_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_9 = arg_158_1:GetWordFromCfg(105082039)
				local var_161_10 = arg_158_1:FormatText(var_161_9.content)

				arg_158_1.text_.text = var_161_10

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_11 = 25
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
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_14 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_14 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_14

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_14 and arg_158_1.time_ < var_161_6 + var_161_14 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play105082040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 105082040
		arg_162_1.duration_ = 2.07

		local var_162_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.066,
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
				arg_162_0:Play105082041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1080ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1080ui_story == nil then
				arg_162_1.var_.characterEffect1080ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.1

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect1080ui_story and not isNil(var_165_0) then
					arg_162_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1080ui_story then
				arg_162_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_165_4 = arg_162_1.actors_["1148ui_story"].transform
			local var_165_5 = 0

			if var_165_5 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 then
				arg_162_1.var_.moveOldPos1148ui_story = var_165_4.localPosition
			end

			local var_165_6 = 0.001

			if var_165_5 <= arg_162_1.time_ and arg_162_1.time_ < var_165_5 + var_165_6 then
				local var_165_7 = (arg_162_1.time_ - var_165_5) / var_165_6
				local var_165_8 = Vector3.New(0, 100, 0)

				var_165_4.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1148ui_story, var_165_8, var_165_7)

				local var_165_9 = manager.ui.mainCamera.transform.position - var_165_4.position

				var_165_4.forward = Vector3.New(var_165_9.x, var_165_9.y, var_165_9.z)

				local var_165_10 = var_165_4.localEulerAngles

				var_165_10.z = 0
				var_165_10.x = 0
				var_165_4.localEulerAngles = var_165_10
			end

			if arg_162_1.time_ >= var_165_5 + var_165_6 and arg_162_1.time_ < var_165_5 + var_165_6 + arg_165_0 then
				var_165_4.localPosition = Vector3.New(0, 100, 0)

				local var_165_11 = manager.ui.mainCamera.transform.position - var_165_4.position

				var_165_4.forward = Vector3.New(var_165_11.x, var_165_11.y, var_165_11.z)

				local var_165_12 = var_165_4.localEulerAngles

				var_165_12.z = 0
				var_165_12.x = 0
				var_165_4.localEulerAngles = var_165_12
			end

			local var_165_13 = arg_162_1.actors_["1027ui_story"].transform
			local var_165_14 = 0

			if var_165_14 < arg_162_1.time_ and arg_162_1.time_ <= var_165_14 + arg_165_0 then
				arg_162_1.var_.moveOldPos1027ui_story = var_165_13.localPosition
			end

			local var_165_15 = 0.001

			if var_165_14 <= arg_162_1.time_ and arg_162_1.time_ < var_165_14 + var_165_15 then
				local var_165_16 = (arg_162_1.time_ - var_165_14) / var_165_15
				local var_165_17 = Vector3.New(0, 100, 0)

				var_165_13.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1027ui_story, var_165_17, var_165_16)

				local var_165_18 = manager.ui.mainCamera.transform.position - var_165_13.position

				var_165_13.forward = Vector3.New(var_165_18.x, var_165_18.y, var_165_18.z)

				local var_165_19 = var_165_13.localEulerAngles

				var_165_19.z = 0
				var_165_19.x = 0
				var_165_13.localEulerAngles = var_165_19
			end

			if arg_162_1.time_ >= var_165_14 + var_165_15 and arg_162_1.time_ < var_165_14 + var_165_15 + arg_165_0 then
				var_165_13.localPosition = Vector3.New(0, 100, 0)

				local var_165_20 = manager.ui.mainCamera.transform.position - var_165_13.position

				var_165_13.forward = Vector3.New(var_165_20.x, var_165_20.y, var_165_20.z)

				local var_165_21 = var_165_13.localEulerAngles

				var_165_21.z = 0
				var_165_21.x = 0
				var_165_13.localEulerAngles = var_165_21
			end

			local var_165_22 = arg_162_1.actors_["1080ui_story"].transform
			local var_165_23 = 0

			if var_165_23 < arg_162_1.time_ and arg_162_1.time_ <= var_165_23 + arg_165_0 then
				arg_162_1.var_.moveOldPos1080ui_story = var_165_22.localPosition
			end

			local var_165_24 = 0.001

			if var_165_23 <= arg_162_1.time_ and arg_162_1.time_ < var_165_23 + var_165_24 then
				local var_165_25 = (arg_162_1.time_ - var_165_23) / var_165_24
				local var_165_26 = Vector3.New(0, -1.01, -6.05)

				var_165_22.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1080ui_story, var_165_26, var_165_25)

				local var_165_27 = manager.ui.mainCamera.transform.position - var_165_22.position

				var_165_22.forward = Vector3.New(var_165_27.x, var_165_27.y, var_165_27.z)

				local var_165_28 = var_165_22.localEulerAngles

				var_165_28.z = 0
				var_165_28.x = 0
				var_165_22.localEulerAngles = var_165_28
			end

			if arg_162_1.time_ >= var_165_23 + var_165_24 and arg_162_1.time_ < var_165_23 + var_165_24 + arg_165_0 then
				var_165_22.localPosition = Vector3.New(0, -1.01, -6.05)

				local var_165_29 = manager.ui.mainCamera.transform.position - var_165_22.position

				var_165_22.forward = Vector3.New(var_165_29.x, var_165_29.y, var_165_29.z)

				local var_165_30 = var_165_22.localEulerAngles

				var_165_30.z = 0
				var_165_30.x = 0
				var_165_22.localEulerAngles = var_165_30
			end

			local var_165_31 = 0

			if var_165_31 < arg_162_1.time_ and arg_162_1.time_ <= var_165_31 + arg_165_0 then
				arg_162_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			local var_165_32 = 0

			if var_165_32 < arg_162_1.time_ and arg_162_1.time_ <= var_165_32 + arg_165_0 then
				arg_162_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_165_33 = 0
			local var_165_34 = 0.175

			if var_165_33 < arg_162_1.time_ and arg_162_1.time_ <= var_165_33 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_35 = arg_162_1:FormatText(StoryNameCfg[55].name)

				arg_162_1.leftNameTxt_.text = var_165_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_36 = arg_162_1:GetWordFromCfg(105082040)
				local var_165_37 = arg_162_1:FormatText(var_165_36.content)

				arg_162_1.text_.text = var_165_37

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_38 = 7
				local var_165_39 = utf8.len(var_165_37)
				local var_165_40 = var_165_38 <= 0 and var_165_34 or var_165_34 * (var_165_39 / var_165_38)

				if var_165_40 > 0 and var_165_34 < var_165_40 then
					arg_162_1.talkMaxDuration = var_165_40

					if var_165_40 + var_165_33 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_40 + var_165_33
					end
				end

				arg_162_1.text_.text = var_165_37
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082040", "story_v_out_105082.awb") ~= 0 then
					local var_165_41 = manager.audio:GetVoiceLength("story_v_out_105082", "105082040", "story_v_out_105082.awb") / 1000

					if var_165_41 + var_165_33 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_41 + var_165_33
					end

					if var_165_36.prefab_name ~= "" and arg_162_1.actors_[var_165_36.prefab_name] ~= nil then
						local var_165_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_36.prefab_name].transform, "story_v_out_105082", "105082040", "story_v_out_105082.awb")

						arg_162_1:RecordAudio("105082040", var_165_42)
						arg_162_1:RecordAudio("105082040", var_165_42)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_105082", "105082040", "story_v_out_105082.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_105082", "105082040", "story_v_out_105082.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_43 = math.max(var_165_34, arg_162_1.talkMaxDuration)

			if var_165_33 <= arg_162_1.time_ and arg_162_1.time_ < var_165_33 + var_165_43 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_33) / var_165_43

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_33 + var_165_43 and arg_162_1.time_ < var_165_33 + var_165_43 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play105082041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 105082041
		arg_166_1.duration_ = 7

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play105082042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 1

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				local var_169_2 = "play"
				local var_169_3 = "music"

				arg_166_1:AudioAction(var_169_2, var_169_3, "bgm_story_office", "bgm_story_office", "bgm_story_office")

				local var_169_4 = ""
				local var_169_5 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_169_5 ~= "" then
					if arg_166_1.bgmTxt_.text ~= var_169_5 and arg_166_1.bgmTxt_.text ~= "" then
						if arg_166_1.bgmTxt2_.text ~= "" then
							arg_166_1.bgmTxt_.text = arg_166_1.bgmTxt2_.text
						end

						arg_166_1.bgmTxt2_.text = var_169_5

						arg_166_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_166_1.bgmTxt_.text = var_169_5
						arg_166_1.bgmTxt2_.text = var_169_5
					end

					if arg_166_1.bgmTimer then
						arg_166_1.bgmTimer:Stop()

						arg_166_1.bgmTimer = nil
					end

					if arg_166_1.settingData.show_music_name == 1 then
						arg_166_1.musicController:SetSelectedState("show")
						arg_166_1.musicAnimator_:Play("open", 0, 0)

						if arg_166_1.settingData.music_time ~= 0 then
							arg_166_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_166_1.settingData.music_time), function()
								if arg_166_1 == nil or isNil(arg_166_1.bgmTxt_) then
									return
								end

								arg_166_1.musicController:SetSelectedState("hide")
								arg_166_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_169_6 = arg_166_1.actors_["1080ui_story"]
			local var_169_7 = 2

			if var_169_7 < arg_166_1.time_ and arg_166_1.time_ <= var_169_7 + arg_169_0 and not isNil(var_169_6) and arg_166_1.var_.characterEffect1080ui_story == nil then
				arg_166_1.var_.characterEffect1080ui_story = var_169_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_8 = 0.1

			if var_169_7 <= arg_166_1.time_ and arg_166_1.time_ < var_169_7 + var_169_8 and not isNil(var_169_6) then
				local var_169_9 = (arg_166_1.time_ - var_169_7) / var_169_8

				if arg_166_1.var_.characterEffect1080ui_story and not isNil(var_169_6) then
					local var_169_10 = Mathf.Lerp(0, 0.5, var_169_9)

					arg_166_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1080ui_story.fillRatio = var_169_10
				end
			end

			if arg_166_1.time_ >= var_169_7 + var_169_8 and arg_166_1.time_ < var_169_7 + var_169_8 + arg_169_0 and not isNil(var_169_6) and arg_166_1.var_.characterEffect1080ui_story then
				local var_169_11 = 0.5

				arg_166_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1080ui_story.fillRatio = var_169_11
			end

			local var_169_12 = arg_166_1.bgs_.B14
			local var_169_13 = 0

			if var_169_13 < arg_166_1.time_ and arg_166_1.time_ <= var_169_13 + arg_169_0 then
				local var_169_14 = var_169_12:GetComponent("SpriteRenderer")

				if var_169_14 then
					arg_166_1.var_.alphaOldValueB14 = var_169_14.color.a
					arg_166_1.var_.alphaMatValueB14 = var_169_14
				end

				arg_166_1.var_.alphaOldValueB14 = 1
			end

			local var_169_15 = 1.5

			if var_169_13 <= arg_166_1.time_ and arg_166_1.time_ < var_169_13 + var_169_15 then
				local var_169_16 = (arg_166_1.time_ - var_169_13) / var_169_15
				local var_169_17 = Mathf.Lerp(arg_166_1.var_.alphaOldValueB14, 0, var_169_16)

				if arg_166_1.var_.alphaMatValueB14 then
					local var_169_18 = arg_166_1.var_.alphaMatValueB14.color

					var_169_18.a = var_169_17
					arg_166_1.var_.alphaMatValueB14.color = var_169_18
				end
			end

			if arg_166_1.time_ >= var_169_13 + var_169_15 and arg_166_1.time_ < var_169_13 + var_169_15 + arg_169_0 and arg_166_1.var_.alphaMatValueB14 then
				local var_169_19 = arg_166_1.var_.alphaMatValueB14
				local var_169_20 = var_169_19.color

				var_169_20.a = 0
				var_169_19.color = var_169_20
			end

			local var_169_21 = arg_166_1.bgs_.B14.transform
			local var_169_22 = 1.5

			if var_169_22 < arg_166_1.time_ and arg_166_1.time_ <= var_169_22 + arg_169_0 then
				arg_166_1.var_.moveOldPosB14 = var_169_21.localPosition
			end

			local var_169_23 = 0.001

			if var_169_22 <= arg_166_1.time_ and arg_166_1.time_ < var_169_22 + var_169_23 then
				local var_169_24 = (arg_166_1.time_ - var_169_22) / var_169_23
				local var_169_25 = Vector3.New(0, -100, 10)

				var_169_21.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPosB14, var_169_25, var_169_24)
			end

			if arg_166_1.time_ >= var_169_22 + var_169_23 and arg_166_1.time_ < var_169_22 + var_169_23 + arg_169_0 then
				var_169_21.localPosition = Vector3.New(0, -100, 10)
			end

			local var_169_26 = "A00"

			if arg_166_1.bgs_[var_169_26] == nil then
				local var_169_27 = Object.Instantiate(arg_166_1.paintGo_)

				var_169_27:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_169_26)
				var_169_27.name = var_169_26
				var_169_27.transform.parent = arg_166_1.stage_.transform
				var_169_27.transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.bgs_[var_169_26] = var_169_27
			end

			local var_169_28 = arg_166_1.bgs_.A00
			local var_169_29 = 1.5

			if var_169_29 < arg_166_1.time_ and arg_166_1.time_ <= var_169_29 + arg_169_0 then
				local var_169_30 = var_169_28:GetComponent("SpriteRenderer")

				if var_169_30 then
					arg_166_1.var_.alphaOldValueA00 = var_169_30.color.a
					arg_166_1.var_.alphaMatValueA00 = var_169_30
				end

				arg_166_1.var_.alphaOldValueA00 = 0
			end

			local var_169_31 = 1.5

			if var_169_29 <= arg_166_1.time_ and arg_166_1.time_ < var_169_29 + var_169_31 then
				local var_169_32 = (arg_166_1.time_ - var_169_29) / var_169_31
				local var_169_33 = Mathf.Lerp(arg_166_1.var_.alphaOldValueA00, 1, var_169_32)

				if arg_166_1.var_.alphaMatValueA00 then
					local var_169_34 = arg_166_1.var_.alphaMatValueA00.color

					var_169_34.a = var_169_33
					arg_166_1.var_.alphaMatValueA00.color = var_169_34
				end
			end

			if arg_166_1.time_ >= var_169_29 + var_169_31 and arg_166_1.time_ < var_169_29 + var_169_31 + arg_169_0 and arg_166_1.var_.alphaMatValueA00 then
				local var_169_35 = arg_166_1.var_.alphaMatValueA00
				local var_169_36 = var_169_35.color

				var_169_36.a = 1
				var_169_35.color = var_169_36
			end

			local var_169_37 = 1.5

			if var_169_37 < arg_166_1.time_ and arg_166_1.time_ <= var_169_37 + arg_169_0 then
				local var_169_38 = manager.ui.mainCamera.transform.localPosition
				local var_169_39 = Vector3.New(0, 0, 10) + Vector3.New(var_169_38.x, var_169_38.y, 0)
				local var_169_40 = arg_166_1.bgs_.A00

				var_169_40.transform.localPosition = var_169_39
				var_169_40.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_41 = var_169_40:GetComponent("SpriteRenderer")

				if var_169_41 and var_169_41.sprite then
					local var_169_42 = (var_169_40.transform.localPosition - var_169_38).z
					local var_169_43 = manager.ui.mainCameraCom_
					local var_169_44 = 2 * var_169_42 * Mathf.Tan(var_169_43.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_169_45 = var_169_44 * var_169_43.aspect
					local var_169_46 = var_169_41.sprite.bounds.size.x
					local var_169_47 = var_169_41.sprite.bounds.size.y
					local var_169_48 = var_169_45 / var_169_46
					local var_169_49 = var_169_44 / var_169_47
					local var_169_50 = var_169_49 < var_169_48 and var_169_48 or var_169_49

					var_169_40.transform.localScale = Vector3.New(var_169_50, var_169_50, 0)
				end

				for iter_169_0, iter_169_1 in pairs(arg_166_1.bgs_) do
					if iter_169_0 ~= "A00" then
						iter_169_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_169_51 = arg_166_1.actors_["1080ui_story"].transform
			local var_169_52 = 0

			if var_169_52 < arg_166_1.time_ and arg_166_1.time_ <= var_169_52 + arg_169_0 then
				arg_166_1.var_.moveOldPos1080ui_story = var_169_51.localPosition
			end

			local var_169_53 = 0.001

			if var_169_52 <= arg_166_1.time_ and arg_166_1.time_ < var_169_52 + var_169_53 then
				local var_169_54 = (arg_166_1.time_ - var_169_52) / var_169_53
				local var_169_55 = Vector3.New(0, 100, 0)

				var_169_51.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1080ui_story, var_169_55, var_169_54)

				local var_169_56 = manager.ui.mainCamera.transform.position - var_169_51.position

				var_169_51.forward = Vector3.New(var_169_56.x, var_169_56.y, var_169_56.z)

				local var_169_57 = var_169_51.localEulerAngles

				var_169_57.z = 0
				var_169_57.x = 0
				var_169_51.localEulerAngles = var_169_57
			end

			if arg_166_1.time_ >= var_169_52 + var_169_53 and arg_166_1.time_ < var_169_52 + var_169_53 + arg_169_0 then
				var_169_51.localPosition = Vector3.New(0, 100, 0)

				local var_169_58 = manager.ui.mainCamera.transform.position - var_169_51.position

				var_169_51.forward = Vector3.New(var_169_58.x, var_169_58.y, var_169_58.z)

				local var_169_59 = var_169_51.localEulerAngles

				var_169_59.z = 0
				var_169_59.x = 0
				var_169_51.localEulerAngles = var_169_59
			end

			local var_169_60 = 0

			if var_169_60 < arg_166_1.time_ and arg_166_1.time_ <= var_169_60 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			local var_169_61 = 2

			if arg_166_1.time_ >= var_169_60 + var_169_61 and arg_166_1.time_ < var_169_60 + var_169_61 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			local var_169_62 = 2
			local var_169_63 = 0.225

			if var_169_62 < arg_166_1.time_ and arg_166_1.time_ <= var_169_62 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_64 = arg_166_1:GetWordFromCfg(105082041)
				local var_169_65 = arg_166_1:FormatText(var_169_64.content)

				arg_166_1.text_.text = var_169_65

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_66 = 9
				local var_169_67 = utf8.len(var_169_65)
				local var_169_68 = var_169_66 <= 0 and var_169_63 or var_169_63 * (var_169_67 / var_169_66)

				if var_169_68 > 0 and var_169_63 < var_169_68 then
					arg_166_1.talkMaxDuration = var_169_68

					if var_169_68 + var_169_62 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_68 + var_169_62
					end
				end

				arg_166_1.text_.text = var_169_65
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_69 = math.max(var_169_63, arg_166_1.talkMaxDuration)

			if var_169_62 <= arg_166_1.time_ and arg_166_1.time_ < var_169_62 + var_169_69 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_62) / var_169_69

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_62 + var_169_69 and arg_166_1.time_ < var_169_62 + var_169_69 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B14",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
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
	Play105082042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 105082042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play105082043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.675

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[7].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(105082042)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 27
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_8 and arg_171_1.time_ < var_174_0 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play105082043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 105082043
		arg_175_1.duration_ = 4.2

		local var_175_0 = {
			ja = 3.333,
			ko = 2.8,
			zh = 3.1,
			en = 4.2
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play105082044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.3

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[10].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(105082043)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 12
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082043", "story_v_out_105082.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_105082", "105082043", "story_v_out_105082.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_105082", "105082043", "story_v_out_105082.awb")

						arg_175_1:RecordAudio("105082043", var_178_9)
						arg_175_1:RecordAudio("105082043", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_105082", "105082043", "story_v_out_105082.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_105082", "105082043", "story_v_out_105082.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_10 and arg_175_1.time_ < var_178_0 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play105082044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 105082044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play105082045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.875

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[7].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:GetWordFromCfg(105082044)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 35
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_8 and arg_179_1.time_ < var_182_0 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play105082045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 105082045
		arg_183_1.duration_ = 8.47

		local var_183_0 = {
			ja = 8.466,
			ko = 6.2,
			zh = 5.266,
			en = 5.033
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play105082046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.65

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[10].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(105082045)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 26
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082045", "story_v_out_105082.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_105082", "105082045", "story_v_out_105082.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_105082", "105082045", "story_v_out_105082.awb")

						arg_183_1:RecordAudio("105082045", var_186_9)
						arg_183_1:RecordAudio("105082045", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_105082", "105082045", "story_v_out_105082.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_105082", "105082045", "story_v_out_105082.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play105082046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 105082046
		arg_187_1.duration_ = 2.4

		local var_187_0 = {
			ja = 2.4,
			ko = 2.2,
			zh = 2.166,
			en = 2.266
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play105082047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = "1037ui_story"

			if arg_187_1.actors_[var_190_0] == nil then
				local var_190_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_190_1) then
					local var_190_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_187_1.stage_.transform)

					var_190_2.name = var_190_0
					var_190_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_187_1.actors_[var_190_0] = var_190_2

					local var_190_3 = var_190_2:GetComponentInChildren(typeof(CharacterEffect))

					var_190_3.enabled = true

					local var_190_4 = GameObjectTools.GetOrAddComponent(var_190_2, typeof(DynamicBoneHelper))

					if var_190_4 then
						var_190_4:EnableDynamicBone(false)
					end

					arg_187_1:ShowWeapon(var_190_3.transform, false)

					arg_187_1.var_[var_190_0 .. "Animator"] = var_190_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_187_1.var_[var_190_0 .. "Animator"].applyRootMotion = true
					arg_187_1.var_[var_190_0 .. "LipSync"] = var_190_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_190_5 = arg_187_1.actors_["1037ui_story"]
			local var_190_6 = 0

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.characterEffect1037ui_story == nil then
				arg_187_1.var_.characterEffect1037ui_story = var_190_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_7 = 0.1

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_7 and not isNil(var_190_5) then
				local var_190_8 = (arg_187_1.time_ - var_190_6) / var_190_7

				if arg_187_1.var_.characterEffect1037ui_story and not isNil(var_190_5) then
					arg_187_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_6 + var_190_7 and arg_187_1.time_ < var_190_6 + var_190_7 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.characterEffect1037ui_story then
				arg_187_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_190_9 = arg_187_1.actors_["1037ui_story"].transform
			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 then
				arg_187_1.var_.moveOldPos1037ui_story = var_190_9.localPosition
			end

			local var_190_11 = 0.001

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_11 then
				local var_190_12 = (arg_187_1.time_ - var_190_10) / var_190_11
				local var_190_13 = Vector3.New(0, -1.09, -5.81)

				var_190_9.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1037ui_story, var_190_13, var_190_12)

				local var_190_14 = manager.ui.mainCamera.transform.position - var_190_9.position

				var_190_9.forward = Vector3.New(var_190_14.x, var_190_14.y, var_190_14.z)

				local var_190_15 = var_190_9.localEulerAngles

				var_190_15.z = 0
				var_190_15.x = 0
				var_190_9.localEulerAngles = var_190_15
			end

			if arg_187_1.time_ >= var_190_10 + var_190_11 and arg_187_1.time_ < var_190_10 + var_190_11 + arg_190_0 then
				var_190_9.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_190_16 = manager.ui.mainCamera.transform.position - var_190_9.position

				var_190_9.forward = Vector3.New(var_190_16.x, var_190_16.y, var_190_16.z)

				local var_190_17 = var_190_9.localEulerAngles

				var_190_17.z = 0
				var_190_17.x = 0
				var_190_9.localEulerAngles = var_190_17
			end

			local var_190_18 = 0

			if var_190_18 < arg_187_1.time_ and arg_187_1.time_ <= var_190_18 + arg_190_0 then
				arg_187_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_190_19 = 0

			if var_190_19 < arg_187_1.time_ and arg_187_1.time_ <= var_190_19 + arg_190_0 then
				arg_187_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_190_20 = 0
			local var_190_21 = 0.275

			if var_190_20 < arg_187_1.time_ and arg_187_1.time_ <= var_190_20 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_22 = arg_187_1:FormatText(StoryNameCfg[15].name)

				arg_187_1.leftNameTxt_.text = var_190_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_23 = arg_187_1:GetWordFromCfg(105082046)
				local var_190_24 = arg_187_1:FormatText(var_190_23.content)

				arg_187_1.text_.text = var_190_24

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_25 = 11
				local var_190_26 = utf8.len(var_190_24)
				local var_190_27 = var_190_25 <= 0 and var_190_21 or var_190_21 * (var_190_26 / var_190_25)

				if var_190_27 > 0 and var_190_21 < var_190_27 then
					arg_187_1.talkMaxDuration = var_190_27

					if var_190_27 + var_190_20 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_27 + var_190_20
					end
				end

				arg_187_1.text_.text = var_190_24
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082046", "story_v_out_105082.awb") ~= 0 then
					local var_190_28 = manager.audio:GetVoiceLength("story_v_out_105082", "105082046", "story_v_out_105082.awb") / 1000

					if var_190_28 + var_190_20 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_28 + var_190_20
					end

					if var_190_23.prefab_name ~= "" and arg_187_1.actors_[var_190_23.prefab_name] ~= nil then
						local var_190_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_23.prefab_name].transform, "story_v_out_105082", "105082046", "story_v_out_105082.awb")

						arg_187_1:RecordAudio("105082046", var_190_29)
						arg_187_1:RecordAudio("105082046", var_190_29)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_105082", "105082046", "story_v_out_105082.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_105082", "105082046", "story_v_out_105082.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_30 = math.max(var_190_21, arg_187_1.talkMaxDuration)

			if var_190_20 <= arg_187_1.time_ and arg_187_1.time_ < var_190_20 + var_190_30 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_20) / var_190_30

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_20 + var_190_30 and arg_187_1.time_ < var_190_20 + var_190_30 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play105082047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 105082047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play105082048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1037ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1037ui_story == nil then
				arg_191_1.var_.characterEffect1037ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.1

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect1037ui_story and not isNil(var_194_0) then
					local var_194_4 = Mathf.Lerp(0, 0.5, var_194_3)

					arg_191_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1037ui_story.fillRatio = var_194_4
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1037ui_story then
				local var_194_5 = 0.5

				arg_191_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1037ui_story.fillRatio = var_194_5
			end

			local var_194_6 = 0
			local var_194_7 = 0.225

			if var_194_6 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_8 = arg_191_1:FormatText(StoryNameCfg[7].name)

				arg_191_1.leftNameTxt_.text = var_194_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_9 = arg_191_1:GetWordFromCfg(105082047)
				local var_194_10 = arg_191_1:FormatText(var_194_9.content)

				arg_191_1.text_.text = var_194_10

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 9
				local var_194_12 = utf8.len(var_194_10)
				local var_194_13 = var_194_11 <= 0 and var_194_7 or var_194_7 * (var_194_12 / var_194_11)

				if var_194_13 > 0 and var_194_7 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_10
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_14 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_14 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_14

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_14 and arg_191_1.time_ < var_194_6 + var_194_14 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play105082048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 105082048
		arg_195_1.duration_ = 5.63

		local var_195_0 = {
			ja = 5.633,
			ko = 3.166,
			zh = 3.833,
			en = 3.6
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play105082049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1037ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1037ui_story == nil then
				arg_195_1.var_.characterEffect1037ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.1

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect1037ui_story and not isNil(var_198_0) then
					arg_195_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1037ui_story then
				arg_195_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_198_4 = 0

			if var_198_4 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			local var_198_5 = 0

			if var_198_5 < arg_195_1.time_ and arg_195_1.time_ <= var_198_5 + arg_198_0 then
				arg_195_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_198_6 = 0
			local var_198_7 = 0.45

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_8 = arg_195_1:FormatText(StoryNameCfg[15].name)

				arg_195_1.leftNameTxt_.text = var_198_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_9 = arg_195_1:GetWordFromCfg(105082048)
				local var_198_10 = arg_195_1:FormatText(var_198_9.content)

				arg_195_1.text_.text = var_198_10

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 18
				local var_198_12 = utf8.len(var_198_10)
				local var_198_13 = var_198_11 <= 0 and var_198_7 or var_198_7 * (var_198_12 / var_198_11)

				if var_198_13 > 0 and var_198_7 < var_198_13 then
					arg_195_1.talkMaxDuration = var_198_13

					if var_198_13 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_10
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082048", "story_v_out_105082.awb") ~= 0 then
					local var_198_14 = manager.audio:GetVoiceLength("story_v_out_105082", "105082048", "story_v_out_105082.awb") / 1000

					if var_198_14 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_14 + var_198_6
					end

					if var_198_9.prefab_name ~= "" and arg_195_1.actors_[var_198_9.prefab_name] ~= nil then
						local var_198_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_9.prefab_name].transform, "story_v_out_105082", "105082048", "story_v_out_105082.awb")

						arg_195_1:RecordAudio("105082048", var_198_15)
						arg_195_1:RecordAudio("105082048", var_198_15)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_105082", "105082048", "story_v_out_105082.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_105082", "105082048", "story_v_out_105082.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_16 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_16 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_16

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_16 and arg_195_1.time_ < var_198_6 + var_198_16 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play105082049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 105082049
		arg_199_1.duration_ = 5.73

		local var_199_0 = {
			ja = 5.733,
			ko = 4.3,
			zh = 4.966,
			en = 5.4
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
			arg_199_1.auto_ = false
		end

		function arg_199_1.playNext_(arg_201_0)
			arg_199_1.onStoryFinished_()
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1037ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1037ui_story == nil then
				arg_199_1.var_.characterEffect1037ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.1

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1037ui_story and not isNil(var_202_0) then
					local var_202_4 = Mathf.Lerp(0, 0.5, var_202_3)

					arg_199_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1037ui_story.fillRatio = var_202_4
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1037ui_story then
				local var_202_5 = 0.5

				arg_199_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1037ui_story.fillRatio = var_202_5
			end

			local var_202_6 = 0
			local var_202_7 = 0.45

			if var_202_6 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_8 = arg_199_1:FormatText(StoryNameCfg[10].name)

				arg_199_1.leftNameTxt_.text = var_202_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_9 = arg_199_1:GetWordFromCfg(105082049)
				local var_202_10 = arg_199_1:FormatText(var_202_9.content)

				arg_199_1.text_.text = var_202_10

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_11 = 18
				local var_202_12 = utf8.len(var_202_10)
				local var_202_13 = var_202_11 <= 0 and var_202_7 or var_202_7 * (var_202_12 / var_202_11)

				if var_202_13 > 0 and var_202_7 < var_202_13 then
					arg_199_1.talkMaxDuration = var_202_13

					if var_202_13 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_10
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082049", "story_v_out_105082.awb") ~= 0 then
					local var_202_14 = manager.audio:GetVoiceLength("story_v_out_105082", "105082049", "story_v_out_105082.awb") / 1000

					if var_202_14 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_14 + var_202_6
					end

					if var_202_9.prefab_name ~= "" and arg_199_1.actors_[var_202_9.prefab_name] ~= nil then
						local var_202_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_9.prefab_name].transform, "story_v_out_105082", "105082049", "story_v_out_105082.awb")

						arg_199_1:RecordAudio("105082049", var_202_15)
						arg_199_1:RecordAudio("105082049", var_202_15)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_105082", "105082049", "story_v_out_105082.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_105082", "105082049", "story_v_out_105082.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_16 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_16 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_16

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_16 and arg_199_1.time_ < var_202_6 + var_202_16 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B14",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_out_105082.awb"
	}
}
