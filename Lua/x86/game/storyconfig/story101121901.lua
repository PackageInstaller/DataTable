return {
	Play112191001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112191001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112191002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "H01a"

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
				local var_4_5 = arg_1_1.bgs_.H01a

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
					if iter_4_0 ~= "H01a" then
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
				local var_4_25 = "effect"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_26 = 2
			local var_4_27 = 1

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "music"

				arg_1_1:AudioAction(var_4_28, var_4_29, "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_30 = ""
				local var_4_31 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if var_4_31 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_31 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_31

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_31
						arg_1_1.bgmTxt2_.text = var_4_31
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

			local var_4_32 = 2
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "effect"

				arg_1_1:AudioAction(var_4_34, var_4_35, "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 2
			local var_4_37 = 0.55

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_39 = arg_1_1:GetWordFromCfg(112191001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 22
				local var_4_42 = utf8.len(var_4_40)
				local var_4_43 = var_4_41 <= 0 and var_4_37 or var_4_37 * (var_4_42 / var_4_41)

				if var_4_43 > 0 and var_4_37 < var_4_43 then
					arg_1_1.talkMaxDuration = var_4_43
					var_4_36 = var_4_36 + 0.3

					if var_4_43 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_40
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = var_4_36 + 0.3
			local var_4_45 = math.max(var_4_37, arg_1_1.talkMaxDuration)

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
	Play112191002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 112191002
		arg_8_1.duration_ = 14.93

		local var_8_0 = {
			ja = 14.933,
			ko = 10,
			zh = 10.433,
			en = 11.166
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
				arg_8_0:Play112191003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1081ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1081ui_story"].transform
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.var_.moveOldPos1081ui_story = var_11_5.localPosition

				local var_11_7 = "1081ui_story"

				arg_8_1:ShowWeapon(arg_8_1.var_[var_11_7 .. "Animator"].transform, false)
			end

			local var_11_8 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_8 then
				local var_11_9 = (arg_8_1.time_ - var_11_6) / var_11_8
				local var_11_10 = Vector3.New(0, -0.92, -5.8)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1081ui_story, var_11_10, var_11_9)

				local var_11_11 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_11.x, var_11_11.y, var_11_11.z)

				local var_11_12 = var_11_5.localEulerAngles

				var_11_12.z = 0
				var_11_12.x = 0
				var_11_5.localEulerAngles = var_11_12
			end

			if arg_8_1.time_ >= var_11_6 + var_11_8 and arg_8_1.time_ < var_11_6 + var_11_8 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_11_13 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_13.x, var_11_13.y, var_11_13.z)

				local var_11_14 = var_11_5.localEulerAngles

				var_11_14.z = 0
				var_11_14.x = 0
				var_11_5.localEulerAngles = var_11_14
			end

			local var_11_15 = arg_8_1.actors_["1081ui_story"]
			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 and not isNil(var_11_15) and arg_8_1.var_.characterEffect1081ui_story == nil then
				arg_8_1.var_.characterEffect1081ui_story = var_11_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_17 = 0.2

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_17 and not isNil(var_11_15) then
				local var_11_18 = (arg_8_1.time_ - var_11_16) / var_11_17

				if arg_8_1.var_.characterEffect1081ui_story and not isNil(var_11_15) then
					arg_8_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_16 + var_11_17 and arg_8_1.time_ < var_11_16 + var_11_17 + arg_11_0 and not isNil(var_11_15) and arg_8_1.var_.characterEffect1081ui_story then
				arg_8_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_11_19 = 0

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				arg_8_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			local var_11_20 = 0

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_11_21 = 0
			local var_11_22 = 1.225

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_23 = arg_8_1:FormatText(StoryNameCfg[202].name)

				arg_8_1.leftNameTxt_.text = var_11_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_24 = arg_8_1:GetWordFromCfg(112191002)
				local var_11_25 = arg_8_1:FormatText(var_11_24.content)

				arg_8_1.text_.text = var_11_25

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_26 = 49
				local var_11_27 = utf8.len(var_11_25)
				local var_11_28 = var_11_26 <= 0 and var_11_22 or var_11_22 * (var_11_27 / var_11_26)

				if var_11_28 > 0 and var_11_22 < var_11_28 then
					arg_8_1.talkMaxDuration = var_11_28

					if var_11_28 + var_11_21 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_21
					end
				end

				arg_8_1.text_.text = var_11_25
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191002", "story_v_out_112191.awb") ~= 0 then
					local var_11_29 = manager.audio:GetVoiceLength("story_v_out_112191", "112191002", "story_v_out_112191.awb") / 1000

					if var_11_29 + var_11_21 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_29 + var_11_21
					end

					if var_11_24.prefab_name ~= "" and arg_8_1.actors_[var_11_24.prefab_name] ~= nil then
						local var_11_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_24.prefab_name].transform, "story_v_out_112191", "112191002", "story_v_out_112191.awb")

						arg_8_1:RecordAudio("112191002", var_11_30)
						arg_8_1:RecordAudio("112191002", var_11_30)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_112191", "112191002", "story_v_out_112191.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_112191", "112191002", "story_v_out_112191.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_31 = math.max(var_11_22, arg_8_1.talkMaxDuration)

			if var_11_21 <= arg_8_1.time_ and arg_8_1.time_ < var_11_21 + var_11_31 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_21) / var_11_31

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_21 + var_11_31 and arg_8_1.time_ < var_11_21 + var_11_31 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play112191003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 112191003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play112191004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1081ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1081ui_story == nil then
				arg_12_1.var_.characterEffect1081ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.2

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1081ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1081ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1081ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1081ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 0.3

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_8 = arg_12_1:GetWordFromCfg(112191003)
				local var_15_9 = arg_12_1:FormatText(var_15_8.content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_10 = 12
				local var_15_11 = utf8.len(var_15_9)
				local var_15_12 = var_15_10 <= 0 and var_15_7 or var_15_7 * (var_15_11 / var_15_10)

				if var_15_12 > 0 and var_15_7 < var_15_12 then
					arg_12_1.talkMaxDuration = var_15_12

					if var_15_12 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_9
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_13 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_13 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_13

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_13 and arg_12_1.time_ < var_15_6 + var_15_13 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play112191004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 112191004
		arg_16_1.duration_ = 5.73

		local var_16_0 = {
			ja = 5.733,
			ko = 3.133,
			zh = 5.633,
			en = 3.9
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
				arg_16_0:Play112191005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1081ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1081ui_story == nil then
				arg_16_1.var_.characterEffect1081ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.2

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1081ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1081ui_story then
				arg_16_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_19_4 = 0

			if var_19_4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action475")
			end

			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_19_6 = 0
			local var_19_7 = 0.325

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_8 = arg_16_1:FormatText(StoryNameCfg[202].name)

				arg_16_1.leftNameTxt_.text = var_19_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_9 = arg_16_1:GetWordFromCfg(112191004)
				local var_19_10 = arg_16_1:FormatText(var_19_9.content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 13
				local var_19_12 = utf8.len(var_19_10)
				local var_19_13 = var_19_11 <= 0 and var_19_7 or var_19_7 * (var_19_12 / var_19_11)

				if var_19_13 > 0 and var_19_7 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_10
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191004", "story_v_out_112191.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_112191", "112191004", "story_v_out_112191.awb") / 1000

					if var_19_14 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_6
					end

					if var_19_9.prefab_name ~= "" and arg_16_1.actors_[var_19_9.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_9.prefab_name].transform, "story_v_out_112191", "112191004", "story_v_out_112191.awb")

						arg_16_1:RecordAudio("112191004", var_19_15)
						arg_16_1:RecordAudio("112191004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_112191", "112191004", "story_v_out_112191.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_112191", "112191004", "story_v_out_112191.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_16 and arg_16_1.time_ < var_19_6 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play112191005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 112191005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play112191006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1081ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1081ui_story == nil then
				arg_20_1.var_.characterEffect1081ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.2

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1081ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1081ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1081ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1081ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 0.05

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_9 = arg_20_1:GetWordFromCfg(112191005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 2
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
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_14 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_14 and arg_20_1.time_ < var_23_6 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play112191006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 112191006
		arg_24_1.duration_ = 7.77

		local var_24_0 = {
			ja = 7.766,
			ko = 6.6,
			zh = 7.2,
			en = 6.1
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
				arg_24_0:Play112191007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1081ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos1081ui_story = var_27_0.localPosition
			end

			local var_27_2 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2
				local var_27_4 = Vector3.New(-0.7, -0.92, -5.8)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1081ui_story, var_27_4, var_27_3)

				local var_27_5 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_5.x, var_27_5.y, var_27_5.z)

				local var_27_6 = var_27_0.localEulerAngles

				var_27_6.z = 0
				var_27_6.x = 0
				var_27_0.localEulerAngles = var_27_6
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(-0.7, -0.92, -5.8)

				local var_27_7 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_7.x, var_27_7.y, var_27_7.z)

				local var_27_8 = var_27_0.localEulerAngles

				var_27_8.z = 0
				var_27_8.x = 0
				var_27_0.localEulerAngles = var_27_8
			end

			local var_27_9 = 0

			if var_27_9 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			local var_27_10 = "1148ui_story"

			if arg_24_1.actors_[var_27_10] == nil then
				local var_27_11 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_27_11) then
					local var_27_12 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_24_1.stage_.transform)

					var_27_12.name = var_27_10
					var_27_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_10] = var_27_12

					local var_27_13 = var_27_12:GetComponentInChildren(typeof(CharacterEffect))

					var_27_13.enabled = true

					local var_27_14 = GameObjectTools.GetOrAddComponent(var_27_12, typeof(DynamicBoneHelper))

					if var_27_14 then
						var_27_14:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_13.transform, false)

					arg_24_1.var_[var_27_10 .. "Animator"] = var_27_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_10 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_10 .. "LipSync"] = var_27_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_15 = arg_24_1.actors_["1148ui_story"].transform
			local var_27_16 = 0

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.var_.moveOldPos1148ui_story = var_27_15.localPosition

				local var_27_17 = "1148ui_story"

				arg_24_1:ShowWeapon(arg_24_1.var_[var_27_17 .. "Animator"].transform, false)
			end

			local var_27_18 = 0.001

			if var_27_16 <= arg_24_1.time_ and arg_24_1.time_ < var_27_16 + var_27_18 then
				local var_27_19 = (arg_24_1.time_ - var_27_16) / var_27_18
				local var_27_20 = Vector3.New(0.7, -0.8, -6.2)

				var_27_15.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1148ui_story, var_27_20, var_27_19)

				local var_27_21 = manager.ui.mainCamera.transform.position - var_27_15.position

				var_27_15.forward = Vector3.New(var_27_21.x, var_27_21.y, var_27_21.z)

				local var_27_22 = var_27_15.localEulerAngles

				var_27_22.z = 0
				var_27_22.x = 0
				var_27_15.localEulerAngles = var_27_22
			end

			if arg_24_1.time_ >= var_27_16 + var_27_18 and arg_24_1.time_ < var_27_16 + var_27_18 + arg_27_0 then
				var_27_15.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_27_23 = manager.ui.mainCamera.transform.position - var_27_15.position

				var_27_15.forward = Vector3.New(var_27_23.x, var_27_23.y, var_27_23.z)

				local var_27_24 = var_27_15.localEulerAngles

				var_27_24.z = 0
				var_27_24.x = 0
				var_27_15.localEulerAngles = var_27_24
			end

			local var_27_25 = 0

			if var_27_25 < arg_24_1.time_ and arg_24_1.time_ <= var_27_25 + arg_27_0 then
				arg_24_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_27_26 = arg_24_1.actors_["1148ui_story"]
			local var_27_27 = 0

			if var_27_27 < arg_24_1.time_ and arg_24_1.time_ <= var_27_27 + arg_27_0 and not isNil(var_27_26) and arg_24_1.var_.characterEffect1148ui_story == nil then
				arg_24_1.var_.characterEffect1148ui_story = var_27_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_28 = 0.2

			if var_27_27 <= arg_24_1.time_ and arg_24_1.time_ < var_27_27 + var_27_28 and not isNil(var_27_26) then
				local var_27_29 = (arg_24_1.time_ - var_27_27) / var_27_28

				if arg_24_1.var_.characterEffect1148ui_story and not isNil(var_27_26) then
					arg_24_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_27 + var_27_28 and arg_24_1.time_ < var_27_27 + var_27_28 + arg_27_0 and not isNil(var_27_26) and arg_24_1.var_.characterEffect1148ui_story then
				arg_24_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_27_30 = 0

			if var_27_30 < arg_24_1.time_ and arg_24_1.time_ <= var_27_30 + arg_27_0 then
				arg_24_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_27_31 = 0
			local var_27_32 = 0.75

			if var_27_31 < arg_24_1.time_ and arg_24_1.time_ <= var_27_31 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_33 = arg_24_1:FormatText(StoryNameCfg[8].name)

				arg_24_1.leftNameTxt_.text = var_27_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_34 = arg_24_1:GetWordFromCfg(112191006)
				local var_27_35 = arg_24_1:FormatText(var_27_34.content)

				arg_24_1.text_.text = var_27_35

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_36 = 30
				local var_27_37 = utf8.len(var_27_35)
				local var_27_38 = var_27_36 <= 0 and var_27_32 or var_27_32 * (var_27_37 / var_27_36)

				if var_27_38 > 0 and var_27_32 < var_27_38 then
					arg_24_1.talkMaxDuration = var_27_38

					if var_27_38 + var_27_31 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_38 + var_27_31
					end
				end

				arg_24_1.text_.text = var_27_35
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191006", "story_v_out_112191.awb") ~= 0 then
					local var_27_39 = manager.audio:GetVoiceLength("story_v_out_112191", "112191006", "story_v_out_112191.awb") / 1000

					if var_27_39 + var_27_31 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_39 + var_27_31
					end

					if var_27_34.prefab_name ~= "" and arg_24_1.actors_[var_27_34.prefab_name] ~= nil then
						local var_27_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_34.prefab_name].transform, "story_v_out_112191", "112191006", "story_v_out_112191.awb")

						arg_24_1:RecordAudio("112191006", var_27_40)
						arg_24_1:RecordAudio("112191006", var_27_40)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_112191", "112191006", "story_v_out_112191.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_112191", "112191006", "story_v_out_112191.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_41 = math.max(var_27_32, arg_24_1.talkMaxDuration)

			if var_27_31 <= arg_24_1.time_ and arg_24_1.time_ < var_27_31 + var_27_41 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_31) / var_27_41

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_31 + var_27_41 and arg_24_1.time_ < var_27_31 + var_27_41 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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

		arg_24_1:InitPlayNodeList()
	end,
	Play112191007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 112191007
		arg_28_1.duration_ = 8.5

		local var_28_0 = {
			ja = 6.966,
			ko = 6.933,
			zh = 7.566,
			en = 8.5
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
				arg_28_0:Play112191008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1081ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1081ui_story == nil then
				arg_28_1.var_.characterEffect1081ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.2

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1081ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1081ui_story then
				arg_28_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_31_4 = 0

			if var_31_4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			local var_31_5 = arg_28_1.actors_["1148ui_story"]
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1148ui_story == nil then
				arg_28_1.var_.characterEffect1148ui_story = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_7 = 0.2

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 and not isNil(var_31_5) then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7

				if arg_28_1.var_.characterEffect1148ui_story and not isNil(var_31_5) then
					local var_31_9 = Mathf.Lerp(0, 0.5, var_31_8)

					arg_28_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1148ui_story.fillRatio = var_31_9
				end
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1148ui_story then
				local var_31_10 = 0.5

				arg_28_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1148ui_story.fillRatio = var_31_10
			end

			local var_31_11 = 0

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_31_12 = 0
			local var_31_13 = 0.825

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_14 = arg_28_1:FormatText(StoryNameCfg[202].name)

				arg_28_1.leftNameTxt_.text = var_31_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_15 = arg_28_1:GetWordFromCfg(112191007)
				local var_31_16 = arg_28_1:FormatText(var_31_15.content)

				arg_28_1.text_.text = var_31_16

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_17 = 33
				local var_31_18 = utf8.len(var_31_16)
				local var_31_19 = var_31_17 <= 0 and var_31_13 or var_31_13 * (var_31_18 / var_31_17)

				if var_31_19 > 0 and var_31_13 < var_31_19 then
					arg_28_1.talkMaxDuration = var_31_19

					if var_31_19 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_19 + var_31_12
					end
				end

				arg_28_1.text_.text = var_31_16
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191007", "story_v_out_112191.awb") ~= 0 then
					local var_31_20 = manager.audio:GetVoiceLength("story_v_out_112191", "112191007", "story_v_out_112191.awb") / 1000

					if var_31_20 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_20 + var_31_12
					end

					if var_31_15.prefab_name ~= "" and arg_28_1.actors_[var_31_15.prefab_name] ~= nil then
						local var_31_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_15.prefab_name].transform, "story_v_out_112191", "112191007", "story_v_out_112191.awb")

						arg_28_1:RecordAudio("112191007", var_31_21)
						arg_28_1:RecordAudio("112191007", var_31_21)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_112191", "112191007", "story_v_out_112191.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_112191", "112191007", "story_v_out_112191.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_22 = math.max(var_31_13, arg_28_1.talkMaxDuration)

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_22 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_12) / var_31_22

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_12 + var_31_22 and arg_28_1.time_ < var_31_12 + var_31_22 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play112191008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 112191008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play112191009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1081ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1081ui_story == nil then
				arg_32_1.var_.characterEffect1081ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.2

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1081ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1081ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1081ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1081ui_story.fillRatio = var_35_5
			end

			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_2")
			end

			local var_35_7 = 0

			if var_35_7 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 then
				arg_32_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_35_8 = 0
			local var_35_9 = 0.95

			if var_35_8 < arg_32_1.time_ and arg_32_1.time_ <= var_35_8 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_10 = arg_32_1:FormatText(StoryNameCfg[7].name)

				arg_32_1.leftNameTxt_.text = var_35_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_11 = arg_32_1:GetWordFromCfg(112191008)
				local var_35_12 = arg_32_1:FormatText(var_35_11.content)

				arg_32_1.text_.text = var_35_12

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 38
				local var_35_14 = utf8.len(var_35_12)
				local var_35_15 = var_35_13 <= 0 and var_35_9 or var_35_9 * (var_35_14 / var_35_13)

				if var_35_15 > 0 and var_35_9 < var_35_15 then
					arg_32_1.talkMaxDuration = var_35_15

					if var_35_15 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_15 + var_35_8
					end
				end

				arg_32_1.text_.text = var_35_12
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_9, arg_32_1.talkMaxDuration)

			if var_35_8 <= arg_32_1.time_ and arg_32_1.time_ < var_35_8 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_8) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_8 + var_35_16 and arg_32_1.time_ < var_35_8 + var_35_16 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play112191009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 112191009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play112191010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1081ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1081ui_story = var_39_0.localPosition
			end

			local var_39_2 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2
				local var_39_4 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1081ui_story, var_39_4, var_39_3)

				local var_39_5 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_5.x, var_39_5.y, var_39_5.z)

				local var_39_6 = var_39_0.localEulerAngles

				var_39_6.z = 0
				var_39_6.x = 0
				var_39_0.localEulerAngles = var_39_6
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, 100, 0)

				local var_39_7 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_7.x, var_39_7.y, var_39_7.z)

				local var_39_8 = var_39_0.localEulerAngles

				var_39_8.z = 0
				var_39_8.x = 0
				var_39_0.localEulerAngles = var_39_8
			end

			local var_39_9 = arg_36_1.actors_["1148ui_story"].transform
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.var_.moveOldPos1148ui_story = var_39_9.localPosition
			end

			local var_39_11 = 0.001

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11
				local var_39_13 = Vector3.New(0, 100, 0)

				var_39_9.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1148ui_story, var_39_13, var_39_12)

				local var_39_14 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_14.x, var_39_14.y, var_39_14.z)

				local var_39_15 = var_39_9.localEulerAngles

				var_39_15.z = 0
				var_39_15.x = 0
				var_39_9.localEulerAngles = var_39_15
			end

			if arg_36_1.time_ >= var_39_10 + var_39_11 and arg_36_1.time_ < var_39_10 + var_39_11 + arg_39_0 then
				var_39_9.localPosition = Vector3.New(0, 100, 0)

				local var_39_16 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_16.x, var_39_16.y, var_39_16.z)

				local var_39_17 = var_39_9.localEulerAngles

				var_39_17.z = 0
				var_39_17.x = 0
				var_39_9.localEulerAngles = var_39_17
			end

			local var_39_18 = 0
			local var_39_19 = 1.075

			if var_39_18 < arg_36_1.time_ and arg_36_1.time_ <= var_39_18 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_20 = arg_36_1:GetWordFromCfg(112191009)
				local var_39_21 = arg_36_1:FormatText(var_39_20.content)

				arg_36_1.text_.text = var_39_21

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_22 = 43
				local var_39_23 = utf8.len(var_39_21)
				local var_39_24 = var_39_22 <= 0 and var_39_19 or var_39_19 * (var_39_23 / var_39_22)

				if var_39_24 > 0 and var_39_19 < var_39_24 then
					arg_36_1.talkMaxDuration = var_39_24

					if var_39_24 + var_39_18 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_24 + var_39_18
					end
				end

				arg_36_1.text_.text = var_39_21
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_25 = math.max(var_39_19, arg_36_1.talkMaxDuration)

			if var_39_18 <= arg_36_1.time_ and arg_36_1.time_ < var_39_18 + var_39_25 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_18) / var_39_25

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_18 + var_39_25 and arg_36_1.time_ < var_39_18 + var_39_25 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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

		arg_36_1:InitPlayNodeList()
	end,
	Play112191010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 112191010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play112191011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.725

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_2 = arg_40_1:GetWordFromCfg(112191010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 29
				local var_43_5 = utf8.len(var_43_3)
				local var_43_6 = var_43_4 <= 0 and var_43_1 or var_43_1 * (var_43_5 / var_43_4)

				if var_43_6 > 0 and var_43_1 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_7 and arg_40_1.time_ < var_43_0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play112191011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 112191011
		arg_44_1.duration_ = 9

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play112191012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "H02"

			if arg_44_1.bgs_[var_47_0] == nil then
				local var_47_1 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_47_0)
				var_47_1.name = var_47_0
				var_47_1.transform.parent = arg_44_1.stage_.transform
				var_47_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_[var_47_0] = var_47_1
			end

			local var_47_2 = 2

			if var_47_2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				local var_47_3 = manager.ui.mainCamera.transform.localPosition
				local var_47_4 = Vector3.New(0, 0, 10) + Vector3.New(var_47_3.x, var_47_3.y, 0)
				local var_47_5 = arg_44_1.bgs_.H02

				var_47_5.transform.localPosition = var_47_4
				var_47_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_6 = var_47_5:GetComponent("SpriteRenderer")

				if var_47_6 and var_47_6.sprite then
					local var_47_7 = (var_47_5.transform.localPosition - var_47_3).z
					local var_47_8 = manager.ui.mainCameraCom_
					local var_47_9 = 2 * var_47_7 * Mathf.Tan(var_47_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_47_10 = var_47_9 * var_47_8.aspect
					local var_47_11 = var_47_6.sprite.bounds.size.x
					local var_47_12 = var_47_6.sprite.bounds.size.y
					local var_47_13 = var_47_10 / var_47_11
					local var_47_14 = var_47_9 / var_47_12
					local var_47_15 = var_47_14 < var_47_13 and var_47_13 or var_47_14

					var_47_5.transform.localScale = Vector3.New(var_47_15, var_47_15, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "H02" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_17 = 2

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_17 then
				local var_47_18 = (arg_44_1.time_ - var_47_16) / var_47_17
				local var_47_19 = Color.New(0.02830189, 0.0262994, 0.0262994)

				var_47_19.a = Mathf.Lerp(0, 1, var_47_18)
				arg_44_1.mask_.color = var_47_19
			end

			if arg_44_1.time_ >= var_47_16 + var_47_17 and arg_44_1.time_ < var_47_16 + var_47_17 + arg_47_0 then
				local var_47_20 = Color.New(0.02830189, 0.0262994, 0.0262994)

				var_47_20.a = 1
				arg_44_1.mask_.color = var_47_20
			end

			local var_47_21 = 2

			if var_47_21 < arg_44_1.time_ and arg_44_1.time_ <= var_47_21 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_22 = 2

			if var_47_21 <= arg_44_1.time_ and arg_44_1.time_ < var_47_21 + var_47_22 then
				local var_47_23 = (arg_44_1.time_ - var_47_21) / var_47_22
				local var_47_24 = Color.New(0.03773582, 0.03542183, 0.03542183)

				var_47_24.a = Mathf.Lerp(1, 0, var_47_23)
				arg_44_1.mask_.color = var_47_24
			end

			if arg_44_1.time_ >= var_47_21 + var_47_22 and arg_44_1.time_ < var_47_21 + var_47_22 + arg_47_0 then
				local var_47_25 = Color.New(0.03773582, 0.03542183, 0.03542183)
				local var_47_26 = 0

				arg_44_1.mask_.enabled = false
				var_47_25.a = var_47_26
				arg_44_1.mask_.color = var_47_25
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_27 = 4
			local var_47_28 = 0.1

			if var_47_27 < arg_44_1.time_ and arg_44_1.time_ <= var_47_27 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_29 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_29:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_30 = arg_44_1:GetWordFromCfg(112191011)
				local var_47_31 = arg_44_1:FormatText(var_47_30.content)

				arg_44_1.text_.text = var_47_31

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_32 = 4
				local var_47_33 = utf8.len(var_47_31)
				local var_47_34 = var_47_32 <= 0 and var_47_28 or var_47_28 * (var_47_33 / var_47_32)

				if var_47_34 > 0 and var_47_28 < var_47_34 then
					arg_44_1.talkMaxDuration = var_47_34
					var_47_27 = var_47_27 + 0.3

					if var_47_34 + var_47_27 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_34 + var_47_27
					end
				end

				arg_44_1.text_.text = var_47_31
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_35 = var_47_27 + 0.3
			local var_47_36 = math.max(var_47_28, arg_44_1.talkMaxDuration)

			if var_47_35 <= arg_44_1.time_ and arg_44_1.time_ < var_47_35 + var_47_36 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_35) / var_47_36

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_35 + var_47_36 and arg_44_1.time_ < var_47_35 + var_47_36 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play112191012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 112191012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play112191013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 0.45

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_2 = arg_50_1:GetWordFromCfg(112191012)
				local var_53_3 = arg_50_1:FormatText(var_53_2.content)

				arg_50_1.text_.text = var_53_3

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 18
				local var_53_5 = utf8.len(var_53_3)
				local var_53_6 = var_53_4 <= 0 and var_53_1 or var_53_1 * (var_53_5 / var_53_4)

				if var_53_6 > 0 and var_53_1 < var_53_6 then
					arg_50_1.talkMaxDuration = var_53_6

					if var_53_6 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_6 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_3
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_7 and arg_50_1.time_ < var_53_0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play112191013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 112191013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play112191014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 0.275

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_2 = arg_54_1:FormatText(StoryNameCfg[7].name)

				arg_54_1.leftNameTxt_.text = var_57_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_3 = arg_54_1:GetWordFromCfg(112191013)
				local var_57_4 = arg_54_1:FormatText(var_57_3.content)

				arg_54_1.text_.text = var_57_4

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 11
				local var_57_6 = utf8.len(var_57_4)
				local var_57_7 = var_57_5 <= 0 and var_57_1 or var_57_1 * (var_57_6 / var_57_5)

				if var_57_7 > 0 and var_57_1 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_4
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_8 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_8 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_8

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_8 and arg_54_1.time_ < var_57_0 + var_57_8 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play112191014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 112191014
		arg_58_1.duration_ = 6.37

		local var_58_0 = {
			ja = 6.266,
			ko = 6.366,
			zh = 4.233,
			en = 4.1
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
				arg_58_0:Play112191015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = "1084ui_story"

			if arg_58_1.actors_[var_61_0] == nil then
				local var_61_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_61_1) then
					local var_61_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_58_1.stage_.transform)

					var_61_2.name = var_61_0
					var_61_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_58_1.actors_[var_61_0] = var_61_2

					local var_61_3 = var_61_2:GetComponentInChildren(typeof(CharacterEffect))

					var_61_3.enabled = true

					local var_61_4 = GameObjectTools.GetOrAddComponent(var_61_2, typeof(DynamicBoneHelper))

					if var_61_4 then
						var_61_4:EnableDynamicBone(false)
					end

					arg_58_1:ShowWeapon(var_61_3.transform, false)

					arg_58_1.var_[var_61_0 .. "Animator"] = var_61_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_58_1.var_[var_61_0 .. "Animator"].applyRootMotion = true
					arg_58_1.var_[var_61_0 .. "LipSync"] = var_61_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_61_5 = arg_58_1.actors_["1084ui_story"].transform
			local var_61_6 = 0

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.var_.moveOldPos1084ui_story = var_61_5.localPosition

				local var_61_7 = "1084ui_story"

				arg_58_1:ShowWeapon(arg_58_1.var_[var_61_7 .. "Animator"].transform, false)
			end

			local var_61_8 = 0.001

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_8 then
				local var_61_9 = (arg_58_1.time_ - var_61_6) / var_61_8
				local var_61_10 = Vector3.New(0, -0.97, -6)

				var_61_5.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1084ui_story, var_61_10, var_61_9)

				local var_61_11 = manager.ui.mainCamera.transform.position - var_61_5.position

				var_61_5.forward = Vector3.New(var_61_11.x, var_61_11.y, var_61_11.z)

				local var_61_12 = var_61_5.localEulerAngles

				var_61_12.z = 0
				var_61_12.x = 0
				var_61_5.localEulerAngles = var_61_12
			end

			if arg_58_1.time_ >= var_61_6 + var_61_8 and arg_58_1.time_ < var_61_6 + var_61_8 + arg_61_0 then
				var_61_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_61_13 = manager.ui.mainCamera.transform.position - var_61_5.position

				var_61_5.forward = Vector3.New(var_61_13.x, var_61_13.y, var_61_13.z)

				local var_61_14 = var_61_5.localEulerAngles

				var_61_14.z = 0
				var_61_14.x = 0
				var_61_5.localEulerAngles = var_61_14
			end

			local var_61_15 = arg_58_1.actors_["1084ui_story"]
			local var_61_16 = 0

			if var_61_16 < arg_58_1.time_ and arg_58_1.time_ <= var_61_16 + arg_61_0 and not isNil(var_61_15) and arg_58_1.var_.characterEffect1084ui_story == nil then
				arg_58_1.var_.characterEffect1084ui_story = var_61_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_17 = 0.2

			if var_61_16 <= arg_58_1.time_ and arg_58_1.time_ < var_61_16 + var_61_17 and not isNil(var_61_15) then
				local var_61_18 = (arg_58_1.time_ - var_61_16) / var_61_17

				if arg_58_1.var_.characterEffect1084ui_story and not isNil(var_61_15) then
					arg_58_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_16 + var_61_17 and arg_58_1.time_ < var_61_16 + var_61_17 + arg_61_0 and not isNil(var_61_15) and arg_58_1.var_.characterEffect1084ui_story then
				arg_58_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_61_19 = 0

			if var_61_19 < arg_58_1.time_ and arg_58_1.time_ <= var_61_19 + arg_61_0 then
				arg_58_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			local var_61_20 = 0

			if var_61_20 < arg_58_1.time_ and arg_58_1.time_ <= var_61_20 + arg_61_0 then
				arg_58_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_61_21 = 0
			local var_61_22 = 0.475

			if var_61_21 < arg_58_1.time_ and arg_58_1.time_ <= var_61_21 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_23 = arg_58_1:FormatText(StoryNameCfg[6].name)

				arg_58_1.leftNameTxt_.text = var_61_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_24 = arg_58_1:GetWordFromCfg(112191014)
				local var_61_25 = arg_58_1:FormatText(var_61_24.content)

				arg_58_1.text_.text = var_61_25

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_26 = 19
				local var_61_27 = utf8.len(var_61_25)
				local var_61_28 = var_61_26 <= 0 and var_61_22 or var_61_22 * (var_61_27 / var_61_26)

				if var_61_28 > 0 and var_61_22 < var_61_28 then
					arg_58_1.talkMaxDuration = var_61_28

					if var_61_28 + var_61_21 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_28 + var_61_21
					end
				end

				arg_58_1.text_.text = var_61_25
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191014", "story_v_out_112191.awb") ~= 0 then
					local var_61_29 = manager.audio:GetVoiceLength("story_v_out_112191", "112191014", "story_v_out_112191.awb") / 1000

					if var_61_29 + var_61_21 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_29 + var_61_21
					end

					if var_61_24.prefab_name ~= "" and arg_58_1.actors_[var_61_24.prefab_name] ~= nil then
						local var_61_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_24.prefab_name].transform, "story_v_out_112191", "112191014", "story_v_out_112191.awb")

						arg_58_1:RecordAudio("112191014", var_61_30)
						arg_58_1:RecordAudio("112191014", var_61_30)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_112191", "112191014", "story_v_out_112191.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_112191", "112191014", "story_v_out_112191.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_31 = math.max(var_61_22, arg_58_1.talkMaxDuration)

			if var_61_21 <= arg_58_1.time_ and arg_58_1.time_ < var_61_21 + var_61_31 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_21) / var_61_31

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_21 + var_61_31 and arg_58_1.time_ < var_61_21 + var_61_31 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
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

		arg_58_1:InitPlayNodeList()
	end,
	Play112191015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 112191015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play112191016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1084ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1084ui_story == nil then
				arg_62_1.var_.characterEffect1084ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.2

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1084ui_story and not isNil(var_65_0) then
					local var_65_4 = Mathf.Lerp(0, 0.5, var_65_3)

					arg_62_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1084ui_story.fillRatio = var_65_4
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1084ui_story then
				local var_65_5 = 0.5

				arg_62_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1084ui_story.fillRatio = var_65_5
			end

			local var_65_6 = 0
			local var_65_7 = 0.4

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[7].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_9 = arg_62_1:GetWordFromCfg(112191015)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 16
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
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_14 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_14 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_14

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_14 and arg_62_1.time_ < var_65_6 + var_65_14 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play112191016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 112191016
		arg_66_1.duration_ = 2.87

		local var_66_0 = {
			ja = 2.4,
			ko = 2.866,
			zh = 1.999999999999,
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
				arg_66_0:Play112191017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1084ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1084ui_story == nil then
				arg_66_1.var_.characterEffect1084ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.2

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1084ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1084ui_story then
				arg_66_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_69_4 = 0

			if var_69_4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action496")
			end

			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_69_6 = 0
			local var_69_7 = 0.15

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_8 = arg_66_1:FormatText(StoryNameCfg[6].name)

				arg_66_1.leftNameTxt_.text = var_69_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_9 = arg_66_1:GetWordFromCfg(112191016)
				local var_69_10 = arg_66_1:FormatText(var_69_9.content)

				arg_66_1.text_.text = var_69_10

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 6
				local var_69_12 = utf8.len(var_69_10)
				local var_69_13 = var_69_11 <= 0 and var_69_7 or var_69_7 * (var_69_12 / var_69_11)

				if var_69_13 > 0 and var_69_7 < var_69_13 then
					arg_66_1.talkMaxDuration = var_69_13

					if var_69_13 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_13 + var_69_6
					end
				end

				arg_66_1.text_.text = var_69_10
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191016", "story_v_out_112191.awb") ~= 0 then
					local var_69_14 = manager.audio:GetVoiceLength("story_v_out_112191", "112191016", "story_v_out_112191.awb") / 1000

					if var_69_14 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_14 + var_69_6
					end

					if var_69_9.prefab_name ~= "" and arg_66_1.actors_[var_69_9.prefab_name] ~= nil then
						local var_69_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_9.prefab_name].transform, "story_v_out_112191", "112191016", "story_v_out_112191.awb")

						arg_66_1:RecordAudio("112191016", var_69_15)
						arg_66_1:RecordAudio("112191016", var_69_15)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_112191", "112191016", "story_v_out_112191.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_112191", "112191016", "story_v_out_112191.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_16 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_16 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_16

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_16 and arg_66_1.time_ < var_69_6 + var_69_16 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play112191017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 112191017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play112191018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1084ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1084ui_story == nil then
				arg_70_1.var_.characterEffect1084ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect1084ui_story and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1084ui_story.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1084ui_story then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1084ui_story.fillRatio = var_73_5
			end

			local var_73_6 = 0
			local var_73_7 = 0.475

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_8 = arg_70_1:FormatText(StoryNameCfg[7].name)

				arg_70_1.leftNameTxt_.text = var_73_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_9 = arg_70_1:GetWordFromCfg(112191017)
				local var_73_10 = arg_70_1:FormatText(var_73_9.content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 19
				local var_73_12 = utf8.len(var_73_10)
				local var_73_13 = var_73_11 <= 0 and var_73_7 or var_73_7 * (var_73_12 / var_73_11)

				if var_73_13 > 0 and var_73_7 < var_73_13 then
					arg_70_1.talkMaxDuration = var_73_13

					if var_73_13 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_13 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_10
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_14 and arg_70_1.time_ < var_73_6 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play112191018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 112191018
		arg_74_1.duration_ = 3.3

		local var_74_0 = {
			ja = 2.666,
			ko = 3.3,
			zh = 2.333,
			en = 2.6
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
				arg_74_0:Play112191019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1084ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1084ui_story == nil then
				arg_74_1.var_.characterEffect1084ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.2

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect1084ui_story and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1084ui_story then
				arg_74_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_77_4 = 0

			if var_77_4 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action465")
			end

			local var_77_5 = 0

			if var_77_5 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 then
				arg_74_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_77_6 = 0
			local var_77_7 = 0.25

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_8 = arg_74_1:FormatText(StoryNameCfg[6].name)

				arg_74_1.leftNameTxt_.text = var_77_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_9 = arg_74_1:GetWordFromCfg(112191018)
				local var_77_10 = arg_74_1:FormatText(var_77_9.content)

				arg_74_1.text_.text = var_77_10

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_11 = 10
				local var_77_12 = utf8.len(var_77_10)
				local var_77_13 = var_77_11 <= 0 and var_77_7 or var_77_7 * (var_77_12 / var_77_11)

				if var_77_13 > 0 and var_77_7 < var_77_13 then
					arg_74_1.talkMaxDuration = var_77_13

					if var_77_13 + var_77_6 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_13 + var_77_6
					end
				end

				arg_74_1.text_.text = var_77_10
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191018", "story_v_out_112191.awb") ~= 0 then
					local var_77_14 = manager.audio:GetVoiceLength("story_v_out_112191", "112191018", "story_v_out_112191.awb") / 1000

					if var_77_14 + var_77_6 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_14 + var_77_6
					end

					if var_77_9.prefab_name ~= "" and arg_74_1.actors_[var_77_9.prefab_name] ~= nil then
						local var_77_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_9.prefab_name].transform, "story_v_out_112191", "112191018", "story_v_out_112191.awb")

						arg_74_1:RecordAudio("112191018", var_77_15)
						arg_74_1:RecordAudio("112191018", var_77_15)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_112191", "112191018", "story_v_out_112191.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_112191", "112191018", "story_v_out_112191.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_16 = math.max(var_77_7, arg_74_1.talkMaxDuration)

			if var_77_6 <= arg_74_1.time_ and arg_74_1.time_ < var_77_6 + var_77_16 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_6) / var_77_16

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_6 + var_77_16 and arg_74_1.time_ < var_77_6 + var_77_16 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play112191019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 112191019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play112191020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1084ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos1084ui_story = var_81_0.localPosition
			end

			local var_81_2 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2
				local var_81_4 = Vector3.New(0, 100, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1084ui_story, var_81_4, var_81_3)

				local var_81_5 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_5.x, var_81_5.y, var_81_5.z)

				local var_81_6 = var_81_0.localEulerAngles

				var_81_6.z = 0
				var_81_6.x = 0
				var_81_0.localEulerAngles = var_81_6
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0, 100, 0)

				local var_81_7 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_7.x, var_81_7.y, var_81_7.z)

				local var_81_8 = var_81_0.localEulerAngles

				var_81_8.z = 0
				var_81_8.x = 0
				var_81_0.localEulerAngles = var_81_8
			end

			local var_81_9 = 0
			local var_81_10 = 0.925

			if var_81_9 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_11 = arg_78_1:GetWordFromCfg(112191019)
				local var_81_12 = arg_78_1:FormatText(var_81_11.content)

				arg_78_1.text_.text = var_81_12

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_13 = 37
				local var_81_14 = utf8.len(var_81_12)
				local var_81_15 = var_81_13 <= 0 and var_81_10 or var_81_10 * (var_81_14 / var_81_13)

				if var_81_15 > 0 and var_81_10 < var_81_15 then
					arg_78_1.talkMaxDuration = var_81_15

					if var_81_15 + var_81_9 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_15 + var_81_9
					end
				end

				arg_78_1.text_.text = var_81_12
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_16 = math.max(var_81_10, arg_78_1.talkMaxDuration)

			if var_81_9 <= arg_78_1.time_ and arg_78_1.time_ < var_81_9 + var_81_16 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_9) / var_81_16

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_9 + var_81_16 and arg_78_1.time_ < var_81_9 + var_81_16 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
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

		arg_78_1:InitPlayNodeList()
	end,
	Play112191020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 112191020
		arg_82_1.duration_ = 7.6

		local var_82_0 = {
			ja = 7.6,
			ko = 6.333,
			zh = 5.566,
			en = 6.333
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
				arg_82_0:Play112191021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = "1027ui_story"

			if arg_82_1.actors_[var_85_0] == nil then
				local var_85_1 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_85_1) then
					local var_85_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_82_1.stage_.transform)

					var_85_2.name = var_85_0
					var_85_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_82_1.actors_[var_85_0] = var_85_2

					local var_85_3 = var_85_2:GetComponentInChildren(typeof(CharacterEffect))

					var_85_3.enabled = true

					local var_85_4 = GameObjectTools.GetOrAddComponent(var_85_2, typeof(DynamicBoneHelper))

					if var_85_4 then
						var_85_4:EnableDynamicBone(false)
					end

					arg_82_1:ShowWeapon(var_85_3.transform, false)

					arg_82_1.var_[var_85_0 .. "Animator"] = var_85_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_82_1.var_[var_85_0 .. "Animator"].applyRootMotion = true
					arg_82_1.var_[var_85_0 .. "LipSync"] = var_85_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_85_5 = arg_82_1.actors_["1027ui_story"].transform
			local var_85_6 = 0

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.var_.moveOldPos1027ui_story = var_85_5.localPosition

				local var_85_7 = "1027ui_story"

				arg_82_1:ShowWeapon(arg_82_1.var_[var_85_7 .. "Animator"].transform, false)
			end

			local var_85_8 = 0.001

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_8 then
				local var_85_9 = (arg_82_1.time_ - var_85_6) / var_85_8
				local var_85_10 = Vector3.New(0, -0.81, -5.8)

				var_85_5.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1027ui_story, var_85_10, var_85_9)

				local var_85_11 = manager.ui.mainCamera.transform.position - var_85_5.position

				var_85_5.forward = Vector3.New(var_85_11.x, var_85_11.y, var_85_11.z)

				local var_85_12 = var_85_5.localEulerAngles

				var_85_12.z = 0
				var_85_12.x = 0
				var_85_5.localEulerAngles = var_85_12
			end

			if arg_82_1.time_ >= var_85_6 + var_85_8 and arg_82_1.time_ < var_85_6 + var_85_8 + arg_85_0 then
				var_85_5.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_85_13 = manager.ui.mainCamera.transform.position - var_85_5.position

				var_85_5.forward = Vector3.New(var_85_13.x, var_85_13.y, var_85_13.z)

				local var_85_14 = var_85_5.localEulerAngles

				var_85_14.z = 0
				var_85_14.x = 0
				var_85_5.localEulerAngles = var_85_14
			end

			local var_85_15 = arg_82_1.actors_["1027ui_story"]
			local var_85_16 = 0

			if var_85_16 < arg_82_1.time_ and arg_82_1.time_ <= var_85_16 + arg_85_0 and not isNil(var_85_15) and arg_82_1.var_.characterEffect1027ui_story == nil then
				arg_82_1.var_.characterEffect1027ui_story = var_85_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_17 = 0.2

			if var_85_16 <= arg_82_1.time_ and arg_82_1.time_ < var_85_16 + var_85_17 and not isNil(var_85_15) then
				local var_85_18 = (arg_82_1.time_ - var_85_16) / var_85_17

				if arg_82_1.var_.characterEffect1027ui_story and not isNil(var_85_15) then
					arg_82_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_16 + var_85_17 and arg_82_1.time_ < var_85_16 + var_85_17 + arg_85_0 and not isNil(var_85_15) and arg_82_1.var_.characterEffect1027ui_story then
				arg_82_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_85_19 = 0

			if var_85_19 < arg_82_1.time_ and arg_82_1.time_ <= var_85_19 + arg_85_0 then
				arg_82_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_85_20 = 0

			if var_85_20 < arg_82_1.time_ and arg_82_1.time_ <= var_85_20 + arg_85_0 then
				arg_82_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_85_21 = 0
			local var_85_22 = 0.6

			if var_85_21 < arg_82_1.time_ and arg_82_1.time_ <= var_85_21 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_23 = arg_82_1:FormatText(StoryNameCfg[56].name)

				arg_82_1.leftNameTxt_.text = var_85_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_24 = arg_82_1:GetWordFromCfg(112191020)
				local var_85_25 = arg_82_1:FormatText(var_85_24.content)

				arg_82_1.text_.text = var_85_25

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_26 = 24
				local var_85_27 = utf8.len(var_85_25)
				local var_85_28 = var_85_26 <= 0 and var_85_22 or var_85_22 * (var_85_27 / var_85_26)

				if var_85_28 > 0 and var_85_22 < var_85_28 then
					arg_82_1.talkMaxDuration = var_85_28

					if var_85_28 + var_85_21 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_28 + var_85_21
					end
				end

				arg_82_1.text_.text = var_85_25
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191020", "story_v_out_112191.awb") ~= 0 then
					local var_85_29 = manager.audio:GetVoiceLength("story_v_out_112191", "112191020", "story_v_out_112191.awb") / 1000

					if var_85_29 + var_85_21 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_29 + var_85_21
					end

					if var_85_24.prefab_name ~= "" and arg_82_1.actors_[var_85_24.prefab_name] ~= nil then
						local var_85_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_24.prefab_name].transform, "story_v_out_112191", "112191020", "story_v_out_112191.awb")

						arg_82_1:RecordAudio("112191020", var_85_30)
						arg_82_1:RecordAudio("112191020", var_85_30)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_112191", "112191020", "story_v_out_112191.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_112191", "112191020", "story_v_out_112191.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_31 = math.max(var_85_22, arg_82_1.talkMaxDuration)

			if var_85_21 <= arg_82_1.time_ and arg_82_1.time_ < var_85_21 + var_85_31 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_21) / var_85_31

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_21 + var_85_31 and arg_82_1.time_ < var_85_21 + var_85_31 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play112191021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 112191021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play112191022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1027ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1027ui_story == nil then
				arg_86_1.var_.characterEffect1027ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1027ui_story and not isNil(var_89_0) then
					local var_89_4 = Mathf.Lerp(0, 0.5, var_89_3)

					arg_86_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1027ui_story.fillRatio = var_89_4
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1027ui_story then
				local var_89_5 = 0.5

				arg_86_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1027ui_story.fillRatio = var_89_5
			end

			local var_89_6 = 0

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_89_7 = 0
			local var_89_8 = 0.125

			if var_89_7 < arg_86_1.time_ and arg_86_1.time_ <= var_89_7 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_9 = arg_86_1:FormatText(StoryNameCfg[7].name)

				arg_86_1.leftNameTxt_.text = var_89_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_10 = arg_86_1:GetWordFromCfg(112191021)
				local var_89_11 = arg_86_1:FormatText(var_89_10.content)

				arg_86_1.text_.text = var_89_11

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_12 = 5
				local var_89_13 = utf8.len(var_89_11)
				local var_89_14 = var_89_12 <= 0 and var_89_8 or var_89_8 * (var_89_13 / var_89_12)

				if var_89_14 > 0 and var_89_8 < var_89_14 then
					arg_86_1.talkMaxDuration = var_89_14

					if var_89_14 + var_89_7 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_14 + var_89_7
					end
				end

				arg_86_1.text_.text = var_89_11
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_15 = math.max(var_89_8, arg_86_1.talkMaxDuration)

			if var_89_7 <= arg_86_1.time_ and arg_86_1.time_ < var_89_7 + var_89_15 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_7) / var_89_15

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_7 + var_89_15 and arg_86_1.time_ < var_89_7 + var_89_15 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play112191022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 112191022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play112191023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1027ui_story"].transform
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.var_.moveOldPos1027ui_story = var_93_0.localPosition

				local var_93_2 = "1027ui_story"

				arg_90_1:ShowWeapon(arg_90_1.var_[var_93_2 .. "Animator"].transform, false)
			end

			local var_93_3 = 0.001

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_3 then
				local var_93_4 = (arg_90_1.time_ - var_93_1) / var_93_3
				local var_93_5 = Vector3.New(0, 100, 0)

				var_93_0.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1027ui_story, var_93_5, var_93_4)

				local var_93_6 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_6.x, var_93_6.y, var_93_6.z)

				local var_93_7 = var_93_0.localEulerAngles

				var_93_7.z = 0
				var_93_7.x = 0
				var_93_0.localEulerAngles = var_93_7
			end

			if arg_90_1.time_ >= var_93_1 + var_93_3 and arg_90_1.time_ < var_93_1 + var_93_3 + arg_93_0 then
				var_93_0.localPosition = Vector3.New(0, 100, 0)

				local var_93_8 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_8.x, var_93_8.y, var_93_8.z)

				local var_93_9 = var_93_0.localEulerAngles

				var_93_9.z = 0
				var_93_9.x = 0
				var_93_0.localEulerAngles = var_93_9
			end

			local var_93_10 = 0
			local var_93_11 = 1.15

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_12 = arg_90_1:GetWordFromCfg(112191022)
				local var_93_13 = arg_90_1:FormatText(var_93_12.content)

				arg_90_1.text_.text = var_93_13

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_14 = 46
				local var_93_15 = utf8.len(var_93_13)
				local var_93_16 = var_93_14 <= 0 and var_93_11 or var_93_11 * (var_93_15 / var_93_14)

				if var_93_16 > 0 and var_93_11 < var_93_16 then
					arg_90_1.talkMaxDuration = var_93_16

					if var_93_16 + var_93_10 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_16 + var_93_10
					end
				end

				arg_90_1.text_.text = var_93_13
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_17 = math.max(var_93_11, arg_90_1.talkMaxDuration)

			if var_93_10 <= arg_90_1.time_ and arg_90_1.time_ < var_93_10 + var_93_17 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_10) / var_93_17

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_10 + var_93_17 and arg_90_1.time_ < var_93_10 + var_93_17 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play112191023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 112191023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play112191024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 1.175

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_2 = arg_94_1:GetWordFromCfg(112191023)
				local var_97_3 = arg_94_1:FormatText(var_97_2.content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 47
				local var_97_5 = utf8.len(var_97_3)
				local var_97_6 = var_97_4 <= 0 and var_97_1 or var_97_1 * (var_97_5 / var_97_4)

				if var_97_6 > 0 and var_97_1 < var_97_6 then
					arg_94_1.talkMaxDuration = var_97_6

					if var_97_6 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_6 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_7 and arg_94_1.time_ < var_97_0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play112191024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 112191024
		arg_98_1.duration_ = 7.53

		local var_98_0 = {
			ja = 5.733,
			ko = 6.3,
			zh = 6.1,
			en = 7.533
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
				arg_98_0:Play112191025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1084ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos1084ui_story = var_101_0.localPosition
			end

			local var_101_2 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2
				local var_101_4 = Vector3.New(0.7, -0.97, -6)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1084ui_story, var_101_4, var_101_3)

				local var_101_5 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_5.x, var_101_5.y, var_101_5.z)

				local var_101_6 = var_101_0.localEulerAngles

				var_101_6.z = 0
				var_101_6.x = 0
				var_101_0.localEulerAngles = var_101_6
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_101_7 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_7.x, var_101_7.y, var_101_7.z)

				local var_101_8 = var_101_0.localEulerAngles

				var_101_8.z = 0
				var_101_8.x = 0
				var_101_0.localEulerAngles = var_101_8
			end

			local var_101_9 = 0

			if var_101_9 < arg_98_1.time_ and arg_98_1.time_ <= var_101_9 + arg_101_0 then
				arg_98_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
				arg_98_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_101_11 = arg_98_1.actors_["1084ui_story"]
			local var_101_12 = 0

			if var_101_12 < arg_98_1.time_ and arg_98_1.time_ <= var_101_12 + arg_101_0 and not isNil(var_101_11) and arg_98_1.var_.characterEffect1084ui_story == nil then
				arg_98_1.var_.characterEffect1084ui_story = var_101_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_13 = 0.2

			if var_101_12 <= arg_98_1.time_ and arg_98_1.time_ < var_101_12 + var_101_13 and not isNil(var_101_11) then
				local var_101_14 = (arg_98_1.time_ - var_101_12) / var_101_13

				if arg_98_1.var_.characterEffect1084ui_story and not isNil(var_101_11) then
					arg_98_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_12 + var_101_13 and arg_98_1.time_ < var_101_12 + var_101_13 + arg_101_0 and not isNil(var_101_11) and arg_98_1.var_.characterEffect1084ui_story then
				arg_98_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_101_15 = 0
			local var_101_16 = 0.575

			if var_101_15 < arg_98_1.time_ and arg_98_1.time_ <= var_101_15 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_17 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_17:setOnUpdate(LuaHelper.FloatAction(function(arg_102_0)
					arg_98_1.dialogCg_.alpha = arg_102_0
				end))
				var_101_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_18 = arg_98_1:FormatText(StoryNameCfg[6].name)

				arg_98_1.leftNameTxt_.text = var_101_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_19 = arg_98_1:GetWordFromCfg(112191024)
				local var_101_20 = arg_98_1:FormatText(var_101_19.content)

				arg_98_1.text_.text = var_101_20

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_21 = 23
				local var_101_22 = utf8.len(var_101_20)
				local var_101_23 = var_101_21 <= 0 and var_101_16 or var_101_16 * (var_101_22 / var_101_21)

				if var_101_23 > 0 and var_101_16 < var_101_23 then
					arg_98_1.talkMaxDuration = var_101_23
					var_101_15 = var_101_15 + 0.3

					if var_101_23 + var_101_15 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_23 + var_101_15
					end
				end

				arg_98_1.text_.text = var_101_20
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191024", "story_v_out_112191.awb") ~= 0 then
					local var_101_24 = manager.audio:GetVoiceLength("story_v_out_112191", "112191024", "story_v_out_112191.awb") / 1000

					if var_101_24 + var_101_15 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_24 + var_101_15
					end

					if var_101_19.prefab_name ~= "" and arg_98_1.actors_[var_101_19.prefab_name] ~= nil then
						local var_101_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_19.prefab_name].transform, "story_v_out_112191", "112191024", "story_v_out_112191.awb")

						arg_98_1:RecordAudio("112191024", var_101_25)
						arg_98_1:RecordAudio("112191024", var_101_25)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_112191", "112191024", "story_v_out_112191.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_112191", "112191024", "story_v_out_112191.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_26 = var_101_15 + 0.3
			local var_101_27 = math.max(var_101_16, arg_98_1.talkMaxDuration)

			if var_101_26 <= arg_98_1.time_ and arg_98_1.time_ < var_101_26 + var_101_27 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_26) / var_101_27

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_26 + var_101_27 and arg_98_1.time_ < var_101_26 + var_101_27 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play112191025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 112191025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play112191026(arg_104_1)
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
			local var_107_7 = 0.35

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_8 = arg_104_1:FormatText(StoryNameCfg[7].name)

				arg_104_1.leftNameTxt_.text = var_107_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_9 = arg_104_1:GetWordFromCfg(112191025)
				local var_107_10 = arg_104_1:FormatText(var_107_9.content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 14
				local var_107_12 = utf8.len(var_107_10)
				local var_107_13 = var_107_11 <= 0 and var_107_7 or var_107_7 * (var_107_12 / var_107_11)

				if var_107_13 > 0 and var_107_7 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_10
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_14 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_14 and arg_104_1.time_ < var_107_6 + var_107_14 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play112191026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 112191026
		arg_108_1.duration_ = 18.93

		local var_108_0 = {
			ja = 13.466,
			ko = 7.066,
			zh = 10.2,
			en = 18.933
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
				arg_108_0:Play112191027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1027ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1027ui_story == nil then
				arg_108_1.var_.characterEffect1027ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.2

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1027ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1027ui_story then
				arg_108_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_111_4 = 0

			if var_111_4 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action424")
			end

			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_111_6 = arg_108_1.actors_["1027ui_story"].transform
			local var_111_7 = 0

			if var_111_7 < arg_108_1.time_ and arg_108_1.time_ <= var_111_7 + arg_111_0 then
				arg_108_1.var_.moveOldPos1027ui_story = var_111_6.localPosition
			end

			local var_111_8 = 0.001

			if var_111_7 <= arg_108_1.time_ and arg_108_1.time_ < var_111_7 + var_111_8 then
				local var_111_9 = (arg_108_1.time_ - var_111_7) / var_111_8
				local var_111_10 = Vector3.New(-0.7, -0.81, -5.8)

				var_111_6.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1027ui_story, var_111_10, var_111_9)

				local var_111_11 = manager.ui.mainCamera.transform.position - var_111_6.position

				var_111_6.forward = Vector3.New(var_111_11.x, var_111_11.y, var_111_11.z)

				local var_111_12 = var_111_6.localEulerAngles

				var_111_12.z = 0
				var_111_12.x = 0
				var_111_6.localEulerAngles = var_111_12
			end

			if arg_108_1.time_ >= var_111_7 + var_111_8 and arg_108_1.time_ < var_111_7 + var_111_8 + arg_111_0 then
				var_111_6.localPosition = Vector3.New(-0.7, -0.81, -5.8)

				local var_111_13 = manager.ui.mainCamera.transform.position - var_111_6.position

				var_111_6.forward = Vector3.New(var_111_13.x, var_111_13.y, var_111_13.z)

				local var_111_14 = var_111_6.localEulerAngles

				var_111_14.z = 0
				var_111_14.x = 0
				var_111_6.localEulerAngles = var_111_14
			end

			local var_111_15 = 0
			local var_111_16 = 0.95

			if var_111_15 < arg_108_1.time_ and arg_108_1.time_ <= var_111_15 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_17 = arg_108_1:FormatText(StoryNameCfg[56].name)

				arg_108_1.leftNameTxt_.text = var_111_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_18 = arg_108_1:GetWordFromCfg(112191026)
				local var_111_19 = arg_108_1:FormatText(var_111_18.content)

				arg_108_1.text_.text = var_111_19

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_20 = 38
				local var_111_21 = utf8.len(var_111_19)
				local var_111_22 = var_111_20 <= 0 and var_111_16 or var_111_16 * (var_111_21 / var_111_20)

				if var_111_22 > 0 and var_111_16 < var_111_22 then
					arg_108_1.talkMaxDuration = var_111_22

					if var_111_22 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_22 + var_111_15
					end
				end

				arg_108_1.text_.text = var_111_19
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191026", "story_v_out_112191.awb") ~= 0 then
					local var_111_23 = manager.audio:GetVoiceLength("story_v_out_112191", "112191026", "story_v_out_112191.awb") / 1000

					if var_111_23 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_23 + var_111_15
					end

					if var_111_18.prefab_name ~= "" and arg_108_1.actors_[var_111_18.prefab_name] ~= nil then
						local var_111_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_18.prefab_name].transform, "story_v_out_112191", "112191026", "story_v_out_112191.awb")

						arg_108_1:RecordAudio("112191026", var_111_24)
						arg_108_1:RecordAudio("112191026", var_111_24)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_112191", "112191026", "story_v_out_112191.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_112191", "112191026", "story_v_out_112191.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_25 = math.max(var_111_16, arg_108_1.talkMaxDuration)

			if var_111_15 <= arg_108_1.time_ and arg_108_1.time_ < var_111_15 + var_111_25 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_15) / var_111_25

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_15 + var_111_25 and arg_108_1.time_ < var_111_15 + var_111_25 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play112191027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 112191027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play112191028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1027ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1027ui_story == nil then
				arg_112_1.var_.characterEffect1027ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1027ui_story and not isNil(var_115_0) then
					local var_115_4 = Mathf.Lerp(0, 0.5, var_115_3)

					arg_112_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1027ui_story.fillRatio = var_115_4
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1027ui_story then
				local var_115_5 = 0.5

				arg_112_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1027ui_story.fillRatio = var_115_5
			end

			local var_115_6 = 0

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_115_7 = arg_112_1.actors_["1084ui_story"].transform
			local var_115_8 = 0

			if var_115_8 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 then
				arg_112_1.var_.moveOldPos1084ui_story = var_115_7.localPosition
			end

			local var_115_9 = 0.001

			if var_115_8 <= arg_112_1.time_ and arg_112_1.time_ < var_115_8 + var_115_9 then
				local var_115_10 = (arg_112_1.time_ - var_115_8) / var_115_9
				local var_115_11 = Vector3.New(0, 100, 0)

				var_115_7.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1084ui_story, var_115_11, var_115_10)

				local var_115_12 = manager.ui.mainCamera.transform.position - var_115_7.position

				var_115_7.forward = Vector3.New(var_115_12.x, var_115_12.y, var_115_12.z)

				local var_115_13 = var_115_7.localEulerAngles

				var_115_13.z = 0
				var_115_13.x = 0
				var_115_7.localEulerAngles = var_115_13
			end

			if arg_112_1.time_ >= var_115_8 + var_115_9 and arg_112_1.time_ < var_115_8 + var_115_9 + arg_115_0 then
				var_115_7.localPosition = Vector3.New(0, 100, 0)

				local var_115_14 = manager.ui.mainCamera.transform.position - var_115_7.position

				var_115_7.forward = Vector3.New(var_115_14.x, var_115_14.y, var_115_14.z)

				local var_115_15 = var_115_7.localEulerAngles

				var_115_15.z = 0
				var_115_15.x = 0
				var_115_7.localEulerAngles = var_115_15
			end

			local var_115_16 = arg_112_1.actors_["1027ui_story"].transform
			local var_115_17 = 0

			if var_115_17 < arg_112_1.time_ and arg_112_1.time_ <= var_115_17 + arg_115_0 then
				arg_112_1.var_.moveOldPos1027ui_story = var_115_16.localPosition
			end

			local var_115_18 = 0.001

			if var_115_17 <= arg_112_1.time_ and arg_112_1.time_ < var_115_17 + var_115_18 then
				local var_115_19 = (arg_112_1.time_ - var_115_17) / var_115_18
				local var_115_20 = Vector3.New(0, 100, 0)

				var_115_16.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1027ui_story, var_115_20, var_115_19)

				local var_115_21 = manager.ui.mainCamera.transform.position - var_115_16.position

				var_115_16.forward = Vector3.New(var_115_21.x, var_115_21.y, var_115_21.z)

				local var_115_22 = var_115_16.localEulerAngles

				var_115_22.z = 0
				var_115_22.x = 0
				var_115_16.localEulerAngles = var_115_22
			end

			if arg_112_1.time_ >= var_115_17 + var_115_18 and arg_112_1.time_ < var_115_17 + var_115_18 + arg_115_0 then
				var_115_16.localPosition = Vector3.New(0, 100, 0)

				local var_115_23 = manager.ui.mainCamera.transform.position - var_115_16.position

				var_115_16.forward = Vector3.New(var_115_23.x, var_115_23.y, var_115_23.z)

				local var_115_24 = var_115_16.localEulerAngles

				var_115_24.z = 0
				var_115_24.x = 0
				var_115_16.localEulerAngles = var_115_24
			end

			local var_115_25 = manager.ui.mainCamera.transform
			local var_115_26 = 0

			if var_115_26 < arg_112_1.time_ and arg_112_1.time_ <= var_115_26 + arg_115_0 then
				arg_112_1.var_.shakeOldPos = var_115_25.localPosition
			end

			local var_115_27 = 0.5

			if var_115_26 <= arg_112_1.time_ and arg_112_1.time_ < var_115_26 + var_115_27 then
				local var_115_28 = (arg_112_1.time_ - var_115_26) / 0.099
				local var_115_29, var_115_30 = math.modf(var_115_28)

				var_115_25.localPosition = Vector3.New(var_115_30 * 0.13, var_115_30 * 0.13, var_115_30 * 0.13) + arg_112_1.var_.shakeOldPos
			end

			if arg_112_1.time_ >= var_115_26 + var_115_27 and arg_112_1.time_ < var_115_26 + var_115_27 + arg_115_0 then
				var_115_25.localPosition = arg_112_1.var_.shakeOldPos
			end

			local var_115_31 = 0
			local var_115_32 = 0.675

			if var_115_31 < arg_112_1.time_ and arg_112_1.time_ <= var_115_31 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_33 = arg_112_1:GetWordFromCfg(112191027)
				local var_115_34 = arg_112_1:FormatText(var_115_33.content)

				arg_112_1.text_.text = var_115_34

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_35 = 27
				local var_115_36 = utf8.len(var_115_34)
				local var_115_37 = var_115_35 <= 0 and var_115_32 or var_115_32 * (var_115_36 / var_115_35)

				if var_115_37 > 0 and var_115_32 < var_115_37 then
					arg_112_1.talkMaxDuration = var_115_37

					if var_115_37 + var_115_31 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_37 + var_115_31
					end
				end

				arg_112_1.text_.text = var_115_34
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_38 = math.max(var_115_32, arg_112_1.talkMaxDuration)

			if var_115_31 <= arg_112_1.time_ and arg_112_1.time_ < var_115_31 + var_115_38 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_31) / var_115_38

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_31 + var_115_38 and arg_112_1.time_ < var_115_31 + var_115_38 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
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
	Play112191028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 112191028
		arg_116_1.duration_ = 3.23

		local var_116_0 = {
			ja = 3.233,
			ko = 1.999999999999,
			zh = 2.933,
			en = 3.033
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
				arg_116_0:Play112191029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1027ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1027ui_story == nil then
				arg_116_1.var_.characterEffect1027ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.2

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1027ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1027ui_story then
				arg_116_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_119_4 = arg_116_1.actors_["1084ui_story"]
			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect1084ui_story == nil then
				arg_116_1.var_.characterEffect1084ui_story = var_119_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_6 = 0.2

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_6 and not isNil(var_119_4) then
				local var_119_7 = (arg_116_1.time_ - var_119_5) / var_119_6

				if arg_116_1.var_.characterEffect1084ui_story and not isNil(var_119_4) then
					arg_116_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_5 + var_119_6 and arg_116_1.time_ < var_119_5 + var_119_6 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect1084ui_story then
				arg_116_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_119_8 = 0

			if var_119_8 < arg_116_1.time_ and arg_116_1.time_ <= var_119_8 + arg_119_0 then
				arg_116_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_2")
			end

			local var_119_9 = 0

			if var_119_9 < arg_116_1.time_ and arg_116_1.time_ <= var_119_9 + arg_119_0 then
				arg_116_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				arg_116_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_119_11 = 0

			if var_119_11 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_119_12 = arg_116_1.actors_["1084ui_story"].transform
			local var_119_13 = 0

			if var_119_13 < arg_116_1.time_ and arg_116_1.time_ <= var_119_13 + arg_119_0 then
				arg_116_1.var_.moveOldPos1084ui_story = var_119_12.localPosition
			end

			local var_119_14 = 0.001

			if var_119_13 <= arg_116_1.time_ and arg_116_1.time_ < var_119_13 + var_119_14 then
				local var_119_15 = (arg_116_1.time_ - var_119_13) / var_119_14
				local var_119_16 = Vector3.New(0.7, -0.97, -6)

				var_119_12.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1084ui_story, var_119_16, var_119_15)

				local var_119_17 = manager.ui.mainCamera.transform.position - var_119_12.position

				var_119_12.forward = Vector3.New(var_119_17.x, var_119_17.y, var_119_17.z)

				local var_119_18 = var_119_12.localEulerAngles

				var_119_18.z = 0
				var_119_18.x = 0
				var_119_12.localEulerAngles = var_119_18
			end

			if arg_116_1.time_ >= var_119_13 + var_119_14 and arg_116_1.time_ < var_119_13 + var_119_14 + arg_119_0 then
				var_119_12.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_119_19 = manager.ui.mainCamera.transform.position - var_119_12.position

				var_119_12.forward = Vector3.New(var_119_19.x, var_119_19.y, var_119_19.z)

				local var_119_20 = var_119_12.localEulerAngles

				var_119_20.z = 0
				var_119_20.x = 0
				var_119_12.localEulerAngles = var_119_20
			end

			local var_119_21 = arg_116_1.actors_["1027ui_story"].transform
			local var_119_22 = 0

			if var_119_22 < arg_116_1.time_ and arg_116_1.time_ <= var_119_22 + arg_119_0 then
				arg_116_1.var_.moveOldPos1027ui_story = var_119_21.localPosition
			end

			local var_119_23 = 0.001

			if var_119_22 <= arg_116_1.time_ and arg_116_1.time_ < var_119_22 + var_119_23 then
				local var_119_24 = (arg_116_1.time_ - var_119_22) / var_119_23
				local var_119_25 = Vector3.New(-0.7, -0.81, -5.8)

				var_119_21.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1027ui_story, var_119_25, var_119_24)

				local var_119_26 = manager.ui.mainCamera.transform.position - var_119_21.position

				var_119_21.forward = Vector3.New(var_119_26.x, var_119_26.y, var_119_26.z)

				local var_119_27 = var_119_21.localEulerAngles

				var_119_27.z = 0
				var_119_27.x = 0
				var_119_21.localEulerAngles = var_119_27
			end

			if arg_116_1.time_ >= var_119_22 + var_119_23 and arg_116_1.time_ < var_119_22 + var_119_23 + arg_119_0 then
				var_119_21.localPosition = Vector3.New(-0.7, -0.81, -5.8)

				local var_119_28 = manager.ui.mainCamera.transform.position - var_119_21.position

				var_119_21.forward = Vector3.New(var_119_28.x, var_119_28.y, var_119_28.z)

				local var_119_29 = var_119_21.localEulerAngles

				var_119_29.z = 0
				var_119_29.x = 0
				var_119_21.localEulerAngles = var_119_29
			end

			local var_119_30 = 0
			local var_119_31 = 0.125

			if var_119_30 < arg_116_1.time_ and arg_116_1.time_ <= var_119_30 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_32 = arg_116_1:FormatText(StoryNameCfg[11].name)

				arg_116_1.leftNameTxt_.text = var_119_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_33 = arg_116_1:GetWordFromCfg(112191028)
				local var_119_34 = arg_116_1:FormatText(var_119_33.content)

				arg_116_1.text_.text = var_119_34

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_35 = 5
				local var_119_36 = utf8.len(var_119_34)
				local var_119_37 = var_119_35 <= 0 and var_119_31 or var_119_31 * (var_119_36 / var_119_35)

				if var_119_37 > 0 and var_119_31 < var_119_37 then
					arg_116_1.talkMaxDuration = var_119_37

					if var_119_37 + var_119_30 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_37 + var_119_30
					end
				end

				arg_116_1.text_.text = var_119_34
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191028", "story_v_out_112191.awb") ~= 0 then
					local var_119_38 = manager.audio:GetVoiceLength("story_v_out_112191", "112191028", "story_v_out_112191.awb") / 1000

					if var_119_38 + var_119_30 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_38 + var_119_30
					end

					if var_119_33.prefab_name ~= "" and arg_116_1.actors_[var_119_33.prefab_name] ~= nil then
						local var_119_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_33.prefab_name].transform, "story_v_out_112191", "112191028", "story_v_out_112191.awb")

						arg_116_1:RecordAudio("112191028", var_119_39)
						arg_116_1:RecordAudio("112191028", var_119_39)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_112191", "112191028", "story_v_out_112191.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_112191", "112191028", "story_v_out_112191.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_40 = math.max(var_119_31, arg_116_1.talkMaxDuration)

			if var_119_30 <= arg_116_1.time_ and arg_116_1.time_ < var_119_30 + var_119_40 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_30) / var_119_40

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_30 + var_119_40 and arg_116_1.time_ < var_119_30 + var_119_40 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play112191029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 112191029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play112191030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1027ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1027ui_story == nil then
				arg_120_1.var_.characterEffect1027ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.2

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1027ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1027ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1027ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1027ui_story.fillRatio = var_123_5
			end

			local var_123_6 = arg_120_1.actors_["1084ui_story"]
			local var_123_7 = 0

			if var_123_7 < arg_120_1.time_ and arg_120_1.time_ <= var_123_7 + arg_123_0 and not isNil(var_123_6) and arg_120_1.var_.characterEffect1084ui_story == nil then
				arg_120_1.var_.characterEffect1084ui_story = var_123_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_8 = 0.2

			if var_123_7 <= arg_120_1.time_ and arg_120_1.time_ < var_123_7 + var_123_8 and not isNil(var_123_6) then
				local var_123_9 = (arg_120_1.time_ - var_123_7) / var_123_8

				if arg_120_1.var_.characterEffect1084ui_story and not isNil(var_123_6) then
					local var_123_10 = Mathf.Lerp(0, 0.5, var_123_9)

					arg_120_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1084ui_story.fillRatio = var_123_10
				end
			end

			if arg_120_1.time_ >= var_123_7 + var_123_8 and arg_120_1.time_ < var_123_7 + var_123_8 + arg_123_0 and not isNil(var_123_6) and arg_120_1.var_.characterEffect1084ui_story then
				local var_123_11 = 0.5

				arg_120_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1084ui_story.fillRatio = var_123_11
			end

			local var_123_12 = 0

			if var_123_12 < arg_120_1.time_ and arg_120_1.time_ <= var_123_12 + arg_123_0 then
				arg_120_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_123_13 = 0

			if var_123_13 < arg_120_1.time_ and arg_120_1.time_ <= var_123_13 + arg_123_0 then
				arg_120_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_123_14 = 0
			local var_123_15 = 0.95

			if var_123_14 < arg_120_1.time_ and arg_120_1.time_ <= var_123_14 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_16 = arg_120_1:GetWordFromCfg(112191029)
				local var_123_17 = arg_120_1:FormatText(var_123_16.content)

				arg_120_1.text_.text = var_123_17

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_18 = 38
				local var_123_19 = utf8.len(var_123_17)
				local var_123_20 = var_123_18 <= 0 and var_123_15 or var_123_15 * (var_123_19 / var_123_18)

				if var_123_20 > 0 and var_123_15 < var_123_20 then
					arg_120_1.talkMaxDuration = var_123_20

					if var_123_20 + var_123_14 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_20 + var_123_14
					end
				end

				arg_120_1.text_.text = var_123_17
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_21 = math.max(var_123_15, arg_120_1.talkMaxDuration)

			if var_123_14 <= arg_120_1.time_ and arg_120_1.time_ < var_123_14 + var_123_21 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_14) / var_123_21

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_14 + var_123_21 and arg_120_1.time_ < var_123_14 + var_123_21 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play112191030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 112191030
		arg_124_1.duration_ = 8

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play112191031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1027ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1027ui_story = var_127_0.localPosition
			end

			local var_127_2 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2
				local var_127_4 = Vector3.New(0, 100, 0)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1027ui_story, var_127_4, var_127_3)

				local var_127_5 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_5.x, var_127_5.y, var_127_5.z)

				local var_127_6 = var_127_0.localEulerAngles

				var_127_6.z = 0
				var_127_6.x = 0
				var_127_0.localEulerAngles = var_127_6
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0, 100, 0)

				local var_127_7 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_7.x, var_127_7.y, var_127_7.z)

				local var_127_8 = var_127_0.localEulerAngles

				var_127_8.z = 0
				var_127_8.x = 0
				var_127_0.localEulerAngles = var_127_8
			end

			local var_127_9 = arg_124_1.actors_["1084ui_story"].transform
			local var_127_10 = 0

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 then
				arg_124_1.var_.moveOldPos1084ui_story = var_127_9.localPosition
			end

			local var_127_11 = 0.001

			if var_127_10 <= arg_124_1.time_ and arg_124_1.time_ < var_127_10 + var_127_11 then
				local var_127_12 = (arg_124_1.time_ - var_127_10) / var_127_11
				local var_127_13 = Vector3.New(0, 100, 0)

				var_127_9.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1084ui_story, var_127_13, var_127_12)

				local var_127_14 = manager.ui.mainCamera.transform.position - var_127_9.position

				var_127_9.forward = Vector3.New(var_127_14.x, var_127_14.y, var_127_14.z)

				local var_127_15 = var_127_9.localEulerAngles

				var_127_15.z = 0
				var_127_15.x = 0
				var_127_9.localEulerAngles = var_127_15
			end

			if arg_124_1.time_ >= var_127_10 + var_127_11 and arg_124_1.time_ < var_127_10 + var_127_11 + arg_127_0 then
				var_127_9.localPosition = Vector3.New(0, 100, 0)

				local var_127_16 = manager.ui.mainCamera.transform.position - var_127_9.position

				var_127_9.forward = Vector3.New(var_127_16.x, var_127_16.y, var_127_16.z)

				local var_127_17 = var_127_9.localEulerAngles

				var_127_17.z = 0
				var_127_17.x = 0
				var_127_9.localEulerAngles = var_127_17
			end

			local var_127_18 = 0

			if var_127_18 < arg_124_1.time_ and arg_124_1.time_ <= var_127_18 + arg_127_0 then
				arg_124_1.mask_.enabled = true
				arg_124_1.mask_.raycastTarget = true

				arg_124_1:SetGaussion(false)
			end

			local var_127_19 = 1.5

			if var_127_18 <= arg_124_1.time_ and arg_124_1.time_ < var_127_18 + var_127_19 then
				local var_127_20 = (arg_124_1.time_ - var_127_18) / var_127_19
				local var_127_21 = Color.New(0, 0, 0)

				var_127_21.a = Mathf.Lerp(0, 1, var_127_20)
				arg_124_1.mask_.color = var_127_21
			end

			if arg_124_1.time_ >= var_127_18 + var_127_19 and arg_124_1.time_ < var_127_18 + var_127_19 + arg_127_0 then
				local var_127_22 = Color.New(0, 0, 0)

				var_127_22.a = 1
				arg_124_1.mask_.color = var_127_22
			end

			local var_127_23 = 1.5

			if var_127_23 < arg_124_1.time_ and arg_124_1.time_ <= var_127_23 + arg_127_0 then
				arg_124_1.mask_.enabled = true
				arg_124_1.mask_.raycastTarget = true

				arg_124_1:SetGaussion(false)
			end

			local var_127_24 = 1.5

			if var_127_23 <= arg_124_1.time_ and arg_124_1.time_ < var_127_23 + var_127_24 then
				local var_127_25 = (arg_124_1.time_ - var_127_23) / var_127_24
				local var_127_26 = Color.New(0, 0, 0)

				var_127_26.a = Mathf.Lerp(1, 0, var_127_25)
				arg_124_1.mask_.color = var_127_26
			end

			if arg_124_1.time_ >= var_127_23 + var_127_24 and arg_124_1.time_ < var_127_23 + var_127_24 + arg_127_0 then
				local var_127_27 = Color.New(0, 0, 0)
				local var_127_28 = 0

				arg_124_1.mask_.enabled = false
				var_127_27.a = var_127_28
				arg_124_1.mask_.color = var_127_27
			end

			if arg_124_1.frameCnt_ <= 1 then
				arg_124_1.dialog_:SetActive(false)
			end

			local var_127_29 = 3
			local var_127_30 = 1.025

			if var_127_29 < arg_124_1.time_ and arg_124_1.time_ <= var_127_29 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0

				arg_124_1.dialog_:SetActive(true)

				arg_124_1.dialogCg_.alpha = 0

				local var_127_31 = LeanTween.value(arg_124_1.dialog_, 0, 1, 0.3)

				var_127_31:setOnUpdate(LuaHelper.FloatAction(function(arg_128_0)
					arg_124_1.dialogCg_.alpha = arg_128_0
				end))
				var_127_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_124_1.dialog_)
					var_127_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_124_1.duration_ = arg_124_1.duration_ + 0.3

				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_32 = arg_124_1:GetWordFromCfg(112191030)
				local var_127_33 = arg_124_1:FormatText(var_127_32.content)

				arg_124_1.text_.text = var_127_33

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_34 = 41
				local var_127_35 = utf8.len(var_127_33)
				local var_127_36 = var_127_34 <= 0 and var_127_30 or var_127_30 * (var_127_35 / var_127_34)

				if var_127_36 > 0 and var_127_30 < var_127_36 then
					arg_124_1.talkMaxDuration = var_127_36
					var_127_29 = var_127_29 + 0.3

					if var_127_36 + var_127_29 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_36 + var_127_29
					end
				end

				arg_124_1.text_.text = var_127_33
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_37 = var_127_29 + 0.3
			local var_127_38 = math.max(var_127_30, arg_124_1.talkMaxDuration)

			if var_127_37 <= arg_124_1.time_ and arg_124_1.time_ < var_127_37 + var_127_38 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_37) / var_127_38

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_37 + var_127_38 and arg_124_1.time_ < var_127_37 + var_127_38 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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

		arg_124_1:InitPlayNodeList()
	end,
	Play112191031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 112191031
		arg_130_1.duration_ = 3.77

		local var_130_0 = {
			ja = 3.533,
			ko = 3.766,
			zh = 3.266,
			en = 3.733
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
				arg_130_0:Play112191032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1148ui_story"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos1148ui_story = var_133_0.localPosition

				local var_133_2 = "1148ui_story"

				arg_130_1:ShowWeapon(arg_130_1.var_[var_133_2 .. "Animator"].transform, false)
			end

			local var_133_3 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_3 then
				local var_133_4 = (arg_130_1.time_ - var_133_1) / var_133_3
				local var_133_5 = Vector3.New(0, -0.8, -6.2)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1148ui_story, var_133_5, var_133_4)

				local var_133_6 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_6.x, var_133_6.y, var_133_6.z)

				local var_133_7 = var_133_0.localEulerAngles

				var_133_7.z = 0
				var_133_7.x = 0
				var_133_0.localEulerAngles = var_133_7
			end

			if arg_130_1.time_ >= var_133_1 + var_133_3 and arg_130_1.time_ < var_133_1 + var_133_3 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_133_8 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_8.x, var_133_8.y, var_133_8.z)

				local var_133_9 = var_133_0.localEulerAngles

				var_133_9.z = 0
				var_133_9.x = 0
				var_133_0.localEulerAngles = var_133_9
			end

			local var_133_10 = arg_130_1.actors_["1148ui_story"]
			local var_133_11 = 0

			if var_133_11 < arg_130_1.time_ and arg_130_1.time_ <= var_133_11 + arg_133_0 and not isNil(var_133_10) and arg_130_1.var_.characterEffect1148ui_story == nil then
				arg_130_1.var_.characterEffect1148ui_story = var_133_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_12 = 0.2

			if var_133_11 <= arg_130_1.time_ and arg_130_1.time_ < var_133_11 + var_133_12 and not isNil(var_133_10) then
				local var_133_13 = (arg_130_1.time_ - var_133_11) / var_133_12

				if arg_130_1.var_.characterEffect1148ui_story and not isNil(var_133_10) then
					arg_130_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_11 + var_133_12 and arg_130_1.time_ < var_133_11 + var_133_12 + arg_133_0 and not isNil(var_133_10) and arg_130_1.var_.characterEffect1148ui_story then
				arg_130_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_133_14 = 0

			if var_133_14 < arg_130_1.time_ and arg_130_1.time_ <= var_133_14 + arg_133_0 then
				arg_130_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			local var_133_15 = 0

			if var_133_15 < arg_130_1.time_ and arg_130_1.time_ <= var_133_15 + arg_133_0 then
				arg_130_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_133_16 = 0
			local var_133_17 = 0.35

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_18 = arg_130_1:FormatText(StoryNameCfg[8].name)

				arg_130_1.leftNameTxt_.text = var_133_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_19 = arg_130_1:GetWordFromCfg(112191031)
				local var_133_20 = arg_130_1:FormatText(var_133_19.content)

				arg_130_1.text_.text = var_133_20

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_21 = 14
				local var_133_22 = utf8.len(var_133_20)
				local var_133_23 = var_133_21 <= 0 and var_133_17 or var_133_17 * (var_133_22 / var_133_21)

				if var_133_23 > 0 and var_133_17 < var_133_23 then
					arg_130_1.talkMaxDuration = var_133_23

					if var_133_23 + var_133_16 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_23 + var_133_16
					end
				end

				arg_130_1.text_.text = var_133_20
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191031", "story_v_out_112191.awb") ~= 0 then
					local var_133_24 = manager.audio:GetVoiceLength("story_v_out_112191", "112191031", "story_v_out_112191.awb") / 1000

					if var_133_24 + var_133_16 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_24 + var_133_16
					end

					if var_133_19.prefab_name ~= "" and arg_130_1.actors_[var_133_19.prefab_name] ~= nil then
						local var_133_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_19.prefab_name].transform, "story_v_out_112191", "112191031", "story_v_out_112191.awb")

						arg_130_1:RecordAudio("112191031", var_133_25)
						arg_130_1:RecordAudio("112191031", var_133_25)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_112191", "112191031", "story_v_out_112191.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_112191", "112191031", "story_v_out_112191.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_26 = math.max(var_133_17, arg_130_1.talkMaxDuration)

			if var_133_16 <= arg_130_1.time_ and arg_130_1.time_ < var_133_16 + var_133_26 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_16) / var_133_26

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_16 + var_133_26 and arg_130_1.time_ < var_133_16 + var_133_26 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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

		arg_130_1:InitPlayNodeList()
	end,
	Play112191032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 112191032
		arg_134_1.duration_ = 2

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"

			SetActive(arg_134_1.choicesGo_, true)

			for iter_135_0, iter_135_1 in ipairs(arg_134_1.choices_) do
				local var_135_0 = iter_135_0 <= 2

				SetActive(iter_135_1.go, var_135_0)
			end

			arg_134_1.choices_[1].txt.text = arg_134_1:FormatText(StoryChoiceCfg[129].name)
			arg_134_1.choices_[2].txt.text = arg_134_1:FormatText(StoryChoiceCfg[130].name)
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play112191033(arg_134_1)
			end

			if arg_136_0 == 2 then
				arg_134_0:Play112191035(arg_134_1)
			end

			arg_134_1:RecordChoiceLog(112191032, 129, 130)
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = "1148_tpose"

			if arg_134_1.actors_[var_137_0] == nil then
				local var_137_1 = Asset.Load("Char/" .. "1148_tpose")

				if not isNil(var_137_1) then
					local var_137_2 = Object.Instantiate(Asset.Load("Char/" .. "1148_tpose"), arg_134_1.stage_.transform)

					var_137_2.name = var_137_0
					var_137_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_134_1.actors_[var_137_0] = var_137_2

					local var_137_3 = var_137_2:GetComponentInChildren(typeof(CharacterEffect))

					var_137_3.enabled = true

					local var_137_4 = GameObjectTools.GetOrAddComponent(var_137_2, typeof(DynamicBoneHelper))

					if var_137_4 then
						var_137_4:EnableDynamicBone(false)
					end

					arg_134_1:ShowWeapon(var_137_3.transform, false)

					arg_134_1.var_[var_137_0 .. "Animator"] = var_137_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_134_1.var_[var_137_0 .. "Animator"].applyRootMotion = true
					arg_134_1.var_[var_137_0 .. "LipSync"] = var_137_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_137_5 = arg_134_1.actors_["1148_tpose"]
			local var_137_6 = 0

			if var_137_6 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 and not isNil(var_137_5) and arg_134_1.var_.characterEffect1148_tpose == nil then
				arg_134_1.var_.characterEffect1148_tpose = var_137_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_7 = 0.2

			if var_137_6 <= arg_134_1.time_ and arg_134_1.time_ < var_137_6 + var_137_7 and not isNil(var_137_5) then
				local var_137_8 = (arg_134_1.time_ - var_137_6) / var_137_7

				if arg_134_1.var_.characterEffect1148_tpose and not isNil(var_137_5) then
					local var_137_9 = Mathf.Lerp(0, 0.5, var_137_8)

					arg_134_1.var_.characterEffect1148_tpose.fillFlat = true
					arg_134_1.var_.characterEffect1148_tpose.fillRatio = var_137_9
				end
			end

			if arg_134_1.time_ >= var_137_6 + var_137_7 and arg_134_1.time_ < var_137_6 + var_137_7 + arg_137_0 and not isNil(var_137_5) and arg_134_1.var_.characterEffect1148_tpose then
				local var_137_10 = 0.5

				arg_134_1.var_.characterEffect1148_tpose.fillFlat = true
				arg_134_1.var_.characterEffect1148_tpose.fillRatio = var_137_10
			end

			local var_137_11 = 0

			if var_137_11 < arg_134_1.time_ and arg_134_1.time_ <= var_137_11 + arg_137_0 then
				arg_134_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_2")
			end

			local var_137_12 = 0

			if var_137_12 < arg_134_1.time_ and arg_134_1.time_ <= var_137_12 + arg_137_0 then
				arg_134_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play112191033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 112191033
		arg_138_1.duration_ = 5.17

		local var_138_0 = {
			ja = 4.233,
			ko = 3.033,
			zh = 2.866,
			en = 5.166
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
				arg_138_0:Play112191034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 0.375

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_2 = arg_138_1:FormatText(StoryNameCfg[56].name)

				arg_138_1.leftNameTxt_.text = var_141_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:GetWordFromCfg(112191033)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 15
				local var_141_6 = utf8.len(var_141_4)
				local var_141_7 = var_141_5 <= 0 and var_141_1 or var_141_1 * (var_141_6 / var_141_5)

				if var_141_7 > 0 and var_141_1 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191033", "story_v_out_112191.awb") ~= 0 then
					local var_141_8 = manager.audio:GetVoiceLength("story_v_out_112191", "112191033", "story_v_out_112191.awb") / 1000

					if var_141_8 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_0
					end

					if var_141_3.prefab_name ~= "" and arg_138_1.actors_[var_141_3.prefab_name] ~= nil then
						local var_141_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_3.prefab_name].transform, "story_v_out_112191", "112191033", "story_v_out_112191.awb")

						arg_138_1:RecordAudio("112191033", var_141_9)
						arg_138_1:RecordAudio("112191033", var_141_9)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_112191", "112191033", "story_v_out_112191.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_112191", "112191033", "story_v_out_112191.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_10 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_10 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_10

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_10 and arg_138_1.time_ < var_141_0 + var_141_10 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play112191034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 112191034
		arg_142_1.duration_ = 11.83

		local var_142_0 = {
			ja = 9.333,
			ko = 10.9,
			zh = 8.566,
			en = 11.833
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play112191038(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1148ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1148ui_story == nil then
				arg_142_1.var_.characterEffect1148ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.2

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1148ui_story and not isNil(var_145_0) then
					arg_142_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1148ui_story then
				arg_142_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_145_4 = 0

			if var_145_4 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_145_5 = 0

			if var_145_5 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 then
				arg_142_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2204cva")
			end

			local var_145_6 = 0
			local var_145_7 = 1.025

			if var_145_6 < arg_142_1.time_ and arg_142_1.time_ <= var_145_6 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_8 = arg_142_1:FormatText(StoryNameCfg[8].name)

				arg_142_1.leftNameTxt_.text = var_145_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_9 = arg_142_1:GetWordFromCfg(112191034)
				local var_145_10 = arg_142_1:FormatText(var_145_9.content)

				arg_142_1.text_.text = var_145_10

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_11 = 41
				local var_145_12 = utf8.len(var_145_10)
				local var_145_13 = var_145_11 <= 0 and var_145_7 or var_145_7 * (var_145_12 / var_145_11)

				if var_145_13 > 0 and var_145_7 < var_145_13 then
					arg_142_1.talkMaxDuration = var_145_13

					if var_145_13 + var_145_6 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_13 + var_145_6
					end
				end

				arg_142_1.text_.text = var_145_10
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191034", "story_v_out_112191.awb") ~= 0 then
					local var_145_14 = manager.audio:GetVoiceLength("story_v_out_112191", "112191034", "story_v_out_112191.awb") / 1000

					if var_145_14 + var_145_6 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_14 + var_145_6
					end

					if var_145_9.prefab_name ~= "" and arg_142_1.actors_[var_145_9.prefab_name] ~= nil then
						local var_145_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_9.prefab_name].transform, "story_v_out_112191", "112191034", "story_v_out_112191.awb")

						arg_142_1:RecordAudio("112191034", var_145_15)
						arg_142_1:RecordAudio("112191034", var_145_15)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_112191", "112191034", "story_v_out_112191.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_112191", "112191034", "story_v_out_112191.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_16 = math.max(var_145_7, arg_142_1.talkMaxDuration)

			if var_145_6 <= arg_142_1.time_ and arg_142_1.time_ < var_145_6 + var_145_16 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_6) / var_145_16

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_6 + var_145_16 and arg_142_1.time_ < var_145_6 + var_145_16 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play112191038 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 112191038
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play112191039(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1148ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1148ui_story == nil then
				arg_146_1.var_.characterEffect1148ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.2

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1148ui_story and not isNil(var_149_0) then
					local var_149_4 = Mathf.Lerp(0, 0.5, var_149_3)

					arg_146_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1148ui_story.fillRatio = var_149_4
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1148ui_story then
				local var_149_5 = 0.5

				arg_146_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1148ui_story.fillRatio = var_149_5
			end

			local var_149_6 = 0
			local var_149_7 = 2.175

			if var_149_6 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_8 = arg_146_1:GetWordFromCfg(112191038)
				local var_149_9 = arg_146_1:FormatText(var_149_8.content)

				arg_146_1.text_.text = var_149_9

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_10 = 87
				local var_149_11 = utf8.len(var_149_9)
				local var_149_12 = var_149_10 <= 0 and var_149_7 or var_149_7 * (var_149_11 / var_149_10)

				if var_149_12 > 0 and var_149_7 < var_149_12 then
					arg_146_1.talkMaxDuration = var_149_12

					if var_149_12 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_12 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_9
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_13 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_13 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_13

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_13 and arg_146_1.time_ < var_149_6 + var_149_13 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play112191039 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 112191039
		arg_150_1.duration_ = 6.33

		local var_150_0 = {
			ja = 6.333,
			ko = 4.433,
			zh = 4.3,
			en = 5.733
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
				arg_150_0:Play112191040(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.375

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_2 = arg_150_1:FormatText(StoryNameCfg[56].name)

				arg_150_1.leftNameTxt_.text = var_153_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_3 = arg_150_1:GetWordFromCfg(112191039)
				local var_153_4 = arg_150_1:FormatText(var_153_3.content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 15
				local var_153_6 = utf8.len(var_153_4)
				local var_153_7 = var_153_5 <= 0 and var_153_1 or var_153_1 * (var_153_6 / var_153_5)

				if var_153_7 > 0 and var_153_1 < var_153_7 then
					arg_150_1.talkMaxDuration = var_153_7

					if var_153_7 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_4
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191039", "story_v_out_112191.awb") ~= 0 then
					local var_153_8 = manager.audio:GetVoiceLength("story_v_out_112191", "112191039", "story_v_out_112191.awb") / 1000

					if var_153_8 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_8 + var_153_0
					end

					if var_153_3.prefab_name ~= "" and arg_150_1.actors_[var_153_3.prefab_name] ~= nil then
						local var_153_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_3.prefab_name].transform, "story_v_out_112191", "112191039", "story_v_out_112191.awb")

						arg_150_1:RecordAudio("112191039", var_153_9)
						arg_150_1:RecordAudio("112191039", var_153_9)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_112191", "112191039", "story_v_out_112191.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_112191", "112191039", "story_v_out_112191.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_10 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_10 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_10

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_10 and arg_150_1.time_ < var_153_0 + var_153_10 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play112191040 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 112191040
		arg_154_1.duration_ = 6.17

		local var_154_0 = {
			ja = 4.366,
			ko = 5.366,
			zh = 4.133,
			en = 6.166
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
				arg_154_0:Play112191041(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = manager.ui.mainCamera.transform
			local var_157_1 = 0.425

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.shakeOldPos = var_157_0.localPosition
			end

			local var_157_2 = 0.6

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / 0.099
				local var_157_4, var_157_5 = math.modf(var_157_3)

				var_157_0.localPosition = Vector3.New(var_157_5 * 0.13, var_157_5 * 0.13, var_157_5 * 0.13) + arg_154_1.var_.shakeOldPos
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 then
				var_157_0.localPosition = arg_154_1.var_.shakeOldPos
			end

			local var_157_6 = 0
			local var_157_7 = 0.425

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_8 = arg_154_1:FormatText(StoryNameCfg[6].name)

				arg_154_1.leftNameTxt_.text = var_157_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_9 = arg_154_1:GetWordFromCfg(112191040)
				local var_157_10 = arg_154_1:FormatText(var_157_9.content)

				arg_154_1.text_.text = var_157_10

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_11 = 17
				local var_157_12 = utf8.len(var_157_10)
				local var_157_13 = var_157_11 <= 0 and var_157_7 or var_157_7 * (var_157_12 / var_157_11)

				if var_157_13 > 0 and var_157_7 < var_157_13 then
					arg_154_1.talkMaxDuration = var_157_13

					if var_157_13 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_13 + var_157_6
					end
				end

				arg_154_1.text_.text = var_157_10
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191040", "story_v_out_112191.awb") ~= 0 then
					local var_157_14 = manager.audio:GetVoiceLength("story_v_out_112191", "112191040", "story_v_out_112191.awb") / 1000

					if var_157_14 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_14 + var_157_6
					end

					if var_157_9.prefab_name ~= "" and arg_154_1.actors_[var_157_9.prefab_name] ~= nil then
						local var_157_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_9.prefab_name].transform, "story_v_out_112191", "112191040", "story_v_out_112191.awb")

						arg_154_1:RecordAudio("112191040", var_157_15)
						arg_154_1:RecordAudio("112191040", var_157_15)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_112191", "112191040", "story_v_out_112191.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_112191", "112191040", "story_v_out_112191.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_16 = math.max(var_157_7, arg_154_1.talkMaxDuration)

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_16 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_6) / var_157_16

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_6 + var_157_16 and arg_154_1.time_ < var_157_6 + var_157_16 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play112191041 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 112191041
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play112191042(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action449")
			end

			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_161_2 = 0
			local var_161_3 = 0.675

			if var_161_2 < arg_158_1.time_ and arg_158_1.time_ <= var_161_2 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_4 = arg_158_1:GetWordFromCfg(112191041)
				local var_161_5 = arg_158_1:FormatText(var_161_4.content)

				arg_158_1.text_.text = var_161_5

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_6 = 27
				local var_161_7 = utf8.len(var_161_5)
				local var_161_8 = var_161_6 <= 0 and var_161_3 or var_161_3 * (var_161_7 / var_161_6)

				if var_161_8 > 0 and var_161_3 < var_161_8 then
					arg_158_1.talkMaxDuration = var_161_8

					if var_161_8 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_2
					end
				end

				arg_158_1.text_.text = var_161_5
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_9 = math.max(var_161_3, arg_158_1.talkMaxDuration)

			if var_161_2 <= arg_158_1.time_ and arg_158_1.time_ < var_161_2 + var_161_9 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_2) / var_161_9

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_2 + var_161_9 and arg_158_1.time_ < var_161_2 + var_161_9 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play112191042 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 112191042
		arg_162_1.duration_ = 11.6

		local var_162_0 = {
			ja = 11.4,
			ko = 11.6,
			zh = 9.733,
			en = 10.4
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
				arg_162_0:Play112191043(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1148ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1148ui_story == nil then
				arg_162_1.var_.characterEffect1148ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.2

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect1148ui_story and not isNil(var_165_0) then
					arg_162_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1148ui_story then
				arg_162_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_165_4 = 0

			if var_165_4 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action496")
			end

			local var_165_5 = 0

			if var_165_5 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 then
				arg_162_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_165_6 = 0
			local var_165_7 = 1.125

			if var_165_6 < arg_162_1.time_ and arg_162_1.time_ <= var_165_6 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_8 = arg_162_1:FormatText(StoryNameCfg[8].name)

				arg_162_1.leftNameTxt_.text = var_165_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_9 = arg_162_1:GetWordFromCfg(112191042)
				local var_165_10 = arg_162_1:FormatText(var_165_9.content)

				arg_162_1.text_.text = var_165_10

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_11 = 45
				local var_165_12 = utf8.len(var_165_10)
				local var_165_13 = var_165_11 <= 0 and var_165_7 or var_165_7 * (var_165_12 / var_165_11)

				if var_165_13 > 0 and var_165_7 < var_165_13 then
					arg_162_1.talkMaxDuration = var_165_13

					if var_165_13 + var_165_6 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_13 + var_165_6
					end
				end

				arg_162_1.text_.text = var_165_10
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191042", "story_v_out_112191.awb") ~= 0 then
					local var_165_14 = manager.audio:GetVoiceLength("story_v_out_112191", "112191042", "story_v_out_112191.awb") / 1000

					if var_165_14 + var_165_6 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_14 + var_165_6
					end

					if var_165_9.prefab_name ~= "" and arg_162_1.actors_[var_165_9.prefab_name] ~= nil then
						local var_165_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_9.prefab_name].transform, "story_v_out_112191", "112191042", "story_v_out_112191.awb")

						arg_162_1:RecordAudio("112191042", var_165_15)
						arg_162_1:RecordAudio("112191042", var_165_15)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_112191", "112191042", "story_v_out_112191.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_112191", "112191042", "story_v_out_112191.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_16 = math.max(var_165_7, arg_162_1.talkMaxDuration)

			if var_165_6 <= arg_162_1.time_ and arg_162_1.time_ < var_165_6 + var_165_16 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_6) / var_165_16

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_6 + var_165_16 and arg_162_1.time_ < var_165_6 + var_165_16 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play112191043 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 112191043
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play112191044(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1148ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1148ui_story == nil then
				arg_166_1.var_.characterEffect1148ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.2

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect1148ui_story and not isNil(var_169_0) then
					local var_169_4 = Mathf.Lerp(0, 0.5, var_169_3)

					arg_166_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1148ui_story.fillRatio = var_169_4
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1148ui_story then
				local var_169_5 = 0.5

				arg_166_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1148ui_story.fillRatio = var_169_5
			end

			local var_169_6 = 0
			local var_169_7 = 0.325

			if var_169_6 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_8 = arg_166_1:FormatText(StoryNameCfg[7].name)

				arg_166_1.leftNameTxt_.text = var_169_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_9 = arg_166_1:GetWordFromCfg(112191043)
				local var_169_10 = arg_166_1:FormatText(var_169_9.content)

				arg_166_1.text_.text = var_169_10

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_11 = 13
				local var_169_12 = utf8.len(var_169_10)
				local var_169_13 = var_169_11 <= 0 and var_169_7 or var_169_7 * (var_169_12 / var_169_11)

				if var_169_13 > 0 and var_169_7 < var_169_13 then
					arg_166_1.talkMaxDuration = var_169_13

					if var_169_13 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_13 + var_169_6
					end
				end

				arg_166_1.text_.text = var_169_10
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_14 = math.max(var_169_7, arg_166_1.talkMaxDuration)

			if var_169_6 <= arg_166_1.time_ and arg_166_1.time_ < var_169_6 + var_169_14 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_6) / var_169_14

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_6 + var_169_14 and arg_166_1.time_ < var_169_6 + var_169_14 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play112191044 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 112191044
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play112191045(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1148ui_story"].transform
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.var_.moveOldPos1148ui_story = var_173_0.localPosition
			end

			local var_173_2 = 0.001

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2
				local var_173_4 = Vector3.New(0, 100, 0)

				var_173_0.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1148ui_story, var_173_4, var_173_3)

				local var_173_5 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_5.x, var_173_5.y, var_173_5.z)

				local var_173_6 = var_173_0.localEulerAngles

				var_173_6.z = 0
				var_173_6.x = 0
				var_173_0.localEulerAngles = var_173_6
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 then
				var_173_0.localPosition = Vector3.New(0, 100, 0)

				local var_173_7 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_7.x, var_173_7.y, var_173_7.z)

				local var_173_8 = var_173_0.localEulerAngles

				var_173_8.z = 0
				var_173_8.x = 0
				var_173_0.localEulerAngles = var_173_8
			end

			local var_173_9 = 0
			local var_173_10 = 0.925

			if var_173_9 < arg_170_1.time_ and arg_170_1.time_ <= var_173_9 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_11 = arg_170_1:GetWordFromCfg(112191044)
				local var_173_12 = arg_170_1:FormatText(var_173_11.content)

				arg_170_1.text_.text = var_173_12

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_13 = 37
				local var_173_14 = utf8.len(var_173_12)
				local var_173_15 = var_173_13 <= 0 and var_173_10 or var_173_10 * (var_173_14 / var_173_13)

				if var_173_15 > 0 and var_173_10 < var_173_15 then
					arg_170_1.talkMaxDuration = var_173_15

					if var_173_15 + var_173_9 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_15 + var_173_9
					end
				end

				arg_170_1.text_.text = var_173_12
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_16 = math.max(var_173_10, arg_170_1.talkMaxDuration)

			if var_173_9 <= arg_170_1.time_ and arg_170_1.time_ < var_173_9 + var_173_16 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_9) / var_173_16

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_9 + var_173_16 and arg_170_1.time_ < var_173_9 + var_173_16 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
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

		arg_170_1:InitPlayNodeList()
	end,
	Play112191045 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 112191045
		arg_174_1.duration_ = 10

		local var_174_0 = {
			ja = 10,
			ko = 5.633,
			zh = 7,
			en = 6.733
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play112191046(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = "1039ui_story"

			if arg_174_1.actors_[var_177_0] == nil then
				local var_177_1 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_177_1) then
					local var_177_2 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_174_1.stage_.transform)

					var_177_2.name = var_177_0
					var_177_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_174_1.actors_[var_177_0] = var_177_2

					local var_177_3 = var_177_2:GetComponentInChildren(typeof(CharacterEffect))

					var_177_3.enabled = true

					local var_177_4 = GameObjectTools.GetOrAddComponent(var_177_2, typeof(DynamicBoneHelper))

					if var_177_4 then
						var_177_4:EnableDynamicBone(false)
					end

					arg_174_1:ShowWeapon(var_177_3.transform, false)

					arg_174_1.var_[var_177_0 .. "Animator"] = var_177_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_174_1.var_[var_177_0 .. "Animator"].applyRootMotion = true
					arg_174_1.var_[var_177_0 .. "LipSync"] = var_177_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_177_5 = arg_174_1.actors_["1039ui_story"].transform
			local var_177_6 = 0

			if var_177_6 < arg_174_1.time_ and arg_174_1.time_ <= var_177_6 + arg_177_0 then
				arg_174_1.var_.moveOldPos1039ui_story = var_177_5.localPosition

				local var_177_7 = "1039ui_story"

				arg_174_1:ShowWeapon(arg_174_1.var_[var_177_7 .. "Animator"].transform, false)
			end

			local var_177_8 = 0.001

			if var_177_6 <= arg_174_1.time_ and arg_174_1.time_ < var_177_6 + var_177_8 then
				local var_177_9 = (arg_174_1.time_ - var_177_6) / var_177_8
				local var_177_10 = Vector3.New(0, -1.01, -5.9)

				var_177_5.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1039ui_story, var_177_10, var_177_9)

				local var_177_11 = manager.ui.mainCamera.transform.position - var_177_5.position

				var_177_5.forward = Vector3.New(var_177_11.x, var_177_11.y, var_177_11.z)

				local var_177_12 = var_177_5.localEulerAngles

				var_177_12.z = 0
				var_177_12.x = 0
				var_177_5.localEulerAngles = var_177_12
			end

			if arg_174_1.time_ >= var_177_6 + var_177_8 and arg_174_1.time_ < var_177_6 + var_177_8 + arg_177_0 then
				var_177_5.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_177_13 = manager.ui.mainCamera.transform.position - var_177_5.position

				var_177_5.forward = Vector3.New(var_177_13.x, var_177_13.y, var_177_13.z)

				local var_177_14 = var_177_5.localEulerAngles

				var_177_14.z = 0
				var_177_14.x = 0
				var_177_5.localEulerAngles = var_177_14
			end

			local var_177_15 = arg_174_1.actors_["1039ui_story"]
			local var_177_16 = 0

			if var_177_16 < arg_174_1.time_ and arg_174_1.time_ <= var_177_16 + arg_177_0 and not isNil(var_177_15) and arg_174_1.var_.characterEffect1039ui_story == nil then
				arg_174_1.var_.characterEffect1039ui_story = var_177_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_17 = 0.2

			if var_177_16 <= arg_174_1.time_ and arg_174_1.time_ < var_177_16 + var_177_17 and not isNil(var_177_15) then
				local var_177_18 = (arg_174_1.time_ - var_177_16) / var_177_17

				if arg_174_1.var_.characterEffect1039ui_story and not isNil(var_177_15) then
					arg_174_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= var_177_16 + var_177_17 and arg_174_1.time_ < var_177_16 + var_177_17 + arg_177_0 and not isNil(var_177_15) and arg_174_1.var_.characterEffect1039ui_story then
				arg_174_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_177_19 = 0

			if var_177_19 < arg_174_1.time_ and arg_174_1.time_ <= var_177_19 + arg_177_0 then
				arg_174_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action7_1")
			end

			local var_177_20 = 0

			if var_177_20 < arg_174_1.time_ and arg_174_1.time_ <= var_177_20 + arg_177_0 then
				arg_174_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_177_21 = 0
			local var_177_22 = 0.65

			if var_177_21 < arg_174_1.time_ and arg_174_1.time_ <= var_177_21 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0

				arg_174_1.dialog_:SetActive(true)

				arg_174_1.dialogCg_.alpha = 0

				local var_177_23 = LeanTween.value(arg_174_1.dialog_, 0, 1, 0.3)

				var_177_23:setOnUpdate(LuaHelper.FloatAction(function(arg_178_0)
					arg_174_1.dialogCg_.alpha = arg_178_0
				end))
				var_177_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_174_1.dialog_)
					var_177_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_174_1.duration_ = arg_174_1.duration_ + 0.3

				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_24 = arg_174_1:FormatText(StoryNameCfg[9].name)

				arg_174_1.leftNameTxt_.text = var_177_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_25 = arg_174_1:GetWordFromCfg(112191045)
				local var_177_26 = arg_174_1:FormatText(var_177_25.content)

				arg_174_1.text_.text = var_177_26

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_27 = 26
				local var_177_28 = utf8.len(var_177_26)
				local var_177_29 = var_177_27 <= 0 and var_177_22 or var_177_22 * (var_177_28 / var_177_27)

				if var_177_29 > 0 and var_177_22 < var_177_29 then
					arg_174_1.talkMaxDuration = var_177_29
					var_177_21 = var_177_21 + 0.3

					if var_177_29 + var_177_21 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_29 + var_177_21
					end
				end

				arg_174_1.text_.text = var_177_26
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191045", "story_v_out_112191.awb") ~= 0 then
					local var_177_30 = manager.audio:GetVoiceLength("story_v_out_112191", "112191045", "story_v_out_112191.awb") / 1000

					if var_177_30 + var_177_21 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_30 + var_177_21
					end

					if var_177_25.prefab_name ~= "" and arg_174_1.actors_[var_177_25.prefab_name] ~= nil then
						local var_177_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_25.prefab_name].transform, "story_v_out_112191", "112191045", "story_v_out_112191.awb")

						arg_174_1:RecordAudio("112191045", var_177_31)
						arg_174_1:RecordAudio("112191045", var_177_31)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_112191", "112191045", "story_v_out_112191.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_112191", "112191045", "story_v_out_112191.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_32 = var_177_21 + 0.3
			local var_177_33 = math.max(var_177_22, arg_174_1.talkMaxDuration)

			if var_177_32 <= arg_174_1.time_ and arg_174_1.time_ < var_177_32 + var_177_33 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_32) / var_177_33

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_32 + var_177_33 and arg_174_1.time_ < var_177_32 + var_177_33 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play112191046 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 112191046
		arg_180_1.duration_ = 5

		local var_180_0 = {
			ja = 4.633,
			ko = 5,
			zh = 4.533,
			en = 3.533
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
				arg_180_0:Play112191047(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1039ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1039ui_story == nil then
				arg_180_1.var_.characterEffect1039ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1039ui_story and not isNil(var_183_0) then
					arg_180_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1039ui_story then
				arg_180_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_183_4 = 0
			local var_183_5 = 0.475

			if var_183_4 < arg_180_1.time_ and arg_180_1.time_ <= var_183_4 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_6 = arg_180_1:FormatText(StoryNameCfg[56].name)

				arg_180_1.leftNameTxt_.text = var_183_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_7 = arg_180_1:GetWordFromCfg(112191046)
				local var_183_8 = arg_180_1:FormatText(var_183_7.content)

				arg_180_1.text_.text = var_183_8

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_9 = 19
				local var_183_10 = utf8.len(var_183_8)
				local var_183_11 = var_183_9 <= 0 and var_183_5 or var_183_5 * (var_183_10 / var_183_9)

				if var_183_11 > 0 and var_183_5 < var_183_11 then
					arg_180_1.talkMaxDuration = var_183_11

					if var_183_11 + var_183_4 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_11 + var_183_4
					end
				end

				arg_180_1.text_.text = var_183_8
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191046", "story_v_out_112191.awb") ~= 0 then
					local var_183_12 = manager.audio:GetVoiceLength("story_v_out_112191", "112191046", "story_v_out_112191.awb") / 1000

					if var_183_12 + var_183_4 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_12 + var_183_4
					end

					if var_183_7.prefab_name ~= "" and arg_180_1.actors_[var_183_7.prefab_name] ~= nil then
						local var_183_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_7.prefab_name].transform, "story_v_out_112191", "112191046", "story_v_out_112191.awb")

						arg_180_1:RecordAudio("112191046", var_183_13)
						arg_180_1:RecordAudio("112191046", var_183_13)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_112191", "112191046", "story_v_out_112191.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_112191", "112191046", "story_v_out_112191.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_14 = math.max(var_183_5, arg_180_1.talkMaxDuration)

			if var_183_4 <= arg_180_1.time_ and arg_180_1.time_ < var_183_4 + var_183_14 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_4) / var_183_14

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_4 + var_183_14 and arg_180_1.time_ < var_183_4 + var_183_14 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play112191047 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 112191047
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play112191048(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0
			local var_187_1 = 1.55

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_2 = arg_184_1:GetWordFromCfg(112191047)
				local var_187_3 = arg_184_1:FormatText(var_187_2.content)

				arg_184_1.text_.text = var_187_3

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_4 = 62
				local var_187_5 = utf8.len(var_187_3)
				local var_187_6 = var_187_4 <= 0 and var_187_1 or var_187_1 * (var_187_5 / var_187_4)

				if var_187_6 > 0 and var_187_1 < var_187_6 then
					arg_184_1.talkMaxDuration = var_187_6

					if var_187_6 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_6 + var_187_0
					end
				end

				arg_184_1.text_.text = var_187_3
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_7 = math.max(var_187_1, arg_184_1.talkMaxDuration)

			if var_187_0 <= arg_184_1.time_ and arg_184_1.time_ < var_187_0 + var_187_7 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_0) / var_187_7

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_0 + var_187_7 and arg_184_1.time_ < var_187_0 + var_187_7 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play112191048 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 112191048
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play112191049(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0
			local var_191_1 = 0.35

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_2 = arg_188_1:GetWordFromCfg(112191048)
				local var_191_3 = arg_188_1:FormatText(var_191_2.content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_4 = 14
				local var_191_5 = utf8.len(var_191_3)
				local var_191_6 = var_191_4 <= 0 and var_191_1 or var_191_1 * (var_191_5 / var_191_4)

				if var_191_6 > 0 and var_191_1 < var_191_6 then
					arg_188_1.talkMaxDuration = var_191_6

					if var_191_6 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_6 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_7 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_7 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_7

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_7 and arg_188_1.time_ < var_191_0 + var_191_7 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play112191049 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 112191049
		arg_192_1.duration_ = 8.73

		local var_192_0 = {
			ja = 7.7,
			ko = 6.8,
			zh = 6.233,
			en = 8.733
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play112191050(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 0.675

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[8].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_3 = arg_192_1:GetWordFromCfg(112191049)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 27
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191049", "story_v_out_112191.awb") ~= 0 then
					local var_195_8 = manager.audio:GetVoiceLength("story_v_out_112191", "112191049", "story_v_out_112191.awb") / 1000

					if var_195_8 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_8 + var_195_0
					end

					if var_195_3.prefab_name ~= "" and arg_192_1.actors_[var_195_3.prefab_name] ~= nil then
						local var_195_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_3.prefab_name].transform, "story_v_out_112191", "112191049", "story_v_out_112191.awb")

						arg_192_1:RecordAudio("112191049", var_195_9)
						arg_192_1:RecordAudio("112191049", var_195_9)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_112191", "112191049", "story_v_out_112191.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_112191", "112191049", "story_v_out_112191.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_10 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_10 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_10

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_10 and arg_192_1.time_ < var_195_0 + var_195_10 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play112191050 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 112191050
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play112191051(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 0.35

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_2 = arg_196_1:FormatText(StoryNameCfg[7].name)

				arg_196_1.leftNameTxt_.text = var_199_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_3 = arg_196_1:GetWordFromCfg(112191050)
				local var_199_4 = arg_196_1:FormatText(var_199_3.content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 14
				local var_199_6 = utf8.len(var_199_4)
				local var_199_7 = var_199_5 <= 0 and var_199_1 or var_199_1 * (var_199_6 / var_199_5)

				if var_199_7 > 0 and var_199_1 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_8 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_8 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_8

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_8 and arg_196_1.time_ < var_199_0 + var_199_8 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play112191051 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 112191051
		arg_200_1.duration_ = 9

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play112191052(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1039ui_story"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos1039ui_story = var_203_0.localPosition
			end

			local var_203_2 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2
				local var_203_4 = Vector3.New(0, 100, 0)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1039ui_story, var_203_4, var_203_3)

				local var_203_5 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_5.x, var_203_5.y, var_203_5.z)

				local var_203_6 = var_203_0.localEulerAngles

				var_203_6.z = 0
				var_203_6.x = 0
				var_203_0.localEulerAngles = var_203_6
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(0, 100, 0)

				local var_203_7 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_7.x, var_203_7.y, var_203_7.z)

				local var_203_8 = var_203_0.localEulerAngles

				var_203_8.z = 0
				var_203_8.x = 0
				var_203_0.localEulerAngles = var_203_8
			end

			local var_203_9 = 0

			if var_203_9 < arg_200_1.time_ and arg_200_1.time_ <= var_203_9 + arg_203_0 then
				arg_200_1.mask_.enabled = true
				arg_200_1.mask_.raycastTarget = true

				arg_200_1:SetGaussion(false)
			end

			local var_203_10 = 2

			if var_203_9 <= arg_200_1.time_ and arg_200_1.time_ < var_203_9 + var_203_10 then
				local var_203_11 = (arg_200_1.time_ - var_203_9) / var_203_10
				local var_203_12 = Color.New(0, 0, 0)

				var_203_12.a = Mathf.Lerp(0, 1, var_203_11)
				arg_200_1.mask_.color = var_203_12
			end

			if arg_200_1.time_ >= var_203_9 + var_203_10 and arg_200_1.time_ < var_203_9 + var_203_10 + arg_203_0 then
				local var_203_13 = Color.New(0, 0, 0)

				var_203_13.a = 1
				arg_200_1.mask_.color = var_203_13
			end

			local var_203_14 = 2

			if var_203_14 < arg_200_1.time_ and arg_200_1.time_ <= var_203_14 + arg_203_0 then
				arg_200_1.mask_.enabled = true
				arg_200_1.mask_.raycastTarget = true

				arg_200_1:SetGaussion(false)
			end

			local var_203_15 = 2

			if var_203_14 <= arg_200_1.time_ and arg_200_1.time_ < var_203_14 + var_203_15 then
				local var_203_16 = (arg_200_1.time_ - var_203_14) / var_203_15
				local var_203_17 = Color.New(0, 0, 0)

				var_203_17.a = Mathf.Lerp(1, 0, var_203_16)
				arg_200_1.mask_.color = var_203_17
			end

			if arg_200_1.time_ >= var_203_14 + var_203_15 and arg_200_1.time_ < var_203_14 + var_203_15 + arg_203_0 then
				local var_203_18 = Color.New(0, 0, 0)
				local var_203_19 = 0

				arg_200_1.mask_.enabled = false
				var_203_18.a = var_203_19
				arg_200_1.mask_.color = var_203_18
			end

			if arg_200_1.frameCnt_ <= 1 then
				arg_200_1.dialog_:SetActive(false)
			end

			local var_203_20 = 4
			local var_203_21 = 1.15

			if var_203_20 < arg_200_1.time_ and arg_200_1.time_ <= var_203_20 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0

				arg_200_1.dialog_:SetActive(true)

				arg_200_1.dialogCg_.alpha = 0

				local var_203_22 = LeanTween.value(arg_200_1.dialog_, 0, 1, 0.3)

				var_203_22:setOnUpdate(LuaHelper.FloatAction(function(arg_204_0)
					arg_200_1.dialogCg_.alpha = arg_204_0
				end))
				var_203_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_200_1.dialog_)
					var_203_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_200_1.duration_ = arg_200_1.duration_ + 0.3

				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_23 = arg_200_1:GetWordFromCfg(112191051)
				local var_203_24 = arg_200_1:FormatText(var_203_23.content)

				arg_200_1.text_.text = var_203_24

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_25 = 46
				local var_203_26 = utf8.len(var_203_24)
				local var_203_27 = var_203_25 <= 0 and var_203_21 or var_203_21 * (var_203_26 / var_203_25)

				if var_203_27 > 0 and var_203_21 < var_203_27 then
					arg_200_1.talkMaxDuration = var_203_27
					var_203_20 = var_203_20 + 0.3

					if var_203_27 + var_203_20 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_27 + var_203_20
					end
				end

				arg_200_1.text_.text = var_203_24
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_28 = var_203_20 + 0.3
			local var_203_29 = math.max(var_203_21, arg_200_1.talkMaxDuration)

			if var_203_28 <= arg_200_1.time_ and arg_200_1.time_ < var_203_28 + var_203_29 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_28) / var_203_29

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_28 + var_203_29 and arg_200_1.time_ < var_203_28 + var_203_29 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play112191052 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 112191052
		arg_206_1.duration_ = 4

		local var_206_0 = {
			ja = 4,
			ko = 2.466,
			zh = 3.133,
			en = 2.166
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play112191053(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1081ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos1081ui_story = var_209_0.localPosition
			end

			local var_209_2 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2
				local var_209_4 = Vector3.New(0, -0.92, -5.8)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1081ui_story, var_209_4, var_209_3)

				local var_209_5 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_5.x, var_209_5.y, var_209_5.z)

				local var_209_6 = var_209_0.localEulerAngles

				var_209_6.z = 0
				var_209_6.x = 0
				var_209_0.localEulerAngles = var_209_6
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_209_7 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_7.x, var_209_7.y, var_209_7.z)

				local var_209_8 = var_209_0.localEulerAngles

				var_209_8.z = 0
				var_209_8.x = 0
				var_209_0.localEulerAngles = var_209_8
			end

			local var_209_9 = arg_206_1.actors_["1081ui_story"]
			local var_209_10 = 0

			if var_209_10 < arg_206_1.time_ and arg_206_1.time_ <= var_209_10 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect1081ui_story == nil then
				arg_206_1.var_.characterEffect1081ui_story = var_209_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_11 = 0.2

			if var_209_10 <= arg_206_1.time_ and arg_206_1.time_ < var_209_10 + var_209_11 and not isNil(var_209_9) then
				local var_209_12 = (arg_206_1.time_ - var_209_10) / var_209_11

				if arg_206_1.var_.characterEffect1081ui_story and not isNil(var_209_9) then
					arg_206_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_10 + var_209_11 and arg_206_1.time_ < var_209_10 + var_209_11 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect1081ui_story then
				arg_206_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_209_13 = 0

			if var_209_13 < arg_206_1.time_ and arg_206_1.time_ <= var_209_13 + arg_209_0 then
				arg_206_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			local var_209_14 = 0

			if var_209_14 < arg_206_1.time_ and arg_206_1.time_ <= var_209_14 + arg_209_0 then
				arg_206_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_209_15 = 0
			local var_209_16 = 0.275

			if var_209_15 < arg_206_1.time_ and arg_206_1.time_ <= var_209_15 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_17 = arg_206_1:FormatText(StoryNameCfg[202].name)

				arg_206_1.leftNameTxt_.text = var_209_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_18 = arg_206_1:GetWordFromCfg(112191052)
				local var_209_19 = arg_206_1:FormatText(var_209_18.content)

				arg_206_1.text_.text = var_209_19

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_20 = 11
				local var_209_21 = utf8.len(var_209_19)
				local var_209_22 = var_209_20 <= 0 and var_209_16 or var_209_16 * (var_209_21 / var_209_20)

				if var_209_22 > 0 and var_209_16 < var_209_22 then
					arg_206_1.talkMaxDuration = var_209_22

					if var_209_22 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_22 + var_209_15
					end
				end

				arg_206_1.text_.text = var_209_19
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191052", "story_v_out_112191.awb") ~= 0 then
					local var_209_23 = manager.audio:GetVoiceLength("story_v_out_112191", "112191052", "story_v_out_112191.awb") / 1000

					if var_209_23 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_23 + var_209_15
					end

					if var_209_18.prefab_name ~= "" and arg_206_1.actors_[var_209_18.prefab_name] ~= nil then
						local var_209_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_18.prefab_name].transform, "story_v_out_112191", "112191052", "story_v_out_112191.awb")

						arg_206_1:RecordAudio("112191052", var_209_24)
						arg_206_1:RecordAudio("112191052", var_209_24)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_112191", "112191052", "story_v_out_112191.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_112191", "112191052", "story_v_out_112191.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_25 = math.max(var_209_16, arg_206_1.talkMaxDuration)

			if var_209_15 <= arg_206_1.time_ and arg_206_1.time_ < var_209_15 + var_209_25 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_15) / var_209_25

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_15 + var_209_25 and arg_206_1.time_ < var_209_15 + var_209_25 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play112191053 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 112191053
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play112191054(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1081ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1081ui_story == nil then
				arg_210_1.var_.characterEffect1081ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.2

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect1081ui_story and not isNil(var_213_0) then
					local var_213_4 = Mathf.Lerp(0, 0.5, var_213_3)

					arg_210_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1081ui_story.fillRatio = var_213_4
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1081ui_story then
				local var_213_5 = 0.5

				arg_210_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1081ui_story.fillRatio = var_213_5
			end

			local var_213_6 = 0
			local var_213_7 = 0.25

			if var_213_6 < arg_210_1.time_ and arg_210_1.time_ <= var_213_6 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_8 = arg_210_1:FormatText(StoryNameCfg[7].name)

				arg_210_1.leftNameTxt_.text = var_213_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_9 = arg_210_1:GetWordFromCfg(112191053)
				local var_213_10 = arg_210_1:FormatText(var_213_9.content)

				arg_210_1.text_.text = var_213_10

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_11 = 10
				local var_213_12 = utf8.len(var_213_10)
				local var_213_13 = var_213_11 <= 0 and var_213_7 or var_213_7 * (var_213_12 / var_213_11)

				if var_213_13 > 0 and var_213_7 < var_213_13 then
					arg_210_1.talkMaxDuration = var_213_13

					if var_213_13 + var_213_6 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_13 + var_213_6
					end
				end

				arg_210_1.text_.text = var_213_10
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_14 = math.max(var_213_7, arg_210_1.talkMaxDuration)

			if var_213_6 <= arg_210_1.time_ and arg_210_1.time_ < var_213_6 + var_213_14 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_6) / var_213_14

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_6 + var_213_14 and arg_210_1.time_ < var_213_6 + var_213_14 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play112191054 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 112191054
		arg_214_1.duration_ = 3.7

		local var_214_0 = {
			ja = 3.7,
			ko = 2.833,
			zh = 2.8,
			en = 2.733
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play112191055(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1081ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1081ui_story == nil then
				arg_214_1.var_.characterEffect1081ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.2

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect1081ui_story and not isNil(var_217_0) then
					arg_214_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1081ui_story then
				arg_214_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_217_4 = 0

			if var_217_4 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			local var_217_5 = 0

			if var_217_5 < arg_214_1.time_ and arg_214_1.time_ <= var_217_5 + arg_217_0 then
				arg_214_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_217_6 = 0
			local var_217_7 = 0.35

			if var_217_6 < arg_214_1.time_ and arg_214_1.time_ <= var_217_6 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_8 = arg_214_1:FormatText(StoryNameCfg[202].name)

				arg_214_1.leftNameTxt_.text = var_217_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_9 = arg_214_1:GetWordFromCfg(112191054)
				local var_217_10 = arg_214_1:FormatText(var_217_9.content)

				arg_214_1.text_.text = var_217_10

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_11 = 14
				local var_217_12 = utf8.len(var_217_10)
				local var_217_13 = var_217_11 <= 0 and var_217_7 or var_217_7 * (var_217_12 / var_217_11)

				if var_217_13 > 0 and var_217_7 < var_217_13 then
					arg_214_1.talkMaxDuration = var_217_13

					if var_217_13 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_13 + var_217_6
					end
				end

				arg_214_1.text_.text = var_217_10
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191054", "story_v_out_112191.awb") ~= 0 then
					local var_217_14 = manager.audio:GetVoiceLength("story_v_out_112191", "112191054", "story_v_out_112191.awb") / 1000

					if var_217_14 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_14 + var_217_6
					end

					if var_217_9.prefab_name ~= "" and arg_214_1.actors_[var_217_9.prefab_name] ~= nil then
						local var_217_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_9.prefab_name].transform, "story_v_out_112191", "112191054", "story_v_out_112191.awb")

						arg_214_1:RecordAudio("112191054", var_217_15)
						arg_214_1:RecordAudio("112191054", var_217_15)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_112191", "112191054", "story_v_out_112191.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_112191", "112191054", "story_v_out_112191.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_16 = math.max(var_217_7, arg_214_1.talkMaxDuration)

			if var_217_6 <= arg_214_1.time_ and arg_214_1.time_ < var_217_6 + var_217_16 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_6) / var_217_16

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_6 + var_217_16 and arg_214_1.time_ < var_217_6 + var_217_16 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play112191055 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 112191055
		arg_218_1.duration_ = 2.83

		local var_218_0 = {
			ja = 2.033,
			ko = 2.4,
			zh = 2.833,
			en = 2.533
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play112191056(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1081ui_story"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1081ui_story == nil then
				arg_218_1.var_.characterEffect1081ui_story = var_221_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.2

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.characterEffect1081ui_story and not isNil(var_221_0) then
					local var_221_4 = Mathf.Lerp(0, 0.5, var_221_3)

					arg_218_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1081ui_story.fillRatio = var_221_4
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1081ui_story then
				local var_221_5 = 0.5

				arg_218_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1081ui_story.fillRatio = var_221_5
			end

			local var_221_6 = 0
			local var_221_7 = 0.225

			if var_221_6 < arg_218_1.time_ and arg_218_1.time_ <= var_221_6 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_8 = arg_218_1:FormatText(StoryNameCfg[56].name)

				arg_218_1.leftNameTxt_.text = var_221_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_9 = arg_218_1:GetWordFromCfg(112191055)
				local var_221_10 = arg_218_1:FormatText(var_221_9.content)

				arg_218_1.text_.text = var_221_10

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_11 = 9
				local var_221_12 = utf8.len(var_221_10)
				local var_221_13 = var_221_11 <= 0 and var_221_7 or var_221_7 * (var_221_12 / var_221_11)

				if var_221_13 > 0 and var_221_7 < var_221_13 then
					arg_218_1.talkMaxDuration = var_221_13

					if var_221_13 + var_221_6 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_13 + var_221_6
					end
				end

				arg_218_1.text_.text = var_221_10
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191055", "story_v_out_112191.awb") ~= 0 then
					local var_221_14 = manager.audio:GetVoiceLength("story_v_out_112191", "112191055", "story_v_out_112191.awb") / 1000

					if var_221_14 + var_221_6 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_14 + var_221_6
					end

					if var_221_9.prefab_name ~= "" and arg_218_1.actors_[var_221_9.prefab_name] ~= nil then
						local var_221_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_9.prefab_name].transform, "story_v_out_112191", "112191055", "story_v_out_112191.awb")

						arg_218_1:RecordAudio("112191055", var_221_15)
						arg_218_1:RecordAudio("112191055", var_221_15)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_112191", "112191055", "story_v_out_112191.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_112191", "112191055", "story_v_out_112191.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_16 = math.max(var_221_7, arg_218_1.talkMaxDuration)

			if var_221_6 <= arg_218_1.time_ and arg_218_1.time_ < var_221_6 + var_221_16 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_6) / var_221_16

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_6 + var_221_16 and arg_218_1.time_ < var_221_6 + var_221_16 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play112191056 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 112191056
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play112191057(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 1.425

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_2 = arg_222_1:GetWordFromCfg(112191056)
				local var_225_3 = arg_222_1:FormatText(var_225_2.content)

				arg_222_1.text_.text = var_225_3

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 57
				local var_225_5 = utf8.len(var_225_3)
				local var_225_6 = var_225_4 <= 0 and var_225_1 or var_225_1 * (var_225_5 / var_225_4)

				if var_225_6 > 0 and var_225_1 < var_225_6 then
					arg_222_1.talkMaxDuration = var_225_6

					if var_225_6 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_6 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_3
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_7 and arg_222_1.time_ < var_225_0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play112191057 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 112191057
		arg_226_1.duration_ = 8.6

		local var_226_0 = {
			ja = 6.8,
			ko = 4.9,
			zh = 8.6,
			en = 7.6
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play112191058(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1081ui_story"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1081ui_story == nil then
				arg_226_1.var_.characterEffect1081ui_story = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.2

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect1081ui_story and not isNil(var_229_0) then
					arg_226_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1081ui_story then
				arg_226_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_229_4 = 0

			if var_229_4 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action456")
			end

			local var_229_5 = 0

			if var_229_5 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 then
				arg_226_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_229_6 = 0
			local var_229_7 = 0.625

			if var_229_6 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_8 = arg_226_1:FormatText(StoryNameCfg[202].name)

				arg_226_1.leftNameTxt_.text = var_229_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_9 = arg_226_1:GetWordFromCfg(112191057)
				local var_229_10 = arg_226_1:FormatText(var_229_9.content)

				arg_226_1.text_.text = var_229_10

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 25
				local var_229_12 = utf8.len(var_229_10)
				local var_229_13 = var_229_11 <= 0 and var_229_7 or var_229_7 * (var_229_12 / var_229_11)

				if var_229_13 > 0 and var_229_7 < var_229_13 then
					arg_226_1.talkMaxDuration = var_229_13

					if var_229_13 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_6
					end
				end

				arg_226_1.text_.text = var_229_10
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191057", "story_v_out_112191.awb") ~= 0 then
					local var_229_14 = manager.audio:GetVoiceLength("story_v_out_112191", "112191057", "story_v_out_112191.awb") / 1000

					if var_229_14 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_14 + var_229_6
					end

					if var_229_9.prefab_name ~= "" and arg_226_1.actors_[var_229_9.prefab_name] ~= nil then
						local var_229_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_9.prefab_name].transform, "story_v_out_112191", "112191057", "story_v_out_112191.awb")

						arg_226_1:RecordAudio("112191057", var_229_15)
						arg_226_1:RecordAudio("112191057", var_229_15)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_112191", "112191057", "story_v_out_112191.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_112191", "112191057", "story_v_out_112191.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_16 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_16 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_16

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_16 and arg_226_1.time_ < var_229_6 + var_229_16 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play112191058 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 112191058
		arg_230_1.duration_ = 3.17

		local var_230_0 = {
			ja = 2.3,
			ko = 1.3,
			zh = 2.833,
			en = 3.166
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play112191059(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1081ui_story"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1081ui_story == nil then
				arg_230_1.var_.characterEffect1081ui_story = var_233_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.2

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.characterEffect1081ui_story and not isNil(var_233_0) then
					local var_233_4 = Mathf.Lerp(0, 0.5, var_233_3)

					arg_230_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1081ui_story.fillRatio = var_233_4
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1081ui_story then
				local var_233_5 = 0.5

				arg_230_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1081ui_story.fillRatio = var_233_5
			end

			local var_233_6 = 0
			local var_233_7 = 0.125

			if var_233_6 < arg_230_1.time_ and arg_230_1.time_ <= var_233_6 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_8 = arg_230_1:FormatText(StoryNameCfg[8].name)

				arg_230_1.leftNameTxt_.text = var_233_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_9 = arg_230_1:GetWordFromCfg(112191058)
				local var_233_10 = arg_230_1:FormatText(var_233_9.content)

				arg_230_1.text_.text = var_233_10

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_11 = 5
				local var_233_12 = utf8.len(var_233_10)
				local var_233_13 = var_233_11 <= 0 and var_233_7 or var_233_7 * (var_233_12 / var_233_11)

				if var_233_13 > 0 and var_233_7 < var_233_13 then
					arg_230_1.talkMaxDuration = var_233_13

					if var_233_13 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_13 + var_233_6
					end
				end

				arg_230_1.text_.text = var_233_10
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191058", "story_v_out_112191.awb") ~= 0 then
					local var_233_14 = manager.audio:GetVoiceLength("story_v_out_112191", "112191058", "story_v_out_112191.awb") / 1000

					if var_233_14 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_14 + var_233_6
					end

					if var_233_9.prefab_name ~= "" and arg_230_1.actors_[var_233_9.prefab_name] ~= nil then
						local var_233_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_9.prefab_name].transform, "story_v_out_112191", "112191058", "story_v_out_112191.awb")

						arg_230_1:RecordAudio("112191058", var_233_15)
						arg_230_1:RecordAudio("112191058", var_233_15)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_112191", "112191058", "story_v_out_112191.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_112191", "112191058", "story_v_out_112191.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_16 = math.max(var_233_7, arg_230_1.talkMaxDuration)

			if var_233_6 <= arg_230_1.time_ and arg_230_1.time_ < var_233_6 + var_233_16 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_6) / var_233_16

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_6 + var_233_16 and arg_230_1.time_ < var_233_6 + var_233_16 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play112191059 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 112191059
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play112191060(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1081ui_story"].transform
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.var_.moveOldPos1081ui_story = var_237_0.localPosition
			end

			local var_237_2 = 0.001

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2
				local var_237_4 = Vector3.New(0, 100, 0)

				var_237_0.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1081ui_story, var_237_4, var_237_3)

				local var_237_5 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_5.x, var_237_5.y, var_237_5.z)

				local var_237_6 = var_237_0.localEulerAngles

				var_237_6.z = 0
				var_237_6.x = 0
				var_237_0.localEulerAngles = var_237_6
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 then
				var_237_0.localPosition = Vector3.New(0, 100, 0)

				local var_237_7 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_7.x, var_237_7.y, var_237_7.z)

				local var_237_8 = var_237_0.localEulerAngles

				var_237_8.z = 0
				var_237_8.x = 0
				var_237_0.localEulerAngles = var_237_8
			end

			local var_237_9 = manager.ui.mainCamera.transform
			local var_237_10 = 0

			if var_237_10 < arg_234_1.time_ and arg_234_1.time_ <= var_237_10 + arg_237_0 then
				arg_234_1.var_.shakeOldPos = var_237_9.localPosition
			end

			local var_237_11 = 0.6

			if var_237_10 <= arg_234_1.time_ and arg_234_1.time_ < var_237_10 + var_237_11 then
				local var_237_12 = (arg_234_1.time_ - var_237_10) / 0.099
				local var_237_13, var_237_14 = math.modf(var_237_12)

				var_237_9.localPosition = Vector3.New(var_237_14 * 0.13, var_237_14 * 0.13, var_237_14 * 0.13) + arg_234_1.var_.shakeOldPos
			end

			if arg_234_1.time_ >= var_237_10 + var_237_11 and arg_234_1.time_ < var_237_10 + var_237_11 + arg_237_0 then
				var_237_9.localPosition = arg_234_1.var_.shakeOldPos
			end

			local var_237_15 = 0
			local var_237_16 = 0.675

			if var_237_15 < arg_234_1.time_ and arg_234_1.time_ <= var_237_15 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_17 = arg_234_1:GetWordFromCfg(112191059)
				local var_237_18 = arg_234_1:FormatText(var_237_17.content)

				arg_234_1.text_.text = var_237_18

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_19 = 27
				local var_237_20 = utf8.len(var_237_18)
				local var_237_21 = var_237_19 <= 0 and var_237_16 or var_237_16 * (var_237_20 / var_237_19)

				if var_237_21 > 0 and var_237_16 < var_237_21 then
					arg_234_1.talkMaxDuration = var_237_21

					if var_237_21 + var_237_15 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_21 + var_237_15
					end
				end

				arg_234_1.text_.text = var_237_18
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_22 = math.max(var_237_16, arg_234_1.talkMaxDuration)

			if var_237_15 <= arg_234_1.time_ and arg_234_1.time_ < var_237_15 + var_237_22 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_15) / var_237_22

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_15 + var_237_22 and arg_234_1.time_ < var_237_15 + var_237_22 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play112191060 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 112191060
		arg_238_1.duration_ = 7.8

		local var_238_0 = {
			ja = 7.8,
			ko = 4.3,
			zh = 6.6,
			en = 6.8
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play112191061(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1081ui_story"]
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect1081ui_story == nil then
				arg_238_1.var_.characterEffect1081ui_story = var_241_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.2

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.characterEffect1081ui_story and not isNil(var_241_0) then
					arg_238_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect1081ui_story then
				arg_238_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_241_4 = 0

			if var_241_4 < arg_238_1.time_ and arg_238_1.time_ <= var_241_4 + arg_241_0 then
				arg_238_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_241_5 = 0

			if var_241_5 < arg_238_1.time_ and arg_238_1.time_ <= var_241_5 + arg_241_0 then
				arg_238_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			local var_241_6 = arg_238_1.actors_["1081ui_story"].transform
			local var_241_7 = 0

			if var_241_7 < arg_238_1.time_ and arg_238_1.time_ <= var_241_7 + arg_241_0 then
				arg_238_1.var_.moveOldPos1081ui_story = var_241_6.localPosition
			end

			local var_241_8 = 0.001

			if var_241_7 <= arg_238_1.time_ and arg_238_1.time_ < var_241_7 + var_241_8 then
				local var_241_9 = (arg_238_1.time_ - var_241_7) / var_241_8
				local var_241_10 = Vector3.New(0, -0.92, -5.8)

				var_241_6.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1081ui_story, var_241_10, var_241_9)

				local var_241_11 = manager.ui.mainCamera.transform.position - var_241_6.position

				var_241_6.forward = Vector3.New(var_241_11.x, var_241_11.y, var_241_11.z)

				local var_241_12 = var_241_6.localEulerAngles

				var_241_12.z = 0
				var_241_12.x = 0
				var_241_6.localEulerAngles = var_241_12
			end

			if arg_238_1.time_ >= var_241_7 + var_241_8 and arg_238_1.time_ < var_241_7 + var_241_8 + arg_241_0 then
				var_241_6.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_241_13 = manager.ui.mainCamera.transform.position - var_241_6.position

				var_241_6.forward = Vector3.New(var_241_13.x, var_241_13.y, var_241_13.z)

				local var_241_14 = var_241_6.localEulerAngles

				var_241_14.z = 0
				var_241_14.x = 0
				var_241_6.localEulerAngles = var_241_14
			end

			local var_241_15 = 0
			local var_241_16 = 0.325

			if var_241_15 < arg_238_1.time_ and arg_238_1.time_ <= var_241_15 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_17 = arg_238_1:FormatText(StoryNameCfg[202].name)

				arg_238_1.leftNameTxt_.text = var_241_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_18 = arg_238_1:GetWordFromCfg(112191060)
				local var_241_19 = arg_238_1:FormatText(var_241_18.content)

				arg_238_1.text_.text = var_241_19

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_20 = 13
				local var_241_21 = utf8.len(var_241_19)
				local var_241_22 = var_241_20 <= 0 and var_241_16 or var_241_16 * (var_241_21 / var_241_20)

				if var_241_22 > 0 and var_241_16 < var_241_22 then
					arg_238_1.talkMaxDuration = var_241_22

					if var_241_22 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_22 + var_241_15
					end
				end

				arg_238_1.text_.text = var_241_19
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191060", "story_v_out_112191.awb") ~= 0 then
					local var_241_23 = manager.audio:GetVoiceLength("story_v_out_112191", "112191060", "story_v_out_112191.awb") / 1000

					if var_241_23 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_23 + var_241_15
					end

					if var_241_18.prefab_name ~= "" and arg_238_1.actors_[var_241_18.prefab_name] ~= nil then
						local var_241_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_18.prefab_name].transform, "story_v_out_112191", "112191060", "story_v_out_112191.awb")

						arg_238_1:RecordAudio("112191060", var_241_24)
						arg_238_1:RecordAudio("112191060", var_241_24)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_112191", "112191060", "story_v_out_112191.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_112191", "112191060", "story_v_out_112191.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_25 = math.max(var_241_16, arg_238_1.talkMaxDuration)

			if var_241_15 <= arg_238_1.time_ and arg_238_1.time_ < var_241_15 + var_241_25 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_15) / var_241_25

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_15 + var_241_25 and arg_238_1.time_ < var_241_15 + var_241_25 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play112191061 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 112191061
		arg_242_1.duration_ = 3.23

		local var_242_0 = {
			ja = 2.566,
			ko = 2.766,
			zh = 2.366,
			en = 3.233
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play112191062(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1081ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1081ui_story == nil then
				arg_242_1.var_.characterEffect1081ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.2

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect1081ui_story and not isNil(var_245_0) then
					local var_245_4 = Mathf.Lerp(0, 0.5, var_245_3)

					arg_242_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1081ui_story.fillRatio = var_245_4
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1081ui_story then
				local var_245_5 = 0.5

				arg_242_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1081ui_story.fillRatio = var_245_5
			end

			local var_245_6 = 0
			local var_245_7 = 0.275

			if var_245_6 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_8 = arg_242_1:FormatText(StoryNameCfg[8].name)

				arg_242_1.leftNameTxt_.text = var_245_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_9 = arg_242_1:GetWordFromCfg(112191061)
				local var_245_10 = arg_242_1:FormatText(var_245_9.content)

				arg_242_1.text_.text = var_245_10

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_11 = 11
				local var_245_12 = utf8.len(var_245_10)
				local var_245_13 = var_245_11 <= 0 and var_245_7 or var_245_7 * (var_245_12 / var_245_11)

				if var_245_13 > 0 and var_245_7 < var_245_13 then
					arg_242_1.talkMaxDuration = var_245_13

					if var_245_13 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_13 + var_245_6
					end
				end

				arg_242_1.text_.text = var_245_10
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191061", "story_v_out_112191.awb") ~= 0 then
					local var_245_14 = manager.audio:GetVoiceLength("story_v_out_112191", "112191061", "story_v_out_112191.awb") / 1000

					if var_245_14 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_14 + var_245_6
					end

					if var_245_9.prefab_name ~= "" and arg_242_1.actors_[var_245_9.prefab_name] ~= nil then
						local var_245_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_9.prefab_name].transform, "story_v_out_112191", "112191061", "story_v_out_112191.awb")

						arg_242_1:RecordAudio("112191061", var_245_15)
						arg_242_1:RecordAudio("112191061", var_245_15)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_112191", "112191061", "story_v_out_112191.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_112191", "112191061", "story_v_out_112191.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_16 = math.max(var_245_7, arg_242_1.talkMaxDuration)

			if var_245_6 <= arg_242_1.time_ and arg_242_1.time_ < var_245_6 + var_245_16 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_6) / var_245_16

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_6 + var_245_16 and arg_242_1.time_ < var_245_6 + var_245_16 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play112191062 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 112191062
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play112191063(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1081ui_story"].transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.moveOldPos1081ui_story = var_249_0.localPosition
			end

			local var_249_2 = 0.001

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2
				local var_249_4 = Vector3.New(0, 100, 0)

				var_249_0.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1081ui_story, var_249_4, var_249_3)

				local var_249_5 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_5.x, var_249_5.y, var_249_5.z)

				local var_249_6 = var_249_0.localEulerAngles

				var_249_6.z = 0
				var_249_6.x = 0
				var_249_0.localEulerAngles = var_249_6
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 then
				var_249_0.localPosition = Vector3.New(0, 100, 0)

				local var_249_7 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_7.x, var_249_7.y, var_249_7.z)

				local var_249_8 = var_249_0.localEulerAngles

				var_249_8.z = 0
				var_249_8.x = 0
				var_249_0.localEulerAngles = var_249_8
			end

			local var_249_9 = 0
			local var_249_10 = 0.7

			if var_249_9 < arg_246_1.time_ and arg_246_1.time_ <= var_249_9 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_11 = arg_246_1:GetWordFromCfg(112191062)
				local var_249_12 = arg_246_1:FormatText(var_249_11.content)

				arg_246_1.text_.text = var_249_12

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_13 = 28
				local var_249_14 = utf8.len(var_249_12)
				local var_249_15 = var_249_13 <= 0 and var_249_10 or var_249_10 * (var_249_14 / var_249_13)

				if var_249_15 > 0 and var_249_10 < var_249_15 then
					arg_246_1.talkMaxDuration = var_249_15

					if var_249_15 + var_249_9 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_15 + var_249_9
					end
				end

				arg_246_1.text_.text = var_249_12
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_16 = math.max(var_249_10, arg_246_1.talkMaxDuration)

			if var_249_9 <= arg_246_1.time_ and arg_246_1.time_ < var_249_9 + var_249_16 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_9) / var_249_16

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_9 + var_249_16 and arg_246_1.time_ < var_249_9 + var_249_16 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play112191063 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 112191063
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play112191064(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.2

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_2 = arg_250_1:FormatText(StoryNameCfg[7].name)

				arg_250_1.leftNameTxt_.text = var_253_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_3 = arg_250_1:GetWordFromCfg(112191063)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 8
				local var_253_6 = utf8.len(var_253_4)
				local var_253_7 = var_253_5 <= 0 and var_253_1 or var_253_1 * (var_253_6 / var_253_5)

				if var_253_7 > 0 and var_253_1 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_8 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_8 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_8

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_8 and arg_250_1.time_ < var_253_0 + var_253_8 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play112191064 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 112191064
		arg_254_1.duration_ = 6.3

		local var_254_0 = {
			ja = 6.3,
			ko = 3.966,
			zh = 3.6,
			en = 3.4
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play112191065(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1039ui_story"].transform
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.var_.moveOldPos1039ui_story = var_257_0.localPosition
			end

			local var_257_2 = 0.001

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2
				local var_257_4 = Vector3.New(0, -1.01, -5.9)

				var_257_0.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1039ui_story, var_257_4, var_257_3)

				local var_257_5 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_5.x, var_257_5.y, var_257_5.z)

				local var_257_6 = var_257_0.localEulerAngles

				var_257_6.z = 0
				var_257_6.x = 0
				var_257_0.localEulerAngles = var_257_6
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 then
				var_257_0.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_257_7 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_7.x, var_257_7.y, var_257_7.z)

				local var_257_8 = var_257_0.localEulerAngles

				var_257_8.z = 0
				var_257_8.x = 0
				var_257_0.localEulerAngles = var_257_8
			end

			local var_257_9 = arg_254_1.actors_["1039ui_story"]
			local var_257_10 = 0

			if var_257_10 < arg_254_1.time_ and arg_254_1.time_ <= var_257_10 + arg_257_0 and not isNil(var_257_9) and arg_254_1.var_.characterEffect1039ui_story == nil then
				arg_254_1.var_.characterEffect1039ui_story = var_257_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_11 = 0.2

			if var_257_10 <= arg_254_1.time_ and arg_254_1.time_ < var_257_10 + var_257_11 and not isNil(var_257_9) then
				local var_257_12 = (arg_254_1.time_ - var_257_10) / var_257_11

				if arg_254_1.var_.characterEffect1039ui_story and not isNil(var_257_9) then
					arg_254_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_10 + var_257_11 and arg_254_1.time_ < var_257_10 + var_257_11 + arg_257_0 and not isNil(var_257_9) and arg_254_1.var_.characterEffect1039ui_story then
				arg_254_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_257_13 = 0

			if var_257_13 < arg_254_1.time_ and arg_254_1.time_ <= var_257_13 + arg_257_0 then
				arg_254_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			local var_257_14 = 0

			if var_257_14 < arg_254_1.time_ and arg_254_1.time_ <= var_257_14 + arg_257_0 then
				arg_254_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_257_15 = 0
			local var_257_16 = 0.425

			if var_257_15 < arg_254_1.time_ and arg_254_1.time_ <= var_257_15 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_17 = arg_254_1:FormatText(StoryNameCfg[9].name)

				arg_254_1.leftNameTxt_.text = var_257_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_18 = arg_254_1:GetWordFromCfg(112191064)
				local var_257_19 = arg_254_1:FormatText(var_257_18.content)

				arg_254_1.text_.text = var_257_19

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_20 = 17
				local var_257_21 = utf8.len(var_257_19)
				local var_257_22 = var_257_20 <= 0 and var_257_16 or var_257_16 * (var_257_21 / var_257_20)

				if var_257_22 > 0 and var_257_16 < var_257_22 then
					arg_254_1.talkMaxDuration = var_257_22

					if var_257_22 + var_257_15 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_22 + var_257_15
					end
				end

				arg_254_1.text_.text = var_257_19
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191064", "story_v_out_112191.awb") ~= 0 then
					local var_257_23 = manager.audio:GetVoiceLength("story_v_out_112191", "112191064", "story_v_out_112191.awb") / 1000

					if var_257_23 + var_257_15 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_23 + var_257_15
					end

					if var_257_18.prefab_name ~= "" and arg_254_1.actors_[var_257_18.prefab_name] ~= nil then
						local var_257_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_18.prefab_name].transform, "story_v_out_112191", "112191064", "story_v_out_112191.awb")

						arg_254_1:RecordAudio("112191064", var_257_24)
						arg_254_1:RecordAudio("112191064", var_257_24)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_112191", "112191064", "story_v_out_112191.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_112191", "112191064", "story_v_out_112191.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_25 = math.max(var_257_16, arg_254_1.talkMaxDuration)

			if var_257_15 <= arg_254_1.time_ and arg_254_1.time_ < var_257_15 + var_257_25 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_15) / var_257_25

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_15 + var_257_25 and arg_254_1.time_ < var_257_15 + var_257_25 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play112191065 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 112191065
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play112191066(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1039ui_story"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect1039ui_story == nil then
				arg_258_1.var_.characterEffect1039ui_story = var_261_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.2

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.characterEffect1039ui_story and not isNil(var_261_0) then
					local var_261_4 = Mathf.Lerp(0, 0.5, var_261_3)

					arg_258_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1039ui_story.fillRatio = var_261_4
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect1039ui_story then
				local var_261_5 = 0.5

				arg_258_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1039ui_story.fillRatio = var_261_5
			end

			local var_261_6 = 0
			local var_261_7 = 0.475

			if var_261_6 < arg_258_1.time_ and arg_258_1.time_ <= var_261_6 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_8 = arg_258_1:FormatText(StoryNameCfg[7].name)

				arg_258_1.leftNameTxt_.text = var_261_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_9 = arg_258_1:GetWordFromCfg(112191065)
				local var_261_10 = arg_258_1:FormatText(var_261_9.content)

				arg_258_1.text_.text = var_261_10

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_11 = 19
				local var_261_12 = utf8.len(var_261_10)
				local var_261_13 = var_261_11 <= 0 and var_261_7 or var_261_7 * (var_261_12 / var_261_11)

				if var_261_13 > 0 and var_261_7 < var_261_13 then
					arg_258_1.talkMaxDuration = var_261_13

					if var_261_13 + var_261_6 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_6
					end
				end

				arg_258_1.text_.text = var_261_10
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_14 = math.max(var_261_7, arg_258_1.talkMaxDuration)

			if var_261_6 <= arg_258_1.time_ and arg_258_1.time_ < var_261_6 + var_261_14 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_6) / var_261_14

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_6 + var_261_14 and arg_258_1.time_ < var_261_6 + var_261_14 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play112191066 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 112191066
		arg_262_1.duration_ = 14.7

		local var_262_0 = {
			ja = 14.7,
			ko = 8.466,
			zh = 13.533,
			en = 10.4
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play112191067(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1039ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1039ui_story == nil then
				arg_262_1.var_.characterEffect1039ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.2

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect1039ui_story and not isNil(var_265_0) then
					arg_262_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1039ui_story then
				arg_262_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_265_4 = 0

			if var_265_4 < arg_262_1.time_ and arg_262_1.time_ <= var_265_4 + arg_265_0 then
				arg_262_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action448")
			end

			local var_265_5 = 0

			if var_265_5 < arg_262_1.time_ and arg_262_1.time_ <= var_265_5 + arg_265_0 then
				arg_262_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_265_6 = 0
			local var_265_7 = 1.475

			if var_265_6 < arg_262_1.time_ and arg_262_1.time_ <= var_265_6 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_8 = arg_262_1:FormatText(StoryNameCfg[9].name)

				arg_262_1.leftNameTxt_.text = var_265_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_9 = arg_262_1:GetWordFromCfg(112191066)
				local var_265_10 = arg_262_1:FormatText(var_265_9.content)

				arg_262_1.text_.text = var_265_10

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_11 = 59
				local var_265_12 = utf8.len(var_265_10)
				local var_265_13 = var_265_11 <= 0 and var_265_7 or var_265_7 * (var_265_12 / var_265_11)

				if var_265_13 > 0 and var_265_7 < var_265_13 then
					arg_262_1.talkMaxDuration = var_265_13

					if var_265_13 + var_265_6 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_13 + var_265_6
					end
				end

				arg_262_1.text_.text = var_265_10
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191066", "story_v_out_112191.awb") ~= 0 then
					local var_265_14 = manager.audio:GetVoiceLength("story_v_out_112191", "112191066", "story_v_out_112191.awb") / 1000

					if var_265_14 + var_265_6 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_14 + var_265_6
					end

					if var_265_9.prefab_name ~= "" and arg_262_1.actors_[var_265_9.prefab_name] ~= nil then
						local var_265_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_9.prefab_name].transform, "story_v_out_112191", "112191066", "story_v_out_112191.awb")

						arg_262_1:RecordAudio("112191066", var_265_15)
						arg_262_1:RecordAudio("112191066", var_265_15)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_112191", "112191066", "story_v_out_112191.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_112191", "112191066", "story_v_out_112191.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_16 = math.max(var_265_7, arg_262_1.talkMaxDuration)

			if var_265_6 <= arg_262_1.time_ and arg_262_1.time_ < var_265_6 + var_265_16 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_6) / var_265_16

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_6 + var_265_16 and arg_262_1.time_ < var_265_6 + var_265_16 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play112191067 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 112191067
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play112191068(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1039ui_story"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect1039ui_story == nil then
				arg_266_1.var_.characterEffect1039ui_story = var_269_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.2

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.characterEffect1039ui_story and not isNil(var_269_0) then
					local var_269_4 = Mathf.Lerp(0, 0.5, var_269_3)

					arg_266_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1039ui_story.fillRatio = var_269_4
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect1039ui_story then
				local var_269_5 = 0.5

				arg_266_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1039ui_story.fillRatio = var_269_5
			end

			local var_269_6 = 0
			local var_269_7 = 0.7

			if var_269_6 < arg_266_1.time_ and arg_266_1.time_ <= var_269_6 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_8 = arg_266_1:GetWordFromCfg(112191067)
				local var_269_9 = arg_266_1:FormatText(var_269_8.content)

				arg_266_1.text_.text = var_269_9

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_10 = 28
				local var_269_11 = utf8.len(var_269_9)
				local var_269_12 = var_269_10 <= 0 and var_269_7 or var_269_7 * (var_269_11 / var_269_10)

				if var_269_12 > 0 and var_269_7 < var_269_12 then
					arg_266_1.talkMaxDuration = var_269_12

					if var_269_12 + var_269_6 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_12 + var_269_6
					end
				end

				arg_266_1.text_.text = var_269_9
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_13 = math.max(var_269_7, arg_266_1.talkMaxDuration)

			if var_269_6 <= arg_266_1.time_ and arg_266_1.time_ < var_269_6 + var_269_13 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_6) / var_269_13

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_6 + var_269_13 and arg_266_1.time_ < var_269_6 + var_269_13 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play112191068 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 112191068
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play112191069(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.125

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[7].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:GetWordFromCfg(112191068)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 5
				local var_273_6 = utf8.len(var_273_4)
				local var_273_7 = var_273_5 <= 0 and var_273_1 or var_273_1 * (var_273_6 / var_273_5)

				if var_273_7 > 0 and var_273_1 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_8 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_8 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_8

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_8 and arg_270_1.time_ < var_273_0 + var_273_8 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play112191069 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 112191069
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play112191070(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1039ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos1039ui_story = var_277_0.localPosition
			end

			local var_277_2 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2
				local var_277_4 = Vector3.New(0, 100, 0)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1039ui_story, var_277_4, var_277_3)

				local var_277_5 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_5.x, var_277_5.y, var_277_5.z)

				local var_277_6 = var_277_0.localEulerAngles

				var_277_6.z = 0
				var_277_6.x = 0
				var_277_0.localEulerAngles = var_277_6
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0, 100, 0)

				local var_277_7 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_7.x, var_277_7.y, var_277_7.z)

				local var_277_8 = var_277_0.localEulerAngles

				var_277_8.z = 0
				var_277_8.x = 0
				var_277_0.localEulerAngles = var_277_8
			end

			local var_277_9 = 0
			local var_277_10 = 1.4

			if var_277_9 < arg_274_1.time_ and arg_274_1.time_ <= var_277_9 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_11 = arg_274_1:GetWordFromCfg(112191069)
				local var_277_12 = arg_274_1:FormatText(var_277_11.content)

				arg_274_1.text_.text = var_277_12

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_13 = 56
				local var_277_14 = utf8.len(var_277_12)
				local var_277_15 = var_277_13 <= 0 and var_277_10 or var_277_10 * (var_277_14 / var_277_13)

				if var_277_15 > 0 and var_277_10 < var_277_15 then
					arg_274_1.talkMaxDuration = var_277_15

					if var_277_15 + var_277_9 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_15 + var_277_9
					end
				end

				arg_274_1.text_.text = var_277_12
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_16 = math.max(var_277_10, arg_274_1.talkMaxDuration)

			if var_277_9 <= arg_274_1.time_ and arg_274_1.time_ < var_277_9 + var_277_16 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_9) / var_277_16

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_9 + var_277_16 and arg_274_1.time_ < var_277_9 + var_277_16 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play112191070 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 112191070
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play112191071(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 0.8

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[7].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_3 = arg_278_1:GetWordFromCfg(112191070)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 32
				local var_281_6 = utf8.len(var_281_4)
				local var_281_7 = var_281_5 <= 0 and var_281_1 or var_281_1 * (var_281_6 / var_281_5)

				if var_281_7 > 0 and var_281_1 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_8 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_8 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_8

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_8 and arg_278_1.time_ < var_281_0 + var_281_8 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play112191071 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 112191071
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play112191072(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 1.55

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_2 = arg_282_1:FormatText(StoryNameCfg[7].name)

				arg_282_1.leftNameTxt_.text = var_285_2

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

				local var_285_3 = arg_282_1:GetWordFromCfg(112191071)
				local var_285_4 = arg_282_1:FormatText(var_285_3.content)

				arg_282_1.text_.text = var_285_4

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 62
				local var_285_6 = utf8.len(var_285_4)
				local var_285_7 = var_285_5 <= 0 and var_285_1 or var_285_1 * (var_285_6 / var_285_5)

				if var_285_7 > 0 and var_285_1 < var_285_7 then
					arg_282_1.talkMaxDuration = var_285_7

					if var_285_7 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_7 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_4
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_8 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_8 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_8

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_8 and arg_282_1.time_ < var_285_0 + var_285_8 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play112191072 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 112191072
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play112191073(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.725

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_2 = arg_286_1:GetWordFromCfg(112191072)
				local var_289_3 = arg_286_1:FormatText(var_289_2.content)

				arg_286_1.text_.text = var_289_3

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_4 = 29
				local var_289_5 = utf8.len(var_289_3)
				local var_289_6 = var_289_4 <= 0 and var_289_1 or var_289_1 * (var_289_5 / var_289_4)

				if var_289_6 > 0 and var_289_1 < var_289_6 then
					arg_286_1.talkMaxDuration = var_289_6

					if var_289_6 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_6 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_3
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_7 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_7 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_7

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_7 and arg_286_1.time_ < var_289_0 + var_289_7 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play112191073 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 112191073
		arg_290_1.duration_ = 6.2

		local var_290_0 = {
			ja = 5.133,
			ko = 5,
			zh = 4.7,
			en = 6.2
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
				arg_290_0:Play112191074(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1148ui_story"].transform
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.var_.moveOldPos1148ui_story = var_293_0.localPosition
			end

			local var_293_2 = 0.001

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2
				local var_293_4 = Vector3.New(0, -0.8, -6.2)

				var_293_0.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1148ui_story, var_293_4, var_293_3)

				local var_293_5 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_5.x, var_293_5.y, var_293_5.z)

				local var_293_6 = var_293_0.localEulerAngles

				var_293_6.z = 0
				var_293_6.x = 0
				var_293_0.localEulerAngles = var_293_6
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 then
				var_293_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_293_7 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_7.x, var_293_7.y, var_293_7.z)

				local var_293_8 = var_293_0.localEulerAngles

				var_293_8.z = 0
				var_293_8.x = 0
				var_293_0.localEulerAngles = var_293_8
			end

			local var_293_9 = arg_290_1.actors_["1148ui_story"]
			local var_293_10 = 0

			if var_293_10 < arg_290_1.time_ and arg_290_1.time_ <= var_293_10 + arg_293_0 and not isNil(var_293_9) and arg_290_1.var_.characterEffect1148ui_story == nil then
				arg_290_1.var_.characterEffect1148ui_story = var_293_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_11 = 0.2

			if var_293_10 <= arg_290_1.time_ and arg_290_1.time_ < var_293_10 + var_293_11 and not isNil(var_293_9) then
				local var_293_12 = (arg_290_1.time_ - var_293_10) / var_293_11

				if arg_290_1.var_.characterEffect1148ui_story and not isNil(var_293_9) then
					arg_290_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= var_293_10 + var_293_11 and arg_290_1.time_ < var_293_10 + var_293_11 + arg_293_0 and not isNil(var_293_9) and arg_290_1.var_.characterEffect1148ui_story then
				arg_290_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_293_13 = 0

			if var_293_13 < arg_290_1.time_ and arg_290_1.time_ <= var_293_13 + arg_293_0 then
				arg_290_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_293_14 = 0

			if var_293_14 < arg_290_1.time_ and arg_290_1.time_ <= var_293_14 + arg_293_0 then
				arg_290_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_293_15 = 0
			local var_293_16 = 0.275

			if var_293_15 < arg_290_1.time_ and arg_290_1.time_ <= var_293_15 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_17 = arg_290_1:FormatText(StoryNameCfg[8].name)

				arg_290_1.leftNameTxt_.text = var_293_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_18 = arg_290_1:GetWordFromCfg(112191073)
				local var_293_19 = arg_290_1:FormatText(var_293_18.content)

				arg_290_1.text_.text = var_293_19

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_20 = 11
				local var_293_21 = utf8.len(var_293_19)
				local var_293_22 = var_293_20 <= 0 and var_293_16 or var_293_16 * (var_293_21 / var_293_20)

				if var_293_22 > 0 and var_293_16 < var_293_22 then
					arg_290_1.talkMaxDuration = var_293_22

					if var_293_22 + var_293_15 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_22 + var_293_15
					end
				end

				arg_290_1.text_.text = var_293_19
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191073", "story_v_out_112191.awb") ~= 0 then
					local var_293_23 = manager.audio:GetVoiceLength("story_v_out_112191", "112191073", "story_v_out_112191.awb") / 1000

					if var_293_23 + var_293_15 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_23 + var_293_15
					end

					if var_293_18.prefab_name ~= "" and arg_290_1.actors_[var_293_18.prefab_name] ~= nil then
						local var_293_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_18.prefab_name].transform, "story_v_out_112191", "112191073", "story_v_out_112191.awb")

						arg_290_1:RecordAudio("112191073", var_293_24)
						arg_290_1:RecordAudio("112191073", var_293_24)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_112191", "112191073", "story_v_out_112191.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_112191", "112191073", "story_v_out_112191.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_25 = math.max(var_293_16, arg_290_1.talkMaxDuration)

			if var_293_15 <= arg_290_1.time_ and arg_290_1.time_ < var_293_15 + var_293_25 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_15) / var_293_25

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_15 + var_293_25 and arg_290_1.time_ < var_293_15 + var_293_25 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
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

		arg_290_1:InitPlayNodeList()
	end,
	Play112191074 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 112191074
		arg_294_1.duration_ = 3.63

		local var_294_0 = {
			ja = 2.466,
			ko = 3.633,
			zh = 1.999999999999,
			en = 3.066
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play112191075(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["1148ui_story"].transform
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.var_.moveOldPos1148ui_story = var_297_0.localPosition
			end

			local var_297_2 = 0.001

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2
				local var_297_4 = Vector3.New(0, 100, 0)

				var_297_0.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1148ui_story, var_297_4, var_297_3)

				local var_297_5 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_5.x, var_297_5.y, var_297_5.z)

				local var_297_6 = var_297_0.localEulerAngles

				var_297_6.z = 0
				var_297_6.x = 0
				var_297_0.localEulerAngles = var_297_6
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 then
				var_297_0.localPosition = Vector3.New(0, 100, 0)

				local var_297_7 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_7.x, var_297_7.y, var_297_7.z)

				local var_297_8 = var_297_0.localEulerAngles

				var_297_8.z = 0
				var_297_8.x = 0
				var_297_0.localEulerAngles = var_297_8
			end

			local var_297_9 = arg_294_1.actors_["1084ui_story"].transform
			local var_297_10 = 0

			if var_297_10 < arg_294_1.time_ and arg_294_1.time_ <= var_297_10 + arg_297_0 then
				arg_294_1.var_.moveOldPos1084ui_story = var_297_9.localPosition
			end

			local var_297_11 = 0.001

			if var_297_10 <= arg_294_1.time_ and arg_294_1.time_ < var_297_10 + var_297_11 then
				local var_297_12 = (arg_294_1.time_ - var_297_10) / var_297_11
				local var_297_13 = Vector3.New(0, -0.97, -6)

				var_297_9.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1084ui_story, var_297_13, var_297_12)

				local var_297_14 = manager.ui.mainCamera.transform.position - var_297_9.position

				var_297_9.forward = Vector3.New(var_297_14.x, var_297_14.y, var_297_14.z)

				local var_297_15 = var_297_9.localEulerAngles

				var_297_15.z = 0
				var_297_15.x = 0
				var_297_9.localEulerAngles = var_297_15
			end

			if arg_294_1.time_ >= var_297_10 + var_297_11 and arg_294_1.time_ < var_297_10 + var_297_11 + arg_297_0 then
				var_297_9.localPosition = Vector3.New(0, -0.97, -6)

				local var_297_16 = manager.ui.mainCamera.transform.position - var_297_9.position

				var_297_9.forward = Vector3.New(var_297_16.x, var_297_16.y, var_297_16.z)

				local var_297_17 = var_297_9.localEulerAngles

				var_297_17.z = 0
				var_297_17.x = 0
				var_297_9.localEulerAngles = var_297_17
			end

			local var_297_18 = arg_294_1.actors_["1084ui_story"]
			local var_297_19 = 0

			if var_297_19 < arg_294_1.time_ and arg_294_1.time_ <= var_297_19 + arg_297_0 and not isNil(var_297_18) and arg_294_1.var_.characterEffect1084ui_story == nil then
				arg_294_1.var_.characterEffect1084ui_story = var_297_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_20 = 0.2

			if var_297_19 <= arg_294_1.time_ and arg_294_1.time_ < var_297_19 + var_297_20 and not isNil(var_297_18) then
				local var_297_21 = (arg_294_1.time_ - var_297_19) / var_297_20

				if arg_294_1.var_.characterEffect1084ui_story and not isNil(var_297_18) then
					arg_294_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= var_297_19 + var_297_20 and arg_294_1.time_ < var_297_19 + var_297_20 + arg_297_0 and not isNil(var_297_18) and arg_294_1.var_.characterEffect1084ui_story then
				arg_294_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_297_22 = 0

			if var_297_22 < arg_294_1.time_ and arg_294_1.time_ <= var_297_22 + arg_297_0 then
				arg_294_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_297_23 = 0

			if var_297_23 < arg_294_1.time_ and arg_294_1.time_ <= var_297_23 + arg_297_0 then
				arg_294_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_297_24 = 0
			local var_297_25 = 0.175

			if var_297_24 < arg_294_1.time_ and arg_294_1.time_ <= var_297_24 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_26 = arg_294_1:FormatText(StoryNameCfg[6].name)

				arg_294_1.leftNameTxt_.text = var_297_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_27 = arg_294_1:GetWordFromCfg(112191074)
				local var_297_28 = arg_294_1:FormatText(var_297_27.content)

				arg_294_1.text_.text = var_297_28

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_29 = 7
				local var_297_30 = utf8.len(var_297_28)
				local var_297_31 = var_297_29 <= 0 and var_297_25 or var_297_25 * (var_297_30 / var_297_29)

				if var_297_31 > 0 and var_297_25 < var_297_31 then
					arg_294_1.talkMaxDuration = var_297_31

					if var_297_31 + var_297_24 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_31 + var_297_24
					end
				end

				arg_294_1.text_.text = var_297_28
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191074", "story_v_out_112191.awb") ~= 0 then
					local var_297_32 = manager.audio:GetVoiceLength("story_v_out_112191", "112191074", "story_v_out_112191.awb") / 1000

					if var_297_32 + var_297_24 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_32 + var_297_24
					end

					if var_297_27.prefab_name ~= "" and arg_294_1.actors_[var_297_27.prefab_name] ~= nil then
						local var_297_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_27.prefab_name].transform, "story_v_out_112191", "112191074", "story_v_out_112191.awb")

						arg_294_1:RecordAudio("112191074", var_297_33)
						arg_294_1:RecordAudio("112191074", var_297_33)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_112191", "112191074", "story_v_out_112191.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_112191", "112191074", "story_v_out_112191.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_34 = math.max(var_297_25, arg_294_1.talkMaxDuration)

			if var_297_24 <= arg_294_1.time_ and arg_294_1.time_ < var_297_24 + var_297_34 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_24) / var_297_34

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_24 + var_297_34 and arg_294_1.time_ < var_297_24 + var_297_34 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play112191075 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 112191075
		arg_298_1.duration_ = 8.1

		local var_298_0 = {
			ja = 7.466,
			ko = 5.333,
			zh = 6.833,
			en = 8.1
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
				arg_298_0:Play112191076(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["1084ui_story"].transform
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.var_.moveOldPos1084ui_story = var_301_0.localPosition
			end

			local var_301_2 = 0.001

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2
				local var_301_4 = Vector3.New(0, 100, 0)

				var_301_0.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1084ui_story, var_301_4, var_301_3)

				local var_301_5 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_5.x, var_301_5.y, var_301_5.z)

				local var_301_6 = var_301_0.localEulerAngles

				var_301_6.z = 0
				var_301_6.x = 0
				var_301_0.localEulerAngles = var_301_6
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 then
				var_301_0.localPosition = Vector3.New(0, 100, 0)

				local var_301_7 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_7.x, var_301_7.y, var_301_7.z)

				local var_301_8 = var_301_0.localEulerAngles

				var_301_8.z = 0
				var_301_8.x = 0
				var_301_0.localEulerAngles = var_301_8
			end

			local var_301_9 = arg_298_1.actors_["1027ui_story"].transform
			local var_301_10 = 0

			if var_301_10 < arg_298_1.time_ and arg_298_1.time_ <= var_301_10 + arg_301_0 then
				arg_298_1.var_.moveOldPos1027ui_story = var_301_9.localPosition
			end

			local var_301_11 = 0.001

			if var_301_10 <= arg_298_1.time_ and arg_298_1.time_ < var_301_10 + var_301_11 then
				local var_301_12 = (arg_298_1.time_ - var_301_10) / var_301_11
				local var_301_13 = Vector3.New(0, -0.81, -5.8)

				var_301_9.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1027ui_story, var_301_13, var_301_12)

				local var_301_14 = manager.ui.mainCamera.transform.position - var_301_9.position

				var_301_9.forward = Vector3.New(var_301_14.x, var_301_14.y, var_301_14.z)

				local var_301_15 = var_301_9.localEulerAngles

				var_301_15.z = 0
				var_301_15.x = 0
				var_301_9.localEulerAngles = var_301_15
			end

			if arg_298_1.time_ >= var_301_10 + var_301_11 and arg_298_1.time_ < var_301_10 + var_301_11 + arg_301_0 then
				var_301_9.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_301_16 = manager.ui.mainCamera.transform.position - var_301_9.position

				var_301_9.forward = Vector3.New(var_301_16.x, var_301_16.y, var_301_16.z)

				local var_301_17 = var_301_9.localEulerAngles

				var_301_17.z = 0
				var_301_17.x = 0
				var_301_9.localEulerAngles = var_301_17
			end

			local var_301_18 = arg_298_1.actors_["1027ui_story"]
			local var_301_19 = 0

			if var_301_19 < arg_298_1.time_ and arg_298_1.time_ <= var_301_19 + arg_301_0 and not isNil(var_301_18) and arg_298_1.var_.characterEffect1027ui_story == nil then
				arg_298_1.var_.characterEffect1027ui_story = var_301_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_20 = 0.2

			if var_301_19 <= arg_298_1.time_ and arg_298_1.time_ < var_301_19 + var_301_20 and not isNil(var_301_18) then
				local var_301_21 = (arg_298_1.time_ - var_301_19) / var_301_20

				if arg_298_1.var_.characterEffect1027ui_story and not isNil(var_301_18) then
					arg_298_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= var_301_19 + var_301_20 and arg_298_1.time_ < var_301_19 + var_301_20 + arg_301_0 and not isNil(var_301_18) and arg_298_1.var_.characterEffect1027ui_story then
				arg_298_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_301_22 = 0

			if var_301_22 < arg_298_1.time_ and arg_298_1.time_ <= var_301_22 + arg_301_0 then
				arg_298_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			local var_301_23 = 0

			if var_301_23 < arg_298_1.time_ and arg_298_1.time_ <= var_301_23 + arg_301_0 then
				arg_298_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_301_24 = 0
			local var_301_25 = 0.6

			if var_301_24 < arg_298_1.time_ and arg_298_1.time_ <= var_301_24 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_26 = arg_298_1:FormatText(StoryNameCfg[56].name)

				arg_298_1.leftNameTxt_.text = var_301_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_27 = arg_298_1:GetWordFromCfg(112191075)
				local var_301_28 = arg_298_1:FormatText(var_301_27.content)

				arg_298_1.text_.text = var_301_28

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_29 = 24
				local var_301_30 = utf8.len(var_301_28)
				local var_301_31 = var_301_29 <= 0 and var_301_25 or var_301_25 * (var_301_30 / var_301_29)

				if var_301_31 > 0 and var_301_25 < var_301_31 then
					arg_298_1.talkMaxDuration = var_301_31

					if var_301_31 + var_301_24 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_31 + var_301_24
					end
				end

				arg_298_1.text_.text = var_301_28
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191075", "story_v_out_112191.awb") ~= 0 then
					local var_301_32 = manager.audio:GetVoiceLength("story_v_out_112191", "112191075", "story_v_out_112191.awb") / 1000

					if var_301_32 + var_301_24 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_32 + var_301_24
					end

					if var_301_27.prefab_name ~= "" and arg_298_1.actors_[var_301_27.prefab_name] ~= nil then
						local var_301_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_27.prefab_name].transform, "story_v_out_112191", "112191075", "story_v_out_112191.awb")

						arg_298_1:RecordAudio("112191075", var_301_33)
						arg_298_1:RecordAudio("112191075", var_301_33)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_112191", "112191075", "story_v_out_112191.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_112191", "112191075", "story_v_out_112191.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_34 = math.max(var_301_25, arg_298_1.talkMaxDuration)

			if var_301_24 <= arg_298_1.time_ and arg_298_1.time_ < var_301_24 + var_301_34 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_24) / var_301_34

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_24 + var_301_34 and arg_298_1.time_ < var_301_24 + var_301_34 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play112191076 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 112191076
		arg_302_1.duration_ = 4.9

		local var_302_0 = {
			ja = 4.9,
			ko = 3.2,
			zh = 3.933,
			en = 2.533
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
				arg_302_0:Play112191077(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1027ui_story"].transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.var_.moveOldPos1027ui_story = var_305_0.localPosition
			end

			local var_305_2 = 0.001

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2
				local var_305_4 = Vector3.New(0, 100, 0)

				var_305_0.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1027ui_story, var_305_4, var_305_3)

				local var_305_5 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_5.x, var_305_5.y, var_305_5.z)

				local var_305_6 = var_305_0.localEulerAngles

				var_305_6.z = 0
				var_305_6.x = 0
				var_305_0.localEulerAngles = var_305_6
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 then
				var_305_0.localPosition = Vector3.New(0, 100, 0)

				local var_305_7 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_7.x, var_305_7.y, var_305_7.z)

				local var_305_8 = var_305_0.localEulerAngles

				var_305_8.z = 0
				var_305_8.x = 0
				var_305_0.localEulerAngles = var_305_8
			end

			local var_305_9 = arg_302_1.actors_["1081ui_story"].transform
			local var_305_10 = 0

			if var_305_10 < arg_302_1.time_ and arg_302_1.time_ <= var_305_10 + arg_305_0 then
				arg_302_1.var_.moveOldPos1081ui_story = var_305_9.localPosition
			end

			local var_305_11 = 0.001

			if var_305_10 <= arg_302_1.time_ and arg_302_1.time_ < var_305_10 + var_305_11 then
				local var_305_12 = (arg_302_1.time_ - var_305_10) / var_305_11
				local var_305_13 = Vector3.New(0, -0.92, -5.8)

				var_305_9.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1081ui_story, var_305_13, var_305_12)

				local var_305_14 = manager.ui.mainCamera.transform.position - var_305_9.position

				var_305_9.forward = Vector3.New(var_305_14.x, var_305_14.y, var_305_14.z)

				local var_305_15 = var_305_9.localEulerAngles

				var_305_15.z = 0
				var_305_15.x = 0
				var_305_9.localEulerAngles = var_305_15
			end

			if arg_302_1.time_ >= var_305_10 + var_305_11 and arg_302_1.time_ < var_305_10 + var_305_11 + arg_305_0 then
				var_305_9.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_305_16 = manager.ui.mainCamera.transform.position - var_305_9.position

				var_305_9.forward = Vector3.New(var_305_16.x, var_305_16.y, var_305_16.z)

				local var_305_17 = var_305_9.localEulerAngles

				var_305_17.z = 0
				var_305_17.x = 0
				var_305_9.localEulerAngles = var_305_17
			end

			local var_305_18 = arg_302_1.actors_["1081ui_story"]
			local var_305_19 = 0

			if var_305_19 < arg_302_1.time_ and arg_302_1.time_ <= var_305_19 + arg_305_0 and not isNil(var_305_18) and arg_302_1.var_.characterEffect1081ui_story == nil then
				arg_302_1.var_.characterEffect1081ui_story = var_305_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_20 = 0.2

			if var_305_19 <= arg_302_1.time_ and arg_302_1.time_ < var_305_19 + var_305_20 and not isNil(var_305_18) then
				local var_305_21 = (arg_302_1.time_ - var_305_19) / var_305_20

				if arg_302_1.var_.characterEffect1081ui_story and not isNil(var_305_18) then
					arg_302_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_19 + var_305_20 and arg_302_1.time_ < var_305_19 + var_305_20 + arg_305_0 and not isNil(var_305_18) and arg_302_1.var_.characterEffect1081ui_story then
				arg_302_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_305_22 = 0

			if var_305_22 < arg_302_1.time_ and arg_302_1.time_ <= var_305_22 + arg_305_0 then
				arg_302_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			local var_305_23 = 0

			if var_305_23 < arg_302_1.time_ and arg_302_1.time_ <= var_305_23 + arg_305_0 then
				arg_302_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_305_24 = 0
			local var_305_25 = 0.45

			if var_305_24 < arg_302_1.time_ and arg_302_1.time_ <= var_305_24 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_26 = arg_302_1:FormatText(StoryNameCfg[202].name)

				arg_302_1.leftNameTxt_.text = var_305_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_27 = arg_302_1:GetWordFromCfg(112191076)
				local var_305_28 = arg_302_1:FormatText(var_305_27.content)

				arg_302_1.text_.text = var_305_28

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_29 = 18
				local var_305_30 = utf8.len(var_305_28)
				local var_305_31 = var_305_29 <= 0 and var_305_25 or var_305_25 * (var_305_30 / var_305_29)

				if var_305_31 > 0 and var_305_25 < var_305_31 then
					arg_302_1.talkMaxDuration = var_305_31

					if var_305_31 + var_305_24 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_31 + var_305_24
					end
				end

				arg_302_1.text_.text = var_305_28
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191076", "story_v_out_112191.awb") ~= 0 then
					local var_305_32 = manager.audio:GetVoiceLength("story_v_out_112191", "112191076", "story_v_out_112191.awb") / 1000

					if var_305_32 + var_305_24 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_32 + var_305_24
					end

					if var_305_27.prefab_name ~= "" and arg_302_1.actors_[var_305_27.prefab_name] ~= nil then
						local var_305_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_27.prefab_name].transform, "story_v_out_112191", "112191076", "story_v_out_112191.awb")

						arg_302_1:RecordAudio("112191076", var_305_33)
						arg_302_1:RecordAudio("112191076", var_305_33)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_112191", "112191076", "story_v_out_112191.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_112191", "112191076", "story_v_out_112191.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_34 = math.max(var_305_25, arg_302_1.talkMaxDuration)

			if var_305_24 <= arg_302_1.time_ and arg_302_1.time_ < var_305_24 + var_305_34 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_24) / var_305_34

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_24 + var_305_34 and arg_302_1.time_ < var_305_24 + var_305_34 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play112191077 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 112191077
		arg_306_1.duration_ = 2.8

		local var_306_0 = {
			ja = 2.666,
			ko = 2.633,
			zh = 2.8,
			en = 2.5
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
				arg_306_0:Play112191078(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1081ui_story"].transform
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.var_.moveOldPos1081ui_story = var_309_0.localPosition
			end

			local var_309_2 = 0.001

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2
				local var_309_4 = Vector3.New(0, 100, 0)

				var_309_0.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1081ui_story, var_309_4, var_309_3)

				local var_309_5 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_5.x, var_309_5.y, var_309_5.z)

				local var_309_6 = var_309_0.localEulerAngles

				var_309_6.z = 0
				var_309_6.x = 0
				var_309_0.localEulerAngles = var_309_6
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 then
				var_309_0.localPosition = Vector3.New(0, 100, 0)

				local var_309_7 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_7.x, var_309_7.y, var_309_7.z)

				local var_309_8 = var_309_0.localEulerAngles

				var_309_8.z = 0
				var_309_8.x = 0
				var_309_0.localEulerAngles = var_309_8
			end

			local var_309_9 = arg_306_1.actors_["1039ui_story"].transform
			local var_309_10 = 0

			if var_309_10 < arg_306_1.time_ and arg_306_1.time_ <= var_309_10 + arg_309_0 then
				arg_306_1.var_.moveOldPos1039ui_story = var_309_9.localPosition
			end

			local var_309_11 = 0.001

			if var_309_10 <= arg_306_1.time_ and arg_306_1.time_ < var_309_10 + var_309_11 then
				local var_309_12 = (arg_306_1.time_ - var_309_10) / var_309_11
				local var_309_13 = Vector3.New(0, -1.01, -5.9)

				var_309_9.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1039ui_story, var_309_13, var_309_12)

				local var_309_14 = manager.ui.mainCamera.transform.position - var_309_9.position

				var_309_9.forward = Vector3.New(var_309_14.x, var_309_14.y, var_309_14.z)

				local var_309_15 = var_309_9.localEulerAngles

				var_309_15.z = 0
				var_309_15.x = 0
				var_309_9.localEulerAngles = var_309_15
			end

			if arg_306_1.time_ >= var_309_10 + var_309_11 and arg_306_1.time_ < var_309_10 + var_309_11 + arg_309_0 then
				var_309_9.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_309_16 = manager.ui.mainCamera.transform.position - var_309_9.position

				var_309_9.forward = Vector3.New(var_309_16.x, var_309_16.y, var_309_16.z)

				local var_309_17 = var_309_9.localEulerAngles

				var_309_17.z = 0
				var_309_17.x = 0
				var_309_9.localEulerAngles = var_309_17
			end

			local var_309_18 = arg_306_1.actors_["1039ui_story"]
			local var_309_19 = 0

			if var_309_19 < arg_306_1.time_ and arg_306_1.time_ <= var_309_19 + arg_309_0 and not isNil(var_309_18) and arg_306_1.var_.characterEffect1039ui_story == nil then
				arg_306_1.var_.characterEffect1039ui_story = var_309_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_20 = 0.2

			if var_309_19 <= arg_306_1.time_ and arg_306_1.time_ < var_309_19 + var_309_20 and not isNil(var_309_18) then
				local var_309_21 = (arg_306_1.time_ - var_309_19) / var_309_20

				if arg_306_1.var_.characterEffect1039ui_story and not isNil(var_309_18) then
					arg_306_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= var_309_19 + var_309_20 and arg_306_1.time_ < var_309_19 + var_309_20 + arg_309_0 and not isNil(var_309_18) and arg_306_1.var_.characterEffect1039ui_story then
				arg_306_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_309_22 = 0

			if var_309_22 < arg_306_1.time_ and arg_306_1.time_ <= var_309_22 + arg_309_0 then
				arg_306_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_309_23 = 0

			if var_309_23 < arg_306_1.time_ and arg_306_1.time_ <= var_309_23 + arg_309_0 then
				arg_306_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_309_24 = 0
			local var_309_25 = 0.2

			if var_309_24 < arg_306_1.time_ and arg_306_1.time_ <= var_309_24 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_26 = arg_306_1:FormatText(StoryNameCfg[9].name)

				arg_306_1.leftNameTxt_.text = var_309_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_27 = arg_306_1:GetWordFromCfg(112191077)
				local var_309_28 = arg_306_1:FormatText(var_309_27.content)

				arg_306_1.text_.text = var_309_28

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_29 = 8
				local var_309_30 = utf8.len(var_309_28)
				local var_309_31 = var_309_29 <= 0 and var_309_25 or var_309_25 * (var_309_30 / var_309_29)

				if var_309_31 > 0 and var_309_25 < var_309_31 then
					arg_306_1.talkMaxDuration = var_309_31

					if var_309_31 + var_309_24 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_31 + var_309_24
					end
				end

				arg_306_1.text_.text = var_309_28
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191077", "story_v_out_112191.awb") ~= 0 then
					local var_309_32 = manager.audio:GetVoiceLength("story_v_out_112191", "112191077", "story_v_out_112191.awb") / 1000

					if var_309_32 + var_309_24 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_32 + var_309_24
					end

					if var_309_27.prefab_name ~= "" and arg_306_1.actors_[var_309_27.prefab_name] ~= nil then
						local var_309_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_27.prefab_name].transform, "story_v_out_112191", "112191077", "story_v_out_112191.awb")

						arg_306_1:RecordAudio("112191077", var_309_33)
						arg_306_1:RecordAudio("112191077", var_309_33)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_112191", "112191077", "story_v_out_112191.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_112191", "112191077", "story_v_out_112191.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_34 = math.max(var_309_25, arg_306_1.talkMaxDuration)

			if var_309_24 <= arg_306_1.time_ and arg_306_1.time_ < var_309_24 + var_309_34 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_24) / var_309_34

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_24 + var_309_34 and arg_306_1.time_ < var_309_24 + var_309_34 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play112191078 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 112191078
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play112191079(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["1039ui_story"].transform
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.var_.moveOldPos1039ui_story = var_313_0.localPosition
			end

			local var_313_2 = 0.001

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2
				local var_313_4 = Vector3.New(0, 100, 0)

				var_313_0.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1039ui_story, var_313_4, var_313_3)

				local var_313_5 = manager.ui.mainCamera.transform.position - var_313_0.position

				var_313_0.forward = Vector3.New(var_313_5.x, var_313_5.y, var_313_5.z)

				local var_313_6 = var_313_0.localEulerAngles

				var_313_6.z = 0
				var_313_6.x = 0
				var_313_0.localEulerAngles = var_313_6
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 then
				var_313_0.localPosition = Vector3.New(0, 100, 0)

				local var_313_7 = manager.ui.mainCamera.transform.position - var_313_0.position

				var_313_0.forward = Vector3.New(var_313_7.x, var_313_7.y, var_313_7.z)

				local var_313_8 = var_313_0.localEulerAngles

				var_313_8.z = 0
				var_313_8.x = 0
				var_313_0.localEulerAngles = var_313_8
			end

			local var_313_9 = 0
			local var_313_10 = 1

			if var_313_9 < arg_310_1.time_ and arg_310_1.time_ <= var_313_9 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_11 = arg_310_1:GetWordFromCfg(112191078)
				local var_313_12 = arg_310_1:FormatText(var_313_11.content)

				arg_310_1.text_.text = var_313_12

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_13 = 40
				local var_313_14 = utf8.len(var_313_12)
				local var_313_15 = var_313_13 <= 0 and var_313_10 or var_313_10 * (var_313_14 / var_313_13)

				if var_313_15 > 0 and var_313_10 < var_313_15 then
					arg_310_1.talkMaxDuration = var_313_15

					if var_313_15 + var_313_9 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_15 + var_313_9
					end
				end

				arg_310_1.text_.text = var_313_12
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_16 = math.max(var_313_10, arg_310_1.talkMaxDuration)

			if var_313_9 <= arg_310_1.time_ and arg_310_1.time_ < var_313_9 + var_313_16 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_9) / var_313_16

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_9 + var_313_16 and arg_310_1.time_ < var_313_9 + var_313_16 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play112191079 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 112191079
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
			arg_314_1.auto_ = false
		end

		function arg_314_1.playNext_(arg_316_0)
			arg_314_1.onStoryFinished_()
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0
			local var_317_1 = 1.35

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_2 = arg_314_1:GetWordFromCfg(112191079)
				local var_317_3 = arg_314_1:FormatText(var_317_2.content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 54
				local var_317_5 = utf8.len(var_317_3)
				local var_317_6 = var_317_4 <= 0 and var_317_1 or var_317_1 * (var_317_5 / var_317_4)

				if var_317_6 > 0 and var_317_1 < var_317_6 then
					arg_314_1.talkMaxDuration = var_317_6

					if var_317_6 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_6 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_7 and arg_314_1.time_ < var_317_0 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play112191035 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 112191035
		arg_318_1.duration_ = 7.33

		local var_318_0 = {
			ja = 7.333,
			ko = 5.966,
			zh = 6.366,
			en = 5.4
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
				arg_318_0:Play112191036(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1148ui_story"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1148ui_story == nil then
				arg_318_1.var_.characterEffect1148ui_story = var_321_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.2

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.characterEffect1148ui_story and not isNil(var_321_0) then
					arg_318_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1148ui_story then
				arg_318_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_321_4 = "1148ui_story"

			if arg_318_1.actors_[var_321_4] == nil then
				local var_321_5 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_321_5) then
					local var_321_6 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_318_1.stage_.transform)

					var_321_6.name = var_321_4
					var_321_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_318_1.actors_[var_321_4] = var_321_6

					local var_321_7 = var_321_6:GetComponentInChildren(typeof(CharacterEffect))

					var_321_7.enabled = true

					local var_321_8 = GameObjectTools.GetOrAddComponent(var_321_6, typeof(DynamicBoneHelper))

					if var_321_8 then
						var_321_8:EnableDynamicBone(false)
					end

					arg_318_1:ShowWeapon(var_321_7.transform, false)

					arg_318_1.var_[var_321_4 .. "Animator"] = var_321_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_318_1.var_[var_321_4 .. "Animator"].applyRootMotion = true
					arg_318_1.var_[var_321_4 .. "LipSync"] = var_321_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_321_9 = 0

			if var_321_9 < arg_318_1.time_ and arg_318_1.time_ <= var_321_9 + arg_321_0 then
				arg_318_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_321_10 = "1148ui_story"

			if arg_318_1.actors_[var_321_10] == nil then
				local var_321_11 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_321_11) then
					local var_321_12 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_318_1.stage_.transform)

					var_321_12.name = var_321_10
					var_321_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_318_1.actors_[var_321_10] = var_321_12

					local var_321_13 = var_321_12:GetComponentInChildren(typeof(CharacterEffect))

					var_321_13.enabled = true

					local var_321_14 = GameObjectTools.GetOrAddComponent(var_321_12, typeof(DynamicBoneHelper))

					if var_321_14 then
						var_321_14:EnableDynamicBone(false)
					end

					arg_318_1:ShowWeapon(var_321_13.transform, false)

					arg_318_1.var_[var_321_10 .. "Animator"] = var_321_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_318_1.var_[var_321_10 .. "Animator"].applyRootMotion = true
					arg_318_1.var_[var_321_10 .. "LipSync"] = var_321_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_321_15 = 0

			if var_321_15 < arg_318_1.time_ and arg_318_1.time_ <= var_321_15 + arg_321_0 then
				arg_318_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_321_16 = 0
			local var_321_17 = 0.5

			if var_321_16 < arg_318_1.time_ and arg_318_1.time_ <= var_321_16 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_18 = arg_318_1:FormatText(StoryNameCfg[8].name)

				arg_318_1.leftNameTxt_.text = var_321_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_19 = arg_318_1:GetWordFromCfg(112191035)
				local var_321_20 = arg_318_1:FormatText(var_321_19.content)

				arg_318_1.text_.text = var_321_20

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_21 = 20
				local var_321_22 = utf8.len(var_321_20)
				local var_321_23 = var_321_21 <= 0 and var_321_17 or var_321_17 * (var_321_22 / var_321_21)

				if var_321_23 > 0 and var_321_17 < var_321_23 then
					arg_318_1.talkMaxDuration = var_321_23

					if var_321_23 + var_321_16 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_23 + var_321_16
					end
				end

				arg_318_1.text_.text = var_321_20
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191035", "story_v_out_112191.awb") ~= 0 then
					local var_321_24 = manager.audio:GetVoiceLength("story_v_out_112191", "112191035", "story_v_out_112191.awb") / 1000

					if var_321_24 + var_321_16 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_24 + var_321_16
					end

					if var_321_19.prefab_name ~= "" and arg_318_1.actors_[var_321_19.prefab_name] ~= nil then
						local var_321_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_19.prefab_name].transform, "story_v_out_112191", "112191035", "story_v_out_112191.awb")

						arg_318_1:RecordAudio("112191035", var_321_25)
						arg_318_1:RecordAudio("112191035", var_321_25)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_112191", "112191035", "story_v_out_112191.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_112191", "112191035", "story_v_out_112191.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_26 = math.max(var_321_17, arg_318_1.talkMaxDuration)

			if var_321_16 <= arg_318_1.time_ and arg_318_1.time_ < var_321_16 + var_321_26 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_16) / var_321_26

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_16 + var_321_26 and arg_318_1.time_ < var_321_16 + var_321_26 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play112191036 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 112191036
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play112191037(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["1148ui_story"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect1148ui_story == nil then
				arg_322_1.var_.characterEffect1148ui_story = var_325_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.2

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.characterEffect1148ui_story and not isNil(var_325_0) then
					local var_325_4 = Mathf.Lerp(0, 0.5, var_325_3)

					arg_322_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1148ui_story.fillRatio = var_325_4
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect1148ui_story then
				local var_325_5 = 0.5

				arg_322_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1148ui_story.fillRatio = var_325_5
			end

			local var_325_6 = 0
			local var_325_7 = 0.475

			if var_325_6 < arg_322_1.time_ and arg_322_1.time_ <= var_325_6 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_8 = arg_322_1:FormatText(StoryNameCfg[7].name)

				arg_322_1.leftNameTxt_.text = var_325_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_9 = arg_322_1:GetWordFromCfg(112191036)
				local var_325_10 = arg_322_1:FormatText(var_325_9.content)

				arg_322_1.text_.text = var_325_10

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_11 = 19
				local var_325_12 = utf8.len(var_325_10)
				local var_325_13 = var_325_11 <= 0 and var_325_7 or var_325_7 * (var_325_12 / var_325_11)

				if var_325_13 > 0 and var_325_7 < var_325_13 then
					arg_322_1.talkMaxDuration = var_325_13

					if var_325_13 + var_325_6 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_13 + var_325_6
					end
				end

				arg_322_1.text_.text = var_325_10
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_14 = math.max(var_325_7, arg_322_1.talkMaxDuration)

			if var_325_6 <= arg_322_1.time_ and arg_322_1.time_ < var_325_6 + var_325_14 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_6) / var_325_14

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_6 + var_325_14 and arg_322_1.time_ < var_325_6 + var_325_14 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play112191037 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 112191037
		arg_326_1.duration_ = 10.87

		local var_326_0 = {
			ja = 10.866,
			ko = 7.433,
			zh = 6.2,
			en = 8.1
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play112191038(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["1148ui_story"]
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.characterEffect1148ui_story == nil then
				arg_326_1.var_.characterEffect1148ui_story = var_329_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.2

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 and not isNil(var_329_0) then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2

				if arg_326_1.var_.characterEffect1148ui_story and not isNil(var_329_0) then
					arg_326_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.characterEffect1148ui_story then
				arg_326_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_329_4 = 0

			if var_329_4 < arg_326_1.time_ and arg_326_1.time_ <= var_329_4 + arg_329_0 then
				arg_326_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action454")
			end

			local var_329_5 = 0

			if var_329_5 < arg_326_1.time_ and arg_326_1.time_ <= var_329_5 + arg_329_0 then
				arg_326_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_329_6 = 0
			local var_329_7 = 0.65

			if var_329_6 < arg_326_1.time_ and arg_326_1.time_ <= var_329_6 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_8 = arg_326_1:FormatText(StoryNameCfg[8].name)

				arg_326_1.leftNameTxt_.text = var_329_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_9 = arg_326_1:GetWordFromCfg(112191037)
				local var_329_10 = arg_326_1:FormatText(var_329_9.content)

				arg_326_1.text_.text = var_329_10

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_11 = 26
				local var_329_12 = utf8.len(var_329_10)
				local var_329_13 = var_329_11 <= 0 and var_329_7 or var_329_7 * (var_329_12 / var_329_11)

				if var_329_13 > 0 and var_329_7 < var_329_13 then
					arg_326_1.talkMaxDuration = var_329_13

					if var_329_13 + var_329_6 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_13 + var_329_6
					end
				end

				arg_326_1.text_.text = var_329_10
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112191", "112191037", "story_v_out_112191.awb") ~= 0 then
					local var_329_14 = manager.audio:GetVoiceLength("story_v_out_112191", "112191037", "story_v_out_112191.awb") / 1000

					if var_329_14 + var_329_6 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_14 + var_329_6
					end

					if var_329_9.prefab_name ~= "" and arg_326_1.actors_[var_329_9.prefab_name] ~= nil then
						local var_329_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_9.prefab_name].transform, "story_v_out_112191", "112191037", "story_v_out_112191.awb")

						arg_326_1:RecordAudio("112191037", var_329_15)
						arg_326_1:RecordAudio("112191037", var_329_15)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_112191", "112191037", "story_v_out_112191.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_112191", "112191037", "story_v_out_112191.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_16 = math.max(var_329_7, arg_326_1.talkMaxDuration)

			if var_329_6 <= arg_326_1.time_ and arg_326_1.time_ < var_329_6 + var_329_16 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_6) / var_329_16

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_6 + var_329_16 and arg_326_1.time_ < var_329_6 + var_329_16 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H01a",
		"TextureConfig/Background/H02"
	},
	voices = {
		"story_v_out_112191.awb"
	}
}
