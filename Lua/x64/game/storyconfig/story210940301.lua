return {
	Play1109403001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109403001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1109403002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST08"

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
				local var_4_5 = arg_1_1.bgs_.ST08

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
					if iter_4_0 ~= "ST08" then
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
			local var_4_23 = 0.2

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

			local var_4_28 = 1.8
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

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

			local var_4_34 = 2
			local var_4_35 = 0.8

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(1109403001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 32
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1109403002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1109403002
		arg_9_1.duration_ = 6.63

		local var_9_0 = {
			ja = 6.633,
			ko = 5.566,
			zh = 5.566
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
				arg_9_0:Play1109403003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1019ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1019ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1019ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1019ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["1019ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1019ui_story == nil then
				arg_9_1.var_.characterEffect1019ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1019ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1019ui_story then
				arg_9_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_20 = 0
			local var_12_21 = 0.7

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[47].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(1109403002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 28
				local var_12_26 = utf8.len(var_12_24)
				local var_12_27 = var_12_25 <= 0 and var_12_21 or var_12_21 * (var_12_26 / var_12_25)

				if var_12_27 > 0 and var_12_21 < var_12_27 then
					arg_9_1.talkMaxDuration = var_12_27

					if var_12_27 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_27 + var_12_20
					end
				end

				arg_9_1.text_.text = var_12_24
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403002", "story_v_side_new_1109403.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403002", "story_v_side_new_1109403.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_side_new_1109403", "1109403002", "story_v_side_new_1109403.awb")

						arg_9_1:RecordAudio("1109403002", var_12_29)
						arg_9_1:RecordAudio("1109403002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403002", "story_v_side_new_1109403.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403002", "story_v_side_new_1109403.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_30 = math.max(var_12_21, arg_9_1.talkMaxDuration)

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_30 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_20) / var_12_30

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_20 + var_12_30 and arg_9_1.time_ < var_12_20 + var_12_30 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play1109403003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1109403003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1109403004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1019ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1019ui_story == nil then
				arg_13_1.var_.characterEffect1019ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1019ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1019ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1019ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1019ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 0.1

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_8 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_9 = arg_13_1:GetWordFromCfg(1109403003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 4
				local var_16_12 = utf8.len(var_16_10)
				local var_16_13 = var_16_11 <= 0 and var_16_7 or var_16_7 * (var_16_12 / var_16_11)

				if var_16_13 > 0 and var_16_7 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_14 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_14 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_14

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_14 and arg_13_1.time_ < var_16_6 + var_16_14 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1109403004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1109403004
		arg_17_1.duration_ = 10.97

		local var_17_0 = {
			ja = 10.966,
			ko = 8.233,
			zh = 8.233
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1109403005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1019ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1019ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1019ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1019ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1019ui_story == nil then
				arg_17_1.var_.characterEffect1019ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect1019ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1019ui_story then
				arg_17_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_14 = 0
			local var_20_15 = 0.9

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_16 = arg_17_1:FormatText(StoryNameCfg[47].name)

				arg_17_1.leftNameTxt_.text = var_20_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_17 = arg_17_1:GetWordFromCfg(1109403004)
				local var_20_18 = arg_17_1:FormatText(var_20_17.content)

				arg_17_1.text_.text = var_20_18

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_19 = 36
				local var_20_20 = utf8.len(var_20_18)
				local var_20_21 = var_20_19 <= 0 and var_20_15 or var_20_15 * (var_20_20 / var_20_19)

				if var_20_21 > 0 and var_20_15 < var_20_21 then
					arg_17_1.talkMaxDuration = var_20_21

					if var_20_21 + var_20_14 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_21 + var_20_14
					end
				end

				arg_17_1.text_.text = var_20_18
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403004", "story_v_side_new_1109403.awb") ~= 0 then
					local var_20_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403004", "story_v_side_new_1109403.awb") / 1000

					if var_20_22 + var_20_14 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_22 + var_20_14
					end

					if var_20_17.prefab_name ~= "" and arg_17_1.actors_[var_20_17.prefab_name] ~= nil then
						local var_20_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_17.prefab_name].transform, "story_v_side_new_1109403", "1109403004", "story_v_side_new_1109403.awb")

						arg_17_1:RecordAudio("1109403004", var_20_23)
						arg_17_1:RecordAudio("1109403004", var_20_23)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403004", "story_v_side_new_1109403.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403004", "story_v_side_new_1109403.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_24 = math.max(var_20_15, arg_17_1.talkMaxDuration)

			if var_20_14 <= arg_17_1.time_ and arg_17_1.time_ < var_20_14 + var_20_24 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_14) / var_20_24

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_14 + var_20_24 and arg_17_1.time_ < var_20_14 + var_20_24 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play1109403005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1109403005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1109403006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1019ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1019ui_story == nil then
				arg_21_1.var_.characterEffect1019ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1019ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1019ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1019ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1019ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 0.5

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_8

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

				local var_24_9 = arg_21_1:GetWordFromCfg(1109403005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 20
				local var_24_12 = utf8.len(var_24_10)
				local var_24_13 = var_24_11 <= 0 and var_24_7 or var_24_7 * (var_24_12 / var_24_11)

				if var_24_13 > 0 and var_24_7 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_10
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_14 and arg_21_1.time_ < var_24_6 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1109403006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1109403006
		arg_25_1.duration_ = 8.83

		local var_25_0 = {
			ja = 8.8,
			ko = 8.833,
			zh = 8.833
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
				arg_25_0:Play1109403007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1019ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1019ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1019ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, 100, 0)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1019ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1019ui_story == nil then
				arg_25_1.var_.characterEffect1019ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1019ui_story and not isNil(var_28_9) then
					local var_28_13 = Mathf.Lerp(0, 0.5, var_28_12)

					arg_25_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1019ui_story.fillRatio = var_28_13
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1019ui_story then
				local var_28_14 = 0.5

				arg_25_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1019ui_story.fillRatio = var_28_14
			end

			local var_28_15 = 0
			local var_28_16 = 0.925

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_17 = arg_25_1:FormatText(StoryNameCfg[10].name)

				arg_25_1.leftNameTxt_.text = var_28_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_18 = arg_25_1:GetWordFromCfg(1109403006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_20 = 37
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403006", "story_v_side_new_1109403.awb") ~= 0 then
					local var_28_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403006", "story_v_side_new_1109403.awb") / 1000

					if var_28_23 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_15
					end

					if var_28_18.prefab_name ~= "" and arg_25_1.actors_[var_28_18.prefab_name] ~= nil then
						local var_28_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_18.prefab_name].transform, "story_v_side_new_1109403", "1109403006", "story_v_side_new_1109403.awb")

						arg_25_1:RecordAudio("1109403006", var_28_24)
						arg_25_1:RecordAudio("1109403006", var_28_24)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403006", "story_v_side_new_1109403.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403006", "story_v_side_new_1109403.awb")
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
				actorName = "1019ui_story",
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
	Play1109403007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1109403007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1109403008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.55

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_2

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

				local var_32_3 = arg_29_1:GetWordFromCfg(1109403007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 35
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1109403008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109403008
		arg_33_1.duration_ = 9

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1109403009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "B13"

			if arg_33_1.bgs_[var_36_0] == nil then
				local var_36_1 = Object.Instantiate(arg_33_1.paintGo_)

				var_36_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_36_0)
				var_36_1.name = var_36_0
				var_36_1.transform.parent = arg_33_1.stage_.transform
				var_36_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_[var_36_0] = var_36_1
			end

			local var_36_2 = 2

			if var_36_2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				local var_36_3 = manager.ui.mainCamera.transform.localPosition
				local var_36_4 = Vector3.New(0, 0, 10) + Vector3.New(var_36_3.x, var_36_3.y, 0)
				local var_36_5 = arg_33_1.bgs_.B13

				var_36_5.transform.localPosition = var_36_4
				var_36_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_6 = var_36_5:GetComponent("SpriteRenderer")

				if var_36_6 and var_36_6.sprite then
					local var_36_7 = (var_36_5.transform.localPosition - var_36_3).z
					local var_36_8 = manager.ui.mainCameraCom_
					local var_36_9 = 2 * var_36_7 * Mathf.Tan(var_36_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_36_10 = var_36_9 * var_36_8.aspect
					local var_36_11 = var_36_6.sprite.bounds.size.x
					local var_36_12 = var_36_6.sprite.bounds.size.y
					local var_36_13 = var_36_10 / var_36_11
					local var_36_14 = var_36_9 / var_36_12
					local var_36_15 = var_36_14 < var_36_13 and var_36_13 or var_36_14

					var_36_5.transform.localScale = Vector3.New(var_36_15, var_36_15, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "B13" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_17 = 2

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17
				local var_36_19 = Color.New(0, 0, 0)

				var_36_19.a = Mathf.Lerp(0, 1, var_36_18)
				arg_33_1.mask_.color = var_36_19
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 then
				local var_36_20 = Color.New(0, 0, 0)

				var_36_20.a = 1
				arg_33_1.mask_.color = var_36_20
			end

			local var_36_21 = 2

			if var_36_21 < arg_33_1.time_ and arg_33_1.time_ <= var_36_21 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_22 = 2

			if var_36_21 <= arg_33_1.time_ and arg_33_1.time_ < var_36_21 + var_36_22 then
				local var_36_23 = (arg_33_1.time_ - var_36_21) / var_36_22
				local var_36_24 = Color.New(0, 0, 0)

				var_36_24.a = Mathf.Lerp(1, 0, var_36_23)
				arg_33_1.mask_.color = var_36_24
			end

			if arg_33_1.time_ >= var_36_21 + var_36_22 and arg_33_1.time_ < var_36_21 + var_36_22 + arg_36_0 then
				local var_36_25 = Color.New(0, 0, 0)
				local var_36_26 = 0

				arg_33_1.mask_.enabled = false
				var_36_25.a = var_36_26
				arg_33_1.mask_.color = var_36_25
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_27 = 4
			local var_36_28 = 0.45

			if var_36_27 < arg_33_1.time_ and arg_33_1.time_ <= var_36_27 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_29 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_29:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_30 = arg_33_1:GetWordFromCfg(1109403008)
				local var_36_31 = arg_33_1:FormatText(var_36_30.content)

				arg_33_1.text_.text = var_36_31

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_32 = 18
				local var_36_33 = utf8.len(var_36_31)
				local var_36_34 = var_36_32 <= 0 and var_36_28 or var_36_28 * (var_36_33 / var_36_32)

				if var_36_34 > 0 and var_36_28 < var_36_34 then
					arg_33_1.talkMaxDuration = var_36_34
					var_36_27 = var_36_27 + 0.3

					if var_36_34 + var_36_27 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_34 + var_36_27
					end
				end

				arg_33_1.text_.text = var_36_31
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_35 = var_36_27 + 0.3
			local var_36_36 = math.max(var_36_28, arg_33_1.talkMaxDuration)

			if var_36_35 <= arg_33_1.time_ and arg_33_1.time_ < var_36_35 + var_36_36 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_35) / var_36_36

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_35 + var_36_36 and arg_33_1.time_ < var_36_35 + var_36_36 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1109403009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 1109403009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play1109403010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 1

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				local var_42_2 = "play"
				local var_42_3 = "effect"

				arg_39_1:AudioAction(var_42_2, var_42_3, "se_story_120_04", "se_story_120_04_knock", "")
			end

			local var_42_4 = 0
			local var_42_5 = 0.95

			if var_42_4 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_6 = arg_39_1:GetWordFromCfg(1109403009)
				local var_42_7 = arg_39_1:FormatText(var_42_6.content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_8 = 38
				local var_42_9 = utf8.len(var_42_7)
				local var_42_10 = var_42_8 <= 0 and var_42_5 or var_42_5 * (var_42_9 / var_42_8)

				if var_42_10 > 0 and var_42_5 < var_42_10 then
					arg_39_1.talkMaxDuration = var_42_10

					if var_42_10 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_11 = math.max(var_42_5, arg_39_1.talkMaxDuration)

			if var_42_4 <= arg_39_1.time_ and arg_39_1.time_ < var_42_4 + var_42_11 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_4) / var_42_11

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_4 + var_42_11 and arg_39_1.time_ < var_42_4 + var_42_11 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play1109403010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1109403010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play1109403011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.125

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_2 = arg_43_1:FormatText(StoryNameCfg[7].name)

				arg_43_1.leftNameTxt_.text = var_46_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:GetWordFromCfg(1109403010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 5
				local var_46_6 = utf8.len(var_46_4)
				local var_46_7 = var_46_5 <= 0 and var_46_1 or var_46_1 * (var_46_6 / var_46_5)

				if var_46_7 > 0 and var_46_1 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_8 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_8 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_8

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_8 and arg_43_1.time_ < var_46_0 + var_46_8 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play1109403011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1109403011
		arg_47_1.duration_ = 2.53

		local var_47_0 = {
			ja = 1.999999999999,
			ko = 2.533,
			zh = 2.533
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1109403012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = "1094ui_story"

			if arg_47_1.actors_[var_50_0] == nil then
				local var_50_1 = Asset.Load("Char/" .. "1094ui_story")

				if not isNil(var_50_1) then
					local var_50_2 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_47_1.stage_.transform)

					var_50_2.name = var_50_0
					var_50_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_47_1.actors_[var_50_0] = var_50_2

					local var_50_3 = var_50_2:GetComponentInChildren(typeof(CharacterEffect))

					var_50_3.enabled = true

					local var_50_4 = GameObjectTools.GetOrAddComponent(var_50_2, typeof(DynamicBoneHelper))

					if var_50_4 then
						var_50_4:EnableDynamicBone(false)
					end

					arg_47_1:ShowWeapon(var_50_3.transform, false)

					arg_47_1.var_[var_50_0 .. "Animator"] = var_50_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_47_1.var_[var_50_0 .. "Animator"].applyRootMotion = true
					arg_47_1.var_[var_50_0 .. "LipSync"] = var_50_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_50_5 = arg_47_1.actors_["1094ui_story"].transform
			local var_50_6 = 0

			if var_50_6 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.var_.moveOldPos1094ui_story = var_50_5.localPosition
			end

			local var_50_7 = 0.001

			if var_50_6 <= arg_47_1.time_ and arg_47_1.time_ < var_50_6 + var_50_7 then
				local var_50_8 = (arg_47_1.time_ - var_50_6) / var_50_7
				local var_50_9 = Vector3.New(0, -0.84, -6.1)

				var_50_5.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1094ui_story, var_50_9, var_50_8)

				local var_50_10 = manager.ui.mainCamera.transform.position - var_50_5.position

				var_50_5.forward = Vector3.New(var_50_10.x, var_50_10.y, var_50_10.z)

				local var_50_11 = var_50_5.localEulerAngles

				var_50_11.z = 0
				var_50_11.x = 0
				var_50_5.localEulerAngles = var_50_11
			end

			if arg_47_1.time_ >= var_50_6 + var_50_7 and arg_47_1.time_ < var_50_6 + var_50_7 + arg_50_0 then
				var_50_5.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_50_12 = manager.ui.mainCamera.transform.position - var_50_5.position

				var_50_5.forward = Vector3.New(var_50_12.x, var_50_12.y, var_50_12.z)

				local var_50_13 = var_50_5.localEulerAngles

				var_50_13.z = 0
				var_50_13.x = 0
				var_50_5.localEulerAngles = var_50_13
			end

			local var_50_14 = arg_47_1.actors_["1094ui_story"]
			local var_50_15 = 0

			if var_50_15 < arg_47_1.time_ and arg_47_1.time_ <= var_50_15 + arg_50_0 and not isNil(var_50_14) and arg_47_1.var_.characterEffect1094ui_story == nil then
				arg_47_1.var_.characterEffect1094ui_story = var_50_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_16 = 0.200000002980232

			if var_50_15 <= arg_47_1.time_ and arg_47_1.time_ < var_50_15 + var_50_16 and not isNil(var_50_14) then
				local var_50_17 = (arg_47_1.time_ - var_50_15) / var_50_16

				if arg_47_1.var_.characterEffect1094ui_story and not isNil(var_50_14) then
					arg_47_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_15 + var_50_16 and arg_47_1.time_ < var_50_15 + var_50_16 + arg_50_0 and not isNil(var_50_14) and arg_47_1.var_.characterEffect1094ui_story then
				arg_47_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_50_18 = 0

			if var_50_18 < arg_47_1.time_ and arg_47_1.time_ <= var_50_18 + arg_50_0 then
				arg_47_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_50_19 = 0

			if var_50_19 < arg_47_1.time_ and arg_47_1.time_ <= var_50_19 + arg_50_0 then
				arg_47_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_50_20 = 0
			local var_50_21 = 0.25

			if var_50_20 < arg_47_1.time_ and arg_47_1.time_ <= var_50_20 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_22 = arg_47_1:FormatText(StoryNameCfg[181].name)

				arg_47_1.leftNameTxt_.text = var_50_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_23 = arg_47_1:GetWordFromCfg(1109403011)
				local var_50_24 = arg_47_1:FormatText(var_50_23.content)

				arg_47_1.text_.text = var_50_24

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_25 = 10
				local var_50_26 = utf8.len(var_50_24)
				local var_50_27 = var_50_25 <= 0 and var_50_21 or var_50_21 * (var_50_26 / var_50_25)

				if var_50_27 > 0 and var_50_21 < var_50_27 then
					arg_47_1.talkMaxDuration = var_50_27

					if var_50_27 + var_50_20 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_27 + var_50_20
					end
				end

				arg_47_1.text_.text = var_50_24
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403011", "story_v_side_new_1109403.awb") ~= 0 then
					local var_50_28 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403011", "story_v_side_new_1109403.awb") / 1000

					if var_50_28 + var_50_20 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_28 + var_50_20
					end

					if var_50_23.prefab_name ~= "" and arg_47_1.actors_[var_50_23.prefab_name] ~= nil then
						local var_50_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_23.prefab_name].transform, "story_v_side_new_1109403", "1109403011", "story_v_side_new_1109403.awb")

						arg_47_1:RecordAudio("1109403011", var_50_29)
						arg_47_1:RecordAudio("1109403011", var_50_29)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403011", "story_v_side_new_1109403.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403011", "story_v_side_new_1109403.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_30 = math.max(var_50_21, arg_47_1.talkMaxDuration)

			if var_50_20 <= arg_47_1.time_ and arg_47_1.time_ < var_50_20 + var_50_30 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_20) / var_50_30

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_20 + var_50_30 and arg_47_1.time_ < var_50_20 + var_50_30 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play1109403012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1109403012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1109403013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1094ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1094ui_story == nil then
				arg_51_1.var_.characterEffect1094ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect1094ui_story and not isNil(var_54_0) then
					local var_54_4 = Mathf.Lerp(0, 0.5, var_54_3)

					arg_51_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1094ui_story.fillRatio = var_54_4
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1094ui_story then
				local var_54_5 = 0.5

				arg_51_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1094ui_story.fillRatio = var_54_5
			end

			local var_54_6 = 0
			local var_54_7 = 0.4

			if var_54_6 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_8 = arg_51_1:FormatText(StoryNameCfg[7].name)

				arg_51_1.leftNameTxt_.text = var_54_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_9 = arg_51_1:GetWordFromCfg(1109403012)
				local var_54_10 = arg_51_1:FormatText(var_54_9.content)

				arg_51_1.text_.text = var_54_10

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_11 = 16
				local var_54_12 = utf8.len(var_54_10)
				local var_54_13 = var_54_11 <= 0 and var_54_7 or var_54_7 * (var_54_12 / var_54_11)

				if var_54_13 > 0 and var_54_7 < var_54_13 then
					arg_51_1.talkMaxDuration = var_54_13

					if var_54_13 + var_54_6 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_6
					end
				end

				arg_51_1.text_.text = var_54_10
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_14 = math.max(var_54_7, arg_51_1.talkMaxDuration)

			if var_54_6 <= arg_51_1.time_ and arg_51_1.time_ < var_54_6 + var_54_14 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_6) / var_54_14

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_6 + var_54_14 and arg_51_1.time_ < var_54_6 + var_54_14 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play1109403013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1109403013
		arg_55_1.duration_ = 2

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1109403014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1094ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1094ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(0, -0.84, -6.1)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1094ui_story, var_58_4, var_58_3)

				local var_58_5 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_5.x, var_58_5.y, var_58_5.z)

				local var_58_6 = var_58_0.localEulerAngles

				var_58_6.z = 0
				var_58_6.x = 0
				var_58_0.localEulerAngles = var_58_6
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_58_7 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_7.x, var_58_7.y, var_58_7.z)

				local var_58_8 = var_58_0.localEulerAngles

				var_58_8.z = 0
				var_58_8.x = 0
				var_58_0.localEulerAngles = var_58_8
			end

			local var_58_9 = arg_55_1.actors_["1094ui_story"]
			local var_58_10 = 0

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1094ui_story == nil then
				arg_55_1.var_.characterEffect1094ui_story = var_58_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_11 = 0.200000002980232

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_11 and not isNil(var_58_9) then
				local var_58_12 = (arg_55_1.time_ - var_58_10) / var_58_11

				if arg_55_1.var_.characterEffect1094ui_story and not isNil(var_58_9) then
					arg_55_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_10 + var_58_11 and arg_55_1.time_ < var_58_10 + var_58_11 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1094ui_story then
				arg_55_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_58_13 = 0

			if var_58_13 < arg_55_1.time_ and arg_55_1.time_ <= var_58_13 + arg_58_0 then
				arg_55_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_14 = 0
			local var_58_15 = 0.1

			if var_58_14 < arg_55_1.time_ and arg_55_1.time_ <= var_58_14 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_16 = arg_55_1:FormatText(StoryNameCfg[181].name)

				arg_55_1.leftNameTxt_.text = var_58_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_17 = arg_55_1:GetWordFromCfg(1109403013)
				local var_58_18 = arg_55_1:FormatText(var_58_17.content)

				arg_55_1.text_.text = var_58_18

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_19 = 4
				local var_58_20 = utf8.len(var_58_18)
				local var_58_21 = var_58_19 <= 0 and var_58_15 or var_58_15 * (var_58_20 / var_58_19)

				if var_58_21 > 0 and var_58_15 < var_58_21 then
					arg_55_1.talkMaxDuration = var_58_21

					if var_58_21 + var_58_14 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_21 + var_58_14
					end
				end

				arg_55_1.text_.text = var_58_18
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403013", "story_v_side_new_1109403.awb") ~= 0 then
					local var_58_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403013", "story_v_side_new_1109403.awb") / 1000

					if var_58_22 + var_58_14 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_22 + var_58_14
					end

					if var_58_17.prefab_name ~= "" and arg_55_1.actors_[var_58_17.prefab_name] ~= nil then
						local var_58_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_17.prefab_name].transform, "story_v_side_new_1109403", "1109403013", "story_v_side_new_1109403.awb")

						arg_55_1:RecordAudio("1109403013", var_58_23)
						arg_55_1:RecordAudio("1109403013", var_58_23)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403013", "story_v_side_new_1109403.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403013", "story_v_side_new_1109403.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_24 = math.max(var_58_15, arg_55_1.talkMaxDuration)

			if var_58_14 <= arg_55_1.time_ and arg_55_1.time_ < var_58_14 + var_58_24 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_14) / var_58_24

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_14 + var_58_24 and arg_55_1.time_ < var_58_14 + var_58_24 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play1109403014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1109403014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1109403015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1094ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1094ui_story == nil then
				arg_59_1.var_.characterEffect1094ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1094ui_story and not isNil(var_62_0) then
					local var_62_4 = Mathf.Lerp(0, 0.5, var_62_3)

					arg_59_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1094ui_story.fillRatio = var_62_4
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1094ui_story then
				local var_62_5 = 0.5

				arg_59_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1094ui_story.fillRatio = var_62_5
			end

			local var_62_6 = 0
			local var_62_7 = 0.175

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_8 = arg_59_1:FormatText(StoryNameCfg[7].name)

				arg_59_1.leftNameTxt_.text = var_62_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_9 = arg_59_1:GetWordFromCfg(1109403014)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 7
				local var_62_12 = utf8.len(var_62_10)
				local var_62_13 = var_62_11 <= 0 and var_62_7 or var_62_7 * (var_62_12 / var_62_11)

				if var_62_13 > 0 and var_62_7 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_14 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_14 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_14

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_14 and arg_59_1.time_ < var_62_6 + var_62_14 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play1109403015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1109403015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1109403016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.575

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_2 = arg_63_1:GetWordFromCfg(1109403015)
				local var_66_3 = arg_63_1:FormatText(var_66_2.content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 23
				local var_66_5 = utf8.len(var_66_3)
				local var_66_6 = var_66_4 <= 0 and var_66_1 or var_66_1 * (var_66_5 / var_66_4)

				if var_66_6 > 0 and var_66_1 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_7 and arg_63_1.time_ < var_66_0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1109403016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1109403016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1109403017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.45

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[7].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(1109403016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 18
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_8 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_8 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_8

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_8 and arg_67_1.time_ < var_70_0 + var_70_8 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1109403017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1109403017
		arg_71_1.duration_ = 2.9

		local var_71_0 = {
			ja = 2.9,
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
				arg_71_0:Play1109403018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1094ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1094ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, -0.84, -6.1)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1094ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = arg_71_1.actors_["1094ui_story"]
			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1094ui_story == nil then
				arg_71_1.var_.characterEffect1094ui_story = var_74_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_11 = 0.200000002980232

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_11 and not isNil(var_74_9) then
				local var_74_12 = (arg_71_1.time_ - var_74_10) / var_74_11

				if arg_71_1.var_.characterEffect1094ui_story and not isNil(var_74_9) then
					arg_71_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_10 + var_74_11 and arg_71_1.time_ < var_74_10 + var_74_11 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1094ui_story then
				arg_71_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_74_13 = 0

			if var_74_13 < arg_71_1.time_ and arg_71_1.time_ <= var_74_13 + arg_74_0 then
				arg_71_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_74_14 = 0
			local var_74_15 = 0.125

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_16 = arg_71_1:FormatText(StoryNameCfg[181].name)

				arg_71_1.leftNameTxt_.text = var_74_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_17 = arg_71_1:GetWordFromCfg(1109403017)
				local var_74_18 = arg_71_1:FormatText(var_74_17.content)

				arg_71_1.text_.text = var_74_18

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_19 = 5
				local var_74_20 = utf8.len(var_74_18)
				local var_74_21 = var_74_19 <= 0 and var_74_15 or var_74_15 * (var_74_20 / var_74_19)

				if var_74_21 > 0 and var_74_15 < var_74_21 then
					arg_71_1.talkMaxDuration = var_74_21

					if var_74_21 + var_74_14 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_21 + var_74_14
					end
				end

				arg_71_1.text_.text = var_74_18
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403017", "story_v_side_new_1109403.awb") ~= 0 then
					local var_74_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403017", "story_v_side_new_1109403.awb") / 1000

					if var_74_22 + var_74_14 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_22 + var_74_14
					end

					if var_74_17.prefab_name ~= "" and arg_71_1.actors_[var_74_17.prefab_name] ~= nil then
						local var_74_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_17.prefab_name].transform, "story_v_side_new_1109403", "1109403017", "story_v_side_new_1109403.awb")

						arg_71_1:RecordAudio("1109403017", var_74_23)
						arg_71_1:RecordAudio("1109403017", var_74_23)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403017", "story_v_side_new_1109403.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403017", "story_v_side_new_1109403.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_24 = math.max(var_74_15, arg_71_1.talkMaxDuration)

			if var_74_14 <= arg_71_1.time_ and arg_71_1.time_ < var_74_14 + var_74_24 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_14) / var_74_24

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_14 + var_74_24 and arg_71_1.time_ < var_74_14 + var_74_24 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play1109403018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1109403018
		arg_75_1.duration_ = 9

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1109403019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = "ST01"

			if arg_75_1.bgs_[var_78_0] == nil then
				local var_78_1 = Object.Instantiate(arg_75_1.paintGo_)

				var_78_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_78_0)
				var_78_1.name = var_78_0
				var_78_1.transform.parent = arg_75_1.stage_.transform
				var_78_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.bgs_[var_78_0] = var_78_1
			end

			local var_78_2 = 2

			if var_78_2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				if arg_75_0.sceneSettingEffect_ then
					arg_75_1.sceneSettingEffect_.enabled = false
				end

				arg_75_1.sceneSettingGo_:SetActive(true)

				local var_78_3 = manager.ui.mainCamera.transform.localPosition
				local var_78_4 = Vector3.New(0, 0, 10) + Vector3.New(var_78_3.x, var_78_3.y, 0)
				local var_78_5 = arg_75_1.bgs_.ST01

				var_78_5.transform.localPosition = var_78_4
				var_78_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_78_6 = var_78_5:GetComponent("SpriteRenderer")

				if var_78_6 and var_78_6.sprite then
					local var_78_7 = (var_78_5.transform.localPosition - var_78_3).z
					local var_78_8 = manager.ui.mainCameraCom_
					local var_78_9 = 2 * var_78_7 * Mathf.Tan(var_78_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_78_10 = var_78_9 * var_78_8.aspect
					local var_78_11 = var_78_6.sprite.bounds.size.x
					local var_78_12 = var_78_6.sprite.bounds.size.y
					local var_78_13 = var_78_10 / var_78_11
					local var_78_14 = var_78_9 / var_78_12
					local var_78_15 = var_78_14 < var_78_13 and var_78_13 or var_78_14

					var_78_5.transform.localScale = Vector3.New(var_78_15, var_78_15, 0)
				end

				for iter_78_0, iter_78_1 in pairs(arg_75_1.bgs_) do
					if iter_78_0 ~= "ST01" then
						iter_78_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_78_16 = 0

			if var_78_16 < arg_75_1.time_ and arg_75_1.time_ <= var_78_16 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_17 = 2

			if var_78_16 <= arg_75_1.time_ and arg_75_1.time_ < var_78_16 + var_78_17 then
				local var_78_18 = (arg_75_1.time_ - var_78_16) / var_78_17
				local var_78_19 = Color.New(0, 0, 0)

				var_78_19.a = Mathf.Lerp(0, 1, var_78_18)
				arg_75_1.mask_.color = var_78_19
			end

			if arg_75_1.time_ >= var_78_16 + var_78_17 and arg_75_1.time_ < var_78_16 + var_78_17 + arg_78_0 then
				local var_78_20 = Color.New(0, 0, 0)

				var_78_20.a = 1
				arg_75_1.mask_.color = var_78_20
			end

			local var_78_21 = 2

			if var_78_21 < arg_75_1.time_ and arg_75_1.time_ <= var_78_21 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_22 = 2

			if var_78_21 <= arg_75_1.time_ and arg_75_1.time_ < var_78_21 + var_78_22 then
				local var_78_23 = (arg_75_1.time_ - var_78_21) / var_78_22
				local var_78_24 = Color.New(0, 0, 0)

				var_78_24.a = Mathf.Lerp(1, 0, var_78_23)
				arg_75_1.mask_.color = var_78_24
			end

			if arg_75_1.time_ >= var_78_21 + var_78_22 and arg_75_1.time_ < var_78_21 + var_78_22 + arg_78_0 then
				local var_78_25 = Color.New(0, 0, 0)
				local var_78_26 = 0

				arg_75_1.mask_.enabled = false
				var_78_25.a = var_78_26
				arg_75_1.mask_.color = var_78_25
			end

			local var_78_27 = arg_75_1.actors_["1094ui_story"]
			local var_78_28 = 0

			if var_78_28 < arg_75_1.time_ and arg_75_1.time_ <= var_78_28 + arg_78_0 and not isNil(var_78_27) and arg_75_1.var_.characterEffect1094ui_story == nil then
				arg_75_1.var_.characterEffect1094ui_story = var_78_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_29 = 0.200000002980232

			if var_78_28 <= arg_75_1.time_ and arg_75_1.time_ < var_78_28 + var_78_29 and not isNil(var_78_27) then
				local var_78_30 = (arg_75_1.time_ - var_78_28) / var_78_29

				if arg_75_1.var_.characterEffect1094ui_story and not isNil(var_78_27) then
					local var_78_31 = Mathf.Lerp(0, 0.5, var_78_30)

					arg_75_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1094ui_story.fillRatio = var_78_31
				end
			end

			if arg_75_1.time_ >= var_78_28 + var_78_29 and arg_75_1.time_ < var_78_28 + var_78_29 + arg_78_0 and not isNil(var_78_27) and arg_75_1.var_.characterEffect1094ui_story then
				local var_78_32 = 0.5

				arg_75_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1094ui_story.fillRatio = var_78_32
			end

			local var_78_33 = arg_75_1.actors_["1094ui_story"].transform
			local var_78_34 = 0

			if var_78_34 < arg_75_1.time_ and arg_75_1.time_ <= var_78_34 + arg_78_0 then
				arg_75_1.var_.moveOldPos1094ui_story = var_78_33.localPosition
			end

			local var_78_35 = 0.001

			if var_78_34 <= arg_75_1.time_ and arg_75_1.time_ < var_78_34 + var_78_35 then
				local var_78_36 = (arg_75_1.time_ - var_78_34) / var_78_35
				local var_78_37 = Vector3.New(0, 100, 0)

				var_78_33.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1094ui_story, var_78_37, var_78_36)

				local var_78_38 = manager.ui.mainCamera.transform.position - var_78_33.position

				var_78_33.forward = Vector3.New(var_78_38.x, var_78_38.y, var_78_38.z)

				local var_78_39 = var_78_33.localEulerAngles

				var_78_39.z = 0
				var_78_39.x = 0
				var_78_33.localEulerAngles = var_78_39
			end

			if arg_75_1.time_ >= var_78_34 + var_78_35 and arg_75_1.time_ < var_78_34 + var_78_35 + arg_78_0 then
				var_78_33.localPosition = Vector3.New(0, 100, 0)

				local var_78_40 = manager.ui.mainCamera.transform.position - var_78_33.position

				var_78_33.forward = Vector3.New(var_78_40.x, var_78_40.y, var_78_40.z)

				local var_78_41 = var_78_33.localEulerAngles

				var_78_41.z = 0
				var_78_41.x = 0
				var_78_33.localEulerAngles = var_78_41
			end

			if arg_75_1.frameCnt_ <= 1 then
				arg_75_1.dialog_:SetActive(false)
			end

			local var_78_42 = 4
			local var_78_43 = 0.625

			if var_78_42 < arg_75_1.time_ and arg_75_1.time_ <= var_78_42 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				arg_75_1.dialog_:SetActive(true)

				arg_75_1.dialogCg_.alpha = 0

				local var_78_44 = LeanTween.value(arg_75_1.dialog_, 0, 1, 0.3)

				var_78_44:setOnUpdate(LuaHelper.FloatAction(function(arg_79_0)
					arg_75_1.dialogCg_.alpha = arg_79_0
				end))
				var_78_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_75_1.dialog_)
					var_78_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_75_1.duration_ = arg_75_1.duration_ + 0.3

				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_45 = arg_75_1:GetWordFromCfg(1109403018)
				local var_78_46 = arg_75_1:FormatText(var_78_45.content)

				arg_75_1.text_.text = var_78_46

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_47 = 25
				local var_78_48 = utf8.len(var_78_46)
				local var_78_49 = var_78_47 <= 0 and var_78_43 or var_78_43 * (var_78_48 / var_78_47)

				if var_78_49 > 0 and var_78_43 < var_78_49 then
					arg_75_1.talkMaxDuration = var_78_49
					var_78_42 = var_78_42 + 0.3

					if var_78_49 + var_78_42 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_49 + var_78_42
					end
				end

				arg_75_1.text_.text = var_78_46
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_50 = var_78_42 + 0.3
			local var_78_51 = math.max(var_78_43, arg_75_1.talkMaxDuration)

			if var_78_50 <= arg_75_1.time_ and arg_75_1.time_ < var_78_50 + var_78_51 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_50) / var_78_51

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_50 + var_78_51 and arg_75_1.time_ < var_78_50 + var_78_51 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play1109403019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1109403019
		arg_81_1.duration_ = 5.57

		local var_81_0 = {
			ja = 5.566,
			ko = 3.366,
			zh = 3.366
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1109403020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.45

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[177].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(1109403019)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 18
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403019", "story_v_side_new_1109403.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403019", "story_v_side_new_1109403.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_side_new_1109403", "1109403019", "story_v_side_new_1109403.awb")

						arg_81_1:RecordAudio("1109403019", var_84_9)
						arg_81_1:RecordAudio("1109403019", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403019", "story_v_side_new_1109403.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403019", "story_v_side_new_1109403.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1109403020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1109403020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1109403021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.85

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:GetWordFromCfg(1109403020)
				local var_88_3 = arg_85_1:FormatText(var_88_2.content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 34
				local var_88_5 = utf8.len(var_88_3)
				local var_88_6 = var_88_4 <= 0 and var_88_1 or var_88_1 * (var_88_5 / var_88_4)

				if var_88_6 > 0 and var_88_1 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_7 and arg_85_1.time_ < var_88_0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1109403021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1109403021
		arg_89_1.duration_ = 7.33

		local var_89_0 = {
			ja = 7.333,
			ko = 3.933,
			zh = 3.933
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1109403022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.45

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[177].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(1109403021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 18
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403021", "story_v_side_new_1109403.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403021", "story_v_side_new_1109403.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_side_new_1109403", "1109403021", "story_v_side_new_1109403.awb")

						arg_89_1:RecordAudio("1109403021", var_92_9)
						arg_89_1:RecordAudio("1109403021", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403021", "story_v_side_new_1109403.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403021", "story_v_side_new_1109403.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1109403022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1109403022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1109403023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.425

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(1109403022)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 17
				local var_96_5 = utf8.len(var_96_3)
				local var_96_6 = var_96_4 <= 0 and var_96_1 or var_96_1 * (var_96_5 / var_96_4)

				if var_96_6 > 0 and var_96_1 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_7 and arg_93_1.time_ < var_96_0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1109403023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1109403023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1109403024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.4

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(1109403023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 16
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1109403024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1109403024
		arg_101_1.duration_ = 2.47

		local var_101_0 = {
			ja = 1.133,
			ko = 2.466,
			zh = 2.466
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1109403025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1094ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1094ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, -0.84, -6.1)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1094ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1094ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1094ui_story == nil then
				arg_101_1.var_.characterEffect1094ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect1094ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1094ui_story then
				arg_101_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_15 = 0
			local var_104_16 = 0.15

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_17 = arg_101_1:FormatText(StoryNameCfg[181].name)

				arg_101_1.leftNameTxt_.text = var_104_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_18 = arg_101_1:GetWordFromCfg(1109403024)
				local var_104_19 = arg_101_1:FormatText(var_104_18.content)

				arg_101_1.text_.text = var_104_19

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_20 = 6
				local var_104_21 = utf8.len(var_104_19)
				local var_104_22 = var_104_20 <= 0 and var_104_16 or var_104_16 * (var_104_21 / var_104_20)

				if var_104_22 > 0 and var_104_16 < var_104_22 then
					arg_101_1.talkMaxDuration = var_104_22

					if var_104_22 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_22 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_19
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403024", "story_v_side_new_1109403.awb") ~= 0 then
					local var_104_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403024", "story_v_side_new_1109403.awb") / 1000

					if var_104_23 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_15
					end

					if var_104_18.prefab_name ~= "" and arg_101_1.actors_[var_104_18.prefab_name] ~= nil then
						local var_104_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_18.prefab_name].transform, "story_v_side_new_1109403", "1109403024", "story_v_side_new_1109403.awb")

						arg_101_1:RecordAudio("1109403024", var_104_24)
						arg_101_1:RecordAudio("1109403024", var_104_24)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403024", "story_v_side_new_1109403.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403024", "story_v_side_new_1109403.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_25 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_25 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_15) / var_104_25

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_15 + var_104_25 and arg_101_1.time_ < var_104_15 + var_104_25 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play1109403025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1109403025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1109403026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1094ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1094ui_story == nil then
				arg_105_1.var_.characterEffect1094ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1094ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1094ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1094ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1094ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 1.1

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_8 = arg_105_1:FormatText(StoryNameCfg[7].name)

				arg_105_1.leftNameTxt_.text = var_108_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_9 = arg_105_1:GetWordFromCfg(1109403025)
				local var_108_10 = arg_105_1:FormatText(var_108_9.content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 44
				local var_108_12 = utf8.len(var_108_10)
				local var_108_13 = var_108_11 <= 0 and var_108_7 or var_108_7 * (var_108_12 / var_108_11)

				if var_108_13 > 0 and var_108_7 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_14 and arg_105_1.time_ < var_108_6 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1109403026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1109403026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1109403027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.65

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_2 = arg_109_1:GetWordFromCfg(1109403026)
				local var_112_3 = arg_109_1:FormatText(var_112_2.content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 26
				local var_112_5 = utf8.len(var_112_3)
				local var_112_6 = var_112_4 <= 0 and var_112_1 or var_112_1 * (var_112_5 / var_112_4)

				if var_112_6 > 0 and var_112_1 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_7 and arg_109_1.time_ < var_112_0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1109403027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1109403027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1109403028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.575

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[7].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:GetWordFromCfg(1109403027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 23
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_8 and arg_113_1.time_ < var_116_0 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1109403028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1109403028
		arg_117_1.duration_ = 11.07

		local var_117_0 = {
			ja = 11.066,
			ko = 6.633,
			zh = 6.633
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1109403029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.75

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[177].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:GetWordFromCfg(1109403028)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 30
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403028", "story_v_side_new_1109403.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403028", "story_v_side_new_1109403.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_side_new_1109403", "1109403028", "story_v_side_new_1109403.awb")

						arg_117_1:RecordAudio("1109403028", var_120_9)
						arg_117_1:RecordAudio("1109403028", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403028", "story_v_side_new_1109403.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403028", "story_v_side_new_1109403.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1109403029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1109403029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1109403030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.725

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[7].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:GetWordFromCfg(1109403029)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 29
				local var_124_6 = utf8.len(var_124_4)
				local var_124_7 = var_124_5 <= 0 and var_124_1 or var_124_1 * (var_124_6 / var_124_5)

				if var_124_7 > 0 and var_124_1 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_8 and arg_121_1.time_ < var_124_0 + var_124_8 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1109403030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1109403030
		arg_125_1.duration_ = 2

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1109403031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1094ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1094ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, -0.84, -6.1)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1094ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["1094ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1094ui_story == nil then
				arg_125_1.var_.characterEffect1094ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect1094ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1094ui_story then
				arg_125_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_128_13 = 0

			if var_128_13 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_14 = 0
			local var_128_15 = 0.075

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_16 = arg_125_1:FormatText(StoryNameCfg[181].name)

				arg_125_1.leftNameTxt_.text = var_128_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_17 = arg_125_1:GetWordFromCfg(1109403030)
				local var_128_18 = arg_125_1:FormatText(var_128_17.content)

				arg_125_1.text_.text = var_128_18

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_19 = 3
				local var_128_20 = utf8.len(var_128_18)
				local var_128_21 = var_128_19 <= 0 and var_128_15 or var_128_15 * (var_128_20 / var_128_19)

				if var_128_21 > 0 and var_128_15 < var_128_21 then
					arg_125_1.talkMaxDuration = var_128_21

					if var_128_21 + var_128_14 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_21 + var_128_14
					end
				end

				arg_125_1.text_.text = var_128_18
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403030", "story_v_side_new_1109403.awb") ~= 0 then
					local var_128_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403030", "story_v_side_new_1109403.awb") / 1000

					if var_128_22 + var_128_14 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_22 + var_128_14
					end

					if var_128_17.prefab_name ~= "" and arg_125_1.actors_[var_128_17.prefab_name] ~= nil then
						local var_128_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_17.prefab_name].transform, "story_v_side_new_1109403", "1109403030", "story_v_side_new_1109403.awb")

						arg_125_1:RecordAudio("1109403030", var_128_23)
						arg_125_1:RecordAudio("1109403030", var_128_23)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403030", "story_v_side_new_1109403.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403030", "story_v_side_new_1109403.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_24 = math.max(var_128_15, arg_125_1.talkMaxDuration)

			if var_128_14 <= arg_125_1.time_ and arg_125_1.time_ < var_128_14 + var_128_24 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_14) / var_128_24

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_14 + var_128_24 and arg_125_1.time_ < var_128_14 + var_128_24 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play1109403031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1109403031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1109403032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1094ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1094ui_story == nil then
				arg_129_1.var_.characterEffect1094ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1094ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1094ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1094ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1094ui_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 0.4

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(1109403031)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 16
				local var_132_11 = utf8.len(var_132_9)
				local var_132_12 = var_132_10 <= 0 and var_132_7 or var_132_7 * (var_132_11 / var_132_10)

				if var_132_12 > 0 and var_132_7 < var_132_12 then
					arg_129_1.talkMaxDuration = var_132_12

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_13 and arg_129_1.time_ < var_132_6 + var_132_13 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1109403032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1109403032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1109403033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.425

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[7].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:GetWordFromCfg(1109403032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 17
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_8 and arg_133_1.time_ < var_136_0 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1109403033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1109403033
		arg_137_1.duration_ = 2

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1109403034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1094ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1094ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0, -0.84, -6.1)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1094ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = arg_137_1.actors_["1094ui_story"]
			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect1094ui_story == nil then
				arg_137_1.var_.characterEffect1094ui_story = var_140_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_11 = 0.200000002980232

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_11 and not isNil(var_140_9) then
				local var_140_12 = (arg_137_1.time_ - var_140_10) / var_140_11

				if arg_137_1.var_.characterEffect1094ui_story and not isNil(var_140_9) then
					arg_137_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_10 + var_140_11 and arg_137_1.time_ < var_140_10 + var_140_11 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect1094ui_story then
				arg_137_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_140_13 = 0

			if var_140_13 < arg_137_1.time_ and arg_137_1.time_ <= var_140_13 + arg_140_0 then
				arg_137_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_140_14 = 0
			local var_140_15 = 0.075

			if var_140_14 < arg_137_1.time_ and arg_137_1.time_ <= var_140_14 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_16 = arg_137_1:FormatText(StoryNameCfg[181].name)

				arg_137_1.leftNameTxt_.text = var_140_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_17 = arg_137_1:GetWordFromCfg(1109403033)
				local var_140_18 = arg_137_1:FormatText(var_140_17.content)

				arg_137_1.text_.text = var_140_18

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_19 = 3
				local var_140_20 = utf8.len(var_140_18)
				local var_140_21 = var_140_19 <= 0 and var_140_15 or var_140_15 * (var_140_20 / var_140_19)

				if var_140_21 > 0 and var_140_15 < var_140_21 then
					arg_137_1.talkMaxDuration = var_140_21

					if var_140_21 + var_140_14 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_21 + var_140_14
					end
				end

				arg_137_1.text_.text = var_140_18
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403033", "story_v_side_new_1109403.awb") ~= 0 then
					local var_140_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403033", "story_v_side_new_1109403.awb") / 1000

					if var_140_22 + var_140_14 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_22 + var_140_14
					end

					if var_140_17.prefab_name ~= "" and arg_137_1.actors_[var_140_17.prefab_name] ~= nil then
						local var_140_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_17.prefab_name].transform, "story_v_side_new_1109403", "1109403033", "story_v_side_new_1109403.awb")

						arg_137_1:RecordAudio("1109403033", var_140_23)
						arg_137_1:RecordAudio("1109403033", var_140_23)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403033", "story_v_side_new_1109403.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403033", "story_v_side_new_1109403.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_24 = math.max(var_140_15, arg_137_1.talkMaxDuration)

			if var_140_14 <= arg_137_1.time_ and arg_137_1.time_ < var_140_14 + var_140_24 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_14) / var_140_24

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_14 + var_140_24 and arg_137_1.time_ < var_140_14 + var_140_24 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play1109403034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1109403034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1109403035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1094ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1094ui_story == nil then
				arg_141_1.var_.characterEffect1094ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1094ui_story and not isNil(var_144_0) then
					local var_144_4 = Mathf.Lerp(0, 0.5, var_144_3)

					arg_141_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1094ui_story.fillRatio = var_144_4
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1094ui_story then
				local var_144_5 = 0.5

				arg_141_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1094ui_story.fillRatio = var_144_5
			end

			local var_144_6 = 0

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_144_7 = 0
			local var_144_8 = 0.7

			if var_144_7 < arg_141_1.time_ and arg_141_1.time_ <= var_144_7 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_9 = arg_141_1:GetWordFromCfg(1109403034)
				local var_144_10 = arg_141_1:FormatText(var_144_9.content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 28
				local var_144_12 = utf8.len(var_144_10)
				local var_144_13 = var_144_11 <= 0 and var_144_8 or var_144_8 * (var_144_12 / var_144_11)

				if var_144_13 > 0 and var_144_8 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_7 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_7
					end
				end

				arg_141_1.text_.text = var_144_10
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_8, arg_141_1.talkMaxDuration)

			if var_144_7 <= arg_141_1.time_ and arg_141_1.time_ < var_144_7 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_7) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_7 + var_144_14 and arg_141_1.time_ < var_144_7 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1109403035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1109403035
		arg_145_1.duration_ = 2.3

		local var_145_0 = {
			ja = 2.3,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1109403036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1094ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1094ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, -0.84, -6.1)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1094ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["1094ui_story"]
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect1094ui_story == nil then
				arg_145_1.var_.characterEffect1094ui_story = var_148_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_11 = 0.200000002980232

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 and not isNil(var_148_9) then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11

				if arg_145_1.var_.characterEffect1094ui_story and not isNil(var_148_9) then
					arg_145_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect1094ui_story then
				arg_145_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_148_13 = 0

			if var_148_13 < arg_145_1.time_ and arg_145_1.time_ <= var_148_13 + arg_148_0 then
				arg_145_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_148_14 = 0
			local var_148_15 = 0.1

			if var_148_14 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_16 = arg_145_1:FormatText(StoryNameCfg[181].name)

				arg_145_1.leftNameTxt_.text = var_148_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_17 = arg_145_1:GetWordFromCfg(1109403035)
				local var_148_18 = arg_145_1:FormatText(var_148_17.content)

				arg_145_1.text_.text = var_148_18

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_19 = 4
				local var_148_20 = utf8.len(var_148_18)
				local var_148_21 = var_148_19 <= 0 and var_148_15 or var_148_15 * (var_148_20 / var_148_19)

				if var_148_21 > 0 and var_148_15 < var_148_21 then
					arg_145_1.talkMaxDuration = var_148_21

					if var_148_21 + var_148_14 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_21 + var_148_14
					end
				end

				arg_145_1.text_.text = var_148_18
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403035", "story_v_side_new_1109403.awb") ~= 0 then
					local var_148_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403035", "story_v_side_new_1109403.awb") / 1000

					if var_148_22 + var_148_14 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_22 + var_148_14
					end

					if var_148_17.prefab_name ~= "" and arg_145_1.actors_[var_148_17.prefab_name] ~= nil then
						local var_148_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_17.prefab_name].transform, "story_v_side_new_1109403", "1109403035", "story_v_side_new_1109403.awb")

						arg_145_1:RecordAudio("1109403035", var_148_23)
						arg_145_1:RecordAudio("1109403035", var_148_23)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403035", "story_v_side_new_1109403.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403035", "story_v_side_new_1109403.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_24 = math.max(var_148_15, arg_145_1.talkMaxDuration)

			if var_148_14 <= arg_145_1.time_ and arg_145_1.time_ < var_148_14 + var_148_24 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_14) / var_148_24

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_14 + var_148_24 and arg_145_1.time_ < var_148_14 + var_148_24 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play1109403036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1109403036
		arg_149_1.duration_ = 4.77

		local var_149_0 = {
			ja = 4.766,
			ko = 2.433,
			zh = 2.433
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1109403037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1094ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1094ui_story == nil then
				arg_149_1.var_.characterEffect1094ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect1094ui_story and not isNil(var_152_0) then
					local var_152_4 = Mathf.Lerp(0, 0.5, var_152_3)

					arg_149_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1094ui_story.fillRatio = var_152_4
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1094ui_story then
				local var_152_5 = 0.5

				arg_149_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1094ui_story.fillRatio = var_152_5
			end

			local var_152_6 = 0
			local var_152_7 = 0.175

			if var_152_6 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_8 = arg_149_1:FormatText(StoryNameCfg[36].name)

				arg_149_1.leftNameTxt_.text = var_152_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_9 = arg_149_1:GetWordFromCfg(1109403036)
				local var_152_10 = arg_149_1:FormatText(var_152_9.content)

				arg_149_1.text_.text = var_152_10

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 7
				local var_152_12 = utf8.len(var_152_10)
				local var_152_13 = var_152_11 <= 0 and var_152_7 or var_152_7 * (var_152_12 / var_152_11)

				if var_152_13 > 0 and var_152_7 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_10
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403036", "story_v_side_new_1109403.awb") ~= 0 then
					local var_152_14 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403036", "story_v_side_new_1109403.awb") / 1000

					if var_152_14 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_14 + var_152_6
					end

					if var_152_9.prefab_name ~= "" and arg_149_1.actors_[var_152_9.prefab_name] ~= nil then
						local var_152_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_9.prefab_name].transform, "story_v_side_new_1109403", "1109403036", "story_v_side_new_1109403.awb")

						arg_149_1:RecordAudio("1109403036", var_152_15)
						arg_149_1:RecordAudio("1109403036", var_152_15)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403036", "story_v_side_new_1109403.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403036", "story_v_side_new_1109403.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_16 and arg_149_1.time_ < var_152_6 + var_152_16 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1109403037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1109403037
		arg_153_1.duration_ = 9.77

		local var_153_0 = {
			ja = 9.766,
			ko = 4.033,
			zh = 4.033
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1109403038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.5

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[177].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(1109403037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 20
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403037", "story_v_side_new_1109403.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403037", "story_v_side_new_1109403.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_side_new_1109403", "1109403037", "story_v_side_new_1109403.awb")

						arg_153_1:RecordAudio("1109403037", var_156_9)
						arg_153_1:RecordAudio("1109403037", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403037", "story_v_side_new_1109403.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403037", "story_v_side_new_1109403.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1109403038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1109403038
		arg_157_1.duration_ = 2

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1109403039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			local var_160_1 = 0
			local var_160_2 = 0.05

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_3 = arg_157_1:FormatText(StoryNameCfg[435].name)

				arg_157_1.leftNameTxt_.text = var_160_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_4 = arg_157_1:GetWordFromCfg(1109403038)
				local var_160_5 = arg_157_1:FormatText(var_160_4.content)

				arg_157_1.text_.text = var_160_5

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 2
				local var_160_7 = utf8.len(var_160_5)
				local var_160_8 = var_160_6 <= 0 and var_160_2 or var_160_2 * (var_160_7 / var_160_6)

				if var_160_8 > 0 and var_160_2 < var_160_8 then
					arg_157_1.talkMaxDuration = var_160_8

					if var_160_8 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_5
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403038", "story_v_side_new_1109403.awb") ~= 0 then
					local var_160_9 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403038", "story_v_side_new_1109403.awb") / 1000

					if var_160_9 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_1
					end

					if var_160_4.prefab_name ~= "" and arg_157_1.actors_[var_160_4.prefab_name] ~= nil then
						local var_160_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_4.prefab_name].transform, "story_v_side_new_1109403", "1109403038", "story_v_side_new_1109403.awb")

						arg_157_1:RecordAudio("1109403038", var_160_10)
						arg_157_1:RecordAudio("1109403038", var_160_10)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403038", "story_v_side_new_1109403.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403038", "story_v_side_new_1109403.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_11 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_11 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_11

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_11 and arg_157_1.time_ < var_160_1 + var_160_11 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1109403039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1109403039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1109403040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.325

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:GetWordFromCfg(1109403039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 13
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_8 and arg_161_1.time_ < var_164_0 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play1109403040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1109403040
		arg_165_1.duration_ = 5.4

		local var_165_0 = {
			ja = 5.4,
			ko = 1.766,
			zh = 1.766
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1109403041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1094ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1094ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(0, -0.84, -6.1)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1094ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = arg_165_1.actors_["1094ui_story"]
			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1094ui_story == nil then
				arg_165_1.var_.characterEffect1094ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.200000002980232

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 and not isNil(var_168_9) then
				local var_168_12 = (arg_165_1.time_ - var_168_10) / var_168_11

				if arg_165_1.var_.characterEffect1094ui_story and not isNil(var_168_9) then
					arg_165_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1094ui_story then
				arg_165_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_168_13 = 0
			local var_168_14 = 0.175

			if var_168_13 < arg_165_1.time_ and arg_165_1.time_ <= var_168_13 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_15 = arg_165_1:FormatText(StoryNameCfg[181].name)

				arg_165_1.leftNameTxt_.text = var_168_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_16 = arg_165_1:GetWordFromCfg(1109403040)
				local var_168_17 = arg_165_1:FormatText(var_168_16.content)

				arg_165_1.text_.text = var_168_17

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_18 = 7
				local var_168_19 = utf8.len(var_168_17)
				local var_168_20 = var_168_18 <= 0 and var_168_14 or var_168_14 * (var_168_19 / var_168_18)

				if var_168_20 > 0 and var_168_14 < var_168_20 then
					arg_165_1.talkMaxDuration = var_168_20

					if var_168_20 + var_168_13 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_20 + var_168_13
					end
				end

				arg_165_1.text_.text = var_168_17
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403040", "story_v_side_new_1109403.awb") ~= 0 then
					local var_168_21 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403040", "story_v_side_new_1109403.awb") / 1000

					if var_168_21 + var_168_13 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_21 + var_168_13
					end

					if var_168_16.prefab_name ~= "" and arg_165_1.actors_[var_168_16.prefab_name] ~= nil then
						local var_168_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_16.prefab_name].transform, "story_v_side_new_1109403", "1109403040", "story_v_side_new_1109403.awb")

						arg_165_1:RecordAudio("1109403040", var_168_22)
						arg_165_1:RecordAudio("1109403040", var_168_22)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403040", "story_v_side_new_1109403.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403040", "story_v_side_new_1109403.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_23 = math.max(var_168_14, arg_165_1.talkMaxDuration)

			if var_168_13 <= arg_165_1.time_ and arg_165_1.time_ < var_168_13 + var_168_23 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_13) / var_168_23

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_13 + var_168_23 and arg_165_1.time_ < var_168_13 + var_168_23 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play1109403041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1109403041
		arg_169_1.duration_ = 3.6

		local var_169_0 = {
			ja = 3.333,
			ko = 3.6,
			zh = 3.6
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1109403042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1094ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1094ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0, -0.84, -6.1)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1094ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["1094ui_story"]
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1094ui_story == nil then
				arg_169_1.var_.characterEffect1094ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 and not isNil(var_172_9) then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11

				if arg_169_1.var_.characterEffect1094ui_story and not isNil(var_172_9) then
					arg_169_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1094ui_story then
				arg_169_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_172_13 = 0
			local var_172_14 = 0.325

			if var_172_13 < arg_169_1.time_ and arg_169_1.time_ <= var_172_13 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_15 = arg_169_1:FormatText(StoryNameCfg[181].name)

				arg_169_1.leftNameTxt_.text = var_172_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_16 = arg_169_1:GetWordFromCfg(1109403041)
				local var_172_17 = arg_169_1:FormatText(var_172_16.content)

				arg_169_1.text_.text = var_172_17

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_18 = 13
				local var_172_19 = utf8.len(var_172_17)
				local var_172_20 = var_172_18 <= 0 and var_172_14 or var_172_14 * (var_172_19 / var_172_18)

				if var_172_20 > 0 and var_172_14 < var_172_20 then
					arg_169_1.talkMaxDuration = var_172_20

					if var_172_20 + var_172_13 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_20 + var_172_13
					end
				end

				arg_169_1.text_.text = var_172_17
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403041", "story_v_side_new_1109403.awb") ~= 0 then
					local var_172_21 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403041", "story_v_side_new_1109403.awb") / 1000

					if var_172_21 + var_172_13 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_21 + var_172_13
					end

					if var_172_16.prefab_name ~= "" and arg_169_1.actors_[var_172_16.prefab_name] ~= nil then
						local var_172_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_16.prefab_name].transform, "story_v_side_new_1109403", "1109403041", "story_v_side_new_1109403.awb")

						arg_169_1:RecordAudio("1109403041", var_172_22)
						arg_169_1:RecordAudio("1109403041", var_172_22)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403041", "story_v_side_new_1109403.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403041", "story_v_side_new_1109403.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_23 = math.max(var_172_14, arg_169_1.talkMaxDuration)

			if var_172_13 <= arg_169_1.time_ and arg_169_1.time_ < var_172_13 + var_172_23 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_13) / var_172_23

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_13 + var_172_23 and arg_169_1.time_ < var_172_13 + var_172_23 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play1109403042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1109403042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1109403043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1094ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1094ui_story == nil then
				arg_173_1.var_.characterEffect1094ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1094ui_story and not isNil(var_176_0) then
					local var_176_4 = Mathf.Lerp(0, 0.5, var_176_3)

					arg_173_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1094ui_story.fillRatio = var_176_4
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1094ui_story then
				local var_176_5 = 0.5

				arg_173_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1094ui_story.fillRatio = var_176_5
			end

			local var_176_6 = 0
			local var_176_7 = 0.3

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_8 = arg_173_1:GetWordFromCfg(1109403042)
				local var_176_9 = arg_173_1:FormatText(var_176_8.content)

				arg_173_1.text_.text = var_176_9

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_10 = 12
				local var_176_11 = utf8.len(var_176_9)
				local var_176_12 = var_176_10 <= 0 and var_176_7 or var_176_7 * (var_176_11 / var_176_10)

				if var_176_12 > 0 and var_176_7 < var_176_12 then
					arg_173_1.talkMaxDuration = var_176_12

					if var_176_12 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_12 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_9
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_13 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_13 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_13

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_13 and arg_173_1.time_ < var_176_6 + var_176_13 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1109403043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1109403043
		arg_177_1.duration_ = 4.1

		local var_177_0 = {
			ja = 4.1,
			ko = 2,
			zh = 2
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1109403044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.05

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[36].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(1109403043)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 2
				local var_180_6 = utf8.len(var_180_4)
				local var_180_7 = var_180_5 <= 0 and var_180_1 or var_180_1 * (var_180_6 / var_180_5)

				if var_180_7 > 0 and var_180_1 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403043", "story_v_side_new_1109403.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403043", "story_v_side_new_1109403.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_side_new_1109403", "1109403043", "story_v_side_new_1109403.awb")

						arg_177_1:RecordAudio("1109403043", var_180_9)
						arg_177_1:RecordAudio("1109403043", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403043", "story_v_side_new_1109403.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403043", "story_v_side_new_1109403.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_10 and arg_177_1.time_ < var_180_0 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1109403044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1109403044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1109403045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1094ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1094ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0, 100, 0)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1094ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, 100, 0)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = 0
			local var_184_10 = 0.575

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_11 = arg_181_1:GetWordFromCfg(1109403044)
				local var_184_12 = arg_181_1:FormatText(var_184_11.content)

				arg_181_1.text_.text = var_184_12

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 23
				local var_184_14 = utf8.len(var_184_12)
				local var_184_15 = var_184_13 <= 0 and var_184_10 or var_184_10 * (var_184_14 / var_184_13)

				if var_184_15 > 0 and var_184_10 < var_184_15 then
					arg_181_1.talkMaxDuration = var_184_15

					if var_184_15 + var_184_9 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_15 + var_184_9
					end
				end

				arg_181_1.text_.text = var_184_12
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_10, arg_181_1.talkMaxDuration)

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_9) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_9 + var_184_16 and arg_181_1.time_ < var_184_9 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play1109403045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1109403045
		arg_185_1.duration_ = 4.03

		local var_185_0 = {
			ja = 4.033,
			ko = 3.5,
			zh = 3.5
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1109403046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1094ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1094ui_story = var_188_0.localPosition
			end

			local var_188_2 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2
				local var_188_4 = Vector3.New(0, -0.84, -6.1)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1094ui_story, var_188_4, var_188_3)

				local var_188_5 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_5.x, var_188_5.y, var_188_5.z)

				local var_188_6 = var_188_0.localEulerAngles

				var_188_6.z = 0
				var_188_6.x = 0
				var_188_0.localEulerAngles = var_188_6
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_188_7 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_7.x, var_188_7.y, var_188_7.z)

				local var_188_8 = var_188_0.localEulerAngles

				var_188_8.z = 0
				var_188_8.x = 0
				var_188_0.localEulerAngles = var_188_8
			end

			local var_188_9 = arg_185_1.actors_["1094ui_story"]
			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect1094ui_story == nil then
				arg_185_1.var_.characterEffect1094ui_story = var_188_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_11 = 0.200000002980232

			if var_188_10 <= arg_185_1.time_ and arg_185_1.time_ < var_188_10 + var_188_11 and not isNil(var_188_9) then
				local var_188_12 = (arg_185_1.time_ - var_188_10) / var_188_11

				if arg_185_1.var_.characterEffect1094ui_story and not isNil(var_188_9) then
					arg_185_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_10 + var_188_11 and arg_185_1.time_ < var_188_10 + var_188_11 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect1094ui_story then
				arg_185_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_188_13 = 0

			if var_188_13 < arg_185_1.time_ and arg_185_1.time_ <= var_188_13 + arg_188_0 then
				arg_185_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_188_14 = 0

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				arg_185_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_188_15 = 0
			local var_188_16 = 0.275

			if var_188_15 < arg_185_1.time_ and arg_185_1.time_ <= var_188_15 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_17 = arg_185_1:FormatText(StoryNameCfg[181].name)

				arg_185_1.leftNameTxt_.text = var_188_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_18 = arg_185_1:GetWordFromCfg(1109403045)
				local var_188_19 = arg_185_1:FormatText(var_188_18.content)

				arg_185_1.text_.text = var_188_19

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_20 = 11
				local var_188_21 = utf8.len(var_188_19)
				local var_188_22 = var_188_20 <= 0 and var_188_16 or var_188_16 * (var_188_21 / var_188_20)

				if var_188_22 > 0 and var_188_16 < var_188_22 then
					arg_185_1.talkMaxDuration = var_188_22

					if var_188_22 + var_188_15 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_22 + var_188_15
					end
				end

				arg_185_1.text_.text = var_188_19
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403045", "story_v_side_new_1109403.awb") ~= 0 then
					local var_188_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403045", "story_v_side_new_1109403.awb") / 1000

					if var_188_23 + var_188_15 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_23 + var_188_15
					end

					if var_188_18.prefab_name ~= "" and arg_185_1.actors_[var_188_18.prefab_name] ~= nil then
						local var_188_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_18.prefab_name].transform, "story_v_side_new_1109403", "1109403045", "story_v_side_new_1109403.awb")

						arg_185_1:RecordAudio("1109403045", var_188_24)
						arg_185_1:RecordAudio("1109403045", var_188_24)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403045", "story_v_side_new_1109403.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403045", "story_v_side_new_1109403.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_25 = math.max(var_188_16, arg_185_1.talkMaxDuration)

			if var_188_15 <= arg_185_1.time_ and arg_185_1.time_ < var_188_15 + var_188_25 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_15) / var_188_25

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_15 + var_188_25 and arg_185_1.time_ < var_188_15 + var_188_25 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play1109403046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1109403046
		arg_189_1.duration_ = 10.63

		local var_189_0 = {
			ja = 10.633,
			ko = 6.1,
			zh = 6.1
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1109403047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1094ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1094ui_story == nil then
				arg_189_1.var_.characterEffect1094ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect1094ui_story and not isNil(var_192_0) then
					local var_192_4 = Mathf.Lerp(0, 0.5, var_192_3)

					arg_189_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1094ui_story.fillRatio = var_192_4
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1094ui_story then
				local var_192_5 = 0.5

				arg_189_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1094ui_story.fillRatio = var_192_5
			end

			local var_192_6 = 0
			local var_192_7 = 0.675

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_8 = arg_189_1:FormatText(StoryNameCfg[177].name)

				arg_189_1.leftNameTxt_.text = var_192_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_9 = arg_189_1:GetWordFromCfg(1109403046)
				local var_192_10 = arg_189_1:FormatText(var_192_9.content)

				arg_189_1.text_.text = var_192_10

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 27
				local var_192_12 = utf8.len(var_192_10)
				local var_192_13 = var_192_11 <= 0 and var_192_7 or var_192_7 * (var_192_12 / var_192_11)

				if var_192_13 > 0 and var_192_7 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13

					if var_192_13 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_10
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403046", "story_v_side_new_1109403.awb") ~= 0 then
					local var_192_14 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403046", "story_v_side_new_1109403.awb") / 1000

					if var_192_14 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_14 + var_192_6
					end

					if var_192_9.prefab_name ~= "" and arg_189_1.actors_[var_192_9.prefab_name] ~= nil then
						local var_192_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_9.prefab_name].transform, "story_v_side_new_1109403", "1109403046", "story_v_side_new_1109403.awb")

						arg_189_1:RecordAudio("1109403046", var_192_15)
						arg_189_1:RecordAudio("1109403046", var_192_15)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403046", "story_v_side_new_1109403.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403046", "story_v_side_new_1109403.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_16 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_16 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_16

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_16 and arg_189_1.time_ < var_192_6 + var_192_16 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1109403047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1109403047
		arg_193_1.duration_ = 8.03

		local var_193_0 = {
			ja = 8.033,
			ko = 3.433,
			zh = 3.433
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1109403048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.35

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[177].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_3 = arg_193_1:GetWordFromCfg(1109403047)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 14
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403047", "story_v_side_new_1109403.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403047", "story_v_side_new_1109403.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_side_new_1109403", "1109403047", "story_v_side_new_1109403.awb")

						arg_193_1:RecordAudio("1109403047", var_196_9)
						arg_193_1:RecordAudio("1109403047", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403047", "story_v_side_new_1109403.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403047", "story_v_side_new_1109403.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_10 and arg_193_1.time_ < var_196_0 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1109403048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1109403048
		arg_197_1.duration_ = 16.4

		local var_197_0 = {
			ja = 16.4,
			ko = 8.8,
			zh = 8.8
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1109403049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.925

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[177].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(1109403048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 37
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403048", "story_v_side_new_1109403.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403048", "story_v_side_new_1109403.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_side_new_1109403", "1109403048", "story_v_side_new_1109403.awb")

						arg_197_1:RecordAudio("1109403048", var_200_9)
						arg_197_1:RecordAudio("1109403048", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403048", "story_v_side_new_1109403.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403048", "story_v_side_new_1109403.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_10 and arg_197_1.time_ < var_200_0 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1109403049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1109403049
		arg_201_1.duration_ = 14.4

		local var_201_0 = {
			ja = 14.4,
			ko = 9.533,
			zh = 9.533
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1109403050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 1.175

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[177].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:GetWordFromCfg(1109403049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 47
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_1 or var_204_1 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_1 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403049", "story_v_side_new_1109403.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403049", "story_v_side_new_1109403.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_side_new_1109403", "1109403049", "story_v_side_new_1109403.awb")

						arg_201_1:RecordAudio("1109403049", var_204_9)
						arg_201_1:RecordAudio("1109403049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403049", "story_v_side_new_1109403.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403049", "story_v_side_new_1109403.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_10 and arg_201_1.time_ < var_204_0 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1109403050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1109403050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1109403051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.2

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[7].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:GetWordFromCfg(1109403050)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 8
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_8 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_8 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_8

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_8 and arg_205_1.time_ < var_208_0 + var_208_8 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play1109403051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1109403051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1109403052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.65

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_2 = arg_209_1:GetWordFromCfg(1109403051)
				local var_212_3 = arg_209_1:FormatText(var_212_2.content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 26
				local var_212_5 = utf8.len(var_212_3)
				local var_212_6 = var_212_4 <= 0 and var_212_1 or var_212_1 * (var_212_5 / var_212_4)

				if var_212_6 > 0 and var_212_1 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_3
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_7 and arg_209_1.time_ < var_212_0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1109403052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1109403052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1109403053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.425

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[7].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(1109403052)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 17
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_8 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_8 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_8

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_8 and arg_213_1.time_ < var_216_0 + var_216_8 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1109403053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1109403053
		arg_217_1.duration_ = 0.2

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"

			SetActive(arg_217_1.choicesGo_, true)

			for iter_218_0, iter_218_1 in ipairs(arg_217_1.choices_) do
				local var_218_0 = iter_218_0 <= 1

				SetActive(iter_218_1.go, var_218_0)
			end

			arg_217_1.choices_[1].txt.text = arg_217_1:FormatText(StoryChoiceCfg[408].name)
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1109403054(arg_217_1)
			end

			arg_217_1:RecordChoiceLog(1109403053, 408)
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			local var_220_1 = 0.200000002980232

			if arg_217_1.time_ >= var_220_0 + var_220_1 and arg_217_1.time_ < var_220_0 + var_220_1 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1109403054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1109403054
		arg_221_1.duration_ = 2.9

		local var_221_0 = {
			ja = 2.066,
			ko = 2.9,
			zh = 2.9
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1109403055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1094ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1094ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0, -0.84, -6.1)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1094ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = arg_221_1.actors_["1094ui_story"]
			local var_224_10 = 0

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1094ui_story == nil then
				arg_221_1.var_.characterEffect1094ui_story = var_224_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_11 = 0.200000002980232

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_11 and not isNil(var_224_9) then
				local var_224_12 = (arg_221_1.time_ - var_224_10) / var_224_11

				if arg_221_1.var_.characterEffect1094ui_story and not isNil(var_224_9) then
					arg_221_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_10 + var_224_11 and arg_221_1.time_ < var_224_10 + var_224_11 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1094ui_story then
				arg_221_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_224_13 = 0

			if var_224_13 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				arg_221_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_224_14 = 0

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_224_15 = 0
			local var_224_16 = 0.275

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_17 = arg_221_1:FormatText(StoryNameCfg[181].name)

				arg_221_1.leftNameTxt_.text = var_224_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_18 = arg_221_1:GetWordFromCfg(1109403054)
				local var_224_19 = arg_221_1:FormatText(var_224_18.content)

				arg_221_1.text_.text = var_224_19

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_20 = 11
				local var_224_21 = utf8.len(var_224_19)
				local var_224_22 = var_224_20 <= 0 and var_224_16 or var_224_16 * (var_224_21 / var_224_20)

				if var_224_22 > 0 and var_224_16 < var_224_22 then
					arg_221_1.talkMaxDuration = var_224_22

					if var_224_22 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_22 + var_224_15
					end
				end

				arg_221_1.text_.text = var_224_19
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403054", "story_v_side_new_1109403.awb") ~= 0 then
					local var_224_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403054", "story_v_side_new_1109403.awb") / 1000

					if var_224_23 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_23 + var_224_15
					end

					if var_224_18.prefab_name ~= "" and arg_221_1.actors_[var_224_18.prefab_name] ~= nil then
						local var_224_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_18.prefab_name].transform, "story_v_side_new_1109403", "1109403054", "story_v_side_new_1109403.awb")

						arg_221_1:RecordAudio("1109403054", var_224_24)
						arg_221_1:RecordAudio("1109403054", var_224_24)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403054", "story_v_side_new_1109403.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403054", "story_v_side_new_1109403.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_25 = math.max(var_224_16, arg_221_1.talkMaxDuration)

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_25 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_15) / var_224_25

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_15 + var_224_25 and arg_221_1.time_ < var_224_15 + var_224_25 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play1109403055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1109403055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1109403056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1094ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1094ui_story == nil then
				arg_225_1.var_.characterEffect1094ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1094ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1094ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1094ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1094ui_story.fillRatio = var_228_5
			end

			local var_228_6 = 0
			local var_228_7 = 0.675

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_8 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_9 = arg_225_1:GetWordFromCfg(1109403055)
				local var_228_10 = arg_225_1:FormatText(var_228_9.content)

				arg_225_1.text_.text = var_228_10

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 27
				local var_228_12 = utf8.len(var_228_10)
				local var_228_13 = var_228_11 <= 0 and var_228_7 or var_228_7 * (var_228_12 / var_228_11)

				if var_228_13 > 0 and var_228_7 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_10
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1109403056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1109403056
		arg_229_1.duration_ = 2

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1109403057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1094ui_story"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos1094ui_story = var_232_0.localPosition
			end

			local var_232_2 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2
				local var_232_4 = Vector3.New(0, -0.84, -6.1)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1094ui_story, var_232_4, var_232_3)

				local var_232_5 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_5.x, var_232_5.y, var_232_5.z)

				local var_232_6 = var_232_0.localEulerAngles

				var_232_6.z = 0
				var_232_6.x = 0
				var_232_0.localEulerAngles = var_232_6
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_232_7 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_7.x, var_232_7.y, var_232_7.z)

				local var_232_8 = var_232_0.localEulerAngles

				var_232_8.z = 0
				var_232_8.x = 0
				var_232_0.localEulerAngles = var_232_8
			end

			local var_232_9 = arg_229_1.actors_["1094ui_story"]
			local var_232_10 = 0

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 and not isNil(var_232_9) and arg_229_1.var_.characterEffect1094ui_story == nil then
				arg_229_1.var_.characterEffect1094ui_story = var_232_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_11 = 0.200000002980232

			if var_232_10 <= arg_229_1.time_ and arg_229_1.time_ < var_232_10 + var_232_11 and not isNil(var_232_9) then
				local var_232_12 = (arg_229_1.time_ - var_232_10) / var_232_11

				if arg_229_1.var_.characterEffect1094ui_story and not isNil(var_232_9) then
					arg_229_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_10 + var_232_11 and arg_229_1.time_ < var_232_10 + var_232_11 + arg_232_0 and not isNil(var_232_9) and arg_229_1.var_.characterEffect1094ui_story then
				arg_229_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_232_13 = 0

			if var_232_13 < arg_229_1.time_ and arg_229_1.time_ <= var_232_13 + arg_232_0 then
				arg_229_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_2")
			end

			local var_232_14 = 0

			if var_232_14 < arg_229_1.time_ and arg_229_1.time_ <= var_232_14 + arg_232_0 then
				arg_229_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_232_15 = 0
			local var_232_16 = 0.05

			if var_232_15 < arg_229_1.time_ and arg_229_1.time_ <= var_232_15 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_17 = arg_229_1:FormatText(StoryNameCfg[181].name)

				arg_229_1.leftNameTxt_.text = var_232_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_18 = arg_229_1:GetWordFromCfg(1109403056)
				local var_232_19 = arg_229_1:FormatText(var_232_18.content)

				arg_229_1.text_.text = var_232_19

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_20 = 2
				local var_232_21 = utf8.len(var_232_19)
				local var_232_22 = var_232_20 <= 0 and var_232_16 or var_232_16 * (var_232_21 / var_232_20)

				if var_232_22 > 0 and var_232_16 < var_232_22 then
					arg_229_1.talkMaxDuration = var_232_22

					if var_232_22 + var_232_15 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_22 + var_232_15
					end
				end

				arg_229_1.text_.text = var_232_19
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403056", "story_v_side_new_1109403.awb") ~= 0 then
					local var_232_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403056", "story_v_side_new_1109403.awb") / 1000

					if var_232_23 + var_232_15 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_23 + var_232_15
					end

					if var_232_18.prefab_name ~= "" and arg_229_1.actors_[var_232_18.prefab_name] ~= nil then
						local var_232_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_18.prefab_name].transform, "story_v_side_new_1109403", "1109403056", "story_v_side_new_1109403.awb")

						arg_229_1:RecordAudio("1109403056", var_232_24)
						arg_229_1:RecordAudio("1109403056", var_232_24)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403056", "story_v_side_new_1109403.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403056", "story_v_side_new_1109403.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_25 = math.max(var_232_16, arg_229_1.talkMaxDuration)

			if var_232_15 <= arg_229_1.time_ and arg_229_1.time_ < var_232_15 + var_232_25 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_15) / var_232_25

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_15 + var_232_25 and arg_229_1.time_ < var_232_15 + var_232_25 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play1109403057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1109403057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1109403058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1094ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1094ui_story == nil then
				arg_233_1.var_.characterEffect1094ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1094ui_story and not isNil(var_236_0) then
					local var_236_4 = Mathf.Lerp(0, 0.5, var_236_3)

					arg_233_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1094ui_story.fillRatio = var_236_4
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1094ui_story then
				local var_236_5 = 0.5

				arg_233_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1094ui_story.fillRatio = var_236_5
			end

			local var_236_6 = 0
			local var_236_7 = 0.425

			if var_236_6 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_8 = arg_233_1:GetWordFromCfg(1109403057)
				local var_236_9 = arg_233_1:FormatText(var_236_8.content)

				arg_233_1.text_.text = var_236_9

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_10 = 17
				local var_236_11 = utf8.len(var_236_9)
				local var_236_12 = var_236_10 <= 0 and var_236_7 or var_236_7 * (var_236_11 / var_236_10)

				if var_236_12 > 0 and var_236_7 < var_236_12 then
					arg_233_1.talkMaxDuration = var_236_12

					if var_236_12 + var_236_6 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_12 + var_236_6
					end
				end

				arg_233_1.text_.text = var_236_9
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_13 = math.max(var_236_7, arg_233_1.talkMaxDuration)

			if var_236_6 <= arg_233_1.time_ and arg_233_1.time_ < var_236_6 + var_236_13 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_6) / var_236_13

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_6 + var_236_13 and arg_233_1.time_ < var_236_6 + var_236_13 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1109403058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1109403058
		arg_237_1.duration_ = 1.2

		local var_237_0 = {
			ja = 1.2,
			ko = 1.133,
			zh = 1.133
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1109403059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1094ui_story"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1094ui_story = var_240_0.localPosition
			end

			local var_240_2 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2
				local var_240_4 = Vector3.New(0, 100, 0)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1094ui_story, var_240_4, var_240_3)

				local var_240_5 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_5.x, var_240_5.y, var_240_5.z)

				local var_240_6 = var_240_0.localEulerAngles

				var_240_6.z = 0
				var_240_6.x = 0
				var_240_0.localEulerAngles = var_240_6
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0, 100, 0)

				local var_240_7 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_7.x, var_240_7.y, var_240_7.z)

				local var_240_8 = var_240_0.localEulerAngles

				var_240_8.z = 0
				var_240_8.x = 0
				var_240_0.localEulerAngles = var_240_8
			end

			local var_240_9 = 0
			local var_240_10 = 0.075

			if var_240_9 < arg_237_1.time_ and arg_237_1.time_ <= var_240_9 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_11 = arg_237_1:FormatText(StoryNameCfg[8].name)

				arg_237_1.leftNameTxt_.text = var_240_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_12 = arg_237_1:GetWordFromCfg(1109403058)
				local var_240_13 = arg_237_1:FormatText(var_240_12.content)

				arg_237_1.text_.text = var_240_13

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_14 = 3
				local var_240_15 = utf8.len(var_240_13)
				local var_240_16 = var_240_14 <= 0 and var_240_10 or var_240_10 * (var_240_15 / var_240_14)

				if var_240_16 > 0 and var_240_10 < var_240_16 then
					arg_237_1.talkMaxDuration = var_240_16

					if var_240_16 + var_240_9 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_16 + var_240_9
					end
				end

				arg_237_1.text_.text = var_240_13
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403058", "story_v_side_new_1109403.awb") ~= 0 then
					local var_240_17 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403058", "story_v_side_new_1109403.awb") / 1000

					if var_240_17 + var_240_9 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_17 + var_240_9
					end

					if var_240_12.prefab_name ~= "" and arg_237_1.actors_[var_240_12.prefab_name] ~= nil then
						local var_240_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_12.prefab_name].transform, "story_v_side_new_1109403", "1109403058", "story_v_side_new_1109403.awb")

						arg_237_1:RecordAudio("1109403058", var_240_18)
						arg_237_1:RecordAudio("1109403058", var_240_18)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403058", "story_v_side_new_1109403.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403058", "story_v_side_new_1109403.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_19 = math.max(var_240_10, arg_237_1.talkMaxDuration)

			if var_240_9 <= arg_237_1.time_ and arg_237_1.time_ < var_240_9 + var_240_19 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_9) / var_240_19

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_9 + var_240_19 and arg_237_1.time_ < var_240_9 + var_240_19 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play1109403059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1109403059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1109403060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.2

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				local var_244_2 = "play"
				local var_244_3 = "music"

				arg_241_1:AudioAction(var_244_2, var_244_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_244_4 = ""
				local var_244_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_244_5 ~= "" then
					if arg_241_1.bgmTxt_.text ~= var_244_5 and arg_241_1.bgmTxt_.text ~= "" then
						if arg_241_1.bgmTxt2_.text ~= "" then
							arg_241_1.bgmTxt_.text = arg_241_1.bgmTxt2_.text
						end

						arg_241_1.bgmTxt2_.text = var_244_5

						arg_241_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_241_1.bgmTxt_.text = var_244_5
						arg_241_1.bgmTxt2_.text = var_244_5
					end

					if arg_241_1.bgmTimer then
						arg_241_1.bgmTimer:Stop()

						arg_241_1.bgmTimer = nil
					end

					if arg_241_1.settingData.show_music_name == 1 then
						arg_241_1.musicController:SetSelectedState("show")
						arg_241_1.musicAnimator_:Play("open", 0, 0)

						if arg_241_1.settingData.music_time ~= 0 then
							arg_241_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_241_1.settingData.music_time), function()
								if arg_241_1 == nil or isNil(arg_241_1.bgmTxt_) then
									return
								end

								arg_241_1.musicController:SetSelectedState("hide")
								arg_241_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_244_6 = 0
			local var_244_7 = 0.65

			if var_244_6 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_8 = arg_241_1:GetWordFromCfg(1109403059)
				local var_244_9 = arg_241_1:FormatText(var_244_8.content)

				arg_241_1.text_.text = var_244_9

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_10 = 27
				local var_244_11 = utf8.len(var_244_9)
				local var_244_12 = var_244_10 <= 0 and var_244_7 or var_244_7 * (var_244_11 / var_244_10)

				if var_244_12 > 0 and var_244_7 < var_244_12 then
					arg_241_1.talkMaxDuration = var_244_12

					if var_244_12 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_12 + var_244_6
					end
				end

				arg_241_1.text_.text = var_244_9
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_13 = math.max(var_244_7, arg_241_1.talkMaxDuration)

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_13 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_6) / var_244_13

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_6 + var_244_13 and arg_241_1.time_ < var_244_6 + var_244_13 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1109403060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1109403060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1109403061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = manager.ui.mainCamera.transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.shakeOldPos = var_249_0.localPosition
			end

			local var_249_2 = 0.5

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / 0.066
				local var_249_4, var_249_5 = math.modf(var_249_3)

				var_249_0.localPosition = Vector3.New(var_249_5 * 0.13, var_249_5 * 0.13, var_249_5 * 0.13) + arg_246_1.var_.shakeOldPos
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 then
				var_249_0.localPosition = arg_246_1.var_.shakeOldPos
			end

			local var_249_6 = 0
			local var_249_7 = 0.1

			if var_249_6 < arg_246_1.time_ and arg_246_1.time_ <= var_249_6 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_8 = arg_246_1:FormatText(StoryNameCfg[7].name)

				arg_246_1.leftNameTxt_.text = var_249_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_9 = arg_246_1:GetWordFromCfg(1109403060)
				local var_249_10 = arg_246_1:FormatText(var_249_9.content)

				arg_246_1.text_.text = var_249_10

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_11 = 4
				local var_249_12 = utf8.len(var_249_10)
				local var_249_13 = var_249_11 <= 0 and var_249_7 or var_249_7 * (var_249_12 / var_249_11)

				if var_249_13 > 0 and var_249_7 < var_249_13 then
					arg_246_1.talkMaxDuration = var_249_13

					if var_249_13 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_13 + var_249_6
					end
				end

				arg_246_1.text_.text = var_249_10
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_14 = math.max(var_249_7, arg_246_1.talkMaxDuration)

			if var_249_6 <= arg_246_1.time_ and arg_246_1.time_ < var_249_6 + var_249_14 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_6) / var_249_14

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_6 + var_249_14 and arg_246_1.time_ < var_249_6 + var_249_14 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play1109403061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1109403061
		arg_250_1.duration_ = 7

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1109403062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = "STblack"

			if arg_250_1.bgs_[var_253_0] == nil then
				local var_253_1 = Object.Instantiate(arg_250_1.paintGo_)

				var_253_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_253_0)
				var_253_1.name = var_253_0
				var_253_1.transform.parent = arg_250_1.stage_.transform
				var_253_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_250_1.bgs_[var_253_0] = var_253_1
			end

			local var_253_2 = 0

			if var_253_2 < arg_250_1.time_ and arg_250_1.time_ <= var_253_2 + arg_253_0 then
				local var_253_3 = manager.ui.mainCamera.transform.localPosition
				local var_253_4 = Vector3.New(0, 0, 10) + Vector3.New(var_253_3.x, var_253_3.y, 0)
				local var_253_5 = arg_250_1.bgs_.STblack

				var_253_5.transform.localPosition = var_253_4
				var_253_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_253_6 = var_253_5:GetComponent("SpriteRenderer")

				if var_253_6 and var_253_6.sprite then
					local var_253_7 = (var_253_5.transform.localPosition - var_253_3).z
					local var_253_8 = manager.ui.mainCameraCom_
					local var_253_9 = 2 * var_253_7 * Mathf.Tan(var_253_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_253_10 = var_253_9 * var_253_8.aspect
					local var_253_11 = var_253_6.sprite.bounds.size.x
					local var_253_12 = var_253_6.sprite.bounds.size.y
					local var_253_13 = var_253_10 / var_253_11
					local var_253_14 = var_253_9 / var_253_12
					local var_253_15 = var_253_14 < var_253_13 and var_253_13 or var_253_14

					var_253_5.transform.localScale = Vector3.New(var_253_15, var_253_15, 0)
				end

				for iter_253_0, iter_253_1 in pairs(arg_250_1.bgs_) do
					if iter_253_0 ~= "STblack" then
						iter_253_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_253_16 = 0

			if var_253_16 < arg_250_1.time_ and arg_250_1.time_ <= var_253_16 + arg_253_0 then
				arg_250_1.mask_.enabled = true
				arg_250_1.mask_.raycastTarget = true

				arg_250_1:SetGaussion(false)
			end

			local var_253_17 = 2

			if var_253_16 <= arg_250_1.time_ and arg_250_1.time_ < var_253_16 + var_253_17 then
				local var_253_18 = (arg_250_1.time_ - var_253_16) / var_253_17
				local var_253_19 = Color.New(0, 0, 0)

				var_253_19.a = Mathf.Lerp(1, 0, var_253_18)
				arg_250_1.mask_.color = var_253_19
			end

			if arg_250_1.time_ >= var_253_16 + var_253_17 and arg_250_1.time_ < var_253_16 + var_253_17 + arg_253_0 then
				local var_253_20 = Color.New(0, 0, 0)
				local var_253_21 = 0

				arg_250_1.mask_.enabled = false
				var_253_20.a = var_253_21
				arg_250_1.mask_.color = var_253_20
			end

			if arg_250_1.frameCnt_ <= 1 then
				arg_250_1.dialog_:SetActive(false)
			end

			local var_253_22 = 2
			local var_253_23 = 1.125

			if var_253_22 < arg_250_1.time_ and arg_250_1.time_ <= var_253_22 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0

				arg_250_1.dialog_:SetActive(true)

				arg_250_1.dialogCg_.alpha = 0

				local var_253_24 = LeanTween.value(arg_250_1.dialog_, 0, 1, 0.3)

				var_253_24:setOnUpdate(LuaHelper.FloatAction(function(arg_254_0)
					arg_250_1.dialogCg_.alpha = arg_254_0
				end))
				var_253_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_250_1.dialog_)
					var_253_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_250_1.duration_ = arg_250_1.duration_ + 0.3

				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_25 = arg_250_1:GetWordFromCfg(1109403061)
				local var_253_26 = arg_250_1:FormatText(var_253_25.content)

				arg_250_1.text_.text = var_253_26

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_27 = 53
				local var_253_28 = utf8.len(var_253_26)
				local var_253_29 = var_253_27 <= 0 and var_253_23 or var_253_23 * (var_253_28 / var_253_27)

				if var_253_29 > 0 and var_253_23 < var_253_29 then
					arg_250_1.talkMaxDuration = var_253_29
					var_253_22 = var_253_22 + 0.3

					if var_253_29 + var_253_22 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_29 + var_253_22
					end
				end

				arg_250_1.text_.text = var_253_26
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_30 = var_253_22 + 0.3
			local var_253_31 = math.max(var_253_23, arg_250_1.talkMaxDuration)

			if var_253_30 <= arg_250_1.time_ and arg_250_1.time_ < var_253_30 + var_253_31 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_30) / var_253_31

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_30 + var_253_31 and arg_250_1.time_ < var_253_30 + var_253_31 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1109403062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 1109403062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play1109403063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0
			local var_259_1 = 0.575

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_2 = arg_256_1:GetWordFromCfg(1109403062)
				local var_259_3 = arg_256_1:FormatText(var_259_2.content)

				arg_256_1.text_.text = var_259_3

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_4 = 23
				local var_259_5 = utf8.len(var_259_3)
				local var_259_6 = var_259_4 <= 0 and var_259_1 or var_259_1 * (var_259_5 / var_259_4)

				if var_259_6 > 0 and var_259_1 < var_259_6 then
					arg_256_1.talkMaxDuration = var_259_6

					if var_259_6 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_6 + var_259_0
					end
				end

				arg_256_1.text_.text = var_259_3
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_7 = math.max(var_259_1, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_7 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_0) / var_259_7

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_7 and arg_256_1.time_ < var_259_0 + var_259_7 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play1109403063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 1109403063
		arg_260_1.duration_ = 7

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play1109403064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = "ST12"

			if arg_260_1.bgs_[var_263_0] == nil then
				local var_263_1 = Object.Instantiate(arg_260_1.paintGo_)

				var_263_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_263_0)
				var_263_1.name = var_263_0
				var_263_1.transform.parent = arg_260_1.stage_.transform
				var_263_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.bgs_[var_263_0] = var_263_1
			end

			local var_263_2 = 0

			if var_263_2 < arg_260_1.time_ and arg_260_1.time_ <= var_263_2 + arg_263_0 then
				if arg_260_0.sceneSettingEffect_ then
					arg_260_1.sceneSettingEffect_.enabled = false
				end

				arg_260_1.sceneSettingGo_:SetActive(true)

				local var_263_3 = manager.ui.mainCamera.transform.localPosition
				local var_263_4 = Vector3.New(0, 0, 10) + Vector3.New(var_263_3.x, var_263_3.y, 0)
				local var_263_5 = arg_260_1.bgs_.ST12

				var_263_5.transform.localPosition = var_263_4
				var_263_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_263_6 = var_263_5:GetComponent("SpriteRenderer")

				if var_263_6 and var_263_6.sprite then
					local var_263_7 = (var_263_5.transform.localPosition - var_263_3).z
					local var_263_8 = manager.ui.mainCameraCom_
					local var_263_9 = 2 * var_263_7 * Mathf.Tan(var_263_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_263_10 = var_263_9 * var_263_8.aspect
					local var_263_11 = var_263_6.sprite.bounds.size.x
					local var_263_12 = var_263_6.sprite.bounds.size.y
					local var_263_13 = var_263_10 / var_263_11
					local var_263_14 = var_263_9 / var_263_12
					local var_263_15 = var_263_14 < var_263_13 and var_263_13 or var_263_14

					var_263_5.transform.localScale = Vector3.New(var_263_15, var_263_15, 0)
				end

				for iter_263_0, iter_263_1 in pairs(arg_260_1.bgs_) do
					if iter_263_0 ~= "ST12" then
						iter_263_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_263_16 = 0

			if var_263_16 < arg_260_1.time_ and arg_260_1.time_ <= var_263_16 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_17 = 2

			if var_263_16 <= arg_260_1.time_ and arg_260_1.time_ < var_263_16 + var_263_17 then
				local var_263_18 = (arg_260_1.time_ - var_263_16) / var_263_17
				local var_263_19 = Color.New(0, 0, 0)

				var_263_19.a = Mathf.Lerp(1, 0, var_263_18)
				arg_260_1.mask_.color = var_263_19
			end

			if arg_260_1.time_ >= var_263_16 + var_263_17 and arg_260_1.time_ < var_263_16 + var_263_17 + arg_263_0 then
				local var_263_20 = Color.New(0, 0, 0)
				local var_263_21 = 0

				arg_260_1.mask_.enabled = false
				var_263_20.a = var_263_21
				arg_260_1.mask_.color = var_263_20
			end

			if arg_260_1.frameCnt_ <= 1 then
				arg_260_1.dialog_:SetActive(false)
			end

			local var_263_22 = 2
			local var_263_23 = 0.725

			if var_263_22 < arg_260_1.time_ and arg_260_1.time_ <= var_263_22 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				arg_260_1.dialog_:SetActive(true)

				arg_260_1.dialogCg_.alpha = 0

				local var_263_24 = LeanTween.value(arg_260_1.dialog_, 0, 1, 0.3)

				var_263_24:setOnUpdate(LuaHelper.FloatAction(function(arg_264_0)
					arg_260_1.dialogCg_.alpha = arg_264_0
				end))
				var_263_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_260_1.dialog_)
					var_263_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_260_1.duration_ = arg_260_1.duration_ + 0.3

				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_25 = arg_260_1:GetWordFromCfg(1109403063)
				local var_263_26 = arg_260_1:FormatText(var_263_25.content)

				arg_260_1.text_.text = var_263_26

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_27 = 30
				local var_263_28 = utf8.len(var_263_26)
				local var_263_29 = var_263_27 <= 0 and var_263_23 or var_263_23 * (var_263_28 / var_263_27)

				if var_263_29 > 0 and var_263_23 < var_263_29 then
					arg_260_1.talkMaxDuration = var_263_29
					var_263_22 = var_263_22 + 0.3

					if var_263_29 + var_263_22 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_29 + var_263_22
					end
				end

				arg_260_1.text_.text = var_263_26
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_30 = var_263_22 + 0.3
			local var_263_31 = math.max(var_263_23, arg_260_1.talkMaxDuration)

			if var_263_30 <= arg_260_1.time_ and arg_260_1.time_ < var_263_30 + var_263_31 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_30) / var_263_31

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_30 + var_263_31 and arg_260_1.time_ < var_263_30 + var_263_31 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play1109403064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1109403064
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1109403065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 0.25

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_2 = arg_266_1:FormatText(StoryNameCfg[7].name)

				arg_266_1.leftNameTxt_.text = var_269_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_3 = arg_266_1:GetWordFromCfg(1109403064)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 10
				local var_269_6 = utf8.len(var_269_4)
				local var_269_7 = var_269_5 <= 0 and var_269_1 or var_269_1 * (var_269_6 / var_269_5)

				if var_269_7 > 0 and var_269_1 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_8 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_8 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_8

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_8 and arg_266_1.time_ < var_269_0 + var_269_8 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play1109403065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1109403065
		arg_270_1.duration_ = 9.47

		local var_270_0 = {
			ja = 9.4,
			ko = 9.466,
			zh = 9.466
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1109403066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = "1038ui_story"

			if arg_270_1.actors_[var_273_0] == nil then
				local var_273_1 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_273_1) then
					local var_273_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_270_1.stage_.transform)

					var_273_2.name = var_273_0
					var_273_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_270_1.actors_[var_273_0] = var_273_2

					local var_273_3 = var_273_2:GetComponentInChildren(typeof(CharacterEffect))

					var_273_3.enabled = true

					local var_273_4 = GameObjectTools.GetOrAddComponent(var_273_2, typeof(DynamicBoneHelper))

					if var_273_4 then
						var_273_4:EnableDynamicBone(false)
					end

					arg_270_1:ShowWeapon(var_273_3.transform, false)

					arg_270_1.var_[var_273_0 .. "Animator"] = var_273_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_270_1.var_[var_273_0 .. "Animator"].applyRootMotion = true
					arg_270_1.var_[var_273_0 .. "LipSync"] = var_273_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_273_5 = arg_270_1.actors_["1038ui_story"].transform
			local var_273_6 = 0

			if var_273_6 < arg_270_1.time_ and arg_270_1.time_ <= var_273_6 + arg_273_0 then
				arg_270_1.var_.moveOldPos1038ui_story = var_273_5.localPosition
			end

			local var_273_7 = 0.001

			if var_273_6 <= arg_270_1.time_ and arg_270_1.time_ < var_273_6 + var_273_7 then
				local var_273_8 = (arg_270_1.time_ - var_273_6) / var_273_7
				local var_273_9 = Vector3.New(0, -1.11, -5.9)

				var_273_5.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1038ui_story, var_273_9, var_273_8)

				local var_273_10 = manager.ui.mainCamera.transform.position - var_273_5.position

				var_273_5.forward = Vector3.New(var_273_10.x, var_273_10.y, var_273_10.z)

				local var_273_11 = var_273_5.localEulerAngles

				var_273_11.z = 0
				var_273_11.x = 0
				var_273_5.localEulerAngles = var_273_11
			end

			if arg_270_1.time_ >= var_273_6 + var_273_7 and arg_270_1.time_ < var_273_6 + var_273_7 + arg_273_0 then
				var_273_5.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_273_12 = manager.ui.mainCamera.transform.position - var_273_5.position

				var_273_5.forward = Vector3.New(var_273_12.x, var_273_12.y, var_273_12.z)

				local var_273_13 = var_273_5.localEulerAngles

				var_273_13.z = 0
				var_273_13.x = 0
				var_273_5.localEulerAngles = var_273_13
			end

			local var_273_14 = arg_270_1.actors_["1038ui_story"]
			local var_273_15 = 0

			if var_273_15 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 and not isNil(var_273_14) and arg_270_1.var_.characterEffect1038ui_story == nil then
				arg_270_1.var_.characterEffect1038ui_story = var_273_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_16 = 0.200000002980232

			if var_273_15 <= arg_270_1.time_ and arg_270_1.time_ < var_273_15 + var_273_16 and not isNil(var_273_14) then
				local var_273_17 = (arg_270_1.time_ - var_273_15) / var_273_16

				if arg_270_1.var_.characterEffect1038ui_story and not isNil(var_273_14) then
					arg_270_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_15 + var_273_16 and arg_270_1.time_ < var_273_15 + var_273_16 + arg_273_0 and not isNil(var_273_14) and arg_270_1.var_.characterEffect1038ui_story then
				arg_270_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_273_18 = 0

			if var_273_18 < arg_270_1.time_ and arg_270_1.time_ <= var_273_18 + arg_273_0 then
				arg_270_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_273_19 = 0

			if var_273_19 < arg_270_1.time_ and arg_270_1.time_ <= var_273_19 + arg_273_0 then
				arg_270_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_273_20 = arg_270_1.actors_["1038ui_story"]
			local var_273_21 = 0

			if var_273_21 < arg_270_1.time_ and arg_270_1.time_ <= var_273_21 + arg_273_0 then
				if arg_270_1.var_.characterEffect1038ui_story == nil then
					arg_270_1.var_.characterEffect1038ui_story = var_273_20:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_273_22 = arg_270_1.var_.characterEffect1038ui_story

				var_273_22.imageEffect:turnOff()

				var_273_22.interferenceEffect.enabled = true
				var_273_22.interferenceEffect.noise = 0.001
				var_273_22.interferenceEffect.simTimeScale = 1
				var_273_22.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_273_23 = 0
			local var_273_24 = 1

			if var_273_23 < arg_270_1.time_ and arg_270_1.time_ <= var_273_23 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_25 = arg_270_1:FormatText(StoryNameCfg[94].name)

				arg_270_1.leftNameTxt_.text = var_273_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_26 = arg_270_1:GetWordFromCfg(1109403065)
				local var_273_27 = arg_270_1:FormatText(var_273_26.content)

				arg_270_1.text_.text = var_273_27

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_28 = 40
				local var_273_29 = utf8.len(var_273_27)
				local var_273_30 = var_273_28 <= 0 and var_273_24 or var_273_24 * (var_273_29 / var_273_28)

				if var_273_30 > 0 and var_273_24 < var_273_30 then
					arg_270_1.talkMaxDuration = var_273_30

					if var_273_30 + var_273_23 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_30 + var_273_23
					end
				end

				arg_270_1.text_.text = var_273_27
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403065", "story_v_side_new_1109403.awb") ~= 0 then
					local var_273_31 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403065", "story_v_side_new_1109403.awb") / 1000

					if var_273_31 + var_273_23 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_31 + var_273_23
					end

					if var_273_26.prefab_name ~= "" and arg_270_1.actors_[var_273_26.prefab_name] ~= nil then
						local var_273_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_26.prefab_name].transform, "story_v_side_new_1109403", "1109403065", "story_v_side_new_1109403.awb")

						arg_270_1:RecordAudio("1109403065", var_273_32)
						arg_270_1:RecordAudio("1109403065", var_273_32)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403065", "story_v_side_new_1109403.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403065", "story_v_side_new_1109403.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_33 = math.max(var_273_24, arg_270_1.talkMaxDuration)

			if var_273_23 <= arg_270_1.time_ and arg_270_1.time_ < var_273_23 + var_273_33 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_23) / var_273_33

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_23 + var_273_33 and arg_270_1.time_ < var_273_23 + var_273_33 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play1109403066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1109403066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1109403067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1038ui_story"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1038ui_story == nil then
				arg_274_1.var_.characterEffect1038ui_story = var_277_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.characterEffect1038ui_story and not isNil(var_277_0) then
					local var_277_4 = Mathf.Lerp(0, 0.5, var_277_3)

					arg_274_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1038ui_story.fillRatio = var_277_4
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1038ui_story then
				local var_277_5 = 0.5

				arg_274_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1038ui_story.fillRatio = var_277_5
			end

			local var_277_6 = 0
			local var_277_7 = 0.3

			if var_277_6 < arg_274_1.time_ and arg_274_1.time_ <= var_277_6 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_8 = arg_274_1:FormatText(StoryNameCfg[7].name)

				arg_274_1.leftNameTxt_.text = var_277_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_9 = arg_274_1:GetWordFromCfg(1109403066)
				local var_277_10 = arg_274_1:FormatText(var_277_9.content)

				arg_274_1.text_.text = var_277_10

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_11 = 12
				local var_277_12 = utf8.len(var_277_10)
				local var_277_13 = var_277_11 <= 0 and var_277_7 or var_277_7 * (var_277_12 / var_277_11)

				if var_277_13 > 0 and var_277_7 < var_277_13 then
					arg_274_1.talkMaxDuration = var_277_13

					if var_277_13 + var_277_6 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_13 + var_277_6
					end
				end

				arg_274_1.text_.text = var_277_10
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_14 = math.max(var_277_7, arg_274_1.talkMaxDuration)

			if var_277_6 <= arg_274_1.time_ and arg_274_1.time_ < var_277_6 + var_277_14 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_6) / var_277_14

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_6 + var_277_14 and arg_274_1.time_ < var_277_6 + var_277_14 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play1109403067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1109403067
		arg_278_1.duration_ = 8.67

		local var_278_0 = {
			ja = 6.233,
			ko = 8.666,
			zh = 8.666
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1109403068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1038ui_story"].transform
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.var_.moveOldPos1038ui_story = var_281_0.localPosition
			end

			local var_281_2 = 0.001

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2
				local var_281_4 = Vector3.New(0, -1.11, -5.9)

				var_281_0.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1038ui_story, var_281_4, var_281_3)

				local var_281_5 = manager.ui.mainCamera.transform.position - var_281_0.position

				var_281_0.forward = Vector3.New(var_281_5.x, var_281_5.y, var_281_5.z)

				local var_281_6 = var_281_0.localEulerAngles

				var_281_6.z = 0
				var_281_6.x = 0
				var_281_0.localEulerAngles = var_281_6
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 then
				var_281_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_281_7 = manager.ui.mainCamera.transform.position - var_281_0.position

				var_281_0.forward = Vector3.New(var_281_7.x, var_281_7.y, var_281_7.z)

				local var_281_8 = var_281_0.localEulerAngles

				var_281_8.z = 0
				var_281_8.x = 0
				var_281_0.localEulerAngles = var_281_8
			end

			local var_281_9 = arg_278_1.actors_["1038ui_story"]
			local var_281_10 = 0

			if var_281_10 < arg_278_1.time_ and arg_278_1.time_ <= var_281_10 + arg_281_0 and not isNil(var_281_9) and arg_278_1.var_.characterEffect1038ui_story == nil then
				arg_278_1.var_.characterEffect1038ui_story = var_281_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_11 = 0.200000002980232

			if var_281_10 <= arg_278_1.time_ and arg_278_1.time_ < var_281_10 + var_281_11 and not isNil(var_281_9) then
				local var_281_12 = (arg_278_1.time_ - var_281_10) / var_281_11

				if arg_278_1.var_.characterEffect1038ui_story and not isNil(var_281_9) then
					arg_278_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= var_281_10 + var_281_11 and arg_278_1.time_ < var_281_10 + var_281_11 + arg_281_0 and not isNil(var_281_9) and arg_278_1.var_.characterEffect1038ui_story then
				arg_278_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_281_13 = 0

			if var_281_13 < arg_278_1.time_ and arg_278_1.time_ <= var_281_13 + arg_281_0 then
				arg_278_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_281_14 = 0

			if var_281_14 < arg_278_1.time_ and arg_278_1.time_ <= var_281_14 + arg_281_0 then
				arg_278_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_281_15 = 0
			local var_281_16 = 1

			if var_281_15 < arg_278_1.time_ and arg_278_1.time_ <= var_281_15 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_17 = arg_278_1:FormatText(StoryNameCfg[94].name)

				arg_278_1.leftNameTxt_.text = var_281_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_18 = arg_278_1:GetWordFromCfg(1109403067)
				local var_281_19 = arg_278_1:FormatText(var_281_18.content)

				arg_278_1.text_.text = var_281_19

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_20 = 39
				local var_281_21 = utf8.len(var_281_19)
				local var_281_22 = var_281_20 <= 0 and var_281_16 or var_281_16 * (var_281_21 / var_281_20)

				if var_281_22 > 0 and var_281_16 < var_281_22 then
					arg_278_1.talkMaxDuration = var_281_22

					if var_281_22 + var_281_15 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_22 + var_281_15
					end
				end

				arg_278_1.text_.text = var_281_19
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403067", "story_v_side_new_1109403.awb") ~= 0 then
					local var_281_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403067", "story_v_side_new_1109403.awb") / 1000

					if var_281_23 + var_281_15 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_23 + var_281_15
					end

					if var_281_18.prefab_name ~= "" and arg_278_1.actors_[var_281_18.prefab_name] ~= nil then
						local var_281_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_18.prefab_name].transform, "story_v_side_new_1109403", "1109403067", "story_v_side_new_1109403.awb")

						arg_278_1:RecordAudio("1109403067", var_281_24)
						arg_278_1:RecordAudio("1109403067", var_281_24)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403067", "story_v_side_new_1109403.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403067", "story_v_side_new_1109403.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_25 = math.max(var_281_16, arg_278_1.talkMaxDuration)

			if var_281_15 <= arg_278_1.time_ and arg_278_1.time_ < var_281_15 + var_281_25 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_15) / var_281_25

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_15 + var_281_25 and arg_278_1.time_ < var_281_15 + var_281_25 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play1109403068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1109403068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1109403069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1038ui_story"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1038ui_story == nil then
				arg_282_1.var_.characterEffect1038ui_story = var_285_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.characterEffect1038ui_story and not isNil(var_285_0) then
					local var_285_4 = Mathf.Lerp(0, 0.5, var_285_3)

					arg_282_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1038ui_story.fillRatio = var_285_4
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1038ui_story then
				local var_285_5 = 0.5

				arg_282_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1038ui_story.fillRatio = var_285_5
			end

			local var_285_6 = 0
			local var_285_7 = 0.575

			if var_285_6 < arg_282_1.time_ and arg_282_1.time_ <= var_285_6 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_8 = arg_282_1:FormatText(StoryNameCfg[7].name)

				arg_282_1.leftNameTxt_.text = var_285_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_9 = arg_282_1:GetWordFromCfg(1109403068)
				local var_285_10 = arg_282_1:FormatText(var_285_9.content)

				arg_282_1.text_.text = var_285_10

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_11 = 23
				local var_285_12 = utf8.len(var_285_10)
				local var_285_13 = var_285_11 <= 0 and var_285_7 or var_285_7 * (var_285_12 / var_285_11)

				if var_285_13 > 0 and var_285_7 < var_285_13 then
					arg_282_1.talkMaxDuration = var_285_13

					if var_285_13 + var_285_6 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_13 + var_285_6
					end
				end

				arg_282_1.text_.text = var_285_10
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_14 = math.max(var_285_7, arg_282_1.talkMaxDuration)

			if var_285_6 <= arg_282_1.time_ and arg_282_1.time_ < var_285_6 + var_285_14 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_6) / var_285_14

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_6 + var_285_14 and arg_282_1.time_ < var_285_6 + var_285_14 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play1109403069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1109403069
		arg_286_1.duration_ = 12

		local var_286_0 = {
			ja = 10.066,
			ko = 12,
			zh = 12
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1109403070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["1038ui_story"].transform
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.var_.moveOldPos1038ui_story = var_289_0.localPosition
			end

			local var_289_2 = 0.001

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2
				local var_289_4 = Vector3.New(0, -1.11, -5.9)

				var_289_0.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1038ui_story, var_289_4, var_289_3)

				local var_289_5 = manager.ui.mainCamera.transform.position - var_289_0.position

				var_289_0.forward = Vector3.New(var_289_5.x, var_289_5.y, var_289_5.z)

				local var_289_6 = var_289_0.localEulerAngles

				var_289_6.z = 0
				var_289_6.x = 0
				var_289_0.localEulerAngles = var_289_6
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 then
				var_289_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_289_7 = manager.ui.mainCamera.transform.position - var_289_0.position

				var_289_0.forward = Vector3.New(var_289_7.x, var_289_7.y, var_289_7.z)

				local var_289_8 = var_289_0.localEulerAngles

				var_289_8.z = 0
				var_289_8.x = 0
				var_289_0.localEulerAngles = var_289_8
			end

			local var_289_9 = arg_286_1.actors_["1038ui_story"]
			local var_289_10 = 0

			if var_289_10 < arg_286_1.time_ and arg_286_1.time_ <= var_289_10 + arg_289_0 and not isNil(var_289_9) and arg_286_1.var_.characterEffect1038ui_story == nil then
				arg_286_1.var_.characterEffect1038ui_story = var_289_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_11 = 0.200000002980232

			if var_289_10 <= arg_286_1.time_ and arg_286_1.time_ < var_289_10 + var_289_11 and not isNil(var_289_9) then
				local var_289_12 = (arg_286_1.time_ - var_289_10) / var_289_11

				if arg_286_1.var_.characterEffect1038ui_story and not isNil(var_289_9) then
					arg_286_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= var_289_10 + var_289_11 and arg_286_1.time_ < var_289_10 + var_289_11 + arg_289_0 and not isNil(var_289_9) and arg_286_1.var_.characterEffect1038ui_story then
				arg_286_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_289_13 = 0

			if var_289_13 < arg_286_1.time_ and arg_286_1.time_ <= var_289_13 + arg_289_0 then
				arg_286_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action456")
			end

			local var_289_14 = 0

			if var_289_14 < arg_286_1.time_ and arg_286_1.time_ <= var_289_14 + arg_289_0 then
				arg_286_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_289_15 = 0
			local var_289_16 = 1.25

			if var_289_15 < arg_286_1.time_ and arg_286_1.time_ <= var_289_15 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_17 = arg_286_1:FormatText(StoryNameCfg[94].name)

				arg_286_1.leftNameTxt_.text = var_289_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_18 = arg_286_1:GetWordFromCfg(1109403069)
				local var_289_19 = arg_286_1:FormatText(var_289_18.content)

				arg_286_1.text_.text = var_289_19

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_20 = 50
				local var_289_21 = utf8.len(var_289_19)
				local var_289_22 = var_289_20 <= 0 and var_289_16 or var_289_16 * (var_289_21 / var_289_20)

				if var_289_22 > 0 and var_289_16 < var_289_22 then
					arg_286_1.talkMaxDuration = var_289_22

					if var_289_22 + var_289_15 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_22 + var_289_15
					end
				end

				arg_286_1.text_.text = var_289_19
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403069", "story_v_side_new_1109403.awb") ~= 0 then
					local var_289_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403069", "story_v_side_new_1109403.awb") / 1000

					if var_289_23 + var_289_15 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_23 + var_289_15
					end

					if var_289_18.prefab_name ~= "" and arg_286_1.actors_[var_289_18.prefab_name] ~= nil then
						local var_289_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_18.prefab_name].transform, "story_v_side_new_1109403", "1109403069", "story_v_side_new_1109403.awb")

						arg_286_1:RecordAudio("1109403069", var_289_24)
						arg_286_1:RecordAudio("1109403069", var_289_24)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403069", "story_v_side_new_1109403.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403069", "story_v_side_new_1109403.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_25 = math.max(var_289_16, arg_286_1.talkMaxDuration)

			if var_289_15 <= arg_286_1.time_ and arg_286_1.time_ < var_289_15 + var_289_25 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_15) / var_289_25

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_15 + var_289_25 and arg_286_1.time_ < var_289_15 + var_289_25 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play1109403070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1109403070
		arg_290_1.duration_ = 7.47

		local var_290_0 = {
			ja = 7.466,
			ko = 3.3,
			zh = 3.3
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1109403071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1038ui_story"].transform
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.var_.moveOldPos1038ui_story = var_293_0.localPosition
			end

			local var_293_2 = 0.001

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2
				local var_293_4 = Vector3.New(0, -1.11, -5.9)

				var_293_0.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1038ui_story, var_293_4, var_293_3)

				local var_293_5 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_5.x, var_293_5.y, var_293_5.z)

				local var_293_6 = var_293_0.localEulerAngles

				var_293_6.z = 0
				var_293_6.x = 0
				var_293_0.localEulerAngles = var_293_6
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 then
				var_293_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_293_7 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_7.x, var_293_7.y, var_293_7.z)

				local var_293_8 = var_293_0.localEulerAngles

				var_293_8.z = 0
				var_293_8.x = 0
				var_293_0.localEulerAngles = var_293_8
			end

			local var_293_9 = arg_290_1.actors_["1038ui_story"]
			local var_293_10 = 0

			if var_293_10 < arg_290_1.time_ and arg_290_1.time_ <= var_293_10 + arg_293_0 and not isNil(var_293_9) and arg_290_1.var_.characterEffect1038ui_story == nil then
				arg_290_1.var_.characterEffect1038ui_story = var_293_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_11 = 0.200000002980232

			if var_293_10 <= arg_290_1.time_ and arg_290_1.time_ < var_293_10 + var_293_11 and not isNil(var_293_9) then
				local var_293_12 = (arg_290_1.time_ - var_293_10) / var_293_11

				if arg_290_1.var_.characterEffect1038ui_story and not isNil(var_293_9) then
					arg_290_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= var_293_10 + var_293_11 and arg_290_1.time_ < var_293_10 + var_293_11 + arg_293_0 and not isNil(var_293_9) and arg_290_1.var_.characterEffect1038ui_story then
				arg_290_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_293_13 = 0

			if var_293_13 < arg_290_1.time_ and arg_290_1.time_ <= var_293_13 + arg_293_0 then
				arg_290_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_293_14 = 0
			local var_293_15 = 0.35

			if var_293_14 < arg_290_1.time_ and arg_290_1.time_ <= var_293_14 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_16 = arg_290_1:FormatText(StoryNameCfg[94].name)

				arg_290_1.leftNameTxt_.text = var_293_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_17 = arg_290_1:GetWordFromCfg(1109403070)
				local var_293_18 = arg_290_1:FormatText(var_293_17.content)

				arg_290_1.text_.text = var_293_18

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_19 = 14
				local var_293_20 = utf8.len(var_293_18)
				local var_293_21 = var_293_19 <= 0 and var_293_15 or var_293_15 * (var_293_20 / var_293_19)

				if var_293_21 > 0 and var_293_15 < var_293_21 then
					arg_290_1.talkMaxDuration = var_293_21

					if var_293_21 + var_293_14 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_21 + var_293_14
					end
				end

				arg_290_1.text_.text = var_293_18
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403070", "story_v_side_new_1109403.awb") ~= 0 then
					local var_293_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403070", "story_v_side_new_1109403.awb") / 1000

					if var_293_22 + var_293_14 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_22 + var_293_14
					end

					if var_293_17.prefab_name ~= "" and arg_290_1.actors_[var_293_17.prefab_name] ~= nil then
						local var_293_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_17.prefab_name].transform, "story_v_side_new_1109403", "1109403070", "story_v_side_new_1109403.awb")

						arg_290_1:RecordAudio("1109403070", var_293_23)
						arg_290_1:RecordAudio("1109403070", var_293_23)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403070", "story_v_side_new_1109403.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403070", "story_v_side_new_1109403.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_24 = math.max(var_293_15, arg_290_1.talkMaxDuration)

			if var_293_14 <= arg_290_1.time_ and arg_290_1.time_ < var_293_14 + var_293_24 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_14) / var_293_24

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_14 + var_293_24 and arg_290_1.time_ < var_293_14 + var_293_24 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play1109403071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1109403071
		arg_294_1.duration_ = 0.2

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"

			SetActive(arg_294_1.choicesGo_, true)

			for iter_295_0, iter_295_1 in ipairs(arg_294_1.choices_) do
				local var_295_0 = iter_295_0 <= 1

				SetActive(iter_295_1.go, var_295_0)
			end

			arg_294_1.choices_[1].txt.text = arg_294_1:FormatText(StoryChoiceCfg[409].name)
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1109403072(arg_294_1)
			end

			arg_294_1:RecordChoiceLog(1109403071, 409)
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["1038ui_story"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect1038ui_story == nil then
				arg_294_1.var_.characterEffect1038ui_story = var_297_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.200000002980232

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.characterEffect1038ui_story and not isNil(var_297_0) then
					local var_297_4 = Mathf.Lerp(0, 0.5, var_297_3)

					arg_294_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_294_1.var_.characterEffect1038ui_story.fillRatio = var_297_4
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect1038ui_story then
				local var_297_5 = 0.5

				arg_294_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_294_1.var_.characterEffect1038ui_story.fillRatio = var_297_5
			end

			local var_297_6 = 0

			if var_297_6 < arg_294_1.time_ and arg_294_1.time_ <= var_297_6 + arg_297_0 then
				arg_294_1.allBtn_.enabled = false
			end

			local var_297_7 = 0.200000002980232

			if arg_294_1.time_ >= var_297_6 + var_297_7 and arg_294_1.time_ < var_297_6 + var_297_7 + arg_297_0 then
				arg_294_1.allBtn_.enabled = true
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play1109403072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 1109403072
		arg_298_1.duration_ = 2.63

		local var_298_0 = {
			ja = 2.633,
			ko = 2.133,
			zh = 2.133
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play1109403073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["1038ui_story"].transform
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.var_.moveOldPos1038ui_story = var_301_0.localPosition
			end

			local var_301_2 = 0.001

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2
				local var_301_4 = Vector3.New(0, -1.11, -5.9)

				var_301_0.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1038ui_story, var_301_4, var_301_3)

				local var_301_5 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_5.x, var_301_5.y, var_301_5.z)

				local var_301_6 = var_301_0.localEulerAngles

				var_301_6.z = 0
				var_301_6.x = 0
				var_301_0.localEulerAngles = var_301_6
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 then
				var_301_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_301_7 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_7.x, var_301_7.y, var_301_7.z)

				local var_301_8 = var_301_0.localEulerAngles

				var_301_8.z = 0
				var_301_8.x = 0
				var_301_0.localEulerAngles = var_301_8
			end

			local var_301_9 = arg_298_1.actors_["1038ui_story"]
			local var_301_10 = 0

			if var_301_10 < arg_298_1.time_ and arg_298_1.time_ <= var_301_10 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect1038ui_story == nil then
				arg_298_1.var_.characterEffect1038ui_story = var_301_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_11 = 0.200000002980232

			if var_301_10 <= arg_298_1.time_ and arg_298_1.time_ < var_301_10 + var_301_11 and not isNil(var_301_9) then
				local var_301_12 = (arg_298_1.time_ - var_301_10) / var_301_11

				if arg_298_1.var_.characterEffect1038ui_story and not isNil(var_301_9) then
					arg_298_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= var_301_10 + var_301_11 and arg_298_1.time_ < var_301_10 + var_301_11 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect1038ui_story then
				arg_298_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_301_13 = 0

			if var_301_13 < arg_298_1.time_ and arg_298_1.time_ <= var_301_13 + arg_301_0 then
				arg_298_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_301_14 = 0
			local var_301_15 = 0.175

			if var_301_14 < arg_298_1.time_ and arg_298_1.time_ <= var_301_14 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_16 = arg_298_1:FormatText(StoryNameCfg[94].name)

				arg_298_1.leftNameTxt_.text = var_301_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_17 = arg_298_1:GetWordFromCfg(1109403072)
				local var_301_18 = arg_298_1:FormatText(var_301_17.content)

				arg_298_1.text_.text = var_301_18

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_19 = 7
				local var_301_20 = utf8.len(var_301_18)
				local var_301_21 = var_301_19 <= 0 and var_301_15 or var_301_15 * (var_301_20 / var_301_19)

				if var_301_21 > 0 and var_301_15 < var_301_21 then
					arg_298_1.talkMaxDuration = var_301_21

					if var_301_21 + var_301_14 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_21 + var_301_14
					end
				end

				arg_298_1.text_.text = var_301_18
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403072", "story_v_side_new_1109403.awb") ~= 0 then
					local var_301_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403072", "story_v_side_new_1109403.awb") / 1000

					if var_301_22 + var_301_14 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_22 + var_301_14
					end

					if var_301_17.prefab_name ~= "" and arg_298_1.actors_[var_301_17.prefab_name] ~= nil then
						local var_301_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_17.prefab_name].transform, "story_v_side_new_1109403", "1109403072", "story_v_side_new_1109403.awb")

						arg_298_1:RecordAudio("1109403072", var_301_23)
						arg_298_1:RecordAudio("1109403072", var_301_23)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403072", "story_v_side_new_1109403.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403072", "story_v_side_new_1109403.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_24 = math.max(var_301_15, arg_298_1.talkMaxDuration)

			if var_301_14 <= arg_298_1.time_ and arg_298_1.time_ < var_301_14 + var_301_24 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_14) / var_301_24

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_14 + var_301_24 and arg_298_1.time_ < var_301_14 + var_301_24 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play1109403073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 1109403073
		arg_302_1.duration_ = 9.33

		local var_302_0 = {
			ja = 6.7,
			ko = 9.333,
			zh = 9.333
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play1109403074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1038ui_story"].transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.var_.moveOldPos1038ui_story = var_305_0.localPosition
			end

			local var_305_2 = 0.001

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2
				local var_305_4 = Vector3.New(0, -1.11, -5.9)

				var_305_0.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1038ui_story, var_305_4, var_305_3)

				local var_305_5 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_5.x, var_305_5.y, var_305_5.z)

				local var_305_6 = var_305_0.localEulerAngles

				var_305_6.z = 0
				var_305_6.x = 0
				var_305_0.localEulerAngles = var_305_6
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 then
				var_305_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_305_7 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_7.x, var_305_7.y, var_305_7.z)

				local var_305_8 = var_305_0.localEulerAngles

				var_305_8.z = 0
				var_305_8.x = 0
				var_305_0.localEulerAngles = var_305_8
			end

			local var_305_9 = arg_302_1.actors_["1038ui_story"]
			local var_305_10 = 0

			if var_305_10 < arg_302_1.time_ and arg_302_1.time_ <= var_305_10 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect1038ui_story == nil then
				arg_302_1.var_.characterEffect1038ui_story = var_305_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_11 = 0.200000002980232

			if var_305_10 <= arg_302_1.time_ and arg_302_1.time_ < var_305_10 + var_305_11 and not isNil(var_305_9) then
				local var_305_12 = (arg_302_1.time_ - var_305_10) / var_305_11

				if arg_302_1.var_.characterEffect1038ui_story and not isNil(var_305_9) then
					arg_302_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_10 + var_305_11 and arg_302_1.time_ < var_305_10 + var_305_11 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect1038ui_story then
				arg_302_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_305_13 = 0

			if var_305_13 < arg_302_1.time_ and arg_302_1.time_ <= var_305_13 + arg_305_0 then
				arg_302_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action467")
			end

			local var_305_14 = 0

			if var_305_14 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_305_15 = 0
			local var_305_16 = 1.025

			if var_305_15 < arg_302_1.time_ and arg_302_1.time_ <= var_305_15 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_17 = arg_302_1:FormatText(StoryNameCfg[94].name)

				arg_302_1.leftNameTxt_.text = var_305_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_18 = arg_302_1:GetWordFromCfg(1109403073)
				local var_305_19 = arg_302_1:FormatText(var_305_18.content)

				arg_302_1.text_.text = var_305_19

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_20 = 41
				local var_305_21 = utf8.len(var_305_19)
				local var_305_22 = var_305_20 <= 0 and var_305_16 or var_305_16 * (var_305_21 / var_305_20)

				if var_305_22 > 0 and var_305_16 < var_305_22 then
					arg_302_1.talkMaxDuration = var_305_22

					if var_305_22 + var_305_15 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_22 + var_305_15
					end
				end

				arg_302_1.text_.text = var_305_19
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403073", "story_v_side_new_1109403.awb") ~= 0 then
					local var_305_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403073", "story_v_side_new_1109403.awb") / 1000

					if var_305_23 + var_305_15 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_23 + var_305_15
					end

					if var_305_18.prefab_name ~= "" and arg_302_1.actors_[var_305_18.prefab_name] ~= nil then
						local var_305_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_18.prefab_name].transform, "story_v_side_new_1109403", "1109403073", "story_v_side_new_1109403.awb")

						arg_302_1:RecordAudio("1109403073", var_305_24)
						arg_302_1:RecordAudio("1109403073", var_305_24)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403073", "story_v_side_new_1109403.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403073", "story_v_side_new_1109403.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_25 = math.max(var_305_16, arg_302_1.talkMaxDuration)

			if var_305_15 <= arg_302_1.time_ and arg_302_1.time_ < var_305_15 + var_305_25 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_15) / var_305_25

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_15 + var_305_25 and arg_302_1.time_ < var_305_15 + var_305_25 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play1109403074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 1109403074
		arg_306_1.duration_ = 20.7

		local var_306_0 = {
			ja = 20.7,
			ko = 14.066,
			zh = 14.066
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play1109403075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1038ui_story"].transform
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.var_.moveOldPos1038ui_story = var_309_0.localPosition
			end

			local var_309_2 = 0.001

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2
				local var_309_4 = Vector3.New(0, -1.11, -5.9)

				var_309_0.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1038ui_story, var_309_4, var_309_3)

				local var_309_5 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_5.x, var_309_5.y, var_309_5.z)

				local var_309_6 = var_309_0.localEulerAngles

				var_309_6.z = 0
				var_309_6.x = 0
				var_309_0.localEulerAngles = var_309_6
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 then
				var_309_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_309_7 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_7.x, var_309_7.y, var_309_7.z)

				local var_309_8 = var_309_0.localEulerAngles

				var_309_8.z = 0
				var_309_8.x = 0
				var_309_0.localEulerAngles = var_309_8
			end

			local var_309_9 = arg_306_1.actors_["1038ui_story"]
			local var_309_10 = 0

			if var_309_10 < arg_306_1.time_ and arg_306_1.time_ <= var_309_10 + arg_309_0 and not isNil(var_309_9) and arg_306_1.var_.characterEffect1038ui_story == nil then
				arg_306_1.var_.characterEffect1038ui_story = var_309_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_11 = 0.200000002980232

			if var_309_10 <= arg_306_1.time_ and arg_306_1.time_ < var_309_10 + var_309_11 and not isNil(var_309_9) then
				local var_309_12 = (arg_306_1.time_ - var_309_10) / var_309_11

				if arg_306_1.var_.characterEffect1038ui_story and not isNil(var_309_9) then
					arg_306_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= var_309_10 + var_309_11 and arg_306_1.time_ < var_309_10 + var_309_11 + arg_309_0 and not isNil(var_309_9) and arg_306_1.var_.characterEffect1038ui_story then
				arg_306_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_309_13 = 0

			if var_309_13 < arg_306_1.time_ and arg_306_1.time_ <= var_309_13 + arg_309_0 then
				arg_306_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_309_14 = 0
			local var_309_15 = 1.675

			if var_309_14 < arg_306_1.time_ and arg_306_1.time_ <= var_309_14 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_16 = arg_306_1:FormatText(StoryNameCfg[94].name)

				arg_306_1.leftNameTxt_.text = var_309_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_17 = arg_306_1:GetWordFromCfg(1109403074)
				local var_309_18 = arg_306_1:FormatText(var_309_17.content)

				arg_306_1.text_.text = var_309_18

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_19 = 67
				local var_309_20 = utf8.len(var_309_18)
				local var_309_21 = var_309_19 <= 0 and var_309_15 or var_309_15 * (var_309_20 / var_309_19)

				if var_309_21 > 0 and var_309_15 < var_309_21 then
					arg_306_1.talkMaxDuration = var_309_21

					if var_309_21 + var_309_14 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_21 + var_309_14
					end
				end

				arg_306_1.text_.text = var_309_18
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403074", "story_v_side_new_1109403.awb") ~= 0 then
					local var_309_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403074", "story_v_side_new_1109403.awb") / 1000

					if var_309_22 + var_309_14 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_22 + var_309_14
					end

					if var_309_17.prefab_name ~= "" and arg_306_1.actors_[var_309_17.prefab_name] ~= nil then
						local var_309_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_17.prefab_name].transform, "story_v_side_new_1109403", "1109403074", "story_v_side_new_1109403.awb")

						arg_306_1:RecordAudio("1109403074", var_309_23)
						arg_306_1:RecordAudio("1109403074", var_309_23)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403074", "story_v_side_new_1109403.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403074", "story_v_side_new_1109403.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_24 = math.max(var_309_15, arg_306_1.talkMaxDuration)

			if var_309_14 <= arg_306_1.time_ and arg_306_1.time_ < var_309_14 + var_309_24 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_14) / var_309_24

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_14 + var_309_24 and arg_306_1.time_ < var_309_14 + var_309_24 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play1109403075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 1109403075
		arg_310_1.duration_ = 0.2

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"

			SetActive(arg_310_1.choicesGo_, true)

			for iter_311_0, iter_311_1 in ipairs(arg_310_1.choices_) do
				local var_311_0 = iter_311_0 <= 1

				SetActive(iter_311_1.go, var_311_0)
			end

			arg_310_1.choices_[1].txt.text = arg_310_1:FormatText(StoryChoiceCfg[410].name)
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play1109403076(arg_310_1)
			end

			arg_310_1:RecordChoiceLog(1109403075, 410)
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["1038ui_story"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1038ui_story == nil then
				arg_310_1.var_.characterEffect1038ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.characterEffect1038ui_story and not isNil(var_313_0) then
					local var_313_4 = Mathf.Lerp(0, 0.5, var_313_3)

					arg_310_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_310_1.var_.characterEffect1038ui_story.fillRatio = var_313_4
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1038ui_story then
				local var_313_5 = 0.5

				arg_310_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_310_1.var_.characterEffect1038ui_story.fillRatio = var_313_5
			end

			local var_313_6 = 0

			if var_313_6 < arg_310_1.time_ and arg_310_1.time_ <= var_313_6 + arg_313_0 then
				arg_310_1.allBtn_.enabled = false
			end

			local var_313_7 = 0.200000002980232

			if arg_310_1.time_ >= var_313_6 + var_313_7 and arg_310_1.time_ < var_313_6 + var_313_7 + arg_313_0 then
				arg_310_1.allBtn_.enabled = true
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play1109403076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1109403076
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play1109403077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1038ui_story"].transform
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1.var_.moveOldPos1038ui_story = var_317_0.localPosition
			end

			local var_317_2 = 0.001

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2
				local var_317_4 = Vector3.New(0, 100, 0)

				var_317_0.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos1038ui_story, var_317_4, var_317_3)

				local var_317_5 = manager.ui.mainCamera.transform.position - var_317_0.position

				var_317_0.forward = Vector3.New(var_317_5.x, var_317_5.y, var_317_5.z)

				local var_317_6 = var_317_0.localEulerAngles

				var_317_6.z = 0
				var_317_6.x = 0
				var_317_0.localEulerAngles = var_317_6
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 then
				var_317_0.localPosition = Vector3.New(0, 100, 0)

				local var_317_7 = manager.ui.mainCamera.transform.position - var_317_0.position

				var_317_0.forward = Vector3.New(var_317_7.x, var_317_7.y, var_317_7.z)

				local var_317_8 = var_317_0.localEulerAngles

				var_317_8.z = 0
				var_317_8.x = 0
				var_317_0.localEulerAngles = var_317_8
			end

			local var_317_9 = arg_314_1.actors_["1038ui_story"]
			local var_317_10 = 0

			if var_317_10 < arg_314_1.time_ and arg_314_1.time_ <= var_317_10 + arg_317_0 and not isNil(var_317_9) and arg_314_1.var_.characterEffect1038ui_story == nil then
				arg_314_1.var_.characterEffect1038ui_story = var_317_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_11 = 0.200000002980232

			if var_317_10 <= arg_314_1.time_ and arg_314_1.time_ < var_317_10 + var_317_11 and not isNil(var_317_9) then
				local var_317_12 = (arg_314_1.time_ - var_317_10) / var_317_11

				if arg_314_1.var_.characterEffect1038ui_story and not isNil(var_317_9) then
					local var_317_13 = Mathf.Lerp(0, 0.5, var_317_12)

					arg_314_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_314_1.var_.characterEffect1038ui_story.fillRatio = var_317_13
				end
			end

			if arg_314_1.time_ >= var_317_10 + var_317_11 and arg_314_1.time_ < var_317_10 + var_317_11 + arg_317_0 and not isNil(var_317_9) and arg_314_1.var_.characterEffect1038ui_story then
				local var_317_14 = 0.5

				arg_314_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_314_1.var_.characterEffect1038ui_story.fillRatio = var_317_14
			end

			local var_317_15 = 0
			local var_317_16 = 0.9

			if var_317_15 < arg_314_1.time_ and arg_314_1.time_ <= var_317_15 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_17 = arg_314_1:GetWordFromCfg(1109403076)
				local var_317_18 = arg_314_1:FormatText(var_317_17.content)

				arg_314_1.text_.text = var_317_18

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_19 = 36
				local var_317_20 = utf8.len(var_317_18)
				local var_317_21 = var_317_19 <= 0 and var_317_16 or var_317_16 * (var_317_20 / var_317_19)

				if var_317_21 > 0 and var_317_16 < var_317_21 then
					arg_314_1.talkMaxDuration = var_317_21

					if var_317_21 + var_317_15 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_21 + var_317_15
					end
				end

				arg_314_1.text_.text = var_317_18
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_22 = math.max(var_317_16, arg_314_1.talkMaxDuration)

			if var_317_15 <= arg_314_1.time_ and arg_314_1.time_ < var_317_15 + var_317_22 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_15) / var_317_22

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_15 + var_317_22 and arg_314_1.time_ < var_317_15 + var_317_22 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play1109403077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1109403077
		arg_318_1.duration_ = 13.13

		local var_318_0 = {
			ja = 7.933,
			ko = 13.133,
			zh = 13.133
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play1109403078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 2

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				local var_321_1 = manager.ui.mainCamera.transform.localPosition
				local var_321_2 = Vector3.New(0, 0, 10) + Vector3.New(var_321_1.x, var_321_1.y, 0)
				local var_321_3 = arg_318_1.bgs_.ST01

				var_321_3.transform.localPosition = var_321_2
				var_321_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_321_4 = var_321_3:GetComponent("SpriteRenderer")

				if var_321_4 and var_321_4.sprite then
					local var_321_5 = (var_321_3.transform.localPosition - var_321_1).z
					local var_321_6 = manager.ui.mainCameraCom_
					local var_321_7 = 2 * var_321_5 * Mathf.Tan(var_321_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_321_8 = var_321_7 * var_321_6.aspect
					local var_321_9 = var_321_4.sprite.bounds.size.x
					local var_321_10 = var_321_4.sprite.bounds.size.y
					local var_321_11 = var_321_8 / var_321_9
					local var_321_12 = var_321_7 / var_321_10
					local var_321_13 = var_321_12 < var_321_11 and var_321_11 or var_321_12

					var_321_3.transform.localScale = Vector3.New(var_321_13, var_321_13, 0)
				end

				for iter_321_0, iter_321_1 in pairs(arg_318_1.bgs_) do
					if iter_321_0 ~= "ST01" then
						iter_321_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_321_14 = 0

			if var_321_14 < arg_318_1.time_ and arg_318_1.time_ <= var_321_14 + arg_321_0 then
				arg_318_1.mask_.enabled = true
				arg_318_1.mask_.raycastTarget = true

				arg_318_1:SetGaussion(false)
			end

			local var_321_15 = 2

			if var_321_14 <= arg_318_1.time_ and arg_318_1.time_ < var_321_14 + var_321_15 then
				local var_321_16 = (arg_318_1.time_ - var_321_14) / var_321_15
				local var_321_17 = Color.New(0, 0, 0)

				var_321_17.a = Mathf.Lerp(0, 1, var_321_16)
				arg_318_1.mask_.color = var_321_17
			end

			if arg_318_1.time_ >= var_321_14 + var_321_15 and arg_318_1.time_ < var_321_14 + var_321_15 + arg_321_0 then
				local var_321_18 = Color.New(0, 0, 0)

				var_321_18.a = 1
				arg_318_1.mask_.color = var_321_18
			end

			local var_321_19 = 2

			if var_321_19 < arg_318_1.time_ and arg_318_1.time_ <= var_321_19 + arg_321_0 then
				arg_318_1.mask_.enabled = true
				arg_318_1.mask_.raycastTarget = true

				arg_318_1:SetGaussion(false)
			end

			local var_321_20 = 2

			if var_321_19 <= arg_318_1.time_ and arg_318_1.time_ < var_321_19 + var_321_20 then
				local var_321_21 = (arg_318_1.time_ - var_321_19) / var_321_20
				local var_321_22 = Color.New(0, 0, 0)

				var_321_22.a = Mathf.Lerp(1, 0, var_321_21)
				arg_318_1.mask_.color = var_321_22
			end

			if arg_318_1.time_ >= var_321_19 + var_321_20 and arg_318_1.time_ < var_321_19 + var_321_20 + arg_321_0 then
				local var_321_23 = Color.New(0, 0, 0)
				local var_321_24 = 0

				arg_318_1.mask_.enabled = false
				var_321_23.a = var_321_24
				arg_318_1.mask_.color = var_321_23
			end

			local var_321_25 = arg_318_1.actors_["1094ui_story"].transform
			local var_321_26 = 4

			if var_321_26 < arg_318_1.time_ and arg_318_1.time_ <= var_321_26 + arg_321_0 then
				arg_318_1.var_.moveOldPos1094ui_story = var_321_25.localPosition
			end

			local var_321_27 = 0.001

			if var_321_26 <= arg_318_1.time_ and arg_318_1.time_ < var_321_26 + var_321_27 then
				local var_321_28 = (arg_318_1.time_ - var_321_26) / var_321_27
				local var_321_29 = Vector3.New(0, -0.84, -6.1)

				var_321_25.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1094ui_story, var_321_29, var_321_28)

				local var_321_30 = manager.ui.mainCamera.transform.position - var_321_25.position

				var_321_25.forward = Vector3.New(var_321_30.x, var_321_30.y, var_321_30.z)

				local var_321_31 = var_321_25.localEulerAngles

				var_321_31.z = 0
				var_321_31.x = 0
				var_321_25.localEulerAngles = var_321_31
			end

			if arg_318_1.time_ >= var_321_26 + var_321_27 and arg_318_1.time_ < var_321_26 + var_321_27 + arg_321_0 then
				var_321_25.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_321_32 = manager.ui.mainCamera.transform.position - var_321_25.position

				var_321_25.forward = Vector3.New(var_321_32.x, var_321_32.y, var_321_32.z)

				local var_321_33 = var_321_25.localEulerAngles

				var_321_33.z = 0
				var_321_33.x = 0
				var_321_25.localEulerAngles = var_321_33
			end

			local var_321_34 = arg_318_1.actors_["1094ui_story"]
			local var_321_35 = 4

			if var_321_35 < arg_318_1.time_ and arg_318_1.time_ <= var_321_35 + arg_321_0 and not isNil(var_321_34) and arg_318_1.var_.characterEffect1094ui_story == nil then
				arg_318_1.var_.characterEffect1094ui_story = var_321_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_36 = 0.200000002980232

			if var_321_35 <= arg_318_1.time_ and arg_318_1.time_ < var_321_35 + var_321_36 and not isNil(var_321_34) then
				local var_321_37 = (arg_318_1.time_ - var_321_35) / var_321_36

				if arg_318_1.var_.characterEffect1094ui_story and not isNil(var_321_34) then
					arg_318_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= var_321_35 + var_321_36 and arg_318_1.time_ < var_321_35 + var_321_36 + arg_321_0 and not isNil(var_321_34) and arg_318_1.var_.characterEffect1094ui_story then
				arg_318_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_321_38 = 4

			if var_321_38 < arg_318_1.time_ and arg_318_1.time_ <= var_321_38 + arg_321_0 then
				arg_318_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_321_39 = 4

			if var_321_39 < arg_318_1.time_ and arg_318_1.time_ <= var_321_39 + arg_321_0 then
				arg_318_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_321_40 = 0
			local var_321_41 = 0.3

			if var_321_40 < arg_318_1.time_ and arg_318_1.time_ <= var_321_40 + arg_321_0 then
				local var_321_42 = "play"
				local var_321_43 = "music"

				arg_318_1:AudioAction(var_321_42, var_321_43, "ui_battle", "ui_battle_stopbgm", "")

				local var_321_44 = ""
				local var_321_45 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_321_45 ~= "" then
					if arg_318_1.bgmTxt_.text ~= var_321_45 and arg_318_1.bgmTxt_.text ~= "" then
						if arg_318_1.bgmTxt2_.text ~= "" then
							arg_318_1.bgmTxt_.text = arg_318_1.bgmTxt2_.text
						end

						arg_318_1.bgmTxt2_.text = var_321_45

						arg_318_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_318_1.bgmTxt_.text = var_321_45
						arg_318_1.bgmTxt2_.text = var_321_45
					end

					if arg_318_1.bgmTimer then
						arg_318_1.bgmTimer:Stop()

						arg_318_1.bgmTimer = nil
					end

					if arg_318_1.settingData.show_music_name == 1 then
						arg_318_1.musicController:SetSelectedState("show")
						arg_318_1.musicAnimator_:Play("open", 0, 0)

						if arg_318_1.settingData.music_time ~= 0 then
							arg_318_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_318_1.settingData.music_time), function()
								if arg_318_1 == nil or isNil(arg_318_1.bgmTxt_) then
									return
								end

								arg_318_1.musicController:SetSelectedState("hide")
								arg_318_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_321_46 = 3.63333333333333
			local var_321_47 = 1

			if var_321_46 < arg_318_1.time_ and arg_318_1.time_ <= var_321_46 + arg_321_0 then
				local var_321_48 = "play"
				local var_321_49 = "music"

				arg_318_1:AudioAction(var_321_48, var_321_49, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_321_50 = ""
				local var_321_51 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_321_51 ~= "" then
					if arg_318_1.bgmTxt_.text ~= var_321_51 and arg_318_1.bgmTxt_.text ~= "" then
						if arg_318_1.bgmTxt2_.text ~= "" then
							arg_318_1.bgmTxt_.text = arg_318_1.bgmTxt2_.text
						end

						arg_318_1.bgmTxt2_.text = var_321_51

						arg_318_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_318_1.bgmTxt_.text = var_321_51
						arg_318_1.bgmTxt2_.text = var_321_51
					end

					if arg_318_1.bgmTimer then
						arg_318_1.bgmTimer:Stop()

						arg_318_1.bgmTimer = nil
					end

					if arg_318_1.settingData.show_music_name == 1 then
						arg_318_1.musicController:SetSelectedState("show")
						arg_318_1.musicAnimator_:Play("open", 0, 0)

						if arg_318_1.settingData.music_time ~= 0 then
							arg_318_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_318_1.settingData.music_time), function()
								if arg_318_1 == nil or isNil(arg_318_1.bgmTxt_) then
									return
								end

								arg_318_1.musicController:SetSelectedState("hide")
								arg_318_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_318_1.frameCnt_ <= 1 then
				arg_318_1.dialog_:SetActive(false)
			end

			local var_321_52 = 4
			local var_321_53 = 0.75

			if var_321_52 < arg_318_1.time_ and arg_318_1.time_ <= var_321_52 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0

				arg_318_1.dialog_:SetActive(true)

				arg_318_1.dialogCg_.alpha = 0

				local var_321_54 = LeanTween.value(arg_318_1.dialog_, 0, 1, 0.3)

				var_321_54:setOnUpdate(LuaHelper.FloatAction(function(arg_324_0)
					arg_318_1.dialogCg_.alpha = arg_324_0
				end))
				var_321_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_318_1.dialog_)
					var_321_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_318_1.duration_ = arg_318_1.duration_ + 0.3

				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_55 = arg_318_1:FormatText(StoryNameCfg[181].name)

				arg_318_1.leftNameTxt_.text = var_321_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_56 = arg_318_1:GetWordFromCfg(1109403077)
				local var_321_57 = arg_318_1:FormatText(var_321_56.content)

				arg_318_1.text_.text = var_321_57

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_58 = 30
				local var_321_59 = utf8.len(var_321_57)
				local var_321_60 = var_321_58 <= 0 and var_321_53 or var_321_53 * (var_321_59 / var_321_58)

				if var_321_60 > 0 and var_321_53 < var_321_60 then
					arg_318_1.talkMaxDuration = var_321_60
					var_321_52 = var_321_52 + 0.3

					if var_321_60 + var_321_52 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_60 + var_321_52
					end
				end

				arg_318_1.text_.text = var_321_57
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403077", "story_v_side_new_1109403.awb") ~= 0 then
					local var_321_61 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403077", "story_v_side_new_1109403.awb") / 1000

					if var_321_61 + var_321_52 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_61 + var_321_52
					end

					if var_321_56.prefab_name ~= "" and arg_318_1.actors_[var_321_56.prefab_name] ~= nil then
						local var_321_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_56.prefab_name].transform, "story_v_side_new_1109403", "1109403077", "story_v_side_new_1109403.awb")

						arg_318_1:RecordAudio("1109403077", var_321_62)
						arg_318_1:RecordAudio("1109403077", var_321_62)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403077", "story_v_side_new_1109403.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403077", "story_v_side_new_1109403.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_63 = var_321_52 + 0.3
			local var_321_64 = math.max(var_321_53, arg_318_1.talkMaxDuration)

			if var_321_63 <= arg_318_1.time_ and arg_318_1.time_ < var_321_63 + var_321_64 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_63) / var_321_64

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_63 + var_321_64 and arg_318_1.time_ < var_321_63 + var_321_64 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play1109403078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1109403078
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1109403079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["1094ui_story"]
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.characterEffect1094ui_story == nil then
				arg_326_1.var_.characterEffect1094ui_story = var_329_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.200000002980232

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 and not isNil(var_329_0) then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2

				if arg_326_1.var_.characterEffect1094ui_story and not isNil(var_329_0) then
					local var_329_4 = Mathf.Lerp(0, 0.5, var_329_3)

					arg_326_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_326_1.var_.characterEffect1094ui_story.fillRatio = var_329_4
				end
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.characterEffect1094ui_story then
				local var_329_5 = 0.5

				arg_326_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_326_1.var_.characterEffect1094ui_story.fillRatio = var_329_5
			end

			local var_329_6 = 0
			local var_329_7 = 0.55

			if var_329_6 < arg_326_1.time_ and arg_326_1.time_ <= var_329_6 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_8 = arg_326_1:GetWordFromCfg(1109403078)
				local var_329_9 = arg_326_1:FormatText(var_329_8.content)

				arg_326_1.text_.text = var_329_9

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_10 = 22
				local var_329_11 = utf8.len(var_329_9)
				local var_329_12 = var_329_10 <= 0 and var_329_7 or var_329_7 * (var_329_11 / var_329_10)

				if var_329_12 > 0 and var_329_7 < var_329_12 then
					arg_326_1.talkMaxDuration = var_329_12

					if var_329_12 + var_329_6 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_12 + var_329_6
					end
				end

				arg_326_1.text_.text = var_329_9
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_13 = math.max(var_329_7, arg_326_1.talkMaxDuration)

			if var_329_6 <= arg_326_1.time_ and arg_326_1.time_ < var_329_6 + var_329_13 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_6) / var_329_13

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_6 + var_329_13 and arg_326_1.time_ < var_329_6 + var_329_13 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play1109403079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1109403079
		arg_330_1.duration_ = 3.97

		local var_330_0 = {
			ja = 3.6,
			ko = 3.966,
			zh = 3.966
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1109403080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["1094ui_story"].transform
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.var_.moveOldPos1094ui_story = var_333_0.localPosition
			end

			local var_333_2 = 0.001

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2
				local var_333_4 = Vector3.New(0, -0.84, -6.1)

				var_333_0.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos1094ui_story, var_333_4, var_333_3)

				local var_333_5 = manager.ui.mainCamera.transform.position - var_333_0.position

				var_333_0.forward = Vector3.New(var_333_5.x, var_333_5.y, var_333_5.z)

				local var_333_6 = var_333_0.localEulerAngles

				var_333_6.z = 0
				var_333_6.x = 0
				var_333_0.localEulerAngles = var_333_6
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 then
				var_333_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_333_7 = manager.ui.mainCamera.transform.position - var_333_0.position

				var_333_0.forward = Vector3.New(var_333_7.x, var_333_7.y, var_333_7.z)

				local var_333_8 = var_333_0.localEulerAngles

				var_333_8.z = 0
				var_333_8.x = 0
				var_333_0.localEulerAngles = var_333_8
			end

			local var_333_9 = arg_330_1.actors_["1094ui_story"]
			local var_333_10 = 0

			if var_333_10 < arg_330_1.time_ and arg_330_1.time_ <= var_333_10 + arg_333_0 and not isNil(var_333_9) and arg_330_1.var_.characterEffect1094ui_story == nil then
				arg_330_1.var_.characterEffect1094ui_story = var_333_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_11 = 0.200000002980232

			if var_333_10 <= arg_330_1.time_ and arg_330_1.time_ < var_333_10 + var_333_11 and not isNil(var_333_9) then
				local var_333_12 = (arg_330_1.time_ - var_333_10) / var_333_11

				if arg_330_1.var_.characterEffect1094ui_story and not isNil(var_333_9) then
					arg_330_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= var_333_10 + var_333_11 and arg_330_1.time_ < var_333_10 + var_333_11 + arg_333_0 and not isNil(var_333_9) and arg_330_1.var_.characterEffect1094ui_story then
				arg_330_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_333_13 = 0

			if var_333_13 < arg_330_1.time_ and arg_330_1.time_ <= var_333_13 + arg_333_0 then
				arg_330_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			local var_333_14 = 0

			if var_333_14 < arg_330_1.time_ and arg_330_1.time_ <= var_333_14 + arg_333_0 then
				arg_330_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_333_15 = 0
			local var_333_16 = 0.3

			if var_333_15 < arg_330_1.time_ and arg_330_1.time_ <= var_333_15 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_17 = arg_330_1:FormatText(StoryNameCfg[181].name)

				arg_330_1.leftNameTxt_.text = var_333_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_18 = arg_330_1:GetWordFromCfg(1109403079)
				local var_333_19 = arg_330_1:FormatText(var_333_18.content)

				arg_330_1.text_.text = var_333_19

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_20 = 12
				local var_333_21 = utf8.len(var_333_19)
				local var_333_22 = var_333_20 <= 0 and var_333_16 or var_333_16 * (var_333_21 / var_333_20)

				if var_333_22 > 0 and var_333_16 < var_333_22 then
					arg_330_1.talkMaxDuration = var_333_22

					if var_333_22 + var_333_15 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_22 + var_333_15
					end
				end

				arg_330_1.text_.text = var_333_19
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403079", "story_v_side_new_1109403.awb") ~= 0 then
					local var_333_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403079", "story_v_side_new_1109403.awb") / 1000

					if var_333_23 + var_333_15 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_23 + var_333_15
					end

					if var_333_18.prefab_name ~= "" and arg_330_1.actors_[var_333_18.prefab_name] ~= nil then
						local var_333_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_18.prefab_name].transform, "story_v_side_new_1109403", "1109403079", "story_v_side_new_1109403.awb")

						arg_330_1:RecordAudio("1109403079", var_333_24)
						arg_330_1:RecordAudio("1109403079", var_333_24)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403079", "story_v_side_new_1109403.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403079", "story_v_side_new_1109403.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_25 = math.max(var_333_16, arg_330_1.talkMaxDuration)

			if var_333_15 <= arg_330_1.time_ and arg_330_1.time_ < var_333_15 + var_333_25 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_15) / var_333_25

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_15 + var_333_25 and arg_330_1.time_ < var_333_15 + var_333_25 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play1109403080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1109403080
		arg_334_1.duration_ = 4.9

		local var_334_0 = {
			ja = 4.9,
			ko = 3.3,
			zh = 3.3
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1109403081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["1094ui_story"]
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect1094ui_story == nil then
				arg_334_1.var_.characterEffect1094ui_story = var_337_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_2 = 0.200000002980232

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 and not isNil(var_337_0) then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2

				if arg_334_1.var_.characterEffect1094ui_story and not isNil(var_337_0) then
					local var_337_4 = Mathf.Lerp(0, 0.5, var_337_3)

					arg_334_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_334_1.var_.characterEffect1094ui_story.fillRatio = var_337_4
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect1094ui_story then
				local var_337_5 = 0.5

				arg_334_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_334_1.var_.characterEffect1094ui_story.fillRatio = var_337_5
			end

			local var_337_6 = 0
			local var_337_7 = 0.35

			if var_337_6 < arg_334_1.time_ and arg_334_1.time_ <= var_337_6 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_8 = arg_334_1:FormatText(StoryNameCfg[177].name)

				arg_334_1.leftNameTxt_.text = var_337_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_9 = arg_334_1:GetWordFromCfg(1109403080)
				local var_337_10 = arg_334_1:FormatText(var_337_9.content)

				arg_334_1.text_.text = var_337_10

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_11 = 14
				local var_337_12 = utf8.len(var_337_10)
				local var_337_13 = var_337_11 <= 0 and var_337_7 or var_337_7 * (var_337_12 / var_337_11)

				if var_337_13 > 0 and var_337_7 < var_337_13 then
					arg_334_1.talkMaxDuration = var_337_13

					if var_337_13 + var_337_6 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_13 + var_337_6
					end
				end

				arg_334_1.text_.text = var_337_10
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403080", "story_v_side_new_1109403.awb") ~= 0 then
					local var_337_14 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403080", "story_v_side_new_1109403.awb") / 1000

					if var_337_14 + var_337_6 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_14 + var_337_6
					end

					if var_337_9.prefab_name ~= "" and arg_334_1.actors_[var_337_9.prefab_name] ~= nil then
						local var_337_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_9.prefab_name].transform, "story_v_side_new_1109403", "1109403080", "story_v_side_new_1109403.awb")

						arg_334_1:RecordAudio("1109403080", var_337_15)
						arg_334_1:RecordAudio("1109403080", var_337_15)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403080", "story_v_side_new_1109403.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403080", "story_v_side_new_1109403.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_16 = math.max(var_337_7, arg_334_1.talkMaxDuration)

			if var_337_6 <= arg_334_1.time_ and arg_334_1.time_ < var_337_6 + var_337_16 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_6) / var_337_16

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_6 + var_337_16 and arg_334_1.time_ < var_337_6 + var_337_16 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play1109403081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1109403081
		arg_338_1.duration_ = 3.07

		local var_338_0 = {
			ja = 3.066,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1109403082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1094ui_story"].transform
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1.var_.moveOldPos1094ui_story = var_341_0.localPosition
			end

			local var_341_2 = 0.001

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2
				local var_341_4 = Vector3.New(0, -0.84, -6.1)

				var_341_0.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1094ui_story, var_341_4, var_341_3)

				local var_341_5 = manager.ui.mainCamera.transform.position - var_341_0.position

				var_341_0.forward = Vector3.New(var_341_5.x, var_341_5.y, var_341_5.z)

				local var_341_6 = var_341_0.localEulerAngles

				var_341_6.z = 0
				var_341_6.x = 0
				var_341_0.localEulerAngles = var_341_6
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 then
				var_341_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_341_7 = manager.ui.mainCamera.transform.position - var_341_0.position

				var_341_0.forward = Vector3.New(var_341_7.x, var_341_7.y, var_341_7.z)

				local var_341_8 = var_341_0.localEulerAngles

				var_341_8.z = 0
				var_341_8.x = 0
				var_341_0.localEulerAngles = var_341_8
			end

			local var_341_9 = arg_338_1.actors_["1094ui_story"]
			local var_341_10 = 0

			if var_341_10 < arg_338_1.time_ and arg_338_1.time_ <= var_341_10 + arg_341_0 and not isNil(var_341_9) and arg_338_1.var_.characterEffect1094ui_story == nil then
				arg_338_1.var_.characterEffect1094ui_story = var_341_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_11 = 0.200000002980232

			if var_341_10 <= arg_338_1.time_ and arg_338_1.time_ < var_341_10 + var_341_11 and not isNil(var_341_9) then
				local var_341_12 = (arg_338_1.time_ - var_341_10) / var_341_11

				if arg_338_1.var_.characterEffect1094ui_story and not isNil(var_341_9) then
					arg_338_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= var_341_10 + var_341_11 and arg_338_1.time_ < var_341_10 + var_341_11 + arg_341_0 and not isNil(var_341_9) and arg_338_1.var_.characterEffect1094ui_story then
				arg_338_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_341_13 = 0

			if var_341_13 < arg_338_1.time_ and arg_338_1.time_ <= var_341_13 + arg_341_0 then
				arg_338_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_341_14 = 0
			local var_341_15 = 0.225

			if var_341_14 < arg_338_1.time_ and arg_338_1.time_ <= var_341_14 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_16 = arg_338_1:FormatText(StoryNameCfg[181].name)

				arg_338_1.leftNameTxt_.text = var_341_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_17 = arg_338_1:GetWordFromCfg(1109403081)
				local var_341_18 = arg_338_1:FormatText(var_341_17.content)

				arg_338_1.text_.text = var_341_18

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_19 = 9
				local var_341_20 = utf8.len(var_341_18)
				local var_341_21 = var_341_19 <= 0 and var_341_15 or var_341_15 * (var_341_20 / var_341_19)

				if var_341_21 > 0 and var_341_15 < var_341_21 then
					arg_338_1.talkMaxDuration = var_341_21

					if var_341_21 + var_341_14 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_21 + var_341_14
					end
				end

				arg_338_1.text_.text = var_341_18
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403081", "story_v_side_new_1109403.awb") ~= 0 then
					local var_341_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403081", "story_v_side_new_1109403.awb") / 1000

					if var_341_22 + var_341_14 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_22 + var_341_14
					end

					if var_341_17.prefab_name ~= "" and arg_338_1.actors_[var_341_17.prefab_name] ~= nil then
						local var_341_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_17.prefab_name].transform, "story_v_side_new_1109403", "1109403081", "story_v_side_new_1109403.awb")

						arg_338_1:RecordAudio("1109403081", var_341_23)
						arg_338_1:RecordAudio("1109403081", var_341_23)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403081", "story_v_side_new_1109403.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403081", "story_v_side_new_1109403.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_24 = math.max(var_341_15, arg_338_1.talkMaxDuration)

			if var_341_14 <= arg_338_1.time_ and arg_338_1.time_ < var_341_14 + var_341_24 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_14) / var_341_24

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_14 + var_341_24 and arg_338_1.time_ < var_341_14 + var_341_24 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play1109403082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1109403082
		arg_342_1.duration_ = 9.17

		local var_342_0 = {
			ja = 9.166,
			ko = 6.266,
			zh = 6.266
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1109403083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1094ui_story"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1094ui_story == nil then
				arg_342_1.var_.characterEffect1094ui_story = var_345_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.characterEffect1094ui_story and not isNil(var_345_0) then
					local var_345_4 = Mathf.Lerp(0, 0.5, var_345_3)

					arg_342_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_342_1.var_.characterEffect1094ui_story.fillRatio = var_345_4
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1094ui_story then
				local var_345_5 = 0.5

				arg_342_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_342_1.var_.characterEffect1094ui_story.fillRatio = var_345_5
			end

			local var_345_6 = 0
			local var_345_7 = 0.8

			if var_345_6 < arg_342_1.time_ and arg_342_1.time_ <= var_345_6 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_8 = arg_342_1:FormatText(StoryNameCfg[177].name)

				arg_342_1.leftNameTxt_.text = var_345_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_9 = arg_342_1:GetWordFromCfg(1109403082)
				local var_345_10 = arg_342_1:FormatText(var_345_9.content)

				arg_342_1.text_.text = var_345_10

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_11 = 32
				local var_345_12 = utf8.len(var_345_10)
				local var_345_13 = var_345_11 <= 0 and var_345_7 or var_345_7 * (var_345_12 / var_345_11)

				if var_345_13 > 0 and var_345_7 < var_345_13 then
					arg_342_1.talkMaxDuration = var_345_13

					if var_345_13 + var_345_6 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_13 + var_345_6
					end
				end

				arg_342_1.text_.text = var_345_10
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403082", "story_v_side_new_1109403.awb") ~= 0 then
					local var_345_14 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403082", "story_v_side_new_1109403.awb") / 1000

					if var_345_14 + var_345_6 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_14 + var_345_6
					end

					if var_345_9.prefab_name ~= "" and arg_342_1.actors_[var_345_9.prefab_name] ~= nil then
						local var_345_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_9.prefab_name].transform, "story_v_side_new_1109403", "1109403082", "story_v_side_new_1109403.awb")

						arg_342_1:RecordAudio("1109403082", var_345_15)
						arg_342_1:RecordAudio("1109403082", var_345_15)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403082", "story_v_side_new_1109403.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403082", "story_v_side_new_1109403.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_16 = math.max(var_345_7, arg_342_1.talkMaxDuration)

			if var_345_6 <= arg_342_1.time_ and arg_342_1.time_ < var_345_6 + var_345_16 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_6) / var_345_16

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_6 + var_345_16 and arg_342_1.time_ < var_345_6 + var_345_16 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play1109403083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1109403083
		arg_346_1.duration_ = 4.8

		local var_346_0 = {
			ja = 4.8,
			ko = 2.8,
			zh = 2.8
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1109403084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0
			local var_349_1 = 0.325

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_2 = arg_346_1:FormatText(StoryNameCfg[177].name)

				arg_346_1.leftNameTxt_.text = var_349_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_3 = arg_346_1:GetWordFromCfg(1109403083)
				local var_349_4 = arg_346_1:FormatText(var_349_3.content)

				arg_346_1.text_.text = var_349_4

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 13
				local var_349_6 = utf8.len(var_349_4)
				local var_349_7 = var_349_5 <= 0 and var_349_1 or var_349_1 * (var_349_6 / var_349_5)

				if var_349_7 > 0 and var_349_1 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_0
					end
				end

				arg_346_1.text_.text = var_349_4
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403083", "story_v_side_new_1109403.awb") ~= 0 then
					local var_349_8 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403083", "story_v_side_new_1109403.awb") / 1000

					if var_349_8 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_0
					end

					if var_349_3.prefab_name ~= "" and arg_346_1.actors_[var_349_3.prefab_name] ~= nil then
						local var_349_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_3.prefab_name].transform, "story_v_side_new_1109403", "1109403083", "story_v_side_new_1109403.awb")

						arg_346_1:RecordAudio("1109403083", var_349_9)
						arg_346_1:RecordAudio("1109403083", var_349_9)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403083", "story_v_side_new_1109403.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403083", "story_v_side_new_1109403.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_10 = math.max(var_349_1, arg_346_1.talkMaxDuration)

			if var_349_0 <= arg_346_1.time_ and arg_346_1.time_ < var_349_0 + var_349_10 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_0) / var_349_10

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_0 + var_349_10 and arg_346_1.time_ < var_349_0 + var_349_10 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play1109403084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1109403084
		arg_350_1.duration_ = 2

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1109403085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1094ui_story"].transform
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
				arg_350_1.var_.moveOldPos1094ui_story = var_353_0.localPosition
			end

			local var_353_2 = 0.001

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2
				local var_353_4 = Vector3.New(0, -0.84, -6.1)

				var_353_0.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1094ui_story, var_353_4, var_353_3)

				local var_353_5 = manager.ui.mainCamera.transform.position - var_353_0.position

				var_353_0.forward = Vector3.New(var_353_5.x, var_353_5.y, var_353_5.z)

				local var_353_6 = var_353_0.localEulerAngles

				var_353_6.z = 0
				var_353_6.x = 0
				var_353_0.localEulerAngles = var_353_6
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 then
				var_353_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_353_7 = manager.ui.mainCamera.transform.position - var_353_0.position

				var_353_0.forward = Vector3.New(var_353_7.x, var_353_7.y, var_353_7.z)

				local var_353_8 = var_353_0.localEulerAngles

				var_353_8.z = 0
				var_353_8.x = 0
				var_353_0.localEulerAngles = var_353_8
			end

			local var_353_9 = arg_350_1.actors_["1094ui_story"]
			local var_353_10 = 0

			if var_353_10 < arg_350_1.time_ and arg_350_1.time_ <= var_353_10 + arg_353_0 and not isNil(var_353_9) and arg_350_1.var_.characterEffect1094ui_story == nil then
				arg_350_1.var_.characterEffect1094ui_story = var_353_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_11 = 0.200000002980232

			if var_353_10 <= arg_350_1.time_ and arg_350_1.time_ < var_353_10 + var_353_11 and not isNil(var_353_9) then
				local var_353_12 = (arg_350_1.time_ - var_353_10) / var_353_11

				if arg_350_1.var_.characterEffect1094ui_story and not isNil(var_353_9) then
					arg_350_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= var_353_10 + var_353_11 and arg_350_1.time_ < var_353_10 + var_353_11 + arg_353_0 and not isNil(var_353_9) and arg_350_1.var_.characterEffect1094ui_story then
				arg_350_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_353_13 = 0

			if var_353_13 < arg_350_1.time_ and arg_350_1.time_ <= var_353_13 + arg_353_0 then
				arg_350_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_2")
			end

			local var_353_14 = 0

			if var_353_14 < arg_350_1.time_ and arg_350_1.time_ <= var_353_14 + arg_353_0 then
				arg_350_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_353_15 = 0
			local var_353_16 = 0.1

			if var_353_15 < arg_350_1.time_ and arg_350_1.time_ <= var_353_15 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_17 = arg_350_1:FormatText(StoryNameCfg[181].name)

				arg_350_1.leftNameTxt_.text = var_353_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_18 = arg_350_1:GetWordFromCfg(1109403084)
				local var_353_19 = arg_350_1:FormatText(var_353_18.content)

				arg_350_1.text_.text = var_353_19

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_20 = 4
				local var_353_21 = utf8.len(var_353_19)
				local var_353_22 = var_353_20 <= 0 and var_353_16 or var_353_16 * (var_353_21 / var_353_20)

				if var_353_22 > 0 and var_353_16 < var_353_22 then
					arg_350_1.talkMaxDuration = var_353_22

					if var_353_22 + var_353_15 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_22 + var_353_15
					end
				end

				arg_350_1.text_.text = var_353_19
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403084", "story_v_side_new_1109403.awb") ~= 0 then
					local var_353_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403084", "story_v_side_new_1109403.awb") / 1000

					if var_353_23 + var_353_15 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_23 + var_353_15
					end

					if var_353_18.prefab_name ~= "" and arg_350_1.actors_[var_353_18.prefab_name] ~= nil then
						local var_353_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_18.prefab_name].transform, "story_v_side_new_1109403", "1109403084", "story_v_side_new_1109403.awb")

						arg_350_1:RecordAudio("1109403084", var_353_24)
						arg_350_1:RecordAudio("1109403084", var_353_24)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403084", "story_v_side_new_1109403.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403084", "story_v_side_new_1109403.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_25 = math.max(var_353_16, arg_350_1.talkMaxDuration)

			if var_353_15 <= arg_350_1.time_ and arg_350_1.time_ < var_353_15 + var_353_25 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_15) / var_353_25

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_15 + var_353_25 and arg_350_1.time_ < var_353_15 + var_353_25 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play1109403085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1109403085
		arg_354_1.duration_ = 2.73

		local var_354_0 = {
			ja = 2.733,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1109403086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["1094ui_story"].transform
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.var_.moveOldPos1094ui_story = var_357_0.localPosition
			end

			local var_357_2 = 0.001

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2
				local var_357_4 = Vector3.New(0, -0.84, -6.1)

				var_357_0.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1094ui_story, var_357_4, var_357_3)

				local var_357_5 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_5.x, var_357_5.y, var_357_5.z)

				local var_357_6 = var_357_0.localEulerAngles

				var_357_6.z = 0
				var_357_6.x = 0
				var_357_0.localEulerAngles = var_357_6
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 then
				var_357_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_357_7 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_7.x, var_357_7.y, var_357_7.z)

				local var_357_8 = var_357_0.localEulerAngles

				var_357_8.z = 0
				var_357_8.x = 0
				var_357_0.localEulerAngles = var_357_8
			end

			local var_357_9 = arg_354_1.actors_["1094ui_story"]
			local var_357_10 = 0

			if var_357_10 < arg_354_1.time_ and arg_354_1.time_ <= var_357_10 + arg_357_0 and not isNil(var_357_9) and arg_354_1.var_.characterEffect1094ui_story == nil then
				arg_354_1.var_.characterEffect1094ui_story = var_357_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_11 = 0.200000002980232

			if var_357_10 <= arg_354_1.time_ and arg_354_1.time_ < var_357_10 + var_357_11 and not isNil(var_357_9) then
				local var_357_12 = (arg_354_1.time_ - var_357_10) / var_357_11

				if arg_354_1.var_.characterEffect1094ui_story and not isNil(var_357_9) then
					arg_354_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= var_357_10 + var_357_11 and arg_354_1.time_ < var_357_10 + var_357_11 + arg_357_0 and not isNil(var_357_9) and arg_354_1.var_.characterEffect1094ui_story then
				arg_354_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_357_13 = 0

			if var_357_13 < arg_354_1.time_ and arg_354_1.time_ <= var_357_13 + arg_357_0 then
				arg_354_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_357_14 = 0
			local var_357_15 = 0.125

			if var_357_14 < arg_354_1.time_ and arg_354_1.time_ <= var_357_14 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_16 = arg_354_1:FormatText(StoryNameCfg[181].name)

				arg_354_1.leftNameTxt_.text = var_357_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_17 = arg_354_1:GetWordFromCfg(1109403085)
				local var_357_18 = arg_354_1:FormatText(var_357_17.content)

				arg_354_1.text_.text = var_357_18

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_19 = 5
				local var_357_20 = utf8.len(var_357_18)
				local var_357_21 = var_357_19 <= 0 and var_357_15 or var_357_15 * (var_357_20 / var_357_19)

				if var_357_21 > 0 and var_357_15 < var_357_21 then
					arg_354_1.talkMaxDuration = var_357_21

					if var_357_21 + var_357_14 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_21 + var_357_14
					end
				end

				arg_354_1.text_.text = var_357_18
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403085", "story_v_side_new_1109403.awb") ~= 0 then
					local var_357_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403085", "story_v_side_new_1109403.awb") / 1000

					if var_357_22 + var_357_14 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_22 + var_357_14
					end

					if var_357_17.prefab_name ~= "" and arg_354_1.actors_[var_357_17.prefab_name] ~= nil then
						local var_357_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_17.prefab_name].transform, "story_v_side_new_1109403", "1109403085", "story_v_side_new_1109403.awb")

						arg_354_1:RecordAudio("1109403085", var_357_23)
						arg_354_1:RecordAudio("1109403085", var_357_23)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403085", "story_v_side_new_1109403.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403085", "story_v_side_new_1109403.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_24 = math.max(var_357_15, arg_354_1.talkMaxDuration)

			if var_357_14 <= arg_354_1.time_ and arg_354_1.time_ < var_357_14 + var_357_24 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_14) / var_357_24

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_14 + var_357_24 and arg_354_1.time_ < var_357_14 + var_357_24 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play1109403086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1109403086
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1109403087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1094ui_story"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1094ui_story == nil then
				arg_358_1.var_.characterEffect1094ui_story = var_361_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.characterEffect1094ui_story and not isNil(var_361_0) then
					local var_361_4 = Mathf.Lerp(0, 0.5, var_361_3)

					arg_358_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_358_1.var_.characterEffect1094ui_story.fillRatio = var_361_4
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1094ui_story then
				local var_361_5 = 0.5

				arg_358_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_358_1.var_.characterEffect1094ui_story.fillRatio = var_361_5
			end

			local var_361_6 = 0
			local var_361_7 = 0.3

			if var_361_6 < arg_358_1.time_ and arg_358_1.time_ <= var_361_6 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_8 = arg_358_1:FormatText(StoryNameCfg[7].name)

				arg_358_1.leftNameTxt_.text = var_361_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_9 = arg_358_1:GetWordFromCfg(1109403086)
				local var_361_10 = arg_358_1:FormatText(var_361_9.content)

				arg_358_1.text_.text = var_361_10

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_11 = 12
				local var_361_12 = utf8.len(var_361_10)
				local var_361_13 = var_361_11 <= 0 and var_361_7 or var_361_7 * (var_361_12 / var_361_11)

				if var_361_13 > 0 and var_361_7 < var_361_13 then
					arg_358_1.talkMaxDuration = var_361_13

					if var_361_13 + var_361_6 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_13 + var_361_6
					end
				end

				arg_358_1.text_.text = var_361_10
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_14 = math.max(var_361_7, arg_358_1.talkMaxDuration)

			if var_361_6 <= arg_358_1.time_ and arg_358_1.time_ < var_361_6 + var_361_14 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_6) / var_361_14

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_6 + var_361_14 and arg_358_1.time_ < var_361_6 + var_361_14 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play1109403087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1109403087
		arg_362_1.duration_ = 9.2

		local var_362_0 = {
			ja = 9.2,
			ko = 5.366,
			zh = 5.366
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1109403088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0
			local var_365_1 = 0.625

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_2 = arg_362_1:FormatText(StoryNameCfg[177].name)

				arg_362_1.leftNameTxt_.text = var_365_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_3 = arg_362_1:GetWordFromCfg(1109403087)
				local var_365_4 = arg_362_1:FormatText(var_365_3.content)

				arg_362_1.text_.text = var_365_4

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 25
				local var_365_6 = utf8.len(var_365_4)
				local var_365_7 = var_365_5 <= 0 and var_365_1 or var_365_1 * (var_365_6 / var_365_5)

				if var_365_7 > 0 and var_365_1 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_0
					end
				end

				arg_362_1.text_.text = var_365_4
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403087", "story_v_side_new_1109403.awb") ~= 0 then
					local var_365_8 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403087", "story_v_side_new_1109403.awb") / 1000

					if var_365_8 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_8 + var_365_0
					end

					if var_365_3.prefab_name ~= "" and arg_362_1.actors_[var_365_3.prefab_name] ~= nil then
						local var_365_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_3.prefab_name].transform, "story_v_side_new_1109403", "1109403087", "story_v_side_new_1109403.awb")

						arg_362_1:RecordAudio("1109403087", var_365_9)
						arg_362_1:RecordAudio("1109403087", var_365_9)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403087", "story_v_side_new_1109403.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403087", "story_v_side_new_1109403.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_10 = math.max(var_365_1, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_10 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_0) / var_365_10

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_10 and arg_362_1.time_ < var_365_0 + var_365_10 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1109403088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1109403088
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1109403089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0
			local var_369_1 = 1.125

			if var_369_0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_2 = arg_366_1:FormatText(StoryNameCfg[7].name)

				arg_366_1.leftNameTxt_.text = var_369_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_3 = arg_366_1:GetWordFromCfg(1109403088)
				local var_369_4 = arg_366_1:FormatText(var_369_3.content)

				arg_366_1.text_.text = var_369_4

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_5 = 45
				local var_369_6 = utf8.len(var_369_4)
				local var_369_7 = var_369_5 <= 0 and var_369_1 or var_369_1 * (var_369_6 / var_369_5)

				if var_369_7 > 0 and var_369_1 < var_369_7 then
					arg_366_1.talkMaxDuration = var_369_7

					if var_369_7 + var_369_0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_7 + var_369_0
					end
				end

				arg_366_1.text_.text = var_369_4
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_8 = math.max(var_369_1, arg_366_1.talkMaxDuration)

			if var_369_0 <= arg_366_1.time_ and arg_366_1.time_ < var_369_0 + var_369_8 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_0) / var_369_8

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_0 + var_369_8 and arg_366_1.time_ < var_369_0 + var_369_8 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1109403089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1109403089
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1109403090(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0
			local var_373_1 = 0.55

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_2 = arg_370_1:FormatText(StoryNameCfg[7].name)

				arg_370_1.leftNameTxt_.text = var_373_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_3 = arg_370_1:GetWordFromCfg(1109403089)
				local var_373_4 = arg_370_1:FormatText(var_373_3.content)

				arg_370_1.text_.text = var_373_4

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 22
				local var_373_6 = utf8.len(var_373_4)
				local var_373_7 = var_373_5 <= 0 and var_373_1 or var_373_1 * (var_373_6 / var_373_5)

				if var_373_7 > 0 and var_373_1 < var_373_7 then
					arg_370_1.talkMaxDuration = var_373_7

					if var_373_7 + var_373_0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_7 + var_373_0
					end
				end

				arg_370_1.text_.text = var_373_4
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_8 = math.max(var_373_1, arg_370_1.talkMaxDuration)

			if var_373_0 <= arg_370_1.time_ and arg_370_1.time_ < var_373_0 + var_373_8 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_0) / var_373_8

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_0 + var_373_8 and arg_370_1.time_ < var_373_0 + var_373_8 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play1109403090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1109403090
		arg_374_1.duration_ = 2.03

		local var_374_0 = {
			ja = 1.999999999999,
			ko = 2.033,
			zh = 2.033
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1109403091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["1094ui_story"].transform
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 then
				arg_374_1.var_.moveOldPos1094ui_story = var_377_0.localPosition
			end

			local var_377_2 = 0.001

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2
				local var_377_4 = Vector3.New(0, -0.84, -6.1)

				var_377_0.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1094ui_story, var_377_4, var_377_3)

				local var_377_5 = manager.ui.mainCamera.transform.position - var_377_0.position

				var_377_0.forward = Vector3.New(var_377_5.x, var_377_5.y, var_377_5.z)

				local var_377_6 = var_377_0.localEulerAngles

				var_377_6.z = 0
				var_377_6.x = 0
				var_377_0.localEulerAngles = var_377_6
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 then
				var_377_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_377_7 = manager.ui.mainCamera.transform.position - var_377_0.position

				var_377_0.forward = Vector3.New(var_377_7.x, var_377_7.y, var_377_7.z)

				local var_377_8 = var_377_0.localEulerAngles

				var_377_8.z = 0
				var_377_8.x = 0
				var_377_0.localEulerAngles = var_377_8
			end

			local var_377_9 = arg_374_1.actors_["1094ui_story"]
			local var_377_10 = 0

			if var_377_10 < arg_374_1.time_ and arg_374_1.time_ <= var_377_10 + arg_377_0 and not isNil(var_377_9) and arg_374_1.var_.characterEffect1094ui_story == nil then
				arg_374_1.var_.characterEffect1094ui_story = var_377_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_11 = 0.200000002980232

			if var_377_10 <= arg_374_1.time_ and arg_374_1.time_ < var_377_10 + var_377_11 and not isNil(var_377_9) then
				local var_377_12 = (arg_374_1.time_ - var_377_10) / var_377_11

				if arg_374_1.var_.characterEffect1094ui_story and not isNil(var_377_9) then
					arg_374_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= var_377_10 + var_377_11 and arg_374_1.time_ < var_377_10 + var_377_11 + arg_377_0 and not isNil(var_377_9) and arg_374_1.var_.characterEffect1094ui_story then
				arg_374_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_377_13 = 0

			if var_377_13 < arg_374_1.time_ and arg_374_1.time_ <= var_377_13 + arg_377_0 then
				arg_374_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_377_14 = 0

			if var_377_14 < arg_374_1.time_ and arg_374_1.time_ <= var_377_14 + arg_377_0 then
				arg_374_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			local var_377_15 = 0
			local var_377_16 = 0.075

			if var_377_15 < arg_374_1.time_ and arg_374_1.time_ <= var_377_15 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_17 = arg_374_1:FormatText(StoryNameCfg[181].name)

				arg_374_1.leftNameTxt_.text = var_377_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_18 = arg_374_1:GetWordFromCfg(1109403090)
				local var_377_19 = arg_374_1:FormatText(var_377_18.content)

				arg_374_1.text_.text = var_377_19

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_20 = 3
				local var_377_21 = utf8.len(var_377_19)
				local var_377_22 = var_377_20 <= 0 and var_377_16 or var_377_16 * (var_377_21 / var_377_20)

				if var_377_22 > 0 and var_377_16 < var_377_22 then
					arg_374_1.talkMaxDuration = var_377_22

					if var_377_22 + var_377_15 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_22 + var_377_15
					end
				end

				arg_374_1.text_.text = var_377_19
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403090", "story_v_side_new_1109403.awb") ~= 0 then
					local var_377_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403090", "story_v_side_new_1109403.awb") / 1000

					if var_377_23 + var_377_15 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_23 + var_377_15
					end

					if var_377_18.prefab_name ~= "" and arg_374_1.actors_[var_377_18.prefab_name] ~= nil then
						local var_377_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_18.prefab_name].transform, "story_v_side_new_1109403", "1109403090", "story_v_side_new_1109403.awb")

						arg_374_1:RecordAudio("1109403090", var_377_24)
						arg_374_1:RecordAudio("1109403090", var_377_24)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403090", "story_v_side_new_1109403.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403090", "story_v_side_new_1109403.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_25 = math.max(var_377_16, arg_374_1.talkMaxDuration)

			if var_377_15 <= arg_374_1.time_ and arg_374_1.time_ < var_377_15 + var_377_25 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_15) / var_377_25

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_15 + var_377_25 and arg_374_1.time_ < var_377_15 + var_377_25 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play1109403091 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1109403091
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1109403092(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1094ui_story"]
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1094ui_story == nil then
				arg_378_1.var_.characterEffect1094ui_story = var_381_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.200000002980232

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 and not isNil(var_381_0) then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2

				if arg_378_1.var_.characterEffect1094ui_story and not isNil(var_381_0) then
					local var_381_4 = Mathf.Lerp(0, 0.5, var_381_3)

					arg_378_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1094ui_story.fillRatio = var_381_4
				end
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1094ui_story then
				local var_381_5 = 0.5

				arg_378_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1094ui_story.fillRatio = var_381_5
			end

			local var_381_6 = 0
			local var_381_7 = 0.95

			if var_381_6 < arg_378_1.time_ and arg_378_1.time_ <= var_381_6 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_8 = arg_378_1:GetWordFromCfg(1109403091)
				local var_381_9 = arg_378_1:FormatText(var_381_8.content)

				arg_378_1.text_.text = var_381_9

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_10 = 38
				local var_381_11 = utf8.len(var_381_9)
				local var_381_12 = var_381_10 <= 0 and var_381_7 or var_381_7 * (var_381_11 / var_381_10)

				if var_381_12 > 0 and var_381_7 < var_381_12 then
					arg_378_1.talkMaxDuration = var_381_12

					if var_381_12 + var_381_6 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_12 + var_381_6
					end
				end

				arg_378_1.text_.text = var_381_9
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_13 = math.max(var_381_7, arg_378_1.talkMaxDuration)

			if var_381_6 <= arg_378_1.time_ and arg_378_1.time_ < var_381_6 + var_381_13 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_6) / var_381_13

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_6 + var_381_13 and arg_378_1.time_ < var_381_6 + var_381_13 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1109403092 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1109403092
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1109403093(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0
			local var_385_1 = 0.175

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_2 = arg_382_1:FormatText(StoryNameCfg[7].name)

				arg_382_1.leftNameTxt_.text = var_385_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_3 = arg_382_1:GetWordFromCfg(1109403092)
				local var_385_4 = arg_382_1:FormatText(var_385_3.content)

				arg_382_1.text_.text = var_385_4

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 7
				local var_385_6 = utf8.len(var_385_4)
				local var_385_7 = var_385_5 <= 0 and var_385_1 or var_385_1 * (var_385_6 / var_385_5)

				if var_385_7 > 0 and var_385_1 < var_385_7 then
					arg_382_1.talkMaxDuration = var_385_7

					if var_385_7 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_7 + var_385_0
					end
				end

				arg_382_1.text_.text = var_385_4
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_8 = math.max(var_385_1, arg_382_1.talkMaxDuration)

			if var_385_0 <= arg_382_1.time_ and arg_382_1.time_ < var_385_0 + var_385_8 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_0) / var_385_8

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_0 + var_385_8 and arg_382_1.time_ < var_385_0 + var_385_8 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play1109403093 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1109403093
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1109403094(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0
			local var_389_1 = 0.3

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_2 = arg_386_1:GetWordFromCfg(1109403093)
				local var_389_3 = arg_386_1:FormatText(var_389_2.content)

				arg_386_1.text_.text = var_389_3

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_4 = 12
				local var_389_5 = utf8.len(var_389_3)
				local var_389_6 = var_389_4 <= 0 and var_389_1 or var_389_1 * (var_389_5 / var_389_4)

				if var_389_6 > 0 and var_389_1 < var_389_6 then
					arg_386_1.talkMaxDuration = var_389_6

					if var_389_6 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_6 + var_389_0
					end
				end

				arg_386_1.text_.text = var_389_3
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_7 = math.max(var_389_1, arg_386_1.talkMaxDuration)

			if var_389_0 <= arg_386_1.time_ and arg_386_1.time_ < var_389_0 + var_389_7 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_0) / var_389_7

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_0 + var_389_7 and arg_386_1.time_ < var_389_0 + var_389_7 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play1109403094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1109403094
		arg_390_1.duration_ = 4.23

		local var_390_0 = {
			ja = 1.999999999999,
			ko = 4.233,
			zh = 4.233
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1109403095(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["1094ui_story"].transform
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.var_.moveOldPos1094ui_story = var_393_0.localPosition
			end

			local var_393_2 = 0.001

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2
				local var_393_4 = Vector3.New(0, -0.84, -6.1)

				var_393_0.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1094ui_story, var_393_4, var_393_3)

				local var_393_5 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_5.x, var_393_5.y, var_393_5.z)

				local var_393_6 = var_393_0.localEulerAngles

				var_393_6.z = 0
				var_393_6.x = 0
				var_393_0.localEulerAngles = var_393_6
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 then
				var_393_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_393_7 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_7.x, var_393_7.y, var_393_7.z)

				local var_393_8 = var_393_0.localEulerAngles

				var_393_8.z = 0
				var_393_8.x = 0
				var_393_0.localEulerAngles = var_393_8
			end

			local var_393_9 = arg_390_1.actors_["1094ui_story"]
			local var_393_10 = 0

			if var_393_10 < arg_390_1.time_ and arg_390_1.time_ <= var_393_10 + arg_393_0 and not isNil(var_393_9) and arg_390_1.var_.characterEffect1094ui_story == nil then
				arg_390_1.var_.characterEffect1094ui_story = var_393_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_11 = 0.200000002980232

			if var_393_10 <= arg_390_1.time_ and arg_390_1.time_ < var_393_10 + var_393_11 and not isNil(var_393_9) then
				local var_393_12 = (arg_390_1.time_ - var_393_10) / var_393_11

				if arg_390_1.var_.characterEffect1094ui_story and not isNil(var_393_9) then
					arg_390_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= var_393_10 + var_393_11 and arg_390_1.time_ < var_393_10 + var_393_11 + arg_393_0 and not isNil(var_393_9) and arg_390_1.var_.characterEffect1094ui_story then
				arg_390_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_393_13 = 0

			if var_393_13 < arg_390_1.time_ and arg_390_1.time_ <= var_393_13 + arg_393_0 then
				arg_390_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_2")
			end

			local var_393_14 = 0

			if var_393_14 < arg_390_1.time_ and arg_390_1.time_ <= var_393_14 + arg_393_0 then
				arg_390_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_393_15 = 0
			local var_393_16 = 0.275

			if var_393_15 < arg_390_1.time_ and arg_390_1.time_ <= var_393_15 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_17 = arg_390_1:FormatText(StoryNameCfg[181].name)

				arg_390_1.leftNameTxt_.text = var_393_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_18 = arg_390_1:GetWordFromCfg(1109403094)
				local var_393_19 = arg_390_1:FormatText(var_393_18.content)

				arg_390_1.text_.text = var_393_19

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_20 = 11
				local var_393_21 = utf8.len(var_393_19)
				local var_393_22 = var_393_20 <= 0 and var_393_16 or var_393_16 * (var_393_21 / var_393_20)

				if var_393_22 > 0 and var_393_16 < var_393_22 then
					arg_390_1.talkMaxDuration = var_393_22

					if var_393_22 + var_393_15 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_22 + var_393_15
					end
				end

				arg_390_1.text_.text = var_393_19
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403094", "story_v_side_new_1109403.awb") ~= 0 then
					local var_393_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403094", "story_v_side_new_1109403.awb") / 1000

					if var_393_23 + var_393_15 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_23 + var_393_15
					end

					if var_393_18.prefab_name ~= "" and arg_390_1.actors_[var_393_18.prefab_name] ~= nil then
						local var_393_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_18.prefab_name].transform, "story_v_side_new_1109403", "1109403094", "story_v_side_new_1109403.awb")

						arg_390_1:RecordAudio("1109403094", var_393_24)
						arg_390_1:RecordAudio("1109403094", var_393_24)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403094", "story_v_side_new_1109403.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403094", "story_v_side_new_1109403.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_25 = math.max(var_393_16, arg_390_1.talkMaxDuration)

			if var_393_15 <= arg_390_1.time_ and arg_390_1.time_ < var_393_15 + var_393_25 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_15) / var_393_25

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_15 + var_393_25 and arg_390_1.time_ < var_393_15 + var_393_25 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play1109403095 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1109403095
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1109403096(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["1094ui_story"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1094ui_story == nil then
				arg_394_1.var_.characterEffect1094ui_story = var_397_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.200000002980232

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.characterEffect1094ui_story and not isNil(var_397_0) then
					local var_397_4 = Mathf.Lerp(0, 0.5, var_397_3)

					arg_394_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1094ui_story.fillRatio = var_397_4
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1094ui_story then
				local var_397_5 = 0.5

				arg_394_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1094ui_story.fillRatio = var_397_5
			end

			local var_397_6 = 0
			local var_397_7 = 0.275

			if var_397_6 < arg_394_1.time_ and arg_394_1.time_ <= var_397_6 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_8 = arg_394_1:FormatText(StoryNameCfg[7].name)

				arg_394_1.leftNameTxt_.text = var_397_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_9 = arg_394_1:GetWordFromCfg(1109403095)
				local var_397_10 = arg_394_1:FormatText(var_397_9.content)

				arg_394_1.text_.text = var_397_10

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_11 = 11
				local var_397_12 = utf8.len(var_397_10)
				local var_397_13 = var_397_11 <= 0 and var_397_7 or var_397_7 * (var_397_12 / var_397_11)

				if var_397_13 > 0 and var_397_7 < var_397_13 then
					arg_394_1.talkMaxDuration = var_397_13

					if var_397_13 + var_397_6 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_13 + var_397_6
					end
				end

				arg_394_1.text_.text = var_397_10
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_14 = math.max(var_397_7, arg_394_1.talkMaxDuration)

			if var_397_6 <= arg_394_1.time_ and arg_394_1.time_ < var_397_6 + var_397_14 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_6) / var_397_14

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_6 + var_397_14 and arg_394_1.time_ < var_397_6 + var_397_14 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1109403096 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1109403096
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1109403097(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 0.95

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_2 = arg_398_1:GetWordFromCfg(1109403096)
				local var_401_3 = arg_398_1:FormatText(var_401_2.content)

				arg_398_1.text_.text = var_401_3

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_4 = 38
				local var_401_5 = utf8.len(var_401_3)
				local var_401_6 = var_401_4 <= 0 and var_401_1 or var_401_1 * (var_401_5 / var_401_4)

				if var_401_6 > 0 and var_401_1 < var_401_6 then
					arg_398_1.talkMaxDuration = var_401_6

					if var_401_6 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_6 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_3
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_7 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_7 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_7

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_7 and arg_398_1.time_ < var_401_0 + var_401_7 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1109403097 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1109403097
		arg_402_1.duration_ = 8.13

		local var_402_0 = {
			ja = 8.133,
			ko = 5.566,
			zh = 5.566
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1109403098(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0
			local var_405_1 = 0.625

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_2 = arg_402_1:FormatText(StoryNameCfg[177].name)

				arg_402_1.leftNameTxt_.text = var_405_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_3 = arg_402_1:GetWordFromCfg(1109403097)
				local var_405_4 = arg_402_1:FormatText(var_405_3.content)

				arg_402_1.text_.text = var_405_4

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 25
				local var_405_6 = utf8.len(var_405_4)
				local var_405_7 = var_405_5 <= 0 and var_405_1 or var_405_1 * (var_405_6 / var_405_5)

				if var_405_7 > 0 and var_405_1 < var_405_7 then
					arg_402_1.talkMaxDuration = var_405_7

					if var_405_7 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_7 + var_405_0
					end
				end

				arg_402_1.text_.text = var_405_4
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403097", "story_v_side_new_1109403.awb") ~= 0 then
					local var_405_8 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403097", "story_v_side_new_1109403.awb") / 1000

					if var_405_8 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_8 + var_405_0
					end

					if var_405_3.prefab_name ~= "" and arg_402_1.actors_[var_405_3.prefab_name] ~= nil then
						local var_405_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_3.prefab_name].transform, "story_v_side_new_1109403", "1109403097", "story_v_side_new_1109403.awb")

						arg_402_1:RecordAudio("1109403097", var_405_9)
						arg_402_1:RecordAudio("1109403097", var_405_9)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403097", "story_v_side_new_1109403.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403097", "story_v_side_new_1109403.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_10 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_10 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_10

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_10 and arg_402_1.time_ < var_405_0 + var_405_10 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1109403098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1109403098
		arg_406_1.duration_ = 2.93

		local var_406_0 = {
			ja = 2.233,
			ko = 2.933,
			zh = 2.933
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1109403099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1094ui_story"].transform
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 then
				arg_406_1.var_.moveOldPos1094ui_story = var_409_0.localPosition
			end

			local var_409_2 = 0.001

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2
				local var_409_4 = Vector3.New(0, -0.84, -6.1)

				var_409_0.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1094ui_story, var_409_4, var_409_3)

				local var_409_5 = manager.ui.mainCamera.transform.position - var_409_0.position

				var_409_0.forward = Vector3.New(var_409_5.x, var_409_5.y, var_409_5.z)

				local var_409_6 = var_409_0.localEulerAngles

				var_409_6.z = 0
				var_409_6.x = 0
				var_409_0.localEulerAngles = var_409_6
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 then
				var_409_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_409_7 = manager.ui.mainCamera.transform.position - var_409_0.position

				var_409_0.forward = Vector3.New(var_409_7.x, var_409_7.y, var_409_7.z)

				local var_409_8 = var_409_0.localEulerAngles

				var_409_8.z = 0
				var_409_8.x = 0
				var_409_0.localEulerAngles = var_409_8
			end

			local var_409_9 = arg_406_1.actors_["1094ui_story"]
			local var_409_10 = 0

			if var_409_10 < arg_406_1.time_ and arg_406_1.time_ <= var_409_10 + arg_409_0 and not isNil(var_409_9) and arg_406_1.var_.characterEffect1094ui_story == nil then
				arg_406_1.var_.characterEffect1094ui_story = var_409_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_11 = 0.200000002980232

			if var_409_10 <= arg_406_1.time_ and arg_406_1.time_ < var_409_10 + var_409_11 and not isNil(var_409_9) then
				local var_409_12 = (arg_406_1.time_ - var_409_10) / var_409_11

				if arg_406_1.var_.characterEffect1094ui_story and not isNil(var_409_9) then
					arg_406_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= var_409_10 + var_409_11 and arg_406_1.time_ < var_409_10 + var_409_11 + arg_409_0 and not isNil(var_409_9) and arg_406_1.var_.characterEffect1094ui_story then
				arg_406_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_409_13 = 0

			if var_409_13 < arg_406_1.time_ and arg_406_1.time_ <= var_409_13 + arg_409_0 then
				arg_406_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_409_14 = 0

			if var_409_14 < arg_406_1.time_ and arg_406_1.time_ <= var_409_14 + arg_409_0 then
				arg_406_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_409_15 = 0
			local var_409_16 = 0.15

			if var_409_15 < arg_406_1.time_ and arg_406_1.time_ <= var_409_15 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_17 = arg_406_1:FormatText(StoryNameCfg[181].name)

				arg_406_1.leftNameTxt_.text = var_409_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_18 = arg_406_1:GetWordFromCfg(1109403098)
				local var_409_19 = arg_406_1:FormatText(var_409_18.content)

				arg_406_1.text_.text = var_409_19

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_20 = 6
				local var_409_21 = utf8.len(var_409_19)
				local var_409_22 = var_409_20 <= 0 and var_409_16 or var_409_16 * (var_409_21 / var_409_20)

				if var_409_22 > 0 and var_409_16 < var_409_22 then
					arg_406_1.talkMaxDuration = var_409_22

					if var_409_22 + var_409_15 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_22 + var_409_15
					end
				end

				arg_406_1.text_.text = var_409_19
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403098", "story_v_side_new_1109403.awb") ~= 0 then
					local var_409_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403098", "story_v_side_new_1109403.awb") / 1000

					if var_409_23 + var_409_15 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_23 + var_409_15
					end

					if var_409_18.prefab_name ~= "" and arg_406_1.actors_[var_409_18.prefab_name] ~= nil then
						local var_409_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_18.prefab_name].transform, "story_v_side_new_1109403", "1109403098", "story_v_side_new_1109403.awb")

						arg_406_1:RecordAudio("1109403098", var_409_24)
						arg_406_1:RecordAudio("1109403098", var_409_24)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403098", "story_v_side_new_1109403.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403098", "story_v_side_new_1109403.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_25 = math.max(var_409_16, arg_406_1.talkMaxDuration)

			if var_409_15 <= arg_406_1.time_ and arg_406_1.time_ < var_409_15 + var_409_25 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_15) / var_409_25

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_15 + var_409_25 and arg_406_1.time_ < var_409_15 + var_409_25 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play1109403099 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1109403099
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1109403100(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["1094ui_story"]
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.characterEffect1094ui_story == nil then
				arg_410_1.var_.characterEffect1094ui_story = var_413_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_2 = 0.200000002980232

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_2 and not isNil(var_413_0) then
				local var_413_3 = (arg_410_1.time_ - var_413_1) / var_413_2

				if arg_410_1.var_.characterEffect1094ui_story and not isNil(var_413_0) then
					local var_413_4 = Mathf.Lerp(0, 0.5, var_413_3)

					arg_410_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_410_1.var_.characterEffect1094ui_story.fillRatio = var_413_4
				end
			end

			if arg_410_1.time_ >= var_413_1 + var_413_2 and arg_410_1.time_ < var_413_1 + var_413_2 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.characterEffect1094ui_story then
				local var_413_5 = 0.5

				arg_410_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_410_1.var_.characterEffect1094ui_story.fillRatio = var_413_5
			end

			local var_413_6 = 0
			local var_413_7 = 0.725

			if var_413_6 < arg_410_1.time_ and arg_410_1.time_ <= var_413_6 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_8 = arg_410_1:FormatText(StoryNameCfg[7].name)

				arg_410_1.leftNameTxt_.text = var_413_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_9 = arg_410_1:GetWordFromCfg(1109403099)
				local var_413_10 = arg_410_1:FormatText(var_413_9.content)

				arg_410_1.text_.text = var_413_10

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_11 = 29
				local var_413_12 = utf8.len(var_413_10)
				local var_413_13 = var_413_11 <= 0 and var_413_7 or var_413_7 * (var_413_12 / var_413_11)

				if var_413_13 > 0 and var_413_7 < var_413_13 then
					arg_410_1.talkMaxDuration = var_413_13

					if var_413_13 + var_413_6 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_13 + var_413_6
					end
				end

				arg_410_1.text_.text = var_413_10
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_14 = math.max(var_413_7, arg_410_1.talkMaxDuration)

			if var_413_6 <= arg_410_1.time_ and arg_410_1.time_ < var_413_6 + var_413_14 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_6) / var_413_14

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_6 + var_413_14 and arg_410_1.time_ < var_413_6 + var_413_14 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play1109403100 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1109403100
		arg_414_1.duration_ = 6.3

		local var_414_0 = {
			ja = 5.5,
			ko = 6.3,
			zh = 6.3
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1109403101(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["1094ui_story"].transform
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 then
				arg_414_1.var_.moveOldPos1094ui_story = var_417_0.localPosition
			end

			local var_417_2 = 0.001

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_2 then
				local var_417_3 = (arg_414_1.time_ - var_417_1) / var_417_2
				local var_417_4 = Vector3.New(0, -0.84, -6.1)

				var_417_0.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1094ui_story, var_417_4, var_417_3)

				local var_417_5 = manager.ui.mainCamera.transform.position - var_417_0.position

				var_417_0.forward = Vector3.New(var_417_5.x, var_417_5.y, var_417_5.z)

				local var_417_6 = var_417_0.localEulerAngles

				var_417_6.z = 0
				var_417_6.x = 0
				var_417_0.localEulerAngles = var_417_6
			end

			if arg_414_1.time_ >= var_417_1 + var_417_2 and arg_414_1.time_ < var_417_1 + var_417_2 + arg_417_0 then
				var_417_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_417_7 = manager.ui.mainCamera.transform.position - var_417_0.position

				var_417_0.forward = Vector3.New(var_417_7.x, var_417_7.y, var_417_7.z)

				local var_417_8 = var_417_0.localEulerAngles

				var_417_8.z = 0
				var_417_8.x = 0
				var_417_0.localEulerAngles = var_417_8
			end

			local var_417_9 = arg_414_1.actors_["1094ui_story"]
			local var_417_10 = 0

			if var_417_10 < arg_414_1.time_ and arg_414_1.time_ <= var_417_10 + arg_417_0 and not isNil(var_417_9) and arg_414_1.var_.characterEffect1094ui_story == nil then
				arg_414_1.var_.characterEffect1094ui_story = var_417_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_11 = 0.200000002980232

			if var_417_10 <= arg_414_1.time_ and arg_414_1.time_ < var_417_10 + var_417_11 and not isNil(var_417_9) then
				local var_417_12 = (arg_414_1.time_ - var_417_10) / var_417_11

				if arg_414_1.var_.characterEffect1094ui_story and not isNil(var_417_9) then
					arg_414_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= var_417_10 + var_417_11 and arg_414_1.time_ < var_417_10 + var_417_11 + arg_417_0 and not isNil(var_417_9) and arg_414_1.var_.characterEffect1094ui_story then
				arg_414_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_417_13 = 0

			if var_417_13 < arg_414_1.time_ and arg_414_1.time_ <= var_417_13 + arg_417_0 then
				arg_414_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_417_14 = 0

			if var_417_14 < arg_414_1.time_ and arg_414_1.time_ <= var_417_14 + arg_417_0 then
				arg_414_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_417_15 = 0
			local var_417_16 = 0.35

			if var_417_15 < arg_414_1.time_ and arg_414_1.time_ <= var_417_15 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_17 = arg_414_1:FormatText(StoryNameCfg[181].name)

				arg_414_1.leftNameTxt_.text = var_417_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_18 = arg_414_1:GetWordFromCfg(1109403100)
				local var_417_19 = arg_414_1:FormatText(var_417_18.content)

				arg_414_1.text_.text = var_417_19

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_20 = 14
				local var_417_21 = utf8.len(var_417_19)
				local var_417_22 = var_417_20 <= 0 and var_417_16 or var_417_16 * (var_417_21 / var_417_20)

				if var_417_22 > 0 and var_417_16 < var_417_22 then
					arg_414_1.talkMaxDuration = var_417_22

					if var_417_22 + var_417_15 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_22 + var_417_15
					end
				end

				arg_414_1.text_.text = var_417_19
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403100", "story_v_side_new_1109403.awb") ~= 0 then
					local var_417_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403100", "story_v_side_new_1109403.awb") / 1000

					if var_417_23 + var_417_15 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_23 + var_417_15
					end

					if var_417_18.prefab_name ~= "" and arg_414_1.actors_[var_417_18.prefab_name] ~= nil then
						local var_417_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_18.prefab_name].transform, "story_v_side_new_1109403", "1109403100", "story_v_side_new_1109403.awb")

						arg_414_1:RecordAudio("1109403100", var_417_24)
						arg_414_1:RecordAudio("1109403100", var_417_24)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403100", "story_v_side_new_1109403.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403100", "story_v_side_new_1109403.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_25 = math.max(var_417_16, arg_414_1.talkMaxDuration)

			if var_417_15 <= arg_414_1.time_ and arg_414_1.time_ < var_417_15 + var_417_25 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_15) / var_417_25

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_15 + var_417_25 and arg_414_1.time_ < var_417_15 + var_417_25 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play1109403101 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1109403101
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1109403102(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["1094ui_story"]
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect1094ui_story == nil then
				arg_418_1.var_.characterEffect1094ui_story = var_421_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_2 = 0.200000002980232

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_2 and not isNil(var_421_0) then
				local var_421_3 = (arg_418_1.time_ - var_421_1) / var_421_2

				if arg_418_1.var_.characterEffect1094ui_story and not isNil(var_421_0) then
					local var_421_4 = Mathf.Lerp(0, 0.5, var_421_3)

					arg_418_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_418_1.var_.characterEffect1094ui_story.fillRatio = var_421_4
				end
			end

			if arg_418_1.time_ >= var_421_1 + var_421_2 and arg_418_1.time_ < var_421_1 + var_421_2 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect1094ui_story then
				local var_421_5 = 0.5

				arg_418_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_418_1.var_.characterEffect1094ui_story.fillRatio = var_421_5
			end

			local var_421_6 = 0
			local var_421_7 = 0.45

			if var_421_6 < arg_418_1.time_ and arg_418_1.time_ <= var_421_6 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, false)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_8 = arg_418_1:GetWordFromCfg(1109403101)
				local var_421_9 = arg_418_1:FormatText(var_421_8.content)

				arg_418_1.text_.text = var_421_9

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_10 = 18
				local var_421_11 = utf8.len(var_421_9)
				local var_421_12 = var_421_10 <= 0 and var_421_7 or var_421_7 * (var_421_11 / var_421_10)

				if var_421_12 > 0 and var_421_7 < var_421_12 then
					arg_418_1.talkMaxDuration = var_421_12

					if var_421_12 + var_421_6 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_12 + var_421_6
					end
				end

				arg_418_1.text_.text = var_421_9
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_13 = math.max(var_421_7, arg_418_1.talkMaxDuration)

			if var_421_6 <= arg_418_1.time_ and arg_418_1.time_ < var_421_6 + var_421_13 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_6) / var_421_13

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_6 + var_421_13 and arg_418_1.time_ < var_421_6 + var_421_13 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play1109403102 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1109403102
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play1109403103(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0
			local var_425_1 = 0.425

			if var_425_0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_2 = arg_422_1:FormatText(StoryNameCfg[7].name)

				arg_422_1.leftNameTxt_.text = var_425_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_3 = arg_422_1:GetWordFromCfg(1109403102)
				local var_425_4 = arg_422_1:FormatText(var_425_3.content)

				arg_422_1.text_.text = var_425_4

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_5 = 17
				local var_425_6 = utf8.len(var_425_4)
				local var_425_7 = var_425_5 <= 0 and var_425_1 or var_425_1 * (var_425_6 / var_425_5)

				if var_425_7 > 0 and var_425_1 < var_425_7 then
					arg_422_1.talkMaxDuration = var_425_7

					if var_425_7 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_7 + var_425_0
					end
				end

				arg_422_1.text_.text = var_425_4
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_8 = math.max(var_425_1, arg_422_1.talkMaxDuration)

			if var_425_0 <= arg_422_1.time_ and arg_422_1.time_ < var_425_0 + var_425_8 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_0) / var_425_8

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_0 + var_425_8 and arg_422_1.time_ < var_425_0 + var_425_8 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play1109403103 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1109403103
		arg_426_1.duration_ = 3.03

		local var_426_0 = {
			ja = 1.999999999999,
			ko = 3.033,
			zh = 3.033
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1109403104(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["1094ui_story"].transform
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 then
				arg_426_1.var_.moveOldPos1094ui_story = var_429_0.localPosition
			end

			local var_429_2 = 0.001

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_2 then
				local var_429_3 = (arg_426_1.time_ - var_429_1) / var_429_2
				local var_429_4 = Vector3.New(0, -0.84, -6.1)

				var_429_0.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1094ui_story, var_429_4, var_429_3)

				local var_429_5 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_5.x, var_429_5.y, var_429_5.z)

				local var_429_6 = var_429_0.localEulerAngles

				var_429_6.z = 0
				var_429_6.x = 0
				var_429_0.localEulerAngles = var_429_6
			end

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 then
				var_429_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_429_7 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_7.x, var_429_7.y, var_429_7.z)

				local var_429_8 = var_429_0.localEulerAngles

				var_429_8.z = 0
				var_429_8.x = 0
				var_429_0.localEulerAngles = var_429_8
			end

			local var_429_9 = arg_426_1.actors_["1094ui_story"]
			local var_429_10 = 0

			if var_429_10 < arg_426_1.time_ and arg_426_1.time_ <= var_429_10 + arg_429_0 and not isNil(var_429_9) and arg_426_1.var_.characterEffect1094ui_story == nil then
				arg_426_1.var_.characterEffect1094ui_story = var_429_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_11 = 0.200000002980232

			if var_429_10 <= arg_426_1.time_ and arg_426_1.time_ < var_429_10 + var_429_11 and not isNil(var_429_9) then
				local var_429_12 = (arg_426_1.time_ - var_429_10) / var_429_11

				if arg_426_1.var_.characterEffect1094ui_story and not isNil(var_429_9) then
					arg_426_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= var_429_10 + var_429_11 and arg_426_1.time_ < var_429_10 + var_429_11 + arg_429_0 and not isNil(var_429_9) and arg_426_1.var_.characterEffect1094ui_story then
				arg_426_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_429_13 = 0

			if var_429_13 < arg_426_1.time_ and arg_426_1.time_ <= var_429_13 + arg_429_0 then
				arg_426_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			local var_429_14 = 0

			if var_429_14 < arg_426_1.time_ and arg_426_1.time_ <= var_429_14 + arg_429_0 then
				arg_426_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_429_15 = 0
			local var_429_16 = 0.175

			if var_429_15 < arg_426_1.time_ and arg_426_1.time_ <= var_429_15 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_17 = arg_426_1:FormatText(StoryNameCfg[181].name)

				arg_426_1.leftNameTxt_.text = var_429_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_18 = arg_426_1:GetWordFromCfg(1109403103)
				local var_429_19 = arg_426_1:FormatText(var_429_18.content)

				arg_426_1.text_.text = var_429_19

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_20 = 7
				local var_429_21 = utf8.len(var_429_19)
				local var_429_22 = var_429_20 <= 0 and var_429_16 or var_429_16 * (var_429_21 / var_429_20)

				if var_429_22 > 0 and var_429_16 < var_429_22 then
					arg_426_1.talkMaxDuration = var_429_22

					if var_429_22 + var_429_15 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_22 + var_429_15
					end
				end

				arg_426_1.text_.text = var_429_19
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403103", "story_v_side_new_1109403.awb") ~= 0 then
					local var_429_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403103", "story_v_side_new_1109403.awb") / 1000

					if var_429_23 + var_429_15 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_23 + var_429_15
					end

					if var_429_18.prefab_name ~= "" and arg_426_1.actors_[var_429_18.prefab_name] ~= nil then
						local var_429_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_18.prefab_name].transform, "story_v_side_new_1109403", "1109403103", "story_v_side_new_1109403.awb")

						arg_426_1:RecordAudio("1109403103", var_429_24)
						arg_426_1:RecordAudio("1109403103", var_429_24)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403103", "story_v_side_new_1109403.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403103", "story_v_side_new_1109403.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_25 = math.max(var_429_16, arg_426_1.talkMaxDuration)

			if var_429_15 <= arg_426_1.time_ and arg_426_1.time_ < var_429_15 + var_429_25 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_15) / var_429_25

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_15 + var_429_25 and arg_426_1.time_ < var_429_15 + var_429_25 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play1109403104 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1109403104
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1109403105(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["1094ui_story"]
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1094ui_story == nil then
				arg_430_1.var_.characterEffect1094ui_story = var_433_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.200000002980232

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 and not isNil(var_433_0) then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2

				if arg_430_1.var_.characterEffect1094ui_story and not isNil(var_433_0) then
					local var_433_4 = Mathf.Lerp(0, 0.5, var_433_3)

					arg_430_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_430_1.var_.characterEffect1094ui_story.fillRatio = var_433_4
				end
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1094ui_story then
				local var_433_5 = 0.5

				arg_430_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_430_1.var_.characterEffect1094ui_story.fillRatio = var_433_5
			end

			local var_433_6 = 0
			local var_433_7 = 0.975

			if var_433_6 < arg_430_1.time_ and arg_430_1.time_ <= var_433_6 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_8 = arg_430_1:FormatText(StoryNameCfg[7].name)

				arg_430_1.leftNameTxt_.text = var_433_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_9 = arg_430_1:GetWordFromCfg(1109403104)
				local var_433_10 = arg_430_1:FormatText(var_433_9.content)

				arg_430_1.text_.text = var_433_10

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_11 = 39
				local var_433_12 = utf8.len(var_433_10)
				local var_433_13 = var_433_11 <= 0 and var_433_7 or var_433_7 * (var_433_12 / var_433_11)

				if var_433_13 > 0 and var_433_7 < var_433_13 then
					arg_430_1.talkMaxDuration = var_433_13

					if var_433_13 + var_433_6 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_13 + var_433_6
					end
				end

				arg_430_1.text_.text = var_433_10
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_14 = math.max(var_433_7, arg_430_1.talkMaxDuration)

			if var_433_6 <= arg_430_1.time_ and arg_430_1.time_ < var_433_6 + var_433_14 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_6) / var_433_14

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_6 + var_433_14 and arg_430_1.time_ < var_433_6 + var_433_14 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play1109403105 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1109403105
		arg_434_1.duration_ = 2.07

		local var_434_0 = {
			ja = 1.999999999999,
			ko = 2.066,
			zh = 2.066
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1109403106(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["1094ui_story"].transform
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 then
				arg_434_1.var_.moveOldPos1094ui_story = var_437_0.localPosition
			end

			local var_437_2 = 0.001

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2
				local var_437_4 = Vector3.New(0, -0.84, -6.1)

				var_437_0.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1094ui_story, var_437_4, var_437_3)

				local var_437_5 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_5.x, var_437_5.y, var_437_5.z)

				local var_437_6 = var_437_0.localEulerAngles

				var_437_6.z = 0
				var_437_6.x = 0
				var_437_0.localEulerAngles = var_437_6
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 then
				var_437_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_437_7 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_7.x, var_437_7.y, var_437_7.z)

				local var_437_8 = var_437_0.localEulerAngles

				var_437_8.z = 0
				var_437_8.x = 0
				var_437_0.localEulerAngles = var_437_8
			end

			local var_437_9 = arg_434_1.actors_["1094ui_story"]
			local var_437_10 = 0

			if var_437_10 < arg_434_1.time_ and arg_434_1.time_ <= var_437_10 + arg_437_0 and not isNil(var_437_9) and arg_434_1.var_.characterEffect1094ui_story == nil then
				arg_434_1.var_.characterEffect1094ui_story = var_437_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_11 = 0.200000002980232

			if var_437_10 <= arg_434_1.time_ and arg_434_1.time_ < var_437_10 + var_437_11 and not isNil(var_437_9) then
				local var_437_12 = (arg_434_1.time_ - var_437_10) / var_437_11

				if arg_434_1.var_.characterEffect1094ui_story and not isNil(var_437_9) then
					arg_434_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= var_437_10 + var_437_11 and arg_434_1.time_ < var_437_10 + var_437_11 + arg_437_0 and not isNil(var_437_9) and arg_434_1.var_.characterEffect1094ui_story then
				arg_434_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_437_13 = 0

			if var_437_13 < arg_434_1.time_ and arg_434_1.time_ <= var_437_13 + arg_437_0 then
				arg_434_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_437_14 = 0
			local var_437_15 = 0.075

			if var_437_14 < arg_434_1.time_ and arg_434_1.time_ <= var_437_14 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_16 = arg_434_1:FormatText(StoryNameCfg[181].name)

				arg_434_1.leftNameTxt_.text = var_437_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_17 = arg_434_1:GetWordFromCfg(1109403105)
				local var_437_18 = arg_434_1:FormatText(var_437_17.content)

				arg_434_1.text_.text = var_437_18

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_19 = 3
				local var_437_20 = utf8.len(var_437_18)
				local var_437_21 = var_437_19 <= 0 and var_437_15 or var_437_15 * (var_437_20 / var_437_19)

				if var_437_21 > 0 and var_437_15 < var_437_21 then
					arg_434_1.talkMaxDuration = var_437_21

					if var_437_21 + var_437_14 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_21 + var_437_14
					end
				end

				arg_434_1.text_.text = var_437_18
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403105", "story_v_side_new_1109403.awb") ~= 0 then
					local var_437_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403105", "story_v_side_new_1109403.awb") / 1000

					if var_437_22 + var_437_14 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_22 + var_437_14
					end

					if var_437_17.prefab_name ~= "" and arg_434_1.actors_[var_437_17.prefab_name] ~= nil then
						local var_437_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_17.prefab_name].transform, "story_v_side_new_1109403", "1109403105", "story_v_side_new_1109403.awb")

						arg_434_1:RecordAudio("1109403105", var_437_23)
						arg_434_1:RecordAudio("1109403105", var_437_23)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403105", "story_v_side_new_1109403.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403105", "story_v_side_new_1109403.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_24 = math.max(var_437_15, arg_434_1.talkMaxDuration)

			if var_437_14 <= arg_434_1.time_ and arg_434_1.time_ < var_437_14 + var_437_24 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_14) / var_437_24

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_14 + var_437_24 and arg_434_1.time_ < var_437_14 + var_437_24 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_434_1:InitPlayNodeList()
	end,
	Play1109403106 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1109403106
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1109403107(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["1094ui_story"]
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect1094ui_story == nil then
				arg_438_1.var_.characterEffect1094ui_story = var_441_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_2 = 0.200000002980232

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 and not isNil(var_441_0) then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2

				if arg_438_1.var_.characterEffect1094ui_story and not isNil(var_441_0) then
					local var_441_4 = Mathf.Lerp(0, 0.5, var_441_3)

					arg_438_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_438_1.var_.characterEffect1094ui_story.fillRatio = var_441_4
				end
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect1094ui_story then
				local var_441_5 = 0.5

				arg_438_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_438_1.var_.characterEffect1094ui_story.fillRatio = var_441_5
			end

			local var_441_6 = 0
			local var_441_7 = 0.2

			if var_441_6 < arg_438_1.time_ and arg_438_1.time_ <= var_441_6 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_8 = arg_438_1:FormatText(StoryNameCfg[7].name)

				arg_438_1.leftNameTxt_.text = var_441_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_9 = arg_438_1:GetWordFromCfg(1109403106)
				local var_441_10 = arg_438_1:FormatText(var_441_9.content)

				arg_438_1.text_.text = var_441_10

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_11 = 8
				local var_441_12 = utf8.len(var_441_10)
				local var_441_13 = var_441_11 <= 0 and var_441_7 or var_441_7 * (var_441_12 / var_441_11)

				if var_441_13 > 0 and var_441_7 < var_441_13 then
					arg_438_1.talkMaxDuration = var_441_13

					if var_441_13 + var_441_6 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_13 + var_441_6
					end
				end

				arg_438_1.text_.text = var_441_10
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_14 = math.max(var_441_7, arg_438_1.talkMaxDuration)

			if var_441_6 <= arg_438_1.time_ and arg_438_1.time_ < var_441_6 + var_441_14 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_6) / var_441_14

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_6 + var_441_14 and arg_438_1.time_ < var_441_6 + var_441_14 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play1109403107 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1109403107
		arg_442_1.duration_ = 4.33

		local var_442_0 = {
			ja = 2.266,
			ko = 4.333,
			zh = 4.333
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1109403108(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["1094ui_story"].transform
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 then
				arg_442_1.var_.moveOldPos1094ui_story = var_445_0.localPosition
			end

			local var_445_2 = 0.001

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2
				local var_445_4 = Vector3.New(0, -0.84, -6.1)

				var_445_0.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1094ui_story, var_445_4, var_445_3)

				local var_445_5 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_5.x, var_445_5.y, var_445_5.z)

				local var_445_6 = var_445_0.localEulerAngles

				var_445_6.z = 0
				var_445_6.x = 0
				var_445_0.localEulerAngles = var_445_6
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 then
				var_445_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_445_7 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_7.x, var_445_7.y, var_445_7.z)

				local var_445_8 = var_445_0.localEulerAngles

				var_445_8.z = 0
				var_445_8.x = 0
				var_445_0.localEulerAngles = var_445_8
			end

			local var_445_9 = arg_442_1.actors_["1094ui_story"]
			local var_445_10 = 0

			if var_445_10 < arg_442_1.time_ and arg_442_1.time_ <= var_445_10 + arg_445_0 and not isNil(var_445_9) and arg_442_1.var_.characterEffect1094ui_story == nil then
				arg_442_1.var_.characterEffect1094ui_story = var_445_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_11 = 0.200000002980232

			if var_445_10 <= arg_442_1.time_ and arg_442_1.time_ < var_445_10 + var_445_11 and not isNil(var_445_9) then
				local var_445_12 = (arg_442_1.time_ - var_445_10) / var_445_11

				if arg_442_1.var_.characterEffect1094ui_story and not isNil(var_445_9) then
					arg_442_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= var_445_10 + var_445_11 and arg_442_1.time_ < var_445_10 + var_445_11 + arg_445_0 and not isNil(var_445_9) and arg_442_1.var_.characterEffect1094ui_story then
				arg_442_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_445_13 = 0

			if var_445_13 < arg_442_1.time_ and arg_442_1.time_ <= var_445_13 + arg_445_0 then
				arg_442_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_2")
			end

			local var_445_14 = 0

			if var_445_14 < arg_442_1.time_ and arg_442_1.time_ <= var_445_14 + arg_445_0 then
				arg_442_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_445_15 = 0
			local var_445_16 = 0.275

			if var_445_15 < arg_442_1.time_ and arg_442_1.time_ <= var_445_15 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_17 = arg_442_1:FormatText(StoryNameCfg[181].name)

				arg_442_1.leftNameTxt_.text = var_445_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_18 = arg_442_1:GetWordFromCfg(1109403107)
				local var_445_19 = arg_442_1:FormatText(var_445_18.content)

				arg_442_1.text_.text = var_445_19

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_20 = 11
				local var_445_21 = utf8.len(var_445_19)
				local var_445_22 = var_445_20 <= 0 and var_445_16 or var_445_16 * (var_445_21 / var_445_20)

				if var_445_22 > 0 and var_445_16 < var_445_22 then
					arg_442_1.talkMaxDuration = var_445_22

					if var_445_22 + var_445_15 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_22 + var_445_15
					end
				end

				arg_442_1.text_.text = var_445_19
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403107", "story_v_side_new_1109403.awb") ~= 0 then
					local var_445_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403107", "story_v_side_new_1109403.awb") / 1000

					if var_445_23 + var_445_15 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_23 + var_445_15
					end

					if var_445_18.prefab_name ~= "" and arg_442_1.actors_[var_445_18.prefab_name] ~= nil then
						local var_445_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_18.prefab_name].transform, "story_v_side_new_1109403", "1109403107", "story_v_side_new_1109403.awb")

						arg_442_1:RecordAudio("1109403107", var_445_24)
						arg_442_1:RecordAudio("1109403107", var_445_24)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403107", "story_v_side_new_1109403.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403107", "story_v_side_new_1109403.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_25 = math.max(var_445_16, arg_442_1.talkMaxDuration)

			if var_445_15 <= arg_442_1.time_ and arg_442_1.time_ < var_445_15 + var_445_25 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_15) / var_445_25

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_15 + var_445_25 and arg_442_1.time_ < var_445_15 + var_445_25 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play1109403108 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1109403108
		arg_446_1.duration_ = 7.27

		local var_446_0 = {
			ja = 7.266,
			ko = 4.8,
			zh = 4.8
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1109403109(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["1094ui_story"]
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.characterEffect1094ui_story == nil then
				arg_446_1.var_.characterEffect1094ui_story = var_449_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_2 = 0.200000002980232

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_2 and not isNil(var_449_0) then
				local var_449_3 = (arg_446_1.time_ - var_449_1) / var_449_2

				if arg_446_1.var_.characterEffect1094ui_story and not isNil(var_449_0) then
					local var_449_4 = Mathf.Lerp(0, 0.5, var_449_3)

					arg_446_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_446_1.var_.characterEffect1094ui_story.fillRatio = var_449_4
				end
			end

			if arg_446_1.time_ >= var_449_1 + var_449_2 and arg_446_1.time_ < var_449_1 + var_449_2 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.characterEffect1094ui_story then
				local var_449_5 = 0.5

				arg_446_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_446_1.var_.characterEffect1094ui_story.fillRatio = var_449_5
			end

			local var_449_6 = 0
			local var_449_7 = 0.65

			if var_449_6 < arg_446_1.time_ and arg_446_1.time_ <= var_449_6 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_8 = arg_446_1:FormatText(StoryNameCfg[177].name)

				arg_446_1.leftNameTxt_.text = var_449_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_9 = arg_446_1:GetWordFromCfg(1109403108)
				local var_449_10 = arg_446_1:FormatText(var_449_9.content)

				arg_446_1.text_.text = var_449_10

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_11 = 26
				local var_449_12 = utf8.len(var_449_10)
				local var_449_13 = var_449_11 <= 0 and var_449_7 or var_449_7 * (var_449_12 / var_449_11)

				if var_449_13 > 0 and var_449_7 < var_449_13 then
					arg_446_1.talkMaxDuration = var_449_13

					if var_449_13 + var_449_6 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_13 + var_449_6
					end
				end

				arg_446_1.text_.text = var_449_10
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403108", "story_v_side_new_1109403.awb") ~= 0 then
					local var_449_14 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403108", "story_v_side_new_1109403.awb") / 1000

					if var_449_14 + var_449_6 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_14 + var_449_6
					end

					if var_449_9.prefab_name ~= "" and arg_446_1.actors_[var_449_9.prefab_name] ~= nil then
						local var_449_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_9.prefab_name].transform, "story_v_side_new_1109403", "1109403108", "story_v_side_new_1109403.awb")

						arg_446_1:RecordAudio("1109403108", var_449_15)
						arg_446_1:RecordAudio("1109403108", var_449_15)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403108", "story_v_side_new_1109403.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403108", "story_v_side_new_1109403.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_16 = math.max(var_449_7, arg_446_1.talkMaxDuration)

			if var_449_6 <= arg_446_1.time_ and arg_446_1.time_ < var_449_6 + var_449_16 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_6) / var_449_16

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_6 + var_449_16 and arg_446_1.time_ < var_449_6 + var_449_16 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play1109403109 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1109403109
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1109403110(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["1094ui_story"].transform
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 then
				arg_450_1.var_.moveOldPos1094ui_story = var_453_0.localPosition
			end

			local var_453_2 = 0.001

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_2 then
				local var_453_3 = (arg_450_1.time_ - var_453_1) / var_453_2
				local var_453_4 = Vector3.New(0, 100, 0)

				var_453_0.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1094ui_story, var_453_4, var_453_3)

				local var_453_5 = manager.ui.mainCamera.transform.position - var_453_0.position

				var_453_0.forward = Vector3.New(var_453_5.x, var_453_5.y, var_453_5.z)

				local var_453_6 = var_453_0.localEulerAngles

				var_453_6.z = 0
				var_453_6.x = 0
				var_453_0.localEulerAngles = var_453_6
			end

			if arg_450_1.time_ >= var_453_1 + var_453_2 and arg_450_1.time_ < var_453_1 + var_453_2 + arg_453_0 then
				var_453_0.localPosition = Vector3.New(0, 100, 0)

				local var_453_7 = manager.ui.mainCamera.transform.position - var_453_0.position

				var_453_0.forward = Vector3.New(var_453_7.x, var_453_7.y, var_453_7.z)

				local var_453_8 = var_453_0.localEulerAngles

				var_453_8.z = 0
				var_453_8.x = 0
				var_453_0.localEulerAngles = var_453_8
			end

			local var_453_9 = 0
			local var_453_10 = 0.425

			if var_453_9 < arg_450_1.time_ and arg_450_1.time_ <= var_453_9 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, false)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_11 = arg_450_1:GetWordFromCfg(1109403109)
				local var_453_12 = arg_450_1:FormatText(var_453_11.content)

				arg_450_1.text_.text = var_453_12

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_13 = 17
				local var_453_14 = utf8.len(var_453_12)
				local var_453_15 = var_453_13 <= 0 and var_453_10 or var_453_10 * (var_453_14 / var_453_13)

				if var_453_15 > 0 and var_453_10 < var_453_15 then
					arg_450_1.talkMaxDuration = var_453_15

					if var_453_15 + var_453_9 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_15 + var_453_9
					end
				end

				arg_450_1.text_.text = var_453_12
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_16 = math.max(var_453_10, arg_450_1.talkMaxDuration)

			if var_453_9 <= arg_450_1.time_ and arg_450_1.time_ < var_453_9 + var_453_16 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_9) / var_453_16

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_9 + var_453_16 and arg_450_1.time_ < var_453_9 + var_453_16 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_450_1:InitPlayNodeList()
	end,
	Play1109403110 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1109403110
		arg_454_1.duration_ = 8.47

		local var_454_0 = {
			ja = 8.466,
			ko = 6.6,
			zh = 6.6
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play1109403111(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0
			local var_457_1 = 0.175

			if var_457_0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_2 = arg_454_1:FormatText(StoryNameCfg[181].name)

				arg_454_1.leftNameTxt_.text = var_457_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_3 = arg_454_1:GetWordFromCfg(1109403110)
				local var_457_4 = arg_454_1:FormatText(var_457_3.content)

				arg_454_1.text_.text = var_457_4

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_5 = 7
				local var_457_6 = utf8.len(var_457_4)
				local var_457_7 = var_457_5 <= 0 and var_457_1 or var_457_1 * (var_457_6 / var_457_5)

				if var_457_7 > 0 and var_457_1 < var_457_7 then
					arg_454_1.talkMaxDuration = var_457_7

					if var_457_7 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_7 + var_457_0
					end
				end

				arg_454_1.text_.text = var_457_4
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403110", "story_v_side_new_1109403.awb") ~= 0 then
					local var_457_8 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403110", "story_v_side_new_1109403.awb") / 1000

					if var_457_8 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_8 + var_457_0
					end

					if var_457_3.prefab_name ~= "" and arg_454_1.actors_[var_457_3.prefab_name] ~= nil then
						local var_457_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_3.prefab_name].transform, "story_v_side_new_1109403", "1109403110", "story_v_side_new_1109403.awb")

						arg_454_1:RecordAudio("1109403110", var_457_9)
						arg_454_1:RecordAudio("1109403110", var_457_9)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403110", "story_v_side_new_1109403.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403110", "story_v_side_new_1109403.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_10 = math.max(var_457_1, arg_454_1.talkMaxDuration)

			if var_457_0 <= arg_454_1.time_ and arg_454_1.time_ < var_457_0 + var_457_10 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_0) / var_457_10

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_0 + var_457_10 and arg_454_1.time_ < var_457_0 + var_457_10 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play1109403111 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 1109403111
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play1109403112(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["1094ui_story"]
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1094ui_story == nil then
				arg_458_1.var_.characterEffect1094ui_story = var_461_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_2 = 0.200000002980232

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 and not isNil(var_461_0) then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2

				if arg_458_1.var_.characterEffect1094ui_story and not isNil(var_461_0) then
					local var_461_4 = Mathf.Lerp(0, 0.5, var_461_3)

					arg_458_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1094ui_story.fillRatio = var_461_4
				end
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1094ui_story then
				local var_461_5 = 0.5

				arg_458_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1094ui_story.fillRatio = var_461_5
			end

			local var_461_6 = 0
			local var_461_7 = 0.075

			if var_461_6 < arg_458_1.time_ and arg_458_1.time_ <= var_461_6 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_8 = arg_458_1:FormatText(StoryNameCfg[7].name)

				arg_458_1.leftNameTxt_.text = var_461_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, true)
				arg_458_1.iconController_:SetSelectedState("hero")

				arg_458_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_458_1.callingController_:SetSelectedState("normal")

				arg_458_1.keyicon_.color = Color.New(1, 1, 1)
				arg_458_1.icon_.color = Color.New(1, 1, 1)

				local var_461_9 = arg_458_1:GetWordFromCfg(1109403111)
				local var_461_10 = arg_458_1:FormatText(var_461_9.content)

				arg_458_1.text_.text = var_461_10

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_11 = 3
				local var_461_12 = utf8.len(var_461_10)
				local var_461_13 = var_461_11 <= 0 and var_461_7 or var_461_7 * (var_461_12 / var_461_11)

				if var_461_13 > 0 and var_461_7 < var_461_13 then
					arg_458_1.talkMaxDuration = var_461_13

					if var_461_13 + var_461_6 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_13 + var_461_6
					end
				end

				arg_458_1.text_.text = var_461_10
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_14 = math.max(var_461_7, arg_458_1.talkMaxDuration)

			if var_461_6 <= arg_458_1.time_ and arg_458_1.time_ < var_461_6 + var_461_14 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_6) / var_461_14

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_6 + var_461_14 and arg_458_1.time_ < var_461_6 + var_461_14 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play1109403112 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 1109403112
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play1109403113(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 0
			local var_465_1 = 0.95

			if var_465_0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, false)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_2 = arg_462_1:GetWordFromCfg(1109403112)
				local var_465_3 = arg_462_1:FormatText(var_465_2.content)

				arg_462_1.text_.text = var_465_3

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_4 = 38
				local var_465_5 = utf8.len(var_465_3)
				local var_465_6 = var_465_4 <= 0 and var_465_1 or var_465_1 * (var_465_5 / var_465_4)

				if var_465_6 > 0 and var_465_1 < var_465_6 then
					arg_462_1.talkMaxDuration = var_465_6

					if var_465_6 + var_465_0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_6 + var_465_0
					end
				end

				arg_462_1.text_.text = var_465_3
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_7 = math.max(var_465_1, arg_462_1.talkMaxDuration)

			if var_465_0 <= arg_462_1.time_ and arg_462_1.time_ < var_465_0 + var_465_7 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_0) / var_465_7

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_0 + var_465_7 and arg_462_1.time_ < var_465_0 + var_465_7 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play1109403113 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1109403113
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1109403114(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0
			local var_469_1 = 0.45

			if var_469_0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, false)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_2 = arg_466_1:GetWordFromCfg(1109403113)
				local var_469_3 = arg_466_1:FormatText(var_469_2.content)

				arg_466_1.text_.text = var_469_3

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_4 = 33
				local var_469_5 = utf8.len(var_469_3)
				local var_469_6 = var_469_4 <= 0 and var_469_1 or var_469_1 * (var_469_5 / var_469_4)

				if var_469_6 > 0 and var_469_1 < var_469_6 then
					arg_466_1.talkMaxDuration = var_469_6

					if var_469_6 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_6 + var_469_0
					end
				end

				arg_466_1.text_.text = var_469_3
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_7 = math.max(var_469_1, arg_466_1.talkMaxDuration)

			if var_469_0 <= arg_466_1.time_ and arg_466_1.time_ < var_469_0 + var_469_7 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_0) / var_469_7

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_0 + var_469_7 and arg_466_1.time_ < var_469_0 + var_469_7 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1109403114 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1109403114
		arg_470_1.duration_ = 9

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1109403115(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 2

			if var_473_0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_0 + arg_473_0 then
				local var_473_1 = manager.ui.mainCamera.transform.localPosition
				local var_473_2 = Vector3.New(0, 0, 10) + Vector3.New(var_473_1.x, var_473_1.y, 0)
				local var_473_3 = arg_470_1.bgs_.B13

				var_473_3.transform.localPosition = var_473_2
				var_473_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_473_4 = var_473_3:GetComponent("SpriteRenderer")

				if var_473_4 and var_473_4.sprite then
					local var_473_5 = (var_473_3.transform.localPosition - var_473_1).z
					local var_473_6 = manager.ui.mainCameraCom_
					local var_473_7 = 2 * var_473_5 * Mathf.Tan(var_473_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_473_8 = var_473_7 * var_473_6.aspect
					local var_473_9 = var_473_4.sprite.bounds.size.x
					local var_473_10 = var_473_4.sprite.bounds.size.y
					local var_473_11 = var_473_8 / var_473_9
					local var_473_12 = var_473_7 / var_473_10
					local var_473_13 = var_473_12 < var_473_11 and var_473_11 or var_473_12

					var_473_3.transform.localScale = Vector3.New(var_473_13, var_473_13, 0)
				end

				for iter_473_0, iter_473_1 in pairs(arg_470_1.bgs_) do
					if iter_473_0 ~= "B13" then
						iter_473_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_473_14 = 0

			if var_473_14 < arg_470_1.time_ and arg_470_1.time_ <= var_473_14 + arg_473_0 then
				arg_470_1.mask_.enabled = true
				arg_470_1.mask_.raycastTarget = true

				arg_470_1:SetGaussion(false)
			end

			local var_473_15 = 2

			if var_473_14 <= arg_470_1.time_ and arg_470_1.time_ < var_473_14 + var_473_15 then
				local var_473_16 = (arg_470_1.time_ - var_473_14) / var_473_15
				local var_473_17 = Color.New(0, 0, 0)

				var_473_17.a = Mathf.Lerp(0, 1, var_473_16)
				arg_470_1.mask_.color = var_473_17
			end

			if arg_470_1.time_ >= var_473_14 + var_473_15 and arg_470_1.time_ < var_473_14 + var_473_15 + arg_473_0 then
				local var_473_18 = Color.New(0, 0, 0)

				var_473_18.a = 1
				arg_470_1.mask_.color = var_473_18
			end

			local var_473_19 = 2

			if var_473_19 < arg_470_1.time_ and arg_470_1.time_ <= var_473_19 + arg_473_0 then
				arg_470_1.mask_.enabled = true
				arg_470_1.mask_.raycastTarget = true

				arg_470_1:SetGaussion(false)
			end

			local var_473_20 = 2

			if var_473_19 <= arg_470_1.time_ and arg_470_1.time_ < var_473_19 + var_473_20 then
				local var_473_21 = (arg_470_1.time_ - var_473_19) / var_473_20
				local var_473_22 = Color.New(0, 0, 0)

				var_473_22.a = Mathf.Lerp(1, 0, var_473_21)
				arg_470_1.mask_.color = var_473_22
			end

			if arg_470_1.time_ >= var_473_19 + var_473_20 and arg_470_1.time_ < var_473_19 + var_473_20 + arg_473_0 then
				local var_473_23 = Color.New(0, 0, 0)
				local var_473_24 = 0

				arg_470_1.mask_.enabled = false
				var_473_23.a = var_473_24
				arg_470_1.mask_.color = var_473_23
			end

			if arg_470_1.frameCnt_ <= 1 then
				arg_470_1.dialog_:SetActive(false)
			end

			local var_473_25 = 4
			local var_473_26 = 0.75

			if var_473_25 < arg_470_1.time_ and arg_470_1.time_ <= var_473_25 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0

				arg_470_1.dialog_:SetActive(true)

				arg_470_1.dialogCg_.alpha = 0

				local var_473_27 = LeanTween.value(arg_470_1.dialog_, 0, 1, 0.3)

				var_473_27:setOnUpdate(LuaHelper.FloatAction(function(arg_474_0)
					arg_470_1.dialogCg_.alpha = arg_474_0
				end))
				var_473_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_470_1.dialog_)
					var_473_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_470_1.duration_ = arg_470_1.duration_ + 0.3

				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_28 = arg_470_1:GetWordFromCfg(1109403114)
				local var_473_29 = arg_470_1:FormatText(var_473_28.content)

				arg_470_1.text_.text = var_473_29

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_30 = 30
				local var_473_31 = utf8.len(var_473_29)
				local var_473_32 = var_473_30 <= 0 and var_473_26 or var_473_26 * (var_473_31 / var_473_30)

				if var_473_32 > 0 and var_473_26 < var_473_32 then
					arg_470_1.talkMaxDuration = var_473_32
					var_473_25 = var_473_25 + 0.3

					if var_473_32 + var_473_25 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_32 + var_473_25
					end
				end

				arg_470_1.text_.text = var_473_29
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_33 = var_473_25 + 0.3
			local var_473_34 = math.max(var_473_26, arg_470_1.talkMaxDuration)

			if var_473_33 <= arg_470_1.time_ and arg_470_1.time_ < var_473_33 + var_473_34 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_33) / var_473_34

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_33 + var_473_34 and arg_470_1.time_ < var_473_33 + var_473_34 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play1109403115 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1109403115
		arg_476_1.duration_ = 5

		local var_476_0 = {
			ja = 5,
			ko = 4.266,
			zh = 4.266
		}
		local var_476_1 = manager.audio:GetLocalizationFlag()

		if var_476_0[var_476_1] ~= nil then
			arg_476_1.duration_ = var_476_0[var_476_1]
		end

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1109403116(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = "1048ui_story"

			if arg_476_1.actors_[var_479_0] == nil then
				local var_479_1 = Asset.Load("Char/" .. "1048ui_story")

				if not isNil(var_479_1) then
					local var_479_2 = Object.Instantiate(Asset.Load("Char/" .. "1048ui_story"), arg_476_1.stage_.transform)

					var_479_2.name = var_479_0
					var_479_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_476_1.actors_[var_479_0] = var_479_2

					local var_479_3 = var_479_2:GetComponentInChildren(typeof(CharacterEffect))

					var_479_3.enabled = true

					local var_479_4 = GameObjectTools.GetOrAddComponent(var_479_2, typeof(DynamicBoneHelper))

					if var_479_4 then
						var_479_4:EnableDynamicBone(false)
					end

					arg_476_1:ShowWeapon(var_479_3.transform, false)

					arg_476_1.var_[var_479_0 .. "Animator"] = var_479_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_476_1.var_[var_479_0 .. "Animator"].applyRootMotion = true
					arg_476_1.var_[var_479_0 .. "LipSync"] = var_479_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_479_5 = arg_476_1.actors_["1048ui_story"].transform
			local var_479_6 = 0

			if var_479_6 < arg_476_1.time_ and arg_476_1.time_ <= var_479_6 + arg_479_0 then
				arg_476_1.var_.moveOldPos1048ui_story = var_479_5.localPosition
			end

			local var_479_7 = 0.001

			if var_479_6 <= arg_476_1.time_ and arg_476_1.time_ < var_479_6 + var_479_7 then
				local var_479_8 = (arg_476_1.time_ - var_479_6) / var_479_7
				local var_479_9 = Vector3.New(0, -0.8, -6.2)

				var_479_5.localPosition = Vector3.Lerp(arg_476_1.var_.moveOldPos1048ui_story, var_479_9, var_479_8)

				local var_479_10 = manager.ui.mainCamera.transform.position - var_479_5.position

				var_479_5.forward = Vector3.New(var_479_10.x, var_479_10.y, var_479_10.z)

				local var_479_11 = var_479_5.localEulerAngles

				var_479_11.z = 0
				var_479_11.x = 0
				var_479_5.localEulerAngles = var_479_11
			end

			if arg_476_1.time_ >= var_479_6 + var_479_7 and arg_476_1.time_ < var_479_6 + var_479_7 + arg_479_0 then
				var_479_5.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_479_12 = manager.ui.mainCamera.transform.position - var_479_5.position

				var_479_5.forward = Vector3.New(var_479_12.x, var_479_12.y, var_479_12.z)

				local var_479_13 = var_479_5.localEulerAngles

				var_479_13.z = 0
				var_479_13.x = 0
				var_479_5.localEulerAngles = var_479_13
			end

			local var_479_14 = arg_476_1.actors_["1048ui_story"]
			local var_479_15 = 0

			if var_479_15 < arg_476_1.time_ and arg_476_1.time_ <= var_479_15 + arg_479_0 and not isNil(var_479_14) and arg_476_1.var_.characterEffect1048ui_story == nil then
				arg_476_1.var_.characterEffect1048ui_story = var_479_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_16 = 0.200000002980232

			if var_479_15 <= arg_476_1.time_ and arg_476_1.time_ < var_479_15 + var_479_16 and not isNil(var_479_14) then
				local var_479_17 = (arg_476_1.time_ - var_479_15) / var_479_16

				if arg_476_1.var_.characterEffect1048ui_story and not isNil(var_479_14) then
					arg_476_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_476_1.time_ >= var_479_15 + var_479_16 and arg_476_1.time_ < var_479_15 + var_479_16 + arg_479_0 and not isNil(var_479_14) and arg_476_1.var_.characterEffect1048ui_story then
				arg_476_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_479_18 = 0

			if var_479_18 < arg_476_1.time_ and arg_476_1.time_ <= var_479_18 + arg_479_0 then
				arg_476_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action2_1")
			end

			local var_479_19 = 0

			if var_479_19 < arg_476_1.time_ and arg_476_1.time_ <= var_479_19 + arg_479_0 then
				arg_476_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_479_20 = 0
			local var_479_21 = 0.2

			if var_479_20 < arg_476_1.time_ and arg_476_1.time_ <= var_479_20 + arg_479_0 then
				local var_479_22 = "play"
				local var_479_23 = "music"

				arg_476_1:AudioAction(var_479_22, var_479_23, "ui_battle", "ui_battle_stopbgm", "")

				local var_479_24 = ""
				local var_479_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_479_25 ~= "" then
					if arg_476_1.bgmTxt_.text ~= var_479_25 and arg_476_1.bgmTxt_.text ~= "" then
						if arg_476_1.bgmTxt2_.text ~= "" then
							arg_476_1.bgmTxt_.text = arg_476_1.bgmTxt2_.text
						end

						arg_476_1.bgmTxt2_.text = var_479_25

						arg_476_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_476_1.bgmTxt_.text = var_479_25
						arg_476_1.bgmTxt2_.text = var_479_25
					end

					if arg_476_1.bgmTimer then
						arg_476_1.bgmTimer:Stop()

						arg_476_1.bgmTimer = nil
					end

					if arg_476_1.settingData.show_music_name == 1 then
						arg_476_1.musicController:SetSelectedState("show")
						arg_476_1.musicAnimator_:Play("open", 0, 0)

						if arg_476_1.settingData.music_time ~= 0 then
							arg_476_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_476_1.settingData.music_time), function()
								if arg_476_1 == nil or isNil(arg_476_1.bgmTxt_) then
									return
								end

								arg_476_1.musicController:SetSelectedState("hide")
								arg_476_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_479_26 = 1
			local var_479_27 = 1

			if var_479_26 < arg_476_1.time_ and arg_476_1.time_ <= var_479_26 + arg_479_0 then
				local var_479_28 = "play"
				local var_479_29 = "music"

				arg_476_1:AudioAction(var_479_28, var_479_29, "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_479_30 = ""
				local var_479_31 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if var_479_31 ~= "" then
					if arg_476_1.bgmTxt_.text ~= var_479_31 and arg_476_1.bgmTxt_.text ~= "" then
						if arg_476_1.bgmTxt2_.text ~= "" then
							arg_476_1.bgmTxt_.text = arg_476_1.bgmTxt2_.text
						end

						arg_476_1.bgmTxt2_.text = var_479_31

						arg_476_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_476_1.bgmTxt_.text = var_479_31
						arg_476_1.bgmTxt2_.text = var_479_31
					end

					if arg_476_1.bgmTimer then
						arg_476_1.bgmTimer:Stop()

						arg_476_1.bgmTimer = nil
					end

					if arg_476_1.settingData.show_music_name == 1 then
						arg_476_1.musicController:SetSelectedState("show")
						arg_476_1.musicAnimator_:Play("open", 0, 0)

						if arg_476_1.settingData.music_time ~= 0 then
							arg_476_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_476_1.settingData.music_time), function()
								if arg_476_1 == nil or isNil(arg_476_1.bgmTxt_) then
									return
								end

								arg_476_1.musicController:SetSelectedState("hide")
								arg_476_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_479_32 = 0
			local var_479_33 = 0.55

			if var_479_32 < arg_476_1.time_ and arg_476_1.time_ <= var_479_32 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_34 = arg_476_1:FormatText(StoryNameCfg[8].name)

				arg_476_1.leftNameTxt_.text = var_479_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_35 = arg_476_1:GetWordFromCfg(1109403115)
				local var_479_36 = arg_476_1:FormatText(var_479_35.content)

				arg_476_1.text_.text = var_479_36

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_37 = 22
				local var_479_38 = utf8.len(var_479_36)
				local var_479_39 = var_479_37 <= 0 and var_479_33 or var_479_33 * (var_479_38 / var_479_37)

				if var_479_39 > 0 and var_479_33 < var_479_39 then
					arg_476_1.talkMaxDuration = var_479_39

					if var_479_39 + var_479_32 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_39 + var_479_32
					end
				end

				arg_476_1.text_.text = var_479_36
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403115", "story_v_side_new_1109403.awb") ~= 0 then
					local var_479_40 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403115", "story_v_side_new_1109403.awb") / 1000

					if var_479_40 + var_479_32 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_40 + var_479_32
					end

					if var_479_35.prefab_name ~= "" and arg_476_1.actors_[var_479_35.prefab_name] ~= nil then
						local var_479_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_35.prefab_name].transform, "story_v_side_new_1109403", "1109403115", "story_v_side_new_1109403.awb")

						arg_476_1:RecordAudio("1109403115", var_479_41)
						arg_476_1:RecordAudio("1109403115", var_479_41)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403115", "story_v_side_new_1109403.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403115", "story_v_side_new_1109403.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_42 = math.max(var_479_33, arg_476_1.talkMaxDuration)

			if var_479_32 <= arg_476_1.time_ and arg_476_1.time_ < var_479_32 + var_479_42 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_32) / var_479_42

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_32 + var_479_42 and arg_476_1.time_ < var_479_32 + var_479_42 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_476_1:InitPlayNodeList()
	end,
	Play1109403116 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1109403116
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1109403117(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = arg_482_1.actors_["1048ui_story"]
			local var_485_1 = 0

			if var_485_1 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.characterEffect1048ui_story == nil then
				arg_482_1.var_.characterEffect1048ui_story = var_485_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_2 = 0.200000002980232

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_2 and not isNil(var_485_0) then
				local var_485_3 = (arg_482_1.time_ - var_485_1) / var_485_2

				if arg_482_1.var_.characterEffect1048ui_story and not isNil(var_485_0) then
					local var_485_4 = Mathf.Lerp(0, 0.5, var_485_3)

					arg_482_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_482_1.var_.characterEffect1048ui_story.fillRatio = var_485_4
				end
			end

			if arg_482_1.time_ >= var_485_1 + var_485_2 and arg_482_1.time_ < var_485_1 + var_485_2 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.characterEffect1048ui_story then
				local var_485_5 = 0.5

				arg_482_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_482_1.var_.characterEffect1048ui_story.fillRatio = var_485_5
			end

			local var_485_6 = 0
			local var_485_7 = 0.425

			if var_485_6 < arg_482_1.time_ and arg_482_1.time_ <= var_485_6 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_8 = arg_482_1:FormatText(StoryNameCfg[7].name)

				arg_482_1.leftNameTxt_.text = var_485_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_9 = arg_482_1:GetWordFromCfg(1109403116)
				local var_485_10 = arg_482_1:FormatText(var_485_9.content)

				arg_482_1.text_.text = var_485_10

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_11 = 17
				local var_485_12 = utf8.len(var_485_10)
				local var_485_13 = var_485_11 <= 0 and var_485_7 or var_485_7 * (var_485_12 / var_485_11)

				if var_485_13 > 0 and var_485_7 < var_485_13 then
					arg_482_1.talkMaxDuration = var_485_13

					if var_485_13 + var_485_6 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_13 + var_485_6
					end
				end

				arg_482_1.text_.text = var_485_10
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_14 = math.max(var_485_7, arg_482_1.talkMaxDuration)

			if var_485_6 <= arg_482_1.time_ and arg_482_1.time_ < var_485_6 + var_485_14 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_6) / var_485_14

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_6 + var_485_14 and arg_482_1.time_ < var_485_6 + var_485_14 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play1109403117 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1109403117
		arg_486_1.duration_ = 4.47

		local var_486_0 = {
			ja = 4.466,
			ko = 2.333,
			zh = 2.333
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1109403118(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = arg_486_1.actors_["1048ui_story"].transform
			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 then
				arg_486_1.var_.moveOldPos1048ui_story = var_489_0.localPosition
			end

			local var_489_2 = 0.001

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_2 then
				local var_489_3 = (arg_486_1.time_ - var_489_1) / var_489_2
				local var_489_4 = Vector3.New(0, -0.8, -6.2)

				var_489_0.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos1048ui_story, var_489_4, var_489_3)

				local var_489_5 = manager.ui.mainCamera.transform.position - var_489_0.position

				var_489_0.forward = Vector3.New(var_489_5.x, var_489_5.y, var_489_5.z)

				local var_489_6 = var_489_0.localEulerAngles

				var_489_6.z = 0
				var_489_6.x = 0
				var_489_0.localEulerAngles = var_489_6
			end

			if arg_486_1.time_ >= var_489_1 + var_489_2 and arg_486_1.time_ < var_489_1 + var_489_2 + arg_489_0 then
				var_489_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_489_7 = manager.ui.mainCamera.transform.position - var_489_0.position

				var_489_0.forward = Vector3.New(var_489_7.x, var_489_7.y, var_489_7.z)

				local var_489_8 = var_489_0.localEulerAngles

				var_489_8.z = 0
				var_489_8.x = 0
				var_489_0.localEulerAngles = var_489_8
			end

			local var_489_9 = arg_486_1.actors_["1048ui_story"]
			local var_489_10 = 0

			if var_489_10 < arg_486_1.time_ and arg_486_1.time_ <= var_489_10 + arg_489_0 and not isNil(var_489_9) and arg_486_1.var_.characterEffect1048ui_story == nil then
				arg_486_1.var_.characterEffect1048ui_story = var_489_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_11 = 0.200000002980232

			if var_489_10 <= arg_486_1.time_ and arg_486_1.time_ < var_489_10 + var_489_11 and not isNil(var_489_9) then
				local var_489_12 = (arg_486_1.time_ - var_489_10) / var_489_11

				if arg_486_1.var_.characterEffect1048ui_story and not isNil(var_489_9) then
					arg_486_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= var_489_10 + var_489_11 and arg_486_1.time_ < var_489_10 + var_489_11 + arg_489_0 and not isNil(var_489_9) and arg_486_1.var_.characterEffect1048ui_story then
				arg_486_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_489_13 = 0

			if var_489_13 < arg_486_1.time_ and arg_486_1.time_ <= var_489_13 + arg_489_0 then
				arg_486_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action2_2")
			end

			local var_489_14 = 0

			if var_489_14 < arg_486_1.time_ and arg_486_1.time_ <= var_489_14 + arg_489_0 then
				arg_486_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_489_15 = 0
			local var_489_16 = 0.2

			if var_489_15 < arg_486_1.time_ and arg_486_1.time_ <= var_489_15 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_17 = arg_486_1:FormatText(StoryNameCfg[8].name)

				arg_486_1.leftNameTxt_.text = var_489_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_18 = arg_486_1:GetWordFromCfg(1109403117)
				local var_489_19 = arg_486_1:FormatText(var_489_18.content)

				arg_486_1.text_.text = var_489_19

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_20 = 8
				local var_489_21 = utf8.len(var_489_19)
				local var_489_22 = var_489_20 <= 0 and var_489_16 or var_489_16 * (var_489_21 / var_489_20)

				if var_489_22 > 0 and var_489_16 < var_489_22 then
					arg_486_1.talkMaxDuration = var_489_22

					if var_489_22 + var_489_15 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_22 + var_489_15
					end
				end

				arg_486_1.text_.text = var_489_19
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403117", "story_v_side_new_1109403.awb") ~= 0 then
					local var_489_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403117", "story_v_side_new_1109403.awb") / 1000

					if var_489_23 + var_489_15 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_23 + var_489_15
					end

					if var_489_18.prefab_name ~= "" and arg_486_1.actors_[var_489_18.prefab_name] ~= nil then
						local var_489_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_18.prefab_name].transform, "story_v_side_new_1109403", "1109403117", "story_v_side_new_1109403.awb")

						arg_486_1:RecordAudio("1109403117", var_489_24)
						arg_486_1:RecordAudio("1109403117", var_489_24)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403117", "story_v_side_new_1109403.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403117", "story_v_side_new_1109403.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_25 = math.max(var_489_16, arg_486_1.talkMaxDuration)

			if var_489_15 <= arg_486_1.time_ and arg_486_1.time_ < var_489_15 + var_489_25 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_15) / var_489_25

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_15 + var_489_25 and arg_486_1.time_ < var_489_15 + var_489_25 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_486_1:InitPlayNodeList()
	end,
	Play1109403118 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1109403118
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1109403119(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = arg_490_1.actors_["1048ui_story"]
			local var_493_1 = 0

			if var_493_1 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect1048ui_story == nil then
				arg_490_1.var_.characterEffect1048ui_story = var_493_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_2 = 0.200000002980232

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_2 and not isNil(var_493_0) then
				local var_493_3 = (arg_490_1.time_ - var_493_1) / var_493_2

				if arg_490_1.var_.characterEffect1048ui_story and not isNil(var_493_0) then
					local var_493_4 = Mathf.Lerp(0, 0.5, var_493_3)

					arg_490_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_490_1.var_.characterEffect1048ui_story.fillRatio = var_493_4
				end
			end

			if arg_490_1.time_ >= var_493_1 + var_493_2 and arg_490_1.time_ < var_493_1 + var_493_2 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect1048ui_story then
				local var_493_5 = 0.5

				arg_490_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_490_1.var_.characterEffect1048ui_story.fillRatio = var_493_5
			end

			local var_493_6 = 0
			local var_493_7 = 0.45

			if var_493_6 < arg_490_1.time_ and arg_490_1.time_ <= var_493_6 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, false)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_8 = arg_490_1:GetWordFromCfg(1109403118)
				local var_493_9 = arg_490_1:FormatText(var_493_8.content)

				arg_490_1.text_.text = var_493_9

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_10 = 18
				local var_493_11 = utf8.len(var_493_9)
				local var_493_12 = var_493_10 <= 0 and var_493_7 or var_493_7 * (var_493_11 / var_493_10)

				if var_493_12 > 0 and var_493_7 < var_493_12 then
					arg_490_1.talkMaxDuration = var_493_12

					if var_493_12 + var_493_6 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_12 + var_493_6
					end
				end

				arg_490_1.text_.text = var_493_9
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_13 = math.max(var_493_7, arg_490_1.talkMaxDuration)

			if var_493_6 <= arg_490_1.time_ and arg_490_1.time_ < var_493_6 + var_493_13 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_6) / var_493_13

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_6 + var_493_13 and arg_490_1.time_ < var_493_6 + var_493_13 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play1109403119 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1109403119
		arg_494_1.duration_ = 7.2

		local var_494_0 = {
			ja = 7.2,
			ko = 3.733,
			zh = 3.733
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1109403120(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["1048ui_story"].transform
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 then
				arg_494_1.var_.moveOldPos1048ui_story = var_497_0.localPosition
			end

			local var_497_2 = 0.001

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2
				local var_497_4 = Vector3.New(0, -0.8, -6.2)

				var_497_0.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1048ui_story, var_497_4, var_497_3)

				local var_497_5 = manager.ui.mainCamera.transform.position - var_497_0.position

				var_497_0.forward = Vector3.New(var_497_5.x, var_497_5.y, var_497_5.z)

				local var_497_6 = var_497_0.localEulerAngles

				var_497_6.z = 0
				var_497_6.x = 0
				var_497_0.localEulerAngles = var_497_6
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 then
				var_497_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_497_7 = manager.ui.mainCamera.transform.position - var_497_0.position

				var_497_0.forward = Vector3.New(var_497_7.x, var_497_7.y, var_497_7.z)

				local var_497_8 = var_497_0.localEulerAngles

				var_497_8.z = 0
				var_497_8.x = 0
				var_497_0.localEulerAngles = var_497_8
			end

			local var_497_9 = arg_494_1.actors_["1048ui_story"]
			local var_497_10 = 0

			if var_497_10 < arg_494_1.time_ and arg_494_1.time_ <= var_497_10 + arg_497_0 and not isNil(var_497_9) and arg_494_1.var_.characterEffect1048ui_story == nil then
				arg_494_1.var_.characterEffect1048ui_story = var_497_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_11 = 0.200000002980232

			if var_497_10 <= arg_494_1.time_ and arg_494_1.time_ < var_497_10 + var_497_11 and not isNil(var_497_9) then
				local var_497_12 = (arg_494_1.time_ - var_497_10) / var_497_11

				if arg_494_1.var_.characterEffect1048ui_story and not isNil(var_497_9) then
					arg_494_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_494_1.time_ >= var_497_10 + var_497_11 and arg_494_1.time_ < var_497_10 + var_497_11 + arg_497_0 and not isNil(var_497_9) and arg_494_1.var_.characterEffect1048ui_story then
				arg_494_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_497_13 = 0

			if var_497_13 < arg_494_1.time_ and arg_494_1.time_ <= var_497_13 + arg_497_0 then
				arg_494_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_497_14 = 0

			if var_497_14 < arg_494_1.time_ and arg_494_1.time_ <= var_497_14 + arg_497_0 then
				arg_494_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_497_15 = 0
			local var_497_16 = 0.45

			if var_497_15 < arg_494_1.time_ and arg_494_1.time_ <= var_497_15 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_17 = arg_494_1:FormatText(StoryNameCfg[8].name)

				arg_494_1.leftNameTxt_.text = var_497_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_18 = arg_494_1:GetWordFromCfg(1109403119)
				local var_497_19 = arg_494_1:FormatText(var_497_18.content)

				arg_494_1.text_.text = var_497_19

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_20 = 18
				local var_497_21 = utf8.len(var_497_19)
				local var_497_22 = var_497_20 <= 0 and var_497_16 or var_497_16 * (var_497_21 / var_497_20)

				if var_497_22 > 0 and var_497_16 < var_497_22 then
					arg_494_1.talkMaxDuration = var_497_22

					if var_497_22 + var_497_15 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_22 + var_497_15
					end
				end

				arg_494_1.text_.text = var_497_19
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403119", "story_v_side_new_1109403.awb") ~= 0 then
					local var_497_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403119", "story_v_side_new_1109403.awb") / 1000

					if var_497_23 + var_497_15 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_23 + var_497_15
					end

					if var_497_18.prefab_name ~= "" and arg_494_1.actors_[var_497_18.prefab_name] ~= nil then
						local var_497_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_18.prefab_name].transform, "story_v_side_new_1109403", "1109403119", "story_v_side_new_1109403.awb")

						arg_494_1:RecordAudio("1109403119", var_497_24)
						arg_494_1:RecordAudio("1109403119", var_497_24)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403119", "story_v_side_new_1109403.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403119", "story_v_side_new_1109403.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_25 = math.max(var_497_16, arg_494_1.talkMaxDuration)

			if var_497_15 <= arg_494_1.time_ and arg_494_1.time_ < var_497_15 + var_497_25 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_15) / var_497_25

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_15 + var_497_25 and arg_494_1.time_ < var_497_15 + var_497_25 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_494_1:InitPlayNodeList()
	end,
	Play1109403120 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1109403120
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play1109403121(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["1048ui_story"]
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect1048ui_story == nil then
				arg_498_1.var_.characterEffect1048ui_story = var_501_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_2 = 0.200000002980232

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 and not isNil(var_501_0) then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2

				if arg_498_1.var_.characterEffect1048ui_story and not isNil(var_501_0) then
					local var_501_4 = Mathf.Lerp(0, 0.5, var_501_3)

					arg_498_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_498_1.var_.characterEffect1048ui_story.fillRatio = var_501_4
				end
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect1048ui_story then
				local var_501_5 = 0.5

				arg_498_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_498_1.var_.characterEffect1048ui_story.fillRatio = var_501_5
			end

			local var_501_6 = 0
			local var_501_7 = 0.325

			if var_501_6 < arg_498_1.time_ and arg_498_1.time_ <= var_501_6 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_8 = arg_498_1:FormatText(StoryNameCfg[7].name)

				arg_498_1.leftNameTxt_.text = var_501_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, true)
				arg_498_1.iconController_:SetSelectedState("hero")

				arg_498_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_498_1.callingController_:SetSelectedState("normal")

				arg_498_1.keyicon_.color = Color.New(1, 1, 1)
				arg_498_1.icon_.color = Color.New(1, 1, 1)

				local var_501_9 = arg_498_1:GetWordFromCfg(1109403120)
				local var_501_10 = arg_498_1:FormatText(var_501_9.content)

				arg_498_1.text_.text = var_501_10

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_11 = 13
				local var_501_12 = utf8.len(var_501_10)
				local var_501_13 = var_501_11 <= 0 and var_501_7 or var_501_7 * (var_501_12 / var_501_11)

				if var_501_13 > 0 and var_501_7 < var_501_13 then
					arg_498_1.talkMaxDuration = var_501_13

					if var_501_13 + var_501_6 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_13 + var_501_6
					end
				end

				arg_498_1.text_.text = var_501_10
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_14 = math.max(var_501_7, arg_498_1.talkMaxDuration)

			if var_501_6 <= arg_498_1.time_ and arg_498_1.time_ < var_501_6 + var_501_14 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_6) / var_501_14

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_6 + var_501_14 and arg_498_1.time_ < var_501_6 + var_501_14 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play1109403121 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1109403121
		arg_502_1.duration_ = 5.3

		local var_502_0 = {
			ja = 4.433,
			ko = 5.3,
			zh = 5.3
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play1109403122(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = arg_502_1.actors_["1048ui_story"].transform
			local var_505_1 = 0

			if var_505_1 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 then
				arg_502_1.var_.moveOldPos1048ui_story = var_505_0.localPosition
			end

			local var_505_2 = 0.001

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_2 then
				local var_505_3 = (arg_502_1.time_ - var_505_1) / var_505_2
				local var_505_4 = Vector3.New(0, -0.8, -6.2)

				var_505_0.localPosition = Vector3.Lerp(arg_502_1.var_.moveOldPos1048ui_story, var_505_4, var_505_3)

				local var_505_5 = manager.ui.mainCamera.transform.position - var_505_0.position

				var_505_0.forward = Vector3.New(var_505_5.x, var_505_5.y, var_505_5.z)

				local var_505_6 = var_505_0.localEulerAngles

				var_505_6.z = 0
				var_505_6.x = 0
				var_505_0.localEulerAngles = var_505_6
			end

			if arg_502_1.time_ >= var_505_1 + var_505_2 and arg_502_1.time_ < var_505_1 + var_505_2 + arg_505_0 then
				var_505_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_505_7 = manager.ui.mainCamera.transform.position - var_505_0.position

				var_505_0.forward = Vector3.New(var_505_7.x, var_505_7.y, var_505_7.z)

				local var_505_8 = var_505_0.localEulerAngles

				var_505_8.z = 0
				var_505_8.x = 0
				var_505_0.localEulerAngles = var_505_8
			end

			local var_505_9 = arg_502_1.actors_["1048ui_story"]
			local var_505_10 = 0

			if var_505_10 < arg_502_1.time_ and arg_502_1.time_ <= var_505_10 + arg_505_0 and not isNil(var_505_9) and arg_502_1.var_.characterEffect1048ui_story == nil then
				arg_502_1.var_.characterEffect1048ui_story = var_505_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_11 = 0.200000002980232

			if var_505_10 <= arg_502_1.time_ and arg_502_1.time_ < var_505_10 + var_505_11 and not isNil(var_505_9) then
				local var_505_12 = (arg_502_1.time_ - var_505_10) / var_505_11

				if arg_502_1.var_.characterEffect1048ui_story and not isNil(var_505_9) then
					arg_502_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_502_1.time_ >= var_505_10 + var_505_11 and arg_502_1.time_ < var_505_10 + var_505_11 + arg_505_0 and not isNil(var_505_9) and arg_502_1.var_.characterEffect1048ui_story then
				arg_502_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_505_13 = 0

			if var_505_13 < arg_502_1.time_ and arg_502_1.time_ <= var_505_13 + arg_505_0 then
				arg_502_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action443")
			end

			local var_505_14 = 0

			if var_505_14 < arg_502_1.time_ and arg_502_1.time_ <= var_505_14 + arg_505_0 then
				arg_502_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_505_15 = 0
			local var_505_16 = 0.55

			if var_505_15 < arg_502_1.time_ and arg_502_1.time_ <= var_505_15 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_17 = arg_502_1:FormatText(StoryNameCfg[8].name)

				arg_502_1.leftNameTxt_.text = var_505_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_18 = arg_502_1:GetWordFromCfg(1109403121)
				local var_505_19 = arg_502_1:FormatText(var_505_18.content)

				arg_502_1.text_.text = var_505_19

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_20 = 22
				local var_505_21 = utf8.len(var_505_19)
				local var_505_22 = var_505_20 <= 0 and var_505_16 or var_505_16 * (var_505_21 / var_505_20)

				if var_505_22 > 0 and var_505_16 < var_505_22 then
					arg_502_1.talkMaxDuration = var_505_22

					if var_505_22 + var_505_15 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_22 + var_505_15
					end
				end

				arg_502_1.text_.text = var_505_19
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403121", "story_v_side_new_1109403.awb") ~= 0 then
					local var_505_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403121", "story_v_side_new_1109403.awb") / 1000

					if var_505_23 + var_505_15 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_23 + var_505_15
					end

					if var_505_18.prefab_name ~= "" and arg_502_1.actors_[var_505_18.prefab_name] ~= nil then
						local var_505_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_18.prefab_name].transform, "story_v_side_new_1109403", "1109403121", "story_v_side_new_1109403.awb")

						arg_502_1:RecordAudio("1109403121", var_505_24)
						arg_502_1:RecordAudio("1109403121", var_505_24)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403121", "story_v_side_new_1109403.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403121", "story_v_side_new_1109403.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_25 = math.max(var_505_16, arg_502_1.talkMaxDuration)

			if var_505_15 <= arg_502_1.time_ and arg_502_1.time_ < var_505_15 + var_505_25 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_15) / var_505_25

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_15 + var_505_25 and arg_502_1.time_ < var_505_15 + var_505_25 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_502_1:InitPlayNodeList()
	end,
	Play1109403122 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 1109403122
		arg_506_1.duration_ = 12.3

		local var_506_0 = {
			ja = 12.3,
			ko = 8.066,
			zh = 8.066
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play1109403123(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = arg_506_1.actors_["1048ui_story"].transform
			local var_509_1 = 0

			if var_509_1 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 then
				arg_506_1.var_.moveOldPos1048ui_story = var_509_0.localPosition
			end

			local var_509_2 = 0.001

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_2 then
				local var_509_3 = (arg_506_1.time_ - var_509_1) / var_509_2
				local var_509_4 = Vector3.New(0, -0.8, -6.2)

				var_509_0.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos1048ui_story, var_509_4, var_509_3)

				local var_509_5 = manager.ui.mainCamera.transform.position - var_509_0.position

				var_509_0.forward = Vector3.New(var_509_5.x, var_509_5.y, var_509_5.z)

				local var_509_6 = var_509_0.localEulerAngles

				var_509_6.z = 0
				var_509_6.x = 0
				var_509_0.localEulerAngles = var_509_6
			end

			if arg_506_1.time_ >= var_509_1 + var_509_2 and arg_506_1.time_ < var_509_1 + var_509_2 + arg_509_0 then
				var_509_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_509_7 = manager.ui.mainCamera.transform.position - var_509_0.position

				var_509_0.forward = Vector3.New(var_509_7.x, var_509_7.y, var_509_7.z)

				local var_509_8 = var_509_0.localEulerAngles

				var_509_8.z = 0
				var_509_8.x = 0
				var_509_0.localEulerAngles = var_509_8
			end

			local var_509_9 = arg_506_1.actors_["1048ui_story"]
			local var_509_10 = 0

			if var_509_10 < arg_506_1.time_ and arg_506_1.time_ <= var_509_10 + arg_509_0 and not isNil(var_509_9) and arg_506_1.var_.characterEffect1048ui_story == nil then
				arg_506_1.var_.characterEffect1048ui_story = var_509_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_11 = 0.200000002980232

			if var_509_10 <= arg_506_1.time_ and arg_506_1.time_ < var_509_10 + var_509_11 and not isNil(var_509_9) then
				local var_509_12 = (arg_506_1.time_ - var_509_10) / var_509_11

				if arg_506_1.var_.characterEffect1048ui_story and not isNil(var_509_9) then
					arg_506_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= var_509_10 + var_509_11 and arg_506_1.time_ < var_509_10 + var_509_11 + arg_509_0 and not isNil(var_509_9) and arg_506_1.var_.characterEffect1048ui_story then
				arg_506_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_509_13 = 0

			if var_509_13 < arg_506_1.time_ and arg_506_1.time_ <= var_509_13 + arg_509_0 then
				arg_506_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action435")
			end

			local var_509_14 = 0

			if var_509_14 < arg_506_1.time_ and arg_506_1.time_ <= var_509_14 + arg_509_0 then
				arg_506_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_509_15 = 0
			local var_509_16 = 0.975

			if var_509_15 < arg_506_1.time_ and arg_506_1.time_ <= var_509_15 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_17 = arg_506_1:FormatText(StoryNameCfg[8].name)

				arg_506_1.leftNameTxt_.text = var_509_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_18 = arg_506_1:GetWordFromCfg(1109403122)
				local var_509_19 = arg_506_1:FormatText(var_509_18.content)

				arg_506_1.text_.text = var_509_19

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_20 = 39
				local var_509_21 = utf8.len(var_509_19)
				local var_509_22 = var_509_20 <= 0 and var_509_16 or var_509_16 * (var_509_21 / var_509_20)

				if var_509_22 > 0 and var_509_16 < var_509_22 then
					arg_506_1.talkMaxDuration = var_509_22

					if var_509_22 + var_509_15 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_22 + var_509_15
					end
				end

				arg_506_1.text_.text = var_509_19
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403122", "story_v_side_new_1109403.awb") ~= 0 then
					local var_509_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403122", "story_v_side_new_1109403.awb") / 1000

					if var_509_23 + var_509_15 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_23 + var_509_15
					end

					if var_509_18.prefab_name ~= "" and arg_506_1.actors_[var_509_18.prefab_name] ~= nil then
						local var_509_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_18.prefab_name].transform, "story_v_side_new_1109403", "1109403122", "story_v_side_new_1109403.awb")

						arg_506_1:RecordAudio("1109403122", var_509_24)
						arg_506_1:RecordAudio("1109403122", var_509_24)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403122", "story_v_side_new_1109403.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403122", "story_v_side_new_1109403.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_25 = math.max(var_509_16, arg_506_1.talkMaxDuration)

			if var_509_15 <= arg_506_1.time_ and arg_506_1.time_ < var_509_15 + var_509_25 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_15) / var_509_25

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_15 + var_509_25 and arg_506_1.time_ < var_509_15 + var_509_25 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_506_1:InitPlayNodeList()
	end,
	Play1109403123 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 1109403123
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play1109403124(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["1048ui_story"]
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.characterEffect1048ui_story == nil then
				arg_510_1.var_.characterEffect1048ui_story = var_513_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_2 = 0.200000002980232

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 and not isNil(var_513_0) then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2

				if arg_510_1.var_.characterEffect1048ui_story and not isNil(var_513_0) then
					local var_513_4 = Mathf.Lerp(0, 0.5, var_513_3)

					arg_510_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_510_1.var_.characterEffect1048ui_story.fillRatio = var_513_4
				end
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.characterEffect1048ui_story then
				local var_513_5 = 0.5

				arg_510_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_510_1.var_.characterEffect1048ui_story.fillRatio = var_513_5
			end

			local var_513_6 = 0
			local var_513_7 = 0.775

			if var_513_6 < arg_510_1.time_ and arg_510_1.time_ <= var_513_6 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				local var_513_8 = arg_510_1:FormatText(StoryNameCfg[7].name)

				arg_510_1.leftNameTxt_.text = var_513_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, true)
				arg_510_1.iconController_:SetSelectedState("hero")

				arg_510_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_510_1.callingController_:SetSelectedState("normal")

				arg_510_1.keyicon_.color = Color.New(1, 1, 1)
				arg_510_1.icon_.color = Color.New(1, 1, 1)

				local var_513_9 = arg_510_1:GetWordFromCfg(1109403123)
				local var_513_10 = arg_510_1:FormatText(var_513_9.content)

				arg_510_1.text_.text = var_513_10

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_11 = 31
				local var_513_12 = utf8.len(var_513_10)
				local var_513_13 = var_513_11 <= 0 and var_513_7 or var_513_7 * (var_513_12 / var_513_11)

				if var_513_13 > 0 and var_513_7 < var_513_13 then
					arg_510_1.talkMaxDuration = var_513_13

					if var_513_13 + var_513_6 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_13 + var_513_6
					end
				end

				arg_510_1.text_.text = var_513_10
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_14 = math.max(var_513_7, arg_510_1.talkMaxDuration)

			if var_513_6 <= arg_510_1.time_ and arg_510_1.time_ < var_513_6 + var_513_14 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_6) / var_513_14

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_6 + var_513_14 and arg_510_1.time_ < var_513_6 + var_513_14 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play1109403124 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 1109403124
		arg_514_1.duration_ = 8.47

		local var_514_0 = {
			ja = 8.466,
			ko = 4.1,
			zh = 4.1
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play1109403125(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = arg_514_1.actors_["1048ui_story"].transform
			local var_517_1 = 0

			if var_517_1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 then
				arg_514_1.var_.moveOldPos1048ui_story = var_517_0.localPosition
			end

			local var_517_2 = 0.001

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_2 then
				local var_517_3 = (arg_514_1.time_ - var_517_1) / var_517_2
				local var_517_4 = Vector3.New(0, -0.8, -6.2)

				var_517_0.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1048ui_story, var_517_4, var_517_3)

				local var_517_5 = manager.ui.mainCamera.transform.position - var_517_0.position

				var_517_0.forward = Vector3.New(var_517_5.x, var_517_5.y, var_517_5.z)

				local var_517_6 = var_517_0.localEulerAngles

				var_517_6.z = 0
				var_517_6.x = 0
				var_517_0.localEulerAngles = var_517_6
			end

			if arg_514_1.time_ >= var_517_1 + var_517_2 and arg_514_1.time_ < var_517_1 + var_517_2 + arg_517_0 then
				var_517_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_517_7 = manager.ui.mainCamera.transform.position - var_517_0.position

				var_517_0.forward = Vector3.New(var_517_7.x, var_517_7.y, var_517_7.z)

				local var_517_8 = var_517_0.localEulerAngles

				var_517_8.z = 0
				var_517_8.x = 0
				var_517_0.localEulerAngles = var_517_8
			end

			local var_517_9 = arg_514_1.actors_["1048ui_story"]
			local var_517_10 = 0

			if var_517_10 < arg_514_1.time_ and arg_514_1.time_ <= var_517_10 + arg_517_0 and not isNil(var_517_9) and arg_514_1.var_.characterEffect1048ui_story == nil then
				arg_514_1.var_.characterEffect1048ui_story = var_517_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_11 = 0.200000002980232

			if var_517_10 <= arg_514_1.time_ and arg_514_1.time_ < var_517_10 + var_517_11 and not isNil(var_517_9) then
				local var_517_12 = (arg_514_1.time_ - var_517_10) / var_517_11

				if arg_514_1.var_.characterEffect1048ui_story and not isNil(var_517_9) then
					arg_514_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= var_517_10 + var_517_11 and arg_514_1.time_ < var_517_10 + var_517_11 + arg_517_0 and not isNil(var_517_9) and arg_514_1.var_.characterEffect1048ui_story then
				arg_514_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_517_13 = 0

			if var_517_13 < arg_514_1.time_ and arg_514_1.time_ <= var_517_13 + arg_517_0 then
				arg_514_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_517_14 = 0
			local var_517_15 = 0.4

			if var_517_14 < arg_514_1.time_ and arg_514_1.time_ <= var_517_14 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_16 = arg_514_1:FormatText(StoryNameCfg[8].name)

				arg_514_1.leftNameTxt_.text = var_517_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_17 = arg_514_1:GetWordFromCfg(1109403124)
				local var_517_18 = arg_514_1:FormatText(var_517_17.content)

				arg_514_1.text_.text = var_517_18

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_19 = 16
				local var_517_20 = utf8.len(var_517_18)
				local var_517_21 = var_517_19 <= 0 and var_517_15 or var_517_15 * (var_517_20 / var_517_19)

				if var_517_21 > 0 and var_517_15 < var_517_21 then
					arg_514_1.talkMaxDuration = var_517_21

					if var_517_21 + var_517_14 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_21 + var_517_14
					end
				end

				arg_514_1.text_.text = var_517_18
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403124", "story_v_side_new_1109403.awb") ~= 0 then
					local var_517_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403124", "story_v_side_new_1109403.awb") / 1000

					if var_517_22 + var_517_14 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_22 + var_517_14
					end

					if var_517_17.prefab_name ~= "" and arg_514_1.actors_[var_517_17.prefab_name] ~= nil then
						local var_517_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_17.prefab_name].transform, "story_v_side_new_1109403", "1109403124", "story_v_side_new_1109403.awb")

						arg_514_1:RecordAudio("1109403124", var_517_23)
						arg_514_1:RecordAudio("1109403124", var_517_23)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403124", "story_v_side_new_1109403.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403124", "story_v_side_new_1109403.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_24 = math.max(var_517_15, arg_514_1.talkMaxDuration)

			if var_517_14 <= arg_514_1.time_ and arg_514_1.time_ < var_517_14 + var_517_24 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_14) / var_517_24

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_14 + var_517_24 and arg_514_1.time_ < var_517_14 + var_517_24 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play1109403125 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 1109403125
		arg_518_1.duration_ = 5

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play1109403126(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = arg_518_1.actors_["1048ui_story"]
			local var_521_1 = 0

			if var_521_1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.characterEffect1048ui_story == nil then
				arg_518_1.var_.characterEffect1048ui_story = var_521_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_2 = 0.200000002980232

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_2 and not isNil(var_521_0) then
				local var_521_3 = (arg_518_1.time_ - var_521_1) / var_521_2

				if arg_518_1.var_.characterEffect1048ui_story and not isNil(var_521_0) then
					local var_521_4 = Mathf.Lerp(0, 0.5, var_521_3)

					arg_518_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1048ui_story.fillRatio = var_521_4
				end
			end

			if arg_518_1.time_ >= var_521_1 + var_521_2 and arg_518_1.time_ < var_521_1 + var_521_2 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.characterEffect1048ui_story then
				local var_521_5 = 0.5

				arg_518_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1048ui_story.fillRatio = var_521_5
			end

			local var_521_6 = 0
			local var_521_7 = 0.525

			if var_521_6 < arg_518_1.time_ and arg_518_1.time_ <= var_521_6 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_8 = arg_518_1:FormatText(StoryNameCfg[7].name)

				arg_518_1.leftNameTxt_.text = var_521_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, true)
				arg_518_1.iconController_:SetSelectedState("hero")

				arg_518_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_518_1.callingController_:SetSelectedState("normal")

				arg_518_1.keyicon_.color = Color.New(1, 1, 1)
				arg_518_1.icon_.color = Color.New(1, 1, 1)

				local var_521_9 = arg_518_1:GetWordFromCfg(1109403125)
				local var_521_10 = arg_518_1:FormatText(var_521_9.content)

				arg_518_1.text_.text = var_521_10

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_11 = 21
				local var_521_12 = utf8.len(var_521_10)
				local var_521_13 = var_521_11 <= 0 and var_521_7 or var_521_7 * (var_521_12 / var_521_11)

				if var_521_13 > 0 and var_521_7 < var_521_13 then
					arg_518_1.talkMaxDuration = var_521_13

					if var_521_13 + var_521_6 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_13 + var_521_6
					end
				end

				arg_518_1.text_.text = var_521_10
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_14 = math.max(var_521_7, arg_518_1.talkMaxDuration)

			if var_521_6 <= arg_518_1.time_ and arg_518_1.time_ < var_521_6 + var_521_14 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_6) / var_521_14

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_6 + var_521_14 and arg_518_1.time_ < var_521_6 + var_521_14 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play1109403126 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 1109403126
		arg_522_1.duration_ = 4.83

		local var_522_0 = {
			ja = 4.833,
			ko = 3.066,
			zh = 3.066
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play1109403127(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = arg_522_1.actors_["1048ui_story"].transform
			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 then
				arg_522_1.var_.moveOldPos1048ui_story = var_525_0.localPosition
			end

			local var_525_2 = 0.001

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_2 then
				local var_525_3 = (arg_522_1.time_ - var_525_1) / var_525_2
				local var_525_4 = Vector3.New(0, -0.8, -6.2)

				var_525_0.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos1048ui_story, var_525_4, var_525_3)

				local var_525_5 = manager.ui.mainCamera.transform.position - var_525_0.position

				var_525_0.forward = Vector3.New(var_525_5.x, var_525_5.y, var_525_5.z)

				local var_525_6 = var_525_0.localEulerAngles

				var_525_6.z = 0
				var_525_6.x = 0
				var_525_0.localEulerAngles = var_525_6
			end

			if arg_522_1.time_ >= var_525_1 + var_525_2 and arg_522_1.time_ < var_525_1 + var_525_2 + arg_525_0 then
				var_525_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_525_7 = manager.ui.mainCamera.transform.position - var_525_0.position

				var_525_0.forward = Vector3.New(var_525_7.x, var_525_7.y, var_525_7.z)

				local var_525_8 = var_525_0.localEulerAngles

				var_525_8.z = 0
				var_525_8.x = 0
				var_525_0.localEulerAngles = var_525_8
			end

			local var_525_9 = arg_522_1.actors_["1048ui_story"]
			local var_525_10 = 0

			if var_525_10 < arg_522_1.time_ and arg_522_1.time_ <= var_525_10 + arg_525_0 and not isNil(var_525_9) and arg_522_1.var_.characterEffect1048ui_story == nil then
				arg_522_1.var_.characterEffect1048ui_story = var_525_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_11 = 0.200000002980232

			if var_525_10 <= arg_522_1.time_ and arg_522_1.time_ < var_525_10 + var_525_11 and not isNil(var_525_9) then
				local var_525_12 = (arg_522_1.time_ - var_525_10) / var_525_11

				if arg_522_1.var_.characterEffect1048ui_story and not isNil(var_525_9) then
					arg_522_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= var_525_10 + var_525_11 and arg_522_1.time_ < var_525_10 + var_525_11 + arg_525_0 and not isNil(var_525_9) and arg_522_1.var_.characterEffect1048ui_story then
				arg_522_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_525_13 = 0

			if var_525_13 < arg_522_1.time_ and arg_522_1.time_ <= var_525_13 + arg_525_0 then
				arg_522_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action452")
			end

			local var_525_14 = 0

			if var_525_14 < arg_522_1.time_ and arg_522_1.time_ <= var_525_14 + arg_525_0 then
				arg_522_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_525_15 = 0
			local var_525_16 = 0.325

			if var_525_15 < arg_522_1.time_ and arg_522_1.time_ <= var_525_15 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_17 = arg_522_1:FormatText(StoryNameCfg[8].name)

				arg_522_1.leftNameTxt_.text = var_525_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_18 = arg_522_1:GetWordFromCfg(1109403126)
				local var_525_19 = arg_522_1:FormatText(var_525_18.content)

				arg_522_1.text_.text = var_525_19

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_20 = 13
				local var_525_21 = utf8.len(var_525_19)
				local var_525_22 = var_525_20 <= 0 and var_525_16 or var_525_16 * (var_525_21 / var_525_20)

				if var_525_22 > 0 and var_525_16 < var_525_22 then
					arg_522_1.talkMaxDuration = var_525_22

					if var_525_22 + var_525_15 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_22 + var_525_15
					end
				end

				arg_522_1.text_.text = var_525_19
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403126", "story_v_side_new_1109403.awb") ~= 0 then
					local var_525_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403126", "story_v_side_new_1109403.awb") / 1000

					if var_525_23 + var_525_15 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_23 + var_525_15
					end

					if var_525_18.prefab_name ~= "" and arg_522_1.actors_[var_525_18.prefab_name] ~= nil then
						local var_525_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_18.prefab_name].transform, "story_v_side_new_1109403", "1109403126", "story_v_side_new_1109403.awb")

						arg_522_1:RecordAudio("1109403126", var_525_24)
						arg_522_1:RecordAudio("1109403126", var_525_24)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403126", "story_v_side_new_1109403.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403126", "story_v_side_new_1109403.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_25 = math.max(var_525_16, arg_522_1.talkMaxDuration)

			if var_525_15 <= arg_522_1.time_ and arg_522_1.time_ < var_525_15 + var_525_25 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_15) / var_525_25

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_15 + var_525_25 and arg_522_1.time_ < var_525_15 + var_525_25 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_522_1:InitPlayNodeList()
	end,
	Play1109403127 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 1109403127
		arg_526_1.duration_ = 12.47

		local var_526_0 = {
			ja = 12.466,
			ko = 7.4,
			zh = 7.4
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play1109403128(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = arg_526_1.actors_["1048ui_story"].transform
			local var_529_1 = 0

			if var_529_1 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 then
				arg_526_1.var_.moveOldPos1048ui_story = var_529_0.localPosition
			end

			local var_529_2 = 0.001

			if var_529_1 <= arg_526_1.time_ and arg_526_1.time_ < var_529_1 + var_529_2 then
				local var_529_3 = (arg_526_1.time_ - var_529_1) / var_529_2
				local var_529_4 = Vector3.New(0, -0.8, -6.2)

				var_529_0.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos1048ui_story, var_529_4, var_529_3)

				local var_529_5 = manager.ui.mainCamera.transform.position - var_529_0.position

				var_529_0.forward = Vector3.New(var_529_5.x, var_529_5.y, var_529_5.z)

				local var_529_6 = var_529_0.localEulerAngles

				var_529_6.z = 0
				var_529_6.x = 0
				var_529_0.localEulerAngles = var_529_6
			end

			if arg_526_1.time_ >= var_529_1 + var_529_2 and arg_526_1.time_ < var_529_1 + var_529_2 + arg_529_0 then
				var_529_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_529_7 = manager.ui.mainCamera.transform.position - var_529_0.position

				var_529_0.forward = Vector3.New(var_529_7.x, var_529_7.y, var_529_7.z)

				local var_529_8 = var_529_0.localEulerAngles

				var_529_8.z = 0
				var_529_8.x = 0
				var_529_0.localEulerAngles = var_529_8
			end

			local var_529_9 = arg_526_1.actors_["1048ui_story"]
			local var_529_10 = 0

			if var_529_10 < arg_526_1.time_ and arg_526_1.time_ <= var_529_10 + arg_529_0 and not isNil(var_529_9) and arg_526_1.var_.characterEffect1048ui_story == nil then
				arg_526_1.var_.characterEffect1048ui_story = var_529_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_11 = 0.200000002980232

			if var_529_10 <= arg_526_1.time_ and arg_526_1.time_ < var_529_10 + var_529_11 and not isNil(var_529_9) then
				local var_529_12 = (arg_526_1.time_ - var_529_10) / var_529_11

				if arg_526_1.var_.characterEffect1048ui_story and not isNil(var_529_9) then
					arg_526_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= var_529_10 + var_529_11 and arg_526_1.time_ < var_529_10 + var_529_11 + arg_529_0 and not isNil(var_529_9) and arg_526_1.var_.characterEffect1048ui_story then
				arg_526_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_529_13 = 0

			if var_529_13 < arg_526_1.time_ and arg_526_1.time_ <= var_529_13 + arg_529_0 then
				arg_526_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_529_14 = 0

			if var_529_14 < arg_526_1.time_ and arg_526_1.time_ <= var_529_14 + arg_529_0 then
				arg_526_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action2_2")
			end

			local var_529_15 = 0
			local var_529_16 = 0.975

			if var_529_15 < arg_526_1.time_ and arg_526_1.time_ <= var_529_15 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_17 = arg_526_1:FormatText(StoryNameCfg[8].name)

				arg_526_1.leftNameTxt_.text = var_529_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_18 = arg_526_1:GetWordFromCfg(1109403127)
				local var_529_19 = arg_526_1:FormatText(var_529_18.content)

				arg_526_1.text_.text = var_529_19

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_20 = 39
				local var_529_21 = utf8.len(var_529_19)
				local var_529_22 = var_529_20 <= 0 and var_529_16 or var_529_16 * (var_529_21 / var_529_20)

				if var_529_22 > 0 and var_529_16 < var_529_22 then
					arg_526_1.talkMaxDuration = var_529_22

					if var_529_22 + var_529_15 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_22 + var_529_15
					end
				end

				arg_526_1.text_.text = var_529_19
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403127", "story_v_side_new_1109403.awb") ~= 0 then
					local var_529_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403127", "story_v_side_new_1109403.awb") / 1000

					if var_529_23 + var_529_15 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_23 + var_529_15
					end

					if var_529_18.prefab_name ~= "" and arg_526_1.actors_[var_529_18.prefab_name] ~= nil then
						local var_529_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_18.prefab_name].transform, "story_v_side_new_1109403", "1109403127", "story_v_side_new_1109403.awb")

						arg_526_1:RecordAudio("1109403127", var_529_24)
						arg_526_1:RecordAudio("1109403127", var_529_24)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403127", "story_v_side_new_1109403.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403127", "story_v_side_new_1109403.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_25 = math.max(var_529_16, arg_526_1.talkMaxDuration)

			if var_529_15 <= arg_526_1.time_ and arg_526_1.time_ < var_529_15 + var_529_25 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_15) / var_529_25

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_15 + var_529_25 and arg_526_1.time_ < var_529_15 + var_529_25 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_526_1:InitPlayNodeList()
	end,
	Play1109403128 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 1109403128
		arg_530_1.duration_ = 5

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play1109403129(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = arg_530_1.actors_["1048ui_story"]
			local var_533_1 = 0

			if var_533_1 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.characterEffect1048ui_story == nil then
				arg_530_1.var_.characterEffect1048ui_story = var_533_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_2 = 0.200000002980232

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_2 and not isNil(var_533_0) then
				local var_533_3 = (arg_530_1.time_ - var_533_1) / var_533_2

				if arg_530_1.var_.characterEffect1048ui_story and not isNil(var_533_0) then
					local var_533_4 = Mathf.Lerp(0, 0.5, var_533_3)

					arg_530_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_530_1.var_.characterEffect1048ui_story.fillRatio = var_533_4
				end
			end

			if arg_530_1.time_ >= var_533_1 + var_533_2 and arg_530_1.time_ < var_533_1 + var_533_2 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.characterEffect1048ui_story then
				local var_533_5 = 0.5

				arg_530_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_530_1.var_.characterEffect1048ui_story.fillRatio = var_533_5
			end

			local var_533_6 = 0
			local var_533_7 = 0.225

			if var_533_6 < arg_530_1.time_ and arg_530_1.time_ <= var_533_6 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				local var_533_8 = arg_530_1:FormatText(StoryNameCfg[7].name)

				arg_530_1.leftNameTxt_.text = var_533_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, true)
				arg_530_1.iconController_:SetSelectedState("hero")

				arg_530_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_530_1.callingController_:SetSelectedState("normal")

				arg_530_1.keyicon_.color = Color.New(1, 1, 1)
				arg_530_1.icon_.color = Color.New(1, 1, 1)

				local var_533_9 = arg_530_1:GetWordFromCfg(1109403128)
				local var_533_10 = arg_530_1:FormatText(var_533_9.content)

				arg_530_1.text_.text = var_533_10

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_11 = 9
				local var_533_12 = utf8.len(var_533_10)
				local var_533_13 = var_533_11 <= 0 and var_533_7 or var_533_7 * (var_533_12 / var_533_11)

				if var_533_13 > 0 and var_533_7 < var_533_13 then
					arg_530_1.talkMaxDuration = var_533_13

					if var_533_13 + var_533_6 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_13 + var_533_6
					end
				end

				arg_530_1.text_.text = var_533_10
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)
				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_14 = math.max(var_533_7, arg_530_1.talkMaxDuration)

			if var_533_6 <= arg_530_1.time_ and arg_530_1.time_ < var_533_6 + var_533_14 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_6) / var_533_14

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_6 + var_533_14 and arg_530_1.time_ < var_533_6 + var_533_14 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play1109403129 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 1109403129
		arg_534_1.duration_ = 4.9

		local var_534_0 = {
			ja = 4.8,
			ko = 4.9,
			zh = 4.9
		}
		local var_534_1 = manager.audio:GetLocalizationFlag()

		if var_534_0[var_534_1] ~= nil then
			arg_534_1.duration_ = var_534_0[var_534_1]
		end

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play1109403130(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = arg_534_1.actors_["1048ui_story"].transform
			local var_537_1 = 0

			if var_537_1 < arg_534_1.time_ and arg_534_1.time_ <= var_537_1 + arg_537_0 then
				arg_534_1.var_.moveOldPos1048ui_story = var_537_0.localPosition
			end

			local var_537_2 = 0.001

			if var_537_1 <= arg_534_1.time_ and arg_534_1.time_ < var_537_1 + var_537_2 then
				local var_537_3 = (arg_534_1.time_ - var_537_1) / var_537_2
				local var_537_4 = Vector3.New(0, -0.8, -6.2)

				var_537_0.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos1048ui_story, var_537_4, var_537_3)

				local var_537_5 = manager.ui.mainCamera.transform.position - var_537_0.position

				var_537_0.forward = Vector3.New(var_537_5.x, var_537_5.y, var_537_5.z)

				local var_537_6 = var_537_0.localEulerAngles

				var_537_6.z = 0
				var_537_6.x = 0
				var_537_0.localEulerAngles = var_537_6
			end

			if arg_534_1.time_ >= var_537_1 + var_537_2 and arg_534_1.time_ < var_537_1 + var_537_2 + arg_537_0 then
				var_537_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_537_7 = manager.ui.mainCamera.transform.position - var_537_0.position

				var_537_0.forward = Vector3.New(var_537_7.x, var_537_7.y, var_537_7.z)

				local var_537_8 = var_537_0.localEulerAngles

				var_537_8.z = 0
				var_537_8.x = 0
				var_537_0.localEulerAngles = var_537_8
			end

			local var_537_9 = arg_534_1.actors_["1048ui_story"]
			local var_537_10 = 0

			if var_537_10 < arg_534_1.time_ and arg_534_1.time_ <= var_537_10 + arg_537_0 and not isNil(var_537_9) and arg_534_1.var_.characterEffect1048ui_story == nil then
				arg_534_1.var_.characterEffect1048ui_story = var_537_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_11 = 0.200000002980232

			if var_537_10 <= arg_534_1.time_ and arg_534_1.time_ < var_537_10 + var_537_11 and not isNil(var_537_9) then
				local var_537_12 = (arg_534_1.time_ - var_537_10) / var_537_11

				if arg_534_1.var_.characterEffect1048ui_story and not isNil(var_537_9) then
					arg_534_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_534_1.time_ >= var_537_10 + var_537_11 and arg_534_1.time_ < var_537_10 + var_537_11 + arg_537_0 and not isNil(var_537_9) and arg_534_1.var_.characterEffect1048ui_story then
				arg_534_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_537_13 = 0

			if var_537_13 < arg_534_1.time_ and arg_534_1.time_ <= var_537_13 + arg_537_0 then
				arg_534_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_537_14 = 0

			if var_537_14 < arg_534_1.time_ and arg_534_1.time_ <= var_537_14 + arg_537_0 then
				arg_534_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_537_15 = 0
			local var_537_16 = 0.375

			if var_537_15 < arg_534_1.time_ and arg_534_1.time_ <= var_537_15 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				local var_537_17 = arg_534_1:FormatText(StoryNameCfg[8].name)

				arg_534_1.leftNameTxt_.text = var_537_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_18 = arg_534_1:GetWordFromCfg(1109403129)
				local var_537_19 = arg_534_1:FormatText(var_537_18.content)

				arg_534_1.text_.text = var_537_19

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_20 = 15
				local var_537_21 = utf8.len(var_537_19)
				local var_537_22 = var_537_20 <= 0 and var_537_16 or var_537_16 * (var_537_21 / var_537_20)

				if var_537_22 > 0 and var_537_16 < var_537_22 then
					arg_534_1.talkMaxDuration = var_537_22

					if var_537_22 + var_537_15 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_22 + var_537_15
					end
				end

				arg_534_1.text_.text = var_537_19
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403129", "story_v_side_new_1109403.awb") ~= 0 then
					local var_537_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403129", "story_v_side_new_1109403.awb") / 1000

					if var_537_23 + var_537_15 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_23 + var_537_15
					end

					if var_537_18.prefab_name ~= "" and arg_534_1.actors_[var_537_18.prefab_name] ~= nil then
						local var_537_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_18.prefab_name].transform, "story_v_side_new_1109403", "1109403129", "story_v_side_new_1109403.awb")

						arg_534_1:RecordAudio("1109403129", var_537_24)
						arg_534_1:RecordAudio("1109403129", var_537_24)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403129", "story_v_side_new_1109403.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403129", "story_v_side_new_1109403.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_25 = math.max(var_537_16, arg_534_1.talkMaxDuration)

			if var_537_15 <= arg_534_1.time_ and arg_534_1.time_ < var_537_15 + var_537_25 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_15) / var_537_25

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_15 + var_537_25 and arg_534_1.time_ < var_537_15 + var_537_25 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_534_1:InitPlayNodeList()
	end,
	Play1109403130 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 1109403130
		arg_538_1.duration_ = 9

		local var_538_0 = {
			ja = 9,
			ko = 6.6,
			zh = 6.6
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play1109403131(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = arg_538_1.actors_["1048ui_story"].transform
			local var_541_1 = 0

			if var_541_1 < arg_538_1.time_ and arg_538_1.time_ <= var_541_1 + arg_541_0 then
				arg_538_1.var_.moveOldPos1048ui_story = var_541_0.localPosition
			end

			local var_541_2 = 0.001

			if var_541_1 <= arg_538_1.time_ and arg_538_1.time_ < var_541_1 + var_541_2 then
				local var_541_3 = (arg_538_1.time_ - var_541_1) / var_541_2
				local var_541_4 = Vector3.New(0, -0.8, -6.2)

				var_541_0.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos1048ui_story, var_541_4, var_541_3)

				local var_541_5 = manager.ui.mainCamera.transform.position - var_541_0.position

				var_541_0.forward = Vector3.New(var_541_5.x, var_541_5.y, var_541_5.z)

				local var_541_6 = var_541_0.localEulerAngles

				var_541_6.z = 0
				var_541_6.x = 0
				var_541_0.localEulerAngles = var_541_6
			end

			if arg_538_1.time_ >= var_541_1 + var_541_2 and arg_538_1.time_ < var_541_1 + var_541_2 + arg_541_0 then
				var_541_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_541_7 = manager.ui.mainCamera.transform.position - var_541_0.position

				var_541_0.forward = Vector3.New(var_541_7.x, var_541_7.y, var_541_7.z)

				local var_541_8 = var_541_0.localEulerAngles

				var_541_8.z = 0
				var_541_8.x = 0
				var_541_0.localEulerAngles = var_541_8
			end

			local var_541_9 = arg_538_1.actors_["1048ui_story"]
			local var_541_10 = 0

			if var_541_10 < arg_538_1.time_ and arg_538_1.time_ <= var_541_10 + arg_541_0 and not isNil(var_541_9) and arg_538_1.var_.characterEffect1048ui_story == nil then
				arg_538_1.var_.characterEffect1048ui_story = var_541_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_11 = 0.200000002980232

			if var_541_10 <= arg_538_1.time_ and arg_538_1.time_ < var_541_10 + var_541_11 and not isNil(var_541_9) then
				local var_541_12 = (arg_538_1.time_ - var_541_10) / var_541_11

				if arg_538_1.var_.characterEffect1048ui_story and not isNil(var_541_9) then
					arg_538_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_538_1.time_ >= var_541_10 + var_541_11 and arg_538_1.time_ < var_541_10 + var_541_11 + arg_541_0 and not isNil(var_541_9) and arg_538_1.var_.characterEffect1048ui_story then
				arg_538_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_541_13 = 0

			if var_541_13 < arg_538_1.time_ and arg_538_1.time_ <= var_541_13 + arg_541_0 then
				arg_538_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action435")
			end

			local var_541_14 = 0

			if var_541_14 < arg_538_1.time_ and arg_538_1.time_ <= var_541_14 + arg_541_0 then
				arg_538_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_541_15 = 0
			local var_541_16 = 0.775

			if var_541_15 < arg_538_1.time_ and arg_538_1.time_ <= var_541_15 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				local var_541_17 = arg_538_1:FormatText(StoryNameCfg[8].name)

				arg_538_1.leftNameTxt_.text = var_541_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_18 = arg_538_1:GetWordFromCfg(1109403130)
				local var_541_19 = arg_538_1:FormatText(var_541_18.content)

				arg_538_1.text_.text = var_541_19

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_20 = 31
				local var_541_21 = utf8.len(var_541_19)
				local var_541_22 = var_541_20 <= 0 and var_541_16 or var_541_16 * (var_541_21 / var_541_20)

				if var_541_22 > 0 and var_541_16 < var_541_22 then
					arg_538_1.talkMaxDuration = var_541_22

					if var_541_22 + var_541_15 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_22 + var_541_15
					end
				end

				arg_538_1.text_.text = var_541_19
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403130", "story_v_side_new_1109403.awb") ~= 0 then
					local var_541_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403130", "story_v_side_new_1109403.awb") / 1000

					if var_541_23 + var_541_15 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_23 + var_541_15
					end

					if var_541_18.prefab_name ~= "" and arg_538_1.actors_[var_541_18.prefab_name] ~= nil then
						local var_541_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_18.prefab_name].transform, "story_v_side_new_1109403", "1109403130", "story_v_side_new_1109403.awb")

						arg_538_1:RecordAudio("1109403130", var_541_24)
						arg_538_1:RecordAudio("1109403130", var_541_24)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403130", "story_v_side_new_1109403.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403130", "story_v_side_new_1109403.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_25 = math.max(var_541_16, arg_538_1.talkMaxDuration)

			if var_541_15 <= arg_538_1.time_ and arg_538_1.time_ < var_541_15 + var_541_25 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_15) / var_541_25

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_15 + var_541_25 and arg_538_1.time_ < var_541_15 + var_541_25 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_538_1:InitPlayNodeList()
	end,
	Play1109403131 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 1109403131
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play1109403132(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = arg_542_1.actors_["1048ui_story"]
			local var_545_1 = 0

			if var_545_1 < arg_542_1.time_ and arg_542_1.time_ <= var_545_1 + arg_545_0 and not isNil(var_545_0) and arg_542_1.var_.characterEffect1048ui_story == nil then
				arg_542_1.var_.characterEffect1048ui_story = var_545_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_2 = 0.200000002980232

			if var_545_1 <= arg_542_1.time_ and arg_542_1.time_ < var_545_1 + var_545_2 and not isNil(var_545_0) then
				local var_545_3 = (arg_542_1.time_ - var_545_1) / var_545_2

				if arg_542_1.var_.characterEffect1048ui_story and not isNil(var_545_0) then
					local var_545_4 = Mathf.Lerp(0, 0.5, var_545_3)

					arg_542_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_542_1.var_.characterEffect1048ui_story.fillRatio = var_545_4
				end
			end

			if arg_542_1.time_ >= var_545_1 + var_545_2 and arg_542_1.time_ < var_545_1 + var_545_2 + arg_545_0 and not isNil(var_545_0) and arg_542_1.var_.characterEffect1048ui_story then
				local var_545_5 = 0.5

				arg_542_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_542_1.var_.characterEffect1048ui_story.fillRatio = var_545_5
			end

			local var_545_6 = 0
			local var_545_7 = 0.25

			if var_545_6 < arg_542_1.time_ and arg_542_1.time_ <= var_545_6 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				local var_545_8 = arg_542_1:FormatText(StoryNameCfg[7].name)

				arg_542_1.leftNameTxt_.text = var_545_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, true)
				arg_542_1.iconController_:SetSelectedState("hero")

				arg_542_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_542_1.callingController_:SetSelectedState("normal")

				arg_542_1.keyicon_.color = Color.New(1, 1, 1)
				arg_542_1.icon_.color = Color.New(1, 1, 1)

				local var_545_9 = arg_542_1:GetWordFromCfg(1109403131)
				local var_545_10 = arg_542_1:FormatText(var_545_9.content)

				arg_542_1.text_.text = var_545_10

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_11 = 11
				local var_545_12 = utf8.len(var_545_10)
				local var_545_13 = var_545_11 <= 0 and var_545_7 or var_545_7 * (var_545_12 / var_545_11)

				if var_545_13 > 0 and var_545_7 < var_545_13 then
					arg_542_1.talkMaxDuration = var_545_13

					if var_545_13 + var_545_6 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_13 + var_545_6
					end
				end

				arg_542_1.text_.text = var_545_10
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_14 = math.max(var_545_7, arg_542_1.talkMaxDuration)

			if var_545_6 <= arg_542_1.time_ and arg_542_1.time_ < var_545_6 + var_545_14 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_6) / var_545_14

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_6 + var_545_14 and arg_542_1.time_ < var_545_6 + var_545_14 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play1109403132 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 1109403132
		arg_546_1.duration_ = 10.13

		local var_546_0 = {
			ja = 10.133,
			ko = 8.033,
			zh = 8.033
		}
		local var_546_1 = manager.audio:GetLocalizationFlag()

		if var_546_0[var_546_1] ~= nil then
			arg_546_1.duration_ = var_546_0[var_546_1]
		end

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play1109403133(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = arg_546_1.actors_["1048ui_story"].transform
			local var_549_1 = 0

			if var_549_1 < arg_546_1.time_ and arg_546_1.time_ <= var_549_1 + arg_549_0 then
				arg_546_1.var_.moveOldPos1048ui_story = var_549_0.localPosition
			end

			local var_549_2 = 0.001

			if var_549_1 <= arg_546_1.time_ and arg_546_1.time_ < var_549_1 + var_549_2 then
				local var_549_3 = (arg_546_1.time_ - var_549_1) / var_549_2
				local var_549_4 = Vector3.New(0, -0.8, -6.2)

				var_549_0.localPosition = Vector3.Lerp(arg_546_1.var_.moveOldPos1048ui_story, var_549_4, var_549_3)

				local var_549_5 = manager.ui.mainCamera.transform.position - var_549_0.position

				var_549_0.forward = Vector3.New(var_549_5.x, var_549_5.y, var_549_5.z)

				local var_549_6 = var_549_0.localEulerAngles

				var_549_6.z = 0
				var_549_6.x = 0
				var_549_0.localEulerAngles = var_549_6
			end

			if arg_546_1.time_ >= var_549_1 + var_549_2 and arg_546_1.time_ < var_549_1 + var_549_2 + arg_549_0 then
				var_549_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_549_7 = manager.ui.mainCamera.transform.position - var_549_0.position

				var_549_0.forward = Vector3.New(var_549_7.x, var_549_7.y, var_549_7.z)

				local var_549_8 = var_549_0.localEulerAngles

				var_549_8.z = 0
				var_549_8.x = 0
				var_549_0.localEulerAngles = var_549_8
			end

			local var_549_9 = arg_546_1.actors_["1048ui_story"]
			local var_549_10 = 0

			if var_549_10 < arg_546_1.time_ and arg_546_1.time_ <= var_549_10 + arg_549_0 and not isNil(var_549_9) and arg_546_1.var_.characterEffect1048ui_story == nil then
				arg_546_1.var_.characterEffect1048ui_story = var_549_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_549_11 = 0.200000002980232

			if var_549_10 <= arg_546_1.time_ and arg_546_1.time_ < var_549_10 + var_549_11 and not isNil(var_549_9) then
				local var_549_12 = (arg_546_1.time_ - var_549_10) / var_549_11

				if arg_546_1.var_.characterEffect1048ui_story and not isNil(var_549_9) then
					arg_546_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_546_1.time_ >= var_549_10 + var_549_11 and arg_546_1.time_ < var_549_10 + var_549_11 + arg_549_0 and not isNil(var_549_9) and arg_546_1.var_.characterEffect1048ui_story then
				arg_546_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_549_13 = 0

			if var_549_13 < arg_546_1.time_ and arg_546_1.time_ <= var_549_13 + arg_549_0 then
				arg_546_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_549_14 = 0
			local var_549_15 = 0.95

			if var_549_14 < arg_546_1.time_ and arg_546_1.time_ <= var_549_14 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				local var_549_16 = arg_546_1:FormatText(StoryNameCfg[8].name)

				arg_546_1.leftNameTxt_.text = var_549_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_17 = arg_546_1:GetWordFromCfg(1109403132)
				local var_549_18 = arg_546_1:FormatText(var_549_17.content)

				arg_546_1.text_.text = var_549_18

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_19 = 38
				local var_549_20 = utf8.len(var_549_18)
				local var_549_21 = var_549_19 <= 0 and var_549_15 or var_549_15 * (var_549_20 / var_549_19)

				if var_549_21 > 0 and var_549_15 < var_549_21 then
					arg_546_1.talkMaxDuration = var_549_21

					if var_549_21 + var_549_14 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_21 + var_549_14
					end
				end

				arg_546_1.text_.text = var_549_18
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403132", "story_v_side_new_1109403.awb") ~= 0 then
					local var_549_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403132", "story_v_side_new_1109403.awb") / 1000

					if var_549_22 + var_549_14 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_22 + var_549_14
					end

					if var_549_17.prefab_name ~= "" and arg_546_1.actors_[var_549_17.prefab_name] ~= nil then
						local var_549_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_17.prefab_name].transform, "story_v_side_new_1109403", "1109403132", "story_v_side_new_1109403.awb")

						arg_546_1:RecordAudio("1109403132", var_549_23)
						arg_546_1:RecordAudio("1109403132", var_549_23)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403132", "story_v_side_new_1109403.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403132", "story_v_side_new_1109403.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_24 = math.max(var_549_15, arg_546_1.talkMaxDuration)

			if var_549_14 <= arg_546_1.time_ and arg_546_1.time_ < var_549_14 + var_549_24 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_14) / var_549_24

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_14 + var_549_24 and arg_546_1.time_ < var_549_14 + var_549_24 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_546_1:InitPlayNodeList()
	end,
	Play1109403133 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 1109403133
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play1109403134(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = arg_550_1.actors_["1048ui_story"]
			local var_553_1 = 0

			if var_553_1 < arg_550_1.time_ and arg_550_1.time_ <= var_553_1 + arg_553_0 and not isNil(var_553_0) and arg_550_1.var_.characterEffect1048ui_story == nil then
				arg_550_1.var_.characterEffect1048ui_story = var_553_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_553_2 = 0.200000002980232

			if var_553_1 <= arg_550_1.time_ and arg_550_1.time_ < var_553_1 + var_553_2 and not isNil(var_553_0) then
				local var_553_3 = (arg_550_1.time_ - var_553_1) / var_553_2

				if arg_550_1.var_.characterEffect1048ui_story and not isNil(var_553_0) then
					local var_553_4 = Mathf.Lerp(0, 0.5, var_553_3)

					arg_550_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_550_1.var_.characterEffect1048ui_story.fillRatio = var_553_4
				end
			end

			if arg_550_1.time_ >= var_553_1 + var_553_2 and arg_550_1.time_ < var_553_1 + var_553_2 + arg_553_0 and not isNil(var_553_0) and arg_550_1.var_.characterEffect1048ui_story then
				local var_553_5 = 0.5

				arg_550_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_550_1.var_.characterEffect1048ui_story.fillRatio = var_553_5
			end

			local var_553_6 = 0
			local var_553_7 = 0.625

			if var_553_6 < arg_550_1.time_ and arg_550_1.time_ <= var_553_6 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				local var_553_8 = arg_550_1:FormatText(StoryNameCfg[7].name)

				arg_550_1.leftNameTxt_.text = var_553_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, true)
				arg_550_1.iconController_:SetSelectedState("hero")

				arg_550_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_550_1.callingController_:SetSelectedState("normal")

				arg_550_1.keyicon_.color = Color.New(1, 1, 1)
				arg_550_1.icon_.color = Color.New(1, 1, 1)

				local var_553_9 = arg_550_1:GetWordFromCfg(1109403133)
				local var_553_10 = arg_550_1:FormatText(var_553_9.content)

				arg_550_1.text_.text = var_553_10

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_11 = 25
				local var_553_12 = utf8.len(var_553_10)
				local var_553_13 = var_553_11 <= 0 and var_553_7 or var_553_7 * (var_553_12 / var_553_11)

				if var_553_13 > 0 and var_553_7 < var_553_13 then
					arg_550_1.talkMaxDuration = var_553_13

					if var_553_13 + var_553_6 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_13 + var_553_6
					end
				end

				arg_550_1.text_.text = var_553_10
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_14 = math.max(var_553_7, arg_550_1.talkMaxDuration)

			if var_553_6 <= arg_550_1.time_ and arg_550_1.time_ < var_553_6 + var_553_14 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_6) / var_553_14

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_6 + var_553_14 and arg_550_1.time_ < var_553_6 + var_553_14 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play1109403134 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 1109403134
		arg_554_1.duration_ = 10.17

		local var_554_0 = {
			ja = 10.166,
			ko = 7,
			zh = 7
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play1109403135(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = arg_554_1.actors_["1048ui_story"].transform
			local var_557_1 = 0

			if var_557_1 < arg_554_1.time_ and arg_554_1.time_ <= var_557_1 + arg_557_0 then
				arg_554_1.var_.moveOldPos1048ui_story = var_557_0.localPosition
			end

			local var_557_2 = 0.001

			if var_557_1 <= arg_554_1.time_ and arg_554_1.time_ < var_557_1 + var_557_2 then
				local var_557_3 = (arg_554_1.time_ - var_557_1) / var_557_2
				local var_557_4 = Vector3.New(0, -0.8, -6.2)

				var_557_0.localPosition = Vector3.Lerp(arg_554_1.var_.moveOldPos1048ui_story, var_557_4, var_557_3)

				local var_557_5 = manager.ui.mainCamera.transform.position - var_557_0.position

				var_557_0.forward = Vector3.New(var_557_5.x, var_557_5.y, var_557_5.z)

				local var_557_6 = var_557_0.localEulerAngles

				var_557_6.z = 0
				var_557_6.x = 0
				var_557_0.localEulerAngles = var_557_6
			end

			if arg_554_1.time_ >= var_557_1 + var_557_2 and arg_554_1.time_ < var_557_1 + var_557_2 + arg_557_0 then
				var_557_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_557_7 = manager.ui.mainCamera.transform.position - var_557_0.position

				var_557_0.forward = Vector3.New(var_557_7.x, var_557_7.y, var_557_7.z)

				local var_557_8 = var_557_0.localEulerAngles

				var_557_8.z = 0
				var_557_8.x = 0
				var_557_0.localEulerAngles = var_557_8
			end

			local var_557_9 = arg_554_1.actors_["1048ui_story"]
			local var_557_10 = 0

			if var_557_10 < arg_554_1.time_ and arg_554_1.time_ <= var_557_10 + arg_557_0 and not isNil(var_557_9) and arg_554_1.var_.characterEffect1048ui_story == nil then
				arg_554_1.var_.characterEffect1048ui_story = var_557_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_557_11 = 0.200000002980232

			if var_557_10 <= arg_554_1.time_ and arg_554_1.time_ < var_557_10 + var_557_11 and not isNil(var_557_9) then
				local var_557_12 = (arg_554_1.time_ - var_557_10) / var_557_11

				if arg_554_1.var_.characterEffect1048ui_story and not isNil(var_557_9) then
					arg_554_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_554_1.time_ >= var_557_10 + var_557_11 and arg_554_1.time_ < var_557_10 + var_557_11 + arg_557_0 and not isNil(var_557_9) and arg_554_1.var_.characterEffect1048ui_story then
				arg_554_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_557_13 = 0

			if var_557_13 < arg_554_1.time_ and arg_554_1.time_ <= var_557_13 + arg_557_0 then
				arg_554_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action454")
			end

			local var_557_14 = 0

			if var_557_14 < arg_554_1.time_ and arg_554_1.time_ <= var_557_14 + arg_557_0 then
				arg_554_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_557_15 = 0
			local var_557_16 = 0.75

			if var_557_15 < arg_554_1.time_ and arg_554_1.time_ <= var_557_15 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				local var_557_17 = arg_554_1:FormatText(StoryNameCfg[8].name)

				arg_554_1.leftNameTxt_.text = var_557_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_18 = arg_554_1:GetWordFromCfg(1109403134)
				local var_557_19 = arg_554_1:FormatText(var_557_18.content)

				arg_554_1.text_.text = var_557_19

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_20 = 30
				local var_557_21 = utf8.len(var_557_19)
				local var_557_22 = var_557_20 <= 0 and var_557_16 or var_557_16 * (var_557_21 / var_557_20)

				if var_557_22 > 0 and var_557_16 < var_557_22 then
					arg_554_1.talkMaxDuration = var_557_22

					if var_557_22 + var_557_15 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_22 + var_557_15
					end
				end

				arg_554_1.text_.text = var_557_19
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403134", "story_v_side_new_1109403.awb") ~= 0 then
					local var_557_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403134", "story_v_side_new_1109403.awb") / 1000

					if var_557_23 + var_557_15 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_23 + var_557_15
					end

					if var_557_18.prefab_name ~= "" and arg_554_1.actors_[var_557_18.prefab_name] ~= nil then
						local var_557_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_18.prefab_name].transform, "story_v_side_new_1109403", "1109403134", "story_v_side_new_1109403.awb")

						arg_554_1:RecordAudio("1109403134", var_557_24)
						arg_554_1:RecordAudio("1109403134", var_557_24)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403134", "story_v_side_new_1109403.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403134", "story_v_side_new_1109403.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_25 = math.max(var_557_16, arg_554_1.talkMaxDuration)

			if var_557_15 <= arg_554_1.time_ and arg_554_1.time_ < var_557_15 + var_557_25 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_15) / var_557_25

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_15 + var_557_25 and arg_554_1.time_ < var_557_15 + var_557_25 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_554_1:InitPlayNodeList()
	end,
	Play1109403135 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 1109403135
		arg_558_1.duration_ = 5

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play1109403136(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = arg_558_1.actors_["1048ui_story"]
			local var_561_1 = 0

			if var_561_1 < arg_558_1.time_ and arg_558_1.time_ <= var_561_1 + arg_561_0 and not isNil(var_561_0) and arg_558_1.var_.characterEffect1048ui_story == nil then
				arg_558_1.var_.characterEffect1048ui_story = var_561_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_2 = 0.200000002980232

			if var_561_1 <= arg_558_1.time_ and arg_558_1.time_ < var_561_1 + var_561_2 and not isNil(var_561_0) then
				local var_561_3 = (arg_558_1.time_ - var_561_1) / var_561_2

				if arg_558_1.var_.characterEffect1048ui_story and not isNil(var_561_0) then
					local var_561_4 = Mathf.Lerp(0, 0.5, var_561_3)

					arg_558_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_558_1.var_.characterEffect1048ui_story.fillRatio = var_561_4
				end
			end

			if arg_558_1.time_ >= var_561_1 + var_561_2 and arg_558_1.time_ < var_561_1 + var_561_2 + arg_561_0 and not isNil(var_561_0) and arg_558_1.var_.characterEffect1048ui_story then
				local var_561_5 = 0.5

				arg_558_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_558_1.var_.characterEffect1048ui_story.fillRatio = var_561_5
			end

			local var_561_6 = 0
			local var_561_7 = 0.2

			if var_561_6 < arg_558_1.time_ and arg_558_1.time_ <= var_561_6 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_8 = arg_558_1:FormatText(StoryNameCfg[7].name)

				arg_558_1.leftNameTxt_.text = var_561_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, true)
				arg_558_1.iconController_:SetSelectedState("hero")

				arg_558_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_558_1.callingController_:SetSelectedState("normal")

				arg_558_1.keyicon_.color = Color.New(1, 1, 1)
				arg_558_1.icon_.color = Color.New(1, 1, 1)

				local var_561_9 = arg_558_1:GetWordFromCfg(1109403135)
				local var_561_10 = arg_558_1:FormatText(var_561_9.content)

				arg_558_1.text_.text = var_561_10

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_11 = 8
				local var_561_12 = utf8.len(var_561_10)
				local var_561_13 = var_561_11 <= 0 and var_561_7 or var_561_7 * (var_561_12 / var_561_11)

				if var_561_13 > 0 and var_561_7 < var_561_13 then
					arg_558_1.talkMaxDuration = var_561_13

					if var_561_13 + var_561_6 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_13 + var_561_6
					end
				end

				arg_558_1.text_.text = var_561_10
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)
				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_14 = math.max(var_561_7, arg_558_1.talkMaxDuration)

			if var_561_6 <= arg_558_1.time_ and arg_558_1.time_ < var_561_6 + var_561_14 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_6) / var_561_14

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_6 + var_561_14 and arg_558_1.time_ < var_561_6 + var_561_14 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play1109403136 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 1109403136
		arg_562_1.duration_ = 8.97

		local var_562_0 = {
			ja = 8.966,
			ko = 3.166,
			zh = 3.166
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play1109403137(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = arg_562_1.actors_["1048ui_story"].transform
			local var_565_1 = 0

			if var_565_1 < arg_562_1.time_ and arg_562_1.time_ <= var_565_1 + arg_565_0 then
				arg_562_1.var_.moveOldPos1048ui_story = var_565_0.localPosition
			end

			local var_565_2 = 0.001

			if var_565_1 <= arg_562_1.time_ and arg_562_1.time_ < var_565_1 + var_565_2 then
				local var_565_3 = (arg_562_1.time_ - var_565_1) / var_565_2
				local var_565_4 = Vector3.New(0, -0.8, -6.2)

				var_565_0.localPosition = Vector3.Lerp(arg_562_1.var_.moveOldPos1048ui_story, var_565_4, var_565_3)

				local var_565_5 = manager.ui.mainCamera.transform.position - var_565_0.position

				var_565_0.forward = Vector3.New(var_565_5.x, var_565_5.y, var_565_5.z)

				local var_565_6 = var_565_0.localEulerAngles

				var_565_6.z = 0
				var_565_6.x = 0
				var_565_0.localEulerAngles = var_565_6
			end

			if arg_562_1.time_ >= var_565_1 + var_565_2 and arg_562_1.time_ < var_565_1 + var_565_2 + arg_565_0 then
				var_565_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_565_7 = manager.ui.mainCamera.transform.position - var_565_0.position

				var_565_0.forward = Vector3.New(var_565_7.x, var_565_7.y, var_565_7.z)

				local var_565_8 = var_565_0.localEulerAngles

				var_565_8.z = 0
				var_565_8.x = 0
				var_565_0.localEulerAngles = var_565_8
			end

			local var_565_9 = arg_562_1.actors_["1048ui_story"]
			local var_565_10 = 0

			if var_565_10 < arg_562_1.time_ and arg_562_1.time_ <= var_565_10 + arg_565_0 and not isNil(var_565_9) and arg_562_1.var_.characterEffect1048ui_story == nil then
				arg_562_1.var_.characterEffect1048ui_story = var_565_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_565_11 = 0.200000002980232

			if var_565_10 <= arg_562_1.time_ and arg_562_1.time_ < var_565_10 + var_565_11 and not isNil(var_565_9) then
				local var_565_12 = (arg_562_1.time_ - var_565_10) / var_565_11

				if arg_562_1.var_.characterEffect1048ui_story and not isNil(var_565_9) then
					arg_562_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_562_1.time_ >= var_565_10 + var_565_11 and arg_562_1.time_ < var_565_10 + var_565_11 + arg_565_0 and not isNil(var_565_9) and arg_562_1.var_.characterEffect1048ui_story then
				arg_562_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_565_13 = 0

			if var_565_13 < arg_562_1.time_ and arg_562_1.time_ <= var_565_13 + arg_565_0 then
				arg_562_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action446")
			end

			local var_565_14 = 0

			if var_565_14 < arg_562_1.time_ and arg_562_1.time_ <= var_565_14 + arg_565_0 then
				arg_562_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_565_15 = 0
			local var_565_16 = 0.35

			if var_565_15 < arg_562_1.time_ and arg_562_1.time_ <= var_565_15 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				local var_565_17 = arg_562_1:FormatText(StoryNameCfg[8].name)

				arg_562_1.leftNameTxt_.text = var_565_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_18 = arg_562_1:GetWordFromCfg(1109403136)
				local var_565_19 = arg_562_1:FormatText(var_565_18.content)

				arg_562_1.text_.text = var_565_19

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_20 = 14
				local var_565_21 = utf8.len(var_565_19)
				local var_565_22 = var_565_20 <= 0 and var_565_16 or var_565_16 * (var_565_21 / var_565_20)

				if var_565_22 > 0 and var_565_16 < var_565_22 then
					arg_562_1.talkMaxDuration = var_565_22

					if var_565_22 + var_565_15 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_22 + var_565_15
					end
				end

				arg_562_1.text_.text = var_565_19
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403136", "story_v_side_new_1109403.awb") ~= 0 then
					local var_565_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403136", "story_v_side_new_1109403.awb") / 1000

					if var_565_23 + var_565_15 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_23 + var_565_15
					end

					if var_565_18.prefab_name ~= "" and arg_562_1.actors_[var_565_18.prefab_name] ~= nil then
						local var_565_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_18.prefab_name].transform, "story_v_side_new_1109403", "1109403136", "story_v_side_new_1109403.awb")

						arg_562_1:RecordAudio("1109403136", var_565_24)
						arg_562_1:RecordAudio("1109403136", var_565_24)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403136", "story_v_side_new_1109403.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403136", "story_v_side_new_1109403.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_25 = math.max(var_565_16, arg_562_1.talkMaxDuration)

			if var_565_15 <= arg_562_1.time_ and arg_562_1.time_ < var_565_15 + var_565_25 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_15) / var_565_25

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_15 + var_565_25 and arg_562_1.time_ < var_565_15 + var_565_25 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_562_1:InitPlayNodeList()
	end,
	Play1109403137 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 1109403137
		arg_566_1.duration_ = 4.47

		local var_566_0 = {
			ja = 4.466,
			ko = 3.733,
			zh = 3.733
		}
		local var_566_1 = manager.audio:GetLocalizationFlag()

		if var_566_0[var_566_1] ~= nil then
			arg_566_1.duration_ = var_566_0[var_566_1]
		end

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play1109403138(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = arg_566_1.actors_["1048ui_story"].transform
			local var_569_1 = 0

			if var_569_1 < arg_566_1.time_ and arg_566_1.time_ <= var_569_1 + arg_569_0 then
				arg_566_1.var_.moveOldPos1048ui_story = var_569_0.localPosition
			end

			local var_569_2 = 0.001

			if var_569_1 <= arg_566_1.time_ and arg_566_1.time_ < var_569_1 + var_569_2 then
				local var_569_3 = (arg_566_1.time_ - var_569_1) / var_569_2
				local var_569_4 = Vector3.New(0, -0.8, -6.2)

				var_569_0.localPosition = Vector3.Lerp(arg_566_1.var_.moveOldPos1048ui_story, var_569_4, var_569_3)

				local var_569_5 = manager.ui.mainCamera.transform.position - var_569_0.position

				var_569_0.forward = Vector3.New(var_569_5.x, var_569_5.y, var_569_5.z)

				local var_569_6 = var_569_0.localEulerAngles

				var_569_6.z = 0
				var_569_6.x = 0
				var_569_0.localEulerAngles = var_569_6
			end

			if arg_566_1.time_ >= var_569_1 + var_569_2 and arg_566_1.time_ < var_569_1 + var_569_2 + arg_569_0 then
				var_569_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_569_7 = manager.ui.mainCamera.transform.position - var_569_0.position

				var_569_0.forward = Vector3.New(var_569_7.x, var_569_7.y, var_569_7.z)

				local var_569_8 = var_569_0.localEulerAngles

				var_569_8.z = 0
				var_569_8.x = 0
				var_569_0.localEulerAngles = var_569_8
			end

			local var_569_9 = arg_566_1.actors_["1048ui_story"]
			local var_569_10 = 0

			if var_569_10 < arg_566_1.time_ and arg_566_1.time_ <= var_569_10 + arg_569_0 and not isNil(var_569_9) and arg_566_1.var_.characterEffect1048ui_story == nil then
				arg_566_1.var_.characterEffect1048ui_story = var_569_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_11 = 0.200000002980232

			if var_569_10 <= arg_566_1.time_ and arg_566_1.time_ < var_569_10 + var_569_11 and not isNil(var_569_9) then
				local var_569_12 = (arg_566_1.time_ - var_569_10) / var_569_11

				if arg_566_1.var_.characterEffect1048ui_story and not isNil(var_569_9) then
					arg_566_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_566_1.time_ >= var_569_10 + var_569_11 and arg_566_1.time_ < var_569_10 + var_569_11 + arg_569_0 and not isNil(var_569_9) and arg_566_1.var_.characterEffect1048ui_story then
				arg_566_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_569_13 = 0

			if var_569_13 < arg_566_1.time_ and arg_566_1.time_ <= var_569_13 + arg_569_0 then
				arg_566_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_569_14 = 0
			local var_569_15 = 0.375

			if var_569_14 < arg_566_1.time_ and arg_566_1.time_ <= var_569_14 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				local var_569_16 = arg_566_1:FormatText(StoryNameCfg[8].name)

				arg_566_1.leftNameTxt_.text = var_569_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_17 = arg_566_1:GetWordFromCfg(1109403137)
				local var_569_18 = arg_566_1:FormatText(var_569_17.content)

				arg_566_1.text_.text = var_569_18

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_19 = 15
				local var_569_20 = utf8.len(var_569_18)
				local var_569_21 = var_569_19 <= 0 and var_569_15 or var_569_15 * (var_569_20 / var_569_19)

				if var_569_21 > 0 and var_569_15 < var_569_21 then
					arg_566_1.talkMaxDuration = var_569_21

					if var_569_21 + var_569_14 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_21 + var_569_14
					end
				end

				arg_566_1.text_.text = var_569_18
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403137", "story_v_side_new_1109403.awb") ~= 0 then
					local var_569_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403137", "story_v_side_new_1109403.awb") / 1000

					if var_569_22 + var_569_14 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_22 + var_569_14
					end

					if var_569_17.prefab_name ~= "" and arg_566_1.actors_[var_569_17.prefab_name] ~= nil then
						local var_569_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_17.prefab_name].transform, "story_v_side_new_1109403", "1109403137", "story_v_side_new_1109403.awb")

						arg_566_1:RecordAudio("1109403137", var_569_23)
						arg_566_1:RecordAudio("1109403137", var_569_23)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403137", "story_v_side_new_1109403.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403137", "story_v_side_new_1109403.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_24 = math.max(var_569_15, arg_566_1.talkMaxDuration)

			if var_569_14 <= arg_566_1.time_ and arg_566_1.time_ < var_569_14 + var_569_24 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_14) / var_569_24

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_14 + var_569_24 and arg_566_1.time_ < var_569_14 + var_569_24 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_566_1:InitPlayNodeList()
	end,
	Play1109403138 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 1109403138
		arg_570_1.duration_ = 5

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play1109403139(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = arg_570_1.actors_["1048ui_story"]
			local var_573_1 = 0

			if var_573_1 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.characterEffect1048ui_story == nil then
				arg_570_1.var_.characterEffect1048ui_story = var_573_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_2 = 0.200000002980232

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_2 and not isNil(var_573_0) then
				local var_573_3 = (arg_570_1.time_ - var_573_1) / var_573_2

				if arg_570_1.var_.characterEffect1048ui_story and not isNil(var_573_0) then
					local var_573_4 = Mathf.Lerp(0, 0.5, var_573_3)

					arg_570_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_570_1.var_.characterEffect1048ui_story.fillRatio = var_573_4
				end
			end

			if arg_570_1.time_ >= var_573_1 + var_573_2 and arg_570_1.time_ < var_573_1 + var_573_2 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.characterEffect1048ui_story then
				local var_573_5 = 0.5

				arg_570_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_570_1.var_.characterEffect1048ui_story.fillRatio = var_573_5
			end

			local var_573_6 = 0
			local var_573_7 = 0.85

			if var_573_6 < arg_570_1.time_ and arg_570_1.time_ <= var_573_6 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, false)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_8 = arg_570_1:GetWordFromCfg(1109403138)
				local var_573_9 = arg_570_1:FormatText(var_573_8.content)

				arg_570_1.text_.text = var_573_9

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_10 = 34
				local var_573_11 = utf8.len(var_573_9)
				local var_573_12 = var_573_10 <= 0 and var_573_7 or var_573_7 * (var_573_11 / var_573_10)

				if var_573_12 > 0 and var_573_7 < var_573_12 then
					arg_570_1.talkMaxDuration = var_573_12

					if var_573_12 + var_573_6 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_12 + var_573_6
					end
				end

				arg_570_1.text_.text = var_573_9
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)
				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_13 = math.max(var_573_7, arg_570_1.talkMaxDuration)

			if var_573_6 <= arg_570_1.time_ and arg_570_1.time_ < var_573_6 + var_573_13 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_6) / var_573_13

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_6 + var_573_13 and arg_570_1.time_ < var_573_6 + var_573_13 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play1109403139 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 1109403139
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play1109403140(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = 0
			local var_577_1 = 1.525

			if var_577_0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_0 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				local var_577_2 = arg_574_1:FormatText(StoryNameCfg[7].name)

				arg_574_1.leftNameTxt_.text = var_577_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, true)
				arg_574_1.iconController_:SetSelectedState("hero")

				arg_574_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_574_1.callingController_:SetSelectedState("normal")

				arg_574_1.keyicon_.color = Color.New(1, 1, 1)
				arg_574_1.icon_.color = Color.New(1, 1, 1)

				local var_577_3 = arg_574_1:GetWordFromCfg(1109403139)
				local var_577_4 = arg_574_1:FormatText(var_577_3.content)

				arg_574_1.text_.text = var_577_4

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_5 = 61
				local var_577_6 = utf8.len(var_577_4)
				local var_577_7 = var_577_5 <= 0 and var_577_1 or var_577_1 * (var_577_6 / var_577_5)

				if var_577_7 > 0 and var_577_1 < var_577_7 then
					arg_574_1.talkMaxDuration = var_577_7

					if var_577_7 + var_577_0 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_7 + var_577_0
					end
				end

				arg_574_1.text_.text = var_577_4
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)
				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_8 = math.max(var_577_1, arg_574_1.talkMaxDuration)

			if var_577_0 <= arg_574_1.time_ and arg_574_1.time_ < var_577_0 + var_577_8 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_0) / var_577_8

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_0 + var_577_8 and arg_574_1.time_ < var_577_0 + var_577_8 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play1109403140 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 1109403140
		arg_578_1.duration_ = 5.53

		local var_578_0 = {
			ja = 5.533,
			ko = 3.9,
			zh = 3.9
		}
		local var_578_1 = manager.audio:GetLocalizationFlag()

		if var_578_0[var_578_1] ~= nil then
			arg_578_1.duration_ = var_578_0[var_578_1]
		end

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play1109403141(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = arg_578_1.actors_["1048ui_story"].transform
			local var_581_1 = 0

			if var_581_1 < arg_578_1.time_ and arg_578_1.time_ <= var_581_1 + arg_581_0 then
				arg_578_1.var_.moveOldPos1048ui_story = var_581_0.localPosition
			end

			local var_581_2 = 0.001

			if var_581_1 <= arg_578_1.time_ and arg_578_1.time_ < var_581_1 + var_581_2 then
				local var_581_3 = (arg_578_1.time_ - var_581_1) / var_581_2
				local var_581_4 = Vector3.New(0, -0.8, -6.2)

				var_581_0.localPosition = Vector3.Lerp(arg_578_1.var_.moveOldPos1048ui_story, var_581_4, var_581_3)

				local var_581_5 = manager.ui.mainCamera.transform.position - var_581_0.position

				var_581_0.forward = Vector3.New(var_581_5.x, var_581_5.y, var_581_5.z)

				local var_581_6 = var_581_0.localEulerAngles

				var_581_6.z = 0
				var_581_6.x = 0
				var_581_0.localEulerAngles = var_581_6
			end

			if arg_578_1.time_ >= var_581_1 + var_581_2 and arg_578_1.time_ < var_581_1 + var_581_2 + arg_581_0 then
				var_581_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_581_7 = manager.ui.mainCamera.transform.position - var_581_0.position

				var_581_0.forward = Vector3.New(var_581_7.x, var_581_7.y, var_581_7.z)

				local var_581_8 = var_581_0.localEulerAngles

				var_581_8.z = 0
				var_581_8.x = 0
				var_581_0.localEulerAngles = var_581_8
			end

			local var_581_9 = arg_578_1.actors_["1048ui_story"]
			local var_581_10 = 0

			if var_581_10 < arg_578_1.time_ and arg_578_1.time_ <= var_581_10 + arg_581_0 and not isNil(var_581_9) and arg_578_1.var_.characterEffect1048ui_story == nil then
				arg_578_1.var_.characterEffect1048ui_story = var_581_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_11 = 0.200000002980232

			if var_581_10 <= arg_578_1.time_ and arg_578_1.time_ < var_581_10 + var_581_11 and not isNil(var_581_9) then
				local var_581_12 = (arg_578_1.time_ - var_581_10) / var_581_11

				if arg_578_1.var_.characterEffect1048ui_story and not isNil(var_581_9) then
					arg_578_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_578_1.time_ >= var_581_10 + var_581_11 and arg_578_1.time_ < var_581_10 + var_581_11 + arg_581_0 and not isNil(var_581_9) and arg_578_1.var_.characterEffect1048ui_story then
				arg_578_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_581_13 = 0

			if var_581_13 < arg_578_1.time_ and arg_578_1.time_ <= var_581_13 + arg_581_0 then
				arg_578_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_581_14 = 0
			local var_581_15 = 0.425

			if var_581_14 < arg_578_1.time_ and arg_578_1.time_ <= var_581_14 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				local var_581_16 = arg_578_1:FormatText(StoryNameCfg[8].name)

				arg_578_1.leftNameTxt_.text = var_581_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_17 = arg_578_1:GetWordFromCfg(1109403140)
				local var_581_18 = arg_578_1:FormatText(var_581_17.content)

				arg_578_1.text_.text = var_581_18

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_19 = 17
				local var_581_20 = utf8.len(var_581_18)
				local var_581_21 = var_581_19 <= 0 and var_581_15 or var_581_15 * (var_581_20 / var_581_19)

				if var_581_21 > 0 and var_581_15 < var_581_21 then
					arg_578_1.talkMaxDuration = var_581_21

					if var_581_21 + var_581_14 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_21 + var_581_14
					end
				end

				arg_578_1.text_.text = var_581_18
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403140", "story_v_side_new_1109403.awb") ~= 0 then
					local var_581_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403140", "story_v_side_new_1109403.awb") / 1000

					if var_581_22 + var_581_14 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_22 + var_581_14
					end

					if var_581_17.prefab_name ~= "" and arg_578_1.actors_[var_581_17.prefab_name] ~= nil then
						local var_581_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_17.prefab_name].transform, "story_v_side_new_1109403", "1109403140", "story_v_side_new_1109403.awb")

						arg_578_1:RecordAudio("1109403140", var_581_23)
						arg_578_1:RecordAudio("1109403140", var_581_23)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403140", "story_v_side_new_1109403.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403140", "story_v_side_new_1109403.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_24 = math.max(var_581_15, arg_578_1.talkMaxDuration)

			if var_581_14 <= arg_578_1.time_ and arg_578_1.time_ < var_581_14 + var_581_24 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_14) / var_581_24

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_14 + var_581_24 and arg_578_1.time_ < var_581_14 + var_581_24 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_578_1:InitPlayNodeList()
	end,
	Play1109403141 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 1109403141
		arg_582_1.duration_ = 0.2

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"

			SetActive(arg_582_1.choicesGo_, true)

			for iter_583_0, iter_583_1 in ipairs(arg_582_1.choices_) do
				local var_583_0 = iter_583_0 <= 1

				SetActive(iter_583_1.go, var_583_0)
			end

			arg_582_1.choices_[1].txt.text = arg_582_1:FormatText(StoryChoiceCfg[411].name)
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play1109403142(arg_582_1)
			end

			arg_582_1:RecordChoiceLog(1109403141, 411)
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = arg_582_1.actors_["1048ui_story"]
			local var_585_1 = 0

			if var_585_1 < arg_582_1.time_ and arg_582_1.time_ <= var_585_1 + arg_585_0 and not isNil(var_585_0) and arg_582_1.var_.characterEffect1048ui_story == nil then
				arg_582_1.var_.characterEffect1048ui_story = var_585_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_585_2 = 0.200000002980232

			if var_585_1 <= arg_582_1.time_ and arg_582_1.time_ < var_585_1 + var_585_2 and not isNil(var_585_0) then
				local var_585_3 = (arg_582_1.time_ - var_585_1) / var_585_2

				if arg_582_1.var_.characterEffect1048ui_story and not isNil(var_585_0) then
					local var_585_4 = Mathf.Lerp(0, 0.5, var_585_3)

					arg_582_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_582_1.var_.characterEffect1048ui_story.fillRatio = var_585_4
				end
			end

			if arg_582_1.time_ >= var_585_1 + var_585_2 and arg_582_1.time_ < var_585_1 + var_585_2 + arg_585_0 and not isNil(var_585_0) and arg_582_1.var_.characterEffect1048ui_story then
				local var_585_5 = 0.5

				arg_582_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_582_1.var_.characterEffect1048ui_story.fillRatio = var_585_5
			end

			local var_585_6 = 0

			if var_585_6 < arg_582_1.time_ and arg_582_1.time_ <= var_585_6 + arg_585_0 then
				arg_582_1.allBtn_.enabled = false
			end

			local var_585_7 = 0.200000002980232

			if arg_582_1.time_ >= var_585_6 + var_585_7 and arg_582_1.time_ < var_585_6 + var_585_7 + arg_585_0 then
				arg_582_1.allBtn_.enabled = true
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play1109403142 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 1109403142
		arg_586_1.duration_ = 9.4

		local var_586_0 = {
			ja = 9.4,
			ko = 8.1,
			zh = 8.1
		}
		local var_586_1 = manager.audio:GetLocalizationFlag()

		if var_586_0[var_586_1] ~= nil then
			arg_586_1.duration_ = var_586_0[var_586_1]
		end

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play1109403143(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = arg_586_1.actors_["1048ui_story"].transform
			local var_589_1 = 0

			if var_589_1 < arg_586_1.time_ and arg_586_1.time_ <= var_589_1 + arg_589_0 then
				arg_586_1.var_.moveOldPos1048ui_story = var_589_0.localPosition
			end

			local var_589_2 = 0.001

			if var_589_1 <= arg_586_1.time_ and arg_586_1.time_ < var_589_1 + var_589_2 then
				local var_589_3 = (arg_586_1.time_ - var_589_1) / var_589_2
				local var_589_4 = Vector3.New(0, -0.8, -6.2)

				var_589_0.localPosition = Vector3.Lerp(arg_586_1.var_.moveOldPos1048ui_story, var_589_4, var_589_3)

				local var_589_5 = manager.ui.mainCamera.transform.position - var_589_0.position

				var_589_0.forward = Vector3.New(var_589_5.x, var_589_5.y, var_589_5.z)

				local var_589_6 = var_589_0.localEulerAngles

				var_589_6.z = 0
				var_589_6.x = 0
				var_589_0.localEulerAngles = var_589_6
			end

			if arg_586_1.time_ >= var_589_1 + var_589_2 and arg_586_1.time_ < var_589_1 + var_589_2 + arg_589_0 then
				var_589_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_589_7 = manager.ui.mainCamera.transform.position - var_589_0.position

				var_589_0.forward = Vector3.New(var_589_7.x, var_589_7.y, var_589_7.z)

				local var_589_8 = var_589_0.localEulerAngles

				var_589_8.z = 0
				var_589_8.x = 0
				var_589_0.localEulerAngles = var_589_8
			end

			local var_589_9 = arg_586_1.actors_["1048ui_story"]
			local var_589_10 = 0

			if var_589_10 < arg_586_1.time_ and arg_586_1.time_ <= var_589_10 + arg_589_0 and not isNil(var_589_9) and arg_586_1.var_.characterEffect1048ui_story == nil then
				arg_586_1.var_.characterEffect1048ui_story = var_589_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_11 = 0.200000002980232

			if var_589_10 <= arg_586_1.time_ and arg_586_1.time_ < var_589_10 + var_589_11 and not isNil(var_589_9) then
				local var_589_12 = (arg_586_1.time_ - var_589_10) / var_589_11

				if arg_586_1.var_.characterEffect1048ui_story and not isNil(var_589_9) then
					arg_586_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_586_1.time_ >= var_589_10 + var_589_11 and arg_586_1.time_ < var_589_10 + var_589_11 + arg_589_0 and not isNil(var_589_9) and arg_586_1.var_.characterEffect1048ui_story then
				arg_586_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_589_13 = 0

			if var_589_13 < arg_586_1.time_ and arg_586_1.time_ <= var_589_13 + arg_589_0 then
				arg_586_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action467")
			end

			local var_589_14 = 0

			if var_589_14 < arg_586_1.time_ and arg_586_1.time_ <= var_589_14 + arg_589_0 then
				arg_586_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_589_15 = 0
			local var_589_16 = 0.8

			if var_589_15 < arg_586_1.time_ and arg_586_1.time_ <= var_589_15 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				local var_589_17 = arg_586_1:FormatText(StoryNameCfg[8].name)

				arg_586_1.leftNameTxt_.text = var_589_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_18 = arg_586_1:GetWordFromCfg(1109403142)
				local var_589_19 = arg_586_1:FormatText(var_589_18.content)

				arg_586_1.text_.text = var_589_19

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_20 = 32
				local var_589_21 = utf8.len(var_589_19)
				local var_589_22 = var_589_20 <= 0 and var_589_16 or var_589_16 * (var_589_21 / var_589_20)

				if var_589_22 > 0 and var_589_16 < var_589_22 then
					arg_586_1.talkMaxDuration = var_589_22

					if var_589_22 + var_589_15 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_22 + var_589_15
					end
				end

				arg_586_1.text_.text = var_589_19
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403142", "story_v_side_new_1109403.awb") ~= 0 then
					local var_589_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403142", "story_v_side_new_1109403.awb") / 1000

					if var_589_23 + var_589_15 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_23 + var_589_15
					end

					if var_589_18.prefab_name ~= "" and arg_586_1.actors_[var_589_18.prefab_name] ~= nil then
						local var_589_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_586_1.actors_[var_589_18.prefab_name].transform, "story_v_side_new_1109403", "1109403142", "story_v_side_new_1109403.awb")

						arg_586_1:RecordAudio("1109403142", var_589_24)
						arg_586_1:RecordAudio("1109403142", var_589_24)
					else
						arg_586_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403142", "story_v_side_new_1109403.awb")
					end

					arg_586_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403142", "story_v_side_new_1109403.awb")
				end

				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_25 = math.max(var_589_16, arg_586_1.talkMaxDuration)

			if var_589_15 <= arg_586_1.time_ and arg_586_1.time_ < var_589_15 + var_589_25 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_15) / var_589_25

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_15 + var_589_25 and arg_586_1.time_ < var_589_15 + var_589_25 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_586_1:InitPlayNodeList()
	end,
	Play1109403143 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 1109403143
		arg_590_1.duration_ = 5

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play1109403144(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			local var_593_0 = arg_590_1.actors_["1048ui_story"]
			local var_593_1 = 0

			if var_593_1 < arg_590_1.time_ and arg_590_1.time_ <= var_593_1 + arg_593_0 and not isNil(var_593_0) and arg_590_1.var_.characterEffect1048ui_story == nil then
				arg_590_1.var_.characterEffect1048ui_story = var_593_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_593_2 = 0.200000002980232

			if var_593_1 <= arg_590_1.time_ and arg_590_1.time_ < var_593_1 + var_593_2 and not isNil(var_593_0) then
				local var_593_3 = (arg_590_1.time_ - var_593_1) / var_593_2

				if arg_590_1.var_.characterEffect1048ui_story and not isNil(var_593_0) then
					local var_593_4 = Mathf.Lerp(0, 0.5, var_593_3)

					arg_590_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_590_1.var_.characterEffect1048ui_story.fillRatio = var_593_4
				end
			end

			if arg_590_1.time_ >= var_593_1 + var_593_2 and arg_590_1.time_ < var_593_1 + var_593_2 + arg_593_0 and not isNil(var_593_0) and arg_590_1.var_.characterEffect1048ui_story then
				local var_593_5 = 0.5

				arg_590_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_590_1.var_.characterEffect1048ui_story.fillRatio = var_593_5
			end

			local var_593_6 = 0
			local var_593_7 = 0.05

			if var_593_6 < arg_590_1.time_ and arg_590_1.time_ <= var_593_6 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				local var_593_8 = arg_590_1:FormatText(StoryNameCfg[7].name)

				arg_590_1.leftNameTxt_.text = var_593_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, true)
				arg_590_1.iconController_:SetSelectedState("hero")

				arg_590_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_590_1.callingController_:SetSelectedState("normal")

				arg_590_1.keyicon_.color = Color.New(1, 1, 1)
				arg_590_1.icon_.color = Color.New(1, 1, 1)

				local var_593_9 = arg_590_1:GetWordFromCfg(1109403143)
				local var_593_10 = arg_590_1:FormatText(var_593_9.content)

				arg_590_1.text_.text = var_593_10

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_11 = 2
				local var_593_12 = utf8.len(var_593_10)
				local var_593_13 = var_593_11 <= 0 and var_593_7 or var_593_7 * (var_593_12 / var_593_11)

				if var_593_13 > 0 and var_593_7 < var_593_13 then
					arg_590_1.talkMaxDuration = var_593_13

					if var_593_13 + var_593_6 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_13 + var_593_6
					end
				end

				arg_590_1.text_.text = var_593_10
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)
				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_14 = math.max(var_593_7, arg_590_1.talkMaxDuration)

			if var_593_6 <= arg_590_1.time_ and arg_590_1.time_ < var_593_6 + var_593_14 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_6) / var_593_14

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_6 + var_593_14 and arg_590_1.time_ < var_593_6 + var_593_14 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {}

		arg_590_1:InitPlayNodeList()
	end,
	Play1109403144 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 1109403144
		arg_594_1.duration_ = 9.2

		local var_594_0 = {
			ja = 9.2,
			ko = 6.4,
			zh = 6.4
		}
		local var_594_1 = manager.audio:GetLocalizationFlag()

		if var_594_0[var_594_1] ~= nil then
			arg_594_1.duration_ = var_594_0[var_594_1]
		end

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play1109403145(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			local var_597_0 = arg_594_1.actors_["1048ui_story"].transform
			local var_597_1 = 0

			if var_597_1 < arg_594_1.time_ and arg_594_1.time_ <= var_597_1 + arg_597_0 then
				arg_594_1.var_.moveOldPos1048ui_story = var_597_0.localPosition
			end

			local var_597_2 = 0.001

			if var_597_1 <= arg_594_1.time_ and arg_594_1.time_ < var_597_1 + var_597_2 then
				local var_597_3 = (arg_594_1.time_ - var_597_1) / var_597_2
				local var_597_4 = Vector3.New(0, -0.8, -6.2)

				var_597_0.localPosition = Vector3.Lerp(arg_594_1.var_.moveOldPos1048ui_story, var_597_4, var_597_3)

				local var_597_5 = manager.ui.mainCamera.transform.position - var_597_0.position

				var_597_0.forward = Vector3.New(var_597_5.x, var_597_5.y, var_597_5.z)

				local var_597_6 = var_597_0.localEulerAngles

				var_597_6.z = 0
				var_597_6.x = 0
				var_597_0.localEulerAngles = var_597_6
			end

			if arg_594_1.time_ >= var_597_1 + var_597_2 and arg_594_1.time_ < var_597_1 + var_597_2 + arg_597_0 then
				var_597_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_597_7 = manager.ui.mainCamera.transform.position - var_597_0.position

				var_597_0.forward = Vector3.New(var_597_7.x, var_597_7.y, var_597_7.z)

				local var_597_8 = var_597_0.localEulerAngles

				var_597_8.z = 0
				var_597_8.x = 0
				var_597_0.localEulerAngles = var_597_8
			end

			local var_597_9 = arg_594_1.actors_["1048ui_story"]
			local var_597_10 = 0

			if var_597_10 < arg_594_1.time_ and arg_594_1.time_ <= var_597_10 + arg_597_0 and not isNil(var_597_9) and arg_594_1.var_.characterEffect1048ui_story == nil then
				arg_594_1.var_.characterEffect1048ui_story = var_597_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_597_11 = 0.200000002980232

			if var_597_10 <= arg_594_1.time_ and arg_594_1.time_ < var_597_10 + var_597_11 and not isNil(var_597_9) then
				local var_597_12 = (arg_594_1.time_ - var_597_10) / var_597_11

				if arg_594_1.var_.characterEffect1048ui_story and not isNil(var_597_9) then
					arg_594_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_594_1.time_ >= var_597_10 + var_597_11 and arg_594_1.time_ < var_597_10 + var_597_11 + arg_597_0 and not isNil(var_597_9) and arg_594_1.var_.characterEffect1048ui_story then
				arg_594_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_597_13 = 0

			if var_597_13 < arg_594_1.time_ and arg_594_1.time_ <= var_597_13 + arg_597_0 then
				arg_594_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_597_14 = 0

			if var_597_14 < arg_594_1.time_ and arg_594_1.time_ <= var_597_14 + arg_597_0 then
				arg_594_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_597_15 = 0
			local var_597_16 = 0.7

			if var_597_15 < arg_594_1.time_ and arg_594_1.time_ <= var_597_15 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				local var_597_17 = arg_594_1:FormatText(StoryNameCfg[8].name)

				arg_594_1.leftNameTxt_.text = var_597_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_18 = arg_594_1:GetWordFromCfg(1109403144)
				local var_597_19 = arg_594_1:FormatText(var_597_18.content)

				arg_594_1.text_.text = var_597_19

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_20 = 28
				local var_597_21 = utf8.len(var_597_19)
				local var_597_22 = var_597_20 <= 0 and var_597_16 or var_597_16 * (var_597_21 / var_597_20)

				if var_597_22 > 0 and var_597_16 < var_597_22 then
					arg_594_1.talkMaxDuration = var_597_22

					if var_597_22 + var_597_15 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_22 + var_597_15
					end
				end

				arg_594_1.text_.text = var_597_19
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403144", "story_v_side_new_1109403.awb") ~= 0 then
					local var_597_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403144", "story_v_side_new_1109403.awb") / 1000

					if var_597_23 + var_597_15 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_23 + var_597_15
					end

					if var_597_18.prefab_name ~= "" and arg_594_1.actors_[var_597_18.prefab_name] ~= nil then
						local var_597_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_594_1.actors_[var_597_18.prefab_name].transform, "story_v_side_new_1109403", "1109403144", "story_v_side_new_1109403.awb")

						arg_594_1:RecordAudio("1109403144", var_597_24)
						arg_594_1:RecordAudio("1109403144", var_597_24)
					else
						arg_594_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403144", "story_v_side_new_1109403.awb")
					end

					arg_594_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403144", "story_v_side_new_1109403.awb")
				end

				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_25 = math.max(var_597_16, arg_594_1.talkMaxDuration)

			if var_597_15 <= arg_594_1.time_ and arg_594_1.time_ < var_597_15 + var_597_25 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_15) / var_597_25

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_15 + var_597_25 and arg_594_1.time_ < var_597_15 + var_597_25 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_594_1:InitPlayNodeList()
	end,
	Play1109403145 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 1109403145
		arg_598_1.duration_ = 5

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play1109403146(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			local var_601_0 = arg_598_1.actors_["1048ui_story"]
			local var_601_1 = 0

			if var_601_1 < arg_598_1.time_ and arg_598_1.time_ <= var_601_1 + arg_601_0 and not isNil(var_601_0) and arg_598_1.var_.characterEffect1048ui_story == nil then
				arg_598_1.var_.characterEffect1048ui_story = var_601_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_2 = 0.200000002980232

			if var_601_1 <= arg_598_1.time_ and arg_598_1.time_ < var_601_1 + var_601_2 and not isNil(var_601_0) then
				local var_601_3 = (arg_598_1.time_ - var_601_1) / var_601_2

				if arg_598_1.var_.characterEffect1048ui_story and not isNil(var_601_0) then
					local var_601_4 = Mathf.Lerp(0, 0.5, var_601_3)

					arg_598_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_598_1.var_.characterEffect1048ui_story.fillRatio = var_601_4
				end
			end

			if arg_598_1.time_ >= var_601_1 + var_601_2 and arg_598_1.time_ < var_601_1 + var_601_2 + arg_601_0 and not isNil(var_601_0) and arg_598_1.var_.characterEffect1048ui_story then
				local var_601_5 = 0.5

				arg_598_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_598_1.var_.characterEffect1048ui_story.fillRatio = var_601_5
			end

			local var_601_6 = 0
			local var_601_7 = 1.05

			if var_601_6 < arg_598_1.time_ and arg_598_1.time_ <= var_601_6 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				local var_601_8 = arg_598_1:FormatText(StoryNameCfg[7].name)

				arg_598_1.leftNameTxt_.text = var_601_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, true)
				arg_598_1.iconController_:SetSelectedState("hero")

				arg_598_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_598_1.callingController_:SetSelectedState("normal")

				arg_598_1.keyicon_.color = Color.New(1, 1, 1)
				arg_598_1.icon_.color = Color.New(1, 1, 1)

				local var_601_9 = arg_598_1:GetWordFromCfg(1109403145)
				local var_601_10 = arg_598_1:FormatText(var_601_9.content)

				arg_598_1.text_.text = var_601_10

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_11 = 42
				local var_601_12 = utf8.len(var_601_10)
				local var_601_13 = var_601_11 <= 0 and var_601_7 or var_601_7 * (var_601_12 / var_601_11)

				if var_601_13 > 0 and var_601_7 < var_601_13 then
					arg_598_1.talkMaxDuration = var_601_13

					if var_601_13 + var_601_6 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_13 + var_601_6
					end
				end

				arg_598_1.text_.text = var_601_10
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)
				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_14 = math.max(var_601_7, arg_598_1.talkMaxDuration)

			if var_601_6 <= arg_598_1.time_ and arg_598_1.time_ < var_601_6 + var_601_14 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_6) / var_601_14

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_6 + var_601_14 and arg_598_1.time_ < var_601_6 + var_601_14 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {}

		arg_598_1:InitPlayNodeList()
	end,
	Play1109403146 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 1109403146
		arg_602_1.duration_ = 2

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play1109403147(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			local var_605_0 = arg_602_1.actors_["1048ui_story"].transform
			local var_605_1 = 0

			if var_605_1 < arg_602_1.time_ and arg_602_1.time_ <= var_605_1 + arg_605_0 then
				arg_602_1.var_.moveOldPos1048ui_story = var_605_0.localPosition
			end

			local var_605_2 = 0.001

			if var_605_1 <= arg_602_1.time_ and arg_602_1.time_ < var_605_1 + var_605_2 then
				local var_605_3 = (arg_602_1.time_ - var_605_1) / var_605_2
				local var_605_4 = Vector3.New(0, -0.8, -6.2)

				var_605_0.localPosition = Vector3.Lerp(arg_602_1.var_.moveOldPos1048ui_story, var_605_4, var_605_3)

				local var_605_5 = manager.ui.mainCamera.transform.position - var_605_0.position

				var_605_0.forward = Vector3.New(var_605_5.x, var_605_5.y, var_605_5.z)

				local var_605_6 = var_605_0.localEulerAngles

				var_605_6.z = 0
				var_605_6.x = 0
				var_605_0.localEulerAngles = var_605_6
			end

			if arg_602_1.time_ >= var_605_1 + var_605_2 and arg_602_1.time_ < var_605_1 + var_605_2 + arg_605_0 then
				var_605_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_605_7 = manager.ui.mainCamera.transform.position - var_605_0.position

				var_605_0.forward = Vector3.New(var_605_7.x, var_605_7.y, var_605_7.z)

				local var_605_8 = var_605_0.localEulerAngles

				var_605_8.z = 0
				var_605_8.x = 0
				var_605_0.localEulerAngles = var_605_8
			end

			local var_605_9 = arg_602_1.actors_["1048ui_story"]
			local var_605_10 = 0

			if var_605_10 < arg_602_1.time_ and arg_602_1.time_ <= var_605_10 + arg_605_0 and not isNil(var_605_9) and arg_602_1.var_.characterEffect1048ui_story == nil then
				arg_602_1.var_.characterEffect1048ui_story = var_605_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_605_11 = 0.200000002980232

			if var_605_10 <= arg_602_1.time_ and arg_602_1.time_ < var_605_10 + var_605_11 and not isNil(var_605_9) then
				local var_605_12 = (arg_602_1.time_ - var_605_10) / var_605_11

				if arg_602_1.var_.characterEffect1048ui_story and not isNil(var_605_9) then
					arg_602_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_602_1.time_ >= var_605_10 + var_605_11 and arg_602_1.time_ < var_605_10 + var_605_11 + arg_605_0 and not isNil(var_605_9) and arg_602_1.var_.characterEffect1048ui_story then
				arg_602_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_605_13 = 0

			if var_605_13 < arg_602_1.time_ and arg_602_1.time_ <= var_605_13 + arg_605_0 then
				arg_602_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_605_14 = 0

			if var_605_14 < arg_602_1.time_ and arg_602_1.time_ <= var_605_14 + arg_605_0 then
				arg_602_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_605_15 = 0
			local var_605_16 = 0.125

			if var_605_15 < arg_602_1.time_ and arg_602_1.time_ <= var_605_15 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, true)

				local var_605_17 = arg_602_1:FormatText(StoryNameCfg[8].name)

				arg_602_1.leftNameTxt_.text = var_605_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_602_1.leftNameTxt_.transform)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1.leftNameTxt_.text)
				SetActive(arg_602_1.iconTrs_.gameObject, false)
				arg_602_1.callingController_:SetSelectedState("normal")

				local var_605_18 = arg_602_1:GetWordFromCfg(1109403146)
				local var_605_19 = arg_602_1:FormatText(var_605_18.content)

				arg_602_1.text_.text = var_605_19

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_20 = 5
				local var_605_21 = utf8.len(var_605_19)
				local var_605_22 = var_605_20 <= 0 and var_605_16 or var_605_16 * (var_605_21 / var_605_20)

				if var_605_22 > 0 and var_605_16 < var_605_22 then
					arg_602_1.talkMaxDuration = var_605_22

					if var_605_22 + var_605_15 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_22 + var_605_15
					end
				end

				arg_602_1.text_.text = var_605_19
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403146", "story_v_side_new_1109403.awb") ~= 0 then
					local var_605_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403146", "story_v_side_new_1109403.awb") / 1000

					if var_605_23 + var_605_15 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_23 + var_605_15
					end

					if var_605_18.prefab_name ~= "" and arg_602_1.actors_[var_605_18.prefab_name] ~= nil then
						local var_605_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_602_1.actors_[var_605_18.prefab_name].transform, "story_v_side_new_1109403", "1109403146", "story_v_side_new_1109403.awb")

						arg_602_1:RecordAudio("1109403146", var_605_24)
						arg_602_1:RecordAudio("1109403146", var_605_24)
					else
						arg_602_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403146", "story_v_side_new_1109403.awb")
					end

					arg_602_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403146", "story_v_side_new_1109403.awb")
				end

				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_25 = math.max(var_605_16, arg_602_1.talkMaxDuration)

			if var_605_15 <= arg_602_1.time_ and arg_602_1.time_ < var_605_15 + var_605_25 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - var_605_15) / var_605_25

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= var_605_15 + var_605_25 and arg_602_1.time_ < var_605_15 + var_605_25 + arg_605_0 then
				arg_602_1.typewritter.percent = 1

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(true)
			end
		end

		arg_602_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_602_1:InitPlayNodeList()
	end,
	Play1109403147 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 1109403147
		arg_606_1.duration_ = 7

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play1109403148(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			local var_609_0 = 0

			if var_609_0 < arg_606_1.time_ and arg_606_1.time_ <= var_609_0 + arg_609_0 then
				local var_609_1 = manager.ui.mainCamera.transform.localPosition
				local var_609_2 = Vector3.New(0, 0, 10) + Vector3.New(var_609_1.x, var_609_1.y, 0)
				local var_609_3 = arg_606_1.bgs_.STblack

				var_609_3.transform.localPosition = var_609_2
				var_609_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_609_4 = var_609_3:GetComponent("SpriteRenderer")

				if var_609_4 and var_609_4.sprite then
					local var_609_5 = (var_609_3.transform.localPosition - var_609_1).z
					local var_609_6 = manager.ui.mainCameraCom_
					local var_609_7 = 2 * var_609_5 * Mathf.Tan(var_609_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_609_8 = var_609_7 * var_609_6.aspect
					local var_609_9 = var_609_4.sprite.bounds.size.x
					local var_609_10 = var_609_4.sprite.bounds.size.y
					local var_609_11 = var_609_8 / var_609_9
					local var_609_12 = var_609_7 / var_609_10
					local var_609_13 = var_609_12 < var_609_11 and var_609_11 or var_609_12

					var_609_3.transform.localScale = Vector3.New(var_609_13, var_609_13, 0)
				end

				for iter_609_0, iter_609_1 in pairs(arg_606_1.bgs_) do
					if iter_609_0 ~= "STblack" then
						iter_609_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_609_14 = 0

			if var_609_14 < arg_606_1.time_ and arg_606_1.time_ <= var_609_14 + arg_609_0 then
				arg_606_1.mask_.enabled = true
				arg_606_1.mask_.raycastTarget = true

				arg_606_1:SetGaussion(false)
			end

			local var_609_15 = 2

			if var_609_14 <= arg_606_1.time_ and arg_606_1.time_ < var_609_14 + var_609_15 then
				local var_609_16 = (arg_606_1.time_ - var_609_14) / var_609_15
				local var_609_17 = Color.New(0, 0, 0)

				var_609_17.a = Mathf.Lerp(1, 0, var_609_16)
				arg_606_1.mask_.color = var_609_17
			end

			if arg_606_1.time_ >= var_609_14 + var_609_15 and arg_606_1.time_ < var_609_14 + var_609_15 + arg_609_0 then
				local var_609_18 = Color.New(0, 0, 0)
				local var_609_19 = 0

				arg_606_1.mask_.enabled = false
				var_609_18.a = var_609_19
				arg_606_1.mask_.color = var_609_18
			end

			local var_609_20 = arg_606_1.actors_["1048ui_story"].transform
			local var_609_21 = 0

			if var_609_21 < arg_606_1.time_ and arg_606_1.time_ <= var_609_21 + arg_609_0 then
				arg_606_1.var_.moveOldPos1048ui_story = var_609_20.localPosition
			end

			local var_609_22 = 0.001

			if var_609_21 <= arg_606_1.time_ and arg_606_1.time_ < var_609_21 + var_609_22 then
				local var_609_23 = (arg_606_1.time_ - var_609_21) / var_609_22
				local var_609_24 = Vector3.New(0, 100, 0)

				var_609_20.localPosition = Vector3.Lerp(arg_606_1.var_.moveOldPos1048ui_story, var_609_24, var_609_23)

				local var_609_25 = manager.ui.mainCamera.transform.position - var_609_20.position

				var_609_20.forward = Vector3.New(var_609_25.x, var_609_25.y, var_609_25.z)

				local var_609_26 = var_609_20.localEulerAngles

				var_609_26.z = 0
				var_609_26.x = 0
				var_609_20.localEulerAngles = var_609_26
			end

			if arg_606_1.time_ >= var_609_21 + var_609_22 and arg_606_1.time_ < var_609_21 + var_609_22 + arg_609_0 then
				var_609_20.localPosition = Vector3.New(0, 100, 0)

				local var_609_27 = manager.ui.mainCamera.transform.position - var_609_20.position

				var_609_20.forward = Vector3.New(var_609_27.x, var_609_27.y, var_609_27.z)

				local var_609_28 = var_609_20.localEulerAngles

				var_609_28.z = 0
				var_609_28.x = 0
				var_609_20.localEulerAngles = var_609_28
			end

			local var_609_29 = arg_606_1.actors_["1048ui_story"]
			local var_609_30 = 0

			if var_609_30 < arg_606_1.time_ and arg_606_1.time_ <= var_609_30 + arg_609_0 and not isNil(var_609_29) and arg_606_1.var_.characterEffect1048ui_story == nil then
				arg_606_1.var_.characterEffect1048ui_story = var_609_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_609_31 = 0.200000002980232

			if var_609_30 <= arg_606_1.time_ and arg_606_1.time_ < var_609_30 + var_609_31 and not isNil(var_609_29) then
				local var_609_32 = (arg_606_1.time_ - var_609_30) / var_609_31

				if arg_606_1.var_.characterEffect1048ui_story and not isNil(var_609_29) then
					local var_609_33 = Mathf.Lerp(0, 0.5, var_609_32)

					arg_606_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_606_1.var_.characterEffect1048ui_story.fillRatio = var_609_33
				end
			end

			if arg_606_1.time_ >= var_609_30 + var_609_31 and arg_606_1.time_ < var_609_30 + var_609_31 + arg_609_0 and not isNil(var_609_29) and arg_606_1.var_.characterEffect1048ui_story then
				local var_609_34 = 0.5

				arg_606_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_606_1.var_.characterEffect1048ui_story.fillRatio = var_609_34
			end

			if arg_606_1.frameCnt_ <= 1 then
				arg_606_1.dialog_:SetActive(false)
			end

			local var_609_35 = 2
			local var_609_36 = 0.125

			if var_609_35 < arg_606_1.time_ and arg_606_1.time_ <= var_609_35 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0

				arg_606_1.dialog_:SetActive(true)

				arg_606_1.dialogCg_.alpha = 0

				local var_609_37 = LeanTween.value(arg_606_1.dialog_, 0, 1, 0.3)

				var_609_37:setOnUpdate(LuaHelper.FloatAction(function(arg_610_0)
					arg_606_1.dialogCg_.alpha = arg_610_0
				end))
				var_609_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_606_1.dialog_)
					var_609_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_606_1.duration_ = arg_606_1.duration_ + 0.3

				SetActive(arg_606_1.leftNameGo_, false)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_606_1.iconTrs_.gameObject, false)
				arg_606_1.callingController_:SetSelectedState("normal")

				local var_609_38 = arg_606_1:GetWordFromCfg(1109403147)
				local var_609_39 = arg_606_1:FormatText(var_609_38.content)

				arg_606_1.text_.text = var_609_39

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_40 = 5
				local var_609_41 = utf8.len(var_609_39)
				local var_609_42 = var_609_40 <= 0 and var_609_36 or var_609_36 * (var_609_41 / var_609_40)

				if var_609_42 > 0 and var_609_36 < var_609_42 then
					arg_606_1.talkMaxDuration = var_609_42
					var_609_35 = var_609_35 + 0.3

					if var_609_42 + var_609_35 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_42 + var_609_35
					end
				end

				arg_606_1.text_.text = var_609_39
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)
				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_43 = var_609_35 + 0.3
			local var_609_44 = math.max(var_609_36, arg_606_1.talkMaxDuration)

			if var_609_43 <= arg_606_1.time_ and arg_606_1.time_ < var_609_43 + var_609_44 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - var_609_43) / var_609_44

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= var_609_43 + var_609_44 and arg_606_1.time_ < var_609_43 + var_609_44 + arg_609_0 then
				arg_606_1.typewritter.percent = 1

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(true)
			end
		end

		arg_606_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_606_1:InitPlayNodeList()
	end,
	Play1109403148 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 1109403148
		arg_612_1.duration_ = 10.6

		local var_612_0 = {
			ja = 10.2,
			ko = 10.6,
			zh = 10.6
		}
		local var_612_1 = manager.audio:GetLocalizationFlag()

		if var_612_0[var_612_1] ~= nil then
			arg_612_1.duration_ = var_612_0[var_612_1]
		end

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play1109403149(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = "ST10"

			if arg_612_1.bgs_[var_615_0] == nil then
				local var_615_1 = Object.Instantiate(arg_612_1.paintGo_)

				var_615_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_615_0)
				var_615_1.name = var_615_0
				var_615_1.transform.parent = arg_612_1.stage_.transform
				var_615_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_612_1.bgs_[var_615_0] = var_615_1
			end

			local var_615_2 = 0

			if var_615_2 < arg_612_1.time_ and arg_612_1.time_ <= var_615_2 + arg_615_0 then
				local var_615_3 = manager.ui.mainCamera.transform.localPosition
				local var_615_4 = Vector3.New(0, 0, 10) + Vector3.New(var_615_3.x, var_615_3.y, 0)
				local var_615_5 = arg_612_1.bgs_.ST10

				var_615_5.transform.localPosition = var_615_4
				var_615_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_615_6 = var_615_5:GetComponent("SpriteRenderer")

				if var_615_6 and var_615_6.sprite then
					local var_615_7 = (var_615_5.transform.localPosition - var_615_3).z
					local var_615_8 = manager.ui.mainCameraCom_
					local var_615_9 = 2 * var_615_7 * Mathf.Tan(var_615_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_615_10 = var_615_9 * var_615_8.aspect
					local var_615_11 = var_615_6.sprite.bounds.size.x
					local var_615_12 = var_615_6.sprite.bounds.size.y
					local var_615_13 = var_615_10 / var_615_11
					local var_615_14 = var_615_9 / var_615_12
					local var_615_15 = var_615_14 < var_615_13 and var_615_13 or var_615_14

					var_615_5.transform.localScale = Vector3.New(var_615_15, var_615_15, 0)
				end

				for iter_615_0, iter_615_1 in pairs(arg_612_1.bgs_) do
					if iter_615_0 ~= "ST10" then
						iter_615_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_615_16 = 0

			if var_615_16 < arg_612_1.time_ and arg_612_1.time_ <= var_615_16 + arg_615_0 then
				arg_612_1.mask_.enabled = true
				arg_612_1.mask_.raycastTarget = true

				arg_612_1:SetGaussion(false)
			end

			local var_615_17 = 2

			if var_615_16 <= arg_612_1.time_ and arg_612_1.time_ < var_615_16 + var_615_17 then
				local var_615_18 = (arg_612_1.time_ - var_615_16) / var_615_17
				local var_615_19 = Color.New(0, 0, 0)

				var_615_19.a = Mathf.Lerp(1, 0, var_615_18)
				arg_612_1.mask_.color = var_615_19
			end

			if arg_612_1.time_ >= var_615_16 + var_615_17 and arg_612_1.time_ < var_615_16 + var_615_17 + arg_615_0 then
				local var_615_20 = Color.New(0, 0, 0)
				local var_615_21 = 0

				arg_612_1.mask_.enabled = false
				var_615_20.a = var_615_21
				arg_612_1.mask_.color = var_615_20
			end

			local var_615_22 = "1066ui_story"

			if arg_612_1.actors_[var_615_22] == nil then
				local var_615_23 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_615_23) then
					local var_615_24 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_612_1.stage_.transform)

					var_615_24.name = var_615_22
					var_615_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_612_1.actors_[var_615_22] = var_615_24

					local var_615_25 = var_615_24:GetComponentInChildren(typeof(CharacterEffect))

					var_615_25.enabled = true

					local var_615_26 = GameObjectTools.GetOrAddComponent(var_615_24, typeof(DynamicBoneHelper))

					if var_615_26 then
						var_615_26:EnableDynamicBone(false)
					end

					arg_612_1:ShowWeapon(var_615_25.transform, false)

					arg_612_1.var_[var_615_22 .. "Animator"] = var_615_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_612_1.var_[var_615_22 .. "Animator"].applyRootMotion = true
					arg_612_1.var_[var_615_22 .. "LipSync"] = var_615_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_615_27 = arg_612_1.actors_["1066ui_story"].transform
			local var_615_28 = 2

			if var_615_28 < arg_612_1.time_ and arg_612_1.time_ <= var_615_28 + arg_615_0 then
				arg_612_1.var_.moveOldPos1066ui_story = var_615_27.localPosition
			end

			local var_615_29 = 0.001

			if var_615_28 <= arg_612_1.time_ and arg_612_1.time_ < var_615_28 + var_615_29 then
				local var_615_30 = (arg_612_1.time_ - var_615_28) / var_615_29
				local var_615_31 = Vector3.New(0, -0.77, -6.1)

				var_615_27.localPosition = Vector3.Lerp(arg_612_1.var_.moveOldPos1066ui_story, var_615_31, var_615_30)

				local var_615_32 = manager.ui.mainCamera.transform.position - var_615_27.position

				var_615_27.forward = Vector3.New(var_615_32.x, var_615_32.y, var_615_32.z)

				local var_615_33 = var_615_27.localEulerAngles

				var_615_33.z = 0
				var_615_33.x = 0
				var_615_27.localEulerAngles = var_615_33
			end

			if arg_612_1.time_ >= var_615_28 + var_615_29 and arg_612_1.time_ < var_615_28 + var_615_29 + arg_615_0 then
				var_615_27.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_615_34 = manager.ui.mainCamera.transform.position - var_615_27.position

				var_615_27.forward = Vector3.New(var_615_34.x, var_615_34.y, var_615_34.z)

				local var_615_35 = var_615_27.localEulerAngles

				var_615_35.z = 0
				var_615_35.x = 0
				var_615_27.localEulerAngles = var_615_35
			end

			local var_615_36 = arg_612_1.actors_["1066ui_story"]
			local var_615_37 = 2

			if var_615_37 < arg_612_1.time_ and arg_612_1.time_ <= var_615_37 + arg_615_0 and not isNil(var_615_36) and arg_612_1.var_.characterEffect1066ui_story == nil then
				arg_612_1.var_.characterEffect1066ui_story = var_615_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_615_38 = 0.200000002980232

			if var_615_37 <= arg_612_1.time_ and arg_612_1.time_ < var_615_37 + var_615_38 and not isNil(var_615_36) then
				local var_615_39 = (arg_612_1.time_ - var_615_37) / var_615_38

				if arg_612_1.var_.characterEffect1066ui_story and not isNil(var_615_36) then
					arg_612_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_612_1.time_ >= var_615_37 + var_615_38 and arg_612_1.time_ < var_615_37 + var_615_38 + arg_615_0 and not isNil(var_615_36) and arg_612_1.var_.characterEffect1066ui_story then
				arg_612_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_615_40 = 2

			if var_615_40 < arg_612_1.time_ and arg_612_1.time_ <= var_615_40 + arg_615_0 then
				arg_612_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			local var_615_41 = 2

			if var_615_41 < arg_612_1.time_ and arg_612_1.time_ <= var_615_41 + arg_615_0 then
				arg_612_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_612_1.frameCnt_ <= 1 then
				arg_612_1.dialog_:SetActive(false)
			end

			local var_615_42 = 2
			local var_615_43 = 0.825

			if var_615_42 < arg_612_1.time_ and arg_612_1.time_ <= var_615_42 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0

				arg_612_1.dialog_:SetActive(true)

				arg_612_1.dialogCg_.alpha = 0

				local var_615_44 = LeanTween.value(arg_612_1.dialog_, 0, 1, 0.3)

				var_615_44:setOnUpdate(LuaHelper.FloatAction(function(arg_616_0)
					arg_612_1.dialogCg_.alpha = arg_616_0
				end))
				var_615_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_612_1.dialog_)
					var_615_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_612_1.duration_ = arg_612_1.duration_ + 0.3

				SetActive(arg_612_1.leftNameGo_, true)

				local var_615_45 = arg_612_1:FormatText(StoryNameCfg[32].name)

				arg_612_1.leftNameTxt_.text = var_615_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_46 = arg_612_1:GetWordFromCfg(1109403148)
				local var_615_47 = arg_612_1:FormatText(var_615_46.content)

				arg_612_1.text_.text = var_615_47

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_48 = 33
				local var_615_49 = utf8.len(var_615_47)
				local var_615_50 = var_615_48 <= 0 and var_615_43 or var_615_43 * (var_615_49 / var_615_48)

				if var_615_50 > 0 and var_615_43 < var_615_50 then
					arg_612_1.talkMaxDuration = var_615_50
					var_615_42 = var_615_42 + 0.3

					if var_615_50 + var_615_42 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_50 + var_615_42
					end
				end

				arg_612_1.text_.text = var_615_47
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403148", "story_v_side_new_1109403.awb") ~= 0 then
					local var_615_51 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403148", "story_v_side_new_1109403.awb") / 1000

					if var_615_51 + var_615_42 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_51 + var_615_42
					end

					if var_615_46.prefab_name ~= "" and arg_612_1.actors_[var_615_46.prefab_name] ~= nil then
						local var_615_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_612_1.actors_[var_615_46.prefab_name].transform, "story_v_side_new_1109403", "1109403148", "story_v_side_new_1109403.awb")

						arg_612_1:RecordAudio("1109403148", var_615_52)
						arg_612_1:RecordAudio("1109403148", var_615_52)
					else
						arg_612_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403148", "story_v_side_new_1109403.awb")
					end

					arg_612_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403148", "story_v_side_new_1109403.awb")
				end

				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_53 = var_615_42 + 0.3
			local var_615_54 = math.max(var_615_43, arg_612_1.talkMaxDuration)

			if var_615_53 <= arg_612_1.time_ and arg_612_1.time_ < var_615_53 + var_615_54 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_53) / var_615_54

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_53 + var_615_54 and arg_612_1.time_ < var_615_53 + var_615_54 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_612_1:InitPlayNodeList()
	end,
	Play1109403149 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 1109403149
		arg_618_1.duration_ = 5.53

		local var_618_0 = {
			ja = 5.266,
			ko = 5.533,
			zh = 5.533
		}
		local var_618_1 = manager.audio:GetLocalizationFlag()

		if var_618_0[var_618_1] ~= nil then
			arg_618_1.duration_ = var_618_0[var_618_1]
		end

		SetActive(arg_618_1.tipsGo_, false)

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				arg_618_0:Play1109403150(arg_618_1)
			end
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			local var_621_0 = arg_618_1.actors_["1066ui_story"].transform
			local var_621_1 = 0

			if var_621_1 < arg_618_1.time_ and arg_618_1.time_ <= var_621_1 + arg_621_0 then
				arg_618_1.var_.moveOldPos1066ui_story = var_621_0.localPosition
			end

			local var_621_2 = 0.001

			if var_621_1 <= arg_618_1.time_ and arg_618_1.time_ < var_621_1 + var_621_2 then
				local var_621_3 = (arg_618_1.time_ - var_621_1) / var_621_2
				local var_621_4 = Vector3.New(0, -0.77, -6.1)

				var_621_0.localPosition = Vector3.Lerp(arg_618_1.var_.moveOldPos1066ui_story, var_621_4, var_621_3)

				local var_621_5 = manager.ui.mainCamera.transform.position - var_621_0.position

				var_621_0.forward = Vector3.New(var_621_5.x, var_621_5.y, var_621_5.z)

				local var_621_6 = var_621_0.localEulerAngles

				var_621_6.z = 0
				var_621_6.x = 0
				var_621_0.localEulerAngles = var_621_6
			end

			if arg_618_1.time_ >= var_621_1 + var_621_2 and arg_618_1.time_ < var_621_1 + var_621_2 + arg_621_0 then
				var_621_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_621_7 = manager.ui.mainCamera.transform.position - var_621_0.position

				var_621_0.forward = Vector3.New(var_621_7.x, var_621_7.y, var_621_7.z)

				local var_621_8 = var_621_0.localEulerAngles

				var_621_8.z = 0
				var_621_8.x = 0
				var_621_0.localEulerAngles = var_621_8
			end

			local var_621_9 = 0

			if var_621_9 < arg_618_1.time_ and arg_618_1.time_ <= var_621_9 + arg_621_0 then
				arg_618_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_621_10 = 0
			local var_621_11 = 0.625

			if var_621_10 < arg_618_1.time_ and arg_618_1.time_ <= var_621_10 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0
				arg_618_1.dialogCg_.alpha = 1

				arg_618_1.dialog_:SetActive(true)
				SetActive(arg_618_1.leftNameGo_, true)

				local var_621_12 = arg_618_1:FormatText(StoryNameCfg[32].name)

				arg_618_1.leftNameTxt_.text = var_621_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_618_1.leftNameTxt_.transform)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1.leftNameTxt_.text)
				SetActive(arg_618_1.iconTrs_.gameObject, false)
				arg_618_1.callingController_:SetSelectedState("normal")

				local var_621_13 = arg_618_1:GetWordFromCfg(1109403149)
				local var_621_14 = arg_618_1:FormatText(var_621_13.content)

				arg_618_1.text_.text = var_621_14

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_15 = 25
				local var_621_16 = utf8.len(var_621_14)
				local var_621_17 = var_621_15 <= 0 and var_621_11 or var_621_11 * (var_621_16 / var_621_15)

				if var_621_17 > 0 and var_621_11 < var_621_17 then
					arg_618_1.talkMaxDuration = var_621_17

					if var_621_17 + var_621_10 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_17 + var_621_10
					end
				end

				arg_618_1.text_.text = var_621_14
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403149", "story_v_side_new_1109403.awb") ~= 0 then
					local var_621_18 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403149", "story_v_side_new_1109403.awb") / 1000

					if var_621_18 + var_621_10 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_18 + var_621_10
					end

					if var_621_13.prefab_name ~= "" and arg_618_1.actors_[var_621_13.prefab_name] ~= nil then
						local var_621_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_618_1.actors_[var_621_13.prefab_name].transform, "story_v_side_new_1109403", "1109403149", "story_v_side_new_1109403.awb")

						arg_618_1:RecordAudio("1109403149", var_621_19)
						arg_618_1:RecordAudio("1109403149", var_621_19)
					else
						arg_618_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403149", "story_v_side_new_1109403.awb")
					end

					arg_618_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403149", "story_v_side_new_1109403.awb")
				end

				arg_618_1:RecordContent(arg_618_1.text_.text)
			end

			local var_621_20 = math.max(var_621_11, arg_618_1.talkMaxDuration)

			if var_621_10 <= arg_618_1.time_ and arg_618_1.time_ < var_621_10 + var_621_20 then
				arg_618_1.typewritter.percent = (arg_618_1.time_ - var_621_10) / var_621_20

				arg_618_1.typewritter:SetDirty()
			end

			if arg_618_1.time_ >= var_621_10 + var_621_20 and arg_618_1.time_ < var_621_10 + var_621_20 + arg_621_0 then
				arg_618_1.typewritter.percent = 1

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(true)
			end
		end

		arg_618_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_618_1:InitPlayNodeList()
	end,
	Play1109403150 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 1109403150
		arg_622_1.duration_ = 10.17

		local var_622_0 = {
			ja = 10.166,
			ko = 7.566,
			zh = 7.566
		}
		local var_622_1 = manager.audio:GetLocalizationFlag()

		if var_622_0[var_622_1] ~= nil then
			arg_622_1.duration_ = var_622_0[var_622_1]
		end

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play1109403151(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			local var_625_0 = arg_622_1.actors_["1066ui_story"].transform
			local var_625_1 = 0

			if var_625_1 < arg_622_1.time_ and arg_622_1.time_ <= var_625_1 + arg_625_0 then
				arg_622_1.var_.moveOldPos1066ui_story = var_625_0.localPosition
			end

			local var_625_2 = 0.001

			if var_625_1 <= arg_622_1.time_ and arg_622_1.time_ < var_625_1 + var_625_2 then
				local var_625_3 = (arg_622_1.time_ - var_625_1) / var_625_2
				local var_625_4 = Vector3.New(0, -0.77, -6.1)

				var_625_0.localPosition = Vector3.Lerp(arg_622_1.var_.moveOldPos1066ui_story, var_625_4, var_625_3)

				local var_625_5 = manager.ui.mainCamera.transform.position - var_625_0.position

				var_625_0.forward = Vector3.New(var_625_5.x, var_625_5.y, var_625_5.z)

				local var_625_6 = var_625_0.localEulerAngles

				var_625_6.z = 0
				var_625_6.x = 0
				var_625_0.localEulerAngles = var_625_6
			end

			if arg_622_1.time_ >= var_625_1 + var_625_2 and arg_622_1.time_ < var_625_1 + var_625_2 + arg_625_0 then
				var_625_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_625_7 = manager.ui.mainCamera.transform.position - var_625_0.position

				var_625_0.forward = Vector3.New(var_625_7.x, var_625_7.y, var_625_7.z)

				local var_625_8 = var_625_0.localEulerAngles

				var_625_8.z = 0
				var_625_8.x = 0
				var_625_0.localEulerAngles = var_625_8
			end

			local var_625_9 = 0

			if var_625_9 < arg_622_1.time_ and arg_622_1.time_ <= var_625_9 + arg_625_0 then
				arg_622_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action423")
			end

			local var_625_10 = 0

			if var_625_10 < arg_622_1.time_ and arg_622_1.time_ <= var_625_10 + arg_625_0 then
				arg_622_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_625_11 = 0
			local var_625_12 = 0.675

			if var_625_11 < arg_622_1.time_ and arg_622_1.time_ <= var_625_11 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				local var_625_13 = arg_622_1:FormatText(StoryNameCfg[32].name)

				arg_622_1.leftNameTxt_.text = var_625_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, false)
				arg_622_1.callingController_:SetSelectedState("normal")

				local var_625_14 = arg_622_1:GetWordFromCfg(1109403150)
				local var_625_15 = arg_622_1:FormatText(var_625_14.content)

				arg_622_1.text_.text = var_625_15

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_16 = 27
				local var_625_17 = utf8.len(var_625_15)
				local var_625_18 = var_625_16 <= 0 and var_625_12 or var_625_12 * (var_625_17 / var_625_16)

				if var_625_18 > 0 and var_625_12 < var_625_18 then
					arg_622_1.talkMaxDuration = var_625_18

					if var_625_18 + var_625_11 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_18 + var_625_11
					end
				end

				arg_622_1.text_.text = var_625_15
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403150", "story_v_side_new_1109403.awb") ~= 0 then
					local var_625_19 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403150", "story_v_side_new_1109403.awb") / 1000

					if var_625_19 + var_625_11 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_19 + var_625_11
					end

					if var_625_14.prefab_name ~= "" and arg_622_1.actors_[var_625_14.prefab_name] ~= nil then
						local var_625_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_622_1.actors_[var_625_14.prefab_name].transform, "story_v_side_new_1109403", "1109403150", "story_v_side_new_1109403.awb")

						arg_622_1:RecordAudio("1109403150", var_625_20)
						arg_622_1:RecordAudio("1109403150", var_625_20)
					else
						arg_622_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403150", "story_v_side_new_1109403.awb")
					end

					arg_622_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403150", "story_v_side_new_1109403.awb")
				end

				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_21 = math.max(var_625_12, arg_622_1.talkMaxDuration)

			if var_625_11 <= arg_622_1.time_ and arg_622_1.time_ < var_625_11 + var_625_21 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - var_625_11) / var_625_21

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= var_625_11 + var_625_21 and arg_622_1.time_ < var_625_11 + var_625_21 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_622_1:InitPlayNodeList()
	end,
	Play1109403151 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 1109403151
		arg_626_1.duration_ = 14.3

		local var_626_0 = {
			ja = 14.3,
			ko = 11.7,
			zh = 11.7
		}
		local var_626_1 = manager.audio:GetLocalizationFlag()

		if var_626_0[var_626_1] ~= nil then
			arg_626_1.duration_ = var_626_0[var_626_1]
		end

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play1109403152(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			local var_629_0 = 2

			if var_629_0 < arg_626_1.time_ and arg_626_1.time_ <= var_629_0 + arg_629_0 then
				local var_629_1 = manager.ui.mainCamera.transform.localPosition
				local var_629_2 = Vector3.New(0, 0, 10) + Vector3.New(var_629_1.x, var_629_1.y, 0)
				local var_629_3 = arg_626_1.bgs_.ST01

				var_629_3.transform.localPosition = var_629_2
				var_629_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_629_4 = var_629_3:GetComponent("SpriteRenderer")

				if var_629_4 and var_629_4.sprite then
					local var_629_5 = (var_629_3.transform.localPosition - var_629_1).z
					local var_629_6 = manager.ui.mainCameraCom_
					local var_629_7 = 2 * var_629_5 * Mathf.Tan(var_629_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_629_8 = var_629_7 * var_629_6.aspect
					local var_629_9 = var_629_4.sprite.bounds.size.x
					local var_629_10 = var_629_4.sprite.bounds.size.y
					local var_629_11 = var_629_8 / var_629_9
					local var_629_12 = var_629_7 / var_629_10
					local var_629_13 = var_629_12 < var_629_11 and var_629_11 or var_629_12

					var_629_3.transform.localScale = Vector3.New(var_629_13, var_629_13, 0)
				end

				for iter_629_0, iter_629_1 in pairs(arg_626_1.bgs_) do
					if iter_629_0 ~= "ST01" then
						iter_629_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_629_14 = 0

			if var_629_14 < arg_626_1.time_ and arg_626_1.time_ <= var_629_14 + arg_629_0 then
				arg_626_1.mask_.enabled = true
				arg_626_1.mask_.raycastTarget = true

				arg_626_1:SetGaussion(false)
			end

			local var_629_15 = 2

			if var_629_14 <= arg_626_1.time_ and arg_626_1.time_ < var_629_14 + var_629_15 then
				local var_629_16 = (arg_626_1.time_ - var_629_14) / var_629_15
				local var_629_17 = Color.New(0, 0, 0)

				var_629_17.a = Mathf.Lerp(0, 1, var_629_16)
				arg_626_1.mask_.color = var_629_17
			end

			if arg_626_1.time_ >= var_629_14 + var_629_15 and arg_626_1.time_ < var_629_14 + var_629_15 + arg_629_0 then
				local var_629_18 = Color.New(0, 0, 0)

				var_629_18.a = 1
				arg_626_1.mask_.color = var_629_18
			end

			local var_629_19 = 2

			if var_629_19 < arg_626_1.time_ and arg_626_1.time_ <= var_629_19 + arg_629_0 then
				arg_626_1.mask_.enabled = true
				arg_626_1.mask_.raycastTarget = true

				arg_626_1:SetGaussion(false)
			end

			local var_629_20 = 2

			if var_629_19 <= arg_626_1.time_ and arg_626_1.time_ < var_629_19 + var_629_20 then
				local var_629_21 = (arg_626_1.time_ - var_629_19) / var_629_20
				local var_629_22 = Color.New(0, 0, 0)

				var_629_22.a = Mathf.Lerp(1, 0, var_629_21)
				arg_626_1.mask_.color = var_629_22
			end

			if arg_626_1.time_ >= var_629_19 + var_629_20 and arg_626_1.time_ < var_629_19 + var_629_20 + arg_629_0 then
				local var_629_23 = Color.New(0, 0, 0)
				local var_629_24 = 0

				arg_626_1.mask_.enabled = false
				var_629_23.a = var_629_24
				arg_626_1.mask_.color = var_629_23
			end

			local var_629_25 = "1011ui_story"

			if arg_626_1.actors_[var_629_25] == nil then
				local var_629_26 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_629_26) then
					local var_629_27 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_626_1.stage_.transform)

					var_629_27.name = var_629_25
					var_629_27.transform.localPosition = Vector3.New(0, 100, 0)
					arg_626_1.actors_[var_629_25] = var_629_27

					local var_629_28 = var_629_27:GetComponentInChildren(typeof(CharacterEffect))

					var_629_28.enabled = true

					local var_629_29 = GameObjectTools.GetOrAddComponent(var_629_27, typeof(DynamicBoneHelper))

					if var_629_29 then
						var_629_29:EnableDynamicBone(false)
					end

					arg_626_1:ShowWeapon(var_629_28.transform, false)

					arg_626_1.var_[var_629_25 .. "Animator"] = var_629_28.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_626_1.var_[var_629_25 .. "Animator"].applyRootMotion = true
					arg_626_1.var_[var_629_25 .. "LipSync"] = var_629_28.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_629_30 = arg_626_1.actors_["1011ui_story"].transform
			local var_629_31 = 4

			if var_629_31 < arg_626_1.time_ and arg_626_1.time_ <= var_629_31 + arg_629_0 then
				arg_626_1.var_.moveOldPos1011ui_story = var_629_30.localPosition
			end

			local var_629_32 = 0.001

			if var_629_31 <= arg_626_1.time_ and arg_626_1.time_ < var_629_31 + var_629_32 then
				local var_629_33 = (arg_626_1.time_ - var_629_31) / var_629_32
				local var_629_34 = Vector3.New(0, -0.71, -6)

				var_629_30.localPosition = Vector3.Lerp(arg_626_1.var_.moveOldPos1011ui_story, var_629_34, var_629_33)

				local var_629_35 = manager.ui.mainCamera.transform.position - var_629_30.position

				var_629_30.forward = Vector3.New(var_629_35.x, var_629_35.y, var_629_35.z)

				local var_629_36 = var_629_30.localEulerAngles

				var_629_36.z = 0
				var_629_36.x = 0
				var_629_30.localEulerAngles = var_629_36
			end

			if arg_626_1.time_ >= var_629_31 + var_629_32 and arg_626_1.time_ < var_629_31 + var_629_32 + arg_629_0 then
				var_629_30.localPosition = Vector3.New(0, -0.71, -6)

				local var_629_37 = manager.ui.mainCamera.transform.position - var_629_30.position

				var_629_30.forward = Vector3.New(var_629_37.x, var_629_37.y, var_629_37.z)

				local var_629_38 = var_629_30.localEulerAngles

				var_629_38.z = 0
				var_629_38.x = 0
				var_629_30.localEulerAngles = var_629_38
			end

			local var_629_39 = arg_626_1.actors_["1011ui_story"]
			local var_629_40 = 4

			if var_629_40 < arg_626_1.time_ and arg_626_1.time_ <= var_629_40 + arg_629_0 and not isNil(var_629_39) and arg_626_1.var_.characterEffect1011ui_story == nil then
				arg_626_1.var_.characterEffect1011ui_story = var_629_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_629_41 = 0.200000002980232

			if var_629_40 <= arg_626_1.time_ and arg_626_1.time_ < var_629_40 + var_629_41 and not isNil(var_629_39) then
				local var_629_42 = (arg_626_1.time_ - var_629_40) / var_629_41

				if arg_626_1.var_.characterEffect1011ui_story and not isNil(var_629_39) then
					arg_626_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_626_1.time_ >= var_629_40 + var_629_41 and arg_626_1.time_ < var_629_40 + var_629_41 + arg_629_0 and not isNil(var_629_39) and arg_626_1.var_.characterEffect1011ui_story then
				arg_626_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_629_43 = 4

			if var_629_43 < arg_626_1.time_ and arg_626_1.time_ <= var_629_43 + arg_629_0 then
				arg_626_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_629_44 = 4

			if var_629_44 < arg_626_1.time_ and arg_626_1.time_ <= var_629_44 + arg_629_0 then
				arg_626_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_629_45 = arg_626_1.actors_["1066ui_story"].transform
			local var_629_46 = 0

			if var_629_46 < arg_626_1.time_ and arg_626_1.time_ <= var_629_46 + arg_629_0 then
				arg_626_1.var_.moveOldPos1066ui_story = var_629_45.localPosition
			end

			local var_629_47 = 0.001

			if var_629_46 <= arg_626_1.time_ and arg_626_1.time_ < var_629_46 + var_629_47 then
				local var_629_48 = (arg_626_1.time_ - var_629_46) / var_629_47
				local var_629_49 = Vector3.New(0, 100, 0)

				var_629_45.localPosition = Vector3.Lerp(arg_626_1.var_.moveOldPos1066ui_story, var_629_49, var_629_48)

				local var_629_50 = manager.ui.mainCamera.transform.position - var_629_45.position

				var_629_45.forward = Vector3.New(var_629_50.x, var_629_50.y, var_629_50.z)

				local var_629_51 = var_629_45.localEulerAngles

				var_629_51.z = 0
				var_629_51.x = 0
				var_629_45.localEulerAngles = var_629_51
			end

			if arg_626_1.time_ >= var_629_46 + var_629_47 and arg_626_1.time_ < var_629_46 + var_629_47 + arg_629_0 then
				var_629_45.localPosition = Vector3.New(0, 100, 0)

				local var_629_52 = manager.ui.mainCamera.transform.position - var_629_45.position

				var_629_45.forward = Vector3.New(var_629_52.x, var_629_52.y, var_629_52.z)

				local var_629_53 = var_629_45.localEulerAngles

				var_629_53.z = 0
				var_629_53.x = 0
				var_629_45.localEulerAngles = var_629_53
			end

			local var_629_54 = arg_626_1.actors_["1066ui_story"]
			local var_629_55 = 0

			if var_629_55 < arg_626_1.time_ and arg_626_1.time_ <= var_629_55 + arg_629_0 and not isNil(var_629_54) and arg_626_1.var_.characterEffect1066ui_story == nil then
				arg_626_1.var_.characterEffect1066ui_story = var_629_54:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_629_56 = 0.200000002980232

			if var_629_55 <= arg_626_1.time_ and arg_626_1.time_ < var_629_55 + var_629_56 and not isNil(var_629_54) then
				local var_629_57 = (arg_626_1.time_ - var_629_55) / var_629_56

				if arg_626_1.var_.characterEffect1066ui_story and not isNil(var_629_54) then
					local var_629_58 = Mathf.Lerp(0, 0.5, var_629_57)

					arg_626_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_626_1.var_.characterEffect1066ui_story.fillRatio = var_629_58
				end
			end

			if arg_626_1.time_ >= var_629_55 + var_629_56 and arg_626_1.time_ < var_629_55 + var_629_56 + arg_629_0 and not isNil(var_629_54) and arg_626_1.var_.characterEffect1066ui_story then
				local var_629_59 = 0.5

				arg_626_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_626_1.var_.characterEffect1066ui_story.fillRatio = var_629_59
			end

			if arg_626_1.frameCnt_ <= 1 then
				arg_626_1.dialog_:SetActive(false)
			end

			local var_629_60 = 4
			local var_629_61 = 0.7

			if var_629_60 < arg_626_1.time_ and arg_626_1.time_ <= var_629_60 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0

				arg_626_1.dialog_:SetActive(true)

				arg_626_1.dialogCg_.alpha = 0

				local var_629_62 = LeanTween.value(arg_626_1.dialog_, 0, 1, 0.3)

				var_629_62:setOnUpdate(LuaHelper.FloatAction(function(arg_630_0)
					arg_626_1.dialogCg_.alpha = arg_630_0
				end))
				var_629_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_626_1.dialog_)
					var_629_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_626_1.duration_ = arg_626_1.duration_ + 0.3

				SetActive(arg_626_1.leftNameGo_, true)

				local var_629_63 = arg_626_1:FormatText(StoryNameCfg[37].name)

				arg_626_1.leftNameTxt_.text = var_629_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_626_1.leftNameTxt_.transform)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1.leftNameTxt_.text)
				SetActive(arg_626_1.iconTrs_.gameObject, false)
				arg_626_1.callingController_:SetSelectedState("normal")

				local var_629_64 = arg_626_1:GetWordFromCfg(1109403151)
				local var_629_65 = arg_626_1:FormatText(var_629_64.content)

				arg_626_1.text_.text = var_629_65

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_66 = 28
				local var_629_67 = utf8.len(var_629_65)
				local var_629_68 = var_629_66 <= 0 and var_629_61 or var_629_61 * (var_629_67 / var_629_66)

				if var_629_68 > 0 and var_629_61 < var_629_68 then
					arg_626_1.talkMaxDuration = var_629_68
					var_629_60 = var_629_60 + 0.3

					if var_629_68 + var_629_60 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_68 + var_629_60
					end
				end

				arg_626_1.text_.text = var_629_65
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403151", "story_v_side_new_1109403.awb") ~= 0 then
					local var_629_69 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403151", "story_v_side_new_1109403.awb") / 1000

					if var_629_69 + var_629_60 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_69 + var_629_60
					end

					if var_629_64.prefab_name ~= "" and arg_626_1.actors_[var_629_64.prefab_name] ~= nil then
						local var_629_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_626_1.actors_[var_629_64.prefab_name].transform, "story_v_side_new_1109403", "1109403151", "story_v_side_new_1109403.awb")

						arg_626_1:RecordAudio("1109403151", var_629_70)
						arg_626_1:RecordAudio("1109403151", var_629_70)
					else
						arg_626_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403151", "story_v_side_new_1109403.awb")
					end

					arg_626_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403151", "story_v_side_new_1109403.awb")
				end

				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_71 = var_629_60 + 0.3
			local var_629_72 = math.max(var_629_61, arg_626_1.talkMaxDuration)

			if var_629_71 <= arg_626_1.time_ and arg_626_1.time_ < var_629_71 + var_629_72 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - var_629_71) / var_629_72

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= var_629_71 + var_629_72 and arg_626_1.time_ < var_629_71 + var_629_72 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_626_1:InitPlayNodeList()
	end,
	Play1109403152 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 1109403152
		arg_632_1.duration_ = 13.57

		local var_632_0 = {
			ja = 13.566,
			ko = 6.066,
			zh = 6.066
		}
		local var_632_1 = manager.audio:GetLocalizationFlag()

		if var_632_0[var_632_1] ~= nil then
			arg_632_1.duration_ = var_632_0[var_632_1]
		end

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play1109403153(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			local var_635_0 = arg_632_1.actors_["1011ui_story"].transform
			local var_635_1 = 0

			if var_635_1 < arg_632_1.time_ and arg_632_1.time_ <= var_635_1 + arg_635_0 then
				arg_632_1.var_.moveOldPos1011ui_story = var_635_0.localPosition
			end

			local var_635_2 = 0.001

			if var_635_1 <= arg_632_1.time_ and arg_632_1.time_ < var_635_1 + var_635_2 then
				local var_635_3 = (arg_632_1.time_ - var_635_1) / var_635_2
				local var_635_4 = Vector3.New(0, -0.71, -6)

				var_635_0.localPosition = Vector3.Lerp(arg_632_1.var_.moveOldPos1011ui_story, var_635_4, var_635_3)

				local var_635_5 = manager.ui.mainCamera.transform.position - var_635_0.position

				var_635_0.forward = Vector3.New(var_635_5.x, var_635_5.y, var_635_5.z)

				local var_635_6 = var_635_0.localEulerAngles

				var_635_6.z = 0
				var_635_6.x = 0
				var_635_0.localEulerAngles = var_635_6
			end

			if arg_632_1.time_ >= var_635_1 + var_635_2 and arg_632_1.time_ < var_635_1 + var_635_2 + arg_635_0 then
				var_635_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_635_7 = manager.ui.mainCamera.transform.position - var_635_0.position

				var_635_0.forward = Vector3.New(var_635_7.x, var_635_7.y, var_635_7.z)

				local var_635_8 = var_635_0.localEulerAngles

				var_635_8.z = 0
				var_635_8.x = 0
				var_635_0.localEulerAngles = var_635_8
			end

			local var_635_9 = arg_632_1.actors_["1011ui_story"]
			local var_635_10 = 0

			if var_635_10 < arg_632_1.time_ and arg_632_1.time_ <= var_635_10 + arg_635_0 and not isNil(var_635_9) and arg_632_1.var_.characterEffect1011ui_story == nil then
				arg_632_1.var_.characterEffect1011ui_story = var_635_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_635_11 = 0.200000002980232

			if var_635_10 <= arg_632_1.time_ and arg_632_1.time_ < var_635_10 + var_635_11 and not isNil(var_635_9) then
				local var_635_12 = (arg_632_1.time_ - var_635_10) / var_635_11

				if arg_632_1.var_.characterEffect1011ui_story and not isNil(var_635_9) then
					arg_632_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_632_1.time_ >= var_635_10 + var_635_11 and arg_632_1.time_ < var_635_10 + var_635_11 + arg_635_0 and not isNil(var_635_9) and arg_632_1.var_.characterEffect1011ui_story then
				arg_632_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_635_13 = 0

			if var_635_13 < arg_632_1.time_ and arg_632_1.time_ <= var_635_13 + arg_635_0 then
				arg_632_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action462")
			end

			local var_635_14 = 0

			if var_635_14 < arg_632_1.time_ and arg_632_1.time_ <= var_635_14 + arg_635_0 then
				arg_632_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_635_15 = 0
			local var_635_16 = 0.725

			if var_635_15 < arg_632_1.time_ and arg_632_1.time_ <= var_635_15 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				local var_635_17 = arg_632_1:FormatText(StoryNameCfg[37].name)

				arg_632_1.leftNameTxt_.text = var_635_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, false)
				arg_632_1.callingController_:SetSelectedState("normal")

				local var_635_18 = arg_632_1:GetWordFromCfg(1109403152)
				local var_635_19 = arg_632_1:FormatText(var_635_18.content)

				arg_632_1.text_.text = var_635_19

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_20 = 29
				local var_635_21 = utf8.len(var_635_19)
				local var_635_22 = var_635_20 <= 0 and var_635_16 or var_635_16 * (var_635_21 / var_635_20)

				if var_635_22 > 0 and var_635_16 < var_635_22 then
					arg_632_1.talkMaxDuration = var_635_22

					if var_635_22 + var_635_15 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_22 + var_635_15
					end
				end

				arg_632_1.text_.text = var_635_19
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403152", "story_v_side_new_1109403.awb") ~= 0 then
					local var_635_23 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403152", "story_v_side_new_1109403.awb") / 1000

					if var_635_23 + var_635_15 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_23 + var_635_15
					end

					if var_635_18.prefab_name ~= "" and arg_632_1.actors_[var_635_18.prefab_name] ~= nil then
						local var_635_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_632_1.actors_[var_635_18.prefab_name].transform, "story_v_side_new_1109403", "1109403152", "story_v_side_new_1109403.awb")

						arg_632_1:RecordAudio("1109403152", var_635_24)
						arg_632_1:RecordAudio("1109403152", var_635_24)
					else
						arg_632_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403152", "story_v_side_new_1109403.awb")
					end

					arg_632_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403152", "story_v_side_new_1109403.awb")
				end

				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_25 = math.max(var_635_16, arg_632_1.talkMaxDuration)

			if var_635_15 <= arg_632_1.time_ and arg_632_1.time_ < var_635_15 + var_635_25 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_15) / var_635_25

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_15 + var_635_25 and arg_632_1.time_ < var_635_15 + var_635_25 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_632_1:InitPlayNodeList()
	end,
	Play1109403153 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 1109403153
		arg_636_1.duration_ = 12.93

		local var_636_0 = {
			ja = 12.933,
			ko = 10.833,
			zh = 10.833
		}
		local var_636_1 = manager.audio:GetLocalizationFlag()

		if var_636_0[var_636_1] ~= nil then
			arg_636_1.duration_ = var_636_0[var_636_1]
		end

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play1109403154(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			local var_639_0 = 2

			if var_639_0 < arg_636_1.time_ and arg_636_1.time_ <= var_639_0 + arg_639_0 then
				local var_639_1 = manager.ui.mainCamera.transform.localPosition
				local var_639_2 = Vector3.New(0, 0, 10) + Vector3.New(var_639_1.x, var_639_1.y, 0)
				local var_639_3 = arg_636_1.bgs_.ST01

				var_639_3.transform.localPosition = var_639_2
				var_639_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_639_4 = var_639_3:GetComponent("SpriteRenderer")

				if var_639_4 and var_639_4.sprite then
					local var_639_5 = (var_639_3.transform.localPosition - var_639_1).z
					local var_639_6 = manager.ui.mainCameraCom_
					local var_639_7 = 2 * var_639_5 * Mathf.Tan(var_639_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_639_8 = var_639_7 * var_639_6.aspect
					local var_639_9 = var_639_4.sprite.bounds.size.x
					local var_639_10 = var_639_4.sprite.bounds.size.y
					local var_639_11 = var_639_8 / var_639_9
					local var_639_12 = var_639_7 / var_639_10
					local var_639_13 = var_639_12 < var_639_11 and var_639_11 or var_639_12

					var_639_3.transform.localScale = Vector3.New(var_639_13, var_639_13, 0)
				end

				for iter_639_0, iter_639_1 in pairs(arg_636_1.bgs_) do
					if iter_639_0 ~= "ST01" then
						iter_639_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_639_14 = 0

			if var_639_14 < arg_636_1.time_ and arg_636_1.time_ <= var_639_14 + arg_639_0 then
				arg_636_1.mask_.enabled = true
				arg_636_1.mask_.raycastTarget = true

				arg_636_1:SetGaussion(false)
			end

			local var_639_15 = 2

			if var_639_14 <= arg_636_1.time_ and arg_636_1.time_ < var_639_14 + var_639_15 then
				local var_639_16 = (arg_636_1.time_ - var_639_14) / var_639_15
				local var_639_17 = Color.New(0, 0, 0)

				var_639_17.a = Mathf.Lerp(0, 1, var_639_16)
				arg_636_1.mask_.color = var_639_17
			end

			if arg_636_1.time_ >= var_639_14 + var_639_15 and arg_636_1.time_ < var_639_14 + var_639_15 + arg_639_0 then
				local var_639_18 = Color.New(0, 0, 0)

				var_639_18.a = 1
				arg_636_1.mask_.color = var_639_18
			end

			local var_639_19 = 2

			if var_639_19 < arg_636_1.time_ and arg_636_1.time_ <= var_639_19 + arg_639_0 then
				arg_636_1.mask_.enabled = true
				arg_636_1.mask_.raycastTarget = true

				arg_636_1:SetGaussion(false)
			end

			local var_639_20 = 2

			if var_639_19 <= arg_636_1.time_ and arg_636_1.time_ < var_639_19 + var_639_20 then
				local var_639_21 = (arg_636_1.time_ - var_639_19) / var_639_20
				local var_639_22 = Color.New(0, 0, 0)

				var_639_22.a = Mathf.Lerp(1, 0, var_639_21)
				arg_636_1.mask_.color = var_639_22
			end

			if arg_636_1.time_ >= var_639_19 + var_639_20 and arg_636_1.time_ < var_639_19 + var_639_20 + arg_639_0 then
				local var_639_23 = Color.New(0, 0, 0)
				local var_639_24 = 0

				arg_636_1.mask_.enabled = false
				var_639_23.a = var_639_24
				arg_636_1.mask_.color = var_639_23
			end

			local var_639_25 = "1039ui_story"

			if arg_636_1.actors_[var_639_25] == nil then
				local var_639_26 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_639_26) then
					local var_639_27 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_636_1.stage_.transform)

					var_639_27.name = var_639_25
					var_639_27.transform.localPosition = Vector3.New(0, 100, 0)
					arg_636_1.actors_[var_639_25] = var_639_27

					local var_639_28 = var_639_27:GetComponentInChildren(typeof(CharacterEffect))

					var_639_28.enabled = true

					local var_639_29 = GameObjectTools.GetOrAddComponent(var_639_27, typeof(DynamicBoneHelper))

					if var_639_29 then
						var_639_29:EnableDynamicBone(false)
					end

					arg_636_1:ShowWeapon(var_639_28.transform, false)

					arg_636_1.var_[var_639_25 .. "Animator"] = var_639_28.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_636_1.var_[var_639_25 .. "Animator"].applyRootMotion = true
					arg_636_1.var_[var_639_25 .. "LipSync"] = var_639_28.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_639_30 = arg_636_1.actors_["1039ui_story"].transform
			local var_639_31 = 4

			if var_639_31 < arg_636_1.time_ and arg_636_1.time_ <= var_639_31 + arg_639_0 then
				arg_636_1.var_.moveOldPos1039ui_story = var_639_30.localPosition
			end

			local var_639_32 = 0.001

			if var_639_31 <= arg_636_1.time_ and arg_636_1.time_ < var_639_31 + var_639_32 then
				local var_639_33 = (arg_636_1.time_ - var_639_31) / var_639_32
				local var_639_34 = Vector3.New(0, -1.01, -5.9)

				var_639_30.localPosition = Vector3.Lerp(arg_636_1.var_.moveOldPos1039ui_story, var_639_34, var_639_33)

				local var_639_35 = manager.ui.mainCamera.transform.position - var_639_30.position

				var_639_30.forward = Vector3.New(var_639_35.x, var_639_35.y, var_639_35.z)

				local var_639_36 = var_639_30.localEulerAngles

				var_639_36.z = 0
				var_639_36.x = 0
				var_639_30.localEulerAngles = var_639_36
			end

			if arg_636_1.time_ >= var_639_31 + var_639_32 and arg_636_1.time_ < var_639_31 + var_639_32 + arg_639_0 then
				var_639_30.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_639_37 = manager.ui.mainCamera.transform.position - var_639_30.position

				var_639_30.forward = Vector3.New(var_639_37.x, var_639_37.y, var_639_37.z)

				local var_639_38 = var_639_30.localEulerAngles

				var_639_38.z = 0
				var_639_38.x = 0
				var_639_30.localEulerAngles = var_639_38
			end

			local var_639_39 = arg_636_1.actors_["1039ui_story"]
			local var_639_40 = 4

			if var_639_40 < arg_636_1.time_ and arg_636_1.time_ <= var_639_40 + arg_639_0 and not isNil(var_639_39) and arg_636_1.var_.characterEffect1039ui_story == nil then
				arg_636_1.var_.characterEffect1039ui_story = var_639_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_639_41 = 0.200000002980232

			if var_639_40 <= arg_636_1.time_ and arg_636_1.time_ < var_639_40 + var_639_41 and not isNil(var_639_39) then
				local var_639_42 = (arg_636_1.time_ - var_639_40) / var_639_41

				if arg_636_1.var_.characterEffect1039ui_story and not isNil(var_639_39) then
					arg_636_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_636_1.time_ >= var_639_40 + var_639_41 and arg_636_1.time_ < var_639_40 + var_639_41 + arg_639_0 and not isNil(var_639_39) and arg_636_1.var_.characterEffect1039ui_story then
				arg_636_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_639_43 = 4

			if var_639_43 < arg_636_1.time_ and arg_636_1.time_ <= var_639_43 + arg_639_0 then
				arg_636_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action1_1")
			end

			local var_639_44 = 4

			if var_639_44 < arg_636_1.time_ and arg_636_1.time_ <= var_639_44 + arg_639_0 then
				arg_636_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_639_45 = arg_636_1.actors_["1011ui_story"].transform
			local var_639_46 = 0

			if var_639_46 < arg_636_1.time_ and arg_636_1.time_ <= var_639_46 + arg_639_0 then
				arg_636_1.var_.moveOldPos1011ui_story = var_639_45.localPosition
			end

			local var_639_47 = 0.001

			if var_639_46 <= arg_636_1.time_ and arg_636_1.time_ < var_639_46 + var_639_47 then
				local var_639_48 = (arg_636_1.time_ - var_639_46) / var_639_47
				local var_639_49 = Vector3.New(0, 100, 0)

				var_639_45.localPosition = Vector3.Lerp(arg_636_1.var_.moveOldPos1011ui_story, var_639_49, var_639_48)

				local var_639_50 = manager.ui.mainCamera.transform.position - var_639_45.position

				var_639_45.forward = Vector3.New(var_639_50.x, var_639_50.y, var_639_50.z)

				local var_639_51 = var_639_45.localEulerAngles

				var_639_51.z = 0
				var_639_51.x = 0
				var_639_45.localEulerAngles = var_639_51
			end

			if arg_636_1.time_ >= var_639_46 + var_639_47 and arg_636_1.time_ < var_639_46 + var_639_47 + arg_639_0 then
				var_639_45.localPosition = Vector3.New(0, 100, 0)

				local var_639_52 = manager.ui.mainCamera.transform.position - var_639_45.position

				var_639_45.forward = Vector3.New(var_639_52.x, var_639_52.y, var_639_52.z)

				local var_639_53 = var_639_45.localEulerAngles

				var_639_53.z = 0
				var_639_53.x = 0
				var_639_45.localEulerAngles = var_639_53
			end

			local var_639_54 = arg_636_1.actors_["1011ui_story"]
			local var_639_55 = 0

			if var_639_55 < arg_636_1.time_ and arg_636_1.time_ <= var_639_55 + arg_639_0 and not isNil(var_639_54) and arg_636_1.var_.characterEffect1011ui_story == nil then
				arg_636_1.var_.characterEffect1011ui_story = var_639_54:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_639_56 = 0.200000002980232

			if var_639_55 <= arg_636_1.time_ and arg_636_1.time_ < var_639_55 + var_639_56 and not isNil(var_639_54) then
				local var_639_57 = (arg_636_1.time_ - var_639_55) / var_639_56

				if arg_636_1.var_.characterEffect1011ui_story and not isNil(var_639_54) then
					local var_639_58 = Mathf.Lerp(0, 0.5, var_639_57)

					arg_636_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_636_1.var_.characterEffect1011ui_story.fillRatio = var_639_58
				end
			end

			if arg_636_1.time_ >= var_639_55 + var_639_56 and arg_636_1.time_ < var_639_55 + var_639_56 + arg_639_0 and not isNil(var_639_54) and arg_636_1.var_.characterEffect1011ui_story then
				local var_639_59 = 0.5

				arg_636_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_636_1.var_.characterEffect1011ui_story.fillRatio = var_639_59
			end

			if arg_636_1.frameCnt_ <= 1 then
				arg_636_1.dialog_:SetActive(false)
			end

			local var_639_60 = 4
			local var_639_61 = 0.725

			if var_639_60 < arg_636_1.time_ and arg_636_1.time_ <= var_639_60 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0

				arg_636_1.dialog_:SetActive(true)

				arg_636_1.dialogCg_.alpha = 0

				local var_639_62 = LeanTween.value(arg_636_1.dialog_, 0, 1, 0.3)

				var_639_62:setOnUpdate(LuaHelper.FloatAction(function(arg_640_0)
					arg_636_1.dialogCg_.alpha = arg_640_0
				end))
				var_639_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_636_1.dialog_)
					var_639_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_636_1.duration_ = arg_636_1.duration_ + 0.3

				SetActive(arg_636_1.leftNameGo_, true)

				local var_639_63 = arg_636_1:FormatText(StoryNameCfg[9].name)

				arg_636_1.leftNameTxt_.text = var_639_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_636_1.leftNameTxt_.transform)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1.leftNameTxt_.text)
				SetActive(arg_636_1.iconTrs_.gameObject, false)
				arg_636_1.callingController_:SetSelectedState("normal")

				local var_639_64 = arg_636_1:GetWordFromCfg(1109403153)
				local var_639_65 = arg_636_1:FormatText(var_639_64.content)

				arg_636_1.text_.text = var_639_65

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_66 = 29
				local var_639_67 = utf8.len(var_639_65)
				local var_639_68 = var_639_66 <= 0 and var_639_61 or var_639_61 * (var_639_67 / var_639_66)

				if var_639_68 > 0 and var_639_61 < var_639_68 then
					arg_636_1.talkMaxDuration = var_639_68
					var_639_60 = var_639_60 + 0.3

					if var_639_68 + var_639_60 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_68 + var_639_60
					end
				end

				arg_636_1.text_.text = var_639_65
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403153", "story_v_side_new_1109403.awb") ~= 0 then
					local var_639_69 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403153", "story_v_side_new_1109403.awb") / 1000

					if var_639_69 + var_639_60 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_69 + var_639_60
					end

					if var_639_64.prefab_name ~= "" and arg_636_1.actors_[var_639_64.prefab_name] ~= nil then
						local var_639_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_636_1.actors_[var_639_64.prefab_name].transform, "story_v_side_new_1109403", "1109403153", "story_v_side_new_1109403.awb")

						arg_636_1:RecordAudio("1109403153", var_639_70)
						arg_636_1:RecordAudio("1109403153", var_639_70)
					else
						arg_636_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403153", "story_v_side_new_1109403.awb")
					end

					arg_636_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403153", "story_v_side_new_1109403.awb")
				end

				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_71 = var_639_60 + 0.3
			local var_639_72 = math.max(var_639_61, arg_636_1.talkMaxDuration)

			if var_639_71 <= arg_636_1.time_ and arg_636_1.time_ < var_639_71 + var_639_72 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - var_639_71) / var_639_72

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= var_639_71 + var_639_72 and arg_636_1.time_ < var_639_71 + var_639_72 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_636_1:InitPlayNodeList()
	end,
	Play1109403154 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 1109403154
		arg_642_1.duration_ = 10.6

		local var_642_0 = {
			ja = 10.6,
			ko = 8.133,
			zh = 8.133
		}
		local var_642_1 = manager.audio:GetLocalizationFlag()

		if var_642_0[var_642_1] ~= nil then
			arg_642_1.duration_ = var_642_0[var_642_1]
		end

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play1109403155(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			local var_645_0 = arg_642_1.actors_["1039ui_story"].transform
			local var_645_1 = 0

			if var_645_1 < arg_642_1.time_ and arg_642_1.time_ <= var_645_1 + arg_645_0 then
				arg_642_1.var_.moveOldPos1039ui_story = var_645_0.localPosition
			end

			local var_645_2 = 0.001

			if var_645_1 <= arg_642_1.time_ and arg_642_1.time_ < var_645_1 + var_645_2 then
				local var_645_3 = (arg_642_1.time_ - var_645_1) / var_645_2
				local var_645_4 = Vector3.New(0, -1.01, -5.9)

				var_645_0.localPosition = Vector3.Lerp(arg_642_1.var_.moveOldPos1039ui_story, var_645_4, var_645_3)

				local var_645_5 = manager.ui.mainCamera.transform.position - var_645_0.position

				var_645_0.forward = Vector3.New(var_645_5.x, var_645_5.y, var_645_5.z)

				local var_645_6 = var_645_0.localEulerAngles

				var_645_6.z = 0
				var_645_6.x = 0
				var_645_0.localEulerAngles = var_645_6
			end

			if arg_642_1.time_ >= var_645_1 + var_645_2 and arg_642_1.time_ < var_645_1 + var_645_2 + arg_645_0 then
				var_645_0.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_645_7 = manager.ui.mainCamera.transform.position - var_645_0.position

				var_645_0.forward = Vector3.New(var_645_7.x, var_645_7.y, var_645_7.z)

				local var_645_8 = var_645_0.localEulerAngles

				var_645_8.z = 0
				var_645_8.x = 0
				var_645_0.localEulerAngles = var_645_8
			end

			local var_645_9 = arg_642_1.actors_["1039ui_story"]
			local var_645_10 = 0

			if var_645_10 < arg_642_1.time_ and arg_642_1.time_ <= var_645_10 + arg_645_0 and not isNil(var_645_9) and arg_642_1.var_.characterEffect1039ui_story == nil then
				arg_642_1.var_.characterEffect1039ui_story = var_645_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_645_11 = 0.200000002980232

			if var_645_10 <= arg_642_1.time_ and arg_642_1.time_ < var_645_10 + var_645_11 and not isNil(var_645_9) then
				local var_645_12 = (arg_642_1.time_ - var_645_10) / var_645_11

				if arg_642_1.var_.characterEffect1039ui_story and not isNil(var_645_9) then
					arg_642_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_642_1.time_ >= var_645_10 + var_645_11 and arg_642_1.time_ < var_645_10 + var_645_11 + arg_645_0 and not isNil(var_645_9) and arg_642_1.var_.characterEffect1039ui_story then
				arg_642_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_645_13 = 0

			if var_645_13 < arg_642_1.time_ and arg_642_1.time_ <= var_645_13 + arg_645_0 then
				arg_642_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_645_14 = 0
			local var_645_15 = 0.925

			if var_645_14 < arg_642_1.time_ and arg_642_1.time_ <= var_645_14 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, true)

				local var_645_16 = arg_642_1:FormatText(StoryNameCfg[9].name)

				arg_642_1.leftNameTxt_.text = var_645_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_642_1.leftNameTxt_.transform)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1.leftNameTxt_.text)
				SetActive(arg_642_1.iconTrs_.gameObject, false)
				arg_642_1.callingController_:SetSelectedState("normal")

				local var_645_17 = arg_642_1:GetWordFromCfg(1109403154)
				local var_645_18 = arg_642_1:FormatText(var_645_17.content)

				arg_642_1.text_.text = var_645_18

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_19 = 37
				local var_645_20 = utf8.len(var_645_18)
				local var_645_21 = var_645_19 <= 0 and var_645_15 or var_645_15 * (var_645_20 / var_645_19)

				if var_645_21 > 0 and var_645_15 < var_645_21 then
					arg_642_1.talkMaxDuration = var_645_21

					if var_645_21 + var_645_14 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_21 + var_645_14
					end
				end

				arg_642_1.text_.text = var_645_18
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403154", "story_v_side_new_1109403.awb") ~= 0 then
					local var_645_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403154", "story_v_side_new_1109403.awb") / 1000

					if var_645_22 + var_645_14 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_22 + var_645_14
					end

					if var_645_17.prefab_name ~= "" and arg_642_1.actors_[var_645_17.prefab_name] ~= nil then
						local var_645_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_642_1.actors_[var_645_17.prefab_name].transform, "story_v_side_new_1109403", "1109403154", "story_v_side_new_1109403.awb")

						arg_642_1:RecordAudio("1109403154", var_645_23)
						arg_642_1:RecordAudio("1109403154", var_645_23)
					else
						arg_642_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403154", "story_v_side_new_1109403.awb")
					end

					arg_642_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403154", "story_v_side_new_1109403.awb")
				end

				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_24 = math.max(var_645_15, arg_642_1.talkMaxDuration)

			if var_645_14 <= arg_642_1.time_ and arg_642_1.time_ < var_645_14 + var_645_24 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - var_645_14) / var_645_24

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= var_645_14 + var_645_24 and arg_642_1.time_ < var_645_14 + var_645_24 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_642_1:InitPlayNodeList()
	end,
	Play1109403155 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 1109403155
		arg_646_1.duration_ = 9

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play1109403156(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			local var_649_0 = 2

			if var_649_0 < arg_646_1.time_ and arg_646_1.time_ <= var_649_0 + arg_649_0 then
				local var_649_1 = manager.ui.mainCamera.transform.localPosition
				local var_649_2 = Vector3.New(0, 0, 10) + Vector3.New(var_649_1.x, var_649_1.y, 0)
				local var_649_3 = arg_646_1.bgs_.B13

				var_649_3.transform.localPosition = var_649_2
				var_649_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_649_4 = var_649_3:GetComponent("SpriteRenderer")

				if var_649_4 and var_649_4.sprite then
					local var_649_5 = (var_649_3.transform.localPosition - var_649_1).z
					local var_649_6 = manager.ui.mainCameraCom_
					local var_649_7 = 2 * var_649_5 * Mathf.Tan(var_649_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_649_8 = var_649_7 * var_649_6.aspect
					local var_649_9 = var_649_4.sprite.bounds.size.x
					local var_649_10 = var_649_4.sprite.bounds.size.y
					local var_649_11 = var_649_8 / var_649_9
					local var_649_12 = var_649_7 / var_649_10
					local var_649_13 = var_649_12 < var_649_11 and var_649_11 or var_649_12

					var_649_3.transform.localScale = Vector3.New(var_649_13, var_649_13, 0)
				end

				for iter_649_0, iter_649_1 in pairs(arg_646_1.bgs_) do
					if iter_649_0 ~= "B13" then
						iter_649_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_649_14 = 0

			if var_649_14 < arg_646_1.time_ and arg_646_1.time_ <= var_649_14 + arg_649_0 then
				arg_646_1.mask_.enabled = true
				arg_646_1.mask_.raycastTarget = true

				arg_646_1:SetGaussion(false)
			end

			local var_649_15 = 2

			if var_649_14 <= arg_646_1.time_ and arg_646_1.time_ < var_649_14 + var_649_15 then
				local var_649_16 = (arg_646_1.time_ - var_649_14) / var_649_15
				local var_649_17 = Color.New(0, 0, 0)

				var_649_17.a = Mathf.Lerp(0, 1, var_649_16)
				arg_646_1.mask_.color = var_649_17
			end

			if arg_646_1.time_ >= var_649_14 + var_649_15 and arg_646_1.time_ < var_649_14 + var_649_15 + arg_649_0 then
				local var_649_18 = Color.New(0, 0, 0)

				var_649_18.a = 1
				arg_646_1.mask_.color = var_649_18
			end

			local var_649_19 = 2

			if var_649_19 < arg_646_1.time_ and arg_646_1.time_ <= var_649_19 + arg_649_0 then
				arg_646_1.mask_.enabled = true
				arg_646_1.mask_.raycastTarget = true

				arg_646_1:SetGaussion(false)
			end

			local var_649_20 = 2

			if var_649_19 <= arg_646_1.time_ and arg_646_1.time_ < var_649_19 + var_649_20 then
				local var_649_21 = (arg_646_1.time_ - var_649_19) / var_649_20
				local var_649_22 = Color.New(0, 0, 0)

				var_649_22.a = Mathf.Lerp(1, 0, var_649_21)
				arg_646_1.mask_.color = var_649_22
			end

			if arg_646_1.time_ >= var_649_19 + var_649_20 and arg_646_1.time_ < var_649_19 + var_649_20 + arg_649_0 then
				local var_649_23 = Color.New(0, 0, 0)
				local var_649_24 = 0

				arg_646_1.mask_.enabled = false
				var_649_23.a = var_649_24
				arg_646_1.mask_.color = var_649_23
			end

			local var_649_25 = arg_646_1.actors_["1039ui_story"].transform
			local var_649_26 = 0

			if var_649_26 < arg_646_1.time_ and arg_646_1.time_ <= var_649_26 + arg_649_0 then
				arg_646_1.var_.moveOldPos1039ui_story = var_649_25.localPosition
			end

			local var_649_27 = 0.001

			if var_649_26 <= arg_646_1.time_ and arg_646_1.time_ < var_649_26 + var_649_27 then
				local var_649_28 = (arg_646_1.time_ - var_649_26) / var_649_27
				local var_649_29 = Vector3.New(0, 100, 0)

				var_649_25.localPosition = Vector3.Lerp(arg_646_1.var_.moveOldPos1039ui_story, var_649_29, var_649_28)

				local var_649_30 = manager.ui.mainCamera.transform.position - var_649_25.position

				var_649_25.forward = Vector3.New(var_649_30.x, var_649_30.y, var_649_30.z)

				local var_649_31 = var_649_25.localEulerAngles

				var_649_31.z = 0
				var_649_31.x = 0
				var_649_25.localEulerAngles = var_649_31
			end

			if arg_646_1.time_ >= var_649_26 + var_649_27 and arg_646_1.time_ < var_649_26 + var_649_27 + arg_649_0 then
				var_649_25.localPosition = Vector3.New(0, 100, 0)

				local var_649_32 = manager.ui.mainCamera.transform.position - var_649_25.position

				var_649_25.forward = Vector3.New(var_649_32.x, var_649_32.y, var_649_32.z)

				local var_649_33 = var_649_25.localEulerAngles

				var_649_33.z = 0
				var_649_33.x = 0
				var_649_25.localEulerAngles = var_649_33
			end

			local var_649_34 = arg_646_1.actors_["1039ui_story"]
			local var_649_35 = 0

			if var_649_35 < arg_646_1.time_ and arg_646_1.time_ <= var_649_35 + arg_649_0 and not isNil(var_649_34) and arg_646_1.var_.characterEffect1039ui_story == nil then
				arg_646_1.var_.characterEffect1039ui_story = var_649_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_649_36 = 0.200000002980232

			if var_649_35 <= arg_646_1.time_ and arg_646_1.time_ < var_649_35 + var_649_36 and not isNil(var_649_34) then
				local var_649_37 = (arg_646_1.time_ - var_649_35) / var_649_36

				if arg_646_1.var_.characterEffect1039ui_story and not isNil(var_649_34) then
					local var_649_38 = Mathf.Lerp(0, 0.5, var_649_37)

					arg_646_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_646_1.var_.characterEffect1039ui_story.fillRatio = var_649_38
				end
			end

			if arg_646_1.time_ >= var_649_35 + var_649_36 and arg_646_1.time_ < var_649_35 + var_649_36 + arg_649_0 and not isNil(var_649_34) and arg_646_1.var_.characterEffect1039ui_story then
				local var_649_39 = 0.5

				arg_646_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_646_1.var_.characterEffect1039ui_story.fillRatio = var_649_39
			end

			local var_649_40 = arg_646_1.actors_["1094ui_story"].transform
			local var_649_41 = 4

			if var_649_41 < arg_646_1.time_ and arg_646_1.time_ <= var_649_41 + arg_649_0 then
				arg_646_1.var_.moveOldPos1094ui_story = var_649_40.localPosition
			end

			local var_649_42 = 0.001

			if var_649_41 <= arg_646_1.time_ and arg_646_1.time_ < var_649_41 + var_649_42 then
				local var_649_43 = (arg_646_1.time_ - var_649_41) / var_649_42
				local var_649_44 = Vector3.New(0, -0.84, -6.1)

				var_649_40.localPosition = Vector3.Lerp(arg_646_1.var_.moveOldPos1094ui_story, var_649_44, var_649_43)

				local var_649_45 = manager.ui.mainCamera.transform.position - var_649_40.position

				var_649_40.forward = Vector3.New(var_649_45.x, var_649_45.y, var_649_45.z)

				local var_649_46 = var_649_40.localEulerAngles

				var_649_46.z = 0
				var_649_46.x = 0
				var_649_40.localEulerAngles = var_649_46
			end

			if arg_646_1.time_ >= var_649_41 + var_649_42 and arg_646_1.time_ < var_649_41 + var_649_42 + arg_649_0 then
				var_649_40.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_649_47 = manager.ui.mainCamera.transform.position - var_649_40.position

				var_649_40.forward = Vector3.New(var_649_47.x, var_649_47.y, var_649_47.z)

				local var_649_48 = var_649_40.localEulerAngles

				var_649_48.z = 0
				var_649_48.x = 0
				var_649_40.localEulerAngles = var_649_48
			end

			local var_649_49 = arg_646_1.actors_["1094ui_story"]
			local var_649_50 = 4

			if var_649_50 < arg_646_1.time_ and arg_646_1.time_ <= var_649_50 + arg_649_0 and not isNil(var_649_49) and arg_646_1.var_.characterEffect1094ui_story == nil then
				arg_646_1.var_.characterEffect1094ui_story = var_649_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_649_51 = 0.0166666666666667

			if var_649_50 <= arg_646_1.time_ and arg_646_1.time_ < var_649_50 + var_649_51 and not isNil(var_649_49) then
				local var_649_52 = (arg_646_1.time_ - var_649_50) / var_649_51

				if arg_646_1.var_.characterEffect1094ui_story and not isNil(var_649_49) then
					local var_649_53 = Mathf.Lerp(0, 0.5, var_649_52)

					arg_646_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_646_1.var_.characterEffect1094ui_story.fillRatio = var_649_53
				end
			end

			if arg_646_1.time_ >= var_649_50 + var_649_51 and arg_646_1.time_ < var_649_50 + var_649_51 + arg_649_0 and not isNil(var_649_49) and arg_646_1.var_.characterEffect1094ui_story then
				local var_649_54 = 0.5

				arg_646_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_646_1.var_.characterEffect1094ui_story.fillRatio = var_649_54
			end

			local var_649_55 = 4

			if var_649_55 < arg_646_1.time_ and arg_646_1.time_ <= var_649_55 + arg_649_0 then
				arg_646_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if arg_646_1.frameCnt_ <= 1 then
				arg_646_1.dialog_:SetActive(false)
			end

			local var_649_56 = 4
			local var_649_57 = 0.375

			if var_649_56 < arg_646_1.time_ and arg_646_1.time_ <= var_649_56 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0

				arg_646_1.dialog_:SetActive(true)

				arg_646_1.dialogCg_.alpha = 0

				local var_649_58 = LeanTween.value(arg_646_1.dialog_, 0, 1, 0.3)

				var_649_58:setOnUpdate(LuaHelper.FloatAction(function(arg_650_0)
					arg_646_1.dialogCg_.alpha = arg_650_0
				end))
				var_649_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_646_1.dialog_)
					var_649_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_646_1.duration_ = arg_646_1.duration_ + 0.3

				SetActive(arg_646_1.leftNameGo_, false)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_646_1.iconTrs_.gameObject, false)
				arg_646_1.callingController_:SetSelectedState("normal")

				local var_649_59 = arg_646_1:GetWordFromCfg(1109403155)
				local var_649_60 = arg_646_1:FormatText(var_649_59.content)

				arg_646_1.text_.text = var_649_60

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_61 = 15
				local var_649_62 = utf8.len(var_649_60)
				local var_649_63 = var_649_61 <= 0 and var_649_57 or var_649_57 * (var_649_62 / var_649_61)

				if var_649_63 > 0 and var_649_57 < var_649_63 then
					arg_646_1.talkMaxDuration = var_649_63
					var_649_56 = var_649_56 + 0.3

					if var_649_63 + var_649_56 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_63 + var_649_56
					end
				end

				arg_646_1.text_.text = var_649_60
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)
				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_64 = var_649_56 + 0.3
			local var_649_65 = math.max(var_649_57, arg_646_1.talkMaxDuration)

			if var_649_64 <= arg_646_1.time_ and arg_646_1.time_ < var_649_64 + var_649_65 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - var_649_64) / var_649_65

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= var_649_64 + var_649_65 and arg_646_1.time_ < var_649_64 + var_649_65 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_646_1:InitPlayNodeList()
	end,
	Play1109403156 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 1109403156
		arg_652_1.duration_ = 5

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play1109403157(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			local var_655_0 = 0
			local var_655_1 = 1

			if var_655_0 < arg_652_1.time_ and arg_652_1.time_ <= var_655_0 + arg_655_0 then
				local var_655_2 = "play"
				local var_655_3 = "effect"

				arg_652_1:AudioAction(var_655_2, var_655_3, "se_story_side_1094", "se_story_1094_cat", "")
			end

			local var_655_4 = 0
			local var_655_5 = 0.1

			if var_655_4 < arg_652_1.time_ and arg_652_1.time_ <= var_655_4 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, true)

				local var_655_6 = arg_652_1:FormatText(StoryNameCfg[197].name)

				arg_652_1.leftNameTxt_.text = var_655_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_652_1.leftNameTxt_.transform)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1.leftNameTxt_.text)
				SetActive(arg_652_1.iconTrs_.gameObject, true)
				arg_652_1.iconController_:SetSelectedState("hero")

				arg_652_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_catb")

				arg_652_1.callingController_:SetSelectedState("normal")

				arg_652_1.keyicon_.color = Color.New(1, 1, 1)
				arg_652_1.icon_.color = Color.New(1, 1, 1)

				local var_655_7 = arg_652_1:GetWordFromCfg(1109403156)
				local var_655_8 = arg_652_1:FormatText(var_655_7.content)

				arg_652_1.text_.text = var_655_8

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_9 = 4
				local var_655_10 = utf8.len(var_655_8)
				local var_655_11 = var_655_9 <= 0 and var_655_5 or var_655_5 * (var_655_10 / var_655_9)

				if var_655_11 > 0 and var_655_5 < var_655_11 then
					arg_652_1.talkMaxDuration = var_655_11

					if var_655_11 + var_655_4 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_11 + var_655_4
					end
				end

				arg_652_1.text_.text = var_655_8
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)
				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_12 = math.max(var_655_5, arg_652_1.talkMaxDuration)

			if var_655_4 <= arg_652_1.time_ and arg_652_1.time_ < var_655_4 + var_655_12 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_4) / var_655_12

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_4 + var_655_12 and arg_652_1.time_ < var_655_4 + var_655_12 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {}

		arg_652_1:InitPlayNodeList()
	end,
	Play1109403157 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 1109403157
		arg_656_1.duration_ = 4.9

		local var_656_0 = {
			ja = 3.966,
			ko = 4.9,
			zh = 4.9
		}
		local var_656_1 = manager.audio:GetLocalizationFlag()

		if var_656_0[var_656_1] ~= nil then
			arg_656_1.duration_ = var_656_0[var_656_1]
		end

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play1109403158(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			local var_659_0 = arg_656_1.actors_["1094ui_story"].transform
			local var_659_1 = 0

			if var_659_1 < arg_656_1.time_ and arg_656_1.time_ <= var_659_1 + arg_659_0 then
				arg_656_1.var_.moveOldPos1094ui_story = var_659_0.localPosition
			end

			local var_659_2 = 0.001

			if var_659_1 <= arg_656_1.time_ and arg_656_1.time_ < var_659_1 + var_659_2 then
				local var_659_3 = (arg_656_1.time_ - var_659_1) / var_659_2
				local var_659_4 = Vector3.New(0, -0.84, -6.1)

				var_659_0.localPosition = Vector3.Lerp(arg_656_1.var_.moveOldPos1094ui_story, var_659_4, var_659_3)

				local var_659_5 = manager.ui.mainCamera.transform.position - var_659_0.position

				var_659_0.forward = Vector3.New(var_659_5.x, var_659_5.y, var_659_5.z)

				local var_659_6 = var_659_0.localEulerAngles

				var_659_6.z = 0
				var_659_6.x = 0
				var_659_0.localEulerAngles = var_659_6
			end

			if arg_656_1.time_ >= var_659_1 + var_659_2 and arg_656_1.time_ < var_659_1 + var_659_2 + arg_659_0 then
				var_659_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_659_7 = manager.ui.mainCamera.transform.position - var_659_0.position

				var_659_0.forward = Vector3.New(var_659_7.x, var_659_7.y, var_659_7.z)

				local var_659_8 = var_659_0.localEulerAngles

				var_659_8.z = 0
				var_659_8.x = 0
				var_659_0.localEulerAngles = var_659_8
			end

			local var_659_9 = arg_656_1.actors_["1094ui_story"]
			local var_659_10 = 0

			if var_659_10 < arg_656_1.time_ and arg_656_1.time_ <= var_659_10 + arg_659_0 and not isNil(var_659_9) and arg_656_1.var_.characterEffect1094ui_story == nil then
				arg_656_1.var_.characterEffect1094ui_story = var_659_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_659_11 = 0.200000002980232

			if var_659_10 <= arg_656_1.time_ and arg_656_1.time_ < var_659_10 + var_659_11 and not isNil(var_659_9) then
				local var_659_12 = (arg_656_1.time_ - var_659_10) / var_659_11

				if arg_656_1.var_.characterEffect1094ui_story and not isNil(var_659_9) then
					arg_656_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_656_1.time_ >= var_659_10 + var_659_11 and arg_656_1.time_ < var_659_10 + var_659_11 + arg_659_0 and not isNil(var_659_9) and arg_656_1.var_.characterEffect1094ui_story then
				arg_656_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_659_13 = 0

			if var_659_13 < arg_656_1.time_ and arg_656_1.time_ <= var_659_13 + arg_659_0 then
				arg_656_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_659_14 = 0
			local var_659_15 = 0.175

			if var_659_14 < arg_656_1.time_ and arg_656_1.time_ <= var_659_14 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, true)

				local var_659_16 = arg_656_1:FormatText(StoryNameCfg[181].name)

				arg_656_1.leftNameTxt_.text = var_659_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_656_1.leftNameTxt_.transform)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1.leftNameTxt_.text)
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_17 = arg_656_1:GetWordFromCfg(1109403157)
				local var_659_18 = arg_656_1:FormatText(var_659_17.content)

				arg_656_1.text_.text = var_659_18

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_19 = 7
				local var_659_20 = utf8.len(var_659_18)
				local var_659_21 = var_659_19 <= 0 and var_659_15 or var_659_15 * (var_659_20 / var_659_19)

				if var_659_21 > 0 and var_659_15 < var_659_21 then
					arg_656_1.talkMaxDuration = var_659_21

					if var_659_21 + var_659_14 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_21 + var_659_14
					end
				end

				arg_656_1.text_.text = var_659_18
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403157", "story_v_side_new_1109403.awb") ~= 0 then
					local var_659_22 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403157", "story_v_side_new_1109403.awb") / 1000

					if var_659_22 + var_659_14 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_22 + var_659_14
					end

					if var_659_17.prefab_name ~= "" and arg_656_1.actors_[var_659_17.prefab_name] ~= nil then
						local var_659_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_656_1.actors_[var_659_17.prefab_name].transform, "story_v_side_new_1109403", "1109403157", "story_v_side_new_1109403.awb")

						arg_656_1:RecordAudio("1109403157", var_659_23)
						arg_656_1:RecordAudio("1109403157", var_659_23)
					else
						arg_656_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403157", "story_v_side_new_1109403.awb")
					end

					arg_656_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403157", "story_v_side_new_1109403.awb")
				end

				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_24 = math.max(var_659_15, arg_656_1.talkMaxDuration)

			if var_659_14 <= arg_656_1.time_ and arg_656_1.time_ < var_659_14 + var_659_24 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_14) / var_659_24

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_14 + var_659_24 and arg_656_1.time_ < var_659_14 + var_659_24 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_656_1:InitPlayNodeList()
	end,
	Play1109403158 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 1109403158
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
			arg_660_1.auto_ = false
		end

		function arg_660_1.playNext_(arg_662_0)
			arg_660_1.onStoryFinished_()
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = 0
			local var_663_1 = 0.675

			if var_663_0 < arg_660_1.time_ and arg_660_1.time_ <= var_663_0 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, false)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_660_1.iconTrs_.gameObject, false)
				arg_660_1.callingController_:SetSelectedState("normal")

				local var_663_2 = arg_660_1:GetWordFromCfg(1109403158)
				local var_663_3 = arg_660_1:FormatText(var_663_2.content)

				arg_660_1.text_.text = var_663_3

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_4 = 27
				local var_663_5 = utf8.len(var_663_3)
				local var_663_6 = var_663_4 <= 0 and var_663_1 or var_663_1 * (var_663_5 / var_663_4)

				if var_663_6 > 0 and var_663_1 < var_663_6 then
					arg_660_1.talkMaxDuration = var_663_6

					if var_663_6 + var_663_0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_6 + var_663_0
					end
				end

				arg_660_1.text_.text = var_663_3
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_7 = math.max(var_663_1, arg_660_1.talkMaxDuration)

			if var_663_0 <= arg_660_1.time_ and arg_660_1.time_ < var_663_0 + var_663_7 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_0) / var_663_7

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_0 + var_663_7 and arg_660_1.time_ < var_663_0 + var_663_7 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST08",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST10"
	},
	voices = {
		"story_v_side_new_1109403.awb"
	}
}
