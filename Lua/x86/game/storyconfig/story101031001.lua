return {
	Play103101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103101001
		arg_1_1.duration_ = 7.1

		local var_1_0 = {
			ja = 7.1,
			ko = 4.633,
			zh = 4.8,
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
				arg_1_0:Play103101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_office", "bgm_story_office", "bgm_story_office")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

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

			local var_4_6 = "B13"

			if arg_1_1.bgs_[var_4_6] == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			local var_4_8 = arg_1_1.bgs_.B13
			local var_4_9 = 0

			if var_4_9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				local var_4_10 = var_4_8:GetComponent("SpriteRenderer")

				if var_4_10 then
					arg_1_1.var_.alphaOldValueB13 = var_4_10.color.a
					arg_1_1.var_.alphaMatValueB13 = var_4_10
				end

				arg_1_1.var_.alphaOldValueB13 = 0
			end

			local var_4_11 = 1.5

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_11 then
				local var_4_12 = (arg_1_1.time_ - var_4_9) / var_4_11
				local var_4_13 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB13, 1, var_4_12)

				if arg_1_1.var_.alphaMatValueB13 then
					local var_4_14 = arg_1_1.var_.alphaMatValueB13.color

					var_4_14.a = var_4_13
					arg_1_1.var_.alphaMatValueB13.color = var_4_14
				end
			end

			if arg_1_1.time_ >= var_4_9 + var_4_11 and arg_1_1.time_ < var_4_9 + var_4_11 + arg_4_0 and arg_1_1.var_.alphaMatValueB13 then
				local var_4_15 = arg_1_1.var_.alphaMatValueB13
				local var_4_16 = var_4_15.color

				var_4_16.a = 1
				var_4_15.color = var_4_16
			end

			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = manager.ui.mainCamera.transform.localPosition
				local var_4_19 = Vector3.New(0, 0, 10) + Vector3.New(var_4_18.x, var_4_18.y, 0)
				local var_4_20 = arg_1_1.bgs_.B13

				var_4_20.transform.localPosition = var_4_19
				var_4_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_21 = var_4_20:GetComponent("SpriteRenderer")

				if var_4_21 and var_4_21.sprite then
					local var_4_22 = (var_4_20.transform.localPosition - var_4_18).z
					local var_4_23 = manager.ui.mainCameraCom_
					local var_4_24 = 2 * var_4_22 * Mathf.Tan(var_4_23.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_25 = var_4_24 * var_4_23.aspect
					local var_4_26 = var_4_21.sprite.bounds.size.x
					local var_4_27 = var_4_21.sprite.bounds.size.y
					local var_4_28 = var_4_25 / var_4_26
					local var_4_29 = var_4_24 / var_4_27
					local var_4_30 = var_4_29 < var_4_28 and var_4_28 or var_4_29

					var_4_20.transform.localScale = Vector3.New(var_4_30, var_4_30, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_31 = 0

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_32 = 2

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_33 = 2
			local var_4_34 = 0.55

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_35 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_35:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_36 = arg_1_1:FormatText(StoryNameCfg[52].name)

				arg_1_1.leftNameTxt_.text = var_4_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6061")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_37 = arg_1_1:GetWordFromCfg(103101001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 13
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_34 or var_4_34 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_34 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_33 = var_4_33 + 0.3

					if var_4_41 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101001", "story_v_out_103101.awb") ~= 0 then
					local var_4_42 = manager.audio:GetVoiceLength("story_v_out_103101", "103101001", "story_v_out_103101.awb") / 1000

					if var_4_42 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_33
					end

					if var_4_37.prefab_name ~= "" and arg_1_1.actors_[var_4_37.prefab_name] ~= nil then
						local var_4_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_37.prefab_name].transform, "story_v_out_103101", "103101001", "story_v_out_103101.awb")

						arg_1_1:RecordAudio("103101001", var_4_43)
						arg_1_1:RecordAudio("103101001", var_4_43)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_103101", "103101001", "story_v_out_103101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_103101", "103101001", "story_v_out_103101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = var_4_33 + 0.3
			local var_4_45 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_44) / var_4_45

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play103101002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 103101002
		arg_8_1.duration_ = 2.47

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play103101003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1037ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1037ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1037ui_story == nil then
				arg_8_1.var_.characterEffect1037ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1037ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1037ui_story then
				arg_8_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["1037ui_story"].transform
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.var_.moveOldPos1037ui_story = var_11_9.localPosition
			end

			local var_11_11 = 0.001

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11
				local var_11_13 = Vector3.New(0, -1.09, -5.81)

				var_11_9.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1037ui_story, var_11_13, var_11_12)

				local var_11_14 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_14.x, var_11_14.y, var_11_14.z)

				local var_11_15 = var_11_9.localEulerAngles

				var_11_15.z = 0
				var_11_15.x = 0
				var_11_9.localEulerAngles = var_11_15
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 then
				var_11_9.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_11_16 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_16.x, var_11_16.y, var_11_16.z)

				local var_11_17 = var_11_9.localEulerAngles

				var_11_17.z = 0
				var_11_17.x = 0
				var_11_9.localEulerAngles = var_11_17
			end

			local var_11_18 = 0

			if var_11_18 < arg_8_1.time_ and arg_8_1.time_ <= var_11_18 + arg_11_0 then
				arg_8_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_11_19 = 0

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				arg_8_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_11_20 = 0
			local var_11_21 = 0.1

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_22 = arg_8_1:FormatText(StoryNameCfg[15].name)

				arg_8_1.leftNameTxt_.text = var_11_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_23 = arg_8_1:GetWordFromCfg(103101002)
				local var_11_24 = arg_8_1:FormatText(var_11_23.content)

				arg_8_1.text_.text = var_11_24

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_25 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101002", "story_v_out_103101.awb") ~= 0 then
					local var_11_28 = manager.audio:GetVoiceLength("story_v_out_103101", "103101002", "story_v_out_103101.awb") / 1000

					if var_11_28 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_20
					end

					if var_11_23.prefab_name ~= "" and arg_8_1.actors_[var_11_23.prefab_name] ~= nil then
						local var_11_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_23.prefab_name].transform, "story_v_out_103101", "103101002", "story_v_out_103101.awb")

						arg_8_1:RecordAudio("103101002", var_11_29)
						arg_8_1:RecordAudio("103101002", var_11_29)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_103101", "103101002", "story_v_out_103101.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_103101", "103101002", "story_v_out_103101.awb")
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
				actorName = "1037ui_story",
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
	Play103101003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 103101003
		arg_12_1.duration_ = 13.17

		local var_12_0 = {
			ja = 11.9,
			ko = 13.166,
			zh = 10.4,
			en = 9.2
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
				arg_12_0:Play103101004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1037ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1037ui_story == nil then
				arg_12_1.var_.characterEffect1037ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1037ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1037ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1037ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1037ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 1.175

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[52].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6061")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_9 = arg_12_1:GetWordFromCfg(103101003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101003", "story_v_out_103101.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_103101", "103101003", "story_v_out_103101.awb") / 1000

					if var_15_14 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_6
					end

					if var_15_9.prefab_name ~= "" and arg_12_1.actors_[var_15_9.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_9.prefab_name].transform, "story_v_out_103101", "103101003", "story_v_out_103101.awb")

						arg_12_1:RecordAudio("103101003", var_15_15)
						arg_12_1:RecordAudio("103101003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_103101", "103101003", "story_v_out_103101.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_103101", "103101003", "story_v_out_103101.awb")
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
	Play103101004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 103101004
		arg_16_1.duration_ = 2.1

		local var_16_0 = {
			ja = 2.1,
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
				arg_16_0:Play103101005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1037ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1037ui_story == nil then
				arg_16_1.var_.characterEffect1037ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1037ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1037ui_story then
				arg_16_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_19_4 = 0

			if var_19_4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_19_5 = 0
			local var_19_6 = 0.05

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_7 = arg_16_1:FormatText(StoryNameCfg[15].name)

				arg_16_1.leftNameTxt_.text = var_19_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_8 = arg_16_1:GetWordFromCfg(103101004)
				local var_19_9 = arg_16_1:FormatText(var_19_8.content)

				arg_16_1.text_.text = var_19_9

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_10 = 2
				local var_19_11 = utf8.len(var_19_9)
				local var_19_12 = var_19_10 <= 0 and var_19_6 or var_19_6 * (var_19_11 / var_19_10)

				if var_19_12 > 0 and var_19_6 < var_19_12 then
					arg_16_1.talkMaxDuration = var_19_12

					if var_19_12 + var_19_5 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_5
					end
				end

				arg_16_1.text_.text = var_19_9
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101004", "story_v_out_103101.awb") ~= 0 then
					local var_19_13 = manager.audio:GetVoiceLength("story_v_out_103101", "103101004", "story_v_out_103101.awb") / 1000

					if var_19_13 + var_19_5 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_5
					end

					if var_19_8.prefab_name ~= "" and arg_16_1.actors_[var_19_8.prefab_name] ~= nil then
						local var_19_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_8.prefab_name].transform, "story_v_out_103101", "103101004", "story_v_out_103101.awb")

						arg_16_1:RecordAudio("103101004", var_19_14)
						arg_16_1:RecordAudio("103101004", var_19_14)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_103101", "103101004", "story_v_out_103101.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_103101", "103101004", "story_v_out_103101.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_15 = math.max(var_19_6, arg_16_1.talkMaxDuration)

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_15 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_5) / var_19_15

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_5 + var_19_15 and arg_16_1.time_ < var_19_5 + var_19_15 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play103101005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 103101005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play103101006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1037ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1037ui_story == nil then
				arg_20_1.var_.characterEffect1037ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1037ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1037ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1037ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1037ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 0.525

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_8 = arg_20_1:GetWordFromCfg(103101005)
				local var_23_9 = arg_20_1:FormatText(var_23_8.content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_10 = 21
				local var_23_11 = utf8.len(var_23_9)
				local var_23_12 = var_23_10 <= 0 and var_23_7 or var_23_7 * (var_23_11 / var_23_10)

				if var_23_12 > 0 and var_23_7 < var_23_12 then
					arg_20_1.talkMaxDuration = var_23_12

					if var_23_12 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_13 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_13 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_13

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_13 and arg_20_1.time_ < var_23_6 + var_23_13 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play103101006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 103101006
		arg_24_1.duration_ = 6.87

		local var_24_0 = {
			ja = 6.866,
			ko = 6.566,
			zh = 5.933,
			en = 4.8
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
				arg_24_0:Play103101007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1037ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1037ui_story == nil then
				arg_24_1.var_.characterEffect1037ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1037ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1037ui_story then
				arg_24_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_27_4 = 0

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action425")
			end

			local var_27_6 = 0
			local var_27_7 = 0.35

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_8 = arg_24_1:FormatText(StoryNameCfg[15].name)

				arg_24_1.leftNameTxt_.text = var_27_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_9 = arg_24_1:GetWordFromCfg(103101006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 26
				local var_27_12 = utf8.len(var_27_10)
				local var_27_13 = var_27_11 <= 0 and var_27_7 or var_27_7 * (var_27_12 / var_27_11)

				if var_27_13 > 0 and var_27_7 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_10
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101006", "story_v_out_103101.awb") ~= 0 then
					local var_27_14 = manager.audio:GetVoiceLength("story_v_out_103101", "103101006", "story_v_out_103101.awb") / 1000

					if var_27_14 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_6
					end

					if var_27_9.prefab_name ~= "" and arg_24_1.actors_[var_27_9.prefab_name] ~= nil then
						local var_27_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_9.prefab_name].transform, "story_v_out_103101", "103101006", "story_v_out_103101.awb")

						arg_24_1:RecordAudio("103101006", var_27_15)
						arg_24_1:RecordAudio("103101006", var_27_15)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_103101", "103101006", "story_v_out_103101.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_103101", "103101006", "story_v_out_103101.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_16 and arg_24_1.time_ < var_27_6 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play103101007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 103101007
		arg_28_1.duration_ = 9

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play103101008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 1

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				local var_31_2 = "play"
				local var_31_3 = "effect"

				arg_28_1:AudioAction(var_31_2, var_31_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_31_4 = 0

			if var_31_4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_5 = 2

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_5 then
				local var_31_6 = (arg_28_1.time_ - var_31_4) / var_31_5
				local var_31_7 = Color.New(0, 0, 0)

				var_31_7.a = Mathf.Lerp(0, 1, var_31_6)
				arg_28_1.mask_.color = var_31_7
			end

			if arg_28_1.time_ >= var_31_4 + var_31_5 and arg_28_1.time_ < var_31_4 + var_31_5 + arg_31_0 then
				local var_31_8 = Color.New(0, 0, 0)

				var_31_8.a = 1
				arg_28_1.mask_.color = var_31_8
			end

			local var_31_9 = 2

			if var_31_9 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_10 = 2

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_10 then
				local var_31_11 = (arg_28_1.time_ - var_31_9) / var_31_10
				local var_31_12 = Color.New(0, 0, 0)

				var_31_12.a = Mathf.Lerp(1, 0, var_31_11)
				arg_28_1.mask_.color = var_31_12
			end

			if arg_28_1.time_ >= var_31_9 + var_31_10 and arg_28_1.time_ < var_31_9 + var_31_10 + arg_31_0 then
				local var_31_13 = Color.New(0, 0, 0)
				local var_31_14 = 0

				arg_28_1.mask_.enabled = false
				var_31_13.a = var_31_14
				arg_28_1.mask_.color = var_31_13
			end

			local var_31_15 = "B03a"

			if arg_28_1.bgs_[var_31_15] == nil then
				local var_31_16 = Object.Instantiate(arg_28_1.paintGo_)

				var_31_16:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_31_15)
				var_31_16.name = var_31_15
				var_31_16.transform.parent = arg_28_1.stage_.transform
				var_31_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.bgs_[var_31_15] = var_31_16
			end

			local var_31_17 = 2

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 then
				local var_31_18 = manager.ui.mainCamera.transform.localPosition
				local var_31_19 = Vector3.New(0, 0, 10) + Vector3.New(var_31_18.x, var_31_18.y, 0)
				local var_31_20 = arg_28_1.bgs_.B03a

				var_31_20.transform.localPosition = var_31_19
				var_31_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_21 = var_31_20:GetComponent("SpriteRenderer")

				if var_31_21 and var_31_21.sprite then
					local var_31_22 = (var_31_20.transform.localPosition - var_31_18).z
					local var_31_23 = manager.ui.mainCameraCom_
					local var_31_24 = 2 * var_31_22 * Mathf.Tan(var_31_23.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_31_25 = var_31_24 * var_31_23.aspect
					local var_31_26 = var_31_21.sprite.bounds.size.x
					local var_31_27 = var_31_21.sprite.bounds.size.y
					local var_31_28 = var_31_25 / var_31_26
					local var_31_29 = var_31_24 / var_31_27
					local var_31_30 = var_31_29 < var_31_28 and var_31_28 or var_31_29

					var_31_20.transform.localScale = Vector3.New(var_31_30, var_31_30, 0)
				end

				for iter_31_0, iter_31_1 in pairs(arg_28_1.bgs_) do
					if iter_31_0 ~= "B03a" then
						iter_31_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_31 = arg_28_1.actors_["1037ui_story"].transform
			local var_31_32 = 1.966

			if var_31_32 < arg_28_1.time_ and arg_28_1.time_ <= var_31_32 + arg_31_0 then
				arg_28_1.var_.moveOldPos1037ui_story = var_31_31.localPosition
			end

			local var_31_33 = 0.001

			if var_31_32 <= arg_28_1.time_ and arg_28_1.time_ < var_31_32 + var_31_33 then
				local var_31_34 = (arg_28_1.time_ - var_31_32) / var_31_33
				local var_31_35 = Vector3.New(0, 100, 0)

				var_31_31.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1037ui_story, var_31_35, var_31_34)

				local var_31_36 = manager.ui.mainCamera.transform.position - var_31_31.position

				var_31_31.forward = Vector3.New(var_31_36.x, var_31_36.y, var_31_36.z)

				local var_31_37 = var_31_31.localEulerAngles

				var_31_37.z = 0
				var_31_37.x = 0
				var_31_31.localEulerAngles = var_31_37
			end

			if arg_28_1.time_ >= var_31_32 + var_31_33 and arg_28_1.time_ < var_31_32 + var_31_33 + arg_31_0 then
				var_31_31.localPosition = Vector3.New(0, 100, 0)

				local var_31_38 = manager.ui.mainCamera.transform.position - var_31_31.position

				var_31_31.forward = Vector3.New(var_31_38.x, var_31_38.y, var_31_38.z)

				local var_31_39 = var_31_31.localEulerAngles

				var_31_39.z = 0
				var_31_39.x = 0
				var_31_31.localEulerAngles = var_31_39
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_40 = 4
			local var_31_41 = 0.25

			if var_31_40 < arg_28_1.time_ and arg_28_1.time_ <= var_31_40 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_42 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_42:setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
					arg_28_1.dialogCg_.alpha = arg_32_0
				end))
				var_31_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_43 = arg_28_1:GetWordFromCfg(103101007)
				local var_31_44 = arg_28_1:FormatText(var_31_43.content)

				arg_28_1.text_.text = var_31_44

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_45 = 10
				local var_31_46 = utf8.len(var_31_44)
				local var_31_47 = var_31_45 <= 0 and var_31_41 or var_31_41 * (var_31_46 / var_31_45)

				if var_31_47 > 0 and var_31_41 < var_31_47 then
					arg_28_1.talkMaxDuration = var_31_47
					var_31_40 = var_31_40 + 0.3

					if var_31_47 + var_31_40 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_47 + var_31_40
					end
				end

				arg_28_1.text_.text = var_31_44
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_48 = var_31_40 + 0.3
			local var_31_49 = math.max(var_31_41, arg_28_1.talkMaxDuration)

			if var_31_48 <= arg_28_1.time_ and arg_28_1.time_ < var_31_48 + var_31_49 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_48) / var_31_49

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_48 + var_31_49 and arg_28_1.time_ < var_31_48 + var_31_49 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play103101008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 103101008
		arg_34_1.duration_ = 6.4

		local var_34_0 = {
			ja = 6.4,
			ko = 4.366,
			zh = 3.766,
			en = 6.266
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
				arg_34_0:Play103101009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0
			local var_37_1 = 1

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				local var_37_2 = "play"
				local var_37_3 = "music"

				arg_34_1:AudioAction(var_37_2, var_37_3, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_37_4 = ""
				local var_37_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_37_5 ~= "" then
					if arg_34_1.bgmTxt_.text ~= var_37_5 and arg_34_1.bgmTxt_.text ~= "" then
						if arg_34_1.bgmTxt2_.text ~= "" then
							arg_34_1.bgmTxt_.text = arg_34_1.bgmTxt2_.text
						end

						arg_34_1.bgmTxt2_.text = var_37_5

						arg_34_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_34_1.bgmTxt_.text = var_37_5
						arg_34_1.bgmTxt2_.text = var_37_5
					end

					if arg_34_1.bgmTimer then
						arg_34_1.bgmTimer:Stop()

						arg_34_1.bgmTimer = nil
					end

					if arg_34_1.settingData.show_music_name == 1 then
						arg_34_1.musicController:SetSelectedState("show")
						arg_34_1.musicAnimator_:Play("open", 0, 0)

						if arg_34_1.settingData.music_time ~= 0 then
							arg_34_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_34_1.settingData.music_time), function()
								if arg_34_1 == nil or isNil(arg_34_1.bgmTxt_) then
									return
								end

								arg_34_1.musicController:SetSelectedState("hide")
								arg_34_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_37_6 = 0
			local var_37_7 = 1

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				local var_37_8 = "play"
				local var_37_9 = "effect"

				arg_34_1:AudioAction(var_37_8, var_37_9, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_37_10 = "1036ui_story"

			if arg_34_1.actors_[var_37_10] == nil then
				local var_37_11 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_37_11) then
					local var_37_12 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_34_1.stage_.transform)

					var_37_12.name = var_37_10
					var_37_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_34_1.actors_[var_37_10] = var_37_12

					local var_37_13 = var_37_12:GetComponentInChildren(typeof(CharacterEffect))

					var_37_13.enabled = true

					local var_37_14 = GameObjectTools.GetOrAddComponent(var_37_12, typeof(DynamicBoneHelper))

					if var_37_14 then
						var_37_14:EnableDynamicBone(false)
					end

					arg_34_1:ShowWeapon(var_37_13.transform, false)

					arg_34_1.var_[var_37_10 .. "Animator"] = var_37_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_34_1.var_[var_37_10 .. "Animator"].applyRootMotion = true
					arg_34_1.var_[var_37_10 .. "LipSync"] = var_37_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_37_15 = arg_34_1.actors_["1036ui_story"]
			local var_37_16 = 0

			if var_37_16 < arg_34_1.time_ and arg_34_1.time_ <= var_37_16 + arg_37_0 and not isNil(var_37_15) and arg_34_1.var_.characterEffect1036ui_story == nil then
				arg_34_1.var_.characterEffect1036ui_story = var_37_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_17 = 0.1

			if var_37_16 <= arg_34_1.time_ and arg_34_1.time_ < var_37_16 + var_37_17 and not isNil(var_37_15) then
				local var_37_18 = (arg_34_1.time_ - var_37_16) / var_37_17

				if arg_34_1.var_.characterEffect1036ui_story and not isNil(var_37_15) then
					arg_34_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_16 + var_37_17 and arg_34_1.time_ < var_37_16 + var_37_17 + arg_37_0 and not isNil(var_37_15) and arg_34_1.var_.characterEffect1036ui_story then
				arg_34_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_37_19 = arg_34_1.actors_["1036ui_story"].transform
			local var_37_20 = 0

			if var_37_20 < arg_34_1.time_ and arg_34_1.time_ <= var_37_20 + arg_37_0 then
				arg_34_1.var_.moveOldPos1036ui_story = var_37_19.localPosition
			end

			local var_37_21 = 0.001

			if var_37_20 <= arg_34_1.time_ and arg_34_1.time_ < var_37_20 + var_37_21 then
				local var_37_22 = (arg_34_1.time_ - var_37_20) / var_37_21
				local var_37_23 = Vector3.New(-0.7, -1.09, -5.78)

				var_37_19.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1036ui_story, var_37_23, var_37_22)

				local var_37_24 = manager.ui.mainCamera.transform.position - var_37_19.position

				var_37_19.forward = Vector3.New(var_37_24.x, var_37_24.y, var_37_24.z)

				local var_37_25 = var_37_19.localEulerAngles

				var_37_25.z = 0
				var_37_25.x = 0
				var_37_19.localEulerAngles = var_37_25
			end

			if arg_34_1.time_ >= var_37_20 + var_37_21 and arg_34_1.time_ < var_37_20 + var_37_21 + arg_37_0 then
				var_37_19.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_37_26 = manager.ui.mainCamera.transform.position - var_37_19.position

				var_37_19.forward = Vector3.New(var_37_26.x, var_37_26.y, var_37_26.z)

				local var_37_27 = var_37_19.localEulerAngles

				var_37_27.z = 0
				var_37_27.x = 0
				var_37_19.localEulerAngles = var_37_27
			end

			local var_37_28 = 0

			if var_37_28 < arg_34_1.time_ and arg_34_1.time_ <= var_37_28 + arg_37_0 then
				arg_34_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action2_1")
			end

			local var_37_29 = 0

			if var_37_29 < arg_34_1.time_ and arg_34_1.time_ <= var_37_29 + arg_37_0 then
				arg_34_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_37_30 = 0
			local var_37_31 = 0.525

			if var_37_30 < arg_34_1.time_ and arg_34_1.time_ <= var_37_30 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_32 = arg_34_1:FormatText(StoryNameCfg[5].name)

				arg_34_1.leftNameTxt_.text = var_37_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_33 = arg_34_1:GetWordFromCfg(103101008)
				local var_37_34 = arg_34_1:FormatText(var_37_33.content)

				arg_34_1.text_.text = var_37_34

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_35 = 21
				local var_37_36 = utf8.len(var_37_34)
				local var_37_37 = var_37_35 <= 0 and var_37_31 or var_37_31 * (var_37_36 / var_37_35)

				if var_37_37 > 0 and var_37_31 < var_37_37 then
					arg_34_1.talkMaxDuration = var_37_37

					if var_37_37 + var_37_30 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_37 + var_37_30
					end
				end

				arg_34_1.text_.text = var_37_34
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101008", "story_v_out_103101.awb") ~= 0 then
					local var_37_38 = manager.audio:GetVoiceLength("story_v_out_103101", "103101008", "story_v_out_103101.awb") / 1000

					if var_37_38 + var_37_30 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_38 + var_37_30
					end

					if var_37_33.prefab_name ~= "" and arg_34_1.actors_[var_37_33.prefab_name] ~= nil then
						local var_37_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_33.prefab_name].transform, "story_v_out_103101", "103101008", "story_v_out_103101.awb")

						arg_34_1:RecordAudio("103101008", var_37_39)
						arg_34_1:RecordAudio("103101008", var_37_39)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_103101", "103101008", "story_v_out_103101.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_103101", "103101008", "story_v_out_103101.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_40 = math.max(var_37_31, arg_34_1.talkMaxDuration)

			if var_37_30 <= arg_34_1.time_ and arg_34_1.time_ < var_37_30 + var_37_40 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_30) / var_37_40

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_30 + var_37_40 and arg_34_1.time_ < var_37_30 + var_37_40 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play103101009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 103101009
		arg_39_1.duration_ = 6.17

		local var_39_0 = {
			ja = 6.166,
			ko = 3.2,
			zh = 3.733,
			en = 3.533
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play103101010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = "4010ui_story"

			if arg_39_1.actors_[var_42_0] == nil then
				local var_42_1 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_42_1) then
					local var_42_2 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_39_1.stage_.transform)

					var_42_2.name = var_42_0
					var_42_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_39_1.actors_[var_42_0] = var_42_2

					local var_42_3 = var_42_2:GetComponentInChildren(typeof(CharacterEffect))

					var_42_3.enabled = true

					local var_42_4 = GameObjectTools.GetOrAddComponent(var_42_2, typeof(DynamicBoneHelper))

					if var_42_4 then
						var_42_4:EnableDynamicBone(false)
					end

					arg_39_1:ShowWeapon(var_42_3.transform, false)

					arg_39_1.var_[var_42_0 .. "Animator"] = var_42_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_39_1.var_[var_42_0 .. "Animator"].applyRootMotion = true
					arg_39_1.var_[var_42_0 .. "LipSync"] = var_42_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_42_5 = arg_39_1.actors_["4010ui_story"]
			local var_42_6 = 0

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.characterEffect4010ui_story == nil then
				arg_39_1.var_.characterEffect4010ui_story = var_42_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_7 = 0.1

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_7 and not isNil(var_42_5) then
				local var_42_8 = (arg_39_1.time_ - var_42_6) / var_42_7

				if arg_39_1.var_.characterEffect4010ui_story and not isNil(var_42_5) then
					arg_39_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_6 + var_42_7 and arg_39_1.time_ < var_42_6 + var_42_7 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.characterEffect4010ui_story then
				arg_39_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_42_9 = arg_39_1.actors_["1036ui_story"]
			local var_42_10 = 0

			if var_42_10 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 and not isNil(var_42_9) and arg_39_1.var_.characterEffect1036ui_story == nil then
				arg_39_1.var_.characterEffect1036ui_story = var_42_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_11 = 0.1

			if var_42_10 <= arg_39_1.time_ and arg_39_1.time_ < var_42_10 + var_42_11 and not isNil(var_42_9) then
				local var_42_12 = (arg_39_1.time_ - var_42_10) / var_42_11

				if arg_39_1.var_.characterEffect1036ui_story and not isNil(var_42_9) then
					local var_42_13 = Mathf.Lerp(0, 0.5, var_42_12)

					arg_39_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1036ui_story.fillRatio = var_42_13
				end
			end

			if arg_39_1.time_ >= var_42_10 + var_42_11 and arg_39_1.time_ < var_42_10 + var_42_11 + arg_42_0 and not isNil(var_42_9) and arg_39_1.var_.characterEffect1036ui_story then
				local var_42_14 = 0.5

				arg_39_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1036ui_story.fillRatio = var_42_14
			end

			local var_42_15 = arg_39_1.actors_["4010ui_story"].transform
			local var_42_16 = 0

			if var_42_16 < arg_39_1.time_ and arg_39_1.time_ <= var_42_16 + arg_42_0 then
				arg_39_1.var_.moveOldPos4010ui_story = var_42_15.localPosition
			end

			local var_42_17 = 0.001

			if var_42_16 <= arg_39_1.time_ and arg_39_1.time_ < var_42_16 + var_42_17 then
				local var_42_18 = (arg_39_1.time_ - var_42_16) / var_42_17
				local var_42_19 = Vector3.New(0.7, -1.59, -5.2)

				var_42_15.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos4010ui_story, var_42_19, var_42_18)

				local var_42_20 = manager.ui.mainCamera.transform.position - var_42_15.position

				var_42_15.forward = Vector3.New(var_42_20.x, var_42_20.y, var_42_20.z)

				local var_42_21 = var_42_15.localEulerAngles

				var_42_21.z = 0
				var_42_21.x = 0
				var_42_15.localEulerAngles = var_42_21
			end

			if arg_39_1.time_ >= var_42_16 + var_42_17 and arg_39_1.time_ < var_42_16 + var_42_17 + arg_42_0 then
				var_42_15.localPosition = Vector3.New(0.7, -1.59, -5.2)

				local var_42_22 = manager.ui.mainCamera.transform.position - var_42_15.position

				var_42_15.forward = Vector3.New(var_42_22.x, var_42_22.y, var_42_22.z)

				local var_42_23 = var_42_15.localEulerAngles

				var_42_23.z = 0
				var_42_23.x = 0
				var_42_15.localEulerAngles = var_42_23
			end

			local var_42_24 = 0

			if var_42_24 < arg_39_1.time_ and arg_39_1.time_ <= var_42_24 + arg_42_0 then
				arg_39_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_42_25 = 0

			if var_42_25 < arg_39_1.time_ and arg_39_1.time_ <= var_42_25 + arg_42_0 then
				arg_39_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_42_26 = 0
			local var_42_27 = 0.325

			if var_42_26 < arg_39_1.time_ and arg_39_1.time_ <= var_42_26 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_28 = arg_39_1:FormatText(StoryNameCfg[42].name)

				arg_39_1.leftNameTxt_.text = var_42_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_29 = arg_39_1:GetWordFromCfg(103101009)
				local var_42_30 = arg_39_1:FormatText(var_42_29.content)

				arg_39_1.text_.text = var_42_30

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_31 = 13
				local var_42_32 = utf8.len(var_42_30)
				local var_42_33 = var_42_31 <= 0 and var_42_27 or var_42_27 * (var_42_32 / var_42_31)

				if var_42_33 > 0 and var_42_27 < var_42_33 then
					arg_39_1.talkMaxDuration = var_42_33

					if var_42_33 + var_42_26 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_33 + var_42_26
					end
				end

				arg_39_1.text_.text = var_42_30
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101009", "story_v_out_103101.awb") ~= 0 then
					local var_42_34 = manager.audio:GetVoiceLength("story_v_out_103101", "103101009", "story_v_out_103101.awb") / 1000

					if var_42_34 + var_42_26 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_34 + var_42_26
					end

					if var_42_29.prefab_name ~= "" and arg_39_1.actors_[var_42_29.prefab_name] ~= nil then
						local var_42_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_29.prefab_name].transform, "story_v_out_103101", "103101009", "story_v_out_103101.awb")

						arg_39_1:RecordAudio("103101009", var_42_35)
						arg_39_1:RecordAudio("103101009", var_42_35)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_103101", "103101009", "story_v_out_103101.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_103101", "103101009", "story_v_out_103101.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_36 = math.max(var_42_27, arg_39_1.talkMaxDuration)

			if var_42_26 <= arg_39_1.time_ and arg_39_1.time_ < var_42_26 + var_42_36 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_26) / var_42_36

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_26 + var_42_36 and arg_39_1.time_ < var_42_26 + var_42_36 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
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

		arg_39_1:InitPlayNodeList()
	end,
	Play103101010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 103101010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play103101011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["4010ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect4010ui_story == nil then
				arg_43_1.var_.characterEffect4010ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.1

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect4010ui_story and not isNil(var_46_0) then
					local var_46_4 = Mathf.Lerp(0, 0.5, var_46_3)

					arg_43_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_43_1.var_.characterEffect4010ui_story.fillRatio = var_46_4
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect4010ui_story then
				local var_46_5 = 0.5

				arg_43_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_43_1.var_.characterEffect4010ui_story.fillRatio = var_46_5
			end

			local var_46_6 = 0
			local var_46_7 = 0.525

			if var_46_6 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_8 = arg_43_1:GetWordFromCfg(103101010)
				local var_46_9 = arg_43_1:FormatText(var_46_8.content)

				arg_43_1.text_.text = var_46_9

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_10 = 21
				local var_46_11 = utf8.len(var_46_9)
				local var_46_12 = var_46_10 <= 0 and var_46_7 or var_46_7 * (var_46_11 / var_46_10)

				if var_46_12 > 0 and var_46_7 < var_46_12 then
					arg_43_1.talkMaxDuration = var_46_12

					if var_46_12 + var_46_6 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_12 + var_46_6
					end
				end

				arg_43_1.text_.text = var_46_9
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_13 = math.max(var_46_7, arg_43_1.talkMaxDuration)

			if var_46_6 <= arg_43_1.time_ and arg_43_1.time_ < var_46_6 + var_46_13 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_6) / var_46_13

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_6 + var_46_13 and arg_43_1.time_ < var_46_6 + var_46_13 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play103101011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 103101011
		arg_47_1.duration_ = 11.97

		local var_47_0 = {
			ja = 11.966,
			ko = 6.566,
			zh = 8.2,
			en = 5.833
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
				arg_47_0:Play103101012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["4010ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect4010ui_story == nil then
				arg_47_1.var_.characterEffect4010ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.1

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect4010ui_story and not isNil(var_50_0) then
					arg_47_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect4010ui_story then
				arg_47_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_50_4 = 0

			if var_50_4 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_50_5 = 0
			local var_50_6 = 0.7

			if var_50_5 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_7 = arg_47_1:FormatText(StoryNameCfg[42].name)

				arg_47_1.leftNameTxt_.text = var_50_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_8 = arg_47_1:GetWordFromCfg(103101011)
				local var_50_9 = arg_47_1:FormatText(var_50_8.content)

				arg_47_1.text_.text = var_50_9

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_10 = 28
				local var_50_11 = utf8.len(var_50_9)
				local var_50_12 = var_50_10 <= 0 and var_50_6 or var_50_6 * (var_50_11 / var_50_10)

				if var_50_12 > 0 and var_50_6 < var_50_12 then
					arg_47_1.talkMaxDuration = var_50_12

					if var_50_12 + var_50_5 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_5
					end
				end

				arg_47_1.text_.text = var_50_9
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101011", "story_v_out_103101.awb") ~= 0 then
					local var_50_13 = manager.audio:GetVoiceLength("story_v_out_103101", "103101011", "story_v_out_103101.awb") / 1000

					if var_50_13 + var_50_5 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_5
					end

					if var_50_8.prefab_name ~= "" and arg_47_1.actors_[var_50_8.prefab_name] ~= nil then
						local var_50_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_8.prefab_name].transform, "story_v_out_103101", "103101011", "story_v_out_103101.awb")

						arg_47_1:RecordAudio("103101011", var_50_14)
						arg_47_1:RecordAudio("103101011", var_50_14)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_103101", "103101011", "story_v_out_103101.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_103101", "103101011", "story_v_out_103101.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_15 = math.max(var_50_6, arg_47_1.talkMaxDuration)

			if var_50_5 <= arg_47_1.time_ and arg_47_1.time_ < var_50_5 + var_50_15 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_5) / var_50_15

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_5 + var_50_15 and arg_47_1.time_ < var_50_5 + var_50_15 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play103101012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 103101012
		arg_51_1.duration_ = 9.7

		local var_51_0 = {
			ja = 9.7,
			ko = 6.733,
			zh = 5.433,
			en = 6.333
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play103101013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1036ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1036ui_story == nil then
				arg_51_1.var_.characterEffect1036ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.1

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect1036ui_story and not isNil(var_54_0) then
					arg_51_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1036ui_story then
				arg_51_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_54_4 = arg_51_1.actors_["4010ui_story"]
			local var_54_5 = 0

			if var_54_5 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.characterEffect4010ui_story == nil then
				arg_51_1.var_.characterEffect4010ui_story = var_54_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_6 = 0.1

			if var_54_5 <= arg_51_1.time_ and arg_51_1.time_ < var_54_5 + var_54_6 and not isNil(var_54_4) then
				local var_54_7 = (arg_51_1.time_ - var_54_5) / var_54_6

				if arg_51_1.var_.characterEffect4010ui_story and not isNil(var_54_4) then
					local var_54_8 = Mathf.Lerp(0, 0.5, var_54_7)

					arg_51_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_51_1.var_.characterEffect4010ui_story.fillRatio = var_54_8
				end
			end

			if arg_51_1.time_ >= var_54_5 + var_54_6 and arg_51_1.time_ < var_54_5 + var_54_6 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.characterEffect4010ui_story then
				local var_54_9 = 0.5

				arg_51_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_51_1.var_.characterEffect4010ui_story.fillRatio = var_54_9
			end

			local var_54_10 = 0

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 then
				arg_51_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action423")
			end

			local var_54_11 = 0

			if var_54_11 < arg_51_1.time_ and arg_51_1.time_ <= var_54_11 + arg_54_0 then
				arg_51_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_54_12 = 0
			local var_54_13 = 0.775

			if var_54_12 < arg_51_1.time_ and arg_51_1.time_ <= var_54_12 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_14 = arg_51_1:FormatText(StoryNameCfg[5].name)

				arg_51_1.leftNameTxt_.text = var_54_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_15 = arg_51_1:GetWordFromCfg(103101012)
				local var_54_16 = arg_51_1:FormatText(var_54_15.content)

				arg_51_1.text_.text = var_54_16

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_17 = 31
				local var_54_18 = utf8.len(var_54_16)
				local var_54_19 = var_54_17 <= 0 and var_54_13 or var_54_13 * (var_54_18 / var_54_17)

				if var_54_19 > 0 and var_54_13 < var_54_19 then
					arg_51_1.talkMaxDuration = var_54_19

					if var_54_19 + var_54_12 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_19 + var_54_12
					end
				end

				arg_51_1.text_.text = var_54_16
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101012", "story_v_out_103101.awb") ~= 0 then
					local var_54_20 = manager.audio:GetVoiceLength("story_v_out_103101", "103101012", "story_v_out_103101.awb") / 1000

					if var_54_20 + var_54_12 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_20 + var_54_12
					end

					if var_54_15.prefab_name ~= "" and arg_51_1.actors_[var_54_15.prefab_name] ~= nil then
						local var_54_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_15.prefab_name].transform, "story_v_out_103101", "103101012", "story_v_out_103101.awb")

						arg_51_1:RecordAudio("103101012", var_54_21)
						arg_51_1:RecordAudio("103101012", var_54_21)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_103101", "103101012", "story_v_out_103101.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_103101", "103101012", "story_v_out_103101.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_22 = math.max(var_54_13, arg_51_1.talkMaxDuration)

			if var_54_12 <= arg_51_1.time_ and arg_51_1.time_ < var_54_12 + var_54_22 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_12) / var_54_22

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_12 + var_54_22 and arg_51_1.time_ < var_54_12 + var_54_22 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play103101013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 103101013
		arg_55_1.duration_ = 3.23

		local var_55_0 = {
			ja = 3.233,
			ko = 2.133,
			zh = 2.366,
			en = 1.999999999999
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play103101014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["4010ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect4010ui_story == nil then
				arg_55_1.var_.characterEffect4010ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.1

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect4010ui_story and not isNil(var_58_0) then
					arg_55_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect4010ui_story then
				arg_55_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_58_4 = arg_55_1.actors_["1036ui_story"]
			local var_58_5 = 0

			if var_58_5 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 and not isNil(var_58_4) and arg_55_1.var_.characterEffect1036ui_story == nil then
				arg_55_1.var_.characterEffect1036ui_story = var_58_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_6 = 0.1

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_6 and not isNil(var_58_4) then
				local var_58_7 = (arg_55_1.time_ - var_58_5) / var_58_6

				if arg_55_1.var_.characterEffect1036ui_story and not isNil(var_58_4) then
					local var_58_8 = Mathf.Lerp(0, 0.5, var_58_7)

					arg_55_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1036ui_story.fillRatio = var_58_8
				end
			end

			if arg_55_1.time_ >= var_58_5 + var_58_6 and arg_55_1.time_ < var_58_5 + var_58_6 + arg_58_0 and not isNil(var_58_4) and arg_55_1.var_.characterEffect1036ui_story then
				local var_58_9 = 0.5

				arg_55_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1036ui_story.fillRatio = var_58_9
			end

			local var_58_10 = 0

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 then
				arg_55_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_58_11 = 0
			local var_58_12 = 0.225

			if var_58_11 < arg_55_1.time_ and arg_55_1.time_ <= var_58_11 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_13 = arg_55_1:FormatText(StoryNameCfg[42].name)

				arg_55_1.leftNameTxt_.text = var_58_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_14 = arg_55_1:GetWordFromCfg(103101013)
				local var_58_15 = arg_55_1:FormatText(var_58_14.content)

				arg_55_1.text_.text = var_58_15

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_16 = 9
				local var_58_17 = utf8.len(var_58_15)
				local var_58_18 = var_58_16 <= 0 and var_58_12 or var_58_12 * (var_58_17 / var_58_16)

				if var_58_18 > 0 and var_58_12 < var_58_18 then
					arg_55_1.talkMaxDuration = var_58_18

					if var_58_18 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_18 + var_58_11
					end
				end

				arg_55_1.text_.text = var_58_15
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101013", "story_v_out_103101.awb") ~= 0 then
					local var_58_19 = manager.audio:GetVoiceLength("story_v_out_103101", "103101013", "story_v_out_103101.awb") / 1000

					if var_58_19 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_19 + var_58_11
					end

					if var_58_14.prefab_name ~= "" and arg_55_1.actors_[var_58_14.prefab_name] ~= nil then
						local var_58_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_14.prefab_name].transform, "story_v_out_103101", "103101013", "story_v_out_103101.awb")

						arg_55_1:RecordAudio("103101013", var_58_20)
						arg_55_1:RecordAudio("103101013", var_58_20)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_103101", "103101013", "story_v_out_103101.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_103101", "103101013", "story_v_out_103101.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_21 = math.max(var_58_12, arg_55_1.talkMaxDuration)

			if var_58_11 <= arg_55_1.time_ and arg_55_1.time_ < var_58_11 + var_58_21 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_11) / var_58_21

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_11 + var_58_21 and arg_55_1.time_ < var_58_11 + var_58_21 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play103101014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 103101014
		arg_59_1.duration_ = 2

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play103101015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1036ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1036ui_story == nil then
				arg_59_1.var_.characterEffect1036ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.1

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1036ui_story and not isNil(var_62_0) then
					arg_59_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1036ui_story then
				arg_59_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_62_4 = arg_59_1.actors_["4010ui_story"]
			local var_62_5 = 0

			if var_62_5 < arg_59_1.time_ and arg_59_1.time_ <= var_62_5 + arg_62_0 and not isNil(var_62_4) and arg_59_1.var_.characterEffect4010ui_story == nil then
				arg_59_1.var_.characterEffect4010ui_story = var_62_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_6 = 0.1

			if var_62_5 <= arg_59_1.time_ and arg_59_1.time_ < var_62_5 + var_62_6 and not isNil(var_62_4) then
				local var_62_7 = (arg_59_1.time_ - var_62_5) / var_62_6

				if arg_59_1.var_.characterEffect4010ui_story and not isNil(var_62_4) then
					local var_62_8 = Mathf.Lerp(0, 0.5, var_62_7)

					arg_59_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_59_1.var_.characterEffect4010ui_story.fillRatio = var_62_8
				end
			end

			if arg_59_1.time_ >= var_62_5 + var_62_6 and arg_59_1.time_ < var_62_5 + var_62_6 + arg_62_0 and not isNil(var_62_4) and arg_59_1.var_.characterEffect4010ui_story then
				local var_62_9 = 0.5

				arg_59_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_59_1.var_.characterEffect4010ui_story.fillRatio = var_62_9
			end

			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 then
				arg_59_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action435")
			end

			local var_62_11 = 0

			if var_62_11 < arg_59_1.time_ and arg_59_1.time_ <= var_62_11 + arg_62_0 then
				arg_59_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_62_12 = 0
			local var_62_13 = 0.075

			if var_62_12 < arg_59_1.time_ and arg_59_1.time_ <= var_62_12 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_14 = arg_59_1:FormatText(StoryNameCfg[5].name)

				arg_59_1.leftNameTxt_.text = var_62_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_15 = arg_59_1:GetWordFromCfg(103101014)
				local var_62_16 = arg_59_1:FormatText(var_62_15.content)

				arg_59_1.text_.text = var_62_16

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_17 = 3
				local var_62_18 = utf8.len(var_62_16)
				local var_62_19 = var_62_17 <= 0 and var_62_13 or var_62_13 * (var_62_18 / var_62_17)

				if var_62_19 > 0 and var_62_13 < var_62_19 then
					arg_59_1.talkMaxDuration = var_62_19

					if var_62_19 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_19 + var_62_12
					end
				end

				arg_59_1.text_.text = var_62_16
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101014", "story_v_out_103101.awb") ~= 0 then
					local var_62_20 = manager.audio:GetVoiceLength("story_v_out_103101", "103101014", "story_v_out_103101.awb") / 1000

					if var_62_20 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_20 + var_62_12
					end

					if var_62_15.prefab_name ~= "" and arg_59_1.actors_[var_62_15.prefab_name] ~= nil then
						local var_62_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_15.prefab_name].transform, "story_v_out_103101", "103101014", "story_v_out_103101.awb")

						arg_59_1:RecordAudio("103101014", var_62_21)
						arg_59_1:RecordAudio("103101014", var_62_21)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_103101", "103101014", "story_v_out_103101.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_103101", "103101014", "story_v_out_103101.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_22 = math.max(var_62_13, arg_59_1.talkMaxDuration)

			if var_62_12 <= arg_59_1.time_ and arg_59_1.time_ < var_62_12 + var_62_22 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_12) / var_62_22

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_12 + var_62_22 and arg_59_1.time_ < var_62_12 + var_62_22 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play103101015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 103101015
		arg_63_1.duration_ = 10.77

		local var_63_0 = {
			ja = 10.766,
			ko = 5.733,
			zh = 6.3,
			en = 3.266
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play103101016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["4010ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect4010ui_story == nil then
				arg_63_1.var_.characterEffect4010ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.1

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect4010ui_story and not isNil(var_66_0) then
					arg_63_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect4010ui_story then
				arg_63_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_66_4 = arg_63_1.actors_["1036ui_story"]
			local var_66_5 = 0

			if var_66_5 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1036ui_story == nil then
				arg_63_1.var_.characterEffect1036ui_story = var_66_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_6 = 0.1

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_6 and not isNil(var_66_4) then
				local var_66_7 = (arg_63_1.time_ - var_66_5) / var_66_6

				if arg_63_1.var_.characterEffect1036ui_story and not isNil(var_66_4) then
					local var_66_8 = Mathf.Lerp(0, 0.5, var_66_7)

					arg_63_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1036ui_story.fillRatio = var_66_8
				end
			end

			if arg_63_1.time_ >= var_66_5 + var_66_6 and arg_63_1.time_ < var_66_5 + var_66_6 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1036ui_story then
				local var_66_9 = 0.5

				arg_63_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1036ui_story.fillRatio = var_66_9
			end

			local var_66_10 = 0

			if var_66_10 < arg_63_1.time_ and arg_63_1.time_ <= var_66_10 + arg_66_0 then
				arg_63_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_66_11 = 0
			local var_66_12 = 0.625

			if var_66_11 < arg_63_1.time_ and arg_63_1.time_ <= var_66_11 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_13 = arg_63_1:FormatText(StoryNameCfg[42].name)

				arg_63_1.leftNameTxt_.text = var_66_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_14 = arg_63_1:GetWordFromCfg(103101015)
				local var_66_15 = arg_63_1:FormatText(var_66_14.content)

				arg_63_1.text_.text = var_66_15

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_16 = 25
				local var_66_17 = utf8.len(var_66_15)
				local var_66_18 = var_66_16 <= 0 and var_66_12 or var_66_12 * (var_66_17 / var_66_16)

				if var_66_18 > 0 and var_66_12 < var_66_18 then
					arg_63_1.talkMaxDuration = var_66_18

					if var_66_18 + var_66_11 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_18 + var_66_11
					end
				end

				arg_63_1.text_.text = var_66_15
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101015", "story_v_out_103101.awb") ~= 0 then
					local var_66_19 = manager.audio:GetVoiceLength("story_v_out_103101", "103101015", "story_v_out_103101.awb") / 1000

					if var_66_19 + var_66_11 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_19 + var_66_11
					end

					if var_66_14.prefab_name ~= "" and arg_63_1.actors_[var_66_14.prefab_name] ~= nil then
						local var_66_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_14.prefab_name].transform, "story_v_out_103101", "103101015", "story_v_out_103101.awb")

						arg_63_1:RecordAudio("103101015", var_66_20)
						arg_63_1:RecordAudio("103101015", var_66_20)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_103101", "103101015", "story_v_out_103101.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_103101", "103101015", "story_v_out_103101.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_21 = math.max(var_66_12, arg_63_1.talkMaxDuration)

			if var_66_11 <= arg_63_1.time_ and arg_63_1.time_ < var_66_11 + var_66_21 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_11) / var_66_21

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_11 + var_66_21 and arg_63_1.time_ < var_66_11 + var_66_21 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play103101016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 103101016
		arg_67_1.duration_ = 13.43

		local var_67_0 = {
			ja = 13.433,
			ko = 9,
			zh = 9.3,
			en = 8.033
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play103101017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_70_1 = 0
			local var_70_2 = 1.075

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_3 = arg_67_1:FormatText(StoryNameCfg[42].name)

				arg_67_1.leftNameTxt_.text = var_70_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:GetWordFromCfg(103101016)
				local var_70_5 = arg_67_1:FormatText(var_70_4.content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_6 = 43
				local var_70_7 = utf8.len(var_70_5)
				local var_70_8 = var_70_6 <= 0 and var_70_2 or var_70_2 * (var_70_7 / var_70_6)

				if var_70_8 > 0 and var_70_2 < var_70_8 then
					arg_67_1.talkMaxDuration = var_70_8

					if var_70_8 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101016", "story_v_out_103101.awb") ~= 0 then
					local var_70_9 = manager.audio:GetVoiceLength("story_v_out_103101", "103101016", "story_v_out_103101.awb") / 1000

					if var_70_9 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_1
					end

					if var_70_4.prefab_name ~= "" and arg_67_1.actors_[var_70_4.prefab_name] ~= nil then
						local var_70_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_4.prefab_name].transform, "story_v_out_103101", "103101016", "story_v_out_103101.awb")

						arg_67_1:RecordAudio("103101016", var_70_10)
						arg_67_1:RecordAudio("103101016", var_70_10)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_103101", "103101016", "story_v_out_103101.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_103101", "103101016", "story_v_out_103101.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_11 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_11 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_11

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_11 and arg_67_1.time_ < var_70_1 + var_70_11 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play103101017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 103101017
		arg_71_1.duration_ = 4.67

		local var_71_0 = {
			ja = 4.666,
			ko = 2.1,
			zh = 3.066,
			en = 3
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
				arg_71_0:Play103101018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1036ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1036ui_story == nil then
				arg_71_1.var_.characterEffect1036ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.1

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect1036ui_story and not isNil(var_74_0) then
					arg_71_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1036ui_story then
				arg_71_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_74_4 = arg_71_1.actors_["4010ui_story"]
			local var_74_5 = 0

			if var_74_5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect4010ui_story == nil then
				arg_71_1.var_.characterEffect4010ui_story = var_74_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_6 = 0.1

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_6 and not isNil(var_74_4) then
				local var_74_7 = (arg_71_1.time_ - var_74_5) / var_74_6

				if arg_71_1.var_.characterEffect4010ui_story and not isNil(var_74_4) then
					local var_74_8 = Mathf.Lerp(0, 0.5, var_74_7)

					arg_71_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_71_1.var_.characterEffect4010ui_story.fillRatio = var_74_8
				end
			end

			if arg_71_1.time_ >= var_74_5 + var_74_6 and arg_71_1.time_ < var_74_5 + var_74_6 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect4010ui_story then
				local var_74_9 = 0.5

				arg_71_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_71_1.var_.characterEffect4010ui_story.fillRatio = var_74_9
			end

			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action456")
			end

			local var_74_11 = 0

			if var_74_11 < arg_71_1.time_ and arg_71_1.time_ <= var_74_11 + arg_74_0 then
				arg_71_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_74_12 = 0
			local var_74_13 = 0.25

			if var_74_12 < arg_71_1.time_ and arg_71_1.time_ <= var_74_12 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_14 = arg_71_1:FormatText(StoryNameCfg[5].name)

				arg_71_1.leftNameTxt_.text = var_74_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_15 = arg_71_1:GetWordFromCfg(103101017)
				local var_74_16 = arg_71_1:FormatText(var_74_15.content)

				arg_71_1.text_.text = var_74_16

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_17 = 10
				local var_74_18 = utf8.len(var_74_16)
				local var_74_19 = var_74_17 <= 0 and var_74_13 or var_74_13 * (var_74_18 / var_74_17)

				if var_74_19 > 0 and var_74_13 < var_74_19 then
					arg_71_1.talkMaxDuration = var_74_19

					if var_74_19 + var_74_12 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_19 + var_74_12
					end
				end

				arg_71_1.text_.text = var_74_16
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101017", "story_v_out_103101.awb") ~= 0 then
					local var_74_20 = manager.audio:GetVoiceLength("story_v_out_103101", "103101017", "story_v_out_103101.awb") / 1000

					if var_74_20 + var_74_12 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_20 + var_74_12
					end

					if var_74_15.prefab_name ~= "" and arg_71_1.actors_[var_74_15.prefab_name] ~= nil then
						local var_74_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_15.prefab_name].transform, "story_v_out_103101", "103101017", "story_v_out_103101.awb")

						arg_71_1:RecordAudio("103101017", var_74_21)
						arg_71_1:RecordAudio("103101017", var_74_21)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_103101", "103101017", "story_v_out_103101.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_103101", "103101017", "story_v_out_103101.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_22 = math.max(var_74_13, arg_71_1.talkMaxDuration)

			if var_74_12 <= arg_71_1.time_ and arg_71_1.time_ < var_74_12 + var_74_22 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_12) / var_74_22

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_12 + var_74_22 and arg_71_1.time_ < var_74_12 + var_74_22 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play103101018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 103101018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play103101019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1036ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1036ui_story == nil then
				arg_75_1.var_.characterEffect1036ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.1

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1036ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1036ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1036ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1036ui_story.fillRatio = var_78_5
			end

			local var_78_6 = arg_75_1.actors_["1036ui_story"].transform
			local var_78_7 = 0

			if var_78_7 < arg_75_1.time_ and arg_75_1.time_ <= var_78_7 + arg_78_0 then
				arg_75_1.var_.moveOldPos1036ui_story = var_78_6.localPosition
			end

			local var_78_8 = 0.001

			if var_78_7 <= arg_75_1.time_ and arg_75_1.time_ < var_78_7 + var_78_8 then
				local var_78_9 = (arg_75_1.time_ - var_78_7) / var_78_8
				local var_78_10 = Vector3.New(0, 100, 0)

				var_78_6.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1036ui_story, var_78_10, var_78_9)

				local var_78_11 = manager.ui.mainCamera.transform.position - var_78_6.position

				var_78_6.forward = Vector3.New(var_78_11.x, var_78_11.y, var_78_11.z)

				local var_78_12 = var_78_6.localEulerAngles

				var_78_12.z = 0
				var_78_12.x = 0
				var_78_6.localEulerAngles = var_78_12
			end

			if arg_75_1.time_ >= var_78_7 + var_78_8 and arg_75_1.time_ < var_78_7 + var_78_8 + arg_78_0 then
				var_78_6.localPosition = Vector3.New(0, 100, 0)

				local var_78_13 = manager.ui.mainCamera.transform.position - var_78_6.position

				var_78_6.forward = Vector3.New(var_78_13.x, var_78_13.y, var_78_13.z)

				local var_78_14 = var_78_6.localEulerAngles

				var_78_14.z = 0
				var_78_14.x = 0
				var_78_6.localEulerAngles = var_78_14
			end

			local var_78_15 = arg_75_1.actors_["4010ui_story"].transform
			local var_78_16 = 0

			if var_78_16 < arg_75_1.time_ and arg_75_1.time_ <= var_78_16 + arg_78_0 then
				arg_75_1.var_.moveOldPos4010ui_story = var_78_15.localPosition
			end

			local var_78_17 = 0.001

			if var_78_16 <= arg_75_1.time_ and arg_75_1.time_ < var_78_16 + var_78_17 then
				local var_78_18 = (arg_75_1.time_ - var_78_16) / var_78_17
				local var_78_19 = Vector3.New(0, 100, 0)

				var_78_15.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos4010ui_story, var_78_19, var_78_18)

				local var_78_20 = manager.ui.mainCamera.transform.position - var_78_15.position

				var_78_15.forward = Vector3.New(var_78_20.x, var_78_20.y, var_78_20.z)

				local var_78_21 = var_78_15.localEulerAngles

				var_78_21.z = 0
				var_78_21.x = 0
				var_78_15.localEulerAngles = var_78_21
			end

			if arg_75_1.time_ >= var_78_16 + var_78_17 and arg_75_1.time_ < var_78_16 + var_78_17 + arg_78_0 then
				var_78_15.localPosition = Vector3.New(0, 100, 0)

				local var_78_22 = manager.ui.mainCamera.transform.position - var_78_15.position

				var_78_15.forward = Vector3.New(var_78_22.x, var_78_22.y, var_78_22.z)

				local var_78_23 = var_78_15.localEulerAngles

				var_78_23.z = 0
				var_78_23.x = 0
				var_78_15.localEulerAngles = var_78_23
			end

			local var_78_24 = 0
			local var_78_25 = 0.5

			if var_78_24 < arg_75_1.time_ and arg_75_1.time_ <= var_78_24 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_26 = arg_75_1:GetWordFromCfg(103101018)
				local var_78_27 = arg_75_1:FormatText(var_78_26.content)

				arg_75_1.text_.text = var_78_27

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_28 = 20
				local var_78_29 = utf8.len(var_78_27)
				local var_78_30 = var_78_28 <= 0 and var_78_25 or var_78_25 * (var_78_29 / var_78_28)

				if var_78_30 > 0 and var_78_25 < var_78_30 then
					arg_75_1.talkMaxDuration = var_78_30

					if var_78_30 + var_78_24 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_30 + var_78_24
					end
				end

				arg_75_1.text_.text = var_78_27
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_31 = math.max(var_78_25, arg_75_1.talkMaxDuration)

			if var_78_24 <= arg_75_1.time_ and arg_75_1.time_ < var_78_24 + var_78_31 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_24) / var_78_31

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_24 + var_78_31 and arg_75_1.time_ < var_78_24 + var_78_31 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
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

		arg_75_1:InitPlayNodeList()
	end,
	Play103101019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 103101019
		arg_79_1.duration_ = 10.57

		local var_79_0 = {
			ja = 10.566,
			ko = 6.066,
			zh = 6.066,
			en = 5.4
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
				arg_79_0:Play103101020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1036ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1036ui_story == nil then
				arg_79_1.var_.characterEffect1036ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.1

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect1036ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1036ui_story then
				arg_79_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_82_4 = arg_79_1.actors_["4010ui_story"]
			local var_82_5 = 0

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect4010ui_story == nil then
				arg_79_1.var_.characterEffect4010ui_story = var_82_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_6 = 0.1

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_6 and not isNil(var_82_4) then
				local var_82_7 = (arg_79_1.time_ - var_82_5) / var_82_6

				if arg_79_1.var_.characterEffect4010ui_story and not isNil(var_82_4) then
					local var_82_8 = Mathf.Lerp(0, 0.5, var_82_7)

					arg_79_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_79_1.var_.characterEffect4010ui_story.fillRatio = var_82_8
				end
			end

			if arg_79_1.time_ >= var_82_5 + var_82_6 and arg_79_1.time_ < var_82_5 + var_82_6 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect4010ui_story then
				local var_82_9 = 0.5

				arg_79_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_79_1.var_.characterEffect4010ui_story.fillRatio = var_82_9
			end

			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 then
				arg_79_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			local var_82_11 = arg_79_1.actors_["1036ui_story"].transform
			local var_82_12 = 0

			if var_82_12 < arg_79_1.time_ and arg_79_1.time_ <= var_82_12 + arg_82_0 then
				arg_79_1.var_.moveOldPos1036ui_story = var_82_11.localPosition
			end

			local var_82_13 = 0.001

			if var_82_12 <= arg_79_1.time_ and arg_79_1.time_ < var_82_12 + var_82_13 then
				local var_82_14 = (arg_79_1.time_ - var_82_12) / var_82_13
				local var_82_15 = Vector3.New(-0.7, -1.09, -5.78)

				var_82_11.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1036ui_story, var_82_15, var_82_14)

				local var_82_16 = manager.ui.mainCamera.transform.position - var_82_11.position

				var_82_11.forward = Vector3.New(var_82_16.x, var_82_16.y, var_82_16.z)

				local var_82_17 = var_82_11.localEulerAngles

				var_82_17.z = 0
				var_82_17.x = 0
				var_82_11.localEulerAngles = var_82_17
			end

			if arg_79_1.time_ >= var_82_12 + var_82_13 and arg_79_1.time_ < var_82_12 + var_82_13 + arg_82_0 then
				var_82_11.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_82_18 = manager.ui.mainCamera.transform.position - var_82_11.position

				var_82_11.forward = Vector3.New(var_82_18.x, var_82_18.y, var_82_18.z)

				local var_82_19 = var_82_11.localEulerAngles

				var_82_19.z = 0
				var_82_19.x = 0
				var_82_11.localEulerAngles = var_82_19
			end

			local var_82_20 = 0

			if var_82_20 < arg_79_1.time_ and arg_79_1.time_ <= var_82_20 + arg_82_0 then
				arg_79_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_82_21 = 0
			local var_82_22 = 0.75

			if var_82_21 < arg_79_1.time_ and arg_79_1.time_ <= var_82_21 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_23 = arg_79_1:FormatText(StoryNameCfg[5].name)

				arg_79_1.leftNameTxt_.text = var_82_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_24 = arg_79_1:GetWordFromCfg(103101019)
				local var_82_25 = arg_79_1:FormatText(var_82_24.content)

				arg_79_1.text_.text = var_82_25

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_26 = 30
				local var_82_27 = utf8.len(var_82_25)
				local var_82_28 = var_82_26 <= 0 and var_82_22 or var_82_22 * (var_82_27 / var_82_26)

				if var_82_28 > 0 and var_82_22 < var_82_28 then
					arg_79_1.talkMaxDuration = var_82_28

					if var_82_28 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_28 + var_82_21
					end
				end

				arg_79_1.text_.text = var_82_25
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101019", "story_v_out_103101.awb") ~= 0 then
					local var_82_29 = manager.audio:GetVoiceLength("story_v_out_103101", "103101019", "story_v_out_103101.awb") / 1000

					if var_82_29 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_29 + var_82_21
					end

					if var_82_24.prefab_name ~= "" and arg_79_1.actors_[var_82_24.prefab_name] ~= nil then
						local var_82_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_24.prefab_name].transform, "story_v_out_103101", "103101019", "story_v_out_103101.awb")

						arg_79_1:RecordAudio("103101019", var_82_30)
						arg_79_1:RecordAudio("103101019", var_82_30)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_103101", "103101019", "story_v_out_103101.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_103101", "103101019", "story_v_out_103101.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_31 = math.max(var_82_22, arg_79_1.talkMaxDuration)

			if var_82_21 <= arg_79_1.time_ and arg_79_1.time_ < var_82_21 + var_82_31 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_21) / var_82_31

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_21 + var_82_31 and arg_79_1.time_ < var_82_21 + var_82_31 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play103101020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 103101020
		arg_83_1.duration_ = 13.97

		local var_83_0 = {
			ja = 13.966,
			ko = 7.766,
			zh = 10.7,
			en = 7.3
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play103101021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["4010ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect4010ui_story == nil then
				arg_83_1.var_.characterEffect4010ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.1

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect4010ui_story and not isNil(var_86_0) then
					arg_83_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect4010ui_story then
				arg_83_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_86_4 = arg_83_1.actors_["1036ui_story"]
			local var_86_5 = 0

			if var_86_5 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 and not isNil(var_86_4) and arg_83_1.var_.characterEffect1036ui_story == nil then
				arg_83_1.var_.characterEffect1036ui_story = var_86_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_6 = 0.1

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_6 and not isNil(var_86_4) then
				local var_86_7 = (arg_83_1.time_ - var_86_5) / var_86_6

				if arg_83_1.var_.characterEffect1036ui_story and not isNil(var_86_4) then
					local var_86_8 = Mathf.Lerp(0, 0.5, var_86_7)

					arg_83_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1036ui_story.fillRatio = var_86_8
				end
			end

			if arg_83_1.time_ >= var_86_5 + var_86_6 and arg_83_1.time_ < var_86_5 + var_86_6 + arg_86_0 and not isNil(var_86_4) and arg_83_1.var_.characterEffect1036ui_story then
				local var_86_9 = 0.5

				arg_83_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1036ui_story.fillRatio = var_86_9
			end

			local var_86_10 = arg_83_1.actors_["4010ui_story"].transform
			local var_86_11 = 0

			if var_86_11 < arg_83_1.time_ and arg_83_1.time_ <= var_86_11 + arg_86_0 then
				arg_83_1.var_.moveOldPos4010ui_story = var_86_10.localPosition
			end

			local var_86_12 = 0.001

			if var_86_11 <= arg_83_1.time_ and arg_83_1.time_ < var_86_11 + var_86_12 then
				local var_86_13 = (arg_83_1.time_ - var_86_11) / var_86_12
				local var_86_14 = Vector3.New(0.7, -1.59, -5.2)

				var_86_10.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos4010ui_story, var_86_14, var_86_13)

				local var_86_15 = manager.ui.mainCamera.transform.position - var_86_10.position

				var_86_10.forward = Vector3.New(var_86_15.x, var_86_15.y, var_86_15.z)

				local var_86_16 = var_86_10.localEulerAngles

				var_86_16.z = 0
				var_86_16.x = 0
				var_86_10.localEulerAngles = var_86_16
			end

			if arg_83_1.time_ >= var_86_11 + var_86_12 and arg_83_1.time_ < var_86_11 + var_86_12 + arg_86_0 then
				var_86_10.localPosition = Vector3.New(0.7, -1.59, -5.2)

				local var_86_17 = manager.ui.mainCamera.transform.position - var_86_10.position

				var_86_10.forward = Vector3.New(var_86_17.x, var_86_17.y, var_86_17.z)

				local var_86_18 = var_86_10.localEulerAngles

				var_86_18.z = 0
				var_86_18.x = 0
				var_86_10.localEulerAngles = var_86_18
			end

			local var_86_19 = 0

			if var_86_19 < arg_83_1.time_ and arg_83_1.time_ <= var_86_19 + arg_86_0 then
				arg_83_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_86_20 = 0

			if var_86_20 < arg_83_1.time_ and arg_83_1.time_ <= var_86_20 + arg_86_0 then
				arg_83_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_86_21 = 0
			local var_86_22 = 0.85

			if var_86_21 < arg_83_1.time_ and arg_83_1.time_ <= var_86_21 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_23 = arg_83_1:FormatText(StoryNameCfg[42].name)

				arg_83_1.leftNameTxt_.text = var_86_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_24 = arg_83_1:GetWordFromCfg(103101020)
				local var_86_25 = arg_83_1:FormatText(var_86_24.content)

				arg_83_1.text_.text = var_86_25

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_26 = 34
				local var_86_27 = utf8.len(var_86_25)
				local var_86_28 = var_86_26 <= 0 and var_86_22 or var_86_22 * (var_86_27 / var_86_26)

				if var_86_28 > 0 and var_86_22 < var_86_28 then
					arg_83_1.talkMaxDuration = var_86_28

					if var_86_28 + var_86_21 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_28 + var_86_21
					end
				end

				arg_83_1.text_.text = var_86_25
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101020", "story_v_out_103101.awb") ~= 0 then
					local var_86_29 = manager.audio:GetVoiceLength("story_v_out_103101", "103101020", "story_v_out_103101.awb") / 1000

					if var_86_29 + var_86_21 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_29 + var_86_21
					end

					if var_86_24.prefab_name ~= "" and arg_83_1.actors_[var_86_24.prefab_name] ~= nil then
						local var_86_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_24.prefab_name].transform, "story_v_out_103101", "103101020", "story_v_out_103101.awb")

						arg_83_1:RecordAudio("103101020", var_86_30)
						arg_83_1:RecordAudio("103101020", var_86_30)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_103101", "103101020", "story_v_out_103101.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_103101", "103101020", "story_v_out_103101.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_31 = math.max(var_86_22, arg_83_1.talkMaxDuration)

			if var_86_21 <= arg_83_1.time_ and arg_83_1.time_ < var_86_21 + var_86_31 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_21) / var_86_31

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_21 + var_86_31 and arg_83_1.time_ < var_86_21 + var_86_31 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play103101021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 103101021
		arg_87_1.duration_ = 2

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play103101022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1036ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1036ui_story == nil then
				arg_87_1.var_.characterEffect1036ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.1

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect1036ui_story and not isNil(var_90_0) then
					arg_87_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1036ui_story then
				arg_87_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_90_4 = arg_87_1.actors_["4010ui_story"]
			local var_90_5 = 0

			if var_90_5 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.characterEffect4010ui_story == nil then
				arg_87_1.var_.characterEffect4010ui_story = var_90_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_6 = 0.1

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_6 and not isNil(var_90_4) then
				local var_90_7 = (arg_87_1.time_ - var_90_5) / var_90_6

				if arg_87_1.var_.characterEffect4010ui_story and not isNil(var_90_4) then
					local var_90_8 = Mathf.Lerp(0, 0.5, var_90_7)

					arg_87_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_87_1.var_.characterEffect4010ui_story.fillRatio = var_90_8
				end
			end

			if arg_87_1.time_ >= var_90_5 + var_90_6 and arg_87_1.time_ < var_90_5 + var_90_6 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.characterEffect4010ui_story then
				local var_90_9 = 0.5

				arg_87_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_87_1.var_.characterEffect4010ui_story.fillRatio = var_90_9
			end

			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 then
				arg_87_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action445")
			end

			local var_90_11 = 0

			if var_90_11 < arg_87_1.time_ and arg_87_1.time_ <= var_90_11 + arg_90_0 then
				arg_87_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_90_12 = 0
			local var_90_13 = 0.05

			if var_90_12 < arg_87_1.time_ and arg_87_1.time_ <= var_90_12 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_14 = arg_87_1:FormatText(StoryNameCfg[5].name)

				arg_87_1.leftNameTxt_.text = var_90_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_15 = arg_87_1:GetWordFromCfg(103101021)
				local var_90_16 = arg_87_1:FormatText(var_90_15.content)

				arg_87_1.text_.text = var_90_16

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_17 = 2
				local var_90_18 = utf8.len(var_90_16)
				local var_90_19 = var_90_17 <= 0 and var_90_13 or var_90_13 * (var_90_18 / var_90_17)

				if var_90_19 > 0 and var_90_13 < var_90_19 then
					arg_87_1.talkMaxDuration = var_90_19

					if var_90_19 + var_90_12 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_19 + var_90_12
					end
				end

				arg_87_1.text_.text = var_90_16
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101021", "story_v_out_103101.awb") ~= 0 then
					local var_90_20 = manager.audio:GetVoiceLength("story_v_out_103101", "103101021", "story_v_out_103101.awb") / 1000

					if var_90_20 + var_90_12 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_20 + var_90_12
					end

					if var_90_15.prefab_name ~= "" and arg_87_1.actors_[var_90_15.prefab_name] ~= nil then
						local var_90_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_15.prefab_name].transform, "story_v_out_103101", "103101021", "story_v_out_103101.awb")

						arg_87_1:RecordAudio("103101021", var_90_21)
						arg_87_1:RecordAudio("103101021", var_90_21)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_103101", "103101021", "story_v_out_103101.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_103101", "103101021", "story_v_out_103101.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_22 = math.max(var_90_13, arg_87_1.talkMaxDuration)

			if var_90_12 <= arg_87_1.time_ and arg_87_1.time_ < var_90_12 + var_90_22 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_12) / var_90_22

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_12 + var_90_22 and arg_87_1.time_ < var_90_12 + var_90_22 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play103101022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 103101022
		arg_91_1.duration_ = 3.63

		local var_91_0 = {
			ja = 3.633,
			ko = 2.4,
			zh = 3.166,
			en = 2.5
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
				arg_91_0:Play103101023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["4010ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect4010ui_story == nil then
				arg_91_1.var_.characterEffect4010ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.1

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect4010ui_story and not isNil(var_94_0) then
					arg_91_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect4010ui_story then
				arg_91_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_94_4 = arg_91_1.actors_["1036ui_story"]
			local var_94_5 = 0

			if var_94_5 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 and not isNil(var_94_4) and arg_91_1.var_.characterEffect1036ui_story == nil then
				arg_91_1.var_.characterEffect1036ui_story = var_94_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_6 = 0.1

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_6 and not isNil(var_94_4) then
				local var_94_7 = (arg_91_1.time_ - var_94_5) / var_94_6

				if arg_91_1.var_.characterEffect1036ui_story and not isNil(var_94_4) then
					local var_94_8 = Mathf.Lerp(0, 0.5, var_94_7)

					arg_91_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1036ui_story.fillRatio = var_94_8
				end
			end

			if arg_91_1.time_ >= var_94_5 + var_94_6 and arg_91_1.time_ < var_94_5 + var_94_6 + arg_94_0 and not isNil(var_94_4) and arg_91_1.var_.characterEffect1036ui_story then
				local var_94_9 = 0.5

				arg_91_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1036ui_story.fillRatio = var_94_9
			end

			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 then
				arg_91_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_94_11 = 0
			local var_94_12 = 0.3

			if var_94_11 < arg_91_1.time_ and arg_91_1.time_ <= var_94_11 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_13 = arg_91_1:FormatText(StoryNameCfg[42].name)

				arg_91_1.leftNameTxt_.text = var_94_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_14 = arg_91_1:GetWordFromCfg(103101022)
				local var_94_15 = arg_91_1:FormatText(var_94_14.content)

				arg_91_1.text_.text = var_94_15

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_16 = 12
				local var_94_17 = utf8.len(var_94_15)
				local var_94_18 = var_94_16 <= 0 and var_94_12 or var_94_12 * (var_94_17 / var_94_16)

				if var_94_18 > 0 and var_94_12 < var_94_18 then
					arg_91_1.talkMaxDuration = var_94_18

					if var_94_18 + var_94_11 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_18 + var_94_11
					end
				end

				arg_91_1.text_.text = var_94_15
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101022", "story_v_out_103101.awb") ~= 0 then
					local var_94_19 = manager.audio:GetVoiceLength("story_v_out_103101", "103101022", "story_v_out_103101.awb") / 1000

					if var_94_19 + var_94_11 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_19 + var_94_11
					end

					if var_94_14.prefab_name ~= "" and arg_91_1.actors_[var_94_14.prefab_name] ~= nil then
						local var_94_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_14.prefab_name].transform, "story_v_out_103101", "103101022", "story_v_out_103101.awb")

						arg_91_1:RecordAudio("103101022", var_94_20)
						arg_91_1:RecordAudio("103101022", var_94_20)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_103101", "103101022", "story_v_out_103101.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_103101", "103101022", "story_v_out_103101.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_21 = math.max(var_94_12, arg_91_1.talkMaxDuration)

			if var_94_11 <= arg_91_1.time_ and arg_91_1.time_ < var_94_11 + var_94_21 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_11) / var_94_21

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_11 + var_94_21 and arg_91_1.time_ < var_94_11 + var_94_21 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play103101023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 103101023
		arg_95_1.duration_ = 5.33

		local var_95_0 = {
			ja = 5.333,
			ko = 3.533,
			zh = 3.6,
			en = 4.633
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play103101024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1036ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1036ui_story == nil then
				arg_95_1.var_.characterEffect1036ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.1

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1036ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1036ui_story then
				arg_95_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_98_4 = arg_95_1.actors_["4010ui_story"]
			local var_98_5 = 0

			if var_98_5 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 and not isNil(var_98_4) and arg_95_1.var_.characterEffect4010ui_story == nil then
				arg_95_1.var_.characterEffect4010ui_story = var_98_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_6 = 0.1

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_6 and not isNil(var_98_4) then
				local var_98_7 = (arg_95_1.time_ - var_98_5) / var_98_6

				if arg_95_1.var_.characterEffect4010ui_story and not isNil(var_98_4) then
					local var_98_8 = Mathf.Lerp(0, 0.5, var_98_7)

					arg_95_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_95_1.var_.characterEffect4010ui_story.fillRatio = var_98_8
				end
			end

			if arg_95_1.time_ >= var_98_5 + var_98_6 and arg_95_1.time_ < var_98_5 + var_98_6 + arg_98_0 and not isNil(var_98_4) and arg_95_1.var_.characterEffect4010ui_story then
				local var_98_9 = 0.5

				arg_95_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_95_1.var_.characterEffect4010ui_story.fillRatio = var_98_9
			end

			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 then
				arg_95_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action453")
			end

			local var_98_11 = 0

			if var_98_11 < arg_95_1.time_ and arg_95_1.time_ <= var_98_11 + arg_98_0 then
				arg_95_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_98_12 = 0
			local var_98_13 = 0.45

			if var_98_12 < arg_95_1.time_ and arg_95_1.time_ <= var_98_12 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_14 = arg_95_1:FormatText(StoryNameCfg[5].name)

				arg_95_1.leftNameTxt_.text = var_98_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_15 = arg_95_1:GetWordFromCfg(103101023)
				local var_98_16 = arg_95_1:FormatText(var_98_15.content)

				arg_95_1.text_.text = var_98_16

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_17 = 18
				local var_98_18 = utf8.len(var_98_16)
				local var_98_19 = var_98_17 <= 0 and var_98_13 or var_98_13 * (var_98_18 / var_98_17)

				if var_98_19 > 0 and var_98_13 < var_98_19 then
					arg_95_1.talkMaxDuration = var_98_19

					if var_98_19 + var_98_12 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_19 + var_98_12
					end
				end

				arg_95_1.text_.text = var_98_16
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101023", "story_v_out_103101.awb") ~= 0 then
					local var_98_20 = manager.audio:GetVoiceLength("story_v_out_103101", "103101023", "story_v_out_103101.awb") / 1000

					if var_98_20 + var_98_12 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_20 + var_98_12
					end

					if var_98_15.prefab_name ~= "" and arg_95_1.actors_[var_98_15.prefab_name] ~= nil then
						local var_98_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_15.prefab_name].transform, "story_v_out_103101", "103101023", "story_v_out_103101.awb")

						arg_95_1:RecordAudio("103101023", var_98_21)
						arg_95_1:RecordAudio("103101023", var_98_21)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_103101", "103101023", "story_v_out_103101.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_103101", "103101023", "story_v_out_103101.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_22 = math.max(var_98_13, arg_95_1.talkMaxDuration)

			if var_98_12 <= arg_95_1.time_ and arg_95_1.time_ < var_98_12 + var_98_22 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_12) / var_98_22

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_12 + var_98_22 and arg_95_1.time_ < var_98_12 + var_98_22 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play103101024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 103101024
		arg_99_1.duration_ = 3.33

		local var_99_0 = {
			ja = 2.933,
			ko = 1.999999999999,
			zh = 3.333,
			en = 1.999999999999
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
				arg_99_0:Play103101025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["4010ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect4010ui_story == nil then
				arg_99_1.var_.characterEffect4010ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.1

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect4010ui_story and not isNil(var_102_0) then
					arg_99_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect4010ui_story then
				arg_99_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_102_4 = arg_99_1.actors_["1036ui_story"]
			local var_102_5 = 0

			if var_102_5 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.characterEffect1036ui_story == nil then
				arg_99_1.var_.characterEffect1036ui_story = var_102_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_6 = 0.1

			if var_102_5 <= arg_99_1.time_ and arg_99_1.time_ < var_102_5 + var_102_6 and not isNil(var_102_4) then
				local var_102_7 = (arg_99_1.time_ - var_102_5) / var_102_6

				if arg_99_1.var_.characterEffect1036ui_story and not isNil(var_102_4) then
					local var_102_8 = Mathf.Lerp(0, 0.5, var_102_7)

					arg_99_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1036ui_story.fillRatio = var_102_8
				end
			end

			if arg_99_1.time_ >= var_102_5 + var_102_6 and arg_99_1.time_ < var_102_5 + var_102_6 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.characterEffect1036ui_story then
				local var_102_9 = 0.5

				arg_99_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1036ui_story.fillRatio = var_102_9
			end

			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 then
				arg_99_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_102_11 = 0
			local var_102_12 = 0.15

			if var_102_11 < arg_99_1.time_ and arg_99_1.time_ <= var_102_11 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_13 = arg_99_1:FormatText(StoryNameCfg[42].name)

				arg_99_1.leftNameTxt_.text = var_102_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_14 = arg_99_1:GetWordFromCfg(103101024)
				local var_102_15 = arg_99_1:FormatText(var_102_14.content)

				arg_99_1.text_.text = var_102_15

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_16 = 6
				local var_102_17 = utf8.len(var_102_15)
				local var_102_18 = var_102_16 <= 0 and var_102_12 or var_102_12 * (var_102_17 / var_102_16)

				if var_102_18 > 0 and var_102_12 < var_102_18 then
					arg_99_1.talkMaxDuration = var_102_18

					if var_102_18 + var_102_11 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_18 + var_102_11
					end
				end

				arg_99_1.text_.text = var_102_15
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101024", "story_v_out_103101.awb") ~= 0 then
					local var_102_19 = manager.audio:GetVoiceLength("story_v_out_103101", "103101024", "story_v_out_103101.awb") / 1000

					if var_102_19 + var_102_11 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_19 + var_102_11
					end

					if var_102_14.prefab_name ~= "" and arg_99_1.actors_[var_102_14.prefab_name] ~= nil then
						local var_102_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_14.prefab_name].transform, "story_v_out_103101", "103101024", "story_v_out_103101.awb")

						arg_99_1:RecordAudio("103101024", var_102_20)
						arg_99_1:RecordAudio("103101024", var_102_20)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_103101", "103101024", "story_v_out_103101.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_103101", "103101024", "story_v_out_103101.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_21 = math.max(var_102_12, arg_99_1.talkMaxDuration)

			if var_102_11 <= arg_99_1.time_ and arg_99_1.time_ < var_102_11 + var_102_21 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_11) / var_102_21

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_11 + var_102_21 and arg_99_1.time_ < var_102_11 + var_102_21 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play103101025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 103101025
		arg_103_1.duration_ = 5.17

		local var_103_0 = {
			ja = 3.1,
			ko = 3.666,
			zh = 3.9,
			en = 5.166
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play103101026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1036ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1036ui_story == nil then
				arg_103_1.var_.characterEffect1036ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.1

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1036ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1036ui_story then
				arg_103_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_106_4 = arg_103_1.actors_["4010ui_story"]
			local var_106_5 = 0

			if var_106_5 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 and not isNil(var_106_4) and arg_103_1.var_.characterEffect4010ui_story == nil then
				arg_103_1.var_.characterEffect4010ui_story = var_106_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_6 = 0.1

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_6 and not isNil(var_106_4) then
				local var_106_7 = (arg_103_1.time_ - var_106_5) / var_106_6

				if arg_103_1.var_.characterEffect4010ui_story and not isNil(var_106_4) then
					local var_106_8 = Mathf.Lerp(0, 0.5, var_106_7)

					arg_103_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_103_1.var_.characterEffect4010ui_story.fillRatio = var_106_8
				end
			end

			if arg_103_1.time_ >= var_106_5 + var_106_6 and arg_103_1.time_ < var_106_5 + var_106_6 + arg_106_0 and not isNil(var_106_4) and arg_103_1.var_.characterEffect4010ui_story then
				local var_106_9 = 0.5

				arg_103_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_103_1.var_.characterEffect4010ui_story.fillRatio = var_106_9
			end

			local var_106_10 = 0

			if var_106_10 < arg_103_1.time_ and arg_103_1.time_ <= var_106_10 + arg_106_0 then
				arg_103_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action432")
			end

			local var_106_11 = 0

			if var_106_11 < arg_103_1.time_ and arg_103_1.time_ <= var_106_11 + arg_106_0 then
				arg_103_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_106_12 = 0
			local var_106_13 = 0.25

			if var_106_12 < arg_103_1.time_ and arg_103_1.time_ <= var_106_12 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_14 = arg_103_1:FormatText(StoryNameCfg[5].name)

				arg_103_1.leftNameTxt_.text = var_106_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_15 = arg_103_1:GetWordFromCfg(103101025)
				local var_106_16 = arg_103_1:FormatText(var_106_15.content)

				arg_103_1.text_.text = var_106_16

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_17 = 10
				local var_106_18 = utf8.len(var_106_16)
				local var_106_19 = var_106_17 <= 0 and var_106_13 or var_106_13 * (var_106_18 / var_106_17)

				if var_106_19 > 0 and var_106_13 < var_106_19 then
					arg_103_1.talkMaxDuration = var_106_19

					if var_106_19 + var_106_12 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_19 + var_106_12
					end
				end

				arg_103_1.text_.text = var_106_16
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101025", "story_v_out_103101.awb") ~= 0 then
					local var_106_20 = manager.audio:GetVoiceLength("story_v_out_103101", "103101025", "story_v_out_103101.awb") / 1000

					if var_106_20 + var_106_12 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_20 + var_106_12
					end

					if var_106_15.prefab_name ~= "" and arg_103_1.actors_[var_106_15.prefab_name] ~= nil then
						local var_106_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_15.prefab_name].transform, "story_v_out_103101", "103101025", "story_v_out_103101.awb")

						arg_103_1:RecordAudio("103101025", var_106_21)
						arg_103_1:RecordAudio("103101025", var_106_21)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_103101", "103101025", "story_v_out_103101.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_103101", "103101025", "story_v_out_103101.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_22 = math.max(var_106_13, arg_103_1.talkMaxDuration)

			if var_106_12 <= arg_103_1.time_ and arg_103_1.time_ < var_106_12 + var_106_22 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_12) / var_106_22

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_12 + var_106_22 and arg_103_1.time_ < var_106_12 + var_106_22 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play103101026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 103101026
		arg_107_1.duration_ = 2

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play103101027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["4010ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect4010ui_story == nil then
				arg_107_1.var_.characterEffect4010ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.1

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect4010ui_story and not isNil(var_110_0) then
					arg_107_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect4010ui_story then
				arg_107_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_110_4 = arg_107_1.actors_["1036ui_story"]
			local var_110_5 = 0

			if var_110_5 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect1036ui_story == nil then
				arg_107_1.var_.characterEffect1036ui_story = var_110_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_6 = 0.1

			if var_110_5 <= arg_107_1.time_ and arg_107_1.time_ < var_110_5 + var_110_6 and not isNil(var_110_4) then
				local var_110_7 = (arg_107_1.time_ - var_110_5) / var_110_6

				if arg_107_1.var_.characterEffect1036ui_story and not isNil(var_110_4) then
					local var_110_8 = Mathf.Lerp(0, 0.5, var_110_7)

					arg_107_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1036ui_story.fillRatio = var_110_8
				end
			end

			if arg_107_1.time_ >= var_110_5 + var_110_6 and arg_107_1.time_ < var_110_5 + var_110_6 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect1036ui_story then
				local var_110_9 = 0.5

				arg_107_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1036ui_story.fillRatio = var_110_9
			end

			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 then
				arg_107_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_110_11 = 0
			local var_110_12 = 0.05

			if var_110_11 < arg_107_1.time_ and arg_107_1.time_ <= var_110_11 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_13 = arg_107_1:FormatText(StoryNameCfg[42].name)

				arg_107_1.leftNameTxt_.text = var_110_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_14 = arg_107_1:GetWordFromCfg(103101026)
				local var_110_15 = arg_107_1:FormatText(var_110_14.content)

				arg_107_1.text_.text = var_110_15

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_16 = 2
				local var_110_17 = utf8.len(var_110_15)
				local var_110_18 = var_110_16 <= 0 and var_110_12 or var_110_12 * (var_110_17 / var_110_16)

				if var_110_18 > 0 and var_110_12 < var_110_18 then
					arg_107_1.talkMaxDuration = var_110_18

					if var_110_18 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_18 + var_110_11
					end
				end

				arg_107_1.text_.text = var_110_15
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101026", "story_v_out_103101.awb") ~= 0 then
					local var_110_19 = manager.audio:GetVoiceLength("story_v_out_103101", "103101026", "story_v_out_103101.awb") / 1000

					if var_110_19 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_19 + var_110_11
					end

					if var_110_14.prefab_name ~= "" and arg_107_1.actors_[var_110_14.prefab_name] ~= nil then
						local var_110_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_14.prefab_name].transform, "story_v_out_103101", "103101026", "story_v_out_103101.awb")

						arg_107_1:RecordAudio("103101026", var_110_20)
						arg_107_1:RecordAudio("103101026", var_110_20)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_103101", "103101026", "story_v_out_103101.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_103101", "103101026", "story_v_out_103101.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_21 = math.max(var_110_12, arg_107_1.talkMaxDuration)

			if var_110_11 <= arg_107_1.time_ and arg_107_1.time_ < var_110_11 + var_110_21 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_11) / var_110_21

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_11 + var_110_21 and arg_107_1.time_ < var_110_11 + var_110_21 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play103101027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 103101027
		arg_111_1.duration_ = 12.77

		local var_111_0 = {
			ja = 11.1,
			ko = 11.866,
			zh = 8.8,
			en = 12.766
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
				arg_111_0:Play103101028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["4010ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos4010ui_story = var_114_0.localPosition
			end

			local var_114_2 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2
				local var_114_4 = Vector3.New(0, 100, 0)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos4010ui_story, var_114_4, var_114_3)

				local var_114_5 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_5.x, var_114_5.y, var_114_5.z)

				local var_114_6 = var_114_0.localEulerAngles

				var_114_6.z = 0
				var_114_6.x = 0
				var_114_0.localEulerAngles = var_114_6
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0, 100, 0)

				local var_114_7 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_7.x, var_114_7.y, var_114_7.z)

				local var_114_8 = var_114_0.localEulerAngles

				var_114_8.z = 0
				var_114_8.x = 0
				var_114_0.localEulerAngles = var_114_8
			end

			local var_114_9 = arg_111_1.actors_["1036ui_story"].transform
			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1.var_.moveOldPos1036ui_story = var_114_9.localPosition
			end

			local var_114_11 = 0.001

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_11 then
				local var_114_12 = (arg_111_1.time_ - var_114_10) / var_114_11
				local var_114_13 = Vector3.New(0, 100, 0)

				var_114_9.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1036ui_story, var_114_13, var_114_12)

				local var_114_14 = manager.ui.mainCamera.transform.position - var_114_9.position

				var_114_9.forward = Vector3.New(var_114_14.x, var_114_14.y, var_114_14.z)

				local var_114_15 = var_114_9.localEulerAngles

				var_114_15.z = 0
				var_114_15.x = 0
				var_114_9.localEulerAngles = var_114_15
			end

			if arg_111_1.time_ >= var_114_10 + var_114_11 and arg_111_1.time_ < var_114_10 + var_114_11 + arg_114_0 then
				var_114_9.localPosition = Vector3.New(0, 100, 0)

				local var_114_16 = manager.ui.mainCamera.transform.position - var_114_9.position

				var_114_9.forward = Vector3.New(var_114_16.x, var_114_16.y, var_114_16.z)

				local var_114_17 = var_114_9.localEulerAngles

				var_114_17.z = 0
				var_114_17.x = 0
				var_114_9.localEulerAngles = var_114_17
			end

			local var_114_18 = manager.ui.mainCamera.transform
			local var_114_19 = 0

			if var_114_19 < arg_111_1.time_ and arg_111_1.time_ <= var_114_19 + arg_114_0 then
				arg_111_1.var_.shakeOldPos = var_114_18.localPosition
			end

			local var_114_20 = 0.6

			if var_114_19 <= arg_111_1.time_ and arg_111_1.time_ < var_114_19 + var_114_20 then
				local var_114_21 = (arg_111_1.time_ - var_114_19) / 0.066
				local var_114_22, var_114_23 = math.modf(var_114_21)

				var_114_18.localPosition = Vector3.New(var_114_23 * 0.13, var_114_23 * 0.13, var_114_23 * 0.13) + arg_111_1.var_.shakeOldPos
			end

			if arg_111_1.time_ >= var_114_19 + var_114_20 and arg_111_1.time_ < var_114_19 + var_114_20 + arg_114_0 then
				var_114_18.localPosition = arg_111_1.var_.shakeOldPos
			end

			local var_114_24 = 0

			if var_114_24 < arg_111_1.time_ and arg_111_1.time_ <= var_114_24 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			local var_114_25 = 0.6

			if arg_111_1.time_ >= var_114_24 + var_114_25 and arg_111_1.time_ < var_114_24 + var_114_25 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			local var_114_26 = 0
			local var_114_27 = 1.125

			if var_114_26 < arg_111_1.time_ and arg_111_1.time_ <= var_114_26 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_28 = arg_111_1:FormatText(StoryNameCfg[5].name)

				arg_111_1.leftNameTxt_.text = var_114_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_29 = arg_111_1:GetWordFromCfg(103101027)
				local var_114_30 = arg_111_1:FormatText(var_114_29.content)

				arg_111_1.text_.text = var_114_30

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_31 = 45
				local var_114_32 = utf8.len(var_114_30)
				local var_114_33 = var_114_31 <= 0 and var_114_27 or var_114_27 * (var_114_32 / var_114_31)

				if var_114_33 > 0 and var_114_27 < var_114_33 then
					arg_111_1.talkMaxDuration = var_114_33

					if var_114_33 + var_114_26 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_33 + var_114_26
					end
				end

				arg_111_1.text_.text = var_114_30
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101027", "story_v_out_103101.awb") ~= 0 then
					local var_114_34 = manager.audio:GetVoiceLength("story_v_out_103101", "103101027", "story_v_out_103101.awb") / 1000

					if var_114_34 + var_114_26 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_34 + var_114_26
					end

					if var_114_29.prefab_name ~= "" and arg_111_1.actors_[var_114_29.prefab_name] ~= nil then
						local var_114_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_29.prefab_name].transform, "story_v_out_103101", "103101027", "story_v_out_103101.awb")

						arg_111_1:RecordAudio("103101027", var_114_35)
						arg_111_1:RecordAudio("103101027", var_114_35)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_103101", "103101027", "story_v_out_103101.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_103101", "103101027", "story_v_out_103101.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_36 = math.max(var_114_27, arg_111_1.talkMaxDuration)

			if var_114_26 <= arg_111_1.time_ and arg_111_1.time_ < var_114_26 + var_114_36 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_26) / var_114_36

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_26 + var_114_36 and arg_111_1.time_ < var_114_26 + var_114_36 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play103101028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 103101028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play103101029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 1

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				local var_118_2 = "play"
				local var_118_3 = "effect"

				arg_115_1:AudioAction(var_118_2, var_118_3, "se_story_3", "se_story_3_windspear", "")
			end

			local var_118_4 = 0
			local var_118_5 = 0.1

			if var_118_4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_6 = arg_115_1:GetWordFromCfg(103101028)
				local var_118_7 = arg_115_1:FormatText(var_118_6.content)

				arg_115_1.text_.text = var_118_7

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_8 = 4
				local var_118_9 = utf8.len(var_118_7)
				local var_118_10 = var_118_8 <= 0 and var_118_5 or var_118_5 * (var_118_9 / var_118_8)

				if var_118_10 > 0 and var_118_5 < var_118_10 then
					arg_115_1.talkMaxDuration = var_118_10

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_7
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_11 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_11 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_4) / var_118_11

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_4 + var_118_11 and arg_115_1.time_ < var_118_4 + var_118_11 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play103101029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 103101029
		arg_119_1.duration_ = 5.6

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play103101030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = false

				arg_119_1:SetGaussion(false)
			end

			local var_122_1 = 0.5

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_1 then
				local var_122_2 = (arg_119_1.time_ - var_122_0) / var_122_1
				local var_122_3 = Color.New(1, 1, 1)

				var_122_3.a = Mathf.Lerp(1, 0, var_122_2)
				arg_119_1.mask_.color = var_122_3
			end

			if arg_119_1.time_ >= var_122_0 + var_122_1 and arg_119_1.time_ < var_122_0 + var_122_1 + arg_122_0 then
				local var_122_4 = Color.New(1, 1, 1)
				local var_122_5 = 0

				arg_119_1.mask_.enabled = false
				var_122_4.a = var_122_5
				arg_119_1.mask_.color = var_122_4
			end

			local var_122_6 = manager.ui.mainCamera.transform
			local var_122_7 = 0.3

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 then
				arg_119_1.var_.shakeOldPosMainCamera = var_122_6.localPosition
			end

			local var_122_8 = 0.600000023841858

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_8 then
				local var_122_9 = (arg_119_1.time_ - var_122_7) / 0.066
				local var_122_10, var_122_11 = math.modf(var_122_9)

				var_122_6.localPosition = Vector3.New(var_122_11 * 0.13, var_122_11 * 0.13, var_122_11 * 0.13) + arg_119_1.var_.shakeOldPosMainCamera
			end

			if arg_119_1.time_ >= var_122_7 + var_122_8 and arg_119_1.time_ < var_122_7 + var_122_8 + arg_122_0 then
				var_122_6.localPosition = arg_119_1.var_.shakeOldPosMainCamera
			end

			local var_122_12 = 0.3

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.allBtn_.enabled = false
			end

			local var_122_13 = 0.600000023841858

			if arg_119_1.time_ >= var_122_12 + var_122_13 and arg_119_1.time_ < var_122_12 + var_122_13 + arg_122_0 then
				arg_119_1.allBtn_.enabled = true
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_14 = 0.600000023841858
			local var_122_15 = 1.25

			if var_122_14 < arg_119_1.time_ and arg_119_1.time_ <= var_122_14 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_16 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_16:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_17 = arg_119_1:GetWordFromCfg(103101029)
				local var_122_18 = arg_119_1:FormatText(var_122_17.content)

				arg_119_1.text_.text = var_122_18

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_19 = 50
				local var_122_20 = utf8.len(var_122_18)
				local var_122_21 = var_122_19 <= 0 and var_122_15 or var_122_15 * (var_122_20 / var_122_19)

				if var_122_21 > 0 and var_122_15 < var_122_21 then
					arg_119_1.talkMaxDuration = var_122_21
					var_122_14 = var_122_14 + 0.3

					if var_122_21 + var_122_14 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_21 + var_122_14
					end
				end

				arg_119_1.text_.text = var_122_18
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_22 = var_122_14 + 0.3
			local var_122_23 = math.max(var_122_15, arg_119_1.talkMaxDuration)

			if var_122_22 <= arg_119_1.time_ and arg_119_1.time_ < var_122_22 + var_122_23 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_22) / var_122_23

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_22 + var_122_23 and arg_119_1.time_ < var_122_22 + var_122_23 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play103101030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 103101030
		arg_125_1.duration_ = 2.93

		local var_125_0 = {
			ja = 2.933,
			ko = 2.9,
			zh = 2.133,
			en = 2.4
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play103101031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = "1019ui_story"

			if arg_125_1.actors_[var_128_0] == nil then
				local var_128_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_128_1) then
					local var_128_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_125_1.stage_.transform)

					var_128_2.name = var_128_0
					var_128_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_125_1.actors_[var_128_0] = var_128_2

					local var_128_3 = var_128_2:GetComponentInChildren(typeof(CharacterEffect))

					var_128_3.enabled = true

					local var_128_4 = GameObjectTools.GetOrAddComponent(var_128_2, typeof(DynamicBoneHelper))

					if var_128_4 then
						var_128_4:EnableDynamicBone(false)
					end

					arg_125_1:ShowWeapon(var_128_3.transform, false)

					arg_125_1.var_[var_128_0 .. "Animator"] = var_128_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_125_1.var_[var_128_0 .. "Animator"].applyRootMotion = true
					arg_125_1.var_[var_128_0 .. "LipSync"] = var_128_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_128_5 = arg_125_1.actors_["1019ui_story"].transform
			local var_128_6 = 0

			if var_128_6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.var_.moveOldPos1019ui_story = var_128_5.localPosition
			end

			local var_128_7 = 0.001

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_7 then
				local var_128_8 = (arg_125_1.time_ - var_128_6) / var_128_7
				local var_128_9 = Vector3.New(-0.7, -1.08, -5.9)

				var_128_5.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1019ui_story, var_128_9, var_128_8)

				local var_128_10 = manager.ui.mainCamera.transform.position - var_128_5.position

				var_128_5.forward = Vector3.New(var_128_10.x, var_128_10.y, var_128_10.z)

				local var_128_11 = var_128_5.localEulerAngles

				var_128_11.z = 0
				var_128_11.x = 0
				var_128_5.localEulerAngles = var_128_11
			end

			if arg_125_1.time_ >= var_128_6 + var_128_7 and arg_125_1.time_ < var_128_6 + var_128_7 + arg_128_0 then
				var_128_5.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_128_12 = manager.ui.mainCamera.transform.position - var_128_5.position

				var_128_5.forward = Vector3.New(var_128_12.x, var_128_12.y, var_128_12.z)

				local var_128_13 = var_128_5.localEulerAngles

				var_128_13.z = 0
				var_128_13.x = 0
				var_128_5.localEulerAngles = var_128_13
			end

			local var_128_14 = 0

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 then
				arg_125_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action4_1")
			end

			local var_128_15 = 0

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				arg_125_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_128_16 = arg_125_1.actors_["1019ui_story"]
			local var_128_17 = 0

			if var_128_17 < arg_125_1.time_ and arg_125_1.time_ <= var_128_17 + arg_128_0 and not isNil(var_128_16) and arg_125_1.var_.characterEffect1019ui_story == nil then
				arg_125_1.var_.characterEffect1019ui_story = var_128_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_18 = 0.2

			if var_128_17 <= arg_125_1.time_ and arg_125_1.time_ < var_128_17 + var_128_18 and not isNil(var_128_16) then
				local var_128_19 = (arg_125_1.time_ - var_128_17) / var_128_18

				if arg_125_1.var_.characterEffect1019ui_story and not isNil(var_128_16) then
					arg_125_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_17 + var_128_18 and arg_125_1.time_ < var_128_17 + var_128_18 + arg_128_0 and not isNil(var_128_16) and arg_125_1.var_.characterEffect1019ui_story then
				arg_125_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_128_20 = 0
			local var_128_21 = 0.2

			if var_128_20 < arg_125_1.time_ and arg_125_1.time_ <= var_128_20 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_22 = arg_125_1:FormatText(StoryNameCfg[13].name)

				arg_125_1.leftNameTxt_.text = var_128_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_23 = arg_125_1:GetWordFromCfg(103101030)
				local var_128_24 = arg_125_1:FormatText(var_128_23.content)

				arg_125_1.text_.text = var_128_24

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_25 = 8
				local var_128_26 = utf8.len(var_128_24)
				local var_128_27 = var_128_25 <= 0 and var_128_21 or var_128_21 * (var_128_26 / var_128_25)

				if var_128_27 > 0 and var_128_21 < var_128_27 then
					arg_125_1.talkMaxDuration = var_128_27

					if var_128_27 + var_128_20 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_27 + var_128_20
					end
				end

				arg_125_1.text_.text = var_128_24
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101030", "story_v_out_103101.awb") ~= 0 then
					local var_128_28 = manager.audio:GetVoiceLength("story_v_out_103101", "103101030", "story_v_out_103101.awb") / 1000

					if var_128_28 + var_128_20 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_28 + var_128_20
					end

					if var_128_23.prefab_name ~= "" and arg_125_1.actors_[var_128_23.prefab_name] ~= nil then
						local var_128_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_23.prefab_name].transform, "story_v_out_103101", "103101030", "story_v_out_103101.awb")

						arg_125_1:RecordAudio("103101030", var_128_29)
						arg_125_1:RecordAudio("103101030", var_128_29)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_103101", "103101030", "story_v_out_103101.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_103101", "103101030", "story_v_out_103101.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_30 = math.max(var_128_21, arg_125_1.talkMaxDuration)

			if var_128_20 <= arg_125_1.time_ and arg_125_1.time_ < var_128_20 + var_128_30 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_20) / var_128_30

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_20 + var_128_30 and arg_125_1.time_ < var_128_20 + var_128_30 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play103101031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 103101031
		arg_129_1.duration_ = 5.67

		local var_129_0 = {
			ja = 5.2,
			ko = 5.4,
			zh = 5.133,
			en = 5.666
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play103101032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = "1084ui_story"

			if arg_129_1.actors_[var_132_0] == nil then
				local var_132_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_132_1) then
					local var_132_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_129_1.stage_.transform)

					var_132_2.name = var_132_0
					var_132_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_129_1.actors_[var_132_0] = var_132_2

					local var_132_3 = var_132_2:GetComponentInChildren(typeof(CharacterEffect))

					var_132_3.enabled = true

					local var_132_4 = GameObjectTools.GetOrAddComponent(var_132_2, typeof(DynamicBoneHelper))

					if var_132_4 then
						var_132_4:EnableDynamicBone(false)
					end

					arg_129_1:ShowWeapon(var_132_3.transform, false)

					arg_129_1.var_[var_132_0 .. "Animator"] = var_132_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_129_1.var_[var_132_0 .. "Animator"].applyRootMotion = true
					arg_129_1.var_[var_132_0 .. "LipSync"] = var_132_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_132_5 = arg_129_1.actors_["1084ui_story"].transform
			local var_132_6 = 0

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.var_.moveOldPos1084ui_story = var_132_5.localPosition
			end

			local var_132_7 = 0.001

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_7 then
				local var_132_8 = (arg_129_1.time_ - var_132_6) / var_132_7
				local var_132_9 = Vector3.New(0.7, -0.97, -6)

				var_132_5.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1084ui_story, var_132_9, var_132_8)

				local var_132_10 = manager.ui.mainCamera.transform.position - var_132_5.position

				var_132_5.forward = Vector3.New(var_132_10.x, var_132_10.y, var_132_10.z)

				local var_132_11 = var_132_5.localEulerAngles

				var_132_11.z = 0
				var_132_11.x = 0
				var_132_5.localEulerAngles = var_132_11
			end

			if arg_129_1.time_ >= var_132_6 + var_132_7 and arg_129_1.time_ < var_132_6 + var_132_7 + arg_132_0 then
				var_132_5.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_132_12 = manager.ui.mainCamera.transform.position - var_132_5.position

				var_132_5.forward = Vector3.New(var_132_12.x, var_132_12.y, var_132_12.z)

				local var_132_13 = var_132_5.localEulerAngles

				var_132_13.z = 0
				var_132_13.x = 0
				var_132_5.localEulerAngles = var_132_13
			end

			local var_132_14 = 0

			if var_132_14 < arg_129_1.time_ and arg_129_1.time_ <= var_132_14 + arg_132_0 then
				arg_129_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_132_15 = 0

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 then
				arg_129_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_132_16 = arg_129_1.actors_["1084ui_story"]
			local var_132_17 = 0

			if var_132_17 < arg_129_1.time_ and arg_129_1.time_ <= var_132_17 + arg_132_0 and not isNil(var_132_16) and arg_129_1.var_.characterEffect1084ui_story == nil then
				arg_129_1.var_.characterEffect1084ui_story = var_132_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_18 = 0.2

			if var_132_17 <= arg_129_1.time_ and arg_129_1.time_ < var_132_17 + var_132_18 and not isNil(var_132_16) then
				local var_132_19 = (arg_129_1.time_ - var_132_17) / var_132_18

				if arg_129_1.var_.characterEffect1084ui_story and not isNil(var_132_16) then
					arg_129_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_17 + var_132_18 and arg_129_1.time_ < var_132_17 + var_132_18 + arg_132_0 and not isNil(var_132_16) and arg_129_1.var_.characterEffect1084ui_story then
				arg_129_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_132_20 = arg_129_1.actors_["1019ui_story"]
			local var_132_21 = 0

			if var_132_21 < arg_129_1.time_ and arg_129_1.time_ <= var_132_21 + arg_132_0 and not isNil(var_132_20) and arg_129_1.var_.characterEffect1019ui_story == nil then
				arg_129_1.var_.characterEffect1019ui_story = var_132_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_22 = 0.2

			if var_132_21 <= arg_129_1.time_ and arg_129_1.time_ < var_132_21 + var_132_22 and not isNil(var_132_20) then
				local var_132_23 = (arg_129_1.time_ - var_132_21) / var_132_22

				if arg_129_1.var_.characterEffect1019ui_story and not isNil(var_132_20) then
					local var_132_24 = Mathf.Lerp(0, 0.5, var_132_23)

					arg_129_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1019ui_story.fillRatio = var_132_24
				end
			end

			if arg_129_1.time_ >= var_132_21 + var_132_22 and arg_129_1.time_ < var_132_21 + var_132_22 + arg_132_0 and not isNil(var_132_20) and arg_129_1.var_.characterEffect1019ui_story then
				local var_132_25 = 0.5

				arg_129_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1019ui_story.fillRatio = var_132_25
			end

			local var_132_26 = 0
			local var_132_27 = 0.625

			if var_132_26 < arg_129_1.time_ and arg_129_1.time_ <= var_132_26 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_28 = arg_129_1:FormatText(StoryNameCfg[6].name)

				arg_129_1.leftNameTxt_.text = var_132_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_29 = arg_129_1:GetWordFromCfg(103101031)
				local var_132_30 = arg_129_1:FormatText(var_132_29.content)

				arg_129_1.text_.text = var_132_30

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_31 = 24
				local var_132_32 = utf8.len(var_132_30)
				local var_132_33 = var_132_31 <= 0 and var_132_27 or var_132_27 * (var_132_32 / var_132_31)

				if var_132_33 > 0 and var_132_27 < var_132_33 then
					arg_129_1.talkMaxDuration = var_132_33

					if var_132_33 + var_132_26 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_33 + var_132_26
					end
				end

				arg_129_1.text_.text = var_132_30
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101031", "story_v_out_103101.awb") ~= 0 then
					local var_132_34 = manager.audio:GetVoiceLength("story_v_out_103101", "103101031", "story_v_out_103101.awb") / 1000

					if var_132_34 + var_132_26 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_34 + var_132_26
					end

					if var_132_29.prefab_name ~= "" and arg_129_1.actors_[var_132_29.prefab_name] ~= nil then
						local var_132_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_29.prefab_name].transform, "story_v_out_103101", "103101031", "story_v_out_103101.awb")

						arg_129_1:RecordAudio("103101031", var_132_35)
						arg_129_1:RecordAudio("103101031", var_132_35)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_103101", "103101031", "story_v_out_103101.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_103101", "103101031", "story_v_out_103101.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_36 = math.max(var_132_27, arg_129_1.talkMaxDuration)

			if var_132_26 <= arg_129_1.time_ and arg_129_1.time_ < var_132_26 + var_132_36 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_26) / var_132_36

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_26 + var_132_36 and arg_129_1.time_ < var_132_26 + var_132_36 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play103101032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 103101032
		arg_133_1.duration_ = 4.63

		local var_133_0 = {
			ja = 3.366,
			ko = 3.9,
			zh = 3.633,
			en = 4.633
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play103101033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1019ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1019ui_story == nil then
				arg_133_1.var_.characterEffect1019ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1019ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1019ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1019ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1019ui_story.fillRatio = var_136_5
			end

			local var_136_6 = arg_133_1.actors_["1036ui_story"].transform
			local var_136_7 = 0

			if var_136_7 < arg_133_1.time_ and arg_133_1.time_ <= var_136_7 + arg_136_0 then
				arg_133_1.var_.moveOldPos1036ui_story = var_136_6.localPosition
			end

			local var_136_8 = 0.001

			if var_136_7 <= arg_133_1.time_ and arg_133_1.time_ < var_136_7 + var_136_8 then
				local var_136_9 = (arg_133_1.time_ - var_136_7) / var_136_8
				local var_136_10 = Vector3.New(0.7, -1.09, -5.78)

				var_136_6.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1036ui_story, var_136_10, var_136_9)

				local var_136_11 = manager.ui.mainCamera.transform.position - var_136_6.position

				var_136_6.forward = Vector3.New(var_136_11.x, var_136_11.y, var_136_11.z)

				local var_136_12 = var_136_6.localEulerAngles

				var_136_12.z = 0
				var_136_12.x = 0
				var_136_6.localEulerAngles = var_136_12
			end

			if arg_133_1.time_ >= var_136_7 + var_136_8 and arg_133_1.time_ < var_136_7 + var_136_8 + arg_136_0 then
				var_136_6.localPosition = Vector3.New(0.7, -1.09, -5.78)

				local var_136_13 = manager.ui.mainCamera.transform.position - var_136_6.position

				var_136_6.forward = Vector3.New(var_136_13.x, var_136_13.y, var_136_13.z)

				local var_136_14 = var_136_6.localEulerAngles

				var_136_14.z = 0
				var_136_14.x = 0
				var_136_6.localEulerAngles = var_136_14
			end

			local var_136_15 = 0

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action7_1")
			end

			local var_136_16 = 0

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_136_17 = arg_133_1.actors_["1036ui_story"]
			local var_136_18 = 0

			if var_136_18 < arg_133_1.time_ and arg_133_1.time_ <= var_136_18 + arg_136_0 and not isNil(var_136_17) and arg_133_1.var_.characterEffect1036ui_story == nil then
				arg_133_1.var_.characterEffect1036ui_story = var_136_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_19 = 0.2

			if var_136_18 <= arg_133_1.time_ and arg_133_1.time_ < var_136_18 + var_136_19 and not isNil(var_136_17) then
				local var_136_20 = (arg_133_1.time_ - var_136_18) / var_136_19

				if arg_133_1.var_.characterEffect1036ui_story and not isNil(var_136_17) then
					arg_133_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_18 + var_136_19 and arg_133_1.time_ < var_136_18 + var_136_19 + arg_136_0 and not isNil(var_136_17) and arg_133_1.var_.characterEffect1036ui_story then
				arg_133_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_136_21 = arg_133_1.actors_["1084ui_story"].transform
			local var_136_22 = 0

			if var_136_22 < arg_133_1.time_ and arg_133_1.time_ <= var_136_22 + arg_136_0 then
				arg_133_1.var_.moveOldPos1084ui_story = var_136_21.localPosition
			end

			local var_136_23 = 0.001

			if var_136_22 <= arg_133_1.time_ and arg_133_1.time_ < var_136_22 + var_136_23 then
				local var_136_24 = (arg_133_1.time_ - var_136_22) / var_136_23
				local var_136_25 = Vector3.New(0, 100, 0)

				var_136_21.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1084ui_story, var_136_25, var_136_24)

				local var_136_26 = manager.ui.mainCamera.transform.position - var_136_21.position

				var_136_21.forward = Vector3.New(var_136_26.x, var_136_26.y, var_136_26.z)

				local var_136_27 = var_136_21.localEulerAngles

				var_136_27.z = 0
				var_136_27.x = 0
				var_136_21.localEulerAngles = var_136_27
			end

			if arg_133_1.time_ >= var_136_22 + var_136_23 and arg_133_1.time_ < var_136_22 + var_136_23 + arg_136_0 then
				var_136_21.localPosition = Vector3.New(0, 100, 0)

				local var_136_28 = manager.ui.mainCamera.transform.position - var_136_21.position

				var_136_21.forward = Vector3.New(var_136_28.x, var_136_28.y, var_136_28.z)

				local var_136_29 = var_136_21.localEulerAngles

				var_136_29.z = 0
				var_136_29.x = 0
				var_136_21.localEulerAngles = var_136_29
			end

			local var_136_30 = 0
			local var_136_31 = 0.425

			if var_136_30 < arg_133_1.time_ and arg_133_1.time_ <= var_136_30 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_32 = arg_133_1:FormatText(StoryNameCfg[5].name)

				arg_133_1.leftNameTxt_.text = var_136_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_33 = arg_133_1:GetWordFromCfg(103101032)
				local var_136_34 = arg_133_1:FormatText(var_136_33.content)

				arg_133_1.text_.text = var_136_34

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_35 = 16
				local var_136_36 = utf8.len(var_136_34)
				local var_136_37 = var_136_35 <= 0 and var_136_31 or var_136_31 * (var_136_36 / var_136_35)

				if var_136_37 > 0 and var_136_31 < var_136_37 then
					arg_133_1.talkMaxDuration = var_136_37

					if var_136_37 + var_136_30 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_37 + var_136_30
					end
				end

				arg_133_1.text_.text = var_136_34
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101032", "story_v_out_103101.awb") ~= 0 then
					local var_136_38 = manager.audio:GetVoiceLength("story_v_out_103101", "103101032", "story_v_out_103101.awb") / 1000

					if var_136_38 + var_136_30 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_38 + var_136_30
					end

					if var_136_33.prefab_name ~= "" and arg_133_1.actors_[var_136_33.prefab_name] ~= nil then
						local var_136_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_33.prefab_name].transform, "story_v_out_103101", "103101032", "story_v_out_103101.awb")

						arg_133_1:RecordAudio("103101032", var_136_39)
						arg_133_1:RecordAudio("103101032", var_136_39)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_103101", "103101032", "story_v_out_103101.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_103101", "103101032", "story_v_out_103101.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_40 = math.max(var_136_31, arg_133_1.talkMaxDuration)

			if var_136_30 <= arg_133_1.time_ and arg_133_1.time_ < var_136_30 + var_136_40 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_30) / var_136_40

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_30 + var_136_40 and arg_133_1.time_ < var_136_30 + var_136_40 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
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

		arg_133_1:InitPlayNodeList()
	end,
	Play103101033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 103101033
		arg_137_1.duration_ = 5.67

		local var_137_0 = {
			ja = 5.666,
			ko = 4.133,
			zh = 3.766,
			en = 5.1
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play103101034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action4_2")
			end

			local var_140_2 = arg_137_1.actors_["1019ui_story"]
			local var_140_3 = 0

			if var_140_3 < arg_137_1.time_ and arg_137_1.time_ <= var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect1019ui_story == nil then
				arg_137_1.var_.characterEffect1019ui_story = var_140_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_4 = 0.2

			if var_140_3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_3 + var_140_4 and not isNil(var_140_2) then
				local var_140_5 = (arg_137_1.time_ - var_140_3) / var_140_4

				if arg_137_1.var_.characterEffect1019ui_story and not isNil(var_140_2) then
					arg_137_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_3 + var_140_4 and arg_137_1.time_ < var_140_3 + var_140_4 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect1019ui_story then
				arg_137_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_140_6 = arg_137_1.actors_["1036ui_story"]
			local var_140_7 = 0

			if var_140_7 < arg_137_1.time_ and arg_137_1.time_ <= var_140_7 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect1036ui_story == nil then
				arg_137_1.var_.characterEffect1036ui_story = var_140_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_8 = 0.2

			if var_140_7 <= arg_137_1.time_ and arg_137_1.time_ < var_140_7 + var_140_8 and not isNil(var_140_6) then
				local var_140_9 = (arg_137_1.time_ - var_140_7) / var_140_8

				if arg_137_1.var_.characterEffect1036ui_story and not isNil(var_140_6) then
					local var_140_10 = Mathf.Lerp(0, 0.5, var_140_9)

					arg_137_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1036ui_story.fillRatio = var_140_10
				end
			end

			if arg_137_1.time_ >= var_140_7 + var_140_8 and arg_137_1.time_ < var_140_7 + var_140_8 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect1036ui_story then
				local var_140_11 = 0.5

				arg_137_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1036ui_story.fillRatio = var_140_11
			end

			local var_140_12 = 0
			local var_140_13 = 0.425

			if var_140_12 < arg_137_1.time_ and arg_137_1.time_ <= var_140_12 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_14 = arg_137_1:FormatText(StoryNameCfg[13].name)

				arg_137_1.leftNameTxt_.text = var_140_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_15 = arg_137_1:GetWordFromCfg(103101033)
				local var_140_16 = arg_137_1:FormatText(var_140_15.content)

				arg_137_1.text_.text = var_140_16

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_17 = 17
				local var_140_18 = utf8.len(var_140_16)
				local var_140_19 = var_140_17 <= 0 and var_140_13 or var_140_13 * (var_140_18 / var_140_17)

				if var_140_19 > 0 and var_140_13 < var_140_19 then
					arg_137_1.talkMaxDuration = var_140_19

					if var_140_19 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_19 + var_140_12
					end
				end

				arg_137_1.text_.text = var_140_16
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101033", "story_v_out_103101.awb") ~= 0 then
					local var_140_20 = manager.audio:GetVoiceLength("story_v_out_103101", "103101033", "story_v_out_103101.awb") / 1000

					if var_140_20 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_20 + var_140_12
					end

					if var_140_15.prefab_name ~= "" and arg_137_1.actors_[var_140_15.prefab_name] ~= nil then
						local var_140_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_15.prefab_name].transform, "story_v_out_103101", "103101033", "story_v_out_103101.awb")

						arg_137_1:RecordAudio("103101033", var_140_21)
						arg_137_1:RecordAudio("103101033", var_140_21)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_103101", "103101033", "story_v_out_103101.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_103101", "103101033", "story_v_out_103101.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_22 = math.max(var_140_13, arg_137_1.talkMaxDuration)

			if var_140_12 <= arg_137_1.time_ and arg_137_1.time_ < var_140_12 + var_140_22 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_12) / var_140_22

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_12 + var_140_22 and arg_137_1.time_ < var_140_12 + var_140_22 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play103101034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 103101034
		arg_141_1.duration_ = 10.63

		local var_141_0 = {
			ja = 9.6,
			ko = 9.016666666666,
			zh = 10.633,
			en = 9.016666666666
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play103101035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_1 = 2

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_1 then
				local var_144_2 = (arg_141_1.time_ - var_144_0) / var_144_1
				local var_144_3 = Color.New(0, 0, 0)

				var_144_3.a = Mathf.Lerp(0, 1, var_144_2)
				arg_141_1.mask_.color = var_144_3
			end

			if arg_141_1.time_ >= var_144_0 + var_144_1 and arg_141_1.time_ < var_144_0 + var_144_1 + arg_144_0 then
				local var_144_4 = Color.New(0, 0, 0)

				var_144_4.a = 1
				arg_141_1.mask_.color = var_144_4
			end

			local var_144_5 = 2

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_6 = 2

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_6 then
				local var_144_7 = (arg_141_1.time_ - var_144_5) / var_144_6
				local var_144_8 = Color.New(0, 0, 0)

				var_144_8.a = Mathf.Lerp(1, 0, var_144_7)
				arg_141_1.mask_.color = var_144_8
			end

			if arg_141_1.time_ >= var_144_5 + var_144_6 and arg_141_1.time_ < var_144_5 + var_144_6 + arg_144_0 then
				local var_144_9 = Color.New(0, 0, 0)
				local var_144_10 = 0

				arg_141_1.mask_.enabled = false
				var_144_9.a = var_144_10
				arg_141_1.mask_.color = var_144_9
			end

			local var_144_11 = "S0302"

			if arg_141_1.bgs_[var_144_11] == nil then
				local var_144_12 = Object.Instantiate(arg_141_1.paintGo_)

				var_144_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_144_11)
				var_144_12.name = var_144_11
				var_144_12.transform.parent = arg_141_1.stage_.transform
				var_144_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.bgs_[var_144_11] = var_144_12
			end

			local var_144_13 = 2

			if var_144_13 < arg_141_1.time_ and arg_141_1.time_ <= var_144_13 + arg_144_0 then
				local var_144_14 = manager.ui.mainCamera.transform.localPosition
				local var_144_15 = Vector3.New(0, 0, 10) + Vector3.New(var_144_14.x, var_144_14.y, 0)
				local var_144_16 = arg_141_1.bgs_.S0302

				var_144_16.transform.localPosition = var_144_15
				var_144_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_144_17 = var_144_16:GetComponent("SpriteRenderer")

				if var_144_17 and var_144_17.sprite then
					local var_144_18 = (var_144_16.transform.localPosition - var_144_14).z
					local var_144_19 = manager.ui.mainCameraCom_
					local var_144_20 = 2 * var_144_18 * Mathf.Tan(var_144_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_144_21 = var_144_20 * var_144_19.aspect
					local var_144_22 = var_144_17.sprite.bounds.size.x
					local var_144_23 = var_144_17.sprite.bounds.size.y
					local var_144_24 = var_144_21 / var_144_22
					local var_144_25 = var_144_20 / var_144_23
					local var_144_26 = var_144_25 < var_144_24 and var_144_24 or var_144_25

					var_144_16.transform.localScale = Vector3.New(var_144_26, var_144_26, 0)
				end

				for iter_144_0, iter_144_1 in pairs(arg_141_1.bgs_) do
					if iter_144_0 ~= "S0302" then
						iter_144_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_144_27 = arg_141_1.bgs_.S0302.transform
			local var_144_28 = 2

			if var_144_28 < arg_141_1.time_ and arg_141_1.time_ <= var_144_28 + arg_144_0 then
				arg_141_1.var_.moveOldPosS0302 = var_144_27.localPosition
			end

			local var_144_29 = 0.001

			if var_144_28 <= arg_141_1.time_ and arg_141_1.time_ < var_144_28 + var_144_29 then
				local var_144_30 = (arg_141_1.time_ - var_144_28) / var_144_29
				local var_144_31 = Vector3.New(0, 1, 0)

				var_144_27.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPosS0302, var_144_31, var_144_30)
			end

			if arg_141_1.time_ >= var_144_28 + var_144_29 and arg_141_1.time_ < var_144_28 + var_144_29 + arg_144_0 then
				var_144_27.localPosition = Vector3.New(0, 1, 0)
			end

			local var_144_32 = arg_141_1.bgs_.S0302.transform
			local var_144_33 = 2.01666666666667

			if var_144_33 < arg_141_1.time_ and arg_141_1.time_ <= var_144_33 + arg_144_0 then
				arg_141_1.var_.moveOldPosS0302 = var_144_32.localPosition
			end

			local var_144_34 = 7

			if var_144_33 <= arg_141_1.time_ and arg_141_1.time_ < var_144_33 + var_144_34 then
				local var_144_35 = (arg_141_1.time_ - var_144_33) / var_144_34
				local var_144_36 = Vector3.New(0, 1, 5)

				var_144_32.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPosS0302, var_144_36, var_144_35)
			end

			if arg_141_1.time_ >= var_144_33 + var_144_34 and arg_141_1.time_ < var_144_33 + var_144_34 + arg_144_0 then
				var_144_32.localPosition = Vector3.New(0, 1, 5)
			end

			local var_144_37 = arg_141_1.actors_["1036ui_story"].transform
			local var_144_38 = 1.966

			if var_144_38 < arg_141_1.time_ and arg_141_1.time_ <= var_144_38 + arg_144_0 then
				arg_141_1.var_.moveOldPos1036ui_story = var_144_37.localPosition
			end

			local var_144_39 = 0.001

			if var_144_38 <= arg_141_1.time_ and arg_141_1.time_ < var_144_38 + var_144_39 then
				local var_144_40 = (arg_141_1.time_ - var_144_38) / var_144_39
				local var_144_41 = Vector3.New(0, 100, 0)

				var_144_37.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1036ui_story, var_144_41, var_144_40)

				local var_144_42 = manager.ui.mainCamera.transform.position - var_144_37.position

				var_144_37.forward = Vector3.New(var_144_42.x, var_144_42.y, var_144_42.z)

				local var_144_43 = var_144_37.localEulerAngles

				var_144_43.z = 0
				var_144_43.x = 0
				var_144_37.localEulerAngles = var_144_43
			end

			if arg_141_1.time_ >= var_144_38 + var_144_39 and arg_141_1.time_ < var_144_38 + var_144_39 + arg_144_0 then
				var_144_37.localPosition = Vector3.New(0, 100, 0)

				local var_144_44 = manager.ui.mainCamera.transform.position - var_144_37.position

				var_144_37.forward = Vector3.New(var_144_44.x, var_144_44.y, var_144_44.z)

				local var_144_45 = var_144_37.localEulerAngles

				var_144_45.z = 0
				var_144_45.x = 0
				var_144_37.localEulerAngles = var_144_45
			end

			local var_144_46 = arg_141_1.actors_["1019ui_story"].transform
			local var_144_47 = 1.966

			if var_144_47 < arg_141_1.time_ and arg_141_1.time_ <= var_144_47 + arg_144_0 then
				arg_141_1.var_.moveOldPos1019ui_story = var_144_46.localPosition
			end

			local var_144_48 = 0.001

			if var_144_47 <= arg_141_1.time_ and arg_141_1.time_ < var_144_47 + var_144_48 then
				local var_144_49 = (arg_141_1.time_ - var_144_47) / var_144_48
				local var_144_50 = Vector3.New(0, 100, 0)

				var_144_46.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1019ui_story, var_144_50, var_144_49)

				local var_144_51 = manager.ui.mainCamera.transform.position - var_144_46.position

				var_144_46.forward = Vector3.New(var_144_51.x, var_144_51.y, var_144_51.z)

				local var_144_52 = var_144_46.localEulerAngles

				var_144_52.z = 0
				var_144_52.x = 0
				var_144_46.localEulerAngles = var_144_52
			end

			if arg_141_1.time_ >= var_144_47 + var_144_48 and arg_141_1.time_ < var_144_47 + var_144_48 + arg_144_0 then
				var_144_46.localPosition = Vector3.New(0, 100, 0)

				local var_144_53 = manager.ui.mainCamera.transform.position - var_144_46.position

				var_144_46.forward = Vector3.New(var_144_53.x, var_144_53.y, var_144_53.z)

				local var_144_54 = var_144_46.localEulerAngles

				var_144_54.z = 0
				var_144_54.x = 0
				var_144_46.localEulerAngles = var_144_54
			end

			local var_144_55 = 4

			if var_144_55 < arg_141_1.time_ and arg_141_1.time_ <= var_144_55 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			local var_144_56 = 5

			if arg_141_1.time_ >= var_144_55 + var_144_56 and arg_141_1.time_ < var_144_55 + var_144_56 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_57 = 4
			local var_144_58 = 0.35

			if var_144_57 < arg_141_1.time_ and arg_141_1.time_ <= var_144_57 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_59 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_59:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_60 = arg_141_1:FormatText(StoryNameCfg[42].name)

				arg_141_1.leftNameTxt_.text = var_144_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_61 = arg_141_1:GetWordFromCfg(103101034)
				local var_144_62 = arg_141_1:FormatText(var_144_61.content)

				arg_141_1.text_.text = var_144_62

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_63 = 14
				local var_144_64 = utf8.len(var_144_62)
				local var_144_65 = var_144_63 <= 0 and var_144_58 or var_144_58 * (var_144_64 / var_144_63)

				if var_144_65 > 0 and var_144_58 < var_144_65 then
					arg_141_1.talkMaxDuration = var_144_65
					var_144_57 = var_144_57 + 0.3

					if var_144_65 + var_144_57 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_65 + var_144_57
					end
				end

				arg_141_1.text_.text = var_144_62
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101034", "story_v_out_103101.awb") ~= 0 then
					local var_144_66 = manager.audio:GetVoiceLength("story_v_out_103101", "103101034", "story_v_out_103101.awb") / 1000

					if var_144_66 + var_144_57 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_66 + var_144_57
					end

					if var_144_61.prefab_name ~= "" and arg_141_1.actors_[var_144_61.prefab_name] ~= nil then
						local var_144_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_61.prefab_name].transform, "story_v_out_103101", "103101034", "story_v_out_103101.awb")

						arg_141_1:RecordAudio("103101034", var_144_67)
						arg_141_1:RecordAudio("103101034", var_144_67)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_103101", "103101034", "story_v_out_103101.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_103101", "103101034", "story_v_out_103101.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_68 = var_144_57 + 0.3
			local var_144_69 = math.max(var_144_58, arg_141_1.talkMaxDuration)

			if var_144_68 <= arg_141_1.time_ and arg_141_1.time_ < var_144_68 + var_144_69 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_68) / var_144_69

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_68 + var_144_69 and arg_141_1.time_ < var_144_68 + var_144_69 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0302",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0302",
				changeDisplayLayer = false,
				needEase = false,
				duration = 7,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play103101035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 103101035
		arg_147_1.duration_ = 5.13

		local var_147_0 = {
			ja = 5.133,
			ko = 4.033,
			zh = 3.866,
			en = 4.233
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
				arg_147_0:Play103101036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.45

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[6].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:GetWordFromCfg(103101035)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101035", "story_v_out_103101.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_103101", "103101035", "story_v_out_103101.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_103101", "103101035", "story_v_out_103101.awb")

						arg_147_1:RecordAudio("103101035", var_150_9)
						arg_147_1:RecordAudio("103101035", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_103101", "103101035", "story_v_out_103101.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_103101", "103101035", "story_v_out_103101.awb")
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
	Play103101036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 103101036
		arg_151_1.duration_ = 7

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play103101037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.bgs_.S0302.transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPosS0302 = var_154_0.localPosition
			end

			local var_154_2 = 7

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(0, 1, 8)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPosS0302, var_154_4, var_154_3)
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(0, 1, 8)
			end

			local var_154_5 = 0
			local var_154_6 = 1.025

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_7 = arg_151_1:GetWordFromCfg(103101036)
				local var_154_8 = arg_151_1:FormatText(var_154_7.content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 41
				local var_154_10 = utf8.len(var_154_8)
				local var_154_11 = var_154_9 <= 0 and var_154_6 or var_154_6 * (var_154_10 / var_154_9)

				if var_154_11 > 0 and var_154_6 < var_154_11 then
					arg_151_1.talkMaxDuration = var_154_11

					if var_154_11 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_5
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_6, arg_151_1.talkMaxDuration)

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_5) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_5 + var_154_12 and arg_151_1.time_ < var_154_5 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0302",
				changeDisplayLayer = false,
				needEase = false,
				duration = 7,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play103101037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 103101037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play103101038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.bgs_.S0302.transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPosS0302 = var_158_0.localPosition
			end

			local var_158_2 = 4

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0, 1, 10)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPosS0302, var_158_4, var_158_3)
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_158_5 = 0
			local var_158_6 = 1.025

			if var_158_5 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_7 = arg_155_1:GetWordFromCfg(103101037)
				local var_158_8 = arg_155_1:FormatText(var_158_7.content)

				arg_155_1.text_.text = var_158_8

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 41
				local var_158_10 = utf8.len(var_158_8)
				local var_158_11 = var_158_9 <= 0 and var_158_6 or var_158_6 * (var_158_10 / var_158_9)

				if var_158_11 > 0 and var_158_6 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_5 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_5
					end
				end

				arg_155_1.text_.text = var_158_8
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_12 = math.max(var_158_6, arg_155_1.talkMaxDuration)

			if var_158_5 <= arg_155_1.time_ and arg_155_1.time_ < var_158_5 + var_158_12 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_5) / var_158_12

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_5 + var_158_12 and arg_155_1.time_ < var_158_5 + var_158_12 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0302",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play103101038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 103101038
		arg_159_1.duration_ = 5.43

		local var_159_0 = {
			ja = 4.133,
			ko = 3.333,
			zh = 5.433,
			en = 3.366
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
				arg_159_0:Play103101039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.325

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[42].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(103101038)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 13
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101038", "story_v_out_103101.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_103101", "103101038", "story_v_out_103101.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_103101", "103101038", "story_v_out_103101.awb")

						arg_159_1:RecordAudio("103101038", var_162_9)
						arg_159_1:RecordAudio("103101038", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_103101", "103101038", "story_v_out_103101.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_103101", "103101038", "story_v_out_103101.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_10 and arg_159_1.time_ < var_162_0 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play103101039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 103101039
		arg_163_1.duration_ = 9.7

		local var_163_0 = {
			ja = 9.7,
			ko = 5.433,
			zh = 5.6,
			en = 5.966
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play103101040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.6

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[49].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:GetWordFromCfg(103101039)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 25
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101039", "story_v_out_103101.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_103101", "103101039", "story_v_out_103101.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_103101", "103101039", "story_v_out_103101.awb")

						arg_163_1:RecordAudio("103101039", var_166_9)
						arg_163_1:RecordAudio("103101039", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_103101", "103101039", "story_v_out_103101.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_103101", "103101039", "story_v_out_103101.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_10 and arg_163_1.time_ < var_166_0 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play103101040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 103101040
		arg_167_1.duration_ = 2.6

		local var_167_0 = {
			ja = 2.6,
			ko = 1.4,
			zh = 1.7,
			en = 1.333
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play103101041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.2

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[37].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(103101040)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101040", "story_v_out_103101.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_103101", "103101040", "story_v_out_103101.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_103101", "103101040", "story_v_out_103101.awb")

						arg_167_1:RecordAudio("103101040", var_170_9)
						arg_167_1:RecordAudio("103101040", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_103101", "103101040", "story_v_out_103101.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_103101", "103101040", "story_v_out_103101.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play103101041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 103101041
		arg_171_1.duration_ = 2.6

		local var_171_0 = {
			ja = 2.6,
			ko = 2.2,
			zh = 2.366,
			en = 2.6
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play103101042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.375

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[5].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(103101041)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101041", "story_v_out_103101.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_103101", "103101041", "story_v_out_103101.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_103101", "103101041", "story_v_out_103101.awb")

						arg_171_1:RecordAudio("103101041", var_174_9)
						arg_171_1:RecordAudio("103101041", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_103101", "103101041", "story_v_out_103101.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_103101", "103101041", "story_v_out_103101.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_10 and arg_171_1.time_ < var_174_0 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play103101042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 103101042
		arg_175_1.duration_ = 6.57

		local var_175_0 = {
			ja = 6.566,
			ko = 1.1,
			zh = 4.5,
			en = 4.666
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
				arg_175_0:Play103101043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.675

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[5].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(103101042)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101042", "story_v_out_103101.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_103101", "103101042", "story_v_out_103101.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_103101", "103101042", "story_v_out_103101.awb")

						arg_175_1:RecordAudio("103101042", var_178_9)
						arg_175_1:RecordAudio("103101042", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_103101", "103101042", "story_v_out_103101.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_103101", "103101042", "story_v_out_103101.awb")
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
	Play103101043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 103101043
		arg_179_1.duration_ = 6.13

		local var_179_0 = {
			ja = 4.7,
			ko = 6.133,
			zh = 4.5,
			en = 2.266
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
			arg_179_1.auto_ = false
		end

		function arg_179_1.playNext_(arg_181_0)
			arg_179_1.onStoryFinished_()
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.275

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[42].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:GetWordFromCfg(103101043)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_103101", "103101043", "story_v_out_103101.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_103101", "103101043", "story_v_out_103101.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_103101", "103101043", "story_v_out_103101.awb")

						arg_179_1:RecordAudio("103101043", var_182_9)
						arg_179_1:RecordAudio("103101043", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_103101", "103101043", "story_v_out_103101.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_103101", "103101043", "story_v_out_103101.awb")
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
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/B03a",
		"TextureConfig/Background/S0302"
	},
	voices = {
		"story_v_out_103101.awb"
	}
}
