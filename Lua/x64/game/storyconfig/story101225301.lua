return {
	Play122531001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122531001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play122531002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST37"

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
				local var_4_5 = arg_1_1.bgs_.ST37

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
					if iter_4_0 ~= "ST37" then
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

			local var_4_22 = 0
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 1.5
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_1_story_farewell", "bgm_activity_2_1_story_farewell", "bgm_activity_2_1_story_farewell.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_1_story_farewell", "bgm_activity_2_1_story_farewell")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			local var_4_34 = 1.999999999999
			local var_4_35 = 0.3

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(122531001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 12
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_43 = var_4_34 + 0.3
			local var_4_44 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_43) / var_4_44

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play122531002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 122531002
		arg_9_1.duration_ = 10.3

		local var_9_0 = {
			ja = 10.3,
			ko = 6.3,
			zh = 6.3
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play122531003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1029ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_9_1.stage_.transform)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentInChildren(typeof(CharacterEffect))

					var_12_3.enabled = true

					local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_2, typeof(DynamicBoneHelper))

					if var_12_4 then
						var_12_4:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_3.transform, false)

					arg_9_1.var_[var_12_0 .. "Animator"] = var_12_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_0 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_0 .. "LipSync"] = var_12_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_5 = arg_9_1.actors_["1029ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1029ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -1.09, -6.2)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1029ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["1029ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1029ui_story == nil then
				arg_9_1.var_.characterEffect1029ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1029ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1029ui_story then
				arg_9_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_20 = arg_9_1.actors_["1029ui_story"]
			local var_12_21 = 0

			if var_12_21 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 then
				if arg_9_1.var_.characterEffect1029ui_story == nil then
					arg_9_1.var_.characterEffect1029ui_story = var_12_20:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_12_22 = arg_9_1.var_.characterEffect1029ui_story

				var_12_22.imageEffect:turnOff()

				var_12_22.interferenceEffect.enabled = true
				var_12_22.interferenceEffect.noise = 0.001
				var_12_22.interferenceEffect.simTimeScale = 1
				var_12_22.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_12_23 = arg_9_1.actors_["1029ui_story"]
			local var_12_24 = 0
			local var_12_25 = 0.2

			if var_12_24 < arg_9_1.time_ and arg_9_1.time_ <= var_12_24 + arg_12_0 then
				if arg_9_1.var_.characterEffect1029ui_story == nil then
					arg_9_1.var_.characterEffect1029ui_story = var_12_23:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_9_1.var_.characterEffect1029ui_story.imageEffect:turnOn(false)
			end

			local var_12_26 = 0
			local var_12_27 = 0.85

			if var_12_26 < arg_9_1.time_ and arg_9_1.time_ <= var_12_26 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_28 = arg_9_1:FormatText(StoryNameCfg[319].name)

				arg_9_1.leftNameTxt_.text = var_12_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_29 = arg_9_1:GetWordFromCfg(122531002)
				local var_12_30 = arg_9_1:FormatText(var_12_29.content)

				arg_9_1.text_.text = var_12_30

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_31 = 34
				local var_12_32 = utf8.len(var_12_30)
				local var_12_33 = var_12_31 <= 0 and var_12_27 or var_12_27 * (var_12_32 / var_12_31)

				if var_12_33 > 0 and var_12_27 < var_12_33 then
					arg_9_1.talkMaxDuration = var_12_33

					if var_12_33 + var_12_26 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_33 + var_12_26
					end
				end

				arg_9_1.text_.text = var_12_30
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531002", "story_v_out_122531.awb") ~= 0 then
					local var_12_34 = manager.audio:GetVoiceLength("story_v_out_122531", "122531002", "story_v_out_122531.awb") / 1000

					if var_12_34 + var_12_26 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_34 + var_12_26
					end

					if var_12_29.prefab_name ~= "" and arg_9_1.actors_[var_12_29.prefab_name] ~= nil then
						local var_12_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_29.prefab_name].transform, "story_v_out_122531", "122531002", "story_v_out_122531.awb")

						arg_9_1:RecordAudio("122531002", var_12_35)
						arg_9_1:RecordAudio("122531002", var_12_35)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_122531", "122531002", "story_v_out_122531.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_122531", "122531002", "story_v_out_122531.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_36 = math.max(var_12_27, arg_9_1.talkMaxDuration)

			if var_12_26 <= arg_9_1.time_ and arg_9_1.time_ < var_12_26 + var_12_36 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_26) / var_12_36

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_26 + var_12_36 and arg_9_1.time_ < var_12_26 + var_12_36 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play122531003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 122531003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play122531004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1029ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1029ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, 100, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1029ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, 100, 0)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["1029ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1029ui_story == nil then
				arg_13_1.var_.characterEffect1029ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect1029ui_story and not isNil(var_16_9) then
					local var_16_13 = Mathf.Lerp(0, 0.5, var_16_12)

					arg_13_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1029ui_story.fillRatio = var_16_13
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1029ui_story then
				local var_16_14 = 0.5

				arg_13_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1029ui_story.fillRatio = var_16_14
			end

			local var_16_15 = 0
			local var_16_16 = 1.525

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_17 = arg_13_1:GetWordFromCfg(122531003)
				local var_16_18 = arg_13_1:FormatText(var_16_17.content)

				arg_13_1.text_.text = var_16_18

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_19 = 61
				local var_16_20 = utf8.len(var_16_18)
				local var_16_21 = var_16_19 <= 0 and var_16_16 or var_16_16 * (var_16_20 / var_16_19)

				if var_16_21 > 0 and var_16_16 < var_16_21 then
					arg_13_1.talkMaxDuration = var_16_21

					if var_16_21 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_21 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_18
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_22 and arg_13_1.time_ < var_16_15 + var_16_22 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play122531004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 122531004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play122531005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.425

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(122531004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 57
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play122531005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 122531005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play122531006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.65

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(122531005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 26
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_8 and arg_21_1.time_ < var_24_0 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play122531006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 122531006
		arg_25_1.duration_ = 3.8

		local var_25_0 = {
			ja = 3.8,
			ko = 3.7,
			zh = 3.7
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play122531007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1029ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1029ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, -1.09, -6.2)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1029ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1029ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1029ui_story == nil then
				arg_25_1.var_.characterEffect1029ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1029ui_story and not isNil(var_28_9) then
					arg_25_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1029ui_story then
				arg_25_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_28_13 = 0

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_15 = 0
			local var_28_16 = 0.425

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_17 = arg_25_1:FormatText(StoryNameCfg[319].name)

				arg_25_1.leftNameTxt_.text = var_28_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_18 = arg_25_1:GetWordFromCfg(122531006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_20 = 17
				local var_28_21 = utf8.len(var_28_19)
				local var_28_22 = var_28_20 <= 0 and var_28_16 or var_28_16 * (var_28_21 / var_28_20)

				if var_28_22 > 0 and var_28_16 < var_28_22 then
					arg_25_1.talkMaxDuration = var_28_22

					if var_28_22 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_19
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531006", "story_v_out_122531.awb") ~= 0 then
					local var_28_23 = manager.audio:GetVoiceLength("story_v_out_122531", "122531006", "story_v_out_122531.awb") / 1000

					if var_28_23 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_15
					end

					if var_28_18.prefab_name ~= "" and arg_25_1.actors_[var_28_18.prefab_name] ~= nil then
						local var_28_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_18.prefab_name].transform, "story_v_out_122531", "122531006", "story_v_out_122531.awb")

						arg_25_1:RecordAudio("122531006", var_28_24)
						arg_25_1:RecordAudio("122531006", var_28_24)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_122531", "122531006", "story_v_out_122531.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_122531", "122531006", "story_v_out_122531.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_25 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_25 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_25

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_25 and arg_25_1.time_ < var_28_15 + var_28_25 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play122531007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 122531007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play122531008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1029ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1029ui_story == nil then
				arg_29_1.var_.characterEffect1029ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1029ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1029ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1029ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1029ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0
			local var_32_7 = 0.2

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_9 = arg_29_1:GetWordFromCfg(122531007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 8
				local var_32_12 = utf8.len(var_32_10)
				local var_32_13 = var_32_11 <= 0 and var_32_7 or var_32_7 * (var_32_12 / var_32_11)

				if var_32_13 > 0 and var_32_7 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_14 and arg_29_1.time_ < var_32_6 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play122531008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 122531008
		arg_33_1.duration_ = 8.63

		local var_33_0 = {
			ja = 8.633,
			ko = 6,
			zh = 6
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play122531009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1029ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1029ui_story == nil then
				arg_33_1.var_.characterEffect1029ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1029ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1029ui_story then
				arg_33_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_36_4 = 0

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_5 = 0
			local var_36_6 = 0.45

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_7 = arg_33_1:FormatText(StoryNameCfg[319].name)

				arg_33_1.leftNameTxt_.text = var_36_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(122531008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 18
				local var_36_11 = utf8.len(var_36_9)
				local var_36_12 = var_36_10 <= 0 and var_36_6 or var_36_6 * (var_36_11 / var_36_10)

				if var_36_12 > 0 and var_36_6 < var_36_12 then
					arg_33_1.talkMaxDuration = var_36_12

					if var_36_12 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531008", "story_v_out_122531.awb") ~= 0 then
					local var_36_13 = manager.audio:GetVoiceLength("story_v_out_122531", "122531008", "story_v_out_122531.awb") / 1000

					if var_36_13 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_5
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_122531", "122531008", "story_v_out_122531.awb")

						arg_33_1:RecordAudio("122531008", var_36_14)
						arg_33_1:RecordAudio("122531008", var_36_14)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_122531", "122531008", "story_v_out_122531.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_122531", "122531008", "story_v_out_122531.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_15 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_15 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_15

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_15 and arg_33_1.time_ < var_36_5 + var_36_15 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play122531009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 122531009
		arg_37_1.duration_ = 6.73

		local var_37_0 = {
			ja = 6.733,
			ko = 3.3,
			zh = 3.3
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play122531010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.475

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[319].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(122531009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 19
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531009", "story_v_out_122531.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531009", "story_v_out_122531.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_122531", "122531009", "story_v_out_122531.awb")

						arg_37_1:RecordAudio("122531009", var_40_9)
						arg_37_1:RecordAudio("122531009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_122531", "122531009", "story_v_out_122531.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_122531", "122531009", "story_v_out_122531.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play122531010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 122531010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play122531011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1029ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1029ui_story == nil then
				arg_41_1.var_.characterEffect1029ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1029ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1029ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1029ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1029ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.225

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(122531010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 9
				local var_44_12 = utf8.len(var_44_10)
				local var_44_13 = var_44_11 <= 0 and var_44_7 or var_44_7 * (var_44_12 / var_44_11)

				if var_44_13 > 0 and var_44_7 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play122531011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 122531011
		arg_45_1.duration_ = 5.83

		local var_45_0 = {
			ja = 5.833,
			ko = 2.5,
			zh = 2.5
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play122531012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1029ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1029ui_story == nil then
				arg_45_1.var_.characterEffect1029ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1029ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1029ui_story then
				arg_45_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_48_4 = 0
			local var_48_5 = 0.3

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_6 = arg_45_1:FormatText(StoryNameCfg[319].name)

				arg_45_1.leftNameTxt_.text = var_48_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:GetWordFromCfg(122531011)
				local var_48_8 = arg_45_1:FormatText(var_48_7.content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 12
				local var_48_10 = utf8.len(var_48_8)
				local var_48_11 = var_48_9 <= 0 and var_48_5 or var_48_5 * (var_48_10 / var_48_9)

				if var_48_11 > 0 and var_48_5 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531011", "story_v_out_122531.awb") ~= 0 then
					local var_48_12 = manager.audio:GetVoiceLength("story_v_out_122531", "122531011", "story_v_out_122531.awb") / 1000

					if var_48_12 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_4
					end

					if var_48_7.prefab_name ~= "" and arg_45_1.actors_[var_48_7.prefab_name] ~= nil then
						local var_48_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_7.prefab_name].transform, "story_v_out_122531", "122531011", "story_v_out_122531.awb")

						arg_45_1:RecordAudio("122531011", var_48_13)
						arg_45_1:RecordAudio("122531011", var_48_13)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_122531", "122531011", "story_v_out_122531.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_122531", "122531011", "story_v_out_122531.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_14 and arg_45_1.time_ < var_48_4 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play122531012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 122531012
		arg_49_1.duration_ = 11.63

		local var_49_0 = {
			ja = 11.633,
			ko = 4.933,
			zh = 4.933
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
				arg_49_0:Play122531013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action442")
			end

			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_52_2 = 0
			local var_52_3 = 0.525

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_4 = arg_49_1:FormatText(StoryNameCfg[319].name)

				arg_49_1.leftNameTxt_.text = var_52_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_5 = arg_49_1:GetWordFromCfg(122531012)
				local var_52_6 = arg_49_1:FormatText(var_52_5.content)

				arg_49_1.text_.text = var_52_6

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 21
				local var_52_8 = utf8.len(var_52_6)
				local var_52_9 = var_52_7 <= 0 and var_52_3 or var_52_3 * (var_52_8 / var_52_7)

				if var_52_9 > 0 and var_52_3 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_6
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531012", "story_v_out_122531.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_122531", "122531012", "story_v_out_122531.awb") / 1000

					if var_52_10 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_2
					end

					if var_52_5.prefab_name ~= "" and arg_49_1.actors_[var_52_5.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_5.prefab_name].transform, "story_v_out_122531", "122531012", "story_v_out_122531.awb")

						arg_49_1:RecordAudio("122531012", var_52_11)
						arg_49_1:RecordAudio("122531012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_122531", "122531012", "story_v_out_122531.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_122531", "122531012", "story_v_out_122531.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_12 and arg_49_1.time_ < var_52_2 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play122531013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 122531013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play122531014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1029ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1029ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, 100, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1029ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, 100, 0)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["1029ui_story"]
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1029ui_story == nil then
				arg_53_1.var_.characterEffect1029ui_story = var_56_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_11 = 0.200000002980232

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 and not isNil(var_56_9) then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11

				if arg_53_1.var_.characterEffect1029ui_story and not isNil(var_56_9) then
					local var_56_13 = Mathf.Lerp(0, 0.5, var_56_12)

					arg_53_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1029ui_story.fillRatio = var_56_13
				end
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1029ui_story then
				local var_56_14 = 0.5

				arg_53_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1029ui_story.fillRatio = var_56_14
			end

			local var_56_15 = 0
			local var_56_16 = 1.325

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_17 = arg_53_1:GetWordFromCfg(122531013)
				local var_56_18 = arg_53_1:FormatText(var_56_17.content)

				arg_53_1.text_.text = var_56_18

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_19 = 53
				local var_56_20 = utf8.len(var_56_18)
				local var_56_21 = var_56_19 <= 0 and var_56_16 or var_56_16 * (var_56_20 / var_56_19)

				if var_56_21 > 0 and var_56_16 < var_56_21 then
					arg_53_1.talkMaxDuration = var_56_21

					if var_56_21 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_21 + var_56_15
					end
				end

				arg_53_1.text_.text = var_56_18
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_22 = math.max(var_56_16, arg_53_1.talkMaxDuration)

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_22 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_15) / var_56_22

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_15 + var_56_22 and arg_53_1.time_ < var_56_15 + var_56_22 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play122531014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 122531014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play122531015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.375

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(122531014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 55
				local var_60_5 = utf8.len(var_60_3)
				local var_60_6 = var_60_4 <= 0 and var_60_1 or var_60_1 * (var_60_5 / var_60_4)

				if var_60_6 > 0 and var_60_1 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_7 and arg_57_1.time_ < var_60_0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play122531015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 122531015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play122531016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.275

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[7].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(122531015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 11
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_8 and arg_61_1.time_ < var_64_0 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play122531016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 122531016
		arg_65_1.duration_ = 6.5

		local var_65_0 = {
			ja = 6.5,
			ko = 6.233333333332,
			zh = 6.233333333332
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play122531017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = "ST42"

			if arg_65_1.bgs_[var_68_0] == nil then
				local var_68_1 = Object.Instantiate(arg_65_1.paintGo_)

				var_68_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_68_0)
				var_68_1.name = var_68_0
				var_68_1.transform.parent = arg_65_1.stage_.transform
				var_68_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_[var_68_0] = var_68_1
			end

			local var_68_2 = 1.999999999999

			if var_68_2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				local var_68_3 = manager.ui.mainCamera.transform.localPosition
				local var_68_4 = Vector3.New(0, 0, 10) + Vector3.New(var_68_3.x, var_68_3.y, 0)
				local var_68_5 = arg_65_1.bgs_.ST42

				var_68_5.transform.localPosition = var_68_4
				var_68_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_6 = var_68_5:GetComponent("SpriteRenderer")

				if var_68_6 and var_68_6.sprite then
					local var_68_7 = (var_68_5.transform.localPosition - var_68_3).z
					local var_68_8 = manager.ui.mainCameraCom_
					local var_68_9 = 2 * var_68_7 * Mathf.Tan(var_68_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_68_10 = var_68_9 * var_68_8.aspect
					local var_68_11 = var_68_6.sprite.bounds.size.x
					local var_68_12 = var_68_6.sprite.bounds.size.y
					local var_68_13 = var_68_10 / var_68_11
					local var_68_14 = var_68_9 / var_68_12
					local var_68_15 = var_68_14 < var_68_13 and var_68_13 or var_68_14

					var_68_5.transform.localScale = Vector3.New(var_68_15, var_68_15, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "ST42" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_17 = 2

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17
				local var_68_19 = Color.New(0, 0, 0)

				var_68_19.a = Mathf.Lerp(0, 1, var_68_18)
				arg_65_1.mask_.color = var_68_19
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 then
				local var_68_20 = Color.New(0, 0, 0)

				var_68_20.a = 1
				arg_65_1.mask_.color = var_68_20
			end

			local var_68_21 = 2

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_22 = 2

			if var_68_21 <= arg_65_1.time_ and arg_65_1.time_ < var_68_21 + var_68_22 then
				local var_68_23 = (arg_65_1.time_ - var_68_21) / var_68_22
				local var_68_24 = Color.New(0, 0, 0)

				var_68_24.a = Mathf.Lerp(1, 0, var_68_23)
				arg_65_1.mask_.color = var_68_24
			end

			if arg_65_1.time_ >= var_68_21 + var_68_22 and arg_65_1.time_ < var_68_21 + var_68_22 + arg_68_0 then
				local var_68_25 = Color.New(0, 0, 0)
				local var_68_26 = 0

				arg_65_1.mask_.enabled = false
				var_68_25.a = var_68_26
				arg_65_1.mask_.color = var_68_25
			end

			local var_68_27 = "1071ui_story"

			if arg_65_1.actors_[var_68_27] == nil then
				local var_68_28 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_68_28) then
					local var_68_29 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_65_1.stage_.transform)

					var_68_29.name = var_68_27
					var_68_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_65_1.actors_[var_68_27] = var_68_29

					local var_68_30 = var_68_29:GetComponentInChildren(typeof(CharacterEffect))

					var_68_30.enabled = true

					local var_68_31 = GameObjectTools.GetOrAddComponent(var_68_29, typeof(DynamicBoneHelper))

					if var_68_31 then
						var_68_31:EnableDynamicBone(false)
					end

					arg_65_1:ShowWeapon(var_68_30.transform, false)

					arg_65_1.var_[var_68_27 .. "Animator"] = var_68_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_65_1.var_[var_68_27 .. "Animator"].applyRootMotion = true
					arg_65_1.var_[var_68_27 .. "LipSync"] = var_68_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_68_32 = arg_65_1.actors_["1071ui_story"].transform
			local var_68_33 = 3.8

			if var_68_33 < arg_65_1.time_ and arg_65_1.time_ <= var_68_33 + arg_68_0 then
				arg_65_1.var_.moveOldPos1071ui_story = var_68_32.localPosition
			end

			local var_68_34 = 0.001

			if var_68_33 <= arg_65_1.time_ and arg_65_1.time_ < var_68_33 + var_68_34 then
				local var_68_35 = (arg_65_1.time_ - var_68_33) / var_68_34
				local var_68_36 = Vector3.New(0, -1.05, -6.2)

				var_68_32.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1071ui_story, var_68_36, var_68_35)

				local var_68_37 = manager.ui.mainCamera.transform.position - var_68_32.position

				var_68_32.forward = Vector3.New(var_68_37.x, var_68_37.y, var_68_37.z)

				local var_68_38 = var_68_32.localEulerAngles

				var_68_38.z = 0
				var_68_38.x = 0
				var_68_32.localEulerAngles = var_68_38
			end

			if arg_65_1.time_ >= var_68_33 + var_68_34 and arg_65_1.time_ < var_68_33 + var_68_34 + arg_68_0 then
				var_68_32.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_68_39 = manager.ui.mainCamera.transform.position - var_68_32.position

				var_68_32.forward = Vector3.New(var_68_39.x, var_68_39.y, var_68_39.z)

				local var_68_40 = var_68_32.localEulerAngles

				var_68_40.z = 0
				var_68_40.x = 0
				var_68_32.localEulerAngles = var_68_40
			end

			local var_68_41 = arg_65_1.actors_["1071ui_story"]
			local var_68_42 = 3.8

			if var_68_42 < arg_65_1.time_ and arg_65_1.time_ <= var_68_42 + arg_68_0 and not isNil(var_68_41) and arg_65_1.var_.characterEffect1071ui_story == nil then
				arg_65_1.var_.characterEffect1071ui_story = var_68_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_43 = 0.200000002980232

			if var_68_42 <= arg_65_1.time_ and arg_65_1.time_ < var_68_42 + var_68_43 and not isNil(var_68_41) then
				local var_68_44 = (arg_65_1.time_ - var_68_42) / var_68_43

				if arg_65_1.var_.characterEffect1071ui_story and not isNil(var_68_41) then
					arg_65_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_42 + var_68_43 and arg_65_1.time_ < var_68_42 + var_68_43 + arg_68_0 and not isNil(var_68_41) and arg_65_1.var_.characterEffect1071ui_story then
				arg_65_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_68_45 = 3.8

			if var_68_45 < arg_65_1.time_ and arg_65_1.time_ <= var_68_45 + arg_68_0 then
				arg_65_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_68_46 = 1.56666666666667

			if var_68_46 < arg_65_1.time_ and arg_65_1.time_ <= var_68_46 + arg_68_0 then
				arg_65_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_47 = 4
			local var_68_48 = 0.05

			if var_68_47 < arg_65_1.time_ and arg_65_1.time_ <= var_68_47 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_49 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_49:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_50 = arg_65_1:FormatText(StoryNameCfg[384].name)

				arg_65_1.leftNameTxt_.text = var_68_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_51 = arg_65_1:GetWordFromCfg(122531016)
				local var_68_52 = arg_65_1:FormatText(var_68_51.content)

				arg_65_1.text_.text = var_68_52

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_53 = 2
				local var_68_54 = utf8.len(var_68_52)
				local var_68_55 = var_68_53 <= 0 and var_68_48 or var_68_48 * (var_68_54 / var_68_53)

				if var_68_55 > 0 and var_68_48 < var_68_55 then
					arg_65_1.talkMaxDuration = var_68_55
					var_68_47 = var_68_47 + 0.3

					if var_68_55 + var_68_47 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_55 + var_68_47
					end
				end

				arg_65_1.text_.text = var_68_52
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531016", "story_v_out_122531.awb") ~= 0 then
					local var_68_56 = manager.audio:GetVoiceLength("story_v_out_122531", "122531016", "story_v_out_122531.awb") / 1000

					if var_68_56 + var_68_47 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_56 + var_68_47
					end

					if var_68_51.prefab_name ~= "" and arg_65_1.actors_[var_68_51.prefab_name] ~= nil then
						local var_68_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_51.prefab_name].transform, "story_v_out_122531", "122531016", "story_v_out_122531.awb")

						arg_65_1:RecordAudio("122531016", var_68_57)
						arg_65_1:RecordAudio("122531016", var_68_57)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_122531", "122531016", "story_v_out_122531.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_122531", "122531016", "story_v_out_122531.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_58 = var_68_47 + 0.3
			local var_68_59 = math.max(var_68_48, arg_65_1.talkMaxDuration)

			if var_68_58 <= arg_65_1.time_ and arg_65_1.time_ < var_68_58 + var_68_59 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_58) / var_68_59

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_58 + var_68_59 and arg_65_1.time_ < var_68_58 + var_68_59 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play122531017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 122531017
		arg_71_1.duration_ = 3.83

		local var_71_0 = {
			ja = 3.833,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play122531018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_74_1 = 0
			local var_74_2 = 0.225

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_3 = arg_71_1:FormatText(StoryNameCfg[384].name)

				arg_71_1.leftNameTxt_.text = var_74_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_4 = arg_71_1:GetWordFromCfg(122531017)
				local var_74_5 = arg_71_1:FormatText(var_74_4.content)

				arg_71_1.text_.text = var_74_5

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_6 = 9
				local var_74_7 = utf8.len(var_74_5)
				local var_74_8 = var_74_6 <= 0 and var_74_2 or var_74_2 * (var_74_7 / var_74_6)

				if var_74_8 > 0 and var_74_2 < var_74_8 then
					arg_71_1.talkMaxDuration = var_74_8

					if var_74_8 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_5
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531017", "story_v_out_122531.awb") ~= 0 then
					local var_74_9 = manager.audio:GetVoiceLength("story_v_out_122531", "122531017", "story_v_out_122531.awb") / 1000

					if var_74_9 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_1
					end

					if var_74_4.prefab_name ~= "" and arg_71_1.actors_[var_74_4.prefab_name] ~= nil then
						local var_74_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_4.prefab_name].transform, "story_v_out_122531", "122531017", "story_v_out_122531.awb")

						arg_71_1:RecordAudio("122531017", var_74_10)
						arg_71_1:RecordAudio("122531017", var_74_10)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_122531", "122531017", "story_v_out_122531.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_122531", "122531017", "story_v_out_122531.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_11 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_11 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_11

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_11 and arg_71_1.time_ < var_74_1 + var_74_11 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play122531018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 122531018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play122531019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1071ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1071ui_story == nil then
				arg_75_1.var_.characterEffect1071ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1071ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1071ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1071ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1071ui_story.fillRatio = var_78_5
			end

			local var_78_6 = 0
			local var_78_7 = 0.475

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_8 = arg_75_1:FormatText(StoryNameCfg[7].name)

				arg_75_1.leftNameTxt_.text = var_78_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_9 = arg_75_1:GetWordFromCfg(122531018)
				local var_78_10 = arg_75_1:FormatText(var_78_9.content)

				arg_75_1.text_.text = var_78_10

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_11 = 19
				local var_78_12 = utf8.len(var_78_10)
				local var_78_13 = var_78_11 <= 0 and var_78_7 or var_78_7 * (var_78_12 / var_78_11)

				if var_78_13 > 0 and var_78_7 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_10
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_14 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_14 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_14

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_14 and arg_75_1.time_ < var_78_6 + var_78_14 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play122531019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 122531019
		arg_79_1.duration_ = 12.33

		local var_79_0 = {
			ja = 12.333,
			ko = 7.266,
			zh = 7.266
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play122531020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1071ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1071ui_story == nil then
				arg_79_1.var_.characterEffect1071ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect1071ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1071ui_story then
				arg_79_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_82_4 = 0

			if var_82_4 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_82_5 = 0
			local var_82_6 = 0.8

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_7 = arg_79_1:FormatText(StoryNameCfg[384].name)

				arg_79_1.leftNameTxt_.text = var_82_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_8 = arg_79_1:GetWordFromCfg(122531019)
				local var_82_9 = arg_79_1:FormatText(var_82_8.content)

				arg_79_1.text_.text = var_82_9

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_10 = 32
				local var_82_11 = utf8.len(var_82_9)
				local var_82_12 = var_82_10 <= 0 and var_82_6 or var_82_6 * (var_82_11 / var_82_10)

				if var_82_12 > 0 and var_82_6 < var_82_12 then
					arg_79_1.talkMaxDuration = var_82_12

					if var_82_12 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_5
					end
				end

				arg_79_1.text_.text = var_82_9
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531019", "story_v_out_122531.awb") ~= 0 then
					local var_82_13 = manager.audio:GetVoiceLength("story_v_out_122531", "122531019", "story_v_out_122531.awb") / 1000

					if var_82_13 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_5
					end

					if var_82_8.prefab_name ~= "" and arg_79_1.actors_[var_82_8.prefab_name] ~= nil then
						local var_82_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_8.prefab_name].transform, "story_v_out_122531", "122531019", "story_v_out_122531.awb")

						arg_79_1:RecordAudio("122531019", var_82_14)
						arg_79_1:RecordAudio("122531019", var_82_14)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_122531", "122531019", "story_v_out_122531.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_122531", "122531019", "story_v_out_122531.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_15 = math.max(var_82_6, arg_79_1.talkMaxDuration)

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_15 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_5) / var_82_15

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_5 + var_82_15 and arg_79_1.time_ < var_82_5 + var_82_15 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play122531020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 122531020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play122531021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1071ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1071ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, 100, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1071ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, 100, 0)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = arg_83_1.actors_["1071ui_story"]
			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 and not isNil(var_86_9) and arg_83_1.var_.characterEffect1071ui_story == nil then
				arg_83_1.var_.characterEffect1071ui_story = var_86_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_11 = 0.200000002980232

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_11 and not isNil(var_86_9) then
				local var_86_12 = (arg_83_1.time_ - var_86_10) / var_86_11

				if arg_83_1.var_.characterEffect1071ui_story and not isNil(var_86_9) then
					local var_86_13 = Mathf.Lerp(0, 0.5, var_86_12)

					arg_83_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1071ui_story.fillRatio = var_86_13
				end
			end

			if arg_83_1.time_ >= var_86_10 + var_86_11 and arg_83_1.time_ < var_86_10 + var_86_11 + arg_86_0 and not isNil(var_86_9) and arg_83_1.var_.characterEffect1071ui_story then
				local var_86_14 = 0.5

				arg_83_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1071ui_story.fillRatio = var_86_14
			end

			local var_86_15 = 0
			local var_86_16 = 0.95

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_17 = arg_83_1:GetWordFromCfg(122531020)
				local var_86_18 = arg_83_1:FormatText(var_86_17.content)

				arg_83_1.text_.text = var_86_18

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_19 = 38
				local var_86_20 = utf8.len(var_86_18)
				local var_86_21 = var_86_19 <= 0 and var_86_16 or var_86_16 * (var_86_20 / var_86_19)

				if var_86_21 > 0 and var_86_16 < var_86_21 then
					arg_83_1.talkMaxDuration = var_86_21

					if var_86_21 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_21 + var_86_15
					end
				end

				arg_83_1.text_.text = var_86_18
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_22 = math.max(var_86_16, arg_83_1.talkMaxDuration)

			if var_86_15 <= arg_83_1.time_ and arg_83_1.time_ < var_86_15 + var_86_22 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_15) / var_86_22

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_15 + var_86_22 and arg_83_1.time_ < var_86_15 + var_86_22 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play122531021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 122531021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play122531022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.5

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[7].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:GetWordFromCfg(122531021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 20
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_8 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_8 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_8

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_8 and arg_87_1.time_ < var_90_0 + var_90_8 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play122531022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 122531022
		arg_91_1.duration_ = 17.23

		local var_91_0 = {
			ja = 17.233,
			ko = 8.8,
			zh = 8.8
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play122531023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1071ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1071ui_story == nil then
				arg_91_1.var_.characterEffect1071ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1071ui_story and not isNil(var_94_0) then
					arg_91_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1071ui_story then
				arg_91_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_94_4 = 0

			if var_94_4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_2")
			end

			local var_94_5 = arg_91_1.actors_["1071ui_story"].transform
			local var_94_6 = 0

			if var_94_6 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.var_.moveOldPos1071ui_story = var_94_5.localPosition
			end

			local var_94_7 = 0.001

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_7 then
				local var_94_8 = (arg_91_1.time_ - var_94_6) / var_94_7
				local var_94_9 = Vector3.New(0, -1.05, -6.2)

				var_94_5.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1071ui_story, var_94_9, var_94_8)

				local var_94_10 = manager.ui.mainCamera.transform.position - var_94_5.position

				var_94_5.forward = Vector3.New(var_94_10.x, var_94_10.y, var_94_10.z)

				local var_94_11 = var_94_5.localEulerAngles

				var_94_11.z = 0
				var_94_11.x = 0
				var_94_5.localEulerAngles = var_94_11
			end

			if arg_91_1.time_ >= var_94_6 + var_94_7 and arg_91_1.time_ < var_94_6 + var_94_7 + arg_94_0 then
				var_94_5.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_94_12 = manager.ui.mainCamera.transform.position - var_94_5.position

				var_94_5.forward = Vector3.New(var_94_12.x, var_94_12.y, var_94_12.z)

				local var_94_13 = var_94_5.localEulerAngles

				var_94_13.z = 0
				var_94_13.x = 0
				var_94_5.localEulerAngles = var_94_13
			end

			local var_94_14 = 0
			local var_94_15 = 0.75

			if var_94_14 < arg_91_1.time_ and arg_91_1.time_ <= var_94_14 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_16 = arg_91_1:FormatText(StoryNameCfg[384].name)

				arg_91_1.leftNameTxt_.text = var_94_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_17 = arg_91_1:GetWordFromCfg(122531022)
				local var_94_18 = arg_91_1:FormatText(var_94_17.content)

				arg_91_1.text_.text = var_94_18

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_19 = 30
				local var_94_20 = utf8.len(var_94_18)
				local var_94_21 = var_94_19 <= 0 and var_94_15 or var_94_15 * (var_94_20 / var_94_19)

				if var_94_21 > 0 and var_94_15 < var_94_21 then
					arg_91_1.talkMaxDuration = var_94_21

					if var_94_21 + var_94_14 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_21 + var_94_14
					end
				end

				arg_91_1.text_.text = var_94_18
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531022", "story_v_out_122531.awb") ~= 0 then
					local var_94_22 = manager.audio:GetVoiceLength("story_v_out_122531", "122531022", "story_v_out_122531.awb") / 1000

					if var_94_22 + var_94_14 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_22 + var_94_14
					end

					if var_94_17.prefab_name ~= "" and arg_91_1.actors_[var_94_17.prefab_name] ~= nil then
						local var_94_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_17.prefab_name].transform, "story_v_out_122531", "122531022", "story_v_out_122531.awb")

						arg_91_1:RecordAudio("122531022", var_94_23)
						arg_91_1:RecordAudio("122531022", var_94_23)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_122531", "122531022", "story_v_out_122531.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_122531", "122531022", "story_v_out_122531.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_24 = math.max(var_94_15, arg_91_1.talkMaxDuration)

			if var_94_14 <= arg_91_1.time_ and arg_91_1.time_ < var_94_14 + var_94_24 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_14) / var_94_24

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_14 + var_94_24 and arg_91_1.time_ < var_94_14 + var_94_24 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play122531023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 122531023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play122531024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1071ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1071ui_story == nil then
				arg_95_1.var_.characterEffect1071ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1071ui_story and not isNil(var_98_0) then
					local var_98_4 = Mathf.Lerp(0, 0.5, var_98_3)

					arg_95_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1071ui_story.fillRatio = var_98_4
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1071ui_story then
				local var_98_5 = 0.5

				arg_95_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1071ui_story.fillRatio = var_98_5
			end

			local var_98_6 = 0
			local var_98_7 = 0.35

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_8 = arg_95_1:FormatText(StoryNameCfg[7].name)

				arg_95_1.leftNameTxt_.text = var_98_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_9 = arg_95_1:GetWordFromCfg(122531023)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 14
				local var_98_12 = utf8.len(var_98_10)
				local var_98_13 = var_98_11 <= 0 and var_98_7 or var_98_7 * (var_98_12 / var_98_11)

				if var_98_13 > 0 and var_98_7 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_14 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_14 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_14

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_14 and arg_95_1.time_ < var_98_6 + var_98_14 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play122531024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 122531024
		arg_99_1.duration_ = 2.53

		local var_99_0 = {
			ja = 2.533,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play122531025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1071ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1071ui_story == nil then
				arg_99_1.var_.characterEffect1071ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect1071ui_story and not isNil(var_102_0) then
					arg_99_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1071ui_story then
				arg_99_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_102_4 = 0

			if var_102_4 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_102_5 = 0
			local var_102_6 = 0.075

			if var_102_5 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_7 = arg_99_1:FormatText(StoryNameCfg[384].name)

				arg_99_1.leftNameTxt_.text = var_102_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_8 = arg_99_1:GetWordFromCfg(122531024)
				local var_102_9 = arg_99_1:FormatText(var_102_8.content)

				arg_99_1.text_.text = var_102_9

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_10 = 3
				local var_102_11 = utf8.len(var_102_9)
				local var_102_12 = var_102_10 <= 0 and var_102_6 or var_102_6 * (var_102_11 / var_102_10)

				if var_102_12 > 0 and var_102_6 < var_102_12 then
					arg_99_1.talkMaxDuration = var_102_12

					if var_102_12 + var_102_5 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_12 + var_102_5
					end
				end

				arg_99_1.text_.text = var_102_9
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531024", "story_v_out_122531.awb") ~= 0 then
					local var_102_13 = manager.audio:GetVoiceLength("story_v_out_122531", "122531024", "story_v_out_122531.awb") / 1000

					if var_102_13 + var_102_5 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_13 + var_102_5
					end

					if var_102_8.prefab_name ~= "" and arg_99_1.actors_[var_102_8.prefab_name] ~= nil then
						local var_102_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_8.prefab_name].transform, "story_v_out_122531", "122531024", "story_v_out_122531.awb")

						arg_99_1:RecordAudio("122531024", var_102_14)
						arg_99_1:RecordAudio("122531024", var_102_14)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_122531", "122531024", "story_v_out_122531.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_122531", "122531024", "story_v_out_122531.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_15 = math.max(var_102_6, arg_99_1.talkMaxDuration)

			if var_102_5 <= arg_99_1.time_ and arg_99_1.time_ < var_102_5 + var_102_15 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_5) / var_102_15

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_5 + var_102_15 and arg_99_1.time_ < var_102_5 + var_102_15 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play122531025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 122531025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play122531026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1071ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1071ui_story == nil then
				arg_103_1.var_.characterEffect1071ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1071ui_story and not isNil(var_106_0) then
					local var_106_4 = Mathf.Lerp(0, 0.5, var_106_3)

					arg_103_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1071ui_story.fillRatio = var_106_4
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1071ui_story then
				local var_106_5 = 0.5

				arg_103_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1071ui_story.fillRatio = var_106_5
			end

			local var_106_6 = 0
			local var_106_7 = 0.475

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_8 = arg_103_1:FormatText(StoryNameCfg[7].name)

				arg_103_1.leftNameTxt_.text = var_106_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_9 = arg_103_1:GetWordFromCfg(122531025)
				local var_106_10 = arg_103_1:FormatText(var_106_9.content)

				arg_103_1.text_.text = var_106_10

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_11 = 19
				local var_106_12 = utf8.len(var_106_10)
				local var_106_13 = var_106_11 <= 0 and var_106_7 or var_106_7 * (var_106_12 / var_106_11)

				if var_106_13 > 0 and var_106_7 < var_106_13 then
					arg_103_1.talkMaxDuration = var_106_13

					if var_106_13 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_6
					end
				end

				arg_103_1.text_.text = var_106_10
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_14 = math.max(var_106_7, arg_103_1.talkMaxDuration)

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_14 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_6) / var_106_14

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_6 + var_106_14 and arg_103_1.time_ < var_106_6 + var_106_14 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play122531026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 122531026
		arg_107_1.duration_ = 6

		local var_107_0 = {
			ja = 6,
			ko = 3.966,
			zh = 3.966
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play122531027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1071ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1071ui_story == nil then
				arg_107_1.var_.characterEffect1071ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect1071ui_story and not isNil(var_110_0) then
					arg_107_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1071ui_story then
				arg_107_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_110_4 = 0

			if var_110_4 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_110_5 = 0
			local var_110_6 = 0.5

			if var_110_5 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_7 = arg_107_1:FormatText(StoryNameCfg[384].name)

				arg_107_1.leftNameTxt_.text = var_110_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_8 = arg_107_1:GetWordFromCfg(122531026)
				local var_110_9 = arg_107_1:FormatText(var_110_8.content)

				arg_107_1.text_.text = var_110_9

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_10 = 20
				local var_110_11 = utf8.len(var_110_9)
				local var_110_12 = var_110_10 <= 0 and var_110_6 or var_110_6 * (var_110_11 / var_110_10)

				if var_110_12 > 0 and var_110_6 < var_110_12 then
					arg_107_1.talkMaxDuration = var_110_12

					if var_110_12 + var_110_5 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_12 + var_110_5
					end
				end

				arg_107_1.text_.text = var_110_9
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531026", "story_v_out_122531.awb") ~= 0 then
					local var_110_13 = manager.audio:GetVoiceLength("story_v_out_122531", "122531026", "story_v_out_122531.awb") / 1000

					if var_110_13 + var_110_5 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_5
					end

					if var_110_8.prefab_name ~= "" and arg_107_1.actors_[var_110_8.prefab_name] ~= nil then
						local var_110_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_8.prefab_name].transform, "story_v_out_122531", "122531026", "story_v_out_122531.awb")

						arg_107_1:RecordAudio("122531026", var_110_14)
						arg_107_1:RecordAudio("122531026", var_110_14)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_122531", "122531026", "story_v_out_122531.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_122531", "122531026", "story_v_out_122531.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_15 = math.max(var_110_6, arg_107_1.talkMaxDuration)

			if var_110_5 <= arg_107_1.time_ and arg_107_1.time_ < var_110_5 + var_110_15 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_5) / var_110_15

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_5 + var_110_15 and arg_107_1.time_ < var_110_5 + var_110_15 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play122531027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 122531027
		arg_111_1.duration_ = 19.3

		local var_111_0 = {
			ja = 19.3,
			ko = 10.933,
			zh = 10.933
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play122531028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 1.2

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[384].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(122531027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 48
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531027", "story_v_out_122531.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531027", "story_v_out_122531.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_122531", "122531027", "story_v_out_122531.awb")

						arg_111_1:RecordAudio("122531027", var_114_9)
						arg_111_1:RecordAudio("122531027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_122531", "122531027", "story_v_out_122531.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_122531", "122531027", "story_v_out_122531.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_10 and arg_111_1.time_ < var_114_0 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play122531028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 122531028
		arg_115_1.duration_ = 18.4

		local var_115_0 = {
			ja = 18.4,
			ko = 10.633,
			zh = 10.633
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play122531029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 1.25

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[384].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:GetWordFromCfg(122531028)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 50
				local var_118_6 = utf8.len(var_118_4)
				local var_118_7 = var_118_5 <= 0 and var_118_1 or var_118_1 * (var_118_6 / var_118_5)

				if var_118_7 > 0 and var_118_1 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531028", "story_v_out_122531.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531028", "story_v_out_122531.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_122531", "122531028", "story_v_out_122531.awb")

						arg_115_1:RecordAudio("122531028", var_118_9)
						arg_115_1:RecordAudio("122531028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_122531", "122531028", "story_v_out_122531.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_122531", "122531028", "story_v_out_122531.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_10 and arg_115_1.time_ < var_118_0 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play122531029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 122531029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play122531030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1071ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1071ui_story == nil then
				arg_119_1.var_.characterEffect1071ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect1071ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1071ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1071ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1071ui_story.fillRatio = var_122_5
			end

			local var_122_6 = 0
			local var_122_7 = 0.875

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_8 = arg_119_1:FormatText(StoryNameCfg[7].name)

				arg_119_1.leftNameTxt_.text = var_122_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_9 = arg_119_1:GetWordFromCfg(122531029)
				local var_122_10 = arg_119_1:FormatText(var_122_9.content)

				arg_119_1.text_.text = var_122_10

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 35
				local var_122_12 = utf8.len(var_122_10)
				local var_122_13 = var_122_11 <= 0 and var_122_7 or var_122_7 * (var_122_12 / var_122_11)

				if var_122_13 > 0 and var_122_7 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_10
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_14 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_14 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_14

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_14 and arg_119_1.time_ < var_122_6 + var_122_14 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play122531030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 122531030
		arg_123_1.duration_ = 4.1

		local var_123_0 = {
			ja = 4.1,
			ko = 2.133,
			zh = 2.133
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play122531031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1071ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1071ui_story == nil then
				arg_123_1.var_.characterEffect1071ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1071ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1071ui_story then
				arg_123_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_126_4 = 0

			if var_126_4 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_126_5 = 0
			local var_126_6 = 0.25

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_7 = arg_123_1:FormatText(StoryNameCfg[384].name)

				arg_123_1.leftNameTxt_.text = var_126_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_8 = arg_123_1:GetWordFromCfg(122531030)
				local var_126_9 = arg_123_1:FormatText(var_126_8.content)

				arg_123_1.text_.text = var_126_9

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_10 = 10
				local var_126_11 = utf8.len(var_126_9)
				local var_126_12 = var_126_10 <= 0 and var_126_6 or var_126_6 * (var_126_11 / var_126_10)

				if var_126_12 > 0 and var_126_6 < var_126_12 then
					arg_123_1.talkMaxDuration = var_126_12

					if var_126_12 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_12 + var_126_5
					end
				end

				arg_123_1.text_.text = var_126_9
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531030", "story_v_out_122531.awb") ~= 0 then
					local var_126_13 = manager.audio:GetVoiceLength("story_v_out_122531", "122531030", "story_v_out_122531.awb") / 1000

					if var_126_13 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_5
					end

					if var_126_8.prefab_name ~= "" and arg_123_1.actors_[var_126_8.prefab_name] ~= nil then
						local var_126_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_8.prefab_name].transform, "story_v_out_122531", "122531030", "story_v_out_122531.awb")

						arg_123_1:RecordAudio("122531030", var_126_14)
						arg_123_1:RecordAudio("122531030", var_126_14)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_122531", "122531030", "story_v_out_122531.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_122531", "122531030", "story_v_out_122531.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_15 = math.max(var_126_6, arg_123_1.talkMaxDuration)

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_15 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_5) / var_126_15

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_5 + var_126_15 and arg_123_1.time_ < var_126_5 + var_126_15 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play122531031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 122531031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play122531032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1071ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1071ui_story == nil then
				arg_127_1.var_.characterEffect1071ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect1071ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1071ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1071ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1071ui_story.fillRatio = var_130_5
			end

			local var_130_6 = 0
			local var_130_7 = 0.575

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_8 = arg_127_1:FormatText(StoryNameCfg[7].name)

				arg_127_1.leftNameTxt_.text = var_130_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_9 = arg_127_1:GetWordFromCfg(122531031)
				local var_130_10 = arg_127_1:FormatText(var_130_9.content)

				arg_127_1.text_.text = var_130_10

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 23
				local var_130_12 = utf8.len(var_130_10)
				local var_130_13 = var_130_11 <= 0 and var_130_7 or var_130_7 * (var_130_12 / var_130_11)

				if var_130_13 > 0 and var_130_7 < var_130_13 then
					arg_127_1.talkMaxDuration = var_130_13

					if var_130_13 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_10
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_14 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_14 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_14

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_14 and arg_127_1.time_ < var_130_6 + var_130_14 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play122531032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 122531032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play122531033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.775

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(122531032)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 31
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play122531033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 122531033
		arg_135_1.duration_ = 10.43

		local var_135_0 = {
			ja = 10.433,
			ko = 4.5,
			zh = 4.5
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play122531034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1071ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1071ui_story == nil then
				arg_135_1.var_.characterEffect1071ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1071ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1071ui_story then
				arg_135_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_138_4 = 0

			if var_138_4 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action436")
			end

			local var_138_5 = 0
			local var_138_6 = 0.4

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_7 = arg_135_1:FormatText(StoryNameCfg[384].name)

				arg_135_1.leftNameTxt_.text = var_138_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_8 = arg_135_1:GetWordFromCfg(122531033)
				local var_138_9 = arg_135_1:FormatText(var_138_8.content)

				arg_135_1.text_.text = var_138_9

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_10 = 16
				local var_138_11 = utf8.len(var_138_9)
				local var_138_12 = var_138_10 <= 0 and var_138_6 or var_138_6 * (var_138_11 / var_138_10)

				if var_138_12 > 0 and var_138_6 < var_138_12 then
					arg_135_1.talkMaxDuration = var_138_12

					if var_138_12 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_12 + var_138_5
					end
				end

				arg_135_1.text_.text = var_138_9
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531033", "story_v_out_122531.awb") ~= 0 then
					local var_138_13 = manager.audio:GetVoiceLength("story_v_out_122531", "122531033", "story_v_out_122531.awb") / 1000

					if var_138_13 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_5
					end

					if var_138_8.prefab_name ~= "" and arg_135_1.actors_[var_138_8.prefab_name] ~= nil then
						local var_138_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_8.prefab_name].transform, "story_v_out_122531", "122531033", "story_v_out_122531.awb")

						arg_135_1:RecordAudio("122531033", var_138_14)
						arg_135_1:RecordAudio("122531033", var_138_14)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_122531", "122531033", "story_v_out_122531.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_122531", "122531033", "story_v_out_122531.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_15 = math.max(var_138_6, arg_135_1.talkMaxDuration)

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_15 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_5) / var_138_15

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_5 + var_138_15 and arg_135_1.time_ < var_138_5 + var_138_15 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play122531034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 122531034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play122531035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1071ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1071ui_story == nil then
				arg_139_1.var_.characterEffect1071ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1071ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1071ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1071ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1071ui_story.fillRatio = var_142_5
			end

			local var_142_6 = 0
			local var_142_7 = 0.1

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_8 = arg_139_1:FormatText(StoryNameCfg[7].name)

				arg_139_1.leftNameTxt_.text = var_142_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_9 = arg_139_1:GetWordFromCfg(122531034)
				local var_142_10 = arg_139_1:FormatText(var_142_9.content)

				arg_139_1.text_.text = var_142_10

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 4
				local var_142_12 = utf8.len(var_142_10)
				local var_142_13 = var_142_11 <= 0 and var_142_7 or var_142_7 * (var_142_12 / var_142_11)

				if var_142_13 > 0 and var_142_7 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_10
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_14 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_14 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_14

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_14 and arg_139_1.time_ < var_142_6 + var_142_14 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play122531035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 122531035
		arg_143_1.duration_ = 19.6

		local var_143_0 = {
			ja = 19.6,
			ko = 8.233,
			zh = 8.233
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play122531036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1071ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1071ui_story == nil then
				arg_143_1.var_.characterEffect1071ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1071ui_story and not isNil(var_146_0) then
					arg_143_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1071ui_story then
				arg_143_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_146_4 = 0

			if var_146_4 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action463")
			end

			local var_146_5 = 0
			local var_146_6 = 1.075

			if var_146_5 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_7 = arg_143_1:FormatText(StoryNameCfg[384].name)

				arg_143_1.leftNameTxt_.text = var_146_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_8 = arg_143_1:GetWordFromCfg(122531035)
				local var_146_9 = arg_143_1:FormatText(var_146_8.content)

				arg_143_1.text_.text = var_146_9

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_10 = 43
				local var_146_11 = utf8.len(var_146_9)
				local var_146_12 = var_146_10 <= 0 and var_146_6 or var_146_6 * (var_146_11 / var_146_10)

				if var_146_12 > 0 and var_146_6 < var_146_12 then
					arg_143_1.talkMaxDuration = var_146_12

					if var_146_12 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_12 + var_146_5
					end
				end

				arg_143_1.text_.text = var_146_9
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531035", "story_v_out_122531.awb") ~= 0 then
					local var_146_13 = manager.audio:GetVoiceLength("story_v_out_122531", "122531035", "story_v_out_122531.awb") / 1000

					if var_146_13 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_5
					end

					if var_146_8.prefab_name ~= "" and arg_143_1.actors_[var_146_8.prefab_name] ~= nil then
						local var_146_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_8.prefab_name].transform, "story_v_out_122531", "122531035", "story_v_out_122531.awb")

						arg_143_1:RecordAudio("122531035", var_146_14)
						arg_143_1:RecordAudio("122531035", var_146_14)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_122531", "122531035", "story_v_out_122531.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_122531", "122531035", "story_v_out_122531.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_15 = math.max(var_146_6, arg_143_1.talkMaxDuration)

			if var_146_5 <= arg_143_1.time_ and arg_143_1.time_ < var_146_5 + var_146_15 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_5) / var_146_15

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_5 + var_146_15 and arg_143_1.time_ < var_146_5 + var_146_15 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play122531036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 122531036
		arg_147_1.duration_ = 16.9

		local var_147_0 = {
			ja = 16.9,
			ko = 12.7,
			zh = 12.7
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play122531037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1.375

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[384].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(122531036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 55
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531036", "story_v_out_122531.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531036", "story_v_out_122531.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_122531", "122531036", "story_v_out_122531.awb")

						arg_147_1:RecordAudio("122531036", var_150_9)
						arg_147_1:RecordAudio("122531036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_122531", "122531036", "story_v_out_122531.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_122531", "122531036", "story_v_out_122531.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_10 and arg_147_1.time_ < var_150_0 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play122531037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 122531037
		arg_151_1.duration_ = 13.9

		local var_151_0 = {
			ja = 13.9,
			ko = 12.166,
			zh = 12.166
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play122531038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 1.25

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[384].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:GetWordFromCfg(122531037)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 50
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531037", "story_v_out_122531.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531037", "story_v_out_122531.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_122531", "122531037", "story_v_out_122531.awb")

						arg_151_1:RecordAudio("122531037", var_154_9)
						arg_151_1:RecordAudio("122531037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_122531", "122531037", "story_v_out_122531.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_122531", "122531037", "story_v_out_122531.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_10 and arg_151_1.time_ < var_154_0 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play122531038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 122531038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play122531039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1071ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1071ui_story == nil then
				arg_155_1.var_.characterEffect1071ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1071ui_story and not isNil(var_158_0) then
					local var_158_4 = Mathf.Lerp(0, 0.5, var_158_3)

					arg_155_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1071ui_story.fillRatio = var_158_4
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1071ui_story then
				local var_158_5 = 0.5

				arg_155_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1071ui_story.fillRatio = var_158_5
			end

			local var_158_6 = 0
			local var_158_7 = 0.45

			if var_158_6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_8 = arg_155_1:FormatText(StoryNameCfg[7].name)

				arg_155_1.leftNameTxt_.text = var_158_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_9 = arg_155_1:GetWordFromCfg(122531038)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 18
				local var_158_12 = utf8.len(var_158_10)
				local var_158_13 = var_158_11 <= 0 and var_158_7 or var_158_7 * (var_158_12 / var_158_11)

				if var_158_13 > 0 and var_158_7 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_10
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_14 and arg_155_1.time_ < var_158_6 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play122531039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 122531039
		arg_159_1.duration_ = 8

		local var_159_0 = {
			ja = 7.233,
			ko = 8,
			zh = 8
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play122531040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1071ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1071ui_story == nil then
				arg_159_1.var_.characterEffect1071ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect1071ui_story and not isNil(var_162_0) then
					arg_159_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1071ui_story then
				arg_159_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_162_4 = 0

			if var_162_4 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_2")
			end

			local var_162_5 = 0
			local var_162_6 = 0.675

			if var_162_5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_7 = arg_159_1:FormatText(StoryNameCfg[384].name)

				arg_159_1.leftNameTxt_.text = var_162_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_8 = arg_159_1:GetWordFromCfg(122531039)
				local var_162_9 = arg_159_1:FormatText(var_162_8.content)

				arg_159_1.text_.text = var_162_9

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_10 = 27
				local var_162_11 = utf8.len(var_162_9)
				local var_162_12 = var_162_10 <= 0 and var_162_6 or var_162_6 * (var_162_11 / var_162_10)

				if var_162_12 > 0 and var_162_6 < var_162_12 then
					arg_159_1.talkMaxDuration = var_162_12

					if var_162_12 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_5
					end
				end

				arg_159_1.text_.text = var_162_9
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531039", "story_v_out_122531.awb") ~= 0 then
					local var_162_13 = manager.audio:GetVoiceLength("story_v_out_122531", "122531039", "story_v_out_122531.awb") / 1000

					if var_162_13 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_5
					end

					if var_162_8.prefab_name ~= "" and arg_159_1.actors_[var_162_8.prefab_name] ~= nil then
						local var_162_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_8.prefab_name].transform, "story_v_out_122531", "122531039", "story_v_out_122531.awb")

						arg_159_1:RecordAudio("122531039", var_162_14)
						arg_159_1:RecordAudio("122531039", var_162_14)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_122531", "122531039", "story_v_out_122531.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_122531", "122531039", "story_v_out_122531.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_15 = math.max(var_162_6, arg_159_1.talkMaxDuration)

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_15 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_5) / var_162_15

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_5 + var_162_15 and arg_159_1.time_ < var_162_5 + var_162_15 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play122531040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 122531040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play122531041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1071ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1071ui_story == nil then
				arg_163_1.var_.characterEffect1071ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1071ui_story and not isNil(var_166_0) then
					local var_166_4 = Mathf.Lerp(0, 0.5, var_166_3)

					arg_163_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1071ui_story.fillRatio = var_166_4
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1071ui_story then
				local var_166_5 = 0.5

				arg_163_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1071ui_story.fillRatio = var_166_5
			end

			local var_166_6 = 0
			local var_166_7 = 1.175

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_8 = arg_163_1:FormatText(StoryNameCfg[7].name)

				arg_163_1.leftNameTxt_.text = var_166_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_9 = arg_163_1:GetWordFromCfg(122531040)
				local var_166_10 = arg_163_1:FormatText(var_166_9.content)

				arg_163_1.text_.text = var_166_10

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 47
				local var_166_12 = utf8.len(var_166_10)
				local var_166_13 = var_166_11 <= 0 and var_166_7 or var_166_7 * (var_166_12 / var_166_11)

				if var_166_13 > 0 and var_166_7 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_10
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_14 and arg_163_1.time_ < var_166_6 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play122531041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 122531041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play122531042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.25

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[7].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(122531041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 10
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_8 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_8 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_8

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_8 and arg_167_1.time_ < var_170_0 + var_170_8 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play122531042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 122531042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play122531043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.725

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_2 = arg_171_1:GetWordFromCfg(122531042)
				local var_174_3 = arg_171_1:FormatText(var_174_2.content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 29
				local var_174_5 = utf8.len(var_174_3)
				local var_174_6 = var_174_4 <= 0 and var_174_1 or var_174_1 * (var_174_5 / var_174_4)

				if var_174_6 > 0 and var_174_1 < var_174_6 then
					arg_171_1.talkMaxDuration = var_174_6

					if var_174_6 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_6 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_7 and arg_171_1.time_ < var_174_0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play122531043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 122531043
		arg_175_1.duration_ = 13.33

		local var_175_0 = {
			ja = 13.333,
			ko = 8.366,
			zh = 8.366
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
				arg_175_0:Play122531044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1071ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1071ui_story == nil then
				arg_175_1.var_.characterEffect1071ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1071ui_story and not isNil(var_178_0) then
					arg_175_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1071ui_story then
				arg_175_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_178_4 = 0
			local var_178_5 = 1.05

			if var_178_4 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_6 = arg_175_1:FormatText(StoryNameCfg[384].name)

				arg_175_1.leftNameTxt_.text = var_178_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_7 = arg_175_1:GetWordFromCfg(122531043)
				local var_178_8 = arg_175_1:FormatText(var_178_7.content)

				arg_175_1.text_.text = var_178_8

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 42
				local var_178_10 = utf8.len(var_178_8)
				local var_178_11 = var_178_9 <= 0 and var_178_5 or var_178_5 * (var_178_10 / var_178_9)

				if var_178_11 > 0 and var_178_5 < var_178_11 then
					arg_175_1.talkMaxDuration = var_178_11

					if var_178_11 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_11 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_8
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531043", "story_v_out_122531.awb") ~= 0 then
					local var_178_12 = manager.audio:GetVoiceLength("story_v_out_122531", "122531043", "story_v_out_122531.awb") / 1000

					if var_178_12 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_12 + var_178_4
					end

					if var_178_7.prefab_name ~= "" and arg_175_1.actors_[var_178_7.prefab_name] ~= nil then
						local var_178_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_7.prefab_name].transform, "story_v_out_122531", "122531043", "story_v_out_122531.awb")

						arg_175_1:RecordAudio("122531043", var_178_13)
						arg_175_1:RecordAudio("122531043", var_178_13)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_122531", "122531043", "story_v_out_122531.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_122531", "122531043", "story_v_out_122531.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_14 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_14 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_14

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_14 and arg_175_1.time_ < var_178_4 + var_178_14 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play122531044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 122531044
		arg_179_1.duration_ = 8.43

		local var_179_0 = {
			ja = 8.433,
			ko = 3.233,
			zh = 3.233
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play122531045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.35

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[384].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:GetWordFromCfg(122531044)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531044", "story_v_out_122531.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531044", "story_v_out_122531.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_122531", "122531044", "story_v_out_122531.awb")

						arg_179_1:RecordAudio("122531044", var_182_9)
						arg_179_1:RecordAudio("122531044", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_122531", "122531044", "story_v_out_122531.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_122531", "122531044", "story_v_out_122531.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_10 and arg_179_1.time_ < var_182_0 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play122531045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 122531045
		arg_183_1.duration_ = 0.5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"

			SetActive(arg_183_1.choicesGo_, true)

			for iter_184_0, iter_184_1 in ipairs(arg_183_1.choices_) do
				local var_184_0 = iter_184_0 <= 2

				SetActive(iter_184_1.go, var_184_0)
			end

			arg_183_1.choices_[1].txt.text = arg_183_1:FormatText(StoryChoiceCfg[461].name)
			arg_183_1.choices_[2].txt.text = arg_183_1:FormatText(StoryChoiceCfg[462].name)
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play122531046(arg_183_1)
			end

			if arg_185_0 == 2 then
				arg_183_0:Play122531046(arg_183_1)
			end

			arg_183_1:RecordChoiceLog(122531045, 461, 462)
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1071ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1071ui_story == nil then
				arg_183_1.var_.characterEffect1071ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1071ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1071ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1071ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1071ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			local var_186_7 = 0.5

			if arg_183_1.time_ >= var_186_6 + var_186_7 and arg_183_1.time_ < var_186_6 + var_186_7 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play122531046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 122531046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play122531047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.525

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[7].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:GetWordFromCfg(122531046)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 21
				local var_190_6 = utf8.len(var_190_4)
				local var_190_7 = var_190_5 <= 0 and var_190_1 or var_190_1 * (var_190_6 / var_190_5)

				if var_190_7 > 0 and var_190_1 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_8 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_8 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_8

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_8 and arg_187_1.time_ < var_190_0 + var_190_8 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play122531047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 122531047
		arg_191_1.duration_ = 8.93

		local var_191_0 = {
			ja = 8.933,
			ko = 3.733,
			zh = 3.733
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play122531048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1071ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1071ui_story == nil then
				arg_191_1.var_.characterEffect1071ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect1071ui_story and not isNil(var_194_0) then
					arg_191_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1071ui_story then
				arg_191_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_194_4 = 0
			local var_194_5 = 0.3

			if var_194_4 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_6 = arg_191_1:FormatText(StoryNameCfg[384].name)

				arg_191_1.leftNameTxt_.text = var_194_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_7 = arg_191_1:GetWordFromCfg(122531047)
				local var_194_8 = arg_191_1:FormatText(var_194_7.content)

				arg_191_1.text_.text = var_194_8

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 12
				local var_194_10 = utf8.len(var_194_8)
				local var_194_11 = var_194_9 <= 0 and var_194_5 or var_194_5 * (var_194_10 / var_194_9)

				if var_194_11 > 0 and var_194_5 < var_194_11 then
					arg_191_1.talkMaxDuration = var_194_11

					if var_194_11 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_8
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531047", "story_v_out_122531.awb") ~= 0 then
					local var_194_12 = manager.audio:GetVoiceLength("story_v_out_122531", "122531047", "story_v_out_122531.awb") / 1000

					if var_194_12 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_12 + var_194_4
					end

					if var_194_7.prefab_name ~= "" and arg_191_1.actors_[var_194_7.prefab_name] ~= nil then
						local var_194_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_7.prefab_name].transform, "story_v_out_122531", "122531047", "story_v_out_122531.awb")

						arg_191_1:RecordAudio("122531047", var_194_13)
						arg_191_1:RecordAudio("122531047", var_194_13)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_122531", "122531047", "story_v_out_122531.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_122531", "122531047", "story_v_out_122531.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_14 = math.max(var_194_5, arg_191_1.talkMaxDuration)

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_14 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_4) / var_194_14

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_4 + var_194_14 and arg_191_1.time_ < var_194_4 + var_194_14 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play122531048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 122531048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play122531049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1071ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1071ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(0, 100, 0)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1071ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, 100, 0)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = arg_195_1.actors_["1071ui_story"]
			local var_198_10 = 0

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1071ui_story == nil then
				arg_195_1.var_.characterEffect1071ui_story = var_198_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_11 = 0.200000002980232

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_11 and not isNil(var_198_9) then
				local var_198_12 = (arg_195_1.time_ - var_198_10) / var_198_11

				if arg_195_1.var_.characterEffect1071ui_story and not isNil(var_198_9) then
					local var_198_13 = Mathf.Lerp(0, 0.5, var_198_12)

					arg_195_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1071ui_story.fillRatio = var_198_13
				end
			end

			if arg_195_1.time_ >= var_198_10 + var_198_11 and arg_195_1.time_ < var_198_10 + var_198_11 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1071ui_story then
				local var_198_14 = 0.5

				arg_195_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1071ui_story.fillRatio = var_198_14
			end

			local var_198_15 = 0
			local var_198_16 = 0.7

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_17 = arg_195_1:FormatText(StoryNameCfg[7].name)

				arg_195_1.leftNameTxt_.text = var_198_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_18 = arg_195_1:GetWordFromCfg(122531048)
				local var_198_19 = arg_195_1:FormatText(var_198_18.content)

				arg_195_1.text_.text = var_198_19

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_20 = 28
				local var_198_21 = utf8.len(var_198_19)
				local var_198_22 = var_198_20 <= 0 and var_198_16 or var_198_16 * (var_198_21 / var_198_20)

				if var_198_22 > 0 and var_198_16 < var_198_22 then
					arg_195_1.talkMaxDuration = var_198_22

					if var_198_22 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_22 + var_198_15
					end
				end

				arg_195_1.text_.text = var_198_19
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_23 = math.max(var_198_16, arg_195_1.talkMaxDuration)

			if var_198_15 <= arg_195_1.time_ and arg_195_1.time_ < var_198_15 + var_198_23 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_15) / var_198_23

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_15 + var_198_23 and arg_195_1.time_ < var_198_15 + var_198_23 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play122531049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 122531049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play122531050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = "ST42_blur"

			if arg_199_1.bgs_[var_202_0] == nil then
				local var_202_1 = Object.Instantiate(arg_199_1.blurPaintGo_)
				local var_202_2 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_202_0)

				var_202_1:GetComponent("SpriteRenderer").sprite = var_202_2
				var_202_1.name = var_202_0
				var_202_1.transform.parent = arg_199_1.stage_.transform
				var_202_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.bgs_[var_202_0] = var_202_1
			end

			local var_202_3 = 0
			local var_202_4 = arg_199_1.bgs_[var_202_0]

			if var_202_3 < arg_199_1.time_ and arg_199_1.time_ <= var_202_3 + arg_202_0 then
				local var_202_5 = manager.ui.mainCamera.transform.localPosition
				local var_202_6 = Vector3.New(0, 0, 10) + Vector3.New(var_202_5.x, var_202_5.y, 0)

				var_202_4.transform.localPosition = var_202_6
				var_202_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_202_7 = var_202_4:GetComponent("SpriteRenderer")

				if var_202_7 and var_202_7.sprite then
					local var_202_8 = (var_202_4.transform.localPosition - var_202_5).z
					local var_202_9 = manager.ui.mainCameraCom_
					local var_202_10 = 2 * var_202_8 * Mathf.Tan(var_202_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_202_11 = var_202_10 * var_202_9.aspect
					local var_202_12 = var_202_7.sprite.bounds.size.x
					local var_202_13 = var_202_7.sprite.bounds.size.y
					local var_202_14 = var_202_11 / var_202_12
					local var_202_15 = var_202_10 / var_202_13
					local var_202_16 = var_202_15 < var_202_14 and var_202_14 or var_202_15

					var_202_4.transform.localScale = Vector3.New(var_202_16, var_202_16, 0)
				end
			end

			local var_202_17 = 2

			if var_202_3 <= arg_199_1.time_ and arg_199_1.time_ < var_202_3 + var_202_17 then
				local var_202_18 = (arg_199_1.time_ - var_202_3) / var_202_17
				local var_202_19 = Color.New(1, 1, 1)

				var_202_19.a = Mathf.Lerp(0, 1, var_202_18)

				var_202_4:GetComponent("SpriteRenderer").material:SetColor("_Color", var_202_19)
			end

			local var_202_20 = 0

			if var_202_20 < arg_199_1.time_ and arg_199_1.time_ <= var_202_20 + arg_202_0 then
				arg_199_1.allBtn_.enabled = false
			end

			local var_202_21 = 2

			if arg_199_1.time_ >= var_202_20 + var_202_21 and arg_199_1.time_ < var_202_20 + var_202_21 + arg_202_0 then
				arg_199_1.allBtn_.enabled = true
			end

			local var_202_22 = 0
			local var_202_23 = 1.275

			if var_202_22 < arg_199_1.time_ and arg_199_1.time_ <= var_202_22 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_24 = arg_199_1:GetWordFromCfg(122531049)
				local var_202_25 = arg_199_1:FormatText(var_202_24.content)

				arg_199_1.text_.text = var_202_25

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_26 = 51
				local var_202_27 = utf8.len(var_202_25)
				local var_202_28 = var_202_26 <= 0 and var_202_23 or var_202_23 * (var_202_27 / var_202_26)

				if var_202_28 > 0 and var_202_23 < var_202_28 then
					arg_199_1.talkMaxDuration = var_202_28

					if var_202_28 + var_202_22 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_28 + var_202_22
					end
				end

				arg_199_1.text_.text = var_202_25
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_29 = math.max(var_202_23, arg_199_1.talkMaxDuration)

			if var_202_22 <= arg_199_1.time_ and arg_199_1.time_ < var_202_22 + var_202_29 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_22) / var_202_29

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_22 + var_202_29 and arg_199_1.time_ < var_202_22 + var_202_29 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play122531050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 122531050
		arg_203_1.duration_ = 2

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"

			SetActive(arg_203_1.choicesGo_, true)

			for iter_204_0, iter_204_1 in ipairs(arg_203_1.choices_) do
				local var_204_0 = iter_204_0 <= 1

				SetActive(iter_204_1.go, var_204_0)
			end

			arg_203_1.choices_[1].txt.text = arg_203_1:FormatText(StoryChoiceCfg[463].name)
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play122531051(arg_203_1)
			end

			arg_203_1:RecordChoiceLog(122531050, 463)
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = "ST42_blur"

			if arg_203_1.bgs_[var_206_0] == nil then
				local var_206_1 = Object.Instantiate(arg_203_1.blurPaintGo_)
				local var_206_2 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_206_0)

				var_206_1:GetComponent("SpriteRenderer").sprite = var_206_2
				var_206_1.name = var_206_0
				var_206_1.transform.parent = arg_203_1.stage_.transform
				var_206_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_[var_206_0] = var_206_1
			end

			local var_206_3 = 0
			local var_206_4 = arg_203_1.bgs_[var_206_0]

			if var_206_3 < arg_203_1.time_ and arg_203_1.time_ <= var_206_3 + arg_206_0 then
				local var_206_5 = manager.ui.mainCamera.transform.localPosition
				local var_206_6 = Vector3.New(0, 0, 10) + Vector3.New(var_206_5.x, var_206_5.y, 0)

				var_206_4.transform.localPosition = var_206_6
				var_206_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_7 = var_206_4:GetComponent("SpriteRenderer")

				if var_206_7 and var_206_7.sprite then
					local var_206_8 = (var_206_4.transform.localPosition - var_206_5).z
					local var_206_9 = manager.ui.mainCameraCom_
					local var_206_10 = 2 * var_206_8 * Mathf.Tan(var_206_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_206_11 = var_206_10 * var_206_9.aspect
					local var_206_12 = var_206_7.sprite.bounds.size.x
					local var_206_13 = var_206_7.sprite.bounds.size.y
					local var_206_14 = var_206_11 / var_206_12
					local var_206_15 = var_206_10 / var_206_13
					local var_206_16 = var_206_15 < var_206_14 and var_206_14 or var_206_15

					var_206_4.transform.localScale = Vector3.New(var_206_16, var_206_16, 0)
				end
			end

			local var_206_17 = 2

			if var_206_3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_3 + var_206_17 then
				local var_206_18 = (arg_203_1.time_ - var_206_3) / var_206_17
				local var_206_19 = Color.New(1, 1, 1)

				var_206_19.a = Mathf.Lerp(1, 0, var_206_18)

				var_206_4:GetComponent("SpriteRenderer").material:SetColor("_Color", var_206_19)
			end

			local var_206_20 = 0

			if var_206_20 < arg_203_1.time_ and arg_203_1.time_ <= var_206_20 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			local var_206_21 = 2

			if arg_203_1.time_ >= var_206_20 + var_206_21 and arg_203_1.time_ < var_206_20 + var_206_21 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play122531051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 122531051
		arg_207_1.duration_ = 15.3

		local var_207_0 = {
			ja = 15.3,
			ko = 5.1,
			zh = 5.1
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play122531052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1071ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1071ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(0, -1.05, -6.2)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1071ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["1071ui_story"]
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1071ui_story == nil then
				arg_207_1.var_.characterEffect1071ui_story = var_210_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_11 = 0.200000002980232

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 and not isNil(var_210_9) then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11

				if arg_207_1.var_.characterEffect1071ui_story and not isNil(var_210_9) then
					arg_207_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1071ui_story then
				arg_207_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_210_13 = 0

			if var_210_13 < arg_207_1.time_ and arg_207_1.time_ <= var_210_13 + arg_210_0 then
				arg_207_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_210_14 = 0
			local var_210_15 = 0.575

			if var_210_14 < arg_207_1.time_ and arg_207_1.time_ <= var_210_14 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_16 = arg_207_1:FormatText(StoryNameCfg[384].name)

				arg_207_1.leftNameTxt_.text = var_210_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_17 = arg_207_1:GetWordFromCfg(122531051)
				local var_210_18 = arg_207_1:FormatText(var_210_17.content)

				arg_207_1.text_.text = var_210_18

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_19 = 23
				local var_210_20 = utf8.len(var_210_18)
				local var_210_21 = var_210_19 <= 0 and var_210_15 or var_210_15 * (var_210_20 / var_210_19)

				if var_210_21 > 0 and var_210_15 < var_210_21 then
					arg_207_1.talkMaxDuration = var_210_21

					if var_210_21 + var_210_14 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_21 + var_210_14
					end
				end

				arg_207_1.text_.text = var_210_18
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531051", "story_v_out_122531.awb") ~= 0 then
					local var_210_22 = manager.audio:GetVoiceLength("story_v_out_122531", "122531051", "story_v_out_122531.awb") / 1000

					if var_210_22 + var_210_14 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_22 + var_210_14
					end

					if var_210_17.prefab_name ~= "" and arg_207_1.actors_[var_210_17.prefab_name] ~= nil then
						local var_210_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_17.prefab_name].transform, "story_v_out_122531", "122531051", "story_v_out_122531.awb")

						arg_207_1:RecordAudio("122531051", var_210_23)
						arg_207_1:RecordAudio("122531051", var_210_23)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_122531", "122531051", "story_v_out_122531.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_122531", "122531051", "story_v_out_122531.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_24 = math.max(var_210_15, arg_207_1.talkMaxDuration)

			if var_210_14 <= arg_207_1.time_ and arg_207_1.time_ < var_210_14 + var_210_24 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_14) / var_210_24

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_14 + var_210_24 and arg_207_1.time_ < var_210_14 + var_210_24 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play122531052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 122531052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play122531053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1071ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1071ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0, 100, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1071ui_story, var_214_4, var_214_3)

				local var_214_5 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_5.x, var_214_5.y, var_214_5.z)

				local var_214_6 = var_214_0.localEulerAngles

				var_214_6.z = 0
				var_214_6.x = 0
				var_214_0.localEulerAngles = var_214_6
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, 100, 0)

				local var_214_7 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_7.x, var_214_7.y, var_214_7.z)

				local var_214_8 = var_214_0.localEulerAngles

				var_214_8.z = 0
				var_214_8.x = 0
				var_214_0.localEulerAngles = var_214_8
			end

			local var_214_9 = arg_211_1.actors_["1071ui_story"]
			local var_214_10 = 0

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect1071ui_story == nil then
				arg_211_1.var_.characterEffect1071ui_story = var_214_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_11 = 0.200000002980232

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_11 and not isNil(var_214_9) then
				local var_214_12 = (arg_211_1.time_ - var_214_10) / var_214_11

				if arg_211_1.var_.characterEffect1071ui_story and not isNil(var_214_9) then
					local var_214_13 = Mathf.Lerp(0, 0.5, var_214_12)

					arg_211_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1071ui_story.fillRatio = var_214_13
				end
			end

			if arg_211_1.time_ >= var_214_10 + var_214_11 and arg_211_1.time_ < var_214_10 + var_214_11 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect1071ui_story then
				local var_214_14 = 0.5

				arg_211_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1071ui_story.fillRatio = var_214_14
			end

			local var_214_15 = 0
			local var_214_16 = 1.2

			if var_214_15 < arg_211_1.time_ and arg_211_1.time_ <= var_214_15 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_17 = arg_211_1:GetWordFromCfg(122531052)
				local var_214_18 = arg_211_1:FormatText(var_214_17.content)

				arg_211_1.text_.text = var_214_18

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_19 = 48
				local var_214_20 = utf8.len(var_214_18)
				local var_214_21 = var_214_19 <= 0 and var_214_16 or var_214_16 * (var_214_20 / var_214_19)

				if var_214_21 > 0 and var_214_16 < var_214_21 then
					arg_211_1.talkMaxDuration = var_214_21

					if var_214_21 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_21 + var_214_15
					end
				end

				arg_211_1.text_.text = var_214_18
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_22 = math.max(var_214_16, arg_211_1.talkMaxDuration)

			if var_214_15 <= arg_211_1.time_ and arg_211_1.time_ < var_214_15 + var_214_22 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_15) / var_214_22

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_15 + var_214_22 and arg_211_1.time_ < var_214_15 + var_214_22 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play122531053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 122531053
		arg_215_1.duration_ = 5.7

		local var_215_0 = {
			ja = 5.7,
			ko = 4.533,
			zh = 4.533
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play122531054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1071ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1071ui_story == nil then
				arg_215_1.var_.characterEffect1071ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect1071ui_story and not isNil(var_218_0) then
					arg_215_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1071ui_story then
				arg_215_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_218_4 = 0

			if var_218_4 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			local var_218_5 = arg_215_1.actors_["1071ui_story"].transform
			local var_218_6 = 0

			if var_218_6 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.var_.moveOldPos1071ui_story = var_218_5.localPosition
			end

			local var_218_7 = 0.001

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_7 then
				local var_218_8 = (arg_215_1.time_ - var_218_6) / var_218_7
				local var_218_9 = Vector3.New(0, -1.05, -6.2)

				var_218_5.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1071ui_story, var_218_9, var_218_8)

				local var_218_10 = manager.ui.mainCamera.transform.position - var_218_5.position

				var_218_5.forward = Vector3.New(var_218_10.x, var_218_10.y, var_218_10.z)

				local var_218_11 = var_218_5.localEulerAngles

				var_218_11.z = 0
				var_218_11.x = 0
				var_218_5.localEulerAngles = var_218_11
			end

			if arg_215_1.time_ >= var_218_6 + var_218_7 and arg_215_1.time_ < var_218_6 + var_218_7 + arg_218_0 then
				var_218_5.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_218_12 = manager.ui.mainCamera.transform.position - var_218_5.position

				var_218_5.forward = Vector3.New(var_218_12.x, var_218_12.y, var_218_12.z)

				local var_218_13 = var_218_5.localEulerAngles

				var_218_13.z = 0
				var_218_13.x = 0
				var_218_5.localEulerAngles = var_218_13
			end

			local var_218_14 = 0
			local var_218_15 = 0.5

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_16 = arg_215_1:FormatText(StoryNameCfg[384].name)

				arg_215_1.leftNameTxt_.text = var_218_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_17 = arg_215_1:GetWordFromCfg(122531053)
				local var_218_18 = arg_215_1:FormatText(var_218_17.content)

				arg_215_1.text_.text = var_218_18

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_19 = 20
				local var_218_20 = utf8.len(var_218_18)
				local var_218_21 = var_218_19 <= 0 and var_218_15 or var_218_15 * (var_218_20 / var_218_19)

				if var_218_21 > 0 and var_218_15 < var_218_21 then
					arg_215_1.talkMaxDuration = var_218_21

					if var_218_21 + var_218_14 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_21 + var_218_14
					end
				end

				arg_215_1.text_.text = var_218_18
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531053", "story_v_out_122531.awb") ~= 0 then
					local var_218_22 = manager.audio:GetVoiceLength("story_v_out_122531", "122531053", "story_v_out_122531.awb") / 1000

					if var_218_22 + var_218_14 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_22 + var_218_14
					end

					if var_218_17.prefab_name ~= "" and arg_215_1.actors_[var_218_17.prefab_name] ~= nil then
						local var_218_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_17.prefab_name].transform, "story_v_out_122531", "122531053", "story_v_out_122531.awb")

						arg_215_1:RecordAudio("122531053", var_218_23)
						arg_215_1:RecordAudio("122531053", var_218_23)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_122531", "122531053", "story_v_out_122531.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_122531", "122531053", "story_v_out_122531.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_24 = math.max(var_218_15, arg_215_1.talkMaxDuration)

			if var_218_14 <= arg_215_1.time_ and arg_215_1.time_ < var_218_14 + var_218_24 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_14) / var_218_24

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_14 + var_218_24 and arg_215_1.time_ < var_218_14 + var_218_24 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play122531054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 122531054
		arg_219_1.duration_ = 14.47

		local var_219_0 = {
			ja = 14.466,
			ko = 7.4,
			zh = 7.4
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play122531055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.825

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[384].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_3 = arg_219_1:GetWordFromCfg(122531054)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 33
				local var_222_6 = utf8.len(var_222_4)
				local var_222_7 = var_222_5 <= 0 and var_222_1 or var_222_1 * (var_222_6 / var_222_5)

				if var_222_7 > 0 and var_222_1 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531054", "story_v_out_122531.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531054", "story_v_out_122531.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_122531", "122531054", "story_v_out_122531.awb")

						arg_219_1:RecordAudio("122531054", var_222_9)
						arg_219_1:RecordAudio("122531054", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_122531", "122531054", "story_v_out_122531.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_122531", "122531054", "story_v_out_122531.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_10 and arg_219_1.time_ < var_222_0 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play122531055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 122531055
		arg_223_1.duration_ = 15.27

		local var_223_0 = {
			ja = 15.266,
			ko = 9,
			zh = 9
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play122531056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 1

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[384].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_3 = arg_223_1:GetWordFromCfg(122531055)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 40
				local var_226_6 = utf8.len(var_226_4)
				local var_226_7 = var_226_5 <= 0 and var_226_1 or var_226_1 * (var_226_6 / var_226_5)

				if var_226_7 > 0 and var_226_1 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531055", "story_v_out_122531.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531055", "story_v_out_122531.awb") / 1000

					if var_226_8 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_0
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_122531", "122531055", "story_v_out_122531.awb")

						arg_223_1:RecordAudio("122531055", var_226_9)
						arg_223_1:RecordAudio("122531055", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_122531", "122531055", "story_v_out_122531.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_122531", "122531055", "story_v_out_122531.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_10 and arg_223_1.time_ < var_226_0 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play122531056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 122531056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play122531057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1071ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1071ui_story == nil then
				arg_227_1.var_.characterEffect1071ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect1071ui_story and not isNil(var_230_0) then
					local var_230_4 = Mathf.Lerp(0, 0.5, var_230_3)

					arg_227_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1071ui_story.fillRatio = var_230_4
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1071ui_story then
				local var_230_5 = 0.5

				arg_227_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1071ui_story.fillRatio = var_230_5
			end

			local var_230_6 = 0
			local var_230_7 = 0.125

			if var_230_6 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_8 = arg_227_1:FormatText(StoryNameCfg[7].name)

				arg_227_1.leftNameTxt_.text = var_230_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_9 = arg_227_1:GetWordFromCfg(122531056)
				local var_230_10 = arg_227_1:FormatText(var_230_9.content)

				arg_227_1.text_.text = var_230_10

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 5
				local var_230_12 = utf8.len(var_230_10)
				local var_230_13 = var_230_11 <= 0 and var_230_7 or var_230_7 * (var_230_12 / var_230_11)

				if var_230_13 > 0 and var_230_7 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_6
					end
				end

				arg_227_1.text_.text = var_230_10
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_14 = math.max(var_230_7, arg_227_1.talkMaxDuration)

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_14 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_6) / var_230_14

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_6 + var_230_14 and arg_227_1.time_ < var_230_6 + var_230_14 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play122531057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 122531057
		arg_231_1.duration_ = 6.43

		local var_231_0 = {
			ja = 6.433,
			ko = 3.2,
			zh = 3.2
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play122531058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1071ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1071ui_story == nil then
				arg_231_1.var_.characterEffect1071ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1071ui_story and not isNil(var_234_0) then
					arg_231_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1071ui_story then
				arg_231_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_234_4 = 0

			if var_234_4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_234_5 = 0
			local var_234_6 = 0.4

			if var_234_5 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_7 = arg_231_1:FormatText(StoryNameCfg[384].name)

				arg_231_1.leftNameTxt_.text = var_234_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_8 = arg_231_1:GetWordFromCfg(122531057)
				local var_234_9 = arg_231_1:FormatText(var_234_8.content)

				arg_231_1.text_.text = var_234_9

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_10 = 16
				local var_234_11 = utf8.len(var_234_9)
				local var_234_12 = var_234_10 <= 0 and var_234_6 or var_234_6 * (var_234_11 / var_234_10)

				if var_234_12 > 0 and var_234_6 < var_234_12 then
					arg_231_1.talkMaxDuration = var_234_12

					if var_234_12 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_12 + var_234_5
					end
				end

				arg_231_1.text_.text = var_234_9
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531057", "story_v_out_122531.awb") ~= 0 then
					local var_234_13 = manager.audio:GetVoiceLength("story_v_out_122531", "122531057", "story_v_out_122531.awb") / 1000

					if var_234_13 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_13 + var_234_5
					end

					if var_234_8.prefab_name ~= "" and arg_231_1.actors_[var_234_8.prefab_name] ~= nil then
						local var_234_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_8.prefab_name].transform, "story_v_out_122531", "122531057", "story_v_out_122531.awb")

						arg_231_1:RecordAudio("122531057", var_234_14)
						arg_231_1:RecordAudio("122531057", var_234_14)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_122531", "122531057", "story_v_out_122531.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_122531", "122531057", "story_v_out_122531.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_15 = math.max(var_234_6, arg_231_1.talkMaxDuration)

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_15 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_5) / var_234_15

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_5 + var_234_15 and arg_231_1.time_ < var_234_5 + var_234_15 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play122531058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 122531058
		arg_235_1.duration_ = 11.57

		local var_235_0 = {
			ja = 11.566,
			ko = 6.633,
			zh = 6.633
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play122531059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_238_1 = 0
			local var_238_2 = 0.65

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_3 = arg_235_1:FormatText(StoryNameCfg[384].name)

				arg_235_1.leftNameTxt_.text = var_238_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_4 = arg_235_1:GetWordFromCfg(122531058)
				local var_238_5 = arg_235_1:FormatText(var_238_4.content)

				arg_235_1.text_.text = var_238_5

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_6 = 26
				local var_238_7 = utf8.len(var_238_5)
				local var_238_8 = var_238_6 <= 0 and var_238_2 or var_238_2 * (var_238_7 / var_238_6)

				if var_238_8 > 0 and var_238_2 < var_238_8 then
					arg_235_1.talkMaxDuration = var_238_8

					if var_238_8 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_1
					end
				end

				arg_235_1.text_.text = var_238_5
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531058", "story_v_out_122531.awb") ~= 0 then
					local var_238_9 = manager.audio:GetVoiceLength("story_v_out_122531", "122531058", "story_v_out_122531.awb") / 1000

					if var_238_9 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_1
					end

					if var_238_4.prefab_name ~= "" and arg_235_1.actors_[var_238_4.prefab_name] ~= nil then
						local var_238_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_4.prefab_name].transform, "story_v_out_122531", "122531058", "story_v_out_122531.awb")

						arg_235_1:RecordAudio("122531058", var_238_10)
						arg_235_1:RecordAudio("122531058", var_238_10)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_122531", "122531058", "story_v_out_122531.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_122531", "122531058", "story_v_out_122531.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_11 = math.max(var_238_2, arg_235_1.talkMaxDuration)

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_11 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_1) / var_238_11

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_1 + var_238_11 and arg_235_1.time_ < var_238_1 + var_238_11 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play122531059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 122531059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play122531060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1071ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1071ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0, 100, 0)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1071ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, 100, 0)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["1071ui_story"]
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1071ui_story == nil then
				arg_239_1.var_.characterEffect1071ui_story = var_242_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_11 = 0.200000002980232

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 and not isNil(var_242_9) then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11

				if arg_239_1.var_.characterEffect1071ui_story and not isNil(var_242_9) then
					local var_242_13 = Mathf.Lerp(0, 0.5, var_242_12)

					arg_239_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1071ui_story.fillRatio = var_242_13
				end
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1071ui_story then
				local var_242_14 = 0.5

				arg_239_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1071ui_story.fillRatio = var_242_14
			end

			local var_242_15 = 0
			local var_242_16 = 1.525

			if var_242_15 < arg_239_1.time_ and arg_239_1.time_ <= var_242_15 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_17 = arg_239_1:GetWordFromCfg(122531059)
				local var_242_18 = arg_239_1:FormatText(var_242_17.content)

				arg_239_1.text_.text = var_242_18

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_19 = 61
				local var_242_20 = utf8.len(var_242_18)
				local var_242_21 = var_242_19 <= 0 and var_242_16 or var_242_16 * (var_242_20 / var_242_19)

				if var_242_21 > 0 and var_242_16 < var_242_21 then
					arg_239_1.talkMaxDuration = var_242_21

					if var_242_21 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_21 + var_242_15
					end
				end

				arg_239_1.text_.text = var_242_18
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_22 = math.max(var_242_16, arg_239_1.talkMaxDuration)

			if var_242_15 <= arg_239_1.time_ and arg_239_1.time_ < var_242_15 + var_242_22 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_15) / var_242_22

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_15 + var_242_22 and arg_239_1.time_ < var_242_15 + var_242_22 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play122531060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 122531060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play122531061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 1.175

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_2 = arg_243_1:GetWordFromCfg(122531060)
				local var_246_3 = arg_243_1:FormatText(var_246_2.content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 47
				local var_246_5 = utf8.len(var_246_3)
				local var_246_6 = var_246_4 <= 0 and var_246_1 or var_246_1 * (var_246_5 / var_246_4)

				if var_246_6 > 0 and var_246_1 < var_246_6 then
					arg_243_1.talkMaxDuration = var_246_6

					if var_246_6 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_7 and arg_243_1.time_ < var_246_0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play122531061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 122531061
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play122531062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 1.375

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_2 = arg_247_1:GetWordFromCfg(122531061)
				local var_250_3 = arg_247_1:FormatText(var_250_2.content)

				arg_247_1.text_.text = var_250_3

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 55
				local var_250_5 = utf8.len(var_250_3)
				local var_250_6 = var_250_4 <= 0 and var_250_1 or var_250_1 * (var_250_5 / var_250_4)

				if var_250_6 > 0 and var_250_1 < var_250_6 then
					arg_247_1.talkMaxDuration = var_250_6

					if var_250_6 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_3
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_7 and arg_247_1.time_ < var_250_0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play122531062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 122531062
		arg_251_1.duration_ = 5.03

		local var_251_0 = {
			ja = 5.033,
			ko = 2.7,
			zh = 2.7
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play122531063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = "1075ui_story"

			if arg_251_1.actors_[var_254_0] == nil then
				local var_254_1 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_254_1) then
					local var_254_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_251_1.stage_.transform)

					var_254_2.name = var_254_0
					var_254_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_251_1.actors_[var_254_0] = var_254_2

					local var_254_3 = var_254_2:GetComponentInChildren(typeof(CharacterEffect))

					var_254_3.enabled = true

					local var_254_4 = GameObjectTools.GetOrAddComponent(var_254_2, typeof(DynamicBoneHelper))

					if var_254_4 then
						var_254_4:EnableDynamicBone(false)
					end

					arg_251_1:ShowWeapon(var_254_3.transform, false)

					arg_251_1.var_[var_254_0 .. "Animator"] = var_254_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_251_1.var_[var_254_0 .. "Animator"].applyRootMotion = true
					arg_251_1.var_[var_254_0 .. "LipSync"] = var_254_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_254_5 = arg_251_1.actors_["1075ui_story"].transform
			local var_254_6 = 0

			if var_254_6 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.var_.moveOldPos1075ui_story = var_254_5.localPosition
			end

			local var_254_7 = 0.001

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_7 then
				local var_254_8 = (arg_251_1.time_ - var_254_6) / var_254_7
				local var_254_9 = Vector3.New(0, -1.055, -6.16)

				var_254_5.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1075ui_story, var_254_9, var_254_8)

				local var_254_10 = manager.ui.mainCamera.transform.position - var_254_5.position

				var_254_5.forward = Vector3.New(var_254_10.x, var_254_10.y, var_254_10.z)

				local var_254_11 = var_254_5.localEulerAngles

				var_254_11.z = 0
				var_254_11.x = 0
				var_254_5.localEulerAngles = var_254_11
			end

			if arg_251_1.time_ >= var_254_6 + var_254_7 and arg_251_1.time_ < var_254_6 + var_254_7 + arg_254_0 then
				var_254_5.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_254_12 = manager.ui.mainCamera.transform.position - var_254_5.position

				var_254_5.forward = Vector3.New(var_254_12.x, var_254_12.y, var_254_12.z)

				local var_254_13 = var_254_5.localEulerAngles

				var_254_13.z = 0
				var_254_13.x = 0
				var_254_5.localEulerAngles = var_254_13
			end

			local var_254_14 = arg_251_1.actors_["1075ui_story"]
			local var_254_15 = 0

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 and not isNil(var_254_14) and arg_251_1.var_.characterEffect1075ui_story == nil then
				arg_251_1.var_.characterEffect1075ui_story = var_254_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_16 = 0.200000002980232

			if var_254_15 <= arg_251_1.time_ and arg_251_1.time_ < var_254_15 + var_254_16 and not isNil(var_254_14) then
				local var_254_17 = (arg_251_1.time_ - var_254_15) / var_254_16

				if arg_251_1.var_.characterEffect1075ui_story and not isNil(var_254_14) then
					arg_251_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_15 + var_254_16 and arg_251_1.time_ < var_254_15 + var_254_16 + arg_254_0 and not isNil(var_254_14) and arg_251_1.var_.characterEffect1075ui_story then
				arg_251_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_254_18 = 0

			if var_254_18 < arg_251_1.time_ and arg_251_1.time_ <= var_254_18 + arg_254_0 then
				arg_251_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_254_19 = 0

			if var_254_19 < arg_251_1.time_ and arg_251_1.time_ <= var_254_19 + arg_254_0 then
				arg_251_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_254_20 = 0
			local var_254_21 = 0.475

			if var_254_20 < arg_251_1.time_ and arg_251_1.time_ <= var_254_20 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_22 = arg_251_1:FormatText(StoryNameCfg[381].name)

				arg_251_1.leftNameTxt_.text = var_254_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_23 = arg_251_1:GetWordFromCfg(122531062)
				local var_254_24 = arg_251_1:FormatText(var_254_23.content)

				arg_251_1.text_.text = var_254_24

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_25 = 19
				local var_254_26 = utf8.len(var_254_24)
				local var_254_27 = var_254_25 <= 0 and var_254_21 or var_254_21 * (var_254_26 / var_254_25)

				if var_254_27 > 0 and var_254_21 < var_254_27 then
					arg_251_1.talkMaxDuration = var_254_27

					if var_254_27 + var_254_20 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_27 + var_254_20
					end
				end

				arg_251_1.text_.text = var_254_24
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531062", "story_v_out_122531.awb") ~= 0 then
					local var_254_28 = manager.audio:GetVoiceLength("story_v_out_122531", "122531062", "story_v_out_122531.awb") / 1000

					if var_254_28 + var_254_20 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_28 + var_254_20
					end

					if var_254_23.prefab_name ~= "" and arg_251_1.actors_[var_254_23.prefab_name] ~= nil then
						local var_254_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_23.prefab_name].transform, "story_v_out_122531", "122531062", "story_v_out_122531.awb")

						arg_251_1:RecordAudio("122531062", var_254_29)
						arg_251_1:RecordAudio("122531062", var_254_29)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_122531", "122531062", "story_v_out_122531.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_122531", "122531062", "story_v_out_122531.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_30 = math.max(var_254_21, arg_251_1.talkMaxDuration)

			if var_254_20 <= arg_251_1.time_ and arg_251_1.time_ < var_254_20 + var_254_30 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_20) / var_254_30

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_20 + var_254_30 and arg_251_1.time_ < var_254_20 + var_254_30 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play122531063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 122531063
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play122531064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1075ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1075ui_story == nil then
				arg_255_1.var_.characterEffect1075ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect1075ui_story and not isNil(var_258_0) then
					local var_258_4 = Mathf.Lerp(0, 0.5, var_258_3)

					arg_255_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1075ui_story.fillRatio = var_258_4
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1075ui_story then
				local var_258_5 = 0.5

				arg_255_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1075ui_story.fillRatio = var_258_5
			end

			local var_258_6 = 0
			local var_258_7 = 0.1

			if var_258_6 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_8 = arg_255_1:FormatText(StoryNameCfg[7].name)

				arg_255_1.leftNameTxt_.text = var_258_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_9 = arg_255_1:GetWordFromCfg(122531063)
				local var_258_10 = arg_255_1:FormatText(var_258_9.content)

				arg_255_1.text_.text = var_258_10

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_11 = 4
				local var_258_12 = utf8.len(var_258_10)
				local var_258_13 = var_258_11 <= 0 and var_258_7 or var_258_7 * (var_258_12 / var_258_11)

				if var_258_13 > 0 and var_258_7 < var_258_13 then
					arg_255_1.talkMaxDuration = var_258_13

					if var_258_13 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_13 + var_258_6
					end
				end

				arg_255_1.text_.text = var_258_10
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_14 = math.max(var_258_7, arg_255_1.talkMaxDuration)

			if var_258_6 <= arg_255_1.time_ and arg_255_1.time_ < var_258_6 + var_258_14 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_6) / var_258_14

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_6 + var_258_14 and arg_255_1.time_ < var_258_6 + var_258_14 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play122531064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 122531064
		arg_259_1.duration_ = 13.27

		local var_259_0 = {
			ja = 13.266,
			ko = 10.4,
			zh = 10.4
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play122531065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1075ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1075ui_story == nil then
				arg_259_1.var_.characterEffect1075ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect1075ui_story and not isNil(var_262_0) then
					arg_259_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1075ui_story then
				arg_259_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_262_4 = 0

			if var_262_4 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_262_5 = 0

			if var_262_5 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_6 = 0
			local var_262_7 = 1.075

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_8 = arg_259_1:FormatText(StoryNameCfg[381].name)

				arg_259_1.leftNameTxt_.text = var_262_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_9 = arg_259_1:GetWordFromCfg(122531064)
				local var_262_10 = arg_259_1:FormatText(var_262_9.content)

				arg_259_1.text_.text = var_262_10

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 43
				local var_262_12 = utf8.len(var_262_10)
				local var_262_13 = var_262_11 <= 0 and var_262_7 or var_262_7 * (var_262_12 / var_262_11)

				if var_262_13 > 0 and var_262_7 < var_262_13 then
					arg_259_1.talkMaxDuration = var_262_13

					if var_262_13 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_13 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_10
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531064", "story_v_out_122531.awb") ~= 0 then
					local var_262_14 = manager.audio:GetVoiceLength("story_v_out_122531", "122531064", "story_v_out_122531.awb") / 1000

					if var_262_14 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_14 + var_262_6
					end

					if var_262_9.prefab_name ~= "" and arg_259_1.actors_[var_262_9.prefab_name] ~= nil then
						local var_262_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_9.prefab_name].transform, "story_v_out_122531", "122531064", "story_v_out_122531.awb")

						arg_259_1:RecordAudio("122531064", var_262_15)
						arg_259_1:RecordAudio("122531064", var_262_15)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_122531", "122531064", "story_v_out_122531.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_122531", "122531064", "story_v_out_122531.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_16 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_16 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_16

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_16 and arg_259_1.time_ < var_262_6 + var_262_16 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play122531065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 122531065
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play122531066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1075ui_story"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect1075ui_story == nil then
				arg_263_1.var_.characterEffect1075ui_story = var_266_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.characterEffect1075ui_story and not isNil(var_266_0) then
					local var_266_4 = Mathf.Lerp(0, 0.5, var_266_3)

					arg_263_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1075ui_story.fillRatio = var_266_4
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect1075ui_story then
				local var_266_5 = 0.5

				arg_263_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1075ui_story.fillRatio = var_266_5
			end

			local var_266_6 = 0
			local var_266_7 = 1.075

			if var_266_6 < arg_263_1.time_ and arg_263_1.time_ <= var_266_6 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_8 = arg_263_1:FormatText(StoryNameCfg[7].name)

				arg_263_1.leftNameTxt_.text = var_266_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_9 = arg_263_1:GetWordFromCfg(122531065)
				local var_266_10 = arg_263_1:FormatText(var_266_9.content)

				arg_263_1.text_.text = var_266_10

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_11 = 43
				local var_266_12 = utf8.len(var_266_10)
				local var_266_13 = var_266_11 <= 0 and var_266_7 or var_266_7 * (var_266_12 / var_266_11)

				if var_266_13 > 0 and var_266_7 < var_266_13 then
					arg_263_1.talkMaxDuration = var_266_13

					if var_266_13 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_13 + var_266_6
					end
				end

				arg_263_1.text_.text = var_266_10
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_14 = math.max(var_266_7, arg_263_1.talkMaxDuration)

			if var_266_6 <= arg_263_1.time_ and arg_263_1.time_ < var_266_6 + var_266_14 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_6) / var_266_14

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_6 + var_266_14 and arg_263_1.time_ < var_266_6 + var_266_14 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play122531066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 122531066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play122531067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 0.75

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_2 = arg_267_1:FormatText(StoryNameCfg[7].name)

				arg_267_1.leftNameTxt_.text = var_270_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_3 = arg_267_1:GetWordFromCfg(122531066)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 30
				local var_270_6 = utf8.len(var_270_4)
				local var_270_7 = var_270_5 <= 0 and var_270_1 or var_270_1 * (var_270_6 / var_270_5)

				if var_270_7 > 0 and var_270_1 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_8 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_8 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_8

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_8 and arg_267_1.time_ < var_270_0 + var_270_8 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play122531067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 122531067
		arg_271_1.duration_ = 15.77

		local var_271_0 = {
			ja = 15.766,
			ko = 10.533,
			zh = 10.533
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play122531068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1075ui_story"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1075ui_story == nil then
				arg_271_1.var_.characterEffect1075ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.characterEffect1075ui_story and not isNil(var_274_0) then
					arg_271_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1075ui_story then
				arg_271_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_274_4 = 0

			if var_274_4 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action443")
			end

			local var_274_5 = 0

			if var_274_5 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_274_6 = 0
			local var_274_7 = 1.2

			if var_274_6 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_8 = arg_271_1:FormatText(StoryNameCfg[381].name)

				arg_271_1.leftNameTxt_.text = var_274_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_9 = arg_271_1:GetWordFromCfg(122531067)
				local var_274_10 = arg_271_1:FormatText(var_274_9.content)

				arg_271_1.text_.text = var_274_10

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_11 = 48
				local var_274_12 = utf8.len(var_274_10)
				local var_274_13 = var_274_11 <= 0 and var_274_7 or var_274_7 * (var_274_12 / var_274_11)

				if var_274_13 > 0 and var_274_7 < var_274_13 then
					arg_271_1.talkMaxDuration = var_274_13

					if var_274_13 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_13 + var_274_6
					end
				end

				arg_271_1.text_.text = var_274_10
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531067", "story_v_out_122531.awb") ~= 0 then
					local var_274_14 = manager.audio:GetVoiceLength("story_v_out_122531", "122531067", "story_v_out_122531.awb") / 1000

					if var_274_14 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_14 + var_274_6
					end

					if var_274_9.prefab_name ~= "" and arg_271_1.actors_[var_274_9.prefab_name] ~= nil then
						local var_274_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_9.prefab_name].transform, "story_v_out_122531", "122531067", "story_v_out_122531.awb")

						arg_271_1:RecordAudio("122531067", var_274_15)
						arg_271_1:RecordAudio("122531067", var_274_15)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_122531", "122531067", "story_v_out_122531.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_122531", "122531067", "story_v_out_122531.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_16 = math.max(var_274_7, arg_271_1.talkMaxDuration)

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_16 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_6) / var_274_16

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_6 + var_274_16 and arg_271_1.time_ < var_274_6 + var_274_16 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play122531068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 122531068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play122531069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1075ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1075ui_story == nil then
				arg_275_1.var_.characterEffect1075ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect1075ui_story and not isNil(var_278_0) then
					local var_278_4 = Mathf.Lerp(0, 0.5, var_278_3)

					arg_275_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1075ui_story.fillRatio = var_278_4
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1075ui_story then
				local var_278_5 = 0.5

				arg_275_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1075ui_story.fillRatio = var_278_5
			end

			local var_278_6 = 0
			local var_278_7 = 0.1

			if var_278_6 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_8 = arg_275_1:FormatText(StoryNameCfg[7].name)

				arg_275_1.leftNameTxt_.text = var_278_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_9 = arg_275_1:GetWordFromCfg(122531068)
				local var_278_10 = arg_275_1:FormatText(var_278_9.content)

				arg_275_1.text_.text = var_278_10

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_11 = 4
				local var_278_12 = utf8.len(var_278_10)
				local var_278_13 = var_278_11 <= 0 and var_278_7 or var_278_7 * (var_278_12 / var_278_11)

				if var_278_13 > 0 and var_278_7 < var_278_13 then
					arg_275_1.talkMaxDuration = var_278_13

					if var_278_13 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_13 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_10
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_14 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_14 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_14

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_14 and arg_275_1.time_ < var_278_6 + var_278_14 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play122531069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 122531069
		arg_279_1.duration_ = 8.9

		local var_279_0 = {
			ja = 8.9,
			ko = 4,
			zh = 4
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play122531070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1071ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos1071ui_story = var_282_0.localPosition
			end

			local var_282_2 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2
				local var_282_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1071ui_story, var_282_4, var_282_3)

				local var_282_5 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_5.x, var_282_5.y, var_282_5.z)

				local var_282_6 = var_282_0.localEulerAngles

				var_282_6.z = 0
				var_282_6.x = 0
				var_282_0.localEulerAngles = var_282_6
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_282_7 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_7.x, var_282_7.y, var_282_7.z)

				local var_282_8 = var_282_0.localEulerAngles

				var_282_8.z = 0
				var_282_8.x = 0
				var_282_0.localEulerAngles = var_282_8
			end

			local var_282_9 = arg_279_1.actors_["1071ui_story"]
			local var_282_10 = 0

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect1071ui_story == nil then
				arg_279_1.var_.characterEffect1071ui_story = var_282_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_11 = 0.200000002980232

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_11 and not isNil(var_282_9) then
				local var_282_12 = (arg_279_1.time_ - var_282_10) / var_282_11

				if arg_279_1.var_.characterEffect1071ui_story and not isNil(var_282_9) then
					arg_279_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_10 + var_282_11 and arg_279_1.time_ < var_282_10 + var_282_11 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect1071ui_story then
				arg_279_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_282_13 = 0

			if var_282_13 < arg_279_1.time_ and arg_279_1.time_ <= var_282_13 + arg_282_0 then
				arg_279_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_282_14 = arg_279_1.actors_["1075ui_story"].transform
			local var_282_15 = 0

			if var_282_15 < arg_279_1.time_ and arg_279_1.time_ <= var_282_15 + arg_282_0 then
				arg_279_1.var_.moveOldPos1075ui_story = var_282_14.localPosition
			end

			local var_282_16 = 0.001

			if var_282_15 <= arg_279_1.time_ and arg_279_1.time_ < var_282_15 + var_282_16 then
				local var_282_17 = (arg_279_1.time_ - var_282_15) / var_282_16
				local var_282_18 = Vector3.New(0.7, -1.055, -6.16)

				var_282_14.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1075ui_story, var_282_18, var_282_17)

				local var_282_19 = manager.ui.mainCamera.transform.position - var_282_14.position

				var_282_14.forward = Vector3.New(var_282_19.x, var_282_19.y, var_282_19.z)

				local var_282_20 = var_282_14.localEulerAngles

				var_282_20.z = 0
				var_282_20.x = 0
				var_282_14.localEulerAngles = var_282_20
			end

			if arg_279_1.time_ >= var_282_15 + var_282_16 and arg_279_1.time_ < var_282_15 + var_282_16 + arg_282_0 then
				var_282_14.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_282_21 = manager.ui.mainCamera.transform.position - var_282_14.position

				var_282_14.forward = Vector3.New(var_282_21.x, var_282_21.y, var_282_21.z)

				local var_282_22 = var_282_14.localEulerAngles

				var_282_22.z = 0
				var_282_22.x = 0
				var_282_14.localEulerAngles = var_282_22
			end

			local var_282_23 = arg_279_1.actors_["1075ui_story"]
			local var_282_24 = 0

			if var_282_24 < arg_279_1.time_ and arg_279_1.time_ <= var_282_24 + arg_282_0 and not isNil(var_282_23) and arg_279_1.var_.characterEffect1075ui_story == nil then
				arg_279_1.var_.characterEffect1075ui_story = var_282_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_25 = 0.200000002980232

			if var_282_24 <= arg_279_1.time_ and arg_279_1.time_ < var_282_24 + var_282_25 and not isNil(var_282_23) then
				local var_282_26 = (arg_279_1.time_ - var_282_24) / var_282_25

				if arg_279_1.var_.characterEffect1075ui_story and not isNil(var_282_23) then
					local var_282_27 = Mathf.Lerp(0, 0.5, var_282_26)

					arg_279_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1075ui_story.fillRatio = var_282_27
				end
			end

			if arg_279_1.time_ >= var_282_24 + var_282_25 and arg_279_1.time_ < var_282_24 + var_282_25 + arg_282_0 and not isNil(var_282_23) and arg_279_1.var_.characterEffect1075ui_story then
				local var_282_28 = 0.5

				arg_279_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1075ui_story.fillRatio = var_282_28
			end

			local var_282_29 = 0

			if var_282_29 < arg_279_1.time_ and arg_279_1.time_ <= var_282_29 + arg_282_0 then
				arg_279_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			local var_282_30 = 0

			if var_282_30 < arg_279_1.time_ and arg_279_1.time_ <= var_282_30 + arg_282_0 then
				arg_279_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_282_31 = 0
			local var_282_32 = 0.525

			if var_282_31 < arg_279_1.time_ and arg_279_1.time_ <= var_282_31 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_33 = arg_279_1:FormatText(StoryNameCfg[384].name)

				arg_279_1.leftNameTxt_.text = var_282_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_34 = arg_279_1:GetWordFromCfg(122531069)
				local var_282_35 = arg_279_1:FormatText(var_282_34.content)

				arg_279_1.text_.text = var_282_35

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_36 = 21
				local var_282_37 = utf8.len(var_282_35)
				local var_282_38 = var_282_36 <= 0 and var_282_32 or var_282_32 * (var_282_37 / var_282_36)

				if var_282_38 > 0 and var_282_32 < var_282_38 then
					arg_279_1.talkMaxDuration = var_282_38

					if var_282_38 + var_282_31 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_38 + var_282_31
					end
				end

				arg_279_1.text_.text = var_282_35
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531069", "story_v_out_122531.awb") ~= 0 then
					local var_282_39 = manager.audio:GetVoiceLength("story_v_out_122531", "122531069", "story_v_out_122531.awb") / 1000

					if var_282_39 + var_282_31 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_39 + var_282_31
					end

					if var_282_34.prefab_name ~= "" and arg_279_1.actors_[var_282_34.prefab_name] ~= nil then
						local var_282_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_34.prefab_name].transform, "story_v_out_122531", "122531069", "story_v_out_122531.awb")

						arg_279_1:RecordAudio("122531069", var_282_40)
						arg_279_1:RecordAudio("122531069", var_282_40)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_122531", "122531069", "story_v_out_122531.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_122531", "122531069", "story_v_out_122531.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_41 = math.max(var_282_32, arg_279_1.talkMaxDuration)

			if var_282_31 <= arg_279_1.time_ and arg_279_1.time_ < var_282_31 + var_282_41 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_31) / var_282_41

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_31 + var_282_41 and arg_279_1.time_ < var_282_31 + var_282_41 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play122531070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 122531070
		arg_283_1.duration_ = 7.73

		local var_283_0 = {
			ja = 7.733,
			ko = 7.6,
			zh = 7.6
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play122531071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1075ui_story"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1075ui_story == nil then
				arg_283_1.var_.characterEffect1075ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.characterEffect1075ui_story and not isNil(var_286_0) then
					arg_283_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1075ui_story then
				arg_283_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_286_4 = 0

			if var_286_4 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_286_5 = 0

			if var_286_5 < arg_283_1.time_ and arg_283_1.time_ <= var_286_5 + arg_286_0 then
				arg_283_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_286_6 = arg_283_1.actors_["1071ui_story"]
			local var_286_7 = 0

			if var_286_7 < arg_283_1.time_ and arg_283_1.time_ <= var_286_7 + arg_286_0 and not isNil(var_286_6) and arg_283_1.var_.characterEffect1071ui_story == nil then
				arg_283_1.var_.characterEffect1071ui_story = var_286_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_8 = 0.200000002980232

			if var_286_7 <= arg_283_1.time_ and arg_283_1.time_ < var_286_7 + var_286_8 and not isNil(var_286_6) then
				local var_286_9 = (arg_283_1.time_ - var_286_7) / var_286_8

				if arg_283_1.var_.characterEffect1071ui_story and not isNil(var_286_6) then
					local var_286_10 = Mathf.Lerp(0, 0.5, var_286_9)

					arg_283_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1071ui_story.fillRatio = var_286_10
				end
			end

			if arg_283_1.time_ >= var_286_7 + var_286_8 and arg_283_1.time_ < var_286_7 + var_286_8 + arg_286_0 and not isNil(var_286_6) and arg_283_1.var_.characterEffect1071ui_story then
				local var_286_11 = 0.5

				arg_283_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1071ui_story.fillRatio = var_286_11
			end

			local var_286_12 = 0
			local var_286_13 = 0.75

			if var_286_12 < arg_283_1.time_ and arg_283_1.time_ <= var_286_12 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_14 = arg_283_1:FormatText(StoryNameCfg[381].name)

				arg_283_1.leftNameTxt_.text = var_286_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_15 = arg_283_1:GetWordFromCfg(122531070)
				local var_286_16 = arg_283_1:FormatText(var_286_15.content)

				arg_283_1.text_.text = var_286_16

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_17 = 30
				local var_286_18 = utf8.len(var_286_16)
				local var_286_19 = var_286_17 <= 0 and var_286_13 or var_286_13 * (var_286_18 / var_286_17)

				if var_286_19 > 0 and var_286_13 < var_286_19 then
					arg_283_1.talkMaxDuration = var_286_19

					if var_286_19 + var_286_12 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_19 + var_286_12
					end
				end

				arg_283_1.text_.text = var_286_16
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531070", "story_v_out_122531.awb") ~= 0 then
					local var_286_20 = manager.audio:GetVoiceLength("story_v_out_122531", "122531070", "story_v_out_122531.awb") / 1000

					if var_286_20 + var_286_12 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_20 + var_286_12
					end

					if var_286_15.prefab_name ~= "" and arg_283_1.actors_[var_286_15.prefab_name] ~= nil then
						local var_286_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_15.prefab_name].transform, "story_v_out_122531", "122531070", "story_v_out_122531.awb")

						arg_283_1:RecordAudio("122531070", var_286_21)
						arg_283_1:RecordAudio("122531070", var_286_21)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_122531", "122531070", "story_v_out_122531.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_122531", "122531070", "story_v_out_122531.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_22 = math.max(var_286_13, arg_283_1.talkMaxDuration)

			if var_286_12 <= arg_283_1.time_ and arg_283_1.time_ < var_286_12 + var_286_22 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_12) / var_286_22

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_12 + var_286_22 and arg_283_1.time_ < var_286_12 + var_286_22 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play122531071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 122531071
		arg_287_1.duration_ = 6.2

		local var_287_0 = {
			ja = 6.2,
			ko = 3.8,
			zh = 3.8
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play122531072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0
			local var_290_1 = 0.4

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_2 = arg_287_1:FormatText(StoryNameCfg[381].name)

				arg_287_1.leftNameTxt_.text = var_290_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_3 = arg_287_1:GetWordFromCfg(122531071)
				local var_290_4 = arg_287_1:FormatText(var_290_3.content)

				arg_287_1.text_.text = var_290_4

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 16
				local var_290_6 = utf8.len(var_290_4)
				local var_290_7 = var_290_5 <= 0 and var_290_1 or var_290_1 * (var_290_6 / var_290_5)

				if var_290_7 > 0 and var_290_1 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_0
					end
				end

				arg_287_1.text_.text = var_290_4
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531071", "story_v_out_122531.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531071", "story_v_out_122531.awb") / 1000

					if var_290_8 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_0
					end

					if var_290_3.prefab_name ~= "" and arg_287_1.actors_[var_290_3.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_3.prefab_name].transform, "story_v_out_122531", "122531071", "story_v_out_122531.awb")

						arg_287_1:RecordAudio("122531071", var_290_9)
						arg_287_1:RecordAudio("122531071", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_122531", "122531071", "story_v_out_122531.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_122531", "122531071", "story_v_out_122531.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_1, arg_287_1.talkMaxDuration)

			if var_290_0 <= arg_287_1.time_ and arg_287_1.time_ < var_290_0 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_0) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_0 + var_290_10 and arg_287_1.time_ < var_290_0 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play122531072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 122531072
		arg_291_1.duration_ = 6.57

		local var_291_0 = {
			ja = 6.566,
			ko = 3.5,
			zh = 3.5
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play122531073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 0.625

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_2 = arg_291_1:FormatText(StoryNameCfg[381].name)

				arg_291_1.leftNameTxt_.text = var_294_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_3 = arg_291_1:GetWordFromCfg(122531072)
				local var_294_4 = arg_291_1:FormatText(var_294_3.content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 25
				local var_294_6 = utf8.len(var_294_4)
				local var_294_7 = var_294_5 <= 0 and var_294_1 or var_294_1 * (var_294_6 / var_294_5)

				if var_294_7 > 0 and var_294_1 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531072", "story_v_out_122531.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531072", "story_v_out_122531.awb") / 1000

					if var_294_8 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_0
					end

					if var_294_3.prefab_name ~= "" and arg_291_1.actors_[var_294_3.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_3.prefab_name].transform, "story_v_out_122531", "122531072", "story_v_out_122531.awb")

						arg_291_1:RecordAudio("122531072", var_294_9)
						arg_291_1:RecordAudio("122531072", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_122531", "122531072", "story_v_out_122531.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_122531", "122531072", "story_v_out_122531.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_10 and arg_291_1.time_ < var_294_0 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play122531073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 122531073
		arg_295_1.duration_ = 9

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play122531074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = "ST41"

			if arg_295_1.bgs_[var_298_0] == nil then
				local var_298_1 = Object.Instantiate(arg_295_1.paintGo_)

				var_298_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_298_0)
				var_298_1.name = var_298_0
				var_298_1.transform.parent = arg_295_1.stage_.transform
				var_298_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_295_1.bgs_[var_298_0] = var_298_1
			end

			local var_298_2 = 1.999999999999

			if var_298_2 < arg_295_1.time_ and arg_295_1.time_ <= var_298_2 + arg_298_0 then
				local var_298_3 = manager.ui.mainCamera.transform.localPosition
				local var_298_4 = Vector3.New(0, 0, 10) + Vector3.New(var_298_3.x, var_298_3.y, 0)
				local var_298_5 = arg_295_1.bgs_.ST41

				var_298_5.transform.localPosition = var_298_4
				var_298_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_298_6 = var_298_5:GetComponent("SpriteRenderer")

				if var_298_6 and var_298_6.sprite then
					local var_298_7 = (var_298_5.transform.localPosition - var_298_3).z
					local var_298_8 = manager.ui.mainCameraCom_
					local var_298_9 = 2 * var_298_7 * Mathf.Tan(var_298_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_298_10 = var_298_9 * var_298_8.aspect
					local var_298_11 = var_298_6.sprite.bounds.size.x
					local var_298_12 = var_298_6.sprite.bounds.size.y
					local var_298_13 = var_298_10 / var_298_11
					local var_298_14 = var_298_9 / var_298_12
					local var_298_15 = var_298_14 < var_298_13 and var_298_13 or var_298_14

					var_298_5.transform.localScale = Vector3.New(var_298_15, var_298_15, 0)
				end

				for iter_298_0, iter_298_1 in pairs(arg_295_1.bgs_) do
					if iter_298_0 ~= "ST41" then
						iter_298_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_298_16 = 0

			if var_298_16 < arg_295_1.time_ and arg_295_1.time_ <= var_298_16 + arg_298_0 then
				arg_295_1.mask_.enabled = true
				arg_295_1.mask_.raycastTarget = true

				arg_295_1:SetGaussion(false)
			end

			local var_298_17 = 2

			if var_298_16 <= arg_295_1.time_ and arg_295_1.time_ < var_298_16 + var_298_17 then
				local var_298_18 = (arg_295_1.time_ - var_298_16) / var_298_17
				local var_298_19 = Color.New(0, 0, 0)

				var_298_19.a = Mathf.Lerp(0, 1, var_298_18)
				arg_295_1.mask_.color = var_298_19
			end

			if arg_295_1.time_ >= var_298_16 + var_298_17 and arg_295_1.time_ < var_298_16 + var_298_17 + arg_298_0 then
				local var_298_20 = Color.New(0, 0, 0)

				var_298_20.a = 1
				arg_295_1.mask_.color = var_298_20
			end

			local var_298_21 = 2

			if var_298_21 < arg_295_1.time_ and arg_295_1.time_ <= var_298_21 + arg_298_0 then
				arg_295_1.mask_.enabled = true
				arg_295_1.mask_.raycastTarget = true

				arg_295_1:SetGaussion(false)
			end

			local var_298_22 = 2

			if var_298_21 <= arg_295_1.time_ and arg_295_1.time_ < var_298_21 + var_298_22 then
				local var_298_23 = (arg_295_1.time_ - var_298_21) / var_298_22
				local var_298_24 = Color.New(0, 0, 0)

				var_298_24.a = Mathf.Lerp(1, 0, var_298_23)
				arg_295_1.mask_.color = var_298_24
			end

			if arg_295_1.time_ >= var_298_21 + var_298_22 and arg_295_1.time_ < var_298_21 + var_298_22 + arg_298_0 then
				local var_298_25 = Color.New(0, 0, 0)
				local var_298_26 = 0

				arg_295_1.mask_.enabled = false
				var_298_25.a = var_298_26
				arg_295_1.mask_.color = var_298_25
			end

			local var_298_27 = arg_295_1.actors_["1071ui_story"].transform
			local var_298_28 = 1.96599999815226

			if var_298_28 < arg_295_1.time_ and arg_295_1.time_ <= var_298_28 + arg_298_0 then
				arg_295_1.var_.moveOldPos1071ui_story = var_298_27.localPosition
			end

			local var_298_29 = 0.001

			if var_298_28 <= arg_295_1.time_ and arg_295_1.time_ < var_298_28 + var_298_29 then
				local var_298_30 = (arg_295_1.time_ - var_298_28) / var_298_29
				local var_298_31 = Vector3.New(0, 100, 0)

				var_298_27.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1071ui_story, var_298_31, var_298_30)

				local var_298_32 = manager.ui.mainCamera.transform.position - var_298_27.position

				var_298_27.forward = Vector3.New(var_298_32.x, var_298_32.y, var_298_32.z)

				local var_298_33 = var_298_27.localEulerAngles

				var_298_33.z = 0
				var_298_33.x = 0
				var_298_27.localEulerAngles = var_298_33
			end

			if arg_295_1.time_ >= var_298_28 + var_298_29 and arg_295_1.time_ < var_298_28 + var_298_29 + arg_298_0 then
				var_298_27.localPosition = Vector3.New(0, 100, 0)

				local var_298_34 = manager.ui.mainCamera.transform.position - var_298_27.position

				var_298_27.forward = Vector3.New(var_298_34.x, var_298_34.y, var_298_34.z)

				local var_298_35 = var_298_27.localEulerAngles

				var_298_35.z = 0
				var_298_35.x = 0
				var_298_27.localEulerAngles = var_298_35
			end

			local var_298_36 = arg_295_1.actors_["1071ui_story"]
			local var_298_37 = 1.96599999815226

			if var_298_37 < arg_295_1.time_ and arg_295_1.time_ <= var_298_37 + arg_298_0 and not isNil(var_298_36) and arg_295_1.var_.characterEffect1071ui_story == nil then
				arg_295_1.var_.characterEffect1071ui_story = var_298_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_38 = 0.034000001847744

			if var_298_37 <= arg_295_1.time_ and arg_295_1.time_ < var_298_37 + var_298_38 and not isNil(var_298_36) then
				local var_298_39 = (arg_295_1.time_ - var_298_37) / var_298_38

				if arg_295_1.var_.characterEffect1071ui_story and not isNil(var_298_36) then
					local var_298_40 = Mathf.Lerp(0, 0.5, var_298_39)

					arg_295_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1071ui_story.fillRatio = var_298_40
				end
			end

			if arg_295_1.time_ >= var_298_37 + var_298_38 and arg_295_1.time_ < var_298_37 + var_298_38 + arg_298_0 and not isNil(var_298_36) and arg_295_1.var_.characterEffect1071ui_story then
				local var_298_41 = 0.5

				arg_295_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1071ui_story.fillRatio = var_298_41
			end

			local var_298_42 = arg_295_1.actors_["1075ui_story"].transform
			local var_298_43 = 1.96599999815226

			if var_298_43 < arg_295_1.time_ and arg_295_1.time_ <= var_298_43 + arg_298_0 then
				arg_295_1.var_.moveOldPos1075ui_story = var_298_42.localPosition
			end

			local var_298_44 = 0.001

			if var_298_43 <= arg_295_1.time_ and arg_295_1.time_ < var_298_43 + var_298_44 then
				local var_298_45 = (arg_295_1.time_ - var_298_43) / var_298_44
				local var_298_46 = Vector3.New(0, 100, 0)

				var_298_42.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1075ui_story, var_298_46, var_298_45)

				local var_298_47 = manager.ui.mainCamera.transform.position - var_298_42.position

				var_298_42.forward = Vector3.New(var_298_47.x, var_298_47.y, var_298_47.z)

				local var_298_48 = var_298_42.localEulerAngles

				var_298_48.z = 0
				var_298_48.x = 0
				var_298_42.localEulerAngles = var_298_48
			end

			if arg_295_1.time_ >= var_298_43 + var_298_44 and arg_295_1.time_ < var_298_43 + var_298_44 + arg_298_0 then
				var_298_42.localPosition = Vector3.New(0, 100, 0)

				local var_298_49 = manager.ui.mainCamera.transform.position - var_298_42.position

				var_298_42.forward = Vector3.New(var_298_49.x, var_298_49.y, var_298_49.z)

				local var_298_50 = var_298_42.localEulerAngles

				var_298_50.z = 0
				var_298_50.x = 0
				var_298_42.localEulerAngles = var_298_50
			end

			local var_298_51 = arg_295_1.actors_["1075ui_story"]
			local var_298_52 = 1.96599999815226

			if var_298_52 < arg_295_1.time_ and arg_295_1.time_ <= var_298_52 + arg_298_0 and not isNil(var_298_51) and arg_295_1.var_.characterEffect1075ui_story == nil then
				arg_295_1.var_.characterEffect1075ui_story = var_298_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_53 = 0.034000001847744

			if var_298_52 <= arg_295_1.time_ and arg_295_1.time_ < var_298_52 + var_298_53 and not isNil(var_298_51) then
				local var_298_54 = (arg_295_1.time_ - var_298_52) / var_298_53

				if arg_295_1.var_.characterEffect1075ui_story and not isNil(var_298_51) then
					local var_298_55 = Mathf.Lerp(0, 0.5, var_298_54)

					arg_295_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1075ui_story.fillRatio = var_298_55
				end
			end

			if arg_295_1.time_ >= var_298_52 + var_298_53 and arg_295_1.time_ < var_298_52 + var_298_53 + arg_298_0 and not isNil(var_298_51) and arg_295_1.var_.characterEffect1075ui_story then
				local var_298_56 = 0.5

				arg_295_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1075ui_story.fillRatio = var_298_56
			end

			if arg_295_1.frameCnt_ <= 1 then
				arg_295_1.dialog_:SetActive(false)
			end

			local var_298_57 = 3.999999999999
			local var_298_58 = 1.5

			if var_298_57 < arg_295_1.time_ and arg_295_1.time_ <= var_298_57 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0

				arg_295_1.dialog_:SetActive(true)

				arg_295_1.dialogCg_.alpha = 0

				local var_298_59 = LeanTween.value(arg_295_1.dialog_, 0, 1, 0.3)

				var_298_59:setOnUpdate(LuaHelper.FloatAction(function(arg_299_0)
					arg_295_1.dialogCg_.alpha = arg_299_0
				end))
				var_298_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_295_1.dialog_)
					var_298_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_295_1.duration_ = arg_295_1.duration_ + 0.3

				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_60 = arg_295_1:GetWordFromCfg(122531073)
				local var_298_61 = arg_295_1:FormatText(var_298_60.content)

				arg_295_1.text_.text = var_298_61

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_62 = 60
				local var_298_63 = utf8.len(var_298_61)
				local var_298_64 = var_298_62 <= 0 and var_298_58 or var_298_58 * (var_298_63 / var_298_62)

				if var_298_64 > 0 and var_298_58 < var_298_64 then
					arg_295_1.talkMaxDuration = var_298_64
					var_298_57 = var_298_57 + 0.3

					if var_298_64 + var_298_57 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_64 + var_298_57
					end
				end

				arg_295_1.text_.text = var_298_61
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_65 = var_298_57 + 0.3
			local var_298_66 = math.max(var_298_58, arg_295_1.talkMaxDuration)

			if var_298_65 <= arg_295_1.time_ and arg_295_1.time_ < var_298_65 + var_298_66 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_65) / var_298_66

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_65 + var_298_66 and arg_295_1.time_ < var_298_65 + var_298_66 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play122531074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 122531074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play122531075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 1

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_2 = arg_301_1:GetWordFromCfg(122531074)
				local var_304_3 = arg_301_1:FormatText(var_304_2.content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 40
				local var_304_5 = utf8.len(var_304_3)
				local var_304_6 = var_304_4 <= 0 and var_304_1 or var_304_1 * (var_304_5 / var_304_4)

				if var_304_6 > 0 and var_304_1 < var_304_6 then
					arg_301_1.talkMaxDuration = var_304_6

					if var_304_6 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_6 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_7 and arg_301_1.time_ < var_304_0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play122531075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 122531075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play122531076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.75

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_2 = arg_305_1:GetWordFromCfg(122531075)
				local var_308_3 = arg_305_1:FormatText(var_308_2.content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 30
				local var_308_5 = utf8.len(var_308_3)
				local var_308_6 = var_308_4 <= 0 and var_308_1 or var_308_1 * (var_308_5 / var_308_4)

				if var_308_6 > 0 and var_308_1 < var_308_6 then
					arg_305_1.talkMaxDuration = var_308_6

					if var_308_6 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_6 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_7 and arg_305_1.time_ < var_308_0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play122531076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 122531076
		arg_309_1.duration_ = 2.43

		local var_309_0 = {
			ja = 2.433,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play122531077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1071ui_story"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos1071ui_story = var_312_0.localPosition
			end

			local var_312_2 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2
				local var_312_4 = Vector3.New(0, -1.05, -6.2)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1071ui_story, var_312_4, var_312_3)

				local var_312_5 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_5.x, var_312_5.y, var_312_5.z)

				local var_312_6 = var_312_0.localEulerAngles

				var_312_6.z = 0
				var_312_6.x = 0
				var_312_0.localEulerAngles = var_312_6
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_312_7 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_7.x, var_312_7.y, var_312_7.z)

				local var_312_8 = var_312_0.localEulerAngles

				var_312_8.z = 0
				var_312_8.x = 0
				var_312_0.localEulerAngles = var_312_8
			end

			local var_312_9 = arg_309_1.actors_["1071ui_story"]
			local var_312_10 = 0

			if var_312_10 < arg_309_1.time_ and arg_309_1.time_ <= var_312_10 + arg_312_0 and not isNil(var_312_9) and arg_309_1.var_.characterEffect1071ui_story == nil then
				arg_309_1.var_.characterEffect1071ui_story = var_312_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_11 = 0.200000002980232

			if var_312_10 <= arg_309_1.time_ and arg_309_1.time_ < var_312_10 + var_312_11 and not isNil(var_312_9) then
				local var_312_12 = (arg_309_1.time_ - var_312_10) / var_312_11

				if arg_309_1.var_.characterEffect1071ui_story and not isNil(var_312_9) then
					arg_309_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_10 + var_312_11 and arg_309_1.time_ < var_312_10 + var_312_11 + arg_312_0 and not isNil(var_312_9) and arg_309_1.var_.characterEffect1071ui_story then
				arg_309_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_312_13 = 0

			if var_312_13 < arg_309_1.time_ and arg_309_1.time_ <= var_312_13 + arg_312_0 then
				arg_309_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_312_14 = 0

			if var_312_14 < arg_309_1.time_ and arg_309_1.time_ <= var_312_14 + arg_312_0 then
				arg_309_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_312_15 = 0
			local var_312_16 = 0.1

			if var_312_15 < arg_309_1.time_ and arg_309_1.time_ <= var_312_15 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_17 = arg_309_1:FormatText(StoryNameCfg[384].name)

				arg_309_1.leftNameTxt_.text = var_312_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_18 = arg_309_1:GetWordFromCfg(122531076)
				local var_312_19 = arg_309_1:FormatText(var_312_18.content)

				arg_309_1.text_.text = var_312_19

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_20 = 4
				local var_312_21 = utf8.len(var_312_19)
				local var_312_22 = var_312_20 <= 0 and var_312_16 or var_312_16 * (var_312_21 / var_312_20)

				if var_312_22 > 0 and var_312_16 < var_312_22 then
					arg_309_1.talkMaxDuration = var_312_22

					if var_312_22 + var_312_15 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_22 + var_312_15
					end
				end

				arg_309_1.text_.text = var_312_19
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531076", "story_v_out_122531.awb") ~= 0 then
					local var_312_23 = manager.audio:GetVoiceLength("story_v_out_122531", "122531076", "story_v_out_122531.awb") / 1000

					if var_312_23 + var_312_15 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_23 + var_312_15
					end

					if var_312_18.prefab_name ~= "" and arg_309_1.actors_[var_312_18.prefab_name] ~= nil then
						local var_312_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_18.prefab_name].transform, "story_v_out_122531", "122531076", "story_v_out_122531.awb")

						arg_309_1:RecordAudio("122531076", var_312_24)
						arg_309_1:RecordAudio("122531076", var_312_24)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_122531", "122531076", "story_v_out_122531.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_122531", "122531076", "story_v_out_122531.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_25 = math.max(var_312_16, arg_309_1.talkMaxDuration)

			if var_312_15 <= arg_309_1.time_ and arg_309_1.time_ < var_312_15 + var_312_25 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_15) / var_312_25

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_15 + var_312_25 and arg_309_1.time_ < var_312_15 + var_312_25 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play122531077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 122531077
		arg_313_1.duration_ = 7.2

		local var_313_0 = {
			ja = 7.2,
			ko = 4.933,
			zh = 4.933
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play122531078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1075ui_story"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos1075ui_story = var_316_0.localPosition
			end

			local var_316_2 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2
				local var_316_4 = Vector3.New(0, -1.055, -6.16)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1075ui_story, var_316_4, var_316_3)

				local var_316_5 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_5.x, var_316_5.y, var_316_5.z)

				local var_316_6 = var_316_0.localEulerAngles

				var_316_6.z = 0
				var_316_6.x = 0
				var_316_0.localEulerAngles = var_316_6
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_316_7 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_7.x, var_316_7.y, var_316_7.z)

				local var_316_8 = var_316_0.localEulerAngles

				var_316_8.z = 0
				var_316_8.x = 0
				var_316_0.localEulerAngles = var_316_8
			end

			local var_316_9 = arg_313_1.actors_["1075ui_story"]
			local var_316_10 = 0

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1075ui_story == nil then
				arg_313_1.var_.characterEffect1075ui_story = var_316_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_11 = 0.200000002980232

			if var_316_10 <= arg_313_1.time_ and arg_313_1.time_ < var_316_10 + var_316_11 and not isNil(var_316_9) then
				local var_316_12 = (arg_313_1.time_ - var_316_10) / var_316_11

				if arg_313_1.var_.characterEffect1075ui_story and not isNil(var_316_9) then
					arg_313_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_10 + var_316_11 and arg_313_1.time_ < var_316_10 + var_316_11 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1075ui_story then
				arg_313_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_316_13 = 0

			if var_316_13 < arg_313_1.time_ and arg_313_1.time_ <= var_316_13 + arg_316_0 then
				arg_313_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_316_14 = 0

			if var_316_14 < arg_313_1.time_ and arg_313_1.time_ <= var_316_14 + arg_316_0 then
				arg_313_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_316_15 = arg_313_1.actors_["1071ui_story"].transform
			local var_316_16 = 0

			if var_316_16 < arg_313_1.time_ and arg_313_1.time_ <= var_316_16 + arg_316_0 then
				arg_313_1.var_.moveOldPos1071ui_story = var_316_15.localPosition
			end

			local var_316_17 = 0.001

			if var_316_16 <= arg_313_1.time_ and arg_313_1.time_ < var_316_16 + var_316_17 then
				local var_316_18 = (arg_313_1.time_ - var_316_16) / var_316_17
				local var_316_19 = Vector3.New(0, 100, 0)

				var_316_15.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1071ui_story, var_316_19, var_316_18)

				local var_316_20 = manager.ui.mainCamera.transform.position - var_316_15.position

				var_316_15.forward = Vector3.New(var_316_20.x, var_316_20.y, var_316_20.z)

				local var_316_21 = var_316_15.localEulerAngles

				var_316_21.z = 0
				var_316_21.x = 0
				var_316_15.localEulerAngles = var_316_21
			end

			if arg_313_1.time_ >= var_316_16 + var_316_17 and arg_313_1.time_ < var_316_16 + var_316_17 + arg_316_0 then
				var_316_15.localPosition = Vector3.New(0, 100, 0)

				local var_316_22 = manager.ui.mainCamera.transform.position - var_316_15.position

				var_316_15.forward = Vector3.New(var_316_22.x, var_316_22.y, var_316_22.z)

				local var_316_23 = var_316_15.localEulerAngles

				var_316_23.z = 0
				var_316_23.x = 0
				var_316_15.localEulerAngles = var_316_23
			end

			local var_316_24 = arg_313_1.actors_["1071ui_story"]
			local var_316_25 = 0

			if var_316_25 < arg_313_1.time_ and arg_313_1.time_ <= var_316_25 + arg_316_0 and not isNil(var_316_24) and arg_313_1.var_.characterEffect1071ui_story == nil then
				arg_313_1.var_.characterEffect1071ui_story = var_316_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_26 = 0.200000002980232

			if var_316_25 <= arg_313_1.time_ and arg_313_1.time_ < var_316_25 + var_316_26 and not isNil(var_316_24) then
				local var_316_27 = (arg_313_1.time_ - var_316_25) / var_316_26

				if arg_313_1.var_.characterEffect1071ui_story and not isNil(var_316_24) then
					local var_316_28 = Mathf.Lerp(0, 0.5, var_316_27)

					arg_313_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1071ui_story.fillRatio = var_316_28
				end
			end

			if arg_313_1.time_ >= var_316_25 + var_316_26 and arg_313_1.time_ < var_316_25 + var_316_26 + arg_316_0 and not isNil(var_316_24) and arg_313_1.var_.characterEffect1071ui_story then
				local var_316_29 = 0.5

				arg_313_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1071ui_story.fillRatio = var_316_29
			end

			local var_316_30 = 0
			local var_316_31 = 0.6

			if var_316_30 < arg_313_1.time_ and arg_313_1.time_ <= var_316_30 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_32 = arg_313_1:FormatText(StoryNameCfg[381].name)

				arg_313_1.leftNameTxt_.text = var_316_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_33 = arg_313_1:GetWordFromCfg(122531077)
				local var_316_34 = arg_313_1:FormatText(var_316_33.content)

				arg_313_1.text_.text = var_316_34

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_35 = 24
				local var_316_36 = utf8.len(var_316_34)
				local var_316_37 = var_316_35 <= 0 and var_316_31 or var_316_31 * (var_316_36 / var_316_35)

				if var_316_37 > 0 and var_316_31 < var_316_37 then
					arg_313_1.talkMaxDuration = var_316_37

					if var_316_37 + var_316_30 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_37 + var_316_30
					end
				end

				arg_313_1.text_.text = var_316_34
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531077", "story_v_out_122531.awb") ~= 0 then
					local var_316_38 = manager.audio:GetVoiceLength("story_v_out_122531", "122531077", "story_v_out_122531.awb") / 1000

					if var_316_38 + var_316_30 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_38 + var_316_30
					end

					if var_316_33.prefab_name ~= "" and arg_313_1.actors_[var_316_33.prefab_name] ~= nil then
						local var_316_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_33.prefab_name].transform, "story_v_out_122531", "122531077", "story_v_out_122531.awb")

						arg_313_1:RecordAudio("122531077", var_316_39)
						arg_313_1:RecordAudio("122531077", var_316_39)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_122531", "122531077", "story_v_out_122531.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_122531", "122531077", "story_v_out_122531.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_40 = math.max(var_316_31, arg_313_1.talkMaxDuration)

			if var_316_30 <= arg_313_1.time_ and arg_313_1.time_ < var_316_30 + var_316_40 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_30) / var_316_40

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_30 + var_316_40 and arg_313_1.time_ < var_316_30 + var_316_40 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play122531078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 122531078
		arg_317_1.duration_ = 6.9

		local var_317_0 = {
			ja = 6.9,
			ko = 5.533,
			zh = 5.533
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play122531079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = "1069ui_story"

			if arg_317_1.actors_[var_320_0] == nil then
				local var_320_1 = Asset.Load("Char/" .. "1069ui_story")

				if not isNil(var_320_1) then
					local var_320_2 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_317_1.stage_.transform)

					var_320_2.name = var_320_0
					var_320_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_317_1.actors_[var_320_0] = var_320_2

					local var_320_3 = var_320_2:GetComponentInChildren(typeof(CharacterEffect))

					var_320_3.enabled = true

					local var_320_4 = GameObjectTools.GetOrAddComponent(var_320_2, typeof(DynamicBoneHelper))

					if var_320_4 then
						var_320_4:EnableDynamicBone(false)
					end

					arg_317_1:ShowWeapon(var_320_3.transform, false)

					arg_317_1.var_[var_320_0 .. "Animator"] = var_320_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_317_1.var_[var_320_0 .. "Animator"].applyRootMotion = true
					arg_317_1.var_[var_320_0 .. "LipSync"] = var_320_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_320_5 = arg_317_1.actors_["1069ui_story"].transform
			local var_320_6 = 0

			if var_320_6 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1.var_.moveOldPos1069ui_story = var_320_5.localPosition
			end

			local var_320_7 = 0.001

			if var_320_6 <= arg_317_1.time_ and arg_317_1.time_ < var_320_6 + var_320_7 then
				local var_320_8 = (arg_317_1.time_ - var_320_6) / var_320_7
				local var_320_9 = Vector3.New(0, -1, -6)

				var_320_5.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1069ui_story, var_320_9, var_320_8)

				local var_320_10 = manager.ui.mainCamera.transform.position - var_320_5.position

				var_320_5.forward = Vector3.New(var_320_10.x, var_320_10.y, var_320_10.z)

				local var_320_11 = var_320_5.localEulerAngles

				var_320_11.z = 0
				var_320_11.x = 0
				var_320_5.localEulerAngles = var_320_11
			end

			if arg_317_1.time_ >= var_320_6 + var_320_7 and arg_317_1.time_ < var_320_6 + var_320_7 + arg_320_0 then
				var_320_5.localPosition = Vector3.New(0, -1, -6)

				local var_320_12 = manager.ui.mainCamera.transform.position - var_320_5.position

				var_320_5.forward = Vector3.New(var_320_12.x, var_320_12.y, var_320_12.z)

				local var_320_13 = var_320_5.localEulerAngles

				var_320_13.z = 0
				var_320_13.x = 0
				var_320_5.localEulerAngles = var_320_13
			end

			local var_320_14 = arg_317_1.actors_["1069ui_story"]
			local var_320_15 = 0

			if var_320_15 < arg_317_1.time_ and arg_317_1.time_ <= var_320_15 + arg_320_0 and not isNil(var_320_14) and arg_317_1.var_.characterEffect1069ui_story == nil then
				arg_317_1.var_.characterEffect1069ui_story = var_320_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_16 = 0.200000002980232

			if var_320_15 <= arg_317_1.time_ and arg_317_1.time_ < var_320_15 + var_320_16 and not isNil(var_320_14) then
				local var_320_17 = (arg_317_1.time_ - var_320_15) / var_320_16

				if arg_317_1.var_.characterEffect1069ui_story and not isNil(var_320_14) then
					arg_317_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_15 + var_320_16 and arg_317_1.time_ < var_320_15 + var_320_16 + arg_320_0 and not isNil(var_320_14) and arg_317_1.var_.characterEffect1069ui_story then
				arg_317_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_320_18 = 0

			if var_320_18 < arg_317_1.time_ and arg_317_1.time_ <= var_320_18 + arg_320_0 then
				arg_317_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_320_19 = 0

			if var_320_19 < arg_317_1.time_ and arg_317_1.time_ <= var_320_19 + arg_320_0 then
				arg_317_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_320_20 = arg_317_1.actors_["1075ui_story"].transform
			local var_320_21 = 0

			if var_320_21 < arg_317_1.time_ and arg_317_1.time_ <= var_320_21 + arg_320_0 then
				arg_317_1.var_.moveOldPos1075ui_story = var_320_20.localPosition
			end

			local var_320_22 = 0.001

			if var_320_21 <= arg_317_1.time_ and arg_317_1.time_ < var_320_21 + var_320_22 then
				local var_320_23 = (arg_317_1.time_ - var_320_21) / var_320_22
				local var_320_24 = Vector3.New(0, 100, 0)

				var_320_20.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1075ui_story, var_320_24, var_320_23)

				local var_320_25 = manager.ui.mainCamera.transform.position - var_320_20.position

				var_320_20.forward = Vector3.New(var_320_25.x, var_320_25.y, var_320_25.z)

				local var_320_26 = var_320_20.localEulerAngles

				var_320_26.z = 0
				var_320_26.x = 0
				var_320_20.localEulerAngles = var_320_26
			end

			if arg_317_1.time_ >= var_320_21 + var_320_22 and arg_317_1.time_ < var_320_21 + var_320_22 + arg_320_0 then
				var_320_20.localPosition = Vector3.New(0, 100, 0)

				local var_320_27 = manager.ui.mainCamera.transform.position - var_320_20.position

				var_320_20.forward = Vector3.New(var_320_27.x, var_320_27.y, var_320_27.z)

				local var_320_28 = var_320_20.localEulerAngles

				var_320_28.z = 0
				var_320_28.x = 0
				var_320_20.localEulerAngles = var_320_28
			end

			local var_320_29 = arg_317_1.actors_["1075ui_story"]
			local var_320_30 = 0

			if var_320_30 < arg_317_1.time_ and arg_317_1.time_ <= var_320_30 + arg_320_0 and not isNil(var_320_29) and arg_317_1.var_.characterEffect1075ui_story == nil then
				arg_317_1.var_.characterEffect1075ui_story = var_320_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_31 = 0.200000002980232

			if var_320_30 <= arg_317_1.time_ and arg_317_1.time_ < var_320_30 + var_320_31 and not isNil(var_320_29) then
				local var_320_32 = (arg_317_1.time_ - var_320_30) / var_320_31

				if arg_317_1.var_.characterEffect1075ui_story and not isNil(var_320_29) then
					local var_320_33 = Mathf.Lerp(0, 0.5, var_320_32)

					arg_317_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1075ui_story.fillRatio = var_320_33
				end
			end

			if arg_317_1.time_ >= var_320_30 + var_320_31 and arg_317_1.time_ < var_320_30 + var_320_31 + arg_320_0 and not isNil(var_320_29) and arg_317_1.var_.characterEffect1075ui_story then
				local var_320_34 = 0.5

				arg_317_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1075ui_story.fillRatio = var_320_34
			end

			local var_320_35 = 0
			local var_320_36 = 0.45

			if var_320_35 < arg_317_1.time_ and arg_317_1.time_ <= var_320_35 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_37 = arg_317_1:FormatText(StoryNameCfg[378].name)

				arg_317_1.leftNameTxt_.text = var_320_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_38 = arg_317_1:GetWordFromCfg(122531078)
				local var_320_39 = arg_317_1:FormatText(var_320_38.content)

				arg_317_1.text_.text = var_320_39

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_40 = 18
				local var_320_41 = utf8.len(var_320_39)
				local var_320_42 = var_320_40 <= 0 and var_320_36 or var_320_36 * (var_320_41 / var_320_40)

				if var_320_42 > 0 and var_320_36 < var_320_42 then
					arg_317_1.talkMaxDuration = var_320_42

					if var_320_42 + var_320_35 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_42 + var_320_35
					end
				end

				arg_317_1.text_.text = var_320_39
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531078", "story_v_out_122531.awb") ~= 0 then
					local var_320_43 = manager.audio:GetVoiceLength("story_v_out_122531", "122531078", "story_v_out_122531.awb") / 1000

					if var_320_43 + var_320_35 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_43 + var_320_35
					end

					if var_320_38.prefab_name ~= "" and arg_317_1.actors_[var_320_38.prefab_name] ~= nil then
						local var_320_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_38.prefab_name].transform, "story_v_out_122531", "122531078", "story_v_out_122531.awb")

						arg_317_1:RecordAudio("122531078", var_320_44)
						arg_317_1:RecordAudio("122531078", var_320_44)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_122531", "122531078", "story_v_out_122531.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_122531", "122531078", "story_v_out_122531.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_45 = math.max(var_320_36, arg_317_1.talkMaxDuration)

			if var_320_35 <= arg_317_1.time_ and arg_317_1.time_ < var_320_35 + var_320_45 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_35) / var_320_45

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_35 + var_320_45 and arg_317_1.time_ < var_320_35 + var_320_45 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play122531079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 122531079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play122531080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1069ui_story"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos1069ui_story = var_324_0.localPosition
			end

			local var_324_2 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2
				local var_324_4 = Vector3.New(0, 100, 0)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1069ui_story, var_324_4, var_324_3)

				local var_324_5 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_5.x, var_324_5.y, var_324_5.z)

				local var_324_6 = var_324_0.localEulerAngles

				var_324_6.z = 0
				var_324_6.x = 0
				var_324_0.localEulerAngles = var_324_6
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(0, 100, 0)

				local var_324_7 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_7.x, var_324_7.y, var_324_7.z)

				local var_324_8 = var_324_0.localEulerAngles

				var_324_8.z = 0
				var_324_8.x = 0
				var_324_0.localEulerAngles = var_324_8
			end

			local var_324_9 = arg_321_1.actors_["1075ui_story"]
			local var_324_10 = 0

			if var_324_10 < arg_321_1.time_ and arg_321_1.time_ <= var_324_10 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1075ui_story == nil then
				arg_321_1.var_.characterEffect1075ui_story = var_324_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_11 = 0.200000002980232

			if var_324_10 <= arg_321_1.time_ and arg_321_1.time_ < var_324_10 + var_324_11 and not isNil(var_324_9) then
				local var_324_12 = (arg_321_1.time_ - var_324_10) / var_324_11

				if arg_321_1.var_.characterEffect1075ui_story and not isNil(var_324_9) then
					local var_324_13 = Mathf.Lerp(0, 0.5, var_324_12)

					arg_321_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1075ui_story.fillRatio = var_324_13
				end
			end

			if arg_321_1.time_ >= var_324_10 + var_324_11 and arg_321_1.time_ < var_324_10 + var_324_11 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1075ui_story then
				local var_324_14 = 0.5

				arg_321_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1075ui_story.fillRatio = var_324_14
			end

			local var_324_15 = arg_321_1.actors_["1069ui_story"]
			local var_324_16 = 0

			if var_324_16 < arg_321_1.time_ and arg_321_1.time_ <= var_324_16 + arg_324_0 and not isNil(var_324_15) and arg_321_1.var_.characterEffect1069ui_story == nil then
				arg_321_1.var_.characterEffect1069ui_story = var_324_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_17 = 0.200000002980232

			if var_324_16 <= arg_321_1.time_ and arg_321_1.time_ < var_324_16 + var_324_17 and not isNil(var_324_15) then
				local var_324_18 = (arg_321_1.time_ - var_324_16) / var_324_17

				if arg_321_1.var_.characterEffect1069ui_story and not isNil(var_324_15) then
					local var_324_19 = Mathf.Lerp(0, 0.5, var_324_18)

					arg_321_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1069ui_story.fillRatio = var_324_19
				end
			end

			if arg_321_1.time_ >= var_324_16 + var_324_17 and arg_321_1.time_ < var_324_16 + var_324_17 + arg_324_0 and not isNil(var_324_15) and arg_321_1.var_.characterEffect1069ui_story then
				local var_324_20 = 0.5

				arg_321_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1069ui_story.fillRatio = var_324_20
			end

			local var_324_21 = 0
			local var_324_22 = 0.6

			if var_324_21 < arg_321_1.time_ and arg_321_1.time_ <= var_324_21 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_23 = arg_321_1:GetWordFromCfg(122531079)
				local var_324_24 = arg_321_1:FormatText(var_324_23.content)

				arg_321_1.text_.text = var_324_24

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_25 = 24
				local var_324_26 = utf8.len(var_324_24)
				local var_324_27 = var_324_25 <= 0 and var_324_22 or var_324_22 * (var_324_26 / var_324_25)

				if var_324_27 > 0 and var_324_22 < var_324_27 then
					arg_321_1.talkMaxDuration = var_324_27

					if var_324_27 + var_324_21 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_27 + var_324_21
					end
				end

				arg_321_1.text_.text = var_324_24
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_28 = math.max(var_324_22, arg_321_1.talkMaxDuration)

			if var_324_21 <= arg_321_1.time_ and arg_321_1.time_ < var_324_21 + var_324_28 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_21) / var_324_28

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_21 + var_324_28 and arg_321_1.time_ < var_324_21 + var_324_28 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play122531080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 122531080
		arg_325_1.duration_ = 8.27

		local var_325_0 = {
			ja = 8.266,
			ko = 5.8,
			zh = 5.8
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play122531081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1071ui_story"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos1071ui_story = var_328_0.localPosition
			end

			local var_328_2 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2
				local var_328_4 = Vector3.New(0, -1.05, -6.2)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1071ui_story, var_328_4, var_328_3)

				local var_328_5 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_5.x, var_328_5.y, var_328_5.z)

				local var_328_6 = var_328_0.localEulerAngles

				var_328_6.z = 0
				var_328_6.x = 0
				var_328_0.localEulerAngles = var_328_6
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_328_7 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_7.x, var_328_7.y, var_328_7.z)

				local var_328_8 = var_328_0.localEulerAngles

				var_328_8.z = 0
				var_328_8.x = 0
				var_328_0.localEulerAngles = var_328_8
			end

			local var_328_9 = arg_325_1.actors_["1071ui_story"]
			local var_328_10 = 0

			if var_328_10 < arg_325_1.time_ and arg_325_1.time_ <= var_328_10 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1071ui_story == nil then
				arg_325_1.var_.characterEffect1071ui_story = var_328_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_11 = 0.200000002980232

			if var_328_10 <= arg_325_1.time_ and arg_325_1.time_ < var_328_10 + var_328_11 and not isNil(var_328_9) then
				local var_328_12 = (arg_325_1.time_ - var_328_10) / var_328_11

				if arg_325_1.var_.characterEffect1071ui_story and not isNil(var_328_9) then
					arg_325_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_10 + var_328_11 and arg_325_1.time_ < var_328_10 + var_328_11 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1071ui_story then
				arg_325_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_328_13 = 0

			if var_328_13 < arg_325_1.time_ and arg_325_1.time_ <= var_328_13 + arg_328_0 then
				arg_325_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_328_14 = 0
			local var_328_15 = 0.45

			if var_328_14 < arg_325_1.time_ and arg_325_1.time_ <= var_328_14 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_16 = arg_325_1:FormatText(StoryNameCfg[384].name)

				arg_325_1.leftNameTxt_.text = var_328_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_17 = arg_325_1:GetWordFromCfg(122531080)
				local var_328_18 = arg_325_1:FormatText(var_328_17.content)

				arg_325_1.text_.text = var_328_18

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_19 = 18
				local var_328_20 = utf8.len(var_328_18)
				local var_328_21 = var_328_19 <= 0 and var_328_15 or var_328_15 * (var_328_20 / var_328_19)

				if var_328_21 > 0 and var_328_15 < var_328_21 then
					arg_325_1.talkMaxDuration = var_328_21

					if var_328_21 + var_328_14 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_21 + var_328_14
					end
				end

				arg_325_1.text_.text = var_328_18
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531080", "story_v_out_122531.awb") ~= 0 then
					local var_328_22 = manager.audio:GetVoiceLength("story_v_out_122531", "122531080", "story_v_out_122531.awb") / 1000

					if var_328_22 + var_328_14 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_22 + var_328_14
					end

					if var_328_17.prefab_name ~= "" and arg_325_1.actors_[var_328_17.prefab_name] ~= nil then
						local var_328_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_17.prefab_name].transform, "story_v_out_122531", "122531080", "story_v_out_122531.awb")

						arg_325_1:RecordAudio("122531080", var_328_23)
						arg_325_1:RecordAudio("122531080", var_328_23)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_122531", "122531080", "story_v_out_122531.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_122531", "122531080", "story_v_out_122531.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_24 = math.max(var_328_15, arg_325_1.talkMaxDuration)

			if var_328_14 <= arg_325_1.time_ and arg_325_1.time_ < var_328_14 + var_328_24 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_14) / var_328_24

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_14 + var_328_24 and arg_325_1.time_ < var_328_14 + var_328_24 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play122531081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 122531081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play122531082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1071ui_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1071ui_story == nil then
				arg_329_1.var_.characterEffect1071ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect1071ui_story and not isNil(var_332_0) then
					local var_332_4 = Mathf.Lerp(0, 0.5, var_332_3)

					arg_329_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1071ui_story.fillRatio = var_332_4
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1071ui_story then
				local var_332_5 = 0.5

				arg_329_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1071ui_story.fillRatio = var_332_5
			end

			local var_332_6 = 0
			local var_332_7 = 0.9

			if var_332_6 < arg_329_1.time_ and arg_329_1.time_ <= var_332_6 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_8 = arg_329_1:GetWordFromCfg(122531081)
				local var_332_9 = arg_329_1:FormatText(var_332_8.content)

				arg_329_1.text_.text = var_332_9

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_10 = 36
				local var_332_11 = utf8.len(var_332_9)
				local var_332_12 = var_332_10 <= 0 and var_332_7 or var_332_7 * (var_332_11 / var_332_10)

				if var_332_12 > 0 and var_332_7 < var_332_12 then
					arg_329_1.talkMaxDuration = var_332_12

					if var_332_12 + var_332_6 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_12 + var_332_6
					end
				end

				arg_329_1.text_.text = var_332_9
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_13 = math.max(var_332_7, arg_329_1.talkMaxDuration)

			if var_332_6 <= arg_329_1.time_ and arg_329_1.time_ < var_332_6 + var_332_13 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_6) / var_332_13

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_6 + var_332_13 and arg_329_1.time_ < var_332_6 + var_332_13 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play122531082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 122531082
		arg_333_1.duration_ = 17.03

		local var_333_0 = {
			ja = 17.033,
			ko = 9.933,
			zh = 9.933
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play122531083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1071ui_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1071ui_story == nil then
				arg_333_1.var_.characterEffect1071ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect1071ui_story and not isNil(var_336_0) then
					arg_333_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1071ui_story then
				arg_333_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_336_4 = 0

			if var_336_4 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_336_5 = 0

			if var_336_5 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 then
				arg_333_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_336_6 = 0
			local var_336_7 = 1.05

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_8 = arg_333_1:FormatText(StoryNameCfg[384].name)

				arg_333_1.leftNameTxt_.text = var_336_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_9 = arg_333_1:GetWordFromCfg(122531082)
				local var_336_10 = arg_333_1:FormatText(var_336_9.content)

				arg_333_1.text_.text = var_336_10

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 42
				local var_336_12 = utf8.len(var_336_10)
				local var_336_13 = var_336_11 <= 0 and var_336_7 or var_336_7 * (var_336_12 / var_336_11)

				if var_336_13 > 0 and var_336_7 < var_336_13 then
					arg_333_1.talkMaxDuration = var_336_13

					if var_336_13 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_13 + var_336_6
					end
				end

				arg_333_1.text_.text = var_336_10
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531082", "story_v_out_122531.awb") ~= 0 then
					local var_336_14 = manager.audio:GetVoiceLength("story_v_out_122531", "122531082", "story_v_out_122531.awb") / 1000

					if var_336_14 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_14 + var_336_6
					end

					if var_336_9.prefab_name ~= "" and arg_333_1.actors_[var_336_9.prefab_name] ~= nil then
						local var_336_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_9.prefab_name].transform, "story_v_out_122531", "122531082", "story_v_out_122531.awb")

						arg_333_1:RecordAudio("122531082", var_336_15)
						arg_333_1:RecordAudio("122531082", var_336_15)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_122531", "122531082", "story_v_out_122531.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_122531", "122531082", "story_v_out_122531.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_16 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_16 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_16

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_16 and arg_333_1.time_ < var_336_6 + var_336_16 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play122531083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 122531083
		arg_337_1.duration_ = 20.3

		local var_337_0 = {
			ja = 20.3,
			ko = 16.566,
			zh = 16.566
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play122531084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 1.475

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_2 = arg_337_1:FormatText(StoryNameCfg[384].name)

				arg_337_1.leftNameTxt_.text = var_340_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_3 = arg_337_1:GetWordFromCfg(122531083)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 59
				local var_340_6 = utf8.len(var_340_4)
				local var_340_7 = var_340_5 <= 0 and var_340_1 or var_340_1 * (var_340_6 / var_340_5)

				if var_340_7 > 0 and var_340_1 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_0
					end
				end

				arg_337_1.text_.text = var_340_4
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531083", "story_v_out_122531.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531083", "story_v_out_122531.awb") / 1000

					if var_340_8 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_0
					end

					if var_340_3.prefab_name ~= "" and arg_337_1.actors_[var_340_3.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_3.prefab_name].transform, "story_v_out_122531", "122531083", "story_v_out_122531.awb")

						arg_337_1:RecordAudio("122531083", var_340_9)
						arg_337_1:RecordAudio("122531083", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_122531", "122531083", "story_v_out_122531.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_122531", "122531083", "story_v_out_122531.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_10 and arg_337_1.time_ < var_340_0 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play122531084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 122531084
		arg_341_1.duration_ = 8.57

		local var_341_0 = {
			ja = 8.566,
			ko = 4.133,
			zh = 4.133
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play122531085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 0.35

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_2 = arg_341_1:FormatText(StoryNameCfg[384].name)

				arg_341_1.leftNameTxt_.text = var_344_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_3 = arg_341_1:GetWordFromCfg(122531084)
				local var_344_4 = arg_341_1:FormatText(var_344_3.content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 14
				local var_344_6 = utf8.len(var_344_4)
				local var_344_7 = var_344_5 <= 0 and var_344_1 or var_344_1 * (var_344_6 / var_344_5)

				if var_344_7 > 0 and var_344_1 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_4
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531084", "story_v_out_122531.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531084", "story_v_out_122531.awb") / 1000

					if var_344_8 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_0
					end

					if var_344_3.prefab_name ~= "" and arg_341_1.actors_[var_344_3.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_3.prefab_name].transform, "story_v_out_122531", "122531084", "story_v_out_122531.awb")

						arg_341_1:RecordAudio("122531084", var_344_9)
						arg_341_1:RecordAudio("122531084", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_122531", "122531084", "story_v_out_122531.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_122531", "122531084", "story_v_out_122531.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_10 and arg_341_1.time_ < var_344_0 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play122531085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 122531085
		arg_345_1.duration_ = 17.1

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play122531086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_1 = 2

			if var_348_0 <= arg_345_1.time_ and arg_345_1.time_ < var_348_0 + var_348_1 then
				local var_348_2 = (arg_345_1.time_ - var_348_0) / var_348_1
				local var_348_3 = Color.New(0, 0, 0)

				var_348_3.a = Mathf.Lerp(0, 1, var_348_2)
				arg_345_1.mask_.color = var_348_3
			end

			if arg_345_1.time_ >= var_348_0 + var_348_1 and arg_345_1.time_ < var_348_0 + var_348_1 + arg_348_0 then
				local var_348_4 = Color.New(0, 0, 0)

				var_348_4.a = 1
				arg_345_1.mask_.color = var_348_4
			end

			local var_348_5 = 2

			if var_348_5 < arg_345_1.time_ and arg_345_1.time_ <= var_348_5 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_6 = 2

			if var_348_5 <= arg_345_1.time_ and arg_345_1.time_ < var_348_5 + var_348_6 then
				local var_348_7 = (arg_345_1.time_ - var_348_5) / var_348_6
				local var_348_8 = Color.New(0, 0, 0)

				var_348_8.a = Mathf.Lerp(1, 0, var_348_7)
				arg_345_1.mask_.color = var_348_8
			end

			if arg_345_1.time_ >= var_348_5 + var_348_6 and arg_345_1.time_ < var_348_5 + var_348_6 + arg_348_0 then
				local var_348_9 = Color.New(0, 0, 0)
				local var_348_10 = 0

				arg_345_1.mask_.enabled = false
				var_348_9.a = var_348_10
				arg_345_1.mask_.color = var_348_9
			end

			local var_348_11 = 2

			if var_348_11 < arg_345_1.time_ and arg_345_1.time_ <= var_348_11 + arg_348_0 then
				arg_345_1.fswbg_:SetActive(true)
				arg_345_1.dialog_:SetActive(false)

				arg_345_1.fswtw_.percent = 0

				local var_348_12 = arg_345_1:GetWordFromCfg(122531085)
				local var_348_13 = arg_345_1:FormatText(var_348_12.content)

				arg_345_1.fswt_.text = var_348_13

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.fswt_)

				arg_345_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_345_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_345_1.fswtw_:SetDirty()

				arg_345_1.typewritterCharCountI18N = 0

				SetActive(arg_345_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_345_1:ShowNextGo(false)
			end

			local var_348_14 = 2.01666666666667

			if var_348_14 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1.var_.oldValueTypewriter = arg_345_1.fswtw_.percent

				SetActive(arg_345_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_345_1:ShowNextGo(false)
			end

			local var_348_15 = 52
			local var_348_16 = 3.46666666666667
			local var_348_17 = arg_345_1:GetWordFromCfg(122531085)
			local var_348_18 = arg_345_1:FormatText(var_348_17.content)
			local var_348_19, var_348_20 = arg_345_1:GetPercentByPara(var_348_18, 1)

			if var_348_14 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0

				local var_348_21 = var_348_15 <= 0 and var_348_16 or var_348_16 * ((var_348_20 - arg_345_1.typewritterCharCountI18N) / var_348_15)

				if var_348_21 > 0 and var_348_16 < var_348_21 then
					arg_345_1.talkMaxDuration = var_348_21

					if var_348_21 + var_348_14 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_21 + var_348_14
					end
				end
			end

			local var_348_22 = 3.46666666666667
			local var_348_23 = math.max(var_348_22, arg_345_1.talkMaxDuration)

			if var_348_14 <= arg_345_1.time_ and arg_345_1.time_ < var_348_14 + var_348_23 then
				local var_348_24 = (arg_345_1.time_ - var_348_14) / var_348_23

				arg_345_1.fswtw_.percent = Mathf.Lerp(arg_345_1.var_.oldValueTypewriter, var_348_19, var_348_24)
				arg_345_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_345_1.fswtw_:SetDirty()
			end

			if arg_345_1.time_ >= var_348_14 + var_348_23 and arg_345_1.time_ < var_348_14 + var_348_23 + arg_348_0 then
				arg_345_1.fswtw_.percent = var_348_19

				arg_345_1.fswtw_:SetDirty()
				arg_345_1:ShowNextGo(true)

				arg_345_1.typewritterCharCountI18N = var_348_20
			end

			local var_348_25 = "STblack"

			if arg_345_1.bgs_[var_348_25] == nil then
				local var_348_26 = Object.Instantiate(arg_345_1.paintGo_)

				var_348_26:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_348_25)
				var_348_26.name = var_348_25
				var_348_26.transform.parent = arg_345_1.stage_.transform
				var_348_26.transform.localPosition = Vector3.New(0, 100, 0)
				arg_345_1.bgs_[var_348_25] = var_348_26
			end

			local var_348_27 = 2

			if var_348_27 < arg_345_1.time_ and arg_345_1.time_ <= var_348_27 + arg_348_0 then
				local var_348_28 = manager.ui.mainCamera.transform.localPosition
				local var_348_29 = Vector3.New(0, 0, 10) + Vector3.New(var_348_28.x, var_348_28.y, 0)
				local var_348_30 = arg_345_1.bgs_.STblack

				var_348_30.transform.localPosition = var_348_29
				var_348_30.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_348_31 = var_348_30:GetComponent("SpriteRenderer")

				if var_348_31 and var_348_31.sprite then
					local var_348_32 = (var_348_30.transform.localPosition - var_348_28).z
					local var_348_33 = manager.ui.mainCameraCom_
					local var_348_34 = 2 * var_348_32 * Mathf.Tan(var_348_33.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_348_35 = var_348_34 * var_348_33.aspect
					local var_348_36 = var_348_31.sprite.bounds.size.x
					local var_348_37 = var_348_31.sprite.bounds.size.y
					local var_348_38 = var_348_35 / var_348_36
					local var_348_39 = var_348_34 / var_348_37
					local var_348_40 = var_348_39 < var_348_38 and var_348_38 or var_348_39

					var_348_30.transform.localScale = Vector3.New(var_348_40, var_348_40, 0)
				end

				for iter_348_0, iter_348_1 in pairs(arg_345_1.bgs_) do
					if iter_348_0 ~= "STblack" then
						iter_348_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_348_41 = arg_345_1.actors_["1071ui_story"].transform
			local var_348_42 = 1.966

			if var_348_42 < arg_345_1.time_ and arg_345_1.time_ <= var_348_42 + arg_348_0 then
				arg_345_1.var_.moveOldPos1071ui_story = var_348_41.localPosition
			end

			local var_348_43 = 0.001

			if var_348_42 <= arg_345_1.time_ and arg_345_1.time_ < var_348_42 + var_348_43 then
				local var_348_44 = (arg_345_1.time_ - var_348_42) / var_348_43
				local var_348_45 = Vector3.New(0, 100, 0)

				var_348_41.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1071ui_story, var_348_45, var_348_44)

				local var_348_46 = manager.ui.mainCamera.transform.position - var_348_41.position

				var_348_41.forward = Vector3.New(var_348_46.x, var_348_46.y, var_348_46.z)

				local var_348_47 = var_348_41.localEulerAngles

				var_348_47.z = 0
				var_348_47.x = 0
				var_348_41.localEulerAngles = var_348_47
			end

			if arg_345_1.time_ >= var_348_42 + var_348_43 and arg_345_1.time_ < var_348_42 + var_348_43 + arg_348_0 then
				var_348_41.localPosition = Vector3.New(0, 100, 0)

				local var_348_48 = manager.ui.mainCamera.transform.position - var_348_41.position

				var_348_41.forward = Vector3.New(var_348_48.x, var_348_48.y, var_348_48.z)

				local var_348_49 = var_348_41.localEulerAngles

				var_348_49.z = 0
				var_348_49.x = 0
				var_348_41.localEulerAngles = var_348_49
			end

			local var_348_50 = 2

			if var_348_50 < arg_345_1.time_ and arg_345_1.time_ <= var_348_50 + arg_348_0 then
				local var_348_51 = arg_345_1.fswbg_.transform:Find("textbox/adapt/content") or arg_345_1.fswbg_.transform:Find("textbox/content")
				local var_348_52 = arg_345_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_348_53 = var_348_51:GetComponent("Text")
				local var_348_54 = var_348_51:GetComponent("RectTransform")

				var_348_53.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_348_54.offsetMin = Vector2.New(0, 0)
				var_348_54.offsetMax = Vector2.New(0, 0)
			end

			local var_348_55 = 2
			local var_348_56 = 13.833
			local var_348_57 = manager.audio:GetVoiceLength("story_v_out_122531", "122531085", "story_v_out_122531.awb") / 1000

			if var_348_57 > 0 and var_348_56 < var_348_57 and var_348_57 + var_348_55 > arg_345_1.duration_ then
				local var_348_58 = var_348_57

				arg_345_1.duration_ = var_348_57 + var_348_55
			end

			if var_348_55 < arg_345_1.time_ and arg_345_1.time_ <= var_348_55 + arg_348_0 then
				local var_348_59 = "play"
				local var_348_60 = "voice"

				arg_345_1:AudioAction(var_348_59, var_348_60, "story_v_out_122531", "122531085", "story_v_out_122531.awb")
			end

			local var_348_61 = 1.966
			local var_348_62 = 1

			if var_348_61 < arg_345_1.time_ and arg_345_1.time_ <= var_348_61 + arg_348_0 then
				local var_348_63 = "play"
				local var_348_64 = "effect"

				arg_345_1:AudioAction(var_348_63, var_348_64, "se_story_122_03", "se_story_122_03_write", "")
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play122531086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 122531086
		arg_349_1.duration_ = 9.33

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play122531087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.fswbg_:SetActive(true)
				arg_349_1.dialog_:SetActive(false)

				arg_349_1.fswtw_.percent = 0

				local var_352_1 = arg_349_1:GetWordFromCfg(122531086)
				local var_352_2 = arg_349_1:FormatText(var_352_1.content)

				arg_349_1.fswt_.text = var_352_2

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.fswt_)

				arg_349_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_349_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_349_1.fswtw_:SetDirty()

				arg_349_1.typewritterCharCountI18N = 0

				SetActive(arg_349_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_349_1:ShowNextGo(false)
			end

			local var_352_3 = 0.0166666666666666

			if var_352_3 < arg_349_1.time_ and arg_349_1.time_ <= var_352_3 + arg_352_0 then
				arg_349_1.var_.oldValueTypewriter = arg_349_1.fswtw_.percent

				SetActive(arg_349_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_349_1:ShowNextGo(false)
			end

			local var_352_4 = 36
			local var_352_5 = 2.46666666666667
			local var_352_6 = arg_349_1:GetWordFromCfg(122531086)
			local var_352_7 = arg_349_1:FormatText(var_352_6.content)
			local var_352_8, var_352_9 = arg_349_1:GetPercentByPara(var_352_7, 1)

			if var_352_3 < arg_349_1.time_ and arg_349_1.time_ <= var_352_3 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0

				local var_352_10 = var_352_4 <= 0 and var_352_5 or var_352_5 * ((var_352_9 - arg_349_1.typewritterCharCountI18N) / var_352_4)

				if var_352_10 > 0 and var_352_5 < var_352_10 then
					arg_349_1.talkMaxDuration = var_352_10

					if var_352_10 + var_352_3 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_10 + var_352_3
					end
				end
			end

			local var_352_11 = 2.46666666666667
			local var_352_12 = math.max(var_352_11, arg_349_1.talkMaxDuration)

			if var_352_3 <= arg_349_1.time_ and arg_349_1.time_ < var_352_3 + var_352_12 then
				local var_352_13 = (arg_349_1.time_ - var_352_3) / var_352_12

				arg_349_1.fswtw_.percent = Mathf.Lerp(arg_349_1.var_.oldValueTypewriter, var_352_8, var_352_13)
				arg_349_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_349_1.fswtw_:SetDirty()
			end

			if arg_349_1.time_ >= var_352_3 + var_352_12 and arg_349_1.time_ < var_352_3 + var_352_12 + arg_352_0 then
				arg_349_1.fswtw_.percent = var_352_8

				arg_349_1.fswtw_:SetDirty()
				arg_349_1:ShowNextGo(true)

				arg_349_1.typewritterCharCountI18N = var_352_9
			end

			local var_352_14 = 0
			local var_352_15 = 9.333
			local var_352_16 = manager.audio:GetVoiceLength("story_v_out_122531", "122531086", "story_v_out_122531.awb") / 1000

			if var_352_16 > 0 and var_352_15 < var_352_16 and var_352_16 + var_352_14 > arg_349_1.duration_ then
				local var_352_17 = var_352_16

				arg_349_1.duration_ = var_352_16 + var_352_14
			end

			if var_352_14 < arg_349_1.time_ and arg_349_1.time_ <= var_352_14 + arg_352_0 then
				local var_352_18 = "play"
				local var_352_19 = "voice"

				arg_349_1:AudioAction(var_352_18, var_352_19, "story_v_out_122531", "122531086", "story_v_out_122531.awb")
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play122531087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 122531087
		arg_353_1.duration_ = 9.17

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play122531088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.fswbg_:SetActive(true)
				arg_353_1.dialog_:SetActive(false)

				arg_353_1.fswtw_.percent = 0

				local var_356_1 = arg_353_1:GetWordFromCfg(122531087)
				local var_356_2 = arg_353_1:FormatText(var_356_1.content)

				arg_353_1.fswt_.text = var_356_2

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.fswt_)

				arg_353_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_353_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_353_1.fswtw_:SetDirty()

				arg_353_1.typewritterCharCountI18N = 0

				SetActive(arg_353_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_353_1:ShowNextGo(false)
			end

			local var_356_3 = 0.0166666666666666

			if var_356_3 < arg_353_1.time_ and arg_353_1.time_ <= var_356_3 + arg_356_0 then
				arg_353_1.var_.oldValueTypewriter = arg_353_1.fswtw_.percent

				SetActive(arg_353_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_353_1:ShowNextGo(false)
			end

			local var_356_4 = 34
			local var_356_5 = 2.26666666666667
			local var_356_6 = arg_353_1:GetWordFromCfg(122531087)
			local var_356_7 = arg_353_1:FormatText(var_356_6.content)
			local var_356_8, var_356_9 = arg_353_1:GetPercentByPara(var_356_7, 1)

			if var_356_3 < arg_353_1.time_ and arg_353_1.time_ <= var_356_3 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0

				local var_356_10 = var_356_4 <= 0 and var_356_5 or var_356_5 * ((var_356_9 - arg_353_1.typewritterCharCountI18N) / var_356_4)

				if var_356_10 > 0 and var_356_5 < var_356_10 then
					arg_353_1.talkMaxDuration = var_356_10

					if var_356_10 + var_356_3 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_3
					end
				end
			end

			local var_356_11 = 2.26666666666667
			local var_356_12 = math.max(var_356_11, arg_353_1.talkMaxDuration)

			if var_356_3 <= arg_353_1.time_ and arg_353_1.time_ < var_356_3 + var_356_12 then
				local var_356_13 = (arg_353_1.time_ - var_356_3) / var_356_12

				arg_353_1.fswtw_.percent = Mathf.Lerp(arg_353_1.var_.oldValueTypewriter, var_356_8, var_356_13)
				arg_353_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_353_1.fswtw_:SetDirty()
			end

			if arg_353_1.time_ >= var_356_3 + var_356_12 and arg_353_1.time_ < var_356_3 + var_356_12 + arg_356_0 then
				arg_353_1.fswtw_.percent = var_356_8

				arg_353_1.fswtw_:SetDirty()
				arg_353_1:ShowNextGo(true)

				arg_353_1.typewritterCharCountI18N = var_356_9
			end

			local var_356_14 = 0
			local var_356_15 = 9.166
			local var_356_16 = manager.audio:GetVoiceLength("story_v_out_122531", "122531087", "story_v_out_122531.awb") / 1000

			if var_356_16 > 0 and var_356_15 < var_356_16 and var_356_16 + var_356_14 > arg_353_1.duration_ then
				local var_356_17 = var_356_16

				arg_353_1.duration_ = var_356_16 + var_356_14
			end

			if var_356_14 < arg_353_1.time_ and arg_353_1.time_ <= var_356_14 + arg_356_0 then
				local var_356_18 = "play"
				local var_356_19 = "voice"

				arg_353_1:AudioAction(var_356_18, var_356_19, "story_v_out_122531", "122531087", "story_v_out_122531.awb")
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play122531088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 122531088
		arg_357_1.duration_ = 10.93

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play122531089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.fswbg_:SetActive(true)
				arg_357_1.dialog_:SetActive(false)

				arg_357_1.fswtw_.percent = 0

				local var_360_1 = arg_357_1:GetWordFromCfg(122531088)
				local var_360_2 = arg_357_1:FormatText(var_360_1.content)

				arg_357_1.fswt_.text = var_360_2

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.fswt_)

				arg_357_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_357_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_357_1.fswtw_:SetDirty()

				arg_357_1.typewritterCharCountI18N = 0

				SetActive(arg_357_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_357_1:ShowNextGo(false)
			end

			local var_360_3 = 0.0166666666666667

			if var_360_3 < arg_357_1.time_ and arg_357_1.time_ <= var_360_3 + arg_360_0 then
				arg_357_1.var_.oldValueTypewriter = arg_357_1.fswtw_.percent

				SetActive(arg_357_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_357_1:ShowNextGo(false)
			end

			local var_360_4 = 37
			local var_360_5 = 2.46666666666667
			local var_360_6 = arg_357_1:GetWordFromCfg(122531088)
			local var_360_7 = arg_357_1:FormatText(var_360_6.content)
			local var_360_8, var_360_9 = arg_357_1:GetPercentByPara(var_360_7, 1)

			if var_360_3 < arg_357_1.time_ and arg_357_1.time_ <= var_360_3 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0

				local var_360_10 = var_360_4 <= 0 and var_360_5 or var_360_5 * ((var_360_9 - arg_357_1.typewritterCharCountI18N) / var_360_4)

				if var_360_10 > 0 and var_360_5 < var_360_10 then
					arg_357_1.talkMaxDuration = var_360_10

					if var_360_10 + var_360_3 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_3
					end
				end
			end

			local var_360_11 = 2.46666666666667
			local var_360_12 = math.max(var_360_11, arg_357_1.talkMaxDuration)

			if var_360_3 <= arg_357_1.time_ and arg_357_1.time_ < var_360_3 + var_360_12 then
				local var_360_13 = (arg_357_1.time_ - var_360_3) / var_360_12

				arg_357_1.fswtw_.percent = Mathf.Lerp(arg_357_1.var_.oldValueTypewriter, var_360_8, var_360_13)
				arg_357_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_357_1.fswtw_:SetDirty()
			end

			if arg_357_1.time_ >= var_360_3 + var_360_12 and arg_357_1.time_ < var_360_3 + var_360_12 + arg_360_0 then
				arg_357_1.fswtw_.percent = var_360_8

				arg_357_1.fswtw_:SetDirty()
				arg_357_1:ShowNextGo(true)

				arg_357_1.typewritterCharCountI18N = var_360_9
			end

			local var_360_14 = 0
			local var_360_15 = 10.2
			local var_360_16 = manager.audio:GetVoiceLength("story_v_out_122531", "122531088", "story_v_out_122531.awb") / 1000

			if var_360_16 > 0 and var_360_15 < var_360_16 and var_360_16 + var_360_14 > arg_357_1.duration_ then
				local var_360_17 = var_360_16

				arg_357_1.duration_ = var_360_16 + var_360_14
			end

			if var_360_14 < arg_357_1.time_ and arg_357_1.time_ <= var_360_14 + arg_360_0 then
				local var_360_18 = "play"
				local var_360_19 = "voice"

				arg_357_1:AudioAction(var_360_18, var_360_19, "story_v_out_122531", "122531088", "story_v_out_122531.awb")
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play122531089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 122531089
		arg_361_1.duration_ = 11.2

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play122531090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.fswbg_:SetActive(true)
				arg_361_1.dialog_:SetActive(false)

				arg_361_1.fswtw_.percent = 0

				local var_364_1 = arg_361_1:GetWordFromCfg(122531089)
				local var_364_2 = arg_361_1:FormatText(var_364_1.content)

				arg_361_1.fswt_.text = var_364_2

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.fswt_)

				arg_361_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_361_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_361_1.fswtw_:SetDirty()

				arg_361_1.typewritterCharCountI18N = 0

				SetActive(arg_361_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_361_1:ShowNextGo(false)
			end

			local var_364_3 = 0.0166666666666666

			if var_364_3 < arg_361_1.time_ and arg_361_1.time_ <= var_364_3 + arg_364_0 then
				arg_361_1.var_.oldValueTypewriter = arg_361_1.fswtw_.percent

				SetActive(arg_361_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_361_1:ShowNextGo(false)
			end

			local var_364_4 = 46
			local var_364_5 = 3.06666666666667
			local var_364_6 = arg_361_1:GetWordFromCfg(122531089)
			local var_364_7 = arg_361_1:FormatText(var_364_6.content)
			local var_364_8, var_364_9 = arg_361_1:GetPercentByPara(var_364_7, 1)

			if var_364_3 < arg_361_1.time_ and arg_361_1.time_ <= var_364_3 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0

				local var_364_10 = var_364_4 <= 0 and var_364_5 or var_364_5 * ((var_364_9 - arg_361_1.typewritterCharCountI18N) / var_364_4)

				if var_364_10 > 0 and var_364_5 < var_364_10 then
					arg_361_1.talkMaxDuration = var_364_10

					if var_364_10 + var_364_3 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_10 + var_364_3
					end
				end
			end

			local var_364_11 = 3.06666666666667
			local var_364_12 = math.max(var_364_11, arg_361_1.talkMaxDuration)

			if var_364_3 <= arg_361_1.time_ and arg_361_1.time_ < var_364_3 + var_364_12 then
				local var_364_13 = (arg_361_1.time_ - var_364_3) / var_364_12

				arg_361_1.fswtw_.percent = Mathf.Lerp(arg_361_1.var_.oldValueTypewriter, var_364_8, var_364_13)
				arg_361_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_361_1.fswtw_:SetDirty()
			end

			if arg_361_1.time_ >= var_364_3 + var_364_12 and arg_361_1.time_ < var_364_3 + var_364_12 + arg_364_0 then
				arg_361_1.fswtw_.percent = var_364_8

				arg_361_1.fswtw_:SetDirty()
				arg_361_1:ShowNextGo(true)

				arg_361_1.typewritterCharCountI18N = var_364_9
			end

			local var_364_14 = 0
			local var_364_15 = 11.2
			local var_364_16 = manager.audio:GetVoiceLength("story_v_out_122531", "122531089", "story_v_out_122531.awb") / 1000

			if var_364_16 > 0 and var_364_15 < var_364_16 and var_364_16 + var_364_14 > arg_361_1.duration_ then
				local var_364_17 = var_364_16

				arg_361_1.duration_ = var_364_16 + var_364_14
			end

			if var_364_14 < arg_361_1.time_ and arg_361_1.time_ <= var_364_14 + arg_364_0 then
				local var_364_18 = "play"
				local var_364_19 = "voice"

				arg_361_1:AudioAction(var_364_18, var_364_19, "story_v_out_122531", "122531089", "story_v_out_122531.awb")
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play122531090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 122531090
		arg_365_1.duration_ = 6.77

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play122531091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.fswbg_:SetActive(true)
				arg_365_1.dialog_:SetActive(false)

				arg_365_1.fswtw_.percent = 0

				local var_368_1 = arg_365_1:GetWordFromCfg(122531090)
				local var_368_2 = arg_365_1:FormatText(var_368_1.content)

				arg_365_1.fswt_.text = var_368_2

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.fswt_)

				arg_365_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_365_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_365_1.fswtw_:SetDirty()

				arg_365_1.typewritterCharCountI18N = 0

				SetActive(arg_365_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_365_1:ShowNextGo(false)
			end

			local var_368_3 = 0.0166666666666666

			if var_368_3 < arg_365_1.time_ and arg_365_1.time_ <= var_368_3 + arg_368_0 then
				arg_365_1.var_.oldValueTypewriter = arg_365_1.fswtw_.percent

				SetActive(arg_365_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_365_1:ShowNextGo(false)
			end

			local var_368_4 = 27
			local var_368_5 = 1.8
			local var_368_6 = arg_365_1:GetWordFromCfg(122531090)
			local var_368_7 = arg_365_1:FormatText(var_368_6.content)
			local var_368_8, var_368_9 = arg_365_1:GetPercentByPara(var_368_7, 1)

			if var_368_3 < arg_365_1.time_ and arg_365_1.time_ <= var_368_3 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0

				local var_368_10 = var_368_4 <= 0 and var_368_5 or var_368_5 * ((var_368_9 - arg_365_1.typewritterCharCountI18N) / var_368_4)

				if var_368_10 > 0 and var_368_5 < var_368_10 then
					arg_365_1.talkMaxDuration = var_368_10

					if var_368_10 + var_368_3 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_10 + var_368_3
					end
				end
			end

			local var_368_11 = 1.8
			local var_368_12 = math.max(var_368_11, arg_365_1.talkMaxDuration)

			if var_368_3 <= arg_365_1.time_ and arg_365_1.time_ < var_368_3 + var_368_12 then
				local var_368_13 = (arg_365_1.time_ - var_368_3) / var_368_12

				arg_365_1.fswtw_.percent = Mathf.Lerp(arg_365_1.var_.oldValueTypewriter, var_368_8, var_368_13)
				arg_365_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_365_1.fswtw_:SetDirty()
			end

			if arg_365_1.time_ >= var_368_3 + var_368_12 and arg_365_1.time_ < var_368_3 + var_368_12 + arg_368_0 then
				arg_365_1.fswtw_.percent = var_368_8

				arg_365_1.fswtw_:SetDirty()
				arg_365_1:ShowNextGo(true)

				arg_365_1.typewritterCharCountI18N = var_368_9
			end

			local var_368_14 = 0
			local var_368_15 = 6.766
			local var_368_16 = manager.audio:GetVoiceLength("story_v_out_122531", "122531090", "story_v_out_122531.awb") / 1000

			if var_368_16 > 0 and var_368_15 < var_368_16 and var_368_16 + var_368_14 > arg_365_1.duration_ then
				local var_368_17 = var_368_16

				arg_365_1.duration_ = var_368_16 + var_368_14
			end

			if var_368_14 < arg_365_1.time_ and arg_365_1.time_ <= var_368_14 + arg_368_0 then
				local var_368_18 = "play"
				local var_368_19 = "voice"

				arg_365_1:AudioAction(var_368_18, var_368_19, "story_v_out_122531", "122531090", "story_v_out_122531.awb")
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play122531091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 122531091
		arg_369_1.duration_ = 14.3

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play122531092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1.fswbg_:SetActive(true)
				arg_369_1.dialog_:SetActive(false)

				arg_369_1.fswtw_.percent = 0

				local var_372_1 = arg_369_1:GetWordFromCfg(122531091)
				local var_372_2 = arg_369_1:FormatText(var_372_1.content)

				arg_369_1.fswt_.text = var_372_2

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.fswt_)

				arg_369_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_369_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_369_1.fswtw_:SetDirty()

				arg_369_1.typewritterCharCountI18N = 0

				SetActive(arg_369_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_369_1:ShowNextGo(false)
			end

			local var_372_3 = 0.0166666666666666

			if var_372_3 < arg_369_1.time_ and arg_369_1.time_ <= var_372_3 + arg_372_0 then
				arg_369_1.var_.oldValueTypewriter = arg_369_1.fswtw_.percent

				SetActive(arg_369_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_369_1:ShowNextGo(false)
			end

			local var_372_4 = 52
			local var_372_5 = 3.46666666666667
			local var_372_6 = arg_369_1:GetWordFromCfg(122531091)
			local var_372_7 = arg_369_1:FormatText(var_372_6.content)
			local var_372_8, var_372_9 = arg_369_1:GetPercentByPara(var_372_7, 1)

			if var_372_3 < arg_369_1.time_ and arg_369_1.time_ <= var_372_3 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0

				local var_372_10 = var_372_4 <= 0 and var_372_5 or var_372_5 * ((var_372_9 - arg_369_1.typewritterCharCountI18N) / var_372_4)

				if var_372_10 > 0 and var_372_5 < var_372_10 then
					arg_369_1.talkMaxDuration = var_372_10

					if var_372_10 + var_372_3 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_10 + var_372_3
					end
				end
			end

			local var_372_11 = 3.46666666666667
			local var_372_12 = math.max(var_372_11, arg_369_1.talkMaxDuration)

			if var_372_3 <= arg_369_1.time_ and arg_369_1.time_ < var_372_3 + var_372_12 then
				local var_372_13 = (arg_369_1.time_ - var_372_3) / var_372_12

				arg_369_1.fswtw_.percent = Mathf.Lerp(arg_369_1.var_.oldValueTypewriter, var_372_8, var_372_13)
				arg_369_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_369_1.fswtw_:SetDirty()
			end

			if arg_369_1.time_ >= var_372_3 + var_372_12 and arg_369_1.time_ < var_372_3 + var_372_12 + arg_372_0 then
				arg_369_1.fswtw_.percent = var_372_8

				arg_369_1.fswtw_:SetDirty()
				arg_369_1:ShowNextGo(true)

				arg_369_1.typewritterCharCountI18N = var_372_9
			end

			local var_372_14 = 0
			local var_372_15 = 13.2
			local var_372_16 = manager.audio:GetVoiceLength("story_v_out_122531", "122531091", "story_v_out_122531.awb") / 1000

			if var_372_16 > 0 and var_372_15 < var_372_16 and var_372_16 + var_372_14 > arg_369_1.duration_ then
				local var_372_17 = var_372_16

				arg_369_1.duration_ = var_372_16 + var_372_14
			end

			if var_372_14 < arg_369_1.time_ and arg_369_1.time_ <= var_372_14 + arg_372_0 then
				local var_372_18 = "play"
				local var_372_19 = "voice"

				arg_369_1:AudioAction(var_372_18, var_372_19, "story_v_out_122531", "122531091", "story_v_out_122531.awb")
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play122531092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 122531092
		arg_373_1.duration_ = 14.73

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play122531093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1.fswbg_:SetActive(true)
				arg_373_1.dialog_:SetActive(false)

				arg_373_1.fswtw_.percent = 0

				local var_376_1 = arg_373_1:GetWordFromCfg(122531092)
				local var_376_2 = arg_373_1:FormatText(var_376_1.content)

				arg_373_1.fswt_.text = var_376_2

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.fswt_)

				arg_373_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_373_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_373_1.fswtw_:SetDirty()

				arg_373_1.typewritterCharCountI18N = 0

				SetActive(arg_373_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_373_1:ShowNextGo(false)
			end

			local var_376_3 = 0.0166666666666666

			if var_376_3 < arg_373_1.time_ and arg_373_1.time_ <= var_376_3 + arg_376_0 then
				arg_373_1.var_.oldValueTypewriter = arg_373_1.fswtw_.percent

				SetActive(arg_373_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_373_1:ShowNextGo(false)
			end

			local var_376_4 = 54
			local var_376_5 = 3.53333333333333
			local var_376_6 = arg_373_1:GetWordFromCfg(122531092)
			local var_376_7 = arg_373_1:FormatText(var_376_6.content)
			local var_376_8, var_376_9 = arg_373_1:GetPercentByPara(var_376_7, 1)

			if var_376_3 < arg_373_1.time_ and arg_373_1.time_ <= var_376_3 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0

				local var_376_10 = var_376_4 <= 0 and var_376_5 or var_376_5 * ((var_376_9 - arg_373_1.typewritterCharCountI18N) / var_376_4)

				if var_376_10 > 0 and var_376_5 < var_376_10 then
					arg_373_1.talkMaxDuration = var_376_10

					if var_376_10 + var_376_3 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_10 + var_376_3
					end
				end
			end

			local var_376_11 = 3.53333333333333
			local var_376_12 = math.max(var_376_11, arg_373_1.talkMaxDuration)

			if var_376_3 <= arg_373_1.time_ and arg_373_1.time_ < var_376_3 + var_376_12 then
				local var_376_13 = (arg_373_1.time_ - var_376_3) / var_376_12

				arg_373_1.fswtw_.percent = Mathf.Lerp(arg_373_1.var_.oldValueTypewriter, var_376_8, var_376_13)
				arg_373_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_373_1.fswtw_:SetDirty()
			end

			if arg_373_1.time_ >= var_376_3 + var_376_12 and arg_373_1.time_ < var_376_3 + var_376_12 + arg_376_0 then
				arg_373_1.fswtw_.percent = var_376_8

				arg_373_1.fswtw_:SetDirty()
				arg_373_1:ShowNextGo(true)

				arg_373_1.typewritterCharCountI18N = var_376_9
			end

			local var_376_14 = 0
			local var_376_15 = 13
			local var_376_16 = manager.audio:GetVoiceLength("story_v_out_122531", "122531092", "story_v_out_122531.awb") / 1000

			if var_376_16 > 0 and var_376_15 < var_376_16 and var_376_16 + var_376_14 > arg_373_1.duration_ then
				local var_376_17 = var_376_16

				arg_373_1.duration_ = var_376_16 + var_376_14
			end

			if var_376_14 < arg_373_1.time_ and arg_373_1.time_ <= var_376_14 + arg_376_0 then
				local var_376_18 = "play"
				local var_376_19 = "voice"

				arg_373_1:AudioAction(var_376_18, var_376_19, "story_v_out_122531", "122531092", "story_v_out_122531.awb")
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play122531093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 122531093
		arg_377_1.duration_ = 16.7

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play122531094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.fswbg_:SetActive(true)
				arg_377_1.dialog_:SetActive(false)

				arg_377_1.fswtw_.percent = 0

				local var_380_1 = arg_377_1:GetWordFromCfg(122531093)
				local var_380_2 = arg_377_1:FormatText(var_380_1.content)

				arg_377_1.fswt_.text = var_380_2

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.fswt_)

				arg_377_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_377_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_377_1.fswtw_:SetDirty()

				arg_377_1.typewritterCharCountI18N = 0

				SetActive(arg_377_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_377_1:ShowNextGo(false)
			end

			local var_380_3 = 0.0166666666666666

			if var_380_3 < arg_377_1.time_ and arg_377_1.time_ <= var_380_3 + arg_380_0 then
				arg_377_1.var_.oldValueTypewriter = arg_377_1.fswtw_.percent

				SetActive(arg_377_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_377_1:ShowNextGo(false)
			end

			local var_380_4 = 51
			local var_380_5 = 3.4
			local var_380_6 = arg_377_1:GetWordFromCfg(122531093)
			local var_380_7 = arg_377_1:FormatText(var_380_6.content)
			local var_380_8, var_380_9 = arg_377_1:GetPercentByPara(var_380_7, 1)

			if var_380_3 < arg_377_1.time_ and arg_377_1.time_ <= var_380_3 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0

				local var_380_10 = var_380_4 <= 0 and var_380_5 or var_380_5 * ((var_380_9 - arg_377_1.typewritterCharCountI18N) / var_380_4)

				if var_380_10 > 0 and var_380_5 < var_380_10 then
					arg_377_1.talkMaxDuration = var_380_10

					if var_380_10 + var_380_3 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_10 + var_380_3
					end
				end
			end

			local var_380_11 = 3.4
			local var_380_12 = math.max(var_380_11, arg_377_1.talkMaxDuration)

			if var_380_3 <= arg_377_1.time_ and arg_377_1.time_ < var_380_3 + var_380_12 then
				local var_380_13 = (arg_377_1.time_ - var_380_3) / var_380_12

				arg_377_1.fswtw_.percent = Mathf.Lerp(arg_377_1.var_.oldValueTypewriter, var_380_8, var_380_13)
				arg_377_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_377_1.fswtw_:SetDirty()
			end

			if arg_377_1.time_ >= var_380_3 + var_380_12 and arg_377_1.time_ < var_380_3 + var_380_12 + arg_380_0 then
				arg_377_1.fswtw_.percent = var_380_8

				arg_377_1.fswtw_:SetDirty()
				arg_377_1:ShowNextGo(true)

				arg_377_1.typewritterCharCountI18N = var_380_9
			end

			local var_380_14 = 0
			local var_380_15 = 15.633
			local var_380_16 = manager.audio:GetVoiceLength("story_v_out_122531", "122531093", "story_v_out_122531.awb") / 1000

			if var_380_16 > 0 and var_380_15 < var_380_16 and var_380_16 + var_380_14 > arg_377_1.duration_ then
				local var_380_17 = var_380_16

				arg_377_1.duration_ = var_380_16 + var_380_14
			end

			if var_380_14 < arg_377_1.time_ and arg_377_1.time_ <= var_380_14 + arg_380_0 then
				local var_380_18 = "play"
				local var_380_19 = "voice"

				arg_377_1:AudioAction(var_380_18, var_380_19, "story_v_out_122531", "122531093", "story_v_out_122531.awb")
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play122531094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 122531094
		arg_381_1.duration_ = 8.03

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play122531095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.fswbg_:SetActive(true)
				arg_381_1.dialog_:SetActive(false)

				arg_381_1.fswtw_.percent = 0

				local var_384_1 = arg_381_1:GetWordFromCfg(122531094)
				local var_384_2 = arg_381_1:FormatText(var_384_1.content)

				arg_381_1.fswt_.text = var_384_2

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.fswt_)

				arg_381_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_381_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_381_1.fswtw_:SetDirty()

				arg_381_1.typewritterCharCountI18N = 0

				SetActive(arg_381_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_381_1:ShowNextGo(false)
			end

			local var_384_3 = 0.0166666666666666

			if var_384_3 < arg_381_1.time_ and arg_381_1.time_ <= var_384_3 + arg_384_0 then
				arg_381_1.var_.oldValueTypewriter = arg_381_1.fswtw_.percent

				SetActive(arg_381_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_381_1:ShowNextGo(false)
			end

			local var_384_4 = 33
			local var_384_5 = 2.2
			local var_384_6 = arg_381_1:GetWordFromCfg(122531094)
			local var_384_7 = arg_381_1:FormatText(var_384_6.content)
			local var_384_8, var_384_9 = arg_381_1:GetPercentByPara(var_384_7, 1)

			if var_384_3 < arg_381_1.time_ and arg_381_1.time_ <= var_384_3 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0

				local var_384_10 = var_384_4 <= 0 and var_384_5 or var_384_5 * ((var_384_9 - arg_381_1.typewritterCharCountI18N) / var_384_4)

				if var_384_10 > 0 and var_384_5 < var_384_10 then
					arg_381_1.talkMaxDuration = var_384_10

					if var_384_10 + var_384_3 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_10 + var_384_3
					end
				end
			end

			local var_384_11 = 2.2
			local var_384_12 = math.max(var_384_11, arg_381_1.talkMaxDuration)

			if var_384_3 <= arg_381_1.time_ and arg_381_1.time_ < var_384_3 + var_384_12 then
				local var_384_13 = (arg_381_1.time_ - var_384_3) / var_384_12

				arg_381_1.fswtw_.percent = Mathf.Lerp(arg_381_1.var_.oldValueTypewriter, var_384_8, var_384_13)
				arg_381_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_381_1.fswtw_:SetDirty()
			end

			if arg_381_1.time_ >= var_384_3 + var_384_12 and arg_381_1.time_ < var_384_3 + var_384_12 + arg_384_0 then
				arg_381_1.fswtw_.percent = var_384_8

				arg_381_1.fswtw_:SetDirty()
				arg_381_1:ShowNextGo(true)

				arg_381_1.typewritterCharCountI18N = var_384_9
			end

			local var_384_14 = 0
			local var_384_15 = 7.6
			local var_384_16 = manager.audio:GetVoiceLength("story_v_out_122531", "122531094", "story_v_out_122531.awb") / 1000

			if var_384_16 > 0 and var_384_15 < var_384_16 and var_384_16 + var_384_14 > arg_381_1.duration_ then
				local var_384_17 = var_384_16

				arg_381_1.duration_ = var_384_16 + var_384_14
			end

			if var_384_14 < arg_381_1.time_ and arg_381_1.time_ <= var_384_14 + arg_384_0 then
				local var_384_18 = "play"
				local var_384_19 = "voice"

				arg_381_1:AudioAction(var_384_18, var_384_19, "story_v_out_122531", "122531094", "story_v_out_122531.awb")
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play122531095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 122531095
		arg_385_1.duration_ = 14.23

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play122531096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0

			if var_388_0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				arg_385_1.fswbg_:SetActive(true)
				arg_385_1.dialog_:SetActive(false)

				arg_385_1.fswtw_.percent = 0

				local var_388_1 = arg_385_1:GetWordFromCfg(122531095)
				local var_388_2 = arg_385_1:FormatText(var_388_1.content)

				arg_385_1.fswt_.text = var_388_2

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.fswt_)

				arg_385_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_385_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_385_1.fswtw_:SetDirty()

				arg_385_1.typewritterCharCountI18N = 0

				SetActive(arg_385_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_385_1:ShowNextGo(false)
			end

			local var_388_3 = 0.0166666666666666

			if var_388_3 < arg_385_1.time_ and arg_385_1.time_ <= var_388_3 + arg_388_0 then
				arg_385_1.var_.oldValueTypewriter = arg_385_1.fswtw_.percent

				SetActive(arg_385_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_385_1:ShowNextGo(false)
			end

			local var_388_4 = 49
			local var_388_5 = 3.26666666666667
			local var_388_6 = arg_385_1:GetWordFromCfg(122531095)
			local var_388_7 = arg_385_1:FormatText(var_388_6.content)
			local var_388_8, var_388_9 = arg_385_1:GetPercentByPara(var_388_7, 1)

			if var_388_3 < arg_385_1.time_ and arg_385_1.time_ <= var_388_3 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0

				local var_388_10 = var_388_4 <= 0 and var_388_5 or var_388_5 * ((var_388_9 - arg_385_1.typewritterCharCountI18N) / var_388_4)

				if var_388_10 > 0 and var_388_5 < var_388_10 then
					arg_385_1.talkMaxDuration = var_388_10

					if var_388_10 + var_388_3 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_10 + var_388_3
					end
				end
			end

			local var_388_11 = 3.26666666666667
			local var_388_12 = math.max(var_388_11, arg_385_1.talkMaxDuration)

			if var_388_3 <= arg_385_1.time_ and arg_385_1.time_ < var_388_3 + var_388_12 then
				local var_388_13 = (arg_385_1.time_ - var_388_3) / var_388_12

				arg_385_1.fswtw_.percent = Mathf.Lerp(arg_385_1.var_.oldValueTypewriter, var_388_8, var_388_13)
				arg_385_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_385_1.fswtw_:SetDirty()
			end

			if arg_385_1.time_ >= var_388_3 + var_388_12 and arg_385_1.time_ < var_388_3 + var_388_12 + arg_388_0 then
				arg_385_1.fswtw_.percent = var_388_8

				arg_385_1.fswtw_:SetDirty()
				arg_385_1:ShowNextGo(true)

				arg_385_1.typewritterCharCountI18N = var_388_9
			end

			local var_388_14 = 0
			local var_388_15 = 13.166
			local var_388_16 = manager.audio:GetVoiceLength("story_v_out_122531", "122531095", "story_v_out_122531.awb") / 1000

			if var_388_16 > 0 and var_388_15 < var_388_16 and var_388_16 + var_388_14 > arg_385_1.duration_ then
				local var_388_17 = var_388_16

				arg_385_1.duration_ = var_388_16 + var_388_14
			end

			if var_388_14 < arg_385_1.time_ and arg_385_1.time_ <= var_388_14 + arg_388_0 then
				local var_388_18 = "play"
				local var_388_19 = "voice"

				arg_385_1:AudioAction(var_388_18, var_388_19, "story_v_out_122531", "122531095", "story_v_out_122531.awb")
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play122531096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 122531096
		arg_389_1.duration_ = 11.5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play122531097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1.fswbg_:SetActive(true)
				arg_389_1.dialog_:SetActive(false)

				arg_389_1.fswtw_.percent = 0

				local var_392_1 = arg_389_1:GetWordFromCfg(122531096)
				local var_392_2 = arg_389_1:FormatText(var_392_1.content)

				arg_389_1.fswt_.text = var_392_2

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.fswt_)

				arg_389_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_389_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_389_1.fswtw_:SetDirty()

				arg_389_1.typewritterCharCountI18N = 0

				SetActive(arg_389_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_389_1:ShowNextGo(false)
			end

			local var_392_3 = 0.0166666666666666

			if var_392_3 < arg_389_1.time_ and arg_389_1.time_ <= var_392_3 + arg_392_0 then
				arg_389_1.var_.oldValueTypewriter = arg_389_1.fswtw_.percent

				SetActive(arg_389_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_389_1:ShowNextGo(false)
			end

			local var_392_4 = 46
			local var_392_5 = 3.2
			local var_392_6 = arg_389_1:GetWordFromCfg(122531096)
			local var_392_7 = arg_389_1:FormatText(var_392_6.content)
			local var_392_8, var_392_9 = arg_389_1:GetPercentByPara(var_392_7, 1)

			if var_392_3 < arg_389_1.time_ and arg_389_1.time_ <= var_392_3 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0

				local var_392_10 = var_392_4 <= 0 and var_392_5 or var_392_5 * ((var_392_9 - arg_389_1.typewritterCharCountI18N) / var_392_4)

				if var_392_10 > 0 and var_392_5 < var_392_10 then
					arg_389_1.talkMaxDuration = var_392_10

					if var_392_10 + var_392_3 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_10 + var_392_3
					end
				end
			end

			local var_392_11 = 3.2
			local var_392_12 = math.max(var_392_11, arg_389_1.talkMaxDuration)

			if var_392_3 <= arg_389_1.time_ and arg_389_1.time_ < var_392_3 + var_392_12 then
				local var_392_13 = (arg_389_1.time_ - var_392_3) / var_392_12

				arg_389_1.fswtw_.percent = Mathf.Lerp(arg_389_1.var_.oldValueTypewriter, var_392_8, var_392_13)
				arg_389_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_389_1.fswtw_:SetDirty()
			end

			if arg_389_1.time_ >= var_392_3 + var_392_12 and arg_389_1.time_ < var_392_3 + var_392_12 + arg_392_0 then
				arg_389_1.fswtw_.percent = var_392_8

				arg_389_1.fswtw_:SetDirty()
				arg_389_1:ShowNextGo(true)

				arg_389_1.typewritterCharCountI18N = var_392_9
			end

			local var_392_14 = 0
			local var_392_15 = 10.433
			local var_392_16 = manager.audio:GetVoiceLength("story_v_out_122531", "122531096", "story_v_out_122531.awb") / 1000

			if var_392_16 > 0 and var_392_15 < var_392_16 and var_392_16 + var_392_14 > arg_389_1.duration_ then
				local var_392_17 = var_392_16

				arg_389_1.duration_ = var_392_16 + var_392_14
			end

			if var_392_14 < arg_389_1.time_ and arg_389_1.time_ <= var_392_14 + arg_392_0 then
				local var_392_18 = "play"
				local var_392_19 = "voice"

				arg_389_1:AudioAction(var_392_18, var_392_19, "story_v_out_122531", "122531096", "story_v_out_122531.awb")
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play122531097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 122531097
		arg_393_1.duration_ = 11.23

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play122531098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.fswbg_:SetActive(true)
				arg_393_1.dialog_:SetActive(false)

				arg_393_1.fswtw_.percent = 0

				local var_396_1 = arg_393_1:GetWordFromCfg(122531097)
				local var_396_2 = arg_393_1:FormatText(var_396_1.content)

				arg_393_1.fswt_.text = var_396_2

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.fswt_)

				arg_393_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_393_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_393_1.fswtw_:SetDirty()

				arg_393_1.typewritterCharCountI18N = 0

				SetActive(arg_393_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_393_1:ShowNextGo(false)
			end

			local var_396_3 = 0.0166666666666666

			if var_396_3 < arg_393_1.time_ and arg_393_1.time_ <= var_396_3 + arg_396_0 then
				arg_393_1.var_.oldValueTypewriter = arg_393_1.fswtw_.percent

				SetActive(arg_393_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_393_1:ShowNextGo(false)
			end

			local var_396_4 = 45
			local var_396_5 = 3
			local var_396_6 = arg_393_1:GetWordFromCfg(122531097)
			local var_396_7 = arg_393_1:FormatText(var_396_6.content)
			local var_396_8, var_396_9 = arg_393_1:GetPercentByPara(var_396_7, 1)

			if var_396_3 < arg_393_1.time_ and arg_393_1.time_ <= var_396_3 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0

				local var_396_10 = var_396_4 <= 0 and var_396_5 or var_396_5 * ((var_396_9 - arg_393_1.typewritterCharCountI18N) / var_396_4)

				if var_396_10 > 0 and var_396_5 < var_396_10 then
					arg_393_1.talkMaxDuration = var_396_10

					if var_396_10 + var_396_3 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_10 + var_396_3
					end
				end
			end

			local var_396_11 = 3
			local var_396_12 = math.max(var_396_11, arg_393_1.talkMaxDuration)

			if var_396_3 <= arg_393_1.time_ and arg_393_1.time_ < var_396_3 + var_396_12 then
				local var_396_13 = (arg_393_1.time_ - var_396_3) / var_396_12

				arg_393_1.fswtw_.percent = Mathf.Lerp(arg_393_1.var_.oldValueTypewriter, var_396_8, var_396_13)
				arg_393_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_393_1.fswtw_:SetDirty()
			end

			if arg_393_1.time_ >= var_396_3 + var_396_12 and arg_393_1.time_ < var_396_3 + var_396_12 + arg_396_0 then
				arg_393_1.fswtw_.percent = var_396_8

				arg_393_1.fswtw_:SetDirty()
				arg_393_1:ShowNextGo(true)

				arg_393_1.typewritterCharCountI18N = var_396_9
			end

			local var_396_14 = 0
			local var_396_15 = 11.233
			local var_396_16 = manager.audio:GetVoiceLength("story_v_out_122531", "122531097", "story_v_out_122531.awb") / 1000

			if var_396_16 > 0 and var_396_15 < var_396_16 and var_396_16 + var_396_14 > arg_393_1.duration_ then
				local var_396_17 = var_396_16

				arg_393_1.duration_ = var_396_16 + var_396_14
			end

			if var_396_14 < arg_393_1.time_ and arg_393_1.time_ <= var_396_14 + arg_396_0 then
				local var_396_18 = "play"
				local var_396_19 = "voice"

				arg_393_1:AudioAction(var_396_18, var_396_19, "story_v_out_122531", "122531097", "story_v_out_122531.awb")
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play122531098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 122531098
		arg_397_1.duration_ = 1

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play122531099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.fswbg_:SetActive(true)
				arg_397_1.dialog_:SetActive(false)

				arg_397_1.fswtw_.percent = 0

				local var_400_1 = arg_397_1:GetWordFromCfg(122531098)
				local var_400_2 = arg_397_1:FormatText(var_400_1.content)

				arg_397_1.fswt_.text = var_400_2

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.fswt_)

				arg_397_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_397_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_397_1.fswtw_:SetDirty()

				arg_397_1.typewritterCharCountI18N = 0

				SetActive(arg_397_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_397_1:ShowNextGo(false)
			end

			local var_400_3 = 0.0166666666666666

			if var_400_3 < arg_397_1.time_ and arg_397_1.time_ <= var_400_3 + arg_400_0 then
				arg_397_1.var_.oldValueTypewriter = arg_397_1.fswtw_.percent

				SetActive(arg_397_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_397_1:ShowNextGo(false)
			end

			local var_400_4 = 6
			local var_400_5 = 0.4
			local var_400_6 = arg_397_1:GetWordFromCfg(122531098)
			local var_400_7 = arg_397_1:FormatText(var_400_6.content)
			local var_400_8, var_400_9 = arg_397_1:GetPercentByPara(var_400_7, 1)

			if var_400_3 < arg_397_1.time_ and arg_397_1.time_ <= var_400_3 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0

				local var_400_10 = var_400_4 <= 0 and var_400_5 or var_400_5 * ((var_400_9 - arg_397_1.typewritterCharCountI18N) / var_400_4)

				if var_400_10 > 0 and var_400_5 < var_400_10 then
					arg_397_1.talkMaxDuration = var_400_10

					if var_400_10 + var_400_3 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_10 + var_400_3
					end
				end
			end

			local var_400_11 = 0.4
			local var_400_12 = math.max(var_400_11, arg_397_1.talkMaxDuration)

			if var_400_3 <= arg_397_1.time_ and arg_397_1.time_ < var_400_3 + var_400_12 then
				local var_400_13 = (arg_397_1.time_ - var_400_3) / var_400_12

				arg_397_1.fswtw_.percent = Mathf.Lerp(arg_397_1.var_.oldValueTypewriter, var_400_8, var_400_13)
				arg_397_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_397_1.fswtw_:SetDirty()
			end

			if arg_397_1.time_ >= var_400_3 + var_400_12 and arg_397_1.time_ < var_400_3 + var_400_12 + arg_400_0 then
				arg_397_1.fswtw_.percent = var_400_8

				arg_397_1.fswtw_:SetDirty()
				arg_397_1:ShowNextGo(true)

				arg_397_1.typewritterCharCountI18N = var_400_9
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play122531099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 122531099
		arg_401_1.duration_ = 9

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play122531100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 2

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				local var_404_1 = manager.ui.mainCamera.transform.localPosition
				local var_404_2 = Vector3.New(0, 0, 10) + Vector3.New(var_404_1.x, var_404_1.y, 0)
				local var_404_3 = arg_401_1.bgs_.ST41

				var_404_3.transform.localPosition = var_404_2
				var_404_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_404_4 = var_404_3:GetComponent("SpriteRenderer")

				if var_404_4 and var_404_4.sprite then
					local var_404_5 = (var_404_3.transform.localPosition - var_404_1).z
					local var_404_6 = manager.ui.mainCameraCom_
					local var_404_7 = 2 * var_404_5 * Mathf.Tan(var_404_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_404_8 = var_404_7 * var_404_6.aspect
					local var_404_9 = var_404_4.sprite.bounds.size.x
					local var_404_10 = var_404_4.sprite.bounds.size.y
					local var_404_11 = var_404_8 / var_404_9
					local var_404_12 = var_404_7 / var_404_10
					local var_404_13 = var_404_12 < var_404_11 and var_404_11 or var_404_12

					var_404_3.transform.localScale = Vector3.New(var_404_13, var_404_13, 0)
				end

				for iter_404_0, iter_404_1 in pairs(arg_401_1.bgs_) do
					if iter_404_0 ~= "ST41" then
						iter_404_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_404_14 = 0

			if var_404_14 < arg_401_1.time_ and arg_401_1.time_ <= var_404_14 + arg_404_0 then
				arg_401_1.mask_.enabled = true
				arg_401_1.mask_.raycastTarget = true

				arg_401_1:SetGaussion(false)
			end

			local var_404_15 = 2

			if var_404_14 <= arg_401_1.time_ and arg_401_1.time_ < var_404_14 + var_404_15 then
				local var_404_16 = (arg_401_1.time_ - var_404_14) / var_404_15
				local var_404_17 = Color.New(0, 0, 0)

				var_404_17.a = Mathf.Lerp(0, 1, var_404_16)
				arg_401_1.mask_.color = var_404_17
			end

			if arg_401_1.time_ >= var_404_14 + var_404_15 and arg_401_1.time_ < var_404_14 + var_404_15 + arg_404_0 then
				local var_404_18 = Color.New(0, 0, 0)

				var_404_18.a = 1
				arg_401_1.mask_.color = var_404_18
			end

			local var_404_19 = 2

			if var_404_19 < arg_401_1.time_ and arg_401_1.time_ <= var_404_19 + arg_404_0 then
				arg_401_1.mask_.enabled = true
				arg_401_1.mask_.raycastTarget = true

				arg_401_1:SetGaussion(false)
			end

			local var_404_20 = 2

			if var_404_19 <= arg_401_1.time_ and arg_401_1.time_ < var_404_19 + var_404_20 then
				local var_404_21 = (arg_401_1.time_ - var_404_19) / var_404_20
				local var_404_22 = Color.New(0, 0, 0)

				var_404_22.a = Mathf.Lerp(1, 0, var_404_21)
				arg_401_1.mask_.color = var_404_22
			end

			if arg_401_1.time_ >= var_404_19 + var_404_20 and arg_401_1.time_ < var_404_19 + var_404_20 + arg_404_0 then
				local var_404_23 = Color.New(0, 0, 0)
				local var_404_24 = 0

				arg_401_1.mask_.enabled = false
				var_404_23.a = var_404_24
				arg_401_1.mask_.color = var_404_23
			end

			local var_404_25 = 2

			if var_404_25 < arg_401_1.time_ and arg_401_1.time_ <= var_404_25 + arg_404_0 then
				arg_401_1.fswbg_:SetActive(false)
				arg_401_1.dialog_:SetActive(false)
				SetActive(arg_401_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_401_1:ShowNextGo(false)
			end

			local var_404_26 = 0
			local var_404_27 = 1

			if var_404_26 < arg_401_1.time_ and arg_401_1.time_ <= var_404_26 + arg_404_0 then
				local var_404_28 = "stop"
				local var_404_29 = "effect"

				arg_401_1:AudioAction(var_404_28, var_404_29, "se_story_122_03", "se_story_122_03_write", "")
			end

			if arg_401_1.frameCnt_ <= 1 then
				arg_401_1.dialog_:SetActive(false)
			end

			local var_404_30 = 3.999999999999
			local var_404_31 = 1.175

			if var_404_30 < arg_401_1.time_ and arg_401_1.time_ <= var_404_30 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0

				arg_401_1.dialog_:SetActive(true)

				arg_401_1.dialogCg_.alpha = 0

				local var_404_32 = LeanTween.value(arg_401_1.dialog_, 0, 1, 0.3)

				var_404_32:setOnUpdate(LuaHelper.FloatAction(function(arg_405_0)
					arg_401_1.dialogCg_.alpha = arg_405_0
				end))
				var_404_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_401_1.dialog_)
					var_404_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_401_1.duration_ = arg_401_1.duration_ + 0.3

				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_33 = arg_401_1:GetWordFromCfg(122531099)
				local var_404_34 = arg_401_1:FormatText(var_404_33.content)

				arg_401_1.text_.text = var_404_34

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_35 = 47
				local var_404_36 = utf8.len(var_404_34)
				local var_404_37 = var_404_35 <= 0 and var_404_31 or var_404_31 * (var_404_36 / var_404_35)

				if var_404_37 > 0 and var_404_31 < var_404_37 then
					arg_401_1.talkMaxDuration = var_404_37
					var_404_30 = var_404_30 + 0.3

					if var_404_37 + var_404_30 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_37 + var_404_30
					end
				end

				arg_401_1.text_.text = var_404_34
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_38 = var_404_30 + 0.3
			local var_404_39 = math.max(var_404_31, arg_401_1.talkMaxDuration)

			if var_404_38 <= arg_401_1.time_ and arg_401_1.time_ < var_404_38 + var_404_39 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_38) / var_404_39

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_38 + var_404_39 and arg_401_1.time_ < var_404_38 + var_404_39 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play122531100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 122531100
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play122531101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0
			local var_410_1 = 1.325

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_2 = arg_407_1:GetWordFromCfg(122531100)
				local var_410_3 = arg_407_1:FormatText(var_410_2.content)

				arg_407_1.text_.text = var_410_3

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_4 = 53
				local var_410_5 = utf8.len(var_410_3)
				local var_410_6 = var_410_4 <= 0 and var_410_1 or var_410_1 * (var_410_5 / var_410_4)

				if var_410_6 > 0 and var_410_1 < var_410_6 then
					arg_407_1.talkMaxDuration = var_410_6

					if var_410_6 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_6 + var_410_0
					end
				end

				arg_407_1.text_.text = var_410_3
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_7 = math.max(var_410_1, arg_407_1.talkMaxDuration)

			if var_410_0 <= arg_407_1.time_ and arg_407_1.time_ < var_410_0 + var_410_7 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_0) / var_410_7

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_0 + var_410_7 and arg_407_1.time_ < var_410_0 + var_410_7 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play122531101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 122531101
		arg_411_1.duration_ = 2

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play122531102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1075ui_story"].transform
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.var_.moveOldPos1075ui_story = var_414_0.localPosition
			end

			local var_414_2 = 0.001

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2
				local var_414_4 = Vector3.New(0, -1.055, -6.16)

				var_414_0.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1075ui_story, var_414_4, var_414_3)

				local var_414_5 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_5.x, var_414_5.y, var_414_5.z)

				local var_414_6 = var_414_0.localEulerAngles

				var_414_6.z = 0
				var_414_6.x = 0
				var_414_0.localEulerAngles = var_414_6
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 then
				var_414_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_414_7 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_7.x, var_414_7.y, var_414_7.z)

				local var_414_8 = var_414_0.localEulerAngles

				var_414_8.z = 0
				var_414_8.x = 0
				var_414_0.localEulerAngles = var_414_8
			end

			local var_414_9 = arg_411_1.actors_["1075ui_story"]
			local var_414_10 = 0

			if var_414_10 < arg_411_1.time_ and arg_411_1.time_ <= var_414_10 + arg_414_0 and not isNil(var_414_9) and arg_411_1.var_.characterEffect1075ui_story == nil then
				arg_411_1.var_.characterEffect1075ui_story = var_414_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_11 = 0.200000002980232

			if var_414_10 <= arg_411_1.time_ and arg_411_1.time_ < var_414_10 + var_414_11 and not isNil(var_414_9) then
				local var_414_12 = (arg_411_1.time_ - var_414_10) / var_414_11

				if arg_411_1.var_.characterEffect1075ui_story and not isNil(var_414_9) then
					arg_411_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= var_414_10 + var_414_11 and arg_411_1.time_ < var_414_10 + var_414_11 + arg_414_0 and not isNil(var_414_9) and arg_411_1.var_.characterEffect1075ui_story then
				arg_411_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_414_13 = 0

			if var_414_13 < arg_411_1.time_ and arg_411_1.time_ <= var_414_13 + arg_414_0 then
				arg_411_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_414_14 = 0

			if var_414_14 < arg_411_1.time_ and arg_411_1.time_ <= var_414_14 + arg_414_0 then
				arg_411_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_414_15 = 0

			if var_414_15 < arg_411_1.time_ and arg_411_1.time_ <= var_414_15 + arg_414_0 then
				arg_411_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_414_16 = 0
			local var_414_17 = 0.075

			if var_414_16 < arg_411_1.time_ and arg_411_1.time_ <= var_414_16 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_18 = arg_411_1:FormatText(StoryNameCfg[381].name)

				arg_411_1.leftNameTxt_.text = var_414_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_19 = arg_411_1:GetWordFromCfg(122531101)
				local var_414_20 = arg_411_1:FormatText(var_414_19.content)

				arg_411_1.text_.text = var_414_20

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_21 = 3
				local var_414_22 = utf8.len(var_414_20)
				local var_414_23 = var_414_21 <= 0 and var_414_17 or var_414_17 * (var_414_22 / var_414_21)

				if var_414_23 > 0 and var_414_17 < var_414_23 then
					arg_411_1.talkMaxDuration = var_414_23

					if var_414_23 + var_414_16 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_23 + var_414_16
					end
				end

				arg_411_1.text_.text = var_414_20
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531101", "story_v_out_122531.awb") ~= 0 then
					local var_414_24 = manager.audio:GetVoiceLength("story_v_out_122531", "122531101", "story_v_out_122531.awb") / 1000

					if var_414_24 + var_414_16 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_24 + var_414_16
					end

					if var_414_19.prefab_name ~= "" and arg_411_1.actors_[var_414_19.prefab_name] ~= nil then
						local var_414_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_19.prefab_name].transform, "story_v_out_122531", "122531101", "story_v_out_122531.awb")

						arg_411_1:RecordAudio("122531101", var_414_25)
						arg_411_1:RecordAudio("122531101", var_414_25)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_122531", "122531101", "story_v_out_122531.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_122531", "122531101", "story_v_out_122531.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_26 = math.max(var_414_17, arg_411_1.talkMaxDuration)

			if var_414_16 <= arg_411_1.time_ and arg_411_1.time_ < var_414_16 + var_414_26 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_16) / var_414_26

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_16 + var_414_26 and arg_411_1.time_ < var_414_16 + var_414_26 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play122531102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 122531102
		arg_415_1.duration_ = 2

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play122531103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["1071ui_story"].transform
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.var_.moveOldPos1071ui_story = var_418_0.localPosition
			end

			local var_418_2 = 0.001

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2
				local var_418_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_418_0.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1071ui_story, var_418_4, var_418_3)

				local var_418_5 = manager.ui.mainCamera.transform.position - var_418_0.position

				var_418_0.forward = Vector3.New(var_418_5.x, var_418_5.y, var_418_5.z)

				local var_418_6 = var_418_0.localEulerAngles

				var_418_6.z = 0
				var_418_6.x = 0
				var_418_0.localEulerAngles = var_418_6
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 then
				var_418_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_418_7 = manager.ui.mainCamera.transform.position - var_418_0.position

				var_418_0.forward = Vector3.New(var_418_7.x, var_418_7.y, var_418_7.z)

				local var_418_8 = var_418_0.localEulerAngles

				var_418_8.z = 0
				var_418_8.x = 0
				var_418_0.localEulerAngles = var_418_8
			end

			local var_418_9 = arg_415_1.actors_["1071ui_story"]
			local var_418_10 = 0

			if var_418_10 < arg_415_1.time_ and arg_415_1.time_ <= var_418_10 + arg_418_0 and not isNil(var_418_9) and arg_415_1.var_.characterEffect1071ui_story == nil then
				arg_415_1.var_.characterEffect1071ui_story = var_418_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_11 = 0.200000002980232

			if var_418_10 <= arg_415_1.time_ and arg_415_1.time_ < var_418_10 + var_418_11 and not isNil(var_418_9) then
				local var_418_12 = (arg_415_1.time_ - var_418_10) / var_418_11

				if arg_415_1.var_.characterEffect1071ui_story and not isNil(var_418_9) then
					arg_415_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= var_418_10 + var_418_11 and arg_415_1.time_ < var_418_10 + var_418_11 + arg_418_0 and not isNil(var_418_9) and arg_415_1.var_.characterEffect1071ui_story then
				arg_415_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_418_13 = 0

			if var_418_13 < arg_415_1.time_ and arg_415_1.time_ <= var_418_13 + arg_418_0 then
				arg_415_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_418_14 = arg_415_1.actors_["1075ui_story"].transform
			local var_418_15 = 0

			if var_418_15 < arg_415_1.time_ and arg_415_1.time_ <= var_418_15 + arg_418_0 then
				arg_415_1.var_.moveOldPos1075ui_story = var_418_14.localPosition
			end

			local var_418_16 = 0.001

			if var_418_15 <= arg_415_1.time_ and arg_415_1.time_ < var_418_15 + var_418_16 then
				local var_418_17 = (arg_415_1.time_ - var_418_15) / var_418_16
				local var_418_18 = Vector3.New(0.7, -1.055, -6.16)

				var_418_14.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1075ui_story, var_418_18, var_418_17)

				local var_418_19 = manager.ui.mainCamera.transform.position - var_418_14.position

				var_418_14.forward = Vector3.New(var_418_19.x, var_418_19.y, var_418_19.z)

				local var_418_20 = var_418_14.localEulerAngles

				var_418_20.z = 0
				var_418_20.x = 0
				var_418_14.localEulerAngles = var_418_20
			end

			if arg_415_1.time_ >= var_418_15 + var_418_16 and arg_415_1.time_ < var_418_15 + var_418_16 + arg_418_0 then
				var_418_14.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_418_21 = manager.ui.mainCamera.transform.position - var_418_14.position

				var_418_14.forward = Vector3.New(var_418_21.x, var_418_21.y, var_418_21.z)

				local var_418_22 = var_418_14.localEulerAngles

				var_418_22.z = 0
				var_418_22.x = 0
				var_418_14.localEulerAngles = var_418_22
			end

			local var_418_23 = arg_415_1.actors_["1075ui_story"]
			local var_418_24 = 0

			if var_418_24 < arg_415_1.time_ and arg_415_1.time_ <= var_418_24 + arg_418_0 and not isNil(var_418_23) and arg_415_1.var_.characterEffect1075ui_story == nil then
				arg_415_1.var_.characterEffect1075ui_story = var_418_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_25 = 0.200000002980232

			if var_418_24 <= arg_415_1.time_ and arg_415_1.time_ < var_418_24 + var_418_25 and not isNil(var_418_23) then
				local var_418_26 = (arg_415_1.time_ - var_418_24) / var_418_25

				if arg_415_1.var_.characterEffect1075ui_story and not isNil(var_418_23) then
					local var_418_27 = Mathf.Lerp(0, 0.5, var_418_26)

					arg_415_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_415_1.var_.characterEffect1075ui_story.fillRatio = var_418_27
				end
			end

			if arg_415_1.time_ >= var_418_24 + var_418_25 and arg_415_1.time_ < var_418_24 + var_418_25 + arg_418_0 and not isNil(var_418_23) and arg_415_1.var_.characterEffect1075ui_story then
				local var_418_28 = 0.5

				arg_415_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_415_1.var_.characterEffect1075ui_story.fillRatio = var_418_28
			end

			local var_418_29 = 0
			local var_418_30 = 0.05

			if var_418_29 < arg_415_1.time_ and arg_415_1.time_ <= var_418_29 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_31 = arg_415_1:FormatText(StoryNameCfg[384].name)

				arg_415_1.leftNameTxt_.text = var_418_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_32 = arg_415_1:GetWordFromCfg(122531102)
				local var_418_33 = arg_415_1:FormatText(var_418_32.content)

				arg_415_1.text_.text = var_418_33

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_34 = 2
				local var_418_35 = utf8.len(var_418_33)
				local var_418_36 = var_418_34 <= 0 and var_418_30 or var_418_30 * (var_418_35 / var_418_34)

				if var_418_36 > 0 and var_418_30 < var_418_36 then
					arg_415_1.talkMaxDuration = var_418_36

					if var_418_36 + var_418_29 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_36 + var_418_29
					end
				end

				arg_415_1.text_.text = var_418_33
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531102", "story_v_out_122531.awb") ~= 0 then
					local var_418_37 = manager.audio:GetVoiceLength("story_v_out_122531", "122531102", "story_v_out_122531.awb") / 1000

					if var_418_37 + var_418_29 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_37 + var_418_29
					end

					if var_418_32.prefab_name ~= "" and arg_415_1.actors_[var_418_32.prefab_name] ~= nil then
						local var_418_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_32.prefab_name].transform, "story_v_out_122531", "122531102", "story_v_out_122531.awb")

						arg_415_1:RecordAudio("122531102", var_418_38)
						arg_415_1:RecordAudio("122531102", var_418_38)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_122531", "122531102", "story_v_out_122531.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_122531", "122531102", "story_v_out_122531.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_39 = math.max(var_418_30, arg_415_1.talkMaxDuration)

			if var_418_29 <= arg_415_1.time_ and arg_415_1.time_ < var_418_29 + var_418_39 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_29) / var_418_39

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_29 + var_418_39 and arg_415_1.time_ < var_418_29 + var_418_39 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play122531103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 122531103
		arg_419_1.duration_ = 3.5

		local var_419_0 = {
			ja = 3.5,
			ko = 1.933,
			zh = 1.933
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play122531104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["1075ui_story"].transform
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.var_.moveOldPos1075ui_story = var_422_0.localPosition
			end

			local var_422_2 = 0.001

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2
				local var_422_4 = Vector3.New(0.7, -1.055, -6.16)

				var_422_0.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1075ui_story, var_422_4, var_422_3)

				local var_422_5 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_5.x, var_422_5.y, var_422_5.z)

				local var_422_6 = var_422_0.localEulerAngles

				var_422_6.z = 0
				var_422_6.x = 0
				var_422_0.localEulerAngles = var_422_6
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 then
				var_422_0.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_422_7 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_7.x, var_422_7.y, var_422_7.z)

				local var_422_8 = var_422_0.localEulerAngles

				var_422_8.z = 0
				var_422_8.x = 0
				var_422_0.localEulerAngles = var_422_8
			end

			local var_422_9 = arg_419_1.actors_["1075ui_story"]
			local var_422_10 = 0

			if var_422_10 < arg_419_1.time_ and arg_419_1.time_ <= var_422_10 + arg_422_0 and not isNil(var_422_9) and arg_419_1.var_.characterEffect1075ui_story == nil then
				arg_419_1.var_.characterEffect1075ui_story = var_422_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_11 = 0.200000002980232

			if var_422_10 <= arg_419_1.time_ and arg_419_1.time_ < var_422_10 + var_422_11 and not isNil(var_422_9) then
				local var_422_12 = (arg_419_1.time_ - var_422_10) / var_422_11

				if arg_419_1.var_.characterEffect1075ui_story and not isNil(var_422_9) then
					arg_419_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= var_422_10 + var_422_11 and arg_419_1.time_ < var_422_10 + var_422_11 + arg_422_0 and not isNil(var_422_9) and arg_419_1.var_.characterEffect1075ui_story then
				arg_419_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_422_13 = 0

			if var_422_13 < arg_419_1.time_ and arg_419_1.time_ <= var_422_13 + arg_422_0 then
				arg_419_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_422_14 = 0

			if var_422_14 < arg_419_1.time_ and arg_419_1.time_ <= var_422_14 + arg_422_0 then
				arg_419_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_422_15 = arg_419_1.actors_["1071ui_story"]
			local var_422_16 = 0

			if var_422_16 < arg_419_1.time_ and arg_419_1.time_ <= var_422_16 + arg_422_0 and not isNil(var_422_15) and arg_419_1.var_.characterEffect1071ui_story == nil then
				arg_419_1.var_.characterEffect1071ui_story = var_422_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_17 = 0.200000002980232

			if var_422_16 <= arg_419_1.time_ and arg_419_1.time_ < var_422_16 + var_422_17 and not isNil(var_422_15) then
				local var_422_18 = (arg_419_1.time_ - var_422_16) / var_422_17

				if arg_419_1.var_.characterEffect1071ui_story and not isNil(var_422_15) then
					local var_422_19 = Mathf.Lerp(0, 0.5, var_422_18)

					arg_419_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_419_1.var_.characterEffect1071ui_story.fillRatio = var_422_19
				end
			end

			if arg_419_1.time_ >= var_422_16 + var_422_17 and arg_419_1.time_ < var_422_16 + var_422_17 + arg_422_0 and not isNil(var_422_15) and arg_419_1.var_.characterEffect1071ui_story then
				local var_422_20 = 0.5

				arg_419_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_419_1.var_.characterEffect1071ui_story.fillRatio = var_422_20
			end

			local var_422_21 = 0
			local var_422_22 = 0.15

			if var_422_21 < arg_419_1.time_ and arg_419_1.time_ <= var_422_21 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_23 = arg_419_1:FormatText(StoryNameCfg[381].name)

				arg_419_1.leftNameTxt_.text = var_422_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_24 = arg_419_1:GetWordFromCfg(122531103)
				local var_422_25 = arg_419_1:FormatText(var_422_24.content)

				arg_419_1.text_.text = var_422_25

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_26 = 6
				local var_422_27 = utf8.len(var_422_25)
				local var_422_28 = var_422_26 <= 0 and var_422_22 or var_422_22 * (var_422_27 / var_422_26)

				if var_422_28 > 0 and var_422_22 < var_422_28 then
					arg_419_1.talkMaxDuration = var_422_28

					if var_422_28 + var_422_21 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_28 + var_422_21
					end
				end

				arg_419_1.text_.text = var_422_25
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531103", "story_v_out_122531.awb") ~= 0 then
					local var_422_29 = manager.audio:GetVoiceLength("story_v_out_122531", "122531103", "story_v_out_122531.awb") / 1000

					if var_422_29 + var_422_21 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_29 + var_422_21
					end

					if var_422_24.prefab_name ~= "" and arg_419_1.actors_[var_422_24.prefab_name] ~= nil then
						local var_422_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_24.prefab_name].transform, "story_v_out_122531", "122531103", "story_v_out_122531.awb")

						arg_419_1:RecordAudio("122531103", var_422_30)
						arg_419_1:RecordAudio("122531103", var_422_30)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_122531", "122531103", "story_v_out_122531.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_122531", "122531103", "story_v_out_122531.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_31 = math.max(var_422_22, arg_419_1.talkMaxDuration)

			if var_422_21 <= arg_419_1.time_ and arg_419_1.time_ < var_422_21 + var_422_31 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_21) / var_422_31

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_21 + var_422_31 and arg_419_1.time_ < var_422_21 + var_422_31 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play122531104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 122531104
		arg_423_1.duration_ = 2.8

		local var_423_0 = {
			ja = 2.8,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play122531105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1071ui_story"]
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect1071ui_story == nil then
				arg_423_1.var_.characterEffect1071ui_story = var_426_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 and not isNil(var_426_0) then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2

				if arg_423_1.var_.characterEffect1071ui_story and not isNil(var_426_0) then
					arg_423_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect1071ui_story then
				arg_423_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_426_4 = 0

			if var_426_4 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_426_5 = arg_423_1.actors_["1075ui_story"]
			local var_426_6 = 0

			if var_426_6 < arg_423_1.time_ and arg_423_1.time_ <= var_426_6 + arg_426_0 and not isNil(var_426_5) and arg_423_1.var_.characterEffect1075ui_story == nil then
				arg_423_1.var_.characterEffect1075ui_story = var_426_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_7 = 0.200000002980232

			if var_426_6 <= arg_423_1.time_ and arg_423_1.time_ < var_426_6 + var_426_7 and not isNil(var_426_5) then
				local var_426_8 = (arg_423_1.time_ - var_426_6) / var_426_7

				if arg_423_1.var_.characterEffect1075ui_story and not isNil(var_426_5) then
					local var_426_9 = Mathf.Lerp(0, 0.5, var_426_8)

					arg_423_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1075ui_story.fillRatio = var_426_9
				end
			end

			if arg_423_1.time_ >= var_426_6 + var_426_7 and arg_423_1.time_ < var_426_6 + var_426_7 + arg_426_0 and not isNil(var_426_5) and arg_423_1.var_.characterEffect1075ui_story then
				local var_426_10 = 0.5

				arg_423_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1075ui_story.fillRatio = var_426_10
			end

			local var_426_11 = 0
			local var_426_12 = 0.15

			if var_426_11 < arg_423_1.time_ and arg_423_1.time_ <= var_426_11 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_13 = arg_423_1:FormatText(StoryNameCfg[384].name)

				arg_423_1.leftNameTxt_.text = var_426_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_14 = arg_423_1:GetWordFromCfg(122531104)
				local var_426_15 = arg_423_1:FormatText(var_426_14.content)

				arg_423_1.text_.text = var_426_15

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_16 = 6
				local var_426_17 = utf8.len(var_426_15)
				local var_426_18 = var_426_16 <= 0 and var_426_12 or var_426_12 * (var_426_17 / var_426_16)

				if var_426_18 > 0 and var_426_12 < var_426_18 then
					arg_423_1.talkMaxDuration = var_426_18

					if var_426_18 + var_426_11 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_18 + var_426_11
					end
				end

				arg_423_1.text_.text = var_426_15
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531104", "story_v_out_122531.awb") ~= 0 then
					local var_426_19 = manager.audio:GetVoiceLength("story_v_out_122531", "122531104", "story_v_out_122531.awb") / 1000

					if var_426_19 + var_426_11 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_19 + var_426_11
					end

					if var_426_14.prefab_name ~= "" and arg_423_1.actors_[var_426_14.prefab_name] ~= nil then
						local var_426_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_14.prefab_name].transform, "story_v_out_122531", "122531104", "story_v_out_122531.awb")

						arg_423_1:RecordAudio("122531104", var_426_20)
						arg_423_1:RecordAudio("122531104", var_426_20)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_122531", "122531104", "story_v_out_122531.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_122531", "122531104", "story_v_out_122531.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_21 = math.max(var_426_12, arg_423_1.talkMaxDuration)

			if var_426_11 <= arg_423_1.time_ and arg_423_1.time_ < var_426_11 + var_426_21 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_11) / var_426_21

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_11 + var_426_21 and arg_423_1.time_ < var_426_11 + var_426_21 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play122531105 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 122531105
		arg_427_1.duration_ = 2.17

		local var_427_0 = {
			ja = 2.166,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play122531106(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["1075ui_story"].transform
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.var_.moveOldPos1075ui_story = var_430_0.localPosition
			end

			local var_430_2 = 0.001

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2
				local var_430_4 = Vector3.New(0, 100, 0)

				var_430_0.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1075ui_story, var_430_4, var_430_3)

				local var_430_5 = manager.ui.mainCamera.transform.position - var_430_0.position

				var_430_0.forward = Vector3.New(var_430_5.x, var_430_5.y, var_430_5.z)

				local var_430_6 = var_430_0.localEulerAngles

				var_430_6.z = 0
				var_430_6.x = 0
				var_430_0.localEulerAngles = var_430_6
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 then
				var_430_0.localPosition = Vector3.New(0, 100, 0)

				local var_430_7 = manager.ui.mainCamera.transform.position - var_430_0.position

				var_430_0.forward = Vector3.New(var_430_7.x, var_430_7.y, var_430_7.z)

				local var_430_8 = var_430_0.localEulerAngles

				var_430_8.z = 0
				var_430_8.x = 0
				var_430_0.localEulerAngles = var_430_8
			end

			local var_430_9 = arg_427_1.actors_["1075ui_story"]
			local var_430_10 = 0

			if var_430_10 < arg_427_1.time_ and arg_427_1.time_ <= var_430_10 + arg_430_0 and not isNil(var_430_9) and arg_427_1.var_.characterEffect1075ui_story == nil then
				arg_427_1.var_.characterEffect1075ui_story = var_430_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_11 = 0.200000002980232

			if var_430_10 <= arg_427_1.time_ and arg_427_1.time_ < var_430_10 + var_430_11 and not isNil(var_430_9) then
				local var_430_12 = (arg_427_1.time_ - var_430_10) / var_430_11

				if arg_427_1.var_.characterEffect1075ui_story and not isNil(var_430_9) then
					local var_430_13 = Mathf.Lerp(0, 0.5, var_430_12)

					arg_427_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1075ui_story.fillRatio = var_430_13
				end
			end

			if arg_427_1.time_ >= var_430_10 + var_430_11 and arg_427_1.time_ < var_430_10 + var_430_11 + arg_430_0 and not isNil(var_430_9) and arg_427_1.var_.characterEffect1075ui_story then
				local var_430_14 = 0.5

				arg_427_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1075ui_story.fillRatio = var_430_14
			end

			local var_430_15 = arg_427_1.actors_["1069ui_story"].transform
			local var_430_16 = 0

			if var_430_16 < arg_427_1.time_ and arg_427_1.time_ <= var_430_16 + arg_430_0 then
				arg_427_1.var_.moveOldPos1069ui_story = var_430_15.localPosition
			end

			local var_430_17 = 0.001

			if var_430_16 <= arg_427_1.time_ and arg_427_1.time_ < var_430_16 + var_430_17 then
				local var_430_18 = (arg_427_1.time_ - var_430_16) / var_430_17
				local var_430_19 = Vector3.New(0.7, -1, -6)

				var_430_15.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1069ui_story, var_430_19, var_430_18)

				local var_430_20 = manager.ui.mainCamera.transform.position - var_430_15.position

				var_430_15.forward = Vector3.New(var_430_20.x, var_430_20.y, var_430_20.z)

				local var_430_21 = var_430_15.localEulerAngles

				var_430_21.z = 0
				var_430_21.x = 0
				var_430_15.localEulerAngles = var_430_21
			end

			if arg_427_1.time_ >= var_430_16 + var_430_17 and arg_427_1.time_ < var_430_16 + var_430_17 + arg_430_0 then
				var_430_15.localPosition = Vector3.New(0.7, -1, -6)

				local var_430_22 = manager.ui.mainCamera.transform.position - var_430_15.position

				var_430_15.forward = Vector3.New(var_430_22.x, var_430_22.y, var_430_22.z)

				local var_430_23 = var_430_15.localEulerAngles

				var_430_23.z = 0
				var_430_23.x = 0
				var_430_15.localEulerAngles = var_430_23
			end

			local var_430_24 = arg_427_1.actors_["1069ui_story"]
			local var_430_25 = 0

			if var_430_25 < arg_427_1.time_ and arg_427_1.time_ <= var_430_25 + arg_430_0 and not isNil(var_430_24) and arg_427_1.var_.characterEffect1069ui_story == nil then
				arg_427_1.var_.characterEffect1069ui_story = var_430_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_26 = 0.200000002980232

			if var_430_25 <= arg_427_1.time_ and arg_427_1.time_ < var_430_25 + var_430_26 and not isNil(var_430_24) then
				local var_430_27 = (arg_427_1.time_ - var_430_25) / var_430_26

				if arg_427_1.var_.characterEffect1069ui_story and not isNil(var_430_24) then
					arg_427_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= var_430_25 + var_430_26 and arg_427_1.time_ < var_430_25 + var_430_26 + arg_430_0 and not isNil(var_430_24) and arg_427_1.var_.characterEffect1069ui_story then
				arg_427_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_430_28 = 0

			if var_430_28 < arg_427_1.time_ and arg_427_1.time_ <= var_430_28 + arg_430_0 then
				arg_427_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_430_29 = 0

			if var_430_29 < arg_427_1.time_ and arg_427_1.time_ <= var_430_29 + arg_430_0 then
				arg_427_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_430_30 = arg_427_1.actors_["1071ui_story"]
			local var_430_31 = 0

			if var_430_31 < arg_427_1.time_ and arg_427_1.time_ <= var_430_31 + arg_430_0 and not isNil(var_430_30) and arg_427_1.var_.characterEffect1071ui_story == nil then
				arg_427_1.var_.characterEffect1071ui_story = var_430_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_32 = 0.200000002980232

			if var_430_31 <= arg_427_1.time_ and arg_427_1.time_ < var_430_31 + var_430_32 and not isNil(var_430_30) then
				local var_430_33 = (arg_427_1.time_ - var_430_31) / var_430_32

				if arg_427_1.var_.characterEffect1071ui_story and not isNil(var_430_30) then
					local var_430_34 = Mathf.Lerp(0, 0.5, var_430_33)

					arg_427_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1071ui_story.fillRatio = var_430_34
				end
			end

			if arg_427_1.time_ >= var_430_31 + var_430_32 and arg_427_1.time_ < var_430_31 + var_430_32 + arg_430_0 and not isNil(var_430_30) and arg_427_1.var_.characterEffect1071ui_story then
				local var_430_35 = 0.5

				arg_427_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1071ui_story.fillRatio = var_430_35
			end

			local var_430_36 = 0
			local var_430_37 = 0.175

			if var_430_36 < arg_427_1.time_ and arg_427_1.time_ <= var_430_36 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_38 = arg_427_1:FormatText(StoryNameCfg[378].name)

				arg_427_1.leftNameTxt_.text = var_430_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_39 = arg_427_1:GetWordFromCfg(122531105)
				local var_430_40 = arg_427_1:FormatText(var_430_39.content)

				arg_427_1.text_.text = var_430_40

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_41 = 7
				local var_430_42 = utf8.len(var_430_40)
				local var_430_43 = var_430_41 <= 0 and var_430_37 or var_430_37 * (var_430_42 / var_430_41)

				if var_430_43 > 0 and var_430_37 < var_430_43 then
					arg_427_1.talkMaxDuration = var_430_43

					if var_430_43 + var_430_36 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_43 + var_430_36
					end
				end

				arg_427_1.text_.text = var_430_40
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531105", "story_v_out_122531.awb") ~= 0 then
					local var_430_44 = manager.audio:GetVoiceLength("story_v_out_122531", "122531105", "story_v_out_122531.awb") / 1000

					if var_430_44 + var_430_36 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_44 + var_430_36
					end

					if var_430_39.prefab_name ~= "" and arg_427_1.actors_[var_430_39.prefab_name] ~= nil then
						local var_430_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_39.prefab_name].transform, "story_v_out_122531", "122531105", "story_v_out_122531.awb")

						arg_427_1:RecordAudio("122531105", var_430_45)
						arg_427_1:RecordAudio("122531105", var_430_45)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_122531", "122531105", "story_v_out_122531.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_122531", "122531105", "story_v_out_122531.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_46 = math.max(var_430_37, arg_427_1.talkMaxDuration)

			if var_430_36 <= arg_427_1.time_ and arg_427_1.time_ < var_430_36 + var_430_46 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_36) / var_430_46

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_36 + var_430_46 and arg_427_1.time_ < var_430_36 + var_430_46 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play122531106 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 122531106
		arg_431_1.duration_ = 14.43

		local var_431_0 = {
			ja = 14.433,
			ko = 10.533,
			zh = 10.533
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play122531107(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1071ui_story"].transform
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.var_.moveOldPos1071ui_story = var_434_0.localPosition
			end

			local var_434_2 = 0.001

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2
				local var_434_4 = Vector3.New(0, -1.05, -6.2)

				var_434_0.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1071ui_story, var_434_4, var_434_3)

				local var_434_5 = manager.ui.mainCamera.transform.position - var_434_0.position

				var_434_0.forward = Vector3.New(var_434_5.x, var_434_5.y, var_434_5.z)

				local var_434_6 = var_434_0.localEulerAngles

				var_434_6.z = 0
				var_434_6.x = 0
				var_434_0.localEulerAngles = var_434_6
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 then
				var_434_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_434_7 = manager.ui.mainCamera.transform.position - var_434_0.position

				var_434_0.forward = Vector3.New(var_434_7.x, var_434_7.y, var_434_7.z)

				local var_434_8 = var_434_0.localEulerAngles

				var_434_8.z = 0
				var_434_8.x = 0
				var_434_0.localEulerAngles = var_434_8
			end

			local var_434_9 = arg_431_1.actors_["1071ui_story"]
			local var_434_10 = 0

			if var_434_10 < arg_431_1.time_ and arg_431_1.time_ <= var_434_10 + arg_434_0 and not isNil(var_434_9) and arg_431_1.var_.characterEffect1071ui_story == nil then
				arg_431_1.var_.characterEffect1071ui_story = var_434_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_11 = 0.200000002980232

			if var_434_10 <= arg_431_1.time_ and arg_431_1.time_ < var_434_10 + var_434_11 and not isNil(var_434_9) then
				local var_434_12 = (arg_431_1.time_ - var_434_10) / var_434_11

				if arg_431_1.var_.characterEffect1071ui_story and not isNil(var_434_9) then
					arg_431_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= var_434_10 + var_434_11 and arg_431_1.time_ < var_434_10 + var_434_11 + arg_434_0 and not isNil(var_434_9) and arg_431_1.var_.characterEffect1071ui_story then
				arg_431_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_434_13 = 0

			if var_434_13 < arg_431_1.time_ and arg_431_1.time_ <= var_434_13 + arg_434_0 then
				arg_431_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_434_14 = arg_431_1.actors_["1069ui_story"].transform
			local var_434_15 = 0

			if var_434_15 < arg_431_1.time_ and arg_431_1.time_ <= var_434_15 + arg_434_0 then
				arg_431_1.var_.moveOldPos1069ui_story = var_434_14.localPosition
			end

			local var_434_16 = 0.001

			if var_434_15 <= arg_431_1.time_ and arg_431_1.time_ < var_434_15 + var_434_16 then
				local var_434_17 = (arg_431_1.time_ - var_434_15) / var_434_16
				local var_434_18 = Vector3.New(0, 100, 0)

				var_434_14.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1069ui_story, var_434_18, var_434_17)

				local var_434_19 = manager.ui.mainCamera.transform.position - var_434_14.position

				var_434_14.forward = Vector3.New(var_434_19.x, var_434_19.y, var_434_19.z)

				local var_434_20 = var_434_14.localEulerAngles

				var_434_20.z = 0
				var_434_20.x = 0
				var_434_14.localEulerAngles = var_434_20
			end

			if arg_431_1.time_ >= var_434_15 + var_434_16 and arg_431_1.time_ < var_434_15 + var_434_16 + arg_434_0 then
				var_434_14.localPosition = Vector3.New(0, 100, 0)

				local var_434_21 = manager.ui.mainCamera.transform.position - var_434_14.position

				var_434_14.forward = Vector3.New(var_434_21.x, var_434_21.y, var_434_21.z)

				local var_434_22 = var_434_14.localEulerAngles

				var_434_22.z = 0
				var_434_22.x = 0
				var_434_14.localEulerAngles = var_434_22
			end

			local var_434_23 = arg_431_1.actors_["1069ui_story"]
			local var_434_24 = 0

			if var_434_24 < arg_431_1.time_ and arg_431_1.time_ <= var_434_24 + arg_434_0 and not isNil(var_434_23) and arg_431_1.var_.characterEffect1069ui_story == nil then
				arg_431_1.var_.characterEffect1069ui_story = var_434_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_25 = 0.200000002980232

			if var_434_24 <= arg_431_1.time_ and arg_431_1.time_ < var_434_24 + var_434_25 and not isNil(var_434_23) then
				local var_434_26 = (arg_431_1.time_ - var_434_24) / var_434_25

				if arg_431_1.var_.characterEffect1069ui_story and not isNil(var_434_23) then
					local var_434_27 = Mathf.Lerp(0, 0.5, var_434_26)

					arg_431_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1069ui_story.fillRatio = var_434_27
				end
			end

			if arg_431_1.time_ >= var_434_24 + var_434_25 and arg_431_1.time_ < var_434_24 + var_434_25 + arg_434_0 and not isNil(var_434_23) and arg_431_1.var_.characterEffect1069ui_story then
				local var_434_28 = 0.5

				arg_431_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1069ui_story.fillRatio = var_434_28
			end

			local var_434_29 = 0
			local var_434_30 = 1.075

			if var_434_29 < arg_431_1.time_ and arg_431_1.time_ <= var_434_29 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_31 = arg_431_1:FormatText(StoryNameCfg[384].name)

				arg_431_1.leftNameTxt_.text = var_434_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_32 = arg_431_1:GetWordFromCfg(122531106)
				local var_434_33 = arg_431_1:FormatText(var_434_32.content)

				arg_431_1.text_.text = var_434_33

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_34 = 43
				local var_434_35 = utf8.len(var_434_33)
				local var_434_36 = var_434_34 <= 0 and var_434_30 or var_434_30 * (var_434_35 / var_434_34)

				if var_434_36 > 0 and var_434_30 < var_434_36 then
					arg_431_1.talkMaxDuration = var_434_36

					if var_434_36 + var_434_29 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_36 + var_434_29
					end
				end

				arg_431_1.text_.text = var_434_33
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531106", "story_v_out_122531.awb") ~= 0 then
					local var_434_37 = manager.audio:GetVoiceLength("story_v_out_122531", "122531106", "story_v_out_122531.awb") / 1000

					if var_434_37 + var_434_29 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_37 + var_434_29
					end

					if var_434_32.prefab_name ~= "" and arg_431_1.actors_[var_434_32.prefab_name] ~= nil then
						local var_434_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_32.prefab_name].transform, "story_v_out_122531", "122531106", "story_v_out_122531.awb")

						arg_431_1:RecordAudio("122531106", var_434_38)
						arg_431_1:RecordAudio("122531106", var_434_38)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_122531", "122531106", "story_v_out_122531.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_122531", "122531106", "story_v_out_122531.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_39 = math.max(var_434_30, arg_431_1.talkMaxDuration)

			if var_434_29 <= arg_431_1.time_ and arg_431_1.time_ < var_434_29 + var_434_39 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_29) / var_434_39

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_29 + var_434_39 and arg_431_1.time_ < var_434_29 + var_434_39 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play122531107 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 122531107
		arg_435_1.duration_ = 19.9

		local var_435_0 = {
			ja = 19.9,
			ko = 15.2,
			zh = 15.2
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play122531108(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_438_1 = 0
			local var_438_2 = 1.475

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_3 = arg_435_1:FormatText(StoryNameCfg[384].name)

				arg_435_1.leftNameTxt_.text = var_438_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_4 = arg_435_1:GetWordFromCfg(122531107)
				local var_438_5 = arg_435_1:FormatText(var_438_4.content)

				arg_435_1.text_.text = var_438_5

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_6 = 59
				local var_438_7 = utf8.len(var_438_5)
				local var_438_8 = var_438_6 <= 0 and var_438_2 or var_438_2 * (var_438_7 / var_438_6)

				if var_438_8 > 0 and var_438_2 < var_438_8 then
					arg_435_1.talkMaxDuration = var_438_8

					if var_438_8 + var_438_1 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_8 + var_438_1
					end
				end

				arg_435_1.text_.text = var_438_5
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531107", "story_v_out_122531.awb") ~= 0 then
					local var_438_9 = manager.audio:GetVoiceLength("story_v_out_122531", "122531107", "story_v_out_122531.awb") / 1000

					if var_438_9 + var_438_1 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_9 + var_438_1
					end

					if var_438_4.prefab_name ~= "" and arg_435_1.actors_[var_438_4.prefab_name] ~= nil then
						local var_438_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_4.prefab_name].transform, "story_v_out_122531", "122531107", "story_v_out_122531.awb")

						arg_435_1:RecordAudio("122531107", var_438_10)
						arg_435_1:RecordAudio("122531107", var_438_10)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_122531", "122531107", "story_v_out_122531.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_122531", "122531107", "story_v_out_122531.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_11 = math.max(var_438_2, arg_435_1.talkMaxDuration)

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_11 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_1) / var_438_11

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_1 + var_438_11 and arg_435_1.time_ < var_438_1 + var_438_11 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play122531108 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 122531108
		arg_439_1.duration_ = 19.13

		local var_439_0 = {
			ja = 19.133,
			ko = 15.1,
			zh = 15.1
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play122531109(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 1.5

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_2 = arg_439_1:FormatText(StoryNameCfg[384].name)

				arg_439_1.leftNameTxt_.text = var_442_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_3 = arg_439_1:GetWordFromCfg(122531108)
				local var_442_4 = arg_439_1:FormatText(var_442_3.content)

				arg_439_1.text_.text = var_442_4

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 60
				local var_442_6 = utf8.len(var_442_4)
				local var_442_7 = var_442_5 <= 0 and var_442_1 or var_442_1 * (var_442_6 / var_442_5)

				if var_442_7 > 0 and var_442_1 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_4
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531108", "story_v_out_122531.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531108", "story_v_out_122531.awb") / 1000

					if var_442_8 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_0
					end

					if var_442_3.prefab_name ~= "" and arg_439_1.actors_[var_442_3.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_3.prefab_name].transform, "story_v_out_122531", "122531108", "story_v_out_122531.awb")

						arg_439_1:RecordAudio("122531108", var_442_9)
						arg_439_1:RecordAudio("122531108", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_122531", "122531108", "story_v_out_122531.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_122531", "122531108", "story_v_out_122531.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_10 and arg_439_1.time_ < var_442_0 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play122531109 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 122531109
		arg_443_1.duration_ = 1.37

		local var_443_0 = {
			ja = 1.366,
			ko = 1.266,
			zh = 1.266
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play122531110(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["1075ui_story"].transform
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1.var_.moveOldPos1075ui_story = var_446_0.localPosition
			end

			local var_446_2 = 0.001

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_2 then
				local var_446_3 = (arg_443_1.time_ - var_446_1) / var_446_2
				local var_446_4 = Vector3.New(0, -1.055, -6.16)

				var_446_0.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1075ui_story, var_446_4, var_446_3)

				local var_446_5 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_5.x, var_446_5.y, var_446_5.z)

				local var_446_6 = var_446_0.localEulerAngles

				var_446_6.z = 0
				var_446_6.x = 0
				var_446_0.localEulerAngles = var_446_6
			end

			if arg_443_1.time_ >= var_446_1 + var_446_2 and arg_443_1.time_ < var_446_1 + var_446_2 + arg_446_0 then
				var_446_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_446_7 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_7.x, var_446_7.y, var_446_7.z)

				local var_446_8 = var_446_0.localEulerAngles

				var_446_8.z = 0
				var_446_8.x = 0
				var_446_0.localEulerAngles = var_446_8
			end

			local var_446_9 = arg_443_1.actors_["1075ui_story"]
			local var_446_10 = 0

			if var_446_10 < arg_443_1.time_ and arg_443_1.time_ <= var_446_10 + arg_446_0 and not isNil(var_446_9) and arg_443_1.var_.characterEffect1075ui_story == nil then
				arg_443_1.var_.characterEffect1075ui_story = var_446_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_11 = 0.200000002980232

			if var_446_10 <= arg_443_1.time_ and arg_443_1.time_ < var_446_10 + var_446_11 and not isNil(var_446_9) then
				local var_446_12 = (arg_443_1.time_ - var_446_10) / var_446_11

				if arg_443_1.var_.characterEffect1075ui_story and not isNil(var_446_9) then
					arg_443_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_443_1.time_ >= var_446_10 + var_446_11 and arg_443_1.time_ < var_446_10 + var_446_11 + arg_446_0 and not isNil(var_446_9) and arg_443_1.var_.characterEffect1075ui_story then
				arg_443_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_446_13 = 0

			if var_446_13 < arg_443_1.time_ and arg_443_1.time_ <= var_446_13 + arg_446_0 then
				arg_443_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_446_14 = 0

			if var_446_14 < arg_443_1.time_ and arg_443_1.time_ <= var_446_14 + arg_446_0 then
				arg_443_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_446_15 = arg_443_1.actors_["1071ui_story"].transform
			local var_446_16 = 0

			if var_446_16 < arg_443_1.time_ and arg_443_1.time_ <= var_446_16 + arg_446_0 then
				arg_443_1.var_.moveOldPos1071ui_story = var_446_15.localPosition
			end

			local var_446_17 = 0.001

			if var_446_16 <= arg_443_1.time_ and arg_443_1.time_ < var_446_16 + var_446_17 then
				local var_446_18 = (arg_443_1.time_ - var_446_16) / var_446_17
				local var_446_19 = Vector3.New(0, 100, 0)

				var_446_15.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1071ui_story, var_446_19, var_446_18)

				local var_446_20 = manager.ui.mainCamera.transform.position - var_446_15.position

				var_446_15.forward = Vector3.New(var_446_20.x, var_446_20.y, var_446_20.z)

				local var_446_21 = var_446_15.localEulerAngles

				var_446_21.z = 0
				var_446_21.x = 0
				var_446_15.localEulerAngles = var_446_21
			end

			if arg_443_1.time_ >= var_446_16 + var_446_17 and arg_443_1.time_ < var_446_16 + var_446_17 + arg_446_0 then
				var_446_15.localPosition = Vector3.New(0, 100, 0)

				local var_446_22 = manager.ui.mainCamera.transform.position - var_446_15.position

				var_446_15.forward = Vector3.New(var_446_22.x, var_446_22.y, var_446_22.z)

				local var_446_23 = var_446_15.localEulerAngles

				var_446_23.z = 0
				var_446_23.x = 0
				var_446_15.localEulerAngles = var_446_23
			end

			local var_446_24 = arg_443_1.actors_["1071ui_story"]
			local var_446_25 = 0

			if var_446_25 < arg_443_1.time_ and arg_443_1.time_ <= var_446_25 + arg_446_0 and not isNil(var_446_24) and arg_443_1.var_.characterEffect1071ui_story == nil then
				arg_443_1.var_.characterEffect1071ui_story = var_446_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_26 = 0.200000002980232

			if var_446_25 <= arg_443_1.time_ and arg_443_1.time_ < var_446_25 + var_446_26 and not isNil(var_446_24) then
				local var_446_27 = (arg_443_1.time_ - var_446_25) / var_446_26

				if arg_443_1.var_.characterEffect1071ui_story and not isNil(var_446_24) then
					local var_446_28 = Mathf.Lerp(0, 0.5, var_446_27)

					arg_443_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1071ui_story.fillRatio = var_446_28
				end
			end

			if arg_443_1.time_ >= var_446_25 + var_446_26 and arg_443_1.time_ < var_446_25 + var_446_26 + arg_446_0 and not isNil(var_446_24) and arg_443_1.var_.characterEffect1071ui_story then
				local var_446_29 = 0.5

				arg_443_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1071ui_story.fillRatio = var_446_29
			end

			local var_446_30 = 0
			local var_446_31 = 0.1

			if var_446_30 < arg_443_1.time_ and arg_443_1.time_ <= var_446_30 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_32 = arg_443_1:FormatText(StoryNameCfg[381].name)

				arg_443_1.leftNameTxt_.text = var_446_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_33 = arg_443_1:GetWordFromCfg(122531109)
				local var_446_34 = arg_443_1:FormatText(var_446_33.content)

				arg_443_1.text_.text = var_446_34

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_35 = 4
				local var_446_36 = utf8.len(var_446_34)
				local var_446_37 = var_446_35 <= 0 and var_446_31 or var_446_31 * (var_446_36 / var_446_35)

				if var_446_37 > 0 and var_446_31 < var_446_37 then
					arg_443_1.talkMaxDuration = var_446_37

					if var_446_37 + var_446_30 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_37 + var_446_30
					end
				end

				arg_443_1.text_.text = var_446_34
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531109", "story_v_out_122531.awb") ~= 0 then
					local var_446_38 = manager.audio:GetVoiceLength("story_v_out_122531", "122531109", "story_v_out_122531.awb") / 1000

					if var_446_38 + var_446_30 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_38 + var_446_30
					end

					if var_446_33.prefab_name ~= "" and arg_443_1.actors_[var_446_33.prefab_name] ~= nil then
						local var_446_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_33.prefab_name].transform, "story_v_out_122531", "122531109", "story_v_out_122531.awb")

						arg_443_1:RecordAudio("122531109", var_446_39)
						arg_443_1:RecordAudio("122531109", var_446_39)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_122531", "122531109", "story_v_out_122531.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_122531", "122531109", "story_v_out_122531.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_40 = math.max(var_446_31, arg_443_1.talkMaxDuration)

			if var_446_30 <= arg_443_1.time_ and arg_443_1.time_ < var_446_30 + var_446_40 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_30) / var_446_40

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_30 + var_446_40 and arg_443_1.time_ < var_446_30 + var_446_40 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play122531110 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 122531110
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play122531111(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["1075ui_story"].transform
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.var_.moveOldPos1075ui_story = var_450_0.localPosition
			end

			local var_450_2 = 0.001

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_2 then
				local var_450_3 = (arg_447_1.time_ - var_450_1) / var_450_2
				local var_450_4 = Vector3.New(0, 100, 0)

				var_450_0.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1075ui_story, var_450_4, var_450_3)

				local var_450_5 = manager.ui.mainCamera.transform.position - var_450_0.position

				var_450_0.forward = Vector3.New(var_450_5.x, var_450_5.y, var_450_5.z)

				local var_450_6 = var_450_0.localEulerAngles

				var_450_6.z = 0
				var_450_6.x = 0
				var_450_0.localEulerAngles = var_450_6
			end

			if arg_447_1.time_ >= var_450_1 + var_450_2 and arg_447_1.time_ < var_450_1 + var_450_2 + arg_450_0 then
				var_450_0.localPosition = Vector3.New(0, 100, 0)

				local var_450_7 = manager.ui.mainCamera.transform.position - var_450_0.position

				var_450_0.forward = Vector3.New(var_450_7.x, var_450_7.y, var_450_7.z)

				local var_450_8 = var_450_0.localEulerAngles

				var_450_8.z = 0
				var_450_8.x = 0
				var_450_0.localEulerAngles = var_450_8
			end

			local var_450_9 = arg_447_1.actors_["1075ui_story"]
			local var_450_10 = 0

			if var_450_10 < arg_447_1.time_ and arg_447_1.time_ <= var_450_10 + arg_450_0 and not isNil(var_450_9) and arg_447_1.var_.characterEffect1075ui_story == nil then
				arg_447_1.var_.characterEffect1075ui_story = var_450_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_11 = 0.200000002980232

			if var_450_10 <= arg_447_1.time_ and arg_447_1.time_ < var_450_10 + var_450_11 and not isNil(var_450_9) then
				local var_450_12 = (arg_447_1.time_ - var_450_10) / var_450_11

				if arg_447_1.var_.characterEffect1075ui_story and not isNil(var_450_9) then
					local var_450_13 = Mathf.Lerp(0, 0.5, var_450_12)

					arg_447_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_447_1.var_.characterEffect1075ui_story.fillRatio = var_450_13
				end
			end

			if arg_447_1.time_ >= var_450_10 + var_450_11 and arg_447_1.time_ < var_450_10 + var_450_11 + arg_450_0 and not isNil(var_450_9) and arg_447_1.var_.characterEffect1075ui_story then
				local var_450_14 = 0.5

				arg_447_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_447_1.var_.characterEffect1075ui_story.fillRatio = var_450_14
			end

			local var_450_15 = 0
			local var_450_16 = 1.375

			if var_450_15 < arg_447_1.time_ and arg_447_1.time_ <= var_450_15 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_17 = arg_447_1:GetWordFromCfg(122531110)
				local var_450_18 = arg_447_1:FormatText(var_450_17.content)

				arg_447_1.text_.text = var_450_18

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_19 = 55
				local var_450_20 = utf8.len(var_450_18)
				local var_450_21 = var_450_19 <= 0 and var_450_16 or var_450_16 * (var_450_20 / var_450_19)

				if var_450_21 > 0 and var_450_16 < var_450_21 then
					arg_447_1.talkMaxDuration = var_450_21

					if var_450_21 + var_450_15 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_21 + var_450_15
					end
				end

				arg_447_1.text_.text = var_450_18
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_22 = math.max(var_450_16, arg_447_1.talkMaxDuration)

			if var_450_15 <= arg_447_1.time_ and arg_447_1.time_ < var_450_15 + var_450_22 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_15) / var_450_22

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_15 + var_450_22 and arg_447_1.time_ < var_450_15 + var_450_22 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play122531111 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 122531111
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play122531112(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0
			local var_454_1 = 0.85

			if var_454_0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_2 = arg_451_1:GetWordFromCfg(122531111)
				local var_454_3 = arg_451_1:FormatText(var_454_2.content)

				arg_451_1.text_.text = var_454_3

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_4 = 34
				local var_454_5 = utf8.len(var_454_3)
				local var_454_6 = var_454_4 <= 0 and var_454_1 or var_454_1 * (var_454_5 / var_454_4)

				if var_454_6 > 0 and var_454_1 < var_454_6 then
					arg_451_1.talkMaxDuration = var_454_6

					if var_454_6 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_6 + var_454_0
					end
				end

				arg_451_1.text_.text = var_454_3
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_7 = math.max(var_454_1, arg_451_1.talkMaxDuration)

			if var_454_0 <= arg_451_1.time_ and arg_451_1.time_ < var_454_0 + var_454_7 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_0) / var_454_7

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_0 + var_454_7 and arg_451_1.time_ < var_454_0 + var_454_7 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play122531112 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 122531112
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play122531113(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0
			local var_458_1 = 0.675

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_2 = arg_455_1:GetWordFromCfg(122531112)
				local var_458_3 = arg_455_1:FormatText(var_458_2.content)

				arg_455_1.text_.text = var_458_3

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_4 = 27
				local var_458_5 = utf8.len(var_458_3)
				local var_458_6 = var_458_4 <= 0 and var_458_1 or var_458_1 * (var_458_5 / var_458_4)

				if var_458_6 > 0 and var_458_1 < var_458_6 then
					arg_455_1.talkMaxDuration = var_458_6

					if var_458_6 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_6 + var_458_0
					end
				end

				arg_455_1.text_.text = var_458_3
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_7 = math.max(var_458_1, arg_455_1.talkMaxDuration)

			if var_458_0 <= arg_455_1.time_ and arg_455_1.time_ < var_458_0 + var_458_7 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_0) / var_458_7

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_0 + var_458_7 and arg_455_1.time_ < var_458_0 + var_458_7 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play122531113 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 122531113
		arg_459_1.duration_ = 8.07

		local var_459_0 = {
			ja = 8.066,
			ko = 4.8,
			zh = 4.8
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play122531114(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = arg_459_1.actors_["1071ui_story"].transform
			local var_462_1 = 0

			if var_462_1 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 then
				arg_459_1.var_.moveOldPos1071ui_story = var_462_0.localPosition
			end

			local var_462_2 = 0.001

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_2 then
				local var_462_3 = (arg_459_1.time_ - var_462_1) / var_462_2
				local var_462_4 = Vector3.New(0, -1.05, -6.2)

				var_462_0.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos1071ui_story, var_462_4, var_462_3)

				local var_462_5 = manager.ui.mainCamera.transform.position - var_462_0.position

				var_462_0.forward = Vector3.New(var_462_5.x, var_462_5.y, var_462_5.z)

				local var_462_6 = var_462_0.localEulerAngles

				var_462_6.z = 0
				var_462_6.x = 0
				var_462_0.localEulerAngles = var_462_6
			end

			if arg_459_1.time_ >= var_462_1 + var_462_2 and arg_459_1.time_ < var_462_1 + var_462_2 + arg_462_0 then
				var_462_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_462_7 = manager.ui.mainCamera.transform.position - var_462_0.position

				var_462_0.forward = Vector3.New(var_462_7.x, var_462_7.y, var_462_7.z)

				local var_462_8 = var_462_0.localEulerAngles

				var_462_8.z = 0
				var_462_8.x = 0
				var_462_0.localEulerAngles = var_462_8
			end

			local var_462_9 = arg_459_1.actors_["1071ui_story"]
			local var_462_10 = 0

			if var_462_10 < arg_459_1.time_ and arg_459_1.time_ <= var_462_10 + arg_462_0 and not isNil(var_462_9) and arg_459_1.var_.characterEffect1071ui_story == nil then
				arg_459_1.var_.characterEffect1071ui_story = var_462_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_11 = 0.200000002980232

			if var_462_10 <= arg_459_1.time_ and arg_459_1.time_ < var_462_10 + var_462_11 and not isNil(var_462_9) then
				local var_462_12 = (arg_459_1.time_ - var_462_10) / var_462_11

				if arg_459_1.var_.characterEffect1071ui_story and not isNil(var_462_9) then
					arg_459_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_459_1.time_ >= var_462_10 + var_462_11 and arg_459_1.time_ < var_462_10 + var_462_11 + arg_462_0 and not isNil(var_462_9) and arg_459_1.var_.characterEffect1071ui_story then
				arg_459_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_462_13 = 0

			if var_462_13 < arg_459_1.time_ and arg_459_1.time_ <= var_462_13 + arg_462_0 then
				arg_459_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action6_1")
			end

			local var_462_14 = 0

			if var_462_14 < arg_459_1.time_ and arg_459_1.time_ <= var_462_14 + arg_462_0 then
				arg_459_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_462_15 = 0
			local var_462_16 = 0.325

			if var_462_15 < arg_459_1.time_ and arg_459_1.time_ <= var_462_15 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_17 = arg_459_1:FormatText(StoryNameCfg[384].name)

				arg_459_1.leftNameTxt_.text = var_462_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_18 = arg_459_1:GetWordFromCfg(122531113)
				local var_462_19 = arg_459_1:FormatText(var_462_18.content)

				arg_459_1.text_.text = var_462_19

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_20 = 13
				local var_462_21 = utf8.len(var_462_19)
				local var_462_22 = var_462_20 <= 0 and var_462_16 or var_462_16 * (var_462_21 / var_462_20)

				if var_462_22 > 0 and var_462_16 < var_462_22 then
					arg_459_1.talkMaxDuration = var_462_22

					if var_462_22 + var_462_15 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_22 + var_462_15
					end
				end

				arg_459_1.text_.text = var_462_19
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531113", "story_v_out_122531.awb") ~= 0 then
					local var_462_23 = manager.audio:GetVoiceLength("story_v_out_122531", "122531113", "story_v_out_122531.awb") / 1000

					if var_462_23 + var_462_15 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_23 + var_462_15
					end

					if var_462_18.prefab_name ~= "" and arg_459_1.actors_[var_462_18.prefab_name] ~= nil then
						local var_462_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_18.prefab_name].transform, "story_v_out_122531", "122531113", "story_v_out_122531.awb")

						arg_459_1:RecordAudio("122531113", var_462_24)
						arg_459_1:RecordAudio("122531113", var_462_24)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_122531", "122531113", "story_v_out_122531.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_122531", "122531113", "story_v_out_122531.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_25 = math.max(var_462_16, arg_459_1.talkMaxDuration)

			if var_462_15 <= arg_459_1.time_ and arg_459_1.time_ < var_462_15 + var_462_25 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_15) / var_462_25

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_15 + var_462_25 and arg_459_1.time_ < var_462_15 + var_462_25 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play122531114 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 122531114
		arg_463_1.duration_ = 5.33

		local var_463_0 = {
			ja = 4.7,
			ko = 5.333,
			zh = 5.333
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play122531115(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0
			local var_466_1 = 0.4

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_2 = arg_463_1:FormatText(StoryNameCfg[384].name)

				arg_463_1.leftNameTxt_.text = var_466_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_3 = arg_463_1:GetWordFromCfg(122531114)
				local var_466_4 = arg_463_1:FormatText(var_466_3.content)

				arg_463_1.text_.text = var_466_4

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_5 = 16
				local var_466_6 = utf8.len(var_466_4)
				local var_466_7 = var_466_5 <= 0 and var_466_1 or var_466_1 * (var_466_6 / var_466_5)

				if var_466_7 > 0 and var_466_1 < var_466_7 then
					arg_463_1.talkMaxDuration = var_466_7

					if var_466_7 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_7 + var_466_0
					end
				end

				arg_463_1.text_.text = var_466_4
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531114", "story_v_out_122531.awb") ~= 0 then
					local var_466_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531114", "story_v_out_122531.awb") / 1000

					if var_466_8 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_8 + var_466_0
					end

					if var_466_3.prefab_name ~= "" and arg_463_1.actors_[var_466_3.prefab_name] ~= nil then
						local var_466_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_3.prefab_name].transform, "story_v_out_122531", "122531114", "story_v_out_122531.awb")

						arg_463_1:RecordAudio("122531114", var_466_9)
						arg_463_1:RecordAudio("122531114", var_466_9)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_122531", "122531114", "story_v_out_122531.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_122531", "122531114", "story_v_out_122531.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_10 = math.max(var_466_1, arg_463_1.talkMaxDuration)

			if var_466_0 <= arg_463_1.time_ and arg_463_1.time_ < var_466_0 + var_466_10 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_0) / var_466_10

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_0 + var_466_10 and arg_463_1.time_ < var_466_0 + var_466_10 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play122531115 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 122531115
		arg_467_1.duration_ = 9

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play122531116(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = "ST31"

			if arg_467_1.bgs_[var_470_0] == nil then
				local var_470_1 = Object.Instantiate(arg_467_1.paintGo_)

				var_470_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_470_0)
				var_470_1.name = var_470_0
				var_470_1.transform.parent = arg_467_1.stage_.transform
				var_470_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_467_1.bgs_[var_470_0] = var_470_1
			end

			local var_470_2 = 2

			if var_470_2 < arg_467_1.time_ and arg_467_1.time_ <= var_470_2 + arg_470_0 then
				local var_470_3 = manager.ui.mainCamera.transform.localPosition
				local var_470_4 = Vector3.New(0, 0, 10) + Vector3.New(var_470_3.x, var_470_3.y, 0)
				local var_470_5 = arg_467_1.bgs_.ST31

				var_470_5.transform.localPosition = var_470_4
				var_470_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_470_6 = var_470_5:GetComponent("SpriteRenderer")

				if var_470_6 and var_470_6.sprite then
					local var_470_7 = (var_470_5.transform.localPosition - var_470_3).z
					local var_470_8 = manager.ui.mainCameraCom_
					local var_470_9 = 2 * var_470_7 * Mathf.Tan(var_470_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_470_10 = var_470_9 * var_470_8.aspect
					local var_470_11 = var_470_6.sprite.bounds.size.x
					local var_470_12 = var_470_6.sprite.bounds.size.y
					local var_470_13 = var_470_10 / var_470_11
					local var_470_14 = var_470_9 / var_470_12
					local var_470_15 = var_470_14 < var_470_13 and var_470_13 or var_470_14

					var_470_5.transform.localScale = Vector3.New(var_470_15, var_470_15, 0)
				end

				for iter_470_0, iter_470_1 in pairs(arg_467_1.bgs_) do
					if iter_470_0 ~= "ST31" then
						iter_470_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_470_16 = 0

			if var_470_16 < arg_467_1.time_ and arg_467_1.time_ <= var_470_16 + arg_470_0 then
				arg_467_1.mask_.enabled = true
				arg_467_1.mask_.raycastTarget = true

				arg_467_1:SetGaussion(false)
			end

			local var_470_17 = 2

			if var_470_16 <= arg_467_1.time_ and arg_467_1.time_ < var_470_16 + var_470_17 then
				local var_470_18 = (arg_467_1.time_ - var_470_16) / var_470_17
				local var_470_19 = Color.New(0, 0, 0)

				var_470_19.a = Mathf.Lerp(0, 1, var_470_18)
				arg_467_1.mask_.color = var_470_19
			end

			if arg_467_1.time_ >= var_470_16 + var_470_17 and arg_467_1.time_ < var_470_16 + var_470_17 + arg_470_0 then
				local var_470_20 = Color.New(0, 0, 0)

				var_470_20.a = 1
				arg_467_1.mask_.color = var_470_20
			end

			local var_470_21 = 2

			if var_470_21 < arg_467_1.time_ and arg_467_1.time_ <= var_470_21 + arg_470_0 then
				arg_467_1.mask_.enabled = true
				arg_467_1.mask_.raycastTarget = true

				arg_467_1:SetGaussion(false)
			end

			local var_470_22 = 2

			if var_470_21 <= arg_467_1.time_ and arg_467_1.time_ < var_470_21 + var_470_22 then
				local var_470_23 = (arg_467_1.time_ - var_470_21) / var_470_22
				local var_470_24 = Color.New(0, 0, 0)

				var_470_24.a = Mathf.Lerp(1, 0, var_470_23)
				arg_467_1.mask_.color = var_470_24
			end

			if arg_467_1.time_ >= var_470_21 + var_470_22 and arg_467_1.time_ < var_470_21 + var_470_22 + arg_470_0 then
				local var_470_25 = Color.New(0, 0, 0)
				local var_470_26 = 0

				arg_467_1.mask_.enabled = false
				var_470_25.a = var_470_26
				arg_467_1.mask_.color = var_470_25
			end

			local var_470_27 = arg_467_1.actors_["1071ui_story"].transform
			local var_470_28 = 1.96599999815226

			if var_470_28 < arg_467_1.time_ and arg_467_1.time_ <= var_470_28 + arg_470_0 then
				arg_467_1.var_.moveOldPos1071ui_story = var_470_27.localPosition
			end

			local var_470_29 = 0.001

			if var_470_28 <= arg_467_1.time_ and arg_467_1.time_ < var_470_28 + var_470_29 then
				local var_470_30 = (arg_467_1.time_ - var_470_28) / var_470_29
				local var_470_31 = Vector3.New(0, 100, 0)

				var_470_27.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos1071ui_story, var_470_31, var_470_30)

				local var_470_32 = manager.ui.mainCamera.transform.position - var_470_27.position

				var_470_27.forward = Vector3.New(var_470_32.x, var_470_32.y, var_470_32.z)

				local var_470_33 = var_470_27.localEulerAngles

				var_470_33.z = 0
				var_470_33.x = 0
				var_470_27.localEulerAngles = var_470_33
			end

			if arg_467_1.time_ >= var_470_28 + var_470_29 and arg_467_1.time_ < var_470_28 + var_470_29 + arg_470_0 then
				var_470_27.localPosition = Vector3.New(0, 100, 0)

				local var_470_34 = manager.ui.mainCamera.transform.position - var_470_27.position

				var_470_27.forward = Vector3.New(var_470_34.x, var_470_34.y, var_470_34.z)

				local var_470_35 = var_470_27.localEulerAngles

				var_470_35.z = 0
				var_470_35.x = 0
				var_470_27.localEulerAngles = var_470_35
			end

			local var_470_36 = arg_467_1.actors_["1071ui_story"]
			local var_470_37 = 1.96599999815226

			if var_470_37 < arg_467_1.time_ and arg_467_1.time_ <= var_470_37 + arg_470_0 and not isNil(var_470_36) and arg_467_1.var_.characterEffect1071ui_story == nil then
				arg_467_1.var_.characterEffect1071ui_story = var_470_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_38 = 0.034000001847744

			if var_470_37 <= arg_467_1.time_ and arg_467_1.time_ < var_470_37 + var_470_38 and not isNil(var_470_36) then
				local var_470_39 = (arg_467_1.time_ - var_470_37) / var_470_38

				if arg_467_1.var_.characterEffect1071ui_story and not isNil(var_470_36) then
					local var_470_40 = Mathf.Lerp(0, 0.5, var_470_39)

					arg_467_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_467_1.var_.characterEffect1071ui_story.fillRatio = var_470_40
				end
			end

			if arg_467_1.time_ >= var_470_37 + var_470_38 and arg_467_1.time_ < var_470_37 + var_470_38 + arg_470_0 and not isNil(var_470_36) and arg_467_1.var_.characterEffect1071ui_story then
				local var_470_41 = 0.5

				arg_467_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_467_1.var_.characterEffect1071ui_story.fillRatio = var_470_41
			end

			if arg_467_1.frameCnt_ <= 1 then
				arg_467_1.dialog_:SetActive(false)
			end

			local var_470_42 = 3.999999999999
			local var_470_43 = 1.3

			if var_470_42 < arg_467_1.time_ and arg_467_1.time_ <= var_470_42 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0

				arg_467_1.dialog_:SetActive(true)

				arg_467_1.dialogCg_.alpha = 0

				local var_470_44 = LeanTween.value(arg_467_1.dialog_, 0, 1, 0.3)

				var_470_44:setOnUpdate(LuaHelper.FloatAction(function(arg_471_0)
					arg_467_1.dialogCg_.alpha = arg_471_0
				end))
				var_470_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_467_1.dialog_)
					var_470_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_467_1.duration_ = arg_467_1.duration_ + 0.3

				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_45 = arg_467_1:GetWordFromCfg(122531115)
				local var_470_46 = arg_467_1:FormatText(var_470_45.content)

				arg_467_1.text_.text = var_470_46

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_47 = 52
				local var_470_48 = utf8.len(var_470_46)
				local var_470_49 = var_470_47 <= 0 and var_470_43 or var_470_43 * (var_470_48 / var_470_47)

				if var_470_49 > 0 and var_470_43 < var_470_49 then
					arg_467_1.talkMaxDuration = var_470_49
					var_470_42 = var_470_42 + 0.3

					if var_470_49 + var_470_42 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_49 + var_470_42
					end
				end

				arg_467_1.text_.text = var_470_46
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_50 = var_470_42 + 0.3
			local var_470_51 = math.max(var_470_43, arg_467_1.talkMaxDuration)

			if var_470_50 <= arg_467_1.time_ and arg_467_1.time_ < var_470_50 + var_470_51 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_50) / var_470_51

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_50 + var_470_51 and arg_467_1.time_ < var_470_50 + var_470_51 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_467_1:InitPlayNodeList()
	end,
	Play122531116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 122531116
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play122531117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 1.375

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_2 = arg_473_1:GetWordFromCfg(122531116)
				local var_476_3 = arg_473_1:FormatText(var_476_2.content)

				arg_473_1.text_.text = var_476_3

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_4 = 55
				local var_476_5 = utf8.len(var_476_3)
				local var_476_6 = var_476_4 <= 0 and var_476_1 or var_476_1 * (var_476_5 / var_476_4)

				if var_476_6 > 0 and var_476_1 < var_476_6 then
					arg_473_1.talkMaxDuration = var_476_6

					if var_476_6 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_6 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_3
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_7 and arg_473_1.time_ < var_476_0 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play122531117 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 122531117
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play122531118(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0
			local var_480_1 = 2.025

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_2 = arg_477_1:GetWordFromCfg(122531117)
				local var_480_3 = arg_477_1:FormatText(var_480_2.content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_4 = 81
				local var_480_5 = utf8.len(var_480_3)
				local var_480_6 = var_480_4 <= 0 and var_480_1 or var_480_1 * (var_480_5 / var_480_4)

				if var_480_6 > 0 and var_480_1 < var_480_6 then
					arg_477_1.talkMaxDuration = var_480_6

					if var_480_6 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_6 + var_480_0
					end
				end

				arg_477_1.text_.text = var_480_3
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_7 = math.max(var_480_1, arg_477_1.talkMaxDuration)

			if var_480_0 <= arg_477_1.time_ and arg_477_1.time_ < var_480_0 + var_480_7 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_0) / var_480_7

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_0 + var_480_7 and arg_477_1.time_ < var_480_0 + var_480_7 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play122531118 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 122531118
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play122531119(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0
			local var_484_1 = 0.225

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_2 = arg_481_1:FormatText(StoryNameCfg[7].name)

				arg_481_1.leftNameTxt_.text = var_484_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_3 = arg_481_1:GetWordFromCfg(122531118)
				local var_484_4 = arg_481_1:FormatText(var_484_3.content)

				arg_481_1.text_.text = var_484_4

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 9
				local var_484_6 = utf8.len(var_484_4)
				local var_484_7 = var_484_5 <= 0 and var_484_1 or var_484_1 * (var_484_6 / var_484_5)

				if var_484_7 > 0 and var_484_1 < var_484_7 then
					arg_481_1.talkMaxDuration = var_484_7

					if var_484_7 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_4
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_8 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_8 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_8

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_8 and arg_481_1.time_ < var_484_0 + var_484_8 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play122531119 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 122531119
		arg_485_1.duration_ = 2.43

		local var_485_0 = {
			ja = 1.999999999999,
			ko = 2.433,
			zh = 2.433
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play122531120(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["1029ui_story"].transform
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1.var_.moveOldPos1029ui_story = var_488_0.localPosition
			end

			local var_488_2 = 0.001

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2
				local var_488_4 = Vector3.New(0, -1.09, -6.2)

				var_488_0.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1029ui_story, var_488_4, var_488_3)

				local var_488_5 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_5.x, var_488_5.y, var_488_5.z)

				local var_488_6 = var_488_0.localEulerAngles

				var_488_6.z = 0
				var_488_6.x = 0
				var_488_0.localEulerAngles = var_488_6
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 then
				var_488_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_488_7 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_7.x, var_488_7.y, var_488_7.z)

				local var_488_8 = var_488_0.localEulerAngles

				var_488_8.z = 0
				var_488_8.x = 0
				var_488_0.localEulerAngles = var_488_8
			end

			local var_488_9 = arg_485_1.actors_["1029ui_story"]
			local var_488_10 = 0

			if var_488_10 < arg_485_1.time_ and arg_485_1.time_ <= var_488_10 + arg_488_0 and not isNil(var_488_9) and arg_485_1.var_.characterEffect1029ui_story == nil then
				arg_485_1.var_.characterEffect1029ui_story = var_488_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_11 = 0.200000002980232

			if var_488_10 <= arg_485_1.time_ and arg_485_1.time_ < var_488_10 + var_488_11 and not isNil(var_488_9) then
				local var_488_12 = (arg_485_1.time_ - var_488_10) / var_488_11

				if arg_485_1.var_.characterEffect1029ui_story and not isNil(var_488_9) then
					arg_485_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= var_488_10 + var_488_11 and arg_485_1.time_ < var_488_10 + var_488_11 + arg_488_0 and not isNil(var_488_9) and arg_485_1.var_.characterEffect1029ui_story then
				arg_485_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_488_13 = 0

			if var_488_13 < arg_485_1.time_ and arg_485_1.time_ <= var_488_13 + arg_488_0 then
				arg_485_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_488_14 = 0

			if var_488_14 < arg_485_1.time_ and arg_485_1.time_ <= var_488_14 + arg_488_0 then
				arg_485_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_488_15 = arg_485_1.actors_["1029ui_story"]
			local var_488_16 = 0

			if var_488_16 < arg_485_1.time_ and arg_485_1.time_ <= var_488_16 + arg_488_0 then
				if arg_485_1.var_.characterEffect1029ui_story == nil then
					arg_485_1.var_.characterEffect1029ui_story = var_488_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_488_17 = arg_485_1.var_.characterEffect1029ui_story

				var_488_17.imageEffect:turnOff()

				var_488_17.interferenceEffect.enabled = false
				var_488_17.interferenceEffect.noise = 0.001
				var_488_17.interferenceEffect.simTimeScale = 1
				var_488_17.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_488_18 = arg_485_1.actors_["1029ui_story"]
			local var_488_19 = 0
			local var_488_20 = 0.2

			if var_488_19 < arg_485_1.time_ and arg_485_1.time_ <= var_488_19 + arg_488_0 then
				if arg_485_1.var_.characterEffect1029ui_story == nil then
					arg_485_1.var_.characterEffect1029ui_story = var_488_18:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_485_1.var_.characterEffect1029ui_story.imageEffect:turnOff()
			end

			local var_488_21 = 0
			local var_488_22 = 0.075

			if var_488_21 < arg_485_1.time_ and arg_485_1.time_ <= var_488_21 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_23 = arg_485_1:FormatText(StoryNameCfg[319].name)

				arg_485_1.leftNameTxt_.text = var_488_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_24 = arg_485_1:GetWordFromCfg(122531119)
				local var_488_25 = arg_485_1:FormatText(var_488_24.content)

				arg_485_1.text_.text = var_488_25

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_26 = 3
				local var_488_27 = utf8.len(var_488_25)
				local var_488_28 = var_488_26 <= 0 and var_488_22 or var_488_22 * (var_488_27 / var_488_26)

				if var_488_28 > 0 and var_488_22 < var_488_28 then
					arg_485_1.talkMaxDuration = var_488_28

					if var_488_28 + var_488_21 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_28 + var_488_21
					end
				end

				arg_485_1.text_.text = var_488_25
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531119", "story_v_out_122531.awb") ~= 0 then
					local var_488_29 = manager.audio:GetVoiceLength("story_v_out_122531", "122531119", "story_v_out_122531.awb") / 1000

					if var_488_29 + var_488_21 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_29 + var_488_21
					end

					if var_488_24.prefab_name ~= "" and arg_485_1.actors_[var_488_24.prefab_name] ~= nil then
						local var_488_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_24.prefab_name].transform, "story_v_out_122531", "122531119", "story_v_out_122531.awb")

						arg_485_1:RecordAudio("122531119", var_488_30)
						arg_485_1:RecordAudio("122531119", var_488_30)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_122531", "122531119", "story_v_out_122531.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_122531", "122531119", "story_v_out_122531.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_31 = math.max(var_488_22, arg_485_1.talkMaxDuration)

			if var_488_21 <= arg_485_1.time_ and arg_485_1.time_ < var_488_21 + var_488_31 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_21) / var_488_31

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_21 + var_488_31 and arg_485_1.time_ < var_488_21 + var_488_31 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_485_1:InitPlayNodeList()
	end,
	Play122531120 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 122531120
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play122531121(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = arg_489_1.actors_["1029ui_story"]
			local var_492_1 = 0

			if var_492_1 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.characterEffect1029ui_story == nil then
				arg_489_1.var_.characterEffect1029ui_story = var_492_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_2 = 0.200000002980232

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_2 and not isNil(var_492_0) then
				local var_492_3 = (arg_489_1.time_ - var_492_1) / var_492_2

				if arg_489_1.var_.characterEffect1029ui_story and not isNil(var_492_0) then
					local var_492_4 = Mathf.Lerp(0, 0.5, var_492_3)

					arg_489_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1029ui_story.fillRatio = var_492_4
				end
			end

			if arg_489_1.time_ >= var_492_1 + var_492_2 and arg_489_1.time_ < var_492_1 + var_492_2 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.characterEffect1029ui_story then
				local var_492_5 = 0.5

				arg_489_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1029ui_story.fillRatio = var_492_5
			end

			local var_492_6 = 0
			local var_492_7 = 0.45

			if var_492_6 < arg_489_1.time_ and arg_489_1.time_ <= var_492_6 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_8 = arg_489_1:FormatText(StoryNameCfg[7].name)

				arg_489_1.leftNameTxt_.text = var_492_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_9 = arg_489_1:GetWordFromCfg(122531120)
				local var_492_10 = arg_489_1:FormatText(var_492_9.content)

				arg_489_1.text_.text = var_492_10

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_11 = 18
				local var_492_12 = utf8.len(var_492_10)
				local var_492_13 = var_492_11 <= 0 and var_492_7 or var_492_7 * (var_492_12 / var_492_11)

				if var_492_13 > 0 and var_492_7 < var_492_13 then
					arg_489_1.talkMaxDuration = var_492_13

					if var_492_13 + var_492_6 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_13 + var_492_6
					end
				end

				arg_489_1.text_.text = var_492_10
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_14 = math.max(var_492_7, arg_489_1.talkMaxDuration)

			if var_492_6 <= arg_489_1.time_ and arg_489_1.time_ < var_492_6 + var_492_14 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_6) / var_492_14

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_6 + var_492_14 and arg_489_1.time_ < var_492_6 + var_492_14 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play122531121 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 122531121
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play122531122(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0
			local var_496_1 = 1.275

			if var_496_0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_2 = arg_493_1:FormatText(StoryNameCfg[7].name)

				arg_493_1.leftNameTxt_.text = var_496_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_3 = arg_493_1:GetWordFromCfg(122531121)
				local var_496_4 = arg_493_1:FormatText(var_496_3.content)

				arg_493_1.text_.text = var_496_4

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_5 = 51
				local var_496_6 = utf8.len(var_496_4)
				local var_496_7 = var_496_5 <= 0 and var_496_1 or var_496_1 * (var_496_6 / var_496_5)

				if var_496_7 > 0 and var_496_1 < var_496_7 then
					arg_493_1.talkMaxDuration = var_496_7

					if var_496_7 + var_496_0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_7 + var_496_0
					end
				end

				arg_493_1.text_.text = var_496_4
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_8 = math.max(var_496_1, arg_493_1.talkMaxDuration)

			if var_496_0 <= arg_493_1.time_ and arg_493_1.time_ < var_496_0 + var_496_8 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_0) / var_496_8

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_0 + var_496_8 and arg_493_1.time_ < var_496_0 + var_496_8 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play122531122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 122531122
		arg_497_1.duration_ = 7.23

		local var_497_0 = {
			ja = 7.233,
			ko = 6.333,
			zh = 6.333
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play122531123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = arg_497_1.actors_["1029ui_story"]
			local var_500_1 = 0

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1029ui_story == nil then
				arg_497_1.var_.characterEffect1029ui_story = var_500_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_2 = 0.200000002980232

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_2 and not isNil(var_500_0) then
				local var_500_3 = (arg_497_1.time_ - var_500_1) / var_500_2

				if arg_497_1.var_.characterEffect1029ui_story and not isNil(var_500_0) then
					arg_497_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= var_500_1 + var_500_2 and arg_497_1.time_ < var_500_1 + var_500_2 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1029ui_story then
				arg_497_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_500_4 = 0

			if var_500_4 < arg_497_1.time_ and arg_497_1.time_ <= var_500_4 + arg_500_0 then
				arg_497_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_500_5 = 0

			if var_500_5 < arg_497_1.time_ and arg_497_1.time_ <= var_500_5 + arg_500_0 then
				arg_497_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_500_6 = 0
			local var_500_7 = 0.475

			if var_500_6 < arg_497_1.time_ and arg_497_1.time_ <= var_500_6 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_8 = arg_497_1:FormatText(StoryNameCfg[319].name)

				arg_497_1.leftNameTxt_.text = var_500_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_9 = arg_497_1:GetWordFromCfg(122531122)
				local var_500_10 = arg_497_1:FormatText(var_500_9.content)

				arg_497_1.text_.text = var_500_10

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_11 = 19
				local var_500_12 = utf8.len(var_500_10)
				local var_500_13 = var_500_11 <= 0 and var_500_7 or var_500_7 * (var_500_12 / var_500_11)

				if var_500_13 > 0 and var_500_7 < var_500_13 then
					arg_497_1.talkMaxDuration = var_500_13

					if var_500_13 + var_500_6 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_13 + var_500_6
					end
				end

				arg_497_1.text_.text = var_500_10
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531122", "story_v_out_122531.awb") ~= 0 then
					local var_500_14 = manager.audio:GetVoiceLength("story_v_out_122531", "122531122", "story_v_out_122531.awb") / 1000

					if var_500_14 + var_500_6 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_14 + var_500_6
					end

					if var_500_9.prefab_name ~= "" and arg_497_1.actors_[var_500_9.prefab_name] ~= nil then
						local var_500_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_9.prefab_name].transform, "story_v_out_122531", "122531122", "story_v_out_122531.awb")

						arg_497_1:RecordAudio("122531122", var_500_15)
						arg_497_1:RecordAudio("122531122", var_500_15)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_122531", "122531122", "story_v_out_122531.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_122531", "122531122", "story_v_out_122531.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_16 = math.max(var_500_7, arg_497_1.talkMaxDuration)

			if var_500_6 <= arg_497_1.time_ and arg_497_1.time_ < var_500_6 + var_500_16 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_6) / var_500_16

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_6 + var_500_16 and arg_497_1.time_ < var_500_6 + var_500_16 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play122531123 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 122531123
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play122531124(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = arg_501_1.actors_["1029ui_story"]
			local var_504_1 = 0

			if var_504_1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.characterEffect1029ui_story == nil then
				arg_501_1.var_.characterEffect1029ui_story = var_504_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_2 = 0.200000002980232

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_2 and not isNil(var_504_0) then
				local var_504_3 = (arg_501_1.time_ - var_504_1) / var_504_2

				if arg_501_1.var_.characterEffect1029ui_story and not isNil(var_504_0) then
					local var_504_4 = Mathf.Lerp(0, 0.5, var_504_3)

					arg_501_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_501_1.var_.characterEffect1029ui_story.fillRatio = var_504_4
				end
			end

			if arg_501_1.time_ >= var_504_1 + var_504_2 and arg_501_1.time_ < var_504_1 + var_504_2 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.characterEffect1029ui_story then
				local var_504_5 = 0.5

				arg_501_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_501_1.var_.characterEffect1029ui_story.fillRatio = var_504_5
			end

			local var_504_6 = 0
			local var_504_7 = 0.375

			if var_504_6 < arg_501_1.time_ and arg_501_1.time_ <= var_504_6 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_8 = arg_501_1:FormatText(StoryNameCfg[7].name)

				arg_501_1.leftNameTxt_.text = var_504_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_9 = arg_501_1:GetWordFromCfg(122531123)
				local var_504_10 = arg_501_1:FormatText(var_504_9.content)

				arg_501_1.text_.text = var_504_10

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_11 = 15
				local var_504_12 = utf8.len(var_504_10)
				local var_504_13 = var_504_11 <= 0 and var_504_7 or var_504_7 * (var_504_12 / var_504_11)

				if var_504_13 > 0 and var_504_7 < var_504_13 then
					arg_501_1.talkMaxDuration = var_504_13

					if var_504_13 + var_504_6 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_13 + var_504_6
					end
				end

				arg_501_1.text_.text = var_504_10
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_14 = math.max(var_504_7, arg_501_1.talkMaxDuration)

			if var_504_6 <= arg_501_1.time_ and arg_501_1.time_ < var_504_6 + var_504_14 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_6) / var_504_14

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_6 + var_504_14 and arg_501_1.time_ < var_504_6 + var_504_14 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play122531124 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 122531124
		arg_505_1.duration_ = 15.03

		local var_505_0 = {
			ja = 15.033,
			ko = 5.466,
			zh = 5.466
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play122531125(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = arg_505_1.actors_["1029ui_story"]
			local var_508_1 = 0

			if var_508_1 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1029ui_story == nil then
				arg_505_1.var_.characterEffect1029ui_story = var_508_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_2 = 0.200000002980232

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_2 and not isNil(var_508_0) then
				local var_508_3 = (arg_505_1.time_ - var_508_1) / var_508_2

				if arg_505_1.var_.characterEffect1029ui_story and not isNil(var_508_0) then
					arg_505_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= var_508_1 + var_508_2 and arg_505_1.time_ < var_508_1 + var_508_2 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1029ui_story then
				arg_505_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_508_4 = 0
			local var_508_5 = 0.525

			if var_508_4 < arg_505_1.time_ and arg_505_1.time_ <= var_508_4 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_6 = arg_505_1:FormatText(StoryNameCfg[319].name)

				arg_505_1.leftNameTxt_.text = var_508_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_7 = arg_505_1:GetWordFromCfg(122531124)
				local var_508_8 = arg_505_1:FormatText(var_508_7.content)

				arg_505_1.text_.text = var_508_8

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_9 = 21
				local var_508_10 = utf8.len(var_508_8)
				local var_508_11 = var_508_9 <= 0 and var_508_5 or var_508_5 * (var_508_10 / var_508_9)

				if var_508_11 > 0 and var_508_5 < var_508_11 then
					arg_505_1.talkMaxDuration = var_508_11

					if var_508_11 + var_508_4 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_11 + var_508_4
					end
				end

				arg_505_1.text_.text = var_508_8
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531124", "story_v_out_122531.awb") ~= 0 then
					local var_508_12 = manager.audio:GetVoiceLength("story_v_out_122531", "122531124", "story_v_out_122531.awb") / 1000

					if var_508_12 + var_508_4 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_12 + var_508_4
					end

					if var_508_7.prefab_name ~= "" and arg_505_1.actors_[var_508_7.prefab_name] ~= nil then
						local var_508_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_7.prefab_name].transform, "story_v_out_122531", "122531124", "story_v_out_122531.awb")

						arg_505_1:RecordAudio("122531124", var_508_13)
						arg_505_1:RecordAudio("122531124", var_508_13)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_out_122531", "122531124", "story_v_out_122531.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_out_122531", "122531124", "story_v_out_122531.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_14 = math.max(var_508_5, arg_505_1.talkMaxDuration)

			if var_508_4 <= arg_505_1.time_ and arg_505_1.time_ < var_508_4 + var_508_14 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_4) / var_508_14

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_4 + var_508_14 and arg_505_1.time_ < var_508_4 + var_508_14 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play122531125 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 122531125
		arg_509_1.duration_ = 17.63

		local var_509_0 = {
			ja = 17.633,
			ko = 11.166,
			zh = 11.166
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play122531126(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0
			local var_512_1 = 1.05

			if var_512_0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_2 = arg_509_1:FormatText(StoryNameCfg[319].name)

				arg_509_1.leftNameTxt_.text = var_512_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_3 = arg_509_1:GetWordFromCfg(122531125)
				local var_512_4 = arg_509_1:FormatText(var_512_3.content)

				arg_509_1.text_.text = var_512_4

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 42
				local var_512_6 = utf8.len(var_512_4)
				local var_512_7 = var_512_5 <= 0 and var_512_1 or var_512_1 * (var_512_6 / var_512_5)

				if var_512_7 > 0 and var_512_1 < var_512_7 then
					arg_509_1.talkMaxDuration = var_512_7

					if var_512_7 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_7 + var_512_0
					end
				end

				arg_509_1.text_.text = var_512_4
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531125", "story_v_out_122531.awb") ~= 0 then
					local var_512_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531125", "story_v_out_122531.awb") / 1000

					if var_512_8 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_8 + var_512_0
					end

					if var_512_3.prefab_name ~= "" and arg_509_1.actors_[var_512_3.prefab_name] ~= nil then
						local var_512_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_3.prefab_name].transform, "story_v_out_122531", "122531125", "story_v_out_122531.awb")

						arg_509_1:RecordAudio("122531125", var_512_9)
						arg_509_1:RecordAudio("122531125", var_512_9)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_122531", "122531125", "story_v_out_122531.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_122531", "122531125", "story_v_out_122531.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_10 = math.max(var_512_1, arg_509_1.talkMaxDuration)

			if var_512_0 <= arg_509_1.time_ and arg_509_1.time_ < var_512_0 + var_512_10 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_0) / var_512_10

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_0 + var_512_10 and arg_509_1.time_ < var_512_0 + var_512_10 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play122531126 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 122531126
		arg_513_1.duration_ = 15

		local var_513_0 = {
			ja = 15,
			ko = 8.7,
			zh = 8.7
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play122531127(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action442")
			end

			local var_516_1 = 0

			if var_516_1 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 then
				arg_513_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_516_2 = 0
			local var_516_3 = 1.125

			if var_516_2 < arg_513_1.time_ and arg_513_1.time_ <= var_516_2 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_4 = arg_513_1:FormatText(StoryNameCfg[319].name)

				arg_513_1.leftNameTxt_.text = var_516_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_5 = arg_513_1:GetWordFromCfg(122531126)
				local var_516_6 = arg_513_1:FormatText(var_516_5.content)

				arg_513_1.text_.text = var_516_6

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_7 = 45
				local var_516_8 = utf8.len(var_516_6)
				local var_516_9 = var_516_7 <= 0 and var_516_3 or var_516_3 * (var_516_8 / var_516_7)

				if var_516_9 > 0 and var_516_3 < var_516_9 then
					arg_513_1.talkMaxDuration = var_516_9

					if var_516_9 + var_516_2 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_9 + var_516_2
					end
				end

				arg_513_1.text_.text = var_516_6
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531126", "story_v_out_122531.awb") ~= 0 then
					local var_516_10 = manager.audio:GetVoiceLength("story_v_out_122531", "122531126", "story_v_out_122531.awb") / 1000

					if var_516_10 + var_516_2 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_10 + var_516_2
					end

					if var_516_5.prefab_name ~= "" and arg_513_1.actors_[var_516_5.prefab_name] ~= nil then
						local var_516_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_5.prefab_name].transform, "story_v_out_122531", "122531126", "story_v_out_122531.awb")

						arg_513_1:RecordAudio("122531126", var_516_11)
						arg_513_1:RecordAudio("122531126", var_516_11)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_out_122531", "122531126", "story_v_out_122531.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_out_122531", "122531126", "story_v_out_122531.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_12 = math.max(var_516_3, arg_513_1.talkMaxDuration)

			if var_516_2 <= arg_513_1.time_ and arg_513_1.time_ < var_516_2 + var_516_12 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_2) / var_516_12

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_2 + var_516_12 and arg_513_1.time_ < var_516_2 + var_516_12 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play122531127 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 122531127
		arg_517_1.duration_ = 7.9

		local var_517_0 = {
			ja = 7.9,
			ko = 4.466,
			zh = 4.466
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play122531128(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action424")
			end

			local var_520_1 = 0

			if var_520_1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 then
				arg_517_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_520_2 = 0
			local var_520_3 = 0.375

			if var_520_2 < arg_517_1.time_ and arg_517_1.time_ <= var_520_2 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_4 = arg_517_1:FormatText(StoryNameCfg[319].name)

				arg_517_1.leftNameTxt_.text = var_520_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_5 = arg_517_1:GetWordFromCfg(122531127)
				local var_520_6 = arg_517_1:FormatText(var_520_5.content)

				arg_517_1.text_.text = var_520_6

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_7 = 15
				local var_520_8 = utf8.len(var_520_6)
				local var_520_9 = var_520_7 <= 0 and var_520_3 or var_520_3 * (var_520_8 / var_520_7)

				if var_520_9 > 0 and var_520_3 < var_520_9 then
					arg_517_1.talkMaxDuration = var_520_9

					if var_520_9 + var_520_2 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_9 + var_520_2
					end
				end

				arg_517_1.text_.text = var_520_6
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531127", "story_v_out_122531.awb") ~= 0 then
					local var_520_10 = manager.audio:GetVoiceLength("story_v_out_122531", "122531127", "story_v_out_122531.awb") / 1000

					if var_520_10 + var_520_2 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_10 + var_520_2
					end

					if var_520_5.prefab_name ~= "" and arg_517_1.actors_[var_520_5.prefab_name] ~= nil then
						local var_520_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_5.prefab_name].transform, "story_v_out_122531", "122531127", "story_v_out_122531.awb")

						arg_517_1:RecordAudio("122531127", var_520_11)
						arg_517_1:RecordAudio("122531127", var_520_11)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_122531", "122531127", "story_v_out_122531.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_122531", "122531127", "story_v_out_122531.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_12 = math.max(var_520_3, arg_517_1.talkMaxDuration)

			if var_520_2 <= arg_517_1.time_ and arg_517_1.time_ < var_520_2 + var_520_12 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_2) / var_520_12

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_2 + var_520_12 and arg_517_1.time_ < var_520_2 + var_520_12 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play122531128 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 122531128
		arg_521_1.duration_ = 5.77

		local var_521_0 = {
			ja = 5.766,
			ko = 4.233,
			zh = 4.233
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play122531129(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0
			local var_524_1 = 0.475

			if var_524_0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_2 = arg_521_1:FormatText(StoryNameCfg[319].name)

				arg_521_1.leftNameTxt_.text = var_524_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_3 = arg_521_1:GetWordFromCfg(122531128)
				local var_524_4 = arg_521_1:FormatText(var_524_3.content)

				arg_521_1.text_.text = var_524_4

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_5 = 19
				local var_524_6 = utf8.len(var_524_4)
				local var_524_7 = var_524_5 <= 0 and var_524_1 or var_524_1 * (var_524_6 / var_524_5)

				if var_524_7 > 0 and var_524_1 < var_524_7 then
					arg_521_1.talkMaxDuration = var_524_7

					if var_524_7 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_7 + var_524_0
					end
				end

				arg_521_1.text_.text = var_524_4
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531128", "story_v_out_122531.awb") ~= 0 then
					local var_524_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531128", "story_v_out_122531.awb") / 1000

					if var_524_8 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_8 + var_524_0
					end

					if var_524_3.prefab_name ~= "" and arg_521_1.actors_[var_524_3.prefab_name] ~= nil then
						local var_524_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_3.prefab_name].transform, "story_v_out_122531", "122531128", "story_v_out_122531.awb")

						arg_521_1:RecordAudio("122531128", var_524_9)
						arg_521_1:RecordAudio("122531128", var_524_9)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_122531", "122531128", "story_v_out_122531.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_122531", "122531128", "story_v_out_122531.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_10 = math.max(var_524_1, arg_521_1.talkMaxDuration)

			if var_524_0 <= arg_521_1.time_ and arg_521_1.time_ < var_524_0 + var_524_10 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_0) / var_524_10

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_0 + var_524_10 and arg_521_1.time_ < var_524_0 + var_524_10 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play122531129 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 122531129
		arg_525_1.duration_ = 15.4

		local var_525_0 = {
			ja = 15.4,
			ko = 7.4,
			zh = 7.4
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play122531130(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0
			local var_528_1 = 0.95

			if var_528_0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_2 = arg_525_1:FormatText(StoryNameCfg[319].name)

				arg_525_1.leftNameTxt_.text = var_528_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_3 = arg_525_1:GetWordFromCfg(122531129)
				local var_528_4 = arg_525_1:FormatText(var_528_3.content)

				arg_525_1.text_.text = var_528_4

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_5 = 38
				local var_528_6 = utf8.len(var_528_4)
				local var_528_7 = var_528_5 <= 0 and var_528_1 or var_528_1 * (var_528_6 / var_528_5)

				if var_528_7 > 0 and var_528_1 < var_528_7 then
					arg_525_1.talkMaxDuration = var_528_7

					if var_528_7 + var_528_0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_7 + var_528_0
					end
				end

				arg_525_1.text_.text = var_528_4
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531129", "story_v_out_122531.awb") ~= 0 then
					local var_528_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531129", "story_v_out_122531.awb") / 1000

					if var_528_8 + var_528_0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_8 + var_528_0
					end

					if var_528_3.prefab_name ~= "" and arg_525_1.actors_[var_528_3.prefab_name] ~= nil then
						local var_528_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_3.prefab_name].transform, "story_v_out_122531", "122531129", "story_v_out_122531.awb")

						arg_525_1:RecordAudio("122531129", var_528_9)
						arg_525_1:RecordAudio("122531129", var_528_9)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_122531", "122531129", "story_v_out_122531.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_122531", "122531129", "story_v_out_122531.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_10 = math.max(var_528_1, arg_525_1.talkMaxDuration)

			if var_528_0 <= arg_525_1.time_ and arg_525_1.time_ < var_528_0 + var_528_10 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_0) / var_528_10

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_0 + var_528_10 and arg_525_1.time_ < var_528_0 + var_528_10 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play122531130 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 122531130
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play122531131(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = arg_529_1.actors_["1029ui_story"]
			local var_532_1 = 0

			if var_532_1 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.characterEffect1029ui_story == nil then
				arg_529_1.var_.characterEffect1029ui_story = var_532_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_2 = 0.200000002980232

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_2 and not isNil(var_532_0) then
				local var_532_3 = (arg_529_1.time_ - var_532_1) / var_532_2

				if arg_529_1.var_.characterEffect1029ui_story and not isNil(var_532_0) then
					local var_532_4 = Mathf.Lerp(0, 0.5, var_532_3)

					arg_529_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_529_1.var_.characterEffect1029ui_story.fillRatio = var_532_4
				end
			end

			if arg_529_1.time_ >= var_532_1 + var_532_2 and arg_529_1.time_ < var_532_1 + var_532_2 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.characterEffect1029ui_story then
				local var_532_5 = 0.5

				arg_529_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_529_1.var_.characterEffect1029ui_story.fillRatio = var_532_5
			end

			local var_532_6 = 0
			local var_532_7 = 0.375

			if var_532_6 < arg_529_1.time_ and arg_529_1.time_ <= var_532_6 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				local var_532_8 = arg_529_1:FormatText(StoryNameCfg[7].name)

				arg_529_1.leftNameTxt_.text = var_532_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, true)
				arg_529_1.iconController_:SetSelectedState("hero")

				arg_529_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_529_1.callingController_:SetSelectedState("normal")

				arg_529_1.keyicon_.color = Color.New(1, 1, 1)
				arg_529_1.icon_.color = Color.New(1, 1, 1)

				local var_532_9 = arg_529_1:GetWordFromCfg(122531130)
				local var_532_10 = arg_529_1:FormatText(var_532_9.content)

				arg_529_1.text_.text = var_532_10

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_11 = 15
				local var_532_12 = utf8.len(var_532_10)
				local var_532_13 = var_532_11 <= 0 and var_532_7 or var_532_7 * (var_532_12 / var_532_11)

				if var_532_13 > 0 and var_532_7 < var_532_13 then
					arg_529_1.talkMaxDuration = var_532_13

					if var_532_13 + var_532_6 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_13 + var_532_6
					end
				end

				arg_529_1.text_.text = var_532_10
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_14 = math.max(var_532_7, arg_529_1.talkMaxDuration)

			if var_532_6 <= arg_529_1.time_ and arg_529_1.time_ < var_532_6 + var_532_14 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_6) / var_532_14

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_6 + var_532_14 and arg_529_1.time_ < var_532_6 + var_532_14 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play122531131 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 122531131
		arg_533_1.duration_ = 10.07

		local var_533_0 = {
			ja = 10.066,
			ko = 6.333,
			zh = 6.333
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play122531132(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = arg_533_1.actors_["1029ui_story"]
			local var_536_1 = 0

			if var_536_1 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 and not isNil(var_536_0) and arg_533_1.var_.characterEffect1029ui_story == nil then
				arg_533_1.var_.characterEffect1029ui_story = var_536_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_2 = 0.200000002980232

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_2 and not isNil(var_536_0) then
				local var_536_3 = (arg_533_1.time_ - var_536_1) / var_536_2

				if arg_533_1.var_.characterEffect1029ui_story and not isNil(var_536_0) then
					arg_533_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_533_1.time_ >= var_536_1 + var_536_2 and arg_533_1.time_ < var_536_1 + var_536_2 + arg_536_0 and not isNil(var_536_0) and arg_533_1.var_.characterEffect1029ui_story then
				arg_533_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_536_4 = 0
			local var_536_5 = 0.55

			if var_536_4 < arg_533_1.time_ and arg_533_1.time_ <= var_536_4 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_6 = arg_533_1:FormatText(StoryNameCfg[319].name)

				arg_533_1.leftNameTxt_.text = var_536_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_7 = arg_533_1:GetWordFromCfg(122531131)
				local var_536_8 = arg_533_1:FormatText(var_536_7.content)

				arg_533_1.text_.text = var_536_8

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_9 = 22
				local var_536_10 = utf8.len(var_536_8)
				local var_536_11 = var_536_9 <= 0 and var_536_5 or var_536_5 * (var_536_10 / var_536_9)

				if var_536_11 > 0 and var_536_5 < var_536_11 then
					arg_533_1.talkMaxDuration = var_536_11

					if var_536_11 + var_536_4 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_11 + var_536_4
					end
				end

				arg_533_1.text_.text = var_536_8
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531131", "story_v_out_122531.awb") ~= 0 then
					local var_536_12 = manager.audio:GetVoiceLength("story_v_out_122531", "122531131", "story_v_out_122531.awb") / 1000

					if var_536_12 + var_536_4 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_12 + var_536_4
					end

					if var_536_7.prefab_name ~= "" and arg_533_1.actors_[var_536_7.prefab_name] ~= nil then
						local var_536_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_7.prefab_name].transform, "story_v_out_122531", "122531131", "story_v_out_122531.awb")

						arg_533_1:RecordAudio("122531131", var_536_13)
						arg_533_1:RecordAudio("122531131", var_536_13)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_out_122531", "122531131", "story_v_out_122531.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_out_122531", "122531131", "story_v_out_122531.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_14 = math.max(var_536_5, arg_533_1.talkMaxDuration)

			if var_536_4 <= arg_533_1.time_ and arg_533_1.time_ < var_536_4 + var_536_14 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_4) / var_536_14

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_4 + var_536_14 and arg_533_1.time_ < var_536_4 + var_536_14 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play122531132 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 122531132
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play122531133(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = arg_537_1.actors_["1029ui_story"]
			local var_540_1 = 0

			if var_540_1 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.characterEffect1029ui_story == nil then
				arg_537_1.var_.characterEffect1029ui_story = var_540_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_2 = 0.200000002980232

			if var_540_1 <= arg_537_1.time_ and arg_537_1.time_ < var_540_1 + var_540_2 and not isNil(var_540_0) then
				local var_540_3 = (arg_537_1.time_ - var_540_1) / var_540_2

				if arg_537_1.var_.characterEffect1029ui_story and not isNil(var_540_0) then
					local var_540_4 = Mathf.Lerp(0, 0.5, var_540_3)

					arg_537_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_537_1.var_.characterEffect1029ui_story.fillRatio = var_540_4
				end
			end

			if arg_537_1.time_ >= var_540_1 + var_540_2 and arg_537_1.time_ < var_540_1 + var_540_2 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.characterEffect1029ui_story then
				local var_540_5 = 0.5

				arg_537_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_537_1.var_.characterEffect1029ui_story.fillRatio = var_540_5
			end

			local var_540_6 = 0
			local var_540_7 = 0.2

			if var_540_6 < arg_537_1.time_ and arg_537_1.time_ <= var_540_6 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_8 = arg_537_1:FormatText(StoryNameCfg[7].name)

				arg_537_1.leftNameTxt_.text = var_540_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_9 = arg_537_1:GetWordFromCfg(122531132)
				local var_540_10 = arg_537_1:FormatText(var_540_9.content)

				arg_537_1.text_.text = var_540_10

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_11 = 8
				local var_540_12 = utf8.len(var_540_10)
				local var_540_13 = var_540_11 <= 0 and var_540_7 or var_540_7 * (var_540_12 / var_540_11)

				if var_540_13 > 0 and var_540_7 < var_540_13 then
					arg_537_1.talkMaxDuration = var_540_13

					if var_540_13 + var_540_6 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_13 + var_540_6
					end
				end

				arg_537_1.text_.text = var_540_10
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_14 = math.max(var_540_7, arg_537_1.talkMaxDuration)

			if var_540_6 <= arg_537_1.time_ and arg_537_1.time_ < var_540_6 + var_540_14 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_6) / var_540_14

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_6 + var_540_14 and arg_537_1.time_ < var_540_6 + var_540_14 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play122531133 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 122531133
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play122531134(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = arg_541_1.actors_["1029ui_story"].transform
			local var_544_1 = 0

			if var_544_1 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 then
				arg_541_1.var_.moveOldPos1029ui_story = var_544_0.localPosition
			end

			local var_544_2 = 0.001

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_2 then
				local var_544_3 = (arg_541_1.time_ - var_544_1) / var_544_2
				local var_544_4 = Vector3.New(0, 100, 0)

				var_544_0.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos1029ui_story, var_544_4, var_544_3)

				local var_544_5 = manager.ui.mainCamera.transform.position - var_544_0.position

				var_544_0.forward = Vector3.New(var_544_5.x, var_544_5.y, var_544_5.z)

				local var_544_6 = var_544_0.localEulerAngles

				var_544_6.z = 0
				var_544_6.x = 0
				var_544_0.localEulerAngles = var_544_6
			end

			if arg_541_1.time_ >= var_544_1 + var_544_2 and arg_541_1.time_ < var_544_1 + var_544_2 + arg_544_0 then
				var_544_0.localPosition = Vector3.New(0, 100, 0)

				local var_544_7 = manager.ui.mainCamera.transform.position - var_544_0.position

				var_544_0.forward = Vector3.New(var_544_7.x, var_544_7.y, var_544_7.z)

				local var_544_8 = var_544_0.localEulerAngles

				var_544_8.z = 0
				var_544_8.x = 0
				var_544_0.localEulerAngles = var_544_8
			end

			local var_544_9 = arg_541_1.actors_["1029ui_story"]
			local var_544_10 = 0

			if var_544_10 < arg_541_1.time_ and arg_541_1.time_ <= var_544_10 + arg_544_0 and not isNil(var_544_9) and arg_541_1.var_.characterEffect1029ui_story == nil then
				arg_541_1.var_.characterEffect1029ui_story = var_544_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_11 = 0.200000002980232

			if var_544_10 <= arg_541_1.time_ and arg_541_1.time_ < var_544_10 + var_544_11 and not isNil(var_544_9) then
				local var_544_12 = (arg_541_1.time_ - var_544_10) / var_544_11

				if arg_541_1.var_.characterEffect1029ui_story and not isNil(var_544_9) then
					local var_544_13 = Mathf.Lerp(0, 0.5, var_544_12)

					arg_541_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_541_1.var_.characterEffect1029ui_story.fillRatio = var_544_13
				end
			end

			if arg_541_1.time_ >= var_544_10 + var_544_11 and arg_541_1.time_ < var_544_10 + var_544_11 + arg_544_0 and not isNil(var_544_9) and arg_541_1.var_.characterEffect1029ui_story then
				local var_544_14 = 0.5

				arg_541_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_541_1.var_.characterEffect1029ui_story.fillRatio = var_544_14
			end

			local var_544_15 = 0
			local var_544_16 = 0.575

			if var_544_15 < arg_541_1.time_ and arg_541_1.time_ <= var_544_15 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, false)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_17 = arg_541_1:GetWordFromCfg(122531133)
				local var_544_18 = arg_541_1:FormatText(var_544_17.content)

				arg_541_1.text_.text = var_544_18

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_19 = 23
				local var_544_20 = utf8.len(var_544_18)
				local var_544_21 = var_544_19 <= 0 and var_544_16 or var_544_16 * (var_544_20 / var_544_19)

				if var_544_21 > 0 and var_544_16 < var_544_21 then
					arg_541_1.talkMaxDuration = var_544_21

					if var_544_21 + var_544_15 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_21 + var_544_15
					end
				end

				arg_541_1.text_.text = var_544_18
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_22 = math.max(var_544_16, arg_541_1.talkMaxDuration)

			if var_544_15 <= arg_541_1.time_ and arg_541_1.time_ < var_544_15 + var_544_22 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_15) / var_544_22

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_15 + var_544_22 and arg_541_1.time_ < var_544_15 + var_544_22 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play122531134 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 122531134
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play122531135(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0
			local var_548_1 = 1.525

			if var_548_0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, false)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_2 = arg_545_1:GetWordFromCfg(122531134)
				local var_548_3 = arg_545_1:FormatText(var_548_2.content)

				arg_545_1.text_.text = var_548_3

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_4 = 61
				local var_548_5 = utf8.len(var_548_3)
				local var_548_6 = var_548_4 <= 0 and var_548_1 or var_548_1 * (var_548_5 / var_548_4)

				if var_548_6 > 0 and var_548_1 < var_548_6 then
					arg_545_1.talkMaxDuration = var_548_6

					if var_548_6 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_6 + var_548_0
					end
				end

				arg_545_1.text_.text = var_548_3
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_7 = math.max(var_548_1, arg_545_1.talkMaxDuration)

			if var_548_0 <= arg_545_1.time_ and arg_545_1.time_ < var_548_0 + var_548_7 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_0) / var_548_7

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_0 + var_548_7 and arg_545_1.time_ < var_548_0 + var_548_7 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play122531135 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 122531135
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play122531136(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0
			local var_552_1 = 0.55

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, false)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_2 = arg_549_1:GetWordFromCfg(122531135)
				local var_552_3 = arg_549_1:FormatText(var_552_2.content)

				arg_549_1.text_.text = var_552_3

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_4 = 22
				local var_552_5 = utf8.len(var_552_3)
				local var_552_6 = var_552_4 <= 0 and var_552_1 or var_552_1 * (var_552_5 / var_552_4)

				if var_552_6 > 0 and var_552_1 < var_552_6 then
					arg_549_1.talkMaxDuration = var_552_6

					if var_552_6 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_6 + var_552_0
					end
				end

				arg_549_1.text_.text = var_552_3
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_7 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_7 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_7

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_7 and arg_549_1.time_ < var_552_0 + var_552_7 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play122531136 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 122531136
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play122531137(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0
			local var_556_1 = 0.25

			if var_556_0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_2 = arg_553_1:FormatText(StoryNameCfg[7].name)

				arg_553_1.leftNameTxt_.text = var_556_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, true)
				arg_553_1.iconController_:SetSelectedState("hero")

				arg_553_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_553_1.callingController_:SetSelectedState("normal")

				arg_553_1.keyicon_.color = Color.New(1, 1, 1)
				arg_553_1.icon_.color = Color.New(1, 1, 1)

				local var_556_3 = arg_553_1:GetWordFromCfg(122531136)
				local var_556_4 = arg_553_1:FormatText(var_556_3.content)

				arg_553_1.text_.text = var_556_4

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_5 = 10
				local var_556_6 = utf8.len(var_556_4)
				local var_556_7 = var_556_5 <= 0 and var_556_1 or var_556_1 * (var_556_6 / var_556_5)

				if var_556_7 > 0 and var_556_1 < var_556_7 then
					arg_553_1.talkMaxDuration = var_556_7

					if var_556_7 + var_556_0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_7 + var_556_0
					end
				end

				arg_553_1.text_.text = var_556_4
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_8 = math.max(var_556_1, arg_553_1.talkMaxDuration)

			if var_556_0 <= arg_553_1.time_ and arg_553_1.time_ < var_556_0 + var_556_8 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_0) / var_556_8

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_0 + var_556_8 and arg_553_1.time_ < var_556_0 + var_556_8 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play122531137 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 122531137
		arg_557_1.duration_ = 5.87

		local var_557_0 = {
			ja = 5.866,
			ko = 2.466,
			zh = 2.466
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play122531138(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = arg_557_1.actors_["1029ui_story"].transform
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 then
				arg_557_1.var_.moveOldPos1029ui_story = var_560_0.localPosition
			end

			local var_560_2 = 0.001

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_2 then
				local var_560_3 = (arg_557_1.time_ - var_560_1) / var_560_2
				local var_560_4 = Vector3.New(0, -1.09, -6.2)

				var_560_0.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos1029ui_story, var_560_4, var_560_3)

				local var_560_5 = manager.ui.mainCamera.transform.position - var_560_0.position

				var_560_0.forward = Vector3.New(var_560_5.x, var_560_5.y, var_560_5.z)

				local var_560_6 = var_560_0.localEulerAngles

				var_560_6.z = 0
				var_560_6.x = 0
				var_560_0.localEulerAngles = var_560_6
			end

			if arg_557_1.time_ >= var_560_1 + var_560_2 and arg_557_1.time_ < var_560_1 + var_560_2 + arg_560_0 then
				var_560_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_560_7 = manager.ui.mainCamera.transform.position - var_560_0.position

				var_560_0.forward = Vector3.New(var_560_7.x, var_560_7.y, var_560_7.z)

				local var_560_8 = var_560_0.localEulerAngles

				var_560_8.z = 0
				var_560_8.x = 0
				var_560_0.localEulerAngles = var_560_8
			end

			local var_560_9 = arg_557_1.actors_["1029ui_story"]
			local var_560_10 = 0

			if var_560_10 < arg_557_1.time_ and arg_557_1.time_ <= var_560_10 + arg_560_0 and not isNil(var_560_9) and arg_557_1.var_.characterEffect1029ui_story == nil then
				arg_557_1.var_.characterEffect1029ui_story = var_560_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_11 = 0.200000002980232

			if var_560_10 <= arg_557_1.time_ and arg_557_1.time_ < var_560_10 + var_560_11 and not isNil(var_560_9) then
				local var_560_12 = (arg_557_1.time_ - var_560_10) / var_560_11

				if arg_557_1.var_.characterEffect1029ui_story and not isNil(var_560_9) then
					arg_557_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_557_1.time_ >= var_560_10 + var_560_11 and arg_557_1.time_ < var_560_10 + var_560_11 + arg_560_0 and not isNil(var_560_9) and arg_557_1.var_.characterEffect1029ui_story then
				arg_557_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_560_13 = 0

			if var_560_13 < arg_557_1.time_ and arg_557_1.time_ <= var_560_13 + arg_560_0 then
				arg_557_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_2")
			end

			local var_560_14 = 0

			if var_560_14 < arg_557_1.time_ and arg_557_1.time_ <= var_560_14 + arg_560_0 then
				arg_557_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_560_15 = 0
			local var_560_16 = 0.35

			if var_560_15 < arg_557_1.time_ and arg_557_1.time_ <= var_560_15 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_17 = arg_557_1:FormatText(StoryNameCfg[319].name)

				arg_557_1.leftNameTxt_.text = var_560_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_18 = arg_557_1:GetWordFromCfg(122531137)
				local var_560_19 = arg_557_1:FormatText(var_560_18.content)

				arg_557_1.text_.text = var_560_19

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_20 = 14
				local var_560_21 = utf8.len(var_560_19)
				local var_560_22 = var_560_20 <= 0 and var_560_16 or var_560_16 * (var_560_21 / var_560_20)

				if var_560_22 > 0 and var_560_16 < var_560_22 then
					arg_557_1.talkMaxDuration = var_560_22

					if var_560_22 + var_560_15 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_22 + var_560_15
					end
				end

				arg_557_1.text_.text = var_560_19
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531137", "story_v_out_122531.awb") ~= 0 then
					local var_560_23 = manager.audio:GetVoiceLength("story_v_out_122531", "122531137", "story_v_out_122531.awb") / 1000

					if var_560_23 + var_560_15 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_23 + var_560_15
					end

					if var_560_18.prefab_name ~= "" and arg_557_1.actors_[var_560_18.prefab_name] ~= nil then
						local var_560_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_18.prefab_name].transform, "story_v_out_122531", "122531137", "story_v_out_122531.awb")

						arg_557_1:RecordAudio("122531137", var_560_24)
						arg_557_1:RecordAudio("122531137", var_560_24)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_out_122531", "122531137", "story_v_out_122531.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_out_122531", "122531137", "story_v_out_122531.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_25 = math.max(var_560_16, arg_557_1.talkMaxDuration)

			if var_560_15 <= arg_557_1.time_ and arg_557_1.time_ < var_560_15 + var_560_25 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_15) / var_560_25

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_15 + var_560_25 and arg_557_1.time_ < var_560_15 + var_560_25 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_557_1:InitPlayNodeList()
	end,
	Play122531138 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 122531138
		arg_561_1.duration_ = 14.63

		local var_561_0 = {
			ja = 14.633,
			ko = 10.7,
			zh = 10.7
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play122531139(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0
			local var_564_1 = 1.3

			if var_564_0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_2 = arg_561_1:FormatText(StoryNameCfg[319].name)

				arg_561_1.leftNameTxt_.text = var_564_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_3 = arg_561_1:GetWordFromCfg(122531138)
				local var_564_4 = arg_561_1:FormatText(var_564_3.content)

				arg_561_1.text_.text = var_564_4

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_5 = 52
				local var_564_6 = utf8.len(var_564_4)
				local var_564_7 = var_564_5 <= 0 and var_564_1 or var_564_1 * (var_564_6 / var_564_5)

				if var_564_7 > 0 and var_564_1 < var_564_7 then
					arg_561_1.talkMaxDuration = var_564_7

					if var_564_7 + var_564_0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_7 + var_564_0
					end
				end

				arg_561_1.text_.text = var_564_4
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531138", "story_v_out_122531.awb") ~= 0 then
					local var_564_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531138", "story_v_out_122531.awb") / 1000

					if var_564_8 + var_564_0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_8 + var_564_0
					end

					if var_564_3.prefab_name ~= "" and arg_561_1.actors_[var_564_3.prefab_name] ~= nil then
						local var_564_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_3.prefab_name].transform, "story_v_out_122531", "122531138", "story_v_out_122531.awb")

						arg_561_1:RecordAudio("122531138", var_564_9)
						arg_561_1:RecordAudio("122531138", var_564_9)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_122531", "122531138", "story_v_out_122531.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_122531", "122531138", "story_v_out_122531.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_10 = math.max(var_564_1, arg_561_1.talkMaxDuration)

			if var_564_0 <= arg_561_1.time_ and arg_561_1.time_ < var_564_0 + var_564_10 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_0) / var_564_10

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_0 + var_564_10 and arg_561_1.time_ < var_564_0 + var_564_10 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play122531139 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 122531139
		arg_565_1.duration_ = 9.43

		local var_565_0 = {
			ja = 9.433,
			ko = 7.233,
			zh = 7.233
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play122531140(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = 0
			local var_568_1 = 0.825

			if var_568_0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_0 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_2 = arg_565_1:FormatText(StoryNameCfg[319].name)

				arg_565_1.leftNameTxt_.text = var_568_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_3 = arg_565_1:GetWordFromCfg(122531139)
				local var_568_4 = arg_565_1:FormatText(var_568_3.content)

				arg_565_1.text_.text = var_568_4

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_5 = 33
				local var_568_6 = utf8.len(var_568_4)
				local var_568_7 = var_568_5 <= 0 and var_568_1 or var_568_1 * (var_568_6 / var_568_5)

				if var_568_7 > 0 and var_568_1 < var_568_7 then
					arg_565_1.talkMaxDuration = var_568_7

					if var_568_7 + var_568_0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_7 + var_568_0
					end
				end

				arg_565_1.text_.text = var_568_4
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531139", "story_v_out_122531.awb") ~= 0 then
					local var_568_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531139", "story_v_out_122531.awb") / 1000

					if var_568_8 + var_568_0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_8 + var_568_0
					end

					if var_568_3.prefab_name ~= "" and arg_565_1.actors_[var_568_3.prefab_name] ~= nil then
						local var_568_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_3.prefab_name].transform, "story_v_out_122531", "122531139", "story_v_out_122531.awb")

						arg_565_1:RecordAudio("122531139", var_568_9)
						arg_565_1:RecordAudio("122531139", var_568_9)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_out_122531", "122531139", "story_v_out_122531.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_out_122531", "122531139", "story_v_out_122531.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_10 = math.max(var_568_1, arg_565_1.talkMaxDuration)

			if var_568_0 <= arg_565_1.time_ and arg_565_1.time_ < var_568_0 + var_568_10 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_0) / var_568_10

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_0 + var_568_10 and arg_565_1.time_ < var_568_0 + var_568_10 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play122531140 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 122531140
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play122531141(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = arg_569_1.actors_["1029ui_story"]
			local var_572_1 = 0

			if var_572_1 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 and not isNil(var_572_0) and arg_569_1.var_.characterEffect1029ui_story == nil then
				arg_569_1.var_.characterEffect1029ui_story = var_572_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_2 = 0.200000002980232

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_2 and not isNil(var_572_0) then
				local var_572_3 = (arg_569_1.time_ - var_572_1) / var_572_2

				if arg_569_1.var_.characterEffect1029ui_story and not isNil(var_572_0) then
					local var_572_4 = Mathf.Lerp(0, 0.5, var_572_3)

					arg_569_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_569_1.var_.characterEffect1029ui_story.fillRatio = var_572_4
				end
			end

			if arg_569_1.time_ >= var_572_1 + var_572_2 and arg_569_1.time_ < var_572_1 + var_572_2 + arg_572_0 and not isNil(var_572_0) and arg_569_1.var_.characterEffect1029ui_story then
				local var_572_5 = 0.5

				arg_569_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_569_1.var_.characterEffect1029ui_story.fillRatio = var_572_5
			end

			local var_572_6 = 0
			local var_572_7 = 0.375

			if var_572_6 < arg_569_1.time_ and arg_569_1.time_ <= var_572_6 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				local var_572_8 = arg_569_1:FormatText(StoryNameCfg[7].name)

				arg_569_1.leftNameTxt_.text = var_572_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, true)
				arg_569_1.iconController_:SetSelectedState("hero")

				arg_569_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_569_1.callingController_:SetSelectedState("normal")

				arg_569_1.keyicon_.color = Color.New(1, 1, 1)
				arg_569_1.icon_.color = Color.New(1, 1, 1)

				local var_572_9 = arg_569_1:GetWordFromCfg(122531140)
				local var_572_10 = arg_569_1:FormatText(var_572_9.content)

				arg_569_1.text_.text = var_572_10

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_11 = 15
				local var_572_12 = utf8.len(var_572_10)
				local var_572_13 = var_572_11 <= 0 and var_572_7 or var_572_7 * (var_572_12 / var_572_11)

				if var_572_13 > 0 and var_572_7 < var_572_13 then
					arg_569_1.talkMaxDuration = var_572_13

					if var_572_13 + var_572_6 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_13 + var_572_6
					end
				end

				arg_569_1.text_.text = var_572_10
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_14 = math.max(var_572_7, arg_569_1.talkMaxDuration)

			if var_572_6 <= arg_569_1.time_ and arg_569_1.time_ < var_572_6 + var_572_14 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_6) / var_572_14

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_6 + var_572_14 and arg_569_1.time_ < var_572_6 + var_572_14 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play122531141 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 122531141
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play122531142(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = 0
			local var_576_1 = 0.525

			if var_576_0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_0 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				local var_576_2 = arg_573_1:FormatText(StoryNameCfg[7].name)

				arg_573_1.leftNameTxt_.text = var_576_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, true)
				arg_573_1.iconController_:SetSelectedState("hero")

				arg_573_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_573_1.callingController_:SetSelectedState("normal")

				arg_573_1.keyicon_.color = Color.New(1, 1, 1)
				arg_573_1.icon_.color = Color.New(1, 1, 1)

				local var_576_3 = arg_573_1:GetWordFromCfg(122531141)
				local var_576_4 = arg_573_1:FormatText(var_576_3.content)

				arg_573_1.text_.text = var_576_4

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_5 = 21
				local var_576_6 = utf8.len(var_576_4)
				local var_576_7 = var_576_5 <= 0 and var_576_1 or var_576_1 * (var_576_6 / var_576_5)

				if var_576_7 > 0 and var_576_1 < var_576_7 then
					arg_573_1.talkMaxDuration = var_576_7

					if var_576_7 + var_576_0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_7 + var_576_0
					end
				end

				arg_573_1.text_.text = var_576_4
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_8 = math.max(var_576_1, arg_573_1.talkMaxDuration)

			if var_576_0 <= arg_573_1.time_ and arg_573_1.time_ < var_576_0 + var_576_8 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_0) / var_576_8

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_0 + var_576_8 and arg_573_1.time_ < var_576_0 + var_576_8 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play122531142 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 122531142
		arg_577_1.duration_ = 4.23

		local var_577_0 = {
			ja = 4.233,
			ko = 2.6,
			zh = 2.6
		}
		local var_577_1 = manager.audio:GetLocalizationFlag()

		if var_577_0[var_577_1] ~= nil then
			arg_577_1.duration_ = var_577_0[var_577_1]
		end

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play122531143(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = arg_577_1.actors_["1029ui_story"]
			local var_580_1 = 0

			if var_580_1 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 and not isNil(var_580_0) and arg_577_1.var_.characterEffect1029ui_story == nil then
				arg_577_1.var_.characterEffect1029ui_story = var_580_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_2 = 0.200000002980232

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_2 and not isNil(var_580_0) then
				local var_580_3 = (arg_577_1.time_ - var_580_1) / var_580_2

				if arg_577_1.var_.characterEffect1029ui_story and not isNil(var_580_0) then
					arg_577_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_577_1.time_ >= var_580_1 + var_580_2 and arg_577_1.time_ < var_580_1 + var_580_2 + arg_580_0 and not isNil(var_580_0) and arg_577_1.var_.characterEffect1029ui_story then
				arg_577_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_580_4 = 0

			if var_580_4 < arg_577_1.time_ and arg_577_1.time_ <= var_580_4 + arg_580_0 then
				arg_577_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_580_5 = 0

			if var_580_5 < arg_577_1.time_ and arg_577_1.time_ <= var_580_5 + arg_580_0 then
				arg_577_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_580_6 = 0
			local var_580_7 = 0.175

			if var_580_6 < arg_577_1.time_ and arg_577_1.time_ <= var_580_6 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				local var_580_8 = arg_577_1:FormatText(StoryNameCfg[319].name)

				arg_577_1.leftNameTxt_.text = var_580_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_9 = arg_577_1:GetWordFromCfg(122531142)
				local var_580_10 = arg_577_1:FormatText(var_580_9.content)

				arg_577_1.text_.text = var_580_10

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_11 = 7
				local var_580_12 = utf8.len(var_580_10)
				local var_580_13 = var_580_11 <= 0 and var_580_7 or var_580_7 * (var_580_12 / var_580_11)

				if var_580_13 > 0 and var_580_7 < var_580_13 then
					arg_577_1.talkMaxDuration = var_580_13

					if var_580_13 + var_580_6 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_13 + var_580_6
					end
				end

				arg_577_1.text_.text = var_580_10
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531142", "story_v_out_122531.awb") ~= 0 then
					local var_580_14 = manager.audio:GetVoiceLength("story_v_out_122531", "122531142", "story_v_out_122531.awb") / 1000

					if var_580_14 + var_580_6 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_14 + var_580_6
					end

					if var_580_9.prefab_name ~= "" and arg_577_1.actors_[var_580_9.prefab_name] ~= nil then
						local var_580_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_577_1.actors_[var_580_9.prefab_name].transform, "story_v_out_122531", "122531142", "story_v_out_122531.awb")

						arg_577_1:RecordAudio("122531142", var_580_15)
						arg_577_1:RecordAudio("122531142", var_580_15)
					else
						arg_577_1:AudioAction("play", "voice", "story_v_out_122531", "122531142", "story_v_out_122531.awb")
					end

					arg_577_1:RecordHistoryTalkVoice("story_v_out_122531", "122531142", "story_v_out_122531.awb")
				end

				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_16 = math.max(var_580_7, arg_577_1.talkMaxDuration)

			if var_580_6 <= arg_577_1.time_ and arg_577_1.time_ < var_580_6 + var_580_16 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_6) / var_580_16

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_6 + var_580_16 and arg_577_1.time_ < var_580_6 + var_580_16 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play122531143 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 122531143
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play122531144(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = arg_581_1.actors_["1029ui_story"]
			local var_584_1 = 0

			if var_584_1 < arg_581_1.time_ and arg_581_1.time_ <= var_584_1 + arg_584_0 and not isNil(var_584_0) and arg_581_1.var_.characterEffect1029ui_story == nil then
				arg_581_1.var_.characterEffect1029ui_story = var_584_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_2 = 0.200000002980232

			if var_584_1 <= arg_581_1.time_ and arg_581_1.time_ < var_584_1 + var_584_2 and not isNil(var_584_0) then
				local var_584_3 = (arg_581_1.time_ - var_584_1) / var_584_2

				if arg_581_1.var_.characterEffect1029ui_story and not isNil(var_584_0) then
					local var_584_4 = Mathf.Lerp(0, 0.5, var_584_3)

					arg_581_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_581_1.var_.characterEffect1029ui_story.fillRatio = var_584_4
				end
			end

			if arg_581_1.time_ >= var_584_1 + var_584_2 and arg_581_1.time_ < var_584_1 + var_584_2 + arg_584_0 and not isNil(var_584_0) and arg_581_1.var_.characterEffect1029ui_story then
				local var_584_5 = 0.5

				arg_581_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_581_1.var_.characterEffect1029ui_story.fillRatio = var_584_5
			end

			local var_584_6 = 0
			local var_584_7 = 0.525

			if var_584_6 < arg_581_1.time_ and arg_581_1.time_ <= var_584_6 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				local var_584_8 = arg_581_1:FormatText(StoryNameCfg[7].name)

				arg_581_1.leftNameTxt_.text = var_584_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, true)
				arg_581_1.iconController_:SetSelectedState("hero")

				arg_581_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_581_1.callingController_:SetSelectedState("normal")

				arg_581_1.keyicon_.color = Color.New(1, 1, 1)
				arg_581_1.icon_.color = Color.New(1, 1, 1)

				local var_584_9 = arg_581_1:GetWordFromCfg(122531143)
				local var_584_10 = arg_581_1:FormatText(var_584_9.content)

				arg_581_1.text_.text = var_584_10

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_11 = 21
				local var_584_12 = utf8.len(var_584_10)
				local var_584_13 = var_584_11 <= 0 and var_584_7 or var_584_7 * (var_584_12 / var_584_11)

				if var_584_13 > 0 and var_584_7 < var_584_13 then
					arg_581_1.talkMaxDuration = var_584_13

					if var_584_13 + var_584_6 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_13 + var_584_6
					end
				end

				arg_581_1.text_.text = var_584_10
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_14 = math.max(var_584_7, arg_581_1.talkMaxDuration)

			if var_584_6 <= arg_581_1.time_ and arg_581_1.time_ < var_584_6 + var_584_14 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_6) / var_584_14

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_6 + var_584_14 and arg_581_1.time_ < var_584_6 + var_584_14 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play122531144 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 122531144
		arg_585_1.duration_ = 15.97

		local var_585_0 = {
			ja = 15.966,
			ko = 10.1,
			zh = 10.1
		}
		local var_585_1 = manager.audio:GetLocalizationFlag()

		if var_585_0[var_585_1] ~= nil then
			arg_585_1.duration_ = var_585_0[var_585_1]
		end

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play122531145(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = arg_585_1.actors_["1029ui_story"]
			local var_588_1 = 0

			if var_588_1 < arg_585_1.time_ and arg_585_1.time_ <= var_588_1 + arg_588_0 and not isNil(var_588_0) and arg_585_1.var_.characterEffect1029ui_story == nil then
				arg_585_1.var_.characterEffect1029ui_story = var_588_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_2 = 0.200000002980232

			if var_588_1 <= arg_585_1.time_ and arg_585_1.time_ < var_588_1 + var_588_2 and not isNil(var_588_0) then
				local var_588_3 = (arg_585_1.time_ - var_588_1) / var_588_2

				if arg_585_1.var_.characterEffect1029ui_story and not isNil(var_588_0) then
					arg_585_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_585_1.time_ >= var_588_1 + var_588_2 and arg_585_1.time_ < var_588_1 + var_588_2 + arg_588_0 and not isNil(var_588_0) and arg_585_1.var_.characterEffect1029ui_story then
				arg_585_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_588_4 = 0

			if var_588_4 < arg_585_1.time_ and arg_585_1.time_ <= var_588_4 + arg_588_0 then
				arg_585_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_588_5 = 0

			if var_588_5 < arg_585_1.time_ and arg_585_1.time_ <= var_588_5 + arg_588_0 then
				arg_585_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_588_6 = 0
			local var_588_7 = 1.125

			if var_588_6 < arg_585_1.time_ and arg_585_1.time_ <= var_588_6 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				local var_588_8 = arg_585_1:FormatText(StoryNameCfg[319].name)

				arg_585_1.leftNameTxt_.text = var_588_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_9 = arg_585_1:GetWordFromCfg(122531144)
				local var_588_10 = arg_585_1:FormatText(var_588_9.content)

				arg_585_1.text_.text = var_588_10

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_11 = 45
				local var_588_12 = utf8.len(var_588_10)
				local var_588_13 = var_588_11 <= 0 and var_588_7 or var_588_7 * (var_588_12 / var_588_11)

				if var_588_13 > 0 and var_588_7 < var_588_13 then
					arg_585_1.talkMaxDuration = var_588_13

					if var_588_13 + var_588_6 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_13 + var_588_6
					end
				end

				arg_585_1.text_.text = var_588_10
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531144", "story_v_out_122531.awb") ~= 0 then
					local var_588_14 = manager.audio:GetVoiceLength("story_v_out_122531", "122531144", "story_v_out_122531.awb") / 1000

					if var_588_14 + var_588_6 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_14 + var_588_6
					end

					if var_588_9.prefab_name ~= "" and arg_585_1.actors_[var_588_9.prefab_name] ~= nil then
						local var_588_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_9.prefab_name].transform, "story_v_out_122531", "122531144", "story_v_out_122531.awb")

						arg_585_1:RecordAudio("122531144", var_588_15)
						arg_585_1:RecordAudio("122531144", var_588_15)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_out_122531", "122531144", "story_v_out_122531.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_out_122531", "122531144", "story_v_out_122531.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_16 = math.max(var_588_7, arg_585_1.talkMaxDuration)

			if var_588_6 <= arg_585_1.time_ and arg_585_1.time_ < var_588_6 + var_588_16 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_6) / var_588_16

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_6 + var_588_16 and arg_585_1.time_ < var_588_6 + var_588_16 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play122531145 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 122531145
		arg_589_1.duration_ = 10.93

		local var_589_0 = {
			ja = 10.933,
			ko = 9.833,
			zh = 9.833
		}
		local var_589_1 = manager.audio:GetLocalizationFlag()

		if var_589_0[var_589_1] ~= nil then
			arg_589_1.duration_ = var_589_0[var_589_1]
		end

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play122531146(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0
			local var_592_1 = 1.175

			if var_592_0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				local var_592_2 = arg_589_1:FormatText(StoryNameCfg[319].name)

				arg_589_1.leftNameTxt_.text = var_592_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_3 = arg_589_1:GetWordFromCfg(122531145)
				local var_592_4 = arg_589_1:FormatText(var_592_3.content)

				arg_589_1.text_.text = var_592_4

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_5 = 47
				local var_592_6 = utf8.len(var_592_4)
				local var_592_7 = var_592_5 <= 0 and var_592_1 or var_592_1 * (var_592_6 / var_592_5)

				if var_592_7 > 0 and var_592_1 < var_592_7 then
					arg_589_1.talkMaxDuration = var_592_7

					if var_592_7 + var_592_0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_7 + var_592_0
					end
				end

				arg_589_1.text_.text = var_592_4
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531145", "story_v_out_122531.awb") ~= 0 then
					local var_592_8 = manager.audio:GetVoiceLength("story_v_out_122531", "122531145", "story_v_out_122531.awb") / 1000

					if var_592_8 + var_592_0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_8 + var_592_0
					end

					if var_592_3.prefab_name ~= "" and arg_589_1.actors_[var_592_3.prefab_name] ~= nil then
						local var_592_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_3.prefab_name].transform, "story_v_out_122531", "122531145", "story_v_out_122531.awb")

						arg_589_1:RecordAudio("122531145", var_592_9)
						arg_589_1:RecordAudio("122531145", var_592_9)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_out_122531", "122531145", "story_v_out_122531.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_out_122531", "122531145", "story_v_out_122531.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_10 = math.max(var_592_1, arg_589_1.talkMaxDuration)

			if var_592_0 <= arg_589_1.time_ and arg_589_1.time_ < var_592_0 + var_592_10 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_0) / var_592_10

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_0 + var_592_10 and arg_589_1.time_ < var_592_0 + var_592_10 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play122531146 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 122531146
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play122531147(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = arg_593_1.actors_["1029ui_story"]
			local var_596_1 = 0

			if var_596_1 < arg_593_1.time_ and arg_593_1.time_ <= var_596_1 + arg_596_0 and not isNil(var_596_0) and arg_593_1.var_.characterEffect1029ui_story == nil then
				arg_593_1.var_.characterEffect1029ui_story = var_596_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_2 = 0.200000002980232

			if var_596_1 <= arg_593_1.time_ and arg_593_1.time_ < var_596_1 + var_596_2 and not isNil(var_596_0) then
				local var_596_3 = (arg_593_1.time_ - var_596_1) / var_596_2

				if arg_593_1.var_.characterEffect1029ui_story and not isNil(var_596_0) then
					local var_596_4 = Mathf.Lerp(0, 0.5, var_596_3)

					arg_593_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_593_1.var_.characterEffect1029ui_story.fillRatio = var_596_4
				end
			end

			if arg_593_1.time_ >= var_596_1 + var_596_2 and arg_593_1.time_ < var_596_1 + var_596_2 + arg_596_0 and not isNil(var_596_0) and arg_593_1.var_.characterEffect1029ui_story then
				local var_596_5 = 0.5

				arg_593_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_593_1.var_.characterEffect1029ui_story.fillRatio = var_596_5
			end

			local var_596_6 = 0
			local var_596_7 = 0.425

			if var_596_6 < arg_593_1.time_ and arg_593_1.time_ <= var_596_6 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				local var_596_8 = arg_593_1:FormatText(StoryNameCfg[7].name)

				arg_593_1.leftNameTxt_.text = var_596_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, true)
				arg_593_1.iconController_:SetSelectedState("hero")

				arg_593_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_593_1.callingController_:SetSelectedState("normal")

				arg_593_1.keyicon_.color = Color.New(1, 1, 1)
				arg_593_1.icon_.color = Color.New(1, 1, 1)

				local var_596_9 = arg_593_1:GetWordFromCfg(122531146)
				local var_596_10 = arg_593_1:FormatText(var_596_9.content)

				arg_593_1.text_.text = var_596_10

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_11 = 17
				local var_596_12 = utf8.len(var_596_10)
				local var_596_13 = var_596_11 <= 0 and var_596_7 or var_596_7 * (var_596_12 / var_596_11)

				if var_596_13 > 0 and var_596_7 < var_596_13 then
					arg_593_1.talkMaxDuration = var_596_13

					if var_596_13 + var_596_6 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_13 + var_596_6
					end
				end

				arg_593_1.text_.text = var_596_10
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_14 = math.max(var_596_7, arg_593_1.talkMaxDuration)

			if var_596_6 <= arg_593_1.time_ and arg_593_1.time_ < var_596_6 + var_596_14 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_6) / var_596_14

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_6 + var_596_14 and arg_593_1.time_ < var_596_6 + var_596_14 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play122531147 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 122531147
		arg_597_1.duration_ = 8.83

		local var_597_0 = {
			ja = 8.833,
			ko = 6.833,
			zh = 6.833
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play122531148(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = arg_597_1.actors_["1029ui_story"]
			local var_600_1 = 0

			if var_600_1 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 and not isNil(var_600_0) and arg_597_1.var_.characterEffect1029ui_story == nil then
				arg_597_1.var_.characterEffect1029ui_story = var_600_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_2 = 0.200000002980232

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_2 and not isNil(var_600_0) then
				local var_600_3 = (arg_597_1.time_ - var_600_1) / var_600_2

				if arg_597_1.var_.characterEffect1029ui_story and not isNil(var_600_0) then
					arg_597_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_597_1.time_ >= var_600_1 + var_600_2 and arg_597_1.time_ < var_600_1 + var_600_2 + arg_600_0 and not isNil(var_600_0) and arg_597_1.var_.characterEffect1029ui_story then
				arg_597_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_600_4 = 0
			local var_600_5 = 0.75

			if var_600_4 < arg_597_1.time_ and arg_597_1.time_ <= var_600_4 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				local var_600_6 = arg_597_1:FormatText(StoryNameCfg[319].name)

				arg_597_1.leftNameTxt_.text = var_600_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_7 = arg_597_1:GetWordFromCfg(122531147)
				local var_600_8 = arg_597_1:FormatText(var_600_7.content)

				arg_597_1.text_.text = var_600_8

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_9 = 30
				local var_600_10 = utf8.len(var_600_8)
				local var_600_11 = var_600_9 <= 0 and var_600_5 or var_600_5 * (var_600_10 / var_600_9)

				if var_600_11 > 0 and var_600_5 < var_600_11 then
					arg_597_1.talkMaxDuration = var_600_11

					if var_600_11 + var_600_4 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_11 + var_600_4
					end
				end

				arg_597_1.text_.text = var_600_8
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531147", "story_v_out_122531.awb") ~= 0 then
					local var_600_12 = manager.audio:GetVoiceLength("story_v_out_122531", "122531147", "story_v_out_122531.awb") / 1000

					if var_600_12 + var_600_4 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_12 + var_600_4
					end

					if var_600_7.prefab_name ~= "" and arg_597_1.actors_[var_600_7.prefab_name] ~= nil then
						local var_600_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_7.prefab_name].transform, "story_v_out_122531", "122531147", "story_v_out_122531.awb")

						arg_597_1:RecordAudio("122531147", var_600_13)
						arg_597_1:RecordAudio("122531147", var_600_13)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_out_122531", "122531147", "story_v_out_122531.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_out_122531", "122531147", "story_v_out_122531.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_14 = math.max(var_600_5, arg_597_1.talkMaxDuration)

			if var_600_4 <= arg_597_1.time_ and arg_597_1.time_ < var_600_4 + var_600_14 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_4) / var_600_14

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_4 + var_600_14 and arg_597_1.time_ < var_600_4 + var_600_14 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play122531148 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 122531148
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play122531149(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = arg_601_1.actors_["1029ui_story"]
			local var_604_1 = 0

			if var_604_1 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.characterEffect1029ui_story == nil then
				arg_601_1.var_.characterEffect1029ui_story = var_604_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_2 = 0.200000002980232

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_2 and not isNil(var_604_0) then
				local var_604_3 = (arg_601_1.time_ - var_604_1) / var_604_2

				if arg_601_1.var_.characterEffect1029ui_story and not isNil(var_604_0) then
					local var_604_4 = Mathf.Lerp(0, 0.5, var_604_3)

					arg_601_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_601_1.var_.characterEffect1029ui_story.fillRatio = var_604_4
				end
			end

			if arg_601_1.time_ >= var_604_1 + var_604_2 and arg_601_1.time_ < var_604_1 + var_604_2 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.characterEffect1029ui_story then
				local var_604_5 = 0.5

				arg_601_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_601_1.var_.characterEffect1029ui_story.fillRatio = var_604_5
			end

			local var_604_6 = 0
			local var_604_7 = 0.9

			if var_604_6 < arg_601_1.time_ and arg_601_1.time_ <= var_604_6 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				local var_604_8 = arg_601_1:FormatText(StoryNameCfg[7].name)

				arg_601_1.leftNameTxt_.text = var_604_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, true)
				arg_601_1.iconController_:SetSelectedState("hero")

				arg_601_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_601_1.callingController_:SetSelectedState("normal")

				arg_601_1.keyicon_.color = Color.New(1, 1, 1)
				arg_601_1.icon_.color = Color.New(1, 1, 1)

				local var_604_9 = arg_601_1:GetWordFromCfg(122531148)
				local var_604_10 = arg_601_1:FormatText(var_604_9.content)

				arg_601_1.text_.text = var_604_10

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_11 = 36
				local var_604_12 = utf8.len(var_604_10)
				local var_604_13 = var_604_11 <= 0 and var_604_7 or var_604_7 * (var_604_12 / var_604_11)

				if var_604_13 > 0 and var_604_7 < var_604_13 then
					arg_601_1.talkMaxDuration = var_604_13

					if var_604_13 + var_604_6 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_13 + var_604_6
					end
				end

				arg_601_1.text_.text = var_604_10
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_14 = math.max(var_604_7, arg_601_1.talkMaxDuration)

			if var_604_6 <= arg_601_1.time_ and arg_601_1.time_ < var_604_6 + var_604_14 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_6) / var_604_14

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_6 + var_604_14 and arg_601_1.time_ < var_604_6 + var_604_14 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play122531149 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 122531149
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play122531150(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0
			local var_608_1 = 0.5

			if var_608_0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				local var_608_2 = arg_605_1:FormatText(StoryNameCfg[7].name)

				arg_605_1.leftNameTxt_.text = var_608_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, true)
				arg_605_1.iconController_:SetSelectedState("hero")

				arg_605_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_605_1.callingController_:SetSelectedState("normal")

				arg_605_1.keyicon_.color = Color.New(1, 1, 1)
				arg_605_1.icon_.color = Color.New(1, 1, 1)

				local var_608_3 = arg_605_1:GetWordFromCfg(122531149)
				local var_608_4 = arg_605_1:FormatText(var_608_3.content)

				arg_605_1.text_.text = var_608_4

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_5 = 20
				local var_608_6 = utf8.len(var_608_4)
				local var_608_7 = var_608_5 <= 0 and var_608_1 or var_608_1 * (var_608_6 / var_608_5)

				if var_608_7 > 0 and var_608_1 < var_608_7 then
					arg_605_1.talkMaxDuration = var_608_7

					if var_608_7 + var_608_0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_7 + var_608_0
					end
				end

				arg_605_1.text_.text = var_608_4
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_8 = math.max(var_608_1, arg_605_1.talkMaxDuration)

			if var_608_0 <= arg_605_1.time_ and arg_605_1.time_ < var_608_0 + var_608_8 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_0) / var_608_8

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_0 + var_608_8 and arg_605_1.time_ < var_608_0 + var_608_8 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play122531150 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 122531150
		arg_609_1.duration_ = 15.63

		local var_609_0 = {
			ja = 15.633,
			ko = 7.633,
			zh = 7.633
		}
		local var_609_1 = manager.audio:GetLocalizationFlag()

		if var_609_0[var_609_1] ~= nil then
			arg_609_1.duration_ = var_609_0[var_609_1]
		end

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play122531151(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = arg_609_1.actors_["1029ui_story"]
			local var_612_1 = 0

			if var_612_1 < arg_609_1.time_ and arg_609_1.time_ <= var_612_1 + arg_612_0 and not isNil(var_612_0) and arg_609_1.var_.characterEffect1029ui_story == nil then
				arg_609_1.var_.characterEffect1029ui_story = var_612_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_2 = 0.200000002980232

			if var_612_1 <= arg_609_1.time_ and arg_609_1.time_ < var_612_1 + var_612_2 and not isNil(var_612_0) then
				local var_612_3 = (arg_609_1.time_ - var_612_1) / var_612_2

				if arg_609_1.var_.characterEffect1029ui_story and not isNil(var_612_0) then
					arg_609_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_609_1.time_ >= var_612_1 + var_612_2 and arg_609_1.time_ < var_612_1 + var_612_2 + arg_612_0 and not isNil(var_612_0) and arg_609_1.var_.characterEffect1029ui_story then
				arg_609_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_612_4 = 0

			if var_612_4 < arg_609_1.time_ and arg_609_1.time_ <= var_612_4 + arg_612_0 then
				arg_609_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action445")
			end

			local var_612_5 = 0

			if var_612_5 < arg_609_1.time_ and arg_609_1.time_ <= var_612_5 + arg_612_0 then
				arg_609_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_612_6 = 0
			local var_612_7 = 0.875

			if var_612_6 < arg_609_1.time_ and arg_609_1.time_ <= var_612_6 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				local var_612_8 = arg_609_1:FormatText(StoryNameCfg[319].name)

				arg_609_1.leftNameTxt_.text = var_612_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_9 = arg_609_1:GetWordFromCfg(122531150)
				local var_612_10 = arg_609_1:FormatText(var_612_9.content)

				arg_609_1.text_.text = var_612_10

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_11 = 35
				local var_612_12 = utf8.len(var_612_10)
				local var_612_13 = var_612_11 <= 0 and var_612_7 or var_612_7 * (var_612_12 / var_612_11)

				if var_612_13 > 0 and var_612_7 < var_612_13 then
					arg_609_1.talkMaxDuration = var_612_13

					if var_612_13 + var_612_6 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_13 + var_612_6
					end
				end

				arg_609_1.text_.text = var_612_10
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531150", "story_v_out_122531.awb") ~= 0 then
					local var_612_14 = manager.audio:GetVoiceLength("story_v_out_122531", "122531150", "story_v_out_122531.awb") / 1000

					if var_612_14 + var_612_6 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_14 + var_612_6
					end

					if var_612_9.prefab_name ~= "" and arg_609_1.actors_[var_612_9.prefab_name] ~= nil then
						local var_612_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_9.prefab_name].transform, "story_v_out_122531", "122531150", "story_v_out_122531.awb")

						arg_609_1:RecordAudio("122531150", var_612_15)
						arg_609_1:RecordAudio("122531150", var_612_15)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_out_122531", "122531150", "story_v_out_122531.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_out_122531", "122531150", "story_v_out_122531.awb")
				end

				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_16 = math.max(var_612_7, arg_609_1.talkMaxDuration)

			if var_612_6 <= arg_609_1.time_ and arg_609_1.time_ < var_612_6 + var_612_16 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_6) / var_612_16

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_6 + var_612_16 and arg_609_1.time_ < var_612_6 + var_612_16 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play122531151 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 122531151
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play122531152(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = arg_613_1.actors_["1029ui_story"].transform
			local var_616_1 = 0

			if var_616_1 < arg_613_1.time_ and arg_613_1.time_ <= var_616_1 + arg_616_0 then
				arg_613_1.var_.moveOldPos1029ui_story = var_616_0.localPosition
			end

			local var_616_2 = 0.001

			if var_616_1 <= arg_613_1.time_ and arg_613_1.time_ < var_616_1 + var_616_2 then
				local var_616_3 = (arg_613_1.time_ - var_616_1) / var_616_2
				local var_616_4 = Vector3.New(0, 100, 0)

				var_616_0.localPosition = Vector3.Lerp(arg_613_1.var_.moveOldPos1029ui_story, var_616_4, var_616_3)

				local var_616_5 = manager.ui.mainCamera.transform.position - var_616_0.position

				var_616_0.forward = Vector3.New(var_616_5.x, var_616_5.y, var_616_5.z)

				local var_616_6 = var_616_0.localEulerAngles

				var_616_6.z = 0
				var_616_6.x = 0
				var_616_0.localEulerAngles = var_616_6
			end

			if arg_613_1.time_ >= var_616_1 + var_616_2 and arg_613_1.time_ < var_616_1 + var_616_2 + arg_616_0 then
				var_616_0.localPosition = Vector3.New(0, 100, 0)

				local var_616_7 = manager.ui.mainCamera.transform.position - var_616_0.position

				var_616_0.forward = Vector3.New(var_616_7.x, var_616_7.y, var_616_7.z)

				local var_616_8 = var_616_0.localEulerAngles

				var_616_8.z = 0
				var_616_8.x = 0
				var_616_0.localEulerAngles = var_616_8
			end

			local var_616_9 = arg_613_1.actors_["1029ui_story"]
			local var_616_10 = 0

			if var_616_10 < arg_613_1.time_ and arg_613_1.time_ <= var_616_10 + arg_616_0 and not isNil(var_616_9) and arg_613_1.var_.characterEffect1029ui_story == nil then
				arg_613_1.var_.characterEffect1029ui_story = var_616_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_616_11 = 0.200000002980232

			if var_616_10 <= arg_613_1.time_ and arg_613_1.time_ < var_616_10 + var_616_11 and not isNil(var_616_9) then
				local var_616_12 = (arg_613_1.time_ - var_616_10) / var_616_11

				if arg_613_1.var_.characterEffect1029ui_story and not isNil(var_616_9) then
					local var_616_13 = Mathf.Lerp(0, 0.5, var_616_12)

					arg_613_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_613_1.var_.characterEffect1029ui_story.fillRatio = var_616_13
				end
			end

			if arg_613_1.time_ >= var_616_10 + var_616_11 and arg_613_1.time_ < var_616_10 + var_616_11 + arg_616_0 and not isNil(var_616_9) and arg_613_1.var_.characterEffect1029ui_story then
				local var_616_14 = 0.5

				arg_613_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_613_1.var_.characterEffect1029ui_story.fillRatio = var_616_14
			end

			local var_616_15 = 0
			local var_616_16 = 0.7

			if var_616_15 < arg_613_1.time_ and arg_613_1.time_ <= var_616_15 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, false)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_17 = arg_613_1:GetWordFromCfg(122531151)
				local var_616_18 = arg_613_1:FormatText(var_616_17.content)

				arg_613_1.text_.text = var_616_18

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_19 = 28
				local var_616_20 = utf8.len(var_616_18)
				local var_616_21 = var_616_19 <= 0 and var_616_16 or var_616_16 * (var_616_20 / var_616_19)

				if var_616_21 > 0 and var_616_16 < var_616_21 then
					arg_613_1.talkMaxDuration = var_616_21

					if var_616_21 + var_616_15 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_21 + var_616_15
					end
				end

				arg_613_1.text_.text = var_616_18
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_22 = math.max(var_616_16, arg_613_1.talkMaxDuration)

			if var_616_15 <= arg_613_1.time_ and arg_613_1.time_ < var_616_15 + var_616_22 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_15) / var_616_22

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_15 + var_616_22 and arg_613_1.time_ < var_616_15 + var_616_22 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_613_1:InitPlayNodeList()
	end,
	Play122531152 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 122531152
		arg_617_1.duration_ = 5

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play122531153(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 0
			local var_620_1 = 2.125

			if var_620_0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, false)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_2 = arg_617_1:GetWordFromCfg(122531152)
				local var_620_3 = arg_617_1:FormatText(var_620_2.content)

				arg_617_1.text_.text = var_620_3

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_4 = 85
				local var_620_5 = utf8.len(var_620_3)
				local var_620_6 = var_620_4 <= 0 and var_620_1 or var_620_1 * (var_620_5 / var_620_4)

				if var_620_6 > 0 and var_620_1 < var_620_6 then
					arg_617_1.talkMaxDuration = var_620_6

					if var_620_6 + var_620_0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_6 + var_620_0
					end
				end

				arg_617_1.text_.text = var_620_3
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)
				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_7 = math.max(var_620_1, arg_617_1.talkMaxDuration)

			if var_620_0 <= arg_617_1.time_ and arg_617_1.time_ < var_620_0 + var_620_7 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_0) / var_620_7

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_0 + var_620_7 and arg_617_1.time_ < var_620_0 + var_620_7 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play122531153 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 122531153
		arg_621_1.duration_ = 5

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play122531154(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = 0
			local var_624_1 = 1.225

			if var_624_0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_0 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, false)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_2 = arg_621_1:GetWordFromCfg(122531153)
				local var_624_3 = arg_621_1:FormatText(var_624_2.content)

				arg_621_1.text_.text = var_624_3

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_4 = 49
				local var_624_5 = utf8.len(var_624_3)
				local var_624_6 = var_624_4 <= 0 and var_624_1 or var_624_1 * (var_624_5 / var_624_4)

				if var_624_6 > 0 and var_624_1 < var_624_6 then
					arg_621_1.talkMaxDuration = var_624_6

					if var_624_6 + var_624_0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_6 + var_624_0
					end
				end

				arg_621_1.text_.text = var_624_3
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)
				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_7 = math.max(var_624_1, arg_621_1.talkMaxDuration)

			if var_624_0 <= arg_621_1.time_ and arg_621_1.time_ < var_624_0 + var_624_7 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_0) / var_624_7

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_0 + var_624_7 and arg_621_1.time_ < var_624_0 + var_624_7 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play122531154 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 122531154
		arg_625_1.duration_ = 5

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play122531155(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0
			local var_628_1 = 0.725

			if var_628_0 < arg_625_1.time_ and arg_625_1.time_ <= var_628_0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, false)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_2 = arg_625_1:GetWordFromCfg(122531154)
				local var_628_3 = arg_625_1:FormatText(var_628_2.content)

				arg_625_1.text_.text = var_628_3

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_4 = 29
				local var_628_5 = utf8.len(var_628_3)
				local var_628_6 = var_628_4 <= 0 and var_628_1 or var_628_1 * (var_628_5 / var_628_4)

				if var_628_6 > 0 and var_628_1 < var_628_6 then
					arg_625_1.talkMaxDuration = var_628_6

					if var_628_6 + var_628_0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_6 + var_628_0
					end
				end

				arg_625_1.text_.text = var_628_3
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)
				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_7 = math.max(var_628_1, arg_625_1.talkMaxDuration)

			if var_628_0 <= arg_625_1.time_ and arg_625_1.time_ < var_628_0 + var_628_7 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_0) / var_628_7

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_0 + var_628_7 and arg_625_1.time_ < var_628_0 + var_628_7 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play122531155 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 122531155
		arg_629_1.duration_ = 5

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play122531156(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = 0
			local var_632_1 = 0.8

			if var_632_0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_0 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, true)

				local var_632_2 = arg_629_1:FormatText(StoryNameCfg[7].name)

				arg_629_1.leftNameTxt_.text = var_632_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, true)
				arg_629_1.iconController_:SetSelectedState("hero")

				arg_629_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_629_1.callingController_:SetSelectedState("normal")

				arg_629_1.keyicon_.color = Color.New(1, 1, 1)
				arg_629_1.icon_.color = Color.New(1, 1, 1)

				local var_632_3 = arg_629_1:GetWordFromCfg(122531155)
				local var_632_4 = arg_629_1:FormatText(var_632_3.content)

				arg_629_1.text_.text = var_632_4

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_5 = 32
				local var_632_6 = utf8.len(var_632_4)
				local var_632_7 = var_632_5 <= 0 and var_632_1 or var_632_1 * (var_632_6 / var_632_5)

				if var_632_7 > 0 and var_632_1 < var_632_7 then
					arg_629_1.talkMaxDuration = var_632_7

					if var_632_7 + var_632_0 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_7 + var_632_0
					end
				end

				arg_629_1.text_.text = var_632_4
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_8 = math.max(var_632_1, arg_629_1.talkMaxDuration)

			if var_632_0 <= arg_629_1.time_ and arg_629_1.time_ < var_632_0 + var_632_8 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_0) / var_632_8

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_0 + var_632_8 and arg_629_1.time_ < var_632_0 + var_632_8 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play122531156 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 122531156
		arg_633_1.duration_ = 11.93

		local var_633_0 = {
			ja = 11.933,
			ko = 7.9,
			zh = 7.9
		}
		local var_633_1 = manager.audio:GetLocalizationFlag()

		if var_633_0[var_633_1] ~= nil then
			arg_633_1.duration_ = var_633_0[var_633_1]
		end

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play122531157(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			local var_636_0 = arg_633_1.actors_["1029ui_story"].transform
			local var_636_1 = 0

			if var_636_1 < arg_633_1.time_ and arg_633_1.time_ <= var_636_1 + arg_636_0 then
				arg_633_1.var_.moveOldPos1029ui_story = var_636_0.localPosition
			end

			local var_636_2 = 0.001

			if var_636_1 <= arg_633_1.time_ and arg_633_1.time_ < var_636_1 + var_636_2 then
				local var_636_3 = (arg_633_1.time_ - var_636_1) / var_636_2
				local var_636_4 = Vector3.New(0, -1.09, -6.2)

				var_636_0.localPosition = Vector3.Lerp(arg_633_1.var_.moveOldPos1029ui_story, var_636_4, var_636_3)

				local var_636_5 = manager.ui.mainCamera.transform.position - var_636_0.position

				var_636_0.forward = Vector3.New(var_636_5.x, var_636_5.y, var_636_5.z)

				local var_636_6 = var_636_0.localEulerAngles

				var_636_6.z = 0
				var_636_6.x = 0
				var_636_0.localEulerAngles = var_636_6
			end

			if arg_633_1.time_ >= var_636_1 + var_636_2 and arg_633_1.time_ < var_636_1 + var_636_2 + arg_636_0 then
				var_636_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_636_7 = manager.ui.mainCamera.transform.position - var_636_0.position

				var_636_0.forward = Vector3.New(var_636_7.x, var_636_7.y, var_636_7.z)

				local var_636_8 = var_636_0.localEulerAngles

				var_636_8.z = 0
				var_636_8.x = 0
				var_636_0.localEulerAngles = var_636_8
			end

			local var_636_9 = arg_633_1.actors_["1029ui_story"]
			local var_636_10 = 0

			if var_636_10 < arg_633_1.time_ and arg_633_1.time_ <= var_636_10 + arg_636_0 and not isNil(var_636_9) and arg_633_1.var_.characterEffect1029ui_story == nil then
				arg_633_1.var_.characterEffect1029ui_story = var_636_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_11 = 0.200000002980232

			if var_636_10 <= arg_633_1.time_ and arg_633_1.time_ < var_636_10 + var_636_11 and not isNil(var_636_9) then
				local var_636_12 = (arg_633_1.time_ - var_636_10) / var_636_11

				if arg_633_1.var_.characterEffect1029ui_story and not isNil(var_636_9) then
					arg_633_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_633_1.time_ >= var_636_10 + var_636_11 and arg_633_1.time_ < var_636_10 + var_636_11 + arg_636_0 and not isNil(var_636_9) and arg_633_1.var_.characterEffect1029ui_story then
				arg_633_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_636_13 = 0

			if var_636_13 < arg_633_1.time_ and arg_633_1.time_ <= var_636_13 + arg_636_0 then
				arg_633_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_636_14 = 0

			if var_636_14 < arg_633_1.time_ and arg_633_1.time_ <= var_636_14 + arg_636_0 then
				arg_633_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_636_15 = 0
			local var_636_16 = 0.95

			if var_636_15 < arg_633_1.time_ and arg_633_1.time_ <= var_636_15 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				local var_636_17 = arg_633_1:FormatText(StoryNameCfg[319].name)

				arg_633_1.leftNameTxt_.text = var_636_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_18 = arg_633_1:GetWordFromCfg(122531156)
				local var_636_19 = arg_633_1:FormatText(var_636_18.content)

				arg_633_1.text_.text = var_636_19

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_20 = 38
				local var_636_21 = utf8.len(var_636_19)
				local var_636_22 = var_636_20 <= 0 and var_636_16 or var_636_16 * (var_636_21 / var_636_20)

				if var_636_22 > 0 and var_636_16 < var_636_22 then
					arg_633_1.talkMaxDuration = var_636_22

					if var_636_22 + var_636_15 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_22 + var_636_15
					end
				end

				arg_633_1.text_.text = var_636_19
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531156", "story_v_out_122531.awb") ~= 0 then
					local var_636_23 = manager.audio:GetVoiceLength("story_v_out_122531", "122531156", "story_v_out_122531.awb") / 1000

					if var_636_23 + var_636_15 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_23 + var_636_15
					end

					if var_636_18.prefab_name ~= "" and arg_633_1.actors_[var_636_18.prefab_name] ~= nil then
						local var_636_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_18.prefab_name].transform, "story_v_out_122531", "122531156", "story_v_out_122531.awb")

						arg_633_1:RecordAudio("122531156", var_636_24)
						arg_633_1:RecordAudio("122531156", var_636_24)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_out_122531", "122531156", "story_v_out_122531.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_out_122531", "122531156", "story_v_out_122531.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_25 = math.max(var_636_16, arg_633_1.talkMaxDuration)

			if var_636_15 <= arg_633_1.time_ and arg_633_1.time_ < var_636_15 + var_636_25 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_15) / var_636_25

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_15 + var_636_25 and arg_633_1.time_ < var_636_15 + var_636_25 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_633_1:InitPlayNodeList()
	end,
	Play122531157 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 122531157
		arg_637_1.duration_ = 5

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play122531158(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = arg_637_1.actors_["1029ui_story"]
			local var_640_1 = 0

			if var_640_1 < arg_637_1.time_ and arg_637_1.time_ <= var_640_1 + arg_640_0 and not isNil(var_640_0) and arg_637_1.var_.characterEffect1029ui_story == nil then
				arg_637_1.var_.characterEffect1029ui_story = var_640_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_640_2 = 0.200000002980232

			if var_640_1 <= arg_637_1.time_ and arg_637_1.time_ < var_640_1 + var_640_2 and not isNil(var_640_0) then
				local var_640_3 = (arg_637_1.time_ - var_640_1) / var_640_2

				if arg_637_1.var_.characterEffect1029ui_story and not isNil(var_640_0) then
					local var_640_4 = Mathf.Lerp(0, 0.5, var_640_3)

					arg_637_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_637_1.var_.characterEffect1029ui_story.fillRatio = var_640_4
				end
			end

			if arg_637_1.time_ >= var_640_1 + var_640_2 and arg_637_1.time_ < var_640_1 + var_640_2 + arg_640_0 and not isNil(var_640_0) and arg_637_1.var_.characterEffect1029ui_story then
				local var_640_5 = 0.5

				arg_637_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_637_1.var_.characterEffect1029ui_story.fillRatio = var_640_5
			end

			local var_640_6 = 0
			local var_640_7 = 0.675

			if var_640_6 < arg_637_1.time_ and arg_637_1.time_ <= var_640_6 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				local var_640_8 = arg_637_1:FormatText(StoryNameCfg[7].name)

				arg_637_1.leftNameTxt_.text = var_640_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, true)
				arg_637_1.iconController_:SetSelectedState("hero")

				arg_637_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_637_1.callingController_:SetSelectedState("normal")

				arg_637_1.keyicon_.color = Color.New(1, 1, 1)
				arg_637_1.icon_.color = Color.New(1, 1, 1)

				local var_640_9 = arg_637_1:GetWordFromCfg(122531157)
				local var_640_10 = arg_637_1:FormatText(var_640_9.content)

				arg_637_1.text_.text = var_640_10

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_11 = 27
				local var_640_12 = utf8.len(var_640_10)
				local var_640_13 = var_640_11 <= 0 and var_640_7 or var_640_7 * (var_640_12 / var_640_11)

				if var_640_13 > 0 and var_640_7 < var_640_13 then
					arg_637_1.talkMaxDuration = var_640_13

					if var_640_13 + var_640_6 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_13 + var_640_6
					end
				end

				arg_637_1.text_.text = var_640_10
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)
				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_14 = math.max(var_640_7, arg_637_1.talkMaxDuration)

			if var_640_6 <= arg_637_1.time_ and arg_637_1.time_ < var_640_6 + var_640_14 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_6) / var_640_14

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_6 + var_640_14 and arg_637_1.time_ < var_640_6 + var_640_14 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play122531158 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 122531158
		arg_641_1.duration_ = 5

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play122531159(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = 0
			local var_644_1 = 0.175

			if var_644_0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_0 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				local var_644_2 = arg_641_1:FormatText(StoryNameCfg[7].name)

				arg_641_1.leftNameTxt_.text = var_644_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, true)
				arg_641_1.iconController_:SetSelectedState("hero")

				arg_641_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_641_1.callingController_:SetSelectedState("normal")

				arg_641_1.keyicon_.color = Color.New(1, 1, 1)
				arg_641_1.icon_.color = Color.New(1, 1, 1)

				local var_644_3 = arg_641_1:GetWordFromCfg(122531158)
				local var_644_4 = arg_641_1:FormatText(var_644_3.content)

				arg_641_1.text_.text = var_644_4

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_5 = 7
				local var_644_6 = utf8.len(var_644_4)
				local var_644_7 = var_644_5 <= 0 and var_644_1 or var_644_1 * (var_644_6 / var_644_5)

				if var_644_7 > 0 and var_644_1 < var_644_7 then
					arg_641_1.talkMaxDuration = var_644_7

					if var_644_7 + var_644_0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_7 + var_644_0
					end
				end

				arg_641_1.text_.text = var_644_4
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)
				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_8 = math.max(var_644_1, arg_641_1.talkMaxDuration)

			if var_644_0 <= arg_641_1.time_ and arg_641_1.time_ < var_644_0 + var_644_8 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_0) / var_644_8

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_0 + var_644_8 and arg_641_1.time_ < var_644_0 + var_644_8 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play122531159 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 122531159
		arg_645_1.duration_ = 11.1

		local var_645_0 = {
			ja = 11.1,
			ko = 7.3,
			zh = 7.3
		}
		local var_645_1 = manager.audio:GetLocalizationFlag()

		if var_645_0[var_645_1] ~= nil then
			arg_645_1.duration_ = var_645_0[var_645_1]
		end

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play122531160(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = arg_645_1.actors_["1029ui_story"]
			local var_648_1 = 0

			if var_648_1 < arg_645_1.time_ and arg_645_1.time_ <= var_648_1 + arg_648_0 and not isNil(var_648_0) and arg_645_1.var_.characterEffect1029ui_story == nil then
				arg_645_1.var_.characterEffect1029ui_story = var_648_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_648_2 = 0.200000002980232

			if var_648_1 <= arg_645_1.time_ and arg_645_1.time_ < var_648_1 + var_648_2 and not isNil(var_648_0) then
				local var_648_3 = (arg_645_1.time_ - var_648_1) / var_648_2

				if arg_645_1.var_.characterEffect1029ui_story and not isNil(var_648_0) then
					arg_645_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_645_1.time_ >= var_648_1 + var_648_2 and arg_645_1.time_ < var_648_1 + var_648_2 + arg_648_0 and not isNil(var_648_0) and arg_645_1.var_.characterEffect1029ui_story then
				arg_645_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_648_4 = 0

			if var_648_4 < arg_645_1.time_ and arg_645_1.time_ <= var_648_4 + arg_648_0 then
				arg_645_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_648_5 = 0

			if var_648_5 < arg_645_1.time_ and arg_645_1.time_ <= var_648_5 + arg_648_0 then
				arg_645_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_648_6 = 0
			local var_648_7 = 0.825

			if var_648_6 < arg_645_1.time_ and arg_645_1.time_ <= var_648_6 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				local var_648_8 = arg_645_1:FormatText(StoryNameCfg[319].name)

				arg_645_1.leftNameTxt_.text = var_648_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_9 = arg_645_1:GetWordFromCfg(122531159)
				local var_648_10 = arg_645_1:FormatText(var_648_9.content)

				arg_645_1.text_.text = var_648_10

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_11 = 33
				local var_648_12 = utf8.len(var_648_10)
				local var_648_13 = var_648_11 <= 0 and var_648_7 or var_648_7 * (var_648_12 / var_648_11)

				if var_648_13 > 0 and var_648_7 < var_648_13 then
					arg_645_1.talkMaxDuration = var_648_13

					if var_648_13 + var_648_6 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_13 + var_648_6
					end
				end

				arg_645_1.text_.text = var_648_10
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531159", "story_v_out_122531.awb") ~= 0 then
					local var_648_14 = manager.audio:GetVoiceLength("story_v_out_122531", "122531159", "story_v_out_122531.awb") / 1000

					if var_648_14 + var_648_6 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_14 + var_648_6
					end

					if var_648_9.prefab_name ~= "" and arg_645_1.actors_[var_648_9.prefab_name] ~= nil then
						local var_648_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_645_1.actors_[var_648_9.prefab_name].transform, "story_v_out_122531", "122531159", "story_v_out_122531.awb")

						arg_645_1:RecordAudio("122531159", var_648_15)
						arg_645_1:RecordAudio("122531159", var_648_15)
					else
						arg_645_1:AudioAction("play", "voice", "story_v_out_122531", "122531159", "story_v_out_122531.awb")
					end

					arg_645_1:RecordHistoryTalkVoice("story_v_out_122531", "122531159", "story_v_out_122531.awb")
				end

				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_16 = math.max(var_648_7, arg_645_1.talkMaxDuration)

			if var_648_6 <= arg_645_1.time_ and arg_645_1.time_ < var_648_6 + var_648_16 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_6) / var_648_16

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_6 + var_648_16 and arg_645_1.time_ < var_648_6 + var_648_16 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play122531160 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 122531160
		arg_649_1.duration_ = 11.63

		local var_649_0 = {
			ja = 11.633,
			ko = 8.766,
			zh = 8.766
		}
		local var_649_1 = manager.audio:GetLocalizationFlag()

		if var_649_0[var_649_1] ~= nil then
			arg_649_1.duration_ = var_649_0[var_649_1]
		end

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play122531161(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0

			if var_652_0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_0 + arg_652_0 then
				arg_649_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_1")
			end

			local var_652_1 = 0

			if var_652_1 < arg_649_1.time_ and arg_649_1.time_ <= var_652_1 + arg_652_0 then
				arg_649_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_652_2 = 0
			local var_652_3 = 0.8

			if var_652_2 < arg_649_1.time_ and arg_649_1.time_ <= var_652_2 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				local var_652_4 = arg_649_1:FormatText(StoryNameCfg[319].name)

				arg_649_1.leftNameTxt_.text = var_652_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_5 = arg_649_1:GetWordFromCfg(122531160)
				local var_652_6 = arg_649_1:FormatText(var_652_5.content)

				arg_649_1.text_.text = var_652_6

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_7 = 32
				local var_652_8 = utf8.len(var_652_6)
				local var_652_9 = var_652_7 <= 0 and var_652_3 or var_652_3 * (var_652_8 / var_652_7)

				if var_652_9 > 0 and var_652_3 < var_652_9 then
					arg_649_1.talkMaxDuration = var_652_9

					if var_652_9 + var_652_2 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_9 + var_652_2
					end
				end

				arg_649_1.text_.text = var_652_6
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531160", "story_v_out_122531.awb") ~= 0 then
					local var_652_10 = manager.audio:GetVoiceLength("story_v_out_122531", "122531160", "story_v_out_122531.awb") / 1000

					if var_652_10 + var_652_2 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_10 + var_652_2
					end

					if var_652_5.prefab_name ~= "" and arg_649_1.actors_[var_652_5.prefab_name] ~= nil then
						local var_652_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_5.prefab_name].transform, "story_v_out_122531", "122531160", "story_v_out_122531.awb")

						arg_649_1:RecordAudio("122531160", var_652_11)
						arg_649_1:RecordAudio("122531160", var_652_11)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_out_122531", "122531160", "story_v_out_122531.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_out_122531", "122531160", "story_v_out_122531.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_12 = math.max(var_652_3, arg_649_1.talkMaxDuration)

			if var_652_2 <= arg_649_1.time_ and arg_649_1.time_ < var_652_2 + var_652_12 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_2) / var_652_12

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_2 + var_652_12 and arg_649_1.time_ < var_652_2 + var_652_12 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play122531161 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 122531161
		arg_653_1.duration_ = 5.8

		local var_653_0 = {
			ja = 5.8,
			ko = 2.333,
			zh = 2.333
		}
		local var_653_1 = manager.audio:GetLocalizationFlag()

		if var_653_0[var_653_1] ~= nil then
			arg_653_1.duration_ = var_653_0[var_653_1]
		end

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play122531162(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = 0

			if var_656_0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_0 + arg_656_0 then
				arg_653_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_2")
			end

			local var_656_1 = 0
			local var_656_2 = 0.2

			if var_656_1 < arg_653_1.time_ and arg_653_1.time_ <= var_656_1 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				local var_656_3 = arg_653_1:FormatText(StoryNameCfg[319].name)

				arg_653_1.leftNameTxt_.text = var_656_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_4 = arg_653_1:GetWordFromCfg(122531161)
				local var_656_5 = arg_653_1:FormatText(var_656_4.content)

				arg_653_1.text_.text = var_656_5

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_6 = 8
				local var_656_7 = utf8.len(var_656_5)
				local var_656_8 = var_656_6 <= 0 and var_656_2 or var_656_2 * (var_656_7 / var_656_6)

				if var_656_8 > 0 and var_656_2 < var_656_8 then
					arg_653_1.talkMaxDuration = var_656_8

					if var_656_8 + var_656_1 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_8 + var_656_1
					end
				end

				arg_653_1.text_.text = var_656_5
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122531", "122531161", "story_v_out_122531.awb") ~= 0 then
					local var_656_9 = manager.audio:GetVoiceLength("story_v_out_122531", "122531161", "story_v_out_122531.awb") / 1000

					if var_656_9 + var_656_1 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_9 + var_656_1
					end

					if var_656_4.prefab_name ~= "" and arg_653_1.actors_[var_656_4.prefab_name] ~= nil then
						local var_656_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_653_1.actors_[var_656_4.prefab_name].transform, "story_v_out_122531", "122531161", "story_v_out_122531.awb")

						arg_653_1:RecordAudio("122531161", var_656_10)
						arg_653_1:RecordAudio("122531161", var_656_10)
					else
						arg_653_1:AudioAction("play", "voice", "story_v_out_122531", "122531161", "story_v_out_122531.awb")
					end

					arg_653_1:RecordHistoryTalkVoice("story_v_out_122531", "122531161", "story_v_out_122531.awb")
				end

				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_11 = math.max(var_656_2, arg_653_1.talkMaxDuration)

			if var_656_1 <= arg_653_1.time_ and arg_653_1.time_ < var_656_1 + var_656_11 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_1) / var_656_11

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_1 + var_656_11 and arg_653_1.time_ < var_656_1 + var_656_11 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play122531162 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 122531162
		arg_657_1.duration_ = 5

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play122531163(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = arg_657_1.actors_["1029ui_story"].transform
			local var_660_1 = 0

			if var_660_1 < arg_657_1.time_ and arg_657_1.time_ <= var_660_1 + arg_660_0 then
				arg_657_1.var_.moveOldPos1029ui_story = var_660_0.localPosition
			end

			local var_660_2 = 0.001

			if var_660_1 <= arg_657_1.time_ and arg_657_1.time_ < var_660_1 + var_660_2 then
				local var_660_3 = (arg_657_1.time_ - var_660_1) / var_660_2
				local var_660_4 = Vector3.New(0, 100, 0)

				var_660_0.localPosition = Vector3.Lerp(arg_657_1.var_.moveOldPos1029ui_story, var_660_4, var_660_3)

				local var_660_5 = manager.ui.mainCamera.transform.position - var_660_0.position

				var_660_0.forward = Vector3.New(var_660_5.x, var_660_5.y, var_660_5.z)

				local var_660_6 = var_660_0.localEulerAngles

				var_660_6.z = 0
				var_660_6.x = 0
				var_660_0.localEulerAngles = var_660_6
			end

			if arg_657_1.time_ >= var_660_1 + var_660_2 and arg_657_1.time_ < var_660_1 + var_660_2 + arg_660_0 then
				var_660_0.localPosition = Vector3.New(0, 100, 0)

				local var_660_7 = manager.ui.mainCamera.transform.position - var_660_0.position

				var_660_0.forward = Vector3.New(var_660_7.x, var_660_7.y, var_660_7.z)

				local var_660_8 = var_660_0.localEulerAngles

				var_660_8.z = 0
				var_660_8.x = 0
				var_660_0.localEulerAngles = var_660_8
			end

			local var_660_9 = arg_657_1.actors_["1029ui_story"]
			local var_660_10 = 0

			if var_660_10 < arg_657_1.time_ and arg_657_1.time_ <= var_660_10 + arg_660_0 and not isNil(var_660_9) and arg_657_1.var_.characterEffect1029ui_story == nil then
				arg_657_1.var_.characterEffect1029ui_story = var_660_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_11 = 0.200000002980232

			if var_660_10 <= arg_657_1.time_ and arg_657_1.time_ < var_660_10 + var_660_11 and not isNil(var_660_9) then
				local var_660_12 = (arg_657_1.time_ - var_660_10) / var_660_11

				if arg_657_1.var_.characterEffect1029ui_story and not isNil(var_660_9) then
					local var_660_13 = Mathf.Lerp(0, 0.5, var_660_12)

					arg_657_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_657_1.var_.characterEffect1029ui_story.fillRatio = var_660_13
				end
			end

			if arg_657_1.time_ >= var_660_10 + var_660_11 and arg_657_1.time_ < var_660_10 + var_660_11 + arg_660_0 and not isNil(var_660_9) and arg_657_1.var_.characterEffect1029ui_story then
				local var_660_14 = 0.5

				arg_657_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_657_1.var_.characterEffect1029ui_story.fillRatio = var_660_14
			end

			local var_660_15 = 0
			local var_660_16 = 1.225

			if var_660_15 < arg_657_1.time_ and arg_657_1.time_ <= var_660_15 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, false)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_17 = arg_657_1:GetWordFromCfg(122531162)
				local var_660_18 = arg_657_1:FormatText(var_660_17.content)

				arg_657_1.text_.text = var_660_18

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_19 = 49
				local var_660_20 = utf8.len(var_660_18)
				local var_660_21 = var_660_19 <= 0 and var_660_16 or var_660_16 * (var_660_20 / var_660_19)

				if var_660_21 > 0 and var_660_16 < var_660_21 then
					arg_657_1.talkMaxDuration = var_660_21

					if var_660_21 + var_660_15 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_21 + var_660_15
					end
				end

				arg_657_1.text_.text = var_660_18
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)
				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_22 = math.max(var_660_16, arg_657_1.talkMaxDuration)

			if var_660_15 <= arg_657_1.time_ and arg_657_1.time_ < var_660_15 + var_660_22 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_15) / var_660_22

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_15 + var_660_22 and arg_657_1.time_ < var_660_15 + var_660_22 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_657_1:InitPlayNodeList()
	end,
	Play122531163 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 122531163
		arg_661_1.duration_ = 5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play122531164(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = 0
			local var_664_1 = 0.6

			if var_664_0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_0 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				local var_664_2 = arg_661_1:FormatText(StoryNameCfg[7].name)

				arg_661_1.leftNameTxt_.text = var_664_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, true)
				arg_661_1.iconController_:SetSelectedState("hero")

				arg_661_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_661_1.callingController_:SetSelectedState("normal")

				arg_661_1.keyicon_.color = Color.New(1, 1, 1)
				arg_661_1.icon_.color = Color.New(1, 1, 1)

				local var_664_3 = arg_661_1:GetWordFromCfg(122531163)
				local var_664_4 = arg_661_1:FormatText(var_664_3.content)

				arg_661_1.text_.text = var_664_4

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_5 = 24
				local var_664_6 = utf8.len(var_664_4)
				local var_664_7 = var_664_5 <= 0 and var_664_1 or var_664_1 * (var_664_6 / var_664_5)

				if var_664_7 > 0 and var_664_1 < var_664_7 then
					arg_661_1.talkMaxDuration = var_664_7

					if var_664_7 + var_664_0 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_7 + var_664_0
					end
				end

				arg_661_1.text_.text = var_664_4
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_8 = math.max(var_664_1, arg_661_1.talkMaxDuration)

			if var_664_0 <= arg_661_1.time_ and arg_661_1.time_ < var_664_0 + var_664_8 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_0) / var_664_8

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_0 + var_664_8 and arg_661_1.time_ < var_664_0 + var_664_8 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play122531164 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 122531164
		arg_665_1.duration_ = 5

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play122531165(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = 0
			local var_668_1 = 0.575

			if var_668_0 < arg_665_1.time_ and arg_665_1.time_ <= var_668_0 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, false)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_2 = arg_665_1:GetWordFromCfg(122531164)
				local var_668_3 = arg_665_1:FormatText(var_668_2.content)

				arg_665_1.text_.text = var_668_3

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_4 = 23
				local var_668_5 = utf8.len(var_668_3)
				local var_668_6 = var_668_4 <= 0 and var_668_1 or var_668_1 * (var_668_5 / var_668_4)

				if var_668_6 > 0 and var_668_1 < var_668_6 then
					arg_665_1.talkMaxDuration = var_668_6

					if var_668_6 + var_668_0 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_6 + var_668_0
					end
				end

				arg_665_1.text_.text = var_668_3
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)
				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_7 = math.max(var_668_1, arg_665_1.talkMaxDuration)

			if var_668_0 <= arg_665_1.time_ and arg_665_1.time_ < var_668_0 + var_668_7 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_0) / var_668_7

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_0 + var_668_7 and arg_665_1.time_ < var_668_0 + var_668_7 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play122531165 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 122531165
		arg_669_1.duration_ = 5

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
			arg_669_1.auto_ = false
		end

		function arg_669_1.playNext_(arg_671_0)
			arg_669_1.onStoryFinished_()
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = 0
			local var_672_1 = 0.45

			if var_672_0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_0 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, false)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_669_1.iconTrs_.gameObject, false)
				arg_669_1.callingController_:SetSelectedState("normal")

				local var_672_2 = arg_669_1:GetWordFromCfg(122531165)
				local var_672_3 = arg_669_1:FormatText(var_672_2.content)

				arg_669_1.text_.text = var_672_3

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_4 = 18
				local var_672_5 = utf8.len(var_672_3)
				local var_672_6 = var_672_4 <= 0 and var_672_1 or var_672_1 * (var_672_5 / var_672_4)

				if var_672_6 > 0 and var_672_1 < var_672_6 then
					arg_669_1.talkMaxDuration = var_672_6

					if var_672_6 + var_672_0 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_6 + var_672_0
					end
				end

				arg_669_1.text_.text = var_672_3
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)
				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_7 = math.max(var_672_1, arg_669_1.talkMaxDuration)

			if var_672_0 <= arg_669_1.time_ and arg_669_1.time_ < var_672_0 + var_672_7 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_0) / var_672_7

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_0 + var_672_7 and arg_669_1.time_ < var_672_0 + var_672_7 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/ST42",
		"TextureConfig/Background/ST41",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST31"
	},
	voices = {
		"story_v_out_122531.awb"
	}
}
